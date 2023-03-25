package com.example.my_book_shop_app.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class BooksPageDto {

    @ApiModelProperty("The number of books in the list")
    private Integer count;

    @ApiModelProperty("A list of books")
    private List<BookDto> books;

    public BooksPageDto(List<BookDto> books) {
        this.books = books;
        this.count = books.size();
    }
}