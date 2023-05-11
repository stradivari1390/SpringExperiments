package com.example.my_book_shop_app.data.model.payments;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@NoArgsConstructor
@Data
@Entity
@Table(name = "balance_transaction", indexes = {
        @Index(name = "idx_balancetransactionentity", columnList = "userId")
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

    @Column(columnDefinition = "BIGINT")
    private Long bookId;

    @Column(columnDefinition = "TEXT NOT NULL")
    private String description;
}
