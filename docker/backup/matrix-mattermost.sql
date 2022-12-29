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
$gnR3q3jOOEFI04MZ00yFbtQ5ZNs9EfZENfrrOEEj46s	nzetx1536bbpmf54xm9ke14ubh	nzetx1536bbpmf54xm9ke14ubh
$ZI6mQ9fcQaRUQRDK0WWxDErZcQGD7ahzFrk1b9nCFRE	ia67b3pmgjf35m3drgzwta85re	ia67b3pmgjf35m3drgzwta85re
$raYGvFCt-q8kxStPhO_tzxQ3pOmVeo5gn8lTV6sHBvs	4fwy1489yfyejysftpewhmpq1o	4fwy1489yfyejysftpewhmpq1o
$mfDu-vDNMkOg-psLHXlWcSXOnVkeuUPJfdm2cZ-3P-k	f9t8uuz1ypnom8e3u3xxeki79r	f9t8uuz1ypnom8e3u3xxeki79r
$iDgp052fBKJYL2KTsRdizUAlriA5itky5-e20aiZwHI	m8ckwwgc6iy7jmzntzauakjhor	m8ckwwgc6iy7jmzntzauakjhor
$uwN8jjs4qWXT6fsX4o-36T96CWj17IDa_TJ3mF5Hd7M	4uzkuqno4tr7jemb4mpejdb5ha	4uzkuqno4tr7jemb4mpejdb5ha
$mXxM94SwVR0FuKbH_riuFTeW0zH7Om62-HEudW_5y80	4uzkuqno4tr7jemb4mpejdb5ha	4uzkuqno4tr7jemb4mpejdb5ha
$OVhb59gyrKY7dsgLlfdIwe1H4O5zslN774jooAK4vec	z6myk7pcwinpi8ea4u6m645igr	z6myk7pcwinpi8ea4u6m645igr
$AxFCh7nvzu51kpXaQqyK3CKEqdyGhhJ0zhqT-c9LGPk	et588ot9k7dnzd15rfcc68h55r	et588ot9k7dnzd15rfcc68h55r
$QjDo1bVrVGh33tmezjIVWxT6VXLutgIWlP9outS8Gcg	93gwkdk7rfrsfnp7ct41rit4cr	93gwkdk7rfrsfnp7ct41rit4cr
$j4OmrTBgGXlAg2ui751-jxTS4uMSPCzpj81xWRfOWiA	nz386cxdqibfjggps36ec3cwta	nz386cxdqibfjggps36ec3cwta
$lQM-XkcgjA40yc1T7BNzbZ8V8yxcnsj23SxrixdEev8	g4raeez3jj8r7p1occaymuxuwh	nz386cxdqibfjggps36ec3cwta
$XikqApD6-vTeGUebJl-_Bc9ButeowpABz5W37dejAy0	po1pmyzanfyjjra7u7ty437mhr	nz386cxdqibfjggps36ec3cwta
$A5qbTNFuQ1MZL2fuT4oUFzi1xCHHDk0NuQZstoz4u-U	aayo4sdzpjdhibh5c778zsox7w	aayo4sdzpjdhibh5c778zsox7w
$kMqJ62yuvBi4RWfOiLMiPcoSKbfcjZvTwwiuRRmfEKA	cycnpsyympgm7bpjop87kqfp7c	aayo4sdzpjdhibh5c778zsox7w
$2xt0-DVGoBAEL-GIwj9HZfHBCQu7_M-HzB2XaEfxjwM	7r946qpjx3yh5y3wdar1qjx1xa	aayo4sdzpjdhibh5c778zsox7w
$6CT_ZCazUgJysnWN-q2s4b5iR-x1EbXa932nBRpldW4	jxp6r9w5cinhxxgpq3ba3cbtre	jxp6r9w5cinhxxgpq3ba3cbtre
$UD0jEJtVKXhlCRf7VxHITWSUyhzaGkpH0VGbwilf2RE	m7o78bmd9trpjm3ix85er1n7br	jxp6r9w5cinhxxgpq3ba3cbtre
$BMnLymfijfp2V1tH1M6Nayfx-iF_rRw70COW60dCBG0	oox994g44tdqjc3jojh57sqspa	jxp6r9w5cinhxxgpq3ba3cbtre
$p2y4ivsQApKJEQKZQ-5KFk47veZlq7V00tHHrokVqK0	r1in1d4uwfrt3rd1zu3qgittba	r1in1d4uwfrt3rd1zu3qgittba
$VzxEyd-riDbZr-sdhUSEcA4h_6kWYfmSeoqEtaZHFFo	nz5jfpeocfd6xg9o44g7yhkidr	nz5jfpeocfd6xg9o44g7yhkidr
$m8QuIxNBjngQA1UhDPZlw6nIvodE764mdmYG9oCKf94	168ud38nq7yz8kqwy511b968ke	168ud38nq7yz8kqwy511b968ke
$mjUbm6eO9Jk-i6bqdyRHFZy9L-lH5TOO27GYMQ87nhs	apuxthakxbyxi8er94z6wutr7e	apuxthakxbyxi8er94z6wutr7e
$j_Vf4RSpugcR52JQthWyGuqRIEdGrETb4ZLvnGxwwg0	t446m1s1ztb1uqmwme5bph887h	t446m1s1ztb1uqmwme5bph887h
$kdWmWl1h_wHbp_4CZHM4AOF1I3SpjgbLYkYoFiWiazU	f6wijmoeujnebnynsgp7s14ukw	f6wijmoeujnebnynsgp7s14ukw
$RuT3uWLcY4y4GhqYFFNXur6XuNwXipRRmx5rJFfM9ms	cd54rifrrjdfmf8tfpmpo4jtce	cd54rifrrjdfmf8tfpmpo4jtce
$sD72WUGTkmqfbvA4mcCNx5IcT-WfbmjsGalYB6V6S-E	dfabwqtngiy63prwyhzguyt15e	dfabwqtngiy63prwyhzguyt15e
$iVV3o47Y40f29uNsCktD5R1VKbTF1y3nGq4KSKQ5YYo	8km7dejhpjrbdq199o5ns7mfhw	8km7dejhpjrbdq199o5ns7mfhw
$kkmwTP1mOPGymh7Q3_N1Y7ftC1xrv5qaHbV_zi99vD4	8km7dejhpjrbdq199o5ns7mfhw	8km7dejhpjrbdq199o5ns7mfhw
$99PDED6qRD6JvJgyuUpKL5SGciNeDx4Q8aNU8-knIfI	5rdyrzt9f38i9ni3sgdruxb94y	5rdyrzt9f38i9ni3sgdruxb94y
$53rDO0S-X2QNPUyUVrTGx092yf0EW0nvJXQNLgQ09kc	az9cwtqt7fdeby65ewt5byk8cw	az9cwtqt7fdeby65ewt5byk8cw
$OL5YFZuIzpeGWvQkJsWD5fA-_tqvM6MNM8aACLhDIKc	fecakni1tf8f5kkik3yzs86jjr	fecakni1tf8f5kkik3yzs86jjr
$WxOx5K9OBtSH4SKkxlQDUCVkiuA8mdui6eTN417KUig	yqk1q63fgj86pxgahge8nsozyy	fecakni1tf8f5kkik3yzs86jjr
$9eV_AyLXyN9dQJyo8nKzxH0MD2Pj26OD3m5hxM368ek	87t9bqhpajne8g118i65y9i8zo	fecakni1tf8f5kkik3yzs86jjr
$KAudDRl-ilYkXdKdFFwSH1rjB9FuDL3iaIcj9chsvuc	3oihhxyonpdjjng1anmuhp846a	3oihhxyonpdjjng1anmuhp846a
$NBW9KofbXfyJlflrssj5f0gU9-vix_ChkMTdCTutt6E	n3srszq9mpr1zp1g4wg9ywwkhy	3oihhxyonpdjjng1anmuhp846a
$G4jqJ_vLOuComzEY5LKlWgJmqk76rEv2BaFnoUc32C4	5psz9y37ip8ypymgq5o3ss9gfa	3oihhxyonpdjjng1anmuhp846a
$PmdsaAuptefoxepoi5dH3S5XZjMQnrw_IY8E3iiC0JI	9f1jhutcabfe5k8e6a4q7fi8me	9f1jhutcabfe5k8e6a4q7fi8me
$LLxGQgsj2x835E7aJtEtKuPEzf1fHJTT_1b0cxZaynk	w79opd1mojd35p9dusyxkmbqre	9f1jhutcabfe5k8e6a4q7fi8me
$xaKVxYK5Ka0brhbVcFdQdutgxYlZom-dUIRWmloBBms	wnuznbbi9jyefqtogn9rhtp6jw	9f1jhutcabfe5k8e6a4q7fi8me
$OIgyn6WfwavdRqCIV587JtVG-UzMqFnY1_VC_N2O6ok	u8jzfir1apfgzny77q3szgc1ny	u8jzfir1apfgzny77q3szgc1ny
$z-yABBMUu-RFJeiOLWwmWghP2O4vgO3Bts6c9FX-uG8	z4hb8n1gofd6dy4xc3kgsxn3yh	z4hb8n1gofd6dy4xc3kgsxn3yh
$P2eP-7teBmGXcBM7DqUedLeBNdY5eaTasFqCr7GXY74	9411xmani3bsjc7trmd1nmiowh	9411xmani3bsjc7trmd1nmiowh
$62DK_5Urc-R1gCm6T-D7rEFWp3Q47rECTaNApSOe0tg	9uzy5cfm8ffbmqjrgheegu59go	9411xmani3bsjc7trmd1nmiowh
$reo6-sRCAReTplLLrWZiUXEMMfaufd1o-PclhKbhxXw	aegkz85sgbgzik1ok6o5irxm9a	9411xmani3bsjc7trmd1nmiowh
$LiUaGyMC-ZVhJFLD9EeZsUNlhdIzJ2J41q-tpdMYQ-g	9ihkg14b838ud8d8megmug1hgc	9ihkg14b838ud8d8megmug1hgc
$kGXjbDILpzPlAVquVm-0ro1Y2cAjvBSU3chLQmB-ZgI	q8m1bndz778kpcphtz5nijqccw	9ihkg14b838ud8d8megmug1hgc
$iR6CRvH8xG5VgeMQIZFMBeaVeTjxgDtnqT7tv-PoCf8	1iui7u3bg3ytxn7fjxo7gk5n1c	9ihkg14b838ud8d8megmug1hgc
$47BkoMnB5FT3PSdXLEy0rb4ZdbS1q9w82a669O4lBXg	pk919jf3abdoifaw9sz7tygony	pk919jf3abdoifaw9sz7tygony
$zI1CZE-pX4aF7RBiJiZqzqFZlxIfJRBpmSuBjEzHTCQ	cj6t7j8x8ffx9bi4bysaeswwqa	pk919jf3abdoifaw9sz7tygony
$y7fmz8cz_zrBS0ZmRnthufiCH3PFkuCVz8YKzQaf81g	wafanm1gsfrnicfs7bezo7b8je	pk919jf3abdoifaw9sz7tygony
$5Iq2ZU88BXgNKKqMGOu71dH7vsyaxwI-Fxg8ocEMI2E	uamtbjhemjf4imhp4oee7g5bry	uamtbjhemjf4imhp4oee7g5bry
$LHW3l0dgme8yNUY6xjIvP_Osal1_vZAuIfg7vCLzGKI	7yndc37wptf3tbrqmwxjcyco5a	7yndc37wptf3tbrqmwxjcyco5a
$_XRh5iYtBtMSC8b9sq-Zq1kS1LqI6azDTXLEGQTiQSs	toashiar8pbqzkhtyspmjy5ouc	toashiar8pbqzkhtyspmjy5ouc
$jgIb5yphKm1y65Shpo1bZF38fQ0ZqUjOopYEMjB2JS0	runzcax383f9pyx4dgw9xe688o	toashiar8pbqzkhtyspmjy5ouc
$j96SJY0VtGl6Q_Fnj_jg3BifdW7s0-Vd8t57DrAeAX8	ztc1jtdakt8riqxuqodbsmybka	toashiar8pbqzkhtyspmjy5ouc
$5-UBR4vNvgnHcUIuQA0gIHJmn4pOL-BNEZ33B-2Dmes	jffnxp8epbgrzytgne139idh3e	jffnxp8epbgrzytgne139idh3e
$8f7euYUQUOKVs1LECS5C0ny-iJc0LrEhKy5AjaE9VwM	9x5p3qjbkpnadqm7uuky8ukz6c	jffnxp8epbgrzytgne139idh3e
$n7rEuNOUTfPAb-nKtA8sQLtp0FZoDqOfMyqN9eKVULc	bgmoha6rxtgajfttfe4xprtnih	jffnxp8epbgrzytgne139idh3e
$KdF0e2L1V2qamNtPDDdbE1nZ8xvaqEBCeH0VcCCosQ8	ps86c8bpzty888yx1godnrr6tw	ps86c8bpzty888yx1godnrr6tw
$VGPWrlgPM0aSEOjGq1_ygJ2gwcjdfMl06P2yF-1EjMw	buszbabdtfn1dndtww437b6j5h	ps86c8bpzty888yx1godnrr6tw
$T-S0-0A2-tysbZGnQHyOgfmxVouK-Ise06pRgQbLLcg	6ghcxjotxpgczbf4q5d5r6ss7y	ps86c8bpzty888yx1godnrr6tw
$5G3tHkgsc39AkOi94e7gxCeKaPhkmyOOAZlGWI8YaCQ	7ozy6u9j63b1pxuoom3ie43f4a	7ozy6u9j63b1pxuoom3ie43f4a
$c-G9o6jTgFkz_rB_zESYfRkHoFMmTM5uCDXF1JAermc	bqktopp983nabk1k7gbzpr8f9h	bqktopp983nabk1k7gbzpr8f9h
$eY9D8MVKC5bDdinpPVI9ooLWvoYHx0tLFn-vRWkp9nk	x4uh8rzrbjruik5s4ubewxbp9h	x4uh8rzrbjruik5s4ubewxbp9h
$AAj21zp54kdoP3h1Zql3vB7JlPNE4Y9HrXrzBQPQrTA	kti3cqy11bgztfkwtqxgqpqg1a	x4uh8rzrbjruik5s4ubewxbp9h
$VZnQHRUET5azOmfmvUZMF1_eEKzi1_WkVHB0pxMELxo	hzh47y16zjb33p1qr8sjzqwewe	x4uh8rzrbjruik5s4ubewxbp9h
$7q-JkspgsFYptPnMJ25LHdffz-rXLRDHzidSYCV3Kc8	fq8tzzaa738adpm6eypjtijhuw	fq8tzzaa738adpm6eypjtijhuw
$dtGyXiOFORXfCA1yAgiPJbV5UKJjEo-zfetInljHoV0	a91ozxwa9jdkpriaf4chqx7azh	fq8tzzaa738adpm6eypjtijhuw
$dxD8VRi5x30Gu7BMEOui-JOrXZEL9meU6Q8aZra1b6U	3o9eworfrbrydpi9snqrrkts9r	fq8tzzaa738adpm6eypjtijhuw
$bXKGeqgVWpdObwAv0HPtsV7_MNqo8HhD_whsZ1gxx54	rcq9j7feiirsd8nd85djs6opdw	rcq9j7feiirsd8nd85djs6opdw
$LOcz4Bm15D4BsyuDXygSGL-0AvIjwSLYy4cezgebQK8	5didoed3ifr38k31nced1xiaae	rcq9j7feiirsd8nd85djs6opdw
$RJSqE0ZymidM-ZtkpYLdrShv6_yNohaw5QtWzVooGsk	gpz3eibemfn6dfz8yjdb35ocbc	rcq9j7feiirsd8nd85djs6opdw
$gLYRtP_fFTIbdUQ6jtldLcUG60gMNlghw7x9t2_PurE	4h5z69rjgjdsupbna7i6wuxjnr	4h5z69rjgjdsupbna7i6wuxjnr
$AbcQJxS0qvSibn6R_hm5OSrLKkHjrpsW8oo97om40r8	u9e9h9r56jg8xcs4upheid3tpa	u9e9h9r56jg8xcs4upheid3tpa
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
@matrix_b:localhost	7buk99iowt8mipptoftdgimmhy	75uajq6ya7dp8edqxjqw4x59xa	t	matrix_matrix_b	matrix_b
@mm_mattermost_a:localhost	5bw66y36bff3umq1q57mfy4y5c		f	mattermost_a	MattermostUser A [mm]
@mm_mattermost_b:localhost	3zats68fztgu9mgu944a4t35so		f	mattermost_b	mattermost_b [mm]
@matrix_a:localhost	7m6hc4oompb7mexf9muuppdd6r	6hpjktpccpnqug3bsaa649jo8r	t	matrix_matrix_a	Matrix UserA
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

