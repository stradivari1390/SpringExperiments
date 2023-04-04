package com.example.my_book_shop_app.data.model.book.review;

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
@Table(name = "book_review", indexes = {
        @Index(name = "idx_bookreviewentity_bookid", columnList = "bookId")
})
public class BookReviewEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(columnDefinition = "BIGINT NOT NULL")
    private Long bookId;

    @Column(columnDefinition = "BIGINT NOT NULL")
    private Long userId;

    @Column(columnDefinition = "TIMESTAMP NOT NULL")
    private LocalDateTime time;

    @Column(columnDefinition = "TEXT NOT NULL")
    private String text;

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof BookReviewEntity)) {
            return false;
        }
        BookReviewEntity that = (BookReviewEntity) o;
        return getId().equals(that.getId()) &&
                getBookId().equals(that.getBookId()) &&
                getUserId().equals(that.getUserId()) &&
                getTime().equals(that.getTime()) &&
                getText().equals(that.getText());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getBookId(), getUserId(), getTime(), getText());
    }
}
