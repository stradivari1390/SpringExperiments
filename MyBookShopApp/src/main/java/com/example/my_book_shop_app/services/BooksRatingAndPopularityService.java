package com.example.my_book_shop_app.services;

import com.example.my_book_shop_app.data.model.Book;
import com.example.my_book_shop_app.data.model.book.review.BookRateEntity;
import com.example.my_book_shop_app.data.repositories.BookRateEntityRepository;
import com.example.my_book_shop_app.data.repositories.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
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

//    @Transactional
    @Scheduled(fixedRate = 1000*60*60*24, initialDelay = 1000*60*60)
    public void updatePopularity() {
        List<Book> books = bookRepository.findAll();
        for (Book book : books) {
            double popularity = calculatePopularity(book);
            book.setPopularity(popularity);
        }
        bookRepository.saveAll(books);
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

    public void addRating(Long bookId, Short value) {
        BookRateEntity bookRateEntity = new BookRateEntity();
        bookRateEntity.setBookId(bookId);
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
