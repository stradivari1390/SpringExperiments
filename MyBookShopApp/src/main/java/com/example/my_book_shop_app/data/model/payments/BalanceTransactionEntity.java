package com.example.my_book_shop_app.data.model.payments;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Objects;

@Getter
@Setter
@ToString
@NoArgsConstructor
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

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof BalanceTransactionEntity)) {
            return false;
        }
        BalanceTransactionEntity that = (BalanceTransactionEntity) o;
        return getId() == that.getId() &&
                getUserId().equals(that.getUserId()) &&
                getValue() == that.getValue() &&
                getBookId().equals(that.getBookId()) &&
                getTime().equals(that.getTime()) &&
                getDescription().equals(that.getDescription());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getUserId(), getTime(),
                getValue(), getBookId(), getDescription());
    }
}
