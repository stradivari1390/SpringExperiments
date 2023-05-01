package com.example.my_book_shop_app.security;

import com.example.my_book_shop_app.data.model.enums.ContactType;
import com.example.my_book_shop_app.data.model.user.UserContactEntity;
import com.example.my_book_shop_app.data.model.user.UserEntity;
import com.example.my_book_shop_app.data.repositories.BookRepository;
import com.example.my_book_shop_app.data.repositories.UserContactEntityRepository;
import com.example.my_book_shop_app.data.repositories.UserEntityRepository;
import com.example.my_book_shop_app.dto.UserDto;
import com.example.my_book_shop_app.exceptions.NoUserFoundException;
import com.example.my_book_shop_app.security.security_services.BookstoreUserDetailsService;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class BookstoreUserDetailsServiceTests {

    @Autowired
    private BookstoreUserDetailsService userDetailsService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @MockBean
    private UserEntityRepository userEntityRepository;

    @MockBean
    private UserContactEntityRepository userContactEntityRepository;

    @Test
    void loadUserByUsername_existingUser() {
        UserEntity userEntity = new UserEntity();
        userEntity.setUsername("test@example.com");
        userEntity.setPassword(passwordEncoder.encode("testpassword"));
        Mockito.when(userEntityRepository.findUserByUsername(userEntity.getUsername()))
                .thenReturn(Optional.of(userEntity));

        UserDetails userDetails = userDetailsService.loadUserByUsername(userEntity.getUsername());

        assertEquals(userEntity.getUsername(), userDetails.getUsername());
        assertTrue(passwordEncoder.matches("testpassword", userDetails.getPassword()));
    }

    @Test
    void loadUserByUsername_nonExistingUser() {
        String nonExistingUsername = "nonexistent@example.com";
        Mockito.when(userEntityRepository.findUserByUsername(nonExistingUsername))
                .thenReturn(Optional.empty());

        assertThrows(NoUserFoundException.class, () -> userDetailsService.loadUserByUsername(nonExistingUsername));
    }

    @Test
    void getUserDtoById_validId() {
        Long userId = 1L;
        UserDto userDto = new UserDto();
        userDto.setId(userId);
        userDto.setUsername("test@example.com");
        Mockito.when(userEntityRepository.findUserDtoById(userId))
                .thenReturn(Optional.of(userDto));

        UserDto fetchedUserDto = userDetailsService.getUserDtoById(userId);

        assertEquals(userDto.getId(), fetchedUserDto.getId());
        assertEquals(userDto.getUsername(), fetchedUserDto.getUsername());
    }

    @Test
    void getUserDtoById_invalidId() {
        Long invalidUserId = 999L;
        Mockito.when(userEntityRepository.findUserDtoById(invalidUserId))
                .thenReturn(Optional.empty());

        assertThrows(NoUserFoundException.class, () -> userDetailsService.getUserDtoById(invalidUserId));
    }

    @Test
    void createSmsOrEmailCode_newContact() {
        String newContact = "newcontact@example.com";
        Mockito.when(userContactEntityRepository.findByContact(newContact))
                .thenReturn(Optional.empty());

        String code = userDetailsService.createSmsOrEmailCode(newContact);

        assertNotNull(code);
        assertEquals(6, code.length());
    }

    @Test
    void createSmsOrEmailCode_existingContact() {
        String existingContact = "existingcontact@example.com";
        UserContactEntity contactEntity = new UserContactEntity();
        contactEntity.setUserId(1L);
        contactEntity.setContact(existingContact);
        contactEntity.setType(ContactType.EMAIL);
        contactEntity.setApproved((short) 0);
        Mockito.when(userContactEntityRepository.findByContact(existingContact))
                .thenReturn(Optional.of(contactEntity));

        String code = userDetailsService.createSmsOrEmailCode(existingContact);

        assertNotNull(code);
        assertEquals(6, code.length());
    }
}