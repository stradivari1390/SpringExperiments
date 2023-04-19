package com.example.my_book_shop_app.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class UserDto {
    private Long id;
    private double balance;
    private String name;
    private String username;
    private String email;
    private String phone;
    private List<BookDto> postponedBooks;
    private List<BookDto> cartBooks;
    private List<BookDto> purchasedBooks;
    private List<BookDto> archivedBooks;

    public UserDto(Long id, double balance, String name, String username, String email, String phone) {
        this.id = id;
        this.balance = balance;
        this.name = name;
        this.username = username;
        this.email = email;
        this.phone = phone;
    }
}
