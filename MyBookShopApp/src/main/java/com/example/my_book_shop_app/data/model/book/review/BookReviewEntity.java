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
@Table(name = "book_review")
public class BookReviewEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(columnDefinition = "INT NOT NULL")
    private int bookId;

    @Column(columnDefinition = "INT NOT NULL")
    private int userId;

    @Column(columnDefinition = "TIMESTAMP NOT NULL")
    private LocalDateTime time;

    @Column(columnDefinition = "TEXT NOT NULL")
    private String text;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof BookReviewEntity)) return false;
        BookReviewEntity that = (BookReviewEntity) o;
        return getId() == that.getId() &&
                getBookId() == that.getBookId() &&
                getUserId() == that.getUserId() &&
                getTime().equals(that.getTime()) &&
                getText().equals(that.getText());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getBookId(), getUserId(), getTime(), getText());
    }
}
