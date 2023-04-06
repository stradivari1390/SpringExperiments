package com.example.my_book_shop_app.security;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class ContactConfirmationPayload {
    private String contact;
    private String code;
}