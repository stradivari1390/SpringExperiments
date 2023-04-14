package com.example.my_book_shop_app.security;

import com.example.my_book_shop_app.data.model.enums.ContactType;
import com.example.my_book_shop_app.data.model.user.UserContactEntity;
import com.example.my_book_shop_app.data.model.user.UserEntity;
import com.example.my_book_shop_app.data.repositories.UserContactEntityRepository;
import com.example.my_book_shop_app.data.repositories.UserEntityRepository;
import com.example.my_book_shop_app.security.jwt.JWTUtil;
import com.example.my_book_shop_app.security.oauth.CustomOAuth2User;
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
                    List.of(new UserContactEntity(user.getId(), ContactType.EMAIL, (short) 1,
                                    registrationForm.getEmail()),
                    new UserContactEntity(user.getId(), ContactType.PHONE, (short) 1,
                            registrationForm.getPhone() == null ?
                                    "" : registrationForm.getPhone().replaceAll("[^0-9+]", "")));
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

    public void jwtTokenLogin(ContactConfirmationPayload payload, HttpServletResponse httpServletResponse) throws Exception {
        if (!payload.getContact().contains("@")) {
            ContactConfirmationResponse confirmationResponse = authUserController.handleApproveContact(payload);
            if (!confirmationResponse.getResult().equals("true")) {
                throw new Exception("INVALID_CODE", new BadCredentialsException("Invalid code provided for phone authentication."));
            }
        }
        authenticate(payload.getContact(), payload.getCode());
        final UserDetails userDetails = bookstoreUserDetailsService.loadUserByUsername(payload.getContact());
        final String token = jwtTokenUtil.generateToken(userDetails);
        Cookie cookie = new Cookie("token", token);
        httpServletResponse.addCookie(cookie);
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
        return userEntityRepository.findByContacts(payload.getContact().replaceAll("[^0-9+]", "")) == null ?
                new ContactConfirmationResponse("false") :
                new ContactConfirmationResponse("true");
    }

    public ContactConfirmationResponse approveContact(ContactConfirmationPayload payload) {
        Long userId = userEntityRepository.findByContacts(payload.getContact()).getId();
        UserContactEntity userContactEntity = new UserContactEntity();
        if (userId != null) {
            userContactEntity = userContactEntityRepository.findByUserIdAndType(userId, ContactType.PHONE);
        }
        if (userContactEntity != null) {
            return userContactEntity.getCode().equals(payload.getCode()) ?
                    new ContactConfirmationResponse("true") :
                    new ContactConfirmationResponse("false");
        } else {
            return new ContactConfirmationResponse("false");
        }
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
