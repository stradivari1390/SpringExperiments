package com.example.my_book_shop_app.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Book2UserDto {
    String slug;
    String image;
    double price;
    int discount;
    boolean bestseller;
    String title;
    String authorSlug;
    String authorFirstName;
    String authorLastName;
    String relation;
}
