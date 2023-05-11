package com.example.my_book_shop_app.security.security_controller;

import ch.qos.logback.classic.Logger;

import org.slf4j.LoggerFactory;

import com.example.my_book_shop_app.exceptions.NoUserFoundException;
import com.example.my_book_shop_app.security.security_dto.ContactConfirmationPayload;
import com.example.my_book_shop_app.security.security_dto.ContactConfirmationResponse;
import com.example.my_book_shop_app.security.security_dto.RegistrationForm;
import com.example.my_book_shop_app.security.security_services.BookstoreUserDetailsService;
import com.example.my_book_shop_app.security.security_services.BookstoreUserRegister;
import com.example.my_book_shop_app.security.security_services.EmailService;
import com.example.my_book_shop_app.security.security_services.TokenBlacklistService;
import com.example.my_book_shop_app.security.security_services.TwilioService;
import com.example.my_book_shop_app.services.CartService;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.Map;

@Controller
public class AuthUserController {

    private final BookstoreUserRegister userRegister;
    private final BookstoreUserDetailsService bookstoreUserDetailsService;
    private final TokenBlacklistService tokenBlacklistService;
    private final TwilioService twilioService;
    private final BookstoreUserRegister bookstoreUserRegister;
    private final EmailService emailService;
    private final CartService cartService;
    private final Logger log = (Logger) LoggerFactory.getLogger(getClass());

    @Autowired
    public AuthUserController(BookstoreUserRegister userRegister,
                              BookstoreUserDetailsService bookstoreUserDetailsService,
                              TokenBlacklistService tokenBlacklistService, TwilioService twilioService,
                              BookstoreUserRegister bookstoreUserRegister, EmailService emailService,
                              CartService cartService) {
        this.userRegister = userRegister;
        this.bookstoreUserDetailsService = bookstoreUserDetailsService;
        this.bookstoreUserRegister = bookstoreUserRegister;
        this.tokenBlacklistService = tokenBlacklistService;
        this.twilioService = twilioService;
        this.emailService = emailService;
        this.cartService = cartService;
    }

    @GetMapping("/signin")
    public String handleSignIn(Model model, Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated()) {
            model.addAttribute("authStatus", "authorized");
            model.addAttribute("curUsr", bookstoreUserDetailsService.getUserDtoById(userRegister.getCurrentUser().getId()));
        } else {
            model.addAttribute("authStatus", "unauthorized");
        }
        return "signin";
    }

    @GetMapping("/signup")
    public String handleSignUp(Model model, Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated()) {
            model.addAttribute("authStatus", "authorized");
        } else {
            model.addAttribute("authStatus", "unauthorized");
        }
        model.addAttribute("regForm", new RegistrationForm());
        return "signup";
    }

    @PostMapping("/requestContactConfirmation")
    @ResponseBody
    public ContactConfirmationResponse handleRequestContactConfirmation(@RequestBody ContactConfirmationPayload payload) {
        ContactConfirmationResponse response = userRegister.requestContactConfirmation(payload);
        if (response.getResult().equals("true") && !payload.getContact().contains("@")) {
            twilioService.handleSmsSend(payload);
        } else if (response.getResult().equals("true") && payload.getContact().contains("@")) {
            emailService.handleEmailSend(payload);
        }
        return response;
    }

    @PostMapping("/approveContact")
    @ResponseBody
    public ContactConfirmationResponse handleApproveContact(@RequestBody ContactConfirmationPayload payload) {
        return userRegister.approveContact(payload);
    }

    @PostMapping("/reg")
    public String handleUserRegistration(@RequestBody RegistrationForm registrationForm, Model model, Authentication authentication) {
        userRegister.registerNewUser(registrationForm);
        model.addAttribute("regOk", true);
        return handleSignIn(model, authentication);
    }

    @GetMapping("/my")
    public String handleMy(Model model) {
        model.addAttribute("authStatus", "authorized");
        model.addAttribute("curUsr", bookstoreUserDetailsService.getUserDtoById(userRegister.getCurrentUser().getId()));
        return "my";
    }

    @GetMapping("/profile")
    public String handleProfile(Model model) {
        model.addAttribute("authStatus", "authorized");
        model.addAttribute("curUsr", bookstoreUserDetailsService.getUserDtoById(userRegister.getCurrentUser().getId()));
        return "profile";
    }

    @PostMapping("/login")
    public ResponseEntity<?> createAuthenticationToken(@RequestBody ContactConfirmationPayload payload,
                                                       HttpServletResponse httpServletResponse,
                                                       HttpServletRequest httpServletRequest,
                                                       Authentication authentication) {
        bookstoreUserRegister.jwtTokenLogin(payload, httpServletResponse);
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("redirect", "/my");
        if (authentication == null) {
            authentication = SecurityContextHolder.getContext().getAuthentication();
        }
        log.info("Authentication after login: {}", authentication);
        if(authentication.isAuthenticated()) {
            cartService.putCookieBooksToDB(
                    cartService.getCookieContents("cartContents", httpServletRequest),
                    "in_cart"
            );
            cartService.putCookieBooksToDB(
                    cartService.getCookieContents("postponedContents", httpServletRequest),
                    "postponed"
            );
        }
        return ResponseEntity.ok(response);
    }

    @PostMapping("/logout")
    public String handleLogout(HttpServletRequest request, HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        log.info("Authentication before logout: {}", auth);
        if (auth != null) {
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("token")) {
                        tokenBlacklistService.addToBlacklist(cookie.getValue());
                        cookie.setMaxAge(0);
                        response.addCookie(cookie);
                        break;
                    }
                }
            }
        }
        SecurityContextHolder.clearContext();
        return "redirect:/signin";
    }

    @GetMapping("/recover-password")
    public String handleRecoverPassword(Model model, Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated()) {
            model.addAttribute("authStatus", "authorized");
        } else {
            model.addAttribute("authStatus", "unauthorized");
        }
        return "recover-password";
    }

    @PostMapping("/recover-password")
    public String handleRecoverPasswordSubmit(@RequestParam("email") String email, Model model, Authentication authentication) {
        try {
            bookstoreUserDetailsService.createPasswordResetToken(email);
            model.addAttribute("emailSent", true);
        } catch (NoUserFoundException e) {
            model.addAttribute("emailSent", false);
        }
        return handleRecoverPassword(model, authentication);
    }

    @GetMapping("/reset-password")
    public String handleResetPassword(@RequestParam("token") String token, Model model) {
        model.addAttribute("resetToken", bookstoreUserDetailsService.getPasswordResetToken(token));
        return "reset-password";
    }

    @PostMapping("/reset-password")
    public String handleResetPasswordSubmit(@RequestParam("password") String password,
                                            @RequestParam("token") String token,
                                            Model model, Authentication authentication) {
        bookstoreUserDetailsService.resetPassword(password, token, model);
        return handleSignIn(model, authentication);
    }

    @PostMapping("/updateProfile")
    public String updateUserProfile(@RequestParam("name") String name,
                                    @RequestParam("mail") String email,
                                    @RequestParam("phone") String phone,
                                    @RequestParam("password") String password,
                                    @RequestParam("passwordReply") String passwordReply,
                                    RedirectAttributes redirectAttributes) {
        if (!password.equals(passwordReply)) {
            redirectAttributes.addFlashAttribute("passwordError", "Passwords do not match");
            return "redirect:/profile";
        }
        bookstoreUserRegister.updateProfile(name, email, phone, password);
        redirectAttributes.addFlashAttribute("profileUpdateSuccess", "Profile updated successfully");
        return "redirect:/profile";
    }

    @PostMapping("/topup")
    public String handleTopup(@RequestParam("sum") String sum) {

        String redirectUrl = bookstoreUserRegister.topupWithPayPal(sum);

        return "redirect:" + redirectUrl;
    }

    @GetMapping("/execute-payment")
    public String executePayment(HttpServletRequest request) {
        bookstoreUserRegister.executePayPalPayment(request);
        return "redirect:/profile";
    }

    @GetMapping("/cancel-payment")
    public String cancelPayment() {
        return "redirect:/profile";
    }
}
