package com.example.my_book_shop_app.data.model.user;

import com.example.my_book_shop_app.data.model.enums.ContactType;
import lombok.*;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@NoArgsConstructor
@Data
@Entity
@Table(name = "user_contact", indexes = {
        @Index(name = "idx_usercontactentity_userid", columnList = "userId, type", unique = true),
        @Index(name = "idx_usercontactentity_contact", columnList = "contact", unique = true)
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

    @Column(columnDefinition = "VARCHAR(255)")
    private String code;

    @Column(columnDefinition = "INT")
    private int codeTrails;

    @Column(columnDefinition = "TIMESTAMP")
    private LocalDateTime codeTime;

    @Column(columnDefinition = "VARCHAR(255) NOT NULL")
    private String contact;

    public UserContactEntity(Long userId, ContactType type,
                             short approved, String contact) {
        this.userId = userId;
        this.type = type;
        this.approved = approved;
        this.contact = contact;
    }
}
