package com.example.my_book_shop_app.data.model;

import lombok.*;

import jakarta.persistence.*;
import java.time.LocalDate;

@NoArgsConstructor
@Data
@Entity
@Table(name = "books", indexes = {
        @Index(name = "idx_book_price", columnList = "price"),
        @Index(name = "idx_book_discount", columnList = "discount"),
        @Index(name = "idx_book_is_bestseller", columnList = "is_bestseller"),
        @Index(name = "idx_book_pub_date", columnList = "pub_date"),
        @Index(name = "idx_book_title", columnList = "title")
})
public class Book {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "book_id_seq")
    @SequenceGenerator(name = "book_id_seq", sequenceName = "book_id_seq", allocationSize = 1)
    private Long id;

    @Column(name = "pub_date", nullable = false)
    private LocalDate publicationDate;

    @Column(name = "is_bestseller", nullable = false)
    private boolean isBestseller;

    @Column(name = "slug", nullable = false, unique = true)
    private String slug;

    @Column(name = "title", nullable = false)
    private String title;

    @Column(name = "image")
    private String image;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "price", nullable = false)
    private double price;

    @Column(name = "discount", nullable = false)
    private int discount;

    @Column(name = "popularity")
    private double popularity;

    @Column(name = "rating")
    private short rating;

    private int quantity;

    @Version
    private int version;
}