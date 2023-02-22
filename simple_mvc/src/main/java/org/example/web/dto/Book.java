package org.example.web.dto;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.validation.constraints.Digits;
import javax.validation.constraints.NotBlank;

@Getter
@Setter
@EqualsAndHashCode
@ToString
public class Book {
    private Integer id;
    @NotBlank
    private String author;
    @NotBlank
    private String title;
    @Digits(integer = 4, fraction = 0)
    private Integer size;
}
