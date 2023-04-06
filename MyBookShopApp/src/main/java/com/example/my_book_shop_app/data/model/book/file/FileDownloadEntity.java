package com.example.my_book_shop_app.data.model.book.file;

import lombok.*;

import jakarta.persistence.*;

@NoArgsConstructor
@Data
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
}
