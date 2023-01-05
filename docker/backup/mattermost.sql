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
zactz9hmrpy48kbw3yxaaf8m8c	1672856703564	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	nuj8b3qqzby83poe5s7eowrroc
9e1kibi547f5tfpc9zqe8zyegc	1672856703581	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
a856uqnmc7nx586mw59ahpn7go	1672856703808	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/1fgsimi9s3rmjxzxsaeqrr66ko/email/verify/member	user verified	172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
4btb459kbtr15yxi1o6gyrbuzh	1672856703817	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/1fgsimi9s3rmjxzxsaeqrr66ko/tokens		172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
cmaotobz7jni5fnm6bjkmdqobr	1672856703830	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/1fgsimi9s3rmjxzxsaeqrr66ko/tokens	success - token_id=6uz914r9ojrktq1xranio359ie	172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
bti74sgerf8n9qg8tq3q7n8s1r	1672856704055	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=1fgsimi9s3rmjxzxsaeqrr66ko	172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
811trmgf5tbub8j7fbmuyjbkoe	1672856704063	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/kgr5hfwxy78k5n9gfkdhcscdoc/email/verify/member	user verified	172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
y3b5y75yf3dffgw7wg1u5wcnye	1672856704110	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/kgr5hfwxy78k5n9gfkdhcscdoc/tokens		172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
5ub8aapg9pratghgjudynuzt9o	1672856704129	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/kgr5hfwxy78k5n9gfkdhcscdoc/tokens	success - token_id=spc9donsrtbduj8y15pck5nq9w	172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
tw7ona3om7b55bohcngbu3fjxe	1672856704223	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/kgr5hfwxy78k5n9gfkdhcscdoc/patch		172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
nerjtnj9dinjm8xm7dm19nt78w	1672856704321	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=kgr5hfwxy78k5n9gfkdhcscdoc	172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
3cxkb8ki3jgmxe1rbtai7qa61h	1672856704336	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/1fgsimi9s3rmjxzxsaeqrr66ko/patch		172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
sht9uwb3y7yajp4hwosh5cqbky	1672856704355	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=1fgsimi9s3rmjxzxsaeqrr66ko	172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
nx1in638afyifnktguoc3x4nsr	1672856704406	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=kgr5hfwxy78k5n9gfkdhcscdoc	172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
z77sdy9gjtbojyho9dfb35mtha	1672856708593	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
wqcujqkqd3dzxfm37cb5dcfexw	1672856708595	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
8gfx37re3pdr7p4rgzw99ymz1h	1672856708726	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/1fgsimi9s3rmjxzxsaeqrr66ko/patch		172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
msnmx87hm3r13cdizmauomr4bw	1672856708741	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=1fgsimi9s3rmjxzxsaeqrr66ko	172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
q7a4uwp7mf8rjxtcsxn7s897tc	1672856708762	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/kgr5hfwxy78k5n9gfkdhcscdoc/patch		172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
ucnxhb964jrt8xkp3fsdjuqqwc	1672856708766	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/kgr5hfwxy78k5n9gfkdhcscdoc/patch		172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
eg4y3rrycjnfxbptem6ifiw13y	1672856708771	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/1fgsimi9s3rmjxzxsaeqrr66ko/patch		172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
efuf11mmjinrz8h16tr11z6kho	1672856708789	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=kgr5hfwxy78k5n9gfkdhcscdoc	172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
48sjb45eb3yiueutai5s3m5xaw	1672856708789	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=kgr5hfwxy78k5n9gfkdhcscdoc	172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
zuwyupnfw7gw5myrq7q9mxy5sa	1672856708798	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=1fgsimi9s3rmjxzxsaeqrr66ko	172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
3r8u7eedjfdid8ne5fm3e6an3o	1672917022523		/api/v4/users/login	attempt - login_id=admin	172.16.238.1	
nmfhdp8sg3gbf8jb19jh5syo6w	1672917022722	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/login	authenticated	172.16.238.1	
r9byen8tbp8jmbpxcwmur8hdmh	1672917022756	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/login	success session_user=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	je8dz9pbt7gu58bqkgnh51nyuw
tykkdiusofnx3qcfkjrtmydnue	1672921754651	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/logout		172.16.238.1	je8dz9pbt7gu58bqkgnh51nyuw
ruot6puzwjbwxcyax5hcdoph9r	1672921832398	98kwr77m4jgwmbdgygknaowcch	/api/v4/users/login	attempt - login_id=	172.16.238.1	
oqh8z37dpfr3xem498qg31iq1e	1672921832554	98kwr77m4jgwmbdgygknaowcch	/api/v4/users/login	authenticated	172.16.238.1	
1rwnwb3affbn7ximf3nrpefjke	1672921832566	98kwr77m4jgwmbdgygknaowcch	/api/v4/users/login	success session_user=98kwr77m4jgwmbdgygknaowcch	172.16.238.1	6z3mbuwc7pfgidai83bcp19bae
knsntsp4bif6ipwmt9qi1hwgby	1672921952058	98kwr77m4jgwmbdgygknaowcch	/api/v4/users/logout		172.16.238.1	6z3mbuwc7pfgidai83bcp19bae
3465pfqbiif87e54xhtfjg9cda	1672921969441		/api/v4/users/login	attempt - login_id=admin	172.16.238.1	
5g4pwhuyofd5ux3peu6ngiegqc	1672921969537	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/login	authenticated	172.16.238.1	
ydk4jk7wu38h8fpkzec344ty6y	1672921969542	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/login	success session_user=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	iaj9hrfd538z8erqe7u7arc7do
egophrofk3bz5pxb8z8d4zp4qc	1672922020824	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/logout		172.16.238.1	iaj9hrfd538z8erqe7u7arc7do
nggkbgawh7f9fpbzy17pg74amh	1672922027099		/api/v4/users/login	attempt - login_id=user1	172.16.238.1	
8a71o1ww1b8q9qo7jn76si146o	1672922027323	98kwr77m4jgwmbdgygknaowcch	/api/v4/users/login	authenticated	172.16.238.1	
dqnhchq97idxmx4y6u83woffhr	1672922027331	98kwr77m4jgwmbdgygknaowcch	/api/v4/users/login	success session_user=98kwr77m4jgwmbdgygknaowcch	172.16.238.1	dy53me3siffkjenk5uha5cgxdr
9h67e4ag9fbgbbrkgdebfho78r	1672922039552	98kwr77m4jgwmbdgygknaowcch	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=98kwr77m4jgwmbdgygknaowcch	172.16.238.1	dy53me3siffkjenk5uha5cgxdr
61yxw1p16jytdnb9emz6g8hkww	1672922076899	98kwr77m4jgwmbdgygknaowcch	/api/v4/channels/dckusnmodbnubf7hcu369adaio/convert	name=off-topic	172.16.238.1	dy53me3siffkjenk5uha5cgxdr
shgpcroqnb8sjgfga86mn8rj5a	1672922248231	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/kgr5hfwxy78k5n9gfkdhcscdoc/patch		172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
o98yg7xcijgix8smccj1gxh4yw	1672922248396	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/she685ewdtyq7m7jgmys7zoqmr/tokens	success - token_id=j9jxpacsy3d4zmx4pu1qjonfua	172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
thitpz4r1fgtzxu15jb8gw9hda	1672922248081	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
amzd1hgpwbbpfkuyya7o69y11c	1672922248083	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
j5xa6jdga7dezntop4wzfn7byo	1672922248314	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=kgr5hfwxy78k5n9gfkdhcscdoc	172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
j6cxxiwfotfxi8z7indsjyzz4o	1672922248381	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/she685ewdtyq7m7jgmys7zoqmr/tokens		172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
63xz13ycffbpmdyd7gpoq3he8e	1672922248532	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/1fgsimi9s3rmjxzxsaeqrr66ko/patch		172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
q4utksz9iiba9k3cuh9s8iorkr	1672922248531	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/kgr5hfwxy78k5n9gfkdhcscdoc/patch		172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
4irsiw6jabdqdbrqito1s76khh	1672922248572	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=1fgsimi9s3rmjxzxsaeqrr66ko	172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
kpxwekusaj8ttdt96w36xx6g9h	1672922248605	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=she685ewdtyq7m7jgmys7zoqmr	172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
s7y85jr9mpyfmgtuthcged51xa	1672922248228	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/1fgsimi9s3rmjxzxsaeqrr66ko/patch		172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
hem9ubony3n9jprk1a49cr8rdc	1672922248312	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=1fgsimi9s3rmjxzxsaeqrr66ko	172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
pmeddj69i7njfb994a1dy839ko	1672922248366	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/she685ewdtyq7m7jgmys7zoqmr/email/verify/member	user verified	172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
36gzbe3jgpnspypcoddny9am5h	1672922248931	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=she685ewdtyq7m7jgmys7zoqmr	172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
wrbw946awjrx3pcograqff8f8a	1672922248542	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/she685ewdtyq7m7jgmys7zoqmr/patch		172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
b8odxth9nif9mbaf5w8785g6gw	1672922248572	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=kgr5hfwxy78k5n9gfkdhcscdoc	172.16.238.1	1kcmnxa9kpgamkpzi5rzjwqdrr
ki8o1ceeq78gfjhxqree5nsu4w	1672922742637	98kwr77m4jgwmbdgygknaowcch	/api/v4/users/logout		172.16.238.1	dy53me3siffkjenk5uha5cgxdr
ixbmss5h13rgiqqgrrybjuaz6y	1672922757644		/api/v4/users/login	attempt - login_id=admin	172.16.238.1	
dpfyt884zpguxdijju1cf9yjsa	1672922757744	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/login	authenticated	172.16.238.1	
msdd9x4n3tgkbfx9tqmpxmgfre	1672922757750	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/login	success session_user=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	371b6ouhibgdzy5yuoend8knhw
1691uz9hntyjtns3emgkfd7p1y	1672922800570	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/teams/tgrw7sjgbiy1jggs3qg3m6zpee/patch		172.16.238.1	371b6ouhibgdzy5yuoend8knhw
gush415e7pgpipbgs5kis4ydrr	1672922833180	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/teams/tgrw7sjgbiy1jggs3qg3m6zpee/patch		172.16.238.1	371b6ouhibgdzy5yuoend8knhw
n3dyu6ts8384fdozzkjfwjx5sa	1672922930353	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/5bw66y36bff3umq1q57mfy4y5c/password	attempted	172.16.238.1	371b6ouhibgdzy5yuoend8knhw
rt6gbrcu9tyatnor81ydjjfr6y	1672922930448	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/5bw66y36bff3umq1q57mfy4y5c/password	completed	172.16.238.1	371b6ouhibgdzy5yuoend8knhw
eij5gdeknbgn3pmcoju6d8cmry	1672922973255	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/logout		172.16.238.1	371b6ouhibgdzy5yuoend8knhw
51tn6ws5ppntfnzojbt584brno	1672922989984		/api/v4/users/login	attempt - login_id=mattermost_a	172.16.238.1	
mhbpxhk9wbf78jh8toocpitbrw	1672922990084		/api/v4/users/login	failure - login_id=mattermost_a	172.16.238.1	
x9yazzb3zibw7cgrjopey7jk8o	1672923004526		/api/v4/users/login	attempt - login_id=mattermost_a	172.16.238.1	
tt1p898jgffmbpk1tkds5bcp9w	1672923004632	5bw66y36bff3umq1q57mfy4y5c	/api/v4/users/login	authenticated	172.16.238.1	
uhwacyqqmidhxfxqaamkhdto1y	1672923004643	5bw66y36bff3umq1q57mfy4y5c	/api/v4/users/login	success session_user=5bw66y36bff3umq1q57mfy4y5c	172.16.238.1	dj4cashhdfycxjyxdyz1eh63ma
4efg9gzatiguzy4uw1de8w5w9c	1672923085587	5bw66y36bff3umq1q57mfy4y5c	/api/v4/channels	name=bugs-in-bridge	172.16.238.1	dj4cashhdfycxjyxdyz1eh63ma
oarwnhj9i3rpirmxudbppm4hfw	1672923120171	5bw66y36bff3umq1q57mfy4y5c	/api/v4/channels/g18pe3wojtr65rnxnm4ugmuq4h/members	name=bugs-in-bridge user_id=98kwr77m4jgwmbdgygknaowcch	172.16.238.1	dj4cashhdfycxjyxdyz1eh63ma
5p4f1e83ctbffxjzmgnswsc9aa	1672923120185	5bw66y36bff3umq1q57mfy4y5c	/api/v4/channels/g18pe3wojtr65rnxnm4ugmuq4h/members	name=bugs-in-bridge user_id=she685ewdtyq7m7jgmys7zoqmr	172.16.238.1	dj4cashhdfycxjyxdyz1eh63ma
sqqxtmmnp3gdtkaazgtg6hp5uw	1672923120281	5bw66y36bff3umq1q57mfy4y5c	/api/v4/channels/g18pe3wojtr65rnxnm4ugmuq4h/members	name=bugs-in-bridge user_id=1fgsimi9s3rmjxzxsaeqrr66ko	172.16.238.1	dj4cashhdfycxjyxdyz1eh63ma
a5imaz169bdyuxdbxessss5e8o	1672923120317	5bw66y36bff3umq1q57mfy4y5c	/api/v4/channels/g18pe3wojtr65rnxnm4ugmuq4h/members	name=bugs-in-bridge user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	dj4cashhdfycxjyxdyz1eh63ma
ekj1hxirktgeumdifmzbwe1czr	1672923120328	5bw66y36bff3umq1q57mfy4y5c	/api/v4/channels/g18pe3wojtr65rnxnm4ugmuq4h/members	name=bugs-in-bridge user_id=3zats68fztgu9mgu944a4t35so	172.16.238.1	dj4cashhdfycxjyxdyz1eh63ma
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
cxtmz3ubz3gfigd5m6prendmsw	1fgsimi9s3rmjxzxsaeqrr66ko	1672856703965	\N
73uy6kj1jb8wdqrf3ti6zies6r	1fgsimi9s3rmjxzxsaeqrr66ko	1672856703992	\N
cxtmz3ubz3gfigd5m6prendmsw	kgr5hfwxy78k5n9gfkdhcscdoc	1672856704278	\N
73uy6kj1jb8wdqrf3ti6zies6r	kgr5hfwxy78k5n9gfkdhcscdoc	1672856704314	\N
73uy6kj1jb8wdqrf3ti6zies6r	kgr5hfwxy78k5n9gfkdhcscdoc	1672856704321	\N
9eiccer1gfbzzpf8yfbze74n3e	98kwr77m4jgwmbdgygknaowcch	1672921846309	\N
dckusnmodbnubf7hcu369adaio	98kwr77m4jgwmbdgygknaowcch	1672921846347	\N
cxtmz3ubz3gfigd5m6prendmsw	98kwr77m4jgwmbdgygknaowcch	1672922006346	\N
73uy6kj1jb8wdqrf3ti6zies6r	98kwr77m4jgwmbdgygknaowcch	1672922006380	\N
cxtmz3ubz3gfigd5m6prendmsw	she685ewdtyq7m7jgmys7zoqmr	1672922248602	\N
cxtmz3ubz3gfigd5m6prendmsw	she685ewdtyq7m7jgmys7zoqmr	1672922248631	\N
73uy6kj1jb8wdqrf3ti6zies6r	she685ewdtyq7m7jgmys7zoqmr	1672922248792	\N
g18pe3wojtr65rnxnm4ugmuq4h	5bw66y36bff3umq1q57mfy4y5c	1672923085567	\N
g18pe3wojtr65rnxnm4ugmuq4h	98kwr77m4jgwmbdgygknaowcch	1672923120164	\N
g18pe3wojtr65rnxnm4ugmuq4h	she685ewdtyq7m7jgmys7zoqmr	1672923120166	\N
g18pe3wojtr65rnxnm4ugmuq4h	1fgsimi9s3rmjxzxsaeqrr66ko	1672923120265	\N
g18pe3wojtr65rnxnm4ugmuq4h	bmq7jiumpib3xdz3mx5iyo99ro	1672923120312	\N
g18pe3wojtr65rnxnm4ugmuq4h	3zats68fztgu9mgu944a4t35so	1672923120313	\N
\.


--
-- Data for Name: channelmembers; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.channelmembers (channelid, userid, roles, lastviewedat, msgcount, mentioncount, notifyprops, lastupdateat, schemeuser, schemeadmin, schemeguest) FROM stdin;
cxtmz3ubz3gfigd5m6prendmsw	0z4okgmv5lfhx3p0tf6pnpk8sk		0	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1598351852017	t	f	f
73uy6kj1jb8wdqrf3ti6zies6r	0z4okgmv5lfhx3p0tf6pnpk8sk		0	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1598351852041	t	f	f
cxtmz3ubz3gfigd5m6prendmsw	3zats68fztgu9mgu944a4t35so		0	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1598351852017	t	f	f
73uy6kj1jb8wdqrf3ti6zies6r	kgr5hfwxy78k5n9gfkdhcscdoc		0	0	1	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672856704360	t	f	f
cxtmz3ubz3gfigd5m6prendmsw	kgr5hfwxy78k5n9gfkdhcscdoc		1672856706939	4	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672856706939	t	f	f
73uy6kj1jb8wdqrf3ti6zies6r	3zats68fztgu9mgu944a4t35so		1672856707526	2	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672856707526	t	f	f
cxtmz3ubz3gfigd5m6prendmsw	1fgsimi9s3rmjxzxsaeqrr66ko		1672856708115	6	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672856708115	t	f	f
73uy6kj1jb8wdqrf3ti6zies6r	1fgsimi9s3rmjxzxsaeqrr66ko		1672856710756	3	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672856710756	t	f	f
g18pe3wojtr65rnxnm4ugmuq4h	5bw66y36bff3umq1q57mfy4y5c		1672923135329	1	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672923135329	t	t	f
73uy6kj1jb8wdqrf3ti6zies6r	she685ewdtyq7m7jgmys7zoqmr		0	0	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672922248719	t	f	f
cxtmz3ubz3gfigd5m6prendmsw	bmq7jiumpib3xdz3mx5iyo99ro		1672856708115	6	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672856708115	t	f	f
cxtmz3ubz3gfigd5m6prendmsw	98kwr77m4jgwmbdgygknaowcch		1672922547481	9	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672922547481	t	f	f
73uy6kj1jb8wdqrf3ti6zies6r	5bw66y36bff3umq1q57mfy4y5c		1672923027698	5	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672923027698	t	f	f
73uy6kj1jb8wdqrf3ti6zies6r	98kwr77m4jgwmbdgygknaowcch		1672922654416	4	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672922654416	t	f	f
73uy6kj1jb8wdqrf3ti6zies6r	bmq7jiumpib3xdz3mx5iyo99ro		1672922654416	4	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672922654416	t	f	f
g18pe3wojtr65rnxnm4ugmuq4h	98kwr77m4jgwmbdgygknaowcch		0	0	1	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672923120265	t	f	f
g18pe3wojtr65rnxnm4ugmuq4h	she685ewdtyq7m7jgmys7zoqmr		0	0	1	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672923120332	t	f	f
cxtmz3ubz3gfigd5m6prendmsw	she685ewdtyq7m7jgmys7zoqmr		0	0	2	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672922547495	t	f	f
cxtmz3ubz3gfigd5m6prendmsw	5bw66y36bff3umq1q57mfy4y5c		1672922547481	9	0	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672922547481	t	f	f
g18pe3wojtr65rnxnm4ugmuq4h	1fgsimi9s3rmjxzxsaeqrr66ko		0	0	1	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672923120354	t	f	f
g18pe3wojtr65rnxnm4ugmuq4h	3zats68fztgu9mgu944a4t35so		0	0	1	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672923120359	t	f	f
g18pe3wojtr65rnxnm4ugmuq4h	bmq7jiumpib3xdz3mx5iyo99ro		0	0	1	{"desktop":"default","email":"default","ignore_channel_mentions":"default","mark_unread":"all","push":"default"}	1672923120383	t	f	f
\.


--
-- Data for Name: channels; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.channels (id, createat, updateat, deleteat, teamid, type, displayname, name, header, purpose, lastpostat, totalmsgcount, extraupdateat, creatorid, schemeid, groupconstrained) FROM stdin;
dckusnmodbnubf7hcu369adaio	1672921846260	1672922076863	0	7jenmotdwfdq7mmci7zz7hfpze	P	Off-Topic	off-topic			1672922076871	1	0		\N	\N
9eiccer1gfbzzpf8yfbze74n3e	1672921846247	1672921846247	0	7jenmotdwfdq7mmci7zz7hfpze	O	Town Square	town-square			1672922135142	0	0		\N	\N
cxtmz3ubz3gfigd5m6prendmsw	1598351837713	1598351837713	0	tgrw7sjgbiy1jggs3qg3m6zpee	O	Town Square	town-square			1672922547481	9	0		\N	\N
73uy6kj1jb8wdqrf3ti6zies6r	1598351837717	1598351837717	0	tgrw7sjgbiy1jggs3qg3m6zpee	O	Off-Topic	off-topic			1672923027698	5	0		\N	\N
g18pe3wojtr65rnxnm4ugmuq4h	1672923085547	1672923085547	0	tgrw7sjgbiy1jggs3qg3m6zpee	O	Bugs in bridge	bugs-in-bridge			1672923135329	1	0	5bw66y36bff3umq1q57mfy4y5c		f
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
kpadhxdtotddukna1hnf993bir	3zats68fztgu9mgu944a4t35so	7qj53zemsbnzdgad76g9ifw6hc	1672856707505	1672856707505	0	20230104/teams/noteam/channels/73uy6kj1jb8wdqrf3ti6zies6r/users/3zats68fztgu9mgu944a4t35so/kpadhxdtotddukna1hnf993bir/filename			filename		11		0	0	f
neqkjkfddigrpbn13jtppboecw	1fgsimi9s3rmjxzxsaeqrr66ko	op4mz46j4pywu8at8f9k5hk8wy	1672856708099	1672856708099	0	20230104/teams/noteam/channels/cxtmz3ubz3gfigd5m6prendmsw/users/1fgsimi9s3rmjxzxsaeqrr66ko/neqkjkfddigrpbn13jtppboecw/mydata			mydata		8		0	0	f
t5mx13mgzby65be4tgz33qnppc	98kwr77m4jgwmbdgygknaowcch	grcxd88ak7rsxpia59fadzb7aa	1672922641890	1672922641890	0	20230105/teams/noteam/channels/73uy6kj1jb8wdqrf3ti6zies6r/users/98kwr77m4jgwmbdgygknaowcch/t5mx13mgzby65be4tgz33qnppc/Testing_in_VS_Code.png	20230105/teams/noteam/channels/73uy6kj1jb8wdqrf3ti6zies6r/users/98kwr77m4jgwmbdgygknaowcch/t5mx13mgzby65be4tgz33qnppc/Testing_in_VS_Code_thumb.jpg	20230105/teams/noteam/channels/73uy6kj1jb8wdqrf3ti6zies6r/users/98kwr77m4jgwmbdgygknaowcch/t5mx13mgzby65be4tgz33qnppc/Testing_in_VS_Code_preview.jpg	Testing_in_VS_Code.png	png	172914	image/png	993	533	t
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
az6m9wg69jdcmxf1f4sskuf77e	expiry_notify	0	1672917590506	1672917591360	1672917591367	success	0	{}
hyxbwtfw4tbgzy4kqiem47jhya	expiry_notify	0	1672918190122	1672918191169	1672918191177	success	0	{}
iepq4435d7fe8cbhemip3rt4rr	expiry_notify	0	1672918789735	1672918790998	1672918791005	success	0	{}
gpg3g756c3yxtrxb37sfxwkaoh	expiry_notify	0	1672919389360	1672919390767	1672919390772	success	0	{}
mzokxwhjhfrudr9skdxhp6uxuc	expiry_notify	0	1672919988970	1672919990571	1672919990576	success	0	{}
dq3p5iox8jgnikqrfk6rfnjd7h	expiry_notify	0	1672920588620	1672920590409	1672920590418	success	0	{}
imod9kjm13nfzdcrbmz9kcsxur	expiry_notify	0	1672921188247	1672921190187	1672921190194	success	0	{}
oifqe37zkpyt5ejqs85zp69s4e	expiry_notify	0	1672921787897	1672921790060	1672921790068	success	0	{}
musog89wjpdo3pj1oazrrpucfr	expiry_notify	0	1672922387523	1672922389874	1672922389879	success	0	{}
ekftspmuytbu3x399egkqb57ah	expiry_notify	0	1672922987184	1672922989745	1672922989752	success	0	{}
r7ofowkaeidfx88x47wu7o3wmc	expiry_notify	0	1672923586796	1672923589547	1672923589553	success	0	{}
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
18k3695ojtrhfqob4fyms69ciw	1672856703968	1672856703968	0	0	f	1fgsimi9s3rmjxzxsaeqrr66ko	cxtmz3ubz3gfigd5m6prendmsw				matrix_matrix_a joined the team.	system_join_team	{"username":"matrix_matrix_a"}		[]	[]	f
98hfz3hfotdbpebfmpuaxtm47w	1672856703994	1672856703994	0	0	f	1fgsimi9s3rmjxzxsaeqrr66ko	73uy6kj1jb8wdqrf3ti6zies6r				matrix_matrix_a joined the channel.	system_join_channel	{"username":"matrix_matrix_a"}		[]	[]	f
rgumdwrdrpffzp3fuyzmqgda7c	1672856704279	1672856704279	0	0	f	kgr5hfwxy78k5n9gfkdhcscdoc	cxtmz3ubz3gfigd5m6prendmsw				matrix_matrix_b joined the team.	system_join_team	{"username":"matrix_matrix_b"}		[]	[]	f
rangim3hatnypxq6o49qypjh1y	1672856704327	1672856704327	0	0	f	kgr5hfwxy78k5n9gfkdhcscdoc	73uy6kj1jb8wdqrf3ti6zies6r				matrix_matrix_b joined the channel.	system_join_channel	{"username":"matrix_matrix_b"}		[]	[]	f
rrorpwj3ttfptfqm64s4duapgy	1672856704323	1672856704323	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	73uy6kj1jb8wdqrf3ti6zies6r				matrix_matrix_b added to the channel by admin.	system_add_to_channel	{"addedUserId":"kgr5hfwxy78k5n9gfkdhcscdoc","addedUsername":"matrix_matrix_b","userId":"bmq7jiumpib3xdz3mx5iyo99ro","username":"admin"}		[]	[]	f
zaqw6nbri7b7uyahc8je5ms4jc	1672856705901	1672856705901	0	0	f	5bw66y36bff3umq1q57mfy4y5c	cxtmz3ubz3gfigd5m6prendmsw				test		{}		[]	[]	f
7azm5pwxk3nbdx8ixpqir5draa	1672856706384	1672856706384	0	0	f	1fgsimi9s3rmjxzxsaeqrr66ko	cxtmz3ubz3gfigd5m6prendmsw				test2		{}		[]	[]	f
pi3xicw5r78q9bnties3txu1th	1672856706470	1672856706470	0	0	f	5bw66y36bff3umq1q57mfy4y5c	cxtmz3ubz3gfigd5m6prendmsw				# Header\n\n**bold**		{}		[]	[]	f
cn1xnusgrtbo3btpidqpwmttca	1672856706939	1672856706939	0	0	f	kgr5hfwxy78k5n9gfkdhcscdoc	cxtmz3ubz3gfigd5m6prendmsw				Header\n======\n\n**Bolded text**		{}		[]	[]	f
debuqhoasjgktrzxtdqppwku5o	1672856707022	1672856707022	0	0	f	5bw66y36bff3umq1q57mfy4y5c	73uy6kj1jb8wdqrf3ti6zies6r				*hi me*	me	{"message":"hi me"}		[]	[]	f
1pe3kybx5tyo9jiq3bify8ptrh	1672856707403	1672856707403	0	0	f	1fgsimi9s3rmjxzxsaeqrr66ko	cxtmz3ubz3gfigd5m6prendmsw				*test*	me	{"message":"test"}		[]	[]	f
7qj53zemsbnzdgad76g9ifw6hc	1672856707526	1672856707526	0	0	f	3zats68fztgu9mgu944a4t35so	73uy6kj1jb8wdqrf3ti6zies6r				filename		{}		[]	["kpadhxdtotddukna1hnf993bir"]	f
op4mz46j4pywu8at8f9k5hk8wy	1672856708115	1672856708115	0	0	f	1fgsimi9s3rmjxzxsaeqrr66ko	cxtmz3ubz3gfigd5m6prendmsw						{}		[]	["neqkjkfddigrpbn13jtppboecw"]	f
96xmitp7qjnu389ecctrja49kr	1672856710756	1672856710756	0	0	f	1fgsimi9s3rmjxzxsaeqrr66ko	73uy6kj1jb8wdqrf3ti6zies6r				hidden message		{}		[]	[]	f
frbqs14mqbykjr5q35n59s9sko	1672921846313	1672921846313	0	0	f	98kwr77m4jgwmbdgygknaowcch	9eiccer1gfbzzpf8yfbze74n3e				user1 joined the team.	system_join_team	{"username":"user1"}		[]	[]	f
ndech86d9briprnyb4mhdapmcr	1672921846351	1672921846351	0	0	f	98kwr77m4jgwmbdgygknaowcch	dckusnmodbnubf7hcu369adaio				user1 joined the channel.	system_join_channel	{"username":"user1"}		[]	[]	f
suiocyjea3fe5mhucpk7rngg3h	1672922006348	1672922006348	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	cxtmz3ubz3gfigd5m6prendmsw				user1 added to the team by admin.	system_add_to_team	{"addedUserId":"98kwr77m4jgwmbdgygknaowcch","addedUsername":"user1","userId":"bmq7jiumpib3xdz3mx5iyo99ro","username":"admin"}		[]	[]	f
kusfngm4xtn9mbigjfmbzyqopw	1672922006383	1672922006383	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	73uy6kj1jb8wdqrf3ti6zies6r				user1 added to the channel by admin.	system_add_to_channel	{"addedUserId":"98kwr77m4jgwmbdgygknaowcch","addedUsername":"user1","userId":"bmq7jiumpib3xdz3mx5iyo99ro","username":"admin"}		[]	[]	f
81x8fwbat3n38eikpndaapuj9c	1672922076871	1672922076871	0	0	f	98kwr77m4jgwmbdgygknaowcch	dckusnmodbnubf7hcu369adaio				This channel has been converted to a Private Channel.	system_change_chan_privacy	{"username":"user1"}		[]	[]	f
kf5pow5zn3ysundqnryufqsyjy	1672922135142	1672922135142	0	0	f	98kwr77m4jgwmbdgygknaowcch	9eiccer1gfbzzpf8yfbze74n3e				user1 left the team.	system_leave_team	{"username":"user1"}		[]	[]	f
sshopdjyojrtjmn3zqjbhpk8ie	1672922164548	1672922164548	0	0	f	98kwr77m4jgwmbdgygknaowcch	cxtmz3ubz3gfigd5m6prendmsw				Hi I am writing now 		{"disable_group_highlight":true}		[]	[]	f
1rgwxi9fnbdifr7md7zf1rsnnr	1672922248606	1672922248606	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	cxtmz3ubz3gfigd5m6prendmsw				matrix_user1 added to the channel by admin.	system_add_to_channel	{"addedUserId":"she685ewdtyq7m7jgmys7zoqmr","addedUsername":"matrix_user1","userId":"bmq7jiumpib3xdz3mx5iyo99ro","username":"admin"}		[]	[]	f
6inf8oagn3fsfgmrkiuu1uedhe	1672922248660	1672922248660	0	0	f	she685ewdtyq7m7jgmys7zoqmr	cxtmz3ubz3gfigd5m6prendmsw				matrix_user1 joined the team.	system_join_team	{"username":"matrix_user1"}		[]	[]	f
cyu4bcmurprymre6ofr6b1drfr	1672922248798	1672922248798	0	0	f	she685ewdtyq7m7jgmys7zoqmr	73uy6kj1jb8wdqrf3ti6zies6r				matrix_user1 joined the channel.	system_join_channel	{"username":"matrix_user1"}		[]	[]	f
7op8pa1a43rbtmi5bscf41oefw	1672922287657	1672922287657	0	0	f	98kwr77m4jgwmbdgygknaowcch	cxtmz3ubz3gfigd5m6prendmsw				Like this channel		{"disable_group_highlight":true}		[]	[]	f
os6sm85ooiy68go7b4uqibhgdy	1672922547481	1672922547481	0	0	f	98kwr77m4jgwmbdgygknaowcch	cxtmz3ubz3gfigd5m6prendmsw				Are you online @matrix_user1 ?		{"disable_group_highlight":true}		[]	[]	f
grcxd88ak7rsxpia59fadzb7aa	1672922654416	1672922654416	0	0	f	98kwr77m4jgwmbdgygknaowcch	73uy6kj1jb8wdqrf3ti6zies6r				A program		{"disable_group_highlight":true}		[]	["t5mx13mgzby65be4tgz33qnppc"]	f
hp4449juf7d8xc591q3rnejfcc	1672923027698	1672923027698	0	0	f	5bw66y36bff3umq1q57mfy4y5c	73uy6kj1jb8wdqrf3ti6zies6r				Nice		{"disable_group_highlight":true}		[]	[]	f
ddxjx3ynkfds5gaqymm8x8jiwr	1672923085571	1672923085571	0	0	f	5bw66y36bff3umq1q57mfy4y5c	g18pe3wojtr65rnxnm4ugmuq4h				mattermost_a joined the channel.	system_join_channel	{"username":"mattermost_a"}		[]	[]	f
39k1ghs65fgt8kzttx7fkpn75y	1672923120172	1672923120172	0	0	f	5bw66y36bff3umq1q57mfy4y5c	g18pe3wojtr65rnxnm4ugmuq4h				user1 added to the channel by mattermost_a.	system_add_to_channel	{"addedUserId":"98kwr77m4jgwmbdgygknaowcch","addedUsername":"user1","userId":"5bw66y36bff3umq1q57mfy4y5c","username":"mattermost_a"}		[]	[]	f
aiqniqrnppns9r76nqm7meiydr	1672923120190	1672923120190	0	0	f	5bw66y36bff3umq1q57mfy4y5c	g18pe3wojtr65rnxnm4ugmuq4h				matrix_user1 added to the channel by mattermost_a.	system_add_to_channel	{"addedUserId":"she685ewdtyq7m7jgmys7zoqmr","addedUsername":"matrix_user1","userId":"5bw66y36bff3umq1q57mfy4y5c","username":"mattermost_a"}		[]	[]	f
qbkfa8qc1trxmyx6b3m1wgizda	1672923120283	1672923120283	0	0	f	5bw66y36bff3umq1q57mfy4y5c	g18pe3wojtr65rnxnm4ugmuq4h				matrix_matrix_a added to the channel by mattermost_a.	system_add_to_channel	{"addedUserId":"1fgsimi9s3rmjxzxsaeqrr66ko","addedUsername":"matrix_matrix_a","userId":"5bw66y36bff3umq1q57mfy4y5c","username":"mattermost_a"}		[]	[]	f
d3ke1cnikfbe7pwjozzdypzkur	1672923120319	1672923120319	0	0	f	5bw66y36bff3umq1q57mfy4y5c	g18pe3wojtr65rnxnm4ugmuq4h				admin added to the channel by mattermost_a.	system_add_to_channel	{"addedUserId":"bmq7jiumpib3xdz3mx5iyo99ro","addedUsername":"admin","userId":"5bw66y36bff3umq1q57mfy4y5c","username":"mattermost_a"}		[]	[]	f
888qct7tebdopchaaj7qsu89ge	1672923120329	1672923120329	0	0	f	5bw66y36bff3umq1q57mfy4y5c	g18pe3wojtr65rnxnm4ugmuq4h				mattermost_b added to the channel by mattermost_a.	system_add_to_channel	{"addedUserId":"3zats68fztgu9mgu944a4t35so","addedUsername":"mattermost_b","userId":"5bw66y36bff3umq1q57mfy4y5c","username":"mattermost_a"}		[]	[]	f
tnq9t7qtqtd6friw8dn59hgqsr	1672923135329	1672923135329	0	0	f	5bw66y36bff3umq1q57mfy4y5c	g18pe3wojtr65rnxnm4ugmuq4h				This is a bug		{"disable_group_highlight":true}		[]	[]	f
\.


--
-- Data for Name: preferences; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.preferences (userid, category, name, value) FROM stdin;
0z4okgmv5lfhx3p0tf6pnpk8sk	tutorial_step	0z4okgmv5lfhx3p0tf6pnpk8sk	0
3zats68fztgu9mgu944a4t35so	tutorial_step	3zats68fztgu9mgu944a4t35so	0
1fgsimi9s3rmjxzxsaeqrr66ko	tutorial_step	1fgsimi9s3rmjxzxsaeqrr66ko	0
kgr5hfwxy78k5n9gfkdhcscdoc	tutorial_step	kgr5hfwxy78k5n9gfkdhcscdoc	0
bmq7jiumpib3xdz3mx5iyo99ro	tutorial_step	bmq7jiumpib3xdz3mx5iyo99ro	999
bmq7jiumpib3xdz3mx5iyo99ro	channel_approximate_view_time		1672917057537
98kwr77m4jgwmbdgygknaowcch	tutorial_step	98kwr77m4jgwmbdgygknaowcch	999
98kwr77m4jgwmbdgygknaowcch	channel_approximate_view_time	dckusnmodbnubf7hcu369adaio	1672922039338
98kwr77m4jgwmbdgygknaowcch	channel_approximate_view_time	cxtmz3ubz3gfigd5m6prendmsw	1672922053328
98kwr77m4jgwmbdgygknaowcch	channel_approximate_view_time		1672922170909
she685ewdtyq7m7jgmys7zoqmr	tutorial_step	she685ewdtyq7m7jgmys7zoqmr	0
5bw66y36bff3umq1q57mfy4y5c	tutorial_step	5bw66y36bff3umq1q57mfy4y5c	999
5bw66y36bff3umq1q57mfy4y5c	channel_approximate_view_time		1672923137822
\.


--
-- Data for Name: publicchannels; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.publicchannels (id, deleteat, teamid, displayname, name, header, purpose) FROM stdin;
cxtmz3ubz3gfigd5m6prendmsw	0	tgrw7sjgbiy1jggs3qg3m6zpee	Town Square	town-square		
73uy6kj1jb8wdqrf3ti6zies6r	0	tgrw7sjgbiy1jggs3qg3m6zpee	Off-Topic	off-topic		
9eiccer1gfbzzpf8yfbze74n3e	0	7jenmotdwfdq7mmci7zz7hfpze	Town Square	town-square		
g18pe3wojtr65rnxnm4ugmuq4h	0	tgrw7sjgbiy1jggs3qg3m6zpee	Bugs in bridge	bugs-in-bridge		
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
nuj8b3qqzby83poe5s7eowrroc	s537n3t8zib1tx7eyd44qzqnbr	1672856703479	4826456703479	1672856703479	bmq7jiumpib3xdz3mx5iyo99ro		system_admin system_user	f	f	{"is_guest":"false","type":"UserAccessToken","user_access_token_id":"98yjyceocfb5mc3jaibtbmr1ph"}
zh7d8s9zepf1xqo1roee4593to	s537n3t8zib1tx7eyd44qzqnbr	1672856703476	4826456703476	1672856703476	bmq7jiumpib3xdz3mx5iyo99ro		system_admin system_user	f	f	{"is_guest":"false","type":"UserAccessToken","user_access_token_id":"98yjyceocfb5mc3jaibtbmr1ph"}
wm7tg3bnjfbz9pokty3y335jpo	aqhn1jc1nbgjtpd7es83wckner	1672856705867	4826456705867	1672856705867	5bw66y36bff3umq1q57mfy4y5c		system_user	f	f	{"is_guest":"false","type":"UserAccessToken","user_access_token_id":"ya4wtr9fjiyxfptgnjmjgcc3wh"}
nx4ge8gf1bgidgskfz3t8qfmew	6nk5qzigrfg8py1bfjx49zkrgh	1672856706373	4826456706373	1672856706373	1fgsimi9s3rmjxzxsaeqrr66ko		system_user	f	f	{"is_guest":"false","type":"UserAccessToken","user_access_token_id":"6uz914r9ojrktq1xranio359ie"}
ftayyd6rjbds5npwion3kqowzw	j6knf51k1jb63fe8moah7qbf6o	1672856706932	4826456706932	1672856706932	kgr5hfwxy78k5n9gfkdhcscdoc		system_user	f	f	{"is_guest":"false","type":"UserAccessToken","user_access_token_id":"spc9donsrtbduj8y15pck5nq9w"}
o6a418brw7d1fxz7b8psyjgawa	ox8n8edimjdbfkeybdf56pj4xw	1672856707498	4826456707498	1672856707498	3zats68fztgu9mgu944a4t35so		system_user	f	f	{"is_guest":"false","type":"UserAccessToken","user_access_token_id":"e3dnfu1g17fjtxq53odawh6e7y"}
1kcmnxa9kpgamkpzi5rzjwqdrr	s537n3t8zib1tx7eyd44qzqnbr	1672856703482	4826456703482	1672922247795	bmq7jiumpib3xdz3mx5iyo99ro		system_admin system_user	f	f	{"is_guest":"false","type":"UserAccessToken","user_access_token_id":"98yjyceocfb5mc3jaibtbmr1ph"}
dj4cashhdfycxjyxdyz1eh63ma	fsyrgfjxafnr9erkxhk1hup8fa	1672923004637	1675515004637	1672923004637	5bw66y36bff3umq1q57mfy4y5c		system_user	f	f	{"browser":"Chrome/108.0","csrf":"b7czsefjpigxmyixstcpx3a77w","isMobile":"false","isOAuthUser":"false","isSaml":"false","is_guest":"false","os":"Mac OS","platform":"Macintosh"}
\.


--
-- Data for Name: sidebarcategories; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.sidebarcategories (id, userid, teamid, sortorder, sorting, type, displayname) FROM stdin;
z8ezpkrpd3d7irxpormhn3w9er	1fgsimi9s3rmjxzxsaeqrr66ko	tgrw7sjgbiy1jggs3qg3m6zpee	0		favorites	Favorites
t3bmpa1bfbdo9mk3wphoeys9my	1fgsimi9s3rmjxzxsaeqrr66ko	tgrw7sjgbiy1jggs3qg3m6zpee	10		channels	Channels
edfdeurajfgctqxz8ttsfw6ruw	1fgsimi9s3rmjxzxsaeqrr66ko	tgrw7sjgbiy1jggs3qg3m6zpee	20	recent	direct_messages	Direct Messages
a469xbwpo7bx3rzankrrywobuw	kgr5hfwxy78k5n9gfkdhcscdoc	tgrw7sjgbiy1jggs3qg3m6zpee	0		favorites	Favorites
sefn36xsabfm7e14p4rk9mztoe	kgr5hfwxy78k5n9gfkdhcscdoc	tgrw7sjgbiy1jggs3qg3m6zpee	10		channels	Channels
ho69ue7c5frefq97zb1sh9j8qh	kgr5hfwxy78k5n9gfkdhcscdoc	tgrw7sjgbiy1jggs3qg3m6zpee	20	recent	direct_messages	Direct Messages
jigazeeu8irabn1qm9n4kp57sh	98kwr77m4jgwmbdgygknaowcch	tgrw7sjgbiy1jggs3qg3m6zpee	0		favorites	Favorites
4m9dn1jqwbb3djxd44sxci8yze	98kwr77m4jgwmbdgygknaowcch	tgrw7sjgbiy1jggs3qg3m6zpee	10		channels	Channels
ttidzgpuubg4mfr6ox85stjhrw	98kwr77m4jgwmbdgygknaowcch	tgrw7sjgbiy1jggs3qg3m6zpee	20	recent	direct_messages	Direct Messages
dfrum9y3f7r3mgb8kq39g1ydeh	she685ewdtyq7m7jgmys7zoqmr	tgrw7sjgbiy1jggs3qg3m6zpee	0		favorites	Favorites
f3c1j165ftyb9d8utcm6zdktic	she685ewdtyq7m7jgmys7zoqmr	tgrw7sjgbiy1jggs3qg3m6zpee	10		channels	Channels
dnq8zjdd1jyspxikqdb3m1cy5c	she685ewdtyq7m7jgmys7zoqmr	tgrw7sjgbiy1jggs3qg3m6zpee	20	recent	direct_messages	Direct Messages
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
1fgsimi9s3rmjxzxsaeqrr66ko	offline	f	1672856706408
kgr5hfwxy78k5n9gfkdhcscdoc	offline	f	1672856706956
3zats68fztgu9mgu944a4t35so	offline	f	1672856707579
98kwr77m4jgwmbdgygknaowcch	offline	f	1672922742708
bmq7jiumpib3xdz3mx5iyo99ro	away	f	1672922249312
5bw66y36bff3umq1q57mfy4y5c	away	f	1672923137885
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
LastSecurityTime	1672856703392
\.


--
-- Data for Name: teammembers; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.teammembers (teamid, userid, roles, deleteat, schemeuser, schemeadmin, schemeguest) FROM stdin;
tgrw7sjgbiy1jggs3qg3m6zpee	bmq7jiumpib3xdz3mx5iyo99ro		0	t	t	f
tgrw7sjgbiy1jggs3qg3m6zpee	5bw66y36bff3umq1q57mfy4y5c		0	t	f	f
tgrw7sjgbiy1jggs3qg3m6zpee	0z4okgmv5lfhx3p0tf6pnpk8sk		0	t	f	f
tgrw7sjgbiy1jggs3qg3m6zpee	3zats68fztgu9mgu944a4t35so		0	t	f	f
tgrw7sjgbiy1jggs3qg3m6zpee	1fgsimi9s3rmjxzxsaeqrr66ko		0	t	f	f
tgrw7sjgbiy1jggs3qg3m6zpee	kgr5hfwxy78k5n9gfkdhcscdoc		0	t	f	f
tgrw7sjgbiy1jggs3qg3m6zpee	98kwr77m4jgwmbdgygknaowcch		0	t	f	f
7jenmotdwfdq7mmci7zz7hfpze	98kwr77m4jgwmbdgygknaowcch		1672922135158	t	t	f
tgrw7sjgbiy1jggs3qg3m6zpee	she685ewdtyq7m7jgmys7zoqmr		0	t	f	f
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.teams (id, createat, updateat, deleteat, displayname, name, description, email, type, companyname, alloweddomains, inviteid, allowopeninvite, lastteamiconupdate, schemeid, groupconstrained) FROM stdin;
7jenmotdwfdq7mmci7zz7hfpze	1672921846241	1672921846241	0	users	users		user1@localhost	O			k3m7x5sumpnx3jyquka4mjj7na	f	0	\N	\N
tgrw7sjgbiy1jggs3qg3m6zpee	1598351837711	1672922833167	0	Public Team	test			O			5tdc6sxr43byufri3r6px9f9xo	t	0	\N	\N
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
6uz914r9ojrktq1xranio359ie	6nk5qzigrfg8py1bfjx49zkrgh	1fgsimi9s3rmjxzxsaeqrr66ko	bridge	t
spc9donsrtbduj8y15pck5nq9w	j6knf51k1jb63fe8moah7qbf6o	kgr5hfwxy78k5n9gfkdhcscdoc	bridge	t
j9jxpacsy3d4zmx4pu1qjonfua	pgrgjax6rpggub1hxajrw5ne4h	she685ewdtyq7m7jgmys7zoqmr	bridge	t
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
0z4okgmv5lfhx3p0tf6pnpk8sk	1598351800458	1598352057088	0	ignored_user	$2a$10$WdovEVVvy9ZS867UE2hSq.7hV38Lg9H2ozgaF3gwuO6fuoCkkTzIu	\N		ignored_user@localhost	f					system_user	f	{}	{"channel":"true","comments":"never","desktop":"mention","desktop_sound":"true","email":"true","first_name":"false","mention_keys":"","push":"mention","push_status":"away"}	1598352057088	0	0	en	{"automaticTimezone":"","manualTimezone":"","useAutomaticTimezone":"true"}	f	
1fgsimi9s3rmjxzxsaeqrr66ko	1672856703693	1672922248484	0	matrix_matrix_a	$2a$10$Ev9uMMLU1j7olpOnonXlcega8UsQ5iJAkZSoxs6LKPPLHo08TK7T6	\N		devnull-heuxcvsa5epb25-j@localhost	t		Matrix UserA			system_user	f	{}	{"channel":"true","comments":"never","desktop":"mention","desktop_sound":"true","email":"true","first_name":"false","mention_keys":"","push":"mention","push_status":"away"}	1672856703693	0	0	en	{"automaticTimezone":"","manualTimezone":"","useAutomaticTimezone":"true"}	f	
kgr5hfwxy78k5n9gfkdhcscdoc	1672856703886	1672922248492	0	matrix_matrix_b	$2a$10$/SAgqCacBg.Xr.2a2Yy2xO.MhGG2zEkJ1j0l.oA/yLifm812.51zW	\N		devnull-jvwx5lytbmh2xdbp@localhost	t		matrix_b			system_user	f	{}	{"channel":"true","comments":"never","desktop":"mention","desktop_sound":"true","email":"true","first_name":"false","mention_keys":"","push":"mention","push_status":"away"}	1672856703886	0	0	en	{"automaticTimezone":"","manualTimezone":"","useAutomaticTimezone":"true"}	f	
bmq7jiumpib3xdz3mx5iyo99ro	1598351769026	1598351847718	0	admin	$2a$10$dCK8unlOWxu7Ge1Fmeo70eaETqonsQC1mVbwnLi5lCH5ALbzKyqnO	\N		admin@localhost	f		Admin	User		system_admin system_user	f	{}	{"channel":"true","comments":"never","desktop":"mention","desktop_sound":"true","email":"true","first_name":"false","mention_keys":"","push":"mention","push_status":"away"}	1598351769026	0	0	en	{"automaticTimezone":"","manualTimezone":"","useAutomaticTimezone":"true"}	f	
98kwr77m4jgwmbdgygknaowcch	1672921832140	1672922135162	0	user1	$2a$10$Y.xgACBeddylzHset9G7B.W5ni806n7eAXtjkvCD6s9ZjyDy7MrR.	\N		user1@localhost	f					system_user	t	{}	{"channel":"true","comments":"never","desktop":"mention","desktop_sound":"true","email":"true","first_name":"false","mention_keys":"","push":"mention","push_status":"away"}	1672921832140	0	0	en	{"automaticTimezone":"","manualTimezone":"","useAutomaticTimezone":"true"}	f	
5bw66y36bff3umq1q57mfy4y5c	1598351800458	1672922930445	0	mattermost_a	$2a$10$2/PIURccK5KZOUw50RQhFOzJwteNZIa8GQrLMe3m9iJH5L2Dn/69K	\N		mattermost_a@localhost	f		MattermostUser	A		system_user	f	{}	{"channel":"true","comments":"never","desktop":"mention","desktop_sound":"true","email":"true","first_name":"false","mention_keys":"","push":"mention","push_status":"away"}	1672922930445	0	0	en	{"automaticTimezone":"","manualTimezone":"","useAutomaticTimezone":"true"}	f	
she685ewdtyq7m7jgmys7zoqmr	1672922248219	1672922248542	0	matrix_user1	$2a$10$W7hFVwRIKYVlfz7Cgsco5uMfk66J4U.fBDA0wF8hXmSkSLZJEoiMK	\N		devnull-w1pfjon95qjil-gz@localhost	t		User 1			system_user	f	{}	{"channel":"true","comments":"never","desktop":"mention","desktop_sound":"true","email":"true","first_name":"false","mention_keys":"","push":"mention","push_status":"away"}	1672922248219	0	0	en	{"automaticTimezone":"","manualTimezone":"","useAutomaticTimezone":"true"}	f	
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

