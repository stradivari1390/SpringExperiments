package com.example.my_book_shop_app.data.repositories;

import com.example.my_book_shop_app.data.model.user.UserEntity;
import com.example.my_book_shop_app.dto.UserDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface UserEntityRepository extends JpaRepository<UserEntity, Integer> {

    @Query(value = "select u from UserEntity u " +
                   "JOIN UserContactEntity uc on u.id = uc.userId " +
                   "WHERE uc.contact = :contact")
    UserEntity findByContacts(@Param("contact") String emailOrPhoneNumber);

    UserEntity findUserByUsername(String username);

    @Query(value = "select new com.example.my_book_shop_app.dto.UserDto(u.balance, u.name, u.username, uce.contact, ucp.contact) " +
            "from UserEntity u " +
            "JOIN UserContactEntity uce ON u.id = uce.userId AND uce.type = 'EMAIL' " +
            "JOIN UserContactEntity ucp ON u.id = ucp.userId AND ucp.type = 'PHONE' " +
            "WHERE u.id = :id")
    UserDto findUserDtoById(@Param("id") Long id);
}