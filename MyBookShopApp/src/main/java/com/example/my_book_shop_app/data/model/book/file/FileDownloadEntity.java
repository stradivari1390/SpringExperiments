package com.example.my_book_shop_app.data.model.book.file;

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
@Table(name = "file_download")
public class FileDownloadEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private int id;

    @Column(columnDefinition = "INT NOT NULL")
    private int userId;

    @Column(columnDefinition = "INT NOT NULL")
    private int bookId;

    @Column(columnDefinition = "INT NOT NULL DEFAULT 1")
    private int count;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof FileDownloadEntity)) return false;
        FileDownloadEntity that = (FileDownloadEntity) o;
        return getId() == that.getId() &&
                getUserId() == that.getUserId() &&
                getBookId() == that.getBookId() &&
                getCount() == that.getCount();
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getUserId(), getBookId(), getCount());
    }
}
