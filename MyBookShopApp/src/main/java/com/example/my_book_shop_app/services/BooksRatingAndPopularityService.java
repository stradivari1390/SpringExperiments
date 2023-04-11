package com.example.my_book_shop_app.services;

import com.example.my_book_shop_app.data.model.Book;
import com.example.my_book_shop_app.data.model.book.review.BookRateEntity;
import com.example.my_book_shop_app.data.repositories.BookRateEntityRepository;
import com.example.my_book_shop_app.data.repositories.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.OptimisticLockingFailureException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class BooksRatingAndPopularityService {

    private final BookRepository bookRepository;
    private final BookRateEntityRepository bookRateEntityRepository;

    @Autowired
    public BooksRatingAndPopularityService(BookRepository bookRepository,
                                           BookRateEntityRepository bookRateEntityRepository) {
        this.bookRepository = bookRepository;
        this.bookRateEntityRepository = bookRateEntityRepository;
    }

    @Scheduled(fixedRate = 1000*60*60*24, initialDelay = 1000*60*60)
    @Transactional(isolation = Isolation.REPEATABLE_READ)
    public void updatePopularity() {
        int pageNumber = 0;
        int pageSize = 1000;
        Pageable pageable = PageRequest.of(pageNumber, pageSize, Sort.by("id"));

        Page<Book> bookPage;
        do {
            bookPage = bookRepository.findAll(pageable);
            for (Book book : bookPage) {
                double popularity = calculatePopularity(book);
                book.setPopularity(popularity);
                saveBookWithOptimisticLocking(book);
            }
            pageable = pageable.next();
        } while (bookPage.hasNext());
    }

    private void saveBookWithOptimisticLocking(Book book) {
        int maxAttempts = 5;
        for (int attempt = 1; attempt <= maxAttempts; attempt++) {
            try {
                bookRepository.save(book);
                break;
            } catch (OptimisticLockingFailureException e) {
                if (attempt == maxAttempts) {
                    throw e;
                }
                Long bookId = book.getId();
                book = bookRepository.findById(bookId).orElseThrow(() ->
                        new IllegalStateException("Book not found: " + bookId));
                double newPopularity = calculatePopularity(book);
                book.setPopularity(newPopularity);
            }
        }
    }

    private double calculatePopularity(Book book) {
        double purchasedWeight = 1.0;
        double inCartWeight = 0.7;
        double postponedWeight = 0.4;

        return purchasedWeight * bookRepository.getPurchasesCount(book.getSlug())
                + inCartWeight * bookRepository.getInCartCount(book.getSlug())
                + postponedWeight * bookRepository.getPostponesCount(book.getSlug());
    }

    public short calculateRating(Book book) {
        return (short) (Math.round(bookRateEntityRepository.getRatingByBookSlug(book.getSlug())));
    }

    public Map<Short, Integer> calculateStarRatesByBookSlug(String slug) {
        List<BookRateEntity> bookRateEntityList = bookRateEntityRepository.findAllByBookSlug(slug);
        return bookRateEntityList.stream()
                .collect(Collectors.groupingBy(BookRateEntity::getValue, Collectors.counting()))
                .entrySet()
                .stream()
                .collect(Collectors.toMap(Map.Entry::getKey, e -> e.getValue().intValue()));
    }

    public Integer countRatesByBookSlug(String slug) {
        return bookRateEntityRepository.countByBookSlug(slug);
    }

    @Transactional
    public void addRating(Long bookId, Long userId, Short value) {
        BookRateEntity bookRateEntity = new BookRateEntity();
        bookRateEntity.setBookId(bookId);
        bookRateEntity.setUserId(userId);
        bookRateEntity.setValue(value);
        bookRateEntityRepository.save(bookRateEntity);

        Book book = bookRepository.findById(bookId).orElse(null);
        if (book != null) {
            short rating = calculateRating(book);
            book.setRating(rating);
            bookRepository.save(book);
        }
    }
}
