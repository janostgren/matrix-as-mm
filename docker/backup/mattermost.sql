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
    createat bigint,
    updateat bigint,
    deleteat bigint,
    lasticonupdate bigint
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
    username character varying(255),
    iconurl character varying(1024),
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
    token character varying(26) NOT NULL,
    refreshtoken character varying(26),
    redirecturi character varying(256),
    clientid character varying(26),
    userid character varying(26),
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
    callbackurls character varying(1024),
    homepage character varying(256),
    istrusted boolean,
    iconurl character varying(512),
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
    callbackurls character varying(1024),
    displayname character varying(64),
    contenttype character varying(128),
    triggerwhen integer,
    username character varying(64),
    iconurl character varying(1024),
    description character varying(500)
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
    deleteat bigint,
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
    editat bigint,
    ispinned boolean,
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
    props jsonb,
    expirednotify boolean
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
    schemeid character varying(26),
    allowopeninvite boolean,
    lastteamiconupdate bigint,
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
    roles character varying(256),
    allowmarketing boolean,
    props jsonb,
    notifyprops jsonb,
    lastpasswordupdate bigint,
    lastpictureupdate bigint,
    failedattempts integer,
    locale character varying(5),
    mfaactive boolean,
    mfasecret character varying(128),
    "position" character varying(128),
    timezone jsonb,
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
r3fpyhmo4bdhzgssef1yackcjh	1675285731721		/api/v4/users/login	attempt - login_id=admin	172.16.238.1	
u1imou1fg78efjct3u6qyykfic	1675285731748		/api/v4/users/login	failure - login_id=admin	172.16.238.1	
n3mxjru16bnudryqnocy1r3hqy	1675285739817		/api/v4/users/login	attempt - login_id=matrix.bridge	172.16.238.1	
pi3uonkjjtb9brj8ygdrub5g9r	1675285739826		/api/v4/users/login	failure - login_id=matrix.bridge	172.16.238.1	
659pqdbuginpdqn3e8knx58ubw	1675285775074	tkzqirh7h78opxqwk5a4bt3fkw	/api/v4/users/login	attempt - login_id=	172.16.238.1	
ouftpzpkjjdzbm4r4dsm5ahbhc	1675285775162	tkzqirh7h78opxqwk5a4bt3fkw	/api/v4/users/login	authenticated	172.16.238.1	
yhr8mtywaidj7eiaw3s1o9m79r	1675285775172	tkzqirh7h78opxqwk5a4bt3fkw	/api/v4/users/login	success session_user=tkzqirh7h78opxqwk5a4bt3fkw	172.16.238.1	4ir9z81c57fppdqnn9akmxjnto
6g3oy4yt17fp3xz18nmu8xq8jr	1675286114605	tkzqirh7h78opxqwk5a4bt3fkw	/api/v4/users/logout		172.16.238.1	4ir9z81c57fppdqnn9akmxjnto
3idjcrq7nf8hufoxegtog71t5w	1675286114850		/api/v4/users/logout		172.16.238.1	
smc1bbs3mif7znr6qp7fpiahia	1675286152573	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/login	attempt - login_id=	172.16.238.1	
5ussdoqsmfrp7pthsepggtcrxa	1675286152662	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/login	authenticated	172.16.238.1	
8bc4efwhafdu9yi3et3ahscsph	1675286152667	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/login	success session_user=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	bzyr8f6rcpd5fd3zjojys9ouse
pfkf17oqqfnpbre68koypokixy	1675286187979	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/logout		172.16.238.1	bzyr8f6rcpd5fd3zjojys9ouse
zk4ebrxtnpfktx8735z5nrchcc	1675286188049		/api/v4/users/logout		172.16.238.1	
bs8qbbsr87gctek6opsgphzkaa	1675286199919		/api/v4/users/login	attempt - login_id=admin	172.16.238.1	
er5ni4qn63nideoehupo517faa	1675286200038	tkzqirh7h78opxqwk5a4bt3fkw	/api/v4/users/login	authenticated	172.16.238.1	
zs4jh8w5q7rfbp7dzkecnjq9zw	1675286200043	tkzqirh7h78opxqwk5a4bt3fkw	/api/v4/users/login	success session_user=tkzqirh7h78opxqwk5a4bt3fkw	172.16.238.1	y8oo71jm7jr7fegiixwenu688r
477g84dwi7bhufne3i5imq94mr	1675286258205	tkzqirh7h78opxqwk5a4bt3fkw	/api/v4/teams/jubozzh9wi8g9j33syw1b4tefo/patch		172.16.238.1	y8oo71jm7jr7fegiixwenu688r
cmganmtgs7bz7rk9ztdpo1tcwr	1675286350912	tkzqirh7h78opxqwk5a4bt3fkw	/api/v4/users/yp7iiitd1prkukea7ci1yeqo4h/roles	user=yp7iiitd1prkukea7ci1yeqo4h roles=system_user system_admin	172.16.238.1	y8oo71jm7jr7fegiixwenu688r
p9mf33wh97fytfgmqyt3spx58a	1675286387945	tkzqirh7h78opxqwk5a4bt3fkw	/api/v4/users/logout		172.16.238.1	y8oo71jm7jr7fegiixwenu688r
5bzi83qnqt83fci1mcpqmdd1ty	1675286388167		/api/v4/users/logout		172.16.238.1	
4gy4rsfm3j87xnp1p311gjdrnh	1675286410313		/api/v4/users/login	attempt - login_id=matrix.bridge	172.16.238.1	
hgd8if7x8b8fidg1gzigf7tqba	1675286410444	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/login	authenticated	172.16.238.1	
kk69y8ujubromjjc9ipu3aiuzc	1675286410449	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/login	success session_user=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	ipkj1iaax7yyff9jk9og86eeoh
jz7rqxpya78sjgfowm1kpwpmjr	1675286470301	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/yp7iiitd1prkukea7ci1yeqo4h/tokens		172.16.238.1	ipkj1iaax7yyff9jk9og86eeoh
kb9gm9xwmfypmrkx3qkjmc6n5o	1675286470311	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/yp7iiitd1prkukea7ci1yeqo4h/tokens	success - token_id=au1qubnd5pngmpus4pxx7wjqnh	172.16.238.1	ipkj1iaax7yyff9jk9og86eeoh
pf1tec9oztyrmjg59ca9isczor	1675287172417	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/6j47rggkup8xupunzj5dfxojih/members	name=off-topic user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
jyxq6i5c6by3pqgqkef65doooc	1675287172425	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/g593o5aooif69kt9xfdzsydu3y/members	name=town-square user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
smeyfisy9jbw3c9uuo7hakfxir	1675287995819	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/6j47rggkup8xupunzj5dfxojih/members	name=off-topic user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
h9qs855jwjb95qee8y1ywqt6io	1675287995826	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/g593o5aooif69kt9xfdzsydu3y/members	name=town-square user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
ga1e6qy8qp85fj151u9199ci3r	1675288909400	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/6j47rggkup8xupunzj5dfxojih/members	name=off-topic user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
dw1zymcpxig6pmajit4hny38yo	1675288909415	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/g593o5aooif69kt9xfdzsydu3y/members	name=town-square user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
nnxjudx65ino9yeusqczwt5jfy	1675288988169	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/6j47rggkup8xupunzj5dfxojih/members	name=off-topic user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
mza6pp7fa7ryzpzwfbjxjaeq8a	1675288988170	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/g593o5aooif69kt9xfdzsydu3y/members	name=town-square user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
sc5u8y1sfbbjumijiytxfw55er	1675794016345		/api/v4/users/logout		172.16.238.1	
ocwip4gk33yabqw6iq6kc7tm3c	1675794206855		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
aj43eujpu7yexboccwhyzmomac	1675794206886		/api/v4/users/login	failure - login_id=user1.mm	172.16.238.1	
j84sh9dwnjntupffgsgigegute	1675794259407	cjsqd673nbgzzybrrkmzxou34y	/api/v4/users/login	attempt - login_id=	172.16.238.1	
8ud6a3uqnigkpk3jpgq7di4f9w	1675794259515	cjsqd673nbgzzybrrkmzxou34y	/api/v4/users/login	authenticated	172.16.238.1	
q6xjnxqatfghmcq7j9zpbhr3wy	1675794259528	cjsqd673nbgzzybrrkmzxou34y	/api/v4/users/login	success session_user=cjsqd673nbgzzybrrkmzxou34y	172.16.238.1	magwjmmyg388bepg5j3qcb6rdr
cj4jgzaqjtdkx8w48xgh41mx6r	1675814024463	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/6j47rggkup8xupunzj5dfxojih/members	name=off-topic user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
qhq8j8rna3fnxd37kfjeuwf9bw	1675814024464	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/g593o5aooif69kt9xfdzsydu3y/members	name=town-square user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
sjoyb1ja47da5by5zc3o7mcwqw	1675814025124	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/pqzp7j96epnczy4icow41mnhpc/email/verify/member	user verified	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
6yc5x4opw7r48rwwotx3sec8sw	1675814025162	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/pqzp7j96epnczy4icow41mnhpc/tokens		172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
s85u8fwhjtyddrtjuawybxx3sh	1675814025427	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/pqzp7j96epnczy4icow41mnhpc/patch		172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
qya84x3pfb8dik5yhaxs85ix3e	1675814025180	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/pqzp7j96epnczy4icow41mnhpc/tokens	success - token_id=eewj7s96s3baib1k1y64bcckfo	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
6km4yatdx78td85a5cw91i3kha	1675814025464	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/6j47rggkup8xupunzj5dfxojih/members	name=off-topic user_id=pqzp7j96epnczy4icow41mnhpc	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
farq11hasfdxbnn9wf7d43t6ih	1675814025594	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/cjsqd673nbgzzybrrkmzxou34y/tokens		172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
egmtkdcwxb8jfm4jf84g6e4ggr	1675814025612	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/cjsqd673nbgzzybrrkmzxou34y/tokens	success - token_id=j58z4mccftfp3mrjq963y6byhw	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
tiipcs3173ghdr8j8sq5rbxuhh	1675877263374	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/6j47rggkup8xupunzj5dfxojih/members	name=off-topic user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
5pj9neg3ffy33rhamysbhkg8sc	1675877263378	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/g593o5aooif69kt9xfdzsydu3y/members	name=town-square user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
upaxafj553gtfkpaf8yh1embtc	1675877263955	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/pqzp7j96epnczy4icow41mnhpc/patch		172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
t8md78oos7rqdbynkq9tchjzho	1675877263959	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/pqzp7j96epnczy4icow41mnhpc/patch		172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
woyk7wujwtbt9kecbasnnp38ah	1675877263980	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/g593o5aooif69kt9xfdzsydu3y/members	name=town-square user_id=pqzp7j96epnczy4icow41mnhpc	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
cnu75i57ejyu9bg54dqpzz7tra	1675877263984	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/6j47rggkup8xupunzj5dfxojih/members	name=off-topic user_id=pqzp7j96epnczy4icow41mnhpc	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
pgmmgjcxm7nf9mrydui9kbbkiy	1675877280814		/api/v4/users/login	attempt - login_id=user1.mm session_user=cjsqd673nbgzzybrrkmzxou34y	172.16.238.1	magwjmmyg388bepg5j3qcb6rdr
pt8ut9ncx3rhpjf6tbyww7gter	1675877280946	cjsqd673nbgzzybrrkmzxou34y	/api/v4/users/login	authenticated session_user=cjsqd673nbgzzybrrkmzxou34y	172.16.238.1	magwjmmyg388bepg5j3qcb6rdr
kn6kbjwmhiyr8q76ykbea4pb4w	1675877280952	cjsqd673nbgzzybrrkmzxou34y	/api/v4/users/login	success session_user=cjsqd673nbgzzybrrkmzxou34y	172.16.238.1	pf63kmuxn787dbnppuupbpmmya
ubizmuqspfda8pgrkw8kqrogde	1675877556115	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/6j47rggkup8xupunzj5dfxojih/members	name=off-topic user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
s17u8y65z7gapfktkbo8rzooia	1675877556121	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/g593o5aooif69kt9xfdzsydu3y/members	name=town-square user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
mk1bg7a1qfyqirdpahjh4idmbo	1675877556457	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/pqzp7j96epnczy4icow41mnhpc/patch		172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
33zp5zmcb7fzb8f8nsry86fa5a	1675877556489	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/pqzp7j96epnczy4icow41mnhpc/patch		172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
74w899kbyjdz9mwaz4paj7sbsh	1675877556535	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/6j47rggkup8xupunzj5dfxojih/members	name=off-topic user_id=pqzp7j96epnczy4icow41mnhpc	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
ohgzjognwfgdjqsknh7thwexjr	1675877556546	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/g593o5aooif69kt9xfdzsydu3y/members	name=town-square user_id=pqzp7j96epnczy4icow41mnhpc	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
ez9xihiaobgkbnhozsr1zx3rra	1675877728312	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/6j47rggkup8xupunzj5dfxojih/members	name=off-topic user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
3nikr4rw17b7p8rxedtygekbxe	1675877728313	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/g593o5aooif69kt9xfdzsydu3y/members	name=town-square user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
1wxttcn5kfbsxy9h99hf3q64rh	1675877728673	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/pqzp7j96epnczy4icow41mnhpc/patch		172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
t7om3uyadpnbpqhk6x7fbn3xny	1675877728675	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/pqzp7j96epnczy4icow41mnhpc/patch		172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
bytztcxt3bn5ijj4mb8jekzyhh	1675877728713	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/g593o5aooif69kt9xfdzsydu3y/members	name=town-square user_id=pqzp7j96epnczy4icow41mnhpc	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
f7p1pc8dw3nqubpnppxpiow6ko	1675877728746	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/6j47rggkup8xupunzj5dfxojih/members	name=off-topic user_id=pqzp7j96epnczy4icow41mnhpc	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
xc63o5osf7fzidf4tkj7ujrxmw	1675877951457	cjsqd673nbgzzybrrkmzxou34y	/api/v4/users/logout		172.16.238.1	pf63kmuxn787dbnppuupbpmmya
55uebeczstn7dbrbmby7y9nksh	1675877956365		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
ct5gdj597p8tbrct6caw3rwztc	1675877956459	cjsqd673nbgzzybrrkmzxou34y	/api/v4/users/login	authenticated	172.16.238.1	
is8hbzay8fym9nhcpxfrcf7zhc	1675877956465	cjsqd673nbgzzybrrkmzxou34y	/api/v4/users/login	success session_user=cjsqd673nbgzzybrrkmzxou34y	172.16.238.1	5s7s15pti3fxzr97zchcp8gczo
1f98crd46bnepm59mm77w1hppe	1675878356303	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/6j47rggkup8xupunzj5dfxojih/members	name=off-topic user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
j1i7dhwhtifmbqg48k4qeixaur	1675878356310	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/g593o5aooif69kt9xfdzsydu3y/members	name=town-square user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
sfdombadnjysfdcrsieepqd6ny	1675878357014	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/pqzp7j96epnczy4icow41mnhpc/patch		172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
xe43ocmiiffwmgtogtuhrtqwja	1675878357030	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/6j47rggkup8xupunzj5dfxojih/members	name=off-topic user_id=pqzp7j96epnczy4icow41mnhpc	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
fk1g74fgqbd3bm8brftxecoczc	1675878357024	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/pqzp7j96epnczy4icow41mnhpc/patch		172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
p7yn3xen63yfmxheq17cm5iizr	1675878357063	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/g593o5aooif69kt9xfdzsydu3y/members	name=town-square user_id=pqzp7j96epnczy4icow41mnhpc	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
mkjpe4fnq7f4tqbetxotd6jbty	1675879386427	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/g593o5aooif69kt9xfdzsydu3y/members	name=town-square user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
6bmt83kbijndjgtk65nfwpsd8a	1675879386444	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/6j47rggkup8xupunzj5dfxojih/members	name=off-topic user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
y17aso91sife5kob57zufq7eta	1675879387161	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/pqzp7j96epnczy4icow41mnhpc/patch		172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
wq68m8qjqir1upyqze8p94h7io	1675879387170	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/pqzp7j96epnczy4icow41mnhpc/patch		172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
tjy1q9obgbyazc6didojz1inme	1675879387219	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/6j47rggkup8xupunzj5dfxojih/members	name=off-topic user_id=pqzp7j96epnczy4icow41mnhpc	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
retpycf1s3rndjpnge3uouthgw	1675879697346	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/6j47rggkup8xupunzj5dfxojih/members	name=off-topic user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
h49xpodn8byffbyong41bz4y7h	1675879697841	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/pqzp7j96epnczy4icow41mnhpc/patch		172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
99kks5k5qpnzif5yza8cz7fa3y	1675879697905	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/6j47rggkup8xupunzj5dfxojih/members	name=off-topic user_id=pqzp7j96epnczy4icow41mnhpc	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
cbj78o917jf78j3wmyq15oh5ie	1675879780271	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/6j47rggkup8xupunzj5dfxojih/members	name=off-topic user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
btpsoicyitn4m8toie1hpc9wma	1675879780677	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/pqzp7j96epnczy4icow41mnhpc/patch		172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
6ii3k59imtbypjr96wuk3uyuye	1675880501763	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/6j47rggkup8xupunzj5dfxojih/members	name=off-topic user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
m77c7xq4jin8zdtrza5h6tk9kc	1675880502279	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/pqzp7j96epnczy4icow41mnhpc/patch		172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
j6eye9zcbidox8wsg7ydp7fmkw	1675880502323	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/g593o5aooif69kt9xfdzsydu3y/members	name=town-square user_id=pqzp7j96epnczy4icow41mnhpc	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
8pcusz6d8ffqzqztsdn7hs5wuo	1675880655874	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/g593o5aooif69kt9xfdzsydu3y/members	name=town-square user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
nk9ab9q9qf8mjkqjteoh9z6f9o	1675880656291	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/pqzp7j96epnczy4icow41mnhpc/patch		172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
51zscjx78jgaddywic51gs5a8c	1675880656342	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/6j47rggkup8xupunzj5dfxojih/members	name=off-topic user_id=pqzp7j96epnczy4icow41mnhpc	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
sfu715dar3dytj6fg7m4h1oe3e	1675879387239	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/g593o5aooif69kt9xfdzsydu3y/members	name=town-square user_id=pqzp7j96epnczy4icow41mnhpc	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
nobckxo6w78uxnjgjcngwc59zr	1675879697341	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/g593o5aooif69kt9xfdzsydu3y/members	name=town-square user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
x63kfigggjrnfjiji35k7fn69a	1675879697867	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/pqzp7j96epnczy4icow41mnhpc/patch		172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
ax1pjkh6wid9tguzadfihopudc	1675879697908	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/g593o5aooif69kt9xfdzsydu3y/members	name=town-square user_id=pqzp7j96epnczy4icow41mnhpc	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
ayg1yyujepdk5crbugaudiobsw	1675879780272	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/g593o5aooif69kt9xfdzsydu3y/members	name=town-square user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
thkmm4ipr3fpumd9qnx13hxyih	1675879780630	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/pqzp7j96epnczy4icow41mnhpc/patch		172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
qwefphspjtfe3dz73k3mr7z8jr	1675879780689	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/6j47rggkup8xupunzj5dfxojih/members	name=off-topic user_id=pqzp7j96epnczy4icow41mnhpc	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
yex3qyj37tb6pnzo8tdqknj3ba	1675879780742	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/g593o5aooif69kt9xfdzsydu3y/members	name=town-square user_id=pqzp7j96epnczy4icow41mnhpc	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
dn3gdebcc3yqtfrdox7zsqnb9w	1675880227398	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/6j47rggkup8xupunzj5dfxojih/members	name=off-topic user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
6im8qdh697gjf8948fexpkq9oc	1675880227412	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/g593o5aooif69kt9xfdzsydu3y/members	name=town-square user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
4xiyz3515pynmju9tww9cc5seo	1675880227794	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/pqzp7j96epnczy4icow41mnhpc/patch		172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
8cms9x6uctyidfopt9q4seug4o	1675880227894	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/pqzp7j96epnczy4icow41mnhpc/patch		172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
jo944gcra3gsune789upckn1co	1675880227909	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/g593o5aooif69kt9xfdzsydu3y/members	name=town-square user_id=pqzp7j96epnczy4icow41mnhpc	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
cyj79morfb8dxmrknrok6ago3y	1675880227961	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/6j47rggkup8xupunzj5dfxojih/members	name=off-topic user_id=pqzp7j96epnczy4icow41mnhpc	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
8axtf35bwfgniez838e1i6jcua	1675880501752	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/g593o5aooif69kt9xfdzsydu3y/members	name=town-square user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
eswcwt77kjdrix4q9hhd1uzair	1675880502279	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/pqzp7j96epnczy4icow41mnhpc/patch		172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
hhanioowdpd3ixwbag41fhf88w	1675880502320	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/6j47rggkup8xupunzj5dfxojih/members	name=off-topic user_id=pqzp7j96epnczy4icow41mnhpc	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
dgqyggbuo7rq3r3nop6xx584my	1675880655877	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/6j47rggkup8xupunzj5dfxojih/members	name=off-topic user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
mrc6jbc443g6bc9josfh33cr8h	1675880656296	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/pqzp7j96epnczy4icow41mnhpc/patch		172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
ju1e8rpsdpds9jrqswfybgbhkh	1675880656333	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/g593o5aooif69kt9xfdzsydu3y/members	name=town-square user_id=pqzp7j96epnczy4icow41mnhpc	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
ka5tnawn8fgfmbkm58ybujxeco	1675880965219	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/6j47rggkup8xupunzj5dfxojih/members	name=off-topic user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
76fdjbadt3rtzm4r7mbdtw795h	1675880965234	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/g593o5aooif69kt9xfdzsydu3y/members	name=town-square user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
cpy4mxfcxprmbqu3ak4tk3u3je	1675880965752	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/pqzp7j96epnczy4icow41mnhpc/patch		172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
ucuobkbjjigpupg1doozpattfy	1675880965874	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/pqzp7j96epnczy4icow41mnhpc/patch		172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
ufy8ect9xjfg8dadz4se3m6e6h	1675880965915	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/g593o5aooif69kt9xfdzsydu3y/members	name=town-square user_id=pqzp7j96epnczy4icow41mnhpc	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
dn95n6j9c3d37fsgti7tsrxayh	1675880965938	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/6j47rggkup8xupunzj5dfxojih/members	name=off-topic user_id=pqzp7j96epnczy4icow41mnhpc	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
1ripjbomkiffzrig3sousf7opy	1675881596532	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/6j47rggkup8xupunzj5dfxojih/members	name=off-topic user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
gwe4ygc36jd9ikhdfqj8nmbx7e	1675881596535	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/g593o5aooif69kt9xfdzsydu3y/members	name=town-square user_id=yp7iiitd1prkukea7ci1yeqo4h	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
75uu93gxqifajqx4i3yndha49o	1675881821148	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/pqzp7j96epnczy4icow41mnhpc/patch		172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
h646tanhd7fedkhji6bqpsweyw	1675881821170	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/users/pqzp7j96epnczy4icow41mnhpc/patch		172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
hoyhdjcma7g3jxqsgsafm9iqae	1675881821200	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/g593o5aooif69kt9xfdzsydu3y/members	name=town-square user_id=pqzp7j96epnczy4icow41mnhpc	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
ik7hb9447id45bow95xqms8ady	1675881821217	yp7iiitd1prkukea7ci1yeqo4h	/api/v4/channels/6j47rggkup8xupunzj5dfxojih/members	name=off-topic user_id=pqzp7j96epnczy4icow41mnhpc	172.16.238.1	mox6yuw8e7gyj8wmfut1s91nty
\.


--
-- Data for Name: bots; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.bots (userid, description, ownerid, createat, updateat, deleteat, lasticonupdate) FROM stdin;
tftaugsmmpygxgik3w48nybfdc	Mattermost Apps Registry and API proxy.	com.mattermost.apps	1675285308183	1675285308183	0	0
sqf1gfpbu7ngpgzbcqt93p87ro	Playbooks bot.	playbooks	1675285308631	1675285308631	0	0
x3wbz7kwnif3tj751sffqtpuuy	Created by Boards plugin.	focalboard	1675285310436	1675285310436	0	0
x8ummu1bgtnstcy1j78c75ozsa		tkzqirh7h78opxqwk5a4bt3fkw	1675285799662	1675285799662	0	0
\.


--
-- Data for Name: channelmemberhistory; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.channelmemberhistory (channelid, userid, jointime, leavetime) FROM stdin;
g593o5aooif69kt9xfdzsydu3y	tkzqirh7h78opxqwk5a4bt3fkw	1675285819391	\N
6j47rggkup8xupunzj5dfxojih	tkzqirh7h78opxqwk5a4bt3fkw	1675285819498	\N
g593o5aooif69kt9xfdzsydu3y	yp7iiitd1prkukea7ci1yeqo4h	1675286415659	\N
6j47rggkup8xupunzj5dfxojih	yp7iiitd1prkukea7ci1yeqo4h	1675286415704	\N
g593o5aooif69kt9xfdzsydu3y	yp7iiitd1prkukea7ci1yeqo4h	1675287027088	\N
6j47rggkup8xupunzj5dfxojih	yp7iiitd1prkukea7ci1yeqo4h	1675287027114	\N
13kiq1kuy3du3nfdc4wpddte1h	yp7iiitd1prkukea7ci1yeqo4h	1675288445735	\N
g593o5aooif69kt9xfdzsydu3y	cjsqd673nbgzzybrrkmzxou34y	1675794260358	\N
6j47rggkup8xupunzj5dfxojih	cjsqd673nbgzzybrrkmzxou34y	1675794260394	\N
6j47rggkup8xupunzj5dfxojih	pqzp7j96epnczy4icow41mnhpc	1675814025461	\N
g593o5aooif69kt9xfdzsydu3y	pqzp7j96epnczy4icow41mnhpc	1675814025518	\N
6j47rggkup8xupunzj5dfxojih	pqzp7j96epnczy4icow41mnhpc	1675814025681	\N
\.


--
-- Data for Name: channelmembers; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.channelmembers (channelid, userid, roles, lastviewedat, msgcount, mentioncount, notifyprops, lastupdateat, schemeuser, schemeadmin, schemeguest, mentioncountroot, msgcountroot) FROM stdin;
6j47rggkup8xupunzj5dfxojih	tkzqirh7h78opxqwk5a4bt3fkw		1675285819504	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1675285819504	t	t	f	0	0
g593o5aooif69kt9xfdzsydu3y	tkzqirh7h78opxqwk5a4bt3fkw		1675285819432	1	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1675285819432	t	t	f	0	1
g593o5aooif69kt9xfdzsydu3y	yp7iiitd1prkukea7ci1yeqo4h		1675287027090	1	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1675287027090	t	f	f	0	1
13kiq1kuy3du3nfdc4wpddte1h	yp7iiitd1prkukea7ci1yeqo4h		0	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	0	t	f	f	0	0
6j47rggkup8xupunzj5dfxojih	yp7iiitd1prkukea7ci1yeqo4h		1675287027121	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1675287027121	t	f	f	0	0
g593o5aooif69kt9xfdzsydu3y	pqzp7j96epnczy4icow41mnhpc		0	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1675814025459	t	f	f	0	0
6j47rggkup8xupunzj5dfxojih	pqzp7j96epnczy4icow41mnhpc		1675878048989	8	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1675878048989	t	f	f	0	8
g593o5aooif69kt9xfdzsydu3y	cjsqd673nbgzzybrrkmzxou34y		1675877966817	2	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1675877966817	t	f	f	0	2
6j47rggkup8xupunzj5dfxojih	cjsqd673nbgzzybrrkmzxou34y		1675878385137	9	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1675878385137	t	f	f	0	9
\.


--
-- Data for Name: channels; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.channels (id, createat, updateat, deleteat, teamid, type, displayname, name, header, purpose, lastpostat, totalmsgcount, extraupdateat, creatorid, schemeid, groupconstrained, shared, totalmsgcountroot, lastrootpostat) FROM stdin;
13kiq1kuy3du3nfdc4wpddte1h	1675288445726	1675288445726	0		D		yp7iiitd1prkukea7ci1yeqo4h__yp7iiitd1prkukea7ci1yeqo4h			0	0	0	yp7iiitd1prkukea7ci1yeqo4h	\N	\N	f	0	0
g593o5aooif69kt9xfdzsydu3y	1675285819309	1675285819309	0	jubozzh9wi8g9j33syw1b4tefo	O	Town Square	town-square			1675877966817	2	0		\N	\N	\N	2	1675877966817
6j47rggkup8xupunzj5dfxojih	1675285819328	1675285819328	0	jubozzh9wi8g9j33syw1b4tefo	O	Off-Topic	off-topic			1675878385137	9	0		\N	\N	\N	9	1675878385137
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
qwapdibndiyjpbkcg16wopcria	cjsqd673nbgzzybrrkmzxou34y	aog3bs786pdn8jc6g88wwmtbnw	1675877304989	1675877304989	0	20230208/teams/noteam/channels/6j47rggkup8xupunzj5dfxojih/users/cjsqd673nbgzzybrrkmzxou34y/qwapdibndiyjpbkcg16wopcria/contribute.json			contribute.json	json	435	application/json	0	0	f	\N	{\n    "name": "Element",\n    "description": "A glossy Matrix collaboration client for the web.",\n    "repository": {\n        "url": "https://github.com/vector-im/element-web",\n        "license": "Apache License 2.0"\n    },\n    "bugs": {\n        "list": "https://github.com/vector-im/element-web/issues",\n        "report": "https://github.com/vector-im/element-web/issues/new/choose"\n    },\n    "keywords": ["chat", "riot", "matrix"]\n}\n		f
ehkxaekorbrhdqwjex8q6t3dmr	cjsqd673nbgzzybrrkmzxou34y	rbiq8w89g3yntbri9kfw9m5niy	1675877831004	1675877831004	0	20230208/teams/noteam/channels/6j47rggkup8xupunzj5dfxojih/users/cjsqd673nbgzzybrrkmzxou34y/ehkxaekorbrhdqwjex8q6t3dmr/CONTRIBUTING.md			CONTRIBUTING.md	md	12636		0	0	f	\N	# Contributing code to Element Web\n\nEveryone is welcome to contribute code to Element Web, provided that they are\nwilling to license their contributions under the same license as the project\nitself. We follow a simple 'inbound=outbound' model for contributions: the act\nof submitting an 'inbound' contribution means that the contributor agrees to\nlicense the code under the same terms as the project's overall 'outbound'\nlicense - in this case, Apache Software License v2 (see\n[LICENSE](LICENSE)).\n\n## How to contribute\n\nThe preferred and easiest way to contribute changes to the project is to fork\nit on github, and then create a pull request to ask us to pull your changes\ninto our repo (https://help.github.com/articles/using-pull-requests/)\n\nWe use GitHub's pull request workflow to review the contribution, and either\nask you to make any refinements needed or merge it and make them ourselves.\n\nThings that should go into your PR description:\n\n-   A changelog entry in the `Notes` section (see below)\n-   References to any bugs fixed by the change (in GitHub's `Fixes` notation)\n-   Describe the why and what is changing in the PR description so it's easy for\n    onlookers and reviewers to onboard and context switch. This information is\n    also helpful when we come back to look at this in 6 months and ask "why did\n    we do it like that?" we have a chance of finding out.\n    -   Why didn't it work before? Why does it work now? What use cases does it\n        unlock?\n    -   If you find yourself adding information on how the code works or why you\n        chose to do it the way you did, make sure this information is instead\n        written as comments in the code itself.\n    -   Sometimes a PR can change considerably as it is developed. In this case,\n        the description should be updated to reflect the most recent state of\n        the PR. (It can be helpful to retain the old content under a suitable\n        heading, for additional context.)\n-   Include both **before** and **after** screenshots to easily compare and discuss\n    what's changing.\n-   Include a step-by-step testing strategy so that a reviewer can check out the\n    code locally and easily get to the point of testing your change.\n-   Add comments to the diff for the reviewer that might help them to understand\n    why the change is necessary or how they might better understand and review it.\n\nWe rely on information in pull request to populate the information that goes into\nthe changelogs our users see, both for Element Web itself and other projects on\nwhich it is based. This is picked up from both labels on the pull request and\nthe `Notes:` annotation in the description. By default, the PR title will be\nused for the changelog entry, but you can specify more options, as follows.\n\nTo add a longer, more detailed description of the change for the changelog:\n\n_Fix llama herding bug_\n\n```\nNotes: Fix a bug (https://github.com/matrix-org/notaproject/issues/123) where the 'Herd' button would not herd more than 8 Llamas if the moon was in the waxing gibbous phase\n```\n\nFor some PRs, it's not useful to have an entry in the user-facing changelog (this is\nthe default for PRs labelled with `T-Task`):\n\n_Remove outdated comment from `Ungulates.ts`_\n\n```\nNotes: none\n```\n\nSometimes, you're fixing a bug in a downstream project, in which case you want\nan entry in that project's changelog. You can do that too:\n\n_Fix another herding bug_\n\n```\nNotes: Fix a bug where the `herd()` function would only work on Tuesdays\nelement-web notes: Fix a bug where the 'Herd' button only worked on Tuesdays\n```\n\nThis example is for Element Web. You can specify:\n\n-   matrix-react-sdk\n-   element-web\n-   element-desktop\n\nIf your PR introduces a breaking change, use the `Notes` section in the same\nway, additionally adding the `X-Breaking-Change` label (see below). There's no need\nto specify in the notes that it's a breaking change - this will be added\nautomatically based on the label - but remember to tell the developer how to\nmigrate:\n\n_Remove legacy class_\n\n```\nNotes: Remove legacy `Camelopard` class. `Giraffe` should be used instead.\n```\n\nOther metadata can be added using labels.\n\n-   `X-Breaking-Change`: A breaking change - adding this label will mean the change causes a _major_ version bump.\n-   `T-Enhancement`: A new feature - adding this label will mean the change causes a _minor_ version bump.\n-   `T-Defect`: A bug fix (in either code or docs).\n-   `T-Task`: No user-facing changes, eg. code comments, CI fixes, refactors or tests. Won't have a changelog entry unless you specify one.\n\nIf you don't have permission to add labels, your PR reviewer(s) can work with you\nto add them: ask in the PR description or comments.\n\nWe use continuous integration, and all pull requests get automatically tested:\nif your change breaks the build, then the PR will show that there are failed\nchecks, so please check back after a few minutes.\n\n## Tests\n\nYour PR should include tests.\n\nFor new user facing features in `matrix-js-sdk`, `matrix-react-sdk` or `element-web`, you\nmust include:\n\n1. Comprehensive unit tests written in Jest. These are located in `/test`.\n2. "happy path" end-to-end tests.\n   These are located in `/cypress/e2e` in `matrix-react-sdk`, and\n   are run using `element-web`. Ideally, you would also include tests for edge\n   and error cases.\n\nUnit tests are expected even when the feature is in labs. It's good practice\nto write tests alongside the code as it ensures the code is testable from\nthe start, and gives you a fast feedback loop while you're developing the\nfunctionality. End-to-end tests should be added prior to the feature\nleaving labs, but don't have to be present from the start (although it might\nbe beneficial to have some running early, so you can test things faster).\n\nFor bugs in those repos, your change must include at least one unit test or\nend-to-end test; which is best depends on what sort of test most concisely\nexercises the area.\n\nChanges to must be accompanied by unit tests written in Jest.\nThese are located in `/spec/` in `matrix-js-sdk` or `/test/` in `element-web`\nand `matrix-react-sdk`.\n\nWhen writing unit tests, please aim for a high level of test coverage\nfor new code - 80% or greater. If you cannot achieve that, please document\nwhy it's not possible in your PR.\n\nSome sections of code are not sensible to add coverage for, such as those\nwhich explicitly inhibit noisy logging for tests. Which can be hidden using\nan istanbul magic comment as [documented here][1]. See example:\n\n```javascript\n/* istanbul ignore if */\nif (process.env.NODE_ENV !== "test") {\n    logger.error("Log line that is noisy enough in tests to want to skip");\n}\n```\n\nTests validate that your change works as intended and also document\nconcisely what is being changed. Ideally, your new tests fail\nprior to your change, and succeed once it has been applied. You may\nfind this simpler to achieve if you write the tests first.\n\nIf you're spiking some code that's experimental and not being used to support\nproduction features, exceptions can be made to requirements for tests.\nNote that tests will still be required in order to ship the feature, and it's\nstrongly encouraged to think about tests early in the process, as adding\ntests later will become progressively more difficult.\n\nIf you're not sure how to approach writing tests for your change, ask for help\nin [#element-dev](https://matrix.to/#/#element-dev:matrix.org).\n\n## Code style\n\nElement Web aims to target TypeScript/ES6. All new files should be written in\nTypeScript and existing files should use ES6 principles where possible.\n\nMembers should not be exported as a default export in general - it causes problems\nwith the architecture of the SDK (index file becomes less clear) and could\nintroduce naming problems (as default exports get aliased upon import). In\ngeneral, avoid using `export default`.\n\nThe remaining code style is documented in [code_style.md](./code_style.md).\nContributors are encouraged to it and follow the principles set out there.\n\nPlease ensure your changes match the cosmetic style of the existing project,\nand **_never_** mix cosmetic and functional changes in the same commit, as it\nmakes it horribly hard to review otherwise.\n\n## Attribution\n\nEveryone who contributes anything to Matrix is welcome to be listed in the\nAUTHORS.rst file for the project in question. Please feel free to include a\nchange to AUTHORS.rst in your pull request to list yourself and a short\ndescription of the area(s) you've worked on. Also, we sometimes have swag to\ngive away to contributors - if you feel that Matrix-branded apparel is missing\nfrom your life, please mail us your shipping address to matrix at matrix.org\nand we'll try to fix it :)\n\n## Sign off\n\nIn order to have a concrete record that your contribution is intentional\nand you agree to license it under the same terms as the project's license, we've\nadopted the same lightweight approach that the Linux Kernel\n(https://www.kernel.org/doc/Documentation/SubmittingPatches), Docker\n(https://github.com/docker/docker/blob/master/CONTRIBUTING.md), and many other\nprojects use: the DCO (Developer Certificate of Origin:\nhttp://developercertificate.org/). This is a simple declaration that you wrote\nthe contribution or otherwise have the right to contribute it to Matrix:\n\n```\nDeveloper Certificate of Origin\nVersion 1.1\n\nCopyright (C) 2004, 2006 The Linux Foundation and its contributors.\n660 York Street, Suite 102,\nSan Francisco, CA 94110 USA\n\nEveryone is permitted to copy and distribute verbatim copies of this\nlicense document, but changing it is not allowed.\n\nDeveloper's Certificate of Origin 1.1\n\nBy making a contribution to this project, I certify that:\n\n(a) The contribution was created in whole or in part by me and I\n    have the right to submit it under the open source license\n    indicated in the file; or\n\n(b) The contribution is based upon previous work that, to the best\n    of my knowledge, is covered under an appropriate open source\n    license and I have the right under that license to submit that\n    work with modifications, whether created in whole or in part\n    by me, under the same open source license (unless I am\n    permitted to submit under a different license), as indicated\n    in the file; or\n\n(c) The contribution was provided directly to me by some other\n    person who certified (a), (b) or (c) and I have not modified\n    it.\n\n(d) I understand and agree that this project and the contribution\n    are public and that a record of the contribution (including all\n    personal information I submit with it, including my sign-off) is\n    maintained indefinitely and may be redistributed consistent with\n    this project or the open source license(s) involved.\n```\n\nIf you agree to this for your contribution, then all that's needed is to\ninclude the line in your commit or pull request comment:\n\n```\nSigned-off-by: Your Name <your@email.example.org>\n```\n\nWe accept contributions under a legally identifiable name, such as your name on\ngovernment documentation or common-law names (names claimed by legitimate usage\nor repute). Unfortunately, we cannot accept anonymous contributions at this\ntime.\n\nGit allows you to add this signoff automatically when using the `-s` flag to\n`git commit`, which uses the name and email set in your `user.name` and\n`user.email` git configs.\n\nIf you forgot to sign off your commits before making your pull request and are\non Git 2.17+ you can mass signoff using rebase:\n\n```\ngit rebase --signoff origin/develop\n```\n\n# Review expectations\n\nSee https://github.com/vector-im/element-meta/wiki/Review-process\n\n# Merge Strategy\n\nThe preferred method for merging pull requests is squash merging to keep the\ncommit history trim, but it is up to the discretion of the team member merging\nthe change. We do not support rebase merges due to `allchange` being unable to\nhandle them. When merging make sure to leave the default commit title, or\nat least leave the PR number at the end in brackets like by default.\nWhen stacking pull requests, you may wish to do the following:\n\n1. Branch from develop to your branch (branch1), push commits onto it and open a pull request\n2. Branch from your base branch (branch1) to your work branch (branch2), push commits and open a pull request configuring the base to be branch1, saying in the description that it is based on your other PR.\n3. Merge the first PR using a merge commit otherwise your stacked PR will need a rebase. Github will automatically adjust the base branch of your other PR to be develop.\n\n[1]: https://github.com/gotwarlost/istanbul/blob/master/ignoring-code-for-coverage.md\n		f
\.


--
-- Data for Name: focalboard_blocks; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_blocks (id, insert_at, parent_id, schema, type, title, fields, create_at, update_at, delete_at, root_id, modified_by, channel_id, created_by, board_id) FROM stdin;
c3w9in6qnttf4zd3om9yf95upiy	2023-02-01 21:01:50.459085+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Team Schedule	{"contentOrder":["abgi5ubibkjgc9d3h3xp6dggajr","7pjcbsmde9pfa9cuw9dmsr7a4ae","ajtwjrtqdb7fh78ycbc1xwj9iwe","73zz8ydn5ytyafxb41e1yp4ruiy","7pdp7hehnjtn3zg8exs4cs56way","7h5hx6o6nyjnybcsxjy7henocyh"],"icon":"⏰","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"8b05c83e-a44a-4d04-831e-97f01d8e2003","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"34eb9c25-d5bf-49d9-859e-f74f4e0030e7"}}	1675285310477	1675285310477	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
c6nns8c31g78qdxujeg59e6tq1r	2023-02-01 21:01:50.459085+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Video production	{"contentOrder":["anrmt9tpccfbbfnpab78gdfaszy","7ghb3i7r9u38czfxx8fygumo9fy","aj6cr9kez5fyy7y94ir7zpj3zte","7r58bwmi8t3nymffyzp33ghaphc","7qizfhsa84idkt8a34n9ma713xh","7j8tssgdi77dqfydzbgep8y3tkr"],"icon":"📹","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"b1abafbf-a038-4a19-8b68-56e0fd2319f7","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"34eb9c25-d5bf-49d9-859e-f74f4e0030e7"}}	1675285310485	1675285310485	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
cqtdwsjfyqidntenab8sheq6n1e	2023-02-01 21:01:50.459085+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Offsite plans	{"contentOrder":["ajmjkrtn74fggpdsurg7acqfkhc","75uh4sj76h78ounfbofubq1u8qw","a1myhbpurwpdrdfac7c1c4wdr7e","7y8wf9mnpdtgs8qmgcbfpdiha4h","7416ahn46ojbzmkzzxnohf74okr","74wjudf3z33b9pp1hp8f5xm8sho"],"icon":"🚙","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"8b05c83e-a44a-4d04-831e-97f01d8e2003","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"dabadd9b-adf1-4d9f-8702-805ac6cef602"}}	1675285310493	1675285310493	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
crsbb63axmj8a7n4aasuqexad8c	2023-02-01 21:01:50.459085+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Social Media Strategy	{"contentOrder":["aenc74c6dcjnudcczwnno8nwg3y","7c4mihz1s838epf4gsqsths8tzw","a6fbr7myzu388txozueaa68kc8r","755goxmygabrci8f65acg1m3r6r","7hubpn69jztg9uqcntibh35jese","7iw9zf9xw4tfmtm7i5wraqdp5ir"],"icon":"🎉","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"b1abafbf-a038-4a19-8b68-56e0fd2319f7","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"d37a61f4-f332-4db9-8b2d-5e0a91aa20ed"}}	1675285310505	1675285310505	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
v46981ps1m3rpzptrtooyz4zcka	2023-02-01 21:01:50.459085+00	b7wnw9awd4pnefryhq51apbzb4c	1	view	Discussion Items	{"cardOrder":["cjpkiya33qsagr4f9hrdwhgiajc"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"d777ba3b-8728-40d1-87a6-59406bbbbfb0","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[{"propertyId":"4cf1568d-530f-4028-8ffd-bdc65249187e","reversed":false}],"viewType":"board","visibleOptionIds":[],"visiblePropertyIds":["4cf1568d-530f-4028-8ffd-bdc65249187e"]}	1675285310514	1675285310514	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7pdp7hehnjtn3zg8exs4cs56way	2023-02-01 21:01:50.459085+00	c3w9in6qnttf4zd3om9yf95upiy	1	checkbox		{"value":false}	1675285310521	1675285310521	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
73zz8ydn5ytyafxb41e1yp4ruiy	2023-02-01 21:01:50.459085+00	c3w9in6qnttf4zd3om9yf95upiy	1	checkbox		{"value":false}	1675285310526	1675285310526	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7pjcbsmde9pfa9cuw9dmsr7a4ae	2023-02-01 21:01:50.459085+00	c3w9in6qnttf4zd3om9yf95upiy	1	divider		{}	1675285310531	1675285310531	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7h5hx6o6nyjnybcsxjy7henocyh	2023-02-01 21:01:50.459085+00	c3w9in6qnttf4zd3om9yf95upiy	1	checkbox		{"value":false}	1675285310536	1675285310536	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
abgi5ubibkjgc9d3h3xp6dggajr	2023-02-01 21:01:50.459085+00	c3w9in6qnttf4zd3om9yf95upiy	1	text	## Notes\n*[Add meeting notes here]*	{}	1675285310542	1675285310542	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
ajtwjrtqdb7fh78ycbc1xwj9iwe	2023-02-01 21:01:50.459085+00	c3w9in6qnttf4zd3om9yf95upiy	1	text	## Action Items	{}	1675285310546	1675285310546	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7awn4m7bf7pfbiyj5x4otuoxhoe	2023-02-01 21:01:50.459085+00	ch798q5ucefyobf5bymgqjt4f3h	1	divider		{}	1675285310550	1675285310550	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7sexd4aa6opym3j3ohpkpsqmg4e	2023-02-01 21:01:50.459085+00	ch798q5ucefyobf5bymgqjt4f3h	1	checkbox		{"value":false}	1675285310556	1675285310556	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7sqbscdctkjdoxfysau1wzs5p6r	2023-02-01 21:01:50.459085+00	ch798q5ucefyobf5bymgqjt4f3h	1	checkbox		{"value":false}	1675285310560	1675285310560	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7b6ey5yxmdfbkmeugqtwzbrw8zc	2023-02-01 21:01:50.459085+00	ch798q5ucefyobf5bymgqjt4f3h	1	checkbox		{"value":false}	1675285310565	1675285310565	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
aof9obzh5wfy3tga7hrzqh75duw	2023-02-01 21:01:50.459085+00	ch798q5ucefyobf5bymgqjt4f3h	1	text	# Action Items	{}	1675285310571	1675285310571	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
ax7eu8owcgibdjyf89erbped5zy	2023-02-01 21:01:50.459085+00	ch798q5ucefyobf5bymgqjt4f3h	1	text	# Notes\n*[Add meeting notes here]*	{}	1675285310575	1675285310575	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7ghb3i7r9u38czfxx8fygumo9fy	2023-02-01 21:01:50.459085+00	c6nns8c31g78qdxujeg59e6tq1r	1	divider		{}	1675285310579	1675285310579	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7j8tssgdi77dqfydzbgep8y3tkr	2023-02-01 21:01:50.459085+00	c6nns8c31g78qdxujeg59e6tq1r	1	checkbox		{"value":false}	1675285310583	1675285310583	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7qizfhsa84idkt8a34n9ma713xh	2023-02-01 21:01:50.459085+00	c6nns8c31g78qdxujeg59e6tq1r	1	checkbox		{"value":false}	1675285310588	1675285310588	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7r58bwmi8t3nymffyzp33ghaphc	2023-02-01 21:01:50.459085+00	c6nns8c31g78qdxujeg59e6tq1r	1	checkbox		{"value":false}	1675285310592	1675285310592	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
aj6cr9kez5fyy7y94ir7zpj3zte	2023-02-01 21:01:50.459085+00	c6nns8c31g78qdxujeg59e6tq1r	1	text	## Action Items	{}	1675285310596	1675285310596	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
anrmt9tpccfbbfnpab78gdfaszy	2023-02-01 21:01:50.459085+00	c6nns8c31g78qdxujeg59e6tq1r	1	text	## Notes\n*[Add meeting notes here]*	{}	1675285310600	1675285310600	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7y8wf9mnpdtgs8qmgcbfpdiha4h	2023-02-01 21:01:50.459085+00	cqtdwsjfyqidntenab8sheq6n1e	1	checkbox		{"value":false}	1675285310605	1675285310605	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7416ahn46ojbzmkzzxnohf74okr	2023-02-01 21:01:50.459085+00	cqtdwsjfyqidntenab8sheq6n1e	1	checkbox		{"value":false}	1675285310609	1675285310609	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
75uh4sj76h78ounfbofubq1u8qw	2023-02-01 21:01:50.459085+00	cqtdwsjfyqidntenab8sheq6n1e	1	divider		{}	1675285310613	1675285310613	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
74wjudf3z33b9pp1hp8f5xm8sho	2023-02-01 21:01:50.459085+00	cqtdwsjfyqidntenab8sheq6n1e	1	checkbox		{"value":false}	1675285310618	1675285310618	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
a1myhbpurwpdrdfac7c1c4wdr7e	2023-02-01 21:01:50.459085+00	cqtdwsjfyqidntenab8sheq6n1e	1	text	## Action Items	{}	1675285310622	1675285310622	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
ajmjkrtn74fggpdsurg7acqfkhc	2023-02-01 21:01:50.459085+00	cqtdwsjfyqidntenab8sheq6n1e	1	text	## Notes\n*[Add meeting notes here]*	{}	1675285310627	1675285310627	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7c4mihz1s838epf4gsqsths8tzw	2023-02-01 21:01:50.459085+00	crsbb63axmj8a7n4aasuqexad8c	1	divider		{}	1675285310631	1675285310631	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7hubpn69jztg9uqcntibh35jese	2023-02-01 21:01:50.459085+00	crsbb63axmj8a7n4aasuqexad8c	1	checkbox		{"value":false}	1675285310636	1675285310636	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7iw9zf9xw4tfmtm7i5wraqdp5ir	2023-02-01 21:01:50.459085+00	crsbb63axmj8a7n4aasuqexad8c	1	checkbox		{"value":false}	1675285310644	1675285310644	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
755goxmygabrci8f65acg1m3r6r	2023-02-01 21:01:50.459085+00	crsbb63axmj8a7n4aasuqexad8c	1	checkbox		{"value":false}	1675285310651	1675285310651	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
a6fbr7myzu388txozueaa68kc8r	2023-02-01 21:01:50.459085+00	crsbb63axmj8a7n4aasuqexad8c	1	text	## Action Items	{}	1675285310657	1675285310657	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
aenc74c6dcjnudcczwnno8nwg3y	2023-02-01 21:01:50.459085+00	crsbb63axmj8a7n4aasuqexad8c	1	text	## Notes\n*[Add meeting notes here]*	{}	1675285310665	1675285310665	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
vcszbudnt8j817qt866jqnfw7wo	2023-02-01 21:01:51.066397+00		1	view	All Contacts	{"cardOrder":["c77bhbr3hg7yctnz3ngujq668yr","c1c5sshrud7yd3dn3cu1h9k7u5c","ch78mkjmgspytfexiypm3cxgc9w","c3w9hjx9oi3nwxx8aprz3kib4sr","cashp9xzkuj8q8yd59jsq4uthgo"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":240,"a1438fbbhjeffkexmcfhnx99o1h":151,"a5hwxjsmkn6bak6r7uea5bx1kwc":132,"abru6tz8uebdxy4skheqidh7zxy":247,"adtf1151chornmihz4xbgbk9exa":125,"aejo5tcmq54bauuueem9wc4fw4y":127,"ahf43e44h3y8ftanqgzno9z7q7w":129,"ainpw47babwkpyj77ic4b9zq9xr":157,"amahgyn9n4twaapg3jyxb6y4jic":224,"amba7ot98fh7hwsx8jdcfst5g7h":171,"aoheuj1f3mu6eehygr45fxa144y":130,"auhf91pm85f73swwidi4wid8jqe":157},"defaultTemplateId":"cxjt7qpo143rpmpiuni8rpbzoww","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a5hwxjsmkn6bak6r7uea5bx1kwc","aoheuj1f3mu6eehygr45fxa144y","aro91wme9kfaie5ceu9qasmtcnw","ainpw47babwkpyj77ic4b9zq9xr","ahf43e44h3y8ftanqgzno9z7q7w","amahgyn9n4twaapg3jyxb6y4jic","abru6tz8uebdxy4skheqidh7zxy","a1438fbbhjeffkexmcfhnx99o1h","auhf91pm85f73swwidi4wid8jqe","adtf1151chornmihz4xbgbk9exa","aejo5tcmq54bauuueem9wc4fw4y","amba7ot98fh7hwsx8jdcfst5g7h"]}	1675285311084	1675285311084	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
vamocn3756jfpmfkfa6n6hc4mhc	2023-02-01 21:01:51.066397+00		1	view	Pipeline Tracker	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["akj61wc9yxdwyw3t6m8igyf9d5o","aic89a5xox4wbppi6mbyx6ujsda","ah6ehh43rwj88jy4awensin8pcw","aprhd96zwi34o9cs4xyr3o9sf3c","axesd74yuxtbmw1sbk8ufax7z3a","a5txuiubumsmrs8gsd5jz5gc1oa","acm9q494bcthyoqzmfogxxy5czy"],"visiblePropertyIds":["aro91wme9kfaie5ceu9qasmtcnw","amahgyn9n4twaapg3jyxb6y4jic"]}	1675285311101	1675285311101	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
c3w9hjx9oi3nwxx8aprz3kib4sr	2023-02-01 21:01:51.066397+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Jonathan Frazier	{"contentOrder":["aheseum5hgi81xnjsx1rr4ujp7r","aw7adgosz8tnc9kesobpquie57h","7ax1sfm116fgd5byp888tk7gmye","7dbgrr3e937fk8rx5m9yyi8bh8y","77u4hw9b3jtbtjdscb6rnwk3dpa","77urwwied7bfu8dagrqer1jkroc","7m6o7gam3u3dmjnr4kkkjdag7ac","7ma6he37s4bfr8qpkfb8swsxs7r","7mfqz6xyzatfp5d5bxzibcymgac","7hw5x8n9ijbrnigf3uyeu4e3ine","7cykhef57kpnd5p1qodpbc7sn9a","7mrphh66xmir48e9imr1za4ewie"],"icon":"🙎‍♂️","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(999) 123-5678","a5hwxjsmkn6bak6r7uea5bx1kwc":"a5txuiubumsmrs8gsd5jz5gc1oa","abru6tz8uebdxy4skheqidh7zxy":"jonathan.frazier@email.com","aejo5tcmq54bauuueem9wc4fw4y":"0%","ahf43e44h3y8ftanqgzno9z7q7w":"$800,000","ainpw47babwkpyj77ic4b9zq9xr":"Ositions Inc.","amahgyn9n4twaapg3jyxb6y4jic":"as5bk6afoaaa7caewe1zc391sce","aro91wme9kfaie5ceu9qasmtcnw":"apiswzj7uiwbh87z8dw8c6mturw","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1669118400000}"}}	1675285311112	1675285311112	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
ch78mkjmgspytfexiypm3cxgc9w	2023-02-01 21:01:51.066397+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Richard Guzman	{"contentOrder":["ag3dtq44c13r79nz3wiqmqn3niy","araiwz15n6bgnmji4yizn5yjzyw","71nijhn4kejf75nbiid16jaksba","7qrxdubrfrjfh3mcrtz84g978ee","7nwyz1i6qxigp5pxuyus6baxc7o","7chc7m1yy3t8x3x4qos5dpcm39h","7hpbiaowgmfdw5ckmwu85oc45ry","7uxn6w1ngiidwufxniw73yo9qur","75uwzow4hpt8ftqa9z9ncrsgu1a","7nhaizf7cqtgamgotyhcscq6utw","7yuiw4tzhcffw7j84xczthpshpo","7xk331tmi9iryf871pkxz14ohwh"],"icon":"👨‍💼","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(222) 123-1234","a5hwxjsmkn6bak6r7uea5bx1kwc":"axesd74yuxtbmw1sbk8ufax7z3a","abru6tz8uebdxy4skheqidh7zxy":"richard.guzman@email.com","adtf1151chornmihz4xbgbk9exa":"{\\"from\\":1681992000000}","aejo5tcmq54bauuueem9wc4fw4y":"80%","ahf43e44h3y8ftanqgzno9z7q7w":"$3,200,000","ainpw47babwkpyj77ic4b9zq9xr":"Afformance Ltd.","amahgyn9n4twaapg3jyxb6y4jic":"ar6t1ttcumgfuqugg5o4g4mzrza","aro91wme9kfaie5ceu9qasmtcnw":"apjnaggwixchfxwiatfh7ey7uno","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1667476800000}"}}	1675285311129	1675285311129	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
cashp9xzkuj8q8yd59jsq4uthgo	2023-02-01 21:01:51.066397+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Byron Cole	{"contentOrder":["akk9y84c7ptgxjn1co6zmmz7jth","ahzksjktg13ruixijzoi4wizz1a","7cxrg43e36bn55y3ijgze5ubrto","7gq86u41gnbghjqtnt7n5kr5gfo","7edtkotuj7tbs8ctsamym7ahqzr","7nh7kwadyif8gueu4ztef6szp1e","7qp1ug6yi7tbmffofugnpykxpca","7qtouhgkwmpdbif13t7wki3aajc","7tywz5j41qpgxjbi3dbqban3cpc","7i6x9gopwe3879khsiinxicfpzc","7jizdcdwxf3bn8fn6ot9ncxrgkc","7n46szddgcjy3bcz4fp7iagkdkc"],"icon":"🤵","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(333) 123-1234","a5hwxjsmkn6bak6r7uea5bx1kwc":"acm9q494bcthyoqzmfogxxy5czy","abru6tz8uebdxy4skheqidh7zxy":"byron.cole@email.com","adtf1151chornmihz4xbgbk9exa":"{\\"from\\":1667563200000}","aejo5tcmq54bauuueem9wc4fw4y":"100%","ahf43e44h3y8ftanqgzno9z7q7w":"$500,000","ainpw47babwkpyj77ic4b9zq9xr":"Helx Industries","amahgyn9n4twaapg3jyxb6y4jic":"aafwyza5iwdcwcyfyj6bp7emufw","aro91wme9kfaie5ceu9qasmtcnw":"apjnaggwixchfxwiatfh7ey7uno","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1667822400000}"}}	1675285311138	1675285311138	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7yuiw4tzhcffw7j84xczthpshpo	2023-02-01 21:01:51.066397+00	ch78mkjmgspytfexiypm3cxgc9w	1	checkbox	Hand-off to customer success	{}	1675285311245	1675285311245	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7nhaizf7cqtgamgotyhcscq6utw	2023-02-01 21:01:51.066397+00	ch78mkjmgspytfexiypm3cxgc9w	1	checkbox	Finalize contract	{}	1675285311250	1675285311250	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7xk331tmi9iryf871pkxz14ohwh	2023-02-01 21:01:51.066397+00	ch78mkjmgspytfexiypm3cxgc9w	1	checkbox	Post-sales follow up	{}	1675285311256	1675285311256	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
c1c5sshrud7yd3dn3cu1h9k7u5c	2023-02-01 21:01:51.066397+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Caitlyn Russel	{"contentOrder":["az5ken7xou7gsdxqd4884yca3ie","auu9n65xsfpgeiqu1huwie139oh","7cf8kwn5q378njp35nwwt958acy","7nfmna5o6utyumqgqqyyuj6n3wo","7hnk6qa3egbn9tprmeaizqutksc","7hugsyenjciywims3tyqotdx7no","7jmcnou6nxbfhbr3jckb5ff7eac","78s3my3a9h3yy7ny3nxadfpiqdc","7wqmcjdk783r4t8ubjpxee4864h","7a8z55np11tn67d5b1qyp1wfw7o","79ay794go13fs5dut48rcbnrxhw","7s6ipo4tadbfebyopz5dwg1nt4y"],"icon":"🧑‍💼","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(111) 123-1234","a5hwxjsmkn6bak6r7uea5bx1kwc":"ah6ehh43rwj88jy4awensin8pcw","abru6tz8uebdxy4skheqidh7zxy":"caitlyn.russel@email.com","adtf1151chornmihz4xbgbk9exa":"{\\"from\\":1689336000000}","aejo5tcmq54bauuueem9wc4fw4y":"20%","ahf43e44h3y8ftanqgzno9z7q7w":"$250,000","ainpw47babwkpyj77ic4b9zq9xr":"Liminary Corp.","amahgyn9n4twaapg3jyxb6y4jic":"aafwyza5iwdcwcyfyj6bp7emufw","aro91wme9kfaie5ceu9qasmtcnw":"apiswzj7uiwbh87z8dw8c6mturw","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1668168000000}"}}	1675285311143	1675285311143	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
cxjt7qpo143rpmpiuni8rpbzoww	2023-02-01 21:01:51.066397+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	New Prospect	{"contentOrder":["a4rfspspx1iy7xmkp9anbkdmrkw","ajk9xaiirm3ykbeego3jtczn5uo","7qhxxe5i8nffcfces8bx88igyay","79xiwfi64zb8rip4m93gftgyroc","7fqpdwc3xr7rctk7nairp1q67br","7a99pekjn4ffwfdut755fapg3ah","7y9kcbmyog78t3npc9exak13tao","7dmmxyed3tjd8ibygcj9hb9kapy","7zmkncnstrtdb8fradmognondww","76ishcfirrjgb9cyps4ujpiym5o","7mwwd9h3zdp8y7ehrpduyh1m1re","7k94p6adrofdqzgggkyimijc99w"],"icon":"👤","isTemplate":true,"properties":{"a5hwxjsmkn6bak6r7uea5bx1kwc":"akj61wc9yxdwyw3t6m8igyf9d5o"}}	1675285311149	1675285311149	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
c77bhbr3hg7yctnz3ngujq668yr	2023-02-01 21:01:51.066397+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Shelby Olson	{"contentOrder":["a839444fg7bdu9diontmswkmchy","akggx148oyprxdpwwwfipodjuio","7idhcin49oiy65y59m35xt7nwmc","7an7jxs1yg7f4dciw74tcrdmkny","7g38hyfc74fnqzysngkauemjmhr","7hg1cq9fqyj8ztrc1a56hr67g3a","7jijk4twacty53qehuqx6odfh4w","78ad9bc3kqp893xoeu5mwatdzcc","7r613e3xs5pg47fyfmzbn1a8iac","7ep6o89sqj7bfdyijnsg4rkiogy","7y8koixfbwpfc8dib6u8wqaernr","7ahtoyyb9d7rj8mwp3k64d4fupa"],"icon":"🙎‍♀️","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(111) 321-5678","a5hwxjsmkn6bak6r7uea5bx1kwc":"akj61wc9yxdwyw3t6m8igyf9d5o","abru6tz8uebdxy4skheqidh7zxy":"shelby.olson@email.com","ahf43e44h3y8ftanqgzno9z7q7w":"$30,000","ainpw47babwkpyj77ic4b9zq9xr":"Kadera Global","amahgyn9n4twaapg3jyxb6y4jic":"ar6t1ttcumgfuqugg5o4g4mzrza","aro91wme9kfaie5ceu9qasmtcnw":"auu9bfzqeuruyjwzzqgz7q8apuw","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1669291200000}"}}	1675285311155	1675285311155	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
vmr8u7dsbzibbmfneugjngcsber	2023-02-01 21:01:51.066397+00	bzwb99zf498tsm7mjqbiy7g81ze	1	view	Open Deals	{"cardOrder":["c1c5sshrud7yd3dn3cu1h9k7u5c"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[{"condition":"includes","propertyId":"a5hwxjsmkn6bak6r7uea5bx1kwc","values":["akj61wc9yxdwyw3t6m8igyf9d5o","aic89a5xox4wbppi6mbyx6ujsda","ah6ehh43rwj88jy4awensin8pcw","aprhd96zwi34o9cs4xyr3o9sf3c","axesd74yuxtbmw1sbk8ufax7z3a"]}],"operation":"and"},"groupById":"aro91wme9kfaie5ceu9qasmtcnw","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["apjnaggwixchfxwiatfh7ey7uno","apiswzj7uiwbh87z8dw8c6mturw","auu9bfzqeuruyjwzzqgz7q8apuw",""],"visiblePropertyIds":[]}	1675285311160	1675285311160	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7ax1sfm116fgd5byp888tk7gmye	2023-02-01 21:01:51.066397+00	c3w9hjx9oi3nwxx8aprz3kib4sr	1	checkbox	Send initial email	{"value":true}	1675285311166	1675285311166	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7dbgrr3e937fk8rx5m9yyi8bh8y	2023-02-01 21:01:51.066397+00	c3w9hjx9oi3nwxx8aprz3kib4sr	1	checkbox	Send follow-up email	{"value":true}	1675285311172	1675285311172	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7mfqz6xyzatfp5d5bxzibcymgac	2023-02-01 21:01:51.066397+00	c3w9hjx9oi3nwxx8aprz3kib4sr	1	checkbox	Send proposal	{"value":true}	1675285311178	1675285311178	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7hw5x8n9ijbrnigf3uyeu4e3ine	2023-02-01 21:01:51.066397+00	c3w9hjx9oi3nwxx8aprz3kib4sr	1	checkbox	Finalize contract	{}	1675285311182	1675285311182	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
77u4hw9b3jtbtjdscb6rnwk3dpa	2023-02-01 21:01:51.066397+00	c3w9hjx9oi3nwxx8aprz3kib4sr	1	checkbox	Schedule initial sales call	{"value":true}	1675285311186	1675285311186	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7m6o7gam3u3dmjnr4kkkjdag7ac	2023-02-01 21:01:51.066397+00	c3w9hjx9oi3nwxx8aprz3kib4sr	1	checkbox	Schedule demo	{"value":true}	1675285311190	1675285311190	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7cykhef57kpnd5p1qodpbc7sn9a	2023-02-01 21:01:51.066397+00	c3w9hjx9oi3nwxx8aprz3kib4sr	1	checkbox	Hand-off to customer success	{}	1675285311194	1675285311194	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7ma6he37s4bfr8qpkfb8swsxs7r	2023-02-01 21:01:51.066397+00	c3w9hjx9oi3nwxx8aprz3kib4sr	1	checkbox	Follow up after demo	{"value":true}	1675285311198	1675285311198	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
77urwwied7bfu8dagrqer1jkroc	2023-02-01 21:01:51.066397+00	c3w9hjx9oi3nwxx8aprz3kib4sr	1	checkbox	Schedule follow-up sales call	{"value":true}	1675285311203	1675285311203	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7mrphh66xmir48e9imr1za4ewie	2023-02-01 21:01:51.066397+00	c3w9hjx9oi3nwxx8aprz3kib4sr	1	checkbox	Post-sales follow up	{}	1675285311208	1675285311208	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
aw7adgosz8tnc9kesobpquie57h	2023-02-01 21:01:51.066397+00	c3w9hjx9oi3nwxx8aprz3kib4sr	1	text	## Checklist	{}	1675285311213	1675285311213	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
aheseum5hgi81xnjsx1rr4ujp7r	2023-02-01 21:01:51.066397+00	c3w9hjx9oi3nwxx8aprz3kib4sr	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1675285311218	1675285311218	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
71nijhn4kejf75nbiid16jaksba	2023-02-01 21:01:51.066397+00	ch78mkjmgspytfexiypm3cxgc9w	1	checkbox	Send initial email	{"value":true}	1675285311223	1675285311223	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7chc7m1yy3t8x3x4qos5dpcm39h	2023-02-01 21:01:51.066397+00	ch78mkjmgspytfexiypm3cxgc9w	1	checkbox	Schedule follow-up sales call	{"value":true}	1675285311229	1675285311229	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7uxn6w1ngiidwufxniw73yo9qur	2023-02-01 21:01:51.066397+00	ch78mkjmgspytfexiypm3cxgc9w	1	checkbox	Follow up after demo	{"value":true}	1675285311234	1675285311234	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
75uwzow4hpt8ftqa9z9ncrsgu1a	2023-02-01 21:01:51.066397+00	ch78mkjmgspytfexiypm3cxgc9w	1	checkbox	Send proposal	{"value":true}	1675285311241	1675285311241	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7hpbiaowgmfdw5ckmwu85oc45ry	2023-02-01 21:01:51.066397+00	ch78mkjmgspytfexiypm3cxgc9w	1	checkbox	Schedule demo	{"value":true}	1675285311260	1675285311260	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7nwyz1i6qxigp5pxuyus6baxc7o	2023-02-01 21:01:51.066397+00	ch78mkjmgspytfexiypm3cxgc9w	1	checkbox	Schedule initial sales call	{"value":true}	1675285311263	1675285311263	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7qrxdubrfrjfh3mcrtz84g978ee	2023-02-01 21:01:51.066397+00	ch78mkjmgspytfexiypm3cxgc9w	1	checkbox	Send follow-up email	{"value":true}	1675285311267	1675285311267	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
ag3dtq44c13r79nz3wiqmqn3niy	2023-02-01 21:01:51.066397+00	ch78mkjmgspytfexiypm3cxgc9w	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1675285311272	1675285311272	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
araiwz15n6bgnmji4yizn5yjzyw	2023-02-01 21:01:51.066397+00	ch78mkjmgspytfexiypm3cxgc9w	1	text	## Checklist	{}	1675285311277	1675285311277	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7qtouhgkwmpdbif13t7wki3aajc	2023-02-01 21:01:51.066397+00	cashp9xzkuj8q8yd59jsq4uthgo	1	checkbox	Follow up after demo	{"value":true}	1675285311280	1675285311280	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7cxrg43e36bn55y3ijgze5ubrto	2023-02-01 21:01:51.066397+00	cashp9xzkuj8q8yd59jsq4uthgo	1	checkbox	Send initial email	{"value":true}	1675285311284	1675285311284	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7gq86u41gnbghjqtnt7n5kr5gfo	2023-02-01 21:01:51.066397+00	cashp9xzkuj8q8yd59jsq4uthgo	1	checkbox	Send follow-up email	{"value":true}	1675285311289	1675285311289	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7tywz5j41qpgxjbi3dbqban3cpc	2023-02-01 21:01:51.066397+00	cashp9xzkuj8q8yd59jsq4uthgo	1	checkbox	Send proposal	{"value":true}	1675285311292	1675285311292	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7i6x9gopwe3879khsiinxicfpzc	2023-02-01 21:01:51.066397+00	cashp9xzkuj8q8yd59jsq4uthgo	1	checkbox	Finalize contract	{"value":true}	1675285311296	1675285311296	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7nh7kwadyif8gueu4ztef6szp1e	2023-02-01 21:01:51.066397+00	cashp9xzkuj8q8yd59jsq4uthgo	1	checkbox	Schedule follow-up sales call	{"value":true}	1675285311300	1675285311300	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7edtkotuj7tbs8ctsamym7ahqzr	2023-02-01 21:01:51.066397+00	cashp9xzkuj8q8yd59jsq4uthgo	1	checkbox	Schedule initial sales call	{"value":true}	1675285311305	1675285311305	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7qp1ug6yi7tbmffofugnpykxpca	2023-02-01 21:01:51.066397+00	cashp9xzkuj8q8yd59jsq4uthgo	1	checkbox	Schedule demo	{"value":true}	1675285311309	1675285311309	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7jizdcdwxf3bn8fn6ot9ncxrgkc	2023-02-01 21:01:51.066397+00	cashp9xzkuj8q8yd59jsq4uthgo	1	checkbox	Hand-off to customer success	{"value":true}	1675285311314	1675285311314	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7n46szddgcjy3bcz4fp7iagkdkc	2023-02-01 21:01:51.066397+00	cashp9xzkuj8q8yd59jsq4uthgo	1	checkbox	Post-sales follow up	{"value":true}	1675285311319	1675285311319	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
ahzksjktg13ruixijzoi4wizz1a	2023-02-01 21:01:51.066397+00	cashp9xzkuj8q8yd59jsq4uthgo	1	text	## Checklist	{}	1675285311324	1675285311324	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
akk9y84c7ptgxjn1co6zmmz7jth	2023-02-01 21:01:51.066397+00	cashp9xzkuj8q8yd59jsq4uthgo	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1675285311328	1675285311328	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7s6ipo4tadbfebyopz5dwg1nt4y	2023-02-01 21:01:51.066397+00	c1c5sshrud7yd3dn3cu1h9k7u5c	1	checkbox	Post-sales follow up	{}	1675285311333	1675285311333	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7wqmcjdk783r4t8ubjpxee4864h	2023-02-01 21:01:51.066397+00	c1c5sshrud7yd3dn3cu1h9k7u5c	1	checkbox	Send proposal	{}	1675285311338	1675285311338	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
79ay794go13fs5dut48rcbnrxhw	2023-02-01 21:01:51.066397+00	c1c5sshrud7yd3dn3cu1h9k7u5c	1	checkbox	Hand-off to customer success	{}	1675285311342	1675285311342	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
78s3my3a9h3yy7ny3nxadfpiqdc	2023-02-01 21:01:51.066397+00	c1c5sshrud7yd3dn3cu1h9k7u5c	1	checkbox	Follow up after demo	{}	1675285311346	1675285311346	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7jmcnou6nxbfhbr3jckb5ff7eac	2023-02-01 21:01:51.066397+00	c1c5sshrud7yd3dn3cu1h9k7u5c	1	checkbox	Schedule demo	{"value":true}	1675285311350	1675285311350	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7cf8kwn5q378njp35nwwt958acy	2023-02-01 21:01:51.066397+00	c1c5sshrud7yd3dn3cu1h9k7u5c	1	checkbox	Send initial email	{"value":true}	1675285311356	1675285311356	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7hugsyenjciywims3tyqotdx7no	2023-02-01 21:01:51.066397+00	c1c5sshrud7yd3dn3cu1h9k7u5c	1	checkbox	Schedule follow-up sales call	{"value":true}	1675285311362	1675285311362	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7nfmna5o6utyumqgqqyyuj6n3wo	2023-02-01 21:01:51.066397+00	c1c5sshrud7yd3dn3cu1h9k7u5c	1	checkbox	Send follow-up email	{"value":true}	1675285311368	1675285311368	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7hnk6qa3egbn9tprmeaizqutksc	2023-02-01 21:01:51.066397+00	c1c5sshrud7yd3dn3cu1h9k7u5c	1	checkbox	Schedule initial sales call	{"value":true}	1675285311374	1675285311374	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7a8z55np11tn67d5b1qyp1wfw7o	2023-02-01 21:01:51.066397+00	c1c5sshrud7yd3dn3cu1h9k7u5c	1	checkbox	Finalize contract	{}	1675285311381	1675285311381	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
auu9n65xsfpgeiqu1huwie139oh	2023-02-01 21:01:51.066397+00	c1c5sshrud7yd3dn3cu1h9k7u5c	1	text	## Checklist	{}	1675285311393	1675285311393	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
az5ken7xou7gsdxqd4884yca3ie	2023-02-01 21:01:51.066397+00	c1c5sshrud7yd3dn3cu1h9k7u5c	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1675285311399	1675285311399	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7qhxxe5i8nffcfces8bx88igyay	2023-02-01 21:01:51.066397+00	cxjt7qpo143rpmpiuni8rpbzoww	1	checkbox	Send initial email	{"value":false}	1675285311406	1675285311406	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7fqpdwc3xr7rctk7nairp1q67br	2023-02-01 21:01:51.066397+00	cxjt7qpo143rpmpiuni8rpbzoww	1	checkbox	Schedule initial sales call	{"value":false}	1675285311412	1675285311412	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7a99pekjn4ffwfdut755fapg3ah	2023-02-01 21:01:51.066397+00	cxjt7qpo143rpmpiuni8rpbzoww	1	checkbox	Schedule follow-up sales call	{"value":false}	1675285311418	1675285311418	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7zmkncnstrtdb8fradmognondww	2023-02-01 21:01:51.066397+00	cxjt7qpo143rpmpiuni8rpbzoww	1	checkbox	Send proposal	{}	1675285311425	1675285311425	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
76ishcfirrjgb9cyps4ujpiym5o	2023-02-01 21:01:51.066397+00	cxjt7qpo143rpmpiuni8rpbzoww	1	checkbox	Finalize contract	{}	1675285311431	1675285311431	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7k94p6adrofdqzgggkyimijc99w	2023-02-01 21:01:51.066397+00	cxjt7qpo143rpmpiuni8rpbzoww	1	checkbox	Post-sales follow up	{}	1675285311436	1675285311436	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
79xiwfi64zb8rip4m93gftgyroc	2023-02-01 21:01:51.066397+00	cxjt7qpo143rpmpiuni8rpbzoww	1	checkbox	Send follow-up email	{"value":false}	1675285311442	1675285311442	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7y9kcbmyog78t3npc9exak13tao	2023-02-01 21:01:51.066397+00	cxjt7qpo143rpmpiuni8rpbzoww	1	checkbox	Schedule demo	{"value":false}	1675285311448	1675285311448	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7mwwd9h3zdp8y7ehrpduyh1m1re	2023-02-01 21:01:51.066397+00	cxjt7qpo143rpmpiuni8rpbzoww	1	checkbox	Hand-off to customer success	{}	1675285311453	1675285311453	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7dmmxyed3tjd8ibygcj9hb9kapy	2023-02-01 21:01:51.066397+00	cxjt7qpo143rpmpiuni8rpbzoww	1	checkbox	Follow up after demo	{}	1675285311458	1675285311458	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
a4rfspspx1iy7xmkp9anbkdmrkw	2023-02-01 21:01:51.066397+00	cxjt7qpo143rpmpiuni8rpbzoww	1	text	## Notes\n[Enter notes here...]	{}	1675285311462	1675285311462	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
ajk9xaiirm3ykbeego3jtczn5uo	2023-02-01 21:01:51.066397+00	cxjt7qpo143rpmpiuni8rpbzoww	1	text	## Checklist	{}	1675285311466	1675285311466	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
73rqcqs6eqigx5ro33rppnd9bth	2023-02-01 21:01:51.066397+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Hand-off to customer success	{}	1675285311469	1675285311469	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7c1p7m6mtmpn1pjmmbc7hzsdkke	2023-02-01 21:01:51.066397+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Send initial email	{"value":false}	1675285311474	1675285311474	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7e5gh8pkcbibcijkfjhg1xpsu9r	2023-02-01 21:01:51.066397+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Post-sales follow up	{}	1675285311478	1675285311478	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7iiax1wwma3nw5kbbnbrffqkh3r	2023-02-01 21:01:51.066397+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Finalize contract	{}	1675285311482	1675285311482	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7ebs4n1owejyp8dbc6z568istnr	2023-02-01 21:01:51.066397+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Send follow-up email	{"value":false}	1675285311486	1675285311486	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7rmn9661bzj8zjmywbt34pubkdw	2023-02-01 21:01:51.066397+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Schedule follow-up sales call	{"value":false}	1675285311491	1675285311491	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7s7ngurmhjifo3eu6jjjqf9ihuo	2023-02-01 21:01:51.066397+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Send proposal	{}	1675285311494	1675285311494	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7qm3tf8akktnq3pqse9n6ekcmjw	2023-02-01 21:01:51.066397+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Follow up after demo	{}	1675285311497	1675285311497	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7fs1mamc9ztyaijpg1ey3e5e7zc	2023-02-01 21:01:51.066397+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Schedule initial sales call	{"value":false}	1675285311501	1675285311501	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7mggfp6x1b3y3dyynneseq56t6e	2023-02-01 21:01:51.066397+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Schedule demo	{"value":false}	1675285311506	1675285311506	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
az6sgkd64dtyrmqxjkw8maju6fh	2023-02-01 21:01:51.066397+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	text	## Checklist	{}	1675285311511	1675285311511	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
a1rkxfz65gbypmp6hoqkah979ne	2023-02-01 21:01:51.066397+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	text	## Notes\n[Enter notes here...]	{}	1675285311515	1675285311515	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7r613e3xs5pg47fyfmzbn1a8iac	2023-02-01 21:01:51.066397+00	c77bhbr3hg7yctnz3ngujq668yr	1	checkbox	Send proposal	{}	1675285311520	1675285311520	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7idhcin49oiy65y59m35xt7nwmc	2023-02-01 21:01:51.066397+00	c77bhbr3hg7yctnz3ngujq668yr	1	checkbox	Send initial email	{"value":true}	1675285311526	1675285311526	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
78ad9bc3kqp893xoeu5mwatdzcc	2023-02-01 21:01:51.066397+00	c77bhbr3hg7yctnz3ngujq668yr	1	checkbox	Follow up after demo	{}	1675285311529	1675285311529	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7ep6o89sqj7bfdyijnsg4rkiogy	2023-02-01 21:01:51.066397+00	c77bhbr3hg7yctnz3ngujq668yr	1	checkbox	Finalize contract	{}	1675285311533	1675285311533	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7hg1cq9fqyj8ztrc1a56hr67g3a	2023-02-01 21:01:51.066397+00	c77bhbr3hg7yctnz3ngujq668yr	1	checkbox	Schedule follow-up sales call	{"value":false}	1675285311537	1675285311537	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7jijk4twacty53qehuqx6odfh4w	2023-02-01 21:01:51.066397+00	c77bhbr3hg7yctnz3ngujq668yr	1	checkbox	Schedule demo	{"value":false}	1675285311542	1675285311542	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7g38hyfc74fnqzysngkauemjmhr	2023-02-01 21:01:51.066397+00	c77bhbr3hg7yctnz3ngujq668yr	1	checkbox	Schedule initial sales call	{"value":false}	1675285311548	1675285311548	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7ahtoyyb9d7rj8mwp3k64d4fupa	2023-02-01 21:01:51.066397+00	c77bhbr3hg7yctnz3ngujq668yr	1	checkbox	Post-sales follow up	{}	1675285311555	1675285311555	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7y8koixfbwpfc8dib6u8wqaernr	2023-02-01 21:01:51.066397+00	c77bhbr3hg7yctnz3ngujq668yr	1	checkbox	Hand-off to customer success	{}	1675285311560	1675285311560	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7an7jxs1yg7f4dciw74tcrdmkny	2023-02-01 21:01:51.066397+00	c77bhbr3hg7yctnz3ngujq668yr	1	checkbox	Send follow-up email	{"value":false}	1675285311565	1675285311565	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
akggx148oyprxdpwwwfipodjuio	2023-02-01 21:01:51.066397+00	c77bhbr3hg7yctnz3ngujq668yr	1	text	## Checklist	{}	1675285311571	1675285311571	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
77sjgwoedsi8kzkfxrgg3pptpfo	2023-02-01 21:01:52.583303+00	cqqa8c5xnj7yapgxraokaoau5qa	1	checkbox	[Subtask 3]	{"value":false}	1675285312658	1675285312658	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
a839444fg7bdu9diontmswkmchy	2023-02-01 21:01:51.066397+00	c77bhbr3hg7yctnz3ngujq668yr	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1675285311577	1675285311577	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
c1b4u8tfuzpgepxxgsi5j37nunc	2023-02-01 21:01:52.182013+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Pay bills	{"contentOrder":["7nrzy4mfmhfn55yk3835cqq3jzr","7oem51ndexpfnfn89tstrd1ix6c","7s9qdgpyj8fbxdrxrxfc1y331te"],"icon":"🔌","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"aj4jyekqqssatjcq7r7chmy19ey","abthng7baedhhtrwsdodeuincqy":"true"}}	1675285312194	1675285312194	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
cpbwt854s9tnjbdffisek6yekte	2023-02-01 21:01:52.182013+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Buy groceries	{"contentOrder":["a7argh1g3y38itro8zazweohrxw","73wy1rwhdzff1umw3ferxa149ry","7fuqe3idduidqzj984x5e457owy","7n15xdmheqpbktb6w951a3pr1py","764rqxkmhc7y48cmo66d939jkth","76786pppnx7nwdeni3ouyrc5goo","7ayessgojapnku8h5nxkm89w6zh"],"icon":"🛒","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"afpy8s7i45frggprmfsqngsocqh"}}	1675285312199	1675285312199	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
ci5a1q8wnmbd4xkboem4wnz8n7a	2023-02-01 21:01:52.182013+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Go for a walk	{"contentOrder":["an5comy4i9bdpuppjgwazwq8ztw","acxqr4ewgctgy3mzinpuddc9zkw","7jpznuusobig9jp1y9hcxxwj96h"],"icon":"👣","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"an51dnkenmoog9cetapbc4uyt3y"}}	1675285312204	1675285312204	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
cjj3iphuq1frg7qytnyomm8ejoc	2023-02-01 21:01:52.182013+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Feed Fluffy	{"contentOrder":["ax1rfmsdoxirs9yk77iji1ezsae"],"icon":"🐱","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"an51dnkenmoog9cetapbc4uyt3y"}}	1675285312209	1675285312209	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
c97nnmyzqqbgmderxuzczy43fmh	2023-02-01 21:01:52.182013+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Gardening	{"contentOrder":[],"icon":"🌳","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"afpy8s7i45frggprmfsqngsocqh"}}	1675285312213	1675285312213	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
v7mor3x9g6j8h7rtzkygrgg1d4w	2023-02-01 21:01:52.182013+00	bbn1888mprfrm5fjw9f1je9x3xo	1	view	List View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":280},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a9zf59u8x1rf4ywctpcqama7tio","abthng7baedhhtrwsdodeuincqy"]}	1675285312218	1675285312218	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
vnzfcj6kjy7nufjkcsrt73kwthc	2023-02-01 21:01:52.182013+00	bbn1888mprfrm5fjw9f1je9x3xo	1	view	Board View	{"cardOrder":["cpbwt854s9tnjbdffisek6yekte","c1b4u8tfuzpgepxxgsi5j37nunc","ci5a1q8wnmbd4xkboem4wnz8n7a","cjj3iphuq1frg7qytnyomm8ejoc","czowhma7rnpgb3eczbqo3t7fijo"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a9zf59u8x1rf4ywctpcqama7tio","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["an51dnkenmoog9cetapbc4uyt3y","afpy8s7i45frggprmfsqngsocqh","aj4jyekqqssatjcq7r7chmy19ey",""],"visiblePropertyIds":["a9zf59u8x1rf4ywctpcqama7tio"]}	1675285312225	1675285312225	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
7s9qdgpyj8fbxdrxrxfc1y331te	2023-02-01 21:01:52.182013+00	c1b4u8tfuzpgepxxgsi5j37nunc	1	checkbox	Utilities	{"value":true}	1675285312229	1675285312229	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
7nrzy4mfmhfn55yk3835cqq3jzr	2023-02-01 21:01:52.182013+00	c1b4u8tfuzpgepxxgsi5j37nunc	1	checkbox	Mobile phone	{"value":true}	1675285312235	1675285312235	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
7oem51ndexpfnfn89tstrd1ix6c	2023-02-01 21:01:52.182013+00	c1b4u8tfuzpgepxxgsi5j37nunc	1	checkbox	Internet	{"value":true}	1675285312240	1675285312240	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
76786pppnx7nwdeni3ouyrc5goo	2023-02-01 21:01:52.182013+00	cpbwt854s9tnjbdffisek6yekte	1	checkbox	Cereal	{"value":false}	1675285312246	1675285312246	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
764rqxkmhc7y48cmo66d939jkth	2023-02-01 21:01:52.182013+00	cpbwt854s9tnjbdffisek6yekte	1	checkbox	Butter	{"value":false}	1675285312251	1675285312250	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
7n15xdmheqpbktb6w951a3pr1py	2023-02-01 21:01:52.182013+00	cpbwt854s9tnjbdffisek6yekte	1	checkbox	Bread	{"value":false}	1675285312256	1675285312256	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
73wy1rwhdzff1umw3ferxa149ry	2023-02-01 21:01:52.182013+00	cpbwt854s9tnjbdffisek6yekte	1	checkbox	Milk	{"value":false}	1675285312261	1675285312261	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
7ayessgojapnku8h5nxkm89w6zh	2023-02-01 21:01:52.182013+00	cpbwt854s9tnjbdffisek6yekte	1	checkbox	Bananas	{"value":false}	1675285312267	1675285312267	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
7fuqe3idduidqzj984x5e457owy	2023-02-01 21:01:52.182013+00	cpbwt854s9tnjbdffisek6yekte	1	checkbox	Eggs	{"value":false}	1675285312274	1675285312274	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
a7argh1g3y38itro8zazweohrxw	2023-02-01 21:01:52.182013+00	cpbwt854s9tnjbdffisek6yekte	1	text	## Grocery list	{}	1675285312279	1675285312279	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
7jpznuusobig9jp1y9hcxxwj96h	2023-02-01 21:01:52.182013+00	ci5a1q8wnmbd4xkboem4wnz8n7a	1	image		{"fileId":"76fwrj36hptg6dywka4k5mt3sph.png"}	1675285312284	1675285312284	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
an5comy4i9bdpuppjgwazwq8ztw	2023-02-01 21:01:52.182013+00	ci5a1q8wnmbd4xkboem4wnz8n7a	1	text	## Goal\nWalk at least 10,000 steps every day.	{}	1675285312291	1675285312291	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
acxqr4ewgctgy3mzinpuddc9zkw	2023-02-01 21:01:52.182013+00	ci5a1q8wnmbd4xkboem4wnz8n7a	1	text	## Route	{}	1675285312296	1675285312296	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
ax1rfmsdoxirs9yk77iji1ezsae	2023-02-01 21:01:52.182013+00	cjj3iphuq1frg7qytnyomm8ejoc	1	text		{}	1675285312301	1675285312301	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
cqqa8c5xnj7yapgxraokaoau5qa	2023-02-01 21:01:52.583303+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Identify dependencies	{"contentOrder":["azdy5ws6g83djze365xzz3k1ine","7tzdmkwb8y3nk8eouz9st4sgrph","aausrjtefrt8r8cjqa4hzpdm5ca","7jb99rwk9biyx9xkjdta9hkpk3a","7g1w56pcwebfid8n7tcayzbg14c","77sjgwoedsi8kzkfxrgg3pptpfo","73r9dfzbimidh7p7rzyyi7rhhow"],"icon":"🔗","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"16","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ayz81h9f3dwp7rzzbdebesc7ute","d3d682bf-e074-49d9-8df5-7320921c2d23":"98a57627-0f76-471d-850d-91f3ed9fd213"}}	1675285312593	1675285312592	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
cxjs7okw4ijbp3j3dy9jka6fk8r	2023-02-01 21:01:52.583303+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Define project scope	{"contentOrder":["a898bde5ao3yq8e61ku67ct9w1h","7u3ip6wckginmmedfz6w63uk5zy","akjgwh4bo7jnyfcw6rarbg7dz6w","7o1eykatzytbxpe38f8bow18aga","7z35jmjcgp3ratgte7i6gn9rsjh","7jk89jt7hxprftm87fd3eia8sqc","7d1ygogbcutf1iep1n4d3ap6fuw"],"icon":"🔬","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"32","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ar6b8m3jxr3asyxhr8iucdbo6yc","d3d682bf-e074-49d9-8df5-7320921c2d23":"87f59784-b859-4c24-8ebe-17c766e081dd"}}	1675285312597	1675285312597	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
cz6ya7nr1h38axpcg7dzqpca3qa	2023-02-01 21:01:52.583303+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Requirements sign-off	{"contentOrder":["acqcomzu9kirk7gh6zr4jtpa63e","7fjzmiu6h4tf9fqfj1zqd9q386a","a4fxd3hq59fdg7fcj5r7umk7xwy","7trguhpkbb7dhppqj4nknr5pm5y","7zuekry6wzi8uzmsyb1wkh7yxsc","76dtyeui1ppyyze4faamoem1zoa","7jmx7bf8ngifyjmjtw8rprhjyec"],"icon":"🖋️","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"8","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ayz81h9f3dwp7rzzbdebesc7ute","d3d682bf-e074-49d9-8df5-7320921c2d23":"d3bfb50f-f569-4bad-8a3a-dd15c3f60101"}}	1675285312602	1675285312602	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
c8kw5dry3dtyz3ef5bgphr6wfmy	2023-02-01 21:01:52.583303+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Project budget approval	{"contentOrder":["a48ysf3rnnjrnfknrr4d1qkk68y","7qdpwtk45p3neibawrmjgmioixy","ao8uqx33yp3rcuy7zzgfi4eacur","7i11nxjfw8fn7bbnbpz3ebu17nh","7hc1ge1hzb3ra5x15raidcb8gxr","7zr8dtcy8r3djbxbuwduham7xio","7henwbx7q37bfmrrexn3cs8aeur"],"icon":"💵","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"16","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ayz81h9f3dwp7rzzbdebesc7ute","d3d682bf-e074-49d9-8df5-7320921c2d23":"d3bfb50f-f569-4bad-8a3a-dd15c3f60101"}}	1675285312608	1675285312608	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
c96mazm71qf8sfxa77y9zofktrw	2023-02-01 21:01:52.583303+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Conduct market analysis	{"contentOrder":["arui51fnbsjb338xrcayrniksec","7etp67gfrnjg39q7odmgpfzgqtr","a61ugq7zfb38q3xzb9wcybnqbqh","7itq7qxo73trhjb777wqujuk95o","7yunpizq953r69b77wo9j3q88go","7x64po6uoojbqbni6aqcokms7to","78bfqtkxkn78wff7uu3t5oorgay"],"icon":"📈","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"40","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ar6b8m3jxr3asyxhr8iucdbo6yc","d3d682bf-e074-49d9-8df5-7320921c2d23":"87f59784-b859-4c24-8ebe-17c766e081dd"}}	1675285312613	1675285312612	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
vbdqbonce3fg3dju6tn1ukusuco	2023-02-01 21:01:52.583303+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Project Priorities	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"d3d682bf-e074-49d9-8df5-7320921c2d23","hiddenOptionIds":[],"kanbanCalculations":{"":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"87f59784-b859-4c24-8ebe-17c766e081dd":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"98a57627-0f76-471d-850d-91f3ed9fd213":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"d3bfb50f-f569-4bad-8a3a-dd15c3f60101":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"}},"sortOptions":[],"viewType":"board","visibleOptionIds":["d3bfb50f-f569-4bad-8a3a-dd15c3f60101","87f59784-b859-4c24-8ebe-17c766e081dd","98a57627-0f76-471d-850d-91f3ed9fd213",""],"visiblePropertyIds":["a972dc7a-5f4c-45d2-8044-8c28c69717f1","a8daz81s4xjgke1ww6cwik5w7ye"]}	1675285312617	1675285312617	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
vmw6848ygc3rztrhe6z1p79jerw	2023-02-01 21:01:52.583303+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Progress Tracker	{"cardOrder":["c8kw5dry3dtyz3ef5bgphr6wfmy","cz6ya7nr1h38axpcg7dzqpca3qa","cqqa8c5xnj7yapgxraokaoau5qa","c96mazm71qf8sfxa77y9zofktrw","cxjs7okw4ijbp3j3dy9jka6fk8r","coxnjt3ro1in19dd1e3awdt338r"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a972dc7a-5f4c-45d2-8044-8c28c69717f1","hiddenOptionIds":[],"kanbanCalculations":{"":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"adeo5xuwne3qjue83fcozekz8ko":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"afi4o5nhnqc3smtzs1hs3ij34dh":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"ahpyxfnnrzynsw3im1psxpkgtpe":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"ar6b8m3jxr3asyxhr8iucdbo6yc":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"ayz81h9f3dwp7rzzbdebesc7ute":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"}},"sortOptions":[],"viewType":"board","visibleOptionIds":["ayz81h9f3dwp7rzzbdebesc7ute","ar6b8m3jxr3asyxhr8iucdbo6yc","afi4o5nhnqc3smtzs1hs3ij34dh","adeo5xuwne3qjue83fcozekz8ko","ahpyxfnnrzynsw3im1psxpkgtpe",""],"visiblePropertyIds":["d3d682bf-e074-49d9-8df5-7320921c2d23","a8daz81s4xjgke1ww6cwik5w7ye"]}	1675285312622	1675285312622	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
vok9s8etnuty9txbqrjyk9duwfc	2023-02-01 21:01:52.583303+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Task Overview	{"cardOrder":["cxjs7okw4ijbp3j3dy9jka6fk8r","c96mazm71qf8sfxa77y9zofktrw","cqqa8c5xnj7yapgxraokaoau5qa","c8kw5dry3dtyz3ef5bgphr6wfmy","cz6ya7nr1h38axpcg7dzqpca3qa","cz8p8gofakfby8kzz83j97db8ph","ce1jm5q5i54enhuu4h3kkay1hcc"],"collapsedOptionIds":[],"columnCalculations":{"a8daz81s4xjgke1ww6cwik5w7ye":"sum"},"columnWidths":{"2a5da320-735c-4093-8787-f56e15cdfeed":196,"__title":280,"a8daz81s4xjgke1ww6cwik5w7ye":139,"a972dc7a-5f4c-45d2-8044-8c28c69717f1":141,"d3d682bf-e074-49d9-8df5-7320921c2d23":110},"defaultTemplateId":"czw9es1e89fdpjr7cqptr1xq7qh","filter":{"filters":[],"operation":"and"},"groupById":"","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a972dc7a-5f4c-45d2-8044-8c28c69717f1","d3d682bf-e074-49d9-8df5-7320921c2d23","2a5da320-735c-4093-8787-f56e15cdfeed","a3zsw7xs8sxy7atj8b6totp3mby","axkhqa4jxr3jcqe4k87g8bhmary","a7gdnz8ff8iyuqmzddjgmgo9ery","a8daz81s4xjgke1ww6cwik5w7ye"]}	1675285312629	1675285312629	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
v5qyzkcts7bgemdbgsoj46m4dcr	2023-02-01 21:01:52.583303+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Task Calendar	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"a3zsw7xs8sxy7atj8b6totp3mby","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675285312634	1675285312634	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7jb99rwk9biyx9xkjdta9hkpk3a	2023-02-01 21:01:52.583303+00	cqqa8c5xnj7yapgxraokaoau5qa	1	checkbox	[Subtask 1]	{"value":false}	1675285312640	1675285312640	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7g1w56pcwebfid8n7tcayzbg14c	2023-02-01 21:01:52.583303+00	cqqa8c5xnj7yapgxraokaoau5qa	1	checkbox	[Subtask 2]	{"value":false}	1675285312645	1675285312645	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7tzdmkwb8y3nk8eouz9st4sgrph	2023-02-01 21:01:52.583303+00	cqqa8c5xnj7yapgxraokaoau5qa	1	divider		{}	1675285312649	1675285312649	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
73r9dfzbimidh7p7rzyyi7rhhow	2023-02-01 21:01:52.583303+00	cqqa8c5xnj7yapgxraokaoau5qa	1	checkbox	...	{"value":false}	1675285312653	1675285312653	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
aausrjtefrt8r8cjqa4hzpdm5ca	2023-02-01 21:01:52.583303+00	cqqa8c5xnj7yapgxraokaoau5qa	1	text	## Checklist	{}	1675285312662	1675285312662	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
azdy5ws6g83djze365xzz3k1ine	2023-02-01 21:01:52.583303+00	cqqa8c5xnj7yapgxraokaoau5qa	1	text	## Description\n*[Brief description of this task]*	{}	1675285312667	1675285312667	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7z35jmjcgp3ratgte7i6gn9rsjh	2023-02-01 21:01:52.583303+00	cxjs7okw4ijbp3j3dy9jka6fk8r	1	checkbox	[Subtask 2]	{"value":false}	1675285312672	1675285312672	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7d1ygogbcutf1iep1n4d3ap6fuw	2023-02-01 21:01:52.583303+00	cxjs7okw4ijbp3j3dy9jka6fk8r	1	checkbox	...	{"value":false}	1675285312678	1675285312678	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7o1eykatzytbxpe38f8bow18aga	2023-02-01 21:01:52.583303+00	cxjs7okw4ijbp3j3dy9jka6fk8r	1	checkbox	[Subtask 1]	{"value":false}	1675285312682	1675285312682	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7jk89jt7hxprftm87fd3eia8sqc	2023-02-01 21:01:52.583303+00	cxjs7okw4ijbp3j3dy9jka6fk8r	1	checkbox	[Subtask 3]	{"value":false}	1675285312687	1675285312687	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7u3ip6wckginmmedfz6w63uk5zy	2023-02-01 21:01:52.583303+00	cxjs7okw4ijbp3j3dy9jka6fk8r	1	divider		{}	1675285312692	1675285312692	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
akjgwh4bo7jnyfcw6rarbg7dz6w	2023-02-01 21:01:52.583303+00	cxjs7okw4ijbp3j3dy9jka6fk8r	1	text	## Checklist	{}	1675285312696	1675285312696	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
a898bde5ao3yq8e61ku67ct9w1h	2023-02-01 21:01:52.583303+00	cxjs7okw4ijbp3j3dy9jka6fk8r	1	text	## Description\n*[Brief description of this task]*	{}	1675285312701	1675285312701	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7jmx7bf8ngifyjmjtw8rprhjyec	2023-02-01 21:01:52.583303+00	cz6ya7nr1h38axpcg7dzqpca3qa	1	checkbox	...	{"value":false}	1675285312705	1675285312705	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7zuekry6wzi8uzmsyb1wkh7yxsc	2023-02-01 21:01:52.583303+00	cz6ya7nr1h38axpcg7dzqpca3qa	1	checkbox	[Subtask 2]	{"value":false}	1675285312710	1675285312710	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7fjzmiu6h4tf9fqfj1zqd9q386a	2023-02-01 21:01:52.583303+00	cz6ya7nr1h38axpcg7dzqpca3qa	1	divider		{}	1675285312715	1675285312715	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
76dtyeui1ppyyze4faamoem1zoa	2023-02-01 21:01:52.583303+00	cz6ya7nr1h38axpcg7dzqpca3qa	1	checkbox	[Subtask 3]	{"value":false}	1675285312720	1675285312720	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7trguhpkbb7dhppqj4nknr5pm5y	2023-02-01 21:01:52.583303+00	cz6ya7nr1h38axpcg7dzqpca3qa	1	checkbox	[Subtask 1]	{"value":false}	1675285312726	1675285312726	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
acqcomzu9kirk7gh6zr4jtpa63e	2023-02-01 21:01:52.583303+00	cz6ya7nr1h38axpcg7dzqpca3qa	1	text	## Description\n*[Brief description of this task]*	{}	1675285312730	1675285312730	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
a4fxd3hq59fdg7fcj5r7umk7xwy	2023-02-01 21:01:52.583303+00	cz6ya7nr1h38axpcg7dzqpca3qa	1	text	## Checklist	{}	1675285312735	1675285312735	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7qdpwtk45p3neibawrmjgmioixy	2023-02-01 21:01:52.583303+00	c8kw5dry3dtyz3ef5bgphr6wfmy	1	divider		{}	1675285312742	1675285312742	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7i11nxjfw8fn7bbnbpz3ebu17nh	2023-02-01 21:01:52.583303+00	c8kw5dry3dtyz3ef5bgphr6wfmy	1	checkbox	[Subtask 1]	{"value":false}	1675285312747	1675285312747	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7zr8dtcy8r3djbxbuwduham7xio	2023-02-01 21:01:52.583303+00	c8kw5dry3dtyz3ef5bgphr6wfmy	1	checkbox	[Subtask 3]	{"value":false}	1675285312752	1675285312752	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7henwbx7q37bfmrrexn3cs8aeur	2023-02-01 21:01:52.583303+00	c8kw5dry3dtyz3ef5bgphr6wfmy	1	checkbox	...	{"value":false}	1675285312757	1675285312757	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7hc1ge1hzb3ra5x15raidcb8gxr	2023-02-01 21:01:52.583303+00	c8kw5dry3dtyz3ef5bgphr6wfmy	1	checkbox	[Subtask 2]	{"value":false}	1675285312762	1675285312761	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
ao8uqx33yp3rcuy7zzgfi4eacur	2023-02-01 21:01:52.583303+00	c8kw5dry3dtyz3ef5bgphr6wfmy	1	text	## Checklist	{}	1675285312766	1675285312766	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
a48ysf3rnnjrnfknrr4d1qkk68y	2023-02-01 21:01:52.583303+00	c8kw5dry3dtyz3ef5bgphr6wfmy	1	text	## Description\n*[Brief description of this task]*	{}	1675285312769	1675285312769	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
78bfqtkxkn78wff7uu3t5oorgay	2023-02-01 21:01:52.583303+00	c96mazm71qf8sfxa77y9zofktrw	1	checkbox	...	{"value":false}	1675285312775	1675285312775	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7x64po6uoojbqbni6aqcokms7to	2023-02-01 21:01:52.583303+00	c96mazm71qf8sfxa77y9zofktrw	1	checkbox	[Subtask 3]	{"value":false}	1675285312780	1675285312780	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7etp67gfrnjg39q7odmgpfzgqtr	2023-02-01 21:01:52.583303+00	c96mazm71qf8sfxa77y9zofktrw	1	divider		{}	1675285312784	1675285312784	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7yunpizq953r69b77wo9j3q88go	2023-02-01 21:01:52.583303+00	c96mazm71qf8sfxa77y9zofktrw	1	checkbox	[Subtask 2]	{"value":false}	1675285312789	1675285312789	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7itq7qxo73trhjb777wqujuk95o	2023-02-01 21:01:52.583303+00	c96mazm71qf8sfxa77y9zofktrw	1	checkbox	[Subtask 1]	{"value":false}	1675285312795	1675285312794	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
arui51fnbsjb338xrcayrniksec	2023-02-01 21:01:52.583303+00	c96mazm71qf8sfxa77y9zofktrw	1	text	## Description\n*[Brief description of this task]*	{}	1675285312800	1675285312800	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
a61ugq7zfb38q3xzb9wcybnqbqh	2023-02-01 21:01:52.583303+00	c96mazm71qf8sfxa77y9zofktrw	1	text	## Checklist	{}	1675285312806	1675285312806	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7jjn7six9178abkf53p3yhycfey	2023-02-01 21:01:52.583303+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	[Subtask 3]	{"value":false}	1675285312811	1675285312811	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
77j8xyt44ipfh8qxiwog7j47oiy	2023-02-01 21:01:52.583303+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	[Subtask 2]	{"value":false}	1675285312816	1675285312816	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7noijreiwjj8m8roeizz3pb1c3h	2023-02-01 21:01:52.583303+00	czw9es1e89fdpjr7cqptr1xq7qh	1	divider		{}	1675285312822	1675285312822	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7ik861fgp3jrb8n58ofjbrnhiwr	2023-02-01 21:01:52.583303+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	[Subtask 1]	{"value":false}	1675285312828	1675285312828	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7kkiubk15bjruir3dr18uqcmfsr	2023-02-01 21:01:52.583303+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	...	{"value":false}	1675285312833	1675285312833	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
a8w37pe1xafrjir5e6hg7yf9x5r	2023-02-01 21:01:52.583303+00	czw9es1e89fdpjr7cqptr1xq7qh	1	text	## Description\n*[Brief description of this task]*	{}	1675285312838	1675285312838	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
aar5urjpb9bnw8ks15m3boakxbc	2023-02-01 21:01:52.583303+00	czw9es1e89fdpjr7cqptr1xq7qh	1	text	## Checklist	{}	1675285312845	1675285312845	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
vys9qu1qeuind5k9azrmuoq3c1o	2023-02-01 21:01:53.231087+00		1	view	By Quarter	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":452,"a17ryhi1jfsboxkwkztwawhmsxe":148,"a6amddgmrzakw66cidqzgk6p4ge":230,"azzbawji5bksj69sekcs4srm1ky":142},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"aqxyzkdrs4egqf7yk866ixkaojc","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a6amddgmrzakw66cidqzgk6p4ge","a17ryhi1jfsboxkwkztwawhmsxe","azzbawji5bksj69sekcs4srm1ky","adp5ft3kgz7r5iqq3tnwg551der","aqxyzkdrs4egqf7yk866ixkaojc","adu6mebzpibq6mgcswk69xxmnqe","asope3bddhm4gpsng5cfu4hf6rh","ajwxp866f9obs1kutfwaa5ru7fe","azqnyswk6s1boiwuthscm78qwuo","ahz3fmjnaguec8hce7xq3h5cjdr","a17bfcgnzmkwhziwa4tr38kiw5r"]}	1675285313244	1675285313244	0	\N	system		system	bm9cpg1atuf8n3m9rd3mbf5d7yc
var8sfkf5g3bwukuo1r8igs6mae	2023-02-01 21:01:53.231087+00		1	view	By Objectives	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":387,"a17ryhi1jfsboxkwkztwawhmsxe":134,"a6amddgmrzakw66cidqzgk6p4ge":183,"aqxyzkdrs4egqf7yk866ixkaojc":100},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a6amddgmrzakw66cidqzgk6p4ge","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a6amddgmrzakw66cidqzgk6p4ge","a17ryhi1jfsboxkwkztwawhmsxe","azzbawji5bksj69sekcs4srm1ky","adp5ft3kgz7r5iqq3tnwg551der","aqxyzkdrs4egqf7yk866ixkaojc","adu6mebzpibq6mgcswk69xxmnqe","asope3bddhm4gpsng5cfu4hf6rh","ajwxp866f9obs1kutfwaa5ru7fe","azqnyswk6s1boiwuthscm78qwuo","ahz3fmjnaguec8hce7xq3h5cjdr","a17bfcgnzmkwhziwa4tr38kiw5r"]}	1675285313250	1675285313250	0	\N	system		system	bm9cpg1atuf8n3m9rd3mbf5d7yc
cb31ppku4ufrkxeo8a1otsnhajw	2023-02-01 21:01:53.231087+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Improve customer NPS score	{"contentOrder":[],"icon":"💯","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a8nukezwwmknqwjsygg7eaxs9te","a6amddgmrzakw66cidqzgk6p4ge":"apqfjst8massbjjhpcsjs3y1yqa","adp5ft3kgz7r5iqq3tnwg551der":"as555ipyzopjjpfb5rjtssecw5e","ahz3fmjnaguec8hce7xq3h5cjdr":"82%","ajwxp866f9obs1kutfwaa5ru7fe":"8.5","aqxyzkdrs4egqf7yk866ixkaojc":"anruuoyez51r3yjxuoc8zoqnwaw","azqnyswk6s1boiwuthscm78qwuo":"7","azzbawji5bksj69sekcs4srm1ky":"agm9p6gcq15ueuzqq3wd4be39wy"}}	1675285313254	1675285313253	0	\N	system		system	bm9cpg1atuf8n3m9rd3mbf5d7yc
c95ijif8xhbrg5m3coccg657zgw	2023-02-01 21:01:53.231087+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Generate more Marketing Qualified Leads (MQLs)	{"contentOrder":[],"icon":"🛣️","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a8nukezwwmknqwjsygg7eaxs9te","a6amddgmrzakw66cidqzgk6p4ge":"auw3afh3kfhrfgmjr8muiz137jy","adp5ft3kgz7r5iqq3tnwg551der":"as555ipyzopjjpfb5rjtssecw5e","ahz3fmjnaguec8hce7xq3h5cjdr":"65%","ajwxp866f9obs1kutfwaa5ru7fe":"100","aqxyzkdrs4egqf7yk866ixkaojc":"ahfbn1jsmhydym33ygxwg5jt3kh","azqnyswk6s1boiwuthscm78qwuo":"65","azzbawji5bksj69sekcs4srm1ky":"aehoa17cz18rqnrf75g7dwhphpr"}}	1675285313258	1675285313258	0	\N	system		system	bm9cpg1atuf8n3m9rd3mbf5d7yc
cnjniz8bjyfnj5qjtq6wcup1qqo	2023-02-01 21:01:53.231087+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Increase customer retention	{"contentOrder":[],"icon":"😀","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a8nukezwwmknqwjsygg7eaxs9te","a6amddgmrzakw66cidqzgk6p4ge":"apqfjst8massbjjhpcsjs3y1yqa","adp5ft3kgz7r5iqq3tnwg551der":"a8zg3rjtf4swh7smsjxpsn743rh","ahz3fmjnaguec8hce7xq3h5cjdr":"66%","ajwxp866f9obs1kutfwaa5ru7fe":"90% customer retention rate","aqxyzkdrs4egqf7yk866ixkaojc":"acb6dqqs6yson7bbzx6jk9bghjh","azqnyswk6s1boiwuthscm78qwuo":"60%","azzbawji5bksj69sekcs4srm1ky":"afkxpcjqjypu7hhar7banxau91h"}}	1675285313263	1675285313263	0	\N	system		system	bm9cpg1atuf8n3m9rd3mbf5d7yc
c517m7hypo3dk5p85gmijbfkxah	2023-02-01 21:01:53.231087+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Hit company global sales target	{"contentOrder":[],"icon":"💰","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a6robxx81diugpjq5jkezz3j1fo","a6amddgmrzakw66cidqzgk6p4ge":"auw3afh3kfhrfgmjr8muiz137jy","adp5ft3kgz7r5iqq3tnwg551der":"a8zg3rjtf4swh7smsjxpsn743rh","ahz3fmjnaguec8hce7xq3h5cjdr":"15%","ajwxp866f9obs1kutfwaa5ru7fe":"50MM","aqxyzkdrs4egqf7yk866ixkaojc":"awfu37js3fomfkkczm1zppac57a","azqnyswk6s1boiwuthscm78qwuo":"7.5MM","azzbawji5bksj69sekcs4srm1ky":"agrfeaoj7d8p5ianw5iaf3191ae"}}	1675285313268	1675285313268	0	\N	system		system	bm9cpg1atuf8n3m9rd3mbf5d7yc
ccm4dbjf6ypf13ed8eu3okfoh5e	2023-02-01 21:01:53.231087+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Increase user signups by 30%	{"contentOrder":[],"icon":"💳","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a6robxx81diugpjq5jkezz3j1fo","a6amddgmrzakw66cidqzgk6p4ge":"ao9b5pxyt7tkgdohzh9oaustdhr","adp5ft3kgz7r5iqq3tnwg551der":"as555ipyzopjjpfb5rjtssecw5e","ahz3fmjnaguec8hce7xq3h5cjdr":"0%","ajwxp866f9obs1kutfwaa5ru7fe":"1,000","aqxyzkdrs4egqf7yk866ixkaojc":"acb6dqqs6yson7bbzx6jk9bghjh","azqnyswk6s1boiwuthscm78qwuo":"0","azzbawji5bksj69sekcs4srm1ky":"afkxpcjqjypu7hhar7banxau91h"}}	1675285313274	1675285313274	0	\N	system		system	bm9cpg1atuf8n3m9rd3mbf5d7yc
ch3xuddkqxib95pi1f9qiujngna	2023-02-01 21:01:53.231087+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Add 10 new customers in the EU	{"contentOrder":[],"icon":"🌍","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"apnt1f7na9rzgk1rt49keg7xbiy","a6amddgmrzakw66cidqzgk6p4ge":"auw3afh3kfhrfgmjr8muiz137jy","adp5ft3kgz7r5iqq3tnwg551der":"a1ts3ftyr8nocsicui98c89uxjy","ahz3fmjnaguec8hce7xq3h5cjdr":"30%","ajwxp866f9obs1kutfwaa5ru7fe":"10","aqxyzkdrs4egqf7yk866ixkaojc":"acb6dqqs6yson7bbzx6jk9bghjh","azqnyswk6s1boiwuthscm78qwuo":"3","azzbawji5bksj69sekcs4srm1ky":"agrfeaoj7d8p5ianw5iaf3191ae"}}	1675285313279	1675285313279	0	\N	system		system	bm9cpg1atuf8n3m9rd3mbf5d7yc
cfmmnd485mirr3dw1o1dociys8h	2023-02-01 21:01:53.231087+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Launch 3 key features	{"contentOrder":[],"icon":"🚀","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"apnt1f7na9rzgk1rt49keg7xbiy","a6amddgmrzakw66cidqzgk6p4ge":"ao9b5pxyt7tkgdohzh9oaustdhr","adp5ft3kgz7r5iqq3tnwg551der":"a8zg3rjtf4swh7smsjxpsn743rh","ahz3fmjnaguec8hce7xq3h5cjdr":"33%","ajwxp866f9obs1kutfwaa5ru7fe":"3","aqxyzkdrs4egqf7yk866ixkaojc":"anruuoyez51r3yjxuoc8zoqnwaw","azqnyswk6s1boiwuthscm78qwuo":"1","azzbawji5bksj69sekcs4srm1ky":"aw5i7hmpadn6mbwbz955ubarhme"}}	1675285313285	1675285313285	0	\N	system		system	bm9cpg1atuf8n3m9rd3mbf5d7yc
ccygg7f9m5bddff7p96ye4rcqow	2023-02-01 21:01:53.231087+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Reduce bug backlog by 50%	{"contentOrder":[],"icon":"🐞","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"abzfwnn6rmtfzyq5hg8uqmpsncy","a6amddgmrzakw66cidqzgk6p4ge":"apqfjst8massbjjhpcsjs3y1yqa","adp5ft3kgz7r5iqq3tnwg551der":"a1ts3ftyr8nocsicui98c89uxjy","ahz3fmjnaguec8hce7xq3h5cjdr":"100%","ajwxp866f9obs1kutfwaa5ru7fe":"75","aqxyzkdrs4egqf7yk866ixkaojc":"awfu37js3fomfkkczm1zppac57a","azqnyswk6s1boiwuthscm78qwuo":"75","azzbawji5bksj69sekcs4srm1ky":"aw5i7hmpadn6mbwbz955ubarhme"}}	1675285313291	1675285313291	0	\N	system		system	bm9cpg1atuf8n3m9rd3mbf5d7yc
ayi3gma6tufy1t8qmn86hjnafmw	2023-02-01 21:01:53.698735+00	chgbgdr44iif87xim9xgus5sxew	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675285313914	1675285313914	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
vx7xaok4eupn7pjjiyxs8q8hofc	2023-02-01 21:01:53.231087+00	bm4ubx56krp4zwyfcqh7nxiigbr	1	view	Departments	{"cardOrder":["cpa534b5natgmunis8u1ixb55pw"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"azzbawji5bksj69sekcs4srm1ky","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["aw5i7hmpadn6mbwbz955ubarhme","afkxpcjqjypu7hhar7banxau91h","aehoa17cz18rqnrf75g7dwhphpr","agrfeaoj7d8p5ianw5iaf3191ae","agm9p6gcq15ueuzqq3wd4be39wy","aucop7kw6xwodcix6zzojhxih6r","afust91f3g8ht368mkn5x9tgf1o","acocxxwjurud1jixhp7nowdig7y"],"visiblePropertyIds":[]}	1675285313295	1675285313295	0	\N	system		system	bm9cpg1atuf8n3m9rd3mbf5d7yc
csrh74ossctradrhzjhaopk7kic	2023-02-01 21:01:53.538374+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Start a daily journal	{"contentOrder":[],"icon":"✍️","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","d6b1249b-bc18-45fc-889e-bec48fce80ef":"0a82977f-52bf-457b-841b-e2b7f76fb525","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"3245a32d-f688-463b-87f4-8e7142c1b397"}}	1675285313550	1675285313550	0	\N	system		system	b9wgudz1ippgf7map6ygr7tydza
c44mniddtqtg7xe9md1ekdsh3fa	2023-02-01 21:01:53.538374+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Run 3 times a week	{"contentOrder":[],"icon":"🏃","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","d6b1249b-bc18-45fc-889e-bec48fce80ef":"6e7139e4-5358-46bb-8c01-7b029a57b80a","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"ffb3f951-b47f-413b-8f1d-238666728008"}}	1675285313553	1675285313553	0	\N	system		system	b9wgudz1ippgf7map6ygr7tydza
ch4z9qfabz7rbbb574qo6hp9o7h	2023-02-01 21:01:53.538374+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Learn to paint	{"contentOrder":[],"icon":"🎨","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"77c539af-309c-4db1-8329-d20ef7e9eacd","d6b1249b-bc18-45fc-889e-bec48fce80ef":"9a090e33-b110-4268-8909-132c5002c90e","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"3245a32d-f688-463b-87f4-8e7142c1b397"}}	1675285313560	1675285313560	0	\N	system		system	b9wgudz1ippgf7map6ygr7tydza
cp88u4rthp7rjdg43p89pyr3q4w	2023-02-01 21:01:53.538374+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Open retirement account	{"contentOrder":[],"icon":"🏦","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","d6b1249b-bc18-45fc-889e-bec48fce80ef":"0a82977f-52bf-457b-841b-e2b7f76fb525","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"80be816c-fc7a-4928-8489-8b02180f4954"}}	1675285313568	1675285313568	0	\N	system		system	b9wgudz1ippgf7map6ygr7tydza
vaxnnfhfcointxddzm8u7bdzf3y	2023-02-01 21:01:53.538374+00	bd65qbzuqupfztpg31dgwgwm5ga	1	view	By Status	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"af6fcbb8-ca56-4b73-83eb-37437b9a667d","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","77c539af-309c-4db1-8329-d20ef7e9eacd","98bdea27-0cce-4cde-8dc6-212add36e63a",""],"visiblePropertyIds":["d9725d14-d5a8-48e5-8de1-6f8c004a9680","d6b1249b-bc18-45fc-889e-bec48fce80ef"]}	1675285313575	1675285313575	0	\N	system		system	b9wgudz1ippgf7map6ygr7tydza
vjedjnzbtebg99mtiyfpasa5rsc	2023-02-01 21:01:53.538374+00	bd65qbzuqupfztpg31dgwgwm5ga	1	view	Calendar View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"ajy6xbebzopojaenbnmfpgtdwso","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675285313580	1675285313580	0	\N	system		system	b9wgudz1ippgf7map6ygr7tydza
v9kfotbb9fjfhbcpueqkb8ek7xe	2023-02-01 21:01:53.538374+00	bd65qbzuqupfztpg31dgwgwm5ga	1	view	By Date	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"d6b1249b-bc18-45fc-889e-bec48fce80ef","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["9a090e33-b110-4268-8909-132c5002c90e","0a82977f-52bf-457b-841b-e2b7f76fb525","6e7139e4-5358-46bb-8c01-7b029a57b80a","d5371c63-66bf-4468-8738-c4dc4bea4843",""],"visiblePropertyIds":["d9725d14-d5a8-48e5-8de1-6f8c004a9680"]}	1675285313594	1675285313593	0	\N	system		system	b9wgudz1ippgf7map6ygr7tydza
v6cagtxm463ftdg9ni9x155kp7o	2023-02-01 21:01:54.131682+00		1	view	All Users	{"cardOrder":["cse9me1ogppgktyn7q7hrmrdaxa"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":280,"aaebj5fyx493eezx6ukxiwydgty":146,"acjq4t5ymytu8x1f68wkggm7ypc":222,"akrxgi7p7w14fym3gbynb98t9fh":131,"atg9qu6oe4bjm8jczzsn71ff5me":131},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"akrxgi7p7w14fym3gbynb98t9fh","reversed":false}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["aaebj5fyx493eezx6ukxiwydgty","akrxgi7p7w14fym3gbynb98t9fh","atg9qu6oe4bjm8jczzsn71ff5me","acjq4t5ymytu8x1f68wkggm7ypc","aphio1s5gkmpdbwoxynim7acw3e","aqafzdeekpyncwz7m7i54q3iqqy","aify3r761b9w43bqjtskrzi68tr"]}	1675285314141	1675285314141	0	\N	system		system	bjwjkmputh7dn8mequhmmfrhnba
cse9me1ogppgktyn7q7hrmrdaxa	2023-02-01 21:01:54.131682+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Frank Nash	{"contentOrder":["ax7ha15c8g3ypjyi6ug4kpt6efr"],"icon":"👨‍💼","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"ap93ysuzy1xa7z818r6myrn4h4y","acjq4t5ymytu8x1f68wkggm7ypc":"frank.nash@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1669896000000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"aehc83ffays3gh8myz16a8j7k4e"}}	1675285314148	1675285314148	0	\N	system		system	bjwjkmputh7dn8mequhmmfrhnba
cojh3dntq83ymbxx76ne8w9ckpc	2023-02-01 21:01:54.131682+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Richard Parsons	{"contentOrder":["af9ozxqifk7fztgjns71jpchu3c"],"icon":"👨‍🦱","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"a7yq89whddzob1futao4rxk3yzc","acjq4t5ymytu8x1f68wkggm7ypc":"richard.parsons@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1671019200000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"a1sxagjgaadym5yrjak6tcup1oa"}}	1675285314152	1675285314152	0	\N	system		system	bjwjkmputh7dn8mequhmmfrhnba
ct6cbjq9fkty398pm7i1rggk6pc	2023-02-01 21:01:54.131682+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Claire Hart	{"contentOrder":["acnefwdrtsigyppobztpiobwp1o"],"icon":"👩‍🦰","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"aseqq9hrsua56r3s6nbuirj9eec","acjq4t5ymytu8x1f68wkggm7ypc":"claire.hart@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1670500800000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"ahn89mqg9u4igk6pdm7333t8i5h"}}	1675285314156	1675285314156	0	\N	system		system	bjwjkmputh7dn8mequhmmfrhnba
vqh7ut1ag4fbi7j5mt6tp1pd31a	2023-02-01 21:01:53.698735+00		1	view	By Sprint	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{"ai7ajsdk14w7x5s8up3dwir77te":"count"},"columnWidths":{"20717ad3-5741-4416-83f1-6f133fff3d11":128,"50117d52-bcc7-4750-82aa-831a351c44a0":126,"__title":280,"a1g6i613dpe9oryeo71ex3c86hy":159,"aeomttrbhhsi8bph31jn84sto6h":141,"ax9f8so418s6s65hi5ympd93i6a":183,"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":100},"defaultTemplateId":"cdgg5axw99i8g8q19xnb9t8nnre","filter":{"filters":[],"operation":"and"},"groupById":"60985f46-3e41-486e-8213-2b987440ea1c","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["50117d52-bcc7-4750-82aa-831a351c44a0","20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","aphg37f7zbpuc3bhwhp19s1ribh","a4378omyhmgj3bex13sj4wbpfiy","ai7ajsdk14w7x5s8up3dwir77te","a1g6i613dpe9oryeo71ex3c86hy","aeomttrbhhsi8bph31jn84sto6h","ax9f8so418s6s65hi5ympd93i6a"]}	1675285313716	1675285313716	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
cdgg5axw99i8g8q19xnb9t8nnre	2023-02-01 21:01:53.698735+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	User Story	{"contentOrder":["a7yw4ja7bo3b6tpppx859ok4z6y"],"icon":"📖","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"apht1nt5ryukdmxkh6fkfn6rgoy","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer"}}	1675285313724	1675285313724	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
cmdct36nzyjgz3gxc5y99t9w77r	2023-02-01 21:01:53.698735+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Horizontal scroll issue	{"contentOrder":["aksc1gc3hrbdyzdpnnykbpyxzje","aqtaxszth4fgnbyyob3cnkhpqje","7yz7y1s4ffjgp8dfnndh3z7k9hc"],"icon":"〰️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"aomnawq4551cbbzha9gxnmb3z5w","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","ai7ajsdk14w7x5s8up3dwir77te":"1","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675285313726	1675285313726	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
ctfpzwwoysjbh5fjikhrt3wpybe	2023-02-01 21:01:53.698735+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Login screen not loading	{"contentOrder":["aumrq4z8rs7r9uysym3beq3urxr","afj1jneb377baiyqh7owf4p4xic","7bc46ems95inotfhh8rh6d5pyqy"],"icon":"🖥️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"aomnawq4551cbbzha9gxnmb3z5w","50117d52-bcc7-4750-82aa-831a351c44a0":"abrfos7e7eczk9rqw6y5abadm1y","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","ai7ajsdk14w7x5s8up3dwir77te":"1","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"cb8ecdac-38be-4d36-8712-c4d58cc8a8e9"}}	1675285313728	1675285313728	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
c5josmiyxofrijgu4tpsiqcahye	2023-02-01 21:01:53.698735+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Move cards across boards	{"contentOrder":["aqikuktit9pyc9jsffr5x3ijzgh"],"icon":"🚚","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"abrfos7e7eczk9rqw6y5abadm1y","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"2","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675285313736	1675285313736	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
ctiipeg948p8fumipgkjattphze	2023-02-01 21:01:53.698735+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Cross-team collaboration	{"contentOrder":["a5bdy74tbejfb7rwfwizxebkxxo"],"icon":"🤝","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"424ea5e3-9aa1-4075-8c5c-01b44b66e634","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","60985f46-3e41-486e-8213-2b987440ea1c":"14892380-1a32-42dd-8034-a0cea32bc7e6","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"3","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"c62172ea-5da7-4dec-8186-37267d8ee9a7"}}	1675285313740	1675285313740	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
cb1n1h1w75jbafqjdd5qi8tzedw	2023-02-01 21:01:53.698735+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Bug	{"contentOrder":["aafxd758zniyexgdfj64cs7coer","ayniuk6nohfyp9cths4anryxd4y","7hf9aqj6ospge9jo3ej5wsh7muw"],"icon":"🐞","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"aomnawq4551cbbzha9gxnmb3z5w","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer"}}	1675285313742	1675285313742	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
cm9nyefeoxtyjidq8je1bnriobe	2023-02-01 21:01:53.698735+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Standard properties	{"contentOrder":["ac8fqo7bpepbdmd9ybzx3i6fpyo"],"icon":"🏷️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","60985f46-3e41-486e-8213-2b987440ea1c":"14892380-1a32-42dd-8034-a0cea32bc7e6","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"3","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675285313745	1675285313745	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
cwb3ucjf81fdifcy41cfcm4qb5e	2023-02-01 21:01:53.698735+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Epic	{"contentOrder":["awn6zjuk64jbhbpjyqfcoqfg1do"],"icon":"🤝","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"424ea5e3-9aa1-4075-8c5c-01b44b66e634","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"3","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"c62172ea-5da7-4dec-8186-37267d8ee9a7"}}	1675285313748	1675285313748	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
chgbgdr44iif87xim9xgus5sxew	2023-02-01 21:01:53.698735+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Global templates	{"contentOrder":["ayi3gma6tufy1t8qmn86hjnafmw"],"icon":"🖼️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"a6ghze4iy441qhsh3eijnc8hwze","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"2","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675285313751	1675285313751	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
cwa6utrrkgjb5jyo345wr4wys4o	2023-02-01 21:01:53.698735+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Feature	{"contentOrder":["auwor8ubpaff77pttbw8m61za3w"],"icon":"🏗️","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer"}}	1675285313776	1675285313776	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
awn6zjuk64jbhbpjyqfcoqfg1do	2023-02-01 21:01:53.698735+00	cwb3ucjf81fdifcy41cfcm4qb5e	1	text	## Summary\n*[Brief description of what this epic is about]*\n\n## Motivation\n*[Brief description on why this is needed]*\n\n## Acceptance Criteria\n - *[Criteron 1]*\n - *[Criteron 2]*\n - ...\n\n## Personas\n - *[Persona A]*\n - *[Persona B]*\n - ...\n\n## Reference Materials\n - *[Links to other relevant documents as needed]*\n - ...	{}	1675285313909	1675285313909	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
vmt4jqqapz3di9fbxjmmu3iba5h	2023-02-01 21:01:53.698735+00	bgi1yqiis8t8xdqxgnet8ebutky	1	view	By Status	{"cardOrder":["chgbgdr44iif87xim9xgus5sxew","cmdct36nzyjgz3gxc5y99t9w77r","c5josmiyxofrijgu4tpsiqcahye","ctfpzwwoysjbh5fjikhrt3wpybe","cm9nyefeoxtyjidq8je1bnriobe","ctiipeg948p8fumipgkjattphze"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cidz4imnqhir48brz6e8hxhfrhy","filter":{"filters":[],"operation":"and"},"groupById":"50117d52-bcc7-4750-82aa-831a351c44a0","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["aft5bzo7h9aspqgrx3jpy5tzrer","abrfos7e7eczk9rqw6y5abadm1y","ax8wzbka5ahs3zziji3pp4qp9mc","atabdfbdmjh83136d5e5oysxybw","ace1bzypd586kkyhcht5qqd9eca","aay656c9m1hzwxc9ch5ftymh3nw","a6ghze4iy441qhsh3eijnc8hwze"],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675285313784	1675285313783	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
vsn678k8yking8k5y6tqpxjdt9o	2023-02-01 21:01:53.698735+00	bgi1yqiis8t8xdqxgnet8ebutky	1	view	By Type	{"cardOrder":["ctfpzwwoysjbh5fjikhrt3wpybe","c5josmiyxofrijgu4tpsiqcahye","cm9nyefeoxtyjidq8je1bnriobe","cmdct36nzyjgz3gxc5y99t9w77r","chgbgdr44iif87xim9xgus5sxew","ctiipeg948p8fumipgkjattphze"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cidz4imnqhir48brz6e8hxhfrhy","filter":{"filters":[],"operation":"and"},"groupById":"20717ad3-5741-4416-83f1-6f133fff3d11","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["424ea5e3-9aa1-4075-8c5c-01b44b66e634","a5yxq8rbubrpnoommfwqmty138h","apht1nt5ryukdmxkh6fkfn6rgoy","aiycbuo3dr5k4xxbfr7coem8ono","aomnawq4551cbbzha9gxnmb3z5w"],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675285313802	1675285313802	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
a7yw4ja7bo3b6tpppx859ok4z6y	2023-02-01 21:01:53.698735+00	cdgg5axw99i8g8q19xnb9t8nnre	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675285313818	1675285313818	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
7yz7y1s4ffjgp8dfnndh3z7k9hc	2023-02-01 21:01:53.698735+00	cmdct36nzyjgz3gxc5y99t9w77r	1	image		{"fileId":"7tmfu5iqju3n1mdfwi5gru89qmw.png"}	1675285313824	1675285313824	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
aksc1gc3hrbdyzdpnnykbpyxzje	2023-02-01 21:01:53.698735+00	cmdct36nzyjgz3gxc5y99t9w77r	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675285313829	1675285313829	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
aqtaxszth4fgnbyyob3cnkhpqje	2023-02-01 21:01:53.698735+00	cmdct36nzyjgz3gxc5y99t9w77r	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675285313835	1675285313835	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
7bc46ems95inotfhh8rh6d5pyqy	2023-02-01 21:01:53.698735+00	ctfpzwwoysjbh5fjikhrt3wpybe	1	image		{"fileId":"7b9xk9boj3fbqfm3umeaaizp8qr.png"}	1675285313842	1675285313842	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
aumrq4z8rs7r9uysym3beq3urxr	2023-02-01 21:01:53.698735+00	ctfpzwwoysjbh5fjikhrt3wpybe	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675285313847	1675285313847	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
afj1jneb377baiyqh7owf4p4xic	2023-02-01 21:01:53.698735+00	ctfpzwwoysjbh5fjikhrt3wpybe	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675285313856	1675285313856	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
aqikuktit9pyc9jsffr5x3ijzgh	2023-02-01 21:01:53.698735+00	c5josmiyxofrijgu4tpsiqcahye	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675285313861	1675285313861	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
axrcdmicz5trrbpwxz6js7ae1fh	2023-02-01 21:01:53.698735+00	cfmk7771httynm8r7rm8cbrmrya	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675285313866	1675285313866	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
au9b3t7tafibn7gimjqpbaeagdc	2023-02-01 21:01:53.698735+00	cfmk7771httynm8r7rm8cbrmrya	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675285313871	1675285313871	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
a5bdy74tbejfb7rwfwizxebkxxo	2023-02-01 21:01:53.698735+00	ctiipeg948p8fumipgkjattphze	1	text	## Summary\n*[Brief description of what this epic is about]*\n\n## Motivation\n*[Brief description on why this is needed]*\n\n## Acceptance Criteria\n - *[Criteron 1]*\n - *[Criteron 2]*\n - ...\n\n## Personas\n - *[Persona A]*\n - *[Persona B]*\n - ...\n\n## Reference Materials\n - *[Links to other relevant documents as needed]*\n - ...	{}	1675285313877	1675285313877	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
7hf9aqj6ospge9jo3ej5wsh7muw	2023-02-01 21:01:53.698735+00	cb1n1h1w75jbafqjdd5qi8tzedw	1	image		{"fileId":"7tmfu5iqju3n1mdfwi5gru89qmw.png"}	1675285313883	1675285313883	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
aafxd758zniyexgdfj64cs7coer	2023-02-01 21:01:53.698735+00	cb1n1h1w75jbafqjdd5qi8tzedw	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675285313891	1675285313891	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
ayniuk6nohfyp9cths4anryxd4y	2023-02-01 21:01:53.698735+00	cb1n1h1w75jbafqjdd5qi8tzedw	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675285313896	1675285313896	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
ac8fqo7bpepbdmd9ybzx3i6fpyo	2023-02-01 21:01:53.698735+00	cm9nyefeoxtyjidq8je1bnriobe	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675285313902	1675285313902	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
auwor8ubpaff77pttbw8m61za3w	2023-02-01 21:01:53.698735+00	cwa6utrrkgjb5jyo345wr4wys4o	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675285313920	1675285313920	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
c58p3in8hitgcd8sn874bb8wx1c	2023-02-01 21:01:54.567052+00	brs9cdimfw7fodyi7erqt747rhc	1	card	New Project and Workflow Management Solutions for Developers	{"contentOrder":["71qhnzuec6esdi6fnynwpze4xya","arkandwdsr7rufy5setjep4p18h"],"icon":"🎯","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1645790400000}","ab6mbock6styfe6htf815ph1mhw":["a8xceonxiu4n3c43szhskqizicr","a3pdzi53kpbd4okzdkz6khi87zo","a3d9ux4fmi3anyd11kyipfbhwde"],"ae9ar615xoknd8hw8py7mbyr7zo":"awna1nuarjca99m9s4uiy9kwj5h","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://mattermost.com/newsroom/press-releases/mattermost-launches-new-project-and-workflow-management-solutions-for-developers/","aysx3atqexotgwp5kx6h5i5ancw":"aywiofmmtd3ofgzj95ysky4pjga"}}	1675285314578	1675285314578	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
cqzyozmn73t8wbb36mm5u5w1kuh	2023-02-01 21:01:54.567052+00	brs9cdimfw7fodyi7erqt747rhc	1	card	[Tweet] Mattermost v6.1 includes card @-mention notifications in Boards	{"contentOrder":["7i96m7nbsdsex8n6hzuzrmdfjuy","7ed5bwp3gr8yax3mhtuwiaa9gjy","arug9oegqaift9qee3p3nc5ko9w","aw3uj74yanjrxxgsw6wouuixp8e","abdasiyq4k7ndtfrdadrias8sjy","7pgiwso5hctfwi8wncfpagkyrpa"],"icon":"🐤","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1639051200000}","ab6mbock6styfe6htf815ph1mhw":["az8o8pfe9hq6s7xaehoqyc3wpyc"],"ae9ar615xoknd8hw8py7mbyr7zo":"a9ana1e9w673o5cp8md4xjjwfto","agqsoiipowmnu9rdwxm57zrehtr":"{\\"from\\":1637668800000}","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://twitter.com/Mattermost/status/1463145633162969097?s=20","aysx3atqexotgwp5kx6h5i5ancw":"aj8y675weso8kpb6eceqbpj4ruw"}}	1675285314583	1675285314583	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
cibzpxum8rpbm5nsr7x6jo4gmfc	2023-02-01 21:01:54.567052+00	brs9cdimfw7fodyi7erqt747rhc	1	card	Top 10 Must-Have DevOps Tools in 2021	{"contentOrder":["7fo1utqc8x1z1z6hzg33hes1ktc","ardq3zywcg7dk5cji8n47ws69ja"],"icon":"🛠️","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1636113600000}","ab6mbock6styfe6htf815ph1mhw":["a8xceonxiu4n3c43szhskqizicr"],"ae9ar615xoknd8hw8py7mbyr7zo":"a9ana1e9w673o5cp8md4xjjwfto","agqsoiipowmnu9rdwxm57zrehtr":"{\\"from\\":1637323200000}","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://www.toolbox.com/tech/devops/articles/best-devops-tools/","aysx3atqexotgwp5kx6h5i5ancw":"a3xky7ygn14osr1mokerbfah5cy"}}	1675285314587	1675285314587	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
c533j4aj6xjnexjogofhjiammuy	2023-02-01 21:01:54.567052+00	brs9cdimfw7fodyi7erqt747rhc	1	card	Unblocking Workflows: The Guide to Developer Productivity	{"contentOrder":["77tz16jtz5x73ncs3dxc3fp1d7h","ar5k6gq6hw3gejywmycrzhxhw8e"],"icon":"💻","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1638532800000}","ab6mbock6styfe6htf815ph1mhw":["a3pdzi53kpbd4okzdkz6khi87zo"],"ae9ar615xoknd8hw8py7mbyr7zo":"apy9dcd7zmand615p3h53zjqxjh","agqsoiipowmnu9rdwxm57zrehtr":"{\\"from\\":1639483200000}","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://mattermost.com/newsroom/press-releases/mattermost-unveils-definitive-report-on-the-state-of-developer-productivity-unblocking-workflows-the-guide-to-developer-productivity-2022-edition/","aysx3atqexotgwp5kx6h5i5ancw":"a3xky7ygn14osr1mokerbfah5cy"}}	1675285314593	1675285314593	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
v3hx5az1mbpy3bjeyefs9xc1ube	2023-02-01 21:01:54.567052+00	brs9cdimfw7fodyi7erqt747rhc	1	view	By Status	{"cardOrder":[null,"cdbfkd15d6iy18rgx1tskmfsr6c","cn8yofg9rtkgmzgmb5xdi56p3ic","csgsnnywpuqzs5jgq87snk9x17e","cqwaytore5y487wdu8zffppqnea",null],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["awna1nuarjca99m9s4uiy9kwj5h","a9ana1e9w673o5cp8md4xjjwfto","apy9dcd7zmand615p3h53zjqxjh","acri4cm3bmay55f7ksztphmtnga","amsowcd9a8e1kid317r7ttw6uzh",""],"visiblePropertyIds":["ab6mbock6styfe6htf815ph1mhw"]}	1675285314598	1675285314598	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
vuedb8yqmx3y4px4syyiapgsghe	2023-02-01 21:01:54.567052+00	brs9cdimfw7fodyi7erqt747rhc	1	view	Due Date Calendar	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"a39x5cybshwrbjpc3juaakcyj6e","defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675285314602	1675285314602	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
vme5iffr4gtrqjecc1kb7ff4yac	2023-02-01 21:01:54.567052+00	brs9cdimfw7fodyi7erqt747rhc	1	view	Publication Calendar	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"agqsoiipowmnu9rdwxm57zrehtr","defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675285314609	1675285314609	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
vy191ygom7jdhtpajteynp9unhc	2023-02-01 21:01:54.567052+00	brs9cdimfw7fodyi7erqt747rhc	1	view	Content List	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":322,"ab6mbock6styfe6htf815ph1mhw":229,"aysx3atqexotgwp5kx6h5i5ancw":208},"defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"a39x5cybshwrbjpc3juaakcyj6e","reversed":false}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["ae9ar615xoknd8hw8py7mbyr7zo","aysx3atqexotgwp5kx6h5i5ancw","ab6mbock6styfe6htf815ph1mhw","ao44fz8nf6z6tuj1x31t9yyehcc","a39x5cybshwrbjpc3juaakcyj6e","agqsoiipowmnu9rdwxm57zrehtr","ap4e7kdg7eip7j3c3oyiz39eaoc"]}	1675285314614	1675285314614	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
arkandwdsr7rufy5setjep4p18h	2023-02-01 21:01:54.567052+00	c58p3in8hitgcd8sn874bb8wx1c	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675285314619	1675285314619	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
7pgiwso5hctfwi8wncfpagkyrpa	2023-02-01 21:01:54.567052+00	cqzyozmn73t8wbb36mm5u5w1kuh	1	image		{"fileId":"7y5kr8x8ybpnwdykjfuz57rggrh.png"}	1675285314626	1675285314626	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
arug9oegqaift9qee3p3nc5ko9w	2023-02-01 21:01:54.567052+00	cqzyozmn73t8wbb36mm5u5w1kuh	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675285314634	1675285314634	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
aw3uj74yanjrxxgsw6wouuixp8e	2023-02-01 21:01:54.567052+00	cqzyozmn73t8wbb36mm5u5w1kuh	1	text	## Media	{}	1675285314644	1675285314644	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
aqd8jkextujbz7jfpt5b4jujp5h	2023-02-01 21:01:54.567052+00	cff1jmrxfrirgbeebhr9qd7nida	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675285314655	1675285314655	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
atjdthd87e7b53c3ynx8sh3p37o	2023-02-01 21:01:54.567052+00	cff1jmrxfrirgbeebhr9qd7nida	1	text	## Research\n- ...\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n- ...\n\n## Notes\n- ...\n- ...\n- ...	{}	1675285314658	1675285314658	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
crxzm5uw7qbdoufth4jysrm49fo	2023-02-01 21:01:54.131682+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Olivia Alsop	{"contentOrder":["aocw178uepffgb8urbtmdiqatwe"],"icon":"👩‍💼","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"a7yq89whddzob1futao4rxk3yzc","acjq4t5ymytu8x1f68wkggm7ypc":"olivia.alsop@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1671192000000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"a1sxagjgaadym5yrjak6tcup1oa"}}	1675285314160	1675285314160	0	\N	system		system	bjwjkmputh7dn8mequhmmfrhnba
cfhgcyk97ai8gteoge1gwynmwah	2023-02-01 21:01:54.131682+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Bernadette Powell	{"contentOrder":["ajdc6xc7g9frg8e1ob7foo9ttzc"],"icon":"🧑‍💼","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"af6hjb3ysuaxbwnfqpby4wwnkdr","acjq4t5ymytu8x1f68wkggm7ypc":"bernadette.powell@email.com"}}	1675285314164	1675285314164	0	\N	system		system	bjwjkmputh7dn8mequhmmfrhnba
vejapho6yojbo7b9rsdougexd6e	2023-02-01 21:01:54.131682+00	bh4pkixqsjift58e1qy6htrgeay	1	view	By Date	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"akrxgi7p7w14fym3gbynb98t9fh","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675285314168	1675285314168	0	\N	system		system	bjwjkmputh7dn8mequhmmfrhnba
vac69jd61btdfdchpim3rbeh4hy	2023-02-01 21:01:54.131682+00	bixohg18tt11in4qbtinimk974y	1	view	By Status	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["af6hjb3ysuaxbwnfqpby4wwnkdr","aotxum1p5bw3xuzqz3ctjw66yww","a7yq89whddzob1futao4rxk3yzc","aseqq9hrsua56r3s6nbuirj9eec","ap93ysuzy1xa7z818r6myrn4h4y"],"visiblePropertyIds":[]}	1675285314173	1675285314173	0	\N	system		system	bjwjkmputh7dn8mequhmmfrhnba
ax7ha15c8g3ypjyi6ug4kpt6efr	2023-02-01 21:01:54.131682+00	cse9me1ogppgktyn7q7hrmrdaxa	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1675285314178	1675285314178	0	\N	system		system	bjwjkmputh7dn8mequhmmfrhnba
af9ozxqifk7fztgjns71jpchu3c	2023-02-01 21:01:54.131682+00	cojh3dntq83ymbxx76ne8w9ckpc	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1675285314182	1675285314182	0	\N	system		system	bjwjkmputh7dn8mequhmmfrhnba
acnefwdrtsigyppobztpiobwp1o	2023-02-01 21:01:54.131682+00	ct6cbjq9fkty398pm7i1rggk6pc	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1675285314186	1675285314186	0	\N	system		system	bjwjkmputh7dn8mequhmmfrhnba
aocw178uepffgb8urbtmdiqatwe	2023-02-01 21:01:54.131682+00	crxzm5uw7qbdoufth4jysrm49fo	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1675285314191	1675285314191	0	\N	system		system	bjwjkmputh7dn8mequhmmfrhnba
ajdc6xc7g9frg8e1ob7foo9ttzc	2023-02-01 21:01:54.131682+00	cfhgcyk97ai8gteoge1gwynmwah	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1675285314194	1675285314194	0	\N	system		system	bjwjkmputh7dn8mequhmmfrhnba
v3wkhaifh3frwzm1cij5q4q8rna	2023-02-01 21:01:54.299613+00		1	view	Competitor List	{"cardOrder":["cai9xuy4er78fxyhbgurwzb9rtw","czo8iyi89jtdkxdet7tqkjb6few","cwc8yt8ztp7fuj8sdah4irsimbe","cbr73ap5j5tgo8c61by3cfoi9hw","czq1j6aji77dabmjkujixhc9jxa"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":210,"a1semdhszu1rq17d7et5ydrqqio":121,"aapogff3xoa8ym7xf56s87kysda":194,"ahzspe59iux8wigra8bg6cg18nc":156,"aiefo7nh9jwisn8b4cgakowithy":155,"aozntq4go4nkab688j1s7stqtfc":151,"az3jkw3ynd3mqmart7edypey15e":145},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["ahzspe59iux8wigra8bg6cg18nc","aozntq4go4nkab688j1s7stqtfc","aiefo7nh9jwisn8b4cgakowithy","a6cwaq79b1pdpb97wkanmeyy4er","an1eerzscfxn6awdfajbg41uz3h","a1semdhszu1rq17d7et5ydrqqio","aapogff3xoa8ym7xf56s87kysda","az3jkw3ynd3mqmart7edypey15e"]}	1675285314310	1675285314310	0	\N	system		system	b94e89e4eyib89q8aayocgudx7a
v3sgexeex7bgutce69myoqwqhjr	2023-02-01 21:01:54.299613+00		1	view	Market Position	{"cardOrder":["cip8b4jcomfr7by9gtizebikfke","cacs91js1hb887ds41r6dwnd88c","ca3u8edwrof89i8obxffnz4xw3a"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["arfjpz9by5car71tz3behba8yih","abajmr34b8g1916w495xjb35iko","abt79uxg5edqojsrrefcnr4eruo","aipf3qfgjtkheiayjuxrxbpk9wa"],"visiblePropertyIds":[]}	1675285314315	1675285314315	0	\N	system		system	b94e89e4eyib89q8aayocgudx7a
cai9xuy4er78fxyhbgurwzb9rtw	2023-02-01 21:01:54.299613+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Liminary Corp.	{"contentOrder":["aqcxdcjsca7drun1i1ryqzdt7oo"],"icon":"🌧","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"abt79uxg5edqojsrrefcnr4eruo","a6cwaq79b1pdpb97wkanmeyy4er":"300","ahzspe59iux8wigra8bg6cg18nc":"liminarycorp.com","aiefo7nh9jwisn8b4cgakowithy":"$25,000,000","an1eerzscfxn6awdfajbg41uz3h":"2017","aozntq4go4nkab688j1s7stqtfc":"Toronto, Canada"}}	1675285314320	1675285314320	0	\N	system		system	b94e89e4eyib89q8aayocgudx7a
czo8iyi89jtdkxdet7tqkjb6few	2023-02-01 21:01:54.299613+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Helx Industries	{"contentOrder":["akwuyptb3hjfuzqcymu8kxbfjza"],"icon":"📦","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"abt79uxg5edqojsrrefcnr4eruo","a6cwaq79b1pdpb97wkanmeyy4er":"650","ahzspe59iux8wigra8bg6cg18nc":"helxindustries.com","aiefo7nh9jwisn8b4cgakowithy":"$50,000,000","an1eerzscfxn6awdfajbg41uz3h":"2009","aozntq4go4nkab688j1s7stqtfc":"New York, NY"}}	1675285314325	1675285314325	0	\N	system		system	b94e89e4eyib89q8aayocgudx7a
cwc8yt8ztp7fuj8sdah4irsimbe	2023-02-01 21:01:54.299613+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Kadera Global	{"contentOrder":["as4wqofedst8rpqr8ytark9kh5h"],"icon":"🛡","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"aipf3qfgjtkheiayjuxrxbpk9wa","a6cwaq79b1pdpb97wkanmeyy4er":"150","ahzspe59iux8wigra8bg6cg18nc":"kaderaglobal.com","aiefo7nh9jwisn8b4cgakowithy":"$12,000,000","an1eerzscfxn6awdfajbg41uz3h":"2015","aozntq4go4nkab688j1s7stqtfc":"Seattle, OR"}}	1675285314330	1675285314330	0	\N	system		system	b94e89e4eyib89q8aayocgudx7a
czq1j6aji77dabmjkujixhc9jxa	2023-02-01 21:01:54.299613+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Ositions Inc.	{"contentOrder":["ah3u8wrrqttbmjxz6z1cc434fbc"],"icon":"🌃","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"abajmr34b8g1916w495xjb35iko","a6cwaq79b1pdpb97wkanmeyy4er":"2,700","ahzspe59iux8wigra8bg6cg18nc":"ositionsinc.com","aiefo7nh9jwisn8b4cgakowithy":"$125,000,000","an1eerzscfxn6awdfajbg41uz3h":"2004","aozntq4go4nkab688j1s7stqtfc":"Berlin, Germany"}}	1675285314335	1675285314335	0	\N	system		system	b94e89e4eyib89q8aayocgudx7a
aywxhfdfumby8dre4fw4wdou5ay	2023-02-01 21:01:54.567052+00	cff1jmrxfrirgbeebhr9qd7nida	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675285314663	1675285314663	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
cbr73ap5j5tgo8c61by3cfoi9hw	2023-02-01 21:01:54.299613+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Afformance Ltd.	{"contentOrder":["awp6i5rw353rpmfrksgu3fnhuor"],"icon":"⚡","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"arfjpz9by5car71tz3behba8yih","a6cwaq79b1pdpb97wkanmeyy4er":"1,800","ahzspe59iux8wigra8bg6cg18nc":"afformanceltd.com","aiefo7nh9jwisn8b4cgakowithy":"$200,000,000","an1eerzscfxn6awdfajbg41uz3h":"2002","aozntq4go4nkab688j1s7stqtfc":"Palo Alto, CA"}}	1675285314339	1675285314339	0	\N	system		system	b94e89e4eyib89q8aayocgudx7a
aqcxdcjsca7drun1i1ryqzdt7oo	2023-02-01 21:01:54.299613+00	cai9xuy4er78fxyhbgurwzb9rtw	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1675285314345	1675285314345	0	\N	system		system	b94e89e4eyib89q8aayocgudx7a
akwuyptb3hjfuzqcymu8kxbfjza	2023-02-01 21:01:54.299613+00	czo8iyi89jtdkxdet7tqkjb6few	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1675285314350	1675285314350	0	\N	system		system	b94e89e4eyib89q8aayocgudx7a
as4wqofedst8rpqr8ytark9kh5h	2023-02-01 21:01:54.299613+00	cwc8yt8ztp7fuj8sdah4irsimbe	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1675285314355	1675285314355	0	\N	system		system	b94e89e4eyib89q8aayocgudx7a
ah3u8wrrqttbmjxz6z1cc434fbc	2023-02-01 21:01:54.299613+00	czq1j6aji77dabmjkujixhc9jxa	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n\n## Weaknesses\n- ...\n- ...\n\n## Opportunities\n- ...\n- ...\n\n## Threats\n- ...\n- ...	{}	1675285314361	1675285314361	0	\N	system		system	b94e89e4eyib89q8aayocgudx7a
awp6i5rw353rpmfrksgu3fnhuor	2023-02-01 21:01:54.299613+00	cbr73ap5j5tgo8c61by3cfoi9hw	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1675285314366	1675285314366	0	\N	system		system	b94e89e4eyib89q8aayocgudx7a
ce6f7uy1wc7ny5q755969c9ma3w	2023-02-01 21:01:54.916038+00	bui5izho7dtn77xg3thkiqprc9r	1	card	App crashing	{"contentOrder":["79t7rkiuspeneqi9xurou9tqzwh","abkisg9sqm3yt8j4uc156kuz99h","ac5dmog1ctifxfy54biqxidh4ch","7zmze7z65m7n9ixxpij5ioj89ic"],"icon":"📉","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"1fdbb515-edd2-4af5-80fc-437ed2211a49","50117d52-bcc7-4750-82aa-831a351c44a0":"ec6d2bc5-df2b-4f77-8479-e59ceb039946","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"cb8ecdac-38be-4d36-8712-c4d58cc8a8e9"}}	1675285314927	1675285314927	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
c1c3fs48ig3fa9mtwgsdsm6dzqo	2023-02-01 21:01:54.916038+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Calendar view	{"contentOrder":["7df11783ny67mdnognqae31ax6y","a7ew6ioamjbg3xc5xoe97c7aniw"],"icon":"📆","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"6eea96c9-4c61-4968-8554-4b7537e8f748","50117d52-bcc7-4750-82aa-831a351c44a0":"849766ba-56a5-48d1-886f-21672f415395","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675285314933	1675285314933	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
c3nwo55y5ctn88q8i4xemhdqq5e	2023-02-01 21:01:54.916038+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Standard templates	{"contentOrder":["7uonmjk41nipnrsi6tz8wau5ssh","adm59pmr4si8nbe494mjxssgzmw"],"icon":"🗺️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"6eea96c9-4c61-4968-8554-4b7537e8f748","50117d52-bcc7-4750-82aa-831a351c44a0":"ec6d2bc5-df2b-4f77-8479-e59ceb039946","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675285314939	1675285314939	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
c4rpiqgadu7n6mk89fi9dyy994a	2023-02-01 21:01:54.916038+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Import / Export	{"contentOrder":["aobzs896xwbgkjp4deb816g986e"],"icon":"🚢","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"6eea96c9-4c61-4968-8554-4b7537e8f748","50117d52-bcc7-4750-82aa-831a351c44a0":"ec6d2bc5-df2b-4f77-8479-e59ceb039946","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675285314945	1675285314945	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
ct7jahzpysjb4pbhxi58spwdtxh	2023-02-01 21:01:54.916038+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Review API design	{"contentOrder":["abmhnzpwuk38wurwejgb68866ha"],"icon":"🛣️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"424ea5e3-9aa1-4075-8c5c-01b44b66e634","50117d52-bcc7-4750-82aa-831a351c44a0":"8c557f69-b0ed-46ec-83a3-8efab9d47ef5","60985f46-3e41-486e-8213-2b987440ea1c":"14892380-1a32-42dd-8034-a0cea32bc7e6","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"c62172ea-5da7-4dec-8186-37267d8ee9a7"}}	1675285314951	1675285314951	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
75134sysbt7dmbric3ygi8is36r	2023-02-01 21:01:55.312436+00	cukpzn8sxhtbn3krci16sa3saka	1	checkbox	Create and manage checklists, like this one... :)	{"value":false}	1675285315399	1675285315398	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
ardq3zywcg7dk5cji8n47ws69ja	2023-02-01 21:01:54.567052+00	cibzpxum8rpbm5nsr7x6jo4gmfc	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675285314668	1675285314668	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
ar5k6gq6hw3gejywmycrzhxhw8e	2023-02-01 21:01:54.567052+00	c533j4aj6xjnexjogofhjiammuy	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675285314674	1675285314674	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
vhbxi8kf817g8xrau13ggicim4r	2023-02-01 21:01:54.819555+00	bjbhs6bos3m8zjouf78xceg9nqw	1	view	Board view	{"cardOrder":["cniwb8xwcqtbstbcm3sdfrr854h","cs4qwpzr65fgttd7364dicskanh","c9s78pzbdg3g4jkcdjqahtnfejc","c8utmazns878jtfgtf7exyi9pee","cnobejmb6bf8e3c1w7em5z4pwyh"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["aok6pgecm85qe9k5kcphzoe63ma","aq1dwbf661yx337hjcd5q3sbxwa","ar87yh5xmsswqkxmjq1ipfftfpc","akj3fkmxq7idma55mdt8sqpumyw"],"visiblePropertyIds":["aspaay76a5wrnuhtqgm97tt3rer"]}	1675285314827	1675285314827	0	\N	system		system	bydniqgzqq3bwm8kw55a67d93oo
cj5oa77pxgbf5t8ixsbj7gcznfw	2023-02-01 21:01:54.819555+00	bsjd59qtpbf888mqez3ge77domw	1	card	Tight deadline	{"contentOrder":[],"icon":"📅","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"ar87yh5xmsswqkxmjq1ipfftfpc"}}	1675285314831	1675285314831	0	\N	system		system	bydniqgzqq3bwm8kw55a67d93oo
c9nskf1atnffypg4rmejpbksn8a	2023-02-01 21:01:54.819555+00	bsjd59qtpbf888mqez3ge77domw	1	card	Team communication	{"contentOrder":[],"icon":"💬","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"aq1dwbf661yx337hjcd5q3sbxwa"}}	1675285314835	1675285314835	0	\N	system		system	bydniqgzqq3bwm8kw55a67d93oo
cxghiu5yzifbz78b5x5h173maby	2023-02-01 21:01:54.819555+00	bsjd59qtpbf888mqez3ge77domw	1	card	Reschedule planning meeting	{"contentOrder":[],"icon":"🗓️","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"aok6pgecm85qe9k5kcphzoe63ma"}}	1675285314840	1675285314840	0	\N	system		system	bydniqgzqq3bwm8kw55a67d93oo
cyjzct66ekp8auxspki7fq9bkoo	2023-02-01 21:01:54.819555+00	bsjd59qtpbf888mqez3ge77domw	1	card	Schedule more time for testing	{"contentOrder":[],"icon":"🧪","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"akj3fkmxq7idma55mdt8sqpumyw"}}	1675285314845	1675285314845	0	\N	system		system	bydniqgzqq3bwm8kw55a67d93oo
cdaccq8mwni86781868m9drfsse	2023-02-01 21:01:54.819555+00	bsjd59qtpbf888mqez3ge77domw	1	card	Positive user feedback	{"contentOrder":[],"icon":"🥰","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"aq1dwbf661yx337hjcd5q3sbxwa"}}	1675285314848	1675285314848	0	\N	system		system	bydniqgzqq3bwm8kw55a67d93oo
cqwxtbrobujg58gqcfamejkhxkw	2023-02-01 21:01:54.916038+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Icons don't display	{"contentOrder":["agrw435r3yjdtpremce3r6d4dfr","akxzotnktgib9tbk3j6uyix4udy","7f96e5xpuf38xfc6bqzwimgxoje"],"icon":"💻","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"1fdbb515-edd2-4af5-80fc-437ed2211a49","50117d52-bcc7-4750-82aa-831a351c44a0":"8c557f69-b0ed-46ec-83a3-8efab9d47ef5","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675285314961	1675285314961	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
vfue7aio66jfmb8ugywp3rg95ie	2023-02-01 21:01:54.916038+00	bui5izho7dtn77xg3thkiqprc9r	1	view	Calendar View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"a4378omyhmgj3bex13sj4wbpfiy","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675285314966	1675285314966	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
vhj7ro9auobdpmn5r86tmdj4aka	2023-02-01 21:01:54.916038+00	bui5izho7dtn77xg3thkiqprc9r	1	view	Board: Sprints	{"cardOrder":["ce6f7uy1wc7ny5q755969c9ma3w","c1c3fs48ig3fa9mtwgsdsm6dzqo","c3nwo55y5ctn88q8i4xemhdqq5e","cqwxtbrobujg58gqcfamejkhxkw","c4rpiqgadu7n6mk89fi9dyy994a","ct7jahzpysjb4pbhxi58spwdtxh"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"60985f46-3e41-486e-8213-2b987440ea1c","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["c01676ca-babf-4534-8be5-cce2287daa6c","ed4a5340-460d-461b-8838-2c56e8ee59fe","14892380-1a32-42dd-8034-a0cea32bc7e6",""],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675285314972	1675285314972	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
vwm7pdf949if38dofbpybe65e5a	2023-02-01 21:01:54.916038+00	bui5izho7dtn77xg3thkiqprc9r	1	view	List: Tasks 🔨	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"50117d52-bcc7-4750-82aa-831a351c44a0":139,"__title":280},"defaultTemplateId":"","filter":{"filters":[{"condition":"includes","propertyId":"20717ad3-5741-4416-83f1-6f133fff3d11","values":["6eea96c9-4c61-4968-8554-4b7537e8f748"]}],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"50117d52-bcc7-4750-82aa-831a351c44a0","reversed":true}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["50117d52-bcc7-4750-82aa-831a351c44a0","20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675285314979	1675285314979	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
vfutrxwzyjirpbnxwepo9kphtwc	2023-02-01 21:01:54.916038+00	bui5izho7dtn77xg3thkiqprc9r	1	view	Board: Status	{"cardOrder":["ce6f7uy1wc7ny5q755969c9ma3w","cm4w7cc3aac6s9jdcujbs4j8f4r","c6egh6cpnj137ixdoitsoxq17oo","cct9u78utsdyotmejbmwwg66ihr","cmft87it1q7yebbd51ij9k65xbw","c9fe77j9qcruxf4itzib7ag6f1c","coup7afjknqnzbdwghiwbsq541w","c5ex1hndz8qyc8gx6ofbfeksftc"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cidz4imnqhir48brz6e8hxhfrhy","filter":{"filters":[],"operation":"and"},"groupById":"50117d52-bcc7-4750-82aa-831a351c44a0","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["8c557f69-b0ed-46ec-83a3-8efab9d47ef5","ec6d2bc5-df2b-4f77-8479-e59ceb039946","849766ba-56a5-48d1-886f-21672f415395",""],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675285314985	1675285314985	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
ay8xkm18ujtbiin6kekgwtw8zoe	2023-02-01 21:01:54.916038+00	cwrq9ag3p5pgzzy98nfd3wwra1w	1	text	## Summary\n*[Brief description of what this epic is about]*\n## Motivation\n*[Brief description on why this is needed]*\n## Acceptance Criteria\n- *[Criteron 1]*\n- *[Criteron 2]*\n- ...\n## Personas\n- *[Persona A]*\n- *[Persona B]*\n- ...\n## Reference Materials\n- *[Links to other relevant documents as needed]*\n- ...	{}	1675285315078	1675285315078	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
vjyngn6i9gbgeuchcpdbmsqjp9o	2023-02-01 21:01:54.916038+00	bui5izho7dtn77xg3thkiqprc9r	1	view	List: Bugs 🐞	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"50117d52-bcc7-4750-82aa-831a351c44a0":145,"__title":280},"defaultTemplateId":"","filter":{"filters":[{"condition":"includes","propertyId":"20717ad3-5741-4416-83f1-6f133fff3d11","values":["1fdbb515-edd2-4af5-80fc-437ed2211a49"]}],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["50117d52-bcc7-4750-82aa-831a351c44a0","20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675285314990	1675285314990	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
7zmze7z65m7n9ixxpij5ioj89ic	2023-02-01 21:01:54.916038+00	ce6f7uy1wc7ny5q755969c9ma3w	1	image		{"fileId":"77pe9r4ckbin438ph3f18bpatua.png"}	1675285314995	1675285314995	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
abkisg9sqm3yt8j4uc156kuz99h	2023-02-01 21:01:54.916038+00	ce6f7uy1wc7ny5q755969c9ma3w	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675285314999	1675285314999	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
ac5dmog1ctifxfy54biqxidh4ch	2023-02-01 21:01:54.916038+00	ce6f7uy1wc7ny5q755969c9ma3w	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675285315004	1675285315004	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
a7ew6ioamjbg3xc5xoe97c7aniw	2023-02-01 21:01:54.916038+00	c1c3fs48ig3fa9mtwgsdsm6dzqo	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675285315009	1675285315009	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
adm59pmr4si8nbe494mjxssgzmw	2023-02-01 21:01:54.916038+00	c3nwo55y5ctn88q8i4xemhdqq5e	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675285315016	1675285315016	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
79ghy66qyxffh9eyp3ue1zdaicy	2023-02-01 21:01:54.916038+00	cfefgwjke6bbxpjpig618g9bpte	1	image		{"fileId":"7pbp4qg415pbstc6enzeicnu3qh.png"}	1675285315021	1675285315021	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
agdiwm9hoofdp7e7pz5186zo67w	2023-02-01 21:01:54.916038+00	cfefgwjke6bbxpjpig618g9bpte	1	text	## Screenshots\nIf applicable, add screenshots to elaborate on the problem.	{}	1675285315027	1675285315027	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
7tqu6wtfqstrhxgse8suphmu91h	2023-02-01 21:01:55.312436+00	cukpzn8sxhtbn3krci16sa3saka	1	checkbox	Add and update descriptions with Markdown	{"value":false}	1675285315404	1675285315404	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
7ywwms93ojir75rwfectqgac44y	2023-02-01 21:01:55.312436+00	cukpzn8sxhtbn3krci16sa3saka	1	checkbox	Follow cards to get notified on the latest updates	{"value":false}	1675285315410	1675285315410	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
aqfz3whzxztd97psx5wi43xumxa	2023-02-01 21:01:54.916038+00	cfefgwjke6bbxpjpig618g9bpte	1	text	## Steps to reproduce the behavior\n\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n\nA clear and concise description of what you expected to happen.\n\n## Edition and Platform\n\n - Edition: Personal Desktop / Personal Server / Mattermost plugin\n - Version: [e.g. v0.9.0]\n - Browser and OS: [e.g. Chrome 91 on macOS, Edge 93 on Windows]\n\n## Additional context\n\nAdd any other context about the problem here.	{}	1675285315031	1675285315031	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
asftpr5xph78ntda9z7udnngbiw	2023-02-01 21:01:54.916038+00	cfefgwjke6bbxpjpig618g9bpte	1	text	## Steps to reproduce the behavior\n\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n\n*[A clear and concise description of what you expected to happen.]*\n\n## Screenshots\n\n*[If applicable, add screenshots to elaborate on the problem.]*\n\n## Edition and Platform\n\n - Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n - Version: *[e.g. v0.9.0]*\n - Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n\n*[Add any other context about the problem here.]*	{}	1675285315036	1675285315036	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
aobzs896xwbgkjp4deb816g986e	2023-02-01 21:01:54.916038+00	c4rpiqgadu7n6mk89fi9dyy994a	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675285315040	1675285315040	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
a8g5ygo39tpfe8gnqe5i47dsgna	2023-02-01 21:01:54.916038+00	cidz4imnqhir48brz6e8hxhfrhy	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675285315046	1675285315045	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
a8hyt5eqep7fwfcwhbsnuu3pgxa	2023-02-01 21:01:54.916038+00	cidz4imnqhir48brz6e8hxhfrhy	1	text	## Requirements\n- [Requirement 1]\n- [Requirement 2]\n- ...	{}	1675285315050	1675285315050	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
abmhnzpwuk38wurwejgb68866ha	2023-02-01 21:01:54.916038+00	ct7jahzpysjb4pbhxi58spwdtxh	1	text	## Summary\n*[Brief description of what this epic is about]*\n\n## Motivation\n*[Brief description on why this is needed]*\n\n## Acceptance Criteria\n - *[Criteron 1]*\n - *[Criteron 2]*\n - ...\n\n## Personas\n - *[Persona A]*\n - *[Persona B]*\n - ...\n\n## Reference Materials\n - *[Links to other relevant documents as needed]*\n - ...	{}	1675285315056	1675285315056	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
7f96e5xpuf38xfc6bqzwimgxoje	2023-02-01 21:01:54.916038+00	cqwxtbrobujg58gqcfamejkhxkw	1	image		{"fileId":"7pbp4qg415pbstc6enzeicnu3qh.png"}	1675285315061	1675285315061	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
akxzotnktgib9tbk3j6uyix4udy	2023-02-01 21:01:54.916038+00	cqwxtbrobujg58gqcfamejkhxkw	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675285315067	1675285315067	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
agrw435r3yjdtpremce3r6d4dfr	2023-02-01 21:01:54.916038+00	cqwxtbrobujg58gqcfamejkhxkw	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675285315072	1675285315072	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
azzr1yefgz7nimd47c5opf41qqc	2023-02-01 21:01:55.312436+00	coe9fht9rx7fa8ngd7s6wscbi6y	1	text	After you've copied the link, paste it into any channel or Direct Message to share the card. A preview of the card will display within the channel with a link back to the card on Boards.	{}	1675285315486	1675285315486	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
a4mc7zebjw3dgi8has51fpr5djr	2023-02-01 21:01:54.916038+00	cwrq9ag3p5pgzzy98nfd3wwra1w	1	text	## Summary\n[Brief description of what this epic is about]\n\n## Motivation\n[Brief description on why this is needed]\n\n## Acceptance Criteria\n - [Criteron 1]\n - [Criteron 2]\n - ...\n\n## Personas\n - [Persona A]\n - [Persona B]\n - ...\n\n## Reference Materials\n - [Links to other relevant documents as needed]\n - ...	{}	1675285315083	1675285315083	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
cu1ggrzabwpg17jwh9pbf6uhirc	2023-02-01 21:01:55.312436+00	buixxjic3xjfkieees4iafdrznc	1	card	Drag cards	{"contentOrder":["apktbgtee5jb8xrnqy3ibiujxew","ahpy4kassrbfrj8yxemrh4179pw"],"icon":"🤏","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#dragging-cards","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1675285315319	1675285315319	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
cukpzn8sxhtbn3krci16sa3saka	2023-02-01 21:01:55.312436+00	buixxjic3xjfkieees4iafdrznc	1	card	Manage tasks with cards	{"contentOrder":["ay3fyzpqpz7ygm8giqut139rwiw","7fdsxg4gpa3ycxqzg9omc7osoko","7ma1kot1hipng7pkr8jadcu8dwy","784uu3ufcgb878ky7hyugmf6xcw","71be7uuu8h7rbpeyf91dk34xdgy","7tqu6wtfqstrhxgse8suphmu91h","7hh5okxxowp8gidkf7d1njimuye","7nb8y7jyoetro8cd36qcju53z8c","7ywwms93ojir75rwfectqgac44y","7h1eoa56ahin588rggnxxz6b9bo","76nwb9tqfsid5jx46yw34itqima","7dy3mcgzgybf1ifa3emgewkzj7e","a5ca6tii33bfw8ba36y1rswq3he","7876od6xhffr6fy69zeogag7eyw","7x7bq9awkatbm5x4docbh5gaw4y","7ghpx9qff43dgtke1rwidmge1ho","7nb8y7jyoetro8cd36qcju53z8c","7hdyxemhbytfm3m83g88djq9nhr","7pgnejxokubbe9kdrxj6g9qa41e","7hw9z6qtx8jyizkmm9g5yq3gxcy","7gk6ooz6npbb8by5rgp9aig7tua","75134sysbt7dmbric3ygi8is36r"],"icon":"☑️","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"amm6wfhnbuxojwssyftgs9dipqe","acypkejeb5yfujhj9te57p9kaxw":"aanaehcw3m13jytujsjk5hpf6ry"}}	1675285315323	1675285315323	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
c9hy3rkeymprhbro69c9zqyo5re	2023-02-01 21:01:55.312436+00	buixxjic3xjfkieees4iafdrznc	1	card	Create your own board	{"contentOrder":["ao563bjzunpygtm3ykszf51f6oy","ag4u173nywprbixwwuh9i6m88pc","7r9my1yuddbn45dojrfht3neg8c","7eir5gdjxgjbsxpbyp3df4npcze","7gzrme78yx7nejxpphbzroq5ddc"],"icon":"📋","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#adding-new-boards","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"amm6wfhnbuxojwssyftgs9dipqe","acypkejeb5yfujhj9te57p9kaxw":"aanaehcw3m13jytujsjk5hpf6ry"}}	1675285315328	1675285315328	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
7fdsxg4gpa3ycxqzg9omc7osoko	2023-02-01 21:01:55.312436+00	cukpzn8sxhtbn3krci16sa3saka	1	checkbox	Set priorities and update statuses	{"value":false}	1675285315416	1675285315416	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
7hh5okxxowp8gidkf7d1njimuye	2023-02-01 21:01:55.312436+00	cukpzn8sxhtbn3krci16sa3saka	1	checkbox	Provide feedback and ask questions via comments	{"value":false}	1675285315422	1675285315422	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
cq75jez4drp84jpbktqbx8ko7se	2023-02-01 21:01:55.312436+00	buixxjic3xjfkieees4iafdrznc	1	card	Share a board	{"contentOrder":["ax34fardyitn67deep8dgummjte","abbz61swbufbf88jsjhs6nqh8dc","7r7asyew8d7fyunf4sow8e5iyoc","ad8j3n8tp77bppee3ipjt6odgpe","7w935usqt6pby8qz9x5pxaj7iow","7ogbs8h6q4j8z7ngy1m7eag63nw","7z1jau5qy3jfcxdp5cgq3duk6ne","747noxpdrhpbyigsoyr48rg3bwc"],"icon":"📤","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/sharing-boards.html","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1675285315332	1675285315332	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
czd377jwygtr57nqgpkmhzwyf1h	2023-02-01 21:01:55.312436+00	buixxjic3xjfkieees4iafdrznc	1	card	Create a new card	{"contentOrder":["a9xbubn9xmpd63c9ej3zf8my9wr","adhsx4h5ss7rqdcjt8xyam6xtqc","aa1i7uq4nffg1fxk9f85uirj9we","7me9p46gbqiyfmfnapi7dyxb5br","7647wzwdcbpdrujuhmg3btgwipo"],"icon":"📝","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#adding-cards","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"amm6wfhnbuxojwssyftgs9dipqe","acypkejeb5yfujhj9te57p9kaxw":"aanaehcw3m13jytujsjk5hpf6ry"}}	1675285315337	1675285315337	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
coe9fht9rx7fa8ngd7s6wscbi6y	2023-02-01 21:01:55.312436+00	buixxjic3xjfkieees4iafdrznc	1	card	Share cards on Channels	{"contentOrder":["anf18mxnxtjfyfgn4uwa4d3k9ma","a6wpf9kwx7tdebdtdp5eotohyza","azzr1yefgz7nimd47c5opf41qqc","7wajetc4u1tyajrwc1wobwufcih"],"icon":"📮","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html#share-card-previews","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"af3p8ztcyxgn8wd9z4az7o9tjeh","acypkejeb5yfujhj9te57p9kaxw":"ascd7nm9r491ayot8i86g1gmgqw"}}	1675285315341	1675285315341	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
ckinu9rtwafdi8y6izc6qg74k7w	2023-02-01 21:01:55.312436+00	buixxjic3xjfkieees4iafdrznc	1	card	Filter and sort cards	{"contentOrder":["a4fz9kcfs9ibj8puk9mux7ac94c","axai7yjih6jy4mekcdjdzxw94pr","78i8aqjmqtibr7x4okhz6uqquqr","77mm4c6cug7dp5jg4w9snhkaqth"],"icon":"🎛️","isTemplate":false,"properties":{"a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1675285315346	1675285315346	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
cwbgwt8w9r3fpm8metpb9c4zrpc	2023-02-01 21:01:55.312436+00	buixxjic3xjfkieees4iafdrznc	1	card	Create a new view	{"contentOrder":["aozbezukpgif3jpbsq7tahmmp5e","asksigkxeu7gstp5yduaokrgm9c","7owai1ux3h3gtf8byynfk6hyx1c","7n8jq1dizyfgotby3o91arf1hxh","77y4wffj1ctg7xmm9bx45qn6q6o","7d1hxfztimpn6uj4d3rpd5uiydr"],"icon":"👓","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#adding-new-views","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"af3p8ztcyxgn8wd9z4az7o9tjeh","acypkejeb5yfujhj9te57p9kaxw":"ascd7nm9r491ayot8i86g1gmgqw"}}	1675285315350	1675285315350	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
c5rqxuzrn9tf99ghn6srapgt8jr	2023-02-01 21:01:55.312436+00	buixxjic3xjfkieees4iafdrznc	1	card	Add new properties	{"contentOrder":["adtuhtdxccinoibzo61wirrf5kr","ayhk11qsuz789fk8bqae4oz8mro","7gc3z8cf8rirgfyutwoke9nn6jy","76cinqnb6k3dzmfbm9fnc8eofny","7uujbdoffb3n3tfjjdc5xg8emeh"],"icon":"🏷️","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html#add-and-manage-properties","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"af3p8ztcyxgn8wd9z4az7o9tjeh","acypkejeb5yfujhj9te57p9kaxw":"ascd7nm9r491ayot8i86g1gmgqw"}}	1675285315354	1675285315354	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
cpu8f4mkqjty9my48uqu3rqtqqw	2023-02-01 21:01:55.312436+00	buixxjic3xjfkieees4iafdrznc	1	card	@mention teammates	{"contentOrder":["azmczx5rmzi8kmc6ngamkmb7cmy","adakjec8bwfyo7pud3ch3qxowxh","7mbw9t71hjbrydgzgkqqaoh8usr","7tn48dj54ef8w7kqbzo93t4drbo"],"icon":"🔔","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html#mention-people","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1675285315360	1675285315360	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
vkt3i1hoqxfdb5merjssupsyyac	2023-02-01 21:01:55.312436+00	buixxjic3xjfkieees4iafdrznc	1	view	Preview: Table View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":280,"a972dc7a-5f4c-45d2-8044-8c28c69717f1":100,"acypkejeb5yfujhj9te57p9kaxw":169},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a972dc7a-5f4c-45d2-8044-8c28c69717f1","aqh13jabwexjkzr3jqsz1i1syew","acmg7mz1rr1eykfug4hcdpb1y1o","acypkejeb5yfujhj9te57p9kaxw"]}	1675285315365	1675285315364	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
v84pptna67jb9trghufkd83gdxa	2023-02-01 21:01:55.312436+00	buixxjic3xjfkieees4iafdrznc	1	view	Preview: Calendar View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"acmg7mz1rr1eykfug4hcdpb1y1o","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675285315370	1675285315370	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
vpc6da4cio7yoddbbedwcojykyh	2023-02-01 21:01:55.312436+00	buixxjic3xjfkieees4iafdrznc	1	view	Preview: Gallery View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"gallery","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675285315378	1675285315378	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
vurut55y7sjyuumy5gbiwrt5bph	2023-02-01 21:01:55.312436+00	buixxjic3xjfkieees4iafdrznc	1	view	Onboarding	{"cardOrder":["czd377jwygtr57nqgpkmhzwyf1h","cukpzn8sxhtbn3krci16sa3saka","c9hy3rkeymprhbro69c9zqyo5re","coe9fht9rx7fa8ngd7s6wscbi6y","c5rqxuzrn9tf99ghn6srapgt8jr","cwbgwt8w9r3fpm8metpb9c4zrpc","cpu8f4mkqjty9my48uqu3rqtqqw","cu1ggrzabwpg17jwh9pbf6uhirc","cq75jez4drp84jpbktqbx8ko7se","ckinu9rtwafdi8y6izc6qg74k7w"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a972dc7a-5f4c-45d2-8044-8c28c69717f1","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["aqb5x3pt87dcc9stbk4ofodrpoy","a1mtm777bkagq3iuu7xo9b13qfr","auxbwzptiqzkii5r61uz3ndsy1r","aj9386k1bx8qwmepeuxg3b7z4pw"],"visiblePropertyIds":[]}	1675285315383	1675285315383	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
ahpy4kassrbfrj8yxemrh4179pw	2023-02-01 21:01:55.312436+00	cu1ggrzabwpg17jwh9pbf6uhirc	1	text	Mattermost Boards makes it easy for you to update certain properties on cards through our drag and drop functionality. Simply drag this card from the **Later** column to the **Completed** column to automatically update the status and mark this task as complete.	{}	1675285315388	1675285315388	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
71be7uuu8h7rbpeyf91dk34xdgy	2023-02-01 21:01:55.312436+00	cukpzn8sxhtbn3krci16sa3saka	1	checkbox	Assign tasks to teammates	{"value":false}	1675285315394	1675285315394	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
7h1eoa56ahin588rggnxxz6b9bo	2023-02-01 21:01:55.312436+00	cukpzn8sxhtbn3krci16sa3saka	1	checkbox	@mention teammates so they can follow, and collaborate on, comments and descriptions	{"value":false}	1675285315430	1675285315430	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
7ma1kot1hipng7pkr8jadcu8dwy	2023-02-01 21:01:55.312436+00	cukpzn8sxhtbn3krci16sa3saka	1	checkbox	Manage deadlines and milestones	{"value":false}	1675285315435	1675285315435	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
ay3fyzpqpz7ygm8giqut139rwiw	2023-02-01 21:01:55.312436+00	cukpzn8sxhtbn3krci16sa3saka	1	text	Cards allow your entire team to manage and collaborate on a task in one place. Within a card, your team can:	{}	1675285315440	1675285315440	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
7gzrme78yx7nejxpphbzroq5ddc	2023-02-01 21:01:55.312436+00	c9hy3rkeymprhbro69c9zqyo5re	1	image		{"fileId":"74uia99m9btr8peydw7oexn37tw.gif"}	1675285315446	1675285315446	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
ao563bjzunpygtm3ykszf51f6oy	2023-02-01 21:01:55.312436+00	c9hy3rkeymprhbro69c9zqyo5re	1	text	A board helps you manage your project, organize tasks, and collaborate with your team all in one place.	{}	1675285315450	1675285315450	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
ag4u173nywprbixwwuh9i6m88pc	2023-02-01 21:01:55.312436+00	c9hy3rkeymprhbro69c9zqyo5re	1	text	To create your own board, select the "+" on the top of the left hand sidebar. Choose from one of our standard templates and see how they can help you get started with your next project:\n\n- **Project Tasks**: Stay on top of your project tasks, track progress, and set priorities. \n- **Meeting Agenda**: Set your meeting agendas for recurring team meetings and 1:1s.\n- **Roadmap**: Plan your roadmap and manage your releases more efficiently.\n- **Personal Tasks**: Organize your life and track your personal tasks.\n- **Content Calendar**: Plan your editorial content, assign work, and track deadlines.\n- **Personal Goals**: Set and accomplish new personal goals and milestones.	{}	1675285315453	1675285315453	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
747noxpdrhpbyigsoyr48rg3bwc	2023-02-01 21:01:55.312436+00	cq75jez4drp84jpbktqbx8ko7se	1	image		{"fileId":"7knxbyuiedtdafcgmropgkrtybr.gif"}	1675285315456	1675285315456	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
ax34fardyitn67deep8dgummjte	2023-02-01 21:01:55.312436+00	cq75jez4drp84jpbktqbx8ko7se	1	text	Keep stakeholders and customers up-to-date on project progress by sharing your board.	{}	1675285315459	1675285315459	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
abbz61swbufbf88jsjhs6nqh8dc	2023-02-01 21:01:55.312436+00	cq75jez4drp84jpbktqbx8ko7se	1	text	To share a board, select **Share** at the top right of the Board view. Copy the link to share the board internally with your team or generate public link that can be accessed by anyone externally.	{}	1675285315464	1675285315464	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
7647wzwdcbpdrujuhmg3btgwipo	2023-02-01 21:01:55.312436+00	czd377jwygtr57nqgpkmhzwyf1h	1	image		{"fileId":"7iw4rxx7jj7bypmdotd9z469cyh.png"}	1675285315468	1675285315468	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
aa1i7uq4nffg1fxk9f85uirj9we	2023-02-01 21:01:55.312436+00	czd377jwygtr57nqgpkmhzwyf1h	1	text	To create a new card, simply do any of the following:\n- Select "**New**" on the top right header\n- Select "**+ New**" below any column\n- Select "**+**" to the right of any columnn header	{}	1675285315473	1675285315473	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
a9xbubn9xmpd63c9ej3zf8my9wr	2023-02-01 21:01:55.312436+00	czd377jwygtr57nqgpkmhzwyf1h	1	text	Mattermost Boards helps you manage and track all your project tasks with **Cards**.	{}	1675285315477	1675285315477	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
7wajetc4u1tyajrwc1wobwufcih	2023-02-01 21:01:55.312436+00	coe9fht9rx7fa8ngd7s6wscbi6y	1	image		{"fileId":"7ek6wbpp19jfoujs1goh6kttbby.gif"}	1675285315482	1675285315482	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
a6wpf9kwx7tdebdtdp5eotohyza	2023-02-01 21:01:55.312436+00	coe9fht9rx7fa8ngd7s6wscbi6y	1	text	To share a card, you'll need to copy the card link first. You can:\n\n- Open a card and select the options menu button at the top right of the card.\n- Open the board view and hover your mouse over any card to access the options menu button.	{}	1675285315493	1675285315493	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
anf18mxnxtjfyfgn4uwa4d3k9ma	2023-02-01 21:01:55.312436+00	coe9fht9rx7fa8ngd7s6wscbi6y	1	text	Cards can be linked and shared with teammates directly on Channels. Card previews are displayed when shared on Channels, so your team can discuss work items and get the relevant context without having to switch over to Boards.	{}	1675285315499	1675285315499	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
77mm4c6cug7dp5jg4w9snhkaqth	2023-02-01 21:01:55.312436+00	ckinu9rtwafdi8y6izc6qg74k7w	1	image		{"fileId":"7dybb6t8fj3nrdft7nerhuf784y.png"}	1675285315505	1675285315505	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
axai7yjih6jy4mekcdjdzxw94pr	2023-02-01 21:01:55.312436+00	ckinu9rtwafdi8y6izc6qg74k7w	1	text	Organize and find the cards you're looking for with our filter, sort, and grouping options. From the Board header, you can quickly toggle on different properties, change the group display, set filters, and change how the cards are sorted.	{}	1675285315522	1675285315522	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
7d1hxfztimpn6uj4d3rpd5uiydr	2023-02-01 21:01:55.312436+00	cwbgwt8w9r3fpm8metpb9c4zrpc	1	image		{"fileId":"78jws5m1myf8pufewzkaa6i11sc.gif"}	1675285315528	1675285315528	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
asksigkxeu7gstp5yduaokrgm9c	2023-02-01 21:01:55.312436+00	cwbgwt8w9r3fpm8metpb9c4zrpc	1	text	Views allow your team to visualize the same cards and data from different perspectives, so they can stay up-to-date in the way that works best for them. To add a new view, go to **Add a new view** from the view drop-down, then select from any of the following views:\n\n- **Board**: Adds a Kanban board, similar to this one, that allows your team to organize cards in swimlanes grouped by any property of your choosing. This view helps you visualize your project progress.\n- **Table**: Displays cards in a table format with rows and columns. Use this view to get an overview of all your project tasks. Easily view and compare the state of all properties across all cards without needing to open individual cards.\n- **Gallery**: Displays cards in a gallery format, so you can manage and organize cards with image attachments.\n- **Calendar**: Adds a calendar view to easily visualize your cards by dates and keep track of deadlines.	{}	1675285315533	1675285315533	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
7uujbdoffb3n3tfjjdc5xg8emeh	2023-02-01 21:01:55.312436+00	c5rqxuzrn9tf99ghn6srapgt8jr	1	image		{"fileId":"7d6hrtig3zt8f9cnbo1um5oxx3y.gif"}	1675285315539	1675285315539	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
adtuhtdxccinoibzo61wirrf5kr	2023-02-01 21:01:55.312436+00	c5rqxuzrn9tf99ghn6srapgt8jr	1	text	Customize cards to fit your needs and track the information most important to you. Boards supports a wide range of fully customizable property types. For example, you can:\n- Use the **Date** property for things like deadlines or milestones.\n- Assign owners to tasks with the **Person** property.\n- Define statuses and priorities with the **Select** property.\n- Create tags with the **Multi Select** property.\n- Link cards to webpages with the **URL** property.	{}	1675285315545	1675285315545	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
7tn48dj54ef8w7kqbzo93t4drbo	2023-02-01 21:01:55.312436+00	cpu8f4mkqjty9my48uqu3rqtqqw	1	image		{"fileId":"74nt9eqzea3ydjjpgjtsxcjgrxc.gif"}	1675285315550	1675285315550	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
adakjec8bwfyo7pud3ch3qxowxh	2023-02-01 21:01:55.312436+00	cpu8f4mkqjty9my48uqu3rqtqqw	1	text	To mention a teammate use the **@ symbol with their username** in the comments or description section. They'll get a Direct Message notification via Channels and also be added as a [follower](https://docs.mattermost.com/boards/work-with-cards.html#receive-updates) to the card. \n\nWhenever any changes are made to the card, they'll automatically get notified on Channels.	{}	1675285315556	1675285315556	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
azmczx5rmzi8kmc6ngamkmb7cmy	2023-02-01 21:01:55.312436+00	cpu8f4mkqjty9my48uqu3rqtqqw	1	text	Collaborate with teammates directly on each card using @mentions and have all the relevant context in one place.	{}	1675285315562	1675285315562	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
\.


--
-- Data for Name: focalboard_blocks_history; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_blocks_history (id, insert_at, parent_id, schema, type, title, fields, create_at, update_at, delete_at, root_id, modified_by, channel_id, created_by, board_id) FROM stdin;
c3w9in6qnttf4zd3om9yf95upiy	2023-02-01 21:01:50.459085+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Team Schedule	{"contentOrder":["abgi5ubibkjgc9d3h3xp6dggajr","7pjcbsmde9pfa9cuw9dmsr7a4ae","ajtwjrtqdb7fh78ycbc1xwj9iwe","73zz8ydn5ytyafxb41e1yp4ruiy","7pdp7hehnjtn3zg8exs4cs56way","7h5hx6o6nyjnybcsxjy7henocyh"],"icon":"⏰","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"8b05c83e-a44a-4d04-831e-97f01d8e2003","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"34eb9c25-d5bf-49d9-859e-f74f4e0030e7"}}	1675285310477	1675285310477	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
c6nns8c31g78qdxujeg59e6tq1r	2023-02-01 21:01:50.459085+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Video production	{"contentOrder":["anrmt9tpccfbbfnpab78gdfaszy","7ghb3i7r9u38czfxx8fygumo9fy","aj6cr9kez5fyy7y94ir7zpj3zte","7r58bwmi8t3nymffyzp33ghaphc","7qizfhsa84idkt8a34n9ma713xh","7j8tssgdi77dqfydzbgep8y3tkr"],"icon":"📹","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"b1abafbf-a038-4a19-8b68-56e0fd2319f7","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"34eb9c25-d5bf-49d9-859e-f74f4e0030e7"}}	1675285310485	1675285310485	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
cqtdwsjfyqidntenab8sheq6n1e	2023-02-01 21:01:50.459085+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Offsite plans	{"contentOrder":["ajmjkrtn74fggpdsurg7acqfkhc","75uh4sj76h78ounfbofubq1u8qw","a1myhbpurwpdrdfac7c1c4wdr7e","7y8wf9mnpdtgs8qmgcbfpdiha4h","7416ahn46ojbzmkzzxnohf74okr","74wjudf3z33b9pp1hp8f5xm8sho"],"icon":"🚙","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"8b05c83e-a44a-4d04-831e-97f01d8e2003","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"dabadd9b-adf1-4d9f-8702-805ac6cef602"}}	1675285310493	1675285310493	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
crsbb63axmj8a7n4aasuqexad8c	2023-02-01 21:01:50.459085+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Social Media Strategy	{"contentOrder":["aenc74c6dcjnudcczwnno8nwg3y","7c4mihz1s838epf4gsqsths8tzw","a6fbr7myzu388txozueaa68kc8r","755goxmygabrci8f65acg1m3r6r","7hubpn69jztg9uqcntibh35jese","7iw9zf9xw4tfmtm7i5wraqdp5ir"],"icon":"🎉","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"b1abafbf-a038-4a19-8b68-56e0fd2319f7","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"d37a61f4-f332-4db9-8b2d-5e0a91aa20ed"}}	1675285310505	1675285310505	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
v46981ps1m3rpzptrtooyz4zcka	2023-02-01 21:01:50.459085+00	b7wnw9awd4pnefryhq51apbzb4c	1	view	Discussion Items	{"cardOrder":["cjpkiya33qsagr4f9hrdwhgiajc"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"d777ba3b-8728-40d1-87a6-59406bbbbfb0","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[{"propertyId":"4cf1568d-530f-4028-8ffd-bdc65249187e","reversed":false}],"viewType":"board","visibleOptionIds":[],"visiblePropertyIds":["4cf1568d-530f-4028-8ffd-bdc65249187e"]}	1675285310514	1675285310514	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7pdp7hehnjtn3zg8exs4cs56way	2023-02-01 21:01:50.459085+00	c3w9in6qnttf4zd3om9yf95upiy	1	checkbox		{"value":false}	1675285310521	1675285310521	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
73zz8ydn5ytyafxb41e1yp4ruiy	2023-02-01 21:01:50.459085+00	c3w9in6qnttf4zd3om9yf95upiy	1	checkbox		{"value":false}	1675285310526	1675285310526	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7pjcbsmde9pfa9cuw9dmsr7a4ae	2023-02-01 21:01:50.459085+00	c3w9in6qnttf4zd3om9yf95upiy	1	divider		{}	1675285310531	1675285310531	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7h5hx6o6nyjnybcsxjy7henocyh	2023-02-01 21:01:50.459085+00	c3w9in6qnttf4zd3om9yf95upiy	1	checkbox		{"value":false}	1675285310536	1675285310536	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
abgi5ubibkjgc9d3h3xp6dggajr	2023-02-01 21:01:50.459085+00	c3w9in6qnttf4zd3om9yf95upiy	1	text	## Notes\n*[Add meeting notes here]*	{}	1675285310542	1675285310542	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
ajtwjrtqdb7fh78ycbc1xwj9iwe	2023-02-01 21:01:50.459085+00	c3w9in6qnttf4zd3om9yf95upiy	1	text	## Action Items	{}	1675285310546	1675285310546	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7awn4m7bf7pfbiyj5x4otuoxhoe	2023-02-01 21:01:50.459085+00	ch798q5ucefyobf5bymgqjt4f3h	1	divider		{}	1675285310550	1675285310550	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7sexd4aa6opym3j3ohpkpsqmg4e	2023-02-01 21:01:50.459085+00	ch798q5ucefyobf5bymgqjt4f3h	1	checkbox		{"value":false}	1675285310556	1675285310556	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7sqbscdctkjdoxfysau1wzs5p6r	2023-02-01 21:01:50.459085+00	ch798q5ucefyobf5bymgqjt4f3h	1	checkbox		{"value":false}	1675285310560	1675285310560	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7b6ey5yxmdfbkmeugqtwzbrw8zc	2023-02-01 21:01:50.459085+00	ch798q5ucefyobf5bymgqjt4f3h	1	checkbox		{"value":false}	1675285310565	1675285310565	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
aof9obzh5wfy3tga7hrzqh75duw	2023-02-01 21:01:50.459085+00	ch798q5ucefyobf5bymgqjt4f3h	1	text	# Action Items	{}	1675285310571	1675285310571	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
ax7eu8owcgibdjyf89erbped5zy	2023-02-01 21:01:50.459085+00	ch798q5ucefyobf5bymgqjt4f3h	1	text	# Notes\n*[Add meeting notes here]*	{}	1675285310575	1675285310575	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7ghb3i7r9u38czfxx8fygumo9fy	2023-02-01 21:01:50.459085+00	c6nns8c31g78qdxujeg59e6tq1r	1	divider		{}	1675285310579	1675285310579	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7j8tssgdi77dqfydzbgep8y3tkr	2023-02-01 21:01:50.459085+00	c6nns8c31g78qdxujeg59e6tq1r	1	checkbox		{"value":false}	1675285310583	1675285310583	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7qizfhsa84idkt8a34n9ma713xh	2023-02-01 21:01:50.459085+00	c6nns8c31g78qdxujeg59e6tq1r	1	checkbox		{"value":false}	1675285310588	1675285310588	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7r58bwmi8t3nymffyzp33ghaphc	2023-02-01 21:01:50.459085+00	c6nns8c31g78qdxujeg59e6tq1r	1	checkbox		{"value":false}	1675285310592	1675285310592	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
aj6cr9kez5fyy7y94ir7zpj3zte	2023-02-01 21:01:50.459085+00	c6nns8c31g78qdxujeg59e6tq1r	1	text	## Action Items	{}	1675285310596	1675285310596	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
anrmt9tpccfbbfnpab78gdfaszy	2023-02-01 21:01:50.459085+00	c6nns8c31g78qdxujeg59e6tq1r	1	text	## Notes\n*[Add meeting notes here]*	{}	1675285310600	1675285310600	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7y8wf9mnpdtgs8qmgcbfpdiha4h	2023-02-01 21:01:50.459085+00	cqtdwsjfyqidntenab8sheq6n1e	1	checkbox		{"value":false}	1675285310605	1675285310605	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7416ahn46ojbzmkzzxnohf74okr	2023-02-01 21:01:50.459085+00	cqtdwsjfyqidntenab8sheq6n1e	1	checkbox		{"value":false}	1675285310609	1675285310609	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
75uh4sj76h78ounfbofubq1u8qw	2023-02-01 21:01:50.459085+00	cqtdwsjfyqidntenab8sheq6n1e	1	divider		{}	1675285310613	1675285310613	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
74wjudf3z33b9pp1hp8f5xm8sho	2023-02-01 21:01:50.459085+00	cqtdwsjfyqidntenab8sheq6n1e	1	checkbox		{"value":false}	1675285310618	1675285310618	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
a1myhbpurwpdrdfac7c1c4wdr7e	2023-02-01 21:01:50.459085+00	cqtdwsjfyqidntenab8sheq6n1e	1	text	## Action Items	{}	1675285310622	1675285310622	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
ajmjkrtn74fggpdsurg7acqfkhc	2023-02-01 21:01:50.459085+00	cqtdwsjfyqidntenab8sheq6n1e	1	text	## Notes\n*[Add meeting notes here]*	{}	1675285310627	1675285310627	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7c4mihz1s838epf4gsqsths8tzw	2023-02-01 21:01:50.459085+00	crsbb63axmj8a7n4aasuqexad8c	1	divider		{}	1675285310631	1675285310631	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7hubpn69jztg9uqcntibh35jese	2023-02-01 21:01:50.459085+00	crsbb63axmj8a7n4aasuqexad8c	1	checkbox		{"value":false}	1675285310636	1675285310636	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
7iw9zf9xw4tfmtm7i5wraqdp5ir	2023-02-01 21:01:50.459085+00	crsbb63axmj8a7n4aasuqexad8c	1	checkbox		{"value":false}	1675285310644	1675285310644	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
755goxmygabrci8f65acg1m3r6r	2023-02-01 21:01:50.459085+00	crsbb63axmj8a7n4aasuqexad8c	1	checkbox		{"value":false}	1675285310651	1675285310651	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
a6fbr7myzu388txozueaa68kc8r	2023-02-01 21:01:50.459085+00	crsbb63axmj8a7n4aasuqexad8c	1	text	## Action Items	{}	1675285310657	1675285310657	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
aenc74c6dcjnudcczwnno8nwg3y	2023-02-01 21:01:50.459085+00	crsbb63axmj8a7n4aasuqexad8c	1	text	## Notes\n*[Add meeting notes here]*	{}	1675285310665	1675285310665	0	\N	system		system	b4cyhfatknfga9paqdgkoiatddo
vcszbudnt8j817qt866jqnfw7wo	2023-02-01 21:01:51.066397+00		1	view	All Contacts	{"cardOrder":["c77bhbr3hg7yctnz3ngujq668yr","c1c5sshrud7yd3dn3cu1h9k7u5c","ch78mkjmgspytfexiypm3cxgc9w","c3w9hjx9oi3nwxx8aprz3kib4sr","cashp9xzkuj8q8yd59jsq4uthgo"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":240,"a1438fbbhjeffkexmcfhnx99o1h":151,"a5hwxjsmkn6bak6r7uea5bx1kwc":132,"abru6tz8uebdxy4skheqidh7zxy":247,"adtf1151chornmihz4xbgbk9exa":125,"aejo5tcmq54bauuueem9wc4fw4y":127,"ahf43e44h3y8ftanqgzno9z7q7w":129,"ainpw47babwkpyj77ic4b9zq9xr":157,"amahgyn9n4twaapg3jyxb6y4jic":224,"amba7ot98fh7hwsx8jdcfst5g7h":171,"aoheuj1f3mu6eehygr45fxa144y":130,"auhf91pm85f73swwidi4wid8jqe":157},"defaultTemplateId":"cxjt7qpo143rpmpiuni8rpbzoww","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a5hwxjsmkn6bak6r7uea5bx1kwc","aoheuj1f3mu6eehygr45fxa144y","aro91wme9kfaie5ceu9qasmtcnw","ainpw47babwkpyj77ic4b9zq9xr","ahf43e44h3y8ftanqgzno9z7q7w","amahgyn9n4twaapg3jyxb6y4jic","abru6tz8uebdxy4skheqidh7zxy","a1438fbbhjeffkexmcfhnx99o1h","auhf91pm85f73swwidi4wid8jqe","adtf1151chornmihz4xbgbk9exa","aejo5tcmq54bauuueem9wc4fw4y","amba7ot98fh7hwsx8jdcfst5g7h"]}	1675285311084	1675285311084	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
vamocn3756jfpmfkfa6n6hc4mhc	2023-02-01 21:01:51.066397+00		1	view	Pipeline Tracker	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["akj61wc9yxdwyw3t6m8igyf9d5o","aic89a5xox4wbppi6mbyx6ujsda","ah6ehh43rwj88jy4awensin8pcw","aprhd96zwi34o9cs4xyr3o9sf3c","axesd74yuxtbmw1sbk8ufax7z3a","a5txuiubumsmrs8gsd5jz5gc1oa","acm9q494bcthyoqzmfogxxy5czy"],"visiblePropertyIds":["aro91wme9kfaie5ceu9qasmtcnw","amahgyn9n4twaapg3jyxb6y4jic"]}	1675285311101	1675285311101	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
c3w9hjx9oi3nwxx8aprz3kib4sr	2023-02-01 21:01:51.066397+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Jonathan Frazier	{"contentOrder":["aheseum5hgi81xnjsx1rr4ujp7r","aw7adgosz8tnc9kesobpquie57h","7ax1sfm116fgd5byp888tk7gmye","7dbgrr3e937fk8rx5m9yyi8bh8y","77u4hw9b3jtbtjdscb6rnwk3dpa","77urwwied7bfu8dagrqer1jkroc","7m6o7gam3u3dmjnr4kkkjdag7ac","7ma6he37s4bfr8qpkfb8swsxs7r","7mfqz6xyzatfp5d5bxzibcymgac","7hw5x8n9ijbrnigf3uyeu4e3ine","7cykhef57kpnd5p1qodpbc7sn9a","7mrphh66xmir48e9imr1za4ewie"],"icon":"🙎‍♂️","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(999) 123-5678","a5hwxjsmkn6bak6r7uea5bx1kwc":"a5txuiubumsmrs8gsd5jz5gc1oa","abru6tz8uebdxy4skheqidh7zxy":"jonathan.frazier@email.com","aejo5tcmq54bauuueem9wc4fw4y":"0%","ahf43e44h3y8ftanqgzno9z7q7w":"$800,000","ainpw47babwkpyj77ic4b9zq9xr":"Ositions Inc.","amahgyn9n4twaapg3jyxb6y4jic":"as5bk6afoaaa7caewe1zc391sce","aro91wme9kfaie5ceu9qasmtcnw":"apiswzj7uiwbh87z8dw8c6mturw","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1669118400000}"}}	1675285311112	1675285311112	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
ch78mkjmgspytfexiypm3cxgc9w	2023-02-01 21:01:51.066397+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Richard Guzman	{"contentOrder":["ag3dtq44c13r79nz3wiqmqn3niy","araiwz15n6bgnmji4yizn5yjzyw","71nijhn4kejf75nbiid16jaksba","7qrxdubrfrjfh3mcrtz84g978ee","7nwyz1i6qxigp5pxuyus6baxc7o","7chc7m1yy3t8x3x4qos5dpcm39h","7hpbiaowgmfdw5ckmwu85oc45ry","7uxn6w1ngiidwufxniw73yo9qur","75uwzow4hpt8ftqa9z9ncrsgu1a","7nhaizf7cqtgamgotyhcscq6utw","7yuiw4tzhcffw7j84xczthpshpo","7xk331tmi9iryf871pkxz14ohwh"],"icon":"👨‍💼","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(222) 123-1234","a5hwxjsmkn6bak6r7uea5bx1kwc":"axesd74yuxtbmw1sbk8ufax7z3a","abru6tz8uebdxy4skheqidh7zxy":"richard.guzman@email.com","adtf1151chornmihz4xbgbk9exa":"{\\"from\\":1681992000000}","aejo5tcmq54bauuueem9wc4fw4y":"80%","ahf43e44h3y8ftanqgzno9z7q7w":"$3,200,000","ainpw47babwkpyj77ic4b9zq9xr":"Afformance Ltd.","amahgyn9n4twaapg3jyxb6y4jic":"ar6t1ttcumgfuqugg5o4g4mzrza","aro91wme9kfaie5ceu9qasmtcnw":"apjnaggwixchfxwiatfh7ey7uno","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1667476800000}"}}	1675285311129	1675285311129	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
cashp9xzkuj8q8yd59jsq4uthgo	2023-02-01 21:01:51.066397+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Byron Cole	{"contentOrder":["akk9y84c7ptgxjn1co6zmmz7jth","ahzksjktg13ruixijzoi4wizz1a","7cxrg43e36bn55y3ijgze5ubrto","7gq86u41gnbghjqtnt7n5kr5gfo","7edtkotuj7tbs8ctsamym7ahqzr","7nh7kwadyif8gueu4ztef6szp1e","7qp1ug6yi7tbmffofugnpykxpca","7qtouhgkwmpdbif13t7wki3aajc","7tywz5j41qpgxjbi3dbqban3cpc","7i6x9gopwe3879khsiinxicfpzc","7jizdcdwxf3bn8fn6ot9ncxrgkc","7n46szddgcjy3bcz4fp7iagkdkc"],"icon":"🤵","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(333) 123-1234","a5hwxjsmkn6bak6r7uea5bx1kwc":"acm9q494bcthyoqzmfogxxy5czy","abru6tz8uebdxy4skheqidh7zxy":"byron.cole@email.com","adtf1151chornmihz4xbgbk9exa":"{\\"from\\":1667563200000}","aejo5tcmq54bauuueem9wc4fw4y":"100%","ahf43e44h3y8ftanqgzno9z7q7w":"$500,000","ainpw47babwkpyj77ic4b9zq9xr":"Helx Industries","amahgyn9n4twaapg3jyxb6y4jic":"aafwyza5iwdcwcyfyj6bp7emufw","aro91wme9kfaie5ceu9qasmtcnw":"apjnaggwixchfxwiatfh7ey7uno","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1667822400000}"}}	1675285311138	1675285311138	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7yuiw4tzhcffw7j84xczthpshpo	2023-02-01 21:01:51.066397+00	ch78mkjmgspytfexiypm3cxgc9w	1	checkbox	Hand-off to customer success	{}	1675285311245	1675285311245	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7nhaizf7cqtgamgotyhcscq6utw	2023-02-01 21:01:51.066397+00	ch78mkjmgspytfexiypm3cxgc9w	1	checkbox	Finalize contract	{}	1675285311250	1675285311250	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7xk331tmi9iryf871pkxz14ohwh	2023-02-01 21:01:51.066397+00	ch78mkjmgspytfexiypm3cxgc9w	1	checkbox	Post-sales follow up	{}	1675285311256	1675285311256	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
c1c5sshrud7yd3dn3cu1h9k7u5c	2023-02-01 21:01:51.066397+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Caitlyn Russel	{"contentOrder":["az5ken7xou7gsdxqd4884yca3ie","auu9n65xsfpgeiqu1huwie139oh","7cf8kwn5q378njp35nwwt958acy","7nfmna5o6utyumqgqqyyuj6n3wo","7hnk6qa3egbn9tprmeaizqutksc","7hugsyenjciywims3tyqotdx7no","7jmcnou6nxbfhbr3jckb5ff7eac","78s3my3a9h3yy7ny3nxadfpiqdc","7wqmcjdk783r4t8ubjpxee4864h","7a8z55np11tn67d5b1qyp1wfw7o","79ay794go13fs5dut48rcbnrxhw","7s6ipo4tadbfebyopz5dwg1nt4y"],"icon":"🧑‍💼","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(111) 123-1234","a5hwxjsmkn6bak6r7uea5bx1kwc":"ah6ehh43rwj88jy4awensin8pcw","abru6tz8uebdxy4skheqidh7zxy":"caitlyn.russel@email.com","adtf1151chornmihz4xbgbk9exa":"{\\"from\\":1689336000000}","aejo5tcmq54bauuueem9wc4fw4y":"20%","ahf43e44h3y8ftanqgzno9z7q7w":"$250,000","ainpw47babwkpyj77ic4b9zq9xr":"Liminary Corp.","amahgyn9n4twaapg3jyxb6y4jic":"aafwyza5iwdcwcyfyj6bp7emufw","aro91wme9kfaie5ceu9qasmtcnw":"apiswzj7uiwbh87z8dw8c6mturw","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1668168000000}"}}	1675285311143	1675285311143	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
cxjt7qpo143rpmpiuni8rpbzoww	2023-02-01 21:01:51.066397+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	New Prospect	{"contentOrder":["a4rfspspx1iy7xmkp9anbkdmrkw","ajk9xaiirm3ykbeego3jtczn5uo","7qhxxe5i8nffcfces8bx88igyay","79xiwfi64zb8rip4m93gftgyroc","7fqpdwc3xr7rctk7nairp1q67br","7a99pekjn4ffwfdut755fapg3ah","7y9kcbmyog78t3npc9exak13tao","7dmmxyed3tjd8ibygcj9hb9kapy","7zmkncnstrtdb8fradmognondww","76ishcfirrjgb9cyps4ujpiym5o","7mwwd9h3zdp8y7ehrpduyh1m1re","7k94p6adrofdqzgggkyimijc99w"],"icon":"👤","isTemplate":true,"properties":{"a5hwxjsmkn6bak6r7uea5bx1kwc":"akj61wc9yxdwyw3t6m8igyf9d5o"}}	1675285311149	1675285311149	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
c77bhbr3hg7yctnz3ngujq668yr	2023-02-01 21:01:51.066397+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Shelby Olson	{"contentOrder":["a839444fg7bdu9diontmswkmchy","akggx148oyprxdpwwwfipodjuio","7idhcin49oiy65y59m35xt7nwmc","7an7jxs1yg7f4dciw74tcrdmkny","7g38hyfc74fnqzysngkauemjmhr","7hg1cq9fqyj8ztrc1a56hr67g3a","7jijk4twacty53qehuqx6odfh4w","78ad9bc3kqp893xoeu5mwatdzcc","7r613e3xs5pg47fyfmzbn1a8iac","7ep6o89sqj7bfdyijnsg4rkiogy","7y8koixfbwpfc8dib6u8wqaernr","7ahtoyyb9d7rj8mwp3k64d4fupa"],"icon":"🙎‍♀️","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(111) 321-5678","a5hwxjsmkn6bak6r7uea5bx1kwc":"akj61wc9yxdwyw3t6m8igyf9d5o","abru6tz8uebdxy4skheqidh7zxy":"shelby.olson@email.com","ahf43e44h3y8ftanqgzno9z7q7w":"$30,000","ainpw47babwkpyj77ic4b9zq9xr":"Kadera Global","amahgyn9n4twaapg3jyxb6y4jic":"ar6t1ttcumgfuqugg5o4g4mzrza","aro91wme9kfaie5ceu9qasmtcnw":"auu9bfzqeuruyjwzzqgz7q8apuw","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1669291200000}"}}	1675285311155	1675285311155	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
vmr8u7dsbzibbmfneugjngcsber	2023-02-01 21:01:51.066397+00	bzwb99zf498tsm7mjqbiy7g81ze	1	view	Open Deals	{"cardOrder":["c1c5sshrud7yd3dn3cu1h9k7u5c"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[{"condition":"includes","propertyId":"a5hwxjsmkn6bak6r7uea5bx1kwc","values":["akj61wc9yxdwyw3t6m8igyf9d5o","aic89a5xox4wbppi6mbyx6ujsda","ah6ehh43rwj88jy4awensin8pcw","aprhd96zwi34o9cs4xyr3o9sf3c","axesd74yuxtbmw1sbk8ufax7z3a"]}],"operation":"and"},"groupById":"aro91wme9kfaie5ceu9qasmtcnw","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["apjnaggwixchfxwiatfh7ey7uno","apiswzj7uiwbh87z8dw8c6mturw","auu9bfzqeuruyjwzzqgz7q8apuw",""],"visiblePropertyIds":[]}	1675285311160	1675285311160	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7ax1sfm116fgd5byp888tk7gmye	2023-02-01 21:01:51.066397+00	c3w9hjx9oi3nwxx8aprz3kib4sr	1	checkbox	Send initial email	{"value":true}	1675285311166	1675285311166	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7dbgrr3e937fk8rx5m9yyi8bh8y	2023-02-01 21:01:51.066397+00	c3w9hjx9oi3nwxx8aprz3kib4sr	1	checkbox	Send follow-up email	{"value":true}	1675285311172	1675285311172	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7mfqz6xyzatfp5d5bxzibcymgac	2023-02-01 21:01:51.066397+00	c3w9hjx9oi3nwxx8aprz3kib4sr	1	checkbox	Send proposal	{"value":true}	1675285311178	1675285311178	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7hw5x8n9ijbrnigf3uyeu4e3ine	2023-02-01 21:01:51.066397+00	c3w9hjx9oi3nwxx8aprz3kib4sr	1	checkbox	Finalize contract	{}	1675285311182	1675285311182	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
77u4hw9b3jtbtjdscb6rnwk3dpa	2023-02-01 21:01:51.066397+00	c3w9hjx9oi3nwxx8aprz3kib4sr	1	checkbox	Schedule initial sales call	{"value":true}	1675285311186	1675285311186	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7m6o7gam3u3dmjnr4kkkjdag7ac	2023-02-01 21:01:51.066397+00	c3w9hjx9oi3nwxx8aprz3kib4sr	1	checkbox	Schedule demo	{"value":true}	1675285311190	1675285311190	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7cykhef57kpnd5p1qodpbc7sn9a	2023-02-01 21:01:51.066397+00	c3w9hjx9oi3nwxx8aprz3kib4sr	1	checkbox	Hand-off to customer success	{}	1675285311194	1675285311194	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7ma6he37s4bfr8qpkfb8swsxs7r	2023-02-01 21:01:51.066397+00	c3w9hjx9oi3nwxx8aprz3kib4sr	1	checkbox	Follow up after demo	{"value":true}	1675285311198	1675285311198	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
77urwwied7bfu8dagrqer1jkroc	2023-02-01 21:01:51.066397+00	c3w9hjx9oi3nwxx8aprz3kib4sr	1	checkbox	Schedule follow-up sales call	{"value":true}	1675285311203	1675285311203	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7mrphh66xmir48e9imr1za4ewie	2023-02-01 21:01:51.066397+00	c3w9hjx9oi3nwxx8aprz3kib4sr	1	checkbox	Post-sales follow up	{}	1675285311208	1675285311208	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
aw7adgosz8tnc9kesobpquie57h	2023-02-01 21:01:51.066397+00	c3w9hjx9oi3nwxx8aprz3kib4sr	1	text	## Checklist	{}	1675285311213	1675285311213	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
aheseum5hgi81xnjsx1rr4ujp7r	2023-02-01 21:01:51.066397+00	c3w9hjx9oi3nwxx8aprz3kib4sr	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1675285311218	1675285311218	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
71nijhn4kejf75nbiid16jaksba	2023-02-01 21:01:51.066397+00	ch78mkjmgspytfexiypm3cxgc9w	1	checkbox	Send initial email	{"value":true}	1675285311223	1675285311223	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7chc7m1yy3t8x3x4qos5dpcm39h	2023-02-01 21:01:51.066397+00	ch78mkjmgspytfexiypm3cxgc9w	1	checkbox	Schedule follow-up sales call	{"value":true}	1675285311229	1675285311229	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7uxn6w1ngiidwufxniw73yo9qur	2023-02-01 21:01:51.066397+00	ch78mkjmgspytfexiypm3cxgc9w	1	checkbox	Follow up after demo	{"value":true}	1675285311234	1675285311234	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
75uwzow4hpt8ftqa9z9ncrsgu1a	2023-02-01 21:01:51.066397+00	ch78mkjmgspytfexiypm3cxgc9w	1	checkbox	Send proposal	{"value":true}	1675285311241	1675285311241	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7hpbiaowgmfdw5ckmwu85oc45ry	2023-02-01 21:01:51.066397+00	ch78mkjmgspytfexiypm3cxgc9w	1	checkbox	Schedule demo	{"value":true}	1675285311260	1675285311260	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7nwyz1i6qxigp5pxuyus6baxc7o	2023-02-01 21:01:51.066397+00	ch78mkjmgspytfexiypm3cxgc9w	1	checkbox	Schedule initial sales call	{"value":true}	1675285311263	1675285311263	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7qrxdubrfrjfh3mcrtz84g978ee	2023-02-01 21:01:51.066397+00	ch78mkjmgspytfexiypm3cxgc9w	1	checkbox	Send follow-up email	{"value":true}	1675285311267	1675285311267	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
ag3dtq44c13r79nz3wiqmqn3niy	2023-02-01 21:01:51.066397+00	ch78mkjmgspytfexiypm3cxgc9w	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1675285311272	1675285311272	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
araiwz15n6bgnmji4yizn5yjzyw	2023-02-01 21:01:51.066397+00	ch78mkjmgspytfexiypm3cxgc9w	1	text	## Checklist	{}	1675285311277	1675285311277	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7qtouhgkwmpdbif13t7wki3aajc	2023-02-01 21:01:51.066397+00	cashp9xzkuj8q8yd59jsq4uthgo	1	checkbox	Follow up after demo	{"value":true}	1675285311280	1675285311280	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7cxrg43e36bn55y3ijgze5ubrto	2023-02-01 21:01:51.066397+00	cashp9xzkuj8q8yd59jsq4uthgo	1	checkbox	Send initial email	{"value":true}	1675285311284	1675285311284	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7gq86u41gnbghjqtnt7n5kr5gfo	2023-02-01 21:01:51.066397+00	cashp9xzkuj8q8yd59jsq4uthgo	1	checkbox	Send follow-up email	{"value":true}	1675285311289	1675285311289	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7tywz5j41qpgxjbi3dbqban3cpc	2023-02-01 21:01:51.066397+00	cashp9xzkuj8q8yd59jsq4uthgo	1	checkbox	Send proposal	{"value":true}	1675285311292	1675285311292	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7i6x9gopwe3879khsiinxicfpzc	2023-02-01 21:01:51.066397+00	cashp9xzkuj8q8yd59jsq4uthgo	1	checkbox	Finalize contract	{"value":true}	1675285311296	1675285311296	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7nh7kwadyif8gueu4ztef6szp1e	2023-02-01 21:01:51.066397+00	cashp9xzkuj8q8yd59jsq4uthgo	1	checkbox	Schedule follow-up sales call	{"value":true}	1675285311300	1675285311300	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7edtkotuj7tbs8ctsamym7ahqzr	2023-02-01 21:01:51.066397+00	cashp9xzkuj8q8yd59jsq4uthgo	1	checkbox	Schedule initial sales call	{"value":true}	1675285311305	1675285311305	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7qp1ug6yi7tbmffofugnpykxpca	2023-02-01 21:01:51.066397+00	cashp9xzkuj8q8yd59jsq4uthgo	1	checkbox	Schedule demo	{"value":true}	1675285311309	1675285311309	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7jizdcdwxf3bn8fn6ot9ncxrgkc	2023-02-01 21:01:51.066397+00	cashp9xzkuj8q8yd59jsq4uthgo	1	checkbox	Hand-off to customer success	{"value":true}	1675285311314	1675285311314	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7n46szddgcjy3bcz4fp7iagkdkc	2023-02-01 21:01:51.066397+00	cashp9xzkuj8q8yd59jsq4uthgo	1	checkbox	Post-sales follow up	{"value":true}	1675285311319	1675285311319	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
ahzksjktg13ruixijzoi4wizz1a	2023-02-01 21:01:51.066397+00	cashp9xzkuj8q8yd59jsq4uthgo	1	text	## Checklist	{}	1675285311324	1675285311324	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
akk9y84c7ptgxjn1co6zmmz7jth	2023-02-01 21:01:51.066397+00	cashp9xzkuj8q8yd59jsq4uthgo	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1675285311328	1675285311328	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7s6ipo4tadbfebyopz5dwg1nt4y	2023-02-01 21:01:51.066397+00	c1c5sshrud7yd3dn3cu1h9k7u5c	1	checkbox	Post-sales follow up	{}	1675285311333	1675285311333	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7wqmcjdk783r4t8ubjpxee4864h	2023-02-01 21:01:51.066397+00	c1c5sshrud7yd3dn3cu1h9k7u5c	1	checkbox	Send proposal	{}	1675285311338	1675285311338	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
79ay794go13fs5dut48rcbnrxhw	2023-02-01 21:01:51.066397+00	c1c5sshrud7yd3dn3cu1h9k7u5c	1	checkbox	Hand-off to customer success	{}	1675285311342	1675285311342	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
78s3my3a9h3yy7ny3nxadfpiqdc	2023-02-01 21:01:51.066397+00	c1c5sshrud7yd3dn3cu1h9k7u5c	1	checkbox	Follow up after demo	{}	1675285311346	1675285311346	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7jmcnou6nxbfhbr3jckb5ff7eac	2023-02-01 21:01:51.066397+00	c1c5sshrud7yd3dn3cu1h9k7u5c	1	checkbox	Schedule demo	{"value":true}	1675285311350	1675285311350	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7cf8kwn5q378njp35nwwt958acy	2023-02-01 21:01:51.066397+00	c1c5sshrud7yd3dn3cu1h9k7u5c	1	checkbox	Send initial email	{"value":true}	1675285311356	1675285311356	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7hugsyenjciywims3tyqotdx7no	2023-02-01 21:01:51.066397+00	c1c5sshrud7yd3dn3cu1h9k7u5c	1	checkbox	Schedule follow-up sales call	{"value":true}	1675285311362	1675285311362	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7nfmna5o6utyumqgqqyyuj6n3wo	2023-02-01 21:01:51.066397+00	c1c5sshrud7yd3dn3cu1h9k7u5c	1	checkbox	Send follow-up email	{"value":true}	1675285311368	1675285311368	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7hnk6qa3egbn9tprmeaizqutksc	2023-02-01 21:01:51.066397+00	c1c5sshrud7yd3dn3cu1h9k7u5c	1	checkbox	Schedule initial sales call	{"value":true}	1675285311374	1675285311374	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7a8z55np11tn67d5b1qyp1wfw7o	2023-02-01 21:01:51.066397+00	c1c5sshrud7yd3dn3cu1h9k7u5c	1	checkbox	Finalize contract	{}	1675285311381	1675285311381	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
auu9n65xsfpgeiqu1huwie139oh	2023-02-01 21:01:51.066397+00	c1c5sshrud7yd3dn3cu1h9k7u5c	1	text	## Checklist	{}	1675285311393	1675285311393	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
az5ken7xou7gsdxqd4884yca3ie	2023-02-01 21:01:51.066397+00	c1c5sshrud7yd3dn3cu1h9k7u5c	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1675285311399	1675285311399	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7qhxxe5i8nffcfces8bx88igyay	2023-02-01 21:01:51.066397+00	cxjt7qpo143rpmpiuni8rpbzoww	1	checkbox	Send initial email	{"value":false}	1675285311406	1675285311406	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7fqpdwc3xr7rctk7nairp1q67br	2023-02-01 21:01:51.066397+00	cxjt7qpo143rpmpiuni8rpbzoww	1	checkbox	Schedule initial sales call	{"value":false}	1675285311412	1675285311412	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7a99pekjn4ffwfdut755fapg3ah	2023-02-01 21:01:51.066397+00	cxjt7qpo143rpmpiuni8rpbzoww	1	checkbox	Schedule follow-up sales call	{"value":false}	1675285311418	1675285311418	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7zmkncnstrtdb8fradmognondww	2023-02-01 21:01:51.066397+00	cxjt7qpo143rpmpiuni8rpbzoww	1	checkbox	Send proposal	{}	1675285311425	1675285311425	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
76ishcfirrjgb9cyps4ujpiym5o	2023-02-01 21:01:51.066397+00	cxjt7qpo143rpmpiuni8rpbzoww	1	checkbox	Finalize contract	{}	1675285311431	1675285311431	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7k94p6adrofdqzgggkyimijc99w	2023-02-01 21:01:51.066397+00	cxjt7qpo143rpmpiuni8rpbzoww	1	checkbox	Post-sales follow up	{}	1675285311436	1675285311436	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
79xiwfi64zb8rip4m93gftgyroc	2023-02-01 21:01:51.066397+00	cxjt7qpo143rpmpiuni8rpbzoww	1	checkbox	Send follow-up email	{"value":false}	1675285311442	1675285311442	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7y9kcbmyog78t3npc9exak13tao	2023-02-01 21:01:51.066397+00	cxjt7qpo143rpmpiuni8rpbzoww	1	checkbox	Schedule demo	{"value":false}	1675285311448	1675285311448	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7mwwd9h3zdp8y7ehrpduyh1m1re	2023-02-01 21:01:51.066397+00	cxjt7qpo143rpmpiuni8rpbzoww	1	checkbox	Hand-off to customer success	{}	1675285311453	1675285311453	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7dmmxyed3tjd8ibygcj9hb9kapy	2023-02-01 21:01:51.066397+00	cxjt7qpo143rpmpiuni8rpbzoww	1	checkbox	Follow up after demo	{}	1675285311458	1675285311458	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
a4rfspspx1iy7xmkp9anbkdmrkw	2023-02-01 21:01:51.066397+00	cxjt7qpo143rpmpiuni8rpbzoww	1	text	## Notes\n[Enter notes here...]	{}	1675285311462	1675285311462	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
ajk9xaiirm3ykbeego3jtczn5uo	2023-02-01 21:01:51.066397+00	cxjt7qpo143rpmpiuni8rpbzoww	1	text	## Checklist	{}	1675285311466	1675285311466	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
73rqcqs6eqigx5ro33rppnd9bth	2023-02-01 21:01:51.066397+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Hand-off to customer success	{}	1675285311469	1675285311469	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7c1p7m6mtmpn1pjmmbc7hzsdkke	2023-02-01 21:01:51.066397+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Send initial email	{"value":false}	1675285311474	1675285311474	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7e5gh8pkcbibcijkfjhg1xpsu9r	2023-02-01 21:01:51.066397+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Post-sales follow up	{}	1675285311478	1675285311478	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7iiax1wwma3nw5kbbnbrffqkh3r	2023-02-01 21:01:51.066397+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Finalize contract	{}	1675285311482	1675285311482	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7ebs4n1owejyp8dbc6z568istnr	2023-02-01 21:01:51.066397+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Send follow-up email	{"value":false}	1675285311486	1675285311486	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7rmn9661bzj8zjmywbt34pubkdw	2023-02-01 21:01:51.066397+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Schedule follow-up sales call	{"value":false}	1675285311491	1675285311491	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7s7ngurmhjifo3eu6jjjqf9ihuo	2023-02-01 21:01:51.066397+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Send proposal	{}	1675285311494	1675285311494	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7qm3tf8akktnq3pqse9n6ekcmjw	2023-02-01 21:01:51.066397+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Follow up after demo	{}	1675285311497	1675285311497	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7fs1mamc9ztyaijpg1ey3e5e7zc	2023-02-01 21:01:51.066397+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Schedule initial sales call	{"value":false}	1675285311501	1675285311501	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7mggfp6x1b3y3dyynneseq56t6e	2023-02-01 21:01:51.066397+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Schedule demo	{"value":false}	1675285311506	1675285311506	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
az6sgkd64dtyrmqxjkw8maju6fh	2023-02-01 21:01:51.066397+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	text	## Checklist	{}	1675285311511	1675285311511	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
a1rkxfz65gbypmp6hoqkah979ne	2023-02-01 21:01:51.066397+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	text	## Notes\n[Enter notes here...]	{}	1675285311515	1675285311515	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7r613e3xs5pg47fyfmzbn1a8iac	2023-02-01 21:01:51.066397+00	c77bhbr3hg7yctnz3ngujq668yr	1	checkbox	Send proposal	{}	1675285311520	1675285311520	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7idhcin49oiy65y59m35xt7nwmc	2023-02-01 21:01:51.066397+00	c77bhbr3hg7yctnz3ngujq668yr	1	checkbox	Send initial email	{"value":true}	1675285311526	1675285311526	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
78ad9bc3kqp893xoeu5mwatdzcc	2023-02-01 21:01:51.066397+00	c77bhbr3hg7yctnz3ngujq668yr	1	checkbox	Follow up after demo	{}	1675285311529	1675285311529	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7ep6o89sqj7bfdyijnsg4rkiogy	2023-02-01 21:01:51.066397+00	c77bhbr3hg7yctnz3ngujq668yr	1	checkbox	Finalize contract	{}	1675285311533	1675285311533	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7hg1cq9fqyj8ztrc1a56hr67g3a	2023-02-01 21:01:51.066397+00	c77bhbr3hg7yctnz3ngujq668yr	1	checkbox	Schedule follow-up sales call	{"value":false}	1675285311537	1675285311537	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7jijk4twacty53qehuqx6odfh4w	2023-02-01 21:01:51.066397+00	c77bhbr3hg7yctnz3ngujq668yr	1	checkbox	Schedule demo	{"value":false}	1675285311542	1675285311542	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7g38hyfc74fnqzysngkauemjmhr	2023-02-01 21:01:51.066397+00	c77bhbr3hg7yctnz3ngujq668yr	1	checkbox	Schedule initial sales call	{"value":false}	1675285311548	1675285311548	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7ahtoyyb9d7rj8mwp3k64d4fupa	2023-02-01 21:01:51.066397+00	c77bhbr3hg7yctnz3ngujq668yr	1	checkbox	Post-sales follow up	{}	1675285311555	1675285311555	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7y8koixfbwpfc8dib6u8wqaernr	2023-02-01 21:01:51.066397+00	c77bhbr3hg7yctnz3ngujq668yr	1	checkbox	Hand-off to customer success	{}	1675285311560	1675285311560	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
7an7jxs1yg7f4dciw74tcrdmkny	2023-02-01 21:01:51.066397+00	c77bhbr3hg7yctnz3ngujq668yr	1	checkbox	Send follow-up email	{"value":false}	1675285311565	1675285311565	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
akggx148oyprxdpwwwfipodjuio	2023-02-01 21:01:51.066397+00	c77bhbr3hg7yctnz3ngujq668yr	1	text	## Checklist	{}	1675285311571	1675285311571	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
77sjgwoedsi8kzkfxrgg3pptpfo	2023-02-01 21:01:52.583303+00	cqqa8c5xnj7yapgxraokaoau5qa	1	checkbox	[Subtask 3]	{"value":false}	1675285312658	1675285312658	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
a839444fg7bdu9diontmswkmchy	2023-02-01 21:01:51.066397+00	c77bhbr3hg7yctnz3ngujq668yr	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1675285311577	1675285311577	0	\N	system		system	bibxp8mmpkjdoijx58xnmcchgmr
c1b4u8tfuzpgepxxgsi5j37nunc	2023-02-01 21:01:52.182013+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Pay bills	{"contentOrder":["7nrzy4mfmhfn55yk3835cqq3jzr","7oem51ndexpfnfn89tstrd1ix6c","7s9qdgpyj8fbxdrxrxfc1y331te"],"icon":"🔌","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"aj4jyekqqssatjcq7r7chmy19ey","abthng7baedhhtrwsdodeuincqy":"true"}}	1675285312194	1675285312194	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
cpbwt854s9tnjbdffisek6yekte	2023-02-01 21:01:52.182013+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Buy groceries	{"contentOrder":["a7argh1g3y38itro8zazweohrxw","73wy1rwhdzff1umw3ferxa149ry","7fuqe3idduidqzj984x5e457owy","7n15xdmheqpbktb6w951a3pr1py","764rqxkmhc7y48cmo66d939jkth","76786pppnx7nwdeni3ouyrc5goo","7ayessgojapnku8h5nxkm89w6zh"],"icon":"🛒","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"afpy8s7i45frggprmfsqngsocqh"}}	1675285312199	1675285312199	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
ci5a1q8wnmbd4xkboem4wnz8n7a	2023-02-01 21:01:52.182013+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Go for a walk	{"contentOrder":["an5comy4i9bdpuppjgwazwq8ztw","acxqr4ewgctgy3mzinpuddc9zkw","7jpznuusobig9jp1y9hcxxwj96h"],"icon":"👣","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"an51dnkenmoog9cetapbc4uyt3y"}}	1675285312204	1675285312204	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
cjj3iphuq1frg7qytnyomm8ejoc	2023-02-01 21:01:52.182013+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Feed Fluffy	{"contentOrder":["ax1rfmsdoxirs9yk77iji1ezsae"],"icon":"🐱","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"an51dnkenmoog9cetapbc4uyt3y"}}	1675285312209	1675285312209	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
c97nnmyzqqbgmderxuzczy43fmh	2023-02-01 21:01:52.182013+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Gardening	{"contentOrder":[],"icon":"🌳","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"afpy8s7i45frggprmfsqngsocqh"}}	1675285312213	1675285312213	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
v7mor3x9g6j8h7rtzkygrgg1d4w	2023-02-01 21:01:52.182013+00	bbn1888mprfrm5fjw9f1je9x3xo	1	view	List View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":280},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a9zf59u8x1rf4ywctpcqama7tio","abthng7baedhhtrwsdodeuincqy"]}	1675285312218	1675285312218	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
vnzfcj6kjy7nufjkcsrt73kwthc	2023-02-01 21:01:52.182013+00	bbn1888mprfrm5fjw9f1je9x3xo	1	view	Board View	{"cardOrder":["cpbwt854s9tnjbdffisek6yekte","c1b4u8tfuzpgepxxgsi5j37nunc","ci5a1q8wnmbd4xkboem4wnz8n7a","cjj3iphuq1frg7qytnyomm8ejoc","czowhma7rnpgb3eczbqo3t7fijo"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a9zf59u8x1rf4ywctpcqama7tio","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["an51dnkenmoog9cetapbc4uyt3y","afpy8s7i45frggprmfsqngsocqh","aj4jyekqqssatjcq7r7chmy19ey",""],"visiblePropertyIds":["a9zf59u8x1rf4ywctpcqama7tio"]}	1675285312225	1675285312225	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
7s9qdgpyj8fbxdrxrxfc1y331te	2023-02-01 21:01:52.182013+00	c1b4u8tfuzpgepxxgsi5j37nunc	1	checkbox	Utilities	{"value":true}	1675285312229	1675285312229	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
7nrzy4mfmhfn55yk3835cqq3jzr	2023-02-01 21:01:52.182013+00	c1b4u8tfuzpgepxxgsi5j37nunc	1	checkbox	Mobile phone	{"value":true}	1675285312235	1675285312235	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
7oem51ndexpfnfn89tstrd1ix6c	2023-02-01 21:01:52.182013+00	c1b4u8tfuzpgepxxgsi5j37nunc	1	checkbox	Internet	{"value":true}	1675285312240	1675285312240	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
76786pppnx7nwdeni3ouyrc5goo	2023-02-01 21:01:52.182013+00	cpbwt854s9tnjbdffisek6yekte	1	checkbox	Cereal	{"value":false}	1675285312246	1675285312246	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
764rqxkmhc7y48cmo66d939jkth	2023-02-01 21:01:52.182013+00	cpbwt854s9tnjbdffisek6yekte	1	checkbox	Butter	{"value":false}	1675285312251	1675285312250	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
7n15xdmheqpbktb6w951a3pr1py	2023-02-01 21:01:52.182013+00	cpbwt854s9tnjbdffisek6yekte	1	checkbox	Bread	{"value":false}	1675285312256	1675285312256	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
73wy1rwhdzff1umw3ferxa149ry	2023-02-01 21:01:52.182013+00	cpbwt854s9tnjbdffisek6yekte	1	checkbox	Milk	{"value":false}	1675285312261	1675285312261	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
7ayessgojapnku8h5nxkm89w6zh	2023-02-01 21:01:52.182013+00	cpbwt854s9tnjbdffisek6yekte	1	checkbox	Bananas	{"value":false}	1675285312267	1675285312267	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
7fuqe3idduidqzj984x5e457owy	2023-02-01 21:01:52.182013+00	cpbwt854s9tnjbdffisek6yekte	1	checkbox	Eggs	{"value":false}	1675285312274	1675285312274	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
a7argh1g3y38itro8zazweohrxw	2023-02-01 21:01:52.182013+00	cpbwt854s9tnjbdffisek6yekte	1	text	## Grocery list	{}	1675285312279	1675285312279	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
7jpznuusobig9jp1y9hcxxwj96h	2023-02-01 21:01:52.182013+00	ci5a1q8wnmbd4xkboem4wnz8n7a	1	image		{"fileId":"76fwrj36hptg6dywka4k5mt3sph.png"}	1675285312284	1675285312284	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
an5comy4i9bdpuppjgwazwq8ztw	2023-02-01 21:01:52.182013+00	ci5a1q8wnmbd4xkboem4wnz8n7a	1	text	## Goal\nWalk at least 10,000 steps every day.	{}	1675285312291	1675285312291	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
acxqr4ewgctgy3mzinpuddc9zkw	2023-02-01 21:01:52.182013+00	ci5a1q8wnmbd4xkboem4wnz8n7a	1	text	## Route	{}	1675285312296	1675285312296	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
ax1rfmsdoxirs9yk77iji1ezsae	2023-02-01 21:01:52.182013+00	cjj3iphuq1frg7qytnyomm8ejoc	1	text		{}	1675285312301	1675285312301	0	\N	system		system	b6hhefpcchbyy9f1pc15a15wobr
cqqa8c5xnj7yapgxraokaoau5qa	2023-02-01 21:01:52.583303+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Identify dependencies	{"contentOrder":["azdy5ws6g83djze365xzz3k1ine","7tzdmkwb8y3nk8eouz9st4sgrph","aausrjtefrt8r8cjqa4hzpdm5ca","7jb99rwk9biyx9xkjdta9hkpk3a","7g1w56pcwebfid8n7tcayzbg14c","77sjgwoedsi8kzkfxrgg3pptpfo","73r9dfzbimidh7p7rzyyi7rhhow"],"icon":"🔗","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"16","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ayz81h9f3dwp7rzzbdebesc7ute","d3d682bf-e074-49d9-8df5-7320921c2d23":"98a57627-0f76-471d-850d-91f3ed9fd213"}}	1675285312593	1675285312592	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
cxjs7okw4ijbp3j3dy9jka6fk8r	2023-02-01 21:01:52.583303+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Define project scope	{"contentOrder":["a898bde5ao3yq8e61ku67ct9w1h","7u3ip6wckginmmedfz6w63uk5zy","akjgwh4bo7jnyfcw6rarbg7dz6w","7o1eykatzytbxpe38f8bow18aga","7z35jmjcgp3ratgte7i6gn9rsjh","7jk89jt7hxprftm87fd3eia8sqc","7d1ygogbcutf1iep1n4d3ap6fuw"],"icon":"🔬","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"32","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ar6b8m3jxr3asyxhr8iucdbo6yc","d3d682bf-e074-49d9-8df5-7320921c2d23":"87f59784-b859-4c24-8ebe-17c766e081dd"}}	1675285312597	1675285312597	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
cz6ya7nr1h38axpcg7dzqpca3qa	2023-02-01 21:01:52.583303+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Requirements sign-off	{"contentOrder":["acqcomzu9kirk7gh6zr4jtpa63e","7fjzmiu6h4tf9fqfj1zqd9q386a","a4fxd3hq59fdg7fcj5r7umk7xwy","7trguhpkbb7dhppqj4nknr5pm5y","7zuekry6wzi8uzmsyb1wkh7yxsc","76dtyeui1ppyyze4faamoem1zoa","7jmx7bf8ngifyjmjtw8rprhjyec"],"icon":"🖋️","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"8","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ayz81h9f3dwp7rzzbdebesc7ute","d3d682bf-e074-49d9-8df5-7320921c2d23":"d3bfb50f-f569-4bad-8a3a-dd15c3f60101"}}	1675285312602	1675285312602	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
c8kw5dry3dtyz3ef5bgphr6wfmy	2023-02-01 21:01:52.583303+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Project budget approval	{"contentOrder":["a48ysf3rnnjrnfknrr4d1qkk68y","7qdpwtk45p3neibawrmjgmioixy","ao8uqx33yp3rcuy7zzgfi4eacur","7i11nxjfw8fn7bbnbpz3ebu17nh","7hc1ge1hzb3ra5x15raidcb8gxr","7zr8dtcy8r3djbxbuwduham7xio","7henwbx7q37bfmrrexn3cs8aeur"],"icon":"💵","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"16","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ayz81h9f3dwp7rzzbdebesc7ute","d3d682bf-e074-49d9-8df5-7320921c2d23":"d3bfb50f-f569-4bad-8a3a-dd15c3f60101"}}	1675285312608	1675285312608	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
c96mazm71qf8sfxa77y9zofktrw	2023-02-01 21:01:52.583303+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Conduct market analysis	{"contentOrder":["arui51fnbsjb338xrcayrniksec","7etp67gfrnjg39q7odmgpfzgqtr","a61ugq7zfb38q3xzb9wcybnqbqh","7itq7qxo73trhjb777wqujuk95o","7yunpizq953r69b77wo9j3q88go","7x64po6uoojbqbni6aqcokms7to","78bfqtkxkn78wff7uu3t5oorgay"],"icon":"📈","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"40","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ar6b8m3jxr3asyxhr8iucdbo6yc","d3d682bf-e074-49d9-8df5-7320921c2d23":"87f59784-b859-4c24-8ebe-17c766e081dd"}}	1675285312613	1675285312612	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
vbdqbonce3fg3dju6tn1ukusuco	2023-02-01 21:01:52.583303+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Project Priorities	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"d3d682bf-e074-49d9-8df5-7320921c2d23","hiddenOptionIds":[],"kanbanCalculations":{"":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"87f59784-b859-4c24-8ebe-17c766e081dd":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"98a57627-0f76-471d-850d-91f3ed9fd213":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"d3bfb50f-f569-4bad-8a3a-dd15c3f60101":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"}},"sortOptions":[],"viewType":"board","visibleOptionIds":["d3bfb50f-f569-4bad-8a3a-dd15c3f60101","87f59784-b859-4c24-8ebe-17c766e081dd","98a57627-0f76-471d-850d-91f3ed9fd213",""],"visiblePropertyIds":["a972dc7a-5f4c-45d2-8044-8c28c69717f1","a8daz81s4xjgke1ww6cwik5w7ye"]}	1675285312617	1675285312617	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
vmw6848ygc3rztrhe6z1p79jerw	2023-02-01 21:01:52.583303+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Progress Tracker	{"cardOrder":["c8kw5dry3dtyz3ef5bgphr6wfmy","cz6ya7nr1h38axpcg7dzqpca3qa","cqqa8c5xnj7yapgxraokaoau5qa","c96mazm71qf8sfxa77y9zofktrw","cxjs7okw4ijbp3j3dy9jka6fk8r","coxnjt3ro1in19dd1e3awdt338r"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a972dc7a-5f4c-45d2-8044-8c28c69717f1","hiddenOptionIds":[],"kanbanCalculations":{"":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"adeo5xuwne3qjue83fcozekz8ko":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"afi4o5nhnqc3smtzs1hs3ij34dh":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"ahpyxfnnrzynsw3im1psxpkgtpe":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"ar6b8m3jxr3asyxhr8iucdbo6yc":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"ayz81h9f3dwp7rzzbdebesc7ute":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"}},"sortOptions":[],"viewType":"board","visibleOptionIds":["ayz81h9f3dwp7rzzbdebesc7ute","ar6b8m3jxr3asyxhr8iucdbo6yc","afi4o5nhnqc3smtzs1hs3ij34dh","adeo5xuwne3qjue83fcozekz8ko","ahpyxfnnrzynsw3im1psxpkgtpe",""],"visiblePropertyIds":["d3d682bf-e074-49d9-8df5-7320921c2d23","a8daz81s4xjgke1ww6cwik5w7ye"]}	1675285312622	1675285312622	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
vok9s8etnuty9txbqrjyk9duwfc	2023-02-01 21:01:52.583303+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Task Overview	{"cardOrder":["cxjs7okw4ijbp3j3dy9jka6fk8r","c96mazm71qf8sfxa77y9zofktrw","cqqa8c5xnj7yapgxraokaoau5qa","c8kw5dry3dtyz3ef5bgphr6wfmy","cz6ya7nr1h38axpcg7dzqpca3qa","cz8p8gofakfby8kzz83j97db8ph","ce1jm5q5i54enhuu4h3kkay1hcc"],"collapsedOptionIds":[],"columnCalculations":{"a8daz81s4xjgke1ww6cwik5w7ye":"sum"},"columnWidths":{"2a5da320-735c-4093-8787-f56e15cdfeed":196,"__title":280,"a8daz81s4xjgke1ww6cwik5w7ye":139,"a972dc7a-5f4c-45d2-8044-8c28c69717f1":141,"d3d682bf-e074-49d9-8df5-7320921c2d23":110},"defaultTemplateId":"czw9es1e89fdpjr7cqptr1xq7qh","filter":{"filters":[],"operation":"and"},"groupById":"","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a972dc7a-5f4c-45d2-8044-8c28c69717f1","d3d682bf-e074-49d9-8df5-7320921c2d23","2a5da320-735c-4093-8787-f56e15cdfeed","a3zsw7xs8sxy7atj8b6totp3mby","axkhqa4jxr3jcqe4k87g8bhmary","a7gdnz8ff8iyuqmzddjgmgo9ery","a8daz81s4xjgke1ww6cwik5w7ye"]}	1675285312629	1675285312629	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
v5qyzkcts7bgemdbgsoj46m4dcr	2023-02-01 21:01:52.583303+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Task Calendar	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"a3zsw7xs8sxy7atj8b6totp3mby","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675285312634	1675285312634	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7jb99rwk9biyx9xkjdta9hkpk3a	2023-02-01 21:01:52.583303+00	cqqa8c5xnj7yapgxraokaoau5qa	1	checkbox	[Subtask 1]	{"value":false}	1675285312640	1675285312640	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7g1w56pcwebfid8n7tcayzbg14c	2023-02-01 21:01:52.583303+00	cqqa8c5xnj7yapgxraokaoau5qa	1	checkbox	[Subtask 2]	{"value":false}	1675285312645	1675285312645	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7tzdmkwb8y3nk8eouz9st4sgrph	2023-02-01 21:01:52.583303+00	cqqa8c5xnj7yapgxraokaoau5qa	1	divider		{}	1675285312649	1675285312649	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
73r9dfzbimidh7p7rzyyi7rhhow	2023-02-01 21:01:52.583303+00	cqqa8c5xnj7yapgxraokaoau5qa	1	checkbox	...	{"value":false}	1675285312653	1675285312653	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
aausrjtefrt8r8cjqa4hzpdm5ca	2023-02-01 21:01:52.583303+00	cqqa8c5xnj7yapgxraokaoau5qa	1	text	## Checklist	{}	1675285312662	1675285312662	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
azdy5ws6g83djze365xzz3k1ine	2023-02-01 21:01:52.583303+00	cqqa8c5xnj7yapgxraokaoau5qa	1	text	## Description\n*[Brief description of this task]*	{}	1675285312667	1675285312667	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7z35jmjcgp3ratgte7i6gn9rsjh	2023-02-01 21:01:52.583303+00	cxjs7okw4ijbp3j3dy9jka6fk8r	1	checkbox	[Subtask 2]	{"value":false}	1675285312672	1675285312672	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7d1ygogbcutf1iep1n4d3ap6fuw	2023-02-01 21:01:52.583303+00	cxjs7okw4ijbp3j3dy9jka6fk8r	1	checkbox	...	{"value":false}	1675285312678	1675285312678	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7o1eykatzytbxpe38f8bow18aga	2023-02-01 21:01:52.583303+00	cxjs7okw4ijbp3j3dy9jka6fk8r	1	checkbox	[Subtask 1]	{"value":false}	1675285312682	1675285312682	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7jk89jt7hxprftm87fd3eia8sqc	2023-02-01 21:01:52.583303+00	cxjs7okw4ijbp3j3dy9jka6fk8r	1	checkbox	[Subtask 3]	{"value":false}	1675285312687	1675285312687	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7u3ip6wckginmmedfz6w63uk5zy	2023-02-01 21:01:52.583303+00	cxjs7okw4ijbp3j3dy9jka6fk8r	1	divider		{}	1675285312692	1675285312692	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
akjgwh4bo7jnyfcw6rarbg7dz6w	2023-02-01 21:01:52.583303+00	cxjs7okw4ijbp3j3dy9jka6fk8r	1	text	## Checklist	{}	1675285312696	1675285312696	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
a898bde5ao3yq8e61ku67ct9w1h	2023-02-01 21:01:52.583303+00	cxjs7okw4ijbp3j3dy9jka6fk8r	1	text	## Description\n*[Brief description of this task]*	{}	1675285312701	1675285312701	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7jmx7bf8ngifyjmjtw8rprhjyec	2023-02-01 21:01:52.583303+00	cz6ya7nr1h38axpcg7dzqpca3qa	1	checkbox	...	{"value":false}	1675285312705	1675285312705	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7zuekry6wzi8uzmsyb1wkh7yxsc	2023-02-01 21:01:52.583303+00	cz6ya7nr1h38axpcg7dzqpca3qa	1	checkbox	[Subtask 2]	{"value":false}	1675285312710	1675285312710	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7fjzmiu6h4tf9fqfj1zqd9q386a	2023-02-01 21:01:52.583303+00	cz6ya7nr1h38axpcg7dzqpca3qa	1	divider		{}	1675285312715	1675285312715	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
76dtyeui1ppyyze4faamoem1zoa	2023-02-01 21:01:52.583303+00	cz6ya7nr1h38axpcg7dzqpca3qa	1	checkbox	[Subtask 3]	{"value":false}	1675285312720	1675285312720	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7trguhpkbb7dhppqj4nknr5pm5y	2023-02-01 21:01:52.583303+00	cz6ya7nr1h38axpcg7dzqpca3qa	1	checkbox	[Subtask 1]	{"value":false}	1675285312726	1675285312726	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
acqcomzu9kirk7gh6zr4jtpa63e	2023-02-01 21:01:52.583303+00	cz6ya7nr1h38axpcg7dzqpca3qa	1	text	## Description\n*[Brief description of this task]*	{}	1675285312730	1675285312730	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
a4fxd3hq59fdg7fcj5r7umk7xwy	2023-02-01 21:01:52.583303+00	cz6ya7nr1h38axpcg7dzqpca3qa	1	text	## Checklist	{}	1675285312735	1675285312735	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7qdpwtk45p3neibawrmjgmioixy	2023-02-01 21:01:52.583303+00	c8kw5dry3dtyz3ef5bgphr6wfmy	1	divider		{}	1675285312742	1675285312742	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7i11nxjfw8fn7bbnbpz3ebu17nh	2023-02-01 21:01:52.583303+00	c8kw5dry3dtyz3ef5bgphr6wfmy	1	checkbox	[Subtask 1]	{"value":false}	1675285312747	1675285312747	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7zr8dtcy8r3djbxbuwduham7xio	2023-02-01 21:01:52.583303+00	c8kw5dry3dtyz3ef5bgphr6wfmy	1	checkbox	[Subtask 3]	{"value":false}	1675285312752	1675285312752	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7henwbx7q37bfmrrexn3cs8aeur	2023-02-01 21:01:52.583303+00	c8kw5dry3dtyz3ef5bgphr6wfmy	1	checkbox	...	{"value":false}	1675285312757	1675285312757	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7hc1ge1hzb3ra5x15raidcb8gxr	2023-02-01 21:01:52.583303+00	c8kw5dry3dtyz3ef5bgphr6wfmy	1	checkbox	[Subtask 2]	{"value":false}	1675285312762	1675285312761	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
ao8uqx33yp3rcuy7zzgfi4eacur	2023-02-01 21:01:52.583303+00	c8kw5dry3dtyz3ef5bgphr6wfmy	1	text	## Checklist	{}	1675285312766	1675285312766	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
a48ysf3rnnjrnfknrr4d1qkk68y	2023-02-01 21:01:52.583303+00	c8kw5dry3dtyz3ef5bgphr6wfmy	1	text	## Description\n*[Brief description of this task]*	{}	1675285312769	1675285312769	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
78bfqtkxkn78wff7uu3t5oorgay	2023-02-01 21:01:52.583303+00	c96mazm71qf8sfxa77y9zofktrw	1	checkbox	...	{"value":false}	1675285312775	1675285312775	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7x64po6uoojbqbni6aqcokms7to	2023-02-01 21:01:52.583303+00	c96mazm71qf8sfxa77y9zofktrw	1	checkbox	[Subtask 3]	{"value":false}	1675285312780	1675285312780	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7etp67gfrnjg39q7odmgpfzgqtr	2023-02-01 21:01:52.583303+00	c96mazm71qf8sfxa77y9zofktrw	1	divider		{}	1675285312784	1675285312784	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7yunpizq953r69b77wo9j3q88go	2023-02-01 21:01:52.583303+00	c96mazm71qf8sfxa77y9zofktrw	1	checkbox	[Subtask 2]	{"value":false}	1675285312789	1675285312789	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7itq7qxo73trhjb777wqujuk95o	2023-02-01 21:01:52.583303+00	c96mazm71qf8sfxa77y9zofktrw	1	checkbox	[Subtask 1]	{"value":false}	1675285312795	1675285312794	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
arui51fnbsjb338xrcayrniksec	2023-02-01 21:01:52.583303+00	c96mazm71qf8sfxa77y9zofktrw	1	text	## Description\n*[Brief description of this task]*	{}	1675285312800	1675285312800	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
a61ugq7zfb38q3xzb9wcybnqbqh	2023-02-01 21:01:52.583303+00	c96mazm71qf8sfxa77y9zofktrw	1	text	## Checklist	{}	1675285312806	1675285312806	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7jjn7six9178abkf53p3yhycfey	2023-02-01 21:01:52.583303+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	[Subtask 3]	{"value":false}	1675285312811	1675285312811	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
77j8xyt44ipfh8qxiwog7j47oiy	2023-02-01 21:01:52.583303+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	[Subtask 2]	{"value":false}	1675285312816	1675285312816	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7noijreiwjj8m8roeizz3pb1c3h	2023-02-01 21:01:52.583303+00	czw9es1e89fdpjr7cqptr1xq7qh	1	divider		{}	1675285312822	1675285312822	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7ik861fgp3jrb8n58ofjbrnhiwr	2023-02-01 21:01:52.583303+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	[Subtask 1]	{"value":false}	1675285312828	1675285312828	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
7kkiubk15bjruir3dr18uqcmfsr	2023-02-01 21:01:52.583303+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	...	{"value":false}	1675285312833	1675285312833	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
a8w37pe1xafrjir5e6hg7yf9x5r	2023-02-01 21:01:52.583303+00	czw9es1e89fdpjr7cqptr1xq7qh	1	text	## Description\n*[Brief description of this task]*	{}	1675285312838	1675285312838	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
aar5urjpb9bnw8ks15m3boakxbc	2023-02-01 21:01:52.583303+00	czw9es1e89fdpjr7cqptr1xq7qh	1	text	## Checklist	{}	1675285312845	1675285312845	0	\N	system		system	b7q1dux1e8f8gmmg5zhexdr5gwy
vys9qu1qeuind5k9azrmuoq3c1o	2023-02-01 21:01:53.231087+00		1	view	By Quarter	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":452,"a17ryhi1jfsboxkwkztwawhmsxe":148,"a6amddgmrzakw66cidqzgk6p4ge":230,"azzbawji5bksj69sekcs4srm1ky":142},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"aqxyzkdrs4egqf7yk866ixkaojc","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a6amddgmrzakw66cidqzgk6p4ge","a17ryhi1jfsboxkwkztwawhmsxe","azzbawji5bksj69sekcs4srm1ky","adp5ft3kgz7r5iqq3tnwg551der","aqxyzkdrs4egqf7yk866ixkaojc","adu6mebzpibq6mgcswk69xxmnqe","asope3bddhm4gpsng5cfu4hf6rh","ajwxp866f9obs1kutfwaa5ru7fe","azqnyswk6s1boiwuthscm78qwuo","ahz3fmjnaguec8hce7xq3h5cjdr","a17bfcgnzmkwhziwa4tr38kiw5r"]}	1675285313244	1675285313244	0	\N	system		system	bm9cpg1atuf8n3m9rd3mbf5d7yc
var8sfkf5g3bwukuo1r8igs6mae	2023-02-01 21:01:53.231087+00		1	view	By Objectives	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":387,"a17ryhi1jfsboxkwkztwawhmsxe":134,"a6amddgmrzakw66cidqzgk6p4ge":183,"aqxyzkdrs4egqf7yk866ixkaojc":100},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a6amddgmrzakw66cidqzgk6p4ge","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a6amddgmrzakw66cidqzgk6p4ge","a17ryhi1jfsboxkwkztwawhmsxe","azzbawji5bksj69sekcs4srm1ky","adp5ft3kgz7r5iqq3tnwg551der","aqxyzkdrs4egqf7yk866ixkaojc","adu6mebzpibq6mgcswk69xxmnqe","asope3bddhm4gpsng5cfu4hf6rh","ajwxp866f9obs1kutfwaa5ru7fe","azqnyswk6s1boiwuthscm78qwuo","ahz3fmjnaguec8hce7xq3h5cjdr","a17bfcgnzmkwhziwa4tr38kiw5r"]}	1675285313250	1675285313250	0	\N	system		system	bm9cpg1atuf8n3m9rd3mbf5d7yc
cb31ppku4ufrkxeo8a1otsnhajw	2023-02-01 21:01:53.231087+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Improve customer NPS score	{"contentOrder":[],"icon":"💯","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a8nukezwwmknqwjsygg7eaxs9te","a6amddgmrzakw66cidqzgk6p4ge":"apqfjst8massbjjhpcsjs3y1yqa","adp5ft3kgz7r5iqq3tnwg551der":"as555ipyzopjjpfb5rjtssecw5e","ahz3fmjnaguec8hce7xq3h5cjdr":"82%","ajwxp866f9obs1kutfwaa5ru7fe":"8.5","aqxyzkdrs4egqf7yk866ixkaojc":"anruuoyez51r3yjxuoc8zoqnwaw","azqnyswk6s1boiwuthscm78qwuo":"7","azzbawji5bksj69sekcs4srm1ky":"agm9p6gcq15ueuzqq3wd4be39wy"}}	1675285313254	1675285313253	0	\N	system		system	bm9cpg1atuf8n3m9rd3mbf5d7yc
c95ijif8xhbrg5m3coccg657zgw	2023-02-01 21:01:53.231087+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Generate more Marketing Qualified Leads (MQLs)	{"contentOrder":[],"icon":"🛣️","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a8nukezwwmknqwjsygg7eaxs9te","a6amddgmrzakw66cidqzgk6p4ge":"auw3afh3kfhrfgmjr8muiz137jy","adp5ft3kgz7r5iqq3tnwg551der":"as555ipyzopjjpfb5rjtssecw5e","ahz3fmjnaguec8hce7xq3h5cjdr":"65%","ajwxp866f9obs1kutfwaa5ru7fe":"100","aqxyzkdrs4egqf7yk866ixkaojc":"ahfbn1jsmhydym33ygxwg5jt3kh","azqnyswk6s1boiwuthscm78qwuo":"65","azzbawji5bksj69sekcs4srm1ky":"aehoa17cz18rqnrf75g7dwhphpr"}}	1675285313258	1675285313258	0	\N	system		system	bm9cpg1atuf8n3m9rd3mbf5d7yc
cnjniz8bjyfnj5qjtq6wcup1qqo	2023-02-01 21:01:53.231087+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Increase customer retention	{"contentOrder":[],"icon":"😀","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a8nukezwwmknqwjsygg7eaxs9te","a6amddgmrzakw66cidqzgk6p4ge":"apqfjst8massbjjhpcsjs3y1yqa","adp5ft3kgz7r5iqq3tnwg551der":"a8zg3rjtf4swh7smsjxpsn743rh","ahz3fmjnaguec8hce7xq3h5cjdr":"66%","ajwxp866f9obs1kutfwaa5ru7fe":"90% customer retention rate","aqxyzkdrs4egqf7yk866ixkaojc":"acb6dqqs6yson7bbzx6jk9bghjh","azqnyswk6s1boiwuthscm78qwuo":"60%","azzbawji5bksj69sekcs4srm1ky":"afkxpcjqjypu7hhar7banxau91h"}}	1675285313263	1675285313263	0	\N	system		system	bm9cpg1atuf8n3m9rd3mbf5d7yc
c517m7hypo3dk5p85gmijbfkxah	2023-02-01 21:01:53.231087+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Hit company global sales target	{"contentOrder":[],"icon":"💰","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a6robxx81diugpjq5jkezz3j1fo","a6amddgmrzakw66cidqzgk6p4ge":"auw3afh3kfhrfgmjr8muiz137jy","adp5ft3kgz7r5iqq3tnwg551der":"a8zg3rjtf4swh7smsjxpsn743rh","ahz3fmjnaguec8hce7xq3h5cjdr":"15%","ajwxp866f9obs1kutfwaa5ru7fe":"50MM","aqxyzkdrs4egqf7yk866ixkaojc":"awfu37js3fomfkkczm1zppac57a","azqnyswk6s1boiwuthscm78qwuo":"7.5MM","azzbawji5bksj69sekcs4srm1ky":"agrfeaoj7d8p5ianw5iaf3191ae"}}	1675285313268	1675285313268	0	\N	system		system	bm9cpg1atuf8n3m9rd3mbf5d7yc
ccm4dbjf6ypf13ed8eu3okfoh5e	2023-02-01 21:01:53.231087+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Increase user signups by 30%	{"contentOrder":[],"icon":"💳","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a6robxx81diugpjq5jkezz3j1fo","a6amddgmrzakw66cidqzgk6p4ge":"ao9b5pxyt7tkgdohzh9oaustdhr","adp5ft3kgz7r5iqq3tnwg551der":"as555ipyzopjjpfb5rjtssecw5e","ahz3fmjnaguec8hce7xq3h5cjdr":"0%","ajwxp866f9obs1kutfwaa5ru7fe":"1,000","aqxyzkdrs4egqf7yk866ixkaojc":"acb6dqqs6yson7bbzx6jk9bghjh","azqnyswk6s1boiwuthscm78qwuo":"0","azzbawji5bksj69sekcs4srm1ky":"afkxpcjqjypu7hhar7banxau91h"}}	1675285313274	1675285313274	0	\N	system		system	bm9cpg1atuf8n3m9rd3mbf5d7yc
ch3xuddkqxib95pi1f9qiujngna	2023-02-01 21:01:53.231087+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Add 10 new customers in the EU	{"contentOrder":[],"icon":"🌍","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"apnt1f7na9rzgk1rt49keg7xbiy","a6amddgmrzakw66cidqzgk6p4ge":"auw3afh3kfhrfgmjr8muiz137jy","adp5ft3kgz7r5iqq3tnwg551der":"a1ts3ftyr8nocsicui98c89uxjy","ahz3fmjnaguec8hce7xq3h5cjdr":"30%","ajwxp866f9obs1kutfwaa5ru7fe":"10","aqxyzkdrs4egqf7yk866ixkaojc":"acb6dqqs6yson7bbzx6jk9bghjh","azqnyswk6s1boiwuthscm78qwuo":"3","azzbawji5bksj69sekcs4srm1ky":"agrfeaoj7d8p5ianw5iaf3191ae"}}	1675285313279	1675285313279	0	\N	system		system	bm9cpg1atuf8n3m9rd3mbf5d7yc
cfmmnd485mirr3dw1o1dociys8h	2023-02-01 21:01:53.231087+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Launch 3 key features	{"contentOrder":[],"icon":"🚀","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"apnt1f7na9rzgk1rt49keg7xbiy","a6amddgmrzakw66cidqzgk6p4ge":"ao9b5pxyt7tkgdohzh9oaustdhr","adp5ft3kgz7r5iqq3tnwg551der":"a8zg3rjtf4swh7smsjxpsn743rh","ahz3fmjnaguec8hce7xq3h5cjdr":"33%","ajwxp866f9obs1kutfwaa5ru7fe":"3","aqxyzkdrs4egqf7yk866ixkaojc":"anruuoyez51r3yjxuoc8zoqnwaw","azqnyswk6s1boiwuthscm78qwuo":"1","azzbawji5bksj69sekcs4srm1ky":"aw5i7hmpadn6mbwbz955ubarhme"}}	1675285313285	1675285313285	0	\N	system		system	bm9cpg1atuf8n3m9rd3mbf5d7yc
ccygg7f9m5bddff7p96ye4rcqow	2023-02-01 21:01:53.231087+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Reduce bug backlog by 50%	{"contentOrder":[],"icon":"🐞","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"abzfwnn6rmtfzyq5hg8uqmpsncy","a6amddgmrzakw66cidqzgk6p4ge":"apqfjst8massbjjhpcsjs3y1yqa","adp5ft3kgz7r5iqq3tnwg551der":"a1ts3ftyr8nocsicui98c89uxjy","ahz3fmjnaguec8hce7xq3h5cjdr":"100%","ajwxp866f9obs1kutfwaa5ru7fe":"75","aqxyzkdrs4egqf7yk866ixkaojc":"awfu37js3fomfkkczm1zppac57a","azqnyswk6s1boiwuthscm78qwuo":"75","azzbawji5bksj69sekcs4srm1ky":"aw5i7hmpadn6mbwbz955ubarhme"}}	1675285313291	1675285313291	0	\N	system		system	bm9cpg1atuf8n3m9rd3mbf5d7yc
ayi3gma6tufy1t8qmn86hjnafmw	2023-02-01 21:01:53.698735+00	chgbgdr44iif87xim9xgus5sxew	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675285313914	1675285313914	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
vx7xaok4eupn7pjjiyxs8q8hofc	2023-02-01 21:01:53.231087+00	bm4ubx56krp4zwyfcqh7nxiigbr	1	view	Departments	{"cardOrder":["cpa534b5natgmunis8u1ixb55pw"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"azzbawji5bksj69sekcs4srm1ky","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["aw5i7hmpadn6mbwbz955ubarhme","afkxpcjqjypu7hhar7banxau91h","aehoa17cz18rqnrf75g7dwhphpr","agrfeaoj7d8p5ianw5iaf3191ae","agm9p6gcq15ueuzqq3wd4be39wy","aucop7kw6xwodcix6zzojhxih6r","afust91f3g8ht368mkn5x9tgf1o","acocxxwjurud1jixhp7nowdig7y"],"visiblePropertyIds":[]}	1675285313295	1675285313295	0	\N	system		system	bm9cpg1atuf8n3m9rd3mbf5d7yc
csrh74ossctradrhzjhaopk7kic	2023-02-01 21:01:53.538374+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Start a daily journal	{"contentOrder":[],"icon":"✍️","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","d6b1249b-bc18-45fc-889e-bec48fce80ef":"0a82977f-52bf-457b-841b-e2b7f76fb525","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"3245a32d-f688-463b-87f4-8e7142c1b397"}}	1675285313550	1675285313550	0	\N	system		system	b9wgudz1ippgf7map6ygr7tydza
c44mniddtqtg7xe9md1ekdsh3fa	2023-02-01 21:01:53.538374+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Run 3 times a week	{"contentOrder":[],"icon":"🏃","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","d6b1249b-bc18-45fc-889e-bec48fce80ef":"6e7139e4-5358-46bb-8c01-7b029a57b80a","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"ffb3f951-b47f-413b-8f1d-238666728008"}}	1675285313553	1675285313553	0	\N	system		system	b9wgudz1ippgf7map6ygr7tydza
ch4z9qfabz7rbbb574qo6hp9o7h	2023-02-01 21:01:53.538374+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Learn to paint	{"contentOrder":[],"icon":"🎨","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"77c539af-309c-4db1-8329-d20ef7e9eacd","d6b1249b-bc18-45fc-889e-bec48fce80ef":"9a090e33-b110-4268-8909-132c5002c90e","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"3245a32d-f688-463b-87f4-8e7142c1b397"}}	1675285313560	1675285313560	0	\N	system		system	b9wgudz1ippgf7map6ygr7tydza
cp88u4rthp7rjdg43p89pyr3q4w	2023-02-01 21:01:53.538374+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Open retirement account	{"contentOrder":[],"icon":"🏦","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","d6b1249b-bc18-45fc-889e-bec48fce80ef":"0a82977f-52bf-457b-841b-e2b7f76fb525","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"80be816c-fc7a-4928-8489-8b02180f4954"}}	1675285313568	1675285313568	0	\N	system		system	b9wgudz1ippgf7map6ygr7tydza
vaxnnfhfcointxddzm8u7bdzf3y	2023-02-01 21:01:53.538374+00	bd65qbzuqupfztpg31dgwgwm5ga	1	view	By Status	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"af6fcbb8-ca56-4b73-83eb-37437b9a667d","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","77c539af-309c-4db1-8329-d20ef7e9eacd","98bdea27-0cce-4cde-8dc6-212add36e63a",""],"visiblePropertyIds":["d9725d14-d5a8-48e5-8de1-6f8c004a9680","d6b1249b-bc18-45fc-889e-bec48fce80ef"]}	1675285313575	1675285313575	0	\N	system		system	b9wgudz1ippgf7map6ygr7tydza
vjedjnzbtebg99mtiyfpasa5rsc	2023-02-01 21:01:53.538374+00	bd65qbzuqupfztpg31dgwgwm5ga	1	view	Calendar View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"ajy6xbebzopojaenbnmfpgtdwso","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675285313580	1675285313580	0	\N	system		system	b9wgudz1ippgf7map6ygr7tydza
v9kfotbb9fjfhbcpueqkb8ek7xe	2023-02-01 21:01:53.538374+00	bd65qbzuqupfztpg31dgwgwm5ga	1	view	By Date	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"d6b1249b-bc18-45fc-889e-bec48fce80ef","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["9a090e33-b110-4268-8909-132c5002c90e","0a82977f-52bf-457b-841b-e2b7f76fb525","6e7139e4-5358-46bb-8c01-7b029a57b80a","d5371c63-66bf-4468-8738-c4dc4bea4843",""],"visiblePropertyIds":["d9725d14-d5a8-48e5-8de1-6f8c004a9680"]}	1675285313594	1675285313593	0	\N	system		system	b9wgudz1ippgf7map6ygr7tydza
v6cagtxm463ftdg9ni9x155kp7o	2023-02-01 21:01:54.131682+00		1	view	All Users	{"cardOrder":["cse9me1ogppgktyn7q7hrmrdaxa"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":280,"aaebj5fyx493eezx6ukxiwydgty":146,"acjq4t5ymytu8x1f68wkggm7ypc":222,"akrxgi7p7w14fym3gbynb98t9fh":131,"atg9qu6oe4bjm8jczzsn71ff5me":131},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"akrxgi7p7w14fym3gbynb98t9fh","reversed":false}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["aaebj5fyx493eezx6ukxiwydgty","akrxgi7p7w14fym3gbynb98t9fh","atg9qu6oe4bjm8jczzsn71ff5me","acjq4t5ymytu8x1f68wkggm7ypc","aphio1s5gkmpdbwoxynim7acw3e","aqafzdeekpyncwz7m7i54q3iqqy","aify3r761b9w43bqjtskrzi68tr"]}	1675285314141	1675285314141	0	\N	system		system	bjwjkmputh7dn8mequhmmfrhnba
cse9me1ogppgktyn7q7hrmrdaxa	2023-02-01 21:01:54.131682+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Frank Nash	{"contentOrder":["ax7ha15c8g3ypjyi6ug4kpt6efr"],"icon":"👨‍💼","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"ap93ysuzy1xa7z818r6myrn4h4y","acjq4t5ymytu8x1f68wkggm7ypc":"frank.nash@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1669896000000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"aehc83ffays3gh8myz16a8j7k4e"}}	1675285314148	1675285314148	0	\N	system		system	bjwjkmputh7dn8mequhmmfrhnba
cojh3dntq83ymbxx76ne8w9ckpc	2023-02-01 21:01:54.131682+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Richard Parsons	{"contentOrder":["af9ozxqifk7fztgjns71jpchu3c"],"icon":"👨‍🦱","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"a7yq89whddzob1futao4rxk3yzc","acjq4t5ymytu8x1f68wkggm7ypc":"richard.parsons@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1671019200000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"a1sxagjgaadym5yrjak6tcup1oa"}}	1675285314152	1675285314152	0	\N	system		system	bjwjkmputh7dn8mequhmmfrhnba
ct6cbjq9fkty398pm7i1rggk6pc	2023-02-01 21:01:54.131682+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Claire Hart	{"contentOrder":["acnefwdrtsigyppobztpiobwp1o"],"icon":"👩‍🦰","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"aseqq9hrsua56r3s6nbuirj9eec","acjq4t5ymytu8x1f68wkggm7ypc":"claire.hart@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1670500800000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"ahn89mqg9u4igk6pdm7333t8i5h"}}	1675285314156	1675285314156	0	\N	system		system	bjwjkmputh7dn8mequhmmfrhnba
vqh7ut1ag4fbi7j5mt6tp1pd31a	2023-02-01 21:01:53.698735+00		1	view	By Sprint	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{"ai7ajsdk14w7x5s8up3dwir77te":"count"},"columnWidths":{"20717ad3-5741-4416-83f1-6f133fff3d11":128,"50117d52-bcc7-4750-82aa-831a351c44a0":126,"__title":280,"a1g6i613dpe9oryeo71ex3c86hy":159,"aeomttrbhhsi8bph31jn84sto6h":141,"ax9f8so418s6s65hi5ympd93i6a":183,"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":100},"defaultTemplateId":"cdgg5axw99i8g8q19xnb9t8nnre","filter":{"filters":[],"operation":"and"},"groupById":"60985f46-3e41-486e-8213-2b987440ea1c","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["50117d52-bcc7-4750-82aa-831a351c44a0","20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","aphg37f7zbpuc3bhwhp19s1ribh","a4378omyhmgj3bex13sj4wbpfiy","ai7ajsdk14w7x5s8up3dwir77te","a1g6i613dpe9oryeo71ex3c86hy","aeomttrbhhsi8bph31jn84sto6h","ax9f8so418s6s65hi5ympd93i6a"]}	1675285313716	1675285313716	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
cdgg5axw99i8g8q19xnb9t8nnre	2023-02-01 21:01:53.698735+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	User Story	{"contentOrder":["a7yw4ja7bo3b6tpppx859ok4z6y"],"icon":"📖","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"apht1nt5ryukdmxkh6fkfn6rgoy","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer"}}	1675285313724	1675285313724	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
cmdct36nzyjgz3gxc5y99t9w77r	2023-02-01 21:01:53.698735+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Horizontal scroll issue	{"contentOrder":["aksc1gc3hrbdyzdpnnykbpyxzje","aqtaxszth4fgnbyyob3cnkhpqje","7yz7y1s4ffjgp8dfnndh3z7k9hc"],"icon":"〰️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"aomnawq4551cbbzha9gxnmb3z5w","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","ai7ajsdk14w7x5s8up3dwir77te":"1","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675285313726	1675285313726	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
ctfpzwwoysjbh5fjikhrt3wpybe	2023-02-01 21:01:53.698735+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Login screen not loading	{"contentOrder":["aumrq4z8rs7r9uysym3beq3urxr","afj1jneb377baiyqh7owf4p4xic","7bc46ems95inotfhh8rh6d5pyqy"],"icon":"🖥️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"aomnawq4551cbbzha9gxnmb3z5w","50117d52-bcc7-4750-82aa-831a351c44a0":"abrfos7e7eczk9rqw6y5abadm1y","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","ai7ajsdk14w7x5s8up3dwir77te":"1","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"cb8ecdac-38be-4d36-8712-c4d58cc8a8e9"}}	1675285313728	1675285313728	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
c5josmiyxofrijgu4tpsiqcahye	2023-02-01 21:01:53.698735+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Move cards across boards	{"contentOrder":["aqikuktit9pyc9jsffr5x3ijzgh"],"icon":"🚚","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"abrfos7e7eczk9rqw6y5abadm1y","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"2","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675285313736	1675285313736	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
ctiipeg948p8fumipgkjattphze	2023-02-01 21:01:53.698735+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Cross-team collaboration	{"contentOrder":["a5bdy74tbejfb7rwfwizxebkxxo"],"icon":"🤝","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"424ea5e3-9aa1-4075-8c5c-01b44b66e634","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","60985f46-3e41-486e-8213-2b987440ea1c":"14892380-1a32-42dd-8034-a0cea32bc7e6","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"3","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"c62172ea-5da7-4dec-8186-37267d8ee9a7"}}	1675285313740	1675285313740	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
cb1n1h1w75jbafqjdd5qi8tzedw	2023-02-01 21:01:53.698735+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Bug	{"contentOrder":["aafxd758zniyexgdfj64cs7coer","ayniuk6nohfyp9cths4anryxd4y","7hf9aqj6ospge9jo3ej5wsh7muw"],"icon":"🐞","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"aomnawq4551cbbzha9gxnmb3z5w","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer"}}	1675285313742	1675285313742	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
cm9nyefeoxtyjidq8je1bnriobe	2023-02-01 21:01:53.698735+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Standard properties	{"contentOrder":["ac8fqo7bpepbdmd9ybzx3i6fpyo"],"icon":"🏷️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","60985f46-3e41-486e-8213-2b987440ea1c":"14892380-1a32-42dd-8034-a0cea32bc7e6","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"3","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675285313745	1675285313745	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
cwb3ucjf81fdifcy41cfcm4qb5e	2023-02-01 21:01:53.698735+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Epic	{"contentOrder":["awn6zjuk64jbhbpjyqfcoqfg1do"],"icon":"🤝","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"424ea5e3-9aa1-4075-8c5c-01b44b66e634","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"3","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"c62172ea-5da7-4dec-8186-37267d8ee9a7"}}	1675285313748	1675285313748	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
chgbgdr44iif87xim9xgus5sxew	2023-02-01 21:01:53.698735+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Global templates	{"contentOrder":["ayi3gma6tufy1t8qmn86hjnafmw"],"icon":"🖼️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"a6ghze4iy441qhsh3eijnc8hwze","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"2","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675285313751	1675285313751	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
cwa6utrrkgjb5jyo345wr4wys4o	2023-02-01 21:01:53.698735+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Feature	{"contentOrder":["auwor8ubpaff77pttbw8m61za3w"],"icon":"🏗️","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer"}}	1675285313776	1675285313776	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
awn6zjuk64jbhbpjyqfcoqfg1do	2023-02-01 21:01:53.698735+00	cwb3ucjf81fdifcy41cfcm4qb5e	1	text	## Summary\n*[Brief description of what this epic is about]*\n\n## Motivation\n*[Brief description on why this is needed]*\n\n## Acceptance Criteria\n - *[Criteron 1]*\n - *[Criteron 2]*\n - ...\n\n## Personas\n - *[Persona A]*\n - *[Persona B]*\n - ...\n\n## Reference Materials\n - *[Links to other relevant documents as needed]*\n - ...	{}	1675285313909	1675285313909	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
vmt4jqqapz3di9fbxjmmu3iba5h	2023-02-01 21:01:53.698735+00	bgi1yqiis8t8xdqxgnet8ebutky	1	view	By Status	{"cardOrder":["chgbgdr44iif87xim9xgus5sxew","cmdct36nzyjgz3gxc5y99t9w77r","c5josmiyxofrijgu4tpsiqcahye","ctfpzwwoysjbh5fjikhrt3wpybe","cm9nyefeoxtyjidq8je1bnriobe","ctiipeg948p8fumipgkjattphze"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cidz4imnqhir48brz6e8hxhfrhy","filter":{"filters":[],"operation":"and"},"groupById":"50117d52-bcc7-4750-82aa-831a351c44a0","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["aft5bzo7h9aspqgrx3jpy5tzrer","abrfos7e7eczk9rqw6y5abadm1y","ax8wzbka5ahs3zziji3pp4qp9mc","atabdfbdmjh83136d5e5oysxybw","ace1bzypd586kkyhcht5qqd9eca","aay656c9m1hzwxc9ch5ftymh3nw","a6ghze4iy441qhsh3eijnc8hwze"],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675285313784	1675285313783	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
vsn678k8yking8k5y6tqpxjdt9o	2023-02-01 21:01:53.698735+00	bgi1yqiis8t8xdqxgnet8ebutky	1	view	By Type	{"cardOrder":["ctfpzwwoysjbh5fjikhrt3wpybe","c5josmiyxofrijgu4tpsiqcahye","cm9nyefeoxtyjidq8je1bnriobe","cmdct36nzyjgz3gxc5y99t9w77r","chgbgdr44iif87xim9xgus5sxew","ctiipeg948p8fumipgkjattphze"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cidz4imnqhir48brz6e8hxhfrhy","filter":{"filters":[],"operation":"and"},"groupById":"20717ad3-5741-4416-83f1-6f133fff3d11","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["424ea5e3-9aa1-4075-8c5c-01b44b66e634","a5yxq8rbubrpnoommfwqmty138h","apht1nt5ryukdmxkh6fkfn6rgoy","aiycbuo3dr5k4xxbfr7coem8ono","aomnawq4551cbbzha9gxnmb3z5w"],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675285313802	1675285313802	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
a7yw4ja7bo3b6tpppx859ok4z6y	2023-02-01 21:01:53.698735+00	cdgg5axw99i8g8q19xnb9t8nnre	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675285313818	1675285313818	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
7yz7y1s4ffjgp8dfnndh3z7k9hc	2023-02-01 21:01:53.698735+00	cmdct36nzyjgz3gxc5y99t9w77r	1	image		{"fileId":"7tmfu5iqju3n1mdfwi5gru89qmw.png"}	1675285313824	1675285313824	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
aksc1gc3hrbdyzdpnnykbpyxzje	2023-02-01 21:01:53.698735+00	cmdct36nzyjgz3gxc5y99t9w77r	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675285313829	1675285313829	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
aqtaxszth4fgnbyyob3cnkhpqje	2023-02-01 21:01:53.698735+00	cmdct36nzyjgz3gxc5y99t9w77r	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675285313835	1675285313835	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
7bc46ems95inotfhh8rh6d5pyqy	2023-02-01 21:01:53.698735+00	ctfpzwwoysjbh5fjikhrt3wpybe	1	image		{"fileId":"7b9xk9boj3fbqfm3umeaaizp8qr.png"}	1675285313842	1675285313842	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
aumrq4z8rs7r9uysym3beq3urxr	2023-02-01 21:01:53.698735+00	ctfpzwwoysjbh5fjikhrt3wpybe	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675285313847	1675285313847	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
afj1jneb377baiyqh7owf4p4xic	2023-02-01 21:01:53.698735+00	ctfpzwwoysjbh5fjikhrt3wpybe	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675285313856	1675285313856	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
aqikuktit9pyc9jsffr5x3ijzgh	2023-02-01 21:01:53.698735+00	c5josmiyxofrijgu4tpsiqcahye	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675285313861	1675285313861	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
axrcdmicz5trrbpwxz6js7ae1fh	2023-02-01 21:01:53.698735+00	cfmk7771httynm8r7rm8cbrmrya	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675285313866	1675285313866	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
au9b3t7tafibn7gimjqpbaeagdc	2023-02-01 21:01:53.698735+00	cfmk7771httynm8r7rm8cbrmrya	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675285313871	1675285313871	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
a5bdy74tbejfb7rwfwizxebkxxo	2023-02-01 21:01:53.698735+00	ctiipeg948p8fumipgkjattphze	1	text	## Summary\n*[Brief description of what this epic is about]*\n\n## Motivation\n*[Brief description on why this is needed]*\n\n## Acceptance Criteria\n - *[Criteron 1]*\n - *[Criteron 2]*\n - ...\n\n## Personas\n - *[Persona A]*\n - *[Persona B]*\n - ...\n\n## Reference Materials\n - *[Links to other relevant documents as needed]*\n - ...	{}	1675285313877	1675285313877	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
7hf9aqj6ospge9jo3ej5wsh7muw	2023-02-01 21:01:53.698735+00	cb1n1h1w75jbafqjdd5qi8tzedw	1	image		{"fileId":"7tmfu5iqju3n1mdfwi5gru89qmw.png"}	1675285313883	1675285313883	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
aafxd758zniyexgdfj64cs7coer	2023-02-01 21:01:53.698735+00	cb1n1h1w75jbafqjdd5qi8tzedw	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675285313891	1675285313891	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
ayniuk6nohfyp9cths4anryxd4y	2023-02-01 21:01:53.698735+00	cb1n1h1w75jbafqjdd5qi8tzedw	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675285313896	1675285313896	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
ac8fqo7bpepbdmd9ybzx3i6fpyo	2023-02-01 21:01:53.698735+00	cm9nyefeoxtyjidq8je1bnriobe	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675285313902	1675285313902	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
auwor8ubpaff77pttbw8m61za3w	2023-02-01 21:01:53.698735+00	cwa6utrrkgjb5jyo345wr4wys4o	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675285313920	1675285313920	0	\N	system		system	bp9zz8foamiyadchistmtnj7bro
c58p3in8hitgcd8sn874bb8wx1c	2023-02-01 21:01:54.567052+00	brs9cdimfw7fodyi7erqt747rhc	1	card	New Project and Workflow Management Solutions for Developers	{"contentOrder":["71qhnzuec6esdi6fnynwpze4xya","arkandwdsr7rufy5setjep4p18h"],"icon":"🎯","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1645790400000}","ab6mbock6styfe6htf815ph1mhw":["a8xceonxiu4n3c43szhskqizicr","a3pdzi53kpbd4okzdkz6khi87zo","a3d9ux4fmi3anyd11kyipfbhwde"],"ae9ar615xoknd8hw8py7mbyr7zo":"awna1nuarjca99m9s4uiy9kwj5h","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://mattermost.com/newsroom/press-releases/mattermost-launches-new-project-and-workflow-management-solutions-for-developers/","aysx3atqexotgwp5kx6h5i5ancw":"aywiofmmtd3ofgzj95ysky4pjga"}}	1675285314578	1675285314578	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
cqzyozmn73t8wbb36mm5u5w1kuh	2023-02-01 21:01:54.567052+00	brs9cdimfw7fodyi7erqt747rhc	1	card	[Tweet] Mattermost v6.1 includes card @-mention notifications in Boards	{"contentOrder":["7i96m7nbsdsex8n6hzuzrmdfjuy","7ed5bwp3gr8yax3mhtuwiaa9gjy","arug9oegqaift9qee3p3nc5ko9w","aw3uj74yanjrxxgsw6wouuixp8e","abdasiyq4k7ndtfrdadrias8sjy","7pgiwso5hctfwi8wncfpagkyrpa"],"icon":"🐤","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1639051200000}","ab6mbock6styfe6htf815ph1mhw":["az8o8pfe9hq6s7xaehoqyc3wpyc"],"ae9ar615xoknd8hw8py7mbyr7zo":"a9ana1e9w673o5cp8md4xjjwfto","agqsoiipowmnu9rdwxm57zrehtr":"{\\"from\\":1637668800000}","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://twitter.com/Mattermost/status/1463145633162969097?s=20","aysx3atqexotgwp5kx6h5i5ancw":"aj8y675weso8kpb6eceqbpj4ruw"}}	1675285314583	1675285314583	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
cibzpxum8rpbm5nsr7x6jo4gmfc	2023-02-01 21:01:54.567052+00	brs9cdimfw7fodyi7erqt747rhc	1	card	Top 10 Must-Have DevOps Tools in 2021	{"contentOrder":["7fo1utqc8x1z1z6hzg33hes1ktc","ardq3zywcg7dk5cji8n47ws69ja"],"icon":"🛠️","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1636113600000}","ab6mbock6styfe6htf815ph1mhw":["a8xceonxiu4n3c43szhskqizicr"],"ae9ar615xoknd8hw8py7mbyr7zo":"a9ana1e9w673o5cp8md4xjjwfto","agqsoiipowmnu9rdwxm57zrehtr":"{\\"from\\":1637323200000}","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://www.toolbox.com/tech/devops/articles/best-devops-tools/","aysx3atqexotgwp5kx6h5i5ancw":"a3xky7ygn14osr1mokerbfah5cy"}}	1675285314587	1675285314587	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
c533j4aj6xjnexjogofhjiammuy	2023-02-01 21:01:54.567052+00	brs9cdimfw7fodyi7erqt747rhc	1	card	Unblocking Workflows: The Guide to Developer Productivity	{"contentOrder":["77tz16jtz5x73ncs3dxc3fp1d7h","ar5k6gq6hw3gejywmycrzhxhw8e"],"icon":"💻","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1638532800000}","ab6mbock6styfe6htf815ph1mhw":["a3pdzi53kpbd4okzdkz6khi87zo"],"ae9ar615xoknd8hw8py7mbyr7zo":"apy9dcd7zmand615p3h53zjqxjh","agqsoiipowmnu9rdwxm57zrehtr":"{\\"from\\":1639483200000}","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://mattermost.com/newsroom/press-releases/mattermost-unveils-definitive-report-on-the-state-of-developer-productivity-unblocking-workflows-the-guide-to-developer-productivity-2022-edition/","aysx3atqexotgwp5kx6h5i5ancw":"a3xky7ygn14osr1mokerbfah5cy"}}	1675285314593	1675285314593	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
v3hx5az1mbpy3bjeyefs9xc1ube	2023-02-01 21:01:54.567052+00	brs9cdimfw7fodyi7erqt747rhc	1	view	By Status	{"cardOrder":[null,"cdbfkd15d6iy18rgx1tskmfsr6c","cn8yofg9rtkgmzgmb5xdi56p3ic","csgsnnywpuqzs5jgq87snk9x17e","cqwaytore5y487wdu8zffppqnea",null],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["awna1nuarjca99m9s4uiy9kwj5h","a9ana1e9w673o5cp8md4xjjwfto","apy9dcd7zmand615p3h53zjqxjh","acri4cm3bmay55f7ksztphmtnga","amsowcd9a8e1kid317r7ttw6uzh",""],"visiblePropertyIds":["ab6mbock6styfe6htf815ph1mhw"]}	1675285314598	1675285314598	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
vuedb8yqmx3y4px4syyiapgsghe	2023-02-01 21:01:54.567052+00	brs9cdimfw7fodyi7erqt747rhc	1	view	Due Date Calendar	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"a39x5cybshwrbjpc3juaakcyj6e","defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675285314602	1675285314602	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
vme5iffr4gtrqjecc1kb7ff4yac	2023-02-01 21:01:54.567052+00	brs9cdimfw7fodyi7erqt747rhc	1	view	Publication Calendar	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"agqsoiipowmnu9rdwxm57zrehtr","defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675285314609	1675285314609	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
vy191ygom7jdhtpajteynp9unhc	2023-02-01 21:01:54.567052+00	brs9cdimfw7fodyi7erqt747rhc	1	view	Content List	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":322,"ab6mbock6styfe6htf815ph1mhw":229,"aysx3atqexotgwp5kx6h5i5ancw":208},"defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"a39x5cybshwrbjpc3juaakcyj6e","reversed":false}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["ae9ar615xoknd8hw8py7mbyr7zo","aysx3atqexotgwp5kx6h5i5ancw","ab6mbock6styfe6htf815ph1mhw","ao44fz8nf6z6tuj1x31t9yyehcc","a39x5cybshwrbjpc3juaakcyj6e","agqsoiipowmnu9rdwxm57zrehtr","ap4e7kdg7eip7j3c3oyiz39eaoc"]}	1675285314614	1675285314614	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
arkandwdsr7rufy5setjep4p18h	2023-02-01 21:01:54.567052+00	c58p3in8hitgcd8sn874bb8wx1c	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675285314619	1675285314619	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
7pgiwso5hctfwi8wncfpagkyrpa	2023-02-01 21:01:54.567052+00	cqzyozmn73t8wbb36mm5u5w1kuh	1	image		{"fileId":"7y5kr8x8ybpnwdykjfuz57rggrh.png"}	1675285314626	1675285314626	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
arug9oegqaift9qee3p3nc5ko9w	2023-02-01 21:01:54.567052+00	cqzyozmn73t8wbb36mm5u5w1kuh	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675285314634	1675285314634	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
aw3uj74yanjrxxgsw6wouuixp8e	2023-02-01 21:01:54.567052+00	cqzyozmn73t8wbb36mm5u5w1kuh	1	text	## Media	{}	1675285314644	1675285314644	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
aqd8jkextujbz7jfpt5b4jujp5h	2023-02-01 21:01:54.567052+00	cff1jmrxfrirgbeebhr9qd7nida	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675285314655	1675285314655	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
atjdthd87e7b53c3ynx8sh3p37o	2023-02-01 21:01:54.567052+00	cff1jmrxfrirgbeebhr9qd7nida	1	text	## Research\n- ...\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n- ...\n\n## Notes\n- ...\n- ...\n- ...	{}	1675285314658	1675285314658	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
crxzm5uw7qbdoufth4jysrm49fo	2023-02-01 21:01:54.131682+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Olivia Alsop	{"contentOrder":["aocw178uepffgb8urbtmdiqatwe"],"icon":"👩‍💼","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"a7yq89whddzob1futao4rxk3yzc","acjq4t5ymytu8x1f68wkggm7ypc":"olivia.alsop@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1671192000000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"a1sxagjgaadym5yrjak6tcup1oa"}}	1675285314160	1675285314160	0	\N	system		system	bjwjkmputh7dn8mequhmmfrhnba
cfhgcyk97ai8gteoge1gwynmwah	2023-02-01 21:01:54.131682+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Bernadette Powell	{"contentOrder":["ajdc6xc7g9frg8e1ob7foo9ttzc"],"icon":"🧑‍💼","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"af6hjb3ysuaxbwnfqpby4wwnkdr","acjq4t5ymytu8x1f68wkggm7ypc":"bernadette.powell@email.com"}}	1675285314164	1675285314164	0	\N	system		system	bjwjkmputh7dn8mequhmmfrhnba
vejapho6yojbo7b9rsdougexd6e	2023-02-01 21:01:54.131682+00	bh4pkixqsjift58e1qy6htrgeay	1	view	By Date	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"akrxgi7p7w14fym3gbynb98t9fh","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675285314168	1675285314168	0	\N	system		system	bjwjkmputh7dn8mequhmmfrhnba
vac69jd61btdfdchpim3rbeh4hy	2023-02-01 21:01:54.131682+00	bixohg18tt11in4qbtinimk974y	1	view	By Status	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["af6hjb3ysuaxbwnfqpby4wwnkdr","aotxum1p5bw3xuzqz3ctjw66yww","a7yq89whddzob1futao4rxk3yzc","aseqq9hrsua56r3s6nbuirj9eec","ap93ysuzy1xa7z818r6myrn4h4y"],"visiblePropertyIds":[]}	1675285314173	1675285314173	0	\N	system		system	bjwjkmputh7dn8mequhmmfrhnba
ax7ha15c8g3ypjyi6ug4kpt6efr	2023-02-01 21:01:54.131682+00	cse9me1ogppgktyn7q7hrmrdaxa	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1675285314178	1675285314178	0	\N	system		system	bjwjkmputh7dn8mequhmmfrhnba
af9ozxqifk7fztgjns71jpchu3c	2023-02-01 21:01:54.131682+00	cojh3dntq83ymbxx76ne8w9ckpc	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1675285314182	1675285314182	0	\N	system		system	bjwjkmputh7dn8mequhmmfrhnba
acnefwdrtsigyppobztpiobwp1o	2023-02-01 21:01:54.131682+00	ct6cbjq9fkty398pm7i1rggk6pc	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1675285314186	1675285314186	0	\N	system		system	bjwjkmputh7dn8mequhmmfrhnba
aocw178uepffgb8urbtmdiqatwe	2023-02-01 21:01:54.131682+00	crxzm5uw7qbdoufth4jysrm49fo	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1675285314191	1675285314191	0	\N	system		system	bjwjkmputh7dn8mequhmmfrhnba
ajdc6xc7g9frg8e1ob7foo9ttzc	2023-02-01 21:01:54.131682+00	cfhgcyk97ai8gteoge1gwynmwah	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1675285314194	1675285314194	0	\N	system		system	bjwjkmputh7dn8mequhmmfrhnba
v3wkhaifh3frwzm1cij5q4q8rna	2023-02-01 21:01:54.299613+00		1	view	Competitor List	{"cardOrder":["cai9xuy4er78fxyhbgurwzb9rtw","czo8iyi89jtdkxdet7tqkjb6few","cwc8yt8ztp7fuj8sdah4irsimbe","cbr73ap5j5tgo8c61by3cfoi9hw","czq1j6aji77dabmjkujixhc9jxa"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":210,"a1semdhszu1rq17d7et5ydrqqio":121,"aapogff3xoa8ym7xf56s87kysda":194,"ahzspe59iux8wigra8bg6cg18nc":156,"aiefo7nh9jwisn8b4cgakowithy":155,"aozntq4go4nkab688j1s7stqtfc":151,"az3jkw3ynd3mqmart7edypey15e":145},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["ahzspe59iux8wigra8bg6cg18nc","aozntq4go4nkab688j1s7stqtfc","aiefo7nh9jwisn8b4cgakowithy","a6cwaq79b1pdpb97wkanmeyy4er","an1eerzscfxn6awdfajbg41uz3h","a1semdhszu1rq17d7et5ydrqqio","aapogff3xoa8ym7xf56s87kysda","az3jkw3ynd3mqmart7edypey15e"]}	1675285314310	1675285314310	0	\N	system		system	b94e89e4eyib89q8aayocgudx7a
v3sgexeex7bgutce69myoqwqhjr	2023-02-01 21:01:54.299613+00		1	view	Market Position	{"cardOrder":["cip8b4jcomfr7by9gtizebikfke","cacs91js1hb887ds41r6dwnd88c","ca3u8edwrof89i8obxffnz4xw3a"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["arfjpz9by5car71tz3behba8yih","abajmr34b8g1916w495xjb35iko","abt79uxg5edqojsrrefcnr4eruo","aipf3qfgjtkheiayjuxrxbpk9wa"],"visiblePropertyIds":[]}	1675285314315	1675285314315	0	\N	system		system	b94e89e4eyib89q8aayocgudx7a
cai9xuy4er78fxyhbgurwzb9rtw	2023-02-01 21:01:54.299613+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Liminary Corp.	{"contentOrder":["aqcxdcjsca7drun1i1ryqzdt7oo"],"icon":"🌧","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"abt79uxg5edqojsrrefcnr4eruo","a6cwaq79b1pdpb97wkanmeyy4er":"300","ahzspe59iux8wigra8bg6cg18nc":"liminarycorp.com","aiefo7nh9jwisn8b4cgakowithy":"$25,000,000","an1eerzscfxn6awdfajbg41uz3h":"2017","aozntq4go4nkab688j1s7stqtfc":"Toronto, Canada"}}	1675285314320	1675285314320	0	\N	system		system	b94e89e4eyib89q8aayocgudx7a
czo8iyi89jtdkxdet7tqkjb6few	2023-02-01 21:01:54.299613+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Helx Industries	{"contentOrder":["akwuyptb3hjfuzqcymu8kxbfjza"],"icon":"📦","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"abt79uxg5edqojsrrefcnr4eruo","a6cwaq79b1pdpb97wkanmeyy4er":"650","ahzspe59iux8wigra8bg6cg18nc":"helxindustries.com","aiefo7nh9jwisn8b4cgakowithy":"$50,000,000","an1eerzscfxn6awdfajbg41uz3h":"2009","aozntq4go4nkab688j1s7stqtfc":"New York, NY"}}	1675285314325	1675285314325	0	\N	system		system	b94e89e4eyib89q8aayocgudx7a
cwc8yt8ztp7fuj8sdah4irsimbe	2023-02-01 21:01:54.299613+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Kadera Global	{"contentOrder":["as4wqofedst8rpqr8ytark9kh5h"],"icon":"🛡","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"aipf3qfgjtkheiayjuxrxbpk9wa","a6cwaq79b1pdpb97wkanmeyy4er":"150","ahzspe59iux8wigra8bg6cg18nc":"kaderaglobal.com","aiefo7nh9jwisn8b4cgakowithy":"$12,000,000","an1eerzscfxn6awdfajbg41uz3h":"2015","aozntq4go4nkab688j1s7stqtfc":"Seattle, OR"}}	1675285314330	1675285314330	0	\N	system		system	b94e89e4eyib89q8aayocgudx7a
czq1j6aji77dabmjkujixhc9jxa	2023-02-01 21:01:54.299613+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Ositions Inc.	{"contentOrder":["ah3u8wrrqttbmjxz6z1cc434fbc"],"icon":"🌃","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"abajmr34b8g1916w495xjb35iko","a6cwaq79b1pdpb97wkanmeyy4er":"2,700","ahzspe59iux8wigra8bg6cg18nc":"ositionsinc.com","aiefo7nh9jwisn8b4cgakowithy":"$125,000,000","an1eerzscfxn6awdfajbg41uz3h":"2004","aozntq4go4nkab688j1s7stqtfc":"Berlin, Germany"}}	1675285314335	1675285314335	0	\N	system		system	b94e89e4eyib89q8aayocgudx7a
aywxhfdfumby8dre4fw4wdou5ay	2023-02-01 21:01:54.567052+00	cff1jmrxfrirgbeebhr9qd7nida	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675285314663	1675285314663	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
cbr73ap5j5tgo8c61by3cfoi9hw	2023-02-01 21:01:54.299613+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Afformance Ltd.	{"contentOrder":["awp6i5rw353rpmfrksgu3fnhuor"],"icon":"⚡","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"arfjpz9by5car71tz3behba8yih","a6cwaq79b1pdpb97wkanmeyy4er":"1,800","ahzspe59iux8wigra8bg6cg18nc":"afformanceltd.com","aiefo7nh9jwisn8b4cgakowithy":"$200,000,000","an1eerzscfxn6awdfajbg41uz3h":"2002","aozntq4go4nkab688j1s7stqtfc":"Palo Alto, CA"}}	1675285314339	1675285314339	0	\N	system		system	b94e89e4eyib89q8aayocgudx7a
aqcxdcjsca7drun1i1ryqzdt7oo	2023-02-01 21:01:54.299613+00	cai9xuy4er78fxyhbgurwzb9rtw	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1675285314345	1675285314345	0	\N	system		system	b94e89e4eyib89q8aayocgudx7a
akwuyptb3hjfuzqcymu8kxbfjza	2023-02-01 21:01:54.299613+00	czo8iyi89jtdkxdet7tqkjb6few	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1675285314350	1675285314350	0	\N	system		system	b94e89e4eyib89q8aayocgudx7a
as4wqofedst8rpqr8ytark9kh5h	2023-02-01 21:01:54.299613+00	cwc8yt8ztp7fuj8sdah4irsimbe	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1675285314355	1675285314355	0	\N	system		system	b94e89e4eyib89q8aayocgudx7a
ah3u8wrrqttbmjxz6z1cc434fbc	2023-02-01 21:01:54.299613+00	czq1j6aji77dabmjkujixhc9jxa	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n\n## Weaknesses\n- ...\n- ...\n\n## Opportunities\n- ...\n- ...\n\n## Threats\n- ...\n- ...	{}	1675285314361	1675285314361	0	\N	system		system	b94e89e4eyib89q8aayocgudx7a
awp6i5rw353rpmfrksgu3fnhuor	2023-02-01 21:01:54.299613+00	cbr73ap5j5tgo8c61by3cfoi9hw	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1675285314366	1675285314366	0	\N	system		system	b94e89e4eyib89q8aayocgudx7a
ce6f7uy1wc7ny5q755969c9ma3w	2023-02-01 21:01:54.916038+00	bui5izho7dtn77xg3thkiqprc9r	1	card	App crashing	{"contentOrder":["79t7rkiuspeneqi9xurou9tqzwh","abkisg9sqm3yt8j4uc156kuz99h","ac5dmog1ctifxfy54biqxidh4ch","7zmze7z65m7n9ixxpij5ioj89ic"],"icon":"📉","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"1fdbb515-edd2-4af5-80fc-437ed2211a49","50117d52-bcc7-4750-82aa-831a351c44a0":"ec6d2bc5-df2b-4f77-8479-e59ceb039946","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"cb8ecdac-38be-4d36-8712-c4d58cc8a8e9"}}	1675285314927	1675285314927	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
c1c3fs48ig3fa9mtwgsdsm6dzqo	2023-02-01 21:01:54.916038+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Calendar view	{"contentOrder":["7df11783ny67mdnognqae31ax6y","a7ew6ioamjbg3xc5xoe97c7aniw"],"icon":"📆","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"6eea96c9-4c61-4968-8554-4b7537e8f748","50117d52-bcc7-4750-82aa-831a351c44a0":"849766ba-56a5-48d1-886f-21672f415395","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675285314933	1675285314933	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
c3nwo55y5ctn88q8i4xemhdqq5e	2023-02-01 21:01:54.916038+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Standard templates	{"contentOrder":["7uonmjk41nipnrsi6tz8wau5ssh","adm59pmr4si8nbe494mjxssgzmw"],"icon":"🗺️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"6eea96c9-4c61-4968-8554-4b7537e8f748","50117d52-bcc7-4750-82aa-831a351c44a0":"ec6d2bc5-df2b-4f77-8479-e59ceb039946","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675285314939	1675285314939	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
c4rpiqgadu7n6mk89fi9dyy994a	2023-02-01 21:01:54.916038+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Import / Export	{"contentOrder":["aobzs896xwbgkjp4deb816g986e"],"icon":"🚢","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"6eea96c9-4c61-4968-8554-4b7537e8f748","50117d52-bcc7-4750-82aa-831a351c44a0":"ec6d2bc5-df2b-4f77-8479-e59ceb039946","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675285314945	1675285314945	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
ct7jahzpysjb4pbhxi58spwdtxh	2023-02-01 21:01:54.916038+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Review API design	{"contentOrder":["abmhnzpwuk38wurwejgb68866ha"],"icon":"🛣️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"424ea5e3-9aa1-4075-8c5c-01b44b66e634","50117d52-bcc7-4750-82aa-831a351c44a0":"8c557f69-b0ed-46ec-83a3-8efab9d47ef5","60985f46-3e41-486e-8213-2b987440ea1c":"14892380-1a32-42dd-8034-a0cea32bc7e6","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"c62172ea-5da7-4dec-8186-37267d8ee9a7"}}	1675285314951	1675285314951	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
75134sysbt7dmbric3ygi8is36r	2023-02-01 21:01:55.312436+00	cukpzn8sxhtbn3krci16sa3saka	1	checkbox	Create and manage checklists, like this one... :)	{"value":false}	1675285315399	1675285315398	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
ardq3zywcg7dk5cji8n47ws69ja	2023-02-01 21:01:54.567052+00	cibzpxum8rpbm5nsr7x6jo4gmfc	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675285314668	1675285314668	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
ar5k6gq6hw3gejywmycrzhxhw8e	2023-02-01 21:01:54.567052+00	c533j4aj6xjnexjogofhjiammuy	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675285314674	1675285314674	0	\N	system		system	br7ayzinnkfryudqw8jpuqpwniw
vhbxi8kf817g8xrau13ggicim4r	2023-02-01 21:01:54.819555+00	bjbhs6bos3m8zjouf78xceg9nqw	1	view	Board view	{"cardOrder":["cniwb8xwcqtbstbcm3sdfrr854h","cs4qwpzr65fgttd7364dicskanh","c9s78pzbdg3g4jkcdjqahtnfejc","c8utmazns878jtfgtf7exyi9pee","cnobejmb6bf8e3c1w7em5z4pwyh"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["aok6pgecm85qe9k5kcphzoe63ma","aq1dwbf661yx337hjcd5q3sbxwa","ar87yh5xmsswqkxmjq1ipfftfpc","akj3fkmxq7idma55mdt8sqpumyw"],"visiblePropertyIds":["aspaay76a5wrnuhtqgm97tt3rer"]}	1675285314827	1675285314827	0	\N	system		system	bydniqgzqq3bwm8kw55a67d93oo
cj5oa77pxgbf5t8ixsbj7gcznfw	2023-02-01 21:01:54.819555+00	bsjd59qtpbf888mqez3ge77domw	1	card	Tight deadline	{"contentOrder":[],"icon":"📅","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"ar87yh5xmsswqkxmjq1ipfftfpc"}}	1675285314831	1675285314831	0	\N	system		system	bydniqgzqq3bwm8kw55a67d93oo
c9nskf1atnffypg4rmejpbksn8a	2023-02-01 21:01:54.819555+00	bsjd59qtpbf888mqez3ge77domw	1	card	Team communication	{"contentOrder":[],"icon":"💬","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"aq1dwbf661yx337hjcd5q3sbxwa"}}	1675285314835	1675285314835	0	\N	system		system	bydniqgzqq3bwm8kw55a67d93oo
cxghiu5yzifbz78b5x5h173maby	2023-02-01 21:01:54.819555+00	bsjd59qtpbf888mqez3ge77domw	1	card	Reschedule planning meeting	{"contentOrder":[],"icon":"🗓️","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"aok6pgecm85qe9k5kcphzoe63ma"}}	1675285314840	1675285314840	0	\N	system		system	bydniqgzqq3bwm8kw55a67d93oo
cyjzct66ekp8auxspki7fq9bkoo	2023-02-01 21:01:54.819555+00	bsjd59qtpbf888mqez3ge77domw	1	card	Schedule more time for testing	{"contentOrder":[],"icon":"🧪","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"akj3fkmxq7idma55mdt8sqpumyw"}}	1675285314845	1675285314845	0	\N	system		system	bydniqgzqq3bwm8kw55a67d93oo
cdaccq8mwni86781868m9drfsse	2023-02-01 21:01:54.819555+00	bsjd59qtpbf888mqez3ge77domw	1	card	Positive user feedback	{"contentOrder":[],"icon":"🥰","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"aq1dwbf661yx337hjcd5q3sbxwa"}}	1675285314848	1675285314848	0	\N	system		system	bydniqgzqq3bwm8kw55a67d93oo
cqwxtbrobujg58gqcfamejkhxkw	2023-02-01 21:01:54.916038+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Icons don't display	{"contentOrder":["agrw435r3yjdtpremce3r6d4dfr","akxzotnktgib9tbk3j6uyix4udy","7f96e5xpuf38xfc6bqzwimgxoje"],"icon":"💻","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"1fdbb515-edd2-4af5-80fc-437ed2211a49","50117d52-bcc7-4750-82aa-831a351c44a0":"8c557f69-b0ed-46ec-83a3-8efab9d47ef5","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675285314961	1675285314961	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
vfue7aio66jfmb8ugywp3rg95ie	2023-02-01 21:01:54.916038+00	bui5izho7dtn77xg3thkiqprc9r	1	view	Calendar View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"a4378omyhmgj3bex13sj4wbpfiy","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675285314966	1675285314966	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
vhj7ro9auobdpmn5r86tmdj4aka	2023-02-01 21:01:54.916038+00	bui5izho7dtn77xg3thkiqprc9r	1	view	Board: Sprints	{"cardOrder":["ce6f7uy1wc7ny5q755969c9ma3w","c1c3fs48ig3fa9mtwgsdsm6dzqo","c3nwo55y5ctn88q8i4xemhdqq5e","cqwxtbrobujg58gqcfamejkhxkw","c4rpiqgadu7n6mk89fi9dyy994a","ct7jahzpysjb4pbhxi58spwdtxh"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"60985f46-3e41-486e-8213-2b987440ea1c","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["c01676ca-babf-4534-8be5-cce2287daa6c","ed4a5340-460d-461b-8838-2c56e8ee59fe","14892380-1a32-42dd-8034-a0cea32bc7e6",""],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675285314972	1675285314972	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
vwm7pdf949if38dofbpybe65e5a	2023-02-01 21:01:54.916038+00	bui5izho7dtn77xg3thkiqprc9r	1	view	List: Tasks 🔨	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"50117d52-bcc7-4750-82aa-831a351c44a0":139,"__title":280},"defaultTemplateId":"","filter":{"filters":[{"condition":"includes","propertyId":"20717ad3-5741-4416-83f1-6f133fff3d11","values":["6eea96c9-4c61-4968-8554-4b7537e8f748"]}],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"50117d52-bcc7-4750-82aa-831a351c44a0","reversed":true}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["50117d52-bcc7-4750-82aa-831a351c44a0","20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675285314979	1675285314979	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
vfutrxwzyjirpbnxwepo9kphtwc	2023-02-01 21:01:54.916038+00	bui5izho7dtn77xg3thkiqprc9r	1	view	Board: Status	{"cardOrder":["ce6f7uy1wc7ny5q755969c9ma3w","cm4w7cc3aac6s9jdcujbs4j8f4r","c6egh6cpnj137ixdoitsoxq17oo","cct9u78utsdyotmejbmwwg66ihr","cmft87it1q7yebbd51ij9k65xbw","c9fe77j9qcruxf4itzib7ag6f1c","coup7afjknqnzbdwghiwbsq541w","c5ex1hndz8qyc8gx6ofbfeksftc"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cidz4imnqhir48brz6e8hxhfrhy","filter":{"filters":[],"operation":"and"},"groupById":"50117d52-bcc7-4750-82aa-831a351c44a0","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["8c557f69-b0ed-46ec-83a3-8efab9d47ef5","ec6d2bc5-df2b-4f77-8479-e59ceb039946","849766ba-56a5-48d1-886f-21672f415395",""],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675285314985	1675285314985	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
ay8xkm18ujtbiin6kekgwtw8zoe	2023-02-01 21:01:54.916038+00	cwrq9ag3p5pgzzy98nfd3wwra1w	1	text	## Summary\n*[Brief description of what this epic is about]*\n## Motivation\n*[Brief description on why this is needed]*\n## Acceptance Criteria\n- *[Criteron 1]*\n- *[Criteron 2]*\n- ...\n## Personas\n- *[Persona A]*\n- *[Persona B]*\n- ...\n## Reference Materials\n- *[Links to other relevant documents as needed]*\n- ...	{}	1675285315078	1675285315078	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
vjyngn6i9gbgeuchcpdbmsqjp9o	2023-02-01 21:01:54.916038+00	bui5izho7dtn77xg3thkiqprc9r	1	view	List: Bugs 🐞	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"50117d52-bcc7-4750-82aa-831a351c44a0":145,"__title":280},"defaultTemplateId":"","filter":{"filters":[{"condition":"includes","propertyId":"20717ad3-5741-4416-83f1-6f133fff3d11","values":["1fdbb515-edd2-4af5-80fc-437ed2211a49"]}],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["50117d52-bcc7-4750-82aa-831a351c44a0","20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675285314990	1675285314990	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
7zmze7z65m7n9ixxpij5ioj89ic	2023-02-01 21:01:54.916038+00	ce6f7uy1wc7ny5q755969c9ma3w	1	image		{"fileId":"77pe9r4ckbin438ph3f18bpatua.png"}	1675285314995	1675285314995	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
abkisg9sqm3yt8j4uc156kuz99h	2023-02-01 21:01:54.916038+00	ce6f7uy1wc7ny5q755969c9ma3w	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675285314999	1675285314999	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
ac5dmog1ctifxfy54biqxidh4ch	2023-02-01 21:01:54.916038+00	ce6f7uy1wc7ny5q755969c9ma3w	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675285315004	1675285315004	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
a7ew6ioamjbg3xc5xoe97c7aniw	2023-02-01 21:01:54.916038+00	c1c3fs48ig3fa9mtwgsdsm6dzqo	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675285315009	1675285315009	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
adm59pmr4si8nbe494mjxssgzmw	2023-02-01 21:01:54.916038+00	c3nwo55y5ctn88q8i4xemhdqq5e	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675285315016	1675285315016	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
79ghy66qyxffh9eyp3ue1zdaicy	2023-02-01 21:01:54.916038+00	cfefgwjke6bbxpjpig618g9bpte	1	image		{"fileId":"7pbp4qg415pbstc6enzeicnu3qh.png"}	1675285315021	1675285315021	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
agdiwm9hoofdp7e7pz5186zo67w	2023-02-01 21:01:54.916038+00	cfefgwjke6bbxpjpig618g9bpte	1	text	## Screenshots\nIf applicable, add screenshots to elaborate on the problem.	{}	1675285315027	1675285315027	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
7tqu6wtfqstrhxgse8suphmu91h	2023-02-01 21:01:55.312436+00	cukpzn8sxhtbn3krci16sa3saka	1	checkbox	Add and update descriptions with Markdown	{"value":false}	1675285315404	1675285315404	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
7ywwms93ojir75rwfectqgac44y	2023-02-01 21:01:55.312436+00	cukpzn8sxhtbn3krci16sa3saka	1	checkbox	Follow cards to get notified on the latest updates	{"value":false}	1675285315410	1675285315410	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
aqfz3whzxztd97psx5wi43xumxa	2023-02-01 21:01:54.916038+00	cfefgwjke6bbxpjpig618g9bpte	1	text	## Steps to reproduce the behavior\n\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n\nA clear and concise description of what you expected to happen.\n\n## Edition and Platform\n\n - Edition: Personal Desktop / Personal Server / Mattermost plugin\n - Version: [e.g. v0.9.0]\n - Browser and OS: [e.g. Chrome 91 on macOS, Edge 93 on Windows]\n\n## Additional context\n\nAdd any other context about the problem here.	{}	1675285315031	1675285315031	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
asftpr5xph78ntda9z7udnngbiw	2023-02-01 21:01:54.916038+00	cfefgwjke6bbxpjpig618g9bpte	1	text	## Steps to reproduce the behavior\n\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n\n*[A clear and concise description of what you expected to happen.]*\n\n## Screenshots\n\n*[If applicable, add screenshots to elaborate on the problem.]*\n\n## Edition and Platform\n\n - Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n - Version: *[e.g. v0.9.0]*\n - Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n\n*[Add any other context about the problem here.]*	{}	1675285315036	1675285315036	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
aobzs896xwbgkjp4deb816g986e	2023-02-01 21:01:54.916038+00	c4rpiqgadu7n6mk89fi9dyy994a	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675285315040	1675285315040	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
a8g5ygo39tpfe8gnqe5i47dsgna	2023-02-01 21:01:54.916038+00	cidz4imnqhir48brz6e8hxhfrhy	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675285315046	1675285315045	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
a8hyt5eqep7fwfcwhbsnuu3pgxa	2023-02-01 21:01:54.916038+00	cidz4imnqhir48brz6e8hxhfrhy	1	text	## Requirements\n- [Requirement 1]\n- [Requirement 2]\n- ...	{}	1675285315050	1675285315050	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
abmhnzpwuk38wurwejgb68866ha	2023-02-01 21:01:54.916038+00	ct7jahzpysjb4pbhxi58spwdtxh	1	text	## Summary\n*[Brief description of what this epic is about]*\n\n## Motivation\n*[Brief description on why this is needed]*\n\n## Acceptance Criteria\n - *[Criteron 1]*\n - *[Criteron 2]*\n - ...\n\n## Personas\n - *[Persona A]*\n - *[Persona B]*\n - ...\n\n## Reference Materials\n - *[Links to other relevant documents as needed]*\n - ...	{}	1675285315056	1675285315056	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
7f96e5xpuf38xfc6bqzwimgxoje	2023-02-01 21:01:54.916038+00	cqwxtbrobujg58gqcfamejkhxkw	1	image		{"fileId":"7pbp4qg415pbstc6enzeicnu3qh.png"}	1675285315061	1675285315061	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
akxzotnktgib9tbk3j6uyix4udy	2023-02-01 21:01:54.916038+00	cqwxtbrobujg58gqcfamejkhxkw	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675285315067	1675285315067	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
agrw435r3yjdtpremce3r6d4dfr	2023-02-01 21:01:54.916038+00	cqwxtbrobujg58gqcfamejkhxkw	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675285315072	1675285315072	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
azzr1yefgz7nimd47c5opf41qqc	2023-02-01 21:01:55.312436+00	coe9fht9rx7fa8ngd7s6wscbi6y	1	text	After you've copied the link, paste it into any channel or Direct Message to share the card. A preview of the card will display within the channel with a link back to the card on Boards.	{}	1675285315486	1675285315486	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
a4mc7zebjw3dgi8has51fpr5djr	2023-02-01 21:01:54.916038+00	cwrq9ag3p5pgzzy98nfd3wwra1w	1	text	## Summary\n[Brief description of what this epic is about]\n\n## Motivation\n[Brief description on why this is needed]\n\n## Acceptance Criteria\n - [Criteron 1]\n - [Criteron 2]\n - ...\n\n## Personas\n - [Persona A]\n - [Persona B]\n - ...\n\n## Reference Materials\n - [Links to other relevant documents as needed]\n - ...	{}	1675285315083	1675285315083	0	\N	system		system	btqbtub75ybyitqe86bjikuxwmr
cu1ggrzabwpg17jwh9pbf6uhirc	2023-02-01 21:01:55.312436+00	buixxjic3xjfkieees4iafdrznc	1	card	Drag cards	{"contentOrder":["apktbgtee5jb8xrnqy3ibiujxew","ahpy4kassrbfrj8yxemrh4179pw"],"icon":"🤏","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#dragging-cards","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1675285315319	1675285315319	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
cukpzn8sxhtbn3krci16sa3saka	2023-02-01 21:01:55.312436+00	buixxjic3xjfkieees4iafdrznc	1	card	Manage tasks with cards	{"contentOrder":["ay3fyzpqpz7ygm8giqut139rwiw","7fdsxg4gpa3ycxqzg9omc7osoko","7ma1kot1hipng7pkr8jadcu8dwy","784uu3ufcgb878ky7hyugmf6xcw","71be7uuu8h7rbpeyf91dk34xdgy","7tqu6wtfqstrhxgse8suphmu91h","7hh5okxxowp8gidkf7d1njimuye","7nb8y7jyoetro8cd36qcju53z8c","7ywwms93ojir75rwfectqgac44y","7h1eoa56ahin588rggnxxz6b9bo","76nwb9tqfsid5jx46yw34itqima","7dy3mcgzgybf1ifa3emgewkzj7e","a5ca6tii33bfw8ba36y1rswq3he","7876od6xhffr6fy69zeogag7eyw","7x7bq9awkatbm5x4docbh5gaw4y","7ghpx9qff43dgtke1rwidmge1ho","7nb8y7jyoetro8cd36qcju53z8c","7hdyxemhbytfm3m83g88djq9nhr","7pgnejxokubbe9kdrxj6g9qa41e","7hw9z6qtx8jyizkmm9g5yq3gxcy","7gk6ooz6npbb8by5rgp9aig7tua","75134sysbt7dmbric3ygi8is36r"],"icon":"☑️","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"amm6wfhnbuxojwssyftgs9dipqe","acypkejeb5yfujhj9te57p9kaxw":"aanaehcw3m13jytujsjk5hpf6ry"}}	1675285315323	1675285315323	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
c9hy3rkeymprhbro69c9zqyo5re	2023-02-01 21:01:55.312436+00	buixxjic3xjfkieees4iafdrznc	1	card	Create your own board	{"contentOrder":["ao563bjzunpygtm3ykszf51f6oy","ag4u173nywprbixwwuh9i6m88pc","7r9my1yuddbn45dojrfht3neg8c","7eir5gdjxgjbsxpbyp3df4npcze","7gzrme78yx7nejxpphbzroq5ddc"],"icon":"📋","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#adding-new-boards","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"amm6wfhnbuxojwssyftgs9dipqe","acypkejeb5yfujhj9te57p9kaxw":"aanaehcw3m13jytujsjk5hpf6ry"}}	1675285315328	1675285315328	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
7fdsxg4gpa3ycxqzg9omc7osoko	2023-02-01 21:01:55.312436+00	cukpzn8sxhtbn3krci16sa3saka	1	checkbox	Set priorities and update statuses	{"value":false}	1675285315416	1675285315416	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
7hh5okxxowp8gidkf7d1njimuye	2023-02-01 21:01:55.312436+00	cukpzn8sxhtbn3krci16sa3saka	1	checkbox	Provide feedback and ask questions via comments	{"value":false}	1675285315422	1675285315422	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
cq75jez4drp84jpbktqbx8ko7se	2023-02-01 21:01:55.312436+00	buixxjic3xjfkieees4iafdrznc	1	card	Share a board	{"contentOrder":["ax34fardyitn67deep8dgummjte","abbz61swbufbf88jsjhs6nqh8dc","7r7asyew8d7fyunf4sow8e5iyoc","ad8j3n8tp77bppee3ipjt6odgpe","7w935usqt6pby8qz9x5pxaj7iow","7ogbs8h6q4j8z7ngy1m7eag63nw","7z1jau5qy3jfcxdp5cgq3duk6ne","747noxpdrhpbyigsoyr48rg3bwc"],"icon":"📤","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/sharing-boards.html","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1675285315332	1675285315332	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
czd377jwygtr57nqgpkmhzwyf1h	2023-02-01 21:01:55.312436+00	buixxjic3xjfkieees4iafdrznc	1	card	Create a new card	{"contentOrder":["a9xbubn9xmpd63c9ej3zf8my9wr","adhsx4h5ss7rqdcjt8xyam6xtqc","aa1i7uq4nffg1fxk9f85uirj9we","7me9p46gbqiyfmfnapi7dyxb5br","7647wzwdcbpdrujuhmg3btgwipo"],"icon":"📝","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#adding-cards","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"amm6wfhnbuxojwssyftgs9dipqe","acypkejeb5yfujhj9te57p9kaxw":"aanaehcw3m13jytujsjk5hpf6ry"}}	1675285315337	1675285315337	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
coe9fht9rx7fa8ngd7s6wscbi6y	2023-02-01 21:01:55.312436+00	buixxjic3xjfkieees4iafdrznc	1	card	Share cards on Channels	{"contentOrder":["anf18mxnxtjfyfgn4uwa4d3k9ma","a6wpf9kwx7tdebdtdp5eotohyza","azzr1yefgz7nimd47c5opf41qqc","7wajetc4u1tyajrwc1wobwufcih"],"icon":"📮","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html#share-card-previews","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"af3p8ztcyxgn8wd9z4az7o9tjeh","acypkejeb5yfujhj9te57p9kaxw":"ascd7nm9r491ayot8i86g1gmgqw"}}	1675285315341	1675285315341	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
ckinu9rtwafdi8y6izc6qg74k7w	2023-02-01 21:01:55.312436+00	buixxjic3xjfkieees4iafdrznc	1	card	Filter and sort cards	{"contentOrder":["a4fz9kcfs9ibj8puk9mux7ac94c","axai7yjih6jy4mekcdjdzxw94pr","78i8aqjmqtibr7x4okhz6uqquqr","77mm4c6cug7dp5jg4w9snhkaqth"],"icon":"🎛️","isTemplate":false,"properties":{"a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1675285315346	1675285315346	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
cwbgwt8w9r3fpm8metpb9c4zrpc	2023-02-01 21:01:55.312436+00	buixxjic3xjfkieees4iafdrznc	1	card	Create a new view	{"contentOrder":["aozbezukpgif3jpbsq7tahmmp5e","asksigkxeu7gstp5yduaokrgm9c","7owai1ux3h3gtf8byynfk6hyx1c","7n8jq1dizyfgotby3o91arf1hxh","77y4wffj1ctg7xmm9bx45qn6q6o","7d1hxfztimpn6uj4d3rpd5uiydr"],"icon":"👓","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#adding-new-views","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"af3p8ztcyxgn8wd9z4az7o9tjeh","acypkejeb5yfujhj9te57p9kaxw":"ascd7nm9r491ayot8i86g1gmgqw"}}	1675285315350	1675285315350	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
c5rqxuzrn9tf99ghn6srapgt8jr	2023-02-01 21:01:55.312436+00	buixxjic3xjfkieees4iafdrznc	1	card	Add new properties	{"contentOrder":["adtuhtdxccinoibzo61wirrf5kr","ayhk11qsuz789fk8bqae4oz8mro","7gc3z8cf8rirgfyutwoke9nn6jy","76cinqnb6k3dzmfbm9fnc8eofny","7uujbdoffb3n3tfjjdc5xg8emeh"],"icon":"🏷️","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html#add-and-manage-properties","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"af3p8ztcyxgn8wd9z4az7o9tjeh","acypkejeb5yfujhj9te57p9kaxw":"ascd7nm9r491ayot8i86g1gmgqw"}}	1675285315354	1675285315354	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
cpu8f4mkqjty9my48uqu3rqtqqw	2023-02-01 21:01:55.312436+00	buixxjic3xjfkieees4iafdrznc	1	card	@mention teammates	{"contentOrder":["azmczx5rmzi8kmc6ngamkmb7cmy","adakjec8bwfyo7pud3ch3qxowxh","7mbw9t71hjbrydgzgkqqaoh8usr","7tn48dj54ef8w7kqbzo93t4drbo"],"icon":"🔔","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html#mention-people","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1675285315360	1675285315360	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
vkt3i1hoqxfdb5merjssupsyyac	2023-02-01 21:01:55.312436+00	buixxjic3xjfkieees4iafdrznc	1	view	Preview: Table View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":280,"a972dc7a-5f4c-45d2-8044-8c28c69717f1":100,"acypkejeb5yfujhj9te57p9kaxw":169},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a972dc7a-5f4c-45d2-8044-8c28c69717f1","aqh13jabwexjkzr3jqsz1i1syew","acmg7mz1rr1eykfug4hcdpb1y1o","acypkejeb5yfujhj9te57p9kaxw"]}	1675285315365	1675285315364	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
v84pptna67jb9trghufkd83gdxa	2023-02-01 21:01:55.312436+00	buixxjic3xjfkieees4iafdrznc	1	view	Preview: Calendar View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"acmg7mz1rr1eykfug4hcdpb1y1o","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675285315370	1675285315370	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
vpc6da4cio7yoddbbedwcojykyh	2023-02-01 21:01:55.312436+00	buixxjic3xjfkieees4iafdrznc	1	view	Preview: Gallery View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"gallery","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675285315378	1675285315378	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
vurut55y7sjyuumy5gbiwrt5bph	2023-02-01 21:01:55.312436+00	buixxjic3xjfkieees4iafdrznc	1	view	Onboarding	{"cardOrder":["czd377jwygtr57nqgpkmhzwyf1h","cukpzn8sxhtbn3krci16sa3saka","c9hy3rkeymprhbro69c9zqyo5re","coe9fht9rx7fa8ngd7s6wscbi6y","c5rqxuzrn9tf99ghn6srapgt8jr","cwbgwt8w9r3fpm8metpb9c4zrpc","cpu8f4mkqjty9my48uqu3rqtqqw","cu1ggrzabwpg17jwh9pbf6uhirc","cq75jez4drp84jpbktqbx8ko7se","ckinu9rtwafdi8y6izc6qg74k7w"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a972dc7a-5f4c-45d2-8044-8c28c69717f1","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["aqb5x3pt87dcc9stbk4ofodrpoy","a1mtm777bkagq3iuu7xo9b13qfr","auxbwzptiqzkii5r61uz3ndsy1r","aj9386k1bx8qwmepeuxg3b7z4pw"],"visiblePropertyIds":[]}	1675285315383	1675285315383	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
ahpy4kassrbfrj8yxemrh4179pw	2023-02-01 21:01:55.312436+00	cu1ggrzabwpg17jwh9pbf6uhirc	1	text	Mattermost Boards makes it easy for you to update certain properties on cards through our drag and drop functionality. Simply drag this card from the **Later** column to the **Completed** column to automatically update the status and mark this task as complete.	{}	1675285315388	1675285315388	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
71be7uuu8h7rbpeyf91dk34xdgy	2023-02-01 21:01:55.312436+00	cukpzn8sxhtbn3krci16sa3saka	1	checkbox	Assign tasks to teammates	{"value":false}	1675285315394	1675285315394	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
7h1eoa56ahin588rggnxxz6b9bo	2023-02-01 21:01:55.312436+00	cukpzn8sxhtbn3krci16sa3saka	1	checkbox	@mention teammates so they can follow, and collaborate on, comments and descriptions	{"value":false}	1675285315430	1675285315430	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
7ma1kot1hipng7pkr8jadcu8dwy	2023-02-01 21:01:55.312436+00	cukpzn8sxhtbn3krci16sa3saka	1	checkbox	Manage deadlines and milestones	{"value":false}	1675285315435	1675285315435	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
ay3fyzpqpz7ygm8giqut139rwiw	2023-02-01 21:01:55.312436+00	cukpzn8sxhtbn3krci16sa3saka	1	text	Cards allow your entire team to manage and collaborate on a task in one place. Within a card, your team can:	{}	1675285315440	1675285315440	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
7gzrme78yx7nejxpphbzroq5ddc	2023-02-01 21:01:55.312436+00	c9hy3rkeymprhbro69c9zqyo5re	1	image		{"fileId":"74uia99m9btr8peydw7oexn37tw.gif"}	1675285315446	1675285315446	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
ao563bjzunpygtm3ykszf51f6oy	2023-02-01 21:01:55.312436+00	c9hy3rkeymprhbro69c9zqyo5re	1	text	A board helps you manage your project, organize tasks, and collaborate with your team all in one place.	{}	1675285315450	1675285315450	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
ag4u173nywprbixwwuh9i6m88pc	2023-02-01 21:01:55.312436+00	c9hy3rkeymprhbro69c9zqyo5re	1	text	To create your own board, select the "+" on the top of the left hand sidebar. Choose from one of our standard templates and see how they can help you get started with your next project:\n\n- **Project Tasks**: Stay on top of your project tasks, track progress, and set priorities. \n- **Meeting Agenda**: Set your meeting agendas for recurring team meetings and 1:1s.\n- **Roadmap**: Plan your roadmap and manage your releases more efficiently.\n- **Personal Tasks**: Organize your life and track your personal tasks.\n- **Content Calendar**: Plan your editorial content, assign work, and track deadlines.\n- **Personal Goals**: Set and accomplish new personal goals and milestones.	{}	1675285315453	1675285315453	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
747noxpdrhpbyigsoyr48rg3bwc	2023-02-01 21:01:55.312436+00	cq75jez4drp84jpbktqbx8ko7se	1	image		{"fileId":"7knxbyuiedtdafcgmropgkrtybr.gif"}	1675285315456	1675285315456	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
ax34fardyitn67deep8dgummjte	2023-02-01 21:01:55.312436+00	cq75jez4drp84jpbktqbx8ko7se	1	text	Keep stakeholders and customers up-to-date on project progress by sharing your board.	{}	1675285315459	1675285315459	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
abbz61swbufbf88jsjhs6nqh8dc	2023-02-01 21:01:55.312436+00	cq75jez4drp84jpbktqbx8ko7se	1	text	To share a board, select **Share** at the top right of the Board view. Copy the link to share the board internally with your team or generate public link that can be accessed by anyone externally.	{}	1675285315464	1675285315464	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
7647wzwdcbpdrujuhmg3btgwipo	2023-02-01 21:01:55.312436+00	czd377jwygtr57nqgpkmhzwyf1h	1	image		{"fileId":"7iw4rxx7jj7bypmdotd9z469cyh.png"}	1675285315468	1675285315468	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
aa1i7uq4nffg1fxk9f85uirj9we	2023-02-01 21:01:55.312436+00	czd377jwygtr57nqgpkmhzwyf1h	1	text	To create a new card, simply do any of the following:\n- Select "**New**" on the top right header\n- Select "**+ New**" below any column\n- Select "**+**" to the right of any columnn header	{}	1675285315473	1675285315473	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
a9xbubn9xmpd63c9ej3zf8my9wr	2023-02-01 21:01:55.312436+00	czd377jwygtr57nqgpkmhzwyf1h	1	text	Mattermost Boards helps you manage and track all your project tasks with **Cards**.	{}	1675285315477	1675285315477	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
7wajetc4u1tyajrwc1wobwufcih	2023-02-01 21:01:55.312436+00	coe9fht9rx7fa8ngd7s6wscbi6y	1	image		{"fileId":"7ek6wbpp19jfoujs1goh6kttbby.gif"}	1675285315482	1675285315482	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
a6wpf9kwx7tdebdtdp5eotohyza	2023-02-01 21:01:55.312436+00	coe9fht9rx7fa8ngd7s6wscbi6y	1	text	To share a card, you'll need to copy the card link first. You can:\n\n- Open a card and select the options menu button at the top right of the card.\n- Open the board view and hover your mouse over any card to access the options menu button.	{}	1675285315493	1675285315493	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
anf18mxnxtjfyfgn4uwa4d3k9ma	2023-02-01 21:01:55.312436+00	coe9fht9rx7fa8ngd7s6wscbi6y	1	text	Cards can be linked and shared with teammates directly on Channels. Card previews are displayed when shared on Channels, so your team can discuss work items and get the relevant context without having to switch over to Boards.	{}	1675285315499	1675285315499	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
77mm4c6cug7dp5jg4w9snhkaqth	2023-02-01 21:01:55.312436+00	ckinu9rtwafdi8y6izc6qg74k7w	1	image		{"fileId":"7dybb6t8fj3nrdft7nerhuf784y.png"}	1675285315505	1675285315505	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
axai7yjih6jy4mekcdjdzxw94pr	2023-02-01 21:01:55.312436+00	ckinu9rtwafdi8y6izc6qg74k7w	1	text	Organize and find the cards you're looking for with our filter, sort, and grouping options. From the Board header, you can quickly toggle on different properties, change the group display, set filters, and change how the cards are sorted.	{}	1675285315522	1675285315522	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
7d1hxfztimpn6uj4d3rpd5uiydr	2023-02-01 21:01:55.312436+00	cwbgwt8w9r3fpm8metpb9c4zrpc	1	image		{"fileId":"78jws5m1myf8pufewzkaa6i11sc.gif"}	1675285315528	1675285315528	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
asksigkxeu7gstp5yduaokrgm9c	2023-02-01 21:01:55.312436+00	cwbgwt8w9r3fpm8metpb9c4zrpc	1	text	Views allow your team to visualize the same cards and data from different perspectives, so they can stay up-to-date in the way that works best for them. To add a new view, go to **Add a new view** from the view drop-down, then select from any of the following views:\n\n- **Board**: Adds a Kanban board, similar to this one, that allows your team to organize cards in swimlanes grouped by any property of your choosing. This view helps you visualize your project progress.\n- **Table**: Displays cards in a table format with rows and columns. Use this view to get an overview of all your project tasks. Easily view and compare the state of all properties across all cards without needing to open individual cards.\n- **Gallery**: Displays cards in a gallery format, so you can manage and organize cards with image attachments.\n- **Calendar**: Adds a calendar view to easily visualize your cards by dates and keep track of deadlines.	{}	1675285315533	1675285315533	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
7uujbdoffb3n3tfjjdc5xg8emeh	2023-02-01 21:01:55.312436+00	c5rqxuzrn9tf99ghn6srapgt8jr	1	image		{"fileId":"7d6hrtig3zt8f9cnbo1um5oxx3y.gif"}	1675285315539	1675285315539	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
adtuhtdxccinoibzo61wirrf5kr	2023-02-01 21:01:55.312436+00	c5rqxuzrn9tf99ghn6srapgt8jr	1	text	Customize cards to fit your needs and track the information most important to you. Boards supports a wide range of fully customizable property types. For example, you can:\n- Use the **Date** property for things like deadlines or milestones.\n- Assign owners to tasks with the **Person** property.\n- Define statuses and priorities with the **Select** property.\n- Create tags with the **Multi Select** property.\n- Link cards to webpages with the **URL** property.	{}	1675285315545	1675285315545	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
7tn48dj54ef8w7kqbzo93t4drbo	2023-02-01 21:01:55.312436+00	cpu8f4mkqjty9my48uqu3rqtqqw	1	image		{"fileId":"74nt9eqzea3ydjjpgjtsxcjgrxc.gif"}	1675285315550	1675285315550	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
adakjec8bwfyo7pud3ch3qxowxh	2023-02-01 21:01:55.312436+00	cpu8f4mkqjty9my48uqu3rqtqqw	1	text	To mention a teammate use the **@ symbol with their username** in the comments or description section. They'll get a Direct Message notification via Channels and also be added as a [follower](https://docs.mattermost.com/boards/work-with-cards.html#receive-updates) to the card. \n\nWhenever any changes are made to the card, they'll automatically get notified on Channels.	{}	1675285315556	1675285315556	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
azmczx5rmzi8kmc6ngamkmb7cmy	2023-02-01 21:01:55.312436+00	cpu8f4mkqjty9my48uqu3rqtqqw	1	text	Collaborate with teammates directly on each card using @mentions and have all the relevant context in one place.	{}	1675285315562	1675285315562	0	\N	system		system	b55a5epzey7dqik9yr96gjtppmr
\.


--
-- Data for Name: focalboard_board_members; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_board_members (board_id, user_id, roles, scheme_admin, scheme_editor, scheme_commenter, scheme_viewer) FROM stdin;
b4cyhfatknfga9paqdgkoiatddo	system		t	f	f	f
bibxp8mmpkjdoijx58xnmcchgmr	system		t	f	f	f
b6hhefpcchbyy9f1pc15a15wobr	system		t	f	f	f
b7q1dux1e8f8gmmg5zhexdr5gwy	system		t	f	f	f
bm9cpg1atuf8n3m9rd3mbf5d7yc	system		t	f	f	f
b9wgudz1ippgf7map6ygr7tydza	system		t	f	f	f
bp9zz8foamiyadchistmtnj7bro	system		t	f	f	f
bjwjkmputh7dn8mequhmmfrhnba	system		t	f	f	f
b94e89e4eyib89q8aayocgudx7a	system		t	f	f	f
br7ayzinnkfryudqw8jpuqpwniw	system		t	f	f	f
bydniqgzqq3bwm8kw55a67d93oo	system		t	f	f	f
btqbtub75ybyitqe86bjikuxwmr	system		t	f	f	f
b55a5epzey7dqik9yr96gjtppmr	system		t	f	f	f
\.


--
-- Data for Name: focalboard_board_members_history; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_board_members_history (board_id, user_id, action, insert_at) FROM stdin;
b4cyhfatknfga9paqdgkoiatddo	system	created	2023-02-01 21:01:51.040877+00
bibxp8mmpkjdoijx58xnmcchgmr	system	created	2023-02-01 21:01:52.178761+00
b6hhefpcchbyy9f1pc15a15wobr	system	created	2023-02-01 21:01:52.487465+00
b7q1dux1e8f8gmmg5zhexdr5gwy	system	created	2023-02-01 21:01:53.227359+00
bm9cpg1atuf8n3m9rd3mbf5d7yc	system	created	2023-02-01 21:01:53.507479+00
b9wgudz1ippgf7map6ygr7tydza	system	created	2023-02-01 21:01:53.688043+00
bp9zz8foamiyadchistmtnj7bro	system	created	2023-02-01 21:01:54.129263+00
bjwjkmputh7dn8mequhmmfrhnba	system	created	2023-02-01 21:01:54.297543+00
b94e89e4eyib89q8aayocgudx7a	system	created	2023-02-01 21:01:54.562479+00
br7ayzinnkfryudqw8jpuqpwniw	system	created	2023-02-01 21:01:54.800625+00
bydniqgzqq3bwm8kw55a67d93oo	system	created	2023-02-01 21:01:54.912823+00
btqbtub75ybyitqe86bjikuxwmr	system	created	2023-02-01 21:01:55.285471+00
b55a5epzey7dqik9yr96gjtppmr	system	created	2023-02-01 21:01:55.890024+00
\.


--
-- Data for Name: focalboard_boards; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_boards (id, insert_at, team_id, channel_id, created_by, modified_by, type, title, description, icon, show_description, is_template, template_version, properties, card_properties, create_at, update_at, delete_at, minimum_role) FROM stdin;
b4cyhfatknfga9paqdgkoiatddo	2023-02-01 21:01:50.459085+00	0		system	system	O	Meeting Agenda 	Use this template for recurring meeting agendas, like team meetings and 1:1's. To use this board:\n* Participants queue new items to discuss under "To Discuss"\n* Go through items during the meeting\n* Move items to Done or Revisit Later as needed	🍩	t	t	6	{"trackingTemplateId": "54fcf9c610f0ac5e4c522c0657c90602"}	[{"id": "d777ba3b-8728-40d1-87a6-59406bbbbfb0", "name": "Status", "type": "select", "options": [{"id": "34eb9c25-d5bf-49d9-859e-f74f4e0030e7", "color": "propColorPink", "value": "To Discuss 💬"}, {"id": "d37a61f4-f332-4db9-8b2d-5e0a91aa20ed", "color": "propColorYellow", "value": "Revisit Later ⏳"}, {"id": "dabadd9b-adf1-4d9f-8702-805ac6cef602", "color": "propColorGreen", "value": "Done / Archived 📦"}]}, {"id": "4cf1568d-530f-4028-8ffd-bdc65249187e", "name": "Priority", "type": "select", "options": [{"id": "8b05c83e-a44a-4d04-831e-97f01d8e2003", "color": "propColorRed", "value": "1. High"}, {"id": "b1abafbf-a038-4a19-8b68-56e0fd2319f7", "color": "propColorYellow", "value": "2. Medium"}, {"id": "2491ffaa-eb55-417b-8aff-4bd7d4136613", "color": "propColorGray", "value": "3. Low"}]}, {"id": "aw4w63xhet79y9gueqzzeiifdoe", "name": "Created by", "type": "createdBy", "options": []}, {"id": "a6ux19353xcwfqg9k1inqg5sg4w", "name": "Created time", "type": "createdTime", "options": []}]	1675285310462	1675285310462	0	
bibxp8mmpkjdoijx58xnmcchgmr	2023-02-01 21:01:51.066397+00	0		system	system	O	Sales Pipeline CRM	Use this template to grow and keep track of your sales opportunities.	📈	t	t	6	{"trackingTemplateId": "ecc250bb7dff0fe02247f1110f097544"}	[{"id": "a5hwxjsmkn6bak6r7uea5bx1kwc", "name": "Status", "type": "select", "options": [{"id": "akj61wc9yxdwyw3t6m8igyf9d5o", "color": "propColorGray", "value": "Lead"}, {"id": "aic89a5xox4wbppi6mbyx6ujsda", "color": "propColorYellow", "value": "Qualified"}, {"id": "ah6ehh43rwj88jy4awensin8pcw", "color": "propColorBrown", "value": "Meeting"}, {"id": "aprhd96zwi34o9cs4xyr3o9sf3c", "color": "propColorPurple", "value": "Proposal"}, {"id": "axesd74yuxtbmw1sbk8ufax7z3a", "color": "propColorOrange", "value": "Negotiation"}, {"id": "a5txuiubumsmrs8gsd5jz5gc1oa", "color": "propColorRed", "value": "Lost"}, {"id": "acm9q494bcthyoqzmfogxxy5czy", "color": "propColorGreen", "value": "Closed 🏆"}]}, {"id": "aoheuj1f3mu6eehygr45fxa144y", "name": "Account Owner", "type": "multiPerson", "options": []}, {"id": "aro91wme9kfaie5ceu9qasmtcnw", "name": "Priority", "type": "select", "options": [{"id": "apjnaggwixchfxwiatfh7ey7uno", "color": "propColorRed", "value": "High 🔥"}, {"id": "apiswzj7uiwbh87z8dw8c6mturw", "color": "propColorYellow", "value": "Medium"}, {"id": "auu9bfzqeuruyjwzzqgz7q8apuw", "color": "propColorBrown", "value": "Low"}]}, {"id": "ainpw47babwkpyj77ic4b9zq9xr", "name": "Company", "type": "text", "options": []}, {"id": "ahf43e44h3y8ftanqgzno9z7q7w", "name": "Estimated Value", "type": "number", "options": []}, {"id": "amahgyn9n4twaapg3jyxb6y4jic", "name": "Territory", "type": "select", "options": [{"id": "ar6t1ttcumgfuqugg5o4g4mzrza", "color": "propColorBrown", "value": "Western US"}, {"id": "asbwojkm7zb4ohrtij97jkdfgwe", "color": "propColorGreen", "value": "Mountain West / Central US"}, {"id": "aw8ppwtcrm8iwopdadje3ni196w", "color": "propColorGray", "value": "Mid-Atlantic / Southeast"}, {"id": "aafwyza5iwdcwcyfyj6bp7emufw", "color": "propColorBlue", "value": "Northeast US / Canada"}, {"id": "agw8rcb9uxyt3c7g6tq3r65fgqe", "color": "propColorPink", "value": "Eastern Europe"}, {"id": "as5bk6afoaaa7caewe1zc391sce", "color": "propColorPurple", "value": "Central Europe / Africa"}, {"id": "a8fj94bka8z9t6p95qd3hn6t5re", "color": "propColorYellow", "value": "Middle East"}, {"id": "arpxa3faaou9trt4zx5sh435gne", "color": "propColorOrange", "value": "UK"}, {"id": "azdidd5wze4kcxf8neefj3ctkyr", "color": "propColorRed", "value": "Asia"}, {"id": "a4jn5mhqs3thknqf5opykntgsnc", "color": "propColorGray", "value": "Australia"}, {"id": "afjbgrecb7hp5owj7xh8u4w33tr", "color": "propColorBrown", "value": "Latin America"}]}, {"id": "abru6tz8uebdxy4skheqidh7zxy", "name": "Email", "type": "email", "options": []}, {"id": "a1438fbbhjeffkexmcfhnx99o1h", "name": "Phone", "type": "phone", "options": []}, {"id": "auhf91pm85f73swwidi4wid8jqe", "name": "Last Contact Date", "type": "date", "options": []}, {"id": "adtf1151chornmihz4xbgbk9exa", "name": "Expected Close", "type": "date", "options": []}, {"id": "aejo5tcmq54bauuueem9wc4fw4y", "name": "Close Probability", "type": "text", "options": []}, {"id": "amba7ot98fh7hwsx8jdcfst5g7h", "name": "Created Date", "type": "createdTime", "options": []}]	1675285311072	1675285311072	0	
b6hhefpcchbyy9f1pc15a15wobr	2023-02-01 21:01:52.182013+00	0		system	system	O	Personal Tasks 	Use this template to organize your life and track your personal tasks.	✔️	t	t	6	{"trackingTemplateId": "dfb70c146a4584b8a21837477c7b5431"}	[{"id": "a9zf59u8x1rf4ywctpcqama7tio", "name": "Occurrence", "type": "select", "options": [{"id": "an51dnkenmoog9cetapbc4uyt3y", "color": "propColorBlue", "value": "Daily"}, {"id": "afpy8s7i45frggprmfsqngsocqh", "color": "propColorOrange", "value": "Weekly"}, {"id": "aj4jyekqqssatjcq7r7chmy19ey", "color": "propColorPurple", "value": "Monthly"}]}, {"id": "abthng7baedhhtrwsdodeuincqy", "name": "Completed", "type": "checkbox", "options": []}]	1675285312186	1675285312186	0	
b7q1dux1e8f8gmmg5zhexdr5gwy	2023-02-01 21:01:52.583303+00	0		system	system	O	Project Tasks 	Use this template to stay on top of your project tasks and progress.	🎯	t	t	6	{"trackingTemplateId": "a4ec399ab4f2088b1051c3cdf1dde4c3"}	[{"id": "a972dc7a-5f4c-45d2-8044-8c28c69717f1", "name": "Status", "type": "select", "options": [{"id": "ayz81h9f3dwp7rzzbdebesc7ute", "color": "propColorBlue", "value": "Not Started"}, {"id": "ar6b8m3jxr3asyxhr8iucdbo6yc", "color": "propColorYellow", "value": "In Progress"}, {"id": "afi4o5nhnqc3smtzs1hs3ij34dh", "color": "propColorRed", "value": "Blocked"}, {"id": "adeo5xuwne3qjue83fcozekz8ko", "color": "propColorGreen", "value": "Completed 🙌"}, {"id": "ahpyxfnnrzynsw3im1psxpkgtpe", "color": "propColorBrown", "value": "Archived"}]}, {"id": "d3d682bf-e074-49d9-8df5-7320921c2d23", "name": "Priority", "type": "select", "options": [{"id": "d3bfb50f-f569-4bad-8a3a-dd15c3f60101", "color": "propColorRed", "value": "1. High 🔥"}, {"id": "87f59784-b859-4c24-8ebe-17c766e081dd", "color": "propColorYellow", "value": "2. Medium"}, {"id": "98a57627-0f76-471d-850d-91f3ed9fd213", "color": "propColorGray", "value": "3. Low"}]}, {"id": "axkhqa4jxr3jcqe4k87g8bhmary", "name": "Assignee", "type": "person", "options": []}, {"id": "a8daz81s4xjgke1ww6cwik5w7ye", "name": "Estimated Hours", "type": "number", "options": []}, {"id": "a3zsw7xs8sxy7atj8b6totp3mby", "name": "Due Date", "type": "date", "options": []}, {"id": "a7gdnz8ff8iyuqmzddjgmgo9ery", "name": "Created By", "type": "createdBy", "options": []}, {"id": "2a5da320-735c-4093-8787-f56e15cdfeed", "name": "Date Created", "type": "createdTime", "options": []}]	1675285312586	1675285312586	0	
bm9cpg1atuf8n3m9rd3mbf5d7yc	2023-02-01 21:01:53.231087+00	0		system	system	O	Company Goals & OKRs	Use this template to plan your company goals and OKRs more efficiently.	⛳	t	t	6	{"trackingTemplateId": "7ba22ccfdfac391d63dea5c4b8cde0de"}	[{"id": "a6amddgmrzakw66cidqzgk6p4ge", "name": "Objective", "type": "select", "options": [{"id": "auw3afh3kfhrfgmjr8muiz137jy", "color": "propColorGreen", "value": "Grow Revenue"}, {"id": "apqfjst8massbjjhpcsjs3y1yqa", "color": "propColorOrange", "value": "Delight Customers"}, {"id": "ao9b5pxyt7tkgdohzh9oaustdhr", "color": "propColorPurple", "value": "Drive Product Adoption"}]}, {"id": "a17ryhi1jfsboxkwkztwawhmsxe", "name": "Status", "type": "select", "options": [{"id": "a6robxx81diugpjq5jkezz3j1fo", "color": "propColorGray", "value": "Not Started"}, {"id": "a8nukezwwmknqwjsygg7eaxs9te", "color": "propColorBlue", "value": "In Progress"}, {"id": "apnt1f7na9rzgk1rt49keg7xbiy", "color": "propColorYellow", "value": "At Risk"}, {"id": "axbz3m1amss335wzwf9s7pqjzxr", "color": "propColorRed", "value": "Missed"}, {"id": "abzfwnn6rmtfzyq5hg8uqmpsncy", "color": "propColorGreen", "value": "Complete 🙌"}]}, {"id": "azzbawji5bksj69sekcs4srm1ky", "name": "Department", "type": "select", "options": [{"id": "aw5i7hmpadn6mbwbz955ubarhme", "color": "propColorBrown", "value": "Engineering"}, {"id": "afkxpcjqjypu7hhar7banxau91h", "color": "propColorBlue", "value": "Product"}, {"id": "aehoa17cz18rqnrf75g7dwhphpr", "color": "propColorOrange", "value": "Marketing"}, {"id": "agrfeaoj7d8p5ianw5iaf3191ae", "color": "propColorGreen", "value": "Sales"}, {"id": "agm9p6gcq15ueuzqq3wd4be39wy", "color": "propColorYellow", "value": "Support"}, {"id": "aucop7kw6xwodcix6zzojhxih6r", "color": "propColorPink", "value": "Design"}, {"id": "afust91f3g8ht368mkn5x9tgf1o", "color": "propColorPurple", "value": "Finance"}, {"id": "acocxxwjurud1jixhp7nowdig7y", "color": "propColorGray", "value": "Human Resources"}]}, {"id": "adp5ft3kgz7r5iqq3tnwg551der", "name": "Priority", "type": "select", "options": [{"id": "a8zg3rjtf4swh7smsjxpsn743rh", "color": "propColorRed", "value": "P1 🔥"}, {"id": "as555ipyzopjjpfb5rjtssecw5e", "color": "propColorYellow", "value": "P2"}, {"id": "a1ts3ftyr8nocsicui98c89uxjy", "color": "propColorGray", "value": "P3"}]}, {"id": "aqxyzkdrs4egqf7yk866ixkaojc", "name": "Quarter", "type": "select", "options": [{"id": "ahfbn1jsmhydym33ygxwg5jt3kh", "color": "propColorBlue", "value": "Q1"}, {"id": "awfu37js3fomfkkczm1zppac57a", "color": "propColorBrown", "value": "Q2"}, {"id": "anruuoyez51r3yjxuoc8zoqnwaw", "color": "propColorGreen", "value": "Q3"}, {"id": "acb6dqqs6yson7bbzx6jk9bghjh", "color": "propColorPurple", "value": "Q4"}]}, {"id": "adu6mebzpibq6mgcswk69xxmnqe", "name": "Due Date", "type": "date", "options": []}, {"id": "asope3bddhm4gpsng5cfu4hf6rh", "name": "Assignee", "type": "multiPerson", "options": []}, {"id": "ajwxp866f9obs1kutfwaa5ru7fe", "name": "Target", "type": "number", "options": []}, {"id": "azqnyswk6s1boiwuthscm78qwuo", "name": "Actual", "type": "number", "options": []}, {"id": "ahz3fmjnaguec8hce7xq3h5cjdr", "name": "Completion (%)", "type": "text", "options": []}, {"id": "a17bfcgnzmkwhziwa4tr38kiw5r", "name": "Note", "type": "text", "options": []}]	1675285313235	1675285313235	0	
b9wgudz1ippgf7map6ygr7tydza	2023-02-01 21:01:53.538374+00	0		system	system	O	Personal Goals 	Use this template to set and accomplish new personal goals.	⛰️	t	t	6	{"trackingTemplateId": "7f32dc8d2ae008cfe56554e9363505cc"}	[{"id": "af6fcbb8-ca56-4b73-83eb-37437b9a667d", "name": "Status", "type": "select", "options": [{"id": "bf52bfe6-ac4c-4948-821f-83eaa1c7b04a", "color": "propColorRed", "value": "To Do"}, {"id": "77c539af-309c-4db1-8329-d20ef7e9eacd", "color": "propColorYellow", "value": "Doing"}, {"id": "98bdea27-0cce-4cde-8dc6-212add36e63a", "color": "propColorGreen", "value": "Done 🙌"}]}, {"id": "d9725d14-d5a8-48e5-8de1-6f8c004a9680", "name": "Category", "type": "select", "options": [{"id": "3245a32d-f688-463b-87f4-8e7142c1b397", "color": "propColorPurple", "value": "Life Skills"}, {"id": "80be816c-fc7a-4928-8489-8b02180f4954", "color": "propColorGreen", "value": "Finance"}, {"id": "ffb3f951-b47f-413b-8f1d-238666728008", "color": "propColorOrange", "value": "Health"}]}, {"id": "d6b1249b-bc18-45fc-889e-bec48fce80ef", "name": "Target", "type": "select", "options": [{"id": "9a090e33-b110-4268-8909-132c5002c90e", "color": "propColorBlue", "value": "Q1"}, {"id": "0a82977f-52bf-457b-841b-e2b7f76fb525", "color": "propColorBrown", "value": "Q2"}, {"id": "6e7139e4-5358-46bb-8c01-7b029a57b80a", "color": "propColorGreen", "value": "Q3"}, {"id": "d5371c63-66bf-4468-8738-c4dc4bea4843", "color": "propColorPurple", "value": "Q4"}]}, {"id": "ajy6xbebzopojaenbnmfpgtdwso", "name": "Due Date", "type": "date", "options": []}]	1675285313547	1675285313547	0	
bp9zz8foamiyadchistmtnj7bro	2023-02-01 21:01:53.698735+00	0		system	system	O	Sprint Planner 	Use this template to plan your sprints and manage your releases more efficiently.	🗓️	t	t	6	{"trackingTemplateId": "99b74e26d2f5d0a9b346d43c0a7bfb09"}	[{"id": "50117d52-bcc7-4750-82aa-831a351c44a0", "name": "Status", "type": "select", "options": [{"id": "aft5bzo7h9aspqgrx3jpy5tzrer", "color": "propColorGray", "value": "Not Started"}, {"id": "abrfos7e7eczk9rqw6y5abadm1y", "color": "propColorOrange", "value": "Next Up"}, {"id": "ax8wzbka5ahs3zziji3pp4qp9mc", "color": "propColorBlue", "value": "In Progress"}, {"id": "atabdfbdmjh83136d5e5oysxybw", "color": "propColorYellow", "value": "In Review"}, {"id": "ace1bzypd586kkyhcht5qqd9eca", "color": "propColorPink", "value": "Approved"}, {"id": "aay656c9m1hzwxc9ch5ftymh3nw", "color": "propColorRed", "value": "Blocked"}, {"id": "a6ghze4iy441qhsh3eijnc8hwze", "color": "propColorGreen", "value": "Complete 🙌"}]}, {"id": "20717ad3-5741-4416-83f1-6f133fff3d11", "name": "Type", "type": "select", "options": [{"id": "424ea5e3-9aa1-4075-8c5c-01b44b66e634", "color": "propColorYellow", "value": "Epic ⛰"}, {"id": "a5yxq8rbubrpnoommfwqmty138h", "color": "propColorGray", "value": "Feature 🏗"}, {"id": "apht1nt5ryukdmxkh6fkfn6rgoy", "color": "propColorOrange", "value": "User Story 📖"}, {"id": "aiycbuo3dr5k4xxbfr7coem8ono", "color": "propColorGreen", "value": "Task ⛏"}, {"id": "aomnawq4551cbbzha9gxnmb3z5w", "color": "propColorRed", "value": "Bug 🐞"}]}, {"id": "60985f46-3e41-486e-8213-2b987440ea1c", "name": "Sprint", "type": "select", "options": [{"id": "c01676ca-babf-4534-8be5-cce2287daa6c", "color": "propColorBrown", "value": "Sprint 1"}, {"id": "ed4a5340-460d-461b-8838-2c56e8ee59fe", "color": "propColorPurple", "value": "Sprint 2"}, {"id": "14892380-1a32-42dd-8034-a0cea32bc7e6", "color": "propColorBlue", "value": "Sprint 3"}]}, {"id": "f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e", "name": "Priority", "type": "select", "options": [{"id": "cb8ecdac-38be-4d36-8712-c4d58cc8a8e9", "color": "propColorRed", "value": "P1 🔥"}, {"id": "e6a7f297-4440-4783-8ab3-3af5ba62ca11", "color": "propColorYellow", "value": "P2"}, {"id": "c62172ea-5da7-4dec-8186-37267d8ee9a7", "color": "propColorGray", "value": "P3"}]}, {"id": "aphg37f7zbpuc3bhwhp19s1ribh", "name": "Assignee", "type": "multiPerson", "options": []}, {"id": "a4378omyhmgj3bex13sj4wbpfiy", "name": "Due Date", "type": "date", "options": []}, {"id": "ai7ajsdk14w7x5s8up3dwir77te", "name": "Story Points", "type": "number", "options": []}, {"id": "a1g6i613dpe9oryeo71ex3c86hy", "name": "Design Link", "type": "url", "options": []}, {"id": "aeomttrbhhsi8bph31jn84sto6h", "name": "Created Time", "type": "createdTime", "options": []}, {"id": "ax9f8so418s6s65hi5ympd93i6a", "name": "Created By", "type": "createdBy", "options": []}]	1675285313706	1675285313706	0	
bjwjkmputh7dn8mequhmmfrhnba	2023-02-01 21:01:54.131682+00	0		system	system	O	User Research Sessions	Use this template to manage and keep track of all your user research sessions.	🔬	t	t	6	{"trackingTemplateId": "6c345c7f50f6833f78b7d0f08ce450a3"}	[{"id": "aaebj5fyx493eezx6ukxiwydgty", "name": "Status", "type": "select", "options": [{"id": "af6hjb3ysuaxbwnfqpby4wwnkdr", "color": "propColorGray", "value": "Backlog 📒"}, {"id": "aotxum1p5bw3xuzqz3ctjw66yww", "color": "propColorYellow", "value": "Contacted 📞"}, {"id": "a7yq89whddzob1futao4rxk3yzc", "color": "propColorBlue", "value": "Scheduled 📅"}, {"id": "aseqq9hrsua56r3s6nbuirj9eec", "color": "propColorRed", "value": "Cancelled 🚫"}, {"id": "ap93ysuzy1xa7z818r6myrn4h4y", "color": "propColorGreen", "value": "Completed ✔️"}]}, {"id": "akrxgi7p7w14fym3gbynb98t9fh", "name": "Interview Date", "type": "date", "options": []}, {"id": "atg9qu6oe4bjm8jczzsn71ff5me", "name": "Product Area", "type": "select", "options": [{"id": "ahn89mqg9u4igk6pdm7333t8i5h", "color": "propColorGreen", "value": "Desktop App"}, {"id": "aehc83ffays3gh8myz16a8j7k4e", "color": "propColorPurple", "value": "Web App"}, {"id": "a1sxagjgaadym5yrjak6tcup1oa", "color": "propColorBlue", "value": "Mobile App"}]}, {"id": "acjq4t5ymytu8x1f68wkggm7ypc", "name": "Email", "type": "email", "options": []}, {"id": "aphio1s5gkmpdbwoxynim7acw3e", "name": "Interviewer", "type": "multiPerson", "options": []}, {"id": "aqafzdeekpyncwz7m7i54q3iqqy", "name": "Recording URL", "type": "url", "options": []}, {"id": "aify3r761b9w43bqjtskrzi68tr", "name": "Passcode", "type": "text", "options": []}]	1675285314135	1675285314135	0	
b94e89e4eyib89q8aayocgudx7a	2023-02-01 21:01:54.299613+00	0		system	system	O	Competitive Analysis	Use this template to track and stay ahead of the competition.	🗂️	t	t	6	{"trackingTemplateId": "06f4bff367a7c2126fab2380c9dec23c"}	[{"id": "ahzspe59iux8wigra8bg6cg18nc", "name": "Website", "type": "url", "options": []}, {"id": "aozntq4go4nkab688j1s7stqtfc", "name": "Location", "type": "text", "options": []}, {"id": "aiefo7nh9jwisn8b4cgakowithy", "name": "Revenue", "type": "text", "options": []}, {"id": "a6cwaq79b1pdpb97wkanmeyy4er", "name": "Employees", "type": "number", "options": []}, {"id": "an1eerzscfxn6awdfajbg41uz3h", "name": "Founded", "type": "text", "options": []}, {"id": "a1semdhszu1rq17d7et5ydrqqio", "name": "Market Position", "type": "select", "options": [{"id": "arfjpz9by5car71tz3behba8yih", "color": "propColorYellow", "value": "Leader"}, {"id": "abajmr34b8g1916w495xjb35iko", "color": "propColorRed", "value": "Challenger"}, {"id": "abt79uxg5edqojsrrefcnr4eruo", "color": "propColorBlue", "value": "Follower"}, {"id": "aipf3qfgjtkheiayjuxrxbpk9wa", "color": "propColorBrown", "value": "Nicher"}]}, {"id": "aapogff3xoa8ym7xf56s87kysda", "name": "Last updated time", "type": "updatedTime", "options": []}, {"id": "az3jkw3ynd3mqmart7edypey15e", "name": "Last updated by", "type": "updatedBy", "options": []}]	1675285314303	1675285314303	0	
btqbtub75ybyitqe86bjikuxwmr	2023-02-01 21:01:54.916038+00	0		system	system	O	Roadmap 	Use this template to plan your roadmap and manage your releases more efficiently.	🗺️	t	t	6	{"trackingTemplateId": "b728c6ca730e2cfc229741c5a4712b65"}	[{"id": "50117d52-bcc7-4750-82aa-831a351c44a0", "name": "Status", "type": "select", "options": [{"id": "8c557f69-b0ed-46ec-83a3-8efab9d47ef5", "color": "propColorGray", "value": "Not Started"}, {"id": "ec6d2bc5-df2b-4f77-8479-e59ceb039946", "color": "propColorYellow", "value": "In Progress"}, {"id": "849766ba-56a5-48d1-886f-21672f415395", "color": "propColorGreen", "value": "Complete 🙌"}]}, {"id": "20717ad3-5741-4416-83f1-6f133fff3d11", "name": "Type", "type": "select", "options": [{"id": "424ea5e3-9aa1-4075-8c5c-01b44b66e634", "color": "propColorYellow", "value": "Epic ⛰"}, {"id": "6eea96c9-4c61-4968-8554-4b7537e8f748", "color": "propColorGreen", "value": "Task 🔨"}, {"id": "1fdbb515-edd2-4af5-80fc-437ed2211a49", "color": "propColorRed", "value": "Bug 🐞"}]}, {"id": "60985f46-3e41-486e-8213-2b987440ea1c", "name": "Sprint", "type": "select", "options": [{"id": "c01676ca-babf-4534-8be5-cce2287daa6c", "color": "propColorBrown", "value": "Sprint 1"}, {"id": "ed4a5340-460d-461b-8838-2c56e8ee59fe", "color": "propColorPurple", "value": "Sprint 2"}, {"id": "14892380-1a32-42dd-8034-a0cea32bc7e6", "color": "propColorBlue", "value": "Sprint 3"}]}, {"id": "f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e", "name": "Priority", "type": "select", "options": [{"id": "cb8ecdac-38be-4d36-8712-c4d58cc8a8e9", "color": "propColorRed", "value": "P1 🔥"}, {"id": "e6a7f297-4440-4783-8ab3-3af5ba62ca11", "color": "propColorYellow", "value": "P2"}, {"id": "c62172ea-5da7-4dec-8186-37267d8ee9a7", "color": "propColorGray", "value": "P3"}]}, {"id": "aphg37f7zbpuc3bhwhp19s1ribh", "name": "Assignee", "type": "person", "options": []}, {"id": "a4378omyhmgj3bex13sj4wbpfiy", "name": "Due Date", "type": "date", "options": []}, {"id": "a36o9q1yik6nmar6ri4q4uca7ey", "name": "Created Date", "type": "createdTime", "options": []}, {"id": "ai7ajsdk14w7x5s8up3dwir77te", "name": "Design Link", "type": "url", "options": []}]	1675285314921	1675285314921	0	
b55a5epzey7dqik9yr96gjtppmr	2023-02-01 21:01:55.312436+00	0		system	system	O	Welcome to Boards!	Mattermost Boards is an open source project management tool that helps you organize, track, and manage work across teams. Select a card to learn more.	👋	t	t	6	{"trackingTemplateId": "65aba997282f3ac457cd66736fb86915"}	[{"id": "a972dc7a-5f4c-45d2-8044-8c28c69717f1", "name": "Status", "type": "select", "options": [{"id": "amm6wfhnbuxojwssyftgs9dipqe", "color": "propColorRed", "value": "To do 🔥"}, {"id": "af3p8ztcyxgn8wd9z4az7o9tjeh", "color": "propColorYellow", "value": "Next up"}, {"id": "ajurey3xkocs1nwx8di5zx6oe7o", "color": "propColorPurple", "value": "Later"}, {"id": "agkinkjy5983wsk6kppsujajxqw", "color": "propColorGreen", "value": "Completed 🙌"}]}, {"id": "acypkejeb5yfujhj9te57p9kaxw", "name": "Priority", "type": "select", "options": [{"id": "aanaehcw3m13jytujsjk5hpf6ry", "color": "propColorOrange", "value": "1. High"}, {"id": "ascd7nm9r491ayot8i86g1gmgqw", "color": "propColorBrown", "value": "2. Medium"}, {"id": "aq6ukoiciyfctgwyhwzpfss8ghe", "color": "propColorGray", "value": "3. Low"}]}, {"id": "aqh13jabwexjkzr3jqsz1i1syew", "name": "Assignee", "type": "person", "options": []}, {"id": "acmg7mz1rr1eykfug4hcdpb1y1o", "name": "Due Date", "type": "date", "options": []}, {"id": "amewjwfjrtpu8ha73xsrdmxazxr", "name": "Reviewed", "type": "checkbox", "options": []}, {"id": "attzzboqaz6m1sdti5xa7gjnk1e", "name": "Last updated time", "type": "updatedTime", "options": []}, {"id": "a4nfnb5xr3txr5xq7y9ho7kyz6c", "name": "Reference", "type": "url", "options": []}, {"id": "a9gzwi3dt5n55nddej6zcbhxaeh", "name": "Created by", "type": "createdBy", "options": []}]	1675285315314	1675285315314	0	
br7ayzinnkfryudqw8jpuqpwniw	2023-02-01 21:01:54.567052+00	0		system	system	O	Content Calendar 	Use this template to plan and organize your editorial content.	📅	t	t	6	{"trackingTemplateId": "c75fbd659d2258b5183af2236d176ab4"}	[{"id": "ae9ar615xoknd8hw8py7mbyr7zo", "name": "Status", "type": "select", "options": [{"id": "awna1nuarjca99m9s4uiy9kwj5h", "color": "propColorGray", "value": "Idea 💡"}, {"id": "a9ana1e9w673o5cp8md4xjjwfto", "color": "propColorOrange", "value": "Draft"}, {"id": "apy9dcd7zmand615p3h53zjqxjh", "color": "propColorPurple", "value": "In Review"}, {"id": "acri4cm3bmay55f7ksztphmtnga", "color": "propColorBlue", "value": "Ready to Publish"}, {"id": "amsowcd9a8e1kid317r7ttw6uzh", "color": "propColorGreen", "value": "Published 🎉"}]}, {"id": "aysx3atqexotgwp5kx6h5i5ancw", "name": "Type", "type": "select", "options": [{"id": "aywiofmmtd3ofgzj95ysky4pjga", "color": "propColorOrange", "value": "Press Release"}, {"id": "apqdgjrmsmx8ngmp7zst51647de", "color": "propColorGreen", "value": "Sponsored Post"}, {"id": "a3woynbjnb7j16e74uw3pubrytw", "color": "propColorPurple", "value": "Customer Story"}, {"id": "aq36k5pkpfcypqb3idw36xdi1fh", "color": "propColorRed", "value": "Product Release"}, {"id": "azn66pmk34adygnizjqhgiac4ia", "color": "propColorGray", "value": "Partnership"}, {"id": "aj8y675weso8kpb6eceqbpj4ruw", "color": "propColorBlue", "value": "Feature Announcement"}, {"id": "a3xky7ygn14osr1mokerbfah5cy", "color": "propColorYellow", "value": "Article"}]}, {"id": "ab6mbock6styfe6htf815ph1mhw", "name": "Channel", "type": "multiSelect", "options": [{"id": "a8xceonxiu4n3c43szhskqizicr", "color": "propColorBrown", "value": "Website"}, {"id": "a3pdzi53kpbd4okzdkz6khi87zo", "color": "propColorGreen", "value": "Blog"}, {"id": "a3d9ux4fmi3anyd11kyipfbhwde", "color": "propColorOrange", "value": "Email"}, {"id": "a8cbbfdwocx73zn3787cx6gacsh", "color": "propColorRed", "value": "Podcast"}, {"id": "aigjtpcaxdp7d6kmctrwo1ztaia", "color": "propColorPink", "value": "Print"}, {"id": "af1wsn13muho59e7ghwaogxy5ey", "color": "propColorBlue", "value": "Facebook"}, {"id": "a47zajfxwhsg6q8m7ppbiqs7jge", "color": "propColorGray", "value": "LinkedIn"}, {"id": "az8o8pfe9hq6s7xaehoqyc3wpyc", "color": "propColorYellow", "value": "Twitter"}]}, {"id": "ao44fz8nf6z6tuj1x31t9yyehcc", "name": "Assignee", "type": "person", "options": []}, {"id": "a39x5cybshwrbjpc3juaakcyj6e", "name": "Due Date", "type": "date", "options": []}, {"id": "agqsoiipowmnu9rdwxm57zrehtr", "name": "Publication Date", "type": "date", "options": []}, {"id": "ap4e7kdg7eip7j3c3oyiz39eaoc", "name": "Link", "type": "url", "options": []}]	1675285314571	1675285314571	0	
bydniqgzqq3bwm8kw55a67d93oo	2023-02-01 21:01:54.819555+00	0		system	system	O	Team Retrospective	Use this template at the end of your project or sprint to identify what worked well and what can be improved for the future.	🧭	t	t	6	{"trackingTemplateId": "e4f03181c4ced8edd4d53d33d569a086"}	[{"id": "adjckpdotpgkz7c6wixzw9ipb1e", "name": "Category", "type": "select", "options": [{"id": "aok6pgecm85qe9k5kcphzoe63ma", "color": "propColorGray", "value": "To Discuss 📣"}, {"id": "aq1dwbf661yx337hjcd5q3sbxwa", "color": "propColorGreen", "value": "Went Well 👍"}, {"id": "ar87yh5xmsswqkxmjq1ipfftfpc", "color": "propColorRed", "value": "Didn't Go Well 🚫"}, {"id": "akj3fkmxq7idma55mdt8sqpumyw", "color": "propColorBlue", "value": "Action Items ✅"}]}, {"id": "aspaay76a5wrnuhtqgm97tt3rer", "name": "Details", "type": "text", "options": []}, {"id": "arzsm76s376y7suuhao3tu6efoc", "name": "Created By", "type": "createdBy", "options": []}, {"id": "a8anbe5fpa668sryatcdsuuyh8a", "name": "Created Time", "type": "createdTime", "options": []}]	1675285314822	1675285314822	0	
\.


--
-- Data for Name: focalboard_boards_history; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_boards_history (id, insert_at, team_id, channel_id, created_by, modified_by, type, title, description, icon, show_description, is_template, template_version, properties, card_properties, create_at, update_at, delete_at, minimum_role) FROM stdin;
b4cyhfatknfga9paqdgkoiatddo	2023-02-01 21:01:50.459085+00	0		system	system	O	Meeting Agenda 	Use this template for recurring meeting agendas, like team meetings and 1:1's. To use this board:\n* Participants queue new items to discuss under "To Discuss"\n* Go through items during the meeting\n* Move items to Done or Revisit Later as needed	🍩	t	t	6	{"trackingTemplateId": "54fcf9c610f0ac5e4c522c0657c90602"}	[{"id": "d777ba3b-8728-40d1-87a6-59406bbbbfb0", "name": "Status", "type": "select", "options": [{"id": "34eb9c25-d5bf-49d9-859e-f74f4e0030e7", "color": "propColorPink", "value": "To Discuss 💬"}, {"id": "d37a61f4-f332-4db9-8b2d-5e0a91aa20ed", "color": "propColorYellow", "value": "Revisit Later ⏳"}, {"id": "dabadd9b-adf1-4d9f-8702-805ac6cef602", "color": "propColorGreen", "value": "Done / Archived 📦"}]}, {"id": "4cf1568d-530f-4028-8ffd-bdc65249187e", "name": "Priority", "type": "select", "options": [{"id": "8b05c83e-a44a-4d04-831e-97f01d8e2003", "color": "propColorRed", "value": "1. High"}, {"id": "b1abafbf-a038-4a19-8b68-56e0fd2319f7", "color": "propColorYellow", "value": "2. Medium"}, {"id": "2491ffaa-eb55-417b-8aff-4bd7d4136613", "color": "propColorGray", "value": "3. Low"}]}, {"id": "aw4w63xhet79y9gueqzzeiifdoe", "name": "Created by", "type": "createdBy", "options": []}, {"id": "a6ux19353xcwfqg9k1inqg5sg4w", "name": "Created time", "type": "createdTime", "options": []}]	1675285310462	1675285310462	0	
bibxp8mmpkjdoijx58xnmcchgmr	2023-02-01 21:01:51.066397+00	0		system	system	O	Sales Pipeline CRM	Use this template to grow and keep track of your sales opportunities.	📈	t	t	6	{"trackingTemplateId": "ecc250bb7dff0fe02247f1110f097544"}	[{"id": "a5hwxjsmkn6bak6r7uea5bx1kwc", "name": "Status", "type": "select", "options": [{"id": "akj61wc9yxdwyw3t6m8igyf9d5o", "color": "propColorGray", "value": "Lead"}, {"id": "aic89a5xox4wbppi6mbyx6ujsda", "color": "propColorYellow", "value": "Qualified"}, {"id": "ah6ehh43rwj88jy4awensin8pcw", "color": "propColorBrown", "value": "Meeting"}, {"id": "aprhd96zwi34o9cs4xyr3o9sf3c", "color": "propColorPurple", "value": "Proposal"}, {"id": "axesd74yuxtbmw1sbk8ufax7z3a", "color": "propColorOrange", "value": "Negotiation"}, {"id": "a5txuiubumsmrs8gsd5jz5gc1oa", "color": "propColorRed", "value": "Lost"}, {"id": "acm9q494bcthyoqzmfogxxy5czy", "color": "propColorGreen", "value": "Closed 🏆"}]}, {"id": "aoheuj1f3mu6eehygr45fxa144y", "name": "Account Owner", "type": "multiPerson", "options": []}, {"id": "aro91wme9kfaie5ceu9qasmtcnw", "name": "Priority", "type": "select", "options": [{"id": "apjnaggwixchfxwiatfh7ey7uno", "color": "propColorRed", "value": "High 🔥"}, {"id": "apiswzj7uiwbh87z8dw8c6mturw", "color": "propColorYellow", "value": "Medium"}, {"id": "auu9bfzqeuruyjwzzqgz7q8apuw", "color": "propColorBrown", "value": "Low"}]}, {"id": "ainpw47babwkpyj77ic4b9zq9xr", "name": "Company", "type": "text", "options": []}, {"id": "ahf43e44h3y8ftanqgzno9z7q7w", "name": "Estimated Value", "type": "number", "options": []}, {"id": "amahgyn9n4twaapg3jyxb6y4jic", "name": "Territory", "type": "select", "options": [{"id": "ar6t1ttcumgfuqugg5o4g4mzrza", "color": "propColorBrown", "value": "Western US"}, {"id": "asbwojkm7zb4ohrtij97jkdfgwe", "color": "propColorGreen", "value": "Mountain West / Central US"}, {"id": "aw8ppwtcrm8iwopdadje3ni196w", "color": "propColorGray", "value": "Mid-Atlantic / Southeast"}, {"id": "aafwyza5iwdcwcyfyj6bp7emufw", "color": "propColorBlue", "value": "Northeast US / Canada"}, {"id": "agw8rcb9uxyt3c7g6tq3r65fgqe", "color": "propColorPink", "value": "Eastern Europe"}, {"id": "as5bk6afoaaa7caewe1zc391sce", "color": "propColorPurple", "value": "Central Europe / Africa"}, {"id": "a8fj94bka8z9t6p95qd3hn6t5re", "color": "propColorYellow", "value": "Middle East"}, {"id": "arpxa3faaou9trt4zx5sh435gne", "color": "propColorOrange", "value": "UK"}, {"id": "azdidd5wze4kcxf8neefj3ctkyr", "color": "propColorRed", "value": "Asia"}, {"id": "a4jn5mhqs3thknqf5opykntgsnc", "color": "propColorGray", "value": "Australia"}, {"id": "afjbgrecb7hp5owj7xh8u4w33tr", "color": "propColorBrown", "value": "Latin America"}]}, {"id": "abru6tz8uebdxy4skheqidh7zxy", "name": "Email", "type": "email", "options": []}, {"id": "a1438fbbhjeffkexmcfhnx99o1h", "name": "Phone", "type": "phone", "options": []}, {"id": "auhf91pm85f73swwidi4wid8jqe", "name": "Last Contact Date", "type": "date", "options": []}, {"id": "adtf1151chornmihz4xbgbk9exa", "name": "Expected Close", "type": "date", "options": []}, {"id": "aejo5tcmq54bauuueem9wc4fw4y", "name": "Close Probability", "type": "text", "options": []}, {"id": "amba7ot98fh7hwsx8jdcfst5g7h", "name": "Created Date", "type": "createdTime", "options": []}]	1675285311072	1675285311072	0	
b6hhefpcchbyy9f1pc15a15wobr	2023-02-01 21:01:52.182013+00	0		system	system	O	Personal Tasks 	Use this template to organize your life and track your personal tasks.	✔️	t	t	6	{"trackingTemplateId": "dfb70c146a4584b8a21837477c7b5431"}	[{"id": "a9zf59u8x1rf4ywctpcqama7tio", "name": "Occurrence", "type": "select", "options": [{"id": "an51dnkenmoog9cetapbc4uyt3y", "color": "propColorBlue", "value": "Daily"}, {"id": "afpy8s7i45frggprmfsqngsocqh", "color": "propColorOrange", "value": "Weekly"}, {"id": "aj4jyekqqssatjcq7r7chmy19ey", "color": "propColorPurple", "value": "Monthly"}]}, {"id": "abthng7baedhhtrwsdodeuincqy", "name": "Completed", "type": "checkbox", "options": []}]	1675285312186	1675285312186	0	
b7q1dux1e8f8gmmg5zhexdr5gwy	2023-02-01 21:01:52.583303+00	0		system	system	O	Project Tasks 	Use this template to stay on top of your project tasks and progress.	🎯	t	t	6	{"trackingTemplateId": "a4ec399ab4f2088b1051c3cdf1dde4c3"}	[{"id": "a972dc7a-5f4c-45d2-8044-8c28c69717f1", "name": "Status", "type": "select", "options": [{"id": "ayz81h9f3dwp7rzzbdebesc7ute", "color": "propColorBlue", "value": "Not Started"}, {"id": "ar6b8m3jxr3asyxhr8iucdbo6yc", "color": "propColorYellow", "value": "In Progress"}, {"id": "afi4o5nhnqc3smtzs1hs3ij34dh", "color": "propColorRed", "value": "Blocked"}, {"id": "adeo5xuwne3qjue83fcozekz8ko", "color": "propColorGreen", "value": "Completed 🙌"}, {"id": "ahpyxfnnrzynsw3im1psxpkgtpe", "color": "propColorBrown", "value": "Archived"}]}, {"id": "d3d682bf-e074-49d9-8df5-7320921c2d23", "name": "Priority", "type": "select", "options": [{"id": "d3bfb50f-f569-4bad-8a3a-dd15c3f60101", "color": "propColorRed", "value": "1. High 🔥"}, {"id": "87f59784-b859-4c24-8ebe-17c766e081dd", "color": "propColorYellow", "value": "2. Medium"}, {"id": "98a57627-0f76-471d-850d-91f3ed9fd213", "color": "propColorGray", "value": "3. Low"}]}, {"id": "axkhqa4jxr3jcqe4k87g8bhmary", "name": "Assignee", "type": "person", "options": []}, {"id": "a8daz81s4xjgke1ww6cwik5w7ye", "name": "Estimated Hours", "type": "number", "options": []}, {"id": "a3zsw7xs8sxy7atj8b6totp3mby", "name": "Due Date", "type": "date", "options": []}, {"id": "a7gdnz8ff8iyuqmzddjgmgo9ery", "name": "Created By", "type": "createdBy", "options": []}, {"id": "2a5da320-735c-4093-8787-f56e15cdfeed", "name": "Date Created", "type": "createdTime", "options": []}]	1675285312586	1675285312586	0	
bm9cpg1atuf8n3m9rd3mbf5d7yc	2023-02-01 21:01:53.231087+00	0		system	system	O	Company Goals & OKRs	Use this template to plan your company goals and OKRs more efficiently.	⛳	t	t	6	{"trackingTemplateId": "7ba22ccfdfac391d63dea5c4b8cde0de"}	[{"id": "a6amddgmrzakw66cidqzgk6p4ge", "name": "Objective", "type": "select", "options": [{"id": "auw3afh3kfhrfgmjr8muiz137jy", "color": "propColorGreen", "value": "Grow Revenue"}, {"id": "apqfjst8massbjjhpcsjs3y1yqa", "color": "propColorOrange", "value": "Delight Customers"}, {"id": "ao9b5pxyt7tkgdohzh9oaustdhr", "color": "propColorPurple", "value": "Drive Product Adoption"}]}, {"id": "a17ryhi1jfsboxkwkztwawhmsxe", "name": "Status", "type": "select", "options": [{"id": "a6robxx81diugpjq5jkezz3j1fo", "color": "propColorGray", "value": "Not Started"}, {"id": "a8nukezwwmknqwjsygg7eaxs9te", "color": "propColorBlue", "value": "In Progress"}, {"id": "apnt1f7na9rzgk1rt49keg7xbiy", "color": "propColorYellow", "value": "At Risk"}, {"id": "axbz3m1amss335wzwf9s7pqjzxr", "color": "propColorRed", "value": "Missed"}, {"id": "abzfwnn6rmtfzyq5hg8uqmpsncy", "color": "propColorGreen", "value": "Complete 🙌"}]}, {"id": "azzbawji5bksj69sekcs4srm1ky", "name": "Department", "type": "select", "options": [{"id": "aw5i7hmpadn6mbwbz955ubarhme", "color": "propColorBrown", "value": "Engineering"}, {"id": "afkxpcjqjypu7hhar7banxau91h", "color": "propColorBlue", "value": "Product"}, {"id": "aehoa17cz18rqnrf75g7dwhphpr", "color": "propColorOrange", "value": "Marketing"}, {"id": "agrfeaoj7d8p5ianw5iaf3191ae", "color": "propColorGreen", "value": "Sales"}, {"id": "agm9p6gcq15ueuzqq3wd4be39wy", "color": "propColorYellow", "value": "Support"}, {"id": "aucop7kw6xwodcix6zzojhxih6r", "color": "propColorPink", "value": "Design"}, {"id": "afust91f3g8ht368mkn5x9tgf1o", "color": "propColorPurple", "value": "Finance"}, {"id": "acocxxwjurud1jixhp7nowdig7y", "color": "propColorGray", "value": "Human Resources"}]}, {"id": "adp5ft3kgz7r5iqq3tnwg551der", "name": "Priority", "type": "select", "options": [{"id": "a8zg3rjtf4swh7smsjxpsn743rh", "color": "propColorRed", "value": "P1 🔥"}, {"id": "as555ipyzopjjpfb5rjtssecw5e", "color": "propColorYellow", "value": "P2"}, {"id": "a1ts3ftyr8nocsicui98c89uxjy", "color": "propColorGray", "value": "P3"}]}, {"id": "aqxyzkdrs4egqf7yk866ixkaojc", "name": "Quarter", "type": "select", "options": [{"id": "ahfbn1jsmhydym33ygxwg5jt3kh", "color": "propColorBlue", "value": "Q1"}, {"id": "awfu37js3fomfkkczm1zppac57a", "color": "propColorBrown", "value": "Q2"}, {"id": "anruuoyez51r3yjxuoc8zoqnwaw", "color": "propColorGreen", "value": "Q3"}, {"id": "acb6dqqs6yson7bbzx6jk9bghjh", "color": "propColorPurple", "value": "Q4"}]}, {"id": "adu6mebzpibq6mgcswk69xxmnqe", "name": "Due Date", "type": "date", "options": []}, {"id": "asope3bddhm4gpsng5cfu4hf6rh", "name": "Assignee", "type": "multiPerson", "options": []}, {"id": "ajwxp866f9obs1kutfwaa5ru7fe", "name": "Target", "type": "number", "options": []}, {"id": "azqnyswk6s1boiwuthscm78qwuo", "name": "Actual", "type": "number", "options": []}, {"id": "ahz3fmjnaguec8hce7xq3h5cjdr", "name": "Completion (%)", "type": "text", "options": []}, {"id": "a17bfcgnzmkwhziwa4tr38kiw5r", "name": "Note", "type": "text", "options": []}]	1675285313235	1675285313235	0	
b9wgudz1ippgf7map6ygr7tydza	2023-02-01 21:01:53.538374+00	0		system	system	O	Personal Goals 	Use this template to set and accomplish new personal goals.	⛰️	t	t	6	{"trackingTemplateId": "7f32dc8d2ae008cfe56554e9363505cc"}	[{"id": "af6fcbb8-ca56-4b73-83eb-37437b9a667d", "name": "Status", "type": "select", "options": [{"id": "bf52bfe6-ac4c-4948-821f-83eaa1c7b04a", "color": "propColorRed", "value": "To Do"}, {"id": "77c539af-309c-4db1-8329-d20ef7e9eacd", "color": "propColorYellow", "value": "Doing"}, {"id": "98bdea27-0cce-4cde-8dc6-212add36e63a", "color": "propColorGreen", "value": "Done 🙌"}]}, {"id": "d9725d14-d5a8-48e5-8de1-6f8c004a9680", "name": "Category", "type": "select", "options": [{"id": "3245a32d-f688-463b-87f4-8e7142c1b397", "color": "propColorPurple", "value": "Life Skills"}, {"id": "80be816c-fc7a-4928-8489-8b02180f4954", "color": "propColorGreen", "value": "Finance"}, {"id": "ffb3f951-b47f-413b-8f1d-238666728008", "color": "propColorOrange", "value": "Health"}]}, {"id": "d6b1249b-bc18-45fc-889e-bec48fce80ef", "name": "Target", "type": "select", "options": [{"id": "9a090e33-b110-4268-8909-132c5002c90e", "color": "propColorBlue", "value": "Q1"}, {"id": "0a82977f-52bf-457b-841b-e2b7f76fb525", "color": "propColorBrown", "value": "Q2"}, {"id": "6e7139e4-5358-46bb-8c01-7b029a57b80a", "color": "propColorGreen", "value": "Q3"}, {"id": "d5371c63-66bf-4468-8738-c4dc4bea4843", "color": "propColorPurple", "value": "Q4"}]}, {"id": "ajy6xbebzopojaenbnmfpgtdwso", "name": "Due Date", "type": "date", "options": []}]	1675285313547	1675285313547	0	
bp9zz8foamiyadchistmtnj7bro	2023-02-01 21:01:53.698735+00	0		system	system	O	Sprint Planner 	Use this template to plan your sprints and manage your releases more efficiently.	🗓️	t	t	6	{"trackingTemplateId": "99b74e26d2f5d0a9b346d43c0a7bfb09"}	[{"id": "50117d52-bcc7-4750-82aa-831a351c44a0", "name": "Status", "type": "select", "options": [{"id": "aft5bzo7h9aspqgrx3jpy5tzrer", "color": "propColorGray", "value": "Not Started"}, {"id": "abrfos7e7eczk9rqw6y5abadm1y", "color": "propColorOrange", "value": "Next Up"}, {"id": "ax8wzbka5ahs3zziji3pp4qp9mc", "color": "propColorBlue", "value": "In Progress"}, {"id": "atabdfbdmjh83136d5e5oysxybw", "color": "propColorYellow", "value": "In Review"}, {"id": "ace1bzypd586kkyhcht5qqd9eca", "color": "propColorPink", "value": "Approved"}, {"id": "aay656c9m1hzwxc9ch5ftymh3nw", "color": "propColorRed", "value": "Blocked"}, {"id": "a6ghze4iy441qhsh3eijnc8hwze", "color": "propColorGreen", "value": "Complete 🙌"}]}, {"id": "20717ad3-5741-4416-83f1-6f133fff3d11", "name": "Type", "type": "select", "options": [{"id": "424ea5e3-9aa1-4075-8c5c-01b44b66e634", "color": "propColorYellow", "value": "Epic ⛰"}, {"id": "a5yxq8rbubrpnoommfwqmty138h", "color": "propColorGray", "value": "Feature 🏗"}, {"id": "apht1nt5ryukdmxkh6fkfn6rgoy", "color": "propColorOrange", "value": "User Story 📖"}, {"id": "aiycbuo3dr5k4xxbfr7coem8ono", "color": "propColorGreen", "value": "Task ⛏"}, {"id": "aomnawq4551cbbzha9gxnmb3z5w", "color": "propColorRed", "value": "Bug 🐞"}]}, {"id": "60985f46-3e41-486e-8213-2b987440ea1c", "name": "Sprint", "type": "select", "options": [{"id": "c01676ca-babf-4534-8be5-cce2287daa6c", "color": "propColorBrown", "value": "Sprint 1"}, {"id": "ed4a5340-460d-461b-8838-2c56e8ee59fe", "color": "propColorPurple", "value": "Sprint 2"}, {"id": "14892380-1a32-42dd-8034-a0cea32bc7e6", "color": "propColorBlue", "value": "Sprint 3"}]}, {"id": "f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e", "name": "Priority", "type": "select", "options": [{"id": "cb8ecdac-38be-4d36-8712-c4d58cc8a8e9", "color": "propColorRed", "value": "P1 🔥"}, {"id": "e6a7f297-4440-4783-8ab3-3af5ba62ca11", "color": "propColorYellow", "value": "P2"}, {"id": "c62172ea-5da7-4dec-8186-37267d8ee9a7", "color": "propColorGray", "value": "P3"}]}, {"id": "aphg37f7zbpuc3bhwhp19s1ribh", "name": "Assignee", "type": "multiPerson", "options": []}, {"id": "a4378omyhmgj3bex13sj4wbpfiy", "name": "Due Date", "type": "date", "options": []}, {"id": "ai7ajsdk14w7x5s8up3dwir77te", "name": "Story Points", "type": "number", "options": []}, {"id": "a1g6i613dpe9oryeo71ex3c86hy", "name": "Design Link", "type": "url", "options": []}, {"id": "aeomttrbhhsi8bph31jn84sto6h", "name": "Created Time", "type": "createdTime", "options": []}, {"id": "ax9f8so418s6s65hi5ympd93i6a", "name": "Created By", "type": "createdBy", "options": []}]	1675285313706	1675285313706	0	
bjwjkmputh7dn8mequhmmfrhnba	2023-02-01 21:01:54.131682+00	0		system	system	O	User Research Sessions	Use this template to manage and keep track of all your user research sessions.	🔬	t	t	6	{"trackingTemplateId": "6c345c7f50f6833f78b7d0f08ce450a3"}	[{"id": "aaebj5fyx493eezx6ukxiwydgty", "name": "Status", "type": "select", "options": [{"id": "af6hjb3ysuaxbwnfqpby4wwnkdr", "color": "propColorGray", "value": "Backlog 📒"}, {"id": "aotxum1p5bw3xuzqz3ctjw66yww", "color": "propColorYellow", "value": "Contacted 📞"}, {"id": "a7yq89whddzob1futao4rxk3yzc", "color": "propColorBlue", "value": "Scheduled 📅"}, {"id": "aseqq9hrsua56r3s6nbuirj9eec", "color": "propColorRed", "value": "Cancelled 🚫"}, {"id": "ap93ysuzy1xa7z818r6myrn4h4y", "color": "propColorGreen", "value": "Completed ✔️"}]}, {"id": "akrxgi7p7w14fym3gbynb98t9fh", "name": "Interview Date", "type": "date", "options": []}, {"id": "atg9qu6oe4bjm8jczzsn71ff5me", "name": "Product Area", "type": "select", "options": [{"id": "ahn89mqg9u4igk6pdm7333t8i5h", "color": "propColorGreen", "value": "Desktop App"}, {"id": "aehc83ffays3gh8myz16a8j7k4e", "color": "propColorPurple", "value": "Web App"}, {"id": "a1sxagjgaadym5yrjak6tcup1oa", "color": "propColorBlue", "value": "Mobile App"}]}, {"id": "acjq4t5ymytu8x1f68wkggm7ypc", "name": "Email", "type": "email", "options": []}, {"id": "aphio1s5gkmpdbwoxynim7acw3e", "name": "Interviewer", "type": "multiPerson", "options": []}, {"id": "aqafzdeekpyncwz7m7i54q3iqqy", "name": "Recording URL", "type": "url", "options": []}, {"id": "aify3r761b9w43bqjtskrzi68tr", "name": "Passcode", "type": "text", "options": []}]	1675285314135	1675285314135	0	
b94e89e4eyib89q8aayocgudx7a	2023-02-01 21:01:54.299613+00	0		system	system	O	Competitive Analysis	Use this template to track and stay ahead of the competition.	🗂️	t	t	6	{"trackingTemplateId": "06f4bff367a7c2126fab2380c9dec23c"}	[{"id": "ahzspe59iux8wigra8bg6cg18nc", "name": "Website", "type": "url", "options": []}, {"id": "aozntq4go4nkab688j1s7stqtfc", "name": "Location", "type": "text", "options": []}, {"id": "aiefo7nh9jwisn8b4cgakowithy", "name": "Revenue", "type": "text", "options": []}, {"id": "a6cwaq79b1pdpb97wkanmeyy4er", "name": "Employees", "type": "number", "options": []}, {"id": "an1eerzscfxn6awdfajbg41uz3h", "name": "Founded", "type": "text", "options": []}, {"id": "a1semdhszu1rq17d7et5ydrqqio", "name": "Market Position", "type": "select", "options": [{"id": "arfjpz9by5car71tz3behba8yih", "color": "propColorYellow", "value": "Leader"}, {"id": "abajmr34b8g1916w495xjb35iko", "color": "propColorRed", "value": "Challenger"}, {"id": "abt79uxg5edqojsrrefcnr4eruo", "color": "propColorBlue", "value": "Follower"}, {"id": "aipf3qfgjtkheiayjuxrxbpk9wa", "color": "propColorBrown", "value": "Nicher"}]}, {"id": "aapogff3xoa8ym7xf56s87kysda", "name": "Last updated time", "type": "updatedTime", "options": []}, {"id": "az3jkw3ynd3mqmart7edypey15e", "name": "Last updated by", "type": "updatedBy", "options": []}]	1675285314303	1675285314303	0	
btqbtub75ybyitqe86bjikuxwmr	2023-02-01 21:01:54.916038+00	0		system	system	O	Roadmap 	Use this template to plan your roadmap and manage your releases more efficiently.	🗺️	t	t	6	{"trackingTemplateId": "b728c6ca730e2cfc229741c5a4712b65"}	[{"id": "50117d52-bcc7-4750-82aa-831a351c44a0", "name": "Status", "type": "select", "options": [{"id": "8c557f69-b0ed-46ec-83a3-8efab9d47ef5", "color": "propColorGray", "value": "Not Started"}, {"id": "ec6d2bc5-df2b-4f77-8479-e59ceb039946", "color": "propColorYellow", "value": "In Progress"}, {"id": "849766ba-56a5-48d1-886f-21672f415395", "color": "propColorGreen", "value": "Complete 🙌"}]}, {"id": "20717ad3-5741-4416-83f1-6f133fff3d11", "name": "Type", "type": "select", "options": [{"id": "424ea5e3-9aa1-4075-8c5c-01b44b66e634", "color": "propColorYellow", "value": "Epic ⛰"}, {"id": "6eea96c9-4c61-4968-8554-4b7537e8f748", "color": "propColorGreen", "value": "Task 🔨"}, {"id": "1fdbb515-edd2-4af5-80fc-437ed2211a49", "color": "propColorRed", "value": "Bug 🐞"}]}, {"id": "60985f46-3e41-486e-8213-2b987440ea1c", "name": "Sprint", "type": "select", "options": [{"id": "c01676ca-babf-4534-8be5-cce2287daa6c", "color": "propColorBrown", "value": "Sprint 1"}, {"id": "ed4a5340-460d-461b-8838-2c56e8ee59fe", "color": "propColorPurple", "value": "Sprint 2"}, {"id": "14892380-1a32-42dd-8034-a0cea32bc7e6", "color": "propColorBlue", "value": "Sprint 3"}]}, {"id": "f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e", "name": "Priority", "type": "select", "options": [{"id": "cb8ecdac-38be-4d36-8712-c4d58cc8a8e9", "color": "propColorRed", "value": "P1 🔥"}, {"id": "e6a7f297-4440-4783-8ab3-3af5ba62ca11", "color": "propColorYellow", "value": "P2"}, {"id": "c62172ea-5da7-4dec-8186-37267d8ee9a7", "color": "propColorGray", "value": "P3"}]}, {"id": "aphg37f7zbpuc3bhwhp19s1ribh", "name": "Assignee", "type": "person", "options": []}, {"id": "a4378omyhmgj3bex13sj4wbpfiy", "name": "Due Date", "type": "date", "options": []}, {"id": "a36o9q1yik6nmar6ri4q4uca7ey", "name": "Created Date", "type": "createdTime", "options": []}, {"id": "ai7ajsdk14w7x5s8up3dwir77te", "name": "Design Link", "type": "url", "options": []}]	1675285314921	1675285314921	0	
b55a5epzey7dqik9yr96gjtppmr	2023-02-01 21:01:55.312436+00	0		system	system	O	Welcome to Boards!	Mattermost Boards is an open source project management tool that helps you organize, track, and manage work across teams. Select a card to learn more.	👋	t	t	6	{"trackingTemplateId": "65aba997282f3ac457cd66736fb86915"}	[{"id": "a972dc7a-5f4c-45d2-8044-8c28c69717f1", "name": "Status", "type": "select", "options": [{"id": "amm6wfhnbuxojwssyftgs9dipqe", "color": "propColorRed", "value": "To do 🔥"}, {"id": "af3p8ztcyxgn8wd9z4az7o9tjeh", "color": "propColorYellow", "value": "Next up"}, {"id": "ajurey3xkocs1nwx8di5zx6oe7o", "color": "propColorPurple", "value": "Later"}, {"id": "agkinkjy5983wsk6kppsujajxqw", "color": "propColorGreen", "value": "Completed 🙌"}]}, {"id": "acypkejeb5yfujhj9te57p9kaxw", "name": "Priority", "type": "select", "options": [{"id": "aanaehcw3m13jytujsjk5hpf6ry", "color": "propColorOrange", "value": "1. High"}, {"id": "ascd7nm9r491ayot8i86g1gmgqw", "color": "propColorBrown", "value": "2. Medium"}, {"id": "aq6ukoiciyfctgwyhwzpfss8ghe", "color": "propColorGray", "value": "3. Low"}]}, {"id": "aqh13jabwexjkzr3jqsz1i1syew", "name": "Assignee", "type": "person", "options": []}, {"id": "acmg7mz1rr1eykfug4hcdpb1y1o", "name": "Due Date", "type": "date", "options": []}, {"id": "amewjwfjrtpu8ha73xsrdmxazxr", "name": "Reviewed", "type": "checkbox", "options": []}, {"id": "attzzboqaz6m1sdti5xa7gjnk1e", "name": "Last updated time", "type": "updatedTime", "options": []}, {"id": "a4nfnb5xr3txr5xq7y9ho7kyz6c", "name": "Reference", "type": "url", "options": []}, {"id": "a9gzwi3dt5n55nddej6zcbhxaeh", "name": "Created by", "type": "createdBy", "options": []}]	1675285315314	1675285315314	0	
br7ayzinnkfryudqw8jpuqpwniw	2023-02-01 21:01:54.567052+00	0		system	system	O	Content Calendar 	Use this template to plan and organize your editorial content.	📅	t	t	6	{"trackingTemplateId": "c75fbd659d2258b5183af2236d176ab4"}	[{"id": "ae9ar615xoknd8hw8py7mbyr7zo", "name": "Status", "type": "select", "options": [{"id": "awna1nuarjca99m9s4uiy9kwj5h", "color": "propColorGray", "value": "Idea 💡"}, {"id": "a9ana1e9w673o5cp8md4xjjwfto", "color": "propColorOrange", "value": "Draft"}, {"id": "apy9dcd7zmand615p3h53zjqxjh", "color": "propColorPurple", "value": "In Review"}, {"id": "acri4cm3bmay55f7ksztphmtnga", "color": "propColorBlue", "value": "Ready to Publish"}, {"id": "amsowcd9a8e1kid317r7ttw6uzh", "color": "propColorGreen", "value": "Published 🎉"}]}, {"id": "aysx3atqexotgwp5kx6h5i5ancw", "name": "Type", "type": "select", "options": [{"id": "aywiofmmtd3ofgzj95ysky4pjga", "color": "propColorOrange", "value": "Press Release"}, {"id": "apqdgjrmsmx8ngmp7zst51647de", "color": "propColorGreen", "value": "Sponsored Post"}, {"id": "a3woynbjnb7j16e74uw3pubrytw", "color": "propColorPurple", "value": "Customer Story"}, {"id": "aq36k5pkpfcypqb3idw36xdi1fh", "color": "propColorRed", "value": "Product Release"}, {"id": "azn66pmk34adygnizjqhgiac4ia", "color": "propColorGray", "value": "Partnership"}, {"id": "aj8y675weso8kpb6eceqbpj4ruw", "color": "propColorBlue", "value": "Feature Announcement"}, {"id": "a3xky7ygn14osr1mokerbfah5cy", "color": "propColorYellow", "value": "Article"}]}, {"id": "ab6mbock6styfe6htf815ph1mhw", "name": "Channel", "type": "multiSelect", "options": [{"id": "a8xceonxiu4n3c43szhskqizicr", "color": "propColorBrown", "value": "Website"}, {"id": "a3pdzi53kpbd4okzdkz6khi87zo", "color": "propColorGreen", "value": "Blog"}, {"id": "a3d9ux4fmi3anyd11kyipfbhwde", "color": "propColorOrange", "value": "Email"}, {"id": "a8cbbfdwocx73zn3787cx6gacsh", "color": "propColorRed", "value": "Podcast"}, {"id": "aigjtpcaxdp7d6kmctrwo1ztaia", "color": "propColorPink", "value": "Print"}, {"id": "af1wsn13muho59e7ghwaogxy5ey", "color": "propColorBlue", "value": "Facebook"}, {"id": "a47zajfxwhsg6q8m7ppbiqs7jge", "color": "propColorGray", "value": "LinkedIn"}, {"id": "az8o8pfe9hq6s7xaehoqyc3wpyc", "color": "propColorYellow", "value": "Twitter"}]}, {"id": "ao44fz8nf6z6tuj1x31t9yyehcc", "name": "Assignee", "type": "person", "options": []}, {"id": "a39x5cybshwrbjpc3juaakcyj6e", "name": "Due Date", "type": "date", "options": []}, {"id": "agqsoiipowmnu9rdwxm57zrehtr", "name": "Publication Date", "type": "date", "options": []}, {"id": "ap4e7kdg7eip7j3c3oyiz39eaoc", "name": "Link", "type": "url", "options": []}]	1675285314571	1675285314571	0	
bydniqgzqq3bwm8kw55a67d93oo	2023-02-01 21:01:54.819555+00	0		system	system	O	Team Retrospective	Use this template at the end of your project or sprint to identify what worked well and what can be improved for the future.	🧭	t	t	6	{"trackingTemplateId": "e4f03181c4ced8edd4d53d33d569a086"}	[{"id": "adjckpdotpgkz7c6wixzw9ipb1e", "name": "Category", "type": "select", "options": [{"id": "aok6pgecm85qe9k5kcphzoe63ma", "color": "propColorGray", "value": "To Discuss 📣"}, {"id": "aq1dwbf661yx337hjcd5q3sbxwa", "color": "propColorGreen", "value": "Went Well 👍"}, {"id": "ar87yh5xmsswqkxmjq1ipfftfpc", "color": "propColorRed", "value": "Didn't Go Well 🚫"}, {"id": "akj3fkmxq7idma55mdt8sqpumyw", "color": "propColorBlue", "value": "Action Items ✅"}]}, {"id": "aspaay76a5wrnuhtqgm97tt3rer", "name": "Details", "type": "text", "options": []}, {"id": "arzsm76s376y7suuhao3tu6efoc", "name": "Created By", "type": "createdBy", "options": []}, {"id": "a8anbe5fpa668sryatcdsuuyh8a", "name": "Created Time", "type": "createdTime", "options": []}]	1675285314822	1675285314822	0	
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
TelemetryID	7w7axokzkd3yktbmqfxgbj9ngga
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
cjsqd673nbgzzybrrkmzxou34y	1675877274162	{"disable_daily_digest":false}
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
cn5q678pgt8czp79k5b8tibgsw	migrations	0	1675285368659	1675285373797	1675285374044	success	0	{"last_done": "{\\"current_table\\":\\"ChannelMembers\\",\\"last_team_id\\":\\"00000000000000000000000000\\",\\"last_channel_id\\":\\"00000000000000000000000000\\",\\"last_user\\":\\"00000000000000000000000000\\"}", "migration_key": "migration_advanced_permissions_phase_2"}
h9zy36cczjd1dy56mao8sxno3r	expiry_notify	0	1675285908342	1675285913614	1675285913629	success	0	null
gqm47wu15idozf4gn1o1grc7er	expiry_notify	0	1675286507952	1675286513426	1675286513445	success	0	null
hoomw98mipyydd7j7xybkp4joh	expiry_notify	0	1675287107530	1675287113186	1675287113192	success	0	null
sgcy4zretir9xxschu8grwu6ky	expiry_notify	0	1675287707130	1675287713020	1675287713024	success	0	null
qxcfsroxnifdxk7a388zys7b9o	expiry_notify	0	1675288306769	1675288312788	1675288312792	success	0	null
4jwhgtk1bi8bbjaopfxr7kb75r	expiry_notify	0	1675288906379	1675288912516	1675288912527	success	0	null
8mnouiw86ifejbn4u6u5k8t5gh	product_notices	0	1675288906386	1675288912516	1675288912733	success	0	null
ynfkdedw4tgh5jhb3w5ti5eyna	expiry_notify	0	1675795070520	1675795080566	1675795080584	success	0	null
6y19pqzboibobphbc9furd7q1y	expiry_notify	0	1675795670163	1675795680372	1675795680383	success	0	null
ontex9httb8bzcibmspzwtz34c	expiry_notify	0	1675796269773	1675796280166	1675796280171	success	0	null
j3etz9hyn7yimb16e1u5of9q7r	expiry_notify	0	1675796869411	1675796879940	1675796879944	success	0	null
ea4mo4k6wfgzfk8w3a1ip8zgqw	expiry_notify	0	1675797468992	1675797479714	1675797479722	success	0	null
7yb3z8i6jbgnmp4bqizob47ouo	expiry_notify	0	1675814096034	1675814102273	1675814102293	success	0	null
43hm1tbruibnxe3ifusyhiap5o	expiry_notify	0	1675877769499	1675877775114	1675877775120	success	0	null
z4opq9riobfp9rdjkr7t9d9iuo	expiry_notify	0	1675879977146	1675879983442	1675879983452	success	0	null
4uh3eypjyinj5j6p8xtzfwqifc	expiry_notify	0	1675880576660	1675880583087	1675880583091	success	0	null
qfo5beh4sjbejdscoyyxcti63e	expiry_notify	0	1675881176244	1675881182834	1675881182839	success	0	null
sq35fa6j9pgktnigdbw959ruhy	expiry_notify	0	1675881775814	1675881782614	1675881782620	success	0	null
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

COPY public.oauthaccessdata (token, refreshtoken, redirecturi, clientid, userid, expiresat, scope) FROM stdin;
\.


--
-- Data for Name: oauthapps; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.oauthapps (id, creatorid, createat, updateat, clientsecret, name, description, callbackurls, homepage, istrusted, iconurl, mattermostappid) FROM stdin;
\.


--
-- Data for Name: oauthauthdata; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.oauthauthdata (clientid, userid, code, expiresin, createat, redirecturi, state, scope) FROM stdin;
\.


--
-- Data for Name: outgoingwebhooks; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.outgoingwebhooks (id, token, createat, updateat, deleteat, creatorid, channelid, teamid, triggerwords, callbackurls, displayname, contenttype, triggerwhen, username, iconurl, description) FROM stdin;
\.


--
-- Data for Name: pluginkeyvaluestore; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.pluginkeyvaluestore (pluginid, pkey, pvalue, expireat) FROM stdin;
com.mattermost.apps	mmi_botid	\\x746674617567736d6d7079677867696b337734386e7962666463	0
playbooks	mmi_botid	\\x737166316766706275376e6770677a626371743933703837726f	0
focalboard	mmi_botid	\\x783377627a376b776e696633746a373531736666717470757579	0
\.


--
-- Data for Name: postreminders; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.postreminders (postid, userid, targettime) FROM stdin;
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.posts (id, createat, updateat, deleteat, userid, channelid, rootid, originalid, message, type, props, hashtags, filenames, fileids, hasreactions, editat, ispinned, remoteid) FROM stdin;
gbnncrfewjfh8gw3pycghboawh	1675285819396	1675285819396	0	tkzqirh7h78opxqwk5a4bt3fkw	g593o5aooif69kt9xfdzsydu3y			admin joined the team.	system_join_team	{"username": "admin"}		[]	[]	f	0	f	\N
m3f46h8g4prc5r1fc96qkzjjaw	1675285819432	1675285819432	0	tkzqirh7h78opxqwk5a4bt3fkw	g593o5aooif69kt9xfdzsydu3y				system_welcome_post	{}		[]	[]	f	0	f	\N
11dz7148ijg9zp8ww1jaoppdze	1675285819504	1675285819504	0	tkzqirh7h78opxqwk5a4bt3fkw	6j47rggkup8xupunzj5dfxojih			admin joined the channel.	system_join_channel	{"username": "admin"}		[]	[]	f	0	f	\N
zx866w619tdk9r64mhxbisskoo	1675286415661	1675286415661	0	yp7iiitd1prkukea7ci1yeqo4h	g593o5aooif69kt9xfdzsydu3y			matrix.bridge joined the team.	system_join_team	{"username": "matrix.bridge"}		[]	[]	f	0	f	\N
dzay9fxfqffg7eaa4mp9gd5dzy	1675286415706	1675286415706	0	yp7iiitd1prkukea7ci1yeqo4h	6j47rggkup8xupunzj5dfxojih			matrix.bridge joined the channel.	system_join_channel	{"username": "matrix.bridge"}		[]	[]	f	0	f	\N
1wgto34wjtf6mjcqwnq9cwq1re	1675286786642	1675286786642	0	yp7iiitd1prkukea7ci1yeqo4h	g593o5aooif69kt9xfdzsydu3y			matrix.bridge left the team.	system_leave_team	{"username": "matrix.bridge"}		[]	[]	f	0	f	\N
zcd98zu5eiba5k7nxbqsfuk5oc	1675287027090	1675287027090	0	yp7iiitd1prkukea7ci1yeqo4h	g593o5aooif69kt9xfdzsydu3y			matrix.bridge joined the team.	system_join_team	{"username": "matrix.bridge"}		[]	[]	f	0	f	\N
tn37tdh75t8bzjssz9mzuhi95a	1675287027121	1675287027121	0	yp7iiitd1prkukea7ci1yeqo4h	6j47rggkup8xupunzj5dfxojih			matrix.bridge joined the channel.	system_join_channel	{"username": "matrix.bridge"}		[]	[]	f	0	f	\N
9731x6oeyinw9e7xraksb8ey9h	1675794260362	1675794260362	0	cjsqd673nbgzzybrrkmzxou34y	g593o5aooif69kt9xfdzsydu3y			user1.mm joined the team.	system_join_team	{"username": "user1.mm"}		[]	[]	f	0	f	\N
judnuuyer3brzejtgq8453tf5e	1675794260401	1675794260401	0	cjsqd673nbgzzybrrkmzxou34y	6j47rggkup8xupunzj5dfxojih			user1.mm joined the channel.	system_join_channel	{"username": "user1.mm"}		[]	[]	f	0	f	\N
gmysrgsoqf8g9ceq5ex1tffjae	1675814025467	1675814025467	0	yp7iiitd1prkukea7ci1yeqo4h	6j47rggkup8xupunzj5dfxojih			matrix_user1.matrix added to the channel by matrix.bridge.	system_add_to_channel	{"userId": "yp7iiitd1prkukea7ci1yeqo4h", "username": "matrix.bridge", "addedUserId": "pqzp7j96epnczy4icow41mnhpc", "addedUsername": "matrix_user1.matrix"}		[]	[]	f	0	f	\N
abap6ub8sid1znsnr9odftpe5c	1675814025536	1675814025536	0	pqzp7j96epnczy4icow41mnhpc	g593o5aooif69kt9xfdzsydu3y			matrix_user1.matrix joined the team.	system_join_team	{"username": "matrix_user1.matrix"}		[]	[]	f	0	f	\N
us7j6c5p37fxzektcwpd34wiyh	1675814025688	1675814025688	0	pqzp7j96epnczy4icow41mnhpc	6j47rggkup8xupunzj5dfxojih			matrix_user1.matrix joined the channel.	system_join_channel	{"username": "matrix_user1.matrix"}		[]	[]	f	0	f	\N
o86d1bhaxfg48kwzmx1ofz7gwr	1675814070936	1675814070936	0	pqzp7j96epnczy4icow41mnhpc	6j47rggkup8xupunzj5dfxojih			ok kl		{}		[]	[]	f	0	f	\N
gopprzcaf781uf3qhizmanp6ur	1675814080447	1675814080447	0	cjsqd673nbgzzybrrkmzxou34y	6j47rggkup8xupunzj5dfxojih			jkjk jkj		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
aog3bs786pdn8jc6g88wwmtbnw	1675877306811	1675877306811	0	cjsqd673nbgzzybrrkmzxou34y	6j47rggkup8xupunzj5dfxojih					{"disable_group_highlight": true}		[]	["qwapdibndiyjpbkcg16wopcria"]	f	0	f	\N
an9ehnxrqjfsxrowqse6n1y69w	1675877529990	1675877529990	0	cjsqd673nbgzzybrrkmzxou34y	6j47rggkup8xupunzj5dfxojih			klklklkl		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
59r6ochdeidi7fjhi3xftkuwfr	1675877574524	1675877574524	0	cjsqd673nbgzzybrrkmzxou34y	6j47rggkup8xupunzj5dfxojih			ok		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
7r6mp65ytffwuqfitkg6cnisky	1675877759400	1675877759400	0	cjsqd673nbgzzybrrkmzxou34y	6j47rggkup8xupunzj5dfxojih			ok		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
rbiq8w89g3yntbri9kfw9m5niy	1675877833275	1675877833275	0	cjsqd673nbgzzybrrkmzxou34y	6j47rggkup8xupunzj5dfxojih			[		{"disable_group_highlight": true}		[]	["ehkxaekorbrhdqwjex8q6t3dmr"]	f	0	f	\N
jytjwsdnztbpiy8ggfqdnnn3py	1675877966817	1675877966817	0	cjsqd673nbgzzybrrkmzxou34y	g593o5aooif69kt9xfdzsydu3y			klklkl		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
fxz1usgc37f3bp65rj6yh8affy	1675878048989	1675878048989	0	pqzp7j96epnczy4icow41mnhpc	6j47rggkup8xupunzj5dfxojih			klklklkl		{}		[]	[]	f	0	f	\N
8um5sctm67dzjxc1iw1wbyax8o	1675878385137	1675878385137	0	cjsqd673nbgzzybrrkmzxou34y	6j47rggkup8xupunzj5dfxojih			okoko		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
\.


--
-- Data for Name: preferences; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.preferences (userid, category, name, value) FROM stdin;
tkzqirh7h78opxqwk5a4bt3fkw	tutorial_step	tkzqirh7h78opxqwk5a4bt3fkw	0
tkzqirh7h78opxqwk5a4bt3fkw	insights	insights_tutorial_state	{"insights_modal_viewed":true}
tkzqirh7h78opxqwk5a4bt3fkw	recommended_next_steps	hide	true
tkzqirh7h78opxqwk5a4bt3fkw	onboarding_task_list	onboarding_task_list_show	false
tkzqirh7h78opxqwk5a4bt3fkw	onboarding_task_list	onboarding_task_list_open	false
yp7iiitd1prkukea7ci1yeqo4h	tutorial_step	yp7iiitd1prkukea7ci1yeqo4h	0
yp7iiitd1prkukea7ci1yeqo4h	insights	insights_tutorial_state	{"insights_modal_viewed":true}
yp7iiitd1prkukea7ci1yeqo4h	onboarding_task_list	onboarding_task_list_show	true
yp7iiitd1prkukea7ci1yeqo4h	recommended_next_steps	hide	true
yp7iiitd1prkukea7ci1yeqo4h	onboarding_task_list	onboarding_task_list_open	false
yp7iiitd1prkukea7ci1yeqo4h	channel_approximate_view_time		1675286489001
yp7iiitd1prkukea7ci1yeqo4h	direct_channel_show	yp7iiitd1prkukea7ci1yeqo4h	true
yp7iiitd1prkukea7ci1yeqo4h	channel_open_time	13kiq1kuy3du3nfdc4wpddte1h	1675288497409
cjsqd673nbgzzybrrkmzxou34y	tutorial_step	cjsqd673nbgzzybrrkmzxou34y	0
cjsqd673nbgzzybrrkmzxou34y	insights	insights_tutorial_state	{"insights_modal_viewed":true}
cjsqd673nbgzzybrrkmzxou34y	onboarding_task_list	onboarding_task_list_show	true
cjsqd673nbgzzybrrkmzxou34y	recommended_next_steps	hide	true
cjsqd673nbgzzybrrkmzxou34y	onboarding_task_list	onboarding_task_list_open	false
pqzp7j96epnczy4icow41mnhpc	recommended_next_steps	hide	false
pqzp7j96epnczy4icow41mnhpc	tutorial_step	pqzp7j96epnczy4icow41mnhpc	0
pqzp7j96epnczy4icow41mnhpc	insights	insights_tutorial_state	{"insights_modal_viewed":true}
cjsqd673nbgzzybrrkmzxou34y	channel_approximate_view_time		1675877297118
\.


--
-- Data for Name: productnoticeviewstate; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.productnoticeviewstate (userid, noticeid, viewed, "timestamp") FROM stdin;
tkzqirh7h78opxqwk5a4bt3fkw	use_case_survey	1	1675285775
tkzqirh7h78opxqwk5a4bt3fkw	june15-cloud-freemium	1	1675285775
tkzqirh7h78opxqwk5a4bt3fkw	desktop_upgrade_v5.2	1	1675285775
tkzqirh7h78opxqwk5a4bt3fkw	server_upgrade_v7.7	1	1675285775
tkzqirh7h78opxqwk5a4bt3fkw	crt-admin-disabled	1	1675285775
tkzqirh7h78opxqwk5a4bt3fkw	crt-admin-default_off	1	1675285775
tkzqirh7h78opxqwk5a4bt3fkw	crt-user-default-on	1	1675285775
tkzqirh7h78opxqwk5a4bt3fkw	crt-user-always-on	1	1675285775
tkzqirh7h78opxqwk5a4bt3fkw	v6.0_user_introduction	1	1675285775
tkzqirh7h78opxqwk5a4bt3fkw	v6.2_boards	1	1675285775
tkzqirh7h78opxqwk5a4bt3fkw	unsupported-server-v5.37	1	1675285775
yp7iiitd1prkukea7ci1yeqo4h	use_case_survey	1	1675286152
yp7iiitd1prkukea7ci1yeqo4h	june15-cloud-freemium	1	1675286152
yp7iiitd1prkukea7ci1yeqo4h	desktop_upgrade_v5.2	1	1675286152
yp7iiitd1prkukea7ci1yeqo4h	server_upgrade_v7.7	1	1675286152
yp7iiitd1prkukea7ci1yeqo4h	crt-admin-disabled	1	1675286152
yp7iiitd1prkukea7ci1yeqo4h	crt-admin-default_off	1	1675286152
yp7iiitd1prkukea7ci1yeqo4h	crt-user-default-on	1	1675286152
yp7iiitd1prkukea7ci1yeqo4h	crt-user-always-on	1	1675286152
yp7iiitd1prkukea7ci1yeqo4h	v6.0_user_introduction	1	1675286152
yp7iiitd1prkukea7ci1yeqo4h	v6.2_boards	1	1675286152
yp7iiitd1prkukea7ci1yeqo4h	unsupported-server-v5.37	1	1675286152
cjsqd673nbgzzybrrkmzxou34y	use_case_survey	1	1675794259
cjsqd673nbgzzybrrkmzxou34y	june15-cloud-freemium	1	1675794259
cjsqd673nbgzzybrrkmzxou34y	desktop_upgrade_v5.2	1	1675794259
cjsqd673nbgzzybrrkmzxou34y	server_upgrade_v7.7	1	1675794259
cjsqd673nbgzzybrrkmzxou34y	crt-admin-disabled	1	1675794259
cjsqd673nbgzzybrrkmzxou34y	crt-admin-default_off	1	1675794259
cjsqd673nbgzzybrrkmzxou34y	crt-user-default-on	1	1675794259
cjsqd673nbgzzybrrkmzxou34y	crt-user-always-on	1	1675794259
cjsqd673nbgzzybrrkmzxou34y	v6.0_user_introduction	1	1675794259
cjsqd673nbgzzybrrkmzxou34y	v6.2_boards	1	1675794259
cjsqd673nbgzzybrrkmzxou34y	unsupported-server-v5.37	1	1675794259
pqzp7j96epnczy4icow41mnhpc	use_case_survey	1	1675814025
pqzp7j96epnczy4icow41mnhpc	june15-cloud-freemium	1	1675814025
pqzp7j96epnczy4icow41mnhpc	desktop_upgrade_v5.2	1	1675814025
pqzp7j96epnczy4icow41mnhpc	server_upgrade_v7.7	1	1675814025
pqzp7j96epnczy4icow41mnhpc	crt-admin-disabled	1	1675814025
pqzp7j96epnczy4icow41mnhpc	crt-admin-default_off	1	1675814025
pqzp7j96epnczy4icow41mnhpc	crt-user-default-on	1	1675814025
pqzp7j96epnczy4icow41mnhpc	crt-user-always-on	1	1675814025
pqzp7j96epnczy4icow41mnhpc	v6.0_user_introduction	1	1675814025
pqzp7j96epnczy4icow41mnhpc	v6.2_boards	1	1675814025
pqzp7j96epnczy4icow41mnhpc	unsupported-server-v5.37	1	1675814025
\.


--
-- Data for Name: publicchannels; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.publicchannels (id, deleteat, teamid, displayname, name, header, purpose) FROM stdin;
g593o5aooif69kt9xfdzsydu3y	0	jubozzh9wi8g9j33syw1b4tefo	Town Square	town-square		
6j47rggkup8xupunzj5dfxojih	0	jubozzh9wi8g9j33syw1b4tefo	Off-Topic	off-topic		
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
93muwaic5fn39dfegc4ggkbd4w	system_user_access_token	authentication.roles.system_user_access_token.name	authentication.roles.system_user_access_token.description	1675285301672	1675285303750	0	 revoke_user_access_token create_user_access_token read_user_access_token	f	t
em7j8sbcxprnfpsdih8tdr4sjo	system_user_manager	authentication.roles.system_user_manager.name	authentication.roles.system_user_manager.description	1675285301674	1675285303776	0	 manage_public_channel_members sysconsole_write_user_management_channels sysconsole_read_authentication_ldap sysconsole_read_authentication_signup sysconsole_read_user_management_channels sysconsole_read_user_management_groups read_private_channel_groups sysconsole_read_authentication_guest_access list_public_teams read_channel manage_team_roles delete_public_channel read_public_channel_groups sysconsole_write_user_management_groups read_public_channel remove_user_from_team sysconsole_read_authentication_mfa list_private_teams manage_public_channel_properties convert_private_channel_to_public test_ldap convert_public_channel_to_private sysconsole_read_authentication_password view_team manage_channel_roles manage_private_channel_members sysconsole_read_user_management_teams sysconsole_read_authentication_openid sysconsole_write_user_management_teams read_ldap_sync_job sysconsole_read_user_management_permissions manage_private_channel_properties add_user_to_team join_private_teams manage_team sysconsole_read_authentication_saml sysconsole_read_authentication_email delete_private_channel join_public_teams	f	t
6ntohod5jjbnik8erwx9xu3z9r	channel_admin	authentication.roles.channel_admin.name	authentication.roles.channel_admin.description	1675285301625	1675285303726	0	 read_private_channel_groups remove_reaction read_public_channel_groups add_reaction use_channel_mentions manage_channel_roles create_post use_group_mentions manage_public_channel_members manage_private_channel_members	t	t
ypfn9etm9png3bw8jrpzpi483r	team_user	authentication.roles.team_user.name	authentication.roles.team_user.description	1675285301646	1675285303729	0	 playbook_public_create invite_user view_team list_team_channels read_public_channel playbook_private_create create_private_channel add_user_to_team create_public_channel join_public_channels	t	t
543znbrbbjgu8xto59rkhitidw	playbook_member	authentication.roles.playbook_member.name	authentication.roles.playbook_member.description	1675285301652	1675285303732	0	 playbook_private_manage_members playbook_private_manage_properties run_create playbook_public_view playbook_public_manage_members playbook_public_manage_properties playbook_private_view	t	t
uzt7cmaid7bypxwk74qnnhznnc	channel_user	authentication.roles.channel_user.name	authentication.roles.channel_user.description	1675285301655	1675285303734	0	 upload_file read_channel read_public_channel_groups use_channel_mentions edit_post delete_private_channel add_reaction create_post manage_private_channel_properties manage_private_channel_members delete_post delete_public_channel use_slash_commands read_private_channel_groups get_public_link manage_public_channel_properties use_group_mentions manage_public_channel_members remove_reaction	t	t
kpsajtxux7ffzjsic53zg7xg6y	playbook_admin	authentication.roles.playbook_admin.name	authentication.roles.playbook_admin.description	1675285301681	1675285303777	0	 playbook_public_make_private playbook_public_manage_members playbook_public_manage_roles playbook_public_manage_properties playbook_private_manage_members playbook_private_manage_roles playbook_private_manage_properties	t	t
k7ru8rbbm7885k1o33puxa6z7a	run_admin	authentication.roles.run_admin.name	authentication.roles.run_admin.description	1675285301685	1675285303778	0	 run_manage_properties run_manage_members	t	t
3d4f9ru7riyw7nnc478bp9rs9r	run_member	authentication.roles.run_member.name	authentication.roles.run_member.description	1675285301689	1675285303780	0	 run_view	t	t
zd1ypqyrdtrf9kwt8jnzysiu9o	team_post_all	authentication.roles.team_post_all.name	authentication.roles.team_post_all.description	1675285301694	1675285303783	0	 use_channel_mentions use_group_mentions create_post	f	t
9h8aywwzibgsbxru836g3d8wpo	team_post_all_public	authentication.roles.team_post_all_public.name	authentication.roles.team_post_all_public.description	1675285301698	1675285303785	0	 create_post_public use_group_mentions use_channel_mentions	f	t
otmz4zfnb3d5dpnw9i6fzbzxxa	system_post_all	authentication.roles.system_post_all.name	authentication.roles.system_post_all.description	1675285301703	1675285303786	0	 use_channel_mentions create_post use_group_mentions	f	t
dqgfyo3jepfmuqhkojori93pnw	system_post_all_public	authentication.roles.system_post_all_public.name	authentication.roles.system_post_all_public.description	1675285301707	1675285303789	0	 create_post_public use_channel_mentions use_group_mentions	f	t
q4qahwetn3di5kf8fixi76muqw	custom_group_user	authentication.roles.custom_group_user.name	authentication.roles.custom_group_user.description	1675285301713	1675285303794	0		f	f
szjguk11t78pdyohd1a78s34ta	channel_guest	authentication.roles.channel_guest.name	authentication.roles.channel_guest.description	1675285301724	1675285303796	0	 read_channel add_reaction remove_reaction upload_file edit_post create_post use_channel_mentions use_slash_commands	t	t
y779o4abnb8dfpfqs98j4misoc	team_guest	authentication.roles.team_guest.name	authentication.roles.team_guest.description	1675285301728	1675285303798	0	 view_team	t	t
f5ursigs8jgx8b7j1gm8y11hxr	system_custom_group_admin	authentication.roles.system_custom_group_admin.name	authentication.roles.system_custom_group_admin.description	1675285301734	1675285303804	0	 manage_custom_group_members create_custom_group edit_custom_group delete_custom_group	f	t
sdghznt3gjgkbfsnkuju6fhsza	system_user	authentication.roles.global_user.name	authentication.roles.global_user.description	1675285301661	1675285303809	0	 delete_emojis edit_custom_group manage_custom_group_members create_emojis create_team join_public_teams create_direct_channel view_members list_public_teams create_custom_group delete_custom_group create_group_channel	t	t
k46n3cf8ktd3pfxb8exhpm1ogo	system_admin	authentication.roles.global_admin.name	authentication.roles.global_admin.description	1675285301611	1675285303814	0	 sysconsole_write_site_public_links create_data_retention_job get_public_link edit_custom_group delete_public_channel remove_user_from_team sysconsole_read_authentication_signup manage_others_incoming_webhooks create_custom_group download_compliance_export_result create_post sysconsole_read_compliance_custom_terms_of_service sysconsole_read_authentication_ldap manage_channel_roles assign_bot test_ldap sysconsole_read_environment_web_server sysconsole_write_authentication_mfa sysconsole_write_site_notices sysconsole_read_compliance_data_retention_policy create_team reload_config remove_ldap_public_cert manage_outgoing_webhooks manage_system edit_post sysconsole_read_reporting_site_statistics sysconsole_read_environment_elasticsearch sysconsole_write_site_file_sharing_and_downloads sysconsole_write_environment_rate_limiting sysconsole_write_site_users_and_teams read_public_channel sysconsole_write_user_management_permissions sysconsole_write_authentication_signup sysconsole_read_environment_session_lengths sysconsole_write_environment_developer sysconsole_read_reporting_server_logs create_post_ephemeral manage_jobs sysconsole_read_plugins run_manage_members sysconsole_write_user_management_channels sysconsole_write_environment_session_lengths remove_saml_public_cert remove_reaction sysconsole_read_authentication_email sysconsole_read_authentication_password manage_oauth sysconsole_write_integrations_bot_accounts playbook_private_make_public run_view test_site_url manage_system_wide_oauth sysconsole_read_compliance_compliance_monitoring sysconsole_write_authentication_password join_private_teams use_group_mentions manage_license_information sysconsole_read_site_file_sharing_and_downloads create_direct_channel read_others_bots sysconsole_read_site_announcement_banner add_reaction read_other_users_teams create_elasticsearch_post_aggregation_job sysconsole_read_billing test_email invite_user create_ldap_sync_job sysconsole_write_compliance_data_retention_policy sysconsole_read_environment_smtp use_channel_mentions use_slash_commands import_team sysconsole_read_site_localization playbook_public_view sysconsole_write_reporting_server_logs test_elasticsearch delete_private_channel sysconsole_write_environment_smtp read_license_information assign_system_admin_role playbook_public_manage_properties manage_others_slash_commands create_user_access_token remove_saml_private_cert view_members sysconsole_read_environment_performance_monitoring sysconsole_read_site_public_links sysconsole_write_integrations_cors sysconsole_read_user_management_system_roles sysconsole_read_environment_database delete_emojis sysconsole_write_authentication_email playbook_public_make_private create_post_public sysconsole_write_integrations_integration_management manage_incoming_webhooks upload_file add_user_to_team sysconsole_read_environment_developer sysconsole_write_site_localization sysconsole_write_environment_image_proxy sysconsole_read_site_customization sysconsole_write_compliance_custom_terms_of_service manage_bots read_public_channel_groups sysconsole_read_compliance_compliance_export create_compliance_export_job sysconsole_read_user_management_groups get_logs remove_others_reactions sysconsole_write_experimental_feature_flags sysconsole_read_user_management_users sysconsole_write_reporting_site_statistics playbook_private_manage_members sysconsole_read_site_users_and_teams sysconsole_write_environment_push_notification_server manage_custom_group_members read_bots sysconsole_write_site_customization sysconsole_write_site_emoji manage_others_bots revoke_user_access_token join_public_channels sysconsole_read_user_management_permissions create_emojis promote_guest playbook_private_create read_ldap_sync_job sysconsole_read_site_notifications create_private_channel read_jobs playbook_public_create create_bot sysconsole_write_environment_elasticsearch sysconsole_write_authentication_guest_access sysconsole_write_environment_logging sysconsole_write_environment_file_storage playbook_public_manage_members delete_custom_group purge_elasticsearch_indexes playbook_private_manage_roles playbook_private_view read_private_channel_groups sysconsole_write_site_notifications convert_public_channel_to_private create_elasticsearch_post_indexing_job sysconsole_read_reporting_team_statistics sysconsole_write_compliance_compliance_monitoring sysconsole_write_compliance_compliance_export sysconsole_read_site_posts sysconsole_read_authentication_saml sysconsole_read_authentication_openid sysconsole_write_experimental_features sysconsole_write_environment_database invalidate_caches get_analytics sysconsole_read_experimental_feature_flags read_deleted_posts list_public_teams sysconsole_write_about_edition_and_license test_s3 sysconsole_write_authentication_openid sysconsole_write_environment_performance_monitoring delete_others_posts playbook_public_manage_roles sysconsole_read_site_notices list_users_without_team sysconsole_write_reporting_team_statistics manage_team_roles sysconsole_read_environment_high_availability edit_brand delete_post read_elasticsearch_post_indexing_job sysconsole_write_site_announcement_banner sysconsole_write_user_management_groups edit_other_users edit_others_posts sysconsole_write_authentication_saml sysconsole_read_about_edition_and_license add_ldap_private_cert demote_to_guest remove_saml_idp_cert create_group_channel sysconsole_read_authentication_mfa sysconsole_write_products_boards manage_public_channel_properties sysconsole_read_integrations_cors manage_secure_connections sysconsole_read_environment_push_notification_server sysconsole_write_environment_web_server join_public_teams run_manage_properties read_data_retention_job read_channel manage_slash_commands sysconsole_read_integrations_integration_management create_public_channel manage_roles add_saml_public_cert read_compliance_export_job sysconsole_read_products_boards sysconsole_read_site_emoji delete_others_emojis manage_public_channel_members read_audits sysconsole_write_user_management_system_roles get_saml_metadata_from_idp create_post_bleve_indexes_job add_ldap_public_cert sysconsole_read_integrations_bot_accounts view_team manage_private_channel_properties sysconsole_write_site_posts read_user_access_token sysconsole_write_billing sysconsole_read_experimental_features sysconsole_write_authentication_ldap sysconsole_read_experimental_bleve sysconsole_write_user_management_users playbook_private_manage_properties sysconsole_read_integrations_gif sysconsole_write_environment_high_availability sysconsole_write_integrations_gif recycle_database_connections sysconsole_read_environment_image_proxy read_elasticsearch_post_aggregation_job sysconsole_read_environment_logging convert_private_channel_to_public manage_others_outgoing_webhooks list_team_channels sysconsole_read_environment_file_storage sysconsole_write_plugins purge_bleve_indexes sysconsole_read_user_management_teams add_saml_idp_cert sysconsole_write_experimental_bleve add_saml_private_cert sysconsole_read_authentication_guest_access sysconsole_write_user_management_teams list_private_teams manage_team invalidate_email_invite remove_ldap_private_cert sysconsole_read_environment_rate_limiting invite_guest get_saml_cert_status manage_shared_channels manage_private_channel_members run_create sysconsole_read_user_management_channels	t	t
uicypuu777yo7pnut18k6zkbpw	team_admin	authentication.roles.team_admin.name	authentication.roles.team_admin.description	1675285301657	1675285303736	0	 manage_others_outgoing_webhooks manage_channel_roles read_public_channel_groups remove_user_from_team delete_others_posts delete_post create_post use_group_mentions add_reaction playbook_public_manage_roles manage_private_channel_members manage_team playbook_private_manage_roles manage_others_incoming_webhooks use_channel_mentions manage_others_slash_commands manage_outgoing_webhooks import_team convert_public_channel_to_private read_private_channel_groups manage_team_roles manage_slash_commands manage_incoming_webhooks remove_reaction manage_public_channel_members convert_private_channel_to_public	t	t
j93aoyy3rfydzrwwp8tnoddskw	system_guest	authentication.roles.global_guest.name	authentication.roles.global_guest.description	1675285301663	1675285303741	0	 create_group_channel create_direct_channel	t	t
78ju3jmaspr4jcnemnrseo718a	system_read_only_admin	authentication.roles.system_read_only_admin.name	authentication.roles.system_read_only_admin.description	1675285301710	1675285303791	0	 sysconsole_read_site_file_sharing_and_downloads sysconsole_read_user_management_teams sysconsole_read_plugins sysconsole_read_experimental_feature_flags sysconsole_read_compliance_custom_terms_of_service read_public_channel_groups read_audits read_other_users_teams sysconsole_read_integrations_integration_management sysconsole_read_compliance_data_retention_policy sysconsole_read_environment_rate_limiting get_logs list_private_teams sysconsole_read_reporting_team_statistics sysconsole_read_environment_database sysconsole_read_about_edition_and_license list_public_teams sysconsole_read_site_notifications sysconsole_read_compliance_compliance_monitoring sysconsole_read_site_public_links sysconsole_read_site_announcement_banner sysconsole_read_environment_high_availability read_elasticsearch_post_indexing_job read_public_channel sysconsole_read_authentication_openid sysconsole_read_environment_image_proxy read_license_information sysconsole_read_experimental_features read_data_retention_job test_ldap sysconsole_read_site_posts sysconsole_read_user_management_channels sysconsole_read_authentication_signup sysconsole_read_environment_developer download_compliance_export_result sysconsole_read_integrations_gif sysconsole_read_site_notices sysconsole_read_environment_file_storage sysconsole_read_authentication_mfa read_private_channel_groups sysconsole_read_compliance_compliance_export sysconsole_read_environment_web_server sysconsole_read_environment_logging sysconsole_read_user_management_groups sysconsole_read_authentication_password sysconsole_read_user_management_permissions sysconsole_read_experimental_bleve sysconsole_read_user_management_users read_elasticsearch_post_aggregation_job sysconsole_read_authentication_guest_access sysconsole_read_environment_performance_monitoring sysconsole_read_integrations_bot_accounts sysconsole_read_site_emoji sysconsole_read_site_customization sysconsole_read_site_localization sysconsole_read_environment_elasticsearch get_analytics sysconsole_read_authentication_saml sysconsole_read_environment_push_notification_server sysconsole_read_authentication_ldap sysconsole_read_environment_session_lengths sysconsole_read_authentication_email view_team sysconsole_read_products_boards sysconsole_read_site_users_and_teams sysconsole_read_reporting_site_statistics read_ldap_sync_job sysconsole_read_environment_smtp read_channel sysconsole_read_reporting_server_logs sysconsole_read_integrations_cors read_compliance_export_job	f	t
zdxbywdw1pb4bjprmezmktidkr	system_manager	authentication.roles.system_manager.name	authentication.roles.system_manager.description	1675285301731	1675285303801	0	 sysconsole_write_environment_rate_limiting manage_channel_roles sysconsole_read_integrations_cors test_ldap sysconsole_read_authentication_openid sysconsole_write_site_posts read_elasticsearch_post_indexing_job sysconsole_write_environment_smtp sysconsole_read_user_management_teams read_elasticsearch_post_aggregation_job sysconsole_read_site_file_sharing_and_downloads join_public_teams sysconsole_read_site_emoji sysconsole_write_site_emoji sysconsole_write_environment_developer read_channel manage_private_channel_members sysconsole_read_plugins sysconsole_read_products_boards join_private_teams sysconsole_write_environment_performance_monitoring sysconsole_read_environment_database sysconsole_read_environment_logging sysconsole_write_environment_image_proxy convert_private_channel_to_public sysconsole_read_site_users_and_teams sysconsole_read_environment_rate_limiting sysconsole_write_integrations_bot_accounts sysconsole_read_site_localization sysconsole_write_user_management_permissions add_user_to_team sysconsole_read_environment_push_notification_server sysconsole_read_environment_file_storage sysconsole_write_site_public_links sysconsole_write_user_management_teams view_team delete_public_channel sysconsole_read_integrations_integration_management create_elasticsearch_post_indexing_job test_elasticsearch sysconsole_read_environment_high_availability sysconsole_read_site_customization sysconsole_write_integrations_cors sysconsole_read_about_edition_and_license sysconsole_read_authentication_ldap read_private_channel_groups sysconsole_write_environment_file_storage manage_public_channel_members get_analytics sysconsole_read_environment_web_server recycle_database_connections sysconsole_read_site_public_links sysconsole_read_environment_developer sysconsole_write_environment_session_lengths sysconsole_write_environment_logging sysconsole_read_environment_image_proxy test_site_url sysconsole_write_user_management_channels sysconsole_read_user_management_permissions reload_config sysconsole_write_site_notifications sysconsole_read_integrations_gif sysconsole_write_environment_web_server sysconsole_read_authentication_signup sysconsole_write_environment_push_notification_server sysconsole_read_reporting_server_logs sysconsole_write_site_users_and_teams sysconsole_read_environment_session_lengths list_public_teams get_logs manage_team sysconsole_write_environment_high_availability sysconsole_write_products_boards sysconsole_read_environment_smtp read_ldap_sync_job test_s3 read_license_information sysconsole_write_site_file_sharing_and_downloads invalidate_caches sysconsole_read_environment_elasticsearch remove_user_from_team sysconsole_read_user_management_channels sysconsole_read_authentication_password sysconsole_write_site_customization edit_brand sysconsole_read_authentication_mfa manage_private_channel_properties sysconsole_write_user_management_groups sysconsole_read_site_notices sysconsole_read_site_notifications sysconsole_read_site_announcement_banner convert_public_channel_to_private sysconsole_read_environment_performance_monitoring test_email sysconsole_read_reporting_team_statistics purge_elasticsearch_indexes sysconsole_write_site_notices manage_public_channel_properties list_private_teams sysconsole_read_authentication_email sysconsole_write_site_announcement_banner sysconsole_write_integrations_integration_management read_public_channel sysconsole_read_user_management_groups sysconsole_write_environment_elasticsearch delete_private_channel sysconsole_read_integrations_bot_accounts sysconsole_write_site_localization sysconsole_read_reporting_site_statistics sysconsole_read_site_posts sysconsole_write_integrations_gif manage_team_roles sysconsole_read_authentication_saml sysconsole_write_environment_database read_public_channel_groups sysconsole_read_authentication_guest_access create_elasticsearch_post_aggregation_job	f	t
\.


--
-- Data for Name: schemes; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.schemes (id, name, displayname, description, createat, updateat, deleteat, scope, defaultteamadminrole, defaultteamuserrole, defaultchanneladminrole, defaultchanneluserrole, defaultteamguestrole, defaultchannelguestrole, defaultplaybookadminrole, defaultplaybookmemberrole, defaultrunadminrole, defaultrunmemberrole) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.sessions (id, token, createat, expiresat, lastactivityat, userid, deviceid, roles, isoauth, props, expirednotify) FROM stdin;
ipkj1iaax7yyff9jk9og86eeoh	4aymd68ihpytmcbafbtfptyzec	1675286410445	1677878410445	1675288618781	yp7iiitd1prkukea7ci1yeqo4h		system_user system_admin	f	{"os": "Mac OS", "csrf": "473f5m5jg38zzmofqghuodo5bw", "isSaml": "false", "browser": "Chrome/109.0", "isMobile": "false", "is_guest": "false", "platform": "Macintosh", "isOAuthUser": "false"}	f
magwjmmyg388bepg5j3qcb6rdr	1stoiq9d1ibq9q6ijkdknqomwa	1675794259517	1678386259517	1675814073190	cjsqd673nbgzzybrrkmzxou34y		system_user	f	{"os": "Mac OS", "csrf": "6dbazixr8ifwpenrws1jnado7o", "isSaml": "false", "browser": "Chrome/109.0", "isMobile": "false", "is_guest": "false", "platform": "Macintosh", "isOAuthUser": "false"}	f
nzp4sa6sbbgadpmc3xhmgpd1nr	wunm3dioj383xfm6rjqruhnynw	1675814070914	4829414070914	1675878049093	pqzp7j96epnczy4icow41mnhpc		system_user	f	{"type": "UserAccessToken", "is_guest": "false", "user_access_token_id": "eewj7s96s3baib1k1y64bcckfo"}	f
5s7s15pti3fxzr97zchcp8gczo	nzhn6ac6fpdbxcp39nnfpwe3oo	1675877956461	1678469956461	1675879561570	cjsqd673nbgzzybrrkmzxou34y		system_user	f	{"os": "Mac OS", "csrf": "hzrzajfqd3yhiyc5dympwfijae", "isSaml": "false", "browser": "Chrome/109.0", "isMobile": "false", "is_guest": "false", "platform": "Macintosh", "isOAuthUser": "false"}	f
mox6yuw8e7gyj8wmfut1s91nty	8swf93z98t8w5q9rc1ia8bmy5r	1675286607700	4828886607700	1675881596085	yp7iiitd1prkukea7ci1yeqo4h		system_user system_admin	f	{"type": "UserAccessToken", "is_guest": "false", "user_access_token_id": "au1qubnd5pngmpus4pxx7wjqnh"}	f
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
favorites_tkzqirh7h78opxqwk5a4bt3fkw_jubozzh9wi8g9j33syw1b4tefo	tkzqirh7h78opxqwk5a4bt3fkw	jubozzh9wi8g9j33syw1b4tefo	0		favorites	Favorites	f	f
direct_messages_tkzqirh7h78opxqwk5a4bt3fkw_jubozzh9wi8g9j33syw1b4tefo	tkzqirh7h78opxqwk5a4bt3fkw	jubozzh9wi8g9j33syw1b4tefo	20	recent	direct_messages	Direct Messages	f	f
channels_tkzqirh7h78opxqwk5a4bt3fkw_jubozzh9wi8g9j33syw1b4tefo	tkzqirh7h78opxqwk5a4bt3fkw	jubozzh9wi8g9j33syw1b4tefo	10		channels	Channels	f	t
favorites_yp7iiitd1prkukea7ci1yeqo4h_jubozzh9wi8g9j33syw1b4tefo	yp7iiitd1prkukea7ci1yeqo4h	jubozzh9wi8g9j33syw1b4tefo	0		favorites	Favorites	f	f
channels_yp7iiitd1prkukea7ci1yeqo4h_jubozzh9wi8g9j33syw1b4tefo	yp7iiitd1prkukea7ci1yeqo4h	jubozzh9wi8g9j33syw1b4tefo	10		channels	Channels	f	f
direct_messages_yp7iiitd1prkukea7ci1yeqo4h_jubozzh9wi8g9j33syw1b4tefo	yp7iiitd1prkukea7ci1yeqo4h	jubozzh9wi8g9j33syw1b4tefo	20	recent	direct_messages	Direct Messages	f	f
favorites_cjsqd673nbgzzybrrkmzxou34y_jubozzh9wi8g9j33syw1b4tefo	cjsqd673nbgzzybrrkmzxou34y	jubozzh9wi8g9j33syw1b4tefo	0		favorites	Favorites	f	f
channels_cjsqd673nbgzzybrrkmzxou34y_jubozzh9wi8g9j33syw1b4tefo	cjsqd673nbgzzybrrkmzxou34y	jubozzh9wi8g9j33syw1b4tefo	10		channels	Channels	f	f
direct_messages_cjsqd673nbgzzybrrkmzxou34y_jubozzh9wi8g9j33syw1b4tefo	cjsqd673nbgzzybrrkmzxou34y	jubozzh9wi8g9j33syw1b4tefo	20	recent	direct_messages	Direct Messages	f	f
favorites_pqzp7j96epnczy4icow41mnhpc_jubozzh9wi8g9j33syw1b4tefo	pqzp7j96epnczy4icow41mnhpc	jubozzh9wi8g9j33syw1b4tefo	0		favorites	Favorites	f	f
channels_pqzp7j96epnczy4icow41mnhpc_jubozzh9wi8g9j33syw1b4tefo	pqzp7j96epnczy4icow41mnhpc	jubozzh9wi8g9j33syw1b4tefo	10		channels	Channels	f	f
direct_messages_pqzp7j96epnczy4icow41mnhpc_jubozzh9wi8g9j33syw1b4tefo	pqzp7j96epnczy4icow41mnhpc	jubozzh9wi8g9j33syw1b4tefo	20	recent	direct_messages	Direct Messages	f	f
\.


--
-- Data for Name: sidebarchannels; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.sidebarchannels (channelid, userid, categoryid, sortorder) FROM stdin;
6j47rggkup8xupunzj5dfxojih	tkzqirh7h78opxqwk5a4bt3fkw	channels_tkzqirh7h78opxqwk5a4bt3fkw_jubozzh9wi8g9j33syw1b4tefo	0
g593o5aooif69kt9xfdzsydu3y	tkzqirh7h78opxqwk5a4bt3fkw	channels_tkzqirh7h78opxqwk5a4bt3fkw_jubozzh9wi8g9j33syw1b4tefo	10
\.


--
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.status (userid, status, manual, lastactivityat, dndendtime, prevstatus) FROM stdin;
yp7iiitd1prkukea7ci1yeqo4h	offline	f	1675881695974	0	
tkzqirh7h78opxqwk5a4bt3fkw	offline	f	1675286388070	0	
pqzp7j96epnczy4icow41mnhpc	offline	f	1675878049091	0	
cjsqd673nbgzzybrrkmzxou34y	away	f	1675879561566	0	
\.


--
-- Data for Name: systems; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.systems (name, value) FROM stdin;
CRTChannelMembershipCountsMigrationComplete	true
CRTThreadCountsAndUnreadsMigrationComplete	true
AsymmetricSigningKey	{"ecdsa_key":{"curve":"P-256","x":76922608848199862515255347341586031219414477802226579870247450716227773439247,"y":40418267195094452651506833300213035952413593774287377291786400084185694192021,"d":90275341277204837488240769729546239734190548889267159865572707162925962033647}}
DiagnosticId	7xtctx5u6bgmmnx54pymduh3rr
AdvancedPermissionsMigrationComplete	true
FirstServerRunTimestamp	1675285301751
EmojisPermissionsMigrationComplete	true
GuestRolesCreationMigrationComplete	true
SystemConsoleRolesCreationMigrationComplete	true
CustomGroupAdminRoleCreationMigrationComplete	true
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
PostActionCookieSecret	{"key":"cz0ahfBhM3+hr7bFsWGRXy7zuVOEY0ndtbsFO/Nry0E="}
InstallationDate	1675285308118
migration_advanced_permissions_phase_2	true
LastSecurityTime	1675793871428
FirstAdminSetupComplete	true
\.


--
-- Data for Name: teammembers; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.teammembers (teamid, userid, roles, deleteat, schemeuser, schemeadmin, schemeguest, createat) FROM stdin;
jubozzh9wi8g9j33syw1b4tefo	tkzqirh7h78opxqwk5a4bt3fkw		0	t	t	f	1675285819336
jubozzh9wi8g9j33syw1b4tefo	yp7iiitd1prkukea7ci1yeqo4h		0	t	f	f	1675286415612
jubozzh9wi8g9j33syw1b4tefo	cjsqd673nbgzzybrrkmzxou34y		0	t	f	f	1675794260313
jubozzh9wi8g9j33syw1b4tefo	pqzp7j96epnczy4icow41mnhpc		0	t	f	f	1675814025371
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.teams (id, createat, updateat, deleteat, displayname, name, description, email, type, companyname, alloweddomains, inviteid, schemeid, allowopeninvite, lastteamiconupdate, groupconstrained, cloudlimitsarchived) FROM stdin;
jubozzh9wi8g9j33syw1b4tefo	1675285819301	1675286258192	0	main	main		admin@localhost.com	O			zy7zmeoy9igbtjpgm8mfky4qho	\N	t	0	\N	f
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
au1qubnd5pngmpus4pxx7wjqnh	8swf93z98t8w5q9rc1ia8bmy5r	yp7iiitd1prkukea7ci1yeqo4h	Bridge Token	t
eewj7s96s3baib1k1y64bcckfo	wunm3dioj383xfm6rjqruhnynw	pqzp7j96epnczy4icow41mnhpc	bridge	t
j58z4mccftfp3mrjq963y6byhw	zsgpd5dqh7rqpbpajay98nadqh	cjsqd673nbgzzybrrkmzxou34y	For the bridge	t
\.


--
-- Data for Name: usergroups; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.usergroups (id, name, displayname, description, source, remoteid, createat, updateat, deleteat, allowreference) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.users (id, createat, updateat, deleteat, username, password, authdata, authservice, email, emailverified, nickname, firstname, lastname, roles, allowmarketing, props, notifyprops, lastpasswordupdate, lastpictureupdate, failedattempts, locale, mfaactive, mfasecret, "position", timezone, remoteid) FROM stdin;
x3wbz7kwnif3tj751sffqtpuuy	1675285310432	1675285310432	0	boards		\N		boards@localhost	f		Boards		system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1675285310432	0	0	en	f			{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	\N
tkzqirh7h78opxqwk5a4bt3fkw	1675285774948	1675285819350	0	admin	$2a$10$4RMWvFeXcKwBs6j1H3Owv.ydMvOr.F7gXMTCX4YG2oLwEGrZVaW4m	\N		admin@localhost.com	f				system_admin system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1675285774948	0	0	en	f			{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	\N
x8ummu1bgtnstcy1j78c75ozsa	1675285799658	1675285799658	0	system-bot		\N		system-bot@localhost	f		System		system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1675285799658	0	0	en	f			{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	\N
yp7iiitd1prkukea7ci1yeqo4h	1675286152435	1675287027020	0	matrix.bridge	$2a$10$wLN6Lkvt.ARVyOb0H/4ggeREZpWl6YX7Wn3.gh/otkV22G9kDX2Nm	\N		matrix.bridge@localhost.com	f				system_user system_admin	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1675286152435	0	0	en	f			{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	\N
tftaugsmmpygxgik3w48nybfdc	1675285308118	1675813495923	0	appsbot		\N		appsbot@localhost	f		Mattermost Apps		system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1675285308118	1675813495923	0	en	f			{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	\N
sqf1gfpbu7ngpgzbcqt93p87ro	1675285308619	1675813496377	0	playbooks		\N		playbooks@localhost	f		Playbooks		system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1675285308619	1675813496377	0	en	f			{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	\N
cjsqd673nbgzzybrrkmzxou34y	1675794259183	1675794260329	0	user1.mm	$2a$10$hzdXkqN3YJeKOYhxXF6clusLNNZ9RygbGnxd1suiJGgS3M9bXS0Uq	\N		user1.mm@localhost.com	f				system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1675794259183	0	0	en	f			{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	\N
pqzp7j96epnczy4icow41mnhpc	1675814024893	1675881820138	0	matrix_user1.matrix	$2a$10$Ra86SnWXs7lsHi2nP49nTORkGuMmUgu0mkBVb66Hz67lgtAxnTgai	\N		devnull-4nct-f9uaniikzdu@localhost	t		user1.matrix		system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1675814024893	0	0	en	f			{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	\N
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

