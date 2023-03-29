package com.example.my_book_shop_app.util;

import com.example.my_book_shop_app.data.model.Author;
import com.example.my_book_shop_app.data.model.Book;
import com.example.my_book_shop_app.data.model.book.file.BookFileEntity;
import com.example.my_book_shop_app.data.model.book.file.BookFileTypeEntity;
import com.example.my_book_shop_app.data.model.book.file.FileDownloadEntity;
import com.example.my_book_shop_app.data.model.book.links.*;
import com.example.my_book_shop_app.data.model.book.review.BookReviewEntity;
import com.example.my_book_shop_app.data.model.book.review.BookReviewLikeEntity;
import com.example.my_book_shop_app.data.model.book.review.MessageEntity;
import com.example.my_book_shop_app.data.model.enums.ContactType;
import com.example.my_book_shop_app.data.model.genre.GenreEntity;
import com.example.my_book_shop_app.data.model.other.DocumentEntity;
import com.example.my_book_shop_app.data.model.other.FaqEntity;
import com.example.my_book_shop_app.data.model.payments.BalanceTransactionEntity;
import com.example.my_book_shop_app.data.model.tag.TagEntity;
import com.example.my_book_shop_app.data.model.user.UserContactEntity;
import com.example.my_book_shop_app.data.model.user.UserEntity;
import com.example.my_book_shop_app.data.repositories.*;
import com.github.javafaker.Faker;

import javax.annotation.PostConstruct;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

public class FakeDataFiller {

    private final AuthorRepository authorRepository;
    private final BookRepository bookRepository;
    private final Book2AuthorEntityRepository book2AuthorRepository;
    private final BookFileEntityRepository bookFileEntityRepository;
    private final BookFileTypeEntityRepository bookFileTypeEntityRepository;
    private final GenreEntityRepository genreRepository;
    private final UserEntityRepository userRepository;
    private final BalanceTransactionEntityRepository balanceTransactionEntityRepository;
    private final Book2GenreEntityRepository book2GenreEntityRepository;
    private final Book2UserEntityRepository book2UserEntityRepository;
    private final Book2UserTypeEntityRepository book2UserTypeEntityRepository;
    private final BookReviewEntityRepository bookReviewEntityRepository;
    private final BookReviewLikeEntityRepository bookReviewLikeEntityRepository;
    private final DocumentEntityRepository documentEntityRepository;
    private final FaqEntityRepository faqEntityRepository;
    private final FileDownloadEntityRepository fileDownloadEntityRepository;
    private final MessageEntityRepository messageEntityRepository;
    private final UserContactEntityRepository userContactEntityRepository;
    private final TagEntityRepository tagEntityRepository;
    private final Book2TagEntityRepository book2TagEntityRepository;
    private final Random random = new Random();
    private final Faker faker = new Faker(new Locale("en"));

    public FakeDataFiller(AuthorRepository authorRepository, BookRepository bookRepository,
                          Book2AuthorEntityRepository book2AuthorRepository, BookFileEntityRepository bookFileEntityRepository,
                          BookFileTypeEntityRepository bookFileTypeEntityRepository, GenreEntityRepository genreRepository,
                          UserEntityRepository userRepository, BalanceTransactionEntityRepository balanceTransactionEntityRepository,
                          Book2GenreEntityRepository book2GenreEntityRepository, Book2UserEntityRepository book2UserEntityRepository,
                          Book2UserTypeEntityRepository book2UserTypeEntityRepository, BookReviewEntityRepository bookReviewEntityRepository,
                          BookReviewLikeEntityRepository bookReviewLikeEntityRepository, DocumentEntityRepository documentEntityRepository,
                          FaqEntityRepository faqEntityRepository, FileDownloadEntityRepository fileDownloadEntityRepository,
                          MessageEntityRepository messageEntityRepository, UserContactEntityRepository userContactEntityRepository,
                          TagEntityRepository tagEntityRepository, Book2TagEntityRepository book2TagEntityRepository) {
        this.authorRepository = authorRepository;
        this.bookRepository = bookRepository;
        this.book2AuthorRepository = book2AuthorRepository;
        this.bookFileEntityRepository = bookFileEntityRepository;
        this.bookFileTypeEntityRepository = bookFileTypeEntityRepository;
        this.genreRepository = genreRepository;
        this.userRepository = userRepository;
        this.balanceTransactionEntityRepository = balanceTransactionEntityRepository;
        this.book2GenreEntityRepository = book2GenreEntityRepository;
        this.book2UserEntityRepository = book2UserEntityRepository;
        this.book2UserTypeEntityRepository = book2UserTypeEntityRepository;
        this.bookReviewEntityRepository = bookReviewEntityRepository;
        this.bookReviewLikeEntityRepository = bookReviewLikeEntityRepository;
        this.documentEntityRepository = documentEntityRepository;
        this.faqEntityRepository = faqEntityRepository;
        this.fileDownloadEntityRepository = fileDownloadEntityRepository;
        this.messageEntityRepository = messageEntityRepository;
        this.userContactEntityRepository = userContactEntityRepository;
        this.tagEntityRepository = tagEntityRepository;
        this.book2TagEntityRepository = book2TagEntityRepository;
    }

    private void generateRandomAuthors(int amount) {
        List<Author> authors = new ArrayList<>();
        for (int i = 0; i < amount; i++) {
            Author author = new Author();
            author.setPhoto("/assets/img/content/main/card2.jpg");
            author.setSlug(UUID.randomUUID().toString());
            author.setFirstName(faker.name().firstName());
            author.setLastName(faker.name().lastName());
            String description = String.join("\n", faker.lorem().paragraphs(random.nextInt(5) + 5));
            author.setDescription(description);
            authors.add(author);
        }
        authorRepository.saveAll(authors);
    }

    private void generateRandomBooks(int amount) {
        List<Book> books = new ArrayList<>();
        for (int i = 0; i < amount; i++) {
            Book book = new Book();
            book.setPublicationDate(LocalDate.now().minusDays(random.nextInt(365 * 10)));
            book.setBestseller(random.nextBoolean());
            book.setSlug(UUID.randomUUID().toString());
            book.setTitle(faker.book().title());
            book.setImage("/assets/img/content/main/card1.jpg");
            book.setDescription("This is a description of Book " + book.getTitle());
            book.setPrice((random.nextInt(5000) + 100) + random.nextDouble());
            book.setDiscount(random.nextInt(51));
            books.add(book);
        }
        bookRepository.saveAll(books);
    }

    private void generateRandomBook2AuthorEntities() {
        List<Book2AuthorEntity> book2AuthorEntities = new ArrayList<>();
        List<Book> books = bookRepository.findAll();
        List<Author> authors = authorRepository.findAll();
        for (Book book : books) {
            Book2AuthorEntity book2AuthorEntity = new Book2AuthorEntity();
            book2AuthorEntity.setBookId(book.getId());
            Author author = authors.get(random.nextInt(authors.size()));
            book2AuthorEntity.setAuthorId(author.getId());
            book2AuthorEntity.setSortIndex(random.nextInt(100));
            book2AuthorEntities.add(book2AuthorEntity);
        }
        book2AuthorRepository.saveAll(book2AuthorEntities);
    }

    private void generateRandomGenres(int amount) {
        List<GenreEntity> genres = new ArrayList<>();
        String[] initGenreNames = {"Light Reading","Fiction","Fighter","Securities / Investments","Accounting / Taxation / Audit",
                "Russian practice","Success Stories","Internet Marketing","Leadership","Project Management","Quality Management",
                "Financial Management","Personnel Management","Business Processes","Business Management","Detectives","Thriller",
                "Tough Detective","Ironic Detective","About Maniacs","Spy Detective","Crime Detective","Classic Detective",
                "Political Detective","Novels","Horror","Adventure","Serious Reading","Biographies","Business Literature",
                "Economic Management","Career","Marketing","PR","Advertising","Finance","Business References","Personal finance",
                "Management","Foreign business literature","Personal Effectiveness","Time Management","Small Business","Sales",
                "Startups and Business Creation","Corporate culture","Banking","Logistics","Real Estate","Internet Business",
                "Oratory / Rhetoric","Customer Attraction & Loyalty","Paperwork","Negotiations",
                "State and municipal government political management","Business Popular","Dramaturgy","Ancient Drama",
                "Comedy","Screenplay","Drama play","Fantasy"};
        Set<String> genreNames = Arrays.stream(initGenreNames).collect(Collectors.toSet());
        if(amount > genreNames.size()) {
            for (int i = 0; i < amount - genreNames.size(); i++) {
                genreNames.add(faker.book().genre());
            }
        }
        for (String genreName : genreNames) {
            GenreEntity genre = new GenreEntity();
            genre.setSlug(UUID.randomUUID().toString());
            genre.setName(genreName);
            genres.add(genre);
        }
        genreRepository.saveAll(genres);
        for (GenreEntity genre : genres) {
            if (random.nextBoolean()) {
                genre.setParentId(genres.get(random.nextInt(genres.size())).getId());
            } else {
                genre.setParentId(null);
            }
        }
        genreRepository.saveAll(genres);
    }

    private void generateRandomBookFileTypes(int amount) {
        List<BookFileTypeEntity> bookFileTypes = new ArrayList<>();

        for (int i = 0; i < amount; i++) {
            BookFileTypeEntity bookFileType = new BookFileTypeEntity();
            bookFileType.setName(faker.file().extension());
            bookFileType.setDescription(faker.lorem().sentence());

            bookFileTypes.add(bookFileType);
        }
        bookFileTypeEntityRepository.saveAll(bookFileTypes);
    }

    private void generateRandomBookFiles() {
        List<BookFileEntity> bookFiles = new ArrayList<>();
        List<Book> books = bookRepository.findAll();
        List<BookFileTypeEntity> fileTypes = bookFileTypeEntityRepository.findAll();

        for (Book book : books) {
            int numberOfBookFiles = random.nextInt(fileTypes.size() + 1);

            for (int j = 0; j < numberOfBookFiles; j++) {
                BookFileEntity bookFile = new BookFileEntity();
                BookFileTypeEntity fileType = fileTypes.get(j % fileTypes.size());
                bookFile.setHash(UUID.randomUUID().toString());
                bookFile.setFileType(fileType.getId());
                bookFile.setBookId(book.getId());
                bookFile.setPath("/path/to/book/file/book_" + bookFile.getBookId() + '.' + fileType.getName());

                bookFiles.add(bookFile);
            }
        }
        bookFileEntityRepository.saveAll(bookFiles);
    }

    private void generateRandomUsers(int amount) {
        List<UserEntity> users = new ArrayList<>();
        for (int i = 0; i < amount; i++) {
            UserEntity user = new UserEntity();
            user.setHash(UUID.randomUUID().toString());
            user.setRegTime(LocalDateTime.now()
                    .minusDays(random.nextInt(365 * 5))
                    .minusHours(random.nextInt(24))
                    .minusMinutes(random.nextInt(60)));
            user.setBalance(random.nextInt(100000));
            user.setName(faker.name().fullName());
            users.add(user);
        }
        userRepository.saveAll(users);
    }

    private void generateRandomBalanceTransactions(int amount) {
        List<UserEntity> users = userRepository.findAll();
        List<BalanceTransactionEntity> balanceTransactions = new ArrayList<>();
        List<Book> books = bookRepository.findAll();

        for (int i = 0; i < amount; i++) {
            UserEntity user = users.get(random.nextInt(users.size()));
            Book book = books.get(random.nextInt(books.size()));

            LocalDateTime transactionTime = LocalDateTime.now()
                    .minusDays(random.nextInt(365 * 5))
                    .minusHours(random.nextInt(24))
                    .minusMinutes(random.nextInt(60));

            if (transactionTime.isAfter(user.getRegTime())) {
                BalanceTransactionEntity transaction = new BalanceTransactionEntity();
                transaction.setTime(transactionTime);
                transaction.setBookId(book.getId());
                transaction.setValue(random.nextInt(5000) - 2500);
                transaction.setDescription(faker.lorem().sentence());
                transaction.setUserId(user.getId());

                balanceTransactions.add(transaction);
            } else {
                i--;
            }
        }
        balanceTransactionEntityRepository.saveAll(balanceTransactions);
    }

    private void generateRandomBook2GenreEntities() {
        List<Book> books = bookRepository.findAll();
        List<GenreEntity> genres = genreRepository.findAll();
        List<Book2GenreEntity> book2GenreEntities = new ArrayList<>();

        for (Book book : books) {
            int numberOfGenres = random.nextInt(3) + 1;
            Set<GenreEntity> assignedGenres = new HashSet<>();

            for (int i = 0; i < numberOfGenres; i++) {
                GenreEntity genre = genres.get(random.nextInt(genres.size()));

                while (assignedGenres.contains(genre)) {
                    genre = genres.get(random.nextInt(genres.size()));
                }
                assignedGenres.add(genre);

                Book2GenreEntity book2GenreEntity = new Book2GenreEntity();
                book2GenreEntity.setBookId(book.getId());
                book2GenreEntity.setGenreId(genre.getId());
                book2GenreEntities.add(book2GenreEntity);
            }
        }
        book2GenreEntityRepository.saveAll(book2GenreEntities);
    }

    private void generateRandomBook2UserEntities(int amount) {
        List<Book> books = bookRepository.findAll();
        List<UserEntity> users = userRepository.findAll();
        List<Book2UserEntity> book2UserEntities = new ArrayList<>();

        for (int i = 0; i < amount; i++) {
            UserEntity user = users.get(random.nextInt(users.size()));
            Book book = books.get(random.nextInt(books.size()));

            LocalDateTime book2UserTime = LocalDateTime.now()
                    .minusDays(random.nextInt(365 * 5))
                    .minusHours(random.nextInt(24))
                    .minusMinutes(random.nextInt(60));

            if (book2UserTime.isAfter(user.getRegTime()) && book2UserTime.isAfter(book.getPublicationDate().atStartOfDay())) {
                Book2UserEntity book2UserEntity = new Book2UserEntity();
                book2UserEntity.setTime(book2UserTime);

                if (!books.isEmpty()) {
                    book2UserEntity.setBookId(book.getId());
                }

                if (!users.isEmpty()) {
                    book2UserEntity.setUserId(user.getId());
                }

                book2UserEntity.setTypeId(
                        balanceTransactionEntityRepository.findByUserIdAndBookId(user.getId(), book.getId()) != null ?
                                4 : (random.nextInt(4) + 1)
                );
                book2UserEntities.add(book2UserEntity);
            } else {
                i--;
            }
        }
        book2UserEntityRepository.saveAll(book2UserEntities);
    }

    private void generateRandomBook2UserTypeEntities() {
        List<Book2UserTypeEntity> book2UserTypeEntities = new ArrayList<>();
        String[] types = {"null_type", "postponed", "in_cart", "purchased"};
        for (int i = 0; i < types.length; i++) {
            Book2UserTypeEntity book2UserTypeEntity = new Book2UserTypeEntity();
            book2UserTypeEntity.setName(types[i]);
            book2UserTypeEntity.setCode(String.valueOf(i));

            book2UserTypeEntities.add(book2UserTypeEntity);
        }
        book2UserTypeEntityRepository.saveAll(book2UserTypeEntities);
    }

    private void generateRandomBookReviewEntities(int amount) {
        List<BookReviewEntity> bookReviewEntities = new ArrayList<>();
        List<BalanceTransactionEntity> transactions = balanceTransactionEntityRepository.findAll();

        for (int i = 0; i < amount; i++) {
            BalanceTransactionEntity transaction = transactions.get(random.nextInt(transactions.size()));
            LocalDateTime reviewTime = LocalDateTime.now()
                    .minusDays(random.nextInt(365 * 3))
                    .minusHours(random.nextInt(24))
                    .minusMinutes(random.nextInt(60));

            if (reviewTime.isAfter(transaction.getTime())) {
                BookReviewEntity bookReviewEntity = new BookReviewEntity();
                bookReviewEntity.setUserId(transaction.getUserId());
                bookReviewEntity.setBookId(transaction.getBookId());
                bookReviewEntity.setText(faker.lorem().paragraph());
                bookReviewEntity.setTime(reviewTime);

                bookReviewEntities.add(bookReviewEntity);
            } else {
                i--;
            }
        }
        bookReviewEntityRepository.saveAll(bookReviewEntities);
    }

    private void generateRandomBookReviewLikeEntities(int amount) {
        List<BookReviewLikeEntity> bookReviewLikeEntities = new ArrayList<>();
        List<UserEntity> users = userRepository.findAll();
        List<BookReviewEntity> bookReviews = bookReviewEntityRepository.findAll();

        for (int i = 0; i < amount; i++) {
            BookReviewEntity bookReview = bookReviews.get(random.nextInt(bookReviews.size()));
            UserEntity user = users.get(random.nextInt(users.size()));

            LocalDateTime bookReviewLikeTime = LocalDateTime.now()
                    .minusDays(random.nextInt(365 * 5))
                    .minusHours(random.nextInt(24))
                    .minusMinutes(random.nextInt(60));

            if (bookReviewLikeTime.isAfter(bookReview.getTime()) && bookReviewLikeTime.isAfter(user.getRegTime())) {
                BookReviewLikeEntity bookReviewLikeEntity = new BookReviewLikeEntity();
                bookReviewLikeEntity.setUserId(user.getId());
                bookReviewLikeEntity.setReviewId(bookReview.getId());
                bookReviewLikeEntity.setValue((short) (random.nextInt(10) + 1));
                bookReviewLikeEntity.setTime(bookReviewLikeTime);

                bookReviewLikeEntities.add(bookReviewLikeEntity);
            } else {
                i--;
            }
        }
        bookReviewLikeEntityRepository.saveAll(bookReviewLikeEntities);
    }

    private void generateRandomDocumentEntities(int amount) {
        List<DocumentEntity> documentEntities = new ArrayList<>();

        for (int i = 0; i < amount; i++) {
            DocumentEntity documentEntity = new DocumentEntity();
            documentEntity.setTitle(faker.lorem().sentence());
            documentEntity.setSlug(UUID.randomUUID().toString());
            documentEntity.setText(faker.lorem().paragraph());
            if (random.nextBoolean()) {
                documentEntity.setSortIndex(random.nextInt(5) + 1);
            }

            documentEntities.add(documentEntity);
        }
        documentEntityRepository.saveAll(documentEntities);
    }

    private void generateRandomFaqEntities(int amount) {
        List<FaqEntity> faqEntities = new ArrayList<>();

        for (int i = 0; i < amount; i++) {
            FaqEntity faqEntity = new FaqEntity();
            faqEntity.setQuestion(faker.lorem().sentence());
            faqEntity.setAnswer(faker.lorem().paragraph());
            if (random.nextBoolean()) {
                faqEntity.setSortIndex(random.nextInt(5) + 1);
            }
            faqEntities.add(faqEntity);
        }
        faqEntityRepository.saveAll(faqEntities);
    }

    private void generateRandomFileDownloadEntities() {
        List<FileDownloadEntity> fileDownloadEntities = new ArrayList<>();
        List<BalanceTransactionEntity> transactions = balanceTransactionEntityRepository.findAll();

        for (int i = 0; i < transactions.size(); i+=2) {
            FileDownloadEntity fileDownloadEntity = new FileDownloadEntity();
            BalanceTransactionEntity transaction = transactions.get(i);
            fileDownloadEntity.setUserId(transaction.getUserId());
            fileDownloadEntity.setBookId(transaction.getBookId());
            fileDownloadEntity.setCount(random.nextInt(3) + 1);

            fileDownloadEntities.add(fileDownloadEntity);
        }
        fileDownloadEntityRepository.saveAll(fileDownloadEntities);
    }

    private void generateRandomUserContactEntities() {
        List<UserContactEntity> userContactEntities = new ArrayList<>();
        List<UserEntity> users = userRepository.findAll();
        String[] codes = {"code1", "code2", "code3"};
        for (UserEntity user : users) {
            UserContactEntity userContactEntity = new UserContactEntity();

            userContactEntity.setUserId(user.getId());
            userContactEntity.setType(random.nextBoolean() ? ContactType.EMAIL : ContactType.PHONE);
            userContactEntity.setContact(userContactEntity.getType() == ContactType.PHONE ?
                    faker.phoneNumber().phoneNumber() : faker.internet().emailAddress());
            userContactEntity.setCode(codes[random.nextInt(3)]);
            userContactEntity.setApproved((short) (random.nextBoolean() ? 0 : 1));
            userContactEntity.setCodeTime(user.getRegTime().plusMinutes(random.nextInt(10)));
            userContactEntity.setCodeTrails(userContactEntity.getCode().hashCode());

            userContactEntities.add(userContactEntity);
        }
        userContactEntityRepository.saveAll(userContactEntities);
    }

    private void generateRandomMessageEntities(int amount) {
        List<MessageEntity> messageEntities = new ArrayList<>();
        List<UserEntity> users = userRepository.findAll();

        for (int i = 0; i < amount; i++) {
            UserEntity user = users.get(random.nextInt(users.size()));

            LocalDateTime messageTime = LocalDateTime.now()
                    .minusDays(random.nextInt(365 * 2))
                    .minusHours(random.nextInt(24))
                    .minusMinutes(random.nextInt(60));

            if (messageTime.isAfter(user.getRegTime())) {
                MessageEntity messageEntity = new MessageEntity();
                if (random.nextBoolean()) {
                    messageEntity.setUserId(user.getId());
                    UserContactEntity contact = userContactEntityRepository.findByUserIdAndType(user.getId(), ContactType.EMAIL);
                    if(contact != null) {
                        messageEntity.setEmail(contact.getContact());
                    }
                    messageEntity.setName(user.getName());
                }
                messageEntity.setSubject(faker.lorem().sentence());
                messageEntity.setText(faker.lorem().paragraph(random.nextInt(4)));
                messageEntity.setTime(messageTime);

                messageEntities.add(messageEntity);
            } else {
                i--;
            }
        }
        messageEntityRepository.saveAll(messageEntities);
    }

    private void generateRandomTagEntities(int tagsCount) {
        String[] tags = {"contemporary literature", "classic literature", "foreign literature", "fantasy", "english literature",
                "russian literature", "american literature", "science fiction", "children's literature", "detective",
                "love", "mystery", "humor", "adventure", "fairy tale", "french literature", "england", "fiction", "psychology",
                "philosophy", "adaptation", "favorite", "dystopia", "books you must read before you die", "novel",
                "france", "two dollars", "young adult", "war", "history", "flashmob 2016", "childhood", "life", "drama",
                "russia", "book journey", "soviet literature", "thriller", "america", "german literature", "vampires",
                "school program", "short stories", "magic", "children", "russian classics", "flashmob 2015", "biography",
                "english"};
        List<TagEntity> tagEntityList = new ArrayList<>();
        for (String tag : tags) {
            TagEntity newTagEntity = new TagEntity();
            newTagEntity.setName(tag);
            tagEntityList.add(newTagEntity);
        }
        tagEntityRepository.saveAll(tagEntityList);
        if (tagsCount > tags.length) {
            Set<TagEntity> moreTags = new HashSet<>();
            for (int i = 0; i < (tagsCount - tags.length); i++) {
                TagEntity newTagEntity = new TagEntity();
                newTagEntity.setName(faker.rickAndMorty().location());
                moreTags.add(newTagEntity);
            }
            tagEntityRepository.saveAll(moreTags);
        }
    }

    private void generateRandomBook2TagEntities() {
        List<Book> books = bookRepository.findAll();
        List<TagEntity> tags = tagEntityRepository.findAll();
        List<Book2TagEntity> book2TagEntities = new ArrayList<>();

        for (Book book : books) {
            int numberOfTags = random.nextInt(4) + 1;
            Set<TagEntity> assignedTags = new HashSet<>();

            for (int i = 0; i < numberOfTags; i++) {
                TagEntity tag = tags.get(random.nextInt(tags.size()));

                while (assignedTags.contains(tag)) {
                    tag = tags.get(random.nextInt(tags.size()));
                }
                assignedTags.add(tag);

                Book2TagEntity book2TagEntity = new Book2TagEntity();
                book2TagEntity.setBookId(book.getId());
                book2TagEntity.setTagId(tag.getId());
                book2TagEntities.add(book2TagEntity);
            }
        }
        book2TagEntityRepository.saveAll(book2TagEntities);
    }

    @PostConstruct
    public void run() {
        generateRandomAuthors(10000);
        generateRandomBooks(200000);
        generateRandomBook2AuthorEntities();
        generateRandomGenres(200);
        generateRandomBook2GenreEntities();
        generateRandomTagEntities(75);
        generateRandomBook2TagEntities();
        generateRandomBookFileTypes(5);
        generateRandomBookFiles();
        generateRandomUsers(25000);
        generateRandomBook2UserTypeEntities();
        generateRandomBook2UserEntities(125000);
        generateRandomBalanceTransactions(50000);
        generateRandomBookReviewEntities(25000);
        generateRandomBookReviewLikeEntities(100000);
        generateRandomDocumentEntities(15);
        generateRandomFaqEntities(30);
        generateRandomFileDownloadEntities();
        generateRandomUserContactEntities();
        generateRandomMessageEntities(5000);
    }
}