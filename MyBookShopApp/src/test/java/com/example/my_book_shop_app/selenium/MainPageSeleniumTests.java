package com.example.my_book_shop_app.selenium;

import com.example.my_book_shop_app.MyBookShopAppApplication;
import com.example.my_book_shop_app.data.model.book.review.BookReviewEntity;
import com.example.my_book_shop_app.data.repositories.BookReviewEntityRepository;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;

import java.time.Duration;
import java.util.List;
import java.util.regex.Pattern;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@TestPropertySource("/application-test.properties")
class MainPageSeleniumTests {

    private static ChromeDriver driver;
    @Autowired
    private BookReviewEntityRepository bookReviewEntityRepository;

    @BeforeAll
    static void setup(){
        SpringApplication.run(MyBookShopAppApplication.class);

        System.setProperty("webdriver.chrome.driver",
                "C:/Users/stradivari1390/Downloads//chromedriver.exe");
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--remote-allow-origins=*");
        driver = new ChromeDriver(options);
        driver.manage().timeouts().pageLoadTimeout(Duration.ofSeconds(10));
    }

    @AfterAll
    static void tearDown(){
        driver.quit();
    }

    @Test
    void testMainPageAccess() {
        MainPage mainPage = new MainPage(driver);
        mainPage.callPage();

        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(3));
        wait.until(ExpectedConditions.textToBePresentInElementLocated(By.tagName("body"), "BOOKSHOP"));

        assertTrue(driver.getPageSource().contains("BOOKSHOP"));
    }

    @Test
    void testMainPageSearchByQuery() {
        MainPage mainPage = new MainPage(driver);
        mainPage.callPage();

        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(3));

        wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector(".Header-searchLink svg")));
        driver.findElement(By.cssSelector(".Header-searchLink svg")).click();

        wait.until(ExpectedConditions.elementToBeClickable(By.name("query")));

        mainPage
                .setUpSearchToken("Tiger")
                .submit();

        wait.until(ExpectedConditions.urlContains("/search?query=Tiger"));

        assertTrue(driver.getPageSource().contains("Tiger! Tiger!"));
    }

    @Test
    void siteWalkthroughTest() {
        driver.get("http://localhost:8080/");

        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));

        // Go to Genres
        WebElement link = driver.findElement(By.xpath("/html/body/header/div[2]/div/nav/ul/li[2]/a"));
        JavascriptExecutor js = driver;
        js.executeScript("arguments[0].click();", link);
        wait.until(ExpectedConditions.urlContains("/genres"));

        // Go to New Releases
        link = driver.findElement(By.xpath("/html/body/header/div[2]/div/nav/ul/li[3]/a"));
        js.executeScript("arguments[0].click();", link);
        wait.until(ExpectedConditions.urlContains("/books/recent"));

        // Go to Popular
        link = driver.findElement(By.xpath("/html/body/header/div[2]/div/nav/ul/li[4]/a"));
        js.executeScript("arguments[0].click();", link);
        wait.until(ExpectedConditions.urlContains("/books/popular"));

        // Go to Authors
        link = driver.findElement(By.xpath("/html/body/header/div[2]/div/nav/ul/li[5]/a"));
        js.executeScript("arguments[0].click();", link);
        wait.until(ExpectedConditions.urlContains("/authors"));

        // Click on the letter N
        link = driver.findElement(By.xpath("/html/body/div/div/main/div[1]/ul/li[13]/a"));
        js.executeScript("arguments[0].click();", link);

        // Click on author Shalanda Nitzsche
        link = driver.findElement(By.xpath("/html/body/div/div/main/div[2]/div/div[13]/ul/li[1]/a"));
        js.executeScript("arguments[0].click();", link);
        wait.until(ExpectedConditions.urlContains("/authors/4dc2d33a-b577-4d0a-88c9-dbed81871ff1"));

        // Click on More button
        link = driver.findElement(By.xpath("/html/body/div/div/main/div[1]/article/div[2]/div[3]/button"));
        js.executeScript("arguments[0].click();", link);

        // Click on Hide button
        link = driver.findElement(By.xpath("/html/body/div/div/main/div[1]/article/div[2]/div[3]/button"));
        js.executeScript("arguments[0].click();", link);

        // Click on All author's books (19) link
        link = driver.findElement(By.xpath("/html/body/div/div/main/footer/a"));
        js.executeScript("arguments[0].click();", link);
        wait.until(ExpectedConditions.urlContains("/books/author?authorSlug=4dc2d33a-b577-4d0a-88c9-dbed81871ff1"));

        // Click on More button
        link = driver.findElement(By.xpath("/html/body/div/div/main/div/div/div[2]/a"));
        js.executeScript("arguments[0].click();", link);
        wait.until(ExpectedConditions.numberOfElementsToBeMoreThan(By.cssSelector(".Card > .Card-picture > a"), 18));

        // Click on a book
        List<WebElement> books = driver.findElements(By.cssSelector(".Card > .Card-picture > a"));
        link = books.get(18);
        js.executeScript("arguments[0].click();", link);
        wait.until(ExpectedConditions.urlContains("/books/c023dbe3-38ed-4620-badb-d15b69838293"));

        // Assert that the book title is displayed
        WebElement bookTitle = driver.findElement(By.cssSelector(".ProductCard-title"));
        assertNotNull(bookTitle);
        assertEquals("Tirra Lirra by the River", bookTitle.getText());

        // Click on the like button
        link = driver.findElement(By.xpath("/html/body/div/div/main/div/div[4]/div/div[1]/div[2]/div/div/div/button[1]/span[1]/img"));
        js.executeScript("arguments[0].click();", link);

        // Wait for the alert and accept it
        wait.until(ExpectedConditions.alertIsPresent());
        Alert alert = driver.switchTo().alert();
        assertEquals("review rating denied", alert.getText());
        alert.accept();

        // Click on 5-star rating
        driver.findElement(By.id("rating5")).click();

        // Wait for the alert and accept it
        wait.until(ExpectedConditions.alertIsPresent());
        alert = driver.switchTo().alert();
        assertEquals("Only authorized users can rate a book", alert.getText());
        alert.accept();

        // Click on Postpone button
        String postponedBefore = driver.findElement(By.xpath("/html/body/header/div[1]/div/div/div[3]/div/div/a[1]/span")).getText();
        String cartBefore = driver.findElement(By.xpath("/html/body/header/div[1]/div/div/div[3]/div/div/a[2]/span")).getText();
        driver.findElement(By.xpath("/html/body/div/div/main/div/div[1]/div[2]/div[3]/div/div[1]/button")).click();

        // Assert postponed incremented by 1
        wait.until(ExpectedConditions.textToBePresentInElementLocated(By.xpath("/html/body/header/div[1]/div/div/div[3]/div/div/a[1]/span"), String.valueOf(Integer.parseInt(postponedBefore) + 1)));

        // Click on the cart icon
        driver.findElement(By.xpath("/html/body/div/div/main/div/div[1]/div[2]/div[3]/div/div[2]/button")).click();

        // Assert cart incremented by 1 and postponed decremented by 1
        wait.until(ExpectedConditions.textToBePresentInElementLocated(By.xpath("/html/body/header/div[1]/div/div/div[3]/div/div/a[2]/span"), String.valueOf(Integer.parseInt(cartBefore) + 1)));
        wait.until(ExpectedConditions.textToBePresentInElementLocated(By.xpath("/html/body/header/div[1]/div/div/div[3]/div/div/a[1]/span"), postponedBefore));

        // Go to Signin
        driver.findElement(By.xpath("/html/body/header/div[1]/div/div/div[3]/div/div/a[3]")).click();
        wait.until(ExpectedConditions.urlContains("/signin"));

        // Choose Email + password login option
        driver.findElement(By.xpath("/html/body/div/div[2]/main/form/div/div[1]/div[2]/div/div[2]/label/input")).click();

        // Insert email and click Next
        driver.findElement(By.id("mail")).sendKeys("stradivari1390@gmail.com");
        driver.findElement(By.id("sendauth")).click();

        // Insert code and click Sign In
        wait.until(ExpectedConditions.elementToBeClickable(By.id("mailcode")));
        driver.findElement(By.id("mailcode")).sendKeys("12345678");
        driver.findElement(By.id("toComeInMail")).click();

        // Wait for the alert and accept it
        wait.until(ExpectedConditions.alertIsPresent());
        alert = driver.switchTo().alert();
        assertEquals("Ошибка 500", alert.getText());
        alert.accept();

        // Navigate to /my
        driver.navigate().to("http://localhost:8080/my");
        wait.until(ExpectedConditions.urlContains("/my"));

        // Go to New Releases
        link = driver.findElement(By.xpath("/html/body/header/div[2]/div/nav/ul/li[3]/a"));
        js.executeScript("arguments[0].click();", link);
        wait.until(ExpectedConditions.urlContains("/books/recent"));

        // Enter a from date (15.02.2023)
        WebElement fromDate = driver.findElement(By.xpath("/html/body/div[1]/div/main/div/div[1]/form/div[1]/input"));
        fromDate.sendKeys("15.02.2023");

        // Enter a to date (15.04.2023)
        WebElement toDate = driver.findElement(By.xpath("/html/body/div[1]/div/main/div/div[1]/form/div[2]/input"));
        toDate.sendKeys("15.04.2023");

        fromDate.click();

        // click More
        link = driver.findElement(By.xpath("/html/body/div[1]/div/main/div/div[2]/div[2]/a"));
        js.executeScript("arguments[0].click();", link);

        // Click on a book
        link = driver.findElement(By.xpath("/html/body/div[1]/div/main/div/div[2]/div[1]/div[1]/a/img"));
        js.executeScript("arguments[0].click();", link);
        wait.until(ExpectedConditions.urlContains("/books/de342b36-b5ed-4fa9-95d4-86a73ded6e8a"));

        // Write a review
        driver.findElement(By.id("review-text")).sendKeys("Lalala");

        // Click Submit for the review
        link = driver.findElement(By.xpath("/html/body/div/div/main/div/div[3]/form/input"));
        js.executeScript("arguments[0].click();", link);
        wait.until(ExpectedConditions.textMatches(By.cssSelector(".Comment-content"), Pattern.compile("^Lalala.*")));

        // Assert that the review text is present
        WebElement reviewText = driver.findElement(By.cssSelector(".Comment-content"));
        assertNotNull(reviewText);
        assertTrue(reviewText.getText().startsWith("Lalala"));
        List<BookReviewEntity> reviews = bookReviewEntityRepository.findReviewsByUserNameOrderByTimeDesc("Stanislav Romanov");
        if (!reviews.isEmpty()) {
            Integer lastReviewId = reviews.get(0).getId();
            bookReviewEntityRepository.deleteById(lastReviewId);
        }

        // Logout
        WebElement logoutButton = driver.findElement(By.cssSelector("form[action='/logout'] button[type='submit']"));
        js.executeScript("arguments[0].click();", logoutButton);
        wait.until(ExpectedConditions.urlContains("/signin"));
    }
}