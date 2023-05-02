package com.example.my_book_shop_app.data.repositories;

import com.example.my_book_shop_app.data.model.enums.ContactType;
import com.example.my_book_shop_app.data.model.user.UserContactEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface UserContactEntityRepository extends JpaRepository<UserContactEntity, Integer> {

    Optional<UserContactEntity> findByUserIdAndType(Long userId, ContactType type);

    Optional<UserContactEntity> findByContact(String contact);

    void deleteAllByUserId(Long userId);

    @Query(value = "SELECT uc.contact " +
            "FROM UserContactEntity uc " +
            "WHERE uc.type = :type AND uc.userId = (SELECT uce.userId FROM UserContactEntity uce WHERE uce.contact = :contact)")
    String getUserEmailByContact(@Param("contact") String contact, @Param("type") ContactType type);
}