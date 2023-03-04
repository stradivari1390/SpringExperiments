package com.example.my_book_shop_app.data.repositories;

import com.example.my_book_shop_app.data.model.other.FaqEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FaqEntityRepository extends JpaRepository<FaqEntity, Integer> {
}