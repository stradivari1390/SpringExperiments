package com.example.my_book_shop_app.data.model;

import lombok.*;

import jakarta.persistence.*;

@NoArgsConstructor
@Data
@Entity
@Table(name = "authors", indexes = {
        @Index(name = "idx_author_first_name", columnList = "first_name"),
        @Index(name = "idx_author_last_name", columnList = "last_name"),
        @Index(name = "idx_author_slug", columnList = "slug", unique = true)
})
public class Author {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "author_id_seq")
    @SequenceGenerator(name = "author_id_seq", sequenceName = "author_id_seq", allocationSize = 1)
    private Long id;

    @Column(name = "photo")
    private String photo;

    @Column(name = "slug", nullable = false)
    private String slug;

    @Column(name = "first_name", nullable = false)
    private String firstName;

    @Column(name = "last_name", nullable = false)
    private String lastName;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;
}