package com.example.my_book_shop_app.services;

import com.example.my_book_shop_app.dto.BookDto;
import com.example.my_book_shop_app.dto.BooksPageDto;
import com.example.my_book_shop_app.errors.EmptySearchException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.InvalidDataAccessResourceUsageException;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

@Service
public class SearchingService {

    private final BookService bookService;

    @Autowired
    public SearchingService(BookService bookService) {
        this.bookService = bookService;
    }

    public Page<BookDto> search(String query, int offset, int limit) throws EmptySearchException {
        try {
            return bookService.getPageOfSearchResultBooks(query, offset, limit);
        } catch(InvalidDataAccessResourceUsageException e) {
            throw new EmptySearchException("insert request query");
        }
    }

    public BooksPageDto getNextSearchPage(String query, Integer offset, Integer limit)  throws EmptySearchException {
        try {
            return new BooksPageDto(bookService.getPageOfSearchResultBooks(query, offset, limit));
        } catch(InvalidDataAccessResourceUsageException e) {
            throw new EmptySearchException("insert request query");
        }
    }
}