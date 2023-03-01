package com.example.my_book_shop_app.data;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@EqualsAndHashCode
@ToString
public class Book {

    private Integer id;
    private String author;
    private String title;
    private String priceOld;
    private String price;
    private String discount;
}