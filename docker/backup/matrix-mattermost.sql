\c matrix-mattermost
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
$DTQEMlxc_4_CqP-rYQ46vmCpJtEKlxw_Ugma4cnNO6w	kiogcheho3dnfxquy57cobdjfr	kiogcheho3dnfxquy57cobdjfr
$cIkI-00MET-_PQ4VaVFuuZsJ2WEz_UMnlXun9Itkqt8	wk465zuxh78qxdzxfbg6y4bgaa	wk465zuxh78qxdzxfbg6y4bgaa
$CsT9BKDbT6nCfiXJCOAHV90fgB6fYV4boIF3v6eEls4	uya3x4wijjnu3n7em4wgnszs8a	uya3x4wijjnu3n7em4wgnszs8a
$3Q6XqtJGvGa1jhhtRN9kQqoLIWqjikrH3x7yltwaZ6w	wzff6e1kxfyzjm3e8kdogaekah	wzff6e1kxfyzjm3e8kdogaekah
$pulJgsd1znNtSba8MCpZoXTCHhxSC0OkMutE8dDzlO0	hfrgor18sjyqicnjri48h8ycie	hfrgor18sjyqicnjri48h8ycie
$JghGsUh3v1rikXL8gETZ_UJKjZC_6NY_WEgHUWlDGUM	33bfc8ghopbfddu6ztg1z98a6r	33bfc8ghopbfddu6ztg1z98a6r
$COcCgODcXP3YBig5Vk-_QDtWh0rzx9K1yVAasfvXRVk	jw96kwqc4i8rdpwd8btfs7ffey	jw96kwqc4i8rdpwd8btfs7ffey
$lGC_2RlgCMjLDCMd4bkjzCmXnXFQHNvnd9eFy28BE8E	9exfeugugpfkbmjqt8ksxr7jre	9exfeugugpfkbmjqt8ksxr7jre
$iPEm9yDTEtMvd-r8SFs0eTz8dpjdWAFHcpWpOTKCqkk	hfear7hhz7dq8cdesdphtnadma	hfear7hhz7dq8cdesdphtnadma
$Ay9Au4hI33NjvpwrmfU6OSnS-_gSjFb5bRzB6756wKo	gozfd9nr6jfyxrnnfabewjgyqa	gozfd9nr6jfyxrnnfabewjgyqa
$szFQBuhhfXcOIlgReai0669p3ycU-w57s91VHUKWXFA	g9nfhps1e3yopqaxrp3mmczwyw	g9nfhps1e3yopqaxrp3mmczwyw
$pec3QOL9YU-4d4ww5taJYfFCSKUcMIUYBRSHQoML6Vw	e1f3s8mq6t843n1rryqfukfu4r	e1f3s8mq6t843n1rryqfukfu4r
$ckvkcjvKmxJljo0NX3W1BFf-JQMuUnFbh-r9CNPtmR4	7in3d1wdt3rapdifkuye1ygfue	7in3d1wdt3rapdifkuye1ygfue
$Ss566NPFclWN6Mx7hHv8fd_JaawsG1AuM6gnlM7fA-k	p3xpqtx1k3gb8r1bcew3aj4aeo	p3xpqtx1k3gb8r1bcew3aj4aeo
$focovH6Yc-m2CXhjrx4lhMQHQhQODpLp4g1sKHOxfaU	bbna6kw78pba8kedke1d5zd1zr	bbna6kw78pba8kedke1d5zd1zr
$Y8T81hxoxP5Ta-IxCarhZjMk4fWMtcg9FlgmTG9VgiE	mzsrzeef8iy9ubn3jycoa1dmya	mzsrzeef8iy9ubn3jycoa1dmya
$RVi3Hrw_NGpZOOlLIRSt-m_lPWPYt0K7JLecNmlU1Sw	61p3qt6uipd1jm3qu9bftbyrpc	61p3qt6uipd1jm3qu9bftbyrpc
$8_ljUg0y31H3DwB8UeZyPs3Vlh_4zdSmAkWCsBDCc98	969xtnz1nifd3mkd4mr9rd5xra	969xtnz1nifd3mkd4mr9rd5xra
$UlpkVhx0UMdfV3JIISqctfZ_aMoIkpmIqcfxcCxxRL8	14k56sm19pgspjyiw3eeguqa7o	14k56sm19pgspjyiw3eeguqa7o
$_B6Ln541gYqlnaEaxAcSwy46yBXDxkldNhRG8HdrPBs	14k56sm19pgspjyiw3eeguqa7o	14k56sm19pgspjyiw3eeguqa7o
$grj8CepyvbRzzkLI4auscQ640Z-NssUGE9TSsXkp690	9arqkaza4irbixj5xqekrxeaqr	9arqkaza4irbixj5xqekrxeaqr
$oakhKpEqFw5Icor6iY_TRMQljV-HWQ3lueP0Vlm9hIY	f5stqsigmpg33mbjf8sfimsrra	f5stqsigmpg33mbjf8sfimsrra
$PfXwdx6I54mC3f0Zd8nOukV5nTCxL7uRQKGn3Bxg17Y	iy5cuxty378h3qaydjwyxmdm1o	iy5cuxty378h3qaydjwyxmdm1o
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
@matrix_b:localhost	bqyuo5n95igtiqj15enjran1br	oo9xnia8opr9xrf5gzyw6wchhe	t	matrix_matrix_b	matrix_b
@matrix_a:localhost	qio139w9xbyc9pknsx1wo388xc	zfmxqhxpapbmifxwgdhk7agq8r	t	matrix_matrix_a	Matrix UserA
@mm_mattermost_a:localhost	5bw66y36bff3umq1q57mfy4y5c		f	mattermost_a	MattermostUser A [mm]
@mm_mattermost_b:localhost	3zats68fztgu9mgu944a4t35so		f	mattermost_b	mattermost_b [mm]
@user1.matrix:localhost	hfby48bpd3r5je83kq15ocnyiy	hjqz5dcjrpd35enutykik45noc	t	matrix_user1.matrix	User 1 - Matrix
@mm_user1.mm:localhost	z3pbizcrujd8jfyqq3z3zj1i5c		f	user1.mm	user1.mm [mm]
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

