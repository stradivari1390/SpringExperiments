--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2 (Debian 15.2-1.pgdg110+1)
-- Dumped by pg_dump version 15.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: book_store; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA book_store;


ALTER SCHEMA book_store OWNER TO postgres;

--
-- Name: author_id_seq; Type: SEQUENCE; Schema: book_store; Owner: postgres
--

CREATE SEQUENCE book_store.author_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE book_store.author_id_seq OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: authors; Type: TABLE; Schema: book_store; Owner: postgres
--

CREATE TABLE book_store.authors (
    id bigint NOT NULL,
    description text,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    photo character varying(255),
    slug character varying(255) NOT NULL
);


ALTER TABLE book_store.authors OWNER TO postgres;

--
-- Name: balance_transaction; Type: TABLE; Schema: book_store; Owner: postgres
--

CREATE TABLE book_store.balance_transaction (
    id integer NOT NULL,
    book_id integer NOT NULL,
    description text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    user_id integer NOT NULL,
    value integer DEFAULT 0 NOT NULL
);


ALTER TABLE book_store.balance_transaction OWNER TO postgres;

--
-- Name: balance_transaction_id_seq; Type: SEQUENCE; Schema: book_store; Owner: postgres
--

CREATE SEQUENCE book_store.balance_transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE book_store.balance_transaction_id_seq OWNER TO postgres;

--
-- Name: balance_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: book_store; Owner: postgres
--

ALTER SEQUENCE book_store.balance_transaction_id_seq OWNED BY book_store.balance_transaction.id;


--
-- Name: book2author; Type: TABLE; Schema: book_store; Owner: postgres
--

CREATE TABLE book_store.book2author (
    id bigint NOT NULL,
    author_id integer NOT NULL,
    book_id integer NOT NULL,
    sort_index integer DEFAULT 0 NOT NULL
);


ALTER TABLE book_store.book2author OWNER TO postgres;

--
-- Name: book2author_id_seq; Type: SEQUENCE; Schema: book_store; Owner: postgres
--

CREATE SEQUENCE book_store.book2author_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE book_store.book2author_id_seq OWNER TO postgres;

--
-- Name: book2author_id_seq; Type: SEQUENCE OWNED BY; Schema: book_store; Owner: postgres
--

ALTER SEQUENCE book_store.book2author_id_seq OWNED BY book_store.book2author.id;


--
-- Name: book2genre; Type: TABLE; Schema: book_store; Owner: postgres
--

CREATE TABLE book_store.book2genre (
    id integer NOT NULL,
    book_id integer NOT NULL,
    genre_id integer NOT NULL
);


ALTER TABLE book_store.book2genre OWNER TO postgres;

--
-- Name: book2genre_id_seq; Type: SEQUENCE; Schema: book_store; Owner: postgres
--

CREATE SEQUENCE book_store.book2genre_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE book_store.book2genre_id_seq OWNER TO postgres;

--
-- Name: book2genre_id_seq; Type: SEQUENCE OWNED BY; Schema: book_store; Owner: postgres
--

ALTER SEQUENCE book_store.book2genre_id_seq OWNED BY book_store.book2genre.id;


--
-- Name: book2user; Type: TABLE; Schema: book_store; Owner: postgres
--

CREATE TABLE book_store.book2user (
    id integer NOT NULL,
    book_id integer NOT NULL,
    "time" timestamp without time zone NOT NULL,
    type_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE book_store.book2user OWNER TO postgres;

--
-- Name: book2user_id_seq; Type: SEQUENCE; Schema: book_store; Owner: postgres
--

CREATE SEQUENCE book_store.book2user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE book_store.book2user_id_seq OWNER TO postgres;

--
-- Name: book2user_id_seq; Type: SEQUENCE OWNED BY; Schema: book_store; Owner: postgres
--

ALTER SEQUENCE book_store.book2user_id_seq OWNED BY book_store.book2user.id;


--
-- Name: book2user_type; Type: TABLE; Schema: book_store; Owner: postgres
--

CREATE TABLE book_store.book2user_type (
    id integer NOT NULL,
    code character varying(255) NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE book_store.book2user_type OWNER TO postgres;

--
-- Name: book2user_type_id_seq; Type: SEQUENCE; Schema: book_store; Owner: postgres
--

CREATE SEQUENCE book_store.book2user_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE book_store.book2user_type_id_seq OWNER TO postgres;

--
-- Name: book2user_type_id_seq; Type: SEQUENCE OWNED BY; Schema: book_store; Owner: postgres
--

ALTER SEQUENCE book_store.book2user_type_id_seq OWNED BY book_store.book2user_type.id;


--
-- Name: book_file; Type: TABLE; Schema: book_store; Owner: postgres
--

CREATE TABLE book_store.book_file (
    id bigint NOT NULL,
    type_id integer NOT NULL,
    hash character varying(255) NOT NULL,
    path character varying(255) NOT NULL
);


ALTER TABLE book_store.book_file OWNER TO postgres;

--
-- Name: book_file_id_seq; Type: SEQUENCE; Schema: book_store; Owner: postgres
--

CREATE SEQUENCE book_store.book_file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE book_store.book_file_id_seq OWNER TO postgres;

--
-- Name: book_file_type; Type: TABLE; Schema: book_store; Owner: postgres
--

CREATE TABLE book_store.book_file_type (
    id bigint NOT NULL,
    description text,
    name character varying(255) NOT NULL
);


ALTER TABLE book_store.book_file_type OWNER TO postgres;

--
-- Name: book_file_type_id_seq; Type: SEQUENCE; Schema: book_store; Owner: postgres
--

CREATE SEQUENCE book_store.book_file_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE book_store.book_file_type_id_seq OWNER TO postgres;

--
-- Name: book_id_seq; Type: SEQUENCE; Schema: book_store; Owner: postgres
--

CREATE SEQUENCE book_store.book_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE book_store.book_id_seq OWNER TO postgres;

--
-- Name: book_review; Type: TABLE; Schema: book_store; Owner: postgres
--

CREATE TABLE book_store.book_review (
    id integer NOT NULL,
    book_id integer NOT NULL,
    text text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE book_store.book_review OWNER TO postgres;

--
-- Name: book_review_id_seq; Type: SEQUENCE; Schema: book_store; Owner: postgres
--

CREATE SEQUENCE book_store.book_review_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE book_store.book_review_id_seq OWNER TO postgres;

--
-- Name: book_review_id_seq; Type: SEQUENCE OWNED BY; Schema: book_store; Owner: postgres
--

ALTER SEQUENCE book_store.book_review_id_seq OWNED BY book_store.book_review.id;


--
-- Name: book_review_like; Type: TABLE; Schema: book_store; Owner: postgres
--

CREATE TABLE book_store.book_review_like (
    id integer NOT NULL,
    review_id integer NOT NULL,
    "time" timestamp without time zone NOT NULL,
    user_id integer NOT NULL,
    value smallint NOT NULL
);


ALTER TABLE book_store.book_review_like OWNER TO postgres;

--
-- Name: book_review_like_id_seq; Type: SEQUENCE; Schema: book_store; Owner: postgres
--

CREATE SEQUENCE book_store.book_review_like_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE book_store.book_review_like_id_seq OWNER TO postgres;

--
-- Name: book_review_like_id_seq; Type: SEQUENCE OWNED BY; Schema: book_store; Owner: postgres
--

ALTER SEQUENCE book_store.book_review_like_id_seq OWNED BY book_store.book_review_like.id;


--
-- Name: books; Type: TABLE; Schema: book_store; Owner: postgres
--

CREATE TABLE book_store.books (
    id bigint NOT NULL,
    description text,
    discount integer NOT NULL,
    image character varying(255),
    is_bestseller boolean NOT NULL,
    price double precision NOT NULL,
    pub_date date NOT NULL,
    slug character varying(255) NOT NULL,
    title character varying(255) NOT NULL
);


ALTER TABLE book_store.books OWNER TO postgres;

--
-- Name: document; Type: TABLE; Schema: book_store; Owner: postgres
--

CREATE TABLE book_store.document (
    id bigint NOT NULL,
    slug character varying(255) NOT NULL,
    sort_index integer DEFAULT 0 NOT NULL,
    text text NOT NULL,
    title character varying(255) NOT NULL
);


ALTER TABLE book_store.document OWNER TO postgres;

--
-- Name: document_id_seq; Type: SEQUENCE; Schema: book_store; Owner: postgres
--

CREATE SEQUENCE book_store.document_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE book_store.document_id_seq OWNER TO postgres;

--
-- Name: faq; Type: TABLE; Schema: book_store; Owner: postgres
--

CREATE TABLE book_store.faq (
    id bigint NOT NULL,
    answer text NOT NULL,
    question character varying(255) NOT NULL,
    sort_index integer DEFAULT 0 NOT NULL
);


ALTER TABLE book_store.faq OWNER TO postgres;

--
-- Name: faq_id_seq; Type: SEQUENCE; Schema: book_store; Owner: postgres
--

CREATE SEQUENCE book_store.faq_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE book_store.faq_id_seq OWNER TO postgres;

--
-- Name: file_download; Type: TABLE; Schema: book_store; Owner: postgres
--

CREATE TABLE book_store.file_download (
    id bigint NOT NULL,
    book_id integer NOT NULL,
    count integer DEFAULT 1 NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE book_store.file_download OWNER TO postgres;

--
-- Name: file_download_id_seq; Type: SEQUENCE; Schema: book_store; Owner: postgres
--

CREATE SEQUENCE book_store.file_download_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE book_store.file_download_id_seq OWNER TO postgres;

--
-- Name: genre; Type: TABLE; Schema: book_store; Owner: postgres
--

CREATE TABLE book_store.genre (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    parent_id integer,
    slug character varying(255) NOT NULL
);


ALTER TABLE book_store.genre OWNER TO postgres;

--
-- Name: genre_id_seq; Type: SEQUENCE; Schema: book_store; Owner: postgres
--

CREATE SEQUENCE book_store.genre_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE book_store.genre_id_seq OWNER TO postgres;

--
-- Name: genre_id_seq; Type: SEQUENCE OWNED BY; Schema: book_store; Owner: postgres
--

ALTER SEQUENCE book_store.genre_id_seq OWNED BY book_store.genre.id;


--
-- Name: message; Type: TABLE; Schema: book_store; Owner: postgres
--

CREATE TABLE book_store.message (
    id bigint NOT NULL,
    email character varying(255),
    name character varying(255),
    subject character varying(255) NOT NULL,
    text text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    user_id integer
);


ALTER TABLE book_store.message OWNER TO postgres;

--
-- Name: message_id_seq; Type: SEQUENCE; Schema: book_store; Owner: postgres
--

CREATE SEQUENCE book_store.message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE book_store.message_id_seq OWNER TO postgres;

--
-- Name: user_contact; Type: TABLE; Schema: book_store; Owner: postgres
--

CREATE TABLE book_store.user_contact (
    id integer NOT NULL,
    approved smallint NOT NULL,
    code character varying(255) NOT NULL,
    code_time timestamp without time zone,
    code_trails integer,
    contact character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE book_store.user_contact OWNER TO postgres;

--
-- Name: user_contact_id_seq; Type: SEQUENCE; Schema: book_store; Owner: postgres
--

CREATE SEQUENCE book_store.user_contact_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE book_store.user_contact_id_seq OWNER TO postgres;

--
-- Name: user_contact_id_seq; Type: SEQUENCE OWNED BY; Schema: book_store; Owner: postgres
--

ALTER SEQUENCE book_store.user_contact_id_seq OWNED BY book_store.user_contact.id;


--
-- Name: user_id_seq; Type: SEQUENCE; Schema: book_store; Owner: postgres
--

CREATE SEQUENCE book_store.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE book_store.user_id_seq OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: book_store; Owner: postgres
--

CREATE TABLE book_store.users (
    id bigint NOT NULL,
    balance integer NOT NULL,
    hash character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    reg_time timestamp without time zone NOT NULL
);


ALTER TABLE book_store.users OWNER TO postgres;

--
-- Name: balance_transaction id; Type: DEFAULT; Schema: book_store; Owner: postgres
--

ALTER TABLE ONLY book_store.balance_transaction ALTER COLUMN id SET DEFAULT nextval('book_store.balance_transaction_id_seq'::regclass);


--
-- Name: book2author id; Type: DEFAULT; Schema: book_store; Owner: postgres
--

ALTER TABLE ONLY book_store.book2author ALTER COLUMN id SET DEFAULT nextval('book_store.book2author_id_seq'::regclass);


--
-- Name: book2genre id; Type: DEFAULT; Schema: book_store; Owner: postgres
--

ALTER TABLE ONLY book_store.book2genre ALTER COLUMN id SET DEFAULT nextval('book_store.book2genre_id_seq'::regclass);


--
-- Name: book2user id; Type: DEFAULT; Schema: book_store; Owner: postgres
--

ALTER TABLE ONLY book_store.book2user ALTER COLUMN id SET DEFAULT nextval('book_store.book2user_id_seq'::regclass);


--
-- Name: book2user_type id; Type: DEFAULT; Schema: book_store; Owner: postgres
--

ALTER TABLE ONLY book_store.book2user_type ALTER COLUMN id SET DEFAULT nextval('book_store.book2user_type_id_seq'::regclass);


--
-- Name: book_review id; Type: DEFAULT; Schema: book_store; Owner: postgres
--

ALTER TABLE ONLY book_store.book_review ALTER COLUMN id SET DEFAULT nextval('book_store.book_review_id_seq'::regclass);


--
-- Name: book_review_like id; Type: DEFAULT; Schema: book_store; Owner: postgres
--

ALTER TABLE ONLY book_store.book_review_like ALTER COLUMN id SET DEFAULT nextval('book_store.book_review_like_id_seq'::regclass);


--
-- Name: genre id; Type: DEFAULT; Schema: book_store; Owner: postgres
--

ALTER TABLE ONLY book_store.genre ALTER COLUMN id SET DEFAULT nextval('book_store.genre_id_seq'::regclass);


--
-- Name: user_contact id; Type: DEFAULT; Schema: book_store; Owner: postgres
--

ALTER TABLE ONLY book_store.user_contact ALTER COLUMN id SET DEFAULT nextval('book_store.user_contact_id_seq'::regclass);


--
-- Data for Name: authors; Type: TABLE DATA; Schema: book_store; Owner: postgres
--

INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (1, 'Ullam consequatur ab id.', 'Laurie', 'Prohaska', '/spring-frontend/assets/img/content/main/card2.jpg', '683feff6-383d-4655-9e94-e5a5ce101ad5');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (2, 'Rerum quae laborum qui possimus.', 'Glynda', 'Schroeder', '/spring-frontend/assets/img/content/main/card2.jpg', 'ff0e009e-167d-4e10-8014-fb1d80107a28');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (3, 'Quae excepturi omnis quia quia est eveniet eveniet.', 'Charlie', 'Wilkinson', '/spring-frontend/assets/img/content/main/card2.jpg', '4d1199ab-ba35-49fd-acd3-900493e9c0f3');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (4, 'Vero quibusdam tempora iusto debitis corporis rem expedita.', 'Thomas', 'Treutel', '/spring-frontend/assets/img/content/main/card2.jpg', '7e0e0d16-dbc3-41f6-a98f-60df6777c9f4');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (5, 'Et earum magnam deleniti unde consequatur rem.', 'Sidney', 'Kerluke', '/spring-frontend/assets/img/content/main/card2.jpg', 'c246bb88-6f87-4e53-a881-9277add8d785');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (6, 'Iste nesciunt qui consequatur.', 'Yahaira', 'Gottlieb', '/spring-frontend/assets/img/content/main/card2.jpg', 'b14b5ea7-22b1-48c3-b112-2acf0b5959ac');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (7, 'Dolorem facilis corrupti blanditiis.', 'Fabian', 'Lueilwitz', '/spring-frontend/assets/img/content/main/card2.jpg', 'ee74d153-e211-4574-a0dc-f9b14653c11f');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (8, 'Velit facilis consectetur sit.', 'George', 'Marquardt', '/spring-frontend/assets/img/content/main/card2.jpg', '297f83bd-a56a-4e57-8548-d18efdaa7e85');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (9, 'Unde excepturi aut quisquam illo qui corrupti sit.', 'Sherman', 'Douglas', '/spring-frontend/assets/img/content/main/card2.jpg', '348ae417-c5bd-4730-aba5-a3d4b6a03c59');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (10, 'Ea consequatur perferendis ipsa aut.', 'Douglas', 'Maggio', '/spring-frontend/assets/img/content/main/card2.jpg', '16d205ab-02ea-49b3-bbe4-948283dadffb');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (11, 'Voluptatem quidem qui velit.', 'Savannah', 'O''Hara', '/spring-frontend/assets/img/content/main/card2.jpg', 'c89c9d7f-4a69-420a-a5e5-e569f6efea5a');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (12, 'Quo aliquam praesentium dicta veniam atque eius quaerat.', 'Lakiesha', 'Satterfield', '/spring-frontend/assets/img/content/main/card2.jpg', 'ccdc7218-df87-4050-9b0c-7936f3348491');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (13, 'Molestiae sed est enim laborum.', 'Jenine', 'Fadel', '/spring-frontend/assets/img/content/main/card2.jpg', '6194c9f6-a6b6-485b-a723-b71650754c90');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (14, 'Tempore nostrum quae deserunt id temporibus expedita quasi.', 'Deon', 'Nienow', '/spring-frontend/assets/img/content/main/card2.jpg', '1e062c82-ea18-4fe5-81b2-91850e8b4a5b');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (15, 'Fugiat expedita accusantium molestiae nam ut.', 'Hunter', 'Berge', '/spring-frontend/assets/img/content/main/card2.jpg', '1f0fc85c-9ac6-4989-9259-f35cd1cb9441');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (16, 'Aut dolore quaerat officiis ipsam.', 'Dann', 'Mayert', '/spring-frontend/assets/img/content/main/card2.jpg', 'a0efba78-3e4c-4d83-9076-e731edea3c15');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (17, 'Dolor dolores sit aut vel et.', 'Inga', 'Nikolaus', '/spring-frontend/assets/img/content/main/card2.jpg', '1ec78a0e-d485-4d11-a9b0-1511ee7b6c52');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (18, 'Qui excepturi atque aut cumque.', 'Eun', 'Zemlak', '/spring-frontend/assets/img/content/main/card2.jpg', '014c63b1-f386-407d-94a6-1c4195fcfc73');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (19, 'Architecto cupiditate molestiae optio labore non qui.', 'Rosann', 'Boehm', '/spring-frontend/assets/img/content/main/card2.jpg', 'f677dc21-5bb6-4006-a2db-167fa17c4045');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (20, 'Nisi quis deleniti.', 'Abel', 'Rutherford', '/spring-frontend/assets/img/content/main/card2.jpg', '061cae07-391a-4d30-a3ce-44cb356af36a');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (21, 'Quae eos rerum suscipit.', 'Margene', 'Marks', '/spring-frontend/assets/img/content/main/card2.jpg', '31e2162b-c76c-44b1-a7b8-0cd2dee24441');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (22, 'Porro perspiciatis tempora quia ut ea aut molestias.', 'Cristobal', 'Bosco', '/spring-frontend/assets/img/content/main/card2.jpg', '33d62418-35d2-452b-89c8-1b62b3c08724');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (23, 'Animi eum quam corrupti in sequi qui.', 'Lewis', 'Mertz', '/spring-frontend/assets/img/content/main/card2.jpg', 'cee861cb-4c4c-4191-b109-9b9a78720261');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (24, 'Saepe harum ea eos voluptas totam.', 'Jonathan', 'Konopelski', '/spring-frontend/assets/img/content/main/card2.jpg', 'a135c056-e282-4a94-8744-58634f3745bd');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (25, 'Et aliquam voluptas explicabo et.', 'Reda', 'Zemlak', '/spring-frontend/assets/img/content/main/card2.jpg', 'dc95c258-d460-4eec-b1b2-0999f8b63304');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (26, 'Voluptas voluptatibus quis eveniet aliquid.', 'Weldon', 'Nicolas', '/spring-frontend/assets/img/content/main/card2.jpg', '88609d5f-38a5-44eb-b506-393ca1c16e60');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (27, 'Incidunt molestias eum dicta est praesentium enim.', 'Jess', 'Jakubowski', '/spring-frontend/assets/img/content/main/card2.jpg', 'dc99be7f-3a65-4a1e-893d-c87357739a97');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (28, 'Ullam nihil rem pariatur vel neque est iusto.', 'Sherrill', 'Turner', '/spring-frontend/assets/img/content/main/card2.jpg', 'ff5550f7-5c14-4315-bd72-0a423c90ff73');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (29, 'Earum id dolor magni.', 'Ken', 'Rodriguez', '/spring-frontend/assets/img/content/main/card2.jpg', 'ba440cce-aa85-410e-b06b-4a43e4af2b21');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (30, 'Pariatur dolorum est.', 'Derrick', 'Hintz', '/spring-frontend/assets/img/content/main/card2.jpg', 'd3351bc5-ebf3-420d-aa9c-7a89816b2aa3');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (31, 'Sequi reprehenderit non quia ducimus labore.', 'Dion', 'Kassulke', '/spring-frontend/assets/img/content/main/card2.jpg', 'b9ee17ac-17cf-4374-923b-45390ece5afa');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (32, 'Et in ut sunt vitae ea.', 'Adaline', 'Bartell', '/spring-frontend/assets/img/content/main/card2.jpg', 'b542d417-9151-49f0-bac5-45d4f247aefb');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (33, 'Rerum officia quis sunt dolor dolores temporibus officiis.', 'Clarice', 'Dach', '/spring-frontend/assets/img/content/main/card2.jpg', '1973281f-255a-45f3-a634-252d96cd8346');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (34, 'Ut libero id.', 'Tresa', 'Legros', '/spring-frontend/assets/img/content/main/card2.jpg', 'f434c610-8385-4b4d-8d22-e4d5069358e4');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (35, 'Ut veritatis et id aliquam consequatur aspernatur.', 'Alexandria', 'Cummings', '/spring-frontend/assets/img/content/main/card2.jpg', 'bd15add6-28cf-4579-b25e-545c7b16dbbd');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (36, 'Voluptatem neque explicabo repudiandae vero aut.', 'Creola', 'Will', '/spring-frontend/assets/img/content/main/card2.jpg', 'd7abd6b5-ddc6-4483-9172-ec8522642dca');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (37, 'Nemo cum totam deleniti suscipit architecto voluptate.', 'Arlie', 'Cartwright', '/spring-frontend/assets/img/content/main/card2.jpg', 'ab4c33c8-39bd-4ca8-98de-cffe28032b17');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (38, 'Temporibus eligendi temporibus aut ullam quos incidunt sunt.', 'Lynn', 'Boyle', '/spring-frontend/assets/img/content/main/card2.jpg', '591d672c-e62c-417b-87e7-ea6645950d90');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (39, 'Reiciendis ut quia quibusdam ipsa.', 'Wilfred', 'Padberg', '/spring-frontend/assets/img/content/main/card2.jpg', '3cee3360-9f63-4bfb-8d5d-63152585d3c6');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (40, 'Assumenda ut dolor iure.', 'Ernest', 'Harris', '/spring-frontend/assets/img/content/main/card2.jpg', '91ad9cd0-094a-4b7c-8806-4312b507a137');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (41, 'Deleniti at voluptatum est aut.', 'Errol', 'Crona', '/spring-frontend/assets/img/content/main/card2.jpg', '8538f577-f381-4b4b-9d36-91feffd21b52');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (42, 'Voluptates quis et in quam nulla non.', 'Filiberto', 'Mayer', '/spring-frontend/assets/img/content/main/card2.jpg', '3168bcec-03fa-418b-b13f-9f67bdb8023f');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (43, 'Ea delectus dolorem totam doloribus.', 'Jermaine', 'Bailey', '/spring-frontend/assets/img/content/main/card2.jpg', '003d1487-5423-4dbb-a8a9-1505a66e47d4');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (44, 'Blanditiis modi quasi voluptatibus.', 'Saul', 'Leffler', '/spring-frontend/assets/img/content/main/card2.jpg', '99718ce9-b0d1-4671-9bfc-ee7cd3f051db');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (45, 'Ab in est minus quis.', 'Jody', 'Bayer', '/spring-frontend/assets/img/content/main/card2.jpg', '7afa1b29-e68e-4181-b6c6-8f04194d3626');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (46, 'Voluptatem et sint vero non.', 'Abram', 'Bogisich', '/spring-frontend/assets/img/content/main/card2.jpg', '522a4f59-2fe1-4576-9808-a0eeac5a0549');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (47, 'Et beatae voluptas.', 'Miles', 'Mitchell', '/spring-frontend/assets/img/content/main/card2.jpg', '120a71ce-1de6-4509-82c4-a9d8e8463c73');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (48, 'Illo quod aspernatur sit optio.', 'Lemuel', 'Boehm', '/spring-frontend/assets/img/content/main/card2.jpg', 'a20817cc-84a3-45e2-b7c4-7f060b258323');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (49, 'Dolore autem consectetur dolores.', 'Toney', 'Yost', '/spring-frontend/assets/img/content/main/card2.jpg', '234c0659-46f4-44bf-9457-8f72fda6a10d');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (50, 'Iure doloremque vel nemo quia accusantium quidem praesentium.', 'Jc', 'Kohler', '/spring-frontend/assets/img/content/main/card2.jpg', 'a2de24b5-9853-4a5a-ad39-47df7cbe7d0d');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (51, 'Totam consectetur vitae molestiae eligendi et officia.', 'Hank', 'Morissette', '/spring-frontend/assets/img/content/main/card2.jpg', '1625385e-657e-45c4-8bd0-72e268bc5669');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (52, 'At illum maxime.', 'Amanda', 'Greenfelder', '/spring-frontend/assets/img/content/main/card2.jpg', '0a302704-891e-44be-8bf8-8fc98c11f89c');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (53, 'Error error voluptas quia a neque placeat nemo.', 'Felix', 'Tillman', '/spring-frontend/assets/img/content/main/card2.jpg', '36f6efbf-3b01-4f61-84e7-9e565f79432f');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (54, 'Nostrum adipisci maxime ex.', 'Jonas', 'Wiegand', '/spring-frontend/assets/img/content/main/card2.jpg', '67cf37ae-5565-4050-8ac3-1606f872561c');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (55, 'Nisi eaque aliquam velit.', 'Carmel', 'Breitenberg', '/spring-frontend/assets/img/content/main/card2.jpg', 'a38eb212-b5fe-4a79-8d14-761bb8c0984f');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (56, 'Dicta vel impedit eum.', 'Corey', 'Kling', '/spring-frontend/assets/img/content/main/card2.jpg', 'c3117c1d-f5d8-4237-a65e-31e7be062553');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (57, 'Architecto modi dolores quas.', 'Roni', 'Hoeger', '/spring-frontend/assets/img/content/main/card2.jpg', 'b7ac13d2-0c80-4d0b-a051-ae3606aa04f1');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (58, 'Repudiandae consectetur amet sit.', 'Margret', 'Wyman', '/spring-frontend/assets/img/content/main/card2.jpg', '81f04b52-cf9a-4b00-a60e-e571ccf21bbc');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (59, 'Nesciunt commodi facilis.', 'Connie', 'Schaden', '/spring-frontend/assets/img/content/main/card2.jpg', '1cbb5d39-759a-455a-b68a-0add51ece280');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (60, 'Sit voluptatem sint sit numquam aut sit.', 'Jospeh', 'Rogahn', '/spring-frontend/assets/img/content/main/card2.jpg', '2b5cc6d8-cd67-4578-af17-c7968de4979d');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (61, 'Natus eum a reprehenderit nihil.', 'Rhiannon', 'Wunsch', '/spring-frontend/assets/img/content/main/card2.jpg', '48758ac0-767b-4141-b1fe-050127160e0d');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (62, 'Corrupti natus perferendis accusantium.', 'Rudolf', 'Daugherty', '/spring-frontend/assets/img/content/main/card2.jpg', '409ede2b-3433-427d-8742-d5dc2aefb235');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (63, 'Id molestiae velit atque harum quas.', 'Adrian', 'Hamill', '/spring-frontend/assets/img/content/main/card2.jpg', '331d3696-41cc-4815-8dfc-0f96204f364b');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (64, 'Iusto est rerum animi quidem maxime voluptatibus eum.', 'Breanne', 'Howell', '/spring-frontend/assets/img/content/main/card2.jpg', '0f9e23fe-0268-4d4c-9fbf-737349d2a701');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (65, 'Suscipit nihil pariatur facere.', 'Lon', 'Hettinger', '/spring-frontend/assets/img/content/main/card2.jpg', 'ce9514b0-8a4f-45cc-8c1a-4a60609d4232');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (66, 'Libero nihil aperiam.', 'Alejandro', 'Sawayn', '/spring-frontend/assets/img/content/main/card2.jpg', '06df2e52-43e2-4d0b-92a7-0a59c3be76e7');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (67, 'Impedit veritatis eveniet in non necessitatibus.', 'Kristel', 'Flatley', '/spring-frontend/assets/img/content/main/card2.jpg', '230028b1-f376-4508-bda2-86d150788764');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (68, 'Sed quas corporis deserunt.', 'Bari', 'Bartell', '/spring-frontend/assets/img/content/main/card2.jpg', 'aec7ea47-c8dd-4c15-956b-fe5e07bbf569');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (69, 'Repellat explicabo accusamus.', 'Mohammed', 'Sipes', '/spring-frontend/assets/img/content/main/card2.jpg', 'e84e6401-fcca-4288-b7a8-72ff37ccb004');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (70, 'Et ut aliquam.', 'Wally', 'Hilll', '/spring-frontend/assets/img/content/main/card2.jpg', '3869c92c-4e58-4088-a11b-d17c2feafc54');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (71, 'Accusantium provident ut excepturi.', 'Milford', 'Jerde', '/spring-frontend/assets/img/content/main/card2.jpg', '82d9c6cb-bdbb-4474-9da5-22ac78b2c711');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (72, 'Et ut laudantium.', 'Jarod', 'Will', '/spring-frontend/assets/img/content/main/card2.jpg', '0726c2b9-1118-4bb9-9d66-8323c5b7ac5d');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (73, 'Porro odio eum eos dolorem veniam iure.', 'Geoffrey', 'Donnelly', '/spring-frontend/assets/img/content/main/card2.jpg', '21ef4e94-e4a2-4935-906b-4a3a68336bcd');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (74, 'A cumque deserunt quae dicta enim.', 'Titus', 'Lowe', '/spring-frontend/assets/img/content/main/card2.jpg', '8de96503-ae73-4537-b2f9-843bef7654d0');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (75, 'Sed eos et cum.', 'Weldon', 'Kuhic', '/spring-frontend/assets/img/content/main/card2.jpg', 'a7f3a671-8ce0-4466-abe1-42767086ff07');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (76, 'Exercitationem repellat magnam.', 'Monika', 'Ledner', '/spring-frontend/assets/img/content/main/card2.jpg', '81b94633-5319-4146-8be2-2e2487670497');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (77, 'Sequi tempore aliquam ut.', 'Shirley', 'Kunde', '/spring-frontend/assets/img/content/main/card2.jpg', 'e119e22f-b403-4e5f-8a18-d1a46f182e00');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (78, 'Quaerat ut eum itaque.', 'Sharita', 'Maggio', '/spring-frontend/assets/img/content/main/card2.jpg', '91923303-ef82-4808-ac29-ae6d839e4dae');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (79, 'Ut reprehenderit eligendi asperiores odio nemo repellat voluptatem.', 'Shane', 'Kiehn', '/spring-frontend/assets/img/content/main/card2.jpg', 'ed9d2913-f0f4-40d4-8e38-02fc95c05d7d');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (80, 'Optio hic animi ut velit libero qui ut.', 'Shelby', 'Lesch', '/spring-frontend/assets/img/content/main/card2.jpg', '03a448b2-3d26-4a8d-bfc3-e60f2d6a4a9f');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (81, 'Voluptatem repellat hic.', 'Jonas', 'Beer', '/spring-frontend/assets/img/content/main/card2.jpg', '4141f7ec-4abf-47cf-a572-9ab3e9132aac');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (82, 'Quis tempore quod distinctio accusamus.', 'Dayle', 'Steuber', '/spring-frontend/assets/img/content/main/card2.jpg', '7e36b68a-540c-4772-b58f-e2a5714ac40b');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (83, 'Et et repellat est tempore.', 'Garfield', 'Reilly', '/spring-frontend/assets/img/content/main/card2.jpg', '7c5506c1-5cf7-4e14-989f-06e24446670c');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (84, 'Debitis quas autem cum.', 'Teodoro', 'Hansen', '/spring-frontend/assets/img/content/main/card2.jpg', '03846112-f110-49a9-a67d-7bb1ffd94be8');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (85, 'Ratione rerum et.', 'Andre', 'Kassulke', '/spring-frontend/assets/img/content/main/card2.jpg', 'd049e15c-cd82-4108-8072-dbca5c105900');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (86, 'Qui est alias incidunt commodi vero dolorem.', 'Marcos', 'Fisher', '/spring-frontend/assets/img/content/main/card2.jpg', 'bf9d6cb5-60cb-4cdc-b6cb-e46554c2e228');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (87, 'Suscipit tenetur ut aliquam.', 'Bruce', 'Conn', '/spring-frontend/assets/img/content/main/card2.jpg', '587d3131-316c-4b00-a6a9-8965d50ecc82');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (88, 'Voluptatum nam voluptatem.', 'Georgiana', 'Schulist', '/spring-frontend/assets/img/content/main/card2.jpg', '179ad9d6-7a01-4ca2-b81c-34c2c618633e');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (89, 'Quis veniam quae harum.', 'Bessie', 'Rippin', '/spring-frontend/assets/img/content/main/card2.jpg', '4b6d00cf-565d-497a-8d57-4b585e4c2ce8');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (90, 'Ut cumque fuga est et praesentium id quasi.', 'Sal', 'Hamill', '/spring-frontend/assets/img/content/main/card2.jpg', 'f9e8f4df-b5f1-48ff-bc41-9218eff36b5c');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (91, 'Cupiditate perferendis qui veniam quis.', 'Fernando', 'Aufderhar', '/spring-frontend/assets/img/content/main/card2.jpg', '4fd32647-5955-4b9a-8411-1672d859bb86');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (92, 'Perspiciatis unde perferendis et placeat et corporis corrupti.', 'Louie', 'Lowe', '/spring-frontend/assets/img/content/main/card2.jpg', '30b0185e-8179-459e-9685-5dd02c5b18b5');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (93, 'Voluptatem non expedita aspernatur ipsum tenetur enim.', 'Celesta', 'Hoppe', '/spring-frontend/assets/img/content/main/card2.jpg', 'df0b9abc-378b-47e7-b771-00027b58c842');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (94, 'Error ipsa corrupti nemo incidunt.', 'Shaunte', 'Bailey', '/spring-frontend/assets/img/content/main/card2.jpg', '6d791d1d-f289-467b-af48-5fe20ddb55d7');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (95, 'Et quis non eos modi facilis ipsa repellat.', 'Abigail', 'Stamm', '/spring-frontend/assets/img/content/main/card2.jpg', 'b9e15e61-a3ed-4334-bbc7-30db79a8bb67');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (96, 'Similique dolor quia et eos totam consectetur vitae.', 'Margie', 'Ondricka', '/spring-frontend/assets/img/content/main/card2.jpg', 'bd2dff1d-42fd-49af-8fd5-882145dac3ce');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (97, 'Qui qui quidem necessitatibus impedit unde iusto.', 'Murray', 'Welch', '/spring-frontend/assets/img/content/main/card2.jpg', '4da52b4e-2298-4a73-9dd2-0c97936745e3');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (98, 'Aut velit in placeat facilis voluptatem repellat.', 'Mimi', 'Gusikowski', '/spring-frontend/assets/img/content/main/card2.jpg', 'aa151c10-fc03-4620-8784-96c126fcfdfb');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (99, 'Et ab labore quae ut id autem quae.', 'Milan', 'Goldner', '/spring-frontend/assets/img/content/main/card2.jpg', 'a0aef05e-6eaa-449e-8d86-ce7eb7201c94');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (100, 'Facilis magnam quia quisquam velit nihil sit.', 'Delinda', 'Hessel', '/spring-frontend/assets/img/content/main/card2.jpg', '79808a2d-648b-4796-8f2a-1d92e084fa27');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (101, 'Iure vel et.', 'Mark', 'Stokes', '/spring-frontend/assets/img/content/main/card2.jpg', 'cab3a3fa-e9e0-4af9-a233-1ba9134859f4');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (102, 'Eligendi alias rerum.', 'Jasper', 'Fahey', '/spring-frontend/assets/img/content/main/card2.jpg', '59a6c2bb-581b-431b-a251-95e8e4f8cac6');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (103, 'Laboriosam debitis reiciendis aliquid sed.', 'Josphine', 'Hoppe', '/spring-frontend/assets/img/content/main/card2.jpg', '5c0d20a4-f798-4e32-835f-35bd6f4166e8');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (104, 'Error aut nostrum id id voluptatibus.', 'Marcy', 'Steuber', '/spring-frontend/assets/img/content/main/card2.jpg', '9ab4dee5-77f2-44e8-a4f9-867237fd5ca6');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (105, 'Provident et explicabo maiores.', 'Gilma', 'Schneider', '/spring-frontend/assets/img/content/main/card2.jpg', 'b7fd9efe-d10d-4a2f-8b69-986547cc7c12');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (106, 'Recusandae odit molestiae quam iure.', 'Kip', 'Schmitt', '/spring-frontend/assets/img/content/main/card2.jpg', '12ca8461-80e5-4691-a1af-16e645e84938');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (107, 'Nihil ipsa pariatur doloribus cum consequatur qui.', 'Josh', 'Thiel', '/spring-frontend/assets/img/content/main/card2.jpg', 'ba516779-57a0-4e23-b37c-e70f77f4f468');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (108, 'Et doloremque repudiandae quibusdam dolor.', 'Jenifer', 'Bode', '/spring-frontend/assets/img/content/main/card2.jpg', 'de7ac3e9-e1b7-4ab6-b0eb-736fcc3af3ff');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (109, 'Ut laboriosam ab nobis sed error cupiditate saepe.', 'Florinda', 'Cole', '/spring-frontend/assets/img/content/main/card2.jpg', 'd02f39d1-0fb0-46fc-a164-85aa697b959d');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (110, 'Optio nihil aliquid mollitia.', 'Alejandro', 'Corwin', '/spring-frontend/assets/img/content/main/card2.jpg', 'b6b1eb4b-1172-4edc-9dcb-6446b3d4aa4f');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (111, 'Molestiae fugiat deserunt qui.', 'Barney', 'Watsica', '/spring-frontend/assets/img/content/main/card2.jpg', '2f65b87d-0b25-4fea-b4eb-6e980cde2c17');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (112, 'Ut fugiat odit et et voluptatem.', 'Ramon', 'Bins', '/spring-frontend/assets/img/content/main/card2.jpg', 'f04ef561-d944-497f-8fc7-285d35b7d981');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (113, 'Et cumque vero non.', 'Ward', 'Moen', '/spring-frontend/assets/img/content/main/card2.jpg', '39dd494b-98de-4995-8597-02f06286fc31');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (114, 'Ut qui minima numquam nemo ut autem velit.', 'Efren', 'Thiel', '/spring-frontend/assets/img/content/main/card2.jpg', 'e6677a27-5bad-4dbd-9d6f-73dd8696713e');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (115, 'Ut soluta voluptas et inventore qui voluptas exercitationem.', 'Rodger', 'Quigley', '/spring-frontend/assets/img/content/main/card2.jpg', 'cee2e384-7030-402f-9afc-d3bf7ff91b62');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (116, 'Ut quibusdam rerum quia consequatur.', 'Hana', 'Streich', '/spring-frontend/assets/img/content/main/card2.jpg', '64ce9391-651c-44d6-bc0b-bc34fde0a69c');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (117, 'Provident earum eligendi rerum.', 'Brandon', 'Stamm', '/spring-frontend/assets/img/content/main/card2.jpg', 'c93bd9b0-8475-43ba-9e9c-7a6f62d3a42f');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (118, 'Velit tempore debitis alias voluptatibus.', 'Gaye', 'Padberg', '/spring-frontend/assets/img/content/main/card2.jpg', '22e1f2ce-113b-4624-9793-5abb9fd0f188');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (119, 'Voluptas hic magni aliquid sequi.', 'Tressie', 'Watsica', '/spring-frontend/assets/img/content/main/card2.jpg', '0ff7eb7a-30eb-4ec1-a299-270de6db7682');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (120, 'Sunt est inventore.', 'Jarvis', 'Schinner', '/spring-frontend/assets/img/content/main/card2.jpg', 'd3c21ef0-bfb0-4a49-8ff2-33ddc1ba4938');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (121, 'Aperiam aut itaque accusamus.', 'Burt', 'Kulas', '/spring-frontend/assets/img/content/main/card2.jpg', '9d3c2ac1-4a84-44ae-9107-b02056c17895');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (122, 'Architecto placeat aperiam eaque laudantium rem esse ut.', 'Joel', 'Reichel', '/spring-frontend/assets/img/content/main/card2.jpg', '539d6fcf-a84e-4395-84f2-8522f7bcd421');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (123, 'Sed soluta assumenda ea similique assumenda.', 'Sheldon', 'Schaden', '/spring-frontend/assets/img/content/main/card2.jpg', '90dbd221-b0af-4287-a0e0-b688c3118557');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (124, 'Eaque dolorem expedita distinctio corporis non molestias.', 'Sandy', 'Herman', '/spring-frontend/assets/img/content/main/card2.jpg', 'cbd2e4b4-9e4f-4da8-af8b-73e267512088');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (125, 'Hic sint aut saepe et quia necessitatibus omnis.', 'Brain', 'Bartell', '/spring-frontend/assets/img/content/main/card2.jpg', '71cd4759-1b24-4204-a621-578a24552956');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (126, 'Fugiat odio maxime.', 'Jacquie', 'Cruickshank', '/spring-frontend/assets/img/content/main/card2.jpg', '1ff0cb13-dedc-4b08-aaca-5c727ae1bbeb');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (127, 'Commodi nostrum esse velit.', 'Miles', 'Gulgowski', '/spring-frontend/assets/img/content/main/card2.jpg', 'f6fbb888-da81-4260-bb31-45bf8f0b0460');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (128, 'Et ducimus sunt vel dolorem.', 'Luna', 'Johns', '/spring-frontend/assets/img/content/main/card2.jpg', '1c9b4f4c-2c46-4812-95bd-837962b7165a');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (129, 'Similique in molestiae aliquam excepturi et doloribus.', 'Corey', 'Kassulke', '/spring-frontend/assets/img/content/main/card2.jpg', '2076ca92-7521-49ac-8bdc-daaf9990c025');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (130, 'At magnam in iure omnis cupiditate.', 'Otto', 'Kirlin', '/spring-frontend/assets/img/content/main/card2.jpg', 'fc28cb94-d084-4795-85f3-09146f6188d0');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (131, 'Libero voluptas modi.', 'Coretta', 'Ondricka', '/spring-frontend/assets/img/content/main/card2.jpg', '1d40f76f-0879-45a4-87a2-e4b94bac9b8d');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (132, 'Occaecati veniam minima saepe quia inventore blanditiis.', 'Alden', 'Wintheiser', '/spring-frontend/assets/img/content/main/card2.jpg', '4bb07973-dc8e-41af-89c7-b98f3b8ee0c4');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (133, 'Ullam iusto dolor magnam sed deleniti.', 'Jule', 'Harvey', '/spring-frontend/assets/img/content/main/card2.jpg', '87b42627-12a7-4b2a-a040-0c1e801d3f9a');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (134, 'Nemo dolor quos fugiat.', 'Selina', 'Cummings', '/spring-frontend/assets/img/content/main/card2.jpg', '7ae00d4c-e3d9-41c2-bcad-232a7c2cef7f');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (135, 'Reprehenderit voluptatem qui itaque optio qui.', 'Dustin', 'Murray', '/spring-frontend/assets/img/content/main/card2.jpg', 'bfe47384-96f8-4b1c-a5df-5443aeb7d187');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (136, 'Veritatis voluptatem tenetur nihil commodi.', 'Amal', 'Kovacek', '/spring-frontend/assets/img/content/main/card2.jpg', '3a9e1bd3-df23-487a-975d-d11f5b10d5d0');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (137, 'Aut ut porro reiciendis voluptas.', 'Colin', 'Walter', '/spring-frontend/assets/img/content/main/card2.jpg', '9c064007-7092-4de9-9cab-b6d63a9e490f');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (138, 'Doloribus et aut illo ullam et.', 'Kyra', 'Blanda', '/spring-frontend/assets/img/content/main/card2.jpg', 'b9ca246d-9b37-4d87-96c8-1cabf7ac63c3');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (139, 'Dicta qui fugiat ratione itaque minus aut voluptas.', 'Mohammad', 'Barton', '/spring-frontend/assets/img/content/main/card2.jpg', '2516d989-d7b5-49a8-b093-b8167f8e9df9');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (140, 'Nihil officiis necessitatibus assumenda.', 'Eleonor', 'Fadel', '/spring-frontend/assets/img/content/main/card2.jpg', 'c6ad81f1-9189-45a5-ae2a-59b396874557');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (141, 'Eos maxime et voluptatum facere distinctio consectetur sed.', 'Alejandro', 'Muller', '/spring-frontend/assets/img/content/main/card2.jpg', 'f7583625-2eb6-45f1-9231-fe10238a0354');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (142, 'Saepe dignissimos minima nihil voluptatibus tenetur quo dolores.', 'Kortney', 'Fadel', '/spring-frontend/assets/img/content/main/card2.jpg', '9e2f3b8f-144b-4ef0-9a8c-54196c98847c');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (143, 'Aut et veniam rerum aspernatur qui quaerat numquam.', 'Kati', 'Murray', '/spring-frontend/assets/img/content/main/card2.jpg', 'b4babcf6-00b9-4344-a979-26de59e89e2c');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (144, 'Unde nulla voluptates nostrum et totam sapiente aspernatur.', 'Damon', 'Ondricka', '/spring-frontend/assets/img/content/main/card2.jpg', '24a4af88-4ff5-4380-bfc7-b0a2c5a92ae8');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (145, 'Est non accusantium.', 'Chloe', 'Kiehn', '/spring-frontend/assets/img/content/main/card2.jpg', '9452ef8d-6e9f-46df-807f-1ac5a90e3983');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (146, 'Aspernatur non qui voluptate aperiam molestiae.', 'Terese', 'Lueilwitz', '/spring-frontend/assets/img/content/main/card2.jpg', '777f03cb-eaa2-4291-a337-0a7032a566b8');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (147, 'Incidunt dolores aut veniam.', 'Roxana', 'Greenfelder', '/spring-frontend/assets/img/content/main/card2.jpg', '8857701b-8a57-4a90-939f-5a6e06fba708');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (148, 'Pariatur assumenda laboriosam ratione possimus et exercitationem.', 'Ronald', 'Stark', '/spring-frontend/assets/img/content/main/card2.jpg', 'e92b8540-6f8d-4d6b-a9dd-62674bf04c65');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (149, 'Molestiae debitis consequuntur dicta rerum saepe.', 'Gale', 'Kunde', '/spring-frontend/assets/img/content/main/card2.jpg', 'f1e72276-ebaf-422b-b9c2-77b67f050d5b');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (150, 'Quisquam omnis debitis asperiores vero ut reiciendis.', 'Beata', 'Crona', '/spring-frontend/assets/img/content/main/card2.jpg', 'ea3c40d0-ae8e-4314-abb4-92cfb3f98d8c');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (151, 'Dolor minima quasi culpa perferendis ratione.', 'Delmy', 'Wiza', '/spring-frontend/assets/img/content/main/card2.jpg', 'eeeb44ac-c563-4a97-898c-c2cd8f31920c');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (152, 'Id ut consequatur nobis qui cumque et ut.', 'Donovan', 'Mann', '/spring-frontend/assets/img/content/main/card2.jpg', 'be0eeb6f-6e15-4120-a86c-6394359a5604');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (153, 'Recusandae modi asperiores.', 'Edmund', 'Green', '/spring-frontend/assets/img/content/main/card2.jpg', 'a4e961b4-6716-496f-9f9d-5b88e69a136c');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (154, 'Nihil soluta qui ratione.', 'Lou', 'Little', '/spring-frontend/assets/img/content/main/card2.jpg', 'bff69745-ad38-48ea-bf1a-f730fdf0c6bf');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (155, 'Aperiam ab deleniti et magni et qui.', 'Corey', 'Senger', '/spring-frontend/assets/img/content/main/card2.jpg', '122333c8-4ef4-4daa-acb1-5f2ba2b0f4f7');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (156, 'Corrupti rerum aut nihil quibusdam laudantium.', 'Antonia', 'Robel', '/spring-frontend/assets/img/content/main/card2.jpg', 'b3f037a5-b3a3-4438-ba06-648db4ad62d6');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (157, 'Facilis omnis voluptatem.', 'Philip', 'Wunsch', '/spring-frontend/assets/img/content/main/card2.jpg', 'e0c7cfbd-bc31-4280-8ce1-67f40fdcd170');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (158, 'Provident rerum ut quibusdam.', 'Ermelinda', 'Runte', '/spring-frontend/assets/img/content/main/card2.jpg', 'fb820360-3cb7-4b64-97af-4a633fa70952');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (159, 'Soluta doloremque ut omnis.', 'Tracy', 'Altenwerth', '/spring-frontend/assets/img/content/main/card2.jpg', '833e3e43-d030-4b12-916e-7ce8b2e7cc3a');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (160, 'Eius totam dignissimos ipsum.', 'Giuseppina', 'Oberbrunner', '/spring-frontend/assets/img/content/main/card2.jpg', 'a2361b32-c457-448b-9cd2-452c544cd0d7');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (161, 'Consequatur nostrum sit et exercitationem qui occaecati vitae.', 'Denisha', 'Rippin', '/spring-frontend/assets/img/content/main/card2.jpg', '0217f1c5-498b-4617-bf78-c2fd98ebaec9');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (162, 'Qui occaecati quidem sed placeat.', 'Clemente', 'Lowe', '/spring-frontend/assets/img/content/main/card2.jpg', '6111e86a-6bfa-4196-937a-303002c565d6');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (163, 'Voluptatem in eum alias quis repudiandae possimus.', 'Vanesa', 'Wolf', '/spring-frontend/assets/img/content/main/card2.jpg', '91e362ea-018a-43e5-9548-99771895b879');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (164, 'Eligendi aut laborum.', 'Tricia', 'Nader', '/spring-frontend/assets/img/content/main/card2.jpg', 'bca8ac2e-ee4c-4194-b864-fd84df241159');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (165, 'Sunt mollitia occaecati porro ipsum aut.', 'Gertha', 'Christiansen', '/spring-frontend/assets/img/content/main/card2.jpg', '1b4ad291-af89-445f-a4de-2613795e16e3');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (166, 'Voluptas sit est qui nisi facere pariatur aut.', 'Kennith', 'Grady', '/spring-frontend/assets/img/content/main/card2.jpg', 'e7cb4f55-d546-4715-9891-b0d6de30ee96');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (167, 'Reprehenderit est vel.', 'Valentin', 'Cartwright', '/spring-frontend/assets/img/content/main/card2.jpg', 'fdd1e581-1ffb-41f4-8b91-fcb32b7ecf01');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (168, 'Fugiat tempore aut.', 'Gail', 'Kovacek', '/spring-frontend/assets/img/content/main/card2.jpg', '4c0a9368-0337-42fa-a379-c9d93f8dc669');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (169, 'Dolorem ut deleniti voluptatibus nam eveniet eveniet.', 'Leesa', 'Shanahan', '/spring-frontend/assets/img/content/main/card2.jpg', '1b02e86c-920c-42bb-ad8b-50ed7a45de4f');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (170, 'Nihil eos id quia repudiandae a illo voluptatem.', 'Lee', 'Kerluke', '/spring-frontend/assets/img/content/main/card2.jpg', '9560dcc7-b709-4413-ba83-f993d1649bc1');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (171, 'Debitis magni consequuntur recusandae voluptatem sed.', 'Odell', 'Ortiz', '/spring-frontend/assets/img/content/main/card2.jpg', '96d35111-7699-4ceb-a374-744e8e429d05');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (172, 'Aliquid quasi quisquam officia error qui.', 'Deon', 'Klein', '/spring-frontend/assets/img/content/main/card2.jpg', '976413a5-db1f-481a-98a5-bbfd2365f832');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (173, 'Sequi numquam maxime.', 'Marry', 'Labadie', '/spring-frontend/assets/img/content/main/card2.jpg', '6e888982-86cb-478a-98f0-76cbeecfa233');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (174, 'Id dicta maxime consequuntur ut tempora minima.', 'Milo', 'Koepp', '/spring-frontend/assets/img/content/main/card2.jpg', 'ce49e5d9-ea5f-4c70-a242-e690156a013d');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (175, 'Et quo nulla inventore enim tenetur magni ut.', 'Breana', 'Johnston', '/spring-frontend/assets/img/content/main/card2.jpg', '7ebfd040-5e29-4aec-956b-e574711c75e6');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (176, 'Cupiditate dolorum sit nostrum eos.', 'Cary', 'Mohr', '/spring-frontend/assets/img/content/main/card2.jpg', '6d8ca6fb-9569-4cc1-8e6a-63c166887d04');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (177, 'Doloribus vel asperiores ut consequuntur consequatur.', 'Kim', 'Cole', '/spring-frontend/assets/img/content/main/card2.jpg', '5d3d6cf4-897a-4a14-90ed-7c5307843f8a');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (178, 'Eos molestiae ipsam non qui.', 'Alecia', 'Bradtke', '/spring-frontend/assets/img/content/main/card2.jpg', '8ba11185-62c2-4bdd-8b5d-47a2c525adb9');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (179, 'At incidunt id ratione quisquam aut esse qui.', 'Kenna', 'Hermiston', '/spring-frontend/assets/img/content/main/card2.jpg', '21082004-0b56-4919-b86a-5a6142fd8a82');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (180, 'At aut voluptas quis.', 'Ezekiel', 'Wiza', '/spring-frontend/assets/img/content/main/card2.jpg', 'c288eef9-8817-4ad5-88da-be03f1a9d5a9');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (181, 'Pariatur dolorem aut pariatur perspiciatis omnis.', 'Eusebio', 'Ratke', '/spring-frontend/assets/img/content/main/card2.jpg', '96464b8c-dc87-4541-8694-aaf91cff8a77');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (182, 'Omnis laudantium rem explicabo nobis at amet tempore.', 'Angelic', 'Batz', '/spring-frontend/assets/img/content/main/card2.jpg', '8634b828-a075-4f0e-acdd-b50e78655fad');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (183, 'Ipsum pariatur aut dolores ratione sit.', 'Bennett', 'Purdy', '/spring-frontend/assets/img/content/main/card2.jpg', '00585089-ab98-4a30-a39d-c8fd0d991305');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (184, 'Rerum aut unde omnis.', 'Luis', 'Frami', '/spring-frontend/assets/img/content/main/card2.jpg', 'b3d5b636-e171-4cb6-9626-e04616e74df4');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (185, 'Rerum debitis aut officiis suscipit error quos tempore.', 'Voncile', 'Moen', '/spring-frontend/assets/img/content/main/card2.jpg', 'a497b983-be98-4510-957d-5725d8f2e310');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (186, 'Numquam modi voluptatibus suscipit aliquam.', 'Enrique', 'Franecki', '/spring-frontend/assets/img/content/main/card2.jpg', 'bbf18aa1-2776-4bd9-851c-ad77c39ed512');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (187, 'Magni velit et officiis nihil.', 'Scotty', 'Bechtelar', '/spring-frontend/assets/img/content/main/card2.jpg', '3fc535bf-df14-4b9b-be92-8018ee4969e3');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (188, 'Aperiam dolorum alias eaque.', 'Rocio', 'Towne', '/spring-frontend/assets/img/content/main/card2.jpg', 'cf1f4a4e-eb3f-43be-bdd3-9d5015f3e493');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (189, 'Quaerat nihil deserunt provident dolore.', 'Tanika', 'Casper', '/spring-frontend/assets/img/content/main/card2.jpg', 'b18d51d1-7ac8-4dc3-9526-6bb6644b6688');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (190, 'Reprehenderit sunt voluptas officia eius et totam.', 'Ivy', 'Nolan', '/spring-frontend/assets/img/content/main/card2.jpg', 'f14a6b98-cc61-4c0a-8429-fffc5f6b6f6c');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (191, 'Id pariatur voluptas mollitia ipsam ex in.', 'Miles', 'Jacobi', '/spring-frontend/assets/img/content/main/card2.jpg', '45bbaf80-b42c-489f-a7ae-20557a80d8b7');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (192, 'Est debitis nihil non nisi enim architecto cum.', 'Austin', 'Kutch', '/spring-frontend/assets/img/content/main/card2.jpg', '756c0f78-1833-4f33-8a70-9e5bbb482ff7');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (193, 'Est velit quod sunt officiis consequatur.', 'Yen', 'Hahn', '/spring-frontend/assets/img/content/main/card2.jpg', 'f42c1d8a-91a1-4f8b-add1-f490aeb0ba31');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (194, 'Fugiat id quia.', 'Horacio', 'Schuppe', '/spring-frontend/assets/img/content/main/card2.jpg', '1effbb02-dd44-4f0e-bfbc-021d4d2b976b');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (195, 'Incidunt minima deleniti facere officia aut.', 'Donte', 'Okuneva', '/spring-frontend/assets/img/content/main/card2.jpg', '36797c78-4dcc-40ac-a2a4-8af4c0f99889');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (196, 'Totam et totam facilis ratione eos.', 'Sam', 'Koelpin', '/spring-frontend/assets/img/content/main/card2.jpg', 'c96ea8c1-5207-4a3f-8370-9cc56cd98ae4');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (197, 'Nobis explicabo itaque perferendis quis consectetur.', 'King', 'Fahey', '/spring-frontend/assets/img/content/main/card2.jpg', '2d3ef028-3add-4ba6-97fb-6cdfceeec5b2');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (198, 'Eligendi culpa et est et et in.', 'Sonia', 'Stokes', '/spring-frontend/assets/img/content/main/card2.jpg', '352cf9ed-8ca5-44a1-b773-ee07ecb1126f');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (199, 'Sint quia voluptatem facilis non sunt.', 'Carin', 'Gerlach', '/spring-frontend/assets/img/content/main/card2.jpg', '09d83710-04b5-459a-94fc-6d11ecb75741');
INSERT INTO book_store.authors (id, description, first_name, last_name, photo, slug) VALUES (200, 'Consequatur molestiae ipsum ex.', 'Roscoe', 'Stark', '/spring-frontend/assets/img/content/main/card2.jpg', '8efda27d-1cfd-491a-8556-c517ed8fbf75');


--
-- Data for Name: balance_transaction; Type: TABLE DATA; Schema: book_store; Owner: postgres
--



--
-- Data for Name: book2author; Type: TABLE DATA; Schema: book_store; Owner: postgres
--

INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (1, 109, 1, 94);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (2, 112, 2, 81);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (3, 120, 3, 83);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (4, 127, 4, 92);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (5, 62, 5, 65);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (6, 136, 6, 30);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (7, 47, 7, 25);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (8, 195, 8, 8);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (9, 199, 9, 88);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (10, 69, 10, 50);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (11, 9, 11, 96);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (12, 9, 12, 24);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (13, 15, 13, 77);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (14, 118, 14, 50);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (15, 45, 15, 1);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (16, 108, 16, 2);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (17, 70, 17, 21);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (18, 120, 18, 79);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (19, 15, 19, 94);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (20, 55, 20, 75);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (21, 159, 21, 9);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (22, 16, 22, 6);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (23, 56, 23, 67);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (24, 193, 24, 95);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (25, 191, 25, 13);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (26, 19, 26, 71);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (27, 30, 27, 20);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (28, 130, 28, 33);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (29, 28, 29, 4);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (30, 196, 30, 45);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (31, 154, 31, 71);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (32, 4, 32, 86);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (33, 94, 33, 17);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (34, 126, 34, 82);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (35, 180, 35, 35);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (36, 130, 36, 28);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (37, 152, 37, 77);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (38, 54, 38, 81);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (39, 137, 39, 54);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (40, 11, 40, 64);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (41, 15, 41, 24);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (42, 34, 42, 29);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (43, 37, 43, 52);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (44, 7, 44, 17);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (45, 81, 45, 11);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (46, 67, 46, 89);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (47, 113, 47, 98);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (48, 104, 48, 41);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (49, 176, 49, 40);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (50, 70, 50, 40);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (51, 181, 51, 47);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (52, 19, 52, 33);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (53, 12, 53, 7);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (54, 6, 54, 96);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (55, 6, 55, 47);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (56, 76, 56, 2);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (57, 28, 57, 85);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (58, 76, 58, 56);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (59, 121, 59, 56);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (60, 181, 60, 16);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (61, 61, 61, 56);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (62, 111, 62, 23);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (63, 53, 63, 51);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (64, 22, 64, 3);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (65, 88, 65, 55);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (66, 35, 66, 23);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (67, 77, 67, 65);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (68, 166, 68, 50);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (69, 192, 69, 57);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (70, 70, 70, 53);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (71, 163, 71, 0);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (72, 136, 72, 22);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (73, 57, 73, 35);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (74, 102, 74, 30);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (75, 94, 75, 5);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (76, 158, 76, 86);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (77, 122, 77, 21);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (78, 140, 78, 13);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (79, 52, 79, 97);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (80, 154, 80, 53);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (81, 91, 81, 51);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (82, 51, 82, 97);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (83, 96, 83, 90);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (84, 175, 84, 81);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (85, 47, 85, 17);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (86, 192, 86, 18);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (87, 21, 87, 92);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (88, 196, 88, 64);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (89, 11, 89, 52);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (90, 35, 90, 0);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (91, 24, 91, 34);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (92, 128, 92, 54);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (93, 53, 93, 84);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (94, 5, 94, 13);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (95, 169, 95, 68);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (96, 71, 96, 3);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (97, 5, 97, 66);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (98, 160, 98, 53);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (99, 50, 99, 5);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (100, 43, 100, 4);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (101, 70, 101, 93);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (102, 10, 102, 61);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (103, 118, 103, 92);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (104, 131, 104, 7);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (105, 141, 105, 18);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (106, 105, 106, 15);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (107, 139, 107, 88);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (108, 55, 108, 5);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (109, 49, 109, 6);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (110, 183, 110, 74);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (111, 128, 111, 89);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (112, 184, 112, 29);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (113, 113, 113, 45);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (114, 7, 114, 80);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (115, 47, 115, 30);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (116, 140, 116, 11);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (117, 200, 117, 22);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (118, 173, 118, 24);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (119, 163, 119, 79);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (120, 89, 120, 48);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (121, 60, 121, 3);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (122, 98, 122, 50);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (123, 99, 123, 18);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (124, 69, 124, 22);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (125, 170, 125, 35);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (126, 86, 126, 28);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (127, 77, 127, 40);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (128, 36, 128, 18);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (129, 171, 129, 4);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (130, 131, 130, 88);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (131, 11, 131, 98);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (132, 57, 132, 23);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (133, 122, 133, 52);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (134, 160, 134, 58);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (135, 89, 135, 94);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (136, 122, 136, 98);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (137, 171, 137, 89);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (138, 67, 138, 21);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (139, 116, 139, 29);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (140, 104, 140, 18);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (141, 173, 141, 19);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (142, 77, 142, 27);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (143, 51, 143, 39);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (144, 180, 144, 67);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (145, 81, 145, 30);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (146, 194, 146, 22);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (147, 18, 147, 92);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (148, 43, 148, 48);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (149, 112, 149, 3);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (150, 190, 150, 43);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (151, 50, 151, 87);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (152, 163, 152, 15);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (153, 143, 153, 73);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (154, 160, 154, 72);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (155, 82, 155, 63);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (156, 67, 156, 45);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (157, 86, 157, 34);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (158, 18, 158, 71);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (159, 112, 159, 80);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (160, 190, 160, 40);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (161, 52, 161, 33);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (162, 158, 162, 27);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (163, 160, 163, 81);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (164, 200, 164, 62);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (165, 77, 165, 67);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (166, 162, 166, 40);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (167, 43, 167, 49);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (168, 15, 168, 17);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (169, 100, 169, 8);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (170, 5, 170, 3);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (171, 105, 171, 47);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (172, 146, 172, 98);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (173, 128, 173, 76);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (174, 175, 174, 68);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (175, 143, 175, 63);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (176, 133, 176, 20);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (177, 154, 177, 28);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (178, 188, 178, 2);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (179, 185, 179, 80);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (180, 139, 180, 4);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (181, 117, 181, 51);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (182, 89, 182, 55);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (183, 145, 183, 1);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (184, 10, 184, 56);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (185, 101, 185, 8);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (186, 165, 186, 34);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (187, 109, 187, 74);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (188, 74, 188, 94);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (189, 144, 189, 20);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (190, 153, 190, 83);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (191, 52, 191, 87);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (192, 157, 192, 88);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (193, 151, 193, 42);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (194, 24, 194, 67);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (195, 89, 195, 61);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (196, 176, 196, 75);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (197, 149, 197, 45);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (198, 39, 198, 10);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (199, 38, 199, 58);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (200, 8, 200, 33);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (201, 94, 201, 18);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (202, 197, 202, 46);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (203, 194, 203, 43);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (204, 22, 204, 69);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (205, 153, 205, 80);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (206, 188, 206, 43);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (207, 67, 207, 96);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (208, 123, 208, 31);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (209, 159, 209, 73);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (210, 117, 210, 98);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (211, 100, 211, 81);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (212, 92, 212, 51);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (213, 169, 213, 59);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (214, 136, 214, 96);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (215, 16, 215, 45);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (216, 86, 216, 32);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (217, 12, 217, 21);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (218, 33, 218, 58);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (219, 132, 219, 87);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (220, 122, 220, 98);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (221, 104, 221, 2);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (222, 27, 222, 60);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (223, 200, 223, 75);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (224, 82, 224, 38);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (225, 100, 225, 87);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (226, 121, 226, 39);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (227, 166, 227, 63);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (228, 138, 228, 15);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (229, 20, 229, 91);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (230, 111, 230, 9);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (231, 89, 231, 96);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (232, 191, 232, 41);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (233, 171, 233, 91);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (234, 117, 234, 42);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (235, 103, 235, 12);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (236, 163, 236, 55);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (237, 192, 237, 4);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (238, 100, 238, 14);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (239, 79, 239, 7);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (240, 102, 240, 9);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (241, 101, 241, 29);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (242, 126, 242, 43);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (243, 75, 243, 48);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (244, 158, 244, 44);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (245, 154, 245, 19);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (246, 65, 246, 9);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (247, 15, 247, 58);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (248, 103, 248, 15);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (249, 86, 249, 43);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (250, 100, 250, 14);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (251, 167, 251, 65);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (252, 43, 252, 13);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (253, 38, 253, 80);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (254, 185, 254, 13);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (255, 140, 255, 77);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (256, 140, 256, 68);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (257, 84, 257, 39);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (258, 41, 258, 4);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (259, 80, 259, 43);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (260, 36, 260, 53);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (261, 104, 261, 76);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (262, 194, 262, 52);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (263, 44, 263, 16);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (264, 75, 264, 35);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (265, 130, 265, 5);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (266, 68, 266, 70);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (267, 97, 267, 71);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (268, 40, 268, 75);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (269, 38, 269, 83);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (270, 126, 270, 49);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (271, 83, 271, 32);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (272, 54, 272, 90);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (273, 37, 273, 73);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (274, 86, 274, 60);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (275, 119, 275, 40);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (276, 41, 276, 20);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (277, 82, 277, 39);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (278, 6, 278, 19);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (279, 158, 279, 93);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (280, 86, 280, 60);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (281, 106, 281, 48);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (282, 7, 282, 42);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (283, 79, 283, 1);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (284, 150, 284, 55);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (285, 99, 285, 9);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (286, 137, 286, 35);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (287, 1, 287, 0);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (288, 82, 288, 8);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (289, 157, 289, 43);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (290, 72, 290, 10);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (291, 133, 291, 48);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (292, 72, 292, 98);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (293, 99, 293, 46);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (294, 48, 294, 88);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (295, 128, 295, 42);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (296, 68, 296, 15);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (297, 19, 297, 57);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (298, 194, 298, 51);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (299, 110, 299, 96);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (300, 79, 300, 13);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (301, 113, 301, 86);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (302, 53, 302, 5);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (303, 152, 303, 14);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (304, 148, 304, 21);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (305, 199, 305, 85);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (306, 44, 306, 2);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (307, 110, 307, 70);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (308, 157, 308, 58);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (309, 72, 309, 10);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (310, 110, 310, 25);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (311, 85, 311, 82);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (312, 130, 312, 80);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (313, 200, 313, 29);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (314, 8, 314, 83);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (315, 162, 315, 87);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (316, 129, 316, 43);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (317, 85, 317, 54);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (318, 165, 318, 69);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (319, 77, 319, 69);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (320, 166, 320, 54);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (321, 48, 321, 91);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (322, 62, 322, 8);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (323, 63, 323, 63);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (324, 69, 324, 34);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (325, 84, 325, 18);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (326, 98, 326, 61);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (327, 99, 327, 41);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (328, 90, 328, 27);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (329, 46, 329, 10);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (330, 39, 330, 4);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (331, 48, 331, 14);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (332, 71, 332, 47);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (333, 3, 333, 25);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (334, 22, 334, 42);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (335, 4, 335, 70);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (336, 166, 336, 23);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (337, 156, 337, 57);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (338, 194, 338, 97);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (339, 58, 339, 78);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (340, 10, 340, 35);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (341, 28, 341, 4);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (342, 105, 342, 88);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (343, 53, 343, 4);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (344, 82, 344, 83);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (345, 104, 345, 57);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (346, 161, 346, 17);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (347, 146, 347, 42);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (348, 94, 348, 69);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (349, 46, 349, 35);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (350, 52, 350, 92);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (351, 130, 351, 96);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (352, 175, 352, 8);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (353, 102, 353, 58);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (354, 148, 354, 47);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (355, 125, 355, 48);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (356, 106, 356, 68);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (357, 187, 357, 51);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (358, 198, 358, 90);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (359, 15, 359, 46);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (360, 6, 360, 48);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (361, 115, 361, 90);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (362, 83, 362, 78);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (363, 142, 363, 74);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (364, 25, 364, 83);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (365, 138, 365, 91);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (366, 146, 366, 40);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (367, 161, 367, 51);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (368, 94, 368, 32);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (369, 58, 369, 96);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (370, 15, 370, 16);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (371, 42, 371, 47);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (372, 185, 372, 18);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (373, 54, 373, 14);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (374, 151, 374, 43);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (375, 173, 375, 72);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (376, 192, 376, 16);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (377, 10, 377, 69);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (378, 145, 378, 75);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (379, 158, 379, 11);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (380, 108, 380, 11);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (381, 20, 381, 95);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (382, 165, 382, 32);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (383, 126, 383, 40);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (384, 69, 384, 3);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (385, 142, 385, 53);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (386, 96, 386, 3);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (387, 174, 387, 98);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (388, 170, 388, 97);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (389, 169, 389, 27);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (390, 46, 390, 56);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (391, 162, 391, 13);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (392, 78, 392, 13);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (393, 114, 393, 54);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (394, 134, 394, 73);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (395, 168, 395, 12);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (396, 155, 396, 61);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (397, 168, 397, 61);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (398, 122, 398, 30);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (399, 94, 399, 78);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (400, 18, 400, 87);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (401, 163, 401, 74);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (402, 155, 402, 0);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (403, 158, 403, 2);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (404, 88, 404, 1);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (405, 87, 405, 72);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (406, 64, 406, 24);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (407, 44, 407, 73);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (408, 99, 408, 48);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (409, 6, 409, 57);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (410, 168, 410, 98);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (411, 142, 411, 57);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (412, 155, 412, 10);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (413, 49, 413, 27);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (414, 66, 414, 12);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (415, 11, 415, 70);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (416, 193, 416, 74);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (417, 7, 417, 75);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (418, 44, 418, 3);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (419, 172, 419, 66);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (420, 154, 420, 77);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (421, 108, 421, 47);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (422, 105, 422, 14);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (423, 198, 423, 97);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (424, 172, 424, 4);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (425, 75, 425, 61);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (426, 177, 426, 4);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (427, 126, 427, 95);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (428, 150, 428, 22);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (429, 164, 429, 95);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (430, 60, 430, 88);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (431, 50, 431, 83);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (432, 44, 432, 9);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (433, 174, 433, 53);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (434, 150, 434, 0);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (435, 126, 435, 55);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (436, 129, 436, 10);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (437, 149, 437, 74);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (438, 93, 438, 44);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (439, 148, 439, 44);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (440, 59, 440, 22);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (441, 93, 441, 84);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (442, 22, 442, 74);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (443, 50, 443, 97);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (444, 43, 444, 37);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (445, 12, 445, 14);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (446, 51, 446, 33);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (447, 80, 447, 85);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (448, 89, 448, 15);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (449, 139, 449, 42);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (450, 127, 450, 84);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (451, 159, 451, 91);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (452, 131, 452, 11);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (453, 109, 453, 82);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (454, 151, 454, 6);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (455, 10, 455, 3);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (456, 30, 456, 18);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (457, 183, 457, 16);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (458, 194, 458, 4);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (459, 32, 459, 16);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (460, 139, 460, 34);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (461, 14, 461, 60);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (462, 82, 462, 40);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (463, 135, 463, 21);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (464, 163, 464, 97);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (465, 179, 465, 51);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (466, 89, 466, 78);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (467, 66, 467, 77);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (468, 35, 468, 29);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (469, 105, 469, 15);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (470, 76, 470, 98);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (471, 116, 471, 81);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (472, 129, 472, 63);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (473, 5, 473, 47);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (474, 11, 474, 26);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (475, 146, 475, 71);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (476, 196, 476, 30);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (477, 53, 477, 33);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (478, 54, 478, 19);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (479, 173, 479, 62);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (480, 87, 480, 63);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (481, 25, 481, 19);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (482, 145, 482, 85);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (483, 165, 483, 6);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (484, 141, 484, 56);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (485, 69, 485, 1);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (486, 72, 486, 25);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (487, 22, 487, 75);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (488, 158, 488, 30);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (489, 172, 489, 19);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (490, 195, 490, 5);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (491, 86, 491, 6);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (492, 89, 492, 81);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (493, 62, 493, 73);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (494, 75, 494, 35);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (495, 108, 495, 89);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (496, 151, 496, 92);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (497, 114, 497, 96);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (498, 194, 498, 19);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (499, 131, 499, 69);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (500, 94, 500, 19);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (501, 188, 501, 36);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (502, 191, 502, 16);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (503, 140, 503, 27);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (504, 35, 504, 67);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (505, 152, 505, 65);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (506, 135, 506, 23);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (507, 63, 507, 82);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (508, 142, 508, 78);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (509, 188, 509, 24);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (510, 156, 510, 49);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (511, 66, 511, 49);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (512, 89, 512, 29);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (513, 178, 513, 77);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (514, 154, 514, 35);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (515, 119, 515, 83);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (516, 89, 516, 19);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (517, 51, 517, 39);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (518, 132, 518, 34);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (519, 138, 519, 80);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (520, 171, 520, 25);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (521, 52, 521, 81);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (522, 155, 522, 58);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (523, 25, 523, 62);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (524, 88, 524, 62);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (525, 12, 525, 85);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (526, 7, 526, 24);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (527, 186, 527, 98);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (528, 57, 528, 2);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (529, 132, 529, 21);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (530, 67, 530, 62);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (531, 199, 531, 59);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (532, 58, 532, 76);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (533, 181, 533, 44);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (534, 84, 534, 43);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (535, 76, 535, 23);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (536, 2, 536, 69);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (537, 165, 537, 71);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (538, 186, 538, 85);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (539, 175, 539, 11);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (540, 17, 540, 52);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (541, 122, 541, 58);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (542, 62, 542, 92);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (543, 199, 543, 25);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (544, 89, 544, 22);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (545, 100, 545, 42);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (546, 18, 546, 18);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (547, 46, 547, 9);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (548, 38, 548, 49);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (549, 183, 549, 54);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (550, 51, 550, 39);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (551, 23, 551, 74);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (552, 101, 552, 47);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (553, 174, 553, 95);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (554, 74, 554, 4);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (555, 111, 555, 24);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (556, 71, 556, 65);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (557, 57, 557, 6);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (558, 62, 558, 1);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (559, 119, 559, 33);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (560, 175, 560, 78);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (561, 87, 561, 98);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (562, 99, 562, 37);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (563, 88, 563, 42);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (564, 55, 564, 19);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (565, 68, 565, 32);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (566, 149, 566, 14);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (567, 133, 567, 13);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (568, 7, 568, 74);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (569, 156, 569, 21);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (570, 165, 570, 27);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (571, 148, 571, 77);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (572, 134, 572, 49);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (573, 61, 573, 40);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (574, 130, 574, 64);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (575, 141, 575, 87);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (576, 174, 576, 94);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (577, 32, 577, 78);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (578, 73, 578, 33);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (579, 128, 579, 73);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (580, 99, 580, 14);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (581, 105, 581, 19);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (582, 198, 582, 80);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (583, 163, 583, 47);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (584, 172, 584, 51);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (585, 146, 585, 33);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (586, 40, 586, 18);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (587, 130, 587, 39);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (588, 41, 588, 92);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (589, 147, 589, 57);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (590, 32, 590, 19);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (591, 116, 591, 50);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (592, 18, 592, 73);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (593, 180, 593, 90);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (594, 89, 594, 64);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (595, 28, 595, 54);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (596, 70, 596, 73);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (597, 41, 597, 16);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (598, 25, 598, 58);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (599, 125, 599, 72);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (600, 105, 600, 82);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (601, 149, 601, 10);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (602, 190, 602, 94);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (603, 173, 603, 21);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (604, 12, 604, 57);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (605, 119, 605, 49);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (606, 138, 606, 76);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (607, 34, 607, 31);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (608, 176, 608, 32);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (609, 55, 609, 71);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (610, 104, 610, 89);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (611, 135, 611, 6);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (612, 154, 612, 49);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (613, 193, 613, 5);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (614, 83, 614, 47);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (615, 184, 615, 25);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (616, 185, 616, 26);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (617, 112, 617, 38);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (618, 109, 618, 89);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (619, 89, 619, 4);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (620, 147, 620, 41);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (621, 52, 621, 21);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (622, 173, 622, 97);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (623, 106, 623, 93);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (624, 3, 624, 46);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (625, 172, 625, 23);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (626, 79, 626, 77);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (627, 141, 627, 57);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (628, 29, 628, 94);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (629, 172, 629, 87);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (630, 56, 630, 58);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (631, 166, 631, 85);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (632, 128, 632, 52);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (633, 8, 633, 11);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (634, 151, 634, 17);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (635, 42, 635, 3);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (636, 122, 636, 15);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (637, 102, 637, 67);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (638, 125, 638, 80);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (639, 96, 639, 0);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (640, 47, 640, 49);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (641, 48, 641, 66);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (642, 77, 642, 98);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (643, 66, 643, 98);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (644, 50, 644, 79);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (645, 79, 645, 54);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (646, 140, 646, 14);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (647, 124, 647, 92);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (648, 114, 648, 27);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (649, 48, 649, 99);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (650, 49, 650, 57);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (651, 44, 651, 59);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (652, 38, 652, 20);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (653, 50, 653, 80);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (654, 22, 654, 60);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (655, 176, 655, 85);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (656, 1, 656, 38);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (657, 46, 657, 62);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (658, 92, 658, 85);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (659, 194, 659, 53);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (660, 6, 660, 9);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (661, 109, 661, 22);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (662, 115, 662, 68);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (663, 39, 663, 51);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (664, 180, 664, 61);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (665, 93, 665, 20);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (666, 47, 666, 33);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (667, 19, 667, 46);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (668, 186, 668, 60);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (669, 84, 669, 47);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (670, 83, 670, 82);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (671, 30, 671, 3);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (672, 35, 672, 84);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (673, 171, 673, 98);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (674, 50, 674, 71);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (675, 105, 675, 2);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (676, 164, 676, 28);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (677, 51, 677, 19);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (678, 184, 678, 61);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (679, 137, 679, 66);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (680, 65, 680, 23);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (681, 115, 681, 67);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (682, 93, 682, 61);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (683, 171, 683, 7);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (684, 179, 684, 2);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (685, 111, 685, 30);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (686, 81, 686, 80);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (687, 101, 687, 14);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (688, 156, 688, 53);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (689, 146, 689, 10);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (690, 145, 690, 79);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (691, 3, 691, 14);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (692, 184, 692, 31);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (693, 5, 693, 60);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (694, 176, 694, 2);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (695, 199, 695, 35);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (696, 165, 696, 28);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (697, 21, 697, 4);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (698, 198, 698, 6);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (699, 120, 699, 11);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (700, 51, 700, 63);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (701, 72, 701, 56);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (702, 132, 702, 20);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (703, 59, 703, 39);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (704, 133, 704, 22);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (705, 104, 705, 49);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (706, 182, 706, 9);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (707, 180, 707, 93);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (708, 70, 708, 67);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (709, 54, 709, 83);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (710, 23, 710, 73);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (711, 134, 711, 80);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (712, 100, 712, 94);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (713, 127, 713, 51);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (714, 103, 714, 46);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (715, 70, 715, 25);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (716, 120, 716, 11);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (717, 170, 717, 52);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (718, 104, 718, 28);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (719, 131, 719, 98);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (720, 52, 720, 63);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (721, 80, 721, 48);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (722, 68, 722, 21);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (723, 104, 723, 34);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (724, 34, 724, 15);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (725, 42, 725, 87);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (726, 80, 726, 28);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (727, 184, 727, 53);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (728, 51, 728, 6);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (729, 86, 729, 88);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (730, 116, 730, 83);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (731, 25, 731, 78);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (732, 117, 732, 98);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (733, 154, 733, 28);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (734, 81, 734, 98);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (735, 105, 735, 81);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (736, 179, 736, 19);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (737, 199, 737, 36);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (738, 56, 738, 67);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (739, 52, 739, 89);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (740, 169, 740, 61);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (741, 150, 741, 63);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (742, 89, 742, 34);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (743, 11, 743, 57);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (744, 125, 744, 64);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (745, 30, 745, 15);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (746, 153, 746, 92);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (747, 117, 747, 72);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (748, 183, 748, 59);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (749, 27, 749, 90);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (750, 162, 750, 5);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (751, 129, 751, 94);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (752, 9, 752, 7);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (753, 112, 753, 71);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (754, 87, 754, 64);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (755, 146, 755, 98);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (756, 6, 756, 50);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (757, 54, 757, 88);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (758, 132, 758, 83);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (759, 146, 759, 92);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (760, 174, 760, 83);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (761, 50, 761, 67);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (762, 98, 762, 41);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (763, 134, 763, 90);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (764, 177, 764, 98);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (765, 146, 765, 84);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (766, 128, 766, 42);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (767, 48, 767, 85);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (768, 135, 768, 46);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (769, 48, 769, 66);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (770, 26, 770, 62);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (771, 191, 771, 74);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (772, 94, 772, 81);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (773, 109, 773, 3);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (774, 70, 774, 47);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (775, 176, 775, 7);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (776, 179, 776, 24);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (777, 102, 777, 42);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (778, 122, 778, 2);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (779, 128, 779, 61);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (780, 159, 780, 93);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (781, 3, 781, 4);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (782, 7, 782, 63);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (783, 32, 783, 93);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (784, 27, 784, 77);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (785, 98, 785, 5);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (786, 16, 786, 75);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (787, 79, 787, 93);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (788, 76, 788, 44);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (789, 152, 789, 10);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (790, 19, 790, 87);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (791, 19, 791, 69);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (792, 183, 792, 86);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (793, 192, 793, 22);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (794, 166, 794, 4);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (795, 96, 795, 4);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (796, 125, 796, 10);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (797, 1, 797, 55);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (798, 90, 798, 53);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (799, 86, 799, 94);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (800, 104, 800, 48);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (801, 3, 801, 96);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (802, 60, 802, 26);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (803, 39, 803, 66);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (804, 60, 804, 76);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (805, 138, 805, 6);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (806, 182, 806, 57);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (807, 189, 807, 11);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (808, 150, 808, 26);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (809, 49, 809, 17);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (810, 42, 810, 93);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (811, 200, 811, 44);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (812, 72, 812, 17);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (813, 104, 813, 81);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (814, 47, 814, 49);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (815, 118, 815, 1);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (816, 2, 816, 47);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (817, 167, 817, 47);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (818, 169, 818, 79);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (819, 169, 819, 41);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (820, 162, 820, 84);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (821, 184, 821, 83);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (822, 53, 822, 35);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (823, 36, 823, 32);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (824, 61, 824, 76);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (825, 168, 825, 61);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (826, 33, 826, 71);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (827, 133, 827, 56);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (828, 171, 828, 16);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (829, 189, 829, 18);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (830, 200, 830, 42);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (831, 164, 831, 17);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (832, 46, 832, 53);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (833, 177, 833, 46);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (834, 156, 834, 26);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (835, 26, 835, 47);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (836, 34, 836, 66);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (837, 197, 837, 5);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (838, 58, 838, 12);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (839, 19, 839, 20);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (840, 94, 840, 51);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (841, 182, 841, 59);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (842, 121, 842, 13);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (843, 196, 843, 16);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (844, 154, 844, 25);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (845, 116, 845, 46);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (846, 50, 846, 20);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (847, 196, 847, 3);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (848, 55, 848, 70);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (849, 157, 849, 80);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (850, 129, 850, 8);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (851, 15, 851, 19);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (852, 57, 852, 55);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (853, 182, 853, 11);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (854, 114, 854, 88);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (855, 134, 855, 92);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (856, 47, 856, 16);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (857, 82, 857, 0);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (858, 172, 858, 66);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (859, 15, 859, 1);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (860, 25, 860, 68);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (861, 40, 861, 12);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (862, 89, 862, 11);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (863, 115, 863, 74);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (864, 161, 864, 52);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (865, 128, 865, 51);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (866, 75, 866, 99);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (867, 146, 867, 61);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (868, 178, 868, 78);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (869, 6, 869, 63);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (870, 48, 870, 79);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (871, 56, 871, 99);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (872, 28, 872, 19);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (873, 141, 873, 22);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (874, 23, 874, 61);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (875, 156, 875, 78);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (876, 29, 876, 71);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (877, 181, 877, 62);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (878, 144, 878, 3);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (879, 195, 879, 82);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (880, 160, 880, 89);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (881, 38, 881, 34);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (882, 72, 882, 65);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (883, 136, 883, 94);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (884, 162, 884, 65);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (885, 50, 885, 76);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (886, 58, 886, 42);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (887, 167, 887, 2);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (888, 191, 888, 40);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (889, 134, 889, 37);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (890, 54, 890, 43);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (891, 149, 891, 52);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (892, 89, 892, 40);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (893, 136, 893, 42);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (894, 5, 894, 9);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (895, 105, 895, 32);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (896, 177, 896, 46);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (897, 50, 897, 92);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (898, 18, 898, 97);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (899, 46, 899, 29);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (900, 35, 900, 77);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (901, 29, 901, 73);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (902, 194, 902, 51);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (903, 150, 903, 52);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (904, 62, 904, 70);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (905, 39, 905, 63);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (906, 52, 906, 25);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (907, 15, 907, 2);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (908, 161, 908, 95);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (909, 173, 909, 62);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (910, 138, 910, 31);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (911, 26, 911, 3);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (912, 55, 912, 14);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (913, 73, 913, 14);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (914, 78, 914, 3);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (915, 70, 915, 51);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (916, 139, 916, 97);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (917, 84, 917, 35);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (918, 141, 918, 36);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (919, 113, 919, 5);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (920, 188, 920, 49);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (921, 156, 921, 7);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (922, 199, 922, 40);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (923, 167, 923, 28);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (924, 106, 924, 17);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (925, 127, 925, 64);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (926, 148, 926, 43);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (927, 104, 927, 84);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (928, 14, 928, 98);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (929, 78, 929, 20);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (930, 184, 930, 95);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (931, 78, 931, 59);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (932, 189, 932, 26);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (933, 11, 933, 39);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (934, 199, 934, 96);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (935, 148, 935, 38);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (936, 174, 936, 19);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (937, 122, 937, 17);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (938, 65, 938, 87);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (939, 136, 939, 27);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (940, 119, 940, 22);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (941, 107, 941, 18);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (942, 47, 942, 36);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (943, 49, 943, 2);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (944, 147, 944, 98);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (945, 5, 945, 94);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (946, 123, 946, 61);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (947, 32, 947, 6);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (948, 30, 948, 56);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (949, 133, 949, 15);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (950, 147, 950, 51);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (951, 3, 951, 94);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (952, 110, 952, 2);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (953, 133, 953, 80);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (954, 79, 954, 74);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (955, 5, 955, 34);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (956, 36, 956, 50);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (957, 164, 957, 70);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (958, 190, 958, 94);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (959, 159, 959, 13);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (960, 153, 960, 97);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (961, 84, 961, 77);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (962, 36, 962, 10);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (963, 74, 963, 82);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (964, 193, 964, 31);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (965, 38, 965, 36);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (966, 71, 966, 65);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (967, 146, 967, 78);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (968, 74, 968, 51);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (969, 80, 969, 38);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (970, 84, 970, 21);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (971, 148, 971, 2);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (972, 197, 972, 96);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (973, 71, 973, 57);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (974, 142, 974, 57);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (975, 104, 975, 94);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (976, 92, 976, 48);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (977, 156, 977, 26);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (978, 159, 978, 72);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (979, 135, 979, 62);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (980, 74, 980, 42);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (981, 147, 981, 82);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (982, 45, 982, 46);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (983, 141, 983, 37);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (984, 78, 984, 49);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (985, 23, 985, 41);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (986, 46, 986, 24);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (987, 15, 987, 82);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (988, 183, 988, 49);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (989, 23, 989, 91);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (990, 139, 990, 74);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (991, 182, 991, 36);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (992, 160, 992, 87);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (993, 188, 993, 20);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (994, 72, 994, 89);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (995, 10, 995, 56);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (996, 189, 996, 77);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (997, 48, 997, 77);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (998, 26, 998, 79);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (999, 160, 999, 95);
INSERT INTO book_store.book2author (id, author_id, book_id, sort_index) VALUES (1000, 92, 1000, 53);


--
-- Data for Name: book2genre; Type: TABLE DATA; Schema: book_store; Owner: postgres
--



--
-- Data for Name: book2user; Type: TABLE DATA; Schema: book_store; Owner: postgres
--



--
-- Data for Name: book2user_type; Type: TABLE DATA; Schema: book_store; Owner: postgres
--



--
-- Data for Name: book_file; Type: TABLE DATA; Schema: book_store; Owner: postgres
--



--
-- Data for Name: book_file_type; Type: TABLE DATA; Schema: book_store; Owner: postgres
--



--
-- Data for Name: book_review; Type: TABLE DATA; Schema: book_store; Owner: postgres
--



--
-- Data for Name: book_review_like; Type: TABLE DATA; Schema: book_store; Owner: postgres
--



--
-- Data for Name: books; Type: TABLE DATA; Schema: book_store; Owner: postgres
--

INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (1, 'This is a description of Book Infinite Jest', 28, '/assets/img/content/main/card2.jpg', false, 1355.1958795444411, '2016-07-30', '98db25f8-c277-4f76-8891-ec3d4a815c74', 'Infinite Jest');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (2, 'This is a description of Book Specimen Days', 43, '/assets/img/content/main/card2.jpg', true, 5014.556924732824, '2022-10-11', 'aa692804-3355-40bc-8a43-778a46c6e70c', 'Specimen Days');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (3, 'This is a description of Book Tender Is the Night', 2, '/assets/img/content/main/card2.jpg', false, 4107.809517367441, '2018-12-09', '4d6c9748-ec96-4b10-9197-4cb0ffbec9c2', 'Tender Is the Night');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (4, 'This is a description of Book Shall not Perish', 6, '/assets/img/content/main/card2.jpg', true, 545.078999024244, '2013-10-19', 'e6c937ed-2fad-4c33-82db-e0c0625706c8', 'Shall not Perish');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (5, 'This is a description of Book Look to Windward', 31, '/assets/img/content/main/card2.jpg', false, 853.1953241519986, '2018-11-29', '5f38e36d-8400-4b66-897f-0a5d564d12cd', 'Look to Windward');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (6, 'This is a description of Book Fair Stood the Wind for France', 22, '/assets/img/content/main/card2.jpg', false, 1242.6590262991854, '2014-12-16', '9e5d8e5a-5054-4e10-82de-e11651c8f034', 'Fair Stood the Wind for France');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (7, 'This is a description of Book Terrible Swift Sword', 25, '/assets/img/content/main/card2.jpg', true, 2011.647031049264, '2016-05-09', '86d272af-d28b-4788-9c96-77570371b242', 'Terrible Swift Sword');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (8, 'This is a description of Book The Curious Incident of the Dog in the Night-Time', 39, '/assets/img/content/main/card2.jpg', false, 2843.405936354449, '2013-06-20', '99851b25-bd8e-4d72-a64f-16c3806bf9af', 'The Curious Incident of the Dog in the Night-Time');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (9, 'This is a description of Book Oh! To be in England', 39, '/assets/img/content/main/card2.jpg', false, 4810.562208732455, '2013-04-22', 'f7ece7ed-272c-43cd-aa4c-7b612a22ec6e', 'Oh! To be in England');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (10, 'This is a description of Book The Grapes of Wrath', 42, '/assets/img/content/main/card2.jpg', true, 3746.55202990685, '2015-11-14', 'ed431bee-4f2e-45e1-bc34-3f8af6ba5f19', 'The Grapes of Wrath');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (11, 'This is a description of Book A Many-Splendoured Thing', 37, '/assets/img/content/main/card2.jpg', false, 3609.850491312572, '2018-03-27', '82dc10ea-6638-4df8-bcb5-e3ef5252c88d', 'A Many-Splendoured Thing');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (12, 'This is a description of Book Great Work of Time', 6, '/assets/img/content/main/card2.jpg', true, 595.3237952331401, '2016-08-25', '7a74c4f6-9c95-4593-b9e2-f25e66808327', 'Great Work of Time');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (13, 'This is a description of Book Far From the Madding Crowd', 11, '/assets/img/content/main/card2.jpg', true, 3476.4540154073957, '2019-03-12', '302f2b50-0d31-4be6-8bc7-3c83ffa3526f', 'Far From the Madding Crowd');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (14, 'This is a description of Book A Summer Bird-Cage', 21, '/assets/img/content/main/card2.jpg', true, 2129.9818386229144, '2015-03-10', '82db8569-acbb-46d0-849b-1c032499edb3', 'A Summer Bird-Cage');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (15, 'This is a description of Book The Monkey''s Raincoat', 49, '/assets/img/content/main/card2.jpg', false, 2325.3142209195266, '2021-07-31', '225aafa1-e4a5-4158-b73f-35811db84d18', 'The Monkey''s Raincoat');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (16, 'This is a description of Book The Far-Distant Oxus', 14, '/assets/img/content/main/card2.jpg', false, 1476.1376818406288, '2019-12-01', 'b53aa9b6-938a-446f-b32c-93f591e2b80d', 'The Far-Distant Oxus');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (17, 'This is a description of Book The Doors of Perception', 25, '/assets/img/content/main/card2.jpg', false, 331.9032969929465, '2018-01-10', '8899cf8a-9988-48bd-81c1-51b51c7160ea', 'The Doors of Perception');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (18, 'This is a description of Book By Grand Central Station I Sat Down and Wept', 23, '/assets/img/content/main/card2.jpg', true, 1485.4115288682501, '2018-05-31', '879941c1-abaa-411d-ba18-4ec8b995a079', 'By Grand Central Station I Sat Down and Wept');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (19, 'This is a description of Book Butter In a Lordly Dish', 2, '/assets/img/content/main/card2.jpg', false, 125.62693140467333, '2017-04-29', '8507509d-2565-4197-83a4-7ad5690a89b4', 'Butter In a Lordly Dish');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (20, 'This is a description of Book A Glass of Blessings', 33, '/assets/img/content/main/card2.jpg', true, 3102.9968013623934, '2013-10-16', 'dfae9a44-3839-49b4-9514-0d27c263eef3', 'A Glass of Blessings');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (21, 'This is a description of Book When the Green Woods Laugh', 26, '/assets/img/content/main/card2.jpg', true, 2119.1509497813336, '2019-11-03', 'e6d00548-6095-4d59-952c-a0fbb113a06e', 'When the Green Woods Laugh');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (22, 'This is a description of Book The Glory and the Dream', 13, '/assets/img/content/main/card2.jpg', false, 1990.6710465511637, '2016-07-23', 'a38a05ae-cd0c-4006-b747-69b8b8d482b4', 'The Glory and the Dream');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (23, 'This is a description of Book The Moving Finger', 20, '/assets/img/content/main/card2.jpg', true, 2549.5206140567902, '2022-04-14', 'f28140d1-e0a2-4589-8bca-236bbb3c3710', 'The Moving Finger');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (24, 'This is a description of Book That Good Night', 14, '/assets/img/content/main/card2.jpg', true, 4952.649865906036, '2019-08-02', '16233327-a28e-4824-9421-d624212eae5f', 'That Good Night');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (25, 'This is a description of Book When the Green Woods Laugh', 26, '/assets/img/content/main/card2.jpg', true, 2444.9498506931786, '2019-11-12', 'd0b006a0-efc0-4556-a58f-0b3d257ad71c', 'When the Green Woods Laugh');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (26, 'This is a description of Book The Sun Also Rises', 48, '/assets/img/content/main/card2.jpg', false, 3227.5663046277236, '2022-10-02', '644fc8f1-a69f-4401-bb87-328d83c82ce0', 'The Sun Also Rises');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (27, 'This is a description of Book Terrible Swift Sword', 31, '/assets/img/content/main/card2.jpg', false, 1317.3399508758102, '2019-11-17', 'f3671b0b-131f-4f00-a81b-cb303497cfa6', 'Terrible Swift Sword');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (28, 'This is a description of Book Number the Stars', 1, '/assets/img/content/main/card2.jpg', true, 1340.9025637832622, '2016-02-28', '6674ffcc-1129-4f7e-9d21-77a12a60decb', 'Number the Stars');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (29, 'This is a description of Book The Waste Land', 42, '/assets/img/content/main/card2.jpg', false, 1653.0341410584435, '2015-06-08', '49d51f10-e37f-46f8-b929-dea049baa8e9', 'The Waste Land');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (30, 'This is a description of Book The Lathe of Heaven', 7, '/assets/img/content/main/card2.jpg', false, 432.76820778734276, '2019-08-03', '3eb68d13-3865-46aa-881c-a8b234922a3e', 'The Lathe of Heaven');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (31, 'This is a description of Book Number the Stars', 38, '/assets/img/content/main/card2.jpg', false, 255.47606317738757, '2022-04-16', '5fe9c4a1-bc6c-4bc8-bef4-9e753ce06bf3', 'Number the Stars');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (32, 'This is a description of Book To Your Scattered Bodies Go', 36, '/assets/img/content/main/card2.jpg', false, 2711.857870739503, '2014-07-31', '4af80366-2399-49d2-815d-0225fc6da5b7', 'To Your Scattered Bodies Go');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (33, 'This is a description of Book Dance Dance Dance', 32, '/assets/img/content/main/card2.jpg', false, 3139.3761968880945, '2018-01-29', '317b5270-0519-45e3-8793-a39260c7bdbe', 'Dance Dance Dance');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (34, 'This is a description of Book Fame Is the Spur', 42, '/assets/img/content/main/card2.jpg', false, 451.31482580941974, '2020-03-26', '3321209e-bd82-477a-976c-0c74d44666ca', 'Fame Is the Spur');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (35, 'This is a description of Book Shall not Perish', 26, '/assets/img/content/main/card2.jpg', true, 2111.6195472843183, '2019-03-03', '25a05cef-3f47-4c43-965b-ab45c7d01f16', 'Shall not Perish');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (36, 'This is a description of Book Gone with the Wind', 36, '/assets/img/content/main/card2.jpg', true, 1087.6420530026849, '2020-09-16', '284eb72b-8735-4a81-837c-fcdf7ebbc57f', 'Gone with the Wind');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (37, 'This is a description of Book Precious Bane', 3, '/assets/img/content/main/card2.jpg', true, 3707.4988327576107, '2022-01-15', '10af109f-061d-453b-8574-9840bbd0d946', 'Precious Bane');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (38, 'This is a description of Book If I Forget Thee Jerusalem', 50, '/assets/img/content/main/card2.jpg', true, 203.54138243411415, '2020-12-05', '9431ccff-2bd5-4d1b-95c2-2b0e259cc6f6', 'If I Forget Thee Jerusalem');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (39, 'This is a description of Book Death Be Not Proud', 46, '/assets/img/content/main/card2.jpg', false, 3794.317630289021, '2018-11-08', 'ce353080-d028-4178-ad51-bf50514e7d91', 'Death Be Not Proud');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (40, 'This is a description of Book Consider Phlebas', 12, '/assets/img/content/main/card2.jpg', true, 4220.910033183002, '2016-01-04', '6c831fe4-83b8-4b41-a1ac-26cf45d702af', 'Consider Phlebas');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (41, 'This is a description of Book In a Glass Darkly', 24, '/assets/img/content/main/card2.jpg', false, 2211.974545483269, '2021-05-05', 'fae26b97-030e-4331-a247-5fa9d5f536f2', 'In a Glass Darkly');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (42, 'This is a description of Book Absalom, Absalom!', 34, '/assets/img/content/main/card2.jpg', false, 2169.202921680362, '2013-10-24', 'de2a74fc-b29e-4453-ae5a-98e110466da5', 'Absalom, Absalom!');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (43, 'This is a description of Book The Needle''s Eye', 32, '/assets/img/content/main/card2.jpg', false, 920.6689115869412, '2018-11-29', '6a693acf-a474-4b40-9174-9104f3120371', 'The Needle''s Eye');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (44, 'This is a description of Book The Road Less Traveled', 2, '/assets/img/content/main/card2.jpg', false, 904.9833596750673, '2017-07-22', '789e5c48-0f99-4465-8991-d736a37e6533', 'The Road Less Traveled');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (45, 'This is a description of Book Taming a Sea Horse', 1, '/assets/img/content/main/card2.jpg', true, 2830.326610057963, '2019-10-06', '5cbbc395-fd87-4714-af00-7019e748a205', 'Taming a Sea Horse');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (46, 'This is a description of Book Ring of Bright Water', 31, '/assets/img/content/main/card2.jpg', true, 1815.9734590231214, '2021-06-07', 'cac8935c-2767-4885-a3e9-e31165323a19', 'Ring of Bright Water');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (47, 'This is a description of Book Far From the Madding Crowd', 33, '/assets/img/content/main/card2.jpg', false, 2178.056538348204, '2021-04-08', '2743f1b3-68b5-4be1-8122-a7dd2e4fa64b', 'Far From the Madding Crowd');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (48, 'This is a description of Book A Glass of Blessings', 41, '/assets/img/content/main/card2.jpg', false, 4407.002341078921, '2014-04-30', '84327aa9-e37f-478b-948a-ef826e4a066f', 'A Glass of Blessings');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (49, 'This is a description of Book From Here to Eternity', 14, '/assets/img/content/main/card2.jpg', false, 453.84859939826526, '2020-02-20', 'c3d633c0-a39b-40da-a46c-f7ea4a1e0758', 'From Here to Eternity');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (50, 'This is a description of Book Terrible Swift Sword', 10, '/assets/img/content/main/card2.jpg', false, 1292.3931202028925, '2018-09-14', '1b56caea-5b0d-4efb-8c73-2495e1d8795e', 'Terrible Swift Sword');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (51, 'This is a description of Book Shall not Perish', 31, '/assets/img/content/main/card2.jpg', false, 2893.606796223074, '2019-01-04', '8dc6f58c-af27-4107-957c-330dba142a80', 'Shall not Perish');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (52, 'This is a description of Book The Wings of the Dove', 25, '/assets/img/content/main/card2.jpg', true, 1088.9709771214282, '2021-06-13', '4518f2ef-19f8-423c-9637-2a0cba4bccb5', 'The Wings of the Dove');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (53, 'This is a description of Book Postern of Fate', 48, '/assets/img/content/main/card2.jpg', true, 4380.3794066743885, '2020-07-29', '60aba2fd-1d11-47ea-98ab-38a727fedc91', 'Postern of Fate');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (54, 'This is a description of Book Clouds of Witness', 48, '/assets/img/content/main/card2.jpg', true, 382.69121549008753, '2014-04-02', 'd29531c0-34e5-4c34-9a9e-ad3a12a6bb46', 'Clouds of Witness');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (55, 'This is a description of Book Beyond the Mexique Bay', 3, '/assets/img/content/main/card2.jpg', false, 3054.564979307801, '2018-12-24', '0e8c8c2d-50a7-40c5-9813-c5a897d895ff', 'Beyond the Mexique Bay');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (56, 'This is a description of Book The Heart Is Deceitful Above All Things', 47, '/assets/img/content/main/card2.jpg', false, 2659.039137920858, '2021-11-27', 'ef06175c-80a8-4231-974c-6e1a53cf7e84', 'The Heart Is Deceitful Above All Things');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (57, 'This is a description of Book Things Fall Apart', 49, '/assets/img/content/main/card2.jpg', true, 1644.8101065848718, '2023-02-18', 'aea904be-9900-4ecf-b954-e5bf6dd53625', 'Things Fall Apart');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (58, 'This is a description of Book A Scanner Darkly', 0, '/assets/img/content/main/card2.jpg', true, 1455.738392858908, '2015-04-28', 'f0bf876e-8a97-48fd-b19c-fba6dc5d8087', 'A Scanner Darkly');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (59, 'This is a description of Book Clouds of Witness', 19, '/assets/img/content/main/card2.jpg', false, 3077.004036148479, '2016-02-23', 'a365102a-ecc8-4cba-b83b-21bce394bc6d', 'Clouds of Witness');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (60, 'This is a description of Book No Highway', 37, '/assets/img/content/main/card2.jpg', true, 2690.8010140311117, '2023-03-01', '1c7ef067-cd9d-4134-a017-5a23c156b828', 'No Highway');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (61, 'This is a description of Book A Catskill Eagle', 45, '/assets/img/content/main/card2.jpg', false, 3403.057000598532, '2014-05-13', '043ab965-505c-4322-8456-8d7064951cb2', 'A Catskill Eagle');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (62, 'This is a description of Book The Skull Beneath the Skin', 44, '/assets/img/content/main/card2.jpg', true, 2634.6749586671076, '2021-11-08', '7d836ab8-88ba-48c3-82d4-cbde2dc2038a', 'The Skull Beneath the Skin');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (63, 'This is a description of Book By Grand Central Station I Sat Down and Wept', 14, '/assets/img/content/main/card2.jpg', false, 4667.223871525335, '2022-10-10', 'da97ad0a-86c8-4656-8dcc-4d14ddc28aec', 'By Grand Central Station I Sat Down and Wept');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (64, 'This is a description of Book The Skull Beneath the Skin', 5, '/assets/img/content/main/card2.jpg', true, 5041.792179470103, '2018-01-21', '72a5fb55-63c7-4c1b-9c30-87d463d2abcd', 'The Skull Beneath the Skin');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (65, 'This is a description of Book Those Barren Leaves, Thrones, Dominations', 46, '/assets/img/content/main/card2.jpg', false, 1614.411947847845, '2022-12-31', '3f5efac9-d68d-4daf-93b8-b420a46187f7', 'Those Barren Leaves, Thrones, Dominations');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (66, 'This is a description of Book Little Hands Clapping', 18, '/assets/img/content/main/card2.jpg', true, 2020.5251497748786, '2022-02-27', '6a832167-394e-448c-9c58-86f03290f93e', 'Little Hands Clapping');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (67, 'This is a description of Book An Acceptable Time', 48, '/assets/img/content/main/card2.jpg', false, 2060.8603162827335, '2021-09-06', 'aa819274-2308-4697-b2a0-bca036c408ce', 'An Acceptable Time');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (68, 'This is a description of Book Brandy of the Damned', 15, '/assets/img/content/main/card2.jpg', true, 4582.739680965382, '2022-04-10', '11265658-21d5-429f-ab31-e1c716352337', 'Brandy of the Damned');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (69, 'This is a description of Book Time of our Darkness', 49, '/assets/img/content/main/card2.jpg', false, 2664.5765923120266, '2016-10-14', 'e6ff2b4c-e38a-4c18-8ef1-d45b24b1e89e', 'Time of our Darkness');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (70, 'This is a description of Book Tirra Lirra by the River', 12, '/assets/img/content/main/card2.jpg', false, 1507.3385862551208, '2015-12-10', '7a13c513-1c48-480a-8be1-c503fd042062', 'Tirra Lirra by the River');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (71, 'This is a description of Book The Yellow Meads of Asphodel', 43, '/assets/img/content/main/card2.jpg', false, 3103.102660773037, '2021-05-19', '91c79e95-e663-4d5c-bff2-c4b59baa8cd5', 'The Yellow Meads of Asphodel');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (72, 'This is a description of Book Cover Her Face', 26, '/assets/img/content/main/card2.jpg', true, 4962.460386227202, '2015-09-18', 'b3703529-2f29-4a80-b70d-7e6003cd494e', 'Cover Her Face');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (73, 'This is a description of Book It''s a Battlefield', 35, '/assets/img/content/main/card2.jpg', false, 4297.301353912851, '2021-11-29', '6e77b10a-b7a9-490c-a801-e7253e69403b', 'It''s a Battlefield');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (74, 'This is a description of Book Of Mice and Men', 42, '/assets/img/content/main/card2.jpg', true, 2515.100329395614, '2019-11-10', 'c1f5104f-ecd9-4ee3-ad46-30d547a1b604', 'Of Mice and Men');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (75, 'This is a description of Book A Summer Bird-Cage', 8, '/assets/img/content/main/card2.jpg', false, 737.5172794642436, '2018-06-26', '559408c3-92bd-40bf-becb-b136e9421ca4', 'A Summer Bird-Cage');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (76, 'This is a description of Book A Farewell to Arms', 28, '/assets/img/content/main/card2.jpg', true, 3974.612394777699, '2018-01-04', 'fbba7b52-f025-4f3e-908f-59cd892dcc23', 'A Farewell to Arms');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (77, 'This is a description of Book In Dubious Battle', 26, '/assets/img/content/main/card2.jpg', true, 640.3830592314413, '2013-12-14', 'a12ead53-1891-4daa-b69b-f97bf47c0688', 'In Dubious Battle');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (78, 'This is a description of Book No Country for Old Men', 21, '/assets/img/content/main/card2.jpg', true, 4756.8199148111335, '2015-10-20', '56569954-be91-4cd7-a784-eea75f87a072', 'No Country for Old Men');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (79, 'This is a description of Book O Jerusalem!', 43, '/assets/img/content/main/card2.jpg', true, 3766.7922584237895, '2017-07-06', '5cfed072-b492-46e0-8127-b26c5c4f8c2d', 'O Jerusalem!');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (80, 'This is a description of Book The Heart Is Deceitful Above All Things', 10, '/assets/img/content/main/card2.jpg', true, 3248.782635443134, '2014-04-25', '8f46a4ab-046f-405c-ab62-53160cebef82', 'The Heart Is Deceitful Above All Things');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (81, 'This is a description of Book Noli Me Tangere', 1, '/assets/img/content/main/card2.jpg', false, 2298.826845681771, '2020-08-17', 'ea4c22ff-a5a9-49e7-8c0e-68bde9ed6474', 'Noli Me Tangere');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (82, 'This is a description of Book Precious Bane', 24, '/assets/img/content/main/card2.jpg', false, 550.8474258259795, '2015-08-11', '484c1ab6-bec9-4c12-a45b-bd292b7435fb', 'Precious Bane');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (83, 'This is a description of Book To Sail Beyond the Sunset', 3, '/assets/img/content/main/card2.jpg', false, 3296.2540683547268, '2019-01-09', '57358d8c-3871-4951-ae9e-1d24c3e41416', 'To Sail Beyond the Sunset');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (84, 'This is a description of Book Great Work of Time', 31, '/assets/img/content/main/card2.jpg', true, 844.640844115501, '2021-10-17', 'a9305741-e3f8-4150-8422-bd0bc953586d', 'Great Work of Time');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (85, 'This is a description of Book Consider Phlebas', 50, '/assets/img/content/main/card2.jpg', true, 2162.2484801481605, '2018-01-20', '048a5d20-fd1b-4419-b047-04e9c0045df3', 'Consider Phlebas');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (86, 'This is a description of Book The Needle''s Eye', 41, '/assets/img/content/main/card2.jpg', false, 4622.571117661021, '2017-02-03', 'bace5eee-8b9c-4964-8c8a-b272c09bb863', 'The Needle''s Eye');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (87, 'This is a description of Book To Sail Beyond the Sunset', 20, '/assets/img/content/main/card2.jpg', true, 2086.2622106739786, '2023-01-19', 'f54e435c-e71a-4633-a3a1-07957e45934f', 'To Sail Beyond the Sunset');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (88, 'This is a description of Book Beneath the Bleeding', 5, '/assets/img/content/main/card2.jpg', true, 3708.105936507342, '2013-04-23', 'b46e8459-07f7-4a68-92ff-ed50c331715f', 'Beneath the Bleeding');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (89, 'This is a description of Book Blood''s a Rover', 24, '/assets/img/content/main/card2.jpg', true, 1983.082491470255, '2017-10-05', '411a6a68-f18a-4bb6-a30c-d463f298ccbd', 'Blood''s a Rover');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (90, 'This is a description of Book The Yellow Meads of Asphodel', 46, '/assets/img/content/main/card2.jpg', true, 3559.2262981704857, '2018-07-26', '1c9414f9-081d-4ae9-bf68-e90950bfacea', 'The Yellow Meads of Asphodel');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (91, 'This is a description of Book The Last Temptation', 44, '/assets/img/content/main/card2.jpg', true, 671.5613952156374, '2022-10-04', '44436387-426f-4af3-9e32-3064c3147ccf', 'The Last Temptation');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (92, 'This is a description of Book Vile Bodies', 24, '/assets/img/content/main/card2.jpg', true, 3241.6553604982687, '2014-12-18', '480cabbd-7194-47a2-8f1d-78fad0fc87f3', 'Vile Bodies');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (93, 'This is a description of Book The Violent Bear It Away', 44, '/assets/img/content/main/card2.jpg', true, 2442.8695236536537, '2018-06-27', '8f98f9cf-a03a-4304-bff9-8a393fc7628d', 'The Violent Bear It Away');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (94, 'This is a description of Book Quo Vadis', 46, '/assets/img/content/main/card2.jpg', true, 4131.58911639914, '2019-10-18', 'd7f337fc-946a-40a8-8a16-963c30dee231', 'Quo Vadis');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (95, 'This is a description of Book Moab Is My Washpot', 45, '/assets/img/content/main/card2.jpg', true, 590.3631922656366, '2018-01-20', '349374c4-3dbc-4845-ab83-7d220070beae', 'Moab Is My Washpot');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (96, 'This is a description of Book Postern of Fate', 3, '/assets/img/content/main/card2.jpg', false, 232.06133318107914, '2017-08-03', 'd3095ec3-679a-4c43-8e69-72d86f357451', 'Postern of Fate');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (97, 'This is a description of Book The Wings of the Dove', 14, '/assets/img/content/main/card2.jpg', false, 789.823074757899, '2019-11-29', '983c708e-8fed-4142-980a-ea3327b5cacb', 'The Wings of the Dove');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (98, 'This is a description of Book Bury My Heart at Wounded Knee', 0, '/assets/img/content/main/card2.jpg', false, 3351.8416051762215, '2015-07-27', 'e9cdb8f1-af46-42a1-ae39-742b03a4a108', 'Bury My Heart at Wounded Knee');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (99, 'This is a description of Book The Violent Bear It Away', 19, '/assets/img/content/main/card2.jpg', false, 132.34023334861726, '2017-04-07', '39a00462-0848-4d80-bf78-97587d516a68', 'The Violent Bear It Away');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (100, 'This is a description of Book Everything is Illuminated', 34, '/assets/img/content/main/card2.jpg', true, 4134.959937920646, '2014-03-25', 'a3a75040-b3ce-4a12-9868-db31bca24ef5', 'Everything is Illuminated');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (101, 'This is a description of Book Terrible Swift Sword', 15, '/assets/img/content/main/card2.jpg', false, 3606.0212937843526, '2015-09-08', '2eb44f62-f83c-4646-8625-99056ace23a9', 'Terrible Swift Sword');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (102, 'This is a description of Book The Moon by Night', 44, '/assets/img/content/main/card2.jpg', true, 2811.87576974402, '2018-03-24', '4817aa09-8679-45f5-85d0-0cbf108658a5', 'The Moon by Night');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (103, 'This is a description of Book Pale Kings and Princes', 28, '/assets/img/content/main/card2.jpg', false, 1721.8459189637624, '2014-02-18', '9fe48436-fb0f-45a4-bacd-0289bbbea135', 'Pale Kings and Princes');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (104, 'This is a description of Book Time of our Darkness', 35, '/assets/img/content/main/card2.jpg', false, 1565.749876908192, '2023-02-02', 'fb602546-1c26-4161-bc6a-7b1a3f87f286', 'Time of our Darkness');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (105, 'This is a description of Book It''s a Battlefield', 21, '/assets/img/content/main/card2.jpg', true, 2802.9337663576844, '2015-02-05', 'fde4d70b-edcb-42eb-86f6-efe02cb7d7cc', 'It''s a Battlefield');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (106, 'This is a description of Book The Mermaids Singing', 0, '/assets/img/content/main/card2.jpg', false, 3896.7547092035766, '2013-06-11', '025b14cb-edbc-44f9-a703-662f9689f51c', 'The Mermaids Singing');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (107, 'This is a description of Book Sleep the Brave', 39, '/assets/img/content/main/card2.jpg', true, 3716.521223667953, '2017-05-07', '63c6026f-21c8-403d-814f-e24db848c869', 'Sleep the Brave');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (108, 'This is a description of Book Beyond the Mexique Bay', 2, '/assets/img/content/main/card2.jpg', false, 3990.3772455126204, '2018-05-19', '7ea47c33-3461-4608-903a-b4dd4a616260', 'Beyond the Mexique Bay');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (109, 'This is a description of Book The Line of Beauty', 41, '/assets/img/content/main/card2.jpg', true, 339.57622712246456, '2021-08-28', '451d9ebb-d8fe-4059-be39-239bf228bc40', 'The Line of Beauty');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (110, 'This is a description of Book The Stars'' Tennis Balls', 33, '/assets/img/content/main/card2.jpg', false, 4481.967703493331, '2018-10-25', '482aee66-7348-412d-8c6f-4f605fc87c02', 'The Stars'' Tennis Balls');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (111, 'This is a description of Book Absalom, Absalom!', 6, '/assets/img/content/main/card2.jpg', false, 647.0175719010457, '2022-04-13', '37544d62-c421-4ccc-8954-b42fadf02333', 'Absalom, Absalom!');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (112, 'This is a description of Book To Say Nothing of the Dog', 49, '/assets/img/content/main/card2.jpg', false, 3661.591014425932, '2018-01-01', '3c731899-f467-4820-9c5d-887d1113e06e', 'To Say Nothing of the Dog');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (113, 'This is a description of Book Arms and the Man', 1, '/assets/img/content/main/card2.jpg', false, 619.3878949001443, '2022-03-30', '98ff2157-1877-4520-80b2-67b816edd624', 'Arms and the Man');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (114, 'This is a description of Book Ah, Wilderness!', 14, '/assets/img/content/main/card2.jpg', false, 1251.503893180401, '2015-09-26', 'a8190d83-038f-4fec-bdb3-ab8af254df2d', 'Ah, Wilderness!');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (115, 'This is a description of Book A Swiftly Tilting Planet', 16, '/assets/img/content/main/card2.jpg', false, 3677.8508906516154, '2017-10-05', '6554c710-e410-43ff-b1ef-524058748b91', 'A Swiftly Tilting Planet');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (116, 'This is a description of Book Pale Kings and Princes', 6, '/assets/img/content/main/card2.jpg', false, 1033.2509762875213, '2015-08-31', 'ab015cfc-415e-4b5f-afb6-afd56386721a', 'Pale Kings and Princes');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (117, 'This is a description of Book The Daffodil Sky', 8, '/assets/img/content/main/card2.jpg', false, 584.9466348924182, '2018-10-26', '8da71619-6510-4974-951f-4c8fad5e0b3f', 'The Daffodil Sky');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (118, 'This is a description of Book To Sail Beyond the Sunset', 32, '/assets/img/content/main/card2.jpg', false, 3221.6256254293276, '2019-07-30', '0ab6b9e4-5e2f-4e4c-9b27-4b9fefde3ebb', 'To Sail Beyond the Sunset');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (119, 'This is a description of Book Dying of the Light', 9, '/assets/img/content/main/card2.jpg', true, 3980.4068282470316, '2018-11-29', 'dba49090-10d6-4a3b-8ebb-a38936223d5e', 'Dying of the Light');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (120, 'This is a description of Book Far From the Madding Crowd', 3, '/assets/img/content/main/card2.jpg', false, 545.2357337812615, '2021-06-22', '0791103c-f6c7-42cb-81cd-1013ab70449e', 'Far From the Madding Crowd');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (121, 'This is a description of Book Some Buried Caesar', 0, '/assets/img/content/main/card2.jpg', true, 2462.87640892049, '2019-09-29', 'd85901fe-0264-40c8-af34-01b571495362', 'Some Buried Caesar');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (122, 'This is a description of Book The Doors of Perception', 4, '/assets/img/content/main/card2.jpg', true, 4769.547734258577, '2016-06-24', '4223a990-93dc-44f1-8289-71ed76170ffe', 'The Doors of Perception');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (123, 'This is a description of Book Wildfire at Midnight', 17, '/assets/img/content/main/card2.jpg', true, 4340.840760803578, '2014-03-29', '70e744b9-96c1-4141-82c9-ff921e4bdcbc', 'Wildfire at Midnight');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (124, 'This is a description of Book A Passage to India', 41, '/assets/img/content/main/card2.jpg', false, 3857.432876278848, '2023-02-13', '7f6765a8-374e-444e-aae9-e8594d57ab2e', 'A Passage to India');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (125, 'This is a description of Book Nectar in a Sieve', 40, '/assets/img/content/main/card2.jpg', true, 2433.759483819874, '2014-07-25', '20343f2a-9c87-4fb4-9a28-804e808fef49', 'Nectar in a Sieve');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (126, 'This is a description of Book In Dubious Battle', 37, '/assets/img/content/main/card2.jpg', false, 1322.022968716825, '2016-12-11', 'dcccfdb4-2c1a-4c38-9f79-6b489dc08feb', 'In Dubious Battle');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (127, 'This is a description of Book No Highway', 33, '/assets/img/content/main/card2.jpg', true, 1150.0585912170966, '2022-08-10', '7db3534e-3435-4b3c-b522-d167e05e95e5', 'No Highway');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (128, 'This is a description of Book O Jerusalem!', 50, '/assets/img/content/main/card2.jpg', true, 2172.1968125489357, '2017-06-29', 'c0dabfab-e4de-4688-af7c-14363ba15f26', 'O Jerusalem!');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (129, 'This is a description of Book Where Angels Fear to Tread', 24, '/assets/img/content/main/card2.jpg', true, 1809.5426248390447, '2018-05-17', 'd74f802d-5e79-4741-9f38-77b8697fb16b', 'Where Angels Fear to Tread');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (130, 'This is a description of Book The Monkey''s Raincoat', 43, '/assets/img/content/main/card2.jpg', true, 4381.096478029813, '2013-12-21', 'c3ace09d-7419-413a-a278-c8318fd03954', 'The Monkey''s Raincoat');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (131, 'This is a description of Book Brandy of the Damned', 12, '/assets/img/content/main/card2.jpg', false, 4294.125477926155, '2020-01-04', 'c73bba83-182b-4af1-8c9a-41e202c7c364', 'Brandy of the Damned');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (132, 'This is a description of Book The Stars'' Tennis Balls', 21, '/assets/img/content/main/card2.jpg', false, 3936.5317975958824, '2021-03-07', 'f749e7d4-d9d2-4b02-9480-0cbe86a9d4f4', 'The Stars'' Tennis Balls');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (133, 'This is a description of Book Dance Dance Dance', 5, '/assets/img/content/main/card2.jpg', true, 3756.822009419663, '2022-10-20', '7f131408-56cd-425a-aefa-76854f305ed1', 'Dance Dance Dance');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (134, 'This is a description of Book The Lathe of Heaven', 5, '/assets/img/content/main/card2.jpg', false, 2961.0237077566635, '2021-04-05', '4bbdaee4-f364-4199-b4d1-96adfbd8a08c', 'The Lathe of Heaven');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (135, 'This is a description of Book This Side of Paradise', 40, '/assets/img/content/main/card2.jpg', false, 522.329513870826, '2015-07-25', '1c16865f-f3c6-41dc-9df4-5ee0fbc43318', 'This Side of Paradise');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (136, 'This is a description of Book In Death Ground', 36, '/assets/img/content/main/card2.jpg', false, 3253.0985115149124, '2022-07-09', '7ccfb7e6-c4ce-421c-afd2-45878b21797e', 'In Death Ground');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (137, 'This is a description of Book The Widening Gyre', 4, '/assets/img/content/main/card2.jpg', true, 864.5058541753705, '2022-09-24', 'd469a0dd-4ff6-4b12-be66-35b838015bd5', 'The Widening Gyre');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (138, 'This is a description of Book A Handful of Dust', 20, '/assets/img/content/main/card2.jpg', true, 3960.5462568631688, '2016-10-03', '5f2db805-fcf7-4fba-a05b-28bde52f3c80', 'A Handful of Dust');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (139, 'This is a description of Book Down to a Sunless Sea', 25, '/assets/img/content/main/card2.jpg', false, 4042.726008655426, '2014-09-18', 'cd17bcd0-dbe8-476d-8ea1-cb8e45c64ca3', 'Down to a Sunless Sea');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (140, 'This is a description of Book Beyond the Mexique Bay', 33, '/assets/img/content/main/card2.jpg', true, 1558.952118976408, '2016-03-23', '77b69bb5-a22e-477b-b6a2-1b7ba30fa425', 'Beyond the Mexique Bay');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (141, 'This is a description of Book The Moving Toyshop', 4, '/assets/img/content/main/card2.jpg', true, 2678.6867557254573, '2015-03-10', '27a531c9-cc9f-44e0-86bc-7ae6b3a6caa4', 'The Moving Toyshop');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (142, 'This is a description of Book No Country for Old Men', 46, '/assets/img/content/main/card2.jpg', true, 4220.3891901037505, '2014-07-16', '31aa30b9-f300-46ad-b0b4-3f2a02fce94d', 'No Country for Old Men');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (143, 'This is a description of Book That Hideous Strength', 7, '/assets/img/content/main/card2.jpg', false, 1639.305409841821, '2017-05-11', '574570e5-3e79-493a-8dd2-fbe007d9f9f1', 'That Hideous Strength');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (144, 'This is a description of Book The Daffodil Sky', 49, '/assets/img/content/main/card2.jpg', true, 1616.6980581503622, '2022-01-05', '9a415652-80f6-457e-ae55-3db514dbce36', 'The Daffodil Sky');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (145, 'This is a description of Book A Time of Gifts', 17, '/assets/img/content/main/card2.jpg', true, 3881.1075040703704, '2014-11-28', 'a55bb6fa-d9d3-4599-bf2b-caa25f2b6db3', 'A Time of Gifts');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (146, 'This is a description of Book Great Work of Time', 38, '/assets/img/content/main/card2.jpg', true, 3339.9809963776042, '2020-01-27', '38fb4931-f618-4ff5-aae8-796ba9542fc8', 'Great Work of Time');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (147, 'This is a description of Book Many Waters', 15, '/assets/img/content/main/card2.jpg', false, 1484.9640319996781, '2022-09-28', '2dba08c8-81a5-48dd-a90c-805b5cc38534', 'Many Waters');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (148, 'This is a description of Book Mother Night', 31, '/assets/img/content/main/card2.jpg', false, 647.49887799976, '2014-12-17', 'a06875f1-dd46-4fc9-a9f2-6b6b0a147370', 'Mother Night');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (149, 'This is a description of Book Infinite Jest', 50, '/assets/img/content/main/card2.jpg', true, 229.3746348518547, '2022-01-07', '9b7fe0fd-a334-487c-8a67-21355281db0d', 'Infinite Jest');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (150, 'This is a description of Book Taming a Sea Horse', 20, '/assets/img/content/main/card2.jpg', true, 1915.0038282413016, '2017-07-09', '198eef27-4e44-45a0-89ef-3ff5cd51e8ab', 'Taming a Sea Horse');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (151, 'This is a description of Book Tiger! Tiger!', 10, '/assets/img/content/main/card2.jpg', true, 2104.2116451728566, '2021-05-26', '1e930b4e-1bae-4aa1-a6cd-0d2f0a8c3a18', 'Tiger! Tiger!');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (152, 'This is a description of Book Great Work of Time', 3, '/assets/img/content/main/card2.jpg', false, 244.08126346020936, '2017-07-27', '8570e573-c825-4918-b27e-6f67ee25795f', 'Great Work of Time');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (153, 'This is a description of Book A Catskill Eagle', 17, '/assets/img/content/main/card2.jpg', true, 1562.0632445089093, '2017-01-22', 'e6fac8ab-dfe4-44c3-a001-87e35491c10d', 'A Catskill Eagle');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (154, 'This is a description of Book Taming a Sea Horse', 13, '/assets/img/content/main/card2.jpg', true, 1631.4568535002713, '2020-08-19', '6284f1d6-e48d-479a-a030-9a878f6630ab', 'Taming a Sea Horse');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (155, 'This is a description of Book Everything is Illuminated', 34, '/assets/img/content/main/card2.jpg', false, 4082.023606877859, '2018-01-30', 'd7a105f2-132e-4e49-9bc3-b2159075e051', 'Everything is Illuminated');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (156, 'This is a description of Book The Line of Beauty', 46, '/assets/img/content/main/card2.jpg', true, 4554.576958322486, '2021-04-27', '73546b01-6754-4837-842b-acf25c9ecafd', 'The Line of Beauty');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (157, 'This is a description of Book Clouds of Witness', 9, '/assets/img/content/main/card2.jpg', false, 3759.064600513449, '2022-08-16', '74d76eba-6df3-4062-bd62-a15e52ad334f', 'Clouds of Witness');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (158, 'This is a description of Book Fame Is the Spur', 42, '/assets/img/content/main/card2.jpg', true, 4361.459495036419, '2015-06-28', 'b8cde91d-c682-4c26-9a9f-4b81751987b2', 'Fame Is the Spur');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (159, 'This is a description of Book This Side of Paradise', 24, '/assets/img/content/main/card2.jpg', false, 2189.437604912502, '2014-11-04', 'fa23ade6-781b-4e14-bc64-0b46ac29b617', 'This Side of Paradise');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (160, 'This is a description of Book The Doors of Perception', 11, '/assets/img/content/main/card2.jpg', true, 3549.6846155852463, '2021-11-05', '9d08123c-4e49-4c03-a03c-dde9fc6d5008', 'The Doors of Perception');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (161, 'This is a description of Book Paths of Glory', 33, '/assets/img/content/main/card2.jpg', true, 184.9548363395769, '2019-12-01', '36747188-5e38-4083-87cb-367802fbb516', 'Paths of Glory');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (162, 'This is a description of Book Recalled to Life', 37, '/assets/img/content/main/card2.jpg', false, 2311.034030146212, '2019-08-26', '0e46565c-91b0-490c-9978-193b55769d49', 'Recalled to Life');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (163, 'This is a description of Book The Far-Distant Oxus', 0, '/assets/img/content/main/card2.jpg', true, 954.4062110626702, '2014-02-17', 'd67225cc-38de-458c-bfb6-7823b9a1f3e6', 'The Far-Distant Oxus');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (164, 'This is a description of Book Let Us Now Praise Famous Men', 38, '/assets/img/content/main/card2.jpg', true, 3242.261675868858, '2021-09-24', '097c4dbc-9ee6-4a04-b802-f35104c3d9c6', 'Let Us Now Praise Famous Men');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (165, 'This is a description of Book Those Barren Leaves, Thrones, Dominations', 38, '/assets/img/content/main/card2.jpg', true, 3593.8085288990155, '2020-04-25', '7c36765d-39d6-4d26-9052-28d02180c9e8', 'Those Barren Leaves, Thrones, Dominations');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (166, 'This is a description of Book Postern of Fate', 31, '/assets/img/content/main/card2.jpg', true, 3615.588466452565, '2018-10-02', '331b5eeb-210a-42a9-9a49-ccb2eec398e2', 'Postern of Fate');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (167, 'This is a description of Book Of Human Bondage', 34, '/assets/img/content/main/card2.jpg', false, 3433.0463279989344, '2017-12-31', '8a56d96d-a1eb-45a1-82f4-38a7aadc2e80', 'Of Human Bondage');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (168, 'This is a description of Book That Hideous Strength', 10, '/assets/img/content/main/card2.jpg', false, 323.04619444955927, '2017-05-26', '7a9df2e6-ef95-4e4a-bdda-88d114e7bd72', 'That Hideous Strength');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (169, 'This is a description of Book The Wives of Bath', 1, '/assets/img/content/main/card2.jpg', true, 1497.7452136257084, '2020-08-22', 'c5e41d67-66b6-4277-b6ea-dbb67d2c97f7', 'The Wives of Bath');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (170, 'This is a description of Book Dance Dance Dance', 17, '/assets/img/content/main/card2.jpg', false, 755.7708060521444, '2018-04-28', '7f0b2453-4293-48d7-969b-595b84ef2ac5', 'Dance Dance Dance');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (171, 'This is a description of Book Butter In a Lordly Dish', 27, '/assets/img/content/main/card2.jpg', true, 1913.775245592346, '2021-11-30', 'df8813f5-2cb0-4e6a-b410-7ed8fb64826a', 'Butter In a Lordly Dish');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (172, 'This is a description of Book The Way of All Flesh', 21, '/assets/img/content/main/card2.jpg', true, 4128.768107763215, '2019-06-15', 'c7a83d61-b131-455a-abf2-59b83390c458', 'The Way of All Flesh');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (173, 'This is a description of Book To a God Unknown', 36, '/assets/img/content/main/card2.jpg', true, 2665.5799008689187, '2013-05-03', 'e5eae779-4efd-416e-a16d-3f29f80ab637', 'To a God Unknown');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (174, 'This is a description of Book Beyond the Mexique Bay', 37, '/assets/img/content/main/card2.jpg', false, 1318.7847555303433, '2017-10-29', 'a1769c4a-b131-49bb-b46e-f70a6070e7d8', 'Beyond the Mexique Bay');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (175, 'This is a description of Book Oh! To be in England', 44, '/assets/img/content/main/card2.jpg', true, 4396.890404437225, '2017-06-15', 'a672eaf5-4ef0-417d-809c-5f77e6405ac0', 'Oh! To be in England');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (176, 'This is a description of Book If I Forget Thee Jerusalem', 5, '/assets/img/content/main/card2.jpg', true, 4519.437750914269, '2014-09-27', 'ecd338d9-e65c-4a33-b281-170a07480f09', 'If I Forget Thee Jerusalem');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (177, 'This is a description of Book Oh! To be in England', 24, '/assets/img/content/main/card2.jpg', true, 1819.2504141039065, '2017-01-20', '3e6d5849-a8dc-4053-9e3a-8fe9ef2c0b2c', 'Oh! To be in England');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (178, 'This is a description of Book Surprised by Joy', 16, '/assets/img/content/main/card2.jpg', false, 2886.144634613716, '2013-07-01', '4d4ca330-f4d9-4f8d-b6c2-6550a4b28b01', 'Surprised by Joy');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (179, 'This is a description of Book Surprised by Joy', 3, '/assets/img/content/main/card2.jpg', true, 837.9360981973302, '2016-05-12', '2da677bf-8384-4630-8835-0f8c78cbac68', 'Surprised by Joy');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (180, 'This is a description of Book Beyond the Mexique Bay', 6, '/assets/img/content/main/card2.jpg', false, 326.096507541474, '2019-03-07', '9f288605-9119-4932-a685-5d4179f63b2f', 'Beyond the Mexique Bay');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (181, 'This is a description of Book Ah, Wilderness!', 23, '/assets/img/content/main/card2.jpg', false, 2755.21487929856, '2022-09-20', 'fe0611a1-b459-42f5-9c6b-ac215746008e', 'Ah, Wilderness!');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (182, 'This is a description of Book If Not Now, When?', 1, '/assets/img/content/main/card2.jpg', false, 4385.2036810258605, '2018-09-11', 'c30bdafb-afcb-4ac9-abb1-563d90884ce6', 'If Not Now, When?');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (183, 'This is a description of Book Françoise Sagan', 39, '/assets/img/content/main/card2.jpg', false, 4762.7052285119, '2017-08-01', '559fbca5-411b-4411-9172-e73f9d003e1e', 'Françoise Sagan');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (184, 'This is a description of Book A Scanner Darkly', 30, '/assets/img/content/main/card2.jpg', true, 1948.7802941258203, '2018-01-23', '853feb1f-3c0c-4f25-9ccc-710f57a5241b', 'A Scanner Darkly');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (185, 'This is a description of Book It''s a Battlefield', 48, '/assets/img/content/main/card2.jpg', false, 3066.7519517088604, '2019-02-08', '9e199513-56f5-4433-a887-ec76e2a943d4', 'It''s a Battlefield');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (186, 'This is a description of Book When the Green Woods Laugh', 14, '/assets/img/content/main/card2.jpg', true, 3376.6151454749893, '2019-12-02', 'e47a49a4-28fe-4629-b3af-623d84430a8d', 'When the Green Woods Laugh');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (187, 'This is a description of Book I Sing the Body Electric', 22, '/assets/img/content/main/card2.jpg', true, 307.9478595302081, '2021-02-23', '6150b193-a5fe-49ab-97c1-b585eb62c7f9', 'I Sing the Body Electric');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (188, 'This is a description of Book The Monkey''s Raincoat', 1, '/assets/img/content/main/card2.jpg', false, 1188.8811507640833, '2018-05-12', 'ef0a673f-fc82-4339-b828-1745ebc2e996', 'The Monkey''s Raincoat');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (189, 'This is a description of Book A Many-Splendoured Thing', 33, '/assets/img/content/main/card2.jpg', true, 382.0543749473705, '2014-10-09', '5d59b12e-a3ad-44ab-a39f-8be03a5286f7', 'A Many-Splendoured Thing');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (190, 'This is a description of Book This Side of Paradise', 30, '/assets/img/content/main/card2.jpg', false, 2831.1795148298597, '2018-02-22', '4f0834e2-28de-44db-ab44-c5f186b6ad01', 'This Side of Paradise');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (191, 'This is a description of Book Bury My Heart at Wounded Knee', 42, '/assets/img/content/main/card2.jpg', true, 3185.800701526969, '2021-02-08', '212654a0-5535-44c4-b7da-f892fb11ed01', 'Bury My Heart at Wounded Knee');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (192, 'This is a description of Book Absalom, Absalom!', 17, '/assets/img/content/main/card2.jpg', true, 4203.495531108423, '2021-04-30', 'ecd97d80-9f82-409a-a455-c31ecfb5d7fb', 'Absalom, Absalom!');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (193, 'This is a description of Book The Glory and the Dream', 12, '/assets/img/content/main/card2.jpg', true, 3276.183224396819, '2019-04-01', 'c23477e8-8ca4-4416-95cb-be7ffe0cff11', 'The Glory and the Dream');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (194, 'This is a description of Book The Wings of the Dove', 45, '/assets/img/content/main/card2.jpg', true, 3476.293897697175, '2017-10-12', '5d8760ca-0aad-4629-81da-03a17af588b6', 'The Wings of the Dove');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (195, 'This is a description of Book For a Breath I Tarry', 9, '/assets/img/content/main/card2.jpg', false, 4153.6127860803845, '2018-05-11', 'af5a11b1-c08c-43bf-97ea-179b003beb58', 'For a Breath I Tarry');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (196, 'This is a description of Book Postern of Fate', 10, '/assets/img/content/main/card2.jpg', true, 4502.7199542920835, '2014-10-26', '358c6791-18f4-4d84-903e-b79ff79a4ddd', 'Postern of Fate');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (197, 'This is a description of Book The Little Foxes', 21, '/assets/img/content/main/card2.jpg', true, 4679.345695056152, '2016-05-24', 'c3949c04-0f95-4753-a45e-55497ecb124a', 'The Little Foxes');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (198, 'This is a description of Book Surprised by Joy', 29, '/assets/img/content/main/card2.jpg', true, 5004.451051683552, '2023-01-15', '727b5d98-de63-45d9-bc64-619dac30aec1', 'Surprised by Joy');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (199, 'This is a description of Book Tirra Lirra by the River', 36, '/assets/img/content/main/card2.jpg', true, 1631.2224782100968, '2022-12-13', 'd818f7d3-88e5-49fb-8edd-eacc83ed5876', 'Tirra Lirra by the River');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (200, 'This is a description of Book Paths of Glory', 10, '/assets/img/content/main/card2.jpg', false, 693.1955018641988, '2020-04-26', 'dbd06159-7a6a-472c-93f5-1f5c9cfdf70d', 'Paths of Glory');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (201, 'This is a description of Book Beneath the Bleeding', 23, '/assets/img/content/main/card2.jpg', false, 231.57355184491107, '2021-08-04', '1a8dfe5e-ea83-4757-808e-3f85236a9a11', 'Beneath the Bleeding');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (202, 'This is a description of Book That Good Night', 36, '/assets/img/content/main/card2.jpg', false, 506.93572686051186, '2018-10-31', '6092ff10-8766-478b-9fb3-212fba1bf189', 'That Good Night');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (203, 'This is a description of Book Arms and the Man', 16, '/assets/img/content/main/card2.jpg', true, 3707.839603315998, '2018-08-22', '75e6ba33-715e-4b80-afdf-904665adec35', 'Arms and the Man');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (204, 'This is a description of Book Unweaving the Rainbow', 41, '/assets/img/content/main/card2.jpg', false, 3131.5122134453886, '2022-12-03', 'ce400eb5-f31a-45a2-aa3a-01a55a890f76', 'Unweaving the Rainbow');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (205, 'This is a description of Book A Time of Gifts', 46, '/assets/img/content/main/card2.jpg', false, 2820.712368104422, '2017-05-31', '27537c1a-8d13-41eb-95be-542f7072bc5c', 'A Time of Gifts');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (206, 'This is a description of Book Butter In a Lordly Dish', 20, '/assets/img/content/main/card2.jpg', true, 3368.034945038659, '2017-09-15', 'b87f88ef-29ea-40d8-810c-e7627e307c03', 'Butter In a Lordly Dish');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (207, 'This is a description of Book Edna O''Brien', 42, '/assets/img/content/main/card2.jpg', false, 3152.5038501166496, '2014-03-01', 'c512b561-d890-4954-9a94-152b19d2b9e6', 'Edna O''Brien');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (208, 'This is a description of Book Look to Windward', 11, '/assets/img/content/main/card2.jpg', true, 4492.362754440408, '2022-06-17', 'c89fd91d-84e5-406c-a41a-736b9cf71348', 'Look to Windward');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (209, 'This is a description of Book Surprised by Joy', 9, '/assets/img/content/main/card2.jpg', false, 2153.6834358190795, '2020-06-04', '4b801e79-279f-47ba-ae82-51ea14741759', 'Surprised by Joy');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (210, 'This is a description of Book Cover Her Face', 1, '/assets/img/content/main/card2.jpg', false, 1716.716530589393, '2016-02-08', '2fa20608-a093-401a-ab87-82aa135a726e', 'Cover Her Face');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (211, 'This is a description of Book Jacob Have I Loved', 2, '/assets/img/content/main/card2.jpg', false, 2712.6267429420163, '2018-01-16', '31bf80c4-54b8-4433-b056-a8e41b3643d9', 'Jacob Have I Loved');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (212, 'This is a description of Book Blue Remembered Earth', 43, '/assets/img/content/main/card2.jpg', false, 4998.5818005210485, '2014-10-28', '6398be60-8061-4e67-9978-bafb09f4be6b', 'Blue Remembered Earth');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (213, 'This is a description of Book Eyeless in Gaza', 18, '/assets/img/content/main/card2.jpg', false, 4986.250738699598, '2019-08-25', 'f02e08d0-864e-475b-84e1-103ac6acceb5', 'Eyeless in Gaza');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (214, 'This is a description of Book That Hideous Strength', 14, '/assets/img/content/main/card2.jpg', true, 3477.8366527042645, '2022-09-15', '7cd9f0ff-aab3-4881-8716-a231a414b195', 'That Hideous Strength');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (215, 'This is a description of Book In a Glass Darkly', 13, '/assets/img/content/main/card2.jpg', false, 3771.3793601777484, '2022-06-03', '0a7308ad-74aa-4ad5-8ba5-7a87394b10a2', 'In a Glass Darkly');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (216, 'This is a description of Book The Wings of the Dove', 46, '/assets/img/content/main/card2.jpg', true, 641.4234027877413, '2013-03-27', 'cd91741b-e1d5-48fd-a49f-b5718c8743fa', 'The Wings of the Dove');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (217, 'This is a description of Book Terrible Swift Sword', 35, '/assets/img/content/main/card2.jpg', false, 4558.014637780378, '2013-03-31', '737f529b-8b06-4c84-9db3-60dc1dbb837b', 'Terrible Swift Sword');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (218, 'This is a description of Book Beneath the Bleeding', 20, '/assets/img/content/main/card2.jpg', true, 1508.5123354448672, '2015-03-21', 'b31901e7-850f-405c-afe7-62b905771907', 'Beneath the Bleeding');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (219, 'This is a description of Book The Glory and the Dream', 34, '/assets/img/content/main/card2.jpg', false, 4982.661608047963, '2019-05-22', '1d2a5f28-5696-4394-a81d-82a848fd4763', 'The Glory and the Dream');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (220, 'This is a description of Book Butter In a Lordly Dish', 15, '/assets/img/content/main/card2.jpg', false, 4536.613168436091, '2015-09-06', '1fa726f5-9cd8-4f48-8885-85849918b2dc', 'Butter In a Lordly Dish');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (221, 'This is a description of Book Waiting for the Barbarians', 35, '/assets/img/content/main/card2.jpg', false, 438.06192599242365, '2018-11-19', 'a2cb88a6-cb23-40f6-8e07-6b8c5a0e8b2e', 'Waiting for the Barbarians');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (222, 'This is a description of Book Ah, Wilderness!', 31, '/assets/img/content/main/card2.jpg', false, 4228.338836209932, '2017-09-18', '73e4e1f4-f3b9-4151-9f3f-214e80512f14', 'Ah, Wilderness!');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (223, 'This is a description of Book I Will Fear No Evil', 29, '/assets/img/content/main/card2.jpg', true, 4916.0812418547175, '2022-09-15', '5dd6d52e-013c-4b69-875a-a9690073f19e', 'I Will Fear No Evil');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (224, 'This is a description of Book The Curious Incident of the Dog in the Night-Time', 3, '/assets/img/content/main/card2.jpg', false, 3094.8654121745103, '2016-08-01', '06a9ab51-070e-42b0-b4fd-e779e5fd9f19', 'The Curious Incident of the Dog in the Night-Time');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (225, 'This is a description of Book If Not Now, When?', 11, '/assets/img/content/main/card2.jpg', true, 700.6286669321765, '2019-12-13', '2486c8f6-fef7-421f-b427-b47b5884eb40', 'If Not Now, When?');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (226, 'This is a description of Book A Monstrous Regiment of Women', 22, '/assets/img/content/main/card2.jpg', false, 187.64448953305427, '2014-06-12', 'f87f4bbc-eab9-43ef-92a0-d5a31cd05d71', 'A Monstrous Regiment of Women');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (227, 'This is a description of Book In a Glass Darkly', 30, '/assets/img/content/main/card2.jpg', false, 2681.781959743655, '2018-07-22', 'bd0a575e-c844-45ca-bcda-d2337f6d65c9', 'In a Glass Darkly');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (228, 'This is a description of Book In a Glass Darkly', 15, '/assets/img/content/main/card2.jpg', false, 1450.6775033676079, '2021-02-10', '6582c7de-8a09-4161-a859-3abb6259e03a', 'In a Glass Darkly');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (229, 'This is a description of Book The Daffodil Sky', 50, '/assets/img/content/main/card2.jpg', false, 1094.2777399853594, '2016-01-03', '29221ab6-77a2-4310-a1be-0a7b6087334b', 'The Daffodil Sky');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (230, 'This is a description of Book Such, Such Were the Joys', 15, '/assets/img/content/main/card2.jpg', true, 4784.957057505347, '2021-02-28', '8f9785c9-31a7-4387-900a-32cd66d3aa98', 'Such, Such Were the Joys');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (231, 'This is a description of Book For a Breath I Tarry', 22, '/assets/img/content/main/card2.jpg', false, 682.0897767087838, '2020-11-15', 'f3e56336-a663-4a8c-b357-5da0590e9ca5', 'For a Breath I Tarry');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (232, 'This is a description of Book Recalled to Life', 9, '/assets/img/content/main/card2.jpg', false, 2245.3044550030822, '2017-09-24', '1f1c200d-eaf9-4f3a-b3d7-4959f449d7f6', 'Recalled to Life');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (233, 'This is a description of Book Ego Dominus Tuus', 30, '/assets/img/content/main/card2.jpg', true, 409.45727276393905, '2016-06-24', 'a5857f4f-d07b-4545-b01d-ec2c8f9a4781', 'Ego Dominus Tuus');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (234, 'This is a description of Book A Time to Kill', 39, '/assets/img/content/main/card2.jpg', false, 355.305824242981, '2013-08-16', '0e75ec6f-ba4c-46fd-a9ec-5f8a42b30e97', 'A Time to Kill');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (235, 'This is a description of Book Alone on a Wide, Wide Sea', 48, '/assets/img/content/main/card2.jpg', true, 2231.795519227758, '2014-01-31', '071b748a-e78d-425a-a061-82323b55059d', 'Alone on a Wide, Wide Sea');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (236, 'This is a description of Book Tirra Lirra by the River', 0, '/assets/img/content/main/card2.jpg', true, 2167.8763699982096, '2023-03-08', '2bc7008e-83af-4203-a4c8-efa1b389ed39', 'Tirra Lirra by the River');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (237, 'This is a description of Book Moab Is My Washpot', 49, '/assets/img/content/main/card2.jpg', false, 991.8891486887429, '2015-05-24', '00e35150-002f-472f-876a-8f1583e52698', 'Moab Is My Washpot');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (238, 'This is a description of Book Waiting for the Barbarians', 22, '/assets/img/content/main/card2.jpg', false, 1201.9026166204505, '2015-09-15', '1b55f635-0a98-4edd-a317-b727da1419e1', 'Waiting for the Barbarians');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (239, 'This is a description of Book In Dubious Battle', 29, '/assets/img/content/main/card2.jpg', false, 474.45866428799445, '2018-07-25', 'ff723fd0-c051-4ddb-a761-290f70cbca47', 'In Dubious Battle');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (240, 'This is a description of Book Let Us Now Praise Famous Men', 5, '/assets/img/content/main/card2.jpg', false, 790.6496814581141, '2017-06-04', '9ca70368-da22-4afe-8f4e-bd458b60a243', 'Let Us Now Praise Famous Men');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (241, 'This is a description of Book The House of Mirth', 22, '/assets/img/content/main/card2.jpg', true, 2266.038535748595, '2022-06-14', '8a1c6863-5c8f-42ac-8905-e92fa82a5b1b', 'The House of Mirth');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (242, 'This is a description of Book I Sing the Body Electric', 3, '/assets/img/content/main/card2.jpg', true, 2405.132628963196, '2020-08-08', '6d7d2709-ee29-40eb-9474-8816f9561d86', 'I Sing the Body Electric');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (243, 'This is a description of Book This Side of Paradise', 13, '/assets/img/content/main/card2.jpg', true, 222.40387876088667, '2016-03-07', '5e678e46-4c72-41d6-8a4e-1a17fe7175e7', 'This Side of Paradise');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (244, 'This is a description of Book As I Lay Dying', 44, '/assets/img/content/main/card2.jpg', false, 135.38019329166545, '2017-09-10', 'ddfe57e5-38db-4511-a05c-3a4bb68bae82', 'As I Lay Dying');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (245, 'This is a description of Book Of Human Bondage', 25, '/assets/img/content/main/card2.jpg', false, 4992.935890692615, '2013-09-27', '4fe7ff4f-5755-4a8c-bd3f-2cb8e216602c', 'Of Human Bondage');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (246, 'This is a description of Book Little Hands Clapping', 33, '/assets/img/content/main/card2.jpg', true, 4569.642374554548, '2017-12-19', '9649ff31-7e1c-4d62-98c6-4ca877b3cbe3', 'Little Hands Clapping');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (247, 'This is a description of Book I Will Fear No Evil', 46, '/assets/img/content/main/card2.jpg', true, 1777.086497953954, '2019-07-08', '832a7226-e219-4f65-87a6-49948631bad1', 'I Will Fear No Evil');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (248, 'This is a description of Book Endless Night', 45, '/assets/img/content/main/card2.jpg', false, 475.77174824271157, '2016-12-06', '53ac39fb-5cde-4f39-821d-97dd6d610e37', 'Endless Night');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (249, 'This is a description of Book Nine Coaches Waiting', 20, '/assets/img/content/main/card2.jpg', false, 4534.86214982449, '2016-11-15', 'a65cf01c-75a3-4603-8cf5-867fd92be875', 'Nine Coaches Waiting');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (250, 'This is a description of Book If Not Now, When?', 38, '/assets/img/content/main/card2.jpg', true, 299.63728264515385, '2014-05-13', '06d46805-f3b8-4683-b111-5d19d7e07191', 'If Not Now, When?');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (251, 'This is a description of Book Arms and the Man', 4, '/assets/img/content/main/card2.jpg', false, 3163.226815719021, '2020-06-28', '7845befd-7e5f-4325-8871-ea73036e52c9', 'Arms and the Man');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (252, 'This is a description of Book Dulce et Decorum Est', 46, '/assets/img/content/main/card2.jpg', false, 156.88892032491006, '2018-04-14', '45f19d00-44d3-4f68-a703-f613d2662a20', 'Dulce et Decorum Est');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (253, 'This is a description of Book Have His Carcase', 22, '/assets/img/content/main/card2.jpg', true, 861.8658262207855, '2017-12-04', '80719c46-303d-4420-b985-20893b07ba79', 'Have His Carcase');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (254, 'This is a description of Book For Whom the Bell Tolls', 10, '/assets/img/content/main/card2.jpg', true, 4169.2954042658275, '2016-11-13', '851b2c6e-e6ea-4305-b540-1a690757a060', 'For Whom the Bell Tolls');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (255, 'This is a description of Book Cabbages and Kings', 48, '/assets/img/content/main/card2.jpg', true, 2205.5554402597722, '2022-01-06', 'ada59b24-9f16-49b0-8278-399f3da4e36b', 'Cabbages and Kings');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (256, 'This is a description of Book Pale Kings and Princes', 47, '/assets/img/content/main/card2.jpg', false, 2127.325449511699, '2020-04-24', '623a9226-760e-4021-91e2-170241206ce7', 'Pale Kings and Princes');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (257, 'This is a description of Book Specimen Days', 33, '/assets/img/content/main/card2.jpg', true, 520.7574906244196, '2013-07-29', 'b38dfbac-070d-48af-b5eb-efe9f14ce6fd', 'Specimen Days');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (258, 'This is a description of Book Fear and Trembling', 43, '/assets/img/content/main/card2.jpg', false, 4838.466385742346, '2017-08-09', '4da0307b-8b52-446e-8dcb-124936bc4b1f', 'Fear and Trembling');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (259, 'This is a description of Book Fair Stood the Wind for France', 44, '/assets/img/content/main/card2.jpg', false, 2043.1731031021031, '2017-12-02', '4288472c-b146-4078-adc7-60e7547cc61e', 'Fair Stood the Wind for France');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (260, 'This is a description of Book Let Us Now Praise Famous Men', 21, '/assets/img/content/main/card2.jpg', true, 3120.7922061533695, '2021-01-09', '7f5e5736-5e7f-4540-927a-97428757cc78', 'Let Us Now Praise Famous Men');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (261, 'This is a description of Book Mother Night', 13, '/assets/img/content/main/card2.jpg', true, 2732.122620855032, '2013-07-15', '065571af-49b5-4967-8db4-0d93f5474056', 'Mother Night');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (262, 'This is a description of Book I Know Why the Caged Bird Sings', 27, '/assets/img/content/main/card2.jpg', true, 4683.556314514063, '2022-03-10', '42796547-fe39-4500-8cbc-94f68c60c0b3', 'I Know Why the Caged Bird Sings');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (263, 'This is a description of Book Blood''s a Rover', 15, '/assets/img/content/main/card2.jpg', false, 3323.4081920308076, '2015-06-16', '4fcc623e-d72f-42a2-a4ec-2669fc6a46b2', 'Blood''s a Rover');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (264, 'This is a description of Book If Not Now, When?', 9, '/assets/img/content/main/card2.jpg', true, 4433.6292935784895, '2018-01-02', 'cc329f4f-173b-4040-9c7d-e061f0eb1f19', 'If Not Now, When?');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (265, 'This is a description of Book The Heart Is a Lonely Hunter', 1, '/assets/img/content/main/card2.jpg', false, 759.0080631050678, '2019-05-25', '6f5ddd7a-0ceb-4594-8438-f253fa03be3f', 'The Heart Is a Lonely Hunter');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (266, 'This is a description of Book For a Breath I Tarry', 37, '/assets/img/content/main/card2.jpg', false, 2024.699236415528, '2018-01-09', 'c7dba6d7-6527-4df1-ad70-bcd2e3ae2f61', 'For a Breath I Tarry');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (267, 'This is a description of Book Far From the Madding Crowd', 47, '/assets/img/content/main/card2.jpg', true, 3709.6539102638153, '2021-08-07', '4f0ee47b-ecb2-492d-a35c-f5f8ed21036e', 'Far From the Madding Crowd');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (268, 'This is a description of Book What''s Become of Waring', 11, '/assets/img/content/main/card2.jpg', true, 2732.5564672432524, '2019-04-06', '0fd93a37-50c2-4fb4-bf9e-3f76968b3aa9', 'What''s Become of Waring');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (269, 'This is a description of Book The Heart Is a Lonely Hunter', 39, '/assets/img/content/main/card2.jpg', false, 3674.2703554207073, '2018-05-25', '5a3a2e26-e687-44b7-9e01-811ef56966ab', 'The Heart Is a Lonely Hunter');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (270, 'This is a description of Book Ring of Bright Water', 5, '/assets/img/content/main/card2.jpg', true, 5089.985089554621, '2020-10-08', '687898a3-5282-4ac8-ad5e-bd07477cf6f4', 'Ring of Bright Water');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (271, 'This is a description of Book Alone on a Wide, Wide Sea', 11, '/assets/img/content/main/card2.jpg', false, 3178.984348469036, '2016-03-21', '2cbb0663-8415-425f-9d13-2c513db386db', 'Alone on a Wide, Wide Sea');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (272, 'This is a description of Book Quo Vadis', 31, '/assets/img/content/main/card2.jpg', true, 4085.7543690651705, '2020-03-30', '5a575289-57ee-4a2f-98b8-a2491da57793', 'Quo Vadis');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (273, 'This is a description of Book If Not Now, When?', 23, '/assets/img/content/main/card2.jpg', true, 4505.12592221899, '2013-09-01', 'c04ea7fa-6636-4af9-ac28-b107ea236320', 'If Not Now, When?');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (274, 'This is a description of Book Unweaving the Rainbow', 13, '/assets/img/content/main/card2.jpg', false, 138.65149480869388, '2018-12-10', 'e0170c07-54f3-476f-b7b3-7fa3acf43151', 'Unweaving the Rainbow');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (275, 'This is a description of Book Endless Night', 42, '/assets/img/content/main/card2.jpg', false, 5085.384887915396, '2019-04-12', '530739a1-f6d0-4ee4-a8a4-759cd60c827e', 'Endless Night');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (276, 'This is a description of Book Blue Remembered Earth', 27, '/assets/img/content/main/card2.jpg', false, 810.1161464105021, '2020-10-05', '32954073-d8a8-4b5d-a350-f40334efc23f', 'Blue Remembered Earth');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (277, 'This is a description of Book Many Waters', 38, '/assets/img/content/main/card2.jpg', false, 3958.213656035382, '2021-03-06', '94f436b7-9bbe-4043-a11e-0e391ff53872', 'Many Waters');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (278, 'This is a description of Book Consider Phlebas', 28, '/assets/img/content/main/card2.jpg', true, 907.753288654191, '2017-11-01', 'e2331860-a6fb-4a34-a55d-5af54c40f2ea', 'Consider Phlebas');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (279, 'This is a description of Book As I Lay Dying', 24, '/assets/img/content/main/card2.jpg', true, 1717.1872363059622, '2018-11-25', '02abe7ef-f02c-4b80-bbbf-b9850ebf6cad', 'As I Lay Dying');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (280, 'This is a description of Book The Skull Beneath the Skin', 43, '/assets/img/content/main/card2.jpg', false, 4955.2248445565765, '2019-10-11', 'bce170da-36d6-443c-afa6-a630591cbed6', 'The Skull Beneath the Skin');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (281, 'This is a description of Book The Violent Bear It Away', 17, '/assets/img/content/main/card2.jpg', false, 1370.4696606326386, '2015-01-13', 'd7b1ae06-31ce-46da-aa4d-462bf2f3b891', 'The Violent Bear It Away');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (282, 'This is a description of Book Bury My Heart at Wounded Knee', 27, '/assets/img/content/main/card2.jpg', false, 902.8988788763512, '2014-10-03', '9daa6602-6e96-4925-82c0-d2f92253c162', 'Bury My Heart at Wounded Knee');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (283, 'This is a description of Book Gone with the Wind', 14, '/assets/img/content/main/card2.jpg', false, 3674.7730308640243, '2014-03-09', '3b57651e-9323-486a-80c0-819f8f10cec6', 'Gone with the Wind');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (284, 'This is a description of Book In a Dry Season', 5, '/assets/img/content/main/card2.jpg', true, 3354.296532956514, '2013-11-04', '9bd7a668-9e94-408e-9c12-cacd63113e6d', 'In a Dry Season');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (285, 'This is a description of Book Consider Phlebas', 13, '/assets/img/content/main/card2.jpg', true, 2924.321937759633, '2021-07-27', 'bb4c6818-333f-42b7-9bec-9bf500aec005', 'Consider Phlebas');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (286, 'This is a description of Book This Side of Paradise', 0, '/assets/img/content/main/card2.jpg', false, 1692.186449447136, '2016-02-06', '13b910ea-910b-4071-872e-0b7ce42208a5', 'This Side of Paradise');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (287, 'This is a description of Book Look Homeward, Angel', 10, '/assets/img/content/main/card2.jpg', true, 4756.802325540975, '2015-10-19', '3688be74-a5ad-410b-ae51-ed2f92147eb0', 'Look Homeward, Angel');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (288, 'This is a description of Book For a Breath I Tarry', 43, '/assets/img/content/main/card2.jpg', false, 4404.982445003272, '2019-08-26', 'e0647910-2fbe-44b9-950c-190b226e3bb5', 'For a Breath I Tarry');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (289, 'This is a description of Book His Dark Materials', 42, '/assets/img/content/main/card2.jpg', false, 2296.1395568866915, '2014-10-31', 'a7df0a6d-06ce-470a-bdf7-905439b55b48', 'His Dark Materials');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (290, 'This is a description of Book Frequent Hearses', 33, '/assets/img/content/main/card2.jpg', false, 1804.4857359616424, '2020-12-11', '4f7529db-c4c9-4be4-ad95-1e974b598485', 'Frequent Hearses');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (291, 'This is a description of Book The Last Enemy', 14, '/assets/img/content/main/card2.jpg', false, 1512.134412382174, '2016-12-03', 'c806bbf5-bda5-4e44-8bb8-ce6005ee3a4f', 'The Last Enemy');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (292, 'This is a description of Book The Heart Is Deceitful Above All Things', 34, '/assets/img/content/main/card2.jpg', false, 3759.5454816050424, '2020-04-09', '27785323-1935-41d0-a5dc-ce32a517cb68', 'The Heart Is Deceitful Above All Things');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (293, 'This is a description of Book The Mirror Crack''d from Side to Side', 36, '/assets/img/content/main/card2.jpg', true, 2218.5163559484727, '2022-07-14', '396274f4-6740-45c8-b0f0-79e819267a67', 'The Mirror Crack''d from Side to Side');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (294, 'This is a description of Book The Grapes of Wrath', 42, '/assets/img/content/main/card2.jpg', false, 2117.6925384248484, '2021-09-21', 'e41cb80a-ab86-4a63-9147-0d89e2ad3ffc', 'The Grapes of Wrath');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (295, 'This is a description of Book As I Lay Dying', 43, '/assets/img/content/main/card2.jpg', true, 315.238309872019, '2014-12-16', 'b383d5a0-9b27-495f-a6b5-829ba537298c', 'As I Lay Dying');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (296, 'This is a description of Book The Road Less Traveled', 26, '/assets/img/content/main/card2.jpg', true, 3803.517249358914, '2017-02-13', '289303ff-42d4-4844-bc3e-b8ed17a20544', 'The Road Less Traveled');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (297, 'This is a description of Book A Monstrous Regiment of Women', 1, '/assets/img/content/main/card2.jpg', true, 4409.833478218266, '2016-03-09', '9816b155-cc82-44ef-9f7a-8fb5eaa9f618', 'A Monstrous Regiment of Women');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (298, 'This is a description of Book The Cricket on the Hearth', 48, '/assets/img/content/main/card2.jpg', false, 1912.5333333599942, '2022-12-28', 'bf596d12-4377-4a7b-81c3-4fedf6b1c2c8', 'The Cricket on the Hearth');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (299, 'This is a description of Book The Proper Study', 44, '/assets/img/content/main/card2.jpg', false, 3917.238883810015, '2020-12-18', 'a178dddb-c48e-40d7-9119-e742ae516a0d', 'The Proper Study');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (300, 'This is a description of Book Ring of Bright Water', 12, '/assets/img/content/main/card2.jpg', false, 4226.501374265677, '2013-03-23', '798a2a5d-7c9d-4f6a-98f6-7230f745c276', 'Ring of Bright Water');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (301, 'This is a description of Book Tender Is the Night', 14, '/assets/img/content/main/card2.jpg', true, 3766.6280587201773, '2016-06-13', '04364d32-3c55-4d96-a830-87e4741637ee', 'Tender Is the Night');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (302, 'This is a description of Book Fair Stood the Wind for France', 6, '/assets/img/content/main/card2.jpg', true, 1320.9162926589613, '2013-12-22', 'ac8e3612-15f0-45e4-8df6-84697f1cb2f2', 'Fair Stood the Wind for France');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (303, 'This is a description of Book The Monkey''s Raincoat', 6, '/assets/img/content/main/card2.jpg', false, 4560.811949050002, '2021-05-09', '5381d354-aa28-4a4f-a762-f43bd484fdfb', 'The Monkey''s Raincoat');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (304, 'This is a description of Book An Instant In The Wind', 27, '/assets/img/content/main/card2.jpg', true, 2473.3171522722273, '2014-10-20', '5633de82-d4b2-43a1-8fa9-6f4b96ead3bc', 'An Instant In The Wind');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (305, 'This is a description of Book As I Lay Dying', 44, '/assets/img/content/main/card2.jpg', true, 3323.5971312102974, '2018-07-09', '7c00238e-5a60-48ed-99ee-1a0341e42a2b', 'As I Lay Dying');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (306, 'This is a description of Book The Sun Also Rises', 41, '/assets/img/content/main/card2.jpg', true, 5066.71271198588, '2014-05-28', '6927aea4-1391-434e-be70-a3e0ab3196f7', 'The Sun Also Rises');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (307, 'This is a description of Book Look Homeward, Angel', 27, '/assets/img/content/main/card2.jpg', false, 4735.927833369229, '2022-08-07', '95a0434e-e3f0-4e29-871c-90db9fc41f89', 'Look Homeward, Angel');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (308, 'This is a description of Book Rosemary Sutcliff', 30, '/assets/img/content/main/card2.jpg', false, 3829.174668101651, '2017-07-07', '4d275cba-c6a0-4794-8838-11765644f3b2', 'Rosemary Sutcliff');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (309, 'This is a description of Book Absalom, Absalom!', 1, '/assets/img/content/main/card2.jpg', true, 2197.5863344547374, '2019-11-11', '26d36c41-c608-4801-bd71-dbe402a3929c', 'Absalom, Absalom!');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (310, 'This is a description of Book A Scanner Darkly', 47, '/assets/img/content/main/card2.jpg', false, 4741.209296386111, '2017-02-09', 'df74ce60-caab-42a8-9e14-b8406dac5d11', 'A Scanner Darkly');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (311, 'This is a description of Book The Way Through the Woods', 44, '/assets/img/content/main/card2.jpg', false, 2720.947767420288, '2021-12-14', '15fadfc4-db44-4278-ae0e-1e4fddf96c50', 'The Way Through the Woods');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (312, 'This is a description of Book The Way of All Flesh', 41, '/assets/img/content/main/card2.jpg', false, 1143.038334475522, '2018-06-05', '9708795c-4b4f-4e41-8e93-639aae57c182', 'The Way of All Flesh');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (313, 'This is a description of Book Jacob Have I Loved', 31, '/assets/img/content/main/card2.jpg', false, 498.652254644126, '2017-09-26', '09ed5eaa-d8ed-47ef-b913-16d5ab9f7a0f', 'Jacob Have I Loved');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (314, 'This is a description of Book The Torment of Others', 11, '/assets/img/content/main/card2.jpg', false, 2315.2969468616657, '2016-03-06', '73cfdf22-9a3c-46e4-a127-a20a548e7f9c', 'The Torment of Others');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (315, 'This is a description of Book Have His Carcase', 26, '/assets/img/content/main/card2.jpg', true, 4755.801097678564, '2016-06-06', 'ec131399-0d60-4096-b0e4-61300b1c6006', 'Have His Carcase');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (316, 'This is a description of Book No Highway', 12, '/assets/img/content/main/card2.jpg', true, 3161.770373845402, '2015-09-18', '055aeb69-3432-4306-914d-9949092376d0', 'No Highway');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (317, 'This is a description of Book Those Barren Leaves, Thrones, Dominations', 12, '/assets/img/content/main/card2.jpg', true, 980.2452482378835, '2019-03-10', '1bf97522-70cf-43b9-a6ef-d980c896e6f4', 'Those Barren Leaves, Thrones, Dominations');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (318, 'This is a description of Book Wildfire at Midnight', 40, '/assets/img/content/main/card2.jpg', true, 887.7556361601844, '2022-06-19', 'd03536df-23fa-4ad6-a4dc-5ee4848d84ab', 'Wildfire at Midnight');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (319, 'This is a description of Book Tender Is the Night', 18, '/assets/img/content/main/card2.jpg', false, 377.9137019944489, '2018-03-06', 'a9dafb32-ba95-4fcb-a92e-4f957613262b', 'Tender Is the Night');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (320, 'This is a description of Book I Sing the Body Electric', 5, '/assets/img/content/main/card2.jpg', false, 3527.049085040169, '2018-03-14', 'cf1090f8-553f-4408-8382-8a95e0822129', 'I Sing the Body Electric');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (321, 'This is a description of Book O Pioneers!', 49, '/assets/img/content/main/card2.jpg', false, 2396.736347772737, '2018-01-21', 'f24a337f-8bc9-4c59-8fed-b7c336c98a8a', 'O Pioneers!');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (322, 'This is a description of Book Ego Dominus Tuus', 4, '/assets/img/content/main/card2.jpg', false, 2430.757657912829, '2016-05-22', 'badf7ca9-7b34-4b2c-b591-68478a5914c6', 'Ego Dominus Tuus');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (323, 'This is a description of Book Let Us Now Praise Famous Men', 1, '/assets/img/content/main/card2.jpg', true, 1151.2191200016307, '2021-06-07', 'b83d7e69-8e2a-409e-80c8-b7a903fa3143', 'Let Us Now Praise Famous Men');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (324, 'This is a description of Book Surprised by Joy', 32, '/assets/img/content/main/card2.jpg', true, 5015.428808025921, '2016-04-08', '29d80676-1081-4af7-9ba7-a0460a3399d0', 'Surprised by Joy');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (325, 'This is a description of Book Number the Stars', 43, '/assets/img/content/main/card2.jpg', true, 433.907360544513, '2023-02-01', '1aba77b8-8b0a-4625-b7c7-9dcd547b1433', 'Number the Stars');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (326, 'This is a description of Book O Pioneers!', 8, '/assets/img/content/main/card2.jpg', true, 3662.9429783711184, '2017-02-15', '822c7763-7f9e-423a-93ba-081c8fabd45c', 'O Pioneers!');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (327, 'This is a description of Book Vanity Fair', 23, '/assets/img/content/main/card2.jpg', false, 3153.9637941293445, '2018-01-28', '7d5356aa-565c-4e23-805f-b39923ebe989', 'Vanity Fair');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (328, 'This is a description of Book The Wealth of Nations', 30, '/assets/img/content/main/card2.jpg', false, 1482.2493194480508, '2018-11-08', 'e47d50a4-9214-4b1c-8db0-fe551c38249e', 'The Wealth of Nations');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (329, 'This is a description of Book Specimen Days', 9, '/assets/img/content/main/card2.jpg', false, 3688.6375281150144, '2014-04-02', '1bef4559-de94-4a2f-a96c-2e6337da0b0d', 'Specimen Days');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (330, 'This is a description of Book Beneath the Bleeding', 9, '/assets/img/content/main/card2.jpg', false, 1043.120615123794, '2019-05-23', '8ef2d53c-250a-47ac-b3c9-9f606a34dc29', 'Beneath the Bleeding');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (331, 'This is a description of Book A Darkling Plain', 1, '/assets/img/content/main/card2.jpg', true, 231.11644868003057, '2019-04-17', '2cc17e9e-8da2-49fa-a0cd-a7deae8c9c74', 'A Darkling Plain');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (332, 'This is a description of Book Jesting Pilate', 26, '/assets/img/content/main/card2.jpg', true, 3394.4119628799444, '2022-07-06', 'aa367517-6b4b-426a-a248-6690912853b7', 'Jesting Pilate');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (333, 'This is a description of Book Fear and Trembling', 9, '/assets/img/content/main/card2.jpg', true, 705.8531224723465, '2013-12-05', 'c3a8ff0c-600d-4ceb-8d1e-dfbf2f032f32', 'Fear and Trembling');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (334, 'This is a description of Book The Sun Also Rises', 0, '/assets/img/content/main/card2.jpg', true, 3870.818912947961, '2020-03-22', '7ed69248-9457-44dd-9aca-ba3bd7533f2f', 'The Sun Also Rises');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (335, 'This is a description of Book The Moving Toyshop', 32, '/assets/img/content/main/card2.jpg', false, 2132.009018372792, '2013-12-18', '665c13ed-8b7b-43fc-b5dc-83505099c4b9', 'The Moving Toyshop');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (336, 'This is a description of Book To a God Unknown', 39, '/assets/img/content/main/card2.jpg', true, 1226.3181372231097, '2022-10-12', 'c9b348f2-015b-4e83-a7f8-ea60532a6adc', 'To a God Unknown');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (337, 'This is a description of Book I Know Why the Caged Bird Sings', 4, '/assets/img/content/main/card2.jpg', false, 4705.858112279033, '2020-02-27', '30912eac-6714-4bf0-8929-6ab348128f36', 'I Know Why the Caged Bird Sings');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (338, 'This is a description of Book The House of Mirth', 33, '/assets/img/content/main/card2.jpg', true, 3156.54528165043, '2016-08-28', 'acb81b51-afe7-4122-9830-aaa50251cfe3', 'The House of Mirth');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (339, 'This is a description of Book The Little Foxes', 1, '/assets/img/content/main/card2.jpg', false, 1555.3726697301556, '2017-10-01', '8ba37e91-d71a-4a89-97e1-ab65dd4dd226', 'The Little Foxes');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (340, 'This is a description of Book The World, the Flesh and the Devil', 10, '/assets/img/content/main/card2.jpg', true, 914.5128376035611, '2021-05-12', '30e910a4-34e9-4fd9-ab9f-c41e77233b68', 'The World, the Flesh and the Devil');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (341, 'This is a description of Book The Heart Is a Lonely Hunter', 28, '/assets/img/content/main/card2.jpg', true, 2427.434540752588, '2013-12-23', '5055e5e7-88e3-4e48-a55a-db34db435da3', 'The Heart Is a Lonely Hunter');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (342, 'This is a description of Book The Mirror Crack''d from Side to Side', 33, '/assets/img/content/main/card2.jpg', false, 1654.722406814277, '2016-07-30', '73f5104e-802a-4795-b5e0-47f192e071ef', 'The Mirror Crack''d from Side to Side');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (343, 'This is a description of Book The Lathe of Heaven', 33, '/assets/img/content/main/card2.jpg', true, 4217.187342098404, '2021-05-07', '26492d3c-048c-40bc-86f2-ebef6057a604', 'The Lathe of Heaven');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (344, 'This is a description of Book Gone with the Wind', 18, '/assets/img/content/main/card2.jpg', false, 4784.791762915539, '2018-10-02', '8d6cbb06-aa63-44e1-8af9-e2324d544460', 'Gone with the Wind');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (345, 'This is a description of Book The Needle''s Eye', 13, '/assets/img/content/main/card2.jpg', false, 2366.590513892393, '2015-12-29', '16068dc6-0a2f-4889-9179-c887199ca39b', 'The Needle''s Eye');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (346, 'This is a description of Book A Scanner Darkly', 17, '/assets/img/content/main/card2.jpg', false, 1379.8431386826887, '2016-01-25', '0a018f65-254b-468c-9088-d43a1df176cc', 'A Scanner Darkly');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (347, 'This is a description of Book Ah, Wilderness!', 17, '/assets/img/content/main/card2.jpg', false, 2918.7368672728157, '2016-01-20', '93e633c0-e0c6-4d50-b239-3dda62299590', 'Ah, Wilderness!');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (348, 'This is a description of Book The Mermaids Singing', 22, '/assets/img/content/main/card2.jpg', true, 1825.7150749323769, '2016-10-08', '2cc4be76-9f0e-44db-bc0c-6fdb251689e4', 'The Mermaids Singing');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (349, 'This is a description of Book Infinite Jest', 0, '/assets/img/content/main/card2.jpg', true, 3875.5417067515614, '2021-06-16', 'c1c0cf84-9fd6-4481-9101-76c061421221', 'Infinite Jest');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (350, 'This is a description of Book Cover Her Face', 12, '/assets/img/content/main/card2.jpg', false, 1128.4302110551669, '2021-03-27', 'feea532c-cd72-4661-8d00-49fac1c9ad6c', 'Cover Her Face');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (351, 'This is a description of Book Pale Kings and Princes', 1, '/assets/img/content/main/card2.jpg', true, 3989.95411018175, '2022-11-21', '0ba17e06-7812-495f-bf73-2d657465a1f8', 'Pale Kings and Princes');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (352, 'This is a description of Book The Wives of Bath', 3, '/assets/img/content/main/card2.jpg', true, 4615.624214011376, '2018-05-29', 'bdd2cb3a-4768-4b4a-9e59-10736ea08903', 'The Wives of Bath');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (353, 'This is a description of Book Death Be Not Proud', 32, '/assets/img/content/main/card2.jpg', true, 2517.4390518570526, '2017-08-26', 'e12b0b33-2517-4eed-bfe7-73e0e1401e63', 'Death Be Not Proud');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (354, 'This is a description of Book The Last Temptation', 29, '/assets/img/content/main/card2.jpg', false, 1458.8996357949916, '2016-05-10', 'bf028533-6064-4320-ab32-f8e738504665', 'The Last Temptation');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (355, 'This is a description of Book In a Glass Darkly', 19, '/assets/img/content/main/card2.jpg', true, 159.5517054834653, '2018-12-28', 'be328386-58f8-4369-ab46-24b484aed157', 'In a Glass Darkly');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (356, 'This is a description of Book Tirra Lirra by the River', 21, '/assets/img/content/main/card2.jpg', false, 920.3802465056294, '2019-07-14', 'cd5b7f4f-09c3-474b-bb02-939b45e26d1c', 'Tirra Lirra by the River');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (357, 'This is a description of Book Terrible Swift Sword', 37, '/assets/img/content/main/card2.jpg', true, 2951.5007828167527, '2013-08-29', '19b2e16a-c472-4a1a-8585-c81f90a8a322', 'Terrible Swift Sword');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (358, 'This is a description of Book Vanity Fair', 21, '/assets/img/content/main/card2.jpg', false, 3903.4080654310496, '2020-06-01', '271b5224-2e9e-4958-a048-a35b53f317de', 'Vanity Fair');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (359, 'This is a description of Book Edna O''Brien', 16, '/assets/img/content/main/card2.jpg', false, 2693.563847766733, '2017-05-30', 'c7d3814a-144a-4b5a-8955-0d351704936d', 'Edna O''Brien');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (360, 'This is a description of Book A Confederacy of Dunces', 46, '/assets/img/content/main/card2.jpg', true, 4166.133039865528, '2018-11-23', '665d9c55-cb5a-4505-8570-10cb4ac2a891', 'A Confederacy of Dunces');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (361, 'This is a description of Book Waiting for the Barbarians', 20, '/assets/img/content/main/card2.jpg', false, 5018.571263327038, '2017-12-06', '334471e6-f84a-423b-a031-81065df695e6', 'Waiting for the Barbarians');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (362, 'This is a description of Book The Moving Toyshop', 2, '/assets/img/content/main/card2.jpg', false, 641.2146104511743, '2016-04-04', '52270b7b-dcad-4783-bc28-393bd04ea0e3', 'The Moving Toyshop');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (363, 'This is a description of Book Many Waters', 33, '/assets/img/content/main/card2.jpg', true, 4052.773225978053, '2014-05-09', 'a015bf0c-1491-4986-9876-0a814661e5e7', 'Many Waters');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (364, 'This is a description of Book A Monstrous Regiment of Women', 23, '/assets/img/content/main/card2.jpg', false, 1026.4901310396492, '2021-08-05', 'd2acaaa4-aa0a-4217-bd23-00753ea72523', 'A Monstrous Regiment of Women');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (365, 'This is a description of Book The Heart Is Deceitful Above All Things', 14, '/assets/img/content/main/card2.jpg', false, 997.7120399353652, '2013-09-13', '99135531-74f3-4e00-a47b-cbc663a61113', 'The Heart Is Deceitful Above All Things');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (366, 'This is a description of Book This Lime Tree Bower', 22, '/assets/img/content/main/card2.jpg', false, 5099.006543877094, '2015-02-01', '7f87e561-456a-4f53-b3b7-12f9c6ee1839', 'This Lime Tree Bower');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (367, 'This is a description of Book The Last Temptation', 31, '/assets/img/content/main/card2.jpg', true, 3031.064575530803, '2018-03-12', 'd6fba598-8e55-4fef-9c6d-5ca3110ddffb', 'The Last Temptation');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (368, 'This is a description of Book All the King''s Men', 3, '/assets/img/content/main/card2.jpg', true, 1976.4824748807948, '2014-05-11', 'f6c23691-0c60-42a6-85f2-d625ce759a72', 'All the King''s Men');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (369, 'This is a description of Book The Last Temptation', 12, '/assets/img/content/main/card2.jpg', true, 4196.232314574324, '2013-05-09', 'ce772825-dcec-44ef-bc91-743c298087f0', 'The Last Temptation');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (370, 'This is a description of Book Rosemary Sutcliff', 44, '/assets/img/content/main/card2.jpg', true, 4970.026020662374, '2022-10-31', 'aea1c57d-81cf-4b29-a666-b92fb10316ee', 'Rosemary Sutcliff');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (371, 'This is a description of Book Consider Phlebas', 28, '/assets/img/content/main/card2.jpg', true, 865.0324541658005, '2017-09-19', '6dee1802-9c41-4c72-af63-502ea8590b03', 'Consider Phlebas');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (372, 'This is a description of Book This Side of Paradise', 39, '/assets/img/content/main/card2.jpg', true, 2655.7213287288137, '2021-08-28', '3bfdf545-2d06-431e-a773-b82c4376f9e3', 'This Side of Paradise');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (373, 'This is a description of Book The World, the Flesh and the Devil', 6, '/assets/img/content/main/card2.jpg', true, 1674.5865405282013, '2023-01-30', '6f0ab8fa-61ca-4003-a218-cd7d05e7d03b', 'The World, the Flesh and the Devil');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (374, 'This is a description of Book Some Buried Caesar', 27, '/assets/img/content/main/card2.jpg', true, 4998.691385092843, '2013-09-15', 'fdde6926-fa81-4d58-a55c-c0300b56b36e', 'Some Buried Caesar');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (375, 'This is a description of Book Dulce et Decorum Est', 39, '/assets/img/content/main/card2.jpg', true, 1784.1757307437601, '2021-03-13', '6778040e-d0d0-49d9-9ab2-cb0a1c2dd080', 'Dulce et Decorum Est');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (376, 'This is a description of Book A Darkling Plain', 11, '/assets/img/content/main/card2.jpg', false, 2815.1063502917, '2021-06-05', '17420781-9ed2-40fa-8f53-cc148934992d', 'A Darkling Plain');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (377, 'This is a description of Book The Line of Beauty', 48, '/assets/img/content/main/card2.jpg', true, 4679.806103940116, '2016-07-04', '8e4a3825-3a23-485b-8033-dea8c3daf3bf', 'The Line of Beauty');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (378, 'This is a description of Book Bury My Heart at Wounded Knee', 5, '/assets/img/content/main/card2.jpg', false, 2863.731834278408, '2017-01-19', '6304c4aa-3e55-42c9-b8a1-8c95553abbd4', 'Bury My Heart at Wounded Knee');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (379, 'This is a description of Book Vile Bodies', 26, '/assets/img/content/main/card2.jpg', false, 2716.7349085211927, '2019-06-24', 'ccd3a902-c951-4fe0-8db7-18cf7016c36e', 'Vile Bodies');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (380, 'This is a description of Book Noli Me Tangere', 23, '/assets/img/content/main/card2.jpg', true, 4266.379556070747, '2017-09-17', '10df0052-98c8-418e-b260-ed207365411d', 'Noli Me Tangere');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (381, 'This is a description of Book The Torment of Others', 5, '/assets/img/content/main/card2.jpg', false, 115.59005980308905, '2021-10-12', '190c713e-be77-4507-94b9-15c93ecb0e46', 'The Torment of Others');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (382, 'This is a description of Book Blithe Spirit', 4, '/assets/img/content/main/card2.jpg', false, 1473.648151570328, '2020-12-08', 'ae36b6f0-e9f2-4023-aa73-cf601b18f142', 'Blithe Spirit');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (383, 'This is a description of Book It''s a Battlefield', 48, '/assets/img/content/main/card2.jpg', true, 4022.6707880444847, '2021-07-20', 'e43d73c7-53ce-4244-a1b5-8e557d31c184', 'It''s a Battlefield');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (384, 'This is a description of Book Unweaving the Rainbow', 2, '/assets/img/content/main/card2.jpg', false, 1780.7231077533506, '2017-11-04', 'e3dafbbc-f5b1-4012-a6d1-ccbdb089e7fa', 'Unweaving the Rainbow');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (385, 'This is a description of Book Infinite Jest', 37, '/assets/img/content/main/card2.jpg', true, 3169.856650282676, '2019-10-25', '8c7ee2b6-6f37-4a85-97ba-a54e69214cc5', 'Infinite Jest');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (386, 'This is a description of Book Frequent Hearses', 15, '/assets/img/content/main/card2.jpg', true, 1137.5749187247534, '2021-07-25', '30c27a7d-ed3f-40e2-b640-05b8cc8a06fb', 'Frequent Hearses');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (387, 'This is a description of Book Vanity Fair', 5, '/assets/img/content/main/card2.jpg', false, 1258.4441063884374, '2021-02-06', 'a266e37c-ebea-4724-bb9b-679e14fc2384', 'Vanity Fair');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (388, 'This is a description of Book The Heart Is Deceitful Above All Things', 6, '/assets/img/content/main/card2.jpg', false, 2715.4709644221552, '2017-12-21', '6921d701-5670-4b06-87a1-d20d84b52afa', 'The Heart Is Deceitful Above All Things');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (389, 'This is a description of Book An Instant In The Wind', 33, '/assets/img/content/main/card2.jpg', false, 2934.4528398557404, '2015-10-22', '3e1c9ddf-4157-40c6-917d-7e54542fca8c', 'An Instant In The Wind');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (390, 'This is a description of Book Arms and the Man', 22, '/assets/img/content/main/card2.jpg', false, 4375.351061008773, '2018-10-19', '5dc4366a-6d74-4ead-a82b-794c440c00a7', 'Arms and the Man');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (391, 'This is a description of Book Tiger! Tiger!', 15, '/assets/img/content/main/card2.jpg', false, 1391.1356738040404, '2019-07-04', 'ebbcd7d1-a9dd-487c-af42-61d829e698c5', 'Tiger! Tiger!');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (392, 'This is a description of Book To a God Unknown', 38, '/assets/img/content/main/card2.jpg', true, 2087.8452588780497, '2019-10-02', 'b7027307-6849-43ea-a7e4-74f6a68b0e32', 'To a God Unknown');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (393, 'This is a description of Book The World, the Flesh and the Devil', 18, '/assets/img/content/main/card2.jpg', true, 3785.833360917769, '2018-05-04', 'e243203a-1ab7-4c93-82d2-0b046a99522d', 'The World, the Flesh and the Devil');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (394, 'This is a description of Book The Sun Also Rises', 28, '/assets/img/content/main/card2.jpg', false, 2546.805775060569, '2015-08-13', 'b9ef1c3c-91f4-467e-abd7-3b790348ff94', 'The Sun Also Rises');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (395, 'This is a description of Book The Doors of Perception', 19, '/assets/img/content/main/card2.jpg', false, 1026.045160129116, '2016-01-10', '69e053de-ba22-4607-9808-1cfb97027b63', 'The Doors of Perception');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (396, 'This is a description of Book All the King''s Men', 36, '/assets/img/content/main/card2.jpg', true, 3764.4378263255926, '2020-01-25', '4f726d1a-0e7b-48bc-8b71-13c610aeb06d', 'All the King''s Men');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (397, 'This is a description of Book Blood''s a Rover', 40, '/assets/img/content/main/card2.jpg', false, 4233.853769845406, '2023-02-13', '067c7344-5ce4-4f72-a303-d9ebffa4eb64', 'Blood''s a Rover');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (398, 'This is a description of Book Dance Dance Dance', 45, '/assets/img/content/main/card2.jpg', true, 3303.9358339186706, '2018-08-13', 'c6a47f05-19b6-4ed4-80af-47fe3378e6ea', 'Dance Dance Dance');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (399, 'This is a description of Book The Little Foxes', 50, '/assets/img/content/main/card2.jpg', true, 1279.2240674854, '2022-02-02', 'c43ac6a4-8306-4f6c-9d1c-dd6a87903fc6', 'The Little Foxes');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (400, 'This is a description of Book No Highway', 49, '/assets/img/content/main/card2.jpg', true, 3348.9356343445797, '2020-02-01', '05de380c-379b-4b42-abca-8a4d800b6426', 'No Highway');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (401, 'This is a description of Book Ego Dominus Tuus', 31, '/assets/img/content/main/card2.jpg', true, 4082.3737726789427, '2017-09-03', 'f0720c3d-eba2-473d-979f-01a5fae2425a', 'Ego Dominus Tuus');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (402, 'This is a description of Book Fear and Trembling', 40, '/assets/img/content/main/card2.jpg', true, 1979.7879600282974, '2023-01-26', 'ca1a91e4-386c-4948-b5aa-312f24ed52ad', 'Fear and Trembling');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (403, 'This is a description of Book A Summer Bird-Cage', 26, '/assets/img/content/main/card2.jpg', true, 633.4345573678485, '2018-01-17', '30cb13f7-488c-4cad-9b0c-25c819a01cc0', 'A Summer Bird-Cage');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (404, 'This is a description of Book Death Be Not Proud', 46, '/assets/img/content/main/card2.jpg', false, 3926.3359332339155, '2014-02-26', '15435d9b-2aed-4420-b7a9-cf614c6fbac4', 'Death Be Not Proud');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (405, 'This is a description of Book Cover Her Face', 36, '/assets/img/content/main/card2.jpg', true, 2721.1375863214535, '2017-04-12', '7b796c03-4816-4c5c-9c9f-d82a0101f86b', 'Cover Her Face');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (406, 'This is a description of Book Fear and Trembling', 43, '/assets/img/content/main/card2.jpg', true, 4221.4664010280285, '2019-10-30', 'ec84a361-55a2-4c01-9a53-0787ed125f64', 'Fear and Trembling');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (407, 'This is a description of Book Endless Night', 19, '/assets/img/content/main/card2.jpg', false, 2133.7806841737142, '2014-05-15', '5f10e9a4-df7f-4f5e-beb7-61f5a47456bf', 'Endless Night');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (408, 'This is a description of Book The House of Mirth', 46, '/assets/img/content/main/card2.jpg', false, 3419.6127660895827, '2020-05-22', 'dfc10894-cfe2-4d23-9ef3-fa6535d845d7', 'The House of Mirth');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (409, 'This is a description of Book Alone on a Wide, Wide Sea', 19, '/assets/img/content/main/card2.jpg', true, 2179.3873598031305, '2014-07-25', '03f1ffbe-f0ee-4d76-8b8b-23547bc23ca9', 'Alone on a Wide, Wide Sea');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (410, 'This is a description of Book Recalled to Life', 45, '/assets/img/content/main/card2.jpg', false, 3574.761039798931, '2016-06-07', 'a295098a-5ff0-4cde-a3cd-60e61461eb05', 'Recalled to Life');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (411, 'This is a description of Book A Monstrous Regiment of Women', 18, '/assets/img/content/main/card2.jpg', true, 1883.732219094534, '2022-01-25', 'f1b019f8-2fba-49e1-8ab8-3ba942c0d4ff', 'A Monstrous Regiment of Women');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (412, 'This is a description of Book If I Forget Thee Jerusalem', 24, '/assets/img/content/main/card2.jpg', true, 2092.4810483970496, '2015-01-31', 'ec006a6c-2e73-4369-8d2b-daabb3b10f9d', 'If I Forget Thee Jerusalem');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (413, 'This is a description of Book Infinite Jest', 19, '/assets/img/content/main/card2.jpg', false, 155.87368724430024, '2020-07-15', '3ae993a2-a389-4d55-8e0e-4897f70aa23e', 'Infinite Jest');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (414, 'This is a description of Book As I Lay Dying', 6, '/assets/img/content/main/card2.jpg', true, 1777.435314301053, '2016-01-18', 'f1a298aa-e73d-45a6-a0b0-ca91ba720e46', 'As I Lay Dying');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (415, 'This is a description of Book Tirra Lirra by the River', 28, '/assets/img/content/main/card2.jpg', true, 550.4536317097187, '2013-03-29', 'ee7ffdf4-22fb-48ad-940b-6cae0f51ad3a', 'Tirra Lirra by the River');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (416, 'This is a description of Book No Country for Old Men', 11, '/assets/img/content/main/card2.jpg', false, 5030.557746928653, '2016-04-15', '8523d71a-bb02-4360-9517-bd3ce2679493', 'No Country for Old Men');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (417, 'This is a description of Book Antic Hay', 28, '/assets/img/content/main/card2.jpg', true, 378.3540025891829, '2017-03-09', '319587de-7bed-4e7a-9eed-2859ab31f647', 'Antic Hay');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (418, 'This is a description of Book An Evil Cradling', 8, '/assets/img/content/main/card2.jpg', true, 4476.22591918034, '2020-08-29', '7883f8bf-baea-4b53-b2c7-9a4a1f7dc31f', 'An Evil Cradling');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (419, 'This is a description of Book The Cricket on the Hearth', 0, '/assets/img/content/main/card2.jpg', true, 3967.2619292364357, '2021-02-10', 'f6cdd990-c09f-496c-9389-cd677deb5387', 'The Cricket on the Hearth');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (420, 'This is a description of Book Ring of Bright Water', 10, '/assets/img/content/main/card2.jpg', false, 4302.841758739001, '2022-12-30', '93656be6-467b-44c4-9afb-7807c4b4e5f3', 'Ring of Bright Water');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (421, 'This is a description of Book Fear and Trembling', 16, '/assets/img/content/main/card2.jpg', false, 2501.3151535756647, '2015-01-04', 'd4c0181e-e8f7-4fa2-af9f-d5a5f202065b', 'Fear and Trembling');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (422, 'This is a description of Book Vanity Fair', 34, '/assets/img/content/main/card2.jpg', false, 2477.0877053534127, '2022-04-08', '36093b6f-b9ec-4c96-9288-24c687fc6075', 'Vanity Fair');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (423, 'This is a description of Book Vanity Fair', 42, '/assets/img/content/main/card2.jpg', true, 3751.666936160625, '2013-08-03', 'acb35d46-2ce5-4e14-b1bb-700d9da8652b', 'Vanity Fair');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (424, 'This is a description of Book Fear and Trembling', 36, '/assets/img/content/main/card2.jpg', false, 878.0249104832693, '2020-02-22', 'f0962e08-9223-4e97-80e0-ac7a7908da5c', 'Fear and Trembling');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (425, 'This is a description of Book Jesting Pilate', 14, '/assets/img/content/main/card2.jpg', true, 1459.5207103783366, '2017-02-20', '83bc10a1-8c50-4d5d-95a4-4b853e8a8b77', 'Jesting Pilate');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (426, 'This is a description of Book Rosemary Sutcliff', 42, '/assets/img/content/main/card2.jpg', true, 670.1673901491998, '2022-04-23', 'ef68f86a-adff-49ea-825f-9f490a823e01', 'Rosemary Sutcliff');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (427, 'This is a description of Book The Lathe of Heaven', 15, '/assets/img/content/main/card2.jpg', false, 3131.7962297194354, '2020-02-27', '8ebdb2a9-49d4-4f09-801b-24491b5571f3', 'The Lathe of Heaven');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (428, 'This is a description of Book All Passion Spent', 36, '/assets/img/content/main/card2.jpg', false, 2622.7060693034637, '2018-06-28', '7474c5cd-ff23-4a70-b06a-1da12a84258d', 'All Passion Spent');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (429, 'This is a description of Book Such, Such Were the Joys', 24, '/assets/img/content/main/card2.jpg', false, 1789.0665721380233, '2017-09-01', 'd78f0f2b-e2c0-43ec-83a7-ab4bcb4c2572', 'Such, Such Were the Joys');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (430, 'This is a description of Book To Your Scattered Bodies Go', 40, '/assets/img/content/main/card2.jpg', true, 1587.4086349327836, '2020-01-23', '21fa0081-da51-4915-a7e5-2a688b662337', 'To Your Scattered Bodies Go');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (431, 'This is a description of Book In a Dry Season', 39, '/assets/img/content/main/card2.jpg', true, 1374.0743297986894, '2013-11-22', '0d036955-fdef-4013-a8ff-880ab41e135b', 'In a Dry Season');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (432, 'This is a description of Book After Many a Summer Dies the Swan', 35, '/assets/img/content/main/card2.jpg', true, 205.1086762156824, '2016-11-08', '9570dd47-7d6f-4dc9-a14b-2bc113a95990', 'After Many a Summer Dies the Swan');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (433, 'This is a description of Book A Passage to India', 50, '/assets/img/content/main/card2.jpg', true, 2717.9301926030776, '2019-05-27', '80f0e767-3f11-4f72-b85f-e0d017820c85', 'A Passage to India');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (434, 'This is a description of Book The Stars'' Tennis Balls', 35, '/assets/img/content/main/card2.jpg', true, 3927.5787433025616, '2013-09-13', '73b22c57-79fa-46d2-9a64-200a1c50597b', 'The Stars'' Tennis Balls');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (435, 'This is a description of Book Consider Phlebas', 1, '/assets/img/content/main/card2.jpg', true, 1691.811874445466, '2013-06-27', '6e511c34-6cb1-42e4-949c-f915fe7e0d51', 'Consider Phlebas');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (436, 'This is a description of Book That Hideous Strength', 18, '/assets/img/content/main/card2.jpg', false, 3310.399084207714, '2018-01-16', '7193b270-3ff4-4c05-93ca-a32c412a8bcd', 'That Hideous Strength');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (437, 'This is a description of Book For a Breath I Tarry', 40, '/assets/img/content/main/card2.jpg', true, 2424.5192533872746, '2021-06-29', 'cd8ec536-35a8-4de9-9fb5-ba284bc4f449', 'For a Breath I Tarry');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (438, 'This is a description of Book Things Fall Apart', 5, '/assets/img/content/main/card2.jpg', false, 2067.8636773754943, '2018-09-29', 'd8ff3a3b-d725-430c-9821-f989374be9cb', 'Things Fall Apart');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (439, 'This is a description of Book The Millstone', 39, '/assets/img/content/main/card2.jpg', true, 4016.865394748115, '2015-04-11', '2008d850-2d58-41dc-a003-499418bd50c0', 'The Millstone');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (440, 'This is a description of Book It''s a Battlefield', 2, '/assets/img/content/main/card2.jpg', false, 772.1689022317984, '2021-07-19', '95adfccc-1d9c-4972-8e03-240fa437d5fb', 'It''s a Battlefield');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (441, 'This is a description of Book Lilies of the Field', 37, '/assets/img/content/main/card2.jpg', false, 2476.464871907883, '2022-05-16', '7aec04b0-0b1f-4ec1-afd2-e882c7be46f7', 'Lilies of the Field');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (442, 'This is a description of Book Infinite Jest', 3, '/assets/img/content/main/card2.jpg', false, 3736.0032860672454, '2019-07-14', '3e833a00-a851-464d-b01b-8b00941ad8fb', 'Infinite Jest');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (443, 'This is a description of Book Blithe Spirit', 1, '/assets/img/content/main/card2.jpg', false, 1173.7519362725018, '2022-05-10', '4ca59ff3-3e03-403b-9c5b-0b0cd86ab02b', 'Blithe Spirit');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (444, 'This is a description of Book The Sun Also Rises', 19, '/assets/img/content/main/card2.jpg', true, 2175.079117780004, '2015-05-15', '8507ce73-c93e-4240-8613-3da72a52c6c6', 'The Sun Also Rises');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (445, 'This is a description of Book No Highway', 32, '/assets/img/content/main/card2.jpg', false, 3387.8624381337754, '2020-09-11', '3e69253f-cfc4-44d4-8c96-8e04e1a27cae', 'No Highway');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (446, 'This is a description of Book Specimen Days', 25, '/assets/img/content/main/card2.jpg', true, 3912.232583462092, '2013-08-22', '209e88e6-52aa-481c-a75b-21fe3de2c83f', 'Specimen Days');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (447, 'This is a description of Book Wildfire at Midnight', 14, '/assets/img/content/main/card2.jpg', false, 1619.5451564928314, '2019-01-29', 'f4b6ea1e-0855-450d-808f-4b2f974641ad', 'Wildfire at Midnight');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (448, 'This is a description of Book To Say Nothing of the Dog', 32, '/assets/img/content/main/card2.jpg', false, 2269.0670905275206, '2021-06-28', 'db353b28-65ba-4da8-903b-e3cc71b28ddc', 'To Say Nothing of the Dog');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (449, 'This is a description of Book The Last Temptation', 8, '/assets/img/content/main/card2.jpg', false, 2343.3399327530246, '2020-01-25', 'e90f1338-44dd-4943-8967-f77952ad6495', 'The Last Temptation');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (450, 'This is a description of Book Recalled to Life', 11, '/assets/img/content/main/card2.jpg', false, 1578.0576114493651, '2020-08-16', 'da3e0902-7dfb-4f21-b50e-b8404052020a', 'Recalled to Life');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (451, 'This is a description of Book The Monkey''s Raincoat', 48, '/assets/img/content/main/card2.jpg', false, 3111.54066049117, '2022-04-21', '43b9f3e1-a80d-484f-8f8a-2430fb4c0f60', 'The Monkey''s Raincoat');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (452, 'This is a description of Book The Parliament of Man', 30, '/assets/img/content/main/card2.jpg', true, 3491.8895795742737, '2019-01-29', '14822923-631b-4611-886e-957e725e8319', 'The Parliament of Man');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (453, 'This is a description of Book Cabbages and Kings', 17, '/assets/img/content/main/card2.jpg', false, 148.7290866247749, '2014-05-01', 'ce21e489-b3c7-4364-b6d1-a847f018fbf9', 'Cabbages and Kings');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (454, 'This is a description of Book The Last Enemy', 19, '/assets/img/content/main/card2.jpg', true, 2115.1258658732245, '2016-04-06', '3663cc80-412a-463d-8409-e8082a891363', 'The Last Enemy');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (455, 'This is a description of Book Consider Phlebas', 44, '/assets/img/content/main/card2.jpg', true, 4445.05822077089, '2013-09-21', 'ce25efa3-1725-4610-b8a6-85cc4cb2b258', 'Consider Phlebas');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (456, 'This is a description of Book The Lathe of Heaven', 14, '/assets/img/content/main/card2.jpg', true, 1361.1157878675936, '2018-04-29', '9338f570-86c9-423b-8172-475e91dbb84c', 'The Lathe of Heaven');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (457, 'This is a description of Book A Monstrous Regiment of Women', 0, '/assets/img/content/main/card2.jpg', true, 4586.72899952727, '2015-11-10', 'b03d7da3-b85c-40bf-bbd7-69afbc88d066', 'A Monstrous Regiment of Women');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (458, 'This is a description of Book If Not Now, When?', 40, '/assets/img/content/main/card2.jpg', false, 4182.151460811992, '2015-03-06', '8eeb0fed-7e21-4e2d-80b9-e28ffebc365c', 'If Not Now, When?');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (459, 'This is a description of Book The Proper Study', 26, '/assets/img/content/main/card2.jpg', true, 590.847158504382, '2020-01-05', 'a286fd14-a07b-4a59-b7f5-33e4491bf4a7', 'The Proper Study');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (460, 'This is a description of Book The Yellow Meads of Asphodel', 17, '/assets/img/content/main/card2.jpg', false, 2434.993977004455, '2019-03-06', '9010b272-31c5-4a71-a644-64a5a6955a1e', 'The Yellow Meads of Asphodel');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (461, 'This is a description of Book This Side of Paradise', 41, '/assets/img/content/main/card2.jpg', true, 4673.784844015967, '2015-04-25', '22213922-2e5c-442e-b629-03dd55a643d3', 'This Side of Paradise');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (462, 'This is a description of Book The Wives of Bath', 19, '/assets/img/content/main/card2.jpg', true, 3589.0241506165016, '2020-02-15', '8b491399-de58-4e61-a26c-5e2d2a62d03e', 'The Wives of Bath');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (463, 'This is a description of Book Precious Bane', 4, '/assets/img/content/main/card2.jpg', true, 610.3785477574405, '2013-04-23', 'fa6a938f-8b21-48bf-b02c-389af7435965', 'Precious Bane');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (464, 'This is a description of Book Now Sleeps the Crimson Petal', 22, '/assets/img/content/main/card2.jpg', false, 2866.893526204983, '2015-01-22', '5e9ad97b-e395-4db8-8fb9-0acca06bbb39', 'Now Sleeps the Crimson Petal');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (465, 'This is a description of Book No Longer at Ease', 19, '/assets/img/content/main/card2.jpg', true, 3116.456037722228, '2022-01-19', '8420cba2-36a8-435e-b9e5-93a51ff9b426', 'No Longer at Ease');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (466, 'This is a description of Book Time of our Darkness', 5, '/assets/img/content/main/card2.jpg', true, 4271.869025066759, '2014-11-23', '2d851581-7330-4e49-b746-8a471defaa1d', 'Time of our Darkness');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (467, 'This is a description of Book Rosemary Sutcliff', 48, '/assets/img/content/main/card2.jpg', true, 3863.844035882054, '2017-07-18', '4217e8c4-81b0-40ba-9e40-d3c5797f44e2', 'Rosemary Sutcliff');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (468, 'This is a description of Book Jesting Pilate', 9, '/assets/img/content/main/card2.jpg', true, 335.2713796274519, '2022-10-06', 'ce3e52b8-c7ab-424d-8f00-723a3a2cc2f1', 'Jesting Pilate');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (469, 'This is a description of Book The Curious Incident of the Dog in the Night-Time', 15, '/assets/img/content/main/card2.jpg', true, 3103.8187757420433, '2019-08-13', 'fba3a54e-e053-4050-a871-5332bb37c061', 'The Curious Incident of the Dog in the Night-Time');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (470, 'This is a description of Book Blood''s a Rover', 19, '/assets/img/content/main/card2.jpg', true, 673.9301383351642, '2014-12-13', '43b5449d-e263-45a3-be34-4f4a129e551b', 'Blood''s a Rover');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (471, 'This is a description of Book No Longer at Ease', 25, '/assets/img/content/main/card2.jpg', true, 449.9359571141765, '2021-12-01', '086c282d-cbce-43c1-ae89-996759078cb6', 'No Longer at Ease');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (472, 'This is a description of Book A Catskill Eagle', 41, '/assets/img/content/main/card2.jpg', true, 2458.3276464631485, '2014-06-06', 'dd70f4c7-82ee-49a1-a725-40c2c8f698a3', 'A Catskill Eagle');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (473, 'This is a description of Book Fair Stood the Wind for France', 10, '/assets/img/content/main/card2.jpg', false, 2241.937072007901, '2019-11-19', '6af9bf14-449b-4f4e-b335-d4f3a4785350', 'Fair Stood the Wind for France');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (474, 'This is a description of Book Lilies of the Field', 15, '/assets/img/content/main/card2.jpg', true, 2925.7265271043048, '2017-07-28', 'e8878a86-7370-4408-b768-e9274f0465b6', 'Lilies of the Field');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (475, 'This is a description of Book Of Mice and Men', 3, '/assets/img/content/main/card2.jpg', false, 2673.4570480428256, '2021-04-05', 'bcfedf6f-6621-4b27-9eb1-10b9633eecf9', 'Of Mice and Men');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (476, 'This is a description of Book Wildfire at Midnight', 34, '/assets/img/content/main/card2.jpg', true, 2900.6996883178904, '2021-06-12', '6b8e966b-eefa-406a-befc-0bde29b37fd0', 'Wildfire at Midnight');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (477, 'This is a description of Book Terrible Swift Sword', 21, '/assets/img/content/main/card2.jpg', true, 4963.144466776713, '2013-08-27', 'e05300b0-f3d7-479f-b5d0-bac020b5133d', 'Terrible Swift Sword');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (478, 'This is a description of Book Bury My Heart at Wounded Knee', 4, '/assets/img/content/main/card2.jpg', true, 2006.9730193237056, '2018-03-01', 'dea58a45-7869-4543-b93f-56b3a6b6763b', 'Bury My Heart at Wounded Knee');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (479, 'This is a description of Book Postern of Fate', 41, '/assets/img/content/main/card2.jpg', true, 4151.500457784883, '2022-05-15', '9034f509-c714-41cd-a3d2-fcdb498789ba', 'Postern of Fate');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (480, 'This is a description of Book When the Green Woods Laugh', 4, '/assets/img/content/main/card2.jpg', true, 3561.697349283762, '2023-02-07', 'e4c22ca8-acbc-47db-952b-508921ca76ba', 'When the Green Woods Laugh');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (481, 'This is a description of Book Paths of Glory', 7, '/assets/img/content/main/card2.jpg', false, 1608.805315037878, '2022-02-09', 'c1a121a2-2549-4e6e-a322-4deafde27d9a', 'Paths of Glory');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (482, 'This is a description of Book East of Eden', 1, '/assets/img/content/main/card2.jpg', true, 2018.270930020742, '2014-04-27', '372ae653-d5d4-4061-b364-010f4266a384', 'East of Eden');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (483, 'This is a description of Book A Scanner Darkly', 14, '/assets/img/content/main/card2.jpg', false, 1624.351877429378, '2022-07-30', '4b772ab8-9044-4208-8a53-13943506ba6e', 'A Scanner Darkly');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (484, 'This is a description of Book Mother Night', 23, '/assets/img/content/main/card2.jpg', true, 3328.704053594692, '2018-04-20', 'bed79eab-9c53-456c-91f9-cc642ff54a14', 'Mother Night');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (485, 'This is a description of Book The Glory and the Dream', 8, '/assets/img/content/main/card2.jpg', true, 2187.370078329326, '2018-11-20', '3993def2-147b-43d1-8221-b385ae2e3d77', 'The Glory and the Dream');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (486, 'This is a description of Book In Dubious Battle', 32, '/assets/img/content/main/card2.jpg', true, 4968.555185676985, '2013-06-18', 'd7930db4-b6ad-41c4-8a97-0508fc474ee8', 'In Dubious Battle');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (487, 'This is a description of Book Blithe Spirit', 7, '/assets/img/content/main/card2.jpg', true, 177.39549630122232, '2022-04-12', '030222dd-1544-4911-8e99-92955b5343c8', 'Blithe Spirit');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (488, 'This is a description of Book No Country for Old Men', 32, '/assets/img/content/main/card2.jpg', true, 538.4593167633973, '2019-05-17', '8beed739-9eab-4c7c-bbcc-1246b4f70bce', 'No Country for Old Men');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (489, 'This is a description of Book Paths of Glory', 35, '/assets/img/content/main/card2.jpg', false, 2789.903300562949, '2020-03-14', 'a1e72186-8cda-42c5-9478-b81c56cbf6cb', 'Paths of Glory');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (490, 'This is a description of Book Everything is Illuminated', 35, '/assets/img/content/main/card2.jpg', false, 1193.7346145387244, '2017-05-05', '7491ce11-a20d-4506-b9be-746ac2e5df4e', 'Everything is Illuminated');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (491, 'This is a description of Book I Sing the Body Electric', 31, '/assets/img/content/main/card2.jpg', false, 4018.154126345676, '2018-07-07', 'a7a50717-a85c-4acf-be2d-ecd9214cdf15', 'I Sing the Body Electric');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (492, 'This is a description of Book After Many a Summer Dies the Swan', 29, '/assets/img/content/main/card2.jpg', true, 4087.997786424508, '2016-03-19', '78ad44d1-fa67-40d1-bff7-692795f64613', 'After Many a Summer Dies the Swan');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (493, 'This is a description of Book All Passion Spent', 34, '/assets/img/content/main/card2.jpg', true, 1341.8459558568059, '2013-11-08', '18b0f9b6-fdeb-402a-93c9-00a0e90a058e', 'All Passion Spent');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (494, 'This is a description of Book The Man Within', 3, '/assets/img/content/main/card2.jpg', true, 3775.881084912071, '2017-10-04', '79b088b4-136d-465a-8fbc-102073fd0ed6', 'The Man Within');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (495, 'This is a description of Book The Wealth of Nations', 46, '/assets/img/content/main/card2.jpg', true, 2605.1612171431084, '2019-06-05', '2a965dc2-fb1d-4092-81fc-41a0964cb2a2', 'The Wealth of Nations');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (496, 'This is a description of Book Postern of Fate', 25, '/assets/img/content/main/card2.jpg', false, 3181.0482484464706, '2019-03-31', 'fa02cffc-86fd-4cec-80bf-f790e52002a7', 'Postern of Fate');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (497, 'This is a description of Book The Man Within', 23, '/assets/img/content/main/card2.jpg', false, 1399.57561470392, '2016-03-01', '834b7047-f279-41fe-8e62-7d36893399c6', 'The Man Within');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (498, 'This is a description of Book Paths of Glory', 42, '/assets/img/content/main/card2.jpg', true, 3009.7108694128874, '2022-04-18', '7e062ee7-198a-4126-8fd2-fc3ec4aec30a', 'Paths of Glory');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (499, 'This is a description of Book The Moving Toyshop', 49, '/assets/img/content/main/card2.jpg', true, 709.648618540427, '2014-06-05', '02a5a60e-64c5-43ac-b6f9-c0d98e65660d', 'The Moving Toyshop');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (500, 'This is a description of Book Endless Night', 28, '/assets/img/content/main/card2.jpg', false, 1730.6931057248312, '2018-09-21', 'a65e02fc-633e-4156-9a3d-0accc4285454', 'Endless Night');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (501, 'This is a description of Book Blithe Spirit', 12, '/assets/img/content/main/card2.jpg', false, 2678.348382049788, '2023-01-03', '40befc22-0c08-42ba-8ac4-e650f874e023', 'Blithe Spirit');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (502, 'This is a description of Book A Glass of Blessings', 12, '/assets/img/content/main/card2.jpg', false, 4109.95805804977, '2021-09-04', '4bb0e29b-e790-4c8c-9140-0ddb2efa5f46', 'A Glass of Blessings');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (503, 'This is a description of Book This Side of Paradise', 7, '/assets/img/content/main/card2.jpg', false, 1441.0388292531056, '2020-04-12', 'a373d399-fa8d-49f7-a6ca-ac2e2d19d7a3', 'This Side of Paradise');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (504, 'This is a description of Book Vile Bodies', 16, '/assets/img/content/main/card2.jpg', true, 2797.05465588852, '2022-12-26', 'da21dd6a-2f40-4fd5-a965-4618496a4fa2', 'Vile Bodies');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (505, 'This is a description of Book The Wealth of Nations', 40, '/assets/img/content/main/card2.jpg', false, 266.44581914869656, '2023-02-15', '680b14a8-9669-4106-acea-75b40684cf70', 'The Wealth of Nations');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (506, 'This is a description of Book Noli Me Tangere', 28, '/assets/img/content/main/card2.jpg', false, 2453.5650384194237, '2018-12-04', 'd039ef88-82e2-4e07-b0e7-c4d7e98fa5b4', 'Noli Me Tangere');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (507, 'This is a description of Book Mother Night', 47, '/assets/img/content/main/card2.jpg', false, 1871.9541038168427, '2013-09-11', '0a789a51-7810-4caf-ba87-ede7f5a64e54', 'Mother Night');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (508, 'This is a description of Book Antic Hay', 26, '/assets/img/content/main/card2.jpg', true, 4561.709065690648, '2017-10-01', '742e551d-cead-4c72-8b4e-140fb5e3bfd5', 'Antic Hay');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (509, 'This is a description of Book The Green Bay Tree', 14, '/assets/img/content/main/card2.jpg', false, 955.8080686195168, '2020-08-15', '03cd2148-4688-4438-904c-cee29a2fcbb7', 'The Green Bay Tree');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (510, 'This is a description of Book The Wives of Bath', 25, '/assets/img/content/main/card2.jpg', true, 3188.4090066515387, '2019-02-28', 'e7cd1dcc-1f55-4573-9c13-a84b21096e19', 'The Wives of Bath');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (511, 'This is a description of Book A Farewell to Arms', 37, '/assets/img/content/main/card2.jpg', true, 3041.897172107624, '2022-02-18', 'ac1df60d-a870-4123-abdc-a7bee2cb255c', 'A Farewell to Arms');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (512, 'This is a description of Book Jesting Pilate', 35, '/assets/img/content/main/card2.jpg', true, 771.4322591241682, '2014-10-08', '82869aaa-dde3-421d-9d41-e66a23b1f7b5', 'Jesting Pilate');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (513, 'This is a description of Book I Will Fear No Evil', 32, '/assets/img/content/main/card2.jpg', false, 1253.1111599679275, '2023-02-13', '6227088a-090d-4811-8c8b-cc16f7bfeb09', 'I Will Fear No Evil');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (514, 'This is a description of Book Frequent Hearses', 6, '/assets/img/content/main/card2.jpg', false, 3006.546168114426, '2016-02-24', '4a05178b-e157-486a-8f52-ed5a391e6b01', 'Frequent Hearses');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (515, 'This is a description of Book What''s Become of Waring', 0, '/assets/img/content/main/card2.jpg', true, 883.9194591329699, '2022-07-30', '223ac8b8-7039-4ef7-9e88-55976b49eff5', 'What''s Become of Waring');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (516, 'This is a description of Book Dulce et Decorum Est', 50, '/assets/img/content/main/card2.jpg', true, 575.7540074133126, '2017-10-16', '5884da3e-74d5-4119-aac8-d34d9d8634c6', 'Dulce et Decorum Est');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (517, 'This is a description of Book Blood''s a Rover', 12, '/assets/img/content/main/card2.jpg', false, 3747.141980685956, '2015-05-10', 'e4a9bd7d-1963-4ad3-a6e8-e40f12b70c1b', 'Blood''s a Rover');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (518, 'This is a description of Book The Soldier''s Art', 42, '/assets/img/content/main/card2.jpg', true, 660.686731999894, '2018-07-16', '6fab89ce-5d7e-4f5f-aa5d-729b88013393', 'The Soldier''s Art');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (519, 'This is a description of Book Stranger in a Strange Land', 16, '/assets/img/content/main/card2.jpg', false, 3684.4725752878826, '2013-09-12', 'a187c513-c77f-4bfa-b1ba-238301ff7dae', 'Stranger in a Strange Land');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (520, 'This is a description of Book The Golden Apples of the Sun', 44, '/assets/img/content/main/card2.jpg', false, 4959.63732898878, '2013-10-11', '0ba76a48-25dc-4181-aade-1c2ec8e893dd', 'The Golden Apples of the Sun');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (521, 'This is a description of Book An Instant In The Wind', 25, '/assets/img/content/main/card2.jpg', false, 932.4386558664486, '2021-06-17', '88f9c719-76eb-4199-b14d-9ee5d93b8b44', 'An Instant In The Wind');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (522, 'This is a description of Book Dying of the Light', 7, '/assets/img/content/main/card2.jpg', true, 3766.8139995509873, '2015-11-04', '0433459a-dc25-4ac0-851d-a3f2882b4a2b', 'Dying of the Light');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (523, 'This is a description of Book Mr Standfast', 18, '/assets/img/content/main/card2.jpg', false, 873.2374800778024, '2016-01-19', 'ee5b24b0-6d31-4e77-b7d8-2c2a75e24c05', 'Mr Standfast');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (524, 'This is a description of Book The Little Foxes', 48, '/assets/img/content/main/card2.jpg', false, 3085.409877833567, '2021-07-01', 'ffa0623b-0108-4d5d-b2af-f5149c17ee65', 'The Little Foxes');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (525, 'This is a description of Book Specimen Days', 47, '/assets/img/content/main/card2.jpg', true, 4129.497087168983, '2014-10-14', 'a1023481-cb4c-4350-b071-7cced017cfde', 'Specimen Days');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (526, 'This is a description of Book Beyond the Mexique Bay', 27, '/assets/img/content/main/card2.jpg', false, 392.52979050825786, '2019-10-19', 'a96b671e-e377-4889-b8e0-2dbd093b7887', 'Beyond the Mexique Bay');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (527, 'This is a description of Book O Pioneers!', 37, '/assets/img/content/main/card2.jpg', true, 4150.043105348309, '2013-08-02', '21368b20-b477-4e1d-a327-8c6dbc830738', 'O Pioneers!');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (528, 'This is a description of Book Clouds of Witness', 39, '/assets/img/content/main/card2.jpg', false, 2861.852318963422, '2017-06-16', '3a9d8df2-1515-4618-82ea-3da5f9a579e0', 'Clouds of Witness');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (529, 'This is a description of Book A Time of Gifts', 6, '/assets/img/content/main/card2.jpg', true, 3030.396159453052, '2013-07-19', '763fb53a-e975-4ff5-a7d6-46dcb0d4df63', 'A Time of Gifts');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (530, 'This is a description of Book To Say Nothing of the Dog', 23, '/assets/img/content/main/card2.jpg', false, 1654.8461482365456, '2015-03-08', '39707fae-47f2-457c-b6e0-4849590540fd', 'To Say Nothing of the Dog');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (531, 'This is a description of Book A Passage to India', 40, '/assets/img/content/main/card2.jpg', true, 2886.022356478007, '2015-12-07', 'b2417a51-6ef1-459d-ae75-812d5235d428', 'A Passage to India');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (532, 'This is a description of Book I Sing the Body Electric', 35, '/assets/img/content/main/card2.jpg', false, 3181.095760370705, '2020-05-20', 'bb999ac2-292e-4833-ae4d-9281d8965da4', 'I Sing the Body Electric');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (533, 'This is a description of Book If I Forget Thee Jerusalem', 43, '/assets/img/content/main/card2.jpg', true, 4773.464631571725, '2019-11-18', '07d88be6-e8da-4009-be6c-5b88856a4b44', 'If I Forget Thee Jerusalem');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (534, 'This is a description of Book The Cricket on the Hearth', 46, '/assets/img/content/main/card2.jpg', true, 2785.749708913409, '2017-02-05', '55215311-ea08-47a9-b6cd-1fe7cb6a8de1', 'The Cricket on the Hearth');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (535, 'This is a description of Book Brandy of the Damned', 50, '/assets/img/content/main/card2.jpg', false, 1686.9082934261412, '2017-11-30', '44aeadfc-31ad-4af5-a4d4-e38fdd69a2a9', 'Brandy of the Damned');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (536, 'This is a description of Book Gone with the Wind', 26, '/assets/img/content/main/card2.jpg', true, 3437.6961303654903, '2017-03-31', '8f24d39f-f0e3-4e82-9bf3-9352ef6654e7', 'Gone with the Wind');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (537, 'This is a description of Book Pale Kings and Princes', 29, '/assets/img/content/main/card2.jpg', true, 5079.601985591688, '2021-11-01', 'ce110971-a3b0-4c84-ab4a-d95c276c976f', 'Pale Kings and Princes');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (538, 'This is a description of Book Those Barren Leaves, Thrones, Dominations', 11, '/assets/img/content/main/card2.jpg', true, 2592.9403155726195, '2022-04-02', 'd057213b-6a77-42b2-9458-12289ba187aa', 'Those Barren Leaves, Thrones, Dominations');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (539, 'This is a description of Book All the King''s Men', 36, '/assets/img/content/main/card2.jpg', false, 1039.846925625599, '2020-12-07', '86670621-abef-4b68-b28e-54d1891b8023', 'All the King''s Men');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (540, 'This is a description of Book Have His Carcase', 28, '/assets/img/content/main/card2.jpg', true, 2032.9379606647, '2015-08-20', '529dc27b-9352-479d-8f62-9598f3a2f047', 'Have His Carcase');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (541, 'This is a description of Book Tirra Lirra by the River', 41, '/assets/img/content/main/card2.jpg', false, 1596.073516222613, '2015-11-17', 'c6327ec7-5a96-41e1-bb8b-8b783c24ad4e', 'Tirra Lirra by the River');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (542, 'This is a description of Book A Darkling Plain', 35, '/assets/img/content/main/card2.jpg', true, 3704.6894031502156, '2021-10-28', 'e4a1ca40-18c8-47f4-869f-645cfe0b3b94', 'A Darkling Plain');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (543, 'This is a description of Book Great Work of Time', 24, '/assets/img/content/main/card2.jpg', false, 3345.2954378443965, '2018-06-19', '57b76666-97e1-400a-8ff9-d9fdc352e5d6', 'Great Work of Time');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (544, 'This is a description of Book Noli Me Tangere', 31, '/assets/img/content/main/card2.jpg', true, 945.0733545322546, '2019-01-20', '76a07a5b-70bd-4d91-85e2-e3de11982449', 'Noli Me Tangere');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (545, 'This is a description of Book Time of our Darkness', 50, '/assets/img/content/main/card2.jpg', false, 238.0267003048743, '2019-06-24', 'a3aeb12a-47b1-47bd-b507-c0129c128bb6', 'Time of our Darkness');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (546, 'This is a description of Book Far From the Madding Crowd', 35, '/assets/img/content/main/card2.jpg', false, 1285.7763760211708, '2017-06-29', 'dda71b2f-7c4b-4936-bfe5-2c2bf7fff08b', 'Far From the Madding Crowd');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (547, 'This is a description of Book I Know Why the Caged Bird Sings', 25, '/assets/img/content/main/card2.jpg', false, 2633.485797425289, '2017-09-27', 'f4726122-a214-4382-b7a3-af7715e7e786', 'I Know Why the Caged Bird Sings');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (548, 'This is a description of Book Antic Hay', 16, '/assets/img/content/main/card2.jpg', true, 3455.823991110197, '2020-01-27', '925cd05e-0a2d-407e-9a42-346170e99aef', 'Antic Hay');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (549, 'This is a description of Book Fame Is the Spur', 40, '/assets/img/content/main/card2.jpg', false, 4330.62139419387, '2017-12-21', '05d2723e-8521-422d-9a22-f0c663fc8424', 'Fame Is the Spur');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (550, 'This is a description of Book If I Forget Thee Jerusalem', 42, '/assets/img/content/main/card2.jpg', true, 2559.942644573596, '2015-10-21', '32c485af-7285-4d8b-b929-f961399c96f3', 'If I Forget Thee Jerusalem');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (551, 'This is a description of Book Blithe Spirit', 0, '/assets/img/content/main/card2.jpg', true, 2420.5635749359026, '2019-06-24', '3e4c971e-b4e4-481b-9cb1-2eb0e8779961', 'Blithe Spirit');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (552, 'This is a description of Book The Monkey''s Raincoat', 6, '/assets/img/content/main/card2.jpg', true, 4482.064835797331, '2023-02-15', '0a5948e5-2ef4-4f1c-9587-7bd3dc1b15fa', 'The Monkey''s Raincoat');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (553, 'This is a description of Book Those Barren Leaves, Thrones, Dominations', 29, '/assets/img/content/main/card2.jpg', false, 1247.5306640167382, '2019-04-04', 'e155efd2-596a-4408-886a-492686b1dfa2', 'Those Barren Leaves, Thrones, Dominations');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (554, 'This is a description of Book Nectar in a Sieve', 38, '/assets/img/content/main/card2.jpg', false, 4375.253183306785, '2020-05-12', '6aa22fa9-372f-48e1-a025-ba66d05f69ac', 'Nectar in a Sieve');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (555, 'This is a description of Book The Line of Beauty', 22, '/assets/img/content/main/card2.jpg', true, 2123.8604445718634, '2022-09-13', 'c06b221b-7eaf-494e-bef8-933afa5875bb', 'The Line of Beauty');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (556, 'This is a description of Book Stranger in a Strange Land', 47, '/assets/img/content/main/card2.jpg', false, 3077.1677982822725, '2019-07-05', '4721ecd4-cdaf-4fc3-888a-ce79820fc6f1', 'Stranger in a Strange Land');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (557, 'This is a description of Book Blood''s a Rover', 17, '/assets/img/content/main/card2.jpg', true, 4838.652062477087, '2019-01-11', '591e46b6-ec94-4c8d-9b1e-2b05b59e02b7', 'Blood''s a Rover');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (558, 'This is a description of Book To a God Unknown', 25, '/assets/img/content/main/card2.jpg', false, 1640.1744172411018, '2019-11-15', 'defce98f-5029-4761-a6ed-8ff3b8c3f564', 'To a God Unknown');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (559, 'This is a description of Book Quo Vadis', 9, '/assets/img/content/main/card2.jpg', true, 1093.8262121095859, '2016-09-17', '6f90ba3b-112e-4a90-bab1-5d795284852f', 'Quo Vadis');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (560, 'This is a description of Book Unweaving the Rainbow', 3, '/assets/img/content/main/card2.jpg', false, 4082.0118991383124, '2019-03-12', 'e81ee834-86fa-4197-bcd6-eb6dd9443af8', 'Unweaving the Rainbow');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (561, 'This is a description of Book Precious Bane', 37, '/assets/img/content/main/card2.jpg', false, 4969.170923001355, '2020-03-08', '0447492f-8eae-4916-8129-8d2c49186ef4', 'Precious Bane');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (562, 'This is a description of Book The Painted Veil', 3, '/assets/img/content/main/card2.jpg', true, 4647.0649398169635, '2017-07-15', '556a8dac-3c8a-4c4d-aa29-cde8be5dacd5', 'The Painted Veil');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (563, 'This is a description of Book Clouds of Witness', 19, '/assets/img/content/main/card2.jpg', false, 1601.932351959453, '2013-06-03', 'b364e5d8-e863-47f9-8537-1eb1e20e4df3', 'Clouds of Witness');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (564, 'This is a description of Book The Green Bay Tree', 13, '/assets/img/content/main/card2.jpg', false, 4714.16357665721, '2014-05-28', '6647fb90-4d8b-48e6-a688-742ae770d1cd', 'The Green Bay Tree');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (565, 'This is a description of Book Noli Me Tangere', 21, '/assets/img/content/main/card2.jpg', false, 4197.637750089711, '2019-08-13', '5aeb6f1b-290b-46c0-8a49-b6e6d79c45c4', 'Noli Me Tangere');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (566, 'This is a description of Book Antic Hay', 22, '/assets/img/content/main/card2.jpg', false, 3628.132010107336, '2019-08-28', '4e2f0ee7-d08c-4626-b078-4f1261a85a51', 'Antic Hay');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (567, 'This is a description of Book Little Hands Clapping', 5, '/assets/img/content/main/card2.jpg', false, 2826.363917064718, '2019-11-30', 'c7ef7492-fc2b-4f3e-84cf-256d314760de', 'Little Hands Clapping');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (568, 'This is a description of Book Postern of Fate', 39, '/assets/img/content/main/card2.jpg', true, 803.1965859751687, '2016-09-28', '241cea30-1263-4d92-b366-50f13c3e391e', 'Postern of Fate');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (569, 'This is a description of Book For a Breath I Tarry', 38, '/assets/img/content/main/card2.jpg', true, 1584.4610427418493, '2013-08-18', '83fb0ecb-d3bd-4c6d-8547-878b81cf84a6', 'For a Breath I Tarry');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (570, 'This is a description of Book Ah, Wilderness!', 42, '/assets/img/content/main/card2.jpg', false, 4895.731972532062, '2015-09-04', 'b94ace09-bcb6-4aaf-98c4-5f03212ae851', 'Ah, Wilderness!');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (571, 'This is a description of Book A Handful of Dust', 29, '/assets/img/content/main/card2.jpg', false, 3937.5403188577416, '2013-04-22', 'a1614991-4fb5-4f05-aadb-14ba0f798cca', 'A Handful of Dust');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (572, 'This is a description of Book A Confederacy of Dunces', 48, '/assets/img/content/main/card2.jpg', false, 1448.5555124525094, '2022-10-02', '8f67292c-2e8b-4b2f-8a73-6617f393b45c', 'A Confederacy of Dunces');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (573, 'This is a description of Book Antic Hay', 39, '/assets/img/content/main/card2.jpg', true, 2316.174895087982, '2017-01-15', '2e3913d2-a94e-428f-b63e-0aaaae8ec6d7', 'Antic Hay');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (574, 'This is a description of Book A Passage to India', 13, '/assets/img/content/main/card2.jpg', false, 2436.186687895763, '2022-01-24', '5863b3b7-d23e-4bc1-ad00-e7b7e2dd8863', 'A Passage to India');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (575, 'This is a description of Book Tender Is the Night', 10, '/assets/img/content/main/card2.jpg', true, 4855.447856436708, '2016-08-11', 'b317dff8-3b61-4d1d-9e61-ff55c1547280', 'Tender Is the Night');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (576, 'This is a description of Book Wildfire at Midnight', 41, '/assets/img/content/main/card2.jpg', false, 4133.770242094533, '2020-08-23', 'df15af85-2c8c-4e28-8d68-2ae4f5d5b376', 'Wildfire at Midnight');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (577, 'This is a description of Book A Handful of Dust', 24, '/assets/img/content/main/card2.jpg', false, 3715.0174769243613, '2019-07-27', 'beef9ebc-ac5d-4024-ba5d-488a224519f7', 'A Handful of Dust');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (578, 'This is a description of Book As I Lay Dying', 17, '/assets/img/content/main/card2.jpg', false, 415.0507595652156, '2021-05-06', '07c7ccfd-30b6-4342-a246-00bca7d01e19', 'As I Lay Dying');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (579, 'This is a description of Book Many Waters', 49, '/assets/img/content/main/card2.jpg', true, 601.4280077813007, '2014-10-28', '57e51c56-745d-458c-bd11-eec7f33c7a3e', 'Many Waters');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (580, 'This is a description of Book Great Work of Time', 13, '/assets/img/content/main/card2.jpg', false, 1952.2008015928873, '2018-05-27', '7c16cd57-bb56-4382-b1b9-9c63bf58815e', 'Great Work of Time');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (581, 'This is a description of Book Bury My Heart at Wounded Knee', 9, '/assets/img/content/main/card2.jpg', false, 1049.7520039291774, '2013-05-03', '83b029ac-e344-48a3-8ccb-79419c740f85', 'Bury My Heart at Wounded Knee');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (582, 'This is a description of Book Fair Stood the Wind for France', 38, '/assets/img/content/main/card2.jpg', true, 714.9957841042375, '2017-01-13', 'db10d830-e33c-4d89-a459-7255b635c7aa', 'Fair Stood the Wind for France');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (583, 'This is a description of Book Edna O''Brien', 7, '/assets/img/content/main/card2.jpg', true, 739.4453781005159, '2017-03-30', 'f6bb4136-fdd3-4c8f-9412-9b387a681b52', 'Edna O''Brien');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (584, 'This is a description of Book To Your Scattered Bodies Go', 1, '/assets/img/content/main/card2.jpg', false, 3818.83280139554, '2016-08-20', '70a4d5a0-71f7-4454-bff9-d6721c4d20e4', 'To Your Scattered Bodies Go');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (585, 'This is a description of Book Recalled to Life', 1, '/assets/img/content/main/card2.jpg', false, 2318.2760657499916, '2017-09-03', 'e71f4d72-d8de-4ced-b6ab-829ad25335dd', 'Recalled to Life');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (586, 'This is a description of Book Beneath the Bleeding', 21, '/assets/img/content/main/card2.jpg', false, 1787.1780509194493, '2018-02-02', '3e1575a7-1d67-4186-bd10-a6e4e24b094d', 'Beneath the Bleeding');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (587, 'This is a description of Book If I Forget Thee Jerusalem', 48, '/assets/img/content/main/card2.jpg', true, 2406.957833505137, '2015-07-14', 'ef778437-103c-45f0-ae84-ceee7b427cb5', 'If I Forget Thee Jerusalem');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (588, 'This is a description of Book The Wives of Bath', 8, '/assets/img/content/main/card2.jpg', true, 3941.9532851123818, '2015-06-18', 'e10945e4-d32e-409f-ac9e-296b18ec23e4', 'The Wives of Bath');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (589, 'This is a description of Book Some Buried Caesar', 39, '/assets/img/content/main/card2.jpg', false, 2986.3981873300627, '2015-07-27', '8a74c0cf-79f0-4767-84ca-5a704e275c70', 'Some Buried Caesar');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (590, 'This is a description of Book The Last Enemy', 43, '/assets/img/content/main/card2.jpg', true, 2343.125060513301, '2013-11-01', '47cbf52d-0b6d-42d5-9b5c-1748b69af0d7', 'The Last Enemy');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (591, 'This is a description of Book Ah, Wilderness!', 19, '/assets/img/content/main/card2.jpg', true, 131.32873064623837, '2022-03-20', '0e2b7b32-e3ab-4110-a6a2-3310e750a8bb', 'Ah, Wilderness!');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (592, 'This is a description of Book A Catskill Eagle', 2, '/assets/img/content/main/card2.jpg', true, 2349.815109082137, '2020-07-17', '45c72d19-ba3e-42fe-ae36-7e5fb31e7ef6', 'A Catskill Eagle');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (593, 'This is a description of Book A Handful of Dust', 43, '/assets/img/content/main/card2.jpg', false, 1440.2122575346955, '2019-06-24', '40761a06-f65c-4511-bd45-a314e86120d1', 'A Handful of Dust');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (594, 'This is a description of Book The Cricket on the Hearth', 7, '/assets/img/content/main/card2.jpg', true, 2627.8139271921477, '2014-02-25', '3fafd998-a871-472b-bcb0-98f3f901e6c2', 'The Cricket on the Hearth');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (595, 'This is a description of Book Death Be Not Proud', 28, '/assets/img/content/main/card2.jpg', false, 4205.257286398512, '2014-09-12', '7ae60a05-4d1f-4ab3-a135-d0d7299f8fe1', 'Death Be Not Proud');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (596, 'This is a description of Book The Wind''s Twelve Quarters', 31, '/assets/img/content/main/card2.jpg', false, 4679.645046215399, '2017-06-02', '090980f9-f67c-488a-ac71-9da928013b03', 'The Wind''s Twelve Quarters');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (597, 'This is a description of Book Gone with the Wind', 14, '/assets/img/content/main/card2.jpg', true, 4404.770965907936, '2015-10-19', '885bc82e-2baa-49ef-afc0-a3f0e55df786', 'Gone with the Wind');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (598, 'This is a description of Book It''s a Battlefield', 31, '/assets/img/content/main/card2.jpg', false, 3605.7211760351865, '2014-04-17', 'e136952d-84fe-42d2-9e69-6a12aa820e15', 'It''s a Battlefield');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (599, 'This is a description of Book In Dubious Battle', 46, '/assets/img/content/main/card2.jpg', true, 1612.958013694156, '2021-06-25', '832ba920-9a87-4632-9245-a14d024cd00f', 'In Dubious Battle');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (600, 'This is a description of Book The Wives of Bath', 47, '/assets/img/content/main/card2.jpg', true, 3917.566628362647, '2017-12-15', '7376aa12-0bff-463e-b080-ae92291eec8d', 'The Wives of Bath');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (601, 'This is a description of Book Recalled to Life', 33, '/assets/img/content/main/card2.jpg', true, 1854.2486470790825, '2019-06-25', '608c0b0d-b4f1-4bcb-9e1a-2095648fb3c4', 'Recalled to Life');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (602, 'This is a description of Book Where Angels Fear to Tread', 21, '/assets/img/content/main/card2.jpg', true, 3664.1986401544577, '2018-10-23', '19f7a33a-fb9f-4616-b433-6052fc700490', 'Where Angels Fear to Tread');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (603, 'This is a description of Book Of Mice and Men', 6, '/assets/img/content/main/card2.jpg', true, 3853.793783284257, '2016-09-22', '7d4cff7f-bd68-46a6-9662-8d11c44698c8', 'Of Mice and Men');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (604, 'This is a description of Book For Whom the Bell Tolls', 30, '/assets/img/content/main/card2.jpg', false, 1585.1933122844569, '2017-06-01', '09624c60-01ef-417d-b552-a15875ef2f15', 'For Whom the Bell Tolls');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (605, 'This is a description of Book Moab Is My Washpot', 12, '/assets/img/content/main/card2.jpg', true, 1517.4919397288318, '2013-08-13', '634da858-9f04-4c8c-9c56-4f33b3079b2d', 'Moab Is My Washpot');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (606, 'This is a description of Book No Country for Old Men', 39, '/assets/img/content/main/card2.jpg', false, 2894.5741097270534, '2022-11-21', 'c474441d-47be-4427-bcbe-4dad26cd53a9', 'No Country for Old Men');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (607, 'This is a description of Book Let Us Now Praise Famous Men', 28, '/assets/img/content/main/card2.jpg', true, 700.7594530480782, '2018-09-02', 'f2904482-49a6-4b0b-b01f-bf789a05f8fc', 'Let Us Now Praise Famous Men');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (608, 'This is a description of Book To Your Scattered Bodies Go', 3, '/assets/img/content/main/card2.jpg', true, 2238.800873871702, '2017-08-08', '92eb0da3-0657-4ba7-9408-c452658563ae', 'To Your Scattered Bodies Go');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (609, 'This is a description of Book Beneath the Bleeding', 35, '/assets/img/content/main/card2.jpg', true, 604.7834247259271, '2018-06-04', 'b7535fda-6be7-4512-83db-99aba1758aa5', 'Beneath the Bleeding');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (610, 'This is a description of Book The Painted Veil', 50, '/assets/img/content/main/card2.jpg', false, 3965.888078585604, '2018-10-09', '68230e6a-27b7-4a8a-a98c-f77b486b7c11', 'The Painted Veil');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (611, 'This is a description of Book Ego Dominus Tuus', 14, '/assets/img/content/main/card2.jpg', true, 731.6241402564013, '2016-01-24', '3bd1ded8-28d0-446f-84ab-7e8932fdc1de', 'Ego Dominus Tuus');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (612, 'This is a description of Book Dance Dance Dance', 16, '/assets/img/content/main/card2.jpg', true, 498.110006050015, '2021-04-18', 'a11ea435-6855-463f-b391-edcf8885efcd', 'Dance Dance Dance');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (613, 'This is a description of Book Tiger! Tiger!', 49, '/assets/img/content/main/card2.jpg', false, 601.7889153696235, '2014-04-20', '137ee734-93cf-4adc-acec-71ae63d5e301', 'Tiger! Tiger!');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (614, 'This is a description of Book The Widening Gyre', 17, '/assets/img/content/main/card2.jpg', true, 3939.1593807840486, '2022-04-28', '8475a09d-53fc-4758-8bab-99a491c84d6e', 'The Widening Gyre');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (615, 'This is a description of Book The Lathe of Heaven', 12, '/assets/img/content/main/card2.jpg', true, 808.670094272314, '2017-04-28', 'cd9f8231-d671-4bc7-8914-df30d90b01e1', 'The Lathe of Heaven');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (616, 'This is a description of Book Where Angels Fear to Tread', 31, '/assets/img/content/main/card2.jpg', false, 4463.800916285103, '2019-06-08', '2d673f90-a676-4aaf-b0e6-a735e9b17601', 'Where Angels Fear to Tread');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (617, 'This is a description of Book The Far-Distant Oxus', 30, '/assets/img/content/main/card2.jpg', true, 4794.0233298183175, '2016-06-05', '6a97b3bf-b231-4cb4-a755-8c1951480fb0', 'The Far-Distant Oxus');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (618, 'This is a description of Book No Longer at Ease', 42, '/assets/img/content/main/card2.jpg', false, 3402.5227035653847, '2014-08-01', 'd6519037-9fa4-4f92-8831-4f639d150230', 'No Longer at Ease');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (619, 'This is a description of Book A Handful of Dust', 40, '/assets/img/content/main/card2.jpg', true, 4755.814760462181, '2018-09-09', 'c36e14e2-228e-44e0-98f2-f92fa9af5eb4', 'A Handful of Dust');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (620, 'This is a description of Book Gone with the Wind', 35, '/assets/img/content/main/card2.jpg', true, 2678.9412892175947, '2022-02-24', '63d6f0d1-196c-4754-af67-3b6e0f5ce0c3', 'Gone with the Wind');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (621, 'This is a description of Book For a Breath I Tarry', 28, '/assets/img/content/main/card2.jpg', false, 1335.7530841939304, '2014-06-30', '7c9d8e40-3273-4ec7-885d-c3dea7007f14', 'For a Breath I Tarry');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (622, 'This is a description of Book Carrion Comfort', 16, '/assets/img/content/main/card2.jpg', true, 5053.499909747122, '2022-11-03', '213b7d71-4e16-434f-915f-f728e87467f8', 'Carrion Comfort');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (623, 'This is a description of Book The Stars'' Tennis Balls', 41, '/assets/img/content/main/card2.jpg', true, 4214.470008475046, '2015-12-28', 'a52b1415-9db0-4759-b2db-27633e0b5758', 'The Stars'' Tennis Balls');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (624, 'This is a description of Book The Millstone', 33, '/assets/img/content/main/card2.jpg', false, 268.5373011564735, '2014-04-19', '2394afc6-cfad-44df-8757-8bbb20959355', 'The Millstone');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (625, 'This is a description of Book Blood''s a Rover', 9, '/assets/img/content/main/card2.jpg', true, 1964.0547022750889, '2016-09-09', 'd7770eff-6238-4baa-8efa-2dff2d4944eb', 'Blood''s a Rover');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (626, 'This is a description of Book That Good Night', 46, '/assets/img/content/main/card2.jpg', false, 4194.054796612262, '2016-12-13', 'e46f5fea-d056-47d5-92f8-9df925ac79c9', 'That Good Night');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (627, 'This is a description of Book Blood''s a Rover', 44, '/assets/img/content/main/card2.jpg', false, 4884.778631258894, '2014-11-29', '8e264ee6-a760-45ba-ba76-f457eb3ee75b', 'Blood''s a Rover');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (628, 'This is a description of Book Noli Me Tangere', 32, '/assets/img/content/main/card2.jpg', true, 606.4144426558148, '2013-09-04', 'b278ff35-2d03-4c7f-8f23-33435aa181e6', 'Noli Me Tangere');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (629, 'This is a description of Book The Daffodil Sky', 42, '/assets/img/content/main/card2.jpg', false, 2508.7698456646226, '2019-07-04', '932e9a11-5a25-401b-a772-cd7d2b4919bc', 'The Daffodil Sky');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (630, 'This is a description of Book The Millstone', 17, '/assets/img/content/main/card2.jpg', true, 1326.9373646725046, '2018-11-09', 'a9749e8e-3357-4995-a193-0c484553788f', 'The Millstone');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (631, 'This is a description of Book Sleep the Brave', 44, '/assets/img/content/main/card2.jpg', false, 4396.8731039504855, '2018-02-08', '4fccfabe-9d4d-49bc-b160-f9f29c0b243d', 'Sleep the Brave');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (632, 'This is a description of Book Those Barren Leaves, Thrones, Dominations', 37, '/assets/img/content/main/card2.jpg', true, 1917.6007262599937, '2020-11-24', '14197e71-1891-4e85-9dd0-974d31497e5d', 'Those Barren Leaves, Thrones, Dominations');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (633, 'This is a description of Book Shall not Perish', 27, '/assets/img/content/main/card2.jpg', false, 3183.336226138021, '2013-03-15', '91121658-95c8-4c7c-824e-01f499507f22', 'Shall not Perish');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (634, 'This is a description of Book The Torment of Others', 26, '/assets/img/content/main/card2.jpg', false, 4973.148864639356, '2016-09-21', '97b17464-71a9-4a9b-83de-b48e5edb026e', 'The Torment of Others');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (635, 'This is a description of Book Vanity Fair', 5, '/assets/img/content/main/card2.jpg', false, 2300.5252239975284, '2021-09-21', '1f69d1bb-d7e1-4257-bbf8-8725b51ab69a', 'Vanity Fair');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (636, 'This is a description of Book The Far-Distant Oxus', 48, '/assets/img/content/main/card2.jpg', false, 1835.3194267013344, '2019-06-28', 'd0eba91b-dc76-47ad-aa6e-04d052c05dc2', 'The Far-Distant Oxus');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (637, 'This is a description of Book As I Lay Dying', 4, '/assets/img/content/main/card2.jpg', false, 1133.9318695492855, '2020-12-19', '7bd0c3fe-2ad5-4ff5-b43f-73a57cb8b736', 'As I Lay Dying');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (638, 'This is a description of Book What''s Become of Waring', 12, '/assets/img/content/main/card2.jpg', true, 856.1528357899826, '2017-11-21', 'afdab7fc-1a7a-4ea1-ab09-83212a5041ea', 'What''s Become of Waring');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (639, 'This is a description of Book The Sun Also Rises', 38, '/assets/img/content/main/card2.jpg', true, 502.9976377382573, '2021-11-10', '05d1cd87-6d03-4fd1-9c72-201177f4b362', 'The Sun Also Rises');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (640, 'This is a description of Book Everything is Illuminated', 4, '/assets/img/content/main/card2.jpg', false, 3659.601820848061, '2018-09-15', 'a2aeec7e-7d20-42b0-bcbe-b96c77ca4eab', 'Everything is Illuminated');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (641, 'This is a description of Book The Little Foxes', 2, '/assets/img/content/main/card2.jpg', true, 3970.0469587105963, '2021-07-26', '26b64eef-2f62-4a7a-b0bb-de899bc0eea6', 'The Little Foxes');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (642, 'This is a description of Book Have His Carcase', 17, '/assets/img/content/main/card2.jpg', false, 3797.7200453765195, '2015-02-16', 'b6f57932-0599-42bf-ad71-163149ba8c92', 'Have His Carcase');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (643, 'This is a description of Book Far From the Madding Crowd', 21, '/assets/img/content/main/card2.jpg', false, 847.0693904785638, '2023-02-02', '11b6148e-8a2b-4237-807c-3fafb96473d9', 'Far From the Madding Crowd');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (644, 'This is a description of Book If Not Now, When?', 37, '/assets/img/content/main/card2.jpg', true, 1982.4024654533391, '2014-03-23', '5cdc18b3-f1aa-4004-8a64-78fc287b00aa', 'If Not Now, When?');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (645, 'This is a description of Book Little Hands Clapping', 25, '/assets/img/content/main/card2.jpg', false, 2025.492990357166, '2022-08-19', 'a012df0a-3cdd-4197-b5e6-54f3ff0e5497', 'Little Hands Clapping');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (646, 'This is a description of Book By Grand Central Station I Sat Down and Wept', 28, '/assets/img/content/main/card2.jpg', true, 1468.0266825682368, '2016-05-05', '8e0bc96b-f9e6-409a-a5a6-bb93c1a74195', 'By Grand Central Station I Sat Down and Wept');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (647, 'This is a description of Book Vile Bodies', 8, '/assets/img/content/main/card2.jpg', true, 4443.087520446922, '2016-07-03', '2e862e26-5a28-41e7-8bb1-4f5c2e5de9a6', 'Vile Bodies');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (648, 'This is a description of Book A Monstrous Regiment of Women', 22, '/assets/img/content/main/card2.jpg', false, 778.9403708026878, '2019-08-11', 'fa2546f8-c524-4d71-abd2-06748e570c93', 'A Monstrous Regiment of Women');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (649, 'This is a description of Book The Daffodil Sky', 0, '/assets/img/content/main/card2.jpg', true, 433.97323897142644, '2019-02-12', '9d6d6bf8-5b04-4abc-b991-10fb58926639', 'The Daffodil Sky');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (650, 'This is a description of Book Cover Her Face', 46, '/assets/img/content/main/card2.jpg', true, 3908.825357044543, '2022-04-07', '0a61048a-39e8-435b-8871-f51567cbb4f1', 'Cover Her Face');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (651, 'This is a description of Book The Mermaids Singing', 27, '/assets/img/content/main/card2.jpg', false, 4059.495349771448, '2022-04-13', 'b551a8ff-82eb-4ad3-90d6-7989bae6c2cd', 'The Mermaids Singing');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (652, 'This is a description of Book Clouds of Witness', 37, '/assets/img/content/main/card2.jpg', false, 1025.798998665729, '2018-02-24', '492b7227-8685-4e62-b227-1f1a4675d583', 'Clouds of Witness');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (653, 'This is a description of Book The Cricket on the Hearth', 14, '/assets/img/content/main/card2.jpg', false, 4204.671528348239, '2021-12-27', 'e38636a5-ba18-4a75-86a4-05677e833db3', 'The Cricket on the Hearth');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (654, 'This is a description of Book Everything is Illuminated', 16, '/assets/img/content/main/card2.jpg', true, 3547.1773968857383, '2020-05-31', 'cb95fb45-dcc7-4fc1-ac16-3c2adc6d97a2', 'Everything is Illuminated');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (655, 'This is a description of Book The Doors of Perception', 44, '/assets/img/content/main/card2.jpg', false, 760.6055083330272, '2017-08-27', 'a4245555-1df5-46e4-8876-8f6ddde56385', 'The Doors of Perception');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (656, 'This is a description of Book The Daffodil Sky', 14, '/assets/img/content/main/card2.jpg', false, 2776.096333350257, '2021-11-13', '32d3369a-9cc3-4d96-84c3-897372dea72a', 'The Daffodil Sky');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (657, 'This is a description of Book If Not Now, When?', 11, '/assets/img/content/main/card2.jpg', true, 3539.868069366437, '2017-06-13', '9d7c5704-6868-4203-ac51-a7b3d894cdbd', 'If Not Now, When?');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (658, 'This is a description of Book A Time of Gifts', 0, '/assets/img/content/main/card2.jpg', false, 3300.3726359222187, '2022-02-12', '9a84ce98-42fd-42f4-803d-f0ebd88c3b2e', 'A Time of Gifts');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (659, 'This is a description of Book For a Breath I Tarry', 0, '/assets/img/content/main/card2.jpg', false, 1661.4218590631747, '2016-02-10', '07be567a-8c1c-463b-b9e9-3d91cd1c760d', 'For a Breath I Tarry');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (660, 'This is a description of Book Look Homeward, Angel', 47, '/assets/img/content/main/card2.jpg', true, 958.7833451021925, '2020-09-20', 'a44e8e6e-69de-434a-b49a-9fe536687919', 'Look Homeward, Angel');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (661, 'This is a description of Book Of Mice and Men', 16, '/assets/img/content/main/card2.jpg', true, 3028.361630415664, '2014-06-18', '2837013d-7d29-4d85-ad31-247ddf9a85ad', 'Of Mice and Men');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (662, 'This is a description of Book Paths of Glory', 15, '/assets/img/content/main/card2.jpg', false, 903.2693261435227, '2020-10-30', '41de2153-de2e-4276-8651-e1307e0aae30', 'Paths of Glory');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (663, 'This is a description of Book Ego Dominus Tuus', 14, '/assets/img/content/main/card2.jpg', false, 4418.069376437079, '2020-03-10', '773eec3e-c27f-4366-8f8c-8adeaa6bc77b', 'Ego Dominus Tuus');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (664, 'This is a description of Book Behold the Man', 31, '/assets/img/content/main/card2.jpg', true, 4106.844984953366, '2022-11-22', 'f405f0c3-6bd2-4b01-83f4-0e51b010f5b9', 'Behold the Man');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (665, 'This is a description of Book When the Green Woods Laugh', 18, '/assets/img/content/main/card2.jpg', false, 2061.466564402151, '2015-04-24', '004014f1-be80-433d-b301-6c19fce387ec', 'When the Green Woods Laugh');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (666, 'This is a description of Book Surprised by Joy', 13, '/assets/img/content/main/card2.jpg', true, 2253.3620058679753, '2013-07-14', '4b644484-f33c-44e1-91cc-486ad8f7d2c7', 'Surprised by Joy');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (667, 'This is a description of Book A Scanner Darkly', 24, '/assets/img/content/main/card2.jpg', true, 3468.8646622945125, '2017-11-22', 'e90c6121-ff45-48f2-9352-bf52b1cd23fb', 'A Scanner Darkly');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (668, 'This is a description of Book The Wives of Bath', 22, '/assets/img/content/main/card2.jpg', false, 1350.8624210740784, '2013-03-16', 'b1511d9b-f34a-4f7d-a9f7-eb2a862356d4', 'The Wives of Bath');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (669, 'This is a description of Book Lilies of the Field', 17, '/assets/img/content/main/card2.jpg', true, 3118.5612247724935, '2015-09-09', 'f9e3cc3d-0c02-46bb-b4f2-f6cee8c25353', 'Lilies of the Field');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (670, 'This is a description of Book Oh! To be in England', 18, '/assets/img/content/main/card2.jpg', true, 3185.4290998618612, '2021-10-17', 'a78aedd2-fe3d-4fae-beed-af3c86ac26f1', 'Oh! To be in England');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (671, 'This is a description of Book Look to Windward', 6, '/assets/img/content/main/card2.jpg', true, 4455.252166268638, '2014-12-15', 'c6096aba-1445-4924-8245-7671c6fb84d9', 'Look to Windward');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (672, 'This is a description of Book A Glass of Blessings', 1, '/assets/img/content/main/card2.jpg', true, 4383.048546369755, '2020-01-11', '7205fd39-d4ff-4c30-9e12-696161424174', 'A Glass of Blessings');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (673, 'This is a description of Book The Soldier''s Art', 16, '/assets/img/content/main/card2.jpg', false, 2179.591059749273, '2018-08-15', 'cd5534ec-7d65-4166-a59c-df55eed08f05', 'The Soldier''s Art');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (674, 'This is a description of Book Alone on a Wide, Wide Sea', 32, '/assets/img/content/main/card2.jpg', true, 1849.6247230121396, '2022-11-01', 'aa13eaea-bada-40b5-9dab-8da081f298f5', 'Alone on a Wide, Wide Sea');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (675, 'This is a description of Book The Mirror Crack''d from Side to Side', 15, '/assets/img/content/main/card2.jpg', false, 2301.7423105249945, '2021-02-01', 'fe4750a2-1b1e-42d5-8f2c-50f53c483af7', 'The Mirror Crack''d from Side to Side');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (676, 'This is a description of Book His Dark Materials', 13, '/assets/img/content/main/card2.jpg', false, 370.49085788469495, '2018-11-06', 'a409b0a2-d59b-4561-9b4b-511b97087842', 'His Dark Materials');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (677, 'This is a description of Book After Many a Summer Dies the Swan', 35, '/assets/img/content/main/card2.jpg', true, 1857.575183049371, '2022-06-12', 'b440e7ac-90ad-4918-947c-54f498c0b0ae', 'After Many a Summer Dies the Swan');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (678, 'This is a description of Book Look to Windward', 38, '/assets/img/content/main/card2.jpg', true, 3211.3606037238205, '2019-08-30', 'c76f1afd-ca59-495f-afe5-ebb7aa06e73f', 'Look to Windward');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (679, 'This is a description of Book All the King''s Men', 24, '/assets/img/content/main/card2.jpg', true, 1668.6176020580015, '2016-10-10', 'd8ab70a9-7594-4f03-9315-ecf7dbfd096f', 'All the King''s Men');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (680, 'This is a description of Book Waiting for the Barbarians', 17, '/assets/img/content/main/card2.jpg', false, 3329.9266285143985, '2018-08-20', '8974eb36-94a6-4718-bdd2-b191ff251b78', 'Waiting for the Barbarians');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (681, 'This is a description of Book Blue Remembered Earth', 37, '/assets/img/content/main/card2.jpg', true, 5053.029475912216, '2018-08-03', 'b2fa6c31-a670-4ae0-9442-42bed124f43e', 'Blue Remembered Earth');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (682, 'This is a description of Book A Scanner Darkly', 2, '/assets/img/content/main/card2.jpg', false, 4442.274240016804, '2017-02-24', '452669ae-58f8-474d-aac6-3f79717b9976', 'A Scanner Darkly');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (683, 'This is a description of Book The Other Side of Silence', 26, '/assets/img/content/main/card2.jpg', true, 2660.52144746483, '2014-08-14', '8eebd0d3-3df2-4561-9d1f-dbfd07732c75', 'The Other Side of Silence');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (684, 'This is a description of Book Taming a Sea Horse', 12, '/assets/img/content/main/card2.jpg', true, 4925.934861996802, '2017-10-12', 'c7f33d31-2f09-4981-b938-66bbfa2894ee', 'Taming a Sea Horse');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (685, 'This is a description of Book Fair Stood the Wind for France', 23, '/assets/img/content/main/card2.jpg', true, 3465.30228393525, '2014-12-28', '07dd23e4-bdc4-4acd-bb41-8fde079287b9', 'Fair Stood the Wind for France');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (686, 'This is a description of Book The Wives of Bath', 40, '/assets/img/content/main/card2.jpg', true, 343.99834468968004, '2020-03-25', '195ceb0b-bf82-48b8-9c99-ec0e6d755f14', 'The Wives of Bath');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (687, 'This is a description of Book Bury My Heart at Wounded Knee', 6, '/assets/img/content/main/card2.jpg', true, 3879.1117692231333, '2014-10-27', '66cf9193-ded0-495a-9ee3-9dee130a3ee1', 'Bury My Heart at Wounded Knee');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (688, 'This is a description of Book If Not Now, When?', 27, '/assets/img/content/main/card2.jpg', false, 4906.957842734784, '2016-08-09', '5781b201-c401-4c01-9011-4c12d9a2474e', 'If Not Now, When?');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (689, 'This is a description of Book The Mirror Crack''d from Side to Side', 16, '/assets/img/content/main/card2.jpg', false, 4967.120529972609, '2020-08-26', '72a5df9b-31e3-4276-8271-5459dc4f8c45', 'The Mirror Crack''d from Side to Side');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (690, 'This is a description of Book Those Barren Leaves, Thrones, Dominations', 33, '/assets/img/content/main/card2.jpg', false, 3777.334333126814, '2015-06-03', 'f4a4a6c2-4bc1-4aef-894a-1b93cf18fc33', 'Those Barren Leaves, Thrones, Dominations');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (691, 'This is a description of Book Vanity Fair', 18, '/assets/img/content/main/card2.jpg', true, 4856.747654211715, '2018-02-05', '341a5130-4001-4a6c-ad6f-12a66b992c7d', 'Vanity Fair');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (692, 'This is a description of Book The Heart Is a Lonely Hunter', 30, '/assets/img/content/main/card2.jpg', false, 3623.062161505368, '2018-01-23', 'e49f8ace-6e39-45df-ac3a-0e2358372f42', 'The Heart Is a Lonely Hunter');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (693, 'This is a description of Book The Wealth of Nations', 29, '/assets/img/content/main/card2.jpg', false, 2556.1645714537813, '2020-10-20', '60140755-a21b-4265-bb63-ae03a0b14da4', 'The Wealth of Nations');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (694, 'This is a description of Book Cabbages and Kings', 6, '/assets/img/content/main/card2.jpg', true, 3206.78905103344, '2020-01-27', '16261308-e72b-443f-a567-bd433dc04318', 'Cabbages and Kings');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (695, 'This is a description of Book Many Waters', 43, '/assets/img/content/main/card2.jpg', false, 2710.6821487042207, '2021-09-10', 'fccfc0f4-190f-4e08-8bd1-85207c977091', 'Many Waters');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (696, 'This is a description of Book Number the Stars', 46, '/assets/img/content/main/card2.jpg', false, 4699.814919619738, '2013-07-26', '94671712-2dce-43f1-b523-311e09195d05', 'Number the Stars');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (697, 'This is a description of Book Rosemary Sutcliff', 14, '/assets/img/content/main/card2.jpg', true, 806.2293892761605, '2020-05-28', '3cfc5252-ca49-4781-ae0b-c12b448f1798', 'Rosemary Sutcliff');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (698, 'This is a description of Book Tirra Lirra by the River', 34, '/assets/img/content/main/card2.jpg', false, 3080.2591359543662, '2014-10-04', '6f016dd5-f8a9-4cdb-a55c-57b95a72c5ff', 'Tirra Lirra by the River');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (699, 'This is a description of Book Jesting Pilate', 24, '/assets/img/content/main/card2.jpg', true, 1103.457946697755, '2017-01-28', 'cd7ee354-d73a-4ae2-8918-644428e869f2', 'Jesting Pilate');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (700, 'This is a description of Book Bury My Heart at Wounded Knee', 50, '/assets/img/content/main/card2.jpg', true, 4786.085383008018, '2022-10-14', 'c479feaf-4ef5-4dbf-9522-a367e69161c7', 'Bury My Heart at Wounded Knee');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (701, 'This is a description of Book Postern of Fate', 43, '/assets/img/content/main/card2.jpg', false, 1295.4877023724732, '2013-03-31', '40cdffa7-9496-406a-97e7-58a8c01ad109', 'Postern of Fate');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (702, 'This is a description of Book A Handful of Dust', 32, '/assets/img/content/main/card2.jpg', false, 3105.941350888142, '2022-05-28', '66983c7d-c635-434a-8886-14871d340abf', 'A Handful of Dust');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (703, 'This is a description of Book Look Homeward, Angel', 17, '/assets/img/content/main/card2.jpg', false, 4653.1451010306, '2019-09-12', 'f92f7739-6fe6-4801-a7bb-aea79cffd2f3', 'Look Homeward, Angel');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (704, 'This is a description of Book O Pioneers!', 50, '/assets/img/content/main/card2.jpg', true, 4031.9856796016416, '2020-02-27', 'e7669124-92e0-445a-a74c-477b915727f6', 'O Pioneers!');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (705, 'This is a description of Book Unweaving the Rainbow', 27, '/assets/img/content/main/card2.jpg', true, 3809.547360667781, '2017-08-22', '0a69dc6a-a665-4175-9163-9cda0f9af84d', 'Unweaving the Rainbow');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (706, 'This is a description of Book Those Barren Leaves, Thrones, Dominations', 13, '/assets/img/content/main/card2.jpg', false, 239.30992391363299, '2014-06-20', 'b598e67f-0ffa-49d1-a9e3-d12ee78074f1', 'Those Barren Leaves, Thrones, Dominations');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (707, 'This is a description of Book This Side of Paradise', 3, '/assets/img/content/main/card2.jpg', false, 1997.721019921726, '2022-09-01', 'e25c7578-ebcc-40f5-ae42-c8fe835f1f69', 'This Side of Paradise');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (708, 'This is a description of Book Things Fall Apart', 18, '/assets/img/content/main/card2.jpg', true, 3432.536202060384, '2022-02-01', '93a9efd8-225b-47cd-99b1-c18325aafcbb', 'Things Fall Apart');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (709, 'This is a description of Book To a God Unknown', 20, '/assets/img/content/main/card2.jpg', true, 1417.3908759341396, '2013-11-11', '946295b9-c1bd-4046-bf45-23fcd05ef989', 'To a God Unknown');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (710, 'This is a description of Book Fair Stood the Wind for France', 17, '/assets/img/content/main/card2.jpg', false, 1346.233373322589, '2017-09-15', '31d8a204-d9d6-44e5-afd7-b56722038863', 'Fair Stood the Wind for France');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (711, 'This is a description of Book Look to Windward', 48, '/assets/img/content/main/card2.jpg', true, 723.2728940033846, '2020-08-13', '995713a5-d42c-475d-9265-b168699bc2d7', 'Look to Windward');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (712, 'This is a description of Book In Death Ground', 11, '/assets/img/content/main/card2.jpg', false, 4909.98219956927, '2020-06-26', '9ce18609-2412-4d15-8bc7-af077c49472a', 'In Death Ground');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (713, 'This is a description of Book The Moving Toyshop', 30, '/assets/img/content/main/card2.jpg', false, 749.8992091964827, '2017-04-17', 'b3adb688-d598-4eaa-a563-a9ed77a08e97', 'The Moving Toyshop');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (714, 'This is a description of Book Look to Windward', 21, '/assets/img/content/main/card2.jpg', true, 4826.003492629507, '2022-07-20', '8706a7c3-31f2-4fa8-917b-7019bac1b143', 'Look to Windward');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (715, 'This is a description of Book Shall not Perish', 18, '/assets/img/content/main/card2.jpg', true, 3760.8013322409292, '2015-10-03', 'b58dbf56-a0dc-4cf7-9d15-8efa3b271deb', 'Shall not Perish');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (716, 'This is a description of Book Rosemary Sutcliff', 29, '/assets/img/content/main/card2.jpg', false, 2618.99761173345, '2020-11-18', '5c74a1f0-deef-4ad9-b67c-bf4101b7b5da', 'Rosemary Sutcliff');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (717, 'This is a description of Book Françoise Sagan', 7, '/assets/img/content/main/card2.jpg', true, 3150.494939804234, '2017-02-22', '1ecb5502-3be1-43f7-9c8b-98e76234c232', 'Françoise Sagan');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (718, 'This is a description of Book Mr Standfast', 22, '/assets/img/content/main/card2.jpg', true, 2435.218115335029, '2016-05-01', 'c6df4c61-e3e1-4842-aca3-a1b63ab57e32', 'Mr Standfast');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (719, 'This is a description of Book Beneath the Bleeding', 27, '/assets/img/content/main/card2.jpg', true, 3877.22136725505, '2016-12-21', '8f0c3b0a-60d9-4632-b817-0326295f61e8', 'Beneath the Bleeding');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (720, 'This is a description of Book The Heart Is Deceitful Above All Things', 7, '/assets/img/content/main/card2.jpg', true, 3833.2905188926466, '2019-11-27', '88aa5583-e105-4c49-ae8a-d61422c81eb4', 'The Heart Is Deceitful Above All Things');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (721, 'This is a description of Book The Widening Gyre', 2, '/assets/img/content/main/card2.jpg', false, 4095.491700006718, '2017-06-18', '859ae933-7e81-4734-a4a7-82cc55c1d53b', 'The Widening Gyre');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (722, 'This is a description of Book The Line of Beauty', 48, '/assets/img/content/main/card2.jpg', true, 313.0969746615659, '2020-11-06', 'aa42789a-1022-41dd-8887-68fa5c9b1932', 'The Line of Beauty');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (723, 'This is a description of Book Jacob Have I Loved', 13, '/assets/img/content/main/card2.jpg', true, 3086.6931239990167, '2016-12-15', '9343cb5e-0d3b-47a3-b3d4-bb7232b13ec9', 'Jacob Have I Loved');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (724, 'This is a description of Book Tender Is the Night', 34, '/assets/img/content/main/card2.jpg', true, 1385.3716522291359, '2014-12-23', 'b465cf6b-3f9a-4c83-a2cb-251b73a83e07', 'Tender Is the Night');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (725, 'This is a description of Book Postern of Fate', 50, '/assets/img/content/main/card2.jpg', false, 2092.007266310208, '2016-08-05', '4896a928-31f7-4066-91c7-c01606a0f177', 'Postern of Fate');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (726, 'This is a description of Book No Highway', 41, '/assets/img/content/main/card2.jpg', true, 1020.9164188534421, '2013-12-10', '6ad599e8-543d-4844-8890-a474ea67a382', 'No Highway');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (727, 'This is a description of Book The Yellow Meads of Asphodel', 7, '/assets/img/content/main/card2.jpg', false, 3024.6693281579005, '2022-08-31', 'fc592e38-ed75-43ac-8e07-379b5ea9357a', 'The Yellow Meads of Asphodel');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (728, 'This is a description of Book Now Sleeps the Crimson Petal', 12, '/assets/img/content/main/card2.jpg', true, 1594.4632288163673, '2015-12-15', '6a453072-43b5-43b8-8a81-9f5e630d9d0b', 'Now Sleeps the Crimson Petal');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (729, 'This is a description of Book Blithe Spirit', 38, '/assets/img/content/main/card2.jpg', true, 2012.7869569428108, '2023-03-05', '88abd2b5-c79f-4de3-bdd0-6a89f3963233', 'Blithe Spirit');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (730, 'This is a description of Book The Waste Land', 19, '/assets/img/content/main/card2.jpg', false, 1054.8239376661916, '2022-07-15', '2fd45114-9891-4ef6-a1f7-1dd9aeca2841', 'The Waste Land');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (731, 'This is a description of Book Antic Hay', 45, '/assets/img/content/main/card2.jpg', false, 188.02046380131273, '2017-05-05', '79d9261a-ff46-452b-b44e-3527d5a20e29', 'Antic Hay');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (732, 'This is a description of Book A Handful of Dust', 12, '/assets/img/content/main/card2.jpg', false, 439.7099458104544, '2020-07-15', 'd3b5dc24-662e-479e-b40f-ffe55df38e40', 'A Handful of Dust');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (733, 'This is a description of Book Precious Bane', 28, '/assets/img/content/main/card2.jpg', false, 2904.9919920990824, '2021-10-11', 'cc273703-19a1-47d8-abb2-b2eea31b12c9', 'Precious Bane');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (734, 'This is a description of Book The Way Through the Woods', 16, '/assets/img/content/main/card2.jpg', false, 2328.3374013142584, '2013-10-22', '3cf3a61e-3f69-4fac-8691-42c8a8df7b58', 'The Way Through the Woods');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (735, 'This is a description of Book Fair Stood the Wind for France', 44, '/assets/img/content/main/card2.jpg', true, 2346.2907721116962, '2017-04-09', 'ebc60984-2d6b-46b8-937b-26a64fd6fc34', 'Fair Stood the Wind for France');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (736, 'This is a description of Book Shall not Perish', 47, '/assets/img/content/main/card2.jpg', true, 1892.0072889282835, '2015-03-07', '455c7992-fa7c-4c3e-93e8-04e924410ab6', 'Shall not Perish');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (737, 'This is a description of Book Edna O''Brien', 11, '/assets/img/content/main/card2.jpg', true, 219.93423203760983, '2017-09-08', '51de9d8c-d1d4-40f0-b0f5-f94f43668bc4', 'Edna O''Brien');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (738, 'This is a description of Book Nine Coaches Waiting', 16, '/assets/img/content/main/card2.jpg', true, 1225.3466082261682, '2013-11-29', 'cb97e841-b2b2-402f-b764-32d821443a90', 'Nine Coaches Waiting');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (739, 'This is a description of Book Clouds of Witness', 16, '/assets/img/content/main/card2.jpg', true, 3439.5494164830247, '2014-03-06', 'f1feb8aa-8727-4bb8-8b32-34aeacfa2142', 'Clouds of Witness');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (740, 'This is a description of Book The Waste Land', 47, '/assets/img/content/main/card2.jpg', false, 2998.884380769881, '2014-11-11', '9c93d0ac-a84a-4e00-a70c-a05a9cf60e61', 'The Waste Land');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (741, 'This is a description of Book Things Fall Apart', 23, '/assets/img/content/main/card2.jpg', true, 3785.8842155650386, '2014-11-08', 'cc2f9056-2834-44c3-917c-51043c004ef6', 'Things Fall Apart');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (742, 'This is a description of Book Time of our Darkness', 16, '/assets/img/content/main/card2.jpg', true, 3344.4161834993647, '2023-02-02', 'd1fab3f6-2181-486c-9532-ed899c967173', 'Time of our Darkness');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (743, 'This is a description of Book The Wings of the Dove', 14, '/assets/img/content/main/card2.jpg', false, 4393.431021481222, '2017-08-29', '4b66297b-a3f7-4b58-8bba-fd7b1bfb59d9', 'The Wings of the Dove');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (744, 'This is a description of Book A Confederacy of Dunces', 6, '/assets/img/content/main/card2.jpg', false, 2999.9694142949033, '2023-02-20', '467e08cf-7542-4d0c-8e22-ce0b80c4b42f', 'A Confederacy of Dunces');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (745, 'This is a description of Book Things Fall Apart', 25, '/assets/img/content/main/card2.jpg', true, 257.4436792257597, '2017-12-04', 'df2d3877-5b65-48f9-8e62-3343eea2c7e4', 'Things Fall Apart');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (746, 'This is a description of Book The Golden Bowl', 18, '/assets/img/content/main/card2.jpg', false, 4150.639064835786, '2016-11-08', 'a194a630-c992-4310-847c-800994adf314', 'The Golden Bowl');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (747, 'This is a description of Book The Mermaids Singing', 49, '/assets/img/content/main/card2.jpg', false, 3022.8084263724504, '2020-11-01', 'bfabbad9-2597-47ad-b59b-7c4fb4db6c13', 'The Mermaids Singing');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (748, 'This is a description of Book The Parliament of Man', 32, '/assets/img/content/main/card2.jpg', false, 3232.6252878354644, '2013-05-08', '310ddaeb-8a7c-4624-b672-d1f0232309fa', 'The Parliament of Man');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (749, 'This is a description of Book The Golden Bowl', 9, '/assets/img/content/main/card2.jpg', false, 4563.5567455085, '2021-12-10', 'c5a0ed1c-18bf-42fc-8d9c-5ecb8a965c5b', 'The Golden Bowl');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (750, 'This is a description of Book Dying of the Light', 11, '/assets/img/content/main/card2.jpg', true, 3333.208758702418, '2017-10-09', '3b29671f-7e55-40dd-bcb7-9cf63041b96f', 'Dying of the Light');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (751, 'This is a description of Book Clouds of Witness', 45, '/assets/img/content/main/card2.jpg', true, 897.1078766387394, '2013-11-26', '87ed1a8f-5e47-4f94-bc5e-374f5bec4904', 'Clouds of Witness');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (752, 'This is a description of Book The Millstone', 19, '/assets/img/content/main/card2.jpg', true, 1709.37137738018, '2019-03-30', '73e0f096-7faa-4587-96de-c6faa2f0fbda', 'The Millstone');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (753, 'This is a description of Book Little Hands Clapping', 34, '/assets/img/content/main/card2.jpg', true, 3963.035726221752, '2021-01-21', '93af79ba-5ef4-4db6-b9d7-f310d7a16d85', 'Little Hands Clapping');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (754, 'This is a description of Book Wildfire at Midnight', 21, '/assets/img/content/main/card2.jpg', false, 2100.266243980202, '2017-01-17', '74297e9d-2def-4cb9-809a-34a2efa90ad4', 'Wildfire at Midnight');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (755, 'This is a description of Book The Man Within', 12, '/assets/img/content/main/card2.jpg', true, 837.5630095891015, '2021-09-10', '6160f749-4214-4e3c-9874-972a4feb6adf', 'The Man Within');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (756, 'This is a description of Book After Many a Summer Dies the Swan', 27, '/assets/img/content/main/card2.jpg', true, 4940.704453282205, '2014-06-01', 'e5a78c94-1580-4ef6-a034-1d6de9ddddaf', 'After Many a Summer Dies the Swan');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (757, 'This is a description of Book Consider the Lilies', 32, '/assets/img/content/main/card2.jpg', false, 4884.497994670697, '2022-08-20', '65c1d526-9e57-489d-814c-d5c13b1968af', 'Consider the Lilies');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (758, 'This is a description of Book To a God Unknown', 5, '/assets/img/content/main/card2.jpg', false, 2122.433846569047, '2017-06-01', '62e3fac4-7f4c-4d40-9eaa-d0ecdcb21352', 'To a God Unknown');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (759, 'This is a description of Book Gone with the Wind', 18, '/assets/img/content/main/card2.jpg', true, 912.7088730766294, '2016-10-17', 'c6def2df-22d6-424b-a19a-9436916adc78', 'Gone with the Wind');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (760, 'This is a description of Book The Golden Apples of the Sun', 8, '/assets/img/content/main/card2.jpg', false, 639.8975679590807, '2020-07-04', 'b565f99d-010f-4a7b-bbcf-a4fe2a124207', 'The Golden Apples of the Sun');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (761, 'This is a description of Book I Will Fear No Evil', 37, '/assets/img/content/main/card2.jpg', false, 1598.8496384321431, '2013-08-12', 'c9602eb4-9601-4927-a365-712a10f2446a', 'I Will Fear No Evil');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (762, 'This is a description of Book Beyond the Mexique Bay', 15, '/assets/img/content/main/card2.jpg', false, 4943.773602789627, '2016-05-21', '0d356844-93ca-43c1-8f2d-f863eab79c8c', 'Beyond the Mexique Bay');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (763, 'This is a description of Book Jesting Pilate', 13, '/assets/img/content/main/card2.jpg', false, 2531.1408492843184, '2017-03-14', '601d8ec7-e7a7-4af4-9c4b-1dc597a8f370', 'Jesting Pilate');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (764, 'This is a description of Book A Passage to India', 44, '/assets/img/content/main/card2.jpg', true, 4702.290311917261, '2020-05-06', '1e04dd14-c1c7-40e7-919d-a8c5924d0696', 'A Passage to India');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (765, 'This is a description of Book Time of our Darkness', 14, '/assets/img/content/main/card2.jpg', true, 394.90961223849155, '2015-07-29', 'c1e76f85-f8f1-4db9-9199-1f7ac3d83a92', 'Time of our Darkness');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (766, 'This is a description of Book Tirra Lirra by the River', 22, '/assets/img/content/main/card2.jpg', true, 2614.7015756000033, '2016-02-18', 'b7c5b161-bdf1-4de6-b73d-d42ab9dbb3ac', 'Tirra Lirra by the River');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (767, 'This is a description of Book Death Be Not Proud', 19, '/assets/img/content/main/card2.jpg', true, 2037.0057380824371, '2021-10-15', 'ce824500-8038-4ae7-b805-f1befe8b3522', 'Death Be Not Proud');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (768, 'This is a description of Book For a Breath I Tarry', 8, '/assets/img/content/main/card2.jpg', true, 742.4871554331643, '2016-07-20', '2e897212-b43f-4b4a-bc1a-2858aced439d', 'For a Breath I Tarry');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (769, 'This is a description of Book The Doors of Perception', 23, '/assets/img/content/main/card2.jpg', true, 4985.444868253504, '2018-12-25', '47074471-11ff-4807-97fe-76cc3b4d2dd8', 'The Doors of Perception');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (770, 'This is a description of Book Taming a Sea Horse', 49, '/assets/img/content/main/card2.jpg', true, 486.6522822741518, '2015-10-10', '77d476b7-0b19-43e3-85e2-18561d644697', 'Taming a Sea Horse');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (771, 'This is a description of Book An Evil Cradling', 47, '/assets/img/content/main/card2.jpg', false, 2468.8533873929373, '2015-05-03', 'f41eeb99-f103-40f6-8ebe-40e4211faf81', 'An Evil Cradling');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (772, 'This is a description of Book To a God Unknown', 26, '/assets/img/content/main/card2.jpg', true, 454.75266419905864, '2022-02-19', '7b5d3211-7a4a-4d6c-822b-e6308aec8a6b', 'To a God Unknown');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (773, 'This is a description of Book Blithe Spirit', 17, '/assets/img/content/main/card2.jpg', true, 2505.7824487324906, '2016-07-12', 'bc2d84b7-b382-4008-b304-c44be1314f13', 'Blithe Spirit');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (774, 'This is a description of Book I Will Fear No Evil', 39, '/assets/img/content/main/card2.jpg', true, 1325.0188380418188, '2016-09-10', 'bd9d56a7-adfe-4346-824c-dacb453969c2', 'I Will Fear No Evil');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (775, 'This is a description of Book Ring of Bright Water', 41, '/assets/img/content/main/card2.jpg', false, 3188.357140978866, '2022-01-26', '13cf37fd-956b-46a4-909f-a0fff8b39f69', 'Ring of Bright Water');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (776, 'This is a description of Book In Dubious Battle', 13, '/assets/img/content/main/card2.jpg', false, 2606.733196558406, '2019-10-21', 'db90d2b8-2a8e-46d5-a263-6f2b07b2464d', 'In Dubious Battle');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (777, 'This is a description of Book A Many-Splendoured Thing', 1, '/assets/img/content/main/card2.jpg', true, 465.2787840799726, '2018-07-05', '79add0f2-600e-4c2a-88c3-1ce3a74111f9', 'A Many-Splendoured Thing');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (778, 'This is a description of Book The Wealth of Nations', 20, '/assets/img/content/main/card2.jpg', true, 3476.0946148954445, '2019-05-14', 'bef172e3-57d4-4eeb-b8ab-c0d7e59aa719', 'The Wealth of Nations');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (779, 'This is a description of Book Jacob Have I Loved', 36, '/assets/img/content/main/card2.jpg', false, 3262.010006647122, '2016-04-17', '580932ae-2f3d-4974-8fa5-a3ec05bc2691', 'Jacob Have I Loved');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (780, 'This is a description of Book Carrion Comfort', 16, '/assets/img/content/main/card2.jpg', false, 751.4442610686552, '2016-11-08', '683d6854-d12b-46fc-acc7-76b4363d3f82', 'Carrion Comfort');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (781, 'This is a description of Book Jacob Have I Loved', 11, '/assets/img/content/main/card2.jpg', true, 3656.259447172045, '2017-02-09', 'd421215a-f4cb-4916-bef5-70cbcc6dc60f', 'Jacob Have I Loved');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (782, 'This is a description of Book This Lime Tree Bower', 18, '/assets/img/content/main/card2.jpg', false, 4271.411160937973, '2017-04-03', '42ff8955-eae3-4048-9bf0-38f6277181ce', 'This Lime Tree Bower');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (783, 'This is a description of Book Terrible Swift Sword', 44, '/assets/img/content/main/card2.jpg', false, 4891.220830562492, '2022-04-03', '9c74ca37-40ec-4929-a24e-dde0f6563ded', 'Terrible Swift Sword');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (784, 'This is a description of Book That Hideous Strength', 14, '/assets/img/content/main/card2.jpg', true, 1294.241033163852, '2020-08-24', '63cbaa23-20c1-4d23-a325-19ec6538582c', 'That Hideous Strength');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (785, 'This is a description of Book An Evil Cradling', 6, '/assets/img/content/main/card2.jpg', true, 3635.5943721261133, '2022-06-26', 'f87e6bd6-fc26-46e4-8b9d-1c69fc2864cb', 'An Evil Cradling');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (786, 'This is a description of Book East of Eden', 50, '/assets/img/content/main/card2.jpg', true, 3339.004819922351, '2022-04-05', '124d3738-d83d-42bc-9674-742632597cf6', 'East of Eden');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (787, 'This is a description of Book The Last Enemy', 1, '/assets/img/content/main/card2.jpg', true, 3183.2708968456022, '2013-10-27', '79b14df7-3929-4e73-8938-060a5b02ec14', 'The Last Enemy');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (788, 'This is a description of Book A Farewell to Arms', 12, '/assets/img/content/main/card2.jpg', true, 2897.2365999562066, '2015-08-01', '486929c9-54c4-4637-aedb-efe9885e3b5a', 'A Farewell to Arms');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (789, 'This is a description of Book The Heart Is Deceitful Above All Things', 47, '/assets/img/content/main/card2.jpg', false, 588.8440543399568, '2015-07-17', 'd949ac59-ff3c-40ec-aa29-2f932951b706', 'The Heart Is Deceitful Above All Things');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (790, 'This is a description of Book A Farewell to Arms', 34, '/assets/img/content/main/card2.jpg', false, 1790.750936908662, '2014-01-13', '81896203-0d94-4fb1-87ec-35aa0d80ab41', 'A Farewell to Arms');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (791, 'This is a description of Book The Torment of Others', 10, '/assets/img/content/main/card2.jpg', false, 4663.346253408476, '2021-11-02', '9df30e07-336b-44d8-bd74-a11eaac82352', 'The Torment of Others');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (792, 'This is a description of Book Moab Is My Washpot', 12, '/assets/img/content/main/card2.jpg', true, 1632.3483226999836, '2014-08-12', '99be1a7b-f9f1-420c-8449-fae638dc1ccf', 'Moab Is My Washpot');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (793, 'This is a description of Book Edna O''Brien', 25, '/assets/img/content/main/card2.jpg', true, 1836.9015054559964, '2015-09-09', 'c8162580-e2ef-4268-9fef-ad19fbb69b76', 'Edna O''Brien');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (794, 'This is a description of Book Nectar in a Sieve', 29, '/assets/img/content/main/card2.jpg', true, 499.9797306171974, '2016-10-29', 'b187a12e-966a-4372-87fd-e6fc8b491eb2', 'Nectar in a Sieve');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (795, 'This is a description of Book Antic Hay', 6, '/assets/img/content/main/card2.jpg', true, 2036.3346988090586, '2017-12-27', '2833e91a-3703-4beb-84a1-b70b7b0fabc5', 'Antic Hay');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (796, 'This is a description of Book Nine Coaches Waiting', 48, '/assets/img/content/main/card2.jpg', true, 4726.837276278505, '2017-11-15', '483ad24d-2239-4036-82a0-1663e0ee02ae', 'Nine Coaches Waiting');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (797, 'This is a description of Book The Wealth of Nations', 35, '/assets/img/content/main/card2.jpg', true, 731.2627457648191, '2016-02-29', '59417c1f-e345-414a-bdca-61a89589796a', 'The Wealth of Nations');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (798, 'This is a description of Book Everything is Illuminated', 43, '/assets/img/content/main/card2.jpg', false, 2020.1318586333225, '2023-01-11', 'a8d33726-b2c5-4c2a-aa80-8499e6792b9d', 'Everything is Illuminated');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (799, 'This is a description of Book A Glass of Blessings', 20, '/assets/img/content/main/card2.jpg', false, 3670.2687469954167, '2022-07-23', '6a763b51-b4a9-40f4-a841-3dc5ee5dd393', 'A Glass of Blessings');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (800, 'This is a description of Book The Green Bay Tree', 32, '/assets/img/content/main/card2.jpg', true, 4286.859046277329, '2019-10-03', 'd9e38e2d-f3c4-43ec-ab64-37b9a499de1b', 'The Green Bay Tree');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (801, 'This is a description of Book The Grapes of Wrath', 26, '/assets/img/content/main/card2.jpg', false, 2355.485373421064, '2015-12-15', '47cbf6c8-e4f2-490b-b151-1e55e989ed9b', 'The Grapes of Wrath');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (802, 'This is a description of Book Little Hands Clapping', 11, '/assets/img/content/main/card2.jpg', true, 3494.224397005291, '2013-06-02', '7713e7ad-d14d-401d-9c0d-6f14f82c9e65', 'Little Hands Clapping');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (803, 'This is a description of Book His Dark Materials', 3, '/assets/img/content/main/card2.jpg', true, 130.2070199776433, '2022-12-03', '3bad029d-24e4-4d49-93fe-868bc875edbe', 'His Dark Materials');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (804, 'This is a description of Book Far From the Madding Crowd', 49, '/assets/img/content/main/card2.jpg', true, 4767.166233540259, '2013-04-29', 'a72f5b14-4f3b-485f-bbc4-9be41314a25f', 'Far From the Madding Crowd');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (805, 'This is a description of Book The Curious Incident of the Dog in the Night-Time', 19, '/assets/img/content/main/card2.jpg', true, 3498.0402582214533, '2022-11-09', '0874cdae-ba26-4a2c-bb49-82a8e8ada835', 'The Curious Incident of the Dog in the Night-Time');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (806, 'This is a description of Book The Heart Is Deceitful Above All Things', 25, '/assets/img/content/main/card2.jpg', false, 1377.379400775395, '2021-07-23', '2f313cbf-c6aa-4fa5-8e59-e27c702a0287', 'The Heart Is Deceitful Above All Things');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (807, 'This is a description of Book Fame Is the Spur', 45, '/assets/img/content/main/card2.jpg', true, 1206.9764012356734, '2017-08-22', '7887e01f-5b28-4b1e-a44f-153bb02ef2dd', 'Fame Is the Spur');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (808, 'This is a description of Book A Time to Kill', 38, '/assets/img/content/main/card2.jpg', true, 4201.693837145963, '2018-04-12', '9e5388d8-50c2-4a84-9e4b-2610b6a84d23', 'A Time to Kill');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (809, 'This is a description of Book Tender Is the Night', 2, '/assets/img/content/main/card2.jpg', false, 3189.6256655773345, '2014-01-31', 'c1fef084-8e89-4d5a-a218-b25fda5c3535', 'Tender Is the Night');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (810, 'This is a description of Book The Moon by Night', 2, '/assets/img/content/main/card2.jpg', true, 4062.617407775244, '2019-08-24', 'd442629c-ee18-4a0d-a0a7-94f39d10d4db', 'The Moon by Night');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (811, 'This is a description of Book The Widening Gyre', 35, '/assets/img/content/main/card2.jpg', true, 4232.545915312339, '2018-05-22', 'a09e6319-2d68-4fed-a419-2f34cf2aeed5', 'The Widening Gyre');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (812, 'This is a description of Book A Scanner Darkly', 47, '/assets/img/content/main/card2.jpg', true, 1727.3182564668396, '2016-04-05', '527a90d8-5044-4d6e-880a-d070c5cc91f8', 'A Scanner Darkly');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (813, 'This is a description of Book This Side of Paradise', 35, '/assets/img/content/main/card2.jpg', false, 3374.096123479133, '2022-12-11', 'a0211ee0-b316-499e-8dab-bb5a30657f88', 'This Side of Paradise');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (814, 'This is a description of Book Precious Bane', 2, '/assets/img/content/main/card2.jpg', false, 4016.537192794469, '2018-05-24', '6d08c2e3-6139-48d7-8f6b-1f75825f87b9', 'Precious Bane');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (815, 'This is a description of Book An Acceptable Time', 16, '/assets/img/content/main/card2.jpg', false, 2443.8706822088197, '2020-10-15', 'ed86ee0b-7b1f-4f87-9b91-a9226a8b70b3', 'An Acceptable Time');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (816, 'This is a description of Book A Scanner Darkly', 19, '/assets/img/content/main/card2.jpg', true, 4260.608973985855, '2013-07-14', '63f49975-2eef-4697-b4b4-002fa5e01095', 'A Scanner Darkly');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (817, 'This is a description of Book The Wealth of Nations', 41, '/assets/img/content/main/card2.jpg', false, 4815.460103858182, '2022-07-03', '2f7c6da5-27c6-40fc-8c50-81906b07bbaf', 'The Wealth of Nations');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (818, 'This is a description of Book By Grand Central Station I Sat Down and Wept', 37, '/assets/img/content/main/card2.jpg', true, 4652.390775084966, '2020-09-21', '7e0f00a6-1904-4c02-ae74-214382d691ae', 'By Grand Central Station I Sat Down and Wept');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (819, 'This is a description of Book Cover Her Face', 3, '/assets/img/content/main/card2.jpg', true, 3698.830427359296, '2015-01-12', 'fde16d84-8cdb-4e37-bfd1-de61dd04be1d', 'Cover Her Face');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (820, 'This is a description of Book No Longer at Ease', 30, '/assets/img/content/main/card2.jpg', true, 262.88905018431115, '2019-05-27', '30a975dc-16a7-433d-8949-57ae4c3895b8', 'No Longer at Ease');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (821, 'This is a description of Book Dying of the Light', 22, '/assets/img/content/main/card2.jpg', false, 4933.921097120406, '2020-06-12', 'abb5752b-c03d-458f-9db1-8d85842f84ff', 'Dying of the Light');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (822, 'This is a description of Book The Last Temptation', 40, '/assets/img/content/main/card2.jpg', false, 3938.419126854677, '2013-11-16', 'cee08da9-137a-41c1-94bf-db5500254aee', 'The Last Temptation');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (823, 'This is a description of Book The Monkey''s Raincoat', 13, '/assets/img/content/main/card2.jpg', false, 668.391911825136, '2015-02-11', 'ad9d4367-8209-4939-9cb0-305fc3c7b817', 'The Monkey''s Raincoat');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (824, 'This is a description of Book The Sun Also Rises', 18, '/assets/img/content/main/card2.jpg', false, 366.3863823535932, '2014-12-19', '7e50332f-cc0d-4812-881b-0bdfbb56b2fb', 'The Sun Also Rises');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (825, 'This is a description of Book A Many-Splendoured Thing', 8, '/assets/img/content/main/card2.jpg', false, 1231.6759163803579, '2016-04-05', '024b504b-f5cd-44df-9e90-56c256651b52', 'A Many-Splendoured Thing');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (826, 'This is a description of Book A Farewell to Arms', 21, '/assets/img/content/main/card2.jpg', true, 1426.1392263797297, '2017-09-20', '980ed82c-5f66-4cb2-9640-dfa9b7ea04ad', 'A Farewell to Arms');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (827, 'This is a description of Book The Man Within', 38, '/assets/img/content/main/card2.jpg', false, 2111.348278952581, '2022-11-05', '38410bdf-3adc-48c5-ba79-35ffb55a8c2b', 'The Man Within');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (828, 'This is a description of Book Tender Is the Night', 4, '/assets/img/content/main/card2.jpg', false, 4702.692249896808, '2022-06-30', '7ea94a53-54b1-452c-a51c-6c1d28d0e80f', 'Tender Is the Night');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (829, 'This is a description of Book Recalled to Life', 26, '/assets/img/content/main/card2.jpg', true, 373.1420760931542, '2018-06-22', 'fafb7314-43d4-4dfe-a16e-f567ea7b43ec', 'Recalled to Life');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (830, 'This is a description of Book Nine Coaches Waiting', 3, '/assets/img/content/main/card2.jpg', false, 984.5670442223433, '2017-03-28', '261967e3-2b6e-4cbf-95cd-00eaa2fee4d1', 'Nine Coaches Waiting');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (831, 'This is a description of Book The Far-Distant Oxus', 2, '/assets/img/content/main/card2.jpg', true, 4501.930697343463, '2018-02-12', '4c044256-2e4b-42b8-8c36-f1b4e068c44c', 'The Far-Distant Oxus');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (832, 'This is a description of Book Time To Murder And Create', 34, '/assets/img/content/main/card2.jpg', false, 2675.146988200956, '2014-10-27', 'efd991e3-bfd3-4e44-8fd7-71c72e9c77ce', 'Time To Murder And Create');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (833, 'This is a description of Book Fear and Trembling', 27, '/assets/img/content/main/card2.jpg', false, 3098.4628471735728, '2018-12-31', 'a73fba9c-0dac-4934-9b72-213c122b89be', 'Fear and Trembling');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (834, 'This is a description of Book From Here to Eternity', 30, '/assets/img/content/main/card2.jpg', true, 5089.123746408579, '2017-04-12', '6eb805d2-cc6b-4508-86c1-2deb71a4d01b', 'From Here to Eternity');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (835, 'This is a description of Book No Longer at Ease', 20, '/assets/img/content/main/card2.jpg', true, 2947.248812794454, '2022-07-19', 'ec64a8c9-2e2d-4a1b-be40-1c3f20e4ee2d', 'No Longer at Ease');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (836, 'This is a description of Book Bury My Heart at Wounded Knee', 41, '/assets/img/content/main/card2.jpg', false, 4265.144704322965, '2021-03-28', '09be71c1-215f-46fc-a347-ebc23f18ebf1', 'Bury My Heart at Wounded Knee');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (837, 'This is a description of Book The Green Bay Tree', 7, '/assets/img/content/main/card2.jpg', true, 2882.5340988559524, '2022-04-06', 'c4b8fc35-7483-4f08-b484-da4d2f921033', 'The Green Bay Tree');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (838, 'This is a description of Book A Glass of Blessings', 15, '/assets/img/content/main/card2.jpg', false, 4325.203844011564, '2018-09-25', '8349a01b-960c-498f-900e-ecfed9bf380f', 'A Glass of Blessings');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (839, 'This is a description of Book The Widening Gyre', 0, '/assets/img/content/main/card2.jpg', true, 2485.8964040754286, '2016-03-19', 'bd73363f-0033-4d27-ace2-6a7eb7ab5bfb', 'The Widening Gyre');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (840, 'This is a description of Book Beyond the Mexique Bay', 49, '/assets/img/content/main/card2.jpg', true, 1498.6897672802402, '2014-04-26', 'f15253ce-277a-48a7-bf20-6fbd87adfdfb', 'Beyond the Mexique Bay');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (841, 'This is a description of Book All Passion Spent', 28, '/assets/img/content/main/card2.jpg', true, 2805.4112951442535, '2021-04-09', '1521361b-8901-4ea6-bd1f-1a57abd52bd5', 'All Passion Spent');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (842, 'This is a description of Book Tirra Lirra by the River', 21, '/assets/img/content/main/card2.jpg', false, 3779.0842135827234, '2018-02-03', '96e2e4f3-01a5-4d35-a0cd-4afdafcdf305', 'Tirra Lirra by the River');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (843, 'This is a description of Book The Needle''s Eye', 10, '/assets/img/content/main/card2.jpg', true, 4668.157271068239, '2022-08-02', '4e32e618-2274-4850-a273-d78c4e95cfa7', 'The Needle''s Eye');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (844, 'This is a description of Book Nectar in a Sieve', 44, '/assets/img/content/main/card2.jpg', true, 1480.8473767975586, '2021-06-08', '0937863c-bfd4-4cc8-822a-3adea6e39794', 'Nectar in a Sieve');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (845, 'This is a description of Book The Way of All Flesh', 0, '/assets/img/content/main/card2.jpg', false, 4203.7880216229, '2018-05-11', '019737d0-5bac-4d0f-9131-dcdff16b4fba', 'The Way of All Flesh');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (846, 'This is a description of Book Behold the Man', 15, '/assets/img/content/main/card2.jpg', true, 3656.0218581699146, '2021-09-21', '6040edaf-8874-40ee-9161-ab58463bac85', 'Behold the Man');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (847, 'This is a description of Book The Other Side of Silence', 42, '/assets/img/content/main/card2.jpg', true, 1673.0637655952587, '2013-04-02', '2dd0f854-c45c-4397-bb43-0cb5ff98ef28', 'The Other Side of Silence');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (848, 'This is a description of Book Arms and the Man', 4, '/assets/img/content/main/card2.jpg', true, 2295.008833942049, '2022-02-15', '1f499d28-3ce1-47c1-aa70-c00f1defb05a', 'Arms and the Man');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (849, 'This is a description of Book Tiger! Tiger!', 12, '/assets/img/content/main/card2.jpg', false, 1799.2891761540131, '2019-07-18', '3f518929-ef5f-417f-9192-fb1ba2c92af1', 'Tiger! Tiger!');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (850, 'This is a description of Book A Time to Kill', 12, '/assets/img/content/main/card2.jpg', false, 4881.025974450784, '2017-02-22', '0fa7ea2c-319f-4168-8178-2294035df15b', 'A Time to Kill');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (851, 'This is a description of Book The Lathe of Heaven', 37, '/assets/img/content/main/card2.jpg', false, 1536.096509330353, '2023-02-10', 'f412685c-4079-4f16-8f8a-97373b5b37e9', 'The Lathe of Heaven');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (852, 'This is a description of Book The Wind''s Twelve Quarters', 13, '/assets/img/content/main/card2.jpg', false, 4325.139207903566, '2015-10-29', 'aa9e3579-0a80-47a4-8ad4-0d14c5fb7b32', 'The Wind''s Twelve Quarters');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (853, 'This is a description of Book O Jerusalem!', 19, '/assets/img/content/main/card2.jpg', true, 702.5924648138599, '2016-09-25', 'e0759c8a-d135-4eeb-ac41-2177e5aa5037', 'O Jerusalem!');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (854, 'This is a description of Book A Glass of Blessings', 7, '/assets/img/content/main/card2.jpg', false, 4629.896336153186, '2019-03-29', '7cbb1594-e890-4430-ad15-bf3d88ca06d9', 'A Glass of Blessings');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (855, 'This is a description of Book The Line of Beauty', 6, '/assets/img/content/main/card2.jpg', false, 4830.56872464563, '2020-03-12', '0a3eefca-4ea5-4a16-ad31-2e30f77ad552', 'The Line of Beauty');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (856, 'This is a description of Book Mr Standfast', 8, '/assets/img/content/main/card2.jpg', true, 506.3909134012051, '2018-03-07', '34222de2-4d9d-4772-810a-7bb0c179cd08', 'Mr Standfast');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (857, 'This is a description of Book In a Glass Darkly', 11, '/assets/img/content/main/card2.jpg', true, 4365.881102171639, '2019-07-06', 'af729511-f122-4001-b714-db27b23083f8', 'In a Glass Darkly');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (858, 'This is a description of Book This Side of Paradise', 22, '/assets/img/content/main/card2.jpg', false, 3965.6951997416413, '2014-08-30', '726627e8-c587-4150-a3d6-81f91b8d370b', 'This Side of Paradise');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (859, 'This is a description of Book A Darkling Plain', 39, '/assets/img/content/main/card2.jpg', false, 4116.712238171828, '2021-03-13', '8a9c397b-80ab-4b69-a72f-adacf5e6e571', 'A Darkling Plain');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (860, 'This is a description of Book A Glass of Blessings', 29, '/assets/img/content/main/card2.jpg', true, 4408.651283175717, '2021-09-12', '5a919149-04a7-43db-9ce5-c84696cc7c41', 'A Glass of Blessings');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (861, 'This is a description of Book A Catskill Eagle', 35, '/assets/img/content/main/card2.jpg', true, 1806.8386231641339, '2019-04-19', 'ac89ec4f-9cad-41fd-9eca-b7f9aa60d07b', 'A Catskill Eagle');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (862, 'This is a description of Book Noli Me Tangere', 29, '/assets/img/content/main/card2.jpg', false, 404.86388339740785, '2019-07-25', 'fcd8d8dc-11e9-498d-974e-597acf8df7de', 'Noli Me Tangere');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (863, 'This is a description of Book Beneath the Bleeding', 43, '/assets/img/content/main/card2.jpg', false, 1755.1745989917115, '2021-02-01', '8928369e-6c5a-42ed-a5ad-9351e9663307', 'Beneath the Bleeding');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (864, 'This is a description of Book East of Eden', 26, '/assets/img/content/main/card2.jpg', false, 2308.7455409541462, '2016-01-02', '8efc5e19-c818-44ca-ac70-b5e840329e95', 'East of Eden');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (865, 'This is a description of Book Gone with the Wind', 25, '/assets/img/content/main/card2.jpg', true, 2484.3234708650625, '2013-11-10', '28022ce6-bfd9-4678-adef-404cbffdeda8', 'Gone with the Wind');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (866, 'This is a description of Book Such, Such Were the Joys', 2, '/assets/img/content/main/card2.jpg', true, 2264.707865906207, '2021-11-13', '299e155d-2120-4ac8-8fc7-7c90a4f56b0a', 'Such, Such Were the Joys');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (867, 'This is a description of Book The Glory and the Dream', 12, '/assets/img/content/main/card2.jpg', false, 1254.0478864563172, '2014-05-24', 'c70b6c77-6ab0-4378-b7fc-06f9bd919580', 'The Glory and the Dream');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (868, 'This is a description of Book I Will Fear No Evil', 33, '/assets/img/content/main/card2.jpg', true, 3788.1386498227107, '2020-05-23', 'd3f25806-09cf-4da6-9bce-63460442680a', 'I Will Fear No Evil');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (869, 'This is a description of Book The Yellow Meads of Asphodel', 24, '/assets/img/content/main/card2.jpg', true, 4771.006533413222, '2021-01-04', '9fd4a376-350f-48cc-bcdc-b0ce5c746b48', 'The Yellow Meads of Asphodel');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (870, 'This is a description of Book Alone on a Wide, Wide Sea', 20, '/assets/img/content/main/card2.jpg', true, 4575.955696955098, '2016-05-29', '6e43da5d-46fc-4d1b-b93b-7ff95df4a15c', 'Alone on a Wide, Wide Sea');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (871, 'This is a description of Book The Wings of the Dove', 15, '/assets/img/content/main/card2.jpg', true, 4635.679665495809, '2021-09-19', 'f42a891a-ca1b-4f46-8522-21f20667b1b7', 'The Wings of the Dove');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (872, 'This is a description of Book A Summer Bird-Cage', 28, '/assets/img/content/main/card2.jpg', false, 4448.070332037208, '2018-11-16', '13ed2bb7-a79d-45e6-b4d8-89524c548cea', 'A Summer Bird-Cage');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (873, 'This is a description of Book The Wives of Bath', 50, '/assets/img/content/main/card2.jpg', true, 1018.6190597485669, '2017-11-14', 'bee39447-dd1a-4917-8e5d-b3ab7cfec3a6', 'The Wives of Bath');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (874, 'This is a description of Book A Glass of Blessings', 43, '/assets/img/content/main/card2.jpg', false, 2563.5472060335464, '2017-05-19', '1809b45e-1c14-41bd-a2ac-354740b17255', 'A Glass of Blessings');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (875, 'This is a description of Book Those Barren Leaves, Thrones, Dominations', 32, '/assets/img/content/main/card2.jpg', false, 3363.365179840982, '2018-12-26', '8486f9db-3463-43ab-99c1-938cf9fbde01', 'Those Barren Leaves, Thrones, Dominations');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (876, 'This is a description of Book A Confederacy of Dunces', 46, '/assets/img/content/main/card2.jpg', true, 931.1171260017159, '2017-04-20', '2693ae55-0365-4b0a-8054-c5178b7d1112', 'A Confederacy of Dunces');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (877, 'This is a description of Book A Summer Bird-Cage', 15, '/assets/img/content/main/card2.jpg', true, 1585.0413932129754, '2020-09-28', 'e7eb5a84-b4be-4a2a-aab4-6a12397b9c29', 'A Summer Bird-Cage');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (878, 'This is a description of Book Eyeless in Gaza', 17, '/assets/img/content/main/card2.jpg', true, 3240.7254424114585, '2014-08-14', 'c9ea8e0f-d092-4999-b77e-5ddd1025fcd6', 'Eyeless in Gaza');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (879, 'This is a description of Book The Way Through the Woods', 20, '/assets/img/content/main/card2.jpg', false, 4126.587256612612, '2018-05-07', '9ce5eb57-a90e-419a-8b45-272524f26b63', 'The Way Through the Woods');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (880, 'This is a description of Book Precious Bane', 9, '/assets/img/content/main/card2.jpg', true, 1287.2036667507039, '2022-06-09', '8a4ac0fe-9292-48c1-949b-e199268f4025', 'Precious Bane');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (881, 'This is a description of Book Terrible Swift Sword', 35, '/assets/img/content/main/card2.jpg', true, 4916.264718333654, '2022-08-08', '5fe5bfe3-4ed0-40c5-88e0-5cbe7fdc18cf', 'Terrible Swift Sword');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (882, 'This is a description of Book A Passage to India', 0, '/assets/img/content/main/card2.jpg', false, 1209.8944736032895, '2018-04-22', '340b23e5-2e6d-4b2e-844e-7dbaa3d6ee95', 'A Passage to India');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (883, 'This is a description of Book Vanity Fair', 9, '/assets/img/content/main/card2.jpg', true, 4280.75652854371, '2013-04-30', '1174ecca-6e01-4e5b-a030-494c35b9060c', 'Vanity Fair');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (884, 'This is a description of Book This Side of Paradise', 1, '/assets/img/content/main/card2.jpg', false, 4556.0824466444765, '2015-08-16', '222b1cc4-d83a-47e5-b8b0-265948186c47', 'This Side of Paradise');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (885, 'This is a description of Book The Painted Veil', 33, '/assets/img/content/main/card2.jpg', true, 3278.2785251077376, '2019-03-02', '560a5b19-57b3-484d-8ffb-1bd700035cdf', 'The Painted Veil');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (886, 'This is a description of Book This Lime Tree Bower', 45, '/assets/img/content/main/card2.jpg', false, 439.56161561881953, '2018-12-23', '2fcedbf7-b7bb-452c-828e-8a4b7dce8f9d', 'This Lime Tree Bower');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (887, 'This is a description of Book Precious Bane', 5, '/assets/img/content/main/card2.jpg', false, 2463.4094627190075, '2019-10-17', '40408886-6ac2-41a6-be53-75f11d297b26', 'Precious Bane');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (888, 'This is a description of Book Antic Hay', 29, '/assets/img/content/main/card2.jpg', false, 1098.267132864874, '2015-04-12', 'd9f7870b-5e1e-47a5-8dd5-5150cbaa7d3b', 'Antic Hay');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (889, 'This is a description of Book As I Lay Dying', 42, '/assets/img/content/main/card2.jpg', false, 3607.175752301971, '2020-08-10', '03bc422c-aedd-4586-9c14-cc7d71fb5ffa', 'As I Lay Dying');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (890, 'This is a description of Book Tirra Lirra by the River', 32, '/assets/img/content/main/card2.jpg', true, 1443.0078630764324, '2016-03-24', '29313924-65b0-4d8a-a52c-283f596ebdff', 'Tirra Lirra by the River');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (891, 'This is a description of Book The Road Less Traveled', 32, '/assets/img/content/main/card2.jpg', true, 1595.5453177277923, '2019-10-29', '2a8a22d0-9341-451b-a2a4-295ad8249913', 'The Road Less Traveled');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (892, 'This is a description of Book As I Lay Dying', 33, '/assets/img/content/main/card2.jpg', true, 955.3390894357073, '2022-06-29', '7d4b8e61-9b0a-4d72-9224-d47f707118ac', 'As I Lay Dying');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (893, 'This is a description of Book Death Be Not Proud', 10, '/assets/img/content/main/card2.jpg', false, 1824.2255792044195, '2022-05-13', '33d3d29f-124d-40ed-8526-270bd4794b7a', 'Death Be Not Proud');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (894, 'This is a description of Book The Grapes of Wrath', 43, '/assets/img/content/main/card2.jpg', true, 4543.1242329850575, '2019-03-28', '4b20b61e-7537-49c6-b1fa-dcf7d26fb3cc', 'The Grapes of Wrath');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (895, 'This is a description of Book The Skull Beneath the Skin', 42, '/assets/img/content/main/card2.jpg', false, 3078.225534053794, '2017-01-01', '4fc0b8c8-57fc-427e-bc02-2a4becc5345b', 'The Skull Beneath the Skin');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (896, 'This is a description of Book I Sing the Body Electric', 40, '/assets/img/content/main/card2.jpg', false, 883.4500706867399, '2013-11-25', '74a7d537-f974-4d6b-b68b-09181cf900ee', 'I Sing the Body Electric');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (897, 'This is a description of Book Carrion Comfort', 32, '/assets/img/content/main/card2.jpg', true, 2426.3405932604824, '2017-01-09', '74bf573e-c2f2-4094-80ab-cca5233fed3a', 'Carrion Comfort');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (898, 'This is a description of Book Terrible Swift Sword', 3, '/assets/img/content/main/card2.jpg', true, 4617.114430928008, '2017-10-08', '953d41a3-626c-4dd5-a470-d962c5b4e7f7', 'Terrible Swift Sword');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (899, 'This is a description of Book The Monkey''s Raincoat', 26, '/assets/img/content/main/card2.jpg', true, 3051.7201946239597, '2022-05-11', 'bc93f916-f66a-4f54-a02b-6d00b659e61c', 'The Monkey''s Raincoat');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (900, 'This is a description of Book Sleep the Brave', 18, '/assets/img/content/main/card2.jpg', true, 585.7161246078188, '2017-07-16', 'a3960ac6-2707-4461-a57a-096836857acd', 'Sleep the Brave');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (901, 'This is a description of Book Such, Such Were the Joys', 8, '/assets/img/content/main/card2.jpg', false, 4156.260568496876, '2016-12-08', '1213e8de-a451-4245-8b29-1b48056f5158', 'Such, Such Were the Joys');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (902, 'This is a description of Book A Catskill Eagle', 25, '/assets/img/content/main/card2.jpg', true, 417.49569415977527, '2021-01-04', 'f8a72442-cbae-4ee7-bc4e-14a79dd1bad5', 'A Catskill Eagle');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (903, 'This is a description of Book Pale Kings and Princes', 49, '/assets/img/content/main/card2.jpg', false, 1071.3660764635526, '2017-01-19', 'b0c38bc9-1c40-4bb0-b107-5a311316ef88', 'Pale Kings and Princes');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (904, 'This is a description of Book Far From the Madding Crowd', 2, '/assets/img/content/main/card2.jpg', true, 196.03856378158613, '2013-08-03', '665f73ac-0d1f-4b64-a9e4-717587f3066a', 'Far From the Madding Crowd');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (905, 'This is a description of Book Alone on a Wide, Wide Sea', 44, '/assets/img/content/main/card2.jpg', true, 4554.889347866307, '2014-10-06', '31e3e13a-1a49-4bb0-8659-a1343f03e55f', 'Alone on a Wide, Wide Sea');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (906, 'This is a description of Book A Many-Splendoured Thing', 14, '/assets/img/content/main/card2.jpg', true, 2959.029860892767, '2017-10-15', '8b9d0681-aefc-4df1-b236-e8e3d9e08371', 'A Many-Splendoured Thing');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (907, 'This is a description of Book Endless Night', 43, '/assets/img/content/main/card2.jpg', true, 4387.899445947188, '2016-05-23', '024b3cee-491a-42bc-8f5c-3fb25a8782bb', 'Endless Night');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (908, 'This is a description of Book Vanity Fair', 21, '/assets/img/content/main/card2.jpg', true, 1918.6974325773376, '2022-06-25', '928d90b5-9302-430b-b6d6-f3ee83482e1a', 'Vanity Fair');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (909, 'This is a description of Book Tirra Lirra by the River', 23, '/assets/img/content/main/card2.jpg', false, 1807.5543302166418, '2023-01-24', 'f85c130f-e891-41a5-a963-abb53bde2ddf', 'Tirra Lirra by the River');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (910, 'This is a description of Book Sleep the Brave', 10, '/assets/img/content/main/card2.jpg', false, 2030.88566087633, '2017-10-11', '32e917df-719a-42e8-8099-2e4484711336', 'Sleep the Brave');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (911, 'This is a description of Book No Highway', 15, '/assets/img/content/main/card2.jpg', true, 144.34413393280576, '2016-11-10', '11e6bd5e-a13c-42c7-8416-1d502756cf1a', 'No Highway');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (912, 'This is a description of Book The Mirror Crack''d from Side to Side', 0, '/assets/img/content/main/card2.jpg', true, 3309.8412193527897, '2014-03-09', '2a037927-d0ba-438d-b81f-9bec86314a36', 'The Mirror Crack''d from Side to Side');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (913, 'This is a description of Book His Dark Materials', 2, '/assets/img/content/main/card2.jpg', false, 4468.5098201570845, '2021-04-25', '110b08cf-0217-4e2d-9cb0-4b87028a84da', 'His Dark Materials');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (914, 'This is a description of Book A Glass of Blessings', 29, '/assets/img/content/main/card2.jpg', false, 1836.4709173179233, '2014-06-03', 'b011d1c4-4060-4b36-b597-89507cd49aac', 'A Glass of Blessings');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (915, 'This is a description of Book A Monstrous Regiment of Women', 12, '/assets/img/content/main/card2.jpg', true, 1434.5715593183786, '2016-11-29', 'cc3bb2b2-d1a1-400f-8f73-657caa07a56e', 'A Monstrous Regiment of Women');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (916, 'This is a description of Book This Lime Tree Bower', 39, '/assets/img/content/main/card2.jpg', true, 4781.743632841194, '2017-09-08', 'dd73db73-5b16-4639-8de4-70b44f381d52', 'This Lime Tree Bower');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (917, 'This is a description of Book Down to a Sunless Sea', 4, '/assets/img/content/main/card2.jpg', true, 2103.7760075841984, '2020-05-27', '4a1492f0-4586-4852-bb54-be39e6753b17', 'Down to a Sunless Sea');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (918, 'This is a description of Book The Cricket on the Hearth', 34, '/assets/img/content/main/card2.jpg', true, 1096.9797956519124, '2017-10-23', '2c43721f-46ae-42c0-8542-4bd82de4460b', 'The Cricket on the Hearth');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (919, 'This is a description of Book A Glass of Blessings', 28, '/assets/img/content/main/card2.jpg', false, 2462.404252370395, '2017-03-15', '44219ae3-dafe-4004-ab1b-129eb754d695', 'A Glass of Blessings');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (920, 'This is a description of Book Such, Such Were the Joys', 24, '/assets/img/content/main/card2.jpg', false, 1224.4140818192302, '2013-11-07', 'e3930aeb-920a-4b61-9948-cffdf1023bd5', 'Such, Such Were the Joys');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (921, 'This is a description of Book A Scanner Darkly', 2, '/assets/img/content/main/card2.jpg', true, 4430.394600732733, '2015-05-28', 'f20a9e2a-b661-4913-9ea4-6a45e44f8add', 'A Scanner Darkly');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (922, 'This is a description of Book Tiger! Tiger!', 49, '/assets/img/content/main/card2.jpg', true, 1627.7754301035327, '2013-06-12', '39a02e94-20a1-4bf1-bbc5-351781d9c7b3', 'Tiger! Tiger!');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (923, 'This is a description of Book The Skull Beneath the Skin', 47, '/assets/img/content/main/card2.jpg', true, 2845.6080626282996, '2021-01-15', '7326f3e6-ea0d-47f6-adf9-9b0f1d60d118', 'The Skull Beneath the Skin');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (924, 'This is a description of Book Blood''s a Rover', 25, '/assets/img/content/main/card2.jpg', true, 1456.8330682253038, '2020-01-03', 'd7a5b5f8-cad5-475a-8afe-45b0c56734ab', 'Blood''s a Rover');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (925, 'This is a description of Book I Will Fear No Evil', 31, '/assets/img/content/main/card2.jpg', true, 170.39014492303033, '2022-02-02', 'abf019dd-5a04-485a-ac33-c64af81054da', 'I Will Fear No Evil');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (926, 'This is a description of Book Vanity Fair', 1, '/assets/img/content/main/card2.jpg', false, 4985.272203962221, '2021-11-06', 'b52cd1ac-578c-4dde-a24b-42973ccbba9f', 'Vanity Fair');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (927, 'This is a description of Book If I Forget Thee Jerusalem', 2, '/assets/img/content/main/card2.jpg', false, 3320.3106179505744, '2016-06-26', '313abfe4-af2f-4cbb-9a2b-6eb9be6c7f27', 'If I Forget Thee Jerusalem');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (928, 'This is a description of Book Recalled to Life', 42, '/assets/img/content/main/card2.jpg', true, 1719.7370233865563, '2014-02-01', '08a1e84f-6554-4491-8c5b-5cccd71db15d', 'Recalled to Life');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (929, 'This is a description of Book A Time of Gifts', 30, '/assets/img/content/main/card2.jpg', false, 4117.152816602112, '2020-05-27', 'fefc70b4-41a8-4dea-be48-769c2399c64e', 'A Time of Gifts');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (930, 'This is a description of Book The Moon by Night', 31, '/assets/img/content/main/card2.jpg', false, 4910.99465520651, '2018-02-09', '22a0bb5e-78ca-4a2f-b914-dddb4bd39db2', 'The Moon by Night');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (931, 'This is a description of Book Blood''s a Rover', 37, '/assets/img/content/main/card2.jpg', false, 3762.2947349868537, '2015-02-11', '94170741-4a59-4cac-abaa-894d072ab316', 'Blood''s a Rover');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (932, 'This is a description of Book No Highway', 32, '/assets/img/content/main/card2.jpg', true, 4638.4991878812525, '2018-05-14', '25195dac-c030-445f-aee1-d05c838e1761', 'No Highway');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (933, 'This is a description of Book Mr Standfast', 31, '/assets/img/content/main/card2.jpg', false, 4637.603990562802, '2018-02-03', 'cf20ba75-f884-4be9-9696-99e4a09d46e1', 'Mr Standfast');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (934, 'This is a description of Book Eyeless in Gaza', 21, '/assets/img/content/main/card2.jpg', false, 1985.9714239878124, '2017-06-13', '4ccaecb4-0334-43cc-9f4a-bd2417186812', 'Eyeless in Gaza');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (935, 'This is a description of Book The Torment of Others', 0, '/assets/img/content/main/card2.jpg', true, 521.2453639517686, '2015-06-09', 'a5cd6620-919b-449e-b6ad-5bd594787517', 'The Torment of Others');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (936, 'This is a description of Book By Grand Central Station I Sat Down and Wept', 25, '/assets/img/content/main/card2.jpg', true, 1012.2439555911193, '2019-07-30', '3a986134-e587-430e-bd88-00a29156177c', 'By Grand Central Station I Sat Down and Wept');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (937, 'This is a description of Book The Other Side of Silence', 42, '/assets/img/content/main/card2.jpg', true, 1351.3701354074865, '2018-09-01', 'd1fc0c2c-59cb-40b5-a3f8-14cbb97b97b7', 'The Other Side of Silence');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (938, 'This is a description of Book The Monkey''s Raincoat', 25, '/assets/img/content/main/card2.jpg', true, 2389.5728543751234, '2020-03-16', 'd0709128-5a87-49d0-997d-c3d81a283a51', 'The Monkey''s Raincoat');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (939, 'This is a description of Book Far From the Madding Crowd', 37, '/assets/img/content/main/card2.jpg', false, 3230.3772828299657, '2015-02-08', 'adc9a020-e7ba-43ba-9769-ccace153984a', 'Far From the Madding Crowd');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (940, 'This is a description of Book Ego Dominus Tuus', 25, '/assets/img/content/main/card2.jpg', false, 4379.891673056465, '2015-02-24', '3f120dae-c053-40e3-bc84-73e74d7c1260', 'Ego Dominus Tuus');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (941, 'This is a description of Book The Way of All Flesh', 27, '/assets/img/content/main/card2.jpg', true, 1773.2736009037044, '2013-04-05', 'db82b46c-e9db-461c-beb8-530b0485bc9a', 'The Way of All Flesh');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (942, 'This is a description of Book To Sail Beyond the Sunset', 46, '/assets/img/content/main/card2.jpg', true, 4675.319807347496, '2014-02-19', '46e51d9f-c8b3-4d7e-8bcb-0ff20a00737e', 'To Sail Beyond the Sunset');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (943, 'This is a description of Book Françoise Sagan', 47, '/assets/img/content/main/card2.jpg', true, 2049.9381398906726, '2017-12-05', '5209525c-2b20-40fb-8bcb-a5849a7175a9', 'Françoise Sagan');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (944, 'This is a description of Book A Farewell to Arms', 34, '/assets/img/content/main/card2.jpg', true, 3159.359205232873, '2014-01-22', 'e3580002-8055-47f5-b491-a201045cd10a', 'A Farewell to Arms');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (945, 'This is a description of Book Fame Is the Spur', 5, '/assets/img/content/main/card2.jpg', false, 2481.7506178179888, '2016-10-01', 'fdfe73a9-7b8d-45dd-9ba3-2b10a1d34b41', 'Fame Is the Spur');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (946, 'This is a description of Book Specimen Days', 9, '/assets/img/content/main/card2.jpg', true, 3338.078937933502, '2020-03-08', '5a42a445-c79e-4a3a-84b8-3ef1d6b7a52c', 'Specimen Days');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (947, 'This is a description of Book Ego Dominus Tuus', 24, '/assets/img/content/main/card2.jpg', false, 454.8675753412552, '2017-03-22', 'e6bdd644-5de5-49ed-9da3-81b2bf40ae3a', 'Ego Dominus Tuus');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (948, 'This is a description of Book Dulce et Decorum Est', 46, '/assets/img/content/main/card2.jpg', false, 439.63864933914147, '2019-10-12', 'aea25a69-7e3b-4a69-a380-a649b9befaf8', 'Dulce et Decorum Est');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (949, 'This is a description of Book Absalom, Absalom!', 11, '/assets/img/content/main/card2.jpg', false, 3984.327339554194, '2022-03-16', '198c4b10-2f94-471f-ac76-8f017daaaf6e', 'Absalom, Absalom!');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (950, 'This is a description of Book Time of our Darkness', 47, '/assets/img/content/main/card2.jpg', false, 3720.4161346848978, '2015-06-02', '2ab97c93-555f-4883-996b-be520a4399d5', 'Time of our Darkness');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (951, 'This is a description of Book Fear and Trembling', 18, '/assets/img/content/main/card2.jpg', true, 4436.398036440167, '2018-01-30', '85a4a536-f1c4-4ef6-a823-633d377ba32b', 'Fear and Trembling');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (952, 'This is a description of Book The World, the Flesh and the Devil', 25, '/assets/img/content/main/card2.jpg', true, 4203.942398713307, '2020-12-25', '7e7757ed-e785-43c8-8de9-cd90ed0853fd', 'The World, the Flesh and the Devil');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (953, 'This is a description of Book The Moving Finger', 19, '/assets/img/content/main/card2.jpg', true, 4345.024011797499, '2019-05-05', '8da82a65-77b4-4e89-8cdd-15cc80409af5', 'The Moving Finger');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (954, 'This is a description of Book Cover Her Face', 6, '/assets/img/content/main/card2.jpg', true, 1751.7050141712455, '2016-04-19', 'c5d05dfa-58cd-4951-9999-8903f2f5c43f', 'Cover Her Face');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (955, 'This is a description of Book For Whom the Bell Tolls', 8, '/assets/img/content/main/card2.jpg', false, 4673.606532544714, '2016-05-26', '00cbaa99-09e7-4b98-b1a5-4f2dd8f7f8ce', 'For Whom the Bell Tolls');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (956, 'This is a description of Book After Many a Summer Dies the Swan', 16, '/assets/img/content/main/card2.jpg', true, 2005.5373289190427, '2014-03-11', '7d80bc4d-cfad-43ff-b5c1-11f5429b5b89', 'After Many a Summer Dies the Swan');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (957, 'This is a description of Book Vanity Fair', 11, '/assets/img/content/main/card2.jpg', true, 3820.515365145161, '2019-03-06', '9412be6b-42c6-4308-a3e5-775482fd35cb', 'Vanity Fair');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (958, 'This is a description of Book Where Angels Fear to Tread', 4, '/assets/img/content/main/card2.jpg', true, 906.8813099631457, '2017-01-20', 'd853f4d5-4363-41de-b001-840cd44d6a4b', 'Where Angels Fear to Tread');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (959, 'This is a description of Book To Sail Beyond the Sunset', 41, '/assets/img/content/main/card2.jpg', false, 1807.8689601745818, '2017-03-31', '19626609-58f2-4c06-8e31-177f41d5ae6f', 'To Sail Beyond the Sunset');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (960, 'This is a description of Book The Mirror Crack''d from Side to Side', 18, '/assets/img/content/main/card2.jpg', false, 225.29419839586757, '2017-08-19', '4e40bcb5-ebc6-4e06-908b-547be4420788', 'The Mirror Crack''d from Side to Side');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (961, 'This is a description of Book Such, Such Were the Joys', 35, '/assets/img/content/main/card2.jpg', false, 4692.0520825157855, '2015-09-11', 'e99f0941-a1f4-40f5-b5b7-9248927d0242', 'Such, Such Were the Joys');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (962, 'This is a description of Book The Daffodil Sky', 9, '/assets/img/content/main/card2.jpg', true, 4453.496689284331, '2018-06-14', '18121071-b1ec-49a5-ab15-791a5f6aa220', 'The Daffodil Sky');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (963, 'This is a description of Book The Millstone', 31, '/assets/img/content/main/card2.jpg', true, 555.829760069094, '2014-02-23', 'df054f42-676e-48f3-b1c5-494b6689a15d', 'The Millstone');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (964, 'This is a description of Book The Last Enemy', 30, '/assets/img/content/main/card2.jpg', true, 3149.350426945399, '2016-07-03', '875e1d8b-6d63-4a0e-9e96-77d96705e34f', 'The Last Enemy');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (965, 'This is a description of Book The House of Mirth', 18, '/assets/img/content/main/card2.jpg', false, 3134.5437018146904, '2021-03-17', 'b882e867-b9ce-4f3a-ab0c-c37c9784fc5a', 'The House of Mirth');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (966, 'This is a description of Book Far From the Madding Crowd', 17, '/assets/img/content/main/card2.jpg', false, 4737.956977043214, '2021-09-17', '466ec9d3-a032-4828-bfe9-3190c19705b6', 'Far From the Madding Crowd');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (967, 'This is a description of Book The Heart Is a Lonely Hunter', 21, '/assets/img/content/main/card2.jpg', true, 2977.879551802161, '2013-08-20', 'f6ae03c9-ce65-4437-85cc-5f4366b4e5a1', 'The Heart Is a Lonely Hunter');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (968, 'This is a description of Book Recalled to Life', 22, '/assets/img/content/main/card2.jpg', true, 3961.625234714375, '2020-10-28', 'd14ccfa0-5d1d-4432-8ffa-17247c8b8c61', 'Recalled to Life');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (969, 'This is a description of Book Time of our Darkness', 27, '/assets/img/content/main/card2.jpg', false, 1296.8175716456085, '2015-09-04', '1bc8df6d-0e90-47b3-ac19-49c4112d9e4f', 'Time of our Darkness');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (970, 'This is a description of Book This Lime Tree Bower', 49, '/assets/img/content/main/card2.jpg', false, 4582.52996162356, '2019-11-26', 'bc8de75d-165e-4817-923d-592e2f9d19df', 'This Lime Tree Bower');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (971, 'This is a description of Book As I Lay Dying', 41, '/assets/img/content/main/card2.jpg', false, 1954.2320241264927, '2023-02-10', '90d07fd1-e9ae-4511-85cf-f94ae9e73aaa', 'As I Lay Dying');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (972, 'This is a description of Book Dying of the Light', 2, '/assets/img/content/main/card2.jpg', false, 3617.23569547087, '2013-10-12', '874238ba-8571-43f8-b0c0-280b0c1e9a41', 'Dying of the Light');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (973, 'This is a description of Book The Widening Gyre', 0, '/assets/img/content/main/card2.jpg', true, 371.9014857801979, '2015-12-25', 'bfa90362-0e68-447a-8c91-a521464d0489', 'The Widening Gyre');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (974, 'This is a description of Book Postern of Fate', 38, '/assets/img/content/main/card2.jpg', false, 4232.876902363638, '2013-10-01', '2020c458-54c5-4f44-bf2f-93304651d9c7', 'Postern of Fate');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (975, 'This is a description of Book Tirra Lirra by the River', 47, '/assets/img/content/main/card2.jpg', false, 2279.5087414439618, '2016-09-02', '58561ec6-9f95-41cc-ab95-1465732c4122', 'Tirra Lirra by the River');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (976, 'This is a description of Book I Know Why the Caged Bird Sings', 47, '/assets/img/content/main/card2.jpg', true, 2583.1405778778503, '2018-09-29', '3d5132e6-e816-45b8-a3d2-d02d52bfc82c', 'I Know Why the Caged Bird Sings');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (977, 'This is a description of Book A Summer Bird-Cage', 22, '/assets/img/content/main/card2.jpg', false, 3874.229379881647, '2013-07-23', '031eb29c-bda7-4e66-a661-0db1b769d6ad', 'A Summer Bird-Cage');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (978, 'This is a description of Book No Country for Old Men', 5, '/assets/img/content/main/card2.jpg', false, 4347.499553831672, '2018-04-04', '413c5ea1-d9de-4f08-ab22-b1c5ab68069f', 'No Country for Old Men');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (979, 'This is a description of Book O Pioneers!', 22, '/assets/img/content/main/card2.jpg', false, 1524.2766607728915, '2019-04-15', 'ac847f6f-763b-4284-a6b7-26c0f6850547', 'O Pioneers!');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (980, 'This is a description of Book The Needle''s Eye', 5, '/assets/img/content/main/card2.jpg', false, 2987.58591877225, '2017-12-07', '69ebad82-d366-4394-9e44-3f3f6e8d9265', 'The Needle''s Eye');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (981, 'This is a description of Book I Know Why the Caged Bird Sings', 38, '/assets/img/content/main/card2.jpg', true, 3137.9399820740587, '2015-04-10', '65c48027-f4e2-4a80-bcb7-6d771844e3f5', 'I Know Why the Caged Bird Sings');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (982, 'This is a description of Book By Grand Central Station I Sat Down and Wept', 29, '/assets/img/content/main/card2.jpg', false, 2696.600967557918, '2022-08-08', 'bf272dbb-3832-4623-a478-af6d34330770', 'By Grand Central Station I Sat Down and Wept');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (983, 'This is a description of Book Some Buried Caesar', 48, '/assets/img/content/main/card2.jpg', true, 1999.2380350586243, '2014-01-25', '66d4d367-1476-4b70-83e6-bd1b29516c8c', 'Some Buried Caesar');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (984, 'This is a description of Book Far From the Madding Crowd', 45, '/assets/img/content/main/card2.jpg', false, 4195.14209293451, '2013-11-07', '93611dc9-51cd-4a13-a05e-a5e908c36b81', 'Far From the Madding Crowd');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (985, 'This is a description of Book Specimen Days', 44, '/assets/img/content/main/card2.jpg', false, 1400.9275662079115, '2020-11-12', 'f948b3b0-88ee-4592-9c03-ef36a7716416', 'Specimen Days');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (986, 'This is a description of Book The Soldier''s Art', 22, '/assets/img/content/main/card2.jpg', false, 1206.4335267967374, '2021-08-09', '9e8ec729-9847-4483-a6b3-ffa18c99aa73', 'The Soldier''s Art');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (987, 'This is a description of Book Down to a Sunless Sea', 41, '/assets/img/content/main/card2.jpg', false, 2199.7460127919735, '2022-09-28', 'beeaf0f8-82da-413f-bdaa-6ed55cd634a2', 'Down to a Sunless Sea');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (988, 'This is a description of Book Many Waters', 44, '/assets/img/content/main/card2.jpg', true, 2171.3067140360386, '2016-04-07', '3bfe1408-79ba-46a2-aadd-834771620a4d', 'Many Waters');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (989, 'This is a description of Book For Whom the Bell Tolls', 7, '/assets/img/content/main/card2.jpg', false, 1102.0119650159656, '2016-12-22', 'c548faa2-bc76-4351-8a7e-8a510dd49869', 'For Whom the Bell Tolls');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (990, 'This is a description of Book O Pioneers!', 38, '/assets/img/content/main/card2.jpg', false, 3370.2516156559345, '2022-04-14', 'ef2846b8-5558-482c-9432-2e140175415d', 'O Pioneers!');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (991, 'This is a description of Book Tender Is the Night', 8, '/assets/img/content/main/card2.jpg', true, 2301.0116254455993, '2014-03-07', '5fe23385-fead-4ce0-adbe-2210938b9dec', 'Tender Is the Night');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (992, 'This is a description of Book Have His Carcase', 29, '/assets/img/content/main/card2.jpg', false, 863.8010217825862, '2017-02-18', '6a801dde-7d5d-4df0-b02a-1b5c92714010', 'Have His Carcase');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (993, 'This is a description of Book Unweaving the Rainbow', 38, '/assets/img/content/main/card2.jpg', false, 1159.5217579506555, '2016-11-20', '29cc3e16-451e-4103-8086-283a31618242', 'Unweaving the Rainbow');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (994, 'This is a description of Book That Hideous Strength', 44, '/assets/img/content/main/card2.jpg', true, 1432.4990189656876, '2021-03-04', '9a214bb3-e096-45f7-8a31-abbf21a0b7ba', 'That Hideous Strength');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (995, 'This is a description of Book Nine Coaches Waiting', 42, '/assets/img/content/main/card2.jpg', false, 686.7789882774222, '2022-09-14', '2cfa2e01-c964-4c72-b273-a1e15dae69b1', 'Nine Coaches Waiting');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (996, 'This is a description of Book Unweaving the Rainbow', 19, '/assets/img/content/main/card2.jpg', false, 3629.8094806854824, '2021-10-03', 'dd0b4118-5b63-4d69-a53e-90557a38da7d', 'Unweaving the Rainbow');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (997, 'This is a description of Book O Pioneers!', 49, '/assets/img/content/main/card2.jpg', true, 2679.730056162872, '2018-10-08', 'b209277a-a360-4ac5-a315-e50e3c872f57', 'O Pioneers!');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (998, 'This is a description of Book Cover Her Face', 38, '/assets/img/content/main/card2.jpg', false, 4240.8425945492445, '2013-10-20', '2b9f9522-4518-44f5-810b-4f713ba8ebc0', 'Cover Her Face');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (999, 'This is a description of Book The Doors of Perception', 34, '/assets/img/content/main/card2.jpg', false, 4136.375421754891, '2017-07-11', 'ae06e28b-e01d-498c-a3db-be8a3ee926ee', 'The Doors of Perception');
INSERT INTO book_store.books (id, description, discount, image, is_bestseller, price, pub_date, slug, title) VALUES (1000, 'This is a description of Book Shall not Perish', 13, '/assets/img/content/main/card2.jpg', true, 3364.503135987566, '2018-10-24', '9de8c17e-6695-4389-aa29-005a200ec3b1', 'Shall not Perish');


--
-- Data for Name: document; Type: TABLE DATA; Schema: book_store; Owner: postgres
--



--
-- Data for Name: faq; Type: TABLE DATA; Schema: book_store; Owner: postgres
--



--
-- Data for Name: file_download; Type: TABLE DATA; Schema: book_store; Owner: postgres
--



--
-- Data for Name: genre; Type: TABLE DATA; Schema: book_store; Owner: postgres
--



--
-- Data for Name: message; Type: TABLE DATA; Schema: book_store; Owner: postgres
--



--
-- Data for Name: user_contact; Type: TABLE DATA; Schema: book_store; Owner: postgres
--



--
-- Data for Name: users; Type: TABLE DATA; Schema: book_store; Owner: postgres
--



--
-- Name: author_id_seq; Type: SEQUENCE SET; Schema: book_store; Owner: postgres
--

SELECT pg_catalog.setval('book_store.author_id_seq', 1, false);


--
-- Name: balance_transaction_id_seq; Type: SEQUENCE SET; Schema: book_store; Owner: postgres
--

SELECT pg_catalog.setval('book_store.balance_transaction_id_seq', 1, false);


--
-- Name: book2author_id_seq; Type: SEQUENCE SET; Schema: book_store; Owner: postgres
--

SELECT pg_catalog.setval('book_store.book2author_id_seq', 1, false);


--
-- Name: book2genre_id_seq; Type: SEQUENCE SET; Schema: book_store; Owner: postgres
--

SELECT pg_catalog.setval('book_store.book2genre_id_seq', 1, false);


--
-- Name: book2user_id_seq; Type: SEQUENCE SET; Schema: book_store; Owner: postgres
--

SELECT pg_catalog.setval('book_store.book2user_id_seq', 1, false);


--
-- Name: book2user_type_id_seq; Type: SEQUENCE SET; Schema: book_store; Owner: postgres
--

SELECT pg_catalog.setval('book_store.book2user_type_id_seq', 1, false);


--
-- Name: book_file_id_seq; Type: SEQUENCE SET; Schema: book_store; Owner: postgres
--

SELECT pg_catalog.setval('book_store.book_file_id_seq', 1, false);


--
-- Name: book_file_type_id_seq; Type: SEQUENCE SET; Schema: book_store; Owner: postgres
--

SELECT pg_catalog.setval('book_store.book_file_type_id_seq', 1, false);


--
-- Name: book_id_seq; Type: SEQUENCE SET; Schema: book_store; Owner: postgres
--

SELECT pg_catalog.setval('book_store.book_id_seq', 1, false);


--
-- Name: book_review_id_seq; Type: SEQUENCE SET; Schema: book_store; Owner: postgres
--

SELECT pg_catalog.setval('book_store.book_review_id_seq', 1, false);


--
-- Name: book_review_like_id_seq; Type: SEQUENCE SET; Schema: book_store; Owner: postgres
--

SELECT pg_catalog.setval('book_store.book_review_like_id_seq', 1, false);


--
-- Name: document_id_seq; Type: SEQUENCE SET; Schema: book_store; Owner: postgres
--

SELECT pg_catalog.setval('book_store.document_id_seq', 1, false);


--
-- Name: faq_id_seq; Type: SEQUENCE SET; Schema: book_store; Owner: postgres
--

SELECT pg_catalog.setval('book_store.faq_id_seq', 1, false);


--
-- Name: file_download_id_seq; Type: SEQUENCE SET; Schema: book_store; Owner: postgres
--

SELECT pg_catalog.setval('book_store.file_download_id_seq', 1, false);


--
-- Name: genre_id_seq; Type: SEQUENCE SET; Schema: book_store; Owner: postgres
--

SELECT pg_catalog.setval('book_store.genre_id_seq', 1, false);


--
-- Name: message_id_seq; Type: SEQUENCE SET; Schema: book_store; Owner: postgres
--

SELECT pg_catalog.setval('book_store.message_id_seq', 1, false);


--
-- Name: user_contact_id_seq; Type: SEQUENCE SET; Schema: book_store; Owner: postgres
--

SELECT pg_catalog.setval('book_store.user_contact_id_seq', 1, false);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: book_store; Owner: postgres
--

SELECT pg_catalog.setval('book_store.user_id_seq', 1, false);


--
-- Name: authors authors_pkey; Type: CONSTRAINT; Schema: book_store; Owner: postgres
--

ALTER TABLE ONLY book_store.authors
    ADD CONSTRAINT authors_pkey PRIMARY KEY (id);


--
-- Name: balance_transaction balance_transaction_pkey; Type: CONSTRAINT; Schema: book_store; Owner: postgres
--

ALTER TABLE ONLY book_store.balance_transaction
    ADD CONSTRAINT balance_transaction_pkey PRIMARY KEY (id);


--
-- Name: book2author book2author_pkey; Type: CONSTRAINT; Schema: book_store; Owner: postgres
--

ALTER TABLE ONLY book_store.book2author
    ADD CONSTRAINT book2author_pkey PRIMARY KEY (id);


--
-- Name: book2genre book2genre_pkey; Type: CONSTRAINT; Schema: book_store; Owner: postgres
--

ALTER TABLE ONLY book_store.book2genre
    ADD CONSTRAINT book2genre_pkey PRIMARY KEY (id);


--
-- Name: book2user book2user_pkey; Type: CONSTRAINT; Schema: book_store; Owner: postgres
--

ALTER TABLE ONLY book_store.book2user
    ADD CONSTRAINT book2user_pkey PRIMARY KEY (id);


--
-- Name: book2user_type book2user_type_pkey; Type: CONSTRAINT; Schema: book_store; Owner: postgres
--

ALTER TABLE ONLY book_store.book2user_type
    ADD CONSTRAINT book2user_type_pkey PRIMARY KEY (id);


--
-- Name: book_file book_file_pkey; Type: CONSTRAINT; Schema: book_store; Owner: postgres
--

ALTER TABLE ONLY book_store.book_file
    ADD CONSTRAINT book_file_pkey PRIMARY KEY (id);


--
-- Name: book_file_type book_file_type_pkey; Type: CONSTRAINT; Schema: book_store; Owner: postgres
--

ALTER TABLE ONLY book_store.book_file_type
    ADD CONSTRAINT book_file_type_pkey PRIMARY KEY (id);


--
-- Name: book_review_like book_review_like_pkey; Type: CONSTRAINT; Schema: book_store; Owner: postgres
--

ALTER TABLE ONLY book_store.book_review_like
    ADD CONSTRAINT book_review_like_pkey PRIMARY KEY (id);


--
-- Name: book_review book_review_pkey; Type: CONSTRAINT; Schema: book_store; Owner: postgres
--

ALTER TABLE ONLY book_store.book_review
    ADD CONSTRAINT book_review_pkey PRIMARY KEY (id);


--
-- Name: books books_pkey; Type: CONSTRAINT; Schema: book_store; Owner: postgres
--

ALTER TABLE ONLY book_store.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- Name: document document_pkey; Type: CONSTRAINT; Schema: book_store; Owner: postgres
--

ALTER TABLE ONLY book_store.document
    ADD CONSTRAINT document_pkey PRIMARY KEY (id);


--
-- Name: faq faq_pkey; Type: CONSTRAINT; Schema: book_store; Owner: postgres
--

ALTER TABLE ONLY book_store.faq
    ADD CONSTRAINT faq_pkey PRIMARY KEY (id);


--
-- Name: file_download file_download_pkey; Type: CONSTRAINT; Schema: book_store; Owner: postgres
--

ALTER TABLE ONLY book_store.file_download
    ADD CONSTRAINT file_download_pkey PRIMARY KEY (id);


--
-- Name: genre genre_pkey; Type: CONSTRAINT; Schema: book_store; Owner: postgres
--

ALTER TABLE ONLY book_store.genre
    ADD CONSTRAINT genre_pkey PRIMARY KEY (id);


--
-- Name: message message_pkey; Type: CONSTRAINT; Schema: book_store; Owner: postgres
--

ALTER TABLE ONLY book_store.message
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);


--
-- Name: authors uk_50058x3s3i9lcreapeth7bbsw; Type: CONSTRAINT; Schema: book_store; Owner: postgres
--

ALTER TABLE ONLY book_store.authors
    ADD CONSTRAINT uk_50058x3s3i9lcreapeth7bbsw UNIQUE (slug);


--
-- Name: books uk_67hmc2c9xvynx28p9f1wl6prb; Type: CONSTRAINT; Schema: book_store; Owner: postgres
--

ALTER TABLE ONLY book_store.books
    ADD CONSTRAINT uk_67hmc2c9xvynx28p9f1wl6prb UNIQUE (slug);


--
-- Name: user_contact user_contact_pkey; Type: CONSTRAINT; Schema: book_store; Owner: postgres
--

ALTER TABLE ONLY book_store.user_contact
    ADD CONSTRAINT user_contact_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: book_store; Owner: postgres
--

ALTER TABLE ONLY book_store.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

