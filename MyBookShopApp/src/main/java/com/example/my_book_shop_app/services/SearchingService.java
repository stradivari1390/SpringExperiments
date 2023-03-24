package com.example.my_book_shop_app.services;

import com.example.my_book_shop_app.dto.BookDto;
import com.example.my_book_shop_app.dto.BooksPageDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SearchingService {

    private final BookService bookService;

    @Autowired
    public SearchingService(BookService bookService) {
        this.bookService = bookService;
    }

    public List<BookDto> search(String query, int offset, int limit) {
        return bookService.getPageOfSearchResultBooks(query, offset, limit).getContent();
    }

    public BooksPageDto getNextSearchPage(String query, Integer offset, Integer limit) {
        return new BooksPageDto(bookService.getPageOfSearchResultBooks(query, offset, limit).getContent());
    }
}