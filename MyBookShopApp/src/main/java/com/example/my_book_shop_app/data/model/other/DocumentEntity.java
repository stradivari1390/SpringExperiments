package com.example.my_book_shop_app.data.model.other;

import lombok.*;

import jakarta.persistence.*;

@NoArgsConstructor
@Data
@Entity
@Table(name = "document")
public class DocumentEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "document_id_seq")
    @SequenceGenerator(name = "document_id_seq", sequenceName = "document_id_seq", allocationSize = 1)
    private Integer id;

    @Column(columnDefinition = "INT NOT NULL  DEFAULT 0")
    private int sortIndex;

    @Column(columnDefinition = "VARCHAR(255) NOT NULL")
    private String slug;

    @Column(columnDefinition = "VARCHAR(255) NOT NULL")
    private String title;

    @Column(columnDefinition = "TEXT NOT NULL")
    private String text;
}
