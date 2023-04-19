package com.example.my_book_shop_app.controllers;

import com.example.my_book_shop_app.security.security_services.BookstoreUserDetailsService;
import com.example.my_book_shop_app.security.security_services.BookstoreUserRegister;
import com.example.my_book_shop_app.services.BookService;
import com.example.my_book_shop_app.dto.BookDto;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Controller
public class MainPageController {

    private final BookService bookService;
    private final BookstoreUserRegister bookstoreUserRegister;
    private final BookstoreUserDetailsService bookstoreUserDetailsService;

    @Autowired
    public MainPageController(BookService bookService, BookstoreUserRegister bookstoreUserRegister,
                              BookstoreUserDetailsService bookstoreUserDetailsService) {
        this.bookService = bookService;
        this.bookstoreUserRegister = bookstoreUserRegister;
        this.bookstoreUserDetailsService = bookstoreUserDetailsService;
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
                           Model model, Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated()) {
            model.addAttribute("authStatus", "authorized");
            model.addAttribute("recommendedBooks",
                    bookService.getPageOfRecommendedBooks(bookstoreUserRegister.getCurrentUser().getId(), offset, limit).getContent());
            model.addAttribute("curUsr", bookstoreUserDetailsService.getUserDtoById(bookstoreUserRegister.getCurrentUser().getId()));
        } else {
            model.addAttribute("authStatus", "unauthorized");
        }
        model.addAttribute("recentBooks",
                bookService.getPageOfRecentBooks(offset, limit, LocalDate.now().minusYears(3), LocalDate.now()).getContent());
        model.addAttribute("popularBooks",
                bookService.getPageOfPopularBooks(offset, limit).getContent());
        model.addAttribute("fromDate", LocalDate.now().minusMonths(1));
        model.addAttribute("toDate", LocalDate.now());
        return "index";
    }
}
