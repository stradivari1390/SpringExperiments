package com.example.my_book_shop_app.data.repositories;

import com.example.my_book_shop_app.data.model.book.file.BookFileEntity;
import com.example.my_book_shop_app.dto.BookFileDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface BookFileEntityRepository extends JpaRepository<BookFileEntity, Long> {
    BookFileEntity findBookFileByHash(String hash);

    @Query(value = "SELECT new com.example.my_book_shop_app.dto.BookFileDto(bf.id, bf.bookId, bf.hash, bft.name, bf.path) " +
    "FROM BookFileEntity bf " +
    "join BookFileTypeEntity bft on bf.fileType = bft.id " +
    "join Book b on bf.bookId = b.id " +
    "where b.slug = :slug")
    List<BookFileDto> getBookFileDtoListByBookSlug(@Param("slug") String slug);
}