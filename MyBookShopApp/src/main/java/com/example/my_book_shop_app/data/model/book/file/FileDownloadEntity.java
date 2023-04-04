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
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "file_download_id_seq")
    @SequenceGenerator(name = "file_download_id_seq", sequenceName = "file_download_id_seq", allocationSize = 1)
    private Long id;

    @Column(columnDefinition = "BIGINT NOT NULL")
    private Long userId;

    @Column(columnDefinition = "BIGINT NOT NULL")
    private Long bookId;

    @Column(columnDefinition = "INT NOT NULL DEFAULT 1")
    private int count;

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof FileDownloadEntity)) {
            return false;
        }
        FileDownloadEntity that = (FileDownloadEntity) o;
        return getUserId().equals(that.getUserId()) &&
                getBookId().equals(that.getBookId());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getUserId(), getBookId(), getCount());
    }
}
