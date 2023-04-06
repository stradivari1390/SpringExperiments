package com.example.my_book_shop_app.data.model.book.links;

import lombok.*;

import jakarta.persistence.*;

@NoArgsConstructor
@Data
@Entity
@Table(name = "book2genre", indexes = {
        @Index(name = "idx_book2genreentity_unq", columnList = "bookId, genreId", unique = true)
})
public class Book2GenreEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(columnDefinition = "BIGINT NOT NULL")
    private Long bookId;

    @Column(columnDefinition = "INT NOT NULL")
    private int genreId;
}
