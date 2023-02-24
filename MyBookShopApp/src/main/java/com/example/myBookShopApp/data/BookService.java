package com.example.myBookShopApp.data;

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
    public BookService(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<Book> getBooks(){
        List<Book> books = jdbcTemplate.query("SELECT * FROM books", (ResultSet rs, int rowNum) -> {
            Book book = new Book();
            book.setId(rs.getInt("id"));
            book.setAuthorId(rs.getInt("author_id"));
            book.setTitle(rs.getString("title"));
            book.setPriceOld(rs.getInt("price_old"));
            book.setPrice(rs.getInt("price"));
            return book;
        });
        return new ArrayList<>(books);
    }

    public List<BookData> getBooksData() {
        String sql = "SELECT b.id, b.title, a.first_name, a.last_name, b.price_old, b.price " +
                "FROM books b " +
                "INNER JOIN authors a ON b.author_id = a.id";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            BookData bookData = new BookData();
            bookData.setId(rs.getInt("id"));
            bookData.setTitle(rs.getString("title"));
            bookData.setAuthorFirstName(rs.getString("first_name"));
            bookData.setAuthorLastName(rs.getString("last_name"));
            bookData.setPriceOld(rs.getInt("price_old"));
            bookData.setPrice(rs.getInt("price"));
            return bookData;
        });
    }
}
