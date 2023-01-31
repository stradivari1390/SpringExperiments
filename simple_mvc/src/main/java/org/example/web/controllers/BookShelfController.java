package org.example.web.controllers;

import org.apache.log4j.Logger;
import org.example.app.services.BookService;
import org.example.web.dto.Book;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping(value = "/books")
public class BookShelfController {

    private static final String REDIRECT_TO_BOOKSHELF = "redirect:/books/shelf";
    private final Logger logger = Logger.getLogger(BookShelfController.class);
    private final BookService bookService;

    @Autowired
    public BookShelfController(BookService bookService) {
        this.bookService = bookService;
    }

    @GetMapping("/shelf")
    public String books(Model model) {
        logger.info("got book shelf");
        model.addAttribute("book", new Book());
        model.addAttribute("bookList", bookService.getAllBooks());
        return "book_shelf";
    }

    @PostMapping("/save")
    public String saveBook(Book book) {
        if (book.getAuthor() != null || book.getTitle() != null || book.getSize() != null) {
            bookService.saveBook(book);
            logger.info("current repository size: " + bookService.getAllBooks().size());
        }
        return REDIRECT_TO_BOOKSHELF;
    }

    @PostMapping("/remove")
    public String removeBook(@RequestParam(value = "bookIdToRemove") Integer bookIdToRemove, Model model) {
        if (!bookService.removeBookById(bookIdToRemove)) {
            model.addAttribute("errorMessage", "Could not find book with id " + bookIdToRemove);
        }
        return REDIRECT_TO_BOOKSHELF;
    }

    @PostMapping("/removeByRegex")
    public String removeBookByRegex(@RequestParam(value = "field") String field,
                                    @RequestParam(value = "regex") String regex,
                                    Model model) {
        if (!bookService.removeItemsByRegex(field, regex)) {
            model.addAttribute("errorMessage", "Could not find any books with specified parameters.");
        }
        return REDIRECT_TO_BOOKSHELF;
    }
}