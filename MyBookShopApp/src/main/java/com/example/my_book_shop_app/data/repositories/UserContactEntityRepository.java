package com.example.my_book_shop_app.data.repositories;

import com.example.my_book_shop_app.data.model.user.UserContactEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserContactEntityRepository extends JpaRepository<UserContactEntity, Integer> {
}