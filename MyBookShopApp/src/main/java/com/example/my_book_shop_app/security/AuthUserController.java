package com.example.my_book_shop_app.security;

import com.example.my_book_shop_app.security.jwt.JWTUtil;
import com.example.my_book_shop_app.security.jwt.JwtResponse;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class AuthUserController {

    private final BookstoreUserRegister userRegister;
    private final BookstoreUserDetailsService bookstoreUserDetailsService;
    private final AuthenticationManager authenticationManager;
    private final JWTUtil jwtTokenUtil;

    @Autowired
    public AuthUserController(BookstoreUserRegister userRegister,
                              BookstoreUserDetailsService bookstoreUserDetailsService,
                              AuthenticationManager authenticationManager, JWTUtil jwtTokenUtil) {
        this.userRegister = userRegister;
        this.bookstoreUserDetailsService = bookstoreUserDetailsService;
        this.authenticationManager = authenticationManager;
        this.jwtTokenUtil = jwtTokenUtil;
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
        return userRegister.requestContactConfirmation(payload);
    }

    @PostMapping("/approveContact")
    @ResponseBody
    public ContactConfirmationResponse handleApproveContact(@RequestBody ContactConfirmationPayload payload) {
        return userRegister.approveContact(payload);
    }

    @PostMapping("/reg")
    public String handleUserRegistration(RegistrationForm registrationForm, Model model, Authentication authentication) {
        userRegister.registerNewUser(registrationForm);
        if (authentication != null && authentication.isAuthenticated()) {
            model.addAttribute("authStatus", "authorized");
        } else {
            model.addAttribute("authStatus", "unauthorized");
        }
        model.addAttribute("regOk", true);
        return "signin";
    }

    @PostMapping("/oauth2/authorization/github")
    @ResponseBody
    public ContactConfirmationResponse handleOauth(@RequestBody ContactConfirmationPayload payload,
                                                   HttpServletResponse httpServletResponse) {
        ContactConfirmationResponse loginResponse = userRegister.jwtLogin(payload);
        Cookie cookie = new Cookie("token", loginResponse.getResult());
        httpServletResponse.addCookie(cookie);
        return loginResponse;
    }

    @GetMapping("/my")
    public String handleMy(@CookieValue("postponedContents") String postponedContents,
                           Model model) {
        model.addAttribute("curUsr", bookstoreUserDetailsService.getUserDtoById(userRegister.getCurrentUser().getId()));
        model.addAttribute(postponedContents);
        return "my";
    }

    @GetMapping("/myArchive")
    public String handleMyArchive(@CookieValue("archiveContents") String archiveContents,
                                  Model model) {
        model.addAttribute("curUsr", bookstoreUserDetailsService.getUserDtoById(userRegister.getCurrentUser().getId()));
        model.addAttribute(archiveContents);
        return "myarchive";
    }

    @GetMapping("/profile")
    public String handleProfile(Model model) {
        model.addAttribute("curUsr", bookstoreUserDetailsService.getUserDtoById(userRegister.getCurrentUser().getId()));
        return "profile";
    }

    @PostMapping("/login")
    public ResponseEntity<JwtResponse> createAuthenticationToken(@RequestBody ContactConfirmationPayload payload,
                                                                 HttpServletResponse httpServletResponse) throws Exception {
        authenticate(payload.getContact(), payload.getCode());
        final UserDetails userDetails = bookstoreUserDetailsService.loadUserByUsername(payload.getContact());
        final String token = jwtTokenUtil.generateToken(userDetails);
        Cookie cookie = new Cookie("token", token);
        httpServletResponse.addCookie(cookie);
        return ResponseEntity.ok(new JwtResponse(token));
    }

    private void authenticate(String username, String password) throws Exception {
        try {
            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(username, password));
        } catch (DisabledException e) {
            throw new Exception("USER_DISABLED", e);
        } catch (BadCredentialsException e) {
            throw new Exception("INVALID_CREDENTIALS", e);
        }
    }
}
