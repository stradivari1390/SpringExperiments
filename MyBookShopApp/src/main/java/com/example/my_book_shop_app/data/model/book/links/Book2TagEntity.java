package com.example.my_book_shop_app.data.model.book.links;

import lombok.*;

import jakarta.persistence.*;

@NoArgsConstructor
@Data
@Entity
@Table(name = "book2tag_entity", indexes = {
        @Index(name = "idx_book2tagentity_bookid_unq", columnList = "bookId, tagId", unique = true)
})
public class Book2TagEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer id;

    @Column(nullable = false)
    Integer tagId;

    @Column(nullable = false)
    Long bookId;
}
