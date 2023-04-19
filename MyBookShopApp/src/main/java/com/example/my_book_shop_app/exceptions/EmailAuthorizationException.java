package com.example.my_book_shop_app.exceptions;

public class EmailAuthorizationException extends RuntimeException {
    public EmailAuthorizationException(String message) {
        super(message);
    }
}
