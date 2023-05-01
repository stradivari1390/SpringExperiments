package com.example.my_book_shop_app.data.repositories;

import com.example.my_book_shop_app.data.model.Book;
import com.example.my_book_shop_app.dto.BookDto;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.lang.NonNull;

import java.time.LocalDate;
import java.util.List;

public interface BookRepository extends JpaRepository<Book, Long> {
    Book findBySlug(String slug);

    String SELECT_BOOK_DTO = "SELECT new com.example.my_book_shop_app.dto.BookDto" +
            "(b.id, b.slug, b.title, b.image, b.description, b.price, b.discount, " +
            "b.isBestseller, b.rating, b.publicationDate, a.firstName, a.lastName, a.slug) ";

    @Query(value = SELECT_BOOK_DTO +
            "FROM Book b " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id " +
            "WHERE b.slug in :slug")
    List<BookDto> findAllBookDtoBySlug(@Param("slug") String[] slug);

    @Query(value = SELECT_BOOK_DTO +
            "FROM Book b " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id")
    List<BookDto> getBooksDto();

    @Query(value = SELECT_BOOK_DTO +
            "FROM Book b " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id " +
            "WHERE a.slug = :slug")
    Page<BookDto> getPageOfBooksByAuthorSlug(@Param("slug") String slug, Pageable pageable);

    @Query(value = SELECT_BOOK_DTO +
            "FROM Book b " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id " +
            "WHERE b.price * (1 - b.discount) / 100 between :min and :max")
    Page<BookDto> getPageOfBooksByPriceBetween(@Param("min") Double min, @Param("max") Double max, Pageable pageable);

    @Query(value = SELECT_BOOK_DTO +
            "FROM Book b " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id " +
            "WHERE b.price * (1 - b.discount) / 100 between :searchPrice - 0.75 and :searchPrice + 0.75")
    Page<BookDto> getPageOfBooksByPriceIs(@Param("searchPrice") Double price, Pageable pageable);

    @Query(value = SELECT_BOOK_DTO +
            "FROM Book b " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id " +
            "where b.isBestseller = true")
    Page<BookDto> getPageOfBestsellers(Pageable pageable);

    @Query(value = SELECT_BOOK_DTO +
            "FROM Book b " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id " +
            "WHERE b.discount = (SELECT MAX(discount) FROM Book)")
    Page<BookDto> getPageOfBooksWithMaxDiscount(Pageable pageable);

    @Query(value = SELECT_BOOK_DTO +
            "FROM Book b " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id " +
            "WHERE LOWER(b.title) LIKE LOWER(CONCAT('%', :bookTitle, '%'))")
    Page<BookDto> getPageOfBooksByTitleContaining(@Param("bookTitle") String bookTitle, Pageable pageable);

    @Query(value = SELECT_BOOK_DTO +
            "FROM Book b " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id")
    Page<BookDto> getPageOfBooksDto(Pageable pageable);

    @Query(value = SELECT_BOOK_DTO +
            "FROM Book b " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id " +
            "JOIN Book2GenreEntity bg ON b.id = bg.bookId " +
            "WHERE bg.genreId IN (" +
            "   SELECT bg2.genreId " +
            "   FROM Book2UserEntity b2u " +
            "   JOIN Book2UserTypeEntity bt ON b2u.typeId = bt.id " +
            "   JOIN Book2GenreEntity bg2 ON b2u.bookId = bg2.bookId " +
            "   WHERE b2u.userId = :userId" +
            ") " +
            "AND NOT EXISTS (" +
            "   SELECT b2u2 " +
            "   FROM Book2UserEntity b2u2 " +
            "   JOIN Book2UserTypeEntity bt2 ON b2u2.typeId = bt2.id " +
            "   WHERE b2u2.bookId = b.id " +
            "   AND b2u2.userId = :userId " +
            "   AND bt2.name = 'purchased'" +
            ") " +
            "GROUP BY b.id, a.firstName, a.lastName, a.slug " +
            "ORDER BY SUM(" +
            "   CASE WHEN EXISTS (" +
            "       SELECT b2u3 " +
            "       FROM Book2UserEntity b2u3 " +
            "       WHERE b2u3.bookId = b.id " +
            "       AND b2u3.userId = :userId " +
            "       AND b2u3.typeId = (SELECT bt2.id FROM Book2UserTypeEntity bt2 WHERE bt2.code = 'postponed')" +
            ") THEN 1 ELSE 0 END) DESC, b.id DESC")
    Page<BookDto> getPageOfRecommendedBooksDto(@Param("userId") Long userId, Pageable pageable);

    @Query(value = SELECT_BOOK_DTO +
            "FROM Book b " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id " +
            "WHERE b.publicationDate BETWEEN :fromDate AND :toDate " +
            "ORDER BY b.publicationDate DESC")
    Page<BookDto> getPageOfRecentBooksDto(Pageable pageable, @Param("fromDate") LocalDate fromDate, @Param("toDate") LocalDate toDate);

    @Query(value = SELECT_BOOK_DTO +
            "FROM Book b " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id " +
            "ORDER BY b.popularity DESC")
    Page<BookDto> getPageOfPopularBooksDto(Pageable pageable);

    @Query(value = SELECT_BOOK_DTO +
            "FROM Book b " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id " +
            "JOIN Book2UserEntity b2u ON b.id = b2u.bookId " +
            "JOIN Book2UserTypeEntity bt ON b2u.typeId = bt.id " +
            "WHERE bt.name = 'postponed' " +
            "AND b2u.userId = :userId")
    Page<BookDto> getPageOfPostponedBooks(@Param("userId") Long userId, Pageable pageable);

    @Query(value = SELECT_BOOK_DTO +
            "FROM Book b " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id " +
            "JOIN Book2UserEntity b2u ON b.id = b2u.bookId " +
            "JOIN Book2UserTypeEntity bt ON b2u.typeId = bt.id " +
            "WHERE bt.name = 'in_cart' " +
            "AND b2u.userId = :userId")
    Page<BookDto> getPageOfBooksInCart(@Param("userId") Long userId, Pageable pageable);

    @Query(value = SELECT_BOOK_DTO +
            "FROM Book b " +
            "JOIN Book2TagEntity bt ON b.id = bt.bookId " +
            "JOIN TagEntity t ON bt.tagId = t.id " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id " +
            "WHERE t.name = :tagName")
    Page<BookDto> getPageOfBooksByTagName(@Param("tagName") String tagName, Pageable pageable);

    @Query(value = SELECT_BOOK_DTO +
            "FROM Book b " +
            "JOIN Book2GenreEntity bg ON b.id = bg.bookId " +
            "JOIN GenreEntity g ON bg.genreId = g.id " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id " +
            "WHERE g.slug = :slug")
    Page<BookDto> getPageOfBooksByGenreSlug(@Param("slug") String genreSlug, Pageable nextPage);

    @Query(value = "SELECT SUM(b.price) " +
            "FROM Book b " +
            "JOIN Book2UserEntity b2u ON b.id = b2u.bookId " +
            "JOIN Book2UserTypeEntity bt ON b2u.typeId = bt.id " +
            "WHERE bt.name = 'in_cart' AND b2u.userId = :userId")
    Double getTotalCartBooksPrice(@Param("userId") long userId);

    @Query(value = "SELECT SUM(b.price * (1 - b.discount / 100.0)) " +
            "FROM Book b " +
            "JOIN Book2UserEntity b2u ON b.id = b2u.bookId " +
            "JOIN Book2UserTypeEntity bt ON b2u.typeId = bt.id " +
            "WHERE bt.name = 'in_cart' AND b2u.userId = :userId")
    Double getTotalCartBooksDiscountPrice(@Param("userId") long userId);

    @Query(value = "SELECT COUNT(b) " +
            "FROM Book b " +
            "JOIN Book2UserEntity b2u ON b.id = b2u.bookId " +
            "JOIN Book2UserTypeEntity bt ON b2u.typeId = bt.id " +
            "WHERE bt.name = 'purchased' AND b.slug = :bookSlug")
    int getPurchasesCount(@Param("bookSlug") String bookSlug);

    @Query(value = "SELECT COUNT(b) " +
            "FROM Book b " +
            "JOIN Book2UserEntity b2u ON b.id = b2u.bookId " +
            "JOIN Book2UserTypeEntity bt ON b2u.typeId = bt.id " +
            "WHERE bt.name = 'in_cart' AND b.slug = :bookSlug")
    int getInCartCount(@Param("bookSlug") String bookSlug);

    @Query(value = "SELECT COUNT(b) " +
            "FROM Book b " +
            "JOIN Book2UserEntity b2u ON b.id = b2u.bookId " +
            "JOIN Book2UserTypeEntity bt ON b2u.typeId = bt.id " +
            "WHERE bt.name = 'postponed' AND b.slug = :bookSlug")
    int getPostponesCount(@Param("bookSlug") String bookSlug);

    @Query(value = SELECT_BOOK_DTO +
            "FROM Book b " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id " +
            "WHERE b.slug = :slug")
    BookDto findBookDtoBySlug(@Param("slug") String slug);

    @Query(value = "SELECT b " +
            "FROM Book b " +
            "JOIN BookReviewEntity br ON b.id = br.bookId " +
            "WHERE br.id = :reviewId")
    Book findByReviewId(@Param("reviewId") Integer reviewId);

    @Query(value = SELECT_BOOK_DTO +
            "FROM Book2UserTypeEntity b2ut " +
            "JOIN Book2UserEntity b2u ON b2ut.id = b2u.typeId " +
            "JOIN Book b ON b.id = b2u.bookId " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id " +
            "WHERE b2u.userId = :userId AND b2ut.name = :relation")
    @NonNull
    List<BookDto> findAllBooksDtoByUserIdAndRelation(@Param("userId") Long userId, @Param("relation") String relation);

    @Query(value = SELECT_BOOK_DTO +
            "FROM Book b " +
            "JOIN Book2AuthorEntity ba ON b.id = ba.bookId " +
            "JOIN Author a ON ba.authorId = a.id " +
            "WHERE a.firstName = :token")
    List<BookDto> findAllBooksDtoByAuthorFirstName(@Param("token") String token);
}