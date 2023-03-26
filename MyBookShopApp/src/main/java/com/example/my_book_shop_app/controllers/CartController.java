package com.example.my_book_shop_app.controllers;

import com.example.my_book_shop_app.services.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class CartController {

    private final CartService cartService;

    @Autowired
    public CartController(CartService cartService) {
        this.cartService = cartService;
    }

    @GetMapping("/books/cart")
    public String postponedPage(@RequestParam(value = "offset", defaultValue = "0") Integer offset,
                                @RequestParam(value = "limit", defaultValue = "10") Integer limit,
                                Model model) {
        model.addAttribute("cartBooks", cartService.getPageOfCartBooks(7L, offset, limit).getContent());
        model.addAttribute("totalPrice", cartService.getTotalPrice(7L));
        model.addAttribute("totalDiscountPrice", cartService.getTotalDiscountPrice(7L));
        return "cart";
    }
}
