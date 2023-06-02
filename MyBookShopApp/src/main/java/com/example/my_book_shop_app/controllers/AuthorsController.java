package com.example.my_book_shop_app.controllers;

import com.example.my_book_shop_app.data.model.Author;
import com.example.my_book_shop_app.security.security_services.AuthenticationService;
import com.example.my_book_shop_app.security.security_services.BookstoreUserDetailsService;
import com.example.my_book_shop_app.services.AuthorService;
import com.example.my_book_shop_app.services.BookService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class AuthorsController {

    private final AuthorService authorService;
    private final BookService bookService;
    private final BookstoreUserDetailsService bookstoreUserDetailsService;
    private final AuthenticationService authenticationService;

    @ModelAttribute("authorsMap")
    public Map<String, List<Author>> authorsMap(){
        return authorService.getAuthorsMap();
    }

    @GetMapping("/authors")
    public String authorsPage(Model model, Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated()) {
            model.addAttribute("authStatus", "authorized");
            model.addAttribute("curUsr", bookstoreUserDetailsService.getUserDtoById(authenticationService.getCurrentUser().getId()));
        } else {
            model.addAttribute("authStatus", "unauthorized");
        }
        return "/authors/index";
    }

    @GetMapping("/authors/{slug}")
    public String authorSlugPage(@RequestParam(value = "offset", defaultValue = "0") Integer offset,
                            @RequestParam(value = "limit", defaultValue = "10") Integer limit,
                            @PathVariable("slug") String slug, Model model) {
        model.addAttribute("author", authorService.getAuthorBySlug(slug));
        model.addAttribute("booksAmount", authorService.countAuthorsBooks(slug));
        model.addAttribute("booksPageByAuthor", bookService.getPageOfBooksByAuthor(slug, offset, limit).getContent());
        return "authors/slug";
    }
}
