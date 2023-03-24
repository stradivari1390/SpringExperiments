package com.example.my_book_shop_app.data.model;

import lombok.*;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.Objects;


@Getter
@Setter
@ToString
@NoArgsConstructor
@Entity
@Table(name = "books", indexes = {
        @Index(name = "idx_book_price_discount", columnList = "price, discount"),
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
    private Boolean isBestseller;

    @Column(name = "slug", nullable = false, unique = true)
    private String slug;

    @Column(name = "title", nullable = false)
    private String title;

    @Column(name = "image")
    private String image;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "price", nullable = false)
    private Double price;

    @Column(name = "discount", nullable = false)
    private Integer discount;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Book)) return false;
        Book book = (Book) o;
        return getId().equals(book.getId()) &&
                getTitle().equals(book.getTitle()) &&
                getPrice().equals(book.getPrice());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getTitle(), getPrice());
    }
}