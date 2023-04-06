package com.example.my_book_shop_app.data.model.book.file;

import jakarta.persistence.*;
import lombok.*;

@NoArgsConstructor
@Data
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
}