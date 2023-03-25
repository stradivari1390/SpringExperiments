package com.example.my_book_shop_app.controllers;

import com.example.my_book_shop_app.dto.BooksPageDto;
import com.example.my_book_shop_app.dto.TagCloudDto;
import com.example.my_book_shop_app.services.BookService;
import com.example.my_book_shop_app.dto.BookDto;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api")
@Api(tags = "Books API", description = "API endpoints for managing books data")
public class BooksController {

    private final BookService bookService;

    @Autowired
    public BooksController(BookService bookService) {
        this.bookService = bookService;
    }

    @GetMapping("/books/recommended")
    @ApiOperation("operation to get recommended books list")
    public ResponseEntity<BooksPageDto> getRecommendedBooksPage(@ApiParam(value = "The offset index for pagination", required = true) @RequestParam("offset") Integer offset,
                                                                @ApiParam(value = "The limit of items per page for pagination", required = true) @RequestParam("limit") Integer limit) {
        BooksPageDto recommendedBookPageDto = new BooksPageDto(bookService.getPageOfRecommendedBooks(440L, offset, limit).getContent());
        return ResponseEntity.ok(recommendedBookPageDto);
    }

    @GetMapping("/books/recent")
    @ApiOperation("operation to get recent books list")
    public ResponseEntity<BooksPageDto> recentBooksPage(@ApiParam(value = "The offset index for pagination", required = true) @RequestParam("offset") Integer offset,
                                                        @ApiParam(value = "The limit of items per page for pagination", required = true) @RequestParam("limit") Integer limit,
                                                        @ApiParam(value = "The start date for the recent books range", required = true) @RequestParam("fromDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fromDate,
                                                        @ApiParam(value = "The end date for the recent books range", required = true) @RequestParam("toDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate toDate) {
        BooksPageDto recentBookPageDto = new BooksPageDto(bookService.getPageOfRecentBooks(offset, limit, fromDate, toDate).getContent());
        return ResponseEntity.ok(recentBookPageDto);
    }

    @GetMapping("/books/popular")
    @ApiOperation("Get a list of popular books")
    public ResponseEntity<BooksPageDto> popularBooksPage(
            @ApiParam(value = "The offset index for pagination", required = true) @RequestParam("offset") Integer offset,
            @ApiParam(value = "The limit of items per page for pagination", required = true) @RequestParam("limit") Integer limit) {
        BooksPageDto popularBookPageDto = new BooksPageDto(bookService.getPageOfPopularBooks(offset, limit).getContent());
        return ResponseEntity.ok(popularBookPageDto);
    }

    @GetMapping("/books/by-author")
    @ApiOperation("Get a list of books by the author's first name")
    public ResponseEntity<List<BookDto>> booksByAuthor(
            @ApiParam(value = "Author's first name", required = true) @RequestParam("author") String authorName,
            @ApiParam(value = "The offset index for pagination", required = true) @RequestParam("offset") Integer offset,
            @ApiParam(value = "The limit of items per page for pagination", required = true) @RequestParam("limit") Integer limit) {
        return ResponseEntity.ok(bookService.getPageOfBooksByAuthor(authorName, offset, limit).getContent());
    }

    @GetMapping("/books/by-title")
    @ApiOperation("Get books by book title")
    public ResponseEntity<List<BookDto>> booksByTitle(
            @ApiParam(value = "Book title", required = true) @RequestParam("title") String title,
            @ApiParam(value = "The offset index for pagination", required = true) @RequestParam("offset") Integer offset,
            @ApiParam(value = "The limit of items per page for pagination", required = true) @RequestParam("limit") Integer limit) {
        return ResponseEntity.ok(bookService.getPageOfBooksByTitle(title, offset, limit).getContent());
    }

    @GetMapping("/books/by-price-range")
    @ApiOperation("Get books by price range from min price to max price")
    public ResponseEntity<List<BookDto>> priceRangeBooks(
            @ApiParam(value = "Minimum price", required = true) @RequestParam("min") Double min,
            @ApiParam(value = "Maximum price", required = true) @RequestParam("max") Double max,
            @ApiParam(value = "The offset index for pagination", required = true) @RequestParam("offset") Integer offset,
            @ApiParam(value = "The limit of items per page for pagination", required = true) @RequestParam("limit") Integer limit) {
        return ResponseEntity.ok(bookService.getPageOfBooksWithPriceBetween(min, max, offset, limit).getContent());
    }

    @GetMapping("/books/with-max-discount")
    @ApiOperation("Get a list of books with the maximum discount")
    public ResponseEntity<List<BookDto>> maxPriceBooks(
            @ApiParam(value = "The offset index for pagination", required = true) @RequestParam("offset") Integer offset,
            @ApiParam(value = "The limit of items per page for pagination", required = true) @RequestParam("limit") Integer limit) {
        return ResponseEntity.ok(bookService.getPageOfBooksWithMaxPrice(offset, limit).getContent());
    }

    @GetMapping("/books/bestsellers")
    @ApiOperation("Get a list of bestseller books (which is_bestseller = 1)")
    public ResponseEntity<List<BookDto>> bestSellerBooks(
            @ApiParam(value = "The offset index for pagination", required = true) @RequestParam("offset") Integer offset,
            @ApiParam(value = "The limit of items per page for pagination", required = true) @RequestParam("limit") Integer limit) {
        return ResponseEntity.ok(bookService.getPageOfBestsellers(offset, limit).getContent());
    }

    @GetMapping("/books/tag")
    @ApiOperation("Get a list of books by the specified tag")
    public ResponseEntity<BooksPageDto> booksByTag(
            @ApiParam(value = "Tag name", required = true) @RequestParam("tag") String tag,
            @ApiParam(value = "The offset index for pagination", required = true) @RequestParam("offset") Integer offset,
            @ApiParam(value = "The limit of items per page for pagination", required = true) @RequestParam("limit") Integer limit) {
        BooksPageDto taggedBooksPageDto = new BooksPageDto(bookService.getPageOfBooksByTag(tag, offset, limit).getContent());
        return ResponseEntity.ok(taggedBooksPageDto);
    }

    @GetMapping("/tags/cloud")
    @ApiOperation("Get tag cloud data")
    public ResponseEntity<List<TagCloudDto>> getTagCloudData() {
        return ResponseEntity.ok(bookService.getTagCloudData());
    }

    @GetMapping("/books/genre")
    @ApiOperation("Get a list of books by the specified genre")
    public ResponseEntity<BooksPageDto> booksByGenre(
            @ApiParam(value = "Genre name", required = true) @RequestParam("genre") String genre,
            @ApiParam(value = "The offset index for pagination", required = true) @RequestParam("offset") Integer offset,
            @ApiParam(value = "The limit of items per page for pagination", required = true) @RequestParam("limit") Integer limit) {
        BooksPageDto booksByGenrePageDto = new BooksPageDto(bookService.getPageOfBooksByGenre(genre, offset, limit).getContent());
        return ResponseEntity.ok(booksByGenrePageDto);
    }
}