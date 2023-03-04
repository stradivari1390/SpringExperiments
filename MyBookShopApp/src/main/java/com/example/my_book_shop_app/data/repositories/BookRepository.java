package com.example.my_book_shop_app.data.repositories;

import com.example.my_book_shop_app.data.model.Book;
import com.example.my_book_shop_app.dto.BookDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface BookRepository extends JpaRepository<Book, Long> {

    @Query(value = "SELECT new com.example.my_book_shop_app.dto.BookDto(b.id, b.title, b.image, b.description, b.price, b.discount, a.firstName, a.lastName) " +
            "FROM Book b " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id")
    List<BookDto> getBooksDto();
}