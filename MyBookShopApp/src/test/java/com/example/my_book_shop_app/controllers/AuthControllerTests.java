package com.example.my_book_shop_app.controllers;

import com.example.my_book_shop_app.data.repositories.UserContactEntityRepository;
import com.example.my_book_shop_app.data.repositories.UserEntityRepository;
import com.example.my_book_shop_app.security.security_dto.ContactConfirmationPayload;
import com.example.my_book_shop_app.security.security_dto.RegistrationForm;

import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.Cookie;
import org.junit.jupiter.api.Test;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.security.test.context.support.WithUserDetails;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.transaction.annotation.Transactional;

import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestBuilders.formLogin;
import static org.springframework.security.test.web.servlet.response.SecurityMockMvcResultMatchers.authenticated;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.redirectedUrl;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.xpath;

@SpringBootTest
@AutoConfigureMockMvc
@TestPropertySource("/application-test.properties")
class AuthControllerTests {

    private final MockMvc mockMvc;
    @Autowired
    private UserEntityRepository userEntityRepository;
    @Autowired
    private UserContactEntityRepository userContactEntityRepository;

    @Autowired
    public AuthControllerTests(MockMvc mockMvc) {
        this.mockMvc = mockMvc;
    }

    @Test
    void accessOnlyAuthorizedPageFailTest() throws Exception {
        mockMvc.perform(get("/my"))
                .andDo(print())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/signin"));
    }

    @Test
    void correctLoginTest() throws Exception {
        mockMvc.perform(formLogin("/signin").user("stradivari1390@gmail.com").password("12345678"))
                .andDo(print())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/my"));
    }

    @Test
    @WithUserDetails("stradivari1390@gmail.com")
    void testAuthenticatedAccessToProfilePage() throws Exception {
        mockMvc.perform(get("/profile"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(xpath("/html/body/div/div[2]/main/div/div[2]/div[1]/div/form/div/div[1]/div[1]/input/@value")
                        .string("Stanislav Romanov"));
    }

    @Test
    @Transactional
    void testRegisterNewAccount() throws Exception {
        RegistrationForm registrationForm = new RegistrationForm();
        registrationForm.setName("Test User");
        registrationForm.setEmail("test@example.com");
        registrationForm.setPhone("1234567890");
        registrationForm.setPass("password123");

        mockMvc.perform(post("/reg")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(new ObjectMapper().writeValueAsString(registrationForm)))
                .andExpect(status().is2xxSuccessful());

        mockMvc.perform(formLogin("/signin").user("test@example.com").password("password123"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/my"));

        userContactEntityRepository.deleteAllByUserId(userEntityRepository.deleteByUsername("test@example.com"));
    }

    @Test
    void testLoginWithEmail() throws Exception {
        ContactConfirmationPayload payload = new ContactConfirmationPayload();
        payload.setContact("stradivari1390@gmail.com");
        payload.setCode("12345678");

        Cookie cartContentsCookie = new Cookie("cartContents", "book1/book2/book3");
        Cookie postponedContentsCookie = new Cookie("postponedContents", "book4/book5");

        mockMvc.perform(post("/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(new ObjectMapper().writeValueAsString(payload))
                        .cookie(cartContentsCookie, postponedContentsCookie))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.redirect").value("/my"));
    }

    @Test
    void testLoginWithPhoneNumber() throws Exception {
//        ContactConfirmationPayload payload = new ContactConfirmationPayload();
//        payload.setContact("+62 (821) 4651-2256");
//        payload.setCode("123456");
//
//        mockMvc.perform(post("/login")
//                        .contentType(MediaType.APPLICATION_JSON)
//                        .content(new ObjectMapper().writeValueAsString(payload)))
//                .andExpect(status().isOk())
//                .andExpect(jsonPath("$.success").value(true))
//                .andExpect(jsonPath("$.redirect").value("/my"));
    }

    @Test
    @WithUserDetails("stradivari1390@gmail.com")
    void testLogout() throws Exception {
        mockMvc.perform(post("/logout"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/signin"));

        mockMvc.perform(get("/my"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/signin"));
    }
}
