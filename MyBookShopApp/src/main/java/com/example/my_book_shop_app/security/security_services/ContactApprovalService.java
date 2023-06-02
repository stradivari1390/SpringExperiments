package com.example.my_book_shop_app.security.security_services;

import com.example.my_book_shop_app.data.model.user.UserContactEntity;
import com.example.my_book_shop_app.data.repositories.UserContactEntityRepository;
import com.example.my_book_shop_app.exceptions.ContactNotFoundException;
import com.example.my_book_shop_app.security.security_dto.ContactConfirmationPayload;
import com.example.my_book_shop_app.security.security_dto.ContactConfirmationResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ContactApprovalService {
    private final UserContactEntityRepository userContactEntityRepository;

    public ContactConfirmationResponse approveContact(ContactConfirmationPayload payload) {
        String contact = payload.getContact();
        UserContactEntity userContactEntity = userContactEntityRepository.findByContact(contact)
                .orElseThrow(() -> new ContactNotFoundException(contact + " contact not found"));
        boolean confirmed = userContactEntity.getCode().equals(payload.getCode().replaceAll("\\s", ""));
        return new ContactConfirmationResponse(confirmed ? "true" : "false");
    }
}