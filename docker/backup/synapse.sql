\c synapse
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
-- Name: access_tokens; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.access_tokens (
    id bigint NOT NULL,
    user_id text NOT NULL,
    device_id text,
    token text NOT NULL,
    valid_until_ms bigint,
    puppets_user_id text,
    last_validated bigint,
    refresh_token_id bigint,
    used boolean
);


ALTER TABLE public.access_tokens OWNER TO synapse;

--
-- Name: account_data; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.account_data (
    user_id text NOT NULL,
    account_data_type text NOT NULL,
    stream_id bigint NOT NULL,
    content text NOT NULL,
    instance_name text
);


ALTER TABLE public.account_data OWNER TO synapse;

--
-- Name: account_data_sequence; Type: SEQUENCE; Schema: public; Owner: synapse
--

CREATE SEQUENCE public.account_data_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_data_sequence OWNER TO synapse;

--
-- Name: account_validity; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.account_validity (
    user_id text NOT NULL,
    expiration_ts_ms bigint NOT NULL,
    email_sent boolean NOT NULL,
    renewal_token text,
    token_used_ts_ms bigint
);


ALTER TABLE public.account_validity OWNER TO synapse;

--
-- Name: application_services_state; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.application_services_state (
    as_id text NOT NULL,
    state character varying(5),
    last_txn bigint,
    read_receipt_stream_id bigint,
    presence_stream_id bigint
);


ALTER TABLE public.application_services_state OWNER TO synapse;

--
-- Name: application_services_txns; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.application_services_txns (
    as_id text NOT NULL,
    txn_id bigint NOT NULL,
    event_ids text NOT NULL
);


ALTER TABLE public.application_services_txns OWNER TO synapse;

--
-- Name: applied_module_schemas; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.applied_module_schemas (
    module_name text NOT NULL,
    file text NOT NULL
);


ALTER TABLE public.applied_module_schemas OWNER TO synapse;

--
-- Name: applied_schema_deltas; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.applied_schema_deltas (
    version integer NOT NULL,
    file text NOT NULL
);


ALTER TABLE public.applied_schema_deltas OWNER TO synapse;

--
-- Name: appservice_room_list; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.appservice_room_list (
    appservice_id text NOT NULL,
    network_id text NOT NULL,
    room_id text NOT NULL
);


ALTER TABLE public.appservice_room_list OWNER TO synapse;

--
-- Name: appservice_stream_position; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.appservice_stream_position (
    lock character(1) DEFAULT 'X'::bpchar NOT NULL,
    stream_ordering bigint,
    CONSTRAINT appservice_stream_position_lock_check CHECK ((lock = 'X'::bpchar))
);


ALTER TABLE public.appservice_stream_position OWNER TO synapse;

--
-- Name: background_updates; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.background_updates (
    update_name text NOT NULL,
    progress_json text NOT NULL,
    depends_on text,
    ordering integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.background_updates OWNER TO synapse;

--
-- Name: batch_events; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.batch_events (
    event_id text NOT NULL,
    room_id text NOT NULL,
    batch_id text NOT NULL
);


ALTER TABLE public.batch_events OWNER TO synapse;

--
-- Name: blocked_rooms; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.blocked_rooms (
    room_id text NOT NULL,
    user_id text NOT NULL
);


ALTER TABLE public.blocked_rooms OWNER TO synapse;

--
-- Name: cache_invalidation_stream_by_instance; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.cache_invalidation_stream_by_instance (
    stream_id bigint NOT NULL,
    instance_name text NOT NULL,
    cache_func text NOT NULL,
    keys text[],
    invalidation_ts bigint
);


ALTER TABLE public.cache_invalidation_stream_by_instance OWNER TO synapse;

--
-- Name: cache_invalidation_stream_seq; Type: SEQUENCE; Schema: public; Owner: synapse
--

CREATE SEQUENCE public.cache_invalidation_stream_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cache_invalidation_stream_seq OWNER TO synapse;

--
-- Name: current_state_delta_stream; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.current_state_delta_stream (
    stream_id bigint NOT NULL,
    room_id text NOT NULL,
    type text NOT NULL,
    state_key text NOT NULL,
    event_id text,
    prev_event_id text,
    instance_name text
);


ALTER TABLE public.current_state_delta_stream OWNER TO synapse;

--
-- Name: current_state_events; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.current_state_events (
    event_id text NOT NULL,
    room_id text NOT NULL,
    type text NOT NULL,
    state_key text NOT NULL,
    membership text
);


ALTER TABLE public.current_state_events OWNER TO synapse;

--
-- Name: dehydrated_devices; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.dehydrated_devices (
    user_id text NOT NULL,
    device_id text NOT NULL,
    device_data text NOT NULL
);


ALTER TABLE public.dehydrated_devices OWNER TO synapse;

--
-- Name: deleted_pushers; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.deleted_pushers (
    stream_id bigint NOT NULL,
    app_id text NOT NULL,
    pushkey text NOT NULL,
    user_id text NOT NULL
);


ALTER TABLE public.deleted_pushers OWNER TO synapse;

--
-- Name: destination_rooms; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.destination_rooms (
    destination text NOT NULL,
    room_id text NOT NULL,
    stream_ordering bigint NOT NULL
);


ALTER TABLE public.destination_rooms OWNER TO synapse;

--
-- Name: destinations; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.destinations (
    destination text NOT NULL,
    retry_last_ts bigint,
    retry_interval bigint,
    failure_ts bigint,
    last_successful_stream_ordering bigint
);


ALTER TABLE public.destinations OWNER TO synapse;

--
-- Name: device_federation_inbox; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.device_federation_inbox (
    origin text NOT NULL,
    message_id text NOT NULL,
    received_ts bigint NOT NULL,
    instance_name text
);


ALTER TABLE public.device_federation_inbox OWNER TO synapse;

--
-- Name: device_federation_outbox; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.device_federation_outbox (
    destination text NOT NULL,
    stream_id bigint NOT NULL,
    queued_ts bigint NOT NULL,
    messages_json text NOT NULL,
    instance_name text
);


ALTER TABLE public.device_federation_outbox OWNER TO synapse;

--
-- Name: device_inbox; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.device_inbox (
    user_id text NOT NULL,
    device_id text NOT NULL,
    stream_id bigint NOT NULL,
    message_json text NOT NULL,
    instance_name text
);


ALTER TABLE public.device_inbox OWNER TO synapse;

--
-- Name: device_inbox_sequence; Type: SEQUENCE; Schema: public; Owner: synapse
--

CREATE SEQUENCE public.device_inbox_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.device_inbox_sequence OWNER TO synapse;

--
-- Name: device_lists_outbound_last_success; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.device_lists_outbound_last_success (
    destination text NOT NULL,
    user_id text NOT NULL,
    stream_id bigint NOT NULL
);


ALTER TABLE public.device_lists_outbound_last_success OWNER TO synapse;

--
-- Name: device_lists_outbound_pokes; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.device_lists_outbound_pokes (
    destination text NOT NULL,
    stream_id bigint NOT NULL,
    user_id text NOT NULL,
    device_id text NOT NULL,
    sent boolean NOT NULL,
    ts bigint NOT NULL,
    opentracing_context text
);


ALTER TABLE public.device_lists_outbound_pokes OWNER TO synapse;

--
-- Name: device_lists_remote_cache; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.device_lists_remote_cache (
    user_id text NOT NULL,
    device_id text NOT NULL,
    content text NOT NULL
);


ALTER TABLE public.device_lists_remote_cache OWNER TO synapse;

--
-- Name: device_lists_remote_extremeties; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.device_lists_remote_extremeties (
    user_id text NOT NULL,
    stream_id text NOT NULL
);


ALTER TABLE public.device_lists_remote_extremeties OWNER TO synapse;

--
-- Name: device_lists_remote_resync; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.device_lists_remote_resync (
    user_id text NOT NULL,
    added_ts bigint NOT NULL
);


ALTER TABLE public.device_lists_remote_resync OWNER TO synapse;

--
-- Name: device_lists_stream; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.device_lists_stream (
    stream_id bigint NOT NULL,
    user_id text NOT NULL,
    device_id text NOT NULL
);


ALTER TABLE public.device_lists_stream OWNER TO synapse;

--
-- Name: devices; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.devices (
    user_id text NOT NULL,
    device_id text NOT NULL,
    display_name text,
    last_seen bigint,
    ip text,
    user_agent text,
    hidden boolean DEFAULT false
);


ALTER TABLE public.devices OWNER TO synapse;

--
-- Name: e2e_cross_signing_keys; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.e2e_cross_signing_keys (
    user_id text NOT NULL,
    keytype text NOT NULL,
    keydata text NOT NULL,
    stream_id bigint NOT NULL
);


ALTER TABLE public.e2e_cross_signing_keys OWNER TO synapse;

--
-- Name: e2e_cross_signing_signatures; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.e2e_cross_signing_signatures (
    user_id text NOT NULL,
    key_id text NOT NULL,
    target_user_id text NOT NULL,
    target_device_id text NOT NULL,
    signature text NOT NULL
);


ALTER TABLE public.e2e_cross_signing_signatures OWNER TO synapse;

--
-- Name: e2e_device_keys_json; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.e2e_device_keys_json (
    user_id text NOT NULL,
    device_id text NOT NULL,
    ts_added_ms bigint NOT NULL,
    key_json text NOT NULL
);


ALTER TABLE public.e2e_device_keys_json OWNER TO synapse;

--
-- Name: e2e_fallback_keys_json; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.e2e_fallback_keys_json (
    user_id text NOT NULL,
    device_id text NOT NULL,
    algorithm text NOT NULL,
    key_id text NOT NULL,
    key_json text NOT NULL,
    used boolean DEFAULT false NOT NULL
);


ALTER TABLE public.e2e_fallback_keys_json OWNER TO synapse;

--
-- Name: e2e_one_time_keys_json; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.e2e_one_time_keys_json (
    user_id text NOT NULL,
    device_id text NOT NULL,
    algorithm text NOT NULL,
    key_id text NOT NULL,
    ts_added_ms bigint NOT NULL,
    key_json text NOT NULL
);


ALTER TABLE public.e2e_one_time_keys_json OWNER TO synapse;

--
-- Name: e2e_room_keys; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.e2e_room_keys (
    user_id text NOT NULL,
    room_id text NOT NULL,
    session_id text NOT NULL,
    version bigint NOT NULL,
    first_message_index integer,
    forwarded_count integer,
    is_verified boolean,
    session_data text NOT NULL
);


ALTER TABLE public.e2e_room_keys OWNER TO synapse;

--
-- Name: e2e_room_keys_versions; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.e2e_room_keys_versions (
    user_id text NOT NULL,
    version bigint NOT NULL,
    algorithm text NOT NULL,
    auth_data text NOT NULL,
    deleted smallint DEFAULT 0 NOT NULL,
    etag bigint
);


ALTER TABLE public.e2e_room_keys_versions OWNER TO synapse;

--
-- Name: erased_users; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.erased_users (
    user_id text NOT NULL
);


ALTER TABLE public.erased_users OWNER TO synapse;

--
-- Name: event_auth; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_auth (
    event_id text NOT NULL,
    auth_id text NOT NULL,
    room_id text NOT NULL
);


ALTER TABLE public.event_auth OWNER TO synapse;

--
-- Name: event_auth_chain_id; Type: SEQUENCE; Schema: public; Owner: synapse
--

CREATE SEQUENCE public.event_auth_chain_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.event_auth_chain_id OWNER TO synapse;

--
-- Name: event_auth_chain_links; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_auth_chain_links (
    origin_chain_id bigint NOT NULL,
    origin_sequence_number bigint NOT NULL,
    target_chain_id bigint NOT NULL,
    target_sequence_number bigint NOT NULL
);


ALTER TABLE public.event_auth_chain_links OWNER TO synapse;

--
-- Name: event_auth_chain_to_calculate; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_auth_chain_to_calculate (
    event_id text NOT NULL,
    room_id text NOT NULL,
    type text NOT NULL,
    state_key text NOT NULL
);


ALTER TABLE public.event_auth_chain_to_calculate OWNER TO synapse;

--
-- Name: event_auth_chains; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_auth_chains (
    event_id text NOT NULL,
    chain_id bigint NOT NULL,
    sequence_number bigint NOT NULL
);


ALTER TABLE public.event_auth_chains OWNER TO synapse;

--
-- Name: event_backward_extremities; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_backward_extremities (
    event_id text NOT NULL,
    room_id text NOT NULL
);


ALTER TABLE public.event_backward_extremities OWNER TO synapse;

--
-- Name: event_edges; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_edges (
    event_id text NOT NULL,
    prev_event_id text NOT NULL,
    room_id text NOT NULL,
    is_state boolean NOT NULL
);


ALTER TABLE public.event_edges OWNER TO synapse;

--
-- Name: event_expiry; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_expiry (
    event_id text NOT NULL,
    expiry_ts bigint NOT NULL
);


ALTER TABLE public.event_expiry OWNER TO synapse;

--
-- Name: event_forward_extremities; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_forward_extremities (
    event_id text NOT NULL,
    room_id text NOT NULL
);


ALTER TABLE public.event_forward_extremities OWNER TO synapse;

--
-- Name: event_json; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_json (
    event_id text NOT NULL,
    room_id text NOT NULL,
    internal_metadata text NOT NULL,
    json text NOT NULL,
    format_version integer
);


ALTER TABLE public.event_json OWNER TO synapse;

--
-- Name: event_labels; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_labels (
    event_id text NOT NULL,
    label text NOT NULL,
    room_id text NOT NULL,
    topological_ordering bigint NOT NULL
);


ALTER TABLE public.event_labels OWNER TO synapse;

--
-- Name: event_push_actions; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_push_actions (
    room_id text NOT NULL,
    event_id text NOT NULL,
    user_id text NOT NULL,
    profile_tag character varying(32),
    actions text NOT NULL,
    topological_ordering bigint,
    stream_ordering bigint,
    notif smallint,
    highlight smallint,
    unread smallint
);


ALTER TABLE public.event_push_actions OWNER TO synapse;

--
-- Name: event_push_actions_staging; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_push_actions_staging (
    event_id text NOT NULL,
    user_id text NOT NULL,
    actions text NOT NULL,
    notif smallint NOT NULL,
    highlight smallint NOT NULL,
    unread smallint
);


ALTER TABLE public.event_push_actions_staging OWNER TO synapse;

--
-- Name: event_push_summary; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_push_summary (
    user_id text NOT NULL,
    room_id text NOT NULL,
    notif_count bigint NOT NULL,
    stream_ordering bigint NOT NULL,
    unread_count bigint
);


ALTER TABLE public.event_push_summary OWNER TO synapse;

--
-- Name: event_push_summary_stream_ordering; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_push_summary_stream_ordering (
    lock character(1) DEFAULT 'X'::bpchar NOT NULL,
    stream_ordering bigint NOT NULL,
    CONSTRAINT event_push_summary_stream_ordering_lock_check CHECK ((lock = 'X'::bpchar))
);


ALTER TABLE public.event_push_summary_stream_ordering OWNER TO synapse;

--
-- Name: event_reference_hashes; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_reference_hashes (
    event_id text,
    algorithm text,
    hash bytea
);


ALTER TABLE public.event_reference_hashes OWNER TO synapse;

--
-- Name: event_relations; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_relations (
    event_id text NOT NULL,
    relates_to_id text NOT NULL,
    relation_type text NOT NULL,
    aggregation_key text
);


ALTER TABLE public.event_relations OWNER TO synapse;

--
-- Name: event_reports; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_reports (
    id bigint NOT NULL,
    received_ts bigint NOT NULL,
    room_id text NOT NULL,
    event_id text NOT NULL,
    user_id text NOT NULL,
    reason text,
    content text
);


ALTER TABLE public.event_reports OWNER TO synapse;

--
-- Name: event_search; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_search (
    event_id text,
    room_id text,
    sender text,
    key text,
    vector tsvector,
    origin_server_ts bigint,
    stream_ordering bigint
);


ALTER TABLE public.event_search OWNER TO synapse;

--
-- Name: event_to_state_groups; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_to_state_groups (
    event_id text NOT NULL,
    state_group bigint NOT NULL
);


ALTER TABLE public.event_to_state_groups OWNER TO synapse;

--
-- Name: event_txn_id; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_txn_id (
    event_id text NOT NULL,
    room_id text NOT NULL,
    user_id text NOT NULL,
    token_id bigint NOT NULL,
    txn_id text NOT NULL,
    inserted_ts bigint NOT NULL
);


ALTER TABLE public.event_txn_id OWNER TO synapse;

--
-- Name: events; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.events (
    topological_ordering bigint NOT NULL,
    event_id text NOT NULL,
    type text NOT NULL,
    room_id text NOT NULL,
    content text,
    unrecognized_keys text,
    processed boolean NOT NULL,
    outlier boolean NOT NULL,
    depth bigint DEFAULT 0 NOT NULL,
    origin_server_ts bigint,
    received_ts bigint,
    sender text,
    contains_url boolean,
    instance_name text,
    stream_ordering bigint
);


ALTER TABLE public.events OWNER TO synapse;

--
-- Name: events_backfill_stream_seq; Type: SEQUENCE; Schema: public; Owner: synapse
--

CREATE SEQUENCE public.events_backfill_stream_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.events_backfill_stream_seq OWNER TO synapse;

--
-- Name: events_stream_seq; Type: SEQUENCE; Schema: public; Owner: synapse
--

CREATE SEQUENCE public.events_stream_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.events_stream_seq OWNER TO synapse;

--
-- Name: ex_outlier_stream; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.ex_outlier_stream (
    event_stream_ordering bigint NOT NULL,
    event_id text NOT NULL,
    state_group bigint NOT NULL,
    instance_name text
);


ALTER TABLE public.ex_outlier_stream OWNER TO synapse;

--
-- Name: federation_inbound_events_staging; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.federation_inbound_events_staging (
    origin text NOT NULL,
    room_id text NOT NULL,
    event_id text NOT NULL,
    received_ts bigint NOT NULL,
    event_json text NOT NULL,
    internal_metadata text NOT NULL
);


ALTER TABLE public.federation_inbound_events_staging OWNER TO synapse;

--
-- Name: federation_stream_position; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.federation_stream_position (
    type text NOT NULL,
    stream_id bigint NOT NULL,
    instance_name text DEFAULT 'master'::text NOT NULL
);


ALTER TABLE public.federation_stream_position OWNER TO synapse;

--
-- Name: group_attestations_remote; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.group_attestations_remote (
    group_id text NOT NULL,
    user_id text NOT NULL,
    valid_until_ms bigint NOT NULL,
    attestation_json text NOT NULL
);


ALTER TABLE public.group_attestations_remote OWNER TO synapse;

--
-- Name: group_attestations_renewals; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.group_attestations_renewals (
    group_id text NOT NULL,
    user_id text NOT NULL,
    valid_until_ms bigint NOT NULL
);


ALTER TABLE public.group_attestations_renewals OWNER TO synapse;

--
-- Name: group_invites; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.group_invites (
    group_id text NOT NULL,
    user_id text NOT NULL
);


ALTER TABLE public.group_invites OWNER TO synapse;

--
-- Name: group_roles; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.group_roles (
    group_id text NOT NULL,
    role_id text NOT NULL,
    profile text NOT NULL,
    is_public boolean NOT NULL
);


ALTER TABLE public.group_roles OWNER TO synapse;

--
-- Name: group_room_categories; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.group_room_categories (
    group_id text NOT NULL,
    category_id text NOT NULL,
    profile text NOT NULL,
    is_public boolean NOT NULL
);


ALTER TABLE public.group_room_categories OWNER TO synapse;

--
-- Name: group_rooms; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.group_rooms (
    group_id text NOT NULL,
    room_id text NOT NULL,
    is_public boolean NOT NULL
);


ALTER TABLE public.group_rooms OWNER TO synapse;

--
-- Name: group_summary_roles; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.group_summary_roles (
    group_id text NOT NULL,
    role_id text NOT NULL,
    role_order bigint NOT NULL,
    CONSTRAINT group_summary_roles_role_order_check CHECK ((role_order > 0))
);


ALTER TABLE public.group_summary_roles OWNER TO synapse;

--
-- Name: group_summary_room_categories; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.group_summary_room_categories (
    group_id text NOT NULL,
    category_id text NOT NULL,
    cat_order bigint NOT NULL,
    CONSTRAINT group_summary_room_categories_cat_order_check CHECK ((cat_order > 0))
);


ALTER TABLE public.group_summary_room_categories OWNER TO synapse;

--
-- Name: group_summary_rooms; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.group_summary_rooms (
    group_id text NOT NULL,
    room_id text NOT NULL,
    category_id text NOT NULL,
    room_order bigint NOT NULL,
    is_public boolean NOT NULL,
    CONSTRAINT group_summary_rooms_room_order_check CHECK ((room_order > 0))
);


ALTER TABLE public.group_summary_rooms OWNER TO synapse;

--
-- Name: group_summary_users; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.group_summary_users (
    group_id text NOT NULL,
    user_id text NOT NULL,
    role_id text NOT NULL,
    user_order bigint NOT NULL,
    is_public boolean NOT NULL
);


ALTER TABLE public.group_summary_users OWNER TO synapse;

--
-- Name: group_users; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.group_users (
    group_id text NOT NULL,
    user_id text NOT NULL,
    is_admin boolean NOT NULL,
    is_public boolean NOT NULL
);


ALTER TABLE public.group_users OWNER TO synapse;

--
-- Name: groups; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.groups (
    group_id text NOT NULL,
    name text,
    avatar_url text,
    short_description text,
    long_description text,
    is_public boolean NOT NULL,
    join_policy text DEFAULT 'invite'::text NOT NULL
);


ALTER TABLE public.groups OWNER TO synapse;

--
-- Name: ignored_users; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.ignored_users (
    ignorer_user_id text NOT NULL,
    ignored_user_id text NOT NULL
);


ALTER TABLE public.ignored_users OWNER TO synapse;

--
-- Name: insertion_event_edges; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.insertion_event_edges (
    event_id text NOT NULL,
    room_id text NOT NULL,
    insertion_prev_event_id text NOT NULL
);


ALTER TABLE public.insertion_event_edges OWNER TO synapse;

--
-- Name: insertion_event_extremities; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.insertion_event_extremities (
    event_id text NOT NULL,
    room_id text NOT NULL
);


ALTER TABLE public.insertion_event_extremities OWNER TO synapse;

--
-- Name: insertion_events; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.insertion_events (
    event_id text NOT NULL,
    room_id text NOT NULL,
    next_batch_id text NOT NULL
);


ALTER TABLE public.insertion_events OWNER TO synapse;

--
-- Name: instance_map; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.instance_map (
    instance_id integer NOT NULL,
    instance_name text NOT NULL
);


ALTER TABLE public.instance_map OWNER TO synapse;

--
-- Name: instance_map_instance_id_seq; Type: SEQUENCE; Schema: public; Owner: synapse
--

CREATE SEQUENCE public.instance_map_instance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.instance_map_instance_id_seq OWNER TO synapse;

--
-- Name: instance_map_instance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: synapse
--

ALTER SEQUENCE public.instance_map_instance_id_seq OWNED BY public.instance_map.instance_id;


--
-- Name: local_current_membership; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.local_current_membership (
    room_id text NOT NULL,
    user_id text NOT NULL,
    event_id text NOT NULL,
    membership text NOT NULL
);


ALTER TABLE public.local_current_membership OWNER TO synapse;

--
-- Name: local_group_membership; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.local_group_membership (
    group_id text NOT NULL,
    user_id text NOT NULL,
    is_admin boolean NOT NULL,
    membership text NOT NULL,
    is_publicised boolean NOT NULL,
    content text NOT NULL
);


ALTER TABLE public.local_group_membership OWNER TO synapse;

--
-- Name: local_group_updates; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.local_group_updates (
    stream_id bigint NOT NULL,
    group_id text NOT NULL,
    user_id text NOT NULL,
    type text NOT NULL,
    content text NOT NULL
);


ALTER TABLE public.local_group_updates OWNER TO synapse;

--
-- Name: local_media_repository; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.local_media_repository (
    media_id text,
    media_type text,
    media_length integer,
    created_ts bigint,
    upload_name text,
    user_id text,
    quarantined_by text,
    url_cache text,
    last_access_ts bigint,
    safe_from_quarantine boolean DEFAULT false NOT NULL
);


ALTER TABLE public.local_media_repository OWNER TO synapse;

--
-- Name: local_media_repository_thumbnails; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.local_media_repository_thumbnails (
    media_id text,
    thumbnail_width integer,
    thumbnail_height integer,
    thumbnail_type text,
    thumbnail_method text,
    thumbnail_length integer
);


ALTER TABLE public.local_media_repository_thumbnails OWNER TO synapse;

--
-- Name: local_media_repository_url_cache; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.local_media_repository_url_cache (
    url text,
    response_code integer,
    etag text,
    expires_ts bigint,
    og text,
    media_id text,
    download_ts bigint
);


ALTER TABLE public.local_media_repository_url_cache OWNER TO synapse;

--
-- Name: monthly_active_users; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.monthly_active_users (
    user_id text NOT NULL,
    "timestamp" bigint NOT NULL
);


ALTER TABLE public.monthly_active_users OWNER TO synapse;

--
-- Name: open_id_tokens; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.open_id_tokens (
    token text NOT NULL,
    ts_valid_until_ms bigint NOT NULL,
    user_id text NOT NULL
);


ALTER TABLE public.open_id_tokens OWNER TO synapse;

--
-- Name: presence; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.presence (
    user_id text NOT NULL,
    state character varying(20),
    status_msg text,
    mtime bigint
);


ALTER TABLE public.presence OWNER TO synapse;

--
-- Name: presence_stream; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.presence_stream (
    stream_id bigint,
    user_id text,
    state text,
    last_active_ts bigint,
    last_federation_update_ts bigint,
    last_user_sync_ts bigint,
    status_msg text,
    currently_active boolean,
    instance_name text
);


ALTER TABLE public.presence_stream OWNER TO synapse;

--
-- Name: presence_stream_sequence; Type: SEQUENCE; Schema: public; Owner: synapse
--

CREATE SEQUENCE public.presence_stream_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.presence_stream_sequence OWNER TO synapse;

--
-- Name: profiles; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.profiles (
    user_id text NOT NULL,
    displayname text,
    avatar_url text
);


ALTER TABLE public.profiles OWNER TO synapse;

--
-- Name: public_room_list_stream; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.public_room_list_stream (
    stream_id bigint NOT NULL,
    room_id text NOT NULL,
    visibility boolean NOT NULL,
    appservice_id text,
    network_id text
);


ALTER TABLE public.public_room_list_stream OWNER TO synapse;

--
-- Name: push_rules; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.push_rules (
    id bigint NOT NULL,
    user_name text NOT NULL,
    rule_id text NOT NULL,
    priority_class smallint NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    conditions text NOT NULL,
    actions text NOT NULL
);


ALTER TABLE public.push_rules OWNER TO synapse;

--
-- Name: push_rules_enable; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.push_rules_enable (
    id bigint NOT NULL,
    user_name text NOT NULL,
    rule_id text NOT NULL,
    enabled smallint
);


ALTER TABLE public.push_rules_enable OWNER TO synapse;

--
-- Name: push_rules_stream; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.push_rules_stream (
    stream_id bigint NOT NULL,
    event_stream_ordering bigint NOT NULL,
    user_id text NOT NULL,
    rule_id text NOT NULL,
    op text NOT NULL,
    priority_class smallint,
    priority integer,
    conditions text,
    actions text
);


ALTER TABLE public.push_rules_stream OWNER TO synapse;

--
-- Name: pusher_throttle; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.pusher_throttle (
    pusher bigint NOT NULL,
    room_id text NOT NULL,
    last_sent_ts bigint,
    throttle_ms bigint
);


ALTER TABLE public.pusher_throttle OWNER TO synapse;

--
-- Name: pushers; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.pushers (
    id bigint NOT NULL,
    user_name text NOT NULL,
    access_token bigint,
    profile_tag text NOT NULL,
    kind text NOT NULL,
    app_id text NOT NULL,
    app_display_name text NOT NULL,
    device_display_name text NOT NULL,
    pushkey text NOT NULL,
    ts bigint NOT NULL,
    lang text,
    data text,
    last_stream_ordering bigint,
    last_success bigint,
    failing_since bigint
);


ALTER TABLE public.pushers OWNER TO synapse;

--
-- Name: ratelimit_override; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.ratelimit_override (
    user_id text NOT NULL,
    messages_per_second bigint,
    burst_count bigint
);


ALTER TABLE public.ratelimit_override OWNER TO synapse;

--
-- Name: receipts_graph; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.receipts_graph (
    room_id text NOT NULL,
    receipt_type text NOT NULL,
    user_id text NOT NULL,
    event_ids text NOT NULL,
    data text NOT NULL
);


ALTER TABLE public.receipts_graph OWNER TO synapse;

--
-- Name: receipts_linearized; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.receipts_linearized (
    stream_id bigint NOT NULL,
    room_id text NOT NULL,
    receipt_type text NOT NULL,
    user_id text NOT NULL,
    event_id text NOT NULL,
    data text NOT NULL,
    instance_name text
);


ALTER TABLE public.receipts_linearized OWNER TO synapse;

--
-- Name: receipts_sequence; Type: SEQUENCE; Schema: public; Owner: synapse
--

CREATE SEQUENCE public.receipts_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.receipts_sequence OWNER TO synapse;

--
-- Name: received_transactions; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.received_transactions (
    transaction_id text,
    origin text,
    ts bigint,
    response_code integer,
    response_json bytea,
    has_been_referenced smallint DEFAULT 0
);


ALTER TABLE public.received_transactions OWNER TO synapse;

--
-- Name: redactions; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.redactions (
    event_id text NOT NULL,
    redacts text NOT NULL,
    have_censored boolean DEFAULT false NOT NULL,
    received_ts bigint
);


ALTER TABLE public.redactions OWNER TO synapse;

--
-- Name: refresh_tokens; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.refresh_tokens (
    id bigint NOT NULL,
    user_id text NOT NULL,
    device_id text NOT NULL,
    token text NOT NULL,
    next_token_id bigint
);


ALTER TABLE public.refresh_tokens OWNER TO synapse;

--
-- Name: registration_tokens; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.registration_tokens (
    token text NOT NULL,
    uses_allowed integer,
    pending integer NOT NULL,
    completed integer NOT NULL,
    expiry_time bigint
);


ALTER TABLE public.registration_tokens OWNER TO synapse;

--
-- Name: rejections; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.rejections (
    event_id text NOT NULL,
    reason text NOT NULL,
    last_check text NOT NULL
);


ALTER TABLE public.rejections OWNER TO synapse;

--
-- Name: remote_media_cache; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.remote_media_cache (
    media_origin text,
    media_id text,
    media_type text,
    created_ts bigint,
    upload_name text,
    media_length integer,
    filesystem_id text,
    last_access_ts bigint,
    quarantined_by text
);


ALTER TABLE public.remote_media_cache OWNER TO synapse;

--
-- Name: remote_media_cache_thumbnails; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.remote_media_cache_thumbnails (
    media_origin text,
    media_id text,
    thumbnail_width integer,
    thumbnail_height integer,
    thumbnail_method text,
    thumbnail_type text,
    thumbnail_length integer,
    filesystem_id text
);


ALTER TABLE public.remote_media_cache_thumbnails OWNER TO synapse;

--
-- Name: remote_profile_cache; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.remote_profile_cache (
    user_id text NOT NULL,
    displayname text,
    avatar_url text,
    last_check bigint NOT NULL
);


ALTER TABLE public.remote_profile_cache OWNER TO synapse;

--
-- Name: room_account_data; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.room_account_data (
    user_id text NOT NULL,
    room_id text NOT NULL,
    account_data_type text NOT NULL,
    stream_id bigint NOT NULL,
    content text NOT NULL,
    instance_name text
);


ALTER TABLE public.room_account_data OWNER TO synapse;

--
-- Name: room_alias_servers; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.room_alias_servers (
    room_alias text NOT NULL,
    server text NOT NULL
);


ALTER TABLE public.room_alias_servers OWNER TO synapse;

--
-- Name: room_aliases; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.room_aliases (
    room_alias text NOT NULL,
    room_id text NOT NULL,
    creator text
);


ALTER TABLE public.room_aliases OWNER TO synapse;

--
-- Name: room_depth; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.room_depth (
    room_id text NOT NULL,
    min_depth bigint
);


ALTER TABLE public.room_depth OWNER TO synapse;

--
-- Name: room_memberships; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.room_memberships (
    event_id text NOT NULL,
    user_id text NOT NULL,
    sender text NOT NULL,
    room_id text NOT NULL,
    membership text NOT NULL,
    forgotten integer DEFAULT 0,
    display_name text,
    avatar_url text
);


ALTER TABLE public.room_memberships OWNER TO synapse;

--
-- Name: room_retention; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.room_retention (
    room_id text NOT NULL,
    event_id text NOT NULL,
    min_lifetime bigint,
    max_lifetime bigint
);


ALTER TABLE public.room_retention OWNER TO synapse;

--
-- Name: room_stats_current; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.room_stats_current (
    room_id text NOT NULL,
    current_state_events integer NOT NULL,
    joined_members integer NOT NULL,
    invited_members integer NOT NULL,
    left_members integer NOT NULL,
    banned_members integer NOT NULL,
    local_users_in_room integer NOT NULL,
    completed_delta_stream_id bigint NOT NULL,
    knocked_members integer
);


ALTER TABLE public.room_stats_current OWNER TO synapse;

--
-- Name: room_stats_earliest_token; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.room_stats_earliest_token (
    room_id text NOT NULL,
    token bigint NOT NULL
);


ALTER TABLE public.room_stats_earliest_token OWNER TO synapse;

--
-- Name: room_stats_historical; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.room_stats_historical (
    room_id text NOT NULL,
    end_ts bigint NOT NULL,
    bucket_size bigint NOT NULL,
    current_state_events bigint NOT NULL,
    joined_members bigint NOT NULL,
    invited_members bigint NOT NULL,
    left_members bigint NOT NULL,
    banned_members bigint NOT NULL,
    local_users_in_room bigint NOT NULL,
    total_events bigint NOT NULL,
    total_event_bytes bigint NOT NULL,
    knocked_members bigint
);


ALTER TABLE public.room_stats_historical OWNER TO synapse;

--
-- Name: room_stats_state; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.room_stats_state (
    room_id text NOT NULL,
    name text,
    canonical_alias text,
    join_rules text,
    history_visibility text,
    encryption text,
    avatar text,
    guest_access text,
    is_federatable boolean,
    topic text
);


ALTER TABLE public.room_stats_state OWNER TO synapse;

--
-- Name: room_tags; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.room_tags (
    user_id text NOT NULL,
    room_id text NOT NULL,
    tag text NOT NULL,
    content text NOT NULL
);


ALTER TABLE public.room_tags OWNER TO synapse;

--
-- Name: room_tags_revisions; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.room_tags_revisions (
    user_id text NOT NULL,
    room_id text NOT NULL,
    stream_id bigint NOT NULL,
    instance_name text
);


ALTER TABLE public.room_tags_revisions OWNER TO synapse;

--
-- Name: rooms; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.rooms (
    room_id text NOT NULL,
    is_public boolean,
    creator text,
    room_version text,
    has_auth_chain_index boolean
);


ALTER TABLE public.rooms OWNER TO synapse;

--
-- Name: schema_compat_version; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.schema_compat_version (
    lock character(1) DEFAULT 'X'::bpchar NOT NULL,
    compat_version integer NOT NULL,
    CONSTRAINT schema_compat_version_lock_check CHECK ((lock = 'X'::bpchar))
);


ALTER TABLE public.schema_compat_version OWNER TO synapse;

--
-- Name: schema_version; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.schema_version (
    lock character(1) DEFAULT 'X'::bpchar NOT NULL,
    version integer NOT NULL,
    upgraded boolean NOT NULL,
    CONSTRAINT schema_version_lock_check CHECK ((lock = 'X'::bpchar))
);


ALTER TABLE public.schema_version OWNER TO synapse;

--
-- Name: server_keys_json; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.server_keys_json (
    server_name text NOT NULL,
    key_id text NOT NULL,
    from_server text NOT NULL,
    ts_added_ms bigint NOT NULL,
    ts_valid_until_ms bigint NOT NULL,
    key_json bytea NOT NULL
);


ALTER TABLE public.server_keys_json OWNER TO synapse;

--
-- Name: server_signature_keys; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.server_signature_keys (
    server_name text,
    key_id text,
    from_server text,
    ts_added_ms bigint,
    verify_key bytea,
    ts_valid_until_ms bigint
);


ALTER TABLE public.server_signature_keys OWNER TO synapse;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.sessions (
    session_type text NOT NULL,
    session_id text NOT NULL,
    value text NOT NULL,
    expiry_time_ms bigint NOT NULL
);


ALTER TABLE public.sessions OWNER TO synapse;

--
-- Name: state_events; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.state_events (
    event_id text NOT NULL,
    room_id text NOT NULL,
    type text NOT NULL,
    state_key text NOT NULL,
    prev_state text
);


ALTER TABLE public.state_events OWNER TO synapse;

--
-- Name: state_group_edges; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.state_group_edges (
    state_group bigint NOT NULL,
    prev_state_group bigint NOT NULL
);


ALTER TABLE public.state_group_edges OWNER TO synapse;

--
-- Name: state_group_id_seq; Type: SEQUENCE; Schema: public; Owner: synapse
--

CREATE SEQUENCE public.state_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.state_group_id_seq OWNER TO synapse;

--
-- Name: state_groups; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.state_groups (
    id bigint NOT NULL,
    room_id text NOT NULL,
    event_id text NOT NULL
);


ALTER TABLE public.state_groups OWNER TO synapse;

--
-- Name: state_groups_state; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.state_groups_state (
    state_group bigint NOT NULL,
    room_id text NOT NULL,
    type text NOT NULL,
    state_key text NOT NULL,
    event_id text NOT NULL
);
ALTER TABLE ONLY public.state_groups_state ALTER COLUMN state_group SET (n_distinct=-0.02);


ALTER TABLE public.state_groups_state OWNER TO synapse;

--
-- Name: stats_incremental_position; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.stats_incremental_position (
    lock character(1) DEFAULT 'X'::bpchar NOT NULL,
    stream_id bigint NOT NULL,
    CONSTRAINT stats_incremental_position_lock_check CHECK ((lock = 'X'::bpchar))
);


ALTER TABLE public.stats_incremental_position OWNER TO synapse;

--
-- Name: stream_ordering_to_exterm; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.stream_ordering_to_exterm (
    stream_ordering bigint NOT NULL,
    room_id text NOT NULL,
    event_id text NOT NULL
);


ALTER TABLE public.stream_ordering_to_exterm OWNER TO synapse;

--
-- Name: stream_positions; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.stream_positions (
    stream_name text NOT NULL,
    instance_name text NOT NULL,
    stream_id bigint NOT NULL
);


ALTER TABLE public.stream_positions OWNER TO synapse;

--
-- Name: threepid_guest_access_tokens; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.threepid_guest_access_tokens (
    medium text,
    address text,
    guest_access_token text,
    first_inviter text
);


ALTER TABLE public.threepid_guest_access_tokens OWNER TO synapse;

--
-- Name: threepid_validation_session; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.threepid_validation_session (
    session_id text NOT NULL,
    medium text NOT NULL,
    address text NOT NULL,
    client_secret text NOT NULL,
    last_send_attempt bigint NOT NULL,
    validated_at bigint
);


ALTER TABLE public.threepid_validation_session OWNER TO synapse;

--
-- Name: threepid_validation_token; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.threepid_validation_token (
    token text NOT NULL,
    session_id text NOT NULL,
    next_link text,
    expires bigint NOT NULL
);


ALTER TABLE public.threepid_validation_token OWNER TO synapse;

--
-- Name: ui_auth_sessions; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.ui_auth_sessions (
    session_id text NOT NULL,
    creation_time bigint NOT NULL,
    serverdict text NOT NULL,
    clientdict text NOT NULL,
    uri text NOT NULL,
    method text NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.ui_auth_sessions OWNER TO synapse;

--
-- Name: ui_auth_sessions_credentials; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.ui_auth_sessions_credentials (
    session_id text NOT NULL,
    stage_type text NOT NULL,
    result text NOT NULL
);


ALTER TABLE public.ui_auth_sessions_credentials OWNER TO synapse;

--
-- Name: ui_auth_sessions_ips; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.ui_auth_sessions_ips (
    session_id text NOT NULL,
    ip text NOT NULL,
    user_agent text NOT NULL
);


ALTER TABLE public.ui_auth_sessions_ips OWNER TO synapse;

--
-- Name: user_daily_visits; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.user_daily_visits (
    user_id text NOT NULL,
    device_id text,
    "timestamp" bigint NOT NULL,
    user_agent text
);


ALTER TABLE public.user_daily_visits OWNER TO synapse;

--
-- Name: user_directory; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.user_directory (
    user_id text NOT NULL,
    room_id text,
    display_name text,
    avatar_url text
);


ALTER TABLE public.user_directory OWNER TO synapse;

--
-- Name: user_directory_search; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.user_directory_search (
    user_id text NOT NULL,
    vector tsvector
);


ALTER TABLE public.user_directory_search OWNER TO synapse;

--
-- Name: user_directory_stream_pos; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.user_directory_stream_pos (
    lock character(1) DEFAULT 'X'::bpchar NOT NULL,
    stream_id bigint,
    CONSTRAINT user_directory_stream_pos_lock_check CHECK ((lock = 'X'::bpchar))
);


ALTER TABLE public.user_directory_stream_pos OWNER TO synapse;

--
-- Name: user_external_ids; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.user_external_ids (
    auth_provider text NOT NULL,
    external_id text NOT NULL,
    user_id text NOT NULL
);


ALTER TABLE public.user_external_ids OWNER TO synapse;

--
-- Name: user_filters; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.user_filters (
    user_id text NOT NULL,
    filter_id bigint NOT NULL,
    filter_json bytea NOT NULL
);


ALTER TABLE public.user_filters OWNER TO synapse;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: synapse
--

CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO synapse;

--
-- Name: user_ips; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.user_ips (
    user_id text NOT NULL,
    access_token text NOT NULL,
    device_id text,
    ip text NOT NULL,
    user_agent text NOT NULL,
    last_seen bigint NOT NULL
);


ALTER TABLE public.user_ips OWNER TO synapse;

--
-- Name: user_signature_stream; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.user_signature_stream (
    stream_id bigint NOT NULL,
    from_user_id text NOT NULL,
    user_ids text NOT NULL
);


ALTER TABLE public.user_signature_stream OWNER TO synapse;

--
-- Name: user_stats_current; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.user_stats_current (
    user_id text NOT NULL,
    joined_rooms bigint NOT NULL,
    completed_delta_stream_id bigint NOT NULL
);


ALTER TABLE public.user_stats_current OWNER TO synapse;

--
-- Name: user_stats_historical; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.user_stats_historical (
    user_id text NOT NULL,
    end_ts bigint NOT NULL,
    bucket_size bigint NOT NULL,
    joined_rooms bigint NOT NULL,
    invites_sent bigint NOT NULL,
    rooms_created bigint NOT NULL,
    total_events bigint NOT NULL,
    total_event_bytes bigint NOT NULL
);


ALTER TABLE public.user_stats_historical OWNER TO synapse;

--
-- Name: user_threepid_id_server; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.user_threepid_id_server (
    user_id text NOT NULL,
    medium text NOT NULL,
    address text NOT NULL,
    id_server text NOT NULL
);


ALTER TABLE public.user_threepid_id_server OWNER TO synapse;

--
-- Name: user_threepids; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.user_threepids (
    user_id text NOT NULL,
    medium text NOT NULL,
    address text NOT NULL,
    validated_at bigint NOT NULL,
    added_at bigint NOT NULL
);


ALTER TABLE public.user_threepids OWNER TO synapse;

--
-- Name: users; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.users (
    name text,
    password_hash text,
    creation_ts bigint,
    admin smallint DEFAULT 0 NOT NULL,
    upgrade_ts bigint,
    is_guest smallint DEFAULT 0 NOT NULL,
    appservice_id text,
    consent_version text,
    consent_server_notice_sent text,
    user_type text,
    deactivated smallint DEFAULT 0 NOT NULL,
    shadow_banned boolean
);


ALTER TABLE public.users OWNER TO synapse;

--
-- Name: users_in_public_rooms; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.users_in_public_rooms (
    user_id text NOT NULL,
    room_id text NOT NULL
);


ALTER TABLE public.users_in_public_rooms OWNER TO synapse;

--
-- Name: users_pending_deactivation; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.users_pending_deactivation (
    user_id text NOT NULL
);


ALTER TABLE public.users_pending_deactivation OWNER TO synapse;

--
-- Name: users_to_send_full_presence_to; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.users_to_send_full_presence_to (
    user_id text NOT NULL,
    presence_stream_id bigint
);


ALTER TABLE public.users_to_send_full_presence_to OWNER TO synapse;

--
-- Name: users_who_share_private_rooms; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.users_who_share_private_rooms (
    user_id text NOT NULL,
    other_user_id text NOT NULL,
    room_id text NOT NULL
);


ALTER TABLE public.users_who_share_private_rooms OWNER TO synapse;

--
-- Name: worker_locks; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.worker_locks (
    lock_name text NOT NULL,
    lock_key text NOT NULL,
    instance_name text NOT NULL,
    token text NOT NULL,
    last_renewed_ts bigint NOT NULL
);


ALTER TABLE public.worker_locks OWNER TO synapse;

--
-- Name: instance_map instance_id; Type: DEFAULT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.instance_map ALTER COLUMN instance_id SET DEFAULT nextval('public.instance_map_instance_id_seq'::regclass);


--
-- Data for Name: access_tokens; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.access_tokens (id, user_id, device_id, token, valid_until_ms, puppets_user_id, last_validated, refresh_token_id, used) FROM stdin;
4	@matrix_b:localhost	DJFHSWMXLW	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjZjaWQgdXNlcl9pZCA9IEBtYXRyaXhfYjpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSBBYl9hbWthI0daSzgtfjdICjAwMmZzaWduYXR1cmUgOReBLkPURCMNtzORS9fpogQqVa3IWN9ZEu5gXW91QTMK	\N	\N	\N	\N	\N
5	@ignored_user:localhost	IYEBBQEXHS	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMmFjaWQgdXNlcl9pZCA9IEBpZ25vcmVkX3VzZXI6bG9jYWxob3N0CjAwMTZjaWQgdHlwZSA9IGFjY2VzcwowMDIxY2lkIG5vbmNlID0gZU5ta1BBMj1FNnVPRGtwdgowMDJmc2lnbmF0dXJlIHSt8jrFU836Ne3it2HY88EhPD1Aoustsm211bbFjcLcCg	\N	\N	\N	\N	\N
6	@matterbot:localhost	TGXAZUDNDK	syt_bWF0dGVyYm90_rDERImvoCrdCKLyMUWTi_2iYFRf	\N	\N	1672393388018	\N	f
7	@mm_mattermost_b:localhost	ACNRXLMSJA	syt_bW1fbWF0dGVybW9zdF9i_UCEtYLmnavWPmLiYslnh_0M2Tl3	\N	\N	1672393389752	\N	f
8	@mm_mattermost_a:localhost	RKCHLAOGMQ	syt_bW1fbWF0dGVybW9zdF9h_QMxPfDCfpDEMrxnIarah_2oYq79	\N	\N	1672393389919	\N	f
9	@bridgeuser1:localhost	INZTQIFTZU	syt_YnJpZGdldXNlcjE_aCEphjNZCKCjmXrOUEsx_07D0Nq	\N	\N	1672416114198	\N	f
10	@bridgeuser2:localhost	XNALAXQCPK	syt_YnJpZGdldXNlcjI_ZEXYLRFEPipcjiRgIaPs_0sZqZS	\N	\N	1672416140899	\N	f
12	@mm_mattermost_a_:localhost	SNDZBSJQWR	syt_bW1fbWF0dGVybW9zdF9hXw_tgbHhKKUEaCPowXGGMOs_1rY8Y6	\N	\N	1672416526528	\N	f
13	@mm_mattermost_b_:localhost	ECAJIABDCN	syt_bW1fbWF0dGVybW9zdF9iXw_MJVZJENeFNWoyFFwNurG_1Ade91	\N	\N	1672416526686	\N	f
14	@mm_matrix_matrix_a:localhost	COHLAPFKHD	syt_bW1fbWF0cml4X21hdHJpeF9h_YmwKOcOoGZEDHsrWFsHY_045n7z	\N	\N	1672416526851	\N	f
15	@mm_matrix_matrix_b:localhost	NNNEXFYSII	syt_bW1fbWF0cml4X21hdHJpeF9i_ENLVGrhEUAMwbZkfEeUg_1Ur5Xe	\N	\N	1672416527103	\N	f
11	@bridgeadmin:localhost	IFSVAIKQOJ	syt_YnJpZGdlYWRtaW4_MpYSPFUOTVBiLRuKcWSg_2gXdf2	\N	\N	1672416163950	\N	t
\.


--
-- Data for Name: account_data; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.account_data (user_id, account_data_type, stream_id, content, instance_name) FROM stdin;
@bridgeuser1:localhost	org.matrix.msc3890.local_notification_settings.PIMRNBVGGO	2	{"is_silenced":false}	\N
@bridgeuser1:localhost	im.vector.analytics	4	{"pseudonymousAnalyticsOptIn":false}	\N
@bridgeuser1:localhost	im.vector.web.settings	11	{"Spaces.allRoomsInHome":false}	\N
@bridgeuser1:localhost	im.vector.setting.breadcrumbs	14	{"recent_rooms":["!UKcoTBWWxNEyixrjyM:localhost","local+m1672417504515.6","!MrxfbdodytWwBMqNiF:localhost"]}	\N
@bridgeadmin:localhost	org.matrix.msc3890.local_notification_settings.XGKLFWVQVO	18	{"is_silenced":false}	\N
@bridgeadmin:localhost	org.matrix.msc3890.local_notification_settings.TZENIQYSDC	24	{"is_silenced":false}	\N
@bridgeadmin:localhost	im.vector.analytics	30	{"id":"7654e3648715cbf422e1a733e43aa0","pseudonymousAnalyticsOptIn":true}	\N
@bridgeadmin:localhost	m.direct	40	{"@admin:localhost":["!LwtGEdNVvQHvFLuWQB:localhost","!GNlLBsLXjbOuNhCkEO:localhost"]}	\N
@bridgeadmin:localhost	im.vector.setting.breadcrumbs	42	{"recent_rooms":["!GNlLBsLXjbOuNhCkEO:localhost","!cwnFZrIkYIOvkCHJkc:localhost","!kAToIwhNWrDpgQVMfY:localhost"]}	\N
@admin:localhost	org.matrix.msc3890.local_notification_settings.JOEAGREGVO	46	{"is_silenced":false}	\N
@admin:localhost	im.vector.analytics	47	{"pseudonymousAnalyticsOptIn":false}	\N
@bridgeuser1:localhost	m.direct	54	{"@admin:localhost":["!MrxfbdodytWwBMqNiF:localhost","!nPrdOOfNMRrmJedabn:localhost"],"@matrix_a:localhost":["!UKcoTBWWxNEyixrjyM:localhost"]}	\N
@admin:localhost	org.matrix.msc3890.local_notification_settings.KFURKEDWNO	60	{"is_silenced":false}	\N
@admin:localhost	org.matrix.msc3890.local_notification_settings.XEZPTSZEHL	69	{"is_silenced":false}	\N
@admin:localhost	m.direct	73	{"@bridgeuser1:localhost":["!MrxfbdodytWwBMqNiF:localhost","!nPrdOOfNMRrmJedabn:localhost"],"@bridgeadmin:localhost":["!LwtGEdNVvQHvFLuWQB:localhost"]}	\N
@admin:localhost	im.vector.setting.breadcrumbs	75	{"recent_rooms":["!GNlLBsLXjbOuNhCkEO:localhost","!dKcbdDATuwwphjRPQP:localhost","!kmbTYjjsDRDHGgVqUP:localhost","!nPrdOOfNMRrmJedabn:localhost"]}	\N
@matrix_a:localhost	org.matrix.msc3890.local_notification_settings.JHXXJJAPZQ	78	{"is_silenced":false}	\N
@matrix_a:localhost	im.vector.analytics	79	{"pseudonymousAnalyticsOptIn":false}	\N
@matrix_a:localhost	m.direct	89	{"@bridgeuser1:localhost":["!UKcoTBWWxNEyixrjyM:localhost"]}	\N
@matrix_a:localhost	im.vector.setting.breadcrumbs	97	{"recent_rooms":["!UKcoTBWWxNEyixrjyM:localhost","!kmbTYjjsDRDHGgVqUP:localhost","!dKcbdDATuwwphjRPQP:localhost","!kAToIwhNWrDpgQVMfY:localhost"]}	\N
\.


--
-- Data for Name: account_validity; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.account_validity (user_id, expiration_ts_ms, email_sent, renewal_token, token_used_ts_ms) FROM stdin;
\.


--
-- Data for Name: application_services_state; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.application_services_state (as_id, state, last_txn, read_receipt_stream_id, presence_stream_id) FROM stdin;
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	down	\N	\N	\N
\.


--
-- Data for Name: application_services_txns; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.application_services_txns (as_id, txn_id, event_ids) FROM stdin;
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	1	["$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	2	["$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	3	["$7TwPfUMTevEcf7wLvbgx3LG01lYT_yGudYiOVlkGU7E"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	4	["$jAifmicJfMyB1QPFQ6KFQ7ZqTqQ58RJXsH5viWn3ZUg"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	5	["$DsZXxk2rEIB2tF3pYUdOPjrMwclo8BXltutiWCnKUIU"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	6	["$NyVGoA-ZaMPbk_RzpmLOajRS1nEBirO7Du2KpA9Eo64"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	7	["$JwL8EK5sa4vg29tclnHwa5jrpCTa8oZVOIsgFyivQdY"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	8	["$JcoTJcBGASUqIK9V7j6ND5Jt6P9gdbNJxXxQBZNg8z4"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	9	["$2KnXfE3sZw8LDrOAaEP4HdQuw5neshhvyZKtnwo5cg0"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	10	["$isXWKf_B_7Z7R7jYn_2gZB-U31TuzMehBRxj5701Lq8"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	11	["$rVK77mVSpz5EHxI2mbLxilqbkLxKhXEiusPFjapVPbw"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	12	["$5agO4kI6VqJHGKvKbkqUa2Y3cTwUBrjAhmCVtj9JmKU"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	13	["$4JiNeQHyMbyuEfymLkE-SEzPUh3bWddjxa6-5w36nJw"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	14	["$Y_S-fF0iLu0OHNMcZdYVzt0we_qL_t8_4QIKGeobLdI"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	15	["$g1kV-jEZBtN9l6VGGo2MN-wQn7RR7J-Tv5LfyJ5Z5fc"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	16	["$CQg_jKvdpWFvaiLH2f5MtTnu1Zwxi8P4QPSJZum91dw"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	17	["$OcvCF7YNeTKFnzz4EWVjFJIF9QidMEUmomHIvH3d2W8"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	18	["$GrqoJ52XSgRaoc4wPEYLdL2p6t3jl0aiFd8bYswQQcU"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	19	["$5TE1hAtSTolrY9QTj9Wt8DnKurFa3P6KIfGkWOJbrY4"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	20	["$UYXKiTPqFr31PwoZzi35ODpdRK0hwJVjVGC1N7kR7yk"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	21	["$YFCWkh6b_jgrSjje7vt6JB6-uLPRz7Na1VgGh0PwdI8"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	22	["$h2yGPxzdKWUBUSFQiOgFiRoNa8NgWHYXdy_2SMJx6ns"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	23	["$kmvnPONhcKxIpG62sV6apngYToshpP0mBrwpKL0hAOI"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	24	["$KgpvpFIMQIVFvm0adBZqAbWANmMgdu1_1jbP71RuM48"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	25	["$qWi32T1tK2APgSwc4y_6f0e_N_fUPmIBxC5ACk1h6NM"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	26	["$jvwVmkElpx8M62JlaBz7nJ4qa2U8tVO7V9-HhJ-n8JI"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	27	["$0WsTO-QKZzqtMdl5UwGJc5h4e7YAE5ZGp_GDMb9K824"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	28	["$opS4sT6APXaq4vDdegPq6ik1z-yX-FkMTAqhGtTWXEE"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	29	["$l5dYt-R2kpcKdlmMRFnzC5N9PjiV4DZ63c1bTGPOCXk"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	30	["$NxuVtjeVql0_aadDlNux0yeeR_PxcpcJPnX1SdoDmXM"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	31	["$O04OV5x9R_5W2IT9G9Z-dXJmfV6fgtZM8-4ogFp9rEw"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	32	["$-QMfwsu75_SWJtzFqIsrFjLgl_XBqF6HcorcUjLTsWY"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	33	["$Wj4b7gcXdhL474sxg5O6Kh7tBw4O5BtHv_KJEd3KXfM"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	34	["$ZYEqhm3M07nXRAh1U842uZ1squBm9wa5H1Wb2-LjE1c"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	35	["$p0-tc7QWKDmREIJlluolf1RQ-uKnVDhx5d_JQY9PX5E"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	36	["$GmUIImAeTzvNSV5qvb40ScXGL3dlsX4DDnmg28rkzk4"]
\.


--
-- Data for Name: applied_module_schemas; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.applied_module_schemas (module_name, file) FROM stdin;
\.


--
-- Data for Name: applied_schema_deltas; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.applied_schema_deltas (version, file) FROM stdin;
55	55/access_token_expiry.sql
55	55/track_threepid_validations.sql
55	55/users_alter_deactivated.sql
56	56/add_spans_to_device_lists.sql
56	56/current_state_events_membership.sql
56	56/current_state_events_membership_mk2.sql
56	56/delete_keys_from_deleted_backups.sql
56	56/destinations_failure_ts.sql
56	56/destinations_retry_interval_type.sql.postgres
56	56/device_stream_id_insert.sql
56	56/devices_last_seen.sql
56	56/drop_unused_event_tables.sql
56	56/event_expiry.sql
56	56/event_labels.sql
56	56/event_labels_background_update.sql
56	56/fix_room_keys_index.sql
56	56/hidden_devices.sql
56	56/nuke_empty_communities_from_db.sql
56	56/public_room_list_idx.sql
56	56/redaction_censor.sql
56	56/redaction_censor2.sql
56	56/redaction_censor3_fix_update.sql.postgres
56	56/redaction_censor4.sql
56	56/remove_tombstoned_rooms_from_directory.sql
56	56/room_key_etag.sql
56	56/room_membership_idx.sql
56	56/room_retention.sql
56	56/signing_keys.sql
56	56/signing_keys_nonunique_signatures.sql
56	56/state_group_room_idx.sql
56	56/stats_separated.sql
56	56/unique_user_filter_index.py
56	56/user_external_ids.sql
56	56/users_in_public_rooms_idx.sql
57	57/delete_old_current_state_events.sql
57	57/device_list_remote_cache_stale.sql
57	57/local_current_membership.py
57	57/remove_sent_outbound_pokes.sql
57	57/rooms_version_column.sql
57	57/rooms_version_column_2.sql.postgres
57	57/rooms_version_column_3.sql.postgres
58	58/00background_update_ordering.sql
58	58/02remove_dup_outbound_pokes.sql
58	58/03persist_ui_auth.sql
58	58/05cache_instance.sql.postgres
58	58/06dlols_unique_idx.py
58	58/07add_method_to_thumbnail_constraint.sql.postgres
58	58/07persist_ui_auth_ips.sql
58	58/08_media_safe_from_quarantine.sql.postgres
58	58/09shadow_ban.sql
58	58/10_pushrules_enabled_delete_obsolete.sql
58	58/10drop_local_rejections_stream.sql
58	58/10federation_pos_instance_name.sql
58	58/11dehydration.sql
58	58/11fallback.sql
58	58/11user_id_seq.py
58	58/12room_stats.sql
58	58/13remove_presence_allow_inbound.sql
58	58/14events_instance_name.sql
58	58/14events_instance_name.sql.postgres
58	58/15_catchup_destination_rooms.sql
58	58/15unread_count.sql
58	58/16populate_stats_process_rooms_fix.sql
58	58/17_catchup_last_successful.sql
58	58/18stream_positions.sql
58	58/19instance_map.sql.postgres
58	58/19txn_id.sql
58	58/20instance_name_event_tables.sql
58	58/20user_daily_visits.sql
58	58/21as_device_stream.sql
58	58/21drop_device_max_stream_id.sql
58	58/22puppet_token.sql
58	58/22users_have_local_media.sql
58	58/23e2e_cross_signing_keys_idx.sql
58	58/24drop_event_json_index.sql
58	58/25user_external_ids_user_id_idx.sql
58	58/26access_token_last_validated.sql
58	58/27local_invites.sql
58	58/28drop_last_used_column.sql.postgres
59	59/01ignored_user.py
59	59/02shard_send_to_device.sql
59	59/03shard_send_to_device_sequence.sql.postgres
59	59/04_event_auth_chains.sql
59	59/04_event_auth_chains.sql.postgres
59	59/04drop_account_data.sql
59	59/05cache_invalidation.sql
59	59/06chain_cover_index.sql
59	59/06shard_account_data.sql
59	59/06shard_account_data.sql.postgres
59	59/07shard_account_data_fix.sql
59	59/08delete_pushers_for_deactivated_accounts.sql
59	59/08delete_stale_pushers.sql
59	59/09rejected_events_metadata.sql
59	59/10delete_purged_chain_cover.sql
59	59/11add_knock_members_to_stats.sql
59	59/11drop_thumbnail_constraint.sql.postgres
59	59/12account_validity_token_used_ts_ms.sql
59	59/12presence_stream_instance.sql
59	59/12presence_stream_instance_seq.sql.postgres
59	59/13users_to_send_full_presence_to.sql
59	59/14refresh_tokens.sql
59	59/15locks.sql
59	59/16federation_inbound_staging.sql
60	60/01recreate_stream_ordering.sql.postgres
60	60/02change_stream_ordering_columns.sql.postgres
61	61/01change_appservices_txns.sql.postgres
61	61/01insertion_event_lookups.sql
61	61/02drop_redundant_room_depth_index.sql
61	61/02state_groups_state_n_distinct.sql.postgres
61	61/03recreate_min_depth.py
62	62/01insertion_event_extremities.sql
63	63/01create_registration_tokens.sql
63	63/02delete_unlinked_email_pushers.sql
63	63/02populate-rooms-creator.sql
63	63/03session_store.sql
63	63/04add_presence_stream_not_offline_index.sql
64	64/01msc2716_chunk_to_batch_rename.sql.postgres
65	65/01msc2716_insertion_event_edges.sql
65	65/02_thread_relations.sql
65	65/03remove_hidden_devices_from_device_inbox.sql
65	65/04_local_group_updates.sql
65	65/06remove_deleted_devices_from_device_inbox.sql
\.


--
-- Data for Name: appservice_room_list; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.appservice_room_list (appservice_id, network_id, room_id) FROM stdin;
\.


--
-- Data for Name: appservice_stream_position; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.appservice_stream_position (lock, stream_ordering) FROM stdin;
X	139
\.


--
-- Data for Name: background_updates; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.background_updates (update_name, progress_json, depends_on, ordering) FROM stdin;
\.


--
-- Data for Name: batch_events; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.batch_events (event_id, room_id, batch_id) FROM stdin;
\.


--
-- Data for Name: blocked_rooms; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.blocked_rooms (room_id, user_id) FROM stdin;
\.


--
-- Data for Name: cache_invalidation_stream_by_instance; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.cache_invalidation_stream_by_instance (stream_id, instance_name, cache_func, keys, invalidation_ts) FROM stdin;
1	master	user_last_seen_monthly_active	\N	1598686299114
2	master	get_monthly_active_count	{}	1598686299118
3	master	get_user_by_id	{@admin:localhost}	1598686326905
4	master	get_user_by_id	{@matrix_a:localhost}	1598686327226
5	master	get_user_by_id	{@matrix_b:localhost}	1598686327473
6	master	get_user_by_id	{@ignored_user:localhost}	1598686327717
7	master	get_aliases_for_room	{!kmbTYjjsDRDHGgVqUP:localhost}	1598686327750
8	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost}	1598686327775
9	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@admin:localhost}	1598686327828
10	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost}	1598686327865
11	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost}	1598686328014
12	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost}	1598686328094
13	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost}	1598686328165
14	master	get_aliases_for_room	{!dKcbdDATuwwphjRPQP:localhost}	1598686328206
15	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost}	1598686328225
16	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@admin:localhost}	1598686328264
17	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost}	1598686328293
18	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost}	1598686328324
19	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost}	1598686328352
20	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost}	1598686328382
21	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@matrix_a:localhost}	1598686328424
22	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@matrix_a:localhost}	1598686328465
23	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@matrix_b:localhost}	1598686328510
24	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@matrix_b:localhost}	1598686328549
25	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@ignored_user:localhost}	1598686328591
26	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@ignored_user:localhost}	1598686328631
27	master	user_last_seen_monthly_active	\N	1672393259337
28	master	get_monthly_active_count	{}	1672393259341
29	master	get_user_by_id	{@matterbot:localhost}	1672393387996
30	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@matterbot:localhost}	1672393388523
31	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@matterbot:localhost}	1672393388799
32	master	get_user_by_id	{@mm_mattermost_b:localhost}	1672393389729
33	master	get_user_by_id	{@mm_mattermost_a:localhost}	1672393389886
34	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_b:localhost}	1672393390095
35	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_b:localhost}	1672393390287
36	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_a:localhost}	1672393390289
37	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_a:localhost}	1672393390466
38	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_b:localhost}	1672393390498
39	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_b:localhost}	1672393390660
40	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_a:localhost}	1672393390721
41	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_a:localhost}	1672393390831
42	master	user_last_seen_monthly_active	\N	1672393553133
43	master	get_monthly_active_count	{}	1672393553140
44	master	user_last_seen_monthly_active	\N	1672401608835
45	master	get_monthly_active_count	{}	1672401608970
46	master	user_last_seen_monthly_active	\N	1672408839150
47	master	get_monthly_active_count	{}	1672408839167
48	master	user_last_seen_monthly_active	\N	1672413058254
49	master	get_monthly_active_count	{}	1672413058256
50	master	user_last_seen_monthly_active	\N	1672413621969
51	master	get_monthly_active_count	{}	1672413621974
52	master	user_last_seen_monthly_active	\N	1672414573463
53	master	get_monthly_active_count	{}	1672414573466
54	master	user_last_seen_monthly_active	\N	1672415284423
55	master	get_monthly_active_count	{}	1672415284425
56	master	get_user_by_id	{@bridgeuser1:localhost}	1672416114166
57	master	get_user_by_id	{@bridgeuser2:localhost}	1672416140870
58	master	get_user_by_id	{@bridgeadmin:localhost}	1672416163925
59	master	user_last_seen_monthly_active	\N	1672416364943
60	master	get_monthly_active_count	{}	1672416364946
61	master	get_user_by_id	{@mm_mattermost_a_:localhost}	1672416526507
62	master	get_user_by_id	{@mm_mattermost_b_:localhost}	1672416526656
63	master	get_user_by_id	{@mm_matrix_matrix_a:localhost}	1672416526818
64	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_a_:localhost}	1672416526939
65	master	get_user_by_id	{@mm_matrix_matrix_b:localhost}	1672416526962
66	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_b_:localhost}	1672416527371
67	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_matrix_matrix_b:localhost}	1672416527531
68	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_matrix_matrix_a:localhost}	1672416527629
69	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_matrix_matrix_a:localhost}	1672416527790
70	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_a_:localhost}	1672416527908
71	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_b_:localhost}	1672416528021
77	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_matrix_matrix_a:localhost}	1672416528691
78	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_matrix_matrix_b:localhost}	1672416528835
79	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_b_:localhost}	1672416528888
82	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_b:localhost}	1672416529303
84	master	get_device_list_last_stream_id_for_remote	{@mm_mattermost_b:localhost}	1672416529346
85	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_a:localhost}	1672416529441
86	master	get_device_list_last_stream_id_for_remote	{@mm_mattermost_a:localhost}	1672416529501
88	master	get_e2e_unused_fallback_key_types	{@bridgeuser1:localhost,PIMRNBVGGO}	1672417282156
98	master	_get_bare_e2e_cross_signing_keys	{@bridgeuser1:localhost}	1672417282593
102	master	_get_bare_e2e_cross_signing_keys	{@bridgeuser1:localhost}	1672417286955
106	master	_get_bare_e2e_cross_signing_keys	{@bridgeuser1:localhost}	1672417293180
108	master	_get_bare_e2e_cross_signing_keys	{@bridgeuser1:localhost}	1672417297650
111	master	cs_cache_fake	{!MrxfbdodytWwBMqNiF:localhost}	1672417353550
113	master	cs_cache_fake	{!MrxfbdodytWwBMqNiF:localhost}	1672417353812
72	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_matrix_matrix_b:localhost}	1672416528134
73	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_a_:localhost}	1672416528251
81	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_a_:localhost}	1672416529108
83	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_a:localhost}	1672416529315
87	master	count_e2e_one_time_keys	{@bridgeuser1:localhost,PIMRNBVGGO}	1672417282129
92	master	count_e2e_one_time_keys	{@bridgeuser1:localhost,PIMRNBVGGO}	1672417282383
93	master	count_e2e_one_time_keys	{@bridgeuser1:localhost,PIMRNBVGGO}	1672417282446
94	master	count_e2e_one_time_keys	{@bridgeuser1:localhost,PIMRNBVGGO}	1672417282515
96	master	_get_bare_e2e_cross_signing_keys	{@bridgeuser1:localhost}	1672417282585
116	master	cs_cache_fake	{!MrxfbdodytWwBMqNiF:localhost}	1672417354246
74	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_b_:localhost}	1672416528358
75	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_matrix_matrix_b:localhost}	1672416528503
76	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_matrix_matrix_a:localhost}	1672416528614
80	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_b:localhost}	1672416529072
89	master	count_e2e_one_time_keys	{@bridgeuser1:localhost,PIMRNBVGGO}	1672417282246
90	master	get_e2e_unused_fallback_key_types	{@bridgeuser1:localhost,PIMRNBVGGO}	1672417282253
91	master	count_e2e_one_time_keys	{@bridgeuser1:localhost,PIMRNBVGGO}	1672417282315
95	master	_get_bare_e2e_cross_signing_keys	{@bridgeuser1:localhost}	1672417282559
97	master	count_e2e_one_time_keys	{@bridgeuser1:localhost,PIMRNBVGGO}	1672417282590
99	master	count_e2e_one_time_keys	{@bridgeuser1:localhost,PIMRNBVGGO}	1672417282710
100	master	count_e2e_one_time_keys	{@bridgeuser1:localhost,PIMRNBVGGO}	1672417282803
101	master	count_e2e_one_time_keys	{@bridgeuser1:localhost,PIMRNBVGGO}	1672417282898
103	master	_get_bare_e2e_cross_signing_keys	{@bridgeuser1:localhost}	1672417286962
104	master	_get_bare_e2e_cross_signing_keys	{@bridgeuser1:localhost}	1672417286967
105	master	_get_bare_e2e_cross_signing_keys	{@bridgeuser1:localhost}	1672417293173
107	master	_get_bare_e2e_cross_signing_keys	{@bridgeuser1:localhost}	1672417293185
109	master	_get_bare_e2e_cross_signing_keys	{@bridgeuser1:localhost}	1672417297655
110	master	_get_bare_e2e_cross_signing_keys	{@bridgeuser1:localhost}	1672417297661
112	master	cs_cache_fake	{!MrxfbdodytWwBMqNiF:localhost,@bridgeuser1:localhost}	1672417353655
114	master	cs_cache_fake	{!MrxfbdodytWwBMqNiF:localhost}	1672417354018
115	master	cs_cache_fake	{!MrxfbdodytWwBMqNiF:localhost}	1672417354128
117	master	cs_cache_fake	{!MrxfbdodytWwBMqNiF:localhost,@admin:localhost}	1672417354382
118	master	cs_cache_fake	{!UKcoTBWWxNEyixrjyM:localhost}	1672417514409
119	master	cs_cache_fake	{!UKcoTBWWxNEyixrjyM:localhost,@bridgeuser1:localhost}	1672417514534
120	master	cs_cache_fake	{!UKcoTBWWxNEyixrjyM:localhost}	1672417514751
121	master	cs_cache_fake	{!UKcoTBWWxNEyixrjyM:localhost}	1672417514917
122	master	cs_cache_fake	{!UKcoTBWWxNEyixrjyM:localhost}	1672417515037
123	master	cs_cache_fake	{!UKcoTBWWxNEyixrjyM:localhost}	1672417515306
124	master	cs_cache_fake	{!UKcoTBWWxNEyixrjyM:localhost,@matrix_a:localhost}	1672417515463
125	master	get_user_by_access_token	{syt_YnJpZGdldXNlcjE_cMzgedqFaVOMSJBmfZfe_3maH1A}	1672417616163
126	master	count_e2e_one_time_keys	{@bridgeuser1:localhost,PIMRNBVGGO}	1672417616178
127	master	get_e2e_unused_fallback_key_types	{@bridgeuser1:localhost,PIMRNBVGGO}	1672417616183
128	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,XGKLFWVQVO}	1672417641475
129	master	get_e2e_unused_fallback_key_types	{@bridgeadmin:localhost,XGKLFWVQVO}	1672417641491
130	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,XGKLFWVQVO}	1672417641562
131	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,XGKLFWVQVO}	1672417641627
132	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,XGKLFWVQVO}	1672417641693
133	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,XGKLFWVQVO}	1672417641770
134	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,XGKLFWVQVO}	1672417641842
136	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,XGKLFWVQVO}	1672417641909
135	master	_get_bare_e2e_cross_signing_keys	{@bridgeadmin:localhost}	1672417641909
137	master	_get_bare_e2e_cross_signing_keys	{@bridgeadmin:localhost}	1672417641919
138	master	_get_bare_e2e_cross_signing_keys	{@bridgeadmin:localhost}	1672417641928
139	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,XGKLFWVQVO}	1672417642025
140	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,XGKLFWVQVO}	1672417642135
141	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,XGKLFWVQVO}	1672417642228
142	master	get_aliases_for_room	{!kAToIwhNWrDpgQVMfY:localhost}	1672417768848
143	master	cs_cache_fake	{!kAToIwhNWrDpgQVMfY:localhost}	1672417768915
144	master	cs_cache_fake	{!kAToIwhNWrDpgQVMfY:localhost,@bridgeadmin:localhost}	1672417769074
145	master	cs_cache_fake	{!kAToIwhNWrDpgQVMfY:localhost}	1672417769240
146	master	cs_cache_fake	{!kAToIwhNWrDpgQVMfY:localhost}	1672417769419
147	master	cs_cache_fake	{!kAToIwhNWrDpgQVMfY:localhost}	1672417769542
148	master	cs_cache_fake	{!kAToIwhNWrDpgQVMfY:localhost}	1672417769651
149	master	cs_cache_fake	{!kAToIwhNWrDpgQVMfY:localhost}	1672417769752
150	master	cs_cache_fake	{!kAToIwhNWrDpgQVMfY:localhost}	1672417769871
151	master	cs_cache_fake	{!kAToIwhNWrDpgQVMfY:localhost}	1672417769967
152	master	cs_cache_fake	{!cwnFZrIkYIOvkCHJkc:localhost}	1672417775553
153	master	cs_cache_fake	{!ffaaxOMHcWnINEXTWK:localhost}	1672417775554
154	master	cs_cache_fake	{!ffaaxOMHcWnINEXTWK:localhost,@bridgeadmin:localhost}	1672417775740
167	master	cs_cache_fake	{!cwnFZrIkYIOvkCHJkc:localhost}	1672417777321
171	master	cs_cache_fake	{!kAToIwhNWrDpgQVMfY:localhost,@matrix_b:localhost}	1672417798367
173	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,XGKLFWVQVO}	1672418168071
174	master	get_e2e_unused_fallback_key_types	{@bridgeadmin:localhost,XGKLFWVQVO}	1672418168074
155	master	cs_cache_fake	{!cwnFZrIkYIOvkCHJkc:localhost,@bridgeadmin:localhost}	1672417775772
169	master	cs_cache_fake	{!kAToIwhNWrDpgQVMfY:localhost}	1672417777730
172	master	get_user_by_access_token	{syt_YnJpZGdlYWRtaW4_ErFyglzXQNIHuWssiTTm_2y3mmu}	1672418168045
156	master	cs_cache_fake	{!ffaaxOMHcWnINEXTWK:localhost}	1672417775973
157	master	cs_cache_fake	{!cwnFZrIkYIOvkCHJkc:localhost}	1672417776080
159	master	cs_cache_fake	{!ffaaxOMHcWnINEXTWK:localhost}	1672417776296
168	master	cs_cache_fake	{!kAToIwhNWrDpgQVMfY:localhost}	1672417777558
177	master	user_last_seen_monthly_active	\N	1672432631773
178	master	get_monthly_active_count	{}	1672432631786
158	master	cs_cache_fake	{!cwnFZrIkYIOvkCHJkc:localhost}	1672417776297
164	master	cs_cache_fake	{!ffaaxOMHcWnINEXTWK:localhost}	1672417776996
179	master	user_last_seen_monthly_active	\N	1672439837697
180	master	get_monthly_active_count	{}	1672439837713
160	master	cs_cache_fake	{!ffaaxOMHcWnINEXTWK:localhost}	1672417776553
163	master	cs_cache_fake	{!cwnFZrIkYIOvkCHJkc:localhost}	1672417776748
161	master	cs_cache_fake	{!cwnFZrIkYIOvkCHJkc:localhost}	1672417776561
165	master	cs_cache_fake	{!cwnFZrIkYIOvkCHJkc:localhost}	1672417777030
175	master	user_last_seen_monthly_active	\N	1672425401655
176	master	get_monthly_active_count	{}	1672425401712
162	master	cs_cache_fake	{!ffaaxOMHcWnINEXTWK:localhost}	1672417776747
166	master	cs_cache_fake	{!ffaaxOMHcWnINEXTWK:localhost}	1672417777229
170	master	cs_cache_fake	{!kAToIwhNWrDpgQVMfY:localhost,@matrix_a:localhost}	1672417798185
181	master	user_last_seen_monthly_active	\N	1672447069334
182	master	get_monthly_active_count	{}	1672447069470
183	master	user_last_seen_monthly_active	\N	1672454300548
184	master	get_monthly_active_count	{}	1672454300581
185	master	user_last_seen_monthly_active	\N	1672461506436
186	master	get_monthly_active_count	{}	1672461506663
187	master	user_last_seen_monthly_active	\N	1672468736393
188	master	get_monthly_active_count	{}	1672468736466
189	master	user_last_seen_monthly_active	\N	1672475968516
190	master	get_monthly_active_count	{}	1672475968532
191	master	user_last_seen_monthly_active	\N	1672477840911
192	master	get_monthly_active_count	{}	1672477840955
193	master	user_last_seen_monthly_active	\N	1672479041129
194	master	get_monthly_active_count	{}	1672479041137
195	master	user_last_seen_monthly_active	\N	1672479944579
196	master	get_monthly_active_count	{}	1672479944583
197	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,TZENIQYSDC}	1672480049370
198	master	get_e2e_unused_fallback_key_types	{@bridgeadmin:localhost,TZENIQYSDC}	1672480049380
199	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,TZENIQYSDC}	1672480049453
200	master	get_e2e_unused_fallback_key_types	{@bridgeadmin:localhost,TZENIQYSDC}	1672480049461
201	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,TZENIQYSDC}	1672480049519
202	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,TZENIQYSDC}	1672480049574
203	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,TZENIQYSDC}	1672480049630
204	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,TZENIQYSDC}	1672480049688
205	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,TZENIQYSDC}	1672480049749
206	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,TZENIQYSDC}	1672480049807
207	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,TZENIQYSDC}	1672480049876
208	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,TZENIQYSDC}	1672480049929
209	master	cs_cache_fake	{!LwtGEdNVvQHvFLuWQB:localhost}	1672480138598
210	master	cs_cache_fake	{!LwtGEdNVvQHvFLuWQB:localhost,@bridgeadmin:localhost}	1672480138863
211	master	cs_cache_fake	{!LwtGEdNVvQHvFLuWQB:localhost}	1672480139145
212	master	cs_cache_fake	{!LwtGEdNVvQHvFLuWQB:localhost}	1672480139324
213	master	cs_cache_fake	{!LwtGEdNVvQHvFLuWQB:localhost}	1672480139485
214	master	cs_cache_fake	{!LwtGEdNVvQHvFLuWQB:localhost}	1672480139624
215	master	cs_cache_fake	{!LwtGEdNVvQHvFLuWQB:localhost,@admin:localhost}	1672480139790
216	master	cs_cache_fake	{!LwtGEdNVvQHvFLuWQB:localhost}	1672480178228
217	master	cs_cache_fake	{!GNlLBsLXjbOuNhCkEO:localhost}	1672480208370
218	master	cs_cache_fake	{!GNlLBsLXjbOuNhCkEO:localhost,@bridgeadmin:localhost}	1672480208483
219	master	cs_cache_fake	{!GNlLBsLXjbOuNhCkEO:localhost}	1672480208752
220	master	cs_cache_fake	{!GNlLBsLXjbOuNhCkEO:localhost}	1672480209013
221	master	cs_cache_fake	{!GNlLBsLXjbOuNhCkEO:localhost}	1672480209145
222	master	cs_cache_fake	{!GNlLBsLXjbOuNhCkEO:localhost}	1672480209275
223	master	cs_cache_fake	{!GNlLBsLXjbOuNhCkEO:localhost}	1672480209445
224	master	cs_cache_fake	{!LwtGEdNVvQHvFLuWQB:localhost}	1672480209535
225	master	get_aliases_for_room	{!LwtGEdNVvQHvFLuWQB:localhost}	1672480209550
226	master	get_aliases_for_room	{!GNlLBsLXjbOuNhCkEO:localhost}	1672480209557
227	master	get_aliases_for_room	{!LwtGEdNVvQHvFLuWQB:localhost}	1672480209640
228	master	get_aliases_for_room	{!GNlLBsLXjbOuNhCkEO:localhost}	1672480209648
229	master	cs_cache_fake	{!LwtGEdNVvQHvFLuWQB:localhost}	1672480209878
230	master	cs_cache_fake	{!GNlLBsLXjbOuNhCkEO:localhost,@admin:localhost}	1672480210139
231	master	get_user_by_id	{@admin:localhost}	1672481566971
232	master	get_user_by_access_token	{MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjNjaWQgdXNlcl9pZCA9IEBhZG1pbjpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSBXVU9yUTVRMFRnUkNjME1ACjAwMmZzaWduYXR1cmUgdYKA-yuTQ5JV5O0HWRak-48xavOYgA1MMc6A1V_Uw5kK}	1672481566998
233	master	count_e2e_one_time_keys	{@admin:localhost,WCSUBIGVWG}	1672481567014
234	master	get_e2e_unused_fallback_key_types	{@admin:localhost,WCSUBIGVWG}	1672481567019
235	master	get_user_by_access_token	{syt_YnJpZGdlYWRtaW4_nlAxPyQxZbWOqdTXNWeT_2ky0xI}	1672481601554
236	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,TZENIQYSDC}	1672481601572
237	master	get_e2e_unused_fallback_key_types	{@bridgeadmin:localhost,TZENIQYSDC}	1672481601575
238	master	count_e2e_one_time_keys	{@admin:localhost,JOEAGREGVO}	1672481615795
239	master	get_e2e_unused_fallback_key_types	{@admin:localhost,JOEAGREGVO}	1672481615829
240	master	count_e2e_one_time_keys	{@admin:localhost,JOEAGREGVO}	1672481615916
241	master	get_e2e_unused_fallback_key_types	{@admin:localhost,JOEAGREGVO}	1672481615923
242	master	count_e2e_one_time_keys	{@admin:localhost,JOEAGREGVO}	1672481615994
243	master	count_e2e_one_time_keys	{@admin:localhost,JOEAGREGVO}	1672481616074
251	master	count_e2e_one_time_keys	{@admin:localhost,JOEAGREGVO}	1672481616588
244	master	count_e2e_one_time_keys	{@admin:localhost,JOEAGREGVO}	1672481616145
245	master	count_e2e_one_time_keys	{@admin:localhost,JOEAGREGVO}	1672481616238
246	master	_get_bare_e2e_cross_signing_keys	{@admin:localhost}	1672481616311
253	master	_get_bare_e2e_cross_signing_keys	{@admin:localhost}	1672481619385
254	master	_get_bare_e2e_cross_signing_keys	{@admin:localhost}	1672481619391
255	master	_get_bare_e2e_cross_signing_keys	{@admin:localhost}	1672481619395
247	master	count_e2e_one_time_keys	{@admin:localhost,JOEAGREGVO}	1672481616319
248	master	_get_bare_e2e_cross_signing_keys	{@admin:localhost}	1672481616320
249	master	_get_bare_e2e_cross_signing_keys	{@admin:localhost}	1672481616339
250	master	count_e2e_one_time_keys	{@admin:localhost,JOEAGREGVO}	1672481616455
252	master	count_e2e_one_time_keys	{@admin:localhost,JOEAGREGVO}	1672481616724
256	master	cs_cache_fake	{!GNlLBsLXjbOuNhCkEO:localhost,@admin:localhost}	1672481639333
257	master	cs_cache_fake	{!MrxfbdodytWwBMqNiF:localhost,@admin:localhost}	1672481652309
258	master	cs_cache_fake	{!MrxfbdodytWwBMqNiF:localhost}	1672481727329
259	master	cs_cache_fake	{!nPrdOOfNMRrmJedabn:localhost}	1672481741093
260	master	cs_cache_fake	{!nPrdOOfNMRrmJedabn:localhost,@admin:localhost}	1672481741274
261	master	cs_cache_fake	{!nPrdOOfNMRrmJedabn:localhost}	1672481741597
262	master	cs_cache_fake	{!nPrdOOfNMRrmJedabn:localhost}	1672481741780
263	master	cs_cache_fake	{!nPrdOOfNMRrmJedabn:localhost}	1672481741903
264	master	cs_cache_fake	{!nPrdOOfNMRrmJedabn:localhost}	1672481742018
265	master	cs_cache_fake	{!nPrdOOfNMRrmJedabn:localhost}	1672481742153
266	master	cs_cache_fake	{!MrxfbdodytWwBMqNiF:localhost}	1672481742260
267	master	get_aliases_for_room	{!MrxfbdodytWwBMqNiF:localhost}	1672481742280
268	master	get_aliases_for_room	{!nPrdOOfNMRrmJedabn:localhost}	1672481742285
269	master	get_aliases_for_room	{!MrxfbdodytWwBMqNiF:localhost}	1672481742361
270	master	get_aliases_for_room	{!nPrdOOfNMRrmJedabn:localhost}	1672481742362
271	master	cs_cache_fake	{!MrxfbdodytWwBMqNiF:localhost}	1672481742452
272	master	cs_cache_fake	{!nPrdOOfNMRrmJedabn:localhost,@bridgeuser1:localhost}	1672481743052
273	master	get_user_by_access_token	{syt_YWRtaW4_qcysgvLIAiQdwMiatzuO_4Fh3df}	1672481761201
274	master	count_e2e_one_time_keys	{@admin:localhost,JOEAGREGVO}	1672481761222
275	master	get_e2e_unused_fallback_key_types	{@admin:localhost,JOEAGREGVO}	1672481761226
276	master	count_e2e_one_time_keys	{@admin:localhost,KFURKEDWNO}	1672481785426
277	master	get_e2e_unused_fallback_key_types	{@admin:localhost,KFURKEDWNO}	1672481785456
278	master	count_e2e_one_time_keys	{@admin:localhost,KFURKEDWNO}	1672481785533
279	master	count_e2e_one_time_keys	{@admin:localhost,KFURKEDWNO}	1672481785596
280	master	count_e2e_one_time_keys	{@admin:localhost,KFURKEDWNO}	1672481785660
281	master	count_e2e_one_time_keys	{@admin:localhost,KFURKEDWNO}	1672481785715
282	master	count_e2e_one_time_keys	{@admin:localhost,KFURKEDWNO}	1672481785772
283	master	count_e2e_one_time_keys	{@admin:localhost,KFURKEDWNO}	1672481785828
284	master	count_e2e_one_time_keys	{@admin:localhost,KFURKEDWNO}	1672481785887
285	master	count_e2e_one_time_keys	{@admin:localhost,KFURKEDWNO}	1672481785950
286	master	count_e2e_one_time_keys	{@admin:localhost,KFURKEDWNO}	1672481786008
287	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@bridgeadmin:localhost}	1672481823193
288	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@bridgeuser1:localhost}	1672481842191
289	master	get_user_by_id	{@admin:localhost}	1672482250729
290	master	get_user_by_access_token	{syt_YWRtaW4_buUzZErRoZfQBzygSRKf_2jk2eE}	1672482250743
291	master	count_e2e_one_time_keys	{@admin:localhost,KFURKEDWNO}	1672482250757
292	master	get_e2e_unused_fallback_key_types	{@admin:localhost,KFURKEDWNO}	1672482250760
293	master	count_e2e_one_time_keys	{@admin:localhost,XEZPTSZEHL}	1672482314890
294	master	get_e2e_unused_fallback_key_types	{@admin:localhost,XEZPTSZEHL}	1672482314910
295	master	count_e2e_one_time_keys	{@admin:localhost,XEZPTSZEHL}	1672482315015
296	master	get_e2e_unused_fallback_key_types	{@admin:localhost,XEZPTSZEHL}	1672482315021
297	master	count_e2e_one_time_keys	{@admin:localhost,XEZPTSZEHL}	1672482315085
298	master	count_e2e_one_time_keys	{@admin:localhost,XEZPTSZEHL}	1672482315141
299	master	count_e2e_one_time_keys	{@admin:localhost,XEZPTSZEHL}	1672482315197
300	master	count_e2e_one_time_keys	{@admin:localhost,XEZPTSZEHL}	1672482315259
301	master	count_e2e_one_time_keys	{@admin:localhost,XEZPTSZEHL}	1672482315318
302	master	count_e2e_one_time_keys	{@admin:localhost,XEZPTSZEHL}	1672482315409
303	master	count_e2e_one_time_keys	{@admin:localhost,XEZPTSZEHL}	1672482315484
304	master	count_e2e_one_time_keys	{@admin:localhost,XEZPTSZEHL}	1672482315544
305	master	get_user_by_id	{@matrix_a:localhost}	1672482420960
306	master	get_user_by_access_token	{MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjZjaWQgdXNlcl9pZCA9IEBtYXRyaXhfYTpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSAwb3Y6eTZVdHojUk4jbFprCjAwMmZzaWduYXR1cmUgNNZKnOVRzj5svh9pEM0UUEqtXYnHjnj9XyNLJ1_uKoAK}	1672482420981
307	master	count_e2e_one_time_keys	{@matrix_a:localhost,TKAVEOGKHH}	1672482421017
308	master	get_e2e_unused_fallback_key_types	{@matrix_a:localhost,TKAVEOGKHH}	1672482421022
309	master	cs_cache_fake	{!LwtGEdNVvQHvFLuWQB:localhost,@admin:localhost}	1672482445800
310	master	get_user_by_access_token	{syt_YWRtaW4_NCBAoukOFOBAjSaUWOeN_2phmbL}	1672482506380
311	master	count_e2e_one_time_keys	{@admin:localhost,XEZPTSZEHL}	1672482506396
312	master	get_e2e_unused_fallback_key_types	{@admin:localhost,XEZPTSZEHL}	1672482506398
313	master	count_e2e_one_time_keys	{@matrix_a:localhost,JHXXJJAPZQ}	1672482522516
321	master	_get_bare_e2e_cross_signing_keys	{@matrix_a:localhost}	1672482522966
314	master	get_e2e_unused_fallback_key_types	{@matrix_a:localhost,JHXXJJAPZQ}	1672482522555
325	master	count_e2e_one_time_keys	{@matrix_a:localhost,JHXXJJAPZQ}	1672482523163
331	master	count_e2e_one_time_keys	{@matrix_a:localhost,JHXXJJAPZQ}	1672483090004
332	master	get_e2e_unused_fallback_key_types	{@matrix_a:localhost,JHXXJJAPZQ}	1672483090006
315	master	count_e2e_one_time_keys	{@matrix_a:localhost,JHXXJJAPZQ}	1672482522655
326	master	count_e2e_one_time_keys	{@matrix_a:localhost,JHXXJJAPZQ}	1672482523257
316	master	get_e2e_unused_fallback_key_types	{@matrix_a:localhost,JHXXJJAPZQ}	1672482522664
317	master	count_e2e_one_time_keys	{@matrix_a:localhost,JHXXJJAPZQ}	1672482522736
318	master	count_e2e_one_time_keys	{@matrix_a:localhost,JHXXJJAPZQ}	1672482522805
319	master	count_e2e_one_time_keys	{@matrix_a:localhost,JHXXJJAPZQ}	1672482522869
327	master	count_e2e_one_time_keys	{@matrix_a:localhost,JHXXJJAPZQ}	1672482523324
320	master	count_e2e_one_time_keys	{@matrix_a:localhost,JHXXJJAPZQ}	1672482522947
322	master	_get_bare_e2e_cross_signing_keys	{@matrix_a:localhost}	1672482522977
323	master	_get_bare_e2e_cross_signing_keys	{@matrix_a:localhost}	1672482522995
324	master	count_e2e_one_time_keys	{@matrix_a:localhost,JHXXJJAPZQ}	1672482523032
329	master	cs_cache_fake	{!kAToIwhNWrDpgQVMfY:localhost,@matrix_a:localhost}	1672482657879
328	master	cs_cache_fake	{!UKcoTBWWxNEyixrjyM:localhost,@matrix_a:localhost}	1672482632577
330	master	get_user_by_access_token	{syt_bWF0cml4X2E_QZXFOaNjjlgkaAgrqTHa_0R6Cof}	1672483089988
\.


--
-- Data for Name: current_state_delta_stream; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.current_state_delta_stream (stream_id, room_id, type, state_key, event_id, prev_event_id, instance_name) FROM stdin;
2	!kmbTYjjsDRDHGgVqUP:localhost	m.room.create		$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	\N	\N
3	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@admin:localhost	$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw	\N	\N
4	!kmbTYjjsDRDHGgVqUP:localhost	m.room.power_levels		$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	\N	\N
5	!kmbTYjjsDRDHGgVqUP:localhost	m.room.canonical_alias		$X8tdoEsXAgBC6gobCepAn3rwO8CJoQU6i9NN9Rzhukg	\N	\N
6	!kmbTYjjsDRDHGgVqUP:localhost	m.room.join_rules		$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	\N	\N
7	!kmbTYjjsDRDHGgVqUP:localhost	m.room.history_visibility		$O5iO4EII22igkDq5cMKHFB-SGIYD0KqJQXZohS2Dzc0	\N	\N
8	!dKcbdDATuwwphjRPQP:localhost	m.room.create		$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	\N	\N
9	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@admin:localhost	$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA	\N	\N
10	!dKcbdDATuwwphjRPQP:localhost	m.room.power_levels		$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	\N	\N
11	!dKcbdDATuwwphjRPQP:localhost	m.room.canonical_alias		$b__a7rX3L5YpX7nAZte73DAbjtXZK48JH8VKSnGOKKw	\N	\N
12	!dKcbdDATuwwphjRPQP:localhost	m.room.join_rules		$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	\N	\N
13	!dKcbdDATuwwphjRPQP:localhost	m.room.history_visibility		$TVnvv0nGbLydCBtMmTTz-htMsoI4hmxCr3s9AHyFGHQ	\N	\N
14	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_a:localhost	$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8	\N	\N
15	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0	\N	\N
16	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_b:localhost	$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk	\N	\N
17	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_b:localhost	$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0	\N	\N
18	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@ignored_user:localhost	$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	\N	\N
19	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@ignored_user:localhost	$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A	\N	\N
20	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok	\N	master
21	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ	\N	master
22	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$7TwPfUMTevEcf7wLvbgx3LG01lYT_yGudYiOVlkGU7E	\N	master
23	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$jAifmicJfMyB1QPFQ6KFQ7ZqTqQ58RJXsH5viWn3ZUg	\N	master
24	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$DsZXxk2rEIB2tF3pYUdOPjrMwclo8BXltutiWCnKUIU	\N	master
25	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$NyVGoA-ZaMPbk_RzpmLOajRS1nEBirO7Du2KpA9Eo64	\N	master
26	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$JwL8EK5sa4vg29tclnHwa5jrpCTa8oZVOIsgFyivQdY	$7TwPfUMTevEcf7wLvbgx3LG01lYT_yGudYiOVlkGU7E	master
27	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$JcoTJcBGASUqIK9V7j6ND5Jt6P9gdbNJxXxQBZNg8z4	$jAifmicJfMyB1QPFQ6KFQ7ZqTqQ58RJXsH5viWn3ZUg	master
28	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$2KnXfE3sZw8LDrOAaEP4HdQuw5neshhvyZKtnwo5cg0	$DsZXxk2rEIB2tF3pYUdOPjrMwclo8BXltutiWCnKUIU	master
29	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$isXWKf_B_7Z7R7jYn_2gZB-U31TuzMehBRxj5701Lq8	$NyVGoA-ZaMPbk_RzpmLOajRS1nEBirO7Du2KpA9Eo64	master
30	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a_:localhost	$rVK77mVSpz5EHxI2mbLxilqbkLxKhXEiusPFjapVPbw	\N	master
31	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b_:localhost	$5agO4kI6VqJHGKvKbkqUa2Y3cTwUBrjAhmCVtj9JmKU	\N	master
32	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_matrix_matrix_b:localhost	$4JiNeQHyMbyuEfymLkE-SEzPUh3bWddjxa6-5w36nJw	\N	master
33	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_matrix_matrix_a:localhost	$Y_S-fF0iLu0OHNMcZdYVzt0we_qL_t8_4QIKGeobLdI	\N	master
34	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_matrix_matrix_a:localhost	$g1kV-jEZBtN9l6VGGo2MN-wQn7RR7J-Tv5LfyJ5Z5fc	\N	master
35	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a_:localhost	$CQg_jKvdpWFvaiLH2f5MtTnu1Zwxi8P4QPSJZum91dw	$rVK77mVSpz5EHxI2mbLxilqbkLxKhXEiusPFjapVPbw	master
36	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b_:localhost	$OcvCF7YNeTKFnzz4EWVjFJIF9QidMEUmomHIvH3d2W8	\N	master
37	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_matrix_matrix_b:localhost	$GrqoJ52XSgRaoc4wPEYLdL2p6t3jl0aiFd8bYswQQcU	\N	master
38	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a_:localhost	$5TE1hAtSTolrY9QTj9Wt8DnKurFa3P6KIfGkWOJbrY4	\N	master
39	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b_:localhost	$UYXKiTPqFr31PwoZzi35ODpdRK0hwJVjVGC1N7kR7yk	$5agO4kI6VqJHGKvKbkqUa2Y3cTwUBrjAhmCVtj9JmKU	master
40	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_matrix_matrix_b:localhost	$YFCWkh6b_jgrSjje7vt6JB6-uLPRz7Na1VgGh0PwdI8	$4JiNeQHyMbyuEfymLkE-SEzPUh3bWddjxa6-5w36nJw	master
41	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_matrix_matrix_a:localhost	$h2yGPxzdKWUBUSFQiOgFiRoNa8NgWHYXdy_2SMJx6ns	$Y_S-fF0iLu0OHNMcZdYVzt0we_qL_t8_4QIKGeobLdI	master
42	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_matrix_matrix_a:localhost	$kmvnPONhcKxIpG62sV6apngYToshpP0mBrwpKL0hAOI	$g1kV-jEZBtN9l6VGGo2MN-wQn7RR7J-Tv5LfyJ5Z5fc	master
43	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_matrix_matrix_b:localhost	$KgpvpFIMQIVFvm0adBZqAbWANmMgdu1_1jbP71RuM48	$GrqoJ52XSgRaoc4wPEYLdL2p6t3jl0aiFd8bYswQQcU	master
44	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b_:localhost	$qWi32T1tK2APgSwc4y_6f0e_N_fUPmIBxC5ACk1h6NM	$OcvCF7YNeTKFnzz4EWVjFJIF9QidMEUmomHIvH3d2W8	master
45	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$jvwVmkElpx8M62JlaBz7nJ4qa2U8tVO7V9-HhJ-n8JI	$JcoTJcBGASUqIK9V7j6ND5Jt6P9gdbNJxXxQBZNg8z4	master
46	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a_:localhost	$0WsTO-QKZzqtMdl5UwGJc5h4e7YAE5ZGp_GDMb9K824	$5TE1hAtSTolrY9QTj9Wt8DnKurFa3P6KIfGkWOJbrY4	master
48	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$l5dYt-R2kpcKdlmMRFnzC5N9PjiV4DZ63c1bTGPOCXk	$JwL8EK5sa4vg29tclnHwa5jrpCTa8oZVOIsgFyivQdY	master
47	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$opS4sT6APXaq4vDdegPq6ik1z-yX-FkMTAqhGtTWXEE	$isXWKf_B_7Z7R7jYn_2gZB-U31TuzMehBRxj5701Lq8	master
49	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$NxuVtjeVql0_aadDlNux0yeeR_PxcpcJPnX1SdoDmXM	$2KnXfE3sZw8LDrOAaEP4HdQuw5neshhvyZKtnwo5cg0	master
50	!MrxfbdodytWwBMqNiF:localhost	m.room.create		$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY	\N	master
51	!MrxfbdodytWwBMqNiF:localhost	m.room.member	@bridgeuser1:localhost	$89n67RlAmtb8nRuxie-oq3g9grnkpjzJMAhbJ8h_8Xw	\N	master
53	!MrxfbdodytWwBMqNiF:localhost	m.room.join_rules		$TVXtgqtZ5WfNfZEnJQx6m0NYwp0_34ylOK87XzZ3JlI	\N	master
54	!MrxfbdodytWwBMqNiF:localhost	m.room.history_visibility		$JQ7PDbgzTTAY5uHFM6NV0ovadfzQLOpcAcrSX5mRUi0	\N	master
52	!MrxfbdodytWwBMqNiF:localhost	m.room.power_levels		$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA	\N	master
55	!MrxfbdodytWwBMqNiF:localhost	m.room.guest_access		$9MVFB3q88VYxhDZMX087Uv4c3h3uEpluJN0q33ubtso	\N	master
56	!MrxfbdodytWwBMqNiF:localhost	m.room.member	@admin:localhost	$V_QrTFMCwHlrg-MSVVplcYCRVWM_QgXhIvp-2R_LtHI	\N	master
58	!UKcoTBWWxNEyixrjyM:localhost	m.room.create		$yZwQJfxjuLFOlfyTYw-M1aupZjmck-aVfpfSYx5fj1I	\N	master
59	!UKcoTBWWxNEyixrjyM:localhost	m.room.member	@bridgeuser1:localhost	$sqtTmHJJ_e6UeDKORkztLzcGXYNZpKgoa1v2ir5yr-w	\N	master
60	!UKcoTBWWxNEyixrjyM:localhost	m.room.power_levels		$EsIKBNaGky9gjqListPEKjQfFScHFrG5GuEQD0vyi9Q	\N	master
61	!UKcoTBWWxNEyixrjyM:localhost	m.room.join_rules		$STt_lRcQQY1HR2YQmv4RsQMis1Xc5sWAamnHn02ddqk	\N	master
62	!UKcoTBWWxNEyixrjyM:localhost	m.room.history_visibility		$KEhwfKMs0OrXZWYNQWK_YDu-mrG-UP2Do2VsAShloEY	\N	master
63	!UKcoTBWWxNEyixrjyM:localhost	m.room.guest_access		$em_2PzgnditDYAzn8yY84PnmN1oNQZgI8Co6SjahtU8	\N	master
64	!UKcoTBWWxNEyixrjyM:localhost	m.room.member	@matrix_a:localhost	$sdrkpiq94MhqjrSukg-aexI_3VlPxcoqiZXmrPvpQGw	\N	master
66	!kAToIwhNWrDpgQVMfY:localhost	m.room.create		$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw	\N	master
67	!kAToIwhNWrDpgQVMfY:localhost	m.room.member	@bridgeadmin:localhost	$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE	\N	master
68	!kAToIwhNWrDpgQVMfY:localhost	m.room.power_levels		$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc	\N	master
69	!kAToIwhNWrDpgQVMfY:localhost	m.room.canonical_alias		$fZAJc_jo3uwpjSNh7ULQOuzuMtHLVO8KdmygXkq-95M	\N	master
70	!kAToIwhNWrDpgQVMfY:localhost	m.room.join_rules		$KGv2op0D-6TOpQuqb5Gl4YZxMUKn37cUNSylMiEo7SA	\N	master
71	!kAToIwhNWrDpgQVMfY:localhost	m.room.guest_access		$XvSaPVUaER3JwP1gLc-c__oVTIjGs5YL10o0DSsZ3q0	\N	master
72	!kAToIwhNWrDpgQVMfY:localhost	m.room.history_visibility		$zHrY9OvLbZTtN0bNPCDJg1HsmkgSV-pzAmxVIqaSB98	\N	master
73	!kAToIwhNWrDpgQVMfY:localhost	m.room.name		$Np7HQ3SdNiYX3HhRJtJw4b80J96uY_IbqI_bL7w83m0	\N	master
74	!kAToIwhNWrDpgQVMfY:localhost	m.room.topic		$nL-1meDVcMfCo41V5V5w3EBPwNdmll7Alfsp00QCHvk	\N	master
76	!cwnFZrIkYIOvkCHJkc:localhost	m.room.create		$AXgBEWEnQYL0m4F3qNGi4DDk7afIQe7a_hmRdZkAZLM	\N	master
75	!ffaaxOMHcWnINEXTWK:localhost	m.room.create		$wTlWqRh3eGNrru9CGqbzkNcL0kBGbtEB8sHZwsAboS0	\N	master
77	!ffaaxOMHcWnINEXTWK:localhost	m.room.member	@bridgeadmin:localhost	$81gCIX2tUwDG_Jg02kHVceEfsUG1IOQ9-YnDk1cV15w	\N	master
78	!cwnFZrIkYIOvkCHJkc:localhost	m.room.member	@bridgeadmin:localhost	$41BPCZJ_9IbE7VgIqxEef1X7U2-FXJjTA25i2Q-n_gg	\N	master
79	!ffaaxOMHcWnINEXTWK:localhost	m.room.power_levels		$pn5NPm28AfF5_169OnQQxTv4_ijcoN4k44UIvzGsN7k	\N	master
80	!cwnFZrIkYIOvkCHJkc:localhost	m.room.power_levels		$PJZugFD-K6RtTB0vNzX1j0YFLZ9x4vli99YpMY9dzQk	\N	master
81	!ffaaxOMHcWnINEXTWK:localhost	m.room.join_rules		$jLK4KwpKxGfwbMdz2oJbuUlHegeZ_5YucIy2ChSNCLg	\N	master
82	!cwnFZrIkYIOvkCHJkc:localhost	m.room.join_rules		$ce28aY-iB2mpb8Gioxn_S-YFJtBn3dK4JRguWv9H2XY	\N	master
84	!ffaaxOMHcWnINEXTWK:localhost	m.room.guest_access		$Jy6RZhO0nZ0x_EgWugfJHW0XgWaR5DoWVaImG_wE3lg	\N	master
83	!cwnFZrIkYIOvkCHJkc:localhost	m.room.guest_access		$3ccBKAI_RT742spGFKzsNSBIzhj7WC7YBxugrDvyr4w	\N	master
86	!ffaaxOMHcWnINEXTWK:localhost	m.space.parent	!kAToIwhNWrDpgQVMfY:localhost	$zxy8zKV-5WiZDQEOGVCLyrd2yGWyYrOah4vQYAlc-xI	\N	master
85	!cwnFZrIkYIOvkCHJkc:localhost	m.space.parent	!kAToIwhNWrDpgQVMfY:localhost	$7CUacT0Q8hFhLt80ecyLwLrizW7Jh6uNtLYApZIgNg4	\N	master
87	!ffaaxOMHcWnINEXTWK:localhost	m.room.history_visibility		$e4RXblgeP3Sa0Hs3COmGOAFe9LclWYCrLIk7nF2PEDk	\N	master
88	!cwnFZrIkYIOvkCHJkc:localhost	m.room.history_visibility		$dLHdIN5p2aRYI16qULeP30FhKh5GGtUHvQUzWcSWyTA	\N	master
89	!ffaaxOMHcWnINEXTWK:localhost	m.room.name		$tWJ40KRMdaZwn6df_597mz_AyHLHUSEy0noQk3HlctY	\N	master
90	!cwnFZrIkYIOvkCHJkc:localhost	m.room.name		$ab5rFOQQuDGj00oHfJaJKURhG6lNFNDKS0nkBlsLTMk	\N	master
91	!kAToIwhNWrDpgQVMfY:localhost	m.space.child	!ffaaxOMHcWnINEXTWK:localhost	$BNEpFvlxqdDF-6u3EPToNgfx0BuYX2_P9oWB486xTxM	\N	master
92	!kAToIwhNWrDpgQVMfY:localhost	m.space.child	!cwnFZrIkYIOvkCHJkc:localhost	$v_Jh2P1U7Li3ATyMsxgipoyBuQRYv5HD-cv8JVNpdLc	\N	master
93	!kAToIwhNWrDpgQVMfY:localhost	m.room.member	@matrix_a:localhost	$bFxX1nACgPihIeXfSiWHmW_hxrfmIgtQM9HWAPS2wVY	\N	master
94	!kAToIwhNWrDpgQVMfY:localhost	m.room.member	@matrix_b:localhost	$kL3ALUeGobajxL55gzYoIZLdD1CSD4sYXedIOysHwV0	\N	master
96	!LwtGEdNVvQHvFLuWQB:localhost	m.room.create		$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q	\N	master
97	!LwtGEdNVvQHvFLuWQB:localhost	m.room.member	@bridgeadmin:localhost	$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic	\N	master
98	!LwtGEdNVvQHvFLuWQB:localhost	m.room.power_levels		$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k	\N	master
99	!LwtGEdNVvQHvFLuWQB:localhost	m.room.join_rules		$PTHh0FcsZLrplrmwtCyvLjXr1yAZRgovFGLVt7qrrAo	\N	master
100	!LwtGEdNVvQHvFLuWQB:localhost	m.room.history_visibility		$6CLZCTGtpIVnohQDg2sJwn_880f0--zCZpr6BgOwQ2Q	\N	master
101	!LwtGEdNVvQHvFLuWQB:localhost	m.room.guest_access		$nKXxWIIoo5Vko9Z7kITUEeAsQgQnr-FLvhoQHfkCYAE	\N	master
102	!LwtGEdNVvQHvFLuWQB:localhost	m.room.member	@admin:localhost	$TbFvVskFwRsxEgjNnOjfs4ljMJuZC60_Cqb91vOUrxg	\N	master
104	!LwtGEdNVvQHvFLuWQB:localhost	m.room.encryption		$SuM_AupYZSEtAJBPHbvNkhJ4aIYEjT4c741wzkoOX4I	\N	master
105	!GNlLBsLXjbOuNhCkEO:localhost	m.room.create		$_-6CgruWK6UfiL1rgJnNUgtmp_jusf_3Vf7LUPB6xaU	\N	master
106	!GNlLBsLXjbOuNhCkEO:localhost	m.room.member	@bridgeadmin:localhost	$yrfdAmX0K0lY65Dm9bViRYWOBKtvTB1kxkm6lNsThdw	\N	master
107	!GNlLBsLXjbOuNhCkEO:localhost	m.room.power_levels		$uKKFUGwf_IAnbH81DTvAScd2HFnAwWWL_p4-E5B_YdU	\N	master
108	!GNlLBsLXjbOuNhCkEO:localhost	m.room.encryption		$MRytSYI-n7aCgzUssVx9vLIC5Y-Yt22y_L1eQoE4GgE	\N	master
109	!GNlLBsLXjbOuNhCkEO:localhost	m.room.guest_access		$ah5gH_XfCIYeCtl2NFxHSgdd_OE6O9tHe2U1Pn2Qvhc	\N	master
110	!GNlLBsLXjbOuNhCkEO:localhost	m.room.history_visibility		$lnpmPOjrFoaPq58156r6g4G7gYfejQ2BfcFkjGiEX-I	\N	master
111	!GNlLBsLXjbOuNhCkEO:localhost	m.room.join_rules		$fuvIFJYv32qkEsYyW8XNHbQ0hmQ5HHRjF6UEjte6Z-c	\N	master
112	!LwtGEdNVvQHvFLuWQB:localhost	m.room.tombstone		$smbpaz4v1tYoI0ZZ-HXKXrcs19S7qioXa8ah6FeOBpc	\N	master
113	!LwtGEdNVvQHvFLuWQB:localhost	m.room.power_levels		$O-kcGXcFLVtSNAY7CxqW4hLVBk0UqhADtIs1kCz8hlA	$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k	master
114	!GNlLBsLXjbOuNhCkEO:localhost	m.room.member	@admin:localhost	$vesveJhdimZ9d-Po76D8SZCUm8dVzl0GcQsvVX8lhos	\N	master
115	!GNlLBsLXjbOuNhCkEO:localhost	m.room.member	@admin:localhost	$nfronhC7iKGPRmKJ7zoXzYG7VKiOq5FoUIcfHg3a4Dg	$vesveJhdimZ9d-Po76D8SZCUm8dVzl0GcQsvVX8lhos	master
116	!MrxfbdodytWwBMqNiF:localhost	m.room.member	@admin:localhost	$Pem9TyngNuhpIq_NI2krx6wpkVigoBj6JCeB3WUezVk	$V_QrTFMCwHlrg-MSVVplcYCRVWM_QgXhIvp-2R_LtHI	master
118	!MrxfbdodytWwBMqNiF:localhost	m.room.encryption		$viSFX8RvY5fe8TiOaDirNG6PqooEHTTV3PT3hrQgVLA	\N	master
119	!nPrdOOfNMRrmJedabn:localhost	m.room.create		$A5h106ytjQ2qqPxkSylhOkJgVZQCscB4QX0PK60qxU0	\N	master
120	!nPrdOOfNMRrmJedabn:localhost	m.room.member	@admin:localhost	$AMnH95Ky85GttLR7j9XHrHyULlBBezFJ9w8mtji-7Ok	\N	master
121	!nPrdOOfNMRrmJedabn:localhost	m.room.power_levels		$gDW6j_UqhvIRf1ANEKurSD9fB4Hl4YnQ5uL9cy_U7Os	\N	master
122	!nPrdOOfNMRrmJedabn:localhost	m.room.join_rules		$0gszMJtyESzwVMh4olwTajdbj1MrrJYVnylO0yOIpSg	\N	master
123	!nPrdOOfNMRrmJedabn:localhost	m.room.history_visibility		$2lEnFzGdtIu4kGthBBXcP0gW6sUWKP8c1x9I4-yFWso	\N	master
124	!nPrdOOfNMRrmJedabn:localhost	m.room.guest_access		$yfuDQBYjEI6CCa3AdtfdjL_ZXIR0d92TRfHnh7Gq0zc	\N	master
125	!nPrdOOfNMRrmJedabn:localhost	m.room.encryption		$xyV3lysb-dda01bB4LpALdmaTC_mLZDhwxOE9L4zpXY	\N	master
126	!MrxfbdodytWwBMqNiF:localhost	m.room.tombstone		$MT4EKTmcPC8LCVeATiG-5a71N2Zc1vNQcgKge5W0on8	\N	master
127	!MrxfbdodytWwBMqNiF:localhost	m.room.power_levels		$eOC3-FZNb3jb3NisHG61gQhQ_hf9zWu0xvpfs8ZKDTg	$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA	master
128	!nPrdOOfNMRrmJedabn:localhost	m.room.member	@bridgeuser1:localhost	$usag8slAxKA2dWWERksMiBQ8hRwfGZ8nZzTfcymZxyE	\N	master
129	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@bridgeadmin:localhost	$O04OV5x9R_5W2IT9G9Z-dXJmfV6fgtZM8-4ogFp9rEw	\N	master
130	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@bridgeuser1:localhost	$-QMfwsu75_SWJtzFqIsrFjLgl_XBqF6HcorcUjLTsWY	\N	master
133	!LwtGEdNVvQHvFLuWQB:localhost	m.room.member	@admin:localhost	$WsVhQvsUsrFormgSdFA_Z_Io7y9fxZy5juqaM8oYpkg	$TbFvVskFwRsxEgjNnOjfs4ljMJuZC60_Cqb91vOUrxg	master
137	!UKcoTBWWxNEyixrjyM:localhost	m.room.member	@matrix_a:localhost	$hooKnajA7nQRs3MZDj_evGyHCyHpg4QmGp2i5WRKzp0	$sdrkpiq94MhqjrSukg-aexI_3VlPxcoqiZXmrPvpQGw	master
139	!kAToIwhNWrDpgQVMfY:localhost	m.room.member	@matrix_a:localhost	$rNG4YvsFCU9LVcVcHEkbBRGSuEH_QqO_hMEZ-sC8WH8	$bFxX1nACgPihIeXfSiWHmW_hxrfmIgtQM9HWAPS2wVY	master
\.


--
-- Data for Name: current_state_events; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.current_state_events (event_id, room_id, type, state_key, membership) FROM stdin;
$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost	m.room.create		\N
$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@admin:localhost	join
$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost	m.room.power_levels		\N
$X8tdoEsXAgBC6gobCepAn3rwO8CJoQU6i9NN9Rzhukg	!kmbTYjjsDRDHGgVqUP:localhost	m.room.canonical_alias		\N
$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost	m.room.join_rules		\N
$O5iO4EII22igkDq5cMKHFB-SGIYD0KqJQXZohS2Dzc0	!kmbTYjjsDRDHGgVqUP:localhost	m.room.history_visibility		\N
$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost	m.room.create		\N
$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@admin:localhost	join
$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost	m.room.power_levels		\N
$b__a7rX3L5YpX7nAZte73DAbjtXZK48JH8VKSnGOKKw	!dKcbdDATuwwphjRPQP:localhost	m.room.canonical_alias		\N
$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost	m.room.join_rules		\N
$TVnvv0nGbLydCBtMmTTz-htMsoI4hmxCr3s9AHyFGHQ	!dKcbdDATuwwphjRPQP:localhost	m.room.history_visibility		\N
$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_a:localhost	join
$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	join
$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_b:localhost	join
$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_b:localhost	join
$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@ignored_user:localhost	join
$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@ignored_user:localhost	join
$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	join
$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	join
$CQg_jKvdpWFvaiLH2f5MtTnu1Zwxi8P4QPSJZum91dw	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a_:localhost	join
$UYXKiTPqFr31PwoZzi35ODpdRK0hwJVjVGC1N7kR7yk	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b_:localhost	join
$YFCWkh6b_jgrSjje7vt6JB6-uLPRz7Na1VgGh0PwdI8	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_matrix_matrix_b:localhost	join
$h2yGPxzdKWUBUSFQiOgFiRoNa8NgWHYXdy_2SMJx6ns	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_matrix_matrix_a:localhost	join
$kmvnPONhcKxIpG62sV6apngYToshpP0mBrwpKL0hAOI	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_matrix_matrix_a:localhost	join
$KgpvpFIMQIVFvm0adBZqAbWANmMgdu1_1jbP71RuM48	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_matrix_matrix_b:localhost	join
$qWi32T1tK2APgSwc4y_6f0e_N_fUPmIBxC5ACk1h6NM	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b_:localhost	join
$jvwVmkElpx8M62JlaBz7nJ4qa2U8tVO7V9-HhJ-n8JI	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	leave
$0WsTO-QKZzqtMdl5UwGJc5h4e7YAE5ZGp_GDMb9K824	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a_:localhost	join
$l5dYt-R2kpcKdlmMRFnzC5N9PjiV4DZ63c1bTGPOCXk	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	leave
$opS4sT6APXaq4vDdegPq6ik1z-yX-FkMTAqhGtTWXEE	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	leave
$NxuVtjeVql0_aadDlNux0yeeR_PxcpcJPnX1SdoDmXM	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	leave
$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY	!MrxfbdodytWwBMqNiF:localhost	m.room.create		\N
$89n67RlAmtb8nRuxie-oq3g9grnkpjzJMAhbJ8h_8Xw	!MrxfbdodytWwBMqNiF:localhost	m.room.member	@bridgeuser1:localhost	join
$TVXtgqtZ5WfNfZEnJQx6m0NYwp0_34ylOK87XzZ3JlI	!MrxfbdodytWwBMqNiF:localhost	m.room.join_rules		\N
$JQ7PDbgzTTAY5uHFM6NV0ovadfzQLOpcAcrSX5mRUi0	!MrxfbdodytWwBMqNiF:localhost	m.room.history_visibility		\N
$9MVFB3q88VYxhDZMX087Uv4c3h3uEpluJN0q33ubtso	!MrxfbdodytWwBMqNiF:localhost	m.room.guest_access		\N
$yZwQJfxjuLFOlfyTYw-M1aupZjmck-aVfpfSYx5fj1I	!UKcoTBWWxNEyixrjyM:localhost	m.room.create		\N
$sqtTmHJJ_e6UeDKORkztLzcGXYNZpKgoa1v2ir5yr-w	!UKcoTBWWxNEyixrjyM:localhost	m.room.member	@bridgeuser1:localhost	join
$EsIKBNaGky9gjqListPEKjQfFScHFrG5GuEQD0vyi9Q	!UKcoTBWWxNEyixrjyM:localhost	m.room.power_levels		\N
$STt_lRcQQY1HR2YQmv4RsQMis1Xc5sWAamnHn02ddqk	!UKcoTBWWxNEyixrjyM:localhost	m.room.join_rules		\N
$KEhwfKMs0OrXZWYNQWK_YDu-mrG-UP2Do2VsAShloEY	!UKcoTBWWxNEyixrjyM:localhost	m.room.history_visibility		\N
$em_2PzgnditDYAzn8yY84PnmN1oNQZgI8Co6SjahtU8	!UKcoTBWWxNEyixrjyM:localhost	m.room.guest_access		\N
$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw	!kAToIwhNWrDpgQVMfY:localhost	m.room.create		\N
$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE	!kAToIwhNWrDpgQVMfY:localhost	m.room.member	@bridgeadmin:localhost	join
$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc	!kAToIwhNWrDpgQVMfY:localhost	m.room.power_levels		\N
$fZAJc_jo3uwpjSNh7ULQOuzuMtHLVO8KdmygXkq-95M	!kAToIwhNWrDpgQVMfY:localhost	m.room.canonical_alias		\N
$KGv2op0D-6TOpQuqb5Gl4YZxMUKn37cUNSylMiEo7SA	!kAToIwhNWrDpgQVMfY:localhost	m.room.join_rules		\N
$XvSaPVUaER3JwP1gLc-c__oVTIjGs5YL10o0DSsZ3q0	!kAToIwhNWrDpgQVMfY:localhost	m.room.guest_access		\N
$zHrY9OvLbZTtN0bNPCDJg1HsmkgSV-pzAmxVIqaSB98	!kAToIwhNWrDpgQVMfY:localhost	m.room.history_visibility		\N
$Np7HQ3SdNiYX3HhRJtJw4b80J96uY_IbqI_bL7w83m0	!kAToIwhNWrDpgQVMfY:localhost	m.room.name		\N
$nL-1meDVcMfCo41V5V5w3EBPwNdmll7Alfsp00QCHvk	!kAToIwhNWrDpgQVMfY:localhost	m.room.topic		\N
$AXgBEWEnQYL0m4F3qNGi4DDk7afIQe7a_hmRdZkAZLM	!cwnFZrIkYIOvkCHJkc:localhost	m.room.create		\N
$wTlWqRh3eGNrru9CGqbzkNcL0kBGbtEB8sHZwsAboS0	!ffaaxOMHcWnINEXTWK:localhost	m.room.create		\N
$81gCIX2tUwDG_Jg02kHVceEfsUG1IOQ9-YnDk1cV15w	!ffaaxOMHcWnINEXTWK:localhost	m.room.member	@bridgeadmin:localhost	join
$ab5rFOQQuDGj00oHfJaJKURhG6lNFNDKS0nkBlsLTMk	!cwnFZrIkYIOvkCHJkc:localhost	m.room.name		\N
$41BPCZJ_9IbE7VgIqxEef1X7U2-FXJjTA25i2Q-n_gg	!cwnFZrIkYIOvkCHJkc:localhost	m.room.member	@bridgeadmin:localhost	join
$pn5NPm28AfF5_169OnQQxTv4_ijcoN4k44UIvzGsN7k	!ffaaxOMHcWnINEXTWK:localhost	m.room.power_levels		\N
$PJZugFD-K6RtTB0vNzX1j0YFLZ9x4vli99YpMY9dzQk	!cwnFZrIkYIOvkCHJkc:localhost	m.room.power_levels		\N
$jLK4KwpKxGfwbMdz2oJbuUlHegeZ_5YucIy2ChSNCLg	!ffaaxOMHcWnINEXTWK:localhost	m.room.join_rules		\N
$BNEpFvlxqdDF-6u3EPToNgfx0BuYX2_P9oWB486xTxM	!kAToIwhNWrDpgQVMfY:localhost	m.space.child	!ffaaxOMHcWnINEXTWK:localhost	\N
$v_Jh2P1U7Li3ATyMsxgipoyBuQRYv5HD-cv8JVNpdLc	!kAToIwhNWrDpgQVMfY:localhost	m.space.child	!cwnFZrIkYIOvkCHJkc:localhost	\N
$ce28aY-iB2mpb8Gioxn_S-YFJtBn3dK4JRguWv9H2XY	!cwnFZrIkYIOvkCHJkc:localhost	m.room.join_rules		\N
$e4RXblgeP3Sa0Hs3COmGOAFe9LclWYCrLIk7nF2PEDk	!ffaaxOMHcWnINEXTWK:localhost	m.room.history_visibility		\N
$Jy6RZhO0nZ0x_EgWugfJHW0XgWaR5DoWVaImG_wE3lg	!ffaaxOMHcWnINEXTWK:localhost	m.room.guest_access		\N
$7CUacT0Q8hFhLt80ecyLwLrizW7Jh6uNtLYApZIgNg4	!cwnFZrIkYIOvkCHJkc:localhost	m.space.parent	!kAToIwhNWrDpgQVMfY:localhost	\N
$3ccBKAI_RT742spGFKzsNSBIzhj7WC7YBxugrDvyr4w	!cwnFZrIkYIOvkCHJkc:localhost	m.room.guest_access		\N
$dLHdIN5p2aRYI16qULeP30FhKh5GGtUHvQUzWcSWyTA	!cwnFZrIkYIOvkCHJkc:localhost	m.room.history_visibility		\N
$zxy8zKV-5WiZDQEOGVCLyrd2yGWyYrOah4vQYAlc-xI	!ffaaxOMHcWnINEXTWK:localhost	m.space.parent	!kAToIwhNWrDpgQVMfY:localhost	\N
$tWJ40KRMdaZwn6df_597mz_AyHLHUSEy0noQk3HlctY	!ffaaxOMHcWnINEXTWK:localhost	m.room.name		\N
$kL3ALUeGobajxL55gzYoIZLdD1CSD4sYXedIOysHwV0	!kAToIwhNWrDpgQVMfY:localhost	m.room.member	@matrix_b:localhost	invite
$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q	!LwtGEdNVvQHvFLuWQB:localhost	m.room.create		\N
$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic	!LwtGEdNVvQHvFLuWQB:localhost	m.room.member	@bridgeadmin:localhost	join
$PTHh0FcsZLrplrmwtCyvLjXr1yAZRgovFGLVt7qrrAo	!LwtGEdNVvQHvFLuWQB:localhost	m.room.join_rules		\N
$6CLZCTGtpIVnohQDg2sJwn_880f0--zCZpr6BgOwQ2Q	!LwtGEdNVvQHvFLuWQB:localhost	m.room.history_visibility		\N
$nKXxWIIoo5Vko9Z7kITUEeAsQgQnr-FLvhoQHfkCYAE	!LwtGEdNVvQHvFLuWQB:localhost	m.room.guest_access		\N
$SuM_AupYZSEtAJBPHbvNkhJ4aIYEjT4c741wzkoOX4I	!LwtGEdNVvQHvFLuWQB:localhost	m.room.encryption		\N
$_-6CgruWK6UfiL1rgJnNUgtmp_jusf_3Vf7LUPB6xaU	!GNlLBsLXjbOuNhCkEO:localhost	m.room.create		\N
$yrfdAmX0K0lY65Dm9bViRYWOBKtvTB1kxkm6lNsThdw	!GNlLBsLXjbOuNhCkEO:localhost	m.room.member	@bridgeadmin:localhost	join
$uKKFUGwf_IAnbH81DTvAScd2HFnAwWWL_p4-E5B_YdU	!GNlLBsLXjbOuNhCkEO:localhost	m.room.power_levels		\N
$MRytSYI-n7aCgzUssVx9vLIC5Y-Yt22y_L1eQoE4GgE	!GNlLBsLXjbOuNhCkEO:localhost	m.room.encryption		\N
$ah5gH_XfCIYeCtl2NFxHSgdd_OE6O9tHe2U1Pn2Qvhc	!GNlLBsLXjbOuNhCkEO:localhost	m.room.guest_access		\N
$lnpmPOjrFoaPq58156r6g4G7gYfejQ2BfcFkjGiEX-I	!GNlLBsLXjbOuNhCkEO:localhost	m.room.history_visibility		\N
$fuvIFJYv32qkEsYyW8XNHbQ0hmQ5HHRjF6UEjte6Z-c	!GNlLBsLXjbOuNhCkEO:localhost	m.room.join_rules		\N
$smbpaz4v1tYoI0ZZ-HXKXrcs19S7qioXa8ah6FeOBpc	!LwtGEdNVvQHvFLuWQB:localhost	m.room.tombstone		\N
$O-kcGXcFLVtSNAY7CxqW4hLVBk0UqhADtIs1kCz8hlA	!LwtGEdNVvQHvFLuWQB:localhost	m.room.power_levels		\N
$nfronhC7iKGPRmKJ7zoXzYG7VKiOq5FoUIcfHg3a4Dg	!GNlLBsLXjbOuNhCkEO:localhost	m.room.member	@admin:localhost	join
$Pem9TyngNuhpIq_NI2krx6wpkVigoBj6JCeB3WUezVk	!MrxfbdodytWwBMqNiF:localhost	m.room.member	@admin:localhost	join
$viSFX8RvY5fe8TiOaDirNG6PqooEHTTV3PT3hrQgVLA	!MrxfbdodytWwBMqNiF:localhost	m.room.encryption		\N
$A5h106ytjQ2qqPxkSylhOkJgVZQCscB4QX0PK60qxU0	!nPrdOOfNMRrmJedabn:localhost	m.room.create		\N
$AMnH95Ky85GttLR7j9XHrHyULlBBezFJ9w8mtji-7Ok	!nPrdOOfNMRrmJedabn:localhost	m.room.member	@admin:localhost	join
$gDW6j_UqhvIRf1ANEKurSD9fB4Hl4YnQ5uL9cy_U7Os	!nPrdOOfNMRrmJedabn:localhost	m.room.power_levels		\N
$0gszMJtyESzwVMh4olwTajdbj1MrrJYVnylO0yOIpSg	!nPrdOOfNMRrmJedabn:localhost	m.room.join_rules		\N
$2lEnFzGdtIu4kGthBBXcP0gW6sUWKP8c1x9I4-yFWso	!nPrdOOfNMRrmJedabn:localhost	m.room.history_visibility		\N
$yfuDQBYjEI6CCa3AdtfdjL_ZXIR0d92TRfHnh7Gq0zc	!nPrdOOfNMRrmJedabn:localhost	m.room.guest_access		\N
$xyV3lysb-dda01bB4LpALdmaTC_mLZDhwxOE9L4zpXY	!nPrdOOfNMRrmJedabn:localhost	m.room.encryption		\N
$MT4EKTmcPC8LCVeATiG-5a71N2Zc1vNQcgKge5W0on8	!MrxfbdodytWwBMqNiF:localhost	m.room.tombstone		\N
$eOC3-FZNb3jb3NisHG61gQhQ_hf9zWu0xvpfs8ZKDTg	!MrxfbdodytWwBMqNiF:localhost	m.room.power_levels		\N
$usag8slAxKA2dWWERksMiBQ8hRwfGZ8nZzTfcymZxyE	!nPrdOOfNMRrmJedabn:localhost	m.room.member	@bridgeuser1:localhost	invite
$O04OV5x9R_5W2IT9G9Z-dXJmfV6fgtZM8-4ogFp9rEw	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@bridgeadmin:localhost	invite
$-QMfwsu75_SWJtzFqIsrFjLgl_XBqF6HcorcUjLTsWY	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@bridgeuser1:localhost	invite
$WsVhQvsUsrFormgSdFA_Z_Io7y9fxZy5juqaM8oYpkg	!LwtGEdNVvQHvFLuWQB:localhost	m.room.member	@admin:localhost	join
$hooKnajA7nQRs3MZDj_evGyHCyHpg4QmGp2i5WRKzp0	!UKcoTBWWxNEyixrjyM:localhost	m.room.member	@matrix_a:localhost	join
$rNG4YvsFCU9LVcVcHEkbBRGSuEH_QqO_hMEZ-sC8WH8	!kAToIwhNWrDpgQVMfY:localhost	m.room.member	@matrix_a:localhost	join
\.


--
-- Data for Name: dehydrated_devices; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.dehydrated_devices (user_id, device_id, device_data) FROM stdin;
\.


--
-- Data for Name: deleted_pushers; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.deleted_pushers (stream_id, app_id, pushkey, user_id) FROM stdin;
\.


--
-- Data for Name: destination_rooms; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.destination_rooms (destination, room_id, stream_ordering) FROM stdin;
\.


--
-- Data for Name: destinations; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.destinations (destination, retry_last_ts, retry_interval, failure_ts, last_successful_stream_ordering) FROM stdin;
\.


--
-- Data for Name: device_federation_inbox; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.device_federation_inbox (origin, message_id, received_ts, instance_name) FROM stdin;
\.


--
-- Data for Name: device_federation_outbox; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.device_federation_outbox (destination, stream_id, queued_ts, messages_json, instance_name) FROM stdin;
\.


--
-- Data for Name: device_inbox; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.device_inbox (user_id, device_id, stream_id, message_json, instance_name) FROM stdin;
\.


--
-- Data for Name: device_lists_outbound_last_success; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.device_lists_outbound_last_success (destination, user_id, stream_id) FROM stdin;
\.


--
-- Data for Name: device_lists_outbound_pokes; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.device_lists_outbound_pokes (destination, stream_id, user_id, device_id, sent, ts, opentracing_context) FROM stdin;
\.


--
-- Data for Name: device_lists_remote_cache; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.device_lists_remote_cache (user_id, device_id, content) FROM stdin;
\.


--
-- Data for Name: device_lists_remote_extremeties; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.device_lists_remote_extremeties (user_id, stream_id) FROM stdin;
\.


--
-- Data for Name: device_lists_remote_resync; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.device_lists_remote_resync (user_id, added_ts) FROM stdin;
\.


--
-- Data for Name: device_lists_stream; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.device_lists_stream (stream_id, user_id, device_id) FROM stdin;
4	@matrix_b:localhost	DJFHSWMXLW
5	@ignored_user:localhost	IYEBBQEXHS
6	@matterbot:localhost	TGXAZUDNDK
7	@mm_mattermost_b:localhost	ACNRXLMSJA
8	@mm_mattermost_a:localhost	RKCHLAOGMQ
9	@bridgeuser1:localhost	INZTQIFTZU
10	@bridgeuser2:localhost	XNALAXQCPK
11	@bridgeadmin:localhost	IFSVAIKQOJ
12	@mm_mattermost_a_:localhost	SNDZBSJQWR
13	@mm_mattermost_b_:localhost	ECAJIABDCN
14	@mm_matrix_matrix_a:localhost	COHLAPFKHD
15	@mm_matrix_matrix_b:localhost	NNNEXFYSII
19	@bridgeuser1:localhost	w5ZDKLgy8s/zJcQqFSakpVOkhfD6wwSCMtHe/A5F8aA
20	@bridgeuser1:localhost	kUDSn4KiZiCcP4F90Ie7lDJI3gZSFG4uvqF0PnghnY0
22	@bridgeuser1:localhost	zteJCkUnxQzhF4okQ2ovjX3zv8nD7hpOQNDT3uD3+28
23	@bridgeuser1:localhost	Wz7fNdlInlfXqnzqgJGh+HWKW8keLaporidKHuX1Ads
25	@bridgeuser1:localhost	Pi4zWwBar7EBJpj8LTyoiMTYINPoeTJKSKNKhT8EBB4
26	@bridgeuser1:localhost	RId/hQ856a8USrG4rkavtsXddR7QzljrGGly47xD4V4
28	@bridgeuser1:localhost	7wDLauQ3qGuLiM/yz8cOXh1qzgpbFAqLgedhD1hu8is
29	@bridgeuser1:localhost	u03Pql5u73F/N964ZJ26zmKPbrtjZs/Rm39VTH4A3tY
30	@bridgeuser1:localhost	PIMRNBVGGO
34	@bridgeadmin:localhost	dqKAfhOmGQIvXvXnGg5bH+5t5rgKR+BeJE+VPoFVIGU
35	@bridgeadmin:localhost	z/xKbsyDSNmvuOpalujggdayEWXkgUVIU36fBpby2ME
36	@bridgeadmin:localhost	XGKLFWVQVO
39	@admin:localhost	WCSUBIGVWG
40	@bridgeadmin:localhost	TZENIQYSDC
44	@admin:localhost	DVCR/jmoMkIGLI7QakrxDtXqIexvGehpu4Uq1FMxGV0
45	@admin:localhost	ScHq9g/TJ8qnEHSaKvQwLofFTzq8QqejbfNMoZITy34
47	@admin:localhost	lcbHJ7rLdyswdQrcP5LKDp/ywqeK0qH2KiDYYGEDV+o
48	@admin:localhost	i2xQ0mj11fflxQ/fm7K2FvX3ox/Co14tutNvZ3fHxuo
49	@admin:localhost	JOEAGREGVO
52	@admin:localhost	KFURKEDWNO
55	@matrix_a:localhost	TKAVEOGKHH
56	@admin:localhost	XEZPTSZEHL
60	@matrix_a:localhost	c/SA1TLAutXhk1/a9/uzmFna0q3Po2h/vMfA1vZQYu4
61	@matrix_a:localhost	d0OZz1jWrDfY2lb+1MjC7s9T4GfO15eg/+BkFaqr3EE
62	@matrix_a:localhost	JHXXJJAPZQ
\.


--
-- Data for Name: devices; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.devices (user_id, device_id, display_name, last_seen, ip, user_agent, hidden) FROM stdin;
@matrix_b:localhost	DJFHSWMXLW	\N	1598686328482	172.21.0.1	curl/7.72.0	f
@ignored_user:localhost	IYEBBQEXHS	\N	1598686328565	172.21.0.1	curl/7.72.0	f
@matterbot:localhost	TGXAZUDNDK	\N	\N	\N	\N	f
@mm_mattermost_b:localhost	ACNRXLMSJA	\N	\N	\N	\N	f
@mm_mattermost_a:localhost	RKCHLAOGMQ	\N	\N	\N	\N	f
@bridgeuser1:localhost	INZTQIFTZU	\N	\N	\N	\N	f
@bridgeuser2:localhost	XNALAXQCPK	\N	\N	\N	\N	f
@mm_mattermost_a_:localhost	SNDZBSJQWR	\N	\N	\N	\N	f
@mm_mattermost_b_:localhost	ECAJIABDCN	\N	\N	\N	\N	f
@mm_matrix_matrix_a:localhost	COHLAPFKHD	\N	\N	\N	\N	f
@mm_matrix_matrix_b:localhost	NNNEXFYSII	\N	\N	\N	\N	f
@bridgeuser1:localhost	w5ZDKLgy8s/zJcQqFSakpVOkhfD6wwSCMtHe/A5F8aA	master signing key	\N	\N	\N	t
@bridgeuser1:localhost	kUDSn4KiZiCcP4F90Ie7lDJI3gZSFG4uvqF0PnghnY0	self_signing signing key	\N	\N	\N	t
@bridgeuser1:localhost	+v/mig1JkHpSzHpyR9St6A3qlLuPyUtaHokfjmG2VHs	user_signing signing key	\N	\N	\N	t
@bridgeuser1:localhost	zteJCkUnxQzhF4okQ2ovjX3zv8nD7hpOQNDT3uD3+28	master signing key	\N	\N	\N	t
@bridgeuser1:localhost	Wz7fNdlInlfXqnzqgJGh+HWKW8keLaporidKHuX1Ads	self_signing signing key	\N	\N	\N	t
@bridgeuser1:localhost	+lduEpQRIXBYvQ8RCKg9jZmJ1CdmMuAokrJKKL+eDrM	user_signing signing key	\N	\N	\N	t
@bridgeuser1:localhost	Pi4zWwBar7EBJpj8LTyoiMTYINPoeTJKSKNKhT8EBB4	master signing key	\N	\N	\N	t
@bridgeuser1:localhost	RId/hQ856a8USrG4rkavtsXddR7QzljrGGly47xD4V4	self_signing signing key	\N	\N	\N	t
@bridgeuser1:localhost	XhMQxqj35FDhaCZnNVL+oOZCPAUgfuNn+MtNZZQ8nK8	user_signing signing key	\N	\N	\N	t
@bridgeuser1:localhost	7wDLauQ3qGuLiM/yz8cOXh1qzgpbFAqLgedhD1hu8is	master signing key	\N	\N	\N	t
@bridgeuser1:localhost	u03Pql5u73F/N964ZJ26zmKPbrtjZs/Rm39VTH4A3tY	self_signing signing key	\N	\N	\N	t
@bridgeuser1:localhost	QDvobzyYRsYpNx3s0RYnvP1MhQ5MNKdXtwhJCn253SU	user_signing signing key	\N	\N	\N	t
@bridgeadmin:localhost	dqKAfhOmGQIvXvXnGg5bH+5t5rgKR+BeJE+VPoFVIGU	master signing key	\N	\N	\N	t
@bridgeadmin:localhost	z/xKbsyDSNmvuOpalujggdayEWXkgUVIU36fBpby2ME	self_signing signing key	\N	\N	\N	t
@bridgeadmin:localhost	uVU15sEWPe/zXTD4cV2nnHjB1OGaLeLoMjHmlYYGvkQ	user_signing signing key	\N	\N	\N	t
@admin:localhost	DVCR/jmoMkIGLI7QakrxDtXqIexvGehpu4Uq1FMxGV0	master signing key	\N	\N	\N	t
@admin:localhost	ScHq9g/TJ8qnEHSaKvQwLofFTzq8QqejbfNMoZITy34	self_signing signing key	\N	\N	\N	t
@admin:localhost	Ym8LVmdxz/2yXY1J1KgJPC3n1DG6S7BaFjIUBweQt8g	user_signing signing key	\N	\N	\N	t
@admin:localhost	lcbHJ7rLdyswdQrcP5LKDp/ywqeK0qH2KiDYYGEDV+o	master signing key	\N	\N	\N	t
@admin:localhost	i2xQ0mj11fflxQ/fm7K2FvX3ox/Co14tutNvZ3fHxuo	self_signing signing key	\N	\N	\N	t
@admin:localhost	A788mplF3RET2tbqgC/nQ6zL1fttwgjq/qWHApnnOxo	user_signing signing key	\N	\N	\N	t
@bridgeadmin:localhost	IFSVAIKQOJ	\N	1672482420441	172.16.238.1	PostmanRuntime/7.29.2	f
@matrix_a:localhost	c/SA1TLAutXhk1/a9/uzmFna0q3Po2h/vMfA1vZQYu4	master signing key	\N	\N	\N	t
@matrix_a:localhost	d0OZz1jWrDfY2lb+1MjC7s9T4GfO15eg/+BkFaqr3EE	self_signing signing key	\N	\N	\N	t
@matrix_a:localhost	BR/OuQr1i9/aFvnwzhUXVJ181B4V8J2E1Afp0KVeCXs	user_signing signing key	\N	\N	\N	t
\.


--
-- Data for Name: e2e_cross_signing_keys; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_cross_signing_keys (user_id, keytype, keydata, stream_id) FROM stdin;
@bridgeuser1:localhost	master	{"user_id":"@bridgeuser1:localhost","usage":["master"],"keys":{"ed25519:w5ZDKLgy8s/zJcQqFSakpVOkhfD6wwSCMtHe/A5F8aA":"w5ZDKLgy8s/zJcQqFSakpVOkhfD6wwSCMtHe/A5F8aA"},"signatures":{"@bridgeuser1:localhost":{"ed25519:PIMRNBVGGO":"IyuxoLNlREwjZeu//gIYNveeCLsX1+uljxmOtL0UqMwR+rgW0/bSS1UJCAafrK7Nsuvw7AC3OU5c+dB7zB7+BQ"}}}	2
@bridgeuser1:localhost	self_signing	{"user_id":"@bridgeuser1:localhost","usage":["self_signing"],"keys":{"ed25519:kUDSn4KiZiCcP4F90Ie7lDJI3gZSFG4uvqF0PnghnY0":"kUDSn4KiZiCcP4F90Ie7lDJI3gZSFG4uvqF0PnghnY0"},"signatures":{"@bridgeuser1:localhost":{"ed25519:w5ZDKLgy8s/zJcQqFSakpVOkhfD6wwSCMtHe/A5F8aA":"zRLXEwsrBYEOfLJerlyd1fcezWwq9DJqrKAJaMckP7lfqBkYzEtRmWeEwdL/pJ3SJJdXYF/uoq386wO4Qg3bAA"}}}	3
@bridgeuser1:localhost	user_signing	{"user_id":"@bridgeuser1:localhost","usage":["user_signing"],"keys":{"ed25519:+v/mig1JkHpSzHpyR9St6A3qlLuPyUtaHokfjmG2VHs":"+v/mig1JkHpSzHpyR9St6A3qlLuPyUtaHokfjmG2VHs"},"signatures":{"@bridgeuser1:localhost":{"ed25519:w5ZDKLgy8s/zJcQqFSakpVOkhfD6wwSCMtHe/A5F8aA":"lWCGxjjiUyEYeMG27+R5OVlt0hMcd/CFX5UmOP8iqOfXx2K8CAvb7POEl2KSA/VhvR3pmqkAokt13XRoYE/cCw"}}}	4
@bridgeuser1:localhost	master	{"user_id":"@bridgeuser1:localhost","usage":["master"],"keys":{"ed25519:zteJCkUnxQzhF4okQ2ovjX3zv8nD7hpOQNDT3uD3+28":"zteJCkUnxQzhF4okQ2ovjX3zv8nD7hpOQNDT3uD3+28"},"signatures":{"@bridgeuser1:localhost":{"ed25519:PIMRNBVGGO":"5GWh6iuhXf3H00Vhir7HWdsQZQKku590m27DQBtaV5uQAKyWpCbADVWXtU4RuRMxzIB+s6jrCsFT1Bl4wii6Ag"}}}	5
@bridgeuser1:localhost	self_signing	{"user_id":"@bridgeuser1:localhost","usage":["self_signing"],"keys":{"ed25519:Wz7fNdlInlfXqnzqgJGh+HWKW8keLaporidKHuX1Ads":"Wz7fNdlInlfXqnzqgJGh+HWKW8keLaporidKHuX1Ads"},"signatures":{"@bridgeuser1:localhost":{"ed25519:zteJCkUnxQzhF4okQ2ovjX3zv8nD7hpOQNDT3uD3+28":"0rSSpp0FvOfLtBqw8wby2urM57uTzJ79uHFPNkwtP6PDrKzfcymrswCQ3zE0gXsYMyy0jW/QfNOMhYIVsTbfDA"}}}	6
@bridgeuser1:localhost	user_signing	{"user_id":"@bridgeuser1:localhost","usage":["user_signing"],"keys":{"ed25519:+lduEpQRIXBYvQ8RCKg9jZmJ1CdmMuAokrJKKL+eDrM":"+lduEpQRIXBYvQ8RCKg9jZmJ1CdmMuAokrJKKL+eDrM"},"signatures":{"@bridgeuser1:localhost":{"ed25519:zteJCkUnxQzhF4okQ2ovjX3zv8nD7hpOQNDT3uD3+28":"1sbVfblsHJP4vjZBUNggoRHsqjSd4dljFug1R4Z2xXSvi9jCf6+q0FmXdrMewomfOZYmv6/1VV5weQYwPHSgDg"}}}	7
@bridgeuser1:localhost	master	{"user_id":"@bridgeuser1:localhost","usage":["master"],"keys":{"ed25519:Pi4zWwBar7EBJpj8LTyoiMTYINPoeTJKSKNKhT8EBB4":"Pi4zWwBar7EBJpj8LTyoiMTYINPoeTJKSKNKhT8EBB4"},"signatures":{"@bridgeuser1:localhost":{"ed25519:PIMRNBVGGO":"O1ve5vzdQPXSM0W7zQjft1EfBR+T+0bHNIJCkZS/4PRz+P8m1MHFQxK5FKNXEQPaS9OQ8OMCLIhXd05x83vHDA"}}}	8
@bridgeuser1:localhost	self_signing	{"user_id":"@bridgeuser1:localhost","usage":["self_signing"],"keys":{"ed25519:RId/hQ856a8USrG4rkavtsXddR7QzljrGGly47xD4V4":"RId/hQ856a8USrG4rkavtsXddR7QzljrGGly47xD4V4"},"signatures":{"@bridgeuser1:localhost":{"ed25519:Pi4zWwBar7EBJpj8LTyoiMTYINPoeTJKSKNKhT8EBB4":"g1e2rTLUnjkZzGi4fL2cpo0JlSfG2dkm6ajfoTbebDUuCAuDz9GzLSqOLN4HGyRmdJHsomQi56cTOv3xGVaZBA"}}}	9
@bridgeuser1:localhost	user_signing	{"user_id":"@bridgeuser1:localhost","usage":["user_signing"],"keys":{"ed25519:XhMQxqj35FDhaCZnNVL+oOZCPAUgfuNn+MtNZZQ8nK8":"XhMQxqj35FDhaCZnNVL+oOZCPAUgfuNn+MtNZZQ8nK8"},"signatures":{"@bridgeuser1:localhost":{"ed25519:Pi4zWwBar7EBJpj8LTyoiMTYINPoeTJKSKNKhT8EBB4":"XLiwWJ2byA/AnIubQrBWGxaa3spauQaPH6iKKhn7SAtguiBpcsAryoZpp044kQn8OyICNFM2dxQGGq8nZOgCDA"}}}	10
@bridgeuser1:localhost	master	{"user_id":"@bridgeuser1:localhost","usage":["master"],"keys":{"ed25519:7wDLauQ3qGuLiM/yz8cOXh1qzgpbFAqLgedhD1hu8is":"7wDLauQ3qGuLiM/yz8cOXh1qzgpbFAqLgedhD1hu8is"},"signatures":{"@bridgeuser1:localhost":{"ed25519:PIMRNBVGGO":"QjRXfg8M9cfuZ9HIhcbRIa14/lQKrbBE1qs+pdp1O9GEof4ag7he+2PMsOjx7gJA+tUXOT5ueRA/hXScYmTfBg"}}}	11
@bridgeuser1:localhost	self_signing	{"user_id":"@bridgeuser1:localhost","usage":["self_signing"],"keys":{"ed25519:u03Pql5u73F/N964ZJ26zmKPbrtjZs/Rm39VTH4A3tY":"u03Pql5u73F/N964ZJ26zmKPbrtjZs/Rm39VTH4A3tY"},"signatures":{"@bridgeuser1:localhost":{"ed25519:7wDLauQ3qGuLiM/yz8cOXh1qzgpbFAqLgedhD1hu8is":"4U7BhBB37uQWJbUkYiQC1XyCEqyCT03lI2vswWrSxKw5vav6RQaJEby4bjCPPw1llUYrAnaJk0cfn12g70YTAg"}}}	12
@bridgeuser1:localhost	user_signing	{"user_id":"@bridgeuser1:localhost","usage":["user_signing"],"keys":{"ed25519:QDvobzyYRsYpNx3s0RYnvP1MhQ5MNKdXtwhJCn253SU":"QDvobzyYRsYpNx3s0RYnvP1MhQ5MNKdXtwhJCn253SU"},"signatures":{"@bridgeuser1:localhost":{"ed25519:7wDLauQ3qGuLiM/yz8cOXh1qzgpbFAqLgedhD1hu8is":"IPU/T8pSl/frRtDpqZVBhL5aoahwMz6PM+5gWyWxS/CWi/oR2+yPcInTdGCv72P3WLcw3ZU5+IOeeuUEoJT2Bw"}}}	13
@bridgeadmin:localhost	master	{"user_id":"@bridgeadmin:localhost","usage":["master"],"keys":{"ed25519:dqKAfhOmGQIvXvXnGg5bH+5t5rgKR+BeJE+VPoFVIGU":"dqKAfhOmGQIvXvXnGg5bH+5t5rgKR+BeJE+VPoFVIGU"},"signatures":{"@bridgeadmin:localhost":{"ed25519:XGKLFWVQVO":"2RmUJhzHxo2vqVJ3Ke4HzQNWrp1/K+MGdrO37lxwpo8ecdiLgvxfwdK9/W7j0MWSYsVkm28M4xMZ6a2QVnjFBA"}}}	14
@bridgeadmin:localhost	self_signing	{"user_id":"@bridgeadmin:localhost","usage":["self_signing"],"keys":{"ed25519:z/xKbsyDSNmvuOpalujggdayEWXkgUVIU36fBpby2ME":"z/xKbsyDSNmvuOpalujggdayEWXkgUVIU36fBpby2ME"},"signatures":{"@bridgeadmin:localhost":{"ed25519:dqKAfhOmGQIvXvXnGg5bH+5t5rgKR+BeJE+VPoFVIGU":"EFXNM0a0Lixpa2QAKIq5JDxoNTP/6Wqq0XgqwwW5Az5Z/DXMvS50ydI+eQZ5R+hstKm7IkuqXwK3gd0ecQXNBQ"}}}	15
@bridgeadmin:localhost	user_signing	{"user_id":"@bridgeadmin:localhost","usage":["user_signing"],"keys":{"ed25519:uVU15sEWPe/zXTD4cV2nnHjB1OGaLeLoMjHmlYYGvkQ":"uVU15sEWPe/zXTD4cV2nnHjB1OGaLeLoMjHmlYYGvkQ"},"signatures":{"@bridgeadmin:localhost":{"ed25519:dqKAfhOmGQIvXvXnGg5bH+5t5rgKR+BeJE+VPoFVIGU":"htgvRCGUR0IfB28Rh/4UQ4LW4WOboBSndRAvtqWNbChFpEvMN4oDI8fRf+GLjz922z/Mf99RR2Vw5k0kg5IAAQ"}}}	16
@admin:localhost	master	{"user_id":"@admin:localhost","usage":["master"],"keys":{"ed25519:DVCR/jmoMkIGLI7QakrxDtXqIexvGehpu4Uq1FMxGV0":"DVCR/jmoMkIGLI7QakrxDtXqIexvGehpu4Uq1FMxGV0"},"signatures":{"@admin:localhost":{"ed25519:JOEAGREGVO":"Fj8mG7sGPl4ymd7kdUjrCmGp5wasguCJhatHzDV8ip+wbMSCgZnzBd83o3OG7DIaoorr3ZZNA/ixFexs7ChKDw"}}}	17
@admin:localhost	self_signing	{"user_id":"@admin:localhost","usage":["self_signing"],"keys":{"ed25519:ScHq9g/TJ8qnEHSaKvQwLofFTzq8QqejbfNMoZITy34":"ScHq9g/TJ8qnEHSaKvQwLofFTzq8QqejbfNMoZITy34"},"signatures":{"@admin:localhost":{"ed25519:DVCR/jmoMkIGLI7QakrxDtXqIexvGehpu4Uq1FMxGV0":"m0GxIIwfiO9/5ojY1y1uOLLHjyHX4QR5Dboo3Nv+FOEly+GirS8MfKnrrbdvC61BQOYK/dAMQ+U+gsrB9b5WDA"}}}	18
@admin:localhost	user_signing	{"user_id":"@admin:localhost","usage":["user_signing"],"keys":{"ed25519:Ym8LVmdxz/2yXY1J1KgJPC3n1DG6S7BaFjIUBweQt8g":"Ym8LVmdxz/2yXY1J1KgJPC3n1DG6S7BaFjIUBweQt8g"},"signatures":{"@admin:localhost":{"ed25519:DVCR/jmoMkIGLI7QakrxDtXqIexvGehpu4Uq1FMxGV0":"ZjXlT9CsE8aB+QnZHwFAlTB+B+D6+I2gfjcyI7DqlCRei7MRTV6TDF7xlMxgnb8Iq8O2mPcCPrbLz3Al+QqdCA"}}}	19
@admin:localhost	master	{"user_id":"@admin:localhost","usage":["master"],"keys":{"ed25519:lcbHJ7rLdyswdQrcP5LKDp/ywqeK0qH2KiDYYGEDV+o":"lcbHJ7rLdyswdQrcP5LKDp/ywqeK0qH2KiDYYGEDV+o"},"signatures":{"@admin:localhost":{"ed25519:JOEAGREGVO":"+zgrSmcc03ori6umVlW5stnfTjp0lNd/bG1pgjaT/BjCyrpKbNd92LuJzhlH8yz0zIKv/aULP0Dic+QfZesDCg"}}}	20
@admin:localhost	self_signing	{"user_id":"@admin:localhost","usage":["self_signing"],"keys":{"ed25519:i2xQ0mj11fflxQ/fm7K2FvX3ox/Co14tutNvZ3fHxuo":"i2xQ0mj11fflxQ/fm7K2FvX3ox/Co14tutNvZ3fHxuo"},"signatures":{"@admin:localhost":{"ed25519:lcbHJ7rLdyswdQrcP5LKDp/ywqeK0qH2KiDYYGEDV+o":"hZ/lE4Rp6P4hgc3wmePjSK1pHXFrPPMTnJzYRojx3+wqyuPA+2nwOYuoomtjnuTXg0loSx8C4MOg7mwYdmYoAQ"}}}	21
@admin:localhost	user_signing	{"user_id":"@admin:localhost","usage":["user_signing"],"keys":{"ed25519:A788mplF3RET2tbqgC/nQ6zL1fttwgjq/qWHApnnOxo":"A788mplF3RET2tbqgC/nQ6zL1fttwgjq/qWHApnnOxo"},"signatures":{"@admin:localhost":{"ed25519:lcbHJ7rLdyswdQrcP5LKDp/ywqeK0qH2KiDYYGEDV+o":"B2tOqiLgHFBmGMRe8QON2CT1Ym77VOqgWYg5aJMelJH3FCYW4m0IFrM5+dBJVFT7ENVnrdavb4KRRRHRh2pcDQ"}}}	22
@matrix_a:localhost	master	{"user_id":"@matrix_a:localhost","usage":["master"],"keys":{"ed25519:c/SA1TLAutXhk1/a9/uzmFna0q3Po2h/vMfA1vZQYu4":"c/SA1TLAutXhk1/a9/uzmFna0q3Po2h/vMfA1vZQYu4"},"signatures":{"@matrix_a:localhost":{"ed25519:JHXXJJAPZQ":"xTXXttvPLNbtMkh7kJ2nwcldfS/fJxUwnxfVn7RvUWh+qsJkG2gRWucPUY9Mu/mkeoXbNv0FqrAFMt5fD1oHCw"}}}	23
@matrix_a:localhost	self_signing	{"user_id":"@matrix_a:localhost","usage":["self_signing"],"keys":{"ed25519:d0OZz1jWrDfY2lb+1MjC7s9T4GfO15eg/+BkFaqr3EE":"d0OZz1jWrDfY2lb+1MjC7s9T4GfO15eg/+BkFaqr3EE"},"signatures":{"@matrix_a:localhost":{"ed25519:c/SA1TLAutXhk1/a9/uzmFna0q3Po2h/vMfA1vZQYu4":"LJ/D1kxo/ijX1Aj+XqebZGY8UXOyAR3vgm7GJ3UuE7ClqsyjYGX+R3gnY4wZ5kXZuNO129RfA1Scq5s9qr0IDg"}}}	24
@matrix_a:localhost	user_signing	{"user_id":"@matrix_a:localhost","usage":["user_signing"],"keys":{"ed25519:BR/OuQr1i9/aFvnwzhUXVJ181B4V8J2E1Afp0KVeCXs":"BR/OuQr1i9/aFvnwzhUXVJ181B4V8J2E1Afp0KVeCXs"},"signatures":{"@matrix_a:localhost":{"ed25519:c/SA1TLAutXhk1/a9/uzmFna0q3Po2h/vMfA1vZQYu4":"HYPYfySV3C9gS5Yt9p0ouINlsmfGCmCJE95dUwOCSboPn0soRJnwbcrUwhXcoxg0OVpMKlqrrvSN0umNLb8oDQ"}}}	25
\.


--
-- Data for Name: e2e_cross_signing_signatures; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_cross_signing_signatures (user_id, key_id, target_user_id, target_device_id, signature) FROM stdin;
\.


--
-- Data for Name: e2e_device_keys_json; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_device_keys_json (user_id, device_id, ts_added_ms, key_json) FROM stdin;
\.


--
-- Data for Name: e2e_fallback_keys_json; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_fallback_keys_json (user_id, device_id, algorithm, key_id, key_json, used) FROM stdin;
\.


--
-- Data for Name: e2e_one_time_keys_json; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_one_time_keys_json (user_id, device_id, algorithm, key_id, ts_added_ms, key_json) FROM stdin;
\.


--
-- Data for Name: e2e_room_keys; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_room_keys (user_id, room_id, session_id, version, first_message_index, forwarded_count, is_verified, session_data) FROM stdin;
\.


--
-- Data for Name: e2e_room_keys_versions; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_room_keys_versions (user_id, version, algorithm, auth_data, deleted, etag) FROM stdin;
\.


--
-- Data for Name: erased_users; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.erased_users (user_id) FROM stdin;
\.


--
-- Data for Name: event_auth; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_auth (event_id, auth_id, room_id) FROM stdin;
$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw	!kmbTYjjsDRDHGgVqUP:localhost
$X8tdoEsXAgBC6gobCepAn3rwO8CJoQU6i9NN9Rzhukg	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$X8tdoEsXAgBC6gobCepAn3rwO8CJoQU6i9NN9Rzhukg	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$X8tdoEsXAgBC6gobCepAn3rwO8CJoQU6i9NN9Rzhukg	$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw	!kmbTYjjsDRDHGgVqUP:localhost
$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw	!kmbTYjjsDRDHGgVqUP:localhost
$O5iO4EII22igkDq5cMKHFB-SGIYD0KqJQXZohS2Dzc0	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$O5iO4EII22igkDq5cMKHFB-SGIYD0KqJQXZohS2Dzc0	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$O5iO4EII22igkDq5cMKHFB-SGIYD0KqJQXZohS2Dzc0	$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw	!kmbTYjjsDRDHGgVqUP:localhost
$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA	!dKcbdDATuwwphjRPQP:localhost
$b__a7rX3L5YpX7nAZte73DAbjtXZK48JH8VKSnGOKKw	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$b__a7rX3L5YpX7nAZte73DAbjtXZK48JH8VKSnGOKKw	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$b__a7rX3L5YpX7nAZte73DAbjtXZK48JH8VKSnGOKKw	$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA	!dKcbdDATuwwphjRPQP:localhost
$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA	!dKcbdDATuwwphjRPQP:localhost
$TVnvv0nGbLydCBtMmTTz-htMsoI4hmxCr3s9AHyFGHQ	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$TVnvv0nGbLydCBtMmTTz-htMsoI4hmxCr3s9AHyFGHQ	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$TVnvv0nGbLydCBtMmTTz-htMsoI4hmxCr3s9AHyFGHQ	$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA	!dKcbdDATuwwphjRPQP:localhost
$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$7TwPfUMTevEcf7wLvbgx3LG01lYT_yGudYiOVlkGU7E	$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ	!dKcbdDATuwwphjRPQP:localhost
$7TwPfUMTevEcf7wLvbgx3LG01lYT_yGudYiOVlkGU7E	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$7TwPfUMTevEcf7wLvbgx3LG01lYT_yGudYiOVlkGU7E	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$7TwPfUMTevEcf7wLvbgx3LG01lYT_yGudYiOVlkGU7E	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$jAifmicJfMyB1QPFQ6KFQ7ZqTqQ58RJXsH5viWn3ZUg	$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok	!kmbTYjjsDRDHGgVqUP:localhost
$jAifmicJfMyB1QPFQ6KFQ7ZqTqQ58RJXsH5viWn3ZUg	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$jAifmicJfMyB1QPFQ6KFQ7ZqTqQ58RJXsH5viWn3ZUg	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$jAifmicJfMyB1QPFQ6KFQ7ZqTqQ58RJXsH5viWn3ZUg	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$DsZXxk2rEIB2tF3pYUdOPjrMwclo8BXltutiWCnKUIU	$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ	!dKcbdDATuwwphjRPQP:localhost
$DsZXxk2rEIB2tF3pYUdOPjrMwclo8BXltutiWCnKUIU	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$DsZXxk2rEIB2tF3pYUdOPjrMwclo8BXltutiWCnKUIU	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$DsZXxk2rEIB2tF3pYUdOPjrMwclo8BXltutiWCnKUIU	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$NyVGoA-ZaMPbk_RzpmLOajRS1nEBirO7Du2KpA9Eo64	$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok	!kmbTYjjsDRDHGgVqUP:localhost
$NyVGoA-ZaMPbk_RzpmLOajRS1nEBirO7Du2KpA9Eo64	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$NyVGoA-ZaMPbk_RzpmLOajRS1nEBirO7Du2KpA9Eo64	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$NyVGoA-ZaMPbk_RzpmLOajRS1nEBirO7Du2KpA9Eo64	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$JwL8EK5sa4vg29tclnHwa5jrpCTa8oZVOIsgFyivQdY	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$JwL8EK5sa4vg29tclnHwa5jrpCTa8oZVOIsgFyivQdY	$7TwPfUMTevEcf7wLvbgx3LG01lYT_yGudYiOVlkGU7E	!dKcbdDATuwwphjRPQP:localhost
$JwL8EK5sa4vg29tclnHwa5jrpCTa8oZVOIsgFyivQdY	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$JwL8EK5sa4vg29tclnHwa5jrpCTa8oZVOIsgFyivQdY	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$JcoTJcBGASUqIK9V7j6ND5Jt6P9gdbNJxXxQBZNg8z4	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$JcoTJcBGASUqIK9V7j6ND5Jt6P9gdbNJxXxQBZNg8z4	$jAifmicJfMyB1QPFQ6KFQ7ZqTqQ58RJXsH5viWn3ZUg	!kmbTYjjsDRDHGgVqUP:localhost
$JcoTJcBGASUqIK9V7j6ND5Jt6P9gdbNJxXxQBZNg8z4	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$JcoTJcBGASUqIK9V7j6ND5Jt6P9gdbNJxXxQBZNg8z4	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$2KnXfE3sZw8LDrOAaEP4HdQuw5neshhvyZKtnwo5cg0	$DsZXxk2rEIB2tF3pYUdOPjrMwclo8BXltutiWCnKUIU	!dKcbdDATuwwphjRPQP:localhost
$2KnXfE3sZw8LDrOAaEP4HdQuw5neshhvyZKtnwo5cg0	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$2KnXfE3sZw8LDrOAaEP4HdQuw5neshhvyZKtnwo5cg0	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$2KnXfE3sZw8LDrOAaEP4HdQuw5neshhvyZKtnwo5cg0	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$isXWKf_B_7Z7R7jYn_2gZB-U31TuzMehBRxj5701Lq8	$NyVGoA-ZaMPbk_RzpmLOajRS1nEBirO7Du2KpA9Eo64	!kmbTYjjsDRDHGgVqUP:localhost
$isXWKf_B_7Z7R7jYn_2gZB-U31TuzMehBRxj5701Lq8	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$isXWKf_B_7Z7R7jYn_2gZB-U31TuzMehBRxj5701Lq8	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$isXWKf_B_7Z7R7jYn_2gZB-U31TuzMehBRxj5701Lq8	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$rVK77mVSpz5EHxI2mbLxilqbkLxKhXEiusPFjapVPbw	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$rVK77mVSpz5EHxI2mbLxilqbkLxKhXEiusPFjapVPbw	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$rVK77mVSpz5EHxI2mbLxilqbkLxKhXEiusPFjapVPbw	$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok	!kmbTYjjsDRDHGgVqUP:localhost
$rVK77mVSpz5EHxI2mbLxilqbkLxKhXEiusPFjapVPbw	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$5agO4kI6VqJHGKvKbkqUa2Y3cTwUBrjAhmCVtj9JmKU	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$5agO4kI6VqJHGKvKbkqUa2Y3cTwUBrjAhmCVtj9JmKU	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$5agO4kI6VqJHGKvKbkqUa2Y3cTwUBrjAhmCVtj9JmKU	$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok	!kmbTYjjsDRDHGgVqUP:localhost
$5agO4kI6VqJHGKvKbkqUa2Y3cTwUBrjAhmCVtj9JmKU	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$4JiNeQHyMbyuEfymLkE-SEzPUh3bWddjxa6-5w36nJw	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$4JiNeQHyMbyuEfymLkE-SEzPUh3bWddjxa6-5w36nJw	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$4JiNeQHyMbyuEfymLkE-SEzPUh3bWddjxa6-5w36nJw	$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ	!dKcbdDATuwwphjRPQP:localhost
$4JiNeQHyMbyuEfymLkE-SEzPUh3bWddjxa6-5w36nJw	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$Y_S-fF0iLu0OHNMcZdYVzt0we_qL_t8_4QIKGeobLdI	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$Y_S-fF0iLu0OHNMcZdYVzt0we_qL_t8_4QIKGeobLdI	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$Y_S-fF0iLu0OHNMcZdYVzt0we_qL_t8_4QIKGeobLdI	$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok	!kmbTYjjsDRDHGgVqUP:localhost
$Y_S-fF0iLu0OHNMcZdYVzt0we_qL_t8_4QIKGeobLdI	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$g1kV-jEZBtN9l6VGGo2MN-wQn7RR7J-Tv5LfyJ5Z5fc	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$g1kV-jEZBtN9l6VGGo2MN-wQn7RR7J-Tv5LfyJ5Z5fc	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$g1kV-jEZBtN9l6VGGo2MN-wQn7RR7J-Tv5LfyJ5Z5fc	$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ	!dKcbdDATuwwphjRPQP:localhost
$g1kV-jEZBtN9l6VGGo2MN-wQn7RR7J-Tv5LfyJ5Z5fc	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$CQg_jKvdpWFvaiLH2f5MtTnu1Zwxi8P4QPSJZum91dw	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$CQg_jKvdpWFvaiLH2f5MtTnu1Zwxi8P4QPSJZum91dw	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$CQg_jKvdpWFvaiLH2f5MtTnu1Zwxi8P4QPSJZum91dw	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$CQg_jKvdpWFvaiLH2f5MtTnu1Zwxi8P4QPSJZum91dw	$rVK77mVSpz5EHxI2mbLxilqbkLxKhXEiusPFjapVPbw	!kmbTYjjsDRDHGgVqUP:localhost
$OcvCF7YNeTKFnzz4EWVjFJIF9QidMEUmomHIvH3d2W8	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$OcvCF7YNeTKFnzz4EWVjFJIF9QidMEUmomHIvH3d2W8	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$OcvCF7YNeTKFnzz4EWVjFJIF9QidMEUmomHIvH3d2W8	$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ	!dKcbdDATuwwphjRPQP:localhost
$OcvCF7YNeTKFnzz4EWVjFJIF9QidMEUmomHIvH3d2W8	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$GrqoJ52XSgRaoc4wPEYLdL2p6t3jl0aiFd8bYswQQcU	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$GrqoJ52XSgRaoc4wPEYLdL2p6t3jl0aiFd8bYswQQcU	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$GrqoJ52XSgRaoc4wPEYLdL2p6t3jl0aiFd8bYswQQcU	$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok	!kmbTYjjsDRDHGgVqUP:localhost
$GrqoJ52XSgRaoc4wPEYLdL2p6t3jl0aiFd8bYswQQcU	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$5TE1hAtSTolrY9QTj9Wt8DnKurFa3P6KIfGkWOJbrY4	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$5TE1hAtSTolrY9QTj9Wt8DnKurFa3P6KIfGkWOJbrY4	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$5TE1hAtSTolrY9QTj9Wt8DnKurFa3P6KIfGkWOJbrY4	$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ	!dKcbdDATuwwphjRPQP:localhost
$5TE1hAtSTolrY9QTj9Wt8DnKurFa3P6KIfGkWOJbrY4	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$0WsTO-QKZzqtMdl5UwGJc5h4e7YAE5ZGp_GDMb9K824	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$0WsTO-QKZzqtMdl5UwGJc5h4e7YAE5ZGp_GDMb9K824	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$0WsTO-QKZzqtMdl5UwGJc5h4e7YAE5ZGp_GDMb9K824	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$0WsTO-QKZzqtMdl5UwGJc5h4e7YAE5ZGp_GDMb9K824	$5TE1hAtSTolrY9QTj9Wt8DnKurFa3P6KIfGkWOJbrY4	!dKcbdDATuwwphjRPQP:localhost
$opS4sT6APXaq4vDdegPq6ik1z-yX-FkMTAqhGtTWXEE	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$opS4sT6APXaq4vDdegPq6ik1z-yX-FkMTAqhGtTWXEE	$isXWKf_B_7Z7R7jYn_2gZB-U31TuzMehBRxj5701Lq8	!kmbTYjjsDRDHGgVqUP:localhost
$opS4sT6APXaq4vDdegPq6ik1z-yX-FkMTAqhGtTWXEE	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$UYXKiTPqFr31PwoZzi35ODpdRK0hwJVjVGC1N7kR7yk	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$UYXKiTPqFr31PwoZzi35ODpdRK0hwJVjVGC1N7kR7yk	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$UYXKiTPqFr31PwoZzi35ODpdRK0hwJVjVGC1N7kR7yk	$5agO4kI6VqJHGKvKbkqUa2Y3cTwUBrjAhmCVtj9JmKU	!kmbTYjjsDRDHGgVqUP:localhost
$UYXKiTPqFr31PwoZzi35ODpdRK0hwJVjVGC1N7kR7yk	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$YFCWkh6b_jgrSjje7vt6JB6-uLPRz7Na1VgGh0PwdI8	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$YFCWkh6b_jgrSjje7vt6JB6-uLPRz7Na1VgGh0PwdI8	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$YFCWkh6b_jgrSjje7vt6JB6-uLPRz7Na1VgGh0PwdI8	$4JiNeQHyMbyuEfymLkE-SEzPUh3bWddjxa6-5w36nJw	!dKcbdDATuwwphjRPQP:localhost
$YFCWkh6b_jgrSjje7vt6JB6-uLPRz7Na1VgGh0PwdI8	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$h2yGPxzdKWUBUSFQiOgFiRoNa8NgWHYXdy_2SMJx6ns	$Y_S-fF0iLu0OHNMcZdYVzt0we_qL_t8_4QIKGeobLdI	!kmbTYjjsDRDHGgVqUP:localhost
$h2yGPxzdKWUBUSFQiOgFiRoNa8NgWHYXdy_2SMJx6ns	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$h2yGPxzdKWUBUSFQiOgFiRoNa8NgWHYXdy_2SMJx6ns	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$h2yGPxzdKWUBUSFQiOgFiRoNa8NgWHYXdy_2SMJx6ns	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$jvwVmkElpx8M62JlaBz7nJ4qa2U8tVO7V9-HhJ-n8JI	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$jvwVmkElpx8M62JlaBz7nJ4qa2U8tVO7V9-HhJ-n8JI	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$jvwVmkElpx8M62JlaBz7nJ4qa2U8tVO7V9-HhJ-n8JI	$JcoTJcBGASUqIK9V7j6ND5Jt6P9gdbNJxXxQBZNg8z4	!kmbTYjjsDRDHGgVqUP:localhost
$kmvnPONhcKxIpG62sV6apngYToshpP0mBrwpKL0hAOI	$g1kV-jEZBtN9l6VGGo2MN-wQn7RR7J-Tv5LfyJ5Z5fc	!dKcbdDATuwwphjRPQP:localhost
$kmvnPONhcKxIpG62sV6apngYToshpP0mBrwpKL0hAOI	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$kmvnPONhcKxIpG62sV6apngYToshpP0mBrwpKL0hAOI	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$kmvnPONhcKxIpG62sV6apngYToshpP0mBrwpKL0hAOI	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$KgpvpFIMQIVFvm0adBZqAbWANmMgdu1_1jbP71RuM48	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$KgpvpFIMQIVFvm0adBZqAbWANmMgdu1_1jbP71RuM48	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$KgpvpFIMQIVFvm0adBZqAbWANmMgdu1_1jbP71RuM48	$GrqoJ52XSgRaoc4wPEYLdL2p6t3jl0aiFd8bYswQQcU	!kmbTYjjsDRDHGgVqUP:localhost
$KgpvpFIMQIVFvm0adBZqAbWANmMgdu1_1jbP71RuM48	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$NxuVtjeVql0_aadDlNux0yeeR_PxcpcJPnX1SdoDmXM	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$NxuVtjeVql0_aadDlNux0yeeR_PxcpcJPnX1SdoDmXM	$2KnXfE3sZw8LDrOAaEP4HdQuw5neshhvyZKtnwo5cg0	!dKcbdDATuwwphjRPQP:localhost
$NxuVtjeVql0_aadDlNux0yeeR_PxcpcJPnX1SdoDmXM	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$qWi32T1tK2APgSwc4y_6f0e_N_fUPmIBxC5ACk1h6NM	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$qWi32T1tK2APgSwc4y_6f0e_N_fUPmIBxC5ACk1h6NM	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$qWi32T1tK2APgSwc4y_6f0e_N_fUPmIBxC5ACk1h6NM	$OcvCF7YNeTKFnzz4EWVjFJIF9QidMEUmomHIvH3d2W8	!dKcbdDATuwwphjRPQP:localhost
$qWi32T1tK2APgSwc4y_6f0e_N_fUPmIBxC5ACk1h6NM	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$l5dYt-R2kpcKdlmMRFnzC5N9PjiV4DZ63c1bTGPOCXk	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$l5dYt-R2kpcKdlmMRFnzC5N9PjiV4DZ63c1bTGPOCXk	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$l5dYt-R2kpcKdlmMRFnzC5N9PjiV4DZ63c1bTGPOCXk	$JwL8EK5sa4vg29tclnHwa5jrpCTa8oZVOIsgFyivQdY	!dKcbdDATuwwphjRPQP:localhost
$89n67RlAmtb8nRuxie-oq3g9grnkpjzJMAhbJ8h_8Xw	$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY	!MrxfbdodytWwBMqNiF:localhost
$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA	$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY	!MrxfbdodytWwBMqNiF:localhost
$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA	$89n67RlAmtb8nRuxie-oq3g9grnkpjzJMAhbJ8h_8Xw	!MrxfbdodytWwBMqNiF:localhost
$TVXtgqtZ5WfNfZEnJQx6m0NYwp0_34ylOK87XzZ3JlI	$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY	!MrxfbdodytWwBMqNiF:localhost
$TVXtgqtZ5WfNfZEnJQx6m0NYwp0_34ylOK87XzZ3JlI	$89n67RlAmtb8nRuxie-oq3g9grnkpjzJMAhbJ8h_8Xw	!MrxfbdodytWwBMqNiF:localhost
$TVXtgqtZ5WfNfZEnJQx6m0NYwp0_34ylOK87XzZ3JlI	$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA	!MrxfbdodytWwBMqNiF:localhost
$JQ7PDbgzTTAY5uHFM6NV0ovadfzQLOpcAcrSX5mRUi0	$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY	!MrxfbdodytWwBMqNiF:localhost
$JQ7PDbgzTTAY5uHFM6NV0ovadfzQLOpcAcrSX5mRUi0	$89n67RlAmtb8nRuxie-oq3g9grnkpjzJMAhbJ8h_8Xw	!MrxfbdodytWwBMqNiF:localhost
$JQ7PDbgzTTAY5uHFM6NV0ovadfzQLOpcAcrSX5mRUi0	$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA	!MrxfbdodytWwBMqNiF:localhost
$9MVFB3q88VYxhDZMX087Uv4c3h3uEpluJN0q33ubtso	$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY	!MrxfbdodytWwBMqNiF:localhost
$9MVFB3q88VYxhDZMX087Uv4c3h3uEpluJN0q33ubtso	$89n67RlAmtb8nRuxie-oq3g9grnkpjzJMAhbJ8h_8Xw	!MrxfbdodytWwBMqNiF:localhost
$9MVFB3q88VYxhDZMX087Uv4c3h3uEpluJN0q33ubtso	$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA	!MrxfbdodytWwBMqNiF:localhost
$V_QrTFMCwHlrg-MSVVplcYCRVWM_QgXhIvp-2R_LtHI	$89n67RlAmtb8nRuxie-oq3g9grnkpjzJMAhbJ8h_8Xw	!MrxfbdodytWwBMqNiF:localhost
$V_QrTFMCwHlrg-MSVVplcYCRVWM_QgXhIvp-2R_LtHI	$TVXtgqtZ5WfNfZEnJQx6m0NYwp0_34ylOK87XzZ3JlI	!MrxfbdodytWwBMqNiF:localhost
$V_QrTFMCwHlrg-MSVVplcYCRVWM_QgXhIvp-2R_LtHI	$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY	!MrxfbdodytWwBMqNiF:localhost
$V_QrTFMCwHlrg-MSVVplcYCRVWM_QgXhIvp-2R_LtHI	$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA	!MrxfbdodytWwBMqNiF:localhost
$sqtTmHJJ_e6UeDKORkztLzcGXYNZpKgoa1v2ir5yr-w	$yZwQJfxjuLFOlfyTYw-M1aupZjmck-aVfpfSYx5fj1I	!UKcoTBWWxNEyixrjyM:localhost
$EsIKBNaGky9gjqListPEKjQfFScHFrG5GuEQD0vyi9Q	$yZwQJfxjuLFOlfyTYw-M1aupZjmck-aVfpfSYx5fj1I	!UKcoTBWWxNEyixrjyM:localhost
$EsIKBNaGky9gjqListPEKjQfFScHFrG5GuEQD0vyi9Q	$sqtTmHJJ_e6UeDKORkztLzcGXYNZpKgoa1v2ir5yr-w	!UKcoTBWWxNEyixrjyM:localhost
$STt_lRcQQY1HR2YQmv4RsQMis1Xc5sWAamnHn02ddqk	$yZwQJfxjuLFOlfyTYw-M1aupZjmck-aVfpfSYx5fj1I	!UKcoTBWWxNEyixrjyM:localhost
$STt_lRcQQY1HR2YQmv4RsQMis1Xc5sWAamnHn02ddqk	$sqtTmHJJ_e6UeDKORkztLzcGXYNZpKgoa1v2ir5yr-w	!UKcoTBWWxNEyixrjyM:localhost
$STt_lRcQQY1HR2YQmv4RsQMis1Xc5sWAamnHn02ddqk	$EsIKBNaGky9gjqListPEKjQfFScHFrG5GuEQD0vyi9Q	!UKcoTBWWxNEyixrjyM:localhost
$KEhwfKMs0OrXZWYNQWK_YDu-mrG-UP2Do2VsAShloEY	$yZwQJfxjuLFOlfyTYw-M1aupZjmck-aVfpfSYx5fj1I	!UKcoTBWWxNEyixrjyM:localhost
$KEhwfKMs0OrXZWYNQWK_YDu-mrG-UP2Do2VsAShloEY	$sqtTmHJJ_e6UeDKORkztLzcGXYNZpKgoa1v2ir5yr-w	!UKcoTBWWxNEyixrjyM:localhost
$KEhwfKMs0OrXZWYNQWK_YDu-mrG-UP2Do2VsAShloEY	$EsIKBNaGky9gjqListPEKjQfFScHFrG5GuEQD0vyi9Q	!UKcoTBWWxNEyixrjyM:localhost
$em_2PzgnditDYAzn8yY84PnmN1oNQZgI8Co6SjahtU8	$yZwQJfxjuLFOlfyTYw-M1aupZjmck-aVfpfSYx5fj1I	!UKcoTBWWxNEyixrjyM:localhost
$em_2PzgnditDYAzn8yY84PnmN1oNQZgI8Co6SjahtU8	$sqtTmHJJ_e6UeDKORkztLzcGXYNZpKgoa1v2ir5yr-w	!UKcoTBWWxNEyixrjyM:localhost
$em_2PzgnditDYAzn8yY84PnmN1oNQZgI8Co6SjahtU8	$EsIKBNaGky9gjqListPEKjQfFScHFrG5GuEQD0vyi9Q	!UKcoTBWWxNEyixrjyM:localhost
$sdrkpiq94MhqjrSukg-aexI_3VlPxcoqiZXmrPvpQGw	$sqtTmHJJ_e6UeDKORkztLzcGXYNZpKgoa1v2ir5yr-w	!UKcoTBWWxNEyixrjyM:localhost
$sdrkpiq94MhqjrSukg-aexI_3VlPxcoqiZXmrPvpQGw	$STt_lRcQQY1HR2YQmv4RsQMis1Xc5sWAamnHn02ddqk	!UKcoTBWWxNEyixrjyM:localhost
$sdrkpiq94MhqjrSukg-aexI_3VlPxcoqiZXmrPvpQGw	$yZwQJfxjuLFOlfyTYw-M1aupZjmck-aVfpfSYx5fj1I	!UKcoTBWWxNEyixrjyM:localhost
$sdrkpiq94MhqjrSukg-aexI_3VlPxcoqiZXmrPvpQGw	$EsIKBNaGky9gjqListPEKjQfFScHFrG5GuEQD0vyi9Q	!UKcoTBWWxNEyixrjyM:localhost
$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE	$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw	!kAToIwhNWrDpgQVMfY:localhost
$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc	$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw	!kAToIwhNWrDpgQVMfY:localhost
$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc	$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE	!kAToIwhNWrDpgQVMfY:localhost
$fZAJc_jo3uwpjSNh7ULQOuzuMtHLVO8KdmygXkq-95M	$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw	!kAToIwhNWrDpgQVMfY:localhost
$fZAJc_jo3uwpjSNh7ULQOuzuMtHLVO8KdmygXkq-95M	$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc	!kAToIwhNWrDpgQVMfY:localhost
$fZAJc_jo3uwpjSNh7ULQOuzuMtHLVO8KdmygXkq-95M	$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE	!kAToIwhNWrDpgQVMfY:localhost
$KGv2op0D-6TOpQuqb5Gl4YZxMUKn37cUNSylMiEo7SA	$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw	!kAToIwhNWrDpgQVMfY:localhost
$KGv2op0D-6TOpQuqb5Gl4YZxMUKn37cUNSylMiEo7SA	$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc	!kAToIwhNWrDpgQVMfY:localhost
$KGv2op0D-6TOpQuqb5Gl4YZxMUKn37cUNSylMiEo7SA	$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE	!kAToIwhNWrDpgQVMfY:localhost
$XvSaPVUaER3JwP1gLc-c__oVTIjGs5YL10o0DSsZ3q0	$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw	!kAToIwhNWrDpgQVMfY:localhost
$XvSaPVUaER3JwP1gLc-c__oVTIjGs5YL10o0DSsZ3q0	$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc	!kAToIwhNWrDpgQVMfY:localhost
$XvSaPVUaER3JwP1gLc-c__oVTIjGs5YL10o0DSsZ3q0	$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE	!kAToIwhNWrDpgQVMfY:localhost
$zHrY9OvLbZTtN0bNPCDJg1HsmkgSV-pzAmxVIqaSB98	$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw	!kAToIwhNWrDpgQVMfY:localhost
$zHrY9OvLbZTtN0bNPCDJg1HsmkgSV-pzAmxVIqaSB98	$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc	!kAToIwhNWrDpgQVMfY:localhost
$zHrY9OvLbZTtN0bNPCDJg1HsmkgSV-pzAmxVIqaSB98	$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE	!kAToIwhNWrDpgQVMfY:localhost
$Np7HQ3SdNiYX3HhRJtJw4b80J96uY_IbqI_bL7w83m0	$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw	!kAToIwhNWrDpgQVMfY:localhost
$Np7HQ3SdNiYX3HhRJtJw4b80J96uY_IbqI_bL7w83m0	$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc	!kAToIwhNWrDpgQVMfY:localhost
$Np7HQ3SdNiYX3HhRJtJw4b80J96uY_IbqI_bL7w83m0	$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE	!kAToIwhNWrDpgQVMfY:localhost
$nL-1meDVcMfCo41V5V5w3EBPwNdmll7Alfsp00QCHvk	$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw	!kAToIwhNWrDpgQVMfY:localhost
$nL-1meDVcMfCo41V5V5w3EBPwNdmll7Alfsp00QCHvk	$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc	!kAToIwhNWrDpgQVMfY:localhost
$nL-1meDVcMfCo41V5V5w3EBPwNdmll7Alfsp00QCHvk	$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE	!kAToIwhNWrDpgQVMfY:localhost
$zxy8zKV-5WiZDQEOGVCLyrd2yGWyYrOah4vQYAlc-xI	$wTlWqRh3eGNrru9CGqbzkNcL0kBGbtEB8sHZwsAboS0	!ffaaxOMHcWnINEXTWK:localhost
$zxy8zKV-5WiZDQEOGVCLyrd2yGWyYrOah4vQYAlc-xI	$pn5NPm28AfF5_169OnQQxTv4_ijcoN4k44UIvzGsN7k	!ffaaxOMHcWnINEXTWK:localhost
$zxy8zKV-5WiZDQEOGVCLyrd2yGWyYrOah4vQYAlc-xI	$81gCIX2tUwDG_Jg02kHVceEfsUG1IOQ9-YnDk1cV15w	!ffaaxOMHcWnINEXTWK:localhost
$tWJ40KRMdaZwn6df_597mz_AyHLHUSEy0noQk3HlctY	$wTlWqRh3eGNrru9CGqbzkNcL0kBGbtEB8sHZwsAboS0	!ffaaxOMHcWnINEXTWK:localhost
$tWJ40KRMdaZwn6df_597mz_AyHLHUSEy0noQk3HlctY	$pn5NPm28AfF5_169OnQQxTv4_ijcoN4k44UIvzGsN7k	!ffaaxOMHcWnINEXTWK:localhost
$tWJ40KRMdaZwn6df_597mz_AyHLHUSEy0noQk3HlctY	$81gCIX2tUwDG_Jg02kHVceEfsUG1IOQ9-YnDk1cV15w	!ffaaxOMHcWnINEXTWK:localhost
$bFxX1nACgPihIeXfSiWHmW_hxrfmIgtQM9HWAPS2wVY	$KGv2op0D-6TOpQuqb5Gl4YZxMUKn37cUNSylMiEo7SA	!kAToIwhNWrDpgQVMfY:localhost
$bFxX1nACgPihIeXfSiWHmW_hxrfmIgtQM9HWAPS2wVY	$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE	!kAToIwhNWrDpgQVMfY:localhost
$bFxX1nACgPihIeXfSiWHmW_hxrfmIgtQM9HWAPS2wVY	$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw	!kAToIwhNWrDpgQVMfY:localhost
$bFxX1nACgPihIeXfSiWHmW_hxrfmIgtQM9HWAPS2wVY	$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc	!kAToIwhNWrDpgQVMfY:localhost
$81gCIX2tUwDG_Jg02kHVceEfsUG1IOQ9-YnDk1cV15w	$wTlWqRh3eGNrru9CGqbzkNcL0kBGbtEB8sHZwsAboS0	!ffaaxOMHcWnINEXTWK:localhost
$ab5rFOQQuDGj00oHfJaJKURhG6lNFNDKS0nkBlsLTMk	$AXgBEWEnQYL0m4F3qNGi4DDk7afIQe7a_hmRdZkAZLM	!cwnFZrIkYIOvkCHJkc:localhost
$ab5rFOQQuDGj00oHfJaJKURhG6lNFNDKS0nkBlsLTMk	$PJZugFD-K6RtTB0vNzX1j0YFLZ9x4vli99YpMY9dzQk	!cwnFZrIkYIOvkCHJkc:localhost
$ab5rFOQQuDGj00oHfJaJKURhG6lNFNDKS0nkBlsLTMk	$41BPCZJ_9IbE7VgIqxEef1X7U2-FXJjTA25i2Q-n_gg	!cwnFZrIkYIOvkCHJkc:localhost
$kL3ALUeGobajxL55gzYoIZLdD1CSD4sYXedIOysHwV0	$KGv2op0D-6TOpQuqb5Gl4YZxMUKn37cUNSylMiEo7SA	!kAToIwhNWrDpgQVMfY:localhost
$kL3ALUeGobajxL55gzYoIZLdD1CSD4sYXedIOysHwV0	$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE	!kAToIwhNWrDpgQVMfY:localhost
$kL3ALUeGobajxL55gzYoIZLdD1CSD4sYXedIOysHwV0	$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw	!kAToIwhNWrDpgQVMfY:localhost
$kL3ALUeGobajxL55gzYoIZLdD1CSD4sYXedIOysHwV0	$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc	!kAToIwhNWrDpgQVMfY:localhost
$41BPCZJ_9IbE7VgIqxEef1X7U2-FXJjTA25i2Q-n_gg	$AXgBEWEnQYL0m4F3qNGi4DDk7afIQe7a_hmRdZkAZLM	!cwnFZrIkYIOvkCHJkc:localhost
$pn5NPm28AfF5_169OnQQxTv4_ijcoN4k44UIvzGsN7k	$wTlWqRh3eGNrru9CGqbzkNcL0kBGbtEB8sHZwsAboS0	!ffaaxOMHcWnINEXTWK:localhost
$pn5NPm28AfF5_169OnQQxTv4_ijcoN4k44UIvzGsN7k	$81gCIX2tUwDG_Jg02kHVceEfsUG1IOQ9-YnDk1cV15w	!ffaaxOMHcWnINEXTWK:localhost
$PJZugFD-K6RtTB0vNzX1j0YFLZ9x4vli99YpMY9dzQk	$AXgBEWEnQYL0m4F3qNGi4DDk7afIQe7a_hmRdZkAZLM	!cwnFZrIkYIOvkCHJkc:localhost
$PJZugFD-K6RtTB0vNzX1j0YFLZ9x4vli99YpMY9dzQk	$41BPCZJ_9IbE7VgIqxEef1X7U2-FXJjTA25i2Q-n_gg	!cwnFZrIkYIOvkCHJkc:localhost
$jLK4KwpKxGfwbMdz2oJbuUlHegeZ_5YucIy2ChSNCLg	$wTlWqRh3eGNrru9CGqbzkNcL0kBGbtEB8sHZwsAboS0	!ffaaxOMHcWnINEXTWK:localhost
$jLK4KwpKxGfwbMdz2oJbuUlHegeZ_5YucIy2ChSNCLg	$pn5NPm28AfF5_169OnQQxTv4_ijcoN4k44UIvzGsN7k	!ffaaxOMHcWnINEXTWK:localhost
$jLK4KwpKxGfwbMdz2oJbuUlHegeZ_5YucIy2ChSNCLg	$81gCIX2tUwDG_Jg02kHVceEfsUG1IOQ9-YnDk1cV15w	!ffaaxOMHcWnINEXTWK:localhost
$BNEpFvlxqdDF-6u3EPToNgfx0BuYX2_P9oWB486xTxM	$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw	!kAToIwhNWrDpgQVMfY:localhost
$BNEpFvlxqdDF-6u3EPToNgfx0BuYX2_P9oWB486xTxM	$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc	!kAToIwhNWrDpgQVMfY:localhost
$BNEpFvlxqdDF-6u3EPToNgfx0BuYX2_P9oWB486xTxM	$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE	!kAToIwhNWrDpgQVMfY:localhost
$v_Jh2P1U7Li3ATyMsxgipoyBuQRYv5HD-cv8JVNpdLc	$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw	!kAToIwhNWrDpgQVMfY:localhost
$v_Jh2P1U7Li3ATyMsxgipoyBuQRYv5HD-cv8JVNpdLc	$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc	!kAToIwhNWrDpgQVMfY:localhost
$v_Jh2P1U7Li3ATyMsxgipoyBuQRYv5HD-cv8JVNpdLc	$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE	!kAToIwhNWrDpgQVMfY:localhost
$ce28aY-iB2mpb8Gioxn_S-YFJtBn3dK4JRguWv9H2XY	$AXgBEWEnQYL0m4F3qNGi4DDk7afIQe7a_hmRdZkAZLM	!cwnFZrIkYIOvkCHJkc:localhost
$ce28aY-iB2mpb8Gioxn_S-YFJtBn3dK4JRguWv9H2XY	$PJZugFD-K6RtTB0vNzX1j0YFLZ9x4vli99YpMY9dzQk	!cwnFZrIkYIOvkCHJkc:localhost
$ce28aY-iB2mpb8Gioxn_S-YFJtBn3dK4JRguWv9H2XY	$41BPCZJ_9IbE7VgIqxEef1X7U2-FXJjTA25i2Q-n_gg	!cwnFZrIkYIOvkCHJkc:localhost
$Jy6RZhO0nZ0x_EgWugfJHW0XgWaR5DoWVaImG_wE3lg	$wTlWqRh3eGNrru9CGqbzkNcL0kBGbtEB8sHZwsAboS0	!ffaaxOMHcWnINEXTWK:localhost
$Jy6RZhO0nZ0x_EgWugfJHW0XgWaR5DoWVaImG_wE3lg	$pn5NPm28AfF5_169OnQQxTv4_ijcoN4k44UIvzGsN7k	!ffaaxOMHcWnINEXTWK:localhost
$Jy6RZhO0nZ0x_EgWugfJHW0XgWaR5DoWVaImG_wE3lg	$81gCIX2tUwDG_Jg02kHVceEfsUG1IOQ9-YnDk1cV15w	!ffaaxOMHcWnINEXTWK:localhost
$7CUacT0Q8hFhLt80ecyLwLrizW7Jh6uNtLYApZIgNg4	$AXgBEWEnQYL0m4F3qNGi4DDk7afIQe7a_hmRdZkAZLM	!cwnFZrIkYIOvkCHJkc:localhost
$7CUacT0Q8hFhLt80ecyLwLrizW7Jh6uNtLYApZIgNg4	$PJZugFD-K6RtTB0vNzX1j0YFLZ9x4vli99YpMY9dzQk	!cwnFZrIkYIOvkCHJkc:localhost
$7CUacT0Q8hFhLt80ecyLwLrizW7Jh6uNtLYApZIgNg4	$41BPCZJ_9IbE7VgIqxEef1X7U2-FXJjTA25i2Q-n_gg	!cwnFZrIkYIOvkCHJkc:localhost
$e4RXblgeP3Sa0Hs3COmGOAFe9LclWYCrLIk7nF2PEDk	$wTlWqRh3eGNrru9CGqbzkNcL0kBGbtEB8sHZwsAboS0	!ffaaxOMHcWnINEXTWK:localhost
$e4RXblgeP3Sa0Hs3COmGOAFe9LclWYCrLIk7nF2PEDk	$pn5NPm28AfF5_169OnQQxTv4_ijcoN4k44UIvzGsN7k	!ffaaxOMHcWnINEXTWK:localhost
$e4RXblgeP3Sa0Hs3COmGOAFe9LclWYCrLIk7nF2PEDk	$81gCIX2tUwDG_Jg02kHVceEfsUG1IOQ9-YnDk1cV15w	!ffaaxOMHcWnINEXTWK:localhost
$3ccBKAI_RT742spGFKzsNSBIzhj7WC7YBxugrDvyr4w	$AXgBEWEnQYL0m4F3qNGi4DDk7afIQe7a_hmRdZkAZLM	!cwnFZrIkYIOvkCHJkc:localhost
$3ccBKAI_RT742spGFKzsNSBIzhj7WC7YBxugrDvyr4w	$PJZugFD-K6RtTB0vNzX1j0YFLZ9x4vli99YpMY9dzQk	!cwnFZrIkYIOvkCHJkc:localhost
$3ccBKAI_RT742spGFKzsNSBIzhj7WC7YBxugrDvyr4w	$41BPCZJ_9IbE7VgIqxEef1X7U2-FXJjTA25i2Q-n_gg	!cwnFZrIkYIOvkCHJkc:localhost
$dLHdIN5p2aRYI16qULeP30FhKh5GGtUHvQUzWcSWyTA	$AXgBEWEnQYL0m4F3qNGi4DDk7afIQe7a_hmRdZkAZLM	!cwnFZrIkYIOvkCHJkc:localhost
$dLHdIN5p2aRYI16qULeP30FhKh5GGtUHvQUzWcSWyTA	$PJZugFD-K6RtTB0vNzX1j0YFLZ9x4vli99YpMY9dzQk	!cwnFZrIkYIOvkCHJkc:localhost
$dLHdIN5p2aRYI16qULeP30FhKh5GGtUHvQUzWcSWyTA	$41BPCZJ_9IbE7VgIqxEef1X7U2-FXJjTA25i2Q-n_gg	!cwnFZrIkYIOvkCHJkc:localhost
$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic	$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q	!LwtGEdNVvQHvFLuWQB:localhost
$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k	$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic	!LwtGEdNVvQHvFLuWQB:localhost
$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k	$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q	!LwtGEdNVvQHvFLuWQB:localhost
$PTHh0FcsZLrplrmwtCyvLjXr1yAZRgovFGLVt7qrrAo	$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic	!LwtGEdNVvQHvFLuWQB:localhost
$PTHh0FcsZLrplrmwtCyvLjXr1yAZRgovFGLVt7qrrAo	$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q	!LwtGEdNVvQHvFLuWQB:localhost
$PTHh0FcsZLrplrmwtCyvLjXr1yAZRgovFGLVt7qrrAo	$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k	!LwtGEdNVvQHvFLuWQB:localhost
$6CLZCTGtpIVnohQDg2sJwn_880f0--zCZpr6BgOwQ2Q	$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic	!LwtGEdNVvQHvFLuWQB:localhost
$6CLZCTGtpIVnohQDg2sJwn_880f0--zCZpr6BgOwQ2Q	$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q	!LwtGEdNVvQHvFLuWQB:localhost
$6CLZCTGtpIVnohQDg2sJwn_880f0--zCZpr6BgOwQ2Q	$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k	!LwtGEdNVvQHvFLuWQB:localhost
$nKXxWIIoo5Vko9Z7kITUEeAsQgQnr-FLvhoQHfkCYAE	$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic	!LwtGEdNVvQHvFLuWQB:localhost
$nKXxWIIoo5Vko9Z7kITUEeAsQgQnr-FLvhoQHfkCYAE	$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q	!LwtGEdNVvQHvFLuWQB:localhost
$nKXxWIIoo5Vko9Z7kITUEeAsQgQnr-FLvhoQHfkCYAE	$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k	!LwtGEdNVvQHvFLuWQB:localhost
$TbFvVskFwRsxEgjNnOjfs4ljMJuZC60_Cqb91vOUrxg	$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k	!LwtGEdNVvQHvFLuWQB:localhost
$TbFvVskFwRsxEgjNnOjfs4ljMJuZC60_Cqb91vOUrxg	$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q	!LwtGEdNVvQHvFLuWQB:localhost
$TbFvVskFwRsxEgjNnOjfs4ljMJuZC60_Cqb91vOUrxg	$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic	!LwtGEdNVvQHvFLuWQB:localhost
$TbFvVskFwRsxEgjNnOjfs4ljMJuZC60_Cqb91vOUrxg	$PTHh0FcsZLrplrmwtCyvLjXr1yAZRgovFGLVt7qrrAo	!LwtGEdNVvQHvFLuWQB:localhost
$SuM_AupYZSEtAJBPHbvNkhJ4aIYEjT4c741wzkoOX4I	$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic	!LwtGEdNVvQHvFLuWQB:localhost
$SuM_AupYZSEtAJBPHbvNkhJ4aIYEjT4c741wzkoOX4I	$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q	!LwtGEdNVvQHvFLuWQB:localhost
$SuM_AupYZSEtAJBPHbvNkhJ4aIYEjT4c741wzkoOX4I	$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k	!LwtGEdNVvQHvFLuWQB:localhost
$yrfdAmX0K0lY65Dm9bViRYWOBKtvTB1kxkm6lNsThdw	$_-6CgruWK6UfiL1rgJnNUgtmp_jusf_3Vf7LUPB6xaU	!GNlLBsLXjbOuNhCkEO:localhost
$uKKFUGwf_IAnbH81DTvAScd2HFnAwWWL_p4-E5B_YdU	$yrfdAmX0K0lY65Dm9bViRYWOBKtvTB1kxkm6lNsThdw	!GNlLBsLXjbOuNhCkEO:localhost
$uKKFUGwf_IAnbH81DTvAScd2HFnAwWWL_p4-E5B_YdU	$_-6CgruWK6UfiL1rgJnNUgtmp_jusf_3Vf7LUPB6xaU	!GNlLBsLXjbOuNhCkEO:localhost
$MRytSYI-n7aCgzUssVx9vLIC5Y-Yt22y_L1eQoE4GgE	$yrfdAmX0K0lY65Dm9bViRYWOBKtvTB1kxkm6lNsThdw	!GNlLBsLXjbOuNhCkEO:localhost
$MRytSYI-n7aCgzUssVx9vLIC5Y-Yt22y_L1eQoE4GgE	$_-6CgruWK6UfiL1rgJnNUgtmp_jusf_3Vf7LUPB6xaU	!GNlLBsLXjbOuNhCkEO:localhost
$MRytSYI-n7aCgzUssVx9vLIC5Y-Yt22y_L1eQoE4GgE	$uKKFUGwf_IAnbH81DTvAScd2HFnAwWWL_p4-E5B_YdU	!GNlLBsLXjbOuNhCkEO:localhost
$ah5gH_XfCIYeCtl2NFxHSgdd_OE6O9tHe2U1Pn2Qvhc	$yrfdAmX0K0lY65Dm9bViRYWOBKtvTB1kxkm6lNsThdw	!GNlLBsLXjbOuNhCkEO:localhost
$ah5gH_XfCIYeCtl2NFxHSgdd_OE6O9tHe2U1Pn2Qvhc	$_-6CgruWK6UfiL1rgJnNUgtmp_jusf_3Vf7LUPB6xaU	!GNlLBsLXjbOuNhCkEO:localhost
$ah5gH_XfCIYeCtl2NFxHSgdd_OE6O9tHe2U1Pn2Qvhc	$uKKFUGwf_IAnbH81DTvAScd2HFnAwWWL_p4-E5B_YdU	!GNlLBsLXjbOuNhCkEO:localhost
$lnpmPOjrFoaPq58156r6g4G7gYfejQ2BfcFkjGiEX-I	$yrfdAmX0K0lY65Dm9bViRYWOBKtvTB1kxkm6lNsThdw	!GNlLBsLXjbOuNhCkEO:localhost
$lnpmPOjrFoaPq58156r6g4G7gYfejQ2BfcFkjGiEX-I	$_-6CgruWK6UfiL1rgJnNUgtmp_jusf_3Vf7LUPB6xaU	!GNlLBsLXjbOuNhCkEO:localhost
$lnpmPOjrFoaPq58156r6g4G7gYfejQ2BfcFkjGiEX-I	$uKKFUGwf_IAnbH81DTvAScd2HFnAwWWL_p4-E5B_YdU	!GNlLBsLXjbOuNhCkEO:localhost
$fuvIFJYv32qkEsYyW8XNHbQ0hmQ5HHRjF6UEjte6Z-c	$yrfdAmX0K0lY65Dm9bViRYWOBKtvTB1kxkm6lNsThdw	!GNlLBsLXjbOuNhCkEO:localhost
$fuvIFJYv32qkEsYyW8XNHbQ0hmQ5HHRjF6UEjte6Z-c	$_-6CgruWK6UfiL1rgJnNUgtmp_jusf_3Vf7LUPB6xaU	!GNlLBsLXjbOuNhCkEO:localhost
$fuvIFJYv32qkEsYyW8XNHbQ0hmQ5HHRjF6UEjte6Z-c	$uKKFUGwf_IAnbH81DTvAScd2HFnAwWWL_p4-E5B_YdU	!GNlLBsLXjbOuNhCkEO:localhost
$smbpaz4v1tYoI0ZZ-HXKXrcs19S7qioXa8ah6FeOBpc	$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic	!LwtGEdNVvQHvFLuWQB:localhost
$smbpaz4v1tYoI0ZZ-HXKXrcs19S7qioXa8ah6FeOBpc	$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q	!LwtGEdNVvQHvFLuWQB:localhost
$smbpaz4v1tYoI0ZZ-HXKXrcs19S7qioXa8ah6FeOBpc	$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k	!LwtGEdNVvQHvFLuWQB:localhost
$O-kcGXcFLVtSNAY7CxqW4hLVBk0UqhADtIs1kCz8hlA	$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic	!LwtGEdNVvQHvFLuWQB:localhost
$O-kcGXcFLVtSNAY7CxqW4hLVBk0UqhADtIs1kCz8hlA	$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q	!LwtGEdNVvQHvFLuWQB:localhost
$O-kcGXcFLVtSNAY7CxqW4hLVBk0UqhADtIs1kCz8hlA	$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k	!LwtGEdNVvQHvFLuWQB:localhost
$vesveJhdimZ9d-Po76D8SZCUm8dVzl0GcQsvVX8lhos	$uKKFUGwf_IAnbH81DTvAScd2HFnAwWWL_p4-E5B_YdU	!GNlLBsLXjbOuNhCkEO:localhost
$vesveJhdimZ9d-Po76D8SZCUm8dVzl0GcQsvVX8lhos	$_-6CgruWK6UfiL1rgJnNUgtmp_jusf_3Vf7LUPB6xaU	!GNlLBsLXjbOuNhCkEO:localhost
$vesveJhdimZ9d-Po76D8SZCUm8dVzl0GcQsvVX8lhos	$yrfdAmX0K0lY65Dm9bViRYWOBKtvTB1kxkm6lNsThdw	!GNlLBsLXjbOuNhCkEO:localhost
$vesveJhdimZ9d-Po76D8SZCUm8dVzl0GcQsvVX8lhos	$fuvIFJYv32qkEsYyW8XNHbQ0hmQ5HHRjF6UEjte6Z-c	!GNlLBsLXjbOuNhCkEO:localhost
$nfronhC7iKGPRmKJ7zoXzYG7VKiOq5FoUIcfHg3a4Dg	$vesveJhdimZ9d-Po76D8SZCUm8dVzl0GcQsvVX8lhos	!GNlLBsLXjbOuNhCkEO:localhost
$nfronhC7iKGPRmKJ7zoXzYG7VKiOq5FoUIcfHg3a4Dg	$_-6CgruWK6UfiL1rgJnNUgtmp_jusf_3Vf7LUPB6xaU	!GNlLBsLXjbOuNhCkEO:localhost
$nfronhC7iKGPRmKJ7zoXzYG7VKiOq5FoUIcfHg3a4Dg	$uKKFUGwf_IAnbH81DTvAScd2HFnAwWWL_p4-E5B_YdU	!GNlLBsLXjbOuNhCkEO:localhost
$nfronhC7iKGPRmKJ7zoXzYG7VKiOq5FoUIcfHg3a4Dg	$fuvIFJYv32qkEsYyW8XNHbQ0hmQ5HHRjF6UEjte6Z-c	!GNlLBsLXjbOuNhCkEO:localhost
$Pem9TyngNuhpIq_NI2krx6wpkVigoBj6JCeB3WUezVk	$V_QrTFMCwHlrg-MSVVplcYCRVWM_QgXhIvp-2R_LtHI	!MrxfbdodytWwBMqNiF:localhost
$Pem9TyngNuhpIq_NI2krx6wpkVigoBj6JCeB3WUezVk	$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY	!MrxfbdodytWwBMqNiF:localhost
$Pem9TyngNuhpIq_NI2krx6wpkVigoBj6JCeB3WUezVk	$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA	!MrxfbdodytWwBMqNiF:localhost
$Pem9TyngNuhpIq_NI2krx6wpkVigoBj6JCeB3WUezVk	$TVXtgqtZ5WfNfZEnJQx6m0NYwp0_34ylOK87XzZ3JlI	!MrxfbdodytWwBMqNiF:localhost
$viSFX8RvY5fe8TiOaDirNG6PqooEHTTV3PT3hrQgVLA	$Pem9TyngNuhpIq_NI2krx6wpkVigoBj6JCeB3WUezVk	!MrxfbdodytWwBMqNiF:localhost
$viSFX8RvY5fe8TiOaDirNG6PqooEHTTV3PT3hrQgVLA	$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY	!MrxfbdodytWwBMqNiF:localhost
$viSFX8RvY5fe8TiOaDirNG6PqooEHTTV3PT3hrQgVLA	$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA	!MrxfbdodytWwBMqNiF:localhost
$2lEnFzGdtIu4kGthBBXcP0gW6sUWKP8c1x9I4-yFWso	$AMnH95Ky85GttLR7j9XHrHyULlBBezFJ9w8mtji-7Ok	!nPrdOOfNMRrmJedabn:localhost
$2lEnFzGdtIu4kGthBBXcP0gW6sUWKP8c1x9I4-yFWso	$A5h106ytjQ2qqPxkSylhOkJgVZQCscB4QX0PK60qxU0	!nPrdOOfNMRrmJedabn:localhost
$2lEnFzGdtIu4kGthBBXcP0gW6sUWKP8c1x9I4-yFWso	$gDW6j_UqhvIRf1ANEKurSD9fB4Hl4YnQ5uL9cy_U7Os	!nPrdOOfNMRrmJedabn:localhost
$yfuDQBYjEI6CCa3AdtfdjL_ZXIR0d92TRfHnh7Gq0zc	$AMnH95Ky85GttLR7j9XHrHyULlBBezFJ9w8mtji-7Ok	!nPrdOOfNMRrmJedabn:localhost
$yfuDQBYjEI6CCa3AdtfdjL_ZXIR0d92TRfHnh7Gq0zc	$A5h106ytjQ2qqPxkSylhOkJgVZQCscB4QX0PK60qxU0	!nPrdOOfNMRrmJedabn:localhost
$yfuDQBYjEI6CCa3AdtfdjL_ZXIR0d92TRfHnh7Gq0zc	$gDW6j_UqhvIRf1ANEKurSD9fB4Hl4YnQ5uL9cy_U7Os	!nPrdOOfNMRrmJedabn:localhost
$MT4EKTmcPC8LCVeATiG-5a71N2Zc1vNQcgKge5W0on8	$Pem9TyngNuhpIq_NI2krx6wpkVigoBj6JCeB3WUezVk	!MrxfbdodytWwBMqNiF:localhost
$MT4EKTmcPC8LCVeATiG-5a71N2Zc1vNQcgKge5W0on8	$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY	!MrxfbdodytWwBMqNiF:localhost
$MT4EKTmcPC8LCVeATiG-5a71N2Zc1vNQcgKge5W0on8	$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA	!MrxfbdodytWwBMqNiF:localhost
$AMnH95Ky85GttLR7j9XHrHyULlBBezFJ9w8mtji-7Ok	$A5h106ytjQ2qqPxkSylhOkJgVZQCscB4QX0PK60qxU0	!nPrdOOfNMRrmJedabn:localhost
$gDW6j_UqhvIRf1ANEKurSD9fB4Hl4YnQ5uL9cy_U7Os	$AMnH95Ky85GttLR7j9XHrHyULlBBezFJ9w8mtji-7Ok	!nPrdOOfNMRrmJedabn:localhost
$gDW6j_UqhvIRf1ANEKurSD9fB4Hl4YnQ5uL9cy_U7Os	$A5h106ytjQ2qqPxkSylhOkJgVZQCscB4QX0PK60qxU0	!nPrdOOfNMRrmJedabn:localhost
$eOC3-FZNb3jb3NisHG61gQhQ_hf9zWu0xvpfs8ZKDTg	$Pem9TyngNuhpIq_NI2krx6wpkVigoBj6JCeB3WUezVk	!MrxfbdodytWwBMqNiF:localhost
$eOC3-FZNb3jb3NisHG61gQhQ_hf9zWu0xvpfs8ZKDTg	$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY	!MrxfbdodytWwBMqNiF:localhost
$eOC3-FZNb3jb3NisHG61gQhQ_hf9zWu0xvpfs8ZKDTg	$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA	!MrxfbdodytWwBMqNiF:localhost
$0gszMJtyESzwVMh4olwTajdbj1MrrJYVnylO0yOIpSg	$AMnH95Ky85GttLR7j9XHrHyULlBBezFJ9w8mtji-7Ok	!nPrdOOfNMRrmJedabn:localhost
$0gszMJtyESzwVMh4olwTajdbj1MrrJYVnylO0yOIpSg	$A5h106ytjQ2qqPxkSylhOkJgVZQCscB4QX0PK60qxU0	!nPrdOOfNMRrmJedabn:localhost
$0gszMJtyESzwVMh4olwTajdbj1MrrJYVnylO0yOIpSg	$gDW6j_UqhvIRf1ANEKurSD9fB4Hl4YnQ5uL9cy_U7Os	!nPrdOOfNMRrmJedabn:localhost
$xyV3lysb-dda01bB4LpALdmaTC_mLZDhwxOE9L4zpXY	$AMnH95Ky85GttLR7j9XHrHyULlBBezFJ9w8mtji-7Ok	!nPrdOOfNMRrmJedabn:localhost
$xyV3lysb-dda01bB4LpALdmaTC_mLZDhwxOE9L4zpXY	$A5h106ytjQ2qqPxkSylhOkJgVZQCscB4QX0PK60qxU0	!nPrdOOfNMRrmJedabn:localhost
$xyV3lysb-dda01bB4LpALdmaTC_mLZDhwxOE9L4zpXY	$gDW6j_UqhvIRf1ANEKurSD9fB4Hl4YnQ5uL9cy_U7Os	!nPrdOOfNMRrmJedabn:localhost
$usag8slAxKA2dWWERksMiBQ8hRwfGZ8nZzTfcymZxyE	$AMnH95Ky85GttLR7j9XHrHyULlBBezFJ9w8mtji-7Ok	!nPrdOOfNMRrmJedabn:localhost
$usag8slAxKA2dWWERksMiBQ8hRwfGZ8nZzTfcymZxyE	$gDW6j_UqhvIRf1ANEKurSD9fB4Hl4YnQ5uL9cy_U7Os	!nPrdOOfNMRrmJedabn:localhost
$usag8slAxKA2dWWERksMiBQ8hRwfGZ8nZzTfcymZxyE	$A5h106ytjQ2qqPxkSylhOkJgVZQCscB4QX0PK60qxU0	!nPrdOOfNMRrmJedabn:localhost
$usag8slAxKA2dWWERksMiBQ8hRwfGZ8nZzTfcymZxyE	$0gszMJtyESzwVMh4olwTajdbj1MrrJYVnylO0yOIpSg	!nPrdOOfNMRrmJedabn:localhost
$O04OV5x9R_5W2IT9G9Z-dXJmfV6fgtZM8-4ogFp9rEw	$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA	!dKcbdDATuwwphjRPQP:localhost
$O04OV5x9R_5W2IT9G9Z-dXJmfV6fgtZM8-4ogFp9rEw	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$O04OV5x9R_5W2IT9G9Z-dXJmfV6fgtZM8-4ogFp9rEw	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$O04OV5x9R_5W2IT9G9Z-dXJmfV6fgtZM8-4ogFp9rEw	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$-QMfwsu75_SWJtzFqIsrFjLgl_XBqF6HcorcUjLTsWY	$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA	!dKcbdDATuwwphjRPQP:localhost
$-QMfwsu75_SWJtzFqIsrFjLgl_XBqF6HcorcUjLTsWY	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$-QMfwsu75_SWJtzFqIsrFjLgl_XBqF6HcorcUjLTsWY	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$-QMfwsu75_SWJtzFqIsrFjLgl_XBqF6HcorcUjLTsWY	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$WsVhQvsUsrFormgSdFA_Z_Io7y9fxZy5juqaM8oYpkg	$TbFvVskFwRsxEgjNnOjfs4ljMJuZC60_Cqb91vOUrxg	!LwtGEdNVvQHvFLuWQB:localhost
$WsVhQvsUsrFormgSdFA_Z_Io7y9fxZy5juqaM8oYpkg	$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q	!LwtGEdNVvQHvFLuWQB:localhost
$WsVhQvsUsrFormgSdFA_Z_Io7y9fxZy5juqaM8oYpkg	$O-kcGXcFLVtSNAY7CxqW4hLVBk0UqhADtIs1kCz8hlA	!LwtGEdNVvQHvFLuWQB:localhost
$WsVhQvsUsrFormgSdFA_Z_Io7y9fxZy5juqaM8oYpkg	$PTHh0FcsZLrplrmwtCyvLjXr1yAZRgovFGLVt7qrrAo	!LwtGEdNVvQHvFLuWQB:localhost
$hooKnajA7nQRs3MZDj_evGyHCyHpg4QmGp2i5WRKzp0	$sdrkpiq94MhqjrSukg-aexI_3VlPxcoqiZXmrPvpQGw	!UKcoTBWWxNEyixrjyM:localhost
$hooKnajA7nQRs3MZDj_evGyHCyHpg4QmGp2i5WRKzp0	$yZwQJfxjuLFOlfyTYw-M1aupZjmck-aVfpfSYx5fj1I	!UKcoTBWWxNEyixrjyM:localhost
$hooKnajA7nQRs3MZDj_evGyHCyHpg4QmGp2i5WRKzp0	$EsIKBNaGky9gjqListPEKjQfFScHFrG5GuEQD0vyi9Q	!UKcoTBWWxNEyixrjyM:localhost
$hooKnajA7nQRs3MZDj_evGyHCyHpg4QmGp2i5WRKzp0	$STt_lRcQQY1HR2YQmv4RsQMis1Xc5sWAamnHn02ddqk	!UKcoTBWWxNEyixrjyM:localhost
$rNG4YvsFCU9LVcVcHEkbBRGSuEH_QqO_hMEZ-sC8WH8	$bFxX1nACgPihIeXfSiWHmW_hxrfmIgtQM9HWAPS2wVY	!kAToIwhNWrDpgQVMfY:localhost
$rNG4YvsFCU9LVcVcHEkbBRGSuEH_QqO_hMEZ-sC8WH8	$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw	!kAToIwhNWrDpgQVMfY:localhost
$rNG4YvsFCU9LVcVcHEkbBRGSuEH_QqO_hMEZ-sC8WH8	$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc	!kAToIwhNWrDpgQVMfY:localhost
$rNG4YvsFCU9LVcVcHEkbBRGSuEH_QqO_hMEZ-sC8WH8	$KGv2op0D-6TOpQuqb5Gl4YZxMUKn37cUNSylMiEo7SA	!kAToIwhNWrDpgQVMfY:localhost
\.


--
-- Data for Name: event_auth_chain_links; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_auth_chain_links (origin_chain_id, origin_sequence_number, target_chain_id, target_sequence_number) FROM stdin;
1	1	13	1
12	1	16	1
5	1	18	1
5	1	9	1
17	1	8	1
2	1	6	1
4	1	8	1
2	1	8	1
15	1	13	1
14	1	18	1
11	1	16	1
18	1	9	1
14	1	9	1
18	1	6	1
4	1	6	1
1	1	10	1
7	1	10	1
7	1	12	1
16	1	10	1
18	1	8	1
1	1	12	1
13	1	10	1
5	1	6	1
13	1	12	1
7	1	16	1
9	1	8	1
3	1	10	1
15	1	10	1
11	1	13	1
3	1	12	1
5	1	8	1
14	1	8	1
14	1	6	1
1	1	16	1
9	1	6	1
17	1	9	1
13	1	16	1
4	1	18	1
15	1	12	1
4	1	9	1
12	1	10	1
2	1	9	1
8	1	6	1
17	1	6	1
3	1	16	1
15	1	16	1
11	1	10	1
11	1	12	1
19	1	6	1
19	1	8	1
19	1	9	1
19	1	18	1
20	1	16	1
20	1	12	1
20	1	10	1
20	1	13	1
21	1	13	1
21	1	20	1
21	1	10	1
21	1	16	1
21	1	12	1
22	1	6	1
22	1	18	1
22	1	9	1
22	1	19	1
22	1	8	1
23	1	12	1
23	1	13	1
23	1	20	1
23	1	10	1
23	1	16	1
24	1	6	1
24	1	18	1
24	1	8	1
24	1	19	1
24	1	9	1
25	1	19	1
25	1	18	1
25	1	8	1
25	1	6	1
25	1	9	1
26	1	9	1
26	1	6	1
26	1	18	1
26	1	8	1
26	1	19	1
27	1	16	1
27	1	20	1
27	1	12	1
27	1	10	1
27	1	13	1
28	1	19	1
28	1	8	1
28	1	9	1
28	1	6	1
28	1	18	1
29	1	16	1
29	1	12	1
29	1	13	1
29	1	20	1
29	1	10	1
30	1	10	1
30	1	13	1
30	1	20	1
30	1	16	1
30	1	12	1
31	1	9	1
31	1	19	1
31	1	6	1
31	1	18	1
31	1	8	1
32	1	16	1
32	1	12	1
32	1	13	1
32	1	20	1
32	1	10	1
34	1	33	1
35	1	33	1
35	1	34	1
36	1	33	1
36	1	34	1
36	1	35	1
37	1	35	1
37	1	33	1
37	1	34	1
38	1	35	1
38	1	33	1
38	1	34	1
39	1	33	1
39	1	36	1
39	1	34	1
39	1	35	1
41	1	40	1
42	1	40	1
42	1	41	1
43	1	40	1
43	1	41	1
43	1	42	1
44	1	41	1
44	1	42	1
44	1	40	1
45	1	41	1
45	1	42	1
45	1	40	1
46	1	40	1
46	1	41	1
46	1	42	1
46	1	43	1
48	1	47	1
49	1	47	1
49	1	48	1
50	1	49	1
50	1	47	1
50	1	48	1
51	1	48	1
51	1	49	1
51	1	47	1
52	1	48	1
52	1	49	1
52	1	47	1
53	1	47	1
53	1	48	1
53	1	49	1
54	1	49	1
54	1	47	1
54	1	48	1
55	1	48	1
55	1	49	1
55	1	47	1
58	1	57	1
59	1	56	1
60	1	58	1
60	1	57	1
61	1	56	1
61	1	59	1
62	1	57	1
62	1	60	1
62	1	58	1
63	1	59	1
63	1	61	1
63	1	56	1
64	1	57	1
64	1	60	1
64	1	58	1
65	1	61	1
65	1	56	1
65	1	59	1
67	1	60	1
67	1	58	1
67	1	57	1
66	1	59	1
66	1	61	1
66	1	56	1
68	1	60	1
68	1	57	1
68	1	58	1
69	1	61	1
69	1	56	1
69	1	59	1
70	1	60	1
70	1	58	1
70	1	57	1
71	1	61	1
71	1	56	1
71	1	59	1
72	1	47	1
72	1	48	1
72	1	49	1
73	1	49	1
73	1	47	1
73	1	48	1
74	1	47	1
74	1	48	1
74	1	49	1
74	1	51	1
75	1	51	1
75	1	49	1
75	1	47	1
75	1	48	1
77	1	76	1
78	1	76	1
78	1	77	1
79	1	77	1
79	1	78	1
79	1	76	1
80	1	78	1
80	1	76	1
80	1	77	1
81	1	78	1
81	1	76	1
81	1	77	1
82	1	78	1
82	1	76	1
82	1	79	1
82	1	77	1
83	1	76	1
83	1	77	1
83	1	78	1
85	1	84	1
86	1	85	1
86	1	84	1
87	1	86	1
87	1	84	1
87	1	85	1
88	1	84	1
88	1	85	1
88	1	86	1
89	1	86	1
89	1	84	1
89	1	85	1
90	1	85	1
90	1	86	1
90	1	84	1
91	1	77	1
91	1	78	1
91	1	76	1
92	1	90	1
92	1	84	1
92	1	85	1
92	1	86	1
93	1	34	1
93	1	35	1
93	1	39	2
93	1	36	1
93	1	33	1
95	1	94	1
96	1	95	1
96	1	94	1
97	1	96	1
97	1	94	1
97	1	95	1
98	1	96	1
98	1	94	1
98	1	95	1
99	1	95	1
99	1	96	1
99	1	94	1
100	1	95	1
100	1	96	1
100	1	94	1
101	1	36	1
101	1	33	1
101	1	34	1
101	1	35	1
101	1	39	2
35	2	36	1
35	2	39	2
102	1	95	1
102	1	94	1
102	1	96	1
102	1	97	1
103	1	12	1
103	1	10	1
103	1	13	1
103	1	16	1
104	1	16	1
104	1	13	1
104	1	12	1
104	1	10	1
82	2	78	2
\.


--
-- Data for Name: event_auth_chain_to_calculate; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_auth_chain_to_calculate (event_id, room_id, type, state_key) FROM stdin;
\.


--
-- Data for Name: event_auth_chains; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_auth_chains (event_id, chain_id, sequence_number) FROM stdin;
$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	10	1
$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA	16	1
$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	12	1
$TVnvv0nGbLydCBtMmTTz-htMsoI4hmxCr3s9AHyFGHQ	3	1
$b__a7rX3L5YpX7nAZte73DAbjtXZK48JH8VKSnGOKKw	7	1
$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	13	1
$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0	15	1
$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A	11	1
$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	6	1
$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw	8	1
$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	9	1
$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	18	1
$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8	4	1
$O5iO4EII22igkDq5cMKHFB-SGIYD0KqJQXZohS2Dzc0	17	1
$X8tdoEsXAgBC6gobCepAn3rwO8CJoQU6i9NN9Rzhukg	2	1
$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	5	1
$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk	14	1
$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0	1	1
$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok	19	1
$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ	20	1
$7TwPfUMTevEcf7wLvbgx3LG01lYT_yGudYiOVlkGU7E	21	1
$jAifmicJfMyB1QPFQ6KFQ7ZqTqQ58RJXsH5viWn3ZUg	22	1
$DsZXxk2rEIB2tF3pYUdOPjrMwclo8BXltutiWCnKUIU	23	1
$NyVGoA-ZaMPbk_RzpmLOajRS1nEBirO7Du2KpA9Eo64	24	1
$JwL8EK5sa4vg29tclnHwa5jrpCTa8oZVOIsgFyivQdY	21	2
$JcoTJcBGASUqIK9V7j6ND5Jt6P9gdbNJxXxQBZNg8z4	22	2
$2KnXfE3sZw8LDrOAaEP4HdQuw5neshhvyZKtnwo5cg0	23	2
$isXWKf_B_7Z7R7jYn_2gZB-U31TuzMehBRxj5701Lq8	24	2
$rVK77mVSpz5EHxI2mbLxilqbkLxKhXEiusPFjapVPbw	25	1
$5agO4kI6VqJHGKvKbkqUa2Y3cTwUBrjAhmCVtj9JmKU	26	1
$4JiNeQHyMbyuEfymLkE-SEzPUh3bWddjxa6-5w36nJw	27	1
$Y_S-fF0iLu0OHNMcZdYVzt0we_qL_t8_4QIKGeobLdI	28	1
$g1kV-jEZBtN9l6VGGo2MN-wQn7RR7J-Tv5LfyJ5Z5fc	29	1
$CQg_jKvdpWFvaiLH2f5MtTnu1Zwxi8P4QPSJZum91dw	25	2
$OcvCF7YNeTKFnzz4EWVjFJIF9QidMEUmomHIvH3d2W8	30	1
$GrqoJ52XSgRaoc4wPEYLdL2p6t3jl0aiFd8bYswQQcU	31	1
$5TE1hAtSTolrY9QTj9Wt8DnKurFa3P6KIfGkWOJbrY4	32	1
$UYXKiTPqFr31PwoZzi35ODpdRK0hwJVjVGC1N7kR7yk	26	2
$YFCWkh6b_jgrSjje7vt6JB6-uLPRz7Na1VgGh0PwdI8	27	2
$h2yGPxzdKWUBUSFQiOgFiRoNa8NgWHYXdy_2SMJx6ns	28	2
$kmvnPONhcKxIpG62sV6apngYToshpP0mBrwpKL0hAOI	29	2
$KgpvpFIMQIVFvm0adBZqAbWANmMgdu1_1jbP71RuM48	31	2
$qWi32T1tK2APgSwc4y_6f0e_N_fUPmIBxC5ACk1h6NM	30	2
$jvwVmkElpx8M62JlaBz7nJ4qa2U8tVO7V9-HhJ-n8JI	22	3
$0WsTO-QKZzqtMdl5UwGJc5h4e7YAE5ZGp_GDMb9K824	32	2
$l5dYt-R2kpcKdlmMRFnzC5N9PjiV4DZ63c1bTGPOCXk	21	3
$opS4sT6APXaq4vDdegPq6ik1z-yX-FkMTAqhGtTWXEE	24	3
$NxuVtjeVql0_aadDlNux0yeeR_PxcpcJPnX1SdoDmXM	23	3
$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY	33	1
$89n67RlAmtb8nRuxie-oq3g9grnkpjzJMAhbJ8h_8Xw	34	1
$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA	35	1
$TVXtgqtZ5WfNfZEnJQx6m0NYwp0_34ylOK87XzZ3JlI	36	1
$JQ7PDbgzTTAY5uHFM6NV0ovadfzQLOpcAcrSX5mRUi0	37	1
$9MVFB3q88VYxhDZMX087Uv4c3h3uEpluJN0q33ubtso	38	1
$V_QrTFMCwHlrg-MSVVplcYCRVWM_QgXhIvp-2R_LtHI	39	1
$yZwQJfxjuLFOlfyTYw-M1aupZjmck-aVfpfSYx5fj1I	40	1
$sqtTmHJJ_e6UeDKORkztLzcGXYNZpKgoa1v2ir5yr-w	41	1
$EsIKBNaGky9gjqListPEKjQfFScHFrG5GuEQD0vyi9Q	42	1
$STt_lRcQQY1HR2YQmv4RsQMis1Xc5sWAamnHn02ddqk	43	1
$KEhwfKMs0OrXZWYNQWK_YDu-mrG-UP2Do2VsAShloEY	44	1
$em_2PzgnditDYAzn8yY84PnmN1oNQZgI8Co6SjahtU8	45	1
$sdrkpiq94MhqjrSukg-aexI_3VlPxcoqiZXmrPvpQGw	46	1
$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw	47	1
$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE	48	1
$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc	49	1
$fZAJc_jo3uwpjSNh7ULQOuzuMtHLVO8KdmygXkq-95M	50	1
$KGv2op0D-6TOpQuqb5Gl4YZxMUKn37cUNSylMiEo7SA	51	1
$XvSaPVUaER3JwP1gLc-c__oVTIjGs5YL10o0DSsZ3q0	52	1
$zHrY9OvLbZTtN0bNPCDJg1HsmkgSV-pzAmxVIqaSB98	53	1
$Np7HQ3SdNiYX3HhRJtJw4b80J96uY_IbqI_bL7w83m0	54	1
$nL-1meDVcMfCo41V5V5w3EBPwNdmll7Alfsp00QCHvk	55	1
$AXgBEWEnQYL0m4F3qNGi4DDk7afIQe7a_hmRdZkAZLM	56	1
$wTlWqRh3eGNrru9CGqbzkNcL0kBGbtEB8sHZwsAboS0	57	1
$81gCIX2tUwDG_Jg02kHVceEfsUG1IOQ9-YnDk1cV15w	58	1
$41BPCZJ_9IbE7VgIqxEef1X7U2-FXJjTA25i2Q-n_gg	59	1
$pn5NPm28AfF5_169OnQQxTv4_ijcoN4k44UIvzGsN7k	60	1
$PJZugFD-K6RtTB0vNzX1j0YFLZ9x4vli99YpMY9dzQk	61	1
$jLK4KwpKxGfwbMdz2oJbuUlHegeZ_5YucIy2ChSNCLg	62	1
$ce28aY-iB2mpb8Gioxn_S-YFJtBn3dK4JRguWv9H2XY	63	1
$Jy6RZhO0nZ0x_EgWugfJHW0XgWaR5DoWVaImG_wE3lg	64	1
$3ccBKAI_RT742spGFKzsNSBIzhj7WC7YBxugrDvyr4w	65	1
$7CUacT0Q8hFhLt80ecyLwLrizW7Jh6uNtLYApZIgNg4	66	1
$zxy8zKV-5WiZDQEOGVCLyrd2yGWyYrOah4vQYAlc-xI	67	1
$e4RXblgeP3Sa0Hs3COmGOAFe9LclWYCrLIk7nF2PEDk	68	1
$dLHdIN5p2aRYI16qULeP30FhKh5GGtUHvQUzWcSWyTA	69	1
$tWJ40KRMdaZwn6df_597mz_AyHLHUSEy0noQk3HlctY	70	1
$ab5rFOQQuDGj00oHfJaJKURhG6lNFNDKS0nkBlsLTMk	71	1
$BNEpFvlxqdDF-6u3EPToNgfx0BuYX2_P9oWB486xTxM	72	1
$v_Jh2P1U7Li3ATyMsxgipoyBuQRYv5HD-cv8JVNpdLc	73	1
$bFxX1nACgPihIeXfSiWHmW_hxrfmIgtQM9HWAPS2wVY	74	1
$kL3ALUeGobajxL55gzYoIZLdD1CSD4sYXedIOysHwV0	75	1
$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q	76	1
$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic	77	1
$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k	78	1
$PTHh0FcsZLrplrmwtCyvLjXr1yAZRgovFGLVt7qrrAo	79	1
$6CLZCTGtpIVnohQDg2sJwn_880f0--zCZpr6BgOwQ2Q	80	1
$nKXxWIIoo5Vko9Z7kITUEeAsQgQnr-FLvhoQHfkCYAE	81	1
$TbFvVskFwRsxEgjNnOjfs4ljMJuZC60_Cqb91vOUrxg	82	1
$SuM_AupYZSEtAJBPHbvNkhJ4aIYEjT4c741wzkoOX4I	83	1
$_-6CgruWK6UfiL1rgJnNUgtmp_jusf_3Vf7LUPB6xaU	84	1
$yrfdAmX0K0lY65Dm9bViRYWOBKtvTB1kxkm6lNsThdw	85	1
$uKKFUGwf_IAnbH81DTvAScd2HFnAwWWL_p4-E5B_YdU	86	1
$MRytSYI-n7aCgzUssVx9vLIC5Y-Yt22y_L1eQoE4GgE	87	1
$ah5gH_XfCIYeCtl2NFxHSgdd_OE6O9tHe2U1Pn2Qvhc	88	1
$lnpmPOjrFoaPq58156r6g4G7gYfejQ2BfcFkjGiEX-I	89	1
$fuvIFJYv32qkEsYyW8XNHbQ0hmQ5HHRjF6UEjte6Z-c	90	1
$smbpaz4v1tYoI0ZZ-HXKXrcs19S7qioXa8ah6FeOBpc	91	1
$O-kcGXcFLVtSNAY7CxqW4hLVBk0UqhADtIs1kCz8hlA	78	2
$vesveJhdimZ9d-Po76D8SZCUm8dVzl0GcQsvVX8lhos	92	1
$nfronhC7iKGPRmKJ7zoXzYG7VKiOq5FoUIcfHg3a4Dg	92	2
$Pem9TyngNuhpIq_NI2krx6wpkVigoBj6JCeB3WUezVk	39	2
$viSFX8RvY5fe8TiOaDirNG6PqooEHTTV3PT3hrQgVLA	93	1
$A5h106ytjQ2qqPxkSylhOkJgVZQCscB4QX0PK60qxU0	94	1
$AMnH95Ky85GttLR7j9XHrHyULlBBezFJ9w8mtji-7Ok	95	1
$gDW6j_UqhvIRf1ANEKurSD9fB4Hl4YnQ5uL9cy_U7Os	96	1
$0gszMJtyESzwVMh4olwTajdbj1MrrJYVnylO0yOIpSg	97	1
$2lEnFzGdtIu4kGthBBXcP0gW6sUWKP8c1x9I4-yFWso	98	1
$yfuDQBYjEI6CCa3AdtfdjL_ZXIR0d92TRfHnh7Gq0zc	99	1
$xyV3lysb-dda01bB4LpALdmaTC_mLZDhwxOE9L4zpXY	100	1
$MT4EKTmcPC8LCVeATiG-5a71N2Zc1vNQcgKge5W0on8	101	1
$eOC3-FZNb3jb3NisHG61gQhQ_hf9zWu0xvpfs8ZKDTg	35	2
$usag8slAxKA2dWWERksMiBQ8hRwfGZ8nZzTfcymZxyE	102	1
$O04OV5x9R_5W2IT9G9Z-dXJmfV6fgtZM8-4ogFp9rEw	103	1
$-QMfwsu75_SWJtzFqIsrFjLgl_XBqF6HcorcUjLTsWY	104	1
$WsVhQvsUsrFormgSdFA_Z_Io7y9fxZy5juqaM8oYpkg	82	2
$hooKnajA7nQRs3MZDj_evGyHCyHpg4QmGp2i5WRKzp0	46	2
$rNG4YvsFCU9LVcVcHEkbBRGSuEH_QqO_hMEZ-sC8WH8	74	2
\.


--
-- Data for Name: event_backward_extremities; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_backward_extremities (event_id, room_id) FROM stdin;
\.


--
-- Data for Name: event_edges; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_edges (event_id, prev_event_id, room_id, is_state) FROM stdin;
$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost	f
$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw	!kmbTYjjsDRDHGgVqUP:localhost	f
$X8tdoEsXAgBC6gobCepAn3rwO8CJoQU6i9NN9Rzhukg	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost	f
$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	$X8tdoEsXAgBC6gobCepAn3rwO8CJoQU6i9NN9Rzhukg	!kmbTYjjsDRDHGgVqUP:localhost	f
$O5iO4EII22igkDq5cMKHFB-SGIYD0KqJQXZohS2Dzc0	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost	f
$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost	f
$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA	!dKcbdDATuwwphjRPQP:localhost	f
$b__a7rX3L5YpX7nAZte73DAbjtXZK48JH8VKSnGOKKw	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost	f
$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	$b__a7rX3L5YpX7nAZte73DAbjtXZK48JH8VKSnGOKKw	!dKcbdDATuwwphjRPQP:localhost	f
$TVnvv0nGbLydCBtMmTTz-htMsoI4hmxCr3s9AHyFGHQ	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost	f
$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8	$O5iO4EII22igkDq5cMKHFB-SGIYD0KqJQXZohS2Dzc0	!kmbTYjjsDRDHGgVqUP:localhost	f
$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0	$TVnvv0nGbLydCBtMmTTz-htMsoI4hmxCr3s9AHyFGHQ	!dKcbdDATuwwphjRPQP:localhost	f
$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk	$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8	!kmbTYjjsDRDHGgVqUP:localhost	f
$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0	$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0	!dKcbdDATuwwphjRPQP:localhost	f
$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk	!kmbTYjjsDRDHGgVqUP:localhost	f
$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A	$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0	!dKcbdDATuwwphjRPQP:localhost	f
$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok	$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	!kmbTYjjsDRDHGgVqUP:localhost	f
$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ	$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A	!dKcbdDATuwwphjRPQP:localhost	f
$7TwPfUMTevEcf7wLvbgx3LG01lYT_yGudYiOVlkGU7E	$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ	!dKcbdDATuwwphjRPQP:localhost	f
$jAifmicJfMyB1QPFQ6KFQ7ZqTqQ58RJXsH5viWn3ZUg	$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok	!kmbTYjjsDRDHGgVqUP:localhost	f
$DsZXxk2rEIB2tF3pYUdOPjrMwclo8BXltutiWCnKUIU	$7TwPfUMTevEcf7wLvbgx3LG01lYT_yGudYiOVlkGU7E	!dKcbdDATuwwphjRPQP:localhost	f
$NyVGoA-ZaMPbk_RzpmLOajRS1nEBirO7Du2KpA9Eo64	$jAifmicJfMyB1QPFQ6KFQ7ZqTqQ58RJXsH5viWn3ZUg	!kmbTYjjsDRDHGgVqUP:localhost	f
$JwL8EK5sa4vg29tclnHwa5jrpCTa8oZVOIsgFyivQdY	$DsZXxk2rEIB2tF3pYUdOPjrMwclo8BXltutiWCnKUIU	!dKcbdDATuwwphjRPQP:localhost	f
$JcoTJcBGASUqIK9V7j6ND5Jt6P9gdbNJxXxQBZNg8z4	$NyVGoA-ZaMPbk_RzpmLOajRS1nEBirO7Du2KpA9Eo64	!kmbTYjjsDRDHGgVqUP:localhost	f
$2KnXfE3sZw8LDrOAaEP4HdQuw5neshhvyZKtnwo5cg0	$JwL8EK5sa4vg29tclnHwa5jrpCTa8oZVOIsgFyivQdY	!dKcbdDATuwwphjRPQP:localhost	f
$isXWKf_B_7Z7R7jYn_2gZB-U31TuzMehBRxj5701Lq8	$JcoTJcBGASUqIK9V7j6ND5Jt6P9gdbNJxXxQBZNg8z4	!kmbTYjjsDRDHGgVqUP:localhost	f
$rVK77mVSpz5EHxI2mbLxilqbkLxKhXEiusPFjapVPbw	$isXWKf_B_7Z7R7jYn_2gZB-U31TuzMehBRxj5701Lq8	!kmbTYjjsDRDHGgVqUP:localhost	f
$5agO4kI6VqJHGKvKbkqUa2Y3cTwUBrjAhmCVtj9JmKU	$rVK77mVSpz5EHxI2mbLxilqbkLxKhXEiusPFjapVPbw	!kmbTYjjsDRDHGgVqUP:localhost	f
$4JiNeQHyMbyuEfymLkE-SEzPUh3bWddjxa6-5w36nJw	$2KnXfE3sZw8LDrOAaEP4HdQuw5neshhvyZKtnwo5cg0	!dKcbdDATuwwphjRPQP:localhost	f
$Y_S-fF0iLu0OHNMcZdYVzt0we_qL_t8_4QIKGeobLdI	$5agO4kI6VqJHGKvKbkqUa2Y3cTwUBrjAhmCVtj9JmKU	!kmbTYjjsDRDHGgVqUP:localhost	f
$g1kV-jEZBtN9l6VGGo2MN-wQn7RR7J-Tv5LfyJ5Z5fc	$4JiNeQHyMbyuEfymLkE-SEzPUh3bWddjxa6-5w36nJw	!dKcbdDATuwwphjRPQP:localhost	f
$CQg_jKvdpWFvaiLH2f5MtTnu1Zwxi8P4QPSJZum91dw	$Y_S-fF0iLu0OHNMcZdYVzt0we_qL_t8_4QIKGeobLdI	!kmbTYjjsDRDHGgVqUP:localhost	f
$OcvCF7YNeTKFnzz4EWVjFJIF9QidMEUmomHIvH3d2W8	$g1kV-jEZBtN9l6VGGo2MN-wQn7RR7J-Tv5LfyJ5Z5fc	!dKcbdDATuwwphjRPQP:localhost	f
$GrqoJ52XSgRaoc4wPEYLdL2p6t3jl0aiFd8bYswQQcU	$CQg_jKvdpWFvaiLH2f5MtTnu1Zwxi8P4QPSJZum91dw	!kmbTYjjsDRDHGgVqUP:localhost	f
$5TE1hAtSTolrY9QTj9Wt8DnKurFa3P6KIfGkWOJbrY4	$OcvCF7YNeTKFnzz4EWVjFJIF9QidMEUmomHIvH3d2W8	!dKcbdDATuwwphjRPQP:localhost	f
$UYXKiTPqFr31PwoZzi35ODpdRK0hwJVjVGC1N7kR7yk	$GrqoJ52XSgRaoc4wPEYLdL2p6t3jl0aiFd8bYswQQcU	!kmbTYjjsDRDHGgVqUP:localhost	f
$YFCWkh6b_jgrSjje7vt6JB6-uLPRz7Na1VgGh0PwdI8	$5TE1hAtSTolrY9QTj9Wt8DnKurFa3P6KIfGkWOJbrY4	!dKcbdDATuwwphjRPQP:localhost	f
$h2yGPxzdKWUBUSFQiOgFiRoNa8NgWHYXdy_2SMJx6ns	$UYXKiTPqFr31PwoZzi35ODpdRK0hwJVjVGC1N7kR7yk	!kmbTYjjsDRDHGgVqUP:localhost	f
$kmvnPONhcKxIpG62sV6apngYToshpP0mBrwpKL0hAOI	$YFCWkh6b_jgrSjje7vt6JB6-uLPRz7Na1VgGh0PwdI8	!dKcbdDATuwwphjRPQP:localhost	f
$KgpvpFIMQIVFvm0adBZqAbWANmMgdu1_1jbP71RuM48	$h2yGPxzdKWUBUSFQiOgFiRoNa8NgWHYXdy_2SMJx6ns	!kmbTYjjsDRDHGgVqUP:localhost	f
$qWi32T1tK2APgSwc4y_6f0e_N_fUPmIBxC5ACk1h6NM	$kmvnPONhcKxIpG62sV6apngYToshpP0mBrwpKL0hAOI	!dKcbdDATuwwphjRPQP:localhost	f
$jvwVmkElpx8M62JlaBz7nJ4qa2U8tVO7V9-HhJ-n8JI	$KgpvpFIMQIVFvm0adBZqAbWANmMgdu1_1jbP71RuM48	!kmbTYjjsDRDHGgVqUP:localhost	f
$0WsTO-QKZzqtMdl5UwGJc5h4e7YAE5ZGp_GDMb9K824	$qWi32T1tK2APgSwc4y_6f0e_N_fUPmIBxC5ACk1h6NM	!dKcbdDATuwwphjRPQP:localhost	f
$l5dYt-R2kpcKdlmMRFnzC5N9PjiV4DZ63c1bTGPOCXk	$0WsTO-QKZzqtMdl5UwGJc5h4e7YAE5ZGp_GDMb9K824	!dKcbdDATuwwphjRPQP:localhost	f
$opS4sT6APXaq4vDdegPq6ik1z-yX-FkMTAqhGtTWXEE	$jvwVmkElpx8M62JlaBz7nJ4qa2U8tVO7V9-HhJ-n8JI	!kmbTYjjsDRDHGgVqUP:localhost	f
$NxuVtjeVql0_aadDlNux0yeeR_PxcpcJPnX1SdoDmXM	$l5dYt-R2kpcKdlmMRFnzC5N9PjiV4DZ63c1bTGPOCXk	!dKcbdDATuwwphjRPQP:localhost	f
$89n67RlAmtb8nRuxie-oq3g9grnkpjzJMAhbJ8h_8Xw	$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY	!MrxfbdodytWwBMqNiF:localhost	f
$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA	$89n67RlAmtb8nRuxie-oq3g9grnkpjzJMAhbJ8h_8Xw	!MrxfbdodytWwBMqNiF:localhost	f
$TVXtgqtZ5WfNfZEnJQx6m0NYwp0_34ylOK87XzZ3JlI	$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA	!MrxfbdodytWwBMqNiF:localhost	f
$JQ7PDbgzTTAY5uHFM6NV0ovadfzQLOpcAcrSX5mRUi0	$TVXtgqtZ5WfNfZEnJQx6m0NYwp0_34ylOK87XzZ3JlI	!MrxfbdodytWwBMqNiF:localhost	f
$9MVFB3q88VYxhDZMX087Uv4c3h3uEpluJN0q33ubtso	$JQ7PDbgzTTAY5uHFM6NV0ovadfzQLOpcAcrSX5mRUi0	!MrxfbdodytWwBMqNiF:localhost	f
$V_QrTFMCwHlrg-MSVVplcYCRVWM_QgXhIvp-2R_LtHI	$9MVFB3q88VYxhDZMX087Uv4c3h3uEpluJN0q33ubtso	!MrxfbdodytWwBMqNiF:localhost	f
$Nv-ymHeLYsZKVjdilAoBLGC4GlzNJWt1HBqtIlSIz1k	$V_QrTFMCwHlrg-MSVVplcYCRVWM_QgXhIvp-2R_LtHI	!MrxfbdodytWwBMqNiF:localhost	f
$sqtTmHJJ_e6UeDKORkztLzcGXYNZpKgoa1v2ir5yr-w	$yZwQJfxjuLFOlfyTYw-M1aupZjmck-aVfpfSYx5fj1I	!UKcoTBWWxNEyixrjyM:localhost	f
$EsIKBNaGky9gjqListPEKjQfFScHFrG5GuEQD0vyi9Q	$sqtTmHJJ_e6UeDKORkztLzcGXYNZpKgoa1v2ir5yr-w	!UKcoTBWWxNEyixrjyM:localhost	f
$STt_lRcQQY1HR2YQmv4RsQMis1Xc5sWAamnHn02ddqk	$EsIKBNaGky9gjqListPEKjQfFScHFrG5GuEQD0vyi9Q	!UKcoTBWWxNEyixrjyM:localhost	f
$KEhwfKMs0OrXZWYNQWK_YDu-mrG-UP2Do2VsAShloEY	$STt_lRcQQY1HR2YQmv4RsQMis1Xc5sWAamnHn02ddqk	!UKcoTBWWxNEyixrjyM:localhost	f
$em_2PzgnditDYAzn8yY84PnmN1oNQZgI8Co6SjahtU8	$KEhwfKMs0OrXZWYNQWK_YDu-mrG-UP2Do2VsAShloEY	!UKcoTBWWxNEyixrjyM:localhost	f
$sdrkpiq94MhqjrSukg-aexI_3VlPxcoqiZXmrPvpQGw	$em_2PzgnditDYAzn8yY84PnmN1oNQZgI8Co6SjahtU8	!UKcoTBWWxNEyixrjyM:localhost	f
$-JWBJJpXpVo-YhtBYaJDTakzo94Jhn_XGlhnLzEWxyc	$sdrkpiq94MhqjrSukg-aexI_3VlPxcoqiZXmrPvpQGw	!UKcoTBWWxNEyixrjyM:localhost	f
$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE	$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw	!kAToIwhNWrDpgQVMfY:localhost	f
$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc	$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE	!kAToIwhNWrDpgQVMfY:localhost	f
$fZAJc_jo3uwpjSNh7ULQOuzuMtHLVO8KdmygXkq-95M	$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc	!kAToIwhNWrDpgQVMfY:localhost	f
$KGv2op0D-6TOpQuqb5Gl4YZxMUKn37cUNSylMiEo7SA	$fZAJc_jo3uwpjSNh7ULQOuzuMtHLVO8KdmygXkq-95M	!kAToIwhNWrDpgQVMfY:localhost	f
$XvSaPVUaER3JwP1gLc-c__oVTIjGs5YL10o0DSsZ3q0	$KGv2op0D-6TOpQuqb5Gl4YZxMUKn37cUNSylMiEo7SA	!kAToIwhNWrDpgQVMfY:localhost	f
$zHrY9OvLbZTtN0bNPCDJg1HsmkgSV-pzAmxVIqaSB98	$XvSaPVUaER3JwP1gLc-c__oVTIjGs5YL10o0DSsZ3q0	!kAToIwhNWrDpgQVMfY:localhost	f
$Np7HQ3SdNiYX3HhRJtJw4b80J96uY_IbqI_bL7w83m0	$zHrY9OvLbZTtN0bNPCDJg1HsmkgSV-pzAmxVIqaSB98	!kAToIwhNWrDpgQVMfY:localhost	f
$nL-1meDVcMfCo41V5V5w3EBPwNdmll7Alfsp00QCHvk	$Np7HQ3SdNiYX3HhRJtJw4b80J96uY_IbqI_bL7w83m0	!kAToIwhNWrDpgQVMfY:localhost	f
$81gCIX2tUwDG_Jg02kHVceEfsUG1IOQ9-YnDk1cV15w	$wTlWqRh3eGNrru9CGqbzkNcL0kBGbtEB8sHZwsAboS0	!ffaaxOMHcWnINEXTWK:localhost	f
$41BPCZJ_9IbE7VgIqxEef1X7U2-FXJjTA25i2Q-n_gg	$AXgBEWEnQYL0m4F3qNGi4DDk7afIQe7a_hmRdZkAZLM	!cwnFZrIkYIOvkCHJkc:localhost	f
$pn5NPm28AfF5_169OnQQxTv4_ijcoN4k44UIvzGsN7k	$81gCIX2tUwDG_Jg02kHVceEfsUG1IOQ9-YnDk1cV15w	!ffaaxOMHcWnINEXTWK:localhost	f
$PJZugFD-K6RtTB0vNzX1j0YFLZ9x4vli99YpMY9dzQk	$41BPCZJ_9IbE7VgIqxEef1X7U2-FXJjTA25i2Q-n_gg	!cwnFZrIkYIOvkCHJkc:localhost	f
$jLK4KwpKxGfwbMdz2oJbuUlHegeZ_5YucIy2ChSNCLg	$pn5NPm28AfF5_169OnQQxTv4_ijcoN4k44UIvzGsN7k	!ffaaxOMHcWnINEXTWK:localhost	f
$ce28aY-iB2mpb8Gioxn_S-YFJtBn3dK4JRguWv9H2XY	$PJZugFD-K6RtTB0vNzX1j0YFLZ9x4vli99YpMY9dzQk	!cwnFZrIkYIOvkCHJkc:localhost	f
$Jy6RZhO0nZ0x_EgWugfJHW0XgWaR5DoWVaImG_wE3lg	$jLK4KwpKxGfwbMdz2oJbuUlHegeZ_5YucIy2ChSNCLg	!ffaaxOMHcWnINEXTWK:localhost	f
$3ccBKAI_RT742spGFKzsNSBIzhj7WC7YBxugrDvyr4w	$ce28aY-iB2mpb8Gioxn_S-YFJtBn3dK4JRguWv9H2XY	!cwnFZrIkYIOvkCHJkc:localhost	f
$zxy8zKV-5WiZDQEOGVCLyrd2yGWyYrOah4vQYAlc-xI	$Jy6RZhO0nZ0x_EgWugfJHW0XgWaR5DoWVaImG_wE3lg	!ffaaxOMHcWnINEXTWK:localhost	f
$7CUacT0Q8hFhLt80ecyLwLrizW7Jh6uNtLYApZIgNg4	$3ccBKAI_RT742spGFKzsNSBIzhj7WC7YBxugrDvyr4w	!cwnFZrIkYIOvkCHJkc:localhost	f
$e4RXblgeP3Sa0Hs3COmGOAFe9LclWYCrLIk7nF2PEDk	$zxy8zKV-5WiZDQEOGVCLyrd2yGWyYrOah4vQYAlc-xI	!ffaaxOMHcWnINEXTWK:localhost	f
$dLHdIN5p2aRYI16qULeP30FhKh5GGtUHvQUzWcSWyTA	$7CUacT0Q8hFhLt80ecyLwLrizW7Jh6uNtLYApZIgNg4	!cwnFZrIkYIOvkCHJkc:localhost	f
$tWJ40KRMdaZwn6df_597mz_AyHLHUSEy0noQk3HlctY	$e4RXblgeP3Sa0Hs3COmGOAFe9LclWYCrLIk7nF2PEDk	!ffaaxOMHcWnINEXTWK:localhost	f
$ab5rFOQQuDGj00oHfJaJKURhG6lNFNDKS0nkBlsLTMk	$dLHdIN5p2aRYI16qULeP30FhKh5GGtUHvQUzWcSWyTA	!cwnFZrIkYIOvkCHJkc:localhost	f
$BNEpFvlxqdDF-6u3EPToNgfx0BuYX2_P9oWB486xTxM	$nL-1meDVcMfCo41V5V5w3EBPwNdmll7Alfsp00QCHvk	!kAToIwhNWrDpgQVMfY:localhost	f
$v_Jh2P1U7Li3ATyMsxgipoyBuQRYv5HD-cv8JVNpdLc	$nL-1meDVcMfCo41V5V5w3EBPwNdmll7Alfsp00QCHvk	!kAToIwhNWrDpgQVMfY:localhost	f
$bFxX1nACgPihIeXfSiWHmW_hxrfmIgtQM9HWAPS2wVY	$v_Jh2P1U7Li3ATyMsxgipoyBuQRYv5HD-cv8JVNpdLc	!kAToIwhNWrDpgQVMfY:localhost	f
$bFxX1nACgPihIeXfSiWHmW_hxrfmIgtQM9HWAPS2wVY	$BNEpFvlxqdDF-6u3EPToNgfx0BuYX2_P9oWB486xTxM	!kAToIwhNWrDpgQVMfY:localhost	f
$kL3ALUeGobajxL55gzYoIZLdD1CSD4sYXedIOysHwV0	$bFxX1nACgPihIeXfSiWHmW_hxrfmIgtQM9HWAPS2wVY	!kAToIwhNWrDpgQVMfY:localhost	f
$b_nOg7oeQd8bhYHe5kvgAdNM0U6hcAUFdf-yhgbItfc	$ab5rFOQQuDGj00oHfJaJKURhG6lNFNDKS0nkBlsLTMk	!cwnFZrIkYIOvkCHJkc:localhost	f
$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic	$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q	!LwtGEdNVvQHvFLuWQB:localhost	f
$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k	$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic	!LwtGEdNVvQHvFLuWQB:localhost	f
$PTHh0FcsZLrplrmwtCyvLjXr1yAZRgovFGLVt7qrrAo	$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k	!LwtGEdNVvQHvFLuWQB:localhost	f
$6CLZCTGtpIVnohQDg2sJwn_880f0--zCZpr6BgOwQ2Q	$PTHh0FcsZLrplrmwtCyvLjXr1yAZRgovFGLVt7qrrAo	!LwtGEdNVvQHvFLuWQB:localhost	f
$nKXxWIIoo5Vko9Z7kITUEeAsQgQnr-FLvhoQHfkCYAE	$6CLZCTGtpIVnohQDg2sJwn_880f0--zCZpr6BgOwQ2Q	!LwtGEdNVvQHvFLuWQB:localhost	f
$TbFvVskFwRsxEgjNnOjfs4ljMJuZC60_Cqb91vOUrxg	$nKXxWIIoo5Vko9Z7kITUEeAsQgQnr-FLvhoQHfkCYAE	!LwtGEdNVvQHvFLuWQB:localhost	f
$Fu0mjSRDDuhZx4RxMK6O8cvc6t75G99rXoFXGU-7868	$TbFvVskFwRsxEgjNnOjfs4ljMJuZC60_Cqb91vOUrxg	!LwtGEdNVvQHvFLuWQB:localhost	f
$SuM_AupYZSEtAJBPHbvNkhJ4aIYEjT4c741wzkoOX4I	$Fu0mjSRDDuhZx4RxMK6O8cvc6t75G99rXoFXGU-7868	!LwtGEdNVvQHvFLuWQB:localhost	f
$yrfdAmX0K0lY65Dm9bViRYWOBKtvTB1kxkm6lNsThdw	$_-6CgruWK6UfiL1rgJnNUgtmp_jusf_3Vf7LUPB6xaU	!GNlLBsLXjbOuNhCkEO:localhost	f
$uKKFUGwf_IAnbH81DTvAScd2HFnAwWWL_p4-E5B_YdU	$yrfdAmX0K0lY65Dm9bViRYWOBKtvTB1kxkm6lNsThdw	!GNlLBsLXjbOuNhCkEO:localhost	f
$MRytSYI-n7aCgzUssVx9vLIC5Y-Yt22y_L1eQoE4GgE	$uKKFUGwf_IAnbH81DTvAScd2HFnAwWWL_p4-E5B_YdU	!GNlLBsLXjbOuNhCkEO:localhost	f
$ah5gH_XfCIYeCtl2NFxHSgdd_OE6O9tHe2U1Pn2Qvhc	$MRytSYI-n7aCgzUssVx9vLIC5Y-Yt22y_L1eQoE4GgE	!GNlLBsLXjbOuNhCkEO:localhost	f
$lnpmPOjrFoaPq58156r6g4G7gYfejQ2BfcFkjGiEX-I	$ah5gH_XfCIYeCtl2NFxHSgdd_OE6O9tHe2U1Pn2Qvhc	!GNlLBsLXjbOuNhCkEO:localhost	f
$fuvIFJYv32qkEsYyW8XNHbQ0hmQ5HHRjF6UEjte6Z-c	$lnpmPOjrFoaPq58156r6g4G7gYfejQ2BfcFkjGiEX-I	!GNlLBsLXjbOuNhCkEO:localhost	f
$smbpaz4v1tYoI0ZZ-HXKXrcs19S7qioXa8ah6FeOBpc	$SuM_AupYZSEtAJBPHbvNkhJ4aIYEjT4c741wzkoOX4I	!LwtGEdNVvQHvFLuWQB:localhost	f
$O-kcGXcFLVtSNAY7CxqW4hLVBk0UqhADtIs1kCz8hlA	$smbpaz4v1tYoI0ZZ-HXKXrcs19S7qioXa8ah6FeOBpc	!LwtGEdNVvQHvFLuWQB:localhost	f
$vesveJhdimZ9d-Po76D8SZCUm8dVzl0GcQsvVX8lhos	$fuvIFJYv32qkEsYyW8XNHbQ0hmQ5HHRjF6UEjte6Z-c	!GNlLBsLXjbOuNhCkEO:localhost	f
$nfronhC7iKGPRmKJ7zoXzYG7VKiOq5FoUIcfHg3a4Dg	$vesveJhdimZ9d-Po76D8SZCUm8dVzl0GcQsvVX8lhos	!GNlLBsLXjbOuNhCkEO:localhost	f
$gDW6j_UqhvIRf1ANEKurSD9fB4Hl4YnQ5uL9cy_U7Os	$AMnH95Ky85GttLR7j9XHrHyULlBBezFJ9w8mtji-7Ok	!nPrdOOfNMRrmJedabn:localhost	f
$eOC3-FZNb3jb3NisHG61gQhQ_hf9zWu0xvpfs8ZKDTg	$MT4EKTmcPC8LCVeATiG-5a71N2Zc1vNQcgKge5W0on8	!MrxfbdodytWwBMqNiF:localhost	f
$Pem9TyngNuhpIq_NI2krx6wpkVigoBj6JCeB3WUezVk	$Nv-ymHeLYsZKVjdilAoBLGC4GlzNJWt1HBqtIlSIz1k	!MrxfbdodytWwBMqNiF:localhost	f
$Fe89WlTUpNMZrgSmSzGQHSt495sI5DkA-kewln3Ug70	$Pem9TyngNuhpIq_NI2krx6wpkVigoBj6JCeB3WUezVk	!MrxfbdodytWwBMqNiF:localhost	f
$viSFX8RvY5fe8TiOaDirNG6PqooEHTTV3PT3hrQgVLA	$Fe89WlTUpNMZrgSmSzGQHSt495sI5DkA-kewln3Ug70	!MrxfbdodytWwBMqNiF:localhost	f
$2lEnFzGdtIu4kGthBBXcP0gW6sUWKP8c1x9I4-yFWso	$0gszMJtyESzwVMh4olwTajdbj1MrrJYVnylO0yOIpSg	!nPrdOOfNMRrmJedabn:localhost	f
$yfuDQBYjEI6CCa3AdtfdjL_ZXIR0d92TRfHnh7Gq0zc	$2lEnFzGdtIu4kGthBBXcP0gW6sUWKP8c1x9I4-yFWso	!nPrdOOfNMRrmJedabn:localhost	f
$xyV3lysb-dda01bB4LpALdmaTC_mLZDhwxOE9L4zpXY	$yfuDQBYjEI6CCa3AdtfdjL_ZXIR0d92TRfHnh7Gq0zc	!nPrdOOfNMRrmJedabn:localhost	f
$MT4EKTmcPC8LCVeATiG-5a71N2Zc1vNQcgKge5W0on8	$viSFX8RvY5fe8TiOaDirNG6PqooEHTTV3PT3hrQgVLA	!MrxfbdodytWwBMqNiF:localhost	f
$AMnH95Ky85GttLR7j9XHrHyULlBBezFJ9w8mtji-7Ok	$A5h106ytjQ2qqPxkSylhOkJgVZQCscB4QX0PK60qxU0	!nPrdOOfNMRrmJedabn:localhost	f
$0gszMJtyESzwVMh4olwTajdbj1MrrJYVnylO0yOIpSg	$gDW6j_UqhvIRf1ANEKurSD9fB4Hl4YnQ5uL9cy_U7Os	!nPrdOOfNMRrmJedabn:localhost	f
$usag8slAxKA2dWWERksMiBQ8hRwfGZ8nZzTfcymZxyE	$xyV3lysb-dda01bB4LpALdmaTC_mLZDhwxOE9L4zpXY	!nPrdOOfNMRrmJedabn:localhost	f
$O04OV5x9R_5W2IT9G9Z-dXJmfV6fgtZM8-4ogFp9rEw	$NxuVtjeVql0_aadDlNux0yeeR_PxcpcJPnX1SdoDmXM	!dKcbdDATuwwphjRPQP:localhost	f
$-QMfwsu75_SWJtzFqIsrFjLgl_XBqF6HcorcUjLTsWY	$O04OV5x9R_5W2IT9G9Z-dXJmfV6fgtZM8-4ogFp9rEw	!dKcbdDATuwwphjRPQP:localhost	f
$Wj4b7gcXdhL474sxg5O6Kh7tBw4O5BtHv_KJEd3KXfM	$opS4sT6APXaq4vDdegPq6ik1z-yX-FkMTAqhGtTWXEE	!kmbTYjjsDRDHGgVqUP:localhost	f
$ZYEqhm3M07nXRAh1U842uZ1squBm9wa5H1Wb2-LjE1c	$Wj4b7gcXdhL474sxg5O6Kh7tBw4O5BtHv_KJEd3KXfM	!kmbTYjjsDRDHGgVqUP:localhost	f
$WsVhQvsUsrFormgSdFA_Z_Io7y9fxZy5juqaM8oYpkg	$O-kcGXcFLVtSNAY7CxqW4hLVBk0UqhADtIs1kCz8hlA	!LwtGEdNVvQHvFLuWQB:localhost	f
$r8P3KtaOOCBm8XKydsvp0N-cG5BAE1YKU5MumKzWUI8	$nfronhC7iKGPRmKJ7zoXzYG7VKiOq5FoUIcfHg3a4Dg	!GNlLBsLXjbOuNhCkEO:localhost	f
$p0-tc7QWKDmREIJlluolf1RQ-uKnVDhx5d_JQY9PX5E	$-QMfwsu75_SWJtzFqIsrFjLgl_XBqF6HcorcUjLTsWY	!dKcbdDATuwwphjRPQP:localhost	f
$GmUIImAeTzvNSV5qvb40ScXGL3dlsX4DDnmg28rkzk4	$ZYEqhm3M07nXRAh1U842uZ1squBm9wa5H1Wb2-LjE1c	!kmbTYjjsDRDHGgVqUP:localhost	f
$hooKnajA7nQRs3MZDj_evGyHCyHpg4QmGp2i5WRKzp0	$-JWBJJpXpVo-YhtBYaJDTakzo94Jhn_XGlhnLzEWxyc	!UKcoTBWWxNEyixrjyM:localhost	f
$kwgJJLzgJAXgzd-lj8uFVnrjX5yqfNOtOcPrcl87hXU	$hooKnajA7nQRs3MZDj_evGyHCyHpg4QmGp2i5WRKzp0	!UKcoTBWWxNEyixrjyM:localhost	f
$rNG4YvsFCU9LVcVcHEkbBRGSuEH_QqO_hMEZ-sC8WH8	$kL3ALUeGobajxL55gzYoIZLdD1CSD4sYXedIOysHwV0	!kAToIwhNWrDpgQVMfY:localhost	f
\.


--
-- Data for Name: event_expiry; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_expiry (event_id, expiry_ts) FROM stdin;
\.


--
-- Data for Name: event_forward_extremities; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_forward_extremities (event_id, room_id) FROM stdin;
$eOC3-FZNb3jb3NisHG61gQhQ_hf9zWu0xvpfs8ZKDTg	!MrxfbdodytWwBMqNiF:localhost
$usag8slAxKA2dWWERksMiBQ8hRwfGZ8nZzTfcymZxyE	!nPrdOOfNMRrmJedabn:localhost
$WsVhQvsUsrFormgSdFA_Z_Io7y9fxZy5juqaM8oYpkg	!LwtGEdNVvQHvFLuWQB:localhost
$r8P3KtaOOCBm8XKydsvp0N-cG5BAE1YKU5MumKzWUI8	!GNlLBsLXjbOuNhCkEO:localhost
$p0-tc7QWKDmREIJlluolf1RQ-uKnVDhx5d_JQY9PX5E	!dKcbdDATuwwphjRPQP:localhost
$GmUIImAeTzvNSV5qvb40ScXGL3dlsX4DDnmg28rkzk4	!kmbTYjjsDRDHGgVqUP:localhost
$kwgJJLzgJAXgzd-lj8uFVnrjX5yqfNOtOcPrcl87hXU	!UKcoTBWWxNEyixrjyM:localhost
$rNG4YvsFCU9LVcVcHEkbBRGSuEH_QqO_hMEZ-sC8WH8	!kAToIwhNWrDpgQVMfY:localhost
$tWJ40KRMdaZwn6df_597mz_AyHLHUSEy0noQk3HlctY	!ffaaxOMHcWnINEXTWK:localhost
$b_nOg7oeQd8bhYHe5kvgAdNM0U6hcAUFdf-yhgbItfc	!cwnFZrIkYIOvkCHJkc:localhost
\.


--
-- Data for Name: event_json; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_json (event_id, room_id, internal_metadata, json, format_version) FROM stdin;
$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id": 2, "stream_ordering": 2}	{"auth_events": [], "prev_events": [], "type": "m.room.create", "room_id": "!kmbTYjjsDRDHGgVqUP:localhost", "sender": "@admin:localhost", "content": {"room_version": "5", "creator": "@admin:localhost"}, "depth": 1, "prev_state": [], "state_key": "", "origin": "localhost", "origin_server_ts": 1598686327756, "hashes": {"sha256": "EYS5stv7QephkSDEw4lMn8/fCE1EfcXS2SKhS9x689c"}, "signatures": {"localhost": {"ed25519:a_snHR": "47z+ybf1v6crQ75SkpwjCPDQ561xdI6SuXgpQHOugqlu7Qkvp1y2U97Z35JRCNa7R0sQvM4rVijYk+YgtbckDw"}}, "unsigned": {"age_ts": 1598686327756}}	3
$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id": 2, "stream_ordering": 3}	{"auth_events": ["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"], "prev_events": ["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"], "type": "m.room.member", "room_id": "!kmbTYjjsDRDHGgVqUP:localhost", "sender": "@admin:localhost", "content": {"membership": "join", "displayname": "admin"}, "depth": 2, "prev_state": [], "state_key": "@admin:localhost", "origin": "localhost", "origin_server_ts": 1598686327803, "hashes": {"sha256": "bFr14ZS6aZalThpjLQ5BkY11tTZqSnnNO5FjkIpsH+0"}, "signatures": {"localhost": {"ed25519:a_snHR": "pvC4gEUv8FV2lKeI3sP1lfY7/eRbZBfNpbWT8v4a8Y9pq+oWw1xozvImaXKjgKgnLKkfEL8U2SKf5Wzchv2iCg"}}, "unsigned": {"age_ts": 1598686327803}}	3
$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id": 2, "stream_ordering": 4}	{"auth_events": ["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU", "$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw"], "prev_events": ["$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw"], "type": "m.room.power_levels", "room_id": "!kmbTYjjsDRDHGgVqUP:localhost", "sender": "@admin:localhost", "content": {"users": {"@admin:localhost": 100}, "users_default": 50, "events": {"m.room.name": 50, "m.room.power_levels": 100, "m.room.history_visibility": 100, "m.room.canonical_alias": 50, "m.room.avatar": 50, "m.room.tombstone": 100, "m.room.server_acl": 100, "m.room.encryption": 100}, "events_default": 0, "state_default": 50, "ban": 50, "kick": 50, "redact": 50, "invite": 50}, "depth": 3, "prev_state": [], "state_key": "", "origin": "localhost", "origin_server_ts": 1598686327849, "hashes": {"sha256": "XRXI1VrMo2lX8l4Xw+9l9POam98NXILANHKa0cTiec8"}, "signatures": {"localhost": {"ed25519:a_snHR": "BpCH59dvjhLkXrhrLvAvctHHpDo5xjfKyPKNPURSOjO9a6M+bBF8BYorYCZ82nY6VuxkpcBEXfqoq0sTZtd3Bw"}}, "unsigned": {"age_ts": 1598686327849}}	3
$X8tdoEsXAgBC6gobCepAn3rwO8CJoQU6i9NN9Rzhukg	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id": 2, "stream_ordering": 5}	{"auth_events": ["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w", "$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU", "$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw"], "prev_events": ["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"], "type": "m.room.canonical_alias", "room_id": "!kmbTYjjsDRDHGgVqUP:localhost", "sender": "@admin:localhost", "content": {"alias": "#town-square:localhost"}, "depth": 4, "prev_state": [], "state_key": "", "origin": "localhost", "origin_server_ts": 1598686327933, "hashes": {"sha256": "JFEosUjTDFb17hL0ogqGvy8PsyFS5AfoImme80JxoBs"}, "signatures": {"localhost": {"ed25519:a_snHR": "fIKrBbyf1iHHSpgs1le6Qt6UIhEqGv37ptN9EYF20qOo80r2hFizzL4QUea1iU4Y2eXLXeSbgMyRIBTgNMqCCA"}}, "unsigned": {"age_ts": 1598686327933}}	3
$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id": 2, "stream_ordering": 6}	{"auth_events": ["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w", "$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU", "$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw"], "prev_events": ["$X8tdoEsXAgBC6gobCepAn3rwO8CJoQU6i9NN9Rzhukg"], "type": "m.room.join_rules", "room_id": "!kmbTYjjsDRDHGgVqUP:localhost", "sender": "@admin:localhost", "content": {"join_rule": "public"}, "depth": 5, "prev_state": [], "state_key": "", "origin": "localhost", "origin_server_ts": 1598686328055, "hashes": {"sha256": "jp1fVxbt3dpJlxSWBs8TDJPKkwiNi8RubTXSwOu2cDE"}, "signatures": {"localhost": {"ed25519:a_snHR": "O1DxN7P7TkUmUp2mTvmbynx8sE967SMMDNvWWukJhW/k0Eycxe1aORQInqOx03jBFS91blUjSiame9d4SsflDQ"}}, "unsigned": {"age_ts": 1598686328055}}	3
$O5iO4EII22igkDq5cMKHFB-SGIYD0KqJQXZohS2Dzc0	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id": 2, "stream_ordering": 7}	{"auth_events": ["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w", "$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU", "$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw"], "prev_events": ["$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o"], "type": "m.room.history_visibility", "room_id": "!kmbTYjjsDRDHGgVqUP:localhost", "sender": "@admin:localhost", "content": {"history_visibility": "shared"}, "depth": 6, "prev_state": [], "state_key": "", "origin": "localhost", "origin_server_ts": 1598686328127, "hashes": {"sha256": "O2HALjh6GpvXYKFGkSI+lQPuJUFwuC032xlArlAC5cU"}, "signatures": {"localhost": {"ed25519:a_snHR": "q2f7/7Q5deI4D976foS2hEJ2u5V5P+rShlUHGLrZ4F1H2xTj+UYejDJbqzhmp6fHwz/tlXtcij6B/PahZDlFCw"}}, "unsigned": {"age_ts": 1598686328127}}	3
$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost	{"token_id": 2, "stream_ordering": 8}	{"auth_events": [], "prev_events": [], "type": "m.room.create", "room_id": "!dKcbdDATuwwphjRPQP:localhost", "sender": "@admin:localhost", "content": {"room_version": "5", "creator": "@admin:localhost"}, "depth": 1, "prev_state": [], "state_key": "", "origin": "localhost", "origin_server_ts": 1598686328210, "hashes": {"sha256": "T2bzVfgzt2griHNrK55gMsLkl82Nz9F/wK3x7lQm0zA"}, "signatures": {"localhost": {"ed25519:a_snHR": "o9ngIVjMu0CXzzIzhHQj+YOJPsXjIAmlQdW+9L6ERQBo8fIQYDUESAAqjGJVhToPS1mFueV7SU7hGRWpd7JSCQ"}}, "unsigned": {"age_ts": 1598686328210}}	3
$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA	!dKcbdDATuwwphjRPQP:localhost	{"token_id": 2, "stream_ordering": 9}	{"auth_events": ["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"], "prev_events": ["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"], "type": "m.room.member", "room_id": "!dKcbdDATuwwphjRPQP:localhost", "sender": "@admin:localhost", "content": {"membership": "join", "displayname": "admin"}, "depth": 2, "prev_state": [], "state_key": "@admin:localhost", "origin": "localhost", "origin_server_ts": 1598686328245, "hashes": {"sha256": "U+/LJW/8SXvlDad8ry9B6gtyrwdAQgQrnsYdoLjFX4c"}, "signatures": {"localhost": {"ed25519:a_snHR": "UFL/8lWTieRcORLzp9XHt+jQ+3dtgGCMRtkmtgbJK1wtJsKvM0Vj+Se/PYxp9D9owNYTYvenbn+Ape9jAWmQDA"}}, "unsigned": {"age_ts": 1598686328245}}	3
$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost	{"token_id": 2, "stream_ordering": 10}	{"auth_events": ["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88", "$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA"], "prev_events": ["$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA"], "type": "m.room.power_levels", "room_id": "!dKcbdDATuwwphjRPQP:localhost", "sender": "@admin:localhost", "content": {"users": {"@admin:localhost": 100}, "users_default": 50, "events": {"m.room.name": 50, "m.room.power_levels": 100, "m.room.history_visibility": 100, "m.room.canonical_alias": 50, "m.room.avatar": 50, "m.room.tombstone": 100, "m.room.server_acl": 100, "m.room.encryption": 100}, "events_default": 0, "state_default": 50, "ban": 50, "kick": 50, "redact": 50, "invite": 50}, "depth": 3, "prev_state": [], "state_key": "", "origin": "localhost", "origin_server_ts": 1598686328280, "hashes": {"sha256": "uhHLqmMxCXLN+w/WytCiGDedq/bLxHrToWTEkOKf9ew"}, "signatures": {"localhost": {"ed25519:a_snHR": "MlX+Q/aDPzkzLhX5vXzxUqlIh1xTg7shPZ6xg5FfsX7xzRzjEyI/zEdQBts8ZNaN0S/rf9Nj43Bde2xRz1xICA"}}, "unsigned": {"age_ts": 1598686328280}}	3
$b__a7rX3L5YpX7nAZte73DAbjtXZK48JH8VKSnGOKKw	!dKcbdDATuwwphjRPQP:localhost	{"token_id": 2, "stream_ordering": 11}	{"auth_events": ["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII", "$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88", "$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA"], "prev_events": ["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"], "type": "m.room.canonical_alias", "room_id": "!dKcbdDATuwwphjRPQP:localhost", "sender": "@admin:localhost", "content": {"alias": "#off-topic:localhost"}, "depth": 4, "prev_state": [], "state_key": "", "origin": "localhost", "origin_server_ts": 1598686328305, "hashes": {"sha256": "+JxLKTsEQryx+GEAalUCnv6Rke8EWjX/fPemyJsDHYc"}, "signatures": {"localhost": {"ed25519:a_snHR": "Cjxg3dN0RmH45DnHWi6hpxa+uebFjCgGQV7rVZrz07nq0D2m/m6xetGsZChX81YA7bTlSaZYZbguZo25iAhsBA"}}, "unsigned": {"age_ts": 1598686328305}}	3
$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost	{"token_id": 2, "stream_ordering": 12}	{"auth_events": ["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII", "$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88", "$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA"], "prev_events": ["$b__a7rX3L5YpX7nAZte73DAbjtXZK48JH8VKSnGOKKw"], "type": "m.room.join_rules", "room_id": "!dKcbdDATuwwphjRPQP:localhost", "sender": "@admin:localhost", "content": {"join_rule": "public"}, "depth": 5, "prev_state": [], "state_key": "", "origin": "localhost", "origin_server_ts": 1598686328338, "hashes": {"sha256": "dxq9CFlffHYBvZuBxLJd5stg6IQ3QXbXZ+NE6ebxX70"}, "signatures": {"localhost": {"ed25519:a_snHR": "Uxvxrm+8J8TXY4TQmd21VQ8FquEl8i2G+J4Key2ULCdTPPuLYVzHptZ2XsY+qVkQQ/j7O8GzZor91QnuTO6OAQ"}}, "unsigned": {"age_ts": 1598686328338}}	3
$TVnvv0nGbLydCBtMmTTz-htMsoI4hmxCr3s9AHyFGHQ	!dKcbdDATuwwphjRPQP:localhost	{"token_id": 2, "stream_ordering": 13}	{"auth_events": ["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII", "$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88", "$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA"], "prev_events": ["$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs"], "type": "m.room.history_visibility", "room_id": "!dKcbdDATuwwphjRPQP:localhost", "sender": "@admin:localhost", "content": {"history_visibility": "shared"}, "depth": 6, "prev_state": [], "state_key": "", "origin": "localhost", "origin_server_ts": 1598686328366, "hashes": {"sha256": "SfV6Kek5Dwi5pw8ipLU5QhGIZ2QJnoj9F6CDcc5IxB4"}, "signatures": {"localhost": {"ed25519:a_snHR": "5ykJ0Blf6mxyCyowVrPMqCBd1CoGzhyHcTYeI54eSztGls6SbF9v0VY23IxdEiYh6Sbb4p/YqhWE5BK0bC99Dg"}}, "unsigned": {"age_ts": 1598686328366}}	3
$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id": 3, "stream_ordering": 14}	{"auth_events": ["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w", "$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU", "$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o"], "prev_events": ["$O5iO4EII22igkDq5cMKHFB-SGIYD0KqJQXZohS2Dzc0"], "type": "m.room.member", "room_id": "!kmbTYjjsDRDHGgVqUP:localhost", "sender": "@matrix_a:localhost", "content": {"membership": "join", "displayname": "matrix_a"}, "depth": 7, "prev_state": [], "state_key": "@matrix_a:localhost", "origin": "localhost", "origin_server_ts": 1598686328406, "hashes": {"sha256": "qLMDs9emxYRXqTqqxoKZcDmjV5VXvdIs3XRGMxFZnbk"}, "signatures": {"localhost": {"ed25519:a_snHR": "xsf3Ds6FQ7mG4614Oiydc3TFdQak3qCYQ/OTfnE+Yd8GclvIc/cMtCrz5VTAjRLIHwoctkLkHraQcxnHkFzwCw"}}, "unsigned": {"age_ts": 1598686328406}}	3
$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0	!dKcbdDATuwwphjRPQP:localhost	{"token_id": 3, "stream_ordering": 15}	{"auth_events": ["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII", "$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88", "$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs"], "prev_events": ["$TVnvv0nGbLydCBtMmTTz-htMsoI4hmxCr3s9AHyFGHQ"], "type": "m.room.member", "room_id": "!dKcbdDATuwwphjRPQP:localhost", "sender": "@matrix_a:localhost", "content": {"membership": "join", "displayname": "matrix_a"}, "depth": 7, "prev_state": [], "state_key": "@matrix_a:localhost", "origin": "localhost", "origin_server_ts": 1598686328450, "hashes": {"sha256": "Bf7Ixij40HV9U18YkDyyR2LTpCTLLhlY3GoSLyLra6c"}, "signatures": {"localhost": {"ed25519:a_snHR": "qsG72VTiWey+fdCVuq4zZWl8IPFwfI1GBpO4iL+axu/ctL5BEo/YYJmWmTJMOz3z4ZyLj8NN/QpwX+p2A8BRDA"}}, "unsigned": {"age_ts": 1598686328450}}	3
$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0	!dKcbdDATuwwphjRPQP:localhost	{"token_id": 4, "stream_ordering": 17}	{"auth_events": ["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII", "$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88", "$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs"], "prev_events": ["$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0"], "type": "m.room.member", "room_id": "!dKcbdDATuwwphjRPQP:localhost", "sender": "@matrix_b:localhost", "content": {"membership": "join", "displayname": "matrix_b"}, "depth": 8, "prev_state": [], "state_key": "@matrix_b:localhost", "origin": "localhost", "origin_server_ts": 1598686328533, "hashes": {"sha256": "uTzAP3DsMrG8vtss7fDEFt+NvMlkJcrp1JpDI+zCYJw"}, "signatures": {"localhost": {"ed25519:a_snHR": "KebfBSToXNEpvTIjoOVA/dUohbdbS6NpSahz9yHvU1HfdpsPGqxwxrwMNuhXaRHzRO6hV0VNgIKyN09GaKNZCg"}}, "unsigned": {"age_ts": 1598686328533}}	3
$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A	!dKcbdDATuwwphjRPQP:localhost	{"token_id": 5, "stream_ordering": 19}	{"auth_events": ["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII", "$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs", "$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"], "prev_events": ["$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0"], "type": "m.room.member", "room_id": "!dKcbdDATuwwphjRPQP:localhost", "sender": "@ignored_user:localhost", "content": {"membership": "join", "displayname": "ignored_user"}, "depth": 9, "prev_state": [], "state_key": "@ignored_user:localhost", "origin": "localhost", "origin_server_ts": 1598686328616, "hashes": {"sha256": "jMkusmfkT7UyF+M8kX/BlBE9cfKlzHtTJumYpcHpBus"}, "signatures": {"localhost": {"ed25519:a_snHR": "OqjM8HC+e4wgWSg64xtgWjy8XhQfXWRLcTO8eDmzywvsGEetzg2MbNi+8UeaO+k0HgySjOQdD+uU794G1VQcBA"}}, "unsigned": {"age_ts": 1598686328616}}	3
$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id": 4, "stream_ordering": 16}	{"auth_events": ["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w", "$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU", "$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o"], "prev_events": ["$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8"], "type": "m.room.member", "room_id": "!kmbTYjjsDRDHGgVqUP:localhost", "sender": "@matrix_b:localhost", "content": {"membership": "join", "displayname": "matrix_b"}, "depth": 8, "prev_state": [], "state_key": "@matrix_b:localhost", "origin": "localhost", "origin_server_ts": 1598686328493, "hashes": {"sha256": "cH8tXUk5lxa0k+40sn0aVCgn+JhxncHg3R/oYnHUDlU"}, "signatures": {"localhost": {"ed25519:a_snHR": "C43sosgS9LF5roZP7JiJGmrZR2O9nHvC+mPvYZ0+qDm58WLnmpjC0B8Y8Txye0OoW8HsBqxhJQf10txK8vI6CQ"}}, "unsigned": {"age_ts": 1598686328493}}	3
$89n67RlAmtb8nRuxie-oq3g9grnkpjzJMAhbJ8h_8Xw	!MrxfbdodytWwBMqNiF:localhost	{"token_id":16,"historical":false}	{"auth_events":["$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY"],"prev_events":["$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY"],"type":"m.room.member","room_id":"!MrxfbdodytWwBMqNiF:localhost","sender":"@bridgeuser1:localhost","content":{"membership":"join","displayname":"bridgeuser1"},"depth":2,"prev_state":[],"state_key":"@bridgeuser1:localhost","origin":"localhost","origin_server_ts":1672417353612,"hashes":{"sha256":"C6JZQudHFcwFcv6tZSb70OfV2Zo8COUsivmwPAQJSMw"},"signatures":{"localhost":{"ed25519:a_CHdg":"5lSx+oVC9ks+9Bu8ZsLVn4NomT3cylywCPqg2jP700Vhq2gUmrwikSNGI65gFyrFQVDzMuyClNn7X/cyVzt8DQ"}},"unsigned":{"age_ts":1672417353612}}	3
$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id": 5, "stream_ordering": 18}	{"auth_events": ["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w", "$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o", "$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"], "prev_events": ["$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk"], "type": "m.room.member", "room_id": "!kmbTYjjsDRDHGgVqUP:localhost", "sender": "@ignored_user:localhost", "content": {"membership": "join", "displayname": "ignored_user"}, "depth": 9, "prev_state": [], "state_key": "@ignored_user:localhost", "origin": "localhost", "origin_server_ts": 1598686328575, "hashes": {"sha256": "D/rwxkYqWZ03Kws7Xsq84khdp4oGHRGnOy4+XwM8dLA"}, "signatures": {"localhost": {"ed25519:a_snHR": "kXK8xKjLjJ97KcFQivelEBI1TR/au+bgtD6i2VPDp9LjRi1bVH/zb6YqHZetT0JYaGt3NY4iFeN0Qh0mD4zyAg"}}, "unsigned": {"age_ts": 1598686328575}}	3
$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"depth":10,"prev_state":[],"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1672393388391,"hashes":{"sha256":"R4SCVXL+1RKO01yO3g9ff5u+esSiGOkuvBQWTaocyUA"},"signatures":{"localhost":{"ed25519:a_CHdg":"H6Lt/+BvAM2B74Y4kAtCpNJhKroJwBNriEgkTDzNciC6N5kF0RgKNu/uND7QE0LAQQeu44XHCTO6eDFstATrCQ"}},"unsigned":{"age_ts":1672393388391}}	3
$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"depth":10,"prev_state":[],"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1672393388388,"hashes":{"sha256":"3LfuqIEvZtngjbXYu9kNdxtg1D/81ZTFrC7GhYWzDaQ"},"signatures":{"localhost":{"ed25519:a_CHdg":"DSPvTLVUy+2DlzidsRWKhpC7La7zEpbQvZrlD2Tq9WqU6s66usfuFGNEnALVsCppX9IKILORXqGg+SuPK1ISBA"}},"unsigned":{"age_ts":1672393388388}}	3
$7TwPfUMTevEcf7wLvbgx3LG01lYT_yGudYiOVlkGU7E	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"mattermost_b [mm]"},"depth":11,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672393389898,"hashes":{"sha256":"mWoL31KlmHVowtRAVpw0lZKlVyTgAoQuOAh3LGsayC0"},"signatures":{"localhost":{"ed25519:a_CHdg":"WaAjS05WQtJGm8qc3r1yv3KkpApJHXdgSOMv8KT5i/82nl+2m97cDHtDiqykGi+wcR63iiMY9qeYOxHyyKP5Dg"}},"unsigned":{"age_ts":1672393389898,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#off-topic:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$jAifmicJfMyB1QPFQ6KFQ7ZqTqQ58RJXsH5viWn3ZUg	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"mattermost_b [mm]"},"depth":11,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672393390194,"hashes":{"sha256":"fUHmPtR9elSeoB+9fsX5EFUKIhd+mvsIVucKO15Cw0U"},"signatures":{"localhost":{"ed25519:a_CHdg":"Q0+gDgYYxCxPJIH/8v0r1Tck5Q9RfCvUUGTUjTjCyMnnwxb0aNu5NRen/df1BgmbR/T0nTzeTzWOwKQvwvEFDQ"}},"unsigned":{"age_ts":1672393390194,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#town-square:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$DsZXxk2rEIB2tF3pYUdOPjrMwclo8BXltutiWCnKUIU	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$7TwPfUMTevEcf7wLvbgx3LG01lYT_yGudYiOVlkGU7E"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"MattermostUser A [mm]"},"depth":12,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672393390226,"hashes":{"sha256":"mRcdcYOOr9Dss2mhUxuGMEh71/pJbHtL6+hviavJJoY"},"signatures":{"localhost":{"ed25519:a_CHdg":"5QVnrOTeZli8kaH2Iz5Ht68alSpcdWwUzsUS43bUTpxkPNW7eS1zeLx/7bOnjbV2t/97A5t1XuRxKzDJ67Q4AA"}},"unsigned":{"age_ts":1672393390226,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#off-topic:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$kmvnPONhcKxIpG62sV6apngYToshpP0mBrwpKL0hAOI	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$g1kV-jEZBtN9l6VGGo2MN-wQn7RR7J-Tv5LfyJ5Z5fc","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$YFCWkh6b_jgrSjje7vt6JB6-uLPRz7Na1VgGh0PwdI8"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_matrix_matrix_a:localhost","content":{"membership":"join","displayname":"Matrix UserA [mm]"},"depth":20,"prev_state":[],"state_key":"@mm_matrix_matrix_a:localhost","origin":"localhost","origin_server_ts":1672416528584,"hashes":{"sha256":"Sssuorbq1zG+9q0KRaMpV0/lxWFcLCKp8Jl/T2+kNhw"},"signatures":{"localhost":{"ed25519:a_CHdg":"u0szG9ZPvyPBs7kj/Cp+J3MgYwgRSUMD5Ibm7wSpprm+1rT9tVUoo6bur/D5zw8IoV8mOrJU100cwKaQJtloBA"}},"unsigned":{"age_ts":1672416528584,"replaces_state":"$g1kV-jEZBtN9l6VGGo2MN-wQn7RR7J-Tv5LfyJ5Z5fc"}}	3
$NyVGoA-ZaMPbk_RzpmLOajRS1nEBirO7Du2KpA9Eo64	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$jAifmicJfMyB1QPFQ6KFQ7ZqTqQ58RJXsH5viWn3ZUg"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"MattermostUser A [mm]"},"depth":12,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672393390388,"hashes":{"sha256":"6CRO4w5SOw0RYf46VZdswy9dQITneySD15UvwvxcazE"},"signatures":{"localhost":{"ed25519:a_CHdg":"jGPWrwQSRNyxFYfoZ4R0UiVtjPwXhD4YveNZIaxIBLg9LYbmqbzxrxEbAxriyefPQdfeQ6EemA6AyPjt9R55Ag"}},"unsigned":{"age_ts":1672393390388,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#town-square:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$JwL8EK5sa4vg29tclnHwa5jrpCTa8oZVOIsgFyivQdY	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$7TwPfUMTevEcf7wLvbgx3LG01lYT_yGudYiOVlkGU7E","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$DsZXxk2rEIB2tF3pYUdOPjrMwclo8BXltutiWCnKUIU"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_b:localhost","content":{"membership":"join","displayname":"mattermost_b [mm]"},"depth":13,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672393390408,"hashes":{"sha256":"FJtdn6aZkIgyfZUqdJOFkXKsLciKsbQWxSNeJytYM3k"},"signatures":{"localhost":{"ed25519:a_CHdg":"zHPhMVGtgJAe3+ilmcCnGrrVxTK5lrp/cizLdivuSYB8N+az1+0eCa19XZto1GqSpN0PovxoCHLL7MuT9nClBA"}},"unsigned":{"age_ts":1672393390408,"replaces_state":"$7TwPfUMTevEcf7wLvbgx3LG01lYT_yGudYiOVlkGU7E"}}	3
$JcoTJcBGASUqIK9V7j6ND5Jt6P9gdbNJxXxQBZNg8z4	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$jAifmicJfMyB1QPFQ6KFQ7ZqTqQ58RJXsH5viWn3ZUg","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$NyVGoA-ZaMPbk_RzpmLOajRS1nEBirO7Du2KpA9Eo64"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_b:localhost","content":{"membership":"join","displayname":"mattermost_b [mm]"},"depth":13,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672393390567,"hashes":{"sha256":"zAo8RJPla4ZfxK6IZ5RXRAcKdKraqtXfarG5GnGdVPc"},"signatures":{"localhost":{"ed25519:a_CHdg":"mJt0DBfkdhoq2JG2mGF8AY6c84o3fTCc3geS6xLGINUiXMsfSeq6diocrvPyy6GWrtAtPyOiFVlz7DWRXQSUDQ"}},"unsigned":{"age_ts":1672393390567,"replaces_state":"$jAifmicJfMyB1QPFQ6KFQ7ZqTqQ58RJXsH5viWn3ZUg"}}	3
$2KnXfE3sZw8LDrOAaEP4HdQuw5neshhvyZKtnwo5cg0	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$DsZXxk2rEIB2tF3pYUdOPjrMwclo8BXltutiWCnKUIU","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$JwL8EK5sa4vg29tclnHwa5jrpCTa8oZVOIsgFyivQdY"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_a:localhost","content":{"membership":"join","displayname":"MattermostUser A [mm]"},"depth":14,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672393390608,"hashes":{"sha256":"IDIp1Hs2PtibZ8hwbta4UYabbdwgyxPdkDibc8WPIqg"},"signatures":{"localhost":{"ed25519:a_CHdg":"tC9J8pXWZ+RfD24krnBnn6knuX25VQ6MtOeu1V8mUcuk67CIDSZ/y1wMywr1SopUOBT7fQBIUZEtVOmMUrTtAg"}},"unsigned":{"age_ts":1672393390608,"replaces_state":"$DsZXxk2rEIB2tF3pYUdOPjrMwclo8BXltutiWCnKUIU"}}	3
$isXWKf_B_7Z7R7jYn_2gZB-U31TuzMehBRxj5701Lq8	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$NyVGoA-ZaMPbk_RzpmLOajRS1nEBirO7Du2KpA9Eo64","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$JcoTJcBGASUqIK9V7j6ND5Jt6P9gdbNJxXxQBZNg8z4"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"membership":"join","displayname":"MattermostUser A [mm]"},"depth":14,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672393390746,"hashes":{"sha256":"/INJGHE3RCmBbnw0dvJZ7qHDmn+73PAYEcxpcg6cfXE"},"signatures":{"localhost":{"ed25519:a_CHdg":"5rtR1M1XhiZUPocSQJgWFnIGG6Z5yElgj9z6h9mkWwvTrj2d/J3ScENQ0QCHBlGKE8OLVCsH2yztm5ecibxICg"}},"unsigned":{"age_ts":1672393390746,"replaces_state":"$NyVGoA-ZaMPbk_RzpmLOajRS1nEBirO7Du2KpA9Eo64"}}	3
$rVK77mVSpz5EHxI2mbLxilqbkLxKhXEiusPFjapVPbw	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$isXWKf_B_7Z7R7jYn_2gZB-U31TuzMehBRxj5701Lq8"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"MattermostUser A [mm]"},"depth":15,"prev_state":[],"state_key":"@mm_mattermost_a_:localhost","origin":"localhost","origin_server_ts":1672416526671,"hashes":{"sha256":"V5Ohu1yHV3UNInk4ha4FY7+ffC+PtMoQ54GwT/o2xDE"},"signatures":{"localhost":{"ed25519:a_CHdg":"v9CkvYGDrmGuuXMqPqb6J0xqHRq4w8USB8TqB4/p0SlnOt1M695rZceDinbbOX6tSeTgPQ/X/NwZadd00lmJBg"}},"unsigned":{"age_ts":1672416526671,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#town-square:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$KgpvpFIMQIVFvm0adBZqAbWANmMgdu1_1jbP71RuM48	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$GrqoJ52XSgRaoc4wPEYLdL2p6t3jl0aiFd8bYswQQcU","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o"],"prev_events":["$h2yGPxzdKWUBUSFQiOgFiRoNa8NgWHYXdy_2SMJx6ns"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_matrix_matrix_b:localhost","content":{"membership":"join","displayname":"matrix_b [mm]"},"depth":22,"prev_state":[],"state_key":"@mm_matrix_matrix_b:localhost","origin":"localhost","origin_server_ts":1672416528702,"hashes":{"sha256":"kl1fyWZODos3M5BQd8ylv8WPs2cEPzjnKC42Ux7hD4Q"},"signatures":{"localhost":{"ed25519:a_CHdg":"4ON8VaCUuClmct9ojZbPLjHsEuSTrab1CqF9KqPJ/uUGpc8Py1zUhwRSIA9wqCbsQhbFSKipVSXQaZQr+71IDA"}},"unsigned":{"age_ts":1672416528702,"replaces_state":"$GrqoJ52XSgRaoc4wPEYLdL2p6t3jl0aiFd8bYswQQcU"}}	3
$5agO4kI6VqJHGKvKbkqUa2Y3cTwUBrjAhmCVtj9JmKU	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$rVK77mVSpz5EHxI2mbLxilqbkLxKhXEiusPFjapVPbw"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"mattermost_b [mm]"},"depth":16,"prev_state":[],"state_key":"@mm_mattermost_b_:localhost","origin":"localhost","origin_server_ts":1672416527105,"hashes":{"sha256":"vWHrcVteFdK+cHErXEmc4CfvRtq4pP0lKCoDOekgX48"},"signatures":{"localhost":{"ed25519:a_CHdg":"E2p7x5YWKJykUDag2eT5rcsJNyJpsunaA1qil2yRFATWoThu4TZwGtWRZa+s3e2+3jQ8L3SyPu0cnyxImLzdCQ"}},"unsigned":{"age_ts":1672416527105,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#town-square:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$4JiNeQHyMbyuEfymLkE-SEzPUh3bWddjxa6-5w36nJw	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$2KnXfE3sZw8LDrOAaEP4HdQuw5neshhvyZKtnwo5cg0"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"matrix_b [mm]"},"depth":15,"prev_state":[],"state_key":"@mm_matrix_matrix_b:localhost","origin":"localhost","origin_server_ts":1672416527341,"hashes":{"sha256":"T4RWiD0YIypL3HHclZvGCmacQurtuA9aDa1l6xGcsv8"},"signatures":{"localhost":{"ed25519:a_CHdg":"Rg0jlwumPnuOXF/wSXop2nmmjkJUwwUAhsD3HVzlK5q4N6IJVzYZlYh4+kNrW4/3lK47x3GzXVu1tYk4ouXEAA"}},"unsigned":{"age_ts":1672416527341,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#off-topic:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$Y_S-fF0iLu0OHNMcZdYVzt0we_qL_t8_4QIKGeobLdI	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$5agO4kI6VqJHGKvKbkqUa2Y3cTwUBrjAhmCVtj9JmKU"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"Matrix UserA [mm]"},"depth":17,"prev_state":[],"state_key":"@mm_matrix_matrix_a:localhost","origin":"localhost","origin_server_ts":1672416527487,"hashes":{"sha256":"2R0l/KvmOxa5RhVsBECzBVxx0JREDza2CtS2oTxZmJY"},"signatures":{"localhost":{"ed25519:a_CHdg":"OKWi538WWbyhK5kpdVaq6i00ie+W5zKdoF7RmAVlqsWU7vCT0tnmY+nhr8D+97BN1VUGGoin432nlbwUIy51Bw"}},"unsigned":{"age_ts":1672416527487,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#town-square:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$g1kV-jEZBtN9l6VGGo2MN-wQn7RR7J-Tv5LfyJ5Z5fc	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$4JiNeQHyMbyuEfymLkE-SEzPUh3bWddjxa6-5w36nJw"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"Matrix UserA [mm]"},"depth":16,"prev_state":[],"state_key":"@mm_matrix_matrix_a:localhost","origin":"localhost","origin_server_ts":1672416527629,"hashes":{"sha256":"oH0aKCILSfByNUyqt+GJC92N887TG4BvHkPdsgVsK1U"},"signatures":{"localhost":{"ed25519:a_CHdg":"N9LJK3gHk/SIx8cVcm/ND7HM8jiK+BYhhwxjlqGuKgTy6jKdZRR0xWkv1HQkEzYe1U1N4N0LxoKwK/MOE517BQ"}},"unsigned":{"age_ts":1672416527629,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#off-topic:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$CQg_jKvdpWFvaiLH2f5MtTnu1Zwxi8P4QPSJZum91dw	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$rVK77mVSpz5EHxI2mbLxilqbkLxKhXEiusPFjapVPbw"],"prev_events":["$Y_S-fF0iLu0OHNMcZdYVzt0we_qL_t8_4QIKGeobLdI"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a_:localhost","content":{"membership":"join","displayname":"MattermostUser A [mm]"},"depth":18,"prev_state":[],"state_key":"@mm_mattermost_a_:localhost","origin":"localhost","origin_server_ts":1672416527745,"hashes":{"sha256":"SX6V2KFSlRETcz+etQqUUjuGKjhw0TiV4GdgNTX7+ts"},"signatures":{"localhost":{"ed25519:a_CHdg":"MOUDpSWUTIq8K5QuTIBh6uJ7W5+bN9I/94TVM7iQGHdFPpAjxKCCrAyFuyxXnX5EK+C8HTv2M0HbNICvaHsWBA"}},"unsigned":{"age_ts":1672416527745,"replaces_state":"$rVK77mVSpz5EHxI2mbLxilqbkLxKhXEiusPFjapVPbw"}}	3
$OcvCF7YNeTKFnzz4EWVjFJIF9QidMEUmomHIvH3d2W8	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$g1kV-jEZBtN9l6VGGo2MN-wQn7RR7J-Tv5LfyJ5Z5fc"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"mattermost_b [mm]"},"depth":17,"prev_state":[],"state_key":"@mm_mattermost_b_:localhost","origin":"localhost","origin_server_ts":1672416527885,"hashes":{"sha256":"6lvnJvTQEFos9j2N01UrVABSUa3+d66dW8+G6Kjy6TM"},"signatures":{"localhost":{"ed25519:a_CHdg":"ZK8YsH1NTjmAm4MNHB/w38y8OiyrUHoC5C3Zv6TOvJddehQONJc225xxSvjkcslb8ESfhH7xLrQ3SRmDNrG8AA"}},"unsigned":{"age_ts":1672416527885,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#off-topic:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$UYXKiTPqFr31PwoZzi35ODpdRK0hwJVjVGC1N7kR7yk	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$5agO4kI6VqJHGKvKbkqUa2Y3cTwUBrjAhmCVtj9JmKU","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o"],"prev_events":["$GrqoJ52XSgRaoc4wPEYLdL2p6t3jl0aiFd8bYswQQcU"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_b_:localhost","content":{"membership":"join","displayname":"mattermost_b [mm]"},"depth":20,"prev_state":[],"state_key":"@mm_mattermost_b_:localhost","origin":"localhost","origin_server_ts":1672416528236,"hashes":{"sha256":"QXc3Fw4HAuF5XmUlggzmbGDngnNU2JELJlP9QsKUpVM"},"signatures":{"localhost":{"ed25519:a_CHdg":"u0Q3iZ//lTdeCbPXlTLiYhXE3dyDo44fN2X8swbgV1uCYb4iC1ad2O0qWD66GBZ/11nHynz5lVDOcSJ4/x4wDA"}},"unsigned":{"age_ts":1672416528236,"replaces_state":"$5agO4kI6VqJHGKvKbkqUa2Y3cTwUBrjAhmCVtj9JmKU"}}	3
$GrqoJ52XSgRaoc4wPEYLdL2p6t3jl0aiFd8bYswQQcU	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$CQg_jKvdpWFvaiLH2f5MtTnu1Zwxi8P4QPSJZum91dw"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"matrix_b [mm]"},"depth":19,"prev_state":[],"state_key":"@mm_matrix_matrix_b:localhost","origin":"localhost","origin_server_ts":1672416527990,"hashes":{"sha256":"kyciTkBC5gNTyHLpQFxqa1oy+lQnVzIdT5fXzEBnIZI"},"signatures":{"localhost":{"ed25519:a_CHdg":"Klzg/vzOyXGye19QGTHQJMdlQe5QiVAo7thdYBMW7X7a1rpAC46UIYrI/bWlFsMycCg+LH2djumnQLylkvUpCw"}},"unsigned":{"age_ts":1672416527990,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#town-square:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$5TE1hAtSTolrY9QTj9Wt8DnKurFa3P6KIfGkWOJbrY4	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$OcvCF7YNeTKFnzz4EWVjFJIF9QidMEUmomHIvH3d2W8"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"MattermostUser A [mm]"},"depth":18,"prev_state":[],"state_key":"@mm_mattermost_a_:localhost","origin":"localhost","origin_server_ts":1672416528095,"hashes":{"sha256":"4dWJoiM2WzfqCPw00NV24ZPTRd87pYL83sxUzDxbRJ8"},"signatures":{"localhost":{"ed25519:a_CHdg":"64xFwMgeLdfBu9hUeGqJd+6ss9lMqRB+wEmVe+yFb4q1aU9bdeaxl0RDHGd+4Uxyr3i+T4tSzad0Ws2h6uP0CQ"}},"unsigned":{"age_ts":1672416528095,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#off-topic:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$YFCWkh6b_jgrSjje7vt6JB6-uLPRz7Na1VgGh0PwdI8	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$4JiNeQHyMbyuEfymLkE-SEzPUh3bWddjxa6-5w36nJw","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs"],"prev_events":["$5TE1hAtSTolrY9QTj9Wt8DnKurFa3P6KIfGkWOJbrY4"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_matrix_matrix_b:localhost","content":{"membership":"join","displayname":"matrix_b [mm]"},"depth":19,"prev_state":[],"state_key":"@mm_matrix_matrix_b:localhost","origin":"localhost","origin_server_ts":1672416528363,"hashes":{"sha256":"7iHOvDYZIzwbBCb8WIo0D4/dp1ieGC+HxoRu3fSW/Qs"},"signatures":{"localhost":{"ed25519:a_CHdg":"ZpMZ5lc6X2aBrVftbKFKovnvWpwkF2tepu288VGcT/w5EITG7tJLp4RA3PwhBbs9GpTI1UG4D+KAxa3xcVU9Aw"}},"unsigned":{"age_ts":1672416528363,"replaces_state":"$4JiNeQHyMbyuEfymLkE-SEzPUh3bWddjxa6-5w36nJw"}}	3
$h2yGPxzdKWUBUSFQiOgFiRoNa8NgWHYXdy_2SMJx6ns	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$Y_S-fF0iLu0OHNMcZdYVzt0we_qL_t8_4QIKGeobLdI","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$UYXKiTPqFr31PwoZzi35ODpdRK0hwJVjVGC1N7kR7yk"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_matrix_matrix_a:localhost","content":{"membership":"join","displayname":"Matrix UserA [mm]"},"depth":21,"prev_state":[],"state_key":"@mm_matrix_matrix_a:localhost","origin":"localhost","origin_server_ts":1672416528469,"hashes":{"sha256":"bXw8OtWmMHJejRahXJkcC3syd1NjyfW7nb6iqQaoAxA"},"signatures":{"localhost":{"ed25519:a_CHdg":"w28ot0lFQkQfXR1UP71amgxA/Ko/M9uFhA34Hk1QcCoChrKv9viHJgAffBMKP1fdi9wL3XbWyNFhRhuOl5pYCQ"}},"unsigned":{"age_ts":1672416528469,"replaces_state":"$Y_S-fF0iLu0OHNMcZdYVzt0we_qL_t8_4QIKGeobLdI"}}	3
$jvwVmkElpx8M62JlaBz7nJ4qa2U8tVO7V9-HhJ-n8JI	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$JcoTJcBGASUqIK9V7j6ND5Jt6P9gdbNJxXxQBZNg8z4"],"prev_events":["$KgpvpFIMQIVFvm0adBZqAbWANmMgdu1_1jbP71RuM48"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_b:localhost","content":{"membership":"leave"},"depth":23,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672416528973,"hashes":{"sha256":"ZwgUg3c+OCU+DbaKfK+Y6mDbx2QhvkN6HELhEkSMw8E"},"signatures":{"localhost":{"ed25519:a_CHdg":"5RQvGfrKjXFYzjBUDxka3bFuudZAtaIdpMuldFAdFV3XzWNYkxRtkH8PXTeYrLsXLmi9jKyURj72i03HMfs7AA"}},"unsigned":{"age_ts":1672416528973,"replaces_state":"$JcoTJcBGASUqIK9V7j6ND5Jt6P9gdbNJxXxQBZNg8z4"}}	3
$0WsTO-QKZzqtMdl5UwGJc5h4e7YAE5ZGp_GDMb9K824	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$5TE1hAtSTolrY9QTj9Wt8DnKurFa3P6KIfGkWOJbrY4"],"prev_events":["$qWi32T1tK2APgSwc4y_6f0e_N_fUPmIBxC5ACk1h6NM"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_a_:localhost","content":{"membership":"join","displayname":"MattermostUser A [mm]"},"depth":22,"prev_state":[],"state_key":"@mm_mattermost_a_:localhost","origin":"localhost","origin_server_ts":1672416529010,"hashes":{"sha256":"rVEvi/dFV0JeS7i1R9JciHUk8V4YF0nQc4Q5YV/Tb4s"},"signatures":{"localhost":{"ed25519:a_CHdg":"YX/2wfjvPB733Sl1x51n5eDZym4L5ynUb5ofl78LruXkfIMZKaWnd6xTZUIiDAkjWJBrThc3xXghEOYjh1G3DA"}},"unsigned":{"age_ts":1672416529010,"replaces_state":"$5TE1hAtSTolrY9QTj9Wt8DnKurFa3P6KIfGkWOJbrY4"}}	3
$opS4sT6APXaq4vDdegPq6ik1z-yX-FkMTAqhGtTWXEE	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$isXWKf_B_7Z7R7jYn_2gZB-U31TuzMehBRxj5701Lq8","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$jvwVmkElpx8M62JlaBz7nJ4qa2U8tVO7V9-HhJ-n8JI"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"membership":"leave"},"depth":24,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672416529204,"hashes":{"sha256":"abXaZ+iyqb0fQC58B706QJMC+uKHXEZw5mJ/nzJZZo4"},"signatures":{"localhost":{"ed25519:a_CHdg":"xBwoLUzCrY3IYj6DKO19dstLKgz0cLMWn9s7X2U5VURG9l687s8mV/FFzGA/5k0QhsyCmkgElC+AoomSMlMoAw"}},"unsigned":{"age_ts":1672416529204,"replaces_state":"$isXWKf_B_7Z7R7jYn_2gZB-U31TuzMehBRxj5701Lq8"}}	3
$qWi32T1tK2APgSwc4y_6f0e_N_fUPmIBxC5ACk1h6NM	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$OcvCF7YNeTKFnzz4EWVjFJIF9QidMEUmomHIvH3d2W8","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs"],"prev_events":["$kmvnPONhcKxIpG62sV6apngYToshpP0mBrwpKL0hAOI"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_b_:localhost","content":{"membership":"join","displayname":"mattermost_b [mm]"},"depth":21,"prev_state":[],"state_key":"@mm_mattermost_b_:localhost","origin":"localhost","origin_server_ts":1672416528782,"hashes":{"sha256":"VimIM2COGzmIl6z+J+IXh9MljtFeGra4LCZfBfwbB98"},"signatures":{"localhost":{"ed25519:a_CHdg":"AXMVBo7E/9BhPFvH3gKsdvFUMeJHPpw4xjQ+WCwkhqQiX9Wp95LhFhIaEexdiFetXY3seW7mgleNkLGsbxAPBw"}},"unsigned":{"age_ts":1672416528782,"replaces_state":"$OcvCF7YNeTKFnzz4EWVjFJIF9QidMEUmomHIvH3d2W8"}}	3
$l5dYt-R2kpcKdlmMRFnzC5N9PjiV4DZ63c1bTGPOCXk	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$JwL8EK5sa4vg29tclnHwa5jrpCTa8oZVOIsgFyivQdY"],"prev_events":["$0WsTO-QKZzqtMdl5UwGJc5h4e7YAE5ZGp_GDMb9K824"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_b:localhost","content":{"membership":"leave"},"depth":23,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672416529228,"hashes":{"sha256":"EcRan8MR8CW7bOvavlg6HR5JdvTCGw+sOcyKSA4uoNs"},"signatures":{"localhost":{"ed25519:a_CHdg":"q1Zc22fvUilZLjk73VxJW33k4X9BPZ+wOsdV4VmTe3zG4v1w9BldcdjgxxgbQhmYkbIHZw6hno9uo8d1HzVcDA"}},"unsigned":{"age_ts":1672416529228,"replaces_state":"$JwL8EK5sa4vg29tclnHwa5jrpCTa8oZVOIsgFyivQdY"}}	3
$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY	!MrxfbdodytWwBMqNiF:localhost	{"token_id":16,"historical":false}	{"auth_events":[],"prev_events":[],"type":"m.room.create","room_id":"!MrxfbdodytWwBMqNiF:localhost","sender":"@bridgeuser1:localhost","content":{"room_version":"6","creator":"@bridgeuser1:localhost"},"depth":1,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672417353493,"hashes":{"sha256":"r0fXqwiIf1whIQQFxOb6b4tMYb48xQ9giSRrHTIkfbM"},"signatures":{"localhost":{"ed25519:a_CHdg":"b0Ss82hewY04fSFdBFd8hYGq4On8VQ+lm9pZ89QRpomVCViuLwkPu1WwN52y30T/2aVOEe5sW+fFJbu/WUk+BQ"}},"unsigned":{"age_ts":1672417353493}}	3
$NxuVtjeVql0_aadDlNux0yeeR_PxcpcJPnX1SdoDmXM	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$2KnXfE3sZw8LDrOAaEP4HdQuw5neshhvyZKtnwo5cg0","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$l5dYt-R2kpcKdlmMRFnzC5N9PjiV4DZ63c1bTGPOCXk"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_a:localhost","content":{"membership":"leave"},"depth":24,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672416529383,"hashes":{"sha256":"K976CYP/j304SbhzEgdc7rNmoIhODB887UANVNQe21o"},"signatures":{"localhost":{"ed25519:a_CHdg":"e3khP0QdB9BwxAuXBs6c8s0SJr2ZVfmqgiz/QjW3gVVpQ/uKX9gC3Ta28l7L2nBGGDtir6ZFs7CH1mXJTE+1Cg"}},"unsigned":{"age_ts":1672416529383,"replaces_state":"$2KnXfE3sZw8LDrOAaEP4HdQuw5neshhvyZKtnwo5cg0"}}	3
$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA	!MrxfbdodytWwBMqNiF:localhost	{"token_id":16,"historical":false}	{"auth_events":["$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY","$89n67RlAmtb8nRuxie-oq3g9grnkpjzJMAhbJ8h_8Xw"],"prev_events":["$89n67RlAmtb8nRuxie-oq3g9grnkpjzJMAhbJ8h_8Xw"],"type":"m.room.power_levels","room_id":"!MrxfbdodytWwBMqNiF:localhost","sender":"@bridgeuser1:localhost","content":{"users":{"@bridgeuser1:localhost":100,"@admin:localhost":100},"users_default":0,"events":{"m.room.name":50,"m.room.power_levels":100,"m.room.history_visibility":100,"m.room.canonical_alias":50,"m.room.avatar":50,"m.room.tombstone":100,"m.room.server_acl":100,"m.room.encryption":100},"events_default":0,"state_default":50,"ban":50,"kick":50,"redact":50,"invite":0,"historical":100},"depth":3,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672417353714,"hashes":{"sha256":"KvFSidOSiT9AGx98kTm41scBeapX4L00ko5NypG3iBI"},"signatures":{"localhost":{"ed25519:a_CHdg":"2cFHe6ywq4wvCKsvcfB2Qg+Jw0x6bxBwRTkjDAfqp5luajPWA+AWEYU0IkuyvfpPM1cSP4WH5GtseYcuAzCOCw"}},"unsigned":{"age_ts":1672417353714}}	3
$TVXtgqtZ5WfNfZEnJQx6m0NYwp0_34ylOK87XzZ3JlI	!MrxfbdodytWwBMqNiF:localhost	{"token_id":16,"historical":false}	{"auth_events":["$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY","$89n67RlAmtb8nRuxie-oq3g9grnkpjzJMAhbJ8h_8Xw","$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA"],"prev_events":["$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA"],"type":"m.room.join_rules","room_id":"!MrxfbdodytWwBMqNiF:localhost","sender":"@bridgeuser1:localhost","content":{"join_rule":"invite"},"depth":4,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672417353911,"hashes":{"sha256":"x4cj8C0WMP95UZgQX1zsVtSAwH3oQOe49jT/2XbAvc4"},"signatures":{"localhost":{"ed25519:a_CHdg":"vsRZE3G84LGTlPmCl9Bq+/o/q8NXIxGBzAqdA177MQ8dGibYsMb3bJo8ds54+0to8osFklDdFa8tnbHyAa3TBQ"}},"unsigned":{"age_ts":1672417353911}}	3
$JQ7PDbgzTTAY5uHFM6NV0ovadfzQLOpcAcrSX5mRUi0	!MrxfbdodytWwBMqNiF:localhost	{"token_id":16,"historical":false}	{"auth_events":["$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY","$89n67RlAmtb8nRuxie-oq3g9grnkpjzJMAhbJ8h_8Xw","$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA"],"prev_events":["$TVXtgqtZ5WfNfZEnJQx6m0NYwp0_34ylOK87XzZ3JlI"],"type":"m.room.history_visibility","room_id":"!MrxfbdodytWwBMqNiF:localhost","sender":"@bridgeuser1:localhost","content":{"history_visibility":"shared"},"depth":5,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672417354076,"hashes":{"sha256":"NQFH84OfdA8pxAcpZI3tBhufCdpQaNTABaK7FcSevrA"},"signatures":{"localhost":{"ed25519:a_CHdg":"AhJadiie+SoIaGvr89NWacdqOIcwX6htaZ6cLyRlvRinlXtgmIsxE2HLfIlIQW+6R/GiBhleP67SZecjdL0gCg"}},"unsigned":{"age_ts":1672417354076}}	3
$9MVFB3q88VYxhDZMX087Uv4c3h3uEpluJN0q33ubtso	!MrxfbdodytWwBMqNiF:localhost	{"token_id":16,"historical":false}	{"auth_events":["$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY","$89n67RlAmtb8nRuxie-oq3g9grnkpjzJMAhbJ8h_8Xw","$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA"],"prev_events":["$JQ7PDbgzTTAY5uHFM6NV0ovadfzQLOpcAcrSX5mRUi0"],"type":"m.room.guest_access","room_id":"!MrxfbdodytWwBMqNiF:localhost","sender":"@bridgeuser1:localhost","content":{"guest_access":"can_join"},"depth":6,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672417354178,"hashes":{"sha256":"l0G5Lh+OM+vyzYD30lOnDpaZbjA8imu1IhdvKG9jpBE"},"signatures":{"localhost":{"ed25519:a_CHdg":"2aYqiMXONV/YiOKqAkm77zomTsEsHAKQH2AMAKcUevg+uofCEawHtv4PHCrIHqUdP8Y0h8nxtzYKiiKRA2T/BQ"}},"unsigned":{"age_ts":1672417354178}}	3
$Nv-ymHeLYsZKVjdilAoBLGC4GlzNJWt1HBqtIlSIz1k	!MrxfbdodytWwBMqNiF:localhost	{"token_id":16,"txn_id":"m1672417354496.5","historical":false}	{"auth_events":["$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY","$89n67RlAmtb8nRuxie-oq3g9grnkpjzJMAhbJ8h_8Xw","$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA"],"prev_events":["$V_QrTFMCwHlrg-MSVVplcYCRVWM_QgXhIvp-2R_LtHI"],"type":"m.room.message","room_id":"!MrxfbdodytWwBMqNiF:localhost","sender":"@bridgeuser1:localhost","content":{"org.matrix.msc1767.text":"Hej","body":"Hej","msgtype":"m.text"},"depth":8,"prev_state":[],"origin":"localhost","origin_server_ts":1672417354608,"hashes":{"sha256":"gaj4Tb8XaYtjFvAVLLpHfsJM12jeKoAlSpuTdYVts4c"},"signatures":{"localhost":{"ed25519:a_CHdg":"45lN26nAW2h05DkVLACkBJN2GbLn7KYVruSS21z1irLXDR/L53kOk0MrvzAzcC0IOyI3e9B7vQwJEMym6fmVDQ"}},"unsigned":{"age_ts":1672417354608}}	3
$V_QrTFMCwHlrg-MSVVplcYCRVWM_QgXhIvp-2R_LtHI	!MrxfbdodytWwBMqNiF:localhost	{"token_id":16,"historical":false}	{"auth_events":["$89n67RlAmtb8nRuxie-oq3g9grnkpjzJMAhbJ8h_8Xw","$TVXtgqtZ5WfNfZEnJQx6m0NYwp0_34ylOK87XzZ3JlI","$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY","$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA"],"prev_events":["$9MVFB3q88VYxhDZMX087Uv4c3h3uEpluJN0q33ubtso"],"type":"m.room.member","room_id":"!MrxfbdodytWwBMqNiF:localhost","sender":"@bridgeuser1:localhost","content":{"is_direct":true,"membership":"invite","displayname":"Admin User"},"depth":7,"prev_state":[],"state_key":"@admin:localhost","origin":"localhost","origin_server_ts":1672417354326,"hashes":{"sha256":"fCLDhOK6ozkF/is3tmP28sjU2UdSwlCGHlYJzJ1RBE8"},"signatures":{"localhost":{"ed25519:a_CHdg":"kI3+AD7qvBi1oO+rYy/mlEDvwNVLWkKniwlL52l0hvvlFWcFolz/PxTsQVqnqyyGoQxKdZhyGEC3PdIblgFeBw"}},"unsigned":{"age_ts":1672417354326,"invite_room_state":[{"type":"m.room.create","state_key":"","content":{"room_version":"6","creator":"@bridgeuser1:localhost"},"sender":"@bridgeuser1:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"invite"},"sender":"@bridgeuser1:localhost"},{"type":"m.room.member","state_key":"@bridgeuser1:localhost","content":{"membership":"join","displayname":"bridgeuser1"},"sender":"@bridgeuser1:localhost"}]}}	3
$yZwQJfxjuLFOlfyTYw-M1aupZjmck-aVfpfSYx5fj1I	!UKcoTBWWxNEyixrjyM:localhost	{"token_id":16,"historical":false}	{"auth_events":[],"prev_events":[],"type":"m.room.create","room_id":"!UKcoTBWWxNEyixrjyM:localhost","sender":"@bridgeuser1:localhost","content":{"room_version":"6","creator":"@bridgeuser1:localhost"},"depth":1,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672417514365,"hashes":{"sha256":"hUUQZj9bxThfr0nCUBC03ziwQgxLabnAaFaYsjaL62I"},"signatures":{"localhost":{"ed25519:a_CHdg":"ioHokfdUWfd1BQSzQdWwHsFO2iZ8FPI342Ck1zISSHpwzmiamaqE4bNrnE8OhERE6SeljtsojRpV49R+yKJUCg"}},"unsigned":{"age_ts":1672417514365}}	3
$sqtTmHJJ_e6UeDKORkztLzcGXYNZpKgoa1v2ir5yr-w	!UKcoTBWWxNEyixrjyM:localhost	{"token_id":16,"historical":false}	{"auth_events":["$yZwQJfxjuLFOlfyTYw-M1aupZjmck-aVfpfSYx5fj1I"],"prev_events":["$yZwQJfxjuLFOlfyTYw-M1aupZjmck-aVfpfSYx5fj1I"],"type":"m.room.member","room_id":"!UKcoTBWWxNEyixrjyM:localhost","sender":"@bridgeuser1:localhost","content":{"membership":"join","displayname":"bridgeuser1"},"depth":2,"prev_state":[],"state_key":"@bridgeuser1:localhost","origin":"localhost","origin_server_ts":1672417514479,"hashes":{"sha256":"+X9gGlPpx0Pxy24BUW+cr4bjor9h7IR2A9pBA7NqbRs"},"signatures":{"localhost":{"ed25519:a_CHdg":"ula2NGzxLwIgs76Te4KBDOKIRygnK0Ss/4C+t4UQdWoFItmFY9dZP/2UMRd6GlNYAKJf6J0ro6S+LLO+NISKDQ"}},"unsigned":{"age_ts":1672417514479}}	3
$EsIKBNaGky9gjqListPEKjQfFScHFrG5GuEQD0vyi9Q	!UKcoTBWWxNEyixrjyM:localhost	{"token_id":16,"historical":false}	{"auth_events":["$yZwQJfxjuLFOlfyTYw-M1aupZjmck-aVfpfSYx5fj1I","$sqtTmHJJ_e6UeDKORkztLzcGXYNZpKgoa1v2ir5yr-w"],"prev_events":["$sqtTmHJJ_e6UeDKORkztLzcGXYNZpKgoa1v2ir5yr-w"],"type":"m.room.power_levels","room_id":"!UKcoTBWWxNEyixrjyM:localhost","sender":"@bridgeuser1:localhost","content":{"users":{"@bridgeuser1:localhost":100,"@matrix_a:localhost":100},"users_default":0,"events":{"m.room.name":50,"m.room.power_levels":100,"m.room.history_visibility":100,"m.room.canonical_alias":50,"m.room.avatar":50,"m.room.tombstone":100,"m.room.server_acl":100,"m.room.encryption":100},"events_default":0,"state_default":50,"ban":50,"kick":50,"redact":50,"invite":0,"historical":100},"depth":3,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672417514593,"hashes":{"sha256":"eu8nTICpnFthxTmjhenmK3nxZdpPBCgre9g/4SYmBHI"},"signatures":{"localhost":{"ed25519:a_CHdg":"2E/VwVc8/F9Gre+cz2E2lpWS+Y38dbLoi6nu8NruDLd2MfmTDxXl7N4ljdG2Cv8t5eXp9+aBV+xLuNxd5LtzBw"}},"unsigned":{"age_ts":1672417514593}}	3
$STt_lRcQQY1HR2YQmv4RsQMis1Xc5sWAamnHn02ddqk	!UKcoTBWWxNEyixrjyM:localhost	{"token_id":16,"historical":false}	{"auth_events":["$yZwQJfxjuLFOlfyTYw-M1aupZjmck-aVfpfSYx5fj1I","$sqtTmHJJ_e6UeDKORkztLzcGXYNZpKgoa1v2ir5yr-w","$EsIKBNaGky9gjqListPEKjQfFScHFrG5GuEQD0vyi9Q"],"prev_events":["$EsIKBNaGky9gjqListPEKjQfFScHFrG5GuEQD0vyi9Q"],"type":"m.room.join_rules","room_id":"!UKcoTBWWxNEyixrjyM:localhost","sender":"@bridgeuser1:localhost","content":{"join_rule":"invite"},"depth":4,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672417514851,"hashes":{"sha256":"VAV7d1GlVI7fcYzQBvDcanJU3/st/zC1S/6sKuNttMk"},"signatures":{"localhost":{"ed25519:a_CHdg":"4VIs9q3Vbgq1lJgK4DkAsUbvGWevIEa/xF9+hQrTe2WAnhTy6ygnBjNxJB6yiXZaxOX5w7xtqUcb43Qava0eAQ"}},"unsigned":{"age_ts":1672417514851}}	3
$KEhwfKMs0OrXZWYNQWK_YDu-mrG-UP2Do2VsAShloEY	!UKcoTBWWxNEyixrjyM:localhost	{"token_id":16,"historical":false}	{"auth_events":["$yZwQJfxjuLFOlfyTYw-M1aupZjmck-aVfpfSYx5fj1I","$sqtTmHJJ_e6UeDKORkztLzcGXYNZpKgoa1v2ir5yr-w","$EsIKBNaGky9gjqListPEKjQfFScHFrG5GuEQD0vyi9Q"],"prev_events":["$STt_lRcQQY1HR2YQmv4RsQMis1Xc5sWAamnHn02ddqk"],"type":"m.room.history_visibility","room_id":"!UKcoTBWWxNEyixrjyM:localhost","sender":"@bridgeuser1:localhost","content":{"history_visibility":"shared"},"depth":5,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672417514969,"hashes":{"sha256":"FPhKMXd6ar9M20RhBK++0yXnQXouvSkkVOElvlCPvn4"},"signatures":{"localhost":{"ed25519:a_CHdg":"OvaV2NigUIaDyMn9rASlXKtw7dF4KUm//GkARZSvGxrogk4yvGHxsQelD5/wGd5ccpYk3SjGdVXyMeA45OeCAQ"}},"unsigned":{"age_ts":1672417514969}}	3
$em_2PzgnditDYAzn8yY84PnmN1oNQZgI8Co6SjahtU8	!UKcoTBWWxNEyixrjyM:localhost	{"token_id":16,"historical":false}	{"auth_events":["$yZwQJfxjuLFOlfyTYw-M1aupZjmck-aVfpfSYx5fj1I","$sqtTmHJJ_e6UeDKORkztLzcGXYNZpKgoa1v2ir5yr-w","$EsIKBNaGky9gjqListPEKjQfFScHFrG5GuEQD0vyi9Q"],"prev_events":["$KEhwfKMs0OrXZWYNQWK_YDu-mrG-UP2Do2VsAShloEY"],"type":"m.room.guest_access","room_id":"!UKcoTBWWxNEyixrjyM:localhost","sender":"@bridgeuser1:localhost","content":{"guest_access":"can_join"},"depth":6,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672417515149,"hashes":{"sha256":"i+PRtAouJ9haETs6L4Kr0SxCKVe+3cOEriAMTYAqzcQ"},"signatures":{"localhost":{"ed25519:a_CHdg":"RjsxJHcGWTWDHRMu3jK+rnti6NvhiFtVQT1gq41LDIQ/IJY9CRNdfRwWkQ+vebxKqPJOfkqMf7nkg0ucO7UkCA"}},"unsigned":{"age_ts":1672417515149}}	3
$sdrkpiq94MhqjrSukg-aexI_3VlPxcoqiZXmrPvpQGw	!UKcoTBWWxNEyixrjyM:localhost	{"token_id":16,"historical":false}	{"auth_events":["$sqtTmHJJ_e6UeDKORkztLzcGXYNZpKgoa1v2ir5yr-w","$STt_lRcQQY1HR2YQmv4RsQMis1Xc5sWAamnHn02ddqk","$yZwQJfxjuLFOlfyTYw-M1aupZjmck-aVfpfSYx5fj1I","$EsIKBNaGky9gjqListPEKjQfFScHFrG5GuEQD0vyi9Q"],"prev_events":["$em_2PzgnditDYAzn8yY84PnmN1oNQZgI8Co6SjahtU8"],"type":"m.room.member","room_id":"!UKcoTBWWxNEyixrjyM:localhost","sender":"@bridgeuser1:localhost","content":{"is_direct":true,"membership":"invite","displayname":"Matrix UserA"},"depth":7,"prev_state":[],"state_key":"@matrix_a:localhost","origin":"localhost","origin_server_ts":1672417515401,"hashes":{"sha256":"GPIot6n6/EHkL0zCUpSusWCRssIs9yA4jbaNdM+wYEg"},"signatures":{"localhost":{"ed25519:a_CHdg":"jb5Oz1AuR5nLE+cIg75GkvIu7DGwkqwrysPL+rg6/1F+nFH4tjtZWVJovdOxlkomRC+SBOGKpJBeQz8eyVmbDA"}},"unsigned":{"age_ts":1672417515401,"invite_room_state":[{"type":"m.room.create","state_key":"","content":{"room_version":"6","creator":"@bridgeuser1:localhost"},"sender":"@bridgeuser1:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"invite"},"sender":"@bridgeuser1:localhost"},{"type":"m.room.member","state_key":"@bridgeuser1:localhost","content":{"membership":"join","displayname":"bridgeuser1"},"sender":"@bridgeuser1:localhost"}]}}	3
$-JWBJJpXpVo-YhtBYaJDTakzo94Jhn_XGlhnLzEWxyc	!UKcoTBWWxNEyixrjyM:localhost	{"token_id":16,"txn_id":"m1672417516037.11","historical":false}	{"auth_events":["$yZwQJfxjuLFOlfyTYw-M1aupZjmck-aVfpfSYx5fj1I","$sqtTmHJJ_e6UeDKORkztLzcGXYNZpKgoa1v2ir5yr-w","$EsIKBNaGky9gjqListPEKjQfFScHFrG5GuEQD0vyi9Q"],"prev_events":["$sdrkpiq94MhqjrSukg-aexI_3VlPxcoqiZXmrPvpQGw"],"type":"m.room.message","room_id":"!UKcoTBWWxNEyixrjyM:localhost","sender":"@bridgeuser1:localhost","content":{"org.matrix.msc1767.text":"Hej","body":"Hej","msgtype":"m.text"},"depth":8,"prev_state":[],"origin":"localhost","origin_server_ts":1672417516087,"hashes":{"sha256":"ZQiSNXWB47+OsTGVmLNOyzlJF7veToSwxVzjUuqgvt8"},"signatures":{"localhost":{"ed25519:a_CHdg":"2b51p3OqyAmXRDIiSIldnf6juvDTa38lzSmzzCQAQ3C3g4SY7j0GNBijKw94ozpkQnMGLWsPAVmTWWb6iR6WCA"}},"unsigned":{"age_ts":1672417516087}}	3
$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc	!kAToIwhNWrDpgQVMfY:localhost	{"token_id":17,"historical":false}	{"auth_events":["$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw","$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE"],"prev_events":["$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE"],"type":"m.room.power_levels","room_id":"!kAToIwhNWrDpgQVMfY:localhost","sender":"@bridgeadmin:localhost","content":{"users":{"@bridgeadmin:localhost":100},"users_default":0,"events":{"m.room.name":50,"m.room.power_levels":100,"m.room.history_visibility":100,"m.room.canonical_alias":50,"m.room.avatar":50,"m.room.tombstone":100,"m.room.server_acl":100,"m.room.encryption":100},"events_default":100,"state_default":50,"ban":50,"kick":50,"redact":50,"invite":0,"historical":100},"depth":3,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672417769139,"hashes":{"sha256":"63u+UxLNsr+oP4L+vHt1o1xmSBZt5ttKSrcQgADhLQ4"},"signatures":{"localhost":{"ed25519:a_CHdg":"Twkg7htadoiQI43uRd4fGMWjuCDc29S3FMnpJxen9E84fx/JPZnPn/blWtDWFatAXuJZ9OTIUvzS/aGUtBgNBw"}},"unsigned":{"age_ts":1672417769139}}	3
$fZAJc_jo3uwpjSNh7ULQOuzuMtHLVO8KdmygXkq-95M	!kAToIwhNWrDpgQVMfY:localhost	{"token_id":17,"historical":false}	{"auth_events":["$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw","$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc","$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE"],"prev_events":["$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc"],"type":"m.room.canonical_alias","room_id":"!kAToIwhNWrDpgQVMfY:localhost","sender":"@bridgeadmin:localhost","content":{"alias":"#mittrum:localhost"},"depth":4,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672417769336,"hashes":{"sha256":"bLr8HG1+/AAXiKYw5+znOFg864xHNpX36U/0dFpktXM"},"signatures":{"localhost":{"ed25519:a_CHdg":"CrI6yWqd5nkIiy84RJdUYCa4/P2QC9XqmX6AwsxVcHNxcny40PRsO96LcCJ6ESjBGd666b5V4Qcg+rdGzUmrAw"}},"unsigned":{"age_ts":1672417769336}}	3
$ce28aY-iB2mpb8Gioxn_S-YFJtBn3dK4JRguWv9H2XY	!cwnFZrIkYIOvkCHJkc:localhost	{"token_id":17,"historical":false}	{"auth_events":["$AXgBEWEnQYL0m4F3qNGi4DDk7afIQe7a_hmRdZkAZLM","$PJZugFD-K6RtTB0vNzX1j0YFLZ9x4vli99YpMY9dzQk","$41BPCZJ_9IbE7VgIqxEef1X7U2-FXJjTA25i2Q-n_gg"],"prev_events":["$PJZugFD-K6RtTB0vNzX1j0YFLZ9x4vli99YpMY9dzQk"],"type":"m.room.join_rules","room_id":"!cwnFZrIkYIOvkCHJkc:localhost","sender":"@bridgeadmin:localhost","content":{"join_rule":"public"},"depth":4,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672417776148,"hashes":{"sha256":"Z3CYx7BZxokPw6NAdhgXaHYT8rBJdkkcFMpIsHFBJx4"},"signatures":{"localhost":{"ed25519:a_CHdg":"wR73rdAIKVOajO+M1yHdB/bc8ZEYzj6MnCneE0dFinOFJ+sZ1LxCknzNZcGBIZ6IZDKC7PFqx91CsIXeyiOgBg"}},"unsigned":{"age_ts":1672417776148}}	3
$e4RXblgeP3Sa0Hs3COmGOAFe9LclWYCrLIk7nF2PEDk	!ffaaxOMHcWnINEXTWK:localhost	{"token_id":17,"historical":false}	{"auth_events":["$wTlWqRh3eGNrru9CGqbzkNcL0kBGbtEB8sHZwsAboS0","$pn5NPm28AfF5_169OnQQxTv4_ijcoN4k44UIvzGsN7k","$81gCIX2tUwDG_Jg02kHVceEfsUG1IOQ9-YnDk1cV15w"],"prev_events":["$zxy8zKV-5WiZDQEOGVCLyrd2yGWyYrOah4vQYAlc-xI"],"type":"m.room.history_visibility","room_id":"!ffaaxOMHcWnINEXTWK:localhost","sender":"@bridgeadmin:localhost","content":{"history_visibility":"world_readable"},"depth":7,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672417776822,"hashes":{"sha256":"ksCpHZBzg6ExIO19E70HJp2cCCmunjxpq3aCv7RfCF8"},"signatures":{"localhost":{"ed25519:a_CHdg":"1kDTwmJVYTh7N2FanyE/SREnnJL6ZY/Iqv+6ITJZBe0lv38xkqwhaTmXFnBdbn41bNc3MoADIgtspp7R/scmAQ"}},"unsigned":{"age_ts":1672417776822}}	3
$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw	!kAToIwhNWrDpgQVMfY:localhost	{"token_id":17,"historical":false}	{"auth_events":[],"prev_events":[],"type":"m.room.create","room_id":"!kAToIwhNWrDpgQVMfY:localhost","sender":"@bridgeadmin:localhost","content":{"type":"m.space","room_version":"6","creator":"@bridgeadmin:localhost"},"depth":1,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672417768863,"hashes":{"sha256":"KPddnrtcfbC7aPaoUM+OMJRDw5WDkhiNal7SvpGq9QE"},"signatures":{"localhost":{"ed25519:a_CHdg":"b/rcV1HFsjiMvxRQ0vAsSlIt94i99rBSTqinP8l7nvZMdHVXrr3SQKslquTi7Nhuo5LGGXq0MZ9Mo3bZ4OBBAw"}},"unsigned":{"age_ts":1672417768863}}	3
$AXgBEWEnQYL0m4F3qNGi4DDk7afIQe7a_hmRdZkAZLM	!cwnFZrIkYIOvkCHJkc:localhost	{"token_id":17,"historical":false}	{"auth_events":[],"prev_events":[],"type":"m.room.create","room_id":"!cwnFZrIkYIOvkCHJkc:localhost","sender":"@bridgeadmin:localhost","content":{"room_version":"6","creator":"@bridgeadmin:localhost"},"depth":1,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672417775372,"hashes":{"sha256":"UyQ9KFuM1mmAZRhcjjibx0yTlOVAPoO0PEphU078y9k"},"signatures":{"localhost":{"ed25519:a_CHdg":"WlwTnqRWvfh4Ug6PlXs95ZWknXn3tFMLQJRf2ApLpWB7ffycRUzv5J7x/sCQ0AyOH5AKaqiKi63JCjEKO00DCA"}},"unsigned":{"age_ts":1672417775372}}	3
$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE	!kAToIwhNWrDpgQVMfY:localhost	{"token_id":17,"historical":false}	{"auth_events":["$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw"],"prev_events":["$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw"],"type":"m.room.member","room_id":"!kAToIwhNWrDpgQVMfY:localhost","sender":"@bridgeadmin:localhost","content":{"membership":"join","displayname":"bridgeadmin"},"depth":2,"prev_state":[],"state_key":"@bridgeadmin:localhost","origin":"localhost","origin_server_ts":1672417768995,"hashes":{"sha256":"rdZ0LvTRfYqdlEX0oTsA4VhgLLIg/9fLWSoHATDk+QQ"},"signatures":{"localhost":{"ed25519:a_CHdg":"VFeYs3kale+Bd7p9K+JxG1n+sOlCL6k/YcvwUvjWRcrHprOn07RZbBclWDti7k/pNMKAJOh1bwUMQva4/rK7CA"}},"unsigned":{"age_ts":1672417768995}}	3
$41BPCZJ_9IbE7VgIqxEef1X7U2-FXJjTA25i2Q-n_gg	!cwnFZrIkYIOvkCHJkc:localhost	{"token_id":17,"historical":false}	{"auth_events":["$AXgBEWEnQYL0m4F3qNGi4DDk7afIQe7a_hmRdZkAZLM"],"prev_events":["$AXgBEWEnQYL0m4F3qNGi4DDk7afIQe7a_hmRdZkAZLM"],"type":"m.room.member","room_id":"!cwnFZrIkYIOvkCHJkc:localhost","sender":"@bridgeadmin:localhost","content":{"membership":"join","displayname":"bridgeadmin"},"depth":2,"prev_state":[],"state_key":"@bridgeadmin:localhost","origin":"localhost","origin_server_ts":1672417775669,"hashes":{"sha256":"r0ra5128D3XUQNmBn+a8f7kR18l4qFa9YKiFNm8OvvM"},"signatures":{"localhost":{"ed25519:a_CHdg":"AkbblaU7bJO8Dk7GRDNzcHxrxUm0Ld+9Iu8dqCnwALSN/E5hozMyDYCgxNGaP5hSJgrzO29HF4lumGz+vfz7AA"}},"unsigned":{"age_ts":1672417775669}}	3
$v_Jh2P1U7Li3ATyMsxgipoyBuQRYv5HD-cv8JVNpdLc	!kAToIwhNWrDpgQVMfY:localhost	{"token_id":17,"historical":false}	{"auth_events":["$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw","$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc","$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE"],"prev_events":["$nL-1meDVcMfCo41V5V5w3EBPwNdmll7Alfsp00QCHvk"],"type":"m.space.child","room_id":"!kAToIwhNWrDpgQVMfY:localhost","sender":"@bridgeadmin:localhost","content":{"via":["localhost"],"suggested":true},"depth":10,"prev_state":[],"state_key":"!cwnFZrIkYIOvkCHJkc:localhost","origin":"localhost","origin_server_ts":1672417777507,"hashes":{"sha256":"UUA7HGgKjJZLFtI/Wmm+UOD+bAc6ERsLeR98Iyysvq8"},"signatures":{"localhost":{"ed25519:a_CHdg":"JZVRw7um4aoONCcqjH4OfiaPdAWk9pL47ICrJG5gJ67KEbEIl0pKTj1HmvuaSt5EV4up1TGZqa7HcNZxJedIAA"}},"unsigned":{"age_ts":1672417777507}}	3
$KGv2op0D-6TOpQuqb5Gl4YZxMUKn37cUNSylMiEo7SA	!kAToIwhNWrDpgQVMfY:localhost	{"token_id":17,"historical":false}	{"auth_events":["$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw","$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc","$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE"],"prev_events":["$fZAJc_jo3uwpjSNh7ULQOuzuMtHLVO8KdmygXkq-95M"],"type":"m.room.join_rules","room_id":"!kAToIwhNWrDpgQVMfY:localhost","sender":"@bridgeadmin:localhost","content":{"join_rule":"public"},"depth":5,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672417769488,"hashes":{"sha256":"s/J6dubiUzVRreV/SVjst3f+FNhYo95PNcuNdtcOQYY"},"signatures":{"localhost":{"ed25519:a_CHdg":"MJNOGa3eXwMEYkQW8kUXPWkVxqa5F0mO/+Qe7K/f4Pmq8xzIkMPPctLuRnsvQepDaecxUeMpjQmg9Hsudlc9CQ"}},"unsigned":{"age_ts":1672417769488}}	3
$XvSaPVUaER3JwP1gLc-c__oVTIjGs5YL10o0DSsZ3q0	!kAToIwhNWrDpgQVMfY:localhost	{"token_id":17,"historical":false}	{"auth_events":["$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw","$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc","$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE"],"prev_events":["$KGv2op0D-6TOpQuqb5Gl4YZxMUKn37cUNSylMiEo7SA"],"type":"m.room.guest_access","room_id":"!kAToIwhNWrDpgQVMfY:localhost","sender":"@bridgeadmin:localhost","content":{"guest_access":"can_join"},"depth":6,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672417769602,"hashes":{"sha256":"C4wAaAPV0LyZFUhpniqgqLfe95IPv+SYsnCWZNIru5w"},"signatures":{"localhost":{"ed25519:a_CHdg":"8m2HaTnhVmcMESJGS54dYxwZTyKdL6YkTrD4p4o1xTYnCihY5ac0iwsKDXXE/F66ADjH+kTNt9fc5Qsi8q3GCw"}},"unsigned":{"age_ts":1672417769602}}	3
$zHrY9OvLbZTtN0bNPCDJg1HsmkgSV-pzAmxVIqaSB98	!kAToIwhNWrDpgQVMfY:localhost	{"token_id":17,"historical":false}	{"auth_events":["$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw","$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc","$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE"],"prev_events":["$XvSaPVUaER3JwP1gLc-c__oVTIjGs5YL10o0DSsZ3q0"],"type":"m.room.history_visibility","room_id":"!kAToIwhNWrDpgQVMfY:localhost","sender":"@bridgeadmin:localhost","content":{"history_visibility":"world_readable"},"depth":7,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672417769701,"hashes":{"sha256":"XK2mTv0DgoVoThyDbwjPQdl4WhZIoGOh6DtsCab2Pz0"},"signatures":{"localhost":{"ed25519:a_CHdg":"3X8NN03Wss9g2ltfdMdJvOAK0z1njZMx6ofFKtGF7F/3Ox2qitSqk0STYRvEdA8IKcHIAAwcwPmycGoHb++2BA"}},"unsigned":{"age_ts":1672417769701}}	3
$Np7HQ3SdNiYX3HhRJtJw4b80J96uY_IbqI_bL7w83m0	!kAToIwhNWrDpgQVMfY:localhost	{"token_id":17,"historical":false}	{"auth_events":["$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw","$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc","$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE"],"prev_events":["$zHrY9OvLbZTtN0bNPCDJg1HsmkgSV-pzAmxVIqaSB98"],"type":"m.room.name","room_id":"!kAToIwhNWrDpgQVMfY:localhost","sender":"@bridgeadmin:localhost","content":{"name":"Mittrum"},"depth":8,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672417769811,"hashes":{"sha256":"S+HeC5ZuEOqebWY4AWybNRg/tuvH+7jrQyQmr6i0VEU"},"signatures":{"localhost":{"ed25519:a_CHdg":"DTfCnga2IJlqx2iR2h7ZZzklv7HSAgRKNyOKXlswQA5gzduPNDeSwYIVMOzWtiJ3zpYNGXfn4aoLJO3xfPksAQ"}},"unsigned":{"age_ts":1672417769811}}	3
$nL-1meDVcMfCo41V5V5w3EBPwNdmll7Alfsp00QCHvk	!kAToIwhNWrDpgQVMfY:localhost	{"token_id":17,"historical":false}	{"auth_events":["$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw","$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc","$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE"],"prev_events":["$Np7HQ3SdNiYX3HhRJtJw4b80J96uY_IbqI_bL7w83m0"],"type":"m.room.topic","room_id":"!kAToIwhNWrDpgQVMfY:localhost","sender":"@bridgeadmin:localhost","content":{"topic":""},"depth":9,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672417769921,"hashes":{"sha256":"Hev+m/NXKyhplceyGJwY2BQnGqJ5F7j53iwebhD3Sos"},"signatures":{"localhost":{"ed25519:a_CHdg":"iosGg0z/nEe1N25VNCvzyxHHyVVHIaRu2Pt62JZ1nY1DC1sdvxoUOiP3B9VvH+OkEeMFQeELttPz4Y4ieNs5DQ"}},"unsigned":{"age_ts":1672417769921}}	3
$wTlWqRh3eGNrru9CGqbzkNcL0kBGbtEB8sHZwsAboS0	!ffaaxOMHcWnINEXTWK:localhost	{"token_id":17,"historical":false}	{"auth_events":[],"prev_events":[],"type":"m.room.create","room_id":"!ffaaxOMHcWnINEXTWK:localhost","sender":"@bridgeadmin:localhost","content":{"room_version":"6","creator":"@bridgeadmin:localhost"},"depth":1,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672417775354,"hashes":{"sha256":"5lS6aokO1BDUAOP6kyDOksakTgNJyueNFHihvOxQgrU"},"signatures":{"localhost":{"ed25519:a_CHdg":"D694Ws4vuBQy/+uh0JRDEyvM0pdtVDf/x1R4Wr3qDXy9uNbVI710l2ogcLvXYhLJnGu6Japs9jZ55N3GZoHOAg"}},"unsigned":{"age_ts":1672417775354}}	3
$81gCIX2tUwDG_Jg02kHVceEfsUG1IOQ9-YnDk1cV15w	!ffaaxOMHcWnINEXTWK:localhost	{"token_id":17,"historical":false}	{"auth_events":["$wTlWqRh3eGNrru9CGqbzkNcL0kBGbtEB8sHZwsAboS0"],"prev_events":["$wTlWqRh3eGNrru9CGqbzkNcL0kBGbtEB8sHZwsAboS0"],"type":"m.room.member","room_id":"!ffaaxOMHcWnINEXTWK:localhost","sender":"@bridgeadmin:localhost","content":{"membership":"join","displayname":"bridgeadmin"},"depth":2,"prev_state":[],"state_key":"@bridgeadmin:localhost","origin":"localhost","origin_server_ts":1672417775659,"hashes":{"sha256":"IKlq4eSuMX8YTMq0CxmaPyb7A6UWjzAEqDr5dKPnpf0"},"signatures":{"localhost":{"ed25519:a_CHdg":"jWowo2WhDSbzodFNl64vxzo+NWbWp1XBeDpOpYpBn6G78F1QFaH6XXyI3wzWU0h/n+2ThHnpwSI7sgV/89GnBw"}},"unsigned":{"age_ts":1672417775659}}	3
$pn5NPm28AfF5_169OnQQxTv4_ijcoN4k44UIvzGsN7k	!ffaaxOMHcWnINEXTWK:localhost	{"token_id":17,"historical":false}	{"auth_events":["$wTlWqRh3eGNrru9CGqbzkNcL0kBGbtEB8sHZwsAboS0","$81gCIX2tUwDG_Jg02kHVceEfsUG1IOQ9-YnDk1cV15w"],"prev_events":["$81gCIX2tUwDG_Jg02kHVceEfsUG1IOQ9-YnDk1cV15w"],"type":"m.room.power_levels","room_id":"!ffaaxOMHcWnINEXTWK:localhost","sender":"@bridgeadmin:localhost","content":{"users":{"@bridgeadmin:localhost":100},"users_default":0,"events":{"m.room.name":50,"m.room.power_levels":100,"m.room.history_visibility":100,"m.room.canonical_alias":50,"m.room.avatar":50,"m.room.tombstone":100,"m.room.server_acl":100,"m.room.encryption":100},"events_default":0,"state_default":50,"ban":50,"kick":50,"redact":50,"invite":50,"historical":100},"depth":3,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672417775783,"hashes":{"sha256":"+PUTfmIJIE2ya4z2XJgEn8/mE3hqjAYnuMHK0EnQjQ4"},"signatures":{"localhost":{"ed25519:a_CHdg":"pw+N/BhW7RjE2Tf7p/V79RK7ct3+PQuDV6rWFzXcUGrQD745ZWK4kzxzNSOgL6zQefD0ee0G91rO+igx23gpBg"}},"unsigned":{"age_ts":1672417775783}}	3
$PJZugFD-K6RtTB0vNzX1j0YFLZ9x4vli99YpMY9dzQk	!cwnFZrIkYIOvkCHJkc:localhost	{"token_id":17,"historical":false}	{"auth_events":["$AXgBEWEnQYL0m4F3qNGi4DDk7afIQe7a_hmRdZkAZLM","$41BPCZJ_9IbE7VgIqxEef1X7U2-FXJjTA25i2Q-n_gg"],"prev_events":["$41BPCZJ_9IbE7VgIqxEef1X7U2-FXJjTA25i2Q-n_gg"],"type":"m.room.power_levels","room_id":"!cwnFZrIkYIOvkCHJkc:localhost","sender":"@bridgeadmin:localhost","content":{"users":{"@bridgeadmin:localhost":100},"users_default":0,"events":{"m.room.name":50,"m.room.power_levels":100,"m.room.history_visibility":100,"m.room.canonical_alias":50,"m.room.avatar":50,"m.room.tombstone":100,"m.room.server_acl":100,"m.room.encryption":100},"events_default":0,"state_default":50,"ban":50,"kick":50,"redact":50,"invite":50,"historical":100},"depth":3,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672417775878,"hashes":{"sha256":"5HtQTMqAnmQ31jXwDsVPjbGcK1DHU1gUefro8y6eAwQ"},"signatures":{"localhost":{"ed25519:a_CHdg":"3EBSpOA27z9acOHtWAFSjtAZeZDS1+jLOXouH6gtP9JfYw+WJhr3oqlEelftVHmHHf75mGm+CfxrAT3K5yaoBQ"}},"unsigned":{"age_ts":1672417775878}}	3
$jLK4KwpKxGfwbMdz2oJbuUlHegeZ_5YucIy2ChSNCLg	!ffaaxOMHcWnINEXTWK:localhost	{"token_id":17,"historical":false}	{"auth_events":["$wTlWqRh3eGNrru9CGqbzkNcL0kBGbtEB8sHZwsAboS0","$pn5NPm28AfF5_169OnQQxTv4_ijcoN4k44UIvzGsN7k","$81gCIX2tUwDG_Jg02kHVceEfsUG1IOQ9-YnDk1cV15w"],"prev_events":["$pn5NPm28AfF5_169OnQQxTv4_ijcoN4k44UIvzGsN7k"],"type":"m.room.join_rules","room_id":"!ffaaxOMHcWnINEXTWK:localhost","sender":"@bridgeadmin:localhost","content":{"join_rule":"public"},"depth":4,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672417776106,"hashes":{"sha256":"mVCLXjzrc38f7JdfVyZ73xq6/NVNw2pXv7fFkr9Rc/Q"},"signatures":{"localhost":{"ed25519:a_CHdg":"lIOm6/zC8ufSTRwqSwA9DOd2ZPPGtW21eJCxueS9P9t1wElZ9Ism0MBQIiV6Asp4DR0lZ7MJ03V1KC+bPM9kCw"}},"unsigned":{"age_ts":1672417776106}}	3
$BNEpFvlxqdDF-6u3EPToNgfx0BuYX2_P9oWB486xTxM	!kAToIwhNWrDpgQVMfY:localhost	{"token_id":17,"historical":false}	{"auth_events":["$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw","$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc","$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE"],"prev_events":["$nL-1meDVcMfCo41V5V5w3EBPwNdmll7Alfsp00QCHvk"],"type":"m.space.child","room_id":"!kAToIwhNWrDpgQVMfY:localhost","sender":"@bridgeadmin:localhost","content":{"via":["localhost"],"suggested":true},"depth":10,"prev_state":[],"state_key":"!ffaaxOMHcWnINEXTWK:localhost","origin":"localhost","origin_server_ts":1672417777385,"hashes":{"sha256":"lbPDkbTIvvKz14Lxzr/vAmr+wWalI8lrB9FRsqHpHE4"},"signatures":{"localhost":{"ed25519:a_CHdg":"OwofntluZYrv40hIXFyzZcXgyvw9ty/mdWjdw4ahUh419+vi8KAHYji1C/jFxBmBfTXe+mgSU4QAnwh1NuzvBQ"}},"unsigned":{"age_ts":1672417777385}}	3
$Jy6RZhO0nZ0x_EgWugfJHW0XgWaR5DoWVaImG_wE3lg	!ffaaxOMHcWnINEXTWK:localhost	{"token_id":17,"historical":false}	{"auth_events":["$wTlWqRh3eGNrru9CGqbzkNcL0kBGbtEB8sHZwsAboS0","$pn5NPm28AfF5_169OnQQxTv4_ijcoN4k44UIvzGsN7k","$81gCIX2tUwDG_Jg02kHVceEfsUG1IOQ9-YnDk1cV15w"],"prev_events":["$jLK4KwpKxGfwbMdz2oJbuUlHegeZ_5YucIy2ChSNCLg"],"type":"m.room.guest_access","room_id":"!ffaaxOMHcWnINEXTWK:localhost","sender":"@bridgeadmin:localhost","content":{"guest_access":"can_join"},"depth":5,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672417776373,"hashes":{"sha256":"sDYpCiuqMxKStdBAiRmlzMuKmuO283zBjvhic0kv7r4"},"signatures":{"localhost":{"ed25519:a_CHdg":"9j0wgZUPomTW2iYN9Ipj4KHw9UCTPF4T7Due69KVgjkBvsu5JJLYPwSIO7vYJu/liBk8A63XyCNEr97Z/lkIDg"}},"unsigned":{"age_ts":1672417776373}}	3
$3ccBKAI_RT742spGFKzsNSBIzhj7WC7YBxugrDvyr4w	!cwnFZrIkYIOvkCHJkc:localhost	{"token_id":17,"historical":false}	{"auth_events":["$AXgBEWEnQYL0m4F3qNGi4DDk7afIQe7a_hmRdZkAZLM","$PJZugFD-K6RtTB0vNzX1j0YFLZ9x4vli99YpMY9dzQk","$41BPCZJ_9IbE7VgIqxEef1X7U2-FXJjTA25i2Q-n_gg"],"prev_events":["$ce28aY-iB2mpb8Gioxn_S-YFJtBn3dK4JRguWv9H2XY"],"type":"m.room.guest_access","room_id":"!cwnFZrIkYIOvkCHJkc:localhost","sender":"@bridgeadmin:localhost","content":{"guest_access":"can_join"},"depth":5,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672417776368,"hashes":{"sha256":"5Vn2fQ71SEqkd2GECucmxC74BGJ9szGIVC61H1IbdYs"},"signatures":{"localhost":{"ed25519:a_CHdg":"409m+rpKiGSOyrTNwhbNm1BM5zeAG1FUDwZiFNLLrTGTGSbTUuAz+4YCWpoq5IUyYNmVBuvDtCrHwGJGzWM0Bw"}},"unsigned":{"age_ts":1672417776368}}	3
$7CUacT0Q8hFhLt80ecyLwLrizW7Jh6uNtLYApZIgNg4	!cwnFZrIkYIOvkCHJkc:localhost	{"token_id":17,"historical":false}	{"auth_events":["$AXgBEWEnQYL0m4F3qNGi4DDk7afIQe7a_hmRdZkAZLM","$PJZugFD-K6RtTB0vNzX1j0YFLZ9x4vli99YpMY9dzQk","$41BPCZJ_9IbE7VgIqxEef1X7U2-FXJjTA25i2Q-n_gg"],"prev_events":["$3ccBKAI_RT742spGFKzsNSBIzhj7WC7YBxugrDvyr4w"],"type":"m.space.parent","room_id":"!cwnFZrIkYIOvkCHJkc:localhost","sender":"@bridgeadmin:localhost","content":{"via":["localhost"],"canonical":true},"depth":6,"prev_state":[],"state_key":"!kAToIwhNWrDpgQVMfY:localhost","origin":"localhost","origin_server_ts":1672417776624,"hashes":{"sha256":"ELjQ4oZv4NxezVjSjHkOc7DUJ8F2ZaDJKzMdDNxSFDo"},"signatures":{"localhost":{"ed25519:a_CHdg":"nYVFW+ta87uPqKss4Z5Dg6IkZqkGV0zyCXHD5BvDYc/166P7jWIxYc9fDd5MbRjP4kYZNaIgA4NSOVNg09kYAw"}},"unsigned":{"age_ts":1672417776624}}	3
$dLHdIN5p2aRYI16qULeP30FhKh5GGtUHvQUzWcSWyTA	!cwnFZrIkYIOvkCHJkc:localhost	{"token_id":17,"historical":false}	{"auth_events":["$AXgBEWEnQYL0m4F3qNGi4DDk7afIQe7a_hmRdZkAZLM","$PJZugFD-K6RtTB0vNzX1j0YFLZ9x4vli99YpMY9dzQk","$41BPCZJ_9IbE7VgIqxEef1X7U2-FXJjTA25i2Q-n_gg"],"prev_events":["$7CUacT0Q8hFhLt80ecyLwLrizW7Jh6uNtLYApZIgNg4"],"type":"m.room.history_visibility","room_id":"!cwnFZrIkYIOvkCHJkc:localhost","sender":"@bridgeadmin:localhost","content":{"history_visibility":"world_readable"},"depth":7,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672417776891,"hashes":{"sha256":"8+rKx16bTFw0lYmHxIMR1fYqVBI9nBjxxd922z8NXFo"},"signatures":{"localhost":{"ed25519:a_CHdg":"BzOGmMLNYF1fIQpbzpD1QtR+reLH3jC/Vk/smX6z/ay6HL7BL3COLm/ypflekIpIxdgCG53+7QFHu62juY1cAw"}},"unsigned":{"age_ts":1672417776891}}	3
$zxy8zKV-5WiZDQEOGVCLyrd2yGWyYrOah4vQYAlc-xI	!ffaaxOMHcWnINEXTWK:localhost	{"token_id":17,"historical":false}	{"auth_events":["$wTlWqRh3eGNrru9CGqbzkNcL0kBGbtEB8sHZwsAboS0","$pn5NPm28AfF5_169OnQQxTv4_ijcoN4k44UIvzGsN7k","$81gCIX2tUwDG_Jg02kHVceEfsUG1IOQ9-YnDk1cV15w"],"prev_events":["$Jy6RZhO0nZ0x_EgWugfJHW0XgWaR5DoWVaImG_wE3lg"],"type":"m.space.parent","room_id":"!ffaaxOMHcWnINEXTWK:localhost","sender":"@bridgeadmin:localhost","content":{"via":["localhost"],"canonical":true},"depth":6,"prev_state":[],"state_key":"!kAToIwhNWrDpgQVMfY:localhost","origin":"localhost","origin_server_ts":1672417776621,"hashes":{"sha256":"epOeUE5xPiFNZWlErxEV6y/nZwRkQRQ2GSaLz+Ie5A8"},"signatures":{"localhost":{"ed25519:a_CHdg":"dzBCH98COzq86h+CAzpbpTU56xxDl5kyxnrgBuI7O5LJjPsJ693+fAfGUhiuytfZHMc0GU9bII9P/VqJcLUdBQ"}},"unsigned":{"age_ts":1672417776621}}	3
$tWJ40KRMdaZwn6df_597mz_AyHLHUSEy0noQk3HlctY	!ffaaxOMHcWnINEXTWK:localhost	{"token_id":17,"historical":false}	{"auth_events":["$wTlWqRh3eGNrru9CGqbzkNcL0kBGbtEB8sHZwsAboS0","$pn5NPm28AfF5_169OnQQxTv4_ijcoN4k44UIvzGsN7k","$81gCIX2tUwDG_Jg02kHVceEfsUG1IOQ9-YnDk1cV15w"],"prev_events":["$e4RXblgeP3Sa0Hs3COmGOAFe9LclWYCrLIk7nF2PEDk"],"type":"m.room.name","room_id":"!ffaaxOMHcWnINEXTWK:localhost","sender":"@bridgeadmin:localhost","content":{"name":"Slumpm\\u00e4ssig"},"depth":8,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672417777067,"hashes":{"sha256":"WJdXUkX/F7e37Ny+PUx5il/5tPmnT+TFH5nJxaWShv0"},"signatures":{"localhost":{"ed25519:a_CHdg":"JUJGDoC7GxlXVqC7iSzauI7iRHlbOit5OSfR2xW6YPYrHYAvD7Btetxhnp9A5/5sG/ZLEFjviwvwt4U3RmeHBA"}},"unsigned":{"age_ts":1672417777067}}	3
$bFxX1nACgPihIeXfSiWHmW_hxrfmIgtQM9HWAPS2wVY	!kAToIwhNWrDpgQVMfY:localhost	{"token_id":17,"historical":false}	{"auth_events":["$KGv2op0D-6TOpQuqb5Gl4YZxMUKn37cUNSylMiEo7SA","$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE","$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw","$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc"],"prev_events":["$v_Jh2P1U7Li3ATyMsxgipoyBuQRYv5HD-cv8JVNpdLc","$BNEpFvlxqdDF-6u3EPToNgfx0BuYX2_P9oWB486xTxM"],"type":"m.room.member","room_id":"!kAToIwhNWrDpgQVMfY:localhost","sender":"@bridgeadmin:localhost","content":{"membership":"invite","displayname":"Matrix UserA"},"depth":11,"prev_state":[],"state_key":"@matrix_a:localhost","origin":"localhost","origin_server_ts":1672417798116,"hashes":{"sha256":"rRhDxsNAW6Zj3fhhkyZNwCcdnCzj21f5pK7uKId2eaE"},"signatures":{"localhost":{"ed25519:a_CHdg":"MpQD9cFhNxoYnKQz6tEkEb+mPP19wdYODybWK2+87fdJM4m0CiUMkTGAKbFluvE0sHB86w9kyYmsLNa5Lzb+Cw"}},"unsigned":{"age_ts":1672417798116,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#mittrum:localhost"},"sender":"@bridgeadmin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@bridgeadmin:localhost"},{"type":"m.room.member","state_key":"@bridgeadmin:localhost","content":{"membership":"join","displayname":"bridgeadmin"},"sender":"@bridgeadmin:localhost"},{"type":"m.room.create","state_key":"","content":{"type":"m.space","room_version":"6","creator":"@bridgeadmin:localhost"},"sender":"@bridgeadmin:localhost"},{"type":"m.room.name","state_key":"","content":{"name":"Mittrum"},"sender":"@bridgeadmin:localhost"}]}}	3
$b_nOg7oeQd8bhYHe5kvgAdNM0U6hcAUFdf-yhgbItfc	!cwnFZrIkYIOvkCHJkc:localhost	{"token_id":17,"txn_id":"m1672417821929.0","historical":false}	{"auth_events":["$AXgBEWEnQYL0m4F3qNGi4DDk7afIQe7a_hmRdZkAZLM","$PJZugFD-K6RtTB0vNzX1j0YFLZ9x4vli99YpMY9dzQk","$41BPCZJ_9IbE7VgIqxEef1X7U2-FXJjTA25i2Q-n_gg"],"prev_events":["$ab5rFOQQuDGj00oHfJaJKURhG6lNFNDKS0nkBlsLTMk"],"type":"m.room.message","room_id":"!cwnFZrIkYIOvkCHJkc:localhost","sender":"@bridgeadmin:localhost","content":{"org.matrix.msc1767.text":"kalle anka","body":"kalle anka","msgtype":"m.text"},"depth":9,"prev_state":[],"origin":"localhost","origin_server_ts":1672417822072,"hashes":{"sha256":"Op2WQ7kBve2K56M7dUdh5OmGd1KlU3zlZlXEl/ctA8A"},"signatures":{"localhost":{"ed25519:a_CHdg":"QZObSzaya6r/oMQEOHVIS0PCw2QuOPj6AwD+JLRnleu/iRpmDKe4J/bFf3Rhk1HCSfAyako2zUTuRBO2ki8DAA"}},"unsigned":{"age_ts":1672417822072}}	3
$ab5rFOQQuDGj00oHfJaJKURhG6lNFNDKS0nkBlsLTMk	!cwnFZrIkYIOvkCHJkc:localhost	{"token_id":17,"historical":false}	{"auth_events":["$AXgBEWEnQYL0m4F3qNGi4DDk7afIQe7a_hmRdZkAZLM","$PJZugFD-K6RtTB0vNzX1j0YFLZ9x4vli99YpMY9dzQk","$41BPCZJ_9IbE7VgIqxEef1X7U2-FXJjTA25i2Q-n_gg"],"prev_events":["$dLHdIN5p2aRYI16qULeP30FhKh5GGtUHvQUzWcSWyTA"],"type":"m.room.name","room_id":"!cwnFZrIkYIOvkCHJkc:localhost","sender":"@bridgeadmin:localhost","content":{"name":"Allm\\u00e4nt"},"depth":8,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672417777132,"hashes":{"sha256":"4GMTIywKNlT5zq7PMi+I4F8k2QMa5XFUF7XKQ7bDqVg"},"signatures":{"localhost":{"ed25519:a_CHdg":"54OCVtuXg2o0NcRfEE7YmDkfCEE3kt9uP0pexXlQPaLOwG4QUeFOeQ8UalIH8VvoIu/wczEUYqm9JYhFW0erAA"}},"unsigned":{"age_ts":1672417777132}}	3
$kL3ALUeGobajxL55gzYoIZLdD1CSD4sYXedIOysHwV0	!kAToIwhNWrDpgQVMfY:localhost	{"token_id":17,"historical":false}	{"auth_events":["$KGv2op0D-6TOpQuqb5Gl4YZxMUKn37cUNSylMiEo7SA","$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE","$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw","$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc"],"prev_events":["$bFxX1nACgPihIeXfSiWHmW_hxrfmIgtQM9HWAPS2wVY"],"type":"m.room.member","room_id":"!kAToIwhNWrDpgQVMfY:localhost","sender":"@bridgeadmin:localhost","content":{"membership":"invite","displayname":"matrix_b"},"depth":12,"prev_state":[],"state_key":"@matrix_b:localhost","origin":"localhost","origin_server_ts":1672417798307,"hashes":{"sha256":"62kvFemeifBeWV8eRkoVKEQeUCLh7ZLKOLNP8YgF5nA"},"signatures":{"localhost":{"ed25519:a_CHdg":"51NuiFraSCOJ99p2cy3BZNjiqBRSB07Dqx3z0sK2UxCYaFcVrAXT6MVaL9biEM6w5HRTCSBqec9wKsP3Y/V5CA"}},"unsigned":{"age_ts":1672417798307,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#mittrum:localhost"},"sender":"@bridgeadmin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@bridgeadmin:localhost"},{"type":"m.room.create","state_key":"","content":{"type":"m.space","room_version":"6","creator":"@bridgeadmin:localhost"},"sender":"@bridgeadmin:localhost"},{"type":"m.room.name","state_key":"","content":{"name":"Mittrum"},"sender":"@bridgeadmin:localhost"},{"type":"m.room.member","state_key":"@bridgeadmin:localhost","content":{"membership":"join","displayname":"bridgeadmin"},"sender":"@bridgeadmin:localhost"}]}}	3
$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q	!LwtGEdNVvQHvFLuWQB:localhost	{"token_id":16,"historical":false}	{"auth_events":[],"prev_events":[],"type":"m.room.create","room_id":"!LwtGEdNVvQHvFLuWQB:localhost","sender":"@bridgeadmin:localhost","content":{"room_version":"6","creator":"@bridgeadmin:localhost"},"depth":1,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672480138531,"hashes":{"sha256":"FaSJg6KtHh7IHlfscZtQZwVspOlfYZDgXh3P3B8V+ZA"},"signatures":{"localhost":{"ed25519:a_CHdg":"l/UV/3y85k7gu0OBkAHM9b82qlhspGLyk/VBz4TTYRdQMUQ3HED7V+PUhXVkmTWQBpjYHxWN3M2Z/cII96NXCA"}},"unsigned":{"age_ts":1672480138531}}	3
$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic	!LwtGEdNVvQHvFLuWQB:localhost	{"token_id":16,"historical":false}	{"auth_events":["$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q"],"prev_events":["$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q"],"type":"m.room.member","room_id":"!LwtGEdNVvQHvFLuWQB:localhost","sender":"@bridgeadmin:localhost","content":{"membership":"join","displayname":"bridgeadmin"},"depth":2,"prev_state":[],"state_key":"@bridgeadmin:localhost","origin":"localhost","origin_server_ts":1672480138689,"hashes":{"sha256":"yu0I/9Gg/1Z1GAkuWmHHAaOMKZHj0iJ/hvAGwOKGgzA"},"signatures":{"localhost":{"ed25519:a_CHdg":"3LTFaOXfaMxLBOS2ghyfSaOMkibAPZp5oIxIMdooNbRNJpjrG4EW6sY/7luM9KLG1pS7CXu0aeT8M72pVLpGAA"}},"unsigned":{"age_ts":1672480138689}}	3
$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k	!LwtGEdNVvQHvFLuWQB:localhost	{"token_id":16,"historical":false}	{"auth_events":["$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic","$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q"],"prev_events":["$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic"],"type":"m.room.power_levels","room_id":"!LwtGEdNVvQHvFLuWQB:localhost","sender":"@bridgeadmin:localhost","content":{"users":{"@bridgeadmin:localhost":100,"@admin:localhost":100},"users_default":0,"events":{"m.room.name":50,"m.room.power_levels":100,"m.room.history_visibility":100,"m.room.canonical_alias":50,"m.room.avatar":50,"m.room.tombstone":100,"m.room.server_acl":100,"m.room.encryption":100},"events_default":0,"state_default":50,"ban":50,"kick":50,"redact":50,"invite":0,"historical":100},"depth":3,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672480138977,"hashes":{"sha256":"GWOxcVJexjrjhuURP4BOYhxJBCBuvXJBEBo0VlWrfNk"},"signatures":{"localhost":{"ed25519:a_CHdg":"Nk2IE2cFXj+oFgka/PRRDC+DkWe7bEA0NTQLPLYjP6vLkZXX0Q9P4X5N8N3frbJUyYEVt9EBHk9RZ4gUKt00Aw"}},"unsigned":{"age_ts":1672480138977}}	3
$PTHh0FcsZLrplrmwtCyvLjXr1yAZRgovFGLVt7qrrAo	!LwtGEdNVvQHvFLuWQB:localhost	{"token_id":16,"historical":false}	{"auth_events":["$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic","$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q","$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k"],"prev_events":["$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k"],"type":"m.room.join_rules","room_id":"!LwtGEdNVvQHvFLuWQB:localhost","sender":"@bridgeadmin:localhost","content":{"join_rule":"invite"},"depth":4,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672480139246,"hashes":{"sha256":"5JtWFPCSU4SpQf/HskXaW9DkzfxsfpeAPTEbFqbr/Fc"},"signatures":{"localhost":{"ed25519:a_CHdg":"GWOvZmFVzwNLku8NLiNuymM5EzaJUjx/ZuJGpb35h36I+WBCCCnL68nVpaqIvfm2+P1o8+O3RTVYTiV3TNhTDA"}},"unsigned":{"age_ts":1672480139246}}	3
$6CLZCTGtpIVnohQDg2sJwn_880f0--zCZpr6BgOwQ2Q	!LwtGEdNVvQHvFLuWQB:localhost	{"token_id":16,"historical":false}	{"auth_events":["$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic","$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q","$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k"],"prev_events":["$PTHh0FcsZLrplrmwtCyvLjXr1yAZRgovFGLVt7qrrAo"],"type":"m.room.history_visibility","room_id":"!LwtGEdNVvQHvFLuWQB:localhost","sender":"@bridgeadmin:localhost","content":{"history_visibility":"shared"},"depth":5,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672480139417,"hashes":{"sha256":"y1b2daTi320smou3aXQE8hRU0c7uj8ih2zdDihv/ymg"},"signatures":{"localhost":{"ed25519:a_CHdg":"Pt9VE8Xj6KsRAfXO1oSvgFQbQ5LgQLCc8L4k4Hxm8eYamfdHPKwfLQvZl3lVsCAg7sUw8zRWW7625QP+oMbWBA"}},"unsigned":{"age_ts":1672480139417}}	3
$nKXxWIIoo5Vko9Z7kITUEeAsQgQnr-FLvhoQHfkCYAE	!LwtGEdNVvQHvFLuWQB:localhost	{"token_id":16,"historical":false}	{"auth_events":["$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic","$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q","$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k"],"prev_events":["$6CLZCTGtpIVnohQDg2sJwn_880f0--zCZpr6BgOwQ2Q"],"type":"m.room.guest_access","room_id":"!LwtGEdNVvQHvFLuWQB:localhost","sender":"@bridgeadmin:localhost","content":{"guest_access":"can_join"},"depth":6,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672480139567,"hashes":{"sha256":"Ych+jl7XBeM9IeUFOpKylkXcCxnu3wdlX5tY93BhRNU"},"signatures":{"localhost":{"ed25519:a_CHdg":"KfPp1GSz/mT9PRV7M9En66TqXEBOVJyyvPeMPlpVcU46x5lviGxKeucUXc3q78EhooIARV6TgKw7cctvULm9CA"}},"unsigned":{"age_ts":1672480139567}}	3
$TbFvVskFwRsxEgjNnOjfs4ljMJuZC60_Cqb91vOUrxg	!LwtGEdNVvQHvFLuWQB:localhost	{"token_id":16,"historical":false}	{"auth_events":["$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k","$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q","$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic","$PTHh0FcsZLrplrmwtCyvLjXr1yAZRgovFGLVt7qrrAo"],"prev_events":["$nKXxWIIoo5Vko9Z7kITUEeAsQgQnr-FLvhoQHfkCYAE"],"type":"m.room.member","room_id":"!LwtGEdNVvQHvFLuWQB:localhost","sender":"@bridgeadmin:localhost","content":{"is_direct":true,"membership":"invite","displayname":"Admin User"},"depth":7,"prev_state":[],"state_key":"@admin:localhost","origin":"localhost","origin_server_ts":1672480139730,"hashes":{"sha256":"i0EnZzt0IT0ks7ruf330a4Br/1upUGiXyCC0pKK3agM"},"signatures":{"localhost":{"ed25519:a_CHdg":"BxaTkPhhsA6nat3G/VErjF5TvDYZ2pgy8BLUBKnZuTm0y8zHavo3QU180r2LWXzO1vskFikkrgssnTNPinxaBg"}},"unsigned":{"age_ts":1672480139730,"invite_room_state":[{"type":"m.room.create","state_key":"","content":{"room_version":"6","creator":"@bridgeadmin:localhost"},"sender":"@bridgeadmin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"invite"},"sender":"@bridgeadmin:localhost"},{"type":"m.room.member","state_key":"@bridgeadmin:localhost","content":{"membership":"join","displayname":"bridgeadmin"},"sender":"@bridgeadmin:localhost"}]}}	3
$Fu0mjSRDDuhZx4RxMK6O8cvc6t75G99rXoFXGU-7868	!LwtGEdNVvQHvFLuWQB:localhost	{"token_id":16,"txn_id":"m1672480140375.5","historical":false}	{"auth_events":["$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic","$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q","$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k"],"prev_events":["$TbFvVskFwRsxEgjNnOjfs4ljMJuZC60_Cqb91vOUrxg"],"type":"m.room.message","room_id":"!LwtGEdNVvQHvFLuWQB:localhost","sender":"@bridgeadmin:localhost","content":{"org.matrix.msc1767.text":"Kalle","body":"Kalle","msgtype":"m.text"},"depth":8,"prev_state":[],"origin":"localhost","origin_server_ts":1672480140439,"hashes":{"sha256":"JgTodt6U0xEkSEJz9s60RvdSrid6CMSdvUUcXNz5Plw"},"signatures":{"localhost":{"ed25519:a_CHdg":"psN7udFy6ahe4Pog9JMBxdlqUvGzchhqsfDYQpAf9/ApsKJguI8SpJusmap3XV41LJ+AdHKtZwYOkpo4eIoyAw"}},"unsigned":{"age_ts":1672480140439}}	3
$SuM_AupYZSEtAJBPHbvNkhJ4aIYEjT4c741wzkoOX4I	!LwtGEdNVvQHvFLuWQB:localhost	{"token_id":16,"historical":false}	{"auth_events":["$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic","$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q","$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k"],"prev_events":["$Fu0mjSRDDuhZx4RxMK6O8cvc6t75G99rXoFXGU-7868"],"type":"m.room.encryption","room_id":"!LwtGEdNVvQHvFLuWQB:localhost","sender":"@bridgeadmin:localhost","content":{"algorithm":"m.megolm.v1.aes-sha2"},"depth":9,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672480178123,"hashes":{"sha256":"u9WcLqbjWYb5D5a0nmQWLSavqqYHuXfOR+p+CBVfEfw"},"signatures":{"localhost":{"ed25519:a_CHdg":"WQA312iWAUZTqEwqNf9wuE5uZr119XRH90uXHc3quRTdS1uszQ0qHQqAeVfL6ZqclrwS13S7yHkjeMGcxFsOBw"}},"unsigned":{"age_ts":1672480178123}}	3
$_-6CgruWK6UfiL1rgJnNUgtmp_jusf_3Vf7LUPB6xaU	!GNlLBsLXjbOuNhCkEO:localhost	{"token_id":16,"historical":false}	{"auth_events":[],"prev_events":[],"type":"m.room.create","room_id":"!GNlLBsLXjbOuNhCkEO:localhost","sender":"@bridgeadmin:localhost","content":{"room_version":"9","predecessor":{"room_id":"!LwtGEdNVvQHvFLuWQB:localhost","event_id":"$smbpaz4v1tYoI0ZZ-HXKXrcs19S7qioXa8ah6FeOBpc"},"creator":"@bridgeadmin:localhost"},"depth":1,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672480208324,"hashes":{"sha256":"nyA4hplHScuM9dm0dR9ltCQw3a3OwHZ7hTai8hvtB1I"},"signatures":{"localhost":{"ed25519:a_CHdg":"XFJdi2I83cdHNq8TBwsp+lDAJxXtIt4td4DTMRB8IyI8XI0YHR5x9v1AgCFD9Onl6uZIB4DzCFVXzJDFZIemAA"}},"unsigned":{"age_ts":1672480208324}}	3
$uKKFUGwf_IAnbH81DTvAScd2HFnAwWWL_p4-E5B_YdU	!GNlLBsLXjbOuNhCkEO:localhost	{"token_id":16,"historical":false}	{"auth_events":["$yrfdAmX0K0lY65Dm9bViRYWOBKtvTB1kxkm6lNsThdw","$_-6CgruWK6UfiL1rgJnNUgtmp_jusf_3Vf7LUPB6xaU"],"prev_events":["$yrfdAmX0K0lY65Dm9bViRYWOBKtvTB1kxkm6lNsThdw"],"type":"m.room.power_levels","room_id":"!GNlLBsLXjbOuNhCkEO:localhost","sender":"@bridgeadmin:localhost","content":{"users":{"@bridgeadmin:localhost":100,"@admin:localhost":100},"users_default":0,"events":{"m.room.name":50,"m.room.power_levels":100,"m.room.history_visibility":100,"m.room.canonical_alias":50,"m.room.avatar":50,"m.room.tombstone":100,"m.room.server_acl":100,"m.room.encryption":100},"events_default":0,"state_default":50,"ban":50,"kick":50,"redact":50,"invite":0,"historical":100},"depth":3,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672480208538,"hashes":{"sha256":"saosKJ1pIC+4ghNlIbGLZKTYaBrDPCrNob0jidS0KSU"},"signatures":{"localhost":{"ed25519:a_CHdg":"a1tgWP7kFIjcqj9lxJVVjUOz2SPZ1jl1DzGUMO9PhtXXk7uauBMclTA8N3VNmbjxkssJ9mwsJaGcTP/m0eQnBA"}},"unsigned":{"age_ts":1672480208538}}	3
$lnpmPOjrFoaPq58156r6g4G7gYfejQ2BfcFkjGiEX-I	!GNlLBsLXjbOuNhCkEO:localhost	{"token_id":16,"historical":false}	{"auth_events":["$yrfdAmX0K0lY65Dm9bViRYWOBKtvTB1kxkm6lNsThdw","$_-6CgruWK6UfiL1rgJnNUgtmp_jusf_3Vf7LUPB6xaU","$uKKFUGwf_IAnbH81DTvAScd2HFnAwWWL_p4-E5B_YdU"],"prev_events":["$ah5gH_XfCIYeCtl2NFxHSgdd_OE6O9tHe2U1Pn2Qvhc"],"type":"m.room.history_visibility","room_id":"!GNlLBsLXjbOuNhCkEO:localhost","sender":"@bridgeadmin:localhost","content":{"history_visibility":"shared"},"depth":6,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672480209211,"hashes":{"sha256":"PjYKCOYvXzWr4qytkVdUec5NqQKj2N1+OM0iB2U37gI"},"signatures":{"localhost":{"ed25519:a_CHdg":"G6N9qBPY58FI00ZnND9Cg9bWo9YZcAXPW94052Yj2SetM4zz0D1bTlyGYarf5Mqse/Sx1p9CY9631aWKN/q9Aw"}},"unsigned":{"age_ts":1672480209211}}	3
$O-kcGXcFLVtSNAY7CxqW4hLVBk0UqhADtIs1kCz8hlA	!LwtGEdNVvQHvFLuWQB:localhost	{"token_id":16,"historical":false}	{"auth_events":["$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic","$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q","$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k"],"prev_events":["$smbpaz4v1tYoI0ZZ-HXKXrcs19S7qioXa8ah6FeOBpc"],"type":"m.room.power_levels","room_id":"!LwtGEdNVvQHvFLuWQB:localhost","sender":"@bridgeadmin:localhost","content":{"users":{"@bridgeadmin:localhost":100,"@admin:localhost":100},"users_default":0,"events":{"m.room.name":50,"m.room.power_levels":100,"m.room.history_visibility":100,"m.room.canonical_alias":50,"m.room.avatar":50,"m.room.tombstone":100,"m.room.server_acl":100,"m.room.encryption":100},"events_default":50,"state_default":50,"ban":50,"kick":50,"redact":50,"invite":50,"historical":100},"depth":11,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672480209754,"hashes":{"sha256":"2KDbvXtCQDdQWAb3pC+k02kZzskv42kjhz2UJnOAfds"},"signatures":{"localhost":{"ed25519:a_CHdg":"64JvAtMB2dFTyvat90tKkpG+QwNk2laNU+eWd8ShB+NkGDvKWqePbumKDKrjliSba+rNj+eT9eQmZ38pZnWkAA"}},"unsigned":{"age_ts":1672480209754,"replaces_state":"$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k"}}	3
$yrfdAmX0K0lY65Dm9bViRYWOBKtvTB1kxkm6lNsThdw	!GNlLBsLXjbOuNhCkEO:localhost	{"token_id":16,"historical":false}	{"auth_events":["$_-6CgruWK6UfiL1rgJnNUgtmp_jusf_3Vf7LUPB6xaU"],"prev_events":["$_-6CgruWK6UfiL1rgJnNUgtmp_jusf_3Vf7LUPB6xaU"],"type":"m.room.member","room_id":"!GNlLBsLXjbOuNhCkEO:localhost","sender":"@bridgeadmin:localhost","content":{"membership":"join","displayname":"bridgeadmin"},"depth":2,"prev_state":[],"state_key":"@bridgeadmin:localhost","origin":"localhost","origin_server_ts":1672480208432,"hashes":{"sha256":"6myScccgjoYiUTeUhzEqDUDR9MRXZjbKRz2F1CCgRQw"},"signatures":{"localhost":{"ed25519:a_CHdg":"gRSoeVNC3I9ndcvzTCJzixXZo8O+jUL5qntNXdjTarGvWsmo2j8PuehXYGZGV3iAs6YySJRtRJ03MexFCxT5Bg"}},"unsigned":{"age_ts":1672480208432}}	3
$MRytSYI-n7aCgzUssVx9vLIC5Y-Yt22y_L1eQoE4GgE	!GNlLBsLXjbOuNhCkEO:localhost	{"token_id":16,"historical":false}	{"auth_events":["$yrfdAmX0K0lY65Dm9bViRYWOBKtvTB1kxkm6lNsThdw","$_-6CgruWK6UfiL1rgJnNUgtmp_jusf_3Vf7LUPB6xaU","$uKKFUGwf_IAnbH81DTvAScd2HFnAwWWL_p4-E5B_YdU"],"prev_events":["$uKKFUGwf_IAnbH81DTvAScd2HFnAwWWL_p4-E5B_YdU"],"type":"m.room.encryption","room_id":"!GNlLBsLXjbOuNhCkEO:localhost","sender":"@bridgeadmin:localhost","content":{"algorithm":"m.megolm.v1.aes-sha2"},"depth":4,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672480208936,"hashes":{"sha256":"Axy/9kAHbo29shwsT1lS1dq5ses6ZefzGP2ZKMLY/IE"},"signatures":{"localhost":{"ed25519:a_CHdg":"p+RnCJbOYDjqQufQkgFpRISDA62+4MS4UQs1aWCLPE74WXXomj33k69ENxBVv4lGozNKtok8bZ56LeLVB+QFDg"}},"unsigned":{"age_ts":1672480208936}}	3
$fuvIFJYv32qkEsYyW8XNHbQ0hmQ5HHRjF6UEjte6Z-c	!GNlLBsLXjbOuNhCkEO:localhost	{"token_id":16,"historical":false}	{"auth_events":["$yrfdAmX0K0lY65Dm9bViRYWOBKtvTB1kxkm6lNsThdw","$_-6CgruWK6UfiL1rgJnNUgtmp_jusf_3Vf7LUPB6xaU","$uKKFUGwf_IAnbH81DTvAScd2HFnAwWWL_p4-E5B_YdU"],"prev_events":["$lnpmPOjrFoaPq58156r6g4G7gYfejQ2BfcFkjGiEX-I"],"type":"m.room.join_rules","room_id":"!GNlLBsLXjbOuNhCkEO:localhost","sender":"@bridgeadmin:localhost","content":{"join_rule":"invite"},"depth":7,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672480209339,"hashes":{"sha256":"z86n4nKrQsL9yE8onLQHKLSxtTLZNw6TmutSXiqpIdA"},"signatures":{"localhost":{"ed25519:a_CHdg":"QAqpbDZaO+XJr1XEOqSKoU3NqgkBRfbVy4p1d/tBEl8iu7QIqkwUzz9Hzgceg/mSmoCxxayQmmVy/qBH1EnECQ"}},"unsigned":{"age_ts":1672480209339}}	3
$vesveJhdimZ9d-Po76D8SZCUm8dVzl0GcQsvVX8lhos	!GNlLBsLXjbOuNhCkEO:localhost	{"token_id":16,"historical":false}	{"auth_events":["$uKKFUGwf_IAnbH81DTvAScd2HFnAwWWL_p4-E5B_YdU","$_-6CgruWK6UfiL1rgJnNUgtmp_jusf_3Vf7LUPB6xaU","$yrfdAmX0K0lY65Dm9bViRYWOBKtvTB1kxkm6lNsThdw","$fuvIFJYv32qkEsYyW8XNHbQ0hmQ5HHRjF6UEjte6Z-c"],"prev_events":["$fuvIFJYv32qkEsYyW8XNHbQ0hmQ5HHRjF6UEjte6Z-c"],"type":"m.room.member","room_id":"!GNlLBsLXjbOuNhCkEO:localhost","sender":"@bridgeadmin:localhost","content":{"membership":"invite","displayname":"Admin User"},"depth":8,"prev_state":[],"state_key":"@admin:localhost","origin":"localhost","origin_server_ts":1672480210059,"hashes":{"sha256":"CKKMOq+8N/KmqvdoSPhdXnSaXCi2zdZgrAV44SEfZuk"},"signatures":{"localhost":{"ed25519:a_CHdg":"uZzXIBojfOBhLSaQ8uOeQmCT0NiKnMunRI793jdjd5ezAegGPI7Jz2GqyMn7OVoE0gPQFa3xABDo9OD50Zw6DA"}},"unsigned":{"age_ts":1672480210059,"invite_room_state":[{"type":"m.room.create","state_key":"","content":{"room_version":"9","predecessor":{"room_id":"!LwtGEdNVvQHvFLuWQB:localhost","event_id":"$smbpaz4v1tYoI0ZZ-HXKXrcs19S7qioXa8ah6FeOBpc"},"creator":"@bridgeadmin:localhost"},"sender":"@bridgeadmin:localhost"},{"type":"m.room.encryption","state_key":"","content":{"algorithm":"m.megolm.v1.aes-sha2"},"sender":"@bridgeadmin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"invite"},"sender":"@bridgeadmin:localhost"},{"type":"m.room.member","state_key":"@bridgeadmin:localhost","content":{"membership":"join","displayname":"bridgeadmin"},"sender":"@bridgeadmin:localhost"}]}}	3
$ah5gH_XfCIYeCtl2NFxHSgdd_OE6O9tHe2U1Pn2Qvhc	!GNlLBsLXjbOuNhCkEO:localhost	{"token_id":16,"historical":false}	{"auth_events":["$yrfdAmX0K0lY65Dm9bViRYWOBKtvTB1kxkm6lNsThdw","$_-6CgruWK6UfiL1rgJnNUgtmp_jusf_3Vf7LUPB6xaU","$uKKFUGwf_IAnbH81DTvAScd2HFnAwWWL_p4-E5B_YdU"],"prev_events":["$MRytSYI-n7aCgzUssVx9vLIC5Y-Yt22y_L1eQoE4GgE"],"type":"m.room.guest_access","room_id":"!GNlLBsLXjbOuNhCkEO:localhost","sender":"@bridgeadmin:localhost","content":{"guest_access":"can_join"},"depth":5,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672480209077,"hashes":{"sha256":"Q12jRe+3/MKv75nu/MWIsJal1GBoamIMhuH//ZkRVzc"},"signatures":{"localhost":{"ed25519:a_CHdg":"LwCglVPZPrui4lrZlbR7aZI7itoFWkiw1cjYb6lUa9KhHXE8YsJtD9nHbJHLlKiG8X7UCOMWuEYs5BmOnsqYBA"}},"unsigned":{"age_ts":1672480209077}}	3
$smbpaz4v1tYoI0ZZ-HXKXrcs19S7qioXa8ah6FeOBpc	!LwtGEdNVvQHvFLuWQB:localhost	{"token_id":16,"historical":false}	{"auth_events":["$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic","$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q","$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k"],"prev_events":["$SuM_AupYZSEtAJBPHbvNkhJ4aIYEjT4c741wzkoOX4I"],"type":"m.room.tombstone","room_id":"!LwtGEdNVvQHvFLuWQB:localhost","sender":"@bridgeadmin:localhost","content":{"body":"This room has been replaced","replacement_room":"!GNlLBsLXjbOuNhCkEO:localhost"},"depth":10,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672480208302,"hashes":{"sha256":"76NKDni+OKxBl7VTLYqrto5yVv2KCVCO0Va/Ek6+tgA"},"signatures":{"localhost":{"ed25519:a_CHdg":"ZreA+YX8Thw8aVLKeTnbbWYA9dbHZh7k2v4fPgBFm5YQo7k9lhvjZt4p2SyMAtz2KY37XIu4qKahKnIn+ujlBg"}},"unsigned":{"age_ts":1672480208302}}	3
$nfronhC7iKGPRmKJ7zoXzYG7VKiOq5FoUIcfHg3a4Dg	!GNlLBsLXjbOuNhCkEO:localhost	{"token_id":17,"historical":false}	{"auth_events":["$vesveJhdimZ9d-Po76D8SZCUm8dVzl0GcQsvVX8lhos","$_-6CgruWK6UfiL1rgJnNUgtmp_jusf_3Vf7LUPB6xaU","$uKKFUGwf_IAnbH81DTvAScd2HFnAwWWL_p4-E5B_YdU","$fuvIFJYv32qkEsYyW8XNHbQ0hmQ5HHRjF6UEjte6Z-c"],"prev_events":["$vesveJhdimZ9d-Po76D8SZCUm8dVzl0GcQsvVX8lhos"],"type":"m.room.member","room_id":"!GNlLBsLXjbOuNhCkEO:localhost","sender":"@admin:localhost","content":{"membership":"join","displayname":"admin"},"depth":9,"prev_state":[],"state_key":"@admin:localhost","origin":"localhost","origin_server_ts":1672481639271,"hashes":{"sha256":"+Wj+GCAjF/NbPQdQdpprQfjNF2x3sQsdMnBebEm2P5w"},"signatures":{"localhost":{"ed25519:a_CHdg":"U4La8TqhZHyfn/dbONEBs9IR9FipSqQBhzYCYww4kjmOogrgnqgzUt4qSTmYLirBohddb/lyzRmEqZaEcnGuAg"}},"unsigned":{"age_ts":1672481639271,"replaces_state":"$vesveJhdimZ9d-Po76D8SZCUm8dVzl0GcQsvVX8lhos"}}	3
$Pem9TyngNuhpIq_NI2krx6wpkVigoBj6JCeB3WUezVk	!MrxfbdodytWwBMqNiF:localhost	{"token_id":17,"historical":false}	{"auth_events":["$V_QrTFMCwHlrg-MSVVplcYCRVWM_QgXhIvp-2R_LtHI","$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY","$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA","$TVXtgqtZ5WfNfZEnJQx6m0NYwp0_34ylOK87XzZ3JlI"],"prev_events":["$Nv-ymHeLYsZKVjdilAoBLGC4GlzNJWt1HBqtIlSIz1k"],"type":"m.room.member","room_id":"!MrxfbdodytWwBMqNiF:localhost","sender":"@admin:localhost","content":{"membership":"join","displayname":"admin"},"depth":9,"prev_state":[],"state_key":"@admin:localhost","origin":"localhost","origin_server_ts":1672481652243,"hashes":{"sha256":"tFny7ANNcLXfTIeJ9geWq2+B/GpQzDBJw1DgXXGX81k"},"signatures":{"localhost":{"ed25519:a_CHdg":"+XYNprjC37gvR0ZBiLWtfqHohoOXLqb6Qn1mZOIzND0lCLX8+iEkU8S06Kx2tdPooihd6QPWGPBEts4v2rqgDg"}},"unsigned":{"age_ts":1672481652243,"replaces_state":"$V_QrTFMCwHlrg-MSVVplcYCRVWM_QgXhIvp-2R_LtHI"}}	3
$Fe89WlTUpNMZrgSmSzGQHSt495sI5DkA-kewln3Ug70	!MrxfbdodytWwBMqNiF:localhost	{"token_id":17,"txn_id":"m1672481657331.0","historical":false}	{"auth_events":["$Pem9TyngNuhpIq_NI2krx6wpkVigoBj6JCeB3WUezVk","$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY","$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA"],"prev_events":["$Pem9TyngNuhpIq_NI2krx6wpkVigoBj6JCeB3WUezVk"],"type":"m.room.message","room_id":"!MrxfbdodytWwBMqNiF:localhost","sender":"@admin:localhost","content":{"org.matrix.msc1767.text":"OK","body":"OK","msgtype":"m.text"},"depth":10,"prev_state":[],"origin":"localhost","origin_server_ts":1672481657418,"hashes":{"sha256":"27iSFK95sSJw4NYbWT7+QyS23J3/siW/e3L5jTPSe5I"},"signatures":{"localhost":{"ed25519:a_CHdg":"Q8fOxWDbLLW6t+1l7DuHUjjOoP6tBOgqDnYtV5/hoF3CPdDwQZkJiocCjceevokawn8P6gqSKabb84QbCj24Ag"}},"unsigned":{"age_ts":1672481657418}}	3
$viSFX8RvY5fe8TiOaDirNG6PqooEHTTV3PT3hrQgVLA	!MrxfbdodytWwBMqNiF:localhost	{"token_id":17,"historical":false}	{"auth_events":["$Pem9TyngNuhpIq_NI2krx6wpkVigoBj6JCeB3WUezVk","$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY","$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA"],"prev_events":["$Fe89WlTUpNMZrgSmSzGQHSt495sI5DkA-kewln3Ug70"],"type":"m.room.encryption","room_id":"!MrxfbdodytWwBMqNiF:localhost","sender":"@admin:localhost","content":{"algorithm":"m.megolm.v1.aes-sha2"},"depth":11,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672481727245,"hashes":{"sha256":"esLt3m6DU7OcqSdDVcmGN6npbVd4RTkKpdYTs+rhBmk"},"signatures":{"localhost":{"ed25519:a_CHdg":"Vms0wRGfBmj1akwQiS9jCWXTWrcny5/63eskgBPRsQUdmG0lNdtHA6blgrzMeDyH9Uzyy9xyX6EsI8P1F70eBw"}},"unsigned":{"age_ts":1672481727245}}	3
$A5h106ytjQ2qqPxkSylhOkJgVZQCscB4QX0PK60qxU0	!nPrdOOfNMRrmJedabn:localhost	{"token_id":17,"historical":false}	{"auth_events":[],"prev_events":[],"type":"m.room.create","room_id":"!nPrdOOfNMRrmJedabn:localhost","sender":"@admin:localhost","content":{"room_version":"9","predecessor":{"room_id":"!MrxfbdodytWwBMqNiF:localhost","event_id":"$MT4EKTmcPC8LCVeATiG-5a71N2Zc1vNQcgKge5W0on8"},"creator":"@admin:localhost"},"depth":1,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672481741052,"hashes":{"sha256":"jPtDGBVOdb5GyM6XhLY6doCZ+vC2nNcoZ+aajANsKXY"},"signatures":{"localhost":{"ed25519:a_CHdg":"HoC+n6khsVbY9uhrOtWasR+hK9S7w8uewhsLE3Y1hfWGt+bReqieZN5YcNxLd27aZ8sLkJRcQSdIZWanbmizBQ"}},"unsigned":{"age_ts":1672481741052}}	3
$AMnH95Ky85GttLR7j9XHrHyULlBBezFJ9w8mtji-7Ok	!nPrdOOfNMRrmJedabn:localhost	{"token_id":17,"historical":false}	{"auth_events":["$A5h106ytjQ2qqPxkSylhOkJgVZQCscB4QX0PK60qxU0"],"prev_events":["$A5h106ytjQ2qqPxkSylhOkJgVZQCscB4QX0PK60qxU0"],"type":"m.room.member","room_id":"!nPrdOOfNMRrmJedabn:localhost","sender":"@admin:localhost","content":{"membership":"join","displayname":"admin"},"depth":2,"prev_state":[],"state_key":"@admin:localhost","origin":"localhost","origin_server_ts":1672481741153,"hashes":{"sha256":"KoiA7pFY5Gq8K/hAoC13tUQg5AhphoioKrF+d0jOlGI"},"signatures":{"localhost":{"ed25519:a_CHdg":"Jp4uCgmvyTemo26q9Boz/lc8IlCmT43ehnugWNsX3Th68xuiVqRZDbXQrlUHD7W/QEQiqABnzOzWxmQWf6SzBw"}},"unsigned":{"age_ts":1672481741153}}	3
$gDW6j_UqhvIRf1ANEKurSD9fB4Hl4YnQ5uL9cy_U7Os	!nPrdOOfNMRrmJedabn:localhost	{"token_id":17,"historical":false}	{"auth_events":["$AMnH95Ky85GttLR7j9XHrHyULlBBezFJ9w8mtji-7Ok","$A5h106ytjQ2qqPxkSylhOkJgVZQCscB4QX0PK60qxU0"],"prev_events":["$AMnH95Ky85GttLR7j9XHrHyULlBBezFJ9w8mtji-7Ok"],"type":"m.room.power_levels","room_id":"!nPrdOOfNMRrmJedabn:localhost","sender":"@admin:localhost","content":{"users":{"@bridgeuser1:localhost":100,"@admin:localhost":100},"users_default":0,"events":{"m.room.name":50,"m.room.power_levels":100,"m.room.history_visibility":100,"m.room.canonical_alias":50,"m.room.avatar":50,"m.room.tombstone":100,"m.room.server_acl":100,"m.room.encryption":100},"events_default":0,"state_default":50,"ban":50,"kick":50,"redact":50,"invite":0,"historical":100},"depth":3,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672481741336,"hashes":{"sha256":"X4LJ+Oxr2lN6W4ZtQz4utHKB2jG2Cn1rJypn1xHHrhY"},"signatures":{"localhost":{"ed25519:a_CHdg":"TGAeSiuIR6wXk4ptoZJdyYysfB4iSnOtF6Ra/3tEnzB2cgWty2mdFpq4HkYogQ1p4ixkxhBpxdn8avZEOExtAA"}},"unsigned":{"age_ts":1672481741336}}	3
$0gszMJtyESzwVMh4olwTajdbj1MrrJYVnylO0yOIpSg	!nPrdOOfNMRrmJedabn:localhost	{"token_id":17,"historical":false}	{"auth_events":["$AMnH95Ky85GttLR7j9XHrHyULlBBezFJ9w8mtji-7Ok","$A5h106ytjQ2qqPxkSylhOkJgVZQCscB4QX0PK60qxU0","$gDW6j_UqhvIRf1ANEKurSD9fB4Hl4YnQ5uL9cy_U7Os"],"prev_events":["$gDW6j_UqhvIRf1ANEKurSD9fB4Hl4YnQ5uL9cy_U7Os"],"type":"m.room.join_rules","room_id":"!nPrdOOfNMRrmJedabn:localhost","sender":"@admin:localhost","content":{"join_rule":"invite"},"depth":4,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672481741707,"hashes":{"sha256":"gOemNDMGShUngd4y6d2Yrb8ckoT63Kmx/zLrRroK3xE"},"signatures":{"localhost":{"ed25519:a_CHdg":"oqeB+YEvEzIvN4tqqwHzLwObUd6FRWb55E+0kR5yr0oaVz1CH+3Wqy2awVyZAjh4H+wZnluUEMZ1EgztEcEJDg"}},"unsigned":{"age_ts":1672481741707}}	3
$WsVhQvsUsrFormgSdFA_Z_Io7y9fxZy5juqaM8oYpkg	!LwtGEdNVvQHvFLuWQB:localhost	{"token_id":19,"historical":false}	{"auth_events":["$TbFvVskFwRsxEgjNnOjfs4ljMJuZC60_Cqb91vOUrxg","$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q","$O-kcGXcFLVtSNAY7CxqW4hLVBk0UqhADtIs1kCz8hlA","$PTHh0FcsZLrplrmwtCyvLjXr1yAZRgovFGLVt7qrrAo"],"prev_events":["$O-kcGXcFLVtSNAY7CxqW4hLVBk0UqhADtIs1kCz8hlA"],"type":"m.room.member","room_id":"!LwtGEdNVvQHvFLuWQB:localhost","sender":"@admin:localhost","content":{"membership":"join","displayname":"admin"},"depth":12,"prev_state":[],"state_key":"@admin:localhost","origin":"localhost","origin_server_ts":1672482445688,"hashes":{"sha256":"taP8/iirhGL//REAc310UVbnAIMiPGdZmFlpJauNOZ4"},"signatures":{"localhost":{"ed25519:a_CHdg":"l6YMDAgvYo+e2E6afguZpEEDKBy8Nw6FJeyUlmlYuYvZSHdjlYRjBE/BpgbaQISHR29IQuDF9H4Hk2lvOsNCDw"}},"unsigned":{"age_ts":1672482445688,"replaces_state":"$TbFvVskFwRsxEgjNnOjfs4ljMJuZC60_Cqb91vOUrxg"}}	3
$2lEnFzGdtIu4kGthBBXcP0gW6sUWKP8c1x9I4-yFWso	!nPrdOOfNMRrmJedabn:localhost	{"token_id":17,"historical":false}	{"auth_events":["$AMnH95Ky85GttLR7j9XHrHyULlBBezFJ9w8mtji-7Ok","$A5h106ytjQ2qqPxkSylhOkJgVZQCscB4QX0PK60qxU0","$gDW6j_UqhvIRf1ANEKurSD9fB4Hl4YnQ5uL9cy_U7Os"],"prev_events":["$0gszMJtyESzwVMh4olwTajdbj1MrrJYVnylO0yOIpSg"],"type":"m.room.history_visibility","room_id":"!nPrdOOfNMRrmJedabn:localhost","sender":"@admin:localhost","content":{"history_visibility":"shared"},"depth":5,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672481741832,"hashes":{"sha256":"ZdkFnKU71VODqKp3+YToUu4OFvXFRpI7UvJXxX/4h+I"},"signatures":{"localhost":{"ed25519:a_CHdg":"KsknFXfJZxKOdoYOYWBW0Sc1FtGHZZ60jzCwQwa4ipiXbC/vkRu1mdOJusMi/UNs6tgOYdOgVTIFNGYFtbg3Dg"}},"unsigned":{"age_ts":1672481741832}}	3
$yfuDQBYjEI6CCa3AdtfdjL_ZXIR0d92TRfHnh7Gq0zc	!nPrdOOfNMRrmJedabn:localhost	{"token_id":17,"historical":false}	{"auth_events":["$AMnH95Ky85GttLR7j9XHrHyULlBBezFJ9w8mtji-7Ok","$A5h106ytjQ2qqPxkSylhOkJgVZQCscB4QX0PK60qxU0","$gDW6j_UqhvIRf1ANEKurSD9fB4Hl4YnQ5uL9cy_U7Os"],"prev_events":["$2lEnFzGdtIu4kGthBBXcP0gW6sUWKP8c1x9I4-yFWso"],"type":"m.room.guest_access","room_id":"!nPrdOOfNMRrmJedabn:localhost","sender":"@admin:localhost","content":{"guest_access":"can_join"},"depth":6,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672481741952,"hashes":{"sha256":"UnuxaFNZPpXzh3z7AqhsZXX87ArvgPDmHPVKMGYmCq0"},"signatures":{"localhost":{"ed25519:a_CHdg":"MOOfKJstGTRVzajIccozggwDHg0DHcBQ+mLagHopWHIqKi4PfEUfxITFXcrqlU412PAxzwdU/qdyl2InVbRQDw"}},"unsigned":{"age_ts":1672481741952}}	3
$MT4EKTmcPC8LCVeATiG-5a71N2Zc1vNQcgKge5W0on8	!MrxfbdodytWwBMqNiF:localhost	{"token_id":17,"historical":false}	{"auth_events":["$Pem9TyngNuhpIq_NI2krx6wpkVigoBj6JCeB3WUezVk","$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY","$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA"],"prev_events":["$viSFX8RvY5fe8TiOaDirNG6PqooEHTTV3PT3hrQgVLA"],"type":"m.room.tombstone","room_id":"!MrxfbdodytWwBMqNiF:localhost","sender":"@admin:localhost","content":{"body":"This room has been replaced","replacement_room":"!nPrdOOfNMRrmJedabn:localhost"},"depth":12,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672481741034,"hashes":{"sha256":"vGNl9mlccUjobmvXc/UfU5gLBufF7IKXEhXcb7sP+dQ"},"signatures":{"localhost":{"ed25519:a_CHdg":"Ad9Er4dZXwK6bqAK+CxncfB7QkH4SoVU+7adS/u6x7Lgp3mrWXhAW4EGi1+5YRyVyMbqbeNJzWMNibC7wTq1AQ"}},"unsigned":{"age_ts":1672481741034}}	3
$xyV3lysb-dda01bB4LpALdmaTC_mLZDhwxOE9L4zpXY	!nPrdOOfNMRrmJedabn:localhost	{"token_id":17,"historical":false}	{"auth_events":["$AMnH95Ky85GttLR7j9XHrHyULlBBezFJ9w8mtji-7Ok","$A5h106ytjQ2qqPxkSylhOkJgVZQCscB4QX0PK60qxU0","$gDW6j_UqhvIRf1ANEKurSD9fB4Hl4YnQ5uL9cy_U7Os"],"prev_events":["$yfuDQBYjEI6CCa3AdtfdjL_ZXIR0d92TRfHnh7Gq0zc"],"type":"m.room.encryption","room_id":"!nPrdOOfNMRrmJedabn:localhost","sender":"@admin:localhost","content":{"algorithm":"m.megolm.v1.aes-sha2"},"depth":7,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672481742097,"hashes":{"sha256":"Pfi+SKbzEbUH7wxQ18LVt5H1tB9LUJy+pN4vZOPlcdQ"},"signatures":{"localhost":{"ed25519:a_CHdg":"QkM/Ybuuen8hEe4qDMShPe2ZCc9g84I4jKE6jjL22dggHxdkYOGLGZTSvEeM2yCtjAW5Cp1aywJdIDno6Fq3CQ"}},"unsigned":{"age_ts":1672481742097}}	3
$eOC3-FZNb3jb3NisHG61gQhQ_hf9zWu0xvpfs8ZKDTg	!MrxfbdodytWwBMqNiF:localhost	{"token_id":17,"historical":false}	{"auth_events":["$Pem9TyngNuhpIq_NI2krx6wpkVigoBj6JCeB3WUezVk","$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY","$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA"],"prev_events":["$MT4EKTmcPC8LCVeATiG-5a71N2Zc1vNQcgKge5W0on8"],"type":"m.room.power_levels","room_id":"!MrxfbdodytWwBMqNiF:localhost","sender":"@admin:localhost","content":{"users":{"@bridgeuser1:localhost":100,"@admin:localhost":100},"users_default":0,"events":{"m.room.name":50,"m.room.power_levels":100,"m.room.history_visibility":100,"m.room.canonical_alias":50,"m.room.avatar":50,"m.room.tombstone":100,"m.room.server_acl":100,"m.room.encryption":100},"events_default":50,"state_default":50,"ban":50,"kick":50,"redact":50,"invite":50,"historical":100},"depth":13,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1672481742376,"hashes":{"sha256":"yg+jEUBPT+6DupRr90TfhcSOeVlmREI909IqaOfITgo"},"signatures":{"localhost":{"ed25519:a_CHdg":"lBvN1OZLyx763Or21Talg7AfrUlHr/N3mm6LdNQ+4QMcTl7yQi//FPWPmntpssp9Pqxft5d8i2Fvfs0xWwltBg"}},"unsigned":{"age_ts":1672481742376,"replaces_state":"$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA"}}	3
$usag8slAxKA2dWWERksMiBQ8hRwfGZ8nZzTfcymZxyE	!nPrdOOfNMRrmJedabn:localhost	{"token_id":17,"historical":false}	{"auth_events":["$AMnH95Ky85GttLR7j9XHrHyULlBBezFJ9w8mtji-7Ok","$gDW6j_UqhvIRf1ANEKurSD9fB4Hl4YnQ5uL9cy_U7Os","$A5h106ytjQ2qqPxkSylhOkJgVZQCscB4QX0PK60qxU0","$0gszMJtyESzwVMh4olwTajdbj1MrrJYVnylO0yOIpSg"],"prev_events":["$xyV3lysb-dda01bB4LpALdmaTC_mLZDhwxOE9L4zpXY"],"type":"m.room.member","room_id":"!nPrdOOfNMRrmJedabn:localhost","sender":"@admin:localhost","content":{"membership":"invite","displayname":"bridgeuser1"},"depth":8,"prev_state":[],"state_key":"@bridgeuser1:localhost","origin":"localhost","origin_server_ts":1672481742932,"hashes":{"sha256":"gc5QeIRPbAUTNk8nD5LM1ee8yju9/nfS/hCp4Q2srH0"},"signatures":{"localhost":{"ed25519:a_CHdg":"6b0zW+5/o/mttmvZONM2qDIOGKBdgAPYEC2I/QC+IylN6B4IZCSbskDRfpfsvi+maksIrW8yMqGqghDmkiHBCg"}},"unsigned":{"age_ts":1672481742932,"invite_room_state":[{"type":"m.room.create","state_key":"","content":{"room_version":"9","predecessor":{"room_id":"!MrxfbdodytWwBMqNiF:localhost","event_id":"$MT4EKTmcPC8LCVeATiG-5a71N2Zc1vNQcgKge5W0on8"},"creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"invite"},"sender":"@admin:localhost"},{"type":"m.room.encryption","state_key":"","content":{"algorithm":"m.megolm.v1.aes-sha2"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@admin:localhost","content":{"membership":"join","displayname":"admin"},"sender":"@admin:localhost"}]}}	3
$O04OV5x9R_5W2IT9G9Z-dXJmfV6fgtZM8-4ogFp9rEw	!dKcbdDATuwwphjRPQP:localhost	{"token_id":18,"historical":false}	{"auth_events":["$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs"],"prev_events":["$NxuVtjeVql0_aadDlNux0yeeR_PxcpcJPnX1SdoDmXM"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@admin:localhost","content":{"membership":"invite","displayname":"bridgeadmin"},"depth":25,"prev_state":[],"state_key":"@bridgeadmin:localhost","origin":"localhost","origin_server_ts":1672481823109,"hashes":{"sha256":"+HfxfHgIu8pVESbfYTtMAkbt9p8nSvsagDWJnepUJag"},"signatures":{"localhost":{"ed25519:a_CHdg":"+amkMp5KZPZu6wrgEelkqmgTnIP0MxLeYmbwBAqd9w0gytKKbZdtXGiAaAdv/nBmHsiKxV8Sgx+wztYwkjN9Aw"}},"unsigned":{"age_ts":1672481823109,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#off-topic:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@admin:localhost","content":{"membership":"join","displayname":"admin"},"sender":"@admin:localhost"}]}}	3
$-QMfwsu75_SWJtzFqIsrFjLgl_XBqF6HcorcUjLTsWY	!dKcbdDATuwwphjRPQP:localhost	{"token_id":18,"historical":false}	{"auth_events":["$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs"],"prev_events":["$O04OV5x9R_5W2IT9G9Z-dXJmfV6fgtZM8-4ogFp9rEw"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@admin:localhost","content":{"membership":"invite","displayname":"bridgeuser1"},"depth":26,"prev_state":[],"state_key":"@bridgeuser1:localhost","origin":"localhost","origin_server_ts":1672481842114,"hashes":{"sha256":"HOpA1UBkmWZu8CNHS+anFDTF/yvBUwFFWEoLf5mjFyU"},"signatures":{"localhost":{"ed25519:a_CHdg":"wHy1yAtAvNFvQSC9IOvjKVTqtO6yJeuLipSig+w2p54B0zlxKeaBZZ6/qK4Rt3+EharFRz8hLttLF+atpFHDCw"}},"unsigned":{"age_ts":1672481842114,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#off-topic:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@admin:localhost","content":{"membership":"join","displayname":"admin"},"sender":"@admin:localhost"}]}}	3
$r8P3KtaOOCBm8XKydsvp0N-cG5BAE1YKU5MumKzWUI8	!GNlLBsLXjbOuNhCkEO:localhost	{"token_id":19,"txn_id":"m1672482470989.0","historical":false}	{"auth_events":["$nfronhC7iKGPRmKJ7zoXzYG7VKiOq5FoUIcfHg3a4Dg","$_-6CgruWK6UfiL1rgJnNUgtmp_jusf_3Vf7LUPB6xaU","$uKKFUGwf_IAnbH81DTvAScd2HFnAwWWL_p4-E5B_YdU"],"prev_events":["$nfronhC7iKGPRmKJ7zoXzYG7VKiOq5FoUIcfHg3a4Dg"],"type":"m.room.encrypted","room_id":"!GNlLBsLXjbOuNhCkEO:localhost","sender":"@admin:localhost","content":{"algorithm":"m.megolm.v1.aes-sha2","sender_key":"kfPxugb68IBINc5Gvg/Kt7mKyqCdJShv6dvzntCYRlQ","ciphertext":"AwgAEpABhjMZDvsuux8Zk0aac7FmfdV5YDhsxrhaE1rMAGssAmOeyV50XKIMdxu2ue4XNZwzqaYKbmZu2rY28lMpj2ccgcaUWYy8mB3j3ZM2zhu7RMIl571OpyrTJ+/aSNaEoEcECDkVMzAgvcUP6Qh1OjSqsf2Itf2aAi6asARMYT2HePcsoQfXIIPVqs6Id+q0uO/UQkfffMsu2QBxJLClNLfczBuN4pz5TTGG014/a2P0LtuTJxjPzUdJPvPmgpip86o1zXELnx/0VY0mLyLEF96AyX4PKubVX7AM","session_id":"BZB1YjM1PpvNt9iZVjgghs74vcycGbv9/G8t2IPRp8E","device_id":"XEZPTSZEHL"},"depth":10,"prev_state":[],"origin":"localhost","origin_server_ts":1672482471146,"hashes":{"sha256":"XezBXkEBTp7wWF5NxqZPYA5sbDfyy2N+qC4SSDZmico"},"signatures":{"localhost":{"ed25519:a_CHdg":"LiaATIpraFtYLIXsEbN5eaolgbukf9mSFV/AUQ7Rw2VpK0UqjoLpSPgDQlS+4ZnNasIFz6hcT407MyHDQ6swDg"}},"unsigned":{"age_ts":1672482471146}}	3
$kwgJJLzgJAXgzd-lj8uFVnrjX5yqfNOtOcPrcl87hXU	!UKcoTBWWxNEyixrjyM:localhost	{"token_id":20,"txn_id":"m1672482641001.2","historical":false}	{"auth_events":["$hooKnajA7nQRs3MZDj_evGyHCyHpg4QmGp2i5WRKzp0","$yZwQJfxjuLFOlfyTYw-M1aupZjmck-aVfpfSYx5fj1I","$EsIKBNaGky9gjqListPEKjQfFScHFrG5GuEQD0vyi9Q"],"prev_events":["$hooKnajA7nQRs3MZDj_evGyHCyHpg4QmGp2i5WRKzp0"],"type":"m.room.message","room_id":"!UKcoTBWWxNEyixrjyM:localhost","sender":"@matrix_a:localhost","content":{"org.matrix.msc1767.text":"OK","body":"OK","msgtype":"m.text"},"depth":10,"prev_state":[],"origin":"localhost","origin_server_ts":1672482641095,"hashes":{"sha256":"71lJ/7T0V5TXlrYmbu++pWohkfZ16y1FK0ohDYkGPwE"},"signatures":{"localhost":{"ed25519:a_CHdg":"zCVG3MugzbI2+cfvC9LWDTFOosLaQaZl1ZZv2WTbAapvNrmUgFdI97/w/NVlmpoAbfjeRmtGQ0bgeUCyZPh4Ag"}},"unsigned":{"age_ts":1672482641095}}	3
$Wj4b7gcXdhL474sxg5O6Kh7tBw4O5BtHv_KJEd3KXfM	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":18,"txn_id":"m1672481890833.0","historical":false}	{"auth_events":["$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$opS4sT6APXaq4vDdegPq6ik1z-yX-FkMTAqhGtTWXEE"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@admin:localhost","content":{"org.matrix.msc1767.text":"Hej all","body":"Hej all","msgtype":"m.text"},"depth":25,"prev_state":[],"origin":"localhost","origin_server_ts":1672481890977,"hashes":{"sha256":"h/Ir3Jm/88cLBPKZFp4jvOmqaCDL3H3IB9YNn04WXZY"},"signatures":{"localhost":{"ed25519:a_CHdg":"9HSdurSFCVJ/oZR9X4H6GbjgAfWMmNUGNkzffn3k0bR1SvBZtUUAgGY9s7bwK0/bObN1bpslN8LF1lVC+IAWDg"}},"unsigned":{"age_ts":1672481890977}}	3
$p0-tc7QWKDmREIJlluolf1RQ-uKnVDhx5d_JQY9PX5E	!dKcbdDATuwwphjRPQP:localhost	{"token_id":20,"txn_id":"m1672482552567.0","historical":false}	{"auth_events":["$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$-QMfwsu75_SWJtzFqIsrFjLgl_XBqF6HcorcUjLTsWY"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"org.matrix.msc1767.text":"I am here","body":"I am here","msgtype":"m.text"},"depth":27,"prev_state":[],"origin":"localhost","origin_server_ts":1672482552664,"hashes":{"sha256":"AM7kWUZDkshsugjbVgB4cnZzwb6WMtacK1rMKKU5y9k"},"signatures":{"localhost":{"ed25519:a_CHdg":"Z4vw927/J3xvoSdsya8n0rK7rdW/tMjSmceatvZ7G6EJTCOcXts6x4nehSfspGj93LRWdpBJK1cOUhBYe4A5CQ"}},"unsigned":{"age_ts":1672482552664}}	3
$hooKnajA7nQRs3MZDj_evGyHCyHpg4QmGp2i5WRKzp0	!UKcoTBWWxNEyixrjyM:localhost	{"token_id":20,"historical":false}	{"auth_events":["$sdrkpiq94MhqjrSukg-aexI_3VlPxcoqiZXmrPvpQGw","$yZwQJfxjuLFOlfyTYw-M1aupZjmck-aVfpfSYx5fj1I","$EsIKBNaGky9gjqListPEKjQfFScHFrG5GuEQD0vyi9Q","$STt_lRcQQY1HR2YQmv4RsQMis1Xc5sWAamnHn02ddqk"],"prev_events":["$-JWBJJpXpVo-YhtBYaJDTakzo94Jhn_XGlhnLzEWxyc"],"type":"m.room.member","room_id":"!UKcoTBWWxNEyixrjyM:localhost","sender":"@matrix_a:localhost","content":{"membership":"join","displayname":"matrix_a"},"depth":9,"prev_state":[],"state_key":"@matrix_a:localhost","origin":"localhost","origin_server_ts":1672482632371,"hashes":{"sha256":"aegz19INnMTUf7BTnLE+q6hUz3Vi3GNCV/4INBhn1Dw"},"signatures":{"localhost":{"ed25519:a_CHdg":"gjDqcTWoaYlJONlAPDiyK6k8ZN1O2I26uJjB5CglOrZQPP6fGrny9eCwAP6qcdKk1zXDIhVYXQ5QoGCbbd/pDA"}},"unsigned":{"age_ts":1672482632371,"replaces_state":"$sdrkpiq94MhqjrSukg-aexI_3VlPxcoqiZXmrPvpQGw"}}	3
$ZYEqhm3M07nXRAh1U842uZ1squBm9wa5H1Wb2-LjE1c	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":18,"txn_id":"m1672481947068.1","historical":false}	{"auth_events":["$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$Wj4b7gcXdhL474sxg5O6Kh7tBw4O5BtHv_KJEd3KXfM"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@admin:localhost","content":{"org.matrix.msc1767.text":"Nu \\u00e4r vi ig\\u00e5ng","body":"Nu \\u00e4r vi ig\\u00e5ng","msgtype":"m.text"},"depth":26,"prev_state":[],"origin":"localhost","origin_server_ts":1672481947141,"hashes":{"sha256":"GjvNapZCq7LwvAh9u0ElmVBX//7BjKJwREsInvL+YGM"},"signatures":{"localhost":{"ed25519:a_CHdg":"dSYhnNwEI9URKE9NxZ/mPCP/BDHHUrQUbADDwe5gyu74wb12OX3KN4ZjzFNSq0xbx/OD04GfqOKcDv/7et4MBw"}},"unsigned":{"age_ts":1672481947141}}	3
$GmUIImAeTzvNSV5qvb40ScXGL3dlsX4DDnmg28rkzk4	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":20,"txn_id":"m1672482578492.1","historical":false}	{"auth_events":["$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$ZYEqhm3M07nXRAh1U842uZ1squBm9wa5H1Wb2-LjE1c"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_a:localhost","content":{"org.matrix.msc1767.text":"Yes","body":"Yes","msgtype":"m.text"},"depth":27,"prev_state":[],"origin":"localhost","origin_server_ts":1672482578574,"hashes":{"sha256":"ThHDFS6SX+4EB2QFim1Fa8nlXtaxuIyU2Atc3eTwqu4"},"signatures":{"localhost":{"ed25519:a_CHdg":"B6Gm2k7u68JALbMPKXzZURtLDuQCDq5jHKGRsJ2eL/Zvu6+E5VRYNJoST/R8wGYgUkzJ316QwKJAgi9sNE7TCQ"}},"unsigned":{"age_ts":1672482578574}}	3
$rNG4YvsFCU9LVcVcHEkbBRGSuEH_QqO_hMEZ-sC8WH8	!kAToIwhNWrDpgQVMfY:localhost	{"token_id":20,"historical":false}	{"auth_events":["$bFxX1nACgPihIeXfSiWHmW_hxrfmIgtQM9HWAPS2wVY","$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw","$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc","$KGv2op0D-6TOpQuqb5Gl4YZxMUKn37cUNSylMiEo7SA"],"prev_events":["$kL3ALUeGobajxL55gzYoIZLdD1CSD4sYXedIOysHwV0"],"type":"m.room.member","room_id":"!kAToIwhNWrDpgQVMfY:localhost","sender":"@matrix_a:localhost","content":{"membership":"join","displayname":"matrix_a"},"depth":13,"prev_state":[],"state_key":"@matrix_a:localhost","origin":"localhost","origin_server_ts":1672482657800,"hashes":{"sha256":"kP1+anR3bRU8MECxZ6NcSuzklDWXUsVYJIeXNbHM1ek"},"signatures":{"localhost":{"ed25519:a_CHdg":"bu+Zbkkf1ceXNr6ohMS9NpTQpJYEAYAYhSZuiGo0TQwblGtJxBxnc39k+Rv2eDyIF1KqlFLQY09SAA6ENU3bBQ"}},"unsigned":{"age_ts":1672482657800,"replaces_state":"$bFxX1nACgPihIeXfSiWHmW_hxrfmIgtQM9HWAPS2wVY"}}	3
\.


--
-- Data for Name: event_labels; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_labels (event_id, label, room_id, topological_ordering) FROM stdin;
\.


--
-- Data for Name: event_push_actions; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_push_actions (room_id, event_id, user_id, profile_tag, actions, topological_ordering, stream_ordering, notif, highlight, unread) FROM stdin;
!MrxfbdodytWwBMqNiF:localhost	$Fe89WlTUpNMZrgSmSzGQHSt495sI5DkA-kewln3Ug70	@bridgeuser1:localhost	\N	["notify",{"set_tweak":"sound","value":"default"},{"set_tweak":"highlight","value":false}]	10	117	1	0	1
!MrxfbdodytWwBMqNiF:localhost	$MT4EKTmcPC8LCVeATiG-5a71N2Zc1vNQcgKge5W0on8	@bridgeuser1:localhost	\N	[]	12	126	0	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$Wj4b7gcXdhL474sxg5O6Kh7tBw4O5BtHv_KJEd3KXfM	@matrix_b:localhost	\N		25	131	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$Wj4b7gcXdhL474sxg5O6Kh7tBw4O5BtHv_KJEd3KXfM	@matterbot:localhost	\N		25	131	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$Wj4b7gcXdhL474sxg5O6Kh7tBw4O5BtHv_KJEd3KXfM	@ignored_user:localhost	\N		25	131	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$ZYEqhm3M07nXRAh1U842uZ1squBm9wa5H1Wb2-LjE1c	@matrix_b:localhost	\N		26	132	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$ZYEqhm3M07nXRAh1U842uZ1squBm9wa5H1Wb2-LjE1c	@matterbot:localhost	\N		26	132	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$ZYEqhm3M07nXRAh1U842uZ1squBm9wa5H1Wb2-LjE1c	@ignored_user:localhost	\N		26	132	1	0	1
!GNlLBsLXjbOuNhCkEO:localhost	$r8P3KtaOOCBm8XKydsvp0N-cG5BAE1YKU5MumKzWUI8	@bridgeadmin:localhost	\N	["notify",{"set_tweak":"sound","value":"default"},{"set_tweak":"highlight","value":false}]	10	134	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$p0-tc7QWKDmREIJlluolf1RQ-uKnVDhx5d_JQY9PX5E	@admin:localhost	\N		27	135	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$p0-tc7QWKDmREIJlluolf1RQ-uKnVDhx5d_JQY9PX5E	@matterbot:localhost	\N		27	135	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$p0-tc7QWKDmREIJlluolf1RQ-uKnVDhx5d_JQY9PX5E	@matrix_b:localhost	\N		27	135	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$p0-tc7QWKDmREIJlluolf1RQ-uKnVDhx5d_JQY9PX5E	@ignored_user:localhost	\N		27	135	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$GmUIImAeTzvNSV5qvb40ScXGL3dlsX4DDnmg28rkzk4	@matrix_b:localhost	\N		27	136	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$GmUIImAeTzvNSV5qvb40ScXGL3dlsX4DDnmg28rkzk4	@matterbot:localhost	\N		27	136	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$GmUIImAeTzvNSV5qvb40ScXGL3dlsX4DDnmg28rkzk4	@ignored_user:localhost	\N		27	136	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$GmUIImAeTzvNSV5qvb40ScXGL3dlsX4DDnmg28rkzk4	@admin:localhost	\N		27	136	1	0	1
!UKcoTBWWxNEyixrjyM:localhost	$kwgJJLzgJAXgzd-lj8uFVnrjX5yqfNOtOcPrcl87hXU	@bridgeuser1:localhost	\N	["notify",{"set_tweak":"sound","value":"default"},{"set_tweak":"highlight","value":false}]	10	138	1	0	1
\.


--
-- Data for Name: event_push_actions_staging; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_push_actions_staging (event_id, user_id, actions, notif, highlight, unread) FROM stdin;
\.


--
-- Data for Name: event_push_summary; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_push_summary (user_id, room_id, notif_count, stream_ordering, unread_count) FROM stdin;
\.


--
-- Data for Name: event_push_summary_stream_ordering; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_push_summary_stream_ordering (lock, stream_ordering) FROM stdin;
X	30
\.


--
-- Data for Name: event_reference_hashes; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_reference_hashes (event_id, algorithm, hash) FROM stdin;
$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	sha256	\\x981991cb2bcffc973e2c38bbfe18860fd413bb95c6557a8d33164ce320cc40f5
$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw	sha256	\\xfe829a68e7cbeeb16d3ec02cc43987ac263db00cc58ec951c2427f407c470d3c
$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	sha256	\\x058c9508fc8987d3d5241b310f09bd35a906635f43942249d46942718a53bfcc
$X8tdoEsXAgBC6gobCepAn3rwO8CJoQU6i9NN9Rzhukg	sha256	\\x5fcb5da04b17020042ea0a1b09ea409f7af03bc089a1053a8bd34df51ce1ba48
$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	sha256	\\x1bf9b9f408c7d98d455f80f5d490ec9841137c71805a89274c876ffbf5d85b6a
$O5iO4EII22igkDq5cMKHFB-SGIYD0KqJQXZohS2Dzc0	sha256	\\x3b988ee04208db68a0903ab970c287141f92188603d0aa89417668852d83cdcd
$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	sha256	\\x45cce7e46789d5a60c054fe85d2205f29a5593c584aee698201037144ed8abcf
$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA	sha256	\\x3de009e81ca95e325e8078948dc61ef88e827f836e08f2028bfc946fe7f26ae0
$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	sha256	\\x3fdf2fa6d23f8eb35828a9d34c3628b93860a21807a89903e51723d200e0c482
$b__a7rX3L5YpX7nAZte73DAbjtXZK48JH8VKSnGOKKw	sha256	\\x6fffdaeeb5f72f96295fb9c066d7bbdc301b8ed5d92b8f091fc54a4a718e28ac
$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	sha256	\\x844b65b74354d7a8748b1f71057d0c0c9474839e004c46784bdeae758cd806ab
$TVnvv0nGbLydCBtMmTTz-htMsoI4hmxCr3s9AHyFGHQ	sha256	\\x4d59efbf49c66cbc9d081b4c9934f3fa1b4cb28238866c42af7b3d007c851874
$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8	sha256	\\x377dc6c8e369b926b7cd13499350ad2d8761a896e15c1c12a40954526fb3981f
$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0	sha256	\\xc1dfb306c395f4affc1db84f01167dd647f971f6702ca462ef204118635401bd
$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk	sha256	\\x9650ad37eb1f542d4839d0d05e0b24831e2397dee14077ca9c41fe20ffa5caf9
$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0	sha256	\\xe192dffb725124c2cb0036f3a267b69ffe6b64d11e1c4148a37c35c4de0a2aed
$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	sha256	\\x843d99f811e44ac70e4e27ed7097b59fea5e388b228509506edca34762244e60
$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A	sha256	\\x4af7fdd6dc86c94bb37a5607f1b6f333a417b88f5771a6fe5cc5e30ab2203390
$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok	sha256	\\x19a77cdbc2f695b6e268022f9beea2eab54b2ea86d27d5654c07be0599aa3289
$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ	sha256	\\x2314e7f74feb08d920b798b5d482fc067672d84b0ee81e183bd231b773353944
$7TwPfUMTevEcf7wLvbgx3LG01lYT_yGudYiOVlkGU7E	sha256	\\xed3c0f7d43137af11c7fbc0bbdb831dcb1b4d65613ff21ae75888e56590653b1
$jAifmicJfMyB1QPFQ6KFQ7ZqTqQ58RJXsH5viWn3ZUg	sha256	\\x8c089f9a27097ccc81d503c543a28543b66a4ea439f11257b07e6f8969f76548
$DsZXxk2rEIB2tF3pYUdOPjrMwclo8BXltutiWCnKUIU	sha256	\\x0ec657c64dab108076b45de961474e3e3accc1c968f015e5b6eb625829ca5085
$NyVGoA-ZaMPbk_RzpmLOajRS1nEBirO7Du2KpA9Eo64	sha256	\\x372546a00f9968c3db93f473a662ce6a3452d671018ab3bb0eed8aa40f44a3ae
$JwL8EK5sa4vg29tclnHwa5jrpCTa8oZVOIsgFyivQdY	sha256	\\x2702fc10ae6c6b8be0dbdb5c9671f06b98eba424daf28655388b201728af41d6
$JcoTJcBGASUqIK9V7j6ND5Jt6P9gdbNJxXxQBZNg8z4	sha256	\\x25ca1325c04601252a20af55ee3e8d0f926de8ff6075b349c57c50059360f33e
$2KnXfE3sZw8LDrOAaEP4HdQuw5neshhvyZKtnwo5cg0	sha256	\\xd8a9d77c4dec670f0b0eb3806843f81dd42ec399deb2186fc992ad9f0a39720d
$isXWKf_B_7Z7R7jYn_2gZB-U31TuzMehBRxj5701Lq8	sha256	\\x8ac5d629ffc1ffb67b47b8d89ffda0641f94df54eeccc7a1051c63e7bd352eaf
$rVK77mVSpz5EHxI2mbLxilqbkLxKhXEiusPFjapVPbw	sha256	\\xad52bbee6552a73e441f123699b2f18a5a9b90bc4a857122bac3c58daa553dbc
$5agO4kI6VqJHGKvKbkqUa2Y3cTwUBrjAhmCVtj9JmKU	sha256	\\xe5a80ee2423a56a24718abca6e4a946b6637713c1406b8c0866095b63f4998a5
$4JiNeQHyMbyuEfymLkE-SEzPUh3bWddjxa6-5w36nJw	sha256	\\xe0988d7901f231bcae11fca62e413e484ccf521ddb59d763c5aebee70dfa9c9c
$Y_S-fF0iLu0OHNMcZdYVzt0we_qL_t8_4QIKGeobLdI	sha256	\\x63f4be7c5d222eed0e1cd31c65d615cedd307bfa8bfedf3fe1020a19ea1b2dd2
$g1kV-jEZBtN9l6VGGo2MN-wQn7RR7J-Tv5LfyJ5Z5fc	sha256	\\x835915fa311906d37d97a5461a8d8c37ec109fb451ec9f93bf92dfc89e59e5f7
$CQg_jKvdpWFvaiLH2f5MtTnu1Zwxi8P4QPSJZum91dw	sha256	\\x09083f8cabdda5616f6a22c7d9fe4cb539eed59c318bc3f840f48966e9bdd5dc
$OcvCF7YNeTKFnzz4EWVjFJIF9QidMEUmomHIvH3d2W8	sha256	\\x39cbc217b60d7932859f3cf8116563149205f5089d304526a261c8bc7dddd96f
$GrqoJ52XSgRaoc4wPEYLdL2p6t3jl0aiFd8bYswQQcU	sha256	\\x1abaa8279d974a045aa1ce303c460b74bda9eadde39746a215df1b62cc1041c5
$5TE1hAtSTolrY9QTj9Wt8DnKurFa3P6KIfGkWOJbrY4	sha256	\\xe53135840b524e896b63d4138fd5adf039cabab15adcfe8a21f1a458e25bad8e
$UYXKiTPqFr31PwoZzi35ODpdRK0hwJVjVGC1N7kR7yk	sha256	\\x5185ca8933ea16bdf53f0a19ce2df9383a5d44ad21c095635460b537b911ef29
$YFCWkh6b_jgrSjje7vt6JB6-uLPRz7Na1VgGh0PwdI8	sha256	\\x605096921e9bfe382b4a38deeefb7a241ebeb8b3d1cfb35ad558068743f0748f
$h2yGPxzdKWUBUSFQiOgFiRoNa8NgWHYXdy_2SMJx6ns	sha256	\\x876c863f1cdd29650151215088e805891a0d6bc360587617772ff648c271ea7b
$kmvnPONhcKxIpG62sV6apngYToshpP0mBrwpKL0hAOI	sha256	\\x926be73ce36170ac48a46eb6b15e9aa678184e8b21a4fd2606bc2928bd2100e2
$KgpvpFIMQIVFvm0adBZqAbWANmMgdu1_1jbP71RuM48	sha256	\\x2a0a6fa4520c408545be6d1a74166a01b58036632076ed7fd636cfef546e338f
$qWi32T1tK2APgSwc4y_6f0e_N_fUPmIBxC5ACk1h6NM	sha256	\\xa968b7d93d6d2b600f812c1ce32ffa7f47bf37f7d43e6201c42e400a4d61e8d3
$jvwVmkElpx8M62JlaBz7nJ4qa2U8tVO7V9-HhJ-n8JI	sha256	\\x8efc159a4125a71f0ceb6265681cfb9c9e2a6b653cb553bb57df87849fa7f092
$0WsTO-QKZzqtMdl5UwGJc5h4e7YAE5ZGp_GDMb9K824	sha256	\\xd16b133be40a673aad31d9795301897398787bb600139646a7f18331bf4af36e
$l5dYt-R2kpcKdlmMRFnzC5N9PjiV4DZ63c1bTGPOCXk	sha256	\\x979758b7e47692970a76598c4459f30b937d3e3895e0367addcd5b4c63ce0979
$opS4sT6APXaq4vDdegPq6ik1z-yX-FkMTAqhGtTWXEE	sha256	\\xa294b8b13e803d76aae2f0dd7a03eaea2935cfec97f8590c4c0aa11ad4d65c41
$NxuVtjeVql0_aadDlNux0yeeR_PxcpcJPnX1SdoDmXM	sha256	\\x371b95b63795aa5d3f69a74394dbb1d3279e47f3f17297093e75f549da039973
$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY	sha256	\\xcb43d7ebaee8e171e6cecb0aacba94a7199b7f9226e0cecae2361075121ac1f6
$89n67RlAmtb8nRuxie-oq3g9grnkpjzJMAhbJ8h_8Xw	sha256	\\xf3d9faed19409ad6fc9d1bb189efa8ab783d82b9e4a63cc930085b27c87ff17c
$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA	sha256	\\x92dcef80a75557690f8968fc9095c9132a0f1a2b47bc860e82539d91c3b3f160
$TVXtgqtZ5WfNfZEnJQx6m0NYwp0_34ylOK87XzZ3JlI	sha256	\\x4d55ed82ab59e567cd7d9127250c7a9b4358c29d3fdf8ca538af3b5f36772652
$JQ7PDbgzTTAY5uHFM6NV0ovadfzQLOpcAcrSX5mRUi0	sha256	\\x250ecf0db8334d3018e6e1c533a355d28bda75fcd02cea5c01cad25f9991522d
$9MVFB3q88VYxhDZMX087Uv4c3h3uEpluJN0q33ubtso	sha256	\\xf4c545077abcf1563184364c5f4f3b52fe1cde1dee12996e24dd2adf7b9bb6ca
$V_QrTFMCwHlrg-MSVVplcYCRVWM_QgXhIvp-2R_LtHI	sha256	\\x57f42b4c5302c0796b83e312555a6571809155633f4205e122fa7ed91fcbb472
$Nv-ymHeLYsZKVjdilAoBLGC4GlzNJWt1HBqtIlSIz1k	sha256	\\x36ffb298778b62c64a563762940a012c60b81a5ccd256b751c1aad225488cf59
$yZwQJfxjuLFOlfyTYw-M1aupZjmck-aVfpfSYx5fj1I	sha256	\\xc99c1025fc63b8b14e95fc93630f8cd5aba966399c93e6957e97d2631e5f8f52
$sqtTmHJJ_e6UeDKORkztLzcGXYNZpKgoa1v2ir5yr-w	sha256	\\xb2ab53987249fdee9478328e464ced2f37065d8359a4a8286b5bf68abe72afec
$EsIKBNaGky9gjqListPEKjQfFScHFrG5GuEQD0vyi9Q	sha256	\\x12c20a04d686932f608ea2e2b2d3c42a341f15270716b1b91ae1100f4bf28bd4
$STt_lRcQQY1HR2YQmv4RsQMis1Xc5sWAamnHn02ddqk	sha256	\\x493b7f951710418d474766109afe11b10322b355dce6c5806a69c79f4d9d76a9
$KEhwfKMs0OrXZWYNQWK_YDu-mrG-UP2Do2VsAShloEY	sha256	\\x2848707ca32cd0ead765660d4162bf603bbe9ab1be50fd83a3656c012865a046
$em_2PzgnditDYAzn8yY84PnmN1oNQZgI8Co6SjahtU8	sha256	\\x7a6ff63f3827762b43600ce7f3263ce0f9e6375a0d419808f02a3a4a36a1b54f
$sdrkpiq94MhqjrSukg-aexI_3VlPxcoqiZXmrPvpQGw	sha256	\\xb1dae4a62abde0c86a8eb4ae920f9a7b123fdd594fc5ca2a8995e6acfbe9406c
$-JWBJJpXpVo-YhtBYaJDTakzo94Jhn_XGlhnLzEWxyc	sha256	\\xf89581249a57a55a3e621b4161a2434da933a3de09867fd71a58672f3116c727
$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw	sha256	\\x13cf26935cdeea91a468393b9546d7a87c4a40c995917521a6341bd02cfe20ac
$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE	sha256	\\xae705c629722e0f6e2edffbff7f28a508e74a51fac81dcccd7add58cd131d221
$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc	sha256	\\xfb928fea79e3ba16b8a3908ef81052905e66c1e524edaf2e05c14b42c15d8d37
$fZAJc_jo3uwpjSNh7ULQOuzuMtHLVO8KdmygXkq-95M	sha256	\\x7d900973f8e8deec298d2361ed42d03aecee32d1cb54ef0a766ca05e4abef793
$KGv2op0D-6TOpQuqb5Gl4YZxMUKn37cUNSylMiEo7SA	sha256	\\x286bf6a29d03fba4cea50baa6f91a5e186713142a7dfb714352ca5322128ed20
$XvSaPVUaER3JwP1gLc-c__oVTIjGs5YL10o0DSsZ3q0	sha256	\\x5ef49a3d551a111dc9c0fd602dcf9cfffa154c88c6b3960bd74a340d2b19dead
$zHrY9OvLbZTtN0bNPCDJg1HsmkgSV-pzAmxVIqaSB98	sha256	\\xcc7ad8f4ebcb6d94ed3746cd3c20c98351ec9a481257ea73026c5522a69207df
$Np7HQ3SdNiYX3HhRJtJw4b80J96uY_IbqI_bL7w83m0	sha256	\\x369ec743749d362617dc785126d270e1bf3427deae63f21ba88fdb2fbc3cde6d
$nL-1meDVcMfCo41V5V5w3EBPwNdmll7Alfsp00QCHvk	sha256	\\x9cbfb599e0d570c7c2a38d55e55e70dc404fc0d766965ec095fb29d344021ef9
$81gCIX2tUwDG_Jg02kHVceEfsUG1IOQ9-YnDk1cV15w	sha256	\\xf35802217dad5300c6fc9834da41d571e11fb141b520e43df989c3935715d79c
$zxy8zKV-5WiZDQEOGVCLyrd2yGWyYrOah4vQYAlc-xI	sha256	\\xcf1cbccca57ee568990d010e19508bcab776c865b262b39a878bd060095cfb12
$tWJ40KRMdaZwn6df_597mz_AyHLHUSEy0noQk3HlctY	sha256	\\xb56278d0a44c75a6709fa75fff9f7b9b3fc0c872c7512132d27a109371e572d6
$ab5rFOQQuDGj00oHfJaJKURhG6lNFNDKS0nkBlsLTMk	sha256	\\x69be6b14e410b831a3d34a077c96892944611ba94d14d0ca4b49e4065b0b4cc9
$bFxX1nACgPihIeXfSiWHmW_hxrfmIgtQM9HWAPS2wVY	sha256	\\x6c5c57d6700280f8a121e5df4a2587996fe1c6b7e6220b5033d1d600f4b6c156
$kL3ALUeGobajxL55gzYoIZLdD1CSD4sYXedIOysHwV0	sha256	\\x90bdc02d4786a1b6a3c4be798336282192dd0f50920f8b185de7483b2b07c15d
$b_nOg7oeQd8bhYHe5kvgAdNM0U6hcAUFdf-yhgbItfc	sha256	\\x6ff9ce83ba1e41df1b8581dee64be001d34cd14ea170050575ffb28606c8b5f7
$AXgBEWEnQYL0m4F3qNGi4DDk7afIQe7a_hmRdZkAZLM	sha256	\\x0178011161274182f49b8177a8d1a2e030e4eda7c841eedafe199175990064b3
$wTlWqRh3eGNrru9CGqbzkNcL0kBGbtEB8sHZwsAboS0	sha256	\\xc13956a9187778636baeef421aa6f390d70bd240466ed101f2c1d9c2c01ba12d
$Jy6RZhO0nZ0x_EgWugfJHW0XgWaR5DoWVaImG_wE3lg	sha256	\\x272e916613b49d9d31fc4816ba07c91d6d17816691e43a1655a2261bfc04de58
$7CUacT0Q8hFhLt80ecyLwLrizW7Jh6uNtLYApZIgNg4	sha256	\\xec251a713d10f211612edf3479cc8bc0bae2cd6ec987ab8db4b600a59220360e
$41BPCZJ_9IbE7VgIqxEef1X7U2-FXJjTA25i2Q-n_gg	sha256	\\xe3504f09927ff486c4ed5808ab111e7f55fb536f855c98d3036e62d90fa7fe08
$pn5NPm28AfF5_169OnQQxTv4_ijcoN4k44UIvzGsN7k	sha256	\\xa67e4d3e6dbc01f179ff5ebd3a7410c53bf8fe28dca0de24e38508bf31ac37b9
$PJZugFD-K6RtTB0vNzX1j0YFLZ9x4vli99YpMY9dzQk	sha256	\\x3c966e8050fe2ba46d4c1d2f3735f58f46052d9f71e2f962f7d629318f5dcd09
$jLK4KwpKxGfwbMdz2oJbuUlHegeZ_5YucIy2ChSNCLg	sha256	\\x8cb2b82b0a4ac467f06cc773da825bb949477a0799ff962e708cb60a148d08b8
$BNEpFvlxqdDF-6u3EPToNgfx0BuYX2_P9oWB486xTxM	sha256	\\x04d12916f971a9d0c5fbabb710f4e83607f1d01b985f6fcff68581e3ceb14f13
$v_Jh2P1U7Li3ATyMsxgipoyBuQRYv5HD-cv8JVNpdLc	sha256	\\xbff261d8fd54ecb8b7013c8cb31822a68c81b90458bf91c3f9cbfc25536974b7
$ce28aY-iB2mpb8Gioxn_S-YFJtBn3dK4JRguWv9H2XY	sha256	\\x71edbc698fa20769a96fc1a2a319ff4be60526d067ddd2b825182e5aff47d976
$3ccBKAI_RT742spGFKzsNSBIzhj7WC7YBxugrDvyr4w	sha256	\\xddc70128023f453ef8daca4614acec352048ce18fb582ed8071ba0ac3bf2af8c
$e4RXblgeP3Sa0Hs3COmGOAFe9LclWYCrLIk7nF2PEDk	sha256	\\x7b84576e581e3f749ad07b3708e98638015ef4b7255980ab2c893b9c5d8f1039
$dLHdIN5p2aRYI16qULeP30FhKh5GGtUHvQUzWcSWyTA	sha256	\\x74b1dd20de69d9a458235eaa50b78fdf41612a1e461ad507bd053359c496c930
$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q	sha256	\\x7a0934b18d5676ce7eb5f5c0b5649f6fdc05dc457501d2f1a0ad590065fb8764
$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic	sha256	\\x35035dda7882c1793a58d84c6b371f03379b7932f5a5c0c0b78bc4e3f1204a27
$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k	sha256	\\x3ce5be276007a02e2d4db1c1ee4d687bb5138cca24357a2e22298bb969f13b69
$PTHh0FcsZLrplrmwtCyvLjXr1yAZRgovFGLVt7qrrAo	sha256	\\x3d31e1d0572c64bae996b9b0b42caf2e35ebd72019460a2f1462d5b7baabac0a
$6CLZCTGtpIVnohQDg2sJwn_880f0--zCZpr6BgOwQ2Q	sha256	\\xe822d90931ada48567a21403836b09c27ffcf347f4fbecc2669afa0603b04364
$nKXxWIIoo5Vko9Z7kITUEeAsQgQnr-FLvhoQHfkCYAE	sha256	\\x9ca5f1588228a39564a3d67b9084d411e02c420427afe14bbe1a101df9026001
$TbFvVskFwRsxEgjNnOjfs4ljMJuZC60_Cqb91vOUrxg	sha256	\\x4db16f56c905c11b311208cd9ce8dfb38963309b990bad3f0aa6fdd6f394af18
$Fu0mjSRDDuhZx4RxMK6O8cvc6t75G99rXoFXGU-7868	sha256	\\x16ed268d24430ee859c7847130ae8ef1cbdceadef91bdf6b5e8157194fbbf3af
$SuM_AupYZSEtAJBPHbvNkhJ4aIYEjT4c741wzkoOX4I	sha256	\\x4ae33f02ea5865212d00904f1dbbcd9212786886048d3e1cef8d70ce4a0e5f82
$_-6CgruWK6UfiL1rgJnNUgtmp_jusf_3Vf7LUPB6xaU	sha256	\\xffee8282bb962ba51f88bd6b8099cd520b66a7f8eeb1fff755fecb50f07ac5a5
$yrfdAmX0K0lY65Dm9bViRYWOBKtvTB1kxkm6lNsThdw	sha256	\\xcab7dd0265f42b4958eb90e6f5b56245858e04ab6f4c1d64c649ba94db1385dc
$uKKFUGwf_IAnbH81DTvAScd2HFnAwWWL_p4-E5B_YdU	sha256	\\xb8a285506c1ffc80276c7f350d3bc049c7761c59c0c1658bfe9e3e13907f61d5
$MRytSYI-n7aCgzUssVx9vLIC5Y-Yt22y_L1eQoE4GgE	sha256	\\x311cad49823e9fb68283352cb15c7dbcb202e58f98b76db2fcbd5e4281381a01
$ah5gH_XfCIYeCtl2NFxHSgdd_OE6O9tHe2U1Pn2Qvhc	sha256	\\x6a1e601ff5df08861e0ad976345c474a075dfce13a3bdb477b65353e7d90be17
$lnpmPOjrFoaPq58156r6g4G7gYfejQ2BfcFkjGiEX-I	sha256	\\x967a663ce8eb16868fab9f35e7aafa8381bb8187de8d0d817dc1648c68845fe2
$fuvIFJYv32qkEsYyW8XNHbQ0hmQ5HHRjF6UEjte6Z-c	sha256	\\x7eebc814962fdf6aa412c6325bc5cd1db4348664391c746317a5048ed7ba67e7
$smbpaz4v1tYoI0ZZ-HXKXrcs19S7qioXa8ah6FeOBpc	sha256	\\xb266e96b3e2fd6d628234659f875ca5eb72cd7d4bbaa2a176bc6a1e8578e0697
$O-kcGXcFLVtSNAY7CxqW4hLVBk0UqhADtIs1kCz8hlA	sha256	\\x3be91c1977052d5b5234063b0b1a96e212d5064d14aa1003b48b35902cfc8650
$vesveJhdimZ9d-Po76D8SZCUm8dVzl0GcQsvVX8lhos	sha256	\\xbdeb2f78985d8a667d77e3e8efa0fc4990949bc755ce5d06710b2f557f25868b
$nfronhC7iKGPRmKJ7zoXzYG7VKiOq5FoUIcfHg3a4Dg	sha256	\\x9dfae89e10bb88a18f466289ef3a17cd81bb54a88eab916850871f1e0ddae038
$Pem9TyngNuhpIq_NI2krx6wpkVigoBj6JCeB3WUezVk	sha256	\\x3de9bd4f29e036e86922afcd23692bc7ac299158a0a018fa242781dd651ecd59
$Fe89WlTUpNMZrgSmSzGQHSt495sI5DkA-kewln3Ug70	sha256	\\x15ef3d5a54d4a4d319ae04a64b31901d2b78f79b08e43900fa47b0967dd483bd
$viSFX8RvY5fe8TiOaDirNG6PqooEHTTV3PT3hrQgVLA	sha256	\\xbe24855fc46f6397def1388e6838ab346e8faa8a041d34d5dcf4f786b42054b0
$A5h106ytjQ2qqPxkSylhOkJgVZQCscB4QX0PK60qxU0	sha256	\\x039875d3acad8d0daaa8fc644b29613a4260559402b1c078417d0f2bad2ac54d
$AMnH95Ky85GttLR7j9XHrHyULlBBezFJ9w8mtji-7Ok	sha256	\\x00c9c7f792b2f391adb4b47b8fd5c7ac7c942e50417b3149f70f26b638beece9
$gDW6j_UqhvIRf1ANEKurSD9fB4Hl4YnQ5uL9cy_U7Os	sha256	\\x8035ba8ff52a86f2117f500d10abab483f5f0781e5e189d0e6e2fd732fd4eceb
$0gszMJtyESzwVMh4olwTajdbj1MrrJYVnylO0yOIpSg	sha256	\\xd20b33309b72112cf054c878a25c136a375b8f532bac96159f294ed32388a528
$2lEnFzGdtIu4kGthBBXcP0gW6sUWKP8c1x9I4-yFWso	sha256	\\xda512717319db48bb8906b610415dc3f4816eac51628ff1cd71f48e3ec855aca
$yfuDQBYjEI6CCa3AdtfdjL_ZXIR0d92TRfHnh7Gq0zc	sha256	\\xc9fb83401623108e8209adc076d7dd8cbfd95c847477dd9345f1e787b1aad337
$xyV3lysb-dda01bB4LpALdmaTC_mLZDhwxOE9L4zpXY	sha256	\\xc72577972b1bf9d75ad356c1e0ba402dd99a4c2fe62d90e1c31384f4be33a576
$MT4EKTmcPC8LCVeATiG-5a71N2Zc1vNQcgKge5W0on8	sha256	\\x313e0429399c3c2f0b0957804e21bee5aef537665cd6f3507202a07b95b4a27f
$eOC3-FZNb3jb3NisHG61gQhQ_hf9zWu0xvpfs8ZKDTg	sha256	\\x78e0b7f8564d6f78dbdcd8ac1c6eb5810850fe17fdcd6bb4c6fa5fb3c64a0d38
$usag8slAxKA2dWWERksMiBQ8hRwfGZ8nZzTfcymZxyE	sha256	\\xbac6a0f2c940c4a036756584464b0c88143c851c1f199f276734df732999c721
$O04OV5x9R_5W2IT9G9Z-dXJmfV6fgtZM8-4ogFp9rEw	sha256	\\x3b4e0e579c7d47fe56d884fd1bd67e7572667d5e9f82d64cf3ee28805a7dac4c
$-QMfwsu75_SWJtzFqIsrFjLgl_XBqF6HcorcUjLTsWY	sha256	\\xf9031fc2cbbbe7f49626dcc5a88b2b1632e097f5c1a85e87728adc5232d3b166
$Wj4b7gcXdhL474sxg5O6Kh7tBw4O5BtHv_KJEd3KXfM	sha256	\\x5a3e1bee07177612f8ef8b318393ba2a1eed070e0ee41b47bff28911ddca5df3
$ZYEqhm3M07nXRAh1U842uZ1squBm9wa5H1Wb2-LjE1c	sha256	\\x65812a866dccd3b9d744087553ce36b99d6caae066f706b91f559bdbe2e31357
$WsVhQvsUsrFormgSdFA_Z_Io7y9fxZy5juqaM8oYpkg	sha256	\\x5ac56142fb14b2b168ae681274503f67f228ef2f5fc59cb98eea9a33ca18a648
$r8P3KtaOOCBm8XKydsvp0N-cG5BAE1YKU5MumKzWUI8	sha256	\\xafc3f72ad68e382066f172b276cbe9d0df9c1b904013560a53932e98acd6508f
$p0-tc7QWKDmREIJlluolf1RQ-uKnVDhx5d_JQY9PX5E	sha256	\\xa74fad73b41628399110826596ea257f5450fae2a7543871e5dfc9418f4f5f91
$GmUIImAeTzvNSV5qvb40ScXGL3dlsX4DDnmg28rkzk4	sha256	\\x1a650822601e4f3bcd495e6abdbe3449c5c62f7765b17e030e79a0dbcae4ce4e
$hooKnajA7nQRs3MZDj_evGyHCyHpg4QmGp2i5WRKzp0	sha256	\\x868a0a9da8c0ee7411b373190e3fdebc6c870b21e98384261a9da2e5644ace9d
$kwgJJLzgJAXgzd-lj8uFVnrjX5yqfNOtOcPrcl87hXU	sha256	\\x93080924bce02405e0cddfa58fcb85567ae35f9caa7cd3ad39c3eb725f3b8575
$rNG4YvsFCU9LVcVcHEkbBRGSuEH_QqO_hMEZ-sC8WH8	sha256	\\xacd1b862fb05094f4b55c55c1c491b051192b841ff42a3bf84c119fac0bc587f
\.


--
-- Data for Name: event_relations; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_relations (event_id, relates_to_id, relation_type, aggregation_key) FROM stdin;
\.


--
-- Data for Name: event_reports; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_reports (id, received_ts, room_id, event_id, user_id, reason, content) FROM stdin;
\.


--
-- Data for Name: event_search; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_search (event_id, room_id, sender, key, vector, origin_server_ts, stream_ordering) FROM stdin;
$Nv-ymHeLYsZKVjdilAoBLGC4GlzNJWt1HBqtIlSIz1k	!MrxfbdodytWwBMqNiF:localhost	\N	content.body	'hej':1	1672417354608	57
$-JWBJJpXpVo-YhtBYaJDTakzo94Jhn_XGlhnLzEWxyc	!UKcoTBWWxNEyixrjyM:localhost	\N	content.body	'hej':1	1672417516087	65
$Np7HQ3SdNiYX3HhRJtJw4b80J96uY_IbqI_bL7w83m0	!kAToIwhNWrDpgQVMfY:localhost	\N	content.name	'mittrum':1	1672417769811	73
$nL-1meDVcMfCo41V5V5w3EBPwNdmll7Alfsp00QCHvk	!kAToIwhNWrDpgQVMfY:localhost	\N	content.topic		1672417769921	74
$tWJ40KRMdaZwn6df_597mz_AyHLHUSEy0noQk3HlctY	!ffaaxOMHcWnINEXTWK:localhost	\N	content.name	'slumpmässig':1	1672417777067	89
$ab5rFOQQuDGj00oHfJaJKURhG6lNFNDKS0nkBlsLTMk	!cwnFZrIkYIOvkCHJkc:localhost	\N	content.name	'allmänt':1	1672417777132	90
$b_nOg7oeQd8bhYHe5kvgAdNM0U6hcAUFdf-yhgbItfc	!cwnFZrIkYIOvkCHJkc:localhost	\N	content.body	'anka':2 'kall':1	1672417822072	95
$Fu0mjSRDDuhZx4RxMK6O8cvc6t75G99rXoFXGU-7868	!LwtGEdNVvQHvFLuWQB:localhost	\N	content.body	'kall':1	1672480140439	103
$Fe89WlTUpNMZrgSmSzGQHSt495sI5DkA-kewln3Ug70	!MrxfbdodytWwBMqNiF:localhost	\N	content.body	'ok':1	1672481657418	117
$Wj4b7gcXdhL474sxg5O6Kh7tBw4O5BtHv_KJEd3KXfM	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'hej':1	1672481890977	131
$ZYEqhm3M07nXRAh1U842uZ1squBm9wa5H1Wb2-LjE1c	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'igång':4 'nu':1 'vi':3 'är':2	1672481947141	132
$p0-tc7QWKDmREIJlluolf1RQ-uKnVDhx5d_JQY9PX5E	!dKcbdDATuwwphjRPQP:localhost	\N	content.body		1672482552664	135
$GmUIImAeTzvNSV5qvb40ScXGL3dlsX4DDnmg28rkzk4	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'yes':1	1672482578574	136
$kwgJJLzgJAXgzd-lj8uFVnrjX5yqfNOtOcPrcl87hXU	!UKcoTBWWxNEyixrjyM:localhost	\N	content.body	'ok':1	1672482641095	138
\.


--
-- Data for Name: event_to_state_groups; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_to_state_groups (event_id, state_group) FROM stdin;
$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	2
$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw	3
$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	4
$X8tdoEsXAgBC6gobCepAn3rwO8CJoQU6i9NN9Rzhukg	5
$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	6
$O5iO4EII22igkDq5cMKHFB-SGIYD0KqJQXZohS2Dzc0	7
$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	9
$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA	10
$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	11
$b__a7rX3L5YpX7nAZte73DAbjtXZK48JH8VKSnGOKKw	12
$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	13
$TVnvv0nGbLydCBtMmTTz-htMsoI4hmxCr3s9AHyFGHQ	14
$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8	15
$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0	16
$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk	17
$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0	18
$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	19
$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A	20
$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok	22
$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ	21
$7TwPfUMTevEcf7wLvbgx3LG01lYT_yGudYiOVlkGU7E	23
$jAifmicJfMyB1QPFQ6KFQ7ZqTqQ58RJXsH5viWn3ZUg	24
$DsZXxk2rEIB2tF3pYUdOPjrMwclo8BXltutiWCnKUIU	25
$NyVGoA-ZaMPbk_RzpmLOajRS1nEBirO7Du2KpA9Eo64	26
$JwL8EK5sa4vg29tclnHwa5jrpCTa8oZVOIsgFyivQdY	27
$JcoTJcBGASUqIK9V7j6ND5Jt6P9gdbNJxXxQBZNg8z4	28
$2KnXfE3sZw8LDrOAaEP4HdQuw5neshhvyZKtnwo5cg0	29
$isXWKf_B_7Z7R7jYn_2gZB-U31TuzMehBRxj5701Lq8	30
$rVK77mVSpz5EHxI2mbLxilqbkLxKhXEiusPFjapVPbw	69
$5agO4kI6VqJHGKvKbkqUa2Y3cTwUBrjAhmCVtj9JmKU	70
$4JiNeQHyMbyuEfymLkE-SEzPUh3bWddjxa6-5w36nJw	71
$Y_S-fF0iLu0OHNMcZdYVzt0we_qL_t8_4QIKGeobLdI	72
$g1kV-jEZBtN9l6VGGo2MN-wQn7RR7J-Tv5LfyJ5Z5fc	73
$CQg_jKvdpWFvaiLH2f5MtTnu1Zwxi8P4QPSJZum91dw	74
$OcvCF7YNeTKFnzz4EWVjFJIF9QidMEUmomHIvH3d2W8	75
$GrqoJ52XSgRaoc4wPEYLdL2p6t3jl0aiFd8bYswQQcU	76
$5TE1hAtSTolrY9QTj9Wt8DnKurFa3P6KIfGkWOJbrY4	77
$UYXKiTPqFr31PwoZzi35ODpdRK0hwJVjVGC1N7kR7yk	78
$YFCWkh6b_jgrSjje7vt6JB6-uLPRz7Na1VgGh0PwdI8	79
$h2yGPxzdKWUBUSFQiOgFiRoNa8NgWHYXdy_2SMJx6ns	80
$kmvnPONhcKxIpG62sV6apngYToshpP0mBrwpKL0hAOI	81
$KgpvpFIMQIVFvm0adBZqAbWANmMgdu1_1jbP71RuM48	82
$qWi32T1tK2APgSwc4y_6f0e_N_fUPmIBxC5ACk1h6NM	83
$jvwVmkElpx8M62JlaBz7nJ4qa2U8tVO7V9-HhJ-n8JI	84
$0WsTO-QKZzqtMdl5UwGJc5h4e7YAE5ZGp_GDMb9K824	85
$opS4sT6APXaq4vDdegPq6ik1z-yX-FkMTAqhGtTWXEE	86
$l5dYt-R2kpcKdlmMRFnzC5N9PjiV4DZ63c1bTGPOCXk	87
$NxuVtjeVql0_aadDlNux0yeeR_PxcpcJPnX1SdoDmXM	88
$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY	90
$89n67RlAmtb8nRuxie-oq3g9grnkpjzJMAhbJ8h_8Xw	91
$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA	92
$TVXtgqtZ5WfNfZEnJQx6m0NYwp0_34ylOK87XzZ3JlI	93
$JQ7PDbgzTTAY5uHFM6NV0ovadfzQLOpcAcrSX5mRUi0	94
$9MVFB3q88VYxhDZMX087Uv4c3h3uEpluJN0q33ubtso	95
$V_QrTFMCwHlrg-MSVVplcYCRVWM_QgXhIvp-2R_LtHI	96
$Nv-ymHeLYsZKVjdilAoBLGC4GlzNJWt1HBqtIlSIz1k	96
$yZwQJfxjuLFOlfyTYw-M1aupZjmck-aVfpfSYx5fj1I	98
$sqtTmHJJ_e6UeDKORkztLzcGXYNZpKgoa1v2ir5yr-w	99
$EsIKBNaGky9gjqListPEKjQfFScHFrG5GuEQD0vyi9Q	100
$STt_lRcQQY1HR2YQmv4RsQMis1Xc5sWAamnHn02ddqk	101
$KEhwfKMs0OrXZWYNQWK_YDu-mrG-UP2Do2VsAShloEY	102
$em_2PzgnditDYAzn8yY84PnmN1oNQZgI8Co6SjahtU8	103
$sdrkpiq94MhqjrSukg-aexI_3VlPxcoqiZXmrPvpQGw	104
$-JWBJJpXpVo-YhtBYaJDTakzo94Jhn_XGlhnLzEWxyc	104
$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw	106
$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE	107
$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc	108
$fZAJc_jo3uwpjSNh7ULQOuzuMtHLVO8KdmygXkq-95M	109
$KGv2op0D-6TOpQuqb5Gl4YZxMUKn37cUNSylMiEo7SA	110
$XvSaPVUaER3JwP1gLc-c__oVTIjGs5YL10o0DSsZ3q0	111
$zHrY9OvLbZTtN0bNPCDJg1HsmkgSV-pzAmxVIqaSB98	112
$Np7HQ3SdNiYX3HhRJtJw4b80J96uY_IbqI_bL7w83m0	113
$nL-1meDVcMfCo41V5V5w3EBPwNdmll7Alfsp00QCHvk	114
$AXgBEWEnQYL0m4F3qNGi4DDk7afIQe7a_hmRdZkAZLM	118
$wTlWqRh3eGNrru9CGqbzkNcL0kBGbtEB8sHZwsAboS0	116
$81gCIX2tUwDG_Jg02kHVceEfsUG1IOQ9-YnDk1cV15w	119
$41BPCZJ_9IbE7VgIqxEef1X7U2-FXJjTA25i2Q-n_gg	120
$pn5NPm28AfF5_169OnQQxTv4_ijcoN4k44UIvzGsN7k	121
$PJZugFD-K6RtTB0vNzX1j0YFLZ9x4vli99YpMY9dzQk	122
$jLK4KwpKxGfwbMdz2oJbuUlHegeZ_5YucIy2ChSNCLg	123
$ce28aY-iB2mpb8Gioxn_S-YFJtBn3dK4JRguWv9H2XY	124
$Jy6RZhO0nZ0x_EgWugfJHW0XgWaR5DoWVaImG_wE3lg	126
$3ccBKAI_RT742spGFKzsNSBIzhj7WC7YBxugrDvyr4w	125
$zxy8zKV-5WiZDQEOGVCLyrd2yGWyYrOah4vQYAlc-xI	128
$7CUacT0Q8hFhLt80ecyLwLrizW7Jh6uNtLYApZIgNg4	127
$e4RXblgeP3Sa0Hs3COmGOAFe9LclWYCrLIk7nF2PEDk	129
$dLHdIN5p2aRYI16qULeP30FhKh5GGtUHvQUzWcSWyTA	130
$tWJ40KRMdaZwn6df_597mz_AyHLHUSEy0noQk3HlctY	131
$ab5rFOQQuDGj00oHfJaJKURhG6lNFNDKS0nkBlsLTMk	132
$BNEpFvlxqdDF-6u3EPToNgfx0BuYX2_P9oWB486xTxM	133
$v_Jh2P1U7Li3ATyMsxgipoyBuQRYv5HD-cv8JVNpdLc	134
$bFxX1nACgPihIeXfSiWHmW_hxrfmIgtQM9HWAPS2wVY	136
$kL3ALUeGobajxL55gzYoIZLdD1CSD4sYXedIOysHwV0	137
$b_nOg7oeQd8bhYHe5kvgAdNM0U6hcAUFdf-yhgbItfc	132
$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q	139
$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic	140
$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k	141
$PTHh0FcsZLrplrmwtCyvLjXr1yAZRgovFGLVt7qrrAo	142
$6CLZCTGtpIVnohQDg2sJwn_880f0--zCZpr6BgOwQ2Q	143
$TbFvVskFwRsxEgjNnOjfs4ljMJuZC60_Cqb91vOUrxg	145
$ah5gH_XfCIYeCtl2NFxHSgdd_OE6O9tHe2U1Pn2Qvhc	153
$smbpaz4v1tYoI0ZZ-HXKXrcs19S7qioXa8ah6FeOBpc	147
$O-kcGXcFLVtSNAY7CxqW4hLVBk0UqhADtIs1kCz8hlA	156
$nKXxWIIoo5Vko9Z7kITUEeAsQgQnr-FLvhoQHfkCYAE	144
$Fu0mjSRDDuhZx4RxMK6O8cvc6t75G99rXoFXGU-7868	145
$SuM_AupYZSEtAJBPHbvNkhJ4aIYEjT4c741wzkoOX4I	146
$_-6CgruWK6UfiL1rgJnNUgtmp_jusf_3Vf7LUPB6xaU	149
$yrfdAmX0K0lY65Dm9bViRYWOBKtvTB1kxkm6lNsThdw	150
$uKKFUGwf_IAnbH81DTvAScd2HFnAwWWL_p4-E5B_YdU	151
$MRytSYI-n7aCgzUssVx9vLIC5Y-Yt22y_L1eQoE4GgE	152
$lnpmPOjrFoaPq58156r6g4G7gYfejQ2BfcFkjGiEX-I	154
$fuvIFJYv32qkEsYyW8XNHbQ0hmQ5HHRjF6UEjte6Z-c	155
$vesveJhdimZ9d-Po76D8SZCUm8dVzl0GcQsvVX8lhos	158
$nfronhC7iKGPRmKJ7zoXzYG7VKiOq5FoUIcfHg3a4Dg	161
$Pem9TyngNuhpIq_NI2krx6wpkVigoBj6JCeB3WUezVk	162
$Fe89WlTUpNMZrgSmSzGQHSt495sI5DkA-kewln3Ug70	162
$viSFX8RvY5fe8TiOaDirNG6PqooEHTTV3PT3hrQgVLA	197
$A5h106ytjQ2qqPxkSylhOkJgVZQCscB4QX0PK60qxU0	200
$AMnH95Ky85GttLR7j9XHrHyULlBBezFJ9w8mtji-7Ok	201
$gDW6j_UqhvIRf1ANEKurSD9fB4Hl4YnQ5uL9cy_U7Os	202
$0gszMJtyESzwVMh4olwTajdbj1MrrJYVnylO0yOIpSg	203
$2lEnFzGdtIu4kGthBBXcP0gW6sUWKP8c1x9I4-yFWso	204
$yfuDQBYjEI6CCa3AdtfdjL_ZXIR0d92TRfHnh7Gq0zc	205
$xyV3lysb-dda01bB4LpALdmaTC_mLZDhwxOE9L4zpXY	206
$MT4EKTmcPC8LCVeATiG-5a71N2Zc1vNQcgKge5W0on8	198
$eOC3-FZNb3jb3NisHG61gQhQ_hf9zWu0xvpfs8ZKDTg	207
$usag8slAxKA2dWWERksMiBQ8hRwfGZ8nZzTfcymZxyE	209
$O04OV5x9R_5W2IT9G9Z-dXJmfV6fgtZM8-4ogFp9rEw	210
$-QMfwsu75_SWJtzFqIsrFjLgl_XBqF6HcorcUjLTsWY	211
$Wj4b7gcXdhL474sxg5O6Kh7tBw4O5BtHv_KJEd3KXfM	86
$ZYEqhm3M07nXRAh1U842uZ1squBm9wa5H1Wb2-LjE1c	86
$WsVhQvsUsrFormgSdFA_Z_Io7y9fxZy5juqaM8oYpkg	219
$r8P3KtaOOCBm8XKydsvp0N-cG5BAE1YKU5MumKzWUI8	161
$p0-tc7QWKDmREIJlluolf1RQ-uKnVDhx5d_JQY9PX5E	211
$GmUIImAeTzvNSV5qvb40ScXGL3dlsX4DDnmg28rkzk4	86
$hooKnajA7nQRs3MZDj_evGyHCyHpg4QmGp2i5WRKzp0	220
$kwgJJLzgJAXgzd-lj8uFVnrjX5yqfNOtOcPrcl87hXU	220
$rNG4YvsFCU9LVcVcHEkbBRGSuEH_QqO_hMEZ-sC8WH8	221
\.


--
-- Data for Name: event_txn_id; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_txn_id (event_id, room_id, user_id, token_id, txn_id, inserted_ts) FROM stdin;
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.events (topological_ordering, event_id, type, room_id, content, unrecognized_keys, processed, outlier, depth, origin_server_ts, received_ts, sender, contains_url, instance_name, stream_ordering) FROM stdin;
1	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	m.room.create	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	1	1598686327756	1598686327770	@admin:localhost	f	\N	2
2	$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	2	1598686327803	1598686327820	@admin:localhost	f	\N	3
3	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	m.room.power_levels	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	3	1598686327849	1598686327860	@admin:localhost	f	\N	4
4	$X8tdoEsXAgBC6gobCepAn3rwO8CJoQU6i9NN9Rzhukg	m.room.canonical_alias	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	4	1598686327933	1598686327989	@admin:localhost	f	\N	5
5	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	m.room.join_rules	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	5	1598686328055	1598686328083	@admin:localhost	f	\N	6
6	$O5iO4EII22igkDq5cMKHFB-SGIYD0KqJQXZohS2Dzc0	m.room.history_visibility	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	6	1598686328127	1598686328156	@admin:localhost	f	\N	7
1	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	m.room.create	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	1	1598686328210	1598686328221	@admin:localhost	f	\N	8
2	$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	2	1598686328245	1598686328258	@admin:localhost	f	\N	9
3	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	m.room.power_levels	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	3	1598686328280	1598686328291	@admin:localhost	f	\N	10
4	$b__a7rX3L5YpX7nAZte73DAbjtXZK48JH8VKSnGOKKw	m.room.canonical_alias	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	4	1598686328305	1598686328319	@admin:localhost	f	\N	11
5	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	m.room.join_rules	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	5	1598686328338	1598686328349	@admin:localhost	f	\N	12
6	$TVnvv0nGbLydCBtMmTTz-htMsoI4hmxCr3s9AHyFGHQ	m.room.history_visibility	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	6	1598686328366	1598686328379	@admin:localhost	f	\N	13
7	$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	7	1598686328406	1598686328420	@matrix_a:localhost	f	\N	14
7	$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	7	1598686328450	1598686328461	@matrix_a:localhost	f	\N	15
8	$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	8	1598686328493	1598686328506	@matrix_b:localhost	f	\N	16
8	$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	8	1598686328533	1598686328544	@matrix_b:localhost	f	\N	17
9	$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	9	1598686328575	1598686328587	@ignored_user:localhost	f	\N	18
9	$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	9	1598686328616	1598686328628	@ignored_user:localhost	f	\N	19
10	$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	10	1672393388391	1672393388476	@matterbot:localhost	f	master	20
10	$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	10	1672393388388	1672393388666	@matterbot:localhost	f	master	21
11	$7TwPfUMTevEcf7wLvbgx3LG01lYT_yGudYiOVlkGU7E	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	11	1672393389898	1672393390002	@matterbot:localhost	f	master	22
11	$jAifmicJfMyB1QPFQ6KFQ7ZqTqQ58RJXsH5viWn3ZUg	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	11	1672393390194	1672393390252	@matterbot:localhost	f	master	23
12	$DsZXxk2rEIB2tF3pYUdOPjrMwclo8BXltutiWCnKUIU	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	12	1672393390226	1672393390271	@matterbot:localhost	f	master	24
12	$NyVGoA-ZaMPbk_RzpmLOajRS1nEBirO7Du2KpA9Eo64	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	12	1672393390388	1672393390444	@matterbot:localhost	f	master	25
13	$JwL8EK5sa4vg29tclnHwa5jrpCTa8oZVOIsgFyivQdY	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	13	1672393390408	1672393390447	@mm_mattermost_b:localhost	f	master	26
13	$JcoTJcBGASUqIK9V7j6ND5Jt6P9gdbNJxXxQBZNg8z4	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	13	1672393390567	1672393390624	@mm_mattermost_b:localhost	f	master	27
14	$2KnXfE3sZw8LDrOAaEP4HdQuw5neshhvyZKtnwo5cg0	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	14	1672393390608	1672393390641	@mm_mattermost_a:localhost	f	master	28
14	$isXWKf_B_7Z7R7jYn_2gZB-U31TuzMehBRxj5701Lq8	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	14	1672393390746	1672393390810	@mm_mattermost_a:localhost	f	master	29
15	$rVK77mVSpz5EHxI2mbLxilqbkLxKhXEiusPFjapVPbw	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	15	1672416526671	1672416526826	@matterbot:localhost	f	master	30
16	$5agO4kI6VqJHGKvKbkqUa2Y3cTwUBrjAhmCVtj9JmKU	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	16	1672416527105	1672416527213	@matterbot:localhost	f	master	31
15	$4JiNeQHyMbyuEfymLkE-SEzPUh3bWddjxa6-5w36nJw	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	15	1672416527341	1672416527496	@matterbot:localhost	f	master	32
17	$Y_S-fF0iLu0OHNMcZdYVzt0we_qL_t8_4QIKGeobLdI	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	17	1672416527487	1672416527540	@matterbot:localhost	f	master	33
16	$g1kV-jEZBtN9l6VGGo2MN-wQn7RR7J-Tv5LfyJ5Z5fc	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	16	1672416527629	1672416527738	@matterbot:localhost	f	master	34
18	$CQg_jKvdpWFvaiLH2f5MtTnu1Zwxi8P4QPSJZum91dw	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	18	1672416527745	1672416527799	@mm_mattermost_a_:localhost	f	master	35
17	$OcvCF7YNeTKFnzz4EWVjFJIF9QidMEUmomHIvH3d2W8	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	17	1672416527885	1672416527961	@matterbot:localhost	f	master	36
19	$GrqoJ52XSgRaoc4wPEYLdL2p6t3jl0aiFd8bYswQQcU	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	19	1672416527990	1672416528066	@matterbot:localhost	f	master	37
18	$5TE1hAtSTolrY9QTj9Wt8DnKurFa3P6KIfGkWOJbrY4	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	18	1672416528095	1672416528202	@matterbot:localhost	f	master	38
20	$UYXKiTPqFr31PwoZzi35ODpdRK0hwJVjVGC1N7kR7yk	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	20	1672416528236	1672416528294	@mm_mattermost_b_:localhost	f	master	39
19	$YFCWkh6b_jgrSjje7vt6JB6-uLPRz7Na1VgGh0PwdI8	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	19	1672416528363	1672416528466	@mm_matrix_matrix_b:localhost	f	master	40
21	$h2yGPxzdKWUBUSFQiOgFiRoNa8NgWHYXdy_2SMJx6ns	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	21	1672416528469	1672416528502	@mm_matrix_matrix_a:localhost	f	master	41
20	$kmvnPONhcKxIpG62sV6apngYToshpP0mBrwpKL0hAOI	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	20	1672416528584	1672416528616	@mm_matrix_matrix_a:localhost	f	master	42
22	$KgpvpFIMQIVFvm0adBZqAbWANmMgdu1_1jbP71RuM48	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	22	1672416528702	1672416528797	@mm_matrix_matrix_b:localhost	f	master	43
24	$NxuVtjeVql0_aadDlNux0yeeR_PxcpcJPnX1SdoDmXM	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	24	1672416529383	1672416529428	@mm_mattermost_a:localhost	f	master	49
21	$qWi32T1tK2APgSwc4y_6f0e_N_fUPmIBxC5ACk1h6NM	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	21	1672416528782	1672416528818	@mm_mattermost_b_:localhost	f	master	44
23	$l5dYt-R2kpcKdlmMRFnzC5N9PjiV4DZ63c1bTGPOCXk	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	23	1672416529228	1672416529286	@mm_mattermost_b:localhost	f	master	48
1	$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY	m.room.create	!MrxfbdodytWwBMqNiF:localhost	\N	\N	t	f	1	1672417353493	1672417353530	@bridgeuser1:localhost	f	master	50
23	$jvwVmkElpx8M62JlaBz7nJ4qa2U8tVO7V9-HhJ-n8JI	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	23	1672416528973	1672416529043	@mm_mattermost_b:localhost	f	master	45
7	$V_QrTFMCwHlrg-MSVVplcYCRVWM_QgXhIvp-2R_LtHI	m.room.member	!MrxfbdodytWwBMqNiF:localhost	\N	\N	t	f	7	1672417354326	1672417354364	@bridgeuser1:localhost	f	master	56
22	$0WsTO-QKZzqtMdl5UwGJc5h4e7YAE5ZGp_GDMb9K824	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	22	1672416529010	1672416529055	@mm_mattermost_a_:localhost	f	master	46
24	$opS4sT6APXaq4vDdegPq6ik1z-yX-FkMTAqhGtTWXEE	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	24	1672416529204	1672416529270	@mm_mattermost_a:localhost	f	master	47
2	$89n67RlAmtb8nRuxie-oq3g9grnkpjzJMAhbJ8h_8Xw	m.room.member	!MrxfbdodytWwBMqNiF:localhost	\N	\N	t	f	2	1672417353612	1672417353637	@bridgeuser1:localhost	f	master	51
4	$TVXtgqtZ5WfNfZEnJQx6m0NYwp0_34ylOK87XzZ3JlI	m.room.join_rules	!MrxfbdodytWwBMqNiF:localhost	\N	\N	t	f	4	1672417353911	1672417354004	@bridgeuser1:localhost	f	master	53
5	$JQ7PDbgzTTAY5uHFM6NV0ovadfzQLOpcAcrSX5mRUi0	m.room.history_visibility	!MrxfbdodytWwBMqNiF:localhost	\N	\N	t	f	5	1672417354076	1672417354115	@bridgeuser1:localhost	f	master	54
3	$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA	m.room.power_levels	!MrxfbdodytWwBMqNiF:localhost	\N	\N	t	f	3	1672417353714	1672417353784	@bridgeuser1:localhost	f	master	52
6	$9MVFB3q88VYxhDZMX087Uv4c3h3uEpluJN0q33ubtso	m.room.guest_access	!MrxfbdodytWwBMqNiF:localhost	\N	\N	t	f	6	1672417354178	1672417354225	@bridgeuser1:localhost	f	master	55
8	$Nv-ymHeLYsZKVjdilAoBLGC4GlzNJWt1HBqtIlSIz1k	m.room.message	!MrxfbdodytWwBMqNiF:localhost	\N	\N	t	f	8	1672417354608	1672417354675	@bridgeuser1:localhost	f	master	57
1	$yZwQJfxjuLFOlfyTYw-M1aupZjmck-aVfpfSYx5fj1I	m.room.create	!UKcoTBWWxNEyixrjyM:localhost	\N	\N	t	f	1	1672417514365	1672417514389	@bridgeuser1:localhost	f	master	58
2	$sqtTmHJJ_e6UeDKORkztLzcGXYNZpKgoa1v2ir5yr-w	m.room.member	!UKcoTBWWxNEyixrjyM:localhost	\N	\N	t	f	2	1672417514479	1672417514513	@bridgeuser1:localhost	f	master	59
3	$EsIKBNaGky9gjqListPEKjQfFScHFrG5GuEQD0vyi9Q	m.room.power_levels	!UKcoTBWWxNEyixrjyM:localhost	\N	\N	t	f	3	1672417514593	1672417514683	@bridgeuser1:localhost	f	master	60
4	$STt_lRcQQY1HR2YQmv4RsQMis1Xc5sWAamnHn02ddqk	m.room.join_rules	!UKcoTBWWxNEyixrjyM:localhost	\N	\N	t	f	4	1672417514851	1672417514899	@bridgeuser1:localhost	f	master	61
5	$KEhwfKMs0OrXZWYNQWK_YDu-mrG-UP2Do2VsAShloEY	m.room.history_visibility	!UKcoTBWWxNEyixrjyM:localhost	\N	\N	t	f	5	1672417514969	1672417515015	@bridgeuser1:localhost	f	master	62
6	$em_2PzgnditDYAzn8yY84PnmN1oNQZgI8Co6SjahtU8	m.room.guest_access	!UKcoTBWWxNEyixrjyM:localhost	\N	\N	t	f	6	1672417515149	1672417515275	@bridgeuser1:localhost	f	master	63
7	$sdrkpiq94MhqjrSukg-aexI_3VlPxcoqiZXmrPvpQGw	m.room.member	!UKcoTBWWxNEyixrjyM:localhost	\N	\N	t	f	7	1672417515401	1672417515440	@bridgeuser1:localhost	f	master	64
8	$-JWBJJpXpVo-YhtBYaJDTakzo94Jhn_XGlhnLzEWxyc	m.room.message	!UKcoTBWWxNEyixrjyM:localhost	\N	\N	t	f	8	1672417516087	1672417516109	@bridgeuser1:localhost	f	master	65
1	$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw	m.room.create	!kAToIwhNWrDpgQVMfY:localhost	\N	\N	t	f	1	1672417768863	1672417768898	@bridgeadmin:localhost	f	master	66
2	$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE	m.room.member	!kAToIwhNWrDpgQVMfY:localhost	\N	\N	t	f	2	1672417768995	1672417769042	@bridgeadmin:localhost	f	master	67
3	$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc	m.room.power_levels	!kAToIwhNWrDpgQVMfY:localhost	\N	\N	t	f	3	1672417769139	1672417769205	@bridgeadmin:localhost	f	master	68
4	$fZAJc_jo3uwpjSNh7ULQOuzuMtHLVO8KdmygXkq-95M	m.room.canonical_alias	!kAToIwhNWrDpgQVMfY:localhost	\N	\N	t	f	4	1672417769336	1672417769401	@bridgeadmin:localhost	f	master	69
5	$KGv2op0D-6TOpQuqb5Gl4YZxMUKn37cUNSylMiEo7SA	m.room.join_rules	!kAToIwhNWrDpgQVMfY:localhost	\N	\N	t	f	5	1672417769488	1672417769528	@bridgeadmin:localhost	f	master	70
6	$XvSaPVUaER3JwP1gLc-c__oVTIjGs5YL10o0DSsZ3q0	m.room.guest_access	!kAToIwhNWrDpgQVMfY:localhost	\N	\N	t	f	6	1672417769602	1672417769638	@bridgeadmin:localhost	f	master	71
7	$zHrY9OvLbZTtN0bNPCDJg1HsmkgSV-pzAmxVIqaSB98	m.room.history_visibility	!kAToIwhNWrDpgQVMfY:localhost	\N	\N	t	f	7	1672417769701	1672417769734	@bridgeadmin:localhost	f	master	72
8	$Np7HQ3SdNiYX3HhRJtJw4b80J96uY_IbqI_bL7w83m0	m.room.name	!kAToIwhNWrDpgQVMfY:localhost	\N	\N	t	f	8	1672417769811	1672417769849	@bridgeadmin:localhost	f	master	73
9	$nL-1meDVcMfCo41V5V5w3EBPwNdmll7Alfsp00QCHvk	m.room.topic	!kAToIwhNWrDpgQVMfY:localhost	\N	\N	t	f	9	1672417769921	1672417769953	@bridgeadmin:localhost	f	master	74
1	$AXgBEWEnQYL0m4F3qNGi4DDk7afIQe7a_hmRdZkAZLM	m.room.create	!cwnFZrIkYIOvkCHJkc:localhost	\N	\N	t	f	1	1672417775372	1672417775507	@bridgeadmin:localhost	f	master	76
1	$wTlWqRh3eGNrru9CGqbzkNcL0kBGbtEB8sHZwsAboS0	m.room.create	!ffaaxOMHcWnINEXTWK:localhost	\N	\N	t	f	1	1672417775354	1672417775519	@bridgeadmin:localhost	f	master	75
2	$81gCIX2tUwDG_Jg02kHVceEfsUG1IOQ9-YnDk1cV15w	m.room.member	!ffaaxOMHcWnINEXTWK:localhost	\N	\N	t	f	2	1672417775659	1672417775712	@bridgeadmin:localhost	f	master	77
2	$41BPCZJ_9IbE7VgIqxEef1X7U2-FXJjTA25i2Q-n_gg	m.room.member	!cwnFZrIkYIOvkCHJkc:localhost	\N	\N	t	f	2	1672417775669	1672417775718	@bridgeadmin:localhost	f	master	78
3	$pn5NPm28AfF5_169OnQQxTv4_ijcoN4k44UIvzGsN7k	m.room.power_levels	!ffaaxOMHcWnINEXTWK:localhost	\N	\N	t	f	3	1672417775783	1672417775888	@bridgeadmin:localhost	f	master	79
3	$PJZugFD-K6RtTB0vNzX1j0YFLZ9x4vli99YpMY9dzQk	m.room.power_levels	!cwnFZrIkYIOvkCHJkc:localhost	\N	\N	t	f	3	1672417775878	1672417775974	@bridgeadmin:localhost	f	master	80
4	$jLK4KwpKxGfwbMdz2oJbuUlHegeZ_5YucIy2ChSNCLg	m.room.join_rules	!ffaaxOMHcWnINEXTWK:localhost	\N	\N	t	f	4	1672417776106	1672417776200	@bridgeadmin:localhost	f	master	81
4	$ce28aY-iB2mpb8Gioxn_S-YFJtBn3dK4JRguWv9H2XY	m.room.join_rules	!cwnFZrIkYIOvkCHJkc:localhost	\N	\N	t	f	4	1672417776148	1672417776218	@bridgeadmin:localhost	f	master	82
5	$Jy6RZhO0nZ0x_EgWugfJHW0XgWaR5DoWVaImG_wE3lg	m.room.guest_access	!ffaaxOMHcWnINEXTWK:localhost	\N	\N	t	f	5	1672417776373	1672417776479	@bridgeadmin:localhost	f	master	84
5	$3ccBKAI_RT742spGFKzsNSBIzhj7WC7YBxugrDvyr4w	m.room.guest_access	!cwnFZrIkYIOvkCHJkc:localhost	\N	\N	t	f	5	1672417776368	1672417776504	@bridgeadmin:localhost	f	master	83
6	$7CUacT0Q8hFhLt80ecyLwLrizW7Jh6uNtLYApZIgNg4	m.space.parent	!cwnFZrIkYIOvkCHJkc:localhost	\N	\N	t	f	6	1672417776624	1672417776715	@bridgeadmin:localhost	f	master	85
6	$zxy8zKV-5WiZDQEOGVCLyrd2yGWyYrOah4vQYAlc-xI	m.space.parent	!ffaaxOMHcWnINEXTWK:localhost	\N	\N	t	f	6	1672417776621	1672417776720	@bridgeadmin:localhost	f	master	86
7	$e4RXblgeP3Sa0Hs3COmGOAFe9LclWYCrLIk7nF2PEDk	m.room.history_visibility	!ffaaxOMHcWnINEXTWK:localhost	\N	\N	t	f	7	1672417776822	1672417776970	@bridgeadmin:localhost	f	master	87
7	$dLHdIN5p2aRYI16qULeP30FhKh5GGtUHvQUzWcSWyTA	m.room.history_visibility	!cwnFZrIkYIOvkCHJkc:localhost	\N	\N	t	f	7	1672417776891	1672417776974	@bridgeadmin:localhost	f	master	88
8	$tWJ40KRMdaZwn6df_597mz_AyHLHUSEy0noQk3HlctY	m.room.name	!ffaaxOMHcWnINEXTWK:localhost	\N	\N	t	f	8	1672417777067	1672417777174	@bridgeadmin:localhost	f	master	89
8	$ab5rFOQQuDGj00oHfJaJKURhG6lNFNDKS0nkBlsLTMk	m.room.name	!cwnFZrIkYIOvkCHJkc:localhost	\N	\N	t	f	8	1672417777132	1672417777215	@bridgeadmin:localhost	f	master	90
10	$BNEpFvlxqdDF-6u3EPToNgfx0BuYX2_P9oWB486xTxM	m.space.child	!kAToIwhNWrDpgQVMfY:localhost	\N	\N	t	f	10	1672417777385	1672417777528	@bridgeadmin:localhost	f	master	91
10	$v_Jh2P1U7Li3ATyMsxgipoyBuQRYv5HD-cv8JVNpdLc	m.space.child	!kAToIwhNWrDpgQVMfY:localhost	\N	\N	t	f	10	1672417777507	1672417777692	@bridgeadmin:localhost	f	master	92
11	$bFxX1nACgPihIeXfSiWHmW_hxrfmIgtQM9HWAPS2wVY	m.room.member	!kAToIwhNWrDpgQVMfY:localhost	\N	\N	t	f	11	1672417798116	1672417798168	@bridgeadmin:localhost	f	master	93
12	$kL3ALUeGobajxL55gzYoIZLdD1CSD4sYXedIOysHwV0	m.room.member	!kAToIwhNWrDpgQVMfY:localhost	\N	\N	t	f	12	1672417798307	1672417798341	@bridgeadmin:localhost	f	master	94
9	$b_nOg7oeQd8bhYHe5kvgAdNM0U6hcAUFdf-yhgbItfc	m.room.message	!cwnFZrIkYIOvkCHJkc:localhost	\N	\N	t	f	9	1672417822072	1672417822123	@bridgeadmin:localhost	f	master	95
1	$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q	m.room.create	!LwtGEdNVvQHvFLuWQB:localhost	\N	\N	t	f	1	1672480138531	1672480138568	@bridgeadmin:localhost	f	master	96
2	$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic	m.room.member	!LwtGEdNVvQHvFLuWQB:localhost	\N	\N	t	f	2	1672480138689	1672480138759	@bridgeadmin:localhost	f	master	97
3	$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k	m.room.power_levels	!LwtGEdNVvQHvFLuWQB:localhost	\N	\N	t	f	3	1672480138977	1672480139084	@bridgeadmin:localhost	f	master	98
4	$PTHh0FcsZLrplrmwtCyvLjXr1yAZRgovFGLVt7qrrAo	m.room.join_rules	!LwtGEdNVvQHvFLuWQB:localhost	\N	\N	t	f	4	1672480139246	1672480139301	@bridgeadmin:localhost	f	master	99
5	$6CLZCTGtpIVnohQDg2sJwn_880f0--zCZpr6BgOwQ2Q	m.room.history_visibility	!LwtGEdNVvQHvFLuWQB:localhost	\N	\N	t	f	5	1672480139417	1672480139451	@bridgeadmin:localhost	f	master	100
6	$nKXxWIIoo5Vko9Z7kITUEeAsQgQnr-FLvhoQHfkCYAE	m.room.guest_access	!LwtGEdNVvQHvFLuWQB:localhost	\N	\N	t	f	6	1672480139567	1672480139599	@bridgeadmin:localhost	f	master	101
7	$TbFvVskFwRsxEgjNnOjfs4ljMJuZC60_Cqb91vOUrxg	m.room.member	!LwtGEdNVvQHvFLuWQB:localhost	\N	\N	t	f	7	1672480139730	1672480139770	@bridgeadmin:localhost	f	master	102
8	$Fu0mjSRDDuhZx4RxMK6O8cvc6t75G99rXoFXGU-7868	m.room.message	!LwtGEdNVvQHvFLuWQB:localhost	\N	\N	t	f	8	1672480140439	1672480140471	@bridgeadmin:localhost	f	master	103
9	$SuM_AupYZSEtAJBPHbvNkhJ4aIYEjT4c741wzkoOX4I	m.room.encryption	!LwtGEdNVvQHvFLuWQB:localhost	\N	\N	t	f	9	1672480178123	1672480178174	@bridgeadmin:localhost	f	master	104
1	$_-6CgruWK6UfiL1rgJnNUgtmp_jusf_3Vf7LUPB6xaU	m.room.create	!GNlLBsLXjbOuNhCkEO:localhost	\N	\N	t	f	1	1672480208324	1672480208347	@bridgeadmin:localhost	f	master	105
2	$yrfdAmX0K0lY65Dm9bViRYWOBKtvTB1kxkm6lNsThdw	m.room.member	!GNlLBsLXjbOuNhCkEO:localhost	\N	\N	t	f	2	1672480208432	1672480208461	@bridgeadmin:localhost	f	master	106
3	$uKKFUGwf_IAnbH81DTvAScd2HFnAwWWL_p4-E5B_YdU	m.room.power_levels	!GNlLBsLXjbOuNhCkEO:localhost	\N	\N	t	f	3	1672480208538	1672480208625	@bridgeadmin:localhost	f	master	107
4	$MRytSYI-n7aCgzUssVx9vLIC5Y-Yt22y_L1eQoE4GgE	m.room.encryption	!GNlLBsLXjbOuNhCkEO:localhost	\N	\N	t	f	4	1672480208936	1672480208983	@bridgeadmin:localhost	f	master	108
5	$ah5gH_XfCIYeCtl2NFxHSgdd_OE6O9tHe2U1Pn2Qvhc	m.room.guest_access	!GNlLBsLXjbOuNhCkEO:localhost	\N	\N	t	f	5	1672480209077	1672480209126	@bridgeadmin:localhost	f	master	109
6	$lnpmPOjrFoaPq58156r6g4G7gYfejQ2BfcFkjGiEX-I	m.room.history_visibility	!GNlLBsLXjbOuNhCkEO:localhost	\N	\N	t	f	6	1672480209211	1672480209247	@bridgeadmin:localhost	f	master	110
7	$fuvIFJYv32qkEsYyW8XNHbQ0hmQ5HHRjF6UEjte6Z-c	m.room.join_rules	!GNlLBsLXjbOuNhCkEO:localhost	\N	\N	t	f	7	1672480209339	1672480209423	@bridgeadmin:localhost	f	master	111
10	$smbpaz4v1tYoI0ZZ-HXKXrcs19S7qioXa8ah6FeOBpc	m.room.tombstone	!LwtGEdNVvQHvFLuWQB:localhost	\N	\N	t	f	10	1672480208302	1672480209522	@bridgeadmin:localhost	f	master	112
11	$O-kcGXcFLVtSNAY7CxqW4hLVBk0UqhADtIs1kCz8hlA	m.room.power_levels	!LwtGEdNVvQHvFLuWQB:localhost	\N	\N	t	f	11	1672480209754	1672480209840	@bridgeadmin:localhost	f	master	113
8	$vesveJhdimZ9d-Po76D8SZCUm8dVzl0GcQsvVX8lhos	m.room.member	!GNlLBsLXjbOuNhCkEO:localhost	\N	\N	t	f	8	1672480210059	1672480210104	@bridgeadmin:localhost	f	master	114
9	$nfronhC7iKGPRmKJ7zoXzYG7VKiOq5FoUIcfHg3a4Dg	m.room.member	!GNlLBsLXjbOuNhCkEO:localhost	\N	\N	t	f	9	1672481639271	1672481639309	@admin:localhost	f	master	115
9	$Pem9TyngNuhpIq_NI2krx6wpkVigoBj6JCeB3WUezVk	m.room.member	!MrxfbdodytWwBMqNiF:localhost	\N	\N	t	f	9	1672481652243	1672481652287	@admin:localhost	f	master	116
10	$Fe89WlTUpNMZrgSmSzGQHSt495sI5DkA-kewln3Ug70	m.room.message	!MrxfbdodytWwBMqNiF:localhost	\N	\N	t	f	10	1672481657418	1672481657461	@admin:localhost	f	master	117
11	$viSFX8RvY5fe8TiOaDirNG6PqooEHTTV3PT3hrQgVLA	m.room.encryption	!MrxfbdodytWwBMqNiF:localhost	\N	\N	t	f	11	1672481727245	1672481727279	@admin:localhost	f	master	118
1	$A5h106ytjQ2qqPxkSylhOkJgVZQCscB4QX0PK60qxU0	m.room.create	!nPrdOOfNMRrmJedabn:localhost	\N	\N	t	f	1	1672481741052	1672481741078	@admin:localhost	f	master	119
2	$AMnH95Ky85GttLR7j9XHrHyULlBBezFJ9w8mtji-7Ok	m.room.member	!nPrdOOfNMRrmJedabn:localhost	\N	\N	t	f	2	1672481741153	1672481741240	@admin:localhost	f	master	120
3	$gDW6j_UqhvIRf1ANEKurSD9fB4Hl4YnQ5uL9cy_U7Os	m.room.power_levels	!nPrdOOfNMRrmJedabn:localhost	\N	\N	t	f	3	1672481741336	1672481741467	@admin:localhost	f	master	121
4	$0gszMJtyESzwVMh4olwTajdbj1MrrJYVnylO0yOIpSg	m.room.join_rules	!nPrdOOfNMRrmJedabn:localhost	\N	\N	t	f	4	1672481741707	1672481741759	@admin:localhost	f	master	122
5	$2lEnFzGdtIu4kGthBBXcP0gW6sUWKP8c1x9I4-yFWso	m.room.history_visibility	!nPrdOOfNMRrmJedabn:localhost	\N	\N	t	f	5	1672481741832	1672481741881	@admin:localhost	f	master	123
6	$yfuDQBYjEI6CCa3AdtfdjL_ZXIR0d92TRfHnh7Gq0zc	m.room.guest_access	!nPrdOOfNMRrmJedabn:localhost	\N	\N	t	f	6	1672481741952	1672481742006	@admin:localhost	f	master	124
7	$xyV3lysb-dda01bB4LpALdmaTC_mLZDhwxOE9L4zpXY	m.room.encryption	!nPrdOOfNMRrmJedabn:localhost	\N	\N	t	f	7	1672481742097	1672481742131	@admin:localhost	f	master	125
12	$MT4EKTmcPC8LCVeATiG-5a71N2Zc1vNQcgKge5W0on8	m.room.tombstone	!MrxfbdodytWwBMqNiF:localhost	\N	\N	t	f	12	1672481741034	1672481742245	@admin:localhost	f	master	126
13	$eOC3-FZNb3jb3NisHG61gQhQ_hf9zWu0xvpfs8ZKDTg	m.room.power_levels	!MrxfbdodytWwBMqNiF:localhost	\N	\N	t	f	13	1672481742376	1672481742429	@admin:localhost	f	master	127
8	$usag8slAxKA2dWWERksMiBQ8hRwfGZ8nZzTfcymZxyE	m.room.member	!nPrdOOfNMRrmJedabn:localhost	\N	\N	t	f	8	1672481742932	1672481743022	@admin:localhost	f	master	128
25	$O04OV5x9R_5W2IT9G9Z-dXJmfV6fgtZM8-4ogFp9rEw	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	25	1672481823109	1672481823168	@admin:localhost	f	master	129
26	$-QMfwsu75_SWJtzFqIsrFjLgl_XBqF6HcorcUjLTsWY	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	26	1672481842114	1672481842163	@admin:localhost	f	master	130
25	$Wj4b7gcXdhL474sxg5O6Kh7tBw4O5BtHv_KJEd3KXfM	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	25	1672481890977	1672481891015	@admin:localhost	f	master	131
26	$ZYEqhm3M07nXRAh1U842uZ1squBm9wa5H1Wb2-LjE1c	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	26	1672481947141	1672481947212	@admin:localhost	f	master	132
12	$WsVhQvsUsrFormgSdFA_Z_Io7y9fxZy5juqaM8oYpkg	m.room.member	!LwtGEdNVvQHvFLuWQB:localhost	\N	\N	t	f	12	1672482445688	1672482445777	@admin:localhost	f	master	133
10	$r8P3KtaOOCBm8XKydsvp0N-cG5BAE1YKU5MumKzWUI8	m.room.encrypted	!GNlLBsLXjbOuNhCkEO:localhost	\N	\N	t	f	10	1672482471146	1672482471175	@admin:localhost	f	master	134
10	$kwgJJLzgJAXgzd-lj8uFVnrjX5yqfNOtOcPrcl87hXU	m.room.message	!UKcoTBWWxNEyixrjyM:localhost	\N	\N	t	f	10	1672482641095	1672482641150	@matrix_a:localhost	f	master	138
27	$p0-tc7QWKDmREIJlluolf1RQ-uKnVDhx5d_JQY9PX5E	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	27	1672482552664	1672482552703	@matrix_a:localhost	f	master	135
27	$GmUIImAeTzvNSV5qvb40ScXGL3dlsX4DDnmg28rkzk4	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	27	1672482578574	1672482578604	@matrix_a:localhost	f	master	136
9	$hooKnajA7nQRs3MZDj_evGyHCyHpg4QmGp2i5WRKzp0	m.room.member	!UKcoTBWWxNEyixrjyM:localhost	\N	\N	t	f	9	1672482632371	1672482632555	@matrix_a:localhost	f	master	137
13	$rNG4YvsFCU9LVcVcHEkbBRGSuEH_QqO_hMEZ-sC8WH8	m.room.member	!kAToIwhNWrDpgQVMfY:localhost	\N	\N	t	f	13	1672482657800	1672482657861	@matrix_a:localhost	f	master	139
\.


--
-- Data for Name: ex_outlier_stream; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.ex_outlier_stream (event_stream_ordering, event_id, state_group, instance_name) FROM stdin;
\.


--
-- Data for Name: federation_inbound_events_staging; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.federation_inbound_events_staging (origin, room_id, event_id, received_ts, event_json, internal_metadata) FROM stdin;
\.


--
-- Data for Name: federation_stream_position; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.federation_stream_position (type, stream_id, instance_name) FROM stdin;
federation	-1	master
events	139	master
\.


--
-- Data for Name: group_attestations_remote; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.group_attestations_remote (group_id, user_id, valid_until_ms, attestation_json) FROM stdin;
\.


--
-- Data for Name: group_attestations_renewals; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.group_attestations_renewals (group_id, user_id, valid_until_ms) FROM stdin;
\.


--
-- Data for Name: group_invites; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.group_invites (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: group_roles; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.group_roles (group_id, role_id, profile, is_public) FROM stdin;
\.


--
-- Data for Name: group_room_categories; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.group_room_categories (group_id, category_id, profile, is_public) FROM stdin;
\.


--
-- Data for Name: group_rooms; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.group_rooms (group_id, room_id, is_public) FROM stdin;
\.


--
-- Data for Name: group_summary_roles; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.group_summary_roles (group_id, role_id, role_order) FROM stdin;
\.


--
-- Data for Name: group_summary_room_categories; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.group_summary_room_categories (group_id, category_id, cat_order) FROM stdin;
\.


--
-- Data for Name: group_summary_rooms; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.group_summary_rooms (group_id, room_id, category_id, room_order, is_public) FROM stdin;
\.


--
-- Data for Name: group_summary_users; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.group_summary_users (group_id, user_id, role_id, user_order, is_public) FROM stdin;
\.


--
-- Data for Name: group_users; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.group_users (group_id, user_id, is_admin, is_public) FROM stdin;
\.


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.groups (group_id, name, avatar_url, short_description, long_description, is_public, join_policy) FROM stdin;
\.


--
-- Data for Name: ignored_users; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.ignored_users (ignorer_user_id, ignored_user_id) FROM stdin;
\.


--
-- Data for Name: insertion_event_edges; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.insertion_event_edges (event_id, room_id, insertion_prev_event_id) FROM stdin;
\.


--
-- Data for Name: insertion_event_extremities; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.insertion_event_extremities (event_id, room_id) FROM stdin;
\.


--
-- Data for Name: insertion_events; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.insertion_events (event_id, room_id, next_batch_id) FROM stdin;
\.


--
-- Data for Name: instance_map; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.instance_map (instance_id, instance_name) FROM stdin;
\.


--
-- Data for Name: local_current_membership; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.local_current_membership (room_id, user_id, event_id, membership) FROM stdin;
!kmbTYjjsDRDHGgVqUP:localhost	@admin:localhost	$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw	join
!dKcbdDATuwwphjRPQP:localhost	@admin:localhost	$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA	join
!kmbTYjjsDRDHGgVqUP:localhost	@matrix_a:localhost	$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8	join
!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0	join
!kmbTYjjsDRDHGgVqUP:localhost	@matrix_b:localhost	$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk	join
!dKcbdDATuwwphjRPQP:localhost	@matrix_b:localhost	$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0	join
!kmbTYjjsDRDHGgVqUP:localhost	@ignored_user:localhost	$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	join
!dKcbdDATuwwphjRPQP:localhost	@ignored_user:localhost	$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A	join
!kmbTYjjsDRDHGgVqUP:localhost	@matterbot:localhost	$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok	join
!dKcbdDATuwwphjRPQP:localhost	@matterbot:localhost	$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ	join
!kmbTYjjsDRDHGgVqUP:localhost	@mm_mattermost_a_:localhost	$CQg_jKvdpWFvaiLH2f5MtTnu1Zwxi8P4QPSJZum91dw	join
!kmbTYjjsDRDHGgVqUP:localhost	@mm_mattermost_b_:localhost	$UYXKiTPqFr31PwoZzi35ODpdRK0hwJVjVGC1N7kR7yk	join
!dKcbdDATuwwphjRPQP:localhost	@mm_matrix_matrix_b:localhost	$YFCWkh6b_jgrSjje7vt6JB6-uLPRz7Na1VgGh0PwdI8	join
!kmbTYjjsDRDHGgVqUP:localhost	@mm_matrix_matrix_a:localhost	$h2yGPxzdKWUBUSFQiOgFiRoNa8NgWHYXdy_2SMJx6ns	join
!dKcbdDATuwwphjRPQP:localhost	@mm_matrix_matrix_a:localhost	$kmvnPONhcKxIpG62sV6apngYToshpP0mBrwpKL0hAOI	join
!kmbTYjjsDRDHGgVqUP:localhost	@mm_matrix_matrix_b:localhost	$KgpvpFIMQIVFvm0adBZqAbWANmMgdu1_1jbP71RuM48	join
!dKcbdDATuwwphjRPQP:localhost	@mm_mattermost_b_:localhost	$qWi32T1tK2APgSwc4y_6f0e_N_fUPmIBxC5ACk1h6NM	join
!kmbTYjjsDRDHGgVqUP:localhost	@mm_mattermost_b:localhost	$jvwVmkElpx8M62JlaBz7nJ4qa2U8tVO7V9-HhJ-n8JI	leave
!dKcbdDATuwwphjRPQP:localhost	@mm_mattermost_a_:localhost	$0WsTO-QKZzqtMdl5UwGJc5h4e7YAE5ZGp_GDMb9K824	join
!dKcbdDATuwwphjRPQP:localhost	@mm_mattermost_b:localhost	$l5dYt-R2kpcKdlmMRFnzC5N9PjiV4DZ63c1bTGPOCXk	leave
!kmbTYjjsDRDHGgVqUP:localhost	@mm_mattermost_a:localhost	$opS4sT6APXaq4vDdegPq6ik1z-yX-FkMTAqhGtTWXEE	leave
!dKcbdDATuwwphjRPQP:localhost	@mm_mattermost_a:localhost	$NxuVtjeVql0_aadDlNux0yeeR_PxcpcJPnX1SdoDmXM	leave
!MrxfbdodytWwBMqNiF:localhost	@bridgeuser1:localhost	$89n67RlAmtb8nRuxie-oq3g9grnkpjzJMAhbJ8h_8Xw	join
!UKcoTBWWxNEyixrjyM:localhost	@bridgeuser1:localhost	$sqtTmHJJ_e6UeDKORkztLzcGXYNZpKgoa1v2ir5yr-w	join
!kAToIwhNWrDpgQVMfY:localhost	@bridgeadmin:localhost	$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE	join
!ffaaxOMHcWnINEXTWK:localhost	@bridgeadmin:localhost	$81gCIX2tUwDG_Jg02kHVceEfsUG1IOQ9-YnDk1cV15w	join
!cwnFZrIkYIOvkCHJkc:localhost	@bridgeadmin:localhost	$41BPCZJ_9IbE7VgIqxEef1X7U2-FXJjTA25i2Q-n_gg	join
!kAToIwhNWrDpgQVMfY:localhost	@matrix_b:localhost	$kL3ALUeGobajxL55gzYoIZLdD1CSD4sYXedIOysHwV0	invite
!LwtGEdNVvQHvFLuWQB:localhost	@bridgeadmin:localhost	$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic	join
!GNlLBsLXjbOuNhCkEO:localhost	@bridgeadmin:localhost	$yrfdAmX0K0lY65Dm9bViRYWOBKtvTB1kxkm6lNsThdw	join
!GNlLBsLXjbOuNhCkEO:localhost	@admin:localhost	$nfronhC7iKGPRmKJ7zoXzYG7VKiOq5FoUIcfHg3a4Dg	join
!MrxfbdodytWwBMqNiF:localhost	@admin:localhost	$Pem9TyngNuhpIq_NI2krx6wpkVigoBj6JCeB3WUezVk	join
!nPrdOOfNMRrmJedabn:localhost	@admin:localhost	$AMnH95Ky85GttLR7j9XHrHyULlBBezFJ9w8mtji-7Ok	join
!nPrdOOfNMRrmJedabn:localhost	@bridgeuser1:localhost	$usag8slAxKA2dWWERksMiBQ8hRwfGZ8nZzTfcymZxyE	invite
!dKcbdDATuwwphjRPQP:localhost	@bridgeadmin:localhost	$O04OV5x9R_5W2IT9G9Z-dXJmfV6fgtZM8-4ogFp9rEw	invite
!dKcbdDATuwwphjRPQP:localhost	@bridgeuser1:localhost	$-QMfwsu75_SWJtzFqIsrFjLgl_XBqF6HcorcUjLTsWY	invite
!LwtGEdNVvQHvFLuWQB:localhost	@admin:localhost	$WsVhQvsUsrFormgSdFA_Z_Io7y9fxZy5juqaM8oYpkg	join
!UKcoTBWWxNEyixrjyM:localhost	@matrix_a:localhost	$hooKnajA7nQRs3MZDj_evGyHCyHpg4QmGp2i5WRKzp0	join
!kAToIwhNWrDpgQVMfY:localhost	@matrix_a:localhost	$rNG4YvsFCU9LVcVcHEkbBRGSuEH_QqO_hMEZ-sC8WH8	join
\.


--
-- Data for Name: local_group_membership; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.local_group_membership (group_id, user_id, is_admin, membership, is_publicised, content) FROM stdin;
\.


--
-- Data for Name: local_group_updates; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.local_group_updates (stream_id, group_id, user_id, type, content) FROM stdin;
\.


--
-- Data for Name: local_media_repository; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.local_media_repository (media_id, media_type, media_length, created_ts, upload_name, user_id, quarantined_by, url_cache, last_access_ts, safe_from_quarantine) FROM stdin;
\.


--
-- Data for Name: local_media_repository_thumbnails; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.local_media_repository_thumbnails (media_id, thumbnail_width, thumbnail_height, thumbnail_type, thumbnail_method, thumbnail_length) FROM stdin;
\.


--
-- Data for Name: local_media_repository_url_cache; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.local_media_repository_url_cache (url, response_code, etag, expires_ts, og, media_id, download_ts) FROM stdin;
\.


--
-- Data for Name: monthly_active_users; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.monthly_active_users (user_id, "timestamp") FROM stdin;
\.


--
-- Data for Name: open_id_tokens; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.open_id_tokens (token, ts_valid_until_ms, user_id) FROM stdin;
aUmZQmOIzcWvgRoNOijOTiZi	1672421193979	@bridgeuser1:localhost
\.


--
-- Data for Name: presence; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.presence (user_id, state, status_msg, mtime) FROM stdin;
\.


--
-- Data for Name: presence_stream; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.presence_stream (stream_id, user_id, state, last_active_ts, last_federation_update_ts, last_user_sync_ts, status_msg, currently_active, instance_name) FROM stdin;
10	@bridgeuser1:localhost	offline	1672417612080	1672417649641	1672417616211	\N	t	master
68	@admin:localhost	offline	1672482503412	1672482539239	1672482506435	\N	t	master
79	@matrix_a:localhost	offline	1672483087182	1672483124249	1672483090031	\N	t	master
46	@bridgeadmin:localhost	offline	1672481594468	1672481639240	1672481601615	\N	t	master
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.profiles (user_id, displayname, avatar_url) FROM stdin;
matrix_b	matrix_b	\N
ignored_user	ignored_user	\N
matterbot	Mattermost Bridge	\N
mm_mattermost_a	MattermostUser A [mm]	\N
mm_mattermost_b	mattermost_b [mm]	\N
bridgeuser1	bridgeuser1	\N
bridgeuser2	bridgeuser2	\N
bridgeadmin	bridgeadmin	\N
mm_mattermost_a_	MattermostUser A [mm]	\N
mm_mattermost_b_	mattermost_b [mm]	\N
mm_matrix_matrix_b	matrix_b [mm]	\N
mm_matrix_matrix_a	Matrix UserA [mm]	\N
admin	admin	\N
matrix_a	matrix_a	\N
\.


--
-- Data for Name: public_room_list_stream; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.public_room_list_stream (stream_id, room_id, visibility, appservice_id, network_id) FROM stdin;
\.


--
-- Data for Name: push_rules; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.push_rules (id, user_name, rule_id, priority_class, priority, conditions, actions) FROM stdin;
\.


--
-- Data for Name: push_rules_enable; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.push_rules_enable (id, user_name, rule_id, enabled) FROM stdin;
\.


--
-- Data for Name: push_rules_stream; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.push_rules_stream (stream_id, event_stream_ordering, user_id, rule_id, op, priority_class, priority, conditions, actions) FROM stdin;
\.


--
-- Data for Name: pusher_throttle; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.pusher_throttle (pusher, room_id, last_sent_ts, throttle_ms) FROM stdin;
\.


--
-- Data for Name: pushers; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.pushers (id, user_name, access_token, profile_tag, kind, app_id, app_display_name, device_display_name, pushkey, ts, lang, data, last_stream_ordering, last_success, failing_since) FROM stdin;
\.


--
-- Data for Name: ratelimit_override; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.ratelimit_override (user_id, messages_per_second, burst_count) FROM stdin;
\.


--
-- Data for Name: receipts_graph; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.receipts_graph (room_id, receipt_type, user_id, event_ids, data) FROM stdin;
!GNlLBsLXjbOuNhCkEO:localhost	m.read	@admin:localhost	["$vesveJhdimZ9d-Po76D8SZCUm8dVzl0GcQsvVX8lhos"]	{"ts":1672481640132,"hidden":false}
!MrxfbdodytWwBMqNiF:localhost	m.read	@admin:localhost	["$Nv-ymHeLYsZKVjdilAoBLGC4GlzNJWt1HBqtIlSIz1k"]	{"ts":1672481652600,"hidden":false}
!dKcbdDATuwwphjRPQP:localhost	m.read	@admin:localhost	["$NxuVtjeVql0_aadDlNux0yeeR_PxcpcJPnX1SdoDmXM"]	{"ts":1672481810647,"hidden":false}
!kmbTYjjsDRDHGgVqUP:localhost	m.read	@admin:localhost	["$opS4sT6APXaq4vDdegPq6ik1z-yX-FkMTAqhGtTWXEE"]	{"ts":1672481877904,"hidden":false}
!LwtGEdNVvQHvFLuWQB:localhost	m.read	@admin:localhost	["$O-kcGXcFLVtSNAY7CxqW4hLVBk0UqhADtIs1kCz8hlA"]	{"ts":1672482448998,"hidden":false}
!dKcbdDATuwwphjRPQP:localhost	m.read	@matrix_a:localhost	["$-QMfwsu75_SWJtzFqIsrFjLgl_XBqF6HcorcUjLTsWY"]	{"ts":1672482534300,"hidden":false}
!kmbTYjjsDRDHGgVqUP:localhost	m.read	@matrix_a:localhost	["$ZYEqhm3M07nXRAh1U842uZ1squBm9wa5H1Wb2-LjE1c"]	{"ts":1672482569449,"hidden":false}
!UKcoTBWWxNEyixrjyM:localhost	m.read	@matrix_a:localhost	["$-JWBJJpXpVo-YhtBYaJDTakzo94Jhn_XGlhnLzEWxyc"]	{"ts":1672482632877,"hidden":false}
\.


--
-- Data for Name: receipts_linearized; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.receipts_linearized (stream_id, room_id, receipt_type, user_id, event_id, data, instance_name) FROM stdin;
2	!GNlLBsLXjbOuNhCkEO:localhost	m.read	@admin:localhost	$vesveJhdimZ9d-Po76D8SZCUm8dVzl0GcQsvVX8lhos	{"ts":1672481640132,"hidden":false}	\N
3	!MrxfbdodytWwBMqNiF:localhost	m.read	@admin:localhost	$Nv-ymHeLYsZKVjdilAoBLGC4GlzNJWt1HBqtIlSIz1k	{"ts":1672481652600,"hidden":false}	\N
4	!dKcbdDATuwwphjRPQP:localhost	m.read	@admin:localhost	$NxuVtjeVql0_aadDlNux0yeeR_PxcpcJPnX1SdoDmXM	{"ts":1672481810647,"hidden":false}	\N
5	!kmbTYjjsDRDHGgVqUP:localhost	m.read	@admin:localhost	$opS4sT6APXaq4vDdegPq6ik1z-yX-FkMTAqhGtTWXEE	{"ts":1672481877904,"hidden":false}	\N
6	!LwtGEdNVvQHvFLuWQB:localhost	m.read	@admin:localhost	$O-kcGXcFLVtSNAY7CxqW4hLVBk0UqhADtIs1kCz8hlA	{"ts":1672482448998,"hidden":false}	\N
7	!dKcbdDATuwwphjRPQP:localhost	m.read	@matrix_a:localhost	$-QMfwsu75_SWJtzFqIsrFjLgl_XBqF6HcorcUjLTsWY	{"ts":1672482534300,"hidden":false}	\N
8	!kmbTYjjsDRDHGgVqUP:localhost	m.read	@matrix_a:localhost	$ZYEqhm3M07nXRAh1U842uZ1squBm9wa5H1Wb2-LjE1c	{"ts":1672482569449,"hidden":false}	\N
9	!UKcoTBWWxNEyixrjyM:localhost	m.read	@matrix_a:localhost	$-JWBJJpXpVo-YhtBYaJDTakzo94Jhn_XGlhnLzEWxyc	{"ts":1672482632877,"hidden":false}	\N
\.


--
-- Data for Name: received_transactions; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.received_transactions (transaction_id, origin, ts, response_code, response_json, has_been_referenced) FROM stdin;
\.


--
-- Data for Name: redactions; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.redactions (event_id, redacts, have_censored, received_ts) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.refresh_tokens (id, user_id, device_id, token, next_token_id) FROM stdin;
\.


--
-- Data for Name: registration_tokens; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.registration_tokens (token, uses_allowed, pending, completed, expiry_time) FROM stdin;
\.


--
-- Data for Name: rejections; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.rejections (event_id, reason, last_check) FROM stdin;
\.


--
-- Data for Name: remote_media_cache; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.remote_media_cache (media_origin, media_id, media_type, created_ts, upload_name, media_length, filesystem_id, last_access_ts, quarantined_by) FROM stdin;
\.


--
-- Data for Name: remote_media_cache_thumbnails; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.remote_media_cache_thumbnails (media_origin, media_id, thumbnail_width, thumbnail_height, thumbnail_method, thumbnail_type, thumbnail_length, filesystem_id) FROM stdin;
\.


--
-- Data for Name: remote_profile_cache; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.remote_profile_cache (user_id, displayname, avatar_url, last_check) FROM stdin;
\.


--
-- Data for Name: room_account_data; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_account_data (user_id, room_id, account_data_type, stream_id, content, instance_name) FROM stdin;
@bridgeuser1:localhost	!MrxfbdodytWwBMqNiF:localhost	m.fully_read	10	{"event_id":"$Nv-ymHeLYsZKVjdilAoBLGC4GlzNJWt1HBqtIlSIz1k"}	\N
@bridgeuser1:localhost	!UKcoTBWWxNEyixrjyM:localhost	m.fully_read	16	{"event_id":"$-JWBJJpXpVo-YhtBYaJDTakzo94Jhn_XGlhnLzEWxyc"}	\N
@bridgeadmin:localhost	!cwnFZrIkYIOvkCHJkc:localhost	m.fully_read	22	{"event_id":"$b_nOg7oeQd8bhYHe5kvgAdNM0U6hcAUFdf-yhgbItfc"}	\N
@bridgeadmin:localhost	!LwtGEdNVvQHvFLuWQB:localhost	m.fully_read	41	{"event_id":"$smbpaz4v1tYoI0ZZ-HXKXrcs19S7qioXa8ah6FeOBpc"}	\N
@bridgeadmin:localhost	!GNlLBsLXjbOuNhCkEO:localhost	m.fully_read	44	{"event_id":"$vesveJhdimZ9d-Po76D8SZCUm8dVzl0GcQsvVX8lhos"}	\N
@admin:localhost	!MrxfbdodytWwBMqNiF:localhost	m.fully_read	53	{"event_id":"$viSFX8RvY5fe8TiOaDirNG6PqooEHTTV3PT3hrQgVLA"}	\N
@admin:localhost	!nPrdOOfNMRrmJedabn:localhost	m.fully_read	58	{"event_id":"$usag8slAxKA2dWWERksMiBQ8hRwfGZ8nZzTfcymZxyE"}	\N
@admin:localhost	!dKcbdDATuwwphjRPQP:localhost	m.fully_read	64	{"event_id":"$-QMfwsu75_SWJtzFqIsrFjLgl_XBqF6HcorcUjLTsWY"}	\N
@admin:localhost	!kmbTYjjsDRDHGgVqUP:localhost	m.fully_read	68	{"event_id":"$ZYEqhm3M07nXRAh1U842uZ1squBm9wa5H1Wb2-LjE1c"}	\N
@admin:localhost	!LwtGEdNVvQHvFLuWQB:localhost	m.fully_read	74	{"event_id":"$WsVhQvsUsrFormgSdFA_Z_Io7y9fxZy5juqaM8oYpkg"}	\N
@admin:localhost	!GNlLBsLXjbOuNhCkEO:localhost	m.fully_read	76	{"event_id":"$r8P3KtaOOCBm8XKydsvp0N-cG5BAE1YKU5MumKzWUI8"}	\N
@matrix_a:localhost	!dKcbdDATuwwphjRPQP:localhost	m.fully_read	82	{"event_id":"$p0-tc7QWKDmREIJlluolf1RQ-uKnVDhx5d_JQY9PX5E"}	\N
@matrix_a:localhost	!kmbTYjjsDRDHGgVqUP:localhost	m.fully_read	86	{"event_id":"$GmUIImAeTzvNSV5qvb40ScXGL3dlsX4DDnmg28rkzk4"}	\N
@matrix_a:localhost	!UKcoTBWWxNEyixrjyM:localhost	m.fully_read	90	{"event_id":"$kwgJJLzgJAXgzd-lj8uFVnrjX5yqfNOtOcPrcl87hXU"}	\N
\.


--
-- Data for Name: room_alias_servers; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_alias_servers (room_alias, server) FROM stdin;
#town-square:localhost	localhost
#off-topic:localhost	localhost
#mittrum:localhost	localhost
\.


--
-- Data for Name: room_aliases; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_aliases (room_alias, room_id, creator) FROM stdin;
#town-square:localhost	!kmbTYjjsDRDHGgVqUP:localhost	@admin:localhost
#off-topic:localhost	!dKcbdDATuwwphjRPQP:localhost	@admin:localhost
#mittrum:localhost	!kAToIwhNWrDpgQVMfY:localhost	@bridgeadmin:localhost
\.


--
-- Data for Name: room_depth; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_depth (room_id, min_depth) FROM stdin;
!kmbTYjjsDRDHGgVqUP:localhost	1
!dKcbdDATuwwphjRPQP:localhost	1
!MrxfbdodytWwBMqNiF:localhost	1
!UKcoTBWWxNEyixrjyM:localhost	1
!kAToIwhNWrDpgQVMfY:localhost	1
!cwnFZrIkYIOvkCHJkc:localhost	1
!ffaaxOMHcWnINEXTWK:localhost	1
!LwtGEdNVvQHvFLuWQB:localhost	1
!GNlLBsLXjbOuNhCkEO:localhost	1
!nPrdOOfNMRrmJedabn:localhost	1
\.


--
-- Data for Name: room_memberships; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_memberships (event_id, user_id, sender, room_id, membership, forgotten, display_name, avatar_url) FROM stdin;
$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw	@admin:localhost	@admin:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	admin	\N
$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA	@admin:localhost	@admin:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	admin	\N
$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8	@matrix_a:localhost	@matrix_a:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	matrix_a	\N
$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0	@matrix_a:localhost	@matrix_a:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	matrix_a	\N
$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk	@matrix_b:localhost	@matrix_b:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	matrix_b	\N
$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0	@matrix_b:localhost	@matrix_b:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	matrix_b	\N
$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	@ignored_user:localhost	@ignored_user:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	ignored_user	\N
$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A	@ignored_user:localhost	@ignored_user:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	ignored_user	\N
$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok	@matterbot:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	Mattermost Bridge	\N
$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ	@matterbot:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	Mattermost Bridge	\N
$7TwPfUMTevEcf7wLvbgx3LG01lYT_yGudYiOVlkGU7E	@mm_mattermost_b:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	invite	0	mattermost_b [mm]	\N
$jAifmicJfMyB1QPFQ6KFQ7ZqTqQ58RJXsH5viWn3ZUg	@mm_mattermost_b:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	invite	0	mattermost_b [mm]	\N
$DsZXxk2rEIB2tF3pYUdOPjrMwclo8BXltutiWCnKUIU	@mm_mattermost_a:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	invite	0	MattermostUser A [mm]	\N
$NyVGoA-ZaMPbk_RzpmLOajRS1nEBirO7Du2KpA9Eo64	@mm_mattermost_a:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	invite	0	MattermostUser A [mm]	\N
$JwL8EK5sa4vg29tclnHwa5jrpCTa8oZVOIsgFyivQdY	@mm_mattermost_b:localhost	@mm_mattermost_b:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	mattermost_b [mm]	\N
$JcoTJcBGASUqIK9V7j6ND5Jt6P9gdbNJxXxQBZNg8z4	@mm_mattermost_b:localhost	@mm_mattermost_b:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	mattermost_b [mm]	\N
$2KnXfE3sZw8LDrOAaEP4HdQuw5neshhvyZKtnwo5cg0	@mm_mattermost_a:localhost	@mm_mattermost_a:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	MattermostUser A [mm]	\N
$isXWKf_B_7Z7R7jYn_2gZB-U31TuzMehBRxj5701Lq8	@mm_mattermost_a:localhost	@mm_mattermost_a:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	MattermostUser A [mm]	\N
$rVK77mVSpz5EHxI2mbLxilqbkLxKhXEiusPFjapVPbw	@mm_mattermost_a_:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	invite	0	MattermostUser A [mm]	\N
$5agO4kI6VqJHGKvKbkqUa2Y3cTwUBrjAhmCVtj9JmKU	@mm_mattermost_b_:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	invite	0	mattermost_b [mm]	\N
$4JiNeQHyMbyuEfymLkE-SEzPUh3bWddjxa6-5w36nJw	@mm_matrix_matrix_b:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	invite	0	matrix_b [mm]	\N
$Y_S-fF0iLu0OHNMcZdYVzt0we_qL_t8_4QIKGeobLdI	@mm_matrix_matrix_a:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	invite	0	Matrix UserA [mm]	\N
$g1kV-jEZBtN9l6VGGo2MN-wQn7RR7J-Tv5LfyJ5Z5fc	@mm_matrix_matrix_a:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	invite	0	Matrix UserA [mm]	\N
$CQg_jKvdpWFvaiLH2f5MtTnu1Zwxi8P4QPSJZum91dw	@mm_mattermost_a_:localhost	@mm_mattermost_a_:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	MattermostUser A [mm]	\N
$OcvCF7YNeTKFnzz4EWVjFJIF9QidMEUmomHIvH3d2W8	@mm_mattermost_b_:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	invite	0	mattermost_b [mm]	\N
$GrqoJ52XSgRaoc4wPEYLdL2p6t3jl0aiFd8bYswQQcU	@mm_matrix_matrix_b:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	invite	0	matrix_b [mm]	\N
$5TE1hAtSTolrY9QTj9Wt8DnKurFa3P6KIfGkWOJbrY4	@mm_mattermost_a_:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	invite	0	MattermostUser A [mm]	\N
$UYXKiTPqFr31PwoZzi35ODpdRK0hwJVjVGC1N7kR7yk	@mm_mattermost_b_:localhost	@mm_mattermost_b_:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	mattermost_b [mm]	\N
$YFCWkh6b_jgrSjje7vt6JB6-uLPRz7Na1VgGh0PwdI8	@mm_matrix_matrix_b:localhost	@mm_matrix_matrix_b:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	matrix_b [mm]	\N
$h2yGPxzdKWUBUSFQiOgFiRoNa8NgWHYXdy_2SMJx6ns	@mm_matrix_matrix_a:localhost	@mm_matrix_matrix_a:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	Matrix UserA [mm]	\N
$kmvnPONhcKxIpG62sV6apngYToshpP0mBrwpKL0hAOI	@mm_matrix_matrix_a:localhost	@mm_matrix_matrix_a:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	Matrix UserA [mm]	\N
$KgpvpFIMQIVFvm0adBZqAbWANmMgdu1_1jbP71RuM48	@mm_matrix_matrix_b:localhost	@mm_matrix_matrix_b:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	matrix_b [mm]	\N
$qWi32T1tK2APgSwc4y_6f0e_N_fUPmIBxC5ACk1h6NM	@mm_mattermost_b_:localhost	@mm_mattermost_b_:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	mattermost_b [mm]	\N
$jvwVmkElpx8M62JlaBz7nJ4qa2U8tVO7V9-HhJ-n8JI	@mm_mattermost_b:localhost	@mm_mattermost_b:localhost	!kmbTYjjsDRDHGgVqUP:localhost	leave	0	\N	\N
$0WsTO-QKZzqtMdl5UwGJc5h4e7YAE5ZGp_GDMb9K824	@mm_mattermost_a_:localhost	@mm_mattermost_a_:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	MattermostUser A [mm]	\N
$l5dYt-R2kpcKdlmMRFnzC5N9PjiV4DZ63c1bTGPOCXk	@mm_mattermost_b:localhost	@mm_mattermost_b:localhost	!dKcbdDATuwwphjRPQP:localhost	leave	0	\N	\N
$opS4sT6APXaq4vDdegPq6ik1z-yX-FkMTAqhGtTWXEE	@mm_mattermost_a:localhost	@mm_mattermost_a:localhost	!kmbTYjjsDRDHGgVqUP:localhost	leave	0	\N	\N
$NxuVtjeVql0_aadDlNux0yeeR_PxcpcJPnX1SdoDmXM	@mm_mattermost_a:localhost	@mm_mattermost_a:localhost	!dKcbdDATuwwphjRPQP:localhost	leave	0	\N	\N
$89n67RlAmtb8nRuxie-oq3g9grnkpjzJMAhbJ8h_8Xw	@bridgeuser1:localhost	@bridgeuser1:localhost	!MrxfbdodytWwBMqNiF:localhost	join	0	bridgeuser1	\N
$V_QrTFMCwHlrg-MSVVplcYCRVWM_QgXhIvp-2R_LtHI	@admin:localhost	@bridgeuser1:localhost	!MrxfbdodytWwBMqNiF:localhost	invite	0	Admin User	\N
$sqtTmHJJ_e6UeDKORkztLzcGXYNZpKgoa1v2ir5yr-w	@bridgeuser1:localhost	@bridgeuser1:localhost	!UKcoTBWWxNEyixrjyM:localhost	join	0	bridgeuser1	\N
$sdrkpiq94MhqjrSukg-aexI_3VlPxcoqiZXmrPvpQGw	@matrix_a:localhost	@bridgeuser1:localhost	!UKcoTBWWxNEyixrjyM:localhost	invite	0	Matrix UserA	\N
$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE	@bridgeadmin:localhost	@bridgeadmin:localhost	!kAToIwhNWrDpgQVMfY:localhost	join	0	bridgeadmin	\N
$81gCIX2tUwDG_Jg02kHVceEfsUG1IOQ9-YnDk1cV15w	@bridgeadmin:localhost	@bridgeadmin:localhost	!ffaaxOMHcWnINEXTWK:localhost	join	0	bridgeadmin	\N
$41BPCZJ_9IbE7VgIqxEef1X7U2-FXJjTA25i2Q-n_gg	@bridgeadmin:localhost	@bridgeadmin:localhost	!cwnFZrIkYIOvkCHJkc:localhost	join	0	bridgeadmin	\N
$bFxX1nACgPihIeXfSiWHmW_hxrfmIgtQM9HWAPS2wVY	@matrix_a:localhost	@bridgeadmin:localhost	!kAToIwhNWrDpgQVMfY:localhost	invite	0	Matrix UserA	\N
$kL3ALUeGobajxL55gzYoIZLdD1CSD4sYXedIOysHwV0	@matrix_b:localhost	@bridgeadmin:localhost	!kAToIwhNWrDpgQVMfY:localhost	invite	0	matrix_b	\N
$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic	@bridgeadmin:localhost	@bridgeadmin:localhost	!LwtGEdNVvQHvFLuWQB:localhost	join	0	bridgeadmin	\N
$TbFvVskFwRsxEgjNnOjfs4ljMJuZC60_Cqb91vOUrxg	@admin:localhost	@bridgeadmin:localhost	!LwtGEdNVvQHvFLuWQB:localhost	invite	0	Admin User	\N
$yrfdAmX0K0lY65Dm9bViRYWOBKtvTB1kxkm6lNsThdw	@bridgeadmin:localhost	@bridgeadmin:localhost	!GNlLBsLXjbOuNhCkEO:localhost	join	0	bridgeadmin	\N
$vesveJhdimZ9d-Po76D8SZCUm8dVzl0GcQsvVX8lhos	@admin:localhost	@bridgeadmin:localhost	!GNlLBsLXjbOuNhCkEO:localhost	invite	0	Admin User	\N
$nfronhC7iKGPRmKJ7zoXzYG7VKiOq5FoUIcfHg3a4Dg	@admin:localhost	@admin:localhost	!GNlLBsLXjbOuNhCkEO:localhost	join	0	admin	\N
$Pem9TyngNuhpIq_NI2krx6wpkVigoBj6JCeB3WUezVk	@admin:localhost	@admin:localhost	!MrxfbdodytWwBMqNiF:localhost	join	0	admin	\N
$AMnH95Ky85GttLR7j9XHrHyULlBBezFJ9w8mtji-7Ok	@admin:localhost	@admin:localhost	!nPrdOOfNMRrmJedabn:localhost	join	0	admin	\N
$usag8slAxKA2dWWERksMiBQ8hRwfGZ8nZzTfcymZxyE	@bridgeuser1:localhost	@admin:localhost	!nPrdOOfNMRrmJedabn:localhost	invite	0	bridgeuser1	\N
$O04OV5x9R_5W2IT9G9Z-dXJmfV6fgtZM8-4ogFp9rEw	@bridgeadmin:localhost	@admin:localhost	!dKcbdDATuwwphjRPQP:localhost	invite	0	bridgeadmin	\N
$-QMfwsu75_SWJtzFqIsrFjLgl_XBqF6HcorcUjLTsWY	@bridgeuser1:localhost	@admin:localhost	!dKcbdDATuwwphjRPQP:localhost	invite	0	bridgeuser1	\N
$WsVhQvsUsrFormgSdFA_Z_Io7y9fxZy5juqaM8oYpkg	@admin:localhost	@admin:localhost	!LwtGEdNVvQHvFLuWQB:localhost	join	0	admin	\N
$hooKnajA7nQRs3MZDj_evGyHCyHpg4QmGp2i5WRKzp0	@matrix_a:localhost	@matrix_a:localhost	!UKcoTBWWxNEyixrjyM:localhost	join	0	matrix_a	\N
$rNG4YvsFCU9LVcVcHEkbBRGSuEH_QqO_hMEZ-sC8WH8	@matrix_a:localhost	@matrix_a:localhost	!kAToIwhNWrDpgQVMfY:localhost	join	0	matrix_a	\N
\.


--
-- Data for Name: room_retention; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_retention (room_id, event_id, min_lifetime, max_lifetime) FROM stdin;
\.


--
-- Data for Name: room_stats_current; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_stats_current (room_id, current_state_events, joined_members, invited_members, left_members, banned_members, local_users_in_room, completed_delta_stream_id, knocked_members) FROM stdin;
!kmbTYjjsDRDHGgVqUP:localhost	16	9	0	2	0	9	48	0
!GNlLBsLXjbOuNhCkEO:localhost	8	2	0	0	0	2	115	0
!MrxfbdodytWwBMqNiF:localhost	9	2	0	0	0	2	127	0
!nPrdOOfNMRrmJedabn:localhost	8	1	1	0	0	1	128	0
!dKcbdDATuwwphjRPQP:localhost	18	9	2	2	0	9	130	0
!LwtGEdNVvQHvFLuWQB:localhost	9	2	0	0	0	2	133	0
!UKcoTBWWxNEyixrjyM:localhost	7	2	0	0	0	2	137	0
!kAToIwhNWrDpgQVMfY:localhost	13	2	1	0	0	2	139	0
!ffaaxOMHcWnINEXTWK:localhost	8	1	0	0	0	1	89	0
!cwnFZrIkYIOvkCHJkc:localhost	8	1	0	0	0	1	90	0
\.


--
-- Data for Name: room_stats_earliest_token; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_stats_earliest_token (room_id, token) FROM stdin;
\.


--
-- Data for Name: room_stats_historical; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_stats_historical (room_id, end_ts, bucket_size, current_state_events, joined_members, invited_members, left_members, banned_members, local_users_in_room, total_events, total_event_bytes, knocked_members) FROM stdin;
!kmbTYjjsDRDHGgVqUP:localhost	1598745600000	86400000	9	4	0	0	0	4	9	6709	\N
!dKcbdDATuwwphjRPQP:localhost	1598745600000	86400000	9	4	0	0	0	4	9	6707	\N
\.


--
-- Data for Name: room_stats_state; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_stats_state (room_id, name, canonical_alias, join_rules, history_visibility, encryption, avatar, guest_access, is_federatable, topic) FROM stdin;
!dKcbdDATuwwphjRPQP:localhost	\N	#off-topic:localhost	public	shared	\N	\N	\N	t	\N
!kmbTYjjsDRDHGgVqUP:localhost	\N	#town-square:localhost	public	shared	\N	\N	\N	t	\N
!UKcoTBWWxNEyixrjyM:localhost	\N	\N	invite	shared	\N	\N	can_join	t	\N
!kAToIwhNWrDpgQVMfY:localhost	Mittrum	#mittrum:localhost	public	world_readable	\N	\N	can_join	t	
!ffaaxOMHcWnINEXTWK:localhost	Slumpmässig	\N	public	world_readable	\N	\N	can_join	t	\N
!cwnFZrIkYIOvkCHJkc:localhost	Allmänt	\N	public	world_readable	\N	\N	can_join	t	\N
!LwtGEdNVvQHvFLuWQB:localhost	\N	\N	invite	shared	m.megolm.v1.aes-sha2	\N	can_join	t	\N
!GNlLBsLXjbOuNhCkEO:localhost	\N	\N	invite	shared	m.megolm.v1.aes-sha2	\N	can_join	t	\N
!MrxfbdodytWwBMqNiF:localhost	\N	\N	invite	shared	m.megolm.v1.aes-sha2	\N	can_join	t	\N
!nPrdOOfNMRrmJedabn:localhost	\N	\N	invite	shared	m.megolm.v1.aes-sha2	\N	can_join	t	\N
\.


--
-- Data for Name: room_tags; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_tags (user_id, room_id, tag, content) FROM stdin;
\.


--
-- Data for Name: room_tags_revisions; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_tags_revisions (user_id, room_id, stream_id, instance_name) FROM stdin;
\.


--
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.rooms (room_id, is_public, creator, room_version, has_auth_chain_index) FROM stdin;
!dKcbdDATuwwphjRPQP:localhost	f	@admin:localhost	5	t
!kmbTYjjsDRDHGgVqUP:localhost	f	@admin:localhost	5	t
!MrxfbdodytWwBMqNiF:localhost	f	@bridgeuser1:localhost	6	t
!UKcoTBWWxNEyixrjyM:localhost	f	@bridgeuser1:localhost	6	t
!kAToIwhNWrDpgQVMfY:localhost	f	@bridgeadmin:localhost	6	t
!ffaaxOMHcWnINEXTWK:localhost	f	@bridgeadmin:localhost	6	t
!cwnFZrIkYIOvkCHJkc:localhost	f	@bridgeadmin:localhost	6	t
!LwtGEdNVvQHvFLuWQB:localhost	f	@bridgeadmin:localhost	6	t
!GNlLBsLXjbOuNhCkEO:localhost	f	@bridgeadmin:localhost	9	t
!nPrdOOfNMRrmJedabn:localhost	f	@admin:localhost	9	t
\.


--
-- Data for Name: schema_compat_version; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.schema_compat_version (lock, compat_version) FROM stdin;
X	60
\.


--
-- Data for Name: schema_version; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.schema_version (lock, version, upgraded) FROM stdin;
X	65	t
\.


--
-- Data for Name: server_keys_json; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.server_keys_json (server_name, key_id, from_server, ts_added_ms, ts_valid_until_ms, key_json) FROM stdin;
\.


--
-- Data for Name: server_signature_keys; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.server_signature_keys (server_name, key_id, from_server, ts_added_ms, verify_key, ts_valid_until_ms) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.sessions (session_type, session_id, value, expiry_time_ms) FROM stdin;
\.


--
-- Data for Name: state_events; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.state_events (event_id, room_id, type, state_key, prev_state) FROM stdin;
$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost	m.room.create		\N
$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@admin:localhost	\N
$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost	m.room.power_levels		\N
$X8tdoEsXAgBC6gobCepAn3rwO8CJoQU6i9NN9Rzhukg	!kmbTYjjsDRDHGgVqUP:localhost	m.room.canonical_alias		\N
$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost	m.room.join_rules		\N
$O5iO4EII22igkDq5cMKHFB-SGIYD0KqJQXZohS2Dzc0	!kmbTYjjsDRDHGgVqUP:localhost	m.room.history_visibility		\N
$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost	m.room.create		\N
$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@admin:localhost	\N
$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost	m.room.power_levels		\N
$b__a7rX3L5YpX7nAZte73DAbjtXZK48JH8VKSnGOKKw	!dKcbdDATuwwphjRPQP:localhost	m.room.canonical_alias		\N
$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost	m.room.join_rules		\N
$TVnvv0nGbLydCBtMmTTz-htMsoI4hmxCr3s9AHyFGHQ	!dKcbdDATuwwphjRPQP:localhost	m.room.history_visibility		\N
$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_a:localhost	\N
$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	\N
$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_b:localhost	\N
$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_b:localhost	\N
$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@ignored_user:localhost	\N
$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@ignored_user:localhost	\N
$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	\N
$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	\N
$7TwPfUMTevEcf7wLvbgx3LG01lYT_yGudYiOVlkGU7E	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$jAifmicJfMyB1QPFQ6KFQ7ZqTqQ58RJXsH5viWn3ZUg	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$DsZXxk2rEIB2tF3pYUdOPjrMwclo8BXltutiWCnKUIU	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$NyVGoA-ZaMPbk_RzpmLOajRS1nEBirO7Du2KpA9Eo64	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$JwL8EK5sa4vg29tclnHwa5jrpCTa8oZVOIsgFyivQdY	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$JcoTJcBGASUqIK9V7j6ND5Jt6P9gdbNJxXxQBZNg8z4	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$2KnXfE3sZw8LDrOAaEP4HdQuw5neshhvyZKtnwo5cg0	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$isXWKf_B_7Z7R7jYn_2gZB-U31TuzMehBRxj5701Lq8	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$rVK77mVSpz5EHxI2mbLxilqbkLxKhXEiusPFjapVPbw	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a_:localhost	\N
$5agO4kI6VqJHGKvKbkqUa2Y3cTwUBrjAhmCVtj9JmKU	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b_:localhost	\N
$4JiNeQHyMbyuEfymLkE-SEzPUh3bWddjxa6-5w36nJw	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_matrix_matrix_b:localhost	\N
$Y_S-fF0iLu0OHNMcZdYVzt0we_qL_t8_4QIKGeobLdI	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_matrix_matrix_a:localhost	\N
$g1kV-jEZBtN9l6VGGo2MN-wQn7RR7J-Tv5LfyJ5Z5fc	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_matrix_matrix_a:localhost	\N
$CQg_jKvdpWFvaiLH2f5MtTnu1Zwxi8P4QPSJZum91dw	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a_:localhost	\N
$OcvCF7YNeTKFnzz4EWVjFJIF9QidMEUmomHIvH3d2W8	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b_:localhost	\N
$GrqoJ52XSgRaoc4wPEYLdL2p6t3jl0aiFd8bYswQQcU	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_matrix_matrix_b:localhost	\N
$5TE1hAtSTolrY9QTj9Wt8DnKurFa3P6KIfGkWOJbrY4	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a_:localhost	\N
$UYXKiTPqFr31PwoZzi35ODpdRK0hwJVjVGC1N7kR7yk	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b_:localhost	\N
$YFCWkh6b_jgrSjje7vt6JB6-uLPRz7Na1VgGh0PwdI8	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_matrix_matrix_b:localhost	\N
$h2yGPxzdKWUBUSFQiOgFiRoNa8NgWHYXdy_2SMJx6ns	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_matrix_matrix_a:localhost	\N
$kmvnPONhcKxIpG62sV6apngYToshpP0mBrwpKL0hAOI	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_matrix_matrix_a:localhost	\N
$KgpvpFIMQIVFvm0adBZqAbWANmMgdu1_1jbP71RuM48	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_matrix_matrix_b:localhost	\N
$qWi32T1tK2APgSwc4y_6f0e_N_fUPmIBxC5ACk1h6NM	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b_:localhost	\N
$jvwVmkElpx8M62JlaBz7nJ4qa2U8tVO7V9-HhJ-n8JI	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$0WsTO-QKZzqtMdl5UwGJc5h4e7YAE5ZGp_GDMb9K824	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a_:localhost	\N
$opS4sT6APXaq4vDdegPq6ik1z-yX-FkMTAqhGtTWXEE	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$l5dYt-R2kpcKdlmMRFnzC5N9PjiV4DZ63c1bTGPOCXk	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$NxuVtjeVql0_aadDlNux0yeeR_PxcpcJPnX1SdoDmXM	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY	!MrxfbdodytWwBMqNiF:localhost	m.room.create		\N
$89n67RlAmtb8nRuxie-oq3g9grnkpjzJMAhbJ8h_8Xw	!MrxfbdodytWwBMqNiF:localhost	m.room.member	@bridgeuser1:localhost	\N
$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA	!MrxfbdodytWwBMqNiF:localhost	m.room.power_levels		\N
$TVXtgqtZ5WfNfZEnJQx6m0NYwp0_34ylOK87XzZ3JlI	!MrxfbdodytWwBMqNiF:localhost	m.room.join_rules		\N
$JQ7PDbgzTTAY5uHFM6NV0ovadfzQLOpcAcrSX5mRUi0	!MrxfbdodytWwBMqNiF:localhost	m.room.history_visibility		\N
$9MVFB3q88VYxhDZMX087Uv4c3h3uEpluJN0q33ubtso	!MrxfbdodytWwBMqNiF:localhost	m.room.guest_access		\N
$V_QrTFMCwHlrg-MSVVplcYCRVWM_QgXhIvp-2R_LtHI	!MrxfbdodytWwBMqNiF:localhost	m.room.member	@admin:localhost	\N
$yZwQJfxjuLFOlfyTYw-M1aupZjmck-aVfpfSYx5fj1I	!UKcoTBWWxNEyixrjyM:localhost	m.room.create		\N
$sqtTmHJJ_e6UeDKORkztLzcGXYNZpKgoa1v2ir5yr-w	!UKcoTBWWxNEyixrjyM:localhost	m.room.member	@bridgeuser1:localhost	\N
$EsIKBNaGky9gjqListPEKjQfFScHFrG5GuEQD0vyi9Q	!UKcoTBWWxNEyixrjyM:localhost	m.room.power_levels		\N
$STt_lRcQQY1HR2YQmv4RsQMis1Xc5sWAamnHn02ddqk	!UKcoTBWWxNEyixrjyM:localhost	m.room.join_rules		\N
$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE	!kAToIwhNWrDpgQVMfY:localhost	m.room.member	@bridgeadmin:localhost	\N
$41BPCZJ_9IbE7VgIqxEef1X7U2-FXJjTA25i2Q-n_gg	!cwnFZrIkYIOvkCHJkc:localhost	m.room.member	@bridgeadmin:localhost	\N
$v_Jh2P1U7Li3ATyMsxgipoyBuQRYv5HD-cv8JVNpdLc	!kAToIwhNWrDpgQVMfY:localhost	m.space.child	!cwnFZrIkYIOvkCHJkc:localhost	\N
$KEhwfKMs0OrXZWYNQWK_YDu-mrG-UP2Do2VsAShloEY	!UKcoTBWWxNEyixrjyM:localhost	m.room.history_visibility		\N
$em_2PzgnditDYAzn8yY84PnmN1oNQZgI8Co6SjahtU8	!UKcoTBWWxNEyixrjyM:localhost	m.room.guest_access		\N
$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw	!kAToIwhNWrDpgQVMfY:localhost	m.room.create		\N
$AXgBEWEnQYL0m4F3qNGi4DDk7afIQe7a_hmRdZkAZLM	!cwnFZrIkYIOvkCHJkc:localhost	m.room.create		\N
$sdrkpiq94MhqjrSukg-aexI_3VlPxcoqiZXmrPvpQGw	!UKcoTBWWxNEyixrjyM:localhost	m.room.member	@matrix_a:localhost	\N
$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc	!kAToIwhNWrDpgQVMfY:localhost	m.room.power_levels		\N
$fZAJc_jo3uwpjSNh7ULQOuzuMtHLVO8KdmygXkq-95M	!kAToIwhNWrDpgQVMfY:localhost	m.room.canonical_alias		\N
$KGv2op0D-6TOpQuqb5Gl4YZxMUKn37cUNSylMiEo7SA	!kAToIwhNWrDpgQVMfY:localhost	m.room.join_rules		\N
$XvSaPVUaER3JwP1gLc-c__oVTIjGs5YL10o0DSsZ3q0	!kAToIwhNWrDpgQVMfY:localhost	m.room.guest_access		\N
$zHrY9OvLbZTtN0bNPCDJg1HsmkgSV-pzAmxVIqaSB98	!kAToIwhNWrDpgQVMfY:localhost	m.room.history_visibility		\N
$Np7HQ3SdNiYX3HhRJtJw4b80J96uY_IbqI_bL7w83m0	!kAToIwhNWrDpgQVMfY:localhost	m.room.name		\N
$nL-1meDVcMfCo41V5V5w3EBPwNdmll7Alfsp00QCHvk	!kAToIwhNWrDpgQVMfY:localhost	m.room.topic		\N
$wTlWqRh3eGNrru9CGqbzkNcL0kBGbtEB8sHZwsAboS0	!ffaaxOMHcWnINEXTWK:localhost	m.room.create		\N
$81gCIX2tUwDG_Jg02kHVceEfsUG1IOQ9-YnDk1cV15w	!ffaaxOMHcWnINEXTWK:localhost	m.room.member	@bridgeadmin:localhost	\N
$pn5NPm28AfF5_169OnQQxTv4_ijcoN4k44UIvzGsN7k	!ffaaxOMHcWnINEXTWK:localhost	m.room.power_levels		\N
$PJZugFD-K6RtTB0vNzX1j0YFLZ9x4vli99YpMY9dzQk	!cwnFZrIkYIOvkCHJkc:localhost	m.room.power_levels		\N
$jLK4KwpKxGfwbMdz2oJbuUlHegeZ_5YucIy2ChSNCLg	!ffaaxOMHcWnINEXTWK:localhost	m.room.join_rules		\N
$ce28aY-iB2mpb8Gioxn_S-YFJtBn3dK4JRguWv9H2XY	!cwnFZrIkYIOvkCHJkc:localhost	m.room.join_rules		\N
$Jy6RZhO0nZ0x_EgWugfJHW0XgWaR5DoWVaImG_wE3lg	!ffaaxOMHcWnINEXTWK:localhost	m.room.guest_access		\N
$3ccBKAI_RT742spGFKzsNSBIzhj7WC7YBxugrDvyr4w	!cwnFZrIkYIOvkCHJkc:localhost	m.room.guest_access		\N
$zxy8zKV-5WiZDQEOGVCLyrd2yGWyYrOah4vQYAlc-xI	!ffaaxOMHcWnINEXTWK:localhost	m.space.parent	!kAToIwhNWrDpgQVMfY:localhost	\N
$7CUacT0Q8hFhLt80ecyLwLrizW7Jh6uNtLYApZIgNg4	!cwnFZrIkYIOvkCHJkc:localhost	m.space.parent	!kAToIwhNWrDpgQVMfY:localhost	\N
$e4RXblgeP3Sa0Hs3COmGOAFe9LclWYCrLIk7nF2PEDk	!ffaaxOMHcWnINEXTWK:localhost	m.room.history_visibility		\N
$dLHdIN5p2aRYI16qULeP30FhKh5GGtUHvQUzWcSWyTA	!cwnFZrIkYIOvkCHJkc:localhost	m.room.history_visibility		\N
$tWJ40KRMdaZwn6df_597mz_AyHLHUSEy0noQk3HlctY	!ffaaxOMHcWnINEXTWK:localhost	m.room.name		\N
$ab5rFOQQuDGj00oHfJaJKURhG6lNFNDKS0nkBlsLTMk	!cwnFZrIkYIOvkCHJkc:localhost	m.room.name		\N
$BNEpFvlxqdDF-6u3EPToNgfx0BuYX2_P9oWB486xTxM	!kAToIwhNWrDpgQVMfY:localhost	m.space.child	!ffaaxOMHcWnINEXTWK:localhost	\N
$bFxX1nACgPihIeXfSiWHmW_hxrfmIgtQM9HWAPS2wVY	!kAToIwhNWrDpgQVMfY:localhost	m.room.member	@matrix_a:localhost	\N
$kL3ALUeGobajxL55gzYoIZLdD1CSD4sYXedIOysHwV0	!kAToIwhNWrDpgQVMfY:localhost	m.room.member	@matrix_b:localhost	\N
$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q	!LwtGEdNVvQHvFLuWQB:localhost	m.room.create		\N
$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic	!LwtGEdNVvQHvFLuWQB:localhost	m.room.member	@bridgeadmin:localhost	\N
$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k	!LwtGEdNVvQHvFLuWQB:localhost	m.room.power_levels		\N
$PTHh0FcsZLrplrmwtCyvLjXr1yAZRgovFGLVt7qrrAo	!LwtGEdNVvQHvFLuWQB:localhost	m.room.join_rules		\N
$6CLZCTGtpIVnohQDg2sJwn_880f0--zCZpr6BgOwQ2Q	!LwtGEdNVvQHvFLuWQB:localhost	m.room.history_visibility		\N
$nKXxWIIoo5Vko9Z7kITUEeAsQgQnr-FLvhoQHfkCYAE	!LwtGEdNVvQHvFLuWQB:localhost	m.room.guest_access		\N
$TbFvVskFwRsxEgjNnOjfs4ljMJuZC60_Cqb91vOUrxg	!LwtGEdNVvQHvFLuWQB:localhost	m.room.member	@admin:localhost	\N
$SuM_AupYZSEtAJBPHbvNkhJ4aIYEjT4c741wzkoOX4I	!LwtGEdNVvQHvFLuWQB:localhost	m.room.encryption		\N
$_-6CgruWK6UfiL1rgJnNUgtmp_jusf_3Vf7LUPB6xaU	!GNlLBsLXjbOuNhCkEO:localhost	m.room.create		\N
$yrfdAmX0K0lY65Dm9bViRYWOBKtvTB1kxkm6lNsThdw	!GNlLBsLXjbOuNhCkEO:localhost	m.room.member	@bridgeadmin:localhost	\N
$uKKFUGwf_IAnbH81DTvAScd2HFnAwWWL_p4-E5B_YdU	!GNlLBsLXjbOuNhCkEO:localhost	m.room.power_levels		\N
$MRytSYI-n7aCgzUssVx9vLIC5Y-Yt22y_L1eQoE4GgE	!GNlLBsLXjbOuNhCkEO:localhost	m.room.encryption		\N
$ah5gH_XfCIYeCtl2NFxHSgdd_OE6O9tHe2U1Pn2Qvhc	!GNlLBsLXjbOuNhCkEO:localhost	m.room.guest_access		\N
$lnpmPOjrFoaPq58156r6g4G7gYfejQ2BfcFkjGiEX-I	!GNlLBsLXjbOuNhCkEO:localhost	m.room.history_visibility		\N
$fuvIFJYv32qkEsYyW8XNHbQ0hmQ5HHRjF6UEjte6Z-c	!GNlLBsLXjbOuNhCkEO:localhost	m.room.join_rules		\N
$smbpaz4v1tYoI0ZZ-HXKXrcs19S7qioXa8ah6FeOBpc	!LwtGEdNVvQHvFLuWQB:localhost	m.room.tombstone		\N
$O-kcGXcFLVtSNAY7CxqW4hLVBk0UqhADtIs1kCz8hlA	!LwtGEdNVvQHvFLuWQB:localhost	m.room.power_levels		\N
$vesveJhdimZ9d-Po76D8SZCUm8dVzl0GcQsvVX8lhos	!GNlLBsLXjbOuNhCkEO:localhost	m.room.member	@admin:localhost	\N
$nfronhC7iKGPRmKJ7zoXzYG7VKiOq5FoUIcfHg3a4Dg	!GNlLBsLXjbOuNhCkEO:localhost	m.room.member	@admin:localhost	\N
$Pem9TyngNuhpIq_NI2krx6wpkVigoBj6JCeB3WUezVk	!MrxfbdodytWwBMqNiF:localhost	m.room.member	@admin:localhost	\N
$viSFX8RvY5fe8TiOaDirNG6PqooEHTTV3PT3hrQgVLA	!MrxfbdodytWwBMqNiF:localhost	m.room.encryption		\N
$A5h106ytjQ2qqPxkSylhOkJgVZQCscB4QX0PK60qxU0	!nPrdOOfNMRrmJedabn:localhost	m.room.create		\N
$AMnH95Ky85GttLR7j9XHrHyULlBBezFJ9w8mtji-7Ok	!nPrdOOfNMRrmJedabn:localhost	m.room.member	@admin:localhost	\N
$gDW6j_UqhvIRf1ANEKurSD9fB4Hl4YnQ5uL9cy_U7Os	!nPrdOOfNMRrmJedabn:localhost	m.room.power_levels		\N
$0gszMJtyESzwVMh4olwTajdbj1MrrJYVnylO0yOIpSg	!nPrdOOfNMRrmJedabn:localhost	m.room.join_rules		\N
$2lEnFzGdtIu4kGthBBXcP0gW6sUWKP8c1x9I4-yFWso	!nPrdOOfNMRrmJedabn:localhost	m.room.history_visibility		\N
$yfuDQBYjEI6CCa3AdtfdjL_ZXIR0d92TRfHnh7Gq0zc	!nPrdOOfNMRrmJedabn:localhost	m.room.guest_access		\N
$xyV3lysb-dda01bB4LpALdmaTC_mLZDhwxOE9L4zpXY	!nPrdOOfNMRrmJedabn:localhost	m.room.encryption		\N
$MT4EKTmcPC8LCVeATiG-5a71N2Zc1vNQcgKge5W0on8	!MrxfbdodytWwBMqNiF:localhost	m.room.tombstone		\N
$eOC3-FZNb3jb3NisHG61gQhQ_hf9zWu0xvpfs8ZKDTg	!MrxfbdodytWwBMqNiF:localhost	m.room.power_levels		\N
$usag8slAxKA2dWWERksMiBQ8hRwfGZ8nZzTfcymZxyE	!nPrdOOfNMRrmJedabn:localhost	m.room.member	@bridgeuser1:localhost	\N
$O04OV5x9R_5W2IT9G9Z-dXJmfV6fgtZM8-4ogFp9rEw	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@bridgeadmin:localhost	\N
$-QMfwsu75_SWJtzFqIsrFjLgl_XBqF6HcorcUjLTsWY	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@bridgeuser1:localhost	\N
$WsVhQvsUsrFormgSdFA_Z_Io7y9fxZy5juqaM8oYpkg	!LwtGEdNVvQHvFLuWQB:localhost	m.room.member	@admin:localhost	\N
$hooKnajA7nQRs3MZDj_evGyHCyHpg4QmGp2i5WRKzp0	!UKcoTBWWxNEyixrjyM:localhost	m.room.member	@matrix_a:localhost	\N
$rNG4YvsFCU9LVcVcHEkbBRGSuEH_QqO_hMEZ-sC8WH8	!kAToIwhNWrDpgQVMfY:localhost	m.room.member	@matrix_a:localhost	\N
\.


--
-- Data for Name: state_group_edges; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.state_group_edges (state_group, prev_state_group) FROM stdin;
2	1
3	2
4	3
5	4
6	5
7	6
9	8
10	9
11	10
12	11
13	12
14	13
15	7
16	14
17	15
18	16
19	17
20	18
21	20
22	19
23	21
24	22
25	23
26	24
27	25
28	26
29	27
30	28
31	30
32	29
33	29
34	30
35	29
36	29
37	29
38	30
39	29
40	29
41	30
42	29
43	30
44	29
45	30
46	30
47	30
48	30
49	29
50	30
51	30
52	29
53	30
54	30
55	29
56	30
57	30
58	29
59	29
60	30
61	29
62	30
63	29
64	30
65	29
66	29
67	29
68	30
69	30
70	69
71	29
72	70
73	71
74	72
75	73
76	74
77	75
78	76
79	77
80	78
81	79
82	80
83	81
84	82
85	83
86	84
87	85
88	87
90	89
91	90
92	91
93	92
94	93
95	94
96	95
98	97
99	98
100	99
101	100
102	101
103	102
104	103
106	105
107	106
108	107
109	108
110	109
111	110
112	111
113	112
114	113
116	115
118	117
119	116
120	118
121	119
122	120
123	121
124	122
126	123
125	124
127	125
128	126
129	128
130	127
131	129
132	130
133	114
134	114
135	133
136	135
137	136
139	138
140	139
141	140
142	141
143	142
144	143
145	144
146	145
147	146
149	148
150	149
151	150
152	151
153	152
154	153
155	154
156	147
157	155
158	155
159	86
160	88
161	158
162	96
163	88
164	86
165	86
166	88
167	86
168	86
169	88
170	86
171	86
172	88
173	86
174	88
175	86
176	88
177	86
178	88
179	86
180	86
181	88
182	86
183	86
184	86
185	86
186	88
188	86
187	88
189	88
190	86
191	88
192	88
193	88
194	88
195	88
200	199
196	88
197	162
198	197
207	198
201	200
202	201
205	204
203	202
204	203
209	206
206	205
208	206
210	88
211	210
212	209
213	86
214	207
215	211
216	161
217	86
218	211
219	156
220	104
221	137
\.


--
-- Data for Name: state_groups; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.state_groups (id, room_id, event_id) FROM stdin;
1	!kmbTYjjsDRDHGgVqUP:localhost	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU
2	!kmbTYjjsDRDHGgVqUP:localhost	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU
3	!kmbTYjjsDRDHGgVqUP:localhost	$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw
4	!kmbTYjjsDRDHGgVqUP:localhost	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w
5	!kmbTYjjsDRDHGgVqUP:localhost	$X8tdoEsXAgBC6gobCepAn3rwO8CJoQU6i9NN9Rzhukg
6	!kmbTYjjsDRDHGgVqUP:localhost	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o
7	!kmbTYjjsDRDHGgVqUP:localhost	$O5iO4EII22igkDq5cMKHFB-SGIYD0KqJQXZohS2Dzc0
8	!dKcbdDATuwwphjRPQP:localhost	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88
9	!dKcbdDATuwwphjRPQP:localhost	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88
10	!dKcbdDATuwwphjRPQP:localhost	$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA
11	!dKcbdDATuwwphjRPQP:localhost	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII
12	!dKcbdDATuwwphjRPQP:localhost	$b__a7rX3L5YpX7nAZte73DAbjtXZK48JH8VKSnGOKKw
13	!dKcbdDATuwwphjRPQP:localhost	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs
14	!dKcbdDATuwwphjRPQP:localhost	$TVnvv0nGbLydCBtMmTTz-htMsoI4hmxCr3s9AHyFGHQ
15	!kmbTYjjsDRDHGgVqUP:localhost	$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8
16	!dKcbdDATuwwphjRPQP:localhost	$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0
17	!kmbTYjjsDRDHGgVqUP:localhost	$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk
18	!dKcbdDATuwwphjRPQP:localhost	$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0
19	!kmbTYjjsDRDHGgVqUP:localhost	$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA
20	!dKcbdDATuwwphjRPQP:localhost	$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A
21	!dKcbdDATuwwphjRPQP:localhost	$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ
22	!kmbTYjjsDRDHGgVqUP:localhost	$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok
23	!dKcbdDATuwwphjRPQP:localhost	$7TwPfUMTevEcf7wLvbgx3LG01lYT_yGudYiOVlkGU7E
24	!kmbTYjjsDRDHGgVqUP:localhost	$jAifmicJfMyB1QPFQ6KFQ7ZqTqQ58RJXsH5viWn3ZUg
25	!dKcbdDATuwwphjRPQP:localhost	$DsZXxk2rEIB2tF3pYUdOPjrMwclo8BXltutiWCnKUIU
26	!kmbTYjjsDRDHGgVqUP:localhost	$NyVGoA-ZaMPbk_RzpmLOajRS1nEBirO7Du2KpA9Eo64
27	!dKcbdDATuwwphjRPQP:localhost	$JwL8EK5sa4vg29tclnHwa5jrpCTa8oZVOIsgFyivQdY
28	!kmbTYjjsDRDHGgVqUP:localhost	$JcoTJcBGASUqIK9V7j6ND5Jt6P9gdbNJxXxQBZNg8z4
29	!dKcbdDATuwwphjRPQP:localhost	$2KnXfE3sZw8LDrOAaEP4HdQuw5neshhvyZKtnwo5cg0
30	!kmbTYjjsDRDHGgVqUP:localhost	$isXWKf_B_7Z7R7jYn_2gZB-U31TuzMehBRxj5701Lq8
31	!kmbTYjjsDRDHGgVqUP:localhost	$bol9s2O4SKXmDw-4Bv7--ql7Gguji4ci1b9Cbr7pu4I
32	!dKcbdDATuwwphjRPQP:localhost	$I2BzMWA1tFnBNdcW3JX69rFYLO4qkupa_lDvzq0-uWc
33	!dKcbdDATuwwphjRPQP:localhost	$n7dpHaQF1GD7wwTwm9NffaHSmIQF1QkWS-1Y6bpvK6U
34	!kmbTYjjsDRDHGgVqUP:localhost	$dxfYr8h5yt6Ja35gqOmum3fmmD5SEeYFHpRLjwOmcOc
35	!dKcbdDATuwwphjRPQP:localhost	$HnPqDAFxOaABn1b4rdp0JBGYvf69N5Oxig9EwnlDA5s
36	!dKcbdDATuwwphjRPQP:localhost	$QkAPEN8Mmp1dtCCPPIin398pZzoanATju26kxnLo2Dc
37	!dKcbdDATuwwphjRPQP:localhost	$IyMr3UFRyeluQaumjVZMc-pbgv29pQuwQ5p6exrePeU
38	!kmbTYjjsDRDHGgVqUP:localhost	$aE3-AZHGobxFik81gcPSM9121lFXNsKU_QQWxrcI4oE
39	!dKcbdDATuwwphjRPQP:localhost	$qmRDZ3VC9wrxL3Frm4gLzJLuPSm2D6cZrRCQfO_pA8I
40	!dKcbdDATuwwphjRPQP:localhost	$CafbFfKo6gXwjycN0YbLpHmHlgndwj8C01p8tNnzJec
41	!kmbTYjjsDRDHGgVqUP:localhost	$Kd6KpuX9y5Vq6peAGikCo-yKCV2NR0N2iyBEgKSpVLs
42	!dKcbdDATuwwphjRPQP:localhost	$HAn7tvI-lMFVdFowEfK313ZgXSiKl7C9ha7uSh9VY2I
43	!kmbTYjjsDRDHGgVqUP:localhost	$dBOb2c1lY57Me0yOmlJ3AsrjgUoxxTYj-vsovQW9FT0
44	!dKcbdDATuwwphjRPQP:localhost	$sBZZGFNE1JxIyWZU48ZvPA4io9r7AUTxAwL1KSGZxf8
45	!kmbTYjjsDRDHGgVqUP:localhost	$mFiGP6gnsNtvNwzO7vb5nH3oLTO0f3zXxLbtvjhTG6w
46	!kmbTYjjsDRDHGgVqUP:localhost	$exQNAI9_H98QAQCiBPqANLeR80GUdMTDMBCz3cUOZ_o
47	!kmbTYjjsDRDHGgVqUP:localhost	$3S3gk8orbNOqOmhi0i_h2do3Zm-8MzIqR7xMlyP-ehw
48	!kmbTYjjsDRDHGgVqUP:localhost	$1kSEtnyMqIb18AR2oEGHjSwjx1QDx6tsdIpD8oCtJKc
49	!dKcbdDATuwwphjRPQP:localhost	$kle2Bp8ew-aHloeKtDruh1XBOwOmmTRutbOY6fi8ceM
50	!kmbTYjjsDRDHGgVqUP:localhost	$HT7OqT28I3P9p4clRqmpqLMg-sKQj-4QdCrmwBldFfY
51	!kmbTYjjsDRDHGgVqUP:localhost	$bZZ26gK0i6X9jZ7y9d9UOdrBkJdZ0WBl59UoR-Dh7cY
52	!dKcbdDATuwwphjRPQP:localhost	$AXf5K1LcAFpkfKyTmfI5cR3Q6EygP_XZb5c5AX_XMDc
53	!kmbTYjjsDRDHGgVqUP:localhost	$-yU3NmsDDsdfn8bk1p3G83OHyAJFq9n6fZGEWT7OAOc
54	!kmbTYjjsDRDHGgVqUP:localhost	$mGb2SonelXgJyIX8tTN375ipt38sUqSlUhL_y1lVzDg
55	!dKcbdDATuwwphjRPQP:localhost	$uNUp5Khpz8qTVhw5R_2UM-xCJM_isb-HqsDEApY51K8
56	!kmbTYjjsDRDHGgVqUP:localhost	$Bqz5WQ1GEA0PwDWUhZ_-awYChpHP_ipTCLVpoteZbBA
57	!kmbTYjjsDRDHGgVqUP:localhost	$8ARGSQ1QObTUneAjYYK_ST3lrZkSX46BUNy-nurncLE
58	!dKcbdDATuwwphjRPQP:localhost	$TXmc64Tulr0myXphObSutURAvOGzajK-oSNhP4aVA5E
59	!dKcbdDATuwwphjRPQP:localhost	$eap6ELuprcMToIBaPbRO3n7Hrh3lo3Pq1nKcOP92Eec
60	!kmbTYjjsDRDHGgVqUP:localhost	$keLg_iTrTOlYlr_SQepP9ZZo_8hv3_MhSF0Yp6IKlKA
61	!dKcbdDATuwwphjRPQP:localhost	$oh9HYt5PnzKE6_fHAhWM04b2RJeomk91WZt7-ASlUQ4
62	!kmbTYjjsDRDHGgVqUP:localhost	$au5IHGrA3Qyuuq7Im5r-laBTYCFAlPf4rupifQcpV-o
63	!dKcbdDATuwwphjRPQP:localhost	$kr2eCi7iYTaghOVTO068rKQ-85iRzb_DYbBqFAB6iIk
64	!kmbTYjjsDRDHGgVqUP:localhost	$D40TbtFs1n6oOKdZQyDN0JIe7byKjaWxQuMPQQDVuHI
65	!dKcbdDATuwwphjRPQP:localhost	$IhTS0k6hT0feWOgVCI2nrzWR1p1roVXWIMy8CLJK7Ug
66	!dKcbdDATuwwphjRPQP:localhost	$8Ha6OK50Lumf2e5JnrcogtVIO-aPj-Ne0jdzYJyxjtU
67	!dKcbdDATuwwphjRPQP:localhost	$8DM5lrvclwc2WIx7pPw8EV9Mc9BmQIebuMg_xxGuA8I
68	!kmbTYjjsDRDHGgVqUP:localhost	$vSxw7HVlTBfUhW7D5laJfzbyFzoDI-syGrMAYWmlCPc
69	!kmbTYjjsDRDHGgVqUP:localhost	$rVK77mVSpz5EHxI2mbLxilqbkLxKhXEiusPFjapVPbw
70	!kmbTYjjsDRDHGgVqUP:localhost	$5agO4kI6VqJHGKvKbkqUa2Y3cTwUBrjAhmCVtj9JmKU
71	!dKcbdDATuwwphjRPQP:localhost	$4JiNeQHyMbyuEfymLkE-SEzPUh3bWddjxa6-5w36nJw
87	!dKcbdDATuwwphjRPQP:localhost	$l5dYt-R2kpcKdlmMRFnzC5N9PjiV4DZ63c1bTGPOCXk
88	!dKcbdDATuwwphjRPQP:localhost	$NxuVtjeVql0_aadDlNux0yeeR_PxcpcJPnX1SdoDmXM
95	!MrxfbdodytWwBMqNiF:localhost	$9MVFB3q88VYxhDZMX087Uv4c3h3uEpluJN0q33ubtso
114	!kAToIwhNWrDpgQVMfY:localhost	$nL-1meDVcMfCo41V5V5w3EBPwNdmll7Alfsp00QCHvk
117	!cwnFZrIkYIOvkCHJkc:localhost	$AXgBEWEnQYL0m4F3qNGi4DDk7afIQe7a_hmRdZkAZLM
129	!ffaaxOMHcWnINEXTWK:localhost	$e4RXblgeP3Sa0Hs3COmGOAFe9LclWYCrLIk7nF2PEDk
131	!ffaaxOMHcWnINEXTWK:localhost	$tWJ40KRMdaZwn6df_597mz_AyHLHUSEy0noQk3HlctY
72	!kmbTYjjsDRDHGgVqUP:localhost	$Y_S-fF0iLu0OHNMcZdYVzt0we_qL_t8_4QIKGeobLdI
73	!dKcbdDATuwwphjRPQP:localhost	$g1kV-jEZBtN9l6VGGo2MN-wQn7RR7J-Tv5LfyJ5Z5fc
74	!kmbTYjjsDRDHGgVqUP:localhost	$CQg_jKvdpWFvaiLH2f5MtTnu1Zwxi8P4QPSJZum91dw
75	!dKcbdDATuwwphjRPQP:localhost	$OcvCF7YNeTKFnzz4EWVjFJIF9QidMEUmomHIvH3d2W8
76	!kmbTYjjsDRDHGgVqUP:localhost	$GrqoJ52XSgRaoc4wPEYLdL2p6t3jl0aiFd8bYswQQcU
78	!kmbTYjjsDRDHGgVqUP:localhost	$UYXKiTPqFr31PwoZzi35ODpdRK0hwJVjVGC1N7kR7yk
80	!kmbTYjjsDRDHGgVqUP:localhost	$h2yGPxzdKWUBUSFQiOgFiRoNa8NgWHYXdy_2SMJx6ns
92	!MrxfbdodytWwBMqNiF:localhost	$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA
94	!MrxfbdodytWwBMqNiF:localhost	$JQ7PDbgzTTAY5uHFM6NV0ovadfzQLOpcAcrSX5mRUi0
98	!UKcoTBWWxNEyixrjyM:localhost	$yZwQJfxjuLFOlfyTYw-M1aupZjmck-aVfpfSYx5fj1I
103	!UKcoTBWWxNEyixrjyM:localhost	$em_2PzgnditDYAzn8yY84PnmN1oNQZgI8Co6SjahtU8
107	!kAToIwhNWrDpgQVMfY:localhost	$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE
110	!kAToIwhNWrDpgQVMfY:localhost	$KGv2op0D-6TOpQuqb5Gl4YZxMUKn37cUNSylMiEo7SA
111	!kAToIwhNWrDpgQVMfY:localhost	$XvSaPVUaER3JwP1gLc-c__oVTIjGs5YL10o0DSsZ3q0
115	!ffaaxOMHcWnINEXTWK:localhost	$wTlWqRh3eGNrru9CGqbzkNcL0kBGbtEB8sHZwsAboS0
130	!cwnFZrIkYIOvkCHJkc:localhost	$dLHdIN5p2aRYI16qULeP30FhKh5GGtUHvQUzWcSWyTA
133	!kAToIwhNWrDpgQVMfY:localhost	$BNEpFvlxqdDF-6u3EPToNgfx0BuYX2_P9oWB486xTxM
77	!dKcbdDATuwwphjRPQP:localhost	$5TE1hAtSTolrY9QTj9Wt8DnKurFa3P6KIfGkWOJbrY4
79	!dKcbdDATuwwphjRPQP:localhost	$YFCWkh6b_jgrSjje7vt6JB6-uLPRz7Na1VgGh0PwdI8
81	!dKcbdDATuwwphjRPQP:localhost	$kmvnPONhcKxIpG62sV6apngYToshpP0mBrwpKL0hAOI
82	!kmbTYjjsDRDHGgVqUP:localhost	$KgpvpFIMQIVFvm0adBZqAbWANmMgdu1_1jbP71RuM48
83	!dKcbdDATuwwphjRPQP:localhost	$qWi32T1tK2APgSwc4y_6f0e_N_fUPmIBxC5ACk1h6NM
84	!kmbTYjjsDRDHGgVqUP:localhost	$jvwVmkElpx8M62JlaBz7nJ4qa2U8tVO7V9-HhJ-n8JI
85	!dKcbdDATuwwphjRPQP:localhost	$0WsTO-QKZzqtMdl5UwGJc5h4e7YAE5ZGp_GDMb9K824
86	!kmbTYjjsDRDHGgVqUP:localhost	$opS4sT6APXaq4vDdegPq6ik1z-yX-FkMTAqhGtTWXEE
91	!MrxfbdodytWwBMqNiF:localhost	$89n67RlAmtb8nRuxie-oq3g9grnkpjzJMAhbJ8h_8Xw
93	!MrxfbdodytWwBMqNiF:localhost	$TVXtgqtZ5WfNfZEnJQx6m0NYwp0_34ylOK87XzZ3JlI
97	!UKcoTBWWxNEyixrjyM:localhost	$yZwQJfxjuLFOlfyTYw-M1aupZjmck-aVfpfSYx5fj1I
99	!UKcoTBWWxNEyixrjyM:localhost	$sqtTmHJJ_e6UeDKORkztLzcGXYNZpKgoa1v2ir5yr-w
101	!UKcoTBWWxNEyixrjyM:localhost	$STt_lRcQQY1HR2YQmv4RsQMis1Xc5sWAamnHn02ddqk
102	!UKcoTBWWxNEyixrjyM:localhost	$KEhwfKMs0OrXZWYNQWK_YDu-mrG-UP2Do2VsAShloEY
106	!kAToIwhNWrDpgQVMfY:localhost	$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw
108	!kAToIwhNWrDpgQVMfY:localhost	$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc
109	!kAToIwhNWrDpgQVMfY:localhost	$fZAJc_jo3uwpjSNh7ULQOuzuMtHLVO8KdmygXkq-95M
113	!kAToIwhNWrDpgQVMfY:localhost	$Np7HQ3SdNiYX3HhRJtJw4b80J96uY_IbqI_bL7w83m0
116	!ffaaxOMHcWnINEXTWK:localhost	$wTlWqRh3eGNrru9CGqbzkNcL0kBGbtEB8sHZwsAboS0
119	!ffaaxOMHcWnINEXTWK:localhost	$81gCIX2tUwDG_Jg02kHVceEfsUG1IOQ9-YnDk1cV15w
120	!cwnFZrIkYIOvkCHJkc:localhost	$41BPCZJ_9IbE7VgIqxEef1X7U2-FXJjTA25i2Q-n_gg
121	!ffaaxOMHcWnINEXTWK:localhost	$pn5NPm28AfF5_169OnQQxTv4_ijcoN4k44UIvzGsN7k
122	!cwnFZrIkYIOvkCHJkc:localhost	$PJZugFD-K6RtTB0vNzX1j0YFLZ9x4vli99YpMY9dzQk
123	!ffaaxOMHcWnINEXTWK:localhost	$jLK4KwpKxGfwbMdz2oJbuUlHegeZ_5YucIy2ChSNCLg
124	!cwnFZrIkYIOvkCHJkc:localhost	$ce28aY-iB2mpb8Gioxn_S-YFJtBn3dK4JRguWv9H2XY
127	!cwnFZrIkYIOvkCHJkc:localhost	$7CUacT0Q8hFhLt80ecyLwLrizW7Jh6uNtLYApZIgNg4
128	!ffaaxOMHcWnINEXTWK:localhost	$zxy8zKV-5WiZDQEOGVCLyrd2yGWyYrOah4vQYAlc-xI
134	!kAToIwhNWrDpgQVMfY:localhost	$v_Jh2P1U7Li3ATyMsxgipoyBuQRYv5HD-cv8JVNpdLc
136	!kAToIwhNWrDpgQVMfY:localhost	$bFxX1nACgPihIeXfSiWHmW_hxrfmIgtQM9HWAPS2wVY
89	!MrxfbdodytWwBMqNiF:localhost	$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY
90	!MrxfbdodytWwBMqNiF:localhost	$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY
96	!MrxfbdodytWwBMqNiF:localhost	$V_QrTFMCwHlrg-MSVVplcYCRVWM_QgXhIvp-2R_LtHI
100	!UKcoTBWWxNEyixrjyM:localhost	$EsIKBNaGky9gjqListPEKjQfFScHFrG5GuEQD0vyi9Q
104	!UKcoTBWWxNEyixrjyM:localhost	$sdrkpiq94MhqjrSukg-aexI_3VlPxcoqiZXmrPvpQGw
112	!kAToIwhNWrDpgQVMfY:localhost	$zHrY9OvLbZTtN0bNPCDJg1HsmkgSV-pzAmxVIqaSB98
118	!cwnFZrIkYIOvkCHJkc:localhost	$AXgBEWEnQYL0m4F3qNGi4DDk7afIQe7a_hmRdZkAZLM
125	!cwnFZrIkYIOvkCHJkc:localhost	$3ccBKAI_RT742spGFKzsNSBIzhj7WC7YBxugrDvyr4w
132	!cwnFZrIkYIOvkCHJkc:localhost	$ab5rFOQQuDGj00oHfJaJKURhG6lNFNDKS0nkBlsLTMk
135	!kAToIwhNWrDpgQVMfY:localhost	$bFxX1nACgPihIeXfSiWHmW_hxrfmIgtQM9HWAPS2wVY
137	!kAToIwhNWrDpgQVMfY:localhost	$kL3ALUeGobajxL55gzYoIZLdD1CSD4sYXedIOysHwV0
105	!kAToIwhNWrDpgQVMfY:localhost	$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw
126	!ffaaxOMHcWnINEXTWK:localhost	$Jy6RZhO0nZ0x_EgWugfJHW0XgWaR5DoWVaImG_wE3lg
138	!LwtGEdNVvQHvFLuWQB:localhost	$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q
139	!LwtGEdNVvQHvFLuWQB:localhost	$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q
140	!LwtGEdNVvQHvFLuWQB:localhost	$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic
141	!LwtGEdNVvQHvFLuWQB:localhost	$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k
142	!LwtGEdNVvQHvFLuWQB:localhost	$PTHh0FcsZLrplrmwtCyvLjXr1yAZRgovFGLVt7qrrAo
143	!LwtGEdNVvQHvFLuWQB:localhost	$6CLZCTGtpIVnohQDg2sJwn_880f0--zCZpr6BgOwQ2Q
144	!LwtGEdNVvQHvFLuWQB:localhost	$nKXxWIIoo5Vko9Z7kITUEeAsQgQnr-FLvhoQHfkCYAE
145	!LwtGEdNVvQHvFLuWQB:localhost	$TbFvVskFwRsxEgjNnOjfs4ljMJuZC60_Cqb91vOUrxg
146	!LwtGEdNVvQHvFLuWQB:localhost	$SuM_AupYZSEtAJBPHbvNkhJ4aIYEjT4c741wzkoOX4I
147	!LwtGEdNVvQHvFLuWQB:localhost	$smbpaz4v1tYoI0ZZ-HXKXrcs19S7qioXa8ah6FeOBpc
148	!GNlLBsLXjbOuNhCkEO:localhost	$_-6CgruWK6UfiL1rgJnNUgtmp_jusf_3Vf7LUPB6xaU
149	!GNlLBsLXjbOuNhCkEO:localhost	$_-6CgruWK6UfiL1rgJnNUgtmp_jusf_3Vf7LUPB6xaU
150	!GNlLBsLXjbOuNhCkEO:localhost	$yrfdAmX0K0lY65Dm9bViRYWOBKtvTB1kxkm6lNsThdw
151	!GNlLBsLXjbOuNhCkEO:localhost	$uKKFUGwf_IAnbH81DTvAScd2HFnAwWWL_p4-E5B_YdU
152	!GNlLBsLXjbOuNhCkEO:localhost	$MRytSYI-n7aCgzUssVx9vLIC5Y-Yt22y_L1eQoE4GgE
153	!GNlLBsLXjbOuNhCkEO:localhost	$ah5gH_XfCIYeCtl2NFxHSgdd_OE6O9tHe2U1Pn2Qvhc
154	!GNlLBsLXjbOuNhCkEO:localhost	$lnpmPOjrFoaPq58156r6g4G7gYfejQ2BfcFkjGiEX-I
155	!GNlLBsLXjbOuNhCkEO:localhost	$fuvIFJYv32qkEsYyW8XNHbQ0hmQ5HHRjF6UEjte6Z-c
156	!LwtGEdNVvQHvFLuWQB:localhost	$O-kcGXcFLVtSNAY7CxqW4hLVBk0UqhADtIs1kCz8hlA
157	!GNlLBsLXjbOuNhCkEO:localhost	$mrothtkO8tebjJGeNAwAffr795rF0DPgaeqd5sjoqZc
158	!GNlLBsLXjbOuNhCkEO:localhost	$vesveJhdimZ9d-Po76D8SZCUm8dVzl0GcQsvVX8lhos
159	!kmbTYjjsDRDHGgVqUP:localhost	$8xsczNZMt4ghZ8hOUKpNfmtfhHntQ3qyCBw5y4BlHwM
160	!dKcbdDATuwwphjRPQP:localhost	$yc93OwlIQJ1Ogm8WEiqk1PQRKJU563w_qzdsBTXvUP0
161	!GNlLBsLXjbOuNhCkEO:localhost	$nfronhC7iKGPRmKJ7zoXzYG7VKiOq5FoUIcfHg3a4Dg
162	!MrxfbdodytWwBMqNiF:localhost	$Pem9TyngNuhpIq_NI2krx6wpkVigoBj6JCeB3WUezVk
163	!dKcbdDATuwwphjRPQP:localhost	$xRDhFDASTtdpw1L9BgruXmozbigfPYpBzTqq4XcEnbM
164	!kmbTYjjsDRDHGgVqUP:localhost	$WLynpBgpDpk4jol3Hh8HJLzlEBLNRxx5IPFaik0uUvo
165	!kmbTYjjsDRDHGgVqUP:localhost	$m4SBTrAiyFOgwXP_n4DR6ETWWaN6q6X_bhEHAhUO6Nc
166	!dKcbdDATuwwphjRPQP:localhost	$THfYLOl_hf5GFx0WV30l5vb-jrKxuql09UWcThqr1ng
167	!kmbTYjjsDRDHGgVqUP:localhost	$73EMecMC3DNTuQvrCNNFTwIyq8le_uRbahE0rG2Y41o
168	!kmbTYjjsDRDHGgVqUP:localhost	$wCgjRMcm13QlBXMYRsncuxbnCziYKP8cDUQKyybUKoU
169	!dKcbdDATuwwphjRPQP:localhost	$v9kHVKt3C7jK6Zc7vPFiPRi1EGSZpr_aV8SQLdj18RM
170	!kmbTYjjsDRDHGgVqUP:localhost	$Cj1lGN-eHKb-4c7e15DUicGty5qyiwejGTFrXrHCPls
171	!kmbTYjjsDRDHGgVqUP:localhost	$4iJRiSxWb7vSXM_gTgzWeFHE4KVFEqghA4nTV2IeUiQ
172	!dKcbdDATuwwphjRPQP:localhost	$e93QytCN7H8T9HqAWIF_sNsBsTUMiPrT3wiLBNoalt0
173	!kmbTYjjsDRDHGgVqUP:localhost	$lqcDJmmnWI5ZbJe3tsEVs2AcPqQFiSVZAqhjJqkKb9w
174	!dKcbdDATuwwphjRPQP:localhost	$iJbdwiLJri5GvqozCWuWnwewl09YpmiATcChoIdHH2U
175	!kmbTYjjsDRDHGgVqUP:localhost	$BTe_dHBq8KdVZEJifCfJinAGaiBO0tk1kSTykEUiSyk
176	!dKcbdDATuwwphjRPQP:localhost	$KD3fR6oDFKQIBoLnsPUw43We52WoezEjNfWVcT58Ar8
177	!kmbTYjjsDRDHGgVqUP:localhost	$i3LsyYPgVIj7mSl41uVCNmY1UDYyUwQAnOllWICcAXI
178	!dKcbdDATuwwphjRPQP:localhost	$xKu0tXyKXqHV5bWc8yuk2XHg12GnIoagN5QX-fIcByU
179	!kmbTYjjsDRDHGgVqUP:localhost	$qGwpNteqBFuv5YAmCwb-YJ6-wXcYe3wSuM8u8hdYvLE
180	!kmbTYjjsDRDHGgVqUP:localhost	$jhsFpnZfsVsEbgyBh8EI6x2LfibzGlMmIZnE2Tvhe90
181	!dKcbdDATuwwphjRPQP:localhost	$mU3wVh_PVql6beqrNhllADjuwGk1ADjBHUgeMYEPBbA
182	!kmbTYjjsDRDHGgVqUP:localhost	$cqALIjoFjHIahC0BVvgDVxl6_44o5wmej-8t198aAvM
183	!kmbTYjjsDRDHGgVqUP:localhost	$5b0a6UvvtICUqbY9X1O5xVlvEtcgyn12MGHan0HDJlc
184	!kmbTYjjsDRDHGgVqUP:localhost	$pzxqJAY8An4DMY1tfDwDnYrsVnc5yghXpFLZzbBC1Jo
185	!kmbTYjjsDRDHGgVqUP:localhost	$44PFCCW8RSdcjqTSJ-VOD_uJqmsj5nT89WUSRWSLDOg
186	!dKcbdDATuwwphjRPQP:localhost	$CBsW6Bv7UyBlZ9DpjmGZCH-IKo0JdymhSkGaE-Sa1Ow
187	!dKcbdDATuwwphjRPQP:localhost	$GDx9o96T1xZHDFgk4CrVqrBL-rksEMxsn0SXHC-0R_k
188	!kmbTYjjsDRDHGgVqUP:localhost	$iACcMxD_VszJkWyIhHdBjJ_csrmL0tgRvl9r4hK_QVw
189	!dKcbdDATuwwphjRPQP:localhost	$ESNEgoAL2C3c_ziVmTDVM56c-z2eWod4kiPDkoB0IoY
190	!kmbTYjjsDRDHGgVqUP:localhost	$YwdD4feP6crA1CTaoZ-9VPQKsD_ipGXZZKmFD8ONSAQ
191	!dKcbdDATuwwphjRPQP:localhost	$fxvC3xtD69l_p-ZT7BMP16SFmaeTYOCdmh5G69-k54M
192	!dKcbdDATuwwphjRPQP:localhost	$PUKQSi4SX_465dj8Zg4jJ7IeA9AfysAMb2aHmIgitcc
193	!dKcbdDATuwwphjRPQP:localhost	$s3b7zmrcr8AZvGT6Sw6yXnrTircBUHpdCpBkTFguG9s
194	!dKcbdDATuwwphjRPQP:localhost	$oJLkahlF0aI11PKyA3Hcyqgccyz3wHN-KcoK4s4gKQo
195	!dKcbdDATuwwphjRPQP:localhost	$uWtY4ot6KzO7AMco44rkspGXsjDSyHh4GtBVQIs2eJw
196	!dKcbdDATuwwphjRPQP:localhost	$lJ4fGtoJqlDGuef6bH6631xLHgrZqELTWOErVr3zBE8
197	!MrxfbdodytWwBMqNiF:localhost	$viSFX8RvY5fe8TiOaDirNG6PqooEHTTV3PT3hrQgVLA
198	!MrxfbdodytWwBMqNiF:localhost	$MT4EKTmcPC8LCVeATiG-5a71N2Zc1vNQcgKge5W0on8
199	!nPrdOOfNMRrmJedabn:localhost	$A5h106ytjQ2qqPxkSylhOkJgVZQCscB4QX0PK60qxU0
200	!nPrdOOfNMRrmJedabn:localhost	$A5h106ytjQ2qqPxkSylhOkJgVZQCscB4QX0PK60qxU0
201	!nPrdOOfNMRrmJedabn:localhost	$AMnH95Ky85GttLR7j9XHrHyULlBBezFJ9w8mtji-7Ok
202	!nPrdOOfNMRrmJedabn:localhost	$gDW6j_UqhvIRf1ANEKurSD9fB4Hl4YnQ5uL9cy_U7Os
203	!nPrdOOfNMRrmJedabn:localhost	$0gszMJtyESzwVMh4olwTajdbj1MrrJYVnylO0yOIpSg
204	!nPrdOOfNMRrmJedabn:localhost	$2lEnFzGdtIu4kGthBBXcP0gW6sUWKP8c1x9I4-yFWso
205	!nPrdOOfNMRrmJedabn:localhost	$yfuDQBYjEI6CCa3AdtfdjL_ZXIR0d92TRfHnh7Gq0zc
206	!nPrdOOfNMRrmJedabn:localhost	$xyV3lysb-dda01bB4LpALdmaTC_mLZDhwxOE9L4zpXY
207	!MrxfbdodytWwBMqNiF:localhost	$eOC3-FZNb3jb3NisHG61gQhQ_hf9zWu0xvpfs8ZKDTg
208	!nPrdOOfNMRrmJedabn:localhost	$uz-oYzJMCuBOk8PIx6WmLciQUJ8_PEAei2TfFFC-ccQ
209	!nPrdOOfNMRrmJedabn:localhost	$usag8slAxKA2dWWERksMiBQ8hRwfGZ8nZzTfcymZxyE
210	!dKcbdDATuwwphjRPQP:localhost	$O04OV5x9R_5W2IT9G9Z-dXJmfV6fgtZM8-4ogFp9rEw
211	!dKcbdDATuwwphjRPQP:localhost	$-QMfwsu75_SWJtzFqIsrFjLgl_XBqF6HcorcUjLTsWY
212	!nPrdOOfNMRrmJedabn:localhost	$2Wnr71fAdbGyyUyhiqrfnEJcIHAZyuCqEiwv2KgHMzA
213	!kmbTYjjsDRDHGgVqUP:localhost	$Y04ROgkrQyNtYJbPKIsqZvSyp1Th3SAusNK34A3U3Hc
214	!MrxfbdodytWwBMqNiF:localhost	$NE0OtjpKue1xYSdbOT8qccobMlUQmvpOIxCzOdVIrm8
215	!dKcbdDATuwwphjRPQP:localhost	$mnswj7WVVSEwuuCxD_dxP2dfUKUadM-v2R4tvSGbjk0
216	!GNlLBsLXjbOuNhCkEO:localhost	$DO-aeVkP_VpLsVO24WlrbvOYm50Ly8YVtsIyUCeXhrY
217	!kmbTYjjsDRDHGgVqUP:localhost	$nxGZiCt5sPNvx_9WR4yzJQ4GTGceWLmYEsyA_pzb808
218	!dKcbdDATuwwphjRPQP:localhost	$80bVl7TPEhI3PqH7QSJ2xNnkw8fqbeM_BVsB__WK9d0
219	!LwtGEdNVvQHvFLuWQB:localhost	$WsVhQvsUsrFormgSdFA_Z_Io7y9fxZy5juqaM8oYpkg
220	!UKcoTBWWxNEyixrjyM:localhost	$hooKnajA7nQRs3MZDj_evGyHCyHpg4QmGp2i5WRKzp0
221	!kAToIwhNWrDpgQVMfY:localhost	$rNG4YvsFCU9LVcVcHEkbBRGSuEH_QqO_hMEZ-sC8WH8
\.


--
-- Data for Name: state_groups_state; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.state_groups_state (state_group, room_id, type, state_key, event_id) FROM stdin;
2	!kmbTYjjsDRDHGgVqUP:localhost	m.room.create		$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU
3	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@admin:localhost	$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw
4	!kmbTYjjsDRDHGgVqUP:localhost	m.room.power_levels		$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w
5	!kmbTYjjsDRDHGgVqUP:localhost	m.room.canonical_alias		$X8tdoEsXAgBC6gobCepAn3rwO8CJoQU6i9NN9Rzhukg
6	!kmbTYjjsDRDHGgVqUP:localhost	m.room.join_rules		$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o
7	!kmbTYjjsDRDHGgVqUP:localhost	m.room.history_visibility		$O5iO4EII22igkDq5cMKHFB-SGIYD0KqJQXZohS2Dzc0
9	!dKcbdDATuwwphjRPQP:localhost	m.room.create		$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88
10	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@admin:localhost	$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA
11	!dKcbdDATuwwphjRPQP:localhost	m.room.power_levels		$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII
12	!dKcbdDATuwwphjRPQP:localhost	m.room.canonical_alias		$b__a7rX3L5YpX7nAZte73DAbjtXZK48JH8VKSnGOKKw
13	!dKcbdDATuwwphjRPQP:localhost	m.room.join_rules		$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs
14	!dKcbdDATuwwphjRPQP:localhost	m.room.history_visibility		$TVnvv0nGbLydCBtMmTTz-htMsoI4hmxCr3s9AHyFGHQ
15	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_a:localhost	$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8
16	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0
17	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_b:localhost	$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk
18	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_b:localhost	$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0
19	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@ignored_user:localhost	$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA
20	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@ignored_user:localhost	$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A
21	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ
22	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok
23	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$7TwPfUMTevEcf7wLvbgx3LG01lYT_yGudYiOVlkGU7E
24	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$jAifmicJfMyB1QPFQ6KFQ7ZqTqQ58RJXsH5viWn3ZUg
25	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$DsZXxk2rEIB2tF3pYUdOPjrMwclo8BXltutiWCnKUIU
26	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$NyVGoA-ZaMPbk_RzpmLOajRS1nEBirO7Du2KpA9Eo64
27	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$JwL8EK5sa4vg29tclnHwa5jrpCTa8oZVOIsgFyivQdY
28	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$JcoTJcBGASUqIK9V7j6ND5Jt6P9gdbNJxXxQBZNg8z4
29	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$2KnXfE3sZw8LDrOAaEP4HdQuw5neshhvyZKtnwo5cg0
30	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$isXWKf_B_7Z7R7jYn_2gZB-U31TuzMehBRxj5701Lq8
31	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$bol9s2O4SKXmDw-4Bv7--ql7Gguji4ci1b9Cbr7pu4I
32	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$I2BzMWA1tFnBNdcW3JX69rFYLO4qkupa_lDvzq0-uWc
33	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$n7dpHaQF1GD7wwTwm9NffaHSmIQF1QkWS-1Y6bpvK6U
34	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$dxfYr8h5yt6Ja35gqOmum3fmmD5SEeYFHpRLjwOmcOc
35	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$HnPqDAFxOaABn1b4rdp0JBGYvf69N5Oxig9EwnlDA5s
36	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$QkAPEN8Mmp1dtCCPPIin398pZzoanATju26kxnLo2Dc
37	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$IyMr3UFRyeluQaumjVZMc-pbgv29pQuwQ5p6exrePeU
38	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$aE3-AZHGobxFik81gcPSM9121lFXNsKU_QQWxrcI4oE
39	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$qmRDZ3VC9wrxL3Frm4gLzJLuPSm2D6cZrRCQfO_pA8I
40	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$CafbFfKo6gXwjycN0YbLpHmHlgndwj8C01p8tNnzJec
41	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$Kd6KpuX9y5Vq6peAGikCo-yKCV2NR0N2iyBEgKSpVLs
42	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$HAn7tvI-lMFVdFowEfK313ZgXSiKl7C9ha7uSh9VY2I
43	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$dBOb2c1lY57Me0yOmlJ3AsrjgUoxxTYj-vsovQW9FT0
44	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$sBZZGFNE1JxIyWZU48ZvPA4io9r7AUTxAwL1KSGZxf8
45	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$mFiGP6gnsNtvNwzO7vb5nH3oLTO0f3zXxLbtvjhTG6w
46	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$exQNAI9_H98QAQCiBPqANLeR80GUdMTDMBCz3cUOZ_o
47	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$3S3gk8orbNOqOmhi0i_h2do3Zm-8MzIqR7xMlyP-ehw
48	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$1kSEtnyMqIb18AR2oEGHjSwjx1QDx6tsdIpD8oCtJKc
49	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$kle2Bp8ew-aHloeKtDruh1XBOwOmmTRutbOY6fi8ceM
50	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$HT7OqT28I3P9p4clRqmpqLMg-sKQj-4QdCrmwBldFfY
51	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$bZZ26gK0i6X9jZ7y9d9UOdrBkJdZ0WBl59UoR-Dh7cY
52	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$AXf5K1LcAFpkfKyTmfI5cR3Q6EygP_XZb5c5AX_XMDc
53	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$-yU3NmsDDsdfn8bk1p3G83OHyAJFq9n6fZGEWT7OAOc
54	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$mGb2SonelXgJyIX8tTN375ipt38sUqSlUhL_y1lVzDg
55	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$uNUp5Khpz8qTVhw5R_2UM-xCJM_isb-HqsDEApY51K8
56	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$Bqz5WQ1GEA0PwDWUhZ_-awYChpHP_ipTCLVpoteZbBA
57	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$8ARGSQ1QObTUneAjYYK_ST3lrZkSX46BUNy-nurncLE
62	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$au5IHGrA3Qyuuq7Im5r-laBTYCFAlPf4rupifQcpV-o
58	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$TXmc64Tulr0myXphObSutURAvOGzajK-oSNhP4aVA5E
61	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$oh9HYt5PnzKE6_fHAhWM04b2RJeomk91WZt7-ASlUQ4
64	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$D40TbtFs1n6oOKdZQyDN0JIe7byKjaWxQuMPQQDVuHI
59	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$eap6ELuprcMToIBaPbRO3n7Hrh3lo3Pq1nKcOP92Eec
60	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$keLg_iTrTOlYlr_SQepP9ZZo_8hv3_MhSF0Yp6IKlKA
63	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$kr2eCi7iYTaghOVTO068rKQ-85iRzb_DYbBqFAB6iIk
65	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$IhTS0k6hT0feWOgVCI2nrzWR1p1roVXWIMy8CLJK7Ug
66	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$8Ha6OK50Lumf2e5JnrcogtVIO-aPj-Ne0jdzYJyxjtU
67	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$8DM5lrvclwc2WIx7pPw8EV9Mc9BmQIebuMg_xxGuA8I
68	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$vSxw7HVlTBfUhW7D5laJfzbyFzoDI-syGrMAYWmlCPc
69	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a_:localhost	$rVK77mVSpz5EHxI2mbLxilqbkLxKhXEiusPFjapVPbw
70	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b_:localhost	$5agO4kI6VqJHGKvKbkqUa2Y3cTwUBrjAhmCVtj9JmKU
71	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_matrix_matrix_b:localhost	$4JiNeQHyMbyuEfymLkE-SEzPUh3bWddjxa6-5w36nJw
72	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_matrix_matrix_a:localhost	$Y_S-fF0iLu0OHNMcZdYVzt0we_qL_t8_4QIKGeobLdI
73	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_matrix_matrix_a:localhost	$g1kV-jEZBtN9l6VGGo2MN-wQn7RR7J-Tv5LfyJ5Z5fc
74	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a_:localhost	$CQg_jKvdpWFvaiLH2f5MtTnu1Zwxi8P4QPSJZum91dw
75	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b_:localhost	$OcvCF7YNeTKFnzz4EWVjFJIF9QidMEUmomHIvH3d2W8
76	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_matrix_matrix_b:localhost	$GrqoJ52XSgRaoc4wPEYLdL2p6t3jl0aiFd8bYswQQcU
77	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a_:localhost	$5TE1hAtSTolrY9QTj9Wt8DnKurFa3P6KIfGkWOJbrY4
78	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b_:localhost	$UYXKiTPqFr31PwoZzi35ODpdRK0hwJVjVGC1N7kR7yk
79	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_matrix_matrix_b:localhost	$YFCWkh6b_jgrSjje7vt6JB6-uLPRz7Na1VgGh0PwdI8
80	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_matrix_matrix_a:localhost	$h2yGPxzdKWUBUSFQiOgFiRoNa8NgWHYXdy_2SMJx6ns
81	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_matrix_matrix_a:localhost	$kmvnPONhcKxIpG62sV6apngYToshpP0mBrwpKL0hAOI
82	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_matrix_matrix_b:localhost	$KgpvpFIMQIVFvm0adBZqAbWANmMgdu1_1jbP71RuM48
83	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b_:localhost	$qWi32T1tK2APgSwc4y_6f0e_N_fUPmIBxC5ACk1h6NM
84	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$jvwVmkElpx8M62JlaBz7nJ4qa2U8tVO7V9-HhJ-n8JI
85	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a_:localhost	$0WsTO-QKZzqtMdl5UwGJc5h4e7YAE5ZGp_GDMb9K824
86	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$opS4sT6APXaq4vDdegPq6ik1z-yX-FkMTAqhGtTWXEE
87	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$l5dYt-R2kpcKdlmMRFnzC5N9PjiV4DZ63c1bTGPOCXk
88	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$NxuVtjeVql0_aadDlNux0yeeR_PxcpcJPnX1SdoDmXM
90	!MrxfbdodytWwBMqNiF:localhost	m.room.create		$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY
91	!MrxfbdodytWwBMqNiF:localhost	m.room.member	@bridgeuser1:localhost	$89n67RlAmtb8nRuxie-oq3g9grnkpjzJMAhbJ8h_8Xw
92	!MrxfbdodytWwBMqNiF:localhost	m.room.power_levels		$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA
93	!MrxfbdodytWwBMqNiF:localhost	m.room.join_rules		$TVXtgqtZ5WfNfZEnJQx6m0NYwp0_34ylOK87XzZ3JlI
94	!MrxfbdodytWwBMqNiF:localhost	m.room.history_visibility		$JQ7PDbgzTTAY5uHFM6NV0ovadfzQLOpcAcrSX5mRUi0
95	!MrxfbdodytWwBMqNiF:localhost	m.room.guest_access		$9MVFB3q88VYxhDZMX087Uv4c3h3uEpluJN0q33ubtso
96	!MrxfbdodytWwBMqNiF:localhost	m.room.member	@admin:localhost	$V_QrTFMCwHlrg-MSVVplcYCRVWM_QgXhIvp-2R_LtHI
98	!UKcoTBWWxNEyixrjyM:localhost	m.room.create		$yZwQJfxjuLFOlfyTYw-M1aupZjmck-aVfpfSYx5fj1I
99	!UKcoTBWWxNEyixrjyM:localhost	m.room.member	@bridgeuser1:localhost	$sqtTmHJJ_e6UeDKORkztLzcGXYNZpKgoa1v2ir5yr-w
100	!UKcoTBWWxNEyixrjyM:localhost	m.room.power_levels		$EsIKBNaGky9gjqListPEKjQfFScHFrG5GuEQD0vyi9Q
101	!UKcoTBWWxNEyixrjyM:localhost	m.room.join_rules		$STt_lRcQQY1HR2YQmv4RsQMis1Xc5sWAamnHn02ddqk
102	!UKcoTBWWxNEyixrjyM:localhost	m.room.history_visibility		$KEhwfKMs0OrXZWYNQWK_YDu-mrG-UP2Do2VsAShloEY
103	!UKcoTBWWxNEyixrjyM:localhost	m.room.guest_access		$em_2PzgnditDYAzn8yY84PnmN1oNQZgI8Co6SjahtU8
104	!UKcoTBWWxNEyixrjyM:localhost	m.room.member	@matrix_a:localhost	$sdrkpiq94MhqjrSukg-aexI_3VlPxcoqiZXmrPvpQGw
106	!kAToIwhNWrDpgQVMfY:localhost	m.room.create		$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw
107	!kAToIwhNWrDpgQVMfY:localhost	m.room.member	@bridgeadmin:localhost	$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE
108	!kAToIwhNWrDpgQVMfY:localhost	m.room.power_levels		$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc
109	!kAToIwhNWrDpgQVMfY:localhost	m.room.canonical_alias		$fZAJc_jo3uwpjSNh7ULQOuzuMtHLVO8KdmygXkq-95M
110	!kAToIwhNWrDpgQVMfY:localhost	m.room.join_rules		$KGv2op0D-6TOpQuqb5Gl4YZxMUKn37cUNSylMiEo7SA
111	!kAToIwhNWrDpgQVMfY:localhost	m.room.guest_access		$XvSaPVUaER3JwP1gLc-c__oVTIjGs5YL10o0DSsZ3q0
112	!kAToIwhNWrDpgQVMfY:localhost	m.room.history_visibility		$zHrY9OvLbZTtN0bNPCDJg1HsmkgSV-pzAmxVIqaSB98
113	!kAToIwhNWrDpgQVMfY:localhost	m.room.name		$Np7HQ3SdNiYX3HhRJtJw4b80J96uY_IbqI_bL7w83m0
114	!kAToIwhNWrDpgQVMfY:localhost	m.room.topic		$nL-1meDVcMfCo41V5V5w3EBPwNdmll7Alfsp00QCHvk
116	!ffaaxOMHcWnINEXTWK:localhost	m.room.create		$wTlWqRh3eGNrru9CGqbzkNcL0kBGbtEB8sHZwsAboS0
123	!ffaaxOMHcWnINEXTWK:localhost	m.room.join_rules		$jLK4KwpKxGfwbMdz2oJbuUlHegeZ_5YucIy2ChSNCLg
128	!ffaaxOMHcWnINEXTWK:localhost	m.space.parent	!kAToIwhNWrDpgQVMfY:localhost	$zxy8zKV-5WiZDQEOGVCLyrd2yGWyYrOah4vQYAlc-xI
118	!cwnFZrIkYIOvkCHJkc:localhost	m.room.create		$AXgBEWEnQYL0m4F3qNGi4DDk7afIQe7a_hmRdZkAZLM
125	!cwnFZrIkYIOvkCHJkc:localhost	m.room.guest_access		$3ccBKAI_RT742spGFKzsNSBIzhj7WC7YBxugrDvyr4w
132	!cwnFZrIkYIOvkCHJkc:localhost	m.room.name		$ab5rFOQQuDGj00oHfJaJKURhG6lNFNDKS0nkBlsLTMk
135	!kAToIwhNWrDpgQVMfY:localhost	m.space.child	!cwnFZrIkYIOvkCHJkc:localhost	$v_Jh2P1U7Li3ATyMsxgipoyBuQRYv5HD-cv8JVNpdLc
119	!ffaaxOMHcWnINEXTWK:localhost	m.room.member	@bridgeadmin:localhost	$81gCIX2tUwDG_Jg02kHVceEfsUG1IOQ9-YnDk1cV15w
121	!ffaaxOMHcWnINEXTWK:localhost	m.room.power_levels		$pn5NPm28AfF5_169OnQQxTv4_ijcoN4k44UIvzGsN7k
122	!cwnFZrIkYIOvkCHJkc:localhost	m.room.power_levels		$PJZugFD-K6RtTB0vNzX1j0YFLZ9x4vli99YpMY9dzQk
134	!kAToIwhNWrDpgQVMfY:localhost	m.space.child	!cwnFZrIkYIOvkCHJkc:localhost	$v_Jh2P1U7Li3ATyMsxgipoyBuQRYv5HD-cv8JVNpdLc
120	!cwnFZrIkYIOvkCHJkc:localhost	m.room.member	@bridgeadmin:localhost	$41BPCZJ_9IbE7VgIqxEef1X7U2-FXJjTA25i2Q-n_gg
127	!cwnFZrIkYIOvkCHJkc:localhost	m.space.parent	!kAToIwhNWrDpgQVMfY:localhost	$7CUacT0Q8hFhLt80ecyLwLrizW7Jh6uNtLYApZIgNg4
124	!cwnFZrIkYIOvkCHJkc:localhost	m.room.join_rules		$ce28aY-iB2mpb8Gioxn_S-YFJtBn3dK4JRguWv9H2XY
136	!kAToIwhNWrDpgQVMfY:localhost	m.room.member	@matrix_a:localhost	$bFxX1nACgPihIeXfSiWHmW_hxrfmIgtQM9HWAPS2wVY
126	!ffaaxOMHcWnINEXTWK:localhost	m.room.guest_access		$Jy6RZhO0nZ0x_EgWugfJHW0XgWaR5DoWVaImG_wE3lg
129	!ffaaxOMHcWnINEXTWK:localhost	m.room.history_visibility		$e4RXblgeP3Sa0Hs3COmGOAFe9LclWYCrLIk7nF2PEDk
131	!ffaaxOMHcWnINEXTWK:localhost	m.room.name		$tWJ40KRMdaZwn6df_597mz_AyHLHUSEy0noQk3HlctY
130	!cwnFZrIkYIOvkCHJkc:localhost	m.room.history_visibility		$dLHdIN5p2aRYI16qULeP30FhKh5GGtUHvQUzWcSWyTA
133	!kAToIwhNWrDpgQVMfY:localhost	m.space.child	!ffaaxOMHcWnINEXTWK:localhost	$BNEpFvlxqdDF-6u3EPToNgfx0BuYX2_P9oWB486xTxM
137	!kAToIwhNWrDpgQVMfY:localhost	m.room.member	@matrix_b:localhost	$kL3ALUeGobajxL55gzYoIZLdD1CSD4sYXedIOysHwV0
139	!LwtGEdNVvQHvFLuWQB:localhost	m.room.create		$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q
140	!LwtGEdNVvQHvFLuWQB:localhost	m.room.member	@bridgeadmin:localhost	$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic
141	!LwtGEdNVvQHvFLuWQB:localhost	m.room.power_levels		$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k
142	!LwtGEdNVvQHvFLuWQB:localhost	m.room.join_rules		$PTHh0FcsZLrplrmwtCyvLjXr1yAZRgovFGLVt7qrrAo
143	!LwtGEdNVvQHvFLuWQB:localhost	m.room.history_visibility		$6CLZCTGtpIVnohQDg2sJwn_880f0--zCZpr6BgOwQ2Q
144	!LwtGEdNVvQHvFLuWQB:localhost	m.room.guest_access		$nKXxWIIoo5Vko9Z7kITUEeAsQgQnr-FLvhoQHfkCYAE
145	!LwtGEdNVvQHvFLuWQB:localhost	m.room.member	@admin:localhost	$TbFvVskFwRsxEgjNnOjfs4ljMJuZC60_Cqb91vOUrxg
146	!LwtGEdNVvQHvFLuWQB:localhost	m.room.encryption		$SuM_AupYZSEtAJBPHbvNkhJ4aIYEjT4c741wzkoOX4I
147	!LwtGEdNVvQHvFLuWQB:localhost	m.room.tombstone		$smbpaz4v1tYoI0ZZ-HXKXrcs19S7qioXa8ah6FeOBpc
149	!GNlLBsLXjbOuNhCkEO:localhost	m.room.create		$_-6CgruWK6UfiL1rgJnNUgtmp_jusf_3Vf7LUPB6xaU
150	!GNlLBsLXjbOuNhCkEO:localhost	m.room.member	@bridgeadmin:localhost	$yrfdAmX0K0lY65Dm9bViRYWOBKtvTB1kxkm6lNsThdw
151	!GNlLBsLXjbOuNhCkEO:localhost	m.room.power_levels		$uKKFUGwf_IAnbH81DTvAScd2HFnAwWWL_p4-E5B_YdU
152	!GNlLBsLXjbOuNhCkEO:localhost	m.room.encryption		$MRytSYI-n7aCgzUssVx9vLIC5Y-Yt22y_L1eQoE4GgE
153	!GNlLBsLXjbOuNhCkEO:localhost	m.room.guest_access		$ah5gH_XfCIYeCtl2NFxHSgdd_OE6O9tHe2U1Pn2Qvhc
154	!GNlLBsLXjbOuNhCkEO:localhost	m.room.history_visibility		$lnpmPOjrFoaPq58156r6g4G7gYfejQ2BfcFkjGiEX-I
155	!GNlLBsLXjbOuNhCkEO:localhost	m.room.join_rules		$fuvIFJYv32qkEsYyW8XNHbQ0hmQ5HHRjF6UEjte6Z-c
156	!LwtGEdNVvQHvFLuWQB:localhost	m.room.power_levels		$O-kcGXcFLVtSNAY7CxqW4hLVBk0UqhADtIs1kCz8hlA
157	!GNlLBsLXjbOuNhCkEO:localhost	m.room.power_levels		$mrothtkO8tebjJGeNAwAffr795rF0DPgaeqd5sjoqZc
158	!GNlLBsLXjbOuNhCkEO:localhost	m.room.member	@admin:localhost	$vesveJhdimZ9d-Po76D8SZCUm8dVzl0GcQsvVX8lhos
159	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@admin:localhost	$8xsczNZMt4ghZ8hOUKpNfmtfhHntQ3qyCBw5y4BlHwM
160	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@admin:localhost	$yc93OwlIQJ1Ogm8WEiqk1PQRKJU563w_qzdsBTXvUP0
161	!GNlLBsLXjbOuNhCkEO:localhost	m.room.member	@admin:localhost	$nfronhC7iKGPRmKJ7zoXzYG7VKiOq5FoUIcfHg3a4Dg
162	!MrxfbdodytWwBMqNiF:localhost	m.room.member	@admin:localhost	$Pem9TyngNuhpIq_NI2krx6wpkVigoBj6JCeB3WUezVk
163	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$xRDhFDASTtdpw1L9BgruXmozbigfPYpBzTqq4XcEnbM
164	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$WLynpBgpDpk4jol3Hh8HJLzlEBLNRxx5IPFaik0uUvo
165	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a_:localhost	$m4SBTrAiyFOgwXP_n4DR6ETWWaN6q6X_bhEHAhUO6Nc
166	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a_:localhost	$THfYLOl_hf5GFx0WV30l5vb-jrKxuql09UWcThqr1ng
167	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a_:localhost	$73EMecMC3DNTuQvrCNNFTwIyq8le_uRbahE0rG2Y41o
168	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a_:localhost	$wCgjRMcm13QlBXMYRsncuxbnCziYKP8cDUQKyybUKoU
169	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a_:localhost	$v9kHVKt3C7jK6Zc7vPFiPRi1EGSZpr_aV8SQLdj18RM
170	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_matrix_matrix_a:localhost	$Cj1lGN-eHKb-4c7e15DUicGty5qyiwejGTFrXrHCPls
171	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a_:localhost	$4iJRiSxWb7vSXM_gTgzWeFHE4KVFEqghA4nTV2IeUiQ
172	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_matrix_matrix_a:localhost	$e93QytCN7H8T9HqAWIF_sNsBsTUMiPrT3wiLBNoalt0
173	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_matrix_matrix_a:localhost	$lqcDJmmnWI5ZbJe3tsEVs2AcPqQFiSVZAqhjJqkKb9w
174	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a_:localhost	$iJbdwiLJri5GvqozCWuWnwewl09YpmiATcChoIdHH2U
175	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b_:localhost	$BTe_dHBq8KdVZEJifCfJinAGaiBO0tk1kSTykEUiSyk
176	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a_:localhost	$KD3fR6oDFKQIBoLnsPUw43We52WoezEjNfWVcT58Ar8
177	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_matrix_matrix_a:localhost	$i3LsyYPgVIj7mSl41uVCNmY1UDYyUwQAnOllWICcAXI
178	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b_:localhost	$xKu0tXyKXqHV5bWc8yuk2XHg12GnIoagN5QX-fIcByU
179	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b_:localhost	$qGwpNteqBFuv5YAmCwb-YJ6-wXcYe3wSuM8u8hdYvLE
180	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_matrix_matrix_b:localhost	$jhsFpnZfsVsEbgyBh8EI6x2LfibzGlMmIZnE2Tvhe90
181	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_matrix_matrix_b:localhost	$mU3wVh_PVql6beqrNhllADjuwGk1ADjBHUgeMYEPBbA
182	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b_:localhost	$cqALIjoFjHIahC0BVvgDVxl6_44o5wmej-8t198aAvM
183	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_matrix_matrix_b:localhost	$5b0a6UvvtICUqbY9X1O5xVlvEtcgyn12MGHan0HDJlc
184	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b_:localhost	$pzxqJAY8An4DMY1tfDwDnYrsVnc5yghXpFLZzbBC1Jo
185	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_matrix_matrix_b:localhost	$44PFCCW8RSdcjqTSJ-VOD_uJqmsj5nT89WUSRWSLDOg
186	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b_:localhost	$CBsW6Bv7UyBlZ9DpjmGZCH-IKo0JdymhSkGaE-Sa1Ow
187	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_matrix_matrix_b:localhost	$GDx9o96T1xZHDFgk4CrVqrBL-rksEMxsn0SXHC-0R_k
188	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_matrix_matrix_a:localhost	$iACcMxD_VszJkWyIhHdBjJ_csrmL0tgRvl9r4hK_QVw
189	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b_:localhost	$ESNEgoAL2C3c_ziVmTDVM56c-z2eWod4kiPDkoB0IoY
190	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_matrix_matrix_b:localhost	$YwdD4feP6crA1CTaoZ-9VPQKsD_ipGXZZKmFD8ONSAQ
191	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_matrix_matrix_a:localhost	$fxvC3xtD69l_p-ZT7BMP16SFmaeTYOCdmh5G69-k54M
192	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_matrix_matrix_b:localhost	$PUKQSi4SX_465dj8Zg4jJ7IeA9AfysAMb2aHmIgitcc
193	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b_:localhost	$s3b7zmrcr8AZvGT6Sw6yXnrTircBUHpdCpBkTFguG9s
194	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_matrix_matrix_a:localhost	$oJLkahlF0aI11PKyA3Hcyqgccyz3wHN-KcoK4s4gKQo
201	!nPrdOOfNMRrmJedabn:localhost	m.room.member	@admin:localhost	$AMnH95Ky85GttLR7j9XHrHyULlBBezFJ9w8mtji-7Ok
195	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_matrix_matrix_b:localhost	$uWtY4ot6KzO7AMco44rkspGXsjDSyHh4GtBVQIs2eJw
200	!nPrdOOfNMRrmJedabn:localhost	m.room.create		$A5h106ytjQ2qqPxkSylhOkJgVZQCscB4QX0PK60qxU0
196	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_matrix_matrix_a:localhost	$lJ4fGtoJqlDGuef6bH6631xLHgrZqELTWOErVr3zBE8
197	!MrxfbdodytWwBMqNiF:localhost	m.room.encryption		$viSFX8RvY5fe8TiOaDirNG6PqooEHTTV3PT3hrQgVLA
198	!MrxfbdodytWwBMqNiF:localhost	m.room.tombstone		$MT4EKTmcPC8LCVeATiG-5a71N2Zc1vNQcgKge5W0on8
207	!MrxfbdodytWwBMqNiF:localhost	m.room.power_levels		$eOC3-FZNb3jb3NisHG61gQhQ_hf9zWu0xvpfs8ZKDTg
202	!nPrdOOfNMRrmJedabn:localhost	m.room.power_levels		$gDW6j_UqhvIRf1ANEKurSD9fB4Hl4YnQ5uL9cy_U7Os
205	!nPrdOOfNMRrmJedabn:localhost	m.room.guest_access		$yfuDQBYjEI6CCa3AdtfdjL_ZXIR0d92TRfHnh7Gq0zc
203	!nPrdOOfNMRrmJedabn:localhost	m.room.join_rules		$0gszMJtyESzwVMh4olwTajdbj1MrrJYVnylO0yOIpSg
204	!nPrdOOfNMRrmJedabn:localhost	m.room.history_visibility		$2lEnFzGdtIu4kGthBBXcP0gW6sUWKP8c1x9I4-yFWso
209	!nPrdOOfNMRrmJedabn:localhost	m.room.member	@bridgeuser1:localhost	$usag8slAxKA2dWWERksMiBQ8hRwfGZ8nZzTfcymZxyE
206	!nPrdOOfNMRrmJedabn:localhost	m.room.encryption		$xyV3lysb-dda01bB4LpALdmaTC_mLZDhwxOE9L4zpXY
208	!nPrdOOfNMRrmJedabn:localhost	m.room.power_levels		$uz-oYzJMCuBOk8PIx6WmLciQUJ8_PEAei2TfFFC-ccQ
210	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@bridgeadmin:localhost	$O04OV5x9R_5W2IT9G9Z-dXJmfV6fgtZM8-4ogFp9rEw
211	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@bridgeuser1:localhost	$-QMfwsu75_SWJtzFqIsrFjLgl_XBqF6HcorcUjLTsWY
212	!nPrdOOfNMRrmJedabn:localhost	m.room.member	@admin:localhost	$2Wnr71fAdbGyyUyhiqrfnEJcIHAZyuCqEiwv2KgHMzA
213	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@admin:localhost	$Y04ROgkrQyNtYJbPKIsqZvSyp1Th3SAusNK34A3U3Hc
214	!MrxfbdodytWwBMqNiF:localhost	m.room.member	@admin:localhost	$NE0OtjpKue1xYSdbOT8qccobMlUQmvpOIxCzOdVIrm8
215	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@admin:localhost	$mnswj7WVVSEwuuCxD_dxP2dfUKUadM-v2R4tvSGbjk0
216	!GNlLBsLXjbOuNhCkEO:localhost	m.room.member	@admin:localhost	$DO-aeVkP_VpLsVO24WlrbvOYm50Ly8YVtsIyUCeXhrY
217	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_a:localhost	$nxGZiCt5sPNvx_9WR4yzJQ4GTGceWLmYEsyA_pzb808
218	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	$80bVl7TPEhI3PqH7QSJ2xNnkw8fqbeM_BVsB__WK9d0
219	!LwtGEdNVvQHvFLuWQB:localhost	m.room.member	@admin:localhost	$WsVhQvsUsrFormgSdFA_Z_Io7y9fxZy5juqaM8oYpkg
220	!UKcoTBWWxNEyixrjyM:localhost	m.room.member	@matrix_a:localhost	$hooKnajA7nQRs3MZDj_evGyHCyHpg4QmGp2i5WRKzp0
221	!kAToIwhNWrDpgQVMfY:localhost	m.room.member	@matrix_a:localhost	$rNG4YvsFCU9LVcVcHEkbBRGSuEH_QqO_hMEZ-sC8WH8
\.


--
-- Data for Name: stats_incremental_position; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.stats_incremental_position (lock, stream_id) FROM stdin;
X	139
\.


--
-- Data for Name: stream_ordering_to_exterm; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.stream_ordering_to_exterm (stream_ordering, room_id, event_id) FROM stdin;
20	!kmbTYjjsDRDHGgVqUP:localhost	$Gad828L2lbbiaAIvm-6i6rVLLqhtJ9VlTAe-BZmqMok
21	!dKcbdDATuwwphjRPQP:localhost	$IxTn90_rCNkgt5i11IL8BnZy2EsO6B4YO9Ixt3M1OUQ
22	!dKcbdDATuwwphjRPQP:localhost	$7TwPfUMTevEcf7wLvbgx3LG01lYT_yGudYiOVlkGU7E
23	!kmbTYjjsDRDHGgVqUP:localhost	$jAifmicJfMyB1QPFQ6KFQ7ZqTqQ58RJXsH5viWn3ZUg
24	!dKcbdDATuwwphjRPQP:localhost	$DsZXxk2rEIB2tF3pYUdOPjrMwclo8BXltutiWCnKUIU
25	!kmbTYjjsDRDHGgVqUP:localhost	$NyVGoA-ZaMPbk_RzpmLOajRS1nEBirO7Du2KpA9Eo64
26	!dKcbdDATuwwphjRPQP:localhost	$JwL8EK5sa4vg29tclnHwa5jrpCTa8oZVOIsgFyivQdY
27	!kmbTYjjsDRDHGgVqUP:localhost	$JcoTJcBGASUqIK9V7j6ND5Jt6P9gdbNJxXxQBZNg8z4
28	!dKcbdDATuwwphjRPQP:localhost	$2KnXfE3sZw8LDrOAaEP4HdQuw5neshhvyZKtnwo5cg0
29	!kmbTYjjsDRDHGgVqUP:localhost	$isXWKf_B_7Z7R7jYn_2gZB-U31TuzMehBRxj5701Lq8
30	!kmbTYjjsDRDHGgVqUP:localhost	$rVK77mVSpz5EHxI2mbLxilqbkLxKhXEiusPFjapVPbw
31	!kmbTYjjsDRDHGgVqUP:localhost	$5agO4kI6VqJHGKvKbkqUa2Y3cTwUBrjAhmCVtj9JmKU
32	!dKcbdDATuwwphjRPQP:localhost	$4JiNeQHyMbyuEfymLkE-SEzPUh3bWddjxa6-5w36nJw
33	!kmbTYjjsDRDHGgVqUP:localhost	$Y_S-fF0iLu0OHNMcZdYVzt0we_qL_t8_4QIKGeobLdI
34	!dKcbdDATuwwphjRPQP:localhost	$g1kV-jEZBtN9l6VGGo2MN-wQn7RR7J-Tv5LfyJ5Z5fc
35	!kmbTYjjsDRDHGgVqUP:localhost	$CQg_jKvdpWFvaiLH2f5MtTnu1Zwxi8P4QPSJZum91dw
36	!dKcbdDATuwwphjRPQP:localhost	$OcvCF7YNeTKFnzz4EWVjFJIF9QidMEUmomHIvH3d2W8
37	!kmbTYjjsDRDHGgVqUP:localhost	$GrqoJ52XSgRaoc4wPEYLdL2p6t3jl0aiFd8bYswQQcU
38	!dKcbdDATuwwphjRPQP:localhost	$5TE1hAtSTolrY9QTj9Wt8DnKurFa3P6KIfGkWOJbrY4
39	!kmbTYjjsDRDHGgVqUP:localhost	$UYXKiTPqFr31PwoZzi35ODpdRK0hwJVjVGC1N7kR7yk
40	!dKcbdDATuwwphjRPQP:localhost	$YFCWkh6b_jgrSjje7vt6JB6-uLPRz7Na1VgGh0PwdI8
41	!kmbTYjjsDRDHGgVqUP:localhost	$h2yGPxzdKWUBUSFQiOgFiRoNa8NgWHYXdy_2SMJx6ns
42	!dKcbdDATuwwphjRPQP:localhost	$kmvnPONhcKxIpG62sV6apngYToshpP0mBrwpKL0hAOI
43	!kmbTYjjsDRDHGgVqUP:localhost	$KgpvpFIMQIVFvm0adBZqAbWANmMgdu1_1jbP71RuM48
44	!dKcbdDATuwwphjRPQP:localhost	$qWi32T1tK2APgSwc4y_6f0e_N_fUPmIBxC5ACk1h6NM
45	!kmbTYjjsDRDHGgVqUP:localhost	$jvwVmkElpx8M62JlaBz7nJ4qa2U8tVO7V9-HhJ-n8JI
46	!dKcbdDATuwwphjRPQP:localhost	$0WsTO-QKZzqtMdl5UwGJc5h4e7YAE5ZGp_GDMb9K824
47	!kmbTYjjsDRDHGgVqUP:localhost	$opS4sT6APXaq4vDdegPq6ik1z-yX-FkMTAqhGtTWXEE
48	!dKcbdDATuwwphjRPQP:localhost	$l5dYt-R2kpcKdlmMRFnzC5N9PjiV4DZ63c1bTGPOCXk
49	!dKcbdDATuwwphjRPQP:localhost	$NxuVtjeVql0_aadDlNux0yeeR_PxcpcJPnX1SdoDmXM
50	!MrxfbdodytWwBMqNiF:localhost	$y0PX667o4XHmzssKrLqUpxmbf5Im4M7K4jYQdRIawfY
51	!MrxfbdodytWwBMqNiF:localhost	$89n67RlAmtb8nRuxie-oq3g9grnkpjzJMAhbJ8h_8Xw
52	!MrxfbdodytWwBMqNiF:localhost	$ktzvgKdVV2kPiWj8kJXJEyoPGitHvIYOglOdkcOz8WA
53	!MrxfbdodytWwBMqNiF:localhost	$TVXtgqtZ5WfNfZEnJQx6m0NYwp0_34ylOK87XzZ3JlI
54	!MrxfbdodytWwBMqNiF:localhost	$JQ7PDbgzTTAY5uHFM6NV0ovadfzQLOpcAcrSX5mRUi0
55	!MrxfbdodytWwBMqNiF:localhost	$9MVFB3q88VYxhDZMX087Uv4c3h3uEpluJN0q33ubtso
56	!MrxfbdodytWwBMqNiF:localhost	$V_QrTFMCwHlrg-MSVVplcYCRVWM_QgXhIvp-2R_LtHI
57	!MrxfbdodytWwBMqNiF:localhost	$Nv-ymHeLYsZKVjdilAoBLGC4GlzNJWt1HBqtIlSIz1k
58	!UKcoTBWWxNEyixrjyM:localhost	$yZwQJfxjuLFOlfyTYw-M1aupZjmck-aVfpfSYx5fj1I
59	!UKcoTBWWxNEyixrjyM:localhost	$sqtTmHJJ_e6UeDKORkztLzcGXYNZpKgoa1v2ir5yr-w
60	!UKcoTBWWxNEyixrjyM:localhost	$EsIKBNaGky9gjqListPEKjQfFScHFrG5GuEQD0vyi9Q
61	!UKcoTBWWxNEyixrjyM:localhost	$STt_lRcQQY1HR2YQmv4RsQMis1Xc5sWAamnHn02ddqk
62	!UKcoTBWWxNEyixrjyM:localhost	$KEhwfKMs0OrXZWYNQWK_YDu-mrG-UP2Do2VsAShloEY
63	!UKcoTBWWxNEyixrjyM:localhost	$em_2PzgnditDYAzn8yY84PnmN1oNQZgI8Co6SjahtU8
64	!UKcoTBWWxNEyixrjyM:localhost	$sdrkpiq94MhqjrSukg-aexI_3VlPxcoqiZXmrPvpQGw
65	!UKcoTBWWxNEyixrjyM:localhost	$-JWBJJpXpVo-YhtBYaJDTakzo94Jhn_XGlhnLzEWxyc
66	!kAToIwhNWrDpgQVMfY:localhost	$E88mk1ze6pGkaDk7lUbXqHxKQMmVkXUhpjQb0Cz-IKw
67	!kAToIwhNWrDpgQVMfY:localhost	$rnBcYpci4Pbi7f-_9_KKUI50pR-sgdzM163VjNEx0iE
68	!kAToIwhNWrDpgQVMfY:localhost	$-5KP6nnjuha4o5CO-BBSkF5mweUk7a8uBcFLQsFdjTc
69	!kAToIwhNWrDpgQVMfY:localhost	$fZAJc_jo3uwpjSNh7ULQOuzuMtHLVO8KdmygXkq-95M
70	!kAToIwhNWrDpgQVMfY:localhost	$KGv2op0D-6TOpQuqb5Gl4YZxMUKn37cUNSylMiEo7SA
71	!kAToIwhNWrDpgQVMfY:localhost	$XvSaPVUaER3JwP1gLc-c__oVTIjGs5YL10o0DSsZ3q0
72	!kAToIwhNWrDpgQVMfY:localhost	$zHrY9OvLbZTtN0bNPCDJg1HsmkgSV-pzAmxVIqaSB98
73	!kAToIwhNWrDpgQVMfY:localhost	$Np7HQ3SdNiYX3HhRJtJw4b80J96uY_IbqI_bL7w83m0
74	!kAToIwhNWrDpgQVMfY:localhost	$nL-1meDVcMfCo41V5V5w3EBPwNdmll7Alfsp00QCHvk
75	!ffaaxOMHcWnINEXTWK:localhost	$wTlWqRh3eGNrru9CGqbzkNcL0kBGbtEB8sHZwsAboS0
76	!cwnFZrIkYIOvkCHJkc:localhost	$AXgBEWEnQYL0m4F3qNGi4DDk7afIQe7a_hmRdZkAZLM
77	!ffaaxOMHcWnINEXTWK:localhost	$81gCIX2tUwDG_Jg02kHVceEfsUG1IOQ9-YnDk1cV15w
78	!cwnFZrIkYIOvkCHJkc:localhost	$41BPCZJ_9IbE7VgIqxEef1X7U2-FXJjTA25i2Q-n_gg
79	!ffaaxOMHcWnINEXTWK:localhost	$pn5NPm28AfF5_169OnQQxTv4_ijcoN4k44UIvzGsN7k
80	!cwnFZrIkYIOvkCHJkc:localhost	$PJZugFD-K6RtTB0vNzX1j0YFLZ9x4vli99YpMY9dzQk
81	!ffaaxOMHcWnINEXTWK:localhost	$jLK4KwpKxGfwbMdz2oJbuUlHegeZ_5YucIy2ChSNCLg
82	!cwnFZrIkYIOvkCHJkc:localhost	$ce28aY-iB2mpb8Gioxn_S-YFJtBn3dK4JRguWv9H2XY
84	!ffaaxOMHcWnINEXTWK:localhost	$Jy6RZhO0nZ0x_EgWugfJHW0XgWaR5DoWVaImG_wE3lg
83	!cwnFZrIkYIOvkCHJkc:localhost	$3ccBKAI_RT742spGFKzsNSBIzhj7WC7YBxugrDvyr4w
85	!cwnFZrIkYIOvkCHJkc:localhost	$7CUacT0Q8hFhLt80ecyLwLrizW7Jh6uNtLYApZIgNg4
86	!ffaaxOMHcWnINEXTWK:localhost	$zxy8zKV-5WiZDQEOGVCLyrd2yGWyYrOah4vQYAlc-xI
87	!ffaaxOMHcWnINEXTWK:localhost	$e4RXblgeP3Sa0Hs3COmGOAFe9LclWYCrLIk7nF2PEDk
88	!cwnFZrIkYIOvkCHJkc:localhost	$dLHdIN5p2aRYI16qULeP30FhKh5GGtUHvQUzWcSWyTA
89	!ffaaxOMHcWnINEXTWK:localhost	$tWJ40KRMdaZwn6df_597mz_AyHLHUSEy0noQk3HlctY
90	!cwnFZrIkYIOvkCHJkc:localhost	$ab5rFOQQuDGj00oHfJaJKURhG6lNFNDKS0nkBlsLTMk
94	!kAToIwhNWrDpgQVMfY:localhost	$kL3ALUeGobajxL55gzYoIZLdD1CSD4sYXedIOysHwV0
91	!kAToIwhNWrDpgQVMfY:localhost	$BNEpFvlxqdDF-6u3EPToNgfx0BuYX2_P9oWB486xTxM
92	!kAToIwhNWrDpgQVMfY:localhost	$v_Jh2P1U7Li3ATyMsxgipoyBuQRYv5HD-cv8JVNpdLc
92	!kAToIwhNWrDpgQVMfY:localhost	$BNEpFvlxqdDF-6u3EPToNgfx0BuYX2_P9oWB486xTxM
93	!kAToIwhNWrDpgQVMfY:localhost	$bFxX1nACgPihIeXfSiWHmW_hxrfmIgtQM9HWAPS2wVY
95	!cwnFZrIkYIOvkCHJkc:localhost	$b_nOg7oeQd8bhYHe5kvgAdNM0U6hcAUFdf-yhgbItfc
96	!LwtGEdNVvQHvFLuWQB:localhost	$egk0sY1Wds5-tfXAtWSfb9wF3EV1AdLxoK1ZAGX7h2Q
97	!LwtGEdNVvQHvFLuWQB:localhost	$NQNd2niCwXk6WNhMazcfAzebeTL1pcDAt4vE4_EgSic
98	!LwtGEdNVvQHvFLuWQB:localhost	$POW-J2AHoC4tTbHB7k1oe7UTjMokNXouIimLuWnxO2k
99	!LwtGEdNVvQHvFLuWQB:localhost	$PTHh0FcsZLrplrmwtCyvLjXr1yAZRgovFGLVt7qrrAo
100	!LwtGEdNVvQHvFLuWQB:localhost	$6CLZCTGtpIVnohQDg2sJwn_880f0--zCZpr6BgOwQ2Q
101	!LwtGEdNVvQHvFLuWQB:localhost	$nKXxWIIoo5Vko9Z7kITUEeAsQgQnr-FLvhoQHfkCYAE
102	!LwtGEdNVvQHvFLuWQB:localhost	$TbFvVskFwRsxEgjNnOjfs4ljMJuZC60_Cqb91vOUrxg
103	!LwtGEdNVvQHvFLuWQB:localhost	$Fu0mjSRDDuhZx4RxMK6O8cvc6t75G99rXoFXGU-7868
104	!LwtGEdNVvQHvFLuWQB:localhost	$SuM_AupYZSEtAJBPHbvNkhJ4aIYEjT4c741wzkoOX4I
105	!GNlLBsLXjbOuNhCkEO:localhost	$_-6CgruWK6UfiL1rgJnNUgtmp_jusf_3Vf7LUPB6xaU
106	!GNlLBsLXjbOuNhCkEO:localhost	$yrfdAmX0K0lY65Dm9bViRYWOBKtvTB1kxkm6lNsThdw
107	!GNlLBsLXjbOuNhCkEO:localhost	$uKKFUGwf_IAnbH81DTvAScd2HFnAwWWL_p4-E5B_YdU
108	!GNlLBsLXjbOuNhCkEO:localhost	$MRytSYI-n7aCgzUssVx9vLIC5Y-Yt22y_L1eQoE4GgE
109	!GNlLBsLXjbOuNhCkEO:localhost	$ah5gH_XfCIYeCtl2NFxHSgdd_OE6O9tHe2U1Pn2Qvhc
110	!GNlLBsLXjbOuNhCkEO:localhost	$lnpmPOjrFoaPq58156r6g4G7gYfejQ2BfcFkjGiEX-I
111	!GNlLBsLXjbOuNhCkEO:localhost	$fuvIFJYv32qkEsYyW8XNHbQ0hmQ5HHRjF6UEjte6Z-c
112	!LwtGEdNVvQHvFLuWQB:localhost	$smbpaz4v1tYoI0ZZ-HXKXrcs19S7qioXa8ah6FeOBpc
113	!LwtGEdNVvQHvFLuWQB:localhost	$O-kcGXcFLVtSNAY7CxqW4hLVBk0UqhADtIs1kCz8hlA
114	!GNlLBsLXjbOuNhCkEO:localhost	$vesveJhdimZ9d-Po76D8SZCUm8dVzl0GcQsvVX8lhos
115	!GNlLBsLXjbOuNhCkEO:localhost	$nfronhC7iKGPRmKJ7zoXzYG7VKiOq5FoUIcfHg3a4Dg
116	!MrxfbdodytWwBMqNiF:localhost	$Pem9TyngNuhpIq_NI2krx6wpkVigoBj6JCeB3WUezVk
117	!MrxfbdodytWwBMqNiF:localhost	$Fe89WlTUpNMZrgSmSzGQHSt495sI5DkA-kewln3Ug70
118	!MrxfbdodytWwBMqNiF:localhost	$viSFX8RvY5fe8TiOaDirNG6PqooEHTTV3PT3hrQgVLA
119	!nPrdOOfNMRrmJedabn:localhost	$A5h106ytjQ2qqPxkSylhOkJgVZQCscB4QX0PK60qxU0
120	!nPrdOOfNMRrmJedabn:localhost	$AMnH95Ky85GttLR7j9XHrHyULlBBezFJ9w8mtji-7Ok
121	!nPrdOOfNMRrmJedabn:localhost	$gDW6j_UqhvIRf1ANEKurSD9fB4Hl4YnQ5uL9cy_U7Os
122	!nPrdOOfNMRrmJedabn:localhost	$0gszMJtyESzwVMh4olwTajdbj1MrrJYVnylO0yOIpSg
123	!nPrdOOfNMRrmJedabn:localhost	$2lEnFzGdtIu4kGthBBXcP0gW6sUWKP8c1x9I4-yFWso
124	!nPrdOOfNMRrmJedabn:localhost	$yfuDQBYjEI6CCa3AdtfdjL_ZXIR0d92TRfHnh7Gq0zc
125	!nPrdOOfNMRrmJedabn:localhost	$xyV3lysb-dda01bB4LpALdmaTC_mLZDhwxOE9L4zpXY
126	!MrxfbdodytWwBMqNiF:localhost	$MT4EKTmcPC8LCVeATiG-5a71N2Zc1vNQcgKge5W0on8
127	!MrxfbdodytWwBMqNiF:localhost	$eOC3-FZNb3jb3NisHG61gQhQ_hf9zWu0xvpfs8ZKDTg
128	!nPrdOOfNMRrmJedabn:localhost	$usag8slAxKA2dWWERksMiBQ8hRwfGZ8nZzTfcymZxyE
129	!dKcbdDATuwwphjRPQP:localhost	$O04OV5x9R_5W2IT9G9Z-dXJmfV6fgtZM8-4ogFp9rEw
130	!dKcbdDATuwwphjRPQP:localhost	$-QMfwsu75_SWJtzFqIsrFjLgl_XBqF6HcorcUjLTsWY
131	!kmbTYjjsDRDHGgVqUP:localhost	$Wj4b7gcXdhL474sxg5O6Kh7tBw4O5BtHv_KJEd3KXfM
132	!kmbTYjjsDRDHGgVqUP:localhost	$ZYEqhm3M07nXRAh1U842uZ1squBm9wa5H1Wb2-LjE1c
133	!LwtGEdNVvQHvFLuWQB:localhost	$WsVhQvsUsrFormgSdFA_Z_Io7y9fxZy5juqaM8oYpkg
134	!GNlLBsLXjbOuNhCkEO:localhost	$r8P3KtaOOCBm8XKydsvp0N-cG5BAE1YKU5MumKzWUI8
135	!dKcbdDATuwwphjRPQP:localhost	$p0-tc7QWKDmREIJlluolf1RQ-uKnVDhx5d_JQY9PX5E
136	!kmbTYjjsDRDHGgVqUP:localhost	$GmUIImAeTzvNSV5qvb40ScXGL3dlsX4DDnmg28rkzk4
137	!UKcoTBWWxNEyixrjyM:localhost	$hooKnajA7nQRs3MZDj_evGyHCyHpg4QmGp2i5WRKzp0
138	!UKcoTBWWxNEyixrjyM:localhost	$kwgJJLzgJAXgzd-lj8uFVnrjX5yqfNOtOcPrcl87hXU
139	!kAToIwhNWrDpgQVMfY:localhost	$rNG4YvsFCU9LVcVcHEkbBRGSuEH_QqO_hMEZ-sC8WH8
\.


--
-- Data for Name: stream_positions; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.stream_positions (stream_name, instance_name, stream_id) FROM stdin;
account_data	master	97
presence_stream	master	79
receipts	master	9
events	master	139
\.


--
-- Data for Name: threepid_guest_access_tokens; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.threepid_guest_access_tokens (medium, address, guest_access_token, first_inviter) FROM stdin;
\.


--
-- Data for Name: threepid_validation_session; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.threepid_validation_session (session_id, medium, address, client_secret, last_send_attempt, validated_at) FROM stdin;
\.


--
-- Data for Name: threepid_validation_token; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.threepid_validation_token (token, session_id, next_link, expires) FROM stdin;
\.


--
-- Data for Name: ui_auth_sessions; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.ui_auth_sessions (session_id, creation_time, serverdict, clientdict, uri, method, description) FROM stdin;
vYHtkGQzjCRGQGntgyWPCImi	1672417282130	{"request_user_id":"@bridgeuser1:localhost"}	{"master_key":{"user_id":"@bridgeuser1:localhost","usage":["master"],"keys":{"ed25519:w5ZDKLgy8s/zJcQqFSakpVOkhfD6wwSCMtHe/A5F8aA":"w5ZDKLgy8s/zJcQqFSakpVOkhfD6wwSCMtHe/A5F8aA"},"signatures":{"@bridgeuser1:localhost":{"ed25519:PIMRNBVGGO":"IyuxoLNlREwjZeu//gIYNveeCLsX1+uljxmOtL0UqMwR+rgW0/bSS1UJCAafrK7Nsuvw7AC3OU5c+dB7zB7+BQ"}}},"self_signing_key":{"user_id":"@bridgeuser1:localhost","usage":["self_signing"],"keys":{"ed25519:kUDSn4KiZiCcP4F90Ie7lDJI3gZSFG4uvqF0PnghnY0":"kUDSn4KiZiCcP4F90Ie7lDJI3gZSFG4uvqF0PnghnY0"},"signatures":{"@bridgeuser1:localhost":{"ed25519:w5ZDKLgy8s/zJcQqFSakpVOkhfD6wwSCMtHe/A5F8aA":"zRLXEwsrBYEOfLJerlyd1fcezWwq9DJqrKAJaMckP7lfqBkYzEtRmWeEwdL/pJ3SJJdXYF/uoq386wO4Qg3bAA"}}},"user_signing_key":{"user_id":"@bridgeuser1:localhost","usage":["user_signing"],"keys":{"ed25519:+v/mig1JkHpSzHpyR9St6A3qlLuPyUtaHokfjmG2VHs":"+v/mig1JkHpSzHpyR9St6A3qlLuPyUtaHokfjmG2VHs"},"signatures":{"@bridgeuser1:localhost":{"ed25519:w5ZDKLgy8s/zJcQqFSakpVOkhfD6wwSCMtHe/A5F8aA":"lWCGxjjiUyEYeMG27+R5OVlt0hMcd/CFX5UmOP8iqOfXx2K8CAvb7POEl2KSA/VhvR3pmqkAokt13XRoYE/cCw"}}}}	/_matrix/client/unstable/keys/device_signing/upload	POST	add a device signing key to your account
aJDtUFmtZkIujAJztHzipRlV	1672417286636	{"request_user_id":"@bridgeuser1:localhost"}	{"master_key":{"user_id":"@bridgeuser1:localhost","usage":["master"],"keys":{"ed25519:zteJCkUnxQzhF4okQ2ovjX3zv8nD7hpOQNDT3uD3+28":"zteJCkUnxQzhF4okQ2ovjX3zv8nD7hpOQNDT3uD3+28"},"signatures":{"@bridgeuser1:localhost":{"ed25519:PIMRNBVGGO":"5GWh6iuhXf3H00Vhir7HWdsQZQKku590m27DQBtaV5uQAKyWpCbADVWXtU4RuRMxzIB+s6jrCsFT1Bl4wii6Ag"}}},"self_signing_key":{"user_id":"@bridgeuser1:localhost","usage":["self_signing"],"keys":{"ed25519:Wz7fNdlInlfXqnzqgJGh+HWKW8keLaporidKHuX1Ads":"Wz7fNdlInlfXqnzqgJGh+HWKW8keLaporidKHuX1Ads"},"signatures":{"@bridgeuser1:localhost":{"ed25519:zteJCkUnxQzhF4okQ2ovjX3zv8nD7hpOQNDT3uD3+28":"0rSSpp0FvOfLtBqw8wby2urM57uTzJ79uHFPNkwtP6PDrKzfcymrswCQ3zE0gXsYMyy0jW/QfNOMhYIVsTbfDA"}}},"user_signing_key":{"user_id":"@bridgeuser1:localhost","usage":["user_signing"],"keys":{"ed25519:+lduEpQRIXBYvQ8RCKg9jZmJ1CdmMuAokrJKKL+eDrM":"+lduEpQRIXBYvQ8RCKg9jZmJ1CdmMuAokrJKKL+eDrM"},"signatures":{"@bridgeuser1:localhost":{"ed25519:zteJCkUnxQzhF4okQ2ovjX3zv8nD7hpOQNDT3uD3+28":"1sbVfblsHJP4vjZBUNggoRHsqjSd4dljFug1R4Z2xXSvi9jCf6+q0FmXdrMewomfOZYmv6/1VV5weQYwPHSgDg"}}}}	/_matrix/client/unstable/keys/device_signing/upload	POST	add a device signing key to your account
LneOlMumvrJFqCFiqVXBVmQn	1672417292866	{"request_user_id":"@bridgeuser1:localhost"}	{"master_key":{"user_id":"@bridgeuser1:localhost","usage":["master"],"keys":{"ed25519:Pi4zWwBar7EBJpj8LTyoiMTYINPoeTJKSKNKhT8EBB4":"Pi4zWwBar7EBJpj8LTyoiMTYINPoeTJKSKNKhT8EBB4"},"signatures":{"@bridgeuser1:localhost":{"ed25519:PIMRNBVGGO":"O1ve5vzdQPXSM0W7zQjft1EfBR+T+0bHNIJCkZS/4PRz+P8m1MHFQxK5FKNXEQPaS9OQ8OMCLIhXd05x83vHDA"}}},"self_signing_key":{"user_id":"@bridgeuser1:localhost","usage":["self_signing"],"keys":{"ed25519:RId/hQ856a8USrG4rkavtsXddR7QzljrGGly47xD4V4":"RId/hQ856a8USrG4rkavtsXddR7QzljrGGly47xD4V4"},"signatures":{"@bridgeuser1:localhost":{"ed25519:Pi4zWwBar7EBJpj8LTyoiMTYINPoeTJKSKNKhT8EBB4":"g1e2rTLUnjkZzGi4fL2cpo0JlSfG2dkm6ajfoTbebDUuCAuDz9GzLSqOLN4HGyRmdJHsomQi56cTOv3xGVaZBA"}}},"user_signing_key":{"user_id":"@bridgeuser1:localhost","usage":["user_signing"],"keys":{"ed25519:XhMQxqj35FDhaCZnNVL+oOZCPAUgfuNn+MtNZZQ8nK8":"XhMQxqj35FDhaCZnNVL+oOZCPAUgfuNn+MtNZZQ8nK8"},"signatures":{"@bridgeuser1:localhost":{"ed25519:Pi4zWwBar7EBJpj8LTyoiMTYINPoeTJKSKNKhT8EBB4":"XLiwWJ2byA/AnIubQrBWGxaa3spauQaPH6iKKhn7SAtguiBpcsAryoZpp044kQn8OyICNFM2dxQGGq8nZOgCDA"}}}}	/_matrix/client/unstable/keys/device_signing/upload	POST	add a device signing key to your account
pBfRSgkraXepIvPdXkqFFjtk	1672417297333	{"request_user_id":"@bridgeuser1:localhost"}	{"master_key":{"user_id":"@bridgeuser1:localhost","usage":["master"],"keys":{"ed25519:7wDLauQ3qGuLiM/yz8cOXh1qzgpbFAqLgedhD1hu8is":"7wDLauQ3qGuLiM/yz8cOXh1qzgpbFAqLgedhD1hu8is"},"signatures":{"@bridgeuser1:localhost":{"ed25519:PIMRNBVGGO":"QjRXfg8M9cfuZ9HIhcbRIa14/lQKrbBE1qs+pdp1O9GEof4ag7he+2PMsOjx7gJA+tUXOT5ueRA/hXScYmTfBg"}}},"self_signing_key":{"user_id":"@bridgeuser1:localhost","usage":["self_signing"],"keys":{"ed25519:u03Pql5u73F/N964ZJ26zmKPbrtjZs/Rm39VTH4A3tY":"u03Pql5u73F/N964ZJ26zmKPbrtjZs/Rm39VTH4A3tY"},"signatures":{"@bridgeuser1:localhost":{"ed25519:7wDLauQ3qGuLiM/yz8cOXh1qzgpbFAqLgedhD1hu8is":"4U7BhBB37uQWJbUkYiQC1XyCEqyCT03lI2vswWrSxKw5vav6RQaJEby4bjCPPw1llUYrAnaJk0cfn12g70YTAg"}}},"user_signing_key":{"user_id":"@bridgeuser1:localhost","usage":["user_signing"],"keys":{"ed25519:QDvobzyYRsYpNx3s0RYnvP1MhQ5MNKdXtwhJCn253SU":"QDvobzyYRsYpNx3s0RYnvP1MhQ5MNKdXtwhJCn253SU"},"signatures":{"@bridgeuser1:localhost":{"ed25519:7wDLauQ3qGuLiM/yz8cOXh1qzgpbFAqLgedhD1hu8is":"IPU/T8pSl/frRtDpqZVBhL5aoahwMz6PM+5gWyWxS/CWi/oR2+yPcInTdGCv72P3WLcw3ZU5+IOeeuUEoJT2Bw"}}}}	/_matrix/client/unstable/keys/device_signing/upload	POST	add a device signing key to your account
BuVabNkJRsPPCRkcglsPwFxF	1672417641485	{"request_user_id":"@bridgeadmin:localhost"}	{"master_key":{"user_id":"@bridgeadmin:localhost","usage":["master"],"keys":{"ed25519:dqKAfhOmGQIvXvXnGg5bH+5t5rgKR+BeJE+VPoFVIGU":"dqKAfhOmGQIvXvXnGg5bH+5t5rgKR+BeJE+VPoFVIGU"},"signatures":{"@bridgeadmin:localhost":{"ed25519:XGKLFWVQVO":"2RmUJhzHxo2vqVJ3Ke4HzQNWrp1/K+MGdrO37lxwpo8ecdiLgvxfwdK9/W7j0MWSYsVkm28M4xMZ6a2QVnjFBA"}}},"self_signing_key":{"user_id":"@bridgeadmin:localhost","usage":["self_signing"],"keys":{"ed25519:z/xKbsyDSNmvuOpalujggdayEWXkgUVIU36fBpby2ME":"z/xKbsyDSNmvuOpalujggdayEWXkgUVIU36fBpby2ME"},"signatures":{"@bridgeadmin:localhost":{"ed25519:dqKAfhOmGQIvXvXnGg5bH+5t5rgKR+BeJE+VPoFVIGU":"EFXNM0a0Lixpa2QAKIq5JDxoNTP/6Wqq0XgqwwW5Az5Z/DXMvS50ydI+eQZ5R+hstKm7IkuqXwK3gd0ecQXNBQ"}}},"user_signing_key":{"user_id":"@bridgeadmin:localhost","usage":["user_signing"],"keys":{"ed25519:uVU15sEWPe/zXTD4cV2nnHjB1OGaLeLoMjHmlYYGvkQ":"uVU15sEWPe/zXTD4cV2nnHjB1OGaLeLoMjHmlYYGvkQ"},"signatures":{"@bridgeadmin:localhost":{"ed25519:dqKAfhOmGQIvXvXnGg5bH+5t5rgKR+BeJE+VPoFVIGU":"htgvRCGUR0IfB28Rh/4UQ4LW4WOboBSndRAvtqWNbChFpEvMN4oDI8fRf+GLjz922z/Mf99RR2Vw5k0kg5IAAQ"}}}}	/_matrix/client/unstable/keys/device_signing/upload	POST	add a device signing key to your account
aPuDcGJrDNDIkKfuJPMWzPkr	1672480064107	{"request_user_id":"@bridgeadmin:localhost"}	{}	/_matrix/client/unstable/keys/device_signing/upload	POST	add a device signing key to your account
VAaZdvBUryvmnECtqDrwJGYf	1672480300053	{"request_user_id":"@bridgeadmin:localhost"}	{}	/_matrix/client/unstable/keys/device_signing/upload	POST	add a device signing key to your account
bqpaYggGNtAnhQDDHcncMNnT	1672481615788	{"request_user_id":"@admin:localhost"}	{"master_key":{"user_id":"@admin:localhost","usage":["master"],"keys":{"ed25519:DVCR/jmoMkIGLI7QakrxDtXqIexvGehpu4Uq1FMxGV0":"DVCR/jmoMkIGLI7QakrxDtXqIexvGehpu4Uq1FMxGV0"},"signatures":{"@admin:localhost":{"ed25519:JOEAGREGVO":"Fj8mG7sGPl4ymd7kdUjrCmGp5wasguCJhatHzDV8ip+wbMSCgZnzBd83o3OG7DIaoorr3ZZNA/ixFexs7ChKDw"}}},"self_signing_key":{"user_id":"@admin:localhost","usage":["self_signing"],"keys":{"ed25519:ScHq9g/TJ8qnEHSaKvQwLofFTzq8QqejbfNMoZITy34":"ScHq9g/TJ8qnEHSaKvQwLofFTzq8QqejbfNMoZITy34"},"signatures":{"@admin:localhost":{"ed25519:DVCR/jmoMkIGLI7QakrxDtXqIexvGehpu4Uq1FMxGV0":"m0GxIIwfiO9/5ojY1y1uOLLHjyHX4QR5Dboo3Nv+FOEly+GirS8MfKnrrbdvC61BQOYK/dAMQ+U+gsrB9b5WDA"}}},"user_signing_key":{"user_id":"@admin:localhost","usage":["user_signing"],"keys":{"ed25519:Ym8LVmdxz/2yXY1J1KgJPC3n1DG6S7BaFjIUBweQt8g":"Ym8LVmdxz/2yXY1J1KgJPC3n1DG6S7BaFjIUBweQt8g"},"signatures":{"@admin:localhost":{"ed25519:DVCR/jmoMkIGLI7QakrxDtXqIexvGehpu4Uq1FMxGV0":"ZjXlT9CsE8aB+QnZHwFAlTB+B+D6+I2gfjcyI7DqlCRei7MRTV6TDF7xlMxgnb8Iq8O2mPcCPrbLz3Al+QqdCA"}}}}	/_matrix/client/unstable/keys/device_signing/upload	POST	add a device signing key to your account
vErEMZTfbmwofbxRaTdqRYbG	1672481619069	{"request_user_id":"@admin:localhost"}	{"master_key":{"user_id":"@admin:localhost","usage":["master"],"keys":{"ed25519:lcbHJ7rLdyswdQrcP5LKDp/ywqeK0qH2KiDYYGEDV+o":"lcbHJ7rLdyswdQrcP5LKDp/ywqeK0qH2KiDYYGEDV+o"},"signatures":{"@admin:localhost":{"ed25519:JOEAGREGVO":"+zgrSmcc03ori6umVlW5stnfTjp0lNd/bG1pgjaT/BjCyrpKbNd92LuJzhlH8yz0zIKv/aULP0Dic+QfZesDCg"}}},"self_signing_key":{"user_id":"@admin:localhost","usage":["self_signing"],"keys":{"ed25519:i2xQ0mj11fflxQ/fm7K2FvX3ox/Co14tutNvZ3fHxuo":"i2xQ0mj11fflxQ/fm7K2FvX3ox/Co14tutNvZ3fHxuo"},"signatures":{"@admin:localhost":{"ed25519:lcbHJ7rLdyswdQrcP5LKDp/ywqeK0qH2KiDYYGEDV+o":"hZ/lE4Rp6P4hgc3wmePjSK1pHXFrPPMTnJzYRojx3+wqyuPA+2nwOYuoomtjnuTXg0loSx8C4MOg7mwYdmYoAQ"}}},"user_signing_key":{"user_id":"@admin:localhost","usage":["user_signing"],"keys":{"ed25519:A788mplF3RET2tbqgC/nQ6zL1fttwgjq/qWHApnnOxo":"A788mplF3RET2tbqgC/nQ6zL1fttwgjq/qWHApnnOxo"},"signatures":{"@admin:localhost":{"ed25519:lcbHJ7rLdyswdQrcP5LKDp/ywqeK0qH2KiDYYGEDV+o":"B2tOqiLgHFBmGMRe8QON2CT1Ym77VOqgWYg5aJMelJH3FCYW4m0IFrM5+dBJVFT7ENVnrdavb4KRRRHRh2pcDQ"}}}}	/_matrix/client/unstable/keys/device_signing/upload	POST	add a device signing key to your account
BjhIUEgrPVPNpLJRifbzlNhj	1672481791481	{"request_user_id":"@admin:localhost"}	{}	/_matrix/client/unstable/keys/device_signing/upload	POST	add a device signing key to your account
wBMQvRaerRtYKOdbJMmlUhCV	1672481805531	{"request_user_id":"@admin:localhost"}	{}	/_matrix/client/unstable/keys/device_signing/upload	POST	add a device signing key to your account
SzcDnnFTTPZfHDMYJrULekUj	1672481829115	{"request_user_id":"@admin:localhost"}	{}	/_matrix/client/unstable/keys/device_signing/upload	POST	add a device signing key to your account
fAgCeEHlUZwQZkfUmPlacUbT	1672481870817	{"request_user_id":"@admin:localhost"}	{}	/_matrix/client/unstable/keys/device_signing/upload	POST	add a device signing key to your account
GhWprmUQbehXeYOuvERXoAKJ	1672482317387	{"request_user_id":"@admin:localhost"}	{}	/_matrix/client/unstable/keys/device_signing/upload	POST	add a device signing key to your account
pTNMJyZPKCEFuprGAyMpwzHg	1672482327404	{"request_user_id":"@admin:localhost"}	{}	/_matrix/client/unstable/keys/device_signing/upload	POST	add a device signing key to your account
GAESxcCSOrarCsLAqubkSTzR	1672482487332	{"request_user_id":"@admin:localhost"}	{}	/_matrix/client/unstable/keys/device_signing/upload	POST	add a device signing key to your account
JxSuHyvWShSwyJCkqNhTtHCY	1672482522506	{"request_user_id":"@matrix_a:localhost"}	{"master_key":{"user_id":"@matrix_a:localhost","usage":["master"],"keys":{"ed25519:c/SA1TLAutXhk1/a9/uzmFna0q3Po2h/vMfA1vZQYu4":"c/SA1TLAutXhk1/a9/uzmFna0q3Po2h/vMfA1vZQYu4"},"signatures":{"@matrix_a:localhost":{"ed25519:JHXXJJAPZQ":"xTXXttvPLNbtMkh7kJ2nwcldfS/fJxUwnxfVn7RvUWh+qsJkG2gRWucPUY9Mu/mkeoXbNv0FqrAFMt5fD1oHCw"}}},"self_signing_key":{"user_id":"@matrix_a:localhost","usage":["self_signing"],"keys":{"ed25519:d0OZz1jWrDfY2lb+1MjC7s9T4GfO15eg/+BkFaqr3EE":"d0OZz1jWrDfY2lb+1MjC7s9T4GfO15eg/+BkFaqr3EE"},"signatures":{"@matrix_a:localhost":{"ed25519:c/SA1TLAutXhk1/a9/uzmFna0q3Po2h/vMfA1vZQYu4":"LJ/D1kxo/ijX1Aj+XqebZGY8UXOyAR3vgm7GJ3UuE7ClqsyjYGX+R3gnY4wZ5kXZuNO129RfA1Scq5s9qr0IDg"}}},"user_signing_key":{"user_id":"@matrix_a:localhost","usage":["user_signing"],"keys":{"ed25519:BR/OuQr1i9/aFvnwzhUXVJ181B4V8J2E1Afp0KVeCXs":"BR/OuQr1i9/aFvnwzhUXVJ181B4V8J2E1Afp0KVeCXs"},"signatures":{"@matrix_a:localhost":{"ed25519:c/SA1TLAutXhk1/a9/uzmFna0q3Po2h/vMfA1vZQYu4":"HYPYfySV3C9gS5Yt9p0ouINlsmfGCmCJE95dUwOCSboPn0soRJnwbcrUwhXcoxg0OVpMKlqrrvSN0umNLb8oDQ"}}}}	/_matrix/client/unstable/keys/device_signing/upload	POST	add a device signing key to your account
\.


--
-- Data for Name: ui_auth_sessions_credentials; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.ui_auth_sessions_credentials (session_id, stage_type, result) FROM stdin;
vYHtkGQzjCRGQGntgyWPCImi	m.login.password	"@bridgeuser1:localhost"
aJDtUFmtZkIujAJztHzipRlV	m.login.password	"@bridgeuser1:localhost"
LneOlMumvrJFqCFiqVXBVmQn	m.login.password	"@bridgeuser1:localhost"
pBfRSgkraXepIvPdXkqFFjtk	m.login.password	"@bridgeuser1:localhost"
BuVabNkJRsPPCRkcglsPwFxF	m.login.password	"@bridgeadmin:localhost"
bqpaYggGNtAnhQDDHcncMNnT	m.login.password	"@admin:localhost"
vErEMZTfbmwofbxRaTdqRYbG	m.login.password	"@admin:localhost"
JxSuHyvWShSwyJCkqNhTtHCY	m.login.password	"@matrix_a:localhost"
\.


--
-- Data for Name: ui_auth_sessions_ips; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.ui_auth_sessions_ips (session_id, ip, user_agent) FROM stdin;
vYHtkGQzjCRGQGntgyWPCImi	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
aJDtUFmtZkIujAJztHzipRlV	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
LneOlMumvrJFqCFiqVXBVmQn	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
pBfRSgkraXepIvPdXkqFFjtk	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
BuVabNkJRsPPCRkcglsPwFxF	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
aPuDcGJrDNDIkKfuJPMWzPkr	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
VAaZdvBUryvmnECtqDrwJGYf	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
bqpaYggGNtAnhQDDHcncMNnT	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
vErEMZTfbmwofbxRaTdqRYbG	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
BjhIUEgrPVPNpLJRifbzlNhj	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
wBMQvRaerRtYKOdbJMmlUhCV	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
SzcDnnFTTPZfHDMYJrULekUj	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
fAgCeEHlUZwQZkfUmPlacUbT	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
GhWprmUQbehXeYOuvERXoAKJ	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
pTNMJyZPKCEFuprGAyMpwzHg	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
GAESxcCSOrarCsLAqubkSTzR	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
JxSuHyvWShSwyJCkqNhTtHCY	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
\.


--
-- Data for Name: user_daily_visits; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_daily_visits (user_id, device_id, "timestamp", user_agent) FROM stdin;
@bridgeuser1:localhost	PIMRNBVGGO	1672358400000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
@bridgeadmin:localhost	XGKLFWVQVO	1672358400000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
@bridgeadmin:localhost	TZENIQYSDC	1672444800000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
@bridgeadmin:localhost	IFSVAIKQOJ	1672444800000	PostmanRuntime/7.29.2
@admin:localhost	JOEAGREGVO	1672444800000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
@admin:localhost	KFURKEDWNO	1672444800000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
@admin:localhost	XEZPTSZEHL	1672444800000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
@matrix_a:localhost	JHXXJJAPZQ	1672444800000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
\.


--
-- Data for Name: user_directory; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_directory (user_id, room_id, display_name, avatar_url) FROM stdin;
@matrix_b:localhost	\N	matrix_b	\N
@ignored_user:localhost	\N	ignored_user	\N
@bridgeuser1:localhost	\N	bridgeuser1	\N
@bridgeuser2:localhost	\N	bridgeuser2	\N
@bridgeadmin:localhost	\N	bridgeadmin	\N
@admin:localhost	\N	admin	\N
@matrix_a:localhost	\N	matrix_a	\N
\.


--
-- Data for Name: user_directory_search; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_directory_search (user_id, vector) FROM stdin;
@matrix_b:localhost	'b':2A,5B 'localhost':3 'matrix':1A,4B
@ignored_user:localhost	'ignor':1A,4B 'localhost':3 'user':2A,5B
@bridgeuser1:localhost	'bridgeuser1':1A,3B 'localhost':2
@bridgeuser2:localhost	'bridgeuser2':1A,3B 'localhost':2
@bridgeadmin:localhost	'bridgeadmin':1A,3B 'localhost':2
@admin:localhost	'admin':1A,3B 'localhost':2
@matrix_a:localhost	'a':2A,5B 'localhost':3 'matrix':1A,4B
\.


--
-- Data for Name: user_directory_stream_pos; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_directory_stream_pos (lock, stream_id) FROM stdin;
X	139
\.


--
-- Data for Name: user_external_ids; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_external_ids (auth_provider, external_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_filters; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_filters (user_id, filter_id, filter_json) FROM stdin;
bridgeuser1	0	\\x7b22726f6f6d223a7b227374617465223a7b226c617a795f6c6f61645f6d656d62657273223a747275657d7d7d
bridgeadmin	0	\\x7b22726f6f6d223a7b227374617465223a7b226c617a795f6c6f61645f6d656d62657273223a747275657d7d7d
admin	0	\\x7b22726f6f6d223a7b227374617465223a7b226c617a795f6c6f61645f6d656d62657273223a747275657d7d7d
matrix_a	0	\\x7b22726f6f6d223a7b227374617465223a7b226c617a795f6c6f61645f6d656d62657273223a747275657d7d7d
\.


--
-- Data for Name: user_ips; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_ips (user_id, access_token, device_id, ip, user_agent, last_seen) FROM stdin;
@bridgeuser1:localhost	syt_YnJpZGdldXNlcjE_cMzgedqFaVOMSJBmfZfe_3maH1A	PIMRNBVGGO	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36	1672417521872
@bridgeadmin:localhost	syt_YnJpZGdlYWRtaW4_ErFyglzXQNIHuWssiTTm_2y3mmu	XGKLFWVQVO	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36	1672418140108
@bridgeadmin:localhost	syt_YnJpZGdlYWRtaW4_nlAxPyQxZbWOqdTXNWeT_2ky0xI	TZENIQYSDC	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36	1672481556414
@admin:localhost	syt_YWRtaW4_qcysgvLIAiQdwMiatzuO_4Fh3df	JOEAGREGVO	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36	1672481741005
@admin:localhost	syt_YWRtaW4_buUzZErRoZfQBzygSRKf_2jk2eE	KFURKEDWNO	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36	1672482188576
@bridgeadmin:localhost	syt_YnJpZGdlYWRtaW4_MpYSPFUOTVBiLRuKcWSg_2gXdf2	IFSVAIKQOJ	172.16.238.1	PostmanRuntime/7.29.2	1672482420441
@admin:localhost	syt_YWRtaW4_NCBAoukOFOBAjSaUWOeN_2phmbL	XEZPTSZEHL	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36	1672482440160
@matrix_a:localhost	syt_bWF0cml4X2E_QZXFOaNjjlgkaAgrqTHa_0R6Cof	JHXXJJAPZQ	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36	1672483057132
\.


--
-- Data for Name: user_signature_stream; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_signature_stream (stream_id, from_user_id, user_ids) FROM stdin;
18	@bridgeuser1:localhost	["@bridgeuser1:localhost"]
21	@bridgeuser1:localhost	["@bridgeuser1:localhost"]
24	@bridgeuser1:localhost	["@bridgeuser1:localhost"]
27	@bridgeuser1:localhost	["@bridgeuser1:localhost"]
33	@bridgeadmin:localhost	["@bridgeadmin:localhost"]
43	@admin:localhost	["@admin:localhost"]
46	@admin:localhost	["@admin:localhost"]
59	@matrix_a:localhost	["@matrix_a:localhost"]
\.


--
-- Data for Name: user_stats_current; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_stats_current (user_id, joined_rooms, completed_delta_stream_id) FROM stdin;
@matrix_b:localhost	2	17
@ignored_user:localhost	2	19
@matterbot:localhost	2	21
@bridgeuser2:localhost	0	29
@mm_matrix_matrix_a:localhost	2	42
@mm_matrix_matrix_b:localhost	2	43
@mm_mattermost_b_:localhost	2	44
@mm_mattermost_a_:localhost	2	46
@mm_mattermost_b:localhost	0	48
@mm_mattermost_a:localhost	0	49
@bridgeuser1:localhost	2	59
@bridgeadmin:localhost	5	106
@admin:localhost	6	133
@matrix_a:localhost	4	139
\.


--
-- Data for Name: user_stats_historical; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_stats_historical (user_id, end_ts, bucket_size, joined_rooms, invites_sent, rooms_created, total_events, total_event_bytes) FROM stdin;
@admin:localhost	1641600000	86400000	0	0	0	0	0
@matrix_a:localhost	1641600000	86400000	0	0	0	0	0
@matrix_b:localhost	1641600000	86400000	0	0	0	0	0
@ignored_user:localhost	1641600000	86400000	0	0	0	0	0
@admin:localhost	1598745600000	86400000	2	0	2	12	8826
@matrix_a:localhost	1598745600000	86400000	2	0	0	2	1522
@matrix_b:localhost	1598745600000	86400000	2	0	0	2	1522
@ignored_user:localhost	1598745600000	86400000	2	0	0	2	1546
\.


--
-- Data for Name: user_threepid_id_server; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_threepid_id_server (user_id, medium, address, id_server) FROM stdin;
\.


--
-- Data for Name: user_threepids; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_threepids (user_id, medium, address, validated_at, added_at) FROM stdin;
@admin:localhost	email	admin@localhost	1672481566655	1672481566655
@matrix_a:localhost	email	matrix_a@localhost	1672482420604	1672482420604
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.users (name, password_hash, creation_ts, admin, upgrade_ts, is_guest, appservice_id, consent_version, consent_server_notice_sent, user_type, deactivated, shadow_banned) FROM stdin;
@matrix_b:localhost	$2b$12$gnHJ1cdN/bfA2A2V61rPauepmeV2dLXr/pC70rCZy9qZoM9u2GKaq	1598686327	0	\N	0	\N	\N	\N	\N	0	\N
@ignored_user:localhost	$2b$12$cDOaADzxfGcFFspSrfJNcueOwevhD2Ex0hu6oAJcpz3S/owrOeSsW	1598686327	0	\N	0	\N	\N	\N	\N	0	\N
@matterbot:localhost		1672393387	0	\N	0	xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	\N	\N	\N	0	f
@mm_mattermost_b:localhost		1672393389	0	\N	0	xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	\N	\N	\N	0	f
@mm_mattermost_a:localhost		1672393389	0	\N	0	xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	\N	\N	\N	0	f
@bridgeuser1:localhost	$2b$12$AMSaaL5GWwOAm21aBcYpwO2RPXA9h.0sYXneCUf2nCP5o0MBZSPkW	1672416114	0	\N	0	\N	\N	\N	\N	0	f
@bridgeuser2:localhost	$2b$12$VvjhBqRxi3EKhJHPT3Er8.tlGQ6A0HZhkYwK6YFes/wfUGxyn9FDq	1672416140	0	\N	0	\N	\N	\N	\N	0	f
@bridgeadmin:localhost	$2b$12$6MKLyLeJrQSu2cE0V8W3uOiRYYsa5tX34N06d.Ms4eSujSGSgiS4W	1672416163	1	\N	0	\N	\N	\N	\N	0	f
@mm_mattermost_a_:localhost		1672416526	0	\N	0	xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	\N	\N	\N	0	f
@mm_mattermost_b_:localhost		1672416526	0	\N	0	xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	\N	\N	\N	0	f
@mm_matrix_matrix_a:localhost		1672416526	0	\N	0	xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	\N	\N	\N	0	f
@mm_matrix_matrix_b:localhost		1672416526	0	\N	0	xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	\N	\N	\N	0	f
@admin:localhost	$2b$12$CbZR5qyVjn9UcGWVK.7u2u/Dri6PzQZf/OOlcOOc29gUawVSisRQO	1598686326	0	\N	0	\N	\N	\N	\N	0	\N
@matrix_a:localhost	$2b$12$vJnRfaegrlQMkpCNlH2DteaT5ROHWzsPGi9UiBt5wh4dde/90b.c.	1598686327	0	\N	0	\N	\N	\N	\N	0	\N
\.


--
-- Data for Name: users_in_public_rooms; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.users_in_public_rooms (user_id, room_id) FROM stdin;
@admin:localhost	!kmbTYjjsDRDHGgVqUP:localhost
@admin:localhost	!dKcbdDATuwwphjRPQP:localhost
@matrix_a:localhost	!kmbTYjjsDRDHGgVqUP:localhost
@matrix_a:localhost	!dKcbdDATuwwphjRPQP:localhost
@matrix_b:localhost	!kmbTYjjsDRDHGgVqUP:localhost
@matrix_b:localhost	!dKcbdDATuwwphjRPQP:localhost
@ignored_user:localhost	!kmbTYjjsDRDHGgVqUP:localhost
@ignored_user:localhost	!dKcbdDATuwwphjRPQP:localhost
@bridgeadmin:localhost	!kAToIwhNWrDpgQVMfY:localhost
@bridgeadmin:localhost	!ffaaxOMHcWnINEXTWK:localhost
@bridgeadmin:localhost	!cwnFZrIkYIOvkCHJkc:localhost
@matrix_a:localhost	!kAToIwhNWrDpgQVMfY:localhost
\.


--
-- Data for Name: users_pending_deactivation; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.users_pending_deactivation (user_id) FROM stdin;
\.


--
-- Data for Name: users_to_send_full_presence_to; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.users_to_send_full_presence_to (user_id, presence_stream_id) FROM stdin;
\.


--
-- Data for Name: users_who_share_private_rooms; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.users_who_share_private_rooms (user_id, other_user_id, room_id) FROM stdin;
@admin:localhost	@bridgeadmin:localhost	!GNlLBsLXjbOuNhCkEO:localhost
@bridgeadmin:localhost	@admin:localhost	!GNlLBsLXjbOuNhCkEO:localhost
@bridgeuser1:localhost	@admin:localhost	!MrxfbdodytWwBMqNiF:localhost
@admin:localhost	@bridgeuser1:localhost	!MrxfbdodytWwBMqNiF:localhost
@admin:localhost	@bridgeadmin:localhost	!LwtGEdNVvQHvFLuWQB:localhost
@bridgeadmin:localhost	@admin:localhost	!LwtGEdNVvQHvFLuWQB:localhost
@matrix_a:localhost	@bridgeuser1:localhost	!UKcoTBWWxNEyixrjyM:localhost
@bridgeuser1:localhost	@matrix_a:localhost	!UKcoTBWWxNEyixrjyM:localhost
\.


--
-- Data for Name: worker_locks; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.worker_locks (lock_name, lock_key, instance_name, token, last_renewed_ts) FROM stdin;
\.


--
-- Name: account_data_sequence; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.account_data_sequence', 97, true);


--
-- Name: cache_invalidation_stream_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.cache_invalidation_stream_seq', 332, true);


--
-- Name: device_inbox_sequence; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.device_inbox_sequence', 1, true);


--
-- Name: event_auth_chain_id; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.event_auth_chain_id', 104, true);


--
-- Name: events_backfill_stream_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.events_backfill_stream_seq', 1, true);


--
-- Name: events_stream_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.events_stream_seq', 139, true);


--
-- Name: instance_map_instance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.instance_map_instance_id_seq', 1, false);


--
-- Name: presence_stream_sequence; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.presence_stream_sequence', 79, true);


--
-- Name: receipts_sequence; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.receipts_sequence', 9, true);


--
-- Name: state_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.state_group_id_seq', 221, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.user_id_seq', 1, false);


--
-- Name: access_tokens access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.access_tokens
    ADD CONSTRAINT access_tokens_pkey PRIMARY KEY (id);


--
-- Name: access_tokens access_tokens_token_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.access_tokens
    ADD CONSTRAINT access_tokens_token_key UNIQUE (token);


--
-- Name: account_data account_data_uniqueness; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.account_data
    ADD CONSTRAINT account_data_uniqueness UNIQUE (user_id, account_data_type);


--
-- Name: account_validity account_validity_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.account_validity
    ADD CONSTRAINT account_validity_pkey PRIMARY KEY (user_id);


--
-- Name: application_services_state application_services_state_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.application_services_state
    ADD CONSTRAINT application_services_state_pkey PRIMARY KEY (as_id);


--
-- Name: application_services_txns application_services_txns_as_id_txn_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.application_services_txns
    ADD CONSTRAINT application_services_txns_as_id_txn_id_key UNIQUE (as_id, txn_id);


--
-- Name: applied_module_schemas applied_module_schemas_module_name_file_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.applied_module_schemas
    ADD CONSTRAINT applied_module_schemas_module_name_file_key UNIQUE (module_name, file);


--
-- Name: applied_schema_deltas applied_schema_deltas_version_file_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.applied_schema_deltas
    ADD CONSTRAINT applied_schema_deltas_version_file_key UNIQUE (version, file);


--
-- Name: appservice_stream_position appservice_stream_position_lock_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.appservice_stream_position
    ADD CONSTRAINT appservice_stream_position_lock_key UNIQUE (lock);


--
-- Name: background_updates background_updates_uniqueness; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.background_updates
    ADD CONSTRAINT background_updates_uniqueness UNIQUE (update_name);


--
-- Name: current_state_events current_state_events_event_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.current_state_events
    ADD CONSTRAINT current_state_events_event_id_key UNIQUE (event_id);


--
-- Name: current_state_events current_state_events_room_id_type_state_key_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.current_state_events
    ADD CONSTRAINT current_state_events_room_id_type_state_key_key UNIQUE (room_id, type, state_key);


--
-- Name: dehydrated_devices dehydrated_devices_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.dehydrated_devices
    ADD CONSTRAINT dehydrated_devices_pkey PRIMARY KEY (user_id);


--
-- Name: destination_rooms destination_rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.destination_rooms
    ADD CONSTRAINT destination_rooms_pkey PRIMARY KEY (destination, room_id);


--
-- Name: destinations destinations_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.destinations
    ADD CONSTRAINT destinations_pkey PRIMARY KEY (destination);


--
-- Name: devices device_uniqueness; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT device_uniqueness UNIQUE (user_id, device_id);


--
-- Name: e2e_device_keys_json e2e_device_keys_json_uniqueness; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.e2e_device_keys_json
    ADD CONSTRAINT e2e_device_keys_json_uniqueness UNIQUE (user_id, device_id);


--
-- Name: e2e_fallback_keys_json e2e_fallback_keys_json_uniqueness; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.e2e_fallback_keys_json
    ADD CONSTRAINT e2e_fallback_keys_json_uniqueness UNIQUE (user_id, device_id, algorithm);


--
-- Name: e2e_one_time_keys_json e2e_one_time_keys_json_uniqueness; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.e2e_one_time_keys_json
    ADD CONSTRAINT e2e_one_time_keys_json_uniqueness UNIQUE (user_id, device_id, algorithm, key_id);


--
-- Name: event_auth_chain_to_calculate event_auth_chain_to_calculate_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_auth_chain_to_calculate
    ADD CONSTRAINT event_auth_chain_to_calculate_pkey PRIMARY KEY (event_id);


--
-- Name: event_auth_chains event_auth_chains_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_auth_chains
    ADD CONSTRAINT event_auth_chains_pkey PRIMARY KEY (event_id);


--
-- Name: event_backward_extremities event_backward_extremities_event_id_room_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_backward_extremities
    ADD CONSTRAINT event_backward_extremities_event_id_room_id_key UNIQUE (event_id, room_id);


--
-- Name: event_edges event_edges_event_id_prev_event_id_room_id_is_state_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_edges
    ADD CONSTRAINT event_edges_event_id_prev_event_id_room_id_is_state_key UNIQUE (event_id, prev_event_id, room_id, is_state);


--
-- Name: event_expiry event_expiry_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_expiry
    ADD CONSTRAINT event_expiry_pkey PRIMARY KEY (event_id);


--
-- Name: event_forward_extremities event_forward_extremities_event_id_room_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_forward_extremities
    ADD CONSTRAINT event_forward_extremities_event_id_room_id_key UNIQUE (event_id, room_id);


--
-- Name: event_push_actions event_id_user_id_profile_tag_uniqueness; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_push_actions
    ADD CONSTRAINT event_id_user_id_profile_tag_uniqueness UNIQUE (room_id, event_id, user_id, profile_tag);


--
-- Name: event_json event_json_event_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_json
    ADD CONSTRAINT event_json_event_id_key UNIQUE (event_id);


--
-- Name: event_labels event_labels_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_labels
    ADD CONSTRAINT event_labels_pkey PRIMARY KEY (event_id, label);


--
-- Name: event_push_summary_stream_ordering event_push_summary_stream_ordering_lock_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_push_summary_stream_ordering
    ADD CONSTRAINT event_push_summary_stream_ordering_lock_key UNIQUE (lock);


--
-- Name: event_reference_hashes event_reference_hashes_event_id_algorithm_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_reference_hashes
    ADD CONSTRAINT event_reference_hashes_event_id_algorithm_key UNIQUE (event_id, algorithm);


--
-- Name: event_reports event_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_reports
    ADD CONSTRAINT event_reports_pkey PRIMARY KEY (id);


--
-- Name: event_to_state_groups event_to_state_groups_event_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_to_state_groups
    ADD CONSTRAINT event_to_state_groups_event_id_key UNIQUE (event_id);


--
-- Name: events events_event_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_event_id_key UNIQUE (event_id);


--
-- Name: ex_outlier_stream ex_outlier_stream_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.ex_outlier_stream
    ADD CONSTRAINT ex_outlier_stream_pkey PRIMARY KEY (event_stream_ordering);


--
-- Name: group_roles group_roles_group_id_role_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.group_roles
    ADD CONSTRAINT group_roles_group_id_role_id_key UNIQUE (group_id, role_id);


--
-- Name: group_room_categories group_room_categories_group_id_category_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.group_room_categories
    ADD CONSTRAINT group_room_categories_group_id_category_id_key UNIQUE (group_id, category_id);


--
-- Name: group_summary_roles group_summary_roles_group_id_role_id_role_order_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.group_summary_roles
    ADD CONSTRAINT group_summary_roles_group_id_role_id_role_order_key UNIQUE (group_id, role_id, role_order);


--
-- Name: group_summary_room_categories group_summary_room_categories_group_id_category_id_cat_orde_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.group_summary_room_categories
    ADD CONSTRAINT group_summary_room_categories_group_id_category_id_cat_orde_key UNIQUE (group_id, category_id, cat_order);


--
-- Name: group_summary_rooms group_summary_rooms_group_id_category_id_room_id_room_order_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.group_summary_rooms
    ADD CONSTRAINT group_summary_rooms_group_id_category_id_room_id_room_order_key UNIQUE (group_id, category_id, room_id, room_order);


--
-- Name: instance_map instance_map_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.instance_map
    ADD CONSTRAINT instance_map_pkey PRIMARY KEY (instance_id);


--
-- Name: local_media_repository local_media_repository_media_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.local_media_repository
    ADD CONSTRAINT local_media_repository_media_id_key UNIQUE (media_id);


--
-- Name: user_threepids medium_address; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.user_threepids
    ADD CONSTRAINT medium_address UNIQUE (medium, address);


--
-- Name: open_id_tokens open_id_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.open_id_tokens
    ADD CONSTRAINT open_id_tokens_pkey PRIMARY KEY (token);


--
-- Name: presence presence_user_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.presence
    ADD CONSTRAINT presence_user_id_key UNIQUE (user_id);


--
-- Name: profiles profiles_user_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_user_id_key UNIQUE (user_id);


--
-- Name: push_rules_enable push_rules_enable_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.push_rules_enable
    ADD CONSTRAINT push_rules_enable_pkey PRIMARY KEY (id);


--
-- Name: push_rules_enable push_rules_enable_user_name_rule_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.push_rules_enable
    ADD CONSTRAINT push_rules_enable_user_name_rule_id_key UNIQUE (user_name, rule_id);


--
-- Name: push_rules push_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.push_rules
    ADD CONSTRAINT push_rules_pkey PRIMARY KEY (id);


--
-- Name: push_rules push_rules_user_name_rule_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.push_rules
    ADD CONSTRAINT push_rules_user_name_rule_id_key UNIQUE (user_name, rule_id);


--
-- Name: pusher_throttle pusher_throttle_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.pusher_throttle
    ADD CONSTRAINT pusher_throttle_pkey PRIMARY KEY (pusher, room_id);


--
-- Name: pushers pushers2_app_id_pushkey_user_name_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.pushers
    ADD CONSTRAINT pushers2_app_id_pushkey_user_name_key UNIQUE (app_id, pushkey, user_name);


--
-- Name: pushers pushers2_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.pushers
    ADD CONSTRAINT pushers2_pkey PRIMARY KEY (id);


--
-- Name: receipts_graph receipts_graph_uniqueness; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.receipts_graph
    ADD CONSTRAINT receipts_graph_uniqueness UNIQUE (room_id, receipt_type, user_id);


--
-- Name: receipts_linearized receipts_linearized_uniqueness; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.receipts_linearized
    ADD CONSTRAINT receipts_linearized_uniqueness UNIQUE (room_id, receipt_type, user_id);


--
-- Name: received_transactions received_transactions_transaction_id_origin_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.received_transactions
    ADD CONSTRAINT received_transactions_transaction_id_origin_key UNIQUE (transaction_id, origin);


--
-- Name: redactions redactions_event_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.redactions
    ADD CONSTRAINT redactions_event_id_key UNIQUE (event_id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_key UNIQUE (token);


--
-- Name: registration_tokens registration_tokens_token_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.registration_tokens
    ADD CONSTRAINT registration_tokens_token_key UNIQUE (token);


--
-- Name: rejections rejections_event_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.rejections
    ADD CONSTRAINT rejections_event_id_key UNIQUE (event_id);


--
-- Name: remote_media_cache remote_media_cache_media_origin_media_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.remote_media_cache
    ADD CONSTRAINT remote_media_cache_media_origin_media_id_key UNIQUE (media_origin, media_id);


--
-- Name: room_account_data room_account_data_uniqueness; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.room_account_data
    ADD CONSTRAINT room_account_data_uniqueness UNIQUE (user_id, room_id, account_data_type);


--
-- Name: room_aliases room_aliases_room_alias_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.room_aliases
    ADD CONSTRAINT room_aliases_room_alias_key UNIQUE (room_alias);


--
-- Name: room_depth room_depth_room_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.room_depth
    ADD CONSTRAINT room_depth_room_id_key UNIQUE (room_id);


--
-- Name: room_memberships room_memberships_event_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.room_memberships
    ADD CONSTRAINT room_memberships_event_id_key UNIQUE (event_id);


--
-- Name: room_retention room_retention_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.room_retention
    ADD CONSTRAINT room_retention_pkey PRIMARY KEY (room_id, event_id);


--
-- Name: room_stats_current room_stats_current_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.room_stats_current
    ADD CONSTRAINT room_stats_current_pkey PRIMARY KEY (room_id);


--
-- Name: room_stats_historical room_stats_historical_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.room_stats_historical
    ADD CONSTRAINT room_stats_historical_pkey PRIMARY KEY (room_id, end_ts);


--
-- Name: room_tags_revisions room_tag_revisions_uniqueness; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.room_tags_revisions
    ADD CONSTRAINT room_tag_revisions_uniqueness UNIQUE (user_id, room_id);


--
-- Name: room_tags room_tag_uniqueness; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.room_tags
    ADD CONSTRAINT room_tag_uniqueness UNIQUE (user_id, room_id, tag);


--
-- Name: rooms rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (room_id);


--
-- Name: schema_compat_version schema_compat_version_lock_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.schema_compat_version
    ADD CONSTRAINT schema_compat_version_lock_key UNIQUE (lock);


--
-- Name: schema_version schema_version_lock_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.schema_version
    ADD CONSTRAINT schema_version_lock_key UNIQUE (lock);


--
-- Name: server_keys_json server_keys_json_uniqueness; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.server_keys_json
    ADD CONSTRAINT server_keys_json_uniqueness UNIQUE (server_name, key_id, from_server);


--
-- Name: server_signature_keys server_signature_keys_server_name_key_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.server_signature_keys
    ADD CONSTRAINT server_signature_keys_server_name_key_id_key UNIQUE (server_name, key_id);


--
-- Name: sessions sessions_session_type_session_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_session_type_session_id_key UNIQUE (session_type, session_id);


--
-- Name: state_events state_events_event_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.state_events
    ADD CONSTRAINT state_events_event_id_key UNIQUE (event_id);


--
-- Name: state_groups state_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.state_groups
    ADD CONSTRAINT state_groups_pkey PRIMARY KEY (id);


--
-- Name: stats_incremental_position stats_incremental_position_lock_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.stats_incremental_position
    ADD CONSTRAINT stats_incremental_position_lock_key UNIQUE (lock);


--
-- Name: threepid_validation_session threepid_validation_session_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.threepid_validation_session
    ADD CONSTRAINT threepid_validation_session_pkey PRIMARY KEY (session_id);


--
-- Name: threepid_validation_token threepid_validation_token_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.threepid_validation_token
    ADD CONSTRAINT threepid_validation_token_pkey PRIMARY KEY (token);


--
-- Name: ui_auth_sessions_credentials ui_auth_sessions_credentials_session_id_stage_type_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.ui_auth_sessions_credentials
    ADD CONSTRAINT ui_auth_sessions_credentials_session_id_stage_type_key UNIQUE (session_id, stage_type);


--
-- Name: ui_auth_sessions_ips ui_auth_sessions_ips_session_id_ip_user_agent_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.ui_auth_sessions_ips
    ADD CONSTRAINT ui_auth_sessions_ips_session_id_ip_user_agent_key UNIQUE (session_id, ip, user_agent);


--
-- Name: ui_auth_sessions ui_auth_sessions_session_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.ui_auth_sessions
    ADD CONSTRAINT ui_auth_sessions_session_id_key UNIQUE (session_id);


--
-- Name: user_directory_stream_pos user_directory_stream_pos_lock_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.user_directory_stream_pos
    ADD CONSTRAINT user_directory_stream_pos_lock_key UNIQUE (lock);


--
-- Name: user_external_ids user_external_ids_auth_provider_external_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.user_external_ids
    ADD CONSTRAINT user_external_ids_auth_provider_external_id_key UNIQUE (auth_provider, external_id);


--
-- Name: user_stats_current user_stats_current_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.user_stats_current
    ADD CONSTRAINT user_stats_current_pkey PRIMARY KEY (user_id);


--
-- Name: user_stats_historical user_stats_historical_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.user_stats_historical
    ADD CONSTRAINT user_stats_historical_pkey PRIMARY KEY (user_id, end_ts);


--
-- Name: users users_name_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_name_key UNIQUE (name);


--
-- Name: users_to_send_full_presence_to users_to_send_full_presence_to_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.users_to_send_full_presence_to
    ADD CONSTRAINT users_to_send_full_presence_to_pkey PRIMARY KEY (user_id);


--
-- Name: access_tokens_device_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX access_tokens_device_id ON public.access_tokens USING btree (user_id, device_id);


--
-- Name: account_data_stream_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX account_data_stream_id ON public.account_data USING btree (user_id, stream_id);


--
-- Name: application_services_txns_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX application_services_txns_id ON public.application_services_txns USING btree (as_id);


--
-- Name: appservice_room_list_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX appservice_room_list_idx ON public.appservice_room_list USING btree (appservice_id, network_id, room_id);


--
-- Name: batch_events_batch_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX batch_events_batch_id ON public.batch_events USING btree (batch_id);


--
-- Name: blocked_rooms_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX blocked_rooms_idx ON public.blocked_rooms USING btree (room_id);


--
-- Name: cache_invalidation_stream_by_instance_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX cache_invalidation_stream_by_instance_id ON public.cache_invalidation_stream_by_instance USING btree (stream_id);


--
-- Name: chunk_events_event_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX chunk_events_event_id ON public.batch_events USING btree (event_id);


--
-- Name: current_state_delta_stream_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX current_state_delta_stream_idx ON public.current_state_delta_stream USING btree (stream_id);


--
-- Name: current_state_events_member_index; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX current_state_events_member_index ON public.current_state_events USING btree (state_key) WHERE (type = 'm.room.member'::text);


--
-- Name: deleted_pushers_stream_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX deleted_pushers_stream_id ON public.deleted_pushers USING btree (stream_id);


--
-- Name: destination_rooms_room_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX destination_rooms_room_id ON public.destination_rooms USING btree (room_id);


--
-- Name: device_federation_inbox_sender_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX device_federation_inbox_sender_id ON public.device_federation_inbox USING btree (origin, message_id);


--
-- Name: device_federation_outbox_destination_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX device_federation_outbox_destination_id ON public.device_federation_outbox USING btree (destination, stream_id);


--
-- Name: device_federation_outbox_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX device_federation_outbox_id ON public.device_federation_outbox USING btree (stream_id);


--
-- Name: device_inbox_stream_id_user_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX device_inbox_stream_id_user_id ON public.device_inbox USING btree (stream_id, user_id);


--
-- Name: device_inbox_user_stream_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX device_inbox_user_stream_id ON public.device_inbox USING btree (user_id, device_id, stream_id);


--
-- Name: device_lists_outbound_last_success_unique_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX device_lists_outbound_last_success_unique_idx ON public.device_lists_outbound_last_success USING btree (destination, user_id);


--
-- Name: device_lists_outbound_pokes_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX device_lists_outbound_pokes_id ON public.device_lists_outbound_pokes USING btree (destination, stream_id);


--
-- Name: device_lists_outbound_pokes_stream; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX device_lists_outbound_pokes_stream ON public.device_lists_outbound_pokes USING btree (stream_id);


--
-- Name: device_lists_outbound_pokes_user; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX device_lists_outbound_pokes_user ON public.device_lists_outbound_pokes USING btree (destination, user_id);


--
-- Name: device_lists_remote_cache_unique_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX device_lists_remote_cache_unique_id ON public.device_lists_remote_cache USING btree (user_id, device_id);


--
-- Name: device_lists_remote_extremeties_unique_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX device_lists_remote_extremeties_unique_idx ON public.device_lists_remote_extremeties USING btree (user_id);


--
-- Name: device_lists_remote_resync_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX device_lists_remote_resync_idx ON public.device_lists_remote_resync USING btree (user_id);


--
-- Name: device_lists_remote_resync_ts_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX device_lists_remote_resync_ts_idx ON public.device_lists_remote_resync USING btree (added_ts);


--
-- Name: device_lists_stream_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX device_lists_stream_id ON public.device_lists_stream USING btree (stream_id, user_id);


--
-- Name: device_lists_stream_user_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX device_lists_stream_user_id ON public.device_lists_stream USING btree (user_id, device_id);


--
-- Name: e2e_cross_signing_keys_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX e2e_cross_signing_keys_idx ON public.e2e_cross_signing_keys USING btree (user_id, keytype, stream_id);


--
-- Name: e2e_cross_signing_keys_stream_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX e2e_cross_signing_keys_stream_idx ON public.e2e_cross_signing_keys USING btree (stream_id);


--
-- Name: e2e_cross_signing_signatures2_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX e2e_cross_signing_signatures2_idx ON public.e2e_cross_signing_signatures USING btree (user_id, target_user_id, target_device_id);


--
-- Name: e2e_room_keys_versions_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX e2e_room_keys_versions_idx ON public.e2e_room_keys_versions USING btree (user_id, version);


--
-- Name: e2e_room_keys_with_version_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX e2e_room_keys_with_version_idx ON public.e2e_room_keys USING btree (user_id, version, room_id, session_id);


--
-- Name: erased_users_user; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX erased_users_user ON public.erased_users USING btree (user_id);


--
-- Name: ev_b_extrem_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX ev_b_extrem_id ON public.event_backward_extremities USING btree (event_id);


--
-- Name: ev_b_extrem_room; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX ev_b_extrem_room ON public.event_backward_extremities USING btree (room_id);


--
-- Name: ev_edges_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX ev_edges_id ON public.event_edges USING btree (event_id);


--
-- Name: ev_edges_prev_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX ev_edges_prev_id ON public.event_edges USING btree (prev_event_id);


--
-- Name: ev_extrem_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX ev_extrem_id ON public.event_forward_extremities USING btree (event_id);


--
-- Name: ev_extrem_room; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX ev_extrem_room ON public.event_forward_extremities USING btree (room_id);


--
-- Name: evauth_edges_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX evauth_edges_id ON public.event_auth USING btree (event_id);


--
-- Name: event_auth_chain_links_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_auth_chain_links_idx ON public.event_auth_chain_links USING btree (origin_chain_id, target_chain_id);


--
-- Name: event_auth_chain_to_calculate_rm_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_auth_chain_to_calculate_rm_id ON public.event_auth_chain_to_calculate USING btree (room_id);


--
-- Name: event_auth_chains_c_seq_index; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX event_auth_chains_c_seq_index ON public.event_auth_chains USING btree (chain_id, sequence_number);


--
-- Name: event_contains_url_index; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_contains_url_index ON public.events USING btree (room_id, topological_ordering, stream_ordering) WHERE ((contains_url = true) AND (outlier = false));


--
-- Name: event_expiry_expiry_ts_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_expiry_expiry_ts_idx ON public.event_expiry USING btree (expiry_ts);


--
-- Name: event_labels_room_id_label_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_labels_room_id_label_idx ON public.event_labels USING btree (room_id, label, topological_ordering);


--
-- Name: event_push_actions_highlights_index; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_push_actions_highlights_index ON public.event_push_actions USING btree (user_id, room_id, topological_ordering, stream_ordering) WHERE (highlight = 1);


--
-- Name: event_push_actions_rm_tokens; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_push_actions_rm_tokens ON public.event_push_actions USING btree (user_id, room_id, topological_ordering, stream_ordering);


--
-- Name: event_push_actions_room_id_user_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_push_actions_room_id_user_id ON public.event_push_actions USING btree (room_id, user_id);


--
-- Name: event_push_actions_staging_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_push_actions_staging_id ON public.event_push_actions_staging USING btree (event_id);


--
-- Name: event_push_actions_stream_ordering; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_push_actions_stream_ordering ON public.event_push_actions USING btree (stream_ordering, user_id);


--
-- Name: event_push_actions_u_highlight; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_push_actions_u_highlight ON public.event_push_actions USING btree (user_id, stream_ordering);


--
-- Name: event_push_summary_user_rm; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_push_summary_user_rm ON public.event_push_summary USING btree (user_id, room_id);


--
-- Name: event_reference_hashes_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_reference_hashes_id ON public.event_reference_hashes USING btree (event_id);


--
-- Name: event_relations_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX event_relations_id ON public.event_relations USING btree (event_id);


--
-- Name: event_relations_relates; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_relations_relates ON public.event_relations USING btree (relates_to_id, relation_type, aggregation_key);


--
-- Name: event_search_ev_ridx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_search_ev_ridx ON public.event_search USING btree (room_id);


--
-- Name: event_search_event_id_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX event_search_event_id_idx ON public.event_search USING btree (event_id);


--
-- Name: event_search_fts_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_search_fts_idx ON public.event_search USING gin (vector);


--
-- Name: event_to_state_groups_sg_index; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_to_state_groups_sg_index ON public.event_to_state_groups USING btree (state_group);


--
-- Name: event_txn_id_event_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX event_txn_id_event_id ON public.event_txn_id USING btree (event_id);


--
-- Name: event_txn_id_ts; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_txn_id_ts ON public.event_txn_id USING btree (inserted_ts);


--
-- Name: event_txn_id_txn_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX event_txn_id_txn_id ON public.event_txn_id USING btree (room_id, user_id, token_id, txn_id);


--
-- Name: events_order_room; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX events_order_room ON public.events USING btree (room_id, topological_ordering, stream_ordering);


--
-- Name: events_room_stream; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX events_room_stream ON public.events USING btree (room_id, stream_ordering);


--
-- Name: events_stream_ordering; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX events_stream_ordering ON public.events USING btree (stream_ordering);


--
-- Name: events_ts; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX events_ts ON public.events USING btree (origin_server_ts, stream_ordering);


--
-- Name: federation_inbound_events_staging_instance_event; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX federation_inbound_events_staging_instance_event ON public.federation_inbound_events_staging USING btree (origin, event_id);


--
-- Name: federation_inbound_events_staging_room; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX federation_inbound_events_staging_room ON public.federation_inbound_events_staging USING btree (room_id, received_ts);


--
-- Name: federation_stream_position_instance; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX federation_stream_position_instance ON public.federation_stream_position USING btree (type, instance_name);


--
-- Name: group_attestations_remote_g_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX group_attestations_remote_g_idx ON public.group_attestations_remote USING btree (group_id, user_id);


--
-- Name: group_attestations_remote_u_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX group_attestations_remote_u_idx ON public.group_attestations_remote USING btree (user_id);


--
-- Name: group_attestations_remote_v_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX group_attestations_remote_v_idx ON public.group_attestations_remote USING btree (valid_until_ms);


--
-- Name: group_attestations_renewals_g_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX group_attestations_renewals_g_idx ON public.group_attestations_renewals USING btree (group_id, user_id);


--
-- Name: group_attestations_renewals_u_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX group_attestations_renewals_u_idx ON public.group_attestations_renewals USING btree (user_id);


--
-- Name: group_attestations_renewals_v_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX group_attestations_renewals_v_idx ON public.group_attestations_renewals USING btree (valid_until_ms);


--
-- Name: group_invites_g_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX group_invites_g_idx ON public.group_invites USING btree (group_id, user_id);


--
-- Name: group_invites_u_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX group_invites_u_idx ON public.group_invites USING btree (user_id);


--
-- Name: group_rooms_g_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX group_rooms_g_idx ON public.group_rooms USING btree (group_id, room_id);


--
-- Name: group_rooms_r_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX group_rooms_r_idx ON public.group_rooms USING btree (room_id);


--
-- Name: group_summary_rooms_g_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX group_summary_rooms_g_idx ON public.group_summary_rooms USING btree (group_id, room_id, category_id);


--
-- Name: group_summary_users_g_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX group_summary_users_g_idx ON public.group_summary_users USING btree (group_id);


--
-- Name: group_users_g_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX group_users_g_idx ON public.group_users USING btree (group_id, user_id);


--
-- Name: group_users_u_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX group_users_u_idx ON public.group_users USING btree (user_id);


--
-- Name: groups_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX groups_idx ON public.groups USING btree (group_id);


--
-- Name: ignored_users_ignored_user_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX ignored_users_ignored_user_id ON public.ignored_users USING btree (ignored_user_id);


--
-- Name: ignored_users_uniqueness; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX ignored_users_uniqueness ON public.ignored_users USING btree (ignorer_user_id, ignored_user_id);


--
-- Name: insertion_event_edges_event_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX insertion_event_edges_event_id ON public.insertion_event_edges USING btree (event_id);


--
-- Name: insertion_event_edges_insertion_prev_event_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX insertion_event_edges_insertion_prev_event_id ON public.insertion_event_edges USING btree (insertion_prev_event_id);


--
-- Name: insertion_event_edges_insertion_room_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX insertion_event_edges_insertion_room_id ON public.insertion_event_edges USING btree (room_id);


--
-- Name: insertion_event_extremities_event_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX insertion_event_extremities_event_id ON public.insertion_event_extremities USING btree (event_id);


--
-- Name: insertion_event_extremities_room_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX insertion_event_extremities_room_id ON public.insertion_event_extremities USING btree (room_id);


--
-- Name: insertion_events_event_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX insertion_events_event_id ON public.insertion_events USING btree (event_id);


--
-- Name: insertion_events_next_batch_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX insertion_events_next_batch_id ON public.insertion_events USING btree (next_batch_id);


--
-- Name: instance_map_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX instance_map_idx ON public.instance_map USING btree (instance_name);


--
-- Name: local_current_membership_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX local_current_membership_idx ON public.local_current_membership USING btree (user_id, room_id);


--
-- Name: local_current_membership_room_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX local_current_membership_room_idx ON public.local_current_membership USING btree (room_id);


--
-- Name: local_group_membership_g_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX local_group_membership_g_idx ON public.local_group_membership USING btree (group_id);


--
-- Name: local_group_membership_u_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX local_group_membership_u_idx ON public.local_group_membership USING btree (user_id, group_id);


--
-- Name: local_group_updates_stream_id_index; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX local_group_updates_stream_id_index ON public.local_group_updates USING btree (stream_id);


--
-- Name: local_media_repository_thumbn_media_id_width_height_method_key; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX local_media_repository_thumbn_media_id_width_height_method_key ON public.local_media_repository_thumbnails USING btree (media_id, thumbnail_width, thumbnail_height, thumbnail_type, thumbnail_method);


--
-- Name: local_media_repository_thumbnails_media_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX local_media_repository_thumbnails_media_id ON public.local_media_repository_thumbnails USING btree (media_id);


--
-- Name: local_media_repository_url_cache_by_url_download_ts; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX local_media_repository_url_cache_by_url_download_ts ON public.local_media_repository_url_cache USING btree (url, download_ts);


--
-- Name: local_media_repository_url_cache_expires_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX local_media_repository_url_cache_expires_idx ON public.local_media_repository_url_cache USING btree (expires_ts);


--
-- Name: local_media_repository_url_cache_media_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX local_media_repository_url_cache_media_idx ON public.local_media_repository_url_cache USING btree (media_id);


--
-- Name: local_media_repository_url_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX local_media_repository_url_idx ON public.local_media_repository USING btree (created_ts) WHERE (url_cache IS NOT NULL);


--
-- Name: monthly_active_users_time_stamp; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX monthly_active_users_time_stamp ON public.monthly_active_users USING btree ("timestamp");


--
-- Name: monthly_active_users_users; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX monthly_active_users_users ON public.monthly_active_users USING btree (user_id);


--
-- Name: open_id_tokens_ts_valid_until_ms; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX open_id_tokens_ts_valid_until_ms ON public.open_id_tokens USING btree (ts_valid_until_ms);


--
-- Name: presence_stream_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX presence_stream_id ON public.presence_stream USING btree (stream_id, user_id);


--
-- Name: presence_stream_state_not_offline_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX presence_stream_state_not_offline_idx ON public.presence_stream USING btree (state) WHERE (state <> 'offline'::text);


--
-- Name: presence_stream_user_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX presence_stream_user_id ON public.presence_stream USING btree (user_id);


--
-- Name: public_room_index; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX public_room_index ON public.rooms USING btree (is_public);


--
-- Name: public_room_list_stream_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX public_room_list_stream_idx ON public.public_room_list_stream USING btree (stream_id);


--
-- Name: public_room_list_stream_network; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX public_room_list_stream_network ON public.public_room_list_stream USING btree (appservice_id, network_id, room_id);


--
-- Name: public_room_list_stream_rm_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX public_room_list_stream_rm_idx ON public.public_room_list_stream USING btree (room_id, stream_id);


--
-- Name: push_rules_enable_user_name; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX push_rules_enable_user_name ON public.push_rules_enable USING btree (user_name);


--
-- Name: push_rules_stream_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX push_rules_stream_id ON public.push_rules_stream USING btree (stream_id);


--
-- Name: push_rules_stream_user_stream_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX push_rules_stream_user_stream_id ON public.push_rules_stream USING btree (user_id, stream_id);


--
-- Name: push_rules_user_name; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX push_rules_user_name ON public.push_rules USING btree (user_name);


--
-- Name: ratelimit_override_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX ratelimit_override_idx ON public.ratelimit_override USING btree (user_id);


--
-- Name: receipts_linearized_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX receipts_linearized_id ON public.receipts_linearized USING btree (stream_id);


--
-- Name: receipts_linearized_room_stream; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX receipts_linearized_room_stream ON public.receipts_linearized USING btree (room_id, stream_id);


--
-- Name: receipts_linearized_user; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX receipts_linearized_user ON public.receipts_linearized USING btree (user_id);


--
-- Name: received_transactions_ts; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX received_transactions_ts ON public.received_transactions USING btree (ts);


--
-- Name: redactions_have_censored_ts; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX redactions_have_censored_ts ON public.redactions USING btree (received_ts) WHERE (NOT have_censored);


--
-- Name: redactions_redacts; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX redactions_redacts ON public.redactions USING btree (redacts);


--
-- Name: remote_media_repository_thumbn_media_origin_id_width_height_met; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX remote_media_repository_thumbn_media_origin_id_width_height_met ON public.remote_media_cache_thumbnails USING btree (media_origin, media_id, thumbnail_width, thumbnail_height, thumbnail_type, thumbnail_method);


--
-- Name: remote_profile_cache_time; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX remote_profile_cache_time ON public.remote_profile_cache USING btree (last_check);


--
-- Name: remote_profile_cache_user_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX remote_profile_cache_user_id ON public.remote_profile_cache USING btree (user_id);


--
-- Name: room_account_data_stream_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX room_account_data_stream_id ON public.room_account_data USING btree (user_id, stream_id);


--
-- Name: room_alias_servers_alias; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX room_alias_servers_alias ON public.room_alias_servers USING btree (room_alias);


--
-- Name: room_aliases_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX room_aliases_id ON public.room_aliases USING btree (room_id);


--
-- Name: room_memberships_room_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX room_memberships_room_id ON public.room_memberships USING btree (room_id);


--
-- Name: room_memberships_user_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX room_memberships_user_id ON public.room_memberships USING btree (user_id);


--
-- Name: room_memberships_user_room_forgotten; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX room_memberships_user_room_forgotten ON public.room_memberships USING btree (user_id, room_id) WHERE (forgotten = 1);


--
-- Name: room_retention_max_lifetime_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX room_retention_max_lifetime_idx ON public.room_retention USING btree (max_lifetime);


--
-- Name: room_stats_earliest_token_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX room_stats_earliest_token_idx ON public.room_stats_earliest_token USING btree (room_id);


--
-- Name: room_stats_historical_end_ts; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX room_stats_historical_end_ts ON public.room_stats_historical USING btree (end_ts);


--
-- Name: room_stats_state_room; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX room_stats_state_room ON public.room_stats_state USING btree (room_id);


--
-- Name: state_group_edges_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX state_group_edges_idx ON public.state_group_edges USING btree (state_group);


--
-- Name: state_group_edges_prev_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX state_group_edges_prev_idx ON public.state_group_edges USING btree (prev_state_group);


--
-- Name: state_groups_room_id_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX state_groups_room_id_idx ON public.state_groups USING btree (room_id);


--
-- Name: state_groups_state_type_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX state_groups_state_type_idx ON public.state_groups_state USING btree (state_group, type, state_key);


--
-- Name: stream_ordering_to_exterm_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX stream_ordering_to_exterm_idx ON public.stream_ordering_to_exterm USING btree (stream_ordering);


--
-- Name: stream_ordering_to_exterm_rm_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX stream_ordering_to_exterm_rm_idx ON public.stream_ordering_to_exterm USING btree (room_id, stream_ordering);


--
-- Name: stream_positions_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX stream_positions_idx ON public.stream_positions USING btree (stream_name, instance_name);


--
-- Name: threepid_guest_access_tokens_index; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX threepid_guest_access_tokens_index ON public.threepid_guest_access_tokens USING btree (medium, address);


--
-- Name: threepid_validation_token_session_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX threepid_validation_token_session_id ON public.threepid_validation_token USING btree (session_id);


--
-- Name: user_daily_visits_ts_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX user_daily_visits_ts_idx ON public.user_daily_visits USING btree ("timestamp");


--
-- Name: user_daily_visits_uts_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX user_daily_visits_uts_idx ON public.user_daily_visits USING btree (user_id, "timestamp");


--
-- Name: user_directory_room_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX user_directory_room_idx ON public.user_directory USING btree (room_id);


--
-- Name: user_directory_search_fts_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX user_directory_search_fts_idx ON public.user_directory_search USING gin (vector);


--
-- Name: user_directory_search_user_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX user_directory_search_user_idx ON public.user_directory_search USING btree (user_id);


--
-- Name: user_directory_user_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX user_directory_user_idx ON public.user_directory USING btree (user_id);


--
-- Name: user_external_ids_user_id_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX user_external_ids_user_id_idx ON public.user_external_ids USING btree (user_id);


--
-- Name: user_filters_unique; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX user_filters_unique ON public.user_filters USING btree (user_id, filter_id);


--
-- Name: user_ips_device_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX user_ips_device_id ON public.user_ips USING btree (user_id, device_id, last_seen);


--
-- Name: user_ips_last_seen; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX user_ips_last_seen ON public.user_ips USING btree (user_id, last_seen);


--
-- Name: user_ips_last_seen_only; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX user_ips_last_seen_only ON public.user_ips USING btree (last_seen);


--
-- Name: user_ips_user_token_ip_unique_index; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX user_ips_user_token_ip_unique_index ON public.user_ips USING btree (user_id, access_token, ip);


--
-- Name: user_signature_stream_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX user_signature_stream_idx ON public.user_signature_stream USING btree (stream_id);


--
-- Name: user_stats_historical_end_ts; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX user_stats_historical_end_ts ON public.user_stats_historical USING btree (end_ts);


--
-- Name: user_threepid_id_server_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX user_threepid_id_server_idx ON public.user_threepid_id_server USING btree (user_id, medium, address, id_server);


--
-- Name: user_threepids_medium_address; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX user_threepids_medium_address ON public.user_threepids USING btree (medium, address);


--
-- Name: user_threepids_user_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX user_threepids_user_id ON public.user_threepids USING btree (user_id);


--
-- Name: users_creation_ts; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX users_creation_ts ON public.users USING btree (creation_ts);


--
-- Name: users_have_local_media; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX users_have_local_media ON public.local_media_repository USING btree (user_id, created_ts);


--
-- Name: users_in_public_rooms_r_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX users_in_public_rooms_r_idx ON public.users_in_public_rooms USING btree (room_id);


--
-- Name: users_in_public_rooms_u_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX users_in_public_rooms_u_idx ON public.users_in_public_rooms USING btree (user_id, room_id);


--
-- Name: users_who_share_private_rooms_o_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX users_who_share_private_rooms_o_idx ON public.users_who_share_private_rooms USING btree (other_user_id);


--
-- Name: users_who_share_private_rooms_r_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX users_who_share_private_rooms_r_idx ON public.users_who_share_private_rooms USING btree (room_id);


--
-- Name: users_who_share_private_rooms_u_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX users_who_share_private_rooms_u_idx ON public.users_who_share_private_rooms USING btree (user_id, other_user_id, room_id);


--
-- Name: worker_locks_key; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX worker_locks_key ON public.worker_locks USING btree (lock_name, lock_key);


--
-- Name: access_tokens access_tokens_refresh_token_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.access_tokens
    ADD CONSTRAINT access_tokens_refresh_token_id_fkey FOREIGN KEY (refresh_token_id) REFERENCES public.refresh_tokens(id) ON DELETE CASCADE;


--
-- Name: destination_rooms destination_rooms_destination_fkey; Type: FK CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.destination_rooms
    ADD CONSTRAINT destination_rooms_destination_fkey FOREIGN KEY (destination) REFERENCES public.destinations(destination);


--
-- Name: destination_rooms destination_rooms_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.destination_rooms
    ADD CONSTRAINT destination_rooms_room_id_fkey FOREIGN KEY (room_id) REFERENCES public.rooms(room_id);


--
-- Name: event_txn_id event_txn_id_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_txn_id
    ADD CONSTRAINT event_txn_id_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(event_id) ON DELETE CASCADE;


--
-- Name: event_txn_id event_txn_id_token_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_txn_id
    ADD CONSTRAINT event_txn_id_token_id_fkey FOREIGN KEY (token_id) REFERENCES public.access_tokens(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_next_token_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_next_token_id_fkey FOREIGN KEY (next_token_id) REFERENCES public.refresh_tokens(id) ON DELETE CASCADE;


--
-- Name: ui_auth_sessions_credentials ui_auth_sessions_credentials_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.ui_auth_sessions_credentials
    ADD CONSTRAINT ui_auth_sessions_credentials_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.ui_auth_sessions(session_id);


--
-- Name: ui_auth_sessions_ips ui_auth_sessions_ips_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.ui_auth_sessions_ips
    ADD CONSTRAINT ui_auth_sessions_ips_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.ui_auth_sessions(session_id);


--
-- Name: users_to_send_full_presence_to users_to_send_full_presence_to_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.users_to_send_full_presence_to
    ADD CONSTRAINT users_to_send_full_presence_to_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(name);


--
-- PostgreSQL database dump complete
--

