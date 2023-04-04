package com.example.my_book_shop_app.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class BookReviewDto {

    private Integer id;
    private Long bookId;
    private String userName;
    private LocalDateTime time;
    private String text;
    private long likes;
    private long dislikes;
}
