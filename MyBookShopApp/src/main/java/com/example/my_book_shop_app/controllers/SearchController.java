package com.example.my_book_shop_app.controllers;

import com.example.my_book_shop_app.dto.BooksPageDto;
import com.example.my_book_shop_app.errors.EmptySearchException;
import com.example.my_book_shop_app.services.SearchingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.logging.Logger;

@Controller
public class SearchController {

    private final SearchingService searchingService;

    @Autowired
    public SearchController(SearchingService searchingService) {
        this.searchingService = searchingService;
    }

    @GetMapping(value = {"/search"})
    public String getSearchResults(@RequestParam(name = "query", required = false) String query,
                                   @RequestParam(name = "offset", defaultValue = "0") int offset,
                                   @RequestParam(name = "limit", defaultValue = "10") int limit,
                                   Model model) throws EmptySearchException {
        model.addAttribute("query", query);
        model.addAttribute("foundBooks", new BooksPageDto(searchingService.search(query, offset, limit)));
        return "search/index";
    }

    @GetMapping("/search/page")
    @ResponseBody
    public BooksPageDto getNextSearchPage(@RequestParam("offset") Integer offset,
                                          @RequestParam("limit") Integer limit,
                                          @RequestParam(name = "query", required = false) String query) throws EmptySearchException {
        return searchingService.getNextSearchPage(query, offset, limit);
    }

    @ExceptionHandler(EmptySearchException.class)
    public String handleEmptySearchException(EmptySearchException e, RedirectAttributes redirectAttributes){
        Logger.getLogger(this.getClass().getSimpleName()).warning(e.getLocalizedMessage());
        redirectAttributes.addFlashAttribute("searchError", e);
        return "redirect:/";
    }
}