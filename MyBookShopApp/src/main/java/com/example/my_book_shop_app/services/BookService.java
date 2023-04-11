package com.example.my_book_shop_app.services;

import com.example.my_book_shop_app.data.model.Book;
import com.example.my_book_shop_app.data.model.book.file.BookFileEntity;
import com.example.my_book_shop_app.data.model.book.file.FileDownloadEntity;
import com.example.my_book_shop_app.data.model.book.links.Book2UserEntity;
import com.example.my_book_shop_app.data.model.tag.TagEntity;
import com.example.my_book_shop_app.data.repositories.*;
import com.example.my_book_shop_app.dto.BookDto;
import com.example.my_book_shop_app.dto.BookFileDto;
import com.example.my_book_shop_app.dto.TagCloudDto;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.InvalidDataAccessResourceUsageException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class BookService {

    private final BookRepository bookRepository;
    private final TagEntityRepository tagEntityRepository;
    private final FileDownloadEntityRepository fileDownloadEntityRepository;
    private final BookFileTypeEntityRepository bookFileTypeEntityRepository;
    private final BookFileEntityRepository bookFileEntityRepository;
    private final Book2UserEntityRepository book2UserEntityRepository;
    private final Book2UserTypeEntityRepository book2UserTypeEntityRepository;

    @Autowired
    public BookService(BookRepository bookRepository, TagEntityRepository tagEntityRepository,
                       FileDownloadEntityRepository fileDownloadEntityRepository,
                       BookFileTypeEntityRepository bookFileTypeEntityRepository,
                       BookFileEntityRepository bookFileEntityRepository,
                       Book2UserEntityRepository book2UserEntityRepository,
                       Book2UserTypeEntityRepository book2UserTypeEntityRepository) {
        this.bookRepository = bookRepository;
        this.tagEntityRepository = tagEntityRepository;
        this.fileDownloadEntityRepository = fileDownloadEntityRepository;
        this.bookFileTypeEntityRepository = bookFileTypeEntityRepository;
        this.bookFileEntityRepository = bookFileEntityRepository;
        this.book2UserEntityRepository = book2UserEntityRepository;
        this.book2UserTypeEntityRepository = book2UserTypeEntityRepository;
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
        return bookRepository.getPageOfBooksByPriceBetween(min, max, nextPage);
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

    public Page<BookDto> getPageOfRecommendedBooks(Long userId, Integer offset, Integer limit) {
        Pageable nextPage = PageRequest.of(offset, limit);
        return bookRepository.getPageOfRecommendedBooksDto(userId, nextPage);
    }

    public Page<BookDto> getPageOfRecentBooks(Integer offset, Integer limit, LocalDate fromDate, LocalDate toDate) {
        Pageable nextPage = PageRequest.of(offset, limit, Sort.by(Sort.Direction.DESC, "publicationDate"));
        if (fromDate == null) {
            fromDate = LocalDate.now().minusMonths(1);
        }
        if (toDate == null) {
            toDate = LocalDate.now();
        }
        return bookRepository.getPageOfRecentBooksDto(nextPage, fromDate, toDate);
    }

    public Page<BookDto> getPageOfPopularBooks(Integer offset, Integer limit) {
        Pageable nextPage = PageRequest.of(offset, limit);
        return bookRepository.getPageOfPopularBooksDto(nextPage);
    }

    public Page<BookDto> getPageOfSearchResultBooks(String searchWord, Integer offset, Integer limit) throws InvalidDataAccessResourceUsageException {
        Pageable nextPage = PageRequest.of(offset, limit);
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

    public BookDto getBookDtoBySlug(String slug) {
        return bookRepository.findBookDtoBySlug(slug);
    }

    public List<TagEntity> getTagsByBookSlug(String bookSlug) {
        return tagEntityRepository.findAllByBookSlug(bookSlug);
    }

    public Book getBookById(Long bookId) {
        return bookRepository.findById(bookId).orElse(null);
    }

    public void saveDownloadEntityByFileHash(String hash, Long userId) {
        BookFileEntity bookFile = bookFileEntityRepository.findBookFileByHash(hash);
        FileDownloadEntity download = fileDownloadEntityRepository.findByBookIdAndUserId(bookFile.getBookId(), userId);
        if (download != null) {
            download.setCount(download.getCount() + 1);
        } else {
            download = new FileDownloadEntity();
            download.setCount(1);
            download.setBookId(bookFile.getBookId());
            download.setUserId(userId);
        }
        fileDownloadEntityRepository.save(download);
    }

    public List<String> getBookFileTypesByBookSlug(String bookSlug) {
        return bookFileTypeEntityRepository.findAllByBookSlug(bookSlug);
    }

    public List<BookFileDto> getBookFilesByBookSlug(String slug) {
        return bookFileEntityRepository.getBookFileDtoListByBookSlug(slug);
    }

    public Book getBookByReviewId(Integer reviewId) {
        return bookRepository.findByReviewId(reviewId);
    }

    @Transactional
    public void updateBook2UserEntity(Long userId, String bookSlug, String type) {
        Long bookId = bookRepository.findBySlug(bookSlug).getId();
        Book2UserEntity book2UserEntity = book2UserEntityRepository.findByUserIdAndBookId(userId, bookId);
        if (book2UserEntity == null) {
            book2UserEntity = new Book2UserEntity();
            book2UserEntity.setBookId(bookId);
            book2UserEntity.setUserId(userId);
        }
        book2UserEntity.setTypeId(book2UserTypeEntityRepository.findByName(type).getId());
        book2UserEntity.setTime(LocalDateTime.now());
        book2UserEntityRepository.save(book2UserEntity);
    }

    public Book getBookBySlug(String bookSlug) {
        return bookRepository.findBySlug(bookSlug);
    }
}