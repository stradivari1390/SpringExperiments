package com.example.my_book_shop_app.dto;

import com.example.my_book_shop_app.data.Book;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ResponseData {
    private List<Book> booksFound;
}
