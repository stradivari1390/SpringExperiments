package com.example.my_book_shop_app.services;

import com.example.my_book_shop_app.data.model.Book;
import com.example.my_book_shop_app.data.model.book.review.BookReviewEntity;
import com.example.my_book_shop_app.data.model.book.review.BookReviewLikeEntity;
import com.example.my_book_shop_app.data.repositories.BookReviewEntityRepository;
import com.example.my_book_shop_app.data.repositories.BookReviewLikeEntityRepository;
import com.example.my_book_shop_app.dto.BookReviewDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Comparator;
import java.util.List;

@Service
public class ReviewService {
    
    private final BookReviewEntityRepository bookReviewEntityRepository;
    private final BookReviewLikeEntityRepository bookReviewLikeEntityRepository;
    private final BookService bookService;

    @Autowired
    public ReviewService(BookReviewEntityRepository bookReviewEntityRepository,
                         BookReviewLikeEntityRepository bookReviewLikeEntityRepository,
                         BookService bookService) {
        this.bookReviewEntityRepository = bookReviewEntityRepository;
        this.bookReviewLikeEntityRepository = bookReviewLikeEntityRepository;
        this.bookService = bookService;
    }

    public List<BookReviewDto> getReviewDtoListByBookSlug(String bookSlug) {
        List<BookReviewDto> reviewDtoList = bookReviewEntityRepository.findReviewDtoByBookSlug(bookSlug);
        reviewDtoList.sort(Comparator.comparing(BookReviewDto::getTime).reversed());
        return reviewDtoList;
    }

    public boolean addReviewLike(Integer reviewId, Short value, Long userId) {
        BookReviewLikeEntity bookReviewLikeEntity = bookReviewLikeEntityRepository.findByReviewIdAndUserId(reviewId, userId);
        if (bookReviewLikeEntity != null) {
            return false;
        }
        bookReviewLikeEntity = new BookReviewLikeEntity();
        bookReviewLikeEntity.setReviewId(reviewId);
        bookReviewLikeEntity.setTime(LocalDateTime.now());
        bookReviewLikeEntity.setValue(value);
        bookReviewLikeEntity.setUserId(userId);
        bookReviewLikeEntityRepository.save(bookReviewLikeEntity);
        return true;
    }

    public boolean saveReview(String bookSlug, Long userId, String reviewText) {
        Book book = bookService.getBookBySlug(bookSlug);
        if (book == null || bookReviewEntityRepository.findByBookIdAndUserId(book.getId(), userId) != null) {
            return false;
        }
        BookReviewEntity review = new BookReviewEntity();
        review.setBookId(book.getId());
        review.setUserId(userId);
        review.setTime(LocalDateTime.now());
        review.setText(reviewText);
        bookReviewEntityRepository.save(review);
        return true;
    }
}
