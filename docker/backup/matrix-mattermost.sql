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
$FVhXs60ZUT4hfp8SPDQiJ9sUL5CV4MjGIsUfequDwEE	8f8ofanfi7bg584dyf7xcy6k3a	8f8ofanfi7bg584dyf7xcy6k3a
$NDRnMTvwTgCFfTb_vFmNwNe1o4a-UnPMEHKYvBFg1Ms	ogewadu5sib35em7nk3fhg3txr	ogewadu5sib35em7nk3fhg3txr
$jsgSLDcqxEQROuyA6P2myIoJf5N1kGLS_n8iWXwE-nU	zftzdzdijbnexnh8e9ujm8ioor	zftzdzdijbnexnh8e9ujm8ioor
$vg3binnx1kEog3C9nqvwJ7qPu28sTqYrZDssk0vab-Q	xkpspndmxjddukhczankqoakow	xkpspndmxjddukhczankqoakow
$d8OJKkkhp47jknk_LHO0c3d0-CSNWMzpJBRw6bOrQ4M	o9qmfjf34tnyxdji3o81gzptjw	o9qmfjf34tnyxdji3o81gzptjw
$LkEO2DXJWjTGSlo7iokDO6KvigtD7BtSYgzN1bHF2q0	joxxq4ps3jdh7kzj4p97ztqauo	joxxq4ps3jdh7kzj4p97ztqauo
$RBYjw0bWPMbVEg8csvMs4tPORoqreh7W0cTgJTDKhxQ	gsq775ai8t8k9cozpj1i7hpdgw	gsq775ai8t8k9cozpj1i7hpdgw
$3J0wiu01NbTrOfOGZgRjSdNtX0P7ZN-PQp8qKcLDlmY	pkpomsmeejghxm4zai4hfymw8o	pkpomsmeejghxm4zai4hfymw8o
$qpoohVqO3c0vYCNBJuvRZHkBBNPQSrgwVwzIcbCfJJk	cw3shuzizpbrfpei9twkimpr9h	cw3shuzizpbrfpei9twkimpr9h
$uVCWC5TSVmmOhtnjhBprXQIqqNMmjlwAjnAbCFWCmSM	141cf3e9cp8mzp1gcojoiq83do	141cf3e9cp8mzp1gcojoiq83do
$ze3rHWp4q76u5HD9VeEM4tmvDPVyEGXfJ16m3GKAPBA	o9ftokai47yuxydmq8ockozxsc	o9ftokai47yuxydmq8ockozxsc
$wQdEIjcFyopFZpNGXmYD7mGBK2vx6nRTZFbp0tUAS5s	o9ftokai47yuxydmq8ockozxsc	o9ftokai47yuxydmq8ockozxsc
$7tsqPssEA6U65Qrd44F9FbFLND-JhznQ_c-4bXrIlRE	w4ai4uu693b5jxhfb8at5nu9ry	w4ai4uu693b5jxhfb8at5nu9ry
$D4biAJRc__54ONgjSEAYBzE8_j1ePGCqni93Os3tKhM	w4ai4uu693b5jxhfb8at5nu9ry	w4ai4uu693b5jxhfb8at5nu9ry
$GPeeyjoIFFM1Mp_pvKB55ZyVVmuSxQ3czNsjj5VxcZs	5um9oboqufnpx88699x1gf99cc	5um9oboqufnpx88699x1gf99cc
$qIPcuD0d9eSflKKATXSbTJjoKFIBzNFk28nuN3007zo	5um9oboqufnpx88699x1gf99cc	5um9oboqufnpx88699x1gf99cc
$-F2yj6IuC13Z2Eri3_-fsH3NLCQXQ1igRElx9-Op2x4	kx3b3cihziyt9xyb1nwea1msoa	kx3b3cihziyt9xyb1nwea1msoa
$iKj1OUBZW17_u23PJes2dsEtLEQhEZBWblS4q6rzsjU	kx3b3cihziyt9xyb1nwea1msoa	kx3b3cihziyt9xyb1nwea1msoa
$AUKXpVUFnYNqEkGgCvdFpbjbYc6RVwJa6Lu4v1LGoBs	7c9xhxioi3yppjogicsuaf6icy	7c9xhxioi3yppjogicsuaf6icy
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
@matrix_b:localhost	6afiyfegctd1zxwen4aq4ywpyr	f8ffk5uwobdpfmqjtk1gkr598a	t	matrix_matrix_b	matrix_b
@mm_mattermost_b:localhost	3zats68fztgu9mgu944a4t35so		f	mattermost_b	mattermost_b [mm]
@mm_mattermost_a:localhost	5bw66y36bff3umq1q57mfy4y5c		f	mattermost_a	MattermostUser A [mm]
@mm_bridgeuser1:localhost	ujmedpkiu3rcxyaojr1k1qem4h		f	bridgeuser1	bridgeuser1 [mm]
@mm_bridgeuser2:localhost	esahgx8oc7y3pbm4f95doipzny		f	bridgeuser2	bridgeuser2 [mm]
@matrix_a:localhost	p584bbmabpghxqz4qdwj8pdhpr	zkedx4zsd7yqt84nh4h68mgxfr	t	matrix_matrix_a	matrix_a
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

