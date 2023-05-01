package com.example.my_book_shop_app.selenium;

import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

public class MainPage {
    private final ChromeDriver driver;

    public MainPage(ChromeDriver driver) {
        this.driver = driver;
    }

    public MainPage callPage() {
        driver.get("http://localhost:8080/");
        return this;
    }

    public MainPage setUpSearchToken(String query) {
        WebElement searchInput = driver.findElement(By.name("query"));
        searchInput.sendKeys(query);
        return this;
    }

    public MainPage submit() {
        WebElement searchButton = driver.findElement(By.id("search"));
        searchButton.click();
        return this;
    }
}