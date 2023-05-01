package com.example.my_book_shop_app.services;

import com.example.my_book_shop_app.data.model.Book;
import com.example.my_book_shop_app.data.model.book.review.BookRateEntity;
import com.example.my_book_shop_app.data.repositories.BookRateEntityRepository;
import com.example.my_book_shop_app.data.repositories.BookRepository;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;

import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.atLeastOnce;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class BooksRatingAndPopularityServiceTest {

    @Mock
    private BookRepository bookRepository;

    @Mock
    private BookRateEntityRepository bookRateEntityRepository;

    @InjectMocks
    private BooksRatingAndPopularityService booksRatingAndPopularityService;

    private Book book;
    private BookRateEntity bookRateEntity;

    @BeforeEach
    void setUp() {
        book = new Book();
        book.setId(1L);
        book.setSlug("test-book");

        bookRateEntity = new BookRateEntity();
        bookRateEntity.setBookId(1L);
        bookRateEntity.setUserId(1L);
        bookRateEntity.setValue((short) 4);
    }

    @Test
    void updatePopularity() {
        List<Book> books = Collections.singletonList(book);
        when(bookRepository.findAll(any(Pageable.class))).thenReturn(new PageImpl<>(books));

        booksRatingAndPopularityService.updatePopularity();

        verify(bookRepository, atLeastOnce()).save(any(Book.class));
    }

    @Test
    void calculateRating() {
        when(bookRateEntityRepository.getRatingByBookSlug(book.getSlug())).thenReturn(4.0);
        short rating = booksRatingAndPopularityService.calculateRating(book);

        assertEquals(4, rating);
    }

    @Test
    void calculateStarRatesByBookSlug() {
        List<BookRateEntity> bookRateEntities = Collections.singletonList(bookRateEntity);
        when(bookRateEntityRepository.findAllByBookSlug(book.getSlug())).thenReturn(bookRateEntities);

        Map<Short, Integer> starRates = booksRatingAndPopularityService.calculateStarRatesByBookSlug(book.getSlug());

        assertEquals(1, starRates.size());
        assertEquals(1, (int) starRates.get((short) 4));
    }

    @Test
    void countRatesByBookSlug() {
        when(bookRateEntityRepository.countByBookSlug(book.getSlug())).thenReturn(1);

        Integer count = booksRatingAndPopularityService.countRatesByBookSlug(book.getSlug());

        assertEquals(1, count);
    }

    @Test
    void addRating() {
        when(bookRepository.findById(book.getId())).thenReturn(java.util.Optional.ofNullable(book));

        booksRatingAndPopularityService.addRating(book.getId(), 1L, (short) 4);

        verify(bookRateEntityRepository, times(1)).save(any(BookRateEntity.class));
        verify(bookRepository, times(1)).save(any(Book.class));
    }
}