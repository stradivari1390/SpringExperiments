package com.example.my_book_shop_app.data.model.book.review;

import lombok.*;

import jakarta.persistence.*;

@NoArgsConstructor
@Data
@Entity
@Table(name = "book_rate", indexes = {
        @Index(name = "idx_rateentity_bookid_userid", columnList = "bookId, userId")
})
public class BookRateEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column
    private Long bookId;

    @Column
    private Long userId;

    @Column
    private short value;
}