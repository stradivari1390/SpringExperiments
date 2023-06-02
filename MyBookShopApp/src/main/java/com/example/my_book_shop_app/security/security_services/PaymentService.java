package com.example.my_book_shop_app.security.security_services;

import ch.qos.logback.classic.Logger;
import org.slf4j.LoggerFactory;

import com.example.my_book_shop_app.data.model.payments.BalanceTransactionEntity;
import com.example.my_book_shop_app.data.model.user.UserEntity;
import com.example.my_book_shop_app.data.repositories.BalanceTransactionEntityRepository;
import com.example.my_book_shop_app.data.repositories.UserEntityRepository;
import com.example.my_book_shop_app.dto.BalanceTransactionDto;
import com.example.my_book_shop_app.exceptions.NoUserFoundException;

import com.paypal.api.payments.*;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;

import jakarta.servlet.http.HttpServletRequest;

import lombok.RequiredArgsConstructor;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class PaymentService {

    private final AuthenticationService authenticationService;
    private final UserEntityRepository userEntityRepository;
    private final BalanceTransactionEntityRepository balanceTransactionEntityRepository;
    private final APIContext apiContext = new APIContext("AYKIRLX7gctbC0MHf4mWOFiBvHNOMp6laYgtzebaeWupUXJQJd8UH70KERxA6kwq8poBoobpfZ-mzz22",
            "EI_YBne00EsEk3PSzBUJwB_waBDAq042GJ9T0_128870A14j8rs9nOU-5SuXnpKCG9u34ONfv_n5Mzmw",
            "sandbox");
    @Value("${payment.returnUrl}")
    private String returnUrl;
    @Value("${payment.cancelUrl}")
    private String cancelUrl;
    private final Logger log = (Logger) LoggerFactory.getLogger(getClass());

    public String topupWithPayPal(String sum) {
        Amount amount = new Amount();
        amount.setCurrency("USD");
        amount.setTotal(sum);

        Transaction transaction = new Transaction();
        transaction.setDescription("Topup");
        transaction.setAmount(amount);

        Payer payer = new Payer();
        payer.setPaymentMethod("paypal");

        Payment payment = new Payment();
        payment.setIntent("sale");
        payment.setPayer(payer);
        payment.setTransactions(List.of(transaction));

        RedirectUrls redirectUrls = new RedirectUrls();
        redirectUrls.setReturnUrl(returnUrl);
        redirectUrls.setCancelUrl(cancelUrl);
        payment.setRedirectUrls(redirectUrls);

        Payment createdPayment = new Payment();
        try {
            createdPayment = payment.create(apiContext);
        } catch (PayPalRESTException e) {
            log.error(e.getMessage());
        }

        String redirectUrl = "";
        for (Links link : createdPayment.getLinks()) {
            if (link.getRel().equalsIgnoreCase("approval_url")) {
                redirectUrl = link.getHref();
                break;
            }
        }
        return redirectUrl;
    }

    @Transactional
    public void executePayPalPayment(HttpServletRequest request) {
        String paymentId = request.getParameter("paymentId");
        String payerId = request.getParameter("PayerID");

        Payment payment = new Payment();
        payment.setId(paymentId);

        PaymentExecution paymentExecute = new PaymentExecution();
        paymentExecute.setPayerId(payerId);

        try {
            Payment createdPayment = payment.execute(apiContext, paymentExecute);

            String sum = createdPayment.getTransactions().get(0).getAmount().getTotal();
            String hash = createdPayment.getPayer().getPayerInfo().getPayerId();

            UserEntity currentUser = authenticationService.getCurrentUser();
            currentUser.setHash(hash);
            userEntityRepository.save(currentUser);

            Map<String, String> payload = new HashMap<>();
            payload.put("sum", sum);
            payload.put("hash", hash);
            processPayment(payload);

        } catch (PayPalRESTException e) {
            log.error(e.getMessage());
        }
    }

    @Transactional
    public void createInternalPurchaseTransaction(Long userId, Double value, String description) {
        UserEntity user = userEntityRepository.findById(userId)
                .orElseThrow(() -> new NoUserFoundException("User not found"));
        user.setBalance(user.getBalance() + value);
        userEntityRepository.save(user);

        BalanceTransactionEntity transaction = new BalanceTransactionEntity();
        transaction.setUserId(userId);
        transaction.setTime(LocalDateTime.now());
        transaction.setValue(value);
        transaction.setDescription(description);
        balanceTransactionEntityRepository.save(transaction);
    }

    @Transactional
    public void processPayment(Map<String, String> payload) {
        String hash = payload.get("hash");
        double sum = Double.parseDouble(payload.get("sum"));
        long time = System.currentTimeMillis();

        UserEntity userEntity = userEntityRepository.findByHash(hash);
        if (userEntity == null) {
            return;
        }

        BalanceTransactionEntity balanceTransactionEntity = new BalanceTransactionEntity();
        balanceTransactionEntity.setUserId(userEntity.getId());
        balanceTransactionEntity.setTime(LocalDateTime.ofInstant(Instant.ofEpochMilli(time), ZoneId.of("UTC")));
        balanceTransactionEntity.setValue(sum);
        balanceTransactionEntity.setDescription("Payment received from payment system.");
        balanceTransactionEntityRepository.save(balanceTransactionEntity);

        userEntity.setBalance(userEntity.getBalance() + sum);
        userEntityRepository.save(userEntity);
    }

    public BalanceTransactionDto mapToTransactionDto(BalanceTransactionEntity entity) {
        BalanceTransactionDto dto = new BalanceTransactionDto();
        dto.setId(entity.getId());
        dto.setUserId(entity.getUserId());
        dto.setTime(entity.getTime().atZone(ZoneId.systemDefault()).toInstant().toEpochMilli());
        dto.setValue(entity.getValue());
        dto.setBookId(entity.getBookId());
        dto.setDescription(entity.getDescription());
        return dto;
    }

    public Page<BalanceTransactionDto> getBalanceTransactionDtos(int offset, int limit) {
        Page<BalanceTransactionEntity> entities = balanceTransactionEntityRepository
                .findByUserIdOrderByTimeDesc(authenticationService.getCurrentUser().getId(), PageRequest.of(offset / limit, limit));
        return entities.map(this::mapToTransactionDto);
    }
}
