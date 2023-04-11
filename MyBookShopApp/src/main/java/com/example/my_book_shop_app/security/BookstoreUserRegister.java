package com.example.my_book_shop_app.security;

import com.example.my_book_shop_app.data.model.enums.ContactType;
import com.example.my_book_shop_app.data.model.user.UserContactEntity;
import com.example.my_book_shop_app.data.model.user.UserEntity;
import com.example.my_book_shop_app.data.repositories.UserContactEntityRepository;
import com.example.my_book_shop_app.data.repositories.UserEntityRepository;
import com.example.my_book_shop_app.security.jwt.JWTUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class BookstoreUserRegister {

    private final UserEntityRepository userEntityRepository;
    private final UserContactEntityRepository userContactEntityRepository;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationManager authenticationManager;
    private final BookstoreUserDetailsService bookstoreUserDetailsService;
    private final JWTUtil jwtUtil;

    @Autowired
    public BookstoreUserRegister(UserEntityRepository userEntityRepository, PasswordEncoder passwordEncoder,
                                 AuthenticationManager authenticationManager,
                                 BookstoreUserDetailsService bookstoreUserDetailsService, JWTUtil jwtUtil,
                                 UserContactEntityRepository userContactEntityRepository) {
        this.userEntityRepository = userEntityRepository;
        this.passwordEncoder = passwordEncoder;
        this.authenticationManager = authenticationManager;
        this.bookstoreUserDetailsService = bookstoreUserDetailsService;
        this.jwtUtil = jwtUtil;
        this.userContactEntityRepository = userContactEntityRepository;
    }

    public void registerNewUser(RegistrationForm registrationForm) {

        if (userEntityRepository.findByContacts(registrationForm.getEmail()) == null) {
            UserEntity user = new UserEntity();
            user.setName(registrationForm.getName());
            user.setUsername(registrationForm.getEmail());
            user.setPassword(passwordEncoder.encode(registrationForm.getPass()));
            user.setBalance(0D);
            user.setRegTime(LocalDateTime.now());
            user.setHash(String.valueOf(user.getUsername().hashCode()));
            userEntityRepository.save(user);

            List<UserContactEntity> contacts =
                    List.of(new UserContactEntity(user.getId(), ContactType.EMAIL, (short) 1, registrationForm.getEmail()),
                    new UserContactEntity(user.getId(), ContactType.PHONE, (short) 1, registrationForm.getPhone()));
            userContactEntityRepository.saveAll(contacts);
        }
    }

    public ContactConfirmationResponse login(ContactConfirmationPayload payload) {
        Authentication authentication = authenticationManager
                .authenticate(new UsernamePasswordAuthenticationToken(payload.getContact(), payload.getCode()));
        SecurityContextHolder.getContext().setAuthentication(authentication);
        ContactConfirmationResponse response = new ContactConfirmationResponse();
        response.setResult("true");
        return response;
    }

    public ContactConfirmationResponse jwtLogin(ContactConfirmationPayload payload) {
        authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(payload.getContact(), payload.getCode()));
        BookstoreUserDetails userDetails = (BookstoreUserDetails) bookstoreUserDetailsService.loadUserByUsername(payload.getContact());
        String jwtToken = jwtUtil.generateToken(userDetails);
        ContactConfirmationResponse response = new ContactConfirmationResponse();
        response.setResult(jwtToken);
        return response;
    }

    public UserEntity getCurrentUser() {
        BookstoreUserDetails userDetails = (BookstoreUserDetails) SecurityContextHolder
                .getContext()
                .getAuthentication()
                .getPrincipal();
        return userDetails.bookstoreUser();
    }

    public ContactConfirmationResponse requestContactConfirmation(ContactConfirmationPayload payload) {
        return new ContactConfirmationResponse("true");
    }

    public ContactConfirmationResponse approveContact(ContactConfirmationPayload payload) {
        return new ContactConfirmationResponse("true");
    }
}
