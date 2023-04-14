package com.example.my_book_shop_app.data.repositories;

import com.example.my_book_shop_app.data.model.enums.ContactType;
import com.example.my_book_shop_app.data.model.user.UserContactEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.lang.Nullable;

public interface UserContactEntityRepository extends JpaRepository<UserContactEntity, Integer> {
    @Nullable
    UserContactEntity findByUserIdAndType(Long userId, ContactType type);
}