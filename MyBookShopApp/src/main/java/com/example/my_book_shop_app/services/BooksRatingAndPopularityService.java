package com.example.my_book_shop_app.services;

import com.example.my_book_shop_app.data.model.Book;
import com.example.my_book_shop_app.data.repositories.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BooksRatingAndPopularityService {

    private final BookRepository bookRepository;

    @Autowired
    public BooksRatingAndPopularityService(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    @Scheduled(fixedRate = 3600000)
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

        return purchasedWeight * bookRepository.getPurchasesCount(book.getId())
                + inCartWeight * bookRepository.getInCartCount(book.getId())
                + postponedWeight * bookRepository.getPostponesCount(book.getId());
    }
}
