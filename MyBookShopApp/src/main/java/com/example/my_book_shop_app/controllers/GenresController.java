package com.example.my_book_shop_app.controllers;

import com.example.my_book_shop_app.security.security_services.BookstoreUserDetailsService;
import com.example.my_book_shop_app.security.security_services.BookstoreUserRegister;
import com.example.my_book_shop_app.services.BookService;
import com.example.my_book_shop_app.services.GenreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class GenresController {

    private final BookService bookService;
    private final GenreService genreService;
    private final BookstoreUserDetailsService bookstoreUserDetailsService;
    private final BookstoreUserRegister bookstoreUserRegister;

    @Autowired
    public GenresController(BookService bookService, GenreService genreService,
                            BookstoreUserDetailsService bookstoreUserDetailsService,
                            BookstoreUserRegister bookstoreUserRegister) {
        this.bookService = bookService;
        this.genreService = genreService;
        this.bookstoreUserDetailsService = bookstoreUserDetailsService;
        this.bookstoreUserRegister = bookstoreUserRegister;
    }

    @GetMapping("/genres")
    public String genresPage(Model model, Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated()) {
            model.addAttribute("authStatus", "authorized");
            model.addAttribute("curUsr", bookstoreUserDetailsService.getUserDtoById(bookstoreUserRegister.getCurrentUser().getId()));
        } else {
            model.addAttribute("authStatus", "unauthorized");
        }
        model.addAttribute("genres", genreService.getGenresList());
        return "genres/index";
    }

    @GetMapping("/genres/{slug}")
    public String genrePage(@RequestParam(value = "offset", defaultValue = "0") Integer offset,
                            @RequestParam(value = "limit", defaultValue = "10") Integer limit,
                            @PathVariable("slug") String slug, Model model) {
        model.addAttribute("genre", genreService.getGenreBySlug(slug));
        model.addAttribute("booksPageByGenre", bookService.getPageOfBooksByGenre(slug, offset, limit).getContent());
        return "genres/slug";
    }
}
