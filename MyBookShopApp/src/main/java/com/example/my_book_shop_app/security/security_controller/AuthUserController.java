package com.example.my_book_shop_app.security.security_controller;

import ch.qos.logback.classic.Logger;
import com.example.my_book_shop_app.security.security_dto.ContactConfirmationPayload;
import com.example.my_book_shop_app.security.security_dto.ContactConfirmationResponse;
import com.example.my_book_shop_app.security.security_dto.RegistrationForm;
import com.example.my_book_shop_app.security.security_services.*;

import com.example.my_book_shop_app.services.CartService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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
}
