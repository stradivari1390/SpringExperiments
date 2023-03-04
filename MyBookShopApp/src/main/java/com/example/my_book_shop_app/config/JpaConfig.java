package com.example.my_book_shop_app.config;

import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@Configuration
@EnableJpaRepositories(basePackages = "com.example.my_book_shop_app.data.repositories")
@EntityScan("com.example.my_book_shop_app.data.model")
public class JpaConfig {

    // Other beans maybe...
}