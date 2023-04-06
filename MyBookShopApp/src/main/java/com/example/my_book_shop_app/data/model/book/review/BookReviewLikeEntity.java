package com.example.my_book_shop_app.data.model.book.review;

import lombok.*;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@NoArgsConstructor
@Data
@Entity
@Table(name = "book_review_like", indexes = {
        @Index(name = "idx_bookreviewlikeentity", columnList = "reviewId"),
        @Index(name = "idx_bookreviewlikeentity_unq", columnList = "reviewId, userId", unique = true)
})
public class BookReviewLikeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(columnDefinition = "INT NOT NULL")
    private int reviewId;

    @Column(columnDefinition = "BIGINT NOT NULL")
    private Long userId;

    @Column(columnDefinition = "TIMESTAMP NOT NULL")
    private LocalDateTime time;

    @Column(columnDefinition = "SMALLINT NOT NULL")
    private short value;
}
