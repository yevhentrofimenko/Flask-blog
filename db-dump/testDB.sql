--
-- PostgreSQL database dump
--

-- Dumped from database version 10.1
-- Dumped by pg_dump version 10.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: testdb; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE testdb WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE testdb OWNER TO postgres;

\connect testdb

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: comments; Type: TABLE; Schema: public; Owner: testusr
--

CREATE TABLE comments (
    id integer NOT NULL,
    sender integer NOT NULL,
    post_id integer NOT NULL,
    content character varying NOT NULL
);


ALTER TABLE comments OWNER TO testusr;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: testusr
--

CREATE SEQUENCE comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE comments_id_seq OWNER TO testusr;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: testusr
--

ALTER SEQUENCE comments_id_seq OWNED BY comments.id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: testusr
--

CREATE TABLE posts (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    content character varying NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE posts OWNER TO testusr;

--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: testusr
--

CREATE SEQUENCE posts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE posts_id_seq OWNER TO testusr;

--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: testusr
--

ALTER SEQUENCE posts_id_seq OWNED BY posts.id;


--
-- Name: role; Type: TABLE; Schema: public; Owner: testusr
--

CREATE TABLE role (
    id integer NOT NULL,
    name character varying(80),
    description character varying(255)
);


ALTER TABLE role OWNER TO testusr;

--
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: testusr
--

CREATE SEQUENCE role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE role_id_seq OWNER TO testusr;

--
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: testusr
--

ALTER SEQUENCE role_id_seq OWNED BY role.id;


--
-- Name: roles_users; Type: TABLE; Schema: public; Owner: testusr
--

CREATE TABLE roles_users (
    user_id integer,
    role_id integer
);


ALTER TABLE roles_users OWNER TO testusr;

--
-- Name: user; Type: TABLE; Schema: public; Owner: testusr
--

CREATE TABLE "user" (
    id integer NOT NULL,
    email character varying(255),
    password character varying(255),
    name character varying(255),
    second_name character varying(255),
    active boolean,
    confirmed_at timestamp without time zone
);


ALTER TABLE "user" OWNER TO testusr;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: testusr
--

CREATE SEQUENCE user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_id_seq OWNER TO testusr;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: testusr
--

ALTER SEQUENCE user_id_seq OWNED BY "user".id;


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: testusr
--

ALTER TABLE ONLY comments ALTER COLUMN id SET DEFAULT nextval('comments_id_seq'::regclass);


--
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: testusr
--

ALTER TABLE ONLY posts ALTER COLUMN id SET DEFAULT nextval('posts_id_seq'::regclass);


--
-- Name: role id; Type: DEFAULT; Schema: public; Owner: testusr
--

ALTER TABLE ONLY role ALTER COLUMN id SET DEFAULT nextval('role_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: testusr
--

ALTER TABLE ONLY "user" ALTER COLUMN id SET DEFAULT nextval('user_id_seq'::regclass);


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: testusr
--

COPY comments (id, sender, post_id, content) FROM stdin;
1	2	1	COMMENT USER 2: Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
2	1	2	COMMENT USER 1: The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested.
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: testusr
--

COPY posts (id, title, content, user_id) FROM stdin;
1	POST FROM USER 1	It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)	1
2	POST FROM USER 2	There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised .	2
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: testusr
--

COPY role (id, name, description) FROM stdin;
\.


--
-- Data for Name: roles_users; Type: TABLE DATA; Schema: public; Owner: testusr
--

COPY roles_users (user_id, role_id) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: testusr
--

COPY "user" (id, email, password, name, second_name, active, confirmed_at) FROM stdin;
1	user1@gmail.com	password	user1_name	user1_last-name	t	\N
2	user2@gmail.com	password	user2_name	user2_last-name	t	\N
\.


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: testusr
--

SELECT pg_catalog.setval('comments_id_seq', 2, true);


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: testusr
--

SELECT pg_catalog.setval('posts_id_seq', 2, true);


--
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: testusr
--

SELECT pg_catalog.setval('role_id_seq', 1, false);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: testusr
--

SELECT pg_catalog.setval('user_id_seq', 2, true);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: testusr
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: testusr
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: role role_name_key; Type: CONSTRAINT; Schema: public; Owner: testusr
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_name_key UNIQUE (name);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: testusr
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: user user_email_key; Type: CONSTRAINT; Schema: public; Owner: testusr
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: testusr
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: comments comments_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: testusr
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_post_id_fkey FOREIGN KEY (post_id) REFERENCES posts(id);


--
-- Name: comments comments_sender_fkey; Type: FK CONSTRAINT; Schema: public; Owner: testusr
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_sender_fkey FOREIGN KEY (sender) REFERENCES "user"(id);


--
-- Name: posts posts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: testusr
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: roles_users roles_users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: testusr
--

ALTER TABLE ONLY roles_users
    ADD CONSTRAINT roles_users_role_id_fkey FOREIGN KEY (role_id) REFERENCES role(id);


--
-- Name: roles_users roles_users_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: testusr
--

ALTER TABLE ONLY roles_users
    ADD CONSTRAINT roles_users_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- PostgreSQL database dump complete
--

