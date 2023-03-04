package com.example.my_book_shop_app.data.services;

import com.example.my_book_shop_app.data.model.Author;
import com.example.my_book_shop_app.data.model.Book;
import com.example.my_book_shop_app.data.model.book.links.Book2AuthorEntity;
import com.example.my_book_shop_app.data.repositories.AuthorRepository;
import com.example.my_book_shop_app.data.repositories.Book2AuthorEntityRepository;
import com.example.my_book_shop_app.data.repositories.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class Book2AuthorService {
    private final BookRepository bookRepository;
    private final AuthorRepository authorRepository;
    private final Book2AuthorEntityRepository book2AuthorRepository;

    @Autowired
    public Book2AuthorService(BookRepository bookRepository, AuthorRepository authorRepository,
                              Book2AuthorEntityRepository book2AuthorRepository) {
        this.bookRepository = bookRepository;
        this.authorRepository = authorRepository;
        this.book2AuthorRepository = book2AuthorRepository;
//        generateRandomBook2AuthorEntities();
    }

    public List<Book2AuthorEntity> getBook2AuthorEntities() {
        return book2AuthorRepository.findAll();
    }

    public void generateRandomBook2AuthorEntities() {
        List<Book2AuthorEntity> book2AuthorEntities = new ArrayList<>();
        List<Book> books = bookRepository.findAll();
        List<Author> authors = authorRepository.findAll();
        Random random = new Random();
        for (Book book : books) {
            Book2AuthorEntity book2AuthorEntity = new Book2AuthorEntity();
            book2AuthorEntity.setBookId(book.getId());
            Author author = authors.get(random.nextInt(authors.size()));
            book2AuthorEntity.setAuthorId(author.getId());
            book2AuthorEntity.setSortIndex(random.nextInt(100));
            book2AuthorEntities.add(book2AuthorEntity);
        }
        book2AuthorRepository.saveAll(book2AuthorEntities);
    }
}
