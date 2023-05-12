package com.example.my_book_shop_app.data.repositories;

import com.example.my_book_shop_app.data.model.payments.BalanceTransactionEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BalanceTransactionEntityRepository extends JpaRepository<BalanceTransactionEntity, Integer> {

    BalanceTransactionEntity findByUserIdAndBookId(Long userId, Long bookId);

    Page<BalanceTransactionEntity> findByUserIdOrderByTimeDesc(Long userId, Pageable pageable);
}