package com.example.my_book_shop_app.data.repositories;

import com.example.my_book_shop_app.data.model.book.file.BookFileTypeEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BookFileTypeEntityRepository extends JpaRepository<BookFileTypeEntity, Integer> {
}