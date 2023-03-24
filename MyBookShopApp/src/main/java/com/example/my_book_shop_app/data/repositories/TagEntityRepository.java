package com.example.my_book_shop_app.data.repositories;

import com.example.my_book_shop_app.data.model.tag.TagEntity;
import com.example.my_book_shop_app.dto.TagCloudDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface TagEntityRepository extends JpaRepository<TagEntity, Integer> {
    TagEntity findByName(String name);

    @Query(value = "SELECT new com.example.my_book_shop_app.dto.TagCloudDto(t.name, COUNT(bt.tagId), 14) " +
            "FROM TagEntity t " +
            "JOIN Book2TagEntity bt ON t.id = bt.tagId " +
            "GROUP BY t.name")
    List<TagCloudDto> getTagCloudData();
}