package com.example.my_book_shop_app.data.repositories;

import com.example.my_book_shop_app.data.model.book.review.BookReviewEntity;
import com.example.my_book_shop_app.dto.BookReviewDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface BookReviewEntityRepository extends JpaRepository<BookReviewEntity, Integer> {

    @Query(value = "SELECT new com.example.my_book_shop_app.dto.BookReviewDto(br.id, br.bookId, u.name, br.time, " +
            "br.text, (SELECT COUNT(brl) FROM BookReviewLikeEntity brl WHERE brl.reviewId = br.id AND brl.value = 1), " +
            "(SELECT COUNT(brl) FROM BookReviewLikeEntity brl WHERE brl.reviewId = br.id AND brl.value = -1)) " +
            "FROM BookReviewEntity br " +
            "JOIN UserEntity u ON br.userId = u.id " +
            "JOIN Book b ON br.bookId = b.id " +
            "WHERE b.slug = :slug")
    List<BookReviewDto> findReviewDtoByBookSlug(@Param("slug") String slug);

    BookReviewEntity findByBookIdAndUserId(Long bookId, Long userId);
}