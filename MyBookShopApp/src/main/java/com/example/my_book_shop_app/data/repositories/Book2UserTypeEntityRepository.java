package com.example.my_book_shop_app.data.repositories;

import com.example.my_book_shop_app.data.model.book.links.Book2UserTypeEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface Book2UserTypeEntityRepository extends JpaRepository<Book2UserTypeEntity, Integer> {
    Book2UserTypeEntity findByName(String name);

    @Query(value = "SELECT b2ut.name FROM Book2UserTypeEntity b2ut " +
                    "JOIN Book2UserEntity b2u on b2ut.id = b2u.typeId " +
                    "WHERE b2u.bookId = :bookId and b2u.userId = :userId")
    Optional<String> findTypeNameByBookIdAndUserId(@Param("bookId") Long bookId, @Param("userId") Long userId);
}