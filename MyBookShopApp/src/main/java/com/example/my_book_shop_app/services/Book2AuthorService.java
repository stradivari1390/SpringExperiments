package com.example.my_book_shop_app.services;

import com.example.my_book_shop_app.data.model.book.links.Book2AuthorEntity;
import com.example.my_book_shop_app.data.repositories.Book2AuthorEntityRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class Book2AuthorService {

    private final Book2AuthorEntityRepository book2AuthorRepository;

    @Autowired
    public Book2AuthorService(Book2AuthorEntityRepository book2AuthorRepository) {
        this.book2AuthorRepository = book2AuthorRepository;
    }

    public List<Book2AuthorEntity> getBook2AuthorEntities() {
        return book2AuthorRepository.findAll();
    }
}