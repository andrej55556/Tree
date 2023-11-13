--
-- PostgreSQL database cluster dump
--

-- Started on 2023-11-12 19:31:47

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS;

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0
-- Dumped by pg_dump version 16.0

-- Started on 2023-11-12 19:31:47

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

-- Completed on 2023-11-12 19:31:47

--
-- PostgreSQL database dump complete
--

--
-- Database "2" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0
-- Dumped by pg_dump version 16.0

-- Started on 2023-11-12 19:31:47

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
-- TOC entry 4858 (class 1262 OID 24678)
-- Name: 2; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "2" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';


ALTER DATABASE "2" OWNER TO postgres;

\connect "2"

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 24679)
-- Name: course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course (
    course_id integer NOT NULL,
    course_name character varying NOT NULL,
    faculty_id integer NOT NULL
);


ALTER TABLE public.course OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 24748)
-- Name: course_course_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.course ALTER COLUMN course_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.course_course_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 216 (class 1259 OID 24684)
-- Name: faculty; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.faculty (
    faculty_name character varying NOT NULL,
    faculty_id integer NOT NULL
);


ALTER TABLE public.faculty OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 24749)
-- Name: faculty_faculty_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.faculty ALTER COLUMN faculty_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.faculty_faculty_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 217 (class 1259 OID 24689)
-- Name: university_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.university_group (
    group_id integer NOT NULL,
    group_name character varying NOT NULL,
    course_id integer NOT NULL
);


ALTER TABLE public.university_group OWNER TO postgres;

--
-- TOC entry 4848 (class 0 OID 24679)
-- Dependencies: 215
-- Data for Name: course; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course (course_id, course_name, faculty_id) FROM stdin;
3	Третий	1
2	Второй	1
4	Четвёртый	1
1	Первый	1
5	Первый	2
6	Второй	2
\.


--
-- TOC entry 4849 (class 0 OID 24684)
-- Dependencies: 216
-- Data for Name: faculty; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.faculty (faculty_name, faculty_id) FROM stdin;
Мехмат	1
Физфак	2
\.


--
-- TOC entry 4850 (class 0 OID 24689)
-- Dependencies: 217
-- Data for Name: university_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.university_group (group_id, group_name, course_id) FROM stdin;
9	ПМИ56	1
2	ПМИ34	1
1	ПМИ12	1
3	ПМИ12	2
4	ПМИ34	2
5	РФЗ12	5
6	РФЗ34	5
7	РФЗ12	6
8	ПМИ13	3
10	ПМИ1	4
\.


--
-- TOC entry 4859 (class 0 OID 0)
-- Dependencies: 218
-- Name: course_course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.course_course_id_seq', 1, false);


--
-- TOC entry 4860 (class 0 OID 0)
-- Dependencies: 219
-- Name: faculty_faculty_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.faculty_faculty_id_seq', 1, false);


--
-- TOC entry 4698 (class 2606 OID 24695)
-- Name: course course_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_pk PRIMARY KEY (course_id);


--
-- TOC entry 4700 (class 2606 OID 24697)
-- Name: faculty faculty_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty
    ADD CONSTRAINT faculty_pk PRIMARY KEY (faculty_id);


--
-- TOC entry 4702 (class 2606 OID 24699)
-- Name: university_group group_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.university_group
    ADD CONSTRAINT group_pk PRIMARY KEY (group_id);


--
-- TOC entry 4703 (class 2606 OID 24700)
-- Name: course course_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_fk FOREIGN KEY (faculty_id) REFERENCES public.faculty(faculty_id);


--
-- TOC entry 4704 (class 2606 OID 24705)
-- Name: university_group group_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.university_group
    ADD CONSTRAINT group_fk FOREIGN KEY (course_id) REFERENCES public.course(course_id);


-- Completed on 2023-11-12 19:31:47

--
-- PostgreSQL database dump complete
--

--
-- Database "HP" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0
-- Dumped by pg_dump version 16.0

-- Started on 2023-11-12 19:31:47

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
-- TOC entry 4854 (class 1262 OID 24710)
-- Name: HP; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "HP" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';


ALTER DATABASE "HP" OWNER TO postgres;

\connect "HP"

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
-- TOC entry 230 (class 1255 OID 24737)
-- Name: get_next_id(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_next_id(table_name character varying, column_name character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
max_id INTEGER;
next_id INTEGER;
BEGIN
-- Проверка наличия записи в специальной таблице
SELECT current_max_value
INTO max_id
FROM special_table
WHERE table_name = get_next_id.table_name AND column_name = get_next_id.column_name;

IF max_id IS NULL THEN
-- Получение максимального значения из запрашиваемой таблицы
EXECUTE FORMAT('SELECT MAX(%I) FROM %I', get_next_id.column_name, get_next_id.table_name)
INTO max_id;

-- Если нет значений, установка следующего идентификатора в 1
IF max_id IS NULL THEN
next_id := 1;
ELSE
next_id := max_id + 1;
END IF;

-- Запись новой строки в специальную таблицу
INSERT INTO special_table (table_name, column_name, current_max_value)
VALUES (get_next_id.table_name, get_next_id.column_name, next_id);
ELSE
-- Инкрементирование текущего максимального значения
UPDATE special_table
SET current_max_value = current_max_value + 1
WHERE table_name = get_next_id.table_name AND column_name = get_next_id.column_name;

-- Получение следующего значения
SELECT current_max_value
INTO next_id
FROM special_table
WHERE table_name = get_next_id.table_name AND column_name = get_next_id.column_name;
END IF;

-- Возвращение значения пользователю
RETURN next_id;
END;
$$;


ALTER FUNCTION public.get_next_id(table_name character varying, column_name character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 24720)
-- Name: Special; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Special" (
    id integer NOT NULL,
    table_name character varying NOT NULL,
    column_name character varying NOT NULL,
    max_value integer NOT NULL
);


ALTER TABLE public."Special" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 24729)
-- Name: special_table; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.special_table (
    id integer NOT NULL,
    table_name character varying(255),
    column_name character varying(255),
    current_max_value integer
);


ALTER TABLE public.special_table OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 24728)
-- Name: special_table_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.special_table_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.special_table_id_seq OWNER TO postgres;

--
-- TOC entry 4855 (class 0 OID 0)
-- Dependencies: 216
-- Name: special_table_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.special_table_id_seq OWNED BY public.special_table.id;


--
-- TOC entry 218 (class 1259 OID 24738)
-- Name: test; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test (
    id integer
);


ALTER TABLE public.test OWNER TO postgres;

--
-- TOC entry 4697 (class 2604 OID 24732)
-- Name: special_table id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.special_table ALTER COLUMN id SET DEFAULT nextval('public.special_table_id_seq'::regclass);


--
-- TOC entry 4845 (class 0 OID 24720)
-- Dependencies: 215
-- Data for Name: Special; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Special" (id, table_name, column_name, max_value) FROM stdin;
1	spec	id	1
\.


--
-- TOC entry 4847 (class 0 OID 24729)
-- Dependencies: 217
-- Data for Name: special_table; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.special_table (id, table_name, column_name, current_max_value) FROM stdin;
1	spec	id	1
\.


--
-- TOC entry 4848 (class 0 OID 24738)
-- Dependencies: 218
-- Data for Name: test; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test (id) FROM stdin;
10
\.


--
-- TOC entry 4856 (class 0 OID 0)
-- Dependencies: 216
-- Name: special_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.special_table_id_seq', 1, true);


--
-- TOC entry 4699 (class 2606 OID 24726)
-- Name: Special special_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Special"
    ADD CONSTRAINT special_pk PRIMARY KEY (id);


--
-- TOC entry 4701 (class 2606 OID 24736)
-- Name: special_table special_table_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.special_table
    ADD CONSTRAINT special_table_pkey PRIMARY KEY (id);


-- Completed on 2023-11-12 19:31:47

--
-- PostgreSQL database dump complete
--

-- Completed on 2023-11-12 19:31:47

--
-- PostgreSQL database cluster dump complete
--

