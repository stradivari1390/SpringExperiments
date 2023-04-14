package com.example.my_book_shop_app.security;

import com.example.my_book_shop_app.security.jwt.TokenBlacklistService;
import com.example.my_book_shop_app.security.twilio.SMSService;
import com.example.my_book_shop_app.services.BookService;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AuthUserController {

    private final BookstoreUserRegister userRegister;
    private final BookstoreUserDetailsService bookstoreUserDetailsService;
    private final BookService bookService;
    private final TokenBlacklistService tokenBlacklistService;
    private final SMSService smsService;
    private final BookstoreUserRegister bookstoreUserRegister;

    @Autowired
    public AuthUserController(BookstoreUserRegister userRegister,
                              BookstoreUserDetailsService bookstoreUserDetailsService, BookService bookService,
                              TokenBlacklistService tokenBlacklistService, SMSService smsService,
                              BookstoreUserRegister bookstoreUserRegister) {
        this.userRegister = userRegister;
        this.bookstoreUserDetailsService = bookstoreUserDetailsService;
        this.bookService = bookService;
        this.bookstoreUserRegister = bookstoreUserRegister;
        this.tokenBlacklistService = tokenBlacklistService;
        this.smsService = smsService;
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
            smsService.handleSmsSend(payload);
        }
        return response;
    }

    @PostMapping("/approveContact")
    @ResponseBody
    public ContactConfirmationResponse handleApproveContact(@RequestBody ContactConfirmationPayload payload) {
        return userRegister.approveContact(payload);
    }

    @PostMapping("/reg")
    public String handleUserRegistration(RegistrationForm registrationForm, Model model, Authentication authentication) {
        userRegister.registerNewUser(registrationForm);
        model.addAttribute("regOk", true);
        return handleSignIn(model, authentication);
    }

    @GetMapping("/my")
    public String handleMy(Model model) {
        model.addAttribute("authStatus", "authorized");
        model.addAttribute("curUsr", bookstoreUserDetailsService.getUserDtoById(userRegister.getCurrentUser().getId()));
        model.addAttribute("booksList", bookService.getUsersBooks(userRegister.getCurrentUser().getId()));
        return "my";
    }

    @GetMapping("/profile")
    public String handleProfile(Model model) {
        model.addAttribute("authStatus", "authorized");
        model.addAttribute("curUsr", bookstoreUserDetailsService.getUserDtoById(userRegister.getCurrentUser().getId()));
        return "profile";
    }

    @PostMapping("/login")
    public String createAuthenticationToken(@RequestBody ContactConfirmationPayload payload,
                                            HttpServletResponse httpServletResponse) throws Exception {
        bookstoreUserRegister.jwtTokenLogin(payload, httpServletResponse);
        return "redirect:/my";
    }

    @GetMapping("/logout")
    public String handleLogout(HttpServletRequest request, HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
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
