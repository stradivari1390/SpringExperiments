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
@Table(name = "book2author", indexes = {
        @Index(name = "idx_book2authorentity_unq", columnList = "bookId, authorId", unique = true)
})
public class Book2AuthorEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(columnDefinition = "BIGINT NOT NULL")
    private Long bookId;

    @Column(columnDefinition = "BIGINT NOT NULL")
    private Long authorId;

    @Column(columnDefinition = "INT NOT NULL  DEFAULT 0")
    private int sortIndex;

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof Book2AuthorEntity)) {
            return false;
        }
        Book2AuthorEntity that = (Book2AuthorEntity) o;
        return Objects.equals(getId(), that.getId()) &&
                Objects.equals(getBookId(), that.getBookId()) &&
                Objects.equals(getAuthorId(), that.getAuthorId()) &&
                getSortIndex() == that.getSortIndex();
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getBookId(),
                getAuthorId(), getSortIndex());
    }
}
