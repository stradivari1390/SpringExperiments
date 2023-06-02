package com.example.my_book_shop_app.data;

import com.example.my_book_shop_app.data.model.Book;
import com.example.my_book_shop_app.data.repositories.BookRepository;
import com.example.my_book_shop_app.dto.BookDto;

import org.junit.jupiter.api.Test;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.test.context.TestPropertySource;

import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Logger;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;

@SpringBootTest
@TestPropertySource("/application-test.properties")
class BookRepositoryTests {

    private final BookRepository bookRepository;

    @Autowired
    public BookRepositoryTests(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    @Test
    void findBooksByAuthorFirstName() {
        String token = "Carlo";
        List<BookDto> bookListByAuthorFirstName = bookRepository.findAllBooksDtoByAuthorFirstName(token);

        assertNotNull(bookListByAuthorFirstName);
        assertFalse(bookListByAuthorFirstName.isEmpty());

        for (BookDto book : bookListByAuthorFirstName){
            Logger.getLogger(this.getClass().getSimpleName()).info(book.toString());
            assertThat(book.getAuthorFirstName()).contains(token);
        }
    }

    @Test
    void findBooksByTitleContaining() {
        String token = "Tiger";
        Page<BookDto> bookPageByTitleContaining = bookRepository.getPageOfBooksByTitleContaining(token, Pageable.ofSize(10));
        assertNotNull(bookPageByTitleContaining);
        assertFalse(bookPageByTitleContaining.isEmpty());
        for (BookDto book : bookPageByTitleContaining){
            Logger.getLogger(this.getClass().getSimpleName()).info(book.toString());
            assertThat(book.getTitle()).contains(token);
        }
    }

    @Test
    void getBestsellers() {
        Page<BookDto> bestSellersBooks = bookRepository.getPageOfBestsellers(Pageable.ofSize(10));
        assertNotNull(bestSellersBooks);
        assertFalse(bestSellersBooks.isEmpty());
        assertThat(bestSellersBooks).hasSizeGreaterThan(1);
    }

    @Test
    void findBySlug() {
        String slug = "40e431d5-0c15-46c4-9385-3f1520154725";
        Book book = bookRepository.findBySlug(slug);

        assertThat(book).isNotNull();
        assertThat(book.getSlug()).isEqualTo(slug);
    }

    @Test
    void findAllBookDtoBySlug() {
        String[] slugs = {"30fc92c9-1ffc-4044-b5df-5a5619200e8d", "98272068-5aa9-4018-9727-eb7f7fbc31c0"};
        List<BookDto> books = bookRepository.findAllBookDtoBySlug(slugs);

        assertThat(books)
                .isNotEmpty()
                .hasSize(slugs.length);
        assertThat(books.stream().map(BookDto::getSlug)).containsAll(Arrays.asList(slugs));
    }

    @Test
    void getPageOfRecentBooksDto() {
        LocalDate fromDate = LocalDate.of(2023,2,15);
        LocalDate toDate = LocalDate.of(2023,4,15);
        Page<BookDto> recentBooks = bookRepository.getPageOfRecentBooksDto(PageRequest.of(0, 10), fromDate, toDate);

        assertThat(recentBooks).isNotEmpty();
        for (BookDto book : recentBooks) {
            assertThat(book.getPublicationDate()).isAfterOrEqualTo(fromDate).isBeforeOrEqualTo(toDate);
        }
    }

    @Test
    void getPageOfPopularBooksDto() {
        Page<BookDto> popularBooks = bookRepository.getPageOfPopularBooksDto(PageRequest.of(0, 10));

        assertThat(popularBooks).isNotEmpty();
    }

    @Test
    void getPageOfBooksInCart() {
        Long userId = 1L;
        Page<BookDto> booksInCart = bookRepository.getPageOfBooksInCart(userId, PageRequest.of(0, 10));

        assertThat(booksInCart).isNotEmpty();
    }

    @Test
    void getPageOfBooksByTagName() {
        String tagName = "classic literature";
        Page<BookDto> booksByTagName = bookRepository.getPageOfBooksByTagName(tagName, PageRequest.of(0, 10));

        assertThat(booksByTagName).isNotEmpty();
    }

    @Test
    void getPageOfBooksByGenreSlug() {
        String genreSlug = "31ae1914-8689-48bd-8d38-36bd705c5a34";
        Page<BookDto> booksByGenreSlug = bookRepository.getPageOfBooksByGenreSlug(genreSlug, PageRequest.of(0, 10));

        assertThat(booksByGenreSlug).isNotEmpty();
    }

    @Test
    void getTotalCartBooksPrice() {
        long userId = 1L;
        Double totalCartBooksPrice = bookRepository.getTotalCartBooksPrice(userId);

        assertThat(totalCartBooksPrice)
                .isNotNull()
                .isNotNegative();
    }
}