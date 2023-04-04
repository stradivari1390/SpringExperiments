package com.example.my_book_shop_app.services;

import com.example.my_book_shop_app.data.model.Author;

import com.example.my_book_shop_app.data.repositories.AuthorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class AuthorService {

    private final AuthorRepository authorRepository;

    @Autowired
    public AuthorService(AuthorRepository authorRepository) {
        this.authorRepository = authorRepository;
    }

    public Map<String, List<Author>> getAuthorsMap() {
        List<Author> authors = authorRepository.findAll();
        return authors.stream().collect(Collectors.groupingBy((Author a) -> a.getLastName().substring(0,1)));
    }

    public List<Author> getAuthors() {
        return authorRepository.findAll();
    }

    public Author getAuthorBySlug(String slug) {
        return authorRepository.findBySlug(slug);
    }

    public int countAuthorsBooks(String slug) {
        return authorRepository.countBooksByAuthorSlug(slug);
    }

    public Author getAuthorByBookSlug(String bookSlug) {
        return authorRepository.findAuthorByBookSlug(bookSlug);
    }
}