package com.example.my_book_shop_app.data.repositories;

import com.example.my_book_shop_app.data.model.book.review.BookReviewEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BookReviewEntityRepository extends JpaRepository<BookReviewEntity, Integer> {
}