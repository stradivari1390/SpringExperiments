package com.example.my_book_shop_app.controllers;

import com.example.my_book_shop_app.security.BookstoreUserDetailsService;
import com.example.my_book_shop_app.security.BookstoreUserRegister;
import com.example.my_book_shop_app.services.BookService;
import com.example.my_book_shop_app.services.CartService;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;

@Controller
public class CartController {

    private final CartService cartService;
    private final BookstoreUserRegister bookstoreUserRegister;
    private final BookstoreUserDetailsService bookstoreUserDetailsService;
    private final BookstoreUserRegister userRegister;
    private final BookService bookService;

    @Autowired
    public CartController(CartService cartService, BookstoreUserRegister bookstoreUserRegister,
                          BookstoreUserDetailsService bookstoreUserDetailsService, BookstoreUserRegister userRegister,
                          BookService bookService) {
        this.cartService = cartService;
        this.bookstoreUserRegister = bookstoreUserRegister;
        this.bookstoreUserDetailsService = bookstoreUserDetailsService;
        this.userRegister = userRegister;
        this.bookService = bookService;
    }

    @PostMapping("/changeBookStatus/{slug}")
    public String handleChangeBookStatus(@RequestParam("status") String status,
                                         @PathVariable("slug") String slug,
                                         @RequestHeader(value = "referer", required = false) String referer,
                                         @CookieValue(name = "cartContents", required = false) String cartContents,
                                         @CookieValue(name = "postponedContents", required = false) String postponedContents,
                                         HttpServletResponse response) {
        switch (status) {
            case "CART" -> cartService.addToCart(slug, bookstoreUserRegister.getCurrentUser().getId(), cartContents, postponedContents, response);
            case "MASS_CART" -> {
                String[] bookIds = slug.split(",");
                for (String bookId : bookIds) {
                    cartService.addToCart(bookId, bookstoreUserRegister.getCurrentUser().getId(), cartContents, postponedContents, response);
                }
            }
            case "KEPT" -> cartService.addToPostponed(slug, bookstoreUserRegister.getCurrentUser().getId(), cartContents, postponedContents, response);
            case "ARCHIVED" -> cartService.addToArchived(slug, bookstoreUserRegister.getCurrentUser().getId());
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
            model.addAttribute("authStatus", "authorized");
            model.addAttribute("curUsr", bookstoreUserDetailsService.getUserDtoById(userRegister.getCurrentUser().getId()));
        } else {
            model.addAttribute("authStatus", "unauthorized");
        }
        if (cartContents != null && !cartContents.equals("")) {
            model.addAttribute("cartBooks", cartService.getBookDtoListByCookie(cartContents));
            model.addAttribute("totalPrice", cartService.getTotalPrice(cartContents));
            model.addAttribute("totalDiscountPrice", cartService.getTotalDiscountPrice(cartContents));
        } else {
            model.addAttribute("cartBooks", Collections.emptyList());
            model.addAttribute("totalPrice", 0D);
            model.addAttribute("totalDiscountPrice", 0D);
        }
        return "cart";
    }

    @PostMapping("/changeBookStatus/cart/remove/{slug}")
    public String handleRemoveBookFromCartRequest(@PathVariable("slug") String slug,
                                                  @CookieValue(name = "cartContents", required = false) String cartContents,
                                                  HttpServletResponse response, Model model, Authentication authentication) {
        if (cartContents != null && !cartContents.equals("")) {
            cartService.removeSlugFromCookie(slug, cartContents, "cartContents", response);
            cartService.removeBook2UserRelation(bookstoreUserRegister.getCurrentUser().getId(), slug);
        }
        return handleCartRequest(cartContents, model, authentication);
    }

    @GetMapping("/postponed")
    public String handlePostponedRequest(@CookieValue(value = "postponedContents", required = false) String postponedContents,
                                         Model model, Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated()) {
            model.addAttribute("authStatus", "authorized");
            model.addAttribute("curUsr", bookstoreUserDetailsService.getUserDtoById(userRegister.getCurrentUser().getId()));
        } else {
            model.addAttribute("authStatus", "unauthorized");
        }
        if (postponedContents != null && !postponedContents.equals("")) {
            model.addAttribute("postponedBooks", cartService.getBookDtoListByCookie(postponedContents));
            model.addAttribute("postponedBooksSlugs", cartService.getCookieBooksSlugs(postponedContents));
        } else {
            model.addAttribute("postponedBooks", Collections.emptyList());
        }
        return "postponed";
    }

    @PostMapping("/changeBookStatus/postponed/remove/{slug}")
    public String handleRemoveBookFromPostponedRequest(@PathVariable("slug") String slug,
                                                       @CookieValue(name = "postponedContents", required = false) String postponedContents,
                                                       HttpServletResponse response, Model model, Authentication authentication) {
        if (postponedContents != null && !postponedContents.equals("")) {
            cartService.removeSlugFromCookie(slug, postponedContents, "postponedContents", response);
            cartService.removeBook2UserRelation(bookstoreUserRegister.getCurrentUser().getId(), slug);
        }
        return handlePostponedRequest(postponedContents, model, authentication);
    }

    @GetMapping(value = "/archived")
    public String handleArchivedRequest(Model model, Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated()) {
            model.addAttribute("authStatus", "authorized");
            model.addAttribute("curUsr", bookstoreUserDetailsService.getUserDtoById(userRegister.getCurrentUser().getId()));
            model.addAttribute("archivedBooks", bookService.getUsersArchivedBooks(userRegister.getCurrentUser().getId()));
        } else {
            model.addAttribute("authStatus", "unauthorized");
        }
        return "myarchive";
    }

    @PostMapping("/changeBookStatus/archived/remove/{slug}")
    public String handleRemoveBookFromArchivedRequest(@PathVariable("slug") String slug,
                                                      Model model, Authentication authentication) {
        if(cartService.findBook2UserRelation(slug, bookstoreUserRegister.getCurrentUser().getId()).equals("archived")) {
            cartService.changeBook2UserRelation(bookstoreUserRegister.getCurrentUser().getId(), slug, "purchased");
        }
        return handleArchivedRequest(model, authentication);
    }
}