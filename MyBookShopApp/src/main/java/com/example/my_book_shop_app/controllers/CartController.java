package com.example.my_book_shop_app.controllers;

import com.example.my_book_shop_app.dto.UserDto;
import com.example.my_book_shop_app.security.security_services.BookstoreUserDetailsService;
import com.example.my_book_shop_app.security.security_services.BookstoreUserRegister;
import com.example.my_book_shop_app.services.CartService;

import jakarta.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Collections;

@Controller
public class CartController {

    private final CartService cartService;
    private final BookstoreUserRegister bookstoreUserRegister;
    private final BookstoreUserDetailsService bookstoreUserDetailsService;

    @Autowired
    public CartController(CartService cartService, BookstoreUserRegister bookstoreUserRegister,
                          BookstoreUserDetailsService bookstoreUserDetailsService) {
        this.cartService = cartService;
        this.bookstoreUserRegister = bookstoreUserRegister;
        this.bookstoreUserDetailsService = bookstoreUserDetailsService;
    }

    @PostMapping("/changeBookStatus/{slug}")
    public String handleChangeBookStatus(@RequestParam("status") String status,
                                         @PathVariable("slug") String slug,
                                         @RequestHeader(value = "referer", required = false) String referer,
                                         @CookieValue(name = "cartContents", required = false) String cartContents,
                                         @CookieValue(name = "postponedContents", required = false) String postponedContents,
                                         HttpServletResponse response, Authentication authentication) {
        switch (status) {
            case "CART" -> cartService.addToCart(slug, cartContents, postponedContents, response, authentication);
            case "MASS_CART" -> cartService.addAllToCart(cartContents, postponedContents, response, authentication);
            case "KEPT" -> cartService.addToPostponed(slug, cartContents, postponedContents, response, authentication);
            case "ARCHIVED" -> cartService.addToArchived(slug);
            default -> {}
        }
        if (referer != null && !referer.isEmpty()) {
            return "redirect:" + referer;
        } else {
            return "redirect:/";
        }
    }

    @GetMapping("/cart")
    public String handleCartRequest(@CookieValue(value = "cartContents", required = false) String cartContents,
                                    Model model, Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated()) {
            UserDto userDto = bookstoreUserDetailsService.getUserDtoById(bookstoreUserRegister.getCurrentUser().getId());
            model.addAttribute("authStatus", "authorized");
            model.addAttribute("curUsr", userDto);
            model.addAttribute("totalPrice", cartService.getTotalPrice(userDto));
            model.addAttribute("totalDiscountPrice", cartService.getTotalDiscountPrice(userDto));
        } else {
            model.addAttribute("authStatus", "unauthorized");
            if (cartContents != null && !cartContents.equals("")) {
                model.addAttribute("cartBooks", cartService.getBookDtoListByCookie(cartContents));
                model.addAttribute("totalPrice", cartService.getTotalPrice(cartContents));
                model.addAttribute("totalDiscountPrice", cartService.getTotalDiscountPrice(cartContents));
            } else {
                model.addAttribute("cartBooks", Collections.emptyList());
                model.addAttribute("totalPrice", 0D);
                model.addAttribute("totalDiscountPrice", 0D);
            }
        }
        return "cart";
    }

    @PostMapping("/changeBookStatus/cart/remove/{slug}")
    public String handleRemoveBookFromCartRequest(@PathVariable("slug") String slug,
                                                  @CookieValue(name = "cartContents", required = false) String cartContents,
                                                  HttpServletResponse response, Model model, Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated()) {
            cartService.removeBook2UserRelation(bookstoreUserRegister.getCurrentUser().getId(), slug);
        }
        if (cartContents != null && !cartContents.equals("")) {
            cartService.removeSlugFromCookie(slug, cartContents, "cartContents", response);
        }
        return handleCartRequest(cartContents, model, authentication);
    }

    @GetMapping("/postponed")
    public String handlePostponedRequest(@CookieValue(value = "postponedContents", required = false) String postponedContents,
                                         Model model, Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated()) {
            model.addAttribute("authStatus", "authorized");
            model.addAttribute("curUsr", bookstoreUserDetailsService.getUserDtoById(bookstoreUserRegister.getCurrentUser().getId()));
        } else {
            model.addAttribute("authStatus", "unauthorized");
            if (postponedContents != null && !postponedContents.equals("")) {
                model.addAttribute("postponedBooks", cartService.getBookDtoListByCookie(postponedContents));
                model.addAttribute("postponedContents", postponedContents);
            } else {
                model.addAttribute("postponedBooks", Collections.emptyList());
            }
        }
        return "postponed";
    }

    @PostMapping("/changeBookStatus/postponed/remove/{slug}")
    public String handleRemoveBookFromPostponedRequest(@PathVariable("slug") String slug,
                                                       @CookieValue(name = "postponedContents", required = false) String postponedContents,
                                                       HttpServletResponse response, Model model, Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated()) {
            cartService.removeBook2UserRelation(bookstoreUserRegister.getCurrentUser().getId(), slug);
        }
        if (postponedContents != null && !postponedContents.equals("")) {
            cartService.removeSlugFromCookie(slug, postponedContents, "postponedContents", response);
        }
        return handlePostponedRequest(postponedContents, model, authentication);
    }

    @GetMapping(value = "/archived")
    public String handleArchivedRequest(Model model, Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated()) {
            model.addAttribute("authStatus", "authorized");
            model.addAttribute("curUsr", bookstoreUserDetailsService.getUserDtoById(bookstoreUserRegister.getCurrentUser().getId()));
        } else {
            model.addAttribute("authStatus", "unauthorized");
        }
        return "myarchive";
    }

    @PostMapping("/changeBookStatus/archived/remove/{slug}")
    public String handleRemoveBookFromArchivedRequest(@PathVariable("slug") String slug,
                                                      Model model, Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated()) {
            cartService.changeBook2UserRelation(bookstoreUserRegister.getCurrentUser().getId(), slug, "purchased");
        }
        return handleArchivedRequest(model, authentication);
    }

    @GetMapping("/buy")
    public String handleBuyRequest(Authentication authentication, RedirectAttributes redirectAttributes) {
        if (authentication != null && authentication.isAuthenticated()) {
            UserDto userDto = bookstoreUserDetailsService.getUserDtoById(bookstoreUserRegister.getCurrentUser().getId());
            boolean success = cartService.buy(userDto);
            if (success) {
                redirectAttributes.addFlashAttribute("message", "Purchase successful!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Insufficient balance!");
            }
        } else {
            return "redirect:/signin";
        }
        return "redirect:/my";
    }
}