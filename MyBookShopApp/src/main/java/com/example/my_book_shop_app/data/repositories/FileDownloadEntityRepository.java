package com.example.my_book_shop_app.data.repositories;

import com.example.my_book_shop_app.data.model.book.file.FileDownloadEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FileDownloadEntityRepository extends JpaRepository<FileDownloadEntity, Integer> {
}