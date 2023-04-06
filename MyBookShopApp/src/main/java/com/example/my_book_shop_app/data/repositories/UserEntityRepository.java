package com.example.my_book_shop_app.data.repositories;

import com.example.my_book_shop_app.data.model.user.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface UserEntityRepository extends JpaRepository<UserEntity, Integer> {

    @Query(value = "select u from UserEntity u " +
                   "JOIN UserContactEntity uc on u.id = uc.userId " +
                   "WHERE uc.contact = :contact")
    UserEntity findByEmailOrPhoneNumber(@Param("contact") String emailOrPhoneNumber);

    UserEntity findUserByUsername(String username);
}