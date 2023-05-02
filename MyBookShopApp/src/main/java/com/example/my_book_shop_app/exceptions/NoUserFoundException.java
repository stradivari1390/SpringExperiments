package com.example.my_book_shop_app.exceptions;

import org.springframework.security.core.userdetails.UsernameNotFoundException;

public class NoUserFoundException extends UsernameNotFoundException {
    public NoUserFoundException(String message) {
        super(message);
    }
}