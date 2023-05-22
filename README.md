# MyBookShopApp
MyBookShopApp is a Spring Boot web application for a book store.  
*(Localized en, ru)*

Directory Structure
The Java main part of the project is organized as follows:
```
com.example.my_book_shop_app
├── annotations
├── aspects
├── config
├── controllers
├── data
│   ├── model
│   │   ├── book
│   │   │   ├── file
│   │   │   ├── links
│   │   │   └── review
│   │   ├── enums
│   │   ├── genre
│   │   ├── other
│   │   ├── payments
│   │   ├── tag
│   │   └── user
│   └── repositories
├── dto
├── exceptions
├── security
│   ├── jwt
│   ├── oauth
│   ├── security_config
│   ├── security_controller
│   ├── security_dto
│   └── security_services
├── selenium
├── services
└── util
```
* #### Configuration (config)
This directory contains configuration classes for the application, such as CORS, locale change, JPA, and scheduling.

* #### Controllers (controllers)
This directory contains the application's controller classes, responsible for handling HTTP requests and returning the appropriate views or responses.

* #### Data (data)
This directory contains classes related to the application's data layer, including entities, repositories, and a resource storage class.

* #### Model (data/model)
This directory contains entity classes representing the data model for the application.

* #### Repositories (data/repositories)
This directory contains repository interfaces for data access.

* #### Data Transfer Objects (dto)
This directory contains data transfer object (DTO) classes used to transfer data between various layers of the application.

* #### Security (security)
This directory contains classes related to user authentication and authorization, including JWT, OAuth2, and SMS services for user registration.

* #### Services (services)
This directory contains service classes that handle the application's business logic.

* #### Utilities (util)
This directory contains utility classes, such as a fake data filler.

## Installation
To run this application on a local machine, you will need to have the following software and dependencies installed:
* Java 17
* Maven
* PostgreSQL

Then, clone the repository to your local machine:

```bash
$ git clone https://github.com/stradivari1390/SpringExperiments.git
```

and run the application using the following command:

```bash
./mvnw spring-boot:run
```

## Configuration
The application can be configured by modifying the application.properties file. Here are the important configuration options:

* **server.port:** The port number that the application will run on.

* **data.generation:** Set to "false" if you don't want to generate data automatically, or "true" to enable data generation.

* **upload.path & download.path:** Set the paths for storing book cover images and book files.

* **spring.web.locale:** Set the default locale for the web application.

* **spring.messages.basename:** Set the basename for the messages file.

* **spring.datasource:** Configure the database connection details such as driverClassName, url, username, and password.

* **spring.jpa:** Configuration options for JPA and Hibernate, such as ddl-auto and properties.

* **spring.liquibase:** Configuration options for Liquibase, such as enabled, default-schema, change-log, and database connection details.

* **spring.security:** Configuration options for Spring Security, including user credentials and OAuth2 client registrations.

* **jwt.secret:** Secret key for JWT authentication.

* **logging:** Configuration options for logging, such as log level, log file name, logging patterns, and rolling policy.

* **twilio:** Configuration options for Twilio integration, such as account SID, auth token, and phone number.

### Docker-postgres
To raise a PostgreSQL database through Docker, you can follow these steps:

Make sure that Docker is installed on your system. You can do this by running docker --version in your terminal. If it is not installed, you can download it from Docker's official website.

Pull the official PostgreSQL image from the Docker Hub by running the following command:

```
docker pull postgres
```

Create a new container with the PostgreSQL image and set the necessary environment variables:

```
docker run --name your_container_name -e POSTGRES_USER=your_username -e POSTGRES_PASSWORD=your_password -e POSTGRES_DB=your_database_name -p 5432:5432 -d postgres
```

Update the spring.datasource.url property in your application.properties file to match the PostgreSQL container's address. The URL should look like this:

```
jdbc:postgresql://localhost:5432/your_database_name?currentSchema=book_store
```

Update the spring.datasource.username and spring.datasource.password properties in your application.properties file with the PostgreSQL username and password you specified in the docker run command.

After completing these steps, your application should be able to connect to the PostgreSQL database running in the Docker container.

## Technologies
This application uses:

* Spring Boot
* Spring RestApi
* Spring MVC
* Spring Security
* Spring Data ~~JDBC~~ JPA
* Spring Boot Test
* Jakarta Persistence, Hibernate
* Thymeleaf
* JavaScript
* ~~H2 Database~~ PostgreSQL
* Lombok
* Liquibase
* Swagger

to be continued

## Usage
Once the application is running, you can access the web interface at http://localhost:8080/. The Application allows you to browse books by author, genre, tags and search for books. You will be able to add books to your cart, view your cart, and checkout.

<img src="MyBookShopApp\src\main\resources\readme-images\book_shop_1.png" alt="gui_1" width="600"/>
<img src="MyBookShopApp\src\main\resources\readme-images\book_shop_2.png" alt="gui_2" width="600"/>
<img src="MyBookShopApp\src\main\resources\readme-images\book_shop_3.png" alt="gui_3" width="600"/>
<img src="MyBookShopApp\src\main\resources\readme-images\book_shop_4.png" alt="gui_4" width="600"/>
<img src="MyBookShopApp\src\main\resources\readme-images\book_shop_5.png" alt="gui_5" width="600"/>

## Implementations list
### Pages
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
- Algorithm for choosing recommended books
- Algorithm for calculating the rating of books
- Algorithm for calculating the rating of reviews
- Algorithm for determining the popularity of books
- Algorithm of the payment system
- Principles of postponing, moving to the cart and buying books
- Book search algorithm
- File download algorithm
- Authentication and authorization mechanisms (JWT, Oauth, SMS)

### Additional Tasks
The following additional tasks will be implemented in this application:

- Recently viewed books
- Telegram bot for choosing and buying books

## Contributing
If you'd like to contribute to this project, feel free to submit a pull request.

## License
This project is NOT under License yet.
