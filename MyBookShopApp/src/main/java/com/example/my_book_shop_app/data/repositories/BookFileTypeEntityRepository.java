package com.example.my_book_shop_app.data.repositories;

import com.example.my_book_shop_app.data.model.book.file.BookFileTypeEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface BookFileTypeEntityRepository extends JpaRepository<BookFileTypeEntity, Integer> {

    @Query(value = "SELECT bft.name " +
            "FROM BookFileTypeEntity bft " +
            "JOIN BookFileEntity bf ON bft.id = bf.fileType " +
            "JOIN Book b ON bf.bookId = b.id " +
            "WHERE b.slug = :slug")
    List<String> findAllByBookSlug(@Param("slug") String bookSlug);
}