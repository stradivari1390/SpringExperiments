package com.example.my_book_shop_app.data.model.book.links;

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
@Table(name = "book2user_type")
public class Book2UserTypeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(columnDefinition = "VARCHAR(255) NOT NULL")
    private String code;

    @Column(columnDefinition = "VARCHAR(255) NOT NULL")
    private String name;

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof Book2UserTypeEntity)) {
            return false;
        }
        Book2UserTypeEntity that = (Book2UserTypeEntity) o;
        return getId() == that.getId() &&
                getCode().equals(that.getCode()) &&
                getName().equals(that.getName());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getCode(), getName());
    }
}
