package com.example.my_book_shop_app.services;

import com.example.my_book_shop_app.data.model.payments.BalanceTransactionEntity;
import com.example.my_book_shop_app.data.model.user.UserEntity;
import com.example.my_book_shop_app.data.repositories.BalanceTransactionEntityRepository;
import com.example.my_book_shop_app.data.repositories.UserEntityRepository;
import com.example.my_book_shop_app.exceptions.NoUserFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
public class TransactionService {

    private final UserEntityRepository userEntityRepository;
    private final BalanceTransactionEntityRepository balanceTransactionRepository;

    @Autowired
    public TransactionService(UserEntityRepository userEntityRepository,
                              BalanceTransactionEntityRepository balanceTransactionRepository) {
        this.userEntityRepository = userEntityRepository;
        this.balanceTransactionRepository = balanceTransactionRepository;
    }

    @Transactional
    public BalanceTransactionEntity createTransaction(Long userId, Double value, String description) {
        UserEntity user = userEntityRepository.findById(userId)
                .orElseThrow(() -> new NoUserFoundException("User not found"));
        user.setBalance(user.getBalance() + value);
        userEntityRepository.save(user);

        BalanceTransactionEntity transaction = new BalanceTransactionEntity();
        transaction.setUserId(userId);
        transaction.setTime(LocalDateTime.now());
        transaction.setValue(value);
        transaction.setDescription(description);
        return balanceTransactionRepository.save(transaction);
    }
}
