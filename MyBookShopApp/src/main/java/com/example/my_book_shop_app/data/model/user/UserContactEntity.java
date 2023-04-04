package com.example.my_book_shop_app.data.model.user;

import com.example.my_book_shop_app.data.model.enums.ContactType;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Objects;

@Getter
@Setter
@ToString
@NoArgsConstructor
@Entity
@Table(name = "user_contact", indexes = {
        @Index(name = "idx_usercontactentity_userid", columnList = "userId, type")
})
public class UserContactEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(columnDefinition = "BIGINT NOT NULL")
    private Long userId;

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private ContactType type;

    @Column(columnDefinition = "SMALLINT NOT NULL")
    private short approved;

    @Column(columnDefinition = "VARCHAR(255) NOT NULL")
    private String code;

    @Column(columnDefinition = "INT")
    private int codeTrails;

    @Column(columnDefinition = "TIMESTAMP")
    private LocalDateTime codeTime;

    @Column(columnDefinition = "VARCHAR(255) NOT NULL")
    private String contact;

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof UserContactEntity)) {
            return false;
        }
        UserContactEntity that = (UserContactEntity) o;
        return getId() == that.getId() &&
                getUserId().equals(that.getUserId()) &&
                getApproved() == that.getApproved() &&
                getCodeTrails() == that.getCodeTrails() &&
                getType() == that.getType() &&
                getCode().equals(that.getCode()) &&
                getCodeTime().equals(that.getCodeTime()) &&
                getContact().equals(that.getContact());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getUserId(), getType(), getApproved(),
                getCode(), getCodeTrails(), getCodeTime(), getContact());
    }
}
