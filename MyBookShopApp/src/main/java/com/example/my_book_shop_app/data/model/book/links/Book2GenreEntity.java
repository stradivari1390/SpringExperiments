package com.example.my_book_shop_app.data.model.book.links;

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
@Table(name = "book2genre")
public class Book2GenreEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(columnDefinition = "INT NOT NULL")
    private int bookId;

    @Column(columnDefinition = "INT NOT NULL")
    private int genreId;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Book2GenreEntity)) return false;
        Book2GenreEntity that = (Book2GenreEntity) o;
        return getId() == that.getId() &&
                getBookId() == that.getBookId() &&
                getGenreId() == that.getGenreId();
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getBookId(), getGenreId());
    }
}
