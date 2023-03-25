package com.example.my_book_shop_app.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.*;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class TagCloudDto {

    @ApiModelProperty("The tag name")
    private String tagName;

    @ApiModelProperty("The number of occurrences of the tag")
    private Long tagCount;

    @ApiModelProperty("The font size representing the tag's popularity in the tag cloud")
    private Integer fontSize;
}