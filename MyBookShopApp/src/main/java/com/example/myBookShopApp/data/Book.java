package com.example.myBookShopApp.data;

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
    private Integer authorId;
    private String title;
    private Integer priceOld;
    private Integer price;
}