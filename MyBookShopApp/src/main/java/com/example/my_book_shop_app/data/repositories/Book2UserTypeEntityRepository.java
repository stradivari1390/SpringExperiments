package com.example.my_book_shop_app.data.repositories;

import com.example.my_book_shop_app.data.model.book.links.Book2UserTypeEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface Book2UserTypeEntityRepository extends JpaRepository<Book2UserTypeEntity, Integer> {
    Book2UserTypeEntity findByName(String name);
}