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
$cVpm7JtI2FA6jT91bWn5avhRlFg_CpMA5HRanoYhkJs	zaqw6nbri7b7uyahc8je5ms4jc	zaqw6nbri7b7uyahc8je5ms4jc
$jD0GZ5JDGHZiN5kp0llsZ-TSj7JcaRn8CDsEQiyeJ3w	7azm5pwxk3nbdx8ixpqir5draa	7azm5pwxk3nbdx8ixpqir5draa
$1-1XawRJVm29pQHrbkTGcQ-bYWMPoyyXEnV9D0NRRF8	pi3xicw5r78q9bnties3txu1th	pi3xicw5r78q9bnties3txu1th
$hr9BoL0M0CcPevs38ww5_bA24p8HFiP4e9dlGuPrGWs	cn1xnusgrtbo3btpidqpwmttca	cn1xnusgrtbo3btpidqpwmttca
$QM2BSnrrZmMuXPjs3AMnJ7zVsHHdXmGmCFPjoGqBlaQ	debuqhoasjgktrzxtdqppwku5o	debuqhoasjgktrzxtdqppwku5o
$_OchgUntbLcDcJV42YEeAhH2t22AW-wlAxjRPO0SYfU	1pe3kybx5tyo9jiq3bify8ptrh	1pe3kybx5tyo9jiq3bify8ptrh
$Z5cKxfveccJ3nnCMqKA-jwkRw9hbVrCMv6R68J8oPVg	7qj53zemsbnzdgad76g9ifw6hc	7qj53zemsbnzdgad76g9ifw6hc
$G1fvwCN2g1XjFzNmxLnkU_pe19oYNSqJMKqzj8kfXCk	7qj53zemsbnzdgad76g9ifw6hc	7qj53zemsbnzdgad76g9ifw6hc
$Jt6sBZkF1u2z9OovN4zzqiZfS0rQPS2vVpynSjt9ypI	op4mz46j4pywu8at8f9k5hk8wy	op4mz46j4pywu8at8f9k5hk8wy
$xRdCRWLb62a-YRgcfBkJSxc7lUVFkdZnQfSIvcKWw88	96xmitp7qjnu389ecctrja49kr	96xmitp7qjnu389ecctrja49kr
$5auMphtCZ9zvRqrhyXpY0s-cZZl2AbvkyGNRbm2h2zc	7op8pa1a43rbtmi5bscf41oefw	7op8pa1a43rbtmi5bscf41oefw
$j0CTOXXA4AtSOD0pk6kL2BNsa6j5w517GGfkTqmm9ZE	os6sm85ooiy68go7b4uqibhgdy	os6sm85ooiy68go7b4uqibhgdy
$TbIhAYsmySe2O7IaMBarYDokr6-UmyH4IYI3SpbhI-Q	grcxd88ak7rsxpia59fadzb7aa	grcxd88ak7rsxpia59fadzb7aa
$YBt0yFQdKC_886W6aXe4LIv5A5BcBP7pXYeF8XLKhH0	grcxd88ak7rsxpia59fadzb7aa	grcxd88ak7rsxpia59fadzb7aa
$-wkWlUVunP818RkFXsoACrEQ85-ybLTc-vWqiil50Vo	hp4449juf7d8xc591q3rnejfcc	hp4449juf7d8xc591q3rnejfcc
$uFBLsg4RZn3DtG5dqcZ8A11zEbkWHwPLjk_VQtaj0qM	i5k4s56rgbfstmn999rzy1i5kh	i5k4s56rgbfstmn999rzy1i5kh
$wFcIkswyANl3CQZdt_hX9g9e2TeFjIzp9bWhcEbBiCI	t71qaw1t4frwfxf1nhumzkguzh	t71qaw1t4frwfxf1nhumzkguzh
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
@matrix_b:localhost	kgr5hfwxy78k5n9gfkdhcscdoc	j6knf51k1jb63fe8moah7qbf6o	t	matrix_matrix_b	matrix_b
@matrix_a:localhost	1fgsimi9s3rmjxzxsaeqrr66ko	6nk5qzigrfg8py1bfjx49zkrgh	t	matrix_matrix_a	Matrix UserA
@mm_mattermost_b:localhost	3zats68fztgu9mgu944a4t35so		f	mattermost_b	mattermost_b [mm]
@mm_mattermost_a:localhost	5bw66y36bff3umq1q57mfy4y5c		f	mattermost_a	MattermostUser A [mm]
@user1:localhost	she685ewdtyq7m7jgmys7zoqmr	pgrgjax6rpggub1hxajrw5ne4h	t	matrix_user1	User 1
@mm_user1:localhost	98kwr77m4jgwmbdgygknaowcch		f	user1	user1 [mm]
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

