package com.example.my_book_shop_app.data.model.book.file;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;
import java.util.Objects;

@Getter
@Setter
@NoArgsConstructor
@ToString
@Entity
@Table(name = "book_file")
public class BookFileEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "book_file_id_seq")
    @SequenceGenerator(name = "book_file_id_seq", sequenceName = "book_file_id_seq", allocationSize = 1)
    private Long id;

    @Column(name = "hash", nullable = false)
    private String hash;

    @Column(name = "type_id", nullable = false)
    private int fileType;

    @Column(name = "path", nullable = false)
    private String path;

    @Column(name = "book_id", nullable = false)
    private Long bookId;

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof BookFileEntity)) {
            return false;
        }
        BookFileEntity that = (BookFileEntity) o;
        return getFileType() == that.getFileType() &&
                getId().equals(that.getId()) &&
                getHash().equals(that.getHash()) &&
                getPath().equals(that.getPath());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getHash(), getFileType(), getPath());
    }
}