package com.example.my_book_shop_app.controllers;

import com.example.my_book_shop_app.security.BookstoreUserRegister;
import com.example.my_book_shop_app.services.CartService;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;

@Controller
public class CartController {

    private final CartService cartService;
    private final BookstoreUserRegister bookstoreUserRegister;

    @Autowired
    public CartController(CartService cartService, BookstoreUserRegister bookstoreUserRegister) {
        this.cartService = cartService;
        this.bookstoreUserRegister = bookstoreUserRegister;
    }

    @PostMapping("/changeBookStatus/{slug}")
    public String handleChangeBookStatus(@RequestParam("status") String status,
                                         @PathVariable("slug") String slug,
                                         @RequestHeader(value = "referer", required = false) String referer,
                                         @CookieValue(name = "cartContents", required = false) String cartContents,
                                         @CookieValue(name = "postponedContents", required = false) String postponedContents,
                                         @CookieValue(name = "archivedContents", required = false) String archivedContents,
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
            case "ARCHIVED" -> cartService.addToArchived(slug, bookstoreUserRegister.getCurrentUser().getId(), archivedContents, response);
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
                                    Model model) {

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
                                                  HttpServletResponse response, Model model) {
        if (cartContents != null && !cartContents.equals("")) {
            cartService.removeSlugFromCookie(slug, cartContents, "cartContents", response);
            cartService.removeBook2UserRelation(bookstoreUserRegister.getCurrentUser().getId(), slug);
        }
        return handleCartRequest(cartContents, model);
    }

    @GetMapping("/postponed")
    public String handlePostponedRequest(@CookieValue(value = "postponedContents", required = false) String postponedContents,
                                         Model model) {
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
                                                       HttpServletResponse response, Model model) {
        if (postponedContents != null && !postponedContents.equals("")) {
            cartService.removeSlugFromCookie(slug, postponedContents, "postponedContents", response);
            cartService.removeBook2UserRelation(bookstoreUserRegister.getCurrentUser().getId(), slug);
        }
        return handlePostponedRequest(postponedContents, model);
    }

    @GetMapping("/archived")
    public String handleArchivedRequest(@CookieValue(value = "archivedContents", required = false) String archivedContents,
                                        Model model) {
        if (archivedContents != null && !archivedContents.equals("")) {
            model.addAttribute("archivedBooks", cartService.getBookDtoListByCookie(archivedContents));
        } else {
            model.addAttribute("archivedBooks", Collections.emptyList());
        }
        return "myarchive";
    }

    @PostMapping("/changeBookStatus/archived/remove/{slug}")
    public String handleRemoveBookFromArchivedRequest(@PathVariable("slug") String slug,
                                                      @CookieValue(name = "archivedContents", required = false) String archivedContents,
                                                      HttpServletResponse response, Model model) {
        if (archivedContents != null && !archivedContents.equals("")) {
            cartService.removeSlugFromCookie(slug, archivedContents, "archivedContents", response);
            cartService.changeBook2UserRelation(bookstoreUserRegister.getCurrentUser().getId(), slug, "purchased");
        }
        return handleArchivedRequest(archivedContents, model);
    }
}