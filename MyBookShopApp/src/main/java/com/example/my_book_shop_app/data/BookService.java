package com.example.my_book_shop_app.data;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@Service
public class BookService {

    private final JdbcTemplate jdbcTemplate;

    @Autowired
    private BookService(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<Book> getBooksData() {
        List<Book> books = jdbcTemplate.query("SELECT * FROM books",(ResultSet rs, int rowNum) -> {
            Book book = new Book();
            book.setId(rs.getInt("id"));
            book.setAuthor(rs.getString("author"));
            book.setTitle(rs.getString("title"));
            book.setPriceOld(rs.getString("priceOld"));
            book.setPrice(rs.getString("price"));
            setDiscount(book);
            return book;
        });
        return new ArrayList<>(books);
    }

    public List<Book> getRecentBooks() {
        return getBooksData();
    }

    public List<Book> getPopularBooks() {
        return getBooksData();
    }

    public List<Book> getRecommendedBooks() {
        return getBooksData();
    }

    public List<Book> getPostponedBooks() {
        return getBooksData().subList(0, 3);
    }

    public List<Book> getCartBooks() {
        return getBooksData().subList(0, 3);
    }

    private void setDiscount(Book book) {
        if (book.getPrice() == null || book.getPriceOld() == null) {
            book.setDiscount("");
        } else {
            double oldPrice = Double.parseDouble(book.getPriceOld().replace("₽", ""));
            double newPrice = Double.parseDouble(book.getPrice().replace("₽", ""));
            double discountPercent = (1 - newPrice / oldPrice) * 100;
            book.setDiscount(String.format("-%.0f%%", discountPercent));
        }
    }
}