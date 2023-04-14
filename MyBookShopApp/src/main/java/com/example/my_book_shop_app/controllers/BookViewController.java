package com.example.my_book_shop_app.controllers;

import com.example.my_book_shop_app.data.ResourceStorage;
import com.example.my_book_shop_app.dto.BookDto;
import com.example.my_book_shop_app.security.BookstoreUserDetailsService;
import com.example.my_book_shop_app.security.BookstoreUserRegister;
import com.example.my_book_shop_app.services.AuthorService;
import com.example.my_book_shop_app.services.BookService;
import com.example.my_book_shop_app.services.BooksRatingAndPopularityService;
import com.example.my_book_shop_app.services.ReviewService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.data.domain.Page;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.nio.file.Path;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

@Controller
public class BookViewController {

    private final BookService bookService;
    private final AuthorService authorService;
    private final ReviewService reviewService;
    private final BooksRatingAndPopularityService booksRatingAndPopularityService;
    private final ResourceStorage storage;
    private final BookstoreUserRegister bookstoreUserRegister;
    private final BookstoreUserDetailsService bookstoreUserDetailsService;
    private final BookstoreUserRegister userRegister;

    @Autowired
    public BookViewController(BookService bookService, AuthorService authorService, ReviewService reviewService,
                              BooksRatingAndPopularityService booksRatingAndPopularityService, ResourceStorage storage,
                              BookstoreUserRegister bookstoreUserRegister, BookstoreUserDetailsService bookstoreUserDetailsService,
                              BookstoreUserRegister userRegister) {
        this.bookService = bookService;
        this.authorService = authorService;
        this.reviewService = reviewService;
        this.booksRatingAndPopularityService = booksRatingAndPopularityService;
        this.storage = storage;
        this.bookstoreUserRegister = bookstoreUserRegister;
        this.bookstoreUserDetailsService = bookstoreUserDetailsService;
        this.userRegister = userRegister;
    }

    @GetMapping("/books/recent")
    public String recentBooksPage(@RequestParam(value = "offset", defaultValue = "0") Integer offset,
                                  @RequestParam(value = "limit", defaultValue = "10") Integer limit,
                                  @RequestParam(value = "fromDate", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fromDate,
                                  @RequestParam(value = "toDate", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate toDate,
                                  Model model, Authentication authentication) {
        model.addAttribute("recentBooks", bookService.getPageOfRecentBooks(offset, limit, fromDate, toDate).getContent());
        if (authentication != null && authentication.isAuthenticated()) {
            model.addAttribute("authStatus", "authorized");
            model.addAttribute("curUsr", bookstoreUserDetailsService.getUserDtoById(userRegister.getCurrentUser().getId()));
        } else {
            model.addAttribute("authStatus", "unauthorized");
        }
        return "books/recent";
    }

    @GetMapping("/books/popular")
    public String popularBooksPage(@RequestParam(value = "offset", defaultValue = "0") Integer offset,
                                   @RequestParam(value = "limit", defaultValue = "10") Integer limit,
                                   Model model, Authentication authentication) {
        model.addAttribute("popularBooks", bookService.getPageOfPopularBooks(offset, limit).getContent());
        if (authentication != null && authentication.isAuthenticated()) {
            model.addAttribute("authStatus", "authorized");
            model.addAttribute("curUsr", bookstoreUserDetailsService.getUserDtoById(userRegister.getCurrentUser().getId()));
        } else {
            model.addAttribute("authStatus", "unauthorized");
        }
        return "books/popular";
    }

    @GetMapping("/books")
    public ModelAndView getBooksPage(
            @RequestParam(value = "offset", defaultValue = "0") Integer offset,
            @RequestParam(value = "limit", defaultValue = "10") Integer limit) {
        Page<BookDto> booksPage = bookService.getPageOfBooks(offset, limit);
        ModelAndView modelAndView = new ModelAndView("books");
        modelAndView.addObject("booksPage", booksPage);
        return modelAndView;
    }

    @GetMapping("/tags/index")
    public String tagsIndex(@RequestParam(value = "offset", defaultValue = "0") Integer offset,
                            @RequestParam(value = "limit", defaultValue = "10") Integer limit,
                            @RequestParam("tag") String tag,
                            Model model, Authentication authentication) {
        model.addAttribute("tag", bookService.getTagByName(tag));
        model.addAttribute("taggedBookPage", bookService.getPageOfBooksByTag(tag, offset, limit).getContent());
        if (authentication != null && authentication.isAuthenticated()) {
            model.addAttribute("authStatus", "authorized");
            model.addAttribute("curUsr", bookstoreUserDetailsService.getUserDtoById(userRegister.getCurrentUser().getId()));
        } else {
            model.addAttribute("authStatus", "unauthorized");
        }
        return "tags/index";
    }

    @GetMapping("/books/author")
    public String authorBooksPage(@RequestParam(value = "offset", defaultValue = "0") Integer offset,
                                  @RequestParam(value = "limit", defaultValue = "10") Integer limit,
                                  @RequestParam("authorSlug") String slug, Model model, Authentication authentication) {
        model.addAttribute("author", authorService.getAuthorBySlug(slug));
        model.addAttribute("booksPageByAuthor", bookService.getPageOfBooksByAuthor(slug, offset, limit).getContent());
        if (authentication != null && authentication.isAuthenticated()) {
            model.addAttribute("authStatus", "authorized");
            model.addAttribute("curUsr", bookstoreUserDetailsService.getUserDtoById(userRegister.getCurrentUser().getId()));
        } else {
            model.addAttribute("authStatus", "unauthorized");
        }
        return "books/author";
    }

    @GetMapping("/books/{slug}")
    public String authorSlugPage(@PathVariable("slug") String slug, Authentication authentication, Model model) {
        model.addAttribute("book", bookService.getBookDtoBySlug(slug));
        model.addAttribute("bookFiles", bookService.getBookFilesByBookSlug(slug));
        model.addAttribute("reviews", reviewService.getReviewDtoListByBookSlug(slug));
        model.addAttribute("starRates", booksRatingAndPopularityService.calculateStarRatesByBookSlug(slug));
        model.addAttribute("ratesCount", booksRatingAndPopularityService.countRatesByBookSlug(slug));
        model.addAttribute("tags", bookService.getTagsByBookSlug(slug));
        if (authentication != null && authentication.isAuthenticated()) {
            model.addAttribute("authStatus", "authorized");
            model.addAttribute("curUsr", bookstoreUserDetailsService.getUserDtoById(userRegister.getCurrentUser().getId()));
        } else {
            model.addAttribute("authStatus", "unauthorized");
        }
        return "books/slug";
    }

    @PostMapping("/submitReview")
    @ResponseBody
    public ResponseEntity<String> submitReview(@RequestBody Map<String, String> reviewData) {
        String slug = reviewData.get("slug");
        String reviewText = reviewData.get("text");
        Long userId = bookstoreUserRegister.getCurrentUser().getId();
        boolean success = reviewService.saveReview(slug, userId, reviewText);
        return success ? new ResponseEntity<>(HttpStatus.OK) : new ResponseEntity<>(HttpStatus.BAD_REQUEST);
    }

    @PostMapping("/rateBook")
    @ResponseBody
    public ResponseEntity<Map<String, String>> rateBook(@RequestParam("bookId") Long bookId,
                                                        @RequestParam("value") Short value) {
        booksRatingAndPopularityService.addRating(bookId, bookstoreUserRegister.getCurrentUser().getId(), value);
        String redirectUrl = "/books/" + bookService.getBookById(bookId).getSlug();

        Map<String, String> response = new HashMap<>();
        response.put("redirectUrl", redirectUrl);

        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @PostMapping("/rateBookReview")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> rateReview(@RequestParam("reviewid") int reviewId,
                                                          @RequestParam("value") Short value) {
        boolean success = reviewService.addReviewLike(reviewId, value, bookstoreUserRegister.getCurrentUser().getId());
        String redirectUrl = "/books/" + bookService.getBookByReviewId(reviewId).getSlug();

        Map<String, Object> response = new HashMap<>();
        response.put("redirectUrl", redirectUrl);
        response.put("result", success);

        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @GetMapping("/download/{hash}")
    public ResponseEntity<ByteArrayResource> bookFile(@PathVariable("hash") String hash) throws IOException {
        Path path = storage.getBookFilePath(hash);
        MediaType mediaType = storage.getBookFileMime(hash);
        byte[] data = storage.getBookFileByteArray(hash);
        bookService.saveDownloadEntityByFileHash(hash, bookstoreUserRegister.getCurrentUser().getId());
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment;filename=" + path.getFileName().toString())
                .contentType(mediaType)
                .contentLength(data.length)
                .body(new ByteArrayResource(data));
    }
}
