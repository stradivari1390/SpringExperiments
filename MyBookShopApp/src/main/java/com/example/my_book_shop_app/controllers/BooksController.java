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
    @ApiOperation("operation to get popular books list")
    public ResponseEntity<BooksPageDto> popularBooksPage(@RequestParam("offset") Integer offset,
                                                          @RequestParam("limit") Integer limit) {
        BooksPageDto popularBookPageDto = new BooksPageDto(bookService.getPageOfPopularBooks(offset, limit).getContent());
        return ResponseEntity.ok(popularBookPageDto);
    }

    @GetMapping("/books/by-author")
    @ApiOperation("operation to get book list of bookshop by passed author first name")
    public ResponseEntity<List<BookDto>> booksByAuthor(@RequestParam("author") String authorName,
                                                       @RequestParam("offset") Integer offset,
                                                       @RequestParam("limit") Integer limit) {
        return ResponseEntity.ok(bookService.getPageOfBooksByAuthor(authorName, offset, limit).getContent());
    }

    @GetMapping("/books/by-title")
    @ApiOperation("get books by book title")
    public ResponseEntity<List<BookDto>> booksByTitle(@RequestParam("title") String title,
                                                      @RequestParam("offset") Integer offset,
                                                      @RequestParam("limit") Integer limit) {
        return ResponseEntity.ok(bookService.getPageOfBooksByTitle(title, offset, limit).getContent());
    }

    @GetMapping("/books/by-price-range")
    @ApiOperation("get book by price range from min price to max price")
    public ResponseEntity<List<BookDto>> priceRangeBooks(@RequestParam("min") Double min,
                                                         @RequestParam("max") Double max,
                                                         @RequestParam("offset") Integer offset,
                                                         @RequestParam("limit") Integer limit) {
        return ResponseEntity.ok(bookService.getPageOfBooksWithPriceBetween(min, max, offset, limit).getContent());
    }

    @GetMapping("/books/with-max-discount")
    @ApiOperation("get list of book with max price")
    public ResponseEntity<List<BookDto>> maxPriceBooks(@RequestParam("offset") Integer offset,
                                                       @RequestParam("limit") Integer limit) {
        return ResponseEntity.ok(bookService.getPageOfBooksWithMaxPrice(offset, limit).getContent());
    }

    @GetMapping("/books/bestsellers")
    @ApiOperation("get bestseller books (which is_bestseller = 1)")
    public ResponseEntity<List<BookDto>> bestSellerBooks(@RequestParam("offset") Integer offset,
                                                         @RequestParam("limit") Integer limit) {
        return ResponseEntity.ok(bookService.getPageOfBestsellers(offset, limit).getContent());
    }

    @GetMapping("/books/tag")
    @ApiOperation("operation to get book list of bookshop by passed tag")
    public ResponseEntity<BooksPageDto> booksByTag(@RequestParam("tag") String tag,
                                                   @RequestParam("offset") Integer offset,
                                                   @RequestParam("limit") Integer limit) {
        BooksPageDto taggedBooksPageDto = new BooksPageDto(bookService.getPageOfBooksByTag(tag, offset, limit).getContent());
        return ResponseEntity.ok(taggedBooksPageDto);
    }

    @GetMapping("/tags/cloud")
    @ApiOperation("operation to get tag cloud data")
    public ResponseEntity<List<TagCloudDto>> getTagCloudData() {
        return ResponseEntity.ok(bookService.getTagCloudData());
    }
}