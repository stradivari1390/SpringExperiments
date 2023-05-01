package com.example.my_book_shop_app.controllers;

import com.example.my_book_shop_app.data.model.user.UserEntity;
import com.example.my_book_shop_app.security.security_services.BookstoreUserRegister;
import com.example.my_book_shop_app.services.CartService;
import jakarta.servlet.http.Cookie;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.web.servlet.MockMvc;

import static org.mockito.Mockito.*;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.user;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.redirectedUrl;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
class CartControllerTests {

    private final MockMvc mockMvc;

    @MockBean
    private CartService cartService;

    @MockBean
    private BookstoreUserRegister bookstoreUserRegister;

    @Autowired
    public CartControllerTests(MockMvc mockMvc) {
        this.mockMvc = mockMvc;
    }

    @Test
    void addBookToCartForAuthenticatedUser() throws Exception {
        String slug = "test-slug";
        String status = "CART";
        when(bookstoreUserRegister.getCurrentUser()).thenReturn(new UserEntity());

        mockMvc.perform(post("/changeBookStatus/{slug}", slug)
                        .param("status", status)
                        .with(user("user").password("password")))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/"));

        verify(cartService, times(1)).addToCart(eq(slug), any(), any(), any(), any());
    }

    @Test
    void addBookToCartForUnauthenticatedUser() throws Exception {
        String slug = "test-slug";
        String status = "CART";

        mockMvc.perform(post("/changeBookStatus/{slug}", slug)
                        .param("status", status))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/"));

        verify(cartService, times(1)).addToCart(eq(slug), any(), any(), any(), isNull());
    }

    @Test
    void addBookToPostponedForAuthenticatedUser() throws Exception {
        String slug = "test-slug";
        String status = "KEPT";
        when(bookstoreUserRegister.getCurrentUser()).thenReturn(new UserEntity());

        mockMvc.perform(post("/changeBookStatus/{slug}", slug)
                        .param("status", status)
                        .with(user("user").password("password")))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/"));

        verify(cartService, times(1)).addToPostponed(eq(slug), any(), any(), any(), any());
    }

    @Test
    void addBookToPostponedForUnauthenticatedUser() throws Exception {
        String slug = "test-slug";
        String status = "KEPT";

        mockMvc.perform(post("/changeBookStatus/{slug}", slug)
                        .param("status", status))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/"));

        verify(cartService, times(1)).addToPostponed(eq(slug), any(), any(), any(), isNull());
    }

    @Test
    void addBookToArchivedForAuthenticatedUser() throws Exception {
        String slug = "test-slug";
        String status = "ARCHIVED";
        when(bookstoreUserRegister.getCurrentUser()).thenReturn(new UserEntity());

        mockMvc.perform(post("/changeBookStatus/{slug}", slug)
                        .param("status", status)
                        .with(user("user").password("password")))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/"));

        verify(cartService, times(1)).addToArchived(slug);
    }

    @Test
    void removeBookFromCart() throws Exception {
        String slug = "test-slug";
        UserEntity userEntity = new UserEntity();
        userEntity.setId(1L);
        when(bookstoreUserRegister.getCurrentUser()).thenReturn(userEntity);
        String cartContents = "test-slug";
        mockMvc.perform(post("/changeBookStatus/cart/remove/{slug}", slug)
                        .cookie(new Cookie("cartContents", cartContents))
                        .with(user("user").password("password")))
                .andExpect(status().is2xxSuccessful());

        verify(cartService, times(1)).removeBook2UserRelation(any(), eq(slug));
        verify(cartService, times(1)).removeSlugFromCookie(eq(slug), any(), eq("cartContents"), any());
    }

    @Test
    void removeBookFromPostponed() throws Exception {
        String slug = "test-slug";
        UserEntity userEntity = new UserEntity();
        userEntity.setId(1L);
        when(bookstoreUserRegister.getCurrentUser()).thenReturn(userEntity);
        String postponedContents = "test-slug";
        mockMvc.perform(post("/changeBookStatus/postponed/remove/{slug}", slug)
                        .cookie(new Cookie("postponedContents", postponedContents))
                        .with(user("user").password("password")))
                .andExpect(status().is2xxSuccessful());

        verify(cartService, times(1)).removeBook2UserRelation(any(), eq(slug));
        verify(cartService, times(1)).removeSlugFromCookie(eq(slug), any(), eq("postponedContents"), any());
    }

    @Test
    void removeBookFromArchived() throws Exception {
        String slug = "test-slug";
        UserEntity userEntity = new UserEntity();
        userEntity.setId(1L);
        when(bookstoreUserRegister.getCurrentUser()).thenReturn(userEntity);
        mockMvc.perform(post("/changeBookStatus/archived/remove/{slug}", slug)
                        .with(user("user").password("password")))
                .andExpect(status().is2xxSuccessful());
        verify(cartService, times(1)).changeBook2UserRelation(any(), eq(slug), eq("purchased"));
    }
}