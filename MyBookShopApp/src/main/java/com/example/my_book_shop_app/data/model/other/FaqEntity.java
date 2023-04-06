package com.example.my_book_shop_app.data.model.other;

import lombok.*;

import jakarta.persistence.*;

@NoArgsConstructor
@Data
@Entity
@Table(name = "faq")
public class FaqEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "faq_id_seq")
    @SequenceGenerator(name = "faq_id_seq", sequenceName = "faq_id_seq", allocationSize = 1)
    private Integer id;

    @Column(columnDefinition = "INT NOT NULL  DEFAULT 0")
    private int sortIndex;

    @Column(columnDefinition = "VARCHAR(255) NOT NULL")
    private String question;

    @Column(columnDefinition = "TEXT NOT NULL")
    private String answer;
}
