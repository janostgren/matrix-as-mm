--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1
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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: posts; Type: TABLE; Schema: public; Owner: matrix-mattermost
--

CREATE TABLE public.posts (
    eventid text NOT NULL,
    postid character(26) NOT NULL,
    rootid character(26) NOT NULL
);


ALTER TABLE public.posts OWNER TO "matrix-mattermost";

--
-- Name: typeorm_metadata; Type: TABLE; Schema: public; Owner: matrix-mattermost
--

CREATE TABLE public.typeorm_metadata (
    type character varying NOT NULL,
    database character varying,
    schema character varying,
    "table" character varying,
    name character varying,
    value text
);


ALTER TABLE public.typeorm_metadata OWNER TO "matrix-mattermost";

--
-- Name: users; Type: TABLE; Schema: public; Owner: matrix-mattermost
--

CREATE TABLE public.users (
    matrix_userid text NOT NULL,
    mattermost_userid character(26) NOT NULL,
    access_token text NOT NULL,
    is_matrix_user boolean NOT NULL,
    mattermost_username text NOT NULL,
    matrix_displayname text NOT NULL
);


ALTER TABLE public.users OWNER TO "matrix-mattermost";

--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: matrix-mattermost
--

COPY public.posts (eventid, postid, rootid) FROM stdin;
\.


--
-- Data for Name: typeorm_metadata; Type: TABLE DATA; Schema: public; Owner: matrix-mattermost
--

COPY public.typeorm_metadata (type, database, schema, "table", name, value) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: matrix-mattermost
--

COPY public.users (matrix_userid, mattermost_userid, access_token, is_matrix_user, mattermost_username, matrix_displayname) FROM stdin;
@matrix_b:localhost	3ujgtjorx7gtxxfowjujph9npo	xtqo1n11s7njzqawwu1nqn4mec	t	matrix_matrix_b	matrix_b
@matrix_a:localhost	atexouz5nfbujxpoofxop8trnh	66ua3uxxcjy3jy64ajk5rkaeto	t	matrix_matrix_a	Matrix UserA
@mm_mattermost_b:localhost	3zats68fztgu9mgu944a4t35so		f	mattermost_b	mattermost_b [mm]
@mm_mattermost_a:localhost	5bw66y36bff3umq1q57mfy4y5c		f	mattermost_a	MattermostUser A [mm]
\.


--
-- Name: posts PK_4c80ebd45fc8d2779b82a183713; Type: CONSTRAINT; Schema: public; Owner: matrix-mattermost
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT "PK_4c80ebd45fc8d2779b82a183713" PRIMARY KEY (eventid);


--
-- Name: users PK_a857f41bae47ffe29abb14bc31d; Type: CONSTRAINT; Schema: public; Owner: matrix-mattermost
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "PK_a857f41bae47ffe29abb14bc31d" PRIMARY KEY (matrix_userid);


--
-- PostgreSQL database dump complete
--

