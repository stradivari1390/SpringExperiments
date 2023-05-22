package com.example.my_book_shop_app.security.security_services;

import com.example.my_book_shop_app.data.repositories.UserEntityRepository;
import com.example.my_book_shop_app.exceptions.EmailAuthorizationException;
import com.example.my_book_shop_app.security.security_dto.ContactConfirmationPayload;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Lazy;
import org.springframework.mail.MailAuthenticationException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Value("${app.base-url}")
    private String baseUrl;

    @Value("${spring.mail.username}")
    private String emailFrom;

    BookstoreUserDetailsService bookstoreUserDetailsService;
    UserEntityRepository userEntityRepository;
    private final JavaMailSender javaMailSender;

    @Autowired
    public EmailService(@Lazy BookstoreUserDetailsService bookstoreUserDetailsService,
                        UserEntityRepository userEntityRepository,
                        JavaMailSender javaMailSender) {
        this.bookstoreUserDetailsService = bookstoreUserDetailsService;
        this.userEntityRepository = userEntityRepository;
        this.javaMailSender = javaMailSender;
    }

    public void handleEmailSend(ContactConfirmationPayload payload) {
        String email = payload.getContact();
        String code = bookstoreUserDetailsService.createSmsOrEmailCode(email);
        String subject = "Verification Code";
        String message = "Your verification code is: " + code;

        sendEmail(email, subject, message);
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