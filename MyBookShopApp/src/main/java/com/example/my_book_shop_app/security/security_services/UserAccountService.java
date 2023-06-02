package com.example.my_book_shop_app.security.security_services;

import com.example.my_book_shop_app.data.model.user.PasswordResetToken;
import com.example.my_book_shop_app.data.model.user.UserEntity;
import com.example.my_book_shop_app.data.repositories.PasswordResetTokenRepository;
import com.example.my_book_shop_app.data.repositories.UserEntityRepository;
import com.example.my_book_shop_app.exceptions.InvalidResetTokenException;
import com.example.my_book_shop_app.exceptions.NoUserFoundException;

import lombok.RequiredArgsConstructor;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class UserAccountService {

    private final UserEntityRepository userEntityRepository;
    private final PasswordResetTokenRepository passwordResetTokenRepository;
    private final EmailService emailService;
    private final PasswordEncoder passwordEncoder;

    public void createPasswordResetToken(String email) {
        UserEntity user = userEntityRepository.findUserByUsername(email)
                .orElseThrow(() -> new NoUserFoundException("User not found with email: " + email));
        String token = UUID.randomUUID().toString();
        PasswordResetToken resetToken = new PasswordResetToken(token, user);
        passwordResetTokenRepository.save(resetToken);
        emailService.sendPasswordResetEmail(email, token);
    }

    public PasswordResetToken getPasswordResetToken(String token) {
        return passwordResetTokenRepository.findByToken(token)
                .orElseThrow(() -> new InvalidResetTokenException("Invalid reset token: " + token));
    }

    @Transactional
    public void resetPassword(String password, String token, Model model) {
        PasswordResetToken resetToken = passwordResetTokenRepository.findByToken(token)
                .orElseThrow(() -> new InvalidResetTokenException("Invalid reset token: " + token));
        UserEntity user = resetToken.getUser();
        user.setPassword(passwordEncoder.encode(password));
        userEntityRepository.save(user);
        passwordResetTokenRepository.delete(resetToken);
        model.addAttribute("passwordReset", true);
    }
}
