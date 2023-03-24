package com.example.my_book_shop_app.controllers;

import com.example.my_book_shop_app.dto.BooksPageDto;
import com.example.my_book_shop_app.services.SearchingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class SearchController {

    private final SearchingService searchingService;

    @Autowired
    public SearchController(SearchingService searchingService) {
        this.searchingService = searchingService;
    }

    @GetMapping(value = {"/search", "/search/{query}"})
    public String getSearchResults(@PathVariable(value = "query", required = false) String query,
                                   @RequestParam(name = "offset", defaultValue = "0") int offset,
                                   @RequestParam(name = "limit", defaultValue = "20") int limit,
                                   Model model) {
        model.addAttribute("query", query);
        model.addAttribute("foundBooks", searchingService.search(query, offset, limit));
        return "/search/index";
    }

    @GetMapping("/search/page/{query}")
    @ResponseBody
    public BooksPageDto getNextSearchPage(@RequestParam("offset") Integer offset,
                                          @RequestParam("limit") Integer limit,
                                          @PathVariable(value = "query", required = false) String query) {
        return searchingService.getNextSearchPage(query, offset, limit);
    }
}