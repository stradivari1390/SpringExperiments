package com.example.my_book_shop_app.data.model.book.links;

import lombok.*;

import jakarta.persistence.*;

@NoArgsConstructor
@Data
@Entity
@Table(name = "book2author", indexes = {
        @Index(name = "idx_book2authorentity_unq", columnList = "bookId, authorId", unique = true)
})
public class Book2AuthorEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(columnDefinition = "BIGINT NOT NULL")
    private Long bookId;

    @Column(columnDefinition = "BIGINT NOT NULL")
    private Long authorId;

    @Column(columnDefinition = "INT NOT NULL  DEFAULT 0")
    private int sortIndex;
}
