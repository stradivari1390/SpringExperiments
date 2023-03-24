package com.example.my_book_shop_app.data.repositories;

import com.example.my_book_shop_app.data.model.book.links.Book2TagEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface Book2TagEntityRepository extends JpaRepository<Book2TagEntity, Integer> {
}