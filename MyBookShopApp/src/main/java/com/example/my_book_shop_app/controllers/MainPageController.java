package com.example.my_book_shop_app.controllers;

import com.example.my_book_shop_app.data.services.BookService;
import com.example.my_book_shop_app.dto.BookDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.util.List;

@Controller
public class MainPageController {

    private final BookService bookService;

//    private boolean check = false;

    @Autowired
    public MainPageController(BookService bookService) {
        this.bookService = bookService;
    }

    @ModelAttribute("recommendedBooks")
    public List<BookDto> recommendedBooks(){
        return bookService.getRecommendedBooks();
    }
    @ModelAttribute("recentBooks")
    public List<BookDto> recentBooks(){
        return bookService.getRecentBooks();
    }
    @ModelAttribute("popularBooks")
    public List<BookDto> popularBooks(){
        return bookService.getPopularBooks();
    }

    @GetMapping("/")
    public String mainPage() {
//        if(!check) {
//            authorService.generateRandomAuthors(250);
//            bookService.generateRandomBooks(1000);
//            check = true;
//            book2AuthorService.generateRandomBook2AuthorEntities();
//        }
        return "index";
    }
}
