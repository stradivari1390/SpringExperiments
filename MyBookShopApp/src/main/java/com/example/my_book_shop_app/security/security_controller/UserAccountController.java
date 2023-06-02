package com.example.my_book_shop_app.security.security_controller;

import com.example.my_book_shop_app.dto.BalanceTransactionDto;
import com.example.my_book_shop_app.exceptions.NoUserFoundException;
import com.example.my_book_shop_app.security.security_services.*;

import jakarta.servlet.http.HttpServletRequest;

import lombok.RequiredArgsConstructor;

import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class UserAccountController {

    private final ProfileService profileService;
    private final BookstoreUserDetailsService bookstoreUserDetailsService;
    private final UserAccountService userAccountService;
    private final PaymentService paymentService;
    private final AuthenticationService authenticationService;
    private final AuthController authController;

    @GetMapping("/my")
    public String handleMy(Model model) {
        model.addAttribute("authStatus", "authorized");
        model.addAttribute("curUsr",
                bookstoreUserDetailsService.getUserDtoById(authenticationService.getCurrentUser().getId()));
        return "my";
    }

    @GetMapping("/profile")
    public String handleProfile(Model model) {
        model.addAttribute("authStatus", "authorized");
        model.addAttribute("curUsr",
                bookstoreUserDetailsService.getUserDtoById(authenticationService.getCurrentUser().getId()));
        return "profile";
    }

    @GetMapping("/transactions")
    public ResponseEntity<List<BalanceTransactionDto>> getTransactions(
            @RequestParam(defaultValue = "0") int offset, @RequestParam(defaultValue = "10") int limit) {
        Page<BalanceTransactionDto> transactions = paymentService.getBalanceTransactionDtos(offset, limit);
        return ResponseEntity.ok(transactions.getContent());
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
            userAccountService.createPasswordResetToken(email);
            model.addAttribute("emailSent", true);
        } catch (NoUserFoundException e) {
            model.addAttribute("emailSent", false);
        }
        return handleRecoverPassword(model, authentication);
    }

    @GetMapping("/reset-password")
    public String handleResetPassword(@RequestParam("token") String token, Model model) {
        model.addAttribute("resetToken", userAccountService.getPasswordResetToken(token));
        return "reset-password";
    }

    @PostMapping("/reset-password")
    public String handleResetPasswordSubmit(@RequestParam("password") String password,
                                            @RequestParam("token") String token,
                                            Model model, Authentication authentication) {
        userAccountService.resetPassword(password, token, model);
        return authController.handleSignIn(model, authentication);
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
        profileService.updateProfile(name, email, phone, password, passwordReply);
        redirectAttributes.addFlashAttribute("profileUpdateSuccess", "Profile updated successfully");
        return "redirect:/profile";
    }

    @GetMapping("/confirm-update")
    public String confirmUpdate(@RequestParam("token") String token, RedirectAttributes redirectAttributes) {
        return profileService.confirmProfileUpdate(token, redirectAttributes);
    }

    @PostMapping("/topup")
    public String handleTopup(@RequestParam("sum") String sum) {
        String redirectUrl = paymentService.topupWithPayPal(sum);
        return "redirect:" + redirectUrl;
    }

    @GetMapping("/execute-payment")
    public String executePayment(HttpServletRequest request) {
        paymentService.executePayPalPayment(request);
        return "redirect:/profile";
    }

    @GetMapping("/cancel-payment")
    public String cancelPayment() {
        return "redirect:/profile";
    }
}
