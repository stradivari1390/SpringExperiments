package com.example.my_book_shop_app.controllers;

import com.example.my_book_shop_app.data.services.BookService;
import com.example.my_book_shop_app.dto.BookDto;
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
    public List<BookDto> postponedBooks(){
        return bookService.getPostponedBooks();
    }

    @GetMapping("/postponed")
    public String postponedPage() {
        return "postponed";
    }
}
