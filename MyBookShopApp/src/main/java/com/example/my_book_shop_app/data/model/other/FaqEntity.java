package com.example.my_book_shop_app.data.model.other;

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

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof FaqEntity)) {
            return false;
        }
        FaqEntity faqEntity = (FaqEntity) o;
        return getId().equals(faqEntity.getId()) &&
                getSortIndex() == faqEntity.getSortIndex() &&
                getQuestion().equals(faqEntity.getQuestion()) &&
                getAnswer().equals(faqEntity.getAnswer());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getSortIndex(), getQuestion(), getAnswer());
    }
}
