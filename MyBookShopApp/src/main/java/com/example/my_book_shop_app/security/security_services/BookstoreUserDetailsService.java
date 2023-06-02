package com.example.my_book_shop_app.security.security_services;

import com.example.my_book_shop_app.data.model.user.UserEntity;
import com.example.my_book_shop_app.data.repositories.BookRepository;
import com.example.my_book_shop_app.data.repositories.UserEntityRepository;
import com.example.my_book_shop_app.dto.UserDto;
import com.example.my_book_shop_app.exceptions.NoUserFoundException;
import com.example.my_book_shop_app.security.BookstoreUserDetails;

import lombok.RequiredArgsConstructor;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class BookstoreUserDetailsService implements UserDetailsService {

    private final UserEntityRepository userEntityRepository;
    private final BookRepository bookRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UserEntity bookstoreUser = userEntityRepository.findUserByUsername(username)
                .orElseThrow(() -> new NoUserFoundException("User not found with username: " + username));
        return new BookstoreUserDetails(bookstoreUser);
    }

    public UserDto getUserDtoById(Long id) {
        UserDto user = userEntityRepository.findUserDtoById(id)
                .orElseThrow(() -> new NoUserFoundException("User not found with id: " + id));
        user.setPostponedBooks(bookRepository.findAllBooksDtoByUserIdAndRelation(user.getId(), "postponed"));
        user.setCartBooks(bookRepository.findAllBooksDtoByUserIdAndRelation(user.getId(), "in_cart"));
        user.setPurchasedBooks(bookRepository.findAllBooksDtoByUserIdAndRelation(user.getId(), "purchased"));
        user.setArchivedBooks(bookRepository.findAllBooksDtoByUserIdAndRelation(user.getId(), "archived"));
        return user;
    }
}
