package com.example.my_book_shop_app.controllers;

import com.example.my_book_shop_app.services.BookService;
import com.example.my_book_shop_app.dto.BookDto;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Controller
public class MainPageController {

    private final BookService bookService;


    @Autowired
    public MainPageController(BookService bookService) {
        this.bookService = bookService;
    }

    @ModelAttribute("query")
    public String query() {
        return "";
    }
    @ModelAttribute("searchResults")
    public List<BookDto> searchResults() {
        return new ArrayList<>();
    }

    @GetMapping("/")
    public String mainPage(@RequestParam(value = "offset", defaultValue = "0") Integer offset,
                           @RequestParam(value = "limit", defaultValue = "10") Integer limit,
                           Model model) {
        model.addAttribute("recommendedBooks", bookService.getPageOfRecommendedBooks(440L, offset, limit).getContent());
        model.addAttribute("recentBooks", bookService.getPageOfRecentBooks(offset, limit, LocalDate.now().minusYears(3), LocalDate.now()).getContent());
        model.addAttribute("popularBooks", bookService.getPageOfPopularBooks(offset, limit).getContent());
        return "index";
    }
}
