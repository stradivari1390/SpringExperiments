package com.example.my_book_shop_app.data.repositories;

import com.example.my_book_shop_app.data.model.Author;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.web.bind.annotation.RequestParam;

public interface AuthorRepository extends JpaRepository<Author, Long> {
    Author findBySlug(String slug);

    @Query(value = "SELECT COUNT(b.id) " +
            "FROM Book b " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id " +
            "WHERE a.slug = :slug")
    int countBooksByAuthorSlug(@RequestParam("slug") String slug);
}