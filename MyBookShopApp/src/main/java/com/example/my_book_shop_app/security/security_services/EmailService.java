package com.example.my_book_shop_app.security.security_services;

import com.example.my_book_shop_app.data.model.enums.ContactType;
import com.example.my_book_shop_app.data.model.user.UserContactEntity;
import com.example.my_book_shop_app.data.repositories.UserContactEntityRepository;
import com.example.my_book_shop_app.exceptions.EmailAuthorizationException;
import com.example.my_book_shop_app.security.security_dto.ContactConfirmationPayload;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailAuthenticationException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Random;

@Service
@RequiredArgsConstructor
public class EmailService {

    @Value("${app.base-url}")
    private String baseUrl;
    @Value("${spring.mail.username}")
    private String emailFrom;
    private final Random random = new Random();
    private final UserContactEntityRepository userContactEntityRepository;
    private final JavaMailSender javaMailSender;

    @Transactional
    public void handleEmailSend(ContactConfirmationPayload payload) {
        String email = payload.getContact();
        String code = createSmsOrEmailCode(email);
        String subject = "Verification Code";
        String message = "Your verification code is: " + code;

        sendEmail(email, subject, message);
    }

    @Transactional
    public String createSmsOrEmailCode(String contact) {
        String code = String.format("%06d", random.nextInt(1_000_000));
        UserContactEntity contactEntity = userContactEntityRepository.findByContact(contact).orElse(null);
        if(contactEntity == null) {
            contactEntity = new UserContactEntity();
            contactEntity.setUserId(-1L * Math.abs(contact.hashCode()));
            contactEntity.setContact(contact);
            contactEntity.setType(contact.contains("@") ? ContactType.EMAIL : ContactType.PHONE);
            contactEntity.setApproved((short) 0);
        }
        contactEntity.setCode(code);
        contactEntity.setCodeTime(LocalDateTime.now());
        contactEntity.setCodeTrails(0);
        userContactEntityRepository.save(contactEntity);
        return code;
    }

    private void sendEmail(String to, String subject, String messageText) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(emailFrom);
        message.setTo(to);
        message.setSubject(subject);
        message.setText(messageText);
        try {
            javaMailSender.send(message);
        } catch (MailAuthenticationException ex) {
            throw new EmailAuthorizationException("Email authorization failed");
        }
    }

    public void sendPasswordResetEmail(String to, String token) {
        String subject = "Password Reset";
        String messageText = "To reset your password, please click the following link: "
                + baseUrl + "/reset-password?token=" + token;
        try {
            sendEmail(to, subject, messageText);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public void sendConfirmationEmail(String to, String token) {
        String subject = "Confirm Profile Update";
        String messageText = "To confirm your profile update, please click the following link: "
                + baseUrl + "/confirm-update?token=" + token;
        sendEmail(to, subject, messageText);
    }
}