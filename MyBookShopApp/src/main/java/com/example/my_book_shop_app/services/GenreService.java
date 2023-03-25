package com.example.my_book_shop_app.services;

import com.example.my_book_shop_app.data.model.genre.GenreEntity;
import com.example.my_book_shop_app.data.repositories.GenreEntityRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Comparator;
import java.util.List;

@Service
public class GenreService {

    private final GenreEntityRepository genreEntityRepository;

    @Autowired
    public GenreService(GenreEntityRepository genreEntityRepository) {
        this.genreEntityRepository = genreEntityRepository;
    }

    public List<GenreEntity> getGenresList() {
        List<GenreEntity> genres = genreEntityRepository.findAll();
        genres.sort(Comparator.comparing(GenreEntity::getName));
        return genres;
    }

    public GenreEntity getGenreBySlug(String slug) {
        return genreEntityRepository.findBySlug(slug);
    }
}