package com.example.my_book_shop_app.security.security_services;

import com.example.my_book_shop_app.data.model.enums.ContactType;
import com.example.my_book_shop_app.data.model.user.UserContactEntity;
import com.example.my_book_shop_app.data.model.user.UserEntity;
import com.example.my_book_shop_app.data.repositories.UserContactEntityRepository;
import com.example.my_book_shop_app.data.repositories.UserEntityRepository;
import com.example.my_book_shop_app.data.UserContactDetails;
import com.example.my_book_shop_app.exceptions.UserAlreadyExistsException;
import com.example.my_book_shop_app.security.security_dto.RegistrationForm;

import lombok.RequiredArgsConstructor;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class BookstoreUserRegister {

    private final UserEntityRepository userEntityRepository;
    private final UserContactEntityRepository userContactEntityRepository;
    private final PasswordEncoder passwordEncoder;

    public void registerNewUser(RegistrationForm registrationForm) {

        if (userEntityRepository.findByContacts(registrationForm.getEmail()).isEmpty()) {
            UserEntity user = new UserEntity();
            user.setName(registrationForm.getName());
            user.setUsername(registrationForm.getEmail());
            if (registrationForm.getPass() == null) {
                throw new IllegalArgumentException("Password cannot be null");
            }
            user.setPassword(passwordEncoder.encode(registrationForm.getPass()));
            user.setBalance(0D);
            user.setRegTime(LocalDateTime.now());
            user.setHash(String.valueOf(user.getUsername().hashCode()));
            userEntityRepository.save(user);

            String email = registrationForm.getEmail();
            String phone = registrationForm.getPhone() == null ? "" : registrationForm.getPhone();

            List<UserContactDetails> userContacts = List.of(
                    new UserContactDetails(user.getId(), ContactType.EMAIL, email, (short) 1),
                    new UserContactDetails(user.getId(), ContactType.PHONE, phone, (short) 1)
            );

            for (UserContactDetails contactDetails : userContacts) {
                userContactEntityRepository.findByContact(contactDetails.contact())
                        .ifPresentOrElse(existingContact -> {
                            if (existingContact.getUserId() == -1L) {
                                existingContact.setUserId(contactDetails.userId());
                                existingContact.setApproved(contactDetails.approved());
                                userContactEntityRepository.save(existingContact);
                            }
                        }, () -> {
                            UserContactEntity newContact = new UserContactEntity(contactDetails.userId(),
                                    contactDetails.contactType(), contactDetails.approved(),
                                    contactDetails.contact());
                            userContactEntityRepository.save(newContact);
                        });
            }
        } else {
            throw new UserAlreadyExistsException("User with this contact already exists");
        }
    }
}