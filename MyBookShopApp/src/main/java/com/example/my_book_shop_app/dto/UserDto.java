package com.example.my_book_shop_app.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
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
    private List<BookDto> postponedBooks = new ArrayList<>();
    private List<BookDto> cartBooks = new ArrayList<>();
    private List<BookDto> purchasedBooks = new ArrayList<>();
    private List<BookDto> archivedBooks = new ArrayList<>();

    public UserDto(Long id, double balance, String name, String username, String email, String phone) {
        this.id = id;
        this.balance = balance;
        this.name = name;
        this.username = username;
        this.email = email;
        this.phone = phone;
    }
}
