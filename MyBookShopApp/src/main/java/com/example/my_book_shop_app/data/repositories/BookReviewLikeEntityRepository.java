package com.example.my_book_shop_app.data.repositories;

import com.example.my_book_shop_app.data.model.book.review.BookReviewLikeEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BookReviewLikeEntityRepository extends JpaRepository<BookReviewLikeEntity, Integer> {
    BookReviewLikeEntity findByReviewIdAndUserId(int reviewId, Long userId);

    List<BookReviewLikeEntity> findAllByReviewId(Integer reviewId);
}