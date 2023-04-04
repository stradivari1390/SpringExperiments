package com.example.my_book_shop_app.data.model.book.review;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;
import java.util.Objects;

@Getter
@Setter
@ToString
@NoArgsConstructor
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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof BookRateEntity)) return false;
        BookRateEntity that = (BookRateEntity) o;
        return getId().equals(that.getId()) &&
                getValue() == that.getValue() &&
                getBookId().equals(that.getBookId()) &&
                Objects.equals(getUserId(), that.getUserId());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getBookId(), getUserId(), getValue());
    }
}