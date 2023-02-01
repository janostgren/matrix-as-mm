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
    channelid character varying(26) DEFAULT ''::character varying NOT NULL,
    updateat bigint,
    deleteat bigint,
    remoteid character varying(26)
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
szwabpxko3d18fs4db7fx7tywy	1673966480725	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
t9mt88e61ibwbpsxsmgptaf9br	1673966480728	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
iqeoewfhs7npbjbdd3tz4snc1c	1673966481157	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/qio139w9xbyc9pknsx1wo388xc/email/verify/member	user verified	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
hhqrp5cjajfq5fxfzokew7kgdr	1673966481167	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/qio139w9xbyc9pknsx1wo388xc/tokens		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
19heh3xtq3r3feqfk4jnu9f61y	1673966481173	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/qio139w9xbyc9pknsx1wo388xc/tokens	success - token_id=ii1puxgctb86ifuw8big5epn6r	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
45m6dnhmbibmjpwsgbqfx5dafh	1673966481391	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/bqyuo5n95igtiqj15enjran1br/email/verify/member	user verified	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
11ig3n9ogpfftybrpjoacfs4qe	1673966481402	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/bqyuo5n95igtiqj15enjran1br/tokens		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
f31f5k1awpn3meaz6xji1oe6be	1673966481407	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/bqyuo5n95igtiqj15enjran1br/tokens	success - token_id=zqa6p4rjcfgcmn5iqqzgjpdn4r	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
b663rcqswiyepke14d5f8rgt1c	1673966481405	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=qio139w9xbyc9pknsx1wo388xc	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
kgxfbuudf3nxmdoexphj5qxfja	1673966481552	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/bqyuo5n95igtiqj15enjran1br/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
r8btgqpirtds58kqyjgb9tw7wa	1673966481577	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bqyuo5n95igtiqj15enjran1br	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
dme74c8ncf853dj1p9cpatum7a	1673966481581	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/qio139w9xbyc9pknsx1wo388xc/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
was1h61ps7gb3xatdx3wbyjjwc	1673966481601	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=qio139w9xbyc9pknsx1wo388xc	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
69bt6h3xdtrs5bshyibk358o7r	1673966481704	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bqyuo5n95igtiqj15enjran1br	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
iz4ef6oo3if6uxstbcxhsjpyjw	1673967395510	z3pbizcrujd8jfyqq3z3zj1i5c	/api/v4/users/login	attempt - login_id=	172.16.238.1	
ia3euyi7ofdi3fcgx6emi4wfxr	1673967395727	z3pbizcrujd8jfyqq3z3zj1i5c	/api/v4/users/login	authenticated	172.16.238.1	
3wh4sxzzibgnmmatb3joxjde6r	1673967395737	z3pbizcrujd8jfyqq3z3zj1i5c	/api/v4/users/login	success session_user=z3pbizcrujd8jfyqq3z3zj1i5c	172.16.238.1	ytzrzwmw7iggix7f4psy1mb87y
7n4pmk3iyfbt5ez4w149r5169e	1673967430450	z3pbizcrujd8jfyqq3z3zj1i5c	/api/v4/users/logout		172.16.238.1	ytzrzwmw7iggix7f4psy1mb87y
zeinoytuup8z9kj3ydonj6sose	1673967449080		/api/v4/users/login	attempt - login_id=admin	172.16.238.1	
uxrj695uc7b45qg61fpu7xxwey	1673967449187	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/login	authenticated	172.16.238.1	
515snumr93bb5qao8pfkufe4he	1673967449191	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/login	success session_user=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	ckkkarqnobfsx8u1khmxjshwwe
y5nf1h7cxidixybeg9pqb78q7w	1673967450492	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/system/notices/view	attempt	172.16.238.1	ckkkarqnobfsx8u1khmxjshwwe
wk6uszaz6ffrdndptjedp9hdfa	1673967636216	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/teams/tgrw7sjgbiy1jggs3qg3m6zpee/patch		172.16.238.1	ckkkarqnobfsx8u1khmxjshwwe
m5o4g4aeubriukmkoge3xq6efh	1673967867925	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/system/notices/view	attempt	172.16.238.1	ckkkarqnobfsx8u1khmxjshwwe
rkk6s5cnqbgd3kbcmoi1oju5hh	1673968243448	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/logout		172.16.238.1	ckkkarqnobfsx8u1khmxjshwwe
cop3rzo4c7yipekhdba6dfbtiw	1673968258042		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
3jrq1oooyjr4jmre1jgsrozeuo	1673968258141	z3pbizcrujd8jfyqq3z3zj1i5c	/api/v4/users/login	authenticated	172.16.238.1	
dfu3gfx7bbrzipfpidf8b3g84o	1673968258150	z3pbizcrujd8jfyqq3z3zj1i5c	/api/v4/users/login	success session_user=z3pbizcrujd8jfyqq3z3zj1i5c	172.16.238.1	q6zbdigwcp8gtbbkm4uykb7dua
zf6msauo67r98gdu97emwha63e	1673969010639	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
qn8wnr181ifnue6xoufpa4kg5c	1673969010639	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
8qqsn8zrginm9bnti63tsz8sbw	1673969010780	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/qio139w9xbyc9pknsx1wo388xc/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
3q73r3dcdb8j8pmqpbx5q8ioxr	1673969010792	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/bqyuo5n95igtiqj15enjran1br/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
nuh4haj9ntgkub3qsro8iszmuo	1673969010856	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=qio139w9xbyc9pknsx1wo388xc	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
oj64iomi1f8gunu5x1roem15sh	1673969010867	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bqyuo5n95igtiqj15enjran1br	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
pc3y8rqpbfykjmk8w9wmdhr91a	1673969010937	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/hfby48bpd3r5je83kq15ocnyiy/email/verify/member	user verified	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
4b5k8o6fdiditn343cbs49rbha	1673969010956	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/hfby48bpd3r5je83kq15ocnyiy/tokens		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
c3tfez17kbf4fywwc7i3so17qw	1673969010962	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/hfby48bpd3r5je83kq15ocnyiy/tokens	success - token_id=z7etn7g1jfnb8pciotu8bawddh	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
f1frpgcsz3dtj81tukg7aw6qtc	1673969011074	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/bqyuo5n95igtiqj15enjran1br/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
p9kzzrak3p8diypja35tw31i1w	1673969011065	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/qio139w9xbyc9pknsx1wo388xc/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
yrknjj6iepg3ijttwisrwy46he	1673969011072	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/hfby48bpd3r5je83kq15ocnyiy/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
qxndktfcxtnwpjf13epahrwrcw	1673969011176	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=qio139w9xbyc9pknsx1wo388xc	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
po7hqamqdp8xunqjd7w4r7zxme	1673969011204	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bqyuo5n95igtiqj15enjran1br	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
m9913c4fat8pzj6httetj7qq4y	1673969056101	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/hfby48bpd3r5je83kq15ocnyiy/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
xs7wydqsfj8rie5j7c6a7fxice	1673969056130	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=hfby48bpd3r5je83kq15ocnyiy	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
xp9967sakiyjffubdump8sbu3r	1673969056175	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/hfby48bpd3r5je83kq15ocnyiy/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
ugqtadmkb3b99roazofgjfe5qa	1673969056203	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=hfby48bpd3r5je83kq15ocnyiy	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
fk34udfw3jr97mpmyizbjha9gr	1673969011226	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=hfby48bpd3r5je83kq15ocnyiy	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
8xjzs4pwdb899mizmqdregasay	1673969011529	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=hfby48bpd3r5je83kq15ocnyiy	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
86rgmaur6t8ftf6jdybrbzbryc	1673972695861		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
wy6nrw78fif7ik5uehyjtn99sc	1673972696120	z3pbizcrujd8jfyqq3z3zj1i5c	/api/v4/users/login	authenticated	172.16.238.1	
s9mecyjhhjnrbgnsjunrer677y	1673972696150	z3pbizcrujd8jfyqq3z3zj1i5c	/api/v4/users/login	success session_user=z3pbizcrujd8jfyqq3z3zj1i5c	172.16.238.1	8cg59bmtqpf4zrginjoi1774xe
8qeusqi8qj8njyr9ffik9erhey	1673972704092	z3pbizcrujd8jfyqq3z3zj1i5c	/api/v4/users/logout		172.16.238.1	8cg59bmtqpf4zrginjoi1774xe
qt5mehxg3bnf5f9aggcuxw3tyr	1673972839546		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
757i19ju37n6xdsx9mun8eqmqw	1673972839803	z3pbizcrujd8jfyqq3z3zj1i5c	/api/v4/users/login	authenticated	172.16.238.1	
unowhuc7kjgk8fkzdt8tuo9buh	1673972839820	z3pbizcrujd8jfyqq3z3zj1i5c	/api/v4/users/login	success session_user=z3pbizcrujd8jfyqq3z3zj1i5c	172.16.238.1	ssrokj855ibg9xt3o3u4dkdw6c
ci8cdzu4e7g6tqi459gbssg7sh	1673972848590	z3pbizcrujd8jfyqq3z3zj1i5c	/api/v4/users/logout		172.16.238.1	ssrokj855ibg9xt3o3u4dkdw6c
jnjaemnpu3d9iywfbekkyy7n3w	1673972910433		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
wmwq3zukw3ncjexfefd971hjiw	1673972910642	z3pbizcrujd8jfyqq3z3zj1i5c	/api/v4/users/login	authenticated	172.16.238.1	
wae3syzentrsdnbnxrz5e5fi5h	1673972910649	z3pbizcrujd8jfyqq3z3zj1i5c	/api/v4/users/login	success session_user=z3pbizcrujd8jfyqq3z3zj1i5c	172.16.238.1	uo4gbw1x7tybxnd6emenuiz35a
z6bxb3uuxty17gcix8i6hgqopo	1673972920526	z3pbizcrujd8jfyqq3z3zj1i5c	/api/v4/users/logout		172.16.238.1	uo4gbw1x7tybxnd6emenuiz35a
cu1wur39nbgipny1r8jnhwm73h	1674028655379	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
asxogiuk5jr3xdgr6339xirynh	1674028655380	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
44iqsti33pnmpgz6bno59ethqr	1674028655903	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/qio139w9xbyc9pknsx1wo388xc/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
3tmo1xm1k3fq5rifbo67e38k7w	1674028655922	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/bqyuo5n95igtiqj15enjran1br/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
8ey78s5p438jbp5whapaubojte	1674028655969	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/qio139w9xbyc9pknsx1wo388xc/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
5d4gojg9ztd6iri8phitjntouy	1674028655981	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=qio139w9xbyc9pknsx1wo388xc	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
ungaw436w7ft7b6mss1qzus9ro	1674028655989	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/hfby48bpd3r5je83kq15ocnyiy/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
mmfg6t6ecj81fdrystyfjgomae	1674028656039	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=qio139w9xbyc9pknsx1wo388xc	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
613a6ufqy7dbxpjbe3fzaahzoa	1674028656016	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bqyuo5n95igtiqj15enjran1br	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
mzkmuqa41tnydmfj9s9gf5rfpr	1674028656072	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/hfby48bpd3r5je83kq15ocnyiy/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
zazq3hucm7yk7gwkwa9dysof6h	1674028656081	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/bqyuo5n95igtiqj15enjran1br/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
ege71dax7fngpgx5g63heq1dbh	1674028656178	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=hfby48bpd3r5je83kq15ocnyiy	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
agj9sofwttf65mk16nx3b9eqdw	1674028656195	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=hfby48bpd3r5je83kq15ocnyiy	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
wmcsef8wptnx7gtr4w7dcttgkc	1674028656199	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bqyuo5n95igtiqj15enjran1br	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
oxf7oubmoidz9x1konyxj1s85o	1674029671823	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
17p7wtteatn1pn38kdinjkfeze	1674029671831	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
dodkt5fwyi8bzqqxtj9x59swgr	1674029672103	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/qio139w9xbyc9pknsx1wo388xc/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
4153wkoqzfgx5nrqga3n6cwz9r	1674029672157	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=qio139w9xbyc9pknsx1wo388xc	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
zrturrhntjndppo6q689ienkby	1674029672194	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/bqyuo5n95igtiqj15enjran1br/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
nffhjd6r3br3xbtogd3gcdtxyh	1674029672219	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/bqyuo5n95igtiqj15enjran1br/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
zbgcsmeceig6xfzbsfhfynsqfy	1674029672231	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/qio139w9xbyc9pknsx1wo388xc/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
kjp9ard47pyixqzasg9ge1gkuy	1674029672244	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/hfby48bpd3r5je83kq15ocnyiy/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
yg6sf91akbgjxcygi6pq16mtzr	1674029672249	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bqyuo5n95igtiqj15enjran1br	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
xtwkfzqdm7r19crmnmzqjfxbth	1674029672261	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/hfby48bpd3r5je83kq15ocnyiy/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
3qtyddikmbd33pcpt9kxp557wr	1674029672313	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bqyuo5n95igtiqj15enjran1br	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
9jim9bho8bfi5g3cjtmio3ukur	1674029672312	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=qio139w9xbyc9pknsx1wo388xc	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
a4u75496opnxfb6668qm76j97h	1674029672328	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=hfby48bpd3r5je83kq15ocnyiy	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
iip4p4hi7fde9rqzdai5b5unyc	1674029672334	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=hfby48bpd3r5je83kq15ocnyiy	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
u7bgmihwpjb8bcpgore135rh6w	1674046419675	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
j4exqrei6tdrddosb5qhay46ie	1674046419693	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
5o3i3pan53g8bpget333n57nwa	1674046419980	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/bqyuo5n95igtiqj15enjran1br/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
e5uemyntnin15rdot7td6wshjc	1674046419995	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/qio139w9xbyc9pknsx1wo388xc/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
bhezs97iwfnatp3mtwdz7ufpqh	1674046420000	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/hfby48bpd3r5je83kq15ocnyiy/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
dfk75n8uwpym5ciocbeef8w5ic	1674046420051	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bqyuo5n95igtiqj15enjran1br	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
7zxs35kamf8mij7oy8knaoeekh	1674046420059	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=qio139w9xbyc9pknsx1wo388xc	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
3x6wyfp3iprmunxmbgnu4med4o	1674046420067	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/hfby48bpd3r5je83kq15ocnyiy/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
9nc8ws3bk7dqxxtq1hbcyr44cc	1674046420080	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=hfby48bpd3r5je83kq15ocnyiy	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
hg9whz59aidruxsj3zxd8k6o3r	1674046420125	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/qio139w9xbyc9pknsx1wo388xc/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
n8feggge6j893r3xt5g4yyhf6y	1674046420147	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/bqyuo5n95igtiqj15enjran1br/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
yxs5r6bam38mzfaadim71qx6eo	1674046420228	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=hfby48bpd3r5je83kq15ocnyiy	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
f4445wfmutr45kcjindxzdw46e	1674046420231	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bqyuo5n95igtiqj15enjran1br	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
bphpbhurkinm9mr9pguw18xeya	1674046420236	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=qio139w9xbyc9pknsx1wo388xc	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
mj9bd57mkidu8bq8jb6m16cybw	1674060013862	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
czjng8sx3tdcxnrqtjxwp3hrpy	1674060013870	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
wd8eqehhp7dptnrzrejx8ntyhr	1674060014227	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/bqyuo5n95igtiqj15enjran1br/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
kf847d53i7da3gmsgpuwof38jh	1674060014240	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/qio139w9xbyc9pknsx1wo388xc/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
rzcr4t9f3f8xxeepzd7pocr5do	1674060014228	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/hfby48bpd3r5je83kq15ocnyiy/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
xafsz15ewpbbfcirrxo51cc64a	1674060014265	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=qio139w9xbyc9pknsx1wo388xc	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
fpa4eg47e7detmcmrgefad51ie	1674060014262	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/bqyuo5n95igtiqj15enjran1br/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
n6yir348at8m9q6i6kh9p6uw1o	1674060014262	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/hfby48bpd3r5je83kq15ocnyiy/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
dtayydsisjy5fppbaswzqi3tfh	1674060014290	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bqyuo5n95igtiqj15enjran1br	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
uc19cooh7prd3dbijycris99pr	1674060014295	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=hfby48bpd3r5je83kq15ocnyiy	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
eouaxeekc7rffeitx39yh8bi9o	1674060014310	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=hfby48bpd3r5je83kq15ocnyiy	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
uzjqo6ydqtn5mm5zhb5tws4zmc	1674060014321	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/qio139w9xbyc9pknsx1wo388xc/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
7t8mipg6s7ru3e19g6yadugqbr	1674060014333	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bqyuo5n95igtiqj15enjran1br	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
qe6ckmuq1irdxb6o99z3j6papa	1674060014344	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=qio139w9xbyc9pknsx1wo388xc	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
uro8dijgdtr6inukrcmx37iste	1674210716302	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/hfby48bpd3r5je83kq15ocnyiy/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
j7eqtgcnff8hbfdoweapqhcjir	1674111282961	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
k1h4y4p5s7n69dbqoajmrn16yy	1674111282969	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
3cyswuj45tbi5pwbbcqdtff9fa	1674111283215	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/bqyuo5n95igtiqj15enjran1br/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
77qxe5zwkfy5xbr9mqmydqw8ao	1674111283263	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/qio139w9xbyc9pknsx1wo388xc/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
skz8md58fbdrdqof4dn5utkq1o	1674111283309	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/hfby48bpd3r5je83kq15ocnyiy/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
cn6e4r3pyt8wmxjpuwoe3gkyzc	1674111283261	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/hfby48bpd3r5je83kq15ocnyiy/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
dg1c6u43ufbk3k89uqf86eymxe	1674111283329	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/bqyuo5n95igtiqj15enjran1br/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
855c6jmrgib8jfy4ohnr3ksmih	1674111283358	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=hfby48bpd3r5je83kq15ocnyiy	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
n1hffx1iyignfdcaeh8ztz3z4y	1674111283360	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bqyuo5n95igtiqj15enjran1br	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
1woesfj7bpfy9y3cxarjfpt4jo	1674111283382	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=qio139w9xbyc9pknsx1wo388xc	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
jpg86yq3difcictqoan1cgq6jh	1674111283394	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=hfby48bpd3r5je83kq15ocnyiy	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
fqpxcesywp89x8pqzjcwhxxcre	1674111283396	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/qio139w9xbyc9pknsx1wo388xc/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
rqmk6eq3z7f65bn94coaaii7mh	1674111283450	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=qio139w9xbyc9pknsx1wo388xc	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
yi9qwxctipfbbredbymahh9efa	1674111716983	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
s5od7ye417g5pbbbypqkc1bqiw	1674111717191	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/qio139w9xbyc9pknsx1wo388xc/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
4yhkioodkjbe3qt11x1iq7n9ga	1674111717210	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/hfby48bpd3r5je83kq15ocnyiy/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
gh9z1kakctbi5cd4dyf7ek3d8y	1674111717289	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bqyuo5n95igtiqj15enjran1br	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
skct7dufwpf6md8bqbsj8cwrch	1674111717314	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=hfby48bpd3r5je83kq15ocnyiy	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
3aic77gwtjba7dm4fqroa5hufa	1674111717350	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=qio139w9xbyc9pknsx1wo388xc	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
gi8zgrzm3tbh5g8apa76xt4eah	1674112798347	z3pbizcrujd8jfyqq3z3zj1i5c	/api/v4/channels	name=hockey	172.16.238.1	q6zbdigwcp8gtbbkm4uykb7dua
pr8sweg85fdtiqh3w5ay3skwac	1674111283458	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bqyuo5n95igtiqj15enjran1br	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
c4buqfw1dj818mttkf8kn174qe	1674111716977	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
hu9xu5db97nh98g18ab779ftoh	1674111717181	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/bqyuo5n95igtiqj15enjran1br/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
giiqg4bifi8jtqj7u83aewe1eh	1674111717306	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/qio139w9xbyc9pknsx1wo388xc/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
cfj6yfktpjbkfpfguaqtmftj1a	1674111717366	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/bqyuo5n95igtiqj15enjran1br/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
xr17xs6mojryipmy8py4bfpnpe	1674111717379	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=qio139w9xbyc9pknsx1wo388xc	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
n4yh9s1rhbdk9q9mfik9gxam5e	1674111717403	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bqyuo5n95igtiqj15enjran1br	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
x64ub4qr87dadfedttcyfog6hh	1674111717402	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/hfby48bpd3r5je83kq15ocnyiy/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
mj3zijew9bd8dm1s6tijny77te	1674111717523	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=hfby48bpd3r5je83kq15ocnyiy	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
76kd9bz7xjyefqohepsbumah7e	1674111790296	z3pbizcrujd8jfyqq3z3zj1i5c	/api/v4/channels	name=bandy	172.16.238.1	q6zbdigwcp8gtbbkm4uykb7dua
afmm3spinbr3irb6n9y39qt9aw	1674111815641	z3pbizcrujd8jfyqq3z3zj1i5c	/api/v4/channels/r19piuh75bya3ddt69xhjohsba/members	name=bandy user_id=hfby48bpd3r5je83kq15ocnyiy	172.16.238.1	q6zbdigwcp8gtbbkm4uykb7dua
j7r58gujwtdojyxu89pmb7tgdw	1674112823948	z3pbizcrujd8jfyqq3z3zj1i5c	/api/v4/channels/sc6xxqg7qfn8fr9a7dj5pfqudr/members	name=hockey user_id=hfby48bpd3r5je83kq15ocnyiy	172.16.238.1	q6zbdigwcp8gtbbkm4uykb7dua
8zez7rthftgrdfq9cm3rc7ftta	1674210715981	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
jjdetn4d4bytxdfjypydg9ufrc	1674210715985	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bmq7jiumpib3xdz3mx5iyo99ro	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
kgyo85fzo7dw9jxao6pzrx4bkr	1674210716302	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/bqyuo5n95igtiqj15enjran1br/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
748ewtdzn3baz8wfqq37i99b7y	1674210716302	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/bqyuo5n95igtiqj15enjran1br/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
77xebo4zhjbx9gub6b3tpmu6pa	1674210716302	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/qio139w9xbyc9pknsx1wo388xc/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
9eps78atybg4zqqqx3phawzcdc	1674210716266	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/qio139w9xbyc9pknsx1wo388xc/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
e1ngpypc73nyxbg9oupcs8a68w	1674210716392	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/users/hfby48bpd3r5je83kq15ocnyiy/patch		172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
nucpf1jd63yrfg7r6h6skcxw6r	1674210716431	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=bqyuo5n95igtiqj15enjran1br	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
o4i9ih8asiggmpd83wmf1kjhgr	1674210716458	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=hfby48bpd3r5je83kq15ocnyiy	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
zdshskbtb7dj7xj3mczr4y7imr	1674210716426	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=qio139w9xbyc9pknsx1wo388xc	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
1w9ya9j3cbf1urh9o3uxk3mjdh	1674210716421	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=qio139w9xbyc9pknsx1wo388xc	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
bs5ypbi3a7d5b81umkfddtcmnr	1674210716445	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/73uy6kj1jb8wdqrf3ti6zies6r/members	name=off-topic user_id=bqyuo5n95igtiqj15enjran1br	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
eeow5btbbtgof8upn53of58c6w	1674210716447	bmq7jiumpib3xdz3mx5iyo99ro	/api/v4/channels/cxtmz3ubz3gfigd5m6prendmsw/members	name=town-square user_id=hfby48bpd3r5je83kq15ocnyiy	172.16.238.1	fzcwbcg1tfr3fkar9qm49kqfer
\.


--
-- Data for Name: bots; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.bots (userid, description, ownerid, lasticonupdate, createat, updateat, deleteat) FROM stdin;
4yrxecdqy785ubz1wtr6oud5uo	Mattermost Apps Registry and API proxy.	com.mattermost.apps	0	1673965819010	1673965819010	0
74y58caaebyg8mgx5p9gzm8u5r	Playbooks bot.	playbooks	0	1673965820128	1673965820128	0
jf5pp1xbbjnu7j9bekkmuhf87h	Created by Boards plugin.	focalboard	0	1673965821897	1673965821897	0
79skdzyqafbftx6orqugpitixy		bmq7jiumpib3xdz3mx5iyo99ro	0	1673966099808	1673966099808	0
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
cxtmz3ubz3gfigd5m6prendmsw	qio139w9xbyc9pknsx1wo388xc	1673966481287	\N
73uy6kj1jb8wdqrf3ti6zies6r	qio139w9xbyc9pknsx1wo388xc	1673966481323	\N
cxtmz3ubz3gfigd5m6prendmsw	bqyuo5n95igtiqj15enjran1br	1673966481545	\N
73uy6kj1jb8wdqrf3ti6zies6r	bqyuo5n95igtiqj15enjran1br	1673966481633	\N
cxtmz3ubz3gfigd5m6prendmsw	z3pbizcrujd8jfyqq3z3zj1i5c	1673968214739	\N
73uy6kj1jb8wdqrf3ti6zies6r	z3pbizcrujd8jfyqq3z3zj1i5c	1673968214816	\N
73uy6kj1jb8wdqrf3ti6zies6r	hfby48bpd3r5je83kq15ocnyiy	1673969011224	\N
cxtmz3ubz3gfigd5m6prendmsw	hfby48bpd3r5je83kq15ocnyiy	1673969011258	\N
73uy6kj1jb8wdqrf3ti6zies6r	hfby48bpd3r5je83kq15ocnyiy	1673969011351	\N
r19piuh75bya3ddt69xhjohsba	z3pbizcrujd8jfyqq3z3zj1i5c	1674111790266	\N
r19piuh75bya3ddt69xhjohsba	hfby48bpd3r5je83kq15ocnyiy	1674111815639	\N
sc6xxqg7qfn8fr9a7dj5pfqudr	z3pbizcrujd8jfyqq3z3zj1i5c	1674112798287	\N
sc6xxqg7qfn8fr9a7dj5pfqudr	hfby48bpd3r5je83kq15ocnyiy	1674112823944	\N
\.


--
-- Data for Name: channelmembers; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.channelmembers (channelid, userid, roles, lastviewedat, msgcount, mentioncount, notifyprops, lastupdateat, schemeuser, schemeadmin, schemeguest, mentioncountroot, msgcountroot) FROM stdin;
73uy6kj1jb8wdqrf3ti6zies6r	0z4okgmv5lfhx3p0tf6pnpk8sk		0	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1598351852041	t	f	f	0	0
73uy6kj1jb8wdqrf3ti6zies6r	3zats68fztgu9mgu944a4t35so		0	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1598351852041	t	f	f	0	0
73uy6kj1jb8wdqrf3ti6zies6r	5bw66y36bff3umq1q57mfy4y5c		0	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1598351852041	t	f	f	0	0
cxtmz3ubz3gfigd5m6prendmsw	0z4okgmv5lfhx3p0tf6pnpk8sk		0	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1598351852017	t	f	f	0	0
cxtmz3ubz3gfigd5m6prendmsw	3zats68fztgu9mgu944a4t35so		0	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1598351852017	t	f	f	0	0
cxtmz3ubz3gfigd5m6prendmsw	5bw66y36bff3umq1q57mfy4y5c		0	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1598351852017	t	f	f	0	0
cxtmz3ubz3gfigd5m6prendmsw	qio139w9xbyc9pknsx1wo388xc		0	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1673966481281	t	f	f	0	0
73uy6kj1jb8wdqrf3ti6zies6r	qio139w9xbyc9pknsx1wo388xc		0	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1673966481315	t	f	f	0	0
73uy6kj1jb8wdqrf3ti6zies6r	bqyuo5n95igtiqj15enjran1br		0	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1673966481620	t	f	f	0	0
73uy6kj1jb8wdqrf3ti6zies6r	bmq7jiumpib3xdz3mx5iyo99ro		1673966481638	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1673966481638	t	f	f	0	0
cxtmz3ubz3gfigd5m6prendmsw	bmq7jiumpib3xdz3mx5iyo99ro		1673968214744	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1673968214744	t	f	f	0	0
cxtmz3ubz3gfigd5m6prendmsw	bqyuo5n95igtiqj15enjran1br		1673974557078	11	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1673974557078	t	f	f	0	11
r19piuh75bya3ddt69xhjohsba	hfby48bpd3r5je83kq15ocnyiy		0	0	1	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1674111815713	t	f	f	1	0
sc6xxqg7qfn8fr9a7dj5pfqudr	hfby48bpd3r5je83kq15ocnyiy		0	0	1	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1674112824033	t	f	f	1	0
sc6xxqg7qfn8fr9a7dj5pfqudr	z3pbizcrujd8jfyqq3z3zj1i5c		1674112851403	1	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1674112851403	t	t	f	0	1
r19piuh75bya3ddt69xhjohsba	z3pbizcrujd8jfyqq3z3zj1i5c		1674112749988	2	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1674112749988	t	t	f	0	2
73uy6kj1jb8wdqrf3ti6zies6r	z3pbizcrujd8jfyqq3z3zj1i5c		1674211228005	7	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1674211228005	t	f	f	0	7
cxtmz3ubz3gfigd5m6prendmsw	hfby48bpd3r5je83kq15ocnyiy		1674211519784	15	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1674211519784	t	f	f	0	15
cxtmz3ubz3gfigd5m6prendmsw	z3pbizcrujd8jfyqq3z3zj1i5c		1674060070295	14	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1674060070295	t	f	f	0	14
73uy6kj1jb8wdqrf3ti6zies6r	hfby48bpd3r5je83kq15ocnyiy		1674211228005	7	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1674211228005	t	f	f	0	7
\.


--
-- Data for Name: channels; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.channels (id, createat, updateat, deleteat, teamid, type, displayname, name, header, purpose, lastpostat, totalmsgcount, extraupdateat, creatorid, schemeid, groupconstrained, shared, totalmsgcountroot, lastrootpostat) FROM stdin;
sc6xxqg7qfn8fr9a7dj5pfqudr	1674112798146	1674112798146	0	tgrw7sjgbiy1jggs3qg3m6zpee	P	Hockey	hockey			1674112851403	1	0	z3pbizcrujd8jfyqq3z3zj1i5c		f	\N	1	1674112851403
r19piuh75bya3ddt69xhjohsba	1674111790238	1674111790238	0	tgrw7sjgbiy1jggs3qg3m6zpee	O	Bandy	bandy		Testing	1674112749988	2	0	z3pbizcrujd8jfyqq3z3zj1i5c		f	\N	2	1674112749988
73uy6kj1jb8wdqrf3ti6zies6r	1598351837717	1598351837717	0	tgrw7sjgbiy1jggs3qg3m6zpee	O	Off-Topic	off-topic			1674211228005	7	0		\N	\N	\N	7	1674211228005
cxtmz3ubz3gfigd5m6prendmsw	1598351837713	1598351837713	0	tgrw7sjgbiy1jggs3qg3m6zpee	O	Town Square	town-square			1674211519784	15	0		\N	\N	\N	15	1674211519784
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
osidpr7repn5pejjjn79jonabw	z3pbizcrujd8jfyqq3z3zj1i5c	14k56sm19pgspjyiw3eeguqa7o	1674210897894	1674210897894	0	20230120/teams/noteam/channels/73uy6kj1jb8wdqrf3ti6zies6r/users/z3pbizcrujd8jfyqq3z3zj1i5c/osidpr7repn5pejjjn79jonabw/code_style.md			code_style.md	md	15996		0	0	f	\N	# Element Web/Desktop code style guide\n\nThis code style applies to projects which the element-web team directly maintains or is reasonably\nadjacent to. As of writing, these are:\n\n-   element-desktop\n-   element-web\n-   matrix-react-sdk\n-   matrix-js-sdk\n\nOther projects might extend this code style for increased strictness. For example, matrix-events-sdk\nhas stricter code organization to reduce the maintenance burden. These projects will declare their code\nstyle within their own repos.\n\nNote that some requirements will be layer-specific. Where the requirements don't make sense for the\nproject, they are used to the best of their ability, used in spirit, or ignored if not applicable,\nin that order.\n\n## Guiding principles\n\n1. We want the lint rules to feel natural for most team members. No one should have to think too much\n   about the linter.\n2. We want to stay relatively close to [industry standards](https://google.github.io/styleguide/tsguide.html)\n   to make onboarding easier.\n3. We describe what good code looks like rather than point out bad examples. We do this to avoid\n   excessively punishing people for writing code which fails the linter.\n4. When something isn't covered by the style guide, we come up with a reasonable rule rather than\n   claim that it "passes the linter". We update the style guide and linter accordingly.\n5. While we aim to improve readability, understanding, and other aspects of the code, we deliberately\n   do not let solely our personal preferences drive decisions.\n6. We aim to have an understandable guide.\n\n## Coding practices\n\n1. Lint rules enforce decisions made by this guide. The lint rules and this guide are kept in\n   perfect sync.\n2. Commit messages are descriptive for the changes. When the project supports squash merging,\n   only the squashed commit needs to have a descriptive message.\n3. When there is disagreement with a code style approved by the linter, a PR is opened against\n   the lint rules rather than making exceptions on the responsible code PR.\n4. Rules which are intentionally broken (via eslint-ignore, @ts-ignore, etc) have a comment\n   included in the immediate vicinity for why. Determination of whether this is valid applies at\n   code review time.\n5. When editing a file, nearby code is updated to meet the modern standards. "Nearby" is subjective,\n   but should be whatever is reasonable at review time. Such an example might be to update the\n   class's code style, but not the file's.\n    1. These changes should be minor enough to include in the same commit without affecting a code\n       reviewer's job.\n\n## All code\n\nUnless otherwise specified, the following applies to all code:\n\n1. 120 character limit per line. Match existing code in the file if it is using a lower guide.\n2. A tab/indentation is 4 spaces.\n3. Newlines are Unix.\n4. A file has a single empty line at the end.\n5. Lines are trimmed of all excess whitespace, including blank lines.\n6. Long lines are broken up for readability.\n\n## TypeScript / JavaScript {#typescript-javascript}\n\n1. Write TypeScript. Turn JavaScript into TypeScript when working in the area.\n2. Use named exports.\n3. Break long lines to appear as follows:\n\n    ```typescript\n    // Function arguments\n    function doThing(arg1: string, arg2: string, arg3: string): boolean {\n        return !!arg1 && !!arg2 && !!arg3;\n    }\n\n    // Calling a function\n    doThing("String 1", "String 2", "String 3");\n\n    // Reduce line verbosity when possible/reasonable\n    doThing("String1", "String 2", "A much longer string 3");\n\n    // Chaining function calls\n    something\n        .doThing()\n        .doOtherThing()\n        .doMore()\n        .somethingElse((it) => useIt(it));\n    ```\n\n4. Use semicolons for block/line termination.\n    1. Except when defining interfaces, classes, and non-arrow functions specifically.\n5. When a statement's body is a single line, it may be written without curly braces, so long as the body is placed on\n   the same line as the statement.\n\n    ```typescript\n    if (x) doThing();\n    ```\n\n6. Blocks for `if`, `for`, `switch` and so on must have a space surrounding the condition, but not\n   within the condition.\n\n    ```typescript\n    if (x) {\n        doThing();\n    }\n    ```\n\n7. Mixing of logical operands requires brackets to explicitly define boolean logic.\n\n    ```typescript\n    if ((a > b && b > c) || d < e) return true;\n    ```\n\n8. Ternaries use the same rules as `if` statements, plus the following:\n\n    ```typescript\n    // Single line is acceptable\n    const val = a > b ? doThing() : doOtherThing();\n\n    // Multiline is also okay\n    const val = a > b ? doThing() : doOtherThing();\n\n    // Use brackets when using multiple conditions.\n    // Maximum 3 conditions, prefer 2 or less.\n    const val = a > b && b > c ? doThing() : doOtherThing();\n    ```\n\n9. lowerCamelCase is used for function and variable naming.\n10. UpperCamelCase is used for general naming.\n11. Interface names should not be marked with an uppercase `I`.\n12. One variable declaration per line.\n13. If a variable is not receiving a value on declaration, its type must be defined.\n\n    ```typescript\n    let errorMessage: Optional<string>;\n    ```\n\n14. Objects, arrays, enums and so on must have each line terminated with a comma:\n\n    ```typescript\n    const obj = {\n        prop: 1,\n        else: 2,\n    };\n\n    const arr = ["one", "two"];\n\n    enum Thing {\n        Foo,\n        Bar,\n    }\n\n    doThing("arg1", "arg2");\n    ```\n\n15. Objects can use shorthand declarations, including mixing of types.\n\n    ```typescript\n    {\n        room,\n        prop: this.prop,\n    }\n    // ... or ...\n    { room, prop: this.prop }\n    ```\n\n16. Object keys should always be non-strings when possible.\n\n    ```typescript\n    {\n        property: "value",\n        "m.unavoidable": true,\n        [EventType.RoomMessage]: true,\n    }\n    ```\n\n17. Explicitly cast to a boolean.\n\n    ```typescript\n    !!stringVar || Boolean(stringVar);\n    ```\n\n18. Use `switch` statements when checking against more than a few enum-like values.\n19. Use `const` for constants, `let` for mutability.\n20. Describe types exhaustively (ensure noImplictAny would pass).\n    1. Notable exceptions are arrow functions used as parameters, when a void return type is\n       obvious, and when declaring and assigning a variable in the same line.\n21. Declare member visibility (public/private/protected).\n22. Private members are private and not prefixed unless required for naming conflicts.\n    1. Convention is to use an underscore or the word "internal" to denote conflicted member names.\n    2. "Conflicted" typically refers to a getter which wants the same name as the underlying variable.\n23. Prefer readonly members over getters backed by a variable, unless an internal setter is required.\n24. Prefer Interfaces for object definitions, and types for parameter-value-only declarations.\n\n    1. Note that an explicit type is optional if not expected to be used outside of the function call,\n       unlike in this example:\n\n        ```typescript\n        interface MyObject {\n            hasString: boolean;\n        }\n\n        type Options = MyObject | string;\n\n        function doThing(arg: Options) {\n            // ...\n        }\n        ```\n\n25. Variables/properties which are `public static` should also be `readonly` when possible.\n26. Interface and type properties are terminated with semicolons, not commas.\n27. Prefer arrow formatting when declaring functions for interfaces/types:\n\n    ```typescript\n    interface Test {\n        myCallback: (arg: string) => Promise<void>;\n    }\n    ```\n\n28. Prefer a type definition over an inline type. For example, define an interface.\n29. Always prefer to add types or declare a type over the use of `any`. Prefer inferred types\n    when they are not `any`.\n    1. When using `any`, a comment explaining why must be present.\n30. `import` should be used instead of `require`, as `require` does not have types.\n31. Export only what can be reused.\n32. Prefer a type like `Optional<X>` (`type Optional<T> = T | null | undefined`) instead\n    of truly optional parameters.\n\n    1. A notable exception is when the likelihood of a bug is minimal, such as when a function\n       takes an argument that is more often not required than required. An example where the\n       `?` operator is inappropriate is when taking a room ID: typically the caller should\n       supply the room ID if it knows it, otherwise deliberately acknowledge that it doesn't\n       have one with `null`.\n\n        ```typescript\n        function doThingWithRoom(\n            thing: string,\n            room: Optional<string>, // require the caller to specify\n        ) {\n            // ...\n        }\n        ```\n\n33. There should be approximately one interface, class, or enum per file unless the file is named\n    "types.ts", "global.d.ts", or ends with "-types.ts".\n    1. The file name should match the interface, class, or enum name.\n34. Bulk functions can be declared in a single file, though named as "foo-utils.ts" or "utils/foo.ts".\n35. Imports are grouped by external module imports first, then by internal imports.\n36. File ordering is not strict, but should generally follow this sequence:\n    1. Licence header\n    2. Imports\n    3. Constants\n    4. Enums\n    5. Interfaces\n    6. Functions\n    7. Classes\n        1. Public/protected/private static properties\n        2. Public/protected/private properties\n        3. Constructors\n        4. Public/protected/private getters & setters\n        5. Protected and abstract functions\n        6. Public/private functions\n        7. Public/protected/private static functions\n37. Variable names should be noticeably unique from their types. For example, "str: string" instead\n    of "string: string".\n38. Use double quotes to enclose strings. You may use single quotes if the string contains double quotes.\n\n    ```typescript\n    const example1 = "simple string";\n    const example2 = 'string containing "double quotes"';\n    ```\n\n39. Prefer async-await to promise-chaining\n\n    ```typescript\n    async function () {\n        const result = await anotherAsyncFunction();\n        // ...\n    }\n    ```\n\n## React\n\nInheriting all the rules of TypeScript, the following additionally apply:\n\n1. Types for lifecycle functions are not required (render, componentDidMount, and so on).\n2. Class components must always have a `Props` interface declared immediately above them. It can be\n   empty if the component accepts no props.\n3. Class components should have an `State` interface declared immediately above them, but after `Props`.\n4. Props and State should not be exported. Use `React.ComponentProps<typeof ComponentNameHere>`\n   instead.\n5. One component per file, except when a component is a utility component specifically for the "primary"\n   component. The utility component should not be exported.\n6. Exported constants, enums, interfaces, functions, etc must be separate from files containing components\n   or stores.\n7. Stores should use a singleton pattern with a static instance property:\n\n    ```typescript\n    class FooStore {\n        public static readonly instance = new FooStore();\n\n        // or if the instance can't be created eagerly:\n        private static _instance: FooStore;\n        public static get instance(): FooStore {\n            if (!FooStore._instance) {\n                FooStore._instance = new FooStore();\n            }\n            return FooStore._instance;\n        }\n    }\n    ```\n\n8. Stores must support using an alternative MatrixClient and dispatcher instance.\n9. Utilities which require JSX must be split out from utilities which do not. This is to prevent import\n   cycles during runtime where components accidentally include more of the app than they intended.\n10. Interdependence between stores should be kept to a minimum. Break functions and constants out to utilities\n    if at all possible.\n11. A component should only use CSS class names in line with the component name.\n    1. When knowingly using a class name from another component, document it.\n12. Break components over multiple lines like so:\n\n    ```typescript\n    function render() {\n        return <Component prop1="test" prop2={this.state.variable} />;\n\n        // or\n\n        return <Component prop1="test" prop2={this.state.variable} />;\n\n        // or if children are needed (infer parens usage)\n\n        return (\n            <Component prop1="test" prop2={this.state.variable}>\n                {_t("Short string here")}\n            </Component>\n        );\n\n        return (\n            <Component prop1="test" prop2={this.state.variable}>\n                {_t("Longer string here")}\n            </Component>\n        );\n    }\n    ```\n\n13. Curly braces within JSX should be padded with a space, however properties on those components should not.\n    See above code example.\n14. Functions used as properties should either be defined on the class or stored in a variable. They should not\n    be inline unless mocking/short-circuiting the value.\n15. Prefer hooks (functional components) over class components. Be consistent with the existing area if unsure\n    which should be used.\n    1. Unless the component is considered a "structure", in which case use classes.\n16. Write more views than structures. Structures are chunks of functionality like MatrixChat while views are\n    isolated components.\n17. Components should serve a single, or near-single, purpose.\n18. Prefer to derive information from component properties rather than establish state.\n19. Do not use `React.Component::forceUpdate`.\n\n## Stylesheets (\\*.pcss = PostCSS + Plugins)\n\nNote: We use PostCSS + some plugins to process our styles. It looks like SCSS, but actually it is not.\n\n1. Class names must be prefixed with "mx\\_".\n2. Class names should denote the component which defines them, followed by any context:\n    1. mx_MyFoo\n    2. mx_MyFoo_avatar\n    3. mx_MyFoo_avatar--user\n3. Use the `$font` and `$spacing` variables instead of manual values.\n4. Keep indentation/nesting to a minimum. Maximum suggested nesting is 5 layers.\n5. Use the whole class name instead of shortcuts:\n\n    ```scss\n    .mx_MyFoo {\n        & .mx_MyFoo_avatar {\n            // instead of &_avatar\n            // ...\n        }\n    }\n    ```\n\n6. Break multiple selectors over multiple lines this way:\n\n    ```scss\n    .mx_MyFoo,\n    .mx_MyBar,\n    .mx_MyFooBar {\n        // ...\n    }\n    ```\n\n7. Non-shared variables should use $lowerCamelCase. Shared variables use $dashed-naming.\n8. Overrides to Z indexes, adjustments of dimensions/padding with pixels, and so on should all be\n   documented for what the values mean:\n\n    ```scss\n    .mx_MyFoo {\n        width: calc(100% - 12px); // 12px for read receipts\n        top: -2px; // visually centred vertically\n        z-index: 10; // above user avatar, but below dialogs\n    }\n    ```\n\n9. Avoid the use of `!important`. If necessary, add a comment.\n\n## Tests\n\n1. Tests must be written in TypeScript.\n2. Jest mocks are declared below imports, but above everything else.\n3. Use the following convention template:\n\n    ```typescript\n    // Describe the class, component, or file name.\n    describe("FooComponent", () => {\n        // all test inspecific variables go here\n\n        beforeEach(() => {\n            // exclude if not used.\n        });\n\n        afterEach(() => {\n            // exclude if not used.\n        });\n\n        // Use "it should..." terminology\n        it("should call the correct API", async () => {\n            // test-specific variables go here\n            // function calls/state changes go here\n            // expectations go here\n        });\n    });\n\n    // If the file being tested is a utility class:\n    describe("foo-utils", () => {\n        describe("firstUtilFunction", () => {\n            it("should...", async () => {\n                // ...\n            });\n        });\n\n        describe("secondUtilFunction", () => {\n            it("should...", async () => {\n                // ...\n            });\n        });\n    });\n    ```\n		f
xrmywz8trfno7jx7dyt7nqzt1c	hfby48bpd3r5je83kq15ocnyiy	9arqkaza4irbixj5xqekrxeaqr	1674211098974	1674211098974	0	20230120/teams/noteam/channels/73uy6kj1jb8wdqrf3ti6zies6r/users/hfby48bpd3r5je83kq15ocnyiy/xrmywz8trfno7jx7dyt7nqzt1c/AB9719AB-315B-4EAB-AB5F-84EBA089EBB5.heic			AB9719AB-315B-4EAB-AB5F-84EBA089EBB5.heic	heic	2178164		0	0	f	\N			f
yd5pem8jqtdkp85ujit6sbsnqh	hfby48bpd3r5je83kq15ocnyiy	f5stqsigmpg33mbjf8sfimsrra	1674211226052	1674211226052	0	20230120/teams/noteam/channels/73uy6kj1jb8wdqrf3ti6zies6r/users/hfby48bpd3r5je83kq15ocnyiy/yd5pem8jqtdkp85ujit6sbsnqh/A1D99574-D44E-4526-BEBD-470362011CD5.jpeg	20230120/teams/noteam/channels/73uy6kj1jb8wdqrf3ti6zies6r/users/hfby48bpd3r5je83kq15ocnyiy/yd5pem8jqtdkp85ujit6sbsnqh/A1D99574-D44E-4526-BEBD-470362011CD5_thumb.jpg	20230120/teams/noteam/channels/73uy6kj1jb8wdqrf3ti6zies6r/users/hfby48bpd3r5je83kq15ocnyiy/yd5pem8jqtdkp85ujit6sbsnqh/A1D99574-D44E-4526-BEBD-470362011CD5_preview.jpg	A1D99574-D44E-4526-BEBD-470362011CD5.jpeg	jpeg	3068971	image/jpeg	4032	3024	t	\\xffd8ffdb0084000302020302020303030304030304050805050404050a070706080c0a0c0c0b0a0b0b0d0e12100d0e110e0b0b1016101113141515150c0f1718161418121415140103040405040509050509140d0b0d1414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414ffc00011080010001003012200021101031101ffc401a20000010501010101010100000000000000000102030405060708090a0b100002010303020403050504040000017d01020300041105122131410613516107227114328191a1082342b1c11552d1f02433627282090a161718191a25262728292a3435363738393a434445464748494a535455565758595a636465666768696a737475767778797a838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae1e2e3e4e5e6e7e8e9eaf1f2f3f4f5f6f7f8f9fa0100030101010101010101010000000000000102030405060708090a0b1100020102040403040705040400010277000102031104052131061241510761711322328108144291a1b1c109233352f0156272d10a162434e125f11718191a262728292a35363738393a434445464748494a535455565758595a636465666768696a737475767778797a82838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae2e3e4e5e6e7e8e9eaf2f3f4f5f6f7f8f9faffda000c03010002110311003f00f61f177c5ff0ddda4822f0f6ad70f8e03c96e83f13e61c7e55e47e22f16d9ea3bfcaf0fadbaf669afd0e3f05535e77a9f88653212ae5327231c9acbb8d6e4914063e6f72251bbf5aef966f8bb5948e3596e1e32bd8ffd9			f
\.


--
-- Data for Name: focalboard_blocks; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_blocks (id, insert_at, parent_id, schema, type, title, fields, create_at, update_at, delete_at, root_id, modified_by, channel_id, created_by, board_id) FROM stdin;
ciwp7htn7strcfb6x6jummtqcre	2023-01-17 14:30:21.922829+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Team Schedule	{"contentOrder":["ag5yd49ddubyg7p4o1uh1yqtn8r","7aogktzf8c38x9ytux6p37isxie","abrc9cnrk6tfwjg4m3d8g8rpb7w","7xco9wosbhjreiqs3ddn4yh3pir","7jkshqesxtpnn38bc7ydjzcwpmr","7qjnd15spuif9tgzdso9eqf1qja"],"icon":"⏰","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"8b05c83e-a44a-4d04-831e-97f01d8e2003","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"34eb9c25-d5bf-49d9-859e-f74f4e0030e7"}}	1673965821937	1673965821937	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
cdm7adft76tdtjrydoxjnif4p8y	2023-01-17 14:30:21.922829+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Video production	{"contentOrder":["autjd9uyypfdazfagneb35j7b6y","76zruzbprtfypppgskjzszgb63e","ataig68tpy3fo7qw5mdfdwofwgh","77okzej4urtdx3k97gccx83afyc","7bui9mgdqm3ygtkfih4dd1bmwwh","77sg6hmt63385bcdhzfe7uckbjh"],"icon":"📹","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"b1abafbf-a038-4a19-8b68-56e0fd2319f7","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"34eb9c25-d5bf-49d9-859e-f74f4e0030e7"}}	1673965821946	1673965821946	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
cfoaipyhu97yt9pzhoz35d5r9by	2023-01-17 14:30:21.922829+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Offsite plans	{"contentOrder":["aj6chr8faf78f8k4krocuoam1cr","7cireohxwnjg4zy53qokogsghir","atqngytobziyzpyaw3x6aw8rqbe","78ncuyso5j3rai8oh5o6auhje5c","7hq7f64kag7b6dc1u38npftd5oo","7d6csj67odf8tpduqpkcenq1q4h"],"icon":"🚙","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"8b05c83e-a44a-4d04-831e-97f01d8e2003","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"dabadd9b-adf1-4d9f-8702-805ac6cef602"}}	1673965821952	1673965821952	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
c138xdxrczjfuidn8kf7633ddoy	2023-01-17 14:30:21.922829+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Social Media Strategy	{"contentOrder":["akmcci8p8sjbd5fca3n94rqathe","71mtcnejj3jdh58p3h4i999gzdy","atnibwzraabnizbu1c19fwjy8ew","74775cqcg93r8xbtdmbpobpwnhr","745b6gu9saf8wzrxeuh36e4bqio","7eu8m8wep9p8xiksj19p7wxpitw"],"icon":"🎉","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"b1abafbf-a038-4a19-8b68-56e0fd2319f7","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"d37a61f4-f332-4db9-8b2d-5e0a91aa20ed"}}	1673965821959	1673965821959	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
vzgb9dheqcbd1uqqkr3fhmh9ebh	2023-01-17 14:30:21.922829+00	b7wnw9awd4pnefryhq51apbzb4c	1	view	Discussion Items	{"cardOrder":["cjpkiya33qsagr4f9hrdwhgiajc"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"d777ba3b-8728-40d1-87a6-59406bbbbfb0","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[{"propertyId":"4cf1568d-530f-4028-8ffd-bdc65249187e","reversed":false}],"viewType":"board","visibleOptionIds":[],"visiblePropertyIds":["4cf1568d-530f-4028-8ffd-bdc65249187e"]}	1673965821966	1673965821966	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
7jkshqesxtpnn38bc7ydjzcwpmr	2023-01-17 14:30:21.922829+00	ciwp7htn7strcfb6x6jummtqcre	1	checkbox		{"value":false}	1673965821976	1673965821976	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
7xco9wosbhjreiqs3ddn4yh3pir	2023-01-17 14:30:21.922829+00	ciwp7htn7strcfb6x6jummtqcre	1	checkbox		{"value":false}	1673965821983	1673965821983	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
7aogktzf8c38x9ytux6p37isxie	2023-01-17 14:30:21.922829+00	ciwp7htn7strcfb6x6jummtqcre	1	divider		{}	1673965821988	1673965821988	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
7qjnd15spuif9tgzdso9eqf1qja	2023-01-17 14:30:21.922829+00	ciwp7htn7strcfb6x6jummtqcre	1	checkbox		{"value":false}	1673965821995	1673965821994	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
ag5yd49ddubyg7p4o1uh1yqtn8r	2023-01-17 14:30:21.922829+00	ciwp7htn7strcfb6x6jummtqcre	1	text	## Notes\n*[Add meeting notes here]*	{}	1673965822000	1673965822000	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
abrc9cnrk6tfwjg4m3d8g8rpb7w	2023-01-17 14:30:21.922829+00	ciwp7htn7strcfb6x6jummtqcre	1	text	## Action Items	{}	1673965822005	1673965822005	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
7xqx11ymuntnzpry81fsqrfmdqy	2023-01-17 14:30:21.922829+00	ch798q5ucefyobf5bymgqjt4f3h	1	divider		{}	1673965822010	1673965822010	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
7f6np7oqeoir3xf58xk7yrd3foa	2023-01-17 14:30:21.922829+00	ch798q5ucefyobf5bymgqjt4f3h	1	checkbox		{"value":false}	1673965822015	1673965822015	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
7dfqkkxosgb8tzpubhcoqf78e7w	2023-01-17 14:30:21.922829+00	ch798q5ucefyobf5bymgqjt4f3h	1	checkbox		{"value":false}	1673965822019	1673965822019	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
7n1x4rz87p38i3rywza1zz9gk9e	2023-01-17 14:30:21.922829+00	ch798q5ucefyobf5bymgqjt4f3h	1	checkbox		{"value":false}	1673965822025	1673965822025	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
actcefa5npfbajngq7wmmxhpenc	2023-01-17 14:30:21.922829+00	ch798q5ucefyobf5bymgqjt4f3h	1	text	# Action Items	{}	1673965822032	1673965822032	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
abhkoi31zejy77p9m5tso1ew9je	2023-01-17 14:30:21.922829+00	ch798q5ucefyobf5bymgqjt4f3h	1	text	# Notes\n*[Add meeting notes here]*	{}	1673965822037	1673965822037	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
76zruzbprtfypppgskjzszgb63e	2023-01-17 14:30:21.922829+00	cdm7adft76tdtjrydoxjnif4p8y	1	divider		{}	1673965822043	1673965822043	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
77sg6hmt63385bcdhzfe7uckbjh	2023-01-17 14:30:21.922829+00	cdm7adft76tdtjrydoxjnif4p8y	1	checkbox		{"value":false}	1673965822056	1673965822056	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
7bui9mgdqm3ygtkfih4dd1bmwwh	2023-01-17 14:30:21.922829+00	cdm7adft76tdtjrydoxjnif4p8y	1	checkbox		{"value":false}	1673965822073	1673965822073	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
77okzej4urtdx3k97gccx83afyc	2023-01-17 14:30:21.922829+00	cdm7adft76tdtjrydoxjnif4p8y	1	checkbox		{"value":false}	1673965822078	1673965822078	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
ataig68tpy3fo7qw5mdfdwofwgh	2023-01-17 14:30:21.922829+00	cdm7adft76tdtjrydoxjnif4p8y	1	text	## Action Items	{}	1673965822082	1673965822082	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
autjd9uyypfdazfagneb35j7b6y	2023-01-17 14:30:21.922829+00	cdm7adft76tdtjrydoxjnif4p8y	1	text	## Notes\n*[Add meeting notes here]*	{}	1673965822087	1673965822087	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
78ncuyso5j3rai8oh5o6auhje5c	2023-01-17 14:30:21.922829+00	cfoaipyhu97yt9pzhoz35d5r9by	1	checkbox		{"value":false}	1673965822096	1673965822096	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
7hq7f64kag7b6dc1u38npftd5oo	2023-01-17 14:30:21.922829+00	cfoaipyhu97yt9pzhoz35d5r9by	1	checkbox		{"value":false}	1673965822101	1673965822100	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
7cireohxwnjg4zy53qokogsghir	2023-01-17 14:30:21.922829+00	cfoaipyhu97yt9pzhoz35d5r9by	1	divider		{}	1673965822111	1673965822111	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
7d6csj67odf8tpduqpkcenq1q4h	2023-01-17 14:30:21.922829+00	cfoaipyhu97yt9pzhoz35d5r9by	1	checkbox		{"value":false}	1673965822115	1673965822115	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
atqngytobziyzpyaw3x6aw8rqbe	2023-01-17 14:30:21.922829+00	cfoaipyhu97yt9pzhoz35d5r9by	1	text	## Action Items	{}	1673965822121	1673965822121	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
aj6chr8faf78f8k4krocuoam1cr	2023-01-17 14:30:21.922829+00	cfoaipyhu97yt9pzhoz35d5r9by	1	text	## Notes\n*[Add meeting notes here]*	{}	1673965822128	1673965822128	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
71mtcnejj3jdh58p3h4i999gzdy	2023-01-17 14:30:21.922829+00	c138xdxrczjfuidn8kf7633ddoy	1	divider		{}	1673965822133	1673965822133	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
745b6gu9saf8wzrxeuh36e4bqio	2023-01-17 14:30:21.922829+00	c138xdxrczjfuidn8kf7633ddoy	1	checkbox		{"value":false}	1673965822139	1673965822139	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
7eu8m8wep9p8xiksj19p7wxpitw	2023-01-17 14:30:21.922829+00	c138xdxrczjfuidn8kf7633ddoy	1	checkbox		{"value":false}	1673965822145	1673965822145	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
74775cqcg93r8xbtdmbpobpwnhr	2023-01-17 14:30:21.922829+00	c138xdxrczjfuidn8kf7633ddoy	1	checkbox		{"value":false}	1673965822150	1673965822150	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
atnibwzraabnizbu1c19fwjy8ew	2023-01-17 14:30:21.922829+00	c138xdxrczjfuidn8kf7633ddoy	1	text	## Action Items	{}	1673965822155	1673965822155	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
akmcci8p8sjbd5fca3n94rqathe	2023-01-17 14:30:21.922829+00	c138xdxrczjfuidn8kf7633ddoy	1	text	## Notes\n*[Add meeting notes here]*	{}	1673965822160	1673965822160	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
vcfd8fwfdi7fnibebud3nzeffdw	2023-01-17 14:30:22.437069+00		1	view	All Contacts	{"cardOrder":["crn69z85umjbxtqbk7nj6rne4ic","c8x67gy9xepfxzptgxzt8wgytzr","c7nxcehxnbtrmde6gsb4zqpjq4r","cudjd3axpfpf35dche43a1mbhma","cosmtosxa73bw5p1t1cohy4ks8a"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":240,"a1438fbbhjeffkexmcfhnx99o1h":151,"a5hwxjsmkn6bak6r7uea5bx1kwc":132,"abru6tz8uebdxy4skheqidh7zxy":247,"adtf1151chornmihz4xbgbk9exa":125,"aejo5tcmq54bauuueem9wc4fw4y":127,"ahf43e44h3y8ftanqgzno9z7q7w":129,"ainpw47babwkpyj77ic4b9zq9xr":157,"amahgyn9n4twaapg3jyxb6y4jic":224,"amba7ot98fh7hwsx8jdcfst5g7h":171,"aoheuj1f3mu6eehygr45fxa144y":130,"auhf91pm85f73swwidi4wid8jqe":157},"defaultTemplateId":"c1zr4ry1y9fdsmpdxyu4i5n8ieo","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a5hwxjsmkn6bak6r7uea5bx1kwc","aoheuj1f3mu6eehygr45fxa144y","aro91wme9kfaie5ceu9qasmtcnw","ainpw47babwkpyj77ic4b9zq9xr","ahf43e44h3y8ftanqgzno9z7q7w","amahgyn9n4twaapg3jyxb6y4jic","abru6tz8uebdxy4skheqidh7zxy","a1438fbbhjeffkexmcfhnx99o1h","auhf91pm85f73swwidi4wid8jqe","adtf1151chornmihz4xbgbk9exa","aejo5tcmq54bauuueem9wc4fw4y","amba7ot98fh7hwsx8jdcfst5g7h"]}	1673965822453	1673965822453	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
v6dam9wyi4fyw8qwotdh4q86fkc	2023-01-17 14:30:22.437069+00		1	view	Pipeline Tracker	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["akj61wc9yxdwyw3t6m8igyf9d5o","aic89a5xox4wbppi6mbyx6ujsda","ah6ehh43rwj88jy4awensin8pcw","aprhd96zwi34o9cs4xyr3o9sf3c","axesd74yuxtbmw1sbk8ufax7z3a","a5txuiubumsmrs8gsd5jz5gc1oa","acm9q494bcthyoqzmfogxxy5czy"],"visiblePropertyIds":["aro91wme9kfaie5ceu9qasmtcnw","amahgyn9n4twaapg3jyxb6y4jic"]}	1673965822462	1673965822462	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
cudjd3axpfpf35dche43a1mbhma	2023-01-17 14:30:22.437069+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Jonathan Frazier	{"contentOrder":["afthufxrpufnfpqgs9ukt6mh61h","agh64gmmhmpfszq9y5fkf3sdoie","75ygzpukfp3d9pd4hg7gmsyns5y","7ajczotzwufg5pmogr6x6wr7fpe","74hum7x8dt3y8xj5jjqm58siqoe","7ektofrqr73b8pn6hb5ri4b41fh","755ofpmqahbynmqfd5wky9n4kie","74p999ukr6igq9ghrtys7r7puqo","7st7hn7uxtbnjjbefcmntesofxc","7qnakgtdgppym5ptehjhoc7nw5y","7q9pg9x1cejnezxuh1gq5i6iqgh","7rt179h6mqpfa9eqktqyig4fcur"],"icon":"🙎‍♂️","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(999) 123-5678","a5hwxjsmkn6bak6r7uea5bx1kwc":"a5txuiubumsmrs8gsd5jz5gc1oa","abru6tz8uebdxy4skheqidh7zxy":"jonathan.frazier@email.com","aejo5tcmq54bauuueem9wc4fw4y":"0%","ahf43e44h3y8ftanqgzno9z7q7w":"$800,000","ainpw47babwkpyj77ic4b9zq9xr":"Ositions Inc.","amahgyn9n4twaapg3jyxb6y4jic":"as5bk6afoaaa7caewe1zc391sce","aro91wme9kfaie5ceu9qasmtcnw":"apiswzj7uiwbh87z8dw8c6mturw","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1669118400000}"}}	1673965822469	1673965822469	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
c7nxcehxnbtrmde6gsb4zqpjq4r	2023-01-17 14:30:22.437069+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Richard Guzman	{"contentOrder":["aroqaaui77bbhfe5d31g5yoonxh","a771mgefirbgzux3k3dgtc35pho","7nmczue3dnty7dn1mp6g9udpffy","73z9ect9o1fr15cx36ju3y16y1a","71xg1cm3hct8x3dm5pfsb1mtkfw","7zowyocezgbbfxxqefga7c5mqww","7buzfau6q5prkmxoorii5abam9w","7gpmwybbxgpdyxc9z1uhkkhnz7w","71txyexmzotn89dcxqrq383o38e","7gecsxrtt5pn47dmhkcpfoc7h4a","7qbry9x9cztno5bgf38j56bktsc","7pp7sopttf3dkzei65d5rguytqh"],"icon":"👨‍💼","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(222) 123-1234","a5hwxjsmkn6bak6r7uea5bx1kwc":"axesd74yuxtbmw1sbk8ufax7z3a","abru6tz8uebdxy4skheqidh7zxy":"richard.guzman@email.com","adtf1151chornmihz4xbgbk9exa":"{\\"from\\":1681992000000}","aejo5tcmq54bauuueem9wc4fw4y":"80%","ahf43e44h3y8ftanqgzno9z7q7w":"$3,200,000","ainpw47babwkpyj77ic4b9zq9xr":"Afformance Ltd.","amahgyn9n4twaapg3jyxb6y4jic":"ar6t1ttcumgfuqugg5o4g4mzrza","aro91wme9kfaie5ceu9qasmtcnw":"apjnaggwixchfxwiatfh7ey7uno","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1667476800000}"}}	1673965822476	1673965822476	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
cosmtosxa73bw5p1t1cohy4ks8a	2023-01-17 14:30:22.437069+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Byron Cole	{"contentOrder":["ahxaszp31f3yhjjo19eu3544z8o","ajwdcjesu5jy1ugwep9q4g1an1h","78fbar4fyg7bc3gigp3pj1m8gkr","7i1kqqtiz87bbumih14rrewqk9h","7rbokobjh9bnc5ctprmksycxiec","7jre9ywhr4jybdp1kmt5oz4rwww","748ofm3bwk3rytfshqau13iazsw","77equnzy4qigcj8xwb66wqhraoh","7cdxopq4bpinpina7u3njzjw8da","7o9qnzhanjt8pxf8pe4xmk3gn7r","7amc5xqsac3g1jmft5q9ukprzur","791t7xpee5jbn9rxwf5uee5196c"],"icon":"🤵","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(333) 123-1234","a5hwxjsmkn6bak6r7uea5bx1kwc":"acm9q494bcthyoqzmfogxxy5czy","abru6tz8uebdxy4skheqidh7zxy":"byron.cole@email.com","adtf1151chornmihz4xbgbk9exa":"{\\"from\\":1667563200000}","aejo5tcmq54bauuueem9wc4fw4y":"100%","ahf43e44h3y8ftanqgzno9z7q7w":"$500,000","ainpw47babwkpyj77ic4b9zq9xr":"Helx Industries","amahgyn9n4twaapg3jyxb6y4jic":"aafwyza5iwdcwcyfyj6bp7emufw","aro91wme9kfaie5ceu9qasmtcnw":"apjnaggwixchfxwiatfh7ey7uno","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1667822400000}"}}	1673965822483	1673965822483	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7qbry9x9cztno5bgf38j56bktsc	2023-01-17 14:30:22.437069+00	c7nxcehxnbtrmde6gsb4zqpjq4r	1	checkbox	Hand-off to customer success	{}	1673965822617	1673965822617	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7gecsxrtt5pn47dmhkcpfoc7h4a	2023-01-17 14:30:22.437069+00	c7nxcehxnbtrmde6gsb4zqpjq4r	1	checkbox	Finalize contract	{}	1673965822622	1673965822622	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7pp7sopttf3dkzei65d5rguytqh	2023-01-17 14:30:22.437069+00	c7nxcehxnbtrmde6gsb4zqpjq4r	1	checkbox	Post-sales follow up	{}	1673965822627	1673965822627	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
c8x67gy9xepfxzptgxzt8wgytzr	2023-01-17 14:30:22.437069+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Caitlyn Russel	{"contentOrder":["ah64hewt1iffsfb3b9gjggcde9h","affik4pq6mpn8zqjc9prdrhtq3c","7mtji9sd7zf8puqfe5subkm9i1r","7xjcp7osgobbh7xtaeuqdri5zfa","799fwf5a49tba8x615kcfwuprge","75s6bgegkrpgdibowmmcr4dk6sy","7cj4p6dnqxidqufbpmmci3tqofw","7a655j9kehi8fjxrj7k6c6kuooe","7wbkktsfo73gkzgj8t7bx94y1ce","7ca85myg8p3y9fmwsrxzxe6qxer","7ddzqqhzbx7yxbcqk7iikeuch5o","7jmhxnwpux3gyipyj3a3iarpgzr"],"icon":"🧑‍💼","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(111) 123-1234","a5hwxjsmkn6bak6r7uea5bx1kwc":"ah6ehh43rwj88jy4awensin8pcw","abru6tz8uebdxy4skheqidh7zxy":"caitlyn.russel@email.com","adtf1151chornmihz4xbgbk9exa":"{\\"from\\":1689336000000}","aejo5tcmq54bauuueem9wc4fw4y":"20%","ahf43e44h3y8ftanqgzno9z7q7w":"$250,000","ainpw47babwkpyj77ic4b9zq9xr":"Liminary Corp.","amahgyn9n4twaapg3jyxb6y4jic":"aafwyza5iwdcwcyfyj6bp7emufw","aro91wme9kfaie5ceu9qasmtcnw":"apiswzj7uiwbh87z8dw8c6mturw","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1668168000000}"}}	1673965822491	1673965822491	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
c1zr4ry1y9fdsmpdxyu4i5n8ieo	2023-01-17 14:30:22.437069+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	New Prospect	{"contentOrder":["adi6x775bujrgmyqscpt3c93xxe","ax1x8sw6gnpbb5m3e83md6x1b1c","7oq53yacgn78e9mgw7rtyh8bhzy","7n5erteor5bdgmbdgbgpeptb38w","7y6nw38oywtbg9xypjquugqkhyy","7o4sc444ekir73ysppiq9uhwm4o","7hruqoce41pd37k6jx3x8tthr1r","7ndxi8gb593n6zyc7bdnehbfwoo","76g3pktsh4bf97ycyx1p44reytc","7f4oxkpqy7brgjnei6zmnft7qno","73io7mjdtgj8ifnr96dm7cz7eia","79rae1r6dwidwxftw7s43cd77kh"],"icon":"👤","isTemplate":true,"properties":{"a5hwxjsmkn6bak6r7uea5bx1kwc":"akj61wc9yxdwyw3t6m8igyf9d5o"}}	1673965822499	1673965822499	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
crn69z85umjbxtqbk7nj6rne4ic	2023-01-17 14:30:22.437069+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Shelby Olson	{"contentOrder":["aiepiz4odbbdt3d3e55dcpqjsdc","a4jxu74p6z3gpfeixwpc4pwd47w","7866hyr5143rk9q3q5zrtkn17er","743pmufq1tfdutbmurn5bx7rzor","73j6remhzifrhbm4irkc9nc1c3e","7wqbg84e4ab8rzdqoqun3yhwp8a","7jreh9zg4kfgq9gd6kza7ty6jqr","7f8tsoayeeig63nwym8u6o458bw","7jkepmbfsnj8m5xtddh4tyfot7o","7zhgzabkydiyszk1tfz5ggbszby","7zqi73bttx3fuiqjydosrjnu3hr","7pxag7ngrabyk3kf4rzhc89k1bh"],"icon":"🙎‍♀️","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(111) 321-5678","a5hwxjsmkn6bak6r7uea5bx1kwc":"akj61wc9yxdwyw3t6m8igyf9d5o","abru6tz8uebdxy4skheqidh7zxy":"shelby.olson@email.com","ahf43e44h3y8ftanqgzno9z7q7w":"$30,000","ainpw47babwkpyj77ic4b9zq9xr":"Kadera Global","amahgyn9n4twaapg3jyxb6y4jic":"ar6t1ttcumgfuqugg5o4g4mzrza","aro91wme9kfaie5ceu9qasmtcnw":"auu9bfzqeuruyjwzzqgz7q8apuw","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1669291200000}"}}	1673965822505	1673965822505	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
vrzf5mg7nutfe88y1zc4zuaskgr	2023-01-17 14:30:22.437069+00	bzwb99zf498tsm7mjqbiy7g81ze	1	view	Open Deals	{"cardOrder":["c8x67gy9xepfxzptgxzt8wgytzr"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[{"condition":"includes","propertyId":"a5hwxjsmkn6bak6r7uea5bx1kwc","values":["akj61wc9yxdwyw3t6m8igyf9d5o","aic89a5xox4wbppi6mbyx6ujsda","ah6ehh43rwj88jy4awensin8pcw","aprhd96zwi34o9cs4xyr3o9sf3c","axesd74yuxtbmw1sbk8ufax7z3a"]}],"operation":"and"},"groupById":"aro91wme9kfaie5ceu9qasmtcnw","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["apjnaggwixchfxwiatfh7ey7uno","apiswzj7uiwbh87z8dw8c6mturw","auu9bfzqeuruyjwzzqgz7q8apuw",""],"visiblePropertyIds":[]}	1673965822512	1673965822512	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
75ygzpukfp3d9pd4hg7gmsyns5y	2023-01-17 14:30:22.437069+00	cudjd3axpfpf35dche43a1mbhma	1	checkbox	Send initial email	{"value":true}	1673965822518	1673965822518	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7ajczotzwufg5pmogr6x6wr7fpe	2023-01-17 14:30:22.437069+00	cudjd3axpfpf35dche43a1mbhma	1	checkbox	Send follow-up email	{"value":true}	1673965822525	1673965822525	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7st7hn7uxtbnjjbefcmntesofxc	2023-01-17 14:30:22.437069+00	cudjd3axpfpf35dche43a1mbhma	1	checkbox	Send proposal	{"value":true}	1673965822533	1673965822533	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7qnakgtdgppym5ptehjhoc7nw5y	2023-01-17 14:30:22.437069+00	cudjd3axpfpf35dche43a1mbhma	1	checkbox	Finalize contract	{}	1673965822545	1673965822545	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
74hum7x8dt3y8xj5jjqm58siqoe	2023-01-17 14:30:22.437069+00	cudjd3axpfpf35dche43a1mbhma	1	checkbox	Schedule initial sales call	{"value":true}	1673965822551	1673965822551	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
755ofpmqahbynmqfd5wky9n4kie	2023-01-17 14:30:22.437069+00	cudjd3axpfpf35dche43a1mbhma	1	checkbox	Schedule demo	{"value":true}	1673965822560	1673965822560	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7q9pg9x1cejnezxuh1gq5i6iqgh	2023-01-17 14:30:22.437069+00	cudjd3axpfpf35dche43a1mbhma	1	checkbox	Hand-off to customer success	{}	1673965822567	1673965822567	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
74p999ukr6igq9ghrtys7r7puqo	2023-01-17 14:30:22.437069+00	cudjd3axpfpf35dche43a1mbhma	1	checkbox	Follow up after demo	{"value":true}	1673965822573	1673965822573	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7ektofrqr73b8pn6hb5ri4b41fh	2023-01-17 14:30:22.437069+00	cudjd3axpfpf35dche43a1mbhma	1	checkbox	Schedule follow-up sales call	{"value":true}	1673965822579	1673965822579	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7rt179h6mqpfa9eqktqyig4fcur	2023-01-17 14:30:22.437069+00	cudjd3axpfpf35dche43a1mbhma	1	checkbox	Post-sales follow up	{}	1673965822583	1673965822583	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
agh64gmmhmpfszq9y5fkf3sdoie	2023-01-17 14:30:22.437069+00	cudjd3axpfpf35dche43a1mbhma	1	text	## Checklist	{}	1673965822587	1673965822587	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
afthufxrpufnfpqgs9ukt6mh61h	2023-01-17 14:30:22.437069+00	cudjd3axpfpf35dche43a1mbhma	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1673965822593	1673965822593	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7nmczue3dnty7dn1mp6g9udpffy	2023-01-17 14:30:22.437069+00	c7nxcehxnbtrmde6gsb4zqpjq4r	1	checkbox	Send initial email	{"value":true}	1673965822598	1673965822598	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7zowyocezgbbfxxqefga7c5mqww	2023-01-17 14:30:22.437069+00	c7nxcehxnbtrmde6gsb4zqpjq4r	1	checkbox	Schedule follow-up sales call	{"value":true}	1673965822602	1673965822602	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7gpmwybbxgpdyxc9z1uhkkhnz7w	2023-01-17 14:30:22.437069+00	c7nxcehxnbtrmde6gsb4zqpjq4r	1	checkbox	Follow up after demo	{"value":true}	1673965822607	1673965822607	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
71txyexmzotn89dcxqrq383o38e	2023-01-17 14:30:22.437069+00	c7nxcehxnbtrmde6gsb4zqpjq4r	1	checkbox	Send proposal	{"value":true}	1673965822613	1673965822613	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7buzfau6q5prkmxoorii5abam9w	2023-01-17 14:30:22.437069+00	c7nxcehxnbtrmde6gsb4zqpjq4r	1	checkbox	Schedule demo	{"value":true}	1673965822631	1673965822631	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
71xg1cm3hct8x3dm5pfsb1mtkfw	2023-01-17 14:30:22.437069+00	c7nxcehxnbtrmde6gsb4zqpjq4r	1	checkbox	Schedule initial sales call	{"value":true}	1673965822636	1673965822636	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
73z9ect9o1fr15cx36ju3y16y1a	2023-01-17 14:30:22.437069+00	c7nxcehxnbtrmde6gsb4zqpjq4r	1	checkbox	Send follow-up email	{"value":true}	1673965822640	1673965822640	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
aroqaaui77bbhfe5d31g5yoonxh	2023-01-17 14:30:22.437069+00	c7nxcehxnbtrmde6gsb4zqpjq4r	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1673965822645	1673965822645	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
a771mgefirbgzux3k3dgtc35pho	2023-01-17 14:30:22.437069+00	c7nxcehxnbtrmde6gsb4zqpjq4r	1	text	## Checklist	{}	1673965822649	1673965822649	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
77equnzy4qigcj8xwb66wqhraoh	2023-01-17 14:30:22.437069+00	cosmtosxa73bw5p1t1cohy4ks8a	1	checkbox	Follow up after demo	{"value":true}	1673965822653	1673965822653	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
78fbar4fyg7bc3gigp3pj1m8gkr	2023-01-17 14:30:22.437069+00	cosmtosxa73bw5p1t1cohy4ks8a	1	checkbox	Send initial email	{"value":true}	1673965822657	1673965822657	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7i1kqqtiz87bbumih14rrewqk9h	2023-01-17 14:30:22.437069+00	cosmtosxa73bw5p1t1cohy4ks8a	1	checkbox	Send follow-up email	{"value":true}	1673965822663	1673965822663	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7cdxopq4bpinpina7u3njzjw8da	2023-01-17 14:30:22.437069+00	cosmtosxa73bw5p1t1cohy4ks8a	1	checkbox	Send proposal	{"value":true}	1673965822667	1673965822667	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7o9qnzhanjt8pxf8pe4xmk3gn7r	2023-01-17 14:30:22.437069+00	cosmtosxa73bw5p1t1cohy4ks8a	1	checkbox	Finalize contract	{"value":true}	1673965822671	1673965822671	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7jre9ywhr4jybdp1kmt5oz4rwww	2023-01-17 14:30:22.437069+00	cosmtosxa73bw5p1t1cohy4ks8a	1	checkbox	Schedule follow-up sales call	{"value":true}	1673965822677	1673965822677	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7rbokobjh9bnc5ctprmksycxiec	2023-01-17 14:30:22.437069+00	cosmtosxa73bw5p1t1cohy4ks8a	1	checkbox	Schedule initial sales call	{"value":true}	1673965822681	1673965822681	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
748ofm3bwk3rytfshqau13iazsw	2023-01-17 14:30:22.437069+00	cosmtosxa73bw5p1t1cohy4ks8a	1	checkbox	Schedule demo	{"value":true}	1673965822685	1673965822685	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7amc5xqsac3g1jmft5q9ukprzur	2023-01-17 14:30:22.437069+00	cosmtosxa73bw5p1t1cohy4ks8a	1	checkbox	Hand-off to customer success	{"value":true}	1673965822689	1673965822689	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
791t7xpee5jbn9rxwf5uee5196c	2023-01-17 14:30:22.437069+00	cosmtosxa73bw5p1t1cohy4ks8a	1	checkbox	Post-sales follow up	{"value":true}	1673965822694	1673965822694	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
ajwdcjesu5jy1ugwep9q4g1an1h	2023-01-17 14:30:22.437069+00	cosmtosxa73bw5p1t1cohy4ks8a	1	text	## Checklist	{}	1673965822698	1673965822698	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
ahxaszp31f3yhjjo19eu3544z8o	2023-01-17 14:30:22.437069+00	cosmtosxa73bw5p1t1cohy4ks8a	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1673965822703	1673965822703	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7jmhxnwpux3gyipyj3a3iarpgzr	2023-01-17 14:30:22.437069+00	c8x67gy9xepfxzptgxzt8wgytzr	1	checkbox	Post-sales follow up	{}	1673965822706	1673965822706	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7wbkktsfo73gkzgj8t7bx94y1ce	2023-01-17 14:30:22.437069+00	c8x67gy9xepfxzptgxzt8wgytzr	1	checkbox	Send proposal	{}	1673965822712	1673965822712	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7ddzqqhzbx7yxbcqk7iikeuch5o	2023-01-17 14:30:22.437069+00	c8x67gy9xepfxzptgxzt8wgytzr	1	checkbox	Hand-off to customer success	{}	1673965822716	1673965822716	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7a655j9kehi8fjxrj7k6c6kuooe	2023-01-17 14:30:22.437069+00	c8x67gy9xepfxzptgxzt8wgytzr	1	checkbox	Follow up after demo	{}	1673965822720	1673965822719	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7cj4p6dnqxidqufbpmmci3tqofw	2023-01-17 14:30:22.437069+00	c8x67gy9xepfxzptgxzt8wgytzr	1	checkbox	Schedule demo	{"value":true}	1673965822724	1673965822724	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7mtji9sd7zf8puqfe5subkm9i1r	2023-01-17 14:30:22.437069+00	c8x67gy9xepfxzptgxzt8wgytzr	1	checkbox	Send initial email	{"value":true}	1673965822729	1673965822729	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
75s6bgegkrpgdibowmmcr4dk6sy	2023-01-17 14:30:22.437069+00	c8x67gy9xepfxzptgxzt8wgytzr	1	checkbox	Schedule follow-up sales call	{"value":true}	1673965822734	1673965822734	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7xjcp7osgobbh7xtaeuqdri5zfa	2023-01-17 14:30:22.437069+00	c8x67gy9xepfxzptgxzt8wgytzr	1	checkbox	Send follow-up email	{"value":true}	1673965822738	1673965822738	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
799fwf5a49tba8x615kcfwuprge	2023-01-17 14:30:22.437069+00	c8x67gy9xepfxzptgxzt8wgytzr	1	checkbox	Schedule initial sales call	{"value":true}	1673965822742	1673965822742	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7ca85myg8p3y9fmwsrxzxe6qxer	2023-01-17 14:30:22.437069+00	c8x67gy9xepfxzptgxzt8wgytzr	1	checkbox	Finalize contract	{}	1673965822747	1673965822747	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
affik4pq6mpn8zqjc9prdrhtq3c	2023-01-17 14:30:22.437069+00	c8x67gy9xepfxzptgxzt8wgytzr	1	text	## Checklist	{}	1673965822751	1673965822751	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
ah64hewt1iffsfb3b9gjggcde9h	2023-01-17 14:30:22.437069+00	c8x67gy9xepfxzptgxzt8wgytzr	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1673965822756	1673965822756	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7oq53yacgn78e9mgw7rtyh8bhzy	2023-01-17 14:30:22.437069+00	c1zr4ry1y9fdsmpdxyu4i5n8ieo	1	checkbox	Send initial email	{"value":false}	1673965822762	1673965822762	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7y6nw38oywtbg9xypjquugqkhyy	2023-01-17 14:30:22.437069+00	c1zr4ry1y9fdsmpdxyu4i5n8ieo	1	checkbox	Schedule initial sales call	{"value":false}	1673965822766	1673965822766	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7o4sc444ekir73ysppiq9uhwm4o	2023-01-17 14:30:22.437069+00	c1zr4ry1y9fdsmpdxyu4i5n8ieo	1	checkbox	Schedule follow-up sales call	{"value":false}	1673965822771	1673965822771	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
76g3pktsh4bf97ycyx1p44reytc	2023-01-17 14:30:22.437069+00	c1zr4ry1y9fdsmpdxyu4i5n8ieo	1	checkbox	Send proposal	{}	1673965822776	1673965822776	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7f4oxkpqy7brgjnei6zmnft7qno	2023-01-17 14:30:22.437069+00	c1zr4ry1y9fdsmpdxyu4i5n8ieo	1	checkbox	Finalize contract	{}	1673965822781	1673965822781	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
79rae1r6dwidwxftw7s43cd77kh	2023-01-17 14:30:22.437069+00	c1zr4ry1y9fdsmpdxyu4i5n8ieo	1	checkbox	Post-sales follow up	{}	1673965822786	1673965822786	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7n5erteor5bdgmbdgbgpeptb38w	2023-01-17 14:30:22.437069+00	c1zr4ry1y9fdsmpdxyu4i5n8ieo	1	checkbox	Send follow-up email	{"value":false}	1673965822792	1673965822792	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7hruqoce41pd37k6jx3x8tthr1r	2023-01-17 14:30:22.437069+00	c1zr4ry1y9fdsmpdxyu4i5n8ieo	1	checkbox	Schedule demo	{"value":false}	1673965822797	1673965822797	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
73io7mjdtgj8ifnr96dm7cz7eia	2023-01-17 14:30:22.437069+00	c1zr4ry1y9fdsmpdxyu4i5n8ieo	1	checkbox	Hand-off to customer success	{}	1673965822801	1673965822801	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7ndxi8gb593n6zyc7bdnehbfwoo	2023-01-17 14:30:22.437069+00	c1zr4ry1y9fdsmpdxyu4i5n8ieo	1	checkbox	Follow up after demo	{}	1673965822805	1673965822805	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
adi6x775bujrgmyqscpt3c93xxe	2023-01-17 14:30:22.437069+00	c1zr4ry1y9fdsmpdxyu4i5n8ieo	1	text	## Notes\n[Enter notes here...]	{}	1673965822811	1673965822811	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
ax1x8sw6gnpbb5m3e83md6x1b1c	2023-01-17 14:30:22.437069+00	c1zr4ry1y9fdsmpdxyu4i5n8ieo	1	text	## Checklist	{}	1673965822816	1673965822816	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7bbrqqf8gfjd8tbjqq71tbkbupr	2023-01-17 14:30:22.437069+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Hand-off to customer success	{}	1673965822822	1673965822822	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7a9rfmkwuntrg3farpab3b15k9e	2023-01-17 14:30:22.437069+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Send initial email	{"value":false}	1673965822828	1673965822828	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7ix6z7pp9apng9qx7xfuy5juqmo	2023-01-17 14:30:22.437069+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Post-sales follow up	{}	1673965822833	1673965822833	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
783rahmrez7rx8fcg7kewtebbsa	2023-01-17 14:30:22.437069+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Finalize contract	{}	1673965822838	1673965822838	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7qgq3kdjxufdz8p93z6maxeaxbc	2023-01-17 14:30:22.437069+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Send follow-up email	{"value":false}	1673965822843	1673965822843	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
77rjdzudeu3yjxkht9zt4fdfdxy	2023-01-17 14:30:22.437069+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Schedule follow-up sales call	{"value":false}	1673965822848	1673965822848	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7fntad4asejna8bgcqqasmcfzbh	2023-01-17 14:30:22.437069+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Send proposal	{}	1673965822853	1673965822853	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7sfr1qh7ntjb9xkn1tn78j9z9ie	2023-01-17 14:30:22.437069+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Follow up after demo	{}	1673965822857	1673965822857	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7zbhjormicjb6mxupospnbp1e1o	2023-01-17 14:30:22.437069+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Schedule initial sales call	{"value":false}	1673965822862	1673965822862	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7dx19cd31y7rwij6f46xj1qiwxh	2023-01-17 14:30:22.437069+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Schedule demo	{"value":false}	1673965822867	1673965822867	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
a36pnn1guxifqbqpco8c8b7e78c	2023-01-17 14:30:22.437069+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	text	## Checklist	{}	1673965822872	1673965822872	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
aybi6yak1qpddfqcnamahjrcb3o	2023-01-17 14:30:22.437069+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	text	## Notes\n[Enter notes here...]	{}	1673965822878	1673965822878	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7jkepmbfsnj8m5xtddh4tyfot7o	2023-01-17 14:30:22.437069+00	crn69z85umjbxtqbk7nj6rne4ic	1	checkbox	Send proposal	{}	1673965822882	1673965822882	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7866hyr5143rk9q3q5zrtkn17er	2023-01-17 14:30:22.437069+00	crn69z85umjbxtqbk7nj6rne4ic	1	checkbox	Send initial email	{"value":true}	1673965822887	1673965822887	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7f8tsoayeeig63nwym8u6o458bw	2023-01-17 14:30:22.437069+00	crn69z85umjbxtqbk7nj6rne4ic	1	checkbox	Follow up after demo	{}	1673965822891	1673965822891	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7zhgzabkydiyszk1tfz5ggbszby	2023-01-17 14:30:22.437069+00	crn69z85umjbxtqbk7nj6rne4ic	1	checkbox	Finalize contract	{}	1673965822896	1673965822896	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7wqbg84e4ab8rzdqoqun3yhwp8a	2023-01-17 14:30:22.437069+00	crn69z85umjbxtqbk7nj6rne4ic	1	checkbox	Schedule follow-up sales call	{"value":false}	1673965822901	1673965822901	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7jreh9zg4kfgq9gd6kza7ty6jqr	2023-01-17 14:30:22.437069+00	crn69z85umjbxtqbk7nj6rne4ic	1	checkbox	Schedule demo	{"value":false}	1673965822905	1673965822905	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
73j6remhzifrhbm4irkc9nc1c3e	2023-01-17 14:30:22.437069+00	crn69z85umjbxtqbk7nj6rne4ic	1	checkbox	Schedule initial sales call	{"value":false}	1673965822911	1673965822911	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7pxag7ngrabyk3kf4rzhc89k1bh	2023-01-17 14:30:22.437069+00	crn69z85umjbxtqbk7nj6rne4ic	1	checkbox	Post-sales follow up	{}	1673965822916	1673965822916	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7zqi73bttx3fuiqjydosrjnu3hr	2023-01-17 14:30:22.437069+00	crn69z85umjbxtqbk7nj6rne4ic	1	checkbox	Hand-off to customer success	{}	1673965822920	1673965822920	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
743pmufq1tfdutbmurn5bx7rzor	2023-01-17 14:30:22.437069+00	crn69z85umjbxtqbk7nj6rne4ic	1	checkbox	Send follow-up email	{"value":false}	1673965822926	1673965822926	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
a4jxu74p6z3gpfeixwpc4pwd47w	2023-01-17 14:30:22.437069+00	crn69z85umjbxtqbk7nj6rne4ic	1	text	## Checklist	{}	1673965822930	1673965822930	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
71rmsjsx17pyzzeg174moasyhsc	2023-01-17 14:30:23.920434+00	cktgow4j5wp8cjbu6aj18771o4c	1	checkbox	[Subtask 2]	{"value":false}	1673965824007	1673965824007	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
aiepiz4odbbdt3d3e55dcpqjsdc	2023-01-17 14:30:22.437069+00	crn69z85umjbxtqbk7nj6rne4ic	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1673965822935	1673965822934	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
c7roekwxfe3nn5kef46qu4rb69r	2023-01-17 14:30:24.752127+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Start a daily journal	{"contentOrder":[],"icon":"✍️","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","d6b1249b-bc18-45fc-889e-bec48fce80ef":"0a82977f-52bf-457b-841b-e2b7f76fb525","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"3245a32d-f688-463b-87f4-8e7142c1b397"}}	1673965824763	1673965824763	0	\N	system		system	bng8baqwambb6bxwewinmuuno3y
ctrchiyzsz7nqufiqyki6efe4be	2023-01-17 14:30:24.752127+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Run 3 times a week	{"contentOrder":[],"icon":"🏃","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","d6b1249b-bc18-45fc-889e-bec48fce80ef":"6e7139e4-5358-46bb-8c01-7b029a57b80a","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"ffb3f951-b47f-413b-8f1d-238666728008"}}	1673965824768	1673965824768	0	\N	system		system	bng8baqwambb6bxwewinmuuno3y
ctsbwncpdqbg7tekctcfnp7fojc	2023-01-17 14:30:24.752127+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Learn to paint	{"contentOrder":[],"icon":"🎨","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"77c539af-309c-4db1-8329-d20ef7e9eacd","d6b1249b-bc18-45fc-889e-bec48fce80ef":"9a090e33-b110-4268-8909-132c5002c90e","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"3245a32d-f688-463b-87f4-8e7142c1b397"}}	1673965824774	1673965824774	0	\N	system		system	bng8baqwambb6bxwewinmuuno3y
csrtouonhyfdmdgw8agnrqu7sph	2023-01-17 14:30:24.752127+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Open retirement account	{"contentOrder":[],"icon":"🏦","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","d6b1249b-bc18-45fc-889e-bec48fce80ef":"0a82977f-52bf-457b-841b-e2b7f76fb525","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"80be816c-fc7a-4928-8489-8b02180f4954"}}	1673965824779	1673965824779	0	\N	system		system	bng8baqwambb6bxwewinmuuno3y
vpadzzoyxntysipg37tqy35wo1o	2023-01-17 14:30:24.752127+00	bd65qbzuqupfztpg31dgwgwm5ga	1	view	By Status	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"af6fcbb8-ca56-4b73-83eb-37437b9a667d","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","77c539af-309c-4db1-8329-d20ef7e9eacd","98bdea27-0cce-4cde-8dc6-212add36e63a",""],"visiblePropertyIds":["d9725d14-d5a8-48e5-8de1-6f8c004a9680","d6b1249b-bc18-45fc-889e-bec48fce80ef"]}	1673965824784	1673965824784	0	\N	system		system	bng8baqwambb6bxwewinmuuno3y
vru8wd5pdnigt5x88gpcekmnjbo	2023-01-17 14:30:24.752127+00	bd65qbzuqupfztpg31dgwgwm5ga	1	view	Calendar View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"ajy6xbebzopojaenbnmfpgtdwso","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1673965824788	1673965824788	0	\N	system		system	bng8baqwambb6bxwewinmuuno3y
vhec1a7c4mbfwbndr4kxo55sryy	2023-01-17 14:30:24.752127+00	bd65qbzuqupfztpg31dgwgwm5ga	1	view	By Date	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"d6b1249b-bc18-45fc-889e-bec48fce80ef","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["9a090e33-b110-4268-8909-132c5002c90e","0a82977f-52bf-457b-841b-e2b7f76fb525","6e7139e4-5358-46bb-8c01-7b029a57b80a","d5371c63-66bf-4468-8738-c4dc4bea4843",""],"visiblePropertyIds":["d9725d14-d5a8-48e5-8de1-6f8c004a9680"]}	1673965824792	1673965824792	0	\N	system		system	bng8baqwambb6bxwewinmuuno3y
vwq1epbd55frwiyjra3wkwpsc7a	2023-01-17 14:30:25.286676+00		1	view	All Users	{"cardOrder":["ctepgdjm48jbozybjcugxcah8oh"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":280,"aaebj5fyx493eezx6ukxiwydgty":146,"acjq4t5ymytu8x1f68wkggm7ypc":222,"akrxgi7p7w14fym3gbynb98t9fh":131,"atg9qu6oe4bjm8jczzsn71ff5me":131},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"akrxgi7p7w14fym3gbynb98t9fh","reversed":false}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["aaebj5fyx493eezx6ukxiwydgty","akrxgi7p7w14fym3gbynb98t9fh","atg9qu6oe4bjm8jczzsn71ff5me","acjq4t5ymytu8x1f68wkggm7ypc","aphio1s5gkmpdbwoxynim7acw3e","aqafzdeekpyncwz7m7i54q3iqqy","aify3r761b9w43bqjtskrzi68tr"]}	1673965825295	1673965825295	0	\N	system		system	bky8mjzqy9incxk3gjqwiatz6xa
ctepgdjm48jbozybjcugxcah8oh	2023-01-17 14:30:25.286676+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Frank Nash	{"contentOrder":["a9ts9agiduibzfkc3e3gjgjcsto"],"icon":"👨‍💼","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"ap93ysuzy1xa7z818r6myrn4h4y","acjq4t5ymytu8x1f68wkggm7ypc":"frank.nash@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1669896000000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"aehc83ffays3gh8myz16a8j7k4e"}}	1673965825301	1673965825301	0	\N	system		system	bky8mjzqy9incxk3gjqwiatz6xa
c9w8xao7k4fdq7findb74g5uyme	2023-01-17 14:30:25.286676+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Richard Parsons	{"contentOrder":["ah4uo9iiftjyt5dc4wzkyk348ch"],"icon":"👨‍🦱","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"a7yq89whddzob1futao4rxk3yzc","acjq4t5ymytu8x1f68wkggm7ypc":"richard.parsons@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1671019200000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"a1sxagjgaadym5yrjak6tcup1oa"}}	1673965825307	1673965825307	0	\N	system		system	bky8mjzqy9incxk3gjqwiatz6xa
csoqauki377rqme49sujukpf9ie	2023-01-17 14:30:25.286676+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Claire Hart	{"contentOrder":["ajhftsh9id3ncbcpguzmhm3r7ua"],"icon":"👩‍🦰","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"aseqq9hrsua56r3s6nbuirj9eec","acjq4t5ymytu8x1f68wkggm7ypc":"claire.hart@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1670500800000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"ahn89mqg9u4igk6pdm7333t8i5h"}}	1673965825312	1673965825312	0	\N	system		system	bky8mjzqy9incxk3gjqwiatz6xa
7tnc5ee6rqpbi8fphxxfu666b8c	2023-01-17 14:30:23.920434+00	cktgow4j5wp8cjbu6aj18771o4c	1	checkbox	...	{"value":false}	1673965824012	1673965824012	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
cbm5pbrm1d3fr5k3ou8k5z4my1o	2023-01-17 14:30:23.561233+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Pay bills	{"contentOrder":["7f8cmp4xqpjrhfnweqnbqarwd4w","79w7q5nkok7na5y5s1i5r6xdcmc","7bomioiw75j8k9nkaax7rwwupuo"],"icon":"🔌","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"aj4jyekqqssatjcq7r7chmy19ey","abthng7baedhhtrwsdodeuincqy":"true"}}	1673965823572	1673965823572	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
cr47faqnicbrifjtdd8u8x36nuh	2023-01-17 14:30:23.561233+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Buy groceries	{"contentOrder":["anmp3foy1yjbx98zzzbb9wfzgne","7d586azk3g7y85pjnsq74xq8g5w","7odxqyr86nignpgaqxeqr5ntnnw","79mi64hdwotr1uxrn73g4m515zy","7yyrxa34f5ige8f86qx89kommac","7ttzjfzjzfjd13koiyab88mafsc","7umdqpez3jpdtifmqcrk9pgc7dw"],"icon":"🛒","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"afpy8s7i45frggprmfsqngsocqh"}}	1673965823579	1673965823579	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
cjssbauz3xtdf3kqx5sbotc6e8w	2023-01-17 14:30:23.561233+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Go for a walk	{"contentOrder":["ar4643trxrjbafjri1dfysdsoor","a3jzh1uqxmj8kt8i6e51s5pndue","7r7o84kktbj8wzk7gmkqhpzfz5c"],"icon":"👣","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"an51dnkenmoog9cetapbc4uyt3y"}}	1673965823583	1673965823583	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
cgff4xt1wgir1pd5oh6m6kx8u1e	2023-01-17 14:30:23.561233+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Feed Fluffy	{"contentOrder":["am8mg58s99bnyzcaru4u3op469y"],"icon":"🐱","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"an51dnkenmoog9cetapbc4uyt3y"}}	1673965823587	1673965823587	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
c9tmyye5qq3ybbxsucsn74h1qry	2023-01-17 14:30:23.561233+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Gardening	{"contentOrder":[],"icon":"🌳","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"afpy8s7i45frggprmfsqngsocqh"}}	1673965823591	1673965823591	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
vy3am5c91i7nhfeimyw1hd4k4je	2023-01-17 14:30:23.561233+00	bbn1888mprfrm5fjw9f1je9x3xo	1	view	List View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":280},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a9zf59u8x1rf4ywctpcqama7tio","abthng7baedhhtrwsdodeuincqy"]}	1673965823596	1673965823596	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
vn7zsddinitbz5p5cw7iu7fkg9c	2023-01-17 14:30:23.561233+00	bbn1888mprfrm5fjw9f1je9x3xo	1	view	Board View	{"cardOrder":["cr47faqnicbrifjtdd8u8x36nuh","cbm5pbrm1d3fr5k3ou8k5z4my1o","cjssbauz3xtdf3kqx5sbotc6e8w","cgff4xt1wgir1pd5oh6m6kx8u1e","czowhma7rnpgb3eczbqo3t7fijo"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a9zf59u8x1rf4ywctpcqama7tio","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["an51dnkenmoog9cetapbc4uyt3y","afpy8s7i45frggprmfsqngsocqh","aj4jyekqqssatjcq7r7chmy19ey",""],"visiblePropertyIds":["a9zf59u8x1rf4ywctpcqama7tio"]}	1673965823601	1673965823601	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
7bomioiw75j8k9nkaax7rwwupuo	2023-01-17 14:30:23.561233+00	cbm5pbrm1d3fr5k3ou8k5z4my1o	1	checkbox	Utilities	{"value":true}	1673965823605	1673965823605	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
7f8cmp4xqpjrhfnweqnbqarwd4w	2023-01-17 14:30:23.561233+00	cbm5pbrm1d3fr5k3ou8k5z4my1o	1	checkbox	Mobile phone	{"value":true}	1673965823611	1673965823611	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
79w7q5nkok7na5y5s1i5r6xdcmc	2023-01-17 14:30:23.561233+00	cbm5pbrm1d3fr5k3ou8k5z4my1o	1	checkbox	Internet	{"value":true}	1673965823616	1673965823616	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
7ttzjfzjzfjd13koiyab88mafsc	2023-01-17 14:30:23.561233+00	cr47faqnicbrifjtdd8u8x36nuh	1	checkbox	Cereal	{"value":false}	1673965823623	1673965823623	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
7yyrxa34f5ige8f86qx89kommac	2023-01-17 14:30:23.561233+00	cr47faqnicbrifjtdd8u8x36nuh	1	checkbox	Butter	{"value":false}	1673965823630	1673965823630	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
79mi64hdwotr1uxrn73g4m515zy	2023-01-17 14:30:23.561233+00	cr47faqnicbrifjtdd8u8x36nuh	1	checkbox	Bread	{"value":false}	1673965823634	1673965823634	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
7d586azk3g7y85pjnsq74xq8g5w	2023-01-17 14:30:23.561233+00	cr47faqnicbrifjtdd8u8x36nuh	1	checkbox	Milk	{"value":false}	1673965823639	1673965823639	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
7umdqpez3jpdtifmqcrk9pgc7dw	2023-01-17 14:30:23.561233+00	cr47faqnicbrifjtdd8u8x36nuh	1	checkbox	Bananas	{"value":false}	1673965823645	1673965823644	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
7odxqyr86nignpgaqxeqr5ntnnw	2023-01-17 14:30:23.561233+00	cr47faqnicbrifjtdd8u8x36nuh	1	checkbox	Eggs	{"value":false}	1673965823650	1673965823650	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
anmp3foy1yjbx98zzzbb9wfzgne	2023-01-17 14:30:23.561233+00	cr47faqnicbrifjtdd8u8x36nuh	1	text	## Grocery list	{}	1673965823655	1673965823655	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
7r7o84kktbj8wzk7gmkqhpzfz5c	2023-01-17 14:30:23.561233+00	cjssbauz3xtdf3kqx5sbotc6e8w	1	image		{"fileId":"76fwrj36hptg6dywka4k5mt3sph.png"}	1673965823660	1673965823659	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
ar4643trxrjbafjri1dfysdsoor	2023-01-17 14:30:23.561233+00	cjssbauz3xtdf3kqx5sbotc6e8w	1	text	## Goal\nWalk at least 10,000 steps every day.	{}	1673965823665	1673965823665	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
a3jzh1uqxmj8kt8i6e51s5pndue	2023-01-17 14:30:23.561233+00	cjssbauz3xtdf3kqx5sbotc6e8w	1	text	## Route	{}	1673965823669	1673965823669	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
am8mg58s99bnyzcaru4u3op469y	2023-01-17 14:30:23.561233+00	cgff4xt1wgir1pd5oh6m6kx8u1e	1	text		{}	1673965823673	1673965823673	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
cmiywe3nj4tfczdhrojmewgxihh	2023-01-17 14:30:23.920434+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Identify dependencies	{"contentOrder":["ar93zjfxfopdxpex8of6hidn3nc","79chor8bedfnnzqsiwhmwoymi6w","a649zg5dqe7gbmk671ykt65hnir","7cxtn8sif9bg5xko4cmnwojeh1e","7ueqh9pt5ub8kzb386ykpdqh3br","7schprr1s5pdwtbhhiyjcze3xko","7qu5rk53gfjngxkd855ne7gnf9o"],"icon":"🔗","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"16","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ayz81h9f3dwp7rzzbdebesc7ute","d3d682bf-e074-49d9-8df5-7320921c2d23":"98a57627-0f76-471d-850d-91f3ed9fd213"}}	1673965823929	1673965823929	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
cktgow4j5wp8cjbu6aj18771o4c	2023-01-17 14:30:23.920434+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Define project scope	{"contentOrder":["a9ycjkpeqtjys7p5zj33znxue3w","7szysyefd93r9fejte6sqzbnjpc","aeggqdokndfr3przezf91qq9xye","751cabe6umbfc7fgj6d8q8z65dc","71rmsjsx17pyzzeg174moasyhsc","7zrh5knzneprw5c3q9ssejsuw1w","7tnc5ee6rqpbi8fphxxfu666b8c"],"icon":"🔬","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"32","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ar6b8m3jxr3asyxhr8iucdbo6yc","d3d682bf-e074-49d9-8df5-7320921c2d23":"87f59784-b859-4c24-8ebe-17c766e081dd"}}	1673965823935	1673965823935	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
cuyuessh9xpn45r75dg1g3eqn4y	2023-01-17 14:30:23.920434+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Requirements sign-off	{"contentOrder":["aikm9gsdfuig85qufciawmmmgjw","7mgqirp1hd7btmxm3jxjwa6wgno","a5sr1wzmmffdexcympbziuau7mc","7jn1xm5f1sinxbngw6s639jemzc","78fthbrzjs3dgfq8j5a5c7msd8r","77e8jot98ciyxdqcaggk7nhxxgh","7xpfbfmyyw3dgbemn7tkrt3jymo"],"icon":"🖋️","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"8","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ayz81h9f3dwp7rzzbdebesc7ute","d3d682bf-e074-49d9-8df5-7320921c2d23":"d3bfb50f-f569-4bad-8a3a-dd15c3f60101"}}	1673965823941	1673965823941	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
cyxbgjxzrpjbxpjm4rybxcrmg7h	2023-01-17 14:30:23.920434+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Project budget approval	{"contentOrder":["apga5pk5j6fn13x3yzkfow34c5e","75bn89cayztr3bd4gngco76txgh","a58sips6dw3y73p4uzyqoqkp3py","7jdtmj4s7xpy6jy48fsqi6rwrge","7s1jdspe3g3fi5ptbie4a1t6m1h","7hb7yzzrwxbbjzeaaxb5ero83jy","7si53m633ufn59f1j1n9yanw4yy"],"icon":"💵","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"16","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ayz81h9f3dwp7rzzbdebesc7ute","d3d682bf-e074-49d9-8df5-7320921c2d23":"d3bfb50f-f569-4bad-8a3a-dd15c3f60101"}}	1673965823947	1673965823947	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
cnfp9rawkgjbc8f4jeoy1ag31sy	2023-01-17 14:30:23.920434+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Conduct market analysis	{"contentOrder":["akttwuoan3ibu3e3iwqdcje4cgo","7t3mb8zqey3dnzpqbyydkq19csy","acgmc8y5in3fsxdncr8ogfmsiyc","7xsxzqz4pr7bcij8tzogy9zfs5h","7fp59dywwq3bs5qsbnie7e41pfw","7mcubfmpqsp8rjg5owpukt37gba","71tudiw7mmtf4f8wfrxaydctxgo"],"icon":"📈","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"40","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ar6b8m3jxr3asyxhr8iucdbo6yc","d3d682bf-e074-49d9-8df5-7320921c2d23":"87f59784-b859-4c24-8ebe-17c766e081dd"}}	1673965823952	1673965823952	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
vb1scrbdyqp8auf46yorjtxs6sc	2023-01-17 14:30:23.920434+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Project Priorities	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"d3d682bf-e074-49d9-8df5-7320921c2d23","hiddenOptionIds":[],"kanbanCalculations":{"":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"87f59784-b859-4c24-8ebe-17c766e081dd":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"98a57627-0f76-471d-850d-91f3ed9fd213":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"d3bfb50f-f569-4bad-8a3a-dd15c3f60101":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"}},"sortOptions":[],"viewType":"board","visibleOptionIds":["d3bfb50f-f569-4bad-8a3a-dd15c3f60101","87f59784-b859-4c24-8ebe-17c766e081dd","98a57627-0f76-471d-850d-91f3ed9fd213",""],"visiblePropertyIds":["a972dc7a-5f4c-45d2-8044-8c28c69717f1","a8daz81s4xjgke1ww6cwik5w7ye"]}	1673965823957	1673965823957	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
v3nc6fgyxgigt7rpcdykjpnkkdy	2023-01-17 14:30:23.920434+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Progress Tracker	{"cardOrder":["cyxbgjxzrpjbxpjm4rybxcrmg7h","cuyuessh9xpn45r75dg1g3eqn4y","cmiywe3nj4tfczdhrojmewgxihh","cnfp9rawkgjbc8f4jeoy1ag31sy","cktgow4j5wp8cjbu6aj18771o4c","coxnjt3ro1in19dd1e3awdt338r"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a972dc7a-5f4c-45d2-8044-8c28c69717f1","hiddenOptionIds":[],"kanbanCalculations":{"":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"adeo5xuwne3qjue83fcozekz8ko":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"afi4o5nhnqc3smtzs1hs3ij34dh":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"ahpyxfnnrzynsw3im1psxpkgtpe":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"ar6b8m3jxr3asyxhr8iucdbo6yc":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"ayz81h9f3dwp7rzzbdebesc7ute":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"}},"sortOptions":[],"viewType":"board","visibleOptionIds":["ayz81h9f3dwp7rzzbdebesc7ute","ar6b8m3jxr3asyxhr8iucdbo6yc","afi4o5nhnqc3smtzs1hs3ij34dh","adeo5xuwne3qjue83fcozekz8ko","ahpyxfnnrzynsw3im1psxpkgtpe",""],"visiblePropertyIds":["d3d682bf-e074-49d9-8df5-7320921c2d23","a8daz81s4xjgke1ww6cwik5w7ye"]}	1673965823962	1673965823962	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
vprusnt9ft3yj9f9u5zy8daroow	2023-01-17 14:30:23.920434+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Task Overview	{"cardOrder":["cktgow4j5wp8cjbu6aj18771o4c","cnfp9rawkgjbc8f4jeoy1ag31sy","cmiywe3nj4tfczdhrojmewgxihh","cyxbgjxzrpjbxpjm4rybxcrmg7h","cuyuessh9xpn45r75dg1g3eqn4y","cz8p8gofakfby8kzz83j97db8ph","ce1jm5q5i54enhuu4h3kkay1hcc"],"collapsedOptionIds":[],"columnCalculations":{"a8daz81s4xjgke1ww6cwik5w7ye":"sum"},"columnWidths":{"2a5da320-735c-4093-8787-f56e15cdfeed":196,"__title":280,"a8daz81s4xjgke1ww6cwik5w7ye":139,"a972dc7a-5f4c-45d2-8044-8c28c69717f1":141,"d3d682bf-e074-49d9-8df5-7320921c2d23":110},"defaultTemplateId":"czw9es1e89fdpjr7cqptr1xq7qh","filter":{"filters":[],"operation":"and"},"groupById":"","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a972dc7a-5f4c-45d2-8044-8c28c69717f1","d3d682bf-e074-49d9-8df5-7320921c2d23","2a5da320-735c-4093-8787-f56e15cdfeed","a3zsw7xs8sxy7atj8b6totp3mby","axkhqa4jxr3jcqe4k87g8bhmary","a7gdnz8ff8iyuqmzddjgmgo9ery","a8daz81s4xjgke1ww6cwik5w7ye"]}	1673965823966	1673965823966	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
vmcxeyrq8jjrgtjya3f1ph5h83r	2023-01-17 14:30:23.920434+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Task Calendar	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"a3zsw7xs8sxy7atj8b6totp3mby","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1673965823970	1673965823970	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7cxtn8sif9bg5xko4cmnwojeh1e	2023-01-17 14:30:23.920434+00	cmiywe3nj4tfczdhrojmewgxihh	1	checkbox	[Subtask 1]	{"value":false}	1673965823974	1673965823974	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7ueqh9pt5ub8kzb386ykpdqh3br	2023-01-17 14:30:23.920434+00	cmiywe3nj4tfczdhrojmewgxihh	1	checkbox	[Subtask 2]	{"value":false}	1673965823980	1673965823980	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
79chor8bedfnnzqsiwhmwoymi6w	2023-01-17 14:30:23.920434+00	cmiywe3nj4tfczdhrojmewgxihh	1	divider		{}	1673965823984	1673965823984	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7qu5rk53gfjngxkd855ne7gnf9o	2023-01-17 14:30:23.920434+00	cmiywe3nj4tfczdhrojmewgxihh	1	checkbox	...	{"value":false}	1673965823987	1673965823987	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7schprr1s5pdwtbhhiyjcze3xko	2023-01-17 14:30:23.920434+00	cmiywe3nj4tfczdhrojmewgxihh	1	checkbox	[Subtask 3]	{"value":false}	1673965823991	1673965823991	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
a649zg5dqe7gbmk671ykt65hnir	2023-01-17 14:30:23.920434+00	cmiywe3nj4tfczdhrojmewgxihh	1	text	## Checklist	{}	1673965823997	1673965823997	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
ar93zjfxfopdxpex8of6hidn3nc	2023-01-17 14:30:23.920434+00	cmiywe3nj4tfczdhrojmewgxihh	1	text	## Description\n*[Brief description of this task]*	{}	1673965824002	1673965824002	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
751cabe6umbfc7fgj6d8q8z65dc	2023-01-17 14:30:23.920434+00	cktgow4j5wp8cjbu6aj18771o4c	1	checkbox	[Subtask 1]	{"value":false}	1673965824017	1673965824017	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7zrh5knzneprw5c3q9ssejsuw1w	2023-01-17 14:30:23.920434+00	cktgow4j5wp8cjbu6aj18771o4c	1	checkbox	[Subtask 3]	{"value":false}	1673965824021	1673965824021	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7szysyefd93r9fejte6sqzbnjpc	2023-01-17 14:30:23.920434+00	cktgow4j5wp8cjbu6aj18771o4c	1	divider		{}	1673965824026	1673965824026	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
aeggqdokndfr3przezf91qq9xye	2023-01-17 14:30:23.920434+00	cktgow4j5wp8cjbu6aj18771o4c	1	text	## Checklist	{}	1673965824033	1673965824033	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
a9ycjkpeqtjys7p5zj33znxue3w	2023-01-17 14:30:23.920434+00	cktgow4j5wp8cjbu6aj18771o4c	1	text	## Description\n*[Brief description of this task]*	{}	1673965824038	1673965824038	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7xpfbfmyyw3dgbemn7tkrt3jymo	2023-01-17 14:30:23.920434+00	cuyuessh9xpn45r75dg1g3eqn4y	1	checkbox	...	{"value":false}	1673965824048	1673965824048	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
78fthbrzjs3dgfq8j5a5c7msd8r	2023-01-17 14:30:23.920434+00	cuyuessh9xpn45r75dg1g3eqn4y	1	checkbox	[Subtask 2]	{"value":false}	1673965824054	1673965824054	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7mgqirp1hd7btmxm3jxjwa6wgno	2023-01-17 14:30:23.920434+00	cuyuessh9xpn45r75dg1g3eqn4y	1	divider		{}	1673965824059	1673965824059	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
77e8jot98ciyxdqcaggk7nhxxgh	2023-01-17 14:30:23.920434+00	cuyuessh9xpn45r75dg1g3eqn4y	1	checkbox	[Subtask 3]	{"value":false}	1673965824064	1673965824064	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7jn1xm5f1sinxbngw6s639jemzc	2023-01-17 14:30:23.920434+00	cuyuessh9xpn45r75dg1g3eqn4y	1	checkbox	[Subtask 1]	{"value":false}	1673965824068	1673965824068	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
aikm9gsdfuig85qufciawmmmgjw	2023-01-17 14:30:23.920434+00	cuyuessh9xpn45r75dg1g3eqn4y	1	text	## Description\n*[Brief description of this task]*	{}	1673965824073	1673965824073	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
a5sr1wzmmffdexcympbziuau7mc	2023-01-17 14:30:23.920434+00	cuyuessh9xpn45r75dg1g3eqn4y	1	text	## Checklist	{}	1673965824078	1673965824078	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
75bn89cayztr3bd4gngco76txgh	2023-01-17 14:30:23.920434+00	cyxbgjxzrpjbxpjm4rybxcrmg7h	1	divider		{}	1673965824084	1673965824084	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7jdtmj4s7xpy6jy48fsqi6rwrge	2023-01-17 14:30:23.920434+00	cyxbgjxzrpjbxpjm4rybxcrmg7h	1	checkbox	[Subtask 1]	{"value":false}	1673965824090	1673965824090	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7hb7yzzrwxbbjzeaaxb5ero83jy	2023-01-17 14:30:23.920434+00	cyxbgjxzrpjbxpjm4rybxcrmg7h	1	checkbox	[Subtask 3]	{"value":false}	1673965824096	1673965824096	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7si53m633ufn59f1j1n9yanw4yy	2023-01-17 14:30:23.920434+00	cyxbgjxzrpjbxpjm4rybxcrmg7h	1	checkbox	...	{"value":false}	1673965824107	1673965824107	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7s1jdspe3g3fi5ptbie4a1t6m1h	2023-01-17 14:30:23.920434+00	cyxbgjxzrpjbxpjm4rybxcrmg7h	1	checkbox	[Subtask 2]	{"value":false}	1673965824122	1673965824122	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
a58sips6dw3y73p4uzyqoqkp3py	2023-01-17 14:30:23.920434+00	cyxbgjxzrpjbxpjm4rybxcrmg7h	1	text	## Checklist	{}	1673965824129	1673965824129	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
apga5pk5j6fn13x3yzkfow34c5e	2023-01-17 14:30:23.920434+00	cyxbgjxzrpjbxpjm4rybxcrmg7h	1	text	## Description\n*[Brief description of this task]*	{}	1673965824134	1673965824134	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
71tudiw7mmtf4f8wfrxaydctxgo	2023-01-17 14:30:23.920434+00	cnfp9rawkgjbc8f4jeoy1ag31sy	1	checkbox	...	{"value":false}	1673965824140	1673965824140	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7mcubfmpqsp8rjg5owpukt37gba	2023-01-17 14:30:23.920434+00	cnfp9rawkgjbc8f4jeoy1ag31sy	1	checkbox	[Subtask 3]	{"value":false}	1673965824148	1673965824148	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7t3mb8zqey3dnzpqbyydkq19csy	2023-01-17 14:30:23.920434+00	cnfp9rawkgjbc8f4jeoy1ag31sy	1	divider		{}	1673965824158	1673965824158	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7fp59dywwq3bs5qsbnie7e41pfw	2023-01-17 14:30:23.920434+00	cnfp9rawkgjbc8f4jeoy1ag31sy	1	checkbox	[Subtask 2]	{"value":false}	1673965824163	1673965824163	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7xsxzqz4pr7bcij8tzogy9zfs5h	2023-01-17 14:30:23.920434+00	cnfp9rawkgjbc8f4jeoy1ag31sy	1	checkbox	[Subtask 1]	{"value":false}	1673965824168	1673965824168	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
akttwuoan3ibu3e3iwqdcje4cgo	2023-01-17 14:30:23.920434+00	cnfp9rawkgjbc8f4jeoy1ag31sy	1	text	## Description\n*[Brief description of this task]*	{}	1673965824173	1673965824173	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
acgmc8y5in3fsxdncr8ogfmsiyc	2023-01-17 14:30:23.920434+00	cnfp9rawkgjbc8f4jeoy1ag31sy	1	text	## Checklist	{}	1673965824181	1673965824181	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7sj34o9b6ai8pzrmr5nfk1yanio	2023-01-17 14:30:23.920434+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	[Subtask 3]	{"value":false}	1673965824187	1673965824187	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7kyu1oo9a5tr8ufteannsa8fxdc	2023-01-17 14:30:23.920434+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	[Subtask 2]	{"value":false}	1673965824192	1673965824192	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7nyebddja77gpuyhwq4s3mo41mc	2023-01-17 14:30:23.920434+00	czw9es1e89fdpjr7cqptr1xq7qh	1	divider		{}	1673965824198	1673965824198	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7e6dhmna5ftdcbf889krm4i7hxy	2023-01-17 14:30:23.920434+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	[Subtask 1]	{"value":false}	1673965824203	1673965824203	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7oj11jtmk13nbbn5gpexnm3z1cw	2023-01-17 14:30:23.920434+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	...	{"value":false}	1673965824208	1673965824208	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
audpbcs4gctffzkx38kcx1j358r	2023-01-17 14:30:23.920434+00	czw9es1e89fdpjr7cqptr1xq7qh	1	text	## Description\n*[Brief description of this task]*	{}	1673965824214	1673965824214	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
ayk8q8hxxh7nb9x85ebj8dozrzy	2023-01-17 14:30:23.920434+00	czw9es1e89fdpjr7cqptr1xq7qh	1	text	## Checklist	{}	1673965824219	1673965824219	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
czoygsk6367n6jr68mrunq9jxty	2023-01-17 14:30:24.861134+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Feature	{"contentOrder":["auctu9d65jffdjb95pgtn9jb1er"],"icon":"🏗️","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer"}}	1673965824926	1673965824926	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
a6mycyg9gnpbhi88appsymaipqe	2023-01-17 14:30:26.527051+00	cgcj5hcy4g7rrjfeniqeym9kcbc	1	text	Mattermost Boards helps you manage and track all your project tasks with **Cards**.	{}	1673965826767	1673965826767	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
v34by4i8zh3ggzer5yefmcyafkr	2023-01-17 14:30:24.573381+00		1	view	By Quarter	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":452,"a17ryhi1jfsboxkwkztwawhmsxe":148,"a6amddgmrzakw66cidqzgk6p4ge":230,"azzbawji5bksj69sekcs4srm1ky":142},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"aqxyzkdrs4egqf7yk866ixkaojc","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a6amddgmrzakw66cidqzgk6p4ge","a17ryhi1jfsboxkwkztwawhmsxe","azzbawji5bksj69sekcs4srm1ky","adp5ft3kgz7r5iqq3tnwg551der","aqxyzkdrs4egqf7yk866ixkaojc","adu6mebzpibq6mgcswk69xxmnqe","asope3bddhm4gpsng5cfu4hf6rh","ajwxp866f9obs1kutfwaa5ru7fe","azqnyswk6s1boiwuthscm78qwuo","ahz3fmjnaguec8hce7xq3h5cjdr","a17bfcgnzmkwhziwa4tr38kiw5r"]}	1673965824586	1673965824586	0	\N	system		system	baib5iktj5bdnjqnq67rayaidgr
voj4jpnt51f8simen38x3zn5zcy	2023-01-17 14:30:24.573381+00		1	view	By Objectives	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":387,"a17ryhi1jfsboxkwkztwawhmsxe":134,"a6amddgmrzakw66cidqzgk6p4ge":183,"aqxyzkdrs4egqf7yk866ixkaojc":100},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a6amddgmrzakw66cidqzgk6p4ge","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a6amddgmrzakw66cidqzgk6p4ge","a17ryhi1jfsboxkwkztwawhmsxe","azzbawji5bksj69sekcs4srm1ky","adp5ft3kgz7r5iqq3tnwg551der","aqxyzkdrs4egqf7yk866ixkaojc","adu6mebzpibq6mgcswk69xxmnqe","asope3bddhm4gpsng5cfu4hf6rh","ajwxp866f9obs1kutfwaa5ru7fe","azqnyswk6s1boiwuthscm78qwuo","ahz3fmjnaguec8hce7xq3h5cjdr","a17bfcgnzmkwhziwa4tr38kiw5r"]}	1673965824592	1673965824592	0	\N	system		system	baib5iktj5bdnjqnq67rayaidgr
c1p95u7fz4igatb61mtb7wg3fgc	2023-01-17 14:30:24.573381+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Improve customer NPS score	{"contentOrder":[],"icon":"💯","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a8nukezwwmknqwjsygg7eaxs9te","a6amddgmrzakw66cidqzgk6p4ge":"apqfjst8massbjjhpcsjs3y1yqa","adp5ft3kgz7r5iqq3tnwg551der":"as555ipyzopjjpfb5rjtssecw5e","ahz3fmjnaguec8hce7xq3h5cjdr":"82%","ajwxp866f9obs1kutfwaa5ru7fe":"8.5","aqxyzkdrs4egqf7yk866ixkaojc":"anruuoyez51r3yjxuoc8zoqnwaw","azqnyswk6s1boiwuthscm78qwuo":"7","azzbawji5bksj69sekcs4srm1ky":"agm9p6gcq15ueuzqq3wd4be39wy"}}	1673965824599	1673965824599	0	\N	system		system	baib5iktj5bdnjqnq67rayaidgr
crz9aw5kfafy138b5a6d1s1c4de	2023-01-17 14:30:24.573381+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Generate more Marketing Qualified Leads (MQLs)	{"contentOrder":[],"icon":"🛣️","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a8nukezwwmknqwjsygg7eaxs9te","a6amddgmrzakw66cidqzgk6p4ge":"auw3afh3kfhrfgmjr8muiz137jy","adp5ft3kgz7r5iqq3tnwg551der":"as555ipyzopjjpfb5rjtssecw5e","ahz3fmjnaguec8hce7xq3h5cjdr":"65%","ajwxp866f9obs1kutfwaa5ru7fe":"100","aqxyzkdrs4egqf7yk866ixkaojc":"ahfbn1jsmhydym33ygxwg5jt3kh","azqnyswk6s1boiwuthscm78qwuo":"65","azzbawji5bksj69sekcs4srm1ky":"aehoa17cz18rqnrf75g7dwhphpr"}}	1673965824606	1673965824605	0	\N	system		system	baib5iktj5bdnjqnq67rayaidgr
cwrqrgzfp9jdx9x1u4w34r17hya	2023-01-17 14:30:24.573381+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Increase customer retention	{"contentOrder":[],"icon":"😀","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a8nukezwwmknqwjsygg7eaxs9te","a6amddgmrzakw66cidqzgk6p4ge":"apqfjst8massbjjhpcsjs3y1yqa","adp5ft3kgz7r5iqq3tnwg551der":"a8zg3rjtf4swh7smsjxpsn743rh","ahz3fmjnaguec8hce7xq3h5cjdr":"66%","ajwxp866f9obs1kutfwaa5ru7fe":"90% customer retention rate","aqxyzkdrs4egqf7yk866ixkaojc":"acb6dqqs6yson7bbzx6jk9bghjh","azqnyswk6s1boiwuthscm78qwuo":"60%","azzbawji5bksj69sekcs4srm1ky":"afkxpcjqjypu7hhar7banxau91h"}}	1673965824613	1673965824613	0	\N	system		system	baib5iktj5bdnjqnq67rayaidgr
chdqeo6qei3bjiqhi6gtbaefq5o	2023-01-17 14:30:24.573381+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Hit company global sales target	{"contentOrder":[],"icon":"💰","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a6robxx81diugpjq5jkezz3j1fo","a6amddgmrzakw66cidqzgk6p4ge":"auw3afh3kfhrfgmjr8muiz137jy","adp5ft3kgz7r5iqq3tnwg551der":"a8zg3rjtf4swh7smsjxpsn743rh","ahz3fmjnaguec8hce7xq3h5cjdr":"15%","ajwxp866f9obs1kutfwaa5ru7fe":"50MM","aqxyzkdrs4egqf7yk866ixkaojc":"awfu37js3fomfkkczm1zppac57a","azqnyswk6s1boiwuthscm78qwuo":"7.5MM","azzbawji5bksj69sekcs4srm1ky":"agrfeaoj7d8p5ianw5iaf3191ae"}}	1673965824618	1673965824618	0	\N	system		system	baib5iktj5bdnjqnq67rayaidgr
cr8h4tr6yrfnxf854bmshqswcrw	2023-01-17 14:30:24.573381+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Increase user signups by 30%	{"contentOrder":[],"icon":"💳","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a6robxx81diugpjq5jkezz3j1fo","a6amddgmrzakw66cidqzgk6p4ge":"ao9b5pxyt7tkgdohzh9oaustdhr","adp5ft3kgz7r5iqq3tnwg551der":"as555ipyzopjjpfb5rjtssecw5e","ahz3fmjnaguec8hce7xq3h5cjdr":"0%","ajwxp866f9obs1kutfwaa5ru7fe":"1,000","aqxyzkdrs4egqf7yk866ixkaojc":"acb6dqqs6yson7bbzx6jk9bghjh","azqnyswk6s1boiwuthscm78qwuo":"0","azzbawji5bksj69sekcs4srm1ky":"afkxpcjqjypu7hhar7banxau91h"}}	1673965824624	1673965824624	0	\N	system		system	baib5iktj5bdnjqnq67rayaidgr
c3np3bao4utfbpkbysc4grpea9r	2023-01-17 14:30:24.573381+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Add 10 new customers in the EU	{"contentOrder":[],"icon":"🌍","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"apnt1f7na9rzgk1rt49keg7xbiy","a6amddgmrzakw66cidqzgk6p4ge":"auw3afh3kfhrfgmjr8muiz137jy","adp5ft3kgz7r5iqq3tnwg551der":"a1ts3ftyr8nocsicui98c89uxjy","ahz3fmjnaguec8hce7xq3h5cjdr":"30%","ajwxp866f9obs1kutfwaa5ru7fe":"10","aqxyzkdrs4egqf7yk866ixkaojc":"acb6dqqs6yson7bbzx6jk9bghjh","azqnyswk6s1boiwuthscm78qwuo":"3","azzbawji5bksj69sekcs4srm1ky":"agrfeaoj7d8p5ianw5iaf3191ae"}}	1673965824630	1673965824630	0	\N	system		system	baib5iktj5bdnjqnq67rayaidgr
czaw3u5a3mtyuuqj3hxbxxxjfbe	2023-01-17 14:30:24.573381+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Launch 3 key features	{"contentOrder":[],"icon":"🚀","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"apnt1f7na9rzgk1rt49keg7xbiy","a6amddgmrzakw66cidqzgk6p4ge":"ao9b5pxyt7tkgdohzh9oaustdhr","adp5ft3kgz7r5iqq3tnwg551der":"a8zg3rjtf4swh7smsjxpsn743rh","ahz3fmjnaguec8hce7xq3h5cjdr":"33%","ajwxp866f9obs1kutfwaa5ru7fe":"3","aqxyzkdrs4egqf7yk866ixkaojc":"anruuoyez51r3yjxuoc8zoqnwaw","azqnyswk6s1boiwuthscm78qwuo":"1","azzbawji5bksj69sekcs4srm1ky":"aw5i7hmpadn6mbwbz955ubarhme"}}	1673965824636	1673965824636	0	\N	system		system	baib5iktj5bdnjqnq67rayaidgr
c8r3nd58zopf18khq7bo4zqarja	2023-01-17 14:30:24.573381+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Reduce bug backlog by 50%	{"contentOrder":[],"icon":"🐞","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"abzfwnn6rmtfzyq5hg8uqmpsncy","a6amddgmrzakw66cidqzgk6p4ge":"apqfjst8massbjjhpcsjs3y1yqa","adp5ft3kgz7r5iqq3tnwg551der":"a1ts3ftyr8nocsicui98c89uxjy","ahz3fmjnaguec8hce7xq3h5cjdr":"100%","ajwxp866f9obs1kutfwaa5ru7fe":"75","aqxyzkdrs4egqf7yk866ixkaojc":"awfu37js3fomfkkczm1zppac57a","azqnyswk6s1boiwuthscm78qwuo":"75","azzbawji5bksj69sekcs4srm1ky":"aw5i7hmpadn6mbwbz955ubarhme"}}	1673965824641	1673965824641	0	\N	system		system	baib5iktj5bdnjqnq67rayaidgr
a5mqxz59kd3bbjmo9ohn3145wwe	2023-01-17 14:30:24.861134+00	c76435tzksigr8n8q3xkej17h3y	1	text	## Summary\n*[Brief description of what this epic is about]*\n\n## Motivation\n*[Brief description on why this is needed]*\n\n## Acceptance Criteria\n - *[Criteron 1]*\n - *[Criteron 2]*\n - ...\n\n## Personas\n - *[Persona A]*\n - *[Persona B]*\n - ...\n\n## Reference Materials\n - *[Links to other relevant documents as needed]*\n - ...	{}	1673965825018	1673965825018	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
vticqp4sj93naddnufrwsb5mm6r	2023-01-17 14:30:24.573381+00	bm4ubx56krp4zwyfcqh7nxiigbr	1	view	Departments	{"cardOrder":["cpa534b5natgmunis8u1ixb55pw"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"azzbawji5bksj69sekcs4srm1ky","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["aw5i7hmpadn6mbwbz955ubarhme","afkxpcjqjypu7hhar7banxau91h","aehoa17cz18rqnrf75g7dwhphpr","agrfeaoj7d8p5ianw5iaf3191ae","agm9p6gcq15ueuzqq3wd4be39wy","aucop7kw6xwodcix6zzojhxih6r","afust91f3g8ht368mkn5x9tgf1o","acocxxwjurud1jixhp7nowdig7y"],"visiblePropertyIds":[]}	1673965824647	1673965824647	0	\N	system		system	baib5iktj5bdnjqnq67rayaidgr
vgoe1wty5apbz7p1hkrpetybhih	2023-01-17 14:30:24.861134+00		1	view	By Sprint	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{"ai7ajsdk14w7x5s8up3dwir77te":"count"},"columnWidths":{"20717ad3-5741-4416-83f1-6f133fff3d11":128,"50117d52-bcc7-4750-82aa-831a351c44a0":126,"__title":280,"a1g6i613dpe9oryeo71ex3c86hy":159,"aeomttrbhhsi8bph31jn84sto6h":141,"ax9f8so418s6s65hi5ympd93i6a":183,"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":100},"defaultTemplateId":"cog6ycjunyiry8pt7q3h3idejhc","filter":{"filters":[],"operation":"and"},"groupById":"60985f46-3e41-486e-8213-2b987440ea1c","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["50117d52-bcc7-4750-82aa-831a351c44a0","20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","aphg37f7zbpuc3bhwhp19s1ribh","a4378omyhmgj3bex13sj4wbpfiy","ai7ajsdk14w7x5s8up3dwir77te","a1g6i613dpe9oryeo71ex3c86hy","aeomttrbhhsi8bph31jn84sto6h","ax9f8so418s6s65hi5ympd93i6a"]}	1673965824877	1673965824877	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
cog6ycjunyiry8pt7q3h3idejhc	2023-01-17 14:30:24.861134+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	User Story	{"contentOrder":["ah5nioubi93gmmb44w57qz7riuh"],"icon":"📖","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"apht1nt5ryukdmxkh6fkfn6rgoy","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer"}}	1673965824882	1673965824882	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
cerinpts6qbfadd8utwigd5txkw	2023-01-17 14:30:24.861134+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Horizontal scroll issue	{"contentOrder":["axqytkyitrbb1dfim7zgxn3uyey","a1uxwb5zxoi8gxg1i7raq8q3mwh","714krqfu73fb3ubkg15chhsygiw"],"icon":"〰️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"aomnawq4551cbbzha9gxnmb3z5w","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","ai7ajsdk14w7x5s8up3dwir77te":"1","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1673965824886	1673965824886	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
c5agijuybu3ytipchh1cg1jft7o	2023-01-17 14:30:24.861134+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Login screen not loading	{"contentOrder":["aujmrexi577yhipbw7m41mbushw","ag6awtgfgbpbixnnpjo6xe6geao","7n3nofrrx5tb7tdh6m1rgmitaba"],"icon":"🖥️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"aomnawq4551cbbzha9gxnmb3z5w","50117d52-bcc7-4750-82aa-831a351c44a0":"abrfos7e7eczk9rqw6y5abadm1y","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","ai7ajsdk14w7x5s8up3dwir77te":"1","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"cb8ecdac-38be-4d36-8712-c4d58cc8a8e9"}}	1673965824891	1673965824891	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
cbwwm511wmprm8khw3odqtc8rso	2023-01-17 14:30:24.861134+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Move cards across boards	{"contentOrder":["aiuehztraw3fdxbx3jjb1ymrzbo"],"icon":"🚚","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"abrfos7e7eczk9rqw6y5abadm1y","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"2","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1673965824897	1673965824897	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
co3uik6unbfbh5kufkccujj5jaw	2023-01-17 14:30:24.861134+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Cross-team collaboration	{"contentOrder":["adbz7rq4oybfdfmse97y1xpo8ia"],"icon":"🤝","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"424ea5e3-9aa1-4075-8c5c-01b44b66e634","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","60985f46-3e41-486e-8213-2b987440ea1c":"14892380-1a32-42dd-8034-a0cea32bc7e6","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"3","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"c62172ea-5da7-4dec-8186-37267d8ee9a7"}}	1673965824902	1673965824902	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
cro6hkqoesjygdqxtxtt3chefhc	2023-01-17 14:30:24.861134+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Bug	{"contentOrder":["amudnp868cbgr7m1koigb15fqre","ajdtjxrn6ytyn9pn33d6khzy34c","7wikyy4jobjypdfz86k6y3oh8kw"],"icon":"🐞","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"aomnawq4551cbbzha9gxnmb3z5w","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer"}}	1673965824907	1673965824907	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
c83juh4kyc7n6fc4eedjcfknigh	2023-01-17 14:30:24.861134+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Standard properties	{"contentOrder":["aknnbc5xktjde5k481bmide81pw"],"icon":"🏷️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","60985f46-3e41-486e-8213-2b987440ea1c":"14892380-1a32-42dd-8034-a0cea32bc7e6","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"3","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1673965824911	1673965824911	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
c76435tzksigr8n8q3xkej17h3y	2023-01-17 14:30:24.861134+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Epic	{"contentOrder":["a5mqxz59kd3bbjmo9ohn3145wwe"],"icon":"🤝","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"424ea5e3-9aa1-4075-8c5c-01b44b66e634","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"3","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"c62172ea-5da7-4dec-8186-37267d8ee9a7"}}	1673965824916	1673965824916	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
cmki93n3aii8o7f81jb5qya6z7r	2023-01-17 14:30:24.861134+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Global templates	{"contentOrder":["ask4at3979iyemm4pwixhwqmmjr"],"icon":"🖼️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"a6ghze4iy441qhsh3eijnc8hwze","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"2","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1673965824921	1673965824921	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
ask4at3979iyemm4pwixhwqmmjr	2023-01-17 14:30:24.861134+00	cmki93n3aii8o7f81jb5qya6z7r	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1673965825023	1673965825023	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
vqrfrhdqmeff18yuqoji3fq3h4e	2023-01-17 14:30:24.861134+00	bgi1yqiis8t8xdqxgnet8ebutky	1	view	By Status	{"cardOrder":["cmki93n3aii8o7f81jb5qya6z7r","cerinpts6qbfadd8utwigd5txkw","cbwwm511wmprm8khw3odqtc8rso","c5agijuybu3ytipchh1cg1jft7o","c83juh4kyc7n6fc4eedjcfknigh","co3uik6unbfbh5kufkccujj5jaw"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cidz4imnqhir48brz6e8hxhfrhy","filter":{"filters":[],"operation":"and"},"groupById":"50117d52-bcc7-4750-82aa-831a351c44a0","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["aft5bzo7h9aspqgrx3jpy5tzrer","abrfos7e7eczk9rqw6y5abadm1y","ax8wzbka5ahs3zziji3pp4qp9mc","atabdfbdmjh83136d5e5oysxybw","ace1bzypd586kkyhcht5qqd9eca","aay656c9m1hzwxc9ch5ftymh3nw","a6ghze4iy441qhsh3eijnc8hwze"],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1673965824932	1673965824932	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
vmao9o6ciajb3fedfdenjeefm6a	2023-01-17 14:30:24.861134+00	bgi1yqiis8t8xdqxgnet8ebutky	1	view	By Type	{"cardOrder":["c5agijuybu3ytipchh1cg1jft7o","cbwwm511wmprm8khw3odqtc8rso","c83juh4kyc7n6fc4eedjcfknigh","cerinpts6qbfadd8utwigd5txkw","cmki93n3aii8o7f81jb5qya6z7r","co3uik6unbfbh5kufkccujj5jaw"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cidz4imnqhir48brz6e8hxhfrhy","filter":{"filters":[],"operation":"and"},"groupById":"20717ad3-5741-4416-83f1-6f133fff3d11","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["424ea5e3-9aa1-4075-8c5c-01b44b66e634","a5yxq8rbubrpnoommfwqmty138h","apht1nt5ryukdmxkh6fkfn6rgoy","aiycbuo3dr5k4xxbfr7coem8ono","aomnawq4551cbbzha9gxnmb3z5w"],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1673965824936	1673965824936	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
ah5nioubi93gmmb44w57qz7riuh	2023-01-17 14:30:24.861134+00	cog6ycjunyiry8pt7q3h3idejhc	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1673965824942	1673965824942	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
714krqfu73fb3ubkg15chhsygiw	2023-01-17 14:30:24.861134+00	cerinpts6qbfadd8utwigd5txkw	1	image		{"fileId":"7tmfu5iqju3n1mdfwi5gru89qmw.png"}	1673965824947	1673965824947	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
axqytkyitrbb1dfim7zgxn3uyey	2023-01-17 14:30:24.861134+00	cerinpts6qbfadd8utwigd5txkw	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1673965824952	1673965824952	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
a1uxwb5zxoi8gxg1i7raq8q3mwh	2023-01-17 14:30:24.861134+00	cerinpts6qbfadd8utwigd5txkw	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1673965824957	1673965824957	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
7n3nofrrx5tb7tdh6m1rgmitaba	2023-01-17 14:30:24.861134+00	c5agijuybu3ytipchh1cg1jft7o	1	image		{"fileId":"7b9xk9boj3fbqfm3umeaaizp8qr.png"}	1673965824962	1673965824962	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
aujmrexi577yhipbw7m41mbushw	2023-01-17 14:30:24.861134+00	c5agijuybu3ytipchh1cg1jft7o	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1673965824967	1673965824967	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
ag6awtgfgbpbixnnpjo6xe6geao	2023-01-17 14:30:24.861134+00	c5agijuybu3ytipchh1cg1jft7o	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1673965824971	1673965824971	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
aiuehztraw3fdxbx3jjb1ymrzbo	2023-01-17 14:30:24.861134+00	cbwwm511wmprm8khw3odqtc8rso	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1673965824976	1673965824976	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
acecqo3xppbyx7nx9yo9myofcyr	2023-01-17 14:30:24.861134+00	cfmk7771httynm8r7rm8cbrmrya	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1673965824982	1673965824982	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
adky73z881bguzefnwtji7k9kcw	2023-01-17 14:30:24.861134+00	cfmk7771httynm8r7rm8cbrmrya	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1673965824987	1673965824987	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
adbz7rq4oybfdfmse97y1xpo8ia	2023-01-17 14:30:24.861134+00	co3uik6unbfbh5kufkccujj5jaw	1	text	## Summary\n*[Brief description of what this epic is about]*\n\n## Motivation\n*[Brief description on why this is needed]*\n\n## Acceptance Criteria\n - *[Criteron 1]*\n - *[Criteron 2]*\n - ...\n\n## Personas\n - *[Persona A]*\n - *[Persona B]*\n - ...\n\n## Reference Materials\n - *[Links to other relevant documents as needed]*\n - ...	{}	1673965824992	1673965824992	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
7wikyy4jobjypdfz86k6y3oh8kw	2023-01-17 14:30:24.861134+00	cro6hkqoesjygdqxtxtt3chefhc	1	image		{"fileId":"7tmfu5iqju3n1mdfwi5gru89qmw.png"}	1673965824997	1673965824997	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
amudnp868cbgr7m1koigb15fqre	2023-01-17 14:30:24.861134+00	cro6hkqoesjygdqxtxtt3chefhc	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1673965825002	1673965825002	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
ajdtjxrn6ytyn9pn33d6khzy34c	2023-01-17 14:30:24.861134+00	cro6hkqoesjygdqxtxtt3chefhc	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1673965825007	1673965825007	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
aknnbc5xktjde5k481bmide81pw	2023-01-17 14:30:24.861134+00	c83juh4kyc7n6fc4eedjcfknigh	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1673965825013	1673965825013	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
auctu9d65jffdjb95pgtn9jb1er	2023-01-17 14:30:24.861134+00	czoygsk6367n6jr68mrunq9jxty	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1673965825029	1673965825029	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
vh68yx1yinin7tgxtkb87ifp7ie	2023-01-17 14:30:25.483027+00		1	view	Competitor List	{"cardOrder":["cicw93ci61p8388axk61zcmckqw","cc1pmziu8bjrgjbf6qw8u5qmcyc","cqdaiquhea78yigzjomqqoou3tw","c5bruozijn3rkfdowwo7stdwxmo","cr3yfndkftif3uryzqkn555uzxy"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":210,"a1semdhszu1rq17d7et5ydrqqio":121,"aapogff3xoa8ym7xf56s87kysda":194,"ahzspe59iux8wigra8bg6cg18nc":156,"aiefo7nh9jwisn8b4cgakowithy":155,"aozntq4go4nkab688j1s7stqtfc":151,"az3jkw3ynd3mqmart7edypey15e":145},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["ahzspe59iux8wigra8bg6cg18nc","aozntq4go4nkab688j1s7stqtfc","aiefo7nh9jwisn8b4cgakowithy","a6cwaq79b1pdpb97wkanmeyy4er","an1eerzscfxn6awdfajbg41uz3h","a1semdhszu1rq17d7et5ydrqqio","aapogff3xoa8ym7xf56s87kysda","az3jkw3ynd3mqmart7edypey15e"]}	1673965825493	1673965825493	0	\N	system		system	b9ejcs37rcjfdde8b49oabrj6kh
v9u6y9ycef38jdf4hudr6j1b6uc	2023-01-17 14:30:25.483027+00		1	view	Market Position	{"cardOrder":["cip8b4jcomfr7by9gtizebikfke","cacs91js1hb887ds41r6dwnd88c","ca3u8edwrof89i8obxffnz4xw3a"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["arfjpz9by5car71tz3behba8yih","abajmr34b8g1916w495xjb35iko","abt79uxg5edqojsrrefcnr4eruo","aipf3qfgjtkheiayjuxrxbpk9wa"],"visiblePropertyIds":[]}	1673965825498	1673965825498	0	\N	system		system	b9ejcs37rcjfdde8b49oabrj6kh
cicw93ci61p8388axk61zcmckqw	2023-01-17 14:30:25.483027+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Liminary Corp.	{"contentOrder":["amsemmr19stgmzdrh6xh4kkujse"],"icon":"🌧","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"abt79uxg5edqojsrrefcnr4eruo","a6cwaq79b1pdpb97wkanmeyy4er":"300","ahzspe59iux8wigra8bg6cg18nc":"liminarycorp.com","aiefo7nh9jwisn8b4cgakowithy":"$25,000,000","an1eerzscfxn6awdfajbg41uz3h":"2017","aozntq4go4nkab688j1s7stqtfc":"Toronto, Canada"}}	1673965825503	1673965825503	0	\N	system		system	b9ejcs37rcjfdde8b49oabrj6kh
cc1pmziu8bjrgjbf6qw8u5qmcyc	2023-01-17 14:30:25.483027+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Helx Industries	{"contentOrder":["a4b15o5sa7jn4ppdech3dt98pzr"],"icon":"📦","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"abt79uxg5edqojsrrefcnr4eruo","a6cwaq79b1pdpb97wkanmeyy4er":"650","ahzspe59iux8wigra8bg6cg18nc":"helxindustries.com","aiefo7nh9jwisn8b4cgakowithy":"$50,000,000","an1eerzscfxn6awdfajbg41uz3h":"2009","aozntq4go4nkab688j1s7stqtfc":"New York, NY"}}	1673965825508	1673965825508	0	\N	system		system	b9ejcs37rcjfdde8b49oabrj6kh
cqdaiquhea78yigzjomqqoou3tw	2023-01-17 14:30:25.483027+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Kadera Global	{"contentOrder":["a4w84368xmpd33b7k1e533gks7y"],"icon":"🛡","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"aipf3qfgjtkheiayjuxrxbpk9wa","a6cwaq79b1pdpb97wkanmeyy4er":"150","ahzspe59iux8wigra8bg6cg18nc":"kaderaglobal.com","aiefo7nh9jwisn8b4cgakowithy":"$12,000,000","an1eerzscfxn6awdfajbg41uz3h":"2015","aozntq4go4nkab688j1s7stqtfc":"Seattle, OR"}}	1673965825514	1673965825514	0	\N	system		system	b9ejcs37rcjfdde8b49oabrj6kh
cr3yfndkftif3uryzqkn555uzxy	2023-01-17 14:30:25.483027+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Ositions Inc.	{"contentOrder":["a6yuwn4u837y3xm9ho3d4kistwa"],"icon":"🌃","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"abajmr34b8g1916w495xjb35iko","a6cwaq79b1pdpb97wkanmeyy4er":"2,700","ahzspe59iux8wigra8bg6cg18nc":"ositionsinc.com","aiefo7nh9jwisn8b4cgakowithy":"$125,000,000","an1eerzscfxn6awdfajbg41uz3h":"2004","aozntq4go4nkab688j1s7stqtfc":"Berlin, Germany"}}	1673965825519	1673965825519	0	\N	system		system	b9ejcs37rcjfdde8b49oabrj6kh
c5bruozijn3rkfdowwo7stdwxmo	2023-01-17 14:30:25.483027+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Afformance Ltd.	{"contentOrder":["aye7oif7ue3yw7d1rn7wcjcmymr"],"icon":"⚡","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"arfjpz9by5car71tz3behba8yih","a6cwaq79b1pdpb97wkanmeyy4er":"1,800","ahzspe59iux8wigra8bg6cg18nc":"afformanceltd.com","aiefo7nh9jwisn8b4cgakowithy":"$200,000,000","an1eerzscfxn6awdfajbg41uz3h":"2002","aozntq4go4nkab688j1s7stqtfc":"Palo Alto, CA"}}	1673965825524	1673965825524	0	\N	system		system	b9ejcs37rcjfdde8b49oabrj6kh
amsemmr19stgmzdrh6xh4kkujse	2023-01-17 14:30:25.483027+00	cicw93ci61p8388axk61zcmckqw	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1673965825531	1673965825531	0	\N	system		system	b9ejcs37rcjfdde8b49oabrj6kh
a4b15o5sa7jn4ppdech3dt98pzr	2023-01-17 14:30:25.483027+00	cc1pmziu8bjrgjbf6qw8u5qmcyc	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1673965825539	1673965825539	0	\N	system		system	b9ejcs37rcjfdde8b49oabrj6kh
a4w84368xmpd33b7k1e533gks7y	2023-01-17 14:30:25.483027+00	cqdaiquhea78yigzjomqqoou3tw	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1673965825548	1673965825548	0	\N	system		system	b9ejcs37rcjfdde8b49oabrj6kh
a6yuwn4u837y3xm9ho3d4kistwa	2023-01-17 14:30:25.483027+00	cr3yfndkftif3uryzqkn555uzxy	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n\n## Weaknesses\n- ...\n- ...\n\n## Opportunities\n- ...\n- ...\n\n## Threats\n- ...\n- ...	{}	1673965825552	1673965825552	0	\N	system		system	b9ejcs37rcjfdde8b49oabrj6kh
csyx888zmcbbqx8mj66u1su4naw	2023-01-17 14:30:25.286676+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Olivia Alsop	{"contentOrder":["ao7ysbf51k7bpbct1hm9rftgeao"],"icon":"👩‍💼","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"a7yq89whddzob1futao4rxk3yzc","acjq4t5ymytu8x1f68wkggm7ypc":"olivia.alsop@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1671192000000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"a1sxagjgaadym5yrjak6tcup1oa"}}	1673965825317	1673965825317	0	\N	system		system	bky8mjzqy9incxk3gjqwiatz6xa
cyqyd3kzo43nqix1bda5hs5n4zh	2023-01-17 14:30:25.286676+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Bernadette Powell	{"contentOrder":["ac9psk4cuofrn5fkbrs4oxcjiaw"],"icon":"🧑‍💼","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"af6hjb3ysuaxbwnfqpby4wwnkdr","acjq4t5ymytu8x1f68wkggm7ypc":"bernadette.powell@email.com"}}	1673965825322	1673965825322	0	\N	system		system	bky8mjzqy9incxk3gjqwiatz6xa
vjzmfz4c4hfg8xnt7d438z6zxiw	2023-01-17 14:30:25.286676+00	bh4pkixqsjift58e1qy6htrgeay	1	view	By Date	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"akrxgi7p7w14fym3gbynb98t9fh","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1673965825328	1673965825328	0	\N	system		system	bky8mjzqy9incxk3gjqwiatz6xa
v9wmgqz394jy18no8rs8we3z3oa	2023-01-17 14:30:25.286676+00	bixohg18tt11in4qbtinimk974y	1	view	By Status	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["af6hjb3ysuaxbwnfqpby4wwnkdr","aotxum1p5bw3xuzqz3ctjw66yww","a7yq89whddzob1futao4rxk3yzc","aseqq9hrsua56r3s6nbuirj9eec","ap93ysuzy1xa7z818r6myrn4h4y"],"visiblePropertyIds":[]}	1673965825334	1673965825334	0	\N	system		system	bky8mjzqy9incxk3gjqwiatz6xa
a9ts9agiduibzfkc3e3gjgjcsto	2023-01-17 14:30:25.286676+00	ctepgdjm48jbozybjcugxcah8oh	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1673965825340	1673965825340	0	\N	system		system	bky8mjzqy9incxk3gjqwiatz6xa
ah4uo9iiftjyt5dc4wzkyk348ch	2023-01-17 14:30:25.286676+00	c9w8xao7k4fdq7findb74g5uyme	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1673965825344	1673965825344	0	\N	system		system	bky8mjzqy9incxk3gjqwiatz6xa
ajhftsh9id3ncbcpguzmhm3r7ua	2023-01-17 14:30:25.286676+00	csoqauki377rqme49sujukpf9ie	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1673965825349	1673965825349	0	\N	system		system	bky8mjzqy9incxk3gjqwiatz6xa
ao7ysbf51k7bpbct1hm9rftgeao	2023-01-17 14:30:25.286676+00	csyx888zmcbbqx8mj66u1su4naw	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1673965825355	1673965825355	0	\N	system		system	bky8mjzqy9incxk3gjqwiatz6xa
ac9psk4cuofrn5fkbrs4oxcjiaw	2023-01-17 14:30:25.286676+00	cyqyd3kzo43nqix1bda5hs5n4zh	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1673965825360	1673965825360	0	\N	system		system	bky8mjzqy9incxk3gjqwiatz6xa
cfkmbhbwkc3g8mb6uoag7zbb4mr	2023-01-17 14:30:25.707592+00	brs9cdimfw7fodyi7erqt747rhc	1	card	New Project and Workflow Management Solutions for Developers	{"contentOrder":["71qhnzuec6esdi6fnynwpze4xya","aes7wxky9d7gwpx9zwgsmmcbuwa"],"icon":"🎯","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1645790400000}","ab6mbock6styfe6htf815ph1mhw":["a8xceonxiu4n3c43szhskqizicr","a3pdzi53kpbd4okzdkz6khi87zo","a3d9ux4fmi3anyd11kyipfbhwde"],"ae9ar615xoknd8hw8py7mbyr7zo":"awna1nuarjca99m9s4uiy9kwj5h","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://mattermost.com/newsroom/press-releases/mattermost-launches-new-project-and-workflow-management-solutions-for-developers/","aysx3atqexotgwp5kx6h5i5ancw":"aywiofmmtd3ofgzj95ysky4pjga"}}	1673965825720	1673965825720	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
cb6qwccn65j877k47xn94fjybno	2023-01-17 14:30:25.707592+00	brs9cdimfw7fodyi7erqt747rhc	1	card	[Tweet] Mattermost v6.1 includes card @-mention notifications in Boards	{"contentOrder":["7i96m7nbsdsex8n6hzuzrmdfjuy","7ed5bwp3gr8yax3mhtuwiaa9gjy","airobmyxs97gf9x776u9yggqonw","a5d8u884hffgfmmnmeskpx9tfxw","abdasiyq4k7ndtfrdadrias8sjy","7b1j6y7syg7r7jmmeho8we95u7o"],"icon":"🐤","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1639051200000}","ab6mbock6styfe6htf815ph1mhw":["az8o8pfe9hq6s7xaehoqyc3wpyc"],"ae9ar615xoknd8hw8py7mbyr7zo":"a9ana1e9w673o5cp8md4xjjwfto","agqsoiipowmnu9rdwxm57zrehtr":"{\\"from\\":1637668800000}","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://twitter.com/Mattermost/status/1463145633162969097?s=20","aysx3atqexotgwp5kx6h5i5ancw":"aj8y675weso8kpb6eceqbpj4ruw"}}	1673965825726	1673965825726	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
cacokw4kzwtbb8dpdcwzk4gzpur	2023-01-17 14:30:25.707592+00	brs9cdimfw7fodyi7erqt747rhc	1	card	Top 10 Must-Have DevOps Tools in 2021	{"contentOrder":["7fo1utqc8x1z1z6hzg33hes1ktc","an583m9ixy3r8up5o48q1aa4toe"],"icon":"🛠️","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1636113600000}","ab6mbock6styfe6htf815ph1mhw":["a8xceonxiu4n3c43szhskqizicr"],"ae9ar615xoknd8hw8py7mbyr7zo":"a9ana1e9w673o5cp8md4xjjwfto","agqsoiipowmnu9rdwxm57zrehtr":"{\\"from\\":1637323200000}","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://www.toolbox.com/tech/devops/articles/best-devops-tools/","aysx3atqexotgwp5kx6h5i5ancw":"a3xky7ygn14osr1mokerbfah5cy"}}	1673965825732	1673965825732	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
cce5w7gzdrfyg7xu4u4zjtdsc5r	2023-01-17 14:30:25.707592+00	brs9cdimfw7fodyi7erqt747rhc	1	card	Unblocking Workflows: The Guide to Developer Productivity	{"contentOrder":["77tz16jtz5x73ncs3dxc3fp1d7h","ashgk8wjxf7gbtcecrhqokf33ia"],"icon":"💻","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1638532800000}","ab6mbock6styfe6htf815ph1mhw":["a3pdzi53kpbd4okzdkz6khi87zo"],"ae9ar615xoknd8hw8py7mbyr7zo":"apy9dcd7zmand615p3h53zjqxjh","agqsoiipowmnu9rdwxm57zrehtr":"{\\"from\\":1639483200000}","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://mattermost.com/newsroom/press-releases/mattermost-unveils-definitive-report-on-the-state-of-developer-productivity-unblocking-workflows-the-guide-to-developer-productivity-2022-edition/","aysx3atqexotgwp5kx6h5i5ancw":"a3xky7ygn14osr1mokerbfah5cy"}}	1673965825737	1673965825737	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
vbwwc7h53y3du5gh53hbhr8phme	2023-01-17 14:30:25.707592+00	brs9cdimfw7fodyi7erqt747rhc	1	view	By Status	{"cardOrder":[null,"cdbfkd15d6iy18rgx1tskmfsr6c","cn8yofg9rtkgmzgmb5xdi56p3ic","csgsnnywpuqzs5jgq87snk9x17e","cqwaytore5y487wdu8zffppqnea",null],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["awna1nuarjca99m9s4uiy9kwj5h","a9ana1e9w673o5cp8md4xjjwfto","apy9dcd7zmand615p3h53zjqxjh","acri4cm3bmay55f7ksztphmtnga","amsowcd9a8e1kid317r7ttw6uzh",""],"visiblePropertyIds":["ab6mbock6styfe6htf815ph1mhw"]}	1673965825742	1673965825742	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
7tc65fejc13b5jpckks38gorsga	2023-01-17 14:30:26.047826+00	cmjojddgzgtfr9x4g1gmijo1tmc	1	image		{"fileId":"77pe9r4ckbin438ph3f18bpatua.png"}	1673965826117	1673965826117	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
aye7oif7ue3yw7d1rn7wcjcmymr	2023-01-17 14:30:25.483027+00	c5bruozijn3rkfdowwo7stdwxmo	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1673965825556	1673965825556	0	\N	system		system	b9ejcs37rcjfdde8b49oabrj6kh
vm7gjj8ngejf1xp5fxtj95owqce	2023-01-17 14:30:25.707592+00	brs9cdimfw7fodyi7erqt747rhc	1	view	Due Date Calendar	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"a39x5cybshwrbjpc3juaakcyj6e","defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1673965825747	1673965825747	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
vi1d3wbwh5jb5unqb3wfu85dohc	2023-01-17 14:30:25.707592+00	brs9cdimfw7fodyi7erqt747rhc	1	view	Publication Calendar	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"agqsoiipowmnu9rdwxm57zrehtr","defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1673965825752	1673965825752	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
vjbda1tumcf89fcpy65nfabbquh	2023-01-17 14:30:25.707592+00	brs9cdimfw7fodyi7erqt747rhc	1	view	Content List	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":322,"ab6mbock6styfe6htf815ph1mhw":229,"aysx3atqexotgwp5kx6h5i5ancw":208},"defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"a39x5cybshwrbjpc3juaakcyj6e","reversed":false}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["ae9ar615xoknd8hw8py7mbyr7zo","aysx3atqexotgwp5kx6h5i5ancw","ab6mbock6styfe6htf815ph1mhw","ao44fz8nf6z6tuj1x31t9yyehcc","a39x5cybshwrbjpc3juaakcyj6e","agqsoiipowmnu9rdwxm57zrehtr","ap4e7kdg7eip7j3c3oyiz39eaoc"]}	1673965825758	1673965825758	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
aes7wxky9d7gwpx9zwgsmmcbuwa	2023-01-17 14:30:25.707592+00	cfkmbhbwkc3g8mb6uoag7zbb4mr	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1673965825765	1673965825765	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
7b1j6y7syg7r7jmmeho8we95u7o	2023-01-17 14:30:25.707592+00	cb6qwccn65j877k47xn94fjybno	1	image		{"fileId":"7y5kr8x8ybpnwdykjfuz57rggrh.png"}	1673965825770	1673965825770	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
airobmyxs97gf9x776u9yggqonw	2023-01-17 14:30:25.707592+00	cb6qwccn65j877k47xn94fjybno	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1673965825776	1673965825776	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
a5d8u884hffgfmmnmeskpx9tfxw	2023-01-17 14:30:25.707592+00	cb6qwccn65j877k47xn94fjybno	1	text	## Media	{}	1673965825782	1673965825782	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
aa1wmaqe7opyqjjr5a99ntihyny	2023-01-17 14:30:25.707592+00	cff1jmrxfrirgbeebhr9qd7nida	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1673965825787	1673965825787	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
ay6rgrg5p6tbdmn4iahqefcfm9c	2023-01-17 14:30:25.707592+00	cff1jmrxfrirgbeebhr9qd7nida	1	text	## Research\n- ...\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n- ...\n\n## Notes\n- ...\n- ...\n- ...	{}	1673965825793	1673965825793	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
apk537q4watycfe6szmnzrybj8r	2023-01-17 14:30:25.707592+00	cff1jmrxfrirgbeebhr9qd7nida	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1673965825799	1673965825799	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
an583m9ixy3r8up5o48q1aa4toe	2023-01-17 14:30:25.707592+00	cacokw4kzwtbb8dpdcwzk4gzpur	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1673965825804	1673965825804	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
ashgk8wjxf7gbtcecrhqokf33ia	2023-01-17 14:30:25.707592+00	cce5w7gzdrfyg7xu4u4zjtdsc5r	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1673965825809	1673965825809	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
vhzgfdgqtzjndm8jrmmsd5c9one	2023-01-17 14:30:25.954832+00	bjbhs6bos3m8zjouf78xceg9nqw	1	view	Board view	{"cardOrder":["cniwb8xwcqtbstbcm3sdfrr854h","cs4qwpzr65fgttd7364dicskanh","c9s78pzbdg3g4jkcdjqahtnfejc","c8utmazns878jtfgtf7exyi9pee","cnobejmb6bf8e3c1w7em5z4pwyh"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["aok6pgecm85qe9k5kcphzoe63ma","aq1dwbf661yx337hjcd5q3sbxwa","ar87yh5xmsswqkxmjq1ipfftfpc","akj3fkmxq7idma55mdt8sqpumyw"],"visiblePropertyIds":["aspaay76a5wrnuhtqgm97tt3rer"]}	1673965825962	1673965825962	0	\N	system		system	bbr1copn6i7yu5y9sqk1ijg49qa
cx46jb9wqup8nfqzcmyo5uz5iea	2023-01-17 14:30:25.954832+00	bsjd59qtpbf888mqez3ge77domw	1	card	Tight deadline	{"contentOrder":[],"icon":"📅","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"ar87yh5xmsswqkxmjq1ipfftfpc"}}	1673965825967	1673965825967	0	\N	system		system	bbr1copn6i7yu5y9sqk1ijg49qa
c85zr4gcn7jnetbnryktfjps8ur	2023-01-17 14:30:25.954832+00	bsjd59qtpbf888mqez3ge77domw	1	card	Team communication	{"contentOrder":[],"icon":"💬","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"aq1dwbf661yx337hjcd5q3sbxwa"}}	1673965825971	1673965825971	0	\N	system		system	bbr1copn6i7yu5y9sqk1ijg49qa
cxwp6mwzt5igp5k6qp1x1obu5br	2023-01-17 14:30:25.954832+00	bsjd59qtpbf888mqez3ge77domw	1	card	Reschedule planning meeting	{"contentOrder":[],"icon":"🗓️","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"aok6pgecm85qe9k5kcphzoe63ma"}}	1673965825975	1673965825975	0	\N	system		system	bbr1copn6i7yu5y9sqk1ijg49qa
cdx4o8eseutrt7mt8tc1ag9s44o	2023-01-17 14:30:25.954832+00	bsjd59qtpbf888mqez3ge77domw	1	card	Schedule more time for testing	{"contentOrder":[],"icon":"🧪","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"akj3fkmxq7idma55mdt8sqpumyw"}}	1673965825979	1673965825979	0	\N	system		system	bbr1copn6i7yu5y9sqk1ijg49qa
cf3aa5j4ojibc8q7j5tgn7q9w3o	2023-01-17 14:30:25.954832+00	bsjd59qtpbf888mqez3ge77domw	1	card	Positive user feedback	{"contentOrder":[],"icon":"🥰","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"aq1dwbf661yx337hjcd5q3sbxwa"}}	1673965825984	1673965825984	0	\N	system		system	bbr1copn6i7yu5y9sqk1ijg49qa
7eejdg1thpib9pyreu6gy369gwr	2023-01-17 14:30:26.527051+00	c1c6ht51zaiyymp156jtx5zgsfr	1	image		{"fileId":"7ek6wbpp19jfoujs1goh6kttbby.gif"}	1673965826770	1673965826770	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
cmjojddgzgtfr9x4g1gmijo1tmc	2023-01-17 14:30:26.047826+00	bui5izho7dtn77xg3thkiqprc9r	1	card	App crashing	{"contentOrder":["79t7rkiuspeneqi9xurou9tqzwh","a1n8516bmht86ubwgdmmubu3hfe","ahfu7tjz6e3n8ikszjzc6q6zrfr","7tc65fejc13b5jpckks38gorsga"],"icon":"📉","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"1fdbb515-edd2-4af5-80fc-437ed2211a49","50117d52-bcc7-4750-82aa-831a351c44a0":"ec6d2bc5-df2b-4f77-8479-e59ceb039946","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"cb8ecdac-38be-4d36-8712-c4d58cc8a8e9"}}	1673965826060	1673965826060	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
vbqdrei68mfgq8qd55tppz8txuw	2023-01-17 14:30:26.527051+00	buixxjic3xjfkieees4iafdrznc	1	view	Preview: Gallery View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"gallery","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1673965826611	1673965826611	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
cbe3wtgyhdt8szdh7mbnomnxgic	2023-01-17 14:30:26.047826+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Calendar view	{"contentOrder":["7df11783ny67mdnognqae31ax6y","a3mfg6qq8cprquqmszwjfd61mwr"],"icon":"📆","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"6eea96c9-4c61-4968-8554-4b7537e8f748","50117d52-bcc7-4750-82aa-831a351c44a0":"849766ba-56a5-48d1-886f-21672f415395","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1673965826065	1673965826065	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
cpyuu3sybytgut8j4qn4xwxutre	2023-01-17 14:30:26.047826+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Standard templates	{"contentOrder":["7uonmjk41nipnrsi6tz8wau5ssh","a5q8ks7a9yt8nxqstczu43jm9xo"],"icon":"🗺️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"6eea96c9-4c61-4968-8554-4b7537e8f748","50117d52-bcc7-4750-82aa-831a351c44a0":"ec6d2bc5-df2b-4f77-8479-e59ceb039946","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1673965826070	1673965826070	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
cnfbpr65ex78idc8mxzkbg1af9o	2023-01-17 14:30:26.047826+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Import / Export	{"contentOrder":["a83j1u6smx3ghjb6uq8h53anq1w"],"icon":"🚢","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"6eea96c9-4c61-4968-8554-4b7537e8f748","50117d52-bcc7-4750-82aa-831a351c44a0":"ec6d2bc5-df2b-4f77-8479-e59ceb039946","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1673965826074	1673965826074	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
cqpo6e8jq83fzbc5qodyza7h4xo	2023-01-17 14:30:26.047826+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Review API design	{"contentOrder":["axakofzpzair1pee8y7wne99aqo"],"icon":"🛣️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"424ea5e3-9aa1-4075-8c5c-01b44b66e634","50117d52-bcc7-4750-82aa-831a351c44a0":"8c557f69-b0ed-46ec-83a3-8efab9d47ef5","60985f46-3e41-486e-8213-2b987440ea1c":"14892380-1a32-42dd-8034-a0cea32bc7e6","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"c62172ea-5da7-4dec-8186-37267d8ee9a7"}}	1673965826078	1673965826078	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
ctrzp9m4883n6uqf8ddo3ppg8kw	2023-01-17 14:30:26.047826+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Icons don't display	{"contentOrder":["a6pmhwjs5zpfwdr3ygbeo9z43ac","akp54muj8mbrtbyoswn17bcprky","77mn3imeqqpgi5mmoegdg9mfzow"],"icon":"💻","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"1fdbb515-edd2-4af5-80fc-437ed2211a49","50117d52-bcc7-4750-82aa-831a351c44a0":"8c557f69-b0ed-46ec-83a3-8efab9d47ef5","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1673965826084	1673965826084	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
v1cdhfbfyppgkdefy3gaq4t6oto	2023-01-17 14:30:26.047826+00	bui5izho7dtn77xg3thkiqprc9r	1	view	Calendar View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"a4378omyhmgj3bex13sj4wbpfiy","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1673965826089	1673965826089	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
vgydkqua38fyb78zr8y5aq4cabo	2023-01-17 14:30:26.047826+00	bui5izho7dtn77xg3thkiqprc9r	1	view	Board: Sprints	{"cardOrder":["cmjojddgzgtfr9x4g1gmijo1tmc","cbe3wtgyhdt8szdh7mbnomnxgic","cpyuu3sybytgut8j4qn4xwxutre","ctrzp9m4883n6uqf8ddo3ppg8kw","cnfbpr65ex78idc8mxzkbg1af9o","cqpo6e8jq83fzbc5qodyza7h4xo"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"60985f46-3e41-486e-8213-2b987440ea1c","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["c01676ca-babf-4534-8be5-cce2287daa6c","ed4a5340-460d-461b-8838-2c56e8ee59fe","14892380-1a32-42dd-8034-a0cea32bc7e6",""],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1673965826094	1673965826094	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
vwo8ebmszy3fsjnbj98e6et4s6a	2023-01-17 14:30:26.047826+00	bui5izho7dtn77xg3thkiqprc9r	1	view	List: Tasks 🔨	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"50117d52-bcc7-4750-82aa-831a351c44a0":139,"__title":280},"defaultTemplateId":"","filter":{"filters":[{"condition":"includes","propertyId":"20717ad3-5741-4416-83f1-6f133fff3d11","values":["6eea96c9-4c61-4968-8554-4b7537e8f748"]}],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"50117d52-bcc7-4750-82aa-831a351c44a0","reversed":true}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["50117d52-bcc7-4750-82aa-831a351c44a0","20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1673965826101	1673965826101	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
aairnwhsokff9zg1eucqkxeu8ec	2023-01-17 14:30:26.047826+00	cwrq9ag3p5pgzzy98nfd3wwra1w	1	text	## Summary\n*[Brief description of what this epic is about]*\n## Motivation\n*[Brief description on why this is needed]*\n## Acceptance Criteria\n- *[Criteron 1]*\n- *[Criteron 2]*\n- ...\n## Personas\n- *[Persona A]*\n- *[Persona B]*\n- ...\n## Reference Materials\n- *[Links to other relevant documents as needed]*\n- ...	{}	1673965826259	1673965826259	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
vgj7m8iz34bgjtqpjkaeuhy47ao	2023-01-17 14:30:26.047826+00	bui5izho7dtn77xg3thkiqprc9r	1	view	Board: Status	{"cardOrder":["cmjojddgzgtfr9x4g1gmijo1tmc","cm4w7cc3aac6s9jdcujbs4j8f4r","c6egh6cpnj137ixdoitsoxq17oo","cct9u78utsdyotmejbmwwg66ihr","cmft87it1q7yebbd51ij9k65xbw","c9fe77j9qcruxf4itzib7ag6f1c","coup7afjknqnzbdwghiwbsq541w","c5ex1hndz8qyc8gx6ofbfeksftc"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cidz4imnqhir48brz6e8hxhfrhy","filter":{"filters":[],"operation":"and"},"groupById":"50117d52-bcc7-4750-82aa-831a351c44a0","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["8c557f69-b0ed-46ec-83a3-8efab9d47ef5","ec6d2bc5-df2b-4f77-8479-e59ceb039946","849766ba-56a5-48d1-886f-21672f415395",""],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1673965826106	1673965826106	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
vft4fyk7agbyefbpiitrbw8nynw	2023-01-17 14:30:26.047826+00	bui5izho7dtn77xg3thkiqprc9r	1	view	List: Bugs 🐞	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"50117d52-bcc7-4750-82aa-831a351c44a0":145,"__title":280},"defaultTemplateId":"","filter":{"filters":[{"condition":"includes","propertyId":"20717ad3-5741-4416-83f1-6f133fff3d11","values":["1fdbb515-edd2-4af5-80fc-437ed2211a49"]}],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["50117d52-bcc7-4750-82aa-831a351c44a0","20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1673965826110	1673965826110	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
a1n8516bmht86ubwgdmmubu3hfe	2023-01-17 14:30:26.047826+00	cmjojddgzgtfr9x4g1gmijo1tmc	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1673965826128	1673965826128	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
ahfu7tjz6e3n8ikszjzc6q6zrfr	2023-01-17 14:30:26.047826+00	cmjojddgzgtfr9x4g1gmijo1tmc	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1673965826134	1673965826134	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
a3mfg6qq8cprquqmszwjfd61mwr	2023-01-17 14:30:26.047826+00	cbe3wtgyhdt8szdh7mbnomnxgic	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1673965826139	1673965826139	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
a5q8ks7a9yt8nxqstczu43jm9xo	2023-01-17 14:30:26.047826+00	cpyuu3sybytgut8j4qn4xwxutre	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1673965826143	1673965826143	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
737wxytzgupyrxre4dcce3smmzy	2023-01-17 14:30:26.047826+00	cfefgwjke6bbxpjpig618g9bpte	1	image		{"fileId":"7pbp4qg415pbstc6enzeicnu3qh.png"}	1673965826159	1673965826159	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
ac77kgj6zr3nzdcw6hfzte3rqxe	2023-01-17 14:30:26.047826+00	cfefgwjke6bbxpjpig618g9bpte	1	text	## Screenshots\nIf applicable, add screenshots to elaborate on the problem.	{}	1673965826177	1673965826177	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
awyd3q9prm3ddzjpsmjj3pejgfe	2023-01-17 14:30:26.047826+00	cfefgwjke6bbxpjpig618g9bpte	1	text	## Steps to reproduce the behavior\n\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n\nA clear and concise description of what you expected to happen.\n\n## Edition and Platform\n\n - Edition: Personal Desktop / Personal Server / Mattermost plugin\n - Version: [e.g. v0.9.0]\n - Browser and OS: [e.g. Chrome 91 on macOS, Edge 93 on Windows]\n\n## Additional context\n\nAdd any other context about the problem here.	{}	1673965826182	1673965826182	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
am4bsyay7z78wt8f8rasx8krq6c	2023-01-17 14:30:26.047826+00	cfefgwjke6bbxpjpig618g9bpte	1	text	## Steps to reproduce the behavior\n\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n\n*[A clear and concise description of what you expected to happen.]*\n\n## Screenshots\n\n*[If applicable, add screenshots to elaborate on the problem.]*\n\n## Edition and Platform\n\n - Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n - Version: *[e.g. v0.9.0]*\n - Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n\n*[Add any other context about the problem here.]*	{}	1673965826186	1673965826186	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
a83j1u6smx3ghjb6uq8h53anq1w	2023-01-17 14:30:26.047826+00	cnfbpr65ex78idc8mxzkbg1af9o	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1673965826193	1673965826193	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
a6jhetye7xtf8megtbhzp3zjb3c	2023-01-17 14:30:26.047826+00	cidz4imnqhir48brz6e8hxhfrhy	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1673965826214	1673965826214	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
aknfoqzfy1ffozy46c9jsyfasqw	2023-01-17 14:30:26.047826+00	cidz4imnqhir48brz6e8hxhfrhy	1	text	## Requirements\n- [Requirement 1]\n- [Requirement 2]\n- ...	{}	1673965826224	1673965826224	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
axakofzpzair1pee8y7wne99aqo	2023-01-17 14:30:26.047826+00	cqpo6e8jq83fzbc5qodyza7h4xo	1	text	## Summary\n*[Brief description of what this epic is about]*\n\n## Motivation\n*[Brief description on why this is needed]*\n\n## Acceptance Criteria\n - *[Criteron 1]*\n - *[Criteron 2]*\n - ...\n\n## Personas\n - *[Persona A]*\n - *[Persona B]*\n - ...\n\n## Reference Materials\n - *[Links to other relevant documents as needed]*\n - ...	{}	1673965826232	1673965826232	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
77mn3imeqqpgi5mmoegdg9mfzow	2023-01-17 14:30:26.047826+00	ctrzp9m4883n6uqf8ddo3ppg8kw	1	image		{"fileId":"7pbp4qg415pbstc6enzeicnu3qh.png"}	1673965826239	1673965826239	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
akp54muj8mbrtbyoswn17bcprky	2023-01-17 14:30:26.047826+00	ctrzp9m4883n6uqf8ddo3ppg8kw	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1673965826244	1673965826244	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
a6pmhwjs5zpfwdr3ygbeo9z43ac	2023-01-17 14:30:26.047826+00	ctrzp9m4883n6uqf8ddo3ppg8kw	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1673965826251	1673965826251	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
aemyu5s95g3nyxkr7jdr7w4p3hh	2023-01-17 14:30:26.047826+00	cwrq9ag3p5pgzzy98nfd3wwra1w	1	text	## Summary\n[Brief description of what this epic is about]\n\n## Motivation\n[Brief description on why this is needed]\n\n## Acceptance Criteria\n - [Criteron 1]\n - [Criteron 2]\n - ...\n\n## Personas\n - [Persona A]\n - [Persona B]\n - ...\n\n## Reference Materials\n - [Links to other relevant documents as needed]\n - ...	{}	1673965826269	1673965826269	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
cfu8j6oqnupyoini7ygti8yboeh	2023-01-17 14:30:26.527051+00	buixxjic3xjfkieees4iafdrznc	1	card	Drag cards	{"contentOrder":["apktbgtee5jb8xrnqy3ibiujxew","aotzma3fj7jb3mkd9qdqyjsngiw"],"icon":"🤏","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#dragging-cards","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1673965826538	1673965826538	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
ax94qnw8bj3dd8nf66fjx7zkxrh	2023-01-17 14:30:26.527051+00	c1c6ht51zaiyymp156jtx5zgsfr	1	text	To share a card, you'll need to copy the card link first. You can:\n\n- Open a card and select the options menu button at the top right of the card.\n- Open the board view and hover your mouse over any card to access the options menu button.	{}	1673965826776	1673965826776	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
ckpdjgzmdmffn5k5rhh1w9zt8qy	2023-01-17 14:30:26.527051+00	buixxjic3xjfkieees4iafdrznc	1	card	Manage tasks with cards	{"contentOrder":["apbnbfbd4s7neik7rjuotwwgb8o","7f3nm7y5nmfb99qjwcgk8dqih3a","7fq671whz9tgh7x489mupem8fkc","784uu3ufcgb878ky7hyugmf6xcw","7g57zni3iipnw9chkfarj7yuk3r","75b1ygdbchpyzjc7pnnxn5mf9ye","7t5mks7dojifwpq5zpq6p6z4yer","7nb8y7jyoetro8cd36qcju53z8c","7ojx4xy4tdinyxr75oytkn5kqoc","7efqjg7e36jgh9yawa7c3n1wmto","76nwb9tqfsid5jx46yw34itqima","7dy3mcgzgybf1ifa3emgewkzj7e","a5ca6tii33bfw8ba36y1rswq3he","7876od6xhffr6fy69zeogag7eyw","7x7bq9awkatbm5x4docbh5gaw4y","7ghpx9qff43dgtke1rwidmge1ho","7nb8y7jyoetro8cd36qcju53z8c","7hdyxemhbytfm3m83g88djq9nhr","7pgnejxokubbe9kdrxj6g9qa41e","7hw9z6qtx8jyizkmm9g5yq3gxcy","7gk6ooz6npbb8by5rgp9aig7tua","753kd51ce9pnh3b9h8o5dsubm1o"],"icon":"☑️","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"amm6wfhnbuxojwssyftgs9dipqe","acypkejeb5yfujhj9te57p9kaxw":"aanaehcw3m13jytujsjk5hpf6ry"}}	1673965826547	1673965826547	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
ci14cqa8ec7d3pdmj5n5frebi6w	2023-01-17 14:30:26.527051+00	buixxjic3xjfkieees4iafdrznc	1	card	Create your own board	{"contentOrder":["ahgtghf83ptnmik6axwit1az7yw","adrz5i3xwmf8odnb9cpu4kwpwtw","7r9my1yuddbn45dojrfht3neg8c","7eir5gdjxgjbsxpbyp3df4npcze","73zdd8fcn5tyq5pqaog1e7qqj3e"],"icon":"📋","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#adding-new-boards","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"amm6wfhnbuxojwssyftgs9dipqe","acypkejeb5yfujhj9te57p9kaxw":"aanaehcw3m13jytujsjk5hpf6ry"}}	1673965826552	1673965826552	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
c3dhsp8oujpd3dpukr53z74icre	2023-01-17 14:30:26.527051+00	buixxjic3xjfkieees4iafdrznc	1	card	Share a board	{"contentOrder":["a898ujqat8jyf8kx6akjsz6pm7r","arzamptbrz7ro3cx54o9kinybmo","7r7asyew8d7fyunf4sow8e5iyoc","ad8j3n8tp77bppee3ipjt6odgpe","7w935usqt6pby8qz9x5pxaj7iow","7ogbs8h6q4j8z7ngy1m7eag63nw","7z1jau5qy3jfcxdp5cgq3duk6ne","7rhxzxym9dtn7dxggm8m4ynbrwe"],"icon":"📤","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/sharing-boards.html","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1673965826558	1673965826558	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
cgcj5hcy4g7rrjfeniqeym9kcbc	2023-01-17 14:30:26.527051+00	buixxjic3xjfkieees4iafdrznc	1	card	Create a new card	{"contentOrder":["a6mycyg9gnpbhi88appsymaipqe","adhsx4h5ss7rqdcjt8xyam6xtqc","azdeaa64e5i88zkgx8uewjdypdw","7me9p46gbqiyfmfnapi7dyxb5br","7cegndysz7ifnuns5wu519x17zr"],"icon":"📝","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#adding-cards","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"amm6wfhnbuxojwssyftgs9dipqe","acypkejeb5yfujhj9te57p9kaxw":"aanaehcw3m13jytujsjk5hpf6ry"}}	1673965826563	1673965826563	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
c1c6ht51zaiyymp156jtx5zgsfr	2023-01-17 14:30:26.527051+00	buixxjic3xjfkieees4iafdrznc	1	card	Share cards on Channels	{"contentOrder":["a8d61nnahmpdsfpercx7jwi8wor","ax94qnw8bj3dd8nf66fjx7zkxrh","asxegfq1wb7fk7bd55xkxfait8o","7eejdg1thpib9pyreu6gy369gwr"],"icon":"📮","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html#share-card-previews","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"af3p8ztcyxgn8wd9z4az7o9tjeh","acypkejeb5yfujhj9te57p9kaxw":"ascd7nm9r491ayot8i86g1gmgqw"}}	1673965826569	1673965826569	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
c5p3r9atiy3yru8xea5d9bbsbty	2023-01-17 14:30:26.527051+00	buixxjic3xjfkieees4iafdrznc	1	card	Filter and sort cards	{"contentOrder":["a4fz9kcfs9ibj8puk9mux7ac94c","akfdht7kxsjgzbfrsmdoz6n6gre","78i8aqjmqtibr7x4okhz6uqquqr","7my578kmydbg39y8shoftqxwaie"],"icon":"🎛️","isTemplate":false,"properties":{"a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1673965826575	1673965826575	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
ckftks9u5m78kmneaz5o47mx7iw	2023-01-17 14:30:26.527051+00	buixxjic3xjfkieees4iafdrznc	1	card	Create a new view	{"contentOrder":["aozbezukpgif3jpbsq7tahmmp5e","aosutffqcdbg7urzcwbiop5yi1c","7owai1ux3h3gtf8byynfk6hyx1c","7n8jq1dizyfgotby3o91arf1hxh","77y4wffj1ctg7xmm9bx45qn6q6o","7e4ztjeyq5frxurczh1py55kzfc"],"icon":"👓","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#adding-new-views","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"af3p8ztcyxgn8wd9z4az7o9tjeh","acypkejeb5yfujhj9te57p9kaxw":"ascd7nm9r491ayot8i86g1gmgqw"}}	1673965826582	1673965826582	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
c89tpotyoxj8ijg478ax1eakkae	2023-01-17 14:30:26.527051+00	buixxjic3xjfkieees4iafdrznc	1	card	Add new properties	{"contentOrder":["a6dgzc58qpjdgmf4hetwannqgrr","ayhk11qsuz789fk8bqae4oz8mro","7gc3z8cf8rirgfyutwoke9nn6jy","76cinqnb6k3dzmfbm9fnc8eofny","745wuyjha7jd79xk9w3gy8rdcxw"],"icon":"🏷️","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html#add-and-manage-properties","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"af3p8ztcyxgn8wd9z4az7o9tjeh","acypkejeb5yfujhj9te57p9kaxw":"ascd7nm9r491ayot8i86g1gmgqw"}}	1673965826589	1673965826589	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
c8gpmwuttbi8uzmrwu1hte1suyr	2023-01-17 14:30:26.527051+00	buixxjic3xjfkieees4iafdrznc	1	card	@mention teammates	{"contentOrder":["a7rczjrgxujgoikedmpgybjn15r","asoxr8btn5t8tffrk5ryfrdt61y","7mbw9t71hjbrydgzgkqqaoh8usr","73xu1gpk5jiruxdog6eurf1ubgh"],"icon":"🔔","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html#mention-people","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1673965826595	1673965826595	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
vzw4rux56gbdztc5kcfeqk9c6ph	2023-01-17 14:30:26.527051+00	buixxjic3xjfkieees4iafdrznc	1	view	Preview: Table View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":280,"a972dc7a-5f4c-45d2-8044-8c28c69717f1":100,"acypkejeb5yfujhj9te57p9kaxw":169},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a972dc7a-5f4c-45d2-8044-8c28c69717f1","aqh13jabwexjkzr3jqsz1i1syew","acmg7mz1rr1eykfug4hcdpb1y1o","acypkejeb5yfujhj9te57p9kaxw"]}	1673965826602	1673965826602	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
vttwjtchsf3butcchiaa1za3pdo	2023-01-17 14:30:26.527051+00	buixxjic3xjfkieees4iafdrznc	1	view	Preview: Calendar View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"acmg7mz1rr1eykfug4hcdpb1y1o","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1673965826607	1673965826607	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
vo6hrpqyuriym5kdg4h67g1tyqc	2023-01-17 14:30:26.527051+00	buixxjic3xjfkieees4iafdrznc	1	view	Onboarding	{"cardOrder":["cgcj5hcy4g7rrjfeniqeym9kcbc","ckpdjgzmdmffn5k5rhh1w9zt8qy","ci14cqa8ec7d3pdmj5n5frebi6w","c1c6ht51zaiyymp156jtx5zgsfr","c89tpotyoxj8ijg478ax1eakkae","ckftks9u5m78kmneaz5o47mx7iw","c8gpmwuttbi8uzmrwu1hte1suyr","cfu8j6oqnupyoini7ygti8yboeh","c3dhsp8oujpd3dpukr53z74icre","c5p3r9atiy3yru8xea5d9bbsbty"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a972dc7a-5f4c-45d2-8044-8c28c69717f1","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["aqb5x3pt87dcc9stbk4ofodrpoy","a1mtm777bkagq3iuu7xo9b13qfr","auxbwzptiqzkii5r61uz3ndsy1r","aj9386k1bx8qwmepeuxg3b7z4pw"],"visiblePropertyIds":[]}	1673965826618	1673965826618	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
aotzma3fj7jb3mkd9qdqyjsngiw	2023-01-17 14:30:26.527051+00	cfu8j6oqnupyoini7ygti8yboeh	1	text	Mattermost Boards makes it easy for you to update certain properties on cards through our drag and drop functionality. Simply drag this card from the **Later** column to the **Completed** column to automatically update the status and mark this task as complete.	{}	1673965826623	1673965826623	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
7g57zni3iipnw9chkfarj7yuk3r	2023-01-17 14:30:26.527051+00	ckpdjgzmdmffn5k5rhh1w9zt8qy	1	checkbox	Assign tasks to teammates	{"value":false}	1673965826628	1673965826628	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
753kd51ce9pnh3b9h8o5dsubm1o	2023-01-17 14:30:26.527051+00	ckpdjgzmdmffn5k5rhh1w9zt8qy	1	checkbox	Create and manage checklists, like this one... :)	{"value":false}	1673965826635	1673965826635	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
75b1ygdbchpyzjc7pnnxn5mf9ye	2023-01-17 14:30:26.527051+00	ckpdjgzmdmffn5k5rhh1w9zt8qy	1	checkbox	Add and update descriptions with Markdown	{"value":false}	1673965826639	1673965826639	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
7ojx4xy4tdinyxr75oytkn5kqoc	2023-01-17 14:30:26.527051+00	ckpdjgzmdmffn5k5rhh1w9zt8qy	1	checkbox	Follow cards to get notified on the latest updates	{"value":false}	1673965826645	1673965826645	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
7f3nm7y5nmfb99qjwcgk8dqih3a	2023-01-17 14:30:26.527051+00	ckpdjgzmdmffn5k5rhh1w9zt8qy	1	checkbox	Set priorities and update statuses	{"value":false}	1673965826652	1673965826652	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
7t5mks7dojifwpq5zpq6p6z4yer	2023-01-17 14:30:26.527051+00	ckpdjgzmdmffn5k5rhh1w9zt8qy	1	checkbox	Provide feedback and ask questions via comments	{"value":false}	1673965826658	1673965826658	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
7efqjg7e36jgh9yawa7c3n1wmto	2023-01-17 14:30:26.527051+00	ckpdjgzmdmffn5k5rhh1w9zt8qy	1	checkbox	@mention teammates so they can follow, and collaborate on, comments and descriptions	{"value":false}	1673965826667	1673965826667	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
7fq671whz9tgh7x489mupem8fkc	2023-01-17 14:30:26.527051+00	ckpdjgzmdmffn5k5rhh1w9zt8qy	1	checkbox	Manage deadlines and milestones	{"value":false}	1673965826676	1673965826676	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
apbnbfbd4s7neik7rjuotwwgb8o	2023-01-17 14:30:26.527051+00	ckpdjgzmdmffn5k5rhh1w9zt8qy	1	text	Cards allow your entire team to manage and collaborate on a task in one place. Within a card, your team can:	{}	1673965826679	1673965826679	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
73zdd8fcn5tyq5pqaog1e7qqj3e	2023-01-17 14:30:26.527051+00	ci14cqa8ec7d3pdmj5n5frebi6w	1	image		{"fileId":"74uia99m9btr8peydw7oexn37tw.gif"}	1673965826682	1673965826682	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
ahgtghf83ptnmik6axwit1az7yw	2023-01-17 14:30:26.527051+00	ci14cqa8ec7d3pdmj5n5frebi6w	1	text	A board helps you manage your project, organize tasks, and collaborate with your team all in one place.	{}	1673965826684	1673965826684	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
adrz5i3xwmf8odnb9cpu4kwpwtw	2023-01-17 14:30:26.527051+00	ci14cqa8ec7d3pdmj5n5frebi6w	1	text	To create your own board, select the "+" on the top of the left hand sidebar. Choose from one of our standard templates and see how they can help you get started with your next project:\n\n- **Project Tasks**: Stay on top of your project tasks, track progress, and set priorities. \n- **Meeting Agenda**: Set your meeting agendas for recurring team meetings and 1:1s.\n- **Roadmap**: Plan your roadmap and manage your releases more efficiently.\n- **Personal Tasks**: Organize your life and track your personal tasks.\n- **Content Calendar**: Plan your editorial content, assign work, and track deadlines.\n- **Personal Goals**: Set and accomplish new personal goals and milestones.	{}	1673965826698	1673965826698	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
7rhxzxym9dtn7dxggm8m4ynbrwe	2023-01-17 14:30:26.527051+00	c3dhsp8oujpd3dpukr53z74icre	1	image		{"fileId":"7knxbyuiedtdafcgmropgkrtybr.gif"}	1673965826724	1673965826724	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
a898ujqat8jyf8kx6akjsz6pm7r	2023-01-17 14:30:26.527051+00	c3dhsp8oujpd3dpukr53z74icre	1	text	Keep stakeholders and customers up-to-date on project progress by sharing your board.	{}	1673965826738	1673965826738	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
arzamptbrz7ro3cx54o9kinybmo	2023-01-17 14:30:26.527051+00	c3dhsp8oujpd3dpukr53z74icre	1	text	To share a board, select **Share** at the top right of the Board view. Copy the link to share the board internally with your team or generate public link that can be accessed by anyone externally.	{}	1673965826748	1673965826748	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
7cegndysz7ifnuns5wu519x17zr	2023-01-17 14:30:26.527051+00	cgcj5hcy4g7rrjfeniqeym9kcbc	1	image		{"fileId":"7iw4rxx7jj7bypmdotd9z469cyh.png"}	1673965826752	1673965826752	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
azdeaa64e5i88zkgx8uewjdypdw	2023-01-17 14:30:26.527051+00	cgcj5hcy4g7rrjfeniqeym9kcbc	1	text	To create a new card, simply do any of the following:\n- Select "**New**" on the top right header\n- Select "**+ New**" below any column\n- Select "**+**" to the right of any columnn header	{}	1673965826755	1673965826755	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
asxegfq1wb7fk7bd55xkxfait8o	2023-01-17 14:30:26.527051+00	c1c6ht51zaiyymp156jtx5zgsfr	1	text	After you've copied the link, paste it into any channel or Direct Message to share the card. A preview of the card will display within the channel with a link back to the card on Boards.	{}	1673965826773	1673965826773	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
a8d61nnahmpdsfpercx7jwi8wor	2023-01-17 14:30:26.527051+00	c1c6ht51zaiyymp156jtx5zgsfr	1	text	Cards can be linked and shared with teammates directly on Channels. Card previews are displayed when shared on Channels, so your team can discuss work items and get the relevant context without having to switch over to Boards.	{}	1673965826782	1673965826782	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
7my578kmydbg39y8shoftqxwaie	2023-01-17 14:30:26.527051+00	c5p3r9atiy3yru8xea5d9bbsbty	1	image		{"fileId":"7dybb6t8fj3nrdft7nerhuf784y.png"}	1673965826804	1673965826804	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
akfdht7kxsjgzbfrsmdoz6n6gre	2023-01-17 14:30:26.527051+00	c5p3r9atiy3yru8xea5d9bbsbty	1	text	Organize and find the cards you're looking for with our filter, sort, and grouping options. From the Board header, you can quickly toggle on different properties, change the group display, set filters, and change how the cards are sorted.	{}	1673965826809	1673965826809	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
7e4ztjeyq5frxurczh1py55kzfc	2023-01-17 14:30:26.527051+00	ckftks9u5m78kmneaz5o47mx7iw	1	image		{"fileId":"78jws5m1myf8pufewzkaa6i11sc.gif"}	1673965826834	1673965826834	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
aosutffqcdbg7urzcwbiop5yi1c	2023-01-17 14:30:26.527051+00	ckftks9u5m78kmneaz5o47mx7iw	1	text	Views allow your team to visualize the same cards and data from different perspectives, so they can stay up-to-date in the way that works best for them. To add a new view, go to **Add a new view** from the view drop-down, then select from any of the following views:\n\n- **Board**: Adds a Kanban board, similar to this one, that allows your team to organize cards in swimlanes grouped by any property of your choosing. This view helps you visualize your project progress.\n- **Table**: Displays cards in a table format with rows and columns. Use this view to get an overview of all your project tasks. Easily view and compare the state of all properties across all cards without needing to open individual cards.\n- **Gallery**: Displays cards in a gallery format, so you can manage and organize cards with image attachments.\n- **Calendar**: Adds a calendar view to easily visualize your cards by dates and keep track of deadlines.	{}	1673965826837	1673965826837	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
745wuyjha7jd79xk9w3gy8rdcxw	2023-01-17 14:30:26.527051+00	c89tpotyoxj8ijg478ax1eakkae	1	image		{"fileId":"7d6hrtig3zt8f9cnbo1um5oxx3y.gif"}	1673965826842	1673965826842	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
a6dgzc58qpjdgmf4hetwannqgrr	2023-01-17 14:30:26.527051+00	c89tpotyoxj8ijg478ax1eakkae	1	text	Customize cards to fit your needs and track the information most important to you. Boards supports a wide range of fully customizable property types. For example, you can:\n- Use the **Date** property for things like deadlines or milestones.\n- Assign owners to tasks with the **Person** property.\n- Define statuses and priorities with the **Select** property.\n- Create tags with the **Multi Select** property.\n- Link cards to webpages with the **URL** property.	{}	1673965826845	1673965826845	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
73xu1gpk5jiruxdog6eurf1ubgh	2023-01-17 14:30:26.527051+00	c8gpmwuttbi8uzmrwu1hte1suyr	1	image		{"fileId":"74nt9eqzea3ydjjpgjtsxcjgrxc.gif"}	1673965826873	1673965826873	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
asoxr8btn5t8tffrk5ryfrdt61y	2023-01-17 14:30:26.527051+00	c8gpmwuttbi8uzmrwu1hte1suyr	1	text	To mention a teammate use the **@ symbol with their username** in the comments or description section. They'll get a Direct Message notification via Channels and also be added as a [follower](https://docs.mattermost.com/boards/work-with-cards.html#receive-updates) to the card. \n\nWhenever any changes are made to the card, they'll automatically get notified on Channels.	{}	1673965826883	1673965826883	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
a7rczjrgxujgoikedmpgybjn15r	2023-01-17 14:30:26.527051+00	c8gpmwuttbi8uzmrwu1hte1suyr	1	text	Collaborate with teammates directly on each card using @mentions and have all the relevant context in one place.	{}	1673965826886	1673965826886	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
\.


--
-- Data for Name: focalboard_blocks_history; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_blocks_history (id, insert_at, parent_id, schema, type, title, fields, create_at, update_at, delete_at, root_id, modified_by, channel_id, created_by, board_id) FROM stdin;
ciwp7htn7strcfb6x6jummtqcre	2023-01-17 14:30:21.922829+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Team Schedule	{"contentOrder":["ag5yd49ddubyg7p4o1uh1yqtn8r","7aogktzf8c38x9ytux6p37isxie","abrc9cnrk6tfwjg4m3d8g8rpb7w","7xco9wosbhjreiqs3ddn4yh3pir","7jkshqesxtpnn38bc7ydjzcwpmr","7qjnd15spuif9tgzdso9eqf1qja"],"icon":"⏰","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"8b05c83e-a44a-4d04-831e-97f01d8e2003","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"34eb9c25-d5bf-49d9-859e-f74f4e0030e7"}}	1673965821937	1673965821937	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
cdm7adft76tdtjrydoxjnif4p8y	2023-01-17 14:30:21.922829+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Video production	{"contentOrder":["autjd9uyypfdazfagneb35j7b6y","76zruzbprtfypppgskjzszgb63e","ataig68tpy3fo7qw5mdfdwofwgh","77okzej4urtdx3k97gccx83afyc","7bui9mgdqm3ygtkfih4dd1bmwwh","77sg6hmt63385bcdhzfe7uckbjh"],"icon":"📹","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"b1abafbf-a038-4a19-8b68-56e0fd2319f7","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"34eb9c25-d5bf-49d9-859e-f74f4e0030e7"}}	1673965821946	1673965821946	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
cfoaipyhu97yt9pzhoz35d5r9by	2023-01-17 14:30:21.922829+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Offsite plans	{"contentOrder":["aj6chr8faf78f8k4krocuoam1cr","7cireohxwnjg4zy53qokogsghir","atqngytobziyzpyaw3x6aw8rqbe","78ncuyso5j3rai8oh5o6auhje5c","7hq7f64kag7b6dc1u38npftd5oo","7d6csj67odf8tpduqpkcenq1q4h"],"icon":"🚙","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"8b05c83e-a44a-4d04-831e-97f01d8e2003","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"dabadd9b-adf1-4d9f-8702-805ac6cef602"}}	1673965821952	1673965821952	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
c138xdxrczjfuidn8kf7633ddoy	2023-01-17 14:30:21.922829+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Social Media Strategy	{"contentOrder":["akmcci8p8sjbd5fca3n94rqathe","71mtcnejj3jdh58p3h4i999gzdy","atnibwzraabnizbu1c19fwjy8ew","74775cqcg93r8xbtdmbpobpwnhr","745b6gu9saf8wzrxeuh36e4bqio","7eu8m8wep9p8xiksj19p7wxpitw"],"icon":"🎉","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"b1abafbf-a038-4a19-8b68-56e0fd2319f7","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"d37a61f4-f332-4db9-8b2d-5e0a91aa20ed"}}	1673965821959	1673965821959	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
vzgb9dheqcbd1uqqkr3fhmh9ebh	2023-01-17 14:30:21.922829+00	b7wnw9awd4pnefryhq51apbzb4c	1	view	Discussion Items	{"cardOrder":["cjpkiya33qsagr4f9hrdwhgiajc"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"d777ba3b-8728-40d1-87a6-59406bbbbfb0","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[{"propertyId":"4cf1568d-530f-4028-8ffd-bdc65249187e","reversed":false}],"viewType":"board","visibleOptionIds":[],"visiblePropertyIds":["4cf1568d-530f-4028-8ffd-bdc65249187e"]}	1673965821966	1673965821966	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
7jkshqesxtpnn38bc7ydjzcwpmr	2023-01-17 14:30:21.922829+00	ciwp7htn7strcfb6x6jummtqcre	1	checkbox		{"value":false}	1673965821976	1673965821976	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
7xco9wosbhjreiqs3ddn4yh3pir	2023-01-17 14:30:21.922829+00	ciwp7htn7strcfb6x6jummtqcre	1	checkbox		{"value":false}	1673965821983	1673965821983	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
7aogktzf8c38x9ytux6p37isxie	2023-01-17 14:30:21.922829+00	ciwp7htn7strcfb6x6jummtqcre	1	divider		{}	1673965821988	1673965821988	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
7qjnd15spuif9tgzdso9eqf1qja	2023-01-17 14:30:21.922829+00	ciwp7htn7strcfb6x6jummtqcre	1	checkbox		{"value":false}	1673965821995	1673965821994	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
ag5yd49ddubyg7p4o1uh1yqtn8r	2023-01-17 14:30:21.922829+00	ciwp7htn7strcfb6x6jummtqcre	1	text	## Notes\n*[Add meeting notes here]*	{}	1673965822000	1673965822000	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
abrc9cnrk6tfwjg4m3d8g8rpb7w	2023-01-17 14:30:21.922829+00	ciwp7htn7strcfb6x6jummtqcre	1	text	## Action Items	{}	1673965822005	1673965822005	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
7xqx11ymuntnzpry81fsqrfmdqy	2023-01-17 14:30:21.922829+00	ch798q5ucefyobf5bymgqjt4f3h	1	divider		{}	1673965822010	1673965822010	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
7f6np7oqeoir3xf58xk7yrd3foa	2023-01-17 14:30:21.922829+00	ch798q5ucefyobf5bymgqjt4f3h	1	checkbox		{"value":false}	1673965822015	1673965822015	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
7dfqkkxosgb8tzpubhcoqf78e7w	2023-01-17 14:30:21.922829+00	ch798q5ucefyobf5bymgqjt4f3h	1	checkbox		{"value":false}	1673965822019	1673965822019	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
7n1x4rz87p38i3rywza1zz9gk9e	2023-01-17 14:30:21.922829+00	ch798q5ucefyobf5bymgqjt4f3h	1	checkbox		{"value":false}	1673965822025	1673965822025	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
actcefa5npfbajngq7wmmxhpenc	2023-01-17 14:30:21.922829+00	ch798q5ucefyobf5bymgqjt4f3h	1	text	# Action Items	{}	1673965822032	1673965822032	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
abhkoi31zejy77p9m5tso1ew9je	2023-01-17 14:30:21.922829+00	ch798q5ucefyobf5bymgqjt4f3h	1	text	# Notes\n*[Add meeting notes here]*	{}	1673965822037	1673965822037	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
76zruzbprtfypppgskjzszgb63e	2023-01-17 14:30:21.922829+00	cdm7adft76tdtjrydoxjnif4p8y	1	divider		{}	1673965822043	1673965822043	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
77sg6hmt63385bcdhzfe7uckbjh	2023-01-17 14:30:21.922829+00	cdm7adft76tdtjrydoxjnif4p8y	1	checkbox		{"value":false}	1673965822056	1673965822056	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
7bui9mgdqm3ygtkfih4dd1bmwwh	2023-01-17 14:30:21.922829+00	cdm7adft76tdtjrydoxjnif4p8y	1	checkbox		{"value":false}	1673965822073	1673965822073	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
77okzej4urtdx3k97gccx83afyc	2023-01-17 14:30:21.922829+00	cdm7adft76tdtjrydoxjnif4p8y	1	checkbox		{"value":false}	1673965822078	1673965822078	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
ataig68tpy3fo7qw5mdfdwofwgh	2023-01-17 14:30:21.922829+00	cdm7adft76tdtjrydoxjnif4p8y	1	text	## Action Items	{}	1673965822082	1673965822082	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
autjd9uyypfdazfagneb35j7b6y	2023-01-17 14:30:21.922829+00	cdm7adft76tdtjrydoxjnif4p8y	1	text	## Notes\n*[Add meeting notes here]*	{}	1673965822087	1673965822087	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
78ncuyso5j3rai8oh5o6auhje5c	2023-01-17 14:30:21.922829+00	cfoaipyhu97yt9pzhoz35d5r9by	1	checkbox		{"value":false}	1673965822096	1673965822096	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
7hq7f64kag7b6dc1u38npftd5oo	2023-01-17 14:30:21.922829+00	cfoaipyhu97yt9pzhoz35d5r9by	1	checkbox		{"value":false}	1673965822101	1673965822100	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
7cireohxwnjg4zy53qokogsghir	2023-01-17 14:30:21.922829+00	cfoaipyhu97yt9pzhoz35d5r9by	1	divider		{}	1673965822111	1673965822111	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
7d6csj67odf8tpduqpkcenq1q4h	2023-01-17 14:30:21.922829+00	cfoaipyhu97yt9pzhoz35d5r9by	1	checkbox		{"value":false}	1673965822115	1673965822115	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
atqngytobziyzpyaw3x6aw8rqbe	2023-01-17 14:30:21.922829+00	cfoaipyhu97yt9pzhoz35d5r9by	1	text	## Action Items	{}	1673965822121	1673965822121	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
aj6chr8faf78f8k4krocuoam1cr	2023-01-17 14:30:21.922829+00	cfoaipyhu97yt9pzhoz35d5r9by	1	text	## Notes\n*[Add meeting notes here]*	{}	1673965822128	1673965822128	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
71mtcnejj3jdh58p3h4i999gzdy	2023-01-17 14:30:21.922829+00	c138xdxrczjfuidn8kf7633ddoy	1	divider		{}	1673965822133	1673965822133	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
745b6gu9saf8wzrxeuh36e4bqio	2023-01-17 14:30:21.922829+00	c138xdxrczjfuidn8kf7633ddoy	1	checkbox		{"value":false}	1673965822139	1673965822139	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
7eu8m8wep9p8xiksj19p7wxpitw	2023-01-17 14:30:21.922829+00	c138xdxrczjfuidn8kf7633ddoy	1	checkbox		{"value":false}	1673965822145	1673965822145	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
74775cqcg93r8xbtdmbpobpwnhr	2023-01-17 14:30:21.922829+00	c138xdxrczjfuidn8kf7633ddoy	1	checkbox		{"value":false}	1673965822150	1673965822150	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
atnibwzraabnizbu1c19fwjy8ew	2023-01-17 14:30:21.922829+00	c138xdxrczjfuidn8kf7633ddoy	1	text	## Action Items	{}	1673965822155	1673965822155	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
akmcci8p8sjbd5fca3n94rqathe	2023-01-17 14:30:21.922829+00	c138xdxrczjfuidn8kf7633ddoy	1	text	## Notes\n*[Add meeting notes here]*	{}	1673965822160	1673965822160	0	\N	system		system	bdt9z31x7mpryx8y7ocrkepnn8a
vcfd8fwfdi7fnibebud3nzeffdw	2023-01-17 14:30:22.437069+00		1	view	All Contacts	{"cardOrder":["crn69z85umjbxtqbk7nj6rne4ic","c8x67gy9xepfxzptgxzt8wgytzr","c7nxcehxnbtrmde6gsb4zqpjq4r","cudjd3axpfpf35dche43a1mbhma","cosmtosxa73bw5p1t1cohy4ks8a"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":240,"a1438fbbhjeffkexmcfhnx99o1h":151,"a5hwxjsmkn6bak6r7uea5bx1kwc":132,"abru6tz8uebdxy4skheqidh7zxy":247,"adtf1151chornmihz4xbgbk9exa":125,"aejo5tcmq54bauuueem9wc4fw4y":127,"ahf43e44h3y8ftanqgzno9z7q7w":129,"ainpw47babwkpyj77ic4b9zq9xr":157,"amahgyn9n4twaapg3jyxb6y4jic":224,"amba7ot98fh7hwsx8jdcfst5g7h":171,"aoheuj1f3mu6eehygr45fxa144y":130,"auhf91pm85f73swwidi4wid8jqe":157},"defaultTemplateId":"c1zr4ry1y9fdsmpdxyu4i5n8ieo","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a5hwxjsmkn6bak6r7uea5bx1kwc","aoheuj1f3mu6eehygr45fxa144y","aro91wme9kfaie5ceu9qasmtcnw","ainpw47babwkpyj77ic4b9zq9xr","ahf43e44h3y8ftanqgzno9z7q7w","amahgyn9n4twaapg3jyxb6y4jic","abru6tz8uebdxy4skheqidh7zxy","a1438fbbhjeffkexmcfhnx99o1h","auhf91pm85f73swwidi4wid8jqe","adtf1151chornmihz4xbgbk9exa","aejo5tcmq54bauuueem9wc4fw4y","amba7ot98fh7hwsx8jdcfst5g7h"]}	1673965822453	1673965822453	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
v6dam9wyi4fyw8qwotdh4q86fkc	2023-01-17 14:30:22.437069+00		1	view	Pipeline Tracker	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["akj61wc9yxdwyw3t6m8igyf9d5o","aic89a5xox4wbppi6mbyx6ujsda","ah6ehh43rwj88jy4awensin8pcw","aprhd96zwi34o9cs4xyr3o9sf3c","axesd74yuxtbmw1sbk8ufax7z3a","a5txuiubumsmrs8gsd5jz5gc1oa","acm9q494bcthyoqzmfogxxy5czy"],"visiblePropertyIds":["aro91wme9kfaie5ceu9qasmtcnw","amahgyn9n4twaapg3jyxb6y4jic"]}	1673965822462	1673965822462	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
cudjd3axpfpf35dche43a1mbhma	2023-01-17 14:30:22.437069+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Jonathan Frazier	{"contentOrder":["afthufxrpufnfpqgs9ukt6mh61h","agh64gmmhmpfszq9y5fkf3sdoie","75ygzpukfp3d9pd4hg7gmsyns5y","7ajczotzwufg5pmogr6x6wr7fpe","74hum7x8dt3y8xj5jjqm58siqoe","7ektofrqr73b8pn6hb5ri4b41fh","755ofpmqahbynmqfd5wky9n4kie","74p999ukr6igq9ghrtys7r7puqo","7st7hn7uxtbnjjbefcmntesofxc","7qnakgtdgppym5ptehjhoc7nw5y","7q9pg9x1cejnezxuh1gq5i6iqgh","7rt179h6mqpfa9eqktqyig4fcur"],"icon":"🙎‍♂️","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(999) 123-5678","a5hwxjsmkn6bak6r7uea5bx1kwc":"a5txuiubumsmrs8gsd5jz5gc1oa","abru6tz8uebdxy4skheqidh7zxy":"jonathan.frazier@email.com","aejo5tcmq54bauuueem9wc4fw4y":"0%","ahf43e44h3y8ftanqgzno9z7q7w":"$800,000","ainpw47babwkpyj77ic4b9zq9xr":"Ositions Inc.","amahgyn9n4twaapg3jyxb6y4jic":"as5bk6afoaaa7caewe1zc391sce","aro91wme9kfaie5ceu9qasmtcnw":"apiswzj7uiwbh87z8dw8c6mturw","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1669118400000}"}}	1673965822469	1673965822469	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
c7nxcehxnbtrmde6gsb4zqpjq4r	2023-01-17 14:30:22.437069+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Richard Guzman	{"contentOrder":["aroqaaui77bbhfe5d31g5yoonxh","a771mgefirbgzux3k3dgtc35pho","7nmczue3dnty7dn1mp6g9udpffy","73z9ect9o1fr15cx36ju3y16y1a","71xg1cm3hct8x3dm5pfsb1mtkfw","7zowyocezgbbfxxqefga7c5mqww","7buzfau6q5prkmxoorii5abam9w","7gpmwybbxgpdyxc9z1uhkkhnz7w","71txyexmzotn89dcxqrq383o38e","7gecsxrtt5pn47dmhkcpfoc7h4a","7qbry9x9cztno5bgf38j56bktsc","7pp7sopttf3dkzei65d5rguytqh"],"icon":"👨‍💼","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(222) 123-1234","a5hwxjsmkn6bak6r7uea5bx1kwc":"axesd74yuxtbmw1sbk8ufax7z3a","abru6tz8uebdxy4skheqidh7zxy":"richard.guzman@email.com","adtf1151chornmihz4xbgbk9exa":"{\\"from\\":1681992000000}","aejo5tcmq54bauuueem9wc4fw4y":"80%","ahf43e44h3y8ftanqgzno9z7q7w":"$3,200,000","ainpw47babwkpyj77ic4b9zq9xr":"Afformance Ltd.","amahgyn9n4twaapg3jyxb6y4jic":"ar6t1ttcumgfuqugg5o4g4mzrza","aro91wme9kfaie5ceu9qasmtcnw":"apjnaggwixchfxwiatfh7ey7uno","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1667476800000}"}}	1673965822476	1673965822476	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
cosmtosxa73bw5p1t1cohy4ks8a	2023-01-17 14:30:22.437069+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Byron Cole	{"contentOrder":["ahxaszp31f3yhjjo19eu3544z8o","ajwdcjesu5jy1ugwep9q4g1an1h","78fbar4fyg7bc3gigp3pj1m8gkr","7i1kqqtiz87bbumih14rrewqk9h","7rbokobjh9bnc5ctprmksycxiec","7jre9ywhr4jybdp1kmt5oz4rwww","748ofm3bwk3rytfshqau13iazsw","77equnzy4qigcj8xwb66wqhraoh","7cdxopq4bpinpina7u3njzjw8da","7o9qnzhanjt8pxf8pe4xmk3gn7r","7amc5xqsac3g1jmft5q9ukprzur","791t7xpee5jbn9rxwf5uee5196c"],"icon":"🤵","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(333) 123-1234","a5hwxjsmkn6bak6r7uea5bx1kwc":"acm9q494bcthyoqzmfogxxy5czy","abru6tz8uebdxy4skheqidh7zxy":"byron.cole@email.com","adtf1151chornmihz4xbgbk9exa":"{\\"from\\":1667563200000}","aejo5tcmq54bauuueem9wc4fw4y":"100%","ahf43e44h3y8ftanqgzno9z7q7w":"$500,000","ainpw47babwkpyj77ic4b9zq9xr":"Helx Industries","amahgyn9n4twaapg3jyxb6y4jic":"aafwyza5iwdcwcyfyj6bp7emufw","aro91wme9kfaie5ceu9qasmtcnw":"apjnaggwixchfxwiatfh7ey7uno","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1667822400000}"}}	1673965822483	1673965822483	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7qbry9x9cztno5bgf38j56bktsc	2023-01-17 14:30:22.437069+00	c7nxcehxnbtrmde6gsb4zqpjq4r	1	checkbox	Hand-off to customer success	{}	1673965822617	1673965822617	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7gecsxrtt5pn47dmhkcpfoc7h4a	2023-01-17 14:30:22.437069+00	c7nxcehxnbtrmde6gsb4zqpjq4r	1	checkbox	Finalize contract	{}	1673965822622	1673965822622	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7pp7sopttf3dkzei65d5rguytqh	2023-01-17 14:30:22.437069+00	c7nxcehxnbtrmde6gsb4zqpjq4r	1	checkbox	Post-sales follow up	{}	1673965822627	1673965822627	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
c8x67gy9xepfxzptgxzt8wgytzr	2023-01-17 14:30:22.437069+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Caitlyn Russel	{"contentOrder":["ah64hewt1iffsfb3b9gjggcde9h","affik4pq6mpn8zqjc9prdrhtq3c","7mtji9sd7zf8puqfe5subkm9i1r","7xjcp7osgobbh7xtaeuqdri5zfa","799fwf5a49tba8x615kcfwuprge","75s6bgegkrpgdibowmmcr4dk6sy","7cj4p6dnqxidqufbpmmci3tqofw","7a655j9kehi8fjxrj7k6c6kuooe","7wbkktsfo73gkzgj8t7bx94y1ce","7ca85myg8p3y9fmwsrxzxe6qxer","7ddzqqhzbx7yxbcqk7iikeuch5o","7jmhxnwpux3gyipyj3a3iarpgzr"],"icon":"🧑‍💼","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(111) 123-1234","a5hwxjsmkn6bak6r7uea5bx1kwc":"ah6ehh43rwj88jy4awensin8pcw","abru6tz8uebdxy4skheqidh7zxy":"caitlyn.russel@email.com","adtf1151chornmihz4xbgbk9exa":"{\\"from\\":1689336000000}","aejo5tcmq54bauuueem9wc4fw4y":"20%","ahf43e44h3y8ftanqgzno9z7q7w":"$250,000","ainpw47babwkpyj77ic4b9zq9xr":"Liminary Corp.","amahgyn9n4twaapg3jyxb6y4jic":"aafwyza5iwdcwcyfyj6bp7emufw","aro91wme9kfaie5ceu9qasmtcnw":"apiswzj7uiwbh87z8dw8c6mturw","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1668168000000}"}}	1673965822491	1673965822491	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
c1zr4ry1y9fdsmpdxyu4i5n8ieo	2023-01-17 14:30:22.437069+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	New Prospect	{"contentOrder":["adi6x775bujrgmyqscpt3c93xxe","ax1x8sw6gnpbb5m3e83md6x1b1c","7oq53yacgn78e9mgw7rtyh8bhzy","7n5erteor5bdgmbdgbgpeptb38w","7y6nw38oywtbg9xypjquugqkhyy","7o4sc444ekir73ysppiq9uhwm4o","7hruqoce41pd37k6jx3x8tthr1r","7ndxi8gb593n6zyc7bdnehbfwoo","76g3pktsh4bf97ycyx1p44reytc","7f4oxkpqy7brgjnei6zmnft7qno","73io7mjdtgj8ifnr96dm7cz7eia","79rae1r6dwidwxftw7s43cd77kh"],"icon":"👤","isTemplate":true,"properties":{"a5hwxjsmkn6bak6r7uea5bx1kwc":"akj61wc9yxdwyw3t6m8igyf9d5o"}}	1673965822499	1673965822499	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
crn69z85umjbxtqbk7nj6rne4ic	2023-01-17 14:30:22.437069+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Shelby Olson	{"contentOrder":["aiepiz4odbbdt3d3e55dcpqjsdc","a4jxu74p6z3gpfeixwpc4pwd47w","7866hyr5143rk9q3q5zrtkn17er","743pmufq1tfdutbmurn5bx7rzor","73j6remhzifrhbm4irkc9nc1c3e","7wqbg84e4ab8rzdqoqun3yhwp8a","7jreh9zg4kfgq9gd6kza7ty6jqr","7f8tsoayeeig63nwym8u6o458bw","7jkepmbfsnj8m5xtddh4tyfot7o","7zhgzabkydiyszk1tfz5ggbszby","7zqi73bttx3fuiqjydosrjnu3hr","7pxag7ngrabyk3kf4rzhc89k1bh"],"icon":"🙎‍♀️","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(111) 321-5678","a5hwxjsmkn6bak6r7uea5bx1kwc":"akj61wc9yxdwyw3t6m8igyf9d5o","abru6tz8uebdxy4skheqidh7zxy":"shelby.olson@email.com","ahf43e44h3y8ftanqgzno9z7q7w":"$30,000","ainpw47babwkpyj77ic4b9zq9xr":"Kadera Global","amahgyn9n4twaapg3jyxb6y4jic":"ar6t1ttcumgfuqugg5o4g4mzrza","aro91wme9kfaie5ceu9qasmtcnw":"auu9bfzqeuruyjwzzqgz7q8apuw","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1669291200000}"}}	1673965822505	1673965822505	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
vrzf5mg7nutfe88y1zc4zuaskgr	2023-01-17 14:30:22.437069+00	bzwb99zf498tsm7mjqbiy7g81ze	1	view	Open Deals	{"cardOrder":["c8x67gy9xepfxzptgxzt8wgytzr"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[{"condition":"includes","propertyId":"a5hwxjsmkn6bak6r7uea5bx1kwc","values":["akj61wc9yxdwyw3t6m8igyf9d5o","aic89a5xox4wbppi6mbyx6ujsda","ah6ehh43rwj88jy4awensin8pcw","aprhd96zwi34o9cs4xyr3o9sf3c","axesd74yuxtbmw1sbk8ufax7z3a"]}],"operation":"and"},"groupById":"aro91wme9kfaie5ceu9qasmtcnw","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["apjnaggwixchfxwiatfh7ey7uno","apiswzj7uiwbh87z8dw8c6mturw","auu9bfzqeuruyjwzzqgz7q8apuw",""],"visiblePropertyIds":[]}	1673965822512	1673965822512	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
75ygzpukfp3d9pd4hg7gmsyns5y	2023-01-17 14:30:22.437069+00	cudjd3axpfpf35dche43a1mbhma	1	checkbox	Send initial email	{"value":true}	1673965822518	1673965822518	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7ajczotzwufg5pmogr6x6wr7fpe	2023-01-17 14:30:22.437069+00	cudjd3axpfpf35dche43a1mbhma	1	checkbox	Send follow-up email	{"value":true}	1673965822525	1673965822525	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7st7hn7uxtbnjjbefcmntesofxc	2023-01-17 14:30:22.437069+00	cudjd3axpfpf35dche43a1mbhma	1	checkbox	Send proposal	{"value":true}	1673965822533	1673965822533	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7qnakgtdgppym5ptehjhoc7nw5y	2023-01-17 14:30:22.437069+00	cudjd3axpfpf35dche43a1mbhma	1	checkbox	Finalize contract	{}	1673965822545	1673965822545	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
74hum7x8dt3y8xj5jjqm58siqoe	2023-01-17 14:30:22.437069+00	cudjd3axpfpf35dche43a1mbhma	1	checkbox	Schedule initial sales call	{"value":true}	1673965822551	1673965822551	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
755ofpmqahbynmqfd5wky9n4kie	2023-01-17 14:30:22.437069+00	cudjd3axpfpf35dche43a1mbhma	1	checkbox	Schedule demo	{"value":true}	1673965822560	1673965822560	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7q9pg9x1cejnezxuh1gq5i6iqgh	2023-01-17 14:30:22.437069+00	cudjd3axpfpf35dche43a1mbhma	1	checkbox	Hand-off to customer success	{}	1673965822567	1673965822567	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
74p999ukr6igq9ghrtys7r7puqo	2023-01-17 14:30:22.437069+00	cudjd3axpfpf35dche43a1mbhma	1	checkbox	Follow up after demo	{"value":true}	1673965822573	1673965822573	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7ektofrqr73b8pn6hb5ri4b41fh	2023-01-17 14:30:22.437069+00	cudjd3axpfpf35dche43a1mbhma	1	checkbox	Schedule follow-up sales call	{"value":true}	1673965822579	1673965822579	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7rt179h6mqpfa9eqktqyig4fcur	2023-01-17 14:30:22.437069+00	cudjd3axpfpf35dche43a1mbhma	1	checkbox	Post-sales follow up	{}	1673965822583	1673965822583	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
agh64gmmhmpfszq9y5fkf3sdoie	2023-01-17 14:30:22.437069+00	cudjd3axpfpf35dche43a1mbhma	1	text	## Checklist	{}	1673965822587	1673965822587	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
afthufxrpufnfpqgs9ukt6mh61h	2023-01-17 14:30:22.437069+00	cudjd3axpfpf35dche43a1mbhma	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1673965822593	1673965822593	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7nmczue3dnty7dn1mp6g9udpffy	2023-01-17 14:30:22.437069+00	c7nxcehxnbtrmde6gsb4zqpjq4r	1	checkbox	Send initial email	{"value":true}	1673965822598	1673965822598	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7zowyocezgbbfxxqefga7c5mqww	2023-01-17 14:30:22.437069+00	c7nxcehxnbtrmde6gsb4zqpjq4r	1	checkbox	Schedule follow-up sales call	{"value":true}	1673965822602	1673965822602	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7gpmwybbxgpdyxc9z1uhkkhnz7w	2023-01-17 14:30:22.437069+00	c7nxcehxnbtrmde6gsb4zqpjq4r	1	checkbox	Follow up after demo	{"value":true}	1673965822607	1673965822607	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
71txyexmzotn89dcxqrq383o38e	2023-01-17 14:30:22.437069+00	c7nxcehxnbtrmde6gsb4zqpjq4r	1	checkbox	Send proposal	{"value":true}	1673965822613	1673965822613	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7buzfau6q5prkmxoorii5abam9w	2023-01-17 14:30:22.437069+00	c7nxcehxnbtrmde6gsb4zqpjq4r	1	checkbox	Schedule demo	{"value":true}	1673965822631	1673965822631	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
71xg1cm3hct8x3dm5pfsb1mtkfw	2023-01-17 14:30:22.437069+00	c7nxcehxnbtrmde6gsb4zqpjq4r	1	checkbox	Schedule initial sales call	{"value":true}	1673965822636	1673965822636	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
73z9ect9o1fr15cx36ju3y16y1a	2023-01-17 14:30:22.437069+00	c7nxcehxnbtrmde6gsb4zqpjq4r	1	checkbox	Send follow-up email	{"value":true}	1673965822640	1673965822640	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
aroqaaui77bbhfe5d31g5yoonxh	2023-01-17 14:30:22.437069+00	c7nxcehxnbtrmde6gsb4zqpjq4r	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1673965822645	1673965822645	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
a771mgefirbgzux3k3dgtc35pho	2023-01-17 14:30:22.437069+00	c7nxcehxnbtrmde6gsb4zqpjq4r	1	text	## Checklist	{}	1673965822649	1673965822649	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
77equnzy4qigcj8xwb66wqhraoh	2023-01-17 14:30:22.437069+00	cosmtosxa73bw5p1t1cohy4ks8a	1	checkbox	Follow up after demo	{"value":true}	1673965822653	1673965822653	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
78fbar4fyg7bc3gigp3pj1m8gkr	2023-01-17 14:30:22.437069+00	cosmtosxa73bw5p1t1cohy4ks8a	1	checkbox	Send initial email	{"value":true}	1673965822657	1673965822657	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7i1kqqtiz87bbumih14rrewqk9h	2023-01-17 14:30:22.437069+00	cosmtosxa73bw5p1t1cohy4ks8a	1	checkbox	Send follow-up email	{"value":true}	1673965822663	1673965822663	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7cdxopq4bpinpina7u3njzjw8da	2023-01-17 14:30:22.437069+00	cosmtosxa73bw5p1t1cohy4ks8a	1	checkbox	Send proposal	{"value":true}	1673965822667	1673965822667	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7o9qnzhanjt8pxf8pe4xmk3gn7r	2023-01-17 14:30:22.437069+00	cosmtosxa73bw5p1t1cohy4ks8a	1	checkbox	Finalize contract	{"value":true}	1673965822671	1673965822671	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7jre9ywhr4jybdp1kmt5oz4rwww	2023-01-17 14:30:22.437069+00	cosmtosxa73bw5p1t1cohy4ks8a	1	checkbox	Schedule follow-up sales call	{"value":true}	1673965822677	1673965822677	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7rbokobjh9bnc5ctprmksycxiec	2023-01-17 14:30:22.437069+00	cosmtosxa73bw5p1t1cohy4ks8a	1	checkbox	Schedule initial sales call	{"value":true}	1673965822681	1673965822681	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
748ofm3bwk3rytfshqau13iazsw	2023-01-17 14:30:22.437069+00	cosmtosxa73bw5p1t1cohy4ks8a	1	checkbox	Schedule demo	{"value":true}	1673965822685	1673965822685	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7amc5xqsac3g1jmft5q9ukprzur	2023-01-17 14:30:22.437069+00	cosmtosxa73bw5p1t1cohy4ks8a	1	checkbox	Hand-off to customer success	{"value":true}	1673965822689	1673965822689	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
791t7xpee5jbn9rxwf5uee5196c	2023-01-17 14:30:22.437069+00	cosmtosxa73bw5p1t1cohy4ks8a	1	checkbox	Post-sales follow up	{"value":true}	1673965822694	1673965822694	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
ajwdcjesu5jy1ugwep9q4g1an1h	2023-01-17 14:30:22.437069+00	cosmtosxa73bw5p1t1cohy4ks8a	1	text	## Checklist	{}	1673965822698	1673965822698	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
ahxaszp31f3yhjjo19eu3544z8o	2023-01-17 14:30:22.437069+00	cosmtosxa73bw5p1t1cohy4ks8a	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1673965822703	1673965822703	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7jmhxnwpux3gyipyj3a3iarpgzr	2023-01-17 14:30:22.437069+00	c8x67gy9xepfxzptgxzt8wgytzr	1	checkbox	Post-sales follow up	{}	1673965822706	1673965822706	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7wbkktsfo73gkzgj8t7bx94y1ce	2023-01-17 14:30:22.437069+00	c8x67gy9xepfxzptgxzt8wgytzr	1	checkbox	Send proposal	{}	1673965822712	1673965822712	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7ddzqqhzbx7yxbcqk7iikeuch5o	2023-01-17 14:30:22.437069+00	c8x67gy9xepfxzptgxzt8wgytzr	1	checkbox	Hand-off to customer success	{}	1673965822716	1673965822716	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7a655j9kehi8fjxrj7k6c6kuooe	2023-01-17 14:30:22.437069+00	c8x67gy9xepfxzptgxzt8wgytzr	1	checkbox	Follow up after demo	{}	1673965822720	1673965822719	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7cj4p6dnqxidqufbpmmci3tqofw	2023-01-17 14:30:22.437069+00	c8x67gy9xepfxzptgxzt8wgytzr	1	checkbox	Schedule demo	{"value":true}	1673965822724	1673965822724	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7mtji9sd7zf8puqfe5subkm9i1r	2023-01-17 14:30:22.437069+00	c8x67gy9xepfxzptgxzt8wgytzr	1	checkbox	Send initial email	{"value":true}	1673965822729	1673965822729	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
75s6bgegkrpgdibowmmcr4dk6sy	2023-01-17 14:30:22.437069+00	c8x67gy9xepfxzptgxzt8wgytzr	1	checkbox	Schedule follow-up sales call	{"value":true}	1673965822734	1673965822734	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7xjcp7osgobbh7xtaeuqdri5zfa	2023-01-17 14:30:22.437069+00	c8x67gy9xepfxzptgxzt8wgytzr	1	checkbox	Send follow-up email	{"value":true}	1673965822738	1673965822738	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
799fwf5a49tba8x615kcfwuprge	2023-01-17 14:30:22.437069+00	c8x67gy9xepfxzptgxzt8wgytzr	1	checkbox	Schedule initial sales call	{"value":true}	1673965822742	1673965822742	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7ca85myg8p3y9fmwsrxzxe6qxer	2023-01-17 14:30:22.437069+00	c8x67gy9xepfxzptgxzt8wgytzr	1	checkbox	Finalize contract	{}	1673965822747	1673965822747	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
affik4pq6mpn8zqjc9prdrhtq3c	2023-01-17 14:30:22.437069+00	c8x67gy9xepfxzptgxzt8wgytzr	1	text	## Checklist	{}	1673965822751	1673965822751	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
ah64hewt1iffsfb3b9gjggcde9h	2023-01-17 14:30:22.437069+00	c8x67gy9xepfxzptgxzt8wgytzr	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1673965822756	1673965822756	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7oq53yacgn78e9mgw7rtyh8bhzy	2023-01-17 14:30:22.437069+00	c1zr4ry1y9fdsmpdxyu4i5n8ieo	1	checkbox	Send initial email	{"value":false}	1673965822762	1673965822762	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7y6nw38oywtbg9xypjquugqkhyy	2023-01-17 14:30:22.437069+00	c1zr4ry1y9fdsmpdxyu4i5n8ieo	1	checkbox	Schedule initial sales call	{"value":false}	1673965822766	1673965822766	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7o4sc444ekir73ysppiq9uhwm4o	2023-01-17 14:30:22.437069+00	c1zr4ry1y9fdsmpdxyu4i5n8ieo	1	checkbox	Schedule follow-up sales call	{"value":false}	1673965822771	1673965822771	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
76g3pktsh4bf97ycyx1p44reytc	2023-01-17 14:30:22.437069+00	c1zr4ry1y9fdsmpdxyu4i5n8ieo	1	checkbox	Send proposal	{}	1673965822776	1673965822776	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7f4oxkpqy7brgjnei6zmnft7qno	2023-01-17 14:30:22.437069+00	c1zr4ry1y9fdsmpdxyu4i5n8ieo	1	checkbox	Finalize contract	{}	1673965822781	1673965822781	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
79rae1r6dwidwxftw7s43cd77kh	2023-01-17 14:30:22.437069+00	c1zr4ry1y9fdsmpdxyu4i5n8ieo	1	checkbox	Post-sales follow up	{}	1673965822786	1673965822786	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7n5erteor5bdgmbdgbgpeptb38w	2023-01-17 14:30:22.437069+00	c1zr4ry1y9fdsmpdxyu4i5n8ieo	1	checkbox	Send follow-up email	{"value":false}	1673965822792	1673965822792	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7hruqoce41pd37k6jx3x8tthr1r	2023-01-17 14:30:22.437069+00	c1zr4ry1y9fdsmpdxyu4i5n8ieo	1	checkbox	Schedule demo	{"value":false}	1673965822797	1673965822797	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
73io7mjdtgj8ifnr96dm7cz7eia	2023-01-17 14:30:22.437069+00	c1zr4ry1y9fdsmpdxyu4i5n8ieo	1	checkbox	Hand-off to customer success	{}	1673965822801	1673965822801	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7ndxi8gb593n6zyc7bdnehbfwoo	2023-01-17 14:30:22.437069+00	c1zr4ry1y9fdsmpdxyu4i5n8ieo	1	checkbox	Follow up after demo	{}	1673965822805	1673965822805	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
adi6x775bujrgmyqscpt3c93xxe	2023-01-17 14:30:22.437069+00	c1zr4ry1y9fdsmpdxyu4i5n8ieo	1	text	## Notes\n[Enter notes here...]	{}	1673965822811	1673965822811	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
ax1x8sw6gnpbb5m3e83md6x1b1c	2023-01-17 14:30:22.437069+00	c1zr4ry1y9fdsmpdxyu4i5n8ieo	1	text	## Checklist	{}	1673965822816	1673965822816	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7bbrqqf8gfjd8tbjqq71tbkbupr	2023-01-17 14:30:22.437069+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Hand-off to customer success	{}	1673965822822	1673965822822	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7a9rfmkwuntrg3farpab3b15k9e	2023-01-17 14:30:22.437069+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Send initial email	{"value":false}	1673965822828	1673965822828	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7ix6z7pp9apng9qx7xfuy5juqmo	2023-01-17 14:30:22.437069+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Post-sales follow up	{}	1673965822833	1673965822833	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
783rahmrez7rx8fcg7kewtebbsa	2023-01-17 14:30:22.437069+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Finalize contract	{}	1673965822838	1673965822838	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7qgq3kdjxufdz8p93z6maxeaxbc	2023-01-17 14:30:22.437069+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Send follow-up email	{"value":false}	1673965822843	1673965822843	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
77rjdzudeu3yjxkht9zt4fdfdxy	2023-01-17 14:30:22.437069+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Schedule follow-up sales call	{"value":false}	1673965822848	1673965822848	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7fntad4asejna8bgcqqasmcfzbh	2023-01-17 14:30:22.437069+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Send proposal	{}	1673965822853	1673965822853	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7sfr1qh7ntjb9xkn1tn78j9z9ie	2023-01-17 14:30:22.437069+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Follow up after demo	{}	1673965822857	1673965822857	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7zbhjormicjb6mxupospnbp1e1o	2023-01-17 14:30:22.437069+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Schedule initial sales call	{"value":false}	1673965822862	1673965822862	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7dx19cd31y7rwij6f46xj1qiwxh	2023-01-17 14:30:22.437069+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Schedule demo	{"value":false}	1673965822867	1673965822867	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
a36pnn1guxifqbqpco8c8b7e78c	2023-01-17 14:30:22.437069+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	text	## Checklist	{}	1673965822872	1673965822872	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
aybi6yak1qpddfqcnamahjrcb3o	2023-01-17 14:30:22.437069+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	text	## Notes\n[Enter notes here...]	{}	1673965822878	1673965822878	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7jkepmbfsnj8m5xtddh4tyfot7o	2023-01-17 14:30:22.437069+00	crn69z85umjbxtqbk7nj6rne4ic	1	checkbox	Send proposal	{}	1673965822882	1673965822882	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7866hyr5143rk9q3q5zrtkn17er	2023-01-17 14:30:22.437069+00	crn69z85umjbxtqbk7nj6rne4ic	1	checkbox	Send initial email	{"value":true}	1673965822887	1673965822887	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7f8tsoayeeig63nwym8u6o458bw	2023-01-17 14:30:22.437069+00	crn69z85umjbxtqbk7nj6rne4ic	1	checkbox	Follow up after demo	{}	1673965822891	1673965822891	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7zhgzabkydiyszk1tfz5ggbszby	2023-01-17 14:30:22.437069+00	crn69z85umjbxtqbk7nj6rne4ic	1	checkbox	Finalize contract	{}	1673965822896	1673965822896	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7wqbg84e4ab8rzdqoqun3yhwp8a	2023-01-17 14:30:22.437069+00	crn69z85umjbxtqbk7nj6rne4ic	1	checkbox	Schedule follow-up sales call	{"value":false}	1673965822901	1673965822901	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7jreh9zg4kfgq9gd6kza7ty6jqr	2023-01-17 14:30:22.437069+00	crn69z85umjbxtqbk7nj6rne4ic	1	checkbox	Schedule demo	{"value":false}	1673965822905	1673965822905	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
73j6remhzifrhbm4irkc9nc1c3e	2023-01-17 14:30:22.437069+00	crn69z85umjbxtqbk7nj6rne4ic	1	checkbox	Schedule initial sales call	{"value":false}	1673965822911	1673965822911	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7pxag7ngrabyk3kf4rzhc89k1bh	2023-01-17 14:30:22.437069+00	crn69z85umjbxtqbk7nj6rne4ic	1	checkbox	Post-sales follow up	{}	1673965822916	1673965822916	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
7zqi73bttx3fuiqjydosrjnu3hr	2023-01-17 14:30:22.437069+00	crn69z85umjbxtqbk7nj6rne4ic	1	checkbox	Hand-off to customer success	{}	1673965822920	1673965822920	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
743pmufq1tfdutbmurn5bx7rzor	2023-01-17 14:30:22.437069+00	crn69z85umjbxtqbk7nj6rne4ic	1	checkbox	Send follow-up email	{"value":false}	1673965822926	1673965822926	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
a4jxu74p6z3gpfeixwpc4pwd47w	2023-01-17 14:30:22.437069+00	crn69z85umjbxtqbk7nj6rne4ic	1	text	## Checklist	{}	1673965822930	1673965822930	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
71rmsjsx17pyzzeg174moasyhsc	2023-01-17 14:30:23.920434+00	cktgow4j5wp8cjbu6aj18771o4c	1	checkbox	[Subtask 2]	{"value":false}	1673965824007	1673965824007	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
aiepiz4odbbdt3d3e55dcpqjsdc	2023-01-17 14:30:22.437069+00	crn69z85umjbxtqbk7nj6rne4ic	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1673965822935	1673965822934	0	\N	system		system	brdnxu4msb3ns3deuiewy9w9oyo
c7roekwxfe3nn5kef46qu4rb69r	2023-01-17 14:30:24.752127+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Start a daily journal	{"contentOrder":[],"icon":"✍️","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","d6b1249b-bc18-45fc-889e-bec48fce80ef":"0a82977f-52bf-457b-841b-e2b7f76fb525","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"3245a32d-f688-463b-87f4-8e7142c1b397"}}	1673965824763	1673965824763	0	\N	system		system	bng8baqwambb6bxwewinmuuno3y
ctrchiyzsz7nqufiqyki6efe4be	2023-01-17 14:30:24.752127+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Run 3 times a week	{"contentOrder":[],"icon":"🏃","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","d6b1249b-bc18-45fc-889e-bec48fce80ef":"6e7139e4-5358-46bb-8c01-7b029a57b80a","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"ffb3f951-b47f-413b-8f1d-238666728008"}}	1673965824768	1673965824768	0	\N	system		system	bng8baqwambb6bxwewinmuuno3y
ctsbwncpdqbg7tekctcfnp7fojc	2023-01-17 14:30:24.752127+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Learn to paint	{"contentOrder":[],"icon":"🎨","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"77c539af-309c-4db1-8329-d20ef7e9eacd","d6b1249b-bc18-45fc-889e-bec48fce80ef":"9a090e33-b110-4268-8909-132c5002c90e","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"3245a32d-f688-463b-87f4-8e7142c1b397"}}	1673965824774	1673965824774	0	\N	system		system	bng8baqwambb6bxwewinmuuno3y
csrtouonhyfdmdgw8agnrqu7sph	2023-01-17 14:30:24.752127+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Open retirement account	{"contentOrder":[],"icon":"🏦","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","d6b1249b-bc18-45fc-889e-bec48fce80ef":"0a82977f-52bf-457b-841b-e2b7f76fb525","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"80be816c-fc7a-4928-8489-8b02180f4954"}}	1673965824779	1673965824779	0	\N	system		system	bng8baqwambb6bxwewinmuuno3y
vpadzzoyxntysipg37tqy35wo1o	2023-01-17 14:30:24.752127+00	bd65qbzuqupfztpg31dgwgwm5ga	1	view	By Status	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"af6fcbb8-ca56-4b73-83eb-37437b9a667d","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","77c539af-309c-4db1-8329-d20ef7e9eacd","98bdea27-0cce-4cde-8dc6-212add36e63a",""],"visiblePropertyIds":["d9725d14-d5a8-48e5-8de1-6f8c004a9680","d6b1249b-bc18-45fc-889e-bec48fce80ef"]}	1673965824784	1673965824784	0	\N	system		system	bng8baqwambb6bxwewinmuuno3y
vru8wd5pdnigt5x88gpcekmnjbo	2023-01-17 14:30:24.752127+00	bd65qbzuqupfztpg31dgwgwm5ga	1	view	Calendar View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"ajy6xbebzopojaenbnmfpgtdwso","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1673965824788	1673965824788	0	\N	system		system	bng8baqwambb6bxwewinmuuno3y
vhec1a7c4mbfwbndr4kxo55sryy	2023-01-17 14:30:24.752127+00	bd65qbzuqupfztpg31dgwgwm5ga	1	view	By Date	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"d6b1249b-bc18-45fc-889e-bec48fce80ef","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["9a090e33-b110-4268-8909-132c5002c90e","0a82977f-52bf-457b-841b-e2b7f76fb525","6e7139e4-5358-46bb-8c01-7b029a57b80a","d5371c63-66bf-4468-8738-c4dc4bea4843",""],"visiblePropertyIds":["d9725d14-d5a8-48e5-8de1-6f8c004a9680"]}	1673965824792	1673965824792	0	\N	system		system	bng8baqwambb6bxwewinmuuno3y
vwq1epbd55frwiyjra3wkwpsc7a	2023-01-17 14:30:25.286676+00		1	view	All Users	{"cardOrder":["ctepgdjm48jbozybjcugxcah8oh"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":280,"aaebj5fyx493eezx6ukxiwydgty":146,"acjq4t5ymytu8x1f68wkggm7ypc":222,"akrxgi7p7w14fym3gbynb98t9fh":131,"atg9qu6oe4bjm8jczzsn71ff5me":131},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"akrxgi7p7w14fym3gbynb98t9fh","reversed":false}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["aaebj5fyx493eezx6ukxiwydgty","akrxgi7p7w14fym3gbynb98t9fh","atg9qu6oe4bjm8jczzsn71ff5me","acjq4t5ymytu8x1f68wkggm7ypc","aphio1s5gkmpdbwoxynim7acw3e","aqafzdeekpyncwz7m7i54q3iqqy","aify3r761b9w43bqjtskrzi68tr"]}	1673965825295	1673965825295	0	\N	system		system	bky8mjzqy9incxk3gjqwiatz6xa
ctepgdjm48jbozybjcugxcah8oh	2023-01-17 14:30:25.286676+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Frank Nash	{"contentOrder":["a9ts9agiduibzfkc3e3gjgjcsto"],"icon":"👨‍💼","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"ap93ysuzy1xa7z818r6myrn4h4y","acjq4t5ymytu8x1f68wkggm7ypc":"frank.nash@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1669896000000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"aehc83ffays3gh8myz16a8j7k4e"}}	1673965825301	1673965825301	0	\N	system		system	bky8mjzqy9incxk3gjqwiatz6xa
c9w8xao7k4fdq7findb74g5uyme	2023-01-17 14:30:25.286676+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Richard Parsons	{"contentOrder":["ah4uo9iiftjyt5dc4wzkyk348ch"],"icon":"👨‍🦱","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"a7yq89whddzob1futao4rxk3yzc","acjq4t5ymytu8x1f68wkggm7ypc":"richard.parsons@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1671019200000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"a1sxagjgaadym5yrjak6tcup1oa"}}	1673965825307	1673965825307	0	\N	system		system	bky8mjzqy9incxk3gjqwiatz6xa
csoqauki377rqme49sujukpf9ie	2023-01-17 14:30:25.286676+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Claire Hart	{"contentOrder":["ajhftsh9id3ncbcpguzmhm3r7ua"],"icon":"👩‍🦰","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"aseqq9hrsua56r3s6nbuirj9eec","acjq4t5ymytu8x1f68wkggm7ypc":"claire.hart@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1670500800000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"ahn89mqg9u4igk6pdm7333t8i5h"}}	1673965825312	1673965825312	0	\N	system		system	bky8mjzqy9incxk3gjqwiatz6xa
7tnc5ee6rqpbi8fphxxfu666b8c	2023-01-17 14:30:23.920434+00	cktgow4j5wp8cjbu6aj18771o4c	1	checkbox	...	{"value":false}	1673965824012	1673965824012	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
cbm5pbrm1d3fr5k3ou8k5z4my1o	2023-01-17 14:30:23.561233+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Pay bills	{"contentOrder":["7f8cmp4xqpjrhfnweqnbqarwd4w","79w7q5nkok7na5y5s1i5r6xdcmc","7bomioiw75j8k9nkaax7rwwupuo"],"icon":"🔌","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"aj4jyekqqssatjcq7r7chmy19ey","abthng7baedhhtrwsdodeuincqy":"true"}}	1673965823572	1673965823572	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
cr47faqnicbrifjtdd8u8x36nuh	2023-01-17 14:30:23.561233+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Buy groceries	{"contentOrder":["anmp3foy1yjbx98zzzbb9wfzgne","7d586azk3g7y85pjnsq74xq8g5w","7odxqyr86nignpgaqxeqr5ntnnw","79mi64hdwotr1uxrn73g4m515zy","7yyrxa34f5ige8f86qx89kommac","7ttzjfzjzfjd13koiyab88mafsc","7umdqpez3jpdtifmqcrk9pgc7dw"],"icon":"🛒","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"afpy8s7i45frggprmfsqngsocqh"}}	1673965823579	1673965823579	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
cjssbauz3xtdf3kqx5sbotc6e8w	2023-01-17 14:30:23.561233+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Go for a walk	{"contentOrder":["ar4643trxrjbafjri1dfysdsoor","a3jzh1uqxmj8kt8i6e51s5pndue","7r7o84kktbj8wzk7gmkqhpzfz5c"],"icon":"👣","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"an51dnkenmoog9cetapbc4uyt3y"}}	1673965823583	1673965823583	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
cgff4xt1wgir1pd5oh6m6kx8u1e	2023-01-17 14:30:23.561233+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Feed Fluffy	{"contentOrder":["am8mg58s99bnyzcaru4u3op469y"],"icon":"🐱","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"an51dnkenmoog9cetapbc4uyt3y"}}	1673965823587	1673965823587	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
c9tmyye5qq3ybbxsucsn74h1qry	2023-01-17 14:30:23.561233+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Gardening	{"contentOrder":[],"icon":"🌳","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"afpy8s7i45frggprmfsqngsocqh"}}	1673965823591	1673965823591	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
vy3am5c91i7nhfeimyw1hd4k4je	2023-01-17 14:30:23.561233+00	bbn1888mprfrm5fjw9f1je9x3xo	1	view	List View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":280},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a9zf59u8x1rf4ywctpcqama7tio","abthng7baedhhtrwsdodeuincqy"]}	1673965823596	1673965823596	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
vn7zsddinitbz5p5cw7iu7fkg9c	2023-01-17 14:30:23.561233+00	bbn1888mprfrm5fjw9f1je9x3xo	1	view	Board View	{"cardOrder":["cr47faqnicbrifjtdd8u8x36nuh","cbm5pbrm1d3fr5k3ou8k5z4my1o","cjssbauz3xtdf3kqx5sbotc6e8w","cgff4xt1wgir1pd5oh6m6kx8u1e","czowhma7rnpgb3eczbqo3t7fijo"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a9zf59u8x1rf4ywctpcqama7tio","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["an51dnkenmoog9cetapbc4uyt3y","afpy8s7i45frggprmfsqngsocqh","aj4jyekqqssatjcq7r7chmy19ey",""],"visiblePropertyIds":["a9zf59u8x1rf4ywctpcqama7tio"]}	1673965823601	1673965823601	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
7bomioiw75j8k9nkaax7rwwupuo	2023-01-17 14:30:23.561233+00	cbm5pbrm1d3fr5k3ou8k5z4my1o	1	checkbox	Utilities	{"value":true}	1673965823605	1673965823605	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
7f8cmp4xqpjrhfnweqnbqarwd4w	2023-01-17 14:30:23.561233+00	cbm5pbrm1d3fr5k3ou8k5z4my1o	1	checkbox	Mobile phone	{"value":true}	1673965823611	1673965823611	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
79w7q5nkok7na5y5s1i5r6xdcmc	2023-01-17 14:30:23.561233+00	cbm5pbrm1d3fr5k3ou8k5z4my1o	1	checkbox	Internet	{"value":true}	1673965823616	1673965823616	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
7ttzjfzjzfjd13koiyab88mafsc	2023-01-17 14:30:23.561233+00	cr47faqnicbrifjtdd8u8x36nuh	1	checkbox	Cereal	{"value":false}	1673965823623	1673965823623	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
7yyrxa34f5ige8f86qx89kommac	2023-01-17 14:30:23.561233+00	cr47faqnicbrifjtdd8u8x36nuh	1	checkbox	Butter	{"value":false}	1673965823630	1673965823630	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
79mi64hdwotr1uxrn73g4m515zy	2023-01-17 14:30:23.561233+00	cr47faqnicbrifjtdd8u8x36nuh	1	checkbox	Bread	{"value":false}	1673965823634	1673965823634	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
7d586azk3g7y85pjnsq74xq8g5w	2023-01-17 14:30:23.561233+00	cr47faqnicbrifjtdd8u8x36nuh	1	checkbox	Milk	{"value":false}	1673965823639	1673965823639	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
7umdqpez3jpdtifmqcrk9pgc7dw	2023-01-17 14:30:23.561233+00	cr47faqnicbrifjtdd8u8x36nuh	1	checkbox	Bananas	{"value":false}	1673965823645	1673965823644	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
7odxqyr86nignpgaqxeqr5ntnnw	2023-01-17 14:30:23.561233+00	cr47faqnicbrifjtdd8u8x36nuh	1	checkbox	Eggs	{"value":false}	1673965823650	1673965823650	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
anmp3foy1yjbx98zzzbb9wfzgne	2023-01-17 14:30:23.561233+00	cr47faqnicbrifjtdd8u8x36nuh	1	text	## Grocery list	{}	1673965823655	1673965823655	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
7r7o84kktbj8wzk7gmkqhpzfz5c	2023-01-17 14:30:23.561233+00	cjssbauz3xtdf3kqx5sbotc6e8w	1	image		{"fileId":"76fwrj36hptg6dywka4k5mt3sph.png"}	1673965823660	1673965823659	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
ar4643trxrjbafjri1dfysdsoor	2023-01-17 14:30:23.561233+00	cjssbauz3xtdf3kqx5sbotc6e8w	1	text	## Goal\nWalk at least 10,000 steps every day.	{}	1673965823665	1673965823665	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
a3jzh1uqxmj8kt8i6e51s5pndue	2023-01-17 14:30:23.561233+00	cjssbauz3xtdf3kqx5sbotc6e8w	1	text	## Route	{}	1673965823669	1673965823669	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
am8mg58s99bnyzcaru4u3op469y	2023-01-17 14:30:23.561233+00	cgff4xt1wgir1pd5oh6m6kx8u1e	1	text		{}	1673965823673	1673965823673	0	\N	system		system	bhdz6wki5stn9zmhgn9bg8uprbh
cmiywe3nj4tfczdhrojmewgxihh	2023-01-17 14:30:23.920434+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Identify dependencies	{"contentOrder":["ar93zjfxfopdxpex8of6hidn3nc","79chor8bedfnnzqsiwhmwoymi6w","a649zg5dqe7gbmk671ykt65hnir","7cxtn8sif9bg5xko4cmnwojeh1e","7ueqh9pt5ub8kzb386ykpdqh3br","7schprr1s5pdwtbhhiyjcze3xko","7qu5rk53gfjngxkd855ne7gnf9o"],"icon":"🔗","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"16","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ayz81h9f3dwp7rzzbdebesc7ute","d3d682bf-e074-49d9-8df5-7320921c2d23":"98a57627-0f76-471d-850d-91f3ed9fd213"}}	1673965823929	1673965823929	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
cktgow4j5wp8cjbu6aj18771o4c	2023-01-17 14:30:23.920434+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Define project scope	{"contentOrder":["a9ycjkpeqtjys7p5zj33znxue3w","7szysyefd93r9fejte6sqzbnjpc","aeggqdokndfr3przezf91qq9xye","751cabe6umbfc7fgj6d8q8z65dc","71rmsjsx17pyzzeg174moasyhsc","7zrh5knzneprw5c3q9ssejsuw1w","7tnc5ee6rqpbi8fphxxfu666b8c"],"icon":"🔬","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"32","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ar6b8m3jxr3asyxhr8iucdbo6yc","d3d682bf-e074-49d9-8df5-7320921c2d23":"87f59784-b859-4c24-8ebe-17c766e081dd"}}	1673965823935	1673965823935	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
cuyuessh9xpn45r75dg1g3eqn4y	2023-01-17 14:30:23.920434+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Requirements sign-off	{"contentOrder":["aikm9gsdfuig85qufciawmmmgjw","7mgqirp1hd7btmxm3jxjwa6wgno","a5sr1wzmmffdexcympbziuau7mc","7jn1xm5f1sinxbngw6s639jemzc","78fthbrzjs3dgfq8j5a5c7msd8r","77e8jot98ciyxdqcaggk7nhxxgh","7xpfbfmyyw3dgbemn7tkrt3jymo"],"icon":"🖋️","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"8","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ayz81h9f3dwp7rzzbdebesc7ute","d3d682bf-e074-49d9-8df5-7320921c2d23":"d3bfb50f-f569-4bad-8a3a-dd15c3f60101"}}	1673965823941	1673965823941	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
cyxbgjxzrpjbxpjm4rybxcrmg7h	2023-01-17 14:30:23.920434+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Project budget approval	{"contentOrder":["apga5pk5j6fn13x3yzkfow34c5e","75bn89cayztr3bd4gngco76txgh","a58sips6dw3y73p4uzyqoqkp3py","7jdtmj4s7xpy6jy48fsqi6rwrge","7s1jdspe3g3fi5ptbie4a1t6m1h","7hb7yzzrwxbbjzeaaxb5ero83jy","7si53m633ufn59f1j1n9yanw4yy"],"icon":"💵","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"16","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ayz81h9f3dwp7rzzbdebesc7ute","d3d682bf-e074-49d9-8df5-7320921c2d23":"d3bfb50f-f569-4bad-8a3a-dd15c3f60101"}}	1673965823947	1673965823947	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
cnfp9rawkgjbc8f4jeoy1ag31sy	2023-01-17 14:30:23.920434+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Conduct market analysis	{"contentOrder":["akttwuoan3ibu3e3iwqdcje4cgo","7t3mb8zqey3dnzpqbyydkq19csy","acgmc8y5in3fsxdncr8ogfmsiyc","7xsxzqz4pr7bcij8tzogy9zfs5h","7fp59dywwq3bs5qsbnie7e41pfw","7mcubfmpqsp8rjg5owpukt37gba","71tudiw7mmtf4f8wfrxaydctxgo"],"icon":"📈","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"40","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ar6b8m3jxr3asyxhr8iucdbo6yc","d3d682bf-e074-49d9-8df5-7320921c2d23":"87f59784-b859-4c24-8ebe-17c766e081dd"}}	1673965823952	1673965823952	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
vb1scrbdyqp8auf46yorjtxs6sc	2023-01-17 14:30:23.920434+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Project Priorities	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"d3d682bf-e074-49d9-8df5-7320921c2d23","hiddenOptionIds":[],"kanbanCalculations":{"":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"87f59784-b859-4c24-8ebe-17c766e081dd":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"98a57627-0f76-471d-850d-91f3ed9fd213":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"d3bfb50f-f569-4bad-8a3a-dd15c3f60101":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"}},"sortOptions":[],"viewType":"board","visibleOptionIds":["d3bfb50f-f569-4bad-8a3a-dd15c3f60101","87f59784-b859-4c24-8ebe-17c766e081dd","98a57627-0f76-471d-850d-91f3ed9fd213",""],"visiblePropertyIds":["a972dc7a-5f4c-45d2-8044-8c28c69717f1","a8daz81s4xjgke1ww6cwik5w7ye"]}	1673965823957	1673965823957	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
v3nc6fgyxgigt7rpcdykjpnkkdy	2023-01-17 14:30:23.920434+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Progress Tracker	{"cardOrder":["cyxbgjxzrpjbxpjm4rybxcrmg7h","cuyuessh9xpn45r75dg1g3eqn4y","cmiywe3nj4tfczdhrojmewgxihh","cnfp9rawkgjbc8f4jeoy1ag31sy","cktgow4j5wp8cjbu6aj18771o4c","coxnjt3ro1in19dd1e3awdt338r"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a972dc7a-5f4c-45d2-8044-8c28c69717f1","hiddenOptionIds":[],"kanbanCalculations":{"":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"adeo5xuwne3qjue83fcozekz8ko":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"afi4o5nhnqc3smtzs1hs3ij34dh":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"ahpyxfnnrzynsw3im1psxpkgtpe":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"ar6b8m3jxr3asyxhr8iucdbo6yc":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"ayz81h9f3dwp7rzzbdebesc7ute":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"}},"sortOptions":[],"viewType":"board","visibleOptionIds":["ayz81h9f3dwp7rzzbdebesc7ute","ar6b8m3jxr3asyxhr8iucdbo6yc","afi4o5nhnqc3smtzs1hs3ij34dh","adeo5xuwne3qjue83fcozekz8ko","ahpyxfnnrzynsw3im1psxpkgtpe",""],"visiblePropertyIds":["d3d682bf-e074-49d9-8df5-7320921c2d23","a8daz81s4xjgke1ww6cwik5w7ye"]}	1673965823962	1673965823962	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
vprusnt9ft3yj9f9u5zy8daroow	2023-01-17 14:30:23.920434+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Task Overview	{"cardOrder":["cktgow4j5wp8cjbu6aj18771o4c","cnfp9rawkgjbc8f4jeoy1ag31sy","cmiywe3nj4tfczdhrojmewgxihh","cyxbgjxzrpjbxpjm4rybxcrmg7h","cuyuessh9xpn45r75dg1g3eqn4y","cz8p8gofakfby8kzz83j97db8ph","ce1jm5q5i54enhuu4h3kkay1hcc"],"collapsedOptionIds":[],"columnCalculations":{"a8daz81s4xjgke1ww6cwik5w7ye":"sum"},"columnWidths":{"2a5da320-735c-4093-8787-f56e15cdfeed":196,"__title":280,"a8daz81s4xjgke1ww6cwik5w7ye":139,"a972dc7a-5f4c-45d2-8044-8c28c69717f1":141,"d3d682bf-e074-49d9-8df5-7320921c2d23":110},"defaultTemplateId":"czw9es1e89fdpjr7cqptr1xq7qh","filter":{"filters":[],"operation":"and"},"groupById":"","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a972dc7a-5f4c-45d2-8044-8c28c69717f1","d3d682bf-e074-49d9-8df5-7320921c2d23","2a5da320-735c-4093-8787-f56e15cdfeed","a3zsw7xs8sxy7atj8b6totp3mby","axkhqa4jxr3jcqe4k87g8bhmary","a7gdnz8ff8iyuqmzddjgmgo9ery","a8daz81s4xjgke1ww6cwik5w7ye"]}	1673965823966	1673965823966	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
vmcxeyrq8jjrgtjya3f1ph5h83r	2023-01-17 14:30:23.920434+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Task Calendar	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"a3zsw7xs8sxy7atj8b6totp3mby","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1673965823970	1673965823970	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7cxtn8sif9bg5xko4cmnwojeh1e	2023-01-17 14:30:23.920434+00	cmiywe3nj4tfczdhrojmewgxihh	1	checkbox	[Subtask 1]	{"value":false}	1673965823974	1673965823974	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7ueqh9pt5ub8kzb386ykpdqh3br	2023-01-17 14:30:23.920434+00	cmiywe3nj4tfczdhrojmewgxihh	1	checkbox	[Subtask 2]	{"value":false}	1673965823980	1673965823980	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
79chor8bedfnnzqsiwhmwoymi6w	2023-01-17 14:30:23.920434+00	cmiywe3nj4tfczdhrojmewgxihh	1	divider		{}	1673965823984	1673965823984	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7qu5rk53gfjngxkd855ne7gnf9o	2023-01-17 14:30:23.920434+00	cmiywe3nj4tfczdhrojmewgxihh	1	checkbox	...	{"value":false}	1673965823987	1673965823987	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7schprr1s5pdwtbhhiyjcze3xko	2023-01-17 14:30:23.920434+00	cmiywe3nj4tfczdhrojmewgxihh	1	checkbox	[Subtask 3]	{"value":false}	1673965823991	1673965823991	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
a649zg5dqe7gbmk671ykt65hnir	2023-01-17 14:30:23.920434+00	cmiywe3nj4tfczdhrojmewgxihh	1	text	## Checklist	{}	1673965823997	1673965823997	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
ar93zjfxfopdxpex8of6hidn3nc	2023-01-17 14:30:23.920434+00	cmiywe3nj4tfczdhrojmewgxihh	1	text	## Description\n*[Brief description of this task]*	{}	1673965824002	1673965824002	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
751cabe6umbfc7fgj6d8q8z65dc	2023-01-17 14:30:23.920434+00	cktgow4j5wp8cjbu6aj18771o4c	1	checkbox	[Subtask 1]	{"value":false}	1673965824017	1673965824017	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7zrh5knzneprw5c3q9ssejsuw1w	2023-01-17 14:30:23.920434+00	cktgow4j5wp8cjbu6aj18771o4c	1	checkbox	[Subtask 3]	{"value":false}	1673965824021	1673965824021	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7szysyefd93r9fejte6sqzbnjpc	2023-01-17 14:30:23.920434+00	cktgow4j5wp8cjbu6aj18771o4c	1	divider		{}	1673965824026	1673965824026	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
aeggqdokndfr3przezf91qq9xye	2023-01-17 14:30:23.920434+00	cktgow4j5wp8cjbu6aj18771o4c	1	text	## Checklist	{}	1673965824033	1673965824033	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
a9ycjkpeqtjys7p5zj33znxue3w	2023-01-17 14:30:23.920434+00	cktgow4j5wp8cjbu6aj18771o4c	1	text	## Description\n*[Brief description of this task]*	{}	1673965824038	1673965824038	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7xpfbfmyyw3dgbemn7tkrt3jymo	2023-01-17 14:30:23.920434+00	cuyuessh9xpn45r75dg1g3eqn4y	1	checkbox	...	{"value":false}	1673965824048	1673965824048	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
78fthbrzjs3dgfq8j5a5c7msd8r	2023-01-17 14:30:23.920434+00	cuyuessh9xpn45r75dg1g3eqn4y	1	checkbox	[Subtask 2]	{"value":false}	1673965824054	1673965824054	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7mgqirp1hd7btmxm3jxjwa6wgno	2023-01-17 14:30:23.920434+00	cuyuessh9xpn45r75dg1g3eqn4y	1	divider		{}	1673965824059	1673965824059	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
77e8jot98ciyxdqcaggk7nhxxgh	2023-01-17 14:30:23.920434+00	cuyuessh9xpn45r75dg1g3eqn4y	1	checkbox	[Subtask 3]	{"value":false}	1673965824064	1673965824064	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7jn1xm5f1sinxbngw6s639jemzc	2023-01-17 14:30:23.920434+00	cuyuessh9xpn45r75dg1g3eqn4y	1	checkbox	[Subtask 1]	{"value":false}	1673965824068	1673965824068	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
aikm9gsdfuig85qufciawmmmgjw	2023-01-17 14:30:23.920434+00	cuyuessh9xpn45r75dg1g3eqn4y	1	text	## Description\n*[Brief description of this task]*	{}	1673965824073	1673965824073	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
a5sr1wzmmffdexcympbziuau7mc	2023-01-17 14:30:23.920434+00	cuyuessh9xpn45r75dg1g3eqn4y	1	text	## Checklist	{}	1673965824078	1673965824078	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
75bn89cayztr3bd4gngco76txgh	2023-01-17 14:30:23.920434+00	cyxbgjxzrpjbxpjm4rybxcrmg7h	1	divider		{}	1673965824084	1673965824084	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7jdtmj4s7xpy6jy48fsqi6rwrge	2023-01-17 14:30:23.920434+00	cyxbgjxzrpjbxpjm4rybxcrmg7h	1	checkbox	[Subtask 1]	{"value":false}	1673965824090	1673965824090	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7hb7yzzrwxbbjzeaaxb5ero83jy	2023-01-17 14:30:23.920434+00	cyxbgjxzrpjbxpjm4rybxcrmg7h	1	checkbox	[Subtask 3]	{"value":false}	1673965824096	1673965824096	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7si53m633ufn59f1j1n9yanw4yy	2023-01-17 14:30:23.920434+00	cyxbgjxzrpjbxpjm4rybxcrmg7h	1	checkbox	...	{"value":false}	1673965824107	1673965824107	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7s1jdspe3g3fi5ptbie4a1t6m1h	2023-01-17 14:30:23.920434+00	cyxbgjxzrpjbxpjm4rybxcrmg7h	1	checkbox	[Subtask 2]	{"value":false}	1673965824122	1673965824122	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
a58sips6dw3y73p4uzyqoqkp3py	2023-01-17 14:30:23.920434+00	cyxbgjxzrpjbxpjm4rybxcrmg7h	1	text	## Checklist	{}	1673965824129	1673965824129	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
apga5pk5j6fn13x3yzkfow34c5e	2023-01-17 14:30:23.920434+00	cyxbgjxzrpjbxpjm4rybxcrmg7h	1	text	## Description\n*[Brief description of this task]*	{}	1673965824134	1673965824134	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
71tudiw7mmtf4f8wfrxaydctxgo	2023-01-17 14:30:23.920434+00	cnfp9rawkgjbc8f4jeoy1ag31sy	1	checkbox	...	{"value":false}	1673965824140	1673965824140	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7mcubfmpqsp8rjg5owpukt37gba	2023-01-17 14:30:23.920434+00	cnfp9rawkgjbc8f4jeoy1ag31sy	1	checkbox	[Subtask 3]	{"value":false}	1673965824148	1673965824148	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7t3mb8zqey3dnzpqbyydkq19csy	2023-01-17 14:30:23.920434+00	cnfp9rawkgjbc8f4jeoy1ag31sy	1	divider		{}	1673965824158	1673965824158	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7fp59dywwq3bs5qsbnie7e41pfw	2023-01-17 14:30:23.920434+00	cnfp9rawkgjbc8f4jeoy1ag31sy	1	checkbox	[Subtask 2]	{"value":false}	1673965824163	1673965824163	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7xsxzqz4pr7bcij8tzogy9zfs5h	2023-01-17 14:30:23.920434+00	cnfp9rawkgjbc8f4jeoy1ag31sy	1	checkbox	[Subtask 1]	{"value":false}	1673965824168	1673965824168	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
akttwuoan3ibu3e3iwqdcje4cgo	2023-01-17 14:30:23.920434+00	cnfp9rawkgjbc8f4jeoy1ag31sy	1	text	## Description\n*[Brief description of this task]*	{}	1673965824173	1673965824173	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
acgmc8y5in3fsxdncr8ogfmsiyc	2023-01-17 14:30:23.920434+00	cnfp9rawkgjbc8f4jeoy1ag31sy	1	text	## Checklist	{}	1673965824181	1673965824181	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7sj34o9b6ai8pzrmr5nfk1yanio	2023-01-17 14:30:23.920434+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	[Subtask 3]	{"value":false}	1673965824187	1673965824187	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7kyu1oo9a5tr8ufteannsa8fxdc	2023-01-17 14:30:23.920434+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	[Subtask 2]	{"value":false}	1673965824192	1673965824192	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7nyebddja77gpuyhwq4s3mo41mc	2023-01-17 14:30:23.920434+00	czw9es1e89fdpjr7cqptr1xq7qh	1	divider		{}	1673965824198	1673965824198	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7e6dhmna5ftdcbf889krm4i7hxy	2023-01-17 14:30:23.920434+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	[Subtask 1]	{"value":false}	1673965824203	1673965824203	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
7oj11jtmk13nbbn5gpexnm3z1cw	2023-01-17 14:30:23.920434+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	...	{"value":false}	1673965824208	1673965824208	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
audpbcs4gctffzkx38kcx1j358r	2023-01-17 14:30:23.920434+00	czw9es1e89fdpjr7cqptr1xq7qh	1	text	## Description\n*[Brief description of this task]*	{}	1673965824214	1673965824214	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
ayk8q8hxxh7nb9x85ebj8dozrzy	2023-01-17 14:30:23.920434+00	czw9es1e89fdpjr7cqptr1xq7qh	1	text	## Checklist	{}	1673965824219	1673965824219	0	\N	system		system	batppw5i74tr8drq8hjiokfdxaw
czoygsk6367n6jr68mrunq9jxty	2023-01-17 14:30:24.861134+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Feature	{"contentOrder":["auctu9d65jffdjb95pgtn9jb1er"],"icon":"🏗️","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer"}}	1673965824926	1673965824926	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
a6mycyg9gnpbhi88appsymaipqe	2023-01-17 14:30:26.527051+00	cgcj5hcy4g7rrjfeniqeym9kcbc	1	text	Mattermost Boards helps you manage and track all your project tasks with **Cards**.	{}	1673965826767	1673965826767	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
v34by4i8zh3ggzer5yefmcyafkr	2023-01-17 14:30:24.573381+00		1	view	By Quarter	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":452,"a17ryhi1jfsboxkwkztwawhmsxe":148,"a6amddgmrzakw66cidqzgk6p4ge":230,"azzbawji5bksj69sekcs4srm1ky":142},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"aqxyzkdrs4egqf7yk866ixkaojc","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a6amddgmrzakw66cidqzgk6p4ge","a17ryhi1jfsboxkwkztwawhmsxe","azzbawji5bksj69sekcs4srm1ky","adp5ft3kgz7r5iqq3tnwg551der","aqxyzkdrs4egqf7yk866ixkaojc","adu6mebzpibq6mgcswk69xxmnqe","asope3bddhm4gpsng5cfu4hf6rh","ajwxp866f9obs1kutfwaa5ru7fe","azqnyswk6s1boiwuthscm78qwuo","ahz3fmjnaguec8hce7xq3h5cjdr","a17bfcgnzmkwhziwa4tr38kiw5r"]}	1673965824586	1673965824586	0	\N	system		system	baib5iktj5bdnjqnq67rayaidgr
voj4jpnt51f8simen38x3zn5zcy	2023-01-17 14:30:24.573381+00		1	view	By Objectives	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":387,"a17ryhi1jfsboxkwkztwawhmsxe":134,"a6amddgmrzakw66cidqzgk6p4ge":183,"aqxyzkdrs4egqf7yk866ixkaojc":100},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a6amddgmrzakw66cidqzgk6p4ge","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a6amddgmrzakw66cidqzgk6p4ge","a17ryhi1jfsboxkwkztwawhmsxe","azzbawji5bksj69sekcs4srm1ky","adp5ft3kgz7r5iqq3tnwg551der","aqxyzkdrs4egqf7yk866ixkaojc","adu6mebzpibq6mgcswk69xxmnqe","asope3bddhm4gpsng5cfu4hf6rh","ajwxp866f9obs1kutfwaa5ru7fe","azqnyswk6s1boiwuthscm78qwuo","ahz3fmjnaguec8hce7xq3h5cjdr","a17bfcgnzmkwhziwa4tr38kiw5r"]}	1673965824592	1673965824592	0	\N	system		system	baib5iktj5bdnjqnq67rayaidgr
c1p95u7fz4igatb61mtb7wg3fgc	2023-01-17 14:30:24.573381+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Improve customer NPS score	{"contentOrder":[],"icon":"💯","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a8nukezwwmknqwjsygg7eaxs9te","a6amddgmrzakw66cidqzgk6p4ge":"apqfjst8massbjjhpcsjs3y1yqa","adp5ft3kgz7r5iqq3tnwg551der":"as555ipyzopjjpfb5rjtssecw5e","ahz3fmjnaguec8hce7xq3h5cjdr":"82%","ajwxp866f9obs1kutfwaa5ru7fe":"8.5","aqxyzkdrs4egqf7yk866ixkaojc":"anruuoyez51r3yjxuoc8zoqnwaw","azqnyswk6s1boiwuthscm78qwuo":"7","azzbawji5bksj69sekcs4srm1ky":"agm9p6gcq15ueuzqq3wd4be39wy"}}	1673965824599	1673965824599	0	\N	system		system	baib5iktj5bdnjqnq67rayaidgr
crz9aw5kfafy138b5a6d1s1c4de	2023-01-17 14:30:24.573381+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Generate more Marketing Qualified Leads (MQLs)	{"contentOrder":[],"icon":"🛣️","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a8nukezwwmknqwjsygg7eaxs9te","a6amddgmrzakw66cidqzgk6p4ge":"auw3afh3kfhrfgmjr8muiz137jy","adp5ft3kgz7r5iqq3tnwg551der":"as555ipyzopjjpfb5rjtssecw5e","ahz3fmjnaguec8hce7xq3h5cjdr":"65%","ajwxp866f9obs1kutfwaa5ru7fe":"100","aqxyzkdrs4egqf7yk866ixkaojc":"ahfbn1jsmhydym33ygxwg5jt3kh","azqnyswk6s1boiwuthscm78qwuo":"65","azzbawji5bksj69sekcs4srm1ky":"aehoa17cz18rqnrf75g7dwhphpr"}}	1673965824606	1673965824605	0	\N	system		system	baib5iktj5bdnjqnq67rayaidgr
cwrqrgzfp9jdx9x1u4w34r17hya	2023-01-17 14:30:24.573381+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Increase customer retention	{"contentOrder":[],"icon":"😀","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a8nukezwwmknqwjsygg7eaxs9te","a6amddgmrzakw66cidqzgk6p4ge":"apqfjst8massbjjhpcsjs3y1yqa","adp5ft3kgz7r5iqq3tnwg551der":"a8zg3rjtf4swh7smsjxpsn743rh","ahz3fmjnaguec8hce7xq3h5cjdr":"66%","ajwxp866f9obs1kutfwaa5ru7fe":"90% customer retention rate","aqxyzkdrs4egqf7yk866ixkaojc":"acb6dqqs6yson7bbzx6jk9bghjh","azqnyswk6s1boiwuthscm78qwuo":"60%","azzbawji5bksj69sekcs4srm1ky":"afkxpcjqjypu7hhar7banxau91h"}}	1673965824613	1673965824613	0	\N	system		system	baib5iktj5bdnjqnq67rayaidgr
chdqeo6qei3bjiqhi6gtbaefq5o	2023-01-17 14:30:24.573381+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Hit company global sales target	{"contentOrder":[],"icon":"💰","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a6robxx81diugpjq5jkezz3j1fo","a6amddgmrzakw66cidqzgk6p4ge":"auw3afh3kfhrfgmjr8muiz137jy","adp5ft3kgz7r5iqq3tnwg551der":"a8zg3rjtf4swh7smsjxpsn743rh","ahz3fmjnaguec8hce7xq3h5cjdr":"15%","ajwxp866f9obs1kutfwaa5ru7fe":"50MM","aqxyzkdrs4egqf7yk866ixkaojc":"awfu37js3fomfkkczm1zppac57a","azqnyswk6s1boiwuthscm78qwuo":"7.5MM","azzbawji5bksj69sekcs4srm1ky":"agrfeaoj7d8p5ianw5iaf3191ae"}}	1673965824618	1673965824618	0	\N	system		system	baib5iktj5bdnjqnq67rayaidgr
cr8h4tr6yrfnxf854bmshqswcrw	2023-01-17 14:30:24.573381+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Increase user signups by 30%	{"contentOrder":[],"icon":"💳","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a6robxx81diugpjq5jkezz3j1fo","a6amddgmrzakw66cidqzgk6p4ge":"ao9b5pxyt7tkgdohzh9oaustdhr","adp5ft3kgz7r5iqq3tnwg551der":"as555ipyzopjjpfb5rjtssecw5e","ahz3fmjnaguec8hce7xq3h5cjdr":"0%","ajwxp866f9obs1kutfwaa5ru7fe":"1,000","aqxyzkdrs4egqf7yk866ixkaojc":"acb6dqqs6yson7bbzx6jk9bghjh","azqnyswk6s1boiwuthscm78qwuo":"0","azzbawji5bksj69sekcs4srm1ky":"afkxpcjqjypu7hhar7banxau91h"}}	1673965824624	1673965824624	0	\N	system		system	baib5iktj5bdnjqnq67rayaidgr
c3np3bao4utfbpkbysc4grpea9r	2023-01-17 14:30:24.573381+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Add 10 new customers in the EU	{"contentOrder":[],"icon":"🌍","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"apnt1f7na9rzgk1rt49keg7xbiy","a6amddgmrzakw66cidqzgk6p4ge":"auw3afh3kfhrfgmjr8muiz137jy","adp5ft3kgz7r5iqq3tnwg551der":"a1ts3ftyr8nocsicui98c89uxjy","ahz3fmjnaguec8hce7xq3h5cjdr":"30%","ajwxp866f9obs1kutfwaa5ru7fe":"10","aqxyzkdrs4egqf7yk866ixkaojc":"acb6dqqs6yson7bbzx6jk9bghjh","azqnyswk6s1boiwuthscm78qwuo":"3","azzbawji5bksj69sekcs4srm1ky":"agrfeaoj7d8p5ianw5iaf3191ae"}}	1673965824630	1673965824630	0	\N	system		system	baib5iktj5bdnjqnq67rayaidgr
czaw3u5a3mtyuuqj3hxbxxxjfbe	2023-01-17 14:30:24.573381+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Launch 3 key features	{"contentOrder":[],"icon":"🚀","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"apnt1f7na9rzgk1rt49keg7xbiy","a6amddgmrzakw66cidqzgk6p4ge":"ao9b5pxyt7tkgdohzh9oaustdhr","adp5ft3kgz7r5iqq3tnwg551der":"a8zg3rjtf4swh7smsjxpsn743rh","ahz3fmjnaguec8hce7xq3h5cjdr":"33%","ajwxp866f9obs1kutfwaa5ru7fe":"3","aqxyzkdrs4egqf7yk866ixkaojc":"anruuoyez51r3yjxuoc8zoqnwaw","azqnyswk6s1boiwuthscm78qwuo":"1","azzbawji5bksj69sekcs4srm1ky":"aw5i7hmpadn6mbwbz955ubarhme"}}	1673965824636	1673965824636	0	\N	system		system	baib5iktj5bdnjqnq67rayaidgr
c8r3nd58zopf18khq7bo4zqarja	2023-01-17 14:30:24.573381+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Reduce bug backlog by 50%	{"contentOrder":[],"icon":"🐞","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"abzfwnn6rmtfzyq5hg8uqmpsncy","a6amddgmrzakw66cidqzgk6p4ge":"apqfjst8massbjjhpcsjs3y1yqa","adp5ft3kgz7r5iqq3tnwg551der":"a1ts3ftyr8nocsicui98c89uxjy","ahz3fmjnaguec8hce7xq3h5cjdr":"100%","ajwxp866f9obs1kutfwaa5ru7fe":"75","aqxyzkdrs4egqf7yk866ixkaojc":"awfu37js3fomfkkczm1zppac57a","azqnyswk6s1boiwuthscm78qwuo":"75","azzbawji5bksj69sekcs4srm1ky":"aw5i7hmpadn6mbwbz955ubarhme"}}	1673965824641	1673965824641	0	\N	system		system	baib5iktj5bdnjqnq67rayaidgr
a5mqxz59kd3bbjmo9ohn3145wwe	2023-01-17 14:30:24.861134+00	c76435tzksigr8n8q3xkej17h3y	1	text	## Summary\n*[Brief description of what this epic is about]*\n\n## Motivation\n*[Brief description on why this is needed]*\n\n## Acceptance Criteria\n - *[Criteron 1]*\n - *[Criteron 2]*\n - ...\n\n## Personas\n - *[Persona A]*\n - *[Persona B]*\n - ...\n\n## Reference Materials\n - *[Links to other relevant documents as needed]*\n - ...	{}	1673965825018	1673965825018	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
vticqp4sj93naddnufrwsb5mm6r	2023-01-17 14:30:24.573381+00	bm4ubx56krp4zwyfcqh7nxiigbr	1	view	Departments	{"cardOrder":["cpa534b5natgmunis8u1ixb55pw"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"azzbawji5bksj69sekcs4srm1ky","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["aw5i7hmpadn6mbwbz955ubarhme","afkxpcjqjypu7hhar7banxau91h","aehoa17cz18rqnrf75g7dwhphpr","agrfeaoj7d8p5ianw5iaf3191ae","agm9p6gcq15ueuzqq3wd4be39wy","aucop7kw6xwodcix6zzojhxih6r","afust91f3g8ht368mkn5x9tgf1o","acocxxwjurud1jixhp7nowdig7y"],"visiblePropertyIds":[]}	1673965824647	1673965824647	0	\N	system		system	baib5iktj5bdnjqnq67rayaidgr
vgoe1wty5apbz7p1hkrpetybhih	2023-01-17 14:30:24.861134+00		1	view	By Sprint	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{"ai7ajsdk14w7x5s8up3dwir77te":"count"},"columnWidths":{"20717ad3-5741-4416-83f1-6f133fff3d11":128,"50117d52-bcc7-4750-82aa-831a351c44a0":126,"__title":280,"a1g6i613dpe9oryeo71ex3c86hy":159,"aeomttrbhhsi8bph31jn84sto6h":141,"ax9f8so418s6s65hi5ympd93i6a":183,"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":100},"defaultTemplateId":"cog6ycjunyiry8pt7q3h3idejhc","filter":{"filters":[],"operation":"and"},"groupById":"60985f46-3e41-486e-8213-2b987440ea1c","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["50117d52-bcc7-4750-82aa-831a351c44a0","20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","aphg37f7zbpuc3bhwhp19s1ribh","a4378omyhmgj3bex13sj4wbpfiy","ai7ajsdk14w7x5s8up3dwir77te","a1g6i613dpe9oryeo71ex3c86hy","aeomttrbhhsi8bph31jn84sto6h","ax9f8so418s6s65hi5ympd93i6a"]}	1673965824877	1673965824877	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
cog6ycjunyiry8pt7q3h3idejhc	2023-01-17 14:30:24.861134+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	User Story	{"contentOrder":["ah5nioubi93gmmb44w57qz7riuh"],"icon":"📖","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"apht1nt5ryukdmxkh6fkfn6rgoy","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer"}}	1673965824882	1673965824882	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
cerinpts6qbfadd8utwigd5txkw	2023-01-17 14:30:24.861134+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Horizontal scroll issue	{"contentOrder":["axqytkyitrbb1dfim7zgxn3uyey","a1uxwb5zxoi8gxg1i7raq8q3mwh","714krqfu73fb3ubkg15chhsygiw"],"icon":"〰️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"aomnawq4551cbbzha9gxnmb3z5w","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","ai7ajsdk14w7x5s8up3dwir77te":"1","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1673965824886	1673965824886	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
c5agijuybu3ytipchh1cg1jft7o	2023-01-17 14:30:24.861134+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Login screen not loading	{"contentOrder":["aujmrexi577yhipbw7m41mbushw","ag6awtgfgbpbixnnpjo6xe6geao","7n3nofrrx5tb7tdh6m1rgmitaba"],"icon":"🖥️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"aomnawq4551cbbzha9gxnmb3z5w","50117d52-bcc7-4750-82aa-831a351c44a0":"abrfos7e7eczk9rqw6y5abadm1y","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","ai7ajsdk14w7x5s8up3dwir77te":"1","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"cb8ecdac-38be-4d36-8712-c4d58cc8a8e9"}}	1673965824891	1673965824891	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
cbwwm511wmprm8khw3odqtc8rso	2023-01-17 14:30:24.861134+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Move cards across boards	{"contentOrder":["aiuehztraw3fdxbx3jjb1ymrzbo"],"icon":"🚚","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"abrfos7e7eczk9rqw6y5abadm1y","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"2","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1673965824897	1673965824897	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
co3uik6unbfbh5kufkccujj5jaw	2023-01-17 14:30:24.861134+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Cross-team collaboration	{"contentOrder":["adbz7rq4oybfdfmse97y1xpo8ia"],"icon":"🤝","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"424ea5e3-9aa1-4075-8c5c-01b44b66e634","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","60985f46-3e41-486e-8213-2b987440ea1c":"14892380-1a32-42dd-8034-a0cea32bc7e6","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"3","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"c62172ea-5da7-4dec-8186-37267d8ee9a7"}}	1673965824902	1673965824902	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
cro6hkqoesjygdqxtxtt3chefhc	2023-01-17 14:30:24.861134+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Bug	{"contentOrder":["amudnp868cbgr7m1koigb15fqre","ajdtjxrn6ytyn9pn33d6khzy34c","7wikyy4jobjypdfz86k6y3oh8kw"],"icon":"🐞","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"aomnawq4551cbbzha9gxnmb3z5w","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer"}}	1673965824907	1673965824907	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
c83juh4kyc7n6fc4eedjcfknigh	2023-01-17 14:30:24.861134+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Standard properties	{"contentOrder":["aknnbc5xktjde5k481bmide81pw"],"icon":"🏷️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","60985f46-3e41-486e-8213-2b987440ea1c":"14892380-1a32-42dd-8034-a0cea32bc7e6","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"3","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1673965824911	1673965824911	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
c76435tzksigr8n8q3xkej17h3y	2023-01-17 14:30:24.861134+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Epic	{"contentOrder":["a5mqxz59kd3bbjmo9ohn3145wwe"],"icon":"🤝","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"424ea5e3-9aa1-4075-8c5c-01b44b66e634","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"3","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"c62172ea-5da7-4dec-8186-37267d8ee9a7"}}	1673965824916	1673965824916	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
cmki93n3aii8o7f81jb5qya6z7r	2023-01-17 14:30:24.861134+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Global templates	{"contentOrder":["ask4at3979iyemm4pwixhwqmmjr"],"icon":"🖼️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"a6ghze4iy441qhsh3eijnc8hwze","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"2","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1673965824921	1673965824921	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
ask4at3979iyemm4pwixhwqmmjr	2023-01-17 14:30:24.861134+00	cmki93n3aii8o7f81jb5qya6z7r	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1673965825023	1673965825023	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
vqrfrhdqmeff18yuqoji3fq3h4e	2023-01-17 14:30:24.861134+00	bgi1yqiis8t8xdqxgnet8ebutky	1	view	By Status	{"cardOrder":["cmki93n3aii8o7f81jb5qya6z7r","cerinpts6qbfadd8utwigd5txkw","cbwwm511wmprm8khw3odqtc8rso","c5agijuybu3ytipchh1cg1jft7o","c83juh4kyc7n6fc4eedjcfknigh","co3uik6unbfbh5kufkccujj5jaw"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cidz4imnqhir48brz6e8hxhfrhy","filter":{"filters":[],"operation":"and"},"groupById":"50117d52-bcc7-4750-82aa-831a351c44a0","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["aft5bzo7h9aspqgrx3jpy5tzrer","abrfos7e7eczk9rqw6y5abadm1y","ax8wzbka5ahs3zziji3pp4qp9mc","atabdfbdmjh83136d5e5oysxybw","ace1bzypd586kkyhcht5qqd9eca","aay656c9m1hzwxc9ch5ftymh3nw","a6ghze4iy441qhsh3eijnc8hwze"],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1673965824932	1673965824932	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
vmao9o6ciajb3fedfdenjeefm6a	2023-01-17 14:30:24.861134+00	bgi1yqiis8t8xdqxgnet8ebutky	1	view	By Type	{"cardOrder":["c5agijuybu3ytipchh1cg1jft7o","cbwwm511wmprm8khw3odqtc8rso","c83juh4kyc7n6fc4eedjcfknigh","cerinpts6qbfadd8utwigd5txkw","cmki93n3aii8o7f81jb5qya6z7r","co3uik6unbfbh5kufkccujj5jaw"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cidz4imnqhir48brz6e8hxhfrhy","filter":{"filters":[],"operation":"and"},"groupById":"20717ad3-5741-4416-83f1-6f133fff3d11","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["424ea5e3-9aa1-4075-8c5c-01b44b66e634","a5yxq8rbubrpnoommfwqmty138h","apht1nt5ryukdmxkh6fkfn6rgoy","aiycbuo3dr5k4xxbfr7coem8ono","aomnawq4551cbbzha9gxnmb3z5w"],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1673965824936	1673965824936	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
ah5nioubi93gmmb44w57qz7riuh	2023-01-17 14:30:24.861134+00	cog6ycjunyiry8pt7q3h3idejhc	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1673965824942	1673965824942	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
714krqfu73fb3ubkg15chhsygiw	2023-01-17 14:30:24.861134+00	cerinpts6qbfadd8utwigd5txkw	1	image		{"fileId":"7tmfu5iqju3n1mdfwi5gru89qmw.png"}	1673965824947	1673965824947	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
axqytkyitrbb1dfim7zgxn3uyey	2023-01-17 14:30:24.861134+00	cerinpts6qbfadd8utwigd5txkw	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1673965824952	1673965824952	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
a1uxwb5zxoi8gxg1i7raq8q3mwh	2023-01-17 14:30:24.861134+00	cerinpts6qbfadd8utwigd5txkw	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1673965824957	1673965824957	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
7n3nofrrx5tb7tdh6m1rgmitaba	2023-01-17 14:30:24.861134+00	c5agijuybu3ytipchh1cg1jft7o	1	image		{"fileId":"7b9xk9boj3fbqfm3umeaaizp8qr.png"}	1673965824962	1673965824962	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
aujmrexi577yhipbw7m41mbushw	2023-01-17 14:30:24.861134+00	c5agijuybu3ytipchh1cg1jft7o	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1673965824967	1673965824967	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
ag6awtgfgbpbixnnpjo6xe6geao	2023-01-17 14:30:24.861134+00	c5agijuybu3ytipchh1cg1jft7o	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1673965824971	1673965824971	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
aiuehztraw3fdxbx3jjb1ymrzbo	2023-01-17 14:30:24.861134+00	cbwwm511wmprm8khw3odqtc8rso	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1673965824976	1673965824976	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
acecqo3xppbyx7nx9yo9myofcyr	2023-01-17 14:30:24.861134+00	cfmk7771httynm8r7rm8cbrmrya	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1673965824982	1673965824982	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
adky73z881bguzefnwtji7k9kcw	2023-01-17 14:30:24.861134+00	cfmk7771httynm8r7rm8cbrmrya	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1673965824987	1673965824987	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
adbz7rq4oybfdfmse97y1xpo8ia	2023-01-17 14:30:24.861134+00	co3uik6unbfbh5kufkccujj5jaw	1	text	## Summary\n*[Brief description of what this epic is about]*\n\n## Motivation\n*[Brief description on why this is needed]*\n\n## Acceptance Criteria\n - *[Criteron 1]*\n - *[Criteron 2]*\n - ...\n\n## Personas\n - *[Persona A]*\n - *[Persona B]*\n - ...\n\n## Reference Materials\n - *[Links to other relevant documents as needed]*\n - ...	{}	1673965824992	1673965824992	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
7wikyy4jobjypdfz86k6y3oh8kw	2023-01-17 14:30:24.861134+00	cro6hkqoesjygdqxtxtt3chefhc	1	image		{"fileId":"7tmfu5iqju3n1mdfwi5gru89qmw.png"}	1673965824997	1673965824997	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
amudnp868cbgr7m1koigb15fqre	2023-01-17 14:30:24.861134+00	cro6hkqoesjygdqxtxtt3chefhc	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1673965825002	1673965825002	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
ajdtjxrn6ytyn9pn33d6khzy34c	2023-01-17 14:30:24.861134+00	cro6hkqoesjygdqxtxtt3chefhc	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1673965825007	1673965825007	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
aknnbc5xktjde5k481bmide81pw	2023-01-17 14:30:24.861134+00	c83juh4kyc7n6fc4eedjcfknigh	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1673965825013	1673965825013	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
auctu9d65jffdjb95pgtn9jb1er	2023-01-17 14:30:24.861134+00	czoygsk6367n6jr68mrunq9jxty	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1673965825029	1673965825029	0	\N	system		system	brsotn1kutjgpbxf95tq4p94iya
vh68yx1yinin7tgxtkb87ifp7ie	2023-01-17 14:30:25.483027+00		1	view	Competitor List	{"cardOrder":["cicw93ci61p8388axk61zcmckqw","cc1pmziu8bjrgjbf6qw8u5qmcyc","cqdaiquhea78yigzjomqqoou3tw","c5bruozijn3rkfdowwo7stdwxmo","cr3yfndkftif3uryzqkn555uzxy"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":210,"a1semdhszu1rq17d7et5ydrqqio":121,"aapogff3xoa8ym7xf56s87kysda":194,"ahzspe59iux8wigra8bg6cg18nc":156,"aiefo7nh9jwisn8b4cgakowithy":155,"aozntq4go4nkab688j1s7stqtfc":151,"az3jkw3ynd3mqmart7edypey15e":145},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["ahzspe59iux8wigra8bg6cg18nc","aozntq4go4nkab688j1s7stqtfc","aiefo7nh9jwisn8b4cgakowithy","a6cwaq79b1pdpb97wkanmeyy4er","an1eerzscfxn6awdfajbg41uz3h","a1semdhszu1rq17d7et5ydrqqio","aapogff3xoa8ym7xf56s87kysda","az3jkw3ynd3mqmart7edypey15e"]}	1673965825493	1673965825493	0	\N	system		system	b9ejcs37rcjfdde8b49oabrj6kh
v9u6y9ycef38jdf4hudr6j1b6uc	2023-01-17 14:30:25.483027+00		1	view	Market Position	{"cardOrder":["cip8b4jcomfr7by9gtizebikfke","cacs91js1hb887ds41r6dwnd88c","ca3u8edwrof89i8obxffnz4xw3a"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["arfjpz9by5car71tz3behba8yih","abajmr34b8g1916w495xjb35iko","abt79uxg5edqojsrrefcnr4eruo","aipf3qfgjtkheiayjuxrxbpk9wa"],"visiblePropertyIds":[]}	1673965825498	1673965825498	0	\N	system		system	b9ejcs37rcjfdde8b49oabrj6kh
cicw93ci61p8388axk61zcmckqw	2023-01-17 14:30:25.483027+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Liminary Corp.	{"contentOrder":["amsemmr19stgmzdrh6xh4kkujse"],"icon":"🌧","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"abt79uxg5edqojsrrefcnr4eruo","a6cwaq79b1pdpb97wkanmeyy4er":"300","ahzspe59iux8wigra8bg6cg18nc":"liminarycorp.com","aiefo7nh9jwisn8b4cgakowithy":"$25,000,000","an1eerzscfxn6awdfajbg41uz3h":"2017","aozntq4go4nkab688j1s7stqtfc":"Toronto, Canada"}}	1673965825503	1673965825503	0	\N	system		system	b9ejcs37rcjfdde8b49oabrj6kh
cc1pmziu8bjrgjbf6qw8u5qmcyc	2023-01-17 14:30:25.483027+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Helx Industries	{"contentOrder":["a4b15o5sa7jn4ppdech3dt98pzr"],"icon":"📦","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"abt79uxg5edqojsrrefcnr4eruo","a6cwaq79b1pdpb97wkanmeyy4er":"650","ahzspe59iux8wigra8bg6cg18nc":"helxindustries.com","aiefo7nh9jwisn8b4cgakowithy":"$50,000,000","an1eerzscfxn6awdfajbg41uz3h":"2009","aozntq4go4nkab688j1s7stqtfc":"New York, NY"}}	1673965825508	1673965825508	0	\N	system		system	b9ejcs37rcjfdde8b49oabrj6kh
cqdaiquhea78yigzjomqqoou3tw	2023-01-17 14:30:25.483027+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Kadera Global	{"contentOrder":["a4w84368xmpd33b7k1e533gks7y"],"icon":"🛡","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"aipf3qfgjtkheiayjuxrxbpk9wa","a6cwaq79b1pdpb97wkanmeyy4er":"150","ahzspe59iux8wigra8bg6cg18nc":"kaderaglobal.com","aiefo7nh9jwisn8b4cgakowithy":"$12,000,000","an1eerzscfxn6awdfajbg41uz3h":"2015","aozntq4go4nkab688j1s7stqtfc":"Seattle, OR"}}	1673965825514	1673965825514	0	\N	system		system	b9ejcs37rcjfdde8b49oabrj6kh
cr3yfndkftif3uryzqkn555uzxy	2023-01-17 14:30:25.483027+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Ositions Inc.	{"contentOrder":["a6yuwn4u837y3xm9ho3d4kistwa"],"icon":"🌃","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"abajmr34b8g1916w495xjb35iko","a6cwaq79b1pdpb97wkanmeyy4er":"2,700","ahzspe59iux8wigra8bg6cg18nc":"ositionsinc.com","aiefo7nh9jwisn8b4cgakowithy":"$125,000,000","an1eerzscfxn6awdfajbg41uz3h":"2004","aozntq4go4nkab688j1s7stqtfc":"Berlin, Germany"}}	1673965825519	1673965825519	0	\N	system		system	b9ejcs37rcjfdde8b49oabrj6kh
c5bruozijn3rkfdowwo7stdwxmo	2023-01-17 14:30:25.483027+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Afformance Ltd.	{"contentOrder":["aye7oif7ue3yw7d1rn7wcjcmymr"],"icon":"⚡","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"arfjpz9by5car71tz3behba8yih","a6cwaq79b1pdpb97wkanmeyy4er":"1,800","ahzspe59iux8wigra8bg6cg18nc":"afformanceltd.com","aiefo7nh9jwisn8b4cgakowithy":"$200,000,000","an1eerzscfxn6awdfajbg41uz3h":"2002","aozntq4go4nkab688j1s7stqtfc":"Palo Alto, CA"}}	1673965825524	1673965825524	0	\N	system		system	b9ejcs37rcjfdde8b49oabrj6kh
amsemmr19stgmzdrh6xh4kkujse	2023-01-17 14:30:25.483027+00	cicw93ci61p8388axk61zcmckqw	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1673965825531	1673965825531	0	\N	system		system	b9ejcs37rcjfdde8b49oabrj6kh
a4b15o5sa7jn4ppdech3dt98pzr	2023-01-17 14:30:25.483027+00	cc1pmziu8bjrgjbf6qw8u5qmcyc	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1673965825539	1673965825539	0	\N	system		system	b9ejcs37rcjfdde8b49oabrj6kh
a4w84368xmpd33b7k1e533gks7y	2023-01-17 14:30:25.483027+00	cqdaiquhea78yigzjomqqoou3tw	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1673965825548	1673965825548	0	\N	system		system	b9ejcs37rcjfdde8b49oabrj6kh
a6yuwn4u837y3xm9ho3d4kistwa	2023-01-17 14:30:25.483027+00	cr3yfndkftif3uryzqkn555uzxy	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n\n## Weaknesses\n- ...\n- ...\n\n## Opportunities\n- ...\n- ...\n\n## Threats\n- ...\n- ...	{}	1673965825552	1673965825552	0	\N	system		system	b9ejcs37rcjfdde8b49oabrj6kh
csyx888zmcbbqx8mj66u1su4naw	2023-01-17 14:30:25.286676+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Olivia Alsop	{"contentOrder":["ao7ysbf51k7bpbct1hm9rftgeao"],"icon":"👩‍💼","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"a7yq89whddzob1futao4rxk3yzc","acjq4t5ymytu8x1f68wkggm7ypc":"olivia.alsop@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1671192000000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"a1sxagjgaadym5yrjak6tcup1oa"}}	1673965825317	1673965825317	0	\N	system		system	bky8mjzqy9incxk3gjqwiatz6xa
cyqyd3kzo43nqix1bda5hs5n4zh	2023-01-17 14:30:25.286676+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Bernadette Powell	{"contentOrder":["ac9psk4cuofrn5fkbrs4oxcjiaw"],"icon":"🧑‍💼","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"af6hjb3ysuaxbwnfqpby4wwnkdr","acjq4t5ymytu8x1f68wkggm7ypc":"bernadette.powell@email.com"}}	1673965825322	1673965825322	0	\N	system		system	bky8mjzqy9incxk3gjqwiatz6xa
vjzmfz4c4hfg8xnt7d438z6zxiw	2023-01-17 14:30:25.286676+00	bh4pkixqsjift58e1qy6htrgeay	1	view	By Date	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"akrxgi7p7w14fym3gbynb98t9fh","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1673965825328	1673965825328	0	\N	system		system	bky8mjzqy9incxk3gjqwiatz6xa
v9wmgqz394jy18no8rs8we3z3oa	2023-01-17 14:30:25.286676+00	bixohg18tt11in4qbtinimk974y	1	view	By Status	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["af6hjb3ysuaxbwnfqpby4wwnkdr","aotxum1p5bw3xuzqz3ctjw66yww","a7yq89whddzob1futao4rxk3yzc","aseqq9hrsua56r3s6nbuirj9eec","ap93ysuzy1xa7z818r6myrn4h4y"],"visiblePropertyIds":[]}	1673965825334	1673965825334	0	\N	system		system	bky8mjzqy9incxk3gjqwiatz6xa
a9ts9agiduibzfkc3e3gjgjcsto	2023-01-17 14:30:25.286676+00	ctepgdjm48jbozybjcugxcah8oh	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1673965825340	1673965825340	0	\N	system		system	bky8mjzqy9incxk3gjqwiatz6xa
ah4uo9iiftjyt5dc4wzkyk348ch	2023-01-17 14:30:25.286676+00	c9w8xao7k4fdq7findb74g5uyme	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1673965825344	1673965825344	0	\N	system		system	bky8mjzqy9incxk3gjqwiatz6xa
ajhftsh9id3ncbcpguzmhm3r7ua	2023-01-17 14:30:25.286676+00	csoqauki377rqme49sujukpf9ie	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1673965825349	1673965825349	0	\N	system		system	bky8mjzqy9incxk3gjqwiatz6xa
ao7ysbf51k7bpbct1hm9rftgeao	2023-01-17 14:30:25.286676+00	csyx888zmcbbqx8mj66u1su4naw	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1673965825355	1673965825355	0	\N	system		system	bky8mjzqy9incxk3gjqwiatz6xa
ac9psk4cuofrn5fkbrs4oxcjiaw	2023-01-17 14:30:25.286676+00	cyqyd3kzo43nqix1bda5hs5n4zh	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1673965825360	1673965825360	0	\N	system		system	bky8mjzqy9incxk3gjqwiatz6xa
cfkmbhbwkc3g8mb6uoag7zbb4mr	2023-01-17 14:30:25.707592+00	brs9cdimfw7fodyi7erqt747rhc	1	card	New Project and Workflow Management Solutions for Developers	{"contentOrder":["71qhnzuec6esdi6fnynwpze4xya","aes7wxky9d7gwpx9zwgsmmcbuwa"],"icon":"🎯","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1645790400000}","ab6mbock6styfe6htf815ph1mhw":["a8xceonxiu4n3c43szhskqizicr","a3pdzi53kpbd4okzdkz6khi87zo","a3d9ux4fmi3anyd11kyipfbhwde"],"ae9ar615xoknd8hw8py7mbyr7zo":"awna1nuarjca99m9s4uiy9kwj5h","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://mattermost.com/newsroom/press-releases/mattermost-launches-new-project-and-workflow-management-solutions-for-developers/","aysx3atqexotgwp5kx6h5i5ancw":"aywiofmmtd3ofgzj95ysky4pjga"}}	1673965825720	1673965825720	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
cb6qwccn65j877k47xn94fjybno	2023-01-17 14:30:25.707592+00	brs9cdimfw7fodyi7erqt747rhc	1	card	[Tweet] Mattermost v6.1 includes card @-mention notifications in Boards	{"contentOrder":["7i96m7nbsdsex8n6hzuzrmdfjuy","7ed5bwp3gr8yax3mhtuwiaa9gjy","airobmyxs97gf9x776u9yggqonw","a5d8u884hffgfmmnmeskpx9tfxw","abdasiyq4k7ndtfrdadrias8sjy","7b1j6y7syg7r7jmmeho8we95u7o"],"icon":"🐤","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1639051200000}","ab6mbock6styfe6htf815ph1mhw":["az8o8pfe9hq6s7xaehoqyc3wpyc"],"ae9ar615xoknd8hw8py7mbyr7zo":"a9ana1e9w673o5cp8md4xjjwfto","agqsoiipowmnu9rdwxm57zrehtr":"{\\"from\\":1637668800000}","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://twitter.com/Mattermost/status/1463145633162969097?s=20","aysx3atqexotgwp5kx6h5i5ancw":"aj8y675weso8kpb6eceqbpj4ruw"}}	1673965825726	1673965825726	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
cacokw4kzwtbb8dpdcwzk4gzpur	2023-01-17 14:30:25.707592+00	brs9cdimfw7fodyi7erqt747rhc	1	card	Top 10 Must-Have DevOps Tools in 2021	{"contentOrder":["7fo1utqc8x1z1z6hzg33hes1ktc","an583m9ixy3r8up5o48q1aa4toe"],"icon":"🛠️","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1636113600000}","ab6mbock6styfe6htf815ph1mhw":["a8xceonxiu4n3c43szhskqizicr"],"ae9ar615xoknd8hw8py7mbyr7zo":"a9ana1e9w673o5cp8md4xjjwfto","agqsoiipowmnu9rdwxm57zrehtr":"{\\"from\\":1637323200000}","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://www.toolbox.com/tech/devops/articles/best-devops-tools/","aysx3atqexotgwp5kx6h5i5ancw":"a3xky7ygn14osr1mokerbfah5cy"}}	1673965825732	1673965825732	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
cce5w7gzdrfyg7xu4u4zjtdsc5r	2023-01-17 14:30:25.707592+00	brs9cdimfw7fodyi7erqt747rhc	1	card	Unblocking Workflows: The Guide to Developer Productivity	{"contentOrder":["77tz16jtz5x73ncs3dxc3fp1d7h","ashgk8wjxf7gbtcecrhqokf33ia"],"icon":"💻","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1638532800000}","ab6mbock6styfe6htf815ph1mhw":["a3pdzi53kpbd4okzdkz6khi87zo"],"ae9ar615xoknd8hw8py7mbyr7zo":"apy9dcd7zmand615p3h53zjqxjh","agqsoiipowmnu9rdwxm57zrehtr":"{\\"from\\":1639483200000}","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://mattermost.com/newsroom/press-releases/mattermost-unveils-definitive-report-on-the-state-of-developer-productivity-unblocking-workflows-the-guide-to-developer-productivity-2022-edition/","aysx3atqexotgwp5kx6h5i5ancw":"a3xky7ygn14osr1mokerbfah5cy"}}	1673965825737	1673965825737	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
vbwwc7h53y3du5gh53hbhr8phme	2023-01-17 14:30:25.707592+00	brs9cdimfw7fodyi7erqt747rhc	1	view	By Status	{"cardOrder":[null,"cdbfkd15d6iy18rgx1tskmfsr6c","cn8yofg9rtkgmzgmb5xdi56p3ic","csgsnnywpuqzs5jgq87snk9x17e","cqwaytore5y487wdu8zffppqnea",null],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["awna1nuarjca99m9s4uiy9kwj5h","a9ana1e9w673o5cp8md4xjjwfto","apy9dcd7zmand615p3h53zjqxjh","acri4cm3bmay55f7ksztphmtnga","amsowcd9a8e1kid317r7ttw6uzh",""],"visiblePropertyIds":["ab6mbock6styfe6htf815ph1mhw"]}	1673965825742	1673965825742	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
7tc65fejc13b5jpckks38gorsga	2023-01-17 14:30:26.047826+00	cmjojddgzgtfr9x4g1gmijo1tmc	1	image		{"fileId":"77pe9r4ckbin438ph3f18bpatua.png"}	1673965826117	1673965826117	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
aye7oif7ue3yw7d1rn7wcjcmymr	2023-01-17 14:30:25.483027+00	c5bruozijn3rkfdowwo7stdwxmo	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1673965825556	1673965825556	0	\N	system		system	b9ejcs37rcjfdde8b49oabrj6kh
vm7gjj8ngejf1xp5fxtj95owqce	2023-01-17 14:30:25.707592+00	brs9cdimfw7fodyi7erqt747rhc	1	view	Due Date Calendar	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"a39x5cybshwrbjpc3juaakcyj6e","defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1673965825747	1673965825747	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
vi1d3wbwh5jb5unqb3wfu85dohc	2023-01-17 14:30:25.707592+00	brs9cdimfw7fodyi7erqt747rhc	1	view	Publication Calendar	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"agqsoiipowmnu9rdwxm57zrehtr","defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1673965825752	1673965825752	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
vjbda1tumcf89fcpy65nfabbquh	2023-01-17 14:30:25.707592+00	brs9cdimfw7fodyi7erqt747rhc	1	view	Content List	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":322,"ab6mbock6styfe6htf815ph1mhw":229,"aysx3atqexotgwp5kx6h5i5ancw":208},"defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"a39x5cybshwrbjpc3juaakcyj6e","reversed":false}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["ae9ar615xoknd8hw8py7mbyr7zo","aysx3atqexotgwp5kx6h5i5ancw","ab6mbock6styfe6htf815ph1mhw","ao44fz8nf6z6tuj1x31t9yyehcc","a39x5cybshwrbjpc3juaakcyj6e","agqsoiipowmnu9rdwxm57zrehtr","ap4e7kdg7eip7j3c3oyiz39eaoc"]}	1673965825758	1673965825758	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
aes7wxky9d7gwpx9zwgsmmcbuwa	2023-01-17 14:30:25.707592+00	cfkmbhbwkc3g8mb6uoag7zbb4mr	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1673965825765	1673965825765	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
7b1j6y7syg7r7jmmeho8we95u7o	2023-01-17 14:30:25.707592+00	cb6qwccn65j877k47xn94fjybno	1	image		{"fileId":"7y5kr8x8ybpnwdykjfuz57rggrh.png"}	1673965825770	1673965825770	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
airobmyxs97gf9x776u9yggqonw	2023-01-17 14:30:25.707592+00	cb6qwccn65j877k47xn94fjybno	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1673965825776	1673965825776	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
a5d8u884hffgfmmnmeskpx9tfxw	2023-01-17 14:30:25.707592+00	cb6qwccn65j877k47xn94fjybno	1	text	## Media	{}	1673965825782	1673965825782	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
aa1wmaqe7opyqjjr5a99ntihyny	2023-01-17 14:30:25.707592+00	cff1jmrxfrirgbeebhr9qd7nida	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1673965825787	1673965825787	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
ay6rgrg5p6tbdmn4iahqefcfm9c	2023-01-17 14:30:25.707592+00	cff1jmrxfrirgbeebhr9qd7nida	1	text	## Research\n- ...\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n- ...\n\n## Notes\n- ...\n- ...\n- ...	{}	1673965825793	1673965825793	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
apk537q4watycfe6szmnzrybj8r	2023-01-17 14:30:25.707592+00	cff1jmrxfrirgbeebhr9qd7nida	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1673965825799	1673965825799	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
an583m9ixy3r8up5o48q1aa4toe	2023-01-17 14:30:25.707592+00	cacokw4kzwtbb8dpdcwzk4gzpur	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1673965825804	1673965825804	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
ashgk8wjxf7gbtcecrhqokf33ia	2023-01-17 14:30:25.707592+00	cce5w7gzdrfyg7xu4u4zjtdsc5r	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1673965825809	1673965825809	0	\N	system		system	benutoyfd6byx5mxw5rbwtiqg9h
vhzgfdgqtzjndm8jrmmsd5c9one	2023-01-17 14:30:25.954832+00	bjbhs6bos3m8zjouf78xceg9nqw	1	view	Board view	{"cardOrder":["cniwb8xwcqtbstbcm3sdfrr854h","cs4qwpzr65fgttd7364dicskanh","c9s78pzbdg3g4jkcdjqahtnfejc","c8utmazns878jtfgtf7exyi9pee","cnobejmb6bf8e3c1w7em5z4pwyh"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["aok6pgecm85qe9k5kcphzoe63ma","aq1dwbf661yx337hjcd5q3sbxwa","ar87yh5xmsswqkxmjq1ipfftfpc","akj3fkmxq7idma55mdt8sqpumyw"],"visiblePropertyIds":["aspaay76a5wrnuhtqgm97tt3rer"]}	1673965825962	1673965825962	0	\N	system		system	bbr1copn6i7yu5y9sqk1ijg49qa
cx46jb9wqup8nfqzcmyo5uz5iea	2023-01-17 14:30:25.954832+00	bsjd59qtpbf888mqez3ge77domw	1	card	Tight deadline	{"contentOrder":[],"icon":"📅","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"ar87yh5xmsswqkxmjq1ipfftfpc"}}	1673965825967	1673965825967	0	\N	system		system	bbr1copn6i7yu5y9sqk1ijg49qa
c85zr4gcn7jnetbnryktfjps8ur	2023-01-17 14:30:25.954832+00	bsjd59qtpbf888mqez3ge77domw	1	card	Team communication	{"contentOrder":[],"icon":"💬","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"aq1dwbf661yx337hjcd5q3sbxwa"}}	1673965825971	1673965825971	0	\N	system		system	bbr1copn6i7yu5y9sqk1ijg49qa
cxwp6mwzt5igp5k6qp1x1obu5br	2023-01-17 14:30:25.954832+00	bsjd59qtpbf888mqez3ge77domw	1	card	Reschedule planning meeting	{"contentOrder":[],"icon":"🗓️","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"aok6pgecm85qe9k5kcphzoe63ma"}}	1673965825975	1673965825975	0	\N	system		system	bbr1copn6i7yu5y9sqk1ijg49qa
cdx4o8eseutrt7mt8tc1ag9s44o	2023-01-17 14:30:25.954832+00	bsjd59qtpbf888mqez3ge77domw	1	card	Schedule more time for testing	{"contentOrder":[],"icon":"🧪","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"akj3fkmxq7idma55mdt8sqpumyw"}}	1673965825979	1673965825979	0	\N	system		system	bbr1copn6i7yu5y9sqk1ijg49qa
cf3aa5j4ojibc8q7j5tgn7q9w3o	2023-01-17 14:30:25.954832+00	bsjd59qtpbf888mqez3ge77domw	1	card	Positive user feedback	{"contentOrder":[],"icon":"🥰","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"aq1dwbf661yx337hjcd5q3sbxwa"}}	1673965825984	1673965825984	0	\N	system		system	bbr1copn6i7yu5y9sqk1ijg49qa
7eejdg1thpib9pyreu6gy369gwr	2023-01-17 14:30:26.527051+00	c1c6ht51zaiyymp156jtx5zgsfr	1	image		{"fileId":"7ek6wbpp19jfoujs1goh6kttbby.gif"}	1673965826770	1673965826770	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
cmjojddgzgtfr9x4g1gmijo1tmc	2023-01-17 14:30:26.047826+00	bui5izho7dtn77xg3thkiqprc9r	1	card	App crashing	{"contentOrder":["79t7rkiuspeneqi9xurou9tqzwh","a1n8516bmht86ubwgdmmubu3hfe","ahfu7tjz6e3n8ikszjzc6q6zrfr","7tc65fejc13b5jpckks38gorsga"],"icon":"📉","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"1fdbb515-edd2-4af5-80fc-437ed2211a49","50117d52-bcc7-4750-82aa-831a351c44a0":"ec6d2bc5-df2b-4f77-8479-e59ceb039946","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"cb8ecdac-38be-4d36-8712-c4d58cc8a8e9"}}	1673965826060	1673965826060	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
vbqdrei68mfgq8qd55tppz8txuw	2023-01-17 14:30:26.527051+00	buixxjic3xjfkieees4iafdrznc	1	view	Preview: Gallery View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"gallery","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1673965826611	1673965826611	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
cbe3wtgyhdt8szdh7mbnomnxgic	2023-01-17 14:30:26.047826+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Calendar view	{"contentOrder":["7df11783ny67mdnognqae31ax6y","a3mfg6qq8cprquqmszwjfd61mwr"],"icon":"📆","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"6eea96c9-4c61-4968-8554-4b7537e8f748","50117d52-bcc7-4750-82aa-831a351c44a0":"849766ba-56a5-48d1-886f-21672f415395","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1673965826065	1673965826065	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
cpyuu3sybytgut8j4qn4xwxutre	2023-01-17 14:30:26.047826+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Standard templates	{"contentOrder":["7uonmjk41nipnrsi6tz8wau5ssh","a5q8ks7a9yt8nxqstczu43jm9xo"],"icon":"🗺️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"6eea96c9-4c61-4968-8554-4b7537e8f748","50117d52-bcc7-4750-82aa-831a351c44a0":"ec6d2bc5-df2b-4f77-8479-e59ceb039946","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1673965826070	1673965826070	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
cnfbpr65ex78idc8mxzkbg1af9o	2023-01-17 14:30:26.047826+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Import / Export	{"contentOrder":["a83j1u6smx3ghjb6uq8h53anq1w"],"icon":"🚢","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"6eea96c9-4c61-4968-8554-4b7537e8f748","50117d52-bcc7-4750-82aa-831a351c44a0":"ec6d2bc5-df2b-4f77-8479-e59ceb039946","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1673965826074	1673965826074	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
cqpo6e8jq83fzbc5qodyza7h4xo	2023-01-17 14:30:26.047826+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Review API design	{"contentOrder":["axakofzpzair1pee8y7wne99aqo"],"icon":"🛣️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"424ea5e3-9aa1-4075-8c5c-01b44b66e634","50117d52-bcc7-4750-82aa-831a351c44a0":"8c557f69-b0ed-46ec-83a3-8efab9d47ef5","60985f46-3e41-486e-8213-2b987440ea1c":"14892380-1a32-42dd-8034-a0cea32bc7e6","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"c62172ea-5da7-4dec-8186-37267d8ee9a7"}}	1673965826078	1673965826078	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
ctrzp9m4883n6uqf8ddo3ppg8kw	2023-01-17 14:30:26.047826+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Icons don't display	{"contentOrder":["a6pmhwjs5zpfwdr3ygbeo9z43ac","akp54muj8mbrtbyoswn17bcprky","77mn3imeqqpgi5mmoegdg9mfzow"],"icon":"💻","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"1fdbb515-edd2-4af5-80fc-437ed2211a49","50117d52-bcc7-4750-82aa-831a351c44a0":"8c557f69-b0ed-46ec-83a3-8efab9d47ef5","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1673965826084	1673965826084	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
v1cdhfbfyppgkdefy3gaq4t6oto	2023-01-17 14:30:26.047826+00	bui5izho7dtn77xg3thkiqprc9r	1	view	Calendar View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"a4378omyhmgj3bex13sj4wbpfiy","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1673965826089	1673965826089	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
vgydkqua38fyb78zr8y5aq4cabo	2023-01-17 14:30:26.047826+00	bui5izho7dtn77xg3thkiqprc9r	1	view	Board: Sprints	{"cardOrder":["cmjojddgzgtfr9x4g1gmijo1tmc","cbe3wtgyhdt8szdh7mbnomnxgic","cpyuu3sybytgut8j4qn4xwxutre","ctrzp9m4883n6uqf8ddo3ppg8kw","cnfbpr65ex78idc8mxzkbg1af9o","cqpo6e8jq83fzbc5qodyza7h4xo"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"60985f46-3e41-486e-8213-2b987440ea1c","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["c01676ca-babf-4534-8be5-cce2287daa6c","ed4a5340-460d-461b-8838-2c56e8ee59fe","14892380-1a32-42dd-8034-a0cea32bc7e6",""],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1673965826094	1673965826094	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
vwo8ebmszy3fsjnbj98e6et4s6a	2023-01-17 14:30:26.047826+00	bui5izho7dtn77xg3thkiqprc9r	1	view	List: Tasks 🔨	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"50117d52-bcc7-4750-82aa-831a351c44a0":139,"__title":280},"defaultTemplateId":"","filter":{"filters":[{"condition":"includes","propertyId":"20717ad3-5741-4416-83f1-6f133fff3d11","values":["6eea96c9-4c61-4968-8554-4b7537e8f748"]}],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"50117d52-bcc7-4750-82aa-831a351c44a0","reversed":true}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["50117d52-bcc7-4750-82aa-831a351c44a0","20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1673965826101	1673965826101	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
aairnwhsokff9zg1eucqkxeu8ec	2023-01-17 14:30:26.047826+00	cwrq9ag3p5pgzzy98nfd3wwra1w	1	text	## Summary\n*[Brief description of what this epic is about]*\n## Motivation\n*[Brief description on why this is needed]*\n## Acceptance Criteria\n- *[Criteron 1]*\n- *[Criteron 2]*\n- ...\n## Personas\n- *[Persona A]*\n- *[Persona B]*\n- ...\n## Reference Materials\n- *[Links to other relevant documents as needed]*\n- ...	{}	1673965826259	1673965826259	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
vgj7m8iz34bgjtqpjkaeuhy47ao	2023-01-17 14:30:26.047826+00	bui5izho7dtn77xg3thkiqprc9r	1	view	Board: Status	{"cardOrder":["cmjojddgzgtfr9x4g1gmijo1tmc","cm4w7cc3aac6s9jdcujbs4j8f4r","c6egh6cpnj137ixdoitsoxq17oo","cct9u78utsdyotmejbmwwg66ihr","cmft87it1q7yebbd51ij9k65xbw","c9fe77j9qcruxf4itzib7ag6f1c","coup7afjknqnzbdwghiwbsq541w","c5ex1hndz8qyc8gx6ofbfeksftc"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cidz4imnqhir48brz6e8hxhfrhy","filter":{"filters":[],"operation":"and"},"groupById":"50117d52-bcc7-4750-82aa-831a351c44a0","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["8c557f69-b0ed-46ec-83a3-8efab9d47ef5","ec6d2bc5-df2b-4f77-8479-e59ceb039946","849766ba-56a5-48d1-886f-21672f415395",""],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1673965826106	1673965826106	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
vft4fyk7agbyefbpiitrbw8nynw	2023-01-17 14:30:26.047826+00	bui5izho7dtn77xg3thkiqprc9r	1	view	List: Bugs 🐞	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"50117d52-bcc7-4750-82aa-831a351c44a0":145,"__title":280},"defaultTemplateId":"","filter":{"filters":[{"condition":"includes","propertyId":"20717ad3-5741-4416-83f1-6f133fff3d11","values":["1fdbb515-edd2-4af5-80fc-437ed2211a49"]}],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["50117d52-bcc7-4750-82aa-831a351c44a0","20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1673965826110	1673965826110	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
a1n8516bmht86ubwgdmmubu3hfe	2023-01-17 14:30:26.047826+00	cmjojddgzgtfr9x4g1gmijo1tmc	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1673965826128	1673965826128	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
ahfu7tjz6e3n8ikszjzc6q6zrfr	2023-01-17 14:30:26.047826+00	cmjojddgzgtfr9x4g1gmijo1tmc	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1673965826134	1673965826134	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
a3mfg6qq8cprquqmszwjfd61mwr	2023-01-17 14:30:26.047826+00	cbe3wtgyhdt8szdh7mbnomnxgic	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1673965826139	1673965826139	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
a5q8ks7a9yt8nxqstczu43jm9xo	2023-01-17 14:30:26.047826+00	cpyuu3sybytgut8j4qn4xwxutre	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1673965826143	1673965826143	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
737wxytzgupyrxre4dcce3smmzy	2023-01-17 14:30:26.047826+00	cfefgwjke6bbxpjpig618g9bpte	1	image		{"fileId":"7pbp4qg415pbstc6enzeicnu3qh.png"}	1673965826159	1673965826159	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
ac77kgj6zr3nzdcw6hfzte3rqxe	2023-01-17 14:30:26.047826+00	cfefgwjke6bbxpjpig618g9bpte	1	text	## Screenshots\nIf applicable, add screenshots to elaborate on the problem.	{}	1673965826177	1673965826177	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
awyd3q9prm3ddzjpsmjj3pejgfe	2023-01-17 14:30:26.047826+00	cfefgwjke6bbxpjpig618g9bpte	1	text	## Steps to reproduce the behavior\n\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n\nA clear and concise description of what you expected to happen.\n\n## Edition and Platform\n\n - Edition: Personal Desktop / Personal Server / Mattermost plugin\n - Version: [e.g. v0.9.0]\n - Browser and OS: [e.g. Chrome 91 on macOS, Edge 93 on Windows]\n\n## Additional context\n\nAdd any other context about the problem here.	{}	1673965826182	1673965826182	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
am4bsyay7z78wt8f8rasx8krq6c	2023-01-17 14:30:26.047826+00	cfefgwjke6bbxpjpig618g9bpte	1	text	## Steps to reproduce the behavior\n\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n\n*[A clear and concise description of what you expected to happen.]*\n\n## Screenshots\n\n*[If applicable, add screenshots to elaborate on the problem.]*\n\n## Edition and Platform\n\n - Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n - Version: *[e.g. v0.9.0]*\n - Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n\n*[Add any other context about the problem here.]*	{}	1673965826186	1673965826186	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
a83j1u6smx3ghjb6uq8h53anq1w	2023-01-17 14:30:26.047826+00	cnfbpr65ex78idc8mxzkbg1af9o	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1673965826193	1673965826193	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
a6jhetye7xtf8megtbhzp3zjb3c	2023-01-17 14:30:26.047826+00	cidz4imnqhir48brz6e8hxhfrhy	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1673965826214	1673965826214	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
aknfoqzfy1ffozy46c9jsyfasqw	2023-01-17 14:30:26.047826+00	cidz4imnqhir48brz6e8hxhfrhy	1	text	## Requirements\n- [Requirement 1]\n- [Requirement 2]\n- ...	{}	1673965826224	1673965826224	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
axakofzpzair1pee8y7wne99aqo	2023-01-17 14:30:26.047826+00	cqpo6e8jq83fzbc5qodyza7h4xo	1	text	## Summary\n*[Brief description of what this epic is about]*\n\n## Motivation\n*[Brief description on why this is needed]*\n\n## Acceptance Criteria\n - *[Criteron 1]*\n - *[Criteron 2]*\n - ...\n\n## Personas\n - *[Persona A]*\n - *[Persona B]*\n - ...\n\n## Reference Materials\n - *[Links to other relevant documents as needed]*\n - ...	{}	1673965826232	1673965826232	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
77mn3imeqqpgi5mmoegdg9mfzow	2023-01-17 14:30:26.047826+00	ctrzp9m4883n6uqf8ddo3ppg8kw	1	image		{"fileId":"7pbp4qg415pbstc6enzeicnu3qh.png"}	1673965826239	1673965826239	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
akp54muj8mbrtbyoswn17bcprky	2023-01-17 14:30:26.047826+00	ctrzp9m4883n6uqf8ddo3ppg8kw	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1673965826244	1673965826244	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
a6pmhwjs5zpfwdr3ygbeo9z43ac	2023-01-17 14:30:26.047826+00	ctrzp9m4883n6uqf8ddo3ppg8kw	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1673965826251	1673965826251	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
aemyu5s95g3nyxkr7jdr7w4p3hh	2023-01-17 14:30:26.047826+00	cwrq9ag3p5pgzzy98nfd3wwra1w	1	text	## Summary\n[Brief description of what this epic is about]\n\n## Motivation\n[Brief description on why this is needed]\n\n## Acceptance Criteria\n - [Criteron 1]\n - [Criteron 2]\n - ...\n\n## Personas\n - [Persona A]\n - [Persona B]\n - ...\n\n## Reference Materials\n - [Links to other relevant documents as needed]\n - ...	{}	1673965826269	1673965826269	0	\N	system		system	bxf4mbdcr8fdrbga53r9zwrydpr
cfu8j6oqnupyoini7ygti8yboeh	2023-01-17 14:30:26.527051+00	buixxjic3xjfkieees4iafdrznc	1	card	Drag cards	{"contentOrder":["apktbgtee5jb8xrnqy3ibiujxew","aotzma3fj7jb3mkd9qdqyjsngiw"],"icon":"🤏","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#dragging-cards","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1673965826538	1673965826538	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
ax94qnw8bj3dd8nf66fjx7zkxrh	2023-01-17 14:30:26.527051+00	c1c6ht51zaiyymp156jtx5zgsfr	1	text	To share a card, you'll need to copy the card link first. You can:\n\n- Open a card and select the options menu button at the top right of the card.\n- Open the board view and hover your mouse over any card to access the options menu button.	{}	1673965826776	1673965826776	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
ckpdjgzmdmffn5k5rhh1w9zt8qy	2023-01-17 14:30:26.527051+00	buixxjic3xjfkieees4iafdrznc	1	card	Manage tasks with cards	{"contentOrder":["apbnbfbd4s7neik7rjuotwwgb8o","7f3nm7y5nmfb99qjwcgk8dqih3a","7fq671whz9tgh7x489mupem8fkc","784uu3ufcgb878ky7hyugmf6xcw","7g57zni3iipnw9chkfarj7yuk3r","75b1ygdbchpyzjc7pnnxn5mf9ye","7t5mks7dojifwpq5zpq6p6z4yer","7nb8y7jyoetro8cd36qcju53z8c","7ojx4xy4tdinyxr75oytkn5kqoc","7efqjg7e36jgh9yawa7c3n1wmto","76nwb9tqfsid5jx46yw34itqima","7dy3mcgzgybf1ifa3emgewkzj7e","a5ca6tii33bfw8ba36y1rswq3he","7876od6xhffr6fy69zeogag7eyw","7x7bq9awkatbm5x4docbh5gaw4y","7ghpx9qff43dgtke1rwidmge1ho","7nb8y7jyoetro8cd36qcju53z8c","7hdyxemhbytfm3m83g88djq9nhr","7pgnejxokubbe9kdrxj6g9qa41e","7hw9z6qtx8jyizkmm9g5yq3gxcy","7gk6ooz6npbb8by5rgp9aig7tua","753kd51ce9pnh3b9h8o5dsubm1o"],"icon":"☑️","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"amm6wfhnbuxojwssyftgs9dipqe","acypkejeb5yfujhj9te57p9kaxw":"aanaehcw3m13jytujsjk5hpf6ry"}}	1673965826547	1673965826547	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
ci14cqa8ec7d3pdmj5n5frebi6w	2023-01-17 14:30:26.527051+00	buixxjic3xjfkieees4iafdrznc	1	card	Create your own board	{"contentOrder":["ahgtghf83ptnmik6axwit1az7yw","adrz5i3xwmf8odnb9cpu4kwpwtw","7r9my1yuddbn45dojrfht3neg8c","7eir5gdjxgjbsxpbyp3df4npcze","73zdd8fcn5tyq5pqaog1e7qqj3e"],"icon":"📋","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#adding-new-boards","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"amm6wfhnbuxojwssyftgs9dipqe","acypkejeb5yfujhj9te57p9kaxw":"aanaehcw3m13jytujsjk5hpf6ry"}}	1673965826552	1673965826552	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
c3dhsp8oujpd3dpukr53z74icre	2023-01-17 14:30:26.527051+00	buixxjic3xjfkieees4iafdrznc	1	card	Share a board	{"contentOrder":["a898ujqat8jyf8kx6akjsz6pm7r","arzamptbrz7ro3cx54o9kinybmo","7r7asyew8d7fyunf4sow8e5iyoc","ad8j3n8tp77bppee3ipjt6odgpe","7w935usqt6pby8qz9x5pxaj7iow","7ogbs8h6q4j8z7ngy1m7eag63nw","7z1jau5qy3jfcxdp5cgq3duk6ne","7rhxzxym9dtn7dxggm8m4ynbrwe"],"icon":"📤","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/sharing-boards.html","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1673965826558	1673965826558	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
cgcj5hcy4g7rrjfeniqeym9kcbc	2023-01-17 14:30:26.527051+00	buixxjic3xjfkieees4iafdrznc	1	card	Create a new card	{"contentOrder":["a6mycyg9gnpbhi88appsymaipqe","adhsx4h5ss7rqdcjt8xyam6xtqc","azdeaa64e5i88zkgx8uewjdypdw","7me9p46gbqiyfmfnapi7dyxb5br","7cegndysz7ifnuns5wu519x17zr"],"icon":"📝","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#adding-cards","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"amm6wfhnbuxojwssyftgs9dipqe","acypkejeb5yfujhj9te57p9kaxw":"aanaehcw3m13jytujsjk5hpf6ry"}}	1673965826563	1673965826563	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
c1c6ht51zaiyymp156jtx5zgsfr	2023-01-17 14:30:26.527051+00	buixxjic3xjfkieees4iafdrznc	1	card	Share cards on Channels	{"contentOrder":["a8d61nnahmpdsfpercx7jwi8wor","ax94qnw8bj3dd8nf66fjx7zkxrh","asxegfq1wb7fk7bd55xkxfait8o","7eejdg1thpib9pyreu6gy369gwr"],"icon":"📮","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html#share-card-previews","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"af3p8ztcyxgn8wd9z4az7o9tjeh","acypkejeb5yfujhj9te57p9kaxw":"ascd7nm9r491ayot8i86g1gmgqw"}}	1673965826569	1673965826569	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
c5p3r9atiy3yru8xea5d9bbsbty	2023-01-17 14:30:26.527051+00	buixxjic3xjfkieees4iafdrznc	1	card	Filter and sort cards	{"contentOrder":["a4fz9kcfs9ibj8puk9mux7ac94c","akfdht7kxsjgzbfrsmdoz6n6gre","78i8aqjmqtibr7x4okhz6uqquqr","7my578kmydbg39y8shoftqxwaie"],"icon":"🎛️","isTemplate":false,"properties":{"a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1673965826575	1673965826575	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
ckftks9u5m78kmneaz5o47mx7iw	2023-01-17 14:30:26.527051+00	buixxjic3xjfkieees4iafdrznc	1	card	Create a new view	{"contentOrder":["aozbezukpgif3jpbsq7tahmmp5e","aosutffqcdbg7urzcwbiop5yi1c","7owai1ux3h3gtf8byynfk6hyx1c","7n8jq1dizyfgotby3o91arf1hxh","77y4wffj1ctg7xmm9bx45qn6q6o","7e4ztjeyq5frxurczh1py55kzfc"],"icon":"👓","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#adding-new-views","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"af3p8ztcyxgn8wd9z4az7o9tjeh","acypkejeb5yfujhj9te57p9kaxw":"ascd7nm9r491ayot8i86g1gmgqw"}}	1673965826582	1673965826582	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
c89tpotyoxj8ijg478ax1eakkae	2023-01-17 14:30:26.527051+00	buixxjic3xjfkieees4iafdrznc	1	card	Add new properties	{"contentOrder":["a6dgzc58qpjdgmf4hetwannqgrr","ayhk11qsuz789fk8bqae4oz8mro","7gc3z8cf8rirgfyutwoke9nn6jy","76cinqnb6k3dzmfbm9fnc8eofny","745wuyjha7jd79xk9w3gy8rdcxw"],"icon":"🏷️","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html#add-and-manage-properties","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"af3p8ztcyxgn8wd9z4az7o9tjeh","acypkejeb5yfujhj9te57p9kaxw":"ascd7nm9r491ayot8i86g1gmgqw"}}	1673965826589	1673965826589	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
c8gpmwuttbi8uzmrwu1hte1suyr	2023-01-17 14:30:26.527051+00	buixxjic3xjfkieees4iafdrznc	1	card	@mention teammates	{"contentOrder":["a7rczjrgxujgoikedmpgybjn15r","asoxr8btn5t8tffrk5ryfrdt61y","7mbw9t71hjbrydgzgkqqaoh8usr","73xu1gpk5jiruxdog6eurf1ubgh"],"icon":"🔔","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html#mention-people","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1673965826595	1673965826595	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
vzw4rux56gbdztc5kcfeqk9c6ph	2023-01-17 14:30:26.527051+00	buixxjic3xjfkieees4iafdrznc	1	view	Preview: Table View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":280,"a972dc7a-5f4c-45d2-8044-8c28c69717f1":100,"acypkejeb5yfujhj9te57p9kaxw":169},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a972dc7a-5f4c-45d2-8044-8c28c69717f1","aqh13jabwexjkzr3jqsz1i1syew","acmg7mz1rr1eykfug4hcdpb1y1o","acypkejeb5yfujhj9te57p9kaxw"]}	1673965826602	1673965826602	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
vttwjtchsf3butcchiaa1za3pdo	2023-01-17 14:30:26.527051+00	buixxjic3xjfkieees4iafdrznc	1	view	Preview: Calendar View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"acmg7mz1rr1eykfug4hcdpb1y1o","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1673965826607	1673965826607	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
vo6hrpqyuriym5kdg4h67g1tyqc	2023-01-17 14:30:26.527051+00	buixxjic3xjfkieees4iafdrznc	1	view	Onboarding	{"cardOrder":["cgcj5hcy4g7rrjfeniqeym9kcbc","ckpdjgzmdmffn5k5rhh1w9zt8qy","ci14cqa8ec7d3pdmj5n5frebi6w","c1c6ht51zaiyymp156jtx5zgsfr","c89tpotyoxj8ijg478ax1eakkae","ckftks9u5m78kmneaz5o47mx7iw","c8gpmwuttbi8uzmrwu1hte1suyr","cfu8j6oqnupyoini7ygti8yboeh","c3dhsp8oujpd3dpukr53z74icre","c5p3r9atiy3yru8xea5d9bbsbty"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a972dc7a-5f4c-45d2-8044-8c28c69717f1","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["aqb5x3pt87dcc9stbk4ofodrpoy","a1mtm777bkagq3iuu7xo9b13qfr","auxbwzptiqzkii5r61uz3ndsy1r","aj9386k1bx8qwmepeuxg3b7z4pw"],"visiblePropertyIds":[]}	1673965826618	1673965826618	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
aotzma3fj7jb3mkd9qdqyjsngiw	2023-01-17 14:30:26.527051+00	cfu8j6oqnupyoini7ygti8yboeh	1	text	Mattermost Boards makes it easy for you to update certain properties on cards through our drag and drop functionality. Simply drag this card from the **Later** column to the **Completed** column to automatically update the status and mark this task as complete.	{}	1673965826623	1673965826623	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
7g57zni3iipnw9chkfarj7yuk3r	2023-01-17 14:30:26.527051+00	ckpdjgzmdmffn5k5rhh1w9zt8qy	1	checkbox	Assign tasks to teammates	{"value":false}	1673965826628	1673965826628	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
753kd51ce9pnh3b9h8o5dsubm1o	2023-01-17 14:30:26.527051+00	ckpdjgzmdmffn5k5rhh1w9zt8qy	1	checkbox	Create and manage checklists, like this one... :)	{"value":false}	1673965826635	1673965826635	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
75b1ygdbchpyzjc7pnnxn5mf9ye	2023-01-17 14:30:26.527051+00	ckpdjgzmdmffn5k5rhh1w9zt8qy	1	checkbox	Add and update descriptions with Markdown	{"value":false}	1673965826639	1673965826639	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
7ojx4xy4tdinyxr75oytkn5kqoc	2023-01-17 14:30:26.527051+00	ckpdjgzmdmffn5k5rhh1w9zt8qy	1	checkbox	Follow cards to get notified on the latest updates	{"value":false}	1673965826645	1673965826645	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
7f3nm7y5nmfb99qjwcgk8dqih3a	2023-01-17 14:30:26.527051+00	ckpdjgzmdmffn5k5rhh1w9zt8qy	1	checkbox	Set priorities and update statuses	{"value":false}	1673965826652	1673965826652	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
7t5mks7dojifwpq5zpq6p6z4yer	2023-01-17 14:30:26.527051+00	ckpdjgzmdmffn5k5rhh1w9zt8qy	1	checkbox	Provide feedback and ask questions via comments	{"value":false}	1673965826658	1673965826658	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
7efqjg7e36jgh9yawa7c3n1wmto	2023-01-17 14:30:26.527051+00	ckpdjgzmdmffn5k5rhh1w9zt8qy	1	checkbox	@mention teammates so they can follow, and collaborate on, comments and descriptions	{"value":false}	1673965826667	1673965826667	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
7fq671whz9tgh7x489mupem8fkc	2023-01-17 14:30:26.527051+00	ckpdjgzmdmffn5k5rhh1w9zt8qy	1	checkbox	Manage deadlines and milestones	{"value":false}	1673965826676	1673965826676	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
apbnbfbd4s7neik7rjuotwwgb8o	2023-01-17 14:30:26.527051+00	ckpdjgzmdmffn5k5rhh1w9zt8qy	1	text	Cards allow your entire team to manage and collaborate on a task in one place. Within a card, your team can:	{}	1673965826679	1673965826679	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
73zdd8fcn5tyq5pqaog1e7qqj3e	2023-01-17 14:30:26.527051+00	ci14cqa8ec7d3pdmj5n5frebi6w	1	image		{"fileId":"74uia99m9btr8peydw7oexn37tw.gif"}	1673965826682	1673965826682	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
ahgtghf83ptnmik6axwit1az7yw	2023-01-17 14:30:26.527051+00	ci14cqa8ec7d3pdmj5n5frebi6w	1	text	A board helps you manage your project, organize tasks, and collaborate with your team all in one place.	{}	1673965826684	1673965826684	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
adrz5i3xwmf8odnb9cpu4kwpwtw	2023-01-17 14:30:26.527051+00	ci14cqa8ec7d3pdmj5n5frebi6w	1	text	To create your own board, select the "+" on the top of the left hand sidebar. Choose from one of our standard templates and see how they can help you get started with your next project:\n\n- **Project Tasks**: Stay on top of your project tasks, track progress, and set priorities. \n- **Meeting Agenda**: Set your meeting agendas for recurring team meetings and 1:1s.\n- **Roadmap**: Plan your roadmap and manage your releases more efficiently.\n- **Personal Tasks**: Organize your life and track your personal tasks.\n- **Content Calendar**: Plan your editorial content, assign work, and track deadlines.\n- **Personal Goals**: Set and accomplish new personal goals and milestones.	{}	1673965826698	1673965826698	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
7rhxzxym9dtn7dxggm8m4ynbrwe	2023-01-17 14:30:26.527051+00	c3dhsp8oujpd3dpukr53z74icre	1	image		{"fileId":"7knxbyuiedtdafcgmropgkrtybr.gif"}	1673965826724	1673965826724	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
a898ujqat8jyf8kx6akjsz6pm7r	2023-01-17 14:30:26.527051+00	c3dhsp8oujpd3dpukr53z74icre	1	text	Keep stakeholders and customers up-to-date on project progress by sharing your board.	{}	1673965826738	1673965826738	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
arzamptbrz7ro3cx54o9kinybmo	2023-01-17 14:30:26.527051+00	c3dhsp8oujpd3dpukr53z74icre	1	text	To share a board, select **Share** at the top right of the Board view. Copy the link to share the board internally with your team or generate public link that can be accessed by anyone externally.	{}	1673965826748	1673965826748	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
7cegndysz7ifnuns5wu519x17zr	2023-01-17 14:30:26.527051+00	cgcj5hcy4g7rrjfeniqeym9kcbc	1	image		{"fileId":"7iw4rxx7jj7bypmdotd9z469cyh.png"}	1673965826752	1673965826752	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
azdeaa64e5i88zkgx8uewjdypdw	2023-01-17 14:30:26.527051+00	cgcj5hcy4g7rrjfeniqeym9kcbc	1	text	To create a new card, simply do any of the following:\n- Select "**New**" on the top right header\n- Select "**+ New**" below any column\n- Select "**+**" to the right of any columnn header	{}	1673965826755	1673965826755	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
asxegfq1wb7fk7bd55xkxfait8o	2023-01-17 14:30:26.527051+00	c1c6ht51zaiyymp156jtx5zgsfr	1	text	After you've copied the link, paste it into any channel or Direct Message to share the card. A preview of the card will display within the channel with a link back to the card on Boards.	{}	1673965826773	1673965826773	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
a8d61nnahmpdsfpercx7jwi8wor	2023-01-17 14:30:26.527051+00	c1c6ht51zaiyymp156jtx5zgsfr	1	text	Cards can be linked and shared with teammates directly on Channels. Card previews are displayed when shared on Channels, so your team can discuss work items and get the relevant context without having to switch over to Boards.	{}	1673965826782	1673965826782	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
7my578kmydbg39y8shoftqxwaie	2023-01-17 14:30:26.527051+00	c5p3r9atiy3yru8xea5d9bbsbty	1	image		{"fileId":"7dybb6t8fj3nrdft7nerhuf784y.png"}	1673965826804	1673965826804	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
akfdht7kxsjgzbfrsmdoz6n6gre	2023-01-17 14:30:26.527051+00	c5p3r9atiy3yru8xea5d9bbsbty	1	text	Organize and find the cards you're looking for with our filter, sort, and grouping options. From the Board header, you can quickly toggle on different properties, change the group display, set filters, and change how the cards are sorted.	{}	1673965826809	1673965826809	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
7e4ztjeyq5frxurczh1py55kzfc	2023-01-17 14:30:26.527051+00	ckftks9u5m78kmneaz5o47mx7iw	1	image		{"fileId":"78jws5m1myf8pufewzkaa6i11sc.gif"}	1673965826834	1673965826834	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
aosutffqcdbg7urzcwbiop5yi1c	2023-01-17 14:30:26.527051+00	ckftks9u5m78kmneaz5o47mx7iw	1	text	Views allow your team to visualize the same cards and data from different perspectives, so they can stay up-to-date in the way that works best for them. To add a new view, go to **Add a new view** from the view drop-down, then select from any of the following views:\n\n- **Board**: Adds a Kanban board, similar to this one, that allows your team to organize cards in swimlanes grouped by any property of your choosing. This view helps you visualize your project progress.\n- **Table**: Displays cards in a table format with rows and columns. Use this view to get an overview of all your project tasks. Easily view and compare the state of all properties across all cards without needing to open individual cards.\n- **Gallery**: Displays cards in a gallery format, so you can manage and organize cards with image attachments.\n- **Calendar**: Adds a calendar view to easily visualize your cards by dates and keep track of deadlines.	{}	1673965826837	1673965826837	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
745wuyjha7jd79xk9w3gy8rdcxw	2023-01-17 14:30:26.527051+00	c89tpotyoxj8ijg478ax1eakkae	1	image		{"fileId":"7d6hrtig3zt8f9cnbo1um5oxx3y.gif"}	1673965826842	1673965826842	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
a6dgzc58qpjdgmf4hetwannqgrr	2023-01-17 14:30:26.527051+00	c89tpotyoxj8ijg478ax1eakkae	1	text	Customize cards to fit your needs and track the information most important to you. Boards supports a wide range of fully customizable property types. For example, you can:\n- Use the **Date** property for things like deadlines or milestones.\n- Assign owners to tasks with the **Person** property.\n- Define statuses and priorities with the **Select** property.\n- Create tags with the **Multi Select** property.\n- Link cards to webpages with the **URL** property.	{}	1673965826845	1673965826845	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
73xu1gpk5jiruxdog6eurf1ubgh	2023-01-17 14:30:26.527051+00	c8gpmwuttbi8uzmrwu1hte1suyr	1	image		{"fileId":"74nt9eqzea3ydjjpgjtsxcjgrxc.gif"}	1673965826873	1673965826873	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
asoxr8btn5t8tffrk5ryfrdt61y	2023-01-17 14:30:26.527051+00	c8gpmwuttbi8uzmrwu1hte1suyr	1	text	To mention a teammate use the **@ symbol with their username** in the comments or description section. They'll get a Direct Message notification via Channels and also be added as a [follower](https://docs.mattermost.com/boards/work-with-cards.html#receive-updates) to the card. \n\nWhenever any changes are made to the card, they'll automatically get notified on Channels.	{}	1673965826883	1673965826883	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
a7rczjrgxujgoikedmpgybjn15r	2023-01-17 14:30:26.527051+00	c8gpmwuttbi8uzmrwu1hte1suyr	1	text	Collaborate with teammates directly on each card using @mentions and have all the relevant context in one place.	{}	1673965826886	1673965826886	0	\N	system		system	bo47rmr9x6jyuffzi8wjhz9fpgo
\.


--
-- Data for Name: focalboard_board_members; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_board_members (board_id, user_id, roles, scheme_admin, scheme_editor, scheme_commenter, scheme_viewer) FROM stdin;
bdt9z31x7mpryx8y7ocrkepnn8a	system		t	f	f	f
brdnxu4msb3ns3deuiewy9w9oyo	system		t	f	f	f
bhdz6wki5stn9zmhgn9bg8uprbh	system		t	f	f	f
batppw5i74tr8drq8hjiokfdxaw	system		t	f	f	f
baib5iktj5bdnjqnq67rayaidgr	system		t	f	f	f
bng8baqwambb6bxwewinmuuno3y	system		t	f	f	f
brsotn1kutjgpbxf95tq4p94iya	system		t	f	f	f
bky8mjzqy9incxk3gjqwiatz6xa	system		t	f	f	f
b9ejcs37rcjfdde8b49oabrj6kh	system		t	f	f	f
benutoyfd6byx5mxw5rbwtiqg9h	system		t	f	f	f
bbr1copn6i7yu5y9sqk1ijg49qa	system		t	f	f	f
bxf4mbdcr8fdrbga53r9zwrydpr	system		t	f	f	f
bo47rmr9x6jyuffzi8wjhz9fpgo	system		t	f	f	f
\.


--
-- Data for Name: focalboard_board_members_history; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_board_members_history (board_id, user_id, action, insert_at) FROM stdin;
bdt9z31x7mpryx8y7ocrkepnn8a	system	created	2023-01-17 14:30:22.430159+00
brdnxu4msb3ns3deuiewy9w9oyo	system	created	2023-01-17 14:30:23.556891+00
bhdz6wki5stn9zmhgn9bg8uprbh	system	created	2023-01-17 14:30:23.824438+00
batppw5i74tr8drq8hjiokfdxaw	system	created	2023-01-17 14:30:24.571145+00
baib5iktj5bdnjqnq67rayaidgr	system	created	2023-01-17 14:30:24.750368+00
bng8baqwambb6bxwewinmuuno3y	system	created	2023-01-17 14:30:24.858268+00
brsotn1kutjgpbxf95tq4p94iya	system	created	2023-01-17 14:30:25.283458+00
bky8mjzqy9incxk3gjqwiatz6xa	system	created	2023-01-17 14:30:25.48099+00
b9ejcs37rcjfdde8b49oabrj6kh	system	created	2023-01-17 14:30:25.701494+00
benutoyfd6byx5mxw5rbwtiqg9h	system	created	2023-01-17 14:30:25.939352+00
bbr1copn6i7yu5y9sqk1ijg49qa	system	created	2023-01-17 14:30:26.043016+00
bxf4mbdcr8fdrbga53r9zwrydpr	system	created	2023-01-17 14:30:26.496665+00
bo47rmr9x6jyuffzi8wjhz9fpgo	system	created	2023-01-17 14:30:27.186271+00
\.


--
-- Data for Name: focalboard_boards; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_boards (id, insert_at, team_id, channel_id, created_by, modified_by, type, title, description, icon, show_description, is_template, template_version, properties, card_properties, create_at, update_at, delete_at, minimum_role) FROM stdin;
bdt9z31x7mpryx8y7ocrkepnn8a	2023-01-17 14:30:21.922829+00	0		system	system	O	Meeting Agenda 	Use this template for recurring meeting agendas, like team meetings and 1:1's. To use this board:\n* Participants queue new items to discuss under "To Discuss"\n* Go through items during the meeting\n* Move items to Done or Revisit Later as needed	🍩	t	t	6	{"trackingTemplateId": "54fcf9c610f0ac5e4c522c0657c90602"}	[{"id": "d777ba3b-8728-40d1-87a6-59406bbbbfb0", "name": "Status", "type": "select", "options": [{"id": "34eb9c25-d5bf-49d9-859e-f74f4e0030e7", "color": "propColorPink", "value": "To Discuss 💬"}, {"id": "d37a61f4-f332-4db9-8b2d-5e0a91aa20ed", "color": "propColorYellow", "value": "Revisit Later ⏳"}, {"id": "dabadd9b-adf1-4d9f-8702-805ac6cef602", "color": "propColorGreen", "value": "Done / Archived 📦"}]}, {"id": "4cf1568d-530f-4028-8ffd-bdc65249187e", "name": "Priority", "type": "select", "options": [{"id": "8b05c83e-a44a-4d04-831e-97f01d8e2003", "color": "propColorRed", "value": "1. High"}, {"id": "b1abafbf-a038-4a19-8b68-56e0fd2319f7", "color": "propColorYellow", "value": "2. Medium"}, {"id": "2491ffaa-eb55-417b-8aff-4bd7d4136613", "color": "propColorGray", "value": "3. Low"}]}, {"id": "aw4w63xhet79y9gueqzzeiifdoe", "name": "Created by", "type": "createdBy", "options": []}, {"id": "a6ux19353xcwfqg9k1inqg5sg4w", "name": "Created time", "type": "createdTime", "options": []}]	1673965821928	1673965821928	0	
brdnxu4msb3ns3deuiewy9w9oyo	2023-01-17 14:30:22.437069+00	0		system	system	O	Sales Pipeline CRM	Use this template to grow and keep track of your sales opportunities.	📈	t	t	6	{"trackingTemplateId": "ecc250bb7dff0fe02247f1110f097544"}	[{"id": "a5hwxjsmkn6bak6r7uea5bx1kwc", "name": "Status", "type": "select", "options": [{"id": "akj61wc9yxdwyw3t6m8igyf9d5o", "color": "propColorGray", "value": "Lead"}, {"id": "aic89a5xox4wbppi6mbyx6ujsda", "color": "propColorYellow", "value": "Qualified"}, {"id": "ah6ehh43rwj88jy4awensin8pcw", "color": "propColorBrown", "value": "Meeting"}, {"id": "aprhd96zwi34o9cs4xyr3o9sf3c", "color": "propColorPurple", "value": "Proposal"}, {"id": "axesd74yuxtbmw1sbk8ufax7z3a", "color": "propColorOrange", "value": "Negotiation"}, {"id": "a5txuiubumsmrs8gsd5jz5gc1oa", "color": "propColorRed", "value": "Lost"}, {"id": "acm9q494bcthyoqzmfogxxy5czy", "color": "propColorGreen", "value": "Closed 🏆"}]}, {"id": "aoheuj1f3mu6eehygr45fxa144y", "name": "Account Owner", "type": "multiPerson", "options": []}, {"id": "aro91wme9kfaie5ceu9qasmtcnw", "name": "Priority", "type": "select", "options": [{"id": "apjnaggwixchfxwiatfh7ey7uno", "color": "propColorRed", "value": "High 🔥"}, {"id": "apiswzj7uiwbh87z8dw8c6mturw", "color": "propColorYellow", "value": "Medium"}, {"id": "auu9bfzqeuruyjwzzqgz7q8apuw", "color": "propColorBrown", "value": "Low"}]}, {"id": "ainpw47babwkpyj77ic4b9zq9xr", "name": "Company", "type": "text", "options": []}, {"id": "ahf43e44h3y8ftanqgzno9z7q7w", "name": "Estimated Value", "type": "number", "options": []}, {"id": "amahgyn9n4twaapg3jyxb6y4jic", "name": "Territory", "type": "select", "options": [{"id": "ar6t1ttcumgfuqugg5o4g4mzrza", "color": "propColorBrown", "value": "Western US"}, {"id": "asbwojkm7zb4ohrtij97jkdfgwe", "color": "propColorGreen", "value": "Mountain West / Central US"}, {"id": "aw8ppwtcrm8iwopdadje3ni196w", "color": "propColorGray", "value": "Mid-Atlantic / Southeast"}, {"id": "aafwyza5iwdcwcyfyj6bp7emufw", "color": "propColorBlue", "value": "Northeast US / Canada"}, {"id": "agw8rcb9uxyt3c7g6tq3r65fgqe", "color": "propColorPink", "value": "Eastern Europe"}, {"id": "as5bk6afoaaa7caewe1zc391sce", "color": "propColorPurple", "value": "Central Europe / Africa"}, {"id": "a8fj94bka8z9t6p95qd3hn6t5re", "color": "propColorYellow", "value": "Middle East"}, {"id": "arpxa3faaou9trt4zx5sh435gne", "color": "propColorOrange", "value": "UK"}, {"id": "azdidd5wze4kcxf8neefj3ctkyr", "color": "propColorRed", "value": "Asia"}, {"id": "a4jn5mhqs3thknqf5opykntgsnc", "color": "propColorGray", "value": "Australia"}, {"id": "afjbgrecb7hp5owj7xh8u4w33tr", "color": "propColorBrown", "value": "Latin America"}]}, {"id": "abru6tz8uebdxy4skheqidh7zxy", "name": "Email", "type": "email", "options": []}, {"id": "a1438fbbhjeffkexmcfhnx99o1h", "name": "Phone", "type": "phone", "options": []}, {"id": "auhf91pm85f73swwidi4wid8jqe", "name": "Last Contact Date", "type": "date", "options": []}, {"id": "adtf1151chornmihz4xbgbk9exa", "name": "Expected Close", "type": "date", "options": []}, {"id": "aejo5tcmq54bauuueem9wc4fw4y", "name": "Close Probability", "type": "text", "options": []}, {"id": "amba7ot98fh7hwsx8jdcfst5g7h", "name": "Created Date", "type": "createdTime", "options": []}]	1673965822443	1673965822443	0	
bhdz6wki5stn9zmhgn9bg8uprbh	2023-01-17 14:30:23.561233+00	0		system	system	O	Personal Tasks 	Use this template to organize your life and track your personal tasks.	✔️	t	t	6	{"trackingTemplateId": "dfb70c146a4584b8a21837477c7b5431"}	[{"id": "a9zf59u8x1rf4ywctpcqama7tio", "name": "Occurrence", "type": "select", "options": [{"id": "an51dnkenmoog9cetapbc4uyt3y", "color": "propColorBlue", "value": "Daily"}, {"id": "afpy8s7i45frggprmfsqngsocqh", "color": "propColorOrange", "value": "Weekly"}, {"id": "aj4jyekqqssatjcq7r7chmy19ey", "color": "propColorPurple", "value": "Monthly"}]}, {"id": "abthng7baedhhtrwsdodeuincqy", "name": "Completed", "type": "checkbox", "options": []}]	1673965823566	1673965823566	0	
batppw5i74tr8drq8hjiokfdxaw	2023-01-17 14:30:23.920434+00	0		system	system	O	Project Tasks 	Use this template to stay on top of your project tasks and progress.	🎯	t	t	6	{"trackingTemplateId": "a4ec399ab4f2088b1051c3cdf1dde4c3"}	[{"id": "a972dc7a-5f4c-45d2-8044-8c28c69717f1", "name": "Status", "type": "select", "options": [{"id": "ayz81h9f3dwp7rzzbdebesc7ute", "color": "propColorBlue", "value": "Not Started"}, {"id": "ar6b8m3jxr3asyxhr8iucdbo6yc", "color": "propColorYellow", "value": "In Progress"}, {"id": "afi4o5nhnqc3smtzs1hs3ij34dh", "color": "propColorRed", "value": "Blocked"}, {"id": "adeo5xuwne3qjue83fcozekz8ko", "color": "propColorGreen", "value": "Completed 🙌"}, {"id": "ahpyxfnnrzynsw3im1psxpkgtpe", "color": "propColorBrown", "value": "Archived"}]}, {"id": "d3d682bf-e074-49d9-8df5-7320921c2d23", "name": "Priority", "type": "select", "options": [{"id": "d3bfb50f-f569-4bad-8a3a-dd15c3f60101", "color": "propColorRed", "value": "1. High 🔥"}, {"id": "87f59784-b859-4c24-8ebe-17c766e081dd", "color": "propColorYellow", "value": "2. Medium"}, {"id": "98a57627-0f76-471d-850d-91f3ed9fd213", "color": "propColorGray", "value": "3. Low"}]}, {"id": "axkhqa4jxr3jcqe4k87g8bhmary", "name": "Assignee", "type": "person", "options": []}, {"id": "a8daz81s4xjgke1ww6cwik5w7ye", "name": "Estimated Hours", "type": "number", "options": []}, {"id": "a3zsw7xs8sxy7atj8b6totp3mby", "name": "Due Date", "type": "date", "options": []}, {"id": "a7gdnz8ff8iyuqmzddjgmgo9ery", "name": "Created By", "type": "createdBy", "options": []}, {"id": "2a5da320-735c-4093-8787-f56e15cdfeed", "name": "Date Created", "type": "createdTime", "options": []}]	1673965823923	1673965823923	0	
baib5iktj5bdnjqnq67rayaidgr	2023-01-17 14:30:24.573381+00	0		system	system	O	Company Goals & OKRs	Use this template to plan your company goals and OKRs more efficiently.	⛳	t	t	6	{"trackingTemplateId": "7ba22ccfdfac391d63dea5c4b8cde0de"}	[{"id": "a6amddgmrzakw66cidqzgk6p4ge", "name": "Objective", "type": "select", "options": [{"id": "auw3afh3kfhrfgmjr8muiz137jy", "color": "propColorGreen", "value": "Grow Revenue"}, {"id": "apqfjst8massbjjhpcsjs3y1yqa", "color": "propColorOrange", "value": "Delight Customers"}, {"id": "ao9b5pxyt7tkgdohzh9oaustdhr", "color": "propColorPurple", "value": "Drive Product Adoption"}]}, {"id": "a17ryhi1jfsboxkwkztwawhmsxe", "name": "Status", "type": "select", "options": [{"id": "a6robxx81diugpjq5jkezz3j1fo", "color": "propColorGray", "value": "Not Started"}, {"id": "a8nukezwwmknqwjsygg7eaxs9te", "color": "propColorBlue", "value": "In Progress"}, {"id": "apnt1f7na9rzgk1rt49keg7xbiy", "color": "propColorYellow", "value": "At Risk"}, {"id": "axbz3m1amss335wzwf9s7pqjzxr", "color": "propColorRed", "value": "Missed"}, {"id": "abzfwnn6rmtfzyq5hg8uqmpsncy", "color": "propColorGreen", "value": "Complete 🙌"}]}, {"id": "azzbawji5bksj69sekcs4srm1ky", "name": "Department", "type": "select", "options": [{"id": "aw5i7hmpadn6mbwbz955ubarhme", "color": "propColorBrown", "value": "Engineering"}, {"id": "afkxpcjqjypu7hhar7banxau91h", "color": "propColorBlue", "value": "Product"}, {"id": "aehoa17cz18rqnrf75g7dwhphpr", "color": "propColorOrange", "value": "Marketing"}, {"id": "agrfeaoj7d8p5ianw5iaf3191ae", "color": "propColorGreen", "value": "Sales"}, {"id": "agm9p6gcq15ueuzqq3wd4be39wy", "color": "propColorYellow", "value": "Support"}, {"id": "aucop7kw6xwodcix6zzojhxih6r", "color": "propColorPink", "value": "Design"}, {"id": "afust91f3g8ht368mkn5x9tgf1o", "color": "propColorPurple", "value": "Finance"}, {"id": "acocxxwjurud1jixhp7nowdig7y", "color": "propColorGray", "value": "Human Resources"}]}, {"id": "adp5ft3kgz7r5iqq3tnwg551der", "name": "Priority", "type": "select", "options": [{"id": "a8zg3rjtf4swh7smsjxpsn743rh", "color": "propColorRed", "value": "P1 🔥"}, {"id": "as555ipyzopjjpfb5rjtssecw5e", "color": "propColorYellow", "value": "P2"}, {"id": "a1ts3ftyr8nocsicui98c89uxjy", "color": "propColorGray", "value": "P3"}]}, {"id": "aqxyzkdrs4egqf7yk866ixkaojc", "name": "Quarter", "type": "select", "options": [{"id": "ahfbn1jsmhydym33ygxwg5jt3kh", "color": "propColorBlue", "value": "Q1"}, {"id": "awfu37js3fomfkkczm1zppac57a", "color": "propColorBrown", "value": "Q2"}, {"id": "anruuoyez51r3yjxuoc8zoqnwaw", "color": "propColorGreen", "value": "Q3"}, {"id": "acb6dqqs6yson7bbzx6jk9bghjh", "color": "propColorPurple", "value": "Q4"}]}, {"id": "adu6mebzpibq6mgcswk69xxmnqe", "name": "Due Date", "type": "date", "options": []}, {"id": "asope3bddhm4gpsng5cfu4hf6rh", "name": "Assignee", "type": "multiPerson", "options": []}, {"id": "ajwxp866f9obs1kutfwaa5ru7fe", "name": "Target", "type": "number", "options": []}, {"id": "azqnyswk6s1boiwuthscm78qwuo", "name": "Actual", "type": "number", "options": []}, {"id": "ahz3fmjnaguec8hce7xq3h5cjdr", "name": "Completion (%)", "type": "text", "options": []}, {"id": "a17bfcgnzmkwhziwa4tr38kiw5r", "name": "Note", "type": "text", "options": []}]	1673965824578	1673965824578	0	
bng8baqwambb6bxwewinmuuno3y	2023-01-17 14:30:24.752127+00	0		system	system	O	Personal Goals 	Use this template to set and accomplish new personal goals.	⛰️	t	t	6	{"trackingTemplateId": "7f32dc8d2ae008cfe56554e9363505cc"}	[{"id": "af6fcbb8-ca56-4b73-83eb-37437b9a667d", "name": "Status", "type": "select", "options": [{"id": "bf52bfe6-ac4c-4948-821f-83eaa1c7b04a", "color": "propColorRed", "value": "To Do"}, {"id": "77c539af-309c-4db1-8329-d20ef7e9eacd", "color": "propColorYellow", "value": "Doing"}, {"id": "98bdea27-0cce-4cde-8dc6-212add36e63a", "color": "propColorGreen", "value": "Done 🙌"}]}, {"id": "d9725d14-d5a8-48e5-8de1-6f8c004a9680", "name": "Category", "type": "select", "options": [{"id": "3245a32d-f688-463b-87f4-8e7142c1b397", "color": "propColorPurple", "value": "Life Skills"}, {"id": "80be816c-fc7a-4928-8489-8b02180f4954", "color": "propColorGreen", "value": "Finance"}, {"id": "ffb3f951-b47f-413b-8f1d-238666728008", "color": "propColorOrange", "value": "Health"}]}, {"id": "d6b1249b-bc18-45fc-889e-bec48fce80ef", "name": "Target", "type": "select", "options": [{"id": "9a090e33-b110-4268-8909-132c5002c90e", "color": "propColorBlue", "value": "Q1"}, {"id": "0a82977f-52bf-457b-841b-e2b7f76fb525", "color": "propColorBrown", "value": "Q2"}, {"id": "6e7139e4-5358-46bb-8c01-7b029a57b80a", "color": "propColorGreen", "value": "Q3"}, {"id": "d5371c63-66bf-4468-8738-c4dc4bea4843", "color": "propColorPurple", "value": "Q4"}]}, {"id": "ajy6xbebzopojaenbnmfpgtdwso", "name": "Due Date", "type": "date", "options": []}]	1673965824756	1673965824756	0	
brsotn1kutjgpbxf95tq4p94iya	2023-01-17 14:30:24.861134+00	0		system	system	O	Sprint Planner 	Use this template to plan your sprints and manage your releases more efficiently.	🗓️	t	t	6	{"trackingTemplateId": "99b74e26d2f5d0a9b346d43c0a7bfb09"}	[{"id": "50117d52-bcc7-4750-82aa-831a351c44a0", "name": "Status", "type": "select", "options": [{"id": "aft5bzo7h9aspqgrx3jpy5tzrer", "color": "propColorGray", "value": "Not Started"}, {"id": "abrfos7e7eczk9rqw6y5abadm1y", "color": "propColorOrange", "value": "Next Up"}, {"id": "ax8wzbka5ahs3zziji3pp4qp9mc", "color": "propColorBlue", "value": "In Progress"}, {"id": "atabdfbdmjh83136d5e5oysxybw", "color": "propColorYellow", "value": "In Review"}, {"id": "ace1bzypd586kkyhcht5qqd9eca", "color": "propColorPink", "value": "Approved"}, {"id": "aay656c9m1hzwxc9ch5ftymh3nw", "color": "propColorRed", "value": "Blocked"}, {"id": "a6ghze4iy441qhsh3eijnc8hwze", "color": "propColorGreen", "value": "Complete 🙌"}]}, {"id": "20717ad3-5741-4416-83f1-6f133fff3d11", "name": "Type", "type": "select", "options": [{"id": "424ea5e3-9aa1-4075-8c5c-01b44b66e634", "color": "propColorYellow", "value": "Epic ⛰"}, {"id": "a5yxq8rbubrpnoommfwqmty138h", "color": "propColorGray", "value": "Feature 🏗"}, {"id": "apht1nt5ryukdmxkh6fkfn6rgoy", "color": "propColorOrange", "value": "User Story 📖"}, {"id": "aiycbuo3dr5k4xxbfr7coem8ono", "color": "propColorGreen", "value": "Task ⛏"}, {"id": "aomnawq4551cbbzha9gxnmb3z5w", "color": "propColorRed", "value": "Bug 🐞"}]}, {"id": "60985f46-3e41-486e-8213-2b987440ea1c", "name": "Sprint", "type": "select", "options": [{"id": "c01676ca-babf-4534-8be5-cce2287daa6c", "color": "propColorBrown", "value": "Sprint 1"}, {"id": "ed4a5340-460d-461b-8838-2c56e8ee59fe", "color": "propColorPurple", "value": "Sprint 2"}, {"id": "14892380-1a32-42dd-8034-a0cea32bc7e6", "color": "propColorBlue", "value": "Sprint 3"}]}, {"id": "f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e", "name": "Priority", "type": "select", "options": [{"id": "cb8ecdac-38be-4d36-8712-c4d58cc8a8e9", "color": "propColorRed", "value": "P1 🔥"}, {"id": "e6a7f297-4440-4783-8ab3-3af5ba62ca11", "color": "propColorYellow", "value": "P2"}, {"id": "c62172ea-5da7-4dec-8186-37267d8ee9a7", "color": "propColorGray", "value": "P3"}]}, {"id": "aphg37f7zbpuc3bhwhp19s1ribh", "name": "Assignee", "type": "multiPerson", "options": []}, {"id": "a4378omyhmgj3bex13sj4wbpfiy", "name": "Due Date", "type": "date", "options": []}, {"id": "ai7ajsdk14w7x5s8up3dwir77te", "name": "Story Points", "type": "number", "options": []}, {"id": "a1g6i613dpe9oryeo71ex3c86hy", "name": "Design Link", "type": "url", "options": []}, {"id": "aeomttrbhhsi8bph31jn84sto6h", "name": "Created Time", "type": "createdTime", "options": []}, {"id": "ax9f8so418s6s65hi5ympd93i6a", "name": "Created By", "type": "createdBy", "options": []}]	1673965824867	1673965824867	0	
bky8mjzqy9incxk3gjqwiatz6xa	2023-01-17 14:30:25.286676+00	0		system	system	O	User Research Sessions	Use this template to manage and keep track of all your user research sessions.	🔬	t	t	6	{"trackingTemplateId": "6c345c7f50f6833f78b7d0f08ce450a3"}	[{"id": "aaebj5fyx493eezx6ukxiwydgty", "name": "Status", "type": "select", "options": [{"id": "af6hjb3ysuaxbwnfqpby4wwnkdr", "color": "propColorGray", "value": "Backlog 📒"}, {"id": "aotxum1p5bw3xuzqz3ctjw66yww", "color": "propColorYellow", "value": "Contacted 📞"}, {"id": "a7yq89whddzob1futao4rxk3yzc", "color": "propColorBlue", "value": "Scheduled 📅"}, {"id": "aseqq9hrsua56r3s6nbuirj9eec", "color": "propColorRed", "value": "Cancelled 🚫"}, {"id": "ap93ysuzy1xa7z818r6myrn4h4y", "color": "propColorGreen", "value": "Completed ✔️"}]}, {"id": "akrxgi7p7w14fym3gbynb98t9fh", "name": "Interview Date", "type": "date", "options": []}, {"id": "atg9qu6oe4bjm8jczzsn71ff5me", "name": "Product Area", "type": "select", "options": [{"id": "ahn89mqg9u4igk6pdm7333t8i5h", "color": "propColorGreen", "value": "Desktop App"}, {"id": "aehc83ffays3gh8myz16a8j7k4e", "color": "propColorPurple", "value": "Web App"}, {"id": "a1sxagjgaadym5yrjak6tcup1oa", "color": "propColorBlue", "value": "Mobile App"}]}, {"id": "acjq4t5ymytu8x1f68wkggm7ypc", "name": "Email", "type": "email", "options": []}, {"id": "aphio1s5gkmpdbwoxynim7acw3e", "name": "Interviewer", "type": "multiPerson", "options": []}, {"id": "aqafzdeekpyncwz7m7i54q3iqqy", "name": "Recording URL", "type": "url", "options": []}, {"id": "aify3r761b9w43bqjtskrzi68tr", "name": "Passcode", "type": "text", "options": []}]	1673965825289	1673965825289	0	
benutoyfd6byx5mxw5rbwtiqg9h	2023-01-17 14:30:25.707592+00	0		system	system	O	Content Calendar 	Use this template to plan and organize your editorial content.	📅	t	t	6	{"trackingTemplateId": "c75fbd659d2258b5183af2236d176ab4"}	[{"id": "ae9ar615xoknd8hw8py7mbyr7zo", "name": "Status", "type": "select", "options": [{"id": "awna1nuarjca99m9s4uiy9kwj5h", "color": "propColorGray", "value": "Idea 💡"}, {"id": "a9ana1e9w673o5cp8md4xjjwfto", "color": "propColorOrange", "value": "Draft"}, {"id": "apy9dcd7zmand615p3h53zjqxjh", "color": "propColorPurple", "value": "In Review"}, {"id": "acri4cm3bmay55f7ksztphmtnga", "color": "propColorBlue", "value": "Ready to Publish"}, {"id": "amsowcd9a8e1kid317r7ttw6uzh", "color": "propColorGreen", "value": "Published 🎉"}]}, {"id": "aysx3atqexotgwp5kx6h5i5ancw", "name": "Type", "type": "select", "options": [{"id": "aywiofmmtd3ofgzj95ysky4pjga", "color": "propColorOrange", "value": "Press Release"}, {"id": "apqdgjrmsmx8ngmp7zst51647de", "color": "propColorGreen", "value": "Sponsored Post"}, {"id": "a3woynbjnb7j16e74uw3pubrytw", "color": "propColorPurple", "value": "Customer Story"}, {"id": "aq36k5pkpfcypqb3idw36xdi1fh", "color": "propColorRed", "value": "Product Release"}, {"id": "azn66pmk34adygnizjqhgiac4ia", "color": "propColorGray", "value": "Partnership"}, {"id": "aj8y675weso8kpb6eceqbpj4ruw", "color": "propColorBlue", "value": "Feature Announcement"}, {"id": "a3xky7ygn14osr1mokerbfah5cy", "color": "propColorYellow", "value": "Article"}]}, {"id": "ab6mbock6styfe6htf815ph1mhw", "name": "Channel", "type": "multiSelect", "options": [{"id": "a8xceonxiu4n3c43szhskqizicr", "color": "propColorBrown", "value": "Website"}, {"id": "a3pdzi53kpbd4okzdkz6khi87zo", "color": "propColorGreen", "value": "Blog"}, {"id": "a3d9ux4fmi3anyd11kyipfbhwde", "color": "propColorOrange", "value": "Email"}, {"id": "a8cbbfdwocx73zn3787cx6gacsh", "color": "propColorRed", "value": "Podcast"}, {"id": "aigjtpcaxdp7d6kmctrwo1ztaia", "color": "propColorPink", "value": "Print"}, {"id": "af1wsn13muho59e7ghwaogxy5ey", "color": "propColorBlue", "value": "Facebook"}, {"id": "a47zajfxwhsg6q8m7ppbiqs7jge", "color": "propColorGray", "value": "LinkedIn"}, {"id": "az8o8pfe9hq6s7xaehoqyc3wpyc", "color": "propColorYellow", "value": "Twitter"}]}, {"id": "ao44fz8nf6z6tuj1x31t9yyehcc", "name": "Assignee", "type": "person", "options": []}, {"id": "a39x5cybshwrbjpc3juaakcyj6e", "name": "Due Date", "type": "date", "options": []}, {"id": "agqsoiipowmnu9rdwxm57zrehtr", "name": "Publication Date", "type": "date", "options": []}, {"id": "ap4e7kdg7eip7j3c3oyiz39eaoc", "name": "Link", "type": "url", "options": []}]	1673965825712	1673965825712	0	
bbr1copn6i7yu5y9sqk1ijg49qa	2023-01-17 14:30:25.954832+00	0		system	system	O	Team Retrospective	Use this template at the end of your project or sprint to identify what worked well and what can be improved for the future.	🧭	t	t	6	{"trackingTemplateId": "e4f03181c4ced8edd4d53d33d569a086"}	[{"id": "adjckpdotpgkz7c6wixzw9ipb1e", "name": "Category", "type": "select", "options": [{"id": "aok6pgecm85qe9k5kcphzoe63ma", "color": "propColorGray", "value": "To Discuss 📣"}, {"id": "aq1dwbf661yx337hjcd5q3sbxwa", "color": "propColorGreen", "value": "Went Well 👍"}, {"id": "ar87yh5xmsswqkxmjq1ipfftfpc", "color": "propColorRed", "value": "Didn't Go Well 🚫"}, {"id": "akj3fkmxq7idma55mdt8sqpumyw", "color": "propColorBlue", "value": "Action Items ✅"}]}, {"id": "aspaay76a5wrnuhtqgm97tt3rer", "name": "Details", "type": "text", "options": []}, {"id": "arzsm76s376y7suuhao3tu6efoc", "name": "Created By", "type": "createdBy", "options": []}, {"id": "a8anbe5fpa668sryatcdsuuyh8a", "name": "Created Time", "type": "createdTime", "options": []}]	1673965825957	1673965825957	0	
bxf4mbdcr8fdrbga53r9zwrydpr	2023-01-17 14:30:26.047826+00	0		system	system	O	Roadmap 	Use this template to plan your roadmap and manage your releases more efficiently.	🗺️	t	t	6	{"trackingTemplateId": "b728c6ca730e2cfc229741c5a4712b65"}	[{"id": "50117d52-bcc7-4750-82aa-831a351c44a0", "name": "Status", "type": "select", "options": [{"id": "8c557f69-b0ed-46ec-83a3-8efab9d47ef5", "color": "propColorGray", "value": "Not Started"}, {"id": "ec6d2bc5-df2b-4f77-8479-e59ceb039946", "color": "propColorYellow", "value": "In Progress"}, {"id": "849766ba-56a5-48d1-886f-21672f415395", "color": "propColorGreen", "value": "Complete 🙌"}]}, {"id": "20717ad3-5741-4416-83f1-6f133fff3d11", "name": "Type", "type": "select", "options": [{"id": "424ea5e3-9aa1-4075-8c5c-01b44b66e634", "color": "propColorYellow", "value": "Epic ⛰"}, {"id": "6eea96c9-4c61-4968-8554-4b7537e8f748", "color": "propColorGreen", "value": "Task 🔨"}, {"id": "1fdbb515-edd2-4af5-80fc-437ed2211a49", "color": "propColorRed", "value": "Bug 🐞"}]}, {"id": "60985f46-3e41-486e-8213-2b987440ea1c", "name": "Sprint", "type": "select", "options": [{"id": "c01676ca-babf-4534-8be5-cce2287daa6c", "color": "propColorBrown", "value": "Sprint 1"}, {"id": "ed4a5340-460d-461b-8838-2c56e8ee59fe", "color": "propColorPurple", "value": "Sprint 2"}, {"id": "14892380-1a32-42dd-8034-a0cea32bc7e6", "color": "propColorBlue", "value": "Sprint 3"}]}, {"id": "f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e", "name": "Priority", "type": "select", "options": [{"id": "cb8ecdac-38be-4d36-8712-c4d58cc8a8e9", "color": "propColorRed", "value": "P1 🔥"}, {"id": "e6a7f297-4440-4783-8ab3-3af5ba62ca11", "color": "propColorYellow", "value": "P2"}, {"id": "c62172ea-5da7-4dec-8186-37267d8ee9a7", "color": "propColorGray", "value": "P3"}]}, {"id": "aphg37f7zbpuc3bhwhp19s1ribh", "name": "Assignee", "type": "person", "options": []}, {"id": "a4378omyhmgj3bex13sj4wbpfiy", "name": "Due Date", "type": "date", "options": []}, {"id": "a36o9q1yik6nmar6ri4q4uca7ey", "name": "Created Date", "type": "createdTime", "options": []}, {"id": "ai7ajsdk14w7x5s8up3dwir77te", "name": "Design Link", "type": "url", "options": []}]	1673965826055	1673965826055	0	
b9ejcs37rcjfdde8b49oabrj6kh	2023-01-17 14:30:25.483027+00	0		system	system	O	Competitive Analysis	Use this template to track and stay ahead of the competition.	🗂️	t	t	6	{"trackingTemplateId": "06f4bff367a7c2126fab2380c9dec23c"}	[{"id": "ahzspe59iux8wigra8bg6cg18nc", "name": "Website", "type": "url", "options": []}, {"id": "aozntq4go4nkab688j1s7stqtfc", "name": "Location", "type": "text", "options": []}, {"id": "aiefo7nh9jwisn8b4cgakowithy", "name": "Revenue", "type": "text", "options": []}, {"id": "a6cwaq79b1pdpb97wkanmeyy4er", "name": "Employees", "type": "number", "options": []}, {"id": "an1eerzscfxn6awdfajbg41uz3h", "name": "Founded", "type": "text", "options": []}, {"id": "a1semdhszu1rq17d7et5ydrqqio", "name": "Market Position", "type": "select", "options": [{"id": "arfjpz9by5car71tz3behba8yih", "color": "propColorYellow", "value": "Leader"}, {"id": "abajmr34b8g1916w495xjb35iko", "color": "propColorRed", "value": "Challenger"}, {"id": "abt79uxg5edqojsrrefcnr4eruo", "color": "propColorBlue", "value": "Follower"}, {"id": "aipf3qfgjtkheiayjuxrxbpk9wa", "color": "propColorBrown", "value": "Nicher"}]}, {"id": "aapogff3xoa8ym7xf56s87kysda", "name": "Last updated time", "type": "updatedTime", "options": []}, {"id": "az3jkw3ynd3mqmart7edypey15e", "name": "Last updated by", "type": "updatedBy", "options": []}]	1673965825487	1673965825487	0	
bo47rmr9x6jyuffzi8wjhz9fpgo	2023-01-17 14:30:26.527051+00	0		system	system	O	Welcome to Boards!	Mattermost Boards is an open source project management tool that helps you organize, track, and manage work across teams. Select a card to learn more.	👋	t	t	6	{"trackingTemplateId": "65aba997282f3ac457cd66736fb86915"}	[{"id": "a972dc7a-5f4c-45d2-8044-8c28c69717f1", "name": "Status", "type": "select", "options": [{"id": "amm6wfhnbuxojwssyftgs9dipqe", "color": "propColorRed", "value": "To do 🔥"}, {"id": "af3p8ztcyxgn8wd9z4az7o9tjeh", "color": "propColorYellow", "value": "Next up"}, {"id": "ajurey3xkocs1nwx8di5zx6oe7o", "color": "propColorPurple", "value": "Later"}, {"id": "agkinkjy5983wsk6kppsujajxqw", "color": "propColorGreen", "value": "Completed 🙌"}]}, {"id": "acypkejeb5yfujhj9te57p9kaxw", "name": "Priority", "type": "select", "options": [{"id": "aanaehcw3m13jytujsjk5hpf6ry", "color": "propColorOrange", "value": "1. High"}, {"id": "ascd7nm9r491ayot8i86g1gmgqw", "color": "propColorBrown", "value": "2. Medium"}, {"id": "aq6ukoiciyfctgwyhwzpfss8ghe", "color": "propColorGray", "value": "3. Low"}]}, {"id": "aqh13jabwexjkzr3jqsz1i1syew", "name": "Assignee", "type": "person", "options": []}, {"id": "acmg7mz1rr1eykfug4hcdpb1y1o", "name": "Due Date", "type": "date", "options": []}, {"id": "amewjwfjrtpu8ha73xsrdmxazxr", "name": "Reviewed", "type": "checkbox", "options": []}, {"id": "attzzboqaz6m1sdti5xa7gjnk1e", "name": "Last updated time", "type": "updatedTime", "options": []}, {"id": "a4nfnb5xr3txr5xq7y9ho7kyz6c", "name": "Reference", "type": "url", "options": []}, {"id": "a9gzwi3dt5n55nddej6zcbhxaeh", "name": "Created by", "type": "createdBy", "options": []}]	1673965826531	1673965826531	0	
\.


--
-- Data for Name: focalboard_boards_history; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_boards_history (id, insert_at, team_id, channel_id, created_by, modified_by, type, title, description, icon, show_description, is_template, template_version, properties, card_properties, create_at, update_at, delete_at, minimum_role) FROM stdin;
bdt9z31x7mpryx8y7ocrkepnn8a	2023-01-17 14:30:21.922829+00	0		system	system	O	Meeting Agenda 	Use this template for recurring meeting agendas, like team meetings and 1:1's. To use this board:\n* Participants queue new items to discuss under "To Discuss"\n* Go through items during the meeting\n* Move items to Done or Revisit Later as needed	🍩	t	t	6	{"trackingTemplateId": "54fcf9c610f0ac5e4c522c0657c90602"}	[{"id": "d777ba3b-8728-40d1-87a6-59406bbbbfb0", "name": "Status", "type": "select", "options": [{"id": "34eb9c25-d5bf-49d9-859e-f74f4e0030e7", "color": "propColorPink", "value": "To Discuss 💬"}, {"id": "d37a61f4-f332-4db9-8b2d-5e0a91aa20ed", "color": "propColorYellow", "value": "Revisit Later ⏳"}, {"id": "dabadd9b-adf1-4d9f-8702-805ac6cef602", "color": "propColorGreen", "value": "Done / Archived 📦"}]}, {"id": "4cf1568d-530f-4028-8ffd-bdc65249187e", "name": "Priority", "type": "select", "options": [{"id": "8b05c83e-a44a-4d04-831e-97f01d8e2003", "color": "propColorRed", "value": "1. High"}, {"id": "b1abafbf-a038-4a19-8b68-56e0fd2319f7", "color": "propColorYellow", "value": "2. Medium"}, {"id": "2491ffaa-eb55-417b-8aff-4bd7d4136613", "color": "propColorGray", "value": "3. Low"}]}, {"id": "aw4w63xhet79y9gueqzzeiifdoe", "name": "Created by", "type": "createdBy", "options": []}, {"id": "a6ux19353xcwfqg9k1inqg5sg4w", "name": "Created time", "type": "createdTime", "options": []}]	1673965821928	1673965821928	0	
brdnxu4msb3ns3deuiewy9w9oyo	2023-01-17 14:30:22.437069+00	0		system	system	O	Sales Pipeline CRM	Use this template to grow and keep track of your sales opportunities.	📈	t	t	6	{"trackingTemplateId": "ecc250bb7dff0fe02247f1110f097544"}	[{"id": "a5hwxjsmkn6bak6r7uea5bx1kwc", "name": "Status", "type": "select", "options": [{"id": "akj61wc9yxdwyw3t6m8igyf9d5o", "color": "propColorGray", "value": "Lead"}, {"id": "aic89a5xox4wbppi6mbyx6ujsda", "color": "propColorYellow", "value": "Qualified"}, {"id": "ah6ehh43rwj88jy4awensin8pcw", "color": "propColorBrown", "value": "Meeting"}, {"id": "aprhd96zwi34o9cs4xyr3o9sf3c", "color": "propColorPurple", "value": "Proposal"}, {"id": "axesd74yuxtbmw1sbk8ufax7z3a", "color": "propColorOrange", "value": "Negotiation"}, {"id": "a5txuiubumsmrs8gsd5jz5gc1oa", "color": "propColorRed", "value": "Lost"}, {"id": "acm9q494bcthyoqzmfogxxy5czy", "color": "propColorGreen", "value": "Closed 🏆"}]}, {"id": "aoheuj1f3mu6eehygr45fxa144y", "name": "Account Owner", "type": "multiPerson", "options": []}, {"id": "aro91wme9kfaie5ceu9qasmtcnw", "name": "Priority", "type": "select", "options": [{"id": "apjnaggwixchfxwiatfh7ey7uno", "color": "propColorRed", "value": "High 🔥"}, {"id": "apiswzj7uiwbh87z8dw8c6mturw", "color": "propColorYellow", "value": "Medium"}, {"id": "auu9bfzqeuruyjwzzqgz7q8apuw", "color": "propColorBrown", "value": "Low"}]}, {"id": "ainpw47babwkpyj77ic4b9zq9xr", "name": "Company", "type": "text", "options": []}, {"id": "ahf43e44h3y8ftanqgzno9z7q7w", "name": "Estimated Value", "type": "number", "options": []}, {"id": "amahgyn9n4twaapg3jyxb6y4jic", "name": "Territory", "type": "select", "options": [{"id": "ar6t1ttcumgfuqugg5o4g4mzrza", "color": "propColorBrown", "value": "Western US"}, {"id": "asbwojkm7zb4ohrtij97jkdfgwe", "color": "propColorGreen", "value": "Mountain West / Central US"}, {"id": "aw8ppwtcrm8iwopdadje3ni196w", "color": "propColorGray", "value": "Mid-Atlantic / Southeast"}, {"id": "aafwyza5iwdcwcyfyj6bp7emufw", "color": "propColorBlue", "value": "Northeast US / Canada"}, {"id": "agw8rcb9uxyt3c7g6tq3r65fgqe", "color": "propColorPink", "value": "Eastern Europe"}, {"id": "as5bk6afoaaa7caewe1zc391sce", "color": "propColorPurple", "value": "Central Europe / Africa"}, {"id": "a8fj94bka8z9t6p95qd3hn6t5re", "color": "propColorYellow", "value": "Middle East"}, {"id": "arpxa3faaou9trt4zx5sh435gne", "color": "propColorOrange", "value": "UK"}, {"id": "azdidd5wze4kcxf8neefj3ctkyr", "color": "propColorRed", "value": "Asia"}, {"id": "a4jn5mhqs3thknqf5opykntgsnc", "color": "propColorGray", "value": "Australia"}, {"id": "afjbgrecb7hp5owj7xh8u4w33tr", "color": "propColorBrown", "value": "Latin America"}]}, {"id": "abru6tz8uebdxy4skheqidh7zxy", "name": "Email", "type": "email", "options": []}, {"id": "a1438fbbhjeffkexmcfhnx99o1h", "name": "Phone", "type": "phone", "options": []}, {"id": "auhf91pm85f73swwidi4wid8jqe", "name": "Last Contact Date", "type": "date", "options": []}, {"id": "adtf1151chornmihz4xbgbk9exa", "name": "Expected Close", "type": "date", "options": []}, {"id": "aejo5tcmq54bauuueem9wc4fw4y", "name": "Close Probability", "type": "text", "options": []}, {"id": "amba7ot98fh7hwsx8jdcfst5g7h", "name": "Created Date", "type": "createdTime", "options": []}]	1673965822443	1673965822443	0	
bhdz6wki5stn9zmhgn9bg8uprbh	2023-01-17 14:30:23.561233+00	0		system	system	O	Personal Tasks 	Use this template to organize your life and track your personal tasks.	✔️	t	t	6	{"trackingTemplateId": "dfb70c146a4584b8a21837477c7b5431"}	[{"id": "a9zf59u8x1rf4ywctpcqama7tio", "name": "Occurrence", "type": "select", "options": [{"id": "an51dnkenmoog9cetapbc4uyt3y", "color": "propColorBlue", "value": "Daily"}, {"id": "afpy8s7i45frggprmfsqngsocqh", "color": "propColorOrange", "value": "Weekly"}, {"id": "aj4jyekqqssatjcq7r7chmy19ey", "color": "propColorPurple", "value": "Monthly"}]}, {"id": "abthng7baedhhtrwsdodeuincqy", "name": "Completed", "type": "checkbox", "options": []}]	1673965823566	1673965823566	0	
batppw5i74tr8drq8hjiokfdxaw	2023-01-17 14:30:23.920434+00	0		system	system	O	Project Tasks 	Use this template to stay on top of your project tasks and progress.	🎯	t	t	6	{"trackingTemplateId": "a4ec399ab4f2088b1051c3cdf1dde4c3"}	[{"id": "a972dc7a-5f4c-45d2-8044-8c28c69717f1", "name": "Status", "type": "select", "options": [{"id": "ayz81h9f3dwp7rzzbdebesc7ute", "color": "propColorBlue", "value": "Not Started"}, {"id": "ar6b8m3jxr3asyxhr8iucdbo6yc", "color": "propColorYellow", "value": "In Progress"}, {"id": "afi4o5nhnqc3smtzs1hs3ij34dh", "color": "propColorRed", "value": "Blocked"}, {"id": "adeo5xuwne3qjue83fcozekz8ko", "color": "propColorGreen", "value": "Completed 🙌"}, {"id": "ahpyxfnnrzynsw3im1psxpkgtpe", "color": "propColorBrown", "value": "Archived"}]}, {"id": "d3d682bf-e074-49d9-8df5-7320921c2d23", "name": "Priority", "type": "select", "options": [{"id": "d3bfb50f-f569-4bad-8a3a-dd15c3f60101", "color": "propColorRed", "value": "1. High 🔥"}, {"id": "87f59784-b859-4c24-8ebe-17c766e081dd", "color": "propColorYellow", "value": "2. Medium"}, {"id": "98a57627-0f76-471d-850d-91f3ed9fd213", "color": "propColorGray", "value": "3. Low"}]}, {"id": "axkhqa4jxr3jcqe4k87g8bhmary", "name": "Assignee", "type": "person", "options": []}, {"id": "a8daz81s4xjgke1ww6cwik5w7ye", "name": "Estimated Hours", "type": "number", "options": []}, {"id": "a3zsw7xs8sxy7atj8b6totp3mby", "name": "Due Date", "type": "date", "options": []}, {"id": "a7gdnz8ff8iyuqmzddjgmgo9ery", "name": "Created By", "type": "createdBy", "options": []}, {"id": "2a5da320-735c-4093-8787-f56e15cdfeed", "name": "Date Created", "type": "createdTime", "options": []}]	1673965823923	1673965823923	0	
baib5iktj5bdnjqnq67rayaidgr	2023-01-17 14:30:24.573381+00	0		system	system	O	Company Goals & OKRs	Use this template to plan your company goals and OKRs more efficiently.	⛳	t	t	6	{"trackingTemplateId": "7ba22ccfdfac391d63dea5c4b8cde0de"}	[{"id": "a6amddgmrzakw66cidqzgk6p4ge", "name": "Objective", "type": "select", "options": [{"id": "auw3afh3kfhrfgmjr8muiz137jy", "color": "propColorGreen", "value": "Grow Revenue"}, {"id": "apqfjst8massbjjhpcsjs3y1yqa", "color": "propColorOrange", "value": "Delight Customers"}, {"id": "ao9b5pxyt7tkgdohzh9oaustdhr", "color": "propColorPurple", "value": "Drive Product Adoption"}]}, {"id": "a17ryhi1jfsboxkwkztwawhmsxe", "name": "Status", "type": "select", "options": [{"id": "a6robxx81diugpjq5jkezz3j1fo", "color": "propColorGray", "value": "Not Started"}, {"id": "a8nukezwwmknqwjsygg7eaxs9te", "color": "propColorBlue", "value": "In Progress"}, {"id": "apnt1f7na9rzgk1rt49keg7xbiy", "color": "propColorYellow", "value": "At Risk"}, {"id": "axbz3m1amss335wzwf9s7pqjzxr", "color": "propColorRed", "value": "Missed"}, {"id": "abzfwnn6rmtfzyq5hg8uqmpsncy", "color": "propColorGreen", "value": "Complete 🙌"}]}, {"id": "azzbawji5bksj69sekcs4srm1ky", "name": "Department", "type": "select", "options": [{"id": "aw5i7hmpadn6mbwbz955ubarhme", "color": "propColorBrown", "value": "Engineering"}, {"id": "afkxpcjqjypu7hhar7banxau91h", "color": "propColorBlue", "value": "Product"}, {"id": "aehoa17cz18rqnrf75g7dwhphpr", "color": "propColorOrange", "value": "Marketing"}, {"id": "agrfeaoj7d8p5ianw5iaf3191ae", "color": "propColorGreen", "value": "Sales"}, {"id": "agm9p6gcq15ueuzqq3wd4be39wy", "color": "propColorYellow", "value": "Support"}, {"id": "aucop7kw6xwodcix6zzojhxih6r", "color": "propColorPink", "value": "Design"}, {"id": "afust91f3g8ht368mkn5x9tgf1o", "color": "propColorPurple", "value": "Finance"}, {"id": "acocxxwjurud1jixhp7nowdig7y", "color": "propColorGray", "value": "Human Resources"}]}, {"id": "adp5ft3kgz7r5iqq3tnwg551der", "name": "Priority", "type": "select", "options": [{"id": "a8zg3rjtf4swh7smsjxpsn743rh", "color": "propColorRed", "value": "P1 🔥"}, {"id": "as555ipyzopjjpfb5rjtssecw5e", "color": "propColorYellow", "value": "P2"}, {"id": "a1ts3ftyr8nocsicui98c89uxjy", "color": "propColorGray", "value": "P3"}]}, {"id": "aqxyzkdrs4egqf7yk866ixkaojc", "name": "Quarter", "type": "select", "options": [{"id": "ahfbn1jsmhydym33ygxwg5jt3kh", "color": "propColorBlue", "value": "Q1"}, {"id": "awfu37js3fomfkkczm1zppac57a", "color": "propColorBrown", "value": "Q2"}, {"id": "anruuoyez51r3yjxuoc8zoqnwaw", "color": "propColorGreen", "value": "Q3"}, {"id": "acb6dqqs6yson7bbzx6jk9bghjh", "color": "propColorPurple", "value": "Q4"}]}, {"id": "adu6mebzpibq6mgcswk69xxmnqe", "name": "Due Date", "type": "date", "options": []}, {"id": "asope3bddhm4gpsng5cfu4hf6rh", "name": "Assignee", "type": "multiPerson", "options": []}, {"id": "ajwxp866f9obs1kutfwaa5ru7fe", "name": "Target", "type": "number", "options": []}, {"id": "azqnyswk6s1boiwuthscm78qwuo", "name": "Actual", "type": "number", "options": []}, {"id": "ahz3fmjnaguec8hce7xq3h5cjdr", "name": "Completion (%)", "type": "text", "options": []}, {"id": "a17bfcgnzmkwhziwa4tr38kiw5r", "name": "Note", "type": "text", "options": []}]	1673965824578	1673965824578	0	
bng8baqwambb6bxwewinmuuno3y	2023-01-17 14:30:24.752127+00	0		system	system	O	Personal Goals 	Use this template to set and accomplish new personal goals.	⛰️	t	t	6	{"trackingTemplateId": "7f32dc8d2ae008cfe56554e9363505cc"}	[{"id": "af6fcbb8-ca56-4b73-83eb-37437b9a667d", "name": "Status", "type": "select", "options": [{"id": "bf52bfe6-ac4c-4948-821f-83eaa1c7b04a", "color": "propColorRed", "value": "To Do"}, {"id": "77c539af-309c-4db1-8329-d20ef7e9eacd", "color": "propColorYellow", "value": "Doing"}, {"id": "98bdea27-0cce-4cde-8dc6-212add36e63a", "color": "propColorGreen", "value": "Done 🙌"}]}, {"id": "d9725d14-d5a8-48e5-8de1-6f8c004a9680", "name": "Category", "type": "select", "options": [{"id": "3245a32d-f688-463b-87f4-8e7142c1b397", "color": "propColorPurple", "value": "Life Skills"}, {"id": "80be816c-fc7a-4928-8489-8b02180f4954", "color": "propColorGreen", "value": "Finance"}, {"id": "ffb3f951-b47f-413b-8f1d-238666728008", "color": "propColorOrange", "value": "Health"}]}, {"id": "d6b1249b-bc18-45fc-889e-bec48fce80ef", "name": "Target", "type": "select", "options": [{"id": "9a090e33-b110-4268-8909-132c5002c90e", "color": "propColorBlue", "value": "Q1"}, {"id": "0a82977f-52bf-457b-841b-e2b7f76fb525", "color": "propColorBrown", "value": "Q2"}, {"id": "6e7139e4-5358-46bb-8c01-7b029a57b80a", "color": "propColorGreen", "value": "Q3"}, {"id": "d5371c63-66bf-4468-8738-c4dc4bea4843", "color": "propColorPurple", "value": "Q4"}]}, {"id": "ajy6xbebzopojaenbnmfpgtdwso", "name": "Due Date", "type": "date", "options": []}]	1673965824756	1673965824756	0	
brsotn1kutjgpbxf95tq4p94iya	2023-01-17 14:30:24.861134+00	0		system	system	O	Sprint Planner 	Use this template to plan your sprints and manage your releases more efficiently.	🗓️	t	t	6	{"trackingTemplateId": "99b74e26d2f5d0a9b346d43c0a7bfb09"}	[{"id": "50117d52-bcc7-4750-82aa-831a351c44a0", "name": "Status", "type": "select", "options": [{"id": "aft5bzo7h9aspqgrx3jpy5tzrer", "color": "propColorGray", "value": "Not Started"}, {"id": "abrfos7e7eczk9rqw6y5abadm1y", "color": "propColorOrange", "value": "Next Up"}, {"id": "ax8wzbka5ahs3zziji3pp4qp9mc", "color": "propColorBlue", "value": "In Progress"}, {"id": "atabdfbdmjh83136d5e5oysxybw", "color": "propColorYellow", "value": "In Review"}, {"id": "ace1bzypd586kkyhcht5qqd9eca", "color": "propColorPink", "value": "Approved"}, {"id": "aay656c9m1hzwxc9ch5ftymh3nw", "color": "propColorRed", "value": "Blocked"}, {"id": "a6ghze4iy441qhsh3eijnc8hwze", "color": "propColorGreen", "value": "Complete 🙌"}]}, {"id": "20717ad3-5741-4416-83f1-6f133fff3d11", "name": "Type", "type": "select", "options": [{"id": "424ea5e3-9aa1-4075-8c5c-01b44b66e634", "color": "propColorYellow", "value": "Epic ⛰"}, {"id": "a5yxq8rbubrpnoommfwqmty138h", "color": "propColorGray", "value": "Feature 🏗"}, {"id": "apht1nt5ryukdmxkh6fkfn6rgoy", "color": "propColorOrange", "value": "User Story 📖"}, {"id": "aiycbuo3dr5k4xxbfr7coem8ono", "color": "propColorGreen", "value": "Task ⛏"}, {"id": "aomnawq4551cbbzha9gxnmb3z5w", "color": "propColorRed", "value": "Bug 🐞"}]}, {"id": "60985f46-3e41-486e-8213-2b987440ea1c", "name": "Sprint", "type": "select", "options": [{"id": "c01676ca-babf-4534-8be5-cce2287daa6c", "color": "propColorBrown", "value": "Sprint 1"}, {"id": "ed4a5340-460d-461b-8838-2c56e8ee59fe", "color": "propColorPurple", "value": "Sprint 2"}, {"id": "14892380-1a32-42dd-8034-a0cea32bc7e6", "color": "propColorBlue", "value": "Sprint 3"}]}, {"id": "f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e", "name": "Priority", "type": "select", "options": [{"id": "cb8ecdac-38be-4d36-8712-c4d58cc8a8e9", "color": "propColorRed", "value": "P1 🔥"}, {"id": "e6a7f297-4440-4783-8ab3-3af5ba62ca11", "color": "propColorYellow", "value": "P2"}, {"id": "c62172ea-5da7-4dec-8186-37267d8ee9a7", "color": "propColorGray", "value": "P3"}]}, {"id": "aphg37f7zbpuc3bhwhp19s1ribh", "name": "Assignee", "type": "multiPerson", "options": []}, {"id": "a4378omyhmgj3bex13sj4wbpfiy", "name": "Due Date", "type": "date", "options": []}, {"id": "ai7ajsdk14w7x5s8up3dwir77te", "name": "Story Points", "type": "number", "options": []}, {"id": "a1g6i613dpe9oryeo71ex3c86hy", "name": "Design Link", "type": "url", "options": []}, {"id": "aeomttrbhhsi8bph31jn84sto6h", "name": "Created Time", "type": "createdTime", "options": []}, {"id": "ax9f8so418s6s65hi5ympd93i6a", "name": "Created By", "type": "createdBy", "options": []}]	1673965824867	1673965824867	0	
bky8mjzqy9incxk3gjqwiatz6xa	2023-01-17 14:30:25.286676+00	0		system	system	O	User Research Sessions	Use this template to manage and keep track of all your user research sessions.	🔬	t	t	6	{"trackingTemplateId": "6c345c7f50f6833f78b7d0f08ce450a3"}	[{"id": "aaebj5fyx493eezx6ukxiwydgty", "name": "Status", "type": "select", "options": [{"id": "af6hjb3ysuaxbwnfqpby4wwnkdr", "color": "propColorGray", "value": "Backlog 📒"}, {"id": "aotxum1p5bw3xuzqz3ctjw66yww", "color": "propColorYellow", "value": "Contacted 📞"}, {"id": "a7yq89whddzob1futao4rxk3yzc", "color": "propColorBlue", "value": "Scheduled 📅"}, {"id": "aseqq9hrsua56r3s6nbuirj9eec", "color": "propColorRed", "value": "Cancelled 🚫"}, {"id": "ap93ysuzy1xa7z818r6myrn4h4y", "color": "propColorGreen", "value": "Completed ✔️"}]}, {"id": "akrxgi7p7w14fym3gbynb98t9fh", "name": "Interview Date", "type": "date", "options": []}, {"id": "atg9qu6oe4bjm8jczzsn71ff5me", "name": "Product Area", "type": "select", "options": [{"id": "ahn89mqg9u4igk6pdm7333t8i5h", "color": "propColorGreen", "value": "Desktop App"}, {"id": "aehc83ffays3gh8myz16a8j7k4e", "color": "propColorPurple", "value": "Web App"}, {"id": "a1sxagjgaadym5yrjak6tcup1oa", "color": "propColorBlue", "value": "Mobile App"}]}, {"id": "acjq4t5ymytu8x1f68wkggm7ypc", "name": "Email", "type": "email", "options": []}, {"id": "aphio1s5gkmpdbwoxynim7acw3e", "name": "Interviewer", "type": "multiPerson", "options": []}, {"id": "aqafzdeekpyncwz7m7i54q3iqqy", "name": "Recording URL", "type": "url", "options": []}, {"id": "aify3r761b9w43bqjtskrzi68tr", "name": "Passcode", "type": "text", "options": []}]	1673965825289	1673965825289	0	
benutoyfd6byx5mxw5rbwtiqg9h	2023-01-17 14:30:25.707592+00	0		system	system	O	Content Calendar 	Use this template to plan and organize your editorial content.	📅	t	t	6	{"trackingTemplateId": "c75fbd659d2258b5183af2236d176ab4"}	[{"id": "ae9ar615xoknd8hw8py7mbyr7zo", "name": "Status", "type": "select", "options": [{"id": "awna1nuarjca99m9s4uiy9kwj5h", "color": "propColorGray", "value": "Idea 💡"}, {"id": "a9ana1e9w673o5cp8md4xjjwfto", "color": "propColorOrange", "value": "Draft"}, {"id": "apy9dcd7zmand615p3h53zjqxjh", "color": "propColorPurple", "value": "In Review"}, {"id": "acri4cm3bmay55f7ksztphmtnga", "color": "propColorBlue", "value": "Ready to Publish"}, {"id": "amsowcd9a8e1kid317r7ttw6uzh", "color": "propColorGreen", "value": "Published 🎉"}]}, {"id": "aysx3atqexotgwp5kx6h5i5ancw", "name": "Type", "type": "select", "options": [{"id": "aywiofmmtd3ofgzj95ysky4pjga", "color": "propColorOrange", "value": "Press Release"}, {"id": "apqdgjrmsmx8ngmp7zst51647de", "color": "propColorGreen", "value": "Sponsored Post"}, {"id": "a3woynbjnb7j16e74uw3pubrytw", "color": "propColorPurple", "value": "Customer Story"}, {"id": "aq36k5pkpfcypqb3idw36xdi1fh", "color": "propColorRed", "value": "Product Release"}, {"id": "azn66pmk34adygnizjqhgiac4ia", "color": "propColorGray", "value": "Partnership"}, {"id": "aj8y675weso8kpb6eceqbpj4ruw", "color": "propColorBlue", "value": "Feature Announcement"}, {"id": "a3xky7ygn14osr1mokerbfah5cy", "color": "propColorYellow", "value": "Article"}]}, {"id": "ab6mbock6styfe6htf815ph1mhw", "name": "Channel", "type": "multiSelect", "options": [{"id": "a8xceonxiu4n3c43szhskqizicr", "color": "propColorBrown", "value": "Website"}, {"id": "a3pdzi53kpbd4okzdkz6khi87zo", "color": "propColorGreen", "value": "Blog"}, {"id": "a3d9ux4fmi3anyd11kyipfbhwde", "color": "propColorOrange", "value": "Email"}, {"id": "a8cbbfdwocx73zn3787cx6gacsh", "color": "propColorRed", "value": "Podcast"}, {"id": "aigjtpcaxdp7d6kmctrwo1ztaia", "color": "propColorPink", "value": "Print"}, {"id": "af1wsn13muho59e7ghwaogxy5ey", "color": "propColorBlue", "value": "Facebook"}, {"id": "a47zajfxwhsg6q8m7ppbiqs7jge", "color": "propColorGray", "value": "LinkedIn"}, {"id": "az8o8pfe9hq6s7xaehoqyc3wpyc", "color": "propColorYellow", "value": "Twitter"}]}, {"id": "ao44fz8nf6z6tuj1x31t9yyehcc", "name": "Assignee", "type": "person", "options": []}, {"id": "a39x5cybshwrbjpc3juaakcyj6e", "name": "Due Date", "type": "date", "options": []}, {"id": "agqsoiipowmnu9rdwxm57zrehtr", "name": "Publication Date", "type": "date", "options": []}, {"id": "ap4e7kdg7eip7j3c3oyiz39eaoc", "name": "Link", "type": "url", "options": []}]	1673965825712	1673965825712	0	
bbr1copn6i7yu5y9sqk1ijg49qa	2023-01-17 14:30:25.954832+00	0		system	system	O	Team Retrospective	Use this template at the end of your project or sprint to identify what worked well and what can be improved for the future.	🧭	t	t	6	{"trackingTemplateId": "e4f03181c4ced8edd4d53d33d569a086"}	[{"id": "adjckpdotpgkz7c6wixzw9ipb1e", "name": "Category", "type": "select", "options": [{"id": "aok6pgecm85qe9k5kcphzoe63ma", "color": "propColorGray", "value": "To Discuss 📣"}, {"id": "aq1dwbf661yx337hjcd5q3sbxwa", "color": "propColorGreen", "value": "Went Well 👍"}, {"id": "ar87yh5xmsswqkxmjq1ipfftfpc", "color": "propColorRed", "value": "Didn't Go Well 🚫"}, {"id": "akj3fkmxq7idma55mdt8sqpumyw", "color": "propColorBlue", "value": "Action Items ✅"}]}, {"id": "aspaay76a5wrnuhtqgm97tt3rer", "name": "Details", "type": "text", "options": []}, {"id": "arzsm76s376y7suuhao3tu6efoc", "name": "Created By", "type": "createdBy", "options": []}, {"id": "a8anbe5fpa668sryatcdsuuyh8a", "name": "Created Time", "type": "createdTime", "options": []}]	1673965825957	1673965825957	0	
bxf4mbdcr8fdrbga53r9zwrydpr	2023-01-17 14:30:26.047826+00	0		system	system	O	Roadmap 	Use this template to plan your roadmap and manage your releases more efficiently.	🗺️	t	t	6	{"trackingTemplateId": "b728c6ca730e2cfc229741c5a4712b65"}	[{"id": "50117d52-bcc7-4750-82aa-831a351c44a0", "name": "Status", "type": "select", "options": [{"id": "8c557f69-b0ed-46ec-83a3-8efab9d47ef5", "color": "propColorGray", "value": "Not Started"}, {"id": "ec6d2bc5-df2b-4f77-8479-e59ceb039946", "color": "propColorYellow", "value": "In Progress"}, {"id": "849766ba-56a5-48d1-886f-21672f415395", "color": "propColorGreen", "value": "Complete 🙌"}]}, {"id": "20717ad3-5741-4416-83f1-6f133fff3d11", "name": "Type", "type": "select", "options": [{"id": "424ea5e3-9aa1-4075-8c5c-01b44b66e634", "color": "propColorYellow", "value": "Epic ⛰"}, {"id": "6eea96c9-4c61-4968-8554-4b7537e8f748", "color": "propColorGreen", "value": "Task 🔨"}, {"id": "1fdbb515-edd2-4af5-80fc-437ed2211a49", "color": "propColorRed", "value": "Bug 🐞"}]}, {"id": "60985f46-3e41-486e-8213-2b987440ea1c", "name": "Sprint", "type": "select", "options": [{"id": "c01676ca-babf-4534-8be5-cce2287daa6c", "color": "propColorBrown", "value": "Sprint 1"}, {"id": "ed4a5340-460d-461b-8838-2c56e8ee59fe", "color": "propColorPurple", "value": "Sprint 2"}, {"id": "14892380-1a32-42dd-8034-a0cea32bc7e6", "color": "propColorBlue", "value": "Sprint 3"}]}, {"id": "f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e", "name": "Priority", "type": "select", "options": [{"id": "cb8ecdac-38be-4d36-8712-c4d58cc8a8e9", "color": "propColorRed", "value": "P1 🔥"}, {"id": "e6a7f297-4440-4783-8ab3-3af5ba62ca11", "color": "propColorYellow", "value": "P2"}, {"id": "c62172ea-5da7-4dec-8186-37267d8ee9a7", "color": "propColorGray", "value": "P3"}]}, {"id": "aphg37f7zbpuc3bhwhp19s1ribh", "name": "Assignee", "type": "person", "options": []}, {"id": "a4378omyhmgj3bex13sj4wbpfiy", "name": "Due Date", "type": "date", "options": []}, {"id": "a36o9q1yik6nmar6ri4q4uca7ey", "name": "Created Date", "type": "createdTime", "options": []}, {"id": "ai7ajsdk14w7x5s8up3dwir77te", "name": "Design Link", "type": "url", "options": []}]	1673965826055	1673965826055	0	
b9ejcs37rcjfdde8b49oabrj6kh	2023-01-17 14:30:25.483027+00	0		system	system	O	Competitive Analysis	Use this template to track and stay ahead of the competition.	🗂️	t	t	6	{"trackingTemplateId": "06f4bff367a7c2126fab2380c9dec23c"}	[{"id": "ahzspe59iux8wigra8bg6cg18nc", "name": "Website", "type": "url", "options": []}, {"id": "aozntq4go4nkab688j1s7stqtfc", "name": "Location", "type": "text", "options": []}, {"id": "aiefo7nh9jwisn8b4cgakowithy", "name": "Revenue", "type": "text", "options": []}, {"id": "a6cwaq79b1pdpb97wkanmeyy4er", "name": "Employees", "type": "number", "options": []}, {"id": "an1eerzscfxn6awdfajbg41uz3h", "name": "Founded", "type": "text", "options": []}, {"id": "a1semdhszu1rq17d7et5ydrqqio", "name": "Market Position", "type": "select", "options": [{"id": "arfjpz9by5car71tz3behba8yih", "color": "propColorYellow", "value": "Leader"}, {"id": "abajmr34b8g1916w495xjb35iko", "color": "propColorRed", "value": "Challenger"}, {"id": "abt79uxg5edqojsrrefcnr4eruo", "color": "propColorBlue", "value": "Follower"}, {"id": "aipf3qfgjtkheiayjuxrxbpk9wa", "color": "propColorBrown", "value": "Nicher"}]}, {"id": "aapogff3xoa8ym7xf56s87kysda", "name": "Last updated time", "type": "updatedTime", "options": []}, {"id": "az3jkw3ynd3mqmart7edypey15e", "name": "Last updated by", "type": "updatedBy", "options": []}]	1673965825487	1673965825487	0	
bo47rmr9x6jyuffzi8wjhz9fpgo	2023-01-17 14:30:26.527051+00	0		system	system	O	Welcome to Boards!	Mattermost Boards is an open source project management tool that helps you organize, track, and manage work across teams. Select a card to learn more.	👋	t	t	6	{"trackingTemplateId": "65aba997282f3ac457cd66736fb86915"}	[{"id": "a972dc7a-5f4c-45d2-8044-8c28c69717f1", "name": "Status", "type": "select", "options": [{"id": "amm6wfhnbuxojwssyftgs9dipqe", "color": "propColorRed", "value": "To do 🔥"}, {"id": "af3p8ztcyxgn8wd9z4az7o9tjeh", "color": "propColorYellow", "value": "Next up"}, {"id": "ajurey3xkocs1nwx8di5zx6oe7o", "color": "propColorPurple", "value": "Later"}, {"id": "agkinkjy5983wsk6kppsujajxqw", "color": "propColorGreen", "value": "Completed 🙌"}]}, {"id": "acypkejeb5yfujhj9te57p9kaxw", "name": "Priority", "type": "select", "options": [{"id": "aanaehcw3m13jytujsjk5hpf6ry", "color": "propColorOrange", "value": "1. High"}, {"id": "ascd7nm9r491ayot8i86g1gmgqw", "color": "propColorBrown", "value": "2. Medium"}, {"id": "aq6ukoiciyfctgwyhwzpfss8ghe", "color": "propColorGray", "value": "3. Low"}]}, {"id": "aqh13jabwexjkzr3jqsz1i1syew", "name": "Assignee", "type": "person", "options": []}, {"id": "acmg7mz1rr1eykfug4hcdpb1y1o", "name": "Due Date", "type": "date", "options": []}, {"id": "amewjwfjrtpu8ha73xsrdmxazxr", "name": "Reviewed", "type": "checkbox", "options": []}, {"id": "attzzboqaz6m1sdti5xa7gjnk1e", "name": "Last updated time", "type": "updatedTime", "options": []}, {"id": "a4nfnb5xr3txr5xq7y9ho7kyz6c", "name": "Reference", "type": "url", "options": []}, {"id": "a9gzwi3dt5n55nddej6zcbhxaeh", "name": "Created by", "type": "createdBy", "options": []}]	1673965826531	1673965826531	0	
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
TelemetryID	711mo85tqkby9uea315z95jrk6e
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
z3pbizcrujd8jfyqq3z3zj1i5c	1674210751311	{"disable_daily_digest":false}
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
8ywrdoxy1fr93rmyi887jzfama	expiry_notify	0	1673966419782	1673966420399	1673966420404	success	0	null
8qzthhp7xbrbzcpmsech4196by	expiry_notify	0	1673988387204	1673988401776	1673988401781	success	0	null
1cz4woozmjnjijbncejx14nsma	expiry_notify	0	1673967019403	1673967020141	1673967020145	success	0	null
1cb335weojncmx46ey5kk6e1oy	expiry_notify	0	1673967619016	1673967619992	1673967620000	success	0	null
okrhq6apufb1mnzmeph993xino	expiry_notify	0	1673991631918	1673991646192	1673991646197	success	0	null
ocqihdjdmfnudmif71k7rqj3iw	expiry_notify	0	1673968218629	1673968219754	1673968219764	success	0	null
biws5knhxjbo8cwgrh6b8kt1me	product_notices	0	1673991631216	1673991646192	1673991647419	success	0	null
p6h4xokhcpyoix71jf6teqwuta	expiry_notify	0	1673968818278	1673968819589	1673968819593	success	0	null
1kfwqc5uhifstk9ntoikdhdj1o	expiry_notify	0	1673992922579	1673992937594	1673992937602	success	0	null
4bmhpkbchb8fdc5z7uqermahay	expiry_notify	0	1673969417930	1673969419394	1673969419397	success	0	null
5irtsh6xijb69gctquszochp7c	product_notices	0	1673969417926	1673969419394	1673969419588	success	0	null
rq9m1uy4ipndjrcwh37ajitpky	expiry_notify	0	1673995003631	1673995731282	1673995731337	success	0	null
zypqjgzsxifqu855k38sgos6pr	expiry_notify	0	1673970017557	1673970019205	1673970019211	success	0	null
qqtyze46qffd3g8zwyjb3kpwhw	expiry_notify	0	1673970617174	1673970618980	1673970618985	success	0	null
4iui979keidkmrtaf11czo8taw	expiry_notify	0	1673995731295	1673995746290	1673995746297	success	0	null
jpqup87tmiremjamx4ortoip1o	expiry_notify	0	1673971216845	1673971218780	1673971218786	success	0	null
aff4ipba6t8ufmkzi8zp9zgh4e	product_notices	0	1673995731619	1673995746290	1673995746415	success	0	null
z37f5or3wpd5iddtm1owaxx4zw	expiry_notify	0	1673971816461	1673971818603	1673971818611	success	0	null
oeszke5tmjnmmmy4sbkndx5bur	expiry_notify	0	1673998320743	1673998320858	1673998320868	success	0	null
aq71d4ieni8x3gr3pkaacjx8qw	expiry_notify	0	1673972416051	1673972418382	1673972418388	success	0	null
ooht8ndkwpdn5du73sfubx35zw	expiry_notify	0	1673973015660	1673973018244	1673973018251	success	0	null
yswtdb3q8fg63n4yom3695r9ih	product_notices	0	1673973015664	1673973018244	1673973018523	success	0	null
mcwkdbawobrn38bfyb4iu8anyw	expiry_notify	0	1674001560820	1674004804251	1674004804269	success	0	null
nj384ixs1i8r58sprpcsaieboy	expiry_notify	0	1673973615289	1673973617985	1673973617990	success	0	null
x1sniqum17bqbb991kdkiexq8h	product_notices	0	1674001560760	1674004804251	1674004805503	success	0	null
zzcm1s4j5j86ufeh7kumst5ajo	expiry_notify	0	1673974214889	1673974217754	1673974217759	success	0	null
5u4w6c1heb8f7fzahqobar1dxa	expiry_notify	0	1674004802473	1674005361794	1674005361810	success	0	null
cn8hrj6x7bfydrqiyux798t5tr	product_notices	0	1674005361640	1674005361793	1674005362950	success	0	null
5sw1hmem7fdrbccd6jtrpn89me	expiry_notify	0	1673977582033	1673977597001	1673977597012	success	0	null
7a843zxtnfbj3bkicz8bu5nkse	product_notices	0	1673977582067	1673977597001	1673977598699	success	0	null
3aaywsgfobdkxde4x7rf8fniew	expiry_notify	0	1674008101795	1674011342470	1674011342594	success	0	null
yceymmyby7dydr8sowjs36e13w	expiry_notify	0	1673980826384	1673982982092	1673982982103	success	0	null
uxdnjih1h7fyjnrsqm5ms4t9fa	product_notices	0	1673982968655	1673982982092	1673982982360	success	0	null
se5ncu1873r49ysu3zpz6j4t7h	expiry_notify	0	1673982968332	1673982997044	1673982997055	success	0	null
54xndox9fjf6zgt851c5fcp63h	expiry_notify	0	1673983568332	1673983581790	1673983581794	success	0	null
8xzrdo8bm7rx9m9aijx3ae1y5a	expiry_notify	0	1674011342663	1674014583912	1674014584201	success	0	null
tgfr3jgoitb3uqqs9c67cdxi8c	product_notices	0	1674011342652	1674014584038	1674014585104	success	0	null
rmbe3fecup8nxrjrph6jmumyiy	expiry_notify	0	1673984167932	1673984181536	1673984181543	success	0	null
hfoz9k7dnt8zbj834d3reg6hne	expiry_notify	0	1673984767541	1673984781305	1673984781310	success	0	null
4e6oi8aarbyydfnhkrbchfzumh	expiry_notify	0	1674014584134	1674015867742	1674015867780	success	0	null
1mpbts9u17f9umpfha7eipd98y	expiry_notify	0	1673985365423	1673985379350	1673985379368	success	0	null
dtexbithxfnimmug7e99tzqw4e	expiry_notify	0	1673985967139	1673985981206	1673985981221	success	0	null
kdx113spjfyuxy1rzy65eyhw4a	expiry_notify	0	1674015867742	1674015882753	1674015882763	success	0	null
xk6d6fdr8bdz3ck74fcxm18reh	product_notices	0	1674015867773	1674015882753	1674015882849	success	0	null
qwzrjwzuf3yn3y7o8aujuck5tw	expiry_notify	0	1673986813868	1673986814086	1673986814527	success	0	null
ekch8tg9qinz5m4gqakc4twhir	product_notices	0	1673986813899	1673986829096	1673986829377	success	0	null
8np8ufhsu7nf5gkkpej9hrfpea	expiry_notify	0	1674019699641	1674022941334	1674022941344	success	0	null
xasqaiieubya3nxs8w1hj9ghqh	product_notices	0	1674019699767	1674022941334	1674022942439	success	0	null
m7eui8yuwfr6ij3xm5dkuou6fc	expiry_notify	0	1674022941295	1674026183535	1674026183606	success	0	null
nyog1rx46fb1fn147kgwe7gite	expiry_notify	0	1674026183563	1674026198544	1674026198551	success	0	null
tefdrc4dy3yd5jknw6rczw4a7e	product_notices	0	1674026183800	1674026198543	1674026198661	success	0	null
rnjfwkbmtpryjrd1qcnjgjs16w	expiry_notify	0	1674028528366	1674028543337	1674028543343	success	0	null
sojjsesyzigu8cu4dqg655idoe	expiry_notify	0	1674029128560	1674029129745	1674029129758	success	0	null
gu3e1dkqgbnf8rs58ay1jsz35a	expiry_notify	0	1674030190760	1674030196671	1674030196683	success	0	null
qh4pddo74pbmzyiow6wijftj5o	expiry_notify	0	1674033788617	1674033795624	1674033795633	success	0	null
5hgqyt6m9pfz3xakarmeffc9te	expiry_notify	0	1674052135499	1674052137357	1674052137363	success	0	null
zpjg5sfs8pbnmqf46r5xcwxheh	expiry_notify	0	1674030790335	1674030796382	1674030796386	success	0	null
d7u83yettiy4xyxxicuymc74wa	expiry_notify	0	1674112153366	1674112167633	1674112167637	success	0	null
49k1rs5s1bbm9ceaywxi6wqz4e	expiry_notify	0	1674034388248	1674034395450	1674034395456	success	0	null
7tmirx8onbfkdn1ezgshuhtpzc	expiry_notify	0	1674031389913	1674031396098	1674031396104	success	0	null
u53oxewfwfgp7xgygir9cskcca	expiry_notify	0	1674052735105	1674052737124	1674052737142	success	0	null
bi4f1w68upnfjrds8659bso9wr	expiry_notify	0	1674031989750	1674031996091	1674031996103	success	0	null
hfbupn1gcpfcty7e7oc3wc4dha	expiry_notify	0	1674034987870	1674034995289	1674034995298	success	0	null
1hy9wkkooirgdx3bog4bfroxwe	expiry_notify	0	1674032589353	1674032595925	1674032595937	success	0	null
mftrm198mpd43mteka46j43inh	expiry_notify	0	1674035587547	1674035595111	1674035595117	success	0	null
633go335migmp8f4ds91m3ykoa	expiry_notify	0	1674053334694	1674053336922	1674053336931	success	0	null
i1byproxtjdsjgrfhg7rpq98ao	expiry_notify	0	1674033188950	1674033195730	1674033195773	success	0	null
jozfeuzbnt81fmkp3h8sqzqxuw	product_notices	0	1674033188955	1674033195730	1674033195895	success	0	null
3mzitzjwcff4pj7jw5z6f4x3qo	expiry_notify	0	1674036187161	1674036194876	1674036194898	success	0	null
tkzgt4unh788zfaz6uigsyjkbc	expiry_notify	0	1674053934303	1674053937595	1674053937615	success	0	null
uet1w7boxby1tyeo4f3bko9wea	expiry_notify	0	1674036786764	1674036794752	1674036794779	success	0	null
yxy165a11jyrdnkfehikoqxb8y	product_notices	0	1674036786771	1674036794752	1674036794891	success	0	null
uhw53u16rtnxjeyt88aiyeg59y	expiry_notify	0	1674054533880	1674054537434	1674054537443	success	0	null
1bo93fkybint9xdrwq3jmqd9by	expiry_notify	0	1674037386382	1674037394530	1674037394554	success	0	null
zsrc1cmh9fgjun47sidxxs61qw	expiry_notify	0	1674055133477	1674055137188	1674055137194	success	0	null
6j1nd8q3xbdq8ejnfotxmmkh9o	expiry_notify	0	1674037985989	1674037994388	1674037994448	success	0	null
y6muepdh5fftujncyatubbf6pa	expiry_notify	0	1674038585638	1674038594314	1674038594338	success	0	null
734wuq3qjfrwdbwhm4ffjpq9rr	product_notices	0	1674055193476	1674055197162	1674055197322	success	0	null
6hqsy3ohuig8zmgb4ky4ju8ihr	expiry_notify	0	1674039185323	1674039194415	1674039194441	success	0	null
48dxt4jqitbi3bfpcoxzbehk6o	expiry_notify	0	1674055733205	1674055737072	1674055737083	success	0	null
r5m4hpkaxjbk9c73tiy4u4b6ph	expiry_notify	0	1674039784940	1674039794295	1674039794302	success	0	null
kkd79kcon7d1jnxayo4sefrtey	expiry_notify	0	1674056332820	1674056336883	1674056336890	success	0	null
7wsphxk5upgadrjd5k69b9oe3e	expiry_notify	0	1674040384531	1674040394098	1674040394104	success	0	null
6kadepz1gjbx3xi66n8bz16kzc	product_notices	0	1674040384538	1674040394098	1674040394230	success	0	null
e1m5qyhf7pf7be34p8w4ejtj3o	expiry_notify	0	1674056932423	1674056936659	1674056936665	success	0	null
pnk6kzyfnifbmegw8c5yh1gbjr	expiry_notify	0	1674041050422	1674041065378	1674041065385	success	0	null
pfyzbyow8int9d6ki8sodasdco	expiry_notify	0	1674041654913	1674041669639	1674041669646	success	0	null
cgr4mzcwx7dgf88wyc6yz1mubo	expiry_notify	0	1674057532067	1674057536424	1674057536431	success	0	null
aizqu89neb8mdgpbqeztih4uzc	expiry_notify	0	1674042708327	1674042723329	1674042723342	success	0	null
pa89uised3y4xrj3o5m54qrjsc	expiry_notify	0	1674058131681	1674058136214	1674058136218	success	0	null
x19yn36ka7yaxkf1mjps3btphy	expiry_notify	0	1674043772893	1674043773289	1674043773319	success	0	null
gk1r61kxsibqdc716o8u3mj4go	expiry_notify	0	1674060602392	1674060607667	1674060607672	success	0	null
ej8cyzw767d85q4yryqi1oti3r	expiry_notify	0	1674044377056	1674044391632	1674044391639	success	0	null
z9xchfrobpfnzjjzkxob1njdkc	product_notices	0	1674044376690	1674044391633	1674044391734	success	0	null
wm1yejumk7bppdf18owpxr11kr	expiry_notify	0	1674063399521	1674063413585	1674063413590	success	0	null
nijyk6r8sbrymj6r79a1kkou4e	expiry_notify	0	1674045438387	1674045453384	1674045453389	success	0	null
3dip6w1k7p8sufa1h355d9cxwr	expiry_notify	0	1674046137432	1674046151064	1674046151070	success	0	null
8zhmn8m47frbukp7u6hm5h1qhy	expiry_notify	0	1674046738925	1674046739094	1674046739103	success	0	null
nyo911njibddfjbr1t4fgs5ara	expiry_notify	0	1674047338526	1674047338819	1674047338826	success	0	null
tnrctdtd3tyyz8ximkzwmcnihy	expiry_notify	0	1674047938118	1674047938564	1674047938571	success	0	null
hz56k4u53t8wpf6k99ws3jw1gc	product_notices	0	1674047998082	1674047998537	1674047998647	success	0	null
5msd5155itb83gxmc8yys98xoc	expiry_notify	0	1674048537734	1674048538309	1674048538313	success	0	null
yin1btchqffgmftaypu1q9eaea	expiry_notify	0	1674049137339	1674049138087	1674049138100	success	0	null
h5s8mhga43d3zpo1uaurwxsaeh	expiry_notify	0	1674049736950	1674049737872	1674049737880	success	0	null
tbiawyer93yrxg1xpb55mmx8ya	expiry_notify	0	1674050336562	1674050337831	1674050337841	success	0	null
xqifxwqtwfncupyeggq7di3wkc	expiry_notify	0	1674050936241	1674050937834	1674050937844	success	0	null
sy3bn5o6r3bzbbxrjpyqpbrfir	expiry_notify	0	1674051535873	1674051537585	1674051537591	success	0	null
y474u37xs3f8pkb3q9mfu5x3hc	product_notices	0	1674051595840	1674051597562	1674051597703	success	0	null
4pdqa5fiqproicn3tqfhtxqqae	expiry_notify	0	1674112752972	1674112767422	1674112767428	success	0	null
zkaoqi3j3jgnpmw5co6gwhmuhr	expiry_notify	0	1674066645569	1674069885930	1674069885987	success	0	null
83xi56xae7gtjnn1597mhfh1na	product_notices	0	1674066645295	1674069885930	1674069887897	success	0	null
yt5q8dxbsibmmmkahcwzzohd5r	expiry_notify	0	1674069885885	1674069900932	1674069900937	success	0	null
bf5ja7o44pyd5by9nt1zsumo3e	expiry_notify	0	1674115848904	1674115858438	1674115858452	success	0	null
dc7wu86iwj8w9qn686gxk8pihe	product_notices	0	1674115846411	1674115858438	1674115858958	success	0	null
3mno3f13hbdnijg7izor7x5nbw	expiry_notify	0	1674072842755	1674072857703	1674072857708	success	0	null
kgoox83bypn83ebcjtdmqu1tsr	product_notices	0	1674072842725	1674072857703	1674072858191	success	0	null
j1uxaaub378ujca9rtwmitquxh	expiry_notify	0	1674117666206	1674117680723	1674117680729	success	0	null
gsfkumwui7bi9jo4af66nn4idr	expiry_notify	0	1674076086575	1674079330453	1674079330551	success	0	null
3optsiij4idy5k1bzsygbyxwhh	product_notices	0	1674079331169	1674079330452	1674079331079	success	0	null
s6khwzt58tbzzkbo43731a17pw	expiry_notify	0	1674079330519	1674079345457	1674079345464	success	0	null
fmcj31cq63ypt8izeucc64kgcc	expiry_notify	0	1674119574734	1674119589695	1674119589705	success	0	null
azjjy6bcqtd5mppgkdge4y3p3a	expiry_notify	0	1674082571502	1674085812551	1674085813357	success	0	null
r4sicpq9bifh7eeb6m3wuhf1yh	product_notices	0	1674119574654	1674119589696	1674119589781	success	0	null
nr6kjrx6yj8n8jscmnnet93m8a	expiry_notify	0	1674122820841	1674122820969	1674122820980	success	0	null
ag785ekj7jy3t87whkjzxuzqhy	expiry_notify	0	1674085813344	1674089054535	1674089054565	success	0	null
gjqbbpgcfbbnbxj7677du8jdza	product_notices	0	1674085813379	1674089054535	1674089055234	success	0	null
ky1xj3n1ct8ruescte6pq8wpjh	expiry_notify	0	1674129542102	1674129557032	1674129557053	success	0	null
eb937bm8gtfw3fjo3xmsfdthhy	expiry_notify	0	1674089054560	1674092295899	1674092295917	success	0	null
qrqrwr3cmjy3bqmughpnkr965o	product_notices	0	1674092295831	1674092295899	1674092296541	success	0	null
fswczgqiqjnwzn3xe379tmukpo	product_notices	0	1674129542113	1674129557032	1674129557721	success	0	null
mq4jw5qaxty65mkfgk798t6ymw	expiry_notify	0	1674092295821	1674095537380	1674095537403	success	0	null
ueiifdt8ejybix3a1z51ucoqyr	expiry_notify	0	1674095537398	1674098777802	1674098777835	success	0	null
3csdgdhidfb1bgh3hoaco97s8r	expiry_notify	0	1674136774959	1674136789754	1674136789761	success	0	null
751mtg4tofn6zfi34qqxxeodwh	expiry_notify	0	1674098777848	1674102018878	1674102019096	success	0	null
coco6sjgzibsxr9hq5d6zk5utc	product_notices	0	1674136774943	1674136789754	1674136789942	success	0	null
m15saqnkbbnc5g4b6pnegs5j9r	product_notices	0	1674098777806	1674102018878	1674102019771	success	0	null
eri8eohh93863qeq9uomjjxxih	expiry_notify	0	1674102019108	1674105261704	1674105261978	success	0	null
shkh4pcfzidcdrezto11rdizec	expiry_notify	0	1674144006763	1674144021622	1674144021630	success	0	null
q41sm7adpfghxqojxf4acmt56a	expiry_notify	0	1674105260080	1674108501273	1674108501491	success	0	null
ibjpesjtufga7ybkwb5esmmuxc	product_notices	0	1674144006791	1674144021622	1674144021897	success	0	null
bxcw57765fbztmrbhfgisojuwc	product_notices	0	1674105260043	1674108501277	1674108503644	success	0	null
xrwcaxbnmjnzjm1sp7bqut6orw	expiry_notify	0	1674108501606	1674110952494	1674110953322	success	0	null
7t88zc714pnpzrcyoiiqr4miby	expiry_notify	0	1674110952528	1674110967499	1674110967511	success	0	null
hdm3wmw6m7dibxamcp59cafbha	product_notices	0	1674110953431	1674110967499	1674110967572	success	0	null
oqxiue5rf3gdun9d5bk91ohr8c	import_delete	0	1674151235628	1674151250462	1674151250471	success	0	null
nznigfbrtjdoikkgi55baa178c	expiry_notify	0	1674111553715	1674111567809	1674111567815	success	0	null
qxznig73j7ghpn4omjseomsuhe	export_delete	0	1674151235579	1674151250460	1674151250471	success	0	null
ybir9xm9sbf8fymchjfup8xzra	plugins	0	1674151235439	1674151250459	1674151250478	success	0	null
1h51oqouhpnp8r9w4tca4nxciw	expiry_notify	0	1674151235549	1674151250460	1674151250482	success	0	null
bifsc14cj7rkxnggoj8winynic	product_notices	0	1674151235609	1674151250463	1674151250839	success	0	null
do76xz833tnzpeiqxuqrwox8ec	expiry_notify	0	1674158464887	1674165670100	1674165670126	success	0	null
kn3nbfk4o3fgjn7ytrpj4ydi1r	product_notices	0	1674158464894	1674165670100	1674165671010	success	0	null
aeix14bty7btpy3thpbyzpb63c	expiry_notify	0	1674165670375	1674165685514	1674165685622	success	0	null
8pxx3qqdbbdcmx9h4moofje4oc	product_notices	0	1674165670367	1674165685514	1674165685670	success	0	null
ukghfc4t4trszpz6xwckgyhuch	expiry_notify	0	1674172901311	1674180104044	1674180104080	success	0	null
g84amf1ggb8y5eqy7tuij8kfma	product_notices	0	1674172901423	1674180104044	1674180105918	success	0	null
g5d8z7mp7bywfn5qkinq7564zc	expiry_notify	0	1674180103982	1674187308554	1674187308573	success	0	null
q14doe6isibdzkqds6z3gngodc	product_notices	0	1674180104022	1674187308554	1674187309318	success	0	null
31gxtiiuyfyomxtp5deiwegixw	expiry_notify	0	1674187308561	1674194515415	1674194515557	success	0	null
y51n3ighxffz3e1ikpc8hha19r	product_notices	0	1674187308552	1674194515415	1674194515885	success	0	null
awf9xrdn9bf3fm6t17zzie4x8w	product_notices	0	1674194515541	1674194530426	1674194530532	success	0	null
5qexgymirpn6ukjxp68mzgr5ya	expiry_notify	0	1674194515585	1674194530425	1674194530432	success	0	null
kpa4fmurxt8i3ft9ogij4thmfy	expiry_notify	0	1674201743720	1674203273774	1674203274499	success	0	null
17mg65t98pykzbbqjorydcunwc	product_notices	0	1674201743713	1674203273785	1674203275409	success	0	null
rxktrszsbj8p5mk5z1k9wtfyoc	expiry_notify	0	1674203273539	1674203288791	1674203288816	success	0	null
nh6synuzqj88m8cakj5xi1s9fr	expiry_notify	0	1674211217820	1674211228120	1674211228166	success	0	null
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
2463761527	http://localhost:8080	1673971200000	none	null
1721446	http://localhost:8080	1674057600000	none	null
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
com.mattermost.apps	mmi_botid	\\x34797278656364717937383575627a31777472366f756435756f	0
playbooks	mmi_botid	\\x373479353863616165627967386d6778357039677a6d38753572	0
focalboard	mmi_botid	\\x6a66357070317862626a6e75376a3962656b6b6d756866383768	0
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
fh8ph1nnn7fbpdwh1z6uekfwxr	1673966481292	1673966481292	0	0	f	qio139w9xbyc9pknsx1wo388xc	cxtmz3ubz3gfigd5m6prendmsw			matrix_matrix_a joined the team.	system_join_team	{"username": "matrix_matrix_a"}		[]	[]	f	\N
u63ypcgpxb8dfjso8iioit89de	1673966481326	1673966481326	0	0	f	qio139w9xbyc9pknsx1wo388xc	73uy6kj1jb8wdqrf3ti6zies6r			matrix_matrix_a joined the channel.	system_join_channel	{"username": "matrix_matrix_a"}		[]	[]	f	\N
8n1i1sszajnmfbaexpaqjaat5c	1673966481577	1673966481577	0	0	f	bqyuo5n95igtiqj15enjran1br	cxtmz3ubz3gfigd5m6prendmsw			matrix_matrix_b joined the team.	system_join_team	{"username": "matrix_matrix_b"}		[]	[]	f	\N
8k57ckw1upb3i8wu4xjuydt3ha	1673966481638	1673966481638	0	0	f	bqyuo5n95igtiqj15enjran1br	73uy6kj1jb8wdqrf3ti6zies6r			matrix_matrix_b joined the channel.	system_join_channel	{"username": "matrix_matrix_b"}		[]	[]	f	\N
ciahhh1nr3n35qmxxy5tf9q3oy	1673968214744	1673968214744	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	cxtmz3ubz3gfigd5m6prendmsw			user1.mm added to the team by admin.	system_add_to_team	{"userId": "bmq7jiumpib3xdz3mx5iyo99ro", "username": "admin", "addedUserId": "z3pbizcrujd8jfyqq3z3zj1i5c", "addedUsername": "user1.mm"}		[]	[]	f	\N
n383r37u9jfq7k8rhj9696qyge	1673968214821	1673968214821	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	73uy6kj1jb8wdqrf3ti6zies6r			user1.mm added to the channel by admin.	system_add_to_channel	{"userId": "bmq7jiumpib3xdz3mx5iyo99ro", "username": "admin", "addedUserId": "z3pbizcrujd8jfyqq3z3zj1i5c", "addedUsername": "user1.mm"}		[]	[]	f	\N
unrykzp1jpnsx8ns4pqdozxwoa	1673969011227	1673969011227	0	0	f	bmq7jiumpib3xdz3mx5iyo99ro	73uy6kj1jb8wdqrf3ti6zies6r			matrix_user1.matrix added to the channel by admin.	system_add_to_channel	{"userId": "bmq7jiumpib3xdz3mx5iyo99ro", "username": "admin", "addedUserId": "hfby48bpd3r5je83kq15ocnyiy", "addedUsername": "matrix_user1.matrix"}		[]	[]	f	\N
ixx5nbt5mtrytrfebxrd3ecrtr	1673969011303	1673969011303	0	0	f	hfby48bpd3r5je83kq15ocnyiy	cxtmz3ubz3gfigd5m6prendmsw			matrix_user1.matrix joined the team.	system_join_team	{"username": "matrix_user1.matrix"}		[]	[]	f	\N
o3ie8tpmhpyeimygeb573csy3o	1673969011359	1673969011359	0	0	f	hfby48bpd3r5je83kq15ocnyiy	73uy6kj1jb8wdqrf3ti6zies6r			matrix_user1.matrix joined the channel.	system_join_channel	{"username": "matrix_user1.matrix"}		[]	[]	f	\N
kiogcheho3dnfxquy57cobdjfr	1673972702862	1673972702862	0	0	f	z3pbizcrujd8jfyqq3z3zj1i5c	73uy6kj1jb8wdqrf3ti6zies6r			Atque optio veritatis culpa harum amet dolorum aspernatur quidem quidem. Laborum voluptatibus est esse veniam. Nisi eligendi harum eos magni. Impedit incidunt occaecati atque deleniti.		{"disable_group_highlight": true}		[]	[]	f	\N
wk465zuxh78qxdzxfbg6y4bgaa	1673972847037	1673972847037	0	0	f	z3pbizcrujd8jfyqq3z3zj1i5c	73uy6kj1jb8wdqrf3ti6zies6r			Ratione sequi provident placeat blanditiis saepe autem fugit sed voluptatibus. Qui doloremque perferendis libero. Hic occaecati voluptatem atque cum. Minus atque consequuntur debitis enim suscipit corrupti cumque libero autem. Ullam commodi est perferendis dolor eligendi. Sint sit odit quibusdam.		{"disable_group_highlight": true}		[]	[]	f	\N
uya3x4wijjnu3n7em4wgnszs8a	1673972918617	1673972918617	0	0	f	z3pbizcrujd8jfyqq3z3zj1i5c	73uy6kj1jb8wdqrf3ti6zies6r			Totam ullam nemo earum. Vero fugiat ratione enim maxime molestias. Quae voluptate ut alias nemo deserunt. Rem est quis expedita. Molestiae assumenda est architecto quod occaecati aperiam ut. Occaecati eligendi explicabo non tenetur sit.		{"disable_group_highlight": true}		[]	[]	f	\N
wzff6e1kxfyzjm3e8kdogaekah	1673972961810	1673972961810	0	0	f	hfby48bpd3r5je83kq15ocnyiy	cxtmz3ubz3gfigd5m6prendmsw			Playwright Test - Message from Element 		{}		[]	[]	f	\N
hfrgor18sjyqicnjri48h8ycie	1673972964796	1673972964796	0	0	f	hfby48bpd3r5je83kq15ocnyiy	cxtmz3ubz3gfigd5m6prendmsw			URL=http://localhost:8080 risky Browser=false 		{}		[]	[]	f	\N
33bfc8ghopbfddu6ztg1z98a6r	1673972965594	1673972965594	0	0	f	hfby48bpd3r5je83kq15ocnyiy	cxtmz3ubz3gfigd5m6prendmsw			Timestamp=1673972959618		{}		[]	[]	f	\N
jw96kwqc4i8rdpwd8btfs7ffey	1673973089691	1673973089691	0	0	f	bqyuo5n95igtiqj15enjran1br	cxtmz3ubz3gfigd5m6prendmsw			Strange message seen:\nsynthesizing the card won't do anything, we need to generate the virtual EXE transmitter!\n from Ross_Klein19@hotmail.com		{}		[]	[]	f	\N
9exfeugugpfkbmjqt8ksxr7jre	1673973777583	1673973777583	0	0	f	bqyuo5n95igtiqj15enjran1br	cxtmz3ubz3gfigd5m6prendmsw			Strange message seen:\nYou can't copy the panel without navigating the neural RAM sensor!\n from Elouise_Torphy@hotmail.com		{}		[]	[]	f	\N
hfear7hhz7dq8cdesdphtnadma	1673974304160	1673974304160	0	0	f	bqyuo5n95igtiqj15enjran1br	cxtmz3ubz3gfigd5m6prendmsw			Strange message seen:\nThe SMS alarm is down, override the back-end driver so we can copy the HTTP array!\n from Keenan72@yahoo.com		{}		[]	[]	f	\N
gozfd9nr6jfyxrnnfabewjgyqa	1673974370988	1673974370988	0	0	f	bqyuo5n95igtiqj15enjran1br	cxtmz3ubz3gfigd5m6prendmsw			Strange message seen:\nYou can't bypass the firewall without connecting the primary USB microchip!\n from Ben.Sawayn86@hotmail.com		{}		[]	[]	f	\N
g9nfhps1e3yopqaxrp3mmczwyw	1673974421779	1673974421779	0	0	f	bqyuo5n95igtiqj15enjran1br	cxtmz3ubz3gfigd5m6prendmsw			Strange message seen:\nThe IB bus is down, reboot the solid state sensor so we can input the UTF8 protocol!\n from Kaelyn.Wilkinson61@hotmail.com		{}		[]	[]	f	\N
e1f3s8mq6t843n1rryqfukfu4r	1673974499284	1673974499284	0	0	f	bqyuo5n95igtiqj15enjran1br	cxtmz3ubz3gfigd5m6prendmsw			Strange message seen:\nIf we input the system, we can get to the SAS driver through the haptic SDD capacitor!\n from Cary.Bahringer89@hotmail.com		{}		[]	[]	f	\N
7in3d1wdt3rapdifkuye1ygfue	1673974509291	1673974509291	0	0	f	bqyuo5n95igtiqj15enjran1br	cxtmz3ubz3gfigd5m6prendmsw			Strange message seen:\nIf we hack the monitor, we can get to the HEX hard drive through the wireless USB port!\n from Carolyn.Kshlerin@hotmail.com		{}		[]	[]	f	\N
p3xpqtx1k3gb8r1bcew3aj4aeo	1673974557078	1673974557078	0	0	f	bqyuo5n95igtiqj15enjran1br	cxtmz3ubz3gfigd5m6prendmsw			Strange message seen:\nUse the online HDD driver, then you can index the auxiliary alarm!\n from Wallace_Stoltenberg36@gmail.com		{}		[]	[]	f	\N
bbna6kw78pba8kedke1d5zd1zr	1674060065873	1674060065873	0	0	f	hfby48bpd3r5je83kq15ocnyiy	cxtmz3ubz3gfigd5m6prendmsw			Playwright Test - Message from Element 		{}		[]	[]	f	\N
mzsrzeef8iy9ubn3jycoa1dmya	1674060068867	1674060068867	0	0	f	hfby48bpd3r5je83kq15ocnyiy	cxtmz3ubz3gfigd5m6prendmsw			URL=http://localhost:8080 risky Browser=false 		{}		[]	[]	f	\N
61p3qt6uipd1jm3qu9bftbyrpc	1674060070295	1674060070295	0	0	f	hfby48bpd3r5je83kq15ocnyiy	cxtmz3ubz3gfigd5m6prendmsw			Timestamp=1674060064296		{}		[]	[]	f	\N
65gt9g1ht3dm5pkzjzu44whjuh	1674111790274	1674111790274	0	0	f	z3pbizcrujd8jfyqq3z3zj1i5c	r19piuh75bya3ddt69xhjohsba			user1.mm joined the channel.	system_join_channel	{"username": "user1.mm"}		[]	[]	f	\N
toa88dt5ijyibqie613rpisrtc	1674111815646	1674111815646	0	0	f	z3pbizcrujd8jfyqq3z3zj1i5c	r19piuh75bya3ddt69xhjohsba			matrix_user1.matrix added to the channel by user1.mm.	system_add_to_channel	{"userId": "z3pbizcrujd8jfyqq3z3zj1i5c", "username": "user1.mm", "addedUserId": "hfby48bpd3r5je83kq15ocnyiy", "addedUsername": "matrix_user1.matrix"}		[]	[]	f	\N
ogd48p5rwjbr3eubryzimfskah	1674111828470	1674111828470	0	0	f	z3pbizcrujd8jfyqq3z3zj1i5c	r19piuh75bya3ddt69xhjohsba			Now lets talk bandy		{"disable_group_highlight": true}		[]	[]	f	\N
nf65arnu5jd7xp8m8n179xocga	1674112749988	1674112749988	0	0	f	z3pbizcrujd8jfyqq3z3zj1i5c	r19piuh75bya3ddt69xhjohsba			Bandy is cool		{"disable_group_highlight": true}		[]	[]	f	\N
z7snmgqbubrm5dx57cc655bjjc	1674112798294	1674112798294	0	0	f	z3pbizcrujd8jfyqq3z3zj1i5c	sc6xxqg7qfn8fr9a7dj5pfqudr			user1.mm joined the channel.	system_join_channel	{"username": "user1.mm"}		[]	[]	f	\N
4g86khei87r9frxfarjhaocxoy	1674112823951	1674112823951	0	0	f	z3pbizcrujd8jfyqq3z3zj1i5c	sc6xxqg7qfn8fr9a7dj5pfqudr			matrix_user1.matrix added to the channel by user1.mm.	system_add_to_channel	{"userId": "z3pbizcrujd8jfyqq3z3zj1i5c", "username": "user1.mm", "addedUserId": "hfby48bpd3r5je83kq15ocnyiy", "addedUsername": "matrix_user1.matrix"}		[]	[]	f	\N
mqt4mixqzpb9fjwo8a7k3e5ifw	1674112851403	1674112851403	0	0	f	z3pbizcrujd8jfyqq3z3zj1i5c	sc6xxqg7qfn8fr9a7dj5pfqudr			Tumba		{"disable_group_highlight": true}		[]	[]	f	\N
969xtnz1nifd3mkd4mr9rd5xra	1674210869427	1674210869427	0	0	f	hfby48bpd3r5je83kq15ocnyiy	73uy6kj1jb8wdqrf3ti6zies6r			Hi there		{}		[]	[]	f	\N
14k56sm19pgspjyiw3eeguqa7o	1674210901984	1674210901984	0	0	f	z3pbizcrujd8jfyqq3z3zj1i5c	73uy6kj1jb8wdqrf3ti6zies6r					{"disable_group_highlight": true}		[]	["osidpr7repn5pejjjn79jonabw"]	f	\N
9arqkaza4irbixj5xqekrxeaqr	1674211099218	1674211099218	0	0	f	hfby48bpd3r5je83kq15ocnyiy	73uy6kj1jb8wdqrf3ti6zies6r					{}		[]	["xrmywz8trfno7jx7dyt7nqzt1c"]	f	\N
f5stqsigmpg33mbjf8sfimsrra	1674211228005	1674211228005	0	0	f	hfby48bpd3r5je83kq15ocnyiy	73uy6kj1jb8wdqrf3ti6zies6r					{}		[]	["yd5pem8jqtdkp85ujit6sbsnqh"]	f	\N
iy5cuxty378h3qaydjwyxmdm1o	1674211519784	1674211519784	0	0	f	hfby48bpd3r5je83kq15ocnyiy	cxtmz3ubz3gfigd5m6prendmsw			Nice		{}		[]	[]	f	\N
\.


--
-- Data for Name: preferences; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.preferences (userid, category, name, value) FROM stdin;
bmq7jiumpib3xdz3mx5iyo99ro	tutorial_step	bmq7jiumpib3xdz3mx5iyo99ro	0
5bw66y36bff3umq1q57mfy4y5c	tutorial_step	5bw66y36bff3umq1q57mfy4y5c	0
0z4okgmv5lfhx3p0tf6pnpk8sk	tutorial_step	0z4okgmv5lfhx3p0tf6pnpk8sk	0
3zats68fztgu9mgu944a4t35so	tutorial_step	3zats68fztgu9mgu944a4t35so	0
qio139w9xbyc9pknsx1wo388xc	recommended_next_steps	hide	false
qio139w9xbyc9pknsx1wo388xc	tutorial_step	qio139w9xbyc9pknsx1wo388xc	0
qio139w9xbyc9pknsx1wo388xc	insights	insights_tutorial_state	{"insights_modal_viewed":true}
bqyuo5n95igtiqj15enjran1br	recommended_next_steps	hide	false
bqyuo5n95igtiqj15enjran1br	tutorial_step	bqyuo5n95igtiqj15enjran1br	0
bqyuo5n95igtiqj15enjran1br	insights	insights_tutorial_state	{"insights_modal_viewed":true}
z3pbizcrujd8jfyqq3z3zj1i5c	tutorial_step	z3pbizcrujd8jfyqq3z3zj1i5c	0
z3pbizcrujd8jfyqq3z3zj1i5c	insights	insights_tutorial_state	{"insights_modal_viewed":true}
bmq7jiumpib3xdz3mx5iyo99ro	onboarding_task_list	onboarding_task_list_show	true
bmq7jiumpib3xdz3mx5iyo99ro	recommended_next_steps	hide	true
bmq7jiumpib3xdz3mx5iyo99ro	onboarding_task_list	onboarding_task_list_open	false
bmq7jiumpib3xdz3mx5iyo99ro	channel_approximate_view_time		1673968029119
z3pbizcrujd8jfyqq3z3zj1i5c	onboarding_task_list	onboarding_task_list_show	true
z3pbizcrujd8jfyqq3z3zj1i5c	recommended_next_steps	hide	true
z3pbizcrujd8jfyqq3z3zj1i5c	onboarding_task_list	onboarding_task_list_open	false
hfby48bpd3r5je83kq15ocnyiy	recommended_next_steps	hide	false
hfby48bpd3r5je83kq15ocnyiy	tutorial_step	hfby48bpd3r5je83kq15ocnyiy	0
hfby48bpd3r5je83kq15ocnyiy	insights	insights_tutorial_state	{"insights_modal_viewed":true}
z3pbizcrujd8jfyqq3z3zj1i5c	crt_thread_pane_step	z3pbizcrujd8jfyqq3z3zj1i5c	999
z3pbizcrujd8jfyqq3z3zj1i5c	favorite_channel	r19piuh75bya3ddt69xhjohsba	true
z3pbizcrujd8jfyqq3z3zj1i5c	favorite_channel	73uy6kj1jb8wdqrf3ti6zies6r	true
z3pbizcrujd8jfyqq3z3zj1i5c	favorite_channel	cxtmz3ubz3gfigd5m6prendmsw	true
z3pbizcrujd8jfyqq3z3zj1i5c	channel_approximate_view_time		1674203324259
\.


--
-- Data for Name: productnoticeviewstate; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.productnoticeviewstate (userid, noticeid, viewed, "timestamp") FROM stdin;
qio139w9xbyc9pknsx1wo388xc	use_case_survey	1	1673966481
qio139w9xbyc9pknsx1wo388xc	june15-cloud-freemium	1	1673966481
qio139w9xbyc9pknsx1wo388xc	desktop_upgrade_v5.2	1	1673966481
qio139w9xbyc9pknsx1wo388xc	server_upgrade_v7.5	1	1673966481
qio139w9xbyc9pknsx1wo388xc	crt-admin-disabled	1	1673966481
qio139w9xbyc9pknsx1wo388xc	crt-admin-default_off	1	1673966481
qio139w9xbyc9pknsx1wo388xc	crt-user-default-on	1	1673966481
qio139w9xbyc9pknsx1wo388xc	crt-user-always-on	1	1673966481
qio139w9xbyc9pknsx1wo388xc	v6.0_user_introduction	1	1673966481
qio139w9xbyc9pknsx1wo388xc	v6.2_boards	1	1673966481
qio139w9xbyc9pknsx1wo388xc	unsupported-server-v5.37	1	1673966481
bqyuo5n95igtiqj15enjran1br	use_case_survey	1	1673966481
bqyuo5n95igtiqj15enjran1br	june15-cloud-freemium	1	1673966481
bqyuo5n95igtiqj15enjran1br	desktop_upgrade_v5.2	1	1673966481
bqyuo5n95igtiqj15enjran1br	server_upgrade_v7.5	1	1673966481
bqyuo5n95igtiqj15enjran1br	crt-admin-disabled	1	1673966481
bqyuo5n95igtiqj15enjran1br	crt-admin-default_off	1	1673966481
bqyuo5n95igtiqj15enjran1br	crt-user-default-on	1	1673966481
bqyuo5n95igtiqj15enjran1br	crt-user-always-on	1	1673966481
bqyuo5n95igtiqj15enjran1br	v6.0_user_introduction	1	1673966481
bqyuo5n95igtiqj15enjran1br	v6.2_boards	1	1673966481
bqyuo5n95igtiqj15enjran1br	unsupported-server-v5.37	1	1673966481
z3pbizcrujd8jfyqq3z3zj1i5c	use_case_survey	1	1673967395
z3pbizcrujd8jfyqq3z3zj1i5c	june15-cloud-freemium	1	1673967395
z3pbizcrujd8jfyqq3z3zj1i5c	desktop_upgrade_v5.2	1	1673967395
z3pbizcrujd8jfyqq3z3zj1i5c	server_upgrade_v7.5	1	1673967395
z3pbizcrujd8jfyqq3z3zj1i5c	crt-admin-disabled	1	1673967395
z3pbizcrujd8jfyqq3z3zj1i5c	crt-admin-default_off	1	1673967395
z3pbizcrujd8jfyqq3z3zj1i5c	crt-user-default-on	1	1673967395
z3pbizcrujd8jfyqq3z3zj1i5c	crt-user-always-on	1	1673967395
z3pbizcrujd8jfyqq3z3zj1i5c	v6.0_user_introduction	1	1673967395
z3pbizcrujd8jfyqq3z3zj1i5c	v6.2_boards	1	1673967395
z3pbizcrujd8jfyqq3z3zj1i5c	unsupported-server-v5.37	1	1673967395
bmq7jiumpib3xdz3mx5iyo99ro	june15-cloud-freemium	1	1673967450
bmq7jiumpib3xdz3mx5iyo99ro	crt-user-always-on	1	1673967867
hfby48bpd3r5je83kq15ocnyiy	use_case_survey	1	1673969010
hfby48bpd3r5je83kq15ocnyiy	june15-cloud-freemium	1	1673969010
hfby48bpd3r5je83kq15ocnyiy	desktop_upgrade_v5.2	1	1673969010
hfby48bpd3r5je83kq15ocnyiy	server_upgrade_v7.5	1	1673969010
hfby48bpd3r5je83kq15ocnyiy	crt-admin-disabled	1	1673969010
hfby48bpd3r5je83kq15ocnyiy	crt-admin-default_off	1	1673969010
hfby48bpd3r5je83kq15ocnyiy	crt-user-default-on	1	1673969010
hfby48bpd3r5je83kq15ocnyiy	crt-user-always-on	1	1673969010
hfby48bpd3r5je83kq15ocnyiy	v6.0_user_introduction	1	1673969010
hfby48bpd3r5je83kq15ocnyiy	v6.2_boards	1	1673969010
hfby48bpd3r5je83kq15ocnyiy	unsupported-server-v5.37	1	1673969010
\.


--
-- Data for Name: publicchannels; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.publicchannels (id, deleteat, teamid, displayname, name, header, purpose) FROM stdin;
cxtmz3ubz3gfigd5m6prendmsw	0	tgrw7sjgbiy1jggs3qg3m6zpee	Town Square	town-square		
73uy6kj1jb8wdqrf3ti6zies6r	0	tgrw7sjgbiy1jggs3qg3m6zpee	Off-Topic	off-topic		
r19piuh75bya3ddt69xhjohsba	0	tgrw7sjgbiy1jggs3qg3m6zpee	Bandy	bandy		Testing
\.


--
-- Data for Name: reactions; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.reactions (userid, postid, emojiname, createat, channelid, updateat, deleteat, remoteid) FROM stdin;
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
getwmro16pd7jrn1oqrkmn1wsw	system_user	authentication.roles.global_user.name	authentication.roles.global_user.description	1598351767781	1673965810450	0	 create_group_channel create_custom_group delete_custom_group delete_emojis list_public_teams join_public_teams edit_custom_group create_direct_channel manage_custom_group_members create_emojis view_members create_team	t	t
ghsp7z49qbbi5bhuoqaqqs6ake	channel_admin	authentication.roles.channel_admin.name	authentication.roles.channel_admin.description	1598351767766	1673965810453	0	 manage_private_channel_members remove_reaction manage_public_channel_members manage_channel_roles use_group_mentions create_post read_private_channel_groups use_channel_mentions read_public_channel_groups add_reaction	t	t
t6x4ph1uojb398ciuhkgqzexfw	channel_user	authentication.roles.channel_user.name	authentication.roles.channel_user.description	1598351767775	1673965810455	0	 upload_file use_slash_commands manage_private_channel_members read_public_channel_groups edit_post manage_public_channel_members read_private_channel_groups create_post delete_private_channel delete_public_channel manage_public_channel_properties delete_post read_channel remove_reaction manage_private_channel_properties use_channel_mentions get_public_link use_group_mentions add_reaction	t	t
gygr3fd64p8izpynu6uef8jq3r	channel_guest	authentication.roles.channel_guest.name	authentication.roles.channel_guest.description	1598351767780	1673965810457	0	 upload_file edit_post create_post use_channel_mentions use_slash_commands read_channel add_reaction remove_reaction	t	t
jgrdf15eifyu5gsrum87u8ka5y	team_guest	authentication.roles.team_guest.name	authentication.roles.team_guest.description	1598351767768	1673965810459	0	 view_team	t	t
sw8erru9jjyzfegokosh9sb15h	system_user_access_token	authentication.roles.system_user_access_token.name	authentication.roles.system_user_access_token.description	1598351767769	1673965810462	0	 revoke_user_access_token create_user_access_token read_user_access_token	f	t
cqedmkhfmtfhidp18w8pkogtpa	team_post_all	authentication.roles.team_post_all.name	authentication.roles.team_post_all.description	1598351767777	1673965810433	0	 use_group_mentions use_channel_mentions create_post	f	t
jdfscmmwq7yc9pb3j8egpkrhgo	team_admin	authentication.roles.team_admin.name	authentication.roles.team_admin.description	1598351767783	1673965810435	0	 manage_others_outgoing_webhooks manage_others_incoming_webhooks manage_private_channel_members remove_user_from_team convert_public_channel_to_private read_public_channel_groups delete_others_posts add_reaction manage_outgoing_webhooks import_team remove_reaction playbook_private_manage_roles use_group_mentions delete_post manage_team manage_channel_roles manage_slash_commands playbook_public_manage_roles create_post manage_team_roles use_channel_mentions manage_incoming_webhooks convert_private_channel_to_public manage_public_channel_members read_private_channel_groups manage_others_slash_commands	t	t
xqc3eckiafg5i86jthcwbazdpy	team_user	authentication.roles.team_user.name	authentication.roles.team_user.description	1598351767784	1673965810446	0	 join_public_channels add_user_to_team playbook_public_create invite_user playbook_private_create read_public_channel create_public_channel list_team_channels create_private_channel view_team	t	t
go6yxappktb93quowz9j6mkjra	team_post_all_public	authentication.roles.team_post_all_public.name	authentication.roles.team_post_all_public.description	1598351767786	1673965810448	0	 use_group_mentions use_channel_mentions create_post_public	f	t
bz5fnxng6iyhtgz9gd6n69xdgh	system_read_only_admin	authentication.roles.system_read_only_admin.name	authentication.roles.system_read_only_admin.description	1673965809070	1673965810471	0	 read_ldap_sync_job sysconsole_read_reporting_team_statistics sysconsole_read_compliance_custom_terms_of_service sysconsole_read_experimental_bleve sysconsole_read_environment_logging read_elasticsearch_post_indexing_job sysconsole_read_authentication_saml sysconsole_read_environment_file_storage sysconsole_read_user_management_groups read_compliance_export_job read_license_information sysconsole_read_compliance_compliance_monitoring read_channel list_private_teams sysconsole_read_environment_developer test_ldap sysconsole_read_environment_smtp sysconsole_read_experimental_feature_flags sysconsole_read_site_public_links sysconsole_read_user_management_channels sysconsole_read_site_notices sysconsole_read_about_edition_and_license sysconsole_read_authentication_signup read_audits sysconsole_read_reporting_site_statistics read_private_channel_groups sysconsole_read_authentication_email sysconsole_read_experimental_features sysconsole_read_integrations_cors read_other_users_teams read_data_retention_job sysconsole_read_site_users_and_teams sysconsole_read_compliance_data_retention_policy sysconsole_read_integrations_integration_management get_logs sysconsole_read_site_customization sysconsole_read_user_management_users read_public_channel sysconsole_read_user_management_teams sysconsole_read_authentication_ldap sysconsole_read_authentication_password sysconsole_read_reporting_server_logs sysconsole_read_environment_rate_limiting view_team sysconsole_read_products_boards sysconsole_read_environment_high_availability list_public_teams sysconsole_read_site_announcement_banner sysconsole_read_environment_session_lengths sysconsole_read_site_localization download_compliance_export_result read_elasticsearch_post_aggregation_job read_public_channel_groups sysconsole_read_environment_elasticsearch sysconsole_read_environment_performance_monitoring sysconsole_read_site_file_sharing_and_downloads sysconsole_read_integrations_bot_accounts sysconsole_read_compliance_compliance_export sysconsole_read_site_notifications sysconsole_read_authentication_openid get_analytics sysconsole_read_site_posts sysconsole_read_environment_push_notification_server sysconsole_read_site_emoji sysconsole_read_authentication_mfa sysconsole_read_integrations_gif sysconsole_read_plugins sysconsole_read_authentication_guest_access sysconsole_read_environment_database sysconsole_read_environment_image_proxy sysconsole_read_user_management_permissions sysconsole_read_environment_web_server	f	t
bxof3zyb43f5xdfuxtim9a3ese	system_custom_group_admin	authentication.roles.system_custom_group_admin.name	authentication.roles.system_custom_group_admin.description	1673965809116	1673965810474	0	 delete_custom_group manage_custom_group_members create_custom_group edit_custom_group	f	t
qj5hbu454fn63njq69nni3drxh	system_post_all	authentication.roles.system_post_all.name	authentication.roles.system_post_all.description	1598351767778	1673965810437	0	 use_channel_mentions use_group_mentions create_post	f	t
abmhgi8pa3robkzd7kfzongfmc	system_guest	authentication.roles.global_guest.name	authentication.roles.global_guest.description	1598351767761	1673965810440	0	 create_group_channel create_direct_channel	t	t
3sojxu7t47r95cfjs94yywyd9c	system_post_all_public	authentication.roles.system_post_all_public.name	authentication.roles.system_post_all_public.description	1598351767764	1673965810442	0	 create_post_public use_channel_mentions use_group_mentions	f	t
fz35fufa1pf9fd9gcwtpmjtxuy	system_manager	authentication.roles.system_manager.name	authentication.roles.system_manager.description	1673965809060	1673965810469	0	 sysconsole_read_reporting_team_statistics test_elasticsearch test_email read_elasticsearch_post_aggregation_job sysconsole_read_integrations_gif sysconsole_write_environment_developer sysconsole_read_site_notifications sysconsole_read_about_edition_and_license manage_private_channel_members sysconsole_read_authentication_guest_access sysconsole_write_site_users_and_teams test_site_url sysconsole_read_site_file_sharing_and_downloads sysconsole_write_environment_push_notification_server sysconsole_read_environment_rate_limiting sysconsole_read_site_posts sysconsole_read_authentication_mfa reload_config read_channel get_analytics sysconsole_read_environment_web_server get_logs sysconsole_read_site_localization recycle_database_connections sysconsole_read_environment_developer sysconsole_read_site_notices sysconsole_read_environment_file_storage sysconsole_write_site_posts sysconsole_read_site_customization read_public_channel sysconsole_write_site_emoji sysconsole_write_environment_image_proxy sysconsole_read_integrations_integration_management list_public_teams convert_public_channel_to_private sysconsole_read_authentication_email sysconsole_read_user_management_groups sysconsole_read_plugins join_private_teams sysconsole_read_authentication_password sysconsole_write_products_boards manage_team sysconsole_read_reporting_server_logs sysconsole_read_authentication_ldap test_s3 invalidate_caches sysconsole_write_environment_high_availability sysconsole_write_site_notices sysconsole_read_authentication_saml manage_team_roles view_team sysconsole_read_site_users_and_teams sysconsole_read_environment_logging sysconsole_read_site_announcement_banner join_public_teams manage_public_channel_properties edit_brand sysconsole_read_environment_performance_monitoring sysconsole_read_environment_push_notification_server sysconsole_read_environment_session_lengths sysconsole_write_site_file_sharing_and_downloads sysconsole_write_environment_rate_limiting convert_private_channel_to_public sysconsole_write_integrations_bot_accounts list_private_teams sysconsole_write_site_customization sysconsole_write_environment_performance_monitoring read_license_information sysconsole_write_environment_session_lengths read_private_channel_groups manage_public_channel_members sysconsole_write_environment_database sysconsole_read_integrations_bot_accounts sysconsole_read_environment_database sysconsole_write_integrations_cors delete_private_channel sysconsole_write_user_management_channels sysconsole_write_user_management_permissions sysconsole_read_environment_image_proxy sysconsole_write_user_management_teams sysconsole_write_environment_logging create_elasticsearch_post_indexing_job sysconsole_write_site_public_links purge_elasticsearch_indexes delete_public_channel sysconsole_read_site_emoji create_elasticsearch_post_aggregation_job manage_channel_roles sysconsole_write_integrations_integration_management sysconsole_read_integrations_cors sysconsole_read_authentication_openid sysconsole_read_site_public_links sysconsole_write_environment_smtp sysconsole_write_environment_elasticsearch sysconsole_read_user_management_teams read_elasticsearch_post_indexing_job sysconsole_read_user_management_permissions sysconsole_read_environment_high_availability sysconsole_write_site_localization sysconsole_write_environment_web_server read_public_channel_groups add_user_to_team sysconsole_read_reporting_site_statistics remove_user_from_team sysconsole_write_environment_file_storage sysconsole_read_authentication_signup sysconsole_write_site_notifications sysconsole_read_environment_elasticsearch manage_private_channel_properties sysconsole_read_user_management_channels read_ldap_sync_job sysconsole_write_user_management_groups sysconsole_write_integrations_gif sysconsole_read_products_boards test_ldap sysconsole_read_environment_smtp sysconsole_write_site_announcement_banner	f	t
mdtd11n7mb88ubdp6fgnxbho5o	system_user_manager	authentication.roles.system_user_manager.name	authentication.roles.system_user_manager.description	1673965809105	1673965810472	0	 sysconsole_read_authentication_signup sysconsole_read_authentication_password test_ldap convert_private_channel_to_public manage_team read_ldap_sync_job sysconsole_read_user_management_permissions sysconsole_read_user_management_groups sysconsole_write_user_management_groups read_public_channel sysconsole_read_authentication_email manage_team_roles read_channel add_user_to_team sysconsole_write_user_management_channels sysconsole_read_user_management_channels manage_channel_roles manage_private_channel_members remove_user_from_team convert_public_channel_to_private sysconsole_read_authentication_guest_access manage_public_channel_properties delete_private_channel read_public_channel_groups delete_public_channel sysconsole_read_authentication_mfa sysconsole_read_authentication_openid list_public_teams list_private_teams sysconsole_read_user_management_teams sysconsole_read_authentication_ldap manage_public_channel_members join_private_teams manage_private_channel_properties read_private_channel_groups view_team sysconsole_write_user_management_teams sysconsole_read_authentication_saml join_public_teams	f	t
nypn4aniofbf9eu4efqkb1n56y	system_admin	authentication.roles.global_admin.name	authentication.roles.global_admin.description	1598351767771	1673965810466	0	 sysconsole_read_site_emoji delete_others_emojis demote_to_guest sysconsole_write_authentication_saml promote_guest create_post_ephemeral sysconsole_write_site_announcement_banner remove_saml_private_cert invite_guest invalidate_email_invite create_post_public manage_shared_channels sysconsole_read_authentication_email sysconsole_write_reporting_server_logs sysconsole_read_about_edition_and_license playbook_public_manage_members read_channel sysconsole_read_reporting_team_statistics sysconsole_read_experimental_feature_flags manage_private_channel_members sysconsole_write_environment_database sysconsole_read_environment_performance_monitoring sysconsole_read_plugins invite_user remove_ldap_public_cert sysconsole_read_environment_rate_limiting edit_brand manage_jobs add_ldap_private_cert read_user_access_token sysconsole_read_environment_file_storage sysconsole_write_user_management_permissions manage_others_bots sysconsole_write_environment_image_proxy playbook_private_manage_properties sysconsole_write_experimental_feature_flags run_create sysconsole_write_experimental_bleve sysconsole_read_environment_elasticsearch view_members sysconsole_write_integrations_integration_management sysconsole_read_user_management_channels list_users_without_team add_ldap_public_cert sysconsole_read_site_public_links convert_public_channel_to_private sysconsole_write_site_localization sysconsole_write_authentication_email test_s3 sysconsole_read_integrations_gif sysconsole_write_site_file_sharing_and_downloads read_ldap_sync_job read_license_information create_post sysconsole_read_environment_image_proxy remove_saml_idp_cert create_data_retention_job manage_others_slash_commands edit_post run_manage_members playbook_public_create manage_system read_audits read_other_users_teams create_public_channel use_slash_commands purge_elasticsearch_indexes playbook_public_manage_properties sysconsole_read_environment_database create_custom_group sysconsole_write_authentication_ldap download_compliance_export_result playbook_private_create sysconsole_read_site_localization sysconsole_write_site_customization assign_system_admin_role create_elasticsearch_post_aggregation_job sysconsole_read_authentication_saml sysconsole_read_environment_web_server read_others_bots sysconsole_write_compliance_compliance_monitoring sysconsole_read_authentication_mfa sysconsole_write_environment_session_lengths edit_others_posts sysconsole_read_authentication_password add_saml_idp_cert import_team sysconsole_write_site_notifications sysconsole_write_products_boards purge_bleve_indexes sysconsole_write_environment_rate_limiting playbook_public_manage_roles sysconsole_write_environment_elasticsearch sysconsole_write_environment_file_storage sysconsole_read_environment_developer sysconsole_read_site_users_and_teams sysconsole_read_environment_session_lengths read_private_channel_groups edit_custom_group add_user_to_team sysconsole_read_user_management_groups playbook_public_make_private sysconsole_read_compliance_data_retention_policy remove_saml_public_cert create_post_bleve_indexes_job edit_other_users sysconsole_write_environment_smtp delete_custom_group recycle_database_connections sysconsole_read_compliance_compliance_export test_ldap delete_others_posts playbook_private_manage_roles sysconsole_read_environment_high_availability get_analytics sysconsole_write_reporting_site_statistics test_email run_manage_properties manage_license_information sysconsole_write_site_notices read_elasticsearch_post_aggregation_job sysconsole_write_billing get_saml_cert_status sysconsole_read_experimental_features sysconsole_write_integrations_gif sysconsole_write_environment_developer sysconsole_write_environment_push_notification_server manage_team sysconsole_read_environment_smtp list_private_teams sysconsole_write_environment_high_availability get_logs sysconsole_read_user_management_teams sysconsole_write_plugins sysconsole_write_site_public_links sysconsole_write_authentication_password sysconsole_read_user_management_system_roles create_emojis read_elasticsearch_post_indexing_job manage_others_outgoing_webhooks sysconsole_read_site_notices manage_system_wide_oauth sysconsole_write_integrations_cors sysconsole_read_integrations_cors delete_private_channel manage_public_channel_properties manage_team_roles manage_channel_roles remove_ldap_private_cert read_jobs sysconsole_read_site_posts sysconsole_read_integrations_integration_management add_reaction read_data_retention_job sysconsole_read_compliance_compliance_monitoring sysconsole_write_authentication_openid sysconsole_write_user_management_system_roles sysconsole_read_reporting_site_statistics sysconsole_read_site_announcement_banner sysconsole_write_compliance_compliance_export use_group_mentions sysconsole_read_products_boards list_team_channels manage_oauth sysconsole_write_reporting_team_statistics manage_outgoing_webhooks upload_file join_private_teams sysconsole_read_authentication_guest_access convert_private_channel_to_public sysconsole_write_site_emoji test_site_url manage_custom_group_members sysconsole_read_site_file_sharing_and_downloads playbook_private_make_public remove_user_from_team view_team playbook_private_manage_members sysconsole_write_environment_web_server sysconsole_read_environment_push_notification_server sysconsole_write_authentication_mfa run_view sysconsole_write_user_management_teams join_public_channels sysconsole_read_site_customization read_compliance_export_job delete_public_channel read_public_channel_groups create_elasticsearch_post_indexing_job remove_others_reactions sysconsole_write_site_users_and_teams remove_reaction manage_private_channel_properties create_ldap_sync_job sysconsole_read_user_management_users use_channel_mentions sysconsole_write_user_management_groups sysconsole_write_compliance_data_retention_policy sysconsole_write_site_posts create_compliance_export_job sysconsole_write_compliance_custom_terms_of_service sysconsole_write_user_management_users get_public_link sysconsole_write_environment_logging sysconsole_read_reporting_server_logs playbook_public_view sysconsole_write_environment_performance_monitoring manage_roles create_user_access_token sysconsole_read_billing revoke_user_access_token delete_post create_team sysconsole_read_authentication_ldap add_saml_public_cert playbook_private_view sysconsole_read_authentication_signup manage_incoming_webhooks invalidate_caches sysconsole_write_integrations_bot_accounts manage_public_channel_members create_private_channel manage_others_incoming_webhooks sysconsole_read_site_notifications manage_bots read_bots delete_emojis sysconsole_read_experimental_bleve sysconsole_write_user_management_channels sysconsole_write_about_edition_and_license read_public_channel sysconsole_read_authentication_openid create_bot sysconsole_write_experimental_features add_saml_private_cert test_elasticsearch sysconsole_read_environment_logging get_saml_metadata_from_idp sysconsole_read_user_management_permissions sysconsole_read_compliance_custom_terms_of_service sysconsole_read_integrations_bot_accounts manage_secure_connections sysconsole_write_authentication_guest_access sysconsole_write_authentication_signup reload_config manage_slash_commands	t	t
p1n9g8eu4brajmejujrraoxmko	playbook_admin	authentication.roles.playbook_admin.name	authentication.roles.playbook_admin.description	1673965810491	1673965810491	0	 playbook_public_manage_members playbook_public_manage_roles playbook_public_manage_properties playbook_private_manage_members playbook_private_manage_roles playbook_private_manage_properties playbook_public_make_private	t	t
nyi9bddig7gjpnf3kg99cxwara	playbook_member	authentication.roles.playbook_member.name	authentication.roles.playbook_member.description	1673965810495	1673965810495	0	 playbook_public_view playbook_public_manage_members playbook_public_manage_properties playbook_private_view playbook_private_manage_members playbook_private_manage_properties run_create	t	t
q36b4d5d9ff7f8s37wu7ituaor	run_admin	authentication.roles.run_admin.name	authentication.roles.run_admin.description	1673965810498	1673965810498	0	 run_manage_members run_manage_properties	t	t
53r618p397fcipqro964wkbp7y	run_member	authentication.roles.run_member.name	authentication.roles.run_member.description	1673965810502	1673965810502	0	 run_view	t	t
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
tsik87snnfbjzbjpgnfbqdcb5y	oo9xnia8opr9xrf5gzyw6wchhe	1673973089566	4827573089566	1673974304321	bqyuo5n95igtiqj15enjran1br		system_user	f	f	{"type": "UserAccessToken", "is_guest": "false", "user_access_token_id": "zqa6p4rjcfgcmn5iqqzgjpdn4r"}
fzcwbcg1tfr3fkar9qm49kqfer	s537n3t8zib1tx7eyd44qzqnbr	1673965922891	4827565922891	1674210715649	bmq7jiumpib3xdz3mx5iyo99ro		system_admin system_user	f	f	{"type": "UserAccessToken", "is_guest": "false", "user_access_token_id": "98yjyceocfb5mc3jaibtbmr1ph"}
q6zbdigwcp8gtbbkm4uykb7dua	1icpjqtuetg1be7nmp841fk5uy	1673968258143	1676795324001	1674211179373	z3pbizcrujd8jfyqq3z3zj1i5c		system_user	f	f	{"os": "Mac OS", "csrf": "dghfn3ggsbrbdegri1a8iui79e", "isSaml": "false", "browser": "Chrome/108.0", "isMobile": "false", "is_guest": "false", "platform": "Macintosh", "isOAuthUser": "false"}
sc1kdunmi7y63cdohg4dtw3qho	hjqz5dcjrpd35enutykik45noc	1673972961766	4827572961766	1674211228123	hfby48bpd3r5je83kq15ocnyiy		system_user	f	f	{"type": "UserAccessToken", "is_guest": "false", "user_access_token_id": "z7etn7g1jfnb8pciotu8bawddh"}
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
favorites_qio139w9xbyc9pknsx1wo388xc_tgrw7sjgbiy1jggs3qg3m6zpee	qio139w9xbyc9pknsx1wo388xc	tgrw7sjgbiy1jggs3qg3m6zpee	0		favorites	Favorites	f	f
channels_qio139w9xbyc9pknsx1wo388xc_tgrw7sjgbiy1jggs3qg3m6zpee	qio139w9xbyc9pknsx1wo388xc	tgrw7sjgbiy1jggs3qg3m6zpee	10		channels	Channels	f	f
direct_messages_qio139w9xbyc9pknsx1wo388xc_tgrw7sjgbiy1jggs3qg3m6zpee	qio139w9xbyc9pknsx1wo388xc	tgrw7sjgbiy1jggs3qg3m6zpee	20	recent	direct_messages	Direct Messages	f	f
favorites_bqyuo5n95igtiqj15enjran1br_tgrw7sjgbiy1jggs3qg3m6zpee	bqyuo5n95igtiqj15enjran1br	tgrw7sjgbiy1jggs3qg3m6zpee	0		favorites	Favorites	f	f
channels_bqyuo5n95igtiqj15enjran1br_tgrw7sjgbiy1jggs3qg3m6zpee	bqyuo5n95igtiqj15enjran1br	tgrw7sjgbiy1jggs3qg3m6zpee	10		channels	Channels	f	f
direct_messages_bqyuo5n95igtiqj15enjran1br_tgrw7sjgbiy1jggs3qg3m6zpee	bqyuo5n95igtiqj15enjran1br	tgrw7sjgbiy1jggs3qg3m6zpee	20	recent	direct_messages	Direct Messages	f	f
favorites_bmq7jiumpib3xdz3mx5iyo99ro_tgrw7sjgbiy1jggs3qg3m6zpee	bmq7jiumpib3xdz3mx5iyo99ro	tgrw7sjgbiy1jggs3qg3m6zpee	0		favorites	Favorites	f	f
channels_bmq7jiumpib3xdz3mx5iyo99ro_tgrw7sjgbiy1jggs3qg3m6zpee	bmq7jiumpib3xdz3mx5iyo99ro	tgrw7sjgbiy1jggs3qg3m6zpee	10		channels	Channels	f	f
direct_messages_bmq7jiumpib3xdz3mx5iyo99ro_tgrw7sjgbiy1jggs3qg3m6zpee	bmq7jiumpib3xdz3mx5iyo99ro	tgrw7sjgbiy1jggs3qg3m6zpee	20	recent	direct_messages	Direct Messages	f	f
direct_messages_z3pbizcrujd8jfyqq3z3zj1i5c_tgrw7sjgbiy1jggs3qg3m6zpee	z3pbizcrujd8jfyqq3z3zj1i5c	tgrw7sjgbiy1jggs3qg3m6zpee	20	recent	direct_messages	Direct Messages	f	f
favorites_hfby48bpd3r5je83kq15ocnyiy_tgrw7sjgbiy1jggs3qg3m6zpee	hfby48bpd3r5je83kq15ocnyiy	tgrw7sjgbiy1jggs3qg3m6zpee	0		favorites	Favorites	f	f
channels_hfby48bpd3r5je83kq15ocnyiy_tgrw7sjgbiy1jggs3qg3m6zpee	hfby48bpd3r5je83kq15ocnyiy	tgrw7sjgbiy1jggs3qg3m6zpee	10		channels	Channels	f	f
direct_messages_hfby48bpd3r5je83kq15ocnyiy_tgrw7sjgbiy1jggs3qg3m6zpee	hfby48bpd3r5je83kq15ocnyiy	tgrw7sjgbiy1jggs3qg3m6zpee	20	recent	direct_messages	Direct Messages	f	f
favorites_z3pbizcrujd8jfyqq3z3zj1i5c_tgrw7sjgbiy1jggs3qg3m6zpee	z3pbizcrujd8jfyqq3z3zj1i5c	tgrw7sjgbiy1jggs3qg3m6zpee	0		favorites	Favorites	f	f
channels_z3pbizcrujd8jfyqq3z3zj1i5c_tgrw7sjgbiy1jggs3qg3m6zpee	z3pbizcrujd8jfyqq3z3zj1i5c	tgrw7sjgbiy1jggs3qg3m6zpee	10	recent	channels	Channels	f	t
\.


--
-- Data for Name: sidebarchannels; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.sidebarchannels (channelid, userid, categoryid, sortorder) FROM stdin;
r19piuh75bya3ddt69xhjohsba	z3pbizcrujd8jfyqq3z3zj1i5c	favorites_z3pbizcrujd8jfyqq3z3zj1i5c_tgrw7sjgbiy1jggs3qg3m6zpee	0
73uy6kj1jb8wdqrf3ti6zies6r	z3pbizcrujd8jfyqq3z3zj1i5c	favorites_z3pbizcrujd8jfyqq3z3zj1i5c_tgrw7sjgbiy1jggs3qg3m6zpee	10
cxtmz3ubz3gfigd5m6prendmsw	z3pbizcrujd8jfyqq3z3zj1i5c	favorites_z3pbizcrujd8jfyqq3z3zj1i5c_tgrw7sjgbiy1jggs3qg3m6zpee	20
sc6xxqg7qfn8fr9a7dj5pfqudr	z3pbizcrujd8jfyqq3z3zj1i5c	channels_z3pbizcrujd8jfyqq3z3zj1i5c_tgrw7sjgbiy1jggs3qg3m6zpee	0
\.


--
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.status (userid, status, manual, lastactivityat, dndendtime, prevstatus) FROM stdin;
bqyuo5n95igtiqj15enjran1br	offline	f	1673974304320	0	
z3pbizcrujd8jfyqq3z3zj1i5c	online	f	1674210751903	0	
hfby48bpd3r5je83kq15ocnyiy	online	f	1674211520027	0	
bmq7jiumpib3xdz3mx5iyo99ro	offline	f	1674211548806	0	
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
RemainingSchemaMigrations	true
FirstAdminSetupComplete	true
LastSecurityTime	1674151235427
\.


--
-- Data for Name: teammembers; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.teammembers (teamid, userid, roles, deleteat, schemeuser, schemeadmin, schemeguest, createat) FROM stdin;
tgrw7sjgbiy1jggs3qg3m6zpee	bmq7jiumpib3xdz3mx5iyo99ro		0	t	t	f	0
tgrw7sjgbiy1jggs3qg3m6zpee	5bw66y36bff3umq1q57mfy4y5c		0	t	f	f	0
tgrw7sjgbiy1jggs3qg3m6zpee	0z4okgmv5lfhx3p0tf6pnpk8sk		0	t	f	f	0
tgrw7sjgbiy1jggs3qg3m6zpee	3zats68fztgu9mgu944a4t35so		0	t	f	f	0
tgrw7sjgbiy1jggs3qg3m6zpee	qio139w9xbyc9pknsx1wo388xc		0	t	f	f	1673966481254
tgrw7sjgbiy1jggs3qg3m6zpee	bqyuo5n95igtiqj15enjran1br		0	t	f	f	1673966481456
tgrw7sjgbiy1jggs3qg3m6zpee	z3pbizcrujd8jfyqq3z3zj1i5c		0	t	f	f	1673968214665
tgrw7sjgbiy1jggs3qg3m6zpee	hfby48bpd3r5je83kq15ocnyiy		0	t	f	f	1673969011073
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.teams (id, createat, updateat, deleteat, displayname, name, description, email, type, companyname, alloweddomains, inviteid, allowopeninvite, lastteamiconupdate, schemeid, groupconstrained, cloudlimitsarchived) FROM stdin;
tgrw7sjgbiy1jggs3qg3m6zpee	1598351837711	1673967636205	0	Test Team	test			O			5tdc6sxr43byufri3r6px9f9xo	t	0	\N	f	f
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
ii1puxgctb86ifuw8big5epn6r	zfmxqhxpapbmifxwgdhk7agq8r	qio139w9xbyc9pknsx1wo388xc	bridge	t
zqa6p4rjcfgcmn5iqqzgjpdn4r	oo9xnia8opr9xrf5gzyw6wchhe	bqyuo5n95igtiqj15enjran1br	bridge	t
z7etn7g1jfnb8pciotu8bawddh	hjqz5dcjrpd35enutykik45noc	hfby48bpd3r5je83kq15ocnyiy	bridge	t
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
5bw66y36bff3umq1q57mfy4y5c	1598351800458	1598352057088	0	mattermost_a	$2a$10$WdovEVVvy9ZS867UE2hSq.7hV38Lg9H2ozgaF3gwuO6fuoCkkTzIu	\N		mattermost_a@localhost	f		MattermostUser	A		system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "desktop_sound": "true"}	1598352057088	0	0	en	{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	f		\N
0z4okgmv5lfhx3p0tf6pnpk8sk	1598351800458	1598352057088	0	ignored_user	$2a$10$WdovEVVvy9ZS867UE2hSq.7hV38Lg9H2ozgaF3gwuO6fuoCkkTzIu	\N		ignored_user@localhost	f					system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "desktop_sound": "true"}	1598352057088	0	0	en	{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	f		\N
jf5pp1xbbjnu7j9bekkmuhf87h	1673965821894	1673965821894	0	boards		\N		boards@localhost	f		Boards			system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1673965821894	0	0	en	{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	f		\N
79skdzyqafbftx6orqugpitixy	1673966099803	1673966099803	0	system-bot		\N		system-bot@localhost	f		System			system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1673966099803	0	0	en	{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	f		\N
bmq7jiumpib3xdz3mx5iyo99ro	1598351769026	1598351847718	0	admin	$2a$10$dCK8unlOWxu7Ge1Fmeo70eaETqonsQC1mVbwnLi5lCH5ALbzKyqnO	\N		admin@localhost	f		Admin	User		system_admin system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "desktop_sound": "true"}	1598351769026	0	0	en	{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	f		\N
z3pbizcrujd8jfyqq3z3zj1i5c	1673967395212	1673968214688	0	user1.mm	$2a$10$5hC1Trr6gIf7b4Ebs2iLZ.SLZ8dYfnlNAyMvsuUz.vrI3FypLf3ki	\N		user1.mm@localhost	f					system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1673967395212	0	0	en	{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	f		\N
4yrxecdqy785ubz1wtr6oud5uo	1673965818961	1674210399996	0	appsbot		\N		appsbot@localhost	f		Mattermost Apps			system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1673965818961	1674210399996	0	en	{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	f		\N
74y58caaebyg8mgx5p9gzm8u5r	1673965820126	1674210400876	0	playbooks		\N		playbooks@localhost	f		Playbooks			system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1673965820126	1674210400876	0	en	{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	f		\N
bqyuo5n95igtiqj15enjran1br	1673966481231	1674210716246	0	matrix_matrix_b	$2a$10$crKD3uSMFucdddtKtyFJUuBNsWkQ.qLlCo6vFjMR5Ptz7.tdeHYfi	\N		devnull-bl-fgmpttfchxza-@localhost	t		matrix_b			system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1673966481231	0	0	en	{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	f		\N
qio139w9xbyc9pknsx1wo388xc	1673966481028	1674210716247	0	matrix_matrix_a	$2a$10$aAfumPLpr0l3Xn9IdSdyF.rhtEVFtUG/qzUraTfS6hslHLEZ4Bxv.	\N		devnull-jb-lcviwjp84pzu6@localhost	t		Matrix UserA			system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1673966481028	0	0	en	{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	f		\N
hfby48bpd3r5je83kq15ocnyiy	1673969010778	1674210716257	0	matrix_user1.matrix	$2a$10$cILCyifI1hWTyIY6UorbK.qLyYflQLYoH1PD5DA8laLE9y1QRE/Ri	\N		devnull-6z9b6_whtsca8qia@localhost	t		User 1 - Matrix			system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1673969010778	0	0	en	{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	f		\N
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

