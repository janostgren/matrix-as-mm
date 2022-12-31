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
ukf4zf3jptre3n7jqhd1s7mn8c	1672393303457		/api/v4/users/login	attempt - login_id=admin	192.168.112.1	
8uba3awwe3b88ydzmqoxbttx8a	1672393303688		/api/v4/users/login	failure - login_id=admin	192.168.112.1	
wqj9ium5jtgftb7y6zpebnqhka	1672393324516		/api/v4/users/login	attempt - login_id=admin	192.168.112.1	
k6i7hc889jg5xp6ihjd7qwdxtc	1672393324618	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/login	authenticated	192.168.112.1	
myhnhxzcd38nmcqpte11ufbjhy	1672393324634	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/login	success session_user=bmq7jiumpib3xdz3mx5iyo99ro	192.168.112.1	qckzkp1bmtfo5xxr348npyoxto
bnxzrngtwjrtiqshp7xubaknuc	1672393388314	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	192.168.112.1	x51q8edte7dexy31j4f4nh9tde
wbopy8ptzbg6djmd9orfwfa14c	1672393388322	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	192.168.112.1	x51q8edte7dexy31j4f4nh9tde
raqtajd6mfy1fy1hi5ck4gbtto	1672393389069	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/8ij6q13b67dhzko8cqha4rn1sa/email/verify/member	user verified	192.168.112.1	x51q8edte7dexy31j4f4nh9tde
7oi5mptintnkmru5negpktuokh	1672393389092	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/8ij6q13b67dhzko8cqha4rn1sa/tokens		192.168.112.1	x51q8edte7dexy31j4f4nh9tde
q87za4iaifbdufef6bqx4o9wbw	1672393389135	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/8ij6q13b67dhzko8cqha4rn1sa/tokens	success - token_id=61ueoj83fp8gdbnooz9gu8mppe	192.168.112.1	x51q8edte7dexy31j4f4nh9tde
b3nexqyeo7r1fm45p6gk3e1m1y	1672393389390	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=8ij6q13b67dhzko8cqha4rn1sa	192.168.112.1	x51q8edte7dexy31j4f4nh9tde
km6ck1csw3f5mfry8wj489gtpw	1672393389402	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/goynmto1ubrnucswajybh3o4kc/email/verify/member	user verified	192.168.112.1	x51q8edte7dexy31j4f4nh9tde
bfabfxz9pjdopd1hkmdp6o61ao	1672393389411	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/goynmto1ubrnucswajybh3o4kc/tokens		192.168.112.1	x51q8edte7dexy31j4f4nh9tde
4pi3windhtdyzgxwcpzkmu8cry	1672393389432	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/goynmto1ubrnucswajybh3o4kc/tokens	success - token_id=yp5wwhqgjbfmxxs9gc7s43daee	192.168.112.1	x51q8edte7dexy31j4f4nh9tde
jb6e4yb1htrm9qg3mca5hadoaw	1672393389529	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/8ij6q13b67dhzko8cqha4rn1sa/patch		192.168.112.1	x51q8edte7dexy31j4f4nh9tde
dwuaszu1pb8p5rmgebxi339q9c	1672393389561	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=8ij6q13b67dhzko8cqha4rn1sa	192.168.112.1	x51q8edte7dexy31j4f4nh9tde
5cicyhrmz387jfegr17yt89eer	1672393389657	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/goynmto1ubrnucswajybh3o4kc/patch		192.168.112.1	x51q8edte7dexy31j4f4nh9tde
hp3notwmtbnrfd9bzdb9kfsftw	1672393389685	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=goynmto1ubrnucswajybh3o4kc	192.168.112.1	x51q8edte7dexy31j4f4nh9tde
13htitn873fxmgp9tdeut6djye	1672393389700	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=goynmto1ubrnucswajybh3o4kc	192.168.112.1	x51q8edte7dexy31j4f4nh9tde
4g7c61kmgf8bu89b7igokk8qmc	1672393596299	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/logout		192.168.112.1	qckzkp1bmtfo5xxr348npyoxto
3weshe5pabfufnkqaquh8otpar	1672393618831		/api/v4/users/login	attempt - login_id=admin	192.168.112.1	
7tu35r3tq3djid11uzpjjqn9cr	1672393618935	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/login	authenticated	192.168.112.1	
g8eqjpimutd4zn777maxpktuhw	1672393618945	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/login	success session_user=bmq7jiumpib3xdz3mx5iyo99ro	192.168.112.1	8t6p6twq97gdfna11fx595u1dw
mrce8pg3ifn1jmjjp6fypj5jnw	1672393674511	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	192.168.112.1	x51q8edte7dexy31j4f4nh9tde
gjfcca6fi3gmtq4zz8hr1kg3ca	1672393674514	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	192.168.112.1	x51q8edte7dexy31j4f4nh9tde
xth3giriytr63qt5nrcrkkgp1c	1672393674770	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/8ij6q13b67dhzko8cqha4rn1sa/patch		192.168.112.1	x51q8edte7dexy31j4f4nh9tde
3z6hmik7xt83bg1iad6nzzw11w	1672393674781	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/goynmto1ubrnucswajybh3o4kc/patch		192.168.112.1	x51q8edte7dexy31j4f4nh9tde
hh3useiae7f3tri35wp5ce453e	1672393674819	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=8ij6q13b67dhzko8cqha4rn1sa	192.168.112.1	x51q8edte7dexy31j4f4nh9tde
deoud98thtdrbnfefpmjdmxj5h	1672393674833	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/8ij6q13b67dhzko8cqha4rn1sa/patch		192.168.112.1	x51q8edte7dexy31j4f4nh9tde
ky53wjqkx3foi8wime63hgnyzw	1672393674819	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/goynmto1ubrnucswajybh3o4kc/patch		192.168.112.1	x51q8edte7dexy31j4f4nh9tde
6qwzekqap781uqgybtsjaqk5fc	1672393674861	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=goynmto1ubrnucswajybh3o4kc	192.168.112.1	x51q8edte7dexy31j4f4nh9tde
drmwhqk3ztrofrmkpjipzuogxy	1672393674864	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=goynmto1ubrnucswajybh3o4kc	192.168.112.1	x51q8edte7dexy31j4f4nh9tde
a6xaq1krcbdn5kzxfwc4ofzb6o	1672393674887	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=8ij6q13b67dhzko8cqha4rn1sa	192.168.112.1	x51q8edte7dexy31j4f4nh9tde
pbboj8uzfpgd7xrzj79zenfwfr	1672415361777	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/logout		192.168.112.1	8t6p6twq97gdfna11fx595u1dw
rcswtt8p6iditnuf3w7awoezte	1672415461867	wwnaa6j41pbkje5qku89eej6de	/api/v4/users/login	attempt - login_id=	192.168.112.1	
kmewuzoj53bd7qo8myqg7neaow	1672415461961	wwnaa6j41pbkje5qku89eej6de	/api/v4/users/login	authenticated	192.168.112.1	
w1werji18tbmdxeg4wti8qhbco	1672415461970	wwnaa6j41pbkje5qku89eej6de	/api/v4/users/login	success session_user=wwnaa6j41pbkje5qku89eej6de	192.168.112.1	4aqr7z5nk7g83ja1ntqodkx1qe
sacpkstsj7bitxk8u5qchsyryw	1672415742157	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	192.168.112.1	x51q8edte7dexy31j4f4nh9tde
zu31t7eg3fydxxcuwy1mrqmsoo	1672415742160	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	192.168.112.1	x51q8edte7dexy31j4f4nh9tde
89nm4r5qhpfm9xspz7gdndty9o	1672415742452	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/8ij6q13b67dhzko8cqha4rn1sa/patch		192.168.112.1	x51q8edte7dexy31j4f4nh9tde
nbhwktesr3y1z8wecrxjgf6f3y	1672415742483	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/goynmto1ubrnucswajybh3o4kc/patch		192.168.112.1	x51q8edte7dexy31j4f4nh9tde
zddr31rhutbnzkndj6wf88ipzo	1672415742515	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=8ij6q13b67dhzko8cqha4rn1sa	192.168.112.1	x51q8edte7dexy31j4f4nh9tde
4zuuiwegffyqtqa6dikocud5wo	1672415742530	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=goynmto1ubrnucswajybh3o4kc	192.168.112.1	x51q8edte7dexy31j4f4nh9tde
8jfdz6t6mf8fjrqa4fdbke8mky	1672415742533	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/goynmto1ubrnucswajybh3o4kc/patch		192.168.112.1	x51q8edte7dexy31j4f4nh9tde
4y65wy5dqb8cixixe38a5yshnc	1672415742541	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/8ij6q13b67dhzko8cqha4rn1sa/patch		192.168.112.1	x51q8edte7dexy31j4f4nh9tde
so935poik7fk9jwj64z4itz4qr	1672415742565	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=goynmto1ubrnucswajybh3o4kc	192.168.112.1	x51q8edte7dexy31j4f4nh9tde
5uq9eho3girnmmybt6otfcn94r	1672415742575	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=8ij6q13b67dhzko8cqha4rn1sa	192.168.112.1	x51q8edte7dexy31j4f4nh9tde
o7yyhfznwjg7zxkgiiw1ykga9e	1672416372653	wwnaa6j41pbkje5qku89eej6de	/api/v4/users/logout		172.16.238.1	4aqr7z5nk7g83ja1ntqodkx1qe
bqo9j4eir3bf9cc3aunccdxmbw	1672416383912		/api/v4/users/login	attempt - login_id=bridgeuser1	172.16.238.1	
has1su46ijyqpe7ncwxpz6t4jw	1672416384022	wwnaa6j41pbkje5qku89eej6de	/api/v4/users/login	authenticated	172.16.238.1	
q6xpc5sfqt8dx8rhdxnas81gba	1672416384034	wwnaa6j41pbkje5qku89eej6de	/api/v4/users/login	success session_user=wwnaa6j41pbkje5qku89eej6de	172.16.238.1	k479q9sgt7yiifc98dzfihbsnh
s5gawpzgdt8a8dmxibrrm5uwsr	1672416525407	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	x51q8edte7dexy31j4f4nh9tde
wwckqjtjqirp9dhk16cgjghj6e	1672416525415	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	x51q8edte7dexy31j4f4nh9tde
bmdc1cburjdy5keprmwqf6rgoa	1672416525740	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/zr66z9nhxpyxixtgkwq9xydjxa/email/verify/member	user verified	172.16.238.1	x51q8edte7dexy31j4f4nh9tde
gfcoqxd84jfp3cewos683jg84a	1672416525766	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/zr66z9nhxpyxixtgkwq9xydjxa/tokens		172.16.238.1	x51q8edte7dexy31j4f4nh9tde
4ttdthtcwtgdjce1oqo3tddofw	1672416525785	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/zr66z9nhxpyxixtgkwq9xydjxa/tokens	success - token_id=twwgm8xek3y6mqo4fdrgkouako	172.16.238.1	x51q8edte7dexy31j4f4nh9tde
ghxgr6sm4ir5d8697zhyrj6nqc	1672416525975	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=zr66z9nhxpyxixtgkwq9xydjxa	172.16.238.1	x51q8edte7dexy31j4f4nh9tde
r7765fxrjfrt5mnwstebwm3bty	1672416526015	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/8jx756z8z78figfywkuqb8996w/email/verify/member	user verified	172.16.238.1	x51q8edte7dexy31j4f4nh9tde
estmqwmy6i83bfwyjwxjcwqbpr	1672416526027	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/8jx756z8z78figfywkuqb8996w/tokens		172.16.238.1	x51q8edte7dexy31j4f4nh9tde
nor4xbxfybrftphyk185weynho	1672416526044	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/8jx756z8z78figfywkuqb8996w/tokens	success - token_id=abkqr56nifff9jg6hzpxcufqrh	172.16.238.1	x51q8edte7dexy31j4f4nh9tde
atuqr6zte3nymmkwuzrzzys3uy	1672416526146	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/8jx756z8z78figfywkuqb8996w/patch		172.16.238.1	x51q8edte7dexy31j4f4nh9tde
4s7o5en6gtd4z89y6aa7dmwaar	1672416526193	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=8jx756z8z78figfywkuqb8996w	172.16.238.1	x51q8edte7dexy31j4f4nh9tde
yzixubt93prdfeddrreb7myymc	1672416526260	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/zr66z9nhxpyxixtgkwq9xydjxa/patch		172.16.238.1	x51q8edte7dexy31j4f4nh9tde
sx6urcz1wpn3jxyc71jj5ami5c	1672416526282	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=zr66z9nhxpyxixtgkwq9xydjxa	172.16.238.1	x51q8edte7dexy31j4f4nh9tde
wu8fydf4htds7mnquaxotcmbfy	1672416526480	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=8jx756z8z78figfywkuqb8996w	172.16.238.1	x51q8edte7dexy31j4f4nh9tde
3xbxrhkttjf8fc3mdz5p7iisqc	1672416549544	wwnaa6j41pbkje5qku89eej6de	/api/v4/users/logout		172.16.238.1	k479q9sgt7yiifc98dzfihbsnh
78r5hbos8pf9mba49mmtdmxf1w	1672416562218		/api/v4/users/login	attempt - login_id=bridgeuser1	172.16.238.1	
syrnruotdidi5e6rdu7zc4hp3h	1672416562318	wwnaa6j41pbkje5qku89eej6de	/api/v4/users/login	authenticated	172.16.238.1	
5b34w78d9trs7rh33dkwurn33a	1672416562326	wwnaa6j41pbkje5qku89eej6de	/api/v4/users/login	success session_user=wwnaa6j41pbkje5qku89eej6de	172.16.238.1	3czosk8bajfebdt3wmo99euzyc
si7pwpxdhfymigityzbdmehidh	1672481698919	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	x51q8edte7dexy31j4f4nh9tde
117k7wabb3npbpuz69ed87655e	1672481698924	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	x51q8edte7dexy31j4f4nh9tde
5kk89jaqkirq9dgwdde1igeaho	1672481699177	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/zr66z9nhxpyxixtgkwq9xydjxa/patch		172.16.238.1	x51q8edte7dexy31j4f4nh9tde
phg6rkfedpnhjpj6fbq1f7mpuh	1672481699180	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/8jx756z8z78figfywkuqb8996w/patch		172.16.238.1	x51q8edte7dexy31j4f4nh9tde
umohi3d4hjns3p6fmc3jsqkdzh	1672481699217	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/zr66z9nhxpyxixtgkwq9xydjxa/patch		172.16.238.1	x51q8edte7dexy31j4f4nh9tde
s8e4swhsot8wmk6riychxcrx3y	1672481699225	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/8jx756z8z78figfywkuqb8996w/patch		172.16.238.1	x51q8edte7dexy31j4f4nh9tde
cpodbbkuf78o8xxuuzdymjeede	1672481699251	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=8jx756z8z78figfywkuqb8996w	172.16.238.1	x51q8edte7dexy31j4f4nh9tde
4yd1xiq9i3g85ydbcqd7kbfrzc	1672481699252	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=zr66z9nhxpyxixtgkwq9xydjxa	172.16.238.1	x51q8edte7dexy31j4f4nh9tde
jae84z8i4pf1be4dt35f7hj9eh	1672481699293	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=zr66z9nhxpyxixtgkwq9xydjxa	172.16.238.1	x51q8edte7dexy31j4f4nh9tde
p46eqoatetg7jfsznyef817x3h	1672481699293	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=8jx756z8z78figfywkuqb8996w	172.16.238.1	x51q8edte7dexy31j4f4nh9tde
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
cxtmz3ubz3gfigd5m6prendmsw	8ij6q13b67dhzko8cqha4rn1sa	1672393389270	\N
73uy6kj1jb8wdqrf3ti6zies6r	8ij6q13b67dhzko8cqha4rn1sa	1672393389306	\N
cxtmz3ubz3gfigd5m6prendmsw	goynmto1ubrnucswajybh3o4kc	1672393389581	\N
73uy6kj1jb8wdqrf3ti6zies6r	goynmto1ubrnucswajybh3o4kc	1672393389629	\N
1cma8yikrbnhbn65w3rfykwntc	wwnaa6j41pbkje5qku89eej6de	1672415474194	\N
wuo9s48usjrzdk3hxr93173rhr	wwnaa6j41pbkje5qku89eej6de	1672415474245	\N
pnzjpcnrmtdfdq37g3m9hcu3dy	wwnaa6j41pbkje5qku89eej6de	1672416416986	\N
pnzjpcnrmtdfdq37g3m9hcu3dy	8ij6q13b67dhzko8cqha4rn1sa	1672416416990	\N
cxtmz3ubz3gfigd5m6prendmsw	zr66z9nhxpyxixtgkwq9xydjxa	1672416525911	\N
73uy6kj1jb8wdqrf3ti6zies6r	zr66z9nhxpyxixtgkwq9xydjxa	1672416525938	\N
cxtmz3ubz3gfigd5m6prendmsw	8jx756z8z78figfywkuqb8996w	1672416526192	\N
73uy6kj1jb8wdqrf3ti6zies6r	8jx756z8z78figfywkuqb8996w	1672416526253	\N
surjpu98zpgamjbwhhyo5px9zy	wwnaa6j41pbkje5qku89eej6de	1672482999012	\N
surjpu98zpgamjbwhhyo5px9zy	zr66z9nhxpyxixtgkwq9xydjxa	1672482999019	\N
\.


--
-- Data for Name: channelmembers; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.channelmembers (channelid, userid, roles, lastviewedat, msgcount, mentioncount, notifyprops, lastupdateat, schemeuser, schemeadmin, schemeguest) FROM stdin;
73uy6kj1jb8wdqrf3ti6zies6r	bmq7jiumpib3xdz3mx5iyo99ro		0	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1598351847747	t	f	f
cxtmz3ubz3gfigd5m6prendmsw	5bw66y36bff3umq1q57mfy4y5c		0	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1598351852017	t	f	f
73uy6kj1jb8wdqrf3ti6zies6r	5bw66y36bff3umq1q57mfy4y5c		0	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1598351852041	t	f	f
cxtmz3ubz3gfigd5m6prendmsw	0z4okgmv5lfhx3p0tf6pnpk8sk		0	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1598351852017	t	f	f
73uy6kj1jb8wdqrf3ti6zies6r	0z4okgmv5lfhx3p0tf6pnpk8sk		0	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1598351852041	t	f	f
cxtmz3ubz3gfigd5m6prendmsw	3zats68fztgu9mgu944a4t35so		0	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1598351852017	t	f	f
73uy6kj1jb8wdqrf3ti6zies6r	3zats68fztgu9mgu944a4t35so		0	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1598351852041	t	f	f
cxtmz3ubz3gfigd5m6prendmsw	8ij6q13b67dhzko8cqha4rn1sa		0	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672393389263	t	f	f
73uy6kj1jb8wdqrf3ti6zies6r	8ij6q13b67dhzko8cqha4rn1sa		0	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672393389286	t	f	f
cxtmz3ubz3gfigd5m6prendmsw	goynmto1ubrnucswajybh3o4kc		0	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672393389575	t	f	f
73uy6kj1jb8wdqrf3ti6zies6r	goynmto1ubrnucswajybh3o4kc		0	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672393389605	t	f	f
cxtmz3ubz3gfigd5m6prendmsw	bmq7jiumpib3xdz3mx5iyo99ro		1672393715114	3	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672393715114	t	f	f
wuo9s48usjrzdk3hxr93173rhr	wwnaa6j41pbkje5qku89eej6de		1672482901676	1	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672482901676	t	t	f
cxtmz3ubz3gfigd5m6prendmsw	zr66z9nhxpyxixtgkwq9xydjxa		0	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672416525904	t	f	f
73uy6kj1jb8wdqrf3ti6zies6r	zr66z9nhxpyxixtgkwq9xydjxa		0	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672416525932	t	f	f
73uy6kj1jb8wdqrf3ti6zies6r	8jx756z8z78figfywkuqb8996w		0	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672416526235	t	f	f
cxtmz3ubz3gfigd5m6prendmsw	8jx756z8z78figfywkuqb8996w		0	0	1	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672416526247	t	f	f
pnzjpcnrmtdfdq37g3m9hcu3dy	wwnaa6j41pbkje5qku89eej6de		1672482826438	3	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672482826438	t	f	f
surjpu98zpgamjbwhhyo5px9zy	zr66z9nhxpyxixtgkwq9xydjxa		0	0	1	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672483013509	t	f	f
surjpu98zpgamjbwhhyo5px9zy	wwnaa6j41pbkje5qku89eej6de		1672483013491	1	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672483013491	t	f	f
1cma8yikrbnhbn65w3rfykwntc	wwnaa6j41pbkje5qku89eej6de		1672482888674	2	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672482888674	t	t	f
pnzjpcnrmtdfdq37g3m9hcu3dy	8ij6q13b67dhzko8cqha4rn1sa		0	0	3	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672482826449	t	f	f
\.


--
-- Data for Name: channels; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.channels (id, createat, updateat, deleteat, teamid, type, displayname, name, header, purpose, lastpostat, totalmsgcount, extraupdateat, creatorid, schemeid, groupconstrained) FROM stdin;
cxtmz3ubz3gfigd5m6prendmsw	1598351837713	1598351837713	0	tgrw7sjgbiy1jggs3qg3m6zpee	O	Town Square	town-square			1672416526198	3	0		\N	\N
73uy6kj1jb8wdqrf3ti6zies6r	1598351837717	1598351837717	0	tgrw7sjgbiy1jggs3qg3m6zpee	O	Off-Topic	off-topic			1672416526256	0	0		\N	\N
pnzjpcnrmtdfdq37g3m9hcu3dy	1672416416972	1672416416972	0		D		8ij6q13b67dhzko8cqha4rn1sa__wwnaa6j41pbkje5qku89eej6de			1672482826438	3	0		\N	\N
1cma8yikrbnhbn65w3rfykwntc	1672415474116	1672415474116	0	fk9o6gdfcidxiyfeuqnwx5urey	O	Town Square	town-square			1672482888674	2	0		\N	\N
wuo9s48usjrzdk3hxr93173rhr	1672415474129	1672415474129	0	fk9o6gdfcidxiyfeuqnwx5urey	O	Off-Topic	off-topic			1672482901676	1	0		\N	\N
surjpu98zpgamjbwhhyo5px9zy	1672482998998	1672482998998	0		D		wwnaa6j41pbkje5qku89eej6de__zr66z9nhxpyxixtgkwq9xydjxa			1672483013491	1	0		\N	\N
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
5cz4xkdpi3f9brkz8r4mw7fnur	expiry_notify	0	1672394154157	1672394164943	1672394164948	success	0	{}
nk77itkbjbnibjteh86ksfqs7c	expiry_notify	0	1672401609050	1672401609091	1672401609104	success	0	{}
4oyh6rpem3nyxqn9ffrojb37ee	expiry_notify	0	1672408839213	1672413058705	1672413058791	success	0	{}
s1erm55wnb8xxptbegg6q8eiic	expiry_notify	0	1672413058762	1672413073710	1672413073715	success	0	{}
85chjxseatywbmmh6yty36buya	expiry_notify	0	1672415950026	1672415953631	1672415953642	success	0	{}
ykz3qiwbjinimya8s4ci933jfe	expiry_notify	0	1672481435502	1672481450506	1672481450514	success	0	{}
ihw7a4ke5tguzxmxc41d8g8ebr	expiry_notify	0	1672416972470	1672416980206	1672416980212	success	0	{}
bh1iq8d4wirfzxxj8bxhizm1uw	expiry_notify	0	1672417572092	1672417580181	1672417580189	success	0	{}
1wu8fokb7tgg8pur93n98o6z9a	expiry_notify	0	1672418171698	1672418180174	1672418180180	success	0	{}
rgxiiw6mbb8u5qrqjw53wsooxo	expiry_notify	0	1672482036293	1672482050976	1672482050981	success	0	{}
mrtzydu397dtu8kj3148uosx6r	expiry_notify	0	1672425402216	1672425416716	1672425416723	success	0	{}
jphsj4x11tyat8phj5rmaqf9wc	expiry_notify	0	1672432631853	1672439837703	1672439837749	success	0	{}
p3fgwxp8ribtbbeuefan8ddimo	expiry_notify	0	1672439837717	1672439852717	1672439852724	success	0	{}
9yic3t4mhfbwmmgkpwxsdmcpce	expiry_notify	0	1672482636005	1672482650872	1672482650882	success	0	{}
gez1bwhhybyupp1n53zg8qxhyc	expiry_notify	0	1672447069576	1672447069589	1672447069599	success	0	{}
m886tpg89iyupf4xebubin3gdo	expiry_notify	0	1672454300756	1672461506788	1672461506803	success	0	{}
ofh3dyna9pn5i8ttogq4xky8oo	expiry_notify	0	1672461506784	1672461521798	1672461521805	success	0	{}
8fagjgbdtifrig97j1y1g8mmqa	expiry_notify	0	1672483235620	1672483235677	1672483235682	success	0	{}
fzrccuaauprkjkqfzp9b1afmfo	expiry_notify	0	1672468736525	1672468751519	1672468751528	success	0	{}
fmqh7counbgcmc71cr59etk68r	expiry_notify	0	1672475968608	1672475968613	1672475968624	success	0	{}
84br335sridwbn1fs5p69mwqcw	expiry_notify	0	1672477838483	1672477838594	1672477840736	success	0	{}
djqndgywo7gsidc3w1h15t8e4w	expiry_notify	0	1672478438103	1672478438469	1672478438474	success	0	{}
u171brf81ifq7c76se56gxr4tw	expiry_notify	0	1672479640164	1672479651201	1672479651208	success	0	{}
ogf66tgiyfbbzefhzecjuacype	expiry_notify	0	1672480545280	1672480552262	1672480552279	success	0	{}
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
mkh971uau7gi3gc7i5udrgjgfo	1672393389272	1672393389272	0	0	f	8ij6q13b67dhzko8cqha4rn1sa	cxtmz3ubz3gfigd5m6prendmsw				matrix_matrix_a joined the team.	system_join_team	{"username":"matrix_matrix_a"}		[]	[]	f
d8s7r79eii8abk677qjs4r4hyr	1672393389318	1672393389318	0	0	f	8ij6q13b67dhzko8cqha4rn1sa	73uy6kj1jb8wdqrf3ti6zies6r				matrix_matrix_a joined the channel.	system_join_channel	{"username":"matrix_matrix_a"}		[]	[]	f
yy6cj1nsupbndrx9y1okmubypr	1672393389587	1672393389587	0	0	f	goynmto1ubrnucswajybh3o4kc	cxtmz3ubz3gfigd5m6prendmsw				matrix_matrix_b joined the team.	system_join_team	{"username":"matrix_matrix_b"}		[]	[]	f
s11m69cme7ns9kmkutwujaxboa	1672393389631	1672393389631	0	0	f	goynmto1ubrnucswajybh3o4kc	73uy6kj1jb8wdqrf3ti6zies6r				matrix_matrix_b joined the channel.	system_join_channel	{"username":"matrix_matrix_b"}		[]	[]	f
4q1pw7ka63bo3jki4146sg34ww	1672393435992	1672393435992	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	cxtmz3ubz3gfigd5m6prendmsw				Hallo town		{"disable_group_highlight":true}		[]	[]	f
1oe76tpdxpy7fnnf6qisaih4jo	1672393644150	1672393644150	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	cxtmz3ubz3gfigd5m6prendmsw				Hi again		{"disable_group_highlight":true}		[]	[]	f
c7dm3y3d3tbnbkj5aeq3m3wmxe	1672393715114	1672393715114	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	cxtmz3ubz3gfigd5m6prendmsw				Hi		{"disable_group_highlight":true}		[]	[]	f
forf6wbxyfggmg9cz68ajj3pew	1672415474203	1672415474203	0	0	f	wwnaa6j41pbkje5qku89eej6de	1cma8yikrbnhbn65w3rfykwntc				bridgeuser1 joined the team.	system_join_team	{"username":"bridgeuser1"}		[]	[]	f
jhehogmedpdodb6zxcqknasm6h	1672415474249	1672415474249	0	0	f	wwnaa6j41pbkje5qku89eej6de	wuo9s48usjrzdk3hxr93173rhr				bridgeuser1 joined the channel.	system_join_channel	{"username":"bridgeuser1"}		[]	[]	f
5nrtayccs386ty5kh63zpyyxka	1672415777357	1672415777357	0	0	f	wwnaa6j41pbkje5qku89eej6de	1cma8yikrbnhbn65w3rfykwntc				I am here now		{"disable_group_highlight":true}		[]	[]	f
5jdn4chxe7bxtqfwx334qgb5mh	1672416432264	1672416432264	0	0	f	wwnaa6j41pbkje5qku89eej6de	pnzjpcnrmtdfdq37g3m9hcu3dy				Hello to you		{"disable_group_highlight":true}		[]	[]	f
m1xhscnt8f86pkecbhtak7h6na	1672416525912	1672416525912	0	0	f	zr66z9nhxpyxixtgkwq9xydjxa	cxtmz3ubz3gfigd5m6prendmsw				matrix_matrix_a_ joined the team.	system_join_team	{"username":"matrix_matrix_a_"}		[]	[]	f
eciuy8x1wfbtbrghhpek8eo7ah	1672416525940	1672416525940	0	0	f	zr66z9nhxpyxixtgkwq9xydjxa	73uy6kj1jb8wdqrf3ti6zies6r				matrix_matrix_a_ joined the channel.	system_join_channel	{"username":"matrix_matrix_a_"}		[]	[]	f
gt89zhac8pbn583jmat876ss5e	1672416526194	1672416526194	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	cxtmz3ubz3gfigd5m6prendmsw				matrix_matrix_b_ added to the channel by admin.	system_add_to_channel	{"addedUserId":"8jx756z8z78figfywkuqb8996w","addedUsername":"matrix_matrix_b_","userId":"bmq7jiumpib3xdz3mx5iyo99ro","username":"admin"}		[]	[]	f
ogqep93g13rnfdgmj4dcg89t4h	1672416526198	1672416526198	0	0	f	8jx756z8z78figfywkuqb8996w	cxtmz3ubz3gfigd5m6prendmsw				matrix_matrix_b_ joined the team.	system_join_team	{"username":"matrix_matrix_b_"}		[]	[]	f
qu7tx5ndoiym7xt6uccyy73jgw	1672416526256	1672416526256	0	0	f	8jx756z8z78figfywkuqb8996w	73uy6kj1jb8wdqrf3ti6zies6r				matrix_matrix_b_ joined the channel.	system_join_channel	{"username":"matrix_matrix_b_"}		[]	[]	f
cywrh4itg7yttqjig1er1jmq8o	1672416613750	1672416613750	0	0	f	wwnaa6j41pbkje5qku89eej6de	pnzjpcnrmtdfdq37g3m9hcu3dy				Hello again		{"disable_group_highlight":true}		[]	[]	f
4xj66di6n78pmxbnrii5bcai1y	1672482826438	1672482826438	0	0	f	wwnaa6j41pbkje5qku89eej6de	pnzjpcnrmtdfdq37g3m9hcu3dy				I am here now		{"disable_group_highlight":true}		[]	[]	f
wzrinsz4df8iu8rsipmsz4hjfc	1672482888674	1672482888674	0	0	f	wwnaa6j41pbkje5qku89eej6de	1cma8yikrbnhbn65w3rfykwntc				Writing here now		{"disable_group_highlight":true}		[]	[]	f
tgbi9duuctnhijaodrduec8d1c	1672482901676	1672482901676	0	0	f	wwnaa6j41pbkje5qku89eej6de	wuo9s48usjrzdk3hxr93173rhr				write here 		{"disable_group_highlight":true}		[]	[]	f
7qwkyeju1bd19qa6p6cr4ip8ra	1672483013491	1672483013491	0	0	f	wwnaa6j41pbkje5qku89eej6de	surjpu98zpgamjbwhhyo5px9zy				Hi again		{"disable_group_highlight":true}		[]	[]	f
\.


--
-- Data for Name: preferences; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.preferences (userid, category, name, value) FROM stdin;
5bw66y36bff3umq1q57mfy4y5c	tutorial_step	5bw66y36bff3umq1q57mfy4y5c	0
0z4okgmv5lfhx3p0tf6pnpk8sk	tutorial_step	0z4okgmv5lfhx3p0tf6pnpk8sk	0
3zats68fztgu9mgu944a4t35so	tutorial_step	3zats68fztgu9mgu944a4t35so	0
bmq7jiumpib3xdz3mx5iyo99ro	channel_approximate_view_time		1672393343057
8ij6q13b67dhzko8cqha4rn1sa	tutorial_step	8ij6q13b67dhzko8cqha4rn1sa	0
goynmto1ubrnucswajybh3o4kc	tutorial_step	goynmto1ubrnucswajybh3o4kc	0
bmq7jiumpib3xdz3mx5iyo99ro	tutorial_step	bmq7jiumpib3xdz3mx5iyo99ro	999
wwnaa6j41pbkje5qku89eej6de	tutorial_step	wwnaa6j41pbkje5qku89eej6de	999
zr66z9nhxpyxixtgkwq9xydjxa	tutorial_step	zr66z9nhxpyxixtgkwq9xydjxa	0
8jx756z8z78figfywkuqb8996w	tutorial_step	8jx756z8z78figfywkuqb8996w	0
wwnaa6j41pbkje5qku89eej6de	channel_approximate_view_time		1672482835339
wwnaa6j41pbkje5qku89eej6de	direct_channel_show	8ij6q13b67dhzko8cqha4rn1sa	true
wwnaa6j41pbkje5qku89eej6de	channel_open_time	pnzjpcnrmtdfdq37g3m9hcu3dy	1672482983814
wwnaa6j41pbkje5qku89eej6de	direct_channel_show	zr66z9nhxpyxixtgkwq9xydjxa	true
wwnaa6j41pbkje5qku89eej6de	channel_open_time	surjpu98zpgamjbwhhyo5px9zy	1672482999455
\.


--
-- Data for Name: publicchannels; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.publicchannels (id, deleteat, teamid, displayname, name, header, purpose) FROM stdin;
cxtmz3ubz3gfigd5m6prendmsw	0	tgrw7sjgbiy1jggs3qg3m6zpee	Town Square	town-square		
73uy6kj1jb8wdqrf3ti6zies6r	0	tgrw7sjgbiy1jggs3qg3m6zpee	Off-Topic	off-topic		
1cma8yikrbnhbn65w3rfykwntc	0	fk9o6gdfcidxiyfeuqnwx5urey	Town Square	town-square		
wuo9s48usjrzdk3hxr93173rhr	0	fk9o6gdfcidxiyfeuqnwx5urey	Off-Topic	off-topic		
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
x51q8edte7dexy31j4f4nh9tde	s537n3t8zib1tx7eyd44qzqnbr	1672393387984	4825993387984	1672481698581	bmq7jiumpib3xdz3mx5iyo99ro		system_admin system_user	f	f	{"is_guest":"false","type":"UserAccessToken","user_access_token_id":"98yjyceocfb5mc3jaibtbmr1ph"}
3czosk8bajfebdt3wmo99euzyc	87rjg8m9p7n5zqpsw1iuymumoa	1672416562319	1675074786726	1672482797024	wwnaa6j41pbkje5qku89eej6de		system_user	f	f	{"browser":"Chrome/108.0","csrf":"qsqd75xtspnntdcgqeae1mqr8e","isMobile":"false","isOAuthUser":"false","isSaml":"false","is_guest":"false","os":"Mac OS","platform":"Macintosh"}
\.


--
-- Data for Name: sidebarcategories; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.sidebarcategories (id, userid, teamid, sortorder, sorting, type, displayname) FROM stdin;
g14c5kzw7ffm8dxx3ujxsdy8ae	8ij6q13b67dhzko8cqha4rn1sa	tgrw7sjgbiy1jggs3qg3m6zpee	0		favorites	Favorites
ki1xuz1uhb8mdcdyqzoa949wuo	8ij6q13b67dhzko8cqha4rn1sa	tgrw7sjgbiy1jggs3qg3m6zpee	10		channels	Channels
pc1oebbes3fnmrx3ajossafzra	8ij6q13b67dhzko8cqha4rn1sa	tgrw7sjgbiy1jggs3qg3m6zpee	20	recent	direct_messages	Direct Messages
t95yaksdftghtk8fhktfhkygya	goynmto1ubrnucswajybh3o4kc	tgrw7sjgbiy1jggs3qg3m6zpee	0		favorites	Favorites
kwx16bs19jd3tbhyh8iojn5kpw	goynmto1ubrnucswajybh3o4kc	tgrw7sjgbiy1jggs3qg3m6zpee	10		channels	Channels
ts1ikf4i4jgzbfsutd5nnnzihy	goynmto1ubrnucswajybh3o4kc	tgrw7sjgbiy1jggs3qg3m6zpee	20	recent	direct_messages	Direct Messages
mxotbqt65t818yj8ud684ydowa	wwnaa6j41pbkje5qku89eej6de	fk9o6gdfcidxiyfeuqnwx5urey	0		favorites	Favorites
3x9qz3yzctfkjktce7nomds7wy	wwnaa6j41pbkje5qku89eej6de	fk9o6gdfcidxiyfeuqnwx5urey	10		channels	Channels
eifqxu7prpr5unm56z5pxujeue	wwnaa6j41pbkje5qku89eej6de	fk9o6gdfcidxiyfeuqnwx5urey	20	recent	direct_messages	Direct Messages
m16e4j7rjjbk3khgyyfidq7bzw	zr66z9nhxpyxixtgkwq9xydjxa	tgrw7sjgbiy1jggs3qg3m6zpee	0		favorites	Favorites
9ygtq4y4ppng5dmrebkfgr6icc	zr66z9nhxpyxixtgkwq9xydjxa	tgrw7sjgbiy1jggs3qg3m6zpee	10		channels	Channels
rcxfbompbtfyixt6eo3kdaydko	zr66z9nhxpyxixtgkwq9xydjxa	tgrw7sjgbiy1jggs3qg3m6zpee	20	recent	direct_messages	Direct Messages
4ag7bmkfzfg85xw11uktark4eo	8jx756z8z78figfywkuqb8996w	tgrw7sjgbiy1jggs3qg3m6zpee	0		favorites	Favorites
1db4hwwwg3rrunjk99bk17a9cr	8jx756z8z78figfywkuqb8996w	tgrw7sjgbiy1jggs3qg3m6zpee	10		channels	Channels
wwg83fd1ot83bmzobynnnii1so	8jx756z8z78figfywkuqb8996w	tgrw7sjgbiy1jggs3qg3m6zpee	20	recent	direct_messages	Direct Messages
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
wwnaa6j41pbkje5qku89eej6de	away	f	1672481437127
bmq7jiumpib3xdz3mx5iyo99ro	offline	f	1672483282748
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
LastSecurityTime	1672479945682
\.


--
-- Data for Name: teammembers; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.teammembers (teamid, userid, roles, deleteat, schemeuser, schemeadmin, schemeguest) FROM stdin;
tgrw7sjgbiy1jggs3qg3m6zpee	bmq7jiumpib3xdz3mx5iyo99ro		0	t	t	f
tgrw7sjgbiy1jggs3qg3m6zpee	5bw66y36bff3umq1q57mfy4y5c		0	t	f	f
tgrw7sjgbiy1jggs3qg3m6zpee	0z4okgmv5lfhx3p0tf6pnpk8sk		0	t	f	f
tgrw7sjgbiy1jggs3qg3m6zpee	3zats68fztgu9mgu944a4t35so		0	t	f	f
tgrw7sjgbiy1jggs3qg3m6zpee	8ij6q13b67dhzko8cqha4rn1sa		0	t	f	f
tgrw7sjgbiy1jggs3qg3m6zpee	goynmto1ubrnucswajybh3o4kc		0	t	f	f
fk9o6gdfcidxiyfeuqnwx5urey	wwnaa6j41pbkje5qku89eej6de		0	t	t	f
tgrw7sjgbiy1jggs3qg3m6zpee	zr66z9nhxpyxixtgkwq9xydjxa		0	t	f	f
tgrw7sjgbiy1jggs3qg3m6zpee	8jx756z8z78figfywkuqb8996w		0	t	f	f
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.teams (id, createat, updateat, deleteat, displayname, name, description, email, type, companyname, alloweddomains, inviteid, allowopeninvite, lastteamiconupdate, schemeid, groupconstrained) FROM stdin;
tgrw7sjgbiy1jggs3qg3m6zpee	1598351837711	1598351837711	0	Test Team	test			O			5tdc6sxr43byufri3r6px9f9xo	f	0	\N	\N
fk9o6gdfcidxiyfeuqnwx5urey	1672415474108	1672415474108	0	demo	demo		bridgeuser1@localhost	O			eu6kyz3wtjbk3jcmnri1juzfwc	f	0	\N	\N
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
61ueoj83fp8gdbnooz9gu8mppe	topta3oxcirq5yckky8fpyujye	8ij6q13b67dhzko8cqha4rn1sa	bridge	t
yp5wwhqgjbfmxxs9gc7s43daee	g3paapkwjbygjf8sqfbqbg9cae	goynmto1ubrnucswajybh3o4kc	bridge	t
twwgm8xek3y6mqo4fdrgkouako	h7f59iofwif6jnwu6sp68im86y	zr66z9nhxpyxixtgkwq9xydjxa	bridge	t
abkqr56nifff9jg6hzpxcufqrh	5591heuy5jn7dg3a3aghs1otdr	8jx756z8z78figfywkuqb8996w	bridge	t
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
bmq7jiumpib3xdz3mx5iyo99ro	1598351769026	1598351847718	0	admin	$2a$10$dCK8unlOWxu7Ge1Fmeo70eaETqonsQC1mVbwnLi5lCH5ALbzKyqnO	\N		admin@localhost	f		Admin	User		system_admin system_user	f	{}	{"channel":"true","comments":"never","desktop":"mention","desktop_sound":"true","email":"true","first_name":"false","mention_keys":"","push":"mention","push_status":"away"}	1598351769026	0	0	en	{"automaticTimezone":"","manualTimezone":"","useAutomaticTimezone":"true"}	f	
8ij6q13b67dhzko8cqha4rn1sa	1672393388938	1672415742433	0	matrix_matrix_a	$2a$10$4vihwKvWDFI4JR7bBxlOM.txoDXuHJqst29IQr5NHueZsQTOVv56S	\N		devnull-w4ypshteuypq9qls@localhost	t		Matrix UserA			system_user	f	{}	{"channel":"true","comments":"never","desktop":"mention","desktop_sound":"true","email":"true","first_name":"false","mention_keys":"","push":"mention","push_status":"away"}	1672393388938	0	0	en	{"automaticTimezone":"","manualTimezone":"","useAutomaticTimezone":"true"}	f	
goynmto1ubrnucswajybh3o4kc	1672393389206	1672415742505	0	matrix_matrix_b	$2a$10$V6KDbafNnmPZrlF7S9NJcOEcr.yYa2ggAQD8Z2brxlpPaFPF1HvZW	\N		devnull-t-9bvmzc89cg4f4t@localhost	t		matrix_b			system_user	f	{}	{"channel":"true","comments":"never","desktop":"mention","desktop_sound":"true","email":"true","first_name":"false","mention_keys":"","push":"mention","push_status":"away"}	1672393389206	0	0	en	{"automaticTimezone":"","manualTimezone":"","useAutomaticTimezone":"true"}	f	
wwnaa6j41pbkje5qku89eej6de	1672415461749	1672415474152	0	bridgeuser1	$2a$10$Glvl.AcwoRkCC1MxrBGzXuaLJDpOzAkj/i8/i5fNtz8CNj4w/Hb.i	\N		bridgeuser1@localhost	f					system_user	t	{}	{"channel":"true","comments":"never","desktop":"mention","desktop_sound":"true","email":"true","first_name":"false","mention_keys":"","push":"mention","push_status":"away"}	1672415461749	0	0	en	{"automaticTimezone":"","manualTimezone":"","useAutomaticTimezone":"true"}	f	
zr66z9nhxpyxixtgkwq9xydjxa	1672416525626	1672481699184	0	matrix_matrix_a_	$2a$10$PUl9AWgYJyORQ/.ZoxYl3esxxoJc8Mr2dhZvmiwozHiZ5P0dPQDL6	\N		devnull-ow7onsm2odnj330d@localhost	t		Matrix UserA			system_user	f	{}	{"channel":"true","comments":"never","desktop":"mention","desktop_sound":"true","email":"true","first_name":"false","mention_keys":"","push":"mention","push_status":"away"}	1672416525626	0	0	en	{"automaticTimezone":"","manualTimezone":"","useAutomaticTimezone":"true"}	f	
8jx756z8z78figfywkuqb8996w	1672416525858	1672481699201	0	matrix_matrix_b_	$2a$10$xZpZcQkNQREGQeuDWaW.t.OPNoORc..YL.elYFC2RYxZfznZbrQHG	\N		devnull-p8xji-7myrvdr-g5@localhost	t		matrix_b			system_user	f	{}	{"channel":"true","comments":"never","desktop":"mention","desktop_sound":"true","email":"true","first_name":"false","mention_keys":"","push":"mention","push_status":"away"}	1672416525858	0	0	en	{"automaticTimezone":"","manualTimezone":"","useAutomaticTimezone":"true"}	f	
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

