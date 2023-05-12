package com.example.my_book_shop_app.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class BalanceTransactionDto {

    private int id;
    private Long userId;
    private long time;
    private double value;
    private Long bookId;
    private String description;
}