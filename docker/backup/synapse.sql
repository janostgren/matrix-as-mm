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
5	@ignored_user:localhost	IYEBBQEXHS	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMmFjaWQgdXNlcl9pZCA9IEBpZ25vcmVkX3VzZXI6bG9jYWxob3N0CjAwMTZjaWQgdHlwZSA9IGFjY2VzcwowMDIxY2lkIG5vbmNlID0gZU5ta1BBMj1FNnVPRGtwdgowMDJmc2lnbmF0dXJlIHSt8jrFU836Ne3it2HY88EhPD1Aoustsm211bbFjcLcCg	\N	\N	\N	\N	\N
6	@matterbot:localhost	OKGPMGNNEY	syt_bWF0dGVyYm90_qiqMxqPGHFeDOFWgiQhU_0QULKO	\N	\N	1672856700722	\N	f
7	@mm_mattermost_b:localhost	ZESISTJYYM	syt_bW1fbWF0dGVybW9zdF9i_czLJmuThnxfwFQBjzEND_3OxY56	\N	\N	1672856704430	\N	f
8	@mm_mattermost_a:localhost	CWUORKDCEH	syt_bW1fbWF0dGVybW9zdF9h_PgyUmDUUlYkAzyjBteIY_4RLdZ0	\N	\N	1672856704548	\N	f
2	@admin:localhost	WCSUBIGVWG	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjNjaWQgdXNlcl9pZCA9IEBhZG1pbjpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSBXVU9yUTVRMFRnUkNjME1ACjAwMmZzaWduYXR1cmUgdYKA-yuTQ5JV5O0HWRak-48xavOYgA1MMc6A1V_Uw5kK	\N	\N	\N	\N	t
3	@matrix_a:localhost	TKAVEOGKHH	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjZjaWQgdXNlcl9pZCA9IEBtYXRyaXhfYTpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSAwb3Y6eTZVdHojUk4jbFprCjAwMmZzaWduYXR1cmUgNNZKnOVRzj5svh9pEM0UUEqtXYnHjnj9XyNLJ1_uKoAK	\N	\N	\N	\N	t
4	@matrix_b:localhost	DJFHSWMXLW	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjZjaWQgdXNlcl9pZCA9IEBtYXRyaXhfYjpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSBBYl9hbWthI0daSzgtfjdICjAwMmZzaWduYXR1cmUgOReBLkPURCMNtzORS9fpogQqVa3IWN9ZEu5gXW91QTMK	\N	\N	\N	\N	t
\.


--
-- Data for Name: account_data; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.account_data (user_id, account_data_type, stream_id, content, instance_name) FROM stdin;
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
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	up	20	\N	\N
\.


--
-- Data for Name: application_services_txns; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.application_services_txns (as_id, txn_id, event_ids) FROM stdin;
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
X	39
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
27	master	user_last_seen_monthly_active	\N	1672856664791
28	master	get_monthly_active_count	{}	1672856664794
29	master	get_user_by_id	{@matterbot:localhost}	1672856700682
30	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@matterbot:localhost}	1672856701371
31	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@matterbot:localhost}	1672856701400
32	master	get_user_by_id	{@mm_mattermost_b:localhost}	1672856704409
33	master	get_user_by_id	{@mm_mattermost_a:localhost}	1672856704523
34	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_b:localhost}	1672856704709
35	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_b:localhost}	1672856704866
36	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_a:localhost}	1672856704960
37	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_a:localhost}	1672856705110
38	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_b:localhost}	1672856705160
39	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_b:localhost}	1672856705403
40	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_a:localhost}	1672856705498
41	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_a:localhost}	1672856705618
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
21	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$mGK5pQEzegKFhAPXc0TX7drNl2qyJL8ajxnJRmA3kN8	\N	master
20	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$666ybhBdzZc96KCxYMslNrmlLRi8w6uUusi8J4BUVNM	\N	master
22	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$wEzXoaJoNtWHISsmLEY6T-CdgUw21BFOyAw1HcKBBh0	\N	master
23	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$2KF1FxA50OygX8tA7bnhmld7ePb4eIDsQaPB5ssgUSc	\N	master
24	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$g-ojtwk6OBH0sIWVdUrIlKfcesmKRj0kfU5E9ZjKlug	\N	master
25	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$5zlbkFcwjX3ScF4jwQP_koQvnG_-hWrIYwwn4RhXMGs	\N	master
26	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$PSZPiF2_GHeawUZsuFzgg_JuCtoOyaf_11-uLulGF0c	$wEzXoaJoNtWHISsmLEY6T-CdgUw21BFOyAw1HcKBBh0	master
27	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$t5n7gGV4l0pVzkJq8YJdQm4IFq3hTrEHABs9QiejsEA	$2KF1FxA50OygX8tA7bnhmld7ePb4eIDsQaPB5ssgUSc	master
28	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$CPrx1EOiKU0xFQBY1-CbMIp4Nx64vw33awql9URc-is	$g-ojtwk6OBH0sIWVdUrIlKfcesmKRj0kfU5E9ZjKlug	master
29	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk	$5zlbkFcwjX3ScF4jwQP_koQvnG_-hWrIYwwn4RhXMGs	master
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
$mGK5pQEzegKFhAPXc0TX7drNl2qyJL8ajxnJRmA3kN8	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	join
$666ybhBdzZc96KCxYMslNrmlLRi8w6uUusi8J4BUVNM	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	join
$PSZPiF2_GHeawUZsuFzgg_JuCtoOyaf_11-uLulGF0c	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	join
$t5n7gGV4l0pVzkJq8YJdQm4IFq3hTrEHABs9QiejsEA	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	join
$CPrx1EOiKU0xFQBY1-CbMIp4Nx64vw33awql9URc-is	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	join
$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	join
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
2	@admin:localhost	WCSUBIGVWG
3	@matrix_a:localhost	TKAVEOGKHH
4	@matrix_b:localhost	DJFHSWMXLW
5	@ignored_user:localhost	IYEBBQEXHS
6	@matterbot:localhost	OKGPMGNNEY
7	@mm_mattermost_b:localhost	ZESISTJYYM
8	@mm_mattermost_a:localhost	CWUORKDCEH
\.


--
-- Data for Name: devices; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.devices (user_id, device_id, display_name, last_seen, ip, user_agent, hidden) FROM stdin;
@ignored_user:localhost	IYEBBQEXHS	\N	1598686328565	172.21.0.1	curl/7.72.0	f
@matterbot:localhost	OKGPMGNNEY	\N	\N	\N	\N	f
@mm_mattermost_b:localhost	ZESISTJYYM	\N	\N	\N	\N	f
@mm_mattermost_a:localhost	CWUORKDCEH	\N	\N	\N	\N	f
@admin:localhost	WCSUBIGVWG	\N	1672856705983	172.16.238.1		f
@matrix_a:localhost	TKAVEOGKHH	\N	1672856706252	172.16.238.1		f
@matrix_b:localhost	DJFHSWMXLW	\N	1672856706787	172.16.238.1		f
\.


--
-- Data for Name: e2e_cross_signing_keys; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_cross_signing_keys (user_id, keytype, keydata, stream_id) FROM stdin;
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
$mGK5pQEzegKFhAPXc0TX7drNl2qyJL8ajxnJRmA3kN8	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$mGK5pQEzegKFhAPXc0TX7drNl2qyJL8ajxnJRmA3kN8	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$mGK5pQEzegKFhAPXc0TX7drNl2qyJL8ajxnJRmA3kN8	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$666ybhBdzZc96KCxYMslNrmlLRi8w6uUusi8J4BUVNM	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$666ybhBdzZc96KCxYMslNrmlLRi8w6uUusi8J4BUVNM	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$666ybhBdzZc96KCxYMslNrmlLRi8w6uUusi8J4BUVNM	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$wEzXoaJoNtWHISsmLEY6T-CdgUw21BFOyAw1HcKBBh0	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$wEzXoaJoNtWHISsmLEY6T-CdgUw21BFOyAw1HcKBBh0	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$wEzXoaJoNtWHISsmLEY6T-CdgUw21BFOyAw1HcKBBh0	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$wEzXoaJoNtWHISsmLEY6T-CdgUw21BFOyAw1HcKBBh0	$mGK5pQEzegKFhAPXc0TX7drNl2qyJL8ajxnJRmA3kN8	!dKcbdDATuwwphjRPQP:localhost
$2KF1FxA50OygX8tA7bnhmld7ePb4eIDsQaPB5ssgUSc	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$2KF1FxA50OygX8tA7bnhmld7ePb4eIDsQaPB5ssgUSc	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$2KF1FxA50OygX8tA7bnhmld7ePb4eIDsQaPB5ssgUSc	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$2KF1FxA50OygX8tA7bnhmld7ePb4eIDsQaPB5ssgUSc	$666ybhBdzZc96KCxYMslNrmlLRi8w6uUusi8J4BUVNM	!kmbTYjjsDRDHGgVqUP:localhost
$g-ojtwk6OBH0sIWVdUrIlKfcesmKRj0kfU5E9ZjKlug	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$g-ojtwk6OBH0sIWVdUrIlKfcesmKRj0kfU5E9ZjKlug	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$g-ojtwk6OBH0sIWVdUrIlKfcesmKRj0kfU5E9ZjKlug	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$g-ojtwk6OBH0sIWVdUrIlKfcesmKRj0kfU5E9ZjKlug	$mGK5pQEzegKFhAPXc0TX7drNl2qyJL8ajxnJRmA3kN8	!dKcbdDATuwwphjRPQP:localhost
$5zlbkFcwjX3ScF4jwQP_koQvnG_-hWrIYwwn4RhXMGs	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$5zlbkFcwjX3ScF4jwQP_koQvnG_-hWrIYwwn4RhXMGs	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$5zlbkFcwjX3ScF4jwQP_koQvnG_-hWrIYwwn4RhXMGs	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$5zlbkFcwjX3ScF4jwQP_koQvnG_-hWrIYwwn4RhXMGs	$666ybhBdzZc96KCxYMslNrmlLRi8w6uUusi8J4BUVNM	!kmbTYjjsDRDHGgVqUP:localhost
$PSZPiF2_GHeawUZsuFzgg_JuCtoOyaf_11-uLulGF0c	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$PSZPiF2_GHeawUZsuFzgg_JuCtoOyaf_11-uLulGF0c	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$PSZPiF2_GHeawUZsuFzgg_JuCtoOyaf_11-uLulGF0c	$wEzXoaJoNtWHISsmLEY6T-CdgUw21BFOyAw1HcKBBh0	!dKcbdDATuwwphjRPQP:localhost
$PSZPiF2_GHeawUZsuFzgg_JuCtoOyaf_11-uLulGF0c	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$t5n7gGV4l0pVzkJq8YJdQm4IFq3hTrEHABs9QiejsEA	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$t5n7gGV4l0pVzkJq8YJdQm4IFq3hTrEHABs9QiejsEA	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$t5n7gGV4l0pVzkJq8YJdQm4IFq3hTrEHABs9QiejsEA	$2KF1FxA50OygX8tA7bnhmld7ePb4eIDsQaPB5ssgUSc	!kmbTYjjsDRDHGgVqUP:localhost
$t5n7gGV4l0pVzkJq8YJdQm4IFq3hTrEHABs9QiejsEA	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$CPrx1EOiKU0xFQBY1-CbMIp4Nx64vw33awql9URc-is	$g-ojtwk6OBH0sIWVdUrIlKfcesmKRj0kfU5E9ZjKlug	!dKcbdDATuwwphjRPQP:localhost
$CPrx1EOiKU0xFQBY1-CbMIp4Nx64vw33awql9URc-is	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$CPrx1EOiKU0xFQBY1-CbMIp4Nx64vw33awql9URc-is	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$CPrx1EOiKU0xFQBY1-CbMIp4Nx64vw33awql9URc-is	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk	$5zlbkFcwjX3ScF4jwQP_koQvnG_-hWrIYwwn4RhXMGs	!kmbTYjjsDRDHGgVqUP:localhost
$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
\.


--
-- Data for Name: event_auth_chain_links; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_auth_chain_links (origin_chain_id, origin_sequence_number, target_chain_id, target_sequence_number) FROM stdin;
12	1	16	1
8	1	10	1
3	1	18	1
12	1	18	1
3	1	9	1
11	1	1	1
7	1	8	1
5	1	7	1
2	1	8	1
14	1	7	1
6	1	7	1
2	1	10	1
9	1	16	1
11	1	7	1
1	1	8	1
12	1	9	1
1	1	10	1
7	1	10	1
17	1	16	1
4	1	3	1
17	1	18	1
2	1	7	1
5	1	8	1
14	1	8	1
6	1	8	1
13	1	3	1
5	1	10	1
13	1	9	1
14	1	10	1
1	1	7	1
6	1	10	1
18	1	16	1
4	1	18	1
14	1	1	1
4	1	16	1
17	1	9	1
4	1	9	1
13	1	18	1
13	1	16	1
15	1	3	1
3	1	16	1
15	1	16	1
11	1	8	1
15	1	18	1
6	1	1	1
11	1	10	1
15	1	9	1
18	1	9	1
19	1	7	1
19	1	8	1
19	1	1	1
19	1	10	1
20	1	9	1
20	1	18	1
20	1	16	1
20	1	3	1
21	1	1	1
21	1	8	1
21	1	10	1
21	1	7	1
21	1	19	1
22	1	16	1
22	1	18	1
22	1	9	1
22	1	3	1
22	1	20	1
23	1	19	1
23	1	8	1
23	1	10	1
23	1	1	1
23	1	7	1
24	1	16	1
24	1	18	1
24	1	3	1
24	1	9	1
24	1	20	1
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
$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA	8	1
$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	7	1
$TVnvv0nGbLydCBtMmTTz-htMsoI4hmxCr3s9AHyFGHQ	5	1
$b__a7rX3L5YpX7nAZte73DAbjtXZK48JH8VKSnGOKKw	2	1
$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	1	1
$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0	14	1
$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A	6	1
$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	16	1
$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw	9	1
$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	18	1
$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	3	1
$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8	4	1
$O5iO4EII22igkDq5cMKHFB-SGIYD0KqJQXZohS2Dzc0	17	1
$X8tdoEsXAgBC6gobCepAn3rwO8CJoQU6i9NN9Rzhukg	12	1
$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	13	1
$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk	15	1
$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0	11	1
$mGK5pQEzegKFhAPXc0TX7drNl2qyJL8ajxnJRmA3kN8	19	1
$666ybhBdzZc96KCxYMslNrmlLRi8w6uUusi8J4BUVNM	20	1
$wEzXoaJoNtWHISsmLEY6T-CdgUw21BFOyAw1HcKBBh0	21	1
$2KF1FxA50OygX8tA7bnhmld7ePb4eIDsQaPB5ssgUSc	22	1
$g-ojtwk6OBH0sIWVdUrIlKfcesmKRj0kfU5E9ZjKlug	23	1
$5zlbkFcwjX3ScF4jwQP_koQvnG_-hWrIYwwn4RhXMGs	24	1
$PSZPiF2_GHeawUZsuFzgg_JuCtoOyaf_11-uLulGF0c	21	2
$t5n7gGV4l0pVzkJq8YJdQm4IFq3hTrEHABs9QiejsEA	22	2
$CPrx1EOiKU0xFQBY1-CbMIp4Nx64vw33awql9URc-is	23	2
$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk	24	2
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
$mGK5pQEzegKFhAPXc0TX7drNl2qyJL8ajxnJRmA3kN8	$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A	!dKcbdDATuwwphjRPQP:localhost	f
$666ybhBdzZc96KCxYMslNrmlLRi8w6uUusi8J4BUVNM	$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	!kmbTYjjsDRDHGgVqUP:localhost	f
$wEzXoaJoNtWHISsmLEY6T-CdgUw21BFOyAw1HcKBBh0	$mGK5pQEzegKFhAPXc0TX7drNl2qyJL8ajxnJRmA3kN8	!dKcbdDATuwwphjRPQP:localhost	f
$2KF1FxA50OygX8tA7bnhmld7ePb4eIDsQaPB5ssgUSc	$666ybhBdzZc96KCxYMslNrmlLRi8w6uUusi8J4BUVNM	!kmbTYjjsDRDHGgVqUP:localhost	f
$g-ojtwk6OBH0sIWVdUrIlKfcesmKRj0kfU5E9ZjKlug	$wEzXoaJoNtWHISsmLEY6T-CdgUw21BFOyAw1HcKBBh0	!dKcbdDATuwwphjRPQP:localhost	f
$5zlbkFcwjX3ScF4jwQP_koQvnG_-hWrIYwwn4RhXMGs	$2KF1FxA50OygX8tA7bnhmld7ePb4eIDsQaPB5ssgUSc	!kmbTYjjsDRDHGgVqUP:localhost	f
$PSZPiF2_GHeawUZsuFzgg_JuCtoOyaf_11-uLulGF0c	$g-ojtwk6OBH0sIWVdUrIlKfcesmKRj0kfU5E9ZjKlug	!dKcbdDATuwwphjRPQP:localhost	f
$t5n7gGV4l0pVzkJq8YJdQm4IFq3hTrEHABs9QiejsEA	$5zlbkFcwjX3ScF4jwQP_koQvnG_-hWrIYwwn4RhXMGs	!kmbTYjjsDRDHGgVqUP:localhost	f
$CPrx1EOiKU0xFQBY1-CbMIp4Nx64vw33awql9URc-is	$PSZPiF2_GHeawUZsuFzgg_JuCtoOyaf_11-uLulGF0c	!dKcbdDATuwwphjRPQP:localhost	f
$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk	$t5n7gGV4l0pVzkJq8YJdQm4IFq3hTrEHABs9QiejsEA	!kmbTYjjsDRDHGgVqUP:localhost	f
$cVpm7JtI2FA6jT91bWn5avhRlFg_CpMA5HRanoYhkJs	$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk	!kmbTYjjsDRDHGgVqUP:localhost	f
$jD0GZ5JDGHZiN5kp0llsZ-TSj7JcaRn8CDsEQiyeJ3w	$cVpm7JtI2FA6jT91bWn5avhRlFg_CpMA5HRanoYhkJs	!kmbTYjjsDRDHGgVqUP:localhost	f
$1-1XawRJVm29pQHrbkTGcQ-bYWMPoyyXEnV9D0NRRF8	$jD0GZ5JDGHZiN5kp0llsZ-TSj7JcaRn8CDsEQiyeJ3w	!kmbTYjjsDRDHGgVqUP:localhost	f
$hr9BoL0M0CcPevs38ww5_bA24p8HFiP4e9dlGuPrGWs	$1-1XawRJVm29pQHrbkTGcQ-bYWMPoyyXEnV9D0NRRF8	!kmbTYjjsDRDHGgVqUP:localhost	f
$QM2BSnrrZmMuXPjs3AMnJ7zVsHHdXmGmCFPjoGqBlaQ	$CPrx1EOiKU0xFQBY1-CbMIp4Nx64vw33awql9URc-is	!dKcbdDATuwwphjRPQP:localhost	f
$_OchgUntbLcDcJV42YEeAhH2t22AW-wlAxjRPO0SYfU	$hr9BoL0M0CcPevs38ww5_bA24p8HFiP4e9dlGuPrGWs	!kmbTYjjsDRDHGgVqUP:localhost	f
$Z5cKxfveccJ3nnCMqKA-jwkRw9hbVrCMv6R68J8oPVg	$QM2BSnrrZmMuXPjs3AMnJ7zVsHHdXmGmCFPjoGqBlaQ	!dKcbdDATuwwphjRPQP:localhost	f
$G1fvwCN2g1XjFzNmxLnkU_pe19oYNSqJMKqzj8kfXCk	$Z5cKxfveccJ3nnCMqKA-jwkRw9hbVrCMv6R68J8oPVg	!dKcbdDATuwwphjRPQP:localhost	f
$Jt6sBZkF1u2z9OovN4zzqiZfS0rQPS2vVpynSjt9ypI	$_OchgUntbLcDcJV42YEeAhH2t22AW-wlAxjRPO0SYfU	!kmbTYjjsDRDHGgVqUP:localhost	f
$xRdCRWLb62a-YRgcfBkJSxc7lUVFkdZnQfSIvcKWw88	$G1fvwCN2g1XjFzNmxLnkU_pe19oYNSqJMKqzj8kfXCk	!dKcbdDATuwwphjRPQP:localhost	f
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
$Jt6sBZkF1u2z9OovN4zzqiZfS0rQPS2vVpynSjt9ypI	!kmbTYjjsDRDHGgVqUP:localhost
$xRdCRWLb62a-YRgcfBkJSxc7lUVFkdZnQfSIvcKWw88	!dKcbdDATuwwphjRPQP:localhost
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
$cVpm7JtI2FA6jT91bWn5avhRlFg_CpMA5HRanoYhkJs	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672856705941.0","historical":false}	{"auth_events":["$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"test"},"depth":15,"prev_state":[],"origin":"localhost","origin_server_ts":1672856706015,"hashes":{"sha256":"v0zddkJR19A+G1mvjwp0Jq+4z8HTR9vdTdR8Mflri3k"},"signatures":{"localhost":{"ed25519:a_CHdg":"4hFpMiZGnXhglLH9zZWa+7gj/iw4LcK3w+WLkpf2VnY8l+rSzrrN7s5o9QpkjzKR4rV8jIbJklr3qQXo6mqBCQ"}},"unsigned":{"age_ts":1672856706015}}	3
$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id": 5, "stream_ordering": 18}	{"auth_events": ["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w", "$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o", "$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"], "prev_events": ["$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk"], "type": "m.room.member", "room_id": "!kmbTYjjsDRDHGgVqUP:localhost", "sender": "@ignored_user:localhost", "content": {"membership": "join", "displayname": "ignored_user"}, "depth": 9, "prev_state": [], "state_key": "@ignored_user:localhost", "origin": "localhost", "origin_server_ts": 1598686328575, "hashes": {"sha256": "D/rwxkYqWZ03Kws7Xsq84khdp4oGHRGnOy4+XwM8dLA"}, "signatures": {"localhost": {"ed25519:a_snHR": "kXK8xKjLjJ97KcFQivelEBI1TR/au+bgtD6i2VPDp9LjRi1bVH/zb6YqHZetT0JYaGt3NY4iFeN0Qh0mD4zyAg"}}, "unsigned": {"age_ts": 1598686328575}}	3
$mGK5pQEzegKFhAPXc0TX7drNl2qyJL8ajxnJRmA3kN8	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"depth":10,"prev_state":[],"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1672856701211,"hashes":{"sha256":"rzo6j5PUyS8xiPnkIdXtQY5ZoaisK5PAsJV/wyhr0O0"},"signatures":{"localhost":{"ed25519:a_CHdg":"R6gMPFwW+gWrv3Hd99j9wZP2722Af/rzquCGCJuzE115hOv4a8BEOFmDhCxT1Hdpav1RjjUsecsu2dkHsPy7Ag"}},"unsigned":{"age_ts":1672856701211}}	3
$666ybhBdzZc96KCxYMslNrmlLRi8w6uUusi8J4BUVNM	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"depth":10,"prev_state":[],"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1672856701213,"hashes":{"sha256":"FR32T9hZC588xWC5YaJHu41guZvI3jZIl/cIwwFq8ec"},"signatures":{"localhost":{"ed25519:a_CHdg":"Y4snzhT0t8tuM49c/giopoiRK3ZCX7rVCqBD2ZRu4D/fVnUgndcXNI4g/wiEa5tFdAcKg/f9AD+5WYaDh64aBw"}},"unsigned":{"age_ts":1672856701213}}	3
$wEzXoaJoNtWHISsmLEY6T-CdgUw21BFOyAw1HcKBBh0	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$mGK5pQEzegKFhAPXc0TX7drNl2qyJL8ajxnJRmA3kN8"],"prev_events":["$mGK5pQEzegKFhAPXc0TX7drNl2qyJL8ajxnJRmA3kN8"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"mattermost_b [mm]"},"depth":11,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672856704532,"hashes":{"sha256":"ZbnkbtIEQ3EQOfZLl24Ejv4TAj3GeFEwK4cnX+D6iKI"},"signatures":{"localhost":{"ed25519:a_CHdg":"WEWNwuz5K8ieW6/7ATPp3AGicl1Vt4ytE4rWih04rZyr/CG/HzYP+gO3gr4JyfACH21iRnyjwpYtOWXLGB9SDg"}},"unsigned":{"age_ts":1672856704532,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#off-topic:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$2KF1FxA50OygX8tA7bnhmld7ePb4eIDsQaPB5ssgUSc	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$666ybhBdzZc96KCxYMslNrmlLRi8w6uUusi8J4BUVNM"],"prev_events":["$666ybhBdzZc96KCxYMslNrmlLRi8w6uUusi8J4BUVNM"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"mattermost_b [mm]"},"depth":11,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672856704711,"hashes":{"sha256":"eflN7iLImPysjpzNCVBmxy35vqjgeu7JK+c8YtATiIk"},"signatures":{"localhost":{"ed25519:a_CHdg":"h8iC/srzU9fC5RCpsSy1CsFnq+YgNSqDLbTmnhgtRMpIx9kDOCyQLoysXkKE0mUpZ8T8sjgnpYTCWe6VUjf+CQ"}},"unsigned":{"age_ts":1672856704711,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#town-square:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$g-ojtwk6OBH0sIWVdUrIlKfcesmKRj0kfU5E9ZjKlug	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$mGK5pQEzegKFhAPXc0TX7drNl2qyJL8ajxnJRmA3kN8"],"prev_events":["$wEzXoaJoNtWHISsmLEY6T-CdgUw21BFOyAw1HcKBBh0"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"MattermostUser A [mm]"},"depth":12,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672856704815,"hashes":{"sha256":"Lox2QKFmFIuQt8nnEVENhphpypul8lKv8KUzMr2rZJs"},"signatures":{"localhost":{"ed25519:a_CHdg":"eg4CB+ZW7X4kha8teEF+djuVmBn9W/dQRVrOaRw0ZtY5Bbdu+y7aJ1os4qdQMOKwykptDZi8QNdPGRZti6f4DA"}},"unsigned":{"age_ts":1672856704815,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#off-topic:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$PSZPiF2_GHeawUZsuFzgg_JuCtoOyaf_11-uLulGF0c	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$wEzXoaJoNtWHISsmLEY6T-CdgUw21BFOyAw1HcKBBh0","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$g-ojtwk6OBH0sIWVdUrIlKfcesmKRj0kfU5E9ZjKlug"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_b:localhost","content":{"membership":"join","displayname":"mattermost_b [mm]"},"depth":13,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672856705079,"hashes":{"sha256":"TdxHsUuLfOfjRGJ5rwGw0vFsZh9PvEodT2aBCInSa94"},"signatures":{"localhost":{"ed25519:a_CHdg":"ASn47iW9FwgGOnLrKFAwYcXowuPopnYY+NajMgzyTyvGRJMBK6XBaYDSdhDWC0mnCHHy/bfllqAypsyqh5efDA"}},"unsigned":{"age_ts":1672856705079,"replaces_state":"$wEzXoaJoNtWHISsmLEY6T-CdgUw21BFOyAw1HcKBBh0"}}	3
$5zlbkFcwjX3ScF4jwQP_koQvnG_-hWrIYwwn4RhXMGs	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$666ybhBdzZc96KCxYMslNrmlLRi8w6uUusi8J4BUVNM"],"prev_events":["$2KF1FxA50OygX8tA7bnhmld7ePb4eIDsQaPB5ssgUSc"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"MattermostUser A [mm]"},"depth":12,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672856704946,"hashes":{"sha256":"eD76uDQosICdhPs2wl/cm4ewwIzV6V/DgCy1W9kzPP4"},"signatures":{"localhost":{"ed25519:a_CHdg":"1oRyOWBYNyQW4oPVMjg+/SnvPS6dgdHEkXA+na33kRUjIxi16IF+8Y7KNRGMnbMzW18WRDmu5L7sK2cemPCuBA"}},"unsigned":{"age_ts":1672856704946,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#town-square:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$t5n7gGV4l0pVzkJq8YJdQm4IFq3hTrEHABs9QiejsEA	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$2KF1FxA50OygX8tA7bnhmld7ePb4eIDsQaPB5ssgUSc","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$5zlbkFcwjX3ScF4jwQP_koQvnG_-hWrIYwwn4RhXMGs"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_b:localhost","content":{"membership":"join","displayname":"mattermost_b [mm]"},"depth":13,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672856705294,"hashes":{"sha256":"k+YJ5gaPKjJYMz+wFrQSadKOn233UCIy42qFMhLAQ7M"},"signatures":{"localhost":{"ed25519:a_CHdg":"boiMJwSIXF+mIYlw9/H6Nc9CDEXMhcBTAridor+VEzsWSwU166Ya1qtsREJwWYkcEAAEFM7ZkA1PrGXT+71/Ag"}},"unsigned":{"age_ts":1672856705294,"replaces_state":"$2KF1FxA50OygX8tA7bnhmld7ePb4eIDsQaPB5ssgUSc"}}	3
$CPrx1EOiKU0xFQBY1-CbMIp4Nx64vw33awql9URc-is	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$g-ojtwk6OBH0sIWVdUrIlKfcesmKRj0kfU5E9ZjKlug","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$PSZPiF2_GHeawUZsuFzgg_JuCtoOyaf_11-uLulGF0c"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_a:localhost","content":{"membership":"join","displayname":"MattermostUser A [mm]"},"depth":14,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672856705313,"hashes":{"sha256":"ik18kB11YX5jAC3FW+eCSHvZ4I6iuapAZwp3jLQYJaw"},"signatures":{"localhost":{"ed25519:a_CHdg":"g98oRLKE9G+bsOaFh4kulCxg3b4c7yIu2CLp+joOwZpafdNlX32csNzWOn3wvLShoYF3AWn/cIxaFABC0q6rBA"}},"unsigned":{"age_ts":1672856705313,"replaces_state":"$g-ojtwk6OBH0sIWVdUrIlKfcesmKRj0kfU5E9ZjKlug"}}	3
$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$5zlbkFcwjX3ScF4jwQP_koQvnG_-hWrIYwwn4RhXMGs","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$t5n7gGV4l0pVzkJq8YJdQm4IFq3hTrEHABs9QiejsEA"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"membership":"join","displayname":"MattermostUser A [mm]"},"depth":14,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672856705533,"hashes":{"sha256":"N45WT3RGOI7iqlKTnP+OuK3a6Ue0f6M1/CwirC7Z5gI"},"signatures":{"localhost":{"ed25519:a_CHdg":"9BcSxsAN4pTq0/DY2H/A6k2fUhsa3LAEX2LKAVjArh6/NkBQnErIDfNRIRzAy4NDsDpLq5TMVF4KlyCUCX7dBg"}},"unsigned":{"age_ts":1672856705533,"replaces_state":"$5zlbkFcwjX3ScF4jwQP_koQvnG_-hWrIYwwn4RhXMGs"}}	3
$QM2BSnrrZmMuXPjs3AMnJ7zVsHHdXmGmCFPjoGqBlaQ	!dKcbdDATuwwphjRPQP:localhost	{"txn_id":"m1672856707033.2","historical":false}	{"auth_events":["$CPrx1EOiKU0xFQBY1-CbMIp4Nx64vw33awql9URc-is","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$CPrx1EOiKU0xFQBY1-CbMIp4Nx64vw33awql9URc-is"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.emote","body":"hi me"},"depth":15,"prev_state":[],"origin":"localhost","origin_server_ts":1672856707072,"hashes":{"sha256":"u2QsuqdmJH2Pm0CDxUlR3zgIeV2PUVKiBQrLNYDCZSU"},"signatures":{"localhost":{"ed25519:a_CHdg":"9sNVg4Et1ZmfCktOKRsGTY4ttd6ZbD/2uZkvPdSQkgrUSmgyW74ku/Dck9sxS0E00fLKGaGJQMMoeL0uX8RpBw"}},"unsigned":{"age_ts":1672856707072}}	3
$_OchgUntbLcDcJV42YEeAhH2t22AW-wlAxjRPO0SYfU	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":3,"txn_id":"m1672856707257.0","historical":false}	{"auth_events":["$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$hr9BoL0M0CcPevs38ww5_bA24p8HFiP4e9dlGuPrGWs"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.emote","body":"test"},"depth":19,"prev_state":[],"origin":"localhost","origin_server_ts":1672856707296,"hashes":{"sha256":"HWop79XOTOY0CEfu6IRL6Xif5uZqQFqx1dVpufQf9rE"},"signatures":{"localhost":{"ed25519:a_CHdg":"EPkRIX1TO+t3qh0DIna7SAoeYvnIUZY+qtY76hvdsdStI0wNiywTshaRPTGoCW9U7laUVOH2A0jf2r9zoNpaAg"}},"unsigned":{"age_ts":1672856707296}}	3
$xRdCRWLb62a-YRgcfBkJSxc7lUVFkdZnQfSIvcKWw88	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672856708195.0","historical":false}	{"auth_events":["$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$G1fvwCN2g1XjFzNmxLnkU_pe19oYNSqJMKqzj8kfXCk"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"hidden message"},"depth":18,"prev_state":[],"origin":"localhost","origin_server_ts":1672856708238,"hashes":{"sha256":"ic058PvxeyVVIpikSXkNalLX7PP8Xs/IUdiWAfdQBrc"},"signatures":{"localhost":{"ed25519:a_CHdg":"Zc4b5TOyvOb6y4pNzkJ7giYQh/7ugC/Uo53XeedFevFy9DN2Je7LxoTzv84iw90ph7nkBeuCKKTMWeqyLjdJCQ"}},"unsigned":{"age_ts":1672856708238}}	3
$jD0GZ5JDGHZiN5kp0llsZ-TSj7JcaRn8CDsEQiyeJ3w	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":3,"txn_id":"m1672856706219.0","historical":false}	{"auth_events":["$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$cVpm7JtI2FA6jT91bWn5avhRlFg_CpMA5HRanoYhkJs"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"test2"},"depth":16,"prev_state":[],"origin":"localhost","origin_server_ts":1672856706271,"hashes":{"sha256":"WiwXfgAHJNb+xKCj8FGdLzd04JKKT0icyZl3EORIg5M"},"signatures":{"localhost":{"ed25519:a_CHdg":"fG20xDFWmoixTjpiv9t7bjR8e+ASc+5PBvBTh17ynxtuCDgpS8ESYC2+hR5QSRJH4nFPIuUZddQt6979kZZKAg"}},"unsigned":{"age_ts":1672856706271}}	3
$1-1XawRJVm29pQHrbkTGcQ-bYWMPoyyXEnV9D0NRRF8	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672856706497.1","historical":false}	{"auth_events":["$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$jD0GZ5JDGHZiN5kp0llsZ-TSj7JcaRn8CDsEQiyeJ3w"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"# Header\\n\\n**bold**","format":"org.matrix.custom.html","formatted_body":"<h1>Header</h1><strong>bold</strong>"},"depth":17,"prev_state":[],"origin":"localhost","origin_server_ts":1672856706565,"hashes":{"sha256":"zwBs31mBttUnk6uBPXIqtWfyz48rO/k+Zghjqgz04J4"},"signatures":{"localhost":{"ed25519:a_CHdg":"OswdnJBLmrlWwyn7h9SPbHwpzO/XBjyHAwyoFuDZWU5ybhEOi1dEVWm+fA5APH0g/SaHrAlhzeM8Kg3ON39eAA"}},"unsigned":{"age_ts":1672856706565}}	3
$hr9BoL0M0CcPevs38ww5_bA24p8HFiP4e9dlGuPrGWs	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":4,"txn_id":"m1672856706759.0","historical":false}	{"auth_events":["$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$1-1XawRJVm29pQHrbkTGcQ-bYWMPoyyXEnV9D0NRRF8"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_b:localhost","content":{"msgtype":"m.text","body":"random wrong message","format":"org.matrix.custom.html","formatted_body":"<h1>Header</h1><b>Bolded text</b>"},"depth":18,"prev_state":[],"origin":"localhost","origin_server_ts":1672856706805,"hashes":{"sha256":"TIP/NFqNrA/gECaigSf3sV8MHp3w65YhRrjC9BP0/5o"},"signatures":{"localhost":{"ed25519:a_CHdg":"51fS6cZJ3DVMnLsLqrBuPkebN0A4Wrcz4MHuv16HV4POPwa3D0IAxAwFxx+J+K2y6mhNxfDcOJre7gtU5bp6DA"}},"unsigned":{"age_ts":1672856706805}}	3
$Z5cKxfveccJ3nnCMqKA-jwkRw9hbVrCMv6R68J8oPVg	!dKcbdDATuwwphjRPQP:localhost	{"txn_id":"m1672856707534.0","historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$PSZPiF2_GHeawUZsuFzgg_JuCtoOyaf_11-uLulGF0c","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$QM2BSnrrZmMuXPjs3AMnJ7zVsHHdXmGmCFPjoGqBlaQ"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_b:localhost","content":{"msgtype":"m.text","body":"filename"},"depth":16,"prev_state":[],"origin":"localhost","origin_server_ts":1672856707574,"hashes":{"sha256":"XzjnascxcOisdZvK9HILaisShW7MUYaSehy/VW3VazM"},"signatures":{"localhost":{"ed25519:a_CHdg":"FOOZPqr8pCXxwBnYPTcNYiAKeKIB0OvZ2+ZwLaqCQumMqraOwDb1SiMXohKv5DDOfZIkJ7W/iC3nTvH2zZvICQ"}},"unsigned":{"age_ts":1672856707574}}	3
$G1fvwCN2g1XjFzNmxLnkU_pe19oYNSqJMKqzj8kfXCk	!dKcbdDATuwwphjRPQP:localhost	{"txn_id":"m1672856707691.1","historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$PSZPiF2_GHeawUZsuFzgg_JuCtoOyaf_11-uLulGF0c","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$Z5cKxfveccJ3nnCMqKA-jwkRw9hbVrCMv6R68J8oPVg"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_b:localhost","content":{"msgtype":"m.file","body":"filename","url":"mxc://localhost/fndsNAAjXPUHvtbKurhIoDum","info":{"mimetype":"","size":11}},"depth":17,"prev_state":[],"origin":"localhost","origin_server_ts":1672856707732,"hashes":{"sha256":"pOdSpZCLq/gwKKygtFcuHyrVBmkvm3qGbk8k1zj0nH0"},"signatures":{"localhost":{"ed25519:a_CHdg":"WUBOfNXA0TIV5k0dstIzggAFsp+ozG0raqHv3AnVOy2RaXxGMW9GCeUjXFdtxmUp4fNgqPQmvH3rePWKid8nBQ"}},"unsigned":{"age_ts":1672856707732}}	3
$Jt6sBZkF1u2z9OovN4zzqiZfS0rQPS2vVpynSjt9ypI	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":3,"txn_id":"m1672856707957.0","historical":false}	{"auth_events":["$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$_OchgUntbLcDcJV42YEeAhH2t22AW-wlAxjRPO0SYfU"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.file","body":"mydata","url":"mxc://localhost/uVWXteoIJOgvlXENjBgBOUcc","info":{"mimetype":"text/plain"}},"depth":20,"prev_state":[],"origin":"localhost","origin_server_ts":1672856707997,"hashes":{"sha256":"CoKaGs/tOT/54EU6PuKxxHAnfLf3PNnIE+DzhDusCcM"},"signatures":{"localhost":{"ed25519:a_CHdg":"UfYzOfA2HYiI21VzS4bTh9eTagwn2L/wf2jbC0mhcFBA68f1j89B9JcUn4EzlaM96DLMxFPB9tyhukeq9yQAAQ"}},"unsigned":{"age_ts":1672856707997}}	3
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
!kmbTYjjsDRDHGgVqUP:localhost	$cVpm7JtI2FA6jT91bWn5avhRlFg_CpMA5HRanoYhkJs	@matterbot:localhost	\N		15	30	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$cVpm7JtI2FA6jT91bWn5avhRlFg_CpMA5HRanoYhkJs	@admin:localhost	\N		15	30	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$cVpm7JtI2FA6jT91bWn5avhRlFg_CpMA5HRanoYhkJs	@matrix_b:localhost	\N		15	30	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$cVpm7JtI2FA6jT91bWn5avhRlFg_CpMA5HRanoYhkJs	@matrix_a:localhost	\N		15	30	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$cVpm7JtI2FA6jT91bWn5avhRlFg_CpMA5HRanoYhkJs	@ignored_user:localhost	\N		15	30	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$jD0GZ5JDGHZiN5kp0llsZ-TSj7JcaRn8CDsEQiyeJ3w	@matterbot:localhost	\N		16	31	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$jD0GZ5JDGHZiN5kp0llsZ-TSj7JcaRn8CDsEQiyeJ3w	@admin:localhost	\N		16	31	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$jD0GZ5JDGHZiN5kp0llsZ-TSj7JcaRn8CDsEQiyeJ3w	@matrix_b:localhost	\N		16	31	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$jD0GZ5JDGHZiN5kp0llsZ-TSj7JcaRn8CDsEQiyeJ3w	@ignored_user:localhost	\N		16	31	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$1-1XawRJVm29pQHrbkTGcQ-bYWMPoyyXEnV9D0NRRF8	@matterbot:localhost	\N		17	32	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$1-1XawRJVm29pQHrbkTGcQ-bYWMPoyyXEnV9D0NRRF8	@admin:localhost	\N		17	32	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$1-1XawRJVm29pQHrbkTGcQ-bYWMPoyyXEnV9D0NRRF8	@matrix_b:localhost	\N		17	32	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$1-1XawRJVm29pQHrbkTGcQ-bYWMPoyyXEnV9D0NRRF8	@matrix_a:localhost	\N		17	32	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$1-1XawRJVm29pQHrbkTGcQ-bYWMPoyyXEnV9D0NRRF8	@ignored_user:localhost	\N		17	32	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$hr9BoL0M0CcPevs38ww5_bA24p8HFiP4e9dlGuPrGWs	@matterbot:localhost	\N		18	33	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$hr9BoL0M0CcPevs38ww5_bA24p8HFiP4e9dlGuPrGWs	@admin:localhost	\N		18	33	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$hr9BoL0M0CcPevs38ww5_bA24p8HFiP4e9dlGuPrGWs	@matrix_a:localhost	\N		18	33	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$hr9BoL0M0CcPevs38ww5_bA24p8HFiP4e9dlGuPrGWs	@ignored_user:localhost	\N		18	33	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$QM2BSnrrZmMuXPjs3AMnJ7zVsHHdXmGmCFPjoGqBlaQ	@matterbot:localhost	\N		15	34	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$QM2BSnrrZmMuXPjs3AMnJ7zVsHHdXmGmCFPjoGqBlaQ	@admin:localhost	\N		15	34	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$QM2BSnrrZmMuXPjs3AMnJ7zVsHHdXmGmCFPjoGqBlaQ	@matrix_b:localhost	\N		15	34	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$QM2BSnrrZmMuXPjs3AMnJ7zVsHHdXmGmCFPjoGqBlaQ	@matrix_a:localhost	\N		15	34	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$QM2BSnrrZmMuXPjs3AMnJ7zVsHHdXmGmCFPjoGqBlaQ	@ignored_user:localhost	\N		15	34	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$_OchgUntbLcDcJV42YEeAhH2t22AW-wlAxjRPO0SYfU	@matterbot:localhost	\N		19	35	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$_OchgUntbLcDcJV42YEeAhH2t22AW-wlAxjRPO0SYfU	@admin:localhost	\N		19	35	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$_OchgUntbLcDcJV42YEeAhH2t22AW-wlAxjRPO0SYfU	@matrix_b:localhost	\N		19	35	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$_OchgUntbLcDcJV42YEeAhH2t22AW-wlAxjRPO0SYfU	@ignored_user:localhost	\N		19	35	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$Z5cKxfveccJ3nnCMqKA-jwkRw9hbVrCMv6R68J8oPVg	@matterbot:localhost	\N		16	36	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$Z5cKxfveccJ3nnCMqKA-jwkRw9hbVrCMv6R68J8oPVg	@admin:localhost	\N		16	36	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$Z5cKxfveccJ3nnCMqKA-jwkRw9hbVrCMv6R68J8oPVg	@matrix_b:localhost	\N		16	36	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$Z5cKxfveccJ3nnCMqKA-jwkRw9hbVrCMv6R68J8oPVg	@matrix_a:localhost	\N		16	36	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$Z5cKxfveccJ3nnCMqKA-jwkRw9hbVrCMv6R68J8oPVg	@ignored_user:localhost	\N		16	36	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$G1fvwCN2g1XjFzNmxLnkU_pe19oYNSqJMKqzj8kfXCk	@matterbot:localhost	\N		17	37	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$G1fvwCN2g1XjFzNmxLnkU_pe19oYNSqJMKqzj8kfXCk	@admin:localhost	\N		17	37	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$G1fvwCN2g1XjFzNmxLnkU_pe19oYNSqJMKqzj8kfXCk	@matrix_b:localhost	\N		17	37	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$G1fvwCN2g1XjFzNmxLnkU_pe19oYNSqJMKqzj8kfXCk	@matrix_a:localhost	\N		17	37	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$G1fvwCN2g1XjFzNmxLnkU_pe19oYNSqJMKqzj8kfXCk	@ignored_user:localhost	\N		17	37	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$Jt6sBZkF1u2z9OovN4zzqiZfS0rQPS2vVpynSjt9ypI	@matterbot:localhost	\N		20	38	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$Jt6sBZkF1u2z9OovN4zzqiZfS0rQPS2vVpynSjt9ypI	@admin:localhost	\N		20	38	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$Jt6sBZkF1u2z9OovN4zzqiZfS0rQPS2vVpynSjt9ypI	@matrix_b:localhost	\N		20	38	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$Jt6sBZkF1u2z9OovN4zzqiZfS0rQPS2vVpynSjt9ypI	@ignored_user:localhost	\N		20	38	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$xRdCRWLb62a-YRgcfBkJSxc7lUVFkdZnQfSIvcKWw88	@matterbot:localhost	\N		18	39	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$xRdCRWLb62a-YRgcfBkJSxc7lUVFkdZnQfSIvcKWw88	@admin:localhost	\N		18	39	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$xRdCRWLb62a-YRgcfBkJSxc7lUVFkdZnQfSIvcKWw88	@matrix_b:localhost	\N		18	39	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$xRdCRWLb62a-YRgcfBkJSxc7lUVFkdZnQfSIvcKWw88	@ignored_user:localhost	\N		18	39	1	0	1
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
X	0
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
$mGK5pQEzegKFhAPXc0TX7drNl2qyJL8ajxnJRmA3kN8	sha256	\\x9862b9a501337a02858403d77344d7eddacd976ab224bf1a8f19c946603790df
$666ybhBdzZc96KCxYMslNrmlLRi8w6uUusi8J4BUVNM	sha256	\\xebaeb26e105dcd973de8a0b160cb2536b9a52d18bcc3ab94bac8bc27805454d3
$wEzXoaJoNtWHISsmLEY6T-CdgUw21BFOyAw1HcKBBh0	sha256	\\xc04cd7a1a26836d587212b262c463a4fe09d814c36d4114ec80c351dc281061d
$2KF1FxA50OygX8tA7bnhmld7ePb4eIDsQaPB5ssgUSc	sha256	\\xd8a175171039d0eca05fcb40edb9e19a577b78f6f87880ec41a3c1e6cb205127
$g-ojtwk6OBH0sIWVdUrIlKfcesmKRj0kfU5E9ZjKlug	sha256	\\x83ea23b7093a3811f4b08595754ac894a7dc7ac98a463d247d4e44f598ca96e8
$5zlbkFcwjX3ScF4jwQP_koQvnG_-hWrIYwwn4RhXMGs	sha256	\\xe7395b9057308d7dd2705e23c103ff92842f9c6ffe856ac8630c27e11857306b
$PSZPiF2_GHeawUZsuFzgg_JuCtoOyaf_11-uLulGF0c	sha256	\\x3d264f885dbf18779ac1466cb85ce083f26e0ada0ec9a7ffd75fae2ee9461747
$t5n7gGV4l0pVzkJq8YJdQm4IFq3hTrEHABs9QiejsEA	sha256	\\xb799fb806578974a55ce426af1825d426e0816ade14eb107001b3d4227a3b040
$CPrx1EOiKU0xFQBY1-CbMIp4Nx64vw33awql9URc-is	sha256	\\x08faf1d443a2294d31150058d7e09b308a78371eb8bf0df76b0aa5f5445cfa2b
$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk	sha256	\\x1623e1efa0613f9b53d47a2bb3df7b309803beb7a14f4daebdf9aab18db98a59
$cVpm7JtI2FA6jT91bWn5avhRlFg_CpMA5HRanoYhkJs	sha256	\\x715a66ec9b48d8503a8d3f756d69f96af85194583f0a9300e4745a9e8621909b
$jD0GZ5JDGHZiN5kp0llsZ-TSj7JcaRn8CDsEQiyeJ3w	sha256	\\x8c3d06679243187662379929d2596c67e4d28fb25c6919fc083b04422c9e277c
$1-1XawRJVm29pQHrbkTGcQ-bYWMPoyyXEnV9D0NRRF8	sha256	\\xd7ed576b0449566dbda501eb6e44c6710f9b61630fa32c9712757d0f4351445f
$hr9BoL0M0CcPevs38ww5_bA24p8HFiP4e9dlGuPrGWs	sha256	\\x86bf41a0bd0cd0270f7afb37f30c39fdb036e29f071623f87bd7651ae3eb196b
$QM2BSnrrZmMuXPjs3AMnJ7zVsHHdXmGmCFPjoGqBlaQ	sha256	\\x40cd814a7aeb66632e5cf8ecdc032727bcd5b071dd5e61a60853e3a06a8195a4
$_OchgUntbLcDcJV42YEeAhH2t22AW-wlAxjRPO0SYfU	sha256	\\xfce7218149ed6cb703709578d9811e0211f6b76d805bec250318d13ced1261f5
$Z5cKxfveccJ3nnCMqKA-jwkRw9hbVrCMv6R68J8oPVg	sha256	\\x67970ac5fbde71c2779e708ca8a03e8f0911c3d85b56b08cbfa47af09f283d58
$G1fvwCN2g1XjFzNmxLnkU_pe19oYNSqJMKqzj8kfXCk	sha256	\\x1b57efc023768355e3173366c4b9e453fa5ed7da18352a8930aab38fc91f5c29
$Jt6sBZkF1u2z9OovN4zzqiZfS0rQPS2vVpynSjt9ypI	sha256	\\x26deac059905d6edb3f4ea2f378cf3aa265f4b4ad03d2daf569ca74a3b7dca92
$xRdCRWLb62a-YRgcfBkJSxc7lUVFkdZnQfSIvcKWw88	sha256	\\xc517424562dbeb66be61181c7c19094b173b95454591d66741f488bdc296c3cf
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
$cVpm7JtI2FA6jT91bWn5avhRlFg_CpMA5HRanoYhkJs	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'test':1	1672856706015	30
$jD0GZ5JDGHZiN5kp0llsZ-TSj7JcaRn8CDsEQiyeJ3w	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'test2':1	1672856706271	31
$1-1XawRJVm29pQHrbkTGcQ-bYWMPoyyXEnV9D0NRRF8	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'bold':2 'header':1	1672856706565	32
$hr9BoL0M0CcPevs38ww5_bA24p8HFiP4e9dlGuPrGWs	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'messag':3 'random':1 'wrong':2	1672856706805	33
$QM2BSnrrZmMuXPjs3AMnJ7zVsHHdXmGmCFPjoGqBlaQ	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'hi':1	1672856707072	34
$_OchgUntbLcDcJV42YEeAhH2t22AW-wlAxjRPO0SYfU	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'test':1	1672856707296	35
$Z5cKxfveccJ3nnCMqKA-jwkRw9hbVrCMv6R68J8oPVg	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'filenam':1	1672856707574	36
$G1fvwCN2g1XjFzNmxLnkU_pe19oYNSqJMKqzj8kfXCk	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'filenam':1	1672856707732	37
$Jt6sBZkF1u2z9OovN4zzqiZfS0rQPS2vVpynSjt9ypI	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'mydata':1	1672856707997	38
$xRdCRWLb62a-YRgcfBkJSxc7lUVFkdZnQfSIvcKWw88	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'hidden':1 'messag':2	1672856708238	39
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
$mGK5pQEzegKFhAPXc0TX7drNl2qyJL8ajxnJRmA3kN8	21
$666ybhBdzZc96KCxYMslNrmlLRi8w6uUusi8J4BUVNM	22
$wEzXoaJoNtWHISsmLEY6T-CdgUw21BFOyAw1HcKBBh0	23
$2KF1FxA50OygX8tA7bnhmld7ePb4eIDsQaPB5ssgUSc	24
$g-ojtwk6OBH0sIWVdUrIlKfcesmKRj0kfU5E9ZjKlug	25
$5zlbkFcwjX3ScF4jwQP_koQvnG_-hWrIYwwn4RhXMGs	26
$PSZPiF2_GHeawUZsuFzgg_JuCtoOyaf_11-uLulGF0c	27
$t5n7gGV4l0pVzkJq8YJdQm4IFq3hTrEHABs9QiejsEA	28
$CPrx1EOiKU0xFQBY1-CbMIp4Nx64vw33awql9URc-is	29
$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk	30
$cVpm7JtI2FA6jT91bWn5avhRlFg_CpMA5HRanoYhkJs	30
$jD0GZ5JDGHZiN5kp0llsZ-TSj7JcaRn8CDsEQiyeJ3w	30
$1-1XawRJVm29pQHrbkTGcQ-bYWMPoyyXEnV9D0NRRF8	30
$hr9BoL0M0CcPevs38ww5_bA24p8HFiP4e9dlGuPrGWs	30
$QM2BSnrrZmMuXPjs3AMnJ7zVsHHdXmGmCFPjoGqBlaQ	29
$_OchgUntbLcDcJV42YEeAhH2t22AW-wlAxjRPO0SYfU	30
$Z5cKxfveccJ3nnCMqKA-jwkRw9hbVrCMv6R68J8oPVg	29
$G1fvwCN2g1XjFzNmxLnkU_pe19oYNSqJMKqzj8kfXCk	29
$Jt6sBZkF1u2z9OovN4zzqiZfS0rQPS2vVpynSjt9ypI	30
$xRdCRWLb62a-YRgcfBkJSxc7lUVFkdZnQfSIvcKWw88	29
\.


--
-- Data for Name: event_txn_id; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_txn_id (event_id, room_id, user_id, token_id, txn_id, inserted_ts) FROM stdin;
$jD0GZ5JDGHZiN5kp0llsZ-TSj7JcaRn8CDsEQiyeJ3w	!kmbTYjjsDRDHGgVqUP:localhost	@matrix_a:localhost	3	m1672856706219.0	1672856706297
$hr9BoL0M0CcPevs38ww5_bA24p8HFiP4e9dlGuPrGWs	!kmbTYjjsDRDHGgVqUP:localhost	@matrix_b:localhost	4	m1672856706759.0	1672856706835
$_OchgUntbLcDcJV42YEeAhH2t22AW-wlAxjRPO0SYfU	!kmbTYjjsDRDHGgVqUP:localhost	@matrix_a:localhost	3	m1672856707257.0	1672856707320
$Jt6sBZkF1u2z9OovN4zzqiZfS0rQPS2vVpynSjt9ypI	!kmbTYjjsDRDHGgVqUP:localhost	@matrix_a:localhost	3	m1672856707957.0	1672856708020
$xRdCRWLb62a-YRgcfBkJSxc7lUVFkdZnQfSIvcKWw88	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672856708195.0	1672856708266
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
10	$mGK5pQEzegKFhAPXc0TX7drNl2qyJL8ajxnJRmA3kN8	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	10	1672856701211	1672856701311	@matterbot:localhost	f	master	21
10	$666ybhBdzZc96KCxYMslNrmlLRi8w6uUusi8J4BUVNM	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	10	1672856701213	1672856701312	@matterbot:localhost	f	master	20
11	$wEzXoaJoNtWHISsmLEY6T-CdgUw21BFOyAw1HcKBBh0	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	11	1672856704532	1672856704619	@matterbot:localhost	f	master	22
11	$2KF1FxA50OygX8tA7bnhmld7ePb4eIDsQaPB5ssgUSc	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	11	1672856704711	1672856704833	@matterbot:localhost	f	master	23
12	$g-ojtwk6OBH0sIWVdUrIlKfcesmKRj0kfU5E9ZjKlug	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	12	1672856704815	1672856704859	@matterbot:localhost	f	master	24
12	$5zlbkFcwjX3ScF4jwQP_koQvnG_-hWrIYwwn4RhXMGs	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	12	1672856704946	1672856705058	@matterbot:localhost	f	master	25
13	$PSZPiF2_GHeawUZsuFzgg_JuCtoOyaf_11-uLulGF0c	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	13	1672856705079	1672856705112	@mm_mattermost_b:localhost	f	master	26
13	$t5n7gGV4l0pVzkJq8YJdQm4IFq3hTrEHABs9QiejsEA	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	13	1672856705294	1672856705364	@mm_mattermost_b:localhost	f	master	27
14	$CPrx1EOiKU0xFQBY1-CbMIp4Nx64vw33awql9URc-is	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	14	1672856705313	1672856705395	@mm_mattermost_a:localhost	f	master	28
14	$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	14	1672856705533	1672856705596	@mm_mattermost_a:localhost	f	master	29
15	$cVpm7JtI2FA6jT91bWn5avhRlFg_CpMA5HRanoYhkJs	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	15	1672856706015	1672856706055	@mm_mattermost_a:localhost	f	master	30
16	$jD0GZ5JDGHZiN5kp0llsZ-TSj7JcaRn8CDsEQiyeJ3w	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	16	1672856706271	1672856706296	@matrix_a:localhost	f	master	31
17	$1-1XawRJVm29pQHrbkTGcQ-bYWMPoyyXEnV9D0NRRF8	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	17	1672856706565	1672856706596	@mm_mattermost_a:localhost	f	master	32
18	$hr9BoL0M0CcPevs38ww5_bA24p8HFiP4e9dlGuPrGWs	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	18	1672856706805	1672856706834	@matrix_b:localhost	f	master	33
15	$QM2BSnrrZmMuXPjs3AMnJ7zVsHHdXmGmCFPjoGqBlaQ	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	15	1672856707072	1672856707097	@mm_mattermost_a:localhost	f	master	34
19	$_OchgUntbLcDcJV42YEeAhH2t22AW-wlAxjRPO0SYfU	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	19	1672856707296	1672856707319	@matrix_a:localhost	f	master	35
16	$Z5cKxfveccJ3nnCMqKA-jwkRw9hbVrCMv6R68J8oPVg	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	16	1672856707574	1672856707608	@mm_mattermost_b:localhost	f	master	36
17	$G1fvwCN2g1XjFzNmxLnkU_pe19oYNSqJMKqzj8kfXCk	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	17	1672856707732	1672856707767	@mm_mattermost_b:localhost	t	master	37
20	$Jt6sBZkF1u2z9OovN4zzqiZfS0rQPS2vVpynSjt9ypI	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	20	1672856707997	1672856708019	@matrix_a:localhost	t	master	38
18	$xRdCRWLb62a-YRgcfBkJSxc7lUVFkdZnQfSIvcKWw88	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	18	1672856708238	1672856708264	@matrix_a:localhost	f	master	39
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
events	39	master
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
!dKcbdDATuwwphjRPQP:localhost	@matterbot:localhost	$mGK5pQEzegKFhAPXc0TX7drNl2qyJL8ajxnJRmA3kN8	join
!kmbTYjjsDRDHGgVqUP:localhost	@matterbot:localhost	$666ybhBdzZc96KCxYMslNrmlLRi8w6uUusi8J4BUVNM	join
!dKcbdDATuwwphjRPQP:localhost	@mm_mattermost_b:localhost	$PSZPiF2_GHeawUZsuFzgg_JuCtoOyaf_11-uLulGF0c	join
!kmbTYjjsDRDHGgVqUP:localhost	@mm_mattermost_b:localhost	$t5n7gGV4l0pVzkJq8YJdQm4IFq3hTrEHABs9QiejsEA	join
!dKcbdDATuwwphjRPQP:localhost	@mm_mattermost_a:localhost	$CPrx1EOiKU0xFQBY1-CbMIp4Nx64vw33awql9URc-is	join
!kmbTYjjsDRDHGgVqUP:localhost	@mm_mattermost_a:localhost	$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk	join
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
uVWXteoIJOgvlXENjBgBOUcc	text/plain	8	1672856707962	mydata	@matrix_a:localhost	\N	\N	1672856724667	f
fndsNAAjXPUHvtbKurhIoDum	application/octet-stream	11	1672856707685	filename	@mm_mattermost_b:localhost	\N	\N	1672856724667	f
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
3	@mm_mattermost_a:localhost	offline	1672856706102	1672856706102	0	\N	f	master
4	@matrix_a:localhost	offline	1672856706312	1672856706312	0	\N	f	master
5	@matrix_b:localhost	offline	1672856706849	1672856706849	0	\N	f	master
6	@mm_mattermost_b:localhost	offline	1672856707628	1672856707628	0	\N	f	master
7	@admin:localhost	offline	1672856707888	1672856744610	1672856707927	\N	t	master
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.profiles (user_id, displayname, avatar_url) FROM stdin;
admin	Admin User	\N
matrix_a	Matrix UserA	\N
matrix_b	matrix_b	\N
ignored_user	ignored_user	\N
matterbot	Mattermost Bridge	\N
mm_mattermost_a	MattermostUser A [mm]	\N
mm_mattermost_b	mattermost_b [mm]	\N
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
\.


--
-- Data for Name: receipts_linearized; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.receipts_linearized (stream_id, room_id, receipt_type, user_id, event_id, data, instance_name) FROM stdin;
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
\.


--
-- Data for Name: room_alias_servers; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_alias_servers (room_alias, server) FROM stdin;
#town-square:localhost	localhost
#off-topic:localhost	localhost
\.


--
-- Data for Name: room_aliases; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_aliases (room_alias, room_id, creator) FROM stdin;
#town-square:localhost	!kmbTYjjsDRDHGgVqUP:localhost	@admin:localhost
#off-topic:localhost	!dKcbdDATuwwphjRPQP:localhost	@admin:localhost
\.


--
-- Data for Name: room_depth; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_depth (room_id, min_depth) FROM stdin;
!kmbTYjjsDRDHGgVqUP:localhost	1
!dKcbdDATuwwphjRPQP:localhost	1
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
$mGK5pQEzegKFhAPXc0TX7drNl2qyJL8ajxnJRmA3kN8	@matterbot:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	Mattermost Bridge	\N
$666ybhBdzZc96KCxYMslNrmlLRi8w6uUusi8J4BUVNM	@matterbot:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	Mattermost Bridge	\N
$wEzXoaJoNtWHISsmLEY6T-CdgUw21BFOyAw1HcKBBh0	@mm_mattermost_b:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	invite	0	mattermost_b [mm]	\N
$2KF1FxA50OygX8tA7bnhmld7ePb4eIDsQaPB5ssgUSc	@mm_mattermost_b:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	invite	0	mattermost_b [mm]	\N
$g-ojtwk6OBH0sIWVdUrIlKfcesmKRj0kfU5E9ZjKlug	@mm_mattermost_a:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	invite	0	MattermostUser A [mm]	\N
$5zlbkFcwjX3ScF4jwQP_koQvnG_-hWrIYwwn4RhXMGs	@mm_mattermost_a:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	invite	0	MattermostUser A [mm]	\N
$PSZPiF2_GHeawUZsuFzgg_JuCtoOyaf_11-uLulGF0c	@mm_mattermost_b:localhost	@mm_mattermost_b:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	mattermost_b [mm]	\N
$t5n7gGV4l0pVzkJq8YJdQm4IFq3hTrEHABs9QiejsEA	@mm_mattermost_b:localhost	@mm_mattermost_b:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	mattermost_b [mm]	\N
$CPrx1EOiKU0xFQBY1-CbMIp4Nx64vw33awql9URc-is	@mm_mattermost_a:localhost	@mm_mattermost_a:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	MattermostUser A [mm]	\N
$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk	@mm_mattermost_a:localhost	@mm_mattermost_a:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	MattermostUser A [mm]	\N
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
!dKcbdDATuwwphjRPQP:localhost	12	7	0	0	0	7	28	0
!kmbTYjjsDRDHGgVqUP:localhost	12	7	0	0	0	7	29	0
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
$mGK5pQEzegKFhAPXc0TX7drNl2qyJL8ajxnJRmA3kN8	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	\N
$666ybhBdzZc96KCxYMslNrmlLRi8w6uUusi8J4BUVNM	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	\N
$wEzXoaJoNtWHISsmLEY6T-CdgUw21BFOyAw1HcKBBh0	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$2KF1FxA50OygX8tA7bnhmld7ePb4eIDsQaPB5ssgUSc	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$g-ojtwk6OBH0sIWVdUrIlKfcesmKRj0kfU5E9ZjKlug	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$5zlbkFcwjX3ScF4jwQP_koQvnG_-hWrIYwwn4RhXMGs	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$PSZPiF2_GHeawUZsuFzgg_JuCtoOyaf_11-uLulGF0c	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$t5n7gGV4l0pVzkJq8YJdQm4IFq3hTrEHABs9QiejsEA	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$CPrx1EOiKU0xFQBY1-CbMIp4Nx64vw33awql9URc-is	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
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
31	29
32	30
33	30
34	29
35	29
36	30
37	29
38	29
39	29
40	30
41	29
42	30
43	29
44	29
45	30
46	30
47	30
48	30
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
21	!dKcbdDATuwwphjRPQP:localhost	$mGK5pQEzegKFhAPXc0TX7drNl2qyJL8ajxnJRmA3kN8
22	!kmbTYjjsDRDHGgVqUP:localhost	$666ybhBdzZc96KCxYMslNrmlLRi8w6uUusi8J4BUVNM
23	!dKcbdDATuwwphjRPQP:localhost	$wEzXoaJoNtWHISsmLEY6T-CdgUw21BFOyAw1HcKBBh0
24	!kmbTYjjsDRDHGgVqUP:localhost	$2KF1FxA50OygX8tA7bnhmld7ePb4eIDsQaPB5ssgUSc
25	!dKcbdDATuwwphjRPQP:localhost	$g-ojtwk6OBH0sIWVdUrIlKfcesmKRj0kfU5E9ZjKlug
26	!kmbTYjjsDRDHGgVqUP:localhost	$5zlbkFcwjX3ScF4jwQP_koQvnG_-hWrIYwwn4RhXMGs
27	!dKcbdDATuwwphjRPQP:localhost	$PSZPiF2_GHeawUZsuFzgg_JuCtoOyaf_11-uLulGF0c
28	!kmbTYjjsDRDHGgVqUP:localhost	$t5n7gGV4l0pVzkJq8YJdQm4IFq3hTrEHABs9QiejsEA
29	!dKcbdDATuwwphjRPQP:localhost	$CPrx1EOiKU0xFQBY1-CbMIp4Nx64vw33awql9URc-is
30	!kmbTYjjsDRDHGgVqUP:localhost	$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk
31	!dKcbdDATuwwphjRPQP:localhost	$VXPRWjwSZVqgUHnl53zmYmjgkIwnaLooG5_SlkPnycM
32	!kmbTYjjsDRDHGgVqUP:localhost	$uMrnYGTMXeUdqEqR84TGX0zTwE9SEBWDCng3vO8CTek
33	!kmbTYjjsDRDHGgVqUP:localhost	$75xtbGJCOOsLWc0XUo9ZyIqmymZTnD6jJu2V95jv7Hw
34	!dKcbdDATuwwphjRPQP:localhost	$pG2WwEmLWTz4kLanqPcAT5CX9ws-TtpqN1UrD8KdZb4
35	!dKcbdDATuwwphjRPQP:localhost	$xDxlr-sUqTiWovtdFPnPHbOzFFDAy6kFZZPJV6mNCFY
36	!kmbTYjjsDRDHGgVqUP:localhost	$7Hfjk7KJ8UEozcm1dahsgdykf0J8J5aiXENWVuTXRD4
37	!dKcbdDATuwwphjRPQP:localhost	$tsbZ991ACPxlKaGqDGub2ovqrXUUi9T_rUjBklWRAg4
38	!dKcbdDATuwwphjRPQP:localhost	$-XcFCqbhZtQolqC_dTm09uNS8ydJrRTl_VXXXJAB1K8
39	!dKcbdDATuwwphjRPQP:localhost	$NRzCjFLfBQEI_SFifuyXVUeTCwk3E7JbDjQm1mcaEkA
40	!kmbTYjjsDRDHGgVqUP:localhost	$47yblOJ7MzrkpPPvAiBNsiPx8wdtB_fKUEnqvyhqD78
41	!dKcbdDATuwwphjRPQP:localhost	$cJQnd1mGgrPNrgs_8nywD8A-cooQ-mrwqpkft2RU_yY
42	!kmbTYjjsDRDHGgVqUP:localhost	$hVTsEAJkVUfSpogysssCUr5v2HmnM4uCsz-PPV6nDFA
43	!dKcbdDATuwwphjRPQP:localhost	$1_TBSNPquC5OjeHEbihsHLFYZY5-9-cArC_V8VIu4Is
44	!dKcbdDATuwwphjRPQP:localhost	$5aA8anp3lkwGI7krM4c64gzZ_jRfRuBg589JFKMYpTM
45	!kmbTYjjsDRDHGgVqUP:localhost	$Gygi1d81ES_mMbuobzjahBNaC7tbgSkiGj4gnyMz4tQ
46	!kmbTYjjsDRDHGgVqUP:localhost	$mKf03aHjmkOTKjUfoCuRrEne10WarLTn7bc_9CtGBUE
47	!kmbTYjjsDRDHGgVqUP:localhost	$61LtN-tB98fviQlqNuiDoWtFh9B3Hfzto_C31td4_R4
48	!kmbTYjjsDRDHGgVqUP:localhost	$s4_VwTURD0AnN0wSTgfTmWAMQ1ZHExnW-XHQlgDXqgw
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
21	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$mGK5pQEzegKFhAPXc0TX7drNl2qyJL8ajxnJRmA3kN8
22	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$666ybhBdzZc96KCxYMslNrmlLRi8w6uUusi8J4BUVNM
23	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$wEzXoaJoNtWHISsmLEY6T-CdgUw21BFOyAw1HcKBBh0
24	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$2KF1FxA50OygX8tA7bnhmld7ePb4eIDsQaPB5ssgUSc
25	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$g-ojtwk6OBH0sIWVdUrIlKfcesmKRj0kfU5E9ZjKlug
26	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$5zlbkFcwjX3ScF4jwQP_koQvnG_-hWrIYwwn4RhXMGs
27	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$PSZPiF2_GHeawUZsuFzgg_JuCtoOyaf_11-uLulGF0c
28	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$t5n7gGV4l0pVzkJq8YJdQm4IFq3hTrEHABs9QiejsEA
29	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$CPrx1EOiKU0xFQBY1-CbMIp4Nx64vw33awql9URc-is
30	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk
31	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$VXPRWjwSZVqgUHnl53zmYmjgkIwnaLooG5_SlkPnycM
32	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$uMrnYGTMXeUdqEqR84TGX0zTwE9SEBWDCng3vO8CTek
33	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$75xtbGJCOOsLWc0XUo9ZyIqmymZTnD6jJu2V95jv7Hw
34	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$pG2WwEmLWTz4kLanqPcAT5CX9ws-TtpqN1UrD8KdZb4
35	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$xDxlr-sUqTiWovtdFPnPHbOzFFDAy6kFZZPJV6mNCFY
36	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$7Hfjk7KJ8UEozcm1dahsgdykf0J8J5aiXENWVuTXRD4
37	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$tsbZ991ACPxlKaGqDGub2ovqrXUUi9T_rUjBklWRAg4
38	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$-XcFCqbhZtQolqC_dTm09uNS8ydJrRTl_VXXXJAB1K8
39	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$NRzCjFLfBQEI_SFifuyXVUeTCwk3E7JbDjQm1mcaEkA
40	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$47yblOJ7MzrkpPPvAiBNsiPx8wdtB_fKUEnqvyhqD78
41	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$cJQnd1mGgrPNrgs_8nywD8A-cooQ-mrwqpkft2RU_yY
42	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$hVTsEAJkVUfSpogysssCUr5v2HmnM4uCsz-PPV6nDFA
43	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$1_TBSNPquC5OjeHEbihsHLFYZY5-9-cArC_V8VIu4Is
44	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$5aA8anp3lkwGI7krM4c64gzZ_jRfRuBg589JFKMYpTM
45	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$Gygi1d81ES_mMbuobzjahBNaC7tbgSkiGj4gnyMz4tQ
46	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$mKf03aHjmkOTKjUfoCuRrEne10WarLTn7bc_9CtGBUE
47	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$61LtN-tB98fviQlqNuiDoWtFh9B3Hfzto_C31td4_R4
48	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$s4_VwTURD0AnN0wSTgfTmWAMQ1ZHExnW-XHQlgDXqgw
\.


--
-- Data for Name: stats_incremental_position; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.stats_incremental_position (lock, stream_id) FROM stdin;
X	39
\.


--
-- Data for Name: stream_ordering_to_exterm; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.stream_ordering_to_exterm (stream_ordering, room_id, event_id) FROM stdin;
2	!kmbTYjjsDRDHGgVqUP:localhost	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU
3	!kmbTYjjsDRDHGgVqUP:localhost	$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw
4	!kmbTYjjsDRDHGgVqUP:localhost	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w
5	!kmbTYjjsDRDHGgVqUP:localhost	$X8tdoEsXAgBC6gobCepAn3rwO8CJoQU6i9NN9Rzhukg
6	!kmbTYjjsDRDHGgVqUP:localhost	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o
7	!kmbTYjjsDRDHGgVqUP:localhost	$O5iO4EII22igkDq5cMKHFB-SGIYD0KqJQXZohS2Dzc0
8	!dKcbdDATuwwphjRPQP:localhost	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88
9	!dKcbdDATuwwphjRPQP:localhost	$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA
10	!dKcbdDATuwwphjRPQP:localhost	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII
11	!dKcbdDATuwwphjRPQP:localhost	$b__a7rX3L5YpX7nAZte73DAbjtXZK48JH8VKSnGOKKw
12	!dKcbdDATuwwphjRPQP:localhost	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs
13	!dKcbdDATuwwphjRPQP:localhost	$TVnvv0nGbLydCBtMmTTz-htMsoI4hmxCr3s9AHyFGHQ
14	!kmbTYjjsDRDHGgVqUP:localhost	$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8
15	!dKcbdDATuwwphjRPQP:localhost	$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0
16	!kmbTYjjsDRDHGgVqUP:localhost	$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk
17	!dKcbdDATuwwphjRPQP:localhost	$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0
18	!kmbTYjjsDRDHGgVqUP:localhost	$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA
19	!dKcbdDATuwwphjRPQP:localhost	$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A
21	!dKcbdDATuwwphjRPQP:localhost	$mGK5pQEzegKFhAPXc0TX7drNl2qyJL8ajxnJRmA3kN8
20	!kmbTYjjsDRDHGgVqUP:localhost	$666ybhBdzZc96KCxYMslNrmlLRi8w6uUusi8J4BUVNM
22	!dKcbdDATuwwphjRPQP:localhost	$wEzXoaJoNtWHISsmLEY6T-CdgUw21BFOyAw1HcKBBh0
23	!kmbTYjjsDRDHGgVqUP:localhost	$2KF1FxA50OygX8tA7bnhmld7ePb4eIDsQaPB5ssgUSc
24	!dKcbdDATuwwphjRPQP:localhost	$g-ojtwk6OBH0sIWVdUrIlKfcesmKRj0kfU5E9ZjKlug
25	!kmbTYjjsDRDHGgVqUP:localhost	$5zlbkFcwjX3ScF4jwQP_koQvnG_-hWrIYwwn4RhXMGs
26	!dKcbdDATuwwphjRPQP:localhost	$PSZPiF2_GHeawUZsuFzgg_JuCtoOyaf_11-uLulGF0c
27	!kmbTYjjsDRDHGgVqUP:localhost	$t5n7gGV4l0pVzkJq8YJdQm4IFq3hTrEHABs9QiejsEA
28	!dKcbdDATuwwphjRPQP:localhost	$CPrx1EOiKU0xFQBY1-CbMIp4Nx64vw33awql9URc-is
29	!kmbTYjjsDRDHGgVqUP:localhost	$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk
30	!kmbTYjjsDRDHGgVqUP:localhost	$cVpm7JtI2FA6jT91bWn5avhRlFg_CpMA5HRanoYhkJs
31	!kmbTYjjsDRDHGgVqUP:localhost	$jD0GZ5JDGHZiN5kp0llsZ-TSj7JcaRn8CDsEQiyeJ3w
32	!kmbTYjjsDRDHGgVqUP:localhost	$1-1XawRJVm29pQHrbkTGcQ-bYWMPoyyXEnV9D0NRRF8
33	!kmbTYjjsDRDHGgVqUP:localhost	$hr9BoL0M0CcPevs38ww5_bA24p8HFiP4e9dlGuPrGWs
34	!dKcbdDATuwwphjRPQP:localhost	$QM2BSnrrZmMuXPjs3AMnJ7zVsHHdXmGmCFPjoGqBlaQ
35	!kmbTYjjsDRDHGgVqUP:localhost	$_OchgUntbLcDcJV42YEeAhH2t22AW-wlAxjRPO0SYfU
36	!dKcbdDATuwwphjRPQP:localhost	$Z5cKxfveccJ3nnCMqKA-jwkRw9hbVrCMv6R68J8oPVg
37	!dKcbdDATuwwphjRPQP:localhost	$G1fvwCN2g1XjFzNmxLnkU_pe19oYNSqJMKqzj8kfXCk
38	!kmbTYjjsDRDHGgVqUP:localhost	$Jt6sBZkF1u2z9OovN4zzqiZfS0rQPS2vVpynSjt9ypI
39	!dKcbdDATuwwphjRPQP:localhost	$xRdCRWLb62a-YRgcfBkJSxc7lUVFkdZnQfSIvcKWw88
\.


--
-- Data for Name: stream_positions; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.stream_positions (stream_name, instance_name, stream_id) FROM stdin;
events	master	39
presence_stream	master	7
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
xeJRRYeggRZPDjZRxsYsQwor	1598686326894	{"registered_user_id": "@admin:localhost"}	{"username": "admin", "password_hash": "$2b$12$y3lT6nJGWMTXBWF2kFRaRuUqALWaFe.dhbEEBKROoFnkoKBuDnLhK"}	/_matrix/client/r0/register	/_matrix/client/r0/register	register a new account
pljISqDsSRaWKiCZKERPVqQR	1598686327218	{"registered_user_id": "@matrix_a:localhost"}	{"username": "matrix_a", "password_hash": "$2b$12$V8cOJ670WikSre/C66CGI.a1ANkbEvkgYEUW.M23dlUnekRcPr08O"}	/_matrix/client/r0/register	/_matrix/client/r0/register	register a new account
SMvQriZwHcUMqIIOdUeQtXzc	1598686327463	{"registered_user_id": "@matrix_b:localhost"}	{"username": "matrix_b", "password_hash": "$2b$12$gnHJ1cdN/bfA2A2V61rPauepmeV2dLXr/pC70rCZy9qZoM9u2GKaq"}	/_matrix/client/r0/register	/_matrix/client/r0/register	register a new account
EGVIALjvHFLqBpLFKyGCObFZ	1598686327708	{"registered_user_id": "@ignored_user:localhost"}	{"username": "ignored_user", "password_hash": "$2b$12$cDOaADzxfGcFFspSrfJNcueOwevhD2Ex0hu6oAJcpz3S/owrOeSsW"}	/_matrix/client/r0/register	/_matrix/client/r0/register	register a new account
\.


--
-- Data for Name: ui_auth_sessions_credentials; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.ui_auth_sessions_credentials (session_id, stage_type, result) FROM stdin;
xeJRRYeggRZPDjZRxsYsQwor	m.login.dummy	true
pljISqDsSRaWKiCZKERPVqQR	m.login.dummy	true
SMvQriZwHcUMqIIOdUeQtXzc	m.login.dummy	true
EGVIALjvHFLqBpLFKyGCObFZ	m.login.dummy	true
\.


--
-- Data for Name: ui_auth_sessions_ips; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.ui_auth_sessions_ips (session_id, ip, user_agent) FROM stdin;
\.


--
-- Data for Name: user_daily_visits; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_daily_visits (user_id, device_id, "timestamp", user_agent) FROM stdin;
\.


--
-- Data for Name: user_directory; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_directory (user_id, room_id, display_name, avatar_url) FROM stdin;
@admin:localhost	\N	admin	\N
@matrix_a:localhost	\N	matrix_a	\N
@matrix_b:localhost	\N	matrix_b	\N
@ignored_user:localhost	\N	ignored_user	\N
\.


--
-- Data for Name: user_directory_search; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_directory_search (user_id, vector) FROM stdin;
@admin:localhost	'admin':1A,3B 'localhost':2
@matrix_a:localhost	'localhost':2 'matrix':1A,3B
@matrix_b:localhost	'b':2A,5B 'localhost':3 'matrix':1A,4B
@ignored_user:localhost	'ignor':1A,4B 'localhost':3 'user':2A,5B
\.


--
-- Data for Name: user_directory_stream_pos; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_directory_stream_pos (lock, stream_id) FROM stdin;
X	39
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
\.


--
-- Data for Name: user_ips; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_ips (user_id, access_token, device_id, ip, user_agent, last_seen) FROM stdin;
@admin:localhost	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjNjaWQgdXNlcl9pZCA9IEBhZG1pbjpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSBXVU9yUTVRMFRnUkNjME1ACjAwMmZzaWduYXR1cmUgdYKA-yuTQ5JV5O0HWRak-48xavOYgA1MMc6A1V_Uw5kK	WCSUBIGVWG	172.16.238.1		1672856705983
@matrix_a:localhost	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjZjaWQgdXNlcl9pZCA9IEBtYXRyaXhfYTpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSAwb3Y6eTZVdHojUk4jbFprCjAwMmZzaWduYXR1cmUgNNZKnOVRzj5svh9pEM0UUEqtXYnHjnj9XyNLJ1_uKoAK	TKAVEOGKHH	172.16.238.1		1672856706252
@matrix_b:localhost	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjZjaWQgdXNlcl9pZCA9IEBtYXRyaXhfYjpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSBBYl9hbWthI0daSzgtfjdICjAwMmZzaWduYXR1cmUgOReBLkPURCMNtzORS9fpogQqVa3IWN9ZEu5gXW91QTMK	DJFHSWMXLW	172.16.238.1		1672856706787
\.


--
-- Data for Name: user_signature_stream; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_signature_stream (stream_id, from_user_id, user_ids) FROM stdin;
\.


--
-- Data for Name: user_stats_current; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_stats_current (user_id, joined_rooms, completed_delta_stream_id) FROM stdin;
@admin:localhost	2	13
@matrix_a:localhost	2	15
@matrix_b:localhost	2	17
@ignored_user:localhost	2	19
@matterbot:localhost	2	21
@mm_mattermost_b:localhost	2	27
@mm_mattermost_a:localhost	2	29
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
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.users (name, password_hash, creation_ts, admin, upgrade_ts, is_guest, appservice_id, consent_version, consent_server_notice_sent, user_type, deactivated, shadow_banned) FROM stdin;
@admin:localhost	$2b$12$y3lT6nJGWMTXBWF2kFRaRuUqALWaFe.dhbEEBKROoFnkoKBuDnLhK	1598686326	0	\N	0	\N	\N	\N	\N	0	\N
@matrix_a:localhost	$2b$12$V8cOJ670WikSre/C66CGI.a1ANkbEvkgYEUW.M23dlUnekRcPr08O	1598686327	0	\N	0	\N	\N	\N	\N	0	\N
@matrix_b:localhost	$2b$12$gnHJ1cdN/bfA2A2V61rPauepmeV2dLXr/pC70rCZy9qZoM9u2GKaq	1598686327	0	\N	0	\N	\N	\N	\N	0	\N
@ignored_user:localhost	$2b$12$cDOaADzxfGcFFspSrfJNcueOwevhD2Ex0hu6oAJcpz3S/owrOeSsW	1598686327	0	\N	0	\N	\N	\N	\N	0	\N
@matterbot:localhost		1672856700	0	\N	0	xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	\N	\N	\N	0	f
@mm_mattermost_b:localhost		1672856704	0	\N	0	xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	\N	\N	\N	0	f
@mm_mattermost_a:localhost		1672856704	0	\N	0	xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	\N	\N	\N	0	f
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
\.


--
-- Data for Name: worker_locks; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.worker_locks (lock_name, lock_key, instance_name, token, last_renewed_ts) FROM stdin;
\.


--
-- Name: account_data_sequence; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.account_data_sequence', 1, true);


--
-- Name: cache_invalidation_stream_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.cache_invalidation_stream_seq', 41, true);


--
-- Name: device_inbox_sequence; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.device_inbox_sequence', 1, true);


--
-- Name: event_auth_chain_id; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.event_auth_chain_id', 24, true);


--
-- Name: events_backfill_stream_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.events_backfill_stream_seq', 1, true);


--
-- Name: events_stream_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.events_stream_seq', 39, true);


--
-- Name: instance_map_instance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.instance_map_instance_id_seq', 1, false);


--
-- Name: presence_stream_sequence; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.presence_stream_sequence', 7, true);


--
-- Name: receipts_sequence; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.receipts_sequence', 1, true);


--
-- Name: state_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.state_group_id_seq', 48, true);


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

