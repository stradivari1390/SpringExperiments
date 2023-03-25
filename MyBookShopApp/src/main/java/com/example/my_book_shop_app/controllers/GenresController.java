package com.example.my_book_shop_app.controllers;

import com.example.my_book_shop_app.services.BookService;
import com.example.my_book_shop_app.services.GenreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class GenresController {

    private final BookService bookService;
    private final GenreService genreService;

    @Autowired
    public GenresController(BookService bookService, GenreService genreService) {
        this.bookService = bookService;
        this.genreService = genreService;
    }

    @GetMapping("/genres")
    public String genresPage(Model model) {
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
