package com.example.my_book_shop_app.data.services;

import com.example.my_book_shop_app.dto.SearchResponseData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SearchingService {

    private final BookService bookService;

    @Autowired
    public SearchingService(BookService bookService) {
        this.bookService = bookService;
    }

    public SearchResponseData search(String query, int offset, int limit) {
        return new SearchResponseData(bookService.getBooks().subList(0, 4));
    }
}