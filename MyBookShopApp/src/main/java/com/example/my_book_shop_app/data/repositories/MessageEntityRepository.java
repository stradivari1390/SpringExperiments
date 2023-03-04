package com.example.my_book_shop_app.data.repositories;

import com.example.my_book_shop_app.data.model.book.review.MessageEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MessageEntityRepository extends JpaRepository<MessageEntity, Integer> {
}