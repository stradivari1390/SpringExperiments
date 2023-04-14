package com.example.my_book_shop_app.security.twilio;

import com.example.my_book_shop_app.data.repositories.UserEntityRepository;
import com.example.my_book_shop_app.security.BookstoreUserDetailsService;
import com.example.my_book_shop_app.security.ContactConfirmationPayload;
import com.twilio.http.TwilioRestClient;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.rest.api.v2010.account.MessageCreator;
import com.twilio.type.PhoneNumber;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SMSService {

    private final TwilioRestClient twilioRestClient;
    private final PhoneNumber fromPhoneNumber;
    private final BookstoreUserDetailsService bookstoreUserDetailsService;
    private final UserEntityRepository userEntityRepository;

    @Autowired
    public SMSService(TwilioRestClient twilioRestClient, PhoneNumber fromPhoneNumber,
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
        String code = bookstoreUserDetailsService.createSmsCode(
                userEntityRepository
                        .findByContacts(payload.getContact().replaceAll("[^0-9+]", ""))
                        .getId()
        );
        String message = "Your verification code is: " + code;
        sendSMS(payload.getContact().replaceAll("[^0-9+]", ""), message);
    }
}