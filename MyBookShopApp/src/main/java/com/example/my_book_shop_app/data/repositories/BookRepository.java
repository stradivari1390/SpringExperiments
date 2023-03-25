package com.example.my_book_shop_app.data.repositories;

import com.example.my_book_shop_app.data.model.Book;
import com.example.my_book_shop_app.dto.BookDto;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface BookRepository extends JpaRepository<Book, Long> {

    @Query(value = "SELECT new com.example.my_book_shop_app.dto.BookDto(b.id, b.slug, b.title, b.image, " +
            "b.description, b.price, b.discount, a.firstName, a.lastName) " +
            "FROM Book b " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id")
    List<BookDto> getBooksDto();

    @Query(value = "SELECT new com.example.my_book_shop_app.dto.BookDto(b.id, b.slug, b.title, b.image, " +
            "b.description, b.price, b.discount, a.firstName, a.lastName) " +
            "FROM Book b " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id " +
            "WHERE a.firstName LIKE %:authorFirstName%")
    Page<BookDto> getPageOfBooksByAuthorFirstNameContaining(@Param("authorFirstName") String authorFirstName, Pageable pageable);

    @Query(value = "SELECT new com.example.my_book_shop_app.dto.BookDto(b.id, b.slug, b.title, b.image, " +
            "b.description, b.price, b.discount, a.firstName, a.lastName) " +
            "FROM Book b " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id " +
            "WHERE b.price * (1 - b.discount) / 100 between :min and :max")
    Page<BookDto> getPageOfBooksByPriceBetween(@Param("min") Double min, @Param("max") Double max, Pageable pageable);

    @Query(value = "SELECT new com.example.my_book_shop_app.dto.BookDto(b.id, b.slug, b.title, b.image, " +
            "b.description, b.price, b.discount, a.firstName, a.lastName) " +
            "FROM Book b " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id " +
            "WHERE b.price * (1 - b.discount) / 100 between :searchPrice - 0.75 and :searchPrice + 0.75")
    Page<BookDto> getPageOfBooksByPriceIs(@Param("searchPrice") Double price, Pageable pageable);

    @Query(value = "SELECT new com.example.my_book_shop_app.dto.BookDto(b.id, b.slug, b.title, b.image, " +
            "b.description, b.price, b.discount, a.firstName, a.lastName) " +
            "FROM Book b " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id " +
            "where b.isBestseller = true")
    Page<BookDto> getPageOfBestsellers(Pageable pageable);

    @Query(value = "SELECT new com.example.my_book_shop_app.dto.BookDto(b.id, b.slug, b.title, b.image, " +
            "b.description, b.price, b.discount, a.firstName, a.lastName) " +
            "FROM Book b " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id " +
            "WHERE b.discount = (SELECT MAX(discount) FROM Book)")
    Page<BookDto> getPageOfBooksWithMaxDiscount(Pageable pageable);

    @Query(value = "SELECT new com.example.my_book_shop_app.dto.BookDto(b.id, b.slug, b.title, b.image, " +
            "b.description, b.price, b.discount, a.firstName, a.lastName) " +
            "FROM Book b " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id " +
            "WHERE LOWER(b.title) LIKE LOWER(CONCAT('%', :bookTitle, '%'))")
    Page<BookDto> getPageOfBooksByTitleContaining(@Param("bookTitle") String bookTitle, Pageable pageable);

    @Query(value = "SELECT new com.example.my_book_shop_app.dto.BookDto(b.id, b.slug, b.title, b.image, " +
            "b.description, b.price, b.discount, a.firstName, a.lastName) " +
            "FROM Book b " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id")
    Page<BookDto> getPageOfBooksDto(Pageable pageable);

    @Query(value = "SELECT new com.example.my_book_shop_app.dto.BookDto(b.id, b.slug, b.title, b.image, " +
            "b.description, b.price, b.discount, a.firstName, a.lastName) " +
            "FROM Book b " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id " +
            "JOIN Book2GenreEntity bg ON b.id = bg.bookId " +
            "WHERE bg.genreId IN (" +
            "   SELECT bg2.genreId " +
            "   FROM Book2UserEntity b2u " +
            "   JOIN Book2UserTypeEntity bt ON b2u.typeId = bt.id " +
            "   JOIN Book2GenreEntity bg2 ON b2u.bookId = bg2.bookId " +
            "   WHERE bt.id IN (2, 3, 4) " +
            "   AND b2u.userId = :userId" +
            ") " +
            "AND NOT EXISTS (" +
            "   SELECT b2u2 " +
            "   FROM Book2UserEntity b2u2 " +
            "   WHERE b2u2.bookId = b.id " +
            "   AND b2u2.userId = :userId " +
            "   AND b2u2.typeId = 4" +
            ") " +
            "GROUP BY b.id, a.firstName, a.lastName " +
            "ORDER BY SUM(" +
            "   CASE WHEN EXISTS (" +
            "       SELECT b2u3 " +
            "       FROM Book2UserEntity b2u3 " +
            "       WHERE b2u3.bookId = b.id " +
            "       AND b2u3.userId = :userId " +
            "       AND b2u3.typeId = (SELECT bt2.id FROM Book2UserTypeEntity bt2 WHERE bt2.code = 'postponed')" +
            ") THEN 1 ELSE 0 END) DESC, b.id DESC")
    Page<BookDto> getPageOfRecommendedBooksDto(@Param("userId") Long userId, Pageable pageable);

    @Query(value = "SELECT new com.example.my_book_shop_app.dto.BookDto(b.id, b.slug, b.title, b.image, " +
            "b.description, b.price, b.discount, a.firstName, a.lastName) " +
            "FROM Book b " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id " +
            "WHERE b.publicationDate BETWEEN :fromDate AND :toDate " +
            "ORDER BY b.publicationDate DESC")
    Page<BookDto> getPageOfRecentBooksDto(Pageable pageable, @Param("fromDate") LocalDate fromDate, @Param("toDate") LocalDate toDate);

    @Query(value = "SELECT new com.example.my_book_shop_app.dto.BookDto(b.id, b.slug, b.title, b.image, " +
            "b.description, b.price, b.discount, a.firstName, a.lastName) " +
            "FROM Book b " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id " +
            "JOIN BalanceTransactionEntity t ON b.id = t.bookId " +
            "JOIN Book2UserEntity b2u ON b.id = b2u.bookId " +
            "JOIN Book2UserTypeEntity bt ON b2u.typeId = bt.id " +
            "LEFT JOIN BookReviewEntity br ON b.id = br.bookId " +
            "LEFT JOIN BookReviewLikeEntity brl ON br.id = brl.reviewId " +
            "WHERE bt.name IN ('postponed', 'purchased', 'in_cart') " +
            "GROUP BY b.id, a.firstName, a.lastName " +
            "ORDER BY (SUM(CASE WHEN bt.name = 'purchased' THEN 1 ELSE 0 END) + " +
            "0.7 * SUM(CASE WHEN bt.name = 'in_cart' THEN 1 ELSE 0 END) + " +
            "0.4 * SUM(CASE WHEN bt.name = 'postponed' THEN 1 ELSE 0 END)) DESC, " +
            "b.isBestseller DESC, SUM(COALESCE(brl.value, 0)) DESC")
    Page<BookDto> getPageOfPopularBooksDto(Pageable pageable);

    @Query(value = "SELECT new com.example.my_book_shop_app.dto.BookDto(b.id, b.slug, b.title, b.image, " +
            "b.description, b.price, b.discount, a.firstName, a.lastName) " +
            "FROM Book b " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id " +
            "JOIN Book2UserEntity b2u ON b.id = b2u.bookId " +
            "JOIN Book2UserTypeEntity bt ON b2u.typeId = bt.id " +
            "WHERE bt.id = 2 " +
            "AND b2u.userId = :userId")
    Page<BookDto> getPageOfPostponedBooks(@Param("userId") Long userId, Pageable pageable);

    @Query(value = "SELECT new com.example.my_book_shop_app.dto.BookDto(b.id, b.slug, b.title, b.image, " +
            "b.description, b.price, b.discount, a.firstName, a.lastName) " +
            "FROM Book b " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id " +
            "JOIN Book2UserEntity b2u ON b.id = b2u.bookId " +
            "JOIN Book2UserTypeEntity bt ON b2u.typeId = bt.id " +
            "WHERE bt.id = 3 " +
            "AND b2u.userId = :userId")
    Page<BookDto> getPageOfBooksInCart(@Param("userId") Long userId, Pageable pageable);

    @Query(value = "SELECT new com.example.my_book_shop_app.dto.BookDto(b.id, b.slug, b.title, b.image, " +
            "b.description, b.price, b.discount, a.firstName, a.lastName) " +
            "FROM Book b " +
            "JOIN Book2TagEntity bt ON b.id = bt.bookId " +
            "JOIN TagEntity t ON bt.tagId = t.id " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id " +
            "WHERE t.name = :tagName")
    Page<BookDto> getPageOfBooksByTagName(@Param("tagName") String tagName, Pageable pageable);

    @Query(value = "SELECT new com.example.my_book_shop_app.dto.BookDto(b.id, b.slug, b.title, b.image, " +
            "b.description, b.price, b.discount, a.firstName, a.lastName) " +
            "FROM Book b " +
            "JOIN Book2GenreEntity bg ON b.id = bg.bookId " +
            "JOIN GenreEntity g ON bg.genreId = g.id " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id " +
            "WHERE g.slug = :slug")
    Page<BookDto> getPageOfBooksByGenreSlug(@Param("slug") String genreSlug, Pageable nextPage);
}