package com.example.my_book_shop_app.services;

import com.example.my_book_shop_app.data.repositories.Book2UserEntityRepository;
import com.example.my_book_shop_app.data.repositories.BookRepository;
import com.example.my_book_shop_app.dto.BookDto;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public class CartService {

    private final BookRepository bookRepository;
    private final BookService bookService;
    private final Book2UserEntityRepository book2UserEntityRepository;

    @Autowired
    public CartService(BookRepository bookRepository, BookService bookService,
                       Book2UserEntityRepository book2UserEntityRepository) {
        this.bookRepository = bookRepository;
        this.bookService = bookService;
        this.book2UserEntityRepository = book2UserEntityRepository;
    }

    public Page<BookDto> getPageOfCartBooks(Long userId, Integer offset, Integer limit) {
        Pageable nextPage = PageRequest.of(offset, limit);
        return bookRepository.getPageOfBooksInCart(userId, nextPage);
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

    public List<BookDto> getBookDtoListByCookie(String cookieContents) {
        cookieContents = cookieContents.startsWith("/") ? cookieContents.substring(1) : cookieContents;
        cookieContents = cookieContents.endsWith("/") ? cookieContents.substring(0, cookieContents.length() - 1) : cookieContents;
        String[] cookieSlugs = cookieContents.split("/");
        return bookRepository.findAllBookDtoBySlug(cookieSlugs);
    }

    public List<String> getCookieBooksSlugs(String cookieContents) {
        cookieContents = cookieContents.startsWith("/") ? cookieContents.substring(1) : cookieContents;
        cookieContents = cookieContents.endsWith("/") ? cookieContents.substring(0, cookieContents.length() - 1) : cookieContents;
        String[] cookieSlugs = cookieContents.split("/");
        return List.of(cookieSlugs);
    }

    public void addToCart(String slug, Long userId, String cartContents, String postponedContents, HttpServletResponse response) {
        addSlugToCookie("cartContents", cartContents, slug, response);
        if (postponedContents != null) {
            removeSlugFromCookie(slug, postponedContents, "postponedContents", response);
        }
        bookService.updateBook2UserEntity(slug, userId, 4);
    }

    public void addAllToCart(Long userId, String cartContents, String postponedContents, HttpServletResponse response) {
        ArrayList<String> booksSlugsFromCookie = new ArrayList<>();
        if (cartContents != null && !cartContents.equals("")) {
            booksSlugsFromCookie.addAll(List.of(cartContents.split("/")));
        }
        List<String> postponedBooksSlugs;
        if (postponedContents != null && !postponedContents.equals("")) {
            postponedBooksSlugs = List.of(postponedContents.split("/"));
            booksSlugsFromCookie.addAll(postponedBooksSlugs);
            postponedBooksSlugs.forEach(bs -> bookService.updateBook2UserEntity(bs, userId, 4));
        }
        Cookie cartCookie = new Cookie("cartContents", String.join("/", booksSlugsFromCookie));
        cartCookie.setPath("/");
        Cookie postponedCookie = new Cookie("postponedContents", "");
        postponedCookie.setPath("/");
        response.addCookie(cartCookie);
        response.addCookie(postponedCookie);
    }

    public void addToPostponed(String slug, Long userId, String cartContents, String postponedContents, HttpServletResponse response) {
        addSlugToCookie("postponedContents", postponedContents, slug, response);
        if (cartContents != null) {
            removeSlugFromCookie(slug, cartContents, "cartContents", response);
        }
        bookService.updateBook2UserEntity(slug, userId, 3);
    }

    public void addToArchived(String slug, Long userId, String archivedContents, HttpServletResponse response) {
        addSlugToCookie("archivedContents", archivedContents, slug, response);
        bookService.updateBook2UserEntity(slug, userId, 1);
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

    @Transactional
    public void removeBook2UserRelation(Long userId, String bookSlug) {
        Long bookId = bookRepository.findBySlug(bookSlug).getId();
        book2UserEntityRepository.deleteByBookIdAndUserId(bookId, userId);
    }
}