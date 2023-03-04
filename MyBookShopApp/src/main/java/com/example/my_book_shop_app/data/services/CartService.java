package com.example.my_book_shop_app.data.services;

import com.example.my_book_shop_app.dto.BookDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartService {

    private final BookService bookService;

    @Autowired
    public CartService(BookService bookService) {
        this.bookService = bookService;
    }

    public List<BookDto> cartBooks(){
        return bookService.getCartBooks();
    }

    public String totalPrice() {
        double totalPrice = bookService.getCartBooks().stream()
                .mapToDouble(book -> book.getPrice() * (100 - book.getDiscount()) / 100)
                .sum();
        return "₽" + String.format("%.2f", totalPrice);
    }

    public String totalPriceOld(){
        double totalPrice = bookService.getCartBooks().stream()
                .mapToDouble(BookDto::getPrice)
                .sum();
        return "₽" + String.format("%.2f", totalPrice);
    }
}
