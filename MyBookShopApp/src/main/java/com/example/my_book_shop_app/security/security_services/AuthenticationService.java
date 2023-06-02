package com.example.my_book_shop_app.security.security_services;

import ch.qos.logback.classic.Logger;
import com.example.my_book_shop_app.data.model.enums.ContactType;
import com.example.my_book_shop_app.data.model.user.UserEntity;
import com.example.my_book_shop_app.data.repositories.UserContactEntityRepository;
import com.example.my_book_shop_app.data.repositories.UserEntityRepository;
import com.example.my_book_shop_app.exceptions.NoUserFoundException;
import com.example.my_book_shop_app.exceptions.WrongPasswordException;
import com.example.my_book_shop_app.security.BookstoreUserDetails;
import com.example.my_book_shop_app.security.jwt.JWTUtil;
import com.example.my_book_shop_app.security.oauth.CustomOAuth2User;
import com.example.my_book_shop_app.security.security_dto.ContactConfirmationPayload;
import com.example.my_book_shop_app.security.security_dto.ContactConfirmationResponse;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthenticationService {
    private final AuthenticationManager authenticationManager;
    private final BookstoreUserDetailsService bookstoreUserDetailsService;
    private final ContactApprovalService contactApprovalService;
    private final JWTUtil jwtTokenUtil;
    private final UserEntityRepository userEntityRepository;
    private final UserContactEntityRepository userContactEntityRepository;
    private final Logger log = (Logger) LoggerFactory.getLogger(getClass());

    public ContactConfirmationResponse login(ContactConfirmationPayload payload) {
        Authentication authentication = authenticationManager
                .authenticate(new UsernamePasswordAuthenticationToken(payload.getContact(), payload.getCode()));
        SecurityContextHolder.getContext().setAuthentication(authentication);
        ContactConfirmationResponse response = new ContactConfirmationResponse();
        response.setResult("true");
        return response;
    }

    public void jwtTokenLogin(ContactConfirmationPayload payload, HttpServletResponse httpServletResponse) {
        if (!payload.getContact().contains("@")) {
            handlePossessAuthentication(payload);
        } else {
            handlePasswordAuthentication(payload);
        }
        String email = userContactEntityRepository.getUserEmailByContact(payload.getContact(), ContactType.EMAIL);
        final UserDetails userDetails = bookstoreUserDetailsService.loadUserByUsername(email);
        final String token = jwtTokenUtil.generateToken(userDetails);

        Cookie cookie = new Cookie("token", token);
        httpServletResponse.addCookie(cookie);
    }

    private void handlePossessAuthentication(ContactConfirmationPayload payload) {
        ContactConfirmationResponse confirmationResponse = contactApprovalService.approveContact(payload);
        if (!confirmationResponse.getResult().equals("true")) {
            throw new WrongPasswordException("Invalid code provided for authentication.");
        }
    }

    private void handlePasswordAuthentication(ContactConfirmationPayload payload) {
        try {
            authenticate(payload.getContact(), payload.getCode());
        } catch (BadCredentialsException e) {
            if (e.getMessage().contains("UserDetailsService returned null")) {
                throw new NoUserFoundException("User not found");
            } else {
                throw new WrongPasswordException("Wrong password");
            }
        }
    }

    public ContactConfirmationResponse requestContactConfirmation(ContactConfirmationPayload payload) {
        boolean userExists = userEntityRepository.findByContacts(payload.getContact()).isPresent();
        return new ContactConfirmationResponse(userExists ? "true" : "false");
        // throw new ContactNotFoundException("Contact not found: " + payload.getContact());
    }

    private void authenticate(String username, String password) {
        try {
            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(username, password));
        } catch (NoUserFoundException e) {
            throw e;
        } catch (AuthenticationException e) {
            throw new BadCredentialsException(e.getMessage());
        }
    }

    public UserEntity getCurrentUser() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof BookstoreUserDetails userDetails) {
            return userDetails.bookstoreUser();
        } else if (principal instanceof CustomOAuth2User oAuth2User) {
            return oAuth2User.getUser();
        } else {
            log.error("The principal is not an instance of BookstoreUserDetails or CustomOAuth2User. Principal: {}", principal);
            throw new IllegalStateException("The principal is not an instance of BookstoreUserDetails or CustomOAuth2User");
        }
    }
}
