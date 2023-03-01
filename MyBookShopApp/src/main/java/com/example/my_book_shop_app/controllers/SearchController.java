package com.example.my_book_shop_app.controllers;

import com.example.my_book_shop_app.data.SearchingService;
import com.example.my_book_shop_app.dto.ResponseData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class SearchController {

    private final SearchingService searchingService;

    @Autowired
    public SearchController(SearchingService searchingService) {
        this.searchingService = searchingService;
    }

    @GetMapping(value = "/search")
    public String searchPage(@RequestParam(name = "query", required = false) String query,
                                    @RequestParam(name = "offset", defaultValue = "0") int offset,
                                    @RequestParam(name = "limit", defaultValue = "20") int limit, Model model) {
        ResponseData response = searchingService.search(query, offset, limit);
        if (!response.getBooksFound().isEmpty()) {
            model.addAttribute("foundBooks", response.getBooksFound());
        }
        return "search/index";
    }
}