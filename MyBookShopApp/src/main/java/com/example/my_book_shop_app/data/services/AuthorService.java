package com.example.my_book_shop_app.data.services;

import com.example.my_book_shop_app.data.model.Author;

import com.example.my_book_shop_app.data.repositories.AuthorRepository;
import com.github.javafaker.Faker;
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

    public void generateRandomAuthors(int amount) {
        List<Author> authors = new ArrayList<>();
        Faker faker = new Faker(new Locale("en"));
        for (int i = 0; i < amount; i++) {
            Author author = new Author();
            author.setPhoto("/spring-frontend/assets/img/content/main/card2.jpg");
            author.setSlug(UUID.randomUUID().toString());
            author.setFirstName(faker.name().firstName());
            author.setLastName(faker.name().lastName());
            author.setDescription(faker.lorem().sentence());
            authors.add(author);
        }
        authorRepository.saveAll(authors);
    }

    public Map<String, List<Author>> getAuthorsMap() {
        List<Author> authors = authorRepository.findAll();
        return authors.stream().collect(Collectors.groupingBy((Author a) -> a.getLastName().substring(0,1)));
    }

    public List<Author> getAuthors() {
        return authorRepository.findAll();
    }
}