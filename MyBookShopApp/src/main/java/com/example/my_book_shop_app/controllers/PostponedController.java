package com.example.my_book_shop_app.controllers;

import com.example.my_book_shop_app.data.Book;
import com.example.my_book_shop_app.data.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.util.List;

@Controller
public class PostponedController {

    private final BookService bookService;

    @Autowired
    public PostponedController(BookService bookService) {
        this.bookService = bookService;
    }

    @ModelAttribute("postponedBooks")
    public List<Book> postponedBooks(){
        return bookService.getPostponedBooks();
    }

    @GetMapping("/postponed")
    public String postponedPage() {
        return "postponed";
    }
}
