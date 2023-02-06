package org.example.app.services;

import org.apache.log4j.Logger;
import org.example.web.dto.Book;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Pattern;

@Repository
public class BookRepository implements ProjectRepository<Book> {

    private final Logger logger = Logger.getLogger(BookRepository.class);
    private final List<Book> repo = new ArrayList<>();

    @Override
    public List<Book> retrieveAll() {
        return new ArrayList<>(repo);
    }

    @Override
    public void store(Book book) {
        book.setId(book.hashCode());
        logger.info("store new book: " + book);
        repo.add(book);
    }

    @Override
    public boolean removeItemById(Integer bookIdToRemove) {
        for (Book book : retrieveAll()) {
            if (book.getId().equals(bookIdToRemove)) {
                logger.info("remove book completed: " + book);
                return repo.remove(book);
            }
        }
        return false;
    }

    @Override
    public boolean removeItemsByRegex(String field, String regex) {
        Pattern pattern = Pattern.compile(regex);
        int count = 0;
        for (Iterator<Book> iterator = repo.iterator(); iterator.hasNext();) {
            Book book = iterator.next();
            switch (field) {
                case "Author":
                    if (pattern.matcher(book.getAuthor()).matches()) {
                        iterator.remove();
                        count++;
                    }
                    break;
                case "Title":
                    if (pattern.matcher(book.getTitle()).matches()) {
                        iterator.remove();
                        count++;
                    }
                    break;
                case "Size":
                    if (pattern.matcher(String.valueOf(book.getSize())).matches()) {
                        iterator.remove();
                        count++;
                    }
                    break;
                default:
                    logger.info("Error: The specified field is not supported");
                    break;
            }
        }
        logger.info("remove books completed: " + count);
        return count > 0;
    }
}