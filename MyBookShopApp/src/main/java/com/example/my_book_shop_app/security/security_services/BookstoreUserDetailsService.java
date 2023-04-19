package com.example.my_book_shop_app.security.security_services;

import com.example.my_book_shop_app.data.model.enums.ContactType;
import com.example.my_book_shop_app.data.model.user.UserContactEntity;
import com.example.my_book_shop_app.data.model.user.UserEntity;
import com.example.my_book_shop_app.data.repositories.BookRepository;
import com.example.my_book_shop_app.data.repositories.UserContactEntityRepository;
import com.example.my_book_shop_app.data.repositories.UserEntityRepository;
import com.example.my_book_shop_app.dto.UserDto;

import com.example.my_book_shop_app.exceptions.NoUserFoundException;
import com.example.my_book_shop_app.security.BookstoreUserDetails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Collections;
import java.util.Random;

@Service
public class BookstoreUserDetailsService implements UserDetailsService {

    private final UserEntityRepository userEntityRepository;
    private final UserContactEntityRepository userContactEntityRepository;
    private final Random random = new Random();
    private final BookRepository bookRepository;

    @Autowired
    public BookstoreUserDetailsService(UserEntityRepository userEntityRepository,
                                       UserContactEntityRepository userContactEntityRepository,
                                       BookRepository bookRepository) {
        this.userEntityRepository = userEntityRepository;
        this.userContactEntityRepository = userContactEntityRepository;
        this.bookRepository = bookRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String username) {
        UserEntity bookstoreUser = userEntityRepository.findUserByUsername(username)
                .orElseThrow(() -> new NoUserFoundException("User not found with username: " + username));
        return new BookstoreUserDetails(bookstoreUser);
    }

    public UserDto getUserDtoById(Long id) {
        UserDto user = userEntityRepository.findUserDtoById(id)
                .orElseThrow(() -> new NoUserFoundException("User not found with id: " + id));
        user.setPostponedBooks(bookRepository.findAllBooksDtoByUserIdAndRelation(user.getId(), "postponed")
                .orElse(Collections.emptyList()));
        user.setCartBooks(bookRepository.findAllBooksDtoByUserIdAndRelation(user.getId(), "in_cart")
                .orElse(Collections.emptyList()));
        user.setPurchasedBooks(bookRepository.findAllBooksDtoByUserIdAndRelation(user.getId(), "purchased")
                .orElse(Collections.emptyList()));
        user.setArchivedBooks(bookRepository.findAllBooksDtoByUserIdAndRelation(user.getId(), "archived")
                .orElse(Collections.emptyList()));
        return user;
    }

    public String createSmsOrEmailCode(String contact) {
        String code = String.format("%06d", random.nextInt(1_000_000));
        UserContactEntity contactEntity = userContactEntityRepository.findByContact(contact).orElse(null);
        if(contactEntity == null) {
            contactEntity = new UserContactEntity();
            contactEntity.setUserId(-1L * Math.abs(contact.hashCode()));
            contactEntity.setContact(contact);
            contactEntity.setType(contact.contains("@") ? ContactType.EMAIL : ContactType.PHONE);
            contactEntity.setApproved((short) 0);
        }
        contactEntity.setCode(code);
        contactEntity.setCodeTime(LocalDateTime.now());
        contactEntity.setCodeTrails(0);
        userContactEntityRepository.save(contactEntity);
        return code;
    }
}
