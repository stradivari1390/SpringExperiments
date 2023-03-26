package com.example.my_book_shop_app.services;

import com.example.my_book_shop_app.data.model.tag.TagEntity;
import com.example.my_book_shop_app.data.repositories.BookRepository;
import com.example.my_book_shop_app.data.repositories.TagEntityRepository;
import com.example.my_book_shop_app.dto.BookDto;
import com.example.my_book_shop_app.dto.TagCloudDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.*;

@Service
public class BookService {

    private final BookRepository bookRepository;
    private final TagEntityRepository tagEntityRepository;

    @Autowired
    public BookService(BookRepository bookRepository, TagEntityRepository tagEntityRepository) {
        this.bookRepository = bookRepository;
        this.tagEntityRepository = tagEntityRepository;
    }

    public List<BookDto> getBooks() {
        return bookRepository.getBooksDto();
    }

    public Page<BookDto> getPageOfPostponedBooks(Long userId, Integer offset, Integer limit) {
        Pageable nextPage = PageRequest.of(offset, limit);
        return bookRepository.getPageOfPostponedBooks(userId, nextPage);
    }

    public Page<BookDto> getPageOfBooksByAuthor(String slug, Integer offset, Integer limit) {
        Pageable nextPage = PageRequest.of(offset, limit);
        return bookRepository.getPageOfBooksByAuthorSlug(slug, nextPage);
    }

    public Page<BookDto> getPageOfBooksByTitle(String title, Integer offset, Integer limit) {
        Pageable nextPage = PageRequest.of(offset, limit);
        return bookRepository.getPageOfBooksByTitleContaining(title, nextPage);
    }

    public Page<BookDto> getPageOfBooksWithPriceBetween(Double min, Double max, Integer offset, Integer limit) {
        Pageable nextPage = PageRequest.of(offset, limit);
        return bookRepository.getPageOfBooksByPriceBetween(min,max, nextPage);
    }

    public Page<BookDto> getPageOfBooksWithPrice(Double price, Integer offset, Integer limit) {
        Pageable nextPage = PageRequest.of(offset, limit);
        return bookRepository.getPageOfBooksByPriceIs(price, nextPage);
    }

    public Page<BookDto> getPageOfBooksWithMaxPrice(Integer offset, Integer limit) {
        Pageable nextPage = PageRequest.of(offset, limit);
        return bookRepository.getPageOfBooksWithMaxDiscount(nextPage);
    }

    public Page<BookDto> getPageOfBestsellers(Integer offset, Integer limit) {
        Pageable nextPage = PageRequest.of(offset, limit);
        return bookRepository.getPageOfBestsellers(nextPage);
    }

    public Page<BookDto> getPageOfBooks(Integer offset, Integer limit) {
        Pageable nextPage = PageRequest.of(offset, limit);
        return bookRepository.getPageOfBooksDto(nextPage);
    }

    public Page<BookDto> getPageOfRecommendedBooks(Long userId, Integer offset, Integer limit){
        Pageable nextPage = PageRequest.of(offset,limit);
        return bookRepository.getPageOfRecommendedBooksDto(userId, nextPage);
    }

    public Page<BookDto> getPageOfRecentBooks(Integer offset, Integer limit, LocalDate fromDate, LocalDate toDate) {
        Pageable nextPage = PageRequest.of(offset, limit, Sort.by(Sort.Direction.DESC, "publicationDate"));
        if (fromDate == null) fromDate = LocalDate.now().minusMonths(1);
        if (toDate == null) toDate = LocalDate.now();
        return bookRepository.getPageOfRecentBooksDto(nextPage, fromDate, toDate);
    }

    public Page<BookDto> getPageOfPopularBooks(Integer offset, Integer limit) {
        Pageable nextPage = PageRequest.of(offset,limit);
        return bookRepository.getPageOfPopularBooksDto(nextPage);
    }

    public Page<BookDto> getPageOfSearchResultBooks(String searchWord, Integer offset, Integer limit){
        Pageable nextPage = PageRequest.of(offset,limit);
        return bookRepository.getPageOfBooksByTitleContaining(searchWord, nextPage);
    }

    public Page<BookDto> getPageOfBooksByTag(String tag, Integer offset, Integer limit) {
        Pageable nextPage = PageRequest.of(offset, limit);
        return bookRepository.getPageOfBooksByTagName(tag, nextPage);
    }

    public List<TagCloudDto> getTagCloudData() {
        List<TagCloudDto> tagCloudData = tagEntityRepository.getTagCloudData();

        int minFontSize = 12;
        int maxFontSize = 24;

        Long minBookCount = tagCloudData.stream().mapToLong(TagCloudDto::getTagCount).min().orElse(1L);
        Long maxBookCount = tagCloudData.stream().mapToLong(TagCloudDto::getTagCount).max().orElse(1L);

        for (TagCloudDto tag : tagCloudData) {
            int fontSize = (int) (((tag.getTagCount() - minBookCount) * (maxFontSize - minFontSize) / (maxBookCount - minBookCount)) + minFontSize);
            tag.setFontSize(fontSize);
        }
        return tagCloudData;
    }

    public TagEntity getTagByName(String name) {
        return tagEntityRepository.findByName(name);
    }

    public Page<BookDto> getPageOfBooksByGenre(String slug, Integer offset, Integer limit) {
        Pageable nextPage = PageRequest.of(offset, limit);
        return bookRepository.getPageOfBooksByGenreSlug(slug, nextPage);
    }
}