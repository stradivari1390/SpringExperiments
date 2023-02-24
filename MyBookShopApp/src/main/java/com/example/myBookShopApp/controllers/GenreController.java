package com.example.myBookShopApp.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/bookshop")
public class GenreController {

    @GetMapping("/genres")
    public String showAuthors() {
        return "genres";
    }
}