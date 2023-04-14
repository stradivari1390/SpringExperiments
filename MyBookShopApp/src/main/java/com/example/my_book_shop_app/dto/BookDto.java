package com.example.my_book_shop_app.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BookDto {

    @ApiModelProperty("The book's unique identifier")
    private Long id;

    @ApiModelProperty("The book's slug")
    private String slug;

    @ApiModelProperty("The book's title")
    private String title;

    @ApiModelProperty("The book's cover image URL")
    private String image;

    @ApiModelProperty("A description of the book")
    private String description;

    @ApiModelProperty("The book's price")
    private Double price;

    @ApiModelProperty("The discount on the book's price")
    private Integer discount;

    @ApiModelProperty("Is the book a bestseller")
    private boolean bestseller;

    @ApiModelProperty("The rating of the book from 1 to 5")
    private Short rating;

    @ApiModelProperty("The first name of the book's author")
    private String authorFirstName;

    @ApiModelProperty("The last name of the book's author")
    private String authorLastName;

    @ApiModelProperty("The slug of the book's author")
    private String authorSlug;
}