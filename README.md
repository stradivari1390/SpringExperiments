# MyBookShopApp
MyBookShopApp is a Spring Boot web application for a book store.  
*(Localized en, ru)*

**It is under construction at this moment.**

## Installation
To run this application, you need to have Java 11 installed on your system. Then, you can download or clone the repository and run the application using the following command:

```bash
./mvnw spring-boot:run
```
Also, nothing additional is necessary to configure at this moment.
## Technologies
This application uses:

* Spring Boot
* Spring RestApi
* Spring MVC
* Spring Security
* Spring Data ~~JDBC~~ JPA
* Spring Boot Test
* Thymeleaf
* ~~H2 Database~~ PostgreSQL
* Lombok
* Liquibase

to be continued

## Usage
Once the application is running, you can access the web interface at http://localhost:8080/. In the future the application will allow you to browse books by author, genre, tags and search for books. You will be able to add books to your cart, view your cart, and checkout.

<img src="MyBookShopApp\src\main\resources\book_shop_1.jpg" alt="gui_1" width="600"/>
<img src="MyBookShopApp\src\main\resources\book_shop_2.jpg" alt="gui_2" width="600"/>
<img src="MyBookShopApp\src\main\resources\book_shop_3.jpg" alt="gui_3" width="600"/>

## What's going to be implemented
### Pages
The following pages are almost implemented in this application:
- Main page (/)
- Genres (/genres)
- Books by genre (/genres/SLUG)
- New books (/books/recent)
- Popular books (/books/popular)
- Authors (/authors)
- Author page (/authors/SLUG)
- Author's books (/books/author/SLUG)
- Login (/signin)
- Registration page (/signup)
- Cart (/cart)
- Postponed (/postponed)
- My profile (/profile)
- Transaction history (/transactions)
- Account replenishment (/payment)
- My books (/my)
- Search results (/search/QUERY, where QUERY is a search query)
- Books by tag (/tags/SLUG)
- Book page (/books/SLUG)
- Book download (pop-up window)
- Documents (/documents)
- Document (/documents/SLUG)
- About the company (/about)
- Help (/faq)
- Contacts (/contacts)

### Algorithms
The following algorithms will be implemented in this application:

- Algorithm for choosing recommended books
- Algorithm for calculating the rating of books
- Algorithm for calculating the rating of reviews
- Algorithm for determining the popularity of books
- Algorithm of the payment system
- Principles of postponing, moving to the cart and buying books
- Book search algorithm
- File download algorithm

### Additional Tasks
The following additional tasks may be implemented in this application:

- Recently viewed books
- Authorization restriction
- Telegram bot for choosing and buying books

## Contributing
If you'd like to contribute to this project, feel free to submit a pull request.

## License
This project is NOT under License yet.
