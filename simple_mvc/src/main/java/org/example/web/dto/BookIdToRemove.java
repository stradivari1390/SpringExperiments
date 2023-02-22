package org.example.web.dto;

import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotNull;

public class BookIdToRemove {

    @NotNull
    @Getter
    @Setter
    private Integer id;
}