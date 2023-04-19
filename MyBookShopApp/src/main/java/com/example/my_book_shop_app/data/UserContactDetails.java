package com.example.my_book_shop_app.data;

import com.example.my_book_shop_app.data.model.enums.ContactType;

public record UserContactDetails(long userId, ContactType contactType, String contact, short approved) {
}