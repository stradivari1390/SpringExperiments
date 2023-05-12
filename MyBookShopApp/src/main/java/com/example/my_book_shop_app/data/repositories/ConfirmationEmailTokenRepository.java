package com.example.my_book_shop_app.data.repositories;

import com.example.my_book_shop_app.data.model.user.ConfirmationEmailToken;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ConfirmationEmailTokenRepository extends JpaRepository<ConfirmationEmailToken, Long> {
    ConfirmationEmailToken findByToken(String token);
}