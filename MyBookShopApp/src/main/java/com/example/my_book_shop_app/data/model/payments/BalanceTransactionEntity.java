package com.example.my_book_shop_app.data.model.payments;

import lombok.*;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@NoArgsConstructor
@Data
@Entity
@Table(name = "balance_transaction", indexes = {
        @Index(name = "idx_balancetransactionentity", columnList = "userId, bookId")
})
public class BalanceTransactionEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(columnDefinition = "BIGINT NOT NULL")
    private Long userId;

    @Column(columnDefinition = "TIMESTAMP NOT NULL")
    private LocalDateTime time;

    @Column(columnDefinition = "DOUBLE PRECISION NOT NULL DEFAULT 0.0")
    private double value;

    @Column(columnDefinition = "BIGINT NOT NULL")
    private Long bookId;

    @Column(columnDefinition = "TEXT NOT NULL")
    private String description;
}
