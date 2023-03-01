package com.example.my_book_shop_app.controllers;

import com.example.my_book_shop_app.data.Book;
import com.example.my_book_shop_app.data.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.util.List;

@Controller
public class MainPageController {

    private final BookService bookService;

    @Autowired
    public MainPageController(BookService bookService) {
        this.bookService = bookService;
    }

    @ModelAttribute("recommendedBooks")
    public List<Book> recommendedBooks(){
        return bookService.getRecommendedBooks();
    }
    @ModelAttribute("recentBooks")
    public List<Book> recentBooks(){
        return bookService.getRecentBooks();
    }
    @ModelAttribute("popularBooks")
    public List<Book> popularBooks(){
        return bookService.getPopularBooks();
    }

    @GetMapping("/")
    public String mainPage(){
        return "index";
    }
}
