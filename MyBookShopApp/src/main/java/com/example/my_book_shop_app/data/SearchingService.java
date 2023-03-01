package com.example.my_book_shop_app.data;

import com.example.my_book_shop_app.dto.ResponseData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SearchingService {

    private final BookService bookService;

    @Autowired
    public SearchingService(BookService bookService) {
        this.bookService = bookService;
    }

    public ResponseData search(String query, int offset, int limit) {
        return new ResponseData(bookService.getBooksData().subList(0, 4));
    }
}