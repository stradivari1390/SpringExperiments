package com.example.my_book_shop_app.errors;

public class EmptySearchException extends Exception {
    public EmptySearchException(String message) {
        super(message);
    }
}