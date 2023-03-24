package com.example.my_book_shop_app.dto;

import lombok.*;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@EqualsAndHashCode
public class TagCloudDto {
    private String tagName;
    private Long tagCount;
    private Integer fontSize;
}
