package com.example.my_book_shop_app.data.model.tag;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.Objects;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "tag_entity", indexes = {
        @Index(name = "idx_tagentity_name_unq", columnList = "name", unique = true)
})
public class TagEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer id;

    @Column(nullable = false, unique = true)
    String name;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof TagEntity)) return false;
        TagEntity tagEntity = (TagEntity) o;
        return getName().equals(tagEntity.getName());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getName());
    }
}
