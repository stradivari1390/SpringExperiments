package com.example.my_book_shop_app.data.repositories;

import com.example.my_book_shop_app.data.model.book.links.Book2UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface Book2UserEntityRepository extends JpaRepository<Book2UserEntity, Integer> {

    Book2UserEntity findByUserIdAndBookId(Long userId, Long bookId);

    List<Book2UserEntity> findAllByTypeId(int i);
}