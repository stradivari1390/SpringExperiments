package com.example.my_book_shop_app.security;

import com.example.my_book_shop_app.data.model.enums.ContactType;
import com.example.my_book_shop_app.data.model.user.UserContactEntity;
import com.example.my_book_shop_app.data.model.user.UserEntity;
import com.example.my_book_shop_app.data.repositories.UserContactEntityRepository;
import com.example.my_book_shop_app.data.repositories.UserEntityRepository;
import com.example.my_book_shop_app.dto.UserDto;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Random;

@Service
public class BookstoreUserDetailsService implements UserDetailsService {

    private final UserEntityRepository userEntityRepository;
    private final UserContactEntityRepository userContactEntityRepository;

    @Autowired
    public BookstoreUserDetailsService(UserEntityRepository userEntityRepository,
                                       UserContactEntityRepository userContactEntityRepository) {
        this.userEntityRepository = userEntityRepository;
        this.userContactEntityRepository = userContactEntityRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UserEntity bookstoreUser = userEntityRepository.findUserByUsername(username);
        if (bookstoreUser != null){
            return new BookstoreUserDetails(bookstoreUser);
        } else {
            throw new UsernameNotFoundException("User not found.");
        }
    }

    public UserDto getUserDtoById(Long id) {
        return userEntityRepository.findUserDtoById(id);
    }

    public String createSmsCode(Long id) {
        Random random = new Random();
        String code = String.format("%06d", random.nextInt(1_000_000));
        UserContactEntity contact = userContactEntityRepository.findByUserIdAndType(id, ContactType.PHONE);
        assert contact != null;
        contact.setCode(code);
        contact.setCodeTime(LocalDateTime.now());
        userContactEntityRepository.save(contact);
        return code;
    }
}
