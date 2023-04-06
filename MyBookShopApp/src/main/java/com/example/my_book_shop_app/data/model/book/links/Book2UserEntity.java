package com.example.my_book_shop_app.data.model.book.links;

import lombok.*;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@NoArgsConstructor
@Data
@Entity
@Table(name = "book2user", indexes = {
        @Index(name = "idx_book2userentity_bookid", columnList = "bookId, userId, typeId")
})
public class Book2UserEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(columnDefinition = "TIMESTAMP NOT NULL")
    private LocalDateTime time;

    @Column(columnDefinition = "INT NOT NULL")
    private int typeId;

    @Column(columnDefinition = "BIGINT NOT NULL")
    private Long bookId;

    @Column(columnDefinition = "INT NOT NULL")
    private Long userId;
}
