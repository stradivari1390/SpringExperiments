package com.example.my_book_shop_app.security.security_services;

import com.example.my_book_shop_app.data.model.enums.ContactType;
import com.example.my_book_shop_app.data.model.user.UserEntity;
import com.example.my_book_shop_app.data.repositories.UserEntityRepository;
import com.example.my_book_shop_app.exceptions.NoUserFoundException;
import com.example.my_book_shop_app.security.security_dto.ContactConfirmationPayload;
import com.twilio.http.TwilioRestClient;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.rest.api.v2010.account.MessageCreator;
import com.twilio.type.PhoneNumber;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TwilioService {

    private final TwilioRestClient twilioRestClient;
    private final PhoneNumber fromPhoneNumber;
    private final BookstoreUserDetailsService bookstoreUserDetailsService;
    private final UserEntityRepository userEntityRepository;

    @Autowired
    public TwilioService(TwilioRestClient twilioRestClient, PhoneNumber fromPhoneNumber,
                         BookstoreUserDetailsService bookstoreUserDetailsService, UserEntityRepository userEntityRepository) {
        this.twilioRestClient = twilioRestClient;
        this.fromPhoneNumber = fromPhoneNumber;
        this.bookstoreUserDetailsService = bookstoreUserDetailsService;
        this.userEntityRepository = userEntityRepository;
    }

    public void sendSMS(String toPhoneNumber, String message) {
        PhoneNumber to = new PhoneNumber(toPhoneNumber);
        MessageCreator messageCreator = Message.creator(to, fromPhoneNumber, message);
        messageCreator.create(twilioRestClient);
    }

    public void handleSmsSend(ContactConfirmationPayload payload) {
        String phoneNumber = payload.getContact();
        String code = bookstoreUserDetailsService.createSmsOrEmailCode(phoneNumber);
        String message = "Your verification code is: " + code;
//        sendSMS(phoneNumber.replaceAll("[^0-9+]", ""), message);
    }
}