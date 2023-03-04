package com.example.my_book_shop_app.controllers;

import com.example.my_book_shop_app.data.services.CartService;
import com.example.my_book_shop_app.dto.BookDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.util.List;

@Controller
public class CartController {

    private final CartService cartService;

    @Autowired
    public CartController(CartService cartService) {
        this.cartService = cartService;
    }

    @ModelAttribute("cartBooks")
    public List<BookDto> cartBooks(){
        return cartService.cartBooks();
    }

    @ModelAttribute("totalPrice")
    public String totalPrice() {
        return cartService.totalPrice();
    }

    @ModelAttribute("totalPriceOld")
    public String totalPriceOld() {
        return cartService.totalPriceOld();
    }

    @GetMapping("/cart")
    public String cartPage() {
        return "cart";
    }
}
