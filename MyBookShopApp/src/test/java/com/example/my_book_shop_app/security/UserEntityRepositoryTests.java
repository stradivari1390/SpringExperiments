package com.example.my_book_shop_app.security;

import com.example.my_book_shop_app.data.model.enums.ContactType;
import com.example.my_book_shop_app.data.model.user.UserContactEntity;
import com.example.my_book_shop_app.data.model.user.UserEntity;
import com.example.my_book_shop_app.data.repositories.UserContactEntityRepository;
import com.example.my_book_shop_app.data.repositories.UserEntityRepository;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.TestPropertySource;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertNotNull;

@SpringBootTest
@TestPropertySource("/application-test.properties")
@Transactional
class UserEntityRepositoryTests {

    private final UserEntityRepository userEntityRepository;
    @Autowired
    private final UserContactEntityRepository userContactEntityRepository;

    private UserEntity savedUser;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public UserEntityRepositoryTests(UserEntityRepository userEntityRepository,
                                     UserContactEntityRepository userContactEntityRepository,
                                     PasswordEncoder passwordEncoder) {
        this.userEntityRepository = userEntityRepository;
        this.userContactEntityRepository = userContactEntityRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Test
    void testAddNewUser(){
        UserEntity user = new UserEntity();
        user.setPassword(passwordEncoder.encode("12345678"));
        user.setBalance(0);
        user.setName("Stan Romans");
        user.setUsername("botichelli9013@gmail.com");
        user.setRegTime(LocalDateTime.now());
        user.setHash(String.valueOf(user.hashCode()));

        savedUser = userEntityRepository.save(user);
        assertNotNull(savedUser);

        UserContactEntity contactE = new UserContactEntity(user.getId(), ContactType.EMAIL, (short) 1, "botichelli9013@gmail.com");
        UserContactEntity contactP = new UserContactEntity(user.getId(), ContactType.PHONE, (short) 1, "+62 (811) 4651-2256");
        assertNotNull(userContactEntityRepository.saveAll(List.of(contactE, contactP)));
    }

    @AfterEach
    void cleanup() {
        if (savedUser != null) {
            userContactEntityRepository.deleteAllByUserId(savedUser.getId());
            userEntityRepository.deleteById(savedUser.getId());
        }
    }
}