package com.example.my_book_shop_app.data.repositories;

import com.example.my_book_shop_app.data.model.book.review.BookRateEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface BookRateEntityRepository extends JpaRepository<BookRateEntity, Long> {

    @Query(value = "SELECT COALESCE(AVG(br.value), 0.0) " +
            "FROM BookRateEntity br " +
            "JOIN Book b ON b.id = br.bookId " +
            "WHERE b.slug = :slug")
    double getRatingByBookSlug(@Param("slug") String slug);

    @Query(value = "SELECT br " +
            "FROM BookRateEntity br " +
            "JOIN Book b ON b.id = br.bookId " +
            "WHERE b.slug = :slug")
    List<BookRateEntity> findAllByBookSlug(@Param("slug") String slug);

    @Query(value = "SELECT COUNT(br) " +
            "FROM BookRateEntity br " +
            "JOIN Book b ON b.id = br.bookId " +
            "WHERE b.slug = :slug")
    Integer countByBookSlug(@Param("slug") String slug);
}