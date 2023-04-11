package com.example.my_book_shop_app.controllers;

import com.example.my_book_shop_app.data.ApiResponse;
import com.example.my_book_shop_app.dto.BookDto;
import com.example.my_book_shop_app.dto.BooksPageDto;
import com.example.my_book_shop_app.dto.TagCloudDto;
import com.example.my_book_shop_app.services.BookService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import io.swagger.annotations.ApiResponses;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Size;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api")
@Api(tags = "Books API")
@Validated
public class BooksController {

    private final BookService bookService;

    @Autowired
    public BooksController(BookService bookService) {
        this.bookService = bookService;
    }

    @GetMapping("/books/recommended")
    @ApiOperation("operation to get recommended books list")
    public BooksPageDto getRecommendedBooksPage(@ApiParam(value = "User's ID", required = true) @RequestParam("userId") Long userId,
                                                                @ApiParam(value = "The offset index for pagination", required = true) @RequestParam("offset") Integer offset,
                                                                @ApiParam(value = "The limit of items per page for pagination", required = true) @RequestParam("limit") Integer limit) {
        return new BooksPageDto(bookService.getPageOfRecommendedBooks(userId, offset, limit).getContent());
    }

    @GetMapping("/books/recent")
    @ApiOperation("operation to get recent books list")
    public BooksPageDto recentBooksPage(@ApiParam(value = "The offset index for pagination", required = true) @RequestParam("offset") Integer offset,
                                                        @ApiParam(value = "The limit of items per page for pagination", required = true) @RequestParam("limit") Integer limit,
                                                        @ApiParam(value = "The start date for the recent books range", required = true) @RequestParam("fromDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fromDate,
                                                        @ApiParam(value = "The end date for the recent books range", required = true) @RequestParam("toDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate toDate) {
        return new BooksPageDto(bookService.getPageOfRecentBooks(offset, limit, fromDate, toDate).getContent());
    }

    @GetMapping("/books/popular")
    @ApiOperation("Get a list of popular books")
    public BooksPageDto popularBooksPage(
            @ApiParam(value = "The offset index for pagination", required = true) @RequestParam("offset") Integer offset,
            @ApiParam(value = "The limit of items per page for pagination", required = true) @RequestParam("limit") Integer limit) {
        return new BooksPageDto(bookService.getPageOfPopularBooks(offset, limit).getContent());
    }

    @GetMapping("/books/author")
    @ApiOperation("Get a list of books by the author's slug")
    public BooksPageDto booksByAuthor(
            @ApiParam(value = "Author's slug", required = true) @RequestParam("authorSlug") String slug,
            @ApiParam(value = "The offset index for pagination", required = true) @RequestParam("offset") Integer offset,
            @ApiParam(value = "The limit of items per page for pagination", required = true) @RequestParam("limit") Integer limit) {
        return new BooksPageDto(bookService.getPageOfBooksByAuthor(slug, offset, limit).getContent());
    }

    @GetMapping("/books/by-title")
    @ApiOperation("Get books by book title")
    @ApiResponses(value = {
            @io.swagger.annotations.ApiResponse(code = 200, message = "Successful request"),
    })
    public ApiResponse<BookDto> booksByTitle(
            @ApiParam(value = "Book title", required = true) @Valid @Size(min = 3) @RequestParam("title") String title,
            @ApiParam(value = "The offset index for pagination", required = true) @RequestParam("offset") Integer offset,
            @ApiParam(value = "The limit of items per page for pagination", required = true) @RequestParam("limit") Integer limit) {

        ApiResponse<BookDto> response = new ApiResponse<>();
        List<BookDto> data = bookService.getPageOfBooksByTitle(title, offset, limit).getContent();
        response.setDebugMessage("successful request");
        response.setMessage("data size: " + data.size() + " elements");
        response.setStatus(HttpStatus.OK);
        response.setTimeStamp(LocalDateTime.now());
        response.setData(data);
        return response;
    }

    @GetMapping("/books/by-price-range")
    @ApiOperation("Get books by price range from min price to max price")
    public List<BookDto> priceRangeBooks(
            @ApiParam(value = "Minimum price", required = true) @Valid @Size @RequestParam("min") Double min,
            @ApiParam(value = "Maximum price", required = true) @Valid @Size @RequestParam("max") Double max,
            @ApiParam(value = "The offset index for pagination", required = true) @RequestParam("offset") Integer offset,
            @ApiParam(value = "The limit of items per page for pagination", required = true) @RequestParam("limit") Integer limit) {
        return bookService.getPageOfBooksWithPriceBetween(min, max, offset, limit).getContent();
    }

    @GetMapping("/books/with-max-discount")
    @ApiOperation("Get a list of books with the maximum discount")
    public List<BookDto> maxPriceBooks(
            @ApiParam(value = "The offset index for pagination", required = true) @RequestParam("offset") Integer offset,
            @ApiParam(value = "The limit of items per page for pagination", required = true) @RequestParam("limit") Integer limit) {
        return bookService.getPageOfBooksWithMaxPrice(offset, limit).getContent();
    }

    @GetMapping("/books/bestsellers")
    @ApiOperation("Get a list of bestseller books (which is_bestseller = 1)")
    public List<BookDto> bestSellerBooks(
            @ApiParam(value = "The offset index for pagination", required = true) @RequestParam("offset") Integer offset,
            @ApiParam(value = "The limit of items per page for pagination", required = true) @RequestParam("limit") Integer limit) {
        return bookService.getPageOfBestsellers(offset, limit).getContent();
    }

    @GetMapping("/books/tag")
    @ApiOperation("Get a list of books by the specified tag")
    public BooksPageDto booksByTag(
            @ApiParam(value = "Tag name", required = true) @RequestParam("tag") String tag,
            @ApiParam(value = "The offset index for pagination", required = true) @RequestParam("offset") Integer offset,
            @ApiParam(value = "The limit of items per page for pagination", required = true) @RequestParam("limit") Integer limit) {
        return new BooksPageDto(bookService.getPageOfBooksByTag(tag, offset, limit).getContent());
    }

    @GetMapping("/tags/cloud")
    @ApiOperation("Get tag cloud data")
    public List<TagCloudDto> getTagCloudData() {
        return bookService.getTagCloudData();
    }

    @GetMapping("/books/genre")
    @ApiOperation("Get a list of books by the specified genre")
    public BooksPageDto booksByGenre(
            @ApiParam(value = "Genre name", required = true) @RequestParam("genre") String genre,
            @ApiParam(value = "The offset index for pagination", required = true) @RequestParam("offset") Integer offset,
            @ApiParam(value = "The limit of items per page for pagination", required = true) @RequestParam("limit") Integer limit) {
        return new BooksPageDto(bookService.getPageOfBooksByGenre(genre, offset, limit).getContent());
    }
}