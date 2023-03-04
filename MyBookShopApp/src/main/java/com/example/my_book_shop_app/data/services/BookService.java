package com.example.my_book_shop_app.data.services;

import com.example.my_book_shop_app.data.model.Book;
import com.example.my_book_shop_app.data.repositories.BookRepository;
import com.example.my_book_shop_app.dto.BookDto;
import com.github.javafaker.Faker;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.*;

@Service
public class BookService {

    private final BookRepository bookRepository;

    @Autowired
    public BookService(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    public void generateRandomBooks(int amount) {
        List<Book> books = new ArrayList<>();
        Random random = new Random();
        Faker faker = new Faker(new Locale("en"));
        for (int i = 0; i < amount; i++) {
            Book book = new Book();
            book.setPublicationDate(LocalDate.now().minusDays(random.nextInt(365 * 10)));
            book.setIsBestseller(random.nextBoolean());
            book.setSlug(UUID.randomUUID().toString());
            book.setTitle(faker.book().title());
            book.setImage("/assets/img/content/main/card2.jpg");
            book.setDescription("This is a description of Book " + book.getTitle());
            book.setPrice((random.nextInt(5000) + 100) + random.nextDouble());
            book.setDiscount(random.nextInt(51));
            books.add(book);
        }
        bookRepository.saveAll(books);
    }

    public List<Book> getBooksData() {
        return bookRepository.findAll();
    }

    public List<BookDto> getBooks() {
        return bookRepository.getBooksDto();
    }

    public List<BookDto> getRecentBooks() {
        return getBooks().subList(0, 23);
    }

    public List<BookDto> getPopularBooks() {
        return getBooks().subList(23, 46);
    }

    public List<BookDto> getRecommendedBooks() {
        return getBooks().subList(46, 69);
    }

    public List<BookDto> getPostponedBooks() {
        return getBooks().subList(0, 3);
    }

    public List<BookDto> getCartBooks() {
        return getBooks().subList(3, 6);
    }
}