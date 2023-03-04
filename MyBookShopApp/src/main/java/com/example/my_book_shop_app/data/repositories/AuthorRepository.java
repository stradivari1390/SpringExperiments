package com.example.my_book_shop_app.data.repositories;

import com.example.my_book_shop_app.data.model.Author;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AuthorRepository extends JpaRepository<Author, Long> {
}