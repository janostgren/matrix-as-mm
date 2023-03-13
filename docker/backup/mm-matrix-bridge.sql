\c  mm-matrix-bridge
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
-- Name: mapping; Type: TABLE; Schema: public; Owner: mm-matrix-bridge
--

CREATE TABLE public.mapping (
    mattermost_channel_id text NOT NULL,
    matrix_room_id text NOT NULL,
    is_private boolean DEFAULT true NOT NULL,
    is_direct boolean DEFAULT true NOT NULL
);


ALTER TABLE public.mapping OWNER TO "mm-matrix-bridge";

--
-- Name: posts; Type: TABLE; Schema: public; Owner: mm-matrix-bridge
--

CREATE TABLE public.posts (
    eventid text NOT NULL,
    postid character(26) NOT NULL,
    rootid character(26) NOT NULL
);


ALTER TABLE public.posts OWNER TO "mm-matrix-bridge";

--
-- Name: typeorm_metadata; Type: TABLE; Schema: public; Owner: mm-matrix-bridge
--

CREATE TABLE public.typeorm_metadata (
    type character varying NOT NULL,
    database character varying,
    schema character varying,
    "table" character varying,
    name character varying,
    value text
);


ALTER TABLE public.typeorm_metadata OWNER TO "mm-matrix-bridge";

--
-- Name: users; Type: TABLE; Schema: public; Owner: mm-matrix-bridge
--

CREATE TABLE public.users (
    matrix_userid text NOT NULL,
    mattermost_userid character(26) NOT NULL,
    access_token text NOT NULL,
    is_matrix_user boolean NOT NULL,
    mattermost_username text NOT NULL,
    matrix_displayname text NOT NULL
);


ALTER TABLE public.users OWNER TO "mm-matrix-bridge";

--
-- Data for Name: mapping; Type: TABLE DATA; Schema: public; Owner: mm-matrix-bridge
--

COPY public.mapping (mattermost_channel_id, matrix_room_id, is_private, is_direct) FROM stdin;
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: mm-matrix-bridge
--

COPY public.posts (eventid, postid, rootid) FROM stdin;
$ws9UuWLPn8VzHbofyg3g8AQK-aYsdD2iv6woyWt3sEw	qpybi5a1tff9u81mgtngeuhkro	qpybi5a1tff9u81mgtngeuhkro
$ls5AzJlLTu3Alykxvj5L99HqOQsi7cUGH7wVb-IqErQ	xcginserxtyab8q7dtajc43fwr	xcginserxtyab8q7dtajc43fwr
$nFwL1txBnk2dj72aBWqthTGHrC-kv7CYWMt3cwz8qgw	i3rgzbuhdpn73conyzd7zw6sbc	i3rgzbuhdpn73conyzd7zw6sbc
$hXzRSYfNTLUmjRz8EgsrekOmklfOoUQ9NKx0vS1AmTk	ma8t73u6cbnkdy4gsyue5rrd9h	ma8t73u6cbnkdy4gsyue5rrd9h
$ggCddRubeCPps5yMhlY-9Ib0RvBhwUJy716vZvf32Oo	jqbf9g91b3neteabf1378kf6ao	jqbf9g91b3neteabf1378kf6ao
$v3jGyApp70gdwh4Il9oB6nRxdyr-zF1Nt9w5VRI1Em4	man1grukefr4jmityxs3z4z8te	man1grukefr4jmityxs3z4z8te
$95vJ25qtpsri2l4-Ft6bN-NMw1uq9NjdTcLLt_v-cdE	hz71npt4spyr9gesejj34pynkc	hz71npt4spyr9gesejj34pynkc
$cy5KlfdXxrxwsh3JYgCvSt79RGqs9e0nqUdGznRRG7c	xaoe948b4idp3jutbshjkri7wo	xaoe948b4idp3jutbshjkri7wo
$0s6lqq-j-E9Nm_LFwUEpeeLWBeDQ75ZYmwrYMoexDwc	b3ep6go787gpufiweug9qmwoyr	b3ep6go787gpufiweug9qmwoyr
\.


--
-- Data for Name: typeorm_metadata; Type: TABLE DATA; Schema: public; Owner: mm-matrix-bridge
--

COPY public.typeorm_metadata (type, database, schema, "table", name, value) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: mm-matrix-bridge
--

COPY public.users (matrix_userid, mattermost_userid, access_token, is_matrix_user, mattermost_username, matrix_displayname) FROM stdin;
@user1.matrix:localhost	bgct5icpib883fx619bh3cfu6h	zbobs1dw5jgrtby9hkcz3dkpjy	t	matrix_user1.matrix	user1.matrix
@mm_user1.mm:localhost	ygmycw6rnff7igko8gwbqchujr	deges64nuprjdrke65zqfp7fkw	f	user1.mm	user1.mm [mm]
@user2.matrix:localhost	wq6i7sbf4tnqzbssbn7gy7cjcc	i8bz3eaobffm7rgwfrohhjobwa	t	matrix_user2.matrix	
@mm_user2.mm:localhost	e343y5ecu7dyujwqm7yfimh1je	s34w4m8qw7dybmn4qb8qfwyhfr	f	user2.mm	user2.mm [mm]
\.


--
-- Name: posts PK_4c80ebd45fc8d2779b82a183713; Type: CONSTRAINT; Schema: public; Owner: mm-matrix-bridge
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT "PK_4c80ebd45fc8d2779b82a183713" PRIMARY KEY (eventid);


--
-- Name: mapping PK_9b3d7f9178c4476a1f0da53195d; Type: CONSTRAINT; Schema: public; Owner: mm-matrix-bridge
--

ALTER TABLE ONLY public.mapping
    ADD CONSTRAINT "PK_9b3d7f9178c4476a1f0da53195d" PRIMARY KEY (mattermost_channel_id);


--
-- Name: users PK_a857f41bae47ffe29abb14bc31d; Type: CONSTRAINT; Schema: public; Owner: mm-matrix-bridge
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "PK_a857f41bae47ffe29abb14bc31d" PRIMARY KEY (matrix_userid);


--
-- Name: mapping UQ_0e4c898c29b678849086653e2cd; Type: CONSTRAINT; Schema: public; Owner: mm-matrix-bridge
--

ALTER TABLE ONLY public.mapping
    ADD CONSTRAINT "UQ_0e4c898c29b678849086653e2cd" UNIQUE (matrix_room_id);


--
-- PostgreSQL database dump complete
--

