package com.example.my_book_shop_app.services;

import com.example.my_book_shop_app.data.model.user.UserEntity;
import com.example.my_book_shop_app.exceptions.NoUserFoundException;
import com.example.my_book_shop_app.exceptions.WrongPasswordException;
import com.example.my_book_shop_app.security.BookstoreUserDetails;
import com.example.my_book_shop_app.security.jwt.JWTUtil;
import com.example.my_book_shop_app.security.security_dto.ContactConfirmationPayload;
import com.example.my_book_shop_app.security.security_services.BookstoreUserDetailsService;
import com.example.my_book_shop_app.security.security_services.BookstoreUserRegister;
import com.example.my_book_shop_app.security.security_services.TokenBlacklistService;

import jakarta.servlet.http.Cookie;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.context.WebApplicationContext;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.when;

import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.cookie;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
class AdditionalBookstoreUserRegisterTests {
    @Autowired
    private WebApplicationContext context;
    @Autowired
    private JWTUtil jwtTokenUtil;
    @MockBean
    private BookstoreUserDetailsService bookstoreUserDetailsService;
    private MockMvc mockMvc;
    @Autowired
    private BookstoreUserRegister bookstoreUserRegister;
    @Autowired
    private TokenBlacklistService tokenBlacklistService;
    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
    private final MockHttpServletResponse mockHttpServletResponse = new MockHttpServletResponse();

    @BeforeEach
    void setUp() {
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    void registerNewUserWithInvalidEmail() {
        // TODO: Finish implementation of email validation logic in the registration process
        // and add the test case
    }

    @Test
    void registerNewUserWithInvalidPhone() {
        // TODO: Finish implementation of phone number validation logic in the registration process
        // and add the test case
    }

    @Test
    void successfulUserLoginAndTokenGeneration() throws Exception {
        UserEntity user = new UserEntity();
        user.setUsername("testuser");
        user.setPassword(passwordEncoder.encode("password"));

        when(bookstoreUserDetailsService.loadUserByUsername("testuser")).thenReturn(new BookstoreUserDetails(user));

        bookstoreUserRegister.jwtTokenLogin(new ContactConfirmationPayload("testuser", "password"), mockHttpServletResponse);

        UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(user.getUsername(), user.getPassword());
        SecurityContextHolder.getContext().setAuthentication(authenticationToken);

        mockMvc.perform(post("/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"contact\":\"testuser\",\"code\":\"password\"}"))
                .andExpect(status().isOk())
                .andExpect(cookie().exists("token"))
                .andExpect(result -> {
                    Cookie tokenCookie = result.getResponse().getCookie("token");
                    String responseToken = tokenCookie.getValue();
                    String username = jwtTokenUtil.getUsernameFromToken(responseToken);
                    assertEquals("testuser", username);
                });
    }

    @Test
    void unsuccessfulUserLoginWithInvalidPassword() {
        UserEntity user = new UserEntity();
        user.setUsername("testuser");
        user.setPassword(passwordEncoder.encode("password"));

        when(bookstoreUserDetailsService.loadUserByUsername("testuser")).thenReturn(new BookstoreUserDetails(user));

        ContactConfirmationPayload payload = new ContactConfirmationPayload();
        payload.setContact("testuser");
        payload.setCode("wrongpassword");

        assertThrows(WrongPasswordException.class, () -> bookstoreUserRegister.jwtTokenLogin(payload, mockHttpServletResponse));
    }

    @Test
    void unsuccessfulUserLoginWithNonExistentUser() {
        when(bookstoreUserDetailsService.loadUserByUsername("nonexistentuser")).thenThrow(new NoUserFoundException("User not found"));

        ContactConfirmationPayload payload = new ContactConfirmationPayload();
        payload.setContact("nonexistentuser");
        payload.setCode("password");

        assertThrows(NoUserFoundException.class, () -> bookstoreUserRegister.jwtTokenLogin(payload, mockHttpServletResponse));
    }

    @Test
    void testTokenValidationForValidToken() {
        UserEntity user = new UserEntity();
        user.setUsername("testuser2");
        user.setPassword(passwordEncoder.encode("password"));

        BookstoreUserDetails userDetails = new BookstoreUserDetails(user);
        String token = jwtTokenUtil.generateToken(userDetails);

        boolean valid = jwtTokenUtil.validateToken(token, userDetails);

        assertTrue(valid);
    }

    @Test
    void testTokenValidationForExpiredToken() throws InterruptedException {
        JWTUtil.setTokenValidity(1000);
        UserEntity user = new UserEntity();
        user.setUsername("testuser");
        user.setPassword(passwordEncoder.encode("password"));

        BookstoreUserDetails userDetails = new BookstoreUserDetails(user);
        String token = jwtTokenUtil.generateToken(userDetails);

        Thread.sleep(2000);

        boolean valid = jwtTokenUtil.validateToken(token, userDetails);

        assertFalse(valid);

        JWTUtil.setTokenValidity(5 * 60 * 60 * 1000);
    }

    @Test
    void testTokenValidationForInvalidToken() {
        String invalidToken = "invalid_token";
        UserEntity user = new UserEntity();
        user.setUsername("testuser");
        user.setPassword(passwordEncoder.encode("password"));

        BookstoreUserDetails userDetails = new BookstoreUserDetails(user);

        boolean valid = jwtTokenUtil.validateToken(invalidToken, userDetails);

        assertFalse(valid);
    }

    @Test
    void testTokenValidationForBlacklistedToken() {
        UserEntity user = new UserEntity();
        user.setUsername("testuser");
        user.setPassword(passwordEncoder.encode("password"));

        BookstoreUserDetails userDetails = new BookstoreUserDetails(user);
        String token = jwtTokenUtil.generateToken(userDetails);

        tokenBlacklistService.addToBlacklist(token);

        boolean valid = jwtTokenUtil.validateToken(token, userDetails);

        assertFalse(valid);
    }
}