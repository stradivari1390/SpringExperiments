package com.example.my_book_shop_app.security.security_services;

import com.example.my_book_shop_app.security.security_dto.ContactConfirmationPayload;
import com.twilio.http.TwilioRestClient;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.rest.api.v2010.account.MessageCreator;
import com.twilio.type.PhoneNumber;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class TwilioService {

    private final TwilioRestClient twilioRestClient;
    private final PhoneNumber fromPhoneNumber;
    private final EmailService emailService;

    public void sendSMS(String toPhoneNumber, String message) {
        PhoneNumber to = new PhoneNumber(toPhoneNumber);
        MessageCreator messageCreator = Message.creator(to, fromPhoneNumber, message);
        messageCreator.create(twilioRestClient);
    }

    public void handleSmsSend(ContactConfirmationPayload payload) {
        String phoneNumber = payload.getContact();
        String code = emailService.createSmsOrEmailCode(phoneNumber);
        String message = "Your verification code is: " + code;
//        sendSMS(phoneNumber.replaceAll("[^0-9+]", ""), message);
    }
}