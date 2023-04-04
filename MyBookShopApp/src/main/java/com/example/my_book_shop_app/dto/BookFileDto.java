package com.example.my_book_shop_app.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class BookFileDto {
    private Long id;
    private Long bookId;
    private String hash;
    private String fileTypeName;
    private String path;
}
