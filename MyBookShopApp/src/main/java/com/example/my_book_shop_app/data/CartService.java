package com.example.my_book_shop_app.data;

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

    public List<Book> cartBooks(){
        return bookService.getCartBooks();
    }

    public String totalPrice() {
        double totalPrice = bookService.getCartBooks().stream()
                .mapToDouble(book -> Double.parseDouble(book.getPrice().substring(1)))
                .sum();
        return "₽" + String.format("%.2f", totalPrice);
    }

    public String totalPriceOld(){
        double totalPrice = bookService.getCartBooks().stream()
                .mapToDouble(book -> Double.parseDouble(book.getPriceOld().substring(1)))
                .sum();
        return "₽" + String.format("%.2f", totalPrice);
    }
}
