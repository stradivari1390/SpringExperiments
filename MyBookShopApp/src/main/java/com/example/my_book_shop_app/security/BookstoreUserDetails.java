package com.example.my_book_shop_app.security;

import com.example.my_book_shop_app.data.model.user.UserEntity;
import lombok.Getter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.List;

public class BookstoreUserDetails implements UserDetails {

    @Getter
    private final UserEntity bookstoreUser;

    public BookstoreUserDetails(UserEntity bookstoreUser) {
        this.bookstoreUser = bookstoreUser;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of(new SimpleGrantedAuthority("ROLE_USER"));
    }

    @Override
    public String getPassword() {
        return bookstoreUser.getPassword();
    }

    @Override
    public String getUsername() {
        return bookstoreUser.getUsername();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}