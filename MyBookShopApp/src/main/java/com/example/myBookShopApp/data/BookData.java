package com.example.myBookShopApp.data;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@EqualsAndHashCode
@ToString
public class BookData {
    private int id;
    private String title;
    private String authorFirstName;
    private String authorLastName;
    private int priceOld;
    private int price;
}