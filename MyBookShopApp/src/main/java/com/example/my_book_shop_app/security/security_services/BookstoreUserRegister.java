package com.example.my_book_shop_app.security.security_services;

import ch.qos.logback.classic.Logger;
import com.example.my_book_shop_app.data.model.enums.ContactType;
import com.example.my_book_shop_app.data.model.payments.BalanceTransactionEntity;
import com.example.my_book_shop_app.data.model.user.UserContactEntity;
import com.example.my_book_shop_app.data.model.user.UserEntity;
import com.example.my_book_shop_app.data.repositories.BalanceTransactionEntityRepository;
import com.example.my_book_shop_app.data.repositories.UserContactEntityRepository;
import com.example.my_book_shop_app.data.repositories.UserEntityRepository;
import com.example.my_book_shop_app.data.UserContactDetails;
import com.example.my_book_shop_app.exceptions.ContactNotFoundException;
import com.example.my_book_shop_app.exceptions.NoUserFoundException;
import com.example.my_book_shop_app.exceptions.UserAlreadyExistsException;
import com.example.my_book_shop_app.exceptions.WrongPasswordException;
import com.example.my_book_shop_app.security.BookstoreUserDetails;
import com.example.my_book_shop_app.security.jwt.JWTUtil;
import com.example.my_book_shop_app.security.oauth.CustomOAuth2User;
import com.example.my_book_shop_app.security.security_controller.AuthUserController;
import com.example.my_book_shop_app.security.security_dto.ContactConfirmationPayload;
import com.example.my_book_shop_app.security.security_dto.ContactConfirmationResponse;
import com.example.my_book_shop_app.security.security_dto.RegistrationForm;

import com.paypal.api.payments.*;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BookstoreUserRegister {

    private final UserEntityRepository userEntityRepository;
    private final UserContactEntityRepository userContactEntityRepository;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationManager authenticationManager;
    private final BookstoreUserDetailsService bookstoreUserDetailsService;
    private final JWTUtil jwtTokenUtil;
    private final AuthUserController authUserController;
    private final Logger log = (Logger) LoggerFactory.getLogger(getClass());
    private final BalanceTransactionEntityRepository balanceTransactionEntityRepository;
    private final APIContext apiContext = new APIContext("AYKIRLX7gctbC0MHf4mWOFiBvHNOMp6laYgtzebaeWupUXJQJd8UH70KERxA6kwq8poBoobpfZ-mzz22",
            "EI_YBne00EsEk3PSzBUJwB_waBDAq042GJ9T0_128870A14j8rs9nOU-5SuXnpKCG9u34ONfv_n5Mzmw",
            "sandbox");

    @Autowired
    public BookstoreUserRegister(UserEntityRepository userEntityRepository, PasswordEncoder passwordEncoder,
                                 AuthenticationManager authenticationManager,
                                 BookstoreUserDetailsService bookstoreUserDetailsService, JWTUtil jwtTokenUtil,
                                 UserContactEntityRepository userContactEntityRepository,
                                 @Lazy AuthUserController authUserController,
                                 BalanceTransactionEntityRepository balanceTransactionEntityRepository) {
        this.userEntityRepository = userEntityRepository;
        this.passwordEncoder = passwordEncoder;
        this.authenticationManager = authenticationManager;
        this.bookstoreUserDetailsService = bookstoreUserDetailsService;
        this.jwtTokenUtil = jwtTokenUtil;
        this.userContactEntityRepository = userContactEntityRepository;
        this.authUserController = authUserController;
        this.balanceTransactionEntityRepository = balanceTransactionEntityRepository;
    }

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

    public ContactConfirmationResponse login(ContactConfirmationPayload payload) {
        Authentication authentication = authenticationManager
                .authenticate(new UsernamePasswordAuthenticationToken(payload.getContact(), payload.getCode()));
        SecurityContextHolder.getContext().setAuthentication(authentication);
        ContactConfirmationResponse response = new ContactConfirmationResponse();
        response.setResult("true");
        return response;
    }

    public void jwtTokenLogin(ContactConfirmationPayload payload, HttpServletResponse httpServletResponse) {
        if (!payload.getContact().contains("@")) {
            handlePossessAuthentication(payload);
        } else {
            handlePasswordAuthentication(payload);
        }
        String email = userContactEntityRepository.getUserEmailByContact(payload.getContact(), ContactType.EMAIL);
        final UserDetails userDetails = bookstoreUserDetailsService.loadUserByUsername(email);
        final String token = jwtTokenUtil.generateToken(userDetails);

        Cookie cookie = new Cookie("token", token);
        httpServletResponse.addCookie(cookie);
    }

    private void handlePossessAuthentication(ContactConfirmationPayload payload) {
        ContactConfirmationResponse confirmationResponse = authUserController.handleApproveContact(payload);
        if (!confirmationResponse.getResult().equals("true")) {
            throw new WrongPasswordException("Invalid code provided for authentication.");
        }
    }

    private void handlePasswordAuthentication(ContactConfirmationPayload payload) {
        try {
            authenticate(payload.getContact(), payload.getCode());
        } catch (BadCredentialsException e) {
            if (e.getMessage().contains("UserDetailsService returned null")) {
                throw new NoUserFoundException("User not found");
            } else {
                throw new WrongPasswordException("Wrong password");
            }
        }
    }

    public UserEntity getCurrentUser() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof BookstoreUserDetails userDetails) {
            return userDetails.bookstoreUser();
        } else if (principal instanceof CustomOAuth2User oAuth2User) {
            return oAuth2User.getUser();
        } else {
            log.error("The principal is not an instance of BookstoreUserDetails or CustomOAuth2User. Principal: {}", principal);
            throw new IllegalStateException("The principal is not an instance of BookstoreUserDetails or CustomOAuth2User");
        }
    }

    public ContactConfirmationResponse requestContactConfirmation(ContactConfirmationPayload payload) {
        boolean userExists = userEntityRepository.findByContacts(payload.getContact()).isPresent();
        return new ContactConfirmationResponse(userExists ? "true" : "false");
        // throw new ContactNotFoundException("Contact not found: " + payload.getContact());
    }

    public ContactConfirmationResponse approveContact(ContactConfirmationPayload payload) {
        String contact = payload.getContact();
        UserContactEntity userContactEntity = userContactEntityRepository.findByContact(contact)
                .orElseThrow(() -> new ContactNotFoundException(contact + " contact not found"));
        boolean confirmed = userContactEntity.getCode().equals(payload.getCode().replaceAll("\\s", ""));
        return new ContactConfirmationResponse(confirmed ? "true" : "false");
    }


    private void authenticate(String username, String password) {
        try {
            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(username, password));
        } catch (NoUserFoundException e) {
            throw e;
        } catch (AuthenticationException e) {
            throw new BadCredentialsException(e.getMessage());
        }
    }

    public void updateProfile(String name, String email, String phone, String password) {
        UserEntity userEntity = getCurrentUser();
        UserContactEntity phoneEntity = userContactEntityRepository
                .findByUserIdAndType(userEntity.getId(), ContactType.PHONE).orElse(new UserContactEntity());
        UserContactEntity emailEntity = userContactEntityRepository
                .findByUserIdAndType(userEntity.getId(), ContactType.EMAIL).orElse(new UserContactEntity());
        if (name != null) {
            userEntity.setName(name);
        }
        if (email != null) {
            userEntity.setUsername(email);
            emailEntity.setContact(email);
            userContactEntityRepository.save(emailEntity);
        }
        if (phone != null) {
            phoneEntity.setContact(phone);
            userContactEntityRepository.save(phoneEntity);
        }
        if (!password.isEmpty()) {
            userEntity.setPassword(passwordEncoder.encode(password));
        }
        userEntityRepository.save(userEntity);
    }

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
        redirectUrls.setReturnUrl("http://localhost:8080/execute-payment");
        redirectUrls.setCancelUrl("http://localhost:8080/cancel-payment");
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

                UserEntity currentUser = getCurrentUser();
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

    public String processPayment(Map<String, String> payload) {
        String hash = payload.get("hash");
        double sum = Double.parseDouble(payload.get("sum"));
        long time = System.currentTimeMillis();

        UserEntity userEntity = userEntityRepository.findByHash(hash);
        if (userEntity == null) {
            return "{\"result\": false, \"error\": \"Invalid user hash.\"}";
        }

        BalanceTransactionEntity balanceTransactionEntity = new BalanceTransactionEntity();
        balanceTransactionEntity.setUserId(userEntity.getId());
        balanceTransactionEntity.setTime(LocalDateTime.ofInstant(Instant.ofEpochMilli(time), ZoneId.of("UTC")));
        balanceTransactionEntity.setValue(sum);
        balanceTransactionEntity.setDescription("Payment received from payment system.");
        balanceTransactionEntityRepository.save(balanceTransactionEntity);

        userEntity.setBalance(userEntity.getBalance() + sum);
        userEntityRepository.save(userEntity);

        return "{\"result\": true}";
    }
}