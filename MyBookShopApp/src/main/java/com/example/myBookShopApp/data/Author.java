package com.example.myBookShopApp.data;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@EqualsAndHashCode
@ToString
public class Author {
    private int id;
    private String firstName;
    private String lastName;
}