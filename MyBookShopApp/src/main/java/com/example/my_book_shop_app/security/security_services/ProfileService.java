package com.example.my_book_shop_app.security.security_services;

import com.example.my_book_shop_app.data.model.enums.ContactType;
import com.example.my_book_shop_app.data.model.user.ConfirmationEmailToken;
import com.example.my_book_shop_app.data.model.user.UserContactEntity;
import com.example.my_book_shop_app.data.model.user.UserEntity;
import com.example.my_book_shop_app.data.repositories.ConfirmationEmailTokenRepository;
import com.example.my_book_shop_app.data.repositories.UserContactEntityRepository;
import com.example.my_book_shop_app.data.repositories.UserEntityRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ProfileService {

    private final PasswordEncoder passwordEncoder;
    private final AuthenticationService authenticationService;
    private final ConfirmationEmailTokenRepository confirmationEmailTokenRepository;
    private final EmailService emailService;
    private final UserEntityRepository userEntityRepository;
    private final UserContactEntityRepository userContactEntityRepository;

    @Transactional
    public void updateProfile(String name, String email, String phone, String password, String passwordReply) {
        if (!password.equals(passwordReply)) {
            throw new IllegalArgumentException("Passwords do not match");
        }

        UserEntity userEntity = authenticationService.getCurrentUser();
        String token = UUID.randomUUID().toString();

        ConfirmationEmailToken emailToken = new ConfirmationEmailToken();
        emailToken.setToken(token);
        emailToken.setUser(userEntity);
        emailToken.setExpiryDate(LocalDateTime.now().plusMinutes(30));

        emailToken.setName(name);
        emailToken.setEmail(email);
        emailToken.setPhone(phone);
        emailToken.setPassword(passwordEncoder.encode(password));

        confirmationEmailTokenRepository.save(emailToken);

        emailService.sendConfirmationEmail(email, token);
    }

    @Transactional
    public String confirmProfileUpdate(String token, RedirectAttributes redirectAttributes) {
        ConfirmationEmailToken emailToken = confirmationEmailTokenRepository.findByToken(token);

        if (emailToken == null || emailToken.isExpired()) {
            redirectAttributes.addFlashAttribute("token", "expired");
            return "redirect:/profile";
        } else {
            UserEntity userEntity = emailToken.getUser();

            if (emailToken.getName() != null) {
                userEntity.setName(emailToken.getName());
            }
            if (emailToken.getPhone() != null) {
                UserContactEntity phoneEntity = userContactEntityRepository
                        .findByUserIdAndType(userEntity.getId(), ContactType.PHONE).orElse(new UserContactEntity());
                phoneEntity.setContact(emailToken.getPhone());
                userContactEntityRepository.save(phoneEntity);
            }
            if (emailToken.getPassword() != null) {
                userEntity.setPassword(emailToken.getPassword());
            }

            userEntityRepository.save(userEntity);

            confirmationEmailTokenRepository.delete(emailToken);
        }
        return "redirect:/profile";
    }
}
