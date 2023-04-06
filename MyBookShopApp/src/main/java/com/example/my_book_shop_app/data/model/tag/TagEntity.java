package com.example.my_book_shop_app.data.model.tag;

import lombok.*;

import jakarta.persistence.*;

@NoArgsConstructor
@Data
@Entity
@Table(name = "tag_entity", indexes = {
        @Index(name = "idx_tagentity_name_unq", columnList = "name", unique = true)
})
public class TagEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer id;

    @Column(nullable = false)
    String name;
}
