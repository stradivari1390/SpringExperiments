package com.example.my_book_shop_app.security.security_services;

import com.example.my_book_shop_app.data.model.user.UserEntity;
import com.example.my_book_shop_app.data.repositories.UserEntityRepository;
import com.example.my_book_shop_app.exceptions.NoUserFoundException;
import com.example.my_book_shop_app.security.oauth.CustomOAuth2User;
import com.example.my_book_shop_app.security.security_dto.RegistrationForm;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

@Service
public class CustomOAuth2UserService extends DefaultOAuth2UserService {

    private final UserEntityRepository userEntityRepository;
    private final BookstoreUserRegister bookstoreUserRegister;

    @Autowired
    public CustomOAuth2UserService(UserEntityRepository userEntityRepository,
                                   @Lazy BookstoreUserRegister bookstoreUserRegister) {
        this.userEntityRepository = userEntityRepository;
        this.bookstoreUserRegister = bookstoreUserRegister;
    }

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
        OAuth2User oAuth2User = super.loadUser(userRequest);
        UserEntity user = processOAuth2User(oAuth2User);
        CustomOAuth2User customOAuth2User = new CustomOAuth2User(oAuth2User.getAuthorities(), oAuth2User.getAttributes(), "email", user);

        Authentication authentication = new OAuth2AuthenticationToken(customOAuth2User, customOAuth2User.getAuthorities(), userRequest.getClientRegistration().getRegistrationId());
        SecurityContextHolder.getContext().setAuthentication(authentication);

        return customOAuth2User;
    }

    public UserEntity processOAuth2User(OAuth2User oAuth2User) {
        String email = oAuth2User.getAttribute("email");
        String name = oAuth2User.getAttribute("name");
        String phone = oAuth2User.getAttribute("phone");
        UserEntity user = userEntityRepository.findByContacts(email)
                .orElseThrow(() -> new NoUserFoundException("User not found with email: " + email));
        if (user == null) {
            RegistrationForm registrationForm = new RegistrationForm();
            registrationForm.setName(name);
            registrationForm.setEmail(email);
            registrationForm.setPhone(phone);
            registrationForm.setPass("123456");
            bookstoreUserRegister.registerNewUser(registrationForm);
            user = userEntityRepository.findByContacts(email)
                    .orElseThrow(() -> new NoUserFoundException("User not found, incorrect registration with form: " + registrationForm));
        }
        return user;
    }
}