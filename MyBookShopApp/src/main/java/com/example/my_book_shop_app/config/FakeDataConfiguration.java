package com.example.my_book_shop_app.config;

import com.example.my_book_shop_app.data.repositories.*;
import com.example.my_book_shop_app.util.FakeDataFiller;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class FakeDataConfiguration {

    @Bean
    @ConditionalOnProperty(name = "data.generation", havingValue = "true")
    public FakeDataFiller fakeDataFiller(AuthorRepository authorRepository, BookRepository bookRepository,
                                         Book2AuthorEntityRepository book2AuthorRepository, BookFileEntityRepository bookFileEntityRepository,
                                         BookFileTypeEntityRepository bookFileTypeEntityRepository, GenreEntityRepository genreRepository,
                                         UserEntityRepository userRepository, BalanceTransactionEntityRepository balanceTransactionEntityRepository,
                                         Book2GenreEntityRepository book2GenreEntityRepository, Book2UserEntityRepository book2UserEntityRepository,
                                         Book2UserTypeEntityRepository book2UserTypeEntityRepository, BookReviewEntityRepository bookReviewEntityRepository,
                                         BookReviewLikeEntityRepository bookReviewLikeEntityRepository, DocumentEntityRepository documentEntityRepository,
                                         FaqEntityRepository faqEntityRepository, FileDownloadEntityRepository fileDownloadEntityRepository,
                                         MessageEntityRepository messageEntityRepository, UserContactEntityRepository userContactEntityRepository,
                                         TagEntityRepository tagEntityRepository, Book2TagEntityRepository book2TagEntityRepository) {
        return new FakeDataFiller(authorRepository, bookRepository, book2AuthorRepository, bookFileEntityRepository,
                bookFileTypeEntityRepository, genreRepository, userRepository, balanceTransactionEntityRepository,
                book2GenreEntityRepository, book2UserEntityRepository, book2UserTypeEntityRepository, bookReviewEntityRepository,
                bookReviewLikeEntityRepository, documentEntityRepository, faqEntityRepository, fileDownloadEntityRepository,
                messageEntityRepository, userContactEntityRepository, tagEntityRepository, book2TagEntityRepository);
    }
}