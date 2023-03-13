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
rhn48zj797f9dry99r4niiw1qa	1675955707319	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	attempt - login_id=	172.16.238.1	
ohbnmz3s43d6zmxyar5rg9yoge	1675955707411	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	authenticated	172.16.238.1	
8153118mr38u5raz5gjt56uwce	1675955707421	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	success session_user=whida44gqpyfierua1wfrnbxtr	172.16.238.1	6tsp3x1o8jy5j8okhmjfwd36mo
3atkiytc5ib8tkifimtusz5fny	1675955743974	whida44gqpyfierua1wfrnbxtr	/api/v4/teams/ebxg8q3pzbdrdjo7xx1qqw3guy/patch		172.16.238.1	6tsp3x1o8jy5j8okhmjfwd36mo
hpuhxi3mdib8zpqyeh7754zjie	1675956068388	whida44gqpyfierua1wfrnbxtr	/api/v4/users/logout		172.16.238.1	6tsp3x1o8jy5j8okhmjfwd36mo
34yf3ai8w3yq8dqkqfpi58jjje	1675956108661	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/login	attempt - login_id=	172.16.238.1	
brp6uq7wm3rafxhfc7cmsbf68c	1675956108753	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/login	authenticated	172.16.238.1	
hg7yrwk867g5xg5n5iiugpyzka	1675956108757	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/login	success session_user=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	imcx9g55gff5mq96mu9iw14egc
1y8jzsxbwtfhiguqod43dpcqcy	1675956123989	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/logout		172.16.238.1	imcx9g55gff5mq96mu9iw14egc
ksrhjssjzpdcidsx33q5i1cjty	1675956135651		/api/v4/users/login	attempt - login_id=admin	172.16.238.1	
mfoxiso69pb7zcjm94oh4efycw	1675956135757	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	authenticated	172.16.238.1	
iamygnrm4i8h3d36pr5b9suarr	1675956135766	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	success session_user=whida44gqpyfierua1wfrnbxtr	172.16.238.1	6b19i3jrkfd5zmxebyikj1rf6e
4scqck4tebdj8fixhsecj7bjao	1675956222154	whida44gqpyfierua1wfrnbxtr	/api/v4/users/geds3gxhdf81dccdrm8bfx37ry/roles	user=geds3gxhdf81dccdrm8bfx37ry roles=system_user system_admin	172.16.238.1	6b19i3jrkfd5zmxebyikj1rf6e
h4rr7y167fru9neqq4xi4ca43c	1675956299534	whida44gqpyfierua1wfrnbxtr	/api/v4/users/logout		172.16.238.1	6b19i3jrkfd5zmxebyikj1rf6e
g6hgsz1rfbrb8bsn7pos4jy8mr	1675956310153		/api/v4/users/login	attempt - login_id=matrix.bridge	172.16.238.1	
finm6w4nqibk7m7nf6bjiogz3h	1675956310249	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/login	authenticated	172.16.238.1	
wzocniedfigpj813g8f1mkpdzw	1675956310255	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/login	success session_user=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	qy444n649bgzib69a5atczyjxo
55gapndh6fyxigfgss8gy5euzr	1675956350427	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/geds3gxhdf81dccdrm8bfx37ry/tokens		172.16.238.1	qy444n649bgzib69a5atczyjxo
ax3d8en3b7rife19kupt4apfac	1675956350455	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/geds3gxhdf81dccdrm8bfx37ry/tokens	success - token_id=gshdfwp6ytf43pf5q9sra1cs5c	172.16.238.1	qy444n649bgzib69a5atczyjxo
9ieuq56rc7df9g1epbomzrc1fo	1675956396357	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/logout		172.16.238.1	qy444n649bgzib69a5atczyjxo
wimwy453i3rqxxqc4kf8m8i6we	1675956418392	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	attempt - login_id=	172.16.238.1	
ndkxnuawebn3pe47mgfpxbzdco	1675956418483	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
9t1qc7qckjru5gfghdh6gmfx3c	1675956418487	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	rxnatzefbibc7kq8mhyoqr69zy
86usouqmjbguby1arkxctqe1fr	1676645977029		/api/v4/users/login	attempt - login_id=matrix.bridge	172.16.238.1	
nh1dr6agfbfsjjzrexc738c71y	1676645977151	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/login	authenticated	172.16.238.1	
1wfjkcf63jd9dje33a5enqjwuo	1676645977164	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/login	success session_user=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	ipi95so6z7by5r8e7jergii78o
heiugx3x3frs7cpwn1zxuwu1uc	1676646002094	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/tokens/revoke		172.16.238.1	ipi95so6z7by5r8e7jergii78o
7dfmpbbsd3r6xnxcp41d7eobkr	1676646002112	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/tokens/revoke	success - token_id=gshdfwp6ytf43pf5q9sra1cs5c	172.16.238.1	ipi95so6z7by5r8e7jergii78o
zxjankkttifkxbk1o7hx6wqj1e	1676646021595	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/geds3gxhdf81dccdrm8bfx37ry/tokens		172.16.238.1	ipi95so6z7by5r8e7jergii78o
jigbyybfqfn55k3g8qi8jbxu5h	1676646021601	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/geds3gxhdf81dccdrm8bfx37ry/tokens	success - token_id=smw3ipoqajyrdxie69w464cy9e	172.16.238.1	ipi95so6z7by5r8e7jergii78o
gjxn3uhx5bbxudbte53sk3jukr	1676646213954	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
e33dqoqi67bc7m1m93zegepxfo	1676646213972	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
imxwy56aqfnpufoh9inp9om89r	1676646214478	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/email/verify/member	user verified	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
rd98qdccmt8ddykewgx14gpdih	1676646214488	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/tokens		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
rczt9pdi1pdmbdyn1yjitjhq9h	1676646214506	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/tokens	success - token_id=gbrc7c89sbfepjfxyijj5bkwyh	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
wfwyxnkb47gm9eid58nwnzp38o	1676646214633	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
cjg14a5pwtf9inxubr5djas8pe	1676646214702	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
b4o7dc5edjgqzdsr3gjud15axa	1676646214941	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/ygmycw6rnff7igko8gwbqchujr/tokens		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
3yrysrsgdib9bqqebt3t7ewziw	1676646214948	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/ygmycw6rnff7igko8gwbqchujr/tokens	success - token_id=1wnn4juj47nhuqu6rnbsknpqjh	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
mtc4cpmez7n4zbw97zyc6bnmyc	1676646295437	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
33nwux7deby1bfnynzepkrposw	1676646295439	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
c9o3n163wi89dm6k3aqznregzr	1676646295584	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
zdpzducysifd788nt57dw4ajfy	1676646295613	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
oi3ykcg4efd9zrh84hxjatbf1w	1676646295630	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
yzrrdinx3p8tdp9161edsaaifw	1676646295643	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
yjmskucr63fs3kfo8mh9neqtjr	1676646295703	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/ygmycw6rnff7igko8gwbqchujr/tokens		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
6bxmoiohwfn38r6gbwjjambdsh	1676646295710	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/ygmycw6rnff7igko8gwbqchujr/tokens	success - token_id=mnr319koxbdzibwaihhtetpxsw	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
pj9nck67up8jjbf79t769egefc	1676646337586	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/logout		172.16.238.1	ipi95so6z7by5r8e7jergii78o
ecumdh6xg3rxmbjmrdso44pepe	1676646349974		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
ic46jko3abgpzqhhak9tj7ykto	1676646350078	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
sdpb9hqfj7dj7cne1s7ak39nmy	1676646350086	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	uh3yuor4itngzkmp4189tnx6pe
1ko6e8zmr3ye9xqxqfd344qzny	1678032788248	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
jyymbhndnin88q5y75k8taoaih	1678032788283	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
9qswsnr37jfsurihogii7pqz1y	1678032788475	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
jij8mwej7pn7tetnwfshhxpdhh	1678032788483	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
4ecm36rpupdodycys4irajmkor	1678032788499	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
8nro8gi5t78qxr1tkb5a77bxna	1678032788509	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
u7rhaprbbiygjjxbjh8pcgzaiw	1678032922851		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
fr6xqmffu7ne8cuigu887wypfo	1678032922969	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
gh4ryy8sdtf49gxwtnosmca4ec	1678032922981	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	bhw8um8scfgu38j6o84j9ie7ur
sm4doamqdj8xuchkaeo994ykdr	1678033182631	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
ow733ybf3jy7jdeob3h6dkwsxe	1678033182633	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
bqrse5aaijg17ko74mmkemebqy	1678033182764	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
hi1hxzx863b15b3dnaui5graee	1678033182796	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
4j46um3j9byd3bo1xd3fbxidnc	1678033182816	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
tcj77wtak7np7jy5d4mjqspmrw	1678033182813	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
6spsjbzt6tbgfj3cmbj9w8qxmw	1678033205190	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
harci8epfjf5pjmd1u7rkaxwqr	1678033205192	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
un6odrmm1bbyujzdjzm86gtkjh	1678033205284	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
wd5cxwbbi7rtfyimsqqwnuuxsw	1678033205299	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
1mcn6431h3yz9yy1sp4khtcsta	1678033205320	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
8g557urr1jgxiygu6hpik8fo7e	1678033205324	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
9qg6a44hq3fo9fk48t5m4esrby	1678033376362	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/logout		172.16.238.1	bhw8um8scfgu38j6o84j9ie7ur
n7jtfky9p3ywmgmopfmmnpr1zc	1678033386889		/api/v4/users/login	attempt - login_id=matrix.bridge	172.16.238.1	
bebg8ihymtbczgnjd4d1xyqq5y	1678033386980	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/login	authenticated	172.16.238.1	
uct6w7oiufn18ry4c3maeci31y	1678033386986	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/login	success session_user=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	7r3gi9ip8jr1bfsmctretdjqxe
1xg3dodrwjf3jx3unzesou7wzo	1678033387743	geds3gxhdf81dccdrm8bfx37ry	/api/v4/system/notices/view	attempt	172.16.238.1	7r3gi9ip8jr1bfsmctretdjqxe
h6t7ejfcstgjfxfu8kx99yiyjo	1678033545998	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels	name=after-work	172.16.238.1	7r3gi9ip8jr1bfsmctretdjqxe
gmgouprahffpxpa13j91edfgjc	1678033569438	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
toyfjy6ohiy4tcqdd8yzt8ee5c	1678033569438	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
e58ifa3dojfqdbjjssmiwki3xe	1678033569535	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
ppd4gajryifqupot7zxx4kjcko	1678033569551	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
yf69mih1n3bu5f46ppjzcx7jnc	1678033569560	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
45fjttesqb8wfme13kx5sj1c9a	1678033742784	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/logout		172.16.238.1	7r3gi9ip8jr1bfsmctretdjqxe
qt5edfayxjfazqmiy1kjm85haa	1678033753100		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
r7337r4rzpgkicxezur53wtp5y	1678033753202	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
5tminsptiiyufm7xjozd8f37aw	1678033753208	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	aaz1gspyt7fq8nu7p378hmmsyy
fjitr916wb8z5jszazowmbg5tc	1678033923769	ygmycw6rnff7igko8gwbqchujr	/api/v4/channels/rk4gdc4whjnupqoad46hwa9cme/members	name=my-public-room user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	aaz1gspyt7fq8nu7p378hmmsyy
91so4aeb93gxpmgansd3oxstta	1678033936545	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
rsdmjor9k38xipgujehux4xwsr	1678033936650	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
4def8apmzjrhpgtseryoobw6ye	1678033936681	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
8f5eb6oactgr5pxo3a1wumkq8y	1678033569580	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
mddr448y8j8wpf44ms8wpg8bwa	1678033569823	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members/geds3gxhdf81dccdrm8bfx37ry	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
tgg3qm8bb7b5bndynaaganeo4h	1678033632064	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
7qfjy4sf53y1z8rwbpxamey1cy	1678033632068	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
wzcxf4inxtdpmxb5yokm6dhhrc	1678033632149	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
71mjtkozabf6jxndbk9at13qpr	1678033632176	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
bdpzq7crxif18dc3bhrf3xb8mo	1678033632181	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
dga3fcz5cjdhpkdm544riqnqmr	1678033632206	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
gnea45aetjncz8gqya3hjq8rue	1678033679032	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	7r3gi9ip8jr1bfsmctretdjqxe
ymkzn447t3835ftqstma456z1y	1678033706245	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
x69irux8i3dspcjyb8pyohxbby	1678033706248	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
igrkkicxgpyaj88a8p4qx578ir	1678033706366	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
r5wcktfx47rc5n8kd75fbsugbw	1678033706478	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
bfic3ywwrtdx5jpf7uox48txth	1678033706480	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
hwi9k7urtf8f5po8t47r83aibw	1678033706508	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
8czi9b4qwj8ydktt1ooruit4my	1678033706508	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
9okyjgmhhibdicn7ssbh85wnmy	1678033762207	ygmycw6rnff7igko8gwbqchujr	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	aaz1gspyt7fq8nu7p378hmmsyy
wjtp1t4o9byqxe6uoes7wrzbke	1678033782612	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
6pxmza89rpr75rp7k6zceyeuqh	1678033782828	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
uuk6fwt15fy4db3jfraiop7bny	1678033905164	ygmycw6rnff7igko8gwbqchujr	/api/v4/channels	name=my-public-room	172.16.238.1	aaz1gspyt7fq8nu7p378hmmsyy
rngcudjoxb8qfxak7oxi8np77h	1678033936547	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
dwni7jqfdifmzr9a3inzdfnn8y	1678033936552	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
gtehenpwyido5r5ewhw9xqi93h	1678033936648	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
85br3r8otb84xfuzih6gxu7zyc	1678033936653	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
7d7kh7sp8ife8cyhfrqamja6ih	1678033936671	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
sdrtr3q7kjr93jye4hjqbykf9c	1678033936690	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
bq1wrkcwf3rzfcqm1dzyjrxx4r	1678033937167	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/rk4gdc4whjnupqoad46hwa9cme/members/geds3gxhdf81dccdrm8bfx37ry	name=my-public-room user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
njoduqdfpfr1z8woqjye8mrd6r	1678033988125	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
9h1588pue3b59g46zmux6j84ew	1678033988129	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
6q81mmxmk3nimjraweg678si7r	1678033988132	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
kkwjca8wytnh3bcqmwfxojnugy	1678033988224	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
wndfs9hc9trnin63gdw8qof9ea	1678033988260	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
kkrrfkxos38x38tyyyzqqmrd9y	1678033988285	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
c3p1i36ietrt8gaqyaoh3amt4o	1678033988293	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
nj4gj3nqxif3dka8xm7o8fr1gh	1678033988301	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
qgzepsbbgtgtjj4cjpei6gyf1c	1678033988343	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
ei5z7fagkjfnzxxdq54uuo6awc	1678034021923	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/logout		172.16.238.1	aaz1gspyt7fq8nu7p378hmmsyy
i4ibhrspftr8idaypjwq9dga5h	1678611343373	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
9ojd5kbmgtb5bby1yg3hi8t8hh	1678611343406	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
oh4sc1ikpbdw9njqa83c6wpmww	1678611343418	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
5daey6un73rnug7zuk97piyu1o	1678611343546	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
nafxux46qt8bd8i773rrayxuoy	1678611343556	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
b7wsm59j17duipkbotbf5kaoeo	1678611343570	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
8u8konx3rirwim95zagdj3r9gy	1678611343572	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
5t7dag16s3yfpx38rto6kdz81w	1678611343597	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
bkt1tif8rfg95k8fqq6e8357bh	1678611343609	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
tf93rxkzmtfsdjp7ptcux14u7y	1678611367845	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/wq6i7sbf4tnqzbssbn7gy7cjcc/email/verify/member	user verified	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
siog3k6nz3g3dxzyed1idey8ay	1678611367865	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/wq6i7sbf4tnqzbssbn7gy7cjcc/tokens		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
xyn8ggn7abgutjisoadiakpmic	1678611367875	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/wq6i7sbf4tnqzbssbn7gy7cjcc/tokens	success - token_id=nqkt9swge3n87xo18tsdutbryr	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
jfbgbgd4fig7bgkc8skyqtyy6a	1678611369040	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members/wq6i7sbf4tnqzbssbn7gy7cjcc	name=off-topic user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
4idjrn3n5jdxumiy8c6jhktyoo	1678611369120	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
oejb1rimbigj8k363e4y6zfhua	1678611392671	e343y5ecu7dyujwqm7yfimh1je	/api/v4/users/login	attempt - login_id=	172.16.238.1	
q84cd5znd3bytft6sfk3ykmh5o	1678611392771	e343y5ecu7dyujwqm7yfimh1je	/api/v4/users/login	authenticated	172.16.238.1	
1m7tg78abjd3tnopgs9yauxwsr	1678611392779	e343y5ecu7dyujwqm7yfimh1je	/api/v4/users/login	success session_user=e343y5ecu7dyujwqm7yfimh1je	172.16.238.1	6bo5tyfo4pbz9qygrgdhnangyh
7mdj5gnq17fjbkipnozzsjsk4y	1678611396880	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/e343y5ecu7dyujwqm7yfimh1je/tokens		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
pka1xbq4mjfj8fq67199x1bmsw	1678611396898	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/e343y5ecu7dyujwqm7yfimh1je/tokens	success - token_id=fst4r7d4ninxtexjknn4y4ooqa	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
jup9sxxqcjfbicmbk3ut3pgnhh	1678611421794	e343y5ecu7dyujwqm7yfimh1je	/api/v4/users/logout		172.16.238.1	6bo5tyfo4pbz9qygrgdhnangyh
\.


--
-- Data for Name: bots; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.bots (userid, description, ownerid, createat, updateat, deleteat, lasticonupdate) FROM stdin;
uzpc4t1qkjbt3gspmrtmuzrimw	Mattermost Apps Registry and API proxy.	com.mattermost.apps	1675955407740	1675955407740	0	0
nm4raj8trpgetcnutzc8icka7r	Playbooks bot.	playbooks	1675955408410	1675955408410	0	0
g6hetueczp8wif38h7o3o1pcyc	Created by Boards plugin.	focalboard	1675955410092	1675955410092	0	0
59858ksa4ircjd9a5811negojr		whida44gqpyfierua1wfrnbxtr	1675955999763	1675955999763	0	0
\.


--
-- Data for Name: channelmemberhistory; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.channelmemberhistory (channelid, userid, jointime, leavetime) FROM stdin;
p7retz8iwtgzdrdceqw13fwmbr	whida44gqpyfierua1wfrnbxtr	1675955722125	\N
giyj94p1fp86p8zs9z6u5b3ujh	whida44gqpyfierua1wfrnbxtr	1675955722214	\N
p7retz8iwtgzdrdceqw13fwmbr	geds3gxhdf81dccdrm8bfx37ry	1675956111707	\N
giyj94p1fp86p8zs9z6u5b3ujh	geds3gxhdf81dccdrm8bfx37ry	1675956111736	\N
p7retz8iwtgzdrdceqw13fwmbr	ygmycw6rnff7igko8gwbqchujr	1675956421325	\N
giyj94p1fp86p8zs9z6u5b3ujh	ygmycw6rnff7igko8gwbqchujr	1675956421364	\N
p7retz8iwtgzdrdceqw13fwmbr	bgct5icpib883fx619bh3cfu6h	1676646214689	\N
giyj94p1fp86p8zs9z6u5b3ujh	bgct5icpib883fx619bh3cfu6h	1676646214697	\N
giyj94p1fp86p8zs9z6u5b3ujh	bgct5icpib883fx619bh3cfu6h	1676646214765	\N
9wp7xhh6f7namrfm1asziaf9nh	geds3gxhdf81dccdrm8bfx37ry	1678033545977	1678033569794
9wp7xhh6f7namrfm1asziaf9nh	geds3gxhdf81dccdrm8bfx37ry	1678033678971	\N
9wp7xhh6f7namrfm1asziaf9nh	ygmycw6rnff7igko8gwbqchujr	1678033762129	\N
9wp7xhh6f7namrfm1asziaf9nh	bgct5icpib883fx619bh3cfu6h	1678033782813	\N
rk4gdc4whjnupqoad46hwa9cme	ygmycw6rnff7igko8gwbqchujr	1678033905146	\N
rk4gdc4whjnupqoad46hwa9cme	geds3gxhdf81dccdrm8bfx37ry	1678033923766	1678033937009
p7retz8iwtgzdrdceqw13fwmbr	wq6i7sbf4tnqzbssbn7gy7cjcc	1678611368277	\N
giyj94p1fp86p8zs9z6u5b3ujh	wq6i7sbf4tnqzbssbn7gy7cjcc	1678611368371	1678611368803
p7retz8iwtgzdrdceqw13fwmbr	e343y5ecu7dyujwqm7yfimh1je	1678611396672	\N
giyj94p1fp86p8zs9z6u5b3ujh	e343y5ecu7dyujwqm7yfimh1je	1678611396725	\N
\.


--
-- Data for Name: channelmembers; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.channelmembers (channelid, userid, roles, lastviewedat, msgcount, mentioncount, notifyprops, lastupdateat, schemeuser, schemeadmin, schemeguest, mentioncountroot, msgcountroot) FROM stdin;
giyj94p1fp86p8zs9z6u5b3ujh	whida44gqpyfierua1wfrnbxtr		1675955722219	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1675955722219	t	t	f	0	0
p7retz8iwtgzdrdceqw13fwmbr	whida44gqpyfierua1wfrnbxtr		1675956111709	1	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1675956111709	t	t	f	0	1
giyj94p1fp86p8zs9z6u5b3ujh	geds3gxhdf81dccdrm8bfx37ry		1676646214793	1	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1676646214793	t	f	f	0	1
9wp7xhh6f7namrfm1asziaf9nh	geds3gxhdf81dccdrm8bfx37ry		1678033721258	1	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1678033721258	t	f	f	0	1
giyj94p1fp86p8zs9z6u5b3ujh	ygmycw6rnff7igko8gwbqchujr		1676646372520	2	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1676646372520	t	f	f	0	2
p7retz8iwtgzdrdceqw13fwmbr	ygmycw6rnff7igko8gwbqchujr		1678033315382	5	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1678033315382	t	f	f	0	5
giyj94p1fp86p8zs9z6u5b3ujh	bgct5icpib883fx619bh3cfu6h		1678032959928	3	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1678032959928	t	f	f	0	3
p7retz8iwtgzdrdceqw13fwmbr	bgct5icpib883fx619bh3cfu6h		1678033315382	5	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1678033315382	t	f	f	0	5
rk4gdc4whjnupqoad46hwa9cme	ygmycw6rnff7igko8gwbqchujr		1678033959731	2	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1678033959731	t	t	f	0	2
p7retz8iwtgzdrdceqw13fwmbr	geds3gxhdf81dccdrm8bfx37ry		1678033315382	5	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1678033315382	t	t	f	0	5
9wp7xhh6f7namrfm1asziaf9nh	ygmycw6rnff7igko8gwbqchujr		1678034001601	4	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1678034001601	t	f	f	0	4
9wp7xhh6f7namrfm1asziaf9nh	bgct5icpib883fx619bh3cfu6h		1678034001601	4	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1678034001601	t	f	f	0	4
p7retz8iwtgzdrdceqw13fwmbr	wq6i7sbf4tnqzbssbn7gy7cjcc		1678611372954	6	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1678611372954	t	f	f	0	6
giyj94p1fp86p8zs9z6u5b3ujh	e343y5ecu7dyujwqm7yfimh1je		1678611396734	3	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1678611396734	t	f	f	0	3
p7retz8iwtgzdrdceqw13fwmbr	e343y5ecu7dyujwqm7yfimh1je		1678611396675	6	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1678611396675	t	f	f	0	6
\.


--
-- Data for Name: channels; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.channels (id, createat, updateat, deleteat, teamid, type, displayname, name, header, purpose, lastpostat, totalmsgcount, extraupdateat, creatorid, schemeid, groupconstrained, shared, totalmsgcountroot, lastrootpostat) FROM stdin;
rk4gdc4whjnupqoad46hwa9cme	1678033905128	1678033905128	0	ebxg8q3pzbdrdjo7xx1qqw3guy	O	My Public Room	my-public-room			1678033959731	2	0	ygmycw6rnff7igko8gwbqchujr		f	\N	2	1678033959731
9wp7xhh6f7namrfm1asziaf9nh	1678033545956	1678033545956	0	ebxg8q3pzbdrdjo7xx1qqw3guy	O	After Work	after-work		An channel for afterwork 	1678034001601	4	0	geds3gxhdf81dccdrm8bfx37ry		f	\N	4	1678034001601
p7retz8iwtgzdrdceqw13fwmbr	1675955722038	1675955722038	0	ebxg8q3pzbdrdjo7xx1qqw3guy	O	Town Square	town-square			1678611396675	6	0		\N	\N	\N	6	1678611396675
giyj94p1fp86p8zs9z6u5b3ujh	1675955722056	1675955722056	0	ebxg8q3pzbdrdjo7xx1qqw3guy	O	Off-Topic	off-topic			1678611396734	3	0		\N	\N	\N	3	1678611396734
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
\.


--
-- Data for Name: focalboard_blocks; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_blocks (id, insert_at, parent_id, schema, type, title, fields, create_at, update_at, delete_at, root_id, modified_by, channel_id, created_by, board_id) FROM stdin;
czebhwzawapy55jy4qxmozzo4cr	2023-02-09 15:10:10.121663+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Team Schedule	{"contentOrder":["axpbptk9grbrhzdq9rodcqgomra","7dzinn6e9fpri3chki7e71xs8yh","ayarazd7asb8ozkksuxy5351aqh","7196jqjcy8jn7bmsod7ythqpamw","7omaahugkcfdhp8xohiy1d7iniy","7pwy6b4y9qtde9mayz9t576wzbo"],"icon":"⏰","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"8b05c83e-a44a-4d04-831e-97f01d8e2003","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"34eb9c25-d5bf-49d9-859e-f74f4e0030e7"}}	1675955410132	1675955410132	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
caaryyfj35iyo9q7ukein9jiu4e	2023-02-09 15:10:10.121663+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Video production	{"contentOrder":["aiwph7zdhpjbombd49uom6p5qxy","7yd3axyrhzbyh3x9qozk5qtbsrh","ai93zq6uonfrf7gjibrwatofmiy","79u5d4yzqdjg65qgcpwbmob9fzo","7eqriuxcf87dh9frg5aiuc1bp9r","7hhgoyez5etb7mpptkrdq75dghe"],"icon":"📹","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"b1abafbf-a038-4a19-8b68-56e0fd2319f7","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"34eb9c25-d5bf-49d9-859e-f74f4e0030e7"}}	1675955410138	1675955410138	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
ctor6xdeexffg8xzqd76prxk1ge	2023-02-09 15:10:10.121663+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Offsite plans	{"contentOrder":["awjd7cdpaobfi7yofwb76szzdjw","7wgktjf58itbeddwexf15wbg59a","adc9tusigjj8rzqxbfo7s7uko6a","7hncbmdr4jpng3xb44yth4mmwma","7zcg6yc1dyjbwi8nys6916knsse","797gc7kuqubggbbth9tjb394r5c"],"icon":"🚙","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"8b05c83e-a44a-4d04-831e-97f01d8e2003","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"dabadd9b-adf1-4d9f-8702-805ac6cef602"}}	1675955410145	1675955410145	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
cbpyozo5n738dmq36auszr7twty	2023-02-09 15:10:10.121663+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Social Media Strategy	{"contentOrder":["a7nrc4e58m3ru5puz4wswn1trdc","7dqzit6ec5t8ubbnf5pzarpuuja","aoudetcozh3yfmkqkq3cyhp9d8w","7xz74uk3bt3fu9y6spr7s69f8cc","7pbnkbqkjipb47cjxptp91ppz4c","7bqzsshop3pg9mka4h1tspz8ity"],"icon":"🎉","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"b1abafbf-a038-4a19-8b68-56e0fd2319f7","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"d37a61f4-f332-4db9-8b2d-5e0a91aa20ed"}}	1675955410150	1675955410150	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
vkngsehpzdbf47g6pgp9fxz4o7a	2023-02-09 15:10:10.121663+00	b7wnw9awd4pnefryhq51apbzb4c	1	view	Discussion Items	{"cardOrder":["cjpkiya33qsagr4f9hrdwhgiajc"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"d777ba3b-8728-40d1-87a6-59406bbbbfb0","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[{"propertyId":"4cf1568d-530f-4028-8ffd-bdc65249187e","reversed":false}],"viewType":"board","visibleOptionIds":[],"visiblePropertyIds":["4cf1568d-530f-4028-8ffd-bdc65249187e"]}	1675955410157	1675955410157	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7omaahugkcfdhp8xohiy1d7iniy	2023-02-09 15:10:10.121663+00	czebhwzawapy55jy4qxmozzo4cr	1	checkbox		{"value":false}	1675955410167	1675955410167	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7196jqjcy8jn7bmsod7ythqpamw	2023-02-09 15:10:10.121663+00	czebhwzawapy55jy4qxmozzo4cr	1	checkbox		{"value":false}	1675955410172	1675955410172	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7dzinn6e9fpri3chki7e71xs8yh	2023-02-09 15:10:10.121663+00	czebhwzawapy55jy4qxmozzo4cr	1	divider		{}	1675955410176	1675955410175	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7pwy6b4y9qtde9mayz9t576wzbo	2023-02-09 15:10:10.121663+00	czebhwzawapy55jy4qxmozzo4cr	1	checkbox		{"value":false}	1675955410178	1675955410178	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
axpbptk9grbrhzdq9rodcqgomra	2023-02-09 15:10:10.121663+00	czebhwzawapy55jy4qxmozzo4cr	1	text	## Notes\n*[Add meeting notes here]*	{}	1675955410181	1675955410181	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
ayarazd7asb8ozkksuxy5351aqh	2023-02-09 15:10:10.121663+00	czebhwzawapy55jy4qxmozzo4cr	1	text	## Action Items	{}	1675955410183	1675955410183	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7o4rz1o44gbf4zepkb4sqrmhwce	2023-02-09 15:10:10.121663+00	ch798q5ucefyobf5bymgqjt4f3h	1	divider		{}	1675955410188	1675955410187	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7pyuztkwto3b6irhdu7jcusoeqh	2023-02-09 15:10:10.121663+00	ch798q5ucefyobf5bymgqjt4f3h	1	checkbox		{"value":false}	1675955410196	1675955410196	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7f1qymriaetf8fyqb6b88hn6syy	2023-02-09 15:10:10.121663+00	ch798q5ucefyobf5bymgqjt4f3h	1	checkbox		{"value":false}	1675955410211	1675955410211	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
74g7zukwfhjgcfpugf4hxqcostc	2023-02-09 15:10:10.121663+00	ch798q5ucefyobf5bymgqjt4f3h	1	checkbox		{"value":false}	1675955410221	1675955410221	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
a5gpne7xtsjr37d8xxgu93bpyay	2023-02-09 15:10:10.121663+00	ch798q5ucefyobf5bymgqjt4f3h	1	text	# Action Items	{}	1675955410243	1675955410243	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
afoajfa1w4brjbq3wpmguh61w7w	2023-02-09 15:10:10.121663+00	ch798q5ucefyobf5bymgqjt4f3h	1	text	# Notes\n*[Add meeting notes here]*	{}	1675955410251	1675955410251	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7yd3axyrhzbyh3x9qozk5qtbsrh	2023-02-09 15:10:10.121663+00	caaryyfj35iyo9q7ukein9jiu4e	1	divider		{}	1675955410258	1675955410258	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7hhgoyez5etb7mpptkrdq75dghe	2023-02-09 15:10:10.121663+00	caaryyfj35iyo9q7ukein9jiu4e	1	checkbox		{"value":false}	1675955410264	1675955410264	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7eqriuxcf87dh9frg5aiuc1bp9r	2023-02-09 15:10:10.121663+00	caaryyfj35iyo9q7ukein9jiu4e	1	checkbox		{"value":false}	1675955410268	1675955410268	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
79u5d4yzqdjg65qgcpwbmob9fzo	2023-02-09 15:10:10.121663+00	caaryyfj35iyo9q7ukein9jiu4e	1	checkbox		{"value":false}	1675955410273	1675955410273	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
ai93zq6uonfrf7gjibrwatofmiy	2023-02-09 15:10:10.121663+00	caaryyfj35iyo9q7ukein9jiu4e	1	text	## Action Items	{}	1675955410277	1675955410277	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
aiwph7zdhpjbombd49uom6p5qxy	2023-02-09 15:10:10.121663+00	caaryyfj35iyo9q7ukein9jiu4e	1	text	## Notes\n*[Add meeting notes here]*	{}	1675955410283	1675955410283	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7hncbmdr4jpng3xb44yth4mmwma	2023-02-09 15:10:10.121663+00	ctor6xdeexffg8xzqd76prxk1ge	1	checkbox		{"value":false}	1675955410289	1675955410289	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7zcg6yc1dyjbwi8nys6916knsse	2023-02-09 15:10:10.121663+00	ctor6xdeexffg8xzqd76prxk1ge	1	checkbox		{"value":false}	1675955410297	1675955410296	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7wgktjf58itbeddwexf15wbg59a	2023-02-09 15:10:10.121663+00	ctor6xdeexffg8xzqd76prxk1ge	1	divider		{}	1675955410303	1675955410302	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
797gc7kuqubggbbth9tjb394r5c	2023-02-09 15:10:10.121663+00	ctor6xdeexffg8xzqd76prxk1ge	1	checkbox		{"value":false}	1675955410309	1675955410309	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
adc9tusigjj8rzqxbfo7s7uko6a	2023-02-09 15:10:10.121663+00	ctor6xdeexffg8xzqd76prxk1ge	1	text	## Action Items	{}	1675955410314	1675955410314	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
awjd7cdpaobfi7yofwb76szzdjw	2023-02-09 15:10:10.121663+00	ctor6xdeexffg8xzqd76prxk1ge	1	text	## Notes\n*[Add meeting notes here]*	{}	1675955410320	1675955410320	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7dqzit6ec5t8ubbnf5pzarpuuja	2023-02-09 15:10:10.121663+00	cbpyozo5n738dmq36auszr7twty	1	divider		{}	1675955410326	1675955410326	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7pbnkbqkjipb47cjxptp91ppz4c	2023-02-09 15:10:10.121663+00	cbpyozo5n738dmq36auszr7twty	1	checkbox		{"value":false}	1675955410331	1675955410331	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7bqzsshop3pg9mka4h1tspz8ity	2023-02-09 15:10:10.121663+00	cbpyozo5n738dmq36auszr7twty	1	checkbox		{"value":false}	1675955410339	1675955410339	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7xz74uk3bt3fu9y6spr7s69f8cc	2023-02-09 15:10:10.121663+00	cbpyozo5n738dmq36auszr7twty	1	checkbox		{"value":false}	1675955410359	1675955410359	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
aoudetcozh3yfmkqkq3cyhp9d8w	2023-02-09 15:10:10.121663+00	cbpyozo5n738dmq36auszr7twty	1	text	## Action Items	{}	1675955410371	1675955410371	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
a7nrc4e58m3ru5puz4wswn1trdc	2023-02-09 15:10:10.121663+00	cbpyozo5n738dmq36auszr7twty	1	text	## Notes\n*[Add meeting notes here]*	{}	1675955410400	1675955410400	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
vk8bc997m1bysubqa9zzpuikwmo	2023-02-09 15:10:10.921795+00		1	view	All Contacts	{"cardOrder":["c7n4qjbom77g5mxhapf6tmtcidw","cirqnetz9uf8ebpfrq68dx7sj1o","czb14t4y4gbf15ehgi9kpj6hyey","c71eyc8srz7gazgtp3hafyys1ba","c45s8knkw1jf79mfpkh4k1w39ko"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":240,"a1438fbbhjeffkexmcfhnx99o1h":151,"a5hwxjsmkn6bak6r7uea5bx1kwc":132,"abru6tz8uebdxy4skheqidh7zxy":247,"adtf1151chornmihz4xbgbk9exa":125,"aejo5tcmq54bauuueem9wc4fw4y":127,"ahf43e44h3y8ftanqgzno9z7q7w":129,"ainpw47babwkpyj77ic4b9zq9xr":157,"amahgyn9n4twaapg3jyxb6y4jic":224,"amba7ot98fh7hwsx8jdcfst5g7h":171,"aoheuj1f3mu6eehygr45fxa144y":130,"auhf91pm85f73swwidi4wid8jqe":157},"defaultTemplateId":"cxarr4qdxsi8u9jak7cc3yeikuh","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a5hwxjsmkn6bak6r7uea5bx1kwc","aoheuj1f3mu6eehygr45fxa144y","aro91wme9kfaie5ceu9qasmtcnw","ainpw47babwkpyj77ic4b9zq9xr","ahf43e44h3y8ftanqgzno9z7q7w","amahgyn9n4twaapg3jyxb6y4jic","abru6tz8uebdxy4skheqidh7zxy","a1438fbbhjeffkexmcfhnx99o1h","auhf91pm85f73swwidi4wid8jqe","adtf1151chornmihz4xbgbk9exa","aejo5tcmq54bauuueem9wc4fw4y","amba7ot98fh7hwsx8jdcfst5g7h"]}	1675955410931	1675955410931	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
vcaht3fzu1p8czftchjwej9zdbh	2023-02-09 15:10:10.921795+00		1	view	Pipeline Tracker	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["akj61wc9yxdwyw3t6m8igyf9d5o","aic89a5xox4wbppi6mbyx6ujsda","ah6ehh43rwj88jy4awensin8pcw","aprhd96zwi34o9cs4xyr3o9sf3c","axesd74yuxtbmw1sbk8ufax7z3a","a5txuiubumsmrs8gsd5jz5gc1oa","acm9q494bcthyoqzmfogxxy5czy"],"visiblePropertyIds":["aro91wme9kfaie5ceu9qasmtcnw","amahgyn9n4twaapg3jyxb6y4jic"]}	1675955410934	1675955410934	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
c71eyc8srz7gazgtp3hafyys1ba	2023-02-09 15:10:10.921795+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Jonathan Frazier	{"contentOrder":["akf5xjt9byinzfkeos6r6px8jbw","askua4mi95jy8bchwhybg8gfcse","7zu87byt3etrfjj4if6i7o9f5zw","7kwnrbo5c43gfjnpdoygghmfz5y","7n61tdes8updx7dgk4g1qmkqbnh","7iy8rn8s9ubdhxb9w43e5fmhuwh","7gx593y1kpif75xkrho74839yne","7kx16rigxffr9bezsar6dxammny","7uwrwbb9sa38j8d95d4ww8mypdw","7afgp343sijrc7gonf9qoy7556y","71gqjf96497fi9ryke93twwe7xh","77iiwbg3iufbkjp39xbytusm7fy"],"icon":"🙎‍♂️","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(999) 123-5678","a5hwxjsmkn6bak6r7uea5bx1kwc":"a5txuiubumsmrs8gsd5jz5gc1oa","abru6tz8uebdxy4skheqidh7zxy":"jonathan.frazier@email.com","aejo5tcmq54bauuueem9wc4fw4y":"0%","ahf43e44h3y8ftanqgzno9z7q7w":"$800,000","ainpw47babwkpyj77ic4b9zq9xr":"Ositions Inc.","amahgyn9n4twaapg3jyxb6y4jic":"as5bk6afoaaa7caewe1zc391sce","aro91wme9kfaie5ceu9qasmtcnw":"apiswzj7uiwbh87z8dw8c6mturw","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1669118400000}"}}	1675955410936	1675955410936	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
czb14t4y4gbf15ehgi9kpj6hyey	2023-02-09 15:10:10.921795+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Richard Guzman	{"contentOrder":["afdi9nuij83bz9ywhkjsyorsika","ap8htxxgcnpgaxka4s11df59y5c","7cwxpmkp8d3y78e5t4t8aizh9ac","7f6prgh7etidefktxjadakro7de","79by87rm9i3ngfk95wxr4hcu8mw","7p31k115qpbyo5fefdqbwceunfo","7dizabc4pu78y8kknah8pckrpgw","7e8a3i33n8jnujrhb9im4u3f3bc","7pobi5s6iq3dhbktgrootac1h4h","73wnuh3ums7grtb58as6qdu1s7r","7czs3x5g5o7godjj9nwpmnc6dye","76fuqbbtu8pywjqqj1hgg4q9e8e"],"icon":"👨‍💼","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(222) 123-1234","a5hwxjsmkn6bak6r7uea5bx1kwc":"axesd74yuxtbmw1sbk8ufax7z3a","abru6tz8uebdxy4skheqidh7zxy":"richard.guzman@email.com","adtf1151chornmihz4xbgbk9exa":"{\\"from\\":1681992000000}","aejo5tcmq54bauuueem9wc4fw4y":"80%","ahf43e44h3y8ftanqgzno9z7q7w":"$3,200,000","ainpw47babwkpyj77ic4b9zq9xr":"Afformance Ltd.","amahgyn9n4twaapg3jyxb6y4jic":"ar6t1ttcumgfuqugg5o4g4mzrza","aro91wme9kfaie5ceu9qasmtcnw":"apjnaggwixchfxwiatfh7ey7uno","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1667476800000}"}}	1675955410940	1675955410940	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
c45s8knkw1jf79mfpkh4k1w39ko	2023-02-09 15:10:10.921795+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Byron Cole	{"contentOrder":["atyt9edm39tbtbnjddx5rt8mmda","a98wh64rrxtyumdfmo5dim8wikr","7pa48ejem6p8stdqhbbicqjj7cy","714ghubqyrpgd7nw34mh31ug79c","7i9im8g6b17nizpis19mmnn9ckh","78wczgiecq7dkjbau9r54izny9w","7n4b867c94tyymfg16gwoqj94fe","7fymoo4ywy3yg5gyh91ijm1tmuw","77p9joh3ajpg1tr6b385zidjbge","7164ftmhpnfdwu8gy3icogzpa8o","7w4tgym95obnjp8smfskq9iypcc","7bwix7j583irsdmre8a3ttqy31e"],"icon":"🤵","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(333) 123-1234","a5hwxjsmkn6bak6r7uea5bx1kwc":"acm9q494bcthyoqzmfogxxy5czy","abru6tz8uebdxy4skheqidh7zxy":"byron.cole@email.com","adtf1151chornmihz4xbgbk9exa":"{\\"from\\":1667563200000}","aejo5tcmq54bauuueem9wc4fw4y":"100%","ahf43e44h3y8ftanqgzno9z7q7w":"$500,000","ainpw47babwkpyj77ic4b9zq9xr":"Helx Industries","amahgyn9n4twaapg3jyxb6y4jic":"aafwyza5iwdcwcyfyj6bp7emufw","aro91wme9kfaie5ceu9qasmtcnw":"apjnaggwixchfxwiatfh7ey7uno","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1667822400000}"}}	1675955410943	1675955410943	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7czs3x5g5o7godjj9nwpmnc6dye	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Hand-off to customer success	{}	1675955411012	1675955411012	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
73wnuh3ums7grtb58as6qdu1s7r	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Finalize contract	{}	1675955411015	1675955411015	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
76fuqbbtu8pywjqqj1hgg4q9e8e	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Post-sales follow up	{}	1675955411019	1675955411019	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
cirqnetz9uf8ebpfrq68dx7sj1o	2023-02-09 15:10:10.921795+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Caitlyn Russel	{"contentOrder":["auxx7ta8sktnsjmafar4n4ox7uh","auyp7cdhmbpyymefooaxte184nh","7ia67tegp7f8obj4yxtaa8d9whc","768tmcyaxypyrimxhbpqw5i1fpr","765g3gs41epfp9jrm6pm3o9ym3a","7qdcudfpn53b5i8mpe73odd8nwr","71sd6tycbyj8gjrxp1iin7pa7zr","7xgfqfh9fdffcpmg91rdj6d1tea","7kzfgicen5j8d7rwhzbq6o4cedr","7pur5woxchiymbppotiqc3epu8e","7pft7f9sj4jd3upimxkh7x8w87h","7qbk31ej6jjyrjjsqyeu9fmturc"],"icon":"🧑‍💼","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(111) 123-1234","a5hwxjsmkn6bak6r7uea5bx1kwc":"ah6ehh43rwj88jy4awensin8pcw","abru6tz8uebdxy4skheqidh7zxy":"caitlyn.russel@email.com","adtf1151chornmihz4xbgbk9exa":"{\\"from\\":1689336000000}","aejo5tcmq54bauuueem9wc4fw4y":"20%","ahf43e44h3y8ftanqgzno9z7q7w":"$250,000","ainpw47babwkpyj77ic4b9zq9xr":"Liminary Corp.","amahgyn9n4twaapg3jyxb6y4jic":"aafwyza5iwdcwcyfyj6bp7emufw","aro91wme9kfaie5ceu9qasmtcnw":"apiswzj7uiwbh87z8dw8c6mturw","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1668168000000}"}}	1675955410949	1675955410948	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
cxarr4qdxsi8u9jak7cc3yeikuh	2023-02-09 15:10:10.921795+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	New Prospect	{"contentOrder":["ahae77tk763dpmmeijk8nwjociw","awdkgnnej7tnb5yweq4psgm8smc","7axxtz7491tbzddsddkhr1okagw","79gysbkm967djicna43f88r9wpe","71prjd7h1ofy1tbfmwbcyjxkunw","7p4tj6cwryjnbjqu6dp5zbia8rr","7wu3q67edhi8ebgmjzjfiwsahyo","71q3bar1wm7y9tc51rd8j7fymor","779frbxrdd7gb7e1g1u1wcweqnc","7s7keem8eetrm5yguee6e48agee","7yipg3d9mtigbdq8z5h7r3f3wgy","7jyt49rqrwbf5udj38tqu4ea37a"],"icon":"👤","isTemplate":true,"properties":{"a5hwxjsmkn6bak6r7uea5bx1kwc":"akj61wc9yxdwyw3t6m8igyf9d5o"}}	1675955410953	1675955410953	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
c7n4qjbom77g5mxhapf6tmtcidw	2023-02-09 15:10:10.921795+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Shelby Olson	{"contentOrder":["anbyeqt5wz3dkxq6kckxwn79xxr","aw1x1hw8aefd37joninhxtwxxka","7ojg7aiidaprm5q7y54ng8xa97r","7issp85h1mpn7pjo969iynpzike","73x54ue6mzbrj38t5mbkyfds7xc","7ddxcwbw3bpyk3nbyupp9s767pa","7w5z546c5u3d15n1fferi4y3sne","7bdmxk7xcrpryibc4g5srw41qqr","738c4jz9iytfmmjc43f8ma8bn1y","73x4mgnyqrff6jjmdmpwrc3r69a","76zfm97dmgjywuj7ukop3y918no","7xcdyhrcxqfn1byi14nkcfzoyor"],"icon":"🙎‍♀️","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(111) 321-5678","a5hwxjsmkn6bak6r7uea5bx1kwc":"akj61wc9yxdwyw3t6m8igyf9d5o","abru6tz8uebdxy4skheqidh7zxy":"shelby.olson@email.com","ahf43e44h3y8ftanqgzno9z7q7w":"$30,000","ainpw47babwkpyj77ic4b9zq9xr":"Kadera Global","amahgyn9n4twaapg3jyxb6y4jic":"ar6t1ttcumgfuqugg5o4g4mzrza","aro91wme9kfaie5ceu9qasmtcnw":"auu9bfzqeuruyjwzzqgz7q8apuw","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1669291200000}"}}	1675955410961	1675955410961	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
vpzrdpq8ugp88ipudigtx7kksch	2023-02-09 15:10:10.921795+00	bzwb99zf498tsm7mjqbiy7g81ze	1	view	Open Deals	{"cardOrder":["cirqnetz9uf8ebpfrq68dx7sj1o"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[{"condition":"includes","propertyId":"a5hwxjsmkn6bak6r7uea5bx1kwc","values":["akj61wc9yxdwyw3t6m8igyf9d5o","aic89a5xox4wbppi6mbyx6ujsda","ah6ehh43rwj88jy4awensin8pcw","aprhd96zwi34o9cs4xyr3o9sf3c","axesd74yuxtbmw1sbk8ufax7z3a"]}],"operation":"and"},"groupById":"aro91wme9kfaie5ceu9qasmtcnw","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["apjnaggwixchfxwiatfh7ey7uno","apiswzj7uiwbh87z8dw8c6mturw","auu9bfzqeuruyjwzzqgz7q8apuw",""],"visiblePropertyIds":[]}	1675955410964	1675955410964	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7zu87byt3etrfjj4if6i7o9f5zw	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Send initial email	{"value":true}	1675955410969	1675955410969	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7kwnrbo5c43gfjnpdoygghmfz5y	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Send follow-up email	{"value":true}	1675955410972	1675955410972	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7uwrwbb9sa38j8d95d4ww8mypdw	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Send proposal	{"value":true}	1675955410975	1675955410975	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7afgp343sijrc7gonf9qoy7556y	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Finalize contract	{}	1675955410978	1675955410978	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7n61tdes8updx7dgk4g1qmkqbnh	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Schedule initial sales call	{"value":true}	1675955410980	1675955410980	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7gx593y1kpif75xkrho74839yne	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Schedule demo	{"value":true}	1675955410982	1675955410982	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
71gqjf96497fi9ryke93twwe7xh	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Hand-off to customer success	{}	1675955410985	1675955410985	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7kx16rigxffr9bezsar6dxammny	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Follow up after demo	{"value":true}	1675955410987	1675955410987	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7iy8rn8s9ubdhxb9w43e5fmhuwh	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Schedule follow-up sales call	{"value":true}	1675955410990	1675955410990	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
77iiwbg3iufbkjp39xbytusm7fy	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Post-sales follow up	{}	1675955410993	1675955410993	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
askua4mi95jy8bchwhybg8gfcse	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	text	## Checklist	{}	1675955410996	1675955410996	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
akf5xjt9byinzfkeos6r6px8jbw	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1675955410999	1675955410999	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7cwxpmkp8d3y78e5t4t8aizh9ac	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Send initial email	{"value":true}	1675955411002	1675955411002	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7p31k115qpbyo5fefdqbwceunfo	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Schedule follow-up sales call	{"value":true}	1675955411004	1675955411004	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7e8a3i33n8jnujrhb9im4u3f3bc	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Follow up after demo	{"value":true}	1675955411007	1675955411007	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7pobi5s6iq3dhbktgrootac1h4h	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Send proposal	{"value":true}	1675955411009	1675955411009	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7dizabc4pu78y8kknah8pckrpgw	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Schedule demo	{"value":true}	1675955411023	1675955411023	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
79by87rm9i3ngfk95wxr4hcu8mw	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Schedule initial sales call	{"value":true}	1675955411027	1675955411027	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7f6prgh7etidefktxjadakro7de	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Send follow-up email	{"value":true}	1675955411030	1675955411030	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
afdi9nuij83bz9ywhkjsyorsika	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1675955411032	1675955411032	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
ap8htxxgcnpgaxka4s11df59y5c	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	text	## Checklist	{}	1675955411035	1675955411035	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7fymoo4ywy3yg5gyh91ijm1tmuw	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Follow up after demo	{"value":true}	1675955411038	1675955411038	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7pa48ejem6p8stdqhbbicqjj7cy	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Send initial email	{"value":true}	1675955411041	1675955411041	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
714ghubqyrpgd7nw34mh31ug79c	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Send follow-up email	{"value":true}	1675955411043	1675955411043	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
77p9joh3ajpg1tr6b385zidjbge	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Send proposal	{"value":true}	1675955411046	1675955411046	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7164ftmhpnfdwu8gy3icogzpa8o	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Finalize contract	{"value":true}	1675955411049	1675955411049	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
78wczgiecq7dkjbau9r54izny9w	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Schedule follow-up sales call	{"value":true}	1675955411054	1675955411054	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7i9im8g6b17nizpis19mmnn9ckh	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Schedule initial sales call	{"value":true}	1675955411062	1675955411062	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7n4b867c94tyymfg16gwoqj94fe	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Schedule demo	{"value":true}	1675955411077	1675955411077	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7w4tgym95obnjp8smfskq9iypcc	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Hand-off to customer success	{"value":true}	1675955411088	1675955411088	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7bwix7j583irsdmre8a3ttqy31e	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Post-sales follow up	{"value":true}	1675955411093	1675955411093	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
a98wh64rrxtyumdfmo5dim8wikr	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	text	## Checklist	{}	1675955411098	1675955411098	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
atyt9edm39tbtbnjddx5rt8mmda	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1675955411104	1675955411104	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7qbk31ej6jjyrjjsqyeu9fmturc	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Post-sales follow up	{}	1675955411116	1675955411116	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7kzfgicen5j8d7rwhzbq6o4cedr	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Send proposal	{}	1675955411121	1675955411121	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7pft7f9sj4jd3upimxkh7x8w87h	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Hand-off to customer success	{}	1675955411130	1675955411130	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7xgfqfh9fdffcpmg91rdj6d1tea	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Follow up after demo	{}	1675955411136	1675955411136	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
71sd6tycbyj8gjrxp1iin7pa7zr	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Schedule demo	{"value":true}	1675955411141	1675955411141	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7ia67tegp7f8obj4yxtaa8d9whc	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Send initial email	{"value":true}	1675955411144	1675955411144	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7qdcudfpn53b5i8mpe73odd8nwr	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Schedule follow-up sales call	{"value":true}	1675955411148	1675955411148	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
768tmcyaxypyrimxhbpqw5i1fpr	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Send follow-up email	{"value":true}	1675955411154	1675955411153	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
765g3gs41epfp9jrm6pm3o9ym3a	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Schedule initial sales call	{"value":true}	1675955411160	1675955411160	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7pur5woxchiymbppotiqc3epu8e	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Finalize contract	{}	1675955411166	1675955411166	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
auyp7cdhmbpyymefooaxte184nh	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	text	## Checklist	{}	1675955411172	1675955411172	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
auxx7ta8sktnsjmafar4n4ox7uh	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1675955411178	1675955411178	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7axxtz7491tbzddsddkhr1okagw	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Send initial email	{"value":false}	1675955411184	1675955411184	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
71prjd7h1ofy1tbfmwbcyjxkunw	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Schedule initial sales call	{"value":false}	1675955411190	1675955411190	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7p4tj6cwryjnbjqu6dp5zbia8rr	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Schedule follow-up sales call	{"value":false}	1675955411196	1675955411196	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
779frbxrdd7gb7e1g1u1wcweqnc	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Send proposal	{}	1675955411202	1675955411202	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7s7keem8eetrm5yguee6e48agee	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Finalize contract	{}	1675955411208	1675955411208	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7jyt49rqrwbf5udj38tqu4ea37a	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Post-sales follow up	{}	1675955411213	1675955411213	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
79gysbkm967djicna43f88r9wpe	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Send follow-up email	{"value":false}	1675955411219	1675955411219	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7wu3q67edhi8ebgmjzjfiwsahyo	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Schedule demo	{"value":false}	1675955411224	1675955411224	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7yipg3d9mtigbdq8z5h7r3f3wgy	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Hand-off to customer success	{}	1675955411230	1675955411230	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
71q3bar1wm7y9tc51rd8j7fymor	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Follow up after demo	{}	1675955411241	1675955411241	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
ahae77tk763dpmmeijk8nwjociw	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	text	## Notes\n[Enter notes here...]	{}	1675955411252	1675955411251	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
awdkgnnej7tnb5yweq4psgm8smc	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	text	## Checklist	{}	1675955411261	1675955411261	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7kfpfh7omc7f4bpgcpq5u3axgue	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Hand-off to customer success	{}	1675955411268	1675955411268	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
756nnjpzjwpntbe66myqiuw3qda	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Send initial email	{"value":false}	1675955411275	1675955411275	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
76rekmo79d78qtxh39scmb1kx5y	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Post-sales follow up	{}	1675955411281	1675955411281	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7imo387hkz3yrzrs9it7krmgjda	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Finalize contract	{}	1675955411288	1675955411288	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7k5f3rk8c6iyxzrcktu4wr3fwda	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Send follow-up email	{"value":false}	1675955411293	1675955411293	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
71bhibupqmbntbxg6dt8snc6asc	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Schedule follow-up sales call	{"value":false}	1675955411297	1675955411297	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7mb4ytzwbwidq7czurerc6o1swc	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Send proposal	{}	1675955411302	1675955411302	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7h5pc91n56p8yfmgp74rsqy78ro	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Follow up after demo	{}	1675955411310	1675955411310	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
78kwigroocfyn5pf41nhoupwoda	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Schedule initial sales call	{"value":false}	1675955411319	1675955411319	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
77predkxwjjgf7d6dtcjaooxr3e	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Schedule demo	{"value":false}	1675955411332	1675955411332	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
a65asssmsbjdh3giat9xzqoqdco	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	text	## Checklist	{}	1675955411338	1675955411338	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
a4zbibzhm1irk8pkx4xqmp4dpqc	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	text	## Notes\n[Enter notes here...]	{}	1675955411344	1675955411344	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
738c4jz9iytfmmjc43f8ma8bn1y	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Send proposal	{}	1675955411349	1675955411349	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7ojg7aiidaprm5q7y54ng8xa97r	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Send initial email	{"value":true}	1675955411355	1675955411355	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7bdmxk7xcrpryibc4g5srw41qqr	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Follow up after demo	{}	1675955411360	1675955411360	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
73x4mgnyqrff6jjmdmpwrc3r69a	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Finalize contract	{}	1675955411367	1675955411367	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7ddxcwbw3bpyk3nbyupp9s767pa	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Schedule follow-up sales call	{"value":false}	1675955411374	1675955411374	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7w5z546c5u3d15n1fferi4y3sne	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Schedule demo	{"value":false}	1675955411380	1675955411380	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
73x54ue6mzbrj38t5mbkyfds7xc	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Schedule initial sales call	{"value":false}	1675955411387	1675955411387	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7xcdyhrcxqfn1byi14nkcfzoyor	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Post-sales follow up	{}	1675955411394	1675955411394	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
76zfm97dmgjywuj7ukop3y918no	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Hand-off to customer success	{}	1675955411401	1675955411401	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7issp85h1mpn7pjo969iynpzike	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Send follow-up email	{"value":false}	1675955411408	1675955411408	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
aw1x1hw8aefd37joninhxtwxxka	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	text	## Checklist	{}	1675955411416	1675955411415	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7p3whtqf9cpnbuygpkfsutwheoo	2023-02-09 15:10:12.994972+00	cz4wzottsq3dpubozjfty9o4ciw	1	checkbox	[Subtask 3]	{"value":false}	1675955413115	1675955413115	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
anbyeqt5wz3dkxq6kckxwn79xxr	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1675955411433	1675955411433	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
ccq3ukx8c8bgo9x49g8q851froe	2023-02-09 15:10:12.186101+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Pay bills	{"contentOrder":["7kx1socx6mjgwxksy1nmnu8hbky","7mazt3mp5yfbdfkgh7iy4upqccy","7bh94nigoqtgyjgdtk7xan14t4h"],"icon":"🔌","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"aj4jyekqqssatjcq7r7chmy19ey","abthng7baedhhtrwsdodeuincqy":"true"}}	1675955412199	1675955412199	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
cchc3zymfa3f5mktpoiqo4nbzsr	2023-02-09 15:10:12.186101+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Buy groceries	{"contentOrder":["a54rpf4qjypbpdkdnraatck173h","76x94fpy89brh8jsjip3eepyb6c","7oq6wa91e1jnqxfhnshadyqwana","7gui4597mfbyqmgbrenwcu4apja","7wi6nur6ysig43x8yntx1atf13y","7zmwfuc7jqiysupcxdmncgdxqne","75wszyfkeptb4zr63z84e9koy3e"],"icon":"🛒","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"afpy8s7i45frggprmfsqngsocqh"}}	1675955412211	1675955412211	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
c4dc75947tjn5mem7kzzpgqnswh	2023-02-09 15:10:12.186101+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Go for a walk	{"contentOrder":["a8mj5x4thmtbi8jxh51jhq9u7iw","a8w7wz49bb78qxydiw5i398u7sy","7sbu99dbrabgj5bxyqe5c47ztqa"],"icon":"👣","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"an51dnkenmoog9cetapbc4uyt3y"}}	1675955412223	1675955412223	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
crq3aeiaa8frsmdbaox76xiapmc	2023-02-09 15:10:12.186101+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Feed Fluffy	{"contentOrder":["agr7xb7krnfyifg6yua5z86k4th"],"icon":"🐱","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"an51dnkenmoog9cetapbc4uyt3y"}}	1675955412232	1675955412231	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
cbby4rxqas3fxxpeso3quj6s1wy	2023-02-09 15:10:12.186101+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Gardening	{"contentOrder":[],"icon":"🌳","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"afpy8s7i45frggprmfsqngsocqh"}}	1675955412240	1675955412240	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
v9yh48g8pk3r6ico6sdomybkj5r	2023-02-09 15:10:12.186101+00	bbn1888mprfrm5fjw9f1je9x3xo	1	view	List View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":280},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a9zf59u8x1rf4ywctpcqama7tio","abthng7baedhhtrwsdodeuincqy"]}	1675955412247	1675955412247	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
vjy9kijzb53rqmdmszg5nii5nue	2023-02-09 15:10:12.186101+00	bbn1888mprfrm5fjw9f1je9x3xo	1	view	Board View	{"cardOrder":["cchc3zymfa3f5mktpoiqo4nbzsr","ccq3ukx8c8bgo9x49g8q851froe","c4dc75947tjn5mem7kzzpgqnswh","crq3aeiaa8frsmdbaox76xiapmc","czowhma7rnpgb3eczbqo3t7fijo"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a9zf59u8x1rf4ywctpcqama7tio","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["an51dnkenmoog9cetapbc4uyt3y","afpy8s7i45frggprmfsqngsocqh","aj4jyekqqssatjcq7r7chmy19ey",""],"visiblePropertyIds":["a9zf59u8x1rf4ywctpcqama7tio"]}	1675955412252	1675955412252	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7bh94nigoqtgyjgdtk7xan14t4h	2023-02-09 15:10:12.186101+00	ccq3ukx8c8bgo9x49g8q851froe	1	checkbox	Utilities	{"value":true}	1675955412257	1675955412257	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7kx1socx6mjgwxksy1nmnu8hbky	2023-02-09 15:10:12.186101+00	ccq3ukx8c8bgo9x49g8q851froe	1	checkbox	Mobile phone	{"value":true}	1675955412261	1675955412261	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7mazt3mp5yfbdfkgh7iy4upqccy	2023-02-09 15:10:12.186101+00	ccq3ukx8c8bgo9x49g8q851froe	1	checkbox	Internet	{"value":true}	1675955412266	1675955412266	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7zmwfuc7jqiysupcxdmncgdxqne	2023-02-09 15:10:12.186101+00	cchc3zymfa3f5mktpoiqo4nbzsr	1	checkbox	Cereal	{"value":false}	1675955412271	1675955412271	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7wi6nur6ysig43x8yntx1atf13y	2023-02-09 15:10:12.186101+00	cchc3zymfa3f5mktpoiqo4nbzsr	1	checkbox	Butter	{"value":false}	1675955412276	1675955412276	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7gui4597mfbyqmgbrenwcu4apja	2023-02-09 15:10:12.186101+00	cchc3zymfa3f5mktpoiqo4nbzsr	1	checkbox	Bread	{"value":false}	1675955412281	1675955412281	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
76x94fpy89brh8jsjip3eepyb6c	2023-02-09 15:10:12.186101+00	cchc3zymfa3f5mktpoiqo4nbzsr	1	checkbox	Milk	{"value":false}	1675955412285	1675955412285	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
75wszyfkeptb4zr63z84e9koy3e	2023-02-09 15:10:12.186101+00	cchc3zymfa3f5mktpoiqo4nbzsr	1	checkbox	Bananas	{"value":false}	1675955412291	1675955412291	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7oq6wa91e1jnqxfhnshadyqwana	2023-02-09 15:10:12.186101+00	cchc3zymfa3f5mktpoiqo4nbzsr	1	checkbox	Eggs	{"value":false}	1675955412296	1675955412296	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
a54rpf4qjypbpdkdnraatck173h	2023-02-09 15:10:12.186101+00	cchc3zymfa3f5mktpoiqo4nbzsr	1	text	## Grocery list	{}	1675955412300	1675955412300	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7sbu99dbrabgj5bxyqe5c47ztqa	2023-02-09 15:10:12.186101+00	c4dc75947tjn5mem7kzzpgqnswh	1	image		{"fileId":"76fwrj36hptg6dywka4k5mt3sph.png"}	1675955412306	1675955412306	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
a8mj5x4thmtbi8jxh51jhq9u7iw	2023-02-09 15:10:12.186101+00	c4dc75947tjn5mem7kzzpgqnswh	1	text	## Goal\nWalk at least 10,000 steps every day.	{}	1675955412310	1675955412310	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
a8w7wz49bb78qxydiw5i398u7sy	2023-02-09 15:10:12.186101+00	c4dc75947tjn5mem7kzzpgqnswh	1	text	## Route	{}	1675955412315	1675955412315	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
agr7xb7krnfyifg6yua5z86k4th	2023-02-09 15:10:12.186101+00	crq3aeiaa8frsmdbaox76xiapmc	1	text		{}	1675955412322	1675955412322	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
cz4wzottsq3dpubozjfty9o4ciw	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Identify dependencies	{"contentOrder":["aoun6pu8ahbgbdryiwihaf5g7kw","7kzqxyu34tbn4igsiaabt7yusnh","ak6b15yexfbdjbkbgb1qsb37bwo","71oe5g19kwtr65d43ydcfyaquma","7nqstxcxk97gfdq4kug4us1b6my","7p3whtqf9cpnbuygpkfsutwheoo","76z5c5whtetgo3frgooosey8kgw"],"icon":"🔗","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"16","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ayz81h9f3dwp7rzzbdebesc7ute","d3d682bf-e074-49d9-8df5-7320921c2d23":"98a57627-0f76-471d-850d-91f3ed9fd213"}}	1675955413003	1675955413003	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
c4mkyqpdicprz7mwj3hhnuw8ngc	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Define project scope	{"contentOrder":["a76yjexz653d9pn58r7wmfsf7pw","7b3bgpbw3pjgcibq8ghzdqhnqkc","ap7b19me84b8zzq6oknt89cwtxr","7uzdep7j5rbrnzrnugyojjqa43h","7ueynnzbbwp8xbk73848ipjaerr","7qwpifwt5hp87ukgmwusuqbtppa","7pe4oiok7zbdajbz9ryt57qksbo"],"icon":"🔬","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"32","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ar6b8m3jxr3asyxhr8iucdbo6yc","d3d682bf-e074-49d9-8df5-7320921c2d23":"87f59784-b859-4c24-8ebe-17c766e081dd"}}	1675955413009	1675955413009	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
cper74m1sojfhpgur1xhwynxfiy	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Requirements sign-off	{"contentOrder":["ae87wjndr9pnijcmi6hc5wb59re","7skzimbdzbpbq5kforgshzs61kw","ajut4tttrqbnmbp17wkag5omfxy","76sisungewinx7qgn6njki4ticy","7gfdcsb1poj8f5qp7r3h6pe4b1y","7pqf6oazaz3r3fcfdhe8f566prh","79qz9ycustfdhiqoejuc64jbjuy"],"icon":"🖋️","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"8","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ayz81h9f3dwp7rzzbdebesc7ute","d3d682bf-e074-49d9-8df5-7320921c2d23":"d3bfb50f-f569-4bad-8a3a-dd15c3f60101"}}	1675955413015	1675955413015	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
cd6qe9kcu8tny3qk1q166ieq7ca	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Project budget approval	{"contentOrder":["abdket889k3gqjgyapdtwdyrrma","7i5s3bpukbbri5fgi6fqj8hm8ya","aq35hqbaejb8iie6wit8itohs5c","7e1o55mq96py68xhxrpppfpdc5w","73zjyyew9dfbatkcgyp4zg77gmw","7d1eaa4nzcjd9jbo69mcoru8ape","7z54jn3njybgsbf8qtppxtz1zmo"],"icon":"💵","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"16","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ayz81h9f3dwp7rzzbdebesc7ute","d3d682bf-e074-49d9-8df5-7320921c2d23":"d3bfb50f-f569-4bad-8a3a-dd15c3f60101"}}	1675955413019	1675955413019	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
c1zftz5wzmiditnznpqken4saxc	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Conduct market analysis	{"contentOrder":["ae1mquzi61p8qufeuyb9tducnuy","74t5gy1zgujrtjrhiohjrobchqw","afisf71n8n3r49jcapjxbbj3qoh","7m3f5jyj7sjfbjmwxdp5oein9qr","7jy5wgugfjfy53ccqd67c35tchr","73f1jioomr3ryzrrp5h79ce3xde","7jy5gzxjmoiyb3kjxi6xfr4enyh"],"icon":"📈","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"40","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ar6b8m3jxr3asyxhr8iucdbo6yc","d3d682bf-e074-49d9-8df5-7320921c2d23":"87f59784-b859-4c24-8ebe-17c766e081dd"}}	1675955413027	1675955413027	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
vqikjy5xq5bynxrsw7z8jnwzr7c	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Project Priorities	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"d3d682bf-e074-49d9-8df5-7320921c2d23","hiddenOptionIds":[],"kanbanCalculations":{"":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"87f59784-b859-4c24-8ebe-17c766e081dd":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"98a57627-0f76-471d-850d-91f3ed9fd213":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"d3bfb50f-f569-4bad-8a3a-dd15c3f60101":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"}},"sortOptions":[],"viewType":"board","visibleOptionIds":["d3bfb50f-f569-4bad-8a3a-dd15c3f60101","87f59784-b859-4c24-8ebe-17c766e081dd","98a57627-0f76-471d-850d-91f3ed9fd213",""],"visiblePropertyIds":["a972dc7a-5f4c-45d2-8044-8c28c69717f1","a8daz81s4xjgke1ww6cwik5w7ye"]}	1675955413052	1675955413052	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
v1ihhkqej8brfbbthmm8j1b111c	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Progress Tracker	{"cardOrder":["cd6qe9kcu8tny3qk1q166ieq7ca","cper74m1sojfhpgur1xhwynxfiy","cz4wzottsq3dpubozjfty9o4ciw","c1zftz5wzmiditnznpqken4saxc","c4mkyqpdicprz7mwj3hhnuw8ngc","coxnjt3ro1in19dd1e3awdt338r"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a972dc7a-5f4c-45d2-8044-8c28c69717f1","hiddenOptionIds":[],"kanbanCalculations":{"":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"adeo5xuwne3qjue83fcozekz8ko":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"afi4o5nhnqc3smtzs1hs3ij34dh":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"ahpyxfnnrzynsw3im1psxpkgtpe":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"ar6b8m3jxr3asyxhr8iucdbo6yc":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"ayz81h9f3dwp7rzzbdebesc7ute":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"}},"sortOptions":[],"viewType":"board","visibleOptionIds":["ayz81h9f3dwp7rzzbdebesc7ute","ar6b8m3jxr3asyxhr8iucdbo6yc","afi4o5nhnqc3smtzs1hs3ij34dh","adeo5xuwne3qjue83fcozekz8ko","ahpyxfnnrzynsw3im1psxpkgtpe",""],"visiblePropertyIds":["d3d682bf-e074-49d9-8df5-7320921c2d23","a8daz81s4xjgke1ww6cwik5w7ye"]}	1675955413058	1675955413058	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
vsqznqhthm7dstpj4jxpeifppyw	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Task Overview	{"cardOrder":["c4mkyqpdicprz7mwj3hhnuw8ngc","c1zftz5wzmiditnznpqken4saxc","cz4wzottsq3dpubozjfty9o4ciw","cd6qe9kcu8tny3qk1q166ieq7ca","cper74m1sojfhpgur1xhwynxfiy","cz8p8gofakfby8kzz83j97db8ph","ce1jm5q5i54enhuu4h3kkay1hcc"],"collapsedOptionIds":[],"columnCalculations":{"a8daz81s4xjgke1ww6cwik5w7ye":"sum"},"columnWidths":{"2a5da320-735c-4093-8787-f56e15cdfeed":196,"__title":280,"a8daz81s4xjgke1ww6cwik5w7ye":139,"a972dc7a-5f4c-45d2-8044-8c28c69717f1":141,"d3d682bf-e074-49d9-8df5-7320921c2d23":110},"defaultTemplateId":"czw9es1e89fdpjr7cqptr1xq7qh","filter":{"filters":[],"operation":"and"},"groupById":"","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a972dc7a-5f4c-45d2-8044-8c28c69717f1","d3d682bf-e074-49d9-8df5-7320921c2d23","2a5da320-735c-4093-8787-f56e15cdfeed","a3zsw7xs8sxy7atj8b6totp3mby","axkhqa4jxr3jcqe4k87g8bhmary","a7gdnz8ff8iyuqmzddjgmgo9ery","a8daz81s4xjgke1ww6cwik5w7ye"]}	1675955413067	1675955413067	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
v8iq8y5gb6pd65n5iudaoegkc8a	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Task Calendar	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"a3zsw7xs8sxy7atj8b6totp3mby","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955413081	1675955413081	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
71oe5g19kwtr65d43ydcfyaquma	2023-02-09 15:10:12.994972+00	cz4wzottsq3dpubozjfty9o4ciw	1	checkbox	[Subtask 1]	{"value":false}	1675955413085	1675955413085	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7nqstxcxk97gfdq4kug4us1b6my	2023-02-09 15:10:12.994972+00	cz4wzottsq3dpubozjfty9o4ciw	1	checkbox	[Subtask 2]	{"value":false}	1675955413107	1675955413107	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7kzqxyu34tbn4igsiaabt7yusnh	2023-02-09 15:10:12.994972+00	cz4wzottsq3dpubozjfty9o4ciw	1	divider		{}	1675955413110	1675955413110	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
76z5c5whtetgo3frgooosey8kgw	2023-02-09 15:10:12.994972+00	cz4wzottsq3dpubozjfty9o4ciw	1	checkbox	...	{"value":false}	1675955413112	1675955413112	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
ak6b15yexfbdjbkbgb1qsb37bwo	2023-02-09 15:10:12.994972+00	cz4wzottsq3dpubozjfty9o4ciw	1	text	## Checklist	{}	1675955413117	1675955413117	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
aoun6pu8ahbgbdryiwihaf5g7kw	2023-02-09 15:10:12.994972+00	cz4wzottsq3dpubozjfty9o4ciw	1	text	## Description\n*[Brief description of this task]*	{}	1675955413120	1675955413120	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7ueynnzbbwp8xbk73848ipjaerr	2023-02-09 15:10:12.994972+00	c4mkyqpdicprz7mwj3hhnuw8ngc	1	checkbox	[Subtask 2]	{"value":false}	1675955413122	1675955413122	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7pe4oiok7zbdajbz9ryt57qksbo	2023-02-09 15:10:12.994972+00	c4mkyqpdicprz7mwj3hhnuw8ngc	1	checkbox	...	{"value":false}	1675955413134	1675955413134	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7uzdep7j5rbrnzrnugyojjqa43h	2023-02-09 15:10:12.994972+00	c4mkyqpdicprz7mwj3hhnuw8ngc	1	checkbox	[Subtask 1]	{"value":false}	1675955413141	1675955413141	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7qwpifwt5hp87ukgmwusuqbtppa	2023-02-09 15:10:12.994972+00	c4mkyqpdicprz7mwj3hhnuw8ngc	1	checkbox	[Subtask 3]	{"value":false}	1675955413162	1675955413162	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7b3bgpbw3pjgcibq8ghzdqhnqkc	2023-02-09 15:10:12.994972+00	c4mkyqpdicprz7mwj3hhnuw8ngc	1	divider		{}	1675955413188	1675955413188	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
ap7b19me84b8zzq6oknt89cwtxr	2023-02-09 15:10:12.994972+00	c4mkyqpdicprz7mwj3hhnuw8ngc	1	text	## Checklist	{}	1675955413203	1675955413203	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
a76yjexz653d9pn58r7wmfsf7pw	2023-02-09 15:10:12.994972+00	c4mkyqpdicprz7mwj3hhnuw8ngc	1	text	## Description\n*[Brief description of this task]*	{}	1675955413234	1675955413234	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
79qz9ycustfdhiqoejuc64jbjuy	2023-02-09 15:10:12.994972+00	cper74m1sojfhpgur1xhwynxfiy	1	checkbox	...	{"value":false}	1675955413238	1675955413238	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7gfdcsb1poj8f5qp7r3h6pe4b1y	2023-02-09 15:10:12.994972+00	cper74m1sojfhpgur1xhwynxfiy	1	checkbox	[Subtask 2]	{"value":false}	1675955413243	1675955413243	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7skzimbdzbpbq5kforgshzs61kw	2023-02-09 15:10:12.994972+00	cper74m1sojfhpgur1xhwynxfiy	1	divider		{}	1675955413247	1675955413247	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7pqf6oazaz3r3fcfdhe8f566prh	2023-02-09 15:10:12.994972+00	cper74m1sojfhpgur1xhwynxfiy	1	checkbox	[Subtask 3]	{"value":false}	1675955413258	1675955413258	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
76sisungewinx7qgn6njki4ticy	2023-02-09 15:10:12.994972+00	cper74m1sojfhpgur1xhwynxfiy	1	checkbox	[Subtask 1]	{"value":false}	1675955413263	1675955413263	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
ae87wjndr9pnijcmi6hc5wb59re	2023-02-09 15:10:12.994972+00	cper74m1sojfhpgur1xhwynxfiy	1	text	## Description\n*[Brief description of this task]*	{}	1675955413268	1675955413268	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
ajut4tttrqbnmbp17wkag5omfxy	2023-02-09 15:10:12.994972+00	cper74m1sojfhpgur1xhwynxfiy	1	text	## Checklist	{}	1675955413273	1675955413273	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7i5s3bpukbbri5fgi6fqj8hm8ya	2023-02-09 15:10:12.994972+00	cd6qe9kcu8tny3qk1q166ieq7ca	1	divider		{}	1675955413279	1675955413279	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7e1o55mq96py68xhxrpppfpdc5w	2023-02-09 15:10:12.994972+00	cd6qe9kcu8tny3qk1q166ieq7ca	1	checkbox	[Subtask 1]	{"value":false}	1675955413285	1675955413285	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7d1eaa4nzcjd9jbo69mcoru8ape	2023-02-09 15:10:12.994972+00	cd6qe9kcu8tny3qk1q166ieq7ca	1	checkbox	[Subtask 3]	{"value":false}	1675955413291	1675955413291	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7z54jn3njybgsbf8qtppxtz1zmo	2023-02-09 15:10:12.994972+00	cd6qe9kcu8tny3qk1q166ieq7ca	1	checkbox	...	{"value":false}	1675955413295	1675955413295	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
73zjyyew9dfbatkcgyp4zg77gmw	2023-02-09 15:10:12.994972+00	cd6qe9kcu8tny3qk1q166ieq7ca	1	checkbox	[Subtask 2]	{"value":false}	1675955413304	1675955413304	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
aq35hqbaejb8iie6wit8itohs5c	2023-02-09 15:10:12.994972+00	cd6qe9kcu8tny3qk1q166ieq7ca	1	text	## Checklist	{}	1675955413318	1675955413318	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
abdket889k3gqjgyapdtwdyrrma	2023-02-09 15:10:12.994972+00	cd6qe9kcu8tny3qk1q166ieq7ca	1	text	## Description\n*[Brief description of this task]*	{}	1675955413333	1675955413333	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7jy5gzxjmoiyb3kjxi6xfr4enyh	2023-02-09 15:10:12.994972+00	c1zftz5wzmiditnznpqken4saxc	1	checkbox	...	{"value":false}	1675955413338	1675955413338	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
73f1jioomr3ryzrrp5h79ce3xde	2023-02-09 15:10:12.994972+00	c1zftz5wzmiditnznpqken4saxc	1	checkbox	[Subtask 3]	{"value":false}	1675955413343	1675955413343	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
74t5gy1zgujrtjrhiohjrobchqw	2023-02-09 15:10:12.994972+00	c1zftz5wzmiditnznpqken4saxc	1	divider		{}	1675955413359	1675955413359	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7jy5wgugfjfy53ccqd67c35tchr	2023-02-09 15:10:12.994972+00	c1zftz5wzmiditnznpqken4saxc	1	checkbox	[Subtask 2]	{"value":false}	1675955413363	1675955413363	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7m3f5jyj7sjfbjmwxdp5oein9qr	2023-02-09 15:10:12.994972+00	c1zftz5wzmiditnznpqken4saxc	1	checkbox	[Subtask 1]	{"value":false}	1675955413369	1675955413369	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
ae1mquzi61p8qufeuyb9tducnuy	2023-02-09 15:10:12.994972+00	c1zftz5wzmiditnznpqken4saxc	1	text	## Description\n*[Brief description of this task]*	{}	1675955413377	1675955413377	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
afisf71n8n3r49jcapjxbbj3qoh	2023-02-09 15:10:12.994972+00	c1zftz5wzmiditnznpqken4saxc	1	text	## Checklist	{}	1675955413405	1675955413405	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
76azhipbobfygfynia6zacn9w3o	2023-02-09 15:10:12.994972+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	[Subtask 3]	{"value":false}	1675955413408	1675955413408	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7mb6ctqe7pfrtbedqcco1cubphw	2023-02-09 15:10:12.994972+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	[Subtask 2]	{"value":false}	1675955413413	1675955413413	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7jditmempbfbwjf5qcqsen8jrjr	2023-02-09 15:10:12.994972+00	czw9es1e89fdpjr7cqptr1xq7qh	1	divider		{}	1675955413418	1675955413418	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
785gjigqkdif5jf3eu11aubu45h	2023-02-09 15:10:12.994972+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	[Subtask 1]	{"value":false}	1675955413423	1675955413423	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7e5qw6opfzpnxxdzuow1futiuch	2023-02-09 15:10:12.994972+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	...	{"value":false}	1675955413441	1675955413441	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
acqyxd35m8jgmice6s8zu7r5p3w	2023-02-09 15:10:12.994972+00	czw9es1e89fdpjr7cqptr1xq7qh	1	text	## Description\n*[Brief description of this task]*	{}	1675955413455	1675955413455	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
abcywf8z4midn9mt3qcmufk8tmr	2023-02-09 15:10:12.994972+00	czw9es1e89fdpjr7cqptr1xq7qh	1	text	## Checklist	{}	1675955413461	1675955413461	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
vz8mbztwmdtyddeqoecmudbhf4y	2023-02-09 15:10:14.174793+00		1	view	By Quarter	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":452,"a17ryhi1jfsboxkwkztwawhmsxe":148,"a6amddgmrzakw66cidqzgk6p4ge":230,"azzbawji5bksj69sekcs4srm1ky":142},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"aqxyzkdrs4egqf7yk866ixkaojc","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a6amddgmrzakw66cidqzgk6p4ge","a17ryhi1jfsboxkwkztwawhmsxe","azzbawji5bksj69sekcs4srm1ky","adp5ft3kgz7r5iqq3tnwg551der","aqxyzkdrs4egqf7yk866ixkaojc","adu6mebzpibq6mgcswk69xxmnqe","asope3bddhm4gpsng5cfu4hf6rh","ajwxp866f9obs1kutfwaa5ru7fe","azqnyswk6s1boiwuthscm78qwuo","ahz3fmjnaguec8hce7xq3h5cjdr","a17bfcgnzmkwhziwa4tr38kiw5r"]}	1675955414182	1675955414182	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
vzs4utd66mig95xj9aon575y7mo	2023-02-09 15:10:14.174793+00		1	view	By Objectives	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":387,"a17ryhi1jfsboxkwkztwawhmsxe":134,"a6amddgmrzakw66cidqzgk6p4ge":183,"aqxyzkdrs4egqf7yk866ixkaojc":100},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a6amddgmrzakw66cidqzgk6p4ge","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a6amddgmrzakw66cidqzgk6p4ge","a17ryhi1jfsboxkwkztwawhmsxe","azzbawji5bksj69sekcs4srm1ky","adp5ft3kgz7r5iqq3tnwg551der","aqxyzkdrs4egqf7yk866ixkaojc","adu6mebzpibq6mgcswk69xxmnqe","asope3bddhm4gpsng5cfu4hf6rh","ajwxp866f9obs1kutfwaa5ru7fe","azqnyswk6s1boiwuthscm78qwuo","ahz3fmjnaguec8hce7xq3h5cjdr","a17bfcgnzmkwhziwa4tr38kiw5r"]}	1675955414186	1675955414185	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
ch8r4zp93di899kf58zrexgx8do	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Improve customer NPS score	{"contentOrder":[],"icon":"💯","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a8nukezwwmknqwjsygg7eaxs9te","a6amddgmrzakw66cidqzgk6p4ge":"apqfjst8massbjjhpcsjs3y1yqa","adp5ft3kgz7r5iqq3tnwg551der":"as555ipyzopjjpfb5rjtssecw5e","ahz3fmjnaguec8hce7xq3h5cjdr":"82%","ajwxp866f9obs1kutfwaa5ru7fe":"8.5","aqxyzkdrs4egqf7yk866ixkaojc":"anruuoyez51r3yjxuoc8zoqnwaw","azqnyswk6s1boiwuthscm78qwuo":"7","azzbawji5bksj69sekcs4srm1ky":"agm9p6gcq15ueuzqq3wd4be39wy"}}	1675955414192	1675955414192	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
ckiw38hhaz7dz9j817znsydproy	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Generate more Marketing Qualified Leads (MQLs)	{"contentOrder":[],"icon":"🛣️","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a8nukezwwmknqwjsygg7eaxs9te","a6amddgmrzakw66cidqzgk6p4ge":"auw3afh3kfhrfgmjr8muiz137jy","adp5ft3kgz7r5iqq3tnwg551der":"as555ipyzopjjpfb5rjtssecw5e","ahz3fmjnaguec8hce7xq3h5cjdr":"65%","ajwxp866f9obs1kutfwaa5ru7fe":"100","aqxyzkdrs4egqf7yk866ixkaojc":"ahfbn1jsmhydym33ygxwg5jt3kh","azqnyswk6s1boiwuthscm78qwuo":"65","azzbawji5bksj69sekcs4srm1ky":"aehoa17cz18rqnrf75g7dwhphpr"}}	1675955414198	1675955414198	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
cfn4r8fnn37ysfe69imeisb9n7r	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Increase customer retention	{"contentOrder":[],"icon":"😀","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a8nukezwwmknqwjsygg7eaxs9te","a6amddgmrzakw66cidqzgk6p4ge":"apqfjst8massbjjhpcsjs3y1yqa","adp5ft3kgz7r5iqq3tnwg551der":"a8zg3rjtf4swh7smsjxpsn743rh","ahz3fmjnaguec8hce7xq3h5cjdr":"66%","ajwxp866f9obs1kutfwaa5ru7fe":"90% customer retention rate","aqxyzkdrs4egqf7yk866ixkaojc":"acb6dqqs6yson7bbzx6jk9bghjh","azqnyswk6s1boiwuthscm78qwuo":"60%","azzbawji5bksj69sekcs4srm1ky":"afkxpcjqjypu7hhar7banxau91h"}}	1675955414209	1675955414209	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
c7wiascn8wpn3xkhkq8xmkqe8tc	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Hit company global sales target	{"contentOrder":[],"icon":"💰","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a6robxx81diugpjq5jkezz3j1fo","a6amddgmrzakw66cidqzgk6p4ge":"auw3afh3kfhrfgmjr8muiz137jy","adp5ft3kgz7r5iqq3tnwg551der":"a8zg3rjtf4swh7smsjxpsn743rh","ahz3fmjnaguec8hce7xq3h5cjdr":"15%","ajwxp866f9obs1kutfwaa5ru7fe":"50MM","aqxyzkdrs4egqf7yk866ixkaojc":"awfu37js3fomfkkczm1zppac57a","azqnyswk6s1boiwuthscm78qwuo":"7.5MM","azzbawji5bksj69sekcs4srm1ky":"agrfeaoj7d8p5ianw5iaf3191ae"}}	1675955414222	1675955414222	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
cm8zp8a7jp3gezbg3x375hbahye	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Increase user signups by 30%	{"contentOrder":[],"icon":"💳","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a6robxx81diugpjq5jkezz3j1fo","a6amddgmrzakw66cidqzgk6p4ge":"ao9b5pxyt7tkgdohzh9oaustdhr","adp5ft3kgz7r5iqq3tnwg551der":"as555ipyzopjjpfb5rjtssecw5e","ahz3fmjnaguec8hce7xq3h5cjdr":"0%","ajwxp866f9obs1kutfwaa5ru7fe":"1,000","aqxyzkdrs4egqf7yk866ixkaojc":"acb6dqqs6yson7bbzx6jk9bghjh","azqnyswk6s1boiwuthscm78qwuo":"0","azzbawji5bksj69sekcs4srm1ky":"afkxpcjqjypu7hhar7banxau91h"}}	1675955414237	1675955414237	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
c1yangmadqbyqddpcnz51mzb1dc	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Add 10 new customers in the EU	{"contentOrder":[],"icon":"🌍","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"apnt1f7na9rzgk1rt49keg7xbiy","a6amddgmrzakw66cidqzgk6p4ge":"auw3afh3kfhrfgmjr8muiz137jy","adp5ft3kgz7r5iqq3tnwg551der":"a1ts3ftyr8nocsicui98c89uxjy","ahz3fmjnaguec8hce7xq3h5cjdr":"30%","ajwxp866f9obs1kutfwaa5ru7fe":"10","aqxyzkdrs4egqf7yk866ixkaojc":"acb6dqqs6yson7bbzx6jk9bghjh","azqnyswk6s1boiwuthscm78qwuo":"3","azzbawji5bksj69sekcs4srm1ky":"agrfeaoj7d8p5ianw5iaf3191ae"}}	1675955414244	1675955414244	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
cbrnxdi4457dduryz6qpynu5ynr	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Launch 3 key features	{"contentOrder":[],"icon":"🚀","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"apnt1f7na9rzgk1rt49keg7xbiy","a6amddgmrzakw66cidqzgk6p4ge":"ao9b5pxyt7tkgdohzh9oaustdhr","adp5ft3kgz7r5iqq3tnwg551der":"a8zg3rjtf4swh7smsjxpsn743rh","ahz3fmjnaguec8hce7xq3h5cjdr":"33%","ajwxp866f9obs1kutfwaa5ru7fe":"3","aqxyzkdrs4egqf7yk866ixkaojc":"anruuoyez51r3yjxuoc8zoqnwaw","azqnyswk6s1boiwuthscm78qwuo":"1","azzbawji5bksj69sekcs4srm1ky":"aw5i7hmpadn6mbwbz955ubarhme"}}	1675955414250	1675955414249	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
c1kzebdkek3ntixdj5of7q57pya	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Reduce bug backlog by 50%	{"contentOrder":[],"icon":"🐞","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"abzfwnn6rmtfzyq5hg8uqmpsncy","a6amddgmrzakw66cidqzgk6p4ge":"apqfjst8massbjjhpcsjs3y1yqa","adp5ft3kgz7r5iqq3tnwg551der":"a1ts3ftyr8nocsicui98c89uxjy","ahz3fmjnaguec8hce7xq3h5cjdr":"100%","ajwxp866f9obs1kutfwaa5ru7fe":"75","aqxyzkdrs4egqf7yk866ixkaojc":"awfu37js3fomfkkczm1zppac57a","azqnyswk6s1boiwuthscm78qwuo":"75","azzbawji5bksj69sekcs4srm1ky":"aw5i7hmpadn6mbwbz955ubarhme"}}	1675955414260	1675955414260	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
7o9ksmt3jktribytdp9putspe4e	2023-02-09 15:10:14.585839+00	cxy8tneoo8b885jtn4zfqp5xona	1	image		{"fileId":"7b9xk9boj3fbqfm3umeaaizp8qr.png"}	1675955414703	1675955414703	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
v5kjrsy165t85um9997ir99bjxh	2023-02-09 15:10:14.174793+00	bm4ubx56krp4zwyfcqh7nxiigbr	1	view	Departments	{"cardOrder":["cpa534b5natgmunis8u1ixb55pw"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"azzbawji5bksj69sekcs4srm1ky","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["aw5i7hmpadn6mbwbz955ubarhme","afkxpcjqjypu7hhar7banxau91h","aehoa17cz18rqnrf75g7dwhphpr","agrfeaoj7d8p5ianw5iaf3191ae","agm9p6gcq15ueuzqq3wd4be39wy","aucop7kw6xwodcix6zzojhxih6r","afust91f3g8ht368mkn5x9tgf1o","acocxxwjurud1jixhp7nowdig7y"],"visiblePropertyIds":[]}	1675955414270	1675955414270	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
c3kb3yi7xob87xrscc561s3tkmh	2023-02-09 15:10:14.424408+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Start a daily journal	{"contentOrder":[],"icon":"✍️","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","d6b1249b-bc18-45fc-889e-bec48fce80ef":"0a82977f-52bf-457b-841b-e2b7f76fb525","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"3245a32d-f688-463b-87f4-8e7142c1b397"}}	1675955414451	1675955414451	0	\N	system		system	bdjegdwuc3fr3jxmg7sgcn6mtww
cogh3eo3tg7d9umaa5b7rjteejo	2023-02-09 15:10:14.424408+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Run 3 times a week	{"contentOrder":[],"icon":"🏃","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","d6b1249b-bc18-45fc-889e-bec48fce80ef":"6e7139e4-5358-46bb-8c01-7b029a57b80a","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"ffb3f951-b47f-413b-8f1d-238666728008"}}	1675955414456	1675955414456	0	\N	system		system	bdjegdwuc3fr3jxmg7sgcn6mtww
cif69jfjjyfdq9y6kmz6g36mc5a	2023-02-09 15:10:14.424408+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Learn to paint	{"contentOrder":[],"icon":"🎨","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"77c539af-309c-4db1-8329-d20ef7e9eacd","d6b1249b-bc18-45fc-889e-bec48fce80ef":"9a090e33-b110-4268-8909-132c5002c90e","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"3245a32d-f688-463b-87f4-8e7142c1b397"}}	1675955414461	1675955414461	0	\N	system		system	bdjegdwuc3fr3jxmg7sgcn6mtww
cpqd9prb7ij8x98bfoaubgbkbfy	2023-02-09 15:10:14.424408+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Open retirement account	{"contentOrder":[],"icon":"🏦","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","d6b1249b-bc18-45fc-889e-bec48fce80ef":"0a82977f-52bf-457b-841b-e2b7f76fb525","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"80be816c-fc7a-4928-8489-8b02180f4954"}}	1675955414467	1675955414467	0	\N	system		system	bdjegdwuc3fr3jxmg7sgcn6mtww
v6ghe65mhd3fatfmn8r4mkmpejo	2023-02-09 15:10:14.424408+00	bd65qbzuqupfztpg31dgwgwm5ga	1	view	By Status	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"af6fcbb8-ca56-4b73-83eb-37437b9a667d","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","77c539af-309c-4db1-8329-d20ef7e9eacd","98bdea27-0cce-4cde-8dc6-212add36e63a",""],"visiblePropertyIds":["d9725d14-d5a8-48e5-8de1-6f8c004a9680","d6b1249b-bc18-45fc-889e-bec48fce80ef"]}	1675955414476	1675955414476	0	\N	system		system	bdjegdwuc3fr3jxmg7sgcn6mtww
vt6x1h6sacibh3cchs3tea6du9w	2023-02-09 15:10:14.424408+00	bd65qbzuqupfztpg31dgwgwm5ga	1	view	Calendar View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"ajy6xbebzopojaenbnmfpgtdwso","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955414486	1675955414486	0	\N	system		system	bdjegdwuc3fr3jxmg7sgcn6mtww
ve6nrxk4a6trupk94tfw8oxgutw	2023-02-09 15:10:14.424408+00	bd65qbzuqupfztpg31dgwgwm5ga	1	view	By Date	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"d6b1249b-bc18-45fc-889e-bec48fce80ef","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["9a090e33-b110-4268-8909-132c5002c90e","0a82977f-52bf-457b-841b-e2b7f76fb525","6e7139e4-5358-46bb-8c01-7b029a57b80a","d5371c63-66bf-4468-8738-c4dc4bea4843",""],"visiblePropertyIds":["d9725d14-d5a8-48e5-8de1-6f8c004a9680"]}	1675955414493	1675955414493	0	\N	system		system	bdjegdwuc3fr3jxmg7sgcn6mtww
vu77og8uegir6fqcd97psqyuabo	2023-02-09 15:10:14.585839+00		1	view	By Sprint	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{"ai7ajsdk14w7x5s8up3dwir77te":"count"},"columnWidths":{"20717ad3-5741-4416-83f1-6f133fff3d11":128,"50117d52-bcc7-4750-82aa-831a351c44a0":126,"__title":280,"a1g6i613dpe9oryeo71ex3c86hy":159,"aeomttrbhhsi8bph31jn84sto6h":141,"ax9f8so418s6s65hi5ympd93i6a":183,"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":100},"defaultTemplateId":"cc9a5jhgow7njpft3ywtffsz78c","filter":{"filters":[],"operation":"and"},"groupById":"60985f46-3e41-486e-8213-2b987440ea1c","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["50117d52-bcc7-4750-82aa-831a351c44a0","20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","aphg37f7zbpuc3bhwhp19s1ribh","a4378omyhmgj3bex13sj4wbpfiy","ai7ajsdk14w7x5s8up3dwir77te","a1g6i613dpe9oryeo71ex3c86hy","aeomttrbhhsi8bph31jn84sto6h","ax9f8so418s6s65hi5ympd93i6a"]}	1675955414600	1675955414600	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
cc9a5jhgow7njpft3ywtffsz78c	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	User Story	{"contentOrder":["awzojrhtdh3nr5psizhywihzzgh"],"icon":"📖","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"apht1nt5ryukdmxkh6fkfn6rgoy","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer"}}	1675955414605	1675955414605	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
cfcj6p6y8rpn9tnezxe9bmsnmrh	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Horizontal scroll issue	{"contentOrder":["a6znekksdmpgmjedazsggqn1egh","apejdcik6kfn4fpdzixe485b7ae","76mot8uwo8jyatk53897g4oatca"],"icon":"〰️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"aomnawq4551cbbzha9gxnmb3z5w","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","ai7ajsdk14w7x5s8up3dwir77te":"1","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955414611	1675955414611	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
cxy8tneoo8b885jtn4zfqp5xona	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Login screen not loading	{"contentOrder":["aposk4q1ze3yozq4i1h9b6gjcbe","ahohrhxsoxjdmmp8igah5otrsho","7o9ksmt3jktribytdp9putspe4e"],"icon":"🖥️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"aomnawq4551cbbzha9gxnmb3z5w","50117d52-bcc7-4750-82aa-831a351c44a0":"abrfos7e7eczk9rqw6y5abadm1y","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","ai7ajsdk14w7x5s8up3dwir77te":"1","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"cb8ecdac-38be-4d36-8712-c4d58cc8a8e9"}}	1675955414618	1675955414618	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
cjwq1mmub3fbx9xidzmj1jth7dh	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Move cards across boards	{"contentOrder":["acx4qi4iqi3dgbgxe13rndfcxew"],"icon":"🚚","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"abrfos7e7eczk9rqw6y5abadm1y","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"2","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955414623	1675955414623	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
cawustaeu8pftmf4m4pfqya7k5h	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Cross-team collaboration	{"contentOrder":["aghhoq7neoirsbqq1b5r3m8knih"],"icon":"🤝","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"424ea5e3-9aa1-4075-8c5c-01b44b66e634","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","60985f46-3e41-486e-8213-2b987440ea1c":"14892380-1a32-42dd-8034-a0cea32bc7e6","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"3","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"c62172ea-5da7-4dec-8186-37267d8ee9a7"}}	1675955414629	1675955414629	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
cfxdu38pf57f98nmq8jj1fbtqja	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Bug	{"contentOrder":["adxhwp1jo67yxzczyc4p5ywxkmr","aq6rch5gsb3ne8cmqcp56ery9so","7q7j6yp8etpbktptcwtxefck6iw"],"icon":"🐞","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"aomnawq4551cbbzha9gxnmb3z5w","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer"}}	1675955414634	1675955414634	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
cn3ox8hrrutgtbnhoebu7fqgzdy	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Standard properties	{"contentOrder":["ar9whaq5zjifr8rq61a3e5pkyfa"],"icon":"🏷️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","60985f46-3e41-486e-8213-2b987440ea1c":"14892380-1a32-42dd-8034-a0cea32bc7e6","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"3","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955414639	1675955414639	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
c49q5wfok97ghujoyxiaqitzdry	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Epic	{"contentOrder":["akgpkj8rmabby58uyeyag9stijw"],"icon":"🤝","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"424ea5e3-9aa1-4075-8c5c-01b44b66e634","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"3","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"c62172ea-5da7-4dec-8186-37267d8ee9a7"}}	1675955414645	1675955414645	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
casdocyctotyajr5mb6kehetz1a	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Global templates	{"contentOrder":["au7ctdfpqgtrf3xksx398ux3e5h"],"icon":"🖼️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"a6ghze4iy441qhsh3eijnc8hwze","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"2","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955414649	1675955414649	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
chcs5bmiyftf1fjfpiaoeewpgba	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Feature	{"contentOrder":["aip8b45tfj3bp3dduxap3wn7g1a"],"icon":"🏗️","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer"}}	1675955414655	1675955414655	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
voi8jzi41yiyrucj1sh61s8tm6w	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	view	By Status	{"cardOrder":["casdocyctotyajr5mb6kehetz1a","cfcj6p6y8rpn9tnezxe9bmsnmrh","cjwq1mmub3fbx9xidzmj1jth7dh","cxy8tneoo8b885jtn4zfqp5xona","cn3ox8hrrutgtbnhoebu7fqgzdy","cawustaeu8pftmf4m4pfqya7k5h"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cidz4imnqhir48brz6e8hxhfrhy","filter":{"filters":[],"operation":"and"},"groupById":"50117d52-bcc7-4750-82aa-831a351c44a0","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["aft5bzo7h9aspqgrx3jpy5tzrer","abrfos7e7eczk9rqw6y5abadm1y","ax8wzbka5ahs3zziji3pp4qp9mc","atabdfbdmjh83136d5e5oysxybw","ace1bzypd586kkyhcht5qqd9eca","aay656c9m1hzwxc9ch5ftymh3nw","a6ghze4iy441qhsh3eijnc8hwze"],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675955414660	1675955414660	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
v7j16qap9ctfzibq6zgg66b5hay	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	view	By Type	{"cardOrder":["cxy8tneoo8b885jtn4zfqp5xona","cjwq1mmub3fbx9xidzmj1jth7dh","cn3ox8hrrutgtbnhoebu7fqgzdy","cfcj6p6y8rpn9tnezxe9bmsnmrh","casdocyctotyajr5mb6kehetz1a","cawustaeu8pftmf4m4pfqya7k5h"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cidz4imnqhir48brz6e8hxhfrhy","filter":{"filters":[],"operation":"and"},"groupById":"20717ad3-5741-4416-83f1-6f133fff3d11","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["424ea5e3-9aa1-4075-8c5c-01b44b66e634","a5yxq8rbubrpnoommfwqmty138h","apht1nt5ryukdmxkh6fkfn6rgoy","aiycbuo3dr5k4xxbfr7coem8ono","aomnawq4551cbbzha9gxnmb3z5w"],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675955414677	1675955414677	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
awzojrhtdh3nr5psizhywihzzgh	2023-02-09 15:10:14.585839+00	cc9a5jhgow7njpft3ywtffsz78c	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955414683	1675955414683	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
76mot8uwo8jyatk53897g4oatca	2023-02-09 15:10:14.585839+00	cfcj6p6y8rpn9tnezxe9bmsnmrh	1	image		{"fileId":"7tmfu5iqju3n1mdfwi5gru89qmw.png"}	1675955414688	1675955414688	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
a6znekksdmpgmjedazsggqn1egh	2023-02-09 15:10:14.585839+00	cfcj6p6y8rpn9tnezxe9bmsnmrh	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675955414694	1675955414694	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
apejdcik6kfn4fpdzixe485b7ae	2023-02-09 15:10:14.585839+00	cfcj6p6y8rpn9tnezxe9bmsnmrh	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675955414699	1675955414699	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
aposk4q1ze3yozq4i1h9b6gjcbe	2023-02-09 15:10:14.585839+00	cxy8tneoo8b885jtn4zfqp5xona	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675955414707	1675955414707	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
ahohrhxsoxjdmmp8igah5otrsho	2023-02-09 15:10:14.585839+00	cxy8tneoo8b885jtn4zfqp5xona	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675955414712	1675955414712	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
acx4qi4iqi3dgbgxe13rndfcxew	2023-02-09 15:10:14.585839+00	cjwq1mmub3fbx9xidzmj1jth7dh	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955414717	1675955414717	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
abs7abu751bbbjczo3e9j9kyssw	2023-02-09 15:10:14.585839+00	cfmk7771httynm8r7rm8cbrmrya	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675955414722	1675955414722	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
adaiaeiqjrfbf3xekijke57ggco	2023-02-09 15:10:14.585839+00	cfmk7771httynm8r7rm8cbrmrya	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675955414728	1675955414728	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
aghhoq7neoirsbqq1b5r3m8knih	2023-02-09 15:10:14.585839+00	cawustaeu8pftmf4m4pfqya7k5h	1	text	## Summary\n*[Brief description of what this epic is about]*\n\n## Motivation\n*[Brief description on why this is needed]*\n\n## Acceptance Criteria\n - *[Criteron 1]*\n - *[Criteron 2]*\n - ...\n\n## Personas\n - *[Persona A]*\n - *[Persona B]*\n - ...\n\n## Reference Materials\n - *[Links to other relevant documents as needed]*\n - ...	{}	1675955414733	1675955414733	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
7q7j6yp8etpbktptcwtxefck6iw	2023-02-09 15:10:14.585839+00	cfxdu38pf57f98nmq8jj1fbtqja	1	image		{"fileId":"7tmfu5iqju3n1mdfwi5gru89qmw.png"}	1675955414738	1675955414738	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
adxhwp1jo67yxzczyc4p5ywxkmr	2023-02-09 15:10:14.585839+00	cfxdu38pf57f98nmq8jj1fbtqja	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675955414744	1675955414744	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
aq6rch5gsb3ne8cmqcp56ery9so	2023-02-09 15:10:14.585839+00	cfxdu38pf57f98nmq8jj1fbtqja	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675955414750	1675955414750	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
ar9whaq5zjifr8rq61a3e5pkyfa	2023-02-09 15:10:14.585839+00	cn3ox8hrrutgtbnhoebu7fqgzdy	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955414756	1675955414756	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
akgpkj8rmabby58uyeyag9stijw	2023-02-09 15:10:14.585839+00	c49q5wfok97ghujoyxiaqitzdry	1	text	## Summary\n*[Brief description of what this epic is about]*\n\n## Motivation\n*[Brief description on why this is needed]*\n\n## Acceptance Criteria\n - *[Criteron 1]*\n - *[Criteron 2]*\n - ...\n\n## Personas\n - *[Persona A]*\n - *[Persona B]*\n - ...\n\n## Reference Materials\n - *[Links to other relevant documents as needed]*\n - ...	{}	1675955414761	1675955414761	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
au7ctdfpqgtrf3xksx398ux3e5h	2023-02-09 15:10:14.585839+00	casdocyctotyajr5mb6kehetz1a	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955414766	1675955414766	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
aip8b45tfj3bp3dduxap3wn7g1a	2023-02-09 15:10:14.585839+00	chcs5bmiyftf1fjfpiaoeewpgba	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955414771	1675955414771	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
vq5gp9utjdfgaxfzyoh1xbiyieh	2023-02-09 15:10:15.027456+00		1	view	All Users	{"cardOrder":["cmunfwxy6kif48jhg8g8do7wnpy"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":280,"aaebj5fyx493eezx6ukxiwydgty":146,"acjq4t5ymytu8x1f68wkggm7ypc":222,"akrxgi7p7w14fym3gbynb98t9fh":131,"atg9qu6oe4bjm8jczzsn71ff5me":131},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"akrxgi7p7w14fym3gbynb98t9fh","reversed":false}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["aaebj5fyx493eezx6ukxiwydgty","akrxgi7p7w14fym3gbynb98t9fh","atg9qu6oe4bjm8jczzsn71ff5me","acjq4t5ymytu8x1f68wkggm7ypc","aphio1s5gkmpdbwoxynim7acw3e","aqafzdeekpyncwz7m7i54q3iqqy","aify3r761b9w43bqjtskrzi68tr"]}	1675955415037	1675955415037	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
cmunfwxy6kif48jhg8g8do7wnpy	2023-02-09 15:10:15.027456+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Frank Nash	{"contentOrder":["apd8tm8d9838fbczp1a5exi6nde"],"icon":"👨‍💼","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"ap93ysuzy1xa7z818r6myrn4h4y","acjq4t5ymytu8x1f68wkggm7ypc":"frank.nash@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1669896000000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"aehc83ffays3gh8myz16a8j7k4e"}}	1675955415043	1675955415043	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
ceo3xece5mid4jjwaoqfs51xqch	2023-02-09 15:10:15.027456+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Richard Parsons	{"contentOrder":["a66wqjsz1yp87pb3k5sc355cpuy"],"icon":"👨‍🦱","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"a7yq89whddzob1futao4rxk3yzc","acjq4t5ymytu8x1f68wkggm7ypc":"richard.parsons@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1671019200000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"a1sxagjgaadym5yrjak6tcup1oa"}}	1675955415048	1675955415048	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
aogf1khixcifedyhnnxb8y5cs9a	2023-02-09 15:10:16.551755+00	crkth4zwoppf6me17xb1sf7m7wr	1	text	Mattermost Boards helps you manage and track all your project tasks with **Cards**.	{}	1675955416752	1675955416752	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
cwb6qiq5p4pgmfjnk95xz13rx4h	2023-02-09 15:10:15.027456+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Claire Hart	{"contentOrder":["a9xsae5aqafrbixp9gwjwpbqb3r"],"icon":"👩‍🦰","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"aseqq9hrsua56r3s6nbuirj9eec","acjq4t5ymytu8x1f68wkggm7ypc":"claire.hart@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1670500800000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"ahn89mqg9u4igk6pdm7333t8i5h"}}	1675955415054	1675955415054	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
co7xboyn5mfgatfdpye6nhj8ntw	2023-02-09 15:10:15.027456+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Olivia Alsop	{"contentOrder":["aitj1uj1gytfytcxxkarzf7z1sh"],"icon":"👩‍💼","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"a7yq89whddzob1futao4rxk3yzc","acjq4t5ymytu8x1f68wkggm7ypc":"olivia.alsop@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1671192000000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"a1sxagjgaadym5yrjak6tcup1oa"}}	1675955415059	1675955415059	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
c7jc13yp69bfh5q3inet8r7jqso	2023-02-09 15:10:15.027456+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Bernadette Powell	{"contentOrder":["azqotjxjdhj8r7r89r9wu3jyxby"],"icon":"🧑‍💼","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"af6hjb3ysuaxbwnfqpby4wwnkdr","acjq4t5ymytu8x1f68wkggm7ypc":"bernadette.powell@email.com"}}	1675955415065	1675955415065	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
vcnu6wcrtrpr1umz6oeyq5kpfzr	2023-02-09 15:10:15.027456+00	bh4pkixqsjift58e1qy6htrgeay	1	view	By Date	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"akrxgi7p7w14fym3gbynb98t9fh","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955415072	1675955415072	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
vi47u17fbjjbzjmdcu8z9fke64o	2023-02-09 15:10:15.027456+00	bixohg18tt11in4qbtinimk974y	1	view	By Status	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["af6hjb3ysuaxbwnfqpby4wwnkdr","aotxum1p5bw3xuzqz3ctjw66yww","a7yq89whddzob1futao4rxk3yzc","aseqq9hrsua56r3s6nbuirj9eec","ap93ysuzy1xa7z818r6myrn4h4y"],"visiblePropertyIds":[]}	1675955415107	1675955415107	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
apd8tm8d9838fbczp1a5exi6nde	2023-02-09 15:10:15.027456+00	cmunfwxy6kif48jhg8g8do7wnpy	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1675955415117	1675955415117	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
a66wqjsz1yp87pb3k5sc355cpuy	2023-02-09 15:10:15.027456+00	ceo3xece5mid4jjwaoqfs51xqch	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1675955415123	1675955415123	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
a9xsae5aqafrbixp9gwjwpbqb3r	2023-02-09 15:10:15.027456+00	cwb6qiq5p4pgmfjnk95xz13rx4h	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1675955415129	1675955415129	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
aitj1uj1gytfytcxxkarzf7z1sh	2023-02-09 15:10:15.027456+00	co7xboyn5mfgatfdpye6nhj8ntw	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1675955415134	1675955415134	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
azqotjxjdhj8r7r89r9wu3jyxby	2023-02-09 15:10:15.027456+00	c7jc13yp69bfh5q3inet8r7jqso	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1675955415137	1675955415137	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
cc6jo65tkri8kxfy85rpyg9r8de	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	card	New Project and Workflow Management Solutions for Developers	{"contentOrder":["71qhnzuec6esdi6fnynwpze4xya","ah8cy7eza9tba5pmk3qfdn4ngfo"],"icon":"🎯","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1645790400000}","ab6mbock6styfe6htf815ph1mhw":["a8xceonxiu4n3c43szhskqizicr","a3pdzi53kpbd4okzdkz6khi87zo","a3d9ux4fmi3anyd11kyipfbhwde"],"ae9ar615xoknd8hw8py7mbyr7zo":"awna1nuarjca99m9s4uiy9kwj5h","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://mattermost.com/newsroom/press-releases/mattermost-launches-new-project-and-workflow-management-solutions-for-developers/","aysx3atqexotgwp5kx6h5i5ancw":"aywiofmmtd3ofgzj95ysky4pjga"}}	1675955415566	1675955415566	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
c95jy6ztp3t8pinfsftu93bs6uh	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	card	[Tweet] Mattermost v6.1 includes card @-mention notifications in Boards	{"contentOrder":["7i96m7nbsdsex8n6hzuzrmdfjuy","7ed5bwp3gr8yax3mhtuwiaa9gjy","ard5i9e86qjnppf8zzttwiqdsme","aogzjxtgjt38upneka4fjk7f6hh","abdasiyq4k7ndtfrdadrias8sjy","7h6rn8yhjp7bm9q4sac8hinx8ge"],"icon":"🐤","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1639051200000}","ab6mbock6styfe6htf815ph1mhw":["az8o8pfe9hq6s7xaehoqyc3wpyc"],"ae9ar615xoknd8hw8py7mbyr7zo":"a9ana1e9w673o5cp8md4xjjwfto","agqsoiipowmnu9rdwxm57zrehtr":"{\\"from\\":1637668800000}","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://twitter.com/Mattermost/status/1463145633162969097?s=20","aysx3atqexotgwp5kx6h5i5ancw":"aj8y675weso8kpb6eceqbpj4ruw"}}	1675955415576	1675955415576	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
cf735gnmxwbdrd885z11f19rbyw	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	card	Top 10 Must-Have DevOps Tools in 2021	{"contentOrder":["7fo1utqc8x1z1z6hzg33hes1ktc","apsnwcshioid6uca7ugj36paj7y"],"icon":"🛠️","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1636113600000}","ab6mbock6styfe6htf815ph1mhw":["a8xceonxiu4n3c43szhskqizicr"],"ae9ar615xoknd8hw8py7mbyr7zo":"a9ana1e9w673o5cp8md4xjjwfto","agqsoiipowmnu9rdwxm57zrehtr":"{\\"from\\":1637323200000}","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://www.toolbox.com/tech/devops/articles/best-devops-tools/","aysx3atqexotgwp5kx6h5i5ancw":"a3xky7ygn14osr1mokerbfah5cy"}}	1675955415586	1675955415586	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
cjfsfemn88jfx7xutwd7jwfrubo	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	card	Unblocking Workflows: The Guide to Developer Productivity	{"contentOrder":["77tz16jtz5x73ncs3dxc3fp1d7h","aqwxfnfpu9p81zxum4kyy36faso"],"icon":"💻","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1638532800000}","ab6mbock6styfe6htf815ph1mhw":["a3pdzi53kpbd4okzdkz6khi87zo"],"ae9ar615xoknd8hw8py7mbyr7zo":"apy9dcd7zmand615p3h53zjqxjh","agqsoiipowmnu9rdwxm57zrehtr":"{\\"from\\":1639483200000}","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://mattermost.com/newsroom/press-releases/mattermost-unveils-definitive-report-on-the-state-of-developer-productivity-unblocking-workflows-the-guide-to-developer-productivity-2022-edition/","aysx3atqexotgwp5kx6h5i5ancw":"a3xky7ygn14osr1mokerbfah5cy"}}	1675955415591	1675955415591	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
7egzqwfr9n3gqjq6yrs9powrjby	2023-02-09 15:10:16.551755+00	cafahsprdajymd83b1dzr4sj91w	1	image		{"fileId":"7ek6wbpp19jfoujs1goh6kttbby.gif"}	1675955416755	1675955416755	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
vywt3ibumzp8tdg4wm67j5km7ma	2023-02-09 15:10:15.260316+00		1	view	Competitor List	{"cardOrder":["cinzhmm4ixiry8p5uchukeyjxuy","c43hjyntaxi8hup6dykbx4iik4h","ci6ss4aksnir9ukm1ycpbcnxihr","cptd3wkf6tt8oiq891pwj6frbbh","cf1fyfb97p7rumpmtedzawkzp4r"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":210,"a1semdhszu1rq17d7et5ydrqqio":121,"aapogff3xoa8ym7xf56s87kysda":194,"ahzspe59iux8wigra8bg6cg18nc":156,"aiefo7nh9jwisn8b4cgakowithy":155,"aozntq4go4nkab688j1s7stqtfc":151,"az3jkw3ynd3mqmart7edypey15e":145},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["ahzspe59iux8wigra8bg6cg18nc","aozntq4go4nkab688j1s7stqtfc","aiefo7nh9jwisn8b4cgakowithy","a6cwaq79b1pdpb97wkanmeyy4er","an1eerzscfxn6awdfajbg41uz3h","a1semdhszu1rq17d7et5ydrqqio","aapogff3xoa8ym7xf56s87kysda","az3jkw3ynd3mqmart7edypey15e"]}	1675955415270	1675955415270	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
vr7jn5u1b7tnjmjw6tnrkxnx7uc	2023-02-09 15:10:15.260316+00		1	view	Market Position	{"cardOrder":["cip8b4jcomfr7by9gtizebikfke","cacs91js1hb887ds41r6dwnd88c","ca3u8edwrof89i8obxffnz4xw3a"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["arfjpz9by5car71tz3behba8yih","abajmr34b8g1916w495xjb35iko","abt79uxg5edqojsrrefcnr4eruo","aipf3qfgjtkheiayjuxrxbpk9wa"],"visiblePropertyIds":[]}	1675955415276	1675955415276	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
cinzhmm4ixiry8p5uchukeyjxuy	2023-02-09 15:10:15.260316+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Liminary Corp.	{"contentOrder":["apypqwuyws7dxzj3g3fwk8atdse"],"icon":"🌧","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"abt79uxg5edqojsrrefcnr4eruo","a6cwaq79b1pdpb97wkanmeyy4er":"300","ahzspe59iux8wigra8bg6cg18nc":"liminarycorp.com","aiefo7nh9jwisn8b4cgakowithy":"$25,000,000","an1eerzscfxn6awdfajbg41uz3h":"2017","aozntq4go4nkab688j1s7stqtfc":"Toronto, Canada"}}	1675955415280	1675955415280	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
c43hjyntaxi8hup6dykbx4iik4h	2023-02-09 15:10:15.260316+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Helx Industries	{"contentOrder":["az9nkkcazeiruicczj15tot913a"],"icon":"📦","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"abt79uxg5edqojsrrefcnr4eruo","a6cwaq79b1pdpb97wkanmeyy4er":"650","ahzspe59iux8wigra8bg6cg18nc":"helxindustries.com","aiefo7nh9jwisn8b4cgakowithy":"$50,000,000","an1eerzscfxn6awdfajbg41uz3h":"2009","aozntq4go4nkab688j1s7stqtfc":"New York, NY"}}	1675955415284	1675955415284	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
ci6ss4aksnir9ukm1ycpbcnxihr	2023-02-09 15:10:15.260316+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Kadera Global	{"contentOrder":["asge3fu3t6inhjbz3muc4expd9c"],"icon":"🛡","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"aipf3qfgjtkheiayjuxrxbpk9wa","a6cwaq79b1pdpb97wkanmeyy4er":"150","ahzspe59iux8wigra8bg6cg18nc":"kaderaglobal.com","aiefo7nh9jwisn8b4cgakowithy":"$12,000,000","an1eerzscfxn6awdfajbg41uz3h":"2015","aozntq4go4nkab688j1s7stqtfc":"Seattle, OR"}}	1675955415290	1675955415290	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
cf1fyfb97p7rumpmtedzawkzp4r	2023-02-09 15:10:15.260316+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Ositions Inc.	{"contentOrder":["a48dxo8rjrpna7ke391tmepk37c"],"icon":"🌃","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"abajmr34b8g1916w495xjb35iko","a6cwaq79b1pdpb97wkanmeyy4er":"2,700","ahzspe59iux8wigra8bg6cg18nc":"ositionsinc.com","aiefo7nh9jwisn8b4cgakowithy":"$125,000,000","an1eerzscfxn6awdfajbg41uz3h":"2004","aozntq4go4nkab688j1s7stqtfc":"Berlin, Germany"}}	1675955415295	1675955415295	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
cptd3wkf6tt8oiq891pwj6frbbh	2023-02-09 15:10:15.260316+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Afformance Ltd.	{"contentOrder":["acuyiteaixfncprpfxb6p9q65xc"],"icon":"⚡","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"arfjpz9by5car71tz3behba8yih","a6cwaq79b1pdpb97wkanmeyy4er":"1,800","ahzspe59iux8wigra8bg6cg18nc":"afformanceltd.com","aiefo7nh9jwisn8b4cgakowithy":"$200,000,000","an1eerzscfxn6awdfajbg41uz3h":"2002","aozntq4go4nkab688j1s7stqtfc":"Palo Alto, CA"}}	1675955415301	1675955415301	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
apypqwuyws7dxzj3g3fwk8atdse	2023-02-09 15:10:15.260316+00	cinzhmm4ixiry8p5uchukeyjxuy	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1675955415306	1675955415306	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
az9nkkcazeiruicczj15tot913a	2023-02-09 15:10:15.260316+00	c43hjyntaxi8hup6dykbx4iik4h	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1675955415316	1675955415316	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
asge3fu3t6inhjbz3muc4expd9c	2023-02-09 15:10:15.260316+00	ci6ss4aksnir9ukm1ycpbcnxihr	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1675955415329	1675955415329	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
a48dxo8rjrpna7ke391tmepk37c	2023-02-09 15:10:15.260316+00	cf1fyfb97p7rumpmtedzawkzp4r	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n\n## Weaknesses\n- ...\n- ...\n\n## Opportunities\n- ...\n- ...\n\n## Threats\n- ...\n- ...	{}	1675955415342	1675955415342	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
arqrzjjesiirobdw5t97yrnax1a	2023-02-09 15:10:15.990252+00	cwrq9ag3p5pgzzy98nfd3wwra1w	1	text	## Summary\n*[Brief description of what this epic is about]*\n## Motivation\n*[Brief description on why this is needed]*\n## Acceptance Criteria\n- *[Criteron 1]*\n- *[Criteron 2]*\n- ...\n## Personas\n- *[Persona A]*\n- *[Persona B]*\n- ...\n## Reference Materials\n- *[Links to other relevant documents as needed]*\n- ...	{}	1675955416173	1675955416173	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
acuyiteaixfncprpfxb6p9q65xc	2023-02-09 15:10:15.260316+00	cptd3wkf6tt8oiq891pwj6frbbh	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1675955415347	1675955415347	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
cyhsodm36cbdh8q7kxm1j1gr8yw	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	card	App crashing	{"contentOrder":["79t7rkiuspeneqi9xurou9tqzwh","aowo8igj7rtnp7mwapij7s3o3xa","aej4ic8nk8td7zebzhmhfh9wu6y","7xt8yx9f49jbxbpkhjce5pi5g7o"],"icon":"📉","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"1fdbb515-edd2-4af5-80fc-437ed2211a49","50117d52-bcc7-4750-82aa-831a351c44a0":"ec6d2bc5-df2b-4f77-8479-e59ceb039946","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"cb8ecdac-38be-4d36-8712-c4d58cc8a8e9"}}	1675955416001	1675955416001	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
cxjt8ekj8yfratx83ukjr1nt5dw	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Calendar view	{"contentOrder":["7df11783ny67mdnognqae31ax6y","a8xtbuofra3yyf8dms1mknwen3r"],"icon":"📆","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"6eea96c9-4c61-4968-8554-4b7537e8f748","50117d52-bcc7-4750-82aa-831a351c44a0":"849766ba-56a5-48d1-886f-21672f415395","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955416006	1675955416006	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
cut844cdxxj86xqyrs9ctgecfme	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Standard templates	{"contentOrder":["7uonmjk41nipnrsi6tz8wau5ssh","ab6dzethdibbmfpwqwe5hx98pga"],"icon":"🗺️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"6eea96c9-4c61-4968-8554-4b7537e8f748","50117d52-bcc7-4750-82aa-831a351c44a0":"ec6d2bc5-df2b-4f77-8479-e59ceb039946","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955416011	1675955416011	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
ccoro58a94idw8mdo9k5rx3dx4h	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Import / Export	{"contentOrder":["a66nc7e11k78e9gm4hfude4z6dr"],"icon":"🚢","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"6eea96c9-4c61-4968-8554-4b7537e8f748","50117d52-bcc7-4750-82aa-831a351c44a0":"ec6d2bc5-df2b-4f77-8479-e59ceb039946","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955416016	1675955416016	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
c13uy7qkt57gapqc3qp61bhyjqr	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Review API design	{"contentOrder":["afw5i81na7id4jfw1wzb1qc7o6e"],"icon":"🛣️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"424ea5e3-9aa1-4075-8c5c-01b44b66e634","50117d52-bcc7-4750-82aa-831a351c44a0":"8c557f69-b0ed-46ec-83a3-8efab9d47ef5","60985f46-3e41-486e-8213-2b987440ea1c":"14892380-1a32-42dd-8034-a0cea32bc7e6","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"c62172ea-5da7-4dec-8186-37267d8ee9a7"}}	1675955416022	1675955416022	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
czwsifj8cm7fabf6asnhc8fugho	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Icons don't display	{"contentOrder":["azexrsotg53bp7xrf7zjogmk1fo","am796mc4hafgy7dc95e41hwfrmw","7csaz76fn9fgabquxp54stmjbne"],"icon":"💻","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"1fdbb515-edd2-4af5-80fc-437ed2211a49","50117d52-bcc7-4750-82aa-831a351c44a0":"8c557f69-b0ed-46ec-83a3-8efab9d47ef5","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955416028	1675955416028	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
v9d4nczqqmtri8mb6m83qj7j9oo	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	view	Calendar View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"a4378omyhmgj3bex13sj4wbpfiy","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955416036	1675955416035	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
vrtqx3uxamfynjd7ojjm8mcu3ty	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	view	Board: Sprints	{"cardOrder":["cyhsodm36cbdh8q7kxm1j1gr8yw","cxjt8ekj8yfratx83ukjr1nt5dw","cut844cdxxj86xqyrs9ctgecfme","czwsifj8cm7fabf6asnhc8fugho","ccoro58a94idw8mdo9k5rx3dx4h","c13uy7qkt57gapqc3qp61bhyjqr"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"60985f46-3e41-486e-8213-2b987440ea1c","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["c01676ca-babf-4534-8be5-cce2287daa6c","ed4a5340-460d-461b-8838-2c56e8ee59fe","14892380-1a32-42dd-8034-a0cea32bc7e6",""],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675955416048	1675955416047	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
vgf1tx6hdcfg4bnj1fpgkyfdnno	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	view	List: Tasks 🔨	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"50117d52-bcc7-4750-82aa-831a351c44a0":139,"__title":280},"defaultTemplateId":"","filter":{"filters":[{"condition":"includes","propertyId":"20717ad3-5741-4416-83f1-6f133fff3d11","values":["6eea96c9-4c61-4968-8554-4b7537e8f748"]}],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"50117d52-bcc7-4750-82aa-831a351c44a0","reversed":true}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["50117d52-bcc7-4750-82aa-831a351c44a0","20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675955416057	1675955416057	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
azexrsotg53bp7xrf7zjogmk1fo	2023-02-09 15:10:15.990252+00	czwsifj8cm7fabf6asnhc8fugho	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675955416158	1675955416158	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
vy4rzknwe5bdrbd8kg5sfaq7rcy	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	view	By Status	{"cardOrder":[null,"cdbfkd15d6iy18rgx1tskmfsr6c","cn8yofg9rtkgmzgmb5xdi56p3ic","csgsnnywpuqzs5jgq87snk9x17e","cqwaytore5y487wdu8zffppqnea",null],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["awna1nuarjca99m9s4uiy9kwj5h","a9ana1e9w673o5cp8md4xjjwfto","apy9dcd7zmand615p3h53zjqxjh","acri4cm3bmay55f7ksztphmtnga","amsowcd9a8e1kid317r7ttw6uzh",""],"visiblePropertyIds":["ab6mbock6styfe6htf815ph1mhw"]}	1675955415596	1675955415596	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
vf1ywowszz3bktg6rzbj8x5w9qc	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	view	Due Date Calendar	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"a39x5cybshwrbjpc3juaakcyj6e","defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955415602	1675955415602	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
vca7xj7s8d3fpu856mw15dw1o8o	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	view	Publication Calendar	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"agqsoiipowmnu9rdwxm57zrehtr","defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955415607	1675955415607	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
v6jmwqbs8hjrkipcqhjgcxyn9ge	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	view	Content List	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":322,"ab6mbock6styfe6htf815ph1mhw":229,"aysx3atqexotgwp5kx6h5i5ancw":208},"defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"a39x5cybshwrbjpc3juaakcyj6e","reversed":false}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["ae9ar615xoknd8hw8py7mbyr7zo","aysx3atqexotgwp5kx6h5i5ancw","ab6mbock6styfe6htf815ph1mhw","ao44fz8nf6z6tuj1x31t9yyehcc","a39x5cybshwrbjpc3juaakcyj6e","agqsoiipowmnu9rdwxm57zrehtr","ap4e7kdg7eip7j3c3oyiz39eaoc"]}	1675955415613	1675955415613	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
ah8cy7eza9tba5pmk3qfdn4ngfo	2023-02-09 15:10:15.523642+00	cc6jo65tkri8kxfy85rpyg9r8de	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675955415619	1675955415619	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
7h6rn8yhjp7bm9q4sac8hinx8ge	2023-02-09 15:10:15.523642+00	c95jy6ztp3t8pinfsftu93bs6uh	1	image		{"fileId":"7y5kr8x8ybpnwdykjfuz57rggrh.png"}	1675955415624	1675955415624	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
ard5i9e86qjnppf8zzttwiqdsme	2023-02-09 15:10:15.523642+00	c95jy6ztp3t8pinfsftu93bs6uh	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675955415630	1675955415630	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
aogzjxtgjt38upneka4fjk7f6hh	2023-02-09 15:10:15.523642+00	c95jy6ztp3t8pinfsftu93bs6uh	1	text	## Media	{}	1675955415634	1675955415634	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
akta9uxe6pp8gtbmbunotw87m3r	2023-02-09 15:10:15.523642+00	cff1jmrxfrirgbeebhr9qd7nida	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675955415639	1675955415639	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
apsogn1m3ifrc9qsxzesijqcjdc	2023-02-09 15:10:15.523642+00	cff1jmrxfrirgbeebhr9qd7nida	1	text	## Research\n- ...\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n- ...\n\n## Notes\n- ...\n- ...\n- ...	{}	1675955415644	1675955415644	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
ap7a7kupzfffomn6sxkw73yqjmy	2023-02-09 15:10:15.523642+00	cff1jmrxfrirgbeebhr9qd7nida	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675955415649	1675955415649	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
apsnwcshioid6uca7ugj36paj7y	2023-02-09 15:10:15.523642+00	cf735gnmxwbdrd885z11f19rbyw	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675955415655	1675955415655	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
aqwxfnfpu9p81zxum4kyy36faso	2023-02-09 15:10:15.523642+00	cjfsfemn88jfx7xutwd7jwfrubo	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675955415660	1675955415660	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
vcqxizj9q6ibjxf4f7wkyrjqzoa	2023-02-09 15:10:15.867257+00	bjbhs6bos3m8zjouf78xceg9nqw	1	view	Board view	{"cardOrder":["cniwb8xwcqtbstbcm3sdfrr854h","cs4qwpzr65fgttd7364dicskanh","c9s78pzbdg3g4jkcdjqahtnfejc","c8utmazns878jtfgtf7exyi9pee","cnobejmb6bf8e3c1w7em5z4pwyh"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["aok6pgecm85qe9k5kcphzoe63ma","aq1dwbf661yx337hjcd5q3sbxwa","ar87yh5xmsswqkxmjq1ipfftfpc","akj3fkmxq7idma55mdt8sqpumyw"],"visiblePropertyIds":["aspaay76a5wrnuhtqgm97tt3rer"]}	1675955415876	1675955415876	0	\N	system		system	b6p46z69w8pdyzd8xyn6mg9xxmr
ceesyxk3sy38tidayxrqw8etwth	2023-02-09 15:10:15.867257+00	bsjd59qtpbf888mqez3ge77domw	1	card	Tight deadline	{"contentOrder":[],"icon":"📅","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"ar87yh5xmsswqkxmjq1ipfftfpc"}}	1675955415882	1675955415882	0	\N	system		system	b6p46z69w8pdyzd8xyn6mg9xxmr
cmptymjj19b8xjdzzksdhuytehy	2023-02-09 15:10:15.867257+00	bsjd59qtpbf888mqez3ge77domw	1	card	Team communication	{"contentOrder":[],"icon":"💬","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"aq1dwbf661yx337hjcd5q3sbxwa"}}	1675955415888	1675955415888	0	\N	system		system	b6p46z69w8pdyzd8xyn6mg9xxmr
cmi544mdhx7yufmibt1cmatep6a	2023-02-09 15:10:15.867257+00	bsjd59qtpbf888mqez3ge77domw	1	card	Reschedule planning meeting	{"contentOrder":[],"icon":"🗓️","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"aok6pgecm85qe9k5kcphzoe63ma"}}	1675955415893	1675955415893	0	\N	system		system	b6p46z69w8pdyzd8xyn6mg9xxmr
c4p4skb74yjgwjc3ke1jd5tekrr	2023-02-09 15:10:15.867257+00	bsjd59qtpbf888mqez3ge77domw	1	card	Schedule more time for testing	{"contentOrder":[],"icon":"🧪","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"akj3fkmxq7idma55mdt8sqpumyw"}}	1675955415899	1675955415899	0	\N	system		system	b6p46z69w8pdyzd8xyn6mg9xxmr
cqngo6k4i4b8pfb9enafb3hwhyw	2023-02-09 15:10:15.867257+00	bsjd59qtpbf888mqez3ge77domw	1	card	Positive user feedback	{"contentOrder":[],"icon":"🥰","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"aq1dwbf661yx337hjcd5q3sbxwa"}}	1675955415904	1675955415904	0	\N	system		system	b6p46z69w8pdyzd8xyn6mg9xxmr
vew7eb6b56fn8mk91duwjxdohar	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	view	Board: Status	{"cardOrder":["cyhsodm36cbdh8q7kxm1j1gr8yw","cm4w7cc3aac6s9jdcujbs4j8f4r","c6egh6cpnj137ixdoitsoxq17oo","cct9u78utsdyotmejbmwwg66ihr","cmft87it1q7yebbd51ij9k65xbw","c9fe77j9qcruxf4itzib7ag6f1c","coup7afjknqnzbdwghiwbsq541w","c5ex1hndz8qyc8gx6ofbfeksftc"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cidz4imnqhir48brz6e8hxhfrhy","filter":{"filters":[],"operation":"and"},"groupById":"50117d52-bcc7-4750-82aa-831a351c44a0","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["8c557f69-b0ed-46ec-83a3-8efab9d47ef5","ec6d2bc5-df2b-4f77-8479-e59ceb039946","849766ba-56a5-48d1-886f-21672f415395",""],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675955416064	1675955416064	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
vdkcaex5b6tfy9gwkffyhczg8dy	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	view	List: Bugs 🐞	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"50117d52-bcc7-4750-82aa-831a351c44a0":145,"__title":280},"defaultTemplateId":"","filter":{"filters":[{"condition":"includes","propertyId":"20717ad3-5741-4416-83f1-6f133fff3d11","values":["1fdbb515-edd2-4af5-80fc-437ed2211a49"]}],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["50117d52-bcc7-4750-82aa-831a351c44a0","20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675955416071	1675955416071	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
7xt8yx9f49jbxbpkhjce5pi5g7o	2023-02-09 15:10:15.990252+00	cyhsodm36cbdh8q7kxm1j1gr8yw	1	image		{"fileId":"77pe9r4ckbin438ph3f18bpatua.png"}	1675955416077	1675955416077	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
aowo8igj7rtnp7mwapij7s3o3xa	2023-02-09 15:10:15.990252+00	cyhsodm36cbdh8q7kxm1j1gr8yw	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675955416085	1675955416085	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
aej4ic8nk8td7zebzhmhfh9wu6y	2023-02-09 15:10:15.990252+00	cyhsodm36cbdh8q7kxm1j1gr8yw	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675955416091	1675955416091	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
a8xtbuofra3yyf8dms1mknwen3r	2023-02-09 15:10:15.990252+00	cxjt8ekj8yfratx83ukjr1nt5dw	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955416097	1675955416097	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
ab6dzethdibbmfpwqwe5hx98pga	2023-02-09 15:10:15.990252+00	cut844cdxxj86xqyrs9ctgecfme	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955416102	1675955416102	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
7nsq6tift1pg43cqxh6ptkf8s4a	2023-02-09 15:10:15.990252+00	cfefgwjke6bbxpjpig618g9bpte	1	image		{"fileId":"7pbp4qg415pbstc6enzeicnu3qh.png"}	1675955416107	1675955416107	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
a7qy7p9y4qbgwim4qheaoyh56se	2023-02-09 15:10:15.990252+00	cfefgwjke6bbxpjpig618g9bpte	1	text	## Screenshots\nIf applicable, add screenshots to elaborate on the problem.	{}	1675955416113	1675955416113	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
asqe7das383fd8bsg6ki5k3j5de	2023-02-09 15:10:15.990252+00	cfefgwjke6bbxpjpig618g9bpte	1	text	## Steps to reproduce the behavior\n\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n\nA clear and concise description of what you expected to happen.\n\n## Edition and Platform\n\n - Edition: Personal Desktop / Personal Server / Mattermost plugin\n - Version: [e.g. v0.9.0]\n - Browser and OS: [e.g. Chrome 91 on macOS, Edge 93 on Windows]\n\n## Additional context\n\nAdd any other context about the problem here.	{}	1675955416119	1675955416119	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
agsg7r9qcppnjmbm4io1zxkqpfe	2023-02-09 15:10:15.990252+00	cfefgwjke6bbxpjpig618g9bpte	1	text	## Steps to reproduce the behavior\n\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n\n*[A clear and concise description of what you expected to happen.]*\n\n## Screenshots\n\n*[If applicable, add screenshots to elaborate on the problem.]*\n\n## Edition and Platform\n\n - Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n - Version: *[e.g. v0.9.0]*\n - Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n\n*[Add any other context about the problem here.]*	{}	1675955416123	1675955416123	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
a66nc7e11k78e9gm4hfude4z6dr	2023-02-09 15:10:15.990252+00	ccoro58a94idw8mdo9k5rx3dx4h	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955416128	1675955416128	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
a1dihou959jr7trof8zpknymz3h	2023-02-09 15:10:15.990252+00	cidz4imnqhir48brz6e8hxhfrhy	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955416134	1675955416134	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
ahbfddu6t6i8mzmtsdmedda4tgh	2023-02-09 15:10:15.990252+00	cidz4imnqhir48brz6e8hxhfrhy	1	text	## Requirements\n- [Requirement 1]\n- [Requirement 2]\n- ...	{}	1675955416138	1675955416138	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
afw5i81na7id4jfw1wzb1qc7o6e	2023-02-09 15:10:15.990252+00	c13uy7qkt57gapqc3qp61bhyjqr	1	text	## Summary\n*[Brief description of what this epic is about]*\n\n## Motivation\n*[Brief description on why this is needed]*\n\n## Acceptance Criteria\n - *[Criteron 1]*\n - *[Criteron 2]*\n - ...\n\n## Personas\n - *[Persona A]*\n - *[Persona B]*\n - ...\n\n## Reference Materials\n - *[Links to other relevant documents as needed]*\n - ...	{}	1675955416144	1675955416144	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
7csaz76fn9fgabquxp54stmjbne	2023-02-09 15:10:15.990252+00	czwsifj8cm7fabf6asnhc8fugho	1	image		{"fileId":"7pbp4qg415pbstc6enzeicnu3qh.png"}	1675955416149	1675955416149	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
am796mc4hafgy7dc95e41hwfrmw	2023-02-09 15:10:15.990252+00	czwsifj8cm7fabf6asnhc8fugho	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675955416154	1675955416154	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
7nsow3b1arbrnzmjybgu9axwtte	2023-02-09 15:10:16.551755+00	crkth4zwoppf6me17xb1sf7m7wr	1	image		{"fileId":"7iw4rxx7jj7bypmdotd9z469cyh.png"}	1675955416743	1675955416743	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
aszhiqtytuty4888t8dii87td1w	2023-02-09 15:10:15.990252+00	cwrq9ag3p5pgzzy98nfd3wwra1w	1	text	## Summary\n[Brief description of what this epic is about]\n\n## Motivation\n[Brief description on why this is needed]\n\n## Acceptance Criteria\n - [Criteron 1]\n - [Criteron 2]\n - ...\n\n## Personas\n - [Persona A]\n - [Persona B]\n - ...\n\n## Reference Materials\n - [Links to other relevant documents as needed]\n - ...	{}	1675955416179	1675955416179	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
c5wz7jz8at3gx8brn8jcz7u3ujh	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Drag cards	{"contentOrder":["apktbgtee5jb8xrnqy3ibiujxew","aanpn1chdbirddfu4obqi3rieew"],"icon":"🤏","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#dragging-cards","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1675955416560	1675955416560	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
c561c93bfjjyp7gsda4qk6d9dca	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Manage tasks with cards	{"contentOrder":["azz8hdz4357fq8fwghbqz7e88ww","71wbc54cp57yw5x84ih1u7b3bxw","7zudf4ytye3y69dtwtfkagbi7zh","784uu3ufcgb878ky7hyugmf6xcw","7kc44wypp1jnzmm3qh7ocx3t69e","7w4sjknti5pyd5kbkpoba1tkf8h","7gr65cgf58bgzmfun9odcmk14hr","7nb8y7jyoetro8cd36qcju53z8c","7413u4xnrebnf5gypfbzc3yokce","7htefhgxktin4fnfcac7ncuty3a","76nwb9tqfsid5jx46yw34itqima","7dy3mcgzgybf1ifa3emgewkzj7e","a5ca6tii33bfw8ba36y1rswq3he","7876od6xhffr6fy69zeogag7eyw","7x7bq9awkatbm5x4docbh5gaw4y","7ghpx9qff43dgtke1rwidmge1ho","7nb8y7jyoetro8cd36qcju53z8c","7hdyxemhbytfm3m83g88djq9nhr","7pgnejxokubbe9kdrxj6g9qa41e","7hw9z6qtx8jyizkmm9g5yq3gxcy","7gk6ooz6npbb8by5rgp9aig7tua","7ny8o9rq7e3rsbyoogjmgetgspa"],"icon":"☑️","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"amm6wfhnbuxojwssyftgs9dipqe","acypkejeb5yfujhj9te57p9kaxw":"aanaehcw3m13jytujsjk5hpf6ry"}}	1675955416566	1675955416566	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
ct5kpq5rgqidtik98waz1m5fdqo	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Create your own board	{"contentOrder":["at1gc3nj44pfmtchdhm463rsugr","atkhpnbj8qjgyzyac48o36u4xpw","7r9my1yuddbn45dojrfht3neg8c","7eir5gdjxgjbsxpbyp3df4npcze","7qp41kosg67bkbppoqt1c64yu6h"],"icon":"📋","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#adding-new-boards","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"amm6wfhnbuxojwssyftgs9dipqe","acypkejeb5yfujhj9te57p9kaxw":"aanaehcw3m13jytujsjk5hpf6ry"}}	1675955416570	1675955416570	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
chwbzoteop38obrffjnbye8kkph	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Share a board	{"contentOrder":["aj9qonaknubbcjc3txbjxqo5y7a","aqop7km57rpnpmfg6mro767ukaa","7r7asyew8d7fyunf4sow8e5iyoc","ad8j3n8tp77bppee3ipjt6odgpe","7w935usqt6pby8qz9x5pxaj7iow","7ogbs8h6q4j8z7ngy1m7eag63nw","7z1jau5qy3jfcxdp5cgq3duk6ne","7j9bhj4sh8iytxpnu1o1gpfyh6o"],"icon":"📤","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/sharing-boards.html","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1675955416574	1675955416574	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
crkth4zwoppf6me17xb1sf7m7wr	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Create a new card	{"contentOrder":["aogf1khixcifedyhnnxb8y5cs9a","adhsx4h5ss7rqdcjt8xyam6xtqc","a1enn3jnusffjuc4ciqrfc197fr","7me9p46gbqiyfmfnapi7dyxb5br","7nsow3b1arbrnzmjybgu9axwtte"],"icon":"📝","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#adding-cards","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"amm6wfhnbuxojwssyftgs9dipqe","acypkejeb5yfujhj9te57p9kaxw":"aanaehcw3m13jytujsjk5hpf6ry"}}	1675955416580	1675955416579	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
cafahsprdajymd83b1dzr4sj91w	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Share cards on Channels	{"contentOrder":["akr4w845sp3dgty4cayg6wrz96a","ai4qtbj8quiywfxdrorts7dsf3h","aoe9xan7bat8imn45t4x4knq11e","7egzqwfr9n3gqjq6yrs9powrjby"],"icon":"📮","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html#share-card-previews","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"af3p8ztcyxgn8wd9z4az7o9tjeh","acypkejeb5yfujhj9te57p9kaxw":"ascd7nm9r491ayot8i86g1gmgqw"}}	1675955416595	1675955416595	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
copdhfsz6e3gg3yqcofmw7uc8ah	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Filter and sort cards	{"contentOrder":["a4fz9kcfs9ibj8puk9mux7ac94c","ac97q9macgtgg8nawsmwyhsbwca","78i8aqjmqtibr7x4okhz6uqquqr","714ymz3mujfdi9c1u56g5hsw8bh"],"icon":"🎛️","isTemplate":false,"properties":{"a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1675955416605	1675955416605	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
cdy86cwon13n85k1498uqgckjmo	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Create a new view	{"contentOrder":["aozbezukpgif3jpbsq7tahmmp5e","agzxxkj19tfd5zxwje151ma8d4w","7owai1ux3h3gtf8byynfk6hyx1c","7n8jq1dizyfgotby3o91arf1hxh","77y4wffj1ctg7xmm9bx45qn6q6o","7xbpdkw5rdtgfjrajorxz9z1m5a"],"icon":"👓","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#adding-new-views","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"af3p8ztcyxgn8wd9z4az7o9tjeh","acypkejeb5yfujhj9te57p9kaxw":"ascd7nm9r491ayot8i86g1gmgqw"}}	1675955416610	1675955416610	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
ccosx7u14o3b9bngcrskhb59umo	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Add new properties	{"contentOrder":["aaj9oncuimtfeigzof3jn3j1kka","ayhk11qsuz789fk8bqae4oz8mro","7gc3z8cf8rirgfyutwoke9nn6jy","76cinqnb6k3dzmfbm9fnc8eofny","7u7omjjrqmpfwzghn1jsa4ha47w"],"icon":"🏷️","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html#add-and-manage-properties","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"af3p8ztcyxgn8wd9z4az7o9tjeh","acypkejeb5yfujhj9te57p9kaxw":"ascd7nm9r491ayot8i86g1gmgqw"}}	1675955416615	1675955416615	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
cd1hudbdx63dt7mym7hxee6kzrc	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	@mention teammates	{"contentOrder":["ay7zz768zs7gb5e1h8qximpwq9a","an3ts498ri7bwffx31agx89zzuw","7mbw9t71hjbrydgzgkqqaoh8usr","7ttgph9jfotfxzphrb1wmyjzw1c"],"icon":"🔔","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html#mention-people","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1675955416619	1675955416619	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
a1enn3jnusffjuc4ciqrfc197fr	2023-02-09 15:10:16.551755+00	crkth4zwoppf6me17xb1sf7m7wr	1	text	To create a new card, simply do any of the following:\n- Select "**New**" on the top right header\n- Select "**+ New**" below any column\n- Select "**+**" to the right of any columnn header	{}	1675955416748	1675955416748	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
vknytio9am3r1ip5xkn179ymuac	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	view	Preview: Table View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":280,"a972dc7a-5f4c-45d2-8044-8c28c69717f1":100,"acypkejeb5yfujhj9te57p9kaxw":169},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a972dc7a-5f4c-45d2-8044-8c28c69717f1","aqh13jabwexjkzr3jqsz1i1syew","acmg7mz1rr1eykfug4hcdpb1y1o","acypkejeb5yfujhj9te57p9kaxw"]}	1675955416625	1675955416625	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
vprztdsecdb888pw11kzogsysde	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	view	Preview: Calendar View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"acmg7mz1rr1eykfug4hcdpb1y1o","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955416633	1675955416633	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
vyc7c3kwj6ibn7y8cr6rqwdtjwo	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	view	Preview: Gallery View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"gallery","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955416640	1675955416640	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
vuiygiikw4bywbyxto8n4ekg8gh	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	view	Onboarding	{"cardOrder":["crkth4zwoppf6me17xb1sf7m7wr","c561c93bfjjyp7gsda4qk6d9dca","ct5kpq5rgqidtik98waz1m5fdqo","cafahsprdajymd83b1dzr4sj91w","ccosx7u14o3b9bngcrskhb59umo","cdy86cwon13n85k1498uqgckjmo","cd1hudbdx63dt7mym7hxee6kzrc","c5wz7jz8at3gx8brn8jcz7u3ujh","chwbzoteop38obrffjnbye8kkph","copdhfsz6e3gg3yqcofmw7uc8ah"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a972dc7a-5f4c-45d2-8044-8c28c69717f1","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["aqb5x3pt87dcc9stbk4ofodrpoy","a1mtm777bkagq3iuu7xo9b13qfr","auxbwzptiqzkii5r61uz3ndsy1r","aj9386k1bx8qwmepeuxg3b7z4pw"],"visiblePropertyIds":[]}	1675955416646	1675955416646	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
aanpn1chdbirddfu4obqi3rieew	2023-02-09 15:10:16.551755+00	c5wz7jz8at3gx8brn8jcz7u3ujh	1	text	Mattermost Boards makes it easy for you to update certain properties on cards through our drag and drop functionality. Simply drag this card from the **Later** column to the **Completed** column to automatically update the status and mark this task as complete.	{}	1675955416652	1675955416652	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7kc44wypp1jnzmm3qh7ocx3t69e	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	Assign tasks to teammates	{"value":false}	1675955416657	1675955416657	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7ny8o9rq7e3rsbyoogjmgetgspa	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	Create and manage checklists, like this one... :)	{"value":false}	1675955416664	1675955416664	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7w4sjknti5pyd5kbkpoba1tkf8h	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	Add and update descriptions with Markdown	{"value":false}	1675955416670	1675955416670	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7413u4xnrebnf5gypfbzc3yokce	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	Follow cards to get notified on the latest updates	{"value":false}	1675955416675	1675955416675	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
71wbc54cp57yw5x84ih1u7b3bxw	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	Set priorities and update statuses	{"value":false}	1675955416681	1675955416681	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7gr65cgf58bgzmfun9odcmk14hr	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	Provide feedback and ask questions via comments	{"value":false}	1675955416687	1675955416687	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7htefhgxktin4fnfcac7ncuty3a	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	@mention teammates so they can follow, and collaborate on, comments and descriptions	{"value":false}	1675955416693	1675955416693	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7zudf4ytye3y69dtwtfkagbi7zh	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	Manage deadlines and milestones	{"value":false}	1675955416701	1675955416700	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
azz8hdz4357fq8fwghbqz7e88ww	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	text	Cards allow your entire team to manage and collaborate on a task in one place. Within a card, your team can:	{}	1675955416707	1675955416707	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7qp41kosg67bkbppoqt1c64yu6h	2023-02-09 15:10:16.551755+00	ct5kpq5rgqidtik98waz1m5fdqo	1	image		{"fileId":"74uia99m9btr8peydw7oexn37tw.gif"}	1675955416713	1675955416713	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
at1gc3nj44pfmtchdhm463rsugr	2023-02-09 15:10:16.551755+00	ct5kpq5rgqidtik98waz1m5fdqo	1	text	A board helps you manage your project, organize tasks, and collaborate with your team all in one place.	{}	1675955416717	1675955416717	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
atkhpnbj8qjgyzyac48o36u4xpw	2023-02-09 15:10:16.551755+00	ct5kpq5rgqidtik98waz1m5fdqo	1	text	To create your own board, select the "+" on the top of the left hand sidebar. Choose from one of our standard templates and see how they can help you get started with your next project:\n\n- **Project Tasks**: Stay on top of your project tasks, track progress, and set priorities. \n- **Meeting Agenda**: Set your meeting agendas for recurring team meetings and 1:1s.\n- **Roadmap**: Plan your roadmap and manage your releases more efficiently.\n- **Personal Tasks**: Organize your life and track your personal tasks.\n- **Content Calendar**: Plan your editorial content, assign work, and track deadlines.\n- **Personal Goals**: Set and accomplish new personal goals and milestones.	{}	1675955416722	1675955416722	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7j9bhj4sh8iytxpnu1o1gpfyh6o	2023-02-09 15:10:16.551755+00	chwbzoteop38obrffjnbye8kkph	1	image		{"fileId":"7knxbyuiedtdafcgmropgkrtybr.gif"}	1675955416728	1675955416728	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
aj9qonaknubbcjc3txbjxqo5y7a	2023-02-09 15:10:16.551755+00	chwbzoteop38obrffjnbye8kkph	1	text	Keep stakeholders and customers up-to-date on project progress by sharing your board.	{}	1675955416733	1675955416733	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
aqop7km57rpnpmfg6mro767ukaa	2023-02-09 15:10:16.551755+00	chwbzoteop38obrffjnbye8kkph	1	text	To share a board, select **Share** at the top right of the Board view. Copy the link to share the board internally with your team or generate public link that can be accessed by anyone externally.	{}	1675955416738	1675955416738	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
aoe9xan7bat8imn45t4x4knq11e	2023-02-09 15:10:16.551755+00	cafahsprdajymd83b1dzr4sj91w	1	text	After you've copied the link, paste it into any channel or Direct Message to share the card. A preview of the card will display within the channel with a link back to the card on Boards.	{}	1675955416760	1675955416760	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
ai4qtbj8quiywfxdrorts7dsf3h	2023-02-09 15:10:16.551755+00	cafahsprdajymd83b1dzr4sj91w	1	text	To share a card, you'll need to copy the card link first. You can:\n\n- Open a card and select the options menu button at the top right of the card.\n- Open the board view and hover your mouse over any card to access the options menu button.	{}	1675955416765	1675955416765	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
akr4w845sp3dgty4cayg6wrz96a	2023-02-09 15:10:16.551755+00	cafahsprdajymd83b1dzr4sj91w	1	text	Cards can be linked and shared with teammates directly on Channels. Card previews are displayed when shared on Channels, so your team can discuss work items and get the relevant context without having to switch over to Boards.	{}	1675955416769	1675955416769	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
714ymz3mujfdi9c1u56g5hsw8bh	2023-02-09 15:10:16.551755+00	copdhfsz6e3gg3yqcofmw7uc8ah	1	image		{"fileId":"7dybb6t8fj3nrdft7nerhuf784y.png"}	1675955416774	1675955416774	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
ac97q9macgtgg8nawsmwyhsbwca	2023-02-09 15:10:16.551755+00	copdhfsz6e3gg3yqcofmw7uc8ah	1	text	Organize and find the cards you're looking for with our filter, sort, and grouping options. From the Board header, you can quickly toggle on different properties, change the group display, set filters, and change how the cards are sorted.	{}	1675955416779	1675955416779	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7xbpdkw5rdtgfjrajorxz9z1m5a	2023-02-09 15:10:16.551755+00	cdy86cwon13n85k1498uqgckjmo	1	image		{"fileId":"78jws5m1myf8pufewzkaa6i11sc.gif"}	1675955416783	1675955416783	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
agzxxkj19tfd5zxwje151ma8d4w	2023-02-09 15:10:16.551755+00	cdy86cwon13n85k1498uqgckjmo	1	text	Views allow your team to visualize the same cards and data from different perspectives, so they can stay up-to-date in the way that works best for them. To add a new view, go to **Add a new view** from the view drop-down, then select from any of the following views:\n\n- **Board**: Adds a Kanban board, similar to this one, that allows your team to organize cards in swimlanes grouped by any property of your choosing. This view helps you visualize your project progress.\n- **Table**: Displays cards in a table format with rows and columns. Use this view to get an overview of all your project tasks. Easily view and compare the state of all properties across all cards without needing to open individual cards.\n- **Gallery**: Displays cards in a gallery format, so you can manage and organize cards with image attachments.\n- **Calendar**: Adds a calendar view to easily visualize your cards by dates and keep track of deadlines.	{}	1675955416786	1675955416786	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7u7omjjrqmpfwzghn1jsa4ha47w	2023-02-09 15:10:16.551755+00	ccosx7u14o3b9bngcrskhb59umo	1	image		{"fileId":"7d6hrtig3zt8f9cnbo1um5oxx3y.gif"}	1675955416790	1675955416790	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
aaj9oncuimtfeigzof3jn3j1kka	2023-02-09 15:10:16.551755+00	ccosx7u14o3b9bngcrskhb59umo	1	text	Customize cards to fit your needs and track the information most important to you. Boards supports a wide range of fully customizable property types. For example, you can:\n- Use the **Date** property for things like deadlines or milestones.\n- Assign owners to tasks with the **Person** property.\n- Define statuses and priorities with the **Select** property.\n- Create tags with the **Multi Select** property.\n- Link cards to webpages with the **URL** property.	{}	1675955416794	1675955416794	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7ttgph9jfotfxzphrb1wmyjzw1c	2023-02-09 15:10:16.551755+00	cd1hudbdx63dt7mym7hxee6kzrc	1	image		{"fileId":"74nt9eqzea3ydjjpgjtsxcjgrxc.gif"}	1675955416799	1675955416799	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
an3ts498ri7bwffx31agx89zzuw	2023-02-09 15:10:16.551755+00	cd1hudbdx63dt7mym7hxee6kzrc	1	text	To mention a teammate use the **@ symbol with their username** in the comments or description section. They'll get a Direct Message notification via Channels and also be added as a [follower](https://docs.mattermost.com/boards/work-with-cards.html#receive-updates) to the card. \n\nWhenever any changes are made to the card, they'll automatically get notified on Channels.	{}	1675955416803	1675955416803	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
ay7zz768zs7gb5e1h8qximpwq9a	2023-02-09 15:10:16.551755+00	cd1hudbdx63dt7mym7hxee6kzrc	1	text	Collaborate with teammates directly on each card using @mentions and have all the relevant context in one place.	{}	1675955416807	1675955416807	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
\.


--
-- Data for Name: focalboard_blocks_history; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_blocks_history (id, insert_at, parent_id, schema, type, title, fields, create_at, update_at, delete_at, root_id, modified_by, channel_id, created_by, board_id) FROM stdin;
czebhwzawapy55jy4qxmozzo4cr	2023-02-09 15:10:10.121663+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Team Schedule	{"contentOrder":["axpbptk9grbrhzdq9rodcqgomra","7dzinn6e9fpri3chki7e71xs8yh","ayarazd7asb8ozkksuxy5351aqh","7196jqjcy8jn7bmsod7ythqpamw","7omaahugkcfdhp8xohiy1d7iniy","7pwy6b4y9qtde9mayz9t576wzbo"],"icon":"⏰","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"8b05c83e-a44a-4d04-831e-97f01d8e2003","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"34eb9c25-d5bf-49d9-859e-f74f4e0030e7"}}	1675955410132	1675955410132	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
caaryyfj35iyo9q7ukein9jiu4e	2023-02-09 15:10:10.121663+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Video production	{"contentOrder":["aiwph7zdhpjbombd49uom6p5qxy","7yd3axyrhzbyh3x9qozk5qtbsrh","ai93zq6uonfrf7gjibrwatofmiy","79u5d4yzqdjg65qgcpwbmob9fzo","7eqriuxcf87dh9frg5aiuc1bp9r","7hhgoyez5etb7mpptkrdq75dghe"],"icon":"📹","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"b1abafbf-a038-4a19-8b68-56e0fd2319f7","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"34eb9c25-d5bf-49d9-859e-f74f4e0030e7"}}	1675955410138	1675955410138	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
ctor6xdeexffg8xzqd76prxk1ge	2023-02-09 15:10:10.121663+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Offsite plans	{"contentOrder":["awjd7cdpaobfi7yofwb76szzdjw","7wgktjf58itbeddwexf15wbg59a","adc9tusigjj8rzqxbfo7s7uko6a","7hncbmdr4jpng3xb44yth4mmwma","7zcg6yc1dyjbwi8nys6916knsse","797gc7kuqubggbbth9tjb394r5c"],"icon":"🚙","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"8b05c83e-a44a-4d04-831e-97f01d8e2003","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"dabadd9b-adf1-4d9f-8702-805ac6cef602"}}	1675955410145	1675955410145	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
cbpyozo5n738dmq36auszr7twty	2023-02-09 15:10:10.121663+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Social Media Strategy	{"contentOrder":["a7nrc4e58m3ru5puz4wswn1trdc","7dqzit6ec5t8ubbnf5pzarpuuja","aoudetcozh3yfmkqkq3cyhp9d8w","7xz74uk3bt3fu9y6spr7s69f8cc","7pbnkbqkjipb47cjxptp91ppz4c","7bqzsshop3pg9mka4h1tspz8ity"],"icon":"🎉","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"b1abafbf-a038-4a19-8b68-56e0fd2319f7","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"d37a61f4-f332-4db9-8b2d-5e0a91aa20ed"}}	1675955410150	1675955410150	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
vkngsehpzdbf47g6pgp9fxz4o7a	2023-02-09 15:10:10.121663+00	b7wnw9awd4pnefryhq51apbzb4c	1	view	Discussion Items	{"cardOrder":["cjpkiya33qsagr4f9hrdwhgiajc"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"d777ba3b-8728-40d1-87a6-59406bbbbfb0","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[{"propertyId":"4cf1568d-530f-4028-8ffd-bdc65249187e","reversed":false}],"viewType":"board","visibleOptionIds":[],"visiblePropertyIds":["4cf1568d-530f-4028-8ffd-bdc65249187e"]}	1675955410157	1675955410157	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7omaahugkcfdhp8xohiy1d7iniy	2023-02-09 15:10:10.121663+00	czebhwzawapy55jy4qxmozzo4cr	1	checkbox		{"value":false}	1675955410167	1675955410167	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7196jqjcy8jn7bmsod7ythqpamw	2023-02-09 15:10:10.121663+00	czebhwzawapy55jy4qxmozzo4cr	1	checkbox		{"value":false}	1675955410172	1675955410172	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7dzinn6e9fpri3chki7e71xs8yh	2023-02-09 15:10:10.121663+00	czebhwzawapy55jy4qxmozzo4cr	1	divider		{}	1675955410176	1675955410175	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7pwy6b4y9qtde9mayz9t576wzbo	2023-02-09 15:10:10.121663+00	czebhwzawapy55jy4qxmozzo4cr	1	checkbox		{"value":false}	1675955410178	1675955410178	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
axpbptk9grbrhzdq9rodcqgomra	2023-02-09 15:10:10.121663+00	czebhwzawapy55jy4qxmozzo4cr	1	text	## Notes\n*[Add meeting notes here]*	{}	1675955410181	1675955410181	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
ayarazd7asb8ozkksuxy5351aqh	2023-02-09 15:10:10.121663+00	czebhwzawapy55jy4qxmozzo4cr	1	text	## Action Items	{}	1675955410183	1675955410183	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7o4rz1o44gbf4zepkb4sqrmhwce	2023-02-09 15:10:10.121663+00	ch798q5ucefyobf5bymgqjt4f3h	1	divider		{}	1675955410188	1675955410187	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7pyuztkwto3b6irhdu7jcusoeqh	2023-02-09 15:10:10.121663+00	ch798q5ucefyobf5bymgqjt4f3h	1	checkbox		{"value":false}	1675955410196	1675955410196	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7f1qymriaetf8fyqb6b88hn6syy	2023-02-09 15:10:10.121663+00	ch798q5ucefyobf5bymgqjt4f3h	1	checkbox		{"value":false}	1675955410211	1675955410211	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
74g7zukwfhjgcfpugf4hxqcostc	2023-02-09 15:10:10.121663+00	ch798q5ucefyobf5bymgqjt4f3h	1	checkbox		{"value":false}	1675955410221	1675955410221	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
a5gpne7xtsjr37d8xxgu93bpyay	2023-02-09 15:10:10.121663+00	ch798q5ucefyobf5bymgqjt4f3h	1	text	# Action Items	{}	1675955410243	1675955410243	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
afoajfa1w4brjbq3wpmguh61w7w	2023-02-09 15:10:10.121663+00	ch798q5ucefyobf5bymgqjt4f3h	1	text	# Notes\n*[Add meeting notes here]*	{}	1675955410251	1675955410251	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7yd3axyrhzbyh3x9qozk5qtbsrh	2023-02-09 15:10:10.121663+00	caaryyfj35iyo9q7ukein9jiu4e	1	divider		{}	1675955410258	1675955410258	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7hhgoyez5etb7mpptkrdq75dghe	2023-02-09 15:10:10.121663+00	caaryyfj35iyo9q7ukein9jiu4e	1	checkbox		{"value":false}	1675955410264	1675955410264	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7eqriuxcf87dh9frg5aiuc1bp9r	2023-02-09 15:10:10.121663+00	caaryyfj35iyo9q7ukein9jiu4e	1	checkbox		{"value":false}	1675955410268	1675955410268	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
79u5d4yzqdjg65qgcpwbmob9fzo	2023-02-09 15:10:10.121663+00	caaryyfj35iyo9q7ukein9jiu4e	1	checkbox		{"value":false}	1675955410273	1675955410273	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
ai93zq6uonfrf7gjibrwatofmiy	2023-02-09 15:10:10.121663+00	caaryyfj35iyo9q7ukein9jiu4e	1	text	## Action Items	{}	1675955410277	1675955410277	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
aiwph7zdhpjbombd49uom6p5qxy	2023-02-09 15:10:10.121663+00	caaryyfj35iyo9q7ukein9jiu4e	1	text	## Notes\n*[Add meeting notes here]*	{}	1675955410283	1675955410283	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7hncbmdr4jpng3xb44yth4mmwma	2023-02-09 15:10:10.121663+00	ctor6xdeexffg8xzqd76prxk1ge	1	checkbox		{"value":false}	1675955410289	1675955410289	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7zcg6yc1dyjbwi8nys6916knsse	2023-02-09 15:10:10.121663+00	ctor6xdeexffg8xzqd76prxk1ge	1	checkbox		{"value":false}	1675955410297	1675955410296	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7wgktjf58itbeddwexf15wbg59a	2023-02-09 15:10:10.121663+00	ctor6xdeexffg8xzqd76prxk1ge	1	divider		{}	1675955410303	1675955410302	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
797gc7kuqubggbbth9tjb394r5c	2023-02-09 15:10:10.121663+00	ctor6xdeexffg8xzqd76prxk1ge	1	checkbox		{"value":false}	1675955410309	1675955410309	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
adc9tusigjj8rzqxbfo7s7uko6a	2023-02-09 15:10:10.121663+00	ctor6xdeexffg8xzqd76prxk1ge	1	text	## Action Items	{}	1675955410314	1675955410314	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
awjd7cdpaobfi7yofwb76szzdjw	2023-02-09 15:10:10.121663+00	ctor6xdeexffg8xzqd76prxk1ge	1	text	## Notes\n*[Add meeting notes here]*	{}	1675955410320	1675955410320	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7dqzit6ec5t8ubbnf5pzarpuuja	2023-02-09 15:10:10.121663+00	cbpyozo5n738dmq36auszr7twty	1	divider		{}	1675955410326	1675955410326	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7pbnkbqkjipb47cjxptp91ppz4c	2023-02-09 15:10:10.121663+00	cbpyozo5n738dmq36auszr7twty	1	checkbox		{"value":false}	1675955410331	1675955410331	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7bqzsshop3pg9mka4h1tspz8ity	2023-02-09 15:10:10.121663+00	cbpyozo5n738dmq36auszr7twty	1	checkbox		{"value":false}	1675955410339	1675955410339	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7xz74uk3bt3fu9y6spr7s69f8cc	2023-02-09 15:10:10.121663+00	cbpyozo5n738dmq36auszr7twty	1	checkbox		{"value":false}	1675955410359	1675955410359	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
aoudetcozh3yfmkqkq3cyhp9d8w	2023-02-09 15:10:10.121663+00	cbpyozo5n738dmq36auszr7twty	1	text	## Action Items	{}	1675955410371	1675955410371	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
a7nrc4e58m3ru5puz4wswn1trdc	2023-02-09 15:10:10.121663+00	cbpyozo5n738dmq36auszr7twty	1	text	## Notes\n*[Add meeting notes here]*	{}	1675955410400	1675955410400	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
vk8bc997m1bysubqa9zzpuikwmo	2023-02-09 15:10:10.921795+00		1	view	All Contacts	{"cardOrder":["c7n4qjbom77g5mxhapf6tmtcidw","cirqnetz9uf8ebpfrq68dx7sj1o","czb14t4y4gbf15ehgi9kpj6hyey","c71eyc8srz7gazgtp3hafyys1ba","c45s8knkw1jf79mfpkh4k1w39ko"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":240,"a1438fbbhjeffkexmcfhnx99o1h":151,"a5hwxjsmkn6bak6r7uea5bx1kwc":132,"abru6tz8uebdxy4skheqidh7zxy":247,"adtf1151chornmihz4xbgbk9exa":125,"aejo5tcmq54bauuueem9wc4fw4y":127,"ahf43e44h3y8ftanqgzno9z7q7w":129,"ainpw47babwkpyj77ic4b9zq9xr":157,"amahgyn9n4twaapg3jyxb6y4jic":224,"amba7ot98fh7hwsx8jdcfst5g7h":171,"aoheuj1f3mu6eehygr45fxa144y":130,"auhf91pm85f73swwidi4wid8jqe":157},"defaultTemplateId":"cxarr4qdxsi8u9jak7cc3yeikuh","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a5hwxjsmkn6bak6r7uea5bx1kwc","aoheuj1f3mu6eehygr45fxa144y","aro91wme9kfaie5ceu9qasmtcnw","ainpw47babwkpyj77ic4b9zq9xr","ahf43e44h3y8ftanqgzno9z7q7w","amahgyn9n4twaapg3jyxb6y4jic","abru6tz8uebdxy4skheqidh7zxy","a1438fbbhjeffkexmcfhnx99o1h","auhf91pm85f73swwidi4wid8jqe","adtf1151chornmihz4xbgbk9exa","aejo5tcmq54bauuueem9wc4fw4y","amba7ot98fh7hwsx8jdcfst5g7h"]}	1675955410931	1675955410931	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
vcaht3fzu1p8czftchjwej9zdbh	2023-02-09 15:10:10.921795+00		1	view	Pipeline Tracker	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["akj61wc9yxdwyw3t6m8igyf9d5o","aic89a5xox4wbppi6mbyx6ujsda","ah6ehh43rwj88jy4awensin8pcw","aprhd96zwi34o9cs4xyr3o9sf3c","axesd74yuxtbmw1sbk8ufax7z3a","a5txuiubumsmrs8gsd5jz5gc1oa","acm9q494bcthyoqzmfogxxy5czy"],"visiblePropertyIds":["aro91wme9kfaie5ceu9qasmtcnw","amahgyn9n4twaapg3jyxb6y4jic"]}	1675955410934	1675955410934	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
c71eyc8srz7gazgtp3hafyys1ba	2023-02-09 15:10:10.921795+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Jonathan Frazier	{"contentOrder":["akf5xjt9byinzfkeos6r6px8jbw","askua4mi95jy8bchwhybg8gfcse","7zu87byt3etrfjj4if6i7o9f5zw","7kwnrbo5c43gfjnpdoygghmfz5y","7n61tdes8updx7dgk4g1qmkqbnh","7iy8rn8s9ubdhxb9w43e5fmhuwh","7gx593y1kpif75xkrho74839yne","7kx16rigxffr9bezsar6dxammny","7uwrwbb9sa38j8d95d4ww8mypdw","7afgp343sijrc7gonf9qoy7556y","71gqjf96497fi9ryke93twwe7xh","77iiwbg3iufbkjp39xbytusm7fy"],"icon":"🙎‍♂️","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(999) 123-5678","a5hwxjsmkn6bak6r7uea5bx1kwc":"a5txuiubumsmrs8gsd5jz5gc1oa","abru6tz8uebdxy4skheqidh7zxy":"jonathan.frazier@email.com","aejo5tcmq54bauuueem9wc4fw4y":"0%","ahf43e44h3y8ftanqgzno9z7q7w":"$800,000","ainpw47babwkpyj77ic4b9zq9xr":"Ositions Inc.","amahgyn9n4twaapg3jyxb6y4jic":"as5bk6afoaaa7caewe1zc391sce","aro91wme9kfaie5ceu9qasmtcnw":"apiswzj7uiwbh87z8dw8c6mturw","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1669118400000}"}}	1675955410936	1675955410936	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
czb14t4y4gbf15ehgi9kpj6hyey	2023-02-09 15:10:10.921795+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Richard Guzman	{"contentOrder":["afdi9nuij83bz9ywhkjsyorsika","ap8htxxgcnpgaxka4s11df59y5c","7cwxpmkp8d3y78e5t4t8aizh9ac","7f6prgh7etidefktxjadakro7de","79by87rm9i3ngfk95wxr4hcu8mw","7p31k115qpbyo5fefdqbwceunfo","7dizabc4pu78y8kknah8pckrpgw","7e8a3i33n8jnujrhb9im4u3f3bc","7pobi5s6iq3dhbktgrootac1h4h","73wnuh3ums7grtb58as6qdu1s7r","7czs3x5g5o7godjj9nwpmnc6dye","76fuqbbtu8pywjqqj1hgg4q9e8e"],"icon":"👨‍💼","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(222) 123-1234","a5hwxjsmkn6bak6r7uea5bx1kwc":"axesd74yuxtbmw1sbk8ufax7z3a","abru6tz8uebdxy4skheqidh7zxy":"richard.guzman@email.com","adtf1151chornmihz4xbgbk9exa":"{\\"from\\":1681992000000}","aejo5tcmq54bauuueem9wc4fw4y":"80%","ahf43e44h3y8ftanqgzno9z7q7w":"$3,200,000","ainpw47babwkpyj77ic4b9zq9xr":"Afformance Ltd.","amahgyn9n4twaapg3jyxb6y4jic":"ar6t1ttcumgfuqugg5o4g4mzrza","aro91wme9kfaie5ceu9qasmtcnw":"apjnaggwixchfxwiatfh7ey7uno","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1667476800000}"}}	1675955410940	1675955410940	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
c45s8knkw1jf79mfpkh4k1w39ko	2023-02-09 15:10:10.921795+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Byron Cole	{"contentOrder":["atyt9edm39tbtbnjddx5rt8mmda","a98wh64rrxtyumdfmo5dim8wikr","7pa48ejem6p8stdqhbbicqjj7cy","714ghubqyrpgd7nw34mh31ug79c","7i9im8g6b17nizpis19mmnn9ckh","78wczgiecq7dkjbau9r54izny9w","7n4b867c94tyymfg16gwoqj94fe","7fymoo4ywy3yg5gyh91ijm1tmuw","77p9joh3ajpg1tr6b385zidjbge","7164ftmhpnfdwu8gy3icogzpa8o","7w4tgym95obnjp8smfskq9iypcc","7bwix7j583irsdmre8a3ttqy31e"],"icon":"🤵","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(333) 123-1234","a5hwxjsmkn6bak6r7uea5bx1kwc":"acm9q494bcthyoqzmfogxxy5czy","abru6tz8uebdxy4skheqidh7zxy":"byron.cole@email.com","adtf1151chornmihz4xbgbk9exa":"{\\"from\\":1667563200000}","aejo5tcmq54bauuueem9wc4fw4y":"100%","ahf43e44h3y8ftanqgzno9z7q7w":"$500,000","ainpw47babwkpyj77ic4b9zq9xr":"Helx Industries","amahgyn9n4twaapg3jyxb6y4jic":"aafwyza5iwdcwcyfyj6bp7emufw","aro91wme9kfaie5ceu9qasmtcnw":"apjnaggwixchfxwiatfh7ey7uno","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1667822400000}"}}	1675955410943	1675955410943	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7czs3x5g5o7godjj9nwpmnc6dye	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Hand-off to customer success	{}	1675955411012	1675955411012	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
73wnuh3ums7grtb58as6qdu1s7r	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Finalize contract	{}	1675955411015	1675955411015	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
76fuqbbtu8pywjqqj1hgg4q9e8e	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Post-sales follow up	{}	1675955411019	1675955411019	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
cirqnetz9uf8ebpfrq68dx7sj1o	2023-02-09 15:10:10.921795+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Caitlyn Russel	{"contentOrder":["auxx7ta8sktnsjmafar4n4ox7uh","auyp7cdhmbpyymefooaxte184nh","7ia67tegp7f8obj4yxtaa8d9whc","768tmcyaxypyrimxhbpqw5i1fpr","765g3gs41epfp9jrm6pm3o9ym3a","7qdcudfpn53b5i8mpe73odd8nwr","71sd6tycbyj8gjrxp1iin7pa7zr","7xgfqfh9fdffcpmg91rdj6d1tea","7kzfgicen5j8d7rwhzbq6o4cedr","7pur5woxchiymbppotiqc3epu8e","7pft7f9sj4jd3upimxkh7x8w87h","7qbk31ej6jjyrjjsqyeu9fmturc"],"icon":"🧑‍💼","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(111) 123-1234","a5hwxjsmkn6bak6r7uea5bx1kwc":"ah6ehh43rwj88jy4awensin8pcw","abru6tz8uebdxy4skheqidh7zxy":"caitlyn.russel@email.com","adtf1151chornmihz4xbgbk9exa":"{\\"from\\":1689336000000}","aejo5tcmq54bauuueem9wc4fw4y":"20%","ahf43e44h3y8ftanqgzno9z7q7w":"$250,000","ainpw47babwkpyj77ic4b9zq9xr":"Liminary Corp.","amahgyn9n4twaapg3jyxb6y4jic":"aafwyza5iwdcwcyfyj6bp7emufw","aro91wme9kfaie5ceu9qasmtcnw":"apiswzj7uiwbh87z8dw8c6mturw","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1668168000000}"}}	1675955410949	1675955410948	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
cxarr4qdxsi8u9jak7cc3yeikuh	2023-02-09 15:10:10.921795+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	New Prospect	{"contentOrder":["ahae77tk763dpmmeijk8nwjociw","awdkgnnej7tnb5yweq4psgm8smc","7axxtz7491tbzddsddkhr1okagw","79gysbkm967djicna43f88r9wpe","71prjd7h1ofy1tbfmwbcyjxkunw","7p4tj6cwryjnbjqu6dp5zbia8rr","7wu3q67edhi8ebgmjzjfiwsahyo","71q3bar1wm7y9tc51rd8j7fymor","779frbxrdd7gb7e1g1u1wcweqnc","7s7keem8eetrm5yguee6e48agee","7yipg3d9mtigbdq8z5h7r3f3wgy","7jyt49rqrwbf5udj38tqu4ea37a"],"icon":"👤","isTemplate":true,"properties":{"a5hwxjsmkn6bak6r7uea5bx1kwc":"akj61wc9yxdwyw3t6m8igyf9d5o"}}	1675955410953	1675955410953	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
c7n4qjbom77g5mxhapf6tmtcidw	2023-02-09 15:10:10.921795+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Shelby Olson	{"contentOrder":["anbyeqt5wz3dkxq6kckxwn79xxr","aw1x1hw8aefd37joninhxtwxxka","7ojg7aiidaprm5q7y54ng8xa97r","7issp85h1mpn7pjo969iynpzike","73x54ue6mzbrj38t5mbkyfds7xc","7ddxcwbw3bpyk3nbyupp9s767pa","7w5z546c5u3d15n1fferi4y3sne","7bdmxk7xcrpryibc4g5srw41qqr","738c4jz9iytfmmjc43f8ma8bn1y","73x4mgnyqrff6jjmdmpwrc3r69a","76zfm97dmgjywuj7ukop3y918no","7xcdyhrcxqfn1byi14nkcfzoyor"],"icon":"🙎‍♀️","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(111) 321-5678","a5hwxjsmkn6bak6r7uea5bx1kwc":"akj61wc9yxdwyw3t6m8igyf9d5o","abru6tz8uebdxy4skheqidh7zxy":"shelby.olson@email.com","ahf43e44h3y8ftanqgzno9z7q7w":"$30,000","ainpw47babwkpyj77ic4b9zq9xr":"Kadera Global","amahgyn9n4twaapg3jyxb6y4jic":"ar6t1ttcumgfuqugg5o4g4mzrza","aro91wme9kfaie5ceu9qasmtcnw":"auu9bfzqeuruyjwzzqgz7q8apuw","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1669291200000}"}}	1675955410961	1675955410961	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
vpzrdpq8ugp88ipudigtx7kksch	2023-02-09 15:10:10.921795+00	bzwb99zf498tsm7mjqbiy7g81ze	1	view	Open Deals	{"cardOrder":["cirqnetz9uf8ebpfrq68dx7sj1o"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[{"condition":"includes","propertyId":"a5hwxjsmkn6bak6r7uea5bx1kwc","values":["akj61wc9yxdwyw3t6m8igyf9d5o","aic89a5xox4wbppi6mbyx6ujsda","ah6ehh43rwj88jy4awensin8pcw","aprhd96zwi34o9cs4xyr3o9sf3c","axesd74yuxtbmw1sbk8ufax7z3a"]}],"operation":"and"},"groupById":"aro91wme9kfaie5ceu9qasmtcnw","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["apjnaggwixchfxwiatfh7ey7uno","apiswzj7uiwbh87z8dw8c6mturw","auu9bfzqeuruyjwzzqgz7q8apuw",""],"visiblePropertyIds":[]}	1675955410964	1675955410964	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7zu87byt3etrfjj4if6i7o9f5zw	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Send initial email	{"value":true}	1675955410969	1675955410969	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7kwnrbo5c43gfjnpdoygghmfz5y	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Send follow-up email	{"value":true}	1675955410972	1675955410972	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7uwrwbb9sa38j8d95d4ww8mypdw	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Send proposal	{"value":true}	1675955410975	1675955410975	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7afgp343sijrc7gonf9qoy7556y	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Finalize contract	{}	1675955410978	1675955410978	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7n61tdes8updx7dgk4g1qmkqbnh	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Schedule initial sales call	{"value":true}	1675955410980	1675955410980	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7gx593y1kpif75xkrho74839yne	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Schedule demo	{"value":true}	1675955410982	1675955410982	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
71gqjf96497fi9ryke93twwe7xh	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Hand-off to customer success	{}	1675955410985	1675955410985	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7kx16rigxffr9bezsar6dxammny	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Follow up after demo	{"value":true}	1675955410987	1675955410987	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7iy8rn8s9ubdhxb9w43e5fmhuwh	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Schedule follow-up sales call	{"value":true}	1675955410990	1675955410990	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
77iiwbg3iufbkjp39xbytusm7fy	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Post-sales follow up	{}	1675955410993	1675955410993	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
askua4mi95jy8bchwhybg8gfcse	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	text	## Checklist	{}	1675955410996	1675955410996	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
akf5xjt9byinzfkeos6r6px8jbw	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1675955410999	1675955410999	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7cwxpmkp8d3y78e5t4t8aizh9ac	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Send initial email	{"value":true}	1675955411002	1675955411002	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7p31k115qpbyo5fefdqbwceunfo	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Schedule follow-up sales call	{"value":true}	1675955411004	1675955411004	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7e8a3i33n8jnujrhb9im4u3f3bc	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Follow up after demo	{"value":true}	1675955411007	1675955411007	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7pobi5s6iq3dhbktgrootac1h4h	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Send proposal	{"value":true}	1675955411009	1675955411009	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7dizabc4pu78y8kknah8pckrpgw	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Schedule demo	{"value":true}	1675955411023	1675955411023	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
79by87rm9i3ngfk95wxr4hcu8mw	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Schedule initial sales call	{"value":true}	1675955411027	1675955411027	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7f6prgh7etidefktxjadakro7de	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Send follow-up email	{"value":true}	1675955411030	1675955411030	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
afdi9nuij83bz9ywhkjsyorsika	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1675955411032	1675955411032	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
ap8htxxgcnpgaxka4s11df59y5c	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	text	## Checklist	{}	1675955411035	1675955411035	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7fymoo4ywy3yg5gyh91ijm1tmuw	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Follow up after demo	{"value":true}	1675955411038	1675955411038	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7pa48ejem6p8stdqhbbicqjj7cy	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Send initial email	{"value":true}	1675955411041	1675955411041	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
714ghubqyrpgd7nw34mh31ug79c	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Send follow-up email	{"value":true}	1675955411043	1675955411043	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
77p9joh3ajpg1tr6b385zidjbge	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Send proposal	{"value":true}	1675955411046	1675955411046	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7164ftmhpnfdwu8gy3icogzpa8o	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Finalize contract	{"value":true}	1675955411049	1675955411049	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
78wczgiecq7dkjbau9r54izny9w	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Schedule follow-up sales call	{"value":true}	1675955411054	1675955411054	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7i9im8g6b17nizpis19mmnn9ckh	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Schedule initial sales call	{"value":true}	1675955411062	1675955411062	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7n4b867c94tyymfg16gwoqj94fe	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Schedule demo	{"value":true}	1675955411077	1675955411077	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7w4tgym95obnjp8smfskq9iypcc	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Hand-off to customer success	{"value":true}	1675955411088	1675955411088	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7bwix7j583irsdmre8a3ttqy31e	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Post-sales follow up	{"value":true}	1675955411093	1675955411093	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
a98wh64rrxtyumdfmo5dim8wikr	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	text	## Checklist	{}	1675955411098	1675955411098	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
atyt9edm39tbtbnjddx5rt8mmda	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1675955411104	1675955411104	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7qbk31ej6jjyrjjsqyeu9fmturc	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Post-sales follow up	{}	1675955411116	1675955411116	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7kzfgicen5j8d7rwhzbq6o4cedr	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Send proposal	{}	1675955411121	1675955411121	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7pft7f9sj4jd3upimxkh7x8w87h	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Hand-off to customer success	{}	1675955411130	1675955411130	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7xgfqfh9fdffcpmg91rdj6d1tea	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Follow up after demo	{}	1675955411136	1675955411136	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
71sd6tycbyj8gjrxp1iin7pa7zr	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Schedule demo	{"value":true}	1675955411141	1675955411141	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7ia67tegp7f8obj4yxtaa8d9whc	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Send initial email	{"value":true}	1675955411144	1675955411144	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7qdcudfpn53b5i8mpe73odd8nwr	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Schedule follow-up sales call	{"value":true}	1675955411148	1675955411148	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
768tmcyaxypyrimxhbpqw5i1fpr	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Send follow-up email	{"value":true}	1675955411154	1675955411153	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
765g3gs41epfp9jrm6pm3o9ym3a	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Schedule initial sales call	{"value":true}	1675955411160	1675955411160	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7pur5woxchiymbppotiqc3epu8e	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Finalize contract	{}	1675955411166	1675955411166	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
auyp7cdhmbpyymefooaxte184nh	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	text	## Checklist	{}	1675955411172	1675955411172	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
auxx7ta8sktnsjmafar4n4ox7uh	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1675955411178	1675955411178	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7axxtz7491tbzddsddkhr1okagw	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Send initial email	{"value":false}	1675955411184	1675955411184	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
71prjd7h1ofy1tbfmwbcyjxkunw	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Schedule initial sales call	{"value":false}	1675955411190	1675955411190	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7p4tj6cwryjnbjqu6dp5zbia8rr	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Schedule follow-up sales call	{"value":false}	1675955411196	1675955411196	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
779frbxrdd7gb7e1g1u1wcweqnc	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Send proposal	{}	1675955411202	1675955411202	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7s7keem8eetrm5yguee6e48agee	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Finalize contract	{}	1675955411208	1675955411208	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7jyt49rqrwbf5udj38tqu4ea37a	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Post-sales follow up	{}	1675955411213	1675955411213	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
79gysbkm967djicna43f88r9wpe	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Send follow-up email	{"value":false}	1675955411219	1675955411219	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7wu3q67edhi8ebgmjzjfiwsahyo	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Schedule demo	{"value":false}	1675955411224	1675955411224	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7yipg3d9mtigbdq8z5h7r3f3wgy	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Hand-off to customer success	{}	1675955411230	1675955411230	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
71q3bar1wm7y9tc51rd8j7fymor	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Follow up after demo	{}	1675955411241	1675955411241	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
ahae77tk763dpmmeijk8nwjociw	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	text	## Notes\n[Enter notes here...]	{}	1675955411252	1675955411251	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
awdkgnnej7tnb5yweq4psgm8smc	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	text	## Checklist	{}	1675955411261	1675955411261	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7kfpfh7omc7f4bpgcpq5u3axgue	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Hand-off to customer success	{}	1675955411268	1675955411268	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
756nnjpzjwpntbe66myqiuw3qda	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Send initial email	{"value":false}	1675955411275	1675955411275	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
76rekmo79d78qtxh39scmb1kx5y	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Post-sales follow up	{}	1675955411281	1675955411281	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7imo387hkz3yrzrs9it7krmgjda	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Finalize contract	{}	1675955411288	1675955411288	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7k5f3rk8c6iyxzrcktu4wr3fwda	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Send follow-up email	{"value":false}	1675955411293	1675955411293	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
71bhibupqmbntbxg6dt8snc6asc	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Schedule follow-up sales call	{"value":false}	1675955411297	1675955411297	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7mb4ytzwbwidq7czurerc6o1swc	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Send proposal	{}	1675955411302	1675955411302	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7h5pc91n56p8yfmgp74rsqy78ro	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Follow up after demo	{}	1675955411310	1675955411310	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
78kwigroocfyn5pf41nhoupwoda	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Schedule initial sales call	{"value":false}	1675955411319	1675955411319	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
77predkxwjjgf7d6dtcjaooxr3e	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Schedule demo	{"value":false}	1675955411332	1675955411332	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
a65asssmsbjdh3giat9xzqoqdco	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	text	## Checklist	{}	1675955411338	1675955411338	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
a4zbibzhm1irk8pkx4xqmp4dpqc	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	text	## Notes\n[Enter notes here...]	{}	1675955411344	1675955411344	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
738c4jz9iytfmmjc43f8ma8bn1y	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Send proposal	{}	1675955411349	1675955411349	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7ojg7aiidaprm5q7y54ng8xa97r	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Send initial email	{"value":true}	1675955411355	1675955411355	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7bdmxk7xcrpryibc4g5srw41qqr	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Follow up after demo	{}	1675955411360	1675955411360	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
73x4mgnyqrff6jjmdmpwrc3r69a	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Finalize contract	{}	1675955411367	1675955411367	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7ddxcwbw3bpyk3nbyupp9s767pa	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Schedule follow-up sales call	{"value":false}	1675955411374	1675955411374	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7w5z546c5u3d15n1fferi4y3sne	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Schedule demo	{"value":false}	1675955411380	1675955411380	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
73x54ue6mzbrj38t5mbkyfds7xc	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Schedule initial sales call	{"value":false}	1675955411387	1675955411387	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7xcdyhrcxqfn1byi14nkcfzoyor	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Post-sales follow up	{}	1675955411394	1675955411394	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
76zfm97dmgjywuj7ukop3y918no	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Hand-off to customer success	{}	1675955411401	1675955411401	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7issp85h1mpn7pjo969iynpzike	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Send follow-up email	{"value":false}	1675955411408	1675955411408	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
aw1x1hw8aefd37joninhxtwxxka	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	text	## Checklist	{}	1675955411416	1675955411415	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7p3whtqf9cpnbuygpkfsutwheoo	2023-02-09 15:10:12.994972+00	cz4wzottsq3dpubozjfty9o4ciw	1	checkbox	[Subtask 3]	{"value":false}	1675955413115	1675955413115	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
anbyeqt5wz3dkxq6kckxwn79xxr	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1675955411433	1675955411433	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
ccq3ukx8c8bgo9x49g8q851froe	2023-02-09 15:10:12.186101+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Pay bills	{"contentOrder":["7kx1socx6mjgwxksy1nmnu8hbky","7mazt3mp5yfbdfkgh7iy4upqccy","7bh94nigoqtgyjgdtk7xan14t4h"],"icon":"🔌","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"aj4jyekqqssatjcq7r7chmy19ey","abthng7baedhhtrwsdodeuincqy":"true"}}	1675955412199	1675955412199	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
cchc3zymfa3f5mktpoiqo4nbzsr	2023-02-09 15:10:12.186101+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Buy groceries	{"contentOrder":["a54rpf4qjypbpdkdnraatck173h","76x94fpy89brh8jsjip3eepyb6c","7oq6wa91e1jnqxfhnshadyqwana","7gui4597mfbyqmgbrenwcu4apja","7wi6nur6ysig43x8yntx1atf13y","7zmwfuc7jqiysupcxdmncgdxqne","75wszyfkeptb4zr63z84e9koy3e"],"icon":"🛒","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"afpy8s7i45frggprmfsqngsocqh"}}	1675955412211	1675955412211	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
c4dc75947tjn5mem7kzzpgqnswh	2023-02-09 15:10:12.186101+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Go for a walk	{"contentOrder":["a8mj5x4thmtbi8jxh51jhq9u7iw","a8w7wz49bb78qxydiw5i398u7sy","7sbu99dbrabgj5bxyqe5c47ztqa"],"icon":"👣","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"an51dnkenmoog9cetapbc4uyt3y"}}	1675955412223	1675955412223	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
crq3aeiaa8frsmdbaox76xiapmc	2023-02-09 15:10:12.186101+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Feed Fluffy	{"contentOrder":["agr7xb7krnfyifg6yua5z86k4th"],"icon":"🐱","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"an51dnkenmoog9cetapbc4uyt3y"}}	1675955412232	1675955412231	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
cbby4rxqas3fxxpeso3quj6s1wy	2023-02-09 15:10:12.186101+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Gardening	{"contentOrder":[],"icon":"🌳","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"afpy8s7i45frggprmfsqngsocqh"}}	1675955412240	1675955412240	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
v9yh48g8pk3r6ico6sdomybkj5r	2023-02-09 15:10:12.186101+00	bbn1888mprfrm5fjw9f1je9x3xo	1	view	List View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":280},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a9zf59u8x1rf4ywctpcqama7tio","abthng7baedhhtrwsdodeuincqy"]}	1675955412247	1675955412247	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
vjy9kijzb53rqmdmszg5nii5nue	2023-02-09 15:10:12.186101+00	bbn1888mprfrm5fjw9f1je9x3xo	1	view	Board View	{"cardOrder":["cchc3zymfa3f5mktpoiqo4nbzsr","ccq3ukx8c8bgo9x49g8q851froe","c4dc75947tjn5mem7kzzpgqnswh","crq3aeiaa8frsmdbaox76xiapmc","czowhma7rnpgb3eczbqo3t7fijo"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a9zf59u8x1rf4ywctpcqama7tio","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["an51dnkenmoog9cetapbc4uyt3y","afpy8s7i45frggprmfsqngsocqh","aj4jyekqqssatjcq7r7chmy19ey",""],"visiblePropertyIds":["a9zf59u8x1rf4ywctpcqama7tio"]}	1675955412252	1675955412252	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7bh94nigoqtgyjgdtk7xan14t4h	2023-02-09 15:10:12.186101+00	ccq3ukx8c8bgo9x49g8q851froe	1	checkbox	Utilities	{"value":true}	1675955412257	1675955412257	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7kx1socx6mjgwxksy1nmnu8hbky	2023-02-09 15:10:12.186101+00	ccq3ukx8c8bgo9x49g8q851froe	1	checkbox	Mobile phone	{"value":true}	1675955412261	1675955412261	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7mazt3mp5yfbdfkgh7iy4upqccy	2023-02-09 15:10:12.186101+00	ccq3ukx8c8bgo9x49g8q851froe	1	checkbox	Internet	{"value":true}	1675955412266	1675955412266	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7zmwfuc7jqiysupcxdmncgdxqne	2023-02-09 15:10:12.186101+00	cchc3zymfa3f5mktpoiqo4nbzsr	1	checkbox	Cereal	{"value":false}	1675955412271	1675955412271	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7wi6nur6ysig43x8yntx1atf13y	2023-02-09 15:10:12.186101+00	cchc3zymfa3f5mktpoiqo4nbzsr	1	checkbox	Butter	{"value":false}	1675955412276	1675955412276	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7gui4597mfbyqmgbrenwcu4apja	2023-02-09 15:10:12.186101+00	cchc3zymfa3f5mktpoiqo4nbzsr	1	checkbox	Bread	{"value":false}	1675955412281	1675955412281	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
76x94fpy89brh8jsjip3eepyb6c	2023-02-09 15:10:12.186101+00	cchc3zymfa3f5mktpoiqo4nbzsr	1	checkbox	Milk	{"value":false}	1675955412285	1675955412285	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
75wszyfkeptb4zr63z84e9koy3e	2023-02-09 15:10:12.186101+00	cchc3zymfa3f5mktpoiqo4nbzsr	1	checkbox	Bananas	{"value":false}	1675955412291	1675955412291	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7oq6wa91e1jnqxfhnshadyqwana	2023-02-09 15:10:12.186101+00	cchc3zymfa3f5mktpoiqo4nbzsr	1	checkbox	Eggs	{"value":false}	1675955412296	1675955412296	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
a54rpf4qjypbpdkdnraatck173h	2023-02-09 15:10:12.186101+00	cchc3zymfa3f5mktpoiqo4nbzsr	1	text	## Grocery list	{}	1675955412300	1675955412300	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7sbu99dbrabgj5bxyqe5c47ztqa	2023-02-09 15:10:12.186101+00	c4dc75947tjn5mem7kzzpgqnswh	1	image		{"fileId":"76fwrj36hptg6dywka4k5mt3sph.png"}	1675955412306	1675955412306	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
a8mj5x4thmtbi8jxh51jhq9u7iw	2023-02-09 15:10:12.186101+00	c4dc75947tjn5mem7kzzpgqnswh	1	text	## Goal\nWalk at least 10,000 steps every day.	{}	1675955412310	1675955412310	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
a8w7wz49bb78qxydiw5i398u7sy	2023-02-09 15:10:12.186101+00	c4dc75947tjn5mem7kzzpgqnswh	1	text	## Route	{}	1675955412315	1675955412315	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
agr7xb7krnfyifg6yua5z86k4th	2023-02-09 15:10:12.186101+00	crq3aeiaa8frsmdbaox76xiapmc	1	text		{}	1675955412322	1675955412322	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
cz4wzottsq3dpubozjfty9o4ciw	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Identify dependencies	{"contentOrder":["aoun6pu8ahbgbdryiwihaf5g7kw","7kzqxyu34tbn4igsiaabt7yusnh","ak6b15yexfbdjbkbgb1qsb37bwo","71oe5g19kwtr65d43ydcfyaquma","7nqstxcxk97gfdq4kug4us1b6my","7p3whtqf9cpnbuygpkfsutwheoo","76z5c5whtetgo3frgooosey8kgw"],"icon":"🔗","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"16","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ayz81h9f3dwp7rzzbdebesc7ute","d3d682bf-e074-49d9-8df5-7320921c2d23":"98a57627-0f76-471d-850d-91f3ed9fd213"}}	1675955413003	1675955413003	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
c4mkyqpdicprz7mwj3hhnuw8ngc	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Define project scope	{"contentOrder":["a76yjexz653d9pn58r7wmfsf7pw","7b3bgpbw3pjgcibq8ghzdqhnqkc","ap7b19me84b8zzq6oknt89cwtxr","7uzdep7j5rbrnzrnugyojjqa43h","7ueynnzbbwp8xbk73848ipjaerr","7qwpifwt5hp87ukgmwusuqbtppa","7pe4oiok7zbdajbz9ryt57qksbo"],"icon":"🔬","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"32","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ar6b8m3jxr3asyxhr8iucdbo6yc","d3d682bf-e074-49d9-8df5-7320921c2d23":"87f59784-b859-4c24-8ebe-17c766e081dd"}}	1675955413009	1675955413009	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
cper74m1sojfhpgur1xhwynxfiy	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Requirements sign-off	{"contentOrder":["ae87wjndr9pnijcmi6hc5wb59re","7skzimbdzbpbq5kforgshzs61kw","ajut4tttrqbnmbp17wkag5omfxy","76sisungewinx7qgn6njki4ticy","7gfdcsb1poj8f5qp7r3h6pe4b1y","7pqf6oazaz3r3fcfdhe8f566prh","79qz9ycustfdhiqoejuc64jbjuy"],"icon":"🖋️","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"8","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ayz81h9f3dwp7rzzbdebesc7ute","d3d682bf-e074-49d9-8df5-7320921c2d23":"d3bfb50f-f569-4bad-8a3a-dd15c3f60101"}}	1675955413015	1675955413015	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
cd6qe9kcu8tny3qk1q166ieq7ca	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Project budget approval	{"contentOrder":["abdket889k3gqjgyapdtwdyrrma","7i5s3bpukbbri5fgi6fqj8hm8ya","aq35hqbaejb8iie6wit8itohs5c","7e1o55mq96py68xhxrpppfpdc5w","73zjyyew9dfbatkcgyp4zg77gmw","7d1eaa4nzcjd9jbo69mcoru8ape","7z54jn3njybgsbf8qtppxtz1zmo"],"icon":"💵","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"16","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ayz81h9f3dwp7rzzbdebesc7ute","d3d682bf-e074-49d9-8df5-7320921c2d23":"d3bfb50f-f569-4bad-8a3a-dd15c3f60101"}}	1675955413019	1675955413019	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
c1zftz5wzmiditnznpqken4saxc	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Conduct market analysis	{"contentOrder":["ae1mquzi61p8qufeuyb9tducnuy","74t5gy1zgujrtjrhiohjrobchqw","afisf71n8n3r49jcapjxbbj3qoh","7m3f5jyj7sjfbjmwxdp5oein9qr","7jy5wgugfjfy53ccqd67c35tchr","73f1jioomr3ryzrrp5h79ce3xde","7jy5gzxjmoiyb3kjxi6xfr4enyh"],"icon":"📈","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"40","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ar6b8m3jxr3asyxhr8iucdbo6yc","d3d682bf-e074-49d9-8df5-7320921c2d23":"87f59784-b859-4c24-8ebe-17c766e081dd"}}	1675955413027	1675955413027	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
vqikjy5xq5bynxrsw7z8jnwzr7c	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Project Priorities	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"d3d682bf-e074-49d9-8df5-7320921c2d23","hiddenOptionIds":[],"kanbanCalculations":{"":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"87f59784-b859-4c24-8ebe-17c766e081dd":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"98a57627-0f76-471d-850d-91f3ed9fd213":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"d3bfb50f-f569-4bad-8a3a-dd15c3f60101":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"}},"sortOptions":[],"viewType":"board","visibleOptionIds":["d3bfb50f-f569-4bad-8a3a-dd15c3f60101","87f59784-b859-4c24-8ebe-17c766e081dd","98a57627-0f76-471d-850d-91f3ed9fd213",""],"visiblePropertyIds":["a972dc7a-5f4c-45d2-8044-8c28c69717f1","a8daz81s4xjgke1ww6cwik5w7ye"]}	1675955413052	1675955413052	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
v1ihhkqej8brfbbthmm8j1b111c	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Progress Tracker	{"cardOrder":["cd6qe9kcu8tny3qk1q166ieq7ca","cper74m1sojfhpgur1xhwynxfiy","cz4wzottsq3dpubozjfty9o4ciw","c1zftz5wzmiditnznpqken4saxc","c4mkyqpdicprz7mwj3hhnuw8ngc","coxnjt3ro1in19dd1e3awdt338r"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a972dc7a-5f4c-45d2-8044-8c28c69717f1","hiddenOptionIds":[],"kanbanCalculations":{"":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"adeo5xuwne3qjue83fcozekz8ko":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"afi4o5nhnqc3smtzs1hs3ij34dh":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"ahpyxfnnrzynsw3im1psxpkgtpe":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"ar6b8m3jxr3asyxhr8iucdbo6yc":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"ayz81h9f3dwp7rzzbdebesc7ute":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"}},"sortOptions":[],"viewType":"board","visibleOptionIds":["ayz81h9f3dwp7rzzbdebesc7ute","ar6b8m3jxr3asyxhr8iucdbo6yc","afi4o5nhnqc3smtzs1hs3ij34dh","adeo5xuwne3qjue83fcozekz8ko","ahpyxfnnrzynsw3im1psxpkgtpe",""],"visiblePropertyIds":["d3d682bf-e074-49d9-8df5-7320921c2d23","a8daz81s4xjgke1ww6cwik5w7ye"]}	1675955413058	1675955413058	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
vsqznqhthm7dstpj4jxpeifppyw	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Task Overview	{"cardOrder":["c4mkyqpdicprz7mwj3hhnuw8ngc","c1zftz5wzmiditnznpqken4saxc","cz4wzottsq3dpubozjfty9o4ciw","cd6qe9kcu8tny3qk1q166ieq7ca","cper74m1sojfhpgur1xhwynxfiy","cz8p8gofakfby8kzz83j97db8ph","ce1jm5q5i54enhuu4h3kkay1hcc"],"collapsedOptionIds":[],"columnCalculations":{"a8daz81s4xjgke1ww6cwik5w7ye":"sum"},"columnWidths":{"2a5da320-735c-4093-8787-f56e15cdfeed":196,"__title":280,"a8daz81s4xjgke1ww6cwik5w7ye":139,"a972dc7a-5f4c-45d2-8044-8c28c69717f1":141,"d3d682bf-e074-49d9-8df5-7320921c2d23":110},"defaultTemplateId":"czw9es1e89fdpjr7cqptr1xq7qh","filter":{"filters":[],"operation":"and"},"groupById":"","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a972dc7a-5f4c-45d2-8044-8c28c69717f1","d3d682bf-e074-49d9-8df5-7320921c2d23","2a5da320-735c-4093-8787-f56e15cdfeed","a3zsw7xs8sxy7atj8b6totp3mby","axkhqa4jxr3jcqe4k87g8bhmary","a7gdnz8ff8iyuqmzddjgmgo9ery","a8daz81s4xjgke1ww6cwik5w7ye"]}	1675955413067	1675955413067	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
v8iq8y5gb6pd65n5iudaoegkc8a	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Task Calendar	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"a3zsw7xs8sxy7atj8b6totp3mby","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955413081	1675955413081	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
71oe5g19kwtr65d43ydcfyaquma	2023-02-09 15:10:12.994972+00	cz4wzottsq3dpubozjfty9o4ciw	1	checkbox	[Subtask 1]	{"value":false}	1675955413085	1675955413085	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7nqstxcxk97gfdq4kug4us1b6my	2023-02-09 15:10:12.994972+00	cz4wzottsq3dpubozjfty9o4ciw	1	checkbox	[Subtask 2]	{"value":false}	1675955413107	1675955413107	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7kzqxyu34tbn4igsiaabt7yusnh	2023-02-09 15:10:12.994972+00	cz4wzottsq3dpubozjfty9o4ciw	1	divider		{}	1675955413110	1675955413110	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
76z5c5whtetgo3frgooosey8kgw	2023-02-09 15:10:12.994972+00	cz4wzottsq3dpubozjfty9o4ciw	1	checkbox	...	{"value":false}	1675955413112	1675955413112	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
ak6b15yexfbdjbkbgb1qsb37bwo	2023-02-09 15:10:12.994972+00	cz4wzottsq3dpubozjfty9o4ciw	1	text	## Checklist	{}	1675955413117	1675955413117	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
aoun6pu8ahbgbdryiwihaf5g7kw	2023-02-09 15:10:12.994972+00	cz4wzottsq3dpubozjfty9o4ciw	1	text	## Description\n*[Brief description of this task]*	{}	1675955413120	1675955413120	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7ueynnzbbwp8xbk73848ipjaerr	2023-02-09 15:10:12.994972+00	c4mkyqpdicprz7mwj3hhnuw8ngc	1	checkbox	[Subtask 2]	{"value":false}	1675955413122	1675955413122	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7pe4oiok7zbdajbz9ryt57qksbo	2023-02-09 15:10:12.994972+00	c4mkyqpdicprz7mwj3hhnuw8ngc	1	checkbox	...	{"value":false}	1675955413134	1675955413134	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7uzdep7j5rbrnzrnugyojjqa43h	2023-02-09 15:10:12.994972+00	c4mkyqpdicprz7mwj3hhnuw8ngc	1	checkbox	[Subtask 1]	{"value":false}	1675955413141	1675955413141	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7qwpifwt5hp87ukgmwusuqbtppa	2023-02-09 15:10:12.994972+00	c4mkyqpdicprz7mwj3hhnuw8ngc	1	checkbox	[Subtask 3]	{"value":false}	1675955413162	1675955413162	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7b3bgpbw3pjgcibq8ghzdqhnqkc	2023-02-09 15:10:12.994972+00	c4mkyqpdicprz7mwj3hhnuw8ngc	1	divider		{}	1675955413188	1675955413188	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
ap7b19me84b8zzq6oknt89cwtxr	2023-02-09 15:10:12.994972+00	c4mkyqpdicprz7mwj3hhnuw8ngc	1	text	## Checklist	{}	1675955413203	1675955413203	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
a76yjexz653d9pn58r7wmfsf7pw	2023-02-09 15:10:12.994972+00	c4mkyqpdicprz7mwj3hhnuw8ngc	1	text	## Description\n*[Brief description of this task]*	{}	1675955413234	1675955413234	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
79qz9ycustfdhiqoejuc64jbjuy	2023-02-09 15:10:12.994972+00	cper74m1sojfhpgur1xhwynxfiy	1	checkbox	...	{"value":false}	1675955413238	1675955413238	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7gfdcsb1poj8f5qp7r3h6pe4b1y	2023-02-09 15:10:12.994972+00	cper74m1sojfhpgur1xhwynxfiy	1	checkbox	[Subtask 2]	{"value":false}	1675955413243	1675955413243	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7skzimbdzbpbq5kforgshzs61kw	2023-02-09 15:10:12.994972+00	cper74m1sojfhpgur1xhwynxfiy	1	divider		{}	1675955413247	1675955413247	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7pqf6oazaz3r3fcfdhe8f566prh	2023-02-09 15:10:12.994972+00	cper74m1sojfhpgur1xhwynxfiy	1	checkbox	[Subtask 3]	{"value":false}	1675955413258	1675955413258	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
76sisungewinx7qgn6njki4ticy	2023-02-09 15:10:12.994972+00	cper74m1sojfhpgur1xhwynxfiy	1	checkbox	[Subtask 1]	{"value":false}	1675955413263	1675955413263	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
ae87wjndr9pnijcmi6hc5wb59re	2023-02-09 15:10:12.994972+00	cper74m1sojfhpgur1xhwynxfiy	1	text	## Description\n*[Brief description of this task]*	{}	1675955413268	1675955413268	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
ajut4tttrqbnmbp17wkag5omfxy	2023-02-09 15:10:12.994972+00	cper74m1sojfhpgur1xhwynxfiy	1	text	## Checklist	{}	1675955413273	1675955413273	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7i5s3bpukbbri5fgi6fqj8hm8ya	2023-02-09 15:10:12.994972+00	cd6qe9kcu8tny3qk1q166ieq7ca	1	divider		{}	1675955413279	1675955413279	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7e1o55mq96py68xhxrpppfpdc5w	2023-02-09 15:10:12.994972+00	cd6qe9kcu8tny3qk1q166ieq7ca	1	checkbox	[Subtask 1]	{"value":false}	1675955413285	1675955413285	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7d1eaa4nzcjd9jbo69mcoru8ape	2023-02-09 15:10:12.994972+00	cd6qe9kcu8tny3qk1q166ieq7ca	1	checkbox	[Subtask 3]	{"value":false}	1675955413291	1675955413291	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7z54jn3njybgsbf8qtppxtz1zmo	2023-02-09 15:10:12.994972+00	cd6qe9kcu8tny3qk1q166ieq7ca	1	checkbox	...	{"value":false}	1675955413295	1675955413295	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
73zjyyew9dfbatkcgyp4zg77gmw	2023-02-09 15:10:12.994972+00	cd6qe9kcu8tny3qk1q166ieq7ca	1	checkbox	[Subtask 2]	{"value":false}	1675955413304	1675955413304	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
aq35hqbaejb8iie6wit8itohs5c	2023-02-09 15:10:12.994972+00	cd6qe9kcu8tny3qk1q166ieq7ca	1	text	## Checklist	{}	1675955413318	1675955413318	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
abdket889k3gqjgyapdtwdyrrma	2023-02-09 15:10:12.994972+00	cd6qe9kcu8tny3qk1q166ieq7ca	1	text	## Description\n*[Brief description of this task]*	{}	1675955413333	1675955413333	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7jy5gzxjmoiyb3kjxi6xfr4enyh	2023-02-09 15:10:12.994972+00	c1zftz5wzmiditnznpqken4saxc	1	checkbox	...	{"value":false}	1675955413338	1675955413338	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
73f1jioomr3ryzrrp5h79ce3xde	2023-02-09 15:10:12.994972+00	c1zftz5wzmiditnznpqken4saxc	1	checkbox	[Subtask 3]	{"value":false}	1675955413343	1675955413343	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
74t5gy1zgujrtjrhiohjrobchqw	2023-02-09 15:10:12.994972+00	c1zftz5wzmiditnznpqken4saxc	1	divider		{}	1675955413359	1675955413359	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7jy5wgugfjfy53ccqd67c35tchr	2023-02-09 15:10:12.994972+00	c1zftz5wzmiditnznpqken4saxc	1	checkbox	[Subtask 2]	{"value":false}	1675955413363	1675955413363	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7m3f5jyj7sjfbjmwxdp5oein9qr	2023-02-09 15:10:12.994972+00	c1zftz5wzmiditnznpqken4saxc	1	checkbox	[Subtask 1]	{"value":false}	1675955413369	1675955413369	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
ae1mquzi61p8qufeuyb9tducnuy	2023-02-09 15:10:12.994972+00	c1zftz5wzmiditnznpqken4saxc	1	text	## Description\n*[Brief description of this task]*	{}	1675955413377	1675955413377	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
afisf71n8n3r49jcapjxbbj3qoh	2023-02-09 15:10:12.994972+00	c1zftz5wzmiditnznpqken4saxc	1	text	## Checklist	{}	1675955413405	1675955413405	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
76azhipbobfygfynia6zacn9w3o	2023-02-09 15:10:12.994972+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	[Subtask 3]	{"value":false}	1675955413408	1675955413408	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7mb6ctqe7pfrtbedqcco1cubphw	2023-02-09 15:10:12.994972+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	[Subtask 2]	{"value":false}	1675955413413	1675955413413	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7jditmempbfbwjf5qcqsen8jrjr	2023-02-09 15:10:12.994972+00	czw9es1e89fdpjr7cqptr1xq7qh	1	divider		{}	1675955413418	1675955413418	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
785gjigqkdif5jf3eu11aubu45h	2023-02-09 15:10:12.994972+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	[Subtask 1]	{"value":false}	1675955413423	1675955413423	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7e5qw6opfzpnxxdzuow1futiuch	2023-02-09 15:10:12.994972+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	...	{"value":false}	1675955413441	1675955413441	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
acqyxd35m8jgmice6s8zu7r5p3w	2023-02-09 15:10:12.994972+00	czw9es1e89fdpjr7cqptr1xq7qh	1	text	## Description\n*[Brief description of this task]*	{}	1675955413455	1675955413455	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
abcywf8z4midn9mt3qcmufk8tmr	2023-02-09 15:10:12.994972+00	czw9es1e89fdpjr7cqptr1xq7qh	1	text	## Checklist	{}	1675955413461	1675955413461	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
vz8mbztwmdtyddeqoecmudbhf4y	2023-02-09 15:10:14.174793+00		1	view	By Quarter	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":452,"a17ryhi1jfsboxkwkztwawhmsxe":148,"a6amddgmrzakw66cidqzgk6p4ge":230,"azzbawji5bksj69sekcs4srm1ky":142},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"aqxyzkdrs4egqf7yk866ixkaojc","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a6amddgmrzakw66cidqzgk6p4ge","a17ryhi1jfsboxkwkztwawhmsxe","azzbawji5bksj69sekcs4srm1ky","adp5ft3kgz7r5iqq3tnwg551der","aqxyzkdrs4egqf7yk866ixkaojc","adu6mebzpibq6mgcswk69xxmnqe","asope3bddhm4gpsng5cfu4hf6rh","ajwxp866f9obs1kutfwaa5ru7fe","azqnyswk6s1boiwuthscm78qwuo","ahz3fmjnaguec8hce7xq3h5cjdr","a17bfcgnzmkwhziwa4tr38kiw5r"]}	1675955414182	1675955414182	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
vzs4utd66mig95xj9aon575y7mo	2023-02-09 15:10:14.174793+00		1	view	By Objectives	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":387,"a17ryhi1jfsboxkwkztwawhmsxe":134,"a6amddgmrzakw66cidqzgk6p4ge":183,"aqxyzkdrs4egqf7yk866ixkaojc":100},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a6amddgmrzakw66cidqzgk6p4ge","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a6amddgmrzakw66cidqzgk6p4ge","a17ryhi1jfsboxkwkztwawhmsxe","azzbawji5bksj69sekcs4srm1ky","adp5ft3kgz7r5iqq3tnwg551der","aqxyzkdrs4egqf7yk866ixkaojc","adu6mebzpibq6mgcswk69xxmnqe","asope3bddhm4gpsng5cfu4hf6rh","ajwxp866f9obs1kutfwaa5ru7fe","azqnyswk6s1boiwuthscm78qwuo","ahz3fmjnaguec8hce7xq3h5cjdr","a17bfcgnzmkwhziwa4tr38kiw5r"]}	1675955414186	1675955414185	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
ch8r4zp93di899kf58zrexgx8do	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Improve customer NPS score	{"contentOrder":[],"icon":"💯","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a8nukezwwmknqwjsygg7eaxs9te","a6amddgmrzakw66cidqzgk6p4ge":"apqfjst8massbjjhpcsjs3y1yqa","adp5ft3kgz7r5iqq3tnwg551der":"as555ipyzopjjpfb5rjtssecw5e","ahz3fmjnaguec8hce7xq3h5cjdr":"82%","ajwxp866f9obs1kutfwaa5ru7fe":"8.5","aqxyzkdrs4egqf7yk866ixkaojc":"anruuoyez51r3yjxuoc8zoqnwaw","azqnyswk6s1boiwuthscm78qwuo":"7","azzbawji5bksj69sekcs4srm1ky":"agm9p6gcq15ueuzqq3wd4be39wy"}}	1675955414192	1675955414192	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
ckiw38hhaz7dz9j817znsydproy	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Generate more Marketing Qualified Leads (MQLs)	{"contentOrder":[],"icon":"🛣️","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a8nukezwwmknqwjsygg7eaxs9te","a6amddgmrzakw66cidqzgk6p4ge":"auw3afh3kfhrfgmjr8muiz137jy","adp5ft3kgz7r5iqq3tnwg551der":"as555ipyzopjjpfb5rjtssecw5e","ahz3fmjnaguec8hce7xq3h5cjdr":"65%","ajwxp866f9obs1kutfwaa5ru7fe":"100","aqxyzkdrs4egqf7yk866ixkaojc":"ahfbn1jsmhydym33ygxwg5jt3kh","azqnyswk6s1boiwuthscm78qwuo":"65","azzbawji5bksj69sekcs4srm1ky":"aehoa17cz18rqnrf75g7dwhphpr"}}	1675955414198	1675955414198	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
cfn4r8fnn37ysfe69imeisb9n7r	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Increase customer retention	{"contentOrder":[],"icon":"😀","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a8nukezwwmknqwjsygg7eaxs9te","a6amddgmrzakw66cidqzgk6p4ge":"apqfjst8massbjjhpcsjs3y1yqa","adp5ft3kgz7r5iqq3tnwg551der":"a8zg3rjtf4swh7smsjxpsn743rh","ahz3fmjnaguec8hce7xq3h5cjdr":"66%","ajwxp866f9obs1kutfwaa5ru7fe":"90% customer retention rate","aqxyzkdrs4egqf7yk866ixkaojc":"acb6dqqs6yson7bbzx6jk9bghjh","azqnyswk6s1boiwuthscm78qwuo":"60%","azzbawji5bksj69sekcs4srm1ky":"afkxpcjqjypu7hhar7banxau91h"}}	1675955414209	1675955414209	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
c7wiascn8wpn3xkhkq8xmkqe8tc	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Hit company global sales target	{"contentOrder":[],"icon":"💰","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a6robxx81diugpjq5jkezz3j1fo","a6amddgmrzakw66cidqzgk6p4ge":"auw3afh3kfhrfgmjr8muiz137jy","adp5ft3kgz7r5iqq3tnwg551der":"a8zg3rjtf4swh7smsjxpsn743rh","ahz3fmjnaguec8hce7xq3h5cjdr":"15%","ajwxp866f9obs1kutfwaa5ru7fe":"50MM","aqxyzkdrs4egqf7yk866ixkaojc":"awfu37js3fomfkkczm1zppac57a","azqnyswk6s1boiwuthscm78qwuo":"7.5MM","azzbawji5bksj69sekcs4srm1ky":"agrfeaoj7d8p5ianw5iaf3191ae"}}	1675955414222	1675955414222	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
cm8zp8a7jp3gezbg3x375hbahye	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Increase user signups by 30%	{"contentOrder":[],"icon":"💳","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a6robxx81diugpjq5jkezz3j1fo","a6amddgmrzakw66cidqzgk6p4ge":"ao9b5pxyt7tkgdohzh9oaustdhr","adp5ft3kgz7r5iqq3tnwg551der":"as555ipyzopjjpfb5rjtssecw5e","ahz3fmjnaguec8hce7xq3h5cjdr":"0%","ajwxp866f9obs1kutfwaa5ru7fe":"1,000","aqxyzkdrs4egqf7yk866ixkaojc":"acb6dqqs6yson7bbzx6jk9bghjh","azqnyswk6s1boiwuthscm78qwuo":"0","azzbawji5bksj69sekcs4srm1ky":"afkxpcjqjypu7hhar7banxau91h"}}	1675955414237	1675955414237	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
c1yangmadqbyqddpcnz51mzb1dc	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Add 10 new customers in the EU	{"contentOrder":[],"icon":"🌍","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"apnt1f7na9rzgk1rt49keg7xbiy","a6amddgmrzakw66cidqzgk6p4ge":"auw3afh3kfhrfgmjr8muiz137jy","adp5ft3kgz7r5iqq3tnwg551der":"a1ts3ftyr8nocsicui98c89uxjy","ahz3fmjnaguec8hce7xq3h5cjdr":"30%","ajwxp866f9obs1kutfwaa5ru7fe":"10","aqxyzkdrs4egqf7yk866ixkaojc":"acb6dqqs6yson7bbzx6jk9bghjh","azqnyswk6s1boiwuthscm78qwuo":"3","azzbawji5bksj69sekcs4srm1ky":"agrfeaoj7d8p5ianw5iaf3191ae"}}	1675955414244	1675955414244	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
cbrnxdi4457dduryz6qpynu5ynr	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Launch 3 key features	{"contentOrder":[],"icon":"🚀","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"apnt1f7na9rzgk1rt49keg7xbiy","a6amddgmrzakw66cidqzgk6p4ge":"ao9b5pxyt7tkgdohzh9oaustdhr","adp5ft3kgz7r5iqq3tnwg551der":"a8zg3rjtf4swh7smsjxpsn743rh","ahz3fmjnaguec8hce7xq3h5cjdr":"33%","ajwxp866f9obs1kutfwaa5ru7fe":"3","aqxyzkdrs4egqf7yk866ixkaojc":"anruuoyez51r3yjxuoc8zoqnwaw","azqnyswk6s1boiwuthscm78qwuo":"1","azzbawji5bksj69sekcs4srm1ky":"aw5i7hmpadn6mbwbz955ubarhme"}}	1675955414250	1675955414249	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
c1kzebdkek3ntixdj5of7q57pya	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Reduce bug backlog by 50%	{"contentOrder":[],"icon":"🐞","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"abzfwnn6rmtfzyq5hg8uqmpsncy","a6amddgmrzakw66cidqzgk6p4ge":"apqfjst8massbjjhpcsjs3y1yqa","adp5ft3kgz7r5iqq3tnwg551der":"a1ts3ftyr8nocsicui98c89uxjy","ahz3fmjnaguec8hce7xq3h5cjdr":"100%","ajwxp866f9obs1kutfwaa5ru7fe":"75","aqxyzkdrs4egqf7yk866ixkaojc":"awfu37js3fomfkkczm1zppac57a","azqnyswk6s1boiwuthscm78qwuo":"75","azzbawji5bksj69sekcs4srm1ky":"aw5i7hmpadn6mbwbz955ubarhme"}}	1675955414260	1675955414260	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
7o9ksmt3jktribytdp9putspe4e	2023-02-09 15:10:14.585839+00	cxy8tneoo8b885jtn4zfqp5xona	1	image		{"fileId":"7b9xk9boj3fbqfm3umeaaizp8qr.png"}	1675955414703	1675955414703	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
v5kjrsy165t85um9997ir99bjxh	2023-02-09 15:10:14.174793+00	bm4ubx56krp4zwyfcqh7nxiigbr	1	view	Departments	{"cardOrder":["cpa534b5natgmunis8u1ixb55pw"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"azzbawji5bksj69sekcs4srm1ky","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["aw5i7hmpadn6mbwbz955ubarhme","afkxpcjqjypu7hhar7banxau91h","aehoa17cz18rqnrf75g7dwhphpr","agrfeaoj7d8p5ianw5iaf3191ae","agm9p6gcq15ueuzqq3wd4be39wy","aucop7kw6xwodcix6zzojhxih6r","afust91f3g8ht368mkn5x9tgf1o","acocxxwjurud1jixhp7nowdig7y"],"visiblePropertyIds":[]}	1675955414270	1675955414270	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
c3kb3yi7xob87xrscc561s3tkmh	2023-02-09 15:10:14.424408+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Start a daily journal	{"contentOrder":[],"icon":"✍️","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","d6b1249b-bc18-45fc-889e-bec48fce80ef":"0a82977f-52bf-457b-841b-e2b7f76fb525","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"3245a32d-f688-463b-87f4-8e7142c1b397"}}	1675955414451	1675955414451	0	\N	system		system	bdjegdwuc3fr3jxmg7sgcn6mtww
cogh3eo3tg7d9umaa5b7rjteejo	2023-02-09 15:10:14.424408+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Run 3 times a week	{"contentOrder":[],"icon":"🏃","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","d6b1249b-bc18-45fc-889e-bec48fce80ef":"6e7139e4-5358-46bb-8c01-7b029a57b80a","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"ffb3f951-b47f-413b-8f1d-238666728008"}}	1675955414456	1675955414456	0	\N	system		system	bdjegdwuc3fr3jxmg7sgcn6mtww
cif69jfjjyfdq9y6kmz6g36mc5a	2023-02-09 15:10:14.424408+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Learn to paint	{"contentOrder":[],"icon":"🎨","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"77c539af-309c-4db1-8329-d20ef7e9eacd","d6b1249b-bc18-45fc-889e-bec48fce80ef":"9a090e33-b110-4268-8909-132c5002c90e","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"3245a32d-f688-463b-87f4-8e7142c1b397"}}	1675955414461	1675955414461	0	\N	system		system	bdjegdwuc3fr3jxmg7sgcn6mtww
cpqd9prb7ij8x98bfoaubgbkbfy	2023-02-09 15:10:14.424408+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Open retirement account	{"contentOrder":[],"icon":"🏦","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","d6b1249b-bc18-45fc-889e-bec48fce80ef":"0a82977f-52bf-457b-841b-e2b7f76fb525","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"80be816c-fc7a-4928-8489-8b02180f4954"}}	1675955414467	1675955414467	0	\N	system		system	bdjegdwuc3fr3jxmg7sgcn6mtww
v6ghe65mhd3fatfmn8r4mkmpejo	2023-02-09 15:10:14.424408+00	bd65qbzuqupfztpg31dgwgwm5ga	1	view	By Status	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"af6fcbb8-ca56-4b73-83eb-37437b9a667d","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","77c539af-309c-4db1-8329-d20ef7e9eacd","98bdea27-0cce-4cde-8dc6-212add36e63a",""],"visiblePropertyIds":["d9725d14-d5a8-48e5-8de1-6f8c004a9680","d6b1249b-bc18-45fc-889e-bec48fce80ef"]}	1675955414476	1675955414476	0	\N	system		system	bdjegdwuc3fr3jxmg7sgcn6mtww
vt6x1h6sacibh3cchs3tea6du9w	2023-02-09 15:10:14.424408+00	bd65qbzuqupfztpg31dgwgwm5ga	1	view	Calendar View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"ajy6xbebzopojaenbnmfpgtdwso","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955414486	1675955414486	0	\N	system		system	bdjegdwuc3fr3jxmg7sgcn6mtww
ve6nrxk4a6trupk94tfw8oxgutw	2023-02-09 15:10:14.424408+00	bd65qbzuqupfztpg31dgwgwm5ga	1	view	By Date	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"d6b1249b-bc18-45fc-889e-bec48fce80ef","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["9a090e33-b110-4268-8909-132c5002c90e","0a82977f-52bf-457b-841b-e2b7f76fb525","6e7139e4-5358-46bb-8c01-7b029a57b80a","d5371c63-66bf-4468-8738-c4dc4bea4843",""],"visiblePropertyIds":["d9725d14-d5a8-48e5-8de1-6f8c004a9680"]}	1675955414493	1675955414493	0	\N	system		system	bdjegdwuc3fr3jxmg7sgcn6mtww
vu77og8uegir6fqcd97psqyuabo	2023-02-09 15:10:14.585839+00		1	view	By Sprint	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{"ai7ajsdk14w7x5s8up3dwir77te":"count"},"columnWidths":{"20717ad3-5741-4416-83f1-6f133fff3d11":128,"50117d52-bcc7-4750-82aa-831a351c44a0":126,"__title":280,"a1g6i613dpe9oryeo71ex3c86hy":159,"aeomttrbhhsi8bph31jn84sto6h":141,"ax9f8so418s6s65hi5ympd93i6a":183,"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":100},"defaultTemplateId":"cc9a5jhgow7njpft3ywtffsz78c","filter":{"filters":[],"operation":"and"},"groupById":"60985f46-3e41-486e-8213-2b987440ea1c","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["50117d52-bcc7-4750-82aa-831a351c44a0","20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","aphg37f7zbpuc3bhwhp19s1ribh","a4378omyhmgj3bex13sj4wbpfiy","ai7ajsdk14w7x5s8up3dwir77te","a1g6i613dpe9oryeo71ex3c86hy","aeomttrbhhsi8bph31jn84sto6h","ax9f8so418s6s65hi5ympd93i6a"]}	1675955414600	1675955414600	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
cc9a5jhgow7njpft3ywtffsz78c	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	User Story	{"contentOrder":["awzojrhtdh3nr5psizhywihzzgh"],"icon":"📖","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"apht1nt5ryukdmxkh6fkfn6rgoy","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer"}}	1675955414605	1675955414605	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
cfcj6p6y8rpn9tnezxe9bmsnmrh	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Horizontal scroll issue	{"contentOrder":["a6znekksdmpgmjedazsggqn1egh","apejdcik6kfn4fpdzixe485b7ae","76mot8uwo8jyatk53897g4oatca"],"icon":"〰️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"aomnawq4551cbbzha9gxnmb3z5w","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","ai7ajsdk14w7x5s8up3dwir77te":"1","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955414611	1675955414611	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
cxy8tneoo8b885jtn4zfqp5xona	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Login screen not loading	{"contentOrder":["aposk4q1ze3yozq4i1h9b6gjcbe","ahohrhxsoxjdmmp8igah5otrsho","7o9ksmt3jktribytdp9putspe4e"],"icon":"🖥️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"aomnawq4551cbbzha9gxnmb3z5w","50117d52-bcc7-4750-82aa-831a351c44a0":"abrfos7e7eczk9rqw6y5abadm1y","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","ai7ajsdk14w7x5s8up3dwir77te":"1","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"cb8ecdac-38be-4d36-8712-c4d58cc8a8e9"}}	1675955414618	1675955414618	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
cjwq1mmub3fbx9xidzmj1jth7dh	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Move cards across boards	{"contentOrder":["acx4qi4iqi3dgbgxe13rndfcxew"],"icon":"🚚","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"abrfos7e7eczk9rqw6y5abadm1y","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"2","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955414623	1675955414623	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
cawustaeu8pftmf4m4pfqya7k5h	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Cross-team collaboration	{"contentOrder":["aghhoq7neoirsbqq1b5r3m8knih"],"icon":"🤝","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"424ea5e3-9aa1-4075-8c5c-01b44b66e634","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","60985f46-3e41-486e-8213-2b987440ea1c":"14892380-1a32-42dd-8034-a0cea32bc7e6","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"3","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"c62172ea-5da7-4dec-8186-37267d8ee9a7"}}	1675955414629	1675955414629	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
cfxdu38pf57f98nmq8jj1fbtqja	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Bug	{"contentOrder":["adxhwp1jo67yxzczyc4p5ywxkmr","aq6rch5gsb3ne8cmqcp56ery9so","7q7j6yp8etpbktptcwtxefck6iw"],"icon":"🐞","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"aomnawq4551cbbzha9gxnmb3z5w","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer"}}	1675955414634	1675955414634	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
cn3ox8hrrutgtbnhoebu7fqgzdy	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Standard properties	{"contentOrder":["ar9whaq5zjifr8rq61a3e5pkyfa"],"icon":"🏷️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","60985f46-3e41-486e-8213-2b987440ea1c":"14892380-1a32-42dd-8034-a0cea32bc7e6","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"3","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955414639	1675955414639	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
c49q5wfok97ghujoyxiaqitzdry	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Epic	{"contentOrder":["akgpkj8rmabby58uyeyag9stijw"],"icon":"🤝","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"424ea5e3-9aa1-4075-8c5c-01b44b66e634","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"3","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"c62172ea-5da7-4dec-8186-37267d8ee9a7"}}	1675955414645	1675955414645	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
casdocyctotyajr5mb6kehetz1a	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Global templates	{"contentOrder":["au7ctdfpqgtrf3xksx398ux3e5h"],"icon":"🖼️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"a6ghze4iy441qhsh3eijnc8hwze","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"2","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955414649	1675955414649	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
chcs5bmiyftf1fjfpiaoeewpgba	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Feature	{"contentOrder":["aip8b45tfj3bp3dduxap3wn7g1a"],"icon":"🏗️","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer"}}	1675955414655	1675955414655	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
voi8jzi41yiyrucj1sh61s8tm6w	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	view	By Status	{"cardOrder":["casdocyctotyajr5mb6kehetz1a","cfcj6p6y8rpn9tnezxe9bmsnmrh","cjwq1mmub3fbx9xidzmj1jth7dh","cxy8tneoo8b885jtn4zfqp5xona","cn3ox8hrrutgtbnhoebu7fqgzdy","cawustaeu8pftmf4m4pfqya7k5h"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cidz4imnqhir48brz6e8hxhfrhy","filter":{"filters":[],"operation":"and"},"groupById":"50117d52-bcc7-4750-82aa-831a351c44a0","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["aft5bzo7h9aspqgrx3jpy5tzrer","abrfos7e7eczk9rqw6y5abadm1y","ax8wzbka5ahs3zziji3pp4qp9mc","atabdfbdmjh83136d5e5oysxybw","ace1bzypd586kkyhcht5qqd9eca","aay656c9m1hzwxc9ch5ftymh3nw","a6ghze4iy441qhsh3eijnc8hwze"],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675955414660	1675955414660	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
v7j16qap9ctfzibq6zgg66b5hay	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	view	By Type	{"cardOrder":["cxy8tneoo8b885jtn4zfqp5xona","cjwq1mmub3fbx9xidzmj1jth7dh","cn3ox8hrrutgtbnhoebu7fqgzdy","cfcj6p6y8rpn9tnezxe9bmsnmrh","casdocyctotyajr5mb6kehetz1a","cawustaeu8pftmf4m4pfqya7k5h"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cidz4imnqhir48brz6e8hxhfrhy","filter":{"filters":[],"operation":"and"},"groupById":"20717ad3-5741-4416-83f1-6f133fff3d11","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["424ea5e3-9aa1-4075-8c5c-01b44b66e634","a5yxq8rbubrpnoommfwqmty138h","apht1nt5ryukdmxkh6fkfn6rgoy","aiycbuo3dr5k4xxbfr7coem8ono","aomnawq4551cbbzha9gxnmb3z5w"],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675955414677	1675955414677	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
awzojrhtdh3nr5psizhywihzzgh	2023-02-09 15:10:14.585839+00	cc9a5jhgow7njpft3ywtffsz78c	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955414683	1675955414683	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
76mot8uwo8jyatk53897g4oatca	2023-02-09 15:10:14.585839+00	cfcj6p6y8rpn9tnezxe9bmsnmrh	1	image		{"fileId":"7tmfu5iqju3n1mdfwi5gru89qmw.png"}	1675955414688	1675955414688	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
a6znekksdmpgmjedazsggqn1egh	2023-02-09 15:10:14.585839+00	cfcj6p6y8rpn9tnezxe9bmsnmrh	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675955414694	1675955414694	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
apejdcik6kfn4fpdzixe485b7ae	2023-02-09 15:10:14.585839+00	cfcj6p6y8rpn9tnezxe9bmsnmrh	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675955414699	1675955414699	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
aposk4q1ze3yozq4i1h9b6gjcbe	2023-02-09 15:10:14.585839+00	cxy8tneoo8b885jtn4zfqp5xona	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675955414707	1675955414707	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
ahohrhxsoxjdmmp8igah5otrsho	2023-02-09 15:10:14.585839+00	cxy8tneoo8b885jtn4zfqp5xona	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675955414712	1675955414712	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
acx4qi4iqi3dgbgxe13rndfcxew	2023-02-09 15:10:14.585839+00	cjwq1mmub3fbx9xidzmj1jth7dh	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955414717	1675955414717	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
abs7abu751bbbjczo3e9j9kyssw	2023-02-09 15:10:14.585839+00	cfmk7771httynm8r7rm8cbrmrya	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675955414722	1675955414722	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
adaiaeiqjrfbf3xekijke57ggco	2023-02-09 15:10:14.585839+00	cfmk7771httynm8r7rm8cbrmrya	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675955414728	1675955414728	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
aghhoq7neoirsbqq1b5r3m8knih	2023-02-09 15:10:14.585839+00	cawustaeu8pftmf4m4pfqya7k5h	1	text	## Summary\n*[Brief description of what this epic is about]*\n\n## Motivation\n*[Brief description on why this is needed]*\n\n## Acceptance Criteria\n - *[Criteron 1]*\n - *[Criteron 2]*\n - ...\n\n## Personas\n - *[Persona A]*\n - *[Persona B]*\n - ...\n\n## Reference Materials\n - *[Links to other relevant documents as needed]*\n - ...	{}	1675955414733	1675955414733	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
7q7j6yp8etpbktptcwtxefck6iw	2023-02-09 15:10:14.585839+00	cfxdu38pf57f98nmq8jj1fbtqja	1	image		{"fileId":"7tmfu5iqju3n1mdfwi5gru89qmw.png"}	1675955414738	1675955414738	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
adxhwp1jo67yxzczyc4p5ywxkmr	2023-02-09 15:10:14.585839+00	cfxdu38pf57f98nmq8jj1fbtqja	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675955414744	1675955414744	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
aq6rch5gsb3ne8cmqcp56ery9so	2023-02-09 15:10:14.585839+00	cfxdu38pf57f98nmq8jj1fbtqja	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675955414750	1675955414750	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
ar9whaq5zjifr8rq61a3e5pkyfa	2023-02-09 15:10:14.585839+00	cn3ox8hrrutgtbnhoebu7fqgzdy	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955414756	1675955414756	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
akgpkj8rmabby58uyeyag9stijw	2023-02-09 15:10:14.585839+00	c49q5wfok97ghujoyxiaqitzdry	1	text	## Summary\n*[Brief description of what this epic is about]*\n\n## Motivation\n*[Brief description on why this is needed]*\n\n## Acceptance Criteria\n - *[Criteron 1]*\n - *[Criteron 2]*\n - ...\n\n## Personas\n - *[Persona A]*\n - *[Persona B]*\n - ...\n\n## Reference Materials\n - *[Links to other relevant documents as needed]*\n - ...	{}	1675955414761	1675955414761	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
au7ctdfpqgtrf3xksx398ux3e5h	2023-02-09 15:10:14.585839+00	casdocyctotyajr5mb6kehetz1a	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955414766	1675955414766	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
aip8b45tfj3bp3dduxap3wn7g1a	2023-02-09 15:10:14.585839+00	chcs5bmiyftf1fjfpiaoeewpgba	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955414771	1675955414771	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
vq5gp9utjdfgaxfzyoh1xbiyieh	2023-02-09 15:10:15.027456+00		1	view	All Users	{"cardOrder":["cmunfwxy6kif48jhg8g8do7wnpy"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":280,"aaebj5fyx493eezx6ukxiwydgty":146,"acjq4t5ymytu8x1f68wkggm7ypc":222,"akrxgi7p7w14fym3gbynb98t9fh":131,"atg9qu6oe4bjm8jczzsn71ff5me":131},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"akrxgi7p7w14fym3gbynb98t9fh","reversed":false}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["aaebj5fyx493eezx6ukxiwydgty","akrxgi7p7w14fym3gbynb98t9fh","atg9qu6oe4bjm8jczzsn71ff5me","acjq4t5ymytu8x1f68wkggm7ypc","aphio1s5gkmpdbwoxynim7acw3e","aqafzdeekpyncwz7m7i54q3iqqy","aify3r761b9w43bqjtskrzi68tr"]}	1675955415037	1675955415037	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
cmunfwxy6kif48jhg8g8do7wnpy	2023-02-09 15:10:15.027456+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Frank Nash	{"contentOrder":["apd8tm8d9838fbczp1a5exi6nde"],"icon":"👨‍💼","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"ap93ysuzy1xa7z818r6myrn4h4y","acjq4t5ymytu8x1f68wkggm7ypc":"frank.nash@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1669896000000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"aehc83ffays3gh8myz16a8j7k4e"}}	1675955415043	1675955415043	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
ceo3xece5mid4jjwaoqfs51xqch	2023-02-09 15:10:15.027456+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Richard Parsons	{"contentOrder":["a66wqjsz1yp87pb3k5sc355cpuy"],"icon":"👨‍🦱","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"a7yq89whddzob1futao4rxk3yzc","acjq4t5ymytu8x1f68wkggm7ypc":"richard.parsons@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1671019200000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"a1sxagjgaadym5yrjak6tcup1oa"}}	1675955415048	1675955415048	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
aogf1khixcifedyhnnxb8y5cs9a	2023-02-09 15:10:16.551755+00	crkth4zwoppf6me17xb1sf7m7wr	1	text	Mattermost Boards helps you manage and track all your project tasks with **Cards**.	{}	1675955416752	1675955416752	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
cwb6qiq5p4pgmfjnk95xz13rx4h	2023-02-09 15:10:15.027456+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Claire Hart	{"contentOrder":["a9xsae5aqafrbixp9gwjwpbqb3r"],"icon":"👩‍🦰","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"aseqq9hrsua56r3s6nbuirj9eec","acjq4t5ymytu8x1f68wkggm7ypc":"claire.hart@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1670500800000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"ahn89mqg9u4igk6pdm7333t8i5h"}}	1675955415054	1675955415054	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
co7xboyn5mfgatfdpye6nhj8ntw	2023-02-09 15:10:15.027456+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Olivia Alsop	{"contentOrder":["aitj1uj1gytfytcxxkarzf7z1sh"],"icon":"👩‍💼","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"a7yq89whddzob1futao4rxk3yzc","acjq4t5ymytu8x1f68wkggm7ypc":"olivia.alsop@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1671192000000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"a1sxagjgaadym5yrjak6tcup1oa"}}	1675955415059	1675955415059	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
c7jc13yp69bfh5q3inet8r7jqso	2023-02-09 15:10:15.027456+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Bernadette Powell	{"contentOrder":["azqotjxjdhj8r7r89r9wu3jyxby"],"icon":"🧑‍💼","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"af6hjb3ysuaxbwnfqpby4wwnkdr","acjq4t5ymytu8x1f68wkggm7ypc":"bernadette.powell@email.com"}}	1675955415065	1675955415065	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
vcnu6wcrtrpr1umz6oeyq5kpfzr	2023-02-09 15:10:15.027456+00	bh4pkixqsjift58e1qy6htrgeay	1	view	By Date	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"akrxgi7p7w14fym3gbynb98t9fh","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955415072	1675955415072	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
vi47u17fbjjbzjmdcu8z9fke64o	2023-02-09 15:10:15.027456+00	bixohg18tt11in4qbtinimk974y	1	view	By Status	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["af6hjb3ysuaxbwnfqpby4wwnkdr","aotxum1p5bw3xuzqz3ctjw66yww","a7yq89whddzob1futao4rxk3yzc","aseqq9hrsua56r3s6nbuirj9eec","ap93ysuzy1xa7z818r6myrn4h4y"],"visiblePropertyIds":[]}	1675955415107	1675955415107	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
apd8tm8d9838fbczp1a5exi6nde	2023-02-09 15:10:15.027456+00	cmunfwxy6kif48jhg8g8do7wnpy	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1675955415117	1675955415117	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
a66wqjsz1yp87pb3k5sc355cpuy	2023-02-09 15:10:15.027456+00	ceo3xece5mid4jjwaoqfs51xqch	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1675955415123	1675955415123	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
a9xsae5aqafrbixp9gwjwpbqb3r	2023-02-09 15:10:15.027456+00	cwb6qiq5p4pgmfjnk95xz13rx4h	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1675955415129	1675955415129	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
aitj1uj1gytfytcxxkarzf7z1sh	2023-02-09 15:10:15.027456+00	co7xboyn5mfgatfdpye6nhj8ntw	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1675955415134	1675955415134	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
azqotjxjdhj8r7r89r9wu3jyxby	2023-02-09 15:10:15.027456+00	c7jc13yp69bfh5q3inet8r7jqso	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1675955415137	1675955415137	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
cc6jo65tkri8kxfy85rpyg9r8de	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	card	New Project and Workflow Management Solutions for Developers	{"contentOrder":["71qhnzuec6esdi6fnynwpze4xya","ah8cy7eza9tba5pmk3qfdn4ngfo"],"icon":"🎯","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1645790400000}","ab6mbock6styfe6htf815ph1mhw":["a8xceonxiu4n3c43szhskqizicr","a3pdzi53kpbd4okzdkz6khi87zo","a3d9ux4fmi3anyd11kyipfbhwde"],"ae9ar615xoknd8hw8py7mbyr7zo":"awna1nuarjca99m9s4uiy9kwj5h","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://mattermost.com/newsroom/press-releases/mattermost-launches-new-project-and-workflow-management-solutions-for-developers/","aysx3atqexotgwp5kx6h5i5ancw":"aywiofmmtd3ofgzj95ysky4pjga"}}	1675955415566	1675955415566	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
c95jy6ztp3t8pinfsftu93bs6uh	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	card	[Tweet] Mattermost v6.1 includes card @-mention notifications in Boards	{"contentOrder":["7i96m7nbsdsex8n6hzuzrmdfjuy","7ed5bwp3gr8yax3mhtuwiaa9gjy","ard5i9e86qjnppf8zzttwiqdsme","aogzjxtgjt38upneka4fjk7f6hh","abdasiyq4k7ndtfrdadrias8sjy","7h6rn8yhjp7bm9q4sac8hinx8ge"],"icon":"🐤","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1639051200000}","ab6mbock6styfe6htf815ph1mhw":["az8o8pfe9hq6s7xaehoqyc3wpyc"],"ae9ar615xoknd8hw8py7mbyr7zo":"a9ana1e9w673o5cp8md4xjjwfto","agqsoiipowmnu9rdwxm57zrehtr":"{\\"from\\":1637668800000}","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://twitter.com/Mattermost/status/1463145633162969097?s=20","aysx3atqexotgwp5kx6h5i5ancw":"aj8y675weso8kpb6eceqbpj4ruw"}}	1675955415576	1675955415576	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
cf735gnmxwbdrd885z11f19rbyw	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	card	Top 10 Must-Have DevOps Tools in 2021	{"contentOrder":["7fo1utqc8x1z1z6hzg33hes1ktc","apsnwcshioid6uca7ugj36paj7y"],"icon":"🛠️","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1636113600000}","ab6mbock6styfe6htf815ph1mhw":["a8xceonxiu4n3c43szhskqizicr"],"ae9ar615xoknd8hw8py7mbyr7zo":"a9ana1e9w673o5cp8md4xjjwfto","agqsoiipowmnu9rdwxm57zrehtr":"{\\"from\\":1637323200000}","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://www.toolbox.com/tech/devops/articles/best-devops-tools/","aysx3atqexotgwp5kx6h5i5ancw":"a3xky7ygn14osr1mokerbfah5cy"}}	1675955415586	1675955415586	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
cjfsfemn88jfx7xutwd7jwfrubo	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	card	Unblocking Workflows: The Guide to Developer Productivity	{"contentOrder":["77tz16jtz5x73ncs3dxc3fp1d7h","aqwxfnfpu9p81zxum4kyy36faso"],"icon":"💻","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1638532800000}","ab6mbock6styfe6htf815ph1mhw":["a3pdzi53kpbd4okzdkz6khi87zo"],"ae9ar615xoknd8hw8py7mbyr7zo":"apy9dcd7zmand615p3h53zjqxjh","agqsoiipowmnu9rdwxm57zrehtr":"{\\"from\\":1639483200000}","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://mattermost.com/newsroom/press-releases/mattermost-unveils-definitive-report-on-the-state-of-developer-productivity-unblocking-workflows-the-guide-to-developer-productivity-2022-edition/","aysx3atqexotgwp5kx6h5i5ancw":"a3xky7ygn14osr1mokerbfah5cy"}}	1675955415591	1675955415591	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
7egzqwfr9n3gqjq6yrs9powrjby	2023-02-09 15:10:16.551755+00	cafahsprdajymd83b1dzr4sj91w	1	image		{"fileId":"7ek6wbpp19jfoujs1goh6kttbby.gif"}	1675955416755	1675955416755	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
vywt3ibumzp8tdg4wm67j5km7ma	2023-02-09 15:10:15.260316+00		1	view	Competitor List	{"cardOrder":["cinzhmm4ixiry8p5uchukeyjxuy","c43hjyntaxi8hup6dykbx4iik4h","ci6ss4aksnir9ukm1ycpbcnxihr","cptd3wkf6tt8oiq891pwj6frbbh","cf1fyfb97p7rumpmtedzawkzp4r"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":210,"a1semdhszu1rq17d7et5ydrqqio":121,"aapogff3xoa8ym7xf56s87kysda":194,"ahzspe59iux8wigra8bg6cg18nc":156,"aiefo7nh9jwisn8b4cgakowithy":155,"aozntq4go4nkab688j1s7stqtfc":151,"az3jkw3ynd3mqmart7edypey15e":145},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["ahzspe59iux8wigra8bg6cg18nc","aozntq4go4nkab688j1s7stqtfc","aiefo7nh9jwisn8b4cgakowithy","a6cwaq79b1pdpb97wkanmeyy4er","an1eerzscfxn6awdfajbg41uz3h","a1semdhszu1rq17d7et5ydrqqio","aapogff3xoa8ym7xf56s87kysda","az3jkw3ynd3mqmart7edypey15e"]}	1675955415270	1675955415270	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
vr7jn5u1b7tnjmjw6tnrkxnx7uc	2023-02-09 15:10:15.260316+00		1	view	Market Position	{"cardOrder":["cip8b4jcomfr7by9gtizebikfke","cacs91js1hb887ds41r6dwnd88c","ca3u8edwrof89i8obxffnz4xw3a"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["arfjpz9by5car71tz3behba8yih","abajmr34b8g1916w495xjb35iko","abt79uxg5edqojsrrefcnr4eruo","aipf3qfgjtkheiayjuxrxbpk9wa"],"visiblePropertyIds":[]}	1675955415276	1675955415276	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
cinzhmm4ixiry8p5uchukeyjxuy	2023-02-09 15:10:15.260316+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Liminary Corp.	{"contentOrder":["apypqwuyws7dxzj3g3fwk8atdse"],"icon":"🌧","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"abt79uxg5edqojsrrefcnr4eruo","a6cwaq79b1pdpb97wkanmeyy4er":"300","ahzspe59iux8wigra8bg6cg18nc":"liminarycorp.com","aiefo7nh9jwisn8b4cgakowithy":"$25,000,000","an1eerzscfxn6awdfajbg41uz3h":"2017","aozntq4go4nkab688j1s7stqtfc":"Toronto, Canada"}}	1675955415280	1675955415280	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
c43hjyntaxi8hup6dykbx4iik4h	2023-02-09 15:10:15.260316+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Helx Industries	{"contentOrder":["az9nkkcazeiruicczj15tot913a"],"icon":"📦","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"abt79uxg5edqojsrrefcnr4eruo","a6cwaq79b1pdpb97wkanmeyy4er":"650","ahzspe59iux8wigra8bg6cg18nc":"helxindustries.com","aiefo7nh9jwisn8b4cgakowithy":"$50,000,000","an1eerzscfxn6awdfajbg41uz3h":"2009","aozntq4go4nkab688j1s7stqtfc":"New York, NY"}}	1675955415284	1675955415284	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
ci6ss4aksnir9ukm1ycpbcnxihr	2023-02-09 15:10:15.260316+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Kadera Global	{"contentOrder":["asge3fu3t6inhjbz3muc4expd9c"],"icon":"🛡","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"aipf3qfgjtkheiayjuxrxbpk9wa","a6cwaq79b1pdpb97wkanmeyy4er":"150","ahzspe59iux8wigra8bg6cg18nc":"kaderaglobal.com","aiefo7nh9jwisn8b4cgakowithy":"$12,000,000","an1eerzscfxn6awdfajbg41uz3h":"2015","aozntq4go4nkab688j1s7stqtfc":"Seattle, OR"}}	1675955415290	1675955415290	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
cf1fyfb97p7rumpmtedzawkzp4r	2023-02-09 15:10:15.260316+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Ositions Inc.	{"contentOrder":["a48dxo8rjrpna7ke391tmepk37c"],"icon":"🌃","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"abajmr34b8g1916w495xjb35iko","a6cwaq79b1pdpb97wkanmeyy4er":"2,700","ahzspe59iux8wigra8bg6cg18nc":"ositionsinc.com","aiefo7nh9jwisn8b4cgakowithy":"$125,000,000","an1eerzscfxn6awdfajbg41uz3h":"2004","aozntq4go4nkab688j1s7stqtfc":"Berlin, Germany"}}	1675955415295	1675955415295	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
cptd3wkf6tt8oiq891pwj6frbbh	2023-02-09 15:10:15.260316+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Afformance Ltd.	{"contentOrder":["acuyiteaixfncprpfxb6p9q65xc"],"icon":"⚡","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"arfjpz9by5car71tz3behba8yih","a6cwaq79b1pdpb97wkanmeyy4er":"1,800","ahzspe59iux8wigra8bg6cg18nc":"afformanceltd.com","aiefo7nh9jwisn8b4cgakowithy":"$200,000,000","an1eerzscfxn6awdfajbg41uz3h":"2002","aozntq4go4nkab688j1s7stqtfc":"Palo Alto, CA"}}	1675955415301	1675955415301	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
apypqwuyws7dxzj3g3fwk8atdse	2023-02-09 15:10:15.260316+00	cinzhmm4ixiry8p5uchukeyjxuy	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1675955415306	1675955415306	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
az9nkkcazeiruicczj15tot913a	2023-02-09 15:10:15.260316+00	c43hjyntaxi8hup6dykbx4iik4h	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1675955415316	1675955415316	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
asge3fu3t6inhjbz3muc4expd9c	2023-02-09 15:10:15.260316+00	ci6ss4aksnir9ukm1ycpbcnxihr	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1675955415329	1675955415329	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
a48dxo8rjrpna7ke391tmepk37c	2023-02-09 15:10:15.260316+00	cf1fyfb97p7rumpmtedzawkzp4r	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n\n## Weaknesses\n- ...\n- ...\n\n## Opportunities\n- ...\n- ...\n\n## Threats\n- ...\n- ...	{}	1675955415342	1675955415342	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
arqrzjjesiirobdw5t97yrnax1a	2023-02-09 15:10:15.990252+00	cwrq9ag3p5pgzzy98nfd3wwra1w	1	text	## Summary\n*[Brief description of what this epic is about]*\n## Motivation\n*[Brief description on why this is needed]*\n## Acceptance Criteria\n- *[Criteron 1]*\n- *[Criteron 2]*\n- ...\n## Personas\n- *[Persona A]*\n- *[Persona B]*\n- ...\n## Reference Materials\n- *[Links to other relevant documents as needed]*\n- ...	{}	1675955416173	1675955416173	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
acuyiteaixfncprpfxb6p9q65xc	2023-02-09 15:10:15.260316+00	cptd3wkf6tt8oiq891pwj6frbbh	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1675955415347	1675955415347	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
cyhsodm36cbdh8q7kxm1j1gr8yw	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	card	App crashing	{"contentOrder":["79t7rkiuspeneqi9xurou9tqzwh","aowo8igj7rtnp7mwapij7s3o3xa","aej4ic8nk8td7zebzhmhfh9wu6y","7xt8yx9f49jbxbpkhjce5pi5g7o"],"icon":"📉","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"1fdbb515-edd2-4af5-80fc-437ed2211a49","50117d52-bcc7-4750-82aa-831a351c44a0":"ec6d2bc5-df2b-4f77-8479-e59ceb039946","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"cb8ecdac-38be-4d36-8712-c4d58cc8a8e9"}}	1675955416001	1675955416001	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
cxjt8ekj8yfratx83ukjr1nt5dw	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Calendar view	{"contentOrder":["7df11783ny67mdnognqae31ax6y","a8xtbuofra3yyf8dms1mknwen3r"],"icon":"📆","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"6eea96c9-4c61-4968-8554-4b7537e8f748","50117d52-bcc7-4750-82aa-831a351c44a0":"849766ba-56a5-48d1-886f-21672f415395","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955416006	1675955416006	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
cut844cdxxj86xqyrs9ctgecfme	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Standard templates	{"contentOrder":["7uonmjk41nipnrsi6tz8wau5ssh","ab6dzethdibbmfpwqwe5hx98pga"],"icon":"🗺️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"6eea96c9-4c61-4968-8554-4b7537e8f748","50117d52-bcc7-4750-82aa-831a351c44a0":"ec6d2bc5-df2b-4f77-8479-e59ceb039946","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955416011	1675955416011	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
ccoro58a94idw8mdo9k5rx3dx4h	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Import / Export	{"contentOrder":["a66nc7e11k78e9gm4hfude4z6dr"],"icon":"🚢","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"6eea96c9-4c61-4968-8554-4b7537e8f748","50117d52-bcc7-4750-82aa-831a351c44a0":"ec6d2bc5-df2b-4f77-8479-e59ceb039946","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955416016	1675955416016	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
c13uy7qkt57gapqc3qp61bhyjqr	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Review API design	{"contentOrder":["afw5i81na7id4jfw1wzb1qc7o6e"],"icon":"🛣️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"424ea5e3-9aa1-4075-8c5c-01b44b66e634","50117d52-bcc7-4750-82aa-831a351c44a0":"8c557f69-b0ed-46ec-83a3-8efab9d47ef5","60985f46-3e41-486e-8213-2b987440ea1c":"14892380-1a32-42dd-8034-a0cea32bc7e6","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"c62172ea-5da7-4dec-8186-37267d8ee9a7"}}	1675955416022	1675955416022	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
czwsifj8cm7fabf6asnhc8fugho	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Icons don't display	{"contentOrder":["azexrsotg53bp7xrf7zjogmk1fo","am796mc4hafgy7dc95e41hwfrmw","7csaz76fn9fgabquxp54stmjbne"],"icon":"💻","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"1fdbb515-edd2-4af5-80fc-437ed2211a49","50117d52-bcc7-4750-82aa-831a351c44a0":"8c557f69-b0ed-46ec-83a3-8efab9d47ef5","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955416028	1675955416028	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
v9d4nczqqmtri8mb6m83qj7j9oo	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	view	Calendar View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"a4378omyhmgj3bex13sj4wbpfiy","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955416036	1675955416035	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
vrtqx3uxamfynjd7ojjm8mcu3ty	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	view	Board: Sprints	{"cardOrder":["cyhsodm36cbdh8q7kxm1j1gr8yw","cxjt8ekj8yfratx83ukjr1nt5dw","cut844cdxxj86xqyrs9ctgecfme","czwsifj8cm7fabf6asnhc8fugho","ccoro58a94idw8mdo9k5rx3dx4h","c13uy7qkt57gapqc3qp61bhyjqr"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"60985f46-3e41-486e-8213-2b987440ea1c","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["c01676ca-babf-4534-8be5-cce2287daa6c","ed4a5340-460d-461b-8838-2c56e8ee59fe","14892380-1a32-42dd-8034-a0cea32bc7e6",""],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675955416048	1675955416047	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
vgf1tx6hdcfg4bnj1fpgkyfdnno	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	view	List: Tasks 🔨	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"50117d52-bcc7-4750-82aa-831a351c44a0":139,"__title":280},"defaultTemplateId":"","filter":{"filters":[{"condition":"includes","propertyId":"20717ad3-5741-4416-83f1-6f133fff3d11","values":["6eea96c9-4c61-4968-8554-4b7537e8f748"]}],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"50117d52-bcc7-4750-82aa-831a351c44a0","reversed":true}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["50117d52-bcc7-4750-82aa-831a351c44a0","20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675955416057	1675955416057	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
azexrsotg53bp7xrf7zjogmk1fo	2023-02-09 15:10:15.990252+00	czwsifj8cm7fabf6asnhc8fugho	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675955416158	1675955416158	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
vy4rzknwe5bdrbd8kg5sfaq7rcy	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	view	By Status	{"cardOrder":[null,"cdbfkd15d6iy18rgx1tskmfsr6c","cn8yofg9rtkgmzgmb5xdi56p3ic","csgsnnywpuqzs5jgq87snk9x17e","cqwaytore5y487wdu8zffppqnea",null],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["awna1nuarjca99m9s4uiy9kwj5h","a9ana1e9w673o5cp8md4xjjwfto","apy9dcd7zmand615p3h53zjqxjh","acri4cm3bmay55f7ksztphmtnga","amsowcd9a8e1kid317r7ttw6uzh",""],"visiblePropertyIds":["ab6mbock6styfe6htf815ph1mhw"]}	1675955415596	1675955415596	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
vf1ywowszz3bktg6rzbj8x5w9qc	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	view	Due Date Calendar	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"a39x5cybshwrbjpc3juaakcyj6e","defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955415602	1675955415602	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
vca7xj7s8d3fpu856mw15dw1o8o	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	view	Publication Calendar	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"agqsoiipowmnu9rdwxm57zrehtr","defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955415607	1675955415607	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
v6jmwqbs8hjrkipcqhjgcxyn9ge	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	view	Content List	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":322,"ab6mbock6styfe6htf815ph1mhw":229,"aysx3atqexotgwp5kx6h5i5ancw":208},"defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"a39x5cybshwrbjpc3juaakcyj6e","reversed":false}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["ae9ar615xoknd8hw8py7mbyr7zo","aysx3atqexotgwp5kx6h5i5ancw","ab6mbock6styfe6htf815ph1mhw","ao44fz8nf6z6tuj1x31t9yyehcc","a39x5cybshwrbjpc3juaakcyj6e","agqsoiipowmnu9rdwxm57zrehtr","ap4e7kdg7eip7j3c3oyiz39eaoc"]}	1675955415613	1675955415613	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
ah8cy7eza9tba5pmk3qfdn4ngfo	2023-02-09 15:10:15.523642+00	cc6jo65tkri8kxfy85rpyg9r8de	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675955415619	1675955415619	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
7h6rn8yhjp7bm9q4sac8hinx8ge	2023-02-09 15:10:15.523642+00	c95jy6ztp3t8pinfsftu93bs6uh	1	image		{"fileId":"7y5kr8x8ybpnwdykjfuz57rggrh.png"}	1675955415624	1675955415624	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
ard5i9e86qjnppf8zzttwiqdsme	2023-02-09 15:10:15.523642+00	c95jy6ztp3t8pinfsftu93bs6uh	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675955415630	1675955415630	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
aogzjxtgjt38upneka4fjk7f6hh	2023-02-09 15:10:15.523642+00	c95jy6ztp3t8pinfsftu93bs6uh	1	text	## Media	{}	1675955415634	1675955415634	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
akta9uxe6pp8gtbmbunotw87m3r	2023-02-09 15:10:15.523642+00	cff1jmrxfrirgbeebhr9qd7nida	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675955415639	1675955415639	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
apsogn1m3ifrc9qsxzesijqcjdc	2023-02-09 15:10:15.523642+00	cff1jmrxfrirgbeebhr9qd7nida	1	text	## Research\n- ...\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n- ...\n\n## Notes\n- ...\n- ...\n- ...	{}	1675955415644	1675955415644	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
ap7a7kupzfffomn6sxkw73yqjmy	2023-02-09 15:10:15.523642+00	cff1jmrxfrirgbeebhr9qd7nida	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675955415649	1675955415649	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
apsnwcshioid6uca7ugj36paj7y	2023-02-09 15:10:15.523642+00	cf735gnmxwbdrd885z11f19rbyw	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675955415655	1675955415655	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
aqwxfnfpu9p81zxum4kyy36faso	2023-02-09 15:10:15.523642+00	cjfsfemn88jfx7xutwd7jwfrubo	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675955415660	1675955415660	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
vcqxizj9q6ibjxf4f7wkyrjqzoa	2023-02-09 15:10:15.867257+00	bjbhs6bos3m8zjouf78xceg9nqw	1	view	Board view	{"cardOrder":["cniwb8xwcqtbstbcm3sdfrr854h","cs4qwpzr65fgttd7364dicskanh","c9s78pzbdg3g4jkcdjqahtnfejc","c8utmazns878jtfgtf7exyi9pee","cnobejmb6bf8e3c1w7em5z4pwyh"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["aok6pgecm85qe9k5kcphzoe63ma","aq1dwbf661yx337hjcd5q3sbxwa","ar87yh5xmsswqkxmjq1ipfftfpc","akj3fkmxq7idma55mdt8sqpumyw"],"visiblePropertyIds":["aspaay76a5wrnuhtqgm97tt3rer"]}	1675955415876	1675955415876	0	\N	system		system	b6p46z69w8pdyzd8xyn6mg9xxmr
ceesyxk3sy38tidayxrqw8etwth	2023-02-09 15:10:15.867257+00	bsjd59qtpbf888mqez3ge77domw	1	card	Tight deadline	{"contentOrder":[],"icon":"📅","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"ar87yh5xmsswqkxmjq1ipfftfpc"}}	1675955415882	1675955415882	0	\N	system		system	b6p46z69w8pdyzd8xyn6mg9xxmr
cmptymjj19b8xjdzzksdhuytehy	2023-02-09 15:10:15.867257+00	bsjd59qtpbf888mqez3ge77domw	1	card	Team communication	{"contentOrder":[],"icon":"💬","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"aq1dwbf661yx337hjcd5q3sbxwa"}}	1675955415888	1675955415888	0	\N	system		system	b6p46z69w8pdyzd8xyn6mg9xxmr
cmi544mdhx7yufmibt1cmatep6a	2023-02-09 15:10:15.867257+00	bsjd59qtpbf888mqez3ge77domw	1	card	Reschedule planning meeting	{"contentOrder":[],"icon":"🗓️","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"aok6pgecm85qe9k5kcphzoe63ma"}}	1675955415893	1675955415893	0	\N	system		system	b6p46z69w8pdyzd8xyn6mg9xxmr
c4p4skb74yjgwjc3ke1jd5tekrr	2023-02-09 15:10:15.867257+00	bsjd59qtpbf888mqez3ge77domw	1	card	Schedule more time for testing	{"contentOrder":[],"icon":"🧪","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"akj3fkmxq7idma55mdt8sqpumyw"}}	1675955415899	1675955415899	0	\N	system		system	b6p46z69w8pdyzd8xyn6mg9xxmr
cqngo6k4i4b8pfb9enafb3hwhyw	2023-02-09 15:10:15.867257+00	bsjd59qtpbf888mqez3ge77domw	1	card	Positive user feedback	{"contentOrder":[],"icon":"🥰","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"aq1dwbf661yx337hjcd5q3sbxwa"}}	1675955415904	1675955415904	0	\N	system		system	b6p46z69w8pdyzd8xyn6mg9xxmr
vew7eb6b56fn8mk91duwjxdohar	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	view	Board: Status	{"cardOrder":["cyhsodm36cbdh8q7kxm1j1gr8yw","cm4w7cc3aac6s9jdcujbs4j8f4r","c6egh6cpnj137ixdoitsoxq17oo","cct9u78utsdyotmejbmwwg66ihr","cmft87it1q7yebbd51ij9k65xbw","c9fe77j9qcruxf4itzib7ag6f1c","coup7afjknqnzbdwghiwbsq541w","c5ex1hndz8qyc8gx6ofbfeksftc"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cidz4imnqhir48brz6e8hxhfrhy","filter":{"filters":[],"operation":"and"},"groupById":"50117d52-bcc7-4750-82aa-831a351c44a0","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["8c557f69-b0ed-46ec-83a3-8efab9d47ef5","ec6d2bc5-df2b-4f77-8479-e59ceb039946","849766ba-56a5-48d1-886f-21672f415395",""],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675955416064	1675955416064	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
vdkcaex5b6tfy9gwkffyhczg8dy	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	view	List: Bugs 🐞	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"50117d52-bcc7-4750-82aa-831a351c44a0":145,"__title":280},"defaultTemplateId":"","filter":{"filters":[{"condition":"includes","propertyId":"20717ad3-5741-4416-83f1-6f133fff3d11","values":["1fdbb515-edd2-4af5-80fc-437ed2211a49"]}],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["50117d52-bcc7-4750-82aa-831a351c44a0","20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675955416071	1675955416071	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
7xt8yx9f49jbxbpkhjce5pi5g7o	2023-02-09 15:10:15.990252+00	cyhsodm36cbdh8q7kxm1j1gr8yw	1	image		{"fileId":"77pe9r4ckbin438ph3f18bpatua.png"}	1675955416077	1675955416077	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
aowo8igj7rtnp7mwapij7s3o3xa	2023-02-09 15:10:15.990252+00	cyhsodm36cbdh8q7kxm1j1gr8yw	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675955416085	1675955416085	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
aej4ic8nk8td7zebzhmhfh9wu6y	2023-02-09 15:10:15.990252+00	cyhsodm36cbdh8q7kxm1j1gr8yw	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675955416091	1675955416091	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
a8xtbuofra3yyf8dms1mknwen3r	2023-02-09 15:10:15.990252+00	cxjt8ekj8yfratx83ukjr1nt5dw	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955416097	1675955416097	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
ab6dzethdibbmfpwqwe5hx98pga	2023-02-09 15:10:15.990252+00	cut844cdxxj86xqyrs9ctgecfme	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955416102	1675955416102	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
7nsq6tift1pg43cqxh6ptkf8s4a	2023-02-09 15:10:15.990252+00	cfefgwjke6bbxpjpig618g9bpte	1	image		{"fileId":"7pbp4qg415pbstc6enzeicnu3qh.png"}	1675955416107	1675955416107	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
a7qy7p9y4qbgwim4qheaoyh56se	2023-02-09 15:10:15.990252+00	cfefgwjke6bbxpjpig618g9bpte	1	text	## Screenshots\nIf applicable, add screenshots to elaborate on the problem.	{}	1675955416113	1675955416113	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
asqe7das383fd8bsg6ki5k3j5de	2023-02-09 15:10:15.990252+00	cfefgwjke6bbxpjpig618g9bpte	1	text	## Steps to reproduce the behavior\n\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n\nA clear and concise description of what you expected to happen.\n\n## Edition and Platform\n\n - Edition: Personal Desktop / Personal Server / Mattermost plugin\n - Version: [e.g. v0.9.0]\n - Browser and OS: [e.g. Chrome 91 on macOS, Edge 93 on Windows]\n\n## Additional context\n\nAdd any other context about the problem here.	{}	1675955416119	1675955416119	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
agsg7r9qcppnjmbm4io1zxkqpfe	2023-02-09 15:10:15.990252+00	cfefgwjke6bbxpjpig618g9bpte	1	text	## Steps to reproduce the behavior\n\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n\n*[A clear and concise description of what you expected to happen.]*\n\n## Screenshots\n\n*[If applicable, add screenshots to elaborate on the problem.]*\n\n## Edition and Platform\n\n - Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n - Version: *[e.g. v0.9.0]*\n - Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n\n*[Add any other context about the problem here.]*	{}	1675955416123	1675955416123	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
a66nc7e11k78e9gm4hfude4z6dr	2023-02-09 15:10:15.990252+00	ccoro58a94idw8mdo9k5rx3dx4h	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955416128	1675955416128	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
a1dihou959jr7trof8zpknymz3h	2023-02-09 15:10:15.990252+00	cidz4imnqhir48brz6e8hxhfrhy	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955416134	1675955416134	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
ahbfddu6t6i8mzmtsdmedda4tgh	2023-02-09 15:10:15.990252+00	cidz4imnqhir48brz6e8hxhfrhy	1	text	## Requirements\n- [Requirement 1]\n- [Requirement 2]\n- ...	{}	1675955416138	1675955416138	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
afw5i81na7id4jfw1wzb1qc7o6e	2023-02-09 15:10:15.990252+00	c13uy7qkt57gapqc3qp61bhyjqr	1	text	## Summary\n*[Brief description of what this epic is about]*\n\n## Motivation\n*[Brief description on why this is needed]*\n\n## Acceptance Criteria\n - *[Criteron 1]*\n - *[Criteron 2]*\n - ...\n\n## Personas\n - *[Persona A]*\n - *[Persona B]*\n - ...\n\n## Reference Materials\n - *[Links to other relevant documents as needed]*\n - ...	{}	1675955416144	1675955416144	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
7csaz76fn9fgabquxp54stmjbne	2023-02-09 15:10:15.990252+00	czwsifj8cm7fabf6asnhc8fugho	1	image		{"fileId":"7pbp4qg415pbstc6enzeicnu3qh.png"}	1675955416149	1675955416149	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
am796mc4hafgy7dc95e41hwfrmw	2023-02-09 15:10:15.990252+00	czwsifj8cm7fabf6asnhc8fugho	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675955416154	1675955416154	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
7nsow3b1arbrnzmjybgu9axwtte	2023-02-09 15:10:16.551755+00	crkth4zwoppf6me17xb1sf7m7wr	1	image		{"fileId":"7iw4rxx7jj7bypmdotd9z469cyh.png"}	1675955416743	1675955416743	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
aszhiqtytuty4888t8dii87td1w	2023-02-09 15:10:15.990252+00	cwrq9ag3p5pgzzy98nfd3wwra1w	1	text	## Summary\n[Brief description of what this epic is about]\n\n## Motivation\n[Brief description on why this is needed]\n\n## Acceptance Criteria\n - [Criteron 1]\n - [Criteron 2]\n - ...\n\n## Personas\n - [Persona A]\n - [Persona B]\n - ...\n\n## Reference Materials\n - [Links to other relevant documents as needed]\n - ...	{}	1675955416179	1675955416179	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
c5wz7jz8at3gx8brn8jcz7u3ujh	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Drag cards	{"contentOrder":["apktbgtee5jb8xrnqy3ibiujxew","aanpn1chdbirddfu4obqi3rieew"],"icon":"🤏","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#dragging-cards","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1675955416560	1675955416560	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
c561c93bfjjyp7gsda4qk6d9dca	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Manage tasks with cards	{"contentOrder":["azz8hdz4357fq8fwghbqz7e88ww","71wbc54cp57yw5x84ih1u7b3bxw","7zudf4ytye3y69dtwtfkagbi7zh","784uu3ufcgb878ky7hyugmf6xcw","7kc44wypp1jnzmm3qh7ocx3t69e","7w4sjknti5pyd5kbkpoba1tkf8h","7gr65cgf58bgzmfun9odcmk14hr","7nb8y7jyoetro8cd36qcju53z8c","7413u4xnrebnf5gypfbzc3yokce","7htefhgxktin4fnfcac7ncuty3a","76nwb9tqfsid5jx46yw34itqima","7dy3mcgzgybf1ifa3emgewkzj7e","a5ca6tii33bfw8ba36y1rswq3he","7876od6xhffr6fy69zeogag7eyw","7x7bq9awkatbm5x4docbh5gaw4y","7ghpx9qff43dgtke1rwidmge1ho","7nb8y7jyoetro8cd36qcju53z8c","7hdyxemhbytfm3m83g88djq9nhr","7pgnejxokubbe9kdrxj6g9qa41e","7hw9z6qtx8jyizkmm9g5yq3gxcy","7gk6ooz6npbb8by5rgp9aig7tua","7ny8o9rq7e3rsbyoogjmgetgspa"],"icon":"☑️","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"amm6wfhnbuxojwssyftgs9dipqe","acypkejeb5yfujhj9te57p9kaxw":"aanaehcw3m13jytujsjk5hpf6ry"}}	1675955416566	1675955416566	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
ct5kpq5rgqidtik98waz1m5fdqo	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Create your own board	{"contentOrder":["at1gc3nj44pfmtchdhm463rsugr","atkhpnbj8qjgyzyac48o36u4xpw","7r9my1yuddbn45dojrfht3neg8c","7eir5gdjxgjbsxpbyp3df4npcze","7qp41kosg67bkbppoqt1c64yu6h"],"icon":"📋","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#adding-new-boards","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"amm6wfhnbuxojwssyftgs9dipqe","acypkejeb5yfujhj9te57p9kaxw":"aanaehcw3m13jytujsjk5hpf6ry"}}	1675955416570	1675955416570	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
chwbzoteop38obrffjnbye8kkph	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Share a board	{"contentOrder":["aj9qonaknubbcjc3txbjxqo5y7a","aqop7km57rpnpmfg6mro767ukaa","7r7asyew8d7fyunf4sow8e5iyoc","ad8j3n8tp77bppee3ipjt6odgpe","7w935usqt6pby8qz9x5pxaj7iow","7ogbs8h6q4j8z7ngy1m7eag63nw","7z1jau5qy3jfcxdp5cgq3duk6ne","7j9bhj4sh8iytxpnu1o1gpfyh6o"],"icon":"📤","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/sharing-boards.html","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1675955416574	1675955416574	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
crkth4zwoppf6me17xb1sf7m7wr	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Create a new card	{"contentOrder":["aogf1khixcifedyhnnxb8y5cs9a","adhsx4h5ss7rqdcjt8xyam6xtqc","a1enn3jnusffjuc4ciqrfc197fr","7me9p46gbqiyfmfnapi7dyxb5br","7nsow3b1arbrnzmjybgu9axwtte"],"icon":"📝","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#adding-cards","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"amm6wfhnbuxojwssyftgs9dipqe","acypkejeb5yfujhj9te57p9kaxw":"aanaehcw3m13jytujsjk5hpf6ry"}}	1675955416580	1675955416579	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
cafahsprdajymd83b1dzr4sj91w	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Share cards on Channels	{"contentOrder":["akr4w845sp3dgty4cayg6wrz96a","ai4qtbj8quiywfxdrorts7dsf3h","aoe9xan7bat8imn45t4x4knq11e","7egzqwfr9n3gqjq6yrs9powrjby"],"icon":"📮","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html#share-card-previews","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"af3p8ztcyxgn8wd9z4az7o9tjeh","acypkejeb5yfujhj9te57p9kaxw":"ascd7nm9r491ayot8i86g1gmgqw"}}	1675955416595	1675955416595	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
copdhfsz6e3gg3yqcofmw7uc8ah	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Filter and sort cards	{"contentOrder":["a4fz9kcfs9ibj8puk9mux7ac94c","ac97q9macgtgg8nawsmwyhsbwca","78i8aqjmqtibr7x4okhz6uqquqr","714ymz3mujfdi9c1u56g5hsw8bh"],"icon":"🎛️","isTemplate":false,"properties":{"a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1675955416605	1675955416605	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
cdy86cwon13n85k1498uqgckjmo	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Create a new view	{"contentOrder":["aozbezukpgif3jpbsq7tahmmp5e","agzxxkj19tfd5zxwje151ma8d4w","7owai1ux3h3gtf8byynfk6hyx1c","7n8jq1dizyfgotby3o91arf1hxh","77y4wffj1ctg7xmm9bx45qn6q6o","7xbpdkw5rdtgfjrajorxz9z1m5a"],"icon":"👓","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#adding-new-views","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"af3p8ztcyxgn8wd9z4az7o9tjeh","acypkejeb5yfujhj9te57p9kaxw":"ascd7nm9r491ayot8i86g1gmgqw"}}	1675955416610	1675955416610	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
ccosx7u14o3b9bngcrskhb59umo	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Add new properties	{"contentOrder":["aaj9oncuimtfeigzof3jn3j1kka","ayhk11qsuz789fk8bqae4oz8mro","7gc3z8cf8rirgfyutwoke9nn6jy","76cinqnb6k3dzmfbm9fnc8eofny","7u7omjjrqmpfwzghn1jsa4ha47w"],"icon":"🏷️","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html#add-and-manage-properties","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"af3p8ztcyxgn8wd9z4az7o9tjeh","acypkejeb5yfujhj9te57p9kaxw":"ascd7nm9r491ayot8i86g1gmgqw"}}	1675955416615	1675955416615	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
cd1hudbdx63dt7mym7hxee6kzrc	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	@mention teammates	{"contentOrder":["ay7zz768zs7gb5e1h8qximpwq9a","an3ts498ri7bwffx31agx89zzuw","7mbw9t71hjbrydgzgkqqaoh8usr","7ttgph9jfotfxzphrb1wmyjzw1c"],"icon":"🔔","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html#mention-people","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1675955416619	1675955416619	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
a1enn3jnusffjuc4ciqrfc197fr	2023-02-09 15:10:16.551755+00	crkth4zwoppf6me17xb1sf7m7wr	1	text	To create a new card, simply do any of the following:\n- Select "**New**" on the top right header\n- Select "**+ New**" below any column\n- Select "**+**" to the right of any columnn header	{}	1675955416748	1675955416748	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
vknytio9am3r1ip5xkn179ymuac	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	view	Preview: Table View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":280,"a972dc7a-5f4c-45d2-8044-8c28c69717f1":100,"acypkejeb5yfujhj9te57p9kaxw":169},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a972dc7a-5f4c-45d2-8044-8c28c69717f1","aqh13jabwexjkzr3jqsz1i1syew","acmg7mz1rr1eykfug4hcdpb1y1o","acypkejeb5yfujhj9te57p9kaxw"]}	1675955416625	1675955416625	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
vprztdsecdb888pw11kzogsysde	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	view	Preview: Calendar View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"acmg7mz1rr1eykfug4hcdpb1y1o","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955416633	1675955416633	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
vyc7c3kwj6ibn7y8cr6rqwdtjwo	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	view	Preview: Gallery View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"gallery","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955416640	1675955416640	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
vuiygiikw4bywbyxto8n4ekg8gh	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	view	Onboarding	{"cardOrder":["crkth4zwoppf6me17xb1sf7m7wr","c561c93bfjjyp7gsda4qk6d9dca","ct5kpq5rgqidtik98waz1m5fdqo","cafahsprdajymd83b1dzr4sj91w","ccosx7u14o3b9bngcrskhb59umo","cdy86cwon13n85k1498uqgckjmo","cd1hudbdx63dt7mym7hxee6kzrc","c5wz7jz8at3gx8brn8jcz7u3ujh","chwbzoteop38obrffjnbye8kkph","copdhfsz6e3gg3yqcofmw7uc8ah"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a972dc7a-5f4c-45d2-8044-8c28c69717f1","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["aqb5x3pt87dcc9stbk4ofodrpoy","a1mtm777bkagq3iuu7xo9b13qfr","auxbwzptiqzkii5r61uz3ndsy1r","aj9386k1bx8qwmepeuxg3b7z4pw"],"visiblePropertyIds":[]}	1675955416646	1675955416646	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
aanpn1chdbirddfu4obqi3rieew	2023-02-09 15:10:16.551755+00	c5wz7jz8at3gx8brn8jcz7u3ujh	1	text	Mattermost Boards makes it easy for you to update certain properties on cards through our drag and drop functionality. Simply drag this card from the **Later** column to the **Completed** column to automatically update the status and mark this task as complete.	{}	1675955416652	1675955416652	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7kc44wypp1jnzmm3qh7ocx3t69e	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	Assign tasks to teammates	{"value":false}	1675955416657	1675955416657	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7ny8o9rq7e3rsbyoogjmgetgspa	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	Create and manage checklists, like this one... :)	{"value":false}	1675955416664	1675955416664	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7w4sjknti5pyd5kbkpoba1tkf8h	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	Add and update descriptions with Markdown	{"value":false}	1675955416670	1675955416670	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7413u4xnrebnf5gypfbzc3yokce	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	Follow cards to get notified on the latest updates	{"value":false}	1675955416675	1675955416675	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
71wbc54cp57yw5x84ih1u7b3bxw	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	Set priorities and update statuses	{"value":false}	1675955416681	1675955416681	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7gr65cgf58bgzmfun9odcmk14hr	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	Provide feedback and ask questions via comments	{"value":false}	1675955416687	1675955416687	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7htefhgxktin4fnfcac7ncuty3a	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	@mention teammates so they can follow, and collaborate on, comments and descriptions	{"value":false}	1675955416693	1675955416693	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7zudf4ytye3y69dtwtfkagbi7zh	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	Manage deadlines and milestones	{"value":false}	1675955416701	1675955416700	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
azz8hdz4357fq8fwghbqz7e88ww	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	text	Cards allow your entire team to manage and collaborate on a task in one place. Within a card, your team can:	{}	1675955416707	1675955416707	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7qp41kosg67bkbppoqt1c64yu6h	2023-02-09 15:10:16.551755+00	ct5kpq5rgqidtik98waz1m5fdqo	1	image		{"fileId":"74uia99m9btr8peydw7oexn37tw.gif"}	1675955416713	1675955416713	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
at1gc3nj44pfmtchdhm463rsugr	2023-02-09 15:10:16.551755+00	ct5kpq5rgqidtik98waz1m5fdqo	1	text	A board helps you manage your project, organize tasks, and collaborate with your team all in one place.	{}	1675955416717	1675955416717	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
atkhpnbj8qjgyzyac48o36u4xpw	2023-02-09 15:10:16.551755+00	ct5kpq5rgqidtik98waz1m5fdqo	1	text	To create your own board, select the "+" on the top of the left hand sidebar. Choose from one of our standard templates and see how they can help you get started with your next project:\n\n- **Project Tasks**: Stay on top of your project tasks, track progress, and set priorities. \n- **Meeting Agenda**: Set your meeting agendas for recurring team meetings and 1:1s.\n- **Roadmap**: Plan your roadmap and manage your releases more efficiently.\n- **Personal Tasks**: Organize your life and track your personal tasks.\n- **Content Calendar**: Plan your editorial content, assign work, and track deadlines.\n- **Personal Goals**: Set and accomplish new personal goals and milestones.	{}	1675955416722	1675955416722	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7j9bhj4sh8iytxpnu1o1gpfyh6o	2023-02-09 15:10:16.551755+00	chwbzoteop38obrffjnbye8kkph	1	image		{"fileId":"7knxbyuiedtdafcgmropgkrtybr.gif"}	1675955416728	1675955416728	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
aj9qonaknubbcjc3txbjxqo5y7a	2023-02-09 15:10:16.551755+00	chwbzoteop38obrffjnbye8kkph	1	text	Keep stakeholders and customers up-to-date on project progress by sharing your board.	{}	1675955416733	1675955416733	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
aqop7km57rpnpmfg6mro767ukaa	2023-02-09 15:10:16.551755+00	chwbzoteop38obrffjnbye8kkph	1	text	To share a board, select **Share** at the top right of the Board view. Copy the link to share the board internally with your team or generate public link that can be accessed by anyone externally.	{}	1675955416738	1675955416738	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
aoe9xan7bat8imn45t4x4knq11e	2023-02-09 15:10:16.551755+00	cafahsprdajymd83b1dzr4sj91w	1	text	After you've copied the link, paste it into any channel or Direct Message to share the card. A preview of the card will display within the channel with a link back to the card on Boards.	{}	1675955416760	1675955416760	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
ai4qtbj8quiywfxdrorts7dsf3h	2023-02-09 15:10:16.551755+00	cafahsprdajymd83b1dzr4sj91w	1	text	To share a card, you'll need to copy the card link first. You can:\n\n- Open a card and select the options menu button at the top right of the card.\n- Open the board view and hover your mouse over any card to access the options menu button.	{}	1675955416765	1675955416765	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
akr4w845sp3dgty4cayg6wrz96a	2023-02-09 15:10:16.551755+00	cafahsprdajymd83b1dzr4sj91w	1	text	Cards can be linked and shared with teammates directly on Channels. Card previews are displayed when shared on Channels, so your team can discuss work items and get the relevant context without having to switch over to Boards.	{}	1675955416769	1675955416769	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
714ymz3mujfdi9c1u56g5hsw8bh	2023-02-09 15:10:16.551755+00	copdhfsz6e3gg3yqcofmw7uc8ah	1	image		{"fileId":"7dybb6t8fj3nrdft7nerhuf784y.png"}	1675955416774	1675955416774	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
ac97q9macgtgg8nawsmwyhsbwca	2023-02-09 15:10:16.551755+00	copdhfsz6e3gg3yqcofmw7uc8ah	1	text	Organize and find the cards you're looking for with our filter, sort, and grouping options. From the Board header, you can quickly toggle on different properties, change the group display, set filters, and change how the cards are sorted.	{}	1675955416779	1675955416779	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7xbpdkw5rdtgfjrajorxz9z1m5a	2023-02-09 15:10:16.551755+00	cdy86cwon13n85k1498uqgckjmo	1	image		{"fileId":"78jws5m1myf8pufewzkaa6i11sc.gif"}	1675955416783	1675955416783	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
agzxxkj19tfd5zxwje151ma8d4w	2023-02-09 15:10:16.551755+00	cdy86cwon13n85k1498uqgckjmo	1	text	Views allow your team to visualize the same cards and data from different perspectives, so they can stay up-to-date in the way that works best for them. To add a new view, go to **Add a new view** from the view drop-down, then select from any of the following views:\n\n- **Board**: Adds a Kanban board, similar to this one, that allows your team to organize cards in swimlanes grouped by any property of your choosing. This view helps you visualize your project progress.\n- **Table**: Displays cards in a table format with rows and columns. Use this view to get an overview of all your project tasks. Easily view and compare the state of all properties across all cards without needing to open individual cards.\n- **Gallery**: Displays cards in a gallery format, so you can manage and organize cards with image attachments.\n- **Calendar**: Adds a calendar view to easily visualize your cards by dates and keep track of deadlines.	{}	1675955416786	1675955416786	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7u7omjjrqmpfwzghn1jsa4ha47w	2023-02-09 15:10:16.551755+00	ccosx7u14o3b9bngcrskhb59umo	1	image		{"fileId":"7d6hrtig3zt8f9cnbo1um5oxx3y.gif"}	1675955416790	1675955416790	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
aaj9oncuimtfeigzof3jn3j1kka	2023-02-09 15:10:16.551755+00	ccosx7u14o3b9bngcrskhb59umo	1	text	Customize cards to fit your needs and track the information most important to you. Boards supports a wide range of fully customizable property types. For example, you can:\n- Use the **Date** property for things like deadlines or milestones.\n- Assign owners to tasks with the **Person** property.\n- Define statuses and priorities with the **Select** property.\n- Create tags with the **Multi Select** property.\n- Link cards to webpages with the **URL** property.	{}	1675955416794	1675955416794	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7ttgph9jfotfxzphrb1wmyjzw1c	2023-02-09 15:10:16.551755+00	cd1hudbdx63dt7mym7hxee6kzrc	1	image		{"fileId":"74nt9eqzea3ydjjpgjtsxcjgrxc.gif"}	1675955416799	1675955416799	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
an3ts498ri7bwffx31agx89zzuw	2023-02-09 15:10:16.551755+00	cd1hudbdx63dt7mym7hxee6kzrc	1	text	To mention a teammate use the **@ symbol with their username** in the comments or description section. They'll get a Direct Message notification via Channels and also be added as a [follower](https://docs.mattermost.com/boards/work-with-cards.html#receive-updates) to the card. \n\nWhenever any changes are made to the card, they'll automatically get notified on Channels.	{}	1675955416803	1675955416803	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
ay7zz768zs7gb5e1h8qximpwq9a	2023-02-09 15:10:16.551755+00	cd1hudbdx63dt7mym7hxee6kzrc	1	text	Collaborate with teammates directly on each card using @mentions and have all the relevant context in one place.	{}	1675955416807	1675955416807	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
\.


--
-- Data for Name: focalboard_board_members; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_board_members (board_id, user_id, roles, scheme_admin, scheme_editor, scheme_commenter, scheme_viewer) FROM stdin;
bgrnqmugsw3gijk4i4iynp6b15o	system		t	f	f	f
ba4tbc4q9kb8ytjfs9kgx7jzjqy	system		t	f	f	f
b7ziufq456id898g6qn6hocdahe	system		t	f	f	f
bzuetargh8tfgtdj4tt8t9w6ora	system		t	f	f	f
bhiem3kc7pj85585qw3abgs7psa	system		t	f	f	f
bdjegdwuc3fr3jxmg7sgcn6mtww	system		t	f	f	f
bazsdbbtz87gjp8ud7jkskiqzuc	system		t	f	f	f
bujaeu6ekrtdtjyx1xnaptf3szc	system		t	f	f	f
bhaxk1xppmtgnjrxua4dsakij5e	system		t	f	f	f
bg5b5bwqbotr19ke4zt7j9q8xqr	system		t	f	f	f
b6p46z69w8pdyzd8xyn6mg9xxmr	system		t	f	f	f
bhqt3na6kk78afbkt11p7rw1eha	system		t	f	f	f
bgddz141a8j8kdp69mnntpbgoor	system		t	f	f	f
\.


--
-- Data for Name: focalboard_board_members_history; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_board_members_history (board_id, user_id, action, insert_at) FROM stdin;
bgrnqmugsw3gijk4i4iynp6b15o	system	created	2023-02-09 15:10:10.890716+00
ba4tbc4q9kb8ytjfs9kgx7jzjqy	system	created	2023-02-09 15:10:12.184233+00
b7ziufq456id898g6qn6hocdahe	system	created	2023-02-09 15:10:12.811408+00
bzuetargh8tfgtdj4tt8t9w6ora	system	created	2023-02-09 15:10:14.168649+00
bhiem3kc7pj85585qw3abgs7psa	system	created	2023-02-09 15:10:14.420936+00
bdjegdwuc3fr3jxmg7sgcn6mtww	system	created	2023-02-09 15:10:14.582178+00
bazsdbbtz87gjp8ud7jkskiqzuc	system	created	2023-02-09 15:10:15.023543+00
bujaeu6ekrtdtjyx1xnaptf3szc	system	created	2023-02-09 15:10:15.256418+00
bhaxk1xppmtgnjrxua4dsakij5e	system	created	2023-02-09 15:10:15.51612+00
bg5b5bwqbotr19ke4zt7j9q8xqr	system	created	2023-02-09 15:10:15.85282+00
b6p46z69w8pdyzd8xyn6mg9xxmr	system	created	2023-02-09 15:10:15.987721+00
bhqt3na6kk78afbkt11p7rw1eha	system	created	2023-02-09 15:10:16.508824+00
bgddz141a8j8kdp69mnntpbgoor	system	created	2023-02-09 15:10:17.158334+00
\.


--
-- Data for Name: focalboard_boards; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_boards (id, insert_at, team_id, channel_id, created_by, modified_by, type, title, description, icon, show_description, is_template, template_version, properties, card_properties, create_at, update_at, delete_at, minimum_role) FROM stdin;
bgrnqmugsw3gijk4i4iynp6b15o	2023-02-09 15:10:10.121663+00	0		system	system	O	Meeting Agenda 	Use this template for recurring meeting agendas, like team meetings and 1:1's. To use this board:\n* Participants queue new items to discuss under "To Discuss"\n* Go through items during the meeting\n* Move items to Done or Revisit Later as needed	🍩	t	t	6	{"trackingTemplateId": "54fcf9c610f0ac5e4c522c0657c90602"}	[{"id": "d777ba3b-8728-40d1-87a6-59406bbbbfb0", "name": "Status", "type": "select", "options": [{"id": "34eb9c25-d5bf-49d9-859e-f74f4e0030e7", "color": "propColorPink", "value": "To Discuss 💬"}, {"id": "d37a61f4-f332-4db9-8b2d-5e0a91aa20ed", "color": "propColorYellow", "value": "Revisit Later ⏳"}, {"id": "dabadd9b-adf1-4d9f-8702-805ac6cef602", "color": "propColorGreen", "value": "Done / Archived 📦"}]}, {"id": "4cf1568d-530f-4028-8ffd-bdc65249187e", "name": "Priority", "type": "select", "options": [{"id": "8b05c83e-a44a-4d04-831e-97f01d8e2003", "color": "propColorRed", "value": "1. High"}, {"id": "b1abafbf-a038-4a19-8b68-56e0fd2319f7", "color": "propColorYellow", "value": "2. Medium"}, {"id": "2491ffaa-eb55-417b-8aff-4bd7d4136613", "color": "propColorGray", "value": "3. Low"}]}, {"id": "aw4w63xhet79y9gueqzzeiifdoe", "name": "Created by", "type": "createdBy", "options": []}, {"id": "a6ux19353xcwfqg9k1inqg5sg4w", "name": "Created time", "type": "createdTime", "options": []}]	1675955410124	1675955410124	0	
ba4tbc4q9kb8ytjfs9kgx7jzjqy	2023-02-09 15:10:10.921795+00	0		system	system	O	Sales Pipeline CRM	Use this template to grow and keep track of your sales opportunities.	📈	t	t	6	{"trackingTemplateId": "ecc250bb7dff0fe02247f1110f097544"}	[{"id": "a5hwxjsmkn6bak6r7uea5bx1kwc", "name": "Status", "type": "select", "options": [{"id": "akj61wc9yxdwyw3t6m8igyf9d5o", "color": "propColorGray", "value": "Lead"}, {"id": "aic89a5xox4wbppi6mbyx6ujsda", "color": "propColorYellow", "value": "Qualified"}, {"id": "ah6ehh43rwj88jy4awensin8pcw", "color": "propColorBrown", "value": "Meeting"}, {"id": "aprhd96zwi34o9cs4xyr3o9sf3c", "color": "propColorPurple", "value": "Proposal"}, {"id": "axesd74yuxtbmw1sbk8ufax7z3a", "color": "propColorOrange", "value": "Negotiation"}, {"id": "a5txuiubumsmrs8gsd5jz5gc1oa", "color": "propColorRed", "value": "Lost"}, {"id": "acm9q494bcthyoqzmfogxxy5czy", "color": "propColorGreen", "value": "Closed 🏆"}]}, {"id": "aoheuj1f3mu6eehygr45fxa144y", "name": "Account Owner", "type": "multiPerson", "options": []}, {"id": "aro91wme9kfaie5ceu9qasmtcnw", "name": "Priority", "type": "select", "options": [{"id": "apjnaggwixchfxwiatfh7ey7uno", "color": "propColorRed", "value": "High 🔥"}, {"id": "apiswzj7uiwbh87z8dw8c6mturw", "color": "propColorYellow", "value": "Medium"}, {"id": "auu9bfzqeuruyjwzzqgz7q8apuw", "color": "propColorBrown", "value": "Low"}]}, {"id": "ainpw47babwkpyj77ic4b9zq9xr", "name": "Company", "type": "text", "options": []}, {"id": "ahf43e44h3y8ftanqgzno9z7q7w", "name": "Estimated Value", "type": "number", "options": []}, {"id": "amahgyn9n4twaapg3jyxb6y4jic", "name": "Territory", "type": "select", "options": [{"id": "ar6t1ttcumgfuqugg5o4g4mzrza", "color": "propColorBrown", "value": "Western US"}, {"id": "asbwojkm7zb4ohrtij97jkdfgwe", "color": "propColorGreen", "value": "Mountain West / Central US"}, {"id": "aw8ppwtcrm8iwopdadje3ni196w", "color": "propColorGray", "value": "Mid-Atlantic / Southeast"}, {"id": "aafwyza5iwdcwcyfyj6bp7emufw", "color": "propColorBlue", "value": "Northeast US / Canada"}, {"id": "agw8rcb9uxyt3c7g6tq3r65fgqe", "color": "propColorPink", "value": "Eastern Europe"}, {"id": "as5bk6afoaaa7caewe1zc391sce", "color": "propColorPurple", "value": "Central Europe / Africa"}, {"id": "a8fj94bka8z9t6p95qd3hn6t5re", "color": "propColorYellow", "value": "Middle East"}, {"id": "arpxa3faaou9trt4zx5sh435gne", "color": "propColorOrange", "value": "UK"}, {"id": "azdidd5wze4kcxf8neefj3ctkyr", "color": "propColorRed", "value": "Asia"}, {"id": "a4jn5mhqs3thknqf5opykntgsnc", "color": "propColorGray", "value": "Australia"}, {"id": "afjbgrecb7hp5owj7xh8u4w33tr", "color": "propColorBrown", "value": "Latin America"}]}, {"id": "abru6tz8uebdxy4skheqidh7zxy", "name": "Email", "type": "email", "options": []}, {"id": "a1438fbbhjeffkexmcfhnx99o1h", "name": "Phone", "type": "phone", "options": []}, {"id": "auhf91pm85f73swwidi4wid8jqe", "name": "Last Contact Date", "type": "date", "options": []}, {"id": "adtf1151chornmihz4xbgbk9exa", "name": "Expected Close", "type": "date", "options": []}, {"id": "aejo5tcmq54bauuueem9wc4fw4y", "name": "Close Probability", "type": "text", "options": []}, {"id": "amba7ot98fh7hwsx8jdcfst5g7h", "name": "Created Date", "type": "createdTime", "options": []}]	1675955410925	1675955410925	0	
b7ziufq456id898g6qn6hocdahe	2023-02-09 15:10:12.186101+00	0		system	system	O	Personal Tasks 	Use this template to organize your life and track your personal tasks.	✔️	t	t	6	{"trackingTemplateId": "dfb70c146a4584b8a21837477c7b5431"}	[{"id": "a9zf59u8x1rf4ywctpcqama7tio", "name": "Occurrence", "type": "select", "options": [{"id": "an51dnkenmoog9cetapbc4uyt3y", "color": "propColorBlue", "value": "Daily"}, {"id": "afpy8s7i45frggprmfsqngsocqh", "color": "propColorOrange", "value": "Weekly"}, {"id": "aj4jyekqqssatjcq7r7chmy19ey", "color": "propColorPurple", "value": "Monthly"}]}, {"id": "abthng7baedhhtrwsdodeuincqy", "name": "Completed", "type": "checkbox", "options": []}]	1675955412192	1675955412192	0	
bzuetargh8tfgtdj4tt8t9w6ora	2023-02-09 15:10:12.994972+00	0		system	system	O	Project Tasks 	Use this template to stay on top of your project tasks and progress.	🎯	t	t	6	{"trackingTemplateId": "a4ec399ab4f2088b1051c3cdf1dde4c3"}	[{"id": "a972dc7a-5f4c-45d2-8044-8c28c69717f1", "name": "Status", "type": "select", "options": [{"id": "ayz81h9f3dwp7rzzbdebesc7ute", "color": "propColorBlue", "value": "Not Started"}, {"id": "ar6b8m3jxr3asyxhr8iucdbo6yc", "color": "propColorYellow", "value": "In Progress"}, {"id": "afi4o5nhnqc3smtzs1hs3ij34dh", "color": "propColorRed", "value": "Blocked"}, {"id": "adeo5xuwne3qjue83fcozekz8ko", "color": "propColorGreen", "value": "Completed 🙌"}, {"id": "ahpyxfnnrzynsw3im1psxpkgtpe", "color": "propColorBrown", "value": "Archived"}]}, {"id": "d3d682bf-e074-49d9-8df5-7320921c2d23", "name": "Priority", "type": "select", "options": [{"id": "d3bfb50f-f569-4bad-8a3a-dd15c3f60101", "color": "propColorRed", "value": "1. High 🔥"}, {"id": "87f59784-b859-4c24-8ebe-17c766e081dd", "color": "propColorYellow", "value": "2. Medium"}, {"id": "98a57627-0f76-471d-850d-91f3ed9fd213", "color": "propColorGray", "value": "3. Low"}]}, {"id": "axkhqa4jxr3jcqe4k87g8bhmary", "name": "Assignee", "type": "person", "options": []}, {"id": "a8daz81s4xjgke1ww6cwik5w7ye", "name": "Estimated Hours", "type": "number", "options": []}, {"id": "a3zsw7xs8sxy7atj8b6totp3mby", "name": "Due Date", "type": "date", "options": []}, {"id": "a7gdnz8ff8iyuqmzddjgmgo9ery", "name": "Created By", "type": "createdBy", "options": []}, {"id": "2a5da320-735c-4093-8787-f56e15cdfeed", "name": "Date Created", "type": "createdTime", "options": []}]	1675955412997	1675955412997	0	
bhiem3kc7pj85585qw3abgs7psa	2023-02-09 15:10:14.174793+00	0		system	system	O	Company Goals & OKRs	Use this template to plan your company goals and OKRs more efficiently.	⛳	t	t	6	{"trackingTemplateId": "7ba22ccfdfac391d63dea5c4b8cde0de"}	[{"id": "a6amddgmrzakw66cidqzgk6p4ge", "name": "Objective", "type": "select", "options": [{"id": "auw3afh3kfhrfgmjr8muiz137jy", "color": "propColorGreen", "value": "Grow Revenue"}, {"id": "apqfjst8massbjjhpcsjs3y1yqa", "color": "propColorOrange", "value": "Delight Customers"}, {"id": "ao9b5pxyt7tkgdohzh9oaustdhr", "color": "propColorPurple", "value": "Drive Product Adoption"}]}, {"id": "a17ryhi1jfsboxkwkztwawhmsxe", "name": "Status", "type": "select", "options": [{"id": "a6robxx81diugpjq5jkezz3j1fo", "color": "propColorGray", "value": "Not Started"}, {"id": "a8nukezwwmknqwjsygg7eaxs9te", "color": "propColorBlue", "value": "In Progress"}, {"id": "apnt1f7na9rzgk1rt49keg7xbiy", "color": "propColorYellow", "value": "At Risk"}, {"id": "axbz3m1amss335wzwf9s7pqjzxr", "color": "propColorRed", "value": "Missed"}, {"id": "abzfwnn6rmtfzyq5hg8uqmpsncy", "color": "propColorGreen", "value": "Complete 🙌"}]}, {"id": "azzbawji5bksj69sekcs4srm1ky", "name": "Department", "type": "select", "options": [{"id": "aw5i7hmpadn6mbwbz955ubarhme", "color": "propColorBrown", "value": "Engineering"}, {"id": "afkxpcjqjypu7hhar7banxau91h", "color": "propColorBlue", "value": "Product"}, {"id": "aehoa17cz18rqnrf75g7dwhphpr", "color": "propColorOrange", "value": "Marketing"}, {"id": "agrfeaoj7d8p5ianw5iaf3191ae", "color": "propColorGreen", "value": "Sales"}, {"id": "agm9p6gcq15ueuzqq3wd4be39wy", "color": "propColorYellow", "value": "Support"}, {"id": "aucop7kw6xwodcix6zzojhxih6r", "color": "propColorPink", "value": "Design"}, {"id": "afust91f3g8ht368mkn5x9tgf1o", "color": "propColorPurple", "value": "Finance"}, {"id": "acocxxwjurud1jixhp7nowdig7y", "color": "propColorGray", "value": "Human Resources"}]}, {"id": "adp5ft3kgz7r5iqq3tnwg551der", "name": "Priority", "type": "select", "options": [{"id": "a8zg3rjtf4swh7smsjxpsn743rh", "color": "propColorRed", "value": "P1 🔥"}, {"id": "as555ipyzopjjpfb5rjtssecw5e", "color": "propColorYellow", "value": "P2"}, {"id": "a1ts3ftyr8nocsicui98c89uxjy", "color": "propColorGray", "value": "P3"}]}, {"id": "aqxyzkdrs4egqf7yk866ixkaojc", "name": "Quarter", "type": "select", "options": [{"id": "ahfbn1jsmhydym33ygxwg5jt3kh", "color": "propColorBlue", "value": "Q1"}, {"id": "awfu37js3fomfkkczm1zppac57a", "color": "propColorBrown", "value": "Q2"}, {"id": "anruuoyez51r3yjxuoc8zoqnwaw", "color": "propColorGreen", "value": "Q3"}, {"id": "acb6dqqs6yson7bbzx6jk9bghjh", "color": "propColorPurple", "value": "Q4"}]}, {"id": "adu6mebzpibq6mgcswk69xxmnqe", "name": "Due Date", "type": "date", "options": []}, {"id": "asope3bddhm4gpsng5cfu4hf6rh", "name": "Assignee", "type": "multiPerson", "options": []}, {"id": "ajwxp866f9obs1kutfwaa5ru7fe", "name": "Target", "type": "number", "options": []}, {"id": "azqnyswk6s1boiwuthscm78qwuo", "name": "Actual", "type": "number", "options": []}, {"id": "ahz3fmjnaguec8hce7xq3h5cjdr", "name": "Completion (%)", "type": "text", "options": []}, {"id": "a17bfcgnzmkwhziwa4tr38kiw5r", "name": "Note", "type": "text", "options": []}]	1675955414178	1675955414178	0	
bdjegdwuc3fr3jxmg7sgcn6mtww	2023-02-09 15:10:14.424408+00	0		system	system	O	Personal Goals 	Use this template to set and accomplish new personal goals.	⛰️	t	t	6	{"trackingTemplateId": "7f32dc8d2ae008cfe56554e9363505cc"}	[{"id": "af6fcbb8-ca56-4b73-83eb-37437b9a667d", "name": "Status", "type": "select", "options": [{"id": "bf52bfe6-ac4c-4948-821f-83eaa1c7b04a", "color": "propColorRed", "value": "To Do"}, {"id": "77c539af-309c-4db1-8329-d20ef7e9eacd", "color": "propColorYellow", "value": "Doing"}, {"id": "98bdea27-0cce-4cde-8dc6-212add36e63a", "color": "propColorGreen", "value": "Done 🙌"}]}, {"id": "d9725d14-d5a8-48e5-8de1-6f8c004a9680", "name": "Category", "type": "select", "options": [{"id": "3245a32d-f688-463b-87f4-8e7142c1b397", "color": "propColorPurple", "value": "Life Skills"}, {"id": "80be816c-fc7a-4928-8489-8b02180f4954", "color": "propColorGreen", "value": "Finance"}, {"id": "ffb3f951-b47f-413b-8f1d-238666728008", "color": "propColorOrange", "value": "Health"}]}, {"id": "d6b1249b-bc18-45fc-889e-bec48fce80ef", "name": "Target", "type": "select", "options": [{"id": "9a090e33-b110-4268-8909-132c5002c90e", "color": "propColorBlue", "value": "Q1"}, {"id": "0a82977f-52bf-457b-841b-e2b7f76fb525", "color": "propColorBrown", "value": "Q2"}, {"id": "6e7139e4-5358-46bb-8c01-7b029a57b80a", "color": "propColorGreen", "value": "Q3"}, {"id": "d5371c63-66bf-4468-8738-c4dc4bea4843", "color": "propColorPurple", "value": "Q4"}]}, {"id": "ajy6xbebzopojaenbnmfpgtdwso", "name": "Due Date", "type": "date", "options": []}]	1675955414427	1675955414427	0	
bazsdbbtz87gjp8ud7jkskiqzuc	2023-02-09 15:10:14.585839+00	0		system	system	O	Sprint Planner 	Use this template to plan your sprints and manage your releases more efficiently.	🗓️	t	t	6	{"trackingTemplateId": "99b74e26d2f5d0a9b346d43c0a7bfb09"}	[{"id": "50117d52-bcc7-4750-82aa-831a351c44a0", "name": "Status", "type": "select", "options": [{"id": "aft5bzo7h9aspqgrx3jpy5tzrer", "color": "propColorGray", "value": "Not Started"}, {"id": "abrfos7e7eczk9rqw6y5abadm1y", "color": "propColorOrange", "value": "Next Up"}, {"id": "ax8wzbka5ahs3zziji3pp4qp9mc", "color": "propColorBlue", "value": "In Progress"}, {"id": "atabdfbdmjh83136d5e5oysxybw", "color": "propColorYellow", "value": "In Review"}, {"id": "ace1bzypd586kkyhcht5qqd9eca", "color": "propColorPink", "value": "Approved"}, {"id": "aay656c9m1hzwxc9ch5ftymh3nw", "color": "propColorRed", "value": "Blocked"}, {"id": "a6ghze4iy441qhsh3eijnc8hwze", "color": "propColorGreen", "value": "Complete 🙌"}]}, {"id": "20717ad3-5741-4416-83f1-6f133fff3d11", "name": "Type", "type": "select", "options": [{"id": "424ea5e3-9aa1-4075-8c5c-01b44b66e634", "color": "propColorYellow", "value": "Epic ⛰"}, {"id": "a5yxq8rbubrpnoommfwqmty138h", "color": "propColorGray", "value": "Feature 🏗"}, {"id": "apht1nt5ryukdmxkh6fkfn6rgoy", "color": "propColorOrange", "value": "User Story 📖"}, {"id": "aiycbuo3dr5k4xxbfr7coem8ono", "color": "propColorGreen", "value": "Task ⛏"}, {"id": "aomnawq4551cbbzha9gxnmb3z5w", "color": "propColorRed", "value": "Bug 🐞"}]}, {"id": "60985f46-3e41-486e-8213-2b987440ea1c", "name": "Sprint", "type": "select", "options": [{"id": "c01676ca-babf-4534-8be5-cce2287daa6c", "color": "propColorBrown", "value": "Sprint 1"}, {"id": "ed4a5340-460d-461b-8838-2c56e8ee59fe", "color": "propColorPurple", "value": "Sprint 2"}, {"id": "14892380-1a32-42dd-8034-a0cea32bc7e6", "color": "propColorBlue", "value": "Sprint 3"}]}, {"id": "f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e", "name": "Priority", "type": "select", "options": [{"id": "cb8ecdac-38be-4d36-8712-c4d58cc8a8e9", "color": "propColorRed", "value": "P1 🔥"}, {"id": "e6a7f297-4440-4783-8ab3-3af5ba62ca11", "color": "propColorYellow", "value": "P2"}, {"id": "c62172ea-5da7-4dec-8186-37267d8ee9a7", "color": "propColorGray", "value": "P3"}]}, {"id": "aphg37f7zbpuc3bhwhp19s1ribh", "name": "Assignee", "type": "multiPerson", "options": []}, {"id": "a4378omyhmgj3bex13sj4wbpfiy", "name": "Due Date", "type": "date", "options": []}, {"id": "ai7ajsdk14w7x5s8up3dwir77te", "name": "Story Points", "type": "number", "options": []}, {"id": "a1g6i613dpe9oryeo71ex3c86hy", "name": "Design Link", "type": "url", "options": []}, {"id": "aeomttrbhhsi8bph31jn84sto6h", "name": "Created Time", "type": "createdTime", "options": []}, {"id": "ax9f8so418s6s65hi5ympd93i6a", "name": "Created By", "type": "createdBy", "options": []}]	1675955414592	1675955414592	0	
bujaeu6ekrtdtjyx1xnaptf3szc	2023-02-09 15:10:15.027456+00	0		system	system	O	User Research Sessions	Use this template to manage and keep track of all your user research sessions.	🔬	t	t	6	{"trackingTemplateId": "6c345c7f50f6833f78b7d0f08ce450a3"}	[{"id": "aaebj5fyx493eezx6ukxiwydgty", "name": "Status", "type": "select", "options": [{"id": "af6hjb3ysuaxbwnfqpby4wwnkdr", "color": "propColorGray", "value": "Backlog 📒"}, {"id": "aotxum1p5bw3xuzqz3ctjw66yww", "color": "propColorYellow", "value": "Contacted 📞"}, {"id": "a7yq89whddzob1futao4rxk3yzc", "color": "propColorBlue", "value": "Scheduled 📅"}, {"id": "aseqq9hrsua56r3s6nbuirj9eec", "color": "propColorRed", "value": "Cancelled 🚫"}, {"id": "ap93ysuzy1xa7z818r6myrn4h4y", "color": "propColorGreen", "value": "Completed ✔️"}]}, {"id": "akrxgi7p7w14fym3gbynb98t9fh", "name": "Interview Date", "type": "date", "options": []}, {"id": "atg9qu6oe4bjm8jczzsn71ff5me", "name": "Product Area", "type": "select", "options": [{"id": "ahn89mqg9u4igk6pdm7333t8i5h", "color": "propColorGreen", "value": "Desktop App"}, {"id": "aehc83ffays3gh8myz16a8j7k4e", "color": "propColorPurple", "value": "Web App"}, {"id": "a1sxagjgaadym5yrjak6tcup1oa", "color": "propColorBlue", "value": "Mobile App"}]}, {"id": "acjq4t5ymytu8x1f68wkggm7ypc", "name": "Email", "type": "email", "options": []}, {"id": "aphio1s5gkmpdbwoxynim7acw3e", "name": "Interviewer", "type": "multiPerson", "options": []}, {"id": "aqafzdeekpyncwz7m7i54q3iqqy", "name": "Recording URL", "type": "url", "options": []}, {"id": "aify3r761b9w43bqjtskrzi68tr", "name": "Passcode", "type": "text", "options": []}]	1675955415030	1675955415030	0	
bg5b5bwqbotr19ke4zt7j9q8xqr	2023-02-09 15:10:15.523642+00	0		system	system	O	Content Calendar 	Use this template to plan and organize your editorial content.	📅	t	t	6	{"trackingTemplateId": "c75fbd659d2258b5183af2236d176ab4"}	[{"id": "ae9ar615xoknd8hw8py7mbyr7zo", "name": "Status", "type": "select", "options": [{"id": "awna1nuarjca99m9s4uiy9kwj5h", "color": "propColorGray", "value": "Idea 💡"}, {"id": "a9ana1e9w673o5cp8md4xjjwfto", "color": "propColorOrange", "value": "Draft"}, {"id": "apy9dcd7zmand615p3h53zjqxjh", "color": "propColorPurple", "value": "In Review"}, {"id": "acri4cm3bmay55f7ksztphmtnga", "color": "propColorBlue", "value": "Ready to Publish"}, {"id": "amsowcd9a8e1kid317r7ttw6uzh", "color": "propColorGreen", "value": "Published 🎉"}]}, {"id": "aysx3atqexotgwp5kx6h5i5ancw", "name": "Type", "type": "select", "options": [{"id": "aywiofmmtd3ofgzj95ysky4pjga", "color": "propColorOrange", "value": "Press Release"}, {"id": "apqdgjrmsmx8ngmp7zst51647de", "color": "propColorGreen", "value": "Sponsored Post"}, {"id": "a3woynbjnb7j16e74uw3pubrytw", "color": "propColorPurple", "value": "Customer Story"}, {"id": "aq36k5pkpfcypqb3idw36xdi1fh", "color": "propColorRed", "value": "Product Release"}, {"id": "azn66pmk34adygnizjqhgiac4ia", "color": "propColorGray", "value": "Partnership"}, {"id": "aj8y675weso8kpb6eceqbpj4ruw", "color": "propColorBlue", "value": "Feature Announcement"}, {"id": "a3xky7ygn14osr1mokerbfah5cy", "color": "propColorYellow", "value": "Article"}]}, {"id": "ab6mbock6styfe6htf815ph1mhw", "name": "Channel", "type": "multiSelect", "options": [{"id": "a8xceonxiu4n3c43szhskqizicr", "color": "propColorBrown", "value": "Website"}, {"id": "a3pdzi53kpbd4okzdkz6khi87zo", "color": "propColorGreen", "value": "Blog"}, {"id": "a3d9ux4fmi3anyd11kyipfbhwde", "color": "propColorOrange", "value": "Email"}, {"id": "a8cbbfdwocx73zn3787cx6gacsh", "color": "propColorRed", "value": "Podcast"}, {"id": "aigjtpcaxdp7d6kmctrwo1ztaia", "color": "propColorPink", "value": "Print"}, {"id": "af1wsn13muho59e7ghwaogxy5ey", "color": "propColorBlue", "value": "Facebook"}, {"id": "a47zajfxwhsg6q8m7ppbiqs7jge", "color": "propColorGray", "value": "LinkedIn"}, {"id": "az8o8pfe9hq6s7xaehoqyc3wpyc", "color": "propColorYellow", "value": "Twitter"}]}, {"id": "ao44fz8nf6z6tuj1x31t9yyehcc", "name": "Assignee", "type": "person", "options": []}, {"id": "a39x5cybshwrbjpc3juaakcyj6e", "name": "Due Date", "type": "date", "options": []}, {"id": "agqsoiipowmnu9rdwxm57zrehtr", "name": "Publication Date", "type": "date", "options": []}, {"id": "ap4e7kdg7eip7j3c3oyiz39eaoc", "name": "Link", "type": "url", "options": []}]	1675955415541	1675955415541	0	
b6p46z69w8pdyzd8xyn6mg9xxmr	2023-02-09 15:10:15.867257+00	0		system	system	O	Team Retrospective	Use this template at the end of your project or sprint to identify what worked well and what can be improved for the future.	🧭	t	t	6	{"trackingTemplateId": "e4f03181c4ced8edd4d53d33d569a086"}	[{"id": "adjckpdotpgkz7c6wixzw9ipb1e", "name": "Category", "type": "select", "options": [{"id": "aok6pgecm85qe9k5kcphzoe63ma", "color": "propColorGray", "value": "To Discuss 📣"}, {"id": "aq1dwbf661yx337hjcd5q3sbxwa", "color": "propColorGreen", "value": "Went Well 👍"}, {"id": "ar87yh5xmsswqkxmjq1ipfftfpc", "color": "propColorRed", "value": "Didn't Go Well 🚫"}, {"id": "akj3fkmxq7idma55mdt8sqpumyw", "color": "propColorBlue", "value": "Action Items ✅"}]}, {"id": "aspaay76a5wrnuhtqgm97tt3rer", "name": "Details", "type": "text", "options": []}, {"id": "arzsm76s376y7suuhao3tu6efoc", "name": "Created By", "type": "createdBy", "options": []}, {"id": "a8anbe5fpa668sryatcdsuuyh8a", "name": "Created Time", "type": "createdTime", "options": []}]	1675955415870	1675955415870	0	
bhaxk1xppmtgnjrxua4dsakij5e	2023-02-09 15:10:15.260316+00	0		system	system	O	Competitive Analysis	Use this template to track and stay ahead of the competition.	🗂️	t	t	6	{"trackingTemplateId": "06f4bff367a7c2126fab2380c9dec23c"}	[{"id": "ahzspe59iux8wigra8bg6cg18nc", "name": "Website", "type": "url", "options": []}, {"id": "aozntq4go4nkab688j1s7stqtfc", "name": "Location", "type": "text", "options": []}, {"id": "aiefo7nh9jwisn8b4cgakowithy", "name": "Revenue", "type": "text", "options": []}, {"id": "a6cwaq79b1pdpb97wkanmeyy4er", "name": "Employees", "type": "number", "options": []}, {"id": "an1eerzscfxn6awdfajbg41uz3h", "name": "Founded", "type": "text", "options": []}, {"id": "a1semdhszu1rq17d7et5ydrqqio", "name": "Market Position", "type": "select", "options": [{"id": "arfjpz9by5car71tz3behba8yih", "color": "propColorYellow", "value": "Leader"}, {"id": "abajmr34b8g1916w495xjb35iko", "color": "propColorRed", "value": "Challenger"}, {"id": "abt79uxg5edqojsrrefcnr4eruo", "color": "propColorBlue", "value": "Follower"}, {"id": "aipf3qfgjtkheiayjuxrxbpk9wa", "color": "propColorBrown", "value": "Nicher"}]}, {"id": "aapogff3xoa8ym7xf56s87kysda", "name": "Last updated time", "type": "updatedTime", "options": []}, {"id": "az3jkw3ynd3mqmart7edypey15e", "name": "Last updated by", "type": "updatedBy", "options": []}]	1675955415264	1675955415264	0	
bhqt3na6kk78afbkt11p7rw1eha	2023-02-09 15:10:15.990252+00	0		system	system	O	Roadmap 	Use this template to plan your roadmap and manage your releases more efficiently.	🗺️	t	t	6	{"trackingTemplateId": "b728c6ca730e2cfc229741c5a4712b65"}	[{"id": "50117d52-bcc7-4750-82aa-831a351c44a0", "name": "Status", "type": "select", "options": [{"id": "8c557f69-b0ed-46ec-83a3-8efab9d47ef5", "color": "propColorGray", "value": "Not Started"}, {"id": "ec6d2bc5-df2b-4f77-8479-e59ceb039946", "color": "propColorYellow", "value": "In Progress"}, {"id": "849766ba-56a5-48d1-886f-21672f415395", "color": "propColorGreen", "value": "Complete 🙌"}]}, {"id": "20717ad3-5741-4416-83f1-6f133fff3d11", "name": "Type", "type": "select", "options": [{"id": "424ea5e3-9aa1-4075-8c5c-01b44b66e634", "color": "propColorYellow", "value": "Epic ⛰"}, {"id": "6eea96c9-4c61-4968-8554-4b7537e8f748", "color": "propColorGreen", "value": "Task 🔨"}, {"id": "1fdbb515-edd2-4af5-80fc-437ed2211a49", "color": "propColorRed", "value": "Bug 🐞"}]}, {"id": "60985f46-3e41-486e-8213-2b987440ea1c", "name": "Sprint", "type": "select", "options": [{"id": "c01676ca-babf-4534-8be5-cce2287daa6c", "color": "propColorBrown", "value": "Sprint 1"}, {"id": "ed4a5340-460d-461b-8838-2c56e8ee59fe", "color": "propColorPurple", "value": "Sprint 2"}, {"id": "14892380-1a32-42dd-8034-a0cea32bc7e6", "color": "propColorBlue", "value": "Sprint 3"}]}, {"id": "f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e", "name": "Priority", "type": "select", "options": [{"id": "cb8ecdac-38be-4d36-8712-c4d58cc8a8e9", "color": "propColorRed", "value": "P1 🔥"}, {"id": "e6a7f297-4440-4783-8ab3-3af5ba62ca11", "color": "propColorYellow", "value": "P2"}, {"id": "c62172ea-5da7-4dec-8186-37267d8ee9a7", "color": "propColorGray", "value": "P3"}]}, {"id": "aphg37f7zbpuc3bhwhp19s1ribh", "name": "Assignee", "type": "person", "options": []}, {"id": "a4378omyhmgj3bex13sj4wbpfiy", "name": "Due Date", "type": "date", "options": []}, {"id": "a36o9q1yik6nmar6ri4q4uca7ey", "name": "Created Date", "type": "createdTime", "options": []}, {"id": "ai7ajsdk14w7x5s8up3dwir77te", "name": "Design Link", "type": "url", "options": []}]	1675955415996	1675955415996	0	
bgddz141a8j8kdp69mnntpbgoor	2023-02-09 15:10:16.551755+00	0		system	system	O	Welcome to Boards!	Mattermost Boards is an open source project management tool that helps you organize, track, and manage work across teams. Select a card to learn more.	👋	t	t	6	{"trackingTemplateId": "65aba997282f3ac457cd66736fb86915"}	[{"id": "a972dc7a-5f4c-45d2-8044-8c28c69717f1", "name": "Status", "type": "select", "options": [{"id": "amm6wfhnbuxojwssyftgs9dipqe", "color": "propColorRed", "value": "To do 🔥"}, {"id": "af3p8ztcyxgn8wd9z4az7o9tjeh", "color": "propColorYellow", "value": "Next up"}, {"id": "ajurey3xkocs1nwx8di5zx6oe7o", "color": "propColorPurple", "value": "Later"}, {"id": "agkinkjy5983wsk6kppsujajxqw", "color": "propColorGreen", "value": "Completed 🙌"}]}, {"id": "acypkejeb5yfujhj9te57p9kaxw", "name": "Priority", "type": "select", "options": [{"id": "aanaehcw3m13jytujsjk5hpf6ry", "color": "propColorOrange", "value": "1. High"}, {"id": "ascd7nm9r491ayot8i86g1gmgqw", "color": "propColorBrown", "value": "2. Medium"}, {"id": "aq6ukoiciyfctgwyhwzpfss8ghe", "color": "propColorGray", "value": "3. Low"}]}, {"id": "aqh13jabwexjkzr3jqsz1i1syew", "name": "Assignee", "type": "person", "options": []}, {"id": "acmg7mz1rr1eykfug4hcdpb1y1o", "name": "Due Date", "type": "date", "options": []}, {"id": "amewjwfjrtpu8ha73xsrdmxazxr", "name": "Reviewed", "type": "checkbox", "options": []}, {"id": "attzzboqaz6m1sdti5xa7gjnk1e", "name": "Last updated time", "type": "updatedTime", "options": []}, {"id": "a4nfnb5xr3txr5xq7y9ho7kyz6c", "name": "Reference", "type": "url", "options": []}, {"id": "a9gzwi3dt5n55nddej6zcbhxaeh", "name": "Created by", "type": "createdBy", "options": []}]	1675955416554	1675955416554	0	
\.


--
-- Data for Name: focalboard_boards_history; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_boards_history (id, insert_at, team_id, channel_id, created_by, modified_by, type, title, description, icon, show_description, is_template, template_version, properties, card_properties, create_at, update_at, delete_at, minimum_role) FROM stdin;
bgrnqmugsw3gijk4i4iynp6b15o	2023-02-09 15:10:10.121663+00	0		system	system	O	Meeting Agenda 	Use this template for recurring meeting agendas, like team meetings and 1:1's. To use this board:\n* Participants queue new items to discuss under "To Discuss"\n* Go through items during the meeting\n* Move items to Done or Revisit Later as needed	🍩	t	t	6	{"trackingTemplateId": "54fcf9c610f0ac5e4c522c0657c90602"}	[{"id": "d777ba3b-8728-40d1-87a6-59406bbbbfb0", "name": "Status", "type": "select", "options": [{"id": "34eb9c25-d5bf-49d9-859e-f74f4e0030e7", "color": "propColorPink", "value": "To Discuss 💬"}, {"id": "d37a61f4-f332-4db9-8b2d-5e0a91aa20ed", "color": "propColorYellow", "value": "Revisit Later ⏳"}, {"id": "dabadd9b-adf1-4d9f-8702-805ac6cef602", "color": "propColorGreen", "value": "Done / Archived 📦"}]}, {"id": "4cf1568d-530f-4028-8ffd-bdc65249187e", "name": "Priority", "type": "select", "options": [{"id": "8b05c83e-a44a-4d04-831e-97f01d8e2003", "color": "propColorRed", "value": "1. High"}, {"id": "b1abafbf-a038-4a19-8b68-56e0fd2319f7", "color": "propColorYellow", "value": "2. Medium"}, {"id": "2491ffaa-eb55-417b-8aff-4bd7d4136613", "color": "propColorGray", "value": "3. Low"}]}, {"id": "aw4w63xhet79y9gueqzzeiifdoe", "name": "Created by", "type": "createdBy", "options": []}, {"id": "a6ux19353xcwfqg9k1inqg5sg4w", "name": "Created time", "type": "createdTime", "options": []}]	1675955410124	1675955410124	0	
ba4tbc4q9kb8ytjfs9kgx7jzjqy	2023-02-09 15:10:10.921795+00	0		system	system	O	Sales Pipeline CRM	Use this template to grow and keep track of your sales opportunities.	📈	t	t	6	{"trackingTemplateId": "ecc250bb7dff0fe02247f1110f097544"}	[{"id": "a5hwxjsmkn6bak6r7uea5bx1kwc", "name": "Status", "type": "select", "options": [{"id": "akj61wc9yxdwyw3t6m8igyf9d5o", "color": "propColorGray", "value": "Lead"}, {"id": "aic89a5xox4wbppi6mbyx6ujsda", "color": "propColorYellow", "value": "Qualified"}, {"id": "ah6ehh43rwj88jy4awensin8pcw", "color": "propColorBrown", "value": "Meeting"}, {"id": "aprhd96zwi34o9cs4xyr3o9sf3c", "color": "propColorPurple", "value": "Proposal"}, {"id": "axesd74yuxtbmw1sbk8ufax7z3a", "color": "propColorOrange", "value": "Negotiation"}, {"id": "a5txuiubumsmrs8gsd5jz5gc1oa", "color": "propColorRed", "value": "Lost"}, {"id": "acm9q494bcthyoqzmfogxxy5czy", "color": "propColorGreen", "value": "Closed 🏆"}]}, {"id": "aoheuj1f3mu6eehygr45fxa144y", "name": "Account Owner", "type": "multiPerson", "options": []}, {"id": "aro91wme9kfaie5ceu9qasmtcnw", "name": "Priority", "type": "select", "options": [{"id": "apjnaggwixchfxwiatfh7ey7uno", "color": "propColorRed", "value": "High 🔥"}, {"id": "apiswzj7uiwbh87z8dw8c6mturw", "color": "propColorYellow", "value": "Medium"}, {"id": "auu9bfzqeuruyjwzzqgz7q8apuw", "color": "propColorBrown", "value": "Low"}]}, {"id": "ainpw47babwkpyj77ic4b9zq9xr", "name": "Company", "type": "text", "options": []}, {"id": "ahf43e44h3y8ftanqgzno9z7q7w", "name": "Estimated Value", "type": "number", "options": []}, {"id": "amahgyn9n4twaapg3jyxb6y4jic", "name": "Territory", "type": "select", "options": [{"id": "ar6t1ttcumgfuqugg5o4g4mzrza", "color": "propColorBrown", "value": "Western US"}, {"id": "asbwojkm7zb4ohrtij97jkdfgwe", "color": "propColorGreen", "value": "Mountain West / Central US"}, {"id": "aw8ppwtcrm8iwopdadje3ni196w", "color": "propColorGray", "value": "Mid-Atlantic / Southeast"}, {"id": "aafwyza5iwdcwcyfyj6bp7emufw", "color": "propColorBlue", "value": "Northeast US / Canada"}, {"id": "agw8rcb9uxyt3c7g6tq3r65fgqe", "color": "propColorPink", "value": "Eastern Europe"}, {"id": "as5bk6afoaaa7caewe1zc391sce", "color": "propColorPurple", "value": "Central Europe / Africa"}, {"id": "a8fj94bka8z9t6p95qd3hn6t5re", "color": "propColorYellow", "value": "Middle East"}, {"id": "arpxa3faaou9trt4zx5sh435gne", "color": "propColorOrange", "value": "UK"}, {"id": "azdidd5wze4kcxf8neefj3ctkyr", "color": "propColorRed", "value": "Asia"}, {"id": "a4jn5mhqs3thknqf5opykntgsnc", "color": "propColorGray", "value": "Australia"}, {"id": "afjbgrecb7hp5owj7xh8u4w33tr", "color": "propColorBrown", "value": "Latin America"}]}, {"id": "abru6tz8uebdxy4skheqidh7zxy", "name": "Email", "type": "email", "options": []}, {"id": "a1438fbbhjeffkexmcfhnx99o1h", "name": "Phone", "type": "phone", "options": []}, {"id": "auhf91pm85f73swwidi4wid8jqe", "name": "Last Contact Date", "type": "date", "options": []}, {"id": "adtf1151chornmihz4xbgbk9exa", "name": "Expected Close", "type": "date", "options": []}, {"id": "aejo5tcmq54bauuueem9wc4fw4y", "name": "Close Probability", "type": "text", "options": []}, {"id": "amba7ot98fh7hwsx8jdcfst5g7h", "name": "Created Date", "type": "createdTime", "options": []}]	1675955410925	1675955410925	0	
b7ziufq456id898g6qn6hocdahe	2023-02-09 15:10:12.186101+00	0		system	system	O	Personal Tasks 	Use this template to organize your life and track your personal tasks.	✔️	t	t	6	{"trackingTemplateId": "dfb70c146a4584b8a21837477c7b5431"}	[{"id": "a9zf59u8x1rf4ywctpcqama7tio", "name": "Occurrence", "type": "select", "options": [{"id": "an51dnkenmoog9cetapbc4uyt3y", "color": "propColorBlue", "value": "Daily"}, {"id": "afpy8s7i45frggprmfsqngsocqh", "color": "propColorOrange", "value": "Weekly"}, {"id": "aj4jyekqqssatjcq7r7chmy19ey", "color": "propColorPurple", "value": "Monthly"}]}, {"id": "abthng7baedhhtrwsdodeuincqy", "name": "Completed", "type": "checkbox", "options": []}]	1675955412192	1675955412192	0	
bzuetargh8tfgtdj4tt8t9w6ora	2023-02-09 15:10:12.994972+00	0		system	system	O	Project Tasks 	Use this template to stay on top of your project tasks and progress.	🎯	t	t	6	{"trackingTemplateId": "a4ec399ab4f2088b1051c3cdf1dde4c3"}	[{"id": "a972dc7a-5f4c-45d2-8044-8c28c69717f1", "name": "Status", "type": "select", "options": [{"id": "ayz81h9f3dwp7rzzbdebesc7ute", "color": "propColorBlue", "value": "Not Started"}, {"id": "ar6b8m3jxr3asyxhr8iucdbo6yc", "color": "propColorYellow", "value": "In Progress"}, {"id": "afi4o5nhnqc3smtzs1hs3ij34dh", "color": "propColorRed", "value": "Blocked"}, {"id": "adeo5xuwne3qjue83fcozekz8ko", "color": "propColorGreen", "value": "Completed 🙌"}, {"id": "ahpyxfnnrzynsw3im1psxpkgtpe", "color": "propColorBrown", "value": "Archived"}]}, {"id": "d3d682bf-e074-49d9-8df5-7320921c2d23", "name": "Priority", "type": "select", "options": [{"id": "d3bfb50f-f569-4bad-8a3a-dd15c3f60101", "color": "propColorRed", "value": "1. High 🔥"}, {"id": "87f59784-b859-4c24-8ebe-17c766e081dd", "color": "propColorYellow", "value": "2. Medium"}, {"id": "98a57627-0f76-471d-850d-91f3ed9fd213", "color": "propColorGray", "value": "3. Low"}]}, {"id": "axkhqa4jxr3jcqe4k87g8bhmary", "name": "Assignee", "type": "person", "options": []}, {"id": "a8daz81s4xjgke1ww6cwik5w7ye", "name": "Estimated Hours", "type": "number", "options": []}, {"id": "a3zsw7xs8sxy7atj8b6totp3mby", "name": "Due Date", "type": "date", "options": []}, {"id": "a7gdnz8ff8iyuqmzddjgmgo9ery", "name": "Created By", "type": "createdBy", "options": []}, {"id": "2a5da320-735c-4093-8787-f56e15cdfeed", "name": "Date Created", "type": "createdTime", "options": []}]	1675955412997	1675955412997	0	
bhiem3kc7pj85585qw3abgs7psa	2023-02-09 15:10:14.174793+00	0		system	system	O	Company Goals & OKRs	Use this template to plan your company goals and OKRs more efficiently.	⛳	t	t	6	{"trackingTemplateId": "7ba22ccfdfac391d63dea5c4b8cde0de"}	[{"id": "a6amddgmrzakw66cidqzgk6p4ge", "name": "Objective", "type": "select", "options": [{"id": "auw3afh3kfhrfgmjr8muiz137jy", "color": "propColorGreen", "value": "Grow Revenue"}, {"id": "apqfjst8massbjjhpcsjs3y1yqa", "color": "propColorOrange", "value": "Delight Customers"}, {"id": "ao9b5pxyt7tkgdohzh9oaustdhr", "color": "propColorPurple", "value": "Drive Product Adoption"}]}, {"id": "a17ryhi1jfsboxkwkztwawhmsxe", "name": "Status", "type": "select", "options": [{"id": "a6robxx81diugpjq5jkezz3j1fo", "color": "propColorGray", "value": "Not Started"}, {"id": "a8nukezwwmknqwjsygg7eaxs9te", "color": "propColorBlue", "value": "In Progress"}, {"id": "apnt1f7na9rzgk1rt49keg7xbiy", "color": "propColorYellow", "value": "At Risk"}, {"id": "axbz3m1amss335wzwf9s7pqjzxr", "color": "propColorRed", "value": "Missed"}, {"id": "abzfwnn6rmtfzyq5hg8uqmpsncy", "color": "propColorGreen", "value": "Complete 🙌"}]}, {"id": "azzbawji5bksj69sekcs4srm1ky", "name": "Department", "type": "select", "options": [{"id": "aw5i7hmpadn6mbwbz955ubarhme", "color": "propColorBrown", "value": "Engineering"}, {"id": "afkxpcjqjypu7hhar7banxau91h", "color": "propColorBlue", "value": "Product"}, {"id": "aehoa17cz18rqnrf75g7dwhphpr", "color": "propColorOrange", "value": "Marketing"}, {"id": "agrfeaoj7d8p5ianw5iaf3191ae", "color": "propColorGreen", "value": "Sales"}, {"id": "agm9p6gcq15ueuzqq3wd4be39wy", "color": "propColorYellow", "value": "Support"}, {"id": "aucop7kw6xwodcix6zzojhxih6r", "color": "propColorPink", "value": "Design"}, {"id": "afust91f3g8ht368mkn5x9tgf1o", "color": "propColorPurple", "value": "Finance"}, {"id": "acocxxwjurud1jixhp7nowdig7y", "color": "propColorGray", "value": "Human Resources"}]}, {"id": "adp5ft3kgz7r5iqq3tnwg551der", "name": "Priority", "type": "select", "options": [{"id": "a8zg3rjtf4swh7smsjxpsn743rh", "color": "propColorRed", "value": "P1 🔥"}, {"id": "as555ipyzopjjpfb5rjtssecw5e", "color": "propColorYellow", "value": "P2"}, {"id": "a1ts3ftyr8nocsicui98c89uxjy", "color": "propColorGray", "value": "P3"}]}, {"id": "aqxyzkdrs4egqf7yk866ixkaojc", "name": "Quarter", "type": "select", "options": [{"id": "ahfbn1jsmhydym33ygxwg5jt3kh", "color": "propColorBlue", "value": "Q1"}, {"id": "awfu37js3fomfkkczm1zppac57a", "color": "propColorBrown", "value": "Q2"}, {"id": "anruuoyez51r3yjxuoc8zoqnwaw", "color": "propColorGreen", "value": "Q3"}, {"id": "acb6dqqs6yson7bbzx6jk9bghjh", "color": "propColorPurple", "value": "Q4"}]}, {"id": "adu6mebzpibq6mgcswk69xxmnqe", "name": "Due Date", "type": "date", "options": []}, {"id": "asope3bddhm4gpsng5cfu4hf6rh", "name": "Assignee", "type": "multiPerson", "options": []}, {"id": "ajwxp866f9obs1kutfwaa5ru7fe", "name": "Target", "type": "number", "options": []}, {"id": "azqnyswk6s1boiwuthscm78qwuo", "name": "Actual", "type": "number", "options": []}, {"id": "ahz3fmjnaguec8hce7xq3h5cjdr", "name": "Completion (%)", "type": "text", "options": []}, {"id": "a17bfcgnzmkwhziwa4tr38kiw5r", "name": "Note", "type": "text", "options": []}]	1675955414178	1675955414178	0	
bdjegdwuc3fr3jxmg7sgcn6mtww	2023-02-09 15:10:14.424408+00	0		system	system	O	Personal Goals 	Use this template to set and accomplish new personal goals.	⛰️	t	t	6	{"trackingTemplateId": "7f32dc8d2ae008cfe56554e9363505cc"}	[{"id": "af6fcbb8-ca56-4b73-83eb-37437b9a667d", "name": "Status", "type": "select", "options": [{"id": "bf52bfe6-ac4c-4948-821f-83eaa1c7b04a", "color": "propColorRed", "value": "To Do"}, {"id": "77c539af-309c-4db1-8329-d20ef7e9eacd", "color": "propColorYellow", "value": "Doing"}, {"id": "98bdea27-0cce-4cde-8dc6-212add36e63a", "color": "propColorGreen", "value": "Done 🙌"}]}, {"id": "d9725d14-d5a8-48e5-8de1-6f8c004a9680", "name": "Category", "type": "select", "options": [{"id": "3245a32d-f688-463b-87f4-8e7142c1b397", "color": "propColorPurple", "value": "Life Skills"}, {"id": "80be816c-fc7a-4928-8489-8b02180f4954", "color": "propColorGreen", "value": "Finance"}, {"id": "ffb3f951-b47f-413b-8f1d-238666728008", "color": "propColorOrange", "value": "Health"}]}, {"id": "d6b1249b-bc18-45fc-889e-bec48fce80ef", "name": "Target", "type": "select", "options": [{"id": "9a090e33-b110-4268-8909-132c5002c90e", "color": "propColorBlue", "value": "Q1"}, {"id": "0a82977f-52bf-457b-841b-e2b7f76fb525", "color": "propColorBrown", "value": "Q2"}, {"id": "6e7139e4-5358-46bb-8c01-7b029a57b80a", "color": "propColorGreen", "value": "Q3"}, {"id": "d5371c63-66bf-4468-8738-c4dc4bea4843", "color": "propColorPurple", "value": "Q4"}]}, {"id": "ajy6xbebzopojaenbnmfpgtdwso", "name": "Due Date", "type": "date", "options": []}]	1675955414427	1675955414427	0	
bazsdbbtz87gjp8ud7jkskiqzuc	2023-02-09 15:10:14.585839+00	0		system	system	O	Sprint Planner 	Use this template to plan your sprints and manage your releases more efficiently.	🗓️	t	t	6	{"trackingTemplateId": "99b74e26d2f5d0a9b346d43c0a7bfb09"}	[{"id": "50117d52-bcc7-4750-82aa-831a351c44a0", "name": "Status", "type": "select", "options": [{"id": "aft5bzo7h9aspqgrx3jpy5tzrer", "color": "propColorGray", "value": "Not Started"}, {"id": "abrfos7e7eczk9rqw6y5abadm1y", "color": "propColorOrange", "value": "Next Up"}, {"id": "ax8wzbka5ahs3zziji3pp4qp9mc", "color": "propColorBlue", "value": "In Progress"}, {"id": "atabdfbdmjh83136d5e5oysxybw", "color": "propColorYellow", "value": "In Review"}, {"id": "ace1bzypd586kkyhcht5qqd9eca", "color": "propColorPink", "value": "Approved"}, {"id": "aay656c9m1hzwxc9ch5ftymh3nw", "color": "propColorRed", "value": "Blocked"}, {"id": "a6ghze4iy441qhsh3eijnc8hwze", "color": "propColorGreen", "value": "Complete 🙌"}]}, {"id": "20717ad3-5741-4416-83f1-6f133fff3d11", "name": "Type", "type": "select", "options": [{"id": "424ea5e3-9aa1-4075-8c5c-01b44b66e634", "color": "propColorYellow", "value": "Epic ⛰"}, {"id": "a5yxq8rbubrpnoommfwqmty138h", "color": "propColorGray", "value": "Feature 🏗"}, {"id": "apht1nt5ryukdmxkh6fkfn6rgoy", "color": "propColorOrange", "value": "User Story 📖"}, {"id": "aiycbuo3dr5k4xxbfr7coem8ono", "color": "propColorGreen", "value": "Task ⛏"}, {"id": "aomnawq4551cbbzha9gxnmb3z5w", "color": "propColorRed", "value": "Bug 🐞"}]}, {"id": "60985f46-3e41-486e-8213-2b987440ea1c", "name": "Sprint", "type": "select", "options": [{"id": "c01676ca-babf-4534-8be5-cce2287daa6c", "color": "propColorBrown", "value": "Sprint 1"}, {"id": "ed4a5340-460d-461b-8838-2c56e8ee59fe", "color": "propColorPurple", "value": "Sprint 2"}, {"id": "14892380-1a32-42dd-8034-a0cea32bc7e6", "color": "propColorBlue", "value": "Sprint 3"}]}, {"id": "f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e", "name": "Priority", "type": "select", "options": [{"id": "cb8ecdac-38be-4d36-8712-c4d58cc8a8e9", "color": "propColorRed", "value": "P1 🔥"}, {"id": "e6a7f297-4440-4783-8ab3-3af5ba62ca11", "color": "propColorYellow", "value": "P2"}, {"id": "c62172ea-5da7-4dec-8186-37267d8ee9a7", "color": "propColorGray", "value": "P3"}]}, {"id": "aphg37f7zbpuc3bhwhp19s1ribh", "name": "Assignee", "type": "multiPerson", "options": []}, {"id": "a4378omyhmgj3bex13sj4wbpfiy", "name": "Due Date", "type": "date", "options": []}, {"id": "ai7ajsdk14w7x5s8up3dwir77te", "name": "Story Points", "type": "number", "options": []}, {"id": "a1g6i613dpe9oryeo71ex3c86hy", "name": "Design Link", "type": "url", "options": []}, {"id": "aeomttrbhhsi8bph31jn84sto6h", "name": "Created Time", "type": "createdTime", "options": []}, {"id": "ax9f8so418s6s65hi5ympd93i6a", "name": "Created By", "type": "createdBy", "options": []}]	1675955414592	1675955414592	0	
bujaeu6ekrtdtjyx1xnaptf3szc	2023-02-09 15:10:15.027456+00	0		system	system	O	User Research Sessions	Use this template to manage and keep track of all your user research sessions.	🔬	t	t	6	{"trackingTemplateId": "6c345c7f50f6833f78b7d0f08ce450a3"}	[{"id": "aaebj5fyx493eezx6ukxiwydgty", "name": "Status", "type": "select", "options": [{"id": "af6hjb3ysuaxbwnfqpby4wwnkdr", "color": "propColorGray", "value": "Backlog 📒"}, {"id": "aotxum1p5bw3xuzqz3ctjw66yww", "color": "propColorYellow", "value": "Contacted 📞"}, {"id": "a7yq89whddzob1futao4rxk3yzc", "color": "propColorBlue", "value": "Scheduled 📅"}, {"id": "aseqq9hrsua56r3s6nbuirj9eec", "color": "propColorRed", "value": "Cancelled 🚫"}, {"id": "ap93ysuzy1xa7z818r6myrn4h4y", "color": "propColorGreen", "value": "Completed ✔️"}]}, {"id": "akrxgi7p7w14fym3gbynb98t9fh", "name": "Interview Date", "type": "date", "options": []}, {"id": "atg9qu6oe4bjm8jczzsn71ff5me", "name": "Product Area", "type": "select", "options": [{"id": "ahn89mqg9u4igk6pdm7333t8i5h", "color": "propColorGreen", "value": "Desktop App"}, {"id": "aehc83ffays3gh8myz16a8j7k4e", "color": "propColorPurple", "value": "Web App"}, {"id": "a1sxagjgaadym5yrjak6tcup1oa", "color": "propColorBlue", "value": "Mobile App"}]}, {"id": "acjq4t5ymytu8x1f68wkggm7ypc", "name": "Email", "type": "email", "options": []}, {"id": "aphio1s5gkmpdbwoxynim7acw3e", "name": "Interviewer", "type": "multiPerson", "options": []}, {"id": "aqafzdeekpyncwz7m7i54q3iqqy", "name": "Recording URL", "type": "url", "options": []}, {"id": "aify3r761b9w43bqjtskrzi68tr", "name": "Passcode", "type": "text", "options": []}]	1675955415030	1675955415030	0	
bg5b5bwqbotr19ke4zt7j9q8xqr	2023-02-09 15:10:15.523642+00	0		system	system	O	Content Calendar 	Use this template to plan and organize your editorial content.	📅	t	t	6	{"trackingTemplateId": "c75fbd659d2258b5183af2236d176ab4"}	[{"id": "ae9ar615xoknd8hw8py7mbyr7zo", "name": "Status", "type": "select", "options": [{"id": "awna1nuarjca99m9s4uiy9kwj5h", "color": "propColorGray", "value": "Idea 💡"}, {"id": "a9ana1e9w673o5cp8md4xjjwfto", "color": "propColorOrange", "value": "Draft"}, {"id": "apy9dcd7zmand615p3h53zjqxjh", "color": "propColorPurple", "value": "In Review"}, {"id": "acri4cm3bmay55f7ksztphmtnga", "color": "propColorBlue", "value": "Ready to Publish"}, {"id": "amsowcd9a8e1kid317r7ttw6uzh", "color": "propColorGreen", "value": "Published 🎉"}]}, {"id": "aysx3atqexotgwp5kx6h5i5ancw", "name": "Type", "type": "select", "options": [{"id": "aywiofmmtd3ofgzj95ysky4pjga", "color": "propColorOrange", "value": "Press Release"}, {"id": "apqdgjrmsmx8ngmp7zst51647de", "color": "propColorGreen", "value": "Sponsored Post"}, {"id": "a3woynbjnb7j16e74uw3pubrytw", "color": "propColorPurple", "value": "Customer Story"}, {"id": "aq36k5pkpfcypqb3idw36xdi1fh", "color": "propColorRed", "value": "Product Release"}, {"id": "azn66pmk34adygnizjqhgiac4ia", "color": "propColorGray", "value": "Partnership"}, {"id": "aj8y675weso8kpb6eceqbpj4ruw", "color": "propColorBlue", "value": "Feature Announcement"}, {"id": "a3xky7ygn14osr1mokerbfah5cy", "color": "propColorYellow", "value": "Article"}]}, {"id": "ab6mbock6styfe6htf815ph1mhw", "name": "Channel", "type": "multiSelect", "options": [{"id": "a8xceonxiu4n3c43szhskqizicr", "color": "propColorBrown", "value": "Website"}, {"id": "a3pdzi53kpbd4okzdkz6khi87zo", "color": "propColorGreen", "value": "Blog"}, {"id": "a3d9ux4fmi3anyd11kyipfbhwde", "color": "propColorOrange", "value": "Email"}, {"id": "a8cbbfdwocx73zn3787cx6gacsh", "color": "propColorRed", "value": "Podcast"}, {"id": "aigjtpcaxdp7d6kmctrwo1ztaia", "color": "propColorPink", "value": "Print"}, {"id": "af1wsn13muho59e7ghwaogxy5ey", "color": "propColorBlue", "value": "Facebook"}, {"id": "a47zajfxwhsg6q8m7ppbiqs7jge", "color": "propColorGray", "value": "LinkedIn"}, {"id": "az8o8pfe9hq6s7xaehoqyc3wpyc", "color": "propColorYellow", "value": "Twitter"}]}, {"id": "ao44fz8nf6z6tuj1x31t9yyehcc", "name": "Assignee", "type": "person", "options": []}, {"id": "a39x5cybshwrbjpc3juaakcyj6e", "name": "Due Date", "type": "date", "options": []}, {"id": "agqsoiipowmnu9rdwxm57zrehtr", "name": "Publication Date", "type": "date", "options": []}, {"id": "ap4e7kdg7eip7j3c3oyiz39eaoc", "name": "Link", "type": "url", "options": []}]	1675955415541	1675955415541	0	
b6p46z69w8pdyzd8xyn6mg9xxmr	2023-02-09 15:10:15.867257+00	0		system	system	O	Team Retrospective	Use this template at the end of your project or sprint to identify what worked well and what can be improved for the future.	🧭	t	t	6	{"trackingTemplateId": "e4f03181c4ced8edd4d53d33d569a086"}	[{"id": "adjckpdotpgkz7c6wixzw9ipb1e", "name": "Category", "type": "select", "options": [{"id": "aok6pgecm85qe9k5kcphzoe63ma", "color": "propColorGray", "value": "To Discuss 📣"}, {"id": "aq1dwbf661yx337hjcd5q3sbxwa", "color": "propColorGreen", "value": "Went Well 👍"}, {"id": "ar87yh5xmsswqkxmjq1ipfftfpc", "color": "propColorRed", "value": "Didn't Go Well 🚫"}, {"id": "akj3fkmxq7idma55mdt8sqpumyw", "color": "propColorBlue", "value": "Action Items ✅"}]}, {"id": "aspaay76a5wrnuhtqgm97tt3rer", "name": "Details", "type": "text", "options": []}, {"id": "arzsm76s376y7suuhao3tu6efoc", "name": "Created By", "type": "createdBy", "options": []}, {"id": "a8anbe5fpa668sryatcdsuuyh8a", "name": "Created Time", "type": "createdTime", "options": []}]	1675955415870	1675955415870	0	
bhaxk1xppmtgnjrxua4dsakij5e	2023-02-09 15:10:15.260316+00	0		system	system	O	Competitive Analysis	Use this template to track and stay ahead of the competition.	🗂️	t	t	6	{"trackingTemplateId": "06f4bff367a7c2126fab2380c9dec23c"}	[{"id": "ahzspe59iux8wigra8bg6cg18nc", "name": "Website", "type": "url", "options": []}, {"id": "aozntq4go4nkab688j1s7stqtfc", "name": "Location", "type": "text", "options": []}, {"id": "aiefo7nh9jwisn8b4cgakowithy", "name": "Revenue", "type": "text", "options": []}, {"id": "a6cwaq79b1pdpb97wkanmeyy4er", "name": "Employees", "type": "number", "options": []}, {"id": "an1eerzscfxn6awdfajbg41uz3h", "name": "Founded", "type": "text", "options": []}, {"id": "a1semdhszu1rq17d7et5ydrqqio", "name": "Market Position", "type": "select", "options": [{"id": "arfjpz9by5car71tz3behba8yih", "color": "propColorYellow", "value": "Leader"}, {"id": "abajmr34b8g1916w495xjb35iko", "color": "propColorRed", "value": "Challenger"}, {"id": "abt79uxg5edqojsrrefcnr4eruo", "color": "propColorBlue", "value": "Follower"}, {"id": "aipf3qfgjtkheiayjuxrxbpk9wa", "color": "propColorBrown", "value": "Nicher"}]}, {"id": "aapogff3xoa8ym7xf56s87kysda", "name": "Last updated time", "type": "updatedTime", "options": []}, {"id": "az3jkw3ynd3mqmart7edypey15e", "name": "Last updated by", "type": "updatedBy", "options": []}]	1675955415264	1675955415264	0	
bhqt3na6kk78afbkt11p7rw1eha	2023-02-09 15:10:15.990252+00	0		system	system	O	Roadmap 	Use this template to plan your roadmap and manage your releases more efficiently.	🗺️	t	t	6	{"trackingTemplateId": "b728c6ca730e2cfc229741c5a4712b65"}	[{"id": "50117d52-bcc7-4750-82aa-831a351c44a0", "name": "Status", "type": "select", "options": [{"id": "8c557f69-b0ed-46ec-83a3-8efab9d47ef5", "color": "propColorGray", "value": "Not Started"}, {"id": "ec6d2bc5-df2b-4f77-8479-e59ceb039946", "color": "propColorYellow", "value": "In Progress"}, {"id": "849766ba-56a5-48d1-886f-21672f415395", "color": "propColorGreen", "value": "Complete 🙌"}]}, {"id": "20717ad3-5741-4416-83f1-6f133fff3d11", "name": "Type", "type": "select", "options": [{"id": "424ea5e3-9aa1-4075-8c5c-01b44b66e634", "color": "propColorYellow", "value": "Epic ⛰"}, {"id": "6eea96c9-4c61-4968-8554-4b7537e8f748", "color": "propColorGreen", "value": "Task 🔨"}, {"id": "1fdbb515-edd2-4af5-80fc-437ed2211a49", "color": "propColorRed", "value": "Bug 🐞"}]}, {"id": "60985f46-3e41-486e-8213-2b987440ea1c", "name": "Sprint", "type": "select", "options": [{"id": "c01676ca-babf-4534-8be5-cce2287daa6c", "color": "propColorBrown", "value": "Sprint 1"}, {"id": "ed4a5340-460d-461b-8838-2c56e8ee59fe", "color": "propColorPurple", "value": "Sprint 2"}, {"id": "14892380-1a32-42dd-8034-a0cea32bc7e6", "color": "propColorBlue", "value": "Sprint 3"}]}, {"id": "f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e", "name": "Priority", "type": "select", "options": [{"id": "cb8ecdac-38be-4d36-8712-c4d58cc8a8e9", "color": "propColorRed", "value": "P1 🔥"}, {"id": "e6a7f297-4440-4783-8ab3-3af5ba62ca11", "color": "propColorYellow", "value": "P2"}, {"id": "c62172ea-5da7-4dec-8186-37267d8ee9a7", "color": "propColorGray", "value": "P3"}]}, {"id": "aphg37f7zbpuc3bhwhp19s1ribh", "name": "Assignee", "type": "person", "options": []}, {"id": "a4378omyhmgj3bex13sj4wbpfiy", "name": "Due Date", "type": "date", "options": []}, {"id": "a36o9q1yik6nmar6ri4q4uca7ey", "name": "Created Date", "type": "createdTime", "options": []}, {"id": "ai7ajsdk14w7x5s8up3dwir77te", "name": "Design Link", "type": "url", "options": []}]	1675955415996	1675955415996	0	
bgddz141a8j8kdp69mnntpbgoor	2023-02-09 15:10:16.551755+00	0		system	system	O	Welcome to Boards!	Mattermost Boards is an open source project management tool that helps you organize, track, and manage work across teams. Select a card to learn more.	👋	t	t	6	{"trackingTemplateId": "65aba997282f3ac457cd66736fb86915"}	[{"id": "a972dc7a-5f4c-45d2-8044-8c28c69717f1", "name": "Status", "type": "select", "options": [{"id": "amm6wfhnbuxojwssyftgs9dipqe", "color": "propColorRed", "value": "To do 🔥"}, {"id": "af3p8ztcyxgn8wd9z4az7o9tjeh", "color": "propColorYellow", "value": "Next up"}, {"id": "ajurey3xkocs1nwx8di5zx6oe7o", "color": "propColorPurple", "value": "Later"}, {"id": "agkinkjy5983wsk6kppsujajxqw", "color": "propColorGreen", "value": "Completed 🙌"}]}, {"id": "acypkejeb5yfujhj9te57p9kaxw", "name": "Priority", "type": "select", "options": [{"id": "aanaehcw3m13jytujsjk5hpf6ry", "color": "propColorOrange", "value": "1. High"}, {"id": "ascd7nm9r491ayot8i86g1gmgqw", "color": "propColorBrown", "value": "2. Medium"}, {"id": "aq6ukoiciyfctgwyhwzpfss8ghe", "color": "propColorGray", "value": "3. Low"}]}, {"id": "aqh13jabwexjkzr3jqsz1i1syew", "name": "Assignee", "type": "person", "options": []}, {"id": "acmg7mz1rr1eykfug4hcdpb1y1o", "name": "Due Date", "type": "date", "options": []}, {"id": "amewjwfjrtpu8ha73xsrdmxazxr", "name": "Reviewed", "type": "checkbox", "options": []}, {"id": "attzzboqaz6m1sdti5xa7gjnk1e", "name": "Last updated time", "type": "updatedTime", "options": []}, {"id": "a4nfnb5xr3txr5xq7y9ho7kyz6c", "name": "Reference", "type": "url", "options": []}, {"id": "a9gzwi3dt5n55nddej6zcbhxaeh", "name": "Created by", "type": "createdBy", "options": []}]	1675955416554	1675955416554	0	
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
TelemetryID	7yjbdy1is1ibc8mf9u9g11s1ije
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
ms7jm6ewktrqbnbctx6nqx3dce	migrations	0	1675955468473	1675955477173	1675955477390	success	0	{"last_done": "{\\"current_table\\":\\"ChannelMembers\\",\\"last_team_id\\":\\"00000000000000000000000000\\",\\"last_channel_id\\":\\"00000000000000000000000000\\",\\"last_user\\":\\"00000000000000000000000000\\"}", "migration_key": "migration_advanced_permissions_phase_2"}
mucbym53t3yx7rc34ykoe9nqxw	expiry_notify	0	1675956204266	1675956211726	1675956211732	success	0	null
icozsjcfejymbknkbxjnw6me9h	expiry_notify	0	1675956803891	1675956811555	1675956811558	success	0	null
cbzrej5q4p8z5rzrc5jh8ksuhy	expiry_notify	0	1675957765190	1675957774699	1675957774704	success	0	null
ear3tmtgr7nw5gyg6iorx9ugmc	expiry_notify	0	1675970888410	1675970894307	1675970894312	success	0	null
6stkbt4pd7nkpk5cf19wczwtxy	expiry_notify	0	1675971488019	1675971494062	1675971494081	success	0	null
zqmpega96id93pi7fediazhiqo	expiry_notify	0	1675972087639	1675972093815	1675972093820	success	0	null
amneorp9y78afnsb8mcys4maaa	expiry_notify	0	1678033369981	1678033383664	1678033383669	success	0	null
jjmzgyt5epnzf8f5zetp6qdwbh	expiry_notify	0	1678033970016	1678033983828	1678033983833	success	0	null
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
com.mattermost.apps	mmi_botid	\\x757a7063347431716b6a6274336773706d72746d757a72696d77	0
playbooks	mmi_botid	\\x6e6d3472616a38747270676574636e75747a633869636b613772	0
focalboard	mmi_botid	\\x67366865747565637a7038776966333868376f336f3170637963	0
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
f6j4cu9sqbytpy6wd4eq43bcte	1675955722129	1675955722129	0	whida44gqpyfierua1wfrnbxtr	p7retz8iwtgzdrdceqw13fwmbr			admin joined the team.	system_join_team	{"username": "admin"}		[]	[]	f	0	f	\N
7zddp9uw33yrxy5u6tjd8kpk5h	1675955722177	1675955722177	0	whida44gqpyfierua1wfrnbxtr	p7retz8iwtgzdrdceqw13fwmbr				system_welcome_post	{}		[]	[]	f	0	f	\N
4t5emn3sniy3mqhpmapfaedzje	1675955722219	1675955722219	0	whida44gqpyfierua1wfrnbxtr	giyj94p1fp86p8zs9z6u5b3ujh			admin joined the channel.	system_join_channel	{"username": "admin"}		[]	[]	f	0	f	\N
wceqk9cyopy3pb34i5zhjktsxe	1675956111709	1675956111709	0	geds3gxhdf81dccdrm8bfx37ry	p7retz8iwtgzdrdceqw13fwmbr			matrix.bridge joined the team.	system_join_team	{"username": "matrix.bridge"}		[]	[]	f	0	f	\N
atxnnabgd38oxya4ee5q7sqx3y	1675956111738	1675956111738	0	geds3gxhdf81dccdrm8bfx37ry	giyj94p1fp86p8zs9z6u5b3ujh			matrix.bridge joined the channel.	system_join_channel	{"username": "matrix.bridge"}		[]	[]	f	0	f	\N
roetytajujyqbcc67c4aoi9oko	1675956421327	1675956421327	0	ygmycw6rnff7igko8gwbqchujr	p7retz8iwtgzdrdceqw13fwmbr			user1.mm joined the team.	system_join_team	{"username": "user1.mm"}		[]	[]	f	0	f	\N
i8dqkodnninc5qzxxdfyaykpie	1675956421370	1675956421370	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			user1.mm joined the channel.	system_join_channel	{"username": "user1.mm"}		[]	[]	f	0	f	\N
e85mjzrcbjgkincfjq36k1jzch	1675957608047	1675957608047	0	ygmycw6rnff7igko8gwbqchujr	p7retz8iwtgzdrdceqw13fwmbr			klklk		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
3bcyhzzf8igs7jfqi4rumabd9w	1675957625593	1675957625593	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			klklk		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
6xytrtqtb7g49q3a9ubfg3m9rw	1676646214696	1676646214696	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			matrix_user1.matrix joined the team.	system_join_team	{"username": "matrix_user1.matrix"}		[]	[]	f	0	f	\N
ioyak1g35fnymppx6gehzcb7ka	1676646214704	1676646214704	0	geds3gxhdf81dccdrm8bfx37ry	giyj94p1fp86p8zs9z6u5b3ujh			matrix_user1.matrix added to the channel by matrix.bridge.	system_add_to_channel	{"userId": "geds3gxhdf81dccdrm8bfx37ry", "username": "matrix.bridge", "addedUserId": "bgct5icpib883fx619bh3cfu6h", "addedUsername": "matrix_user1.matrix"}		[]	[]	f	0	f	\N
mj13enz8zpfufxoz4poh556omo	1676646214793	1676646214793	0	bgct5icpib883fx619bh3cfu6h	giyj94p1fp86p8zs9z6u5b3ujh			matrix_user1.matrix joined the channel.	system_join_channel	{"username": "matrix_user1.matrix"}		[]	[]	f	0	f	\N
qpybi5a1tff9u81mgtngeuhkro	1676646372520	1676646372520	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			Hej		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
xcginserxtyab8q7dtajc43fwr	1678032937595	1678032937595	0	ygmycw6rnff7igko8gwbqchujr	p7retz8iwtgzdrdceqw13fwmbr			oko		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
i3rgzbuhdpn73conyzd7zw6sbc	1678032959928	1678032959928	0	bgct5icpib883fx619bh3cfu6h	giyj94p1fp86p8zs9z6u5b3ujh			kook		{}		[]	[]	f	0	f	\N
ma8t73u6cbnkdy4gsyue5rrd9h	1678033228840	1678033228840	0	ygmycw6rnff7igko8gwbqchujr	p7retz8iwtgzdrdceqw13fwmbr			okok		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
jqbf9g91b3neteabf1378kf6ao	1678033315382	1678033315382	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			kalle		{}		[]	[]	f	0	f	\N
ah95xeojein9dgb3g5d3nf6m1e	1678033545983	1678033545983	0	geds3gxhdf81dccdrm8bfx37ry	9wp7xhh6f7namrfm1asziaf9nh			matrix.bridge joined the channel.	system_join_channel	{"username": "matrix.bridge"}		[]	[]	f	0	f	\N
gnytotamoid5urg5ythwdpg7xw	1678033569799	1678033569799	0	geds3gxhdf81dccdrm8bfx37ry	9wp7xhh6f7namrfm1asziaf9nh			@matrix.bridge left the channel.	system_leave_channel	{"username": "matrix.bridge"}		[]	[]	f	0	f	\N
e8q748ruubdpzr4mq19momkpky	1678033678977	1678033678977	0	geds3gxhdf81dccdrm8bfx37ry	9wp7xhh6f7namrfm1asziaf9nh			matrix.bridge joined the channel.	system_join_channel	{"username": "matrix.bridge"}		[]	[]	f	0	f	\N
srm7mzjxe3fa8j8ueysash8qor	1678033721258	1678033721258	0	geds3gxhdf81dccdrm8bfx37ry	9wp7xhh6f7namrfm1asziaf9nh			klklk		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
en6dc4fqdjdg7b8aufnuzp5aga	1678033762144	1678033762144	0	ygmycw6rnff7igko8gwbqchujr	9wp7xhh6f7namrfm1asziaf9nh			user1.mm joined the channel.	system_join_channel	{"username": "user1.mm"}		[]	[]	f	0	f	\N
man1grukefr4jmityxs3z4z8te	1678033769132	1678033769132	0	ygmycw6rnff7igko8gwbqchujr	9wp7xhh6f7namrfm1asziaf9nh			klklk		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
wcnfnenx17d47mnrubj9mug3mh	1678033782830	1678033782830	0	geds3gxhdf81dccdrm8bfx37ry	9wp7xhh6f7namrfm1asziaf9nh			matrix_user1.matrix added to the channel by matrix.bridge.	system_add_to_channel	{"userId": "geds3gxhdf81dccdrm8bfx37ry", "username": "matrix.bridge", "addedUserId": "bgct5icpib883fx619bh3cfu6h", "addedUsername": "matrix_user1.matrix"}		[]	[]	f	0	f	\N
hz71npt4spyr9gesejj34pynkc	1678033803352	1678033803352	0	ygmycw6rnff7igko8gwbqchujr	9wp7xhh6f7namrfm1asziaf9nh			KLKLK		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
iwxpx5nkofgqzk437ejaa9fhxo	1678033905152	1678033905152	0	ygmycw6rnff7igko8gwbqchujr	rk4gdc4whjnupqoad46hwa9cme			user1.mm joined the channel.	system_join_channel	{"username": "user1.mm"}		[]	[]	f	0	f	\N
wfngnt9tdfga5yoob75d3euqmy	1678033923786	1678033923786	0	ygmycw6rnff7igko8gwbqchujr	rk4gdc4whjnupqoad46hwa9cme			matrix.bridge added to the channel by user1.mm.	system_add_to_channel	{"userId": "ygmycw6rnff7igko8gwbqchujr", "username": "user1.mm", "addedUserId": "geds3gxhdf81dccdrm8bfx37ry", "addedUsername": "matrix.bridge"}		[]	[]	f	0	f	\N
i9nc6axzgjbsmf3h49jhcddsoc	1678033937017	1678033937017	0	geds3gxhdf81dccdrm8bfx37ry	rk4gdc4whjnupqoad46hwa9cme			@matrix.bridge left the channel.	system_leave_channel	{"username": "matrix.bridge"}		[]	[]	f	0	f	\N
pbezqx8zubr5dyxs63dckmr4ko	1678033955581	1678033955581	0	ygmycw6rnff7igko8gwbqchujr	rk4gdc4whjnupqoad46hwa9cme			klklk		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
11tiqukwoi8fzqtm5mf6rzcqxc	1678033959731	1678033959731	0	ygmycw6rnff7igko8gwbqchujr	rk4gdc4whjnupqoad46hwa9cme			lölö		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
xaoe948b4idp3jutbshjkri7wo	1678034001601	1678034001601	0	bgct5icpib883fx619bh3cfu6h	9wp7xhh6f7namrfm1asziaf9nh			ddd		{}		[]	[]	f	0	f	\N
mohtrsnmajrgiyfrwhk1wks17y	1678611368286	1678611368286	0	wq6i7sbf4tnqzbssbn7gy7cjcc	p7retz8iwtgzdrdceqw13fwmbr			matrix_user2.matrix joined the team.	system_join_team	{"username": "matrix_user2.matrix"}		[]	[]	f	0	f	\N
dcea18ycwif6ux4fn58youfeca	1678611368417	1678611368417	0	wq6i7sbf4tnqzbssbn7gy7cjcc	giyj94p1fp86p8zs9z6u5b3ujh			matrix_user2.matrix joined the channel.	system_join_channel	{"username": "matrix_user2.matrix"}		[]	[]	f	0	f	\N
tr9w9j7rp3dzzyphb4jnibrtko	1678611368929	1678611368929	0	geds3gxhdf81dccdrm8bfx37ry	giyj94p1fp86p8zs9z6u5b3ujh			@matrix_user2.matrix removed from the channel.	system_remove_from_channel	{"removedUserId": "wq6i7sbf4tnqzbssbn7gy7cjcc", "removedUsername": "matrix_user2.matrix"}		[]	[]	f	0	f	\N
b3ep6go787gpufiweug9qmwoyr	1678611372954	1678611372954	0	wq6i7sbf4tnqzbssbn7gy7cjcc	p7retz8iwtgzdrdceqw13fwmbr			ok		{}		[]	[]	f	0	f	\N
syyjtnzntfffbpbmi99659jnxw	1678611396675	1678611396675	0	e343y5ecu7dyujwqm7yfimh1je	p7retz8iwtgzdrdceqw13fwmbr			user2.mm joined the team.	system_join_team	{"username": "user2.mm"}		[]	[]	f	0	f	\N
ygncs7pg6iy47r6d99btbu6zgo	1678611396734	1678611396734	0	e343y5ecu7dyujwqm7yfimh1je	giyj94p1fp86p8zs9z6u5b3ujh			user2.mm joined the channel.	system_join_channel	{"username": "user2.mm"}		[]	[]	f	0	f	\N
\.


--
-- Data for Name: preferences; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.preferences (userid, category, name, value) FROM stdin;
whida44gqpyfierua1wfrnbxtr	tutorial_step	whida44gqpyfierua1wfrnbxtr	0
whida44gqpyfierua1wfrnbxtr	insights	insights_tutorial_state	{"insights_modal_viewed":true}
whida44gqpyfierua1wfrnbxtr	onboarding_task_list	onboarding_task_list_show	true
whida44gqpyfierua1wfrnbxtr	recommended_next_steps	hide	true
whida44gqpyfierua1wfrnbxtr	onboarding_task_list	onboarding_task_list_open	false
whida44gqpyfierua1wfrnbxtr	channel_approximate_view_time		1675955889088
geds3gxhdf81dccdrm8bfx37ry	tutorial_step	geds3gxhdf81dccdrm8bfx37ry	0
geds3gxhdf81dccdrm8bfx37ry	insights	insights_tutorial_state	{"insights_modal_viewed":true}
geds3gxhdf81dccdrm8bfx37ry	onboarding_task_list	onboarding_task_list_show	true
geds3gxhdf81dccdrm8bfx37ry	recommended_next_steps	hide	true
geds3gxhdf81dccdrm8bfx37ry	onboarding_task_list	onboarding_task_list_open	false
ygmycw6rnff7igko8gwbqchujr	tutorial_step	ygmycw6rnff7igko8gwbqchujr	0
ygmycw6rnff7igko8gwbqchujr	insights	insights_tutorial_state	{"insights_modal_viewed":true}
ygmycw6rnff7igko8gwbqchujr	onboarding_task_list	onboarding_task_list_show	true
ygmycw6rnff7igko8gwbqchujr	recommended_next_steps	hide	true
ygmycw6rnff7igko8gwbqchujr	onboarding_task_list	onboarding_task_list_open	false
bgct5icpib883fx619bh3cfu6h	recommended_next_steps	hide	false
bgct5icpib883fx619bh3cfu6h	tutorial_step	bgct5icpib883fx619bh3cfu6h	0
bgct5icpib883fx619bh3cfu6h	insights	insights_tutorial_state	{"insights_modal_viewed":true}
ygmycw6rnff7igko8gwbqchujr	channel_approximate_view_time		1678032950945
geds3gxhdf81dccdrm8bfx37ry	channel_approximate_view_time		1678033562703
wq6i7sbf4tnqzbssbn7gy7cjcc	recommended_next_steps	hide	false
wq6i7sbf4tnqzbssbn7gy7cjcc	tutorial_step	wq6i7sbf4tnqzbssbn7gy7cjcc	0
wq6i7sbf4tnqzbssbn7gy7cjcc	insights	insights_tutorial_state	{"insights_modal_viewed":true}
e343y5ecu7dyujwqm7yfimh1je	tutorial_step	e343y5ecu7dyujwqm7yfimh1je	0
e343y5ecu7dyujwqm7yfimh1je	insights	insights_tutorial_state	{"insights_modal_viewed":true}
e343y5ecu7dyujwqm7yfimh1je	onboarding_task_list	onboarding_task_list_show	true
e343y5ecu7dyujwqm7yfimh1je	recommended_next_steps	hide	true
e343y5ecu7dyujwqm7yfimh1je	onboarding_task_list	onboarding_task_list_open	false
\.


--
-- Data for Name: productnoticeviewstate; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.productnoticeviewstate (userid, noticeid, viewed, "timestamp") FROM stdin;
whida44gqpyfierua1wfrnbxtr	use_case_survey	1	1675955707
whida44gqpyfierua1wfrnbxtr	june15-cloud-freemium	1	1675955707
whida44gqpyfierua1wfrnbxtr	desktop_upgrade_v5.2	1	1675955707
whida44gqpyfierua1wfrnbxtr	crt-admin-disabled	1	1675955707
whida44gqpyfierua1wfrnbxtr	crt-admin-default_off	1	1675955707
whida44gqpyfierua1wfrnbxtr	crt-user-default-on	1	1675955707
whida44gqpyfierua1wfrnbxtr	crt-user-always-on	1	1675955707
whida44gqpyfierua1wfrnbxtr	v6.0_user_introduction	1	1675955707
whida44gqpyfierua1wfrnbxtr	v6.2_boards	1	1675955707
whida44gqpyfierua1wfrnbxtr	unsupported-server-v5.37	1	1675955707
geds3gxhdf81dccdrm8bfx37ry	use_case_survey	1	1675956108
geds3gxhdf81dccdrm8bfx37ry	june15-cloud-freemium	1	1675956108
geds3gxhdf81dccdrm8bfx37ry	desktop_upgrade_v5.2	1	1675956108
geds3gxhdf81dccdrm8bfx37ry	crt-admin-disabled	1	1675956108
geds3gxhdf81dccdrm8bfx37ry	crt-admin-default_off	1	1675956108
geds3gxhdf81dccdrm8bfx37ry	crt-user-default-on	1	1675956108
geds3gxhdf81dccdrm8bfx37ry	crt-user-always-on	1	1675956108
geds3gxhdf81dccdrm8bfx37ry	v6.0_user_introduction	1	1675956108
geds3gxhdf81dccdrm8bfx37ry	v6.2_boards	1	1675956108
geds3gxhdf81dccdrm8bfx37ry	unsupported-server-v5.37	1	1675956108
ygmycw6rnff7igko8gwbqchujr	use_case_survey	1	1675956418
ygmycw6rnff7igko8gwbqchujr	june15-cloud-freemium	1	1675956418
ygmycw6rnff7igko8gwbqchujr	desktop_upgrade_v5.2	1	1675956418
ygmycw6rnff7igko8gwbqchujr	crt-admin-disabled	1	1675956418
ygmycw6rnff7igko8gwbqchujr	crt-admin-default_off	1	1675956418
ygmycw6rnff7igko8gwbqchujr	crt-user-default-on	1	1675956418
ygmycw6rnff7igko8gwbqchujr	crt-user-always-on	1	1675956418
ygmycw6rnff7igko8gwbqchujr	v6.0_user_introduction	1	1675956418
ygmycw6rnff7igko8gwbqchujr	v6.2_boards	1	1675956418
ygmycw6rnff7igko8gwbqchujr	unsupported-server-v5.37	1	1675956418
bgct5icpib883fx619bh3cfu6h	use_case_survey	1	1676646214
bgct5icpib883fx619bh3cfu6h	june15-cloud-freemium	1	1676646214
bgct5icpib883fx619bh3cfu6h	desktop_upgrade_v5.2	1	1676646214
bgct5icpib883fx619bh3cfu6h	crt-admin-disabled	1	1676646214
bgct5icpib883fx619bh3cfu6h	crt-admin-default_off	1	1676646214
bgct5icpib883fx619bh3cfu6h	crt-user-default-on	1	1676646214
bgct5icpib883fx619bh3cfu6h	crt-user-always-on	1	1676646214
bgct5icpib883fx619bh3cfu6h	v6.0_user_introduction	1	1676646214
bgct5icpib883fx619bh3cfu6h	v6.2_boards	1	1676646214
bgct5icpib883fx619bh3cfu6h	unsupported-server-v5.37	1	1676646214
geds3gxhdf81dccdrm8bfx37ry	server_upgrade_v7.8	1	1678033387
wq6i7sbf4tnqzbssbn7gy7cjcc	use_case_survey	1	1678611367
wq6i7sbf4tnqzbssbn7gy7cjcc	june15-cloud-freemium	1	1678611367
wq6i7sbf4tnqzbssbn7gy7cjcc	desktop_upgrade_v5.2	1	1678611367
wq6i7sbf4tnqzbssbn7gy7cjcc	server_upgrade_v7.8	1	1678611367
wq6i7sbf4tnqzbssbn7gy7cjcc	crt-admin-disabled	1	1678611367
wq6i7sbf4tnqzbssbn7gy7cjcc	crt-admin-default_off	1	1678611367
wq6i7sbf4tnqzbssbn7gy7cjcc	crt-user-default-on	1	1678611367
wq6i7sbf4tnqzbssbn7gy7cjcc	crt-user-always-on	1	1678611367
wq6i7sbf4tnqzbssbn7gy7cjcc	v6.0_user_introduction	1	1678611367
wq6i7sbf4tnqzbssbn7gy7cjcc	v6.2_boards	1	1678611367
wq6i7sbf4tnqzbssbn7gy7cjcc	unsupported-server-v5.37	1	1678611367
e343y5ecu7dyujwqm7yfimh1je	use_case_survey	1	1678611392
e343y5ecu7dyujwqm7yfimh1je	june15-cloud-freemium	1	1678611392
e343y5ecu7dyujwqm7yfimh1je	desktop_upgrade_v5.2	1	1678611392
e343y5ecu7dyujwqm7yfimh1je	server_upgrade_v7.8	1	1678611392
e343y5ecu7dyujwqm7yfimh1je	crt-admin-disabled	1	1678611392
e343y5ecu7dyujwqm7yfimh1je	crt-admin-default_off	1	1678611392
e343y5ecu7dyujwqm7yfimh1je	crt-user-default-on	1	1678611392
e343y5ecu7dyujwqm7yfimh1je	crt-user-always-on	1	1678611392
e343y5ecu7dyujwqm7yfimh1je	v6.0_user_introduction	1	1678611392
e343y5ecu7dyujwqm7yfimh1je	v6.2_boards	1	1678611392
e343y5ecu7dyujwqm7yfimh1je	unsupported-server-v5.37	1	1678611392
\.


--
-- Data for Name: publicchannels; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.publicchannels (id, deleteat, teamid, displayname, name, header, purpose) FROM stdin;
p7retz8iwtgzdrdceqw13fwmbr	0	ebxg8q3pzbdrdjo7xx1qqw3guy	Town Square	town-square		
giyj94p1fp86p8zs9z6u5b3ujh	0	ebxg8q3pzbdrdjo7xx1qqw3guy	Off-Topic	off-topic		
9wp7xhh6f7namrfm1asziaf9nh	0	ebxg8q3pzbdrdjo7xx1qqw3guy	After Work	after-work		An channel for afterwork 
rk4gdc4whjnupqoad46hwa9cme	0	ebxg8q3pzbdrdjo7xx1qqw3guy	My Public Room	my-public-room		
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
yigz7aqrufbxzbsje4ksge63kh	channel_guest	authentication.roles.channel_guest.name	authentication.roles.channel_guest.description	1675955399801	1675955402702	0	 use_channel_mentions use_slash_commands read_channel add_reaction remove_reaction upload_file edit_post create_post	t	t
ccqanx7yw3d48m1nr5n87mgm6r	team_guest	authentication.roles.team_guest.name	authentication.roles.team_guest.description	1675955399813	1675955402705	0	 view_team	t	t
3txaajmfp3gmxxz4co5my9m1er	channel_admin	authentication.roles.channel_admin.name	authentication.roles.channel_admin.description	1675955399984	1675955402729	0	 remove_reaction manage_private_channel_members use_group_mentions manage_channel_roles add_reaction read_private_channel_groups manage_public_channel_members create_post read_public_channel_groups use_channel_mentions	t	t
95hg91qcgtbfdmy58tj8korihc	team_post_all	authentication.roles.team_post_all.name	authentication.roles.team_post_all.description	1675955399989	1675955402731	0	 use_group_mentions use_channel_mentions create_post	f	t
durmjtyhz7b3jm7zd9nwyd5r4h	playbook_admin	authentication.roles.playbook_admin.name	authentication.roles.playbook_admin.description	1675955399992	1675955402733	0	 playbook_public_manage_properties playbook_private_manage_members playbook_private_manage_roles playbook_private_manage_properties playbook_public_make_private playbook_public_manage_members playbook_public_manage_roles	t	t
oiccxi68rbfb7ccp98f6re739c	run_admin	authentication.roles.run_admin.name	authentication.roles.run_admin.description	1675955399994	1675955402735	0	 run_manage_members run_manage_properties	t	t
6tcppqipcjn7tyx95ob3hidk5o	system_post_all	authentication.roles.system_post_all.name	authentication.roles.system_post_all.description	1675955399997	1675955402736	0	 use_channel_mentions use_group_mentions create_post	f	t
suok4s677bg6dn9mrcbfk36qgr	system_user_access_token	authentication.roles.system_user_access_token.name	authentication.roles.system_user_access_token.description	1675955400002	1675955402738	0	 create_user_access_token read_user_access_token revoke_user_access_token	f	t
dxx7j8g8xjyburhseoe7wjix1w	team_admin	authentication.roles.team_admin.name	authentication.roles.team_admin.description	1675955399752	1675955402700	0	 playbook_private_manage_roles manage_slash_commands use_channel_mentions manage_public_channel_members remove_reaction manage_others_incoming_webhooks remove_user_from_team manage_others_slash_commands manage_team manage_team_roles create_post delete_post import_team playbook_public_manage_roles manage_incoming_webhooks manage_private_channel_members manage_others_outgoing_webhooks use_group_mentions convert_public_channel_to_private read_private_channel_groups manage_channel_roles add_reaction manage_outgoing_webhooks read_public_channel_groups convert_private_channel_to_public delete_others_posts	t	t
uq7ezmofotri9qsgc5gf3uoofw	custom_group_user	authentication.roles.custom_group_user.name	authentication.roles.custom_group_user.description	1675955399680	1675955402690	0		f	f
siuyt5wdhtrpmxrdhjc9spybsr	team_user	authentication.roles.team_user.name	authentication.roles.team_user.description	1675955399687	1675955402692	0	 list_team_channels create_public_channel playbook_private_create join_public_channels view_team add_user_to_team read_public_channel create_private_channel invite_user playbook_public_create	t	t
h1xwa95pmjrpi8fsfdo1ky4z3c	team_post_all_public	authentication.roles.team_post_all_public.name	authentication.roles.team_post_all_public.description	1675955399713	1675955402693	0	 use_channel_mentions create_post_public use_group_mentions	f	t
5oxheqbnqpgx8d147eeu4ywa7o	system_custom_group_admin	authentication.roles.system_custom_group_admin.name	authentication.roles.system_custom_group_admin.description	1675955399968	1675955402726	0	 create_custom_group edit_custom_group delete_custom_group manage_custom_group_members	f	t
9xm3gn7bsprczjtm98oqaxkcae	system_user	authentication.roles.global_user.name	authentication.roles.global_user.description	1675955399816	1675955402742	0	 create_custom_group create_group_channel list_public_teams create_direct_channel view_members create_team edit_custom_group delete_emojis create_emojis join_public_teams delete_custom_group manage_custom_group_members	t	t
zpcdxpmr1tg73jprtpiwmx6zpa	system_admin	authentication.roles.global_admin.name	authentication.roles.global_admin.description	1675955400022	1675955402745	0	 sysconsole_read_compliance_compliance_export playbook_public_view remove_user_from_team sysconsole_write_user_management_permissions playbook_private_manage_members sysconsole_write_environment_logging create_post recycle_database_connections manage_license_information use_slash_commands sysconsole_read_environment_web_server sysconsole_write_authentication_mfa run_manage_members sysconsole_read_environment_database sysconsole_write_compliance_data_retention_policy create_team sysconsole_write_site_notices manage_others_outgoing_webhooks assign_bot playbook_private_create manage_roles add_saml_private_cert sysconsole_read_user_management_system_roles sysconsole_write_user_management_groups create_custom_group read_elasticsearch_post_aggregation_job sysconsole_write_environment_rate_limiting list_team_channels create_post_bleve_indexes_job create_post_public list_private_teams edit_post sysconsole_write_authentication_password sysconsole_read_experimental_feature_flags view_team sysconsole_read_environment_session_lengths sysconsole_read_reporting_team_statistics create_user_access_token sysconsole_read_authentication_saml delete_private_channel create_bot upload_file remove_saml_public_cert sysconsole_write_site_emoji sysconsole_write_integrations_integration_management sysconsole_read_user_management_groups sysconsole_read_site_announcement_banner sysconsole_write_environment_push_notification_server sysconsole_read_authentication_mfa manage_incoming_webhooks add_ldap_public_cert sysconsole_write_compliance_compliance_export playbook_public_manage_roles sysconsole_write_authentication_saml playbook_public_make_private edit_others_posts join_public_channels remove_saml_idp_cert read_data_retention_job sysconsole_write_experimental_feature_flags sysconsole_read_user_management_users sysconsole_read_user_management_channels read_public_channel convert_private_channel_to_public sysconsole_read_environment_logging list_users_without_team read_ldap_sync_job sysconsole_read_integrations_gif sysconsole_read_environment_high_availability sysconsole_write_reporting_server_logs sysconsole_write_authentication_email sysconsole_write_authentication_guest_access create_ldap_sync_job edit_brand create_post_ephemeral sysconsole_write_integrations_bot_accounts delete_others_emojis sysconsole_write_site_users_and_teams sysconsole_read_environment_developer sysconsole_write_experimental_features playbook_private_view sysconsole_write_plugins purge_bleve_indexes sysconsole_read_plugins sysconsole_write_environment_high_availability sysconsole_read_environment_elasticsearch download_compliance_export_result read_other_users_teams manage_jobs create_direct_channel run_manage_properties manage_slash_commands manage_public_channel_members manage_system_wide_oauth sysconsole_read_authentication_ldap sysconsole_write_site_public_links sysconsole_read_integrations_cors manage_team_roles assign_system_admin_role test_site_url playbook_public_manage_members sysconsole_read_site_emoji sysconsole_write_environment_performance_monitoring add_reaction sysconsole_write_environment_web_server sysconsole_write_environment_file_storage sysconsole_read_authentication_signup sysconsole_write_site_announcement_banner test_elasticsearch sysconsole_read_compliance_custom_terms_of_service sysconsole_read_authentication_email sysconsole_read_authentication_openid sysconsole_read_integrations_integration_management remove_saml_private_cert join_public_teams sysconsole_read_compliance_compliance_monitoring delete_others_posts add_ldap_private_cert sysconsole_read_experimental_bleve sysconsole_read_site_customization remove_reaction join_private_teams sysconsole_read_environment_push_notification_server remove_others_reactions create_compliance_export_job remove_ldap_public_cert sysconsole_write_environment_image_proxy sysconsole_write_environment_elasticsearch sysconsole_read_user_management_permissions sysconsole_write_user_management_users create_elasticsearch_post_aggregation_job sysconsole_write_user_management_system_roles invite_user demote_to_guest create_group_channel sysconsole_read_environment_image_proxy delete_post sysconsole_write_site_file_sharing_and_downloads sysconsole_read_environment_rate_limiting use_group_mentions read_license_information sysconsole_read_products_boards playbook_private_manage_roles sysconsole_write_experimental_bleve sysconsole_read_reporting_server_logs read_deleted_posts read_others_bots sysconsole_write_site_notifications manage_public_channel_properties sysconsole_write_reporting_site_statistics read_audits import_team add_saml_public_cert test_s3 get_analytics get_saml_cert_status sysconsole_read_authentication_password manage_others_slash_commands sysconsole_read_reporting_site_statistics read_channel playbook_public_manage_properties sysconsole_write_environment_database sysconsole_write_environment_developer manage_system revoke_user_access_token list_public_teams test_email manage_others_bots manage_outgoing_webhooks sysconsole_read_site_localization invite_guest sysconsole_write_authentication_openid read_bots manage_channel_roles sysconsole_write_integrations_gif manage_shared_channels delete_public_channel sysconsole_read_integrations_bot_accounts add_user_to_team read_jobs sysconsole_write_site_localization playbook_private_manage_properties use_channel_mentions view_members get_logs get_saml_metadata_from_idp manage_oauth invalidate_caches manage_team playbook_private_make_public sysconsole_write_compliance_custom_terms_of_service run_view manage_bots delete_custom_group manage_custom_group_members sysconsole_write_integrations_cors run_create sysconsole_write_products_boards sysconsole_write_user_management_teams sysconsole_write_reporting_team_statistics read_user_access_token sysconsole_read_authentication_guest_access manage_private_channel_members manage_others_incoming_webhooks manage_private_channel_properties sysconsole_read_billing sysconsole_write_environment_smtp sysconsole_read_environment_performance_monitoring read_private_channel_groups purge_elasticsearch_indexes sysconsole_read_site_posts sysconsole_write_authentication_signup edit_other_users read_elasticsearch_post_indexing_job sysconsole_write_billing sysconsole_read_site_users_and_teams create_public_channel playbook_public_create sysconsole_read_experimental_features sysconsole_read_about_edition_and_license invalidate_email_invite manage_secure_connections sysconsole_read_environment_smtp sysconsole_write_authentication_ldap sysconsole_read_site_notifications edit_custom_group sysconsole_read_compliance_data_retention_policy get_public_link sysconsole_write_about_edition_and_license delete_emojis sysconsole_read_user_management_teams sysconsole_write_compliance_compliance_monitoring reload_config sysconsole_read_site_notices sysconsole_write_user_management_channels add_saml_idp_cert promote_guest sysconsole_read_site_file_sharing_and_downloads sysconsole_write_environment_session_lengths sysconsole_write_site_posts sysconsole_write_site_customization create_data_retention_job test_ldap remove_ldap_private_cert create_private_channel create_emojis sysconsole_read_environment_file_storage create_elasticsearch_post_indexing_job read_public_channel_groups convert_public_channel_to_private read_compliance_export_job sysconsole_read_site_public_links	t	t
soowykci5bbtmdt4zj5mghzfgc	channel_user	authentication.roles.channel_user.name	authentication.roles.channel_user.description	1675955399807	1675955402703	0	 delete_post manage_private_channel_members use_group_mentions manage_public_channel_properties create_post remove_reaction edit_post read_public_channel_groups upload_file manage_public_channel_members use_channel_mentions read_channel read_private_channel_groups manage_private_channel_properties delete_private_channel get_public_link use_slash_commands add_reaction delete_public_channel	t	t
dmd5563itjbi9fu4m1o8m3q85a	playbook_member	authentication.roles.playbook_member.name	authentication.roles.playbook_member.description	1675955399818	1675955402707	0	 run_create playbook_public_view playbook_public_manage_members playbook_public_manage_properties playbook_private_view playbook_private_manage_members playbook_private_manage_properties	t	t
37haby5hsprzjcpthk9nknw67c	run_member	authentication.roles.run_member.name	authentication.roles.run_member.description	1675955399824	1675955402709	0	 run_view	t	t
rmhu9x96s7b7xpnw963oohxinw	system_guest	authentication.roles.global_guest.name	authentication.roles.global_guest.description	1675955399831	1675955402711	0	 create_direct_channel create_group_channel	t	t
ce76ynxpppg6zgd4y56fmzyhge	system_post_all_public	authentication.roles.system_post_all_public.name	authentication.roles.system_post_all_public.description	1675955399837	1675955402714	0	 use_channel_mentions use_group_mentions create_post_public	f	t
3s75xbpn8i8dddzzsyhe7udmma	system_user_manager	authentication.roles.system_user_manager.name	authentication.roles.system_user_manager.description	1675955399893	1675955402719	0	 sysconsole_read_authentication_ldap sysconsole_read_authentication_email sysconsole_write_user_management_teams manage_public_channel_properties sysconsole_read_authentication_saml manage_private_channel_properties manage_public_channel_members read_channel manage_team sysconsole_read_user_management_channels sysconsole_write_user_management_groups manage_channel_roles read_private_channel_groups join_public_teams manage_private_channel_members sysconsole_read_authentication_openid delete_private_channel sysconsole_read_user_management_groups remove_user_from_team list_public_teams sysconsole_read_authentication_mfa add_user_to_team convert_private_channel_to_public test_ldap delete_public_channel sysconsole_write_user_management_channels read_ldap_sync_job read_public_channel join_private_teams list_private_teams convert_public_channel_to_private sysconsole_read_user_management_teams sysconsole_read_authentication_signup manage_team_roles read_public_channel_groups sysconsole_read_authentication_guest_access sysconsole_read_user_management_permissions sysconsole_read_authentication_password view_team	f	t
n96z5yt587yizmuqkj5g7f79jh	system_read_only_admin	authentication.roles.system_read_only_admin.name	authentication.roles.system_read_only_admin.description	1675955399924	1675955402724	0	 sysconsole_read_environment_push_notification_server read_channel sysconsole_read_site_file_sharing_and_downloads get_analytics sysconsole_read_authentication_guest_access sysconsole_read_site_users_and_teams sysconsole_read_experimental_feature_flags read_elasticsearch_post_aggregation_job download_compliance_export_result sysconsole_read_site_public_links sysconsole_read_reporting_server_logs read_elasticsearch_post_indexing_job read_license_information sysconsole_read_integrations_gif sysconsole_read_authentication_password sysconsole_read_user_management_groups list_private_teams sysconsole_read_environment_logging read_data_retention_job list_public_teams sysconsole_read_environment_smtp sysconsole_read_authentication_saml read_other_users_teams sysconsole_read_reporting_team_statistics sysconsole_read_user_management_permissions sysconsole_read_environment_high_availability sysconsole_read_plugins read_ldap_sync_job sysconsole_read_site_announcement_banner sysconsole_read_authentication_ldap sysconsole_read_environment_file_storage read_compliance_export_job sysconsole_read_authentication_email sysconsole_read_site_notices sysconsole_read_about_edition_and_license sysconsole_read_environment_rate_limiting view_team test_ldap sysconsole_read_user_management_channels read_public_channel sysconsole_read_authentication_signup sysconsole_read_reporting_site_statistics sysconsole_read_compliance_custom_terms_of_service sysconsole_read_experimental_features sysconsole_read_environment_session_lengths sysconsole_read_user_management_users sysconsole_read_environment_performance_monitoring sysconsole_read_authentication_openid sysconsole_read_user_management_teams sysconsole_read_integrations_bot_accounts sysconsole_read_environment_database sysconsole_read_environment_image_proxy sysconsole_read_authentication_mfa read_public_channel_groups sysconsole_read_environment_web_server sysconsole_read_integrations_integration_management sysconsole_read_integrations_cors get_logs sysconsole_read_environment_elasticsearch sysconsole_read_products_boards sysconsole_read_site_customization sysconsole_read_experimental_bleve sysconsole_read_site_emoji sysconsole_read_compliance_compliance_monitoring read_private_channel_groups sysconsole_read_site_posts sysconsole_read_environment_developer sysconsole_read_site_notifications read_audits sysconsole_read_compliance_data_retention_policy sysconsole_read_site_localization sysconsole_read_compliance_compliance_export	f	t
3m3dgkrw3byb9p16enpthrpo8w	system_manager	authentication.roles.system_manager.name	authentication.roles.system_manager.description	1675955400010	1675955402740	0	 sysconsole_read_integrations_bot_accounts sysconsole_read_environment_high_availability sysconsole_read_about_edition_and_license sysconsole_read_reporting_server_logs sysconsole_read_authentication_mfa sysconsole_write_environment_smtp sysconsole_read_environment_file_storage sysconsole_read_user_management_channels reload_config read_public_channel_groups sysconsole_read_site_file_sharing_and_downloads sysconsole_read_site_customization create_elasticsearch_post_aggregation_job sysconsole_read_environment_session_lengths sysconsole_read_environment_elasticsearch sysconsole_write_user_management_channels sysconsole_write_site_file_sharing_and_downloads manage_private_channel_properties get_logs test_elasticsearch sysconsole_read_site_notices sysconsole_read_reporting_site_statistics create_elasticsearch_post_indexing_job sysconsole_read_site_localization sysconsole_read_environment_rate_limiting sysconsole_read_reporting_team_statistics purge_elasticsearch_indexes sysconsole_read_site_notifications test_site_url sysconsole_write_site_localization delete_public_channel sysconsole_write_products_boards manage_private_channel_members sysconsole_read_authentication_email convert_public_channel_to_private edit_brand sysconsole_write_integrations_bot_accounts join_public_teams manage_team_roles sysconsole_read_site_public_links sysconsole_read_environment_push_notification_server sysconsole_read_authentication_guest_access manage_team add_user_to_team read_ldap_sync_job sysconsole_write_environment_performance_monitoring convert_private_channel_to_public join_private_teams invalidate_caches sysconsole_read_authentication_saml manage_channel_roles sysconsole_read_environment_performance_monitoring sysconsole_write_user_management_groups sysconsole_read_plugins sysconsole_read_site_announcement_banner read_elasticsearch_post_aggregation_job list_private_teams sysconsole_write_user_management_teams sysconsole_read_site_posts sysconsole_read_integrations_integration_management test_s3 sysconsole_read_environment_developer sysconsole_read_environment_image_proxy sysconsole_write_integrations_integration_management read_license_information sysconsole_read_user_management_teams sysconsole_read_user_management_permissions sysconsole_write_environment_image_proxy read_channel sysconsole_write_environment_web_server sysconsole_write_environment_elasticsearch get_analytics sysconsole_read_environment_smtp sysconsole_write_site_users_and_teams remove_user_from_team sysconsole_write_environment_high_availability sysconsole_read_site_users_and_teams test_ldap manage_public_channel_properties read_public_channel sysconsole_read_integrations_gif sysconsole_read_site_emoji sysconsole_read_products_boards sysconsole_write_environment_logging sysconsole_read_authentication_password sysconsole_read_environment_logging sysconsole_write_site_announcement_banner sysconsole_write_user_management_permissions sysconsole_read_user_management_groups sysconsole_read_authentication_signup test_email manage_public_channel_members sysconsole_write_environment_session_lengths sysconsole_write_environment_push_notification_server sysconsole_write_environment_database read_elasticsearch_post_indexing_job sysconsole_write_site_customization sysconsole_read_environment_web_server sysconsole_write_site_emoji sysconsole_write_environment_developer sysconsole_write_environment_rate_limiting sysconsole_write_integrations_gif read_private_channel_groups sysconsole_write_environment_file_storage sysconsole_read_authentication_ldap sysconsole_read_authentication_openid recycle_database_connections list_public_teams delete_private_channel sysconsole_read_integrations_cors sysconsole_write_site_notifications sysconsole_write_site_public_links view_team sysconsole_write_integrations_cors sysconsole_read_environment_database sysconsole_write_site_notices sysconsole_write_site_posts	f	t
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
uh3yuor4itngzkmp4189tnx6pe	xcpnmx8c3jbnjmggst653ke4kw	1676646350081	1679238350081	1676646350081	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "Mac OS", "csrf": "4zjnq33qz7nijpjbyghuifj6na", "isSaml": "false", "browser": "Chrome/109.0", "isMobile": "false", "is_guest": "false", "platform": "Macintosh", "isOAuthUser": "false"}	f
y978n4jxf7b79ph3ccwfoproeh	bxfcapjqiina9xayxw6y65ubwh	1676646213933	4830246213933	1678033936739	geds3gxhdf81dccdrm8bfx37ry		system_user system_admin	f	{"type": "UserAccessToken", "is_guest": "false", "user_access_token_id": "smw3ipoqajyrdxie69w464cy9e"}	f
17qdxa1ps3b9zxtg81mhsmrttc	zbobs1dw5jgrtby9hkcz3dkpjy	1678032959918	4831632959918	1678034001652	bgct5icpib883fx619bh3cfu6h		system_user	f	{"type": "UserAccessToken", "is_guest": "false", "user_access_token_id": "gbrc7c89sbfepjfxyijj5bkwyh"}	f
fo4846aaei8i38kq9kmhb86xnr	bxfcapjqiina9xayxw6y65ubwh	1676646213929	4830246213929	1678611343615	geds3gxhdf81dccdrm8bfx37ry		system_user system_admin	f	{"type": "UserAccessToken", "is_guest": "false", "user_access_token_id": "smw3ipoqajyrdxie69w464cy9e"}	f
nw4w8ecnz7gy9rt3wm4k68ziqe	i8bz3eaobffm7rgwfrohhjobwa	1678611372912	4832211372912	1678611372912	wq6i7sbf4tnqzbssbn7gy7cjcc		system_user	f	{"type": "UserAccessToken", "is_guest": "false", "user_access_token_id": "nqkt9swge3n87xo18tsdutbryr"}	f
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
favorites_whida44gqpyfierua1wfrnbxtr_ebxg8q3pzbdrdjo7xx1qqw3guy	whida44gqpyfierua1wfrnbxtr	ebxg8q3pzbdrdjo7xx1qqw3guy	0		favorites	Favorites	f	f
channels_whida44gqpyfierua1wfrnbxtr_ebxg8q3pzbdrdjo7xx1qqw3guy	whida44gqpyfierua1wfrnbxtr	ebxg8q3pzbdrdjo7xx1qqw3guy	10		channels	Channels	f	f
direct_messages_whida44gqpyfierua1wfrnbxtr_ebxg8q3pzbdrdjo7xx1qqw3guy	whida44gqpyfierua1wfrnbxtr	ebxg8q3pzbdrdjo7xx1qqw3guy	20	recent	direct_messages	Direct Messages	f	f
favorites_geds3gxhdf81dccdrm8bfx37ry_ebxg8q3pzbdrdjo7xx1qqw3guy	geds3gxhdf81dccdrm8bfx37ry	ebxg8q3pzbdrdjo7xx1qqw3guy	0		favorites	Favorites	f	f
direct_messages_geds3gxhdf81dccdrm8bfx37ry_ebxg8q3pzbdrdjo7xx1qqw3guy	geds3gxhdf81dccdrm8bfx37ry	ebxg8q3pzbdrdjo7xx1qqw3guy	20	recent	direct_messages	Direct Messages	f	f
favorites_ygmycw6rnff7igko8gwbqchujr_ebxg8q3pzbdrdjo7xx1qqw3guy	ygmycw6rnff7igko8gwbqchujr	ebxg8q3pzbdrdjo7xx1qqw3guy	0		favorites	Favorites	f	f
direct_messages_ygmycw6rnff7igko8gwbqchujr_ebxg8q3pzbdrdjo7xx1qqw3guy	ygmycw6rnff7igko8gwbqchujr	ebxg8q3pzbdrdjo7xx1qqw3guy	20	recent	direct_messages	Direct Messages	f	f
favorites_bgct5icpib883fx619bh3cfu6h_ebxg8q3pzbdrdjo7xx1qqw3guy	bgct5icpib883fx619bh3cfu6h	ebxg8q3pzbdrdjo7xx1qqw3guy	0		favorites	Favorites	f	f
channels_bgct5icpib883fx619bh3cfu6h_ebxg8q3pzbdrdjo7xx1qqw3guy	bgct5icpib883fx619bh3cfu6h	ebxg8q3pzbdrdjo7xx1qqw3guy	10		channels	Channels	f	f
direct_messages_bgct5icpib883fx619bh3cfu6h_ebxg8q3pzbdrdjo7xx1qqw3guy	bgct5icpib883fx619bh3cfu6h	ebxg8q3pzbdrdjo7xx1qqw3guy	20	recent	direct_messages	Direct Messages	f	f
channels_geds3gxhdf81dccdrm8bfx37ry_ebxg8q3pzbdrdjo7xx1qqw3guy	geds3gxhdf81dccdrm8bfx37ry	ebxg8q3pzbdrdjo7xx1qqw3guy	10		channels	Channels	f	f
channels_ygmycw6rnff7igko8gwbqchujr_ebxg8q3pzbdrdjo7xx1qqw3guy	ygmycw6rnff7igko8gwbqchujr	ebxg8q3pzbdrdjo7xx1qqw3guy	10		channels	Channels	f	f
favorites_wq6i7sbf4tnqzbssbn7gy7cjcc_ebxg8q3pzbdrdjo7xx1qqw3guy	wq6i7sbf4tnqzbssbn7gy7cjcc	ebxg8q3pzbdrdjo7xx1qqw3guy	0		favorites	Favorites	f	f
channels_wq6i7sbf4tnqzbssbn7gy7cjcc_ebxg8q3pzbdrdjo7xx1qqw3guy	wq6i7sbf4tnqzbssbn7gy7cjcc	ebxg8q3pzbdrdjo7xx1qqw3guy	10		channels	Channels	f	f
direct_messages_wq6i7sbf4tnqzbssbn7gy7cjcc_ebxg8q3pzbdrdjo7xx1qqw3guy	wq6i7sbf4tnqzbssbn7gy7cjcc	ebxg8q3pzbdrdjo7xx1qqw3guy	20	recent	direct_messages	Direct Messages	f	f
favorites_e343y5ecu7dyujwqm7yfimh1je_ebxg8q3pzbdrdjo7xx1qqw3guy	e343y5ecu7dyujwqm7yfimh1je	ebxg8q3pzbdrdjo7xx1qqw3guy	0		favorites	Favorites	f	f
channels_e343y5ecu7dyujwqm7yfimh1je_ebxg8q3pzbdrdjo7xx1qqw3guy	e343y5ecu7dyujwqm7yfimh1je	ebxg8q3pzbdrdjo7xx1qqw3guy	10		channels	Channels	f	f
direct_messages_e343y5ecu7dyujwqm7yfimh1je_ebxg8q3pzbdrdjo7xx1qqw3guy	e343y5ecu7dyujwqm7yfimh1je	ebxg8q3pzbdrdjo7xx1qqw3guy	20	recent	direct_messages	Direct Messages	f	f
\.


--
-- Data for Name: sidebarchannels; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.sidebarchannels (channelid, userid, categoryid, sortorder) FROM stdin;
giyj94p1fp86p8zs9z6u5b3ujh	geds3gxhdf81dccdrm8bfx37ry	channels_geds3gxhdf81dccdrm8bfx37ry_ebxg8q3pzbdrdjo7xx1qqw3guy	10
p7retz8iwtgzdrdceqw13fwmbr	geds3gxhdf81dccdrm8bfx37ry	channels_geds3gxhdf81dccdrm8bfx37ry_ebxg8q3pzbdrdjo7xx1qqw3guy	20
rk4gdc4whjnupqoad46hwa9cme	ygmycw6rnff7igko8gwbqchujr	channels_ygmycw6rnff7igko8gwbqchujr_ebxg8q3pzbdrdjo7xx1qqw3guy	0
9wp7xhh6f7namrfm1asziaf9nh	ygmycw6rnff7igko8gwbqchujr	channels_ygmycw6rnff7igko8gwbqchujr_ebxg8q3pzbdrdjo7xx1qqw3guy	10
giyj94p1fp86p8zs9z6u5b3ujh	ygmycw6rnff7igko8gwbqchujr	channels_ygmycw6rnff7igko8gwbqchujr_ebxg8q3pzbdrdjo7xx1qqw3guy	20
p7retz8iwtgzdrdceqw13fwmbr	ygmycw6rnff7igko8gwbqchujr	channels_ygmycw6rnff7igko8gwbqchujr_ebxg8q3pzbdrdjo7xx1qqw3guy	30
\.


--
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.status (userid, status, manual, lastactivityat, dndendtime, prevstatus) FROM stdin;
whida44gqpyfierua1wfrnbxtr	offline	f	1675956299644	0	
bgct5icpib883fx619bh3cfu6h	offline	f	1678034001648	0	
ygmycw6rnff7igko8gwbqchujr	offline	f	1678034022063	0	
wq6i7sbf4tnqzbssbn7gy7cjcc	online	f	1678611372986	0	
e343y5ecu7dyujwqm7yfimh1je	offline	f	1678611421925	0	
geds3gxhdf81dccdrm8bfx37ry	offline	f	1678611444090	0	
\.


--
-- Data for Name: systems; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.systems (name, value) FROM stdin;
CRTChannelMembershipCountsMigrationComplete	true
CRTThreadCountsAndUnreadsMigrationComplete	true
AsymmetricSigningKey	{"ecdsa_key":{"curve":"P-256","x":60581695069711960390006342233346342337919323610595164976945745154618296289272,"y":27256658457734069685286994869610575277405935570818687355893748260913908058768,"d":65848915887861549171349767132686020608299128055797728715643672013708470201362}}
DiagnosticId	o9fwnewhrfn8br43wgtj4cbkro
FirstServerRunTimestamp	1675955399883
AdvancedPermissionsMigrationComplete	true
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
PostActionCookieSecret	{"key":"1b6qKeFPcn3l3kqRRQNxZXtcD0eX2wyDsY2OkndMkyo="}
InstallationDate	1675955407698
migration_advanced_permissions_phase_2	true
FirstAdminSetupComplete	true
LastSecurityTime	1678611207337
\.


--
-- Data for Name: teammembers; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.teammembers (teamid, userid, roles, deleteat, schemeuser, schemeadmin, schemeguest, createat) FROM stdin;
ebxg8q3pzbdrdjo7xx1qqw3guy	whida44gqpyfierua1wfrnbxtr		0	t	t	f	1675955722063
ebxg8q3pzbdrdjo7xx1qqw3guy	geds3gxhdf81dccdrm8bfx37ry		0	t	f	f	1675956111670
ebxg8q3pzbdrdjo7xx1qqw3guy	ygmycw6rnff7igko8gwbqchujr		0	t	f	f	1675956421284
ebxg8q3pzbdrdjo7xx1qqw3guy	bgct5icpib883fx619bh3cfu6h		0	t	f	f	1676646214604
ebxg8q3pzbdrdjo7xx1qqw3guy	wq6i7sbf4tnqzbssbn7gy7cjcc		0	t	f	f	1678611368085
ebxg8q3pzbdrdjo7xx1qqw3guy	e343y5ecu7dyujwqm7yfimh1je		0	t	f	f	1678611396619
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.teams (id, createat, updateat, deleteat, displayname, name, description, email, type, companyname, alloweddomains, inviteid, schemeid, allowopeninvite, lastteamiconupdate, groupconstrained, cloudlimitsarchived) FROM stdin;
ebxg8q3pzbdrdjo7xx1qqw3guy	1675955722030	1675955743965	0	Default	default		admin@localhost.com	O			mxwqwnwjg3fbbr3o3xpfuw6a3y	\N	t	0	\N	f
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
smw3ipoqajyrdxie69w464cy9e	bxfcapjqiina9xayxw6y65ubwh	geds3gxhdf81dccdrm8bfx37ry	New Bridge Token	t
gbrc7c89sbfepjfxyijj5bkwyh	zbobs1dw5jgrtby9hkcz3dkpjy	bgct5icpib883fx619bh3cfu6h	bridge	t
1wnn4juj47nhuqu6rnbsknpqjh	eox7ugyfujbbdpy4drb1w14nqy	ygmycw6rnff7igko8gwbqchujr	For the bridge	t
mnr319koxbdzibwaihhtetpxsw	deges64nuprjdrke65zqfp7fkw	ygmycw6rnff7igko8gwbqchujr	For the bridge	t
nqkt9swge3n87xo18tsdutbryr	i8bz3eaobffm7rgwfrohhjobwa	wq6i7sbf4tnqzbssbn7gy7cjcc	For the bridge	t
fst4r7d4ninxtexjknn4y4ooqa	s34w4m8qw7dybmn4qb8qfwyhfr	e343y5ecu7dyujwqm7yfimh1je	For the bridge	t
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
g6hetueczp8wif38h7o3o1pcyc	1675955410087	1675955410087	0	boards		\N		boards@localhost	f		Boards		system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1675955410087	0	0	en	f			{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	\N
59858ksa4ircjd9a5811negojr	1675955999723	1675955999723	0	system-bot		\N		system-bot@localhost	f		System		system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1675955999723	0	0	en	f			{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	\N
whida44gqpyfierua1wfrnbxtr	1675955707161	1675955722081	0	admin	$2a$10$F/SOv8pg1NY3p9ZH6USjxOLr02DqMH4SgTEUnKVZlqPLtrkL.lNEK	\N		admin@localhost.com	f				system_admin system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1675955707161	0	0	en	f			{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	\N
geds3gxhdf81dccdrm8bfx37ry	1675956108535	1675956222140	0	matrix.bridge	$2a$10$JXCrzoCJTcpdLmjN1XYghuFiZOizqFjNvlAoSCjt5mhkgJl6owVhu	\N		matrix.bridge@localhost.com	f				system_user system_admin	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1675956108535	0	0	en	f			{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	\N
ygmycw6rnff7igko8gwbqchujr	1675956418277	1675956421298	0	user1.mm	$2a$10$P31EGMdOVpLdPjTky0zd6u6BSLvOMix7MvPxqO5D5k1bf/Pqv/yYK	\N		user1.mm@localhost.com	f				system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1675956418277	0	0	en	f			{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	\N
uzpc4t1qkjbt3gspmrtmuzrimw	1675955407698	1678611212511	0	appsbot		\N		appsbot@localhost	f		Mattermost Apps		system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1675955407698	1678611212511	0	en	f			{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	\N
nm4raj8trpgetcnutzc8icka7r	1675955408397	1678611213110	0	playbooks		\N		playbooks@localhost	f		Playbooks		system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1675955408397	1678611213110	0	en	f			{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	\N
bgct5icpib883fx619bh3cfu6h	1676646214332	1678611343545	0	matrix_user1.matrix	$2a$10$q9SUFyaY6Lra0k7p8YK0YOqT9gP0GS3qw1X8dELNq2PrkEYPBilsW	\N		devnull-t6oqx2s4cgfznyuj@localhost	t		user1.matrix		system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1676646214332	0	0	en	f			{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	\N
wq6i7sbf4tnqzbssbn7gy7cjcc	1678611367465	1678611368123	0	matrix_user2.matrix	$2a$10$Kj2G4VTsS3boBXjoLlSGU.PTIpAwfrpnmikFUctIOqBXVQAEOQWb6	\N		devnull-uszv_qq4l94sqhy7@localhost	t				system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1678611367465	0	0	en	f			{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	\N
e343y5ecu7dyujwqm7yfimh1je	1678611392548	1678611396635	0	user2.mm	$2a$10$vBYh6HG1k6KG50zVq05mW.5XanoPoJ.G6pbypi5.1cImTp0QtGKky	\N		user2.mm@localhost.com	f				system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1678611392548	0	0	en	f			{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	\N
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

