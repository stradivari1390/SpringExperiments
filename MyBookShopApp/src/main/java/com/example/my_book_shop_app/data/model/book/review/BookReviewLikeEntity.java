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
@Table(name = "book_review_like")
public class BookReviewLikeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(columnDefinition = "INT NOT NULL")
    private int reviewId;

    @Column(columnDefinition = "INT NOT NULL")
    private int userId;

    @Column(columnDefinition = "TIMESTAMP NOT NULL")
    private LocalDateTime time;

    @Column(columnDefinition = "SMALLINT NOT NULL")
    private short value;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof BookReviewLikeEntity)) return false;
        BookReviewLikeEntity that = (BookReviewLikeEntity) o;
        return getId() == that.getId() &&
                getReviewId() == that.getReviewId() &&
                getUserId() == that.getUserId() &&
                getValue() == that.getValue() &&
                getTime().equals(that.getTime());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getReviewId(), getUserId(), getTime(), getValue());
    }
}
