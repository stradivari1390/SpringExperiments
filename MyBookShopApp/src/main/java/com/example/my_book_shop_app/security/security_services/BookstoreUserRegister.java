package com.example.my_book_shop_app.security.security_services;

import com.example.my_book_shop_app.data.model.enums.ContactType;
import com.example.my_book_shop_app.data.model.user.UserContactEntity;
import com.example.my_book_shop_app.data.model.user.UserEntity;
import com.example.my_book_shop_app.data.repositories.UserContactEntityRepository;
import com.example.my_book_shop_app.data.repositories.UserEntityRepository;
import com.example.my_book_shop_app.data.UserContactDetails;
import com.example.my_book_shop_app.exceptions.UserAlreadyExistsException;
import com.example.my_book_shop_app.exceptions.WrongPasswordException;
import com.example.my_book_shop_app.security.BookstoreUserDetails;
import com.example.my_book_shop_app.security.jwt.JWTUtil;
import com.example.my_book_shop_app.security.oauth.CustomOAuth2User;
import com.example.my_book_shop_app.security.security_controller.AuthUserController;
import com.example.my_book_shop_app.security.security_dto.ContactConfirmationPayload;
import com.example.my_book_shop_app.security.security_dto.ContactConfirmationResponse;
import com.example.my_book_shop_app.security.security_dto.RegistrationForm;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
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
    private final JWTUtil jwtTokenUtil;
    private final AuthUserController authUserController;

    @Autowired
    public BookstoreUserRegister(UserEntityRepository userEntityRepository, PasswordEncoder passwordEncoder,
                                 AuthenticationManager authenticationManager,
                                 BookstoreUserDetailsService bookstoreUserDetailsService, JWTUtil jwtTokenUtil,
                                 UserContactEntityRepository userContactEntityRepository,
                                 @Lazy AuthUserController authUserController) {
        this.userEntityRepository = userEntityRepository;
        this.passwordEncoder = passwordEncoder;
        this.authenticationManager = authenticationManager;
        this.bookstoreUserDetailsService = bookstoreUserDetailsService;
        this.jwtTokenUtil = jwtTokenUtil;
        this.userContactEntityRepository = userContactEntityRepository;
        this.authUserController = authUserController;
    }

    public void registerNewUser(RegistrationForm registrationForm) {

        if (userEntityRepository.findByContacts(registrationForm.getEmail()).isEmpty()) {
            UserEntity user = new UserEntity();
            user.setName(registrationForm.getName());
            user.setUsername(registrationForm.getEmail());
            user.setPassword(passwordEncoder.encode(registrationForm.getPass()));
            user.setBalance(0D);
            user.setRegTime(LocalDateTime.now());
            user.setHash(String.valueOf(user.getUsername().hashCode()));
            userEntityRepository.save(user);

            String email = registrationForm.getEmail();
            String phone = registrationForm.getPhone() == null ? "" : registrationForm.getPhone();

            List<UserContactDetails> userContacts = List.of(
                    new UserContactDetails(user.getId(), ContactType.EMAIL, email, (short) 1),
                    new UserContactDetails(user.getId(), ContactType.PHONE, phone, (short) 1)
            );

            for (UserContactDetails contactDetails : userContacts) {
                userContactEntityRepository.findByContact(contactDetails.contact())
                        .ifPresentOrElse(existingContact -> {
                            if (existingContact.getUserId() == -1L) {
                                existingContact.setUserId(contactDetails.userId());
                                existingContact.setApproved(contactDetails.approved());
                                userContactEntityRepository.save(existingContact);
                            }
                        }, () -> {
                            UserContactEntity newContact = new UserContactEntity(contactDetails.userId(),
                                    contactDetails.contactType(), contactDetails.approved(),
                                    contactDetails.contact());
                            userContactEntityRepository.save(newContact);
                        });
            }
        } else {
            throw new UserAlreadyExistsException("User with this contact already exists");
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

    public void jwtTokenLogin(ContactConfirmationPayload payload, HttpServletResponse httpServletResponse) throws Exception {
//        handlePossessAuthentication(payload);
        handlePasswordAuthentication(payload);

        final UserDetails userDetails = bookstoreUserDetailsService.loadUserByUsername(payload.getContact());
        final String token = jwtTokenUtil.generateToken(userDetails);
        Cookie cookie = new Cookie("token", token);
        httpServletResponse.addCookie(cookie);
    }

    private void handlePossessAuthentication(ContactConfirmationPayload payload) {
        ContactConfirmationResponse confirmationResponse = authUserController.handleApproveContact(payload);
        if (!confirmationResponse.getResult().equals("true")) {
            throw new WrongPasswordException("Invalid code provided for authentication.");
        }
    }

    private void handlePasswordAuthentication(ContactConfirmationPayload payload) throws Exception {
        try {
            authenticate(payload.getContact(), payload.getCode());
        } catch (BadCredentialsException e) {
            throw new WrongPasswordException("Wrong password");
        }
    }

    public UserEntity getCurrentUser() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof BookstoreUserDetails userDetails) {
            return userDetails.bookstoreUser();
        } else if (principal instanceof CustomOAuth2User oAuth2User) {
            return oAuth2User.getUser();
        } else {
            throw new IllegalStateException("The principal is not an instance of BookstoreUserDetails or CustomOAuth2User");
        }
    }

    public ContactConfirmationResponse requestContactConfirmation(ContactConfirmationPayload payload) {
//        boolean userExists = userEntityRepository.findByContacts(payload.getContact()).isPresent();
//        if (!userExists) {
//            return new ContactConfirmationResponse("false");
//            throw new ContactNotFoundException("Contact not found: " + payload.getContact());
//        }
        return new ContactConfirmationResponse("true");
    }

    public ContactConfirmationResponse approveContact(ContactConfirmationPayload payload) {
//        String contact = payload.getContact();
//        UserContactEntity userContactEntity = userContactEntityRepository.findByContact(contact)
//                .orElseThrow(() -> new ContactNotFoundException(contact + " contact not found"));
//        boolean confirmed = userContactEntity.getCode().equals(payload.getCode());
//        return new ContactConfirmationResponse(confirmed ? "true" : "false");
        return new ContactConfirmationResponse("true");
    }


    private void authenticate(String username, String password) {
        try {
            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(username, password));
//        } catch (DisabledException e) {
//            throw new Exception("USER_DISABLED", e); move to exceptionHandler
        } catch (BadCredentialsException e) {
            throw new WrongPasswordException("INVALID PASSWORD");
        }
    }
}