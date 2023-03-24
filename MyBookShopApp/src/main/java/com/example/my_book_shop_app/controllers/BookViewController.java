package com.example.my_book_shop_app.controllers;

import com.example.my_book_shop_app.dto.BookDto;
import com.example.my_book_shop_app.services.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDate;

@Controller
public class BookViewController {

    private final BookService bookService;

    @Autowired
    public BookViewController(BookService bookService) {
        this.bookService = bookService;
    }

    @GetMapping("/books/recent")
    public String recentBooksPage(@RequestParam(value = "offset", defaultValue = "0") Integer offset,
                                  @RequestParam(value = "limit", defaultValue = "10") Integer limit,
                                  @RequestParam(value = "fromDate", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fromDate,
                                  @RequestParam(value = "toDate", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate toDate,
                                  Model model) {
        model.addAttribute("recentBooks", bookService.getPageOfRecentBooks(offset, limit, fromDate, toDate).getContent());
        return "books/recent";
    }

    @GetMapping("/books/popular")
    public String popularBooksPage(@RequestParam(value = "offset", defaultValue = "0") Integer offset,
                                   @RequestParam(value = "limit", defaultValue = "10") Integer limit,
                                   Model model) {
        model.addAttribute("popularBooks", bookService.getPageOfPopularBooks(offset, limit).getContent());
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

    @GetMapping("/books/postponed")
    public String postponedPage(@RequestParam(value = "offset", defaultValue = "0") Integer offset,
                                @RequestParam(value = "limit", defaultValue = "10") Integer limit,
                                Model model) {
        model.addAttribute("postponedBooks", bookService.getPageOfPostponedBooks(440L, offset, limit).getContent());
        return "postponed";
    }

    @GetMapping("/tags/index")
    public String tagsIndex(@RequestParam(value = "offset", defaultValue = "0") Integer offset,
                            @RequestParam(value = "limit", defaultValue = "10") Integer limit,
                            @RequestParam("tag") String tag,
                            Model model) {
        model.addAttribute("tag", bookService.getTagByName(tag));
        model.addAttribute("taggedBookPage", bookService.getPageOfBooksByTag(tag, offset, limit).getContent());
        return "tags/index";
    }
}
