package com.example.my_book_shop_app.controllers;

import com.example.my_book_shop_app.dto.BooksPageDto;
import com.example.my_book_shop_app.services.SearchingService;

import jakarta.validation.ConstraintViolationException;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import org.hibernate.validator.constraints.Length;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.stream.Collectors;

@Controller
@Validated
public class SearchController {

    private final SearchingService searchingService;

    @Autowired
    public SearchController(SearchingService searchingService) {
        this.searchingService = searchingService;
    }

    @GetMapping(value = {"/search"})
    public String getSearchResults(@NotEmpty(message = "Query must not be empty") @Size(min = 3, message = "query is too short") @RequestParam(name = "query") String query,
                                   @RequestParam(name = "offset", defaultValue = "0") int offset,
                                   @RequestParam(name = "limit", defaultValue = "10") int limit,
                                   Model model) {
        model.addAttribute("query", query);
        model.addAttribute("foundBooks", new BooksPageDto(searchingService.search(query, offset, limit)));
        return "search/index";
    }

    @GetMapping("/search/page")
    @ResponseBody
    public BooksPageDto getNextSearchPage(@RequestParam("offset") Integer offset,
                                          @RequestParam("limit") Integer limit,
                                          @NotEmpty(message = "Query must not be empty") @Length(min = 3, message = "query is too short") @RequestParam(name = "query") String query) {
        return searchingService.getNextSearchPage(query, offset, limit);
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<String> handleValidationExceptions(MethodArgumentNotValidException ex) {
        String errorMessage = ex.getBindingResult()
                .getAllErrors()
                .stream()
                .map(ObjectError::getDefaultMessage)
                .collect(Collectors.joining(", "));

        return ResponseEntity.badRequest().body(errorMessage);
    }

    @ExceptionHandler(ConstraintViolationException.class)
    public String handleValidationExceptions2() {
        return "redirect:/";
    }
}