package com.example.my_book_shop_app.data.model.book.links;

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
@Table(name = "book2user", indexes = {
        @Index(name = "idx_book2userentity_bookid", columnList = "bookId, userId, typeId")
})
public class Book2UserEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(columnDefinition = "TIMESTAMP NOT NULL")
    private LocalDateTime time;

    @Column(columnDefinition = "INT NOT NULL")
    private int typeId;

    @Column(columnDefinition = "BIGINT NOT NULL")
    private Long bookId;

    @Column(columnDefinition = "INT NOT NULL")
    private Long userId;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Book2UserEntity)) return false;
        Book2UserEntity that = (Book2UserEntity) o;
        return getId() == that.getId() &&
                getTypeId() == that.getTypeId() &&
                getBookId().equals(that.getBookId()) &&
                getUserId().equals(that.getUserId()) &&
                Objects.equals(getTime(), that.getTime());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getTime(), getTypeId(), getBookId(), getUserId());
    }
}
