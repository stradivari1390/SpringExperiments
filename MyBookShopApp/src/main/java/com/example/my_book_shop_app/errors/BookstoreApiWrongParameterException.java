package com.example.my_book_shop_app.errors;

public class BookstoreApiWrongParameterException extends Exception {
    public BookstoreApiWrongParameterException(String message) {
        super(message);
    }
}