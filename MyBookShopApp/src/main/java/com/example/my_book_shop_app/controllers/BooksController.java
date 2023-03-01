package com.example.my_book_shop_app.controllers;

import com.example.my_book_shop_app.data.Book;
import com.example.my_book_shop_app.data.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/books")
public class BooksController {

    private final BookService bookService;

    @Autowired
    public BooksController(BookService bookService) {
        this.bookService = bookService;
    }

    @GetMapping("/recent")
    public String recentBooksPage(Model model) {
        List<Book> recentBooks = bookService.getRecentBooks();
        model.addAttribute("recentBooks", recentBooks);
        return "books/recent";
    }

    @GetMapping("/popular")
    public String popularBooksPage(Model model) {
        List<Book> popularBooks = bookService.getPopularBooks();
        model.addAttribute("popularBooks", popularBooks);
        return "books/popular";
    }
}