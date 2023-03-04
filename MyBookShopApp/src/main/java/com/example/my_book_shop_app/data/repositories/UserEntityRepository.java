package com.example.my_book_shop_app.data.repositories;

import com.example.my_book_shop_app.data.model.user.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserEntityRepository extends JpaRepository<UserEntity, Integer> {
}