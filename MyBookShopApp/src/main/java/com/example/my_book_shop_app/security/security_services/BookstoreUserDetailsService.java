package com.example.my_book_shop_app.security.security_services;

import com.example.my_book_shop_app.data.model.enums.ContactType;
import com.example.my_book_shop_app.data.model.user.PasswordResetToken;
import com.example.my_book_shop_app.data.model.user.UserContactEntity;
import com.example.my_book_shop_app.data.model.user.UserEntity;
import com.example.my_book_shop_app.data.repositories.BookRepository;
import com.example.my_book_shop_app.data.repositories.PasswordResetTokenRepository;
import com.example.my_book_shop_app.data.repositories.UserContactEntityRepository;
import com.example.my_book_shop_app.data.repositories.UserEntityRepository;
import com.example.my_book_shop_app.dto.UserDto;

import com.example.my_book_shop_app.exceptions.InvalidResetTokenException;
import com.example.my_book_shop_app.exceptions.NoUserFoundException;
import com.example.my_book_shop_app.security.BookstoreUserDetails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.time.LocalDateTime;
import java.util.Random;
import java.util.UUID;

@Service
public class BookstoreUserDetailsService implements UserDetailsService {

    private final UserEntityRepository userEntityRepository;
    private final UserContactEntityRepository userContactEntityRepository;
    private final Random random = new Random();
    private final BookRepository bookRepository;
    private final PasswordResetTokenRepository passwordResetTokenRepository;
    private final EmailService emailService;
    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    @Autowired
    public BookstoreUserDetailsService(UserEntityRepository userEntityRepository,
                                       UserContactEntityRepository userContactEntityRepository,
                                       BookRepository bookRepository,
                                       PasswordResetTokenRepository passwordResetTokenRepository, EmailService emailService) {
        this.userEntityRepository = userEntityRepository;
        this.userContactEntityRepository = userContactEntityRepository;
        this.bookRepository = bookRepository;
        this.passwordResetTokenRepository = passwordResetTokenRepository;
        this.emailService = emailService;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UserEntity bookstoreUser = userEntityRepository.findUserByUsername(username)
                .orElseThrow(() -> new NoUserFoundException("User not found with username: " + username));
        return new BookstoreUserDetails(bookstoreUser);
    }

    public UserDto getUserDtoById(Long id) {
        UserDto user = userEntityRepository.findUserDtoById(id)
                .orElseThrow(() -> new NoUserFoundException("User not found with id: " + id));
        user.setPostponedBooks(bookRepository.findAllBooksDtoByUserIdAndRelation(user.getId(), "postponed"));
        user.setCartBooks(bookRepository.findAllBooksDtoByUserIdAndRelation(user.getId(), "in_cart"));
        user.setPurchasedBooks(bookRepository.findAllBooksDtoByUserIdAndRelation(user.getId(), "purchased"));
        user.setArchivedBooks(bookRepository.findAllBooksDtoByUserIdAndRelation(user.getId(), "archived"));
        return user;
    }

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
