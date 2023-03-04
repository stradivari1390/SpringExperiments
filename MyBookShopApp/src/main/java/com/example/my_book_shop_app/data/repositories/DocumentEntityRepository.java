package com.example.my_book_shop_app.data.repositories;

import com.example.my_book_shop_app.data.model.other.DocumentEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DocumentEntityRepository extends JpaRepository<DocumentEntity, Integer> {
}