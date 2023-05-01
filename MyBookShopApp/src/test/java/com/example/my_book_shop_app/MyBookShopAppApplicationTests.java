package com.example.my_book_shop_app;

import org.hamcrest.Matchers;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;

import static org.hamcrest.MatcherAssert.assertThat;

@SpringBootTest
@TestPropertySource("/application-test.properties")
class MyBookShopAppApplicationTests {

	@Value("${jwt.secret}")
	String authSecret;

	@Test
	void contextLoads() {
		// This test will pass if the application context loads successfully
	}

	@Test
	void verifyAuthSecret() {
		assertThat(authSecret, Matchers.containsString("stradivari"));
	}
}