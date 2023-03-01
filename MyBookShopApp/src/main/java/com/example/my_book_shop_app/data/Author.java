package com.example.my_book_shop_app.data;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@EqualsAndHashCode
@ToString
public class Author {
    private Integer id;
    private String firstName;
    private String lastName;
}