package com.example.my_book_shop_app.security.security_controller;

import ch.qos.logback.classic.Logger;

import com.example.my_book_shop_app.security.security_services.*;
import lombok.RequiredArgsConstructor;
import org.slf4j.LoggerFactory;

import com.example.my_book_shop_app.security.security_dto.ContactConfirmationPayload;
import com.example.my_book_shop_app.security.security_dto.ContactConfirmationResponse;
import com.example.my_book_shop_app.security.security_dto.RegistrationForm;
import com.example.my_book_shop_app.services.CartService;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class AuthController {

    private final BookstoreUserRegister userRegister;
    private final BookstoreUserDetailsService bookstoreUserDetailsService;
    private final TokenBlacklistService tokenBlacklistService;
    private final TwilioService twilioService;
    private final EmailService emailService;
    private final CartService cartService;
    private final AuthenticationService authenticationService;
    private final ContactApprovalService contactApprovalService;
    private final Logger log = (Logger) LoggerFactory.getLogger(getClass());

    @GetMapping("/signin")
    public String handleSignIn(Model model, Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated()) {
            model.addAttribute("authStatus", "authorized");
            model.addAttribute("curUsr",
                    bookstoreUserDetailsService.getUserDtoById(authenticationService.getCurrentUser().getId()));
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

    @PostMapping("/login")
    public ResponseEntity<?> createAuthenticationToken(@RequestBody ContactConfirmationPayload payload,
                                                       HttpServletResponse httpServletResponse,
                                                       HttpServletRequest httpServletRequest,
                                                       Authentication authentication) {
        authenticationService.jwtTokenLogin(payload, httpServletResponse);
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

    @PostMapping("/requestContactConfirmation")
    @ResponseBody
    public ContactConfirmationResponse handleRequestContactConfirmation(@RequestBody ContactConfirmationPayload payload) {
        ContactConfirmationResponse response = authenticationService.requestContactConfirmation(payload);
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
        return contactApprovalService.approveContact(payload);
    }

    @PostMapping("/reg")
    public String handleUserRegistration(@RequestBody RegistrationForm registrationForm,
                                         Model model, Authentication authentication) {
        userRegister.registerNewUser(registrationForm);
        model.addAttribute("regOk", true);
        return handleSignIn(model, authentication);
    }
}
