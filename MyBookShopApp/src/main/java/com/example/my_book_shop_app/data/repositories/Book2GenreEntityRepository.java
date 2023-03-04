package com.example.my_book_shop_app.data.repositories;

import com.example.my_book_shop_app.data.model.book.links.Book2GenreEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface Book2GenreEntityRepository extends JpaRepository<Book2GenreEntity, Integer> {
}