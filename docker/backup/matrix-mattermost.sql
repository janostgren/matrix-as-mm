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
$zsvkWRGeOerm3Q5DPlTgr7kA7cM2-F0gXr40MUzknyc	nmfqhk8y4jyr3mzc4848kkqw1r	nmfqhk8y4jyr3mzc4848kkqw1r
$r3Ho1IsdJmJB13pD9yX-Jkg_a5s28kBCqoNZ5EPWwqM	rtgu9jmdat8jxnectdr11mdfdw	rtgu9jmdat8jxnectdr11mdfdw
$fQ28BQv7GUBcg_Ok7MCh8uTcQLoT2Tkr2BegUMhst1M	ihebuw631frnmymqjho3fiwaic	ihebuw631frnmymqjho3fiwaic
$Yb59onmhkHIpIJ_VnrP0V02pkFQEF1GwuJqZCNRTQeQ	gj11m8ynbjdm3nq79jpquwdkkw	gj11m8ynbjdm3nq79jpquwdkkw
$IaI_j1zJZ04lmJmCzJfvnr48U2umqKYG1xogY-r9UNY	yiq5oe9n7frt9kyrwk8e1ppzta	yiq5oe9n7frt9kyrwk8e1ppzta
$kQPpv66TuseXeTXJr41QlqLnJBWNpBA_zgzIaJMjpLc	5drb7dqfeibbpgsmd3k7rowyda	5drb7dqfeibbpgsmd3k7rowyda
$BG2gCT3tXMWdl5AO704CVjroaQJysHmLZMRN-QrTH8w	zzzt8oj5y7bk8jbzd5yew4jn7r	zzzt8oj5y7bk8jbzd5yew4jn7r
$AXNJvl1CFFkmeDr63y2IykCN_G-lJiDa4JHsOjaUj4Y	k95x4qn8otfdjfxs77k69fttuw	k95x4qn8otfdjfxs77k69fttuw
$35mlnbt-wcKTRY9cY7oyxyQbIoQPDLdRLHQQPGPVJzo	tdu14gjjjpbgi8fyd7xswarqbe	tdu14gjjjpbgi8fyd7xswarqbe
$9hK3JsOVrMiv0wKjw57rMkc6mne_XmZ0CRTz65g97ek	krq3g4teztng5jwku14k8sf3gc	krq3g4teztng5jwku14k8sf3gc
$Y_FmFbCe62ffJ-UyN7IA1IbcRgUsELxe9lGLmGbDg9o	93gwmmkcyj8idggcy9se8azh1r	93gwmmkcyj8idggcy9se8azh1r
$CPoznAc0caDQuTVk0FlfLDWH79HumOVggLi7MDSYT5M	14rfybnh6bncm8bea95nggec3r	93gwmmkcyj8idggcy9se8azh1r
$pWJdSD5NsfN2PI0YapF9GmJPDpHhbeH6m--Uc5qoX-A	y6o3j16ifpbb8puafa31a6frur	93gwmmkcyj8idggcy9se8azh1r
$NSU5p_lrJEBTd3R6M_2_6ujF1CP9jw5z6-bDhTYxlzY	rio1bzs5kbrg7ef4p6n7fkptbw	rio1bzs5kbrg7ef4p6n7fkptbw
$bZPoJ2CteeROVbzJXAb_pwUfP2AIqhQn8X1nYN6cjRI	71da9nz8ktd1uenwg8gd6q99tw	71da9nz8ktd1uenwg8gd6q99tw
$EpI_As8tc8wuYQzlSbGEsxAOAAjphf1Wn48-zC2Pj68	1pe3kybx5tyo9jiq3bify8ptrh	1pe3kybx5tyo9jiq3bify8ptrh
$Q-2CPBoV3oTFZxGNkFMvNq26XugVjG2Cya0i5tuYeEg	gixo377eyinfteib5hqppj9qtc	gixo377eyinfteib5hqppj9qtc
$_k0ZpNW0oLpqiDqR7NJvZKdA2ZtHt_egRgLiFirmaYQ	gixo377eyinfteib5hqppj9qtc	gixo377eyinfteib5hqppj9qtc
$tWUlYx2qFNzpE_0CfMdKwbXSysRu-Z-uE0yWFp2GbGo	ndgbe1r1yj8e8y3a36d9t7ar8a	ndgbe1r1yj8e8y3a36d9t7ar8a
$Ip6vtDe80sOxCWnWoPVYYN-aqQ4AdGR-zO_krrdduFg	yxihh1tccifguncnq4whgxfycw	yxihh1tccifguncnq4whgxfycw
$9bNGuvT22oFV6Q8GFIzEZVofSbnyc61EIvnP8_3QqCE	gqa8kbchcfdcze36pkiiiphjmy	gqa8kbchcfdcze36pkiiiphjmy
$FhGz_XSQqkNt3u5faKV2p5k8gF47j_27y5RwVbtf3dk	gzzbou3mbbrc7pzmohq1ncmupe	gzzbou3mbbrc7pzmohq1ncmupe
$J2GCbFH7iG1fp5SNdsGmkmqFm59eqB_lJMGLY5yk1D8	pyi6yrpnbp8m8cbpc3oruprcir	pyi6yrpnbp8m8cbpc3oruprcir
$Dtmij3Zgur83VAr9O_P7MPtbPgUoMnnz_pOwemaro9I	ke45aoj9gp8obf8mbnb1339soe	ke45aoj9gp8obf8mbnb1339soe
$Y0__yZ70xH8p15Jr_yTtOJmrMCpaSJLwSo2cc1W4F6o	ftpue6qasbncmxobsq7uzmy49y	ftpue6qasbncmxobsq7uzmy49y
$gPWgeFNvAi1vMKPUzorqatfuOy4HXWKOwonBbcYhiN8	ok1p6motfjrc58irzfb8inqwjc	ftpue6qasbncmxobsq7uzmy49y
$Bh8N0WeVWl8koOcEkS8E0m4kulvHaq75oA0ou0aE8qs	449kcr99rfydbjawembinps4cr	ftpue6qasbncmxobsq7uzmy49y
$GgR_nTglOMJoS8SoJ-HFOS81y7cmJK64h0DeBVyFxkM	qu8eonsiofbh3e3ph9u4ohbayo	qu8eonsiofbh3e3ph9u4ohbayo
$_fc7lLRXoDsqiFKFvhlsSOsOE75ppMdi2ZRa-w_o0OY	x71e6yzecp8p5qzspj5bzdj3uy	qu8eonsiofbh3e3ph9u4ohbayo
$oXdn9vR9Yxd3FXZOxnZLiW-XByipCOWC32N6UNC7fCI	euwuo4id1frfj8pni1mwd7euma	qu8eonsiofbh3e3ph9u4ohbayo
$sDESXFNHywZLVAjOAvBW4Qtv660_Xx9oVSAIUzZs5bA	h7xx3bbu9pfz8nym9bdds46mry	h7xx3bbu9pfz8nym9bdds46mry
$jnaBiJUcEka0drCdQFKBUWluWZq5S7dPNR3XCnWwx8g	44c6ntdjd3yrifhsnezrykeppr	h7xx3bbu9pfz8nym9bdds46mry
$Hlu0oKcyD432dWmJ9w0xHm3PLMnH85Jn-X3GDTYuVV4	szejk99zipgnmgrzgmec9ynyxr	h7xx3bbu9pfz8nym9bdds46mry
$CGChqoz8kvvahzTLr-uENaReKyq5KpqLrL1g9bePx2I	n71qfubh5j8mzpokksdcg8qk4c	n71qfubh5j8mzpokksdcg8qk4c
$m8qqKQF7tvdc1qLDrWf1DjyHng9_F2Y0v_gzFRh6Kag	148sy9danpysbpegc7xudz6pph	148sy9danpysbpegc7xudz6pph
$ABAs5n2LLFjtJj9U8vpXJZW4XssE1_1AOKq1Hht9rAc	jmjiw5kcmbbxdj39q57jjphcge	jmjiw5kcmbbxdj39q57jjphcge
$u2wX-H57z6LJIi2iBRq8--9YEHZj924d1XHR1tbNoTU	obi377bmxpn68cihgxoa77r9zw	obi377bmxpn68cihgxoa77r9zw
$dyDBJ0bfzPuc6VwuCR3A1Q2GNqb5JweFoRuLiNBdLgg	3wg4998z9brp5qea3ybh5zx17o	3wg4998z9brp5qea3ybh5zx17o
$HtuzOrzcCN4JBQCmC2S0KmN-Sq3OXYHy41_xxL3VNE4	oydyrs9igfy5bd9no813tqyfec	oydyrs9igfy5bd9no813tqyfec
$uwxaXiusawT_bOeyGHwB7wfy4YVDUUpEs6A4YMBKfTg	cxkzg45m6jnbxxqbz3weixjdxh	cxkzg45m6jnbxxqbz3weixjdxh
$GoX13j6N-LFoVwqTvDVdFkmlAMyOQncU-wyYccvSOnE	swojgqjo5if3tbjk6e1i5jpkfr	swojgqjo5if3tbjk6e1i5jpkfr
$VcoB1_pk9tOinsmwdQJYShtIuSLosTj-jzPHDVJjEv8	1pe3kybx5tyo9jiq3bify8ptrh	1pe3kybx5tyo9jiq3bify8ptrh
$ORHWJnv40jDzKKISq_X3_aBTGHZZJqjFEVg1kUnrWQ4	hbba4mmt93r9zpe9m8iskjknxc	hbba4mmt93r9zpe9m8iskjknxc
$njvVCKYhRssX__fnFZ8owlNsOC9u3FRj0pmcqeIVVjI	hbba4mmt93r9zpe9m8iskjknxc	hbba4mmt93r9zpe9m8iskjknxc
$7SK-_DIPq2s374RTSr3as9S8GNyjBCDXOXK_ycMXc74	87khotcttbgy9xh1uxp859twse	87khotcttbgy9xh1uxp859twse
$0DBuAxDOgwokpytW0JkbbD3h3YNz3tiYsyJNZZqT6dM	1g6ctmjhe7nb9jssbyowx1ji6c	1g6ctmjhe7nb9jssbyowx1ji6c
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
@matrix_a:localhost	1fgsimi9s3rmjxzxsaeqrr66ko	6nk5qzigrfg8py1bfjx49zkrgh	t	matrix_matrix_a	Matrix UserA
@mm_mattermost_a:localhost	5bw66y36bff3umq1q57mfy4y5c		f	mattermost_a	MattermostUser A [mm]
@user1:localhost	she685ewdtyq7m7jgmys7zoqmr	pgrgjax6rpggub1hxajrw5ne4h	t	matrix_user1	User 1
@mm_user1:localhost	98kwr77m4jgwmbdgygknaowcch		f	user1	user1 [mm]
@mm_mattermost_b:localhost	3zats68fztgu9mgu944a4t35so		f	mattermost_b	mattermost_b [mm]
@matrix_b:localhost	kgr5hfwxy78k5n9gfkdhcscdoc	j6knf51k1jb63fe8moah7qbf6o	t	matrix_matrix_b	matrix_b
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

