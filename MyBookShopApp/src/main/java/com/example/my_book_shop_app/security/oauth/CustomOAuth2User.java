package com.example.my_book_shop_app.security.oauth;

import com.example.my_book_shop_app.data.model.user.UserEntity;

import lombok.Getter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;

import java.util.Collection;
import java.util.Map;
import java.util.Objects;

public class CustomOAuth2User extends DefaultOAuth2User {

    @Getter
    private final UserEntity user;

    public CustomOAuth2User(Collection<? extends GrantedAuthority> authorities,
                            Map<String, Object> attributes, String nameAttributeKey, UserEntity user) {
        super(authorities, attributes, nameAttributeKey);
        this.user = user;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof CustomOAuth2User that)) return false;
        if (!super.equals(o)) return false;
        return getUser().equals(that.getUser());
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), getUser());
    }
}