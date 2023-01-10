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

--
-- Name: channel_type; Type: TYPE; Schema: public; Owner: mattermost
--

CREATE TYPE public.channel_type AS ENUM (
    'P',
    'G',
    'O',
    'D'
);


ALTER TYPE public.channel_type OWNER TO mattermost;

--
-- Name: team_type; Type: TYPE; Schema: public; Owner: mattermost
--

CREATE TYPE public.team_type AS ENUM (
    'I',
    'O'
);


ALTER TYPE public.team_type OWNER TO mattermost;

--
-- Name: upload_session_type; Type: TYPE; Schema: public; Owner: mattermost
--

CREATE TYPE public.upload_session_type AS ENUM (
    'attachment',
    'import'
);


ALTER TYPE public.upload_session_type OWNER TO mattermost;

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
    roles character varying(256),
    lastviewedat bigint,
    msgcount bigint,
    mentioncount bigint,
    notifyprops jsonb,
    lastupdateat bigint,
    schemeuser boolean,
    schemeadmin boolean,
    schemeguest boolean,
    mentioncountroot bigint,
    msgcountroot bigint
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
    type public.channel_type,
    displayname character varying(64),
    name character varying(64),
    header character varying(1024),
    purpose character varying(250),
    lastpostat bigint,
    totalmsgcount bigint,
    extraupdateat bigint,
    creatorid character varying(26),
    schemeid character varying(26),
    groupconstrained boolean,
    shared boolean,
    totalmsgcountroot bigint,
    lastrootpostat bigint DEFAULT '0'::bigint
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
    url character varying(1024),
    pluginid character varying(190)
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
-- Name: db_lock; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.db_lock (
    id character varying(64) NOT NULL,
    expireat bigint
);


ALTER TABLE public.db_lock OWNER TO mattermost;

--
-- Name: db_migrations; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.db_migrations (
    version bigint NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.db_migrations OWNER TO mattermost;

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
    haspreviewimage boolean,
    minipreview bytea,
    content text,
    remoteid character varying(26),
    archived boolean DEFAULT false NOT NULL
);


ALTER TABLE public.fileinfo OWNER TO mattermost;

--
-- Name: focalboard_blocks; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_blocks (
    id character varying(36) NOT NULL,
    insert_at timestamp with time zone DEFAULT now() NOT NULL,
    parent_id character varying(36),
    schema bigint,
    type text,
    title text,
    fields json,
    create_at bigint,
    update_at bigint,
    delete_at bigint,
    root_id character varying(36),
    modified_by character varying(36) NOT NULL,
    channel_id character varying(36) NOT NULL,
    created_by character varying(36) NOT NULL,
    board_id character varying(36)
);


ALTER TABLE public.focalboard_blocks OWNER TO mattermost;

--
-- Name: focalboard_blocks_history; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_blocks_history (
    id character varying(36) NOT NULL,
    insert_at timestamp with time zone DEFAULT now() NOT NULL,
    parent_id character varying(36),
    schema bigint,
    type text,
    title text,
    fields json,
    create_at bigint,
    update_at bigint,
    delete_at bigint,
    root_id character varying(36),
    modified_by character varying(36),
    channel_id character varying(36),
    created_by character varying(36),
    board_id character varying(36)
);


ALTER TABLE public.focalboard_blocks_history OWNER TO mattermost;

--
-- Name: focalboard_board_members; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_board_members (
    board_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    roles character varying(64),
    scheme_admin boolean,
    scheme_editor boolean,
    scheme_commenter boolean,
    scheme_viewer boolean
);


ALTER TABLE public.focalboard_board_members OWNER TO mattermost;

--
-- Name: focalboard_board_members_history; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_board_members_history (
    board_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    action character varying(10),
    insert_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.focalboard_board_members_history OWNER TO mattermost;

--
-- Name: focalboard_boards; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_boards (
    id character varying(36) NOT NULL,
    insert_at timestamp with time zone DEFAULT now() NOT NULL,
    team_id character varying(36) NOT NULL,
    channel_id character varying(36),
    created_by character varying(36),
    modified_by character varying(36),
    type character varying(1) NOT NULL,
    title text NOT NULL,
    description text,
    icon character varying(256),
    show_description boolean,
    is_template boolean,
    template_version integer DEFAULT 0,
    properties jsonb,
    card_properties jsonb,
    create_at bigint,
    update_at bigint,
    delete_at bigint,
    minimum_role character varying(36) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.focalboard_boards OWNER TO mattermost;

--
-- Name: focalboard_boards_history; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_boards_history (
    id character varying(36) NOT NULL,
    insert_at timestamp with time zone DEFAULT now() NOT NULL,
    team_id character varying(36) NOT NULL,
    channel_id character varying(36),
    created_by character varying(36),
    modified_by character varying(36),
    type character varying(1) NOT NULL,
    title text NOT NULL,
    description text,
    icon character varying(256),
    show_description boolean,
    is_template boolean,
    template_version integer DEFAULT 0,
    properties jsonb,
    card_properties jsonb,
    create_at bigint,
    update_at bigint,
    delete_at bigint,
    minimum_role character varying(36) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.focalboard_boards_history OWNER TO mattermost;

--
-- Name: focalboard_categories; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_categories (
    id character varying(36) NOT NULL,
    name character varying(100) NOT NULL,
    user_id character varying(36) NOT NULL,
    team_id character varying(36) NOT NULL,
    channel_id character varying(36),
    create_at bigint,
    update_at bigint,
    delete_at bigint,
    collapsed boolean DEFAULT false,
    type character varying(64)
);


ALTER TABLE public.focalboard_categories OWNER TO mattermost;

--
-- Name: focalboard_category_boards; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_category_boards (
    id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    category_id character varying(36) NOT NULL,
    board_id character varying(36) NOT NULL,
    create_at bigint,
    update_at bigint,
    delete_at bigint
);


ALTER TABLE public.focalboard_category_boards OWNER TO mattermost;

--
-- Name: focalboard_file_info; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_file_info (
    id character varying(26) NOT NULL,
    create_at bigint NOT NULL,
    delete_at bigint,
    name text NOT NULL,
    extension character varying(50) NOT NULL,
    size bigint NOT NULL,
    archived boolean
);


ALTER TABLE public.focalboard_file_info OWNER TO mattermost;

--
-- Name: focalboard_notification_hints; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_notification_hints (
    block_type character varying(10),
    block_id character varying(36) NOT NULL,
    workspace_id character varying(36),
    modified_by_id character varying(36),
    create_at bigint,
    notify_at bigint
);


ALTER TABLE public.focalboard_notification_hints OWNER TO mattermost;

--
-- Name: focalboard_preferences; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_preferences (
    userid character varying(36) NOT NULL,
    category character varying(32) NOT NULL,
    name character varying(32) NOT NULL,
    value text
);


ALTER TABLE public.focalboard_preferences OWNER TO mattermost;

--
-- Name: focalboard_schema_migrations; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_schema_migrations (
    version bigint NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.focalboard_schema_migrations OWNER TO mattermost;

--
-- Name: focalboard_sessions; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_sessions (
    id character varying(100) NOT NULL,
    token character varying(100),
    user_id character varying(100),
    props json,
    create_at bigint,
    update_at bigint,
    auth_service character varying(20)
);


ALTER TABLE public.focalboard_sessions OWNER TO mattermost;

--
-- Name: focalboard_sharing; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_sharing (
    id character varying(36) NOT NULL,
    enabled boolean,
    token character varying(100),
    modified_by character varying(36),
    update_at bigint,
    workspace_id character varying(36)
);


ALTER TABLE public.focalboard_sharing OWNER TO mattermost;

--
-- Name: focalboard_subscriptions; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_subscriptions (
    block_type character varying(10),
    block_id character varying(36) NOT NULL,
    workspace_id character varying(36),
    subscriber_type character varying(10),
    subscriber_id character varying(36) NOT NULL,
    notified_at bigint,
    create_at bigint,
    delete_at bigint
);


ALTER TABLE public.focalboard_subscriptions OWNER TO mattermost;

--
-- Name: focalboard_system_settings; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_system_settings (
    id character varying(100) NOT NULL,
    value text
);


ALTER TABLE public.focalboard_system_settings OWNER TO mattermost;

--
-- Name: focalboard_teams; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_teams (
    id character varying(36) NOT NULL,
    signup_token character varying(100) NOT NULL,
    settings json,
    modified_by character varying(36),
    update_at bigint
);


ALTER TABLE public.focalboard_teams OWNER TO mattermost;

--
-- Name: focalboard_users; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_users (
    id character varying(100) NOT NULL,
    username character varying(100),
    email character varying(255),
    password character varying(100),
    mfa_secret character varying(100),
    auth_service character varying(20),
    auth_data character varying(255),
    props json,
    create_at bigint,
    update_at bigint,
    delete_at bigint
);


ALTER TABLE public.focalboard_users OWNER TO mattermost;

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
-- Name: ir_category; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.ir_category (
    id text NOT NULL,
    name text NOT NULL,
    teamid text NOT NULL,
    userid text NOT NULL,
    collapsed boolean DEFAULT false,
    createat bigint NOT NULL,
    updateat bigint DEFAULT 0 NOT NULL,
    deleteat bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.ir_category OWNER TO mattermost;

--
-- Name: ir_category_item; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.ir_category_item (
    type text NOT NULL,
    categoryid text NOT NULL,
    itemid text NOT NULL
);


ALTER TABLE public.ir_category_item OWNER TO mattermost;

--
-- Name: ir_channelaction; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.ir_channelaction (
    id text NOT NULL,
    channelid character varying(26),
    enabled boolean DEFAULT false,
    deleteat bigint DEFAULT 0 NOT NULL,
    actiontype text NOT NULL,
    triggertype text NOT NULL,
    payload json NOT NULL
);


ALTER TABLE public.ir_channelaction OWNER TO mattermost;

--
-- Name: ir_incident; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.ir_incident (
    id text NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    isactive boolean NOT NULL,
    commanderuserid text NOT NULL,
    teamid text NOT NULL,
    channelid text NOT NULL,
    createat bigint NOT NULL,
    endat bigint DEFAULT 0 NOT NULL,
    deleteat bigint DEFAULT 0 NOT NULL,
    activestage bigint NOT NULL,
    postid text DEFAULT ''::text NOT NULL,
    playbookid text DEFAULT ''::text NOT NULL,
    checklistsjson json NOT NULL,
    activestagetitle text DEFAULT ''::text,
    reminderpostid text,
    broadcastchannelid text DEFAULT ''::text,
    previousreminder bigint DEFAULT 0 NOT NULL,
    remindermessagetemplate text DEFAULT ''::text,
    currentstatus text DEFAULT 'Active'::text NOT NULL,
    reporteruserid text DEFAULT ''::text NOT NULL,
    concatenatedinviteduserids text DEFAULT ''::text,
    defaultcommanderid text DEFAULT ''::text,
    announcementchannelid text DEFAULT ''::text,
    concatenatedwebhookoncreationurls text DEFAULT ''::text,
    concatenatedinvitedgroupids text DEFAULT ''::text,
    retrospective text DEFAULT ''::text,
    messageonjoin text DEFAULT ''::text,
    retrospectivepublishedat bigint DEFAULT 0 NOT NULL,
    retrospectivereminderintervalseconds bigint DEFAULT 0 NOT NULL,
    retrospectivewascanceled boolean DEFAULT false,
    concatenatedwebhookonstatusupdateurls text DEFAULT ''::text,
    laststatusupdateat bigint DEFAULT 0,
    exportchannelonfinishedenabled boolean DEFAULT false NOT NULL,
    categorizechannelenabled boolean DEFAULT false,
    categoryname text DEFAULT ''::text,
    concatenatedbroadcastchannelids text,
    channelidtorootid text DEFAULT ''::text,
    remindertimerdefaultseconds bigint DEFAULT 0 NOT NULL,
    statusupdateenabled boolean DEFAULT true,
    retrospectiveenabled boolean DEFAULT true,
    statusupdatebroadcastchannelsenabled boolean DEFAULT false,
    statusupdatebroadcastwebhooksenabled boolean DEFAULT false,
    summarymodifiedat bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.ir_incident OWNER TO mattermost;

--
-- Name: ir_metric; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.ir_metric (
    incidentid text NOT NULL,
    metricconfigid text NOT NULL,
    value bigint,
    published boolean NOT NULL
);


ALTER TABLE public.ir_metric OWNER TO mattermost;

--
-- Name: ir_metricconfig; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.ir_metricconfig (
    id text NOT NULL,
    playbookid text NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    type text NOT NULL,
    target bigint,
    ordering smallint DEFAULT 0 NOT NULL,
    deleteat bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.ir_metricconfig OWNER TO mattermost;

--
-- Name: ir_playbook; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.ir_playbook (
    id text NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    teamid text NOT NULL,
    createpublicincident boolean NOT NULL,
    createat bigint NOT NULL,
    deleteat bigint DEFAULT 0 NOT NULL,
    checklistsjson json NOT NULL,
    numstages bigint DEFAULT 0 NOT NULL,
    numsteps bigint DEFAULT 0 NOT NULL,
    broadcastchannelid text DEFAULT ''::text,
    remindermessagetemplate text DEFAULT ''::text,
    remindertimerdefaultseconds bigint DEFAULT 0 NOT NULL,
    concatenatedinviteduserids text DEFAULT ''::text,
    inviteusersenabled boolean DEFAULT false,
    defaultcommanderid text DEFAULT ''::text,
    defaultcommanderenabled boolean DEFAULT false,
    announcementchannelid text DEFAULT ''::text,
    announcementchannelenabled boolean DEFAULT false,
    concatenatedwebhookoncreationurls text DEFAULT ''::text,
    webhookoncreationenabled boolean DEFAULT false,
    concatenatedinvitedgroupids text DEFAULT ''::text,
    messageonjoin text DEFAULT ''::text,
    messageonjoinenabled boolean DEFAULT false,
    retrospectivereminderintervalseconds bigint DEFAULT 0 NOT NULL,
    retrospectivetemplate text,
    concatenatedwebhookonstatusupdateurls text DEFAULT ''::text,
    webhookonstatusupdateenabled boolean DEFAULT false,
    concatenatedsignalanykeywords text DEFAULT ''::text,
    signalanykeywordsenabled boolean DEFAULT false,
    updateat bigint DEFAULT 0 NOT NULL,
    exportchannelonfinishedenabled boolean DEFAULT false NOT NULL,
    categorizechannelenabled boolean DEFAULT false,
    categoryname text DEFAULT ''::text,
    concatenatedbroadcastchannelids text,
    broadcastenabled boolean DEFAULT false,
    runsummarytemplate text DEFAULT ''::text,
    channelnametemplate text DEFAULT ''::text,
    statusupdateenabled boolean DEFAULT true,
    retrospectiveenabled boolean DEFAULT true,
    public boolean DEFAULT false,
    runsummarytemplateenabled boolean DEFAULT true
);


ALTER TABLE public.ir_playbook OWNER TO mattermost;

--
-- Name: ir_playbookautofollow; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.ir_playbookautofollow (
    playbookid text NOT NULL,
    userid text NOT NULL
);


ALTER TABLE public.ir_playbookautofollow OWNER TO mattermost;

--
-- Name: ir_playbookmember; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.ir_playbookmember (
    playbookid text NOT NULL,
    memberid text NOT NULL,
    roles text
);


ALTER TABLE public.ir_playbookmember OWNER TO mattermost;

--
-- Name: ir_run_participants; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.ir_run_participants (
    userid text NOT NULL,
    incidentid text NOT NULL,
    isfollower boolean NOT NULL
);


ALTER TABLE public.ir_run_participants OWNER TO mattermost;

--
-- Name: ir_statusposts; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.ir_statusposts (
    incidentid text NOT NULL,
    postid text NOT NULL
);


ALTER TABLE public.ir_statusposts OWNER TO mattermost;

--
-- Name: ir_system; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.ir_system (
    skey character varying(64) NOT NULL,
    svalue character varying(1024)
);


ALTER TABLE public.ir_system OWNER TO mattermost;

--
-- Name: ir_timelineevent; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.ir_timelineevent (
    id text NOT NULL,
    incidentid text NOT NULL,
    createat bigint NOT NULL,
    deleteat bigint DEFAULT 0 NOT NULL,
    eventat bigint NOT NULL,
    eventtype text DEFAULT ''::text NOT NULL,
    summary text DEFAULT ''::text NOT NULL,
    details text DEFAULT ''::text NOT NULL,
    postid text DEFAULT ''::text NOT NULL,
    subjectuserid text DEFAULT ''::text NOT NULL,
    creatoruserid text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.ir_timelineevent OWNER TO mattermost;

--
-- Name: ir_userinfo; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.ir_userinfo (
    id text NOT NULL,
    lastdailytododmat bigint,
    digestnotificationsettingsjson json
);


ALTER TABLE public.ir_userinfo OWNER TO mattermost;

--
-- Name: ir_viewedchannel; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.ir_viewedchannel (
    channelid text NOT NULL,
    userid text NOT NULL
);


ALTER TABLE public.ir_viewedchannel OWNER TO mattermost;

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
    data jsonb
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
    data jsonb
);


ALTER TABLE public.linkmetadata OWNER TO mattermost;

--
-- Name: notifyadmin; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.notifyadmin (
    userid character varying(26) NOT NULL,
    createat bigint,
    requiredplan character varying(26) NOT NULL,
    requiredfeature character varying(100) NOT NULL,
    trial boolean NOT NULL
);


ALTER TABLE public.notifyadmin OWNER TO mattermost;

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
    istrusted boolean,
    mattermostappid character varying(32) DEFAULT ''::character varying NOT NULL
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
    pkey character varying(150) NOT NULL,
    pvalue bytea,
    expireat bigint
);


ALTER TABLE public.pluginkeyvaluestore OWNER TO mattermost;

--
-- Name: postreminders; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.postreminders (
    postid character varying(26) NOT NULL,
    userid character varying(26) NOT NULL,
    targettime bigint
);


ALTER TABLE public.postreminders OWNER TO mattermost;

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
    originalid character varying(26),
    message character varying(65535),
    type character varying(26),
    props jsonb,
    hashtags character varying(1000),
    filenames character varying(4000),
    fileids character varying(300),
    hasreactions boolean,
    remoteid character varying(26)
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
-- Name: productnoticeviewstate; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.productnoticeviewstate (
    userid character varying(26) NOT NULL,
    noticeid character varying(26) NOT NULL,
    viewed integer,
    "timestamp" bigint
);


ALTER TABLE public.productnoticeviewstate OWNER TO mattermost;

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
    createat bigint,
    updateat bigint,
    deleteat bigint,
    remoteid character varying(26),
    channelid character varying(26) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.reactions OWNER TO mattermost;

--
-- Name: recentsearches; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.recentsearches (
    userid character(26) NOT NULL,
    searchpointer integer NOT NULL,
    query jsonb,
    createat bigint NOT NULL
);


ALTER TABLE public.recentsearches OWNER TO mattermost;

--
-- Name: remoteclusters; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.remoteclusters (
    remoteid character varying(26) NOT NULL,
    remoteteamid character varying(26),
    name character varying(64) NOT NULL,
    displayname character varying(64),
    siteurl character varying(512),
    createat bigint,
    lastpingat bigint,
    token character varying(26),
    remotetoken character varying(26),
    topics character varying(512),
    creatorid character varying(26)
);


ALTER TABLE public.remoteclusters OWNER TO mattermost;

--
-- Name: retentionpolicies; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.retentionpolicies (
    id character varying(26) NOT NULL,
    displayname character varying(64),
    postduration bigint
);


ALTER TABLE public.retentionpolicies OWNER TO mattermost;

--
-- Name: retentionpolicieschannels; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.retentionpolicieschannels (
    policyid character varying(26),
    channelid character varying(26) NOT NULL
);


ALTER TABLE public.retentionpolicieschannels OWNER TO mattermost;

--
-- Name: retentionpoliciesteams; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.retentionpoliciesteams (
    policyid character varying(26),
    teamid character varying(26) NOT NULL
);


ALTER TABLE public.retentionpoliciesteams OWNER TO mattermost;

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
    permissions text,
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
    defaultchannelguestrole character varying(64),
    defaultplaybookadminrole character varying(64) DEFAULT ''::character varying,
    defaultplaybookmemberrole character varying(64) DEFAULT ''::character varying,
    defaultrunadminrole character varying(64) DEFAULT ''::character varying,
    defaultrunmemberrole character varying(64) DEFAULT ''::character varying
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
    roles character varying(256),
    isoauth boolean,
    expirednotify boolean,
    props jsonb
);


ALTER TABLE public.sessions OWNER TO mattermost;

--
-- Name: sharedchannelattachments; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.sharedchannelattachments (
    id character varying(26) NOT NULL,
    fileid character varying(26),
    remoteid character varying(26),
    createat bigint,
    lastsyncat bigint
);


ALTER TABLE public.sharedchannelattachments OWNER TO mattermost;

--
-- Name: sharedchannelremotes; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.sharedchannelremotes (
    id character varying(26) NOT NULL,
    channelid character varying(26) NOT NULL,
    creatorid character varying(26),
    createat bigint,
    updateat bigint,
    isinviteaccepted boolean,
    isinviteconfirmed boolean,
    remoteid character varying(26),
    lastpostupdateat bigint,
    lastpostid character varying(26)
);


ALTER TABLE public.sharedchannelremotes OWNER TO mattermost;

--
-- Name: sharedchannels; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.sharedchannels (
    channelid character varying(26) NOT NULL,
    teamid character varying(26),
    home boolean,
    readonly boolean,
    sharename character varying(64),
    sharedisplayname character varying(64),
    sharepurpose character varying(250),
    shareheader character varying(1024),
    creatorid character varying(26),
    createat bigint,
    updateat bigint,
    remoteid character varying(26)
);


ALTER TABLE public.sharedchannels OWNER TO mattermost;

--
-- Name: sharedchannelusers; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.sharedchannelusers (
    id character varying(26) NOT NULL,
    userid character varying(26),
    remoteid character varying(26),
    createat bigint,
    lastsyncat bigint,
    channelid character varying(26)
);


ALTER TABLE public.sharedchannelusers OWNER TO mattermost;

--
-- Name: sidebarcategories; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.sidebarcategories (
    id character varying(128) NOT NULL,
    userid character varying(26),
    teamid character varying(26),
    sortorder bigint,
    sorting character varying(64),
    type character varying(64),
    displayname character varying(64),
    muted boolean,
    collapsed boolean
);


ALTER TABLE public.sidebarcategories OWNER TO mattermost;

--
-- Name: sidebarchannels; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.sidebarchannels (
    channelid character varying(26) NOT NULL,
    userid character varying(26) NOT NULL,
    categoryid character varying(128) NOT NULL,
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
    lastactivityat bigint,
    dndendtime bigint,
    prevstatus character varying(32)
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
    roles character varying(256),
    deleteat bigint,
    schemeuser boolean,
    schemeadmin boolean,
    schemeguest boolean,
    createat bigint DEFAULT 0
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
    type public.team_type,
    companyname character varying(64),
    alloweddomains character varying(1000),
    inviteid character varying(32),
    allowopeninvite boolean,
    lastteamiconupdate bigint,
    schemeid character varying(26),
    groupconstrained boolean,
    cloudlimitsarchived boolean DEFAULT false NOT NULL
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
-- Name: threadmemberships; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.threadmemberships (
    postid character varying(26) NOT NULL,
    userid character varying(26) NOT NULL,
    following boolean,
    lastviewed bigint,
    lastupdated bigint,
    unreadmentions bigint
);


ALTER TABLE public.threadmemberships OWNER TO mattermost;

--
-- Name: threads; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.threads (
    postid character varying(26) NOT NULL,
    replycount bigint,
    lastreplyat bigint,
    participants jsonb,
    channelid character varying(26),
    threaddeleteat bigint
);


ALTER TABLE public.threads OWNER TO mattermost;

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
-- Name: uploadsessions; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.uploadsessions (
    id character varying(26) NOT NULL,
    type public.upload_session_type,
    createat bigint,
    userid character varying(26),
    channelid character varying(26),
    filename character varying(256),
    path character varying(512),
    filesize bigint,
    fileoffset bigint,
    remoteid character varying(26),
    reqfileid character varying(26)
);


ALTER TABLE public.uploadsessions OWNER TO mattermost;

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
    props jsonb,
    notifyprops jsonb,
    lastpasswordupdate bigint,
    lastpictureupdate bigint,
    failedattempts integer,
    locale character varying(5),
    timezone jsonb,
    mfaactive boolean,
    mfasecret character varying(128),
    remoteid character varying(26)
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
ggnns1wpp383fbq8dtytck34ty	1672924735188	5bw66y36bff3umq1q57mfy4y5c	/api/v4/system/notices/view	attempt	172.16.238.1	dj4cashhdfycxjyxdyz1eh63ma
xw1tyxp1miy7fcs8iurph898oo	1672924763653	5bw66y36bff3umq1q57mfy4y5c	/api/v4/users/logout		172.16.238.1	dj4cashhdfycxjyxdyz1eh63ma
baisma3q7pyo5dcjusz9y9czhe	1672924771167		/api/v4/users/login	attempt - login_id=user1	172.16.238.1	
dj9s3ycqdibxtb8sdsnrw7tpao	1672924771274	98kwr77m4jgwmbdgygknaowcch	/api/v4/users/login	authenticated	172.16.238.1	
7y5ijk43giy6xgd6o1cnqtet8o	1672924771281	98kwr77m4jgwmbdgygknaowcch	/api/v4/users/login	success session_user=98kwr77m4jgwmbdgygknaowcch	172.16.238.1	5m84fjgqn7yydbwp9phcfooc4y
yy4ftenxabn4zqs89d4eb4fraw	1672924806564	98kwr77m4jgwmbdgygknaowcch	/api/v4/system/notices/view	attempt	172.16.238.1	5m84fjgqn7yydbwp9phcfooc4y
1mbhsm9qkbnhdjp8dukzdr99ya	1672924891094	98kwr77m4jgwmbdgygknaowcch	/api/v4/users/logout		172.16.238.1	5m84fjgqn7yydbwp9phcfooc4y
q3p6o9tcb7g3br5bczz1xtebga	1672924898616		/api/v4/users/login	attempt - login_id=admin	172.16.238.1	
nmcxf3puh7gc7fxytkoneqzuro	1672924898805		/api/v4/users/login	failure - login_id=admin	172.16.238.1	
bbnqy8ee9ib6b8e63aasg31crc	1672924918158		/api/v4/users/login	attempt - login_id=admin	172.16.238.1	
pqapfu3f7igdzfhphsqetaturc	1672924918265	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/login	authenticated	172.16.238.1	
pzecjt95cib3zdxp55i4tc798r	1672924918278	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/login	success session_user=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	jpc96qdwdbbb9f83j7mic9jidy
r1s5brnfsin69bz4rwyadkie8r	1672924984806	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/system/notices/view	attempt	172.16.238.1	jpc96qdwdbbb9f83j7mic9jidy
3aiip4swwp818q8okwdhpheu3h	1672924987364	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/system/notices/view	attempt	172.16.238.1	jpc96qdwdbbb9f83j7mic9jidy
h7dpseramb8nt881mwaipqcf3h	1672924991416	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/system/notices/view	attempt	172.16.238.1	jpc96qdwdbbb9f83j7mic9jidy
md7dair3r7yyujmdraxdrsbrzy	1672925020020	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	jpc96qdwdbbb9f83j7mic9jidy
ms9ckk76c7no9ffcood3wit77r	1672925080105	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	jpc96qdwdbbb9f83j7mic9jidy
1ar8tsru57r5uppatmfgur4p9o	1672925169357	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=98kwr77m4jgwmbdgygknaowcch	172.16.238.1	jpc96qdwdbbb9f83j7mic9jidy
8868xyxh1bnctdr88aa1urm5ia	1672925224188	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/system/notices/view	attempt	172.16.238.1	jpc96qdwdbbb9f83j7mic9jidy
e737het3xjnqzxm6337xy3dirr	1672925540848	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	nuj8b3qqzby83poe5s7eowrroc
9wtubjxwqpdw3r7pg5qqwsh3hc	1672925540859	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	nuj8b3qqzby83poe5s7eowrroc
gxufjputktfx9go5xukngku1me	1672925619977	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	nuj8b3qqzby83poe5s7eowrroc
hxrypj739jgefr77thwjs4txsa	1672925619990	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	nuj8b3qqzby83poe5s7eowrroc
hbg4wnxteiyhzgymhodf4pwtqe	1673367066223	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
ri7daa4qfbra9c88ei845ky96a	1673367066252	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
c31tfkqe33bttrthww6456nd7h	1673367067251	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
9g93fi315fyrtm8efgygwric7c	1673367067263	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
tfyob5zq1tbnpb9wzpfnncughy	1673367091616	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
tbpzybqus7g3b8ugfguq4hed1o	1673367091618	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
9435kgux4bfp5pkcnrxknj5crh	1673367092288	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
bnzt96ynkbdk5jxf51gm4byn1r	1673367092292	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
1myme6rhaidauyf6xt43d5xobe	1673367606819	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
35dxty4eetbdukkonaqt6oe9ca	1673367606818	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
43ox9z6o6pnazdmiwhoxpf86ue	1673367607588	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
i6ejzi1nnfr63qf1amp7be3cfa	1673367607592	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
8g8zt6mf9pyjzyw3i9qaai5cbr	1673367802105	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
mocz3fmwdpbwxczwzk7foit65w	1673367802109	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
9zxoiagsnbdozdkx519ar34xfw	1673367802442	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/1fgsimi9s3rmjxzxsaeqrr66ko/patch		172.16.238.1	zh7d8s9zepf1xqo1roee4593to
kszwkpzi5jrz7dkp4e1b6corrc	1673367802524	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=1fgsimi9s3rmjxzxsaeqrr66ko	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
8etpn13kd7b6jfeicdjecj1p9o	1673367802508	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/kgr5hfwxy78k5n9gfkdhcscdoc/patch		172.16.238.1	zh7d8s9zepf1xqo1roee4593to
o7kfrdrthfbj7mf14mcfqkstzw	1673367802613	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/she685ewdtyq7m7jgmys7zoqmr/patch		172.16.238.1	zh7d8s9zepf1xqo1roee4593to
9wx9qwhgsfdyfgf1tt4axnqfzr	1673367802630	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/kgr5hfwxy78k5n9gfkdhcscdoc/patch		172.16.238.1	zh7d8s9zepf1xqo1roee4593to
1hq56y7jy7yzmkkyg9hpjr1n6w	1673367802678	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/she685ewdtyq7m7jgmys7zoqmr/patch		172.16.238.1	zh7d8s9zepf1xqo1roee4593to
e33xwwqbzpfs5gh79bwbbnfggy	1673367802675	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=kgr5hfwxy78k5n9gfkdhcscdoc	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
y8ni58858brdxjjtje1ep5y3dh	1673367802722	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=she685ewdtyq7m7jgmys7zoqmr	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
1znu378i7fy5bbo36nswqhtc8r	1673367804303	1fgsimi9s3rmjxzxsaeqrr66ko	/api/v4/channels/g18pe3wojtr65rnxnm4ugmuq4h/members/1fgsimi9s3rmjxzxsaeqrr66ko	name=bugs-in-bridge user_id=1fgsimi9s3rmjxzxsaeqrr66ko	172.16.238.1	nx4ge8gf1bgidgskfz3t8qfmew
h8hkat6rairefyia6dtuu6xema	1673367880882	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
ww39poq3n38kfd1nxqfwmxy5yr	1673367881162	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/she685ewdtyq7m7jgmys7zoqmr/patch		172.16.238.1	zh7d8s9zepf1xqo1roee4593to
1smigjz6ntyuibfg1fcsosjy7o	1673367881261	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=kgr5hfwxy78k5n9gfkdhcscdoc	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
b93mmgxt6braxfeb4irk1peatr	1673367881277	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=kgr5hfwxy78k5n9gfkdhcscdoc	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
aiyahhqm3t8f5dwgi1oh1x3jjo	1673367935583	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
rncwkjhby3g53kthyu4kinihwy	1673367935820	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/kgr5hfwxy78k5n9gfkdhcscdoc/patch		172.16.238.1	zh7d8s9zepf1xqo1roee4593to
cwsymygg3b8mfmjx8fn4zhnqbh	1673367935824	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/kgr5hfwxy78k5n9gfkdhcscdoc/patch		172.16.238.1	zh7d8s9zepf1xqo1roee4593to
bomh3tot83d3jm1dy1ezhqri7c	1673367935857	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/she685ewdtyq7m7jgmys7zoqmr/patch		172.16.238.1	zh7d8s9zepf1xqo1roee4593to
zds1nd5whfbrud61puwioawj4a	1673367935877	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=she685ewdtyq7m7jgmys7zoqmr	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
1z6upc9za7rm9xonzihpnhxpdo	1673367935905	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=she685ewdtyq7m7jgmys7zoqmr	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
8zfbp4ehn3ngzgaiigbkpdd9ie	1673367802746	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/1fgsimi9s3rmjxzxsaeqrr66ko/patch		172.16.238.1	zh7d8s9zepf1xqo1roee4593to
xoghja3s9jrh8rugr9yzjeh9pc	1673367802766	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=she685ewdtyq7m7jgmys7zoqmr	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
n8knqu4jyfrytxarebf4suipfc	1673367802807	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=1fgsimi9s3rmjxzxsaeqrr66ko	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
oxgiryxfgtf3384957pirth67w	1673367804306	she685ewdtyq7m7jgmys7zoqmr	/api/v4/channels/g18pe3wojtr65rnxnm4ugmuq4h/members/she685ewdtyq7m7jgmys7zoqmr	name=bugs-in-bridge user_id=she685ewdtyq7m7jgmys7zoqmr	172.16.238.1	yj4ihgtk7p88fexayf9jse8iey
erm47bijf3dbur8xr6sqke8z8y	1673367804365	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/g18pe3wojtr65rnxnm4ugmuq4h/members/bmq7jiumpib3xdz3mx5iyo99ro	name=bugs-in-bridge user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
6kakn7ta6prxp8p365rh8ffkoa	1673367880869	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
7yq98tdw7pbyiber3siqpd657a	1673367881074	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/1fgsimi9s3rmjxzxsaeqrr66ko/patch		172.16.238.1	zh7d8s9zepf1xqo1roee4593to
4imkpoi14trofpcfhena16ceyh	1673367881088	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=1fgsimi9s3rmjxzxsaeqrr66ko	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
w6tp4ndgiby3ign5j6d6cg4ine	1673367881159	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/she685ewdtyq7m7jgmys7zoqmr/patch		172.16.238.1	zh7d8s9zepf1xqo1roee4593to
wwusinhf7j8hbx7s4e8xfwcccw	1673367881172	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/kgr5hfwxy78k5n9gfkdhcscdoc/patch		172.16.238.1	zh7d8s9zepf1xqo1roee4593to
ehw9rbtfctf9zy4aw7grjdijjo	1673367881264	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=she685ewdtyq7m7jgmys7zoqmr	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
y57ozmh4stgbpe5c1wkasyp5xa	1673367881283	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=she685ewdtyq7m7jgmys7zoqmr	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
stceqorg77gsdy83b65yqbnysy	1673367935824	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/she685ewdtyq7m7jgmys7zoqmr/patch		172.16.238.1	zh7d8s9zepf1xqo1roee4593to
m613mga6ttbezjypwz4jxfwqho	1673367935878	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=kgr5hfwxy78k5n9gfkdhcscdoc	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
pqyq1k9mgigbiyoznhq5js4sqw	1673367935879	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=kgr5hfwxy78k5n9gfkdhcscdoc	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
texyi534xfgt8jhos6hd9dwhrh	1673367802792	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=kgr5hfwxy78k5n9gfkdhcscdoc	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
w4fn7ro7jpyimr3kbdzpexpqoo	1673367881163	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/kgr5hfwxy78k5n9gfkdhcscdoc/patch		172.16.238.1	zh7d8s9zepf1xqo1roee4593to
6o8g8gpzwtgqiybzi7ny9h6ngc	1673367881188	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/1fgsimi9s3rmjxzxsaeqrr66ko/patch		172.16.238.1	zh7d8s9zepf1xqo1roee4593to
1r9pf4uo37yajcq7bndy1zwpgy	1673367881265	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=1fgsimi9s3rmjxzxsaeqrr66ko	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
698krju337buzczkf95zfcwczr	1673367935589	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
hsgqwwbgg7fhbrwxob4muka5da	1673367935814	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/1fgsimi9s3rmjxzxsaeqrr66ko/patch		172.16.238.1	zh7d8s9zepf1xqo1roee4593to
m1ozrj6t3byjbj9emsnofybnbc	1673367935875	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/1fgsimi9s3rmjxzxsaeqrr66ko/patch		172.16.238.1	zh7d8s9zepf1xqo1roee4593to
kcrgwhypsbfszdexnznprd1y8a	1673367935913	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=1fgsimi9s3rmjxzxsaeqrr66ko	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
k9pwtd445tghmdoijnesq4tx4a	1673367935974	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=1fgsimi9s3rmjxzxsaeqrr66ko	172.16.238.1	zh7d8s9zepf1xqo1roee4593to
\.


--
-- Data for Name: bots; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.bots (userid, description, ownerid, lasticonupdate, createat, updateat, deleteat) FROM stdin;
bqy7sf35rtgc3yekuimx43h8by	Mattermost Apps Registry and API proxy.	com.mattermost.apps	0	1672924685904	1672924685904	0
45gdtgiatpf3pfyfgitm5k9cxr	Playbooks bot.	playbooks	0	1672924686624	1672924686624	0
yf4cwcenyjdbfk6zz9713naedo	Created by Boards plugin.	focalboard	0	1672924688001	1672924688001	0
x4tebym3xir39mkitcm8ddzwhc		bmq7jiumpib3xdz3mx5iyo99ro	0	1672924799925	1672924799925	0
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
g18pe3wojtr65rnxnm4ugmuq4h	3zats68fztgu9mgu944a4t35so	1672923120313	\N
u3ui7pauojynpf6ho5unykg4qc	98kwr77m4jgwmbdgygknaowcch	1672924805751	\N
hmim91mc7t88urik4qresfo3oh	98kwr77m4jgwmbdgygknaowcch	1672924805792	\N
g18pe3wojtr65rnxnm4ugmuq4h	1fgsimi9s3rmjxzxsaeqrr66ko	1672923120265	1673367804235
g18pe3wojtr65rnxnm4ugmuq4h	she685ewdtyq7m7jgmys7zoqmr	1672923120166	1673367804245
g18pe3wojtr65rnxnm4ugmuq4h	bmq7jiumpib3xdz3mx5iyo99ro	1672923120312	1673367804337
\.


--
-- Data for Name: channelmembers; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.channelmembers (channelid, userid, roles, lastviewedat, msgcount, mentioncount, notifyprops, lastupdateat, schemeuser, schemeadmin, schemeguest, mentioncountroot, msgcountroot) FROM stdin;
cxtmz3ubz3gfigd5m6prendmsw	98kwr77m4jgwmbdgygknaowcch		1672922547481	9	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1672924679101	t	f	f	0	14
73uy6kj1jb8wdqrf3ti6zies6r	5bw66y36bff3umq1q57mfy4y5c		1672923027698	5	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1672924679101	t	f	f	0	10
g18pe3wojtr65rnxnm4ugmuq4h	5bw66y36bff3umq1q57mfy4y5c		1672923135329	1	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1672923135329	t	t	f	0	7
hmim91mc7t88urik4qresfo3oh	98kwr77m4jgwmbdgygknaowcch		0	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1672924805784	t	t	f	0	0
u3ui7pauojynpf6ho5unykg4qc	98kwr77m4jgwmbdgygknaowcch		1672924805764	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1672924805764	t	t	f	0	0
73uy6kj1jb8wdqrf3ti6zies6r	98kwr77m4jgwmbdgygknaowcch		1672923027698	5	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1672923027698	t	f	f	0	10
cxtmz3ubz3gfigd5m6prendmsw	bmq7jiumpib3xdz3mx5iyo99ro		1672922547481	9	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1672922547481	t	f	f	0	14
73uy6kj1jb8wdqrf3ti6zies6r	bmq7jiumpib3xdz3mx5iyo99ro		1672925487995	8	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1672925487995	t	f	f	0	13
73uy6kj1jb8wdqrf3ti6zies6r	0z4okgmv5lfhx3p0tf6pnpk8sk		0	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1598351852041	t	f	f	0	0
73uy6kj1jb8wdqrf3ti6zies6r	1fgsimi9s3rmjxzxsaeqrr66ko		1672856710756	3	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1672856710756	t	f	f	0	0
73uy6kj1jb8wdqrf3ti6zies6r	3zats68fztgu9mgu944a4t35so		1672856707526	2	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1672856707526	t	f	f	0	0
73uy6kj1jb8wdqrf3ti6zies6r	kgr5hfwxy78k5n9gfkdhcscdoc		0	0	1	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1672856704360	t	f	f	0	0
73uy6kj1jb8wdqrf3ti6zies6r	she685ewdtyq7m7jgmys7zoqmr		0	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1672922248719	t	f	f	0	0
cxtmz3ubz3gfigd5m6prendmsw	0z4okgmv5lfhx3p0tf6pnpk8sk		0	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1598351852017	t	f	f	0	0
cxtmz3ubz3gfigd5m6prendmsw	5bw66y36bff3umq1q57mfy4y5c		1673367882634	11	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1673367882634	t	f	f	0	16
cxtmz3ubz3gfigd5m6prendmsw	1fgsimi9s3rmjxzxsaeqrr66ko		1672856708115	6	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1672856708115	t	f	f	0	0
cxtmz3ubz3gfigd5m6prendmsw	3zats68fztgu9mgu944a4t35so		0	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1598351852017	t	f	f	0	0
cxtmz3ubz3gfigd5m6prendmsw	kgr5hfwxy78k5n9gfkdhcscdoc		1672856706939	4	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1672856706939	t	f	f	0	0
cxtmz3ubz3gfigd5m6prendmsw	she685ewdtyq7m7jgmys7zoqmr		0	0	2	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1672922547495	t	f	f	0	0
g18pe3wojtr65rnxnm4ugmuq4h	3zats68fztgu9mgu944a4t35so		0	0	1	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1672923120359	t	f	f	0	0
g18pe3wojtr65rnxnm4ugmuq4h	98kwr77m4jgwmbdgygknaowcch		0	0	1	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1672923120265	t	f	f	0	0
\.


--
-- Data for Name: channels; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.channels (id, createat, updateat, deleteat, teamid, type, displayname, name, header, purpose, lastpostat, totalmsgcount, extraupdateat, creatorid, schemeid, groupconstrained, shared, totalmsgcountroot, lastrootpostat) FROM stdin;
9eiccer1gfbzzpf8yfbze74n3e	1672921846247	1672921846247	0	7jenmotdwfdq7mmci7zz7hfpze	O	Town Square	town-square			1672922135142	0	0		\N	\N	\N	2	1672922135142
dckusnmodbnubf7hcu369adaio	1672921846260	1672922076863	0	7jenmotdwfdq7mmci7zz7hfpze	P	Off-Topic	off-topic			1672922076871	1	0		\N	\N	\N	2	1672922076871
u3ui7pauojynpf6ho5unykg4qc	1672924805691	1672924805691	0	gajwz6y3efb3mcrsman43cqmxo	O	Town Square	town-square			1672924805764	0	0		\N	\N	\N	0	1672924805764
hmim91mc7t88urik4qresfo3oh	1672924805702	1672924805702	0	gajwz6y3efb3mcrsman43cqmxo	O	Off-Topic	off-topic			1672924805795	0	0		\N	\N	\N	0	1672924805795
73uy6kj1jb8wdqrf3ti6zies6r	1598351837717	1598351837717	0	tgrw7sjgbiy1jggs3qg3m6zpee	O	Off-Topic	off-topic			1672925487995	8	0		\N	\N	\N	13	1672925487995
g18pe3wojtr65rnxnm4ugmuq4h	1672923085547	1672923085547	0	tgrw7sjgbiy1jggs3qg3m6zpee	O	Bugs in bridge	bugs-in-bridge			1673367804341	1	0	5bw66y36bff3umq1q57mfy4y5c		f	\N	7	1673367804341
cxtmz3ubz3gfigd5m6prendmsw	1598351837713	1598351837713	0	tgrw7sjgbiy1jggs3qg3m6zpee	O	Town Square	town-square			1673367882634	11	0		\N	\N	\N	16	1673367882634
\.


--
-- Data for Name: clusterdiscovery; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.clusterdiscovery (id, type, clustername, hostname, gossipport, port, createat, lastpingat) FROM stdin;
\.


--
-- Data for Name: commands; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.commands (id, token, createat, updateat, deleteat, creatorid, teamid, trigger, method, username, iconurl, autocomplete, autocompletedesc, autocompletehint, displayname, description, url, pluginid) FROM stdin;
\.


--
-- Data for Name: commandwebhooks; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.commandwebhooks (id, createat, commandid, userid, channelid, rootid, usecount) FROM stdin;
\.


--
-- Data for Name: compliances; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.compliances (id, createat, userid, status, count, "desc", type, startat, endat, keywords, emails) FROM stdin;
\.


--
-- Data for Name: db_lock; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.db_lock (id, expireat) FROM stdin;
\.


--
-- Data for Name: db_migrations; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.db_migrations (version, name) FROM stdin;
1	create_teams
2	create_team_members
3	create_cluster_discovery
4	create_command_webhooks
5	create_compliances
6	create_emojis
7	create_user_groups
8	create_group_members
9	create_group_teams
10	create_group_channels
11	create_link_metadata
12	create_commands
13	create_incoming_webhooks
14	create_outgoing_webhooks
15	create_systems
16	create_reactions
17	create_roles
18	create_schemes
19	create_licenses
20	create_posts
21	create_product_notice_view_state
22	create_sessions
23	create_terms_of_service
24	create_audits
25	create_oauth_access_data
26	create_preferences
27	create_status
28	create_tokens
29	create_bots
30	create_user_access_tokens
31	create_remote_clusters
32	create_sharedchannels
33	create_sidebar_channels
34	create_oauthauthdata
35	create_sharedchannelattachments
36	create_sharedchannelusers
37	create_sharedchannelremotes
38	create_jobs
39	create_channel_member_history
40	create_sidebar_categories
41	create_upload_sessions
42	create_threads
43	thread_memberships
44	create_user_terms_of_service
45	create_plugin_key_value_store
46	create_users
47	create_file_info
48	create_oauth_apps
49	create_channels
50	create_channelmembers
51	create_msg_root_count
52	create_public_channels
53	create_retention_policies
54	create_crt_channelmembership_count
55	create_crt_thread_count_and_unreads
56	upgrade_channels_v6.0
57	upgrade_command_webhooks_v6.0
58	upgrade_channelmembers_v6.0
59	upgrade_users_v6.0
60	upgrade_jobs_v6.0
61	upgrade_link_metadata_v6.0
62	upgrade_sessions_v6.0
63	upgrade_threads_v6.0
64	upgrade_status_v6.0
65	upgrade_groupchannels_v6.0
66	upgrade_posts_v6.0
67	upgrade_channelmembers_v6.1
68	upgrade_teammembers_v6.1
69	upgrade_jobs_v6.1
70	upgrade_cte_v6.1
71	upgrade_sessions_v6.1
72	upgrade_schemes_v6.3
73	upgrade_plugin_key_value_store_v6.3
74	upgrade_users_v6.3
75	alter_upload_sessions_index
76	upgrade_lastrootpostat
77	upgrade_users_v6.5
78	create_oauth_mattermost_app_id
79	usergroups_displayname_index
80	posts_createat_id
81	threads_deleteat
82	upgrade_oauth_mattermost_app_id
83	threads_threaddeleteat
84	recent_searches
85	fileinfo_add_archived_column
86	add_cloud_limits_archived
87	sidebar_categories_index
88	remaining_migrations
89	add-channelid-to-reaction
90	create_enums
91	create_post_reminder
92	add_createat_to_teamembers
93	notify_admin
95	remove_posts_parentid
\.


--
-- Data for Name: emoji; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.emoji (id, createat, updateat, deleteat, creatorid, name) FROM stdin;
\.


--
-- Data for Name: fileinfo; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.fileinfo (id, creatorid, postid, createat, updateat, deleteat, path, thumbnailpath, previewpath, name, extension, size, mimetype, width, height, haspreviewimage, minipreview, content, remoteid, archived) FROM stdin;
kpadhxdtotddukna1hnf993bir	3zats68fztgu9mgu944a4t35so	7qj53zemsbnzdgad76g9ifw6hc	1672856707505	1672856707505	0	20230104/teams/noteam/channels/73uy6kj1jb8wdqrf3ti6zies6r/users/3zats68fztgu9mgu944a4t35so/kpadhxdtotddukna1hnf993bir/filename			filename		11		0	0	f	\N	\N	\N	f
neqkjkfddigrpbn13jtppboecw	1fgsimi9s3rmjxzxsaeqrr66ko	op4mz46j4pywu8at8f9k5hk8wy	1672856708099	1672856708099	0	20230104/teams/noteam/channels/cxtmz3ubz3gfigd5m6prendmsw/users/1fgsimi9s3rmjxzxsaeqrr66ko/neqkjkfddigrpbn13jtppboecw/mydata			mydata		8		0	0	f	\N	\N	\N	f
t5mx13mgzby65be4tgz33qnppc	98kwr77m4jgwmbdgygknaowcch	grcxd88ak7rsxpia59fadzb7aa	1672922641890	1672922641890	0	20230105/teams/noteam/channels/73uy6kj1jb8wdqrf3ti6zies6r/users/98kwr77m4jgwmbdgygknaowcch/t5mx13mgzby65be4tgz33qnppc/Testing_in_VS_Code.png	20230105/teams/noteam/channels/73uy6kj1jb8wdqrf3ti6zies6r/users/98kwr77m4jgwmbdgygknaowcch/t5mx13mgzby65be4tgz33qnppc/Testing_in_VS_Code_thumb.jpg	20230105/teams/noteam/channels/73uy6kj1jb8wdqrf3ti6zies6r/users/98kwr77m4jgwmbdgygknaowcch/t5mx13mgzby65be4tgz33qnppc/Testing_in_VS_Code_preview.jpg	Testing_in_VS_Code.png	png	172914	image/png	993	533	t	\N	\N	\N	f
n8ihtkozc3f8tk7yornbfx49zw	bmq7jiumpib3xdz3mx5iyo99ro	y3s8zhw5g78jiey4kizi541fbe	1672925353840	1672925353840	0	20230105/teams/noteam/channels/73uy6kj1jb8wdqrf3ti6zies6r/users/bmq7jiumpib3xdz3mx5iyo99ro/n8ihtkozc3f8tk7yornbfx49zw/Testing_in_VS_Code.png	20230105/teams/noteam/channels/73uy6kj1jb8wdqrf3ti6zies6r/users/bmq7jiumpib3xdz3mx5iyo99ro/n8ihtkozc3f8tk7yornbfx49zw/Testing_in_VS_Code_thumb.png	20230105/teams/noteam/channels/73uy6kj1jb8wdqrf3ti6zies6r/users/bmq7jiumpib3xdz3mx5iyo99ro/n8ihtkozc3f8tk7yornbfx49zw/Testing_in_VS_Code_preview.png	Testing_in_VS_Code.png	png	172914	image/png	993	533	t	\\xffd8ffdb0084000302020302020303030304030304050805050404050a070706080c0a0c0c0b0a0b0b0d0e12100d0e110e0b0b1016101113141515150c0f1718161418121415140103040405040509050509140d0b0d1414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414ffc00011080010001003012200021101031101ffc401a20000010501010101010100000000000000000102030405060708090a0b100002010303020403050504040000017d01020300041105122131410613516107227114328191a1082342b1c11552d1f02433627282090a161718191a25262728292a3435363738393a434445464748494a535455565758595a636465666768696a737475767778797a838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae1e2e3e4e5e6e7e8e9eaf1f2f3f4f5f6f7f8f9fa0100030101010101010101010000000000000102030405060708090a0b1100020102040403040705040400010277000102031104052131061241510761711322328108144291a1b1c109233352f0156272d10a162434e125f11718191a262728292a35363738393a434445464748494a535455565758595a636465666768696a737475767778797a82838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae2e3e4e5e6e7e8e9eaf2f3f4f5f6f7f8f9faffda000c03010002110311003f00f8b75d4916349d238632242a260f897ef11f773cfd715997bbe032093509d360f970a53712391fad3b55be4944d1bdba34c2563e777c124e302a8cf05a963e589541181e6c0c4e7d783552dc7d6e7fffd9			f
\.


--
-- Data for Name: focalboard_blocks; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_blocks (id, insert_at, parent_id, schema, type, title, fields, create_at, update_at, delete_at, root_id, modified_by, channel_id, created_by, board_id) FROM stdin;
cbqcirmn8qbg37rbb1oi9wssn3c	2023-01-05 13:18:08.040999+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Team Schedule	{"contentOrder":["aq7bk8rb1gpguifcufifr9sgruh","7xk7a7oazuf8wuk3wp8z5xk6wpr","asyj88s75iibdfk6yq49j8dn7ye","7ax5mfu8y9j8b3ym448seti1x7h","7a4oq3xac47gqxm54broj4qtfmw","7rowytdjuqfrkt8ctpfybbon7ec"],"icon":"⏰","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"8b05c83e-a44a-4d04-831e-97f01d8e2003","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"34eb9c25-d5bf-49d9-859e-f74f4e0030e7"}}	1672924688065	1672924688065	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
c6c79y58wibgntkec89b5e7npza	2023-01-05 13:18:08.040999+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Video production	{"contentOrder":["afbdugcwt1fbe5k6e8ycjis3skc","7fngf88u5ujy9fn39jk1jq4x7fy","ahq8scq9dh38jjcasx9xh78smow","7in5wd35qpjfk8r4fb8hzwhy3sc","7nhzwpx41spbainnsjhdmxm7zaa","736oquxuqopnbtkzd85ko8b3xay"],"icon":"📹","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"b1abafbf-a038-4a19-8b68-56e0fd2319f7","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"34eb9c25-d5bf-49d9-859e-f74f4e0030e7"}}	1672924688076	1672924688076	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
cen6uu3mp3pyjzmypn4xj1btzaa	2023-01-05 13:18:08.040999+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Offsite plans	{"contentOrder":["anynwy9z4w3gd3xbgxtqc5ndgfr","73ax5mxqfkpr99ma3iafgxk85xy","ahdkdokimmtdbtcch6oco4k1thh","7ukkuj968pffubghr8794rph4mc","7kecouiecgj8j7d7dn5uyobqkfo","7ho5n6jipybg65mzz88fgpmdkno"],"icon":"🚙","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"8b05c83e-a44a-4d04-831e-97f01d8e2003","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"dabadd9b-adf1-4d9f-8702-805ac6cef602"}}	1672924688083	1672924688083	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
c9qfk7kfisjfyxyj4p71hpm3t4r	2023-01-05 13:18:08.040999+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Social Media Strategy	{"contentOrder":["a8xa66f4mw3b7jr86so5qfuqw5a","7ekd33wgtapynxbyoghrepd8muy","aw55eypd7ubd35dk4ifn9ptzdjy","74bnf8eq5rtf4pf9df4k7sppnia","7ybr96k6bwfy7xmkypzz49waxih","73ia6i59unjfr9nki7dpouy6ipc"],"icon":"🎉","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"b1abafbf-a038-4a19-8b68-56e0fd2319f7","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"d37a61f4-f332-4db9-8b2d-5e0a91aa20ed"}}	1672924688089	1672924688089	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
vgd65knqp1tr5tpo48zdciey4sy	2023-01-05 13:18:08.040999+00	b7wnw9awd4pnefryhq51apbzb4c	1	view	Discussion Items	{"cardOrder":["cjpkiya33qsagr4f9hrdwhgiajc"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"d777ba3b-8728-40d1-87a6-59406bbbbfb0","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[{"propertyId":"4cf1568d-530f-4028-8ffd-bdc65249187e","reversed":false}],"viewType":"board","visibleOptionIds":[],"visiblePropertyIds":["4cf1568d-530f-4028-8ffd-bdc65249187e"]}	1672924688096	1672924688096	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
7a4oq3xac47gqxm54broj4qtfmw	2023-01-05 13:18:08.040999+00	cbqcirmn8qbg37rbb1oi9wssn3c	1	checkbox		{"value":false}	1672924688101	1672924688101	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
7ax5mfu8y9j8b3ym448seti1x7h	2023-01-05 13:18:08.040999+00	cbqcirmn8qbg37rbb1oi9wssn3c	1	checkbox		{"value":false}	1672924688108	1672924688108	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
7xk7a7oazuf8wuk3wp8z5xk6wpr	2023-01-05 13:18:08.040999+00	cbqcirmn8qbg37rbb1oi9wssn3c	1	divider		{}	1672924688110	1672924688110	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
7rowytdjuqfrkt8ctpfybbon7ec	2023-01-05 13:18:08.040999+00	cbqcirmn8qbg37rbb1oi9wssn3c	1	checkbox		{"value":false}	1672924688117	1672924688117	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
aq7bk8rb1gpguifcufifr9sgruh	2023-01-05 13:18:08.040999+00	cbqcirmn8qbg37rbb1oi9wssn3c	1	text	## Notes\n*[Add meeting notes here]*	{}	1672924688122	1672924688122	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
asyj88s75iibdfk6yq49j8dn7ye	2023-01-05 13:18:08.040999+00	cbqcirmn8qbg37rbb1oi9wssn3c	1	text	## Action Items	{}	1672924688127	1672924688127	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
7b1741iwyx7bh3kb6eyam9p3hhe	2023-01-05 13:18:08.040999+00	ch798q5ucefyobf5bymgqjt4f3h	1	divider		{}	1672924688133	1672924688133	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
76h4zaks4gtytfmxss7199a1wao	2023-01-05 13:18:08.040999+00	ch798q5ucefyobf5bymgqjt4f3h	1	checkbox		{"value":false}	1672924688137	1672924688137	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
73xiqkhgzepgo9xe8ac5yhn6opo	2023-01-05 13:18:08.040999+00	ch798q5ucefyobf5bymgqjt4f3h	1	checkbox		{"value":false}	1672924688143	1672924688143	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
7yhwf8r9zo3rkjbzt8ox3h8taqw	2023-01-05 13:18:08.040999+00	ch798q5ucefyobf5bymgqjt4f3h	1	checkbox		{"value":false}	1672924688149	1672924688149	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
a11s7aquzo3guxkkfzce4aif5hh	2023-01-05 13:18:08.040999+00	ch798q5ucefyobf5bymgqjt4f3h	1	text	# Action Items	{}	1672924688155	1672924688155	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
acahxzqs89f8r3n45jzhhnjhyao	2023-01-05 13:18:08.040999+00	ch798q5ucefyobf5bymgqjt4f3h	1	text	# Notes\n*[Add meeting notes here]*	{}	1672924688161	1672924688161	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
7fngf88u5ujy9fn39jk1jq4x7fy	2023-01-05 13:18:08.040999+00	c6c79y58wibgntkec89b5e7npza	1	divider		{}	1672924688168	1672924688168	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
736oquxuqopnbtkzd85ko8b3xay	2023-01-05 13:18:08.040999+00	c6c79y58wibgntkec89b5e7npza	1	checkbox		{"value":false}	1672924688174	1672924688174	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
7nhzwpx41spbainnsjhdmxm7zaa	2023-01-05 13:18:08.040999+00	c6c79y58wibgntkec89b5e7npza	1	checkbox		{"value":false}	1672924688182	1672924688182	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
7in5wd35qpjfk8r4fb8hzwhy3sc	2023-01-05 13:18:08.040999+00	c6c79y58wibgntkec89b5e7npza	1	checkbox		{"value":false}	1672924688188	1672924688188	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
ahq8scq9dh38jjcasx9xh78smow	2023-01-05 13:18:08.040999+00	c6c79y58wibgntkec89b5e7npza	1	text	## Action Items	{}	1672924688193	1672924688193	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
afbdugcwt1fbe5k6e8ycjis3skc	2023-01-05 13:18:08.040999+00	c6c79y58wibgntkec89b5e7npza	1	text	## Notes\n*[Add meeting notes here]*	{}	1672924688199	1672924688199	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
7ukkuj968pffubghr8794rph4mc	2023-01-05 13:18:08.040999+00	cen6uu3mp3pyjzmypn4xj1btzaa	1	checkbox		{"value":false}	1672924688204	1672924688204	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
7kecouiecgj8j7d7dn5uyobqkfo	2023-01-05 13:18:08.040999+00	cen6uu3mp3pyjzmypn4xj1btzaa	1	checkbox		{"value":false}	1672924688208	1672924688208	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
73ax5mxqfkpr99ma3iafgxk85xy	2023-01-05 13:18:08.040999+00	cen6uu3mp3pyjzmypn4xj1btzaa	1	divider		{}	1672924688214	1672924688214	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
7ho5n6jipybg65mzz88fgpmdkno	2023-01-05 13:18:08.040999+00	cen6uu3mp3pyjzmypn4xj1btzaa	1	checkbox		{"value":false}	1672924688219	1672924688219	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
ahdkdokimmtdbtcch6oco4k1thh	2023-01-05 13:18:08.040999+00	cen6uu3mp3pyjzmypn4xj1btzaa	1	text	## Action Items	{}	1672924688224	1672924688224	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
anynwy9z4w3gd3xbgxtqc5ndgfr	2023-01-05 13:18:08.040999+00	cen6uu3mp3pyjzmypn4xj1btzaa	1	text	## Notes\n*[Add meeting notes here]*	{}	1672924688239	1672924688239	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
7ekd33wgtapynxbyoghrepd8muy	2023-01-05 13:18:08.040999+00	c9qfk7kfisjfyxyj4p71hpm3t4r	1	divider		{}	1672924688254	1672924688254	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
7ybr96k6bwfy7xmkypzz49waxih	2023-01-05 13:18:08.040999+00	c9qfk7kfisjfyxyj4p71hpm3t4r	1	checkbox		{"value":false}	1672924688268	1672924688268	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
73ia6i59unjfr9nki7dpouy6ipc	2023-01-05 13:18:08.040999+00	c9qfk7kfisjfyxyj4p71hpm3t4r	1	checkbox		{"value":false}	1672924688298	1672924688298	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
74bnf8eq5rtf4pf9df4k7sppnia	2023-01-05 13:18:08.040999+00	c9qfk7kfisjfyxyj4p71hpm3t4r	1	checkbox		{"value":false}	1672924688313	1672924688313	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
aw55eypd7ubd35dk4ifn9ptzdjy	2023-01-05 13:18:08.040999+00	c9qfk7kfisjfyxyj4p71hpm3t4r	1	text	## Action Items	{}	1672924688325	1672924688325	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
a8xa66f4mw3b7jr86so5qfuqw5a	2023-01-05 13:18:08.040999+00	c9qfk7kfisjfyxyj4p71hpm3t4r	1	text	## Notes\n*[Add meeting notes here]*	{}	1672924688328	1672924688328	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
v3aq4mpy5hfbg9etg756hk7rntw	2023-01-05 13:18:08.726993+00		1	view	All Contacts	{"cardOrder":["ckim1iz9ni78p8dnf3cmn8td16a","ctawerdpkn78od8muh9szjke3yw","cyra1n9ydbbfpm8dcjjpk7ymyrr","c95j3yj5xoiyrmy3onnk57aaido","c59eubrnukjytb8zik1auzyu41a"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":240,"a1438fbbhjeffkexmcfhnx99o1h":151,"a5hwxjsmkn6bak6r7uea5bx1kwc":132,"abru6tz8uebdxy4skheqidh7zxy":247,"adtf1151chornmihz4xbgbk9exa":125,"aejo5tcmq54bauuueem9wc4fw4y":127,"ahf43e44h3y8ftanqgzno9z7q7w":129,"ainpw47babwkpyj77ic4b9zq9xr":157,"amahgyn9n4twaapg3jyxb6y4jic":224,"amba7ot98fh7hwsx8jdcfst5g7h":171,"aoheuj1f3mu6eehygr45fxa144y":130,"auhf91pm85f73swwidi4wid8jqe":157},"defaultTemplateId":"cw8g9n58zwbri8pxtsx7wgny7uw","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a5hwxjsmkn6bak6r7uea5bx1kwc","aoheuj1f3mu6eehygr45fxa144y","aro91wme9kfaie5ceu9qasmtcnw","ainpw47babwkpyj77ic4b9zq9xr","ahf43e44h3y8ftanqgzno9z7q7w","amahgyn9n4twaapg3jyxb6y4jic","abru6tz8uebdxy4skheqidh7zxy","a1438fbbhjeffkexmcfhnx99o1h","auhf91pm85f73swwidi4wid8jqe","adtf1151chornmihz4xbgbk9exa","aejo5tcmq54bauuueem9wc4fw4y","amba7ot98fh7hwsx8jdcfst5g7h"]}	1672924688735	1672924688735	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
vwaon9gp7tfrsfydsecfitchjuw	2023-01-05 13:18:08.726993+00		1	view	Pipeline Tracker	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["akj61wc9yxdwyw3t6m8igyf9d5o","aic89a5xox4wbppi6mbyx6ujsda","ah6ehh43rwj88jy4awensin8pcw","aprhd96zwi34o9cs4xyr3o9sf3c","axesd74yuxtbmw1sbk8ufax7z3a","a5txuiubumsmrs8gsd5jz5gc1oa","acm9q494bcthyoqzmfogxxy5czy"],"visiblePropertyIds":["aro91wme9kfaie5ceu9qasmtcnw","amahgyn9n4twaapg3jyxb6y4jic"]}	1672924688739	1672924688739	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
c95j3yj5xoiyrmy3onnk57aaido	2023-01-05 13:18:08.726993+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Jonathan Frazier	{"contentOrder":["a1thgrfqf97f9uqaux3gigxf8kh","ae3wbxp9msbfm7yg43kx47o6say","7d648jwamtfn1zprgcdwxa9fa7w","71niq5m16npdptepwdkbrsaj5ua","7ccjhsxjft7fu7yd7ehw4bwrdjr","73guwp5f197be9gra6gwibgtfca","7tr1qzcab7pfg3xh3e4eydpzs3r","7j87tdfaeab8m5fr7i3ne4tie8a","7g6ni9ass4jfz3jx94pkx9hhw6c","79733nepdxt8s3nyyfdsqaw763w","7auyu7r16kjdfppgqxffrtascoo","7zy4rbp6z1bfm7cq6mehw3udu5w"],"icon":"🙎‍♂️","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(999) 123-5678","a5hwxjsmkn6bak6r7uea5bx1kwc":"a5txuiubumsmrs8gsd5jz5gc1oa","abru6tz8uebdxy4skheqidh7zxy":"jonathan.frazier@email.com","aejo5tcmq54bauuueem9wc4fw4y":"0%","ahf43e44h3y8ftanqgzno9z7q7w":"$800,000","ainpw47babwkpyj77ic4b9zq9xr":"Ositions Inc.","amahgyn9n4twaapg3jyxb6y4jic":"as5bk6afoaaa7caewe1zc391sce","aro91wme9kfaie5ceu9qasmtcnw":"apiswzj7uiwbh87z8dw8c6mturw","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1669118400000}"}}	1672924688742	1672924688742	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
cyra1n9ydbbfpm8dcjjpk7ymyrr	2023-01-05 13:18:08.726993+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Richard Guzman	{"contentOrder":["ao3yjboejpp8ctrnwhhd1p7k9gr","arnctww5wqfrnjmz41dn66k8y4h","71nxk1f67oir1dbzfzpho1eq57h","7pft8zmrcxfrjdem7yjzss75t6h","77jco8uqrsprjifahnfxzsy6oqa","7qnf39zsarpf6px9ynkwkd6afcy","7rp6xxiprz7n1jphruncff89poc","71stmm4z957fzucbmu8ofmjnupr","7w8ajh5wcp3bmirw3x7631sprur","7ia43dczwcigq78u43utqx1rdbr","7ht8fk4zq13fpmpmufhenz3o45c","78d14xwe877f79fi8rn1efizunw"],"icon":"👨‍💼","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(222) 123-1234","a5hwxjsmkn6bak6r7uea5bx1kwc":"axesd74yuxtbmw1sbk8ufax7z3a","abru6tz8uebdxy4skheqidh7zxy":"richard.guzman@email.com","adtf1151chornmihz4xbgbk9exa":"{\\"from\\":1681992000000}","aejo5tcmq54bauuueem9wc4fw4y":"80%","ahf43e44h3y8ftanqgzno9z7q7w":"$3,200,000","ainpw47babwkpyj77ic4b9zq9xr":"Afformance Ltd.","amahgyn9n4twaapg3jyxb6y4jic":"ar6t1ttcumgfuqugg5o4g4mzrza","aro91wme9kfaie5ceu9qasmtcnw":"apjnaggwixchfxwiatfh7ey7uno","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1667476800000}"}}	1672924688745	1672924688745	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
c59eubrnukjytb8zik1auzyu41a	2023-01-05 13:18:08.726993+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Byron Cole	{"contentOrder":["anixf3fgofjyc9rjwoy9mp4ybco","aaiqjc55eqbgtinmmsq9ks83huy","7p6dfjronm7fijnaipbdabxnwdr","7sfpuuujb8byiid9znf4msq6gwc","73cpzmh8kd7dw9qkmafnm5te3ta","7xrjsgf4t4jryu8qnnnmc6qsqhe","7ido7ki339fbc7ndrdsq5i1wrty","7taz7tg8dbbdj9qibcdbkrf38zh","75hr3rf3bstrqdxt3pxeka3q13o","7p1111nx84tnpinzxdw7x4jw4po","749purgzp5fd7xnjigngs9ojiry","7jexqrhodftystde85pqir91npw"],"icon":"🤵","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(333) 123-1234","a5hwxjsmkn6bak6r7uea5bx1kwc":"acm9q494bcthyoqzmfogxxy5czy","abru6tz8uebdxy4skheqidh7zxy":"byron.cole@email.com","adtf1151chornmihz4xbgbk9exa":"{\\"from\\":1667563200000}","aejo5tcmq54bauuueem9wc4fw4y":"100%","ahf43e44h3y8ftanqgzno9z7q7w":"$500,000","ainpw47babwkpyj77ic4b9zq9xr":"Helx Industries","amahgyn9n4twaapg3jyxb6y4jic":"aafwyza5iwdcwcyfyj6bp7emufw","aro91wme9kfaie5ceu9qasmtcnw":"apjnaggwixchfxwiatfh7ey7uno","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1667822400000}"}}	1672924688750	1672924688750	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7ht8fk4zq13fpmpmufhenz3o45c	2023-01-05 13:18:08.726993+00	cyra1n9ydbbfpm8dcjjpk7ymyrr	1	checkbox	Hand-off to customer success	{}	1672924688855	1672924688855	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7ia43dczwcigq78u43utqx1rdbr	2023-01-05 13:18:08.726993+00	cyra1n9ydbbfpm8dcjjpk7ymyrr	1	checkbox	Finalize contract	{}	1672924688866	1672924688866	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
78d14xwe877f79fi8rn1efizunw	2023-01-05 13:18:08.726993+00	cyra1n9ydbbfpm8dcjjpk7ymyrr	1	checkbox	Post-sales follow up	{}	1672924688876	1672924688876	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
ctawerdpkn78od8muh9szjke3yw	2023-01-05 13:18:08.726993+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Caitlyn Russel	{"contentOrder":["ac5e3358d9tnnfmmtb8wtscdbie","a6shdw6mastdzdfpcf34twpcq9r","7tsqz4e5rpjrfpnfoy6irfc9cco","7h8ozcg9wkino9do1qece83t66o","7h4augwa4mfyydji34ebgszrrbc","77y9fnhu667fdtgrdf9pek887xo","7p4raiw7fo7r1injenypggxbg7w","716mzzxsqrbyb9f1ekybnz3nqjo","7b6ye18kuu3fw9rnndn5eoekjrc","79w9fmkscj3y79pmwourkt5b4ro","7k7hok4xi9tfizr1umk1pd7ieno","7yhc86iw3hpye5xgixqe9zubwey"],"icon":"🧑‍💼","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(111) 123-1234","a5hwxjsmkn6bak6r7uea5bx1kwc":"ah6ehh43rwj88jy4awensin8pcw","abru6tz8uebdxy4skheqidh7zxy":"caitlyn.russel@email.com","adtf1151chornmihz4xbgbk9exa":"{\\"from\\":1689336000000}","aejo5tcmq54bauuueem9wc4fw4y":"20%","ahf43e44h3y8ftanqgzno9z7q7w":"$250,000","ainpw47babwkpyj77ic4b9zq9xr":"Liminary Corp.","amahgyn9n4twaapg3jyxb6y4jic":"aafwyza5iwdcwcyfyj6bp7emufw","aro91wme9kfaie5ceu9qasmtcnw":"apiswzj7uiwbh87z8dw8c6mturw","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1668168000000}"}}	1672924688753	1672924688753	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
cw8g9n58zwbri8pxtsx7wgny7uw	2023-01-05 13:18:08.726993+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	New Prospect	{"contentOrder":["aqqdyed4m3bge9ksh8hac1t4a3r","akticbfzqqjrx9fyxjqy476fboo","7t4j64do36jrtmgkj37k7ygohqa","7316jzfyex3buieeg61p3uanu8w","7u396wm7kc3r63kxp3gqreqopwa","7w3jxjnm1qpf1dfycxch4h5qqhw","7ya4xtzikgtf4mma7ib34tmu94h","7hn1c3mgyr7de7po3tmccguokfe","77uzu5w7rxp8hdk4dz6bpw5g8ph","7thmioo3xn38ztfi69sohbq9yea","7ghyopfdwkbyy8xtetzrux1a3ay","78twi939pd7fcxgp6buspj4imar"],"icon":"👤","isTemplate":true,"properties":{"a5hwxjsmkn6bak6r7uea5bx1kwc":"akj61wc9yxdwyw3t6m8igyf9d5o"}}	1672924688758	1672924688758	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
ckim1iz9ni78p8dnf3cmn8td16a	2023-01-05 13:18:08.726993+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Shelby Olson	{"contentOrder":["a33h531muhjdjddtg6xtq8tis8y","aapqd3aoswbyxfnbpcipinpt31h","7rkdt3izojtf6m8ek7436h3s5by","7xgcriqsp9by59y1cygejbn7wme","745hidcaqatn4ff7oj5qibkp9fr","78m6x9c6gufdr5q47rpgazbobjy","7ahicq1xmmfftfqddmjwgyfrzbr","7fn47owkpzifb7gmhrmqz8otyto","7z5agzxkddbrmzj5ui9e79iaite","74mccbbbrbjr53g4bztt7eaozmw","7dwz15ofwdpyk3fkqfh7ps9nk9a","7frgsmw9xe7nr3jxp8xu7am44zy"],"icon":"🙎‍♀️","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(111) 321-5678","a5hwxjsmkn6bak6r7uea5bx1kwc":"akj61wc9yxdwyw3t6m8igyf9d5o","abru6tz8uebdxy4skheqidh7zxy":"shelby.olson@email.com","ahf43e44h3y8ftanqgzno9z7q7w":"$30,000","ainpw47babwkpyj77ic4b9zq9xr":"Kadera Global","amahgyn9n4twaapg3jyxb6y4jic":"ar6t1ttcumgfuqugg5o4g4mzrza","aro91wme9kfaie5ceu9qasmtcnw":"auu9bfzqeuruyjwzzqgz7q8apuw","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1669291200000}"}}	1672924688762	1672924688762	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
vbgmgd1bb3fd7ukmhtukmzd915y	2023-01-05 13:18:08.726993+00	bzwb99zf498tsm7mjqbiy7g81ze	1	view	Open Deals	{"cardOrder":["ctawerdpkn78od8muh9szjke3yw"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[{"condition":"includes","propertyId":"a5hwxjsmkn6bak6r7uea5bx1kwc","values":["akj61wc9yxdwyw3t6m8igyf9d5o","aic89a5xox4wbppi6mbyx6ujsda","ah6ehh43rwj88jy4awensin8pcw","aprhd96zwi34o9cs4xyr3o9sf3c","axesd74yuxtbmw1sbk8ufax7z3a"]}],"operation":"and"},"groupById":"aro91wme9kfaie5ceu9qasmtcnw","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["apjnaggwixchfxwiatfh7ey7uno","apiswzj7uiwbh87z8dw8c6mturw","auu9bfzqeuruyjwzzqgz7q8apuw",""],"visiblePropertyIds":[]}	1672924688766	1672924688766	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7d648jwamtfn1zprgcdwxa9fa7w	2023-01-05 13:18:08.726993+00	c95j3yj5xoiyrmy3onnk57aaido	1	checkbox	Send initial email	{"value":true}	1672924688770	1672924688770	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
71niq5m16npdptepwdkbrsaj5ua	2023-01-05 13:18:08.726993+00	c95j3yj5xoiyrmy3onnk57aaido	1	checkbox	Send follow-up email	{"value":true}	1672924688774	1672924688774	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7g6ni9ass4jfz3jx94pkx9hhw6c	2023-01-05 13:18:08.726993+00	c95j3yj5xoiyrmy3onnk57aaido	1	checkbox	Send proposal	{"value":true}	1672924688777	1672924688777	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
79733nepdxt8s3nyyfdsqaw763w	2023-01-05 13:18:08.726993+00	c95j3yj5xoiyrmy3onnk57aaido	1	checkbox	Finalize contract	{}	1672924688782	1672924688782	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7ccjhsxjft7fu7yd7ehw4bwrdjr	2023-01-05 13:18:08.726993+00	c95j3yj5xoiyrmy3onnk57aaido	1	checkbox	Schedule initial sales call	{"value":true}	1672924688787	1672924688787	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7tr1qzcab7pfg3xh3e4eydpzs3r	2023-01-05 13:18:08.726993+00	c95j3yj5xoiyrmy3onnk57aaido	1	checkbox	Schedule demo	{"value":true}	1672924688792	1672924688792	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7auyu7r16kjdfppgqxffrtascoo	2023-01-05 13:18:08.726993+00	c95j3yj5xoiyrmy3onnk57aaido	1	checkbox	Hand-off to customer success	{}	1672924688798	1672924688798	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7j87tdfaeab8m5fr7i3ne4tie8a	2023-01-05 13:18:08.726993+00	c95j3yj5xoiyrmy3onnk57aaido	1	checkbox	Follow up after demo	{"value":true}	1672924688805	1672924688805	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
73guwp5f197be9gra6gwibgtfca	2023-01-05 13:18:08.726993+00	c95j3yj5xoiyrmy3onnk57aaido	1	checkbox	Schedule follow-up sales call	{"value":true}	1672924688811	1672924688811	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7zy4rbp6z1bfm7cq6mehw3udu5w	2023-01-05 13:18:08.726993+00	c95j3yj5xoiyrmy3onnk57aaido	1	checkbox	Post-sales follow up	{}	1672924688819	1672924688819	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
ae3wbxp9msbfm7yg43kx47o6say	2023-01-05 13:18:08.726993+00	c95j3yj5xoiyrmy3onnk57aaido	1	text	## Checklist	{}	1672924688825	1672924688825	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
a1thgrfqf97f9uqaux3gigxf8kh	2023-01-05 13:18:08.726993+00	c95j3yj5xoiyrmy3onnk57aaido	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1672924688831	1672924688831	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
71nxk1f67oir1dbzfzpho1eq57h	2023-01-05 13:18:08.726993+00	cyra1n9ydbbfpm8dcjjpk7ymyrr	1	checkbox	Send initial email	{"value":true}	1672924688836	1672924688836	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7qnf39zsarpf6px9ynkwkd6afcy	2023-01-05 13:18:08.726993+00	cyra1n9ydbbfpm8dcjjpk7ymyrr	1	checkbox	Schedule follow-up sales call	{"value":true}	1672924688840	1672924688840	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
71stmm4z957fzucbmu8ofmjnupr	2023-01-05 13:18:08.726993+00	cyra1n9ydbbfpm8dcjjpk7ymyrr	1	checkbox	Follow up after demo	{"value":true}	1672924688844	1672924688844	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7w8ajh5wcp3bmirw3x7631sprur	2023-01-05 13:18:08.726993+00	cyra1n9ydbbfpm8dcjjpk7ymyrr	1	checkbox	Send proposal	{"value":true}	1672924688851	1672924688850	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7rp6xxiprz7n1jphruncff89poc	2023-01-05 13:18:08.726993+00	cyra1n9ydbbfpm8dcjjpk7ymyrr	1	checkbox	Schedule demo	{"value":true}	1672924688882	1672924688882	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
77jco8uqrsprjifahnfxzsy6oqa	2023-01-05 13:18:08.726993+00	cyra1n9ydbbfpm8dcjjpk7ymyrr	1	checkbox	Schedule initial sales call	{"value":true}	1672924688888	1672924688888	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7pft8zmrcxfrjdem7yjzss75t6h	2023-01-05 13:18:08.726993+00	cyra1n9ydbbfpm8dcjjpk7ymyrr	1	checkbox	Send follow-up email	{"value":true}	1672924688894	1672924688894	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
ao3yjboejpp8ctrnwhhd1p7k9gr	2023-01-05 13:18:08.726993+00	cyra1n9ydbbfpm8dcjjpk7ymyrr	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1672924688900	1672924688900	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
arnctww5wqfrnjmz41dn66k8y4h	2023-01-05 13:18:08.726993+00	cyra1n9ydbbfpm8dcjjpk7ymyrr	1	text	## Checklist	{}	1672924688906	1672924688906	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7taz7tg8dbbdj9qibcdbkrf38zh	2023-01-05 13:18:08.726993+00	c59eubrnukjytb8zik1auzyu41a	1	checkbox	Follow up after demo	{"value":true}	1672924688912	1672924688912	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7p6dfjronm7fijnaipbdabxnwdr	2023-01-05 13:18:08.726993+00	c59eubrnukjytb8zik1auzyu41a	1	checkbox	Send initial email	{"value":true}	1672924688918	1672924688918	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7sfpuuujb8byiid9znf4msq6gwc	2023-01-05 13:18:08.726993+00	c59eubrnukjytb8zik1auzyu41a	1	checkbox	Send follow-up email	{"value":true}	1672924688925	1672924688925	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
75hr3rf3bstrqdxt3pxeka3q13o	2023-01-05 13:18:08.726993+00	c59eubrnukjytb8zik1auzyu41a	1	checkbox	Send proposal	{"value":true}	1672924688930	1672924688929	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7p1111nx84tnpinzxdw7x4jw4po	2023-01-05 13:18:08.726993+00	c59eubrnukjytb8zik1auzyu41a	1	checkbox	Finalize contract	{"value":true}	1672924688935	1672924688935	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7xrjsgf4t4jryu8qnnnmc6qsqhe	2023-01-05 13:18:08.726993+00	c59eubrnukjytb8zik1auzyu41a	1	checkbox	Schedule follow-up sales call	{"value":true}	1672924688940	1672924688940	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
73cpzmh8kd7dw9qkmafnm5te3ta	2023-01-05 13:18:08.726993+00	c59eubrnukjytb8zik1auzyu41a	1	checkbox	Schedule initial sales call	{"value":true}	1672924688945	1672924688945	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7ido7ki339fbc7ndrdsq5i1wrty	2023-01-05 13:18:08.726993+00	c59eubrnukjytb8zik1auzyu41a	1	checkbox	Schedule demo	{"value":true}	1672924688952	1672924688952	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
749purgzp5fd7xnjigngs9ojiry	2023-01-05 13:18:08.726993+00	c59eubrnukjytb8zik1auzyu41a	1	checkbox	Hand-off to customer success	{"value":true}	1672924688957	1672924688957	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7jexqrhodftystde85pqir91npw	2023-01-05 13:18:08.726993+00	c59eubrnukjytb8zik1auzyu41a	1	checkbox	Post-sales follow up	{"value":true}	1672924688962	1672924688962	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
aaiqjc55eqbgtinmmsq9ks83huy	2023-01-05 13:18:08.726993+00	c59eubrnukjytb8zik1auzyu41a	1	text	## Checklist	{}	1672924688967	1672924688967	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
anixf3fgofjyc9rjwoy9mp4ybco	2023-01-05 13:18:08.726993+00	c59eubrnukjytb8zik1auzyu41a	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1672924688972	1672924688972	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7yhc86iw3hpye5xgixqe9zubwey	2023-01-05 13:18:08.726993+00	ctawerdpkn78od8muh9szjke3yw	1	checkbox	Post-sales follow up	{}	1672924688976	1672924688976	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7b6ye18kuu3fw9rnndn5eoekjrc	2023-01-05 13:18:08.726993+00	ctawerdpkn78od8muh9szjke3yw	1	checkbox	Send proposal	{}	1672924688980	1672924688980	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7k7hok4xi9tfizr1umk1pd7ieno	2023-01-05 13:18:08.726993+00	ctawerdpkn78od8muh9szjke3yw	1	checkbox	Hand-off to customer success	{}	1672924688985	1672924688985	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
716mzzxsqrbyb9f1ekybnz3nqjo	2023-01-05 13:18:08.726993+00	ctawerdpkn78od8muh9szjke3yw	1	checkbox	Follow up after demo	{}	1672924688988	1672924688988	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7p4raiw7fo7r1injenypggxbg7w	2023-01-05 13:18:08.726993+00	ctawerdpkn78od8muh9szjke3yw	1	checkbox	Schedule demo	{"value":true}	1672924688993	1672924688993	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7tsqz4e5rpjrfpnfoy6irfc9cco	2023-01-05 13:18:08.726993+00	ctawerdpkn78od8muh9szjke3yw	1	checkbox	Send initial email	{"value":true}	1672924688996	1672924688996	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
77y9fnhu667fdtgrdf9pek887xo	2023-01-05 13:18:08.726993+00	ctawerdpkn78od8muh9szjke3yw	1	checkbox	Schedule follow-up sales call	{"value":true}	1672924689001	1672924689001	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7h8ozcg9wkino9do1qece83t66o	2023-01-05 13:18:08.726993+00	ctawerdpkn78od8muh9szjke3yw	1	checkbox	Send follow-up email	{"value":true}	1672924689005	1672924689005	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7h4augwa4mfyydji34ebgszrrbc	2023-01-05 13:18:08.726993+00	ctawerdpkn78od8muh9szjke3yw	1	checkbox	Schedule initial sales call	{"value":true}	1672924689009	1672924689009	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
79w9fmkscj3y79pmwourkt5b4ro	2023-01-05 13:18:08.726993+00	ctawerdpkn78od8muh9szjke3yw	1	checkbox	Finalize contract	{}	1672924689014	1672924689014	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
a6shdw6mastdzdfpcf34twpcq9r	2023-01-05 13:18:08.726993+00	ctawerdpkn78od8muh9szjke3yw	1	text	## Checklist	{}	1672924689017	1672924689017	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
ac5e3358d9tnnfmmtb8wtscdbie	2023-01-05 13:18:08.726993+00	ctawerdpkn78od8muh9szjke3yw	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1672924689022	1672924689022	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7t4j64do36jrtmgkj37k7ygohqa	2023-01-05 13:18:08.726993+00	cw8g9n58zwbri8pxtsx7wgny7uw	1	checkbox	Send initial email	{"value":false}	1672924689025	1672924689025	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7u396wm7kc3r63kxp3gqreqopwa	2023-01-05 13:18:08.726993+00	cw8g9n58zwbri8pxtsx7wgny7uw	1	checkbox	Schedule initial sales call	{"value":false}	1672924689030	1672924689030	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7w3jxjnm1qpf1dfycxch4h5qqhw	2023-01-05 13:18:08.726993+00	cw8g9n58zwbri8pxtsx7wgny7uw	1	checkbox	Schedule follow-up sales call	{"value":false}	1672924689039	1672924689039	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
77uzu5w7rxp8hdk4dz6bpw5g8ph	2023-01-05 13:18:08.726993+00	cw8g9n58zwbri8pxtsx7wgny7uw	1	checkbox	Send proposal	{}	1672924689047	1672924689047	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7thmioo3xn38ztfi69sohbq9yea	2023-01-05 13:18:08.726993+00	cw8g9n58zwbri8pxtsx7wgny7uw	1	checkbox	Finalize contract	{}	1672924689058	1672924689058	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
78twi939pd7fcxgp6buspj4imar	2023-01-05 13:18:08.726993+00	cw8g9n58zwbri8pxtsx7wgny7uw	1	checkbox	Post-sales follow up	{}	1672924689063	1672924689063	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7316jzfyex3buieeg61p3uanu8w	2023-01-05 13:18:08.726993+00	cw8g9n58zwbri8pxtsx7wgny7uw	1	checkbox	Send follow-up email	{"value":false}	1672924689070	1672924689070	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7ya4xtzikgtf4mma7ib34tmu94h	2023-01-05 13:18:08.726993+00	cw8g9n58zwbri8pxtsx7wgny7uw	1	checkbox	Schedule demo	{"value":false}	1672924689075	1672924689075	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7ghyopfdwkbyy8xtetzrux1a3ay	2023-01-05 13:18:08.726993+00	cw8g9n58zwbri8pxtsx7wgny7uw	1	checkbox	Hand-off to customer success	{}	1672924689082	1672924689082	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7hn1c3mgyr7de7po3tmccguokfe	2023-01-05 13:18:08.726993+00	cw8g9n58zwbri8pxtsx7wgny7uw	1	checkbox	Follow up after demo	{}	1672924689093	1672924689093	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
aqqdyed4m3bge9ksh8hac1t4a3r	2023-01-05 13:18:08.726993+00	cw8g9n58zwbri8pxtsx7wgny7uw	1	text	## Notes\n[Enter notes here...]	{}	1672924689098	1672924689098	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
akticbfzqqjrx9fyxjqy476fboo	2023-01-05 13:18:08.726993+00	cw8g9n58zwbri8pxtsx7wgny7uw	1	text	## Checklist	{}	1672924689108	1672924689108	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7h88e9ci5sfgh5bz95oji5f3oew	2023-01-05 13:18:08.726993+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Hand-off to customer success	{}	1672924689113	1672924689113	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7sxgxamu7ojncjywsf3sb7akm5w	2023-01-05 13:18:08.726993+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Send initial email	{"value":false}	1672924689120	1672924689120	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
774fz9eeux3y3pmq6ajt3qrzcdr	2023-01-05 13:18:08.726993+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Post-sales follow up	{}	1672924689125	1672924689125	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7mqgzqx8gn7bqbr6e39upgys8ea	2023-01-05 13:18:08.726993+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Finalize contract	{}	1672924689132	1672924689131	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7edkymjh1e3bebeee5bumu8cadc	2023-01-05 13:18:08.726993+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Send follow-up email	{"value":false}	1672924689137	1672924689137	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
76b11zoutn38mpx3mcqjknrrqza	2023-01-05 13:18:08.726993+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Schedule follow-up sales call	{"value":false}	1672924689143	1672924689143	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7uw6xzgag9381m8b9oym8t1trry	2023-01-05 13:18:08.726993+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Send proposal	{}	1672924689150	1672924689150	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7j8y8nz7o97bsxx6oyhspt4n7uo	2023-01-05 13:18:08.726993+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Follow up after demo	{}	1672924689153	1672924689153	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7ph3fac5qhbrm7ygs5sx4jxci3a	2023-01-05 13:18:08.726993+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Schedule initial sales call	{"value":false}	1672924689158	1672924689158	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7tazkextky3db3k7fejzta8hbmw	2023-01-05 13:18:08.726993+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Schedule demo	{"value":false}	1672924689163	1672924689163	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
arpgzkjj6ojf17p1uduxf5ichdr	2023-01-05 13:18:08.726993+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	text	## Checklist	{}	1672924689169	1672924689169	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
aqrny3wobwi8sbgsrbs3rpro1cr	2023-01-05 13:18:08.726993+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	text	## Notes\n[Enter notes here...]	{}	1672924689173	1672924689173	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7z5agzxkddbrmzj5ui9e79iaite	2023-01-05 13:18:08.726993+00	ckim1iz9ni78p8dnf3cmn8td16a	1	checkbox	Send proposal	{}	1672924689178	1672924689178	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7rkdt3izojtf6m8ek7436h3s5by	2023-01-05 13:18:08.726993+00	ckim1iz9ni78p8dnf3cmn8td16a	1	checkbox	Send initial email	{"value":true}	1672924689183	1672924689183	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7fn47owkpzifb7gmhrmqz8otyto	2023-01-05 13:18:08.726993+00	ckim1iz9ni78p8dnf3cmn8td16a	1	checkbox	Follow up after demo	{}	1672924689187	1672924689187	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
74mccbbbrbjr53g4bztt7eaozmw	2023-01-05 13:18:08.726993+00	ckim1iz9ni78p8dnf3cmn8td16a	1	checkbox	Finalize contract	{}	1672924689192	1672924689192	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
78m6x9c6gufdr5q47rpgazbobjy	2023-01-05 13:18:08.726993+00	ckim1iz9ni78p8dnf3cmn8td16a	1	checkbox	Schedule follow-up sales call	{"value":false}	1672924689196	1672924689196	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7ahicq1xmmfftfqddmjwgyfrzbr	2023-01-05 13:18:08.726993+00	ckim1iz9ni78p8dnf3cmn8td16a	1	checkbox	Schedule demo	{"value":false}	1672924689201	1672924689201	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
745hidcaqatn4ff7oj5qibkp9fr	2023-01-05 13:18:08.726993+00	ckim1iz9ni78p8dnf3cmn8td16a	1	checkbox	Schedule initial sales call	{"value":false}	1672924689204	1672924689204	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7frgsmw9xe7nr3jxp8xu7am44zy	2023-01-05 13:18:08.726993+00	ckim1iz9ni78p8dnf3cmn8td16a	1	checkbox	Post-sales follow up	{}	1672924689208	1672924689208	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7dwz15ofwdpyk3fkqfh7ps9nk9a	2023-01-05 13:18:08.726993+00	ckim1iz9ni78p8dnf3cmn8td16a	1	checkbox	Hand-off to customer success	{}	1672924689213	1672924689213	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7xgcriqsp9by59y1cygejbn7wme	2023-01-05 13:18:08.726993+00	ckim1iz9ni78p8dnf3cmn8td16a	1	checkbox	Send follow-up email	{"value":false}	1672924689219	1672924689219	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
aapqd3aoswbyxfnbpcipinpt31h	2023-01-05 13:18:08.726993+00	ckim1iz9ni78p8dnf3cmn8td16a	1	text	## Checklist	{}	1672924689224	1672924689224	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7r4wo7r5qo3fc9yr83fjz9kay3e	2023-01-05 13:18:10.587839+00	c7y1bnewb63grffd5hzx7bky69c	1	checkbox	[Subtask 3]	{"value":false}	1672924690693	1672924690693	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
a33h531muhjdjddtg6xtq8tis8y	2023-01-05 13:18:08.726993+00	ckim1iz9ni78p8dnf3cmn8td16a	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1672924689228	1672924689228	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
cehued4tm4bnu8mh4so6ouwaphh	2023-01-05 13:18:10.177036+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Pay bills	{"contentOrder":["7yac1e3t3gpncm8nt1ipnaz76ir","7a8q3ifp3c7nkbxgcjskkiuppfa","7pbc7xf8eztr8tjkwix8nw7u41e"],"icon":"🔌","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"aj4jyekqqssatjcq7r7chmy19ey","abthng7baedhhtrwsdodeuincqy":"true"}}	1672924690191	1672924690191	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
crqag6asmttng8mfdwrtzdjqd9y	2023-01-05 13:18:10.177036+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Buy groceries	{"contentOrder":["ao6apocwmm3r8xfe98hrhpc9rxy","713fmxxj3ytb57bm1ahb73fsjyo","7aboahxgcn3f1bbcuzsmds6dxth","7ryqsi7r3f7bnmfk5ms8t4pe7no","77qdo4mgopbr18fytkfr6zts1he","7g5ynw5teabdauk8tqqoeaq1h7o","7knydr91qkpf15fhi1fqu76hqpc"],"icon":"🛒","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"afpy8s7i45frggprmfsqngsocqh"}}	1672924690197	1672924690197	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
cw8arca9d87dzjb6t6yjjf39ppa	2023-01-05 13:18:10.177036+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Go for a walk	{"contentOrder":["ammm85i7wzjra8mbw63tbu46ayo","agw1548eiyidqjfidwgaquccaue","7cadc6kwkrtyfdy4empk6bgmq3a"],"icon":"👣","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"an51dnkenmoog9cetapbc4uyt3y"}}	1672924690204	1672924690204	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
c75sfehnadpb55bfmirz4q1w3ih	2023-01-05 13:18:10.177036+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Feed Fluffy	{"contentOrder":["ah79z4mjhh3dt3cyf4e64j9djqr"],"icon":"🐱","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"an51dnkenmoog9cetapbc4uyt3y"}}	1672924690208	1672924690208	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
cg1gthoy4d3ntjneybzu5zsa7yo	2023-01-05 13:18:10.177036+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Gardening	{"contentOrder":[],"icon":"🌳","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"afpy8s7i45frggprmfsqngsocqh"}}	1672924690213	1672924690213	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
v9ddzwk1eti8q8n3z6hhhewnn6a	2023-01-05 13:18:10.177036+00	bbn1888mprfrm5fjw9f1je9x3xo	1	view	List View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":280},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a9zf59u8x1rf4ywctpcqama7tio","abthng7baedhhtrwsdodeuincqy"]}	1672924690220	1672924690220	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
vtdu7gdxroigdubuj5td4eeqzzc	2023-01-05 13:18:10.177036+00	bbn1888mprfrm5fjw9f1je9x3xo	1	view	Board View	{"cardOrder":["crqag6asmttng8mfdwrtzdjqd9y","cehued4tm4bnu8mh4so6ouwaphh","cw8arca9d87dzjb6t6yjjf39ppa","c75sfehnadpb55bfmirz4q1w3ih","czowhma7rnpgb3eczbqo3t7fijo"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a9zf59u8x1rf4ywctpcqama7tio","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["an51dnkenmoog9cetapbc4uyt3y","afpy8s7i45frggprmfsqngsocqh","aj4jyekqqssatjcq7r7chmy19ey",""],"visiblePropertyIds":["a9zf59u8x1rf4ywctpcqama7tio"]}	1672924690225	1672924690225	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
7pbc7xf8eztr8tjkwix8nw7u41e	2023-01-05 13:18:10.177036+00	cehued4tm4bnu8mh4so6ouwaphh	1	checkbox	Utilities	{"value":true}	1672924690230	1672924690230	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
7yac1e3t3gpncm8nt1ipnaz76ir	2023-01-05 13:18:10.177036+00	cehued4tm4bnu8mh4so6ouwaphh	1	checkbox	Mobile phone	{"value":true}	1672924690236	1672924690236	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
7a8q3ifp3c7nkbxgcjskkiuppfa	2023-01-05 13:18:10.177036+00	cehued4tm4bnu8mh4so6ouwaphh	1	checkbox	Internet	{"value":true}	1672924690241	1672924690241	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
7g5ynw5teabdauk8tqqoeaq1h7o	2023-01-05 13:18:10.177036+00	crqag6asmttng8mfdwrtzdjqd9y	1	checkbox	Cereal	{"value":false}	1672924690247	1672924690247	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
77qdo4mgopbr18fytkfr6zts1he	2023-01-05 13:18:10.177036+00	crqag6asmttng8mfdwrtzdjqd9y	1	checkbox	Butter	{"value":false}	1672924690253	1672924690253	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
7ryqsi7r3f7bnmfk5ms8t4pe7no	2023-01-05 13:18:10.177036+00	crqag6asmttng8mfdwrtzdjqd9y	1	checkbox	Bread	{"value":false}	1672924690259	1672924690259	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
713fmxxj3ytb57bm1ahb73fsjyo	2023-01-05 13:18:10.177036+00	crqag6asmttng8mfdwrtzdjqd9y	1	checkbox	Milk	{"value":false}	1672924690264	1672924690264	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
7knydr91qkpf15fhi1fqu76hqpc	2023-01-05 13:18:10.177036+00	crqag6asmttng8mfdwrtzdjqd9y	1	checkbox	Bananas	{"value":false}	1672924690271	1672924690271	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
7aboahxgcn3f1bbcuzsmds6dxth	2023-01-05 13:18:10.177036+00	crqag6asmttng8mfdwrtzdjqd9y	1	checkbox	Eggs	{"value":false}	1672924690276	1672924690276	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
ao6apocwmm3r8xfe98hrhpc9rxy	2023-01-05 13:18:10.177036+00	crqag6asmttng8mfdwrtzdjqd9y	1	text	## Grocery list	{}	1672924690282	1672924690282	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
7cadc6kwkrtyfdy4empk6bgmq3a	2023-01-05 13:18:10.177036+00	cw8arca9d87dzjb6t6yjjf39ppa	1	image		{"fileId":"76fwrj36hptg6dywka4k5mt3sph.png"}	1672924690288	1672924690288	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
ammm85i7wzjra8mbw63tbu46ayo	2023-01-05 13:18:10.177036+00	cw8arca9d87dzjb6t6yjjf39ppa	1	text	## Goal\nWalk at least 10,000 steps every day.	{}	1672924690293	1672924690293	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
agw1548eiyidqjfidwgaquccaue	2023-01-05 13:18:10.177036+00	cw8arca9d87dzjb6t6yjjf39ppa	1	text	## Route	{}	1672924690297	1672924690297	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
ah79z4mjhh3dt3cyf4e64j9djqr	2023-01-05 13:18:10.177036+00	c75sfehnadpb55bfmirz4q1w3ih	1	text		{}	1672924690303	1672924690303	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
c7y1bnewb63grffd5hzx7bky69c	2023-01-05 13:18:10.587839+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Identify dependencies	{"contentOrder":["a3w5kk9ut8tbbtyyunt9i4bgnza","7rfy9ysh1hbbdzfn1nt8bz1hpia","a7aj1s8f5obyfxxtzcaf73wnzgo","7437sjj5883gtpqqpa49d91oi1e","73yhk8rdadff8pq48b4f58pgukw","7r4wo7r5qo3fc9yr83fjz9kay3e","77af6cbtcntfb9qk3t63fccjk4e"],"icon":"🔗","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"16","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ayz81h9f3dwp7rzzbdebesc7ute","d3d682bf-e074-49d9-8df5-7320921c2d23":"98a57627-0f76-471d-850d-91f3ed9fd213"}}	1672924690597	1672924690597	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
cp3k1rx5y73fejenzunfr3gdjca	2023-01-05 13:18:10.587839+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Define project scope	{"contentOrder":["a19h3d65jxj8b9y1u3nq1u1es9y","7wd1eusn78fn4dmsumsx78c4rfa","a91f7p3jbqjfapjqhnyb7q3f79e","78qfufuer8fb7mjswhjtsn88cno","7a6k6defccfdzzx5j31zzxkxksr","7biffowit5iykugry3u4cmepiur","7iuzz3a4kopnapgouuy7nrdqr8y"],"icon":"🔬","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"32","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ar6b8m3jxr3asyxhr8iucdbo6yc","d3d682bf-e074-49d9-8df5-7320921c2d23":"87f59784-b859-4c24-8ebe-17c766e081dd"}}	1672924690604	1672924690604	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
ccfcp556krpf1bcan9g8wicwwxe	2023-01-05 13:18:10.587839+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Requirements sign-off	{"contentOrder":["a8x1fm1heh7yu3jk5s6jj9eabnh","7g9msn3tnrif5bphdjz5z3greer","axxhzwhenhtd5pqe39e5kp48f3w","7dhr813mpk3bzbb8ajurx3zeg3r","7kr5uds95e7biux9rkchpwio7dy","7ug8hkqwj63fb9cx1khu5k7pyor","7g615twzps7f67m4wtgepc7iwyr"],"icon":"🖋️","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"8","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ayz81h9f3dwp7rzzbdebesc7ute","d3d682bf-e074-49d9-8df5-7320921c2d23":"d3bfb50f-f569-4bad-8a3a-dd15c3f60101"}}	1672924690610	1672924690610	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
cpxrnqehwifru9f91t9xzjkn9hy	2023-01-05 13:18:10.587839+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Project budget approval	{"contentOrder":["ayoukxyxmxt8jzdhjwbezbpg3oa","7gsn3kimbnbgixfij8jiswixp8y","adn3kiobskibsucw4y84pspj6ir","7hwjfbeqc7jnt8e93kw8we1j7yr","78o3tsdbajbdgtc51nck3xmkgzy","7rgksxf8mibgdmcb46hwnm57qwe","7s9wxbn6o1p8pzgbfu3q1tq693o"],"icon":"💵","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"16","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ayz81h9f3dwp7rzzbdebesc7ute","d3d682bf-e074-49d9-8df5-7320921c2d23":"d3bfb50f-f569-4bad-8a3a-dd15c3f60101"}}	1672924690618	1672924690618	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
c9fgxtyzospr59yegon7bxshkny	2023-01-05 13:18:10.587839+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Conduct market analysis	{"contentOrder":["anoqj44sb6jyw8exn7btb199jrw","745ztu1erx387ucq8g5fgwcy36c","au8rnwu4e7tbfdmfisnrjx8k4fc","794we4iquxbdmzeq89hssmriady","7n69cycx1hifj3k9ca1wrgx1xgw","7d6stid1gq78zzbkxbcf7pm6mwy","7oc87cagy43dc8e9sjbyqfxwgrh"],"icon":"📈","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"40","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ar6b8m3jxr3asyxhr8iucdbo6yc","d3d682bf-e074-49d9-8df5-7320921c2d23":"87f59784-b859-4c24-8ebe-17c766e081dd"}}	1672924690625	1672924690625	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
v18ui55954ff5pmie6mgtccojsa	2023-01-05 13:18:10.587839+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Project Priorities	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"d3d682bf-e074-49d9-8df5-7320921c2d23","hiddenOptionIds":[],"kanbanCalculations":{"":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"87f59784-b859-4c24-8ebe-17c766e081dd":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"98a57627-0f76-471d-850d-91f3ed9fd213":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"d3bfb50f-f569-4bad-8a3a-dd15c3f60101":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"}},"sortOptions":[],"viewType":"board","visibleOptionIds":["d3bfb50f-f569-4bad-8a3a-dd15c3f60101","87f59784-b859-4c24-8ebe-17c766e081dd","98a57627-0f76-471d-850d-91f3ed9fd213",""],"visiblePropertyIds":["a972dc7a-5f4c-45d2-8044-8c28c69717f1","a8daz81s4xjgke1ww6cwik5w7ye"]}	1672924690634	1672924690634	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
vdoteenu9xjyeirrkxyaap454ua	2023-01-05 13:18:10.587839+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Progress Tracker	{"cardOrder":["cpxrnqehwifru9f91t9xzjkn9hy","ccfcp556krpf1bcan9g8wicwwxe","c7y1bnewb63grffd5hzx7bky69c","c9fgxtyzospr59yegon7bxshkny","cp3k1rx5y73fejenzunfr3gdjca","coxnjt3ro1in19dd1e3awdt338r"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a972dc7a-5f4c-45d2-8044-8c28c69717f1","hiddenOptionIds":[],"kanbanCalculations":{"":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"adeo5xuwne3qjue83fcozekz8ko":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"afi4o5nhnqc3smtzs1hs3ij34dh":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"ahpyxfnnrzynsw3im1psxpkgtpe":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"ar6b8m3jxr3asyxhr8iucdbo6yc":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"ayz81h9f3dwp7rzzbdebesc7ute":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"}},"sortOptions":[],"viewType":"board","visibleOptionIds":["ayz81h9f3dwp7rzzbdebesc7ute","ar6b8m3jxr3asyxhr8iucdbo6yc","afi4o5nhnqc3smtzs1hs3ij34dh","adeo5xuwne3qjue83fcozekz8ko","ahpyxfnnrzynsw3im1psxpkgtpe",""],"visiblePropertyIds":["d3d682bf-e074-49d9-8df5-7320921c2d23","a8daz81s4xjgke1ww6cwik5w7ye"]}	1672924690644	1672924690643	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
vz1xppta6ctf77nwwhnpkouudpc	2023-01-05 13:18:10.587839+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Task Overview	{"cardOrder":["cp3k1rx5y73fejenzunfr3gdjca","c9fgxtyzospr59yegon7bxshkny","c7y1bnewb63grffd5hzx7bky69c","cpxrnqehwifru9f91t9xzjkn9hy","ccfcp556krpf1bcan9g8wicwwxe","cz8p8gofakfby8kzz83j97db8ph","ce1jm5q5i54enhuu4h3kkay1hcc"],"collapsedOptionIds":[],"columnCalculations":{"a8daz81s4xjgke1ww6cwik5w7ye":"sum"},"columnWidths":{"2a5da320-735c-4093-8787-f56e15cdfeed":196,"__title":280,"a8daz81s4xjgke1ww6cwik5w7ye":139,"a972dc7a-5f4c-45d2-8044-8c28c69717f1":141,"d3d682bf-e074-49d9-8df5-7320921c2d23":110},"defaultTemplateId":"czw9es1e89fdpjr7cqptr1xq7qh","filter":{"filters":[],"operation":"and"},"groupById":"","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a972dc7a-5f4c-45d2-8044-8c28c69717f1","d3d682bf-e074-49d9-8df5-7320921c2d23","2a5da320-735c-4093-8787-f56e15cdfeed","a3zsw7xs8sxy7atj8b6totp3mby","axkhqa4jxr3jcqe4k87g8bhmary","a7gdnz8ff8iyuqmzddjgmgo9ery","a8daz81s4xjgke1ww6cwik5w7ye"]}	1672924690654	1672924690653	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
vbfane1bodjy13di4zimjtksgho	2023-01-05 13:18:10.587839+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Task Calendar	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"a3zsw7xs8sxy7atj8b6totp3mby","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1672924690661	1672924690661	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7437sjj5883gtpqqpa49d91oi1e	2023-01-05 13:18:10.587839+00	c7y1bnewb63grffd5hzx7bky69c	1	checkbox	[Subtask 1]	{"value":false}	1672924690670	1672924690670	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
73yhk8rdadff8pq48b4f58pgukw	2023-01-05 13:18:10.587839+00	c7y1bnewb63grffd5hzx7bky69c	1	checkbox	[Subtask 2]	{"value":false}	1672924690676	1672924690676	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7rfy9ysh1hbbdzfn1nt8bz1hpia	2023-01-05 13:18:10.587839+00	c7y1bnewb63grffd5hzx7bky69c	1	divider		{}	1672924690683	1672924690683	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
77af6cbtcntfb9qk3t63fccjk4e	2023-01-05 13:18:10.587839+00	c7y1bnewb63grffd5hzx7bky69c	1	checkbox	...	{"value":false}	1672924690689	1672924690689	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
a7aj1s8f5obyfxxtzcaf73wnzgo	2023-01-05 13:18:10.587839+00	c7y1bnewb63grffd5hzx7bky69c	1	text	## Checklist	{}	1672924690698	1672924690698	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
a3w5kk9ut8tbbtyyunt9i4bgnza	2023-01-05 13:18:10.587839+00	c7y1bnewb63grffd5hzx7bky69c	1	text	## Description\n*[Brief description of this task]*	{}	1672924690704	1672924690704	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7a6k6defccfdzzx5j31zzxkxksr	2023-01-05 13:18:10.587839+00	cp3k1rx5y73fejenzunfr3gdjca	1	checkbox	[Subtask 2]	{"value":false}	1672924690708	1672924690708	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7iuzz3a4kopnapgouuy7nrdqr8y	2023-01-05 13:18:10.587839+00	cp3k1rx5y73fejenzunfr3gdjca	1	checkbox	...	{"value":false}	1672924690712	1672924690712	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
78qfufuer8fb7mjswhjtsn88cno	2023-01-05 13:18:10.587839+00	cp3k1rx5y73fejenzunfr3gdjca	1	checkbox	[Subtask 1]	{"value":false}	1672924690717	1672924690717	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7biffowit5iykugry3u4cmepiur	2023-01-05 13:18:10.587839+00	cp3k1rx5y73fejenzunfr3gdjca	1	checkbox	[Subtask 3]	{"value":false}	1672924690723	1672924690723	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7wd1eusn78fn4dmsumsx78c4rfa	2023-01-05 13:18:10.587839+00	cp3k1rx5y73fejenzunfr3gdjca	1	divider		{}	1672924690728	1672924690728	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
a91f7p3jbqjfapjqhnyb7q3f79e	2023-01-05 13:18:10.587839+00	cp3k1rx5y73fejenzunfr3gdjca	1	text	## Checklist	{}	1672924690734	1672924690734	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
a19h3d65jxj8b9y1u3nq1u1es9y	2023-01-05 13:18:10.587839+00	cp3k1rx5y73fejenzunfr3gdjca	1	text	## Description\n*[Brief description of this task]*	{}	1672924690739	1672924690739	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7g615twzps7f67m4wtgepc7iwyr	2023-01-05 13:18:10.587839+00	ccfcp556krpf1bcan9g8wicwwxe	1	checkbox	...	{"value":false}	1672924690745	1672924690745	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7kr5uds95e7biux9rkchpwio7dy	2023-01-05 13:18:10.587839+00	ccfcp556krpf1bcan9g8wicwwxe	1	checkbox	[Subtask 2]	{"value":false}	1672924690751	1672924690751	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7g9msn3tnrif5bphdjz5z3greer	2023-01-05 13:18:10.587839+00	ccfcp556krpf1bcan9g8wicwwxe	1	divider		{}	1672924690757	1672924690757	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7ug8hkqwj63fb9cx1khu5k7pyor	2023-01-05 13:18:10.587839+00	ccfcp556krpf1bcan9g8wicwwxe	1	checkbox	[Subtask 3]	{"value":false}	1672924690762	1672924690762	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7dhr813mpk3bzbb8ajurx3zeg3r	2023-01-05 13:18:10.587839+00	ccfcp556krpf1bcan9g8wicwwxe	1	checkbox	[Subtask 1]	{"value":false}	1672924690769	1672924690769	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
a8x1fm1heh7yu3jk5s6jj9eabnh	2023-01-05 13:18:10.587839+00	ccfcp556krpf1bcan9g8wicwwxe	1	text	## Description\n*[Brief description of this task]*	{}	1672924690775	1672924690775	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
axxhzwhenhtd5pqe39e5kp48f3w	2023-01-05 13:18:10.587839+00	ccfcp556krpf1bcan9g8wicwwxe	1	text	## Checklist	{}	1672924690780	1672924690780	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7gsn3kimbnbgixfij8jiswixp8y	2023-01-05 13:18:10.587839+00	cpxrnqehwifru9f91t9xzjkn9hy	1	divider		{}	1672924690786	1672924690786	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7hwjfbeqc7jnt8e93kw8we1j7yr	2023-01-05 13:18:10.587839+00	cpxrnqehwifru9f91t9xzjkn9hy	1	checkbox	[Subtask 1]	{"value":false}	1672924690791	1672924690791	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7rgksxf8mibgdmcb46hwnm57qwe	2023-01-05 13:18:10.587839+00	cpxrnqehwifru9f91t9xzjkn9hy	1	checkbox	[Subtask 3]	{"value":false}	1672924690795	1672924690795	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7s9wxbn6o1p8pzgbfu3q1tq693o	2023-01-05 13:18:10.587839+00	cpxrnqehwifru9f91t9xzjkn9hy	1	checkbox	...	{"value":false}	1672924690800	1672924690800	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
78o3tsdbajbdgtc51nck3xmkgzy	2023-01-05 13:18:10.587839+00	cpxrnqehwifru9f91t9xzjkn9hy	1	checkbox	[Subtask 2]	{"value":false}	1672924690805	1672924690805	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
adn3kiobskibsucw4y84pspj6ir	2023-01-05 13:18:10.587839+00	cpxrnqehwifru9f91t9xzjkn9hy	1	text	## Checklist	{}	1672924690809	1672924690809	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
ayoukxyxmxt8jzdhjwbezbpg3oa	2023-01-05 13:18:10.587839+00	cpxrnqehwifru9f91t9xzjkn9hy	1	text	## Description\n*[Brief description of this task]*	{}	1672924690816	1672924690816	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7oc87cagy43dc8e9sjbyqfxwgrh	2023-01-05 13:18:10.587839+00	c9fgxtyzospr59yegon7bxshkny	1	checkbox	...	{"value":false}	1672924690824	1672924690824	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7d6stid1gq78zzbkxbcf7pm6mwy	2023-01-05 13:18:10.587839+00	c9fgxtyzospr59yegon7bxshkny	1	checkbox	[Subtask 3]	{"value":false}	1672924690831	1672924690831	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
745ztu1erx387ucq8g5fgwcy36c	2023-01-05 13:18:10.587839+00	c9fgxtyzospr59yegon7bxshkny	1	divider		{}	1672924690838	1672924690838	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7n69cycx1hifj3k9ca1wrgx1xgw	2023-01-05 13:18:10.587839+00	c9fgxtyzospr59yegon7bxshkny	1	checkbox	[Subtask 2]	{"value":false}	1672924690843	1672924690843	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
794we4iquxbdmzeq89hssmriady	2023-01-05 13:18:10.587839+00	c9fgxtyzospr59yegon7bxshkny	1	checkbox	[Subtask 1]	{"value":false}	1672924690851	1672924690851	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
anoqj44sb6jyw8exn7btb199jrw	2023-01-05 13:18:10.587839+00	c9fgxtyzospr59yegon7bxshkny	1	text	## Description\n*[Brief description of this task]*	{}	1672924690858	1672924690858	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
au8rnwu4e7tbfdmfisnrjx8k4fc	2023-01-05 13:18:10.587839+00	c9fgxtyzospr59yegon7bxshkny	1	text	## Checklist	{}	1672924690864	1672924690864	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7thn3yndgm3rwj8g6pioe53dyqc	2023-01-05 13:18:10.587839+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	[Subtask 3]	{"value":false}	1672924690872	1672924690872	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7a66o5axkif8ipjb3kjqn6bmjra	2023-01-05 13:18:10.587839+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	[Subtask 2]	{"value":false}	1672924690879	1672924690879	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7wkn43m3bc7rm5pq16uupmraqcy	2023-01-05 13:18:10.587839+00	czw9es1e89fdpjr7cqptr1xq7qh	1	divider		{}	1672924690886	1672924690886	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7w6totrhdwfdfik5p9u9rmadq8a	2023-01-05 13:18:10.587839+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	[Subtask 1]	{"value":false}	1672924690893	1672924690893	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7zmmw3915kpygdqqk8ex7x95qca	2023-01-05 13:18:10.587839+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	...	{"value":false}	1672924690899	1672924690899	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
atkk6b74t5pbk9khc9tieemg7pc	2023-01-05 13:18:10.587839+00	czw9es1e89fdpjr7cqptr1xq7qh	1	text	## Description\n*[Brief description of this task]*	{}	1672924690906	1672924690906	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
ainruezixbfg1dk5zrqxthdfg6a	2023-01-05 13:18:10.587839+00	czw9es1e89fdpjr7cqptr1xq7qh	1	text	## Checklist	{}	1672924690913	1672924690913	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
c8hah5j7gxfnnuk8apjaeise11e	2023-01-05 13:18:11.555344+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Start a daily journal	{"contentOrder":[],"icon":"✍️","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","d6b1249b-bc18-45fc-889e-bec48fce80ef":"0a82977f-52bf-457b-841b-e2b7f76fb525","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"3245a32d-f688-463b-87f4-8e7142c1b397"}}	1672924691570	1672924691570	0	\N	system		system	bfeybjmgux7niix8i3smgb9b31a
c5s1c7pcc4id6pr65qpgyfnacte	2023-01-05 13:18:11.555344+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Run 3 times a week	{"contentOrder":[],"icon":"🏃","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","d6b1249b-bc18-45fc-889e-bec48fce80ef":"6e7139e4-5358-46bb-8c01-7b029a57b80a","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"ffb3f951-b47f-413b-8f1d-238666728008"}}	1672924691573	1672924691573	0	\N	system		system	bfeybjmgux7niix8i3smgb9b31a
cjmgargm11pb1ie1r7epfdzcnco	2023-01-05 13:18:11.555344+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Learn to paint	{"contentOrder":[],"icon":"🎨","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"77c539af-309c-4db1-8329-d20ef7e9eacd","d6b1249b-bc18-45fc-889e-bec48fce80ef":"9a090e33-b110-4268-8909-132c5002c90e","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"3245a32d-f688-463b-87f4-8e7142c1b397"}}	1672924691577	1672924691577	0	\N	system		system	bfeybjmgux7niix8i3smgb9b31a
cu8bhz43kktbifgre7b8uo3ysro	2023-01-05 13:18:11.555344+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Open retirement account	{"contentOrder":[],"icon":"🏦","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","d6b1249b-bc18-45fc-889e-bec48fce80ef":"0a82977f-52bf-457b-841b-e2b7f76fb525","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"80be816c-fc7a-4928-8489-8b02180f4954"}}	1672924691582	1672924691582	0	\N	system		system	bfeybjmgux7niix8i3smgb9b31a
vsnq9wipkqjd77dchwihr3rzpio	2023-01-05 13:18:11.555344+00	bd65qbzuqupfztpg31dgwgwm5ga	1	view	By Status	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"af6fcbb8-ca56-4b73-83eb-37437b9a667d","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","77c539af-309c-4db1-8329-d20ef7e9eacd","98bdea27-0cce-4cde-8dc6-212add36e63a",""],"visiblePropertyIds":["d9725d14-d5a8-48e5-8de1-6f8c004a9680","d6b1249b-bc18-45fc-889e-bec48fce80ef"]}	1672924691588	1672924691588	0	\N	system		system	bfeybjmgux7niix8i3smgb9b31a
v67g36x7agjgozdq6zyrfduhb6c	2023-01-05 13:18:11.555344+00	bd65qbzuqupfztpg31dgwgwm5ga	1	view	Calendar View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"ajy6xbebzopojaenbnmfpgtdwso","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1672924691594	1672924691593	0	\N	system		system	bfeybjmgux7niix8i3smgb9b31a
v9hze68xgbfg7xrczozrw464rqy	2023-01-05 13:18:11.555344+00	bd65qbzuqupfztpg31dgwgwm5ga	1	view	By Date	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"d6b1249b-bc18-45fc-889e-bec48fce80ef","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["9a090e33-b110-4268-8909-132c5002c90e","0a82977f-52bf-457b-841b-e2b7f76fb525","6e7139e4-5358-46bb-8c01-7b029a57b80a","d5371c63-66bf-4468-8738-c4dc4bea4843",""],"visiblePropertyIds":["d9725d14-d5a8-48e5-8de1-6f8c004a9680"]}	1672924691599	1672924691599	0	\N	system		system	bfeybjmgux7niix8i3smgb9b31a
vfdpsmq331tfo3gkfgaybr7w43a	2023-01-05 13:18:12.257888+00		1	view	Competitor List	{"cardOrder":["cm6jhium31insino6coq8rziyja","czypouqqwyjbkfjkx1sypp5j4ka","ceedjswwfqpftukmtrnwhjojrwc","cxp4qfkegp7byi8bkpztnb33cfe","cckr9sxx73tfe9pksy8ipudfzfh"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":210,"a1semdhszu1rq17d7et5ydrqqio":121,"aapogff3xoa8ym7xf56s87kysda":194,"ahzspe59iux8wigra8bg6cg18nc":156,"aiefo7nh9jwisn8b4cgakowithy":155,"aozntq4go4nkab688j1s7stqtfc":151,"az3jkw3ynd3mqmart7edypey15e":145},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["ahzspe59iux8wigra8bg6cg18nc","aozntq4go4nkab688j1s7stqtfc","aiefo7nh9jwisn8b4cgakowithy","a6cwaq79b1pdpb97wkanmeyy4er","an1eerzscfxn6awdfajbg41uz3h","a1semdhszu1rq17d7et5ydrqqio","aapogff3xoa8ym7xf56s87kysda","az3jkw3ynd3mqmart7edypey15e"]}	1672924692269	1672924692269	0	\N	system		system	bwzfh6d1x3fr8zb8gfxba65kjah
v9si1am1kdtdppgby1ph5taxywy	2023-01-05 13:18:12.257888+00		1	view	Market Position	{"cardOrder":["cip8b4jcomfr7by9gtizebikfke","cacs91js1hb887ds41r6dwnd88c","ca3u8edwrof89i8obxffnz4xw3a"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["arfjpz9by5car71tz3behba8yih","abajmr34b8g1916w495xjb35iko","abt79uxg5edqojsrrefcnr4eruo","aipf3qfgjtkheiayjuxrxbpk9wa"],"visiblePropertyIds":[]}	1672924692275	1672924692275	0	\N	system		system	bwzfh6d1x3fr8zb8gfxba65kjah
cm6jhium31insino6coq8rziyja	2023-01-05 13:18:12.257888+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Liminary Corp.	{"contentOrder":["aj1oizrnd5inifd4ea4pm61nmse"],"icon":"🌧","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"abt79uxg5edqojsrrefcnr4eruo","a6cwaq79b1pdpb97wkanmeyy4er":"300","ahzspe59iux8wigra8bg6cg18nc":"liminarycorp.com","aiefo7nh9jwisn8b4cgakowithy":"$25,000,000","an1eerzscfxn6awdfajbg41uz3h":"2017","aozntq4go4nkab688j1s7stqtfc":"Toronto, Canada"}}	1672924692280	1672924692279	0	\N	system		system	bwzfh6d1x3fr8zb8gfxba65kjah
czypouqqwyjbkfjkx1sypp5j4ka	2023-01-05 13:18:12.257888+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Helx Industries	{"contentOrder":["ay889a3xr5pyixgudjd6mu4pmyy"],"icon":"📦","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"abt79uxg5edqojsrrefcnr4eruo","a6cwaq79b1pdpb97wkanmeyy4er":"650","ahzspe59iux8wigra8bg6cg18nc":"helxindustries.com","aiefo7nh9jwisn8b4cgakowithy":"$50,000,000","an1eerzscfxn6awdfajbg41uz3h":"2009","aozntq4go4nkab688j1s7stqtfc":"New York, NY"}}	1672924692285	1672924692285	0	\N	system		system	bwzfh6d1x3fr8zb8gfxba65kjah
ceedjswwfqpftukmtrnwhjojrwc	2023-01-05 13:18:12.257888+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Kadera Global	{"contentOrder":["aiwabx71igfnhje9j39ytd4t1nh"],"icon":"🛡","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"aipf3qfgjtkheiayjuxrxbpk9wa","a6cwaq79b1pdpb97wkanmeyy4er":"150","ahzspe59iux8wigra8bg6cg18nc":"kaderaglobal.com","aiefo7nh9jwisn8b4cgakowithy":"$12,000,000","an1eerzscfxn6awdfajbg41uz3h":"2015","aozntq4go4nkab688j1s7stqtfc":"Seattle, OR"}}	1672924692290	1672924692290	0	\N	system		system	bwzfh6d1x3fr8zb8gfxba65kjah
aws4m776wgtd7xy7st6e6pxfy1a	2023-01-05 13:18:13.314902+00	cqh6oczxk6tn9tf836qtk7qwc4r	1	text	Collaborate with teammates directly on each card using @mentions and have all the relevant context in one place.	{}	1672924693585	1672924693585	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
vo65rxpbui7bozrid5fxna15qqa	2023-01-05 13:18:11.328467+00		1	view	By Quarter	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":452,"a17ryhi1jfsboxkwkztwawhmsxe":148,"a6amddgmrzakw66cidqzgk6p4ge":230,"azzbawji5bksj69sekcs4srm1ky":142},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"aqxyzkdrs4egqf7yk866ixkaojc","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a6amddgmrzakw66cidqzgk6p4ge","a17ryhi1jfsboxkwkztwawhmsxe","azzbawji5bksj69sekcs4srm1ky","adp5ft3kgz7r5iqq3tnwg551der","aqxyzkdrs4egqf7yk866ixkaojc","adu6mebzpibq6mgcswk69xxmnqe","asope3bddhm4gpsng5cfu4hf6rh","ajwxp866f9obs1kutfwaa5ru7fe","azqnyswk6s1boiwuthscm78qwuo","ahz3fmjnaguec8hce7xq3h5cjdr","a17bfcgnzmkwhziwa4tr38kiw5r"]}	1672924691337	1672924691337	0	\N	system		system	bhfouoto7gtbb3py83ib5nhb7jc
vp411pz7ojjr38bq8hct6ji7i8h	2023-01-05 13:18:11.328467+00		1	view	By Objectives	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":387,"a17ryhi1jfsboxkwkztwawhmsxe":134,"a6amddgmrzakw66cidqzgk6p4ge":183,"aqxyzkdrs4egqf7yk866ixkaojc":100},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a6amddgmrzakw66cidqzgk6p4ge","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a6amddgmrzakw66cidqzgk6p4ge","a17ryhi1jfsboxkwkztwawhmsxe","azzbawji5bksj69sekcs4srm1ky","adp5ft3kgz7r5iqq3tnwg551der","aqxyzkdrs4egqf7yk866ixkaojc","adu6mebzpibq6mgcswk69xxmnqe","asope3bddhm4gpsng5cfu4hf6rh","ajwxp866f9obs1kutfwaa5ru7fe","azqnyswk6s1boiwuthscm78qwuo","ahz3fmjnaguec8hce7xq3h5cjdr","a17bfcgnzmkwhziwa4tr38kiw5r"]}	1672924691343	1672924691343	0	\N	system		system	bhfouoto7gtbb3py83ib5nhb7jc
c9dozc74patrqdf5f1ycedb8f8o	2023-01-05 13:18:11.328467+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Improve customer NPS score	{"contentOrder":[],"icon":"💯","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a8nukezwwmknqwjsygg7eaxs9te","a6amddgmrzakw66cidqzgk6p4ge":"apqfjst8massbjjhpcsjs3y1yqa","adp5ft3kgz7r5iqq3tnwg551der":"as555ipyzopjjpfb5rjtssecw5e","ahz3fmjnaguec8hce7xq3h5cjdr":"82%","ajwxp866f9obs1kutfwaa5ru7fe":"8.5","aqxyzkdrs4egqf7yk866ixkaojc":"anruuoyez51r3yjxuoc8zoqnwaw","azqnyswk6s1boiwuthscm78qwuo":"7","azzbawji5bksj69sekcs4srm1ky":"agm9p6gcq15ueuzqq3wd4be39wy"}}	1672924691349	1672924691349	0	\N	system		system	bhfouoto7gtbb3py83ib5nhb7jc
c7u347gghr7dyfx4s8w9wh4wjbc	2023-01-05 13:18:11.328467+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Generate more Marketing Qualified Leads (MQLs)	{"contentOrder":[],"icon":"🛣️","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a8nukezwwmknqwjsygg7eaxs9te","a6amddgmrzakw66cidqzgk6p4ge":"auw3afh3kfhrfgmjr8muiz137jy","adp5ft3kgz7r5iqq3tnwg551der":"as555ipyzopjjpfb5rjtssecw5e","ahz3fmjnaguec8hce7xq3h5cjdr":"65%","ajwxp866f9obs1kutfwaa5ru7fe":"100","aqxyzkdrs4egqf7yk866ixkaojc":"ahfbn1jsmhydym33ygxwg5jt3kh","azqnyswk6s1boiwuthscm78qwuo":"65","azzbawji5bksj69sekcs4srm1ky":"aehoa17cz18rqnrf75g7dwhphpr"}}	1672924691355	1672924691355	0	\N	system		system	bhfouoto7gtbb3py83ib5nhb7jc
cyci7ammphbgnxx6i7ifayy71wr	2023-01-05 13:18:11.328467+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Increase customer retention	{"contentOrder":[],"icon":"😀","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a8nukezwwmknqwjsygg7eaxs9te","a6amddgmrzakw66cidqzgk6p4ge":"apqfjst8massbjjhpcsjs3y1yqa","adp5ft3kgz7r5iqq3tnwg551der":"a8zg3rjtf4swh7smsjxpsn743rh","ahz3fmjnaguec8hce7xq3h5cjdr":"66%","ajwxp866f9obs1kutfwaa5ru7fe":"90% customer retention rate","aqxyzkdrs4egqf7yk866ixkaojc":"acb6dqqs6yson7bbzx6jk9bghjh","azqnyswk6s1boiwuthscm78qwuo":"60%","azzbawji5bksj69sekcs4srm1ky":"afkxpcjqjypu7hhar7banxau91h"}}	1672924691360	1672924691360	0	\N	system		system	bhfouoto7gtbb3py83ib5nhb7jc
c9in97skfnj8qjkoji4aktax6nh	2023-01-05 13:18:11.328467+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Hit company global sales target	{"contentOrder":[],"icon":"💰","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a6robxx81diugpjq5jkezz3j1fo","a6amddgmrzakw66cidqzgk6p4ge":"auw3afh3kfhrfgmjr8muiz137jy","adp5ft3kgz7r5iqq3tnwg551der":"a8zg3rjtf4swh7smsjxpsn743rh","ahz3fmjnaguec8hce7xq3h5cjdr":"15%","ajwxp866f9obs1kutfwaa5ru7fe":"50MM","aqxyzkdrs4egqf7yk866ixkaojc":"awfu37js3fomfkkczm1zppac57a","azqnyswk6s1boiwuthscm78qwuo":"7.5MM","azzbawji5bksj69sekcs4srm1ky":"agrfeaoj7d8p5ianw5iaf3191ae"}}	1672924691365	1672924691365	0	\N	system		system	bhfouoto7gtbb3py83ib5nhb7jc
c7xih5fgtf7rwietwsj1bxqs7oc	2023-01-05 13:18:11.328467+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Increase user signups by 30%	{"contentOrder":[],"icon":"💳","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a6robxx81diugpjq5jkezz3j1fo","a6amddgmrzakw66cidqzgk6p4ge":"ao9b5pxyt7tkgdohzh9oaustdhr","adp5ft3kgz7r5iqq3tnwg551der":"as555ipyzopjjpfb5rjtssecw5e","ahz3fmjnaguec8hce7xq3h5cjdr":"0%","ajwxp866f9obs1kutfwaa5ru7fe":"1,000","aqxyzkdrs4egqf7yk866ixkaojc":"acb6dqqs6yson7bbzx6jk9bghjh","azqnyswk6s1boiwuthscm78qwuo":"0","azzbawji5bksj69sekcs4srm1ky":"afkxpcjqjypu7hhar7banxau91h"}}	1672924691371	1672924691371	0	\N	system		system	bhfouoto7gtbb3py83ib5nhb7jc
cas47ogpi438p7qqktpiqg6rgnw	2023-01-05 13:18:11.328467+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Add 10 new customers in the EU	{"contentOrder":[],"icon":"🌍","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"apnt1f7na9rzgk1rt49keg7xbiy","a6amddgmrzakw66cidqzgk6p4ge":"auw3afh3kfhrfgmjr8muiz137jy","adp5ft3kgz7r5iqq3tnwg551der":"a1ts3ftyr8nocsicui98c89uxjy","ahz3fmjnaguec8hce7xq3h5cjdr":"30%","ajwxp866f9obs1kutfwaa5ru7fe":"10","aqxyzkdrs4egqf7yk866ixkaojc":"acb6dqqs6yson7bbzx6jk9bghjh","azqnyswk6s1boiwuthscm78qwuo":"3","azzbawji5bksj69sekcs4srm1ky":"agrfeaoj7d8p5ianw5iaf3191ae"}}	1672924691376	1672924691376	0	\N	system		system	bhfouoto7gtbb3py83ib5nhb7jc
cjuiw1ia1b3fzipo91woz8py7aa	2023-01-05 13:18:11.328467+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Launch 3 key features	{"contentOrder":[],"icon":"🚀","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"apnt1f7na9rzgk1rt49keg7xbiy","a6amddgmrzakw66cidqzgk6p4ge":"ao9b5pxyt7tkgdohzh9oaustdhr","adp5ft3kgz7r5iqq3tnwg551der":"a8zg3rjtf4swh7smsjxpsn743rh","ahz3fmjnaguec8hce7xq3h5cjdr":"33%","ajwxp866f9obs1kutfwaa5ru7fe":"3","aqxyzkdrs4egqf7yk866ixkaojc":"anruuoyez51r3yjxuoc8zoqnwaw","azqnyswk6s1boiwuthscm78qwuo":"1","azzbawji5bksj69sekcs4srm1ky":"aw5i7hmpadn6mbwbz955ubarhme"}}	1672924691381	1672924691381	0	\N	system		system	bhfouoto7gtbb3py83ib5nhb7jc
cqgsjnnrb3tfiuptpzws556gz7y	2023-01-05 13:18:11.328467+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Reduce bug backlog by 50%	{"contentOrder":[],"icon":"🐞","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"abzfwnn6rmtfzyq5hg8uqmpsncy","a6amddgmrzakw66cidqzgk6p4ge":"apqfjst8massbjjhpcsjs3y1yqa","adp5ft3kgz7r5iqq3tnwg551der":"a1ts3ftyr8nocsicui98c89uxjy","ahz3fmjnaguec8hce7xq3h5cjdr":"100%","ajwxp866f9obs1kutfwaa5ru7fe":"75","aqxyzkdrs4egqf7yk866ixkaojc":"awfu37js3fomfkkczm1zppac57a","azqnyswk6s1boiwuthscm78qwuo":"75","azzbawji5bksj69sekcs4srm1ky":"aw5i7hmpadn6mbwbz955ubarhme"}}	1672924691386	1672924691386	0	\N	system		system	bhfouoto7gtbb3py83ib5nhb7jc
cg4fz84f1ybb4xe346d784hj6sh	2023-01-05 13:18:11.678364+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Feature	{"contentOrder":["atr1gpn98jfrw7cms48utpdizsc"],"icon":"🏗️","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer"}}	1672924691726	1672924691726	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
vykj4z8nfx78b9niwuypxijeanc	2023-01-05 13:18:11.328467+00	bm4ubx56krp4zwyfcqh7nxiigbr	1	view	Departments	{"cardOrder":["cpa534b5natgmunis8u1ixb55pw"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"azzbawji5bksj69sekcs4srm1ky","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["aw5i7hmpadn6mbwbz955ubarhme","afkxpcjqjypu7hhar7banxau91h","aehoa17cz18rqnrf75g7dwhphpr","agrfeaoj7d8p5ianw5iaf3191ae","agm9p6gcq15ueuzqq3wd4be39wy","aucop7kw6xwodcix6zzojhxih6r","afust91f3g8ht368mkn5x9tgf1o","acocxxwjurud1jixhp7nowdig7y"],"visiblePropertyIds":[]}	1672924691390	1672924691390	0	\N	system		system	bhfouoto7gtbb3py83ib5nhb7jc
vuyyc843377nodcyrd7n1g6xeuw	2023-01-05 13:18:11.678364+00		1	view	By Sprint	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{"ai7ajsdk14w7x5s8up3dwir77te":"count"},"columnWidths":{"20717ad3-5741-4416-83f1-6f133fff3d11":128,"50117d52-bcc7-4750-82aa-831a351c44a0":126,"__title":280,"a1g6i613dpe9oryeo71ex3c86hy":159,"aeomttrbhhsi8bph31jn84sto6h":141,"ax9f8so418s6s65hi5ympd93i6a":183,"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":100},"defaultTemplateId":"czb9pr8mi6pfb7g8geiymmqndqe","filter":{"filters":[],"operation":"and"},"groupById":"60985f46-3e41-486e-8213-2b987440ea1c","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["50117d52-bcc7-4750-82aa-831a351c44a0","20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","aphg37f7zbpuc3bhwhp19s1ribh","a4378omyhmgj3bex13sj4wbpfiy","ai7ajsdk14w7x5s8up3dwir77te","a1g6i613dpe9oryeo71ex3c86hy","aeomttrbhhsi8bph31jn84sto6h","ax9f8so418s6s65hi5ympd93i6a"]}	1672924691690	1672924691690	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
czb9pr8mi6pfb7g8geiymmqndqe	2023-01-05 13:18:11.678364+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	User Story	{"contentOrder":["aun6h5bzz8ib9mxyngwemy8kf9w"],"icon":"📖","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"apht1nt5ryukdmxkh6fkfn6rgoy","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer"}}	1672924691693	1672924691693	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
cxizdup9qe38k9nnfc1s3u74syr	2023-01-05 13:18:11.678364+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Horizontal scroll issue	{"contentOrder":["ae9nrzn1s6byhdgwqaqkxzsrycy","auoe67ckow7ydbkfckfbnzmg3ew","7b1cbjfsur3n1jj4ksox4qsig8e"],"icon":"〰️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"aomnawq4551cbbzha9gxnmb3z5w","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","ai7ajsdk14w7x5s8up3dwir77te":"1","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1672924691696	1672924691696	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
c13jre9i1zb865en3wws6f81kfy	2023-01-05 13:18:11.678364+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Login screen not loading	{"contentOrder":["aacx3p8a59tnubyb8iysnf8mh7a","a35u5uxeyhfbnzbut8jpz8xaete","7xk1ib9g8ejy3ip8t18wikup8ja"],"icon":"🖥️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"aomnawq4551cbbzha9gxnmb3z5w","50117d52-bcc7-4750-82aa-831a351c44a0":"abrfos7e7eczk9rqw6y5abadm1y","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","ai7ajsdk14w7x5s8up3dwir77te":"1","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"cb8ecdac-38be-4d36-8712-c4d58cc8a8e9"}}	1672924691699	1672924691699	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
cdazdcqpzajy8td7uhj3izpaiza	2023-01-05 13:18:11.678364+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Move cards across boards	{"contentOrder":["aehuqx3tuh3rw7mqgoz5duifync"],"icon":"🚚","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"abrfos7e7eczk9rqw6y5abadm1y","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"2","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1672924691703	1672924691703	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
cioyxrb8hbfn4txozz5gn5itiwe	2023-01-05 13:18:11.678364+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Cross-team collaboration	{"contentOrder":["a1hyajcyi3pba5rf5oy9in9jpoa"],"icon":"🤝","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"424ea5e3-9aa1-4075-8c5c-01b44b66e634","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","60985f46-3e41-486e-8213-2b987440ea1c":"14892380-1a32-42dd-8034-a0cea32bc7e6","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"3","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"c62172ea-5da7-4dec-8186-37267d8ee9a7"}}	1672924691706	1672924691706	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
c7oktow86u38dpxwhwwdumrkmew	2023-01-05 13:18:11.678364+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Bug	{"contentOrder":["aubqugebyyir7jeiy8d3eofb6qh","a4w9nyszxeirqxgqqjgigaebs4y","74h7wd8a66jyepmu18rp6dcsyuo"],"icon":"🐞","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"aomnawq4551cbbzha9gxnmb3z5w","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer"}}	1672924691710	1672924691710	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
ciis64kebrf8zipuhzh63kw6g8y	2023-01-05 13:18:11.678364+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Standard properties	{"contentOrder":["awosbkyzk9ff9mgpare4obf3y6a"],"icon":"🏷️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","60985f46-3e41-486e-8213-2b987440ea1c":"14892380-1a32-42dd-8034-a0cea32bc7e6","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"3","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1672924691714	1672924691714	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
c65rybk7kp3g4tq4631kmaj6a6r	2023-01-05 13:18:11.678364+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Epic	{"contentOrder":["aybf1pyesn7f89r1rwxhun8eoao"],"icon":"🤝","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"424ea5e3-9aa1-4075-8c5c-01b44b66e634","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"3","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"c62172ea-5da7-4dec-8186-37267d8ee9a7"}}	1672924691718	1672924691718	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
cbq4ymbirsjbfmyufry44ww883r	2023-01-05 13:18:11.678364+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Global templates	{"contentOrder":["aodmr3dqb1j8wmbygtsestzbise"],"icon":"🖼️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"a6ghze4iy441qhsh3eijnc8hwze","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"2","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1672924691722	1672924691722	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
axui9zb4g7jgcxqre6x6e43apqa	2023-01-05 13:18:12.451033+00	cqgo1rgh4jpdmikoe6tug46huhh	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1672924692542	1672924692542	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
vnct85f3zwbrr8j9y1durpuzjkw	2023-01-05 13:18:11.678364+00	bgi1yqiis8t8xdqxgnet8ebutky	1	view	By Status	{"cardOrder":["cbq4ymbirsjbfmyufry44ww883r","cxizdup9qe38k9nnfc1s3u74syr","cdazdcqpzajy8td7uhj3izpaiza","c13jre9i1zb865en3wws6f81kfy","ciis64kebrf8zipuhzh63kw6g8y","cioyxrb8hbfn4txozz5gn5itiwe"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cidz4imnqhir48brz6e8hxhfrhy","filter":{"filters":[],"operation":"and"},"groupById":"50117d52-bcc7-4750-82aa-831a351c44a0","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["aft5bzo7h9aspqgrx3jpy5tzrer","abrfos7e7eczk9rqw6y5abadm1y","ax8wzbka5ahs3zziji3pp4qp9mc","atabdfbdmjh83136d5e5oysxybw","ace1bzypd586kkyhcht5qqd9eca","aay656c9m1hzwxc9ch5ftymh3nw","a6ghze4iy441qhsh3eijnc8hwze"],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1672924691731	1672924691731	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
v1qhrn4on7fd4bgj7ek6a6ws5ye	2023-01-05 13:18:11.678364+00	bgi1yqiis8t8xdqxgnet8ebutky	1	view	By Type	{"cardOrder":["c13jre9i1zb865en3wws6f81kfy","cdazdcqpzajy8td7uhj3izpaiza","ciis64kebrf8zipuhzh63kw6g8y","cxizdup9qe38k9nnfc1s3u74syr","cbq4ymbirsjbfmyufry44ww883r","cioyxrb8hbfn4txozz5gn5itiwe"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cidz4imnqhir48brz6e8hxhfrhy","filter":{"filters":[],"operation":"and"},"groupById":"20717ad3-5741-4416-83f1-6f133fff3d11","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["424ea5e3-9aa1-4075-8c5c-01b44b66e634","a5yxq8rbubrpnoommfwqmty138h","apht1nt5ryukdmxkh6fkfn6rgoy","aiycbuo3dr5k4xxbfr7coem8ono","aomnawq4551cbbzha9gxnmb3z5w"],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1672924691735	1672924691735	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
aun6h5bzz8ib9mxyngwemy8kf9w	2023-01-05 13:18:11.678364+00	czb9pr8mi6pfb7g8geiymmqndqe	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1672924691738	1672924691738	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
7b1cbjfsur3n1jj4ksox4qsig8e	2023-01-05 13:18:11.678364+00	cxizdup9qe38k9nnfc1s3u74syr	1	image		{"fileId":"7tmfu5iqju3n1mdfwi5gru89qmw.png"}	1672924691741	1672924691741	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
ae9nrzn1s6byhdgwqaqkxzsrycy	2023-01-05 13:18:11.678364+00	cxizdup9qe38k9nnfc1s3u74syr	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1672924691743	1672924691743	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
auoe67ckow7ydbkfckfbnzmg3ew	2023-01-05 13:18:11.678364+00	cxizdup9qe38k9nnfc1s3u74syr	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1672924691747	1672924691747	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
7xk1ib9g8ejy3ip8t18wikup8ja	2023-01-05 13:18:11.678364+00	c13jre9i1zb865en3wws6f81kfy	1	image		{"fileId":"7b9xk9boj3fbqfm3umeaaizp8qr.png"}	1672924691752	1672924691752	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
aacx3p8a59tnubyb8iysnf8mh7a	2023-01-05 13:18:11.678364+00	c13jre9i1zb865en3wws6f81kfy	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1672924691757	1672924691756	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
a35u5uxeyhfbnzbut8jpz8xaete	2023-01-05 13:18:11.678364+00	c13jre9i1zb865en3wws6f81kfy	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1672924691761	1672924691761	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
aehuqx3tuh3rw7mqgoz5duifync	2023-01-05 13:18:11.678364+00	cdazdcqpzajy8td7uhj3izpaiza	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1672924691764	1672924691764	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
a4gocogwg87rgf8kr6jpdj5p6oy	2023-01-05 13:18:11.678364+00	cfmk7771httynm8r7rm8cbrmrya	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1672924691769	1672924691769	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
azbjta561gj8wd87isi916aoatc	2023-01-05 13:18:11.678364+00	cfmk7771httynm8r7rm8cbrmrya	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1672924691772	1672924691772	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
a1hyajcyi3pba5rf5oy9in9jpoa	2023-01-05 13:18:11.678364+00	cioyxrb8hbfn4txozz5gn5itiwe	1	text	## Summary\n*[Brief description of what this epic is about]*\n\n## Motivation\n*[Brief description on why this is needed]*\n\n## Acceptance Criteria\n - *[Criteron 1]*\n - *[Criteron 2]*\n - ...\n\n## Personas\n - *[Persona A]*\n - *[Persona B]*\n - ...\n\n## Reference Materials\n - *[Links to other relevant documents as needed]*\n - ...	{}	1672924691777	1672924691777	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
74h7wd8a66jyepmu18rp6dcsyuo	2023-01-05 13:18:11.678364+00	c7oktow86u38dpxwhwwdumrkmew	1	image		{"fileId":"7tmfu5iqju3n1mdfwi5gru89qmw.png"}	1672924691783	1672924691783	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
aubqugebyyir7jeiy8d3eofb6qh	2023-01-05 13:18:11.678364+00	c7oktow86u38dpxwhwwdumrkmew	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1672924691789	1672924691789	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
a4w9nyszxeirqxgqqjgigaebs4y	2023-01-05 13:18:11.678364+00	c7oktow86u38dpxwhwwdumrkmew	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1672924691794	1672924691794	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
awosbkyzk9ff9mgpare4obf3y6a	2023-01-05 13:18:11.678364+00	ciis64kebrf8zipuhzh63kw6g8y	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1672924691799	1672924691799	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
aybf1pyesn7f89r1rwxhun8eoao	2023-01-05 13:18:11.678364+00	c65rybk7kp3g4tq4631kmaj6a6r	1	text	## Summary\n*[Brief description of what this epic is about]*\n\n## Motivation\n*[Brief description on why this is needed]*\n\n## Acceptance Criteria\n - *[Criteron 1]*\n - *[Criteron 2]*\n - ...\n\n## Personas\n - *[Persona A]*\n - *[Persona B]*\n - ...\n\n## Reference Materials\n - *[Links to other relevant documents as needed]*\n - ...	{}	1672924691805	1672924691805	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
aodmr3dqb1j8wmbygtsestzbise	2023-01-05 13:18:11.678364+00	cbq4ymbirsjbfmyufry44ww883r	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1672924691810	1672924691810	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
atr1gpn98jfrw7cms48utpdizsc	2023-01-05 13:18:11.678364+00	cg4fz84f1ybb4xe346d784hj6sh	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1672924691819	1672924691819	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
vuwfy9kptybrbxry9yzs4q3bgsw	2023-01-05 13:18:12.078234+00		1	view	All Users	{"cardOrder":["cwfijrn8x3jyepf9nrwjhrsx9zy"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":280,"aaebj5fyx493eezx6ukxiwydgty":146,"acjq4t5ymytu8x1f68wkggm7ypc":222,"akrxgi7p7w14fym3gbynb98t9fh":131,"atg9qu6oe4bjm8jczzsn71ff5me":131},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"akrxgi7p7w14fym3gbynb98t9fh","reversed":false}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["aaebj5fyx493eezx6ukxiwydgty","akrxgi7p7w14fym3gbynb98t9fh","atg9qu6oe4bjm8jczzsn71ff5me","acjq4t5ymytu8x1f68wkggm7ypc","aphio1s5gkmpdbwoxynim7acw3e","aqafzdeekpyncwz7m7i54q3iqqy","aify3r761b9w43bqjtskrzi68tr"]}	1672924692089	1672924692089	0	\N	system		system	b69byqn5ghj8umfbseap3ky8qpo
cwfijrn8x3jyepf9nrwjhrsx9zy	2023-01-05 13:18:12.078234+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Frank Nash	{"contentOrder":["az7ntau5zmtdwfjjxxsqza7njew"],"icon":"👨‍💼","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"ap93ysuzy1xa7z818r6myrn4h4y","acjq4t5ymytu8x1f68wkggm7ypc":"frank.nash@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1669896000000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"aehc83ffays3gh8myz16a8j7k4e"}}	1672924692094	1672924692094	0	\N	system		system	b69byqn5ghj8umfbseap3ky8qpo
caoyqkqtjmbngdgrq47qxn5wt7c	2023-01-05 13:18:12.078234+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Richard Parsons	{"contentOrder":["agbjocarp3pftdcrkwjp4hi7ech"],"icon":"👨‍🦱","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"a7yq89whddzob1futao4rxk3yzc","acjq4t5ymytu8x1f68wkggm7ypc":"richard.parsons@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1671019200000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"a1sxagjgaadym5yrjak6tcup1oa"}}	1672924692098	1672924692098	0	\N	system		system	b69byqn5ghj8umfbseap3ky8qpo
c4z9bzfmmxpfp5cd1sayhnrw7me	2023-01-05 13:18:12.078234+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Claire Hart	{"contentOrder":["a8jrdidjhkina9ddkqxguy63gse"],"icon":"👩‍🦰","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"aseqq9hrsua56r3s6nbuirj9eec","acjq4t5ymytu8x1f68wkggm7ypc":"claire.hart@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1670500800000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"ahn89mqg9u4igk6pdm7333t8i5h"}}	1672924692104	1672924692104	0	\N	system		system	b69byqn5ghj8umfbseap3ky8qpo
cd8dkrm4yjpybzpa8k76o54y8wr	2023-01-05 13:18:12.078234+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Olivia Alsop	{"contentOrder":["a1u135oohatbutj6cqztbaxchmy"],"icon":"👩‍💼","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"a7yq89whddzob1futao4rxk3yzc","acjq4t5ymytu8x1f68wkggm7ypc":"olivia.alsop@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1671192000000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"a1sxagjgaadym5yrjak6tcup1oa"}}	1672924692108	1672924692108	0	\N	system		system	b69byqn5ghj8umfbseap3ky8qpo
cnw3ahxzikp83dmf7he6gs8sfir	2023-01-05 13:18:12.078234+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Bernadette Powell	{"contentOrder":["ahjt77a8tcbnkpx6791c9joni6w"],"icon":"🧑‍💼","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"af6hjb3ysuaxbwnfqpby4wwnkdr","acjq4t5ymytu8x1f68wkggm7ypc":"bernadette.powell@email.com"}}	1672924692113	1672924692113	0	\N	system		system	b69byqn5ghj8umfbseap3ky8qpo
v63dxdu8jdpyqb8kxnzfg4num1e	2023-01-05 13:18:12.078234+00	bh4pkixqsjift58e1qy6htrgeay	1	view	By Date	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"akrxgi7p7w14fym3gbynb98t9fh","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1672924692120	1672924692120	0	\N	system		system	b69byqn5ghj8umfbseap3ky8qpo
vwy5tuxn35p8edpg4d8b76kxxyo	2023-01-05 13:18:12.078234+00	bixohg18tt11in4qbtinimk974y	1	view	By Status	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["af6hjb3ysuaxbwnfqpby4wwnkdr","aotxum1p5bw3xuzqz3ctjw66yww","a7yq89whddzob1futao4rxk3yzc","aseqq9hrsua56r3s6nbuirj9eec","ap93ysuzy1xa7z818r6myrn4h4y"],"visiblePropertyIds":[]}	1672924692124	1672924692124	0	\N	system		system	b69byqn5ghj8umfbseap3ky8qpo
az7ntau5zmtdwfjjxxsqza7njew	2023-01-05 13:18:12.078234+00	cwfijrn8x3jyepf9nrwjhrsx9zy	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1672924692128	1672924692128	0	\N	system		system	b69byqn5ghj8umfbseap3ky8qpo
agbjocarp3pftdcrkwjp4hi7ech	2023-01-05 13:18:12.078234+00	caoyqkqtjmbngdgrq47qxn5wt7c	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1672924692134	1672924692134	0	\N	system		system	b69byqn5ghj8umfbseap3ky8qpo
a8jrdidjhkina9ddkqxguy63gse	2023-01-05 13:18:12.078234+00	c4z9bzfmmxpfp5cd1sayhnrw7me	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1672924692140	1672924692140	0	\N	system		system	b69byqn5ghj8umfbseap3ky8qpo
a1u135oohatbutj6cqztbaxchmy	2023-01-05 13:18:12.078234+00	cd8dkrm4yjpybzpa8k76o54y8wr	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1672924692147	1672924692147	0	\N	system		system	b69byqn5ghj8umfbseap3ky8qpo
ahjt77a8tcbnkpx6791c9joni6w	2023-01-05 13:18:12.078234+00	cnw3ahxzikp83dmf7he6gs8sfir	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1672924692151	1672924692151	0	\N	system		system	b69byqn5ghj8umfbseap3ky8qpo
amkdzeei5binwfc65pfb1xgizco	2023-01-05 13:18:12.451033+00	c55srt19grbgkik9a1s1rrbij3r	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1672924692545	1672924692545	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
cckr9sxx73tfe9pksy8ipudfzfh	2023-01-05 13:18:12.257888+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Ositions Inc.	{"contentOrder":["akf1dh4iq8prxifriwoq96s1suy"],"icon":"🌃","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"abajmr34b8g1916w495xjb35iko","a6cwaq79b1pdpb97wkanmeyy4er":"2,700","ahzspe59iux8wigra8bg6cg18nc":"ositionsinc.com","aiefo7nh9jwisn8b4cgakowithy":"$125,000,000","an1eerzscfxn6awdfajbg41uz3h":"2004","aozntq4go4nkab688j1s7stqtfc":"Berlin, Germany"}}	1672924692294	1672924692294	0	\N	system		system	bwzfh6d1x3fr8zb8gfxba65kjah
cxp4qfkegp7byi8bkpztnb33cfe	2023-01-05 13:18:12.257888+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Afformance Ltd.	{"contentOrder":["auacrd8btk3nop8uf5frcd3ro4o"],"icon":"⚡","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"arfjpz9by5car71tz3behba8yih","a6cwaq79b1pdpb97wkanmeyy4er":"1,800","ahzspe59iux8wigra8bg6cg18nc":"afformanceltd.com","aiefo7nh9jwisn8b4cgakowithy":"$200,000,000","an1eerzscfxn6awdfajbg41uz3h":"2002","aozntq4go4nkab688j1s7stqtfc":"Palo Alto, CA"}}	1672924692300	1672924692300	0	\N	system		system	bwzfh6d1x3fr8zb8gfxba65kjah
aj1oizrnd5inifd4ea4pm61nmse	2023-01-05 13:18:12.257888+00	cm6jhium31insino6coq8rziyja	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1672924692306	1672924692306	0	\N	system		system	bwzfh6d1x3fr8zb8gfxba65kjah
ay889a3xr5pyixgudjd6mu4pmyy	2023-01-05 13:18:12.257888+00	czypouqqwyjbkfjkx1sypp5j4ka	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1672924692317	1672924692317	0	\N	system		system	bwzfh6d1x3fr8zb8gfxba65kjah
aiwabx71igfnhje9j39ytd4t1nh	2023-01-05 13:18:12.257888+00	ceedjswwfqpftukmtrnwhjojrwc	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1672924692325	1672924692325	0	\N	system		system	bwzfh6d1x3fr8zb8gfxba65kjah
akf1dh4iq8prxifriwoq96s1suy	2023-01-05 13:18:12.257888+00	cckr9sxx73tfe9pksy8ipudfzfh	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n\n## Weaknesses\n- ...\n- ...\n\n## Opportunities\n- ...\n- ...\n\n## Threats\n- ...\n- ...	{}	1672924692331	1672924692331	0	\N	system		system	bwzfh6d1x3fr8zb8gfxba65kjah
auacrd8btk3nop8uf5frcd3ro4o	2023-01-05 13:18:12.257888+00	cxp4qfkegp7byi8bkpztnb33cfe	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1672924692339	1672924692339	0	\N	system		system	bwzfh6d1x3fr8zb8gfxba65kjah
cmt53wtfcutnodngaif13xebxjr	2023-01-05 13:18:12.451033+00	brs9cdimfw7fodyi7erqt747rhc	1	card	New Project and Workflow Management Solutions for Developers	{"contentOrder":["71qhnzuec6esdi6fnynwpze4xya","afmba3c9ngfyhjnkefi3o5mfcto"],"icon":"🎯","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1645790400000}","ab6mbock6styfe6htf815ph1mhw":["a8xceonxiu4n3c43szhskqizicr","a3pdzi53kpbd4okzdkz6khi87zo","a3d9ux4fmi3anyd11kyipfbhwde"],"ae9ar615xoknd8hw8py7mbyr7zo":"awna1nuarjca99m9s4uiy9kwj5h","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://mattermost.com/newsroom/press-releases/mattermost-launches-new-project-and-workflow-management-solutions-for-developers/","aysx3atqexotgwp5kx6h5i5ancw":"aywiofmmtd3ofgzj95ysky4pjga"}}	1672924692462	1672924692462	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
cqg5ajzp4kbr4tbnukkn5own69a	2023-01-05 13:18:12.451033+00	brs9cdimfw7fodyi7erqt747rhc	1	card	[Tweet] Mattermost v6.1 includes card @-mention notifications in Boards	{"contentOrder":["7i96m7nbsdsex8n6hzuzrmdfjuy","7ed5bwp3gr8yax3mhtuwiaa9gjy","ahhm75n8oxfriik5qafjmuaf99o","af3ryrnj6n3yqdymhfemob9xnfa","abdasiyq4k7ndtfrdadrias8sjy","7uzr864r987rad85fzswweb8qsy"],"icon":"🐤","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1639051200000}","ab6mbock6styfe6htf815ph1mhw":["az8o8pfe9hq6s7xaehoqyc3wpyc"],"ae9ar615xoknd8hw8py7mbyr7zo":"a9ana1e9w673o5cp8md4xjjwfto","agqsoiipowmnu9rdwxm57zrehtr":"{\\"from\\":1637668800000}","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://twitter.com/Mattermost/status/1463145633162969097?s=20","aysx3atqexotgwp5kx6h5i5ancw":"aj8y675weso8kpb6eceqbpj4ruw"}}	1672924692469	1672924692469	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
cqgo1rgh4jpdmikoe6tug46huhh	2023-01-05 13:18:12.451033+00	brs9cdimfw7fodyi7erqt747rhc	1	card	Top 10 Must-Have DevOps Tools in 2021	{"contentOrder":["7fo1utqc8x1z1z6hzg33hes1ktc","axui9zb4g7jgcxqre6x6e43apqa"],"icon":"🛠️","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1636113600000}","ab6mbock6styfe6htf815ph1mhw":["a8xceonxiu4n3c43szhskqizicr"],"ae9ar615xoknd8hw8py7mbyr7zo":"a9ana1e9w673o5cp8md4xjjwfto","agqsoiipowmnu9rdwxm57zrehtr":"{\\"from\\":1637323200000}","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://www.toolbox.com/tech/devops/articles/best-devops-tools/","aysx3atqexotgwp5kx6h5i5ancw":"a3xky7ygn14osr1mokerbfah5cy"}}	1672924692475	1672924692475	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
c6eagmasydp8sbecdjmqt9gba3c	2023-01-05 13:18:12.87149+00	bui5izho7dtn77xg3thkiqprc9r	1	card	App crashing	{"contentOrder":["79t7rkiuspeneqi9xurou9tqzwh","and3sqp9cnidhibgpf9sbnbzhxe","anwog7znmrbyuxp8nfmkxd6ouic","7u1e843j9s7d7ir4mabs6za7tac"],"icon":"📉","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"1fdbb515-edd2-4af5-80fc-437ed2211a49","50117d52-bcc7-4750-82aa-831a351c44a0":"ec6d2bc5-df2b-4f77-8479-e59ceb039946","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"cb8ecdac-38be-4d36-8712-c4d58cc8a8e9"}}	1672924692882	1672924692882	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
c55srt19grbgkik9a1s1rrbij3r	2023-01-05 13:18:12.451033+00	brs9cdimfw7fodyi7erqt747rhc	1	card	Unblocking Workflows: The Guide to Developer Productivity	{"contentOrder":["77tz16jtz5x73ncs3dxc3fp1d7h","amkdzeei5binwfc65pfb1xgizco"],"icon":"💻","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1638532800000}","ab6mbock6styfe6htf815ph1mhw":["a3pdzi53kpbd4okzdkz6khi87zo"],"ae9ar615xoknd8hw8py7mbyr7zo":"apy9dcd7zmand615p3h53zjqxjh","agqsoiipowmnu9rdwxm57zrehtr":"{\\"from\\":1639483200000}","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://mattermost.com/newsroom/press-releases/mattermost-unveils-definitive-report-on-the-state-of-developer-productivity-unblocking-workflows-the-guide-to-developer-productivity-2022-edition/","aysx3atqexotgwp5kx6h5i5ancw":"a3xky7ygn14osr1mokerbfah5cy"}}	1672924692478	1672924692478	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
vr8hpextju7d7zfk5wha7a77c8y	2023-01-05 13:18:12.451033+00	brs9cdimfw7fodyi7erqt747rhc	1	view	By Status	{"cardOrder":[null,"cdbfkd15d6iy18rgx1tskmfsr6c","cn8yofg9rtkgmzgmb5xdi56p3ic","csgsnnywpuqzs5jgq87snk9x17e","cqwaytore5y487wdu8zffppqnea",null],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["awna1nuarjca99m9s4uiy9kwj5h","a9ana1e9w673o5cp8md4xjjwfto","apy9dcd7zmand615p3h53zjqxjh","acri4cm3bmay55f7ksztphmtnga","amsowcd9a8e1kid317r7ttw6uzh",""],"visiblePropertyIds":["ab6mbock6styfe6htf815ph1mhw"]}	1672924692482	1672924692482	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
vuio6u3spgbns5f5perkasojzny	2023-01-05 13:18:12.451033+00	brs9cdimfw7fodyi7erqt747rhc	1	view	Due Date Calendar	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"a39x5cybshwrbjpc3juaakcyj6e","defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1672924692486	1672924692486	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
vit3jujmfn3dj5kfc456oh8caoo	2023-01-05 13:18:12.451033+00	brs9cdimfw7fodyi7erqt747rhc	1	view	Publication Calendar	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"agqsoiipowmnu9rdwxm57zrehtr","defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1672924692490	1672924692490	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
v7qtpgchp5tdcbngqecz4qn16ec	2023-01-05 13:18:12.451033+00	brs9cdimfw7fodyi7erqt747rhc	1	view	Content List	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":322,"ab6mbock6styfe6htf815ph1mhw":229,"aysx3atqexotgwp5kx6h5i5ancw":208},"defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"a39x5cybshwrbjpc3juaakcyj6e","reversed":false}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["ae9ar615xoknd8hw8py7mbyr7zo","aysx3atqexotgwp5kx6h5i5ancw","ab6mbock6styfe6htf815ph1mhw","ao44fz8nf6z6tuj1x31t9yyehcc","a39x5cybshwrbjpc3juaakcyj6e","agqsoiipowmnu9rdwxm57zrehtr","ap4e7kdg7eip7j3c3oyiz39eaoc"]}	1672924692495	1672924692495	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
afmba3c9ngfyhjnkefi3o5mfcto	2023-01-05 13:18:12.451033+00	cmt53wtfcutnodngaif13xebxjr	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1672924692500	1672924692500	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
7uzr864r987rad85fzswweb8qsy	2023-01-05 13:18:12.451033+00	cqg5ajzp4kbr4tbnukkn5own69a	1	image		{"fileId":"7y5kr8x8ybpnwdykjfuz57rggrh.png"}	1672924692506	1672924692506	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
ahhm75n8oxfriik5qafjmuaf99o	2023-01-05 13:18:12.451033+00	cqg5ajzp4kbr4tbnukkn5own69a	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1672924692511	1672924692511	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
af3ryrnj6n3yqdymhfemob9xnfa	2023-01-05 13:18:12.451033+00	cqg5ajzp4kbr4tbnukkn5own69a	1	text	## Media	{}	1672924692515	1672924692515	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
apcob6b59h7gw8deo55xg93ix6r	2023-01-05 13:18:12.451033+00	cff1jmrxfrirgbeebhr9qd7nida	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1672924692523	1672924692523	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
ae43fckijs7feujskx7pqj3qr6r	2023-01-05 13:18:12.451033+00	cff1jmrxfrirgbeebhr9qd7nida	1	text	## Research\n- ...\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n- ...\n\n## Notes\n- ...\n- ...\n- ...	{}	1672924692532	1672924692532	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
aanguuc44ybbbzjyjfy1w49rrsc	2023-01-05 13:18:12.451033+00	cff1jmrxfrirgbeebhr9qd7nida	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1672924692540	1672924692540	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
v1qpind9zdifqzrk9c4po6srbge	2023-01-05 13:18:12.730276+00	bjbhs6bos3m8zjouf78xceg9nqw	1	view	Board view	{"cardOrder":["cniwb8xwcqtbstbcm3sdfrr854h","cs4qwpzr65fgttd7364dicskanh","c9s78pzbdg3g4jkcdjqahtnfejc","c8utmazns878jtfgtf7exyi9pee","cnobejmb6bf8e3c1w7em5z4pwyh"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["aok6pgecm85qe9k5kcphzoe63ma","aq1dwbf661yx337hjcd5q3sbxwa","ar87yh5xmsswqkxmjq1ipfftfpc","akj3fkmxq7idma55mdt8sqpumyw"],"visiblePropertyIds":["aspaay76a5wrnuhtqgm97tt3rer"]}	1672924692744	1672924692744	0	\N	system		system	bomnbp7on3pfdtpby8bpzcesf8w
cjnntjxru7tfnfjxkxxnms1a1ic	2023-01-05 13:18:12.730276+00	bsjd59qtpbf888mqez3ge77domw	1	card	Tight deadline	{"contentOrder":[],"icon":"📅","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"ar87yh5xmsswqkxmjq1ipfftfpc"}}	1672924692753	1672924692753	0	\N	system		system	bomnbp7on3pfdtpby8bpzcesf8w
ct8fxw5gsziyujdxs9x7siuwpqy	2023-01-05 13:18:12.730276+00	bsjd59qtpbf888mqez3ge77domw	1	card	Team communication	{"contentOrder":[],"icon":"💬","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"aq1dwbf661yx337hjcd5q3sbxwa"}}	1672924692763	1672924692763	0	\N	system		system	bomnbp7on3pfdtpby8bpzcesf8w
cw7epsnzfntfg8d8g9r73rp6g4y	2023-01-05 13:18:12.730276+00	bsjd59qtpbf888mqez3ge77domw	1	card	Reschedule planning meeting	{"contentOrder":[],"icon":"🗓️","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"aok6pgecm85qe9k5kcphzoe63ma"}}	1672924692771	1672924692771	0	\N	system		system	bomnbp7on3pfdtpby8bpzcesf8w
cheiau4h4njntf89oi9mggqemhh	2023-01-05 13:18:12.730276+00	bsjd59qtpbf888mqez3ge77domw	1	card	Schedule more time for testing	{"contentOrder":[],"icon":"🧪","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"akj3fkmxq7idma55mdt8sqpumyw"}}	1672924692778	1672924692778	0	\N	system		system	bomnbp7on3pfdtpby8bpzcesf8w
cbwd4fsf7zi8c5e3jo48ys3je5y	2023-01-05 13:18:12.730276+00	bsjd59qtpbf888mqez3ge77domw	1	card	Positive user feedback	{"contentOrder":[],"icon":"🥰","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"aq1dwbf661yx337hjcd5q3sbxwa"}}	1672924692787	1672924692787	0	\N	system		system	bomnbp7on3pfdtpby8bpzcesf8w
ce91q5c5zwjr5i8km6e53au3qcy	2023-01-05 13:18:12.87149+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Calendar view	{"contentOrder":["7df11783ny67mdnognqae31ax6y","atfbkw1wuntyhtqswfsegj14hew"],"icon":"📆","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"6eea96c9-4c61-4968-8554-4b7537e8f748","50117d52-bcc7-4750-82aa-831a351c44a0":"849766ba-56a5-48d1-886f-21672f415395","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1672924692888	1672924692887	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
c9k4wegbc8j8xmnqth9skxd3t8w	2023-01-05 13:18:12.87149+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Standard templates	{"contentOrder":["7uonmjk41nipnrsi6tz8wau5ssh","a5j43dzy68td63jkppxw7f5oatr"],"icon":"🗺️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"6eea96c9-4c61-4968-8554-4b7537e8f748","50117d52-bcc7-4750-82aa-831a351c44a0":"ec6d2bc5-df2b-4f77-8479-e59ceb039946","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1672924692892	1672924692892	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
ck618a41yo785mjzd3d18j9s7oa	2023-01-05 13:18:12.87149+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Import / Export	{"contentOrder":["aac9gqfnetfrgzrpecwn81b6bcw"],"icon":"🚢","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"6eea96c9-4c61-4968-8554-4b7537e8f748","50117d52-bcc7-4750-82aa-831a351c44a0":"ec6d2bc5-df2b-4f77-8479-e59ceb039946","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1672924692896	1672924692896	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
ctd4fs1mtgpfjujqtb9rrtwm4gy	2023-01-05 13:18:12.87149+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Review API design	{"contentOrder":["atgf5bk1x4bfazjfd367tpfrmoe"],"icon":"🛣️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"424ea5e3-9aa1-4075-8c5c-01b44b66e634","50117d52-bcc7-4750-82aa-831a351c44a0":"8c557f69-b0ed-46ec-83a3-8efab9d47ef5","60985f46-3e41-486e-8213-2b987440ea1c":"14892380-1a32-42dd-8034-a0cea32bc7e6","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"c62172ea-5da7-4dec-8186-37267d8ee9a7"}}	1672924692900	1672924692900	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
cugps7oe44pd79muo7czww6cdth	2023-01-05 13:18:12.87149+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Icons don't display	{"contentOrder":["ab4e7hxz8cigr9dk5d3wt8wnwry","a1quczo73ui8hbr44btmudke9xh","73t731shun7rumfbnp99ktb3oaw"],"icon":"💻","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"1fdbb515-edd2-4af5-80fc-437ed2211a49","50117d52-bcc7-4750-82aa-831a351c44a0":"8c557f69-b0ed-46ec-83a3-8efab9d47ef5","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1672924692906	1672924692906	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
va67hxe5qg78quxo5gsmgtr4mwc	2023-01-05 13:18:12.87149+00	bui5izho7dtn77xg3thkiqprc9r	1	view	Calendar View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"a4378omyhmgj3bex13sj4wbpfiy","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1672924692910	1672924692910	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
ai19abeop4pgspc9yq1c8319iwh	2023-01-05 13:18:12.87149+00	cidz4imnqhir48brz6e8hxhfrhy	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1672924693009	1672924693009	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
ahzutx47zntddtchrt7tm8zba4c	2023-01-05 13:18:12.87149+00	cidz4imnqhir48brz6e8hxhfrhy	1	text	## Requirements\n- [Requirement 1]\n- [Requirement 2]\n- ...	{}	1672924693014	1672924693014	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
vxc48htzaipbbu8h7fppqu3ptdw	2023-01-05 13:18:12.87149+00	bui5izho7dtn77xg3thkiqprc9r	1	view	Board: Sprints	{"cardOrder":["c6eagmasydp8sbecdjmqt9gba3c","ce91q5c5zwjr5i8km6e53au3qcy","c9k4wegbc8j8xmnqth9skxd3t8w","cugps7oe44pd79muo7czww6cdth","ck618a41yo785mjzd3d18j9s7oa","ctd4fs1mtgpfjujqtb9rrtwm4gy"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"60985f46-3e41-486e-8213-2b987440ea1c","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["c01676ca-babf-4534-8be5-cce2287daa6c","ed4a5340-460d-461b-8838-2c56e8ee59fe","14892380-1a32-42dd-8034-a0cea32bc7e6",""],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1672924692916	1672924692916	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
v7acgy1g59pnodm655d9d4trekh	2023-01-05 13:18:12.87149+00	bui5izho7dtn77xg3thkiqprc9r	1	view	List: Tasks 🔨	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"50117d52-bcc7-4750-82aa-831a351c44a0":139,"__title":280},"defaultTemplateId":"","filter":{"filters":[{"condition":"includes","propertyId":"20717ad3-5741-4416-83f1-6f133fff3d11","values":["6eea96c9-4c61-4968-8554-4b7537e8f748"]}],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"50117d52-bcc7-4750-82aa-831a351c44a0","reversed":true}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["50117d52-bcc7-4750-82aa-831a351c44a0","20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1672924692923	1672924692923	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
vud76uokugiypzjpeb6bqf4mzfr	2023-01-05 13:18:12.87149+00	bui5izho7dtn77xg3thkiqprc9r	1	view	Board: Status	{"cardOrder":["c6eagmasydp8sbecdjmqt9gba3c","cm4w7cc3aac6s9jdcujbs4j8f4r","c6egh6cpnj137ixdoitsoxq17oo","cct9u78utsdyotmejbmwwg66ihr","cmft87it1q7yebbd51ij9k65xbw","c9fe77j9qcruxf4itzib7ag6f1c","coup7afjknqnzbdwghiwbsq541w","c5ex1hndz8qyc8gx6ofbfeksftc"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cidz4imnqhir48brz6e8hxhfrhy","filter":{"filters":[],"operation":"and"},"groupById":"50117d52-bcc7-4750-82aa-831a351c44a0","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["8c557f69-b0ed-46ec-83a3-8efab9d47ef5","ec6d2bc5-df2b-4f77-8479-e59ceb039946","849766ba-56a5-48d1-886f-21672f415395",""],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1672924692928	1672924692928	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
a5umu1drucfn9zjxr3ta78xsbzo	2023-01-05 13:18:13.314902+00	c68jnqiqjyb8rzpsssydoa35qoh	1	text	After you've copied the link, paste it into any channel or Direct Message to share the card. A preview of the card will display within the channel with a link back to the card on Boards.	{}	1672924693522	1672924693522	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
vgkapxma4gibjbjxadt1hhfuowr	2023-01-05 13:18:12.87149+00	bui5izho7dtn77xg3thkiqprc9r	1	view	List: Bugs 🐞	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"50117d52-bcc7-4750-82aa-831a351c44a0":145,"__title":280},"defaultTemplateId":"","filter":{"filters":[{"condition":"includes","propertyId":"20717ad3-5741-4416-83f1-6f133fff3d11","values":["1fdbb515-edd2-4af5-80fc-437ed2211a49"]}],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["50117d52-bcc7-4750-82aa-831a351c44a0","20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1672924692934	1672924692934	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
7u1e843j9s7d7ir4mabs6za7tac	2023-01-05 13:18:12.87149+00	c6eagmasydp8sbecdjmqt9gba3c	1	image		{"fileId":"77pe9r4ckbin438ph3f18bpatua.png"}	1672924692940	1672924692940	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
and3sqp9cnidhibgpf9sbnbzhxe	2023-01-05 13:18:12.87149+00	c6eagmasydp8sbecdjmqt9gba3c	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1672924692948	1672924692948	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
anwog7znmrbyuxp8nfmkxd6ouic	2023-01-05 13:18:12.87149+00	c6eagmasydp8sbecdjmqt9gba3c	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1672924692957	1672924692957	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
atfbkw1wuntyhtqswfsegj14hew	2023-01-05 13:18:12.87149+00	ce91q5c5zwjr5i8km6e53au3qcy	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1672924692964	1672924692964	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
a5j43dzy68td63jkppxw7f5oatr	2023-01-05 13:18:12.87149+00	c9k4wegbc8j8xmnqth9skxd3t8w	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1672924692972	1672924692972	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
7qgehoy1x4jr35b9es6a8sdqrye	2023-01-05 13:18:12.87149+00	cfefgwjke6bbxpjpig618g9bpte	1	image		{"fileId":"7pbp4qg415pbstc6enzeicnu3qh.png"}	1672924692978	1672924692978	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
aomm6ppnyeifhuyfjunft8677jr	2023-01-05 13:18:12.87149+00	cfefgwjke6bbxpjpig618g9bpte	1	text	## Screenshots\nIf applicable, add screenshots to elaborate on the problem.	{}	1672924692984	1672924692984	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
ado7qf184mpfqbx4dmf6n87wbia	2023-01-05 13:18:12.87149+00	cfefgwjke6bbxpjpig618g9bpte	1	text	## Steps to reproduce the behavior\n\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n\nA clear and concise description of what you expected to happen.\n\n## Edition and Platform\n\n - Edition: Personal Desktop / Personal Server / Mattermost plugin\n - Version: [e.g. v0.9.0]\n - Browser and OS: [e.g. Chrome 91 on macOS, Edge 93 on Windows]\n\n## Additional context\n\nAdd any other context about the problem here.	{}	1672924692991	1672924692991	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
a86toi7ajnp8bpyykgwwf8zbkco	2023-01-05 13:18:12.87149+00	cfefgwjke6bbxpjpig618g9bpte	1	text	## Steps to reproduce the behavior\n\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n\n*[A clear and concise description of what you expected to happen.]*\n\n## Screenshots\n\n*[If applicable, add screenshots to elaborate on the problem.]*\n\n## Edition and Platform\n\n - Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n - Version: *[e.g. v0.9.0]*\n - Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n\n*[Add any other context about the problem here.]*	{}	1672924692996	1672924692996	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
aac9gqfnetfrgzrpecwn81b6bcw	2023-01-05 13:18:12.87149+00	ck618a41yo785mjzd3d18j9s7oa	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1672924693002	1672924693002	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
atgf5bk1x4bfazjfd367tpfrmoe	2023-01-05 13:18:12.87149+00	ctd4fs1mtgpfjujqtb9rrtwm4gy	1	text	## Summary\n*[Brief description of what this epic is about]*\n\n## Motivation\n*[Brief description on why this is needed]*\n\n## Acceptance Criteria\n - *[Criteron 1]*\n - *[Criteron 2]*\n - ...\n\n## Personas\n - *[Persona A]*\n - *[Persona B]*\n - ...\n\n## Reference Materials\n - *[Links to other relevant documents as needed]*\n - ...	{}	1672924693020	1672924693020	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
73t731shun7rumfbnp99ktb3oaw	2023-01-05 13:18:12.87149+00	cugps7oe44pd79muo7czww6cdth	1	image		{"fileId":"7pbp4qg415pbstc6enzeicnu3qh.png"}	1672924693027	1672924693027	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
a1quczo73ui8hbr44btmudke9xh	2023-01-05 13:18:12.87149+00	cugps7oe44pd79muo7czww6cdth	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1672924693039	1672924693039	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
ab4e7hxz8cigr9dk5d3wt8wnwry	2023-01-05 13:18:12.87149+00	cugps7oe44pd79muo7czww6cdth	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1672924693055	1672924693055	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
aw1wn1tmq1ifmmdmbjz1cp7ww4a	2023-01-05 13:18:12.87149+00	cwrq9ag3p5pgzzy98nfd3wwra1w	1	text	## Summary\n*[Brief description of what this epic is about]*\n## Motivation\n*[Brief description on why this is needed]*\n## Acceptance Criteria\n- *[Criteron 1]*\n- *[Criteron 2]*\n- ...\n## Personas\n- *[Persona A]*\n- *[Persona B]*\n- ...\n## Reference Materials\n- *[Links to other relevant documents as needed]*\n- ...	{}	1672924693065	1672924693065	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
aj1igczq17ib3zkzapwjuht3h7e	2023-01-05 13:18:12.87149+00	cwrq9ag3p5pgzzy98nfd3wwra1w	1	text	## Summary\n[Brief description of what this epic is about]\n\n## Motivation\n[Brief description on why this is needed]\n\n## Acceptance Criteria\n - [Criteron 1]\n - [Criteron 2]\n - ...\n\n## Personas\n - [Persona A]\n - [Persona B]\n - ...\n\n## Reference Materials\n - [Links to other relevant documents as needed]\n - ...	{}	1672924693071	1672924693071	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
atrwubb6yof8rzqspy3udcz5gph	2023-01-05 13:18:13.314902+00	c68jnqiqjyb8rzpsssydoa35qoh	1	text	To share a card, you'll need to copy the card link first. You can:\n\n- Open a card and select the options menu button at the top right of the card.\n- Open the board view and hover your mouse over any card to access the options menu button.	{}	1672924693527	1672924693527	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
cmtkcampr33fxfqajdg566eifyo	2023-01-05 13:18:13.314902+00	buixxjic3xjfkieees4iafdrznc	1	card	Drag cards	{"contentOrder":["apktbgtee5jb8xrnqy3ibiujxew","aa6hukwhhcfgytyd8um1w87xcdc"],"icon":"🤏","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#dragging-cards","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1672924693323	1672924693323	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
chjd4w5fxcfgf9euj74zcxwdtdo	2023-01-05 13:18:13.314902+00	buixxjic3xjfkieees4iafdrznc	1	card	Manage tasks with cards	{"contentOrder":["a4zw8644qabgn9jod71d66ri8fo","7uzwzjayawbnpprzuhf8zecpo9c","7tzurgs5mwjd8pc3qka9ojeaxba","784uu3ufcgb878ky7hyugmf6xcw","76jzdfdjw33fc9r6wdqbfuspzde","794wkegbnt7fxfps4zfpr9kq9na","7yis6kg4ofjgytb6x3uqto47amh","7nb8y7jyoetro8cd36qcju53z8c","75pnrn1jdw7dbxj15ziuxkyz5oc","79arebkh1t3ge3gwwno8iz7gozo","76nwb9tqfsid5jx46yw34itqima","7dy3mcgzgybf1ifa3emgewkzj7e","a5ca6tii33bfw8ba36y1rswq3he","7876od6xhffr6fy69zeogag7eyw","7x7bq9awkatbm5x4docbh5gaw4y","7ghpx9qff43dgtke1rwidmge1ho","7nb8y7jyoetro8cd36qcju53z8c","7hdyxemhbytfm3m83g88djq9nhr","7pgnejxokubbe9kdrxj6g9qa41e","7hw9z6qtx8jyizkmm9g5yq3gxcy","7gk6ooz6npbb8by5rgp9aig7tua","7g6w8mxth1tbi8grnmpkkiiwoah"],"icon":"☑️","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"amm6wfhnbuxojwssyftgs9dipqe","acypkejeb5yfujhj9te57p9kaxw":"aanaehcw3m13jytujsjk5hpf6ry"}}	1672924693327	1672924693327	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
crgryu1mz1ifw9bi9y8eypg639y	2023-01-05 13:18:13.314902+00	buixxjic3xjfkieees4iafdrznc	1	card	Create your own board	{"contentOrder":["aqqq44myoq3bytetg8dkny71zah","acnd936gtg7biue6iqrqm4g1tkw","7r9my1yuddbn45dojrfht3neg8c","7eir5gdjxgjbsxpbyp3df4npcze","7rfs4intj4tfp5fb3kc3hzmeper"],"icon":"📋","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#adding-new-boards","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"amm6wfhnbuxojwssyftgs9dipqe","acypkejeb5yfujhj9te57p9kaxw":"aanaehcw3m13jytujsjk5hpf6ry"}}	1672924693332	1672924693332	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
c4j5mdjzu7ibgiqy9usqpysgkpw	2023-01-05 13:18:13.314902+00	buixxjic3xjfkieees4iafdrznc	1	card	Share a board	{"contentOrder":["aaiwtagtnaid7zcpfhqbwmwqhro","azfuwnqnagiriz8exm3gq6bb8ce","7r7asyew8d7fyunf4sow8e5iyoc","ad8j3n8tp77bppee3ipjt6odgpe","7w935usqt6pby8qz9x5pxaj7iow","7ogbs8h6q4j8z7ngy1m7eag63nw","7z1jau5qy3jfcxdp5cgq3duk6ne","7q5t75g5mfbdhjyiqewgkng1zhr"],"icon":"📤","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/sharing-boards.html","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1672924693336	1672924693336	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
cbx789k4b9pn9ibensfy1ntf3ra	2023-01-05 13:18:13.314902+00	buixxjic3xjfkieees4iafdrznc	1	card	Create a new card	{"contentOrder":["atr485n34hjyufcsnteo39yzfgh","adhsx4h5ss7rqdcjt8xyam6xtqc","afm8hkgpk6pgc3q7fzt6mcp1rih","7me9p46gbqiyfmfnapi7dyxb5br","7yja7ojo1w7fgub4i7ajiy8egey"],"icon":"📝","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#adding-cards","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"amm6wfhnbuxojwssyftgs9dipqe","acypkejeb5yfujhj9te57p9kaxw":"aanaehcw3m13jytujsjk5hpf6ry"}}	1672924693341	1672924693341	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
c68jnqiqjyb8rzpsssydoa35qoh	2023-01-05 13:18:13.314902+00	buixxjic3xjfkieees4iafdrznc	1	card	Share cards on Channels	{"contentOrder":["agc6mebe5k7gmuc9cf7mfr3ei4r","atrwubb6yof8rzqspy3udcz5gph","a5umu1drucfn9zjxr3ta78xsbzo","7ppwiwaxoyfnezyze3eb7tuoe1h"],"icon":"📮","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html#share-card-previews","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"af3p8ztcyxgn8wd9z4az7o9tjeh","acypkejeb5yfujhj9te57p9kaxw":"ascd7nm9r491ayot8i86g1gmgqw"}}	1672924693345	1672924693345	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
ca6779z9sp3gkxnhttsi87cc3ee	2023-01-05 13:18:13.314902+00	buixxjic3xjfkieees4iafdrznc	1	card	Filter and sort cards	{"contentOrder":["a4fz9kcfs9ibj8puk9mux7ac94c","afsuxsmhisig9b8oshw6ttthybc","78i8aqjmqtibr7x4okhz6uqquqr","7we8qh6cnk7njfqrtkhe9ref1do"],"icon":"🎛️","isTemplate":false,"properties":{"a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1672924693350	1672924693350	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
aqqq44myoq3bytetg8dkny71zah	2023-01-05 13:18:13.314902+00	crgryu1mz1ifw9bi9y8eypg639y	1	text	A board helps you manage your project, organize tasks, and collaborate with your team all in one place.	{}	1672924693479	1672924693479	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
cph49auqcnp89tkj8ewhn18fbdc	2023-01-05 13:18:13.314902+00	buixxjic3xjfkieees4iafdrznc	1	card	Create a new view	{"contentOrder":["aozbezukpgif3jpbsq7tahmmp5e","aes6itqd7bibg5bj3tfqsf5ub8e","7owai1ux3h3gtf8byynfk6hyx1c","7n8jq1dizyfgotby3o91arf1hxh","77y4wffj1ctg7xmm9bx45qn6q6o","78aetf7whm7b77bf4c6cwopru1o"],"icon":"👓","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#adding-new-views","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"af3p8ztcyxgn8wd9z4az7o9tjeh","acypkejeb5yfujhj9te57p9kaxw":"ascd7nm9r491ayot8i86g1gmgqw"}}	1672924693355	1672924693355	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
cknwsb8ydwfg9meo47cagtfejhh	2023-01-05 13:18:13.314902+00	buixxjic3xjfkieees4iafdrznc	1	card	Add new properties	{"contentOrder":["ax55zfmg36irmujxdu7mmi8jciy","ayhk11qsuz789fk8bqae4oz8mro","7gc3z8cf8rirgfyutwoke9nn6jy","76cinqnb6k3dzmfbm9fnc8eofny","7db1qh8up4jbxjpjh8jko3b574y"],"icon":"🏷️","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html#add-and-manage-properties","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"af3p8ztcyxgn8wd9z4az7o9tjeh","acypkejeb5yfujhj9te57p9kaxw":"ascd7nm9r491ayot8i86g1gmgqw"}}	1672924693360	1672924693360	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
cqh6oczxk6tn9tf836qtk7qwc4r	2023-01-05 13:18:13.314902+00	buixxjic3xjfkieees4iafdrznc	1	card	@mention teammates	{"contentOrder":["aws4m776wgtd7xy7st6e6pxfy1a","apsy1grew9pr7tkxi3fzyox4y9o","7mbw9t71hjbrydgzgkqqaoh8usr","7j89d11qegjr49x66uen1ic9w6a"],"icon":"🔔","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html#mention-people","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1672924693365	1672924693365	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
v49fi3p4nytg1bdit1syg1z5apr	2023-01-05 13:18:13.314902+00	buixxjic3xjfkieees4iafdrznc	1	view	Preview: Table View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":280,"a972dc7a-5f4c-45d2-8044-8c28c69717f1":100,"acypkejeb5yfujhj9te57p9kaxw":169},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a972dc7a-5f4c-45d2-8044-8c28c69717f1","aqh13jabwexjkzr3jqsz1i1syew","acmg7mz1rr1eykfug4hcdpb1y1o","acypkejeb5yfujhj9te57p9kaxw"]}	1672924693372	1672924693372	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
vc8r54mexqpfszx6gb6y91xg7yh	2023-01-05 13:18:13.314902+00	buixxjic3xjfkieees4iafdrznc	1	view	Preview: Calendar View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"acmg7mz1rr1eykfug4hcdpb1y1o","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1672924693376	1672924693376	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
v1dp6nncawpn19ni1ircfdb3mcy	2023-01-05 13:18:13.314902+00	buixxjic3xjfkieees4iafdrznc	1	view	Preview: Gallery View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"gallery","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1672924693381	1672924693381	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
vey6f6huk1i848qhtw53noibh4y	2023-01-05 13:18:13.314902+00	buixxjic3xjfkieees4iafdrznc	1	view	Onboarding	{"cardOrder":["cbx789k4b9pn9ibensfy1ntf3ra","chjd4w5fxcfgf9euj74zcxwdtdo","crgryu1mz1ifw9bi9y8eypg639y","c68jnqiqjyb8rzpsssydoa35qoh","cknwsb8ydwfg9meo47cagtfejhh","cph49auqcnp89tkj8ewhn18fbdc","cqh6oczxk6tn9tf836qtk7qwc4r","cmtkcampr33fxfqajdg566eifyo","c4j5mdjzu7ibgiqy9usqpysgkpw","ca6779z9sp3gkxnhttsi87cc3ee"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a972dc7a-5f4c-45d2-8044-8c28c69717f1","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["aqb5x3pt87dcc9stbk4ofodrpoy","a1mtm777bkagq3iuu7xo9b13qfr","auxbwzptiqzkii5r61uz3ndsy1r","aj9386k1bx8qwmepeuxg3b7z4pw"],"visiblePropertyIds":[]}	1672924693387	1672924693387	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
aa6hukwhhcfgytyd8um1w87xcdc	2023-01-05 13:18:13.314902+00	cmtkcampr33fxfqajdg566eifyo	1	text	Mattermost Boards makes it easy for you to update certain properties on cards through our drag and drop functionality. Simply drag this card from the **Later** column to the **Completed** column to automatically update the status and mark this task as complete.	{}	1672924693393	1672924693393	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
76jzdfdjw33fc9r6wdqbfuspzde	2023-01-05 13:18:13.314902+00	chjd4w5fxcfgf9euj74zcxwdtdo	1	checkbox	Assign tasks to teammates	{"value":false}	1672924693398	1672924693398	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
7g6w8mxth1tbi8grnmpkkiiwoah	2023-01-05 13:18:13.314902+00	chjd4w5fxcfgf9euj74zcxwdtdo	1	checkbox	Create and manage checklists, like this one... :)	{"value":false}	1672924693404	1672924693404	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
794wkegbnt7fxfps4zfpr9kq9na	2023-01-05 13:18:13.314902+00	chjd4w5fxcfgf9euj74zcxwdtdo	1	checkbox	Add and update descriptions with Markdown	{"value":false}	1672924693409	1672924693409	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
75pnrn1jdw7dbxj15ziuxkyz5oc	2023-01-05 13:18:13.314902+00	chjd4w5fxcfgf9euj74zcxwdtdo	1	checkbox	Follow cards to get notified on the latest updates	{"value":false}	1672924693415	1672924693415	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
7uzwzjayawbnpprzuhf8zecpo9c	2023-01-05 13:18:13.314902+00	chjd4w5fxcfgf9euj74zcxwdtdo	1	checkbox	Set priorities and update statuses	{"value":false}	1672924693421	1672924693421	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
7yis6kg4ofjgytb6x3uqto47amh	2023-01-05 13:18:13.314902+00	chjd4w5fxcfgf9euj74zcxwdtdo	1	checkbox	Provide feedback and ask questions via comments	{"value":false}	1672924693431	1672924693431	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
79arebkh1t3ge3gwwno8iz7gozo	2023-01-05 13:18:13.314902+00	chjd4w5fxcfgf9euj74zcxwdtdo	1	checkbox	@mention teammates so they can follow, and collaborate on, comments and descriptions	{"value":false}	1672924693459	1672924693459	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
7tzurgs5mwjd8pc3qka9ojeaxba	2023-01-05 13:18:13.314902+00	chjd4w5fxcfgf9euj74zcxwdtdo	1	checkbox	Manage deadlines and milestones	{"value":false}	1672924693464	1672924693464	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
a4zw8644qabgn9jod71d66ri8fo	2023-01-05 13:18:13.314902+00	chjd4w5fxcfgf9euj74zcxwdtdo	1	text	Cards allow your entire team to manage and collaborate on a task in one place. Within a card, your team can:	{}	1672924693469	1672924693469	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
7rfs4intj4tfp5fb3kc3hzmeper	2023-01-05 13:18:13.314902+00	crgryu1mz1ifw9bi9y8eypg639y	1	image		{"fileId":"74uia99m9btr8peydw7oexn37tw.gif"}	1672924693474	1672924693474	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
acnd936gtg7biue6iqrqm4g1tkw	2023-01-05 13:18:13.314902+00	crgryu1mz1ifw9bi9y8eypg639y	1	text	To create your own board, select the "+" on the top of the left hand sidebar. Choose from one of our standard templates and see how they can help you get started with your next project:\n\n- **Project Tasks**: Stay on top of your project tasks, track progress, and set priorities. \n- **Meeting Agenda**: Set your meeting agendas for recurring team meetings and 1:1s.\n- **Roadmap**: Plan your roadmap and manage your releases more efficiently.\n- **Personal Tasks**: Organize your life and track your personal tasks.\n- **Content Calendar**: Plan your editorial content, assign work, and track deadlines.\n- **Personal Goals**: Set and accomplish new personal goals and milestones.	{}	1672924693483	1672924693483	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
7q5t75g5mfbdhjyiqewgkng1zhr	2023-01-05 13:18:13.314902+00	c4j5mdjzu7ibgiqy9usqpysgkpw	1	image		{"fileId":"7knxbyuiedtdafcgmropgkrtybr.gif"}	1672924693489	1672924693489	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
aaiwtagtnaid7zcpfhqbwmwqhro	2023-01-05 13:18:13.314902+00	c4j5mdjzu7ibgiqy9usqpysgkpw	1	text	Keep stakeholders and customers up-to-date on project progress by sharing your board.	{}	1672924693493	1672924693493	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
azfuwnqnagiriz8exm3gq6bb8ce	2023-01-05 13:18:13.314902+00	c4j5mdjzu7ibgiqy9usqpysgkpw	1	text	To share a board, select **Share** at the top right of the Board view. Copy the link to share the board internally with your team or generate public link that can be accessed by anyone externally.	{}	1672924693498	1672924693498	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
7yja7ojo1w7fgub4i7ajiy8egey	2023-01-05 13:18:13.314902+00	cbx789k4b9pn9ibensfy1ntf3ra	1	image		{"fileId":"7iw4rxx7jj7bypmdotd9z469cyh.png"}	1672924693502	1672924693502	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
afm8hkgpk6pgc3q7fzt6mcp1rih	2023-01-05 13:18:13.314902+00	cbx789k4b9pn9ibensfy1ntf3ra	1	text	To create a new card, simply do any of the following:\n- Select "**New**" on the top right header\n- Select "**+ New**" below any column\n- Select "**+**" to the right of any columnn header	{}	1672924693507	1672924693507	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
atr485n34hjyufcsnteo39yzfgh	2023-01-05 13:18:13.314902+00	cbx789k4b9pn9ibensfy1ntf3ra	1	text	Mattermost Boards helps you manage and track all your project tasks with **Cards**.	{}	1672924693512	1672924693512	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
7ppwiwaxoyfnezyze3eb7tuoe1h	2023-01-05 13:18:13.314902+00	c68jnqiqjyb8rzpsssydoa35qoh	1	image		{"fileId":"7ek6wbpp19jfoujs1goh6kttbby.gif"}	1672924693517	1672924693517	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
agc6mebe5k7gmuc9cf7mfr3ei4r	2023-01-05 13:18:13.314902+00	c68jnqiqjyb8rzpsssydoa35qoh	1	text	Cards can be linked and shared with teammates directly on Channels. Card previews are displayed when shared on Channels, so your team can discuss work items and get the relevant context without having to switch over to Boards.	{}	1672924693531	1672924693531	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
7we8qh6cnk7njfqrtkhe9ref1do	2023-01-05 13:18:13.314902+00	ca6779z9sp3gkxnhttsi87cc3ee	1	image		{"fileId":"7dybb6t8fj3nrdft7nerhuf784y.png"}	1672924693537	1672924693537	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
afsuxsmhisig9b8oshw6ttthybc	2023-01-05 13:18:13.314902+00	ca6779z9sp3gkxnhttsi87cc3ee	1	text	Organize and find the cards you're looking for with our filter, sort, and grouping options. From the Board header, you can quickly toggle on different properties, change the group display, set filters, and change how the cards are sorted.	{}	1672924693543	1672924693543	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
78aetf7whm7b77bf4c6cwopru1o	2023-01-05 13:18:13.314902+00	cph49auqcnp89tkj8ewhn18fbdc	1	image		{"fileId":"78jws5m1myf8pufewzkaa6i11sc.gif"}	1672924693549	1672924693549	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
aes6itqd7bibg5bj3tfqsf5ub8e	2023-01-05 13:18:13.314902+00	cph49auqcnp89tkj8ewhn18fbdc	1	text	Views allow your team to visualize the same cards and data from different perspectives, so they can stay up-to-date in the way that works best for them. To add a new view, go to **Add a new view** from the view drop-down, then select from any of the following views:\n\n- **Board**: Adds a Kanban board, similar to this one, that allows your team to organize cards in swimlanes grouped by any property of your choosing. This view helps you visualize your project progress.\n- **Table**: Displays cards in a table format with rows and columns. Use this view to get an overview of all your project tasks. Easily view and compare the state of all properties across all cards without needing to open individual cards.\n- **Gallery**: Displays cards in a gallery format, so you can manage and organize cards with image attachments.\n- **Calendar**: Adds a calendar view to easily visualize your cards by dates and keep track of deadlines.	{}	1672924693556	1672924693556	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
7db1qh8up4jbxjpjh8jko3b574y	2023-01-05 13:18:13.314902+00	cknwsb8ydwfg9meo47cagtfejhh	1	image		{"fileId":"7d6hrtig3zt8f9cnbo1um5oxx3y.gif"}	1672924693561	1672924693561	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
ax55zfmg36irmujxdu7mmi8jciy	2023-01-05 13:18:13.314902+00	cknwsb8ydwfg9meo47cagtfejhh	1	text	Customize cards to fit your needs and track the information most important to you. Boards supports a wide range of fully customizable property types. For example, you can:\n- Use the **Date** property for things like deadlines or milestones.\n- Assign owners to tasks with the **Person** property.\n- Define statuses and priorities with the **Select** property.\n- Create tags with the **Multi Select** property.\n- Link cards to webpages with the **URL** property.	{}	1672924693566	1672924693566	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
7j89d11qegjr49x66uen1ic9w6a	2023-01-05 13:18:13.314902+00	cqh6oczxk6tn9tf836qtk7qwc4r	1	image		{"fileId":"74nt9eqzea3ydjjpgjtsxcjgrxc.gif"}	1672924693573	1672924693573	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
apsy1grew9pr7tkxi3fzyox4y9o	2023-01-05 13:18:13.314902+00	cqh6oczxk6tn9tf836qtk7qwc4r	1	text	To mention a teammate use the **@ symbol with their username** in the comments or description section. They'll get a Direct Message notification via Channels and also be added as a [follower](https://docs.mattermost.com/boards/work-with-cards.html#receive-updates) to the card. \n\nWhenever any changes are made to the card, they'll automatically get notified on Channels.	{}	1672924693579	1672924693579	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
\.


--
-- Data for Name: focalboard_blocks_history; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_blocks_history (id, insert_at, parent_id, schema, type, title, fields, create_at, update_at, delete_at, root_id, modified_by, channel_id, created_by, board_id) FROM stdin;
cbqcirmn8qbg37rbb1oi9wssn3c	2023-01-05 13:18:08.040999+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Team Schedule	{"contentOrder":["aq7bk8rb1gpguifcufifr9sgruh","7xk7a7oazuf8wuk3wp8z5xk6wpr","asyj88s75iibdfk6yq49j8dn7ye","7ax5mfu8y9j8b3ym448seti1x7h","7a4oq3xac47gqxm54broj4qtfmw","7rowytdjuqfrkt8ctpfybbon7ec"],"icon":"⏰","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"8b05c83e-a44a-4d04-831e-97f01d8e2003","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"34eb9c25-d5bf-49d9-859e-f74f4e0030e7"}}	1672924688065	1672924688065	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
c6c79y58wibgntkec89b5e7npza	2023-01-05 13:18:08.040999+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Video production	{"contentOrder":["afbdugcwt1fbe5k6e8ycjis3skc","7fngf88u5ujy9fn39jk1jq4x7fy","ahq8scq9dh38jjcasx9xh78smow","7in5wd35qpjfk8r4fb8hzwhy3sc","7nhzwpx41spbainnsjhdmxm7zaa","736oquxuqopnbtkzd85ko8b3xay"],"icon":"📹","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"b1abafbf-a038-4a19-8b68-56e0fd2319f7","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"34eb9c25-d5bf-49d9-859e-f74f4e0030e7"}}	1672924688076	1672924688076	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
cen6uu3mp3pyjzmypn4xj1btzaa	2023-01-05 13:18:08.040999+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Offsite plans	{"contentOrder":["anynwy9z4w3gd3xbgxtqc5ndgfr","73ax5mxqfkpr99ma3iafgxk85xy","ahdkdokimmtdbtcch6oco4k1thh","7ukkuj968pffubghr8794rph4mc","7kecouiecgj8j7d7dn5uyobqkfo","7ho5n6jipybg65mzz88fgpmdkno"],"icon":"🚙","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"8b05c83e-a44a-4d04-831e-97f01d8e2003","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"dabadd9b-adf1-4d9f-8702-805ac6cef602"}}	1672924688083	1672924688083	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
c9qfk7kfisjfyxyj4p71hpm3t4r	2023-01-05 13:18:08.040999+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Social Media Strategy	{"contentOrder":["a8xa66f4mw3b7jr86so5qfuqw5a","7ekd33wgtapynxbyoghrepd8muy","aw55eypd7ubd35dk4ifn9ptzdjy","74bnf8eq5rtf4pf9df4k7sppnia","7ybr96k6bwfy7xmkypzz49waxih","73ia6i59unjfr9nki7dpouy6ipc"],"icon":"🎉","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"b1abafbf-a038-4a19-8b68-56e0fd2319f7","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"d37a61f4-f332-4db9-8b2d-5e0a91aa20ed"}}	1672924688089	1672924688089	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
vgd65knqp1tr5tpo48zdciey4sy	2023-01-05 13:18:08.040999+00	b7wnw9awd4pnefryhq51apbzb4c	1	view	Discussion Items	{"cardOrder":["cjpkiya33qsagr4f9hrdwhgiajc"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"d777ba3b-8728-40d1-87a6-59406bbbbfb0","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[{"propertyId":"4cf1568d-530f-4028-8ffd-bdc65249187e","reversed":false}],"viewType":"board","visibleOptionIds":[],"visiblePropertyIds":["4cf1568d-530f-4028-8ffd-bdc65249187e"]}	1672924688096	1672924688096	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
7a4oq3xac47gqxm54broj4qtfmw	2023-01-05 13:18:08.040999+00	cbqcirmn8qbg37rbb1oi9wssn3c	1	checkbox		{"value":false}	1672924688101	1672924688101	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
7ax5mfu8y9j8b3ym448seti1x7h	2023-01-05 13:18:08.040999+00	cbqcirmn8qbg37rbb1oi9wssn3c	1	checkbox		{"value":false}	1672924688108	1672924688108	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
7xk7a7oazuf8wuk3wp8z5xk6wpr	2023-01-05 13:18:08.040999+00	cbqcirmn8qbg37rbb1oi9wssn3c	1	divider		{}	1672924688110	1672924688110	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
7rowytdjuqfrkt8ctpfybbon7ec	2023-01-05 13:18:08.040999+00	cbqcirmn8qbg37rbb1oi9wssn3c	1	checkbox		{"value":false}	1672924688117	1672924688117	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
aq7bk8rb1gpguifcufifr9sgruh	2023-01-05 13:18:08.040999+00	cbqcirmn8qbg37rbb1oi9wssn3c	1	text	## Notes\n*[Add meeting notes here]*	{}	1672924688122	1672924688122	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
asyj88s75iibdfk6yq49j8dn7ye	2023-01-05 13:18:08.040999+00	cbqcirmn8qbg37rbb1oi9wssn3c	1	text	## Action Items	{}	1672924688127	1672924688127	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
7b1741iwyx7bh3kb6eyam9p3hhe	2023-01-05 13:18:08.040999+00	ch798q5ucefyobf5bymgqjt4f3h	1	divider		{}	1672924688133	1672924688133	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
76h4zaks4gtytfmxss7199a1wao	2023-01-05 13:18:08.040999+00	ch798q5ucefyobf5bymgqjt4f3h	1	checkbox		{"value":false}	1672924688137	1672924688137	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
73xiqkhgzepgo9xe8ac5yhn6opo	2023-01-05 13:18:08.040999+00	ch798q5ucefyobf5bymgqjt4f3h	1	checkbox		{"value":false}	1672924688143	1672924688143	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
7yhwf8r9zo3rkjbzt8ox3h8taqw	2023-01-05 13:18:08.040999+00	ch798q5ucefyobf5bymgqjt4f3h	1	checkbox		{"value":false}	1672924688149	1672924688149	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
a11s7aquzo3guxkkfzce4aif5hh	2023-01-05 13:18:08.040999+00	ch798q5ucefyobf5bymgqjt4f3h	1	text	# Action Items	{}	1672924688155	1672924688155	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
acahxzqs89f8r3n45jzhhnjhyao	2023-01-05 13:18:08.040999+00	ch798q5ucefyobf5bymgqjt4f3h	1	text	# Notes\n*[Add meeting notes here]*	{}	1672924688161	1672924688161	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
7fngf88u5ujy9fn39jk1jq4x7fy	2023-01-05 13:18:08.040999+00	c6c79y58wibgntkec89b5e7npza	1	divider		{}	1672924688168	1672924688168	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
736oquxuqopnbtkzd85ko8b3xay	2023-01-05 13:18:08.040999+00	c6c79y58wibgntkec89b5e7npza	1	checkbox		{"value":false}	1672924688174	1672924688174	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
7nhzwpx41spbainnsjhdmxm7zaa	2023-01-05 13:18:08.040999+00	c6c79y58wibgntkec89b5e7npza	1	checkbox		{"value":false}	1672924688182	1672924688182	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
7in5wd35qpjfk8r4fb8hzwhy3sc	2023-01-05 13:18:08.040999+00	c6c79y58wibgntkec89b5e7npza	1	checkbox		{"value":false}	1672924688188	1672924688188	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
ahq8scq9dh38jjcasx9xh78smow	2023-01-05 13:18:08.040999+00	c6c79y58wibgntkec89b5e7npza	1	text	## Action Items	{}	1672924688193	1672924688193	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
afbdugcwt1fbe5k6e8ycjis3skc	2023-01-05 13:18:08.040999+00	c6c79y58wibgntkec89b5e7npza	1	text	## Notes\n*[Add meeting notes here]*	{}	1672924688199	1672924688199	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
7ukkuj968pffubghr8794rph4mc	2023-01-05 13:18:08.040999+00	cen6uu3mp3pyjzmypn4xj1btzaa	1	checkbox		{"value":false}	1672924688204	1672924688204	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
7kecouiecgj8j7d7dn5uyobqkfo	2023-01-05 13:18:08.040999+00	cen6uu3mp3pyjzmypn4xj1btzaa	1	checkbox		{"value":false}	1672924688208	1672924688208	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
73ax5mxqfkpr99ma3iafgxk85xy	2023-01-05 13:18:08.040999+00	cen6uu3mp3pyjzmypn4xj1btzaa	1	divider		{}	1672924688214	1672924688214	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
7ho5n6jipybg65mzz88fgpmdkno	2023-01-05 13:18:08.040999+00	cen6uu3mp3pyjzmypn4xj1btzaa	1	checkbox		{"value":false}	1672924688219	1672924688219	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
ahdkdokimmtdbtcch6oco4k1thh	2023-01-05 13:18:08.040999+00	cen6uu3mp3pyjzmypn4xj1btzaa	1	text	## Action Items	{}	1672924688224	1672924688224	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
anynwy9z4w3gd3xbgxtqc5ndgfr	2023-01-05 13:18:08.040999+00	cen6uu3mp3pyjzmypn4xj1btzaa	1	text	## Notes\n*[Add meeting notes here]*	{}	1672924688239	1672924688239	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
7ekd33wgtapynxbyoghrepd8muy	2023-01-05 13:18:08.040999+00	c9qfk7kfisjfyxyj4p71hpm3t4r	1	divider		{}	1672924688254	1672924688254	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
7ybr96k6bwfy7xmkypzz49waxih	2023-01-05 13:18:08.040999+00	c9qfk7kfisjfyxyj4p71hpm3t4r	1	checkbox		{"value":false}	1672924688268	1672924688268	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
73ia6i59unjfr9nki7dpouy6ipc	2023-01-05 13:18:08.040999+00	c9qfk7kfisjfyxyj4p71hpm3t4r	1	checkbox		{"value":false}	1672924688298	1672924688298	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
74bnf8eq5rtf4pf9df4k7sppnia	2023-01-05 13:18:08.040999+00	c9qfk7kfisjfyxyj4p71hpm3t4r	1	checkbox		{"value":false}	1672924688313	1672924688313	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
aw55eypd7ubd35dk4ifn9ptzdjy	2023-01-05 13:18:08.040999+00	c9qfk7kfisjfyxyj4p71hpm3t4r	1	text	## Action Items	{}	1672924688325	1672924688325	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
a8xa66f4mw3b7jr86so5qfuqw5a	2023-01-05 13:18:08.040999+00	c9qfk7kfisjfyxyj4p71hpm3t4r	1	text	## Notes\n*[Add meeting notes here]*	{}	1672924688328	1672924688328	0	\N	system		system	bmpxqmbwz3jgmfr4wdb3zq3upxo
v3aq4mpy5hfbg9etg756hk7rntw	2023-01-05 13:18:08.726993+00		1	view	All Contacts	{"cardOrder":["ckim1iz9ni78p8dnf3cmn8td16a","ctawerdpkn78od8muh9szjke3yw","cyra1n9ydbbfpm8dcjjpk7ymyrr","c95j3yj5xoiyrmy3onnk57aaido","c59eubrnukjytb8zik1auzyu41a"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":240,"a1438fbbhjeffkexmcfhnx99o1h":151,"a5hwxjsmkn6bak6r7uea5bx1kwc":132,"abru6tz8uebdxy4skheqidh7zxy":247,"adtf1151chornmihz4xbgbk9exa":125,"aejo5tcmq54bauuueem9wc4fw4y":127,"ahf43e44h3y8ftanqgzno9z7q7w":129,"ainpw47babwkpyj77ic4b9zq9xr":157,"amahgyn9n4twaapg3jyxb6y4jic":224,"amba7ot98fh7hwsx8jdcfst5g7h":171,"aoheuj1f3mu6eehygr45fxa144y":130,"auhf91pm85f73swwidi4wid8jqe":157},"defaultTemplateId":"cw8g9n58zwbri8pxtsx7wgny7uw","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a5hwxjsmkn6bak6r7uea5bx1kwc","aoheuj1f3mu6eehygr45fxa144y","aro91wme9kfaie5ceu9qasmtcnw","ainpw47babwkpyj77ic4b9zq9xr","ahf43e44h3y8ftanqgzno9z7q7w","amahgyn9n4twaapg3jyxb6y4jic","abru6tz8uebdxy4skheqidh7zxy","a1438fbbhjeffkexmcfhnx99o1h","auhf91pm85f73swwidi4wid8jqe","adtf1151chornmihz4xbgbk9exa","aejo5tcmq54bauuueem9wc4fw4y","amba7ot98fh7hwsx8jdcfst5g7h"]}	1672924688735	1672924688735	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
vwaon9gp7tfrsfydsecfitchjuw	2023-01-05 13:18:08.726993+00		1	view	Pipeline Tracker	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["akj61wc9yxdwyw3t6m8igyf9d5o","aic89a5xox4wbppi6mbyx6ujsda","ah6ehh43rwj88jy4awensin8pcw","aprhd96zwi34o9cs4xyr3o9sf3c","axesd74yuxtbmw1sbk8ufax7z3a","a5txuiubumsmrs8gsd5jz5gc1oa","acm9q494bcthyoqzmfogxxy5czy"],"visiblePropertyIds":["aro91wme9kfaie5ceu9qasmtcnw","amahgyn9n4twaapg3jyxb6y4jic"]}	1672924688739	1672924688739	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
c95j3yj5xoiyrmy3onnk57aaido	2023-01-05 13:18:08.726993+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Jonathan Frazier	{"contentOrder":["a1thgrfqf97f9uqaux3gigxf8kh","ae3wbxp9msbfm7yg43kx47o6say","7d648jwamtfn1zprgcdwxa9fa7w","71niq5m16npdptepwdkbrsaj5ua","7ccjhsxjft7fu7yd7ehw4bwrdjr","73guwp5f197be9gra6gwibgtfca","7tr1qzcab7pfg3xh3e4eydpzs3r","7j87tdfaeab8m5fr7i3ne4tie8a","7g6ni9ass4jfz3jx94pkx9hhw6c","79733nepdxt8s3nyyfdsqaw763w","7auyu7r16kjdfppgqxffrtascoo","7zy4rbp6z1bfm7cq6mehw3udu5w"],"icon":"🙎‍♂️","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(999) 123-5678","a5hwxjsmkn6bak6r7uea5bx1kwc":"a5txuiubumsmrs8gsd5jz5gc1oa","abru6tz8uebdxy4skheqidh7zxy":"jonathan.frazier@email.com","aejo5tcmq54bauuueem9wc4fw4y":"0%","ahf43e44h3y8ftanqgzno9z7q7w":"$800,000","ainpw47babwkpyj77ic4b9zq9xr":"Ositions Inc.","amahgyn9n4twaapg3jyxb6y4jic":"as5bk6afoaaa7caewe1zc391sce","aro91wme9kfaie5ceu9qasmtcnw":"apiswzj7uiwbh87z8dw8c6mturw","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1669118400000}"}}	1672924688742	1672924688742	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
cyra1n9ydbbfpm8dcjjpk7ymyrr	2023-01-05 13:18:08.726993+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Richard Guzman	{"contentOrder":["ao3yjboejpp8ctrnwhhd1p7k9gr","arnctww5wqfrnjmz41dn66k8y4h","71nxk1f67oir1dbzfzpho1eq57h","7pft8zmrcxfrjdem7yjzss75t6h","77jco8uqrsprjifahnfxzsy6oqa","7qnf39zsarpf6px9ynkwkd6afcy","7rp6xxiprz7n1jphruncff89poc","71stmm4z957fzucbmu8ofmjnupr","7w8ajh5wcp3bmirw3x7631sprur","7ia43dczwcigq78u43utqx1rdbr","7ht8fk4zq13fpmpmufhenz3o45c","78d14xwe877f79fi8rn1efizunw"],"icon":"👨‍💼","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(222) 123-1234","a5hwxjsmkn6bak6r7uea5bx1kwc":"axesd74yuxtbmw1sbk8ufax7z3a","abru6tz8uebdxy4skheqidh7zxy":"richard.guzman@email.com","adtf1151chornmihz4xbgbk9exa":"{\\"from\\":1681992000000}","aejo5tcmq54bauuueem9wc4fw4y":"80%","ahf43e44h3y8ftanqgzno9z7q7w":"$3,200,000","ainpw47babwkpyj77ic4b9zq9xr":"Afformance Ltd.","amahgyn9n4twaapg3jyxb6y4jic":"ar6t1ttcumgfuqugg5o4g4mzrza","aro91wme9kfaie5ceu9qasmtcnw":"apjnaggwixchfxwiatfh7ey7uno","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1667476800000}"}}	1672924688745	1672924688745	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
c59eubrnukjytb8zik1auzyu41a	2023-01-05 13:18:08.726993+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Byron Cole	{"contentOrder":["anixf3fgofjyc9rjwoy9mp4ybco","aaiqjc55eqbgtinmmsq9ks83huy","7p6dfjronm7fijnaipbdabxnwdr","7sfpuuujb8byiid9znf4msq6gwc","73cpzmh8kd7dw9qkmafnm5te3ta","7xrjsgf4t4jryu8qnnnmc6qsqhe","7ido7ki339fbc7ndrdsq5i1wrty","7taz7tg8dbbdj9qibcdbkrf38zh","75hr3rf3bstrqdxt3pxeka3q13o","7p1111nx84tnpinzxdw7x4jw4po","749purgzp5fd7xnjigngs9ojiry","7jexqrhodftystde85pqir91npw"],"icon":"🤵","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(333) 123-1234","a5hwxjsmkn6bak6r7uea5bx1kwc":"acm9q494bcthyoqzmfogxxy5czy","abru6tz8uebdxy4skheqidh7zxy":"byron.cole@email.com","adtf1151chornmihz4xbgbk9exa":"{\\"from\\":1667563200000}","aejo5tcmq54bauuueem9wc4fw4y":"100%","ahf43e44h3y8ftanqgzno9z7q7w":"$500,000","ainpw47babwkpyj77ic4b9zq9xr":"Helx Industries","amahgyn9n4twaapg3jyxb6y4jic":"aafwyza5iwdcwcyfyj6bp7emufw","aro91wme9kfaie5ceu9qasmtcnw":"apjnaggwixchfxwiatfh7ey7uno","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1667822400000}"}}	1672924688750	1672924688750	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7ht8fk4zq13fpmpmufhenz3o45c	2023-01-05 13:18:08.726993+00	cyra1n9ydbbfpm8dcjjpk7ymyrr	1	checkbox	Hand-off to customer success	{}	1672924688855	1672924688855	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7ia43dczwcigq78u43utqx1rdbr	2023-01-05 13:18:08.726993+00	cyra1n9ydbbfpm8dcjjpk7ymyrr	1	checkbox	Finalize contract	{}	1672924688866	1672924688866	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
78d14xwe877f79fi8rn1efizunw	2023-01-05 13:18:08.726993+00	cyra1n9ydbbfpm8dcjjpk7ymyrr	1	checkbox	Post-sales follow up	{}	1672924688876	1672924688876	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
ctawerdpkn78od8muh9szjke3yw	2023-01-05 13:18:08.726993+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Caitlyn Russel	{"contentOrder":["ac5e3358d9tnnfmmtb8wtscdbie","a6shdw6mastdzdfpcf34twpcq9r","7tsqz4e5rpjrfpnfoy6irfc9cco","7h8ozcg9wkino9do1qece83t66o","7h4augwa4mfyydji34ebgszrrbc","77y9fnhu667fdtgrdf9pek887xo","7p4raiw7fo7r1injenypggxbg7w","716mzzxsqrbyb9f1ekybnz3nqjo","7b6ye18kuu3fw9rnndn5eoekjrc","79w9fmkscj3y79pmwourkt5b4ro","7k7hok4xi9tfizr1umk1pd7ieno","7yhc86iw3hpye5xgixqe9zubwey"],"icon":"🧑‍💼","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(111) 123-1234","a5hwxjsmkn6bak6r7uea5bx1kwc":"ah6ehh43rwj88jy4awensin8pcw","abru6tz8uebdxy4skheqidh7zxy":"caitlyn.russel@email.com","adtf1151chornmihz4xbgbk9exa":"{\\"from\\":1689336000000}","aejo5tcmq54bauuueem9wc4fw4y":"20%","ahf43e44h3y8ftanqgzno9z7q7w":"$250,000","ainpw47babwkpyj77ic4b9zq9xr":"Liminary Corp.","amahgyn9n4twaapg3jyxb6y4jic":"aafwyza5iwdcwcyfyj6bp7emufw","aro91wme9kfaie5ceu9qasmtcnw":"apiswzj7uiwbh87z8dw8c6mturw","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1668168000000}"}}	1672924688753	1672924688753	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
cw8g9n58zwbri8pxtsx7wgny7uw	2023-01-05 13:18:08.726993+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	New Prospect	{"contentOrder":["aqqdyed4m3bge9ksh8hac1t4a3r","akticbfzqqjrx9fyxjqy476fboo","7t4j64do36jrtmgkj37k7ygohqa","7316jzfyex3buieeg61p3uanu8w","7u396wm7kc3r63kxp3gqreqopwa","7w3jxjnm1qpf1dfycxch4h5qqhw","7ya4xtzikgtf4mma7ib34tmu94h","7hn1c3mgyr7de7po3tmccguokfe","77uzu5w7rxp8hdk4dz6bpw5g8ph","7thmioo3xn38ztfi69sohbq9yea","7ghyopfdwkbyy8xtetzrux1a3ay","78twi939pd7fcxgp6buspj4imar"],"icon":"👤","isTemplate":true,"properties":{"a5hwxjsmkn6bak6r7uea5bx1kwc":"akj61wc9yxdwyw3t6m8igyf9d5o"}}	1672924688758	1672924688758	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
ckim1iz9ni78p8dnf3cmn8td16a	2023-01-05 13:18:08.726993+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Shelby Olson	{"contentOrder":["a33h531muhjdjddtg6xtq8tis8y","aapqd3aoswbyxfnbpcipinpt31h","7rkdt3izojtf6m8ek7436h3s5by","7xgcriqsp9by59y1cygejbn7wme","745hidcaqatn4ff7oj5qibkp9fr","78m6x9c6gufdr5q47rpgazbobjy","7ahicq1xmmfftfqddmjwgyfrzbr","7fn47owkpzifb7gmhrmqz8otyto","7z5agzxkddbrmzj5ui9e79iaite","74mccbbbrbjr53g4bztt7eaozmw","7dwz15ofwdpyk3fkqfh7ps9nk9a","7frgsmw9xe7nr3jxp8xu7am44zy"],"icon":"🙎‍♀️","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(111) 321-5678","a5hwxjsmkn6bak6r7uea5bx1kwc":"akj61wc9yxdwyw3t6m8igyf9d5o","abru6tz8uebdxy4skheqidh7zxy":"shelby.olson@email.com","ahf43e44h3y8ftanqgzno9z7q7w":"$30,000","ainpw47babwkpyj77ic4b9zq9xr":"Kadera Global","amahgyn9n4twaapg3jyxb6y4jic":"ar6t1ttcumgfuqugg5o4g4mzrza","aro91wme9kfaie5ceu9qasmtcnw":"auu9bfzqeuruyjwzzqgz7q8apuw","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1669291200000}"}}	1672924688762	1672924688762	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
vbgmgd1bb3fd7ukmhtukmzd915y	2023-01-05 13:18:08.726993+00	bzwb99zf498tsm7mjqbiy7g81ze	1	view	Open Deals	{"cardOrder":["ctawerdpkn78od8muh9szjke3yw"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[{"condition":"includes","propertyId":"a5hwxjsmkn6bak6r7uea5bx1kwc","values":["akj61wc9yxdwyw3t6m8igyf9d5o","aic89a5xox4wbppi6mbyx6ujsda","ah6ehh43rwj88jy4awensin8pcw","aprhd96zwi34o9cs4xyr3o9sf3c","axesd74yuxtbmw1sbk8ufax7z3a"]}],"operation":"and"},"groupById":"aro91wme9kfaie5ceu9qasmtcnw","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["apjnaggwixchfxwiatfh7ey7uno","apiswzj7uiwbh87z8dw8c6mturw","auu9bfzqeuruyjwzzqgz7q8apuw",""],"visiblePropertyIds":[]}	1672924688766	1672924688766	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7d648jwamtfn1zprgcdwxa9fa7w	2023-01-05 13:18:08.726993+00	c95j3yj5xoiyrmy3onnk57aaido	1	checkbox	Send initial email	{"value":true}	1672924688770	1672924688770	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
71niq5m16npdptepwdkbrsaj5ua	2023-01-05 13:18:08.726993+00	c95j3yj5xoiyrmy3onnk57aaido	1	checkbox	Send follow-up email	{"value":true}	1672924688774	1672924688774	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7g6ni9ass4jfz3jx94pkx9hhw6c	2023-01-05 13:18:08.726993+00	c95j3yj5xoiyrmy3onnk57aaido	1	checkbox	Send proposal	{"value":true}	1672924688777	1672924688777	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
79733nepdxt8s3nyyfdsqaw763w	2023-01-05 13:18:08.726993+00	c95j3yj5xoiyrmy3onnk57aaido	1	checkbox	Finalize contract	{}	1672924688782	1672924688782	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7ccjhsxjft7fu7yd7ehw4bwrdjr	2023-01-05 13:18:08.726993+00	c95j3yj5xoiyrmy3onnk57aaido	1	checkbox	Schedule initial sales call	{"value":true}	1672924688787	1672924688787	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7tr1qzcab7pfg3xh3e4eydpzs3r	2023-01-05 13:18:08.726993+00	c95j3yj5xoiyrmy3onnk57aaido	1	checkbox	Schedule demo	{"value":true}	1672924688792	1672924688792	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7auyu7r16kjdfppgqxffrtascoo	2023-01-05 13:18:08.726993+00	c95j3yj5xoiyrmy3onnk57aaido	1	checkbox	Hand-off to customer success	{}	1672924688798	1672924688798	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7j87tdfaeab8m5fr7i3ne4tie8a	2023-01-05 13:18:08.726993+00	c95j3yj5xoiyrmy3onnk57aaido	1	checkbox	Follow up after demo	{"value":true}	1672924688805	1672924688805	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
73guwp5f197be9gra6gwibgtfca	2023-01-05 13:18:08.726993+00	c95j3yj5xoiyrmy3onnk57aaido	1	checkbox	Schedule follow-up sales call	{"value":true}	1672924688811	1672924688811	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7zy4rbp6z1bfm7cq6mehw3udu5w	2023-01-05 13:18:08.726993+00	c95j3yj5xoiyrmy3onnk57aaido	1	checkbox	Post-sales follow up	{}	1672924688819	1672924688819	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
ae3wbxp9msbfm7yg43kx47o6say	2023-01-05 13:18:08.726993+00	c95j3yj5xoiyrmy3onnk57aaido	1	text	## Checklist	{}	1672924688825	1672924688825	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
a1thgrfqf97f9uqaux3gigxf8kh	2023-01-05 13:18:08.726993+00	c95j3yj5xoiyrmy3onnk57aaido	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1672924688831	1672924688831	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
71nxk1f67oir1dbzfzpho1eq57h	2023-01-05 13:18:08.726993+00	cyra1n9ydbbfpm8dcjjpk7ymyrr	1	checkbox	Send initial email	{"value":true}	1672924688836	1672924688836	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7qnf39zsarpf6px9ynkwkd6afcy	2023-01-05 13:18:08.726993+00	cyra1n9ydbbfpm8dcjjpk7ymyrr	1	checkbox	Schedule follow-up sales call	{"value":true}	1672924688840	1672924688840	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
71stmm4z957fzucbmu8ofmjnupr	2023-01-05 13:18:08.726993+00	cyra1n9ydbbfpm8dcjjpk7ymyrr	1	checkbox	Follow up after demo	{"value":true}	1672924688844	1672924688844	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7w8ajh5wcp3bmirw3x7631sprur	2023-01-05 13:18:08.726993+00	cyra1n9ydbbfpm8dcjjpk7ymyrr	1	checkbox	Send proposal	{"value":true}	1672924688851	1672924688850	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7rp6xxiprz7n1jphruncff89poc	2023-01-05 13:18:08.726993+00	cyra1n9ydbbfpm8dcjjpk7ymyrr	1	checkbox	Schedule demo	{"value":true}	1672924688882	1672924688882	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
77jco8uqrsprjifahnfxzsy6oqa	2023-01-05 13:18:08.726993+00	cyra1n9ydbbfpm8dcjjpk7ymyrr	1	checkbox	Schedule initial sales call	{"value":true}	1672924688888	1672924688888	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7pft8zmrcxfrjdem7yjzss75t6h	2023-01-05 13:18:08.726993+00	cyra1n9ydbbfpm8dcjjpk7ymyrr	1	checkbox	Send follow-up email	{"value":true}	1672924688894	1672924688894	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
ao3yjboejpp8ctrnwhhd1p7k9gr	2023-01-05 13:18:08.726993+00	cyra1n9ydbbfpm8dcjjpk7ymyrr	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1672924688900	1672924688900	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
arnctww5wqfrnjmz41dn66k8y4h	2023-01-05 13:18:08.726993+00	cyra1n9ydbbfpm8dcjjpk7ymyrr	1	text	## Checklist	{}	1672924688906	1672924688906	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7taz7tg8dbbdj9qibcdbkrf38zh	2023-01-05 13:18:08.726993+00	c59eubrnukjytb8zik1auzyu41a	1	checkbox	Follow up after demo	{"value":true}	1672924688912	1672924688912	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7p6dfjronm7fijnaipbdabxnwdr	2023-01-05 13:18:08.726993+00	c59eubrnukjytb8zik1auzyu41a	1	checkbox	Send initial email	{"value":true}	1672924688918	1672924688918	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7sfpuuujb8byiid9znf4msq6gwc	2023-01-05 13:18:08.726993+00	c59eubrnukjytb8zik1auzyu41a	1	checkbox	Send follow-up email	{"value":true}	1672924688925	1672924688925	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
75hr3rf3bstrqdxt3pxeka3q13o	2023-01-05 13:18:08.726993+00	c59eubrnukjytb8zik1auzyu41a	1	checkbox	Send proposal	{"value":true}	1672924688930	1672924688929	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7p1111nx84tnpinzxdw7x4jw4po	2023-01-05 13:18:08.726993+00	c59eubrnukjytb8zik1auzyu41a	1	checkbox	Finalize contract	{"value":true}	1672924688935	1672924688935	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7xrjsgf4t4jryu8qnnnmc6qsqhe	2023-01-05 13:18:08.726993+00	c59eubrnukjytb8zik1auzyu41a	1	checkbox	Schedule follow-up sales call	{"value":true}	1672924688940	1672924688940	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
73cpzmh8kd7dw9qkmafnm5te3ta	2023-01-05 13:18:08.726993+00	c59eubrnukjytb8zik1auzyu41a	1	checkbox	Schedule initial sales call	{"value":true}	1672924688945	1672924688945	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7ido7ki339fbc7ndrdsq5i1wrty	2023-01-05 13:18:08.726993+00	c59eubrnukjytb8zik1auzyu41a	1	checkbox	Schedule demo	{"value":true}	1672924688952	1672924688952	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
749purgzp5fd7xnjigngs9ojiry	2023-01-05 13:18:08.726993+00	c59eubrnukjytb8zik1auzyu41a	1	checkbox	Hand-off to customer success	{"value":true}	1672924688957	1672924688957	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7jexqrhodftystde85pqir91npw	2023-01-05 13:18:08.726993+00	c59eubrnukjytb8zik1auzyu41a	1	checkbox	Post-sales follow up	{"value":true}	1672924688962	1672924688962	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
aaiqjc55eqbgtinmmsq9ks83huy	2023-01-05 13:18:08.726993+00	c59eubrnukjytb8zik1auzyu41a	1	text	## Checklist	{}	1672924688967	1672924688967	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
anixf3fgofjyc9rjwoy9mp4ybco	2023-01-05 13:18:08.726993+00	c59eubrnukjytb8zik1auzyu41a	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1672924688972	1672924688972	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7yhc86iw3hpye5xgixqe9zubwey	2023-01-05 13:18:08.726993+00	ctawerdpkn78od8muh9szjke3yw	1	checkbox	Post-sales follow up	{}	1672924688976	1672924688976	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7b6ye18kuu3fw9rnndn5eoekjrc	2023-01-05 13:18:08.726993+00	ctawerdpkn78od8muh9szjke3yw	1	checkbox	Send proposal	{}	1672924688980	1672924688980	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7k7hok4xi9tfizr1umk1pd7ieno	2023-01-05 13:18:08.726993+00	ctawerdpkn78od8muh9szjke3yw	1	checkbox	Hand-off to customer success	{}	1672924688985	1672924688985	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
716mzzxsqrbyb9f1ekybnz3nqjo	2023-01-05 13:18:08.726993+00	ctawerdpkn78od8muh9szjke3yw	1	checkbox	Follow up after demo	{}	1672924688988	1672924688988	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7p4raiw7fo7r1injenypggxbg7w	2023-01-05 13:18:08.726993+00	ctawerdpkn78od8muh9szjke3yw	1	checkbox	Schedule demo	{"value":true}	1672924688993	1672924688993	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7tsqz4e5rpjrfpnfoy6irfc9cco	2023-01-05 13:18:08.726993+00	ctawerdpkn78od8muh9szjke3yw	1	checkbox	Send initial email	{"value":true}	1672924688996	1672924688996	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
77y9fnhu667fdtgrdf9pek887xo	2023-01-05 13:18:08.726993+00	ctawerdpkn78od8muh9szjke3yw	1	checkbox	Schedule follow-up sales call	{"value":true}	1672924689001	1672924689001	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7h8ozcg9wkino9do1qece83t66o	2023-01-05 13:18:08.726993+00	ctawerdpkn78od8muh9szjke3yw	1	checkbox	Send follow-up email	{"value":true}	1672924689005	1672924689005	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7h4augwa4mfyydji34ebgszrrbc	2023-01-05 13:18:08.726993+00	ctawerdpkn78od8muh9szjke3yw	1	checkbox	Schedule initial sales call	{"value":true}	1672924689009	1672924689009	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
79w9fmkscj3y79pmwourkt5b4ro	2023-01-05 13:18:08.726993+00	ctawerdpkn78od8muh9szjke3yw	1	checkbox	Finalize contract	{}	1672924689014	1672924689014	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
a6shdw6mastdzdfpcf34twpcq9r	2023-01-05 13:18:08.726993+00	ctawerdpkn78od8muh9szjke3yw	1	text	## Checklist	{}	1672924689017	1672924689017	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
ac5e3358d9tnnfmmtb8wtscdbie	2023-01-05 13:18:08.726993+00	ctawerdpkn78od8muh9szjke3yw	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1672924689022	1672924689022	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7t4j64do36jrtmgkj37k7ygohqa	2023-01-05 13:18:08.726993+00	cw8g9n58zwbri8pxtsx7wgny7uw	1	checkbox	Send initial email	{"value":false}	1672924689025	1672924689025	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7u396wm7kc3r63kxp3gqreqopwa	2023-01-05 13:18:08.726993+00	cw8g9n58zwbri8pxtsx7wgny7uw	1	checkbox	Schedule initial sales call	{"value":false}	1672924689030	1672924689030	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7w3jxjnm1qpf1dfycxch4h5qqhw	2023-01-05 13:18:08.726993+00	cw8g9n58zwbri8pxtsx7wgny7uw	1	checkbox	Schedule follow-up sales call	{"value":false}	1672924689039	1672924689039	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
77uzu5w7rxp8hdk4dz6bpw5g8ph	2023-01-05 13:18:08.726993+00	cw8g9n58zwbri8pxtsx7wgny7uw	1	checkbox	Send proposal	{}	1672924689047	1672924689047	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7thmioo3xn38ztfi69sohbq9yea	2023-01-05 13:18:08.726993+00	cw8g9n58zwbri8pxtsx7wgny7uw	1	checkbox	Finalize contract	{}	1672924689058	1672924689058	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
78twi939pd7fcxgp6buspj4imar	2023-01-05 13:18:08.726993+00	cw8g9n58zwbri8pxtsx7wgny7uw	1	checkbox	Post-sales follow up	{}	1672924689063	1672924689063	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7316jzfyex3buieeg61p3uanu8w	2023-01-05 13:18:08.726993+00	cw8g9n58zwbri8pxtsx7wgny7uw	1	checkbox	Send follow-up email	{"value":false}	1672924689070	1672924689070	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7ya4xtzikgtf4mma7ib34tmu94h	2023-01-05 13:18:08.726993+00	cw8g9n58zwbri8pxtsx7wgny7uw	1	checkbox	Schedule demo	{"value":false}	1672924689075	1672924689075	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7ghyopfdwkbyy8xtetzrux1a3ay	2023-01-05 13:18:08.726993+00	cw8g9n58zwbri8pxtsx7wgny7uw	1	checkbox	Hand-off to customer success	{}	1672924689082	1672924689082	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7hn1c3mgyr7de7po3tmccguokfe	2023-01-05 13:18:08.726993+00	cw8g9n58zwbri8pxtsx7wgny7uw	1	checkbox	Follow up after demo	{}	1672924689093	1672924689093	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
aqqdyed4m3bge9ksh8hac1t4a3r	2023-01-05 13:18:08.726993+00	cw8g9n58zwbri8pxtsx7wgny7uw	1	text	## Notes\n[Enter notes here...]	{}	1672924689098	1672924689098	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
akticbfzqqjrx9fyxjqy476fboo	2023-01-05 13:18:08.726993+00	cw8g9n58zwbri8pxtsx7wgny7uw	1	text	## Checklist	{}	1672924689108	1672924689108	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7h88e9ci5sfgh5bz95oji5f3oew	2023-01-05 13:18:08.726993+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Hand-off to customer success	{}	1672924689113	1672924689113	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7sxgxamu7ojncjywsf3sb7akm5w	2023-01-05 13:18:08.726993+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Send initial email	{"value":false}	1672924689120	1672924689120	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
774fz9eeux3y3pmq6ajt3qrzcdr	2023-01-05 13:18:08.726993+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Post-sales follow up	{}	1672924689125	1672924689125	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7mqgzqx8gn7bqbr6e39upgys8ea	2023-01-05 13:18:08.726993+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Finalize contract	{}	1672924689132	1672924689131	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7edkymjh1e3bebeee5bumu8cadc	2023-01-05 13:18:08.726993+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Send follow-up email	{"value":false}	1672924689137	1672924689137	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
76b11zoutn38mpx3mcqjknrrqza	2023-01-05 13:18:08.726993+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Schedule follow-up sales call	{"value":false}	1672924689143	1672924689143	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7uw6xzgag9381m8b9oym8t1trry	2023-01-05 13:18:08.726993+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Send proposal	{}	1672924689150	1672924689150	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7j8y8nz7o97bsxx6oyhspt4n7uo	2023-01-05 13:18:08.726993+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Follow up after demo	{}	1672924689153	1672924689153	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7ph3fac5qhbrm7ygs5sx4jxci3a	2023-01-05 13:18:08.726993+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Schedule initial sales call	{"value":false}	1672924689158	1672924689158	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7tazkextky3db3k7fejzta8hbmw	2023-01-05 13:18:08.726993+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Schedule demo	{"value":false}	1672924689163	1672924689163	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
arpgzkjj6ojf17p1uduxf5ichdr	2023-01-05 13:18:08.726993+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	text	## Checklist	{}	1672924689169	1672924689169	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
aqrny3wobwi8sbgsrbs3rpro1cr	2023-01-05 13:18:08.726993+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	text	## Notes\n[Enter notes here...]	{}	1672924689173	1672924689173	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7z5agzxkddbrmzj5ui9e79iaite	2023-01-05 13:18:08.726993+00	ckim1iz9ni78p8dnf3cmn8td16a	1	checkbox	Send proposal	{}	1672924689178	1672924689178	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7rkdt3izojtf6m8ek7436h3s5by	2023-01-05 13:18:08.726993+00	ckim1iz9ni78p8dnf3cmn8td16a	1	checkbox	Send initial email	{"value":true}	1672924689183	1672924689183	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7fn47owkpzifb7gmhrmqz8otyto	2023-01-05 13:18:08.726993+00	ckim1iz9ni78p8dnf3cmn8td16a	1	checkbox	Follow up after demo	{}	1672924689187	1672924689187	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
74mccbbbrbjr53g4bztt7eaozmw	2023-01-05 13:18:08.726993+00	ckim1iz9ni78p8dnf3cmn8td16a	1	checkbox	Finalize contract	{}	1672924689192	1672924689192	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
78m6x9c6gufdr5q47rpgazbobjy	2023-01-05 13:18:08.726993+00	ckim1iz9ni78p8dnf3cmn8td16a	1	checkbox	Schedule follow-up sales call	{"value":false}	1672924689196	1672924689196	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7ahicq1xmmfftfqddmjwgyfrzbr	2023-01-05 13:18:08.726993+00	ckim1iz9ni78p8dnf3cmn8td16a	1	checkbox	Schedule demo	{"value":false}	1672924689201	1672924689201	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
745hidcaqatn4ff7oj5qibkp9fr	2023-01-05 13:18:08.726993+00	ckim1iz9ni78p8dnf3cmn8td16a	1	checkbox	Schedule initial sales call	{"value":false}	1672924689204	1672924689204	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7frgsmw9xe7nr3jxp8xu7am44zy	2023-01-05 13:18:08.726993+00	ckim1iz9ni78p8dnf3cmn8td16a	1	checkbox	Post-sales follow up	{}	1672924689208	1672924689208	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7dwz15ofwdpyk3fkqfh7ps9nk9a	2023-01-05 13:18:08.726993+00	ckim1iz9ni78p8dnf3cmn8td16a	1	checkbox	Hand-off to customer success	{}	1672924689213	1672924689213	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7xgcriqsp9by59y1cygejbn7wme	2023-01-05 13:18:08.726993+00	ckim1iz9ni78p8dnf3cmn8td16a	1	checkbox	Send follow-up email	{"value":false}	1672924689219	1672924689219	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
aapqd3aoswbyxfnbpcipinpt31h	2023-01-05 13:18:08.726993+00	ckim1iz9ni78p8dnf3cmn8td16a	1	text	## Checklist	{}	1672924689224	1672924689224	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
7r4wo7r5qo3fc9yr83fjz9kay3e	2023-01-05 13:18:10.587839+00	c7y1bnewb63grffd5hzx7bky69c	1	checkbox	[Subtask 3]	{"value":false}	1672924690693	1672924690693	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
a33h531muhjdjddtg6xtq8tis8y	2023-01-05 13:18:08.726993+00	ckim1iz9ni78p8dnf3cmn8td16a	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1672924689228	1672924689228	0	\N	system		system	b76f7shib8jguxewq7a7ijnrf3y
cehued4tm4bnu8mh4so6ouwaphh	2023-01-05 13:18:10.177036+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Pay bills	{"contentOrder":["7yac1e3t3gpncm8nt1ipnaz76ir","7a8q3ifp3c7nkbxgcjskkiuppfa","7pbc7xf8eztr8tjkwix8nw7u41e"],"icon":"🔌","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"aj4jyekqqssatjcq7r7chmy19ey","abthng7baedhhtrwsdodeuincqy":"true"}}	1672924690191	1672924690191	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
crqag6asmttng8mfdwrtzdjqd9y	2023-01-05 13:18:10.177036+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Buy groceries	{"contentOrder":["ao6apocwmm3r8xfe98hrhpc9rxy","713fmxxj3ytb57bm1ahb73fsjyo","7aboahxgcn3f1bbcuzsmds6dxth","7ryqsi7r3f7bnmfk5ms8t4pe7no","77qdo4mgopbr18fytkfr6zts1he","7g5ynw5teabdauk8tqqoeaq1h7o","7knydr91qkpf15fhi1fqu76hqpc"],"icon":"🛒","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"afpy8s7i45frggprmfsqngsocqh"}}	1672924690197	1672924690197	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
cw8arca9d87dzjb6t6yjjf39ppa	2023-01-05 13:18:10.177036+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Go for a walk	{"contentOrder":["ammm85i7wzjra8mbw63tbu46ayo","agw1548eiyidqjfidwgaquccaue","7cadc6kwkrtyfdy4empk6bgmq3a"],"icon":"👣","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"an51dnkenmoog9cetapbc4uyt3y"}}	1672924690204	1672924690204	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
c75sfehnadpb55bfmirz4q1w3ih	2023-01-05 13:18:10.177036+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Feed Fluffy	{"contentOrder":["ah79z4mjhh3dt3cyf4e64j9djqr"],"icon":"🐱","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"an51dnkenmoog9cetapbc4uyt3y"}}	1672924690208	1672924690208	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
cg1gthoy4d3ntjneybzu5zsa7yo	2023-01-05 13:18:10.177036+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Gardening	{"contentOrder":[],"icon":"🌳","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"afpy8s7i45frggprmfsqngsocqh"}}	1672924690213	1672924690213	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
v9ddzwk1eti8q8n3z6hhhewnn6a	2023-01-05 13:18:10.177036+00	bbn1888mprfrm5fjw9f1je9x3xo	1	view	List View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":280},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a9zf59u8x1rf4ywctpcqama7tio","abthng7baedhhtrwsdodeuincqy"]}	1672924690220	1672924690220	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
vtdu7gdxroigdubuj5td4eeqzzc	2023-01-05 13:18:10.177036+00	bbn1888mprfrm5fjw9f1je9x3xo	1	view	Board View	{"cardOrder":["crqag6asmttng8mfdwrtzdjqd9y","cehued4tm4bnu8mh4so6ouwaphh","cw8arca9d87dzjb6t6yjjf39ppa","c75sfehnadpb55bfmirz4q1w3ih","czowhma7rnpgb3eczbqo3t7fijo"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a9zf59u8x1rf4ywctpcqama7tio","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["an51dnkenmoog9cetapbc4uyt3y","afpy8s7i45frggprmfsqngsocqh","aj4jyekqqssatjcq7r7chmy19ey",""],"visiblePropertyIds":["a9zf59u8x1rf4ywctpcqama7tio"]}	1672924690225	1672924690225	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
7pbc7xf8eztr8tjkwix8nw7u41e	2023-01-05 13:18:10.177036+00	cehued4tm4bnu8mh4so6ouwaphh	1	checkbox	Utilities	{"value":true}	1672924690230	1672924690230	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
7yac1e3t3gpncm8nt1ipnaz76ir	2023-01-05 13:18:10.177036+00	cehued4tm4bnu8mh4so6ouwaphh	1	checkbox	Mobile phone	{"value":true}	1672924690236	1672924690236	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
7a8q3ifp3c7nkbxgcjskkiuppfa	2023-01-05 13:18:10.177036+00	cehued4tm4bnu8mh4so6ouwaphh	1	checkbox	Internet	{"value":true}	1672924690241	1672924690241	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
7g5ynw5teabdauk8tqqoeaq1h7o	2023-01-05 13:18:10.177036+00	crqag6asmttng8mfdwrtzdjqd9y	1	checkbox	Cereal	{"value":false}	1672924690247	1672924690247	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
77qdo4mgopbr18fytkfr6zts1he	2023-01-05 13:18:10.177036+00	crqag6asmttng8mfdwrtzdjqd9y	1	checkbox	Butter	{"value":false}	1672924690253	1672924690253	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
7ryqsi7r3f7bnmfk5ms8t4pe7no	2023-01-05 13:18:10.177036+00	crqag6asmttng8mfdwrtzdjqd9y	1	checkbox	Bread	{"value":false}	1672924690259	1672924690259	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
713fmxxj3ytb57bm1ahb73fsjyo	2023-01-05 13:18:10.177036+00	crqag6asmttng8mfdwrtzdjqd9y	1	checkbox	Milk	{"value":false}	1672924690264	1672924690264	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
7knydr91qkpf15fhi1fqu76hqpc	2023-01-05 13:18:10.177036+00	crqag6asmttng8mfdwrtzdjqd9y	1	checkbox	Bananas	{"value":false}	1672924690271	1672924690271	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
7aboahxgcn3f1bbcuzsmds6dxth	2023-01-05 13:18:10.177036+00	crqag6asmttng8mfdwrtzdjqd9y	1	checkbox	Eggs	{"value":false}	1672924690276	1672924690276	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
ao6apocwmm3r8xfe98hrhpc9rxy	2023-01-05 13:18:10.177036+00	crqag6asmttng8mfdwrtzdjqd9y	1	text	## Grocery list	{}	1672924690282	1672924690282	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
7cadc6kwkrtyfdy4empk6bgmq3a	2023-01-05 13:18:10.177036+00	cw8arca9d87dzjb6t6yjjf39ppa	1	image		{"fileId":"76fwrj36hptg6dywka4k5mt3sph.png"}	1672924690288	1672924690288	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
ammm85i7wzjra8mbw63tbu46ayo	2023-01-05 13:18:10.177036+00	cw8arca9d87dzjb6t6yjjf39ppa	1	text	## Goal\nWalk at least 10,000 steps every day.	{}	1672924690293	1672924690293	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
agw1548eiyidqjfidwgaquccaue	2023-01-05 13:18:10.177036+00	cw8arca9d87dzjb6t6yjjf39ppa	1	text	## Route	{}	1672924690297	1672924690297	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
ah79z4mjhh3dt3cyf4e64j9djqr	2023-01-05 13:18:10.177036+00	c75sfehnadpb55bfmirz4q1w3ih	1	text		{}	1672924690303	1672924690303	0	\N	system		system	bmor97wnjrfyquk9zdnfkufz8tr
c7y1bnewb63grffd5hzx7bky69c	2023-01-05 13:18:10.587839+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Identify dependencies	{"contentOrder":["a3w5kk9ut8tbbtyyunt9i4bgnza","7rfy9ysh1hbbdzfn1nt8bz1hpia","a7aj1s8f5obyfxxtzcaf73wnzgo","7437sjj5883gtpqqpa49d91oi1e","73yhk8rdadff8pq48b4f58pgukw","7r4wo7r5qo3fc9yr83fjz9kay3e","77af6cbtcntfb9qk3t63fccjk4e"],"icon":"🔗","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"16","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ayz81h9f3dwp7rzzbdebesc7ute","d3d682bf-e074-49d9-8df5-7320921c2d23":"98a57627-0f76-471d-850d-91f3ed9fd213"}}	1672924690597	1672924690597	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
cp3k1rx5y73fejenzunfr3gdjca	2023-01-05 13:18:10.587839+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Define project scope	{"contentOrder":["a19h3d65jxj8b9y1u3nq1u1es9y","7wd1eusn78fn4dmsumsx78c4rfa","a91f7p3jbqjfapjqhnyb7q3f79e","78qfufuer8fb7mjswhjtsn88cno","7a6k6defccfdzzx5j31zzxkxksr","7biffowit5iykugry3u4cmepiur","7iuzz3a4kopnapgouuy7nrdqr8y"],"icon":"🔬","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"32","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ar6b8m3jxr3asyxhr8iucdbo6yc","d3d682bf-e074-49d9-8df5-7320921c2d23":"87f59784-b859-4c24-8ebe-17c766e081dd"}}	1672924690604	1672924690604	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
ccfcp556krpf1bcan9g8wicwwxe	2023-01-05 13:18:10.587839+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Requirements sign-off	{"contentOrder":["a8x1fm1heh7yu3jk5s6jj9eabnh","7g9msn3tnrif5bphdjz5z3greer","axxhzwhenhtd5pqe39e5kp48f3w","7dhr813mpk3bzbb8ajurx3zeg3r","7kr5uds95e7biux9rkchpwio7dy","7ug8hkqwj63fb9cx1khu5k7pyor","7g615twzps7f67m4wtgepc7iwyr"],"icon":"🖋️","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"8","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ayz81h9f3dwp7rzzbdebesc7ute","d3d682bf-e074-49d9-8df5-7320921c2d23":"d3bfb50f-f569-4bad-8a3a-dd15c3f60101"}}	1672924690610	1672924690610	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
cpxrnqehwifru9f91t9xzjkn9hy	2023-01-05 13:18:10.587839+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Project budget approval	{"contentOrder":["ayoukxyxmxt8jzdhjwbezbpg3oa","7gsn3kimbnbgixfij8jiswixp8y","adn3kiobskibsucw4y84pspj6ir","7hwjfbeqc7jnt8e93kw8we1j7yr","78o3tsdbajbdgtc51nck3xmkgzy","7rgksxf8mibgdmcb46hwnm57qwe","7s9wxbn6o1p8pzgbfu3q1tq693o"],"icon":"💵","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"16","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ayz81h9f3dwp7rzzbdebesc7ute","d3d682bf-e074-49d9-8df5-7320921c2d23":"d3bfb50f-f569-4bad-8a3a-dd15c3f60101"}}	1672924690618	1672924690618	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
c9fgxtyzospr59yegon7bxshkny	2023-01-05 13:18:10.587839+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Conduct market analysis	{"contentOrder":["anoqj44sb6jyw8exn7btb199jrw","745ztu1erx387ucq8g5fgwcy36c","au8rnwu4e7tbfdmfisnrjx8k4fc","794we4iquxbdmzeq89hssmriady","7n69cycx1hifj3k9ca1wrgx1xgw","7d6stid1gq78zzbkxbcf7pm6mwy","7oc87cagy43dc8e9sjbyqfxwgrh"],"icon":"📈","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"40","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ar6b8m3jxr3asyxhr8iucdbo6yc","d3d682bf-e074-49d9-8df5-7320921c2d23":"87f59784-b859-4c24-8ebe-17c766e081dd"}}	1672924690625	1672924690625	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
v18ui55954ff5pmie6mgtccojsa	2023-01-05 13:18:10.587839+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Project Priorities	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"d3d682bf-e074-49d9-8df5-7320921c2d23","hiddenOptionIds":[],"kanbanCalculations":{"":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"87f59784-b859-4c24-8ebe-17c766e081dd":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"98a57627-0f76-471d-850d-91f3ed9fd213":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"d3bfb50f-f569-4bad-8a3a-dd15c3f60101":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"}},"sortOptions":[],"viewType":"board","visibleOptionIds":["d3bfb50f-f569-4bad-8a3a-dd15c3f60101","87f59784-b859-4c24-8ebe-17c766e081dd","98a57627-0f76-471d-850d-91f3ed9fd213",""],"visiblePropertyIds":["a972dc7a-5f4c-45d2-8044-8c28c69717f1","a8daz81s4xjgke1ww6cwik5w7ye"]}	1672924690634	1672924690634	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
vdoteenu9xjyeirrkxyaap454ua	2023-01-05 13:18:10.587839+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Progress Tracker	{"cardOrder":["cpxrnqehwifru9f91t9xzjkn9hy","ccfcp556krpf1bcan9g8wicwwxe","c7y1bnewb63grffd5hzx7bky69c","c9fgxtyzospr59yegon7bxshkny","cp3k1rx5y73fejenzunfr3gdjca","coxnjt3ro1in19dd1e3awdt338r"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a972dc7a-5f4c-45d2-8044-8c28c69717f1","hiddenOptionIds":[],"kanbanCalculations":{"":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"adeo5xuwne3qjue83fcozekz8ko":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"afi4o5nhnqc3smtzs1hs3ij34dh":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"ahpyxfnnrzynsw3im1psxpkgtpe":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"ar6b8m3jxr3asyxhr8iucdbo6yc":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"ayz81h9f3dwp7rzzbdebesc7ute":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"}},"sortOptions":[],"viewType":"board","visibleOptionIds":["ayz81h9f3dwp7rzzbdebesc7ute","ar6b8m3jxr3asyxhr8iucdbo6yc","afi4o5nhnqc3smtzs1hs3ij34dh","adeo5xuwne3qjue83fcozekz8ko","ahpyxfnnrzynsw3im1psxpkgtpe",""],"visiblePropertyIds":["d3d682bf-e074-49d9-8df5-7320921c2d23","a8daz81s4xjgke1ww6cwik5w7ye"]}	1672924690644	1672924690643	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
vz1xppta6ctf77nwwhnpkouudpc	2023-01-05 13:18:10.587839+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Task Overview	{"cardOrder":["cp3k1rx5y73fejenzunfr3gdjca","c9fgxtyzospr59yegon7bxshkny","c7y1bnewb63grffd5hzx7bky69c","cpxrnqehwifru9f91t9xzjkn9hy","ccfcp556krpf1bcan9g8wicwwxe","cz8p8gofakfby8kzz83j97db8ph","ce1jm5q5i54enhuu4h3kkay1hcc"],"collapsedOptionIds":[],"columnCalculations":{"a8daz81s4xjgke1ww6cwik5w7ye":"sum"},"columnWidths":{"2a5da320-735c-4093-8787-f56e15cdfeed":196,"__title":280,"a8daz81s4xjgke1ww6cwik5w7ye":139,"a972dc7a-5f4c-45d2-8044-8c28c69717f1":141,"d3d682bf-e074-49d9-8df5-7320921c2d23":110},"defaultTemplateId":"czw9es1e89fdpjr7cqptr1xq7qh","filter":{"filters":[],"operation":"and"},"groupById":"","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a972dc7a-5f4c-45d2-8044-8c28c69717f1","d3d682bf-e074-49d9-8df5-7320921c2d23","2a5da320-735c-4093-8787-f56e15cdfeed","a3zsw7xs8sxy7atj8b6totp3mby","axkhqa4jxr3jcqe4k87g8bhmary","a7gdnz8ff8iyuqmzddjgmgo9ery","a8daz81s4xjgke1ww6cwik5w7ye"]}	1672924690654	1672924690653	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
vbfane1bodjy13di4zimjtksgho	2023-01-05 13:18:10.587839+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Task Calendar	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"a3zsw7xs8sxy7atj8b6totp3mby","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1672924690661	1672924690661	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7437sjj5883gtpqqpa49d91oi1e	2023-01-05 13:18:10.587839+00	c7y1bnewb63grffd5hzx7bky69c	1	checkbox	[Subtask 1]	{"value":false}	1672924690670	1672924690670	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
73yhk8rdadff8pq48b4f58pgukw	2023-01-05 13:18:10.587839+00	c7y1bnewb63grffd5hzx7bky69c	1	checkbox	[Subtask 2]	{"value":false}	1672924690676	1672924690676	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7rfy9ysh1hbbdzfn1nt8bz1hpia	2023-01-05 13:18:10.587839+00	c7y1bnewb63grffd5hzx7bky69c	1	divider		{}	1672924690683	1672924690683	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
77af6cbtcntfb9qk3t63fccjk4e	2023-01-05 13:18:10.587839+00	c7y1bnewb63grffd5hzx7bky69c	1	checkbox	...	{"value":false}	1672924690689	1672924690689	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
a7aj1s8f5obyfxxtzcaf73wnzgo	2023-01-05 13:18:10.587839+00	c7y1bnewb63grffd5hzx7bky69c	1	text	## Checklist	{}	1672924690698	1672924690698	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
a3w5kk9ut8tbbtyyunt9i4bgnza	2023-01-05 13:18:10.587839+00	c7y1bnewb63grffd5hzx7bky69c	1	text	## Description\n*[Brief description of this task]*	{}	1672924690704	1672924690704	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7a6k6defccfdzzx5j31zzxkxksr	2023-01-05 13:18:10.587839+00	cp3k1rx5y73fejenzunfr3gdjca	1	checkbox	[Subtask 2]	{"value":false}	1672924690708	1672924690708	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7iuzz3a4kopnapgouuy7nrdqr8y	2023-01-05 13:18:10.587839+00	cp3k1rx5y73fejenzunfr3gdjca	1	checkbox	...	{"value":false}	1672924690712	1672924690712	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
78qfufuer8fb7mjswhjtsn88cno	2023-01-05 13:18:10.587839+00	cp3k1rx5y73fejenzunfr3gdjca	1	checkbox	[Subtask 1]	{"value":false}	1672924690717	1672924690717	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7biffowit5iykugry3u4cmepiur	2023-01-05 13:18:10.587839+00	cp3k1rx5y73fejenzunfr3gdjca	1	checkbox	[Subtask 3]	{"value":false}	1672924690723	1672924690723	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7wd1eusn78fn4dmsumsx78c4rfa	2023-01-05 13:18:10.587839+00	cp3k1rx5y73fejenzunfr3gdjca	1	divider		{}	1672924690728	1672924690728	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
a91f7p3jbqjfapjqhnyb7q3f79e	2023-01-05 13:18:10.587839+00	cp3k1rx5y73fejenzunfr3gdjca	1	text	## Checklist	{}	1672924690734	1672924690734	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
a19h3d65jxj8b9y1u3nq1u1es9y	2023-01-05 13:18:10.587839+00	cp3k1rx5y73fejenzunfr3gdjca	1	text	## Description\n*[Brief description of this task]*	{}	1672924690739	1672924690739	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7g615twzps7f67m4wtgepc7iwyr	2023-01-05 13:18:10.587839+00	ccfcp556krpf1bcan9g8wicwwxe	1	checkbox	...	{"value":false}	1672924690745	1672924690745	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7kr5uds95e7biux9rkchpwio7dy	2023-01-05 13:18:10.587839+00	ccfcp556krpf1bcan9g8wicwwxe	1	checkbox	[Subtask 2]	{"value":false}	1672924690751	1672924690751	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7g9msn3tnrif5bphdjz5z3greer	2023-01-05 13:18:10.587839+00	ccfcp556krpf1bcan9g8wicwwxe	1	divider		{}	1672924690757	1672924690757	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7ug8hkqwj63fb9cx1khu5k7pyor	2023-01-05 13:18:10.587839+00	ccfcp556krpf1bcan9g8wicwwxe	1	checkbox	[Subtask 3]	{"value":false}	1672924690762	1672924690762	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7dhr813mpk3bzbb8ajurx3zeg3r	2023-01-05 13:18:10.587839+00	ccfcp556krpf1bcan9g8wicwwxe	1	checkbox	[Subtask 1]	{"value":false}	1672924690769	1672924690769	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
a8x1fm1heh7yu3jk5s6jj9eabnh	2023-01-05 13:18:10.587839+00	ccfcp556krpf1bcan9g8wicwwxe	1	text	## Description\n*[Brief description of this task]*	{}	1672924690775	1672924690775	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
axxhzwhenhtd5pqe39e5kp48f3w	2023-01-05 13:18:10.587839+00	ccfcp556krpf1bcan9g8wicwwxe	1	text	## Checklist	{}	1672924690780	1672924690780	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7gsn3kimbnbgixfij8jiswixp8y	2023-01-05 13:18:10.587839+00	cpxrnqehwifru9f91t9xzjkn9hy	1	divider		{}	1672924690786	1672924690786	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7hwjfbeqc7jnt8e93kw8we1j7yr	2023-01-05 13:18:10.587839+00	cpxrnqehwifru9f91t9xzjkn9hy	1	checkbox	[Subtask 1]	{"value":false}	1672924690791	1672924690791	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7rgksxf8mibgdmcb46hwnm57qwe	2023-01-05 13:18:10.587839+00	cpxrnqehwifru9f91t9xzjkn9hy	1	checkbox	[Subtask 3]	{"value":false}	1672924690795	1672924690795	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7s9wxbn6o1p8pzgbfu3q1tq693o	2023-01-05 13:18:10.587839+00	cpxrnqehwifru9f91t9xzjkn9hy	1	checkbox	...	{"value":false}	1672924690800	1672924690800	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
78o3tsdbajbdgtc51nck3xmkgzy	2023-01-05 13:18:10.587839+00	cpxrnqehwifru9f91t9xzjkn9hy	1	checkbox	[Subtask 2]	{"value":false}	1672924690805	1672924690805	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
adn3kiobskibsucw4y84pspj6ir	2023-01-05 13:18:10.587839+00	cpxrnqehwifru9f91t9xzjkn9hy	1	text	## Checklist	{}	1672924690809	1672924690809	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
ayoukxyxmxt8jzdhjwbezbpg3oa	2023-01-05 13:18:10.587839+00	cpxrnqehwifru9f91t9xzjkn9hy	1	text	## Description\n*[Brief description of this task]*	{}	1672924690816	1672924690816	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7oc87cagy43dc8e9sjbyqfxwgrh	2023-01-05 13:18:10.587839+00	c9fgxtyzospr59yegon7bxshkny	1	checkbox	...	{"value":false}	1672924690824	1672924690824	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7d6stid1gq78zzbkxbcf7pm6mwy	2023-01-05 13:18:10.587839+00	c9fgxtyzospr59yegon7bxshkny	1	checkbox	[Subtask 3]	{"value":false}	1672924690831	1672924690831	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
745ztu1erx387ucq8g5fgwcy36c	2023-01-05 13:18:10.587839+00	c9fgxtyzospr59yegon7bxshkny	1	divider		{}	1672924690838	1672924690838	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7n69cycx1hifj3k9ca1wrgx1xgw	2023-01-05 13:18:10.587839+00	c9fgxtyzospr59yegon7bxshkny	1	checkbox	[Subtask 2]	{"value":false}	1672924690843	1672924690843	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
794we4iquxbdmzeq89hssmriady	2023-01-05 13:18:10.587839+00	c9fgxtyzospr59yegon7bxshkny	1	checkbox	[Subtask 1]	{"value":false}	1672924690851	1672924690851	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
anoqj44sb6jyw8exn7btb199jrw	2023-01-05 13:18:10.587839+00	c9fgxtyzospr59yegon7bxshkny	1	text	## Description\n*[Brief description of this task]*	{}	1672924690858	1672924690858	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
au8rnwu4e7tbfdmfisnrjx8k4fc	2023-01-05 13:18:10.587839+00	c9fgxtyzospr59yegon7bxshkny	1	text	## Checklist	{}	1672924690864	1672924690864	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7thn3yndgm3rwj8g6pioe53dyqc	2023-01-05 13:18:10.587839+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	[Subtask 3]	{"value":false}	1672924690872	1672924690872	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7a66o5axkif8ipjb3kjqn6bmjra	2023-01-05 13:18:10.587839+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	[Subtask 2]	{"value":false}	1672924690879	1672924690879	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7wkn43m3bc7rm5pq16uupmraqcy	2023-01-05 13:18:10.587839+00	czw9es1e89fdpjr7cqptr1xq7qh	1	divider		{}	1672924690886	1672924690886	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7w6totrhdwfdfik5p9u9rmadq8a	2023-01-05 13:18:10.587839+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	[Subtask 1]	{"value":false}	1672924690893	1672924690893	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
7zmmw3915kpygdqqk8ex7x95qca	2023-01-05 13:18:10.587839+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	...	{"value":false}	1672924690899	1672924690899	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
atkk6b74t5pbk9khc9tieemg7pc	2023-01-05 13:18:10.587839+00	czw9es1e89fdpjr7cqptr1xq7qh	1	text	## Description\n*[Brief description of this task]*	{}	1672924690906	1672924690906	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
ainruezixbfg1dk5zrqxthdfg6a	2023-01-05 13:18:10.587839+00	czw9es1e89fdpjr7cqptr1xq7qh	1	text	## Checklist	{}	1672924690913	1672924690913	0	\N	system		system	bg37p4bhsjjbh8fe8rqerbxtgcr
c8hah5j7gxfnnuk8apjaeise11e	2023-01-05 13:18:11.555344+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Start a daily journal	{"contentOrder":[],"icon":"✍️","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","d6b1249b-bc18-45fc-889e-bec48fce80ef":"0a82977f-52bf-457b-841b-e2b7f76fb525","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"3245a32d-f688-463b-87f4-8e7142c1b397"}}	1672924691570	1672924691570	0	\N	system		system	bfeybjmgux7niix8i3smgb9b31a
c5s1c7pcc4id6pr65qpgyfnacte	2023-01-05 13:18:11.555344+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Run 3 times a week	{"contentOrder":[],"icon":"🏃","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","d6b1249b-bc18-45fc-889e-bec48fce80ef":"6e7139e4-5358-46bb-8c01-7b029a57b80a","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"ffb3f951-b47f-413b-8f1d-238666728008"}}	1672924691573	1672924691573	0	\N	system		system	bfeybjmgux7niix8i3smgb9b31a
cjmgargm11pb1ie1r7epfdzcnco	2023-01-05 13:18:11.555344+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Learn to paint	{"contentOrder":[],"icon":"🎨","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"77c539af-309c-4db1-8329-d20ef7e9eacd","d6b1249b-bc18-45fc-889e-bec48fce80ef":"9a090e33-b110-4268-8909-132c5002c90e","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"3245a32d-f688-463b-87f4-8e7142c1b397"}}	1672924691577	1672924691577	0	\N	system		system	bfeybjmgux7niix8i3smgb9b31a
cu8bhz43kktbifgre7b8uo3ysro	2023-01-05 13:18:11.555344+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Open retirement account	{"contentOrder":[],"icon":"🏦","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","d6b1249b-bc18-45fc-889e-bec48fce80ef":"0a82977f-52bf-457b-841b-e2b7f76fb525","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"80be816c-fc7a-4928-8489-8b02180f4954"}}	1672924691582	1672924691582	0	\N	system		system	bfeybjmgux7niix8i3smgb9b31a
vsnq9wipkqjd77dchwihr3rzpio	2023-01-05 13:18:11.555344+00	bd65qbzuqupfztpg31dgwgwm5ga	1	view	By Status	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"af6fcbb8-ca56-4b73-83eb-37437b9a667d","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","77c539af-309c-4db1-8329-d20ef7e9eacd","98bdea27-0cce-4cde-8dc6-212add36e63a",""],"visiblePropertyIds":["d9725d14-d5a8-48e5-8de1-6f8c004a9680","d6b1249b-bc18-45fc-889e-bec48fce80ef"]}	1672924691588	1672924691588	0	\N	system		system	bfeybjmgux7niix8i3smgb9b31a
v67g36x7agjgozdq6zyrfduhb6c	2023-01-05 13:18:11.555344+00	bd65qbzuqupfztpg31dgwgwm5ga	1	view	Calendar View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"ajy6xbebzopojaenbnmfpgtdwso","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1672924691594	1672924691593	0	\N	system		system	bfeybjmgux7niix8i3smgb9b31a
v9hze68xgbfg7xrczozrw464rqy	2023-01-05 13:18:11.555344+00	bd65qbzuqupfztpg31dgwgwm5ga	1	view	By Date	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"d6b1249b-bc18-45fc-889e-bec48fce80ef","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["9a090e33-b110-4268-8909-132c5002c90e","0a82977f-52bf-457b-841b-e2b7f76fb525","6e7139e4-5358-46bb-8c01-7b029a57b80a","d5371c63-66bf-4468-8738-c4dc4bea4843",""],"visiblePropertyIds":["d9725d14-d5a8-48e5-8de1-6f8c004a9680"]}	1672924691599	1672924691599	0	\N	system		system	bfeybjmgux7niix8i3smgb9b31a
vfdpsmq331tfo3gkfgaybr7w43a	2023-01-05 13:18:12.257888+00		1	view	Competitor List	{"cardOrder":["cm6jhium31insino6coq8rziyja","czypouqqwyjbkfjkx1sypp5j4ka","ceedjswwfqpftukmtrnwhjojrwc","cxp4qfkegp7byi8bkpztnb33cfe","cckr9sxx73tfe9pksy8ipudfzfh"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":210,"a1semdhszu1rq17d7et5ydrqqio":121,"aapogff3xoa8ym7xf56s87kysda":194,"ahzspe59iux8wigra8bg6cg18nc":156,"aiefo7nh9jwisn8b4cgakowithy":155,"aozntq4go4nkab688j1s7stqtfc":151,"az3jkw3ynd3mqmart7edypey15e":145},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["ahzspe59iux8wigra8bg6cg18nc","aozntq4go4nkab688j1s7stqtfc","aiefo7nh9jwisn8b4cgakowithy","a6cwaq79b1pdpb97wkanmeyy4er","an1eerzscfxn6awdfajbg41uz3h","a1semdhszu1rq17d7et5ydrqqio","aapogff3xoa8ym7xf56s87kysda","az3jkw3ynd3mqmart7edypey15e"]}	1672924692269	1672924692269	0	\N	system		system	bwzfh6d1x3fr8zb8gfxba65kjah
v9si1am1kdtdppgby1ph5taxywy	2023-01-05 13:18:12.257888+00		1	view	Market Position	{"cardOrder":["cip8b4jcomfr7by9gtizebikfke","cacs91js1hb887ds41r6dwnd88c","ca3u8edwrof89i8obxffnz4xw3a"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["arfjpz9by5car71tz3behba8yih","abajmr34b8g1916w495xjb35iko","abt79uxg5edqojsrrefcnr4eruo","aipf3qfgjtkheiayjuxrxbpk9wa"],"visiblePropertyIds":[]}	1672924692275	1672924692275	0	\N	system		system	bwzfh6d1x3fr8zb8gfxba65kjah
cm6jhium31insino6coq8rziyja	2023-01-05 13:18:12.257888+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Liminary Corp.	{"contentOrder":["aj1oizrnd5inifd4ea4pm61nmse"],"icon":"🌧","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"abt79uxg5edqojsrrefcnr4eruo","a6cwaq79b1pdpb97wkanmeyy4er":"300","ahzspe59iux8wigra8bg6cg18nc":"liminarycorp.com","aiefo7nh9jwisn8b4cgakowithy":"$25,000,000","an1eerzscfxn6awdfajbg41uz3h":"2017","aozntq4go4nkab688j1s7stqtfc":"Toronto, Canada"}}	1672924692280	1672924692279	0	\N	system		system	bwzfh6d1x3fr8zb8gfxba65kjah
czypouqqwyjbkfjkx1sypp5j4ka	2023-01-05 13:18:12.257888+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Helx Industries	{"contentOrder":["ay889a3xr5pyixgudjd6mu4pmyy"],"icon":"📦","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"abt79uxg5edqojsrrefcnr4eruo","a6cwaq79b1pdpb97wkanmeyy4er":"650","ahzspe59iux8wigra8bg6cg18nc":"helxindustries.com","aiefo7nh9jwisn8b4cgakowithy":"$50,000,000","an1eerzscfxn6awdfajbg41uz3h":"2009","aozntq4go4nkab688j1s7stqtfc":"New York, NY"}}	1672924692285	1672924692285	0	\N	system		system	bwzfh6d1x3fr8zb8gfxba65kjah
ceedjswwfqpftukmtrnwhjojrwc	2023-01-05 13:18:12.257888+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Kadera Global	{"contentOrder":["aiwabx71igfnhje9j39ytd4t1nh"],"icon":"🛡","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"aipf3qfgjtkheiayjuxrxbpk9wa","a6cwaq79b1pdpb97wkanmeyy4er":"150","ahzspe59iux8wigra8bg6cg18nc":"kaderaglobal.com","aiefo7nh9jwisn8b4cgakowithy":"$12,000,000","an1eerzscfxn6awdfajbg41uz3h":"2015","aozntq4go4nkab688j1s7stqtfc":"Seattle, OR"}}	1672924692290	1672924692290	0	\N	system		system	bwzfh6d1x3fr8zb8gfxba65kjah
aws4m776wgtd7xy7st6e6pxfy1a	2023-01-05 13:18:13.314902+00	cqh6oczxk6tn9tf836qtk7qwc4r	1	text	Collaborate with teammates directly on each card using @mentions and have all the relevant context in one place.	{}	1672924693585	1672924693585	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
vo65rxpbui7bozrid5fxna15qqa	2023-01-05 13:18:11.328467+00		1	view	By Quarter	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":452,"a17ryhi1jfsboxkwkztwawhmsxe":148,"a6amddgmrzakw66cidqzgk6p4ge":230,"azzbawji5bksj69sekcs4srm1ky":142},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"aqxyzkdrs4egqf7yk866ixkaojc","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a6amddgmrzakw66cidqzgk6p4ge","a17ryhi1jfsboxkwkztwawhmsxe","azzbawji5bksj69sekcs4srm1ky","adp5ft3kgz7r5iqq3tnwg551der","aqxyzkdrs4egqf7yk866ixkaojc","adu6mebzpibq6mgcswk69xxmnqe","asope3bddhm4gpsng5cfu4hf6rh","ajwxp866f9obs1kutfwaa5ru7fe","azqnyswk6s1boiwuthscm78qwuo","ahz3fmjnaguec8hce7xq3h5cjdr","a17bfcgnzmkwhziwa4tr38kiw5r"]}	1672924691337	1672924691337	0	\N	system		system	bhfouoto7gtbb3py83ib5nhb7jc
vp411pz7ojjr38bq8hct6ji7i8h	2023-01-05 13:18:11.328467+00		1	view	By Objectives	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":387,"a17ryhi1jfsboxkwkztwawhmsxe":134,"a6amddgmrzakw66cidqzgk6p4ge":183,"aqxyzkdrs4egqf7yk866ixkaojc":100},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a6amddgmrzakw66cidqzgk6p4ge","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a6amddgmrzakw66cidqzgk6p4ge","a17ryhi1jfsboxkwkztwawhmsxe","azzbawji5bksj69sekcs4srm1ky","adp5ft3kgz7r5iqq3tnwg551der","aqxyzkdrs4egqf7yk866ixkaojc","adu6mebzpibq6mgcswk69xxmnqe","asope3bddhm4gpsng5cfu4hf6rh","ajwxp866f9obs1kutfwaa5ru7fe","azqnyswk6s1boiwuthscm78qwuo","ahz3fmjnaguec8hce7xq3h5cjdr","a17bfcgnzmkwhziwa4tr38kiw5r"]}	1672924691343	1672924691343	0	\N	system		system	bhfouoto7gtbb3py83ib5nhb7jc
c9dozc74patrqdf5f1ycedb8f8o	2023-01-05 13:18:11.328467+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Improve customer NPS score	{"contentOrder":[],"icon":"💯","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a8nukezwwmknqwjsygg7eaxs9te","a6amddgmrzakw66cidqzgk6p4ge":"apqfjst8massbjjhpcsjs3y1yqa","adp5ft3kgz7r5iqq3tnwg551der":"as555ipyzopjjpfb5rjtssecw5e","ahz3fmjnaguec8hce7xq3h5cjdr":"82%","ajwxp866f9obs1kutfwaa5ru7fe":"8.5","aqxyzkdrs4egqf7yk866ixkaojc":"anruuoyez51r3yjxuoc8zoqnwaw","azqnyswk6s1boiwuthscm78qwuo":"7","azzbawji5bksj69sekcs4srm1ky":"agm9p6gcq15ueuzqq3wd4be39wy"}}	1672924691349	1672924691349	0	\N	system		system	bhfouoto7gtbb3py83ib5nhb7jc
c7u347gghr7dyfx4s8w9wh4wjbc	2023-01-05 13:18:11.328467+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Generate more Marketing Qualified Leads (MQLs)	{"contentOrder":[],"icon":"🛣️","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a8nukezwwmknqwjsygg7eaxs9te","a6amddgmrzakw66cidqzgk6p4ge":"auw3afh3kfhrfgmjr8muiz137jy","adp5ft3kgz7r5iqq3tnwg551der":"as555ipyzopjjpfb5rjtssecw5e","ahz3fmjnaguec8hce7xq3h5cjdr":"65%","ajwxp866f9obs1kutfwaa5ru7fe":"100","aqxyzkdrs4egqf7yk866ixkaojc":"ahfbn1jsmhydym33ygxwg5jt3kh","azqnyswk6s1boiwuthscm78qwuo":"65","azzbawji5bksj69sekcs4srm1ky":"aehoa17cz18rqnrf75g7dwhphpr"}}	1672924691355	1672924691355	0	\N	system		system	bhfouoto7gtbb3py83ib5nhb7jc
cyci7ammphbgnxx6i7ifayy71wr	2023-01-05 13:18:11.328467+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Increase customer retention	{"contentOrder":[],"icon":"😀","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a8nukezwwmknqwjsygg7eaxs9te","a6amddgmrzakw66cidqzgk6p4ge":"apqfjst8massbjjhpcsjs3y1yqa","adp5ft3kgz7r5iqq3tnwg551der":"a8zg3rjtf4swh7smsjxpsn743rh","ahz3fmjnaguec8hce7xq3h5cjdr":"66%","ajwxp866f9obs1kutfwaa5ru7fe":"90% customer retention rate","aqxyzkdrs4egqf7yk866ixkaojc":"acb6dqqs6yson7bbzx6jk9bghjh","azqnyswk6s1boiwuthscm78qwuo":"60%","azzbawji5bksj69sekcs4srm1ky":"afkxpcjqjypu7hhar7banxau91h"}}	1672924691360	1672924691360	0	\N	system		system	bhfouoto7gtbb3py83ib5nhb7jc
c9in97skfnj8qjkoji4aktax6nh	2023-01-05 13:18:11.328467+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Hit company global sales target	{"contentOrder":[],"icon":"💰","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a6robxx81diugpjq5jkezz3j1fo","a6amddgmrzakw66cidqzgk6p4ge":"auw3afh3kfhrfgmjr8muiz137jy","adp5ft3kgz7r5iqq3tnwg551der":"a8zg3rjtf4swh7smsjxpsn743rh","ahz3fmjnaguec8hce7xq3h5cjdr":"15%","ajwxp866f9obs1kutfwaa5ru7fe":"50MM","aqxyzkdrs4egqf7yk866ixkaojc":"awfu37js3fomfkkczm1zppac57a","azqnyswk6s1boiwuthscm78qwuo":"7.5MM","azzbawji5bksj69sekcs4srm1ky":"agrfeaoj7d8p5ianw5iaf3191ae"}}	1672924691365	1672924691365	0	\N	system		system	bhfouoto7gtbb3py83ib5nhb7jc
c7xih5fgtf7rwietwsj1bxqs7oc	2023-01-05 13:18:11.328467+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Increase user signups by 30%	{"contentOrder":[],"icon":"💳","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a6robxx81diugpjq5jkezz3j1fo","a6amddgmrzakw66cidqzgk6p4ge":"ao9b5pxyt7tkgdohzh9oaustdhr","adp5ft3kgz7r5iqq3tnwg551der":"as555ipyzopjjpfb5rjtssecw5e","ahz3fmjnaguec8hce7xq3h5cjdr":"0%","ajwxp866f9obs1kutfwaa5ru7fe":"1,000","aqxyzkdrs4egqf7yk866ixkaojc":"acb6dqqs6yson7bbzx6jk9bghjh","azqnyswk6s1boiwuthscm78qwuo":"0","azzbawji5bksj69sekcs4srm1ky":"afkxpcjqjypu7hhar7banxau91h"}}	1672924691371	1672924691371	0	\N	system		system	bhfouoto7gtbb3py83ib5nhb7jc
cas47ogpi438p7qqktpiqg6rgnw	2023-01-05 13:18:11.328467+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Add 10 new customers in the EU	{"contentOrder":[],"icon":"🌍","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"apnt1f7na9rzgk1rt49keg7xbiy","a6amddgmrzakw66cidqzgk6p4ge":"auw3afh3kfhrfgmjr8muiz137jy","adp5ft3kgz7r5iqq3tnwg551der":"a1ts3ftyr8nocsicui98c89uxjy","ahz3fmjnaguec8hce7xq3h5cjdr":"30%","ajwxp866f9obs1kutfwaa5ru7fe":"10","aqxyzkdrs4egqf7yk866ixkaojc":"acb6dqqs6yson7bbzx6jk9bghjh","azqnyswk6s1boiwuthscm78qwuo":"3","azzbawji5bksj69sekcs4srm1ky":"agrfeaoj7d8p5ianw5iaf3191ae"}}	1672924691376	1672924691376	0	\N	system		system	bhfouoto7gtbb3py83ib5nhb7jc
cjuiw1ia1b3fzipo91woz8py7aa	2023-01-05 13:18:11.328467+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Launch 3 key features	{"contentOrder":[],"icon":"🚀","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"apnt1f7na9rzgk1rt49keg7xbiy","a6amddgmrzakw66cidqzgk6p4ge":"ao9b5pxyt7tkgdohzh9oaustdhr","adp5ft3kgz7r5iqq3tnwg551der":"a8zg3rjtf4swh7smsjxpsn743rh","ahz3fmjnaguec8hce7xq3h5cjdr":"33%","ajwxp866f9obs1kutfwaa5ru7fe":"3","aqxyzkdrs4egqf7yk866ixkaojc":"anruuoyez51r3yjxuoc8zoqnwaw","azqnyswk6s1boiwuthscm78qwuo":"1","azzbawji5bksj69sekcs4srm1ky":"aw5i7hmpadn6mbwbz955ubarhme"}}	1672924691381	1672924691381	0	\N	system		system	bhfouoto7gtbb3py83ib5nhb7jc
cqgsjnnrb3tfiuptpzws556gz7y	2023-01-05 13:18:11.328467+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Reduce bug backlog by 50%	{"contentOrder":[],"icon":"🐞","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"abzfwnn6rmtfzyq5hg8uqmpsncy","a6amddgmrzakw66cidqzgk6p4ge":"apqfjst8massbjjhpcsjs3y1yqa","adp5ft3kgz7r5iqq3tnwg551der":"a1ts3ftyr8nocsicui98c89uxjy","ahz3fmjnaguec8hce7xq3h5cjdr":"100%","ajwxp866f9obs1kutfwaa5ru7fe":"75","aqxyzkdrs4egqf7yk866ixkaojc":"awfu37js3fomfkkczm1zppac57a","azqnyswk6s1boiwuthscm78qwuo":"75","azzbawji5bksj69sekcs4srm1ky":"aw5i7hmpadn6mbwbz955ubarhme"}}	1672924691386	1672924691386	0	\N	system		system	bhfouoto7gtbb3py83ib5nhb7jc
cg4fz84f1ybb4xe346d784hj6sh	2023-01-05 13:18:11.678364+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Feature	{"contentOrder":["atr1gpn98jfrw7cms48utpdizsc"],"icon":"🏗️","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer"}}	1672924691726	1672924691726	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
vykj4z8nfx78b9niwuypxijeanc	2023-01-05 13:18:11.328467+00	bm4ubx56krp4zwyfcqh7nxiigbr	1	view	Departments	{"cardOrder":["cpa534b5natgmunis8u1ixb55pw"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"azzbawji5bksj69sekcs4srm1ky","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["aw5i7hmpadn6mbwbz955ubarhme","afkxpcjqjypu7hhar7banxau91h","aehoa17cz18rqnrf75g7dwhphpr","agrfeaoj7d8p5ianw5iaf3191ae","agm9p6gcq15ueuzqq3wd4be39wy","aucop7kw6xwodcix6zzojhxih6r","afust91f3g8ht368mkn5x9tgf1o","acocxxwjurud1jixhp7nowdig7y"],"visiblePropertyIds":[]}	1672924691390	1672924691390	0	\N	system		system	bhfouoto7gtbb3py83ib5nhb7jc
vuyyc843377nodcyrd7n1g6xeuw	2023-01-05 13:18:11.678364+00		1	view	By Sprint	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{"ai7ajsdk14w7x5s8up3dwir77te":"count"},"columnWidths":{"20717ad3-5741-4416-83f1-6f133fff3d11":128,"50117d52-bcc7-4750-82aa-831a351c44a0":126,"__title":280,"a1g6i613dpe9oryeo71ex3c86hy":159,"aeomttrbhhsi8bph31jn84sto6h":141,"ax9f8so418s6s65hi5ympd93i6a":183,"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":100},"defaultTemplateId":"czb9pr8mi6pfb7g8geiymmqndqe","filter":{"filters":[],"operation":"and"},"groupById":"60985f46-3e41-486e-8213-2b987440ea1c","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["50117d52-bcc7-4750-82aa-831a351c44a0","20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","aphg37f7zbpuc3bhwhp19s1ribh","a4378omyhmgj3bex13sj4wbpfiy","ai7ajsdk14w7x5s8up3dwir77te","a1g6i613dpe9oryeo71ex3c86hy","aeomttrbhhsi8bph31jn84sto6h","ax9f8so418s6s65hi5ympd93i6a"]}	1672924691690	1672924691690	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
czb9pr8mi6pfb7g8geiymmqndqe	2023-01-05 13:18:11.678364+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	User Story	{"contentOrder":["aun6h5bzz8ib9mxyngwemy8kf9w"],"icon":"📖","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"apht1nt5ryukdmxkh6fkfn6rgoy","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer"}}	1672924691693	1672924691693	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
cxizdup9qe38k9nnfc1s3u74syr	2023-01-05 13:18:11.678364+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Horizontal scroll issue	{"contentOrder":["ae9nrzn1s6byhdgwqaqkxzsrycy","auoe67ckow7ydbkfckfbnzmg3ew","7b1cbjfsur3n1jj4ksox4qsig8e"],"icon":"〰️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"aomnawq4551cbbzha9gxnmb3z5w","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","ai7ajsdk14w7x5s8up3dwir77te":"1","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1672924691696	1672924691696	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
c13jre9i1zb865en3wws6f81kfy	2023-01-05 13:18:11.678364+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Login screen not loading	{"contentOrder":["aacx3p8a59tnubyb8iysnf8mh7a","a35u5uxeyhfbnzbut8jpz8xaete","7xk1ib9g8ejy3ip8t18wikup8ja"],"icon":"🖥️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"aomnawq4551cbbzha9gxnmb3z5w","50117d52-bcc7-4750-82aa-831a351c44a0":"abrfos7e7eczk9rqw6y5abadm1y","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","ai7ajsdk14w7x5s8up3dwir77te":"1","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"cb8ecdac-38be-4d36-8712-c4d58cc8a8e9"}}	1672924691699	1672924691699	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
cdazdcqpzajy8td7uhj3izpaiza	2023-01-05 13:18:11.678364+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Move cards across boards	{"contentOrder":["aehuqx3tuh3rw7mqgoz5duifync"],"icon":"🚚","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"abrfos7e7eczk9rqw6y5abadm1y","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"2","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1672924691703	1672924691703	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
cioyxrb8hbfn4txozz5gn5itiwe	2023-01-05 13:18:11.678364+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Cross-team collaboration	{"contentOrder":["a1hyajcyi3pba5rf5oy9in9jpoa"],"icon":"🤝","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"424ea5e3-9aa1-4075-8c5c-01b44b66e634","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","60985f46-3e41-486e-8213-2b987440ea1c":"14892380-1a32-42dd-8034-a0cea32bc7e6","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"3","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"c62172ea-5da7-4dec-8186-37267d8ee9a7"}}	1672924691706	1672924691706	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
c7oktow86u38dpxwhwwdumrkmew	2023-01-05 13:18:11.678364+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Bug	{"contentOrder":["aubqugebyyir7jeiy8d3eofb6qh","a4w9nyszxeirqxgqqjgigaebs4y","74h7wd8a66jyepmu18rp6dcsyuo"],"icon":"🐞","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"aomnawq4551cbbzha9gxnmb3z5w","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer"}}	1672924691710	1672924691710	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
ciis64kebrf8zipuhzh63kw6g8y	2023-01-05 13:18:11.678364+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Standard properties	{"contentOrder":["awosbkyzk9ff9mgpare4obf3y6a"],"icon":"🏷️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","60985f46-3e41-486e-8213-2b987440ea1c":"14892380-1a32-42dd-8034-a0cea32bc7e6","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"3","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1672924691714	1672924691714	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
c65rybk7kp3g4tq4631kmaj6a6r	2023-01-05 13:18:11.678364+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Epic	{"contentOrder":["aybf1pyesn7f89r1rwxhun8eoao"],"icon":"🤝","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"424ea5e3-9aa1-4075-8c5c-01b44b66e634","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"3","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"c62172ea-5da7-4dec-8186-37267d8ee9a7"}}	1672924691718	1672924691718	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
cbq4ymbirsjbfmyufry44ww883r	2023-01-05 13:18:11.678364+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Global templates	{"contentOrder":["aodmr3dqb1j8wmbygtsestzbise"],"icon":"🖼️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"a6ghze4iy441qhsh3eijnc8hwze","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"2","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1672924691722	1672924691722	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
axui9zb4g7jgcxqre6x6e43apqa	2023-01-05 13:18:12.451033+00	cqgo1rgh4jpdmikoe6tug46huhh	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1672924692542	1672924692542	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
vnct85f3zwbrr8j9y1durpuzjkw	2023-01-05 13:18:11.678364+00	bgi1yqiis8t8xdqxgnet8ebutky	1	view	By Status	{"cardOrder":["cbq4ymbirsjbfmyufry44ww883r","cxizdup9qe38k9nnfc1s3u74syr","cdazdcqpzajy8td7uhj3izpaiza","c13jre9i1zb865en3wws6f81kfy","ciis64kebrf8zipuhzh63kw6g8y","cioyxrb8hbfn4txozz5gn5itiwe"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cidz4imnqhir48brz6e8hxhfrhy","filter":{"filters":[],"operation":"and"},"groupById":"50117d52-bcc7-4750-82aa-831a351c44a0","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["aft5bzo7h9aspqgrx3jpy5tzrer","abrfos7e7eczk9rqw6y5abadm1y","ax8wzbka5ahs3zziji3pp4qp9mc","atabdfbdmjh83136d5e5oysxybw","ace1bzypd586kkyhcht5qqd9eca","aay656c9m1hzwxc9ch5ftymh3nw","a6ghze4iy441qhsh3eijnc8hwze"],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1672924691731	1672924691731	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
v1qhrn4on7fd4bgj7ek6a6ws5ye	2023-01-05 13:18:11.678364+00	bgi1yqiis8t8xdqxgnet8ebutky	1	view	By Type	{"cardOrder":["c13jre9i1zb865en3wws6f81kfy","cdazdcqpzajy8td7uhj3izpaiza","ciis64kebrf8zipuhzh63kw6g8y","cxizdup9qe38k9nnfc1s3u74syr","cbq4ymbirsjbfmyufry44ww883r","cioyxrb8hbfn4txozz5gn5itiwe"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cidz4imnqhir48brz6e8hxhfrhy","filter":{"filters":[],"operation":"and"},"groupById":"20717ad3-5741-4416-83f1-6f133fff3d11","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["424ea5e3-9aa1-4075-8c5c-01b44b66e634","a5yxq8rbubrpnoommfwqmty138h","apht1nt5ryukdmxkh6fkfn6rgoy","aiycbuo3dr5k4xxbfr7coem8ono","aomnawq4551cbbzha9gxnmb3z5w"],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1672924691735	1672924691735	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
aun6h5bzz8ib9mxyngwemy8kf9w	2023-01-05 13:18:11.678364+00	czb9pr8mi6pfb7g8geiymmqndqe	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1672924691738	1672924691738	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
7b1cbjfsur3n1jj4ksox4qsig8e	2023-01-05 13:18:11.678364+00	cxizdup9qe38k9nnfc1s3u74syr	1	image		{"fileId":"7tmfu5iqju3n1mdfwi5gru89qmw.png"}	1672924691741	1672924691741	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
ae9nrzn1s6byhdgwqaqkxzsrycy	2023-01-05 13:18:11.678364+00	cxizdup9qe38k9nnfc1s3u74syr	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1672924691743	1672924691743	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
auoe67ckow7ydbkfckfbnzmg3ew	2023-01-05 13:18:11.678364+00	cxizdup9qe38k9nnfc1s3u74syr	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1672924691747	1672924691747	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
7xk1ib9g8ejy3ip8t18wikup8ja	2023-01-05 13:18:11.678364+00	c13jre9i1zb865en3wws6f81kfy	1	image		{"fileId":"7b9xk9boj3fbqfm3umeaaizp8qr.png"}	1672924691752	1672924691752	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
aacx3p8a59tnubyb8iysnf8mh7a	2023-01-05 13:18:11.678364+00	c13jre9i1zb865en3wws6f81kfy	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1672924691757	1672924691756	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
a35u5uxeyhfbnzbut8jpz8xaete	2023-01-05 13:18:11.678364+00	c13jre9i1zb865en3wws6f81kfy	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1672924691761	1672924691761	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
aehuqx3tuh3rw7mqgoz5duifync	2023-01-05 13:18:11.678364+00	cdazdcqpzajy8td7uhj3izpaiza	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1672924691764	1672924691764	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
a4gocogwg87rgf8kr6jpdj5p6oy	2023-01-05 13:18:11.678364+00	cfmk7771httynm8r7rm8cbrmrya	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1672924691769	1672924691769	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
azbjta561gj8wd87isi916aoatc	2023-01-05 13:18:11.678364+00	cfmk7771httynm8r7rm8cbrmrya	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1672924691772	1672924691772	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
a1hyajcyi3pba5rf5oy9in9jpoa	2023-01-05 13:18:11.678364+00	cioyxrb8hbfn4txozz5gn5itiwe	1	text	## Summary\n*[Brief description of what this epic is about]*\n\n## Motivation\n*[Brief description on why this is needed]*\n\n## Acceptance Criteria\n - *[Criteron 1]*\n - *[Criteron 2]*\n - ...\n\n## Personas\n - *[Persona A]*\n - *[Persona B]*\n - ...\n\n## Reference Materials\n - *[Links to other relevant documents as needed]*\n - ...	{}	1672924691777	1672924691777	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
74h7wd8a66jyepmu18rp6dcsyuo	2023-01-05 13:18:11.678364+00	c7oktow86u38dpxwhwwdumrkmew	1	image		{"fileId":"7tmfu5iqju3n1mdfwi5gru89qmw.png"}	1672924691783	1672924691783	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
aubqugebyyir7jeiy8d3eofb6qh	2023-01-05 13:18:11.678364+00	c7oktow86u38dpxwhwwdumrkmew	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1672924691789	1672924691789	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
a4w9nyszxeirqxgqqjgigaebs4y	2023-01-05 13:18:11.678364+00	c7oktow86u38dpxwhwwdumrkmew	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1672924691794	1672924691794	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
awosbkyzk9ff9mgpare4obf3y6a	2023-01-05 13:18:11.678364+00	ciis64kebrf8zipuhzh63kw6g8y	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1672924691799	1672924691799	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
aybf1pyesn7f89r1rwxhun8eoao	2023-01-05 13:18:11.678364+00	c65rybk7kp3g4tq4631kmaj6a6r	1	text	## Summary\n*[Brief description of what this epic is about]*\n\n## Motivation\n*[Brief description on why this is needed]*\n\n## Acceptance Criteria\n - *[Criteron 1]*\n - *[Criteron 2]*\n - ...\n\n## Personas\n - *[Persona A]*\n - *[Persona B]*\n - ...\n\n## Reference Materials\n - *[Links to other relevant documents as needed]*\n - ...	{}	1672924691805	1672924691805	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
aodmr3dqb1j8wmbygtsestzbise	2023-01-05 13:18:11.678364+00	cbq4ymbirsjbfmyufry44ww883r	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1672924691810	1672924691810	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
atr1gpn98jfrw7cms48utpdizsc	2023-01-05 13:18:11.678364+00	cg4fz84f1ybb4xe346d784hj6sh	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1672924691819	1672924691819	0	\N	system		system	b195yoro7a7b4mkf4irwoj7cohy
vuwfy9kptybrbxry9yzs4q3bgsw	2023-01-05 13:18:12.078234+00		1	view	All Users	{"cardOrder":["cwfijrn8x3jyepf9nrwjhrsx9zy"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":280,"aaebj5fyx493eezx6ukxiwydgty":146,"acjq4t5ymytu8x1f68wkggm7ypc":222,"akrxgi7p7w14fym3gbynb98t9fh":131,"atg9qu6oe4bjm8jczzsn71ff5me":131},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"akrxgi7p7w14fym3gbynb98t9fh","reversed":false}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["aaebj5fyx493eezx6ukxiwydgty","akrxgi7p7w14fym3gbynb98t9fh","atg9qu6oe4bjm8jczzsn71ff5me","acjq4t5ymytu8x1f68wkggm7ypc","aphio1s5gkmpdbwoxynim7acw3e","aqafzdeekpyncwz7m7i54q3iqqy","aify3r761b9w43bqjtskrzi68tr"]}	1672924692089	1672924692089	0	\N	system		system	b69byqn5ghj8umfbseap3ky8qpo
cwfijrn8x3jyepf9nrwjhrsx9zy	2023-01-05 13:18:12.078234+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Frank Nash	{"contentOrder":["az7ntau5zmtdwfjjxxsqza7njew"],"icon":"👨‍💼","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"ap93ysuzy1xa7z818r6myrn4h4y","acjq4t5ymytu8x1f68wkggm7ypc":"frank.nash@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1669896000000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"aehc83ffays3gh8myz16a8j7k4e"}}	1672924692094	1672924692094	0	\N	system		system	b69byqn5ghj8umfbseap3ky8qpo
caoyqkqtjmbngdgrq47qxn5wt7c	2023-01-05 13:18:12.078234+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Richard Parsons	{"contentOrder":["agbjocarp3pftdcrkwjp4hi7ech"],"icon":"👨‍🦱","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"a7yq89whddzob1futao4rxk3yzc","acjq4t5ymytu8x1f68wkggm7ypc":"richard.parsons@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1671019200000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"a1sxagjgaadym5yrjak6tcup1oa"}}	1672924692098	1672924692098	0	\N	system		system	b69byqn5ghj8umfbseap3ky8qpo
c4z9bzfmmxpfp5cd1sayhnrw7me	2023-01-05 13:18:12.078234+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Claire Hart	{"contentOrder":["a8jrdidjhkina9ddkqxguy63gse"],"icon":"👩‍🦰","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"aseqq9hrsua56r3s6nbuirj9eec","acjq4t5ymytu8x1f68wkggm7ypc":"claire.hart@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1670500800000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"ahn89mqg9u4igk6pdm7333t8i5h"}}	1672924692104	1672924692104	0	\N	system		system	b69byqn5ghj8umfbseap3ky8qpo
cd8dkrm4yjpybzpa8k76o54y8wr	2023-01-05 13:18:12.078234+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Olivia Alsop	{"contentOrder":["a1u135oohatbutj6cqztbaxchmy"],"icon":"👩‍💼","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"a7yq89whddzob1futao4rxk3yzc","acjq4t5ymytu8x1f68wkggm7ypc":"olivia.alsop@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1671192000000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"a1sxagjgaadym5yrjak6tcup1oa"}}	1672924692108	1672924692108	0	\N	system		system	b69byqn5ghj8umfbseap3ky8qpo
cnw3ahxzikp83dmf7he6gs8sfir	2023-01-05 13:18:12.078234+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Bernadette Powell	{"contentOrder":["ahjt77a8tcbnkpx6791c9joni6w"],"icon":"🧑‍💼","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"af6hjb3ysuaxbwnfqpby4wwnkdr","acjq4t5ymytu8x1f68wkggm7ypc":"bernadette.powell@email.com"}}	1672924692113	1672924692113	0	\N	system		system	b69byqn5ghj8umfbseap3ky8qpo
v63dxdu8jdpyqb8kxnzfg4num1e	2023-01-05 13:18:12.078234+00	bh4pkixqsjift58e1qy6htrgeay	1	view	By Date	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"akrxgi7p7w14fym3gbynb98t9fh","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1672924692120	1672924692120	0	\N	system		system	b69byqn5ghj8umfbseap3ky8qpo
vwy5tuxn35p8edpg4d8b76kxxyo	2023-01-05 13:18:12.078234+00	bixohg18tt11in4qbtinimk974y	1	view	By Status	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["af6hjb3ysuaxbwnfqpby4wwnkdr","aotxum1p5bw3xuzqz3ctjw66yww","a7yq89whddzob1futao4rxk3yzc","aseqq9hrsua56r3s6nbuirj9eec","ap93ysuzy1xa7z818r6myrn4h4y"],"visiblePropertyIds":[]}	1672924692124	1672924692124	0	\N	system		system	b69byqn5ghj8umfbseap3ky8qpo
az7ntau5zmtdwfjjxxsqza7njew	2023-01-05 13:18:12.078234+00	cwfijrn8x3jyepf9nrwjhrsx9zy	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1672924692128	1672924692128	0	\N	system		system	b69byqn5ghj8umfbseap3ky8qpo
agbjocarp3pftdcrkwjp4hi7ech	2023-01-05 13:18:12.078234+00	caoyqkqtjmbngdgrq47qxn5wt7c	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1672924692134	1672924692134	0	\N	system		system	b69byqn5ghj8umfbseap3ky8qpo
a8jrdidjhkina9ddkqxguy63gse	2023-01-05 13:18:12.078234+00	c4z9bzfmmxpfp5cd1sayhnrw7me	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1672924692140	1672924692140	0	\N	system		system	b69byqn5ghj8umfbseap3ky8qpo
a1u135oohatbutj6cqztbaxchmy	2023-01-05 13:18:12.078234+00	cd8dkrm4yjpybzpa8k76o54y8wr	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1672924692147	1672924692147	0	\N	system		system	b69byqn5ghj8umfbseap3ky8qpo
ahjt77a8tcbnkpx6791c9joni6w	2023-01-05 13:18:12.078234+00	cnw3ahxzikp83dmf7he6gs8sfir	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1672924692151	1672924692151	0	\N	system		system	b69byqn5ghj8umfbseap3ky8qpo
amkdzeei5binwfc65pfb1xgizco	2023-01-05 13:18:12.451033+00	c55srt19grbgkik9a1s1rrbij3r	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1672924692545	1672924692545	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
cckr9sxx73tfe9pksy8ipudfzfh	2023-01-05 13:18:12.257888+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Ositions Inc.	{"contentOrder":["akf1dh4iq8prxifriwoq96s1suy"],"icon":"🌃","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"abajmr34b8g1916w495xjb35iko","a6cwaq79b1pdpb97wkanmeyy4er":"2,700","ahzspe59iux8wigra8bg6cg18nc":"ositionsinc.com","aiefo7nh9jwisn8b4cgakowithy":"$125,000,000","an1eerzscfxn6awdfajbg41uz3h":"2004","aozntq4go4nkab688j1s7stqtfc":"Berlin, Germany"}}	1672924692294	1672924692294	0	\N	system		system	bwzfh6d1x3fr8zb8gfxba65kjah
cxp4qfkegp7byi8bkpztnb33cfe	2023-01-05 13:18:12.257888+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Afformance Ltd.	{"contentOrder":["auacrd8btk3nop8uf5frcd3ro4o"],"icon":"⚡","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"arfjpz9by5car71tz3behba8yih","a6cwaq79b1pdpb97wkanmeyy4er":"1,800","ahzspe59iux8wigra8bg6cg18nc":"afformanceltd.com","aiefo7nh9jwisn8b4cgakowithy":"$200,000,000","an1eerzscfxn6awdfajbg41uz3h":"2002","aozntq4go4nkab688j1s7stqtfc":"Palo Alto, CA"}}	1672924692300	1672924692300	0	\N	system		system	bwzfh6d1x3fr8zb8gfxba65kjah
aj1oizrnd5inifd4ea4pm61nmse	2023-01-05 13:18:12.257888+00	cm6jhium31insino6coq8rziyja	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1672924692306	1672924692306	0	\N	system		system	bwzfh6d1x3fr8zb8gfxba65kjah
ay889a3xr5pyixgudjd6mu4pmyy	2023-01-05 13:18:12.257888+00	czypouqqwyjbkfjkx1sypp5j4ka	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1672924692317	1672924692317	0	\N	system		system	bwzfh6d1x3fr8zb8gfxba65kjah
aiwabx71igfnhje9j39ytd4t1nh	2023-01-05 13:18:12.257888+00	ceedjswwfqpftukmtrnwhjojrwc	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1672924692325	1672924692325	0	\N	system		system	bwzfh6d1x3fr8zb8gfxba65kjah
akf1dh4iq8prxifriwoq96s1suy	2023-01-05 13:18:12.257888+00	cckr9sxx73tfe9pksy8ipudfzfh	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n\n## Weaknesses\n- ...\n- ...\n\n## Opportunities\n- ...\n- ...\n\n## Threats\n- ...\n- ...	{}	1672924692331	1672924692331	0	\N	system		system	bwzfh6d1x3fr8zb8gfxba65kjah
auacrd8btk3nop8uf5frcd3ro4o	2023-01-05 13:18:12.257888+00	cxp4qfkegp7byi8bkpztnb33cfe	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1672924692339	1672924692339	0	\N	system		system	bwzfh6d1x3fr8zb8gfxba65kjah
cmt53wtfcutnodngaif13xebxjr	2023-01-05 13:18:12.451033+00	brs9cdimfw7fodyi7erqt747rhc	1	card	New Project and Workflow Management Solutions for Developers	{"contentOrder":["71qhnzuec6esdi6fnynwpze4xya","afmba3c9ngfyhjnkefi3o5mfcto"],"icon":"🎯","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1645790400000}","ab6mbock6styfe6htf815ph1mhw":["a8xceonxiu4n3c43szhskqizicr","a3pdzi53kpbd4okzdkz6khi87zo","a3d9ux4fmi3anyd11kyipfbhwde"],"ae9ar615xoknd8hw8py7mbyr7zo":"awna1nuarjca99m9s4uiy9kwj5h","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://mattermost.com/newsroom/press-releases/mattermost-launches-new-project-and-workflow-management-solutions-for-developers/","aysx3atqexotgwp5kx6h5i5ancw":"aywiofmmtd3ofgzj95ysky4pjga"}}	1672924692462	1672924692462	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
cqg5ajzp4kbr4tbnukkn5own69a	2023-01-05 13:18:12.451033+00	brs9cdimfw7fodyi7erqt747rhc	1	card	[Tweet] Mattermost v6.1 includes card @-mention notifications in Boards	{"contentOrder":["7i96m7nbsdsex8n6hzuzrmdfjuy","7ed5bwp3gr8yax3mhtuwiaa9gjy","ahhm75n8oxfriik5qafjmuaf99o","af3ryrnj6n3yqdymhfemob9xnfa","abdasiyq4k7ndtfrdadrias8sjy","7uzr864r987rad85fzswweb8qsy"],"icon":"🐤","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1639051200000}","ab6mbock6styfe6htf815ph1mhw":["az8o8pfe9hq6s7xaehoqyc3wpyc"],"ae9ar615xoknd8hw8py7mbyr7zo":"a9ana1e9w673o5cp8md4xjjwfto","agqsoiipowmnu9rdwxm57zrehtr":"{\\"from\\":1637668800000}","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://twitter.com/Mattermost/status/1463145633162969097?s=20","aysx3atqexotgwp5kx6h5i5ancw":"aj8y675weso8kpb6eceqbpj4ruw"}}	1672924692469	1672924692469	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
cqgo1rgh4jpdmikoe6tug46huhh	2023-01-05 13:18:12.451033+00	brs9cdimfw7fodyi7erqt747rhc	1	card	Top 10 Must-Have DevOps Tools in 2021	{"contentOrder":["7fo1utqc8x1z1z6hzg33hes1ktc","axui9zb4g7jgcxqre6x6e43apqa"],"icon":"🛠️","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1636113600000}","ab6mbock6styfe6htf815ph1mhw":["a8xceonxiu4n3c43szhskqizicr"],"ae9ar615xoknd8hw8py7mbyr7zo":"a9ana1e9w673o5cp8md4xjjwfto","agqsoiipowmnu9rdwxm57zrehtr":"{\\"from\\":1637323200000}","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://www.toolbox.com/tech/devops/articles/best-devops-tools/","aysx3atqexotgwp5kx6h5i5ancw":"a3xky7ygn14osr1mokerbfah5cy"}}	1672924692475	1672924692475	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
c6eagmasydp8sbecdjmqt9gba3c	2023-01-05 13:18:12.87149+00	bui5izho7dtn77xg3thkiqprc9r	1	card	App crashing	{"contentOrder":["79t7rkiuspeneqi9xurou9tqzwh","and3sqp9cnidhibgpf9sbnbzhxe","anwog7znmrbyuxp8nfmkxd6ouic","7u1e843j9s7d7ir4mabs6za7tac"],"icon":"📉","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"1fdbb515-edd2-4af5-80fc-437ed2211a49","50117d52-bcc7-4750-82aa-831a351c44a0":"ec6d2bc5-df2b-4f77-8479-e59ceb039946","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"cb8ecdac-38be-4d36-8712-c4d58cc8a8e9"}}	1672924692882	1672924692882	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
c55srt19grbgkik9a1s1rrbij3r	2023-01-05 13:18:12.451033+00	brs9cdimfw7fodyi7erqt747rhc	1	card	Unblocking Workflows: The Guide to Developer Productivity	{"contentOrder":["77tz16jtz5x73ncs3dxc3fp1d7h","amkdzeei5binwfc65pfb1xgizco"],"icon":"💻","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1638532800000}","ab6mbock6styfe6htf815ph1mhw":["a3pdzi53kpbd4okzdkz6khi87zo"],"ae9ar615xoknd8hw8py7mbyr7zo":"apy9dcd7zmand615p3h53zjqxjh","agqsoiipowmnu9rdwxm57zrehtr":"{\\"from\\":1639483200000}","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://mattermost.com/newsroom/press-releases/mattermost-unveils-definitive-report-on-the-state-of-developer-productivity-unblocking-workflows-the-guide-to-developer-productivity-2022-edition/","aysx3atqexotgwp5kx6h5i5ancw":"a3xky7ygn14osr1mokerbfah5cy"}}	1672924692478	1672924692478	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
vr8hpextju7d7zfk5wha7a77c8y	2023-01-05 13:18:12.451033+00	brs9cdimfw7fodyi7erqt747rhc	1	view	By Status	{"cardOrder":[null,"cdbfkd15d6iy18rgx1tskmfsr6c","cn8yofg9rtkgmzgmb5xdi56p3ic","csgsnnywpuqzs5jgq87snk9x17e","cqwaytore5y487wdu8zffppqnea",null],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["awna1nuarjca99m9s4uiy9kwj5h","a9ana1e9w673o5cp8md4xjjwfto","apy9dcd7zmand615p3h53zjqxjh","acri4cm3bmay55f7ksztphmtnga","amsowcd9a8e1kid317r7ttw6uzh",""],"visiblePropertyIds":["ab6mbock6styfe6htf815ph1mhw"]}	1672924692482	1672924692482	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
vuio6u3spgbns5f5perkasojzny	2023-01-05 13:18:12.451033+00	brs9cdimfw7fodyi7erqt747rhc	1	view	Due Date Calendar	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"a39x5cybshwrbjpc3juaakcyj6e","defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1672924692486	1672924692486	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
vit3jujmfn3dj5kfc456oh8caoo	2023-01-05 13:18:12.451033+00	brs9cdimfw7fodyi7erqt747rhc	1	view	Publication Calendar	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"agqsoiipowmnu9rdwxm57zrehtr","defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1672924692490	1672924692490	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
v7qtpgchp5tdcbngqecz4qn16ec	2023-01-05 13:18:12.451033+00	brs9cdimfw7fodyi7erqt747rhc	1	view	Content List	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":322,"ab6mbock6styfe6htf815ph1mhw":229,"aysx3atqexotgwp5kx6h5i5ancw":208},"defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"a39x5cybshwrbjpc3juaakcyj6e","reversed":false}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["ae9ar615xoknd8hw8py7mbyr7zo","aysx3atqexotgwp5kx6h5i5ancw","ab6mbock6styfe6htf815ph1mhw","ao44fz8nf6z6tuj1x31t9yyehcc","a39x5cybshwrbjpc3juaakcyj6e","agqsoiipowmnu9rdwxm57zrehtr","ap4e7kdg7eip7j3c3oyiz39eaoc"]}	1672924692495	1672924692495	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
afmba3c9ngfyhjnkefi3o5mfcto	2023-01-05 13:18:12.451033+00	cmt53wtfcutnodngaif13xebxjr	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1672924692500	1672924692500	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
7uzr864r987rad85fzswweb8qsy	2023-01-05 13:18:12.451033+00	cqg5ajzp4kbr4tbnukkn5own69a	1	image		{"fileId":"7y5kr8x8ybpnwdykjfuz57rggrh.png"}	1672924692506	1672924692506	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
ahhm75n8oxfriik5qafjmuaf99o	2023-01-05 13:18:12.451033+00	cqg5ajzp4kbr4tbnukkn5own69a	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1672924692511	1672924692511	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
af3ryrnj6n3yqdymhfemob9xnfa	2023-01-05 13:18:12.451033+00	cqg5ajzp4kbr4tbnukkn5own69a	1	text	## Media	{}	1672924692515	1672924692515	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
apcob6b59h7gw8deo55xg93ix6r	2023-01-05 13:18:12.451033+00	cff1jmrxfrirgbeebhr9qd7nida	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1672924692523	1672924692523	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
ae43fckijs7feujskx7pqj3qr6r	2023-01-05 13:18:12.451033+00	cff1jmrxfrirgbeebhr9qd7nida	1	text	## Research\n- ...\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n- ...\n\n## Notes\n- ...\n- ...\n- ...	{}	1672924692532	1672924692532	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
aanguuc44ybbbzjyjfy1w49rrsc	2023-01-05 13:18:12.451033+00	cff1jmrxfrirgbeebhr9qd7nida	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1672924692540	1672924692540	0	\N	system		system	bsw5maeiywtra5q79ms9ip59msa
v1qpind9zdifqzrk9c4po6srbge	2023-01-05 13:18:12.730276+00	bjbhs6bos3m8zjouf78xceg9nqw	1	view	Board view	{"cardOrder":["cniwb8xwcqtbstbcm3sdfrr854h","cs4qwpzr65fgttd7364dicskanh","c9s78pzbdg3g4jkcdjqahtnfejc","c8utmazns878jtfgtf7exyi9pee","cnobejmb6bf8e3c1w7em5z4pwyh"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["aok6pgecm85qe9k5kcphzoe63ma","aq1dwbf661yx337hjcd5q3sbxwa","ar87yh5xmsswqkxmjq1ipfftfpc","akj3fkmxq7idma55mdt8sqpumyw"],"visiblePropertyIds":["aspaay76a5wrnuhtqgm97tt3rer"]}	1672924692744	1672924692744	0	\N	system		system	bomnbp7on3pfdtpby8bpzcesf8w
cjnntjxru7tfnfjxkxxnms1a1ic	2023-01-05 13:18:12.730276+00	bsjd59qtpbf888mqez3ge77domw	1	card	Tight deadline	{"contentOrder":[],"icon":"📅","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"ar87yh5xmsswqkxmjq1ipfftfpc"}}	1672924692753	1672924692753	0	\N	system		system	bomnbp7on3pfdtpby8bpzcesf8w
ct8fxw5gsziyujdxs9x7siuwpqy	2023-01-05 13:18:12.730276+00	bsjd59qtpbf888mqez3ge77domw	1	card	Team communication	{"contentOrder":[],"icon":"💬","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"aq1dwbf661yx337hjcd5q3sbxwa"}}	1672924692763	1672924692763	0	\N	system		system	bomnbp7on3pfdtpby8bpzcesf8w
cw7epsnzfntfg8d8g9r73rp6g4y	2023-01-05 13:18:12.730276+00	bsjd59qtpbf888mqez3ge77domw	1	card	Reschedule planning meeting	{"contentOrder":[],"icon":"🗓️","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"aok6pgecm85qe9k5kcphzoe63ma"}}	1672924692771	1672924692771	0	\N	system		system	bomnbp7on3pfdtpby8bpzcesf8w
cheiau4h4njntf89oi9mggqemhh	2023-01-05 13:18:12.730276+00	bsjd59qtpbf888mqez3ge77domw	1	card	Schedule more time for testing	{"contentOrder":[],"icon":"🧪","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"akj3fkmxq7idma55mdt8sqpumyw"}}	1672924692778	1672924692778	0	\N	system		system	bomnbp7on3pfdtpby8bpzcesf8w
cbwd4fsf7zi8c5e3jo48ys3je5y	2023-01-05 13:18:12.730276+00	bsjd59qtpbf888mqez3ge77domw	1	card	Positive user feedback	{"contentOrder":[],"icon":"🥰","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"aq1dwbf661yx337hjcd5q3sbxwa"}}	1672924692787	1672924692787	0	\N	system		system	bomnbp7on3pfdtpby8bpzcesf8w
ce91q5c5zwjr5i8km6e53au3qcy	2023-01-05 13:18:12.87149+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Calendar view	{"contentOrder":["7df11783ny67mdnognqae31ax6y","atfbkw1wuntyhtqswfsegj14hew"],"icon":"📆","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"6eea96c9-4c61-4968-8554-4b7537e8f748","50117d52-bcc7-4750-82aa-831a351c44a0":"849766ba-56a5-48d1-886f-21672f415395","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1672924692888	1672924692887	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
c9k4wegbc8j8xmnqth9skxd3t8w	2023-01-05 13:18:12.87149+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Standard templates	{"contentOrder":["7uonmjk41nipnrsi6tz8wau5ssh","a5j43dzy68td63jkppxw7f5oatr"],"icon":"🗺️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"6eea96c9-4c61-4968-8554-4b7537e8f748","50117d52-bcc7-4750-82aa-831a351c44a0":"ec6d2bc5-df2b-4f77-8479-e59ceb039946","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1672924692892	1672924692892	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
ck618a41yo785mjzd3d18j9s7oa	2023-01-05 13:18:12.87149+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Import / Export	{"contentOrder":["aac9gqfnetfrgzrpecwn81b6bcw"],"icon":"🚢","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"6eea96c9-4c61-4968-8554-4b7537e8f748","50117d52-bcc7-4750-82aa-831a351c44a0":"ec6d2bc5-df2b-4f77-8479-e59ceb039946","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1672924692896	1672924692896	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
ctd4fs1mtgpfjujqtb9rrtwm4gy	2023-01-05 13:18:12.87149+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Review API design	{"contentOrder":["atgf5bk1x4bfazjfd367tpfrmoe"],"icon":"🛣️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"424ea5e3-9aa1-4075-8c5c-01b44b66e634","50117d52-bcc7-4750-82aa-831a351c44a0":"8c557f69-b0ed-46ec-83a3-8efab9d47ef5","60985f46-3e41-486e-8213-2b987440ea1c":"14892380-1a32-42dd-8034-a0cea32bc7e6","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"c62172ea-5da7-4dec-8186-37267d8ee9a7"}}	1672924692900	1672924692900	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
cugps7oe44pd79muo7czww6cdth	2023-01-05 13:18:12.87149+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Icons don't display	{"contentOrder":["ab4e7hxz8cigr9dk5d3wt8wnwry","a1quczo73ui8hbr44btmudke9xh","73t731shun7rumfbnp99ktb3oaw"],"icon":"💻","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"1fdbb515-edd2-4af5-80fc-437ed2211a49","50117d52-bcc7-4750-82aa-831a351c44a0":"8c557f69-b0ed-46ec-83a3-8efab9d47ef5","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1672924692906	1672924692906	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
va67hxe5qg78quxo5gsmgtr4mwc	2023-01-05 13:18:12.87149+00	bui5izho7dtn77xg3thkiqprc9r	1	view	Calendar View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"a4378omyhmgj3bex13sj4wbpfiy","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1672924692910	1672924692910	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
ai19abeop4pgspc9yq1c8319iwh	2023-01-05 13:18:12.87149+00	cidz4imnqhir48brz6e8hxhfrhy	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1672924693009	1672924693009	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
ahzutx47zntddtchrt7tm8zba4c	2023-01-05 13:18:12.87149+00	cidz4imnqhir48brz6e8hxhfrhy	1	text	## Requirements\n- [Requirement 1]\n- [Requirement 2]\n- ...	{}	1672924693014	1672924693014	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
vxc48htzaipbbu8h7fppqu3ptdw	2023-01-05 13:18:12.87149+00	bui5izho7dtn77xg3thkiqprc9r	1	view	Board: Sprints	{"cardOrder":["c6eagmasydp8sbecdjmqt9gba3c","ce91q5c5zwjr5i8km6e53au3qcy","c9k4wegbc8j8xmnqth9skxd3t8w","cugps7oe44pd79muo7czww6cdth","ck618a41yo785mjzd3d18j9s7oa","ctd4fs1mtgpfjujqtb9rrtwm4gy"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"60985f46-3e41-486e-8213-2b987440ea1c","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["c01676ca-babf-4534-8be5-cce2287daa6c","ed4a5340-460d-461b-8838-2c56e8ee59fe","14892380-1a32-42dd-8034-a0cea32bc7e6",""],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1672924692916	1672924692916	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
v7acgy1g59pnodm655d9d4trekh	2023-01-05 13:18:12.87149+00	bui5izho7dtn77xg3thkiqprc9r	1	view	List: Tasks 🔨	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"50117d52-bcc7-4750-82aa-831a351c44a0":139,"__title":280},"defaultTemplateId":"","filter":{"filters":[{"condition":"includes","propertyId":"20717ad3-5741-4416-83f1-6f133fff3d11","values":["6eea96c9-4c61-4968-8554-4b7537e8f748"]}],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"50117d52-bcc7-4750-82aa-831a351c44a0","reversed":true}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["50117d52-bcc7-4750-82aa-831a351c44a0","20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1672924692923	1672924692923	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
vud76uokugiypzjpeb6bqf4mzfr	2023-01-05 13:18:12.87149+00	bui5izho7dtn77xg3thkiqprc9r	1	view	Board: Status	{"cardOrder":["c6eagmasydp8sbecdjmqt9gba3c","cm4w7cc3aac6s9jdcujbs4j8f4r","c6egh6cpnj137ixdoitsoxq17oo","cct9u78utsdyotmejbmwwg66ihr","cmft87it1q7yebbd51ij9k65xbw","c9fe77j9qcruxf4itzib7ag6f1c","coup7afjknqnzbdwghiwbsq541w","c5ex1hndz8qyc8gx6ofbfeksftc"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cidz4imnqhir48brz6e8hxhfrhy","filter":{"filters":[],"operation":"and"},"groupById":"50117d52-bcc7-4750-82aa-831a351c44a0","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["8c557f69-b0ed-46ec-83a3-8efab9d47ef5","ec6d2bc5-df2b-4f77-8479-e59ceb039946","849766ba-56a5-48d1-886f-21672f415395",""],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1672924692928	1672924692928	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
a5umu1drucfn9zjxr3ta78xsbzo	2023-01-05 13:18:13.314902+00	c68jnqiqjyb8rzpsssydoa35qoh	1	text	After you've copied the link, paste it into any channel or Direct Message to share the card. A preview of the card will display within the channel with a link back to the card on Boards.	{}	1672924693522	1672924693522	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
vgkapxma4gibjbjxadt1hhfuowr	2023-01-05 13:18:12.87149+00	bui5izho7dtn77xg3thkiqprc9r	1	view	List: Bugs 🐞	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"50117d52-bcc7-4750-82aa-831a351c44a0":145,"__title":280},"defaultTemplateId":"","filter":{"filters":[{"condition":"includes","propertyId":"20717ad3-5741-4416-83f1-6f133fff3d11","values":["1fdbb515-edd2-4af5-80fc-437ed2211a49"]}],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["50117d52-bcc7-4750-82aa-831a351c44a0","20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1672924692934	1672924692934	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
7u1e843j9s7d7ir4mabs6za7tac	2023-01-05 13:18:12.87149+00	c6eagmasydp8sbecdjmqt9gba3c	1	image		{"fileId":"77pe9r4ckbin438ph3f18bpatua.png"}	1672924692940	1672924692940	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
and3sqp9cnidhibgpf9sbnbzhxe	2023-01-05 13:18:12.87149+00	c6eagmasydp8sbecdjmqt9gba3c	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1672924692948	1672924692948	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
anwog7znmrbyuxp8nfmkxd6ouic	2023-01-05 13:18:12.87149+00	c6eagmasydp8sbecdjmqt9gba3c	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1672924692957	1672924692957	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
atfbkw1wuntyhtqswfsegj14hew	2023-01-05 13:18:12.87149+00	ce91q5c5zwjr5i8km6e53au3qcy	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1672924692964	1672924692964	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
a5j43dzy68td63jkppxw7f5oatr	2023-01-05 13:18:12.87149+00	c9k4wegbc8j8xmnqth9skxd3t8w	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1672924692972	1672924692972	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
7qgehoy1x4jr35b9es6a8sdqrye	2023-01-05 13:18:12.87149+00	cfefgwjke6bbxpjpig618g9bpte	1	image		{"fileId":"7pbp4qg415pbstc6enzeicnu3qh.png"}	1672924692978	1672924692978	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
aomm6ppnyeifhuyfjunft8677jr	2023-01-05 13:18:12.87149+00	cfefgwjke6bbxpjpig618g9bpte	1	text	## Screenshots\nIf applicable, add screenshots to elaborate on the problem.	{}	1672924692984	1672924692984	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
ado7qf184mpfqbx4dmf6n87wbia	2023-01-05 13:18:12.87149+00	cfefgwjke6bbxpjpig618g9bpte	1	text	## Steps to reproduce the behavior\n\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n\nA clear and concise description of what you expected to happen.\n\n## Edition and Platform\n\n - Edition: Personal Desktop / Personal Server / Mattermost plugin\n - Version: [e.g. v0.9.0]\n - Browser and OS: [e.g. Chrome 91 on macOS, Edge 93 on Windows]\n\n## Additional context\n\nAdd any other context about the problem here.	{}	1672924692991	1672924692991	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
a86toi7ajnp8bpyykgwwf8zbkco	2023-01-05 13:18:12.87149+00	cfefgwjke6bbxpjpig618g9bpte	1	text	## Steps to reproduce the behavior\n\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n\n*[A clear and concise description of what you expected to happen.]*\n\n## Screenshots\n\n*[If applicable, add screenshots to elaborate on the problem.]*\n\n## Edition and Platform\n\n - Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n - Version: *[e.g. v0.9.0]*\n - Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n\n*[Add any other context about the problem here.]*	{}	1672924692996	1672924692996	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
aac9gqfnetfrgzrpecwn81b6bcw	2023-01-05 13:18:12.87149+00	ck618a41yo785mjzd3d18j9s7oa	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1672924693002	1672924693002	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
atgf5bk1x4bfazjfd367tpfrmoe	2023-01-05 13:18:12.87149+00	ctd4fs1mtgpfjujqtb9rrtwm4gy	1	text	## Summary\n*[Brief description of what this epic is about]*\n\n## Motivation\n*[Brief description on why this is needed]*\n\n## Acceptance Criteria\n - *[Criteron 1]*\n - *[Criteron 2]*\n - ...\n\n## Personas\n - *[Persona A]*\n - *[Persona B]*\n - ...\n\n## Reference Materials\n - *[Links to other relevant documents as needed]*\n - ...	{}	1672924693020	1672924693020	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
73t731shun7rumfbnp99ktb3oaw	2023-01-05 13:18:12.87149+00	cugps7oe44pd79muo7czww6cdth	1	image		{"fileId":"7pbp4qg415pbstc6enzeicnu3qh.png"}	1672924693027	1672924693027	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
a1quczo73ui8hbr44btmudke9xh	2023-01-05 13:18:12.87149+00	cugps7oe44pd79muo7czww6cdth	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1672924693039	1672924693039	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
ab4e7hxz8cigr9dk5d3wt8wnwry	2023-01-05 13:18:12.87149+00	cugps7oe44pd79muo7czww6cdth	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1672924693055	1672924693055	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
aw1wn1tmq1ifmmdmbjz1cp7ww4a	2023-01-05 13:18:12.87149+00	cwrq9ag3p5pgzzy98nfd3wwra1w	1	text	## Summary\n*[Brief description of what this epic is about]*\n## Motivation\n*[Brief description on why this is needed]*\n## Acceptance Criteria\n- *[Criteron 1]*\n- *[Criteron 2]*\n- ...\n## Personas\n- *[Persona A]*\n- *[Persona B]*\n- ...\n## Reference Materials\n- *[Links to other relevant documents as needed]*\n- ...	{}	1672924693065	1672924693065	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
aj1igczq17ib3zkzapwjuht3h7e	2023-01-05 13:18:12.87149+00	cwrq9ag3p5pgzzy98nfd3wwra1w	1	text	## Summary\n[Brief description of what this epic is about]\n\n## Motivation\n[Brief description on why this is needed]\n\n## Acceptance Criteria\n - [Criteron 1]\n - [Criteron 2]\n - ...\n\n## Personas\n - [Persona A]\n - [Persona B]\n - ...\n\n## Reference Materials\n - [Links to other relevant documents as needed]\n - ...	{}	1672924693071	1672924693071	0	\N	system		system	b89qgwoopj7r6iemxatthhb8ynw
atrwubb6yof8rzqspy3udcz5gph	2023-01-05 13:18:13.314902+00	c68jnqiqjyb8rzpsssydoa35qoh	1	text	To share a card, you'll need to copy the card link first. You can:\n\n- Open a card and select the options menu button at the top right of the card.\n- Open the board view and hover your mouse over any card to access the options menu button.	{}	1672924693527	1672924693527	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
cmtkcampr33fxfqajdg566eifyo	2023-01-05 13:18:13.314902+00	buixxjic3xjfkieees4iafdrznc	1	card	Drag cards	{"contentOrder":["apktbgtee5jb8xrnqy3ibiujxew","aa6hukwhhcfgytyd8um1w87xcdc"],"icon":"🤏","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#dragging-cards","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1672924693323	1672924693323	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
chjd4w5fxcfgf9euj74zcxwdtdo	2023-01-05 13:18:13.314902+00	buixxjic3xjfkieees4iafdrznc	1	card	Manage tasks with cards	{"contentOrder":["a4zw8644qabgn9jod71d66ri8fo","7uzwzjayawbnpprzuhf8zecpo9c","7tzurgs5mwjd8pc3qka9ojeaxba","784uu3ufcgb878ky7hyugmf6xcw","76jzdfdjw33fc9r6wdqbfuspzde","794wkegbnt7fxfps4zfpr9kq9na","7yis6kg4ofjgytb6x3uqto47amh","7nb8y7jyoetro8cd36qcju53z8c","75pnrn1jdw7dbxj15ziuxkyz5oc","79arebkh1t3ge3gwwno8iz7gozo","76nwb9tqfsid5jx46yw34itqima","7dy3mcgzgybf1ifa3emgewkzj7e","a5ca6tii33bfw8ba36y1rswq3he","7876od6xhffr6fy69zeogag7eyw","7x7bq9awkatbm5x4docbh5gaw4y","7ghpx9qff43dgtke1rwidmge1ho","7nb8y7jyoetro8cd36qcju53z8c","7hdyxemhbytfm3m83g88djq9nhr","7pgnejxokubbe9kdrxj6g9qa41e","7hw9z6qtx8jyizkmm9g5yq3gxcy","7gk6ooz6npbb8by5rgp9aig7tua","7g6w8mxth1tbi8grnmpkkiiwoah"],"icon":"☑️","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"amm6wfhnbuxojwssyftgs9dipqe","acypkejeb5yfujhj9te57p9kaxw":"aanaehcw3m13jytujsjk5hpf6ry"}}	1672924693327	1672924693327	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
crgryu1mz1ifw9bi9y8eypg639y	2023-01-05 13:18:13.314902+00	buixxjic3xjfkieees4iafdrznc	1	card	Create your own board	{"contentOrder":["aqqq44myoq3bytetg8dkny71zah","acnd936gtg7biue6iqrqm4g1tkw","7r9my1yuddbn45dojrfht3neg8c","7eir5gdjxgjbsxpbyp3df4npcze","7rfs4intj4tfp5fb3kc3hzmeper"],"icon":"📋","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#adding-new-boards","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"amm6wfhnbuxojwssyftgs9dipqe","acypkejeb5yfujhj9te57p9kaxw":"aanaehcw3m13jytujsjk5hpf6ry"}}	1672924693332	1672924693332	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
c4j5mdjzu7ibgiqy9usqpysgkpw	2023-01-05 13:18:13.314902+00	buixxjic3xjfkieees4iafdrznc	1	card	Share a board	{"contentOrder":["aaiwtagtnaid7zcpfhqbwmwqhro","azfuwnqnagiriz8exm3gq6bb8ce","7r7asyew8d7fyunf4sow8e5iyoc","ad8j3n8tp77bppee3ipjt6odgpe","7w935usqt6pby8qz9x5pxaj7iow","7ogbs8h6q4j8z7ngy1m7eag63nw","7z1jau5qy3jfcxdp5cgq3duk6ne","7q5t75g5mfbdhjyiqewgkng1zhr"],"icon":"📤","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/sharing-boards.html","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1672924693336	1672924693336	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
cbx789k4b9pn9ibensfy1ntf3ra	2023-01-05 13:18:13.314902+00	buixxjic3xjfkieees4iafdrznc	1	card	Create a new card	{"contentOrder":["atr485n34hjyufcsnteo39yzfgh","adhsx4h5ss7rqdcjt8xyam6xtqc","afm8hkgpk6pgc3q7fzt6mcp1rih","7me9p46gbqiyfmfnapi7dyxb5br","7yja7ojo1w7fgub4i7ajiy8egey"],"icon":"📝","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#adding-cards","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"amm6wfhnbuxojwssyftgs9dipqe","acypkejeb5yfujhj9te57p9kaxw":"aanaehcw3m13jytujsjk5hpf6ry"}}	1672924693341	1672924693341	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
c68jnqiqjyb8rzpsssydoa35qoh	2023-01-05 13:18:13.314902+00	buixxjic3xjfkieees4iafdrznc	1	card	Share cards on Channels	{"contentOrder":["agc6mebe5k7gmuc9cf7mfr3ei4r","atrwubb6yof8rzqspy3udcz5gph","a5umu1drucfn9zjxr3ta78xsbzo","7ppwiwaxoyfnezyze3eb7tuoe1h"],"icon":"📮","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html#share-card-previews","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"af3p8ztcyxgn8wd9z4az7o9tjeh","acypkejeb5yfujhj9te57p9kaxw":"ascd7nm9r491ayot8i86g1gmgqw"}}	1672924693345	1672924693345	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
ca6779z9sp3gkxnhttsi87cc3ee	2023-01-05 13:18:13.314902+00	buixxjic3xjfkieees4iafdrznc	1	card	Filter and sort cards	{"contentOrder":["a4fz9kcfs9ibj8puk9mux7ac94c","afsuxsmhisig9b8oshw6ttthybc","78i8aqjmqtibr7x4okhz6uqquqr","7we8qh6cnk7njfqrtkhe9ref1do"],"icon":"🎛️","isTemplate":false,"properties":{"a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1672924693350	1672924693350	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
aqqq44myoq3bytetg8dkny71zah	2023-01-05 13:18:13.314902+00	crgryu1mz1ifw9bi9y8eypg639y	1	text	A board helps you manage your project, organize tasks, and collaborate with your team all in one place.	{}	1672924693479	1672924693479	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
cph49auqcnp89tkj8ewhn18fbdc	2023-01-05 13:18:13.314902+00	buixxjic3xjfkieees4iafdrznc	1	card	Create a new view	{"contentOrder":["aozbezukpgif3jpbsq7tahmmp5e","aes6itqd7bibg5bj3tfqsf5ub8e","7owai1ux3h3gtf8byynfk6hyx1c","7n8jq1dizyfgotby3o91arf1hxh","77y4wffj1ctg7xmm9bx45qn6q6o","78aetf7whm7b77bf4c6cwopru1o"],"icon":"👓","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#adding-new-views","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"af3p8ztcyxgn8wd9z4az7o9tjeh","acypkejeb5yfujhj9te57p9kaxw":"ascd7nm9r491ayot8i86g1gmgqw"}}	1672924693355	1672924693355	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
cknwsb8ydwfg9meo47cagtfejhh	2023-01-05 13:18:13.314902+00	buixxjic3xjfkieees4iafdrznc	1	card	Add new properties	{"contentOrder":["ax55zfmg36irmujxdu7mmi8jciy","ayhk11qsuz789fk8bqae4oz8mro","7gc3z8cf8rirgfyutwoke9nn6jy","76cinqnb6k3dzmfbm9fnc8eofny","7db1qh8up4jbxjpjh8jko3b574y"],"icon":"🏷️","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html#add-and-manage-properties","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"af3p8ztcyxgn8wd9z4az7o9tjeh","acypkejeb5yfujhj9te57p9kaxw":"ascd7nm9r491ayot8i86g1gmgqw"}}	1672924693360	1672924693360	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
cqh6oczxk6tn9tf836qtk7qwc4r	2023-01-05 13:18:13.314902+00	buixxjic3xjfkieees4iafdrznc	1	card	@mention teammates	{"contentOrder":["aws4m776wgtd7xy7st6e6pxfy1a","apsy1grew9pr7tkxi3fzyox4y9o","7mbw9t71hjbrydgzgkqqaoh8usr","7j89d11qegjr49x66uen1ic9w6a"],"icon":"🔔","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html#mention-people","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1672924693365	1672924693365	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
v49fi3p4nytg1bdit1syg1z5apr	2023-01-05 13:18:13.314902+00	buixxjic3xjfkieees4iafdrznc	1	view	Preview: Table View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":280,"a972dc7a-5f4c-45d2-8044-8c28c69717f1":100,"acypkejeb5yfujhj9te57p9kaxw":169},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a972dc7a-5f4c-45d2-8044-8c28c69717f1","aqh13jabwexjkzr3jqsz1i1syew","acmg7mz1rr1eykfug4hcdpb1y1o","acypkejeb5yfujhj9te57p9kaxw"]}	1672924693372	1672924693372	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
vc8r54mexqpfszx6gb6y91xg7yh	2023-01-05 13:18:13.314902+00	buixxjic3xjfkieees4iafdrznc	1	view	Preview: Calendar View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"acmg7mz1rr1eykfug4hcdpb1y1o","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1672924693376	1672924693376	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
v1dp6nncawpn19ni1ircfdb3mcy	2023-01-05 13:18:13.314902+00	buixxjic3xjfkieees4iafdrznc	1	view	Preview: Gallery View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"gallery","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1672924693381	1672924693381	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
vey6f6huk1i848qhtw53noibh4y	2023-01-05 13:18:13.314902+00	buixxjic3xjfkieees4iafdrznc	1	view	Onboarding	{"cardOrder":["cbx789k4b9pn9ibensfy1ntf3ra","chjd4w5fxcfgf9euj74zcxwdtdo","crgryu1mz1ifw9bi9y8eypg639y","c68jnqiqjyb8rzpsssydoa35qoh","cknwsb8ydwfg9meo47cagtfejhh","cph49auqcnp89tkj8ewhn18fbdc","cqh6oczxk6tn9tf836qtk7qwc4r","cmtkcampr33fxfqajdg566eifyo","c4j5mdjzu7ibgiqy9usqpysgkpw","ca6779z9sp3gkxnhttsi87cc3ee"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a972dc7a-5f4c-45d2-8044-8c28c69717f1","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["aqb5x3pt87dcc9stbk4ofodrpoy","a1mtm777bkagq3iuu7xo9b13qfr","auxbwzptiqzkii5r61uz3ndsy1r","aj9386k1bx8qwmepeuxg3b7z4pw"],"visiblePropertyIds":[]}	1672924693387	1672924693387	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
aa6hukwhhcfgytyd8um1w87xcdc	2023-01-05 13:18:13.314902+00	cmtkcampr33fxfqajdg566eifyo	1	text	Mattermost Boards makes it easy for you to update certain properties on cards through our drag and drop functionality. Simply drag this card from the **Later** column to the **Completed** column to automatically update the status and mark this task as complete.	{}	1672924693393	1672924693393	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
76jzdfdjw33fc9r6wdqbfuspzde	2023-01-05 13:18:13.314902+00	chjd4w5fxcfgf9euj74zcxwdtdo	1	checkbox	Assign tasks to teammates	{"value":false}	1672924693398	1672924693398	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
7g6w8mxth1tbi8grnmpkkiiwoah	2023-01-05 13:18:13.314902+00	chjd4w5fxcfgf9euj74zcxwdtdo	1	checkbox	Create and manage checklists, like this one... :)	{"value":false}	1672924693404	1672924693404	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
794wkegbnt7fxfps4zfpr9kq9na	2023-01-05 13:18:13.314902+00	chjd4w5fxcfgf9euj74zcxwdtdo	1	checkbox	Add and update descriptions with Markdown	{"value":false}	1672924693409	1672924693409	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
75pnrn1jdw7dbxj15ziuxkyz5oc	2023-01-05 13:18:13.314902+00	chjd4w5fxcfgf9euj74zcxwdtdo	1	checkbox	Follow cards to get notified on the latest updates	{"value":false}	1672924693415	1672924693415	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
7uzwzjayawbnpprzuhf8zecpo9c	2023-01-05 13:18:13.314902+00	chjd4w5fxcfgf9euj74zcxwdtdo	1	checkbox	Set priorities and update statuses	{"value":false}	1672924693421	1672924693421	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
7yis6kg4ofjgytb6x3uqto47amh	2023-01-05 13:18:13.314902+00	chjd4w5fxcfgf9euj74zcxwdtdo	1	checkbox	Provide feedback and ask questions via comments	{"value":false}	1672924693431	1672924693431	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
79arebkh1t3ge3gwwno8iz7gozo	2023-01-05 13:18:13.314902+00	chjd4w5fxcfgf9euj74zcxwdtdo	1	checkbox	@mention teammates so they can follow, and collaborate on, comments and descriptions	{"value":false}	1672924693459	1672924693459	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
7tzurgs5mwjd8pc3qka9ojeaxba	2023-01-05 13:18:13.314902+00	chjd4w5fxcfgf9euj74zcxwdtdo	1	checkbox	Manage deadlines and milestones	{"value":false}	1672924693464	1672924693464	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
a4zw8644qabgn9jod71d66ri8fo	2023-01-05 13:18:13.314902+00	chjd4w5fxcfgf9euj74zcxwdtdo	1	text	Cards allow your entire team to manage and collaborate on a task in one place. Within a card, your team can:	{}	1672924693469	1672924693469	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
7rfs4intj4tfp5fb3kc3hzmeper	2023-01-05 13:18:13.314902+00	crgryu1mz1ifw9bi9y8eypg639y	1	image		{"fileId":"74uia99m9btr8peydw7oexn37tw.gif"}	1672924693474	1672924693474	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
acnd936gtg7biue6iqrqm4g1tkw	2023-01-05 13:18:13.314902+00	crgryu1mz1ifw9bi9y8eypg639y	1	text	To create your own board, select the "+" on the top of the left hand sidebar. Choose from one of our standard templates and see how they can help you get started with your next project:\n\n- **Project Tasks**: Stay on top of your project tasks, track progress, and set priorities. \n- **Meeting Agenda**: Set your meeting agendas for recurring team meetings and 1:1s.\n- **Roadmap**: Plan your roadmap and manage your releases more efficiently.\n- **Personal Tasks**: Organize your life and track your personal tasks.\n- **Content Calendar**: Plan your editorial content, assign work, and track deadlines.\n- **Personal Goals**: Set and accomplish new personal goals and milestones.	{}	1672924693483	1672924693483	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
7q5t75g5mfbdhjyiqewgkng1zhr	2023-01-05 13:18:13.314902+00	c4j5mdjzu7ibgiqy9usqpysgkpw	1	image		{"fileId":"7knxbyuiedtdafcgmropgkrtybr.gif"}	1672924693489	1672924693489	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
aaiwtagtnaid7zcpfhqbwmwqhro	2023-01-05 13:18:13.314902+00	c4j5mdjzu7ibgiqy9usqpysgkpw	1	text	Keep stakeholders and customers up-to-date on project progress by sharing your board.	{}	1672924693493	1672924693493	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
azfuwnqnagiriz8exm3gq6bb8ce	2023-01-05 13:18:13.314902+00	c4j5mdjzu7ibgiqy9usqpysgkpw	1	text	To share a board, select **Share** at the top right of the Board view. Copy the link to share the board internally with your team or generate public link that can be accessed by anyone externally.	{}	1672924693498	1672924693498	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
7yja7ojo1w7fgub4i7ajiy8egey	2023-01-05 13:18:13.314902+00	cbx789k4b9pn9ibensfy1ntf3ra	1	image		{"fileId":"7iw4rxx7jj7bypmdotd9z469cyh.png"}	1672924693502	1672924693502	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
afm8hkgpk6pgc3q7fzt6mcp1rih	2023-01-05 13:18:13.314902+00	cbx789k4b9pn9ibensfy1ntf3ra	1	text	To create a new card, simply do any of the following:\n- Select "**New**" on the top right header\n- Select "**+ New**" below any column\n- Select "**+**" to the right of any columnn header	{}	1672924693507	1672924693507	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
atr485n34hjyufcsnteo39yzfgh	2023-01-05 13:18:13.314902+00	cbx789k4b9pn9ibensfy1ntf3ra	1	text	Mattermost Boards helps you manage and track all your project tasks with **Cards**.	{}	1672924693512	1672924693512	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
7ppwiwaxoyfnezyze3eb7tuoe1h	2023-01-05 13:18:13.314902+00	c68jnqiqjyb8rzpsssydoa35qoh	1	image		{"fileId":"7ek6wbpp19jfoujs1goh6kttbby.gif"}	1672924693517	1672924693517	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
agc6mebe5k7gmuc9cf7mfr3ei4r	2023-01-05 13:18:13.314902+00	c68jnqiqjyb8rzpsssydoa35qoh	1	text	Cards can be linked and shared with teammates directly on Channels. Card previews are displayed when shared on Channels, so your team can discuss work items and get the relevant context without having to switch over to Boards.	{}	1672924693531	1672924693531	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
7we8qh6cnk7njfqrtkhe9ref1do	2023-01-05 13:18:13.314902+00	ca6779z9sp3gkxnhttsi87cc3ee	1	image		{"fileId":"7dybb6t8fj3nrdft7nerhuf784y.png"}	1672924693537	1672924693537	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
afsuxsmhisig9b8oshw6ttthybc	2023-01-05 13:18:13.314902+00	ca6779z9sp3gkxnhttsi87cc3ee	1	text	Organize and find the cards you're looking for with our filter, sort, and grouping options. From the Board header, you can quickly toggle on different properties, change the group display, set filters, and change how the cards are sorted.	{}	1672924693543	1672924693543	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
78aetf7whm7b77bf4c6cwopru1o	2023-01-05 13:18:13.314902+00	cph49auqcnp89tkj8ewhn18fbdc	1	image		{"fileId":"78jws5m1myf8pufewzkaa6i11sc.gif"}	1672924693549	1672924693549	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
aes6itqd7bibg5bj3tfqsf5ub8e	2023-01-05 13:18:13.314902+00	cph49auqcnp89tkj8ewhn18fbdc	1	text	Views allow your team to visualize the same cards and data from different perspectives, so they can stay up-to-date in the way that works best for them. To add a new view, go to **Add a new view** from the view drop-down, then select from any of the following views:\n\n- **Board**: Adds a Kanban board, similar to this one, that allows your team to organize cards in swimlanes grouped by any property of your choosing. This view helps you visualize your project progress.\n- **Table**: Displays cards in a table format with rows and columns. Use this view to get an overview of all your project tasks. Easily view and compare the state of all properties across all cards without needing to open individual cards.\n- **Gallery**: Displays cards in a gallery format, so you can manage and organize cards with image attachments.\n- **Calendar**: Adds a calendar view to easily visualize your cards by dates and keep track of deadlines.	{}	1672924693556	1672924693556	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
7db1qh8up4jbxjpjh8jko3b574y	2023-01-05 13:18:13.314902+00	cknwsb8ydwfg9meo47cagtfejhh	1	image		{"fileId":"7d6hrtig3zt8f9cnbo1um5oxx3y.gif"}	1672924693561	1672924693561	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
ax55zfmg36irmujxdu7mmi8jciy	2023-01-05 13:18:13.314902+00	cknwsb8ydwfg9meo47cagtfejhh	1	text	Customize cards to fit your needs and track the information most important to you. Boards supports a wide range of fully customizable property types. For example, you can:\n- Use the **Date** property for things like deadlines or milestones.\n- Assign owners to tasks with the **Person** property.\n- Define statuses and priorities with the **Select** property.\n- Create tags with the **Multi Select** property.\n- Link cards to webpages with the **URL** property.	{}	1672924693566	1672924693566	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
7j89d11qegjr49x66uen1ic9w6a	2023-01-05 13:18:13.314902+00	cqh6oczxk6tn9tf836qtk7qwc4r	1	image		{"fileId":"74nt9eqzea3ydjjpgjtsxcjgrxc.gif"}	1672924693573	1672924693573	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
apsy1grew9pr7tkxi3fzyox4y9o	2023-01-05 13:18:13.314902+00	cqh6oczxk6tn9tf836qtk7qwc4r	1	text	To mention a teammate use the **@ symbol with their username** in the comments or description section. They'll get a Direct Message notification via Channels and also be added as a [follower](https://docs.mattermost.com/boards/work-with-cards.html#receive-updates) to the card. \n\nWhenever any changes are made to the card, they'll automatically get notified on Channels.	{}	1672924693579	1672924693579	0	\N	system		system	bajnungi3f3dyzn5rr9ok7u9jea
\.


--
-- Data for Name: focalboard_board_members; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_board_members (board_id, user_id, roles, scheme_admin, scheme_editor, scheme_commenter, scheme_viewer) FROM stdin;
bmpxqmbwz3jgmfr4wdb3zq3upxo	system		t	f	f	f
b76f7shib8jguxewq7a7ijnrf3y	system		t	f	f	f
bmor97wnjrfyquk9zdnfkufz8tr	system		t	f	f	f
bg37p4bhsjjbh8fe8rqerbxtgcr	system		t	f	f	f
bhfouoto7gtbb3py83ib5nhb7jc	system		t	f	f	f
bfeybjmgux7niix8i3smgb9b31a	system		t	f	f	f
b195yoro7a7b4mkf4irwoj7cohy	system		t	f	f	f
b69byqn5ghj8umfbseap3ky8qpo	system		t	f	f	f
bwzfh6d1x3fr8zb8gfxba65kjah	system		t	f	f	f
bsw5maeiywtra5q79ms9ip59msa	system		t	f	f	f
bomnbp7on3pfdtpby8bpzcesf8w	system		t	f	f	f
b89qgwoopj7r6iemxatthhb8ynw	system		t	f	f	f
bajnungi3f3dyzn5rr9ok7u9jea	system		t	f	f	f
\.


--
-- Data for Name: focalboard_board_members_history; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_board_members_history (board_id, user_id, action, insert_at) FROM stdin;
bmpxqmbwz3jgmfr4wdb3zq3upxo	system	created	2023-01-05 13:18:08.716782+00
b76f7shib8jguxewq7a7ijnrf3y	system	created	2023-01-05 13:18:10.172069+00
bmor97wnjrfyquk9zdnfkufz8tr	system	created	2023-01-05 13:18:10.48101+00
bg37p4bhsjjbh8fe8rqerbxtgcr	system	created	2023-01-05 13:18:11.321676+00
bhfouoto7gtbb3py83ib5nhb7jc	system	created	2023-01-05 13:18:11.552663+00
bfeybjmgux7niix8i3smgb9b31a	system	created	2023-01-05 13:18:11.674854+00
b195yoro7a7b4mkf4irwoj7cohy	system	created	2023-01-05 13:18:12.07616+00
b69byqn5ghj8umfbseap3ky8qpo	system	created	2023-01-05 13:18:12.254884+00
bwzfh6d1x3fr8zb8gfxba65kjah	system	created	2023-01-05 13:18:12.448398+00
bsw5maeiywtra5q79ms9ip59msa	system	created	2023-01-05 13:18:12.70071+00
bomnbp7on3pfdtpby8bpzcesf8w	system	created	2023-01-05 13:18:12.868621+00
b89qgwoopj7r6iemxatthhb8ynw	system	created	2023-01-05 13:18:13.28178+00
bajnungi3f3dyzn5rr9ok7u9jea	system	created	2023-01-05 13:18:13.936892+00
\.


--
-- Data for Name: focalboard_boards; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_boards (id, insert_at, team_id, channel_id, created_by, modified_by, type, title, description, icon, show_description, is_template, template_version, properties, card_properties, create_at, update_at, delete_at, minimum_role) FROM stdin;
bmpxqmbwz3jgmfr4wdb3zq3upxo	2023-01-05 13:18:08.040999+00	0		system	system	O	Meeting Agenda 	Use this template for recurring meeting agendas, like team meetings and 1:1's. To use this board:\n* Participants queue new items to discuss under "To Discuss"\n* Go through items during the meeting\n* Move items to Done or Revisit Later as needed	🍩	t	t	6	{"trackingTemplateId": "54fcf9c610f0ac5e4c522c0657c90602"}	[{"id": "d777ba3b-8728-40d1-87a6-59406bbbbfb0", "name": "Status", "type": "select", "options": [{"id": "34eb9c25-d5bf-49d9-859e-f74f4e0030e7", "color": "propColorPink", "value": "To Discuss 💬"}, {"id": "d37a61f4-f332-4db9-8b2d-5e0a91aa20ed", "color": "propColorYellow", "value": "Revisit Later ⏳"}, {"id": "dabadd9b-adf1-4d9f-8702-805ac6cef602", "color": "propColorGreen", "value": "Done / Archived 📦"}]}, {"id": "4cf1568d-530f-4028-8ffd-bdc65249187e", "name": "Priority", "type": "select", "options": [{"id": "8b05c83e-a44a-4d04-831e-97f01d8e2003", "color": "propColorRed", "value": "1. High"}, {"id": "b1abafbf-a038-4a19-8b68-56e0fd2319f7", "color": "propColorYellow", "value": "2. Medium"}, {"id": "2491ffaa-eb55-417b-8aff-4bd7d4136613", "color": "propColorGray", "value": "3. Low"}]}, {"id": "aw4w63xhet79y9gueqzzeiifdoe", "name": "Created by", "type": "createdBy", "options": []}, {"id": "a6ux19353xcwfqg9k1inqg5sg4w", "name": "Created time", "type": "createdTime", "options": []}]	1672924688054	1672924688054	0	
b76f7shib8jguxewq7a7ijnrf3y	2023-01-05 13:18:08.726993+00	0		system	system	O	Sales Pipeline CRM	Use this template to grow and keep track of your sales opportunities.	📈	t	t	6	{"trackingTemplateId": "ecc250bb7dff0fe02247f1110f097544"}	[{"id": "a5hwxjsmkn6bak6r7uea5bx1kwc", "name": "Status", "type": "select", "options": [{"id": "akj61wc9yxdwyw3t6m8igyf9d5o", "color": "propColorGray", "value": "Lead"}, {"id": "aic89a5xox4wbppi6mbyx6ujsda", "color": "propColorYellow", "value": "Qualified"}, {"id": "ah6ehh43rwj88jy4awensin8pcw", "color": "propColorBrown", "value": "Meeting"}, {"id": "aprhd96zwi34o9cs4xyr3o9sf3c", "color": "propColorPurple", "value": "Proposal"}, {"id": "axesd74yuxtbmw1sbk8ufax7z3a", "color": "propColorOrange", "value": "Negotiation"}, {"id": "a5txuiubumsmrs8gsd5jz5gc1oa", "color": "propColorRed", "value": "Lost"}, {"id": "acm9q494bcthyoqzmfogxxy5czy", "color": "propColorGreen", "value": "Closed 🏆"}]}, {"id": "aoheuj1f3mu6eehygr45fxa144y", "name": "Account Owner", "type": "multiPerson", "options": []}, {"id": "aro91wme9kfaie5ceu9qasmtcnw", "name": "Priority", "type": "select", "options": [{"id": "apjnaggwixchfxwiatfh7ey7uno", "color": "propColorRed", "value": "High 🔥"}, {"id": "apiswzj7uiwbh87z8dw8c6mturw", "color": "propColorYellow", "value": "Medium"}, {"id": "auu9bfzqeuruyjwzzqgz7q8apuw", "color": "propColorBrown", "value": "Low"}]}, {"id": "ainpw47babwkpyj77ic4b9zq9xr", "name": "Company", "type": "text", "options": []}, {"id": "ahf43e44h3y8ftanqgzno9z7q7w", "name": "Estimated Value", "type": "number", "options": []}, {"id": "amahgyn9n4twaapg3jyxb6y4jic", "name": "Territory", "type": "select", "options": [{"id": "ar6t1ttcumgfuqugg5o4g4mzrza", "color": "propColorBrown", "value": "Western US"}, {"id": "asbwojkm7zb4ohrtij97jkdfgwe", "color": "propColorGreen", "value": "Mountain West / Central US"}, {"id": "aw8ppwtcrm8iwopdadje3ni196w", "color": "propColorGray", "value": "Mid-Atlantic / Southeast"}, {"id": "aafwyza5iwdcwcyfyj6bp7emufw", "color": "propColorBlue", "value": "Northeast US / Canada"}, {"id": "agw8rcb9uxyt3c7g6tq3r65fgqe", "color": "propColorPink", "value": "Eastern Europe"}, {"id": "as5bk6afoaaa7caewe1zc391sce", "color": "propColorPurple", "value": "Central Europe / Africa"}, {"id": "a8fj94bka8z9t6p95qd3hn6t5re", "color": "propColorYellow", "value": "Middle East"}, {"id": "arpxa3faaou9trt4zx5sh435gne", "color": "propColorOrange", "value": "UK"}, {"id": "azdidd5wze4kcxf8neefj3ctkyr", "color": "propColorRed", "value": "Asia"}, {"id": "a4jn5mhqs3thknqf5opykntgsnc", "color": "propColorGray", "value": "Australia"}, {"id": "afjbgrecb7hp5owj7xh8u4w33tr", "color": "propColorBrown", "value": "Latin America"}]}, {"id": "abru6tz8uebdxy4skheqidh7zxy", "name": "Email", "type": "email", "options": []}, {"id": "a1438fbbhjeffkexmcfhnx99o1h", "name": "Phone", "type": "phone", "options": []}, {"id": "auhf91pm85f73swwidi4wid8jqe", "name": "Last Contact Date", "type": "date", "options": []}, {"id": "adtf1151chornmihz4xbgbk9exa", "name": "Expected Close", "type": "date", "options": []}, {"id": "aejo5tcmq54bauuueem9wc4fw4y", "name": "Close Probability", "type": "text", "options": []}, {"id": "amba7ot98fh7hwsx8jdcfst5g7h", "name": "Created Date", "type": "createdTime", "options": []}]	1672924688729	1672924688729	0	
bmor97wnjrfyquk9zdnfkufz8tr	2023-01-05 13:18:10.177036+00	0		system	system	O	Personal Tasks 	Use this template to organize your life and track your personal tasks.	✔️	t	t	6	{"trackingTemplateId": "dfb70c146a4584b8a21837477c7b5431"}	[{"id": "a9zf59u8x1rf4ywctpcqama7tio", "name": "Occurrence", "type": "select", "options": [{"id": "an51dnkenmoog9cetapbc4uyt3y", "color": "propColorBlue", "value": "Daily"}, {"id": "afpy8s7i45frggprmfsqngsocqh", "color": "propColorOrange", "value": "Weekly"}, {"id": "aj4jyekqqssatjcq7r7chmy19ey", "color": "propColorPurple", "value": "Monthly"}]}, {"id": "abthng7baedhhtrwsdodeuincqy", "name": "Completed", "type": "checkbox", "options": []}]	1672924690180	1672924690180	0	
bg37p4bhsjjbh8fe8rqerbxtgcr	2023-01-05 13:18:10.587839+00	0		system	system	O	Project Tasks 	Use this template to stay on top of your project tasks and progress.	🎯	t	t	6	{"trackingTemplateId": "a4ec399ab4f2088b1051c3cdf1dde4c3"}	[{"id": "a972dc7a-5f4c-45d2-8044-8c28c69717f1", "name": "Status", "type": "select", "options": [{"id": "ayz81h9f3dwp7rzzbdebesc7ute", "color": "propColorBlue", "value": "Not Started"}, {"id": "ar6b8m3jxr3asyxhr8iucdbo6yc", "color": "propColorYellow", "value": "In Progress"}, {"id": "afi4o5nhnqc3smtzs1hs3ij34dh", "color": "propColorRed", "value": "Blocked"}, {"id": "adeo5xuwne3qjue83fcozekz8ko", "color": "propColorGreen", "value": "Completed 🙌"}, {"id": "ahpyxfnnrzynsw3im1psxpkgtpe", "color": "propColorBrown", "value": "Archived"}]}, {"id": "d3d682bf-e074-49d9-8df5-7320921c2d23", "name": "Priority", "type": "select", "options": [{"id": "d3bfb50f-f569-4bad-8a3a-dd15c3f60101", "color": "propColorRed", "value": "1. High 🔥"}, {"id": "87f59784-b859-4c24-8ebe-17c766e081dd", "color": "propColorYellow", "value": "2. Medium"}, {"id": "98a57627-0f76-471d-850d-91f3ed9fd213", "color": "propColorGray", "value": "3. Low"}]}, {"id": "axkhqa4jxr3jcqe4k87g8bhmary", "name": "Assignee", "type": "person", "options": []}, {"id": "a8daz81s4xjgke1ww6cwik5w7ye", "name": "Estimated Hours", "type": "number", "options": []}, {"id": "a3zsw7xs8sxy7atj8b6totp3mby", "name": "Due Date", "type": "date", "options": []}, {"id": "a7gdnz8ff8iyuqmzddjgmgo9ery", "name": "Created By", "type": "createdBy", "options": []}, {"id": "2a5da320-735c-4093-8787-f56e15cdfeed", "name": "Date Created", "type": "createdTime", "options": []}]	1672924690591	1672924690591	0	
bhfouoto7gtbb3py83ib5nhb7jc	2023-01-05 13:18:11.328467+00	0		system	system	O	Company Goals & OKRs	Use this template to plan your company goals and OKRs more efficiently.	⛳	t	t	6	{"trackingTemplateId": "7ba22ccfdfac391d63dea5c4b8cde0de"}	[{"id": "a6amddgmrzakw66cidqzgk6p4ge", "name": "Objective", "type": "select", "options": [{"id": "auw3afh3kfhrfgmjr8muiz137jy", "color": "propColorGreen", "value": "Grow Revenue"}, {"id": "apqfjst8massbjjhpcsjs3y1yqa", "color": "propColorOrange", "value": "Delight Customers"}, {"id": "ao9b5pxyt7tkgdohzh9oaustdhr", "color": "propColorPurple", "value": "Drive Product Adoption"}]}, {"id": "a17ryhi1jfsboxkwkztwawhmsxe", "name": "Status", "type": "select", "options": [{"id": "a6robxx81diugpjq5jkezz3j1fo", "color": "propColorGray", "value": "Not Started"}, {"id": "a8nukezwwmknqwjsygg7eaxs9te", "color": "propColorBlue", "value": "In Progress"}, {"id": "apnt1f7na9rzgk1rt49keg7xbiy", "color": "propColorYellow", "value": "At Risk"}, {"id": "axbz3m1amss335wzwf9s7pqjzxr", "color": "propColorRed", "value": "Missed"}, {"id": "abzfwnn6rmtfzyq5hg8uqmpsncy", "color": "propColorGreen", "value": "Complete 🙌"}]}, {"id": "azzbawji5bksj69sekcs4srm1ky", "name": "Department", "type": "select", "options": [{"id": "aw5i7hmpadn6mbwbz955ubarhme", "color": "propColorBrown", "value": "Engineering"}, {"id": "afkxpcjqjypu7hhar7banxau91h", "color": "propColorBlue", "value": "Product"}, {"id": "aehoa17cz18rqnrf75g7dwhphpr", "color": "propColorOrange", "value": "Marketing"}, {"id": "agrfeaoj7d8p5ianw5iaf3191ae", "color": "propColorGreen", "value": "Sales"}, {"id": "agm9p6gcq15ueuzqq3wd4be39wy", "color": "propColorYellow", "value": "Support"}, {"id": "aucop7kw6xwodcix6zzojhxih6r", "color": "propColorPink", "value": "Design"}, {"id": "afust91f3g8ht368mkn5x9tgf1o", "color": "propColorPurple", "value": "Finance"}, {"id": "acocxxwjurud1jixhp7nowdig7y", "color": "propColorGray", "value": "Human Resources"}]}, {"id": "adp5ft3kgz7r5iqq3tnwg551der", "name": "Priority", "type": "select", "options": [{"id": "a8zg3rjtf4swh7smsjxpsn743rh", "color": "propColorRed", "value": "P1 🔥"}, {"id": "as555ipyzopjjpfb5rjtssecw5e", "color": "propColorYellow", "value": "P2"}, {"id": "a1ts3ftyr8nocsicui98c89uxjy", "color": "propColorGray", "value": "P3"}]}, {"id": "aqxyzkdrs4egqf7yk866ixkaojc", "name": "Quarter", "type": "select", "options": [{"id": "ahfbn1jsmhydym33ygxwg5jt3kh", "color": "propColorBlue", "value": "Q1"}, {"id": "awfu37js3fomfkkczm1zppac57a", "color": "propColorBrown", "value": "Q2"}, {"id": "anruuoyez51r3yjxuoc8zoqnwaw", "color": "propColorGreen", "value": "Q3"}, {"id": "acb6dqqs6yson7bbzx6jk9bghjh", "color": "propColorPurple", "value": "Q4"}]}, {"id": "adu6mebzpibq6mgcswk69xxmnqe", "name": "Due Date", "type": "date", "options": []}, {"id": "asope3bddhm4gpsng5cfu4hf6rh", "name": "Assignee", "type": "multiPerson", "options": []}, {"id": "ajwxp866f9obs1kutfwaa5ru7fe", "name": "Target", "type": "number", "options": []}, {"id": "azqnyswk6s1boiwuthscm78qwuo", "name": "Actual", "type": "number", "options": []}, {"id": "ahz3fmjnaguec8hce7xq3h5cjdr", "name": "Completion (%)", "type": "text", "options": []}, {"id": "a17bfcgnzmkwhziwa4tr38kiw5r", "name": "Note", "type": "text", "options": []}]	1672924691331	1672924691331	0	
bfeybjmgux7niix8i3smgb9b31a	2023-01-05 13:18:11.555344+00	0		system	system	O	Personal Goals 	Use this template to set and accomplish new personal goals.	⛰️	t	t	6	{"trackingTemplateId": "7f32dc8d2ae008cfe56554e9363505cc"}	[{"id": "af6fcbb8-ca56-4b73-83eb-37437b9a667d", "name": "Status", "type": "select", "options": [{"id": "bf52bfe6-ac4c-4948-821f-83eaa1c7b04a", "color": "propColorRed", "value": "To Do"}, {"id": "77c539af-309c-4db1-8329-d20ef7e9eacd", "color": "propColorYellow", "value": "Doing"}, {"id": "98bdea27-0cce-4cde-8dc6-212add36e63a", "color": "propColorGreen", "value": "Done 🙌"}]}, {"id": "d9725d14-d5a8-48e5-8de1-6f8c004a9680", "name": "Category", "type": "select", "options": [{"id": "3245a32d-f688-463b-87f4-8e7142c1b397", "color": "propColorPurple", "value": "Life Skills"}, {"id": "80be816c-fc7a-4928-8489-8b02180f4954", "color": "propColorGreen", "value": "Finance"}, {"id": "ffb3f951-b47f-413b-8f1d-238666728008", "color": "propColorOrange", "value": "Health"}]}, {"id": "d6b1249b-bc18-45fc-889e-bec48fce80ef", "name": "Target", "type": "select", "options": [{"id": "9a090e33-b110-4268-8909-132c5002c90e", "color": "propColorBlue", "value": "Q1"}, {"id": "0a82977f-52bf-457b-841b-e2b7f76fb525", "color": "propColorBrown", "value": "Q2"}, {"id": "6e7139e4-5358-46bb-8c01-7b029a57b80a", "color": "propColorGreen", "value": "Q3"}, {"id": "d5371c63-66bf-4468-8738-c4dc4bea4843", "color": "propColorPurple", "value": "Q4"}]}, {"id": "ajy6xbebzopojaenbnmfpgtdwso", "name": "Due Date", "type": "date", "options": []}]	1672924691562	1672924691562	0	
b195yoro7a7b4mkf4irwoj7cohy	2023-01-05 13:18:11.678364+00	0		system	system	O	Sprint Planner 	Use this template to plan your sprints and manage your releases more efficiently.	🗓️	t	t	6	{"trackingTemplateId": "99b74e26d2f5d0a9b346d43c0a7bfb09"}	[{"id": "50117d52-bcc7-4750-82aa-831a351c44a0", "name": "Status", "type": "select", "options": [{"id": "aft5bzo7h9aspqgrx3jpy5tzrer", "color": "propColorGray", "value": "Not Started"}, {"id": "abrfos7e7eczk9rqw6y5abadm1y", "color": "propColorOrange", "value": "Next Up"}, {"id": "ax8wzbka5ahs3zziji3pp4qp9mc", "color": "propColorBlue", "value": "In Progress"}, {"id": "atabdfbdmjh83136d5e5oysxybw", "color": "propColorYellow", "value": "In Review"}, {"id": "ace1bzypd586kkyhcht5qqd9eca", "color": "propColorPink", "value": "Approved"}, {"id": "aay656c9m1hzwxc9ch5ftymh3nw", "color": "propColorRed", "value": "Blocked"}, {"id": "a6ghze4iy441qhsh3eijnc8hwze", "color": "propColorGreen", "value": "Complete 🙌"}]}, {"id": "20717ad3-5741-4416-83f1-6f133fff3d11", "name": "Type", "type": "select", "options": [{"id": "424ea5e3-9aa1-4075-8c5c-01b44b66e634", "color": "propColorYellow", "value": "Epic ⛰"}, {"id": "a5yxq8rbubrpnoommfwqmty138h", "color": "propColorGray", "value": "Feature 🏗"}, {"id": "apht1nt5ryukdmxkh6fkfn6rgoy", "color": "propColorOrange", "value": "User Story 📖"}, {"id": "aiycbuo3dr5k4xxbfr7coem8ono", "color": "propColorGreen", "value": "Task ⛏"}, {"id": "aomnawq4551cbbzha9gxnmb3z5w", "color": "propColorRed", "value": "Bug 🐞"}]}, {"id": "60985f46-3e41-486e-8213-2b987440ea1c", "name": "Sprint", "type": "select", "options": [{"id": "c01676ca-babf-4534-8be5-cce2287daa6c", "color": "propColorBrown", "value": "Sprint 1"}, {"id": "ed4a5340-460d-461b-8838-2c56e8ee59fe", "color": "propColorPurple", "value": "Sprint 2"}, {"id": "14892380-1a32-42dd-8034-a0cea32bc7e6", "color": "propColorBlue", "value": "Sprint 3"}]}, {"id": "f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e", "name": "Priority", "type": "select", "options": [{"id": "cb8ecdac-38be-4d36-8712-c4d58cc8a8e9", "color": "propColorRed", "value": "P1 🔥"}, {"id": "e6a7f297-4440-4783-8ab3-3af5ba62ca11", "color": "propColorYellow", "value": "P2"}, {"id": "c62172ea-5da7-4dec-8186-37267d8ee9a7", "color": "propColorGray", "value": "P3"}]}, {"id": "aphg37f7zbpuc3bhwhp19s1ribh", "name": "Assignee", "type": "multiPerson", "options": []}, {"id": "a4378omyhmgj3bex13sj4wbpfiy", "name": "Due Date", "type": "date", "options": []}, {"id": "ai7ajsdk14w7x5s8up3dwir77te", "name": "Story Points", "type": "number", "options": []}, {"id": "a1g6i613dpe9oryeo71ex3c86hy", "name": "Design Link", "type": "url", "options": []}, {"id": "aeomttrbhhsi8bph31jn84sto6h", "name": "Created Time", "type": "createdTime", "options": []}, {"id": "ax9f8so418s6s65hi5ympd93i6a", "name": "Created By", "type": "createdBy", "options": []}]	1672924691684	1672924691684	0	
b69byqn5ghj8umfbseap3ky8qpo	2023-01-05 13:18:12.078234+00	0		system	system	O	User Research Sessions	Use this template to manage and keep track of all your user research sessions.	🔬	t	t	6	{"trackingTemplateId": "6c345c7f50f6833f78b7d0f08ce450a3"}	[{"id": "aaebj5fyx493eezx6ukxiwydgty", "name": "Status", "type": "select", "options": [{"id": "af6hjb3ysuaxbwnfqpby4wwnkdr", "color": "propColorGray", "value": "Backlog 📒"}, {"id": "aotxum1p5bw3xuzqz3ctjw66yww", "color": "propColorYellow", "value": "Contacted 📞"}, {"id": "a7yq89whddzob1futao4rxk3yzc", "color": "propColorBlue", "value": "Scheduled 📅"}, {"id": "aseqq9hrsua56r3s6nbuirj9eec", "color": "propColorRed", "value": "Cancelled 🚫"}, {"id": "ap93ysuzy1xa7z818r6myrn4h4y", "color": "propColorGreen", "value": "Completed ✔️"}]}, {"id": "akrxgi7p7w14fym3gbynb98t9fh", "name": "Interview Date", "type": "date", "options": []}, {"id": "atg9qu6oe4bjm8jczzsn71ff5me", "name": "Product Area", "type": "select", "options": [{"id": "ahn89mqg9u4igk6pdm7333t8i5h", "color": "propColorGreen", "value": "Desktop App"}, {"id": "aehc83ffays3gh8myz16a8j7k4e", "color": "propColorPurple", "value": "Web App"}, {"id": "a1sxagjgaadym5yrjak6tcup1oa", "color": "propColorBlue", "value": "Mobile App"}]}, {"id": "acjq4t5ymytu8x1f68wkggm7ypc", "name": "Email", "type": "email", "options": []}, {"id": "aphio1s5gkmpdbwoxynim7acw3e", "name": "Interviewer", "type": "multiPerson", "options": []}, {"id": "aqafzdeekpyncwz7m7i54q3iqqy", "name": "Recording URL", "type": "url", "options": []}, {"id": "aify3r761b9w43bqjtskrzi68tr", "name": "Passcode", "type": "text", "options": []}]	1672924692082	1672924692082	0	
bsw5maeiywtra5q79ms9ip59msa	2023-01-05 13:18:12.451033+00	0		system	system	O	Content Calendar 	Use this template to plan and organize your editorial content.	📅	t	t	6	{"trackingTemplateId": "c75fbd659d2258b5183af2236d176ab4"}	[{"id": "ae9ar615xoknd8hw8py7mbyr7zo", "name": "Status", "type": "select", "options": [{"id": "awna1nuarjca99m9s4uiy9kwj5h", "color": "propColorGray", "value": "Idea 💡"}, {"id": "a9ana1e9w673o5cp8md4xjjwfto", "color": "propColorOrange", "value": "Draft"}, {"id": "apy9dcd7zmand615p3h53zjqxjh", "color": "propColorPurple", "value": "In Review"}, {"id": "acri4cm3bmay55f7ksztphmtnga", "color": "propColorBlue", "value": "Ready to Publish"}, {"id": "amsowcd9a8e1kid317r7ttw6uzh", "color": "propColorGreen", "value": "Published 🎉"}]}, {"id": "aysx3atqexotgwp5kx6h5i5ancw", "name": "Type", "type": "select", "options": [{"id": "aywiofmmtd3ofgzj95ysky4pjga", "color": "propColorOrange", "value": "Press Release"}, {"id": "apqdgjrmsmx8ngmp7zst51647de", "color": "propColorGreen", "value": "Sponsored Post"}, {"id": "a3woynbjnb7j16e74uw3pubrytw", "color": "propColorPurple", "value": "Customer Story"}, {"id": "aq36k5pkpfcypqb3idw36xdi1fh", "color": "propColorRed", "value": "Product Release"}, {"id": "azn66pmk34adygnizjqhgiac4ia", "color": "propColorGray", "value": "Partnership"}, {"id": "aj8y675weso8kpb6eceqbpj4ruw", "color": "propColorBlue", "value": "Feature Announcement"}, {"id": "a3xky7ygn14osr1mokerbfah5cy", "color": "propColorYellow", "value": "Article"}]}, {"id": "ab6mbock6styfe6htf815ph1mhw", "name": "Channel", "type": "multiSelect", "options": [{"id": "a8xceonxiu4n3c43szhskqizicr", "color": "propColorBrown", "value": "Website"}, {"id": "a3pdzi53kpbd4okzdkz6khi87zo", "color": "propColorGreen", "value": "Blog"}, {"id": "a3d9ux4fmi3anyd11kyipfbhwde", "color": "propColorOrange", "value": "Email"}, {"id": "a8cbbfdwocx73zn3787cx6gacsh", "color": "propColorRed", "value": "Podcast"}, {"id": "aigjtpcaxdp7d6kmctrwo1ztaia", "color": "propColorPink", "value": "Print"}, {"id": "af1wsn13muho59e7ghwaogxy5ey", "color": "propColorBlue", "value": "Facebook"}, {"id": "a47zajfxwhsg6q8m7ppbiqs7jge", "color": "propColorGray", "value": "LinkedIn"}, {"id": "az8o8pfe9hq6s7xaehoqyc3wpyc", "color": "propColorYellow", "value": "Twitter"}]}, {"id": "ao44fz8nf6z6tuj1x31t9yyehcc", "name": "Assignee", "type": "person", "options": []}, {"id": "a39x5cybshwrbjpc3juaakcyj6e", "name": "Due Date", "type": "date", "options": []}, {"id": "agqsoiipowmnu9rdwxm57zrehtr", "name": "Publication Date", "type": "date", "options": []}, {"id": "ap4e7kdg7eip7j3c3oyiz39eaoc", "name": "Link", "type": "url", "options": []}]	1672924692456	1672924692456	0	
bomnbp7on3pfdtpby8bpzcesf8w	2023-01-05 13:18:12.730276+00	0		system	system	O	Team Retrospective	Use this template at the end of your project or sprint to identify what worked well and what can be improved for the future.	🧭	t	t	6	{"trackingTemplateId": "e4f03181c4ced8edd4d53d33d569a086"}	[{"id": "adjckpdotpgkz7c6wixzw9ipb1e", "name": "Category", "type": "select", "options": [{"id": "aok6pgecm85qe9k5kcphzoe63ma", "color": "propColorGray", "value": "To Discuss 📣"}, {"id": "aq1dwbf661yx337hjcd5q3sbxwa", "color": "propColorGreen", "value": "Went Well 👍"}, {"id": "ar87yh5xmsswqkxmjq1ipfftfpc", "color": "propColorRed", "value": "Didn't Go Well 🚫"}, {"id": "akj3fkmxq7idma55mdt8sqpumyw", "color": "propColorBlue", "value": "Action Items ✅"}]}, {"id": "aspaay76a5wrnuhtqgm97tt3rer", "name": "Details", "type": "text", "options": []}, {"id": "arzsm76s376y7suuhao3tu6efoc", "name": "Created By", "type": "createdBy", "options": []}, {"id": "a8anbe5fpa668sryatcdsuuyh8a", "name": "Created Time", "type": "createdTime", "options": []}]	1672924692734	1672924692734	0	
b89qgwoopj7r6iemxatthhb8ynw	2023-01-05 13:18:12.87149+00	0		system	system	O	Roadmap 	Use this template to plan your roadmap and manage your releases more efficiently.	🗺️	t	t	6	{"trackingTemplateId": "b728c6ca730e2cfc229741c5a4712b65"}	[{"id": "50117d52-bcc7-4750-82aa-831a351c44a0", "name": "Status", "type": "select", "options": [{"id": "8c557f69-b0ed-46ec-83a3-8efab9d47ef5", "color": "propColorGray", "value": "Not Started"}, {"id": "ec6d2bc5-df2b-4f77-8479-e59ceb039946", "color": "propColorYellow", "value": "In Progress"}, {"id": "849766ba-56a5-48d1-886f-21672f415395", "color": "propColorGreen", "value": "Complete 🙌"}]}, {"id": "20717ad3-5741-4416-83f1-6f133fff3d11", "name": "Type", "type": "select", "options": [{"id": "424ea5e3-9aa1-4075-8c5c-01b44b66e634", "color": "propColorYellow", "value": "Epic ⛰"}, {"id": "6eea96c9-4c61-4968-8554-4b7537e8f748", "color": "propColorGreen", "value": "Task 🔨"}, {"id": "1fdbb515-edd2-4af5-80fc-437ed2211a49", "color": "propColorRed", "value": "Bug 🐞"}]}, {"id": "60985f46-3e41-486e-8213-2b987440ea1c", "name": "Sprint", "type": "select", "options": [{"id": "c01676ca-babf-4534-8be5-cce2287daa6c", "color": "propColorBrown", "value": "Sprint 1"}, {"id": "ed4a5340-460d-461b-8838-2c56e8ee59fe", "color": "propColorPurple", "value": "Sprint 2"}, {"id": "14892380-1a32-42dd-8034-a0cea32bc7e6", "color": "propColorBlue", "value": "Sprint 3"}]}, {"id": "f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e", "name": "Priority", "type": "select", "options": [{"id": "cb8ecdac-38be-4d36-8712-c4d58cc8a8e9", "color": "propColorRed", "value": "P1 🔥"}, {"id": "e6a7f297-4440-4783-8ab3-3af5ba62ca11", "color": "propColorYellow", "value": "P2"}, {"id": "c62172ea-5da7-4dec-8186-37267d8ee9a7", "color": "propColorGray", "value": "P3"}]}, {"id": "aphg37f7zbpuc3bhwhp19s1ribh", "name": "Assignee", "type": "person", "options": []}, {"id": "a4378omyhmgj3bex13sj4wbpfiy", "name": "Due Date", "type": "date", "options": []}, {"id": "a36o9q1yik6nmar6ri4q4uca7ey", "name": "Created Date", "type": "createdTime", "options": []}, {"id": "ai7ajsdk14w7x5s8up3dwir77te", "name": "Design Link", "type": "url", "options": []}]	1672924692877	1672924692877	0	
bwzfh6d1x3fr8zb8gfxba65kjah	2023-01-05 13:18:12.257888+00	0		system	system	O	Competitive Analysis	Use this template to track and stay ahead of the competition.	🗂️	t	t	6	{"trackingTemplateId": "06f4bff367a7c2126fab2380c9dec23c"}	[{"id": "ahzspe59iux8wigra8bg6cg18nc", "name": "Website", "type": "url", "options": []}, {"id": "aozntq4go4nkab688j1s7stqtfc", "name": "Location", "type": "text", "options": []}, {"id": "aiefo7nh9jwisn8b4cgakowithy", "name": "Revenue", "type": "text", "options": []}, {"id": "a6cwaq79b1pdpb97wkanmeyy4er", "name": "Employees", "type": "number", "options": []}, {"id": "an1eerzscfxn6awdfajbg41uz3h", "name": "Founded", "type": "text", "options": []}, {"id": "a1semdhszu1rq17d7et5ydrqqio", "name": "Market Position", "type": "select", "options": [{"id": "arfjpz9by5car71tz3behba8yih", "color": "propColorYellow", "value": "Leader"}, {"id": "abajmr34b8g1916w495xjb35iko", "color": "propColorRed", "value": "Challenger"}, {"id": "abt79uxg5edqojsrrefcnr4eruo", "color": "propColorBlue", "value": "Follower"}, {"id": "aipf3qfgjtkheiayjuxrxbpk9wa", "color": "propColorBrown", "value": "Nicher"}]}, {"id": "aapogff3xoa8ym7xf56s87kysda", "name": "Last updated time", "type": "updatedTime", "options": []}, {"id": "az3jkw3ynd3mqmart7edypey15e", "name": "Last updated by", "type": "updatedBy", "options": []}]	1672924692261	1672924692261	0	
bajnungi3f3dyzn5rr9ok7u9jea	2023-01-05 13:18:13.314902+00	0		system	system	O	Welcome to Boards!	Mattermost Boards is an open source project management tool that helps you organize, track, and manage work across teams. Select a card to learn more.	👋	t	t	6	{"trackingTemplateId": "65aba997282f3ac457cd66736fb86915"}	[{"id": "a972dc7a-5f4c-45d2-8044-8c28c69717f1", "name": "Status", "type": "select", "options": [{"id": "amm6wfhnbuxojwssyftgs9dipqe", "color": "propColorRed", "value": "To do 🔥"}, {"id": "af3p8ztcyxgn8wd9z4az7o9tjeh", "color": "propColorYellow", "value": "Next up"}, {"id": "ajurey3xkocs1nwx8di5zx6oe7o", "color": "propColorPurple", "value": "Later"}, {"id": "agkinkjy5983wsk6kppsujajxqw", "color": "propColorGreen", "value": "Completed 🙌"}]}, {"id": "acypkejeb5yfujhj9te57p9kaxw", "name": "Priority", "type": "select", "options": [{"id": "aanaehcw3m13jytujsjk5hpf6ry", "color": "propColorOrange", "value": "1. High"}, {"id": "ascd7nm9r491ayot8i86g1gmgqw", "color": "propColorBrown", "value": "2. Medium"}, {"id": "aq6ukoiciyfctgwyhwzpfss8ghe", "color": "propColorGray", "value": "3. Low"}]}, {"id": "aqh13jabwexjkzr3jqsz1i1syew", "name": "Assignee", "type": "person", "options": []}, {"id": "acmg7mz1rr1eykfug4hcdpb1y1o", "name": "Due Date", "type": "date", "options": []}, {"id": "amewjwfjrtpu8ha73xsrdmxazxr", "name": "Reviewed", "type": "checkbox", "options": []}, {"id": "attzzboqaz6m1sdti5xa7gjnk1e", "name": "Last updated time", "type": "updatedTime", "options": []}, {"id": "a4nfnb5xr3txr5xq7y9ho7kyz6c", "name": "Reference", "type": "url", "options": []}, {"id": "a9gzwi3dt5n55nddej6zcbhxaeh", "name": "Created by", "type": "createdBy", "options": []}]	1672924693317	1672924693317	0	
\.


--
-- Data for Name: focalboard_boards_history; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_boards_history (id, insert_at, team_id, channel_id, created_by, modified_by, type, title, description, icon, show_description, is_template, template_version, properties, card_properties, create_at, update_at, delete_at, minimum_role) FROM stdin;
bmpxqmbwz3jgmfr4wdb3zq3upxo	2023-01-05 13:18:08.040999+00	0		system	system	O	Meeting Agenda 	Use this template for recurring meeting agendas, like team meetings and 1:1's. To use this board:\n* Participants queue new items to discuss under "To Discuss"\n* Go through items during the meeting\n* Move items to Done or Revisit Later as needed	🍩	t	t	6	{"trackingTemplateId": "54fcf9c610f0ac5e4c522c0657c90602"}	[{"id": "d777ba3b-8728-40d1-87a6-59406bbbbfb0", "name": "Status", "type": "select", "options": [{"id": "34eb9c25-d5bf-49d9-859e-f74f4e0030e7", "color": "propColorPink", "value": "To Discuss 💬"}, {"id": "d37a61f4-f332-4db9-8b2d-5e0a91aa20ed", "color": "propColorYellow", "value": "Revisit Later ⏳"}, {"id": "dabadd9b-adf1-4d9f-8702-805ac6cef602", "color": "propColorGreen", "value": "Done / Archived 📦"}]}, {"id": "4cf1568d-530f-4028-8ffd-bdc65249187e", "name": "Priority", "type": "select", "options": [{"id": "8b05c83e-a44a-4d04-831e-97f01d8e2003", "color": "propColorRed", "value": "1. High"}, {"id": "b1abafbf-a038-4a19-8b68-56e0fd2319f7", "color": "propColorYellow", "value": "2. Medium"}, {"id": "2491ffaa-eb55-417b-8aff-4bd7d4136613", "color": "propColorGray", "value": "3. Low"}]}, {"id": "aw4w63xhet79y9gueqzzeiifdoe", "name": "Created by", "type": "createdBy", "options": []}, {"id": "a6ux19353xcwfqg9k1inqg5sg4w", "name": "Created time", "type": "createdTime", "options": []}]	1672924688054	1672924688054	0	
b76f7shib8jguxewq7a7ijnrf3y	2023-01-05 13:18:08.726993+00	0		system	system	O	Sales Pipeline CRM	Use this template to grow and keep track of your sales opportunities.	📈	t	t	6	{"trackingTemplateId": "ecc250bb7dff0fe02247f1110f097544"}	[{"id": "a5hwxjsmkn6bak6r7uea5bx1kwc", "name": "Status", "type": "select", "options": [{"id": "akj61wc9yxdwyw3t6m8igyf9d5o", "color": "propColorGray", "value": "Lead"}, {"id": "aic89a5xox4wbppi6mbyx6ujsda", "color": "propColorYellow", "value": "Qualified"}, {"id": "ah6ehh43rwj88jy4awensin8pcw", "color": "propColorBrown", "value": "Meeting"}, {"id": "aprhd96zwi34o9cs4xyr3o9sf3c", "color": "propColorPurple", "value": "Proposal"}, {"id": "axesd74yuxtbmw1sbk8ufax7z3a", "color": "propColorOrange", "value": "Negotiation"}, {"id": "a5txuiubumsmrs8gsd5jz5gc1oa", "color": "propColorRed", "value": "Lost"}, {"id": "acm9q494bcthyoqzmfogxxy5czy", "color": "propColorGreen", "value": "Closed 🏆"}]}, {"id": "aoheuj1f3mu6eehygr45fxa144y", "name": "Account Owner", "type": "multiPerson", "options": []}, {"id": "aro91wme9kfaie5ceu9qasmtcnw", "name": "Priority", "type": "select", "options": [{"id": "apjnaggwixchfxwiatfh7ey7uno", "color": "propColorRed", "value": "High 🔥"}, {"id": "apiswzj7uiwbh87z8dw8c6mturw", "color": "propColorYellow", "value": "Medium"}, {"id": "auu9bfzqeuruyjwzzqgz7q8apuw", "color": "propColorBrown", "value": "Low"}]}, {"id": "ainpw47babwkpyj77ic4b9zq9xr", "name": "Company", "type": "text", "options": []}, {"id": "ahf43e44h3y8ftanqgzno9z7q7w", "name": "Estimated Value", "type": "number", "options": []}, {"id": "amahgyn9n4twaapg3jyxb6y4jic", "name": "Territory", "type": "select", "options": [{"id": "ar6t1ttcumgfuqugg5o4g4mzrza", "color": "propColorBrown", "value": "Western US"}, {"id": "asbwojkm7zb4ohrtij97jkdfgwe", "color": "propColorGreen", "value": "Mountain West / Central US"}, {"id": "aw8ppwtcrm8iwopdadje3ni196w", "color": "propColorGray", "value": "Mid-Atlantic / Southeast"}, {"id": "aafwyza5iwdcwcyfyj6bp7emufw", "color": "propColorBlue", "value": "Northeast US / Canada"}, {"id": "agw8rcb9uxyt3c7g6tq3r65fgqe", "color": "propColorPink", "value": "Eastern Europe"}, {"id": "as5bk6afoaaa7caewe1zc391sce", "color": "propColorPurple", "value": "Central Europe / Africa"}, {"id": "a8fj94bka8z9t6p95qd3hn6t5re", "color": "propColorYellow", "value": "Middle East"}, {"id": "arpxa3faaou9trt4zx5sh435gne", "color": "propColorOrange", "value": "UK"}, {"id": "azdidd5wze4kcxf8neefj3ctkyr", "color": "propColorRed", "value": "Asia"}, {"id": "a4jn5mhqs3thknqf5opykntgsnc", "color": "propColorGray", "value": "Australia"}, {"id": "afjbgrecb7hp5owj7xh8u4w33tr", "color": "propColorBrown", "value": "Latin America"}]}, {"id": "abru6tz8uebdxy4skheqidh7zxy", "name": "Email", "type": "email", "options": []}, {"id": "a1438fbbhjeffkexmcfhnx99o1h", "name": "Phone", "type": "phone", "options": []}, {"id": "auhf91pm85f73swwidi4wid8jqe", "name": "Last Contact Date", "type": "date", "options": []}, {"id": "adtf1151chornmihz4xbgbk9exa", "name": "Expected Close", "type": "date", "options": []}, {"id": "aejo5tcmq54bauuueem9wc4fw4y", "name": "Close Probability", "type": "text", "options": []}, {"id": "amba7ot98fh7hwsx8jdcfst5g7h", "name": "Created Date", "type": "createdTime", "options": []}]	1672924688729	1672924688729	0	
bmor97wnjrfyquk9zdnfkufz8tr	2023-01-05 13:18:10.177036+00	0		system	system	O	Personal Tasks 	Use this template to organize your life and track your personal tasks.	✔️	t	t	6	{"trackingTemplateId": "dfb70c146a4584b8a21837477c7b5431"}	[{"id": "a9zf59u8x1rf4ywctpcqama7tio", "name": "Occurrence", "type": "select", "options": [{"id": "an51dnkenmoog9cetapbc4uyt3y", "color": "propColorBlue", "value": "Daily"}, {"id": "afpy8s7i45frggprmfsqngsocqh", "color": "propColorOrange", "value": "Weekly"}, {"id": "aj4jyekqqssatjcq7r7chmy19ey", "color": "propColorPurple", "value": "Monthly"}]}, {"id": "abthng7baedhhtrwsdodeuincqy", "name": "Completed", "type": "checkbox", "options": []}]	1672924690180	1672924690180	0	
bg37p4bhsjjbh8fe8rqerbxtgcr	2023-01-05 13:18:10.587839+00	0		system	system	O	Project Tasks 	Use this template to stay on top of your project tasks and progress.	🎯	t	t	6	{"trackingTemplateId": "a4ec399ab4f2088b1051c3cdf1dde4c3"}	[{"id": "a972dc7a-5f4c-45d2-8044-8c28c69717f1", "name": "Status", "type": "select", "options": [{"id": "ayz81h9f3dwp7rzzbdebesc7ute", "color": "propColorBlue", "value": "Not Started"}, {"id": "ar6b8m3jxr3asyxhr8iucdbo6yc", "color": "propColorYellow", "value": "In Progress"}, {"id": "afi4o5nhnqc3smtzs1hs3ij34dh", "color": "propColorRed", "value": "Blocked"}, {"id": "adeo5xuwne3qjue83fcozekz8ko", "color": "propColorGreen", "value": "Completed 🙌"}, {"id": "ahpyxfnnrzynsw3im1psxpkgtpe", "color": "propColorBrown", "value": "Archived"}]}, {"id": "d3d682bf-e074-49d9-8df5-7320921c2d23", "name": "Priority", "type": "select", "options": [{"id": "d3bfb50f-f569-4bad-8a3a-dd15c3f60101", "color": "propColorRed", "value": "1. High 🔥"}, {"id": "87f59784-b859-4c24-8ebe-17c766e081dd", "color": "propColorYellow", "value": "2. Medium"}, {"id": "98a57627-0f76-471d-850d-91f3ed9fd213", "color": "propColorGray", "value": "3. Low"}]}, {"id": "axkhqa4jxr3jcqe4k87g8bhmary", "name": "Assignee", "type": "person", "options": []}, {"id": "a8daz81s4xjgke1ww6cwik5w7ye", "name": "Estimated Hours", "type": "number", "options": []}, {"id": "a3zsw7xs8sxy7atj8b6totp3mby", "name": "Due Date", "type": "date", "options": []}, {"id": "a7gdnz8ff8iyuqmzddjgmgo9ery", "name": "Created By", "type": "createdBy", "options": []}, {"id": "2a5da320-735c-4093-8787-f56e15cdfeed", "name": "Date Created", "type": "createdTime", "options": []}]	1672924690591	1672924690591	0	
bhfouoto7gtbb3py83ib5nhb7jc	2023-01-05 13:18:11.328467+00	0		system	system	O	Company Goals & OKRs	Use this template to plan your company goals and OKRs more efficiently.	⛳	t	t	6	{"trackingTemplateId": "7ba22ccfdfac391d63dea5c4b8cde0de"}	[{"id": "a6amddgmrzakw66cidqzgk6p4ge", "name": "Objective", "type": "select", "options": [{"id": "auw3afh3kfhrfgmjr8muiz137jy", "color": "propColorGreen", "value": "Grow Revenue"}, {"id": "apqfjst8massbjjhpcsjs3y1yqa", "color": "propColorOrange", "value": "Delight Customers"}, {"id": "ao9b5pxyt7tkgdohzh9oaustdhr", "color": "propColorPurple", "value": "Drive Product Adoption"}]}, {"id": "a17ryhi1jfsboxkwkztwawhmsxe", "name": "Status", "type": "select", "options": [{"id": "a6robxx81diugpjq5jkezz3j1fo", "color": "propColorGray", "value": "Not Started"}, {"id": "a8nukezwwmknqwjsygg7eaxs9te", "color": "propColorBlue", "value": "In Progress"}, {"id": "apnt1f7na9rzgk1rt49keg7xbiy", "color": "propColorYellow", "value": "At Risk"}, {"id": "axbz3m1amss335wzwf9s7pqjzxr", "color": "propColorRed", "value": "Missed"}, {"id": "abzfwnn6rmtfzyq5hg8uqmpsncy", "color": "propColorGreen", "value": "Complete 🙌"}]}, {"id": "azzbawji5bksj69sekcs4srm1ky", "name": "Department", "type": "select", "options": [{"id": "aw5i7hmpadn6mbwbz955ubarhme", "color": "propColorBrown", "value": "Engineering"}, {"id": "afkxpcjqjypu7hhar7banxau91h", "color": "propColorBlue", "value": "Product"}, {"id": "aehoa17cz18rqnrf75g7dwhphpr", "color": "propColorOrange", "value": "Marketing"}, {"id": "agrfeaoj7d8p5ianw5iaf3191ae", "color": "propColorGreen", "value": "Sales"}, {"id": "agm9p6gcq15ueuzqq3wd4be39wy", "color": "propColorYellow", "value": "Support"}, {"id": "aucop7kw6xwodcix6zzojhxih6r", "color": "propColorPink", "value": "Design"}, {"id": "afust91f3g8ht368mkn5x9tgf1o", "color": "propColorPurple", "value": "Finance"}, {"id": "acocxxwjurud1jixhp7nowdig7y", "color": "propColorGray", "value": "Human Resources"}]}, {"id": "adp5ft3kgz7r5iqq3tnwg551der", "name": "Priority", "type": "select", "options": [{"id": "a8zg3rjtf4swh7smsjxpsn743rh", "color": "propColorRed", "value": "P1 🔥"}, {"id": "as555ipyzopjjpfb5rjtssecw5e", "color": "propColorYellow", "value": "P2"}, {"id": "a1ts3ftyr8nocsicui98c89uxjy", "color": "propColorGray", "value": "P3"}]}, {"id": "aqxyzkdrs4egqf7yk866ixkaojc", "name": "Quarter", "type": "select", "options": [{"id": "ahfbn1jsmhydym33ygxwg5jt3kh", "color": "propColorBlue", "value": "Q1"}, {"id": "awfu37js3fomfkkczm1zppac57a", "color": "propColorBrown", "value": "Q2"}, {"id": "anruuoyez51r3yjxuoc8zoqnwaw", "color": "propColorGreen", "value": "Q3"}, {"id": "acb6dqqs6yson7bbzx6jk9bghjh", "color": "propColorPurple", "value": "Q4"}]}, {"id": "adu6mebzpibq6mgcswk69xxmnqe", "name": "Due Date", "type": "date", "options": []}, {"id": "asope3bddhm4gpsng5cfu4hf6rh", "name": "Assignee", "type": "multiPerson", "options": []}, {"id": "ajwxp866f9obs1kutfwaa5ru7fe", "name": "Target", "type": "number", "options": []}, {"id": "azqnyswk6s1boiwuthscm78qwuo", "name": "Actual", "type": "number", "options": []}, {"id": "ahz3fmjnaguec8hce7xq3h5cjdr", "name": "Completion (%)", "type": "text", "options": []}, {"id": "a17bfcgnzmkwhziwa4tr38kiw5r", "name": "Note", "type": "text", "options": []}]	1672924691331	1672924691331	0	
bfeybjmgux7niix8i3smgb9b31a	2023-01-05 13:18:11.555344+00	0		system	system	O	Personal Goals 	Use this template to set and accomplish new personal goals.	⛰️	t	t	6	{"trackingTemplateId": "7f32dc8d2ae008cfe56554e9363505cc"}	[{"id": "af6fcbb8-ca56-4b73-83eb-37437b9a667d", "name": "Status", "type": "select", "options": [{"id": "bf52bfe6-ac4c-4948-821f-83eaa1c7b04a", "color": "propColorRed", "value": "To Do"}, {"id": "77c539af-309c-4db1-8329-d20ef7e9eacd", "color": "propColorYellow", "value": "Doing"}, {"id": "98bdea27-0cce-4cde-8dc6-212add36e63a", "color": "propColorGreen", "value": "Done 🙌"}]}, {"id": "d9725d14-d5a8-48e5-8de1-6f8c004a9680", "name": "Category", "type": "select", "options": [{"id": "3245a32d-f688-463b-87f4-8e7142c1b397", "color": "propColorPurple", "value": "Life Skills"}, {"id": "80be816c-fc7a-4928-8489-8b02180f4954", "color": "propColorGreen", "value": "Finance"}, {"id": "ffb3f951-b47f-413b-8f1d-238666728008", "color": "propColorOrange", "value": "Health"}]}, {"id": "d6b1249b-bc18-45fc-889e-bec48fce80ef", "name": "Target", "type": "select", "options": [{"id": "9a090e33-b110-4268-8909-132c5002c90e", "color": "propColorBlue", "value": "Q1"}, {"id": "0a82977f-52bf-457b-841b-e2b7f76fb525", "color": "propColorBrown", "value": "Q2"}, {"id": "6e7139e4-5358-46bb-8c01-7b029a57b80a", "color": "propColorGreen", "value": "Q3"}, {"id": "d5371c63-66bf-4468-8738-c4dc4bea4843", "color": "propColorPurple", "value": "Q4"}]}, {"id": "ajy6xbebzopojaenbnmfpgtdwso", "name": "Due Date", "type": "date", "options": []}]	1672924691562	1672924691562	0	
b195yoro7a7b4mkf4irwoj7cohy	2023-01-05 13:18:11.678364+00	0		system	system	O	Sprint Planner 	Use this template to plan your sprints and manage your releases more efficiently.	🗓️	t	t	6	{"trackingTemplateId": "99b74e26d2f5d0a9b346d43c0a7bfb09"}	[{"id": "50117d52-bcc7-4750-82aa-831a351c44a0", "name": "Status", "type": "select", "options": [{"id": "aft5bzo7h9aspqgrx3jpy5tzrer", "color": "propColorGray", "value": "Not Started"}, {"id": "abrfos7e7eczk9rqw6y5abadm1y", "color": "propColorOrange", "value": "Next Up"}, {"id": "ax8wzbka5ahs3zziji3pp4qp9mc", "color": "propColorBlue", "value": "In Progress"}, {"id": "atabdfbdmjh83136d5e5oysxybw", "color": "propColorYellow", "value": "In Review"}, {"id": "ace1bzypd586kkyhcht5qqd9eca", "color": "propColorPink", "value": "Approved"}, {"id": "aay656c9m1hzwxc9ch5ftymh3nw", "color": "propColorRed", "value": "Blocked"}, {"id": "a6ghze4iy441qhsh3eijnc8hwze", "color": "propColorGreen", "value": "Complete 🙌"}]}, {"id": "20717ad3-5741-4416-83f1-6f133fff3d11", "name": "Type", "type": "select", "options": [{"id": "424ea5e3-9aa1-4075-8c5c-01b44b66e634", "color": "propColorYellow", "value": "Epic ⛰"}, {"id": "a5yxq8rbubrpnoommfwqmty138h", "color": "propColorGray", "value": "Feature 🏗"}, {"id": "apht1nt5ryukdmxkh6fkfn6rgoy", "color": "propColorOrange", "value": "User Story 📖"}, {"id": "aiycbuo3dr5k4xxbfr7coem8ono", "color": "propColorGreen", "value": "Task ⛏"}, {"id": "aomnawq4551cbbzha9gxnmb3z5w", "color": "propColorRed", "value": "Bug 🐞"}]}, {"id": "60985f46-3e41-486e-8213-2b987440ea1c", "name": "Sprint", "type": "select", "options": [{"id": "c01676ca-babf-4534-8be5-cce2287daa6c", "color": "propColorBrown", "value": "Sprint 1"}, {"id": "ed4a5340-460d-461b-8838-2c56e8ee59fe", "color": "propColorPurple", "value": "Sprint 2"}, {"id": "14892380-1a32-42dd-8034-a0cea32bc7e6", "color": "propColorBlue", "value": "Sprint 3"}]}, {"id": "f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e", "name": "Priority", "type": "select", "options": [{"id": "cb8ecdac-38be-4d36-8712-c4d58cc8a8e9", "color": "propColorRed", "value": "P1 🔥"}, {"id": "e6a7f297-4440-4783-8ab3-3af5ba62ca11", "color": "propColorYellow", "value": "P2"}, {"id": "c62172ea-5da7-4dec-8186-37267d8ee9a7", "color": "propColorGray", "value": "P3"}]}, {"id": "aphg37f7zbpuc3bhwhp19s1ribh", "name": "Assignee", "type": "multiPerson", "options": []}, {"id": "a4378omyhmgj3bex13sj4wbpfiy", "name": "Due Date", "type": "date", "options": []}, {"id": "ai7ajsdk14w7x5s8up3dwir77te", "name": "Story Points", "type": "number", "options": []}, {"id": "a1g6i613dpe9oryeo71ex3c86hy", "name": "Design Link", "type": "url", "options": []}, {"id": "aeomttrbhhsi8bph31jn84sto6h", "name": "Created Time", "type": "createdTime", "options": []}, {"id": "ax9f8so418s6s65hi5ympd93i6a", "name": "Created By", "type": "createdBy", "options": []}]	1672924691684	1672924691684	0	
b69byqn5ghj8umfbseap3ky8qpo	2023-01-05 13:18:12.078234+00	0		system	system	O	User Research Sessions	Use this template to manage and keep track of all your user research sessions.	🔬	t	t	6	{"trackingTemplateId": "6c345c7f50f6833f78b7d0f08ce450a3"}	[{"id": "aaebj5fyx493eezx6ukxiwydgty", "name": "Status", "type": "select", "options": [{"id": "af6hjb3ysuaxbwnfqpby4wwnkdr", "color": "propColorGray", "value": "Backlog 📒"}, {"id": "aotxum1p5bw3xuzqz3ctjw66yww", "color": "propColorYellow", "value": "Contacted 📞"}, {"id": "a7yq89whddzob1futao4rxk3yzc", "color": "propColorBlue", "value": "Scheduled 📅"}, {"id": "aseqq9hrsua56r3s6nbuirj9eec", "color": "propColorRed", "value": "Cancelled 🚫"}, {"id": "ap93ysuzy1xa7z818r6myrn4h4y", "color": "propColorGreen", "value": "Completed ✔️"}]}, {"id": "akrxgi7p7w14fym3gbynb98t9fh", "name": "Interview Date", "type": "date", "options": []}, {"id": "atg9qu6oe4bjm8jczzsn71ff5me", "name": "Product Area", "type": "select", "options": [{"id": "ahn89mqg9u4igk6pdm7333t8i5h", "color": "propColorGreen", "value": "Desktop App"}, {"id": "aehc83ffays3gh8myz16a8j7k4e", "color": "propColorPurple", "value": "Web App"}, {"id": "a1sxagjgaadym5yrjak6tcup1oa", "color": "propColorBlue", "value": "Mobile App"}]}, {"id": "acjq4t5ymytu8x1f68wkggm7ypc", "name": "Email", "type": "email", "options": []}, {"id": "aphio1s5gkmpdbwoxynim7acw3e", "name": "Interviewer", "type": "multiPerson", "options": []}, {"id": "aqafzdeekpyncwz7m7i54q3iqqy", "name": "Recording URL", "type": "url", "options": []}, {"id": "aify3r761b9w43bqjtskrzi68tr", "name": "Passcode", "type": "text", "options": []}]	1672924692082	1672924692082	0	
bsw5maeiywtra5q79ms9ip59msa	2023-01-05 13:18:12.451033+00	0		system	system	O	Content Calendar 	Use this template to plan and organize your editorial content.	📅	t	t	6	{"trackingTemplateId": "c75fbd659d2258b5183af2236d176ab4"}	[{"id": "ae9ar615xoknd8hw8py7mbyr7zo", "name": "Status", "type": "select", "options": [{"id": "awna1nuarjca99m9s4uiy9kwj5h", "color": "propColorGray", "value": "Idea 💡"}, {"id": "a9ana1e9w673o5cp8md4xjjwfto", "color": "propColorOrange", "value": "Draft"}, {"id": "apy9dcd7zmand615p3h53zjqxjh", "color": "propColorPurple", "value": "In Review"}, {"id": "acri4cm3bmay55f7ksztphmtnga", "color": "propColorBlue", "value": "Ready to Publish"}, {"id": "amsowcd9a8e1kid317r7ttw6uzh", "color": "propColorGreen", "value": "Published 🎉"}]}, {"id": "aysx3atqexotgwp5kx6h5i5ancw", "name": "Type", "type": "select", "options": [{"id": "aywiofmmtd3ofgzj95ysky4pjga", "color": "propColorOrange", "value": "Press Release"}, {"id": "apqdgjrmsmx8ngmp7zst51647de", "color": "propColorGreen", "value": "Sponsored Post"}, {"id": "a3woynbjnb7j16e74uw3pubrytw", "color": "propColorPurple", "value": "Customer Story"}, {"id": "aq36k5pkpfcypqb3idw36xdi1fh", "color": "propColorRed", "value": "Product Release"}, {"id": "azn66pmk34adygnizjqhgiac4ia", "color": "propColorGray", "value": "Partnership"}, {"id": "aj8y675weso8kpb6eceqbpj4ruw", "color": "propColorBlue", "value": "Feature Announcement"}, {"id": "a3xky7ygn14osr1mokerbfah5cy", "color": "propColorYellow", "value": "Article"}]}, {"id": "ab6mbock6styfe6htf815ph1mhw", "name": "Channel", "type": "multiSelect", "options": [{"id": "a8xceonxiu4n3c43szhskqizicr", "color": "propColorBrown", "value": "Website"}, {"id": "a3pdzi53kpbd4okzdkz6khi87zo", "color": "propColorGreen", "value": "Blog"}, {"id": "a3d9ux4fmi3anyd11kyipfbhwde", "color": "propColorOrange", "value": "Email"}, {"id": "a8cbbfdwocx73zn3787cx6gacsh", "color": "propColorRed", "value": "Podcast"}, {"id": "aigjtpcaxdp7d6kmctrwo1ztaia", "color": "propColorPink", "value": "Print"}, {"id": "af1wsn13muho59e7ghwaogxy5ey", "color": "propColorBlue", "value": "Facebook"}, {"id": "a47zajfxwhsg6q8m7ppbiqs7jge", "color": "propColorGray", "value": "LinkedIn"}, {"id": "az8o8pfe9hq6s7xaehoqyc3wpyc", "color": "propColorYellow", "value": "Twitter"}]}, {"id": "ao44fz8nf6z6tuj1x31t9yyehcc", "name": "Assignee", "type": "person", "options": []}, {"id": "a39x5cybshwrbjpc3juaakcyj6e", "name": "Due Date", "type": "date", "options": []}, {"id": "agqsoiipowmnu9rdwxm57zrehtr", "name": "Publication Date", "type": "date", "options": []}, {"id": "ap4e7kdg7eip7j3c3oyiz39eaoc", "name": "Link", "type": "url", "options": []}]	1672924692456	1672924692456	0	
bomnbp7on3pfdtpby8bpzcesf8w	2023-01-05 13:18:12.730276+00	0		system	system	O	Team Retrospective	Use this template at the end of your project or sprint to identify what worked well and what can be improved for the future.	🧭	t	t	6	{"trackingTemplateId": "e4f03181c4ced8edd4d53d33d569a086"}	[{"id": "adjckpdotpgkz7c6wixzw9ipb1e", "name": "Category", "type": "select", "options": [{"id": "aok6pgecm85qe9k5kcphzoe63ma", "color": "propColorGray", "value": "To Discuss 📣"}, {"id": "aq1dwbf661yx337hjcd5q3sbxwa", "color": "propColorGreen", "value": "Went Well 👍"}, {"id": "ar87yh5xmsswqkxmjq1ipfftfpc", "color": "propColorRed", "value": "Didn't Go Well 🚫"}, {"id": "akj3fkmxq7idma55mdt8sqpumyw", "color": "propColorBlue", "value": "Action Items ✅"}]}, {"id": "aspaay76a5wrnuhtqgm97tt3rer", "name": "Details", "type": "text", "options": []}, {"id": "arzsm76s376y7suuhao3tu6efoc", "name": "Created By", "type": "createdBy", "options": []}, {"id": "a8anbe5fpa668sryatcdsuuyh8a", "name": "Created Time", "type": "createdTime", "options": []}]	1672924692734	1672924692734	0	
b89qgwoopj7r6iemxatthhb8ynw	2023-01-05 13:18:12.87149+00	0		system	system	O	Roadmap 	Use this template to plan your roadmap and manage your releases more efficiently.	🗺️	t	t	6	{"trackingTemplateId": "b728c6ca730e2cfc229741c5a4712b65"}	[{"id": "50117d52-bcc7-4750-82aa-831a351c44a0", "name": "Status", "type": "select", "options": [{"id": "8c557f69-b0ed-46ec-83a3-8efab9d47ef5", "color": "propColorGray", "value": "Not Started"}, {"id": "ec6d2bc5-df2b-4f77-8479-e59ceb039946", "color": "propColorYellow", "value": "In Progress"}, {"id": "849766ba-56a5-48d1-886f-21672f415395", "color": "propColorGreen", "value": "Complete 🙌"}]}, {"id": "20717ad3-5741-4416-83f1-6f133fff3d11", "name": "Type", "type": "select", "options": [{"id": "424ea5e3-9aa1-4075-8c5c-01b44b66e634", "color": "propColorYellow", "value": "Epic ⛰"}, {"id": "6eea96c9-4c61-4968-8554-4b7537e8f748", "color": "propColorGreen", "value": "Task 🔨"}, {"id": "1fdbb515-edd2-4af5-80fc-437ed2211a49", "color": "propColorRed", "value": "Bug 🐞"}]}, {"id": "60985f46-3e41-486e-8213-2b987440ea1c", "name": "Sprint", "type": "select", "options": [{"id": "c01676ca-babf-4534-8be5-cce2287daa6c", "color": "propColorBrown", "value": "Sprint 1"}, {"id": "ed4a5340-460d-461b-8838-2c56e8ee59fe", "color": "propColorPurple", "value": "Sprint 2"}, {"id": "14892380-1a32-42dd-8034-a0cea32bc7e6", "color": "propColorBlue", "value": "Sprint 3"}]}, {"id": "f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e", "name": "Priority", "type": "select", "options": [{"id": "cb8ecdac-38be-4d36-8712-c4d58cc8a8e9", "color": "propColorRed", "value": "P1 🔥"}, {"id": "e6a7f297-4440-4783-8ab3-3af5ba62ca11", "color": "propColorYellow", "value": "P2"}, {"id": "c62172ea-5da7-4dec-8186-37267d8ee9a7", "color": "propColorGray", "value": "P3"}]}, {"id": "aphg37f7zbpuc3bhwhp19s1ribh", "name": "Assignee", "type": "person", "options": []}, {"id": "a4378omyhmgj3bex13sj4wbpfiy", "name": "Due Date", "type": "date", "options": []}, {"id": "a36o9q1yik6nmar6ri4q4uca7ey", "name": "Created Date", "type": "createdTime", "options": []}, {"id": "ai7ajsdk14w7x5s8up3dwir77te", "name": "Design Link", "type": "url", "options": []}]	1672924692877	1672924692877	0	
bwzfh6d1x3fr8zb8gfxba65kjah	2023-01-05 13:18:12.257888+00	0		system	system	O	Competitive Analysis	Use this template to track and stay ahead of the competition.	🗂️	t	t	6	{"trackingTemplateId": "06f4bff367a7c2126fab2380c9dec23c"}	[{"id": "ahzspe59iux8wigra8bg6cg18nc", "name": "Website", "type": "url", "options": []}, {"id": "aozntq4go4nkab688j1s7stqtfc", "name": "Location", "type": "text", "options": []}, {"id": "aiefo7nh9jwisn8b4cgakowithy", "name": "Revenue", "type": "text", "options": []}, {"id": "a6cwaq79b1pdpb97wkanmeyy4er", "name": "Employees", "type": "number", "options": []}, {"id": "an1eerzscfxn6awdfajbg41uz3h", "name": "Founded", "type": "text", "options": []}, {"id": "a1semdhszu1rq17d7et5ydrqqio", "name": "Market Position", "type": "select", "options": [{"id": "arfjpz9by5car71tz3behba8yih", "color": "propColorYellow", "value": "Leader"}, {"id": "abajmr34b8g1916w495xjb35iko", "color": "propColorRed", "value": "Challenger"}, {"id": "abt79uxg5edqojsrrefcnr4eruo", "color": "propColorBlue", "value": "Follower"}, {"id": "aipf3qfgjtkheiayjuxrxbpk9wa", "color": "propColorBrown", "value": "Nicher"}]}, {"id": "aapogff3xoa8ym7xf56s87kysda", "name": "Last updated time", "type": "updatedTime", "options": []}, {"id": "az3jkw3ynd3mqmart7edypey15e", "name": "Last updated by", "type": "updatedBy", "options": []}]	1672924692261	1672924692261	0	
bajnungi3f3dyzn5rr9ok7u9jea	2023-01-05 13:18:13.314902+00	0		system	system	O	Welcome to Boards!	Mattermost Boards is an open source project management tool that helps you organize, track, and manage work across teams. Select a card to learn more.	👋	t	t	6	{"trackingTemplateId": "65aba997282f3ac457cd66736fb86915"}	[{"id": "a972dc7a-5f4c-45d2-8044-8c28c69717f1", "name": "Status", "type": "select", "options": [{"id": "amm6wfhnbuxojwssyftgs9dipqe", "color": "propColorRed", "value": "To do 🔥"}, {"id": "af3p8ztcyxgn8wd9z4az7o9tjeh", "color": "propColorYellow", "value": "Next up"}, {"id": "ajurey3xkocs1nwx8di5zx6oe7o", "color": "propColorPurple", "value": "Later"}, {"id": "agkinkjy5983wsk6kppsujajxqw", "color": "propColorGreen", "value": "Completed 🙌"}]}, {"id": "acypkejeb5yfujhj9te57p9kaxw", "name": "Priority", "type": "select", "options": [{"id": "aanaehcw3m13jytujsjk5hpf6ry", "color": "propColorOrange", "value": "1. High"}, {"id": "ascd7nm9r491ayot8i86g1gmgqw", "color": "propColorBrown", "value": "2. Medium"}, {"id": "aq6ukoiciyfctgwyhwzpfss8ghe", "color": "propColorGray", "value": "3. Low"}]}, {"id": "aqh13jabwexjkzr3jqsz1i1syew", "name": "Assignee", "type": "person", "options": []}, {"id": "acmg7mz1rr1eykfug4hcdpb1y1o", "name": "Due Date", "type": "date", "options": []}, {"id": "amewjwfjrtpu8ha73xsrdmxazxr", "name": "Reviewed", "type": "checkbox", "options": []}, {"id": "attzzboqaz6m1sdti5xa7gjnk1e", "name": "Last updated time", "type": "updatedTime", "options": []}, {"id": "a4nfnb5xr3txr5xq7y9ho7kyz6c", "name": "Reference", "type": "url", "options": []}, {"id": "a9gzwi3dt5n55nddej6zcbhxaeh", "name": "Created by", "type": "createdBy", "options": []}]	1672924693317	1672924693317	0	
\.


--
-- Data for Name: focalboard_categories; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_categories (id, name, user_id, team_id, channel_id, create_at, update_at, delete_at, collapsed, type) FROM stdin;
\.


--
-- Data for Name: focalboard_category_boards; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_category_boards (id, user_id, category_id, board_id, create_at, update_at, delete_at) FROM stdin;
\.


--
-- Data for Name: focalboard_file_info; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_file_info (id, create_at, delete_at, name, extension, size, archived) FROM stdin;
\.


--
-- Data for Name: focalboard_notification_hints; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_notification_hints (block_type, block_id, workspace_id, modified_by_id, create_at, notify_at) FROM stdin;
\.


--
-- Data for Name: focalboard_preferences; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_preferences (userid, category, name, value) FROM stdin;
\.


--
-- Data for Name: focalboard_schema_migrations; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_schema_migrations (version, name) FROM stdin;
1	init
2	system_settings_table
3	blocks_rootid
4	auth_table
5	blocks_modifiedby
6	sharing_table
7	workspaces_table
8	teams
9	blocks_history
10	blocks_created_by
11	match_collation
12	match_column_collation
13	millisecond_timestamps
14	add_not_null_constraint
15	blocks_history_no_nulls
16	subscriptions_table
17	add_file_info
18	add_teams_and_boards
19	populate_categories
20	populate_category_blocks
21	create_boards_members_history
22	create_default_board_role
23	persist_category_collapsed_state
24	mark_existsing_categories_collapsed
25	indexes_update
26	create_preferences_table
27	migrate_user_props_to_preferences
28	remove_template_channel_link
29	add_category_type_field
\.


--
-- Data for Name: focalboard_sessions; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_sessions (id, token, user_id, props, create_at, update_at, auth_service) FROM stdin;
\.


--
-- Data for Name: focalboard_sharing; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_sharing (id, enabled, token, modified_by, update_at, workspace_id) FROM stdin;
\.


--
-- Data for Name: focalboard_subscriptions; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_subscriptions (block_type, block_id, workspace_id, subscriber_type, subscriber_id, notified_at, create_at, delete_at) FROM stdin;
\.


--
-- Data for Name: focalboard_system_settings; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_system_settings (id, value) FROM stdin;
UniqueIDsMigrationComplete	true
TeamLessBoardsMigrationComplete	true
DeletedMembershipBoardsMigrationComplete	true
CategoryUuidIdMigrationComplete	true
TelemetryID	7u3cjnoft3bratmiwn3j3ipgu9y
\.


--
-- Data for Name: focalboard_teams; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_teams (id, signup_token, settings, modified_by, update_at) FROM stdin;
\.


--
-- Data for Name: focalboard_users; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_users (id, username, email, password, mfa_secret, auth_service, auth_data, props, create_at, update_at, delete_at) FROM stdin;
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
-- Data for Name: ir_category; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.ir_category (id, name, teamid, userid, collapsed, createat, updateat, deleteat) FROM stdin;
\.


--
-- Data for Name: ir_category_item; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.ir_category_item (type, categoryid, itemid) FROM stdin;
\.


--
-- Data for Name: ir_channelaction; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.ir_channelaction (id, channelid, enabled, deleteat, actiontype, triggertype, payload) FROM stdin;
\.


--
-- Data for Name: ir_incident; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.ir_incident (id, name, description, isactive, commanderuserid, teamid, channelid, createat, endat, deleteat, activestage, postid, playbookid, checklistsjson, activestagetitle, reminderpostid, broadcastchannelid, previousreminder, remindermessagetemplate, currentstatus, reporteruserid, concatenatedinviteduserids, defaultcommanderid, announcementchannelid, concatenatedwebhookoncreationurls, concatenatedinvitedgroupids, retrospective, messageonjoin, retrospectivepublishedat, retrospectivereminderintervalseconds, retrospectivewascanceled, concatenatedwebhookonstatusupdateurls, laststatusupdateat, exportchannelonfinishedenabled, categorizechannelenabled, categoryname, concatenatedbroadcastchannelids, channelidtorootid, remindertimerdefaultseconds, statusupdateenabled, retrospectiveenabled, statusupdatebroadcastchannelsenabled, statusupdatebroadcastwebhooksenabled, summarymodifiedat) FROM stdin;
\.


--
-- Data for Name: ir_metric; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.ir_metric (incidentid, metricconfigid, value, published) FROM stdin;
\.


--
-- Data for Name: ir_metricconfig; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.ir_metricconfig (id, playbookid, title, description, type, target, ordering, deleteat) FROM stdin;
\.


--
-- Data for Name: ir_playbook; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.ir_playbook (id, title, description, teamid, createpublicincident, createat, deleteat, checklistsjson, numstages, numsteps, broadcastchannelid, remindermessagetemplate, remindertimerdefaultseconds, concatenatedinviteduserids, inviteusersenabled, defaultcommanderid, defaultcommanderenabled, announcementchannelid, announcementchannelenabled, concatenatedwebhookoncreationurls, webhookoncreationenabled, concatenatedinvitedgroupids, messageonjoin, messageonjoinenabled, retrospectivereminderintervalseconds, retrospectivetemplate, concatenatedwebhookonstatusupdateurls, webhookonstatusupdateenabled, concatenatedsignalanykeywords, signalanykeywordsenabled, updateat, exportchannelonfinishedenabled, categorizechannelenabled, categoryname, concatenatedbroadcastchannelids, broadcastenabled, runsummarytemplate, channelnametemplate, statusupdateenabled, retrospectiveenabled, public, runsummarytemplateenabled) FROM stdin;
\.


--
-- Data for Name: ir_playbookautofollow; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.ir_playbookautofollow (playbookid, userid) FROM stdin;
\.


--
-- Data for Name: ir_playbookmember; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.ir_playbookmember (playbookid, memberid, roles) FROM stdin;
\.


--
-- Data for Name: ir_run_participants; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.ir_run_participants (userid, incidentid, isfollower) FROM stdin;
\.


--
-- Data for Name: ir_statusposts; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.ir_statusposts (incidentid, postid) FROM stdin;
\.


--
-- Data for Name: ir_system; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.ir_system (skey, svalue) FROM stdin;
DatabaseVersion	0.56.0
\.


--
-- Data for Name: ir_timelineevent; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.ir_timelineevent (id, incidentid, createat, deleteat, eventat, eventtype, summary, details, postid, subjectuserid, creatoruserid) FROM stdin;
\.


--
-- Data for Name: ir_userinfo; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.ir_userinfo (id, lastdailytododmat, digestnotificationsettingsjson) FROM stdin;
5bw66y36bff3umq1q57mfy4y5c	1672924733521	{"disable_daily_digest":false}
bmq7jiumpib3xdz3mx5iyo99ro	1672925223506	{"disable_daily_digest":false}
\.


--
-- Data for Name: ir_viewedchannel; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.ir_viewedchannel (channelid, userid) FROM stdin;
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.jobs (id, type, priority, createat, startat, lastactivityat, status, progress, data) FROM stdin;
fky8msypr7nhbko6jm1fydozow	migrations	0	1598351829123	1598351839894	1598351840103	success	0	{"last_done": "{\\"current_table\\":\\"ChannelMembers\\",\\"last_team_id\\":\\"00000000000000000000000000\\",\\"last_channel_id\\":\\"00000000000000000000000000\\",\\"last_user\\":\\"00000000000000000000000000\\"}", "migration_key": "migration_advanced_permissions_phase_2"}
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
8dsk9x1etfr68eset79okpzw1y	expiry_notify	0	1672925286309	1672925293515	1672925293531	success	0	null
omouhqz3up8r5fhs1qz5pjjuwe	expiry_notify	0	1673367614930	1673367621086	1673367621092	success	0	null
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
-- Data for Name: notifyadmin; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.notifyadmin (userid, createat, requiredplan, requiredfeature, trial) FROM stdin;
\.


--
-- Data for Name: oauthaccessdata; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.oauthaccessdata (clientid, userid, token, refreshtoken, redirecturi, expiresat, scope) FROM stdin;
\.


--
-- Data for Name: oauthapps; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.oauthapps (id, creatorid, createat, updateat, clientsecret, name, description, iconurl, callbackurls, homepage, istrusted, mattermostappid) FROM stdin;
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
com.mattermost.apps	mmi_botid	\\x6271793773663335727467633379656b75696d78343368386279	0
playbooks	mmi_botid	\\x343567647467696174706633706679666769746d356b39637872	0
focalboard	mmi_botid	\\x796634637763656e796a6462666b367a7a393731336e6165646f	0
\.


--
-- Data for Name: postreminders; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.postreminders (postid, userid, targettime) FROM stdin;
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.posts (id, createat, updateat, editat, deleteat, ispinned, userid, channelid, rootid, originalid, message, type, props, hashtags, filenames, fileids, hasreactions, remoteid) FROM stdin;
18k3695ojtrhfqob4fyms69ciw	1672856703968	1672856703968	0	0	f	1fgsimi9s3rmjxzxsaeqrr66ko	cxtmz3ubz3gfigd5m6prendmsw			matrix_matrix_a joined the team.	system_join_team	{"username": "matrix_matrix_a"}		[]	[]	f	\N
98hfz3hfotdbpebfmpuaxtm47w	1672856703994	1672856703994	0	0	f	1fgsimi9s3rmjxzxsaeqrr66ko	73uy6kj1jb8wdqrf3ti6zies6r			matrix_matrix_a joined the channel.	system_join_channel	{"username": "matrix_matrix_a"}		[]	[]	f	\N
rgumdwrdrpffzp3fuyzmqgda7c	1672856704279	1672856704279	0	0	f	kgr5hfwxy78k5n9gfkdhcscdoc	cxtmz3ubz3gfigd5m6prendmsw			matrix_matrix_b joined the team.	system_join_team	{"username": "matrix_matrix_b"}		[]	[]	f	\N
rangim3hatnypxq6o49qypjh1y	1672856704327	1672856704327	0	0	f	kgr5hfwxy78k5n9gfkdhcscdoc	73uy6kj1jb8wdqrf3ti6zies6r			matrix_matrix_b joined the channel.	system_join_channel	{"username": "matrix_matrix_b"}		[]	[]	f	\N
rrorpwj3ttfptfqm64s4duapgy	1672856704323	1672856704323	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	73uy6kj1jb8wdqrf3ti6zies6r			matrix_matrix_b added to the channel by admin.	system_add_to_channel	{"userId": "bmq7jiumpib3xdz3mx5iyo99ro", "username": "admin", "addedUserId": "kgr5hfwxy78k5n9gfkdhcscdoc", "addedUsername": "matrix_matrix_b"}		[]	[]	f	\N
zaqw6nbri7b7uyahc8je5ms4jc	1672856705901	1672856705901	0	0	f	5bw66y36bff3umq1q57mfy4y5c	cxtmz3ubz3gfigd5m6prendmsw			test		{}		[]	[]	f	\N
7azm5pwxk3nbdx8ixpqir5draa	1672856706384	1672856706384	0	0	f	1fgsimi9s3rmjxzxsaeqrr66ko	cxtmz3ubz3gfigd5m6prendmsw			test2		{}		[]	[]	f	\N
pi3xicw5r78q9bnties3txu1th	1672856706470	1672856706470	0	0	f	5bw66y36bff3umq1q57mfy4y5c	cxtmz3ubz3gfigd5m6prendmsw			# Header\n\n**bold**		{}		[]	[]	f	\N
cn1xnusgrtbo3btpidqpwmttca	1672856706939	1672856706939	0	0	f	kgr5hfwxy78k5n9gfkdhcscdoc	cxtmz3ubz3gfigd5m6prendmsw			Header\n======\n\n**Bolded text**		{}		[]	[]	f	\N
debuqhoasjgktrzxtdqppwku5o	1672856707022	1672856707022	0	0	f	5bw66y36bff3umq1q57mfy4y5c	73uy6kj1jb8wdqrf3ti6zies6r			*hi me*	me	{"message": "hi me"}		[]	[]	f	\N
1pe3kybx5tyo9jiq3bify8ptrh	1672856707403	1672856707403	0	0	f	1fgsimi9s3rmjxzxsaeqrr66ko	cxtmz3ubz3gfigd5m6prendmsw			*test*	me	{"message": "test"}		[]	[]	f	\N
7qj53zemsbnzdgad76g9ifw6hc	1672856707526	1672856707526	0	0	f	3zats68fztgu9mgu944a4t35so	73uy6kj1jb8wdqrf3ti6zies6r			filename		{}		[]	["kpadhxdtotddukna1hnf993bir"]	f	\N
op4mz46j4pywu8at8f9k5hk8wy	1672856708115	1672856708115	0	0	f	1fgsimi9s3rmjxzxsaeqrr66ko	cxtmz3ubz3gfigd5m6prendmsw					{}		[]	["neqkjkfddigrpbn13jtppboecw"]	f	\N
96xmitp7qjnu389ecctrja49kr	1672856710756	1672856710756	0	0	f	1fgsimi9s3rmjxzxsaeqrr66ko	73uy6kj1jb8wdqrf3ti6zies6r			hidden message		{}		[]	[]	f	\N
frbqs14mqbykjr5q35n59s9sko	1672921846313	1672921846313	0	0	f	98kwr77m4jgwmbdgygknaowcch	9eiccer1gfbzzpf8yfbze74n3e			user1 joined the team.	system_join_team	{"username": "user1"}		[]	[]	f	\N
ndech86d9briprnyb4mhdapmcr	1672921846351	1672921846351	0	0	f	98kwr77m4jgwmbdgygknaowcch	dckusnmodbnubf7hcu369adaio			user1 joined the channel.	system_join_channel	{"username": "user1"}		[]	[]	f	\N
suiocyjea3fe5mhucpk7rngg3h	1672922006348	1672922006348	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	cxtmz3ubz3gfigd5m6prendmsw			user1 added to the team by admin.	system_add_to_team	{"userId": "bmq7jiumpib3xdz3mx5iyo99ro", "username": "admin", "addedUserId": "98kwr77m4jgwmbdgygknaowcch", "addedUsername": "user1"}		[]	[]	f	\N
kusfngm4xtn9mbigjfmbzyqopw	1672922006383	1672922006383	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	73uy6kj1jb8wdqrf3ti6zies6r			user1 added to the channel by admin.	system_add_to_channel	{"userId": "bmq7jiumpib3xdz3mx5iyo99ro", "username": "admin", "addedUserId": "98kwr77m4jgwmbdgygknaowcch", "addedUsername": "user1"}		[]	[]	f	\N
81x8fwbat3n38eikpndaapuj9c	1672922076871	1672922076871	0	0	f	98kwr77m4jgwmbdgygknaowcch	dckusnmodbnubf7hcu369adaio			This channel has been converted to a Private Channel.	system_change_chan_privacy	{"username": "user1"}		[]	[]	f	\N
kf5pow5zn3ysundqnryufqsyjy	1672922135142	1672922135142	0	0	f	98kwr77m4jgwmbdgygknaowcch	9eiccer1gfbzzpf8yfbze74n3e			user1 left the team.	system_leave_team	{"username": "user1"}		[]	[]	f	\N
sshopdjyojrtjmn3zqjbhpk8ie	1672922164548	1672922164548	0	0	f	98kwr77m4jgwmbdgygknaowcch	cxtmz3ubz3gfigd5m6prendmsw			Hi I am writing now 		{"disable_group_highlight": true}		[]	[]	f	\N
1rgwxi9fnbdifr7md7zf1rsnnr	1672922248606	1672922248606	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	cxtmz3ubz3gfigd5m6prendmsw			matrix_user1 added to the channel by admin.	system_add_to_channel	{"userId": "bmq7jiumpib3xdz3mx5iyo99ro", "username": "admin", "addedUserId": "she685ewdtyq7m7jgmys7zoqmr", "addedUsername": "matrix_user1"}		[]	[]	f	\N
6inf8oagn3fsfgmrkiuu1uedhe	1672922248660	1672922248660	0	0	f	she685ewdtyq7m7jgmys7zoqmr	cxtmz3ubz3gfigd5m6prendmsw			matrix_user1 joined the team.	system_join_team	{"username": "matrix_user1"}		[]	[]	f	\N
cyu4bcmurprymre6ofr6b1drfr	1672922248798	1672922248798	0	0	f	she685ewdtyq7m7jgmys7zoqmr	73uy6kj1jb8wdqrf3ti6zies6r			matrix_user1 joined the channel.	system_join_channel	{"username": "matrix_user1"}		[]	[]	f	\N
7op8pa1a43rbtmi5bscf41oefw	1672922287657	1672922287657	0	0	f	98kwr77m4jgwmbdgygknaowcch	cxtmz3ubz3gfigd5m6prendmsw			Like this channel		{"disable_group_highlight": true}		[]	[]	f	\N
os6sm85ooiy68go7b4uqibhgdy	1672922547481	1672922547481	0	0	f	98kwr77m4jgwmbdgygknaowcch	cxtmz3ubz3gfigd5m6prendmsw			Are you online @matrix_user1 ?		{"disable_group_highlight": true}		[]	[]	f	\N
grcxd88ak7rsxpia59fadzb7aa	1672922654416	1672922654416	0	0	f	98kwr77m4jgwmbdgygknaowcch	73uy6kj1jb8wdqrf3ti6zies6r			A program		{"disable_group_highlight": true}		[]	["t5mx13mgzby65be4tgz33qnppc"]	f	\N
hp4449juf7d8xc591q3rnejfcc	1672923027698	1672923027698	0	0	f	5bw66y36bff3umq1q57mfy4y5c	73uy6kj1jb8wdqrf3ti6zies6r			Nice		{"disable_group_highlight": true}		[]	[]	f	\N
ddxjx3ynkfds5gaqymm8x8jiwr	1672923085571	1672923085571	0	0	f	5bw66y36bff3umq1q57mfy4y5c	g18pe3wojtr65rnxnm4ugmuq4h			mattermost_a joined the channel.	system_join_channel	{"username": "mattermost_a"}		[]	[]	f	\N
39k1ghs65fgt8kzttx7fkpn75y	1672923120172	1672923120172	0	0	f	5bw66y36bff3umq1q57mfy4y5c	g18pe3wojtr65rnxnm4ugmuq4h			user1 added to the channel by mattermost_a.	system_add_to_channel	{"userId": "5bw66y36bff3umq1q57mfy4y5c", "username": "mattermost_a", "addedUserId": "98kwr77m4jgwmbdgygknaowcch", "addedUsername": "user1"}		[]	[]	f	\N
aiqniqrnppns9r76nqm7meiydr	1672923120190	1672923120190	0	0	f	5bw66y36bff3umq1q57mfy4y5c	g18pe3wojtr65rnxnm4ugmuq4h			matrix_user1 added to the channel by mattermost_a.	system_add_to_channel	{"userId": "5bw66y36bff3umq1q57mfy4y5c", "username": "mattermost_a", "addedUserId": "she685ewdtyq7m7jgmys7zoqmr", "addedUsername": "matrix_user1"}		[]	[]	f	\N
qbkfa8qc1trxmyx6b3m1wgizda	1672923120283	1672923120283	0	0	f	5bw66y36bff3umq1q57mfy4y5c	g18pe3wojtr65rnxnm4ugmuq4h			matrix_matrix_a added to the channel by mattermost_a.	system_add_to_channel	{"userId": "5bw66y36bff3umq1q57mfy4y5c", "username": "mattermost_a", "addedUserId": "1fgsimi9s3rmjxzxsaeqrr66ko", "addedUsername": "matrix_matrix_a"}		[]	[]	f	\N
d3ke1cnikfbe7pwjozzdypzkur	1672923120319	1672923120319	0	0	f	5bw66y36bff3umq1q57mfy4y5c	g18pe3wojtr65rnxnm4ugmuq4h			admin added to the channel by mattermost_a.	system_add_to_channel	{"userId": "5bw66y36bff3umq1q57mfy4y5c", "username": "mattermost_a", "addedUserId": "bmq7jiumpib3xdz3mx5iyo99ro", "addedUsername": "admin"}		[]	[]	f	\N
888qct7tebdopchaaj7qsu89ge	1672923120329	1672923120329	0	0	f	5bw66y36bff3umq1q57mfy4y5c	g18pe3wojtr65rnxnm4ugmuq4h			mattermost_b added to the channel by mattermost_a.	system_add_to_channel	{"userId": "5bw66y36bff3umq1q57mfy4y5c", "username": "mattermost_a", "addedUserId": "3zats68fztgu9mgu944a4t35so", "addedUsername": "mattermost_b"}		[]	[]	f	\N
tnq9t7qtqtd6friw8dn59hgqsr	1672923135329	1672923135329	0	0	f	5bw66y36bff3umq1q57mfy4y5c	g18pe3wojtr65rnxnm4ugmuq4h			This is a bug		{"disable_group_highlight": true}		[]	[]	f	\N
xo3swh5gatrj9rryi8bpdp8ekc	1672924805764	1672924805764	0	0	f	98kwr77m4jgwmbdgygknaowcch	u3ui7pauojynpf6ho5unykg4qc			user1 joined the team.	system_join_team	{"username": "user1"}		[]	[]	f	\N
m5ia7b9zjtfkfefdb5dpbedtso	1672924805795	1672924805795	0	0	f	98kwr77m4jgwmbdgygknaowcch	hmim91mc7t88urik4qresfo3oh			user1 joined the channel.	system_join_channel	{"username": "user1"}		[]	[]	f	\N
f74g44wg1ibd38dcp9efjzdbay	1672925152453	1672925152453	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	73uy6kj1jb8wdqrf3ti6zies6r			OK Now I am here		{"disable_group_highlight": true}		[]	[]	f	\N
y3s8zhw5g78jiey4kizi541fbe	1672925376060	1672925376060	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	73uy6kj1jb8wdqrf3ti6zies6r			This is VC Code thing		{"disable_group_highlight": true}		[]	["n8ihtkozc3f8tk7yornbfx49zw"]	f	\N
sp7qgz6ijbgn9jihnr9gq41qzh	1672925487995	1672925487995	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	73uy6kj1jb8wdqrf3ti6zies6r			I am here now		{"disable_group_highlight": true}		[]	[]	f	\N
fpquforpy3yf5gn1tfk5yi6bhr	1673367804247	1673367804247	0	0	f	1fgsimi9s3rmjxzxsaeqrr66ko	g18pe3wojtr65rnxnm4ugmuq4h			@matrix_matrix_a left the channel.	system_leave_channel	{"username": "matrix_matrix_a"}		[]	[]	f	\N
kbh8dbwu8frd8echyg6765msja	1673367804276	1673367804276	0	0	f	she685ewdtyq7m7jgmys7zoqmr	g18pe3wojtr65rnxnm4ugmuq4h			@matrix_user1 left the channel.	system_leave_channel	{"username": "matrix_user1"}		[]	[]	f	\N
oqk155cwqfrn5er1mm74kzgkga	1673367804341	1673367804341	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	g18pe3wojtr65rnxnm4ugmuq4h			@admin left the channel.	system_leave_channel	{"username": "admin"}		[]	[]	f	\N
i5k4s56rgbfstmn999rzy1i5kh	1673367804396	1673367804396	0	0	f	5bw66y36bff3umq1q57mfy4y5c	cxtmz3ubz3gfigd5m6prendmsw			test		{}		[]	[]	f	\N
t71qaw1t4frwfxf1nhumzkguzh	1673367882634	1673367882634	0	0	f	5bw66y36bff3umq1q57mfy4y5c	cxtmz3ubz3gfigd5m6prendmsw			test		{}		[]	[]	f	\N
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
5bw66y36bff3umq1q57mfy4y5c	onboarding_task_list	onboarding_task_list_show	true
5bw66y36bff3umq1q57mfy4y5c	recommended_next_steps	hide	true
5bw66y36bff3umq1q57mfy4y5c	onboarding_task_list	onboarding_task_list_open	false
98kwr77m4jgwmbdgygknaowcch	onboarding_task_list	onboarding_task_list_show	true
98kwr77m4jgwmbdgygknaowcch	recommended_next_steps	hide	true
98kwr77m4jgwmbdgygknaowcch	onboarding_task_list	onboarding_task_list_open	false
bmq7jiumpib3xdz3mx5iyo99ro	onboarding_task_list	onboarding_task_list_show	true
bmq7jiumpib3xdz3mx5iyo99ro	recommended_next_steps	hide	true
bmq7jiumpib3xdz3mx5iyo99ro	onboarding_task_list	onboarding_task_list_open	false
bmq7jiumpib3xdz3mx5iyo99ro	crt_thread_pane_step	bmq7jiumpib3xdz3mx5iyo99ro	999
\.


--
-- Data for Name: productnoticeviewstate; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.productnoticeviewstate (userid, noticeid, viewed, "timestamp") FROM stdin;
5bw66y36bff3umq1q57mfy4y5c	june15-cloud-freemium	1	1672924735
98kwr77m4jgwmbdgygknaowcch	june15-cloud-freemium	1	1672924806
bmq7jiumpib3xdz3mx5iyo99ro	june15-cloud-freemium	1	1672924984
bmq7jiumpib3xdz3mx5iyo99ro	crt-user-always-on	1	1672924987
bmq7jiumpib3xdz3mx5iyo99ro	v6.0_user_introduction	1	1672924991
bmq7jiumpib3xdz3mx5iyo99ro	v6.2_boards	1	1672925224
\.


--
-- Data for Name: publicchannels; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.publicchannels (id, deleteat, teamid, displayname, name, header, purpose) FROM stdin;
cxtmz3ubz3gfigd5m6prendmsw	0	tgrw7sjgbiy1jggs3qg3m6zpee	Town Square	town-square		
73uy6kj1jb8wdqrf3ti6zies6r	0	tgrw7sjgbiy1jggs3qg3m6zpee	Off-Topic	off-topic		
9eiccer1gfbzzpf8yfbze74n3e	0	7jenmotdwfdq7mmci7zz7hfpze	Town Square	town-square		
g18pe3wojtr65rnxnm4ugmuq4h	0	tgrw7sjgbiy1jggs3qg3m6zpee	Bugs in bridge	bugs-in-bridge		
u3ui7pauojynpf6ho5unykg4qc	0	gajwz6y3efb3mcrsman43cqmxo	Town Square	town-square		
hmim91mc7t88urik4qresfo3oh	0	gajwz6y3efb3mcrsman43cqmxo	Off-Topic	off-topic		
\.


--
-- Data for Name: reactions; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.reactions (userid, postid, emojiname, createat, updateat, deleteat, remoteid, channelid) FROM stdin;
\.


--
-- Data for Name: recentsearches; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.recentsearches (userid, searchpointer, query, createat) FROM stdin;
\.


--
-- Data for Name: remoteclusters; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.remoteclusters (remoteid, remoteteamid, name, displayname, siteurl, createat, lastpingat, token, remotetoken, topics, creatorid) FROM stdin;
\.


--
-- Data for Name: retentionpolicies; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.retentionpolicies (id, displayname, postduration) FROM stdin;
\.


--
-- Data for Name: retentionpolicieschannels; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.retentionpolicieschannels (policyid, channelid) FROM stdin;
\.


--
-- Data for Name: retentionpoliciesteams; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.retentionpoliciesteams (policyid, teamid) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.roles (id, name, displayname, description, createat, updateat, deleteat, permissions, schememanaged, builtin) FROM stdin;
sw8erru9jjyzfegokosh9sb15h	system_user_access_token	authentication.roles.system_user_access_token.name	authentication.roles.system_user_access_token.description	1598351767769	1672924680872	0	 create_user_access_token read_user_access_token revoke_user_access_token	f	t
gx5q8e1wz3ymje5g7rb4t5xkww	system_read_only_admin	authentication.roles.system_read_only_admin.name	authentication.roles.system_read_only_admin.description	1672924679767	1672924680887	0	 sysconsole_read_environment_high_availability sysconsole_read_integrations_cors sysconsole_read_environment_image_proxy sysconsole_read_authentication_signup sysconsole_read_user_management_teams read_channel sysconsole_read_about_edition_and_license sysconsole_read_environment_push_notification_server list_private_teams sysconsole_read_environment_database sysconsole_read_authentication_openid read_license_information read_data_retention_job sysconsole_read_compliance_compliance_monitoring read_elasticsearch_post_indexing_job list_public_teams sysconsole_read_compliance_data_retention_policy sysconsole_read_user_management_permissions test_ldap sysconsole_read_environment_smtp read_compliance_export_job sysconsole_read_site_public_links sysconsole_read_compliance_custom_terms_of_service sysconsole_read_site_notices sysconsole_read_user_management_groups sysconsole_read_user_management_channels read_ldap_sync_job sysconsole_read_environment_developer sysconsole_read_reporting_site_statistics sysconsole_read_experimental_feature_flags sysconsole_read_environment_file_storage read_public_channel sysconsole_read_integrations_gif sysconsole_read_environment_web_server sysconsole_read_environment_logging sysconsole_read_site_users_and_teams sysconsole_read_integrations_integration_management sysconsole_read_authentication_mfa sysconsole_read_authentication_password read_private_channel_groups sysconsole_read_environment_elasticsearch sysconsole_read_integrations_bot_accounts sysconsole_read_products_boards sysconsole_read_site_emoji sysconsole_read_plugins download_compliance_export_result sysconsole_read_authentication_ldap sysconsole_read_compliance_compliance_export sysconsole_read_site_notifications sysconsole_read_experimental_features sysconsole_read_site_announcement_banner sysconsole_read_site_customization view_team read_audits sysconsole_read_authentication_email sysconsole_read_environment_session_lengths sysconsole_read_environment_rate_limiting sysconsole_read_authentication_guest_access sysconsole_read_site_localization read_elasticsearch_post_aggregation_job read_public_channel_groups sysconsole_read_site_posts sysconsole_read_reporting_team_statistics read_other_users_teams sysconsole_read_experimental_bleve sysconsole_read_user_management_users get_analytics sysconsole_read_site_file_sharing_and_downloads get_logs sysconsole_read_authentication_saml sysconsole_read_environment_performance_monitoring sysconsole_read_reporting_server_logs	f	t
h3bzrt4zcjr6znk1pnxp7g78eh	system_user_manager	authentication.roles.system_user_manager.name	authentication.roles.system_user_manager.description	1672924679780	1672924680889	0	 join_public_teams manage_channel_roles list_public_teams manage_team delete_public_channel read_private_channel_groups sysconsole_read_authentication_email list_private_teams sysconsole_read_authentication_openid manage_private_channel_properties manage_public_channel_members read_public_channel test_ldap sysconsole_read_authentication_password sysconsole_read_authentication_mfa convert_private_channel_to_public view_team sysconsole_read_user_management_permissions sysconsole_read_user_management_groups sysconsole_read_authentication_signup sysconsole_write_user_management_channels join_private_teams manage_private_channel_members sysconsole_read_user_management_channels sysconsole_write_user_management_groups remove_user_from_team manage_public_channel_properties sysconsole_write_user_management_teams manage_team_roles delete_private_channel convert_public_channel_to_private read_channel sysconsole_read_user_management_teams add_user_to_team sysconsole_read_authentication_ldap sysconsole_read_authentication_saml read_ldap_sync_job sysconsole_read_authentication_guest_access read_public_channel_groups	f	t
ghsp7z49qbbi5bhuoqaqqs6ake	channel_admin	authentication.roles.channel_admin.name	authentication.roles.channel_admin.description	1598351767766	1672924680866	0	 create_post use_channel_mentions use_group_mentions remove_reaction add_reaction read_public_channel_groups manage_public_channel_members manage_private_channel_members manage_channel_roles read_private_channel_groups	t	t
t6x4ph1uojb398ciuhkgqzexfw	channel_user	authentication.roles.channel_user.name	authentication.roles.channel_user.description	1598351767775	1672924680867	0	 upload_file manage_private_channel_members delete_private_channel read_public_channel_groups read_private_channel_groups read_channel manage_public_channel_members delete_public_channel get_public_link create_post remove_reaction use_channel_mentions edit_post manage_public_channel_properties add_reaction use_slash_commands delete_post use_group_mentions manage_private_channel_properties	t	t
gygr3fd64p8izpynu6uef8jq3r	channel_guest	authentication.roles.channel_guest.name	authentication.roles.channel_guest.description	1598351767780	1672924680869	0	 use_slash_commands read_channel add_reaction remove_reaction upload_file edit_post create_post use_channel_mentions	t	t
qd7fy1q5d3b7jkrttdqwz1rp7w	system_custom_group_admin	authentication.roles.system_custom_group_admin.name	authentication.roles.system_custom_group_admin.description	1672924679793	1672924680891	0	 create_custom_group edit_custom_group delete_custom_group manage_custom_group_members	f	t
cqedmkhfmtfhidp18w8pkogtpa	team_post_all	authentication.roles.team_post_all.name	authentication.roles.team_post_all.description	1598351767777	1672924680854	0	 use_group_mentions use_channel_mentions create_post	f	t
qj5hbu454fn63njq69nni3drxh	system_post_all	authentication.roles.system_post_all.name	authentication.roles.system_post_all.description	1598351767778	1672924680856	0	 create_post use_channel_mentions use_group_mentions	f	t
abmhgi8pa3robkzd7kfzongfmc	system_guest	authentication.roles.global_guest.name	authentication.roles.global_guest.description	1598351767761	1672924680857	0	 create_direct_channel create_group_channel	t	t
jgrdf15eifyu5gsrum87u8ka5y	team_guest	authentication.roles.team_guest.name	authentication.roles.team_guest.description	1598351767768	1672924680870	0	 view_team	t	t
3sojxu7t47r95cfjs94yywyd9c	system_post_all_public	authentication.roles.system_post_all_public.name	authentication.roles.system_post_all_public.description	1598351767764	1672924680859	0	 use_channel_mentions use_group_mentions create_post_public	f	t
k41fws3i97ffmrjjrexhxjz6tc	system_manager	authentication.roles.system_manager.name	authentication.roles.system_manager.description	1672924679750	1672924680885	0	 sysconsole_read_site_notifications read_ldap_sync_job manage_private_channel_properties sysconsole_write_environment_performance_monitoring sysconsole_read_site_posts read_public_channel sysconsole_read_authentication_password sysconsole_read_user_management_teams sysconsole_read_user_management_channels sysconsole_read_products_boards test_ldap sysconsole_write_user_management_permissions list_public_teams sysconsole_read_environment_elasticsearch create_elasticsearch_post_aggregation_job sysconsole_write_site_users_and_teams edit_brand convert_public_channel_to_private sysconsole_read_integrations_integration_management remove_user_from_team sysconsole_read_environment_smtp sysconsole_read_environment_image_proxy sysconsole_read_integrations_cors sysconsole_write_site_emoji sysconsole_read_authentication_openid sysconsole_write_integrations_bot_accounts sysconsole_write_site_customization manage_team sysconsole_read_site_localization sysconsole_read_reporting_server_logs sysconsole_write_environment_push_notification_server sysconsole_read_authentication_ldap recycle_database_connections sysconsole_read_environment_push_notification_server sysconsole_read_site_file_sharing_and_downloads sysconsole_write_user_management_channels sysconsole_read_site_notices delete_private_channel convert_private_channel_to_public purge_elasticsearch_indexes sysconsole_write_environment_high_availability sysconsole_read_about_edition_and_license sysconsole_read_environment_file_storage read_channel invalidate_caches sysconsole_write_environment_image_proxy read_license_information join_private_teams sysconsole_read_environment_web_server sysconsole_read_integrations_gif manage_team_roles sysconsole_write_products_boards sysconsole_write_integrations_cors test_email sysconsole_read_environment_logging test_elasticsearch sysconsole_read_authentication_mfa manage_channel_roles sysconsole_read_site_customization sysconsole_write_site_notices test_s3 sysconsole_read_environment_rate_limiting sysconsole_read_plugins sysconsole_read_environment_performance_monitoring manage_private_channel_members sysconsole_write_site_file_sharing_and_downloads read_elasticsearch_post_indexing_job sysconsole_read_site_users_and_teams sysconsole_read_reporting_site_statistics sysconsole_write_user_management_teams sysconsole_write_site_public_links sysconsole_read_site_public_links view_team manage_public_channel_members read_public_channel_groups sysconsole_write_site_notifications manage_public_channel_properties sysconsole_read_environment_high_availability sysconsole_read_authentication_email sysconsole_read_reporting_team_statistics sysconsole_write_integrations_integration_management get_analytics read_private_channel_groups join_public_teams sysconsole_read_site_emoji delete_public_channel sysconsole_write_environment_database sysconsole_read_site_announcement_banner sysconsole_read_environment_database sysconsole_read_environment_session_lengths sysconsole_read_user_management_permissions get_logs sysconsole_read_integrations_bot_accounts create_elasticsearch_post_indexing_job reload_config sysconsole_write_environment_elasticsearch sysconsole_read_user_management_groups sysconsole_read_environment_developer sysconsole_read_authentication_saml sysconsole_write_site_posts sysconsole_read_authentication_guest_access sysconsole_read_authentication_signup sysconsole_write_environment_developer sysconsole_write_environment_logging sysconsole_write_site_localization test_site_url add_user_to_team sysconsole_write_environment_rate_limiting sysconsole_write_environment_file_storage sysconsole_write_environment_web_server sysconsole_write_user_management_groups sysconsole_write_site_announcement_banner read_elasticsearch_post_aggregation_job list_private_teams sysconsole_write_environment_smtp sysconsole_write_environment_session_lengths sysconsole_write_integrations_gif	f	t
xqc3eckiafg5i86jthcwbazdpy	team_user	authentication.roles.team_user.name	authentication.roles.team_user.description	1598351767784	1672924680861	0	 create_private_channel view_team create_public_channel list_team_channels playbook_private_create invite_user add_user_to_team playbook_public_create read_public_channel join_public_channels	t	t
go6yxappktb93quowz9j6mkjra	team_post_all_public	authentication.roles.team_post_all_public.name	authentication.roles.team_post_all_public.description	1598351767786	1672924680863	0	 use_group_mentions use_channel_mentions create_post_public	f	t
getwmro16pd7jrn1oqrkmn1wsw	system_user	authentication.roles.global_user.name	authentication.roles.global_user.description	1598351767781	1672924680864	0	 join_public_teams create_direct_channel edit_custom_group delete_custom_group create_emojis view_members delete_emojis list_public_teams create_custom_group manage_custom_group_members create_team create_group_channel	t	t
jdfscmmwq7yc9pb3j8egpkrhgo	team_admin	authentication.roles.team_admin.name	authentication.roles.team_admin.description	1598351767783	1672924680855	0	 import_team manage_slash_commands use_channel_mentions remove_user_from_team remove_reaction playbook_public_manage_roles manage_channel_roles convert_public_channel_to_private read_public_channel_groups delete_post read_private_channel_groups manage_outgoing_webhooks manage_others_slash_commands manage_others_outgoing_webhooks manage_team delete_others_posts use_group_mentions manage_private_channel_members playbook_private_manage_roles manage_incoming_webhooks add_reaction manage_team_roles manage_others_incoming_webhooks create_post convert_private_channel_to_public manage_public_channel_members	t	t
nypn4aniofbf9eu4efqkb1n56y	system_admin	authentication.roles.global_admin.name	authentication.roles.global_admin.description	1598351767771	1672924680883	0	 sysconsole_read_about_edition_and_license get_public_link create_elasticsearch_post_indexing_job sysconsole_read_user_management_teams sysconsole_read_site_public_links manage_incoming_webhooks sysconsole_read_environment_database sysconsole_read_site_customization add_ldap_private_cert playbook_private_manage_roles playbook_private_manage_members sysconsole_write_experimental_bleve manage_system_wide_oauth sysconsole_write_environment_web_server sysconsole_read_environment_file_storage sysconsole_write_integrations_gif sysconsole_read_reporting_site_statistics use_group_mentions manage_private_channel_members download_compliance_export_result sysconsole_read_plugins sysconsole_read_site_announcement_banner sysconsole_read_integrations_bot_accounts sysconsole_read_environment_high_availability create_bot list_users_without_team sysconsole_write_site_users_and_teams playbook_private_make_public sysconsole_write_authentication_saml convert_public_channel_to_private demote_to_guest run_manage_properties playbook_public_manage_properties playbook_private_manage_properties sysconsole_write_reporting_site_statistics manage_channel_roles manage_oauth remove_user_from_team test_elasticsearch edit_other_users manage_team playbook_public_view sysconsole_read_experimental_bleve delete_private_channel playbook_public_make_private sysconsole_write_authentication_password read_license_information read_elasticsearch_post_indexing_job manage_public_channel_properties manage_team_roles sysconsole_write_experimental_features convert_private_channel_to_public add_reaction sysconsole_write_site_customization sysconsole_read_user_management_permissions read_others_bots sysconsole_write_reporting_server_logs promote_guest sysconsole_write_environment_high_availability sysconsole_read_integrations_cors remove_reaction add_user_to_team sysconsole_write_plugins manage_custom_group_members sysconsole_write_environment_image_proxy sysconsole_read_environment_developer test_email get_saml_cert_status sysconsole_read_environment_elasticsearch test_ldap sysconsole_write_compliance_compliance_export sysconsole_read_reporting_server_logs create_compliance_export_job read_compliance_export_job create_post_public remove_saml_private_cert sysconsole_write_authentication_guest_access sysconsole_read_authentication_signup sysconsole_write_experimental_feature_flags run_manage_members add_saml_private_cert sysconsole_write_environment_logging sysconsole_read_integrations_gif remove_ldap_private_cert sysconsole_write_integrations_bot_accounts sysconsole_read_compliance_compliance_monitoring remove_ldap_public_cert sysconsole_write_user_management_system_roles sysconsole_read_authentication_ldap sysconsole_read_compliance_data_retention_policy manage_private_channel_properties sysconsole_write_environment_session_lengths delete_others_posts sysconsole_write_integrations_integration_management delete_others_emojis sysconsole_write_environment_rate_limiting create_post_bleve_indexes_job use_channel_mentions create_team add_ldap_public_cert playbook_public_manage_members sysconsole_read_authentication_openid sysconsole_read_environment_logging manage_license_information sysconsole_write_site_file_sharing_and_downloads sysconsole_write_site_announcement_banner sysconsole_read_site_localization sysconsole_write_reporting_team_statistics sysconsole_write_integrations_cors read_public_channel_groups sysconsole_write_site_notifications manage_public_channel_members manage_others_outgoing_webhooks read_bots sysconsole_write_user_management_teams sysconsole_write_site_public_links sysconsole_read_compliance_custom_terms_of_service playbook_private_view test_site_url sysconsole_read_reporting_team_statistics invalidate_email_invite get_logs sysconsole_read_environment_performance_monitoring reload_config sysconsole_read_site_notices sysconsole_read_authentication_mfa read_audits remove_others_reactions sysconsole_write_products_boards get_analytics sysconsole_read_user_management_system_roles purge_bleve_indexes sysconsole_read_site_file_sharing_and_downloads sysconsole_read_user_management_channels create_data_retention_job manage_others_incoming_webhooks delete_public_channel sysconsole_write_environment_performance_monitoring invalidate_caches manage_bots sysconsole_write_compliance_data_retention_policy create_elasticsearch_post_aggregation_job playbook_public_manage_roles create_private_channel sysconsole_write_user_management_groups manage_others_slash_commands sysconsole_read_user_management_groups recycle_database_connections read_user_access_token sysconsole_write_environment_database playbook_private_create sysconsole_write_environment_developer sysconsole_write_authentication_ldap manage_roles delete_custom_group manage_shared_channels sysconsole_read_authentication_guest_access sysconsole_write_authentication_openid sysconsole_read_billing sysconsole_write_site_notices read_ldap_sync_job edit_post edit_others_posts sysconsole_write_compliance_custom_terms_of_service sysconsole_read_integrations_integration_management purge_elasticsearch_indexes playbook_public_create sysconsole_write_billing upload_file view_team manage_jobs remove_saml_public_cert sysconsole_write_authentication_email view_members run_create manage_secure_connections sysconsole_read_environment_web_server remove_saml_idp_cert sysconsole_read_site_users_and_teams assign_system_admin_role test_s3 sysconsole_write_user_management_users invite_user sysconsole_read_environment_rate_limiting sysconsole_write_environment_elasticsearch sysconsole_write_authentication_signup import_team edit_custom_group sysconsole_write_about_edition_and_license sysconsole_read_environment_image_proxy create_emojis sysconsole_write_user_management_channels join_private_teams manage_system add_saml_idp_cert read_public_channel sysconsole_read_compliance_compliance_export sysconsole_read_site_notifications manage_others_bots sysconsole_write_site_localization sysconsole_read_authentication_saml run_view sysconsole_read_authentication_email list_private_teams sysconsole_read_experimental_feature_flags read_channel add_saml_public_cert sysconsole_read_authentication_password create_post sysconsole_read_site_posts read_other_users_teams sysconsole_write_site_posts delete_post sysconsole_write_environment_file_storage sysconsole_write_user_management_permissions manage_outgoing_webhooks revoke_user_access_token sysconsole_write_compliance_compliance_monitoring manage_slash_commands invite_guest sysconsole_write_site_emoji list_team_channels join_public_channels sysconsole_write_environment_push_notification_server sysconsole_read_environment_smtp create_user_access_token sysconsole_write_environment_smtp use_slash_commands sysconsole_read_products_boards create_public_channel read_jobs read_elasticsearch_post_aggregation_job create_ldap_sync_job read_private_channel_groups create_custom_group edit_brand sysconsole_read_environment_push_notification_server sysconsole_read_environment_session_lengths get_saml_metadata_from_idp sysconsole_read_experimental_features sysconsole_read_site_emoji delete_emojis sysconsole_read_user_management_users create_post_ephemeral read_data_retention_job sysconsole_write_authentication_mfa	t	t
pr7sw1uoh3ritxqnz9kg5dntka	playbook_admin	authentication.roles.playbook_admin.name	authentication.roles.playbook_admin.description	1672924680905	1672924680905	0	 playbook_public_manage_members playbook_public_manage_roles playbook_public_manage_properties playbook_private_manage_members playbook_private_manage_roles playbook_private_manage_properties playbook_public_make_private	t	t
4oz1n5j56irydqyabj4mrzja3r	playbook_member	authentication.roles.playbook_member.name	authentication.roles.playbook_member.description	1672924680907	1672924680907	0	 playbook_public_view playbook_public_manage_members playbook_public_manage_properties playbook_private_view playbook_private_manage_members playbook_private_manage_properties run_create	t	t
ug68nzjf6fg68mgu1p7o1s7oxc	run_admin	authentication.roles.run_admin.name	authentication.roles.run_admin.description	1672924680909	1672924680909	0	 run_manage_members run_manage_properties	t	t
gr8oqej36fgn8ddjqbow8mhwfc	run_member	authentication.roles.run_member.name	authentication.roles.run_member.description	1672924680912	1672924680912	0	 run_view	t	t
\.


--
-- Data for Name: schemes; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.schemes (id, name, displayname, description, createat, updateat, deleteat, scope, defaultteamadminrole, defaultteamuserrole, defaultchanneladminrole, defaultchanneluserrole, defaultteamguestrole, defaultchannelguestrole, defaultplaybookadminrole, defaultplaybookmemberrole, defaultrunadminrole, defaultrunmemberrole) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.sessions (id, token, createat, expiresat, lastactivityat, userid, deviceid, roles, isoauth, expirednotify, props) FROM stdin;
nx4ge8gf1bgidgskfz3t8qfmew	6nk5qzigrfg8py1bfjx49zkrgh	1672856706373	4826456706373	1672856706373	1fgsimi9s3rmjxzxsaeqrr66ko		system_user	f	f	{"type": "UserAccessToken", "is_guest": "false", "user_access_token_id": "6uz914r9ojrktq1xranio359ie"}
ftayyd6rjbds5npwion3kqowzw	j6knf51k1jb63fe8moah7qbf6o	1672856706932	4826456706932	1672856706932	kgr5hfwxy78k5n9gfkdhcscdoc		system_user	f	f	{"type": "UserAccessToken", "is_guest": "false", "user_access_token_id": "spc9donsrtbduj8y15pck5nq9w"}
o6a418brw7d1fxz7b8psyjgawa	ox8n8edimjdbfkeybdf56pj4xw	1672856707498	4826456707498	1672856707498	3zats68fztgu9mgu944a4t35so		system_user	f	f	{"type": "UserAccessToken", "is_guest": "false", "user_access_token_id": "e3dnfu1g17fjtxq53odawh6e7y"}
1kcmnxa9kpgamkpzi5rzjwqdrr	s537n3t8zib1tx7eyd44qzqnbr	1672856703482	4826456703482	1672922247795	bmq7jiumpib3xdz3mx5iyo99ro		system_admin system_user	f	f	{"type": "UserAccessToken", "is_guest": "false", "user_access_token_id": "98yjyceocfb5mc3jaibtbmr1ph"}
jpc96qdwdbbb9f83j7mic9jidy	3764heboy7yzjnnwr16kwwdkke	1672924918266	1675516918266	1672925218867	bmq7jiumpib3xdz3mx5iyo99ro		system_admin system_user	f	f	{"os": "Mac OS", "csrf": "yfmadfytpbd4z8dpeisk48cefw", "isSaml": "false", "browser": "Chrome/108.0", "isMobile": "false", "is_guest": "false", "platform": "Macintosh", "isOAuthUser": "false"}
nuj8b3qqzby83poe5s7eowrroc	s537n3t8zib1tx7eyd44qzqnbr	1672856703479	4826456703479	1672925540243	bmq7jiumpib3xdz3mx5iyo99ro		system_admin system_user	f	f	{"type": "UserAccessToken", "is_guest": "false", "user_access_token_id": "98yjyceocfb5mc3jaibtbmr1ph"}
yj4ihgtk7p88fexayf9jse8iey	pgrgjax6rpggub1hxajrw5ne4h	1673367804210	4826967804210	1673367804210	she685ewdtyq7m7jgmys7zoqmr		system_user	f	f	{"type": "UserAccessToken", "is_guest": "false", "user_access_token_id": "j9jxpacsy3d4zmx4pu1qjonfua"}
wm7tg3bnjfbz9pokty3y335jpo	aqhn1jc1nbgjtpd7es83wckner	1672856705867	4826456705867	1673367804448	5bw66y36bff3umq1q57mfy4y5c		system_user	f	f	{"type": "UserAccessToken", "is_guest": "false", "user_access_token_id": "ya4wtr9fjiyxfptgnjmjgcc3wh"}
zh7d8s9zepf1xqo1roee4593to	s537n3t8zib1tx7eyd44qzqnbr	1672856703476	4826456703476	1673367935266	bmq7jiumpib3xdz3mx5iyo99ro		system_admin system_user	f	f	{"type": "UserAccessToken", "is_guest": "false", "user_access_token_id": "98yjyceocfb5mc3jaibtbmr1ph"}
\.


--
-- Data for Name: sharedchannelattachments; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.sharedchannelattachments (id, fileid, remoteid, createat, lastsyncat) FROM stdin;
\.


--
-- Data for Name: sharedchannelremotes; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.sharedchannelremotes (id, channelid, creatorid, createat, updateat, isinviteaccepted, isinviteconfirmed, remoteid, lastpostupdateat, lastpostid) FROM stdin;
\.


--
-- Data for Name: sharedchannels; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.sharedchannels (channelid, teamid, home, readonly, sharename, sharedisplayname, sharepurpose, shareheader, creatorid, createat, updateat, remoteid) FROM stdin;
\.


--
-- Data for Name: sharedchannelusers; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.sharedchannelusers (id, userid, remoteid, createat, lastsyncat, channelid) FROM stdin;
\.


--
-- Data for Name: sidebarcategories; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.sidebarcategories (id, userid, teamid, sortorder, sorting, type, displayname, muted, collapsed) FROM stdin;
z8ezpkrpd3d7irxpormhn3w9er	1fgsimi9s3rmjxzxsaeqrr66ko	tgrw7sjgbiy1jggs3qg3m6zpee	0		favorites	Favorites	\N	\N
t3bmpa1bfbdo9mk3wphoeys9my	1fgsimi9s3rmjxzxsaeqrr66ko	tgrw7sjgbiy1jggs3qg3m6zpee	10		channels	Channels	\N	\N
edfdeurajfgctqxz8ttsfw6ruw	1fgsimi9s3rmjxzxsaeqrr66ko	tgrw7sjgbiy1jggs3qg3m6zpee	20	recent	direct_messages	Direct Messages	\N	\N
a469xbwpo7bx3rzankrrywobuw	kgr5hfwxy78k5n9gfkdhcscdoc	tgrw7sjgbiy1jggs3qg3m6zpee	0		favorites	Favorites	\N	\N
sefn36xsabfm7e14p4rk9mztoe	kgr5hfwxy78k5n9gfkdhcscdoc	tgrw7sjgbiy1jggs3qg3m6zpee	10		channels	Channels	\N	\N
ho69ue7c5frefq97zb1sh9j8qh	kgr5hfwxy78k5n9gfkdhcscdoc	tgrw7sjgbiy1jggs3qg3m6zpee	20	recent	direct_messages	Direct Messages	\N	\N
jigazeeu8irabn1qm9n4kp57sh	98kwr77m4jgwmbdgygknaowcch	tgrw7sjgbiy1jggs3qg3m6zpee	0		favorites	Favorites	\N	\N
4m9dn1jqwbb3djxd44sxci8yze	98kwr77m4jgwmbdgygknaowcch	tgrw7sjgbiy1jggs3qg3m6zpee	10		channels	Channels	\N	\N
ttidzgpuubg4mfr6ox85stjhrw	98kwr77m4jgwmbdgygknaowcch	tgrw7sjgbiy1jggs3qg3m6zpee	20	recent	direct_messages	Direct Messages	\N	\N
dfrum9y3f7r3mgb8kq39g1ydeh	she685ewdtyq7m7jgmys7zoqmr	tgrw7sjgbiy1jggs3qg3m6zpee	0		favorites	Favorites	\N	\N
f3c1j165ftyb9d8utcm6zdktic	she685ewdtyq7m7jgmys7zoqmr	tgrw7sjgbiy1jggs3qg3m6zpee	10		channels	Channels	\N	\N
dnq8zjdd1jyspxikqdb3m1cy5c	she685ewdtyq7m7jgmys7zoqmr	tgrw7sjgbiy1jggs3qg3m6zpee	20	recent	direct_messages	Direct Messages	\N	\N
favorites_5bw66y36bff3umq1q57mfy4y5c_tgrw7sjgbiy1jggs3qg3m6zpee	5bw66y36bff3umq1q57mfy4y5c	tgrw7sjgbiy1jggs3qg3m6zpee	0		favorites	Favorites	f	f
channels_5bw66y36bff3umq1q57mfy4y5c_tgrw7sjgbiy1jggs3qg3m6zpee	5bw66y36bff3umq1q57mfy4y5c	tgrw7sjgbiy1jggs3qg3m6zpee	10		channels	Channels	f	f
direct_messages_5bw66y36bff3umq1q57mfy4y5c_tgrw7sjgbiy1jggs3qg3m6zpee	5bw66y36bff3umq1q57mfy4y5c	tgrw7sjgbiy1jggs3qg3m6zpee	20	recent	direct_messages	Direct Messages	f	f
favorites_98kwr77m4jgwmbdgygknaowcch_gajwz6y3efb3mcrsman43cqmxo	98kwr77m4jgwmbdgygknaowcch	gajwz6y3efb3mcrsman43cqmxo	0		favorites	Favorites	f	f
channels_98kwr77m4jgwmbdgygknaowcch_gajwz6y3efb3mcrsman43cqmxo	98kwr77m4jgwmbdgygknaowcch	gajwz6y3efb3mcrsman43cqmxo	10		channels	Channels	f	f
direct_messages_98kwr77m4jgwmbdgygknaowcch_gajwz6y3efb3mcrsman43cqmxo	98kwr77m4jgwmbdgygknaowcch	gajwz6y3efb3mcrsman43cqmxo	20	recent	direct_messages	Direct Messages	f	f
favorites_bmq7jiumpib3xdz3mx5iyo99ro_tgrw7sjgbiy1jggs3qg3m6zpee	bmq7jiumpib3xdz3mx5iyo99ro	tgrw7sjgbiy1jggs3qg3m6zpee	0		favorites	Favorites	f	f
direct_messages_bmq7jiumpib3xdz3mx5iyo99ro_tgrw7sjgbiy1jggs3qg3m6zpee	bmq7jiumpib3xdz3mx5iyo99ro	tgrw7sjgbiy1jggs3qg3m6zpee	20	recent	direct_messages	Direct Messages	f	f
channels_bmq7jiumpib3xdz3mx5iyo99ro_tgrw7sjgbiy1jggs3qg3m6zpee	bmq7jiumpib3xdz3mx5iyo99ro	tgrw7sjgbiy1jggs3qg3m6zpee	10		channels	Channels	f	f
\.


--
-- Data for Name: sidebarchannels; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.sidebarchannels (channelid, userid, categoryid, sortorder) FROM stdin;
73uy6kj1jb8wdqrf3ti6zies6r	bmq7jiumpib3xdz3mx5iyo99ro	channels_bmq7jiumpib3xdz3mx5iyo99ro_tgrw7sjgbiy1jggs3qg3m6zpee	10
cxtmz3ubz3gfigd5m6prendmsw	bmq7jiumpib3xdz3mx5iyo99ro	channels_bmq7jiumpib3xdz3mx5iyo99ro_tgrw7sjgbiy1jggs3qg3m6zpee	20
\.


--
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.status (userid, status, manual, lastactivityat, dndendtime, prevstatus) FROM stdin;
1fgsimi9s3rmjxzxsaeqrr66ko	offline	f	1672856706408	\N	\N
kgr5hfwxy78k5n9gfkdhcscdoc	offline	f	1672856706956	\N	\N
3zats68fztgu9mgu944a4t35so	offline	f	1672856707579	\N	\N
98kwr77m4jgwmbdgygknaowcch	offline	f	1672924891173	0	
5bw66y36bff3umq1q57mfy4y5c	online	f	1673367804446	0	
bmq7jiumpib3xdz3mx5iyo99ro	offline	f	1673368011017	0	
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
CRTChannelMembershipCountsMigrationComplete	true
CRTThreadCountsAndUnreadsMigrationComplete	true
SystemConsoleRolesCreationMigrationComplete	true
CustomGroupAdminRoleCreationMigrationComplete	true
add_system_console_permissions	true
add_convert_channel_permissions	true
manage_shared_channel_permissions	true
manage_secure_connections_permissions	true
add_system_roles_permissions	true
add_billing_permissions	true
download_compliance_export_results	true
experimental_subsection_permissions	true
authentication_subsection_permissions	true
integrations_subsection_permissions	true
site_subsection_permissions	true
compliance_subsection_permissions	true
environment_subsection_permissions	true
about_subsection_permissions	true
reporting_subsection_permissions	true
test_email_ancillary_permission	true
playbooks_permissions	true
custom_groups_permissions	true
playbooks_manage_roles	true
products_boards	true
ContentExtractionConfigDefaultTrueMigrationComplete	true
PlaybookRolesCreationMigrationComplete	true
FirstAdminSetupComplete	true
RemainingSchemaMigrations	true
LastSecurityTime	1673367008000
\.


--
-- Data for Name: teammembers; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.teammembers (teamid, userid, roles, deleteat, schemeuser, schemeadmin, schemeguest, createat) FROM stdin;
tgrw7sjgbiy1jggs3qg3m6zpee	bmq7jiumpib3xdz3mx5iyo99ro		0	t	t	f	0
tgrw7sjgbiy1jggs3qg3m6zpee	5bw66y36bff3umq1q57mfy4y5c		0	t	f	f	0
tgrw7sjgbiy1jggs3qg3m6zpee	0z4okgmv5lfhx3p0tf6pnpk8sk		0	t	f	f	0
tgrw7sjgbiy1jggs3qg3m6zpee	3zats68fztgu9mgu944a4t35so		0	t	f	f	0
tgrw7sjgbiy1jggs3qg3m6zpee	1fgsimi9s3rmjxzxsaeqrr66ko		0	t	f	f	0
tgrw7sjgbiy1jggs3qg3m6zpee	kgr5hfwxy78k5n9gfkdhcscdoc		0	t	f	f	0
tgrw7sjgbiy1jggs3qg3m6zpee	98kwr77m4jgwmbdgygknaowcch		0	t	f	f	0
7jenmotdwfdq7mmci7zz7hfpze	98kwr77m4jgwmbdgygknaowcch		1672922135158	t	t	f	0
tgrw7sjgbiy1jggs3qg3m6zpee	she685ewdtyq7m7jgmys7zoqmr		0	t	f	f	0
gajwz6y3efb3mcrsman43cqmxo	98kwr77m4jgwmbdgygknaowcch		0	t	t	f	1672924805706
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.teams (id, createat, updateat, deleteat, displayname, name, description, email, type, companyname, alloweddomains, inviteid, allowopeninvite, lastteamiconupdate, schemeid, groupconstrained, cloudlimitsarchived) FROM stdin;
7jenmotdwfdq7mmci7zz7hfpze	1672921846241	1672921846241	0	users	users		user1@localhost	O			k3m7x5sumpnx3jyquka4mjj7na	f	0	\N	\N	f
tgrw7sjgbiy1jggs3qg3m6zpee	1598351837711	1672922833167	0	Public Team	test			O			5tdc6sxr43byufri3r6px9f9xo	t	0	\N	\N	f
gajwz6y3efb3mcrsman43cqmxo	1672924805689	1672924805689	0	demo1	demo1		user1@localhost	O			ns9a8197tpdnd8s8z5pdah11rr	f	0	\N	\N	f
\.


--
-- Data for Name: termsofservice; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.termsofservice (id, createat, userid, text) FROM stdin;
\.


--
-- Data for Name: threadmemberships; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.threadmemberships (postid, userid, following, lastviewed, lastupdated, unreadmentions) FROM stdin;
\.


--
-- Data for Name: threads; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.threads (postid, replycount, lastreplyat, participants, channelid, threaddeleteat) FROM stdin;
\.


--
-- Data for Name: tokens; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.tokens (token, createat, type, extra) FROM stdin;
\.


--
-- Data for Name: uploadsessions; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.uploadsessions (id, type, createat, userid, channelid, filename, path, filesize, fileoffset, remoteid, reqfileid) FROM stdin;
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

COPY public.users (id, createat, updateat, deleteat, username, password, authdata, authservice, email, emailverified, nickname, firstname, lastname, "position", roles, allowmarketing, props, notifyprops, lastpasswordupdate, lastpictureupdate, failedattempts, locale, timezone, mfaactive, mfasecret, remoteid) FROM stdin;
3zats68fztgu9mgu944a4t35so	1598351812493	1598351812493	0	mattermost_b	$2a$10$bV5EvQPt9.p4jTO4VVM4Te2J7B7/IJhstPLhxVltLtufn7F97Q3nO	\N		mattermost_b@localhost	f					system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "desktop_sound": "true"}	1598351812493	0	0	en	{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	f		\N
0z4okgmv5lfhx3p0tf6pnpk8sk	1598351800458	1598352057088	0	ignored_user	$2a$10$WdovEVVvy9ZS867UE2hSq.7hV38Lg9H2ozgaF3gwuO6fuoCkkTzIu	\N		ignored_user@localhost	f					system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "desktop_sound": "true"}	1598352057088	0	0	en	{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	f		\N
5bw66y36bff3umq1q57mfy4y5c	1598351800458	1672922930445	0	mattermost_a	$2a$10$2/PIURccK5KZOUw50RQhFOzJwteNZIa8GQrLMe3m9iJH5L2Dn/69K	\N		mattermost_a@localhost	f		MattermostUser	A		system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "desktop_sound": "true"}	1672922930445	0	0	en	{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	f		\N
yf4cwcenyjdbfk6zz9713naedo	1672924687994	1672924687994	0	boards		\N		boards@localhost	f		Boards			system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1672924687994	0	0	en	{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	f		\N
x4tebym3xir39mkitcm8ddzwhc	1672924799920	1672924799920	0	system-bot		\N		system-bot@localhost	f		System			system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1672924799920	0	0	en	{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	f		\N
98kwr77m4jgwmbdgygknaowcch	1672921832140	1672924805719	0	user1	$2a$10$Y.xgACBeddylzHset9G7B.W5ni806n7eAXtjkvCD6s9ZjyDy7MrR.	\N		user1@localhost	f					system_user	t	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "desktop_sound": "true"}	1672921832140	0	0	en	{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	f		\N
bmq7jiumpib3xdz3mx5iyo99ro	1598351769026	1598351847718	0	admin	$2a$10$dCK8unlOWxu7Ge1Fmeo70eaETqonsQC1mVbwnLi5lCH5ALbzKyqnO	\N		admin@localhost	f		Admin	User		system_admin system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "desktop_sound": "true"}	1598351769026	0	0	en	{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	f		\N
bqy7sf35rtgc3yekuimx43h8by	1672924685853	1673367014650	0	appsbot		\N		appsbot@localhost	f		Mattermost Apps			system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1672924685853	1673367014650	0	en	{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	f		\N
45gdtgiatpf3pfyfgitm5k9cxr	1672924686620	1673367015239	0	playbooks		\N		playbooks@localhost	f		Playbooks			system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1672924686620	1673367015239	0	en	{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	f		\N
1fgsimi9s3rmjxzxsaeqrr66ko	1672856703693	1673367935788	0	matrix_matrix_a	$2a$10$Ev9uMMLU1j7olpOnonXlcega8UsQ5iJAkZSoxs6LKPPLHo08TK7T6	\N		devnull-heuxcvsa5epb25-j@localhost	t		Matrix UserA			system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "desktop_sound": "true"}	1672856703693	0	0	en	{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	f		\N
kgr5hfwxy78k5n9gfkdhcscdoc	1672856703886	1673367935814	0	matrix_matrix_b	$2a$10$/SAgqCacBg.Xr.2a2Yy2xO.MhGG2zEkJ1j0l.oA/yLifm812.51zW	\N		devnull-jvwx5lytbmh2xdbp@localhost	t		matrix_b			system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "desktop_sound": "true"}	1672856703886	0	0	en	{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	f		\N
she685ewdtyq7m7jgmys7zoqmr	1672922248219	1673367935805	0	matrix_user1	$2a$10$W7hFVwRIKYVlfz7Cgsco5uMfk66J4U.fBDA0wF8hXmSkSLZJEoiMK	\N		devnull-w1pfjon95qjil-gz@localhost	t		User 1			system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "desktop_sound": "true"}	1672922248219	0	0	en	{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	f		\N
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
-- Name: db_lock db_lock_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.db_lock
    ADD CONSTRAINT db_lock_pkey PRIMARY KEY (id);


--
-- Name: db_migrations db_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.db_migrations
    ADD CONSTRAINT db_migrations_pkey PRIMARY KEY (version);


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
-- Name: focalboard_blocks_history focalboard_blocks_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_blocks_history
    ADD CONSTRAINT focalboard_blocks_pkey PRIMARY KEY (id, insert_at);


--
-- Name: focalboard_blocks focalboard_blocks_pkey1; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_blocks
    ADD CONSTRAINT focalboard_blocks_pkey1 PRIMARY KEY (id);


--
-- Name: focalboard_board_members_history focalboard_board_members_history_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_board_members_history
    ADD CONSTRAINT focalboard_board_members_history_pkey PRIMARY KEY (board_id, user_id, insert_at);


--
-- Name: focalboard_board_members focalboard_board_members_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_board_members
    ADD CONSTRAINT focalboard_board_members_pkey PRIMARY KEY (board_id, user_id);


--
-- Name: focalboard_boards_history focalboard_boards_history_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_boards_history
    ADD CONSTRAINT focalboard_boards_history_pkey PRIMARY KEY (id, insert_at);


--
-- Name: focalboard_boards focalboard_boards_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_boards
    ADD CONSTRAINT focalboard_boards_pkey PRIMARY KEY (id);


--
-- Name: focalboard_categories focalboard_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_categories
    ADD CONSTRAINT focalboard_categories_pkey PRIMARY KEY (id);


--
-- Name: focalboard_category_boards focalboard_category_boards_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_category_boards
    ADD CONSTRAINT focalboard_category_boards_pkey PRIMARY KEY (id);


--
-- Name: focalboard_notification_hints focalboard_notification_hints_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_notification_hints
    ADD CONSTRAINT focalboard_notification_hints_pkey PRIMARY KEY (block_id);


--
-- Name: focalboard_preferences focalboard_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_preferences
    ADD CONSTRAINT focalboard_preferences_pkey PRIMARY KEY (userid, category, name);


--
-- Name: focalboard_schema_migrations focalboard_schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_schema_migrations
    ADD CONSTRAINT focalboard_schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: focalboard_sessions focalboard_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_sessions
    ADD CONSTRAINT focalboard_sessions_pkey PRIMARY KEY (id);


--
-- Name: focalboard_sharing focalboard_sharing_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_sharing
    ADD CONSTRAINT focalboard_sharing_pkey PRIMARY KEY (id);


--
-- Name: focalboard_subscriptions focalboard_subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_subscriptions
    ADD CONSTRAINT focalboard_subscriptions_pkey PRIMARY KEY (block_id, subscriber_id);


--
-- Name: focalboard_system_settings focalboard_system_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_system_settings
    ADD CONSTRAINT focalboard_system_settings_pkey PRIMARY KEY (id);


--
-- Name: focalboard_users focalboard_users_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_users
    ADD CONSTRAINT focalboard_users_pkey PRIMARY KEY (id);


--
-- Name: focalboard_teams focalboard_workspaces_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_teams
    ADD CONSTRAINT focalboard_workspaces_pkey PRIMARY KEY (id);


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
-- Name: ir_category_item ir_category_item_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_category_item
    ADD CONSTRAINT ir_category_item_pkey PRIMARY KEY (categoryid, itemid, type);


--
-- Name: ir_category ir_category_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_category
    ADD CONSTRAINT ir_category_pkey PRIMARY KEY (id);


--
-- Name: ir_channelaction ir_channelaction_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_channelaction
    ADD CONSTRAINT ir_channelaction_pkey PRIMARY KEY (id);


--
-- Name: ir_incident ir_incident_channelid_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_incident
    ADD CONSTRAINT ir_incident_channelid_key UNIQUE (channelid);


--
-- Name: ir_incident ir_incident_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_incident
    ADD CONSTRAINT ir_incident_pkey PRIMARY KEY (id);


--
-- Name: ir_metric ir_metric_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_metric
    ADD CONSTRAINT ir_metric_pkey PRIMARY KEY (incidentid, metricconfigid);


--
-- Name: ir_metricconfig ir_metricconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_metricconfig
    ADD CONSTRAINT ir_metricconfig_pkey PRIMARY KEY (id);


--
-- Name: ir_playbook ir_playbook_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_playbook
    ADD CONSTRAINT ir_playbook_pkey PRIMARY KEY (id);


--
-- Name: ir_playbookautofollow ir_playbookautofollow_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_playbookautofollow
    ADD CONSTRAINT ir_playbookautofollow_pkey PRIMARY KEY (playbookid, userid);


--
-- Name: ir_playbookmember ir_playbookmember_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_playbookmember
    ADD CONSTRAINT ir_playbookmember_pkey PRIMARY KEY (memberid, playbookid);


--
-- Name: ir_playbookmember ir_playbookmember_playbookid_memberid_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_playbookmember
    ADD CONSTRAINT ir_playbookmember_playbookid_memberid_key UNIQUE (playbookid, memberid);


--
-- Name: ir_run_participants ir_run_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_run_participants
    ADD CONSTRAINT ir_run_participants_pkey PRIMARY KEY (incidentid, userid);


--
-- Name: ir_statusposts ir_statusposts_incidentid_postid_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_statusposts
    ADD CONSTRAINT ir_statusposts_incidentid_postid_key UNIQUE (incidentid, postid);


--
-- Name: ir_statusposts ir_statusposts_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_statusposts
    ADD CONSTRAINT ir_statusposts_pkey PRIMARY KEY (incidentid, postid);


--
-- Name: ir_system ir_system_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_system
    ADD CONSTRAINT ir_system_pkey PRIMARY KEY (skey);


--
-- Name: ir_timelineevent ir_timelineevent_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_timelineevent
    ADD CONSTRAINT ir_timelineevent_pkey PRIMARY KEY (id);


--
-- Name: ir_userinfo ir_userinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_userinfo
    ADD CONSTRAINT ir_userinfo_pkey PRIMARY KEY (id);


--
-- Name: ir_viewedchannel ir_viewedchannel_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_viewedchannel
    ADD CONSTRAINT ir_viewedchannel_pkey PRIMARY KEY (channelid, userid);


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
-- Name: notifyadmin notifyadmin_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.notifyadmin
    ADD CONSTRAINT notifyadmin_pkey PRIMARY KEY (userid, requiredfeature, requiredplan);


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
-- Name: postreminders postreminders_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.postreminders
    ADD CONSTRAINT postreminders_pkey PRIMARY KEY (postid, userid);


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
-- Name: productnoticeviewstate productnoticeviewstate_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.productnoticeviewstate
    ADD CONSTRAINT productnoticeviewstate_pkey PRIMARY KEY (userid, noticeid);


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
-- Name: recentsearches recentsearches_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.recentsearches
    ADD CONSTRAINT recentsearches_pkey PRIMARY KEY (userid, searchpointer);


--
-- Name: remoteclusters remoteclusters_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.remoteclusters
    ADD CONSTRAINT remoteclusters_pkey PRIMARY KEY (remoteid, name);


--
-- Name: retentionpolicies retentionpolicies_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.retentionpolicies
    ADD CONSTRAINT retentionpolicies_pkey PRIMARY KEY (id);


--
-- Name: retentionpolicieschannels retentionpolicieschannels_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.retentionpolicieschannels
    ADD CONSTRAINT retentionpolicieschannels_pkey PRIMARY KEY (channelid);


--
-- Name: retentionpoliciesteams retentionpoliciesteams_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.retentionpoliciesteams
    ADD CONSTRAINT retentionpoliciesteams_pkey PRIMARY KEY (teamid);


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
-- Name: sharedchannelattachments sharedchannelattachments_fileid_remoteid_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.sharedchannelattachments
    ADD CONSTRAINT sharedchannelattachments_fileid_remoteid_key UNIQUE (fileid, remoteid);


--
-- Name: sharedchannelattachments sharedchannelattachments_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.sharedchannelattachments
    ADD CONSTRAINT sharedchannelattachments_pkey PRIMARY KEY (id);


--
-- Name: sharedchannelremotes sharedchannelremotes_channelid_remoteid_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.sharedchannelremotes
    ADD CONSTRAINT sharedchannelremotes_channelid_remoteid_key UNIQUE (channelid, remoteid);


--
-- Name: sharedchannelremotes sharedchannelremotes_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.sharedchannelremotes
    ADD CONSTRAINT sharedchannelremotes_pkey PRIMARY KEY (id, channelid);


--
-- Name: sharedchannels sharedchannels_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.sharedchannels
    ADD CONSTRAINT sharedchannels_pkey PRIMARY KEY (channelid);


--
-- Name: sharedchannels sharedchannels_sharename_teamid_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.sharedchannels
    ADD CONSTRAINT sharedchannels_sharename_teamid_key UNIQUE (sharename, teamid);


--
-- Name: sharedchannelusers sharedchannelusers_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.sharedchannelusers
    ADD CONSTRAINT sharedchannelusers_pkey PRIMARY KEY (id);


--
-- Name: sharedchannelusers sharedchannelusers_userid_channelid_remoteid_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.sharedchannelusers
    ADD CONSTRAINT sharedchannelusers_userid_channelid_remoteid_key UNIQUE (userid, channelid, remoteid);


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
-- Name: threadmemberships threadmemberships_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.threadmemberships
    ADD CONSTRAINT threadmemberships_pkey PRIMARY KEY (postid, userid);


--
-- Name: threads threads_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.threads
    ADD CONSTRAINT threads_pkey PRIMARY KEY (postid);


--
-- Name: tokens tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_pkey PRIMARY KEY (token);


--
-- Name: uploadsessions uploadsessions_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.uploadsessions
    ADD CONSTRAINT uploadsessions_pkey PRIMARY KEY (id);


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
-- Name: idx_blocks_board_id_parent_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_blocks_board_id_parent_id ON public.focalboard_blocks USING btree (board_id, parent_id);


--
-- Name: idx_board_channel_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_board_channel_id ON public.focalboard_boards USING btree (channel_id);


--
-- Name: idx_board_team_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_board_team_id ON public.focalboard_boards USING btree (team_id, is_template);


--
-- Name: idx_boardmembers_user_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_boardmembers_user_id ON public.focalboard_board_members USING btree (user_id);


--
-- Name: idx_boardmembershistory_board_id_user_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_boardmembershistory_board_id_user_id ON public.focalboard_board_members_history USING btree (board_id, user_id);


--
-- Name: idx_boardmembershistory_user_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_boardmembershistory_user_id ON public.focalboard_board_members_history USING btree (user_id);


--
-- Name: idx_categories_user_id_team_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_categories_user_id_team_id ON public.focalboard_categories USING btree (user_id, team_id);


--
-- Name: idx_categoryboards_category_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_categoryboards_category_id ON public.focalboard_category_boards USING btree (category_id);


--
-- Name: idx_channel_search_txt; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_channel_search_txt ON public.channels USING gin (to_tsvector('english'::regconfig, (((((name)::text || ' '::text) || (displayname)::text) || ' '::text) || (purpose)::text)));


--
-- Name: idx_channelmembers_channel_id_scheme_guest_user_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_channelmembers_channel_id_scheme_guest_user_id ON public.channelmembers USING btree (channelid, schemeguest, userid);


--
-- Name: idx_channelmembers_user_id_channel_id_last_viewed_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_channelmembers_user_id_channel_id_last_viewed_at ON public.channelmembers USING btree (userid, channelid, lastviewedat);


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
-- Name: idx_channels_name_lower; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_channels_name_lower ON public.channels USING btree (lower((name)::text));


--
-- Name: idx_channels_scheme_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_channels_scheme_id ON public.channels USING btree (schemeid);


--
-- Name: idx_channels_team_id_display_name; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_channels_team_id_display_name ON public.channels USING btree (teamid, displayname);


--
-- Name: idx_channels_team_id_type; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_channels_team_id_type ON public.channels USING btree (teamid, type);


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
-- Name: idx_emoji_update_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_emoji_update_at ON public.emoji USING btree (updateat);


--
-- Name: idx_fileinfo_content_txt; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_fileinfo_content_txt ON public.fileinfo USING gin (to_tsvector('english'::regconfig, content));


--
-- Name: idx_fileinfo_create_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_fileinfo_create_at ON public.fileinfo USING btree (createat);


--
-- Name: idx_fileinfo_delete_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_fileinfo_delete_at ON public.fileinfo USING btree (deleteat);


--
-- Name: idx_fileinfo_extension_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_fileinfo_extension_at ON public.fileinfo USING btree (extension);


--
-- Name: idx_fileinfo_name_splitted; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_fileinfo_name_splitted ON public.fileinfo USING gin (to_tsvector('english'::regconfig, translate((name)::text, '.,-'::text, '   '::text)));


--
-- Name: idx_fileinfo_name_txt; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_fileinfo_name_txt ON public.fileinfo USING gin (to_tsvector('english'::regconfig, (name)::text));


--
-- Name: idx_fileinfo_postid_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_fileinfo_postid_at ON public.fileinfo USING btree (postid);


--
-- Name: idx_fileinfo_update_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_fileinfo_update_at ON public.fileinfo USING btree (updateat);


--
-- Name: idx_focalboard_preferences_category; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_focalboard_preferences_category ON public.focalboard_preferences USING btree (category);


--
-- Name: idx_focalboard_preferences_name; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_focalboard_preferences_name ON public.focalboard_preferences USING btree (name);


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
-- Name: idx_jobs_status_type; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_jobs_status_type ON public.jobs USING btree (status, type);


--
-- Name: idx_jobs_type; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_jobs_type ON public.jobs USING btree (type);


--
-- Name: idx_link_metadata_url_timestamp; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_link_metadata_url_timestamp ON public.linkmetadata USING btree (url, "timestamp");


--
-- Name: idx_notice_views_notice_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_notice_views_notice_id ON public.productnoticeviewstate USING btree (noticeid);


--
-- Name: idx_notice_views_timestamp; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_notice_views_timestamp ON public.productnoticeviewstate USING btree ("timestamp");


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
-- Name: idx_postreminders_targettime; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_postreminders_targettime ON public.postreminders USING btree (targettime);


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
-- Name: idx_posts_create_at_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_posts_create_at_id ON public.posts USING btree (createat, id);


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
-- Name: idx_posts_root_id_delete_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_posts_root_id_delete_at ON public.posts USING btree (rootid, deleteat);


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
-- Name: idx_publicchannels_delete_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_publicchannels_delete_at ON public.publicchannels USING btree (deleteat);


--
-- Name: idx_publicchannels_displayname_lower; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_publicchannels_displayname_lower ON public.publicchannels USING btree (lower((displayname)::text));


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
-- Name: idx_reactions_channel_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_reactions_channel_id ON public.reactions USING btree (channelid);


--
-- Name: idx_retentionpolicies_displayname; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_retentionpolicies_displayname ON public.retentionpolicies USING btree (displayname);


--
-- Name: idx_retentionpolicieschannels_policyid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_retentionpolicieschannels_policyid ON public.retentionpolicieschannels USING btree (policyid);


--
-- Name: idx_retentionpoliciesteams_policyid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_retentionpoliciesteams_policyid ON public.retentionpoliciesteams USING btree (policyid);


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
-- Name: idx_sharedchannelusers_remote_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_sharedchannelusers_remote_id ON public.sharedchannelusers USING btree (remoteid);


--
-- Name: idx_sidebarcategories_userid_teamid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_sidebarcategories_userid_teamid ON public.sidebarcategories USING btree (userid, teamid);


--
-- Name: idx_status_status_dndendtime; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_status_status_dndendtime ON public.status USING btree (status, dndendtime);


--
-- Name: idx_subscriptions_subscriber_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_subscriptions_subscriber_id ON public.focalboard_subscriptions USING btree (subscriber_id);


--
-- Name: idx_teammembers_createat; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_teammembers_createat ON public.teammembers USING btree (createat);


--
-- Name: idx_teammembers_delete_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_teammembers_delete_at ON public.teammembers USING btree (deleteat);


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
-- Name: idx_teams_scheme_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_teams_scheme_id ON public.teams USING btree (schemeid);


--
-- Name: idx_teams_update_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_teams_update_at ON public.teams USING btree (updateat);


--
-- Name: idx_thread_memberships_last_update_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_thread_memberships_last_update_at ON public.threadmemberships USING btree (lastupdated);


--
-- Name: idx_thread_memberships_last_view_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_thread_memberships_last_view_at ON public.threadmemberships USING btree (lastviewed);


--
-- Name: idx_thread_memberships_user_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_thread_memberships_user_id ON public.threadmemberships USING btree (userid);


--
-- Name: idx_threads_channel_id_last_reply_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_threads_channel_id_last_reply_at ON public.threads USING btree (channelid, lastreplyat);


--
-- Name: idx_uploadsessions_create_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_uploadsessions_create_at ON public.uploadsessions USING btree (createat);


--
-- Name: idx_uploadsessions_type; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_uploadsessions_type ON public.uploadsessions USING btree (type);


--
-- Name: idx_uploadsessions_user_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_uploadsessions_user_id ON public.uploadsessions USING btree (userid);


--
-- Name: idx_user_access_tokens_user_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_user_access_tokens_user_id ON public.useraccesstokens USING btree (userid);


--
-- Name: idx_usergroups_delete_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_usergroups_delete_at ON public.usergroups USING btree (deleteat);


--
-- Name: idx_usergroups_displayname; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_usergroups_displayname ON public.usergroups USING btree (displayname);


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
-- Name: ir_category_item_categoryid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_category_item_categoryid ON public.ir_category_item USING btree (categoryid);


--
-- Name: ir_category_teamid_userid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_category_teamid_userid ON public.ir_category USING btree (teamid, userid);


--
-- Name: ir_channelaction_channelid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_channelaction_channelid ON public.ir_channelaction USING btree (channelid);


--
-- Name: ir_incident_channelid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_incident_channelid ON public.ir_incident USING btree (channelid);


--
-- Name: ir_incident_teamid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_incident_teamid ON public.ir_incident USING btree (teamid);


--
-- Name: ir_incident_teamid_commanderuserid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_incident_teamid_commanderuserid ON public.ir_incident USING btree (teamid, commanderuserid);


--
-- Name: ir_metric_incidentid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_metric_incidentid ON public.ir_metric USING btree (incidentid);


--
-- Name: ir_metric_metricconfigid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_metric_metricconfigid ON public.ir_metric USING btree (metricconfigid);


--
-- Name: ir_metricconfig_playbookid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_metricconfig_playbookid ON public.ir_metricconfig USING btree (playbookid);


--
-- Name: ir_playbook_teamid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_playbook_teamid ON public.ir_playbook USING btree (teamid);


--
-- Name: ir_playbook_updateat; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_playbook_updateat ON public.ir_playbook USING btree (updateat);


--
-- Name: ir_playbookmember_memberid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_playbookmember_memberid ON public.ir_playbookmember USING btree (memberid);


--
-- Name: ir_playbookmember_playbookid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_playbookmember_playbookid ON public.ir_playbookmember USING btree (playbookid);


--
-- Name: ir_run_participants_incidentid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_run_participants_incidentid ON public.ir_run_participants USING btree (incidentid);


--
-- Name: ir_run_participants_userid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_run_participants_userid ON public.ir_run_participants USING btree (userid);


--
-- Name: ir_statusposts_incidentid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_statusposts_incidentid ON public.ir_statusposts USING btree (incidentid);


--
-- Name: ir_statusposts_postid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_statusposts_postid ON public.ir_statusposts USING btree (postid);


--
-- Name: ir_timelineevent_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_timelineevent_id ON public.ir_timelineevent USING btree (id);


--
-- Name: ir_timelineevent_incidentid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_timelineevent_incidentid ON public.ir_timelineevent USING btree (incidentid);


--
-- Name: remote_clusters_site_url_unique; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE UNIQUE INDEX remote_clusters_site_url_unique ON public.remoteclusters USING btree (siteurl, remoteteamid);


--
-- Name: retentionpolicieschannels fk_retentionpolicieschannels_retentionpolicies; Type: FK CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.retentionpolicieschannels
    ADD CONSTRAINT fk_retentionpolicieschannels_retentionpolicies FOREIGN KEY (policyid) REFERENCES public.retentionpolicies(id) ON DELETE CASCADE;


--
-- Name: retentionpoliciesteams fk_retentionpoliciesteams_retentionpolicies; Type: FK CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.retentionpoliciesteams
    ADD CONSTRAINT fk_retentionpoliciesteams_retentionpolicies FOREIGN KEY (policyid) REFERENCES public.retentionpolicies(id) ON DELETE CASCADE;


--
-- Name: ir_category_item ir_category_item_categoryid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_category_item
    ADD CONSTRAINT ir_category_item_categoryid_fkey FOREIGN KEY (categoryid) REFERENCES public.ir_category(id);


--
-- Name: ir_metric ir_metric_incidentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_metric
    ADD CONSTRAINT ir_metric_incidentid_fkey FOREIGN KEY (incidentid) REFERENCES public.ir_incident(id);


--
-- Name: ir_metric ir_metric_metricconfigid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_metric
    ADD CONSTRAINT ir_metric_metricconfigid_fkey FOREIGN KEY (metricconfigid) REFERENCES public.ir_metricconfig(id);


--
-- Name: ir_metricconfig ir_metricconfig_playbookid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_metricconfig
    ADD CONSTRAINT ir_metricconfig_playbookid_fkey FOREIGN KEY (playbookid) REFERENCES public.ir_playbook(id);


--
-- Name: ir_playbookautofollow ir_playbookautofollow_playbookid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_playbookautofollow
    ADD CONSTRAINT ir_playbookautofollow_playbookid_fkey FOREIGN KEY (playbookid) REFERENCES public.ir_playbook(id);


--
-- Name: ir_playbookmember ir_playbookmember_playbookid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_playbookmember
    ADD CONSTRAINT ir_playbookmember_playbookid_fkey FOREIGN KEY (playbookid) REFERENCES public.ir_playbook(id);


--
-- Name: ir_run_participants ir_run_participants_incidentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_run_participants
    ADD CONSTRAINT ir_run_participants_incidentid_fkey FOREIGN KEY (incidentid) REFERENCES public.ir_incident(id);


--
-- Name: ir_statusposts ir_statusposts_incidentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_statusposts
    ADD CONSTRAINT ir_statusposts_incidentid_fkey FOREIGN KEY (incidentid) REFERENCES public.ir_incident(id);


--
-- Name: ir_timelineevent ir_timelineevent_incidentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_timelineevent
    ADD CONSTRAINT ir_timelineevent_incidentid_fkey FOREIGN KEY (incidentid) REFERENCES public.ir_incident(id);


--
-- PostgreSQL database dump complete
--

