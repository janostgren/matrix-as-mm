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
-- Name: audits; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.audits (
    id character varying(26) NOT NULL,
    createat bigint,
    userid character varying(26),
    action character varying(512),
    extrainfo character varying(1024),
    ipaddress character varying(64),
    sessionid character varying(26)
);


ALTER TABLE public.audits OWNER TO mattermost;

--
-- Name: bots; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.bots (
    userid character varying(26) NOT NULL,
    description character varying(1024),
    ownerid character varying(190),
    lasticonupdate bigint,
    createat bigint,
    updateat bigint,
    deleteat bigint
);


ALTER TABLE public.bots OWNER TO mattermost;

--
-- Name: channelmemberhistory; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.channelmemberhistory (
    channelid character varying(26) NOT NULL,
    userid character varying(26) NOT NULL,
    jointime bigint NOT NULL,
    leavetime bigint
);


ALTER TABLE public.channelmemberhistory OWNER TO mattermost;

--
-- Name: channelmembers; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.channelmembers (
    channelid character varying(26) NOT NULL,
    userid character varying(26) NOT NULL,
    roles character varying(64),
    lastviewedat bigint,
    msgcount bigint,
    mentioncount bigint,
    notifyprops character varying(2000),
    lastupdateat bigint,
    schemeuser boolean,
    schemeadmin boolean,
    schemeguest boolean
);


ALTER TABLE public.channelmembers OWNER TO mattermost;

--
-- Name: channels; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.channels (
    id character varying(26) NOT NULL,
    createat bigint,
    updateat bigint,
    deleteat bigint,
    teamid character varying(26),
    type character varying(1),
    displayname character varying(64),
    name character varying(64),
    header character varying(1024),
    purpose character varying(250),
    lastpostat bigint,
    totalmsgcount bigint,
    extraupdateat bigint,
    creatorid character varying(26),
    schemeid character varying(26),
    groupconstrained boolean
);


ALTER TABLE public.channels OWNER TO mattermost;

--
-- Name: clusterdiscovery; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.clusterdiscovery (
    id character varying(26) NOT NULL,
    type character varying(64),
    clustername character varying(64),
    hostname character varying(512),
    gossipport integer,
    port integer,
    createat bigint,
    lastpingat bigint
);


ALTER TABLE public.clusterdiscovery OWNER TO mattermost;

--
-- Name: commands; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.commands (
    id character varying(26) NOT NULL,
    token character varying(26),
    createat bigint,
    updateat bigint,
    deleteat bigint,
    creatorid character varying(26),
    teamid character varying(26),
    trigger character varying(128),
    method character varying(1),
    username character varying(64),
    iconurl character varying(1024),
    autocomplete boolean,
    autocompletedesc character varying(1024),
    autocompletehint character varying(1024),
    displayname character varying(64),
    description character varying(128),
    url character varying(1024)
);


ALTER TABLE public.commands OWNER TO mattermost;

--
-- Name: commandwebhooks; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.commandwebhooks (
    id character varying(26) NOT NULL,
    createat bigint,
    commandid character varying(26),
    userid character varying(26),
    channelid character varying(26),
    rootid character varying(26),
    parentid character varying(26),
    usecount integer
);


ALTER TABLE public.commandwebhooks OWNER TO mattermost;

--
-- Name: compliances; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.compliances (
    id character varying(26) NOT NULL,
    createat bigint,
    userid character varying(26),
    status character varying(64),
    count integer,
    "desc" character varying(512),
    type character varying(64),
    startat bigint,
    endat bigint,
    keywords character varying(512),
    emails character varying(1024)
);


ALTER TABLE public.compliances OWNER TO mattermost;

--
-- Name: emoji; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.emoji (
    id character varying(26) NOT NULL,
    createat bigint,
    updateat bigint,
    deleteat bigint,
    creatorid character varying(26),
    name character varying(64)
);


ALTER TABLE public.emoji OWNER TO mattermost;

--
-- Name: fileinfo; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.fileinfo (
    id character varying(26) NOT NULL,
    creatorid character varying(26),
    postid character varying(26),
    createat bigint,
    updateat bigint,
    deleteat bigint,
    path character varying(512),
    thumbnailpath character varying(512),
    previewpath character varying(512),
    name character varying(256),
    extension character varying(64),
    size bigint,
    mimetype character varying(256),
    width integer,
    height integer,
    haspreviewimage boolean
);


ALTER TABLE public.fileinfo OWNER TO mattermost;

--
-- Name: groupchannels; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.groupchannels (
    groupid character varying(26) NOT NULL,
    autoadd boolean,
    schemeadmin boolean,
    createat bigint,
    deleteat bigint,
    updateat bigint,
    channelid character varying(26) NOT NULL
);


ALTER TABLE public.groupchannels OWNER TO mattermost;

--
-- Name: groupmembers; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.groupmembers (
    groupid character varying(26) NOT NULL,
    userid character varying(26) NOT NULL,
    createat bigint,
    deleteat bigint
);


ALTER TABLE public.groupmembers OWNER TO mattermost;

--
-- Name: groupteams; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.groupteams (
    groupid character varying(26) NOT NULL,
    autoadd boolean,
    schemeadmin boolean,
    createat bigint,
    deleteat bigint,
    updateat bigint,
    teamid character varying(26) NOT NULL
);


ALTER TABLE public.groupteams OWNER TO mattermost;

--
-- Name: incomingwebhooks; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.incomingwebhooks (
    id character varying(26) NOT NULL,
    createat bigint,
    updateat bigint,
    deleteat bigint,
    userid character varying(26),
    channelid character varying(26),
    teamid character varying(26),
    displayname character varying(64),
    description character varying(500),
    username text,
    iconurl text,
    channellocked boolean
);


ALTER TABLE public.incomingwebhooks OWNER TO mattermost;

--
-- Name: jobs; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.jobs (
    id character varying(26) NOT NULL,
    type character varying(32),
    priority bigint,
    createat bigint,
    startat bigint,
    lastactivityat bigint,
    status character varying(32),
    progress bigint,
    data character varying(1024)
);


ALTER TABLE public.jobs OWNER TO mattermost;

--
-- Name: licenses; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.licenses (
    id character varying(26) NOT NULL,
    createat bigint,
    bytes character varying(10000)
);


ALTER TABLE public.licenses OWNER TO mattermost;

--
-- Name: linkmetadata; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.linkmetadata (
    hash bigint NOT NULL,
    url character varying(2048),
    "timestamp" bigint,
    type character varying(16),
    data character varying(4096)
);


ALTER TABLE public.linkmetadata OWNER TO mattermost;

--
-- Name: oauthaccessdata; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.oauthaccessdata (
    clientid character varying(26),
    userid character varying(26),
    token character varying(26) NOT NULL,
    refreshtoken character varying(26),
    redirecturi character varying(256),
    expiresat bigint,
    scope character varying(128)
);


ALTER TABLE public.oauthaccessdata OWNER TO mattermost;

--
-- Name: oauthapps; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.oauthapps (
    id character varying(26) NOT NULL,
    creatorid character varying(26),
    createat bigint,
    updateat bigint,
    clientsecret character varying(128),
    name character varying(64),
    description character varying(512),
    iconurl character varying(512),
    callbackurls character varying(1024),
    homepage character varying(256),
    istrusted boolean
);


ALTER TABLE public.oauthapps OWNER TO mattermost;

--
-- Name: oauthauthdata; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.oauthauthdata (
    clientid character varying(26),
    userid character varying(26),
    code character varying(128) NOT NULL,
    expiresin integer,
    createat bigint,
    redirecturi character varying(256),
    state character varying(1024),
    scope character varying(128)
);


ALTER TABLE public.oauthauthdata OWNER TO mattermost;

--
-- Name: outgoingwebhooks; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.outgoingwebhooks (
    id character varying(26) NOT NULL,
    token character varying(26),
    createat bigint,
    updateat bigint,
    deleteat bigint,
    creatorid character varying(26),
    channelid character varying(26),
    teamid character varying(26),
    triggerwords character varying(1024),
    triggerwhen integer,
    callbackurls character varying(1024),
    displayname character varying(64),
    description character varying(500),
    contenttype character varying(128),
    username character varying(64),
    iconurl character varying(1024)
);


ALTER TABLE public.outgoingwebhooks OWNER TO mattermost;

--
-- Name: pluginkeyvaluestore; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.pluginkeyvaluestore (
    pluginid character varying(190) NOT NULL,
    pkey character varying(50) NOT NULL,
    pvalue bytea,
    expireat bigint
);


ALTER TABLE public.pluginkeyvaluestore OWNER TO mattermost;

--
-- Name: posts; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.posts (
    id character varying(26) NOT NULL,
    createat bigint,
    updateat bigint,
    editat bigint,
    deleteat bigint,
    ispinned boolean,
    userid character varying(26),
    channelid character varying(26),
    rootid character varying(26),
    parentid character varying(26),
    originalid character varying(26),
    message character varying(65535),
    type character varying(26),
    props character varying(8000),
    hashtags character varying(1000),
    filenames character varying(4000),
    fileids character varying(150),
    hasreactions boolean
);


ALTER TABLE public.posts OWNER TO mattermost;

--
-- Name: preferences; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.preferences (
    userid character varying(26) NOT NULL,
    category character varying(32) NOT NULL,
    name character varying(32) NOT NULL,
    value character varying(2000)
);


ALTER TABLE public.preferences OWNER TO mattermost;

--
-- Name: publicchannels; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.publicchannels (
    id character varying(26) NOT NULL,
    deleteat bigint,
    teamid character varying(26),
    displayname character varying(64),
    name character varying(64),
    header character varying(1024),
    purpose character varying(250)
);


ALTER TABLE public.publicchannels OWNER TO mattermost;

--
-- Name: reactions; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.reactions (
    userid character varying(26) NOT NULL,
    postid character varying(26) NOT NULL,
    emojiname character varying(64) NOT NULL,
    createat bigint
);


ALTER TABLE public.reactions OWNER TO mattermost;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.roles (
    id character varying(26) NOT NULL,
    name character varying(64),
    displayname character varying(128),
    description character varying(1024),
    createat bigint,
    updateat bigint,
    deleteat bigint,
    permissions character varying(4096),
    schememanaged boolean,
    builtin boolean
);


ALTER TABLE public.roles OWNER TO mattermost;

--
-- Name: schemes; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.schemes (
    id character varying(26) NOT NULL,
    name character varying(64),
    displayname character varying(128),
    description character varying(1024),
    createat bigint,
    updateat bigint,
    deleteat bigint,
    scope character varying(32),
    defaultteamadminrole character varying(64),
    defaultteamuserrole character varying(64),
    defaultchanneladminrole character varying(64),
    defaultchanneluserrole character varying(64),
    defaultteamguestrole character varying(64),
    defaultchannelguestrole character varying(64)
);


ALTER TABLE public.schemes OWNER TO mattermost;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.sessions (
    id character varying(26) NOT NULL,
    token character varying(26),
    createat bigint,
    expiresat bigint,
    lastactivityat bigint,
    userid character varying(26),
    deviceid character varying(512),
    roles character varying(64),
    isoauth boolean,
    expirednotify boolean,
    props character varying(1000)
);


ALTER TABLE public.sessions OWNER TO mattermost;

--
-- Name: sidebarcategories; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.sidebarcategories (
    id character varying(26) NOT NULL,
    userid character varying(26),
    teamid character varying(26),
    sortorder bigint,
    sorting character varying(64),
    type character varying(64),
    displayname character varying(64)
);


ALTER TABLE public.sidebarcategories OWNER TO mattermost;

--
-- Name: sidebarchannels; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.sidebarchannels (
    channelid character varying(26) NOT NULL,
    userid character varying(26) NOT NULL,
    categoryid character varying(26) NOT NULL,
    sortorder bigint
);


ALTER TABLE public.sidebarchannels OWNER TO mattermost;

--
-- Name: status; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.status (
    userid character varying(26) NOT NULL,
    status character varying(32),
    manual boolean,
    lastactivityat bigint
);


ALTER TABLE public.status OWNER TO mattermost;

--
-- Name: systems; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.systems (
    name character varying(64) NOT NULL,
    value character varying(1024)
);


ALTER TABLE public.systems OWNER TO mattermost;

--
-- Name: teammembers; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.teammembers (
    teamid character varying(26) NOT NULL,
    userid character varying(26) NOT NULL,
    roles character varying(64),
    deleteat bigint,
    schemeuser boolean,
    schemeadmin boolean,
    schemeguest boolean
);


ALTER TABLE public.teammembers OWNER TO mattermost;

--
-- Name: teams; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.teams (
    id character varying(26) NOT NULL,
    createat bigint,
    updateat bigint,
    deleteat bigint,
    displayname character varying(64),
    name character varying(64),
    description character varying(255),
    email character varying(128),
    type text,
    companyname character varying(64),
    alloweddomains character varying(1000),
    inviteid character varying(32),
    allowopeninvite boolean,
    lastteamiconupdate bigint,
    schemeid text,
    groupconstrained boolean
);


ALTER TABLE public.teams OWNER TO mattermost;

--
-- Name: termsofservice; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.termsofservice (
    id character varying(26) NOT NULL,
    createat bigint,
    userid character varying(26),
    text character varying(65535)
);


ALTER TABLE public.termsofservice OWNER TO mattermost;

--
-- Name: tokens; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.tokens (
    token character varying(64) NOT NULL,
    createat bigint,
    type character varying(64),
    extra character varying(2048)
);


ALTER TABLE public.tokens OWNER TO mattermost;

--
-- Name: useraccesstokens; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.useraccesstokens (
    id character varying(26) NOT NULL,
    token character varying(26),
    userid character varying(26),
    description character varying(512),
    isactive boolean
);


ALTER TABLE public.useraccesstokens OWNER TO mattermost;

--
-- Name: usergroups; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.usergroups (
    id character varying(26) NOT NULL,
    name character varying(64),
    displayname character varying(128),
    description character varying(1024),
    source character varying(64),
    remoteid character varying(48),
    createat bigint,
    updateat bigint,
    deleteat bigint,
    allowreference boolean
);


ALTER TABLE public.usergroups OWNER TO mattermost;

--
-- Name: users; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.users (
    id character varying(26) NOT NULL,
    createat bigint,
    updateat bigint,
    deleteat bigint,
    username character varying(64),
    password character varying(128),
    authdata character varying(128),
    authservice character varying(32),
    email character varying(128),
    emailverified boolean,
    nickname character varying(64),
    firstname character varying(64),
    lastname character varying(64),
    "position" character varying(128),
    roles character varying(256),
    allowmarketing boolean,
    props character varying(4000),
    notifyprops character varying(2000),
    lastpasswordupdate bigint,
    lastpictureupdate bigint,
    failedattempts integer,
    locale character varying(5),
    timezone character varying(256),
    mfaactive boolean,
    mfasecret character varying(128)
);


ALTER TABLE public.users OWNER TO mattermost;

--
-- Name: usertermsofservice; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.usertermsofservice (
    userid character varying(26) NOT NULL,
    termsofserviceid character varying(26),
    createat bigint
);


ALTER TABLE public.usertermsofservice OWNER TO mattermost;

--
-- Data for Name: audits; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.audits (id, createat, userid, action, extrainfo, ipaddress, sessionid) FROM stdin;
jybysfe1uinqbmi47wscj77eco	1672674601386	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
wsz81jicji88xbqkof97rq77sa	1672674601420	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
ndj5eh1hr7ffbmapqsicxitr4e	1672674601917	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/p584bbmabpghxqz4qdwj8pdhpr/email/verify/member	user verified	172.16.238.1	hgh71ukabjyzzd1zdbq391peda
tu8e1gyo53gqjf5phuedudndaa	1672674601927	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/p584bbmabpghxqz4qdwj8pdhpr/tokens		172.16.238.1	hgh71ukabjyzzd1zdbq391peda
hfynqnxnufrjfjjkqsk4hf9iwo	1672674601946	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/p584bbmabpghxqz4qdwj8pdhpr/tokens	success - token_id=ob3junttstrfzfffkxg5cuwrth	172.16.238.1	hgh71ukabjyzzd1zdbq391peda
xbrnxomrnbgdbq8jgioq7wsmch	1672674602256	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/6afiyfegctd1zxwen4aq4ywpyr/email/verify/member	user verified	172.16.238.1	hgh71ukabjyzzd1zdbq391peda
d5qr186y9tg7dpjsxkugm3qhse	1672674602285	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/6afiyfegctd1zxwen4aq4ywpyr/tokens		172.16.238.1	hgh71ukabjyzzd1zdbq391peda
6uha4touobfybe39dima878u9h	1672674602320	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/6afiyfegctd1zxwen4aq4ywpyr/tokens	success - token_id=mbd3efwr6bfsddqr1j3ty7ka7a	172.16.238.1	hgh71ukabjyzzd1zdbq391peda
rbmxqifmw3859rjgha85xymrza	1672674602322	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=p584bbmabpghxqz4qdwj8pdhpr	172.16.238.1	hgh71ukabjyzzd1zdbq391peda
foio4a9qqbyy8d3eztphbn6isc	1672674602540	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/p584bbmabpghxqz4qdwj8pdhpr/patch		172.16.238.1	hgh71ukabjyzzd1zdbq391peda
8ykuhpacoiy7up81bi761niqew	1672674602583	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/6afiyfegctd1zxwen4aq4ywpyr/patch		172.16.238.1	hgh71ukabjyzzd1zdbq391peda
hzr99twkwbnuu8rwihe35o1p5y	1672674602600	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=p584bbmabpghxqz4qdwj8pdhpr	172.16.238.1	hgh71ukabjyzzd1zdbq391peda
b5xpsy8qxpfgtmcfkwznm63kya	1672674602633	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=6afiyfegctd1zxwen4aq4ywpyr	172.16.238.1	hgh71ukabjyzzd1zdbq391peda
mhauyxz5jpg8xnnz89cb9g8y6r	1672674602836	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=6afiyfegctd1zxwen4aq4ywpyr	172.16.238.1	hgh71ukabjyzzd1zdbq391peda
397y8wey9fgs3n9ridxfcbqmiy	1672674729145		/api/v4/users/login	attempt - login_id=admin	172.16.238.1	
rx6qsxu7cigpfjnbermqkf7wby	1672674729295		/api/v4/users/login	failure - login_id=admin	172.16.238.1	
8podwkdbz7rd7ryg9onenhri6h	1672674742669		/api/v4/users/login	attempt - login_id=admin	172.16.238.1	
wbfp1ried3grpr57a6u5ffannh	1672674742775		/api/v4/users/login	failure - login_id=admin	172.16.238.1	
9pmjuhd8k3fzjfzxdwzni9yeac	1672674758162		/api/v4/users/login	attempt - login_id=admin	172.16.238.1	
prpyp6x65fdefbttdskz3kn9te	1672674758261		/api/v4/users/login	failure - login_id=admin	172.16.238.1	
m7456u4jrifp78sbab95k1q6hy	1672674771827		/api/v4/users/login	attempt - login_id=admin	172.16.238.1	
ya99wkmeobbqpff3ee4m7dnbse	1672674771930	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/login	authenticated	172.16.238.1	
gxxdocxtrfnptyc73qcwck8kme	1672674771940	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/login	success session_user=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	ejed1nx467yk8ro75gcauw1fkh
jpfti9mmatf67ynarfi3jmbwey	1672675057368	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/logout		172.16.238.1	ejed1nx467yk8ro75gcauw1fkh
pti3qtj1uib8db8ygytmygptwe	1672675063824		/api/v4/users/login	attempt - login_id=bridgeuser2	172.16.238.1	
5s7aytohdjbi3kzzt7th6z6i9e	1672675063828		/api/v4/users/login	failure - login_id=bridgeuser2	172.16.238.1	
a41begwxibd7bxcit66jeabq8h	1672675084999	ujmedpkiu3rcxyaojr1k1qem4h	/api/v4/users/login	attempt - login_id=	172.16.238.1	
9ozarxjs4pfm7mutehpbrh5f7o	1672675085153	ujmedpkiu3rcxyaojr1k1qem4h	/api/v4/users/login	authenticated	172.16.238.1	
7wapwnt1y7rhpmx51mu3crhr4y	1672675085161	ujmedpkiu3rcxyaojr1k1qem4h	/api/v4/users/login	success session_user=ujmedpkiu3rcxyaojr1k1qem4h	172.16.238.1	kz74mxxyxpnxzqrq4c997c1h1h
7fyubc6sm7gwtenaaoxeswddwh	1672675151281	ujmedpkiu3rcxyaojr1k1qem4h	/api/v4/users/logout		172.16.238.1	kz74mxxyxpnxzqrq4c997c1h1h
agq814zi43863y4ktdjjwc165w	1672675171091	esahgx8oc7y3pbm4f95doipzny	/api/v4/users/login	attempt - login_id=	172.16.238.1	
3n5onqkiqt8hiyfrfb88byyqgc	1672675171198	esahgx8oc7y3pbm4f95doipzny	/api/v4/users/login	authenticated	172.16.238.1	
bueh3od9xby8ujdy6w64ikfjwc	1672675171203	esahgx8oc7y3pbm4f95doipzny	/api/v4/users/login	success session_user=esahgx8oc7y3pbm4f95doipzny	172.16.238.1	61ii56xu4bdabjxykoe61dinwe
oyfwskwjxbf8uggk9bgxab85me	1672675208514	esahgx8oc7y3pbm4f95doipzny	/api/v4/users/logout		172.16.238.1	61ii56xu4bdabjxykoe61dinwe
t59hg9yug3r7pepa7htzgyw8yo	1672675219466		/api/v4/users/login	attempt - login_id=admin	172.16.238.1	
jumbu5so5jydxcwfn3jxwm7k3y	1672675219569		/api/v4/users/login	failure - login_id=admin	172.16.238.1	
8z8717cyujnjpq171mbe9oamco	1672675225207		/api/v4/users/login	attempt - login_id=admin	172.16.238.1	
nu8i4yby9pyqimzna7c8gp7sqo	1672675225310		/api/v4/users/login	failure - login_id=admin	172.16.238.1	
nyjjd7xamp843fqfdjqm7uhu3y	1672675236561		/api/v4/users/login	attempt - login_id=admin	172.16.238.1	
witqqz3o9fgn8fgjzyqfd6mjoy	1672675236664	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/login	authenticated	172.16.238.1	
xxrbob1rspdiicryjsmnieod3a	1672675236672	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/login	success session_user=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	r4749uk99i8fpmxk6y8cbw4sdw
47d47goye78bd8thihn5th1i8h	1672676698261	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/teams/tgrw7sjgbiy1jggs3qg3m6zpee/patch		172.16.238.1	r4749uk99i8fpmxk6y8cbw4sdw
qacq354q738h5yo1tst5hi7ywc	1672676978616	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/logout		172.16.238.1	r4749uk99i8fpmxk6y8cbw4sdw
gyxgh79ktfdg5pjsir5pyffjke	1672676988210		/api/v4/users/login	attempt - login_id=bridgeuser2	172.16.238.1	
jzabm89f8iyzfrcrf3outdtpiw	1672676988302	esahgx8oc7y3pbm4f95doipzny	/api/v4/users/login	authenticated	172.16.238.1	
cz77egopxbyjmbnzmai9c7u1jh	1672676988307	esahgx8oc7y3pbm4f95doipzny	/api/v4/users/login	success session_user=esahgx8oc7y3pbm4f95doipzny	172.16.238.1	ps7nokk9o3drfmmxfpxzgmmyqh
kfyramof1bg5uxnj9zk8t9tq8a	1672677000989	esahgx8oc7y3pbm4f95doipzny	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=esahgx8oc7y3pbm4f95doipzny	172.16.238.1	ps7nokk9o3drfmmxfpxzgmmyqh
guj9asta43gfty3mr5m7htssca	1672677121746	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=6afiyfegctd1zxwen4aq4ywpyr	172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
n7tzjjnp17b9jftsjxjjegr6ge	1672677121395	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
uf54u46opig5uj43oxeyqr4u8y	1672677121742	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=6afiyfegctd1zxwen4aq4ywpyr	172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
oebqm9osdiycddqujoxs7eb8pa	1672677121405	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
omrzmydeafdh9f66aohjzeqbbo	1672677121610	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/6afiyfegctd1zxwen4aq4ywpyr/patch		172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
4utyjwma9fdpbn5dp9mc6kyq5h	1672677121750	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=p584bbmabpghxqz4qdwj8pdhpr	172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
ha9dyqa7m3dr3k7jnowbg3ezpo	1672677121622	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/6afiyfegctd1zxwen4aq4ywpyr/patch		172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
7xozb6xhyigxppcsdfro9s1nar	1672677121625	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/p584bbmabpghxqz4qdwj8pdhpr/patch		172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
rsx676c5xpgjx8r3wyqufem87h	1672677121771	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/p584bbmabpghxqz4qdwj8pdhpr/patch		172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
gwj4kacm4b883pdx9pg4xem1ih	1672677121919	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=p584bbmabpghxqz4qdwj8pdhpr	172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
id7ciyk747gs9kxwrt6myc83xo	1672677408369	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
zjnoutjkib8jt8sse394owsa3o	1672677408378	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
jamsdhq8kb89td3achmast84sa	1672677408754	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/p584bbmabpghxqz4qdwj8pdhpr/patch		172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
ybyxso7iyb8i9gb7pkzrpwiyfc	1672677408794	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/6afiyfegctd1zxwen4aq4ywpyr/patch		172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
r8phfznp6p8k7eg38iiawkdfwc	1672677408854	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=p584bbmabpghxqz4qdwj8pdhpr	172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
e8jzfxnk17bybp43kqjmqmqi5a	1672677408912	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/p584bbmabpghxqz4qdwj8pdhpr/patch		172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
wu33pgpa47b7tegdruses6i54c	1672677408930	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=6afiyfegctd1zxwen4aq4ywpyr	172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
8ar4t4trfpf1jkz8f9d54gyttc	1672677408988	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/6afiyfegctd1zxwen4aq4ywpyr/patch		172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
epsoikps6fyxmfs9haz3zt18ch	1672677409060	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=p584bbmabpghxqz4qdwj8pdhpr	172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
b5zx9zqsnbr48mxn831x3mxauh	1672677409062	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=6afiyfegctd1zxwen4aq4ywpyr	172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
obm35u6i87ftbqetdoqjrfk34w	1672677521513	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	hgh71ukabjyzzd1zdbq391peda
3o1pmbz3738sfpxjih8csi18ow	1672677521520	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	hgh71ukabjyzzd1zdbq391peda
54r7xepe9jgfpqdgba8e74mb6c	1672677521736	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/p584bbmabpghxqz4qdwj8pdhpr/patch		172.16.238.1	hgh71ukabjyzzd1zdbq391peda
ixuipyjkrbycugtq4gr6ayopja	1672677521780	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=p584bbmabpghxqz4qdwj8pdhpr	172.16.238.1	hgh71ukabjyzzd1zdbq391peda
dsdmkq8kopdwd85t3co9czxj1r	1672677521841	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/6afiyfegctd1zxwen4aq4ywpyr/patch		172.16.238.1	hgh71ukabjyzzd1zdbq391peda
m4j7mzqihprzdnnwct6bj91rce	1672677521854	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/6afiyfegctd1zxwen4aq4ywpyr/patch		172.16.238.1	hgh71ukabjyzzd1zdbq391peda
uugq9jp9x7bp8pd53d5ptdm59a	1672677521876	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/p584bbmabpghxqz4qdwj8pdhpr/patch		172.16.238.1	hgh71ukabjyzzd1zdbq391peda
n3iedn7xitf1xnptjpaxtaduta	1672677521911	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=6afiyfegctd1zxwen4aq4ywpyr	172.16.238.1	hgh71ukabjyzzd1zdbq391peda
dqhnp1n6g78f9f3pmykmkm1rho	1672677521928	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=6afiyfegctd1zxwen4aq4ywpyr	172.16.238.1	hgh71ukabjyzzd1zdbq391peda
mf51exc68pdwmx3k77xs6pxfee	1672677521936	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=p584bbmabpghxqz4qdwj8pdhpr	172.16.238.1	hgh71ukabjyzzd1zdbq391peda
hj5npdcr8br4xnzurt88xrmytr	1672677604657	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	hgh71ukabjyzzd1zdbq391peda
zzcde5kcitn77cbdnh5ftu8qdw	1672677604689	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	hgh71ukabjyzzd1zdbq391peda
4y5brufa5tgsb8k6hkrg6jtgko	1672677604879	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/p584bbmabpghxqz4qdwj8pdhpr/patch		172.16.238.1	hgh71ukabjyzzd1zdbq391peda
monzj43qding8jqaf96ehefcqo	1672677604890	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/p584bbmabpghxqz4qdwj8pdhpr/patch		172.16.238.1	hgh71ukabjyzzd1zdbq391peda
y6ukmwqjwbbd9eska7h9s5jysw	1672677604937	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=p584bbmabpghxqz4qdwj8pdhpr	172.16.238.1	hgh71ukabjyzzd1zdbq391peda
e4g4kapysbnyd8j1zs6o6zc3nc	1672677604945	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=p584bbmabpghxqz4qdwj8pdhpr	172.16.238.1	hgh71ukabjyzzd1zdbq391peda
rqktraab9jy19mi89tms6qqchy	1672677604957	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/6afiyfegctd1zxwen4aq4ywpyr/patch		172.16.238.1	hgh71ukabjyzzd1zdbq391peda
h9tpaj56stfaxj6uk4raicqj5c	1672677604962	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/6afiyfegctd1zxwen4aq4ywpyr/patch		172.16.238.1	hgh71ukabjyzzd1zdbq391peda
r8wx37kaotng8bdsyujk1h7a7o	1672677605010	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=6afiyfegctd1zxwen4aq4ywpyr	172.16.238.1	hgh71ukabjyzzd1zdbq391peda
q9y3ofcstbg3d89oinrtc3ky9r	1672677605015	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=6afiyfegctd1zxwen4aq4ywpyr	172.16.238.1	hgh71ukabjyzzd1zdbq391peda
7fraaso9fpfku83pq44z77au6e	1672677625916	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	hgh71ukabjyzzd1zdbq391peda
dpe3wd9zebydxr3ekub653jrxw	1672677625921	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	hgh71ukabjyzzd1zdbq391peda
qg83m4waa3rm888mhjfx7zrd9y	1672677626156	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/p584bbmabpghxqz4qdwj8pdhpr/patch		172.16.238.1	hgh71ukabjyzzd1zdbq391peda
uj8df15fqfne8e6wc955aodfch	1672677626170	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/p584bbmabpghxqz4qdwj8pdhpr/patch		172.16.238.1	hgh71ukabjyzzd1zdbq391peda
7ef3o1bkbbgq8yo1amfi4n1wch	1672677626221	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/6afiyfegctd1zxwen4aq4ywpyr/patch		172.16.238.1	hgh71ukabjyzzd1zdbq391peda
w56gp51sq3fjddekzgpoh4qyfy	1672677626198	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/6afiyfegctd1zxwen4aq4ywpyr/patch		172.16.238.1	hgh71ukabjyzzd1zdbq391peda
hqnj9ygea78w3mpnqqezdq93oo	1672677626270	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=p584bbmabpghxqz4qdwj8pdhpr	172.16.238.1	hgh71ukabjyzzd1zdbq391peda
oc3ene91ptbhzjerct7k49ismy	1672677759501	esahgx8oc7y3pbm4f95doipzny	/api/v4/users/login	authenticated	172.16.238.1	
dxaiydu8qtgxmgz594qum8hh7e	1672677626269	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=p584bbmabpghxqz4qdwj8pdhpr	172.16.238.1	hgh71ukabjyzzd1zdbq391peda
huyay3h4ijdixx5bbgyng5x47y	1672677789731	esahgx8oc7y3pbm4f95doipzny	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=esahgx8oc7y3pbm4f95doipzny	172.16.238.1	dbt34xi34f8ipbrjfmj5a5xz5w
rkskyga5tpy7bfcuiep5ibu5qe	1672677626291	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=6afiyfegctd1zxwen4aq4ywpyr	172.16.238.1	hgh71ukabjyzzd1zdbq391peda
ra134n7y8tdbfboikyf41xgzey	1672677626297	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=6afiyfegctd1zxwen4aq4ywpyr	172.16.238.1	hgh71ukabjyzzd1zdbq391peda
rnpuq5rmc3no8k7wp19a76jcqa	1672677749868	esahgx8oc7y3pbm4f95doipzny	/api/v4/users/logout		172.16.238.1	ps7nokk9o3drfmmxfpxzgmmyqh
9tebhzjthpgrjqehog6nd8kica	1672677759356		/api/v4/users/login	attempt - login_id=bridgeuser2	172.16.238.1	
ub3c88k4b3njfxsidct6tkxcua	1672677759508	esahgx8oc7y3pbm4f95doipzny	/api/v4/users/login	success session_user=esahgx8oc7y3pbm4f95doipzny	172.16.238.1	dbt34xi34f8ipbrjfmj5a5xz5w
ux6x56y3itfsixde841c49856y	1672677813137	esahgx8oc7y3pbm4f95doipzny	/api/v4/channels/kn6dnqf6qtni8ji4au64qwi6ec	name=off-topic	172.16.238.1	dbt34xi34f8ipbrjfmj5a5xz5w
f5e7x64947n8fb7yy3ywotetye	1672681228685		/api/v4/users/login	attempt - login_id=bridgeuser2	172.16.238.1	
e4es9aiuq78ytjs4i1esrx975y	1672681228796	esahgx8oc7y3pbm4f95doipzny	/api/v4/users/login	authenticated	172.16.238.1	
5pknq1mojfri7cy1ndp1j9ichc	1672681228806	esahgx8oc7y3pbm4f95doipzny	/api/v4/users/login	success session_user=esahgx8oc7y3pbm4f95doipzny	172.16.238.1	ijeo34zrrfd3ueoef95p4a63to
4jnyehcyafnt8bdk4k8dcup3rw	1672681242449	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
xr84n8z6k7rrtf4sjad19ctt4a	1672681242465	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
gwht3fro8pyy5eh7n4k7oekwcw	1672681242734	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/p584bbmabpghxqz4qdwj8pdhpr/patch		172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
qczw6u55siba3raucherqb9fth	1672681242800	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/6afiyfegctd1zxwen4aq4ywpyr/patch		172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
giofmjfyoiyabk9ot9obd4ty7c	1672681242803	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/p584bbmabpghxqz4qdwj8pdhpr/patch		172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
q9pudgx5i7fn9ncz6it1zae37c	1672681242811	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=p584bbmabpghxqz4qdwj8pdhpr	172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
harc4jabgfgxdyurm8jh7nrx4w	1672681242846	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/6afiyfegctd1zxwen4aq4ywpyr/patch		172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
u1gj618eatyhj85sn5y1897bth	1672681242850	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=p584bbmabpghxqz4qdwj8pdhpr	172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
66h4w4a1bb8i7n3mzekw6sj91a	1672681242877	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=6afiyfegctd1zxwen4aq4ywpyr	172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
yain38brjifn5kqbhu9hcicffo	1672681242886	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=6afiyfegctd1zxwen4aq4ywpyr	172.16.238.1	yor9kdb16brq9guam3z6wuzxsa
rgfxqpszgir6ix4ppc84sob5qo	1672682034026	esahgx8oc7y3pbm4f95doipzny	/api/v4/users/logout		172.16.238.1	ijeo34zrrfd3ueoef95p4a63to
\.


--
-- Data for Name: bots; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.bots (userid, description, ownerid, lasticonupdate, createat, updateat, deleteat) FROM stdin;
\.


--
-- Data for Name: channelmemberhistory; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.channelmemberhistory (channelid, userid, jointime, leavetime) FROM stdin;
cxtmz3ubz3gfigd5m6prendmsw	bmq7jiumpib3xdz3mx5iyo99ro	1598351847734	\N
73uy6kj1jb8wdqrf3ti6zies6r	bmq7jiumpib3xdz3mx5iyo99ro	1598351847751	\N
cxtmz3ubz3gfigd5m6prendmsw	5bw66y36bff3umq1q57mfy4y5c	1598351852028	\N
73uy6kj1jb8wdqrf3ti6zies6r	5bw66y36bff3umq1q57mfy4y5c	1598351852045	\N
cxtmz3ubz3gfigd5m6prendmsw	3zats68fztgu9mgu944a4t35so	1598351852028	\N
73uy6kj1jb8wdqrf3ti6zies6r	3zats68fztgu9mgu944a4t35so	1598351852045	\N
cxtmz3ubz3gfigd5m6prendmsw	0z4okgmv5lfhx3p0tf6pnpk8sk	1598351852028	\N
73uy6kj1jb8wdqrf3ti6zies6r	0z4okgmv5lfhx3p0tf6pnpk8sk	1598351852045	\N
cxtmz3ubz3gfigd5m6prendmsw	p584bbmabpghxqz4qdwj8pdhpr	1672674602101	\N
73uy6kj1jb8wdqrf3ti6zies6r	p584bbmabpghxqz4qdwj8pdhpr	1672674602157	\N
73uy6kj1jb8wdqrf3ti6zies6r	6afiyfegctd1zxwen4aq4ywpyr	1672674602626	\N
cxtmz3ubz3gfigd5m6prendmsw	6afiyfegctd1zxwen4aq4ywpyr	1672674602646	\N
73uy6kj1jb8wdqrf3ti6zies6r	6afiyfegctd1zxwen4aq4ywpyr	1672674602708	\N
5kh66ydh53gs7p3xrnpo1s4dyo	ujmedpkiu3rcxyaojr1k1qem4h	1672675099844	\N
8hbx657ejpbizkubf9f9jjqdkc	ujmedpkiu3rcxyaojr1k1qem4h	1672675099877	\N
tg4mahhodbyadr4k4zbwtcz78r	esahgx8oc7y3pbm4f95doipzny	1672675188378	\N
kn6dnqf6qtni8ji4au64qwi6ec	esahgx8oc7y3pbm4f95doipzny	1672675188406	\N
cxtmz3ubz3gfigd5m6prendmsw	ujmedpkiu3rcxyaojr1k1qem4h	1672675302998	\N
73uy6kj1jb8wdqrf3ti6zies6r	ujmedpkiu3rcxyaojr1k1qem4h	1672675303032	\N
cxtmz3ubz3gfigd5m6prendmsw	esahgx8oc7y3pbm4f95doipzny	1672675303322	\N
73uy6kj1jb8wdqrf3ti6zies6r	esahgx8oc7y3pbm4f95doipzny	1672675303409	\N
f4jhbgjjkff35n5qumfnsggzha	bmq7jiumpib3xdz3mx5iyo99ro	1672676736979	\N
f4jhbgjjkff35n5qumfnsggzha	p584bbmabpghxqz4qdwj8pdhpr	1672676736981	\N
755mk8nfaf8x8ce3o7sofmxafy	bmq7jiumpib3xdz3mx5iyo99ro	1672676955490	\N
755mk8nfaf8x8ce3o7sofmxafy	5bw66y36bff3umq1q57mfy4y5c	1672676955493	\N
tg4mahhodbyadr4k4zbwtcz78r	p584bbmabpghxqz4qdwj8pdhpr	1672677047324	\N
kn6dnqf6qtni8ji4au64qwi6ec	p584bbmabpghxqz4qdwj8pdhpr	1672677047356	\N
tg4mahhodbyadr4k4zbwtcz78r	6afiyfegctd1zxwen4aq4ywpyr	1672677059880	\N
kn6dnqf6qtni8ji4au64qwi6ec	6afiyfegctd1zxwen4aq4ywpyr	1672677059911	\N
tg4mahhodbyadr4k4zbwtcz78r	bmq7jiumpib3xdz3mx5iyo99ro	1672677078568	\N
kn6dnqf6qtni8ji4au64qwi6ec	bmq7jiumpib3xdz3mx5iyo99ro	1672677078600	\N
tg4mahhodbyadr4k4zbwtcz78r	ujmedpkiu3rcxyaojr1k1qem4h	1672677089898	\N
kn6dnqf6qtni8ji4au64qwi6ec	ujmedpkiu3rcxyaojr1k1qem4h	1672677089939	\N
\.


--
-- Data for Name: channelmembers; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.channelmembers (channelid, userid, roles, lastviewedat, msgcount, mentioncount, notifyprops, lastupdateat, schemeuser, schemeadmin, schemeguest) FROM stdin;
cxtmz3ubz3gfigd5m6prendmsw	5bw66y36bff3umq1q57mfy4y5c		0	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1598351852017	t	f	f
73uy6kj1jb8wdqrf3ti6zies6r	5bw66y36bff3umq1q57mfy4y5c		0	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1598351852041	t	f	f
cxtmz3ubz3gfigd5m6prendmsw	0z4okgmv5lfhx3p0tf6pnpk8sk		0	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1598351852017	t	f	f
73uy6kj1jb8wdqrf3ti6zies6r	0z4okgmv5lfhx3p0tf6pnpk8sk		0	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1598351852041	t	f	f
cxtmz3ubz3gfigd5m6prendmsw	3zats68fztgu9mgu944a4t35so		0	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1598351852017	t	f	f
73uy6kj1jb8wdqrf3ti6zies6r	3zats68fztgu9mgu944a4t35so		0	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1598351852041	t	f	f
cxtmz3ubz3gfigd5m6prendmsw	p584bbmabpghxqz4qdwj8pdhpr		0	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672674602088	t	f	f
73uy6kj1jb8wdqrf3ti6zies6r	p584bbmabpghxqz4qdwj8pdhpr		0	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672674602136	t	f	f
cxtmz3ubz3gfigd5m6prendmsw	6afiyfegctd1zxwen4aq4ywpyr		0	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672674602630	t	f	f
73uy6kj1jb8wdqrf3ti6zies6r	6afiyfegctd1zxwen4aq4ywpyr		0	0	1	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672674602677	t	f	f
8hbx657ejpbizkubf9f9jjqdkc	ujmedpkiu3rcxyaojr1k1qem4h		1672675099880	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672675099880	t	t	f
5kh66ydh53gs7p3xrnpo1s4dyo	ujmedpkiu3rcxyaojr1k1qem4h		1672675099846	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672675099846	t	t	f
kn6dnqf6qtni8ji4au64qwi6ec	esahgx8oc7y3pbm4f95doipzny		1672677813074	1	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672677813074	t	t	f
cxtmz3ubz3gfigd5m6prendmsw	bmq7jiumpib3xdz3mx5iyo99ro		1672676758744	1	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672676758744	t	f	f
755mk8nfaf8x8ce3o7sofmxafy	5bw66y36bff3umq1q57mfy4y5c		0	0	2	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672676961554	t	f	f
73uy6kj1jb8wdqrf3ti6zies6r	bmq7jiumpib3xdz3mx5iyo99ro		1672676749509	3	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672676749509	t	f	f
755mk8nfaf8x8ce3o7sofmxafy	bmq7jiumpib3xdz3mx5iyo99ro		1672676961543	2	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672676961543	t	f	f
cxtmz3ubz3gfigd5m6prendmsw	ujmedpkiu3rcxyaojr1k1qem4h		0	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672675302989	t	f	f
73uy6kj1jb8wdqrf3ti6zies6r	ujmedpkiu3rcxyaojr1k1qem4h		0	0	1	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672675303085	t	f	f
tg4mahhodbyadr4k4zbwtcz78r	esahgx8oc7y3pbm4f95doipzny		1672677412426	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672677412426	t	t	f
tg4mahhodbyadr4k4zbwtcz78r	ujmedpkiu3rcxyaojr1k1qem4h		0	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672677089890	t	f	f
kn6dnqf6qtni8ji4au64qwi6ec	ujmedpkiu3rcxyaojr1k1qem4h		0	0	1	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672677089990	t	f	f
cxtmz3ubz3gfigd5m6prendmsw	esahgx8oc7y3pbm4f95doipzny		1672681852643	7	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672681852643	t	f	f
73uy6kj1jb8wdqrf3ti6zies6r	esahgx8oc7y3pbm4f95doipzny		1672681331422	11	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672681331422	t	f	f
\.


--
-- Data for Name: channels; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.channels (id, createat, updateat, deleteat, teamid, type, displayname, name, header, purpose, lastpostat, totalmsgcount, extraupdateat, creatorid, schemeid, groupconstrained) FROM stdin;
5kh66ydh53gs7p3xrnpo1s4dyo	1672675099784	1672675099784	0	3p1ttzmgojbtuc56r5rzrwd1ur	O	Town Square	town-square			1672675099846	0	0		\N	\N
8hbx657ejpbizkubf9f9jjqdkc	1672675099801	1672675099801	0	3p1ttzmgojbtuc56r5rzrwd1ur	O	Off-Topic	off-topic			1672675099880	0	0		\N	\N
f4jhbgjjkff35n5qumfnsggzha	1672676736964	1672676736964	0		D		bmq7jiumpib3xdz3mx5iyo99ro__p584bbmabpghxqz4qdwj8pdhpr			1672676737036	1	0		\N	\N
tg4mahhodbyadr4k4zbwtcz78r	1672675188331	1672675188331	0	6yss1wi6zjyp3mdbe6aezn6ojw	O	Town Square	town-square			1672677412426	0	0		\N	\N
kn6dnqf6qtni8ji4au64qwi6ec	1672675188339	1672677813126	1672677813126	6yss1wi6zjyp3mdbe6aezn6ojw	O	Off-Topic	off-topic			1672677813074	1	0		\N	\N
73uy6kj1jb8wdqrf3ti6zies6r	1598351837717	1598351837717	0	tgrw7sjgbiy1jggs3qg3m6zpee	O	Off-Topic	off-topic			1672681331422	11	0		\N	\N
cxtmz3ubz3gfigd5m6prendmsw	1598351837713	1598351837713	0	tgrw7sjgbiy1jggs3qg3m6zpee	O	Town Square	town-square			1672681852643	7	0		\N	\N
\.


--
-- Data for Name: clusterdiscovery; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.clusterdiscovery (id, type, clustername, hostname, gossipport, port, createat, lastpingat) FROM stdin;
\.


--
-- Data for Name: commands; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.commands (id, token, createat, updateat, deleteat, creatorid, teamid, trigger, method, username, iconurl, autocomplete, autocompletedesc, autocompletehint, displayname, description, url) FROM stdin;
\.


--
-- Data for Name: commandwebhooks; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.commandwebhooks (id, createat, commandid, userid, channelid, rootid, parentid, usecount) FROM stdin;
\.


--
-- Data for Name: compliances; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.compliances (id, createat, userid, status, count, "desc", type, startat, endat, keywords, emails) FROM stdin;
\.


--
-- Data for Name: emoji; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.emoji (id, createat, updateat, deleteat, creatorid, name) FROM stdin;
\.


--
-- Data for Name: fileinfo; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.fileinfo (id, creatorid, postid, createat, updateat, deleteat, path, thumbnailpath, previewpath, name, extension, size, mimetype, width, height, haspreviewimage) FROM stdin;
5xhgttoh17y7zqcj45uzihq8no	esahgx8oc7y3pbm4f95doipzny	o9ftokai47yuxydmq8ockozxsc	1672681373612	1672681373612	0	20230102/teams/noteam/channels/cxtmz3ubz3gfigd5m6prendmsw/users/esahgx8oc7y3pbm4f95doipzny/5xhgttoh17y7zqcj45uzihq8no/README.md			README.md	md	2501		0	0	f
mx1wo1gmu7n9b8yh91kdyez83y	esahgx8oc7y3pbm4f95doipzny	w4ai4uu693b5jxhfb8at5nu9ry	1672681702985	1672681702985	0	20230102/teams/noteam/channels/cxtmz3ubz3gfigd5m6prendmsw/users/esahgx8oc7y3pbm4f95doipzny/mx1wo1gmu7n9b8yh91kdyez83y/docker-compose.yml			docker-compose.yml	yml	558		0	0	f
7916t3zr77fmxxgfefbyt7w7mo	esahgx8oc7y3pbm4f95doipzny	5um9oboqufnpx88699x1gf99cc	1672681756896	1672681756896	0	20230102/teams/noteam/channels/cxtmz3ubz3gfigd5m6prendmsw/users/esahgx8oc7y3pbm4f95doipzny/7916t3zr77fmxxgfefbyt7w7mo/Dockerfile			Dockerfile		159		0	0	f
k9qiswqmp7y1tyfmw4q1i1iamo	esahgx8oc7y3pbm4f95doipzny	kx3b3cihziyt9xyb1nwea1msoa	1672681843436	1672681843436	0	20230102/teams/noteam/channels/cxtmz3ubz3gfigd5m6prendmsw/users/esahgx8oc7y3pbm4f95doipzny/k9qiswqmp7y1tyfmw4q1i1iamo/nginx.conf			nginx.conf	conf	353		0	0	f
\.


--
-- Data for Name: groupchannels; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.groupchannels (groupid, autoadd, schemeadmin, createat, deleteat, updateat, channelid) FROM stdin;
\.


--
-- Data for Name: groupmembers; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.groupmembers (groupid, userid, createat, deleteat) FROM stdin;
\.


--
-- Data for Name: groupteams; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.groupteams (groupid, autoadd, schemeadmin, createat, deleteat, updateat, teamid) FROM stdin;
\.


--
-- Data for Name: incomingwebhooks; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.incomingwebhooks (id, createat, updateat, deleteat, userid, channelid, teamid, displayname, description, username, iconurl, channellocked) FROM stdin;
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.jobs (id, type, priority, createat, startat, lastactivityat, status, progress, data) FROM stdin;
fky8msypr7nhbko6jm1fydozow	migrations	0	1598351829123	1598351839894	1598351840103	success	0	{"last_done":"{\\"current_table\\":\\"ChannelMembers\\",\\"last_team_id\\":\\"00000000000000000000000000\\",\\"last_channel_id\\":\\"00000000000000000000000000\\",\\"last_user\\":\\"00000000000000000000000000\\"}","migration_key":"migration_advanced_permissions_phase_2"}
91a8s4b1cfntjn4rtpyp4933pc	expiry_notify	0	1672675200909	1672675207730	1672675207746	success	0	{}
wdu93mwarfrbdp8woz3smf8ucr	expiry_notify	0	1672675800530	1672675807571	1672675807578	success	0	{}
7jmwnygxujy97ctzf7nd6zc67y	expiry_notify	0	1672676400140	1672676407341	1672676407346	success	0	{}
hwdd9njzejgcbc4i7ox6y5egmr	expiry_notify	0	1672676999850	1672677007108	1672677007114	success	0	{}
btiem88mmiycxysppituq11rba	expiry_notify	0	1672677599461	1672677607030	1672677607052	success	0	{}
geifk4xb7ibg5piey91di7h3po	expiry_notify	0	1672678199130	1672678206863	1672678206870	success	0	{}
s5e4kxub5bdwxrgfc9r5pforgy	expiry_notify	0	1672681815671	1672681826042	1672681826049	success	0	{}
\.


--
-- Data for Name: licenses; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.licenses (id, createat, bytes) FROM stdin;
\.


--
-- Data for Name: linkmetadata; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.linkmetadata (hash, url, "timestamp", type, data) FROM stdin;
\.


--
-- Data for Name: oauthaccessdata; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.oauthaccessdata (clientid, userid, token, refreshtoken, redirecturi, expiresat, scope) FROM stdin;
\.


--
-- Data for Name: oauthapps; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.oauthapps (id, creatorid, createat, updateat, clientsecret, name, description, iconurl, callbackurls, homepage, istrusted) FROM stdin;
\.


--
-- Data for Name: oauthauthdata; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.oauthauthdata (clientid, userid, code, expiresin, createat, redirecturi, state, scope) FROM stdin;
\.


--
-- Data for Name: outgoingwebhooks; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.outgoingwebhooks (id, token, createat, updateat, deleteat, creatorid, channelid, teamid, triggerwords, triggerwhen, callbackurls, displayname, description, contenttype, username, iconurl) FROM stdin;
\.


--
-- Data for Name: pluginkeyvaluestore; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.pluginkeyvaluestore (pluginid, pkey, pvalue, expireat) FROM stdin;
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.posts (id, createat, updateat, editat, deleteat, ispinned, userid, channelid, rootid, parentid, originalid, message, type, props, hashtags, filenames, fileids, hasreactions) FROM stdin;
yf7fmxmi4ffg5mgfpdgpx6agba	1672674602103	1672674602103	0	0	f	p584bbmabpghxqz4qdwj8pdhpr	cxtmz3ubz3gfigd5m6prendmsw				matrix_matrix_a joined the team.	system_join_team	{"username":"matrix_matrix_a"}		[]	[]	f
dgqzt7t1hbbnijtae7rhzbohwe	1672674602161	1672674602161	0	0	f	p584bbmabpghxqz4qdwj8pdhpr	73uy6kj1jb8wdqrf3ti6zies6r				matrix_matrix_a joined the channel.	system_join_channel	{"username":"matrix_matrix_a"}		[]	[]	f
npmo8iu8m3rtfpgjgbf8ntbzcc	1672674602634	1672674602634	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	73uy6kj1jb8wdqrf3ti6zies6r				matrix_matrix_b added to the channel by admin.	system_add_to_channel	{"addedUserId":"6afiyfegctd1zxwen4aq4ywpyr","addedUsername":"matrix_matrix_b","userId":"bmq7jiumpib3xdz3mx5iyo99ro","username":"admin"}		[]	[]	f
3tpjrqfrwpns78qsqrj379yu7c	1672674602660	1672674602660	0	0	f	6afiyfegctd1zxwen4aq4ywpyr	cxtmz3ubz3gfigd5m6prendmsw				matrix_matrix_b joined the team.	system_join_team	{"username":"matrix_matrix_b"}		[]	[]	f
ndoqku9m4ffm7ybgxjuigodgtw	1672674602710	1672674602710	0	0	f	6afiyfegctd1zxwen4aq4ywpyr	73uy6kj1jb8wdqrf3ti6zies6r				matrix_matrix_b joined the channel.	system_join_channel	{"username":"matrix_matrix_b"}		[]	[]	f
miczbjnbqirdjm4is1fsjcjqbo	1672675099846	1672675099846	0	0	f	ujmedpkiu3rcxyaojr1k1qem4h	5kh66ydh53gs7p3xrnpo1s4dyo				bridgeuser1 joined the team.	system_join_team	{"username":"bridgeuser1"}		[]	[]	f
c6jo4456p7fu9k1y3jwwfdth6a	1672675099880	1672675099880	0	0	f	ujmedpkiu3rcxyaojr1k1qem4h	8hbx657ejpbizkubf9f9jjqdkc				bridgeuser1 joined the channel.	system_join_channel	{"username":"bridgeuser1"}		[]	[]	f
qfw5ge58st8imeq5xxwfecf7gh	1672675188380	1672675188380	0	0	f	esahgx8oc7y3pbm4f95doipzny	tg4mahhodbyadr4k4zbwtcz78r				bridgeuser2 joined the team.	system_join_team	{"username":"bridgeuser2"}		[]	[]	f
y9pan7agrprymyb6ogj66gjpmc	1672675188409	1672675188409	0	0	f	esahgx8oc7y3pbm4f95doipzny	kn6dnqf6qtni8ji4au64qwi6ec				bridgeuser2 joined the channel.	system_join_channel	{"username":"bridgeuser2"}		[]	[]	f
c8szpsi56jyktn67igc6bkxyoa	1672675303000	1672675303000	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	cxtmz3ubz3gfigd5m6prendmsw				bridgeuser1 added to the team by admin.	system_add_to_team	{"addedUserId":"ujmedpkiu3rcxyaojr1k1qem4h","addedUsername":"bridgeuser1","userId":"bmq7jiumpib3xdz3mx5iyo99ro","username":"admin"}		[]	[]	f
ocyzhc31zidr5j44x1kb4ka7yo	1672675303035	1672675303035	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	73uy6kj1jb8wdqrf3ti6zies6r				bridgeuser1 added to the channel by admin.	system_add_to_channel	{"addedUserId":"ujmedpkiu3rcxyaojr1k1qem4h","addedUsername":"bridgeuser1","userId":"bmq7jiumpib3xdz3mx5iyo99ro","username":"admin"}		[]	[]	f
6nekrypjmfbdixmiq3rzso8yto	1672675303326	1672675303326	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	cxtmz3ubz3gfigd5m6prendmsw				bridgeuser2 added to the team by admin.	system_add_to_team	{"addedUserId":"esahgx8oc7y3pbm4f95doipzny","addedUsername":"bridgeuser2","userId":"bmq7jiumpib3xdz3mx5iyo99ro","username":"admin"}		[]	[]	f
mkxrwzr63jr7bgpg99mhrgnowc	1672675303412	1672675303412	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	73uy6kj1jb8wdqrf3ti6zies6r				bridgeuser2 added to the channel by admin.	system_add_to_channel	{"addedUserId":"esahgx8oc7y3pbm4f95doipzny","addedUsername":"bridgeuser2","userId":"bmq7jiumpib3xdz3mx5iyo99ro","username":"admin"}		[]	[]	f
eucq6c4pxibptm1ddh94ektdwe	1672675413968	1672675413968	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	73uy6kj1jb8wdqrf3ti6zies6r				** First Message*		{"disable_group_highlight":true}		[]	[]	f
co9ueexx6pgntdaffhatk4p6aa	1672676493796	1672676493796	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	73uy6kj1jb8wdqrf3ti6zies6r				OK		{"disable_group_highlight":true}		[]	[]	f
rjahqzf7ib8yzx7tirrws1wawh	1672676737036	1672676737036	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	f4jhbgjjkff35n5qumfnsggzha				This is a bot. You will not get a reply		{}		[]	[]	f
qignr7thu7namytrwef5sr59gy	1672676749509	1672676749509	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	73uy6kj1jb8wdqrf3ti6zies6r				ok		{"disable_group_highlight":true}		[]	[]	f
oc4feem9w3dhmebkxy6kiwycdy	1672676758744	1672676758744	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	cxtmz3ubz3gfigd5m6prendmsw				ok		{"disable_group_highlight":true}		[]	[]	f
a5t8t9sawingbnj9g8dj14kb4e	1672676955537	1672676955537	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	755mk8nfaf8x8ce3o7sofmxafy				This is a bot. You will not get a reply		{}		[]	[]	f
58guga9nsj8sud8nx8ga4if1qh	1672676961543	1672676961543	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	755mk8nfaf8x8ce3o7sofmxafy				ok		{"disable_group_highlight":true}		[]	[]	f
g8g93m9mwpdc3gu7idryeqje9y	1672677047326	1672677047326	0	0	f	esahgx8oc7y3pbm4f95doipzny	tg4mahhodbyadr4k4zbwtcz78r				matrix_matrix_a added to the team by bridgeuser2.	system_add_to_team	{"addedUserId":"p584bbmabpghxqz4qdwj8pdhpr","addedUsername":"matrix_matrix_a","userId":"esahgx8oc7y3pbm4f95doipzny","username":"bridgeuser2"}		[]	[]	f
4cci5s86ojrx3jr19tn8484dqo	1672677047359	1672677047359	0	0	f	esahgx8oc7y3pbm4f95doipzny	kn6dnqf6qtni8ji4au64qwi6ec				matrix_matrix_a added to the channel by bridgeuser2.	system_add_to_channel	{"addedUserId":"p584bbmabpghxqz4qdwj8pdhpr","addedUsername":"matrix_matrix_a","userId":"esahgx8oc7y3pbm4f95doipzny","username":"bridgeuser2"}		[]	[]	f
3nq9csfe63nh9coq4zuycs6fso	1672677059883	1672677059883	0	0	f	esahgx8oc7y3pbm4f95doipzny	tg4mahhodbyadr4k4zbwtcz78r				matrix_matrix_b added to the team by bridgeuser2.	system_add_to_team	{"addedUserId":"6afiyfegctd1zxwen4aq4ywpyr","addedUsername":"matrix_matrix_b","userId":"esahgx8oc7y3pbm4f95doipzny","username":"bridgeuser2"}		[]	[]	f
6146bszpapnszp48zwgdize7zy	1672677059913	1672677059913	0	0	f	esahgx8oc7y3pbm4f95doipzny	kn6dnqf6qtni8ji4au64qwi6ec				matrix_matrix_b added to the channel by bridgeuser2.	system_add_to_channel	{"addedUserId":"6afiyfegctd1zxwen4aq4ywpyr","addedUsername":"matrix_matrix_b","userId":"esahgx8oc7y3pbm4f95doipzny","username":"bridgeuser2"}		[]	[]	f
odzidux6winndpo15th3hgz56a	1672677078570	1672677078570	0	0	f	esahgx8oc7y3pbm4f95doipzny	tg4mahhodbyadr4k4zbwtcz78r				admin added to the team by bridgeuser2.	system_add_to_team	{"addedUserId":"bmq7jiumpib3xdz3mx5iyo99ro","addedUsername":"admin","userId":"esahgx8oc7y3pbm4f95doipzny","username":"bridgeuser2"}		[]	[]	f
bmarxmjd7f8yixqz7sfzmwbzga	1672677078602	1672677078602	0	0	f	esahgx8oc7y3pbm4f95doipzny	kn6dnqf6qtni8ji4au64qwi6ec				admin added to the channel by bridgeuser2.	system_add_to_channel	{"addedUserId":"bmq7jiumpib3xdz3mx5iyo99ro","addedUsername":"admin","userId":"esahgx8oc7y3pbm4f95doipzny","username":"bridgeuser2"}		[]	[]	f
7uorae8njiddfba8475mcd3o8y	1672677089900	1672677089900	0	0	f	esahgx8oc7y3pbm4f95doipzny	tg4mahhodbyadr4k4zbwtcz78r				bridgeuser1 added to the team by bridgeuser2.	system_add_to_team	{"addedUserId":"ujmedpkiu3rcxyaojr1k1qem4h","addedUsername":"bridgeuser1","userId":"esahgx8oc7y3pbm4f95doipzny","username":"bridgeuser2"}		[]	[]	f
yhg47wj7tjbkfjsoe3atdw4e6h	1672677124063	1672677124063	0	0	f	6afiyfegctd1zxwen4aq4ywpyr	tg4mahhodbyadr4k4zbwtcz78r				matrix_matrix_b left the team.	system_leave_team	{"username":"matrix_matrix_b"}		[]	[]	f
364d19syzprw7m66c5sjotud4e	1672677089943	1672677089943	0	0	f	esahgx8oc7y3pbm4f95doipzny	kn6dnqf6qtni8ji4au64qwi6ec				bridgeuser1 added to the channel by bridgeuser2.	system_add_to_channel	{"addedUserId":"ujmedpkiu3rcxyaojr1k1qem4h","addedUsername":"bridgeuser1","userId":"esahgx8oc7y3pbm4f95doipzny","username":"bridgeuser2"}		[]	[]	f
8f8ofanfi7bg584dyf7xcy6k3a	1672677856040	1672677856040	0	0	f	esahgx8oc7y3pbm4f95doipzny	cxtmz3ubz3gfigd5m6prendmsw				okokok		{"disable_group_highlight":true}		[]	[]	f
38xjyprqjigi7kkqqqzpmatwzc	1672677124079	1672677124079	0	0	f	p584bbmabpghxqz4qdwj8pdhpr	tg4mahhodbyadr4k4zbwtcz78r				matrix_matrix_a left the team.	system_leave_team	{"username":"matrix_matrix_a"}		[]	[]	f
ogewadu5sib35em7nk3fhg3txr	1672677919289	1672677919289	0	0	f	esahgx8oc7y3pbm4f95doipzny	73uy6kj1jb8wdqrf3ti6zies6r				Hi again		{"disable_group_highlight":true}		[]	[]	f
53akznn7x3dmuxci4x13768dih	1672677412426	1672677412426	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	tg4mahhodbyadr4k4zbwtcz78r				admin left the team.	system_leave_team	{"username":"admin"}		[]	[]	f
68m83y8ej3f9p8ej7479n7mjjo	1672677813074	1672677813074	0	0	f	esahgx8oc7y3pbm4f95doipzny	kn6dnqf6qtni8ji4au64qwi6ec				bridgeuser2 archived the channel.	system_channel_deleted	{"username":"bridgeuser2"}		[]	[]	f
zftzdzdijbnexnh8e9ujm8ioor	1672678277782	1672678277782	0	0	f	esahgx8oc7y3pbm4f95doipzny	73uy6kj1jb8wdqrf3ti6zies6r				hi		{"disable_group_highlight":true}		[]	[]	f
xkpspndmxjddukhczankqoakow	1672678307321	1672678307321	0	0	f	esahgx8oc7y3pbm4f95doipzny	73uy6kj1jb8wdqrf3ti6zies6r				fine		{"disable_group_highlight":true}		[]	[]	f
o9qmfjf34tnyxdji3o81gzptjw	1672678409045	1672678409045	0	0	f	esahgx8oc7y3pbm4f95doipzny	73uy6kj1jb8wdqrf3ti6zies6r				ok ok		{"disable_group_highlight":true}		[]	[]	f
joxxq4ps3jdh7kzj4p97ztqauo	1672681261757	1672681261757	0	0	f	esahgx8oc7y3pbm4f95doipzny	73uy6kj1jb8wdqrf3ti6zies6r				ok		{"disable_group_highlight":true}		[]	[]	f
gsq775ai8t8k9cozpj1i7hpdgw	1672681270341	1672681270341	0	0	f	esahgx8oc7y3pbm4f95doipzny	73uy6kj1jb8wdqrf3ti6zies6r				ok		{"disable_group_highlight":true}		[]	[]	f
pkpomsmeejghxm4zai4hfymw8o	1672681275662	1672681275662	0	0	f	esahgx8oc7y3pbm4f95doipzny	73uy6kj1jb8wdqrf3ti6zies6r				pl		{"disable_group_highlight":true}		[]	[]	f
cw3shuzizpbrfpei9twkimpr9h	1672681331422	1672681331422	0	0	f	esahgx8oc7y3pbm4f95doipzny	73uy6kj1jb8wdqrf3ti6zies6r				** klklklkl **		{"disable_group_highlight":true}		[]	[]	f
141cf3e9cp8mzp1gcojoiq83do	1672681359970	1672681359970	0	0	f	esahgx8oc7y3pbm4f95doipzny	cxtmz3ubz3gfigd5m6prendmsw				klklklk		{"disable_group_highlight":true}		[]	[]	f
o9ftokai47yuxydmq8ockozxsc	1672681380078	1672681380078	0	0	f	esahgx8oc7y3pbm4f95doipzny	cxtmz3ubz3gfigd5m6prendmsw				Data		{"disable_group_highlight":true}		[]	["5xhgttoh17y7zqcj45uzihq8no"]	f
w4ai4uu693b5jxhfb8at5nu9ry	1672681715518	1672681715518	0	0	f	esahgx8oc7y3pbm4f95doipzny	cxtmz3ubz3gfigd5m6prendmsw				klk		{"disable_group_highlight":true}		[]	["mx1wo1gmu7n9b8yh91kdyez83y"]	f
5um9oboqufnpx88699x1gf99cc	1672681778635	1672681778635	0	0	f	esahgx8oc7y3pbm4f95doipzny	cxtmz3ubz3gfigd5m6prendmsw				klk		{"disable_group_highlight":true}		[]	["7916t3zr77fmxxgfefbyt7w7mo"]	f
kx3b3cihziyt9xyb1nwea1msoa	1672681852643	1672681852643	0	0	f	esahgx8oc7y3pbm4f95doipzny	cxtmz3ubz3gfigd5m6prendmsw				conf		{"disable_group_highlight":true}		[]	["k9qiswqmp7y1tyfmw4q1i1iamo"]	f
\.


--
-- Data for Name: preferences; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.preferences (userid, category, name, value) FROM stdin;
5bw66y36bff3umq1q57mfy4y5c	tutorial_step	5bw66y36bff3umq1q57mfy4y5c	0
0z4okgmv5lfhx3p0tf6pnpk8sk	tutorial_step	0z4okgmv5lfhx3p0tf6pnpk8sk	0
3zats68fztgu9mgu944a4t35so	tutorial_step	3zats68fztgu9mgu944a4t35so	0
p584bbmabpghxqz4qdwj8pdhpr	tutorial_step	p584bbmabpghxqz4qdwj8pdhpr	0
6afiyfegctd1zxwen4aq4ywpyr	tutorial_step	6afiyfegctd1zxwen4aq4ywpyr	0
bmq7jiumpib3xdz3mx5iyo99ro	tutorial_step	bmq7jiumpib3xdz3mx5iyo99ro	999
bmq7jiumpib3xdz3mx5iyo99ro	favorite_channel	73uy6kj1jb8wdqrf3ti6zies6r	true
ujmedpkiu3rcxyaojr1k1qem4h	tutorial_step	ujmedpkiu3rcxyaojr1k1qem4h	999
esahgx8oc7y3pbm4f95doipzny	tutorial_step	esahgx8oc7y3pbm4f95doipzny	999
bmq7jiumpib3xdz3mx5iyo99ro	favorite_channel	cxtmz3ubz3gfigd5m6prendmsw	true
bmq7jiumpib3xdz3mx5iyo99ro	channel_approximate_view_time		1672675420341
bmq7jiumpib3xdz3mx5iyo99ro	direct_channel_show	p584bbmabpghxqz4qdwj8pdhpr	true
bmq7jiumpib3xdz3mx5iyo99ro	channel_open_time	f4jhbgjjkff35n5qumfnsggzha	1672676941030
bmq7jiumpib3xdz3mx5iyo99ro	direct_channel_show	5bw66y36bff3umq1q57mfy4y5c	true
bmq7jiumpib3xdz3mx5iyo99ro	channel_open_time	755mk8nfaf8x8ce3o7sofmxafy	1672676955943
esahgx8oc7y3pbm4f95doipzny	channel_approximate_view_time	kn6dnqf6qtni8ji4au64qwi6ec	1672677000684
esahgx8oc7y3pbm4f95doipzny	channel_approximate_view_time	73uy6kj1jb8wdqrf3ti6zies6r	1672677008317
esahgx8oc7y3pbm4f95doipzny	channel_approximate_view_time		1672677101123
esahgx8oc7y3pbm4f95doipzny	channel_approximate_view_time	tg4mahhodbyadr4k4zbwtcz78r	1672677840546
\.


--
-- Data for Name: publicchannels; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.publicchannels (id, deleteat, teamid, displayname, name, header, purpose) FROM stdin;
cxtmz3ubz3gfigd5m6prendmsw	0	tgrw7sjgbiy1jggs3qg3m6zpee	Town Square	town-square		
73uy6kj1jb8wdqrf3ti6zies6r	0	tgrw7sjgbiy1jggs3qg3m6zpee	Off-Topic	off-topic		
5kh66ydh53gs7p3xrnpo1s4dyo	0	3p1ttzmgojbtuc56r5rzrwd1ur	Town Square	town-square		
8hbx657ejpbizkubf9f9jjqdkc	0	3p1ttzmgojbtuc56r5rzrwd1ur	Off-Topic	off-topic		
tg4mahhodbyadr4k4zbwtcz78r	0	6yss1wi6zjyp3mdbe6aezn6ojw	Town Square	town-square		
kn6dnqf6qtni8ji4au64qwi6ec	1672677813126	6yss1wi6zjyp3mdbe6aezn6ojw	Off-Topic	off-topic		
\.


--
-- Data for Name: reactions; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.reactions (userid, postid, emojiname, createat) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.roles (id, name, displayname, description, createat, updateat, deleteat, permissions, schememanaged, builtin) FROM stdin;
cqedmkhfmtfhidp18w8pkogtpa	team_post_all	authentication.roles.team_post_all.name	authentication.roles.team_post_all.description	1598351767777	1598351767984	0	 use_channel_mentions create_post use_group_mentions	f	t
jdfscmmwq7yc9pb3j8egpkrhgo	team_admin	authentication.roles.team_admin.name	authentication.roles.team_admin.description	1598351767783	1598351767985	0	 delete_post manage_private_channel_members create_post manage_channel_roles manage_outgoing_webhooks manage_others_outgoing_webhooks use_channel_mentions manage_team_roles delete_others_posts manage_slash_commands use_group_mentions remove_user_from_team add_reaction manage_others_slash_commands manage_others_incoming_webhooks remove_reaction import_team manage_public_channel_members manage_incoming_webhooks manage_team	t	t
qj5hbu454fn63njq69nni3drxh	system_post_all	authentication.roles.system_post_all.name	authentication.roles.system_post_all.description	1598351767778	1598351767986	0	 create_post use_channel_mentions use_group_mentions	f	t
abmhgi8pa3robkzd7kfzongfmc	system_guest	authentication.roles.global_guest.name	authentication.roles.global_guest.description	1598351767761	1598351767987	0	 create_direct_channel create_group_channel	t	t
3sojxu7t47r95cfjs94yywyd9c	system_post_all_public	authentication.roles.system_post_all_public.name	authentication.roles.system_post_all_public.description	1598351767764	1598351767988	0	 create_post_public use_channel_mentions use_group_mentions	f	t
xqc3eckiafg5i86jthcwbazdpy	team_user	authentication.roles.team_user.name	authentication.roles.team_user.description	1598351767784	1598351767979	0	 create_private_channel invite_user add_user_to_team list_team_channels join_public_channels read_public_channel view_team create_public_channel	t	t
go6yxappktb93quowz9j6mkjra	team_post_all_public	authentication.roles.team_post_all_public.name	authentication.roles.team_post_all_public.description	1598351767786	1598351767981	0	 create_post_public use_group_mentions use_channel_mentions	f	t
getwmro16pd7jrn1oqrkmn1wsw	system_user	authentication.roles.global_user.name	authentication.roles.global_user.description	1598351767781	1598351767981	0	 create_emojis delete_emojis list_public_teams join_public_teams create_direct_channel create_group_channel view_members create_team	t	t
ghsp7z49qbbi5bhuoqaqqs6ake	channel_admin	authentication.roles.channel_admin.name	authentication.roles.channel_admin.description	1598351767766	1598351767982	0	 manage_private_channel_members use_channel_mentions manage_channel_roles use_group_mentions create_post add_reaction remove_reaction manage_public_channel_members	t	t
t6x4ph1uojb398ciuhkgqzexfw	channel_user	authentication.roles.channel_user.name	authentication.roles.channel_user.description	1598351767775	1598351767983	0	 use_channel_mentions add_reaction manage_private_channel_properties manage_private_channel_members manage_public_channel_members manage_public_channel_properties edit_post delete_private_channel use_group_mentions create_post read_channel delete_public_channel remove_reaction upload_file use_slash_commands get_public_link delete_post	t	t
gygr3fd64p8izpynu6uef8jq3r	channel_guest	authentication.roles.channel_guest.name	authentication.roles.channel_guest.description	1598351767780	1598351767988	0	 remove_reaction upload_file edit_post create_post use_channel_mentions use_slash_commands read_channel add_reaction	t	t
jgrdf15eifyu5gsrum87u8ka5y	team_guest	authentication.roles.team_guest.name	authentication.roles.team_guest.description	1598351767768	1598351767989	0	 view_team	t	t
sw8erru9jjyzfegokosh9sb15h	system_user_access_token	authentication.roles.system_user_access_token.name	authentication.roles.system_user_access_token.description	1598351767769	1598351767990	0	 create_user_access_token read_user_access_token revoke_user_access_token	f	t
nypn4aniofbf9eu4efqkb1n56y	system_admin	authentication.roles.global_admin.name	authentication.roles.global_admin.description	1598351767771	1598351767991	0	 manage_channel_roles read_public_channel read_user_access_token invite_guest manage_oauth add_reaction manage_bots manage_slash_commands assign_system_admin_role create_post list_users_without_team list_private_teams invite_user delete_post create_emojis add_user_to_team manage_public_channel_members manage_outgoing_webhooks manage_others_slash_commands list_team_channels remove_reaction delete_public_channel read_channel remove_others_reactions delete_emojis remove_user_from_team create_private_channel manage_others_incoming_webhooks create_team edit_post manage_private_channel_members manage_jobs delete_others_posts manage_team_roles create_bot manage_private_channel_properties read_others_bots manage_system_wide_oauth create_public_channel join_public_channels use_slash_commands view_team join_private_teams edit_others_posts manage_others_bots create_post_public read_bots edit_other_users manage_system delete_others_emojis use_group_mentions create_user_access_token manage_public_channel_properties manage_roles promote_guest use_channel_mentions revoke_user_access_token manage_team manage_others_outgoing_webhooks manage_incoming_webhooks get_public_link import_team upload_file view_members delete_private_channel create_post_ephemeral demote_to_guest	t	t
\.


--
-- Data for Name: schemes; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.schemes (id, name, displayname, description, createat, updateat, deleteat, scope, defaultteamadminrole, defaultteamuserrole, defaultchanneladminrole, defaultchanneluserrole, defaultteamguestrole, defaultchannelguestrole) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.sessions (id, token, createat, expiresat, lastactivityat, userid, deviceid, roles, isoauth, expirednotify, props) FROM stdin;
b8te97x8ajfydd53r7xydcuxic	zkedx4zsd7yqt84nh4h68mgxfr	1672677123979	4826277123979	1672677123979	p584bbmabpghxqz4qdwj8pdhpr		system_user	f	f	{"is_guest":"false","type":"UserAccessToken","user_access_token_id":"ob3junttstrfzfffkxg5cuwrth"}
ywaxnuk5s7dd883wm1aziwhego	zkedx4zsd7yqt84nh4h68mgxfr	1672677123978	4826277123978	1672677123978	p584bbmabpghxqz4qdwj8pdhpr		system_user	f	f	{"is_guest":"false","type":"UserAccessToken","user_access_token_id":"ob3junttstrfzfffkxg5cuwrth"}
wiibqq7kn7g18gqkcbyqudyske	f8ffk5uwobdpfmqjtk1gkr598a	1672677124029	4826277124029	1672677124029	6afiyfegctd1zxwen4aq4ywpyr		system_user	f	f	{"is_guest":"false","type":"UserAccessToken","user_access_token_id":"mbd3efwr6bfsddqr1j3ty7ka7a"}
hgh71ukabjyzzd1zdbq391peda	s537n3t8zib1tx7eyd44qzqnbr	1672674601166	4826274601166	1672677520926	bmq7jiumpib3xdz3mx5iyo99ro		system_admin system_user	f	f	{"is_guest":"false","type":"UserAccessToken","user_access_token_id":"98yjyceocfb5mc3jaibtbmr1ph"}
dbt34xi34f8ipbrjfmj5a5xz5w	a9czrqjzupfyzyufuwhfxng9jy	1672677759503	1675269759503	1672678553750	esahgx8oc7y3pbm4f95doipzny		system_user	f	f	{"browser":"Chrome/108.0","csrf":"rhzjf1ydkinfxeh1izuxkbnaxr","isMobile":"false","isOAuthUser":"false","isSaml":"false","is_guest":"false","os":"Mac OS","platform":"Macintosh"}
yor9kdb16brq9guam3z6wuzxsa	s537n3t8zib1tx7eyd44qzqnbr	1672674601178	4826274601178	1672681242059	bmq7jiumpib3xdz3mx5iyo99ro		system_admin system_user	f	f	{"is_guest":"false","type":"UserAccessToken","user_access_token_id":"98yjyceocfb5mc3jaibtbmr1ph"}
\.


--
-- Data for Name: sidebarcategories; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.sidebarcategories (id, userid, teamid, sortorder, sorting, type, displayname) FROM stdin;
rkreyitogig6uj71uma8yzrrke	p584bbmabpghxqz4qdwj8pdhpr	tgrw7sjgbiy1jggs3qg3m6zpee	0		favorites	Favorites
e34j7ygi9tfmxfjkybnicgoosw	p584bbmabpghxqz4qdwj8pdhpr	tgrw7sjgbiy1jggs3qg3m6zpee	10		channels	Channels
snof4xpq5tdbiy4buxw635985r	p584bbmabpghxqz4qdwj8pdhpr	tgrw7sjgbiy1jggs3qg3m6zpee	20	recent	direct_messages	Direct Messages
r8d5y88yjtr1bjifbqxnqdom7e	6afiyfegctd1zxwen4aq4ywpyr	tgrw7sjgbiy1jggs3qg3m6zpee	0		favorites	Favorites
mctjzf51ijy4uew4qkxw1apjty	6afiyfegctd1zxwen4aq4ywpyr	tgrw7sjgbiy1jggs3qg3m6zpee	10		channels	Channels
6ari9rzs67rxxq9hd7n169sm3a	6afiyfegctd1zxwen4aq4ywpyr	tgrw7sjgbiy1jggs3qg3m6zpee	20	recent	direct_messages	Direct Messages
k6t3i86debgxddmedrzqxuegyo	ujmedpkiu3rcxyaojr1k1qem4h	3p1ttzmgojbtuc56r5rzrwd1ur	0		favorites	Favorites
cxqfinwf3pg8fjjswmkp6oz85c	ujmedpkiu3rcxyaojr1k1qem4h	3p1ttzmgojbtuc56r5rzrwd1ur	10		channels	Channels
jwbog5b7fffwzqyj6a3gxbw9je	ujmedpkiu3rcxyaojr1k1qem4h	3p1ttzmgojbtuc56r5rzrwd1ur	20	recent	direct_messages	Direct Messages
yrgon4wy9jb6jqoqtt7fs6a4ro	esahgx8oc7y3pbm4f95doipzny	6yss1wi6zjyp3mdbe6aezn6ojw	0		favorites	Favorites
wxsr39zjnb8aumozot6t3up7dy	esahgx8oc7y3pbm4f95doipzny	6yss1wi6zjyp3mdbe6aezn6ojw	10		channels	Channels
iow45xf79t88zpxybgt69r394h	esahgx8oc7y3pbm4f95doipzny	6yss1wi6zjyp3mdbe6aezn6ojw	20	recent	direct_messages	Direct Messages
kpprf5xfxjynbbcrrdrpemwimo	ujmedpkiu3rcxyaojr1k1qem4h	tgrw7sjgbiy1jggs3qg3m6zpee	0		favorites	Favorites
b987schmz3gyxkcroao5qaz4nr	ujmedpkiu3rcxyaojr1k1qem4h	tgrw7sjgbiy1jggs3qg3m6zpee	10		channels	Channels
rjxstazzojrfdpj56n3yoqji9h	ujmedpkiu3rcxyaojr1k1qem4h	tgrw7sjgbiy1jggs3qg3m6zpee	20	recent	direct_messages	Direct Messages
joxbn13bwtnjfqr81u1ouqsc1o	esahgx8oc7y3pbm4f95doipzny	tgrw7sjgbiy1jggs3qg3m6zpee	0		favorites	Favorites
qs88xadjftd99x1d5rm1k8qx8c	esahgx8oc7y3pbm4f95doipzny	tgrw7sjgbiy1jggs3qg3m6zpee	10		channels	Channels
uuazqzdx7tbexdw3nsefs9sfuo	esahgx8oc7y3pbm4f95doipzny	tgrw7sjgbiy1jggs3qg3m6zpee	20	recent	direct_messages	Direct Messages
tdbzs3f94jnypehop1jm9h69rh	ujmedpkiu3rcxyaojr1k1qem4h	6yss1wi6zjyp3mdbe6aezn6ojw	0		favorites	Favorites
cwdroobi8iy47qages14z9e3na	ujmedpkiu3rcxyaojr1k1qem4h	6yss1wi6zjyp3mdbe6aezn6ojw	10		channels	Channels
csojpaj3u7bhue59udqhbiiwrc	ujmedpkiu3rcxyaojr1k1qem4h	6yss1wi6zjyp3mdbe6aezn6ojw	20	recent	direct_messages	Direct Messages
\.


--
-- Data for Name: sidebarchannels; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.sidebarchannels (channelid, userid, categoryid, sortorder) FROM stdin;
\.


--
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.status (userid, status, manual, lastactivityat) FROM stdin;
ujmedpkiu3rcxyaojr1k1qem4h	offline	f	1672675151330
bmq7jiumpib3xdz3mx5iyo99ro	away	f	1672681242052
esahgx8oc7y3pbm4f95doipzny	offline	f	1672682034104
\.


--
-- Data for Name: systems; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.systems (name, value) FROM stdin;
Version	5.26.0
AsymmetricSigningKey	{"ecdsa_key":{"curve":"P-256","x":44744317388117417793846363992112375138072215766669538838312050574980773534963,"y":106405437094541760691235144597932623735695328716199872932991841706298639959202,"d":514093591070089100882487378727490579260295328943479296300452065637146698099}}
PostActionCookieSecret	{"key":"8cXKorYdh+LUSyAJcMpXp26vIV/vu8B5vq2noKPLGi4="}
InstallationDate	1598351748409
FirstServerRunTimestamp	1598351748411
DiagnosticId	igz85apxkfn5xcd1ioi8dmbnsa
AdvancedPermissionsMigrationComplete	true
EmojisPermissionsMigrationComplete	true
GuestRolesCreationMigrationComplete	true
emoji_permissions_split	true
webhook_permissions_split	true
list_join_public_private_teams	true
remove_permanent_delete_user	true
add_bot_permissions	true
apply_channel_manage_delete_to_channel_user	true
remove_channel_manage_delete_from_team_user	true
view_members_new_permission	true
add_manage_guests_permissions	true
channel_moderations_permissions	true
add_use_group_mentions_permission	true
migration_advanced_permissions_phase_2	true
LastSecurityTime	1672674600893
\.


--
-- Data for Name: teammembers; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.teammembers (teamid, userid, roles, deleteat, schemeuser, schemeadmin, schemeguest) FROM stdin;
tgrw7sjgbiy1jggs3qg3m6zpee	bmq7jiumpib3xdz3mx5iyo99ro		0	t	t	f
tgrw7sjgbiy1jggs3qg3m6zpee	5bw66y36bff3umq1q57mfy4y5c		0	t	f	f
tgrw7sjgbiy1jggs3qg3m6zpee	0z4okgmv5lfhx3p0tf6pnpk8sk		0	t	f	f
tgrw7sjgbiy1jggs3qg3m6zpee	3zats68fztgu9mgu944a4t35so		0	t	f	f
tgrw7sjgbiy1jggs3qg3m6zpee	p584bbmabpghxqz4qdwj8pdhpr		0	t	f	f
tgrw7sjgbiy1jggs3qg3m6zpee	6afiyfegctd1zxwen4aq4ywpyr		0	t	f	f
3p1ttzmgojbtuc56r5rzrwd1ur	ujmedpkiu3rcxyaojr1k1qem4h		0	t	t	f
6yss1wi6zjyp3mdbe6aezn6ojw	esahgx8oc7y3pbm4f95doipzny		0	t	t	f
tgrw7sjgbiy1jggs3qg3m6zpee	ujmedpkiu3rcxyaojr1k1qem4h		0	t	f	f
tgrw7sjgbiy1jggs3qg3m6zpee	esahgx8oc7y3pbm4f95doipzny		0	t	f	f
6yss1wi6zjyp3mdbe6aezn6ojw	ujmedpkiu3rcxyaojr1k1qem4h		0	t	f	f
6yss1wi6zjyp3mdbe6aezn6ojw	6afiyfegctd1zxwen4aq4ywpyr		1672677124100	t	f	f
6yss1wi6zjyp3mdbe6aezn6ojw	p584bbmabpghxqz4qdwj8pdhpr		1672677124144	t	f	f
6yss1wi6zjyp3mdbe6aezn6ojw	bmq7jiumpib3xdz3mx5iyo99ro		1672677412447	t	f	f
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.teams (id, createat, updateat, deleteat, displayname, name, description, email, type, companyname, alloweddomains, inviteid, allowopeninvite, lastteamiconupdate, schemeid, groupconstrained) FROM stdin;
3p1ttzmgojbtuc56r5rzrwd1ur	1672675099778	1672675099778	0	Private	private		bridgeuser1@localhost	O			t3jq1izzo3yh3gz5pwd5nmudfw	f	0	\N	\N
6yss1wi6zjyp3mdbe6aezn6ojw	1672675188327	1672675188327	0	private	private2		bridgeuser2@localhost	O			7ohiyojirj8fme1ig3dnkr9aoh	f	0	\N	\N
tgrw7sjgbiy1jggs3qg3m6zpee	1598351837711	1672676698249	0	Test Team	test			O			5tdc6sxr43byufri3r6px9f9xo	t	0	\N	\N
\.


--
-- Data for Name: termsofservice; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.termsofservice (id, createat, userid, text) FROM stdin;
\.


--
-- Data for Name: tokens; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.tokens (token, createat, type, extra) FROM stdin;
\.


--
-- Data for Name: useraccesstokens; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.useraccesstokens (id, token, userid, description, isactive) FROM stdin;
98yjyceocfb5mc3jaibtbmr1ph	s537n3t8zib1tx7eyd44qzqnbr	bmq7jiumpib3xdz3mx5iyo99ro	test-token	t
ya4wtr9fjiyxfptgnjmjgcc3wh	aqhn1jc1nbgjtpd7es83wckner	5bw66y36bff3umq1q57mfy4y5c	test-token	t
fpvzz1p2d2sgmhzrmfrhg3kami	qhkzgz0ruottpmoooxiudgvtis	0z4okgmv5lfhx3p0tf6pnpk8sk	test-token	t
e3dnfu1g17fjtxq53odawh6e7y	ox8n8edimjdbfkeybdf56pj4xw	3zats68fztgu9mgu944a4t35so	test-token	t
ob3junttstrfzfffkxg5cuwrth	zkedx4zsd7yqt84nh4h68mgxfr	p584bbmabpghxqz4qdwj8pdhpr	bridge	t
mbd3efwr6bfsddqr1j3ty7ka7a	f8ffk5uwobdpfmqjtk1gkr598a	6afiyfegctd1zxwen4aq4ywpyr	bridge	t
\.


--
-- Data for Name: usergroups; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.usergroups (id, name, displayname, description, source, remoteid, createat, updateat, deleteat, allowreference) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.users (id, createat, updateat, deleteat, username, password, authdata, authservice, email, emailverified, nickname, firstname, lastname, "position", roles, allowmarketing, props, notifyprops, lastpasswordupdate, lastpictureupdate, failedattempts, locale, timezone, mfaactive, mfasecret) FROM stdin;
3zats68fztgu9mgu944a4t35so	1598351812493	1598351812493	0	mattermost_b	$2a$10$bV5EvQPt9.p4jTO4VVM4Te2J7B7/IJhstPLhxVltLtufn7F97Q3nO	\N		mattermost_b@localhost	f					system_user	f	{}	{"channel":"true","comments":"never","desktop":"mention","desktop_sound":"true","email":"true","first_name":"false","mention_keys":"","push":"mention","push_status":"away"}	1598351812493	0	0	en	{"automaticTimezone":"","manualTimezone":"","useAutomaticTimezone":"true"}	f	
5bw66y36bff3umq1q57mfy4y5c	1598351800458	1598352057088	0	mattermost_a	$2a$10$WdovEVVvy9ZS867UE2hSq.7hV38Lg9H2ozgaF3gwuO6fuoCkkTzIu	\N		mattermost_a@localhost	f		MattermostUser	A		system_user	f	{}	{"channel":"true","comments":"never","desktop":"mention","desktop_sound":"true","email":"true","first_name":"false","mention_keys":"","push":"mention","push_status":"away"}	1598352057088	0	0	en	{"automaticTimezone":"","manualTimezone":"","useAutomaticTimezone":"true"}	f	
0z4okgmv5lfhx3p0tf6pnpk8sk	1598351800458	1598352057088	0	ignored_user	$2a$10$WdovEVVvy9ZS867UE2hSq.7hV38Lg9H2ozgaF3gwuO6fuoCkkTzIu	\N		ignored_user@localhost	f					system_user	f	{}	{"channel":"true","comments":"never","desktop":"mention","desktop_sound":"true","email":"true","first_name":"false","mention_keys":"","push":"mention","push_status":"away"}	1598352057088	0	0	en	{"automaticTimezone":"","manualTimezone":"","useAutomaticTimezone":"true"}	f	
ujmedpkiu3rcxyaojr1k1qem4h	1672675084887	1672677089875	0	bridgeuser1	$2a$10$lRY3g9V3dVlXKQWl/5WhiePgG506IY.DFZh/lNO4fQ7EKfpCAucbK	\N		bridgeuser1@localhost	f					system_user	t	{}	{"channel":"true","comments":"never","desktop":"mention","desktop_sound":"true","email":"true","first_name":"false","mention_keys":"","push":"mention","push_status":"away"}	1672675084887	0	0	en	{"automaticTimezone":"","manualTimezone":"","useAutomaticTimezone":"true"}	f	
bmq7jiumpib3xdz3mx5iyo99ro	1598351769026	1672677412484	0	admin	$2a$10$dCK8unlOWxu7Ge1Fmeo70eaETqonsQC1mVbwnLi5lCH5ALbzKyqnO	\N		admin@localhost	f		Admin	User		system_admin system_user	f	{}	{"channel":"true","comments":"never","desktop":"mention","desktop_sound":"true","email":"true","first_name":"false","mention_keys":"","push":"mention","push_status":"away"}	1598351769026	0	0	en	{"automaticTimezone":"","manualTimezone":"","useAutomaticTimezone":"true"}	f	
esahgx8oc7y3pbm4f95doipzny	1672675170972	1672675303237	0	bridgeuser2	$2a$10$r1lf3PqjV5N3oAGOTBL8.uiV7igkqvsnm7phRQ76/1/VosyPZQy3i	\N		bridgeuser2@localhost	f					system_user	t	{}	{"channel":"true","comments":"never","desktop":"mention","desktop_sound":"true","email":"true","first_name":"false","mention_keys":"","push":"mention","push_status":"away"}	1672675170972	0	0	en	{"automaticTimezone":"","manualTimezone":"","useAutomaticTimezone":"true"}	f	
p584bbmabpghxqz4qdwj8pdhpr	1672674601717	1672681242762	0	matrix_matrix_a	$2a$10$HaiRpjPGSsysnJW5xlPePunoonRz8L35nLd.zHS6Cgwz.ALb2lKQ6	\N		devnull-r5cxqrewz_kw2koy@localhost	t		matrix_a			system_user	f	{}	{"channel":"true","comments":"never","desktop":"mention","desktop_sound":"true","email":"true","first_name":"false","mention_keys":"","push":"mention","push_status":"away"}	1672674601717	0	0	en	{"automaticTimezone":"","manualTimezone":"","useAutomaticTimezone":"true"}	f	
6afiyfegctd1zxwen4aq4ywpyr	1672674602025	1672681242819	0	matrix_matrix_b	$2a$10$4SPz9uSpOxuHK37GUzohDu8YG1YpsTHcxnhz8FROyX5QgOTjHppPa	\N		devnull-91txgjl1a_mi3jit@localhost	t		matrix_b			system_user	f	{}	{"channel":"true","comments":"never","desktop":"mention","desktop_sound":"true","email":"true","first_name":"false","mention_keys":"","push":"mention","push_status":"away"}	1672674602025	0	0	en	{"automaticTimezone":"","manualTimezone":"","useAutomaticTimezone":"true"}	f	
\.


--
-- Data for Name: usertermsofservice; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.usertermsofservice (userid, termsofserviceid, createat) FROM stdin;
\.


--
-- Name: audits audits_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.audits
    ADD CONSTRAINT audits_pkey PRIMARY KEY (id);


--
-- Name: bots bots_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.bots
    ADD CONSTRAINT bots_pkey PRIMARY KEY (userid);


--
-- Name: channelmemberhistory channelmemberhistory_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.channelmemberhistory
    ADD CONSTRAINT channelmemberhistory_pkey PRIMARY KEY (channelid, userid, jointime);


--
-- Name: channelmembers channelmembers_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.channelmembers
    ADD CONSTRAINT channelmembers_pkey PRIMARY KEY (channelid, userid);


--
-- Name: channels channels_name_teamid_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_name_teamid_key UNIQUE (name, teamid);


--
-- Name: channels channels_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_pkey PRIMARY KEY (id);


--
-- Name: clusterdiscovery clusterdiscovery_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.clusterdiscovery
    ADD CONSTRAINT clusterdiscovery_pkey PRIMARY KEY (id);


--
-- Name: commands commands_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.commands
    ADD CONSTRAINT commands_pkey PRIMARY KEY (id);


--
-- Name: commandwebhooks commandwebhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.commandwebhooks
    ADD CONSTRAINT commandwebhooks_pkey PRIMARY KEY (id);


--
-- Name: compliances compliances_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.compliances
    ADD CONSTRAINT compliances_pkey PRIMARY KEY (id);


--
-- Name: emoji emoji_name_deleteat_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.emoji
    ADD CONSTRAINT emoji_name_deleteat_key UNIQUE (name, deleteat);


--
-- Name: emoji emoji_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.emoji
    ADD CONSTRAINT emoji_pkey PRIMARY KEY (id);


--
-- Name: fileinfo fileinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.fileinfo
    ADD CONSTRAINT fileinfo_pkey PRIMARY KEY (id);


--
-- Name: groupchannels groupchannels_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.groupchannels
    ADD CONSTRAINT groupchannels_pkey PRIMARY KEY (groupid, channelid);


--
-- Name: groupmembers groupmembers_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.groupmembers
    ADD CONSTRAINT groupmembers_pkey PRIMARY KEY (groupid, userid);


--
-- Name: groupteams groupteams_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.groupteams
    ADD CONSTRAINT groupteams_pkey PRIMARY KEY (groupid, teamid);


--
-- Name: incomingwebhooks incomingwebhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.incomingwebhooks
    ADD CONSTRAINT incomingwebhooks_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: licenses licenses_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.licenses
    ADD CONSTRAINT licenses_pkey PRIMARY KEY (id);


--
-- Name: linkmetadata linkmetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.linkmetadata
    ADD CONSTRAINT linkmetadata_pkey PRIMARY KEY (hash);


--
-- Name: oauthaccessdata oauthaccessdata_clientid_userid_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.oauthaccessdata
    ADD CONSTRAINT oauthaccessdata_clientid_userid_key UNIQUE (clientid, userid);


--
-- Name: oauthaccessdata oauthaccessdata_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.oauthaccessdata
    ADD CONSTRAINT oauthaccessdata_pkey PRIMARY KEY (token);


--
-- Name: oauthapps oauthapps_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.oauthapps
    ADD CONSTRAINT oauthapps_pkey PRIMARY KEY (id);


--
-- Name: oauthauthdata oauthauthdata_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.oauthauthdata
    ADD CONSTRAINT oauthauthdata_pkey PRIMARY KEY (code);


--
-- Name: outgoingwebhooks outgoingwebhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.outgoingwebhooks
    ADD CONSTRAINT outgoingwebhooks_pkey PRIMARY KEY (id);


--
-- Name: pluginkeyvaluestore pluginkeyvaluestore_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.pluginkeyvaluestore
    ADD CONSTRAINT pluginkeyvaluestore_pkey PRIMARY KEY (pluginid, pkey);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: preferences preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.preferences
    ADD CONSTRAINT preferences_pkey PRIMARY KEY (userid, category, name);


--
-- Name: publicchannels publicchannels_name_teamid_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.publicchannels
    ADD CONSTRAINT publicchannels_name_teamid_key UNIQUE (name, teamid);


--
-- Name: publicchannels publicchannels_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.publicchannels
    ADD CONSTRAINT publicchannels_pkey PRIMARY KEY (id);


--
-- Name: reactions reactions_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.reactions
    ADD CONSTRAINT reactions_pkey PRIMARY KEY (postid, userid, emojiname);


--
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: schemes schemes_name_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.schemes
    ADD CONSTRAINT schemes_name_key UNIQUE (name);


--
-- Name: schemes schemes_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.schemes
    ADD CONSTRAINT schemes_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sidebarcategories sidebarcategories_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.sidebarcategories
    ADD CONSTRAINT sidebarcategories_pkey PRIMARY KEY (id);


--
-- Name: sidebarchannels sidebarchannels_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.sidebarchannels
    ADD CONSTRAINT sidebarchannels_pkey PRIMARY KEY (channelid, userid, categoryid);


--
-- Name: status status_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_pkey PRIMARY KEY (userid);


--
-- Name: systems systems_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.systems
    ADD CONSTRAINT systems_pkey PRIMARY KEY (name);


--
-- Name: teammembers teammembers_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.teammembers
    ADD CONSTRAINT teammembers_pkey PRIMARY KEY (teamid, userid);


--
-- Name: teams teams_name_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_name_key UNIQUE (name);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: termsofservice termsofservice_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.termsofservice
    ADD CONSTRAINT termsofservice_pkey PRIMARY KEY (id);


--
-- Name: tokens tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_pkey PRIMARY KEY (token);


--
-- Name: useraccesstokens useraccesstokens_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.useraccesstokens
    ADD CONSTRAINT useraccesstokens_pkey PRIMARY KEY (id);


--
-- Name: useraccesstokens useraccesstokens_token_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.useraccesstokens
    ADD CONSTRAINT useraccesstokens_token_key UNIQUE (token);


--
-- Name: usergroups usergroups_name_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.usergroups
    ADD CONSTRAINT usergroups_name_key UNIQUE (name);


--
-- Name: usergroups usergroups_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.usergroups
    ADD CONSTRAINT usergroups_pkey PRIMARY KEY (id);


--
-- Name: usergroups usergroups_source_remoteid_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.usergroups
    ADD CONSTRAINT usergroups_source_remoteid_key UNIQUE (source, remoteid);


--
-- Name: users users_authdata_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_authdata_key UNIQUE (authdata);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: usertermsofservice usertermsofservice_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.usertermsofservice
    ADD CONSTRAINT usertermsofservice_pkey PRIMARY KEY (userid);


--
-- Name: idx_audits_user_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_audits_user_id ON public.audits USING btree (userid);


--
-- Name: idx_channel_search_txt; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_channel_search_txt ON public.channels USING gin (to_tsvector('english'::regconfig, (((((name)::text || ' '::text) || (displayname)::text) || ' '::text) || (purpose)::text)));


--
-- Name: idx_channelmembers_channel_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_channelmembers_channel_id ON public.channelmembers USING btree (channelid);


--
-- Name: idx_channelmembers_user_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_channelmembers_user_id ON public.channelmembers USING btree (userid);


--
-- Name: idx_channels_create_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_channels_create_at ON public.channels USING btree (createat);


--
-- Name: idx_channels_delete_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_channels_delete_at ON public.channels USING btree (deleteat);


--
-- Name: idx_channels_displayname_lower; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_channels_displayname_lower ON public.channels USING btree (lower((displayname)::text));


--
-- Name: idx_channels_name; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_channels_name ON public.channels USING btree (name);


--
-- Name: idx_channels_name_lower; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_channels_name_lower ON public.channels USING btree (lower((name)::text));


--
-- Name: idx_channels_scheme_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_channels_scheme_id ON public.channels USING btree (schemeid);


--
-- Name: idx_channels_team_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_channels_team_id ON public.channels USING btree (teamid);


--
-- Name: idx_channels_update_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_channels_update_at ON public.channels USING btree (updateat);


--
-- Name: idx_command_create_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_command_create_at ON public.commands USING btree (createat);


--
-- Name: idx_command_delete_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_command_delete_at ON public.commands USING btree (deleteat);


--
-- Name: idx_command_team_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_command_team_id ON public.commands USING btree (teamid);


--
-- Name: idx_command_update_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_command_update_at ON public.commands USING btree (updateat);


--
-- Name: idx_command_webhook_create_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_command_webhook_create_at ON public.commandwebhooks USING btree (createat);


--
-- Name: idx_emoji_create_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_emoji_create_at ON public.emoji USING btree (createat);


--
-- Name: idx_emoji_delete_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_emoji_delete_at ON public.emoji USING btree (deleteat);


--
-- Name: idx_emoji_name; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_emoji_name ON public.emoji USING btree (name);


--
-- Name: idx_emoji_update_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_emoji_update_at ON public.emoji USING btree (updateat);


--
-- Name: idx_fileinfo_create_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_fileinfo_create_at ON public.fileinfo USING btree (createat);


--
-- Name: idx_fileinfo_delete_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_fileinfo_delete_at ON public.fileinfo USING btree (deleteat);


--
-- Name: idx_fileinfo_postid_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_fileinfo_postid_at ON public.fileinfo USING btree (postid);


--
-- Name: idx_fileinfo_update_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_fileinfo_update_at ON public.fileinfo USING btree (updateat);


--
-- Name: idx_groupchannels_channelid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_groupchannels_channelid ON public.groupchannels USING btree (channelid);


--
-- Name: idx_groupchannels_schemeadmin; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_groupchannels_schemeadmin ON public.groupchannels USING btree (schemeadmin);


--
-- Name: idx_groupmembers_create_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_groupmembers_create_at ON public.groupmembers USING btree (createat);


--
-- Name: idx_groupteams_schemeadmin; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_groupteams_schemeadmin ON public.groupteams USING btree (schemeadmin);


--
-- Name: idx_groupteams_teamid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_groupteams_teamid ON public.groupteams USING btree (teamid);


--
-- Name: idx_incoming_webhook_create_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_incoming_webhook_create_at ON public.incomingwebhooks USING btree (createat);


--
-- Name: idx_incoming_webhook_delete_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_incoming_webhook_delete_at ON public.incomingwebhooks USING btree (deleteat);


--
-- Name: idx_incoming_webhook_team_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_incoming_webhook_team_id ON public.incomingwebhooks USING btree (teamid);


--
-- Name: idx_incoming_webhook_update_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_incoming_webhook_update_at ON public.incomingwebhooks USING btree (updateat);


--
-- Name: idx_incoming_webhook_user_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_incoming_webhook_user_id ON public.incomingwebhooks USING btree (userid);


--
-- Name: idx_jobs_type; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_jobs_type ON public.jobs USING btree (type);


--
-- Name: idx_link_metadata_url_timestamp; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_link_metadata_url_timestamp ON public.linkmetadata USING btree (url, "timestamp");


--
-- Name: idx_oauthaccessdata_client_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_oauthaccessdata_client_id ON public.oauthaccessdata USING btree (clientid);


--
-- Name: idx_oauthaccessdata_refresh_token; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_oauthaccessdata_refresh_token ON public.oauthaccessdata USING btree (refreshtoken);


--
-- Name: idx_oauthaccessdata_user_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_oauthaccessdata_user_id ON public.oauthaccessdata USING btree (userid);


--
-- Name: idx_oauthapps_creator_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_oauthapps_creator_id ON public.oauthapps USING btree (creatorid);


--
-- Name: idx_oauthauthdata_client_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_oauthauthdata_client_id ON public.oauthauthdata USING btree (code);


--
-- Name: idx_outgoing_webhook_create_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_outgoing_webhook_create_at ON public.outgoingwebhooks USING btree (createat);


--
-- Name: idx_outgoing_webhook_delete_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_outgoing_webhook_delete_at ON public.outgoingwebhooks USING btree (deleteat);


--
-- Name: idx_outgoing_webhook_team_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_outgoing_webhook_team_id ON public.outgoingwebhooks USING btree (teamid);


--
-- Name: idx_outgoing_webhook_update_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_outgoing_webhook_update_at ON public.outgoingwebhooks USING btree (updateat);


--
-- Name: idx_posts_channel_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_posts_channel_id ON public.posts USING btree (channelid);


--
-- Name: idx_posts_channel_id_delete_at_create_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_posts_channel_id_delete_at_create_at ON public.posts USING btree (channelid, deleteat, createat);


--
-- Name: idx_posts_channel_id_update_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_posts_channel_id_update_at ON public.posts USING btree (channelid, updateat);


--
-- Name: idx_posts_create_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_posts_create_at ON public.posts USING btree (createat);


--
-- Name: idx_posts_delete_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_posts_delete_at ON public.posts USING btree (deleteat);


--
-- Name: idx_posts_hashtags_txt; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_posts_hashtags_txt ON public.posts USING gin (to_tsvector('english'::regconfig, (hashtags)::text));


--
-- Name: idx_posts_is_pinned; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_posts_is_pinned ON public.posts USING btree (ispinned);


--
-- Name: idx_posts_message_txt; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_posts_message_txt ON public.posts USING gin (to_tsvector('english'::regconfig, (message)::text));


--
-- Name: idx_posts_root_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_posts_root_id ON public.posts USING btree (rootid);


--
-- Name: idx_posts_update_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_posts_update_at ON public.posts USING btree (updateat);


--
-- Name: idx_posts_user_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_posts_user_id ON public.posts USING btree (userid);


--
-- Name: idx_preferences_category; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_preferences_category ON public.preferences USING btree (category);


--
-- Name: idx_preferences_name; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_preferences_name ON public.preferences USING btree (name);


--
-- Name: idx_preferences_user_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_preferences_user_id ON public.preferences USING btree (userid);


--
-- Name: idx_publicchannels_delete_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_publicchannels_delete_at ON public.publicchannels USING btree (deleteat);


--
-- Name: idx_publicchannels_displayname_lower; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_publicchannels_displayname_lower ON public.publicchannels USING btree (lower((displayname)::text));


--
-- Name: idx_publicchannels_name; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_publicchannels_name ON public.publicchannels USING btree (name);


--
-- Name: idx_publicchannels_name_lower; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_publicchannels_name_lower ON public.publicchannels USING btree (lower((name)::text));


--
-- Name: idx_publicchannels_search_txt; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_publicchannels_search_txt ON public.publicchannels USING gin (to_tsvector('english'::regconfig, (((((name)::text || ' '::text) || (displayname)::text) || ' '::text) || (purpose)::text)));


--
-- Name: idx_publicchannels_team_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_publicchannels_team_id ON public.publicchannels USING btree (teamid);


--
-- Name: idx_schemes_channel_admin_role; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_schemes_channel_admin_role ON public.schemes USING btree (defaultchanneladminrole);


--
-- Name: idx_schemes_channel_guest_role; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_schemes_channel_guest_role ON public.schemes USING btree (defaultchannelguestrole);


--
-- Name: idx_schemes_channel_user_role; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_schemes_channel_user_role ON public.schemes USING btree (defaultchanneluserrole);


--
-- Name: idx_sessions_create_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_sessions_create_at ON public.sessions USING btree (createat);


--
-- Name: idx_sessions_expires_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_sessions_expires_at ON public.sessions USING btree (expiresat);


--
-- Name: idx_sessions_last_activity_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_sessions_last_activity_at ON public.sessions USING btree (lastactivityat);


--
-- Name: idx_sessions_token; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_sessions_token ON public.sessions USING btree (token);


--
-- Name: idx_sessions_user_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_sessions_user_id ON public.sessions USING btree (userid);


--
-- Name: idx_status_status; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_status_status ON public.status USING btree (status);


--
-- Name: idx_status_user_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_status_user_id ON public.status USING btree (userid);


--
-- Name: idx_teammembers_delete_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_teammembers_delete_at ON public.teammembers USING btree (deleteat);


--
-- Name: idx_teammembers_team_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_teammembers_team_id ON public.teammembers USING btree (teamid);


--
-- Name: idx_teammembers_user_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_teammembers_user_id ON public.teammembers USING btree (userid);


--
-- Name: idx_teams_create_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_teams_create_at ON public.teams USING btree (createat);


--
-- Name: idx_teams_delete_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_teams_delete_at ON public.teams USING btree (deleteat);


--
-- Name: idx_teams_invite_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_teams_invite_id ON public.teams USING btree (inviteid);


--
-- Name: idx_teams_name; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_teams_name ON public.teams USING btree (name);


--
-- Name: idx_teams_scheme_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_teams_scheme_id ON public.teams USING btree (schemeid);


--
-- Name: idx_teams_update_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_teams_update_at ON public.teams USING btree (updateat);


--
-- Name: idx_user_access_tokens_token; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_user_access_tokens_token ON public.useraccesstokens USING btree (token);


--
-- Name: idx_user_access_tokens_user_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_user_access_tokens_user_id ON public.useraccesstokens USING btree (userid);


--
-- Name: idx_user_terms_of_service_user_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_user_terms_of_service_user_id ON public.usertermsofservice USING btree (userid);


--
-- Name: idx_usergroups_delete_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_usergroups_delete_at ON public.usergroups USING btree (deleteat);


--
-- Name: idx_usergroups_remote_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_usergroups_remote_id ON public.usergroups USING btree (remoteid);


--
-- Name: idx_users_all_no_full_name_txt; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_users_all_no_full_name_txt ON public.users USING gin (to_tsvector('english'::regconfig, (((((username)::text || ' '::text) || (nickname)::text) || ' '::text) || (email)::text)));


--
-- Name: idx_users_all_txt; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_users_all_txt ON public.users USING gin (to_tsvector('english'::regconfig, (((((((((username)::text || ' '::text) || (firstname)::text) || ' '::text) || (lastname)::text) || ' '::text) || (nickname)::text) || ' '::text) || (email)::text)));


--
-- Name: idx_users_create_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_users_create_at ON public.users USING btree (createat);


--
-- Name: idx_users_delete_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_users_delete_at ON public.users USING btree (deleteat);


--
-- Name: idx_users_email; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_users_email ON public.users USING btree (email);


--
-- Name: idx_users_email_lower_textpattern; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_users_email_lower_textpattern ON public.users USING btree (lower((email)::text) text_pattern_ops);


--
-- Name: idx_users_firstname_lower_textpattern; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_users_firstname_lower_textpattern ON public.users USING btree (lower((firstname)::text) text_pattern_ops);


--
-- Name: idx_users_lastname_lower_textpattern; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_users_lastname_lower_textpattern ON public.users USING btree (lower((lastname)::text) text_pattern_ops);


--
-- Name: idx_users_names_no_full_name_txt; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_users_names_no_full_name_txt ON public.users USING gin (to_tsvector('english'::regconfig, (((username)::text || ' '::text) || (nickname)::text)));


--
-- Name: idx_users_names_txt; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_users_names_txt ON public.users USING gin (to_tsvector('english'::regconfig, (((((((username)::text || ' '::text) || (firstname)::text) || ' '::text) || (lastname)::text) || ' '::text) || (nickname)::text)));


--
-- Name: idx_users_nickname_lower_textpattern; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_users_nickname_lower_textpattern ON public.users USING btree (lower((nickname)::text) text_pattern_ops);


--
-- Name: idx_users_update_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_users_update_at ON public.users USING btree (updateat);


--
-- Name: idx_users_username_lower_textpattern; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_users_username_lower_textpattern ON public.users USING btree (lower((username)::text) text_pattern_ops);


--
-- PostgreSQL database dump complete
--

