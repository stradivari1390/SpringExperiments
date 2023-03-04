package com.example.my_book_shop_app.data.repositories;

import com.example.my_book_shop_app.data.model.genre.GenreEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface GenreEntityRepository extends JpaRepository<GenreEntity, Integer> {
}