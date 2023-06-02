package com.example.my_book_shop_app.services;

import com.example.my_book_shop_app.data.model.book.links.Book2UserEntity;
import com.example.my_book_shop_app.data.repositories.*;
import com.example.my_book_shop_app.dto.BookDto;
import com.example.my_book_shop_app.dto.UserDto;
import com.example.my_book_shop_app.security.security_services.AuthenticationService;

import com.example.my_book_shop_app.security.security_services.PaymentService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CartService {

    private final BookRepository bookRepository;
    private final BookService bookService;
    private final Book2UserEntityRepository book2UserEntityRepository;
    private final Book2UserTypeEntityRepository book2UserTypeEntityRepository;
    private final PaymentService paymentService;
    private final AuthenticationService authenticationService;

    public Page<BookDto> getPageOfCartBooks(Long userId, Integer offset, Integer limit) {
        Pageable nextPage = PageRequest.of(offset, limit);
        return bookRepository.getPageOfBooksInCart(userId, nextPage);
    }

    public List<BookDto> getBookDtoListByCookie(String cookieContents) {
        if (cookieContents == null) {
            return Collections.emptyList();
        }
        cookieContents = cookieContents.startsWith("/") ? cookieContents.substring(1) : cookieContents;
        cookieContents = cookieContents.endsWith("/") ? cookieContents.substring(0, cookieContents.length() - 1) : cookieContents;
        String[] cookieSlugs = cookieContents.split("/");
        return bookRepository.findAllBookDtoBySlug(cookieSlugs);
    }

    public void addToCart(String slug, String cartContents, String postponedContents,
                          HttpServletResponse response, Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated()) {
            changeBook2UserRelation(authenticationService.getCurrentUser().getId(), slug, "in_cart");
        }
        addSlugToCookie("cartContents", cartContents, slug, response);
        if (postponedContents != null) {
            removeSlugFromCookie(slug, postponedContents, "postponedContents", response);
        }
    }

    public void addAllToCart(String cartContents, String postponedContents,
                             HttpServletResponse response, Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated()) {
            Long userId = authenticationService.getCurrentUser().getId();
            List<BookDto> postponedBooks = bookRepository
                    .findAllBooksDtoByUserIdAndRelation(userId, "postponed");
            postponedBooks.forEach(b -> changeBook2UserRelation(userId, b.getSlug(), "in_cart"));
        }
        if (cartContents != null && !cartContents.isEmpty()) {
            cartContents = cartContents + "/" + postponedContents;
        } else {
            cartContents = postponedContents;
        }
        postponedContents = "";
        Cookie cartCookie = new Cookie("cartContents", cartContents);
        cartCookie.setPath("/");
        response.addCookie(cartCookie);

        Cookie postponedCookie = new Cookie("postponedContents", postponedContents);
        postponedCookie.setPath("/");
        response.addCookie(postponedCookie);
    }

    public void addToPostponed(String slug, String cartContents, String postponedContents,
                               HttpServletResponse response, Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated()) {
            changeBook2UserRelation(authenticationService.getCurrentUser().getId(), slug, "postponed");
        }
        addSlugToCookie("postponedContents", postponedContents, slug, response);
        if (cartContents != null) {
            removeSlugFromCookie(slug, cartContents, "cartContents", response);
        }
    }

    public void addToArchived(String slug) {
        Long userId = authenticationService.getCurrentUser().getId();
        changeBook2UserRelation(userId, slug, "archived");
    }

    private void addSlugToCookie(String cookieName, String cookieContents, String slug, HttpServletResponse response) {
        ArrayList<String> booksCookies = new ArrayList<>();
        if (cookieContents != null && !cookieContents.equals("")) {
            booksCookies.addAll(Arrays.asList(cookieContents.split("/")));
        }
        if (!booksCookies.contains(slug)) {
            booksCookies.add(slug);
        }
        Cookie cookie = new Cookie(cookieName, String.join("/", booksCookies));
        cookie.setPath("/");
        response.addCookie(cookie);
    }
    
    public void removeSlugFromCookie(String bookSlug, String cookieString, String cookieName, HttpServletResponse response) {
        if (cookieString.contains(bookSlug)) {
            ArrayList<String> cookieBooks = new ArrayList<>(Arrays.asList(cookieString.split("/")));
            cookieBooks.remove(bookSlug);
            Cookie cookie = new Cookie(cookieName, String.join("/", cookieBooks));
            cookie.setPath("/");
            response.addCookie(cookie);
        }
    }

    public String getCookieContents(String cookieName, HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(cookieName)) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }

    public void removeBook2UserRelation(Long userId, String bookSlug) {
        Long bookId = bookRepository.findBySlug(bookSlug).getId();
        String book2UserTypeName = book2UserTypeEntityRepository.findTypeNameByBookIdAndUserId(bookId, userId).orElse("");
        if(book2UserTypeName.equals("postponed") || book2UserTypeName.equals("in_cart")) {
            Book2UserEntity book2UserEntity = book2UserEntityRepository.findByUserIdAndBookId(userId, bookId);
            book2UserEntityRepository.delete(book2UserEntity);
        }
    }

    public void changeBook2UserRelation(Long userId, String slug, String book2userType) {
        bookService.createOrUpdateBook2UserEntity(userId, slug, book2userType);
    }

    public void putCookieBooksToDB(String cookieValue, String user2BookRelationName) {
        getBookDtoListByCookie(cookieValue)
                .forEach(b -> changeBook2UserRelation(authenticationService.getCurrentUser().getId(), b.getSlug(), user2BookRelationName));
    }

    public Double getTotalPrice(String cookieContents) {
        return getBookDtoListByCookie(cookieContents)
                .stream()
                .mapToDouble(BookDto::getPrice)
                .sum();
    }

    public Double getTotalDiscountPrice(String cookieContents) {
        return getBookDtoListByCookie(cookieContents)
                .stream()
                .mapToDouble(b -> b.getPrice() * (100 - b.getDiscount()) / 100)
                .sum();
    }

    public Double getTotalPrice(UserDto userDto) {
        return userDto.getCartBooks()
                .stream()
                .mapToDouble(BookDto::getPrice)
                .sum();
    }

    public Double getTotalDiscountPrice(UserDto userDto) {
        return userDto.getCartBooks()
                .stream()
                .mapToDouble(b -> b.getPrice() * (100 - b.getDiscount()) / 100)
                .sum();
    }

    @Transactional
    public boolean hasSufficientBalance(UserDto userDto, Double totalCost) {
        return userDto.getBalance() >= totalCost;
    }

    @Transactional
    public boolean buy(UserDto userDto) {
        Double totalCost = getTotalDiscountPrice(userDto);
        if (!hasSufficientBalance(userDto, totalCost)) {
            return false;
        }
        userDto.getCartBooks().forEach(b -> {
            paymentService.createInternalPurchaseTransaction(userDto.getId(), -b.getPrice(), "Purchase: " + b.getTitle());
            changeBook2UserRelation(userDto.getId(), b.getSlug(), "purchased");
        });
        return true;
    }
}