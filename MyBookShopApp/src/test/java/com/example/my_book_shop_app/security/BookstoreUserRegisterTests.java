package com.example.my_book_shop_app.security;

import com.example.my_book_shop_app.data.model.enums.ContactType;
import com.example.my_book_shop_app.data.model.user.UserContactEntity;
import com.example.my_book_shop_app.data.model.user.UserEntity;
import com.example.my_book_shop_app.data.repositories.UserContactEntityRepository;
import com.example.my_book_shop_app.data.repositories.UserEntityRepository;
import com.example.my_book_shop_app.exceptions.UserAlreadyExistsException;
import com.example.my_book_shop_app.security.security_dto.RegistrationForm;
import com.example.my_book_shop_app.security.security_services.BookstoreUserRegister;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import org.mockito.ArgumentCaptor;
import org.mockito.Mockito;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

@SpringBootTest
class BookstoreUserRegisterTests {

    @Autowired
    private BookstoreUserRegister userRegister;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @MockBean
    private UserEntityRepository userEntityRepository;

    @MockBean
    private UserContactEntityRepository userContactEntityRepository;

    private RegistrationForm registrationForm;

    @BeforeEach
    void setUp() {
        registrationForm = new RegistrationForm();
        registrationForm.setEmail("test@gmail.com");
        registrationForm.setName("Tester");
        registrationForm.setPass("12345678");
        registrationForm.setPhone("+62 (821) 1234-5678");

        Mockito.when(userEntityRepository.save(Mockito.any(UserEntity.class)))
                .thenAnswer(invocation -> {
                    UserEntity userEntity = invocation.getArgument(0);
                    userEntity.setId(1L);
                    return userEntity;
                });
    }

    @AfterEach
    void tearDown() {
        registrationForm = null;
    }

    @Test
    void registerNewUser() {
        Mockito.when(userEntityRepository.findByContacts(registrationForm.getEmail()))
                .thenReturn(Optional.empty());

        userRegister.registerNewUser(registrationForm);

        ArgumentCaptor<UserEntity> userEntityCaptor = ArgumentCaptor.forClass(UserEntity.class);
        Mockito.verify(userEntityRepository).save(userEntityCaptor.capture());
        UserEntity capturedUserEntity = userEntityCaptor.getValue();
        assertEquals(registrationForm.getName(), capturedUserEntity.getName());
        assertEquals(registrationForm.getEmail(), capturedUserEntity.getUsername());
        assertTrue(passwordEncoder.matches(registrationForm.getPass(), capturedUserEntity.getPassword()));
        assertEquals(0D, capturedUserEntity.getBalance());
        assertNotNull(capturedUserEntity.getRegTime());
        assertEquals(String.valueOf(capturedUserEntity.getUsername().hashCode()), capturedUserEntity.getHash());

        ArgumentCaptor<UserContactEntity> userContactEntityCaptor = ArgumentCaptor.forClass(UserContactEntity.class);
        Mockito.verify(userContactEntityRepository, Mockito.times(2)).save(userContactEntityCaptor.capture());
        List<UserContactEntity> capturedContacts = userContactEntityCaptor.getAllValues();

        UserContactEntity emailContact = capturedContacts.get(0);
        assertEquals(capturedUserEntity.getId(), emailContact.getUserId());
        assertEquals(ContactType.EMAIL, emailContact.getType());
        assertEquals(registrationForm.getEmail(), emailContact.getContact());
        assertEquals((short) 1, emailContact.getApproved());

        UserContactEntity phoneContact = capturedContacts.get(1);
        assertEquals(capturedUserEntity.getId(), phoneContact.getUserId());
        assertEquals(ContactType.PHONE, phoneContact.getType());
        assertEquals(registrationForm.getPhone(), phoneContact.getContact());
        assertEquals((short) 1, phoneContact.getApproved());
    }

    @Test
    void registerNewUserFail() {
        Mockito.when(userEntityRepository.findByContacts(registrationForm.getEmail()))
                .thenReturn(Optional.of(new UserEntity()));

        assertThrows(UserAlreadyExistsException.class, () -> userRegister.registerNewUser(registrationForm));
    }


}