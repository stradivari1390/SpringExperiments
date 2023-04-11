package com.example.my_book_shop_app.security;

import com.example.my_book_shop_app.data.model.user.UserEntity;
import com.example.my_book_shop_app.data.repositories.UserEntityRepository;
import com.example.my_book_shop_app.dto.UserDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class BookstoreUserDetailsService implements UserDetailsService {

    private final UserEntityRepository userEntityRepository;

    @Autowired
    public BookstoreUserDetailsService(UserEntityRepository userEntityRepository) {
        this.userEntityRepository = userEntityRepository;
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
}
