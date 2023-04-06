package com.example.my_book_shop_app.data;

import com.example.my_book_shop_app.data.model.book.file.BookFileEntity;
import com.example.my_book_shop_app.data.repositories.BookFileEntityRepository;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.net.URLConnection;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.logging.Logger;

@Service
public class ResourceStorage {

    @Value("${upload.path}")
    String uploadPath;

    @Value("${download.path}")
    String downloadPath;

    private final BookFileEntityRepository bookFileEntityRepository;

    @Autowired
    public ResourceStorage(BookFileEntityRepository bookFileEntityRepository) {
        this.bookFileEntityRepository = bookFileEntityRepository;
    }

    public String saveNewBookImage(MultipartFile file, String slug) throws IOException {

        String resourceURI = null;

        if(!file.isEmpty()){
            if(!new File(uploadPath).exists()){
                Files.createDirectories(Paths.get(uploadPath));
                Logger.getLogger(this.getClass().getSimpleName()).info(() -> "created image folder in " + uploadPath);
            }

            String fileName = slug + "." + FilenameUtils.getExtension(file.getOriginalFilename());
            Path path = Paths.get(uploadPath,fileName);
            resourceURI = "/book-covers/" + fileName;
            file.transferTo(path);
            Logger.getLogger(this.getClass().getSimpleName()).info(() -> fileName + " uploaded OK!");
        }
        return resourceURI;
    }

    public Path getBookFilePath(String hash) {
        BookFileEntity bookFile = bookFileEntityRepository.findBookFileByHash(hash);
        return Paths.get(bookFile.getPath());
    }

    public MediaType getBookFileMime(String hash) {
        BookFileEntity bookFile = bookFileEntityRepository.findBookFileByHash(hash);
        String mimeType = URLConnection.guessContentTypeFromName(Paths.get(bookFile.getPath()).getFileName().toString());
        if (mimeType != null) {
            return MediaType.parseMediaType(mimeType);
        } else {
            return MediaType.APPLICATION_OCTET_STREAM;
        }
    }

    public byte[] getBookFileByteArray(String hash) throws IOException {
        BookFileEntity bookFile = bookFileEntityRepository.findBookFileByHash(hash);
        Path path = Paths.get(bookFile.getPath());
        return Files.readAllBytes(path);
    }
}