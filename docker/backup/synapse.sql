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
6	@matterbot:localhost	XDDCJAWJAE	syt_bWF0dGVyYm90_iTyrtdJSIFKnglwYGOJd_3JqxfD	\N	\N	1672674595575	\N	f
7	@mm_mattermost_b:localhost	QRNNVDTJZK	syt_bW1fbWF0dGVybW9zdF9i_nBPxFbSWTxTxkbqmHcpU_4Oh1Mw	\N	\N	1672674602767	\N	f
10	@bridgeuser1:localhost	VHYKHOSQYR	syt_YnJpZGdldXNlcjE_ADklFLptgVyusdGbhqlO_1w5I1X	\N	\N	1672674679311	\N	f
11	@bridgeuser2:localhost	ODNLYFPRKY	syt_YnJpZGdldXNlcjI_hCabQWSJiEqNcFSarYUK_0bI0qW	\N	\N	1672674708470	\N	f
13	@mm_bridgeuser2:localhost	KIVDOYXNGO	syt_bW1fYnJpZGdldXNlcjI_rZNmBkbqsGZqOJStsRzT_19ycoX	\N	\N	1672675304136	\N	f
9	@bridgeadmin:localhost	JRVSUYQVAD	syt_YnJpZGdlYWRtaW4_JoxiEWljSnpIybaKgheJ_3grklR	\N	\N	1672674658431	\N	t
14	@mm_mattermost_a:localhost	WVINFYXSBT	syt_bW1fbWF0dGVybW9zdF9h_HygTckNEzuhbEEcsHKnc_4aaOjA	\N	\N	1672682527162	\N	t
\.


--
-- Data for Name: account_data; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.account_data (user_id, account_data_type, stream_id, content, instance_name) FROM stdin;
@matrix_a:localhost	org.matrix.msc3890.local_notification_settings.DOIVEAHHYD	3	{"is_silenced":false}	\N
@matrix_a:localhost	im.vector.analytics	12	{"pseudonymousAnalyticsOptIn":false}	\N
@admin:localhost	org.matrix.msc3890.local_notification_settings.LDJENJGFPQ	18	{"is_silenced":false}	\N
@admin:localhost	im.vector.analytics	19	{"pseudonymousAnalyticsOptIn":false}	\N
@matrix_a:localhost	org.matrix.msc3890.local_notification_settings.CMZPUTUYMO	29	{"is_silenced":false}	\N
@mm_bridgeuser1:localhost	org.matrix.msc3890.local_notification_settings.TKJYESZBTR	38	{"is_silenced":false}	\N
@mm_bridgeuser1:localhost	im.vector.analytics	44	{"pseudonymousAnalyticsOptIn":false}	\N
@mm_bridgeuser1:localhost	im.vector.setting.breadcrumbs	46	{"recent_rooms":["!dKcbdDATuwwphjRPQP:localhost","!kmbTYjjsDRDHGgVqUP:localhost"]}	\N
@matrix_a:localhost	org.matrix.msc3890.local_notification_settings.QAMBZSULSZ	51	{"is_silenced":false}	\N
@matrix_a:localhost	org.matrix.msc3890.local_notification_settings.JEDZORXLOY	59	{"is_silenced":false}	\N
@matrix_a:localhost	im.vector.setting.breadcrumbs	66	{"recent_rooms":["!kmbTYjjsDRDHGgVqUP:localhost","!dKcbdDATuwwphjRPQP:localhost"]}	\N
@bridgeadmin:localhost	org.matrix.msc3890.local_notification_settings.UMGHKMXVHU	72	{"is_silenced":false}	\N
@bridgeadmin:localhost	im.vector.analytics	73	{"pseudonymousAnalyticsOptIn":false}	\N
@admin:localhost	org.matrix.msc3890.local_notification_settings.VXDDHODNPG	74	{"is_silenced":false}	\N
@admin:localhost	im.vector.setting.breadcrumbs	81	{"recent_rooms":["!kmbTYjjsDRDHGgVqUP:localhost","!dKcbdDATuwwphjRPQP:localhost"]}	\N
@admin:localhost	io.element.recent_emoji	83	{"recent_emoji":[["\\ud83d\\udc4d\\ufe0f",3],["\\ud83d\\ude0c",2],["\\ud83d\\ude04",1],["\\ud83d\\ude43",1]]}	\N
@mm_mattermost_a:localhost	org.matrix.msc3890.local_notification_settings.WVINFYXSBT	84	{"is_silenced":false}	\N
@mm_mattermost_a:localhost	im.vector.setting.breadcrumbs	88	{"recent_rooms":["!kmbTYjjsDRDHGgVqUP:localhost","!dKcbdDATuwwphjRPQP:localhost"]}	\N
@mm_mattermost_a:localhost	io.element.recent_emoji	91	{"recent_emoji":[["\\ud83d\\udc4e\\ufe0f",1],["\\ud83e\\udee5",1],["\\ud83d\\ude36\\u200d\\ud83c\\udf2b\\ufe0f",1],["\\ud83d\\udc4d\\ufe0f",3],["\\ud83d\\ude0c",2],["\\ud83d\\ude04",1],["\\ud83d\\ude43",1]]}	\N
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
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	1	["$Z2BDuqYr2x_4RtA8EmelcT41xj-7klcpKFvY5-POfVw"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	2	["$uuCt7OoWWYBzi7T3Jte6ntGxol6g760NhRDnyPvGMLA"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	3	["$IUtrl9K7UzIz2Mh8WwC4IwE46CubMgrjKFmHcXBu2Cg"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	4	["$_ZI5M7wMM-QBKHgJHCRJC5LeBkOqglv0DLH3BAuL_mw"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	5	["$0qBcJsMAQpJ663R0qWtkO3DyspiocKFy-urTZsaZ3pw"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	6	["$lV2FDnpp7NRIRR5BdRLjhMfQU639aIzIumB6iT8p1ao"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	7	["$AhmCkSaIYchTfHKz-ScAJNw5JBnITPWbCCQxUwRuIjo"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	8	["$th-c5RZ-B0CMnKv9LtzPkBy_JfUuYDy4zUtX-8O9Rzg"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	9	["$DjME4nek1Vnfgp8JIvyexbgZFnJ7UrCzBWYcgi5DRQE"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	10	["$wttc0xGxavZKEFW4jhvY1iHmKn5fBDpTA47wmyrYJ6k"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	11	["$moj2kqPjW9Xd0RBTBX4Ee8HVebtt8aY6J7P3i6UT7qw"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	12	["$DrKoz6WomICqVeub6PxHnTnu5NbhLDAg2J9rHOxBMmA"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	13	["$hUQcgu2HJB2PDqWBrqIQkblhG-WvxXaIzHEnXw-Ej30"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	14	["$fkjIqV9H5dj_boKqogOxPeFW_m8yxwpxTgr4lSwePDY"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	15	["$FUJQN-_4fHqBV5emsypqKHRRS0j5jbpMmuarjoIptOg"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	16	["$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	17	["$fG61faFdiQLdggY7LGhSk_5yDw-HxLQiWURS7cCmAAc"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	18	["$ze3RfSNk1D8sruIVbtfFmFdyoNnUgcEoFtM7ULxeWMs"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	19	["$ifo4xdQDNVXvmkvgnrcj5o9iKblytzWMd_pEcRtWvx8"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	20	["$BeKLUYL7qRfgvRH3qg2u6Z41GK2CNQqGwtAmWHwBWjA"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	21	["$DOD9xnyV6gfI9j6KBsEdTpRu2l62hsRVmc9i6QLcseo"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	22	["$KG18kyO7FM4HavQZH_xZmXGUw1RbyfWhbs-Ds3u5vB8"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	23	["$FVhXs60ZUT4hfp8SPDQiJ9sUL5CV4MjGIsUfequDwEE"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	24	["$MSYX67PL-aQgpnMS30mo0OLCFY11arvS2Ehe0I0SNAg"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	25	["$NDRnMTvwTgCFfTb_vFmNwNe1o4a-UnPMEHKYvBFg1Ms"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	26	["$sT18sK2FK6Bo7161sdufjmhywK9CsJHemT-D6fDbaWs"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	27	["$d05l2i-Vc2Zzx3bl0Vz-NnDVVhxgFQIctiPfGoz0Xjs"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	28	["$jsgSLDcqxEQROuyA6P2myIoJf5N1kGLS_n8iWXwE-nU"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	29	["$vg3binnx1kEog3C9nqvwJ7qPu28sTqYrZDssk0vab-Q"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	30	["$YMb8Q2a5Xbnn70ZtQxPIimfv3Y9zSC67zsDIdEsRFJw"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	31	["$d8OJKkkhp47jknk_LHO0c3d0-CSNWMzpJBRw6bOrQ4M"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	32	["$obESo5AynBeb9xLH4sESBL5g-segSsJGjC9XER9ZTt8"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	33	["$CcTsy5iCDZyphUv5irDLp85iBq-btwDvTJahbK5ATzo"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	34	["$0F5VtbBOxf2d2OwQ46I3LM3tqAkj2YWFXSKWzfzdtT8"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	35	["$LkEO2DXJWjTGSlo7iokDO6KvigtD7BtSYgzN1bHF2q0"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	36	["$RBYjw0bWPMbVEg8csvMs4tPORoqreh7W0cTgJTDKhxQ"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	37	["$3J0wiu01NbTrOfOGZgRjSdNtX0P7ZN-PQp8qKcLDlmY"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	38	["$qpoohVqO3c0vYCNBJuvRZHkBBNPQSrgwVwzIcbCfJJk"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	39	["$FLa6I56u6EmzKm7SjplLhqPxGUZeJy_gEayv25svMwc"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	40	["$uVCWC5TSVmmOhtnjhBprXQIqqNMmjlwAjnAbCFWCmSM"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	41	["$ze3rHWp4q76u5HD9VeEM4tmvDPVyEGXfJ16m3GKAPBA"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	42	["$wQdEIjcFyopFZpNGXmYD7mGBK2vx6nRTZFbp0tUAS5s"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	43	["$vCLF-PjgFkWDlv9RC2q7AbemDp5Aq_wTHx26K7fVT2k"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	44	["$CtsCO4y6Ci5lqltxoUXJqrNNDD4LeUErcBMp_5KFwdU"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	45	["$8AX5D9nuhWswBU_Fc227Rvda1dcYTL38k5-nu5LYeow"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	46	["$C_yOhTrkIxQT1pPwVX1TWe0UBFqH59o0aetXDnxNbb4"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	47	["$7tsqPssEA6U65Qrd44F9FbFLND-JhznQ_c-4bXrIlRE"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	48	["$D4biAJRc__54ONgjSEAYBzE8_j1ePGCqni93Os3tKhM"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	49	["$GPeeyjoIFFM1Mp_pvKB55ZyVVmuSxQ3czNsjj5VxcZs"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	50	["$qIPcuD0d9eSflKKATXSbTJjoKFIBzNFk28nuN3007zo"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	51	["$ge07snxHDhIl87w9HhFEY0Vf4fZF7sfC8ZgYVajdyBQ"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	52	["$8u1nGQdQsFC_o-G3u1FrKnqITkatzs7OCMMVEir7wnk"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	54	["$iKj1OUBZW17_u23PJes2dsEtLEQhEZBWblS4q6rzsjU"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	53	["$-F2yj6IuC13Z2Eri3_-fsH3NLCQXQ1igRElx9-Op2x4"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	55	["$_aHR2VH_SqifxgVILz9ZPES5I390wFZQHGdjrgNSekM"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	56	["$v72gLcqi6Rs213KYj3Q9EwPHikqyQNxPsM2PYcEx_yI"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	57	["$IF1JZZiHama5s_UHEDM0Lrd52rDP-14jwiiT7xvm8gk"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	58	["$nlOfoVdX08P1v2RQ_i1jakYQkuf0y1MGWr21M4pjQJU"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	59	["$AUKXpVUFnYNqEkGgCvdFpbjbYc6RVwJa6Lu4v1LGoBs"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	60	["$1mBKLzxWBgLuS89oa3fbkVxTj_bUJ5krnjvFIGrcU2k"]
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	61	["$7mzkMAeImEcLYZGgGfqB1GHgCADF4xGJ7B-eojgjum4"]
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
X	80
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
27	master	user_last_seen_monthly_active	\N	1672674460513
28	master	get_monthly_active_count	{}	1672674460538
29	master	get_user_by_id	{@matterbot:localhost}	1672674595533
30	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@matterbot:localhost}	1672674596266
31	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@matterbot:localhost}	1672674596312
32	master	get_user_by_id	{@mm_mattermost_b:localhost}	1672674602693
33	master	get_user_by_id	{@mm_mattermost_a:localhost}	1672674602908
34	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_b:localhost}	1672674603201
35	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_b:localhost}	1672674603374
36	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_a:localhost}	1672674603469
37	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_a:localhost}	1672674603607
38	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_b:localhost}	1672674603698
39	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_b:localhost}	1672674603859
40	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_a:localhost}	1672674603955
41	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_a:localhost}	1672674604059
42	master	get_user_by_id	{@bridgeadmin:localhost}	1672674658396
43	master	get_user_by_id	{@bridgeuser1:localhost}	1672674679280
44	master	get_user_by_id	{@bridgeuser2:localhost}	1672674708439
45	master	get_user_by_id	{@mm_bridgeuser1:localhost}	1672675303268
46	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_bridgeuser1:localhost}	1672675303647
47	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_bridgeuser1:localhost}	1672675303782
48	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_bridgeuser1:localhost}	1672675303923
49	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_bridgeuser1:localhost}	1672675304052
50	master	get_user_by_id	{@mm_bridgeuser2:localhost}	1672675304115
51	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_bridgeuser2:localhost}	1672675304292
52	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_bridgeuser2:localhost}	1672675304418
53	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_bridgeuser2:localhost}	1672675304557
54	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_bridgeuser2:localhost}	1672675304675
55	master	get_user_by_id	{@admin:localhost}	1672676257461
56	master	get_user_by_id	{@admin:localhost}	1672676258554
57	master	get_user_by_access_token	{MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjNjaWQgdXNlcl9pZCA9IEBhZG1pbjpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSBXVU9yUTVRMFRnUkNjME1ACjAwMmZzaWduYXR1cmUgdYKA-yuTQ5JV5O0HWRak-48xavOYgA1MMc6A1V_Uw5kK}	1672676258585
58	master	count_e2e_one_time_keys	{@admin:localhost,WCSUBIGVWG}	1672676258630
59	master	get_e2e_unused_fallback_key_types	{@admin:localhost,WCSUBIGVWG}	1672676258645
60	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_bridgeuser1:localhost}	1672676284339
72	master	count_e2e_one_time_keys	{@matrix_a:localhost,DOIVEAHHYD}	1672676402948
74	master	count_e2e_one_time_keys	{@matrix_a:localhost,DOIVEAHHYD}	1672676403047
98	master	_get_bare_e2e_cross_signing_keys	{@admin:localhost}	1672676579564
99	master	_get_bare_e2e_cross_signing_keys	{@admin:localhost}	1672676579569
61	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_bridgeuser1:localhost}	1672676284715
62	master	get_user_by_id	{@mm_bridgeuser1:localhost}	1672676285557
77	master	count_e2e_one_time_keys	{@matrix_a:localhost,DOIVEAHHYD}	1672676403362
78	master	_get_bare_e2e_cross_signing_keys	{@matrix_a:localhost}	1672676403459
80	master	_get_bare_e2e_cross_signing_keys	{@matrix_a:localhost}	1672676403469
83	master	count_e2e_one_time_keys	{@matrix_a:localhost,DOIVEAHHYD}	1672676403747
84	master	count_e2e_one_time_keys	{@matrix_a:localhost,DOIVEAHHYD}	1672676403891
89	master	get_e2e_unused_fallback_key_types	{@admin:localhost,LDJENJGFPQ}	1672676579021
96	master	count_e2e_one_time_keys	{@admin:localhost,LDJENJGFPQ}	1672676579523
100	master	count_e2e_one_time_keys	{@admin:localhost,LDJENJGFPQ}	1672676579613
102	master	count_e2e_one_time_keys	{@admin:localhost,LDJENJGFPQ}	1672676580249
103	master	get_user_by_access_token	{syt_YWRtaW4_kKXHzcVWHTpWkVgojjen_2QRSP0}	1672676781960
104	master	count_e2e_one_time_keys	{@admin:localhost,LDJENJGFPQ}	1672676781976
105	master	get_e2e_unused_fallback_key_types	{@admin:localhost,LDJENJGFPQ}	1672676781980
106	master	count_e2e_one_time_keys	{@matrix_a:localhost,CMZPUTUYMO}	1672676798327
107	master	get_e2e_unused_fallback_key_types	{@matrix_a:localhost,CMZPUTUYMO}	1672676798349
63	master	get_user_by_access_token	{syt_bW1fYnJpZGdldXNlcjE_lAAMDbYpkACgSJUMqotB_05nXnR}	1672676285692
64	master	count_e2e_one_time_keys	{@mm_bridgeuser1:localhost,KGOEVGJKUJ}	1672676285758
65	master	get_e2e_unused_fallback_key_types	{@mm_bridgeuser1:localhost,KGOEVGJKUJ}	1672676285773
66	master	get_user_by_id	{@matrix_a:localhost}	1672676297991
79	master	count_e2e_one_time_keys	{@matrix_a:localhost,DOIVEAHHYD}	1672676403462
81	master	_get_bare_e2e_cross_signing_keys	{@matrix_a:localhost}	1672676403481
82	master	count_e2e_one_time_keys	{@matrix_a:localhost,DOIVEAHHYD}	1672676403576
90	master	count_e2e_one_time_keys	{@admin:localhost,LDJENJGFPQ}	1672676579112
91	master	get_e2e_unused_fallback_key_types	{@admin:localhost,LDJENJGFPQ}	1672676579118
92	master	count_e2e_one_time_keys	{@admin:localhost,LDJENJGFPQ}	1672676579189
93	master	count_e2e_one_time_keys	{@admin:localhost,LDJENJGFPQ}	1672676579262
94	master	count_e2e_one_time_keys	{@admin:localhost,LDJENJGFPQ}	1672676579347
95	master	count_e2e_one_time_keys	{@admin:localhost,LDJENJGFPQ}	1672676579430
101	master	count_e2e_one_time_keys	{@admin:localhost,LDJENJGFPQ}	1672676579761
108	master	count_e2e_one_time_keys	{@matrix_a:localhost,CMZPUTUYMO}	1672676798439
109	master	get_e2e_unused_fallback_key_types	{@matrix_a:localhost,CMZPUTUYMO}	1672676798446
110	master	count_e2e_one_time_keys	{@matrix_a:localhost,CMZPUTUYMO}	1672676798519
111	master	count_e2e_one_time_keys	{@matrix_a:localhost,CMZPUTUYMO}	1672676798585
112	master	count_e2e_one_time_keys	{@matrix_a:localhost,CMZPUTUYMO}	1672676798653
67	master	get_user_by_access_token	{MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjZjaWQgdXNlcl9pZCA9IEBtYXRyaXhfYTpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSAwb3Y6eTZVdHojUk4jbFprCjAwMmZzaWduYXR1cmUgNNZKnOVRzj5svh9pEM0UUEqtXYnHjnj9XyNLJ1_uKoAK}	1672676298047
68	master	count_e2e_one_time_keys	{@matrix_a:localhost,TKAVEOGKHH}	1672676298089
69	master	get_e2e_unused_fallback_key_types	{@matrix_a:localhost,TKAVEOGKHH}	1672676298096
70	master	count_e2e_one_time_keys	{@matrix_a:localhost,DOIVEAHHYD}	1672676402741
71	master	get_e2e_unused_fallback_key_types	{@matrix_a:localhost,DOIVEAHHYD}	1672676402813
73	master	get_e2e_unused_fallback_key_types	{@matrix_a:localhost,DOIVEAHHYD}	1672676402959
75	master	count_e2e_one_time_keys	{@matrix_a:localhost,DOIVEAHHYD}	1672676403142
76	master	count_e2e_one_time_keys	{@matrix_a:localhost,DOIVEAHHYD}	1672676403263
85	master	get_user_by_access_token	{syt_bWF0cml4X2E_uuRAHFFhyRiVYFtlxPOQ_3HbVe4}	1672676567021
86	master	count_e2e_one_time_keys	{@matrix_a:localhost,DOIVEAHHYD}	1672676567042
87	master	get_e2e_unused_fallback_key_types	{@matrix_a:localhost,DOIVEAHHYD}	1672676567049
88	master	count_e2e_one_time_keys	{@admin:localhost,LDJENJGFPQ}	1672676578984
97	master	_get_bare_e2e_cross_signing_keys	{@admin:localhost}	1672676579548
113	master	count_e2e_one_time_keys	{@matrix_a:localhost,CMZPUTUYMO}	1672676798716
114	master	count_e2e_one_time_keys	{@matrix_a:localhost,CMZPUTUYMO}	1672676798805
115	master	count_e2e_one_time_keys	{@matrix_a:localhost,CMZPUTUYMO}	1672676798887
116	master	count_e2e_one_time_keys	{@matrix_a:localhost,CMZPUTUYMO}	1672676798951
117	master	count_e2e_one_time_keys	{@matrix_a:localhost,CMZPUTUYMO}	1672676799020
118	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_bridgeuser1:localhost}	1672677122555
119	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_bridgeuser1:localhost}	1672677122745
120	master	user_last_seen_monthly_active	\N	1672678060408
121	master	get_monthly_active_count	{}	1672678060411
122	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_bridgeuser1:localhost}	1672678123772
123	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_bridgeuser1:localhost}	1672678124164
124	master	get_user_by_id	{@mm_bridgeuser1:localhost}	1672678124609
125	master	get_user_by_access_token	{syt_bWF0cml4X2E_ftlYIoYtsjTFLAnIApLj_3Ywr1n}	1672678144632
126	master	count_e2e_one_time_keys	{@matrix_a:localhost,CMZPUTUYMO}	1672678144650
127	master	get_e2e_unused_fallback_key_types	{@matrix_a:localhost,CMZPUTUYMO}	1672678144653
128	master	count_e2e_one_time_keys	{@mm_bridgeuser1:localhost,TKJYESZBTR}	1672678197815
129	master	get_e2e_unused_fallback_key_types	{@mm_bridgeuser1:localhost,TKJYESZBTR}	1672678197836
130	master	count_e2e_one_time_keys	{@mm_bridgeuser1:localhost,TKJYESZBTR}	1672678197960
131	master	get_e2e_unused_fallback_key_types	{@mm_bridgeuser1:localhost,TKJYESZBTR}	1672678197967
132	master	count_e2e_one_time_keys	{@mm_bridgeuser1:localhost,TKJYESZBTR}	1672678198052
133	master	count_e2e_one_time_keys	{@mm_bridgeuser1:localhost,TKJYESZBTR}	1672678198134
134	master	count_e2e_one_time_keys	{@mm_bridgeuser1:localhost,TKJYESZBTR}	1672678198207
135	master	_get_bare_e2e_cross_signing_keys	{@mm_bridgeuser1:localhost}	1672678198249
136	master	_get_bare_e2e_cross_signing_keys	{@mm_bridgeuser1:localhost}	1672678198260
137	master	_get_bare_e2e_cross_signing_keys	{@mm_bridgeuser1:localhost}	1672678198271
138	master	count_e2e_one_time_keys	{@mm_bridgeuser1:localhost,TKJYESZBTR}	1672678198314
139	master	count_e2e_one_time_keys	{@mm_bridgeuser1:localhost,TKJYESZBTR}	1672678198451
140	master	count_e2e_one_time_keys	{@mm_bridgeuser1:localhost,TKJYESZBTR}	1672678198558
141	master	count_e2e_one_time_keys	{@mm_bridgeuser1:localhost,TKJYESZBTR}	1672678198665
142	master	count_e2e_one_time_keys	{@mm_bridgeuser1:localhost,TKJYESZBTR}	1672678198741
143	master	get_user_by_access_token	{syt_bW1fYnJpZGdldXNlcjE_ZPvUjdGMdxjbetYlnVEp_48DPeD}	1672678346171
144	master	count_e2e_one_time_keys	{@mm_bridgeuser1:localhost,TKJYESZBTR}	1672678346188
145	master	get_e2e_unused_fallback_key_types	{@mm_bridgeuser1:localhost,TKJYESZBTR}	1672678346193
146	master	count_e2e_one_time_keys	{@matrix_a:localhost,QAMBZSULSZ}	1672678361274
147	master	get_e2e_unused_fallback_key_types	{@matrix_a:localhost,QAMBZSULSZ}	1672678361283
148	master	count_e2e_one_time_keys	{@matrix_a:localhost,QAMBZSULSZ}	1672678361363
149	master	count_e2e_one_time_keys	{@matrix_a:localhost,QAMBZSULSZ}	1672678361424
150	master	count_e2e_one_time_keys	{@matrix_a:localhost,QAMBZSULSZ}	1672678361495
151	master	count_e2e_one_time_keys	{@matrix_a:localhost,QAMBZSULSZ}	1672678361560
152	master	count_e2e_one_time_keys	{@matrix_a:localhost,QAMBZSULSZ}	1672678361625
153	master	count_e2e_one_time_keys	{@matrix_a:localhost,QAMBZSULSZ}	1672678361691
154	master	count_e2e_one_time_keys	{@matrix_a:localhost,QAMBZSULSZ}	1672678361763
155	master	count_e2e_one_time_keys	{@matrix_a:localhost,QAMBZSULSZ}	1672678361822
156	master	count_e2e_one_time_keys	{@matrix_a:localhost,QAMBZSULSZ}	1672678361892
157	master	get_user_by_id	{@mm_bridgeuser1:localhost}	1672678472458
158	master	get_user_by_id	{@matrix_a:localhost}	1672678489331
159	master	get_user_by_access_token	{syt_bWF0cml4X2E_FAZDqbqYROOTUHDzMSNf_0D9Qs8}	1672678489357
160	master	count_e2e_one_time_keys	{@matrix_a:localhost,QAMBZSULSZ}	1672678489372
161	master	get_e2e_unused_fallback_key_types	{@matrix_a:localhost,QAMBZSULSZ}	1672678489375
162	master	user_last_seen_monthly_active	\N	1672681156610
163	master	get_monthly_active_count	{}	1672681156614
164	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_bridgeuser1:localhost}	1672681243773
165	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_bridgeuser1:localhost}	1672681243942
166	master	count_e2e_one_time_keys	{@matrix_a:localhost,JEDZORXLOY}	1672681301054
167	master	get_e2e_unused_fallback_key_types	{@matrix_a:localhost,JEDZORXLOY}	1672681301107
168	master	count_e2e_one_time_keys	{@matrix_a:localhost,JEDZORXLOY}	1672681301216
169	master	get_e2e_unused_fallback_key_types	{@matrix_a:localhost,JEDZORXLOY}	1672681301223
170	master	count_e2e_one_time_keys	{@matrix_a:localhost,JEDZORXLOY}	1672681301292
171	master	count_e2e_one_time_keys	{@matrix_a:localhost,JEDZORXLOY}	1672681301357
172	master	count_e2e_one_time_keys	{@matrix_a:localhost,JEDZORXLOY}	1672681301424
173	master	count_e2e_one_time_keys	{@matrix_a:localhost,JEDZORXLOY}	1672681301493
174	master	count_e2e_one_time_keys	{@matrix_a:localhost,JEDZORXLOY}	1672681301589
175	master	count_e2e_one_time_keys	{@matrix_a:localhost,JEDZORXLOY}	1672681301676
177	master	count_e2e_one_time_keys	{@matrix_a:localhost,JEDZORXLOY}	1672681301859
188	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,UMGHKMXVHU}	1672681537821
189	master	_get_bare_e2e_cross_signing_keys	{@bridgeadmin:localhost}	1672681537878
195	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,UMGHKMXVHU}	1672681538331
203	master	count_e2e_one_time_keys	{@admin:localhost,VXDDHODNPG}	1672681647251
176	master	count_e2e_one_time_keys	{@matrix_a:localhost,JEDZORXLOY}	1672681301768
178	master	get_user_by_access_token	{syt_bWF0cml4X2E_cTFxDDHRKyiohLEVNSlU_40TgMx}	1672681511827
179	master	count_e2e_one_time_keys	{@matrix_a:localhost,JEDZORXLOY}	1672681511847
180	master	get_e2e_unused_fallback_key_types	{@matrix_a:localhost,JEDZORXLOY}	1672681511852
184	master	get_e2e_unused_fallback_key_types	{@bridgeadmin:localhost,UMGHKMXVHU}	1672681537499
191	master	_get_bare_e2e_cross_signing_keys	{@bridgeadmin:localhost}	1672681537921
194	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,UMGHKMXVHU}	1672681538260
200	master	get_e2e_unused_fallback_key_types	{@admin:localhost,VXDDHODNPG}	1672681647063
201	master	count_e2e_one_time_keys	{@admin:localhost,VXDDHODNPG}	1672681647129
202	master	count_e2e_one_time_keys	{@admin:localhost,VXDDHODNPG}	1672681647189
205	master	count_e2e_one_time_keys	{@admin:localhost,VXDDHODNPG}	1672681647389
207	master	count_e2e_one_time_keys	{@admin:localhost,VXDDHODNPG}	1672681647540
208	master	count_e2e_one_time_keys	{@admin:localhost,VXDDHODNPG}	1672681647608
209	master	count_e2e_one_time_keys	{@admin:localhost,VXDDHODNPG}	1672681647675
211	master	count_e2e_one_time_keys	{@admin:localhost,VXDDHODNPG}	1672682058161
212	master	get_e2e_unused_fallback_key_types	{@admin:localhost,VXDDHODNPG}	1672682058163
181	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,UMGHKMXVHU}	1672681537356
187	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,UMGHKMXVHU}	1672681537732
190	master	_get_bare_e2e_cross_signing_keys	{@bridgeadmin:localhost}	1672681537895
204	master	count_e2e_one_time_keys	{@admin:localhost,VXDDHODNPG}	1672681647315
182	master	get_e2e_unused_fallback_key_types	{@bridgeadmin:localhost,UMGHKMXVHU}	1672681537384
183	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,UMGHKMXVHU}	1672681537489
185	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,UMGHKMXVHU}	1672681537581
186	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,UMGHKMXVHU}	1672681537660
192	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,UMGHKMXVHU}	1672681537951
193	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,UMGHKMXVHU}	1672681538116
196	master	get_user_by_access_token	{syt_YnJpZGdlYWRtaW4_XbgGxIqpNVYMvwBwSeaY_0XQEMe}	1672681634857
197	master	count_e2e_one_time_keys	{@bridgeadmin:localhost,UMGHKMXVHU}	1672681634881
198	master	get_e2e_unused_fallback_key_types	{@bridgeadmin:localhost,UMGHKMXVHU}	1672681634891
199	master	count_e2e_one_time_keys	{@admin:localhost,VXDDHODNPG}	1672681647055
206	master	count_e2e_one_time_keys	{@admin:localhost,VXDDHODNPG}	1672681647463
210	master	get_user_by_access_token	{syt_YWRtaW4_ySaKUQAzQNbimqhezTsU_3zxMzh}	1672682058144
213	master	user_last_seen_monthly_active	\N	1672682324606
214	master	get_monthly_active_count	{}	1672682324623
215	master	get_user_by_id	{@mm_mattermost_a:localhost}	1672682468627
216	master	get_user_by_access_token	{syt_bW1fbWF0dGVybW9zdF9h_rUrNiYyNSErkgVlCVmNx_3xrgP9}	1672682468660
217	master	count_e2e_one_time_keys	{@mm_mattermost_a:localhost,NKUHEKKTZZ}	1672682468758
218	master	get_e2e_unused_fallback_key_types	{@mm_mattermost_a:localhost,NKUHEKKTZZ}	1672682468765
219	master	count_e2e_one_time_keys	{@mm_mattermost_a:localhost,WVINFYXSBT}	1672682526598
220	master	get_e2e_unused_fallback_key_types	{@mm_mattermost_a:localhost,WVINFYXSBT}	1672682526640
221	master	count_e2e_one_time_keys	{@mm_mattermost_a:localhost,WVINFYXSBT}	1672682526787
222	master	count_e2e_one_time_keys	{@mm_mattermost_a:localhost,WVINFYXSBT}	1672682526881
223	master	count_e2e_one_time_keys	{@mm_mattermost_a:localhost,WVINFYXSBT}	1672682526978
224	master	count_e2e_one_time_keys	{@mm_mattermost_a:localhost,WVINFYXSBT}	1672682527075
225	master	count_e2e_one_time_keys	{@mm_mattermost_a:localhost,WVINFYXSBT}	1672682527165
226	master	_get_bare_e2e_cross_signing_keys	{@mm_mattermost_a:localhost}	1672682527176
227	master	_get_bare_e2e_cross_signing_keys	{@mm_mattermost_a:localhost}	1672682527191
228	master	_get_bare_e2e_cross_signing_keys	{@mm_mattermost_a:localhost}	1672682527207
229	master	count_e2e_one_time_keys	{@mm_mattermost_a:localhost,WVINFYXSBT}	1672682527262
230	master	count_e2e_one_time_keys	{@mm_mattermost_a:localhost,WVINFYXSBT}	1672682527422
231	master	count_e2e_one_time_keys	{@mm_mattermost_a:localhost,WVINFYXSBT}	1672682527565
232	master	count_e2e_one_time_keys	{@mm_mattermost_a:localhost,WVINFYXSBT}	1672682527655
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
20	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$Z2BDuqYr2x_4RtA8EmelcT41xj-7klcpKFvY5-POfVw	\N	master
21	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$uuCt7OoWWYBzi7T3Jte6ntGxol6g760NhRDnyPvGMLA	\N	master
22	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$IUtrl9K7UzIz2Mh8WwC4IwE46CubMgrjKFmHcXBu2Cg	\N	master
23	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$_ZI5M7wMM-QBKHgJHCRJC5LeBkOqglv0DLH3BAuL_mw	\N	master
24	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$0qBcJsMAQpJ663R0qWtkO3DyspiocKFy-urTZsaZ3pw	\N	master
25	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$lV2FDnpp7NRIRR5BdRLjhMfQU639aIzIumB6iT8p1ao	\N	master
26	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$AhmCkSaIYchTfHKz-ScAJNw5JBnITPWbCCQxUwRuIjo	$IUtrl9K7UzIz2Mh8WwC4IwE46CubMgrjKFmHcXBu2Cg	master
27	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$th-c5RZ-B0CMnKv9LtzPkBy_JfUuYDy4zUtX-8O9Rzg	$_ZI5M7wMM-QBKHgJHCRJC5LeBkOqglv0DLH3BAuL_mw	master
28	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$DjME4nek1Vnfgp8JIvyexbgZFnJ7UrCzBWYcgi5DRQE	$0qBcJsMAQpJ663R0qWtkO3DyspiocKFy-urTZsaZ3pw	master
29	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$wttc0xGxavZKEFW4jhvY1iHmKn5fBDpTA47wmyrYJ6k	$lV2FDnpp7NRIRR5BdRLjhMfQU639aIzIumB6iT8p1ao	master
30	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$moj2kqPjW9Xd0RBTBX4Ee8HVebtt8aY6J7P3i6UT7qw	\N	master
31	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$DrKoz6WomICqVeub6PxHnTnu5NbhLDAg2J9rHOxBMmA	$moj2kqPjW9Xd0RBTBX4Ee8HVebtt8aY6J7P3i6UT7qw	master
32	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$hUQcgu2HJB2PDqWBrqIQkblhG-WvxXaIzHEnXw-Ej30	\N	master
33	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$fkjIqV9H5dj_boKqogOxPeFW_m8yxwpxTgr4lSwePDY	$hUQcgu2HJB2PDqWBrqIQkblhG-WvxXaIzHEnXw-Ej30	master
34	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$FUJQN-_4fHqBV5emsypqKHRRS0j5jbpMmuarjoIptOg	\N	master
35	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk	$FUJQN-_4fHqBV5emsypqKHRRS0j5jbpMmuarjoIptOg	master
36	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$fG61faFdiQLdggY7LGhSk_5yDw-HxLQiWURS7cCmAAc	\N	master
37	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$ze3RfSNk1D8sruIVbtfFmFdyoNnUgcEoFtM7ULxeWMs	$fG61faFdiQLdggY7LGhSk_5yDw-HxLQiWURS7cCmAAc	master
38	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$ifo4xdQDNVXvmkvgnrcj5o9iKblytzWMd_pEcRtWvx8	$fkjIqV9H5dj_boKqogOxPeFW_m8yxwpxTgr4lSwePDY	master
39	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$BeKLUYL7qRfgvRH3qg2u6Z41GK2CNQqGwtAmWHwBWjA	$DrKoz6WomICqVeub6PxHnTnu5NbhLDAg2J9rHOxBMmA	master
40	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$DOD9xnyV6gfI9j6KBsEdTpRu2l62hsRVmc9i6QLcseo	$ifo4xdQDNVXvmkvgnrcj5o9iKblytzWMd_pEcRtWvx8	master
41	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$KG18kyO7FM4HavQZH_xZmXGUw1RbyfWhbs-Ds3u5vB8	$BeKLUYL7qRfgvRH3qg2u6Z41GK2CNQqGwtAmWHwBWjA	master
45	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$sT18sK2FK6Bo7161sdufjmhywK9CsJHemT-D6fDbaWs	$DOD9xnyV6gfI9j6KBsEdTpRu2l62hsRVmc9i6QLcseo	master
46	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$d05l2i-Vc2Zzx3bl0Vz-NnDVVhxgFQIctiPfGoz0Xjs	$KG18kyO7FM4HavQZH_xZmXGUw1RbyfWhbs-Ds3u5vB8	master
52	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$CcTsy5iCDZyphUv5irDLp85iBq-btwDvTJahbK5ATzo	$d05l2i-Vc2Zzx3bl0Vz-NnDVVhxgFQIctiPfGoz0Xjs	master
53	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$0F5VtbBOxf2d2OwQ46I3LM3tqAkj2YWFXSKWzfzdtT8	$sT18sK2FK6Bo7161sdufjmhywK9CsJHemT-D6fDbaWs	master
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
$Z2BDuqYr2x_4RtA8EmelcT41xj-7klcpKFvY5-POfVw	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	join
$uuCt7OoWWYBzi7T3Jte6ntGxol6g760NhRDnyPvGMLA	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	join
$AhmCkSaIYchTfHKz-ScAJNw5JBnITPWbCCQxUwRuIjo	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	join
$th-c5RZ-B0CMnKv9LtzPkBy_JfUuYDy4zUtX-8O9Rzg	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	join
$DjME4nek1Vnfgp8JIvyexbgZFnJ7UrCzBWYcgi5DRQE	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	join
$wttc0xGxavZKEFW4jhvY1iHmKn5fBDpTA47wmyrYJ6k	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	join
$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	join
$ze3RfSNk1D8sruIVbtfFmFdyoNnUgcEoFtM7ULxeWMs	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	join
$CcTsy5iCDZyphUv5irDLp85iBq-btwDvTJahbK5ATzo	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	join
$0F5VtbBOxf2d2OwQ46I3LM3tqAkj2YWFXSKWzfzdtT8	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	join
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
6	@matterbot:localhost	XDDCJAWJAE
7	@mm_mattermost_b:localhost	QRNNVDTJZK
9	@bridgeadmin:localhost	JRVSUYQVAD
10	@bridgeuser1:localhost	VHYKHOSQYR
11	@bridgeuser2:localhost	ODNLYFPRKY
13	@mm_bridgeuser2:localhost	KIVDOYXNGO
14	@admin:localhost	WCSUBIGVWG
15	@mm_bridgeuser1:localhost	KGOEVGJKUJ
16	@matrix_a:localhost	TKAVEOGKHH
20	@matrix_a:localhost	s7AxObibLcTRgOC/O+exL9WNyi5neAuVF3uOFmqY6c0
21	@matrix_a:localhost	uUrBrohIl6Xrd5lyKxJ9lBty/nGOXWJ2+gVk01JxZO4
22	@matrix_a:localhost	DOIVEAHHYD
26	@admin:localhost	R3UgEnhYPa5+D1+tlkvn37kpQ3lgTINOyh4m0UCJD3Y
27	@admin:localhost	q3CUiM6vsCzN2C4tfyod3VwGOZhtnXOV2TSj2s4fWqs
28	@admin:localhost	LDJENJGFPQ
31	@matrix_a:localhost	CMZPUTUYMO
35	@mm_bridgeuser1:localhost	DRMz880tLTidkDctudXSpIqG4uAwslSk8Hjm68KYkdY
36	@mm_bridgeuser1:localhost	Ms3Q/f6VJi/GNybdMFWcA0vERCQXuM7D5DDQTK2zvWI
37	@mm_bridgeuser1:localhost	TKJYESZBTR
40	@matrix_a:localhost	QAMBZSULSZ
43	@matrix_a:localhost	JEDZORXLOY
47	@bridgeadmin:localhost	EoTezP3Htf0wWXZ5EMiXaHZRa41sFDA4ijibsq4g86A
48	@bridgeadmin:localhost	rHLn0DPtS8WpleuRtsccACEPrgLfXqAe5RUhD+5lFEU
49	@bridgeadmin:localhost	UMGHKMXVHU
52	@admin:localhost	VXDDHODNPG
53	@mm_mattermost_a:localhost	NKUHEKKTZZ
55	@mm_mattermost_a:localhost	WVINFYXSBT
57	@mm_mattermost_a:localhost	8W+CcIzUjA2oQzjIN2dyZF9K8UTXwkVIJZsNz6w6jUI
58	@mm_mattermost_a:localhost	RBbqKTOq8cZNFukjqOuU4bF/bvV4zFH8LJVI+pxViuo
\.


--
-- Data for Name: devices; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.devices (user_id, device_id, display_name, last_seen, ip, user_agent, hidden) FROM stdin;
@matrix_b:localhost	DJFHSWMXLW	\N	1598686328482	172.21.0.1	curl/7.72.0	f
@ignored_user:localhost	IYEBBQEXHS	\N	1598686328565	172.21.0.1	curl/7.72.0	f
@matterbot:localhost	XDDCJAWJAE	\N	\N	\N	\N	f
@mm_mattermost_b:localhost	QRNNVDTJZK	\N	\N	\N	\N	f
@bridgeuser1:localhost	VHYKHOSQYR	\N	\N	\N	\N	f
@bridgeuser2:localhost	ODNLYFPRKY	\N	\N	\N	\N	f
@mm_bridgeuser2:localhost	KIVDOYXNGO	\N	\N	\N	\N	f
@matrix_a:localhost	s7AxObibLcTRgOC/O+exL9WNyi5neAuVF3uOFmqY6c0	master signing key	\N	\N	\N	t
@matrix_a:localhost	uUrBrohIl6Xrd5lyKxJ9lBty/nGOXWJ2+gVk01JxZO4	self_signing signing key	\N	\N	\N	t
@matrix_a:localhost	2Ni0+kad0Qdxs5VniAAOzVxLBZKcqynOFjSLUwz7kb0	user_signing signing key	\N	\N	\N	t
@admin:localhost	R3UgEnhYPa5+D1+tlkvn37kpQ3lgTINOyh4m0UCJD3Y	master signing key	\N	\N	\N	t
@admin:localhost	q3CUiM6vsCzN2C4tfyod3VwGOZhtnXOV2TSj2s4fWqs	self_signing signing key	\N	\N	\N	t
@admin:localhost	5qGRDtSxhVZyiP2JJbhLJnoUlfH9iHyovyqyPdRG1ZU	user_signing signing key	\N	\N	\N	t
@mm_bridgeuser1:localhost	DRMz880tLTidkDctudXSpIqG4uAwslSk8Hjm68KYkdY	master signing key	\N	\N	\N	t
@mm_bridgeuser1:localhost	Ms3Q/f6VJi/GNybdMFWcA0vERCQXuM7D5DDQTK2zvWI	self_signing signing key	\N	\N	\N	t
@mm_bridgeuser1:localhost	sXQuRrkSusQMI3K8q7A91xEhfNh6GgxUxCkNTrAI9kA	user_signing signing key	\N	\N	\N	t
@bridgeadmin:localhost	EoTezP3Htf0wWXZ5EMiXaHZRa41sFDA4ijibsq4g86A	master signing key	\N	\N	\N	t
@bridgeadmin:localhost	rHLn0DPtS8WpleuRtsccACEPrgLfXqAe5RUhD+5lFEU	self_signing signing key	\N	\N	\N	t
@bridgeadmin:localhost	+Hw6SR2JZ3zFIE5KSHXalhL2IITMMY36ncTP+oqqTpE	user_signing signing key	\N	\N	\N	t
@bridgeadmin:localhost	JRVSUYQVAD	\N	1672682466862	172.16.238.1	PostmanRuntime/7.29.2	f
@mm_mattermost_a:localhost	8W+CcIzUjA2oQzjIN2dyZF9K8UTXwkVIJZsNz6w6jUI	master signing key	\N	\N	\N	t
@mm_mattermost_a:localhost	RBbqKTOq8cZNFukjqOuU4bF/bvV4zFH8LJVI+pxViuo	self_signing signing key	\N	\N	\N	t
@mm_mattermost_a:localhost	ZO1pbK/bBirmkdP/EIuvXs3nKHy/UeSuVIdwEJF6Lns	user_signing signing key	\N	\N	\N	t
@mm_mattermost_a:localhost	WVINFYXSBT	Element Skrivbord: macOS	1672682644828	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36	f
\.


--
-- Data for Name: e2e_cross_signing_keys; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_cross_signing_keys (user_id, keytype, keydata, stream_id) FROM stdin;
@matrix_a:localhost	master	{"user_id":"@matrix_a:localhost","usage":["master"],"keys":{"ed25519:s7AxObibLcTRgOC/O+exL9WNyi5neAuVF3uOFmqY6c0":"s7AxObibLcTRgOC/O+exL9WNyi5neAuVF3uOFmqY6c0"},"signatures":{"@matrix_a:localhost":{"ed25519:DOIVEAHHYD":"I6iNT+wj08jJvQ2kLVjsgSkXiNjrnUXUzS+i4hEjXdDIBHR0ojJQKLmZ34k06ZKSLOKpxVID1km5+Ax9Nx9WBw"}}}	2
@matrix_a:localhost	self_signing	{"user_id":"@matrix_a:localhost","usage":["self_signing"],"keys":{"ed25519:uUrBrohIl6Xrd5lyKxJ9lBty/nGOXWJ2+gVk01JxZO4":"uUrBrohIl6Xrd5lyKxJ9lBty/nGOXWJ2+gVk01JxZO4"},"signatures":{"@matrix_a:localhost":{"ed25519:s7AxObibLcTRgOC/O+exL9WNyi5neAuVF3uOFmqY6c0":"9Fl58cB/h3cR3gdHOCtl2FM92FJERiKi++9TeP1Ta6YUTyi+budzUowZMn4MB4eQp2+uivbW0c/Wt87c+E4DBQ"}}}	3
@matrix_a:localhost	user_signing	{"user_id":"@matrix_a:localhost","usage":["user_signing"],"keys":{"ed25519:2Ni0+kad0Qdxs5VniAAOzVxLBZKcqynOFjSLUwz7kb0":"2Ni0+kad0Qdxs5VniAAOzVxLBZKcqynOFjSLUwz7kb0"},"signatures":{"@matrix_a:localhost":{"ed25519:s7AxObibLcTRgOC/O+exL9WNyi5neAuVF3uOFmqY6c0":"P3a//sInj7zPgo7uZNfBV4nkdjQz0Oi48eWPZS5xjVQCI6L+EsS+oj5OdUcVTSQfioRjTKiyrLHwh/83fX/kCw"}}}	4
@admin:localhost	master	{"user_id":"@admin:localhost","usage":["master"],"keys":{"ed25519:R3UgEnhYPa5+D1+tlkvn37kpQ3lgTINOyh4m0UCJD3Y":"R3UgEnhYPa5+D1+tlkvn37kpQ3lgTINOyh4m0UCJD3Y"},"signatures":{"@admin:localhost":{"ed25519:LDJENJGFPQ":"N1jU3qw/saBzpPEoEj2sPYyV/VYPZwA1I5MoWL4qdqEEEfhlxgQXLADFBVd0Bo1D3RH7pqdwN3kHRe6dxVa9Bw"}}}	5
@admin:localhost	self_signing	{"user_id":"@admin:localhost","usage":["self_signing"],"keys":{"ed25519:q3CUiM6vsCzN2C4tfyod3VwGOZhtnXOV2TSj2s4fWqs":"q3CUiM6vsCzN2C4tfyod3VwGOZhtnXOV2TSj2s4fWqs"},"signatures":{"@admin:localhost":{"ed25519:R3UgEnhYPa5+D1+tlkvn37kpQ3lgTINOyh4m0UCJD3Y":"n0Db7vqFQBWt8OgTGPwYTZUsko2VEvsiTq9Y31X0Cn9UGAVwFhwv3pfKvGGGzG3ja6s2aW8y6G4Ra5hZ0wAMAw"}}}	6
@admin:localhost	user_signing	{"user_id":"@admin:localhost","usage":["user_signing"],"keys":{"ed25519:5qGRDtSxhVZyiP2JJbhLJnoUlfH9iHyovyqyPdRG1ZU":"5qGRDtSxhVZyiP2JJbhLJnoUlfH9iHyovyqyPdRG1ZU"},"signatures":{"@admin:localhost":{"ed25519:R3UgEnhYPa5+D1+tlkvn37kpQ3lgTINOyh4m0UCJD3Y":"Zs0pzlzDd0cvKg8PPx6XwDIZKrZ7P7x6uuwYwPeBM0Yf8VA2IKpffDmAS1kOeKS/9I8zasqDWoZNaIEMRQzyBg"}}}	7
@mm_bridgeuser1:localhost	master	{"user_id":"@mm_bridgeuser1:localhost","usage":["master"],"keys":{"ed25519:DRMz880tLTidkDctudXSpIqG4uAwslSk8Hjm68KYkdY":"DRMz880tLTidkDctudXSpIqG4uAwslSk8Hjm68KYkdY"},"signatures":{"@mm_bridgeuser1:localhost":{"ed25519:TKJYESZBTR":"+O3h34tCSZ2wQkoqkj7UKQwOUTtVvaZ5yVyZGCnA6yY0NEI66CJECDTKXCWqqpTkJvaGuTTKjwyAB4EvbKpmCA"}}}	8
@mm_bridgeuser1:localhost	self_signing	{"user_id":"@mm_bridgeuser1:localhost","usage":["self_signing"],"keys":{"ed25519:Ms3Q/f6VJi/GNybdMFWcA0vERCQXuM7D5DDQTK2zvWI":"Ms3Q/f6VJi/GNybdMFWcA0vERCQXuM7D5DDQTK2zvWI"},"signatures":{"@mm_bridgeuser1:localhost":{"ed25519:DRMz880tLTidkDctudXSpIqG4uAwslSk8Hjm68KYkdY":"CRUPZrr7rUIRIBr6C1QCGgknvX4RAScQkx3drLSpZkMFbV7H9l84hhn1TUJLMdlbmpDkzG7AmH25Bgqa8DWjCA"}}}	9
@mm_bridgeuser1:localhost	user_signing	{"user_id":"@mm_bridgeuser1:localhost","usage":["user_signing"],"keys":{"ed25519:sXQuRrkSusQMI3K8q7A91xEhfNh6GgxUxCkNTrAI9kA":"sXQuRrkSusQMI3K8q7A91xEhfNh6GgxUxCkNTrAI9kA"},"signatures":{"@mm_bridgeuser1:localhost":{"ed25519:DRMz880tLTidkDctudXSpIqG4uAwslSk8Hjm68KYkdY":"7a0lyQx9ajNZg6t9mkCkOJiYIvXByWb7T1U2Tz4Da4yKpE+9/K3dqM0Mxss6X/0qjj6RjOVcjsw3p0F9aoy9CQ"}}}	10
@bridgeadmin:localhost	master	{"user_id":"@bridgeadmin:localhost","usage":["master"],"keys":{"ed25519:EoTezP3Htf0wWXZ5EMiXaHZRa41sFDA4ijibsq4g86A":"EoTezP3Htf0wWXZ5EMiXaHZRa41sFDA4ijibsq4g86A"},"signatures":{"@bridgeadmin:localhost":{"ed25519:UMGHKMXVHU":"JVwM1K+s3mvBjPTN/jonX/Yb42uHOQc955iZ42nkDNdfLAHdjRYQO7wjwBgfwofdGi1ZIRiK4B9ljcQI8swzAg"}}}	11
@bridgeadmin:localhost	self_signing	{"user_id":"@bridgeadmin:localhost","usage":["self_signing"],"keys":{"ed25519:rHLn0DPtS8WpleuRtsccACEPrgLfXqAe5RUhD+5lFEU":"rHLn0DPtS8WpleuRtsccACEPrgLfXqAe5RUhD+5lFEU"},"signatures":{"@bridgeadmin:localhost":{"ed25519:EoTezP3Htf0wWXZ5EMiXaHZRa41sFDA4ijibsq4g86A":"X8kHoGsV9bDiGT0LdZHw/Rb1jZRX1qzF8IB6GXvGWJflpOMR5X2ltmog+zoT1yTfX8VYUcHZo2jLENjQudXhAQ"}}}	12
@bridgeadmin:localhost	user_signing	{"user_id":"@bridgeadmin:localhost","usage":["user_signing"],"keys":{"ed25519:+Hw6SR2JZ3zFIE5KSHXalhL2IITMMY36ncTP+oqqTpE":"+Hw6SR2JZ3zFIE5KSHXalhL2IITMMY36ncTP+oqqTpE"},"signatures":{"@bridgeadmin:localhost":{"ed25519:EoTezP3Htf0wWXZ5EMiXaHZRa41sFDA4ijibsq4g86A":"rJJHCKHM/Do1T2xuc1+ZoPzvaePQIxCD6hqHtR+SEEQa8BjuGvnEqiU7Jv495j1+gl+r/DTpO/D0BRKQ0BRhCA"}}}	13
@mm_mattermost_a:localhost	master	{"user_id":"@mm_mattermost_a:localhost","usage":["master"],"keys":{"ed25519:8W+CcIzUjA2oQzjIN2dyZF9K8UTXwkVIJZsNz6w6jUI":"8W+CcIzUjA2oQzjIN2dyZF9K8UTXwkVIJZsNz6w6jUI"},"signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"IdZGwnosGPlrPhFTjCJ/7kmmlWBd6srwko5TGZOtj0+5p1jHvc0XlgMhvrSRITDg9LA+i3vxvFHdbM9IFWxbCQ"}}}	14
@mm_mattermost_a:localhost	self_signing	{"user_id":"@mm_mattermost_a:localhost","usage":["self_signing"],"keys":{"ed25519:RBbqKTOq8cZNFukjqOuU4bF/bvV4zFH8LJVI+pxViuo":"RBbqKTOq8cZNFukjqOuU4bF/bvV4zFH8LJVI+pxViuo"},"signatures":{"@mm_mattermost_a:localhost":{"ed25519:8W+CcIzUjA2oQzjIN2dyZF9K8UTXwkVIJZsNz6w6jUI":"Sz/7uBfQ5vc36fN7Zsm/HyCpd+uFRPsMXv65iIMIUZefi1bdtN7nMjwlWISAqGlRg0WnmUWtUHWjVfmsFRphCA"}}}	15
@mm_mattermost_a:localhost	user_signing	{"user_id":"@mm_mattermost_a:localhost","usage":["user_signing"],"keys":{"ed25519:ZO1pbK/bBirmkdP/EIuvXs3nKHy/UeSuVIdwEJF6Lns":"ZO1pbK/bBirmkdP/EIuvXs3nKHy/UeSuVIdwEJF6Lns"},"signatures":{"@mm_mattermost_a:localhost":{"ed25519:8W+CcIzUjA2oQzjIN2dyZF9K8UTXwkVIJZsNz6w6jUI":"8USadFVsmhRECSaJ1IOJa05zSaUI13jmyBPPOZZEsZ5ek2d3KmFrhP8nXxwQCRInyIG32CNt/DCCEed+PlwfCw"}}}	16
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
@mm_mattermost_a:localhost	WVINFYXSBT	1672682525725	{"algorithms":["m.olm.v1.curve25519-aes-sha2","m.megolm.v1.aes-sha2"],"device_id":"WVINFYXSBT","keys":{"curve25519:WVINFYXSBT":"GkQdQBLmJ+zOqPOoNTNX4HQ4Fi7P9hPzkDv5qdTiozY","ed25519:WVINFYXSBT":"ZJkhqQgV4Lk1o3DPuG8rvWv6bqWIZDwRuXcbLsUWBj4"},"signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"QCxbBKuVO2WWtk2uxzPIUqEHa8dnXzlsj585zHJ8dN5MI+EVtoIwYN/OWDuSZybJZLAsDsCgzq/+zeOQnrdNBA"}},"user_id":"@mm_mattermost_a:localhost"}
\.


--
-- Data for Name: e2e_fallback_keys_json; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_fallback_keys_json (user_id, device_id, algorithm, key_id, key_json, used) FROM stdin;
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAABg	{"key":"M8EkLLIpVoWpZ317WadVmJOKEVuu/c0c3+4dbsFoVBI","fallback":true,"signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"AuCtYArsA41Lo4mvnc5C7QYfhKFHLwInfrYnw9mAqU3Qgbg09lHuAsGDMxBSWyYcHfhQpc032wTYYJ2TBjiqAQ"}}}	f
\.


--
-- Data for Name: e2e_one_time_keys_json; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_one_time_keys_json (user_id, device_id, algorithm, key_id, ts_added_ms, key_json) FROM stdin;
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAABQ	1672682526550	{"key":"3JYtDUwl/86ucK9UMCcJ/9b9NUUVxscIiLYXo887/wQ","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"ARWAMkNqx9a0p0A4/D8nEevaoXXh6IWVb3BKIdD3cnViBmWQiEpAp+iDWavqZNiSr8PqtMS7tPJLnOu7bYl8CQ"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAABA	1672682526550	{"key":"B0UDLayFNVgwzkK24/kG0oLKcOs6s6CYcpeyCro2TD4","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"R7Fmfd/M0Q8/zcAemS5PhkC2Ue0OwSoSPEPYeRriptsaBbirMIrOJaa8krg72m0rWCcLqqwbYXKQNnQM3EyRAA"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAAw	1672682526550	{"key":"81tDwOxn/GPBGRp78/diG31H8yXupkPYfU7JQimLX0Y","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"Es2RaaPyaVmNZ0ci13LRWoVpzPjecUFDk7i28yb4KpwphqefsRjRyfhYiOpfPPgY4XEHlEuuYRg91L+R+icpDg"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAAg	1672682526550	{"key":"2wV40QDG/ZHg+D9dkUaxdGTqG0B09FR9gW2Wf57ThFY","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"q3yE/iFN495eb/3Ftn/PnFM3XXRwRdFMfKQXZE6zlsaOkWTLgNNC0oXn49FxEYaIfELIIi8b2jDU/HCkLlMRCA"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAAQ	1672682526550	{"key":"8ulpg1TEg7HkD+ecmfMzVTw6lS/FGxoVvrlNsSlxHEI","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"mvYyC675pFWBND9IpdDnSZU1JFmsdDHUUtcObAMEYbM/bBtf7gmIzxp0VSPqzC3DY4m38Dd5c2lTXOm3y/YwDA"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAACw	1672682526777	{"key":"EWh381FNoJRl68GI7nPSgk5oLtsGX1fQPiZFMLyEsQI","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"+vM8G9Fhqz3XAN01v/J7E28cRpTmaf/U5IEQPNxBJbOF17mgkSYt7/XtNvIRODuNTr+lIPi/CRZo/hAQFkv4Bg"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAACg	1672682526777	{"key":"OYadp+3eFeZQWvrO0OBs/OgU7gD8cqJB2cEdUXNBFVc","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"1CW15oB9pcLKEbZm5C2OIQ/4g7EiMVYi6LNOc5ss7wV5sJRZE7W9nrVNLGqTkkDRrqX1NbRGHeHztbBiXk2WCw"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAACQ	1672682526777	{"key":"AD8Q2kE+mvC8ZT8bd960dQO0oInTG33evaK9sjkb+zk","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"BLBOKdXhQUtOfJAK0ivnW63v+zD7XwgCyaIpi4Kjs7ZuYDr4tXeV8IG/q8cyFH96qS6eP9i4VPeTPHwh/9K4Cw"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAACA	1672682526777	{"key":"t/+XLAr3jZiynt64qih/rqctmEz07HNMl0NtspMeSg8","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"0ZQP7XSdeZQcRdP0B801A8uy0f7tTnlUOJsU6V8CHCR7irlsYl3NstgL1wje/kZ/igMpJiXzKhqrJ+iQp8bgDA"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAABw	1672682526777	{"key":"5Ddi9zte67Dh/UBWG3K1rP7UWFCdSWvTCr7io32y1zo","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"/afa3z+285EZdeplLaDxjGuoK41uRAhZkX9+QHIbCA4yj0e7d6oILJBT0aErGFXuaXDkR1h618RocYir7YUGDw"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAEA	1672682526871	{"key":"3PHjlJv+SzLZCKN4D+LwCAkMzpwWhfmr+YHw0HRzA2o","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"bBhskkn3Q86u45fn/IFBZyUE9R8ivIeNniWX5H2qXDUzUQrJGlz7B96JYMDMXrT+gJ7ipnwXgeE4IGRLs++eCg"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAADw	1672682526871	{"key":"cYp/dE4VaeDBdIKlcMWMNaKdDzpuuSon4P08UQWq6QE","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"z4KzK/q+JChr9UchKGegB8rMDsOMr5uDzpNqqqzxjqTAugXoQZl6QqYCqUyct5O63qxDQUC1nf8LxshTLnncBA"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAADg	1672682526871	{"key":"iiapI7q3opeL4bTYSFOjAhkwAK4nbrOPE2IUJJQCoB0","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"kqG1PnLVbYc0rmfzWIZBZfJ+UG5i15sZGI32j/WlIMWJrTSEX2GwjuGGy3xp9X5/deeMZls8rFHAWEj100f0AA"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAADQ	1672682526871	{"key":"UqcOg6VxDVm4lX6HErfCtOsP5OuvEOc0NCiW28rhXmE","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"DzXKTCabPLSRVpf11P0DLSHUvEtHDo9AJz3ttLxJbkIAtvbqMjec+KPvOwpEl8MlmP1l3RSDwQrQ7+HBnkb9BQ"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAADA	1672682526871	{"key":"gfsOnY+rEUXg9jOiy2W5xzJOnXNpZOrW/OBBFki4GVk","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"FMhNzBOg6AZCo5XLTB71jlUH4A/gw120Z8e3ZaROjEEgDXrrYJ6OL0LZ1mIprAElAur9VEcDrOjGiXPHg1d4AA"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAFQ	1672682526969	{"key":"xF1ZLCIy2egHNw6tP8x8l5FmV2kvSGaFuojy032ZLXA","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"g+FilAex4TsJ0WaenXUdz8hcuHLoNs4Shixch4vSZh+ned80kJO56oJblz/FIoCwAFg3T8cjGqBQnx7DgJO3CQ"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAFA	1672682526969	{"key":"0qBdxhD8W5SmB0zJRqTuULEjsHBk8UfvE0fadJ3Hhyw","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"3Htb+RcvhGWxABuqaaV6KdBC5XQ2gev9/xGnn5CeTjvUy1irZZM4I1+21EoYjKh3090A9ZUbHOKvwAgoX1uSAw"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAEw	1672682526969	{"key":"mMeVRntdMdjLWYN/wIqVPJqlNrPknPlU9qpg/6ZJtwI","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"DWDbWJBstGVxxh00E/stHvbzqmUEvO9+Ip/crvGl18o8jeG5kDeLe82meHF68CDQZ0sdbzW0WNkmIBvKHSsHCg"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAEg	1672682526969	{"key":"jjG9vvkh+XgIyjKd84pRjyqWgu0wD+IClh4Z8d2CIHo","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"ppPg3GORzGgJIYshnN4wUgJloJ81J6LleXv0RVT4xvVD9xCmarzj7vFzOAos9bQOA3e3TxUcjumjLxgNHnOdAQ"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAEQ	1672682526969	{"key":"ChB9H3qE+8Opv7w3LucMsseLqEEAQAkDtmVvnoNkv0g","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"a6GUMRNAwCjWFyucOhvki5HIAXnAKSJtL2JR4ENG6erlQ3pg0lAfUooaOQIh08fBfrQd3BTglvJGskYXxb7XCg"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAGg	1672682527069	{"key":"zxDwdGs3SzUEfFpITFHjLAK4JZwiZBpfdc8xwDB90xk","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"M0nnCZQF4NADqM2YZ0yELdttMUoPvOcb8abpHtIbmh/zAU9C/YiZaYdfJsnVQIzjiyx/2iFHhbUCawbmGdD5CA"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAGQ	1672682527069	{"key":"GMIO41cj6h2tkEFxWAp/0Zm95wE27l8Uo/YJ2lyzZVg","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"Bb/jHu75786sFqKGFsrfsaXJDQUqlxQIu/fb2otDvpnNCXGZS5FNEmYr9C1aMypSo5PoX6qx3JfeA5rlNTHYBQ"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAGA	1672682527069	{"key":"jOVsfOI908iOSOoR1+1p+IVFS3N0Q37kzZLNJw8CUx4","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"alG4TaruxkhiPUBdotJlB9trapnvTuvT22Qo+86eBKn0LzVm9yjMqGF3bxeXkjR+rzgR27GfL/Igdq8U12ORCQ"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAFw	1672682527069	{"key":"LRqyuwMXFHlce5WfohtXAZLgsQxq+MTy4NuSns8ApEA","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"udJHEC5kdQOz1dn+DPx95tTuT/CTCvdKyYc5j/fiq1IFgr0wvvFsKwL2ODoq4LyG18UGFKqEK3d+v/4ayUMOBg"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAFg	1672682527069	{"key":"fuB3vokq+Bp20TNgtYv7yRXSJV/KS2AsyYoPe5WPrTI","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"apMpuAwKS4RrKcf1+EWRNMMiPEvUaMMJ/rEiiU62//08oZZ4U6aZ5idA8Cm1ji9dmOOcz4e1sKpcNPcYboL0BA"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAHw	1672682527150	{"key":"n52pQG4ls1aTaTD5aYrYU2JhSqf9n53AuQWjjvuJnTI","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"oR97PImQvOFMmvDm66Ns5rhhzpc0saDqN+WXRSodjQcEidznfia8YXfJ8EiZHthoFnij9s4QarF41W6+tjQICQ"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAHg	1672682527150	{"key":"MoszBHumgDbJs1QGpTZHkdxoYCSfq7JDPhdnDxvZR0g","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"+b3BMGNbj5hE3oLloAmNqRrCHJYN87fXFGJIr6Sdac2Y4w4Vd2b0BTL9m7JR52znoMYo5DecXNQ+Ts/Gc222Aw"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAHQ	1672682527150	{"key":"HFZc02iuJyhshxBpA20xj7urrELyatiGHIEEMqL7GS4","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"Zf4O3lHbP95O9P5ReklwPVobAIpXAd95swuKwetT6sE4vX5waVfnXNKkUIV8Gs9RY2kzKmvXleCAK82eWKrsBQ"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAHA	1672682527150	{"key":"zOdOIhzGR0sTqB8pFV4XA2PPiAPkNwBWiefFVymdhBc","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"Tc5y1kvYiLS+1uNC6jvoqnltSTpwZgaAw51naTS/9hAte9o/8QBECxAEweyHbywCh4WDir+U94vB4zVQ4hxrBw"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAGw	1672682527150	{"key":"04OEWH0uRUaXONg3Xa4GfIXFhuCB7Lrogv9mf/v/gTk","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"xopPD39ZbfIOJXeoIR/5zAEJWmctCwTA9FnLHvJIV1dHq4pCPek40u6jj1ZWxRN9wx4b2bZ19RgA2A5223HSCA"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAJA	1672682527247	{"key":"/CkE55OgZwxngY5JbSF2GbIo3XcP9VK5k7URh2JURWI","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"3IWXycIDm4dHo1dsVM67BB58E2ni+IgIrIXmwljxJWLaerYQphYBavootzmMxMHdozCcrKRf6IbnDVLx7Gi6DA"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAIw	1672682527247	{"key":"Dugoh+rv32EM1PO1qIy7Jon+dpeqDZWN6/88BTvhOXI","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"h2rPjY8rQw4eU1uyrtZ9eKMagWEsg0K5aICPTYoAk+fm9lzG5hUGnbFRmhLsnccf7sPWhRDMziuhNQvYW8BlAw"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAIg	1672682527247	{"key":"KjChc/qF2rNLPEaPrisy9sdGuloW0SBYj1x7GCb8fRo","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"jraaWS6uW8+T2PbvT3cFk7YULNIQs46HP5e97CEFH8bBVFQW1NbQ2qY3lAbTVNyLpXn8215S9HoFfgOrf99qCw"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAIQ	1672682527247	{"key":"1HxZTVhI4cDvf0UxjZl8fMyQMYHACiTDLHRkJqdY8yY","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"SY0TmhbmnalvyvHA++3C1K/+BlKvKsm3Ku6cqeUXL9c8dmG1RfF/t3Lo1gVUwMRvqsmN4V89SqS2A4iESstTDw"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAIA	1672682527247	{"key":"Ajp5VQJZTLw1o/Xvyg1yAfn/5Z79RRcNC8qMU6dcSQM","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"f9NeMVCgXKriPzL2lCRe1xlae3jgrdnP3Mjq9KxmejekXxDZypH1RXFtMkoraK/zpxKEoEwMpTpOsQ1GZHVlBQ"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAALg	1672682527540	{"key":"jhmwQeb1MRnOSUlD1GV9jxS7NrG6M5Br1vbB9LuIgiI","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"yoalvFWyJ/GG1iCtTOVbsmUbC3a8OtTc69430KHHwDfOHN7IzdboiCUgrHNf2TYIg/l2cRDsb3aMpHojdzv6AQ"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAALQ	1672682527540	{"key":"fqpBHszOPOLlYtHZnD8gMny9P43L2RHSenr41LqsgXg","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"MArlSNKQguGWgzyb9juLm+eBGmLwwk+6u5nxI+CSVYdNQp7UhJEnXQslrRV8nUmxgONGQucDAk12NoOH8+ZlDQ"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAALA	1672682527540	{"key":"7JN/01+3jgxQYbB7JsMUlOhrKgyHRuTgvSN/7gWfRDU","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"Z938uWvUyw7u3BxmexkXQX5j3TFfxZIV5xMHNUmY5xOU3tIINMA5fxA+ZCyawuytbJ2j6chS2uoynY3QN9NtDA"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAKw	1672682527540	{"key":"iY5oAofSTotJ4DJ4Yy212DxzxGy1mDqjW/TVnfWINFY","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"igU0ElrZUPE2vdMu+ezg+YcRiAGcL2tX4mRbmOSWMjMidPJw2WguUaeumonFQV203yW54PWe0WOu4veip+QbAA"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAKg	1672682527540	{"key":"Q2upRUv5VZYSpHQcWPEsXFHARF/7IDPgqWcknKvh3E0","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"Fqk6Ww14RO1cd3eTkFCOn0EiQsNXnFypTtYX3PkWlwGY7E4vHJIcZbOWa5is2aEB60T/Upf0BkfGVkVT4+e0AA"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAKQ	1672682527404	{"key":"JKfDrjZD5a/oHun2omOMOhOBR6+PwkY1xml5ffwBrGI","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"DwNMOCtF3Lks2iH6UVzlxE4DOLEBiuEeESaqf3tFPnWwdd9vDMXaRfvSDTF5+xZ2LGPM+DXi06+4Hjb+J0L6Cg"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAKA	1672682527404	{"key":"AdldKPm4Z2yYAq2LYE+oCFGVGSD2JuwYkGOfpciD0W4","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"xotFoX2mmvq/8t8EDNwZuTC7YyaG7DWYT+N/IOyoSagysZParWvuDj7MYHOuhgqJMSfbh6yQiSL0vQH2Ph7wBA"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAJw	1672682527404	{"key":"diXyVxIeZBE+ELH9762ncq+M+Ec0tcqhSYzWzQ+fMWo","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"o+hOCi8C31dTQwND21o+IrW0m1QQ7f9RPdhJbkmqi92lDE55gBpgPZBkiuLZpF8qmBKbH9xG2wrdZM74OthJDg"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAJg	1672682527404	{"key":"dNxrbpERbXIlu4jVRsJ/vZSYrH6p8fgl3J6EDkcuRFg","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"Q5HoXljB1tWP8wXrJDKcLZ5RgbF0HSVKDvZqbg8ToxMJDI9+12xXrbpdRyKgtKBu4t5RJdSpU4MiCpL944mRAw"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAJQ	1672682527404	{"key":"wg0lEm007023KmEqfTum0SgkZeF8D9tv5jz84meQ71o","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"vQvmC0AO3uu5FMwVGjugZp1EVQg6bBZUM9U9KrTjogDD8bd7pZ1hJ0YQHdVmZDEjDG3myjP7ZePpoDJeZCnbCg"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAMw	1672682527645	{"key":"fdmTuZp7mnL4fHT9l6Z6p6uIWLzxirQDucQygDaDfgE","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"BU8s5dSUugb75hU39go1dgvi57IulHIlEgchwU8VQ9fIj5QQbefu7TpiYWMZgQIsaWl4J0D8iseP0IkgEz0UAA"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAMg	1672682527645	{"key":"THsCFF/KxJbyYlJdFWq2oyW71k3J6wLE+SYcer4kr2k","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"dCA1+aSRU/mH638Gln61zo3EdD+kFOUR9NfnKmU8wxnPPvLnu90hrFBRFTo0j85QfIZI6Dl6XBHq0aU5Kik+AQ"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAMQ	1672682527645	{"key":"Jb845P1BZoiyvj0geNXSy/874WRTL2vW4Q282MAlxkA","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"/qfE6rRKWKkXHKxDbk8LREy8yafUzPK2q7QbalYKfcz/tVddBXJ71ywzPbs2tqXu1BE5RjhLgezpBo1M6R5fBQ"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAAMA	1672682527645	{"key":"2LSQYZ465cZSswISa+Q+8vhxXhrFaZQkM2T8Sz4Ntic","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"yXYeFNMwMOAbIp9vi/h3hp7p5fs0cba5UN1H61mOJtNgrxNAGadxUdx7HE5y3sNxuMh0+zwX1wjQ7eO3okIBBQ"}}}
@mm_mattermost_a:localhost	WVINFYXSBT	signed_curve25519	AAAALw	1672682527645	{"key":"M7WddLkavtcF89j5K2ywTS0pIbFcxffAYUCV7S6bAwE","signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"O7GJKXIBvhDmnAkMB3CihTl39RcpSVjsE2gKdTQmvsKK2bQrkKIgBldclUjnzsdoHtcfNDF7DShKKDgdDFfMDQ"}}}
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
$Z2BDuqYr2x_4RtA8EmelcT41xj-7klcpKFvY5-POfVw	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$Z2BDuqYr2x_4RtA8EmelcT41xj-7klcpKFvY5-POfVw	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$Z2BDuqYr2x_4RtA8EmelcT41xj-7klcpKFvY5-POfVw	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$uuCt7OoWWYBzi7T3Jte6ntGxol6g760NhRDnyPvGMLA	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$uuCt7OoWWYBzi7T3Jte6ntGxol6g760NhRDnyPvGMLA	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$uuCt7OoWWYBzi7T3Jte6ntGxol6g760NhRDnyPvGMLA	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$IUtrl9K7UzIz2Mh8WwC4IwE46CubMgrjKFmHcXBu2Cg	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$IUtrl9K7UzIz2Mh8WwC4IwE46CubMgrjKFmHcXBu2Cg	$uuCt7OoWWYBzi7T3Jte6ntGxol6g760NhRDnyPvGMLA	!dKcbdDATuwwphjRPQP:localhost
$IUtrl9K7UzIz2Mh8WwC4IwE46CubMgrjKFmHcXBu2Cg	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$IUtrl9K7UzIz2Mh8WwC4IwE46CubMgrjKFmHcXBu2Cg	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$_ZI5M7wMM-QBKHgJHCRJC5LeBkOqglv0DLH3BAuL_mw	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$_ZI5M7wMM-QBKHgJHCRJC5LeBkOqglv0DLH3BAuL_mw	$Z2BDuqYr2x_4RtA8EmelcT41xj-7klcpKFvY5-POfVw	!kmbTYjjsDRDHGgVqUP:localhost
$_ZI5M7wMM-QBKHgJHCRJC5LeBkOqglv0DLH3BAuL_mw	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$_ZI5M7wMM-QBKHgJHCRJC5LeBkOqglv0DLH3BAuL_mw	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$0qBcJsMAQpJ663R0qWtkO3DyspiocKFy-urTZsaZ3pw	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$0qBcJsMAQpJ663R0qWtkO3DyspiocKFy-urTZsaZ3pw	$uuCt7OoWWYBzi7T3Jte6ntGxol6g760NhRDnyPvGMLA	!dKcbdDATuwwphjRPQP:localhost
$0qBcJsMAQpJ663R0qWtkO3DyspiocKFy-urTZsaZ3pw	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$0qBcJsMAQpJ663R0qWtkO3DyspiocKFy-urTZsaZ3pw	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$wttc0xGxavZKEFW4jhvY1iHmKn5fBDpTA47wmyrYJ6k	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$wttc0xGxavZKEFW4jhvY1iHmKn5fBDpTA47wmyrYJ6k	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$wttc0xGxavZKEFW4jhvY1iHmKn5fBDpTA47wmyrYJ6k	$lV2FDnpp7NRIRR5BdRLjhMfQU639aIzIumB6iT8p1ao	!kmbTYjjsDRDHGgVqUP:localhost
$wttc0xGxavZKEFW4jhvY1iHmKn5fBDpTA47wmyrYJ6k	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$lV2FDnpp7NRIRR5BdRLjhMfQU639aIzIumB6iT8p1ao	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$lV2FDnpp7NRIRR5BdRLjhMfQU639aIzIumB6iT8p1ao	$Z2BDuqYr2x_4RtA8EmelcT41xj-7klcpKFvY5-POfVw	!kmbTYjjsDRDHGgVqUP:localhost
$lV2FDnpp7NRIRR5BdRLjhMfQU639aIzIumB6iT8p1ao	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$lV2FDnpp7NRIRR5BdRLjhMfQU639aIzIumB6iT8p1ao	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$AhmCkSaIYchTfHKz-ScAJNw5JBnITPWbCCQxUwRuIjo	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$AhmCkSaIYchTfHKz-ScAJNw5JBnITPWbCCQxUwRuIjo	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$AhmCkSaIYchTfHKz-ScAJNw5JBnITPWbCCQxUwRuIjo	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$AhmCkSaIYchTfHKz-ScAJNw5JBnITPWbCCQxUwRuIjo	$IUtrl9K7UzIz2Mh8WwC4IwE46CubMgrjKFmHcXBu2Cg	!dKcbdDATuwwphjRPQP:localhost
$th-c5RZ-B0CMnKv9LtzPkBy_JfUuYDy4zUtX-8O9Rzg	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$th-c5RZ-B0CMnKv9LtzPkBy_JfUuYDy4zUtX-8O9Rzg	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$th-c5RZ-B0CMnKv9LtzPkBy_JfUuYDy4zUtX-8O9Rzg	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$th-c5RZ-B0CMnKv9LtzPkBy_JfUuYDy4zUtX-8O9Rzg	$_ZI5M7wMM-QBKHgJHCRJC5LeBkOqglv0DLH3BAuL_mw	!kmbTYjjsDRDHGgVqUP:localhost
$DjME4nek1Vnfgp8JIvyexbgZFnJ7UrCzBWYcgi5DRQE	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$DjME4nek1Vnfgp8JIvyexbgZFnJ7UrCzBWYcgi5DRQE	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$DjME4nek1Vnfgp8JIvyexbgZFnJ7UrCzBWYcgi5DRQE	$0qBcJsMAQpJ663R0qWtkO3DyspiocKFy-urTZsaZ3pw	!dKcbdDATuwwphjRPQP:localhost
$DjME4nek1Vnfgp8JIvyexbgZFnJ7UrCzBWYcgi5DRQE	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$moj2kqPjW9Xd0RBTBX4Ee8HVebtt8aY6J7P3i6UT7qw	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$moj2kqPjW9Xd0RBTBX4Ee8HVebtt8aY6J7P3i6UT7qw	$Z2BDuqYr2x_4RtA8EmelcT41xj-7klcpKFvY5-POfVw	!kmbTYjjsDRDHGgVqUP:localhost
$moj2kqPjW9Xd0RBTBX4Ee8HVebtt8aY6J7P3i6UT7qw	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$moj2kqPjW9Xd0RBTBX4Ee8HVebtt8aY6J7P3i6UT7qw	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$DrKoz6WomICqVeub6PxHnTnu5NbhLDAg2J9rHOxBMmA	$moj2kqPjW9Xd0RBTBX4Ee8HVebtt8aY6J7P3i6UT7qw	!kmbTYjjsDRDHGgVqUP:localhost
$DrKoz6WomICqVeub6PxHnTnu5NbhLDAg2J9rHOxBMmA	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$DrKoz6WomICqVeub6PxHnTnu5NbhLDAg2J9rHOxBMmA	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$DrKoz6WomICqVeub6PxHnTnu5NbhLDAg2J9rHOxBMmA	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$hUQcgu2HJB2PDqWBrqIQkblhG-WvxXaIzHEnXw-Ej30	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$hUQcgu2HJB2PDqWBrqIQkblhG-WvxXaIzHEnXw-Ej30	$uuCt7OoWWYBzi7T3Jte6ntGxol6g760NhRDnyPvGMLA	!dKcbdDATuwwphjRPQP:localhost
$hUQcgu2HJB2PDqWBrqIQkblhG-WvxXaIzHEnXw-Ej30	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$hUQcgu2HJB2PDqWBrqIQkblhG-WvxXaIzHEnXw-Ej30	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$fkjIqV9H5dj_boKqogOxPeFW_m8yxwpxTgr4lSwePDY	$hUQcgu2HJB2PDqWBrqIQkblhG-WvxXaIzHEnXw-Ej30	!dKcbdDATuwwphjRPQP:localhost
$fkjIqV9H5dj_boKqogOxPeFW_m8yxwpxTgr4lSwePDY	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$fkjIqV9H5dj_boKqogOxPeFW_m8yxwpxTgr4lSwePDY	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$fkjIqV9H5dj_boKqogOxPeFW_m8yxwpxTgr4lSwePDY	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$FUJQN-_4fHqBV5emsypqKHRRS0j5jbpMmuarjoIptOg	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$FUJQN-_4fHqBV5emsypqKHRRS0j5jbpMmuarjoIptOg	$Z2BDuqYr2x_4RtA8EmelcT41xj-7klcpKFvY5-POfVw	!kmbTYjjsDRDHGgVqUP:localhost
$FUJQN-_4fHqBV5emsypqKHRRS0j5jbpMmuarjoIptOg	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$FUJQN-_4fHqBV5emsypqKHRRS0j5jbpMmuarjoIptOg	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk	$FUJQN-_4fHqBV5emsypqKHRRS0j5jbpMmuarjoIptOg	!kmbTYjjsDRDHGgVqUP:localhost
$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$fG61faFdiQLdggY7LGhSk_5yDw-HxLQiWURS7cCmAAc	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$fG61faFdiQLdggY7LGhSk_5yDw-HxLQiWURS7cCmAAc	$uuCt7OoWWYBzi7T3Jte6ntGxol6g760NhRDnyPvGMLA	!dKcbdDATuwwphjRPQP:localhost
$fG61faFdiQLdggY7LGhSk_5yDw-HxLQiWURS7cCmAAc	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$fG61faFdiQLdggY7LGhSk_5yDw-HxLQiWURS7cCmAAc	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$ze3RfSNk1D8sruIVbtfFmFdyoNnUgcEoFtM7ULxeWMs	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$ze3RfSNk1D8sruIVbtfFmFdyoNnUgcEoFtM7ULxeWMs	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$ze3RfSNk1D8sruIVbtfFmFdyoNnUgcEoFtM7ULxeWMs	$fG61faFdiQLdggY7LGhSk_5yDw-HxLQiWURS7cCmAAc	!dKcbdDATuwwphjRPQP:localhost
$ze3RfSNk1D8sruIVbtfFmFdyoNnUgcEoFtM7ULxeWMs	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$ifo4xdQDNVXvmkvgnrcj5o9iKblytzWMd_pEcRtWvx8	$fkjIqV9H5dj_boKqogOxPeFW_m8yxwpxTgr4lSwePDY	!dKcbdDATuwwphjRPQP:localhost
$ifo4xdQDNVXvmkvgnrcj5o9iKblytzWMd_pEcRtWvx8	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$ifo4xdQDNVXvmkvgnrcj5o9iKblytzWMd_pEcRtWvx8	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$ifo4xdQDNVXvmkvgnrcj5o9iKblytzWMd_pEcRtWvx8	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$BeKLUYL7qRfgvRH3qg2u6Z41GK2CNQqGwtAmWHwBWjA	$DrKoz6WomICqVeub6PxHnTnu5NbhLDAg2J9rHOxBMmA	!kmbTYjjsDRDHGgVqUP:localhost
$BeKLUYL7qRfgvRH3qg2u6Z41GK2CNQqGwtAmWHwBWjA	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$BeKLUYL7qRfgvRH3qg2u6Z41GK2CNQqGwtAmWHwBWjA	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$BeKLUYL7qRfgvRH3qg2u6Z41GK2CNQqGwtAmWHwBWjA	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$DOD9xnyV6gfI9j6KBsEdTpRu2l62hsRVmc9i6QLcseo	$ifo4xdQDNVXvmkvgnrcj5o9iKblytzWMd_pEcRtWvx8	!dKcbdDATuwwphjRPQP:localhost
$DOD9xnyV6gfI9j6KBsEdTpRu2l62hsRVmc9i6QLcseo	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$DOD9xnyV6gfI9j6KBsEdTpRu2l62hsRVmc9i6QLcseo	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$DOD9xnyV6gfI9j6KBsEdTpRu2l62hsRVmc9i6QLcseo	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$KG18kyO7FM4HavQZH_xZmXGUw1RbyfWhbs-Ds3u5vB8	$BeKLUYL7qRfgvRH3qg2u6Z41GK2CNQqGwtAmWHwBWjA	!kmbTYjjsDRDHGgVqUP:localhost
$KG18kyO7FM4HavQZH_xZmXGUw1RbyfWhbs-Ds3u5vB8	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$KG18kyO7FM4HavQZH_xZmXGUw1RbyfWhbs-Ds3u5vB8	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$KG18kyO7FM4HavQZH_xZmXGUw1RbyfWhbs-Ds3u5vB8	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$sT18sK2FK6Bo7161sdufjmhywK9CsJHemT-D6fDbaWs	$DOD9xnyV6gfI9j6KBsEdTpRu2l62hsRVmc9i6QLcseo	!dKcbdDATuwwphjRPQP:localhost
$sT18sK2FK6Bo7161sdufjmhywK9CsJHemT-D6fDbaWs	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$sT18sK2FK6Bo7161sdufjmhywK9CsJHemT-D6fDbaWs	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$sT18sK2FK6Bo7161sdufjmhywK9CsJHemT-D6fDbaWs	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$d05l2i-Vc2Zzx3bl0Vz-NnDVVhxgFQIctiPfGoz0Xjs	$KG18kyO7FM4HavQZH_xZmXGUw1RbyfWhbs-Ds3u5vB8	!kmbTYjjsDRDHGgVqUP:localhost
$d05l2i-Vc2Zzx3bl0Vz-NnDVVhxgFQIctiPfGoz0Xjs	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$d05l2i-Vc2Zzx3bl0Vz-NnDVVhxgFQIctiPfGoz0Xjs	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$d05l2i-Vc2Zzx3bl0Vz-NnDVVhxgFQIctiPfGoz0Xjs	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$CcTsy5iCDZyphUv5irDLp85iBq-btwDvTJahbK5ATzo	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$CcTsy5iCDZyphUv5irDLp85iBq-btwDvTJahbK5ATzo	$d05l2i-Vc2Zzx3bl0Vz-NnDVVhxgFQIctiPfGoz0Xjs	!kmbTYjjsDRDHGgVqUP:localhost
$CcTsy5iCDZyphUv5irDLp85iBq-btwDvTJahbK5ATzo	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$CcTsy5iCDZyphUv5irDLp85iBq-btwDvTJahbK5ATzo	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$0F5VtbBOxf2d2OwQ46I3LM3tqAkj2YWFXSKWzfzdtT8	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$0F5VtbBOxf2d2OwQ46I3LM3tqAkj2YWFXSKWzfzdtT8	$sT18sK2FK6Bo7161sdufjmhywK9CsJHemT-D6fDbaWs	!dKcbdDATuwwphjRPQP:localhost
$0F5VtbBOxf2d2OwQ46I3LM3tqAkj2YWFXSKWzfzdtT8	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$0F5VtbBOxf2d2OwQ46I3LM3tqAkj2YWFXSKWzfzdtT8	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
\.


--
-- Data for Name: event_auth_chain_links; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_auth_chain_links (origin_chain_id, origin_sequence_number, target_chain_id, target_sequence_number) FROM stdin;
8	1	10	1
4	1	17	1
7	1	8	1
16	1	17	1
15	1	13	1
2	1	1	1
17	1	1	1
7	1	10	1
9	1	13	1
17	1	3	1
7	1	12	1
4	1	1	1
2	1	14	1
2	1	3	1
13	1	8	1
17	1	14	1
13	1	10	1
5	1	17	1
13	1	12	1
4	1	14	1
16	1	1	1
4	1	3	1
15	1	8	1
18	1	14	1
12	1	8	1
16	1	3	1
16	1	14	1
15	1	10	1
9	1	8	1
11	1	10	1
18	1	1	1
6	1	8	1
18	1	3	1
6	1	10	1
5	1	14	1
5	1	1	1
14	1	1	1
3	1	1	1
15	1	12	1
9	1	12	1
12	1	10	1
9	1	10	1
7	1	13	1
11	1	8	1
6	1	12	1
5	1	3	1
14	1	3	1
11	1	12	1
19	1	8	1
19	1	12	1
19	1	10	1
19	1	13	1
20	1	17	1
20	1	14	1
20	1	3	1
20	1	1	1
21	1	1	1
21	1	14	1
21	1	20	1
21	1	17	1
21	1	3	1
22	1	10	1
22	1	13	1
22	1	12	1
22	1	19	1
22	1	8	1
23	1	14	1
23	1	17	1
23	1	3	1
23	1	20	1
23	1	1	1
24	1	12	1
24	1	13	1
24	1	8	1
24	1	19	1
24	1	10	1
25	1	19	1
25	1	12	1
25	1	10	1
25	1	13	1
25	1	8	1
26	1	20	1
26	1	17	1
26	1	3	1
26	1	14	1
26	1	1	1
27	1	8	1
27	1	12	1
27	1	19	1
27	1	10	1
27	1	13	1
28	1	17	1
28	1	3	1
28	1	20	1
28	1	1	1
28	1	14	1
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
$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	1	1
$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA	3	1
$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	14	1
$TVnvv0nGbLydCBtMmTTz-htMsoI4hmxCr3s9AHyFGHQ	18	1
$b__a7rX3L5YpX7nAZte73DAbjtXZK48JH8VKSnGOKKw	2	1
$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	17	1
$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0	5	1
$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A	16	1
$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	10	1
$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw	8	1
$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	12	1
$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	13	1
$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8	15	1
$O5iO4EII22igkDq5cMKHFB-SGIYD0KqJQXZohS2Dzc0	11	1
$X8tdoEsXAgBC6gobCepAn3rwO8CJoQU6i9NN9Rzhukg	6	1
$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	7	1
$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk	9	1
$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0	4	1
$Z2BDuqYr2x_4RtA8EmelcT41xj-7klcpKFvY5-POfVw	19	1
$uuCt7OoWWYBzi7T3Jte6ntGxol6g760NhRDnyPvGMLA	20	1
$IUtrl9K7UzIz2Mh8WwC4IwE46CubMgrjKFmHcXBu2Cg	21	1
$_ZI5M7wMM-QBKHgJHCRJC5LeBkOqglv0DLH3BAuL_mw	22	1
$0qBcJsMAQpJ663R0qWtkO3DyspiocKFy-urTZsaZ3pw	23	1
$lV2FDnpp7NRIRR5BdRLjhMfQU639aIzIumB6iT8p1ao	24	1
$AhmCkSaIYchTfHKz-ScAJNw5JBnITPWbCCQxUwRuIjo	21	2
$th-c5RZ-B0CMnKv9LtzPkBy_JfUuYDy4zUtX-8O9Rzg	22	2
$DjME4nek1Vnfgp8JIvyexbgZFnJ7UrCzBWYcgi5DRQE	23	2
$wttc0xGxavZKEFW4jhvY1iHmKn5fBDpTA47wmyrYJ6k	24	2
$moj2kqPjW9Xd0RBTBX4Ee8HVebtt8aY6J7P3i6UT7qw	25	1
$DrKoz6WomICqVeub6PxHnTnu5NbhLDAg2J9rHOxBMmA	25	2
$hUQcgu2HJB2PDqWBrqIQkblhG-WvxXaIzHEnXw-Ej30	26	1
$fkjIqV9H5dj_boKqogOxPeFW_m8yxwpxTgr4lSwePDY	26	2
$FUJQN-_4fHqBV5emsypqKHRRS0j5jbpMmuarjoIptOg	27	1
$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk	27	2
$fG61faFdiQLdggY7LGhSk_5yDw-HxLQiWURS7cCmAAc	28	1
$ze3RfSNk1D8sruIVbtfFmFdyoNnUgcEoFtM7ULxeWMs	28	2
$ifo4xdQDNVXvmkvgnrcj5o9iKblytzWMd_pEcRtWvx8	26	3
$BeKLUYL7qRfgvRH3qg2u6Z41GK2CNQqGwtAmWHwBWjA	25	3
$DOD9xnyV6gfI9j6KBsEdTpRu2l62hsRVmc9i6QLcseo	26	4
$KG18kyO7FM4HavQZH_xZmXGUw1RbyfWhbs-Ds3u5vB8	25	4
$sT18sK2FK6Bo7161sdufjmhywK9CsJHemT-D6fDbaWs	26	5
$d05l2i-Vc2Zzx3bl0Vz-NnDVVhxgFQIctiPfGoz0Xjs	25	5
$CcTsy5iCDZyphUv5irDLp85iBq-btwDvTJahbK5ATzo	25	6
$0F5VtbBOxf2d2OwQ46I3LM3tqAkj2YWFXSKWzfzdtT8	26	6
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
$Z2BDuqYr2x_4RtA8EmelcT41xj-7klcpKFvY5-POfVw	$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	!kmbTYjjsDRDHGgVqUP:localhost	f
$uuCt7OoWWYBzi7T3Jte6ntGxol6g760NhRDnyPvGMLA	$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A	!dKcbdDATuwwphjRPQP:localhost	f
$IUtrl9K7UzIz2Mh8WwC4IwE46CubMgrjKFmHcXBu2Cg	$uuCt7OoWWYBzi7T3Jte6ntGxol6g760NhRDnyPvGMLA	!dKcbdDATuwwphjRPQP:localhost	f
$_ZI5M7wMM-QBKHgJHCRJC5LeBkOqglv0DLH3BAuL_mw	$Z2BDuqYr2x_4RtA8EmelcT41xj-7klcpKFvY5-POfVw	!kmbTYjjsDRDHGgVqUP:localhost	f
$0qBcJsMAQpJ663R0qWtkO3DyspiocKFy-urTZsaZ3pw	$IUtrl9K7UzIz2Mh8WwC4IwE46CubMgrjKFmHcXBu2Cg	!dKcbdDATuwwphjRPQP:localhost	f
$lV2FDnpp7NRIRR5BdRLjhMfQU639aIzIumB6iT8p1ao	$_ZI5M7wMM-QBKHgJHCRJC5LeBkOqglv0DLH3BAuL_mw	!kmbTYjjsDRDHGgVqUP:localhost	f
$AhmCkSaIYchTfHKz-ScAJNw5JBnITPWbCCQxUwRuIjo	$0qBcJsMAQpJ663R0qWtkO3DyspiocKFy-urTZsaZ3pw	!dKcbdDATuwwphjRPQP:localhost	f
$th-c5RZ-B0CMnKv9LtzPkBy_JfUuYDy4zUtX-8O9Rzg	$lV2FDnpp7NRIRR5BdRLjhMfQU639aIzIumB6iT8p1ao	!kmbTYjjsDRDHGgVqUP:localhost	f
$DjME4nek1Vnfgp8JIvyexbgZFnJ7UrCzBWYcgi5DRQE	$AhmCkSaIYchTfHKz-ScAJNw5JBnITPWbCCQxUwRuIjo	!dKcbdDATuwwphjRPQP:localhost	f
$wttc0xGxavZKEFW4jhvY1iHmKn5fBDpTA47wmyrYJ6k	$th-c5RZ-B0CMnKv9LtzPkBy_JfUuYDy4zUtX-8O9Rzg	!kmbTYjjsDRDHGgVqUP:localhost	f
$moj2kqPjW9Xd0RBTBX4Ee8HVebtt8aY6J7P3i6UT7qw	$wttc0xGxavZKEFW4jhvY1iHmKn5fBDpTA47wmyrYJ6k	!kmbTYjjsDRDHGgVqUP:localhost	f
$DrKoz6WomICqVeub6PxHnTnu5NbhLDAg2J9rHOxBMmA	$moj2kqPjW9Xd0RBTBX4Ee8HVebtt8aY6J7P3i6UT7qw	!kmbTYjjsDRDHGgVqUP:localhost	f
$hUQcgu2HJB2PDqWBrqIQkblhG-WvxXaIzHEnXw-Ej30	$DjME4nek1Vnfgp8JIvyexbgZFnJ7UrCzBWYcgi5DRQE	!dKcbdDATuwwphjRPQP:localhost	f
$fkjIqV9H5dj_boKqogOxPeFW_m8yxwpxTgr4lSwePDY	$hUQcgu2HJB2PDqWBrqIQkblhG-WvxXaIzHEnXw-Ej30	!dKcbdDATuwwphjRPQP:localhost	f
$FUJQN-_4fHqBV5emsypqKHRRS0j5jbpMmuarjoIptOg	$DrKoz6WomICqVeub6PxHnTnu5NbhLDAg2J9rHOxBMmA	!kmbTYjjsDRDHGgVqUP:localhost	f
$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk	$FUJQN-_4fHqBV5emsypqKHRRS0j5jbpMmuarjoIptOg	!kmbTYjjsDRDHGgVqUP:localhost	f
$fG61faFdiQLdggY7LGhSk_5yDw-HxLQiWURS7cCmAAc	$fkjIqV9H5dj_boKqogOxPeFW_m8yxwpxTgr4lSwePDY	!dKcbdDATuwwphjRPQP:localhost	f
$ze3RfSNk1D8sruIVbtfFmFdyoNnUgcEoFtM7ULxeWMs	$fG61faFdiQLdggY7LGhSk_5yDw-HxLQiWURS7cCmAAc	!dKcbdDATuwwphjRPQP:localhost	f
$ifo4xdQDNVXvmkvgnrcj5o9iKblytzWMd_pEcRtWvx8	$ze3RfSNk1D8sruIVbtfFmFdyoNnUgcEoFtM7ULxeWMs	!dKcbdDATuwwphjRPQP:localhost	f
$BeKLUYL7qRfgvRH3qg2u6Z41GK2CNQqGwtAmWHwBWjA	$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk	!kmbTYjjsDRDHGgVqUP:localhost	f
$DOD9xnyV6gfI9j6KBsEdTpRu2l62hsRVmc9i6QLcseo	$ifo4xdQDNVXvmkvgnrcj5o9iKblytzWMd_pEcRtWvx8	!dKcbdDATuwwphjRPQP:localhost	f
$KG18kyO7FM4HavQZH_xZmXGUw1RbyfWhbs-Ds3u5vB8	$BeKLUYL7qRfgvRH3qg2u6Z41GK2CNQqGwtAmWHwBWjA	!kmbTYjjsDRDHGgVqUP:localhost	f
$FVhXs60ZUT4hfp8SPDQiJ9sUL5CV4MjGIsUfequDwEE	$KG18kyO7FM4HavQZH_xZmXGUw1RbyfWhbs-Ds3u5vB8	!kmbTYjjsDRDHGgVqUP:localhost	f
$MSYX67PL-aQgpnMS30mo0OLCFY11arvS2Ehe0I0SNAg	$FVhXs60ZUT4hfp8SPDQiJ9sUL5CV4MjGIsUfequDwEE	!kmbTYjjsDRDHGgVqUP:localhost	f
$NDRnMTvwTgCFfTb_vFmNwNe1o4a-UnPMEHKYvBFg1Ms	$DOD9xnyV6gfI9j6KBsEdTpRu2l62hsRVmc9i6QLcseo	!dKcbdDATuwwphjRPQP:localhost	f
$sT18sK2FK6Bo7161sdufjmhywK9CsJHemT-D6fDbaWs	$NDRnMTvwTgCFfTb_vFmNwNe1o4a-UnPMEHKYvBFg1Ms	!dKcbdDATuwwphjRPQP:localhost	f
$d05l2i-Vc2Zzx3bl0Vz-NnDVVhxgFQIctiPfGoz0Xjs	$MSYX67PL-aQgpnMS30mo0OLCFY11arvS2Ehe0I0SNAg	!kmbTYjjsDRDHGgVqUP:localhost	f
$jsgSLDcqxEQROuyA6P2myIoJf5N1kGLS_n8iWXwE-nU	$sT18sK2FK6Bo7161sdufjmhywK9CsJHemT-D6fDbaWs	!dKcbdDATuwwphjRPQP:localhost	f
$vg3binnx1kEog3C9nqvwJ7qPu28sTqYrZDssk0vab-Q	$jsgSLDcqxEQROuyA6P2myIoJf5N1kGLS_n8iWXwE-nU	!dKcbdDATuwwphjRPQP:localhost	f
$YMb8Q2a5Xbnn70ZtQxPIimfv3Y9zSC67zsDIdEsRFJw	$vg3binnx1kEog3C9nqvwJ7qPu28sTqYrZDssk0vab-Q	!dKcbdDATuwwphjRPQP:localhost	f
$d8OJKkkhp47jknk_LHO0c3d0-CSNWMzpJBRw6bOrQ4M	$YMb8Q2a5Xbnn70ZtQxPIimfv3Y9zSC67zsDIdEsRFJw	!dKcbdDATuwwphjRPQP:localhost	f
$obESo5AynBeb9xLH4sESBL5g-segSsJGjC9XER9ZTt8	$d8OJKkkhp47jknk_LHO0c3d0-CSNWMzpJBRw6bOrQ4M	!dKcbdDATuwwphjRPQP:localhost	f
$CcTsy5iCDZyphUv5irDLp85iBq-btwDvTJahbK5ATzo	$d05l2i-Vc2Zzx3bl0Vz-NnDVVhxgFQIctiPfGoz0Xjs	!kmbTYjjsDRDHGgVqUP:localhost	f
$0F5VtbBOxf2d2OwQ46I3LM3tqAkj2YWFXSKWzfzdtT8	$obESo5AynBeb9xLH4sESBL5g-segSsJGjC9XER9ZTt8	!dKcbdDATuwwphjRPQP:localhost	f
$LkEO2DXJWjTGSlo7iokDO6KvigtD7BtSYgzN1bHF2q0	$0F5VtbBOxf2d2OwQ46I3LM3tqAkj2YWFXSKWzfzdtT8	!dKcbdDATuwwphjRPQP:localhost	f
$RBYjw0bWPMbVEg8csvMs4tPORoqreh7W0cTgJTDKhxQ	$LkEO2DXJWjTGSlo7iokDO6KvigtD7BtSYgzN1bHF2q0	!dKcbdDATuwwphjRPQP:localhost	f
$3J0wiu01NbTrOfOGZgRjSdNtX0P7ZN-PQp8qKcLDlmY	$RBYjw0bWPMbVEg8csvMs4tPORoqreh7W0cTgJTDKhxQ	!dKcbdDATuwwphjRPQP:localhost	f
$qpoohVqO3c0vYCNBJuvRZHkBBNPQSrgwVwzIcbCfJJk	$3J0wiu01NbTrOfOGZgRjSdNtX0P7ZN-PQp8qKcLDlmY	!dKcbdDATuwwphjRPQP:localhost	f
$FLa6I56u6EmzKm7SjplLhqPxGUZeJy_gEayv25svMwc	$qpoohVqO3c0vYCNBJuvRZHkBBNPQSrgwVwzIcbCfJJk	!dKcbdDATuwwphjRPQP:localhost	f
$uVCWC5TSVmmOhtnjhBprXQIqqNMmjlwAjnAbCFWCmSM	$CcTsy5iCDZyphUv5irDLp85iBq-btwDvTJahbK5ATzo	!kmbTYjjsDRDHGgVqUP:localhost	f
$ze3rHWp4q76u5HD9VeEM4tmvDPVyEGXfJ16m3GKAPBA	$uVCWC5TSVmmOhtnjhBprXQIqqNMmjlwAjnAbCFWCmSM	!kmbTYjjsDRDHGgVqUP:localhost	f
$wQdEIjcFyopFZpNGXmYD7mGBK2vx6nRTZFbp0tUAS5s	$ze3rHWp4q76u5HD9VeEM4tmvDPVyEGXfJ16m3GKAPBA	!kmbTYjjsDRDHGgVqUP:localhost	f
$vCLF-PjgFkWDlv9RC2q7AbemDp5Aq_wTHx26K7fVT2k	$wQdEIjcFyopFZpNGXmYD7mGBK2vx6nRTZFbp0tUAS5s	!kmbTYjjsDRDHGgVqUP:localhost	f
$CtsCO4y6Ci5lqltxoUXJqrNNDD4LeUErcBMp_5KFwdU	$vCLF-PjgFkWDlv9RC2q7AbemDp5Aq_wTHx26K7fVT2k	!kmbTYjjsDRDHGgVqUP:localhost	f
$8AX5D9nuhWswBU_Fc227Rvda1dcYTL38k5-nu5LYeow	$CtsCO4y6Ci5lqltxoUXJqrNNDD4LeUErcBMp_5KFwdU	!kmbTYjjsDRDHGgVqUP:localhost	f
$C_yOhTrkIxQT1pPwVX1TWe0UBFqH59o0aetXDnxNbb4	$8AX5D9nuhWswBU_Fc227Rvda1dcYTL38k5-nu5LYeow	!kmbTYjjsDRDHGgVqUP:localhost	f
$7tsqPssEA6U65Qrd44F9FbFLND-JhznQ_c-4bXrIlRE	$C_yOhTrkIxQT1pPwVX1TWe0UBFqH59o0aetXDnxNbb4	!kmbTYjjsDRDHGgVqUP:localhost	f
$D4biAJRc__54ONgjSEAYBzE8_j1ePGCqni93Os3tKhM	$7tsqPssEA6U65Qrd44F9FbFLND-JhznQ_c-4bXrIlRE	!kmbTYjjsDRDHGgVqUP:localhost	f
$GPeeyjoIFFM1Mp_pvKB55ZyVVmuSxQ3czNsjj5VxcZs	$D4biAJRc__54ONgjSEAYBzE8_j1ePGCqni93Os3tKhM	!kmbTYjjsDRDHGgVqUP:localhost	f
$qIPcuD0d9eSflKKATXSbTJjoKFIBzNFk28nuN3007zo	$GPeeyjoIFFM1Mp_pvKB55ZyVVmuSxQ3czNsjj5VxcZs	!kmbTYjjsDRDHGgVqUP:localhost	f
$ge07snxHDhIl87w9HhFEY0Vf4fZF7sfC8ZgYVajdyBQ	$qIPcuD0d9eSflKKATXSbTJjoKFIBzNFk28nuN3007zo	!kmbTYjjsDRDHGgVqUP:localhost	f
$8u1nGQdQsFC_o-G3u1FrKnqITkatzs7OCMMVEir7wnk	$ge07snxHDhIl87w9HhFEY0Vf4fZF7sfC8ZgYVajdyBQ	!kmbTYjjsDRDHGgVqUP:localhost	f
$-F2yj6IuC13Z2Eri3_-fsH3NLCQXQ1igRElx9-Op2x4	$8u1nGQdQsFC_o-G3u1FrKnqITkatzs7OCMMVEir7wnk	!kmbTYjjsDRDHGgVqUP:localhost	f
$iKj1OUBZW17_u23PJes2dsEtLEQhEZBWblS4q6rzsjU	$-F2yj6IuC13Z2Eri3_-fsH3NLCQXQ1igRElx9-Op2x4	!kmbTYjjsDRDHGgVqUP:localhost	f
$_aHR2VH_SqifxgVILz9ZPES5I390wFZQHGdjrgNSekM	$iKj1OUBZW17_u23PJes2dsEtLEQhEZBWblS4q6rzsjU	!kmbTYjjsDRDHGgVqUP:localhost	f
$v72gLcqi6Rs213KYj3Q9EwPHikqyQNxPsM2PYcEx_yI	$_aHR2VH_SqifxgVILz9ZPES5I390wFZQHGdjrgNSekM	!kmbTYjjsDRDHGgVqUP:localhost	f
$IF1JZZiHama5s_UHEDM0Lrd52rDP-14jwiiT7xvm8gk	$v72gLcqi6Rs213KYj3Q9EwPHikqyQNxPsM2PYcEx_yI	!kmbTYjjsDRDHGgVqUP:localhost	f
$nlOfoVdX08P1v2RQ_i1jakYQkuf0y1MGWr21M4pjQJU	$IF1JZZiHama5s_UHEDM0Lrd52rDP-14jwiiT7xvm8gk	!kmbTYjjsDRDHGgVqUP:localhost	f
$AUKXpVUFnYNqEkGgCvdFpbjbYc6RVwJa6Lu4v1LGoBs	$nlOfoVdX08P1v2RQ_i1jakYQkuf0y1MGWr21M4pjQJU	!kmbTYjjsDRDHGgVqUP:localhost	f
$1mBKLzxWBgLuS89oa3fbkVxTj_bUJ5krnjvFIGrcU2k	$AUKXpVUFnYNqEkGgCvdFpbjbYc6RVwJa6Lu4v1LGoBs	!kmbTYjjsDRDHGgVqUP:localhost	f
$7mzkMAeImEcLYZGgGfqB1GHgCADF4xGJ7B-eojgjum4	$1mBKLzxWBgLuS89oa3fbkVxTj_bUJ5krnjvFIGrcU2k	!kmbTYjjsDRDHGgVqUP:localhost	f
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
$FLa6I56u6EmzKm7SjplLhqPxGUZeJy_gEayv25svMwc	!dKcbdDATuwwphjRPQP:localhost
$7mzkMAeImEcLYZGgGfqB1GHgCADF4xGJ7B-eojgjum4	!kmbTYjjsDRDHGgVqUP:localhost
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
$3J0wiu01NbTrOfOGZgRjSdNtX0P7ZN-PQp8qKcLDlmY	!dKcbdDATuwwphjRPQP:localhost	{"txn_id":"m1672681275663.2","historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$ze3RfSNk1D8sruIVbtfFmFdyoNnUgcEoFtM7ULxeWMs"],"prev_events":["$RBYjw0bWPMbVEg8csvMs4tPORoqreh7W0cTgJTDKhxQ"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_bridgeuser2:localhost","content":{"msgtype":"m.text","body":"pl"},"depth":31,"prev_state":[],"origin":"localhost","origin_server_ts":1672681275706,"hashes":{"sha256":"g+lR3P6EJnXRc0TnAZrgBhFPQcPFCzDA3T1BXvIRKLA"},"signatures":{"localhost":{"ed25519:a_CHdg":"Mr2eHE4lklRDRAexRBzC8txV7tZazr/U3KU5s01KOnnxL5YYXWpgFTVNNqs9uREl5ESJo5hYXjwfJJ5LcXTPCA"}},"unsigned":{"age_ts":1672681275706}}	3
$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id": 5, "stream_ordering": 18}	{"auth_events": ["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w", "$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o", "$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"], "prev_events": ["$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk"], "type": "m.room.member", "room_id": "!kmbTYjjsDRDHGgVqUP:localhost", "sender": "@ignored_user:localhost", "content": {"membership": "join", "displayname": "ignored_user"}, "depth": 9, "prev_state": [], "state_key": "@ignored_user:localhost", "origin": "localhost", "origin_server_ts": 1598686328575, "hashes": {"sha256": "D/rwxkYqWZ03Kws7Xsq84khdp4oGHRGnOy4+XwM8dLA"}, "signatures": {"localhost": {"ed25519:a_snHR": "kXK8xKjLjJ97KcFQivelEBI1TR/au+bgtD6i2VPDp9LjRi1bVH/zb6YqHZetT0JYaGt3NY4iFeN0Qh0mD4zyAg"}}, "unsigned": {"age_ts": 1598686328575}}	3
$Z2BDuqYr2x_4RtA8EmelcT41xj-7klcpKFvY5-POfVw	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"depth":10,"prev_state":[],"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1672674596102,"hashes":{"sha256":"8ixY5uz/AlKQx8yzZH9/nyWXXfQoKUoebWoa+tIQWzM"},"signatures":{"localhost":{"ed25519:a_CHdg":"lL5eaNGdLNKTWZg/U4g1ssEPnMTlPVs1nc/60tcLJzV0KtqE9AhWwu0Gyq6gyFwVsbzNkpboVwzDyMJlmKQBAw"}},"unsigned":{"age_ts":1672674596102}}	3
$uuCt7OoWWYBzi7T3Jte6ntGxol6g760NhRDnyPvGMLA	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"depth":10,"prev_state":[],"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1672674596091,"hashes":{"sha256":"K2rb3Yx8LpS/hIZmAkURutYQ3oZ6AFjm62i9FVuC2sU"},"signatures":{"localhost":{"ed25519:a_CHdg":"Hu5dd1pHAfyckKpRQMKVnPBLEcfsJCtqFu5s9tDZPME7ns3hnigII5ySrcNR4rRZOI4NMkDpxZfwIiT2Qf7qAQ"}},"unsigned":{"age_ts":1672674596091}}	3
$IUtrl9K7UzIz2Mh8WwC4IwE46CubMgrjKFmHcXBu2Cg	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$uuCt7OoWWYBzi7T3Jte6ntGxol6g760NhRDnyPvGMLA","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs"],"prev_events":["$uuCt7OoWWYBzi7T3Jte6ntGxol6g760NhRDnyPvGMLA"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"mattermost_b [mm]"},"depth":11,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672674602948,"hashes":{"sha256":"FHw2AOBjUJEKIQN538hHyDhXEiGfx/tk6BUgVofky9U"},"signatures":{"localhost":{"ed25519:a_CHdg":"RWytlP4KmhDwBLYCvGzJbwERudqHVxiVPUbH7T67ciKZqZfmulTtpkL2E9ks+gQupZJsFd09qrBeCcZqO63SAw"}},"unsigned":{"age_ts":1672674602948,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#off-topic:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$_ZI5M7wMM-QBKHgJHCRJC5LeBkOqglv0DLH3BAuL_mw	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$Z2BDuqYr2x_4RtA8EmelcT41xj-7klcpKFvY5-POfVw","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o"],"prev_events":["$Z2BDuqYr2x_4RtA8EmelcT41xj-7klcpKFvY5-POfVw"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"mattermost_b [mm]"},"depth":11,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672674603192,"hashes":{"sha256":"X/vBBTGqBm1cFnl/a3KMUtA+/tPffd33KPhQ00vj3/g"},"signatures":{"localhost":{"ed25519:a_CHdg":"fP+6vsgqZFEIYuR5ACvihSI6lCIFTx4uHmGss9JRnXHLS/dHbJOCmvPBAfHlX5oV+Al6MpuIDBOtUande8dkDg"}},"unsigned":{"age_ts":1672674603192,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#town-square:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$0qBcJsMAQpJ663R0qWtkO3DyspiocKFy-urTZsaZ3pw	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$uuCt7OoWWYBzi7T3Jte6ntGxol6g760NhRDnyPvGMLA","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs"],"prev_events":["$IUtrl9K7UzIz2Mh8WwC4IwE46CubMgrjKFmHcXBu2Cg"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"MattermostUser A [mm]"},"depth":12,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672674603303,"hashes":{"sha256":"cgJytfB1a7l+lue5kdn6ef0QEh70V6acSGQY8HiNeSU"},"signatures":{"localhost":{"ed25519:a_CHdg":"e7zjhKE7K0uB3C80JSIV6FSdlYRMa3Kl/tGBKFaSgk0w8FlRa9pS3w2lcpZ81ghJY/UGnCdgfM35EWy0WGl8Cg"}},"unsigned":{"age_ts":1672674603303,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#off-topic:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$th-c5RZ-B0CMnKv9LtzPkBy_JfUuYDy4zUtX-8O9Rzg	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$_ZI5M7wMM-QBKHgJHCRJC5LeBkOqglv0DLH3BAuL_mw"],"prev_events":["$lV2FDnpp7NRIRR5BdRLjhMfQU639aIzIumB6iT8p1ao"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_b:localhost","content":{"membership":"join","displayname":"mattermost_b [mm]"},"depth":13,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672674603703,"hashes":{"sha256":"leIv6JfvPC8trHNoysjV/goEKTZNhUS1P3/7fix6Jro"},"signatures":{"localhost":{"ed25519:a_CHdg":"cWYXjIdU1hTmFyilXl6d7IbwanyCFzbuOYSVE2WSYyezQFTVz0AAQN8w/D86I9XxWQg2S5Cbp58yv1C36M3kDg"}},"unsigned":{"age_ts":1672674603703,"replaces_state":"$_ZI5M7wMM-QBKHgJHCRJC5LeBkOqglv0DLH3BAuL_mw"}}	3
$lV2FDnpp7NRIRR5BdRLjhMfQU639aIzIumB6iT8p1ao	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$Z2BDuqYr2x_4RtA8EmelcT41xj-7klcpKFvY5-POfVw","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o"],"prev_events":["$_ZI5M7wMM-QBKHgJHCRJC5LeBkOqglv0DLH3BAuL_mw"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"MattermostUser A [mm]"},"depth":12,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672674603466,"hashes":{"sha256":"Zb4x3rjuY4lW03SeQaXzTgvyFlzQf9P/zEEXMfcpjJc"},"signatures":{"localhost":{"ed25519:a_CHdg":"C8hNqgzE1gTz1641JSdHuzQsdKfIWjAlZ1hdJkrTzrn6QePYOCB6ur1Mc3Pdq4qsgSWl0NfySgAh+h923v9KCg"}},"unsigned":{"age_ts":1672674603466,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#town-square:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$AhmCkSaIYchTfHKz-ScAJNw5JBnITPWbCCQxUwRuIjo	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$IUtrl9K7UzIz2Mh8WwC4IwE46CubMgrjKFmHcXBu2Cg"],"prev_events":["$0qBcJsMAQpJ663R0qWtkO3DyspiocKFy-urTZsaZ3pw"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_b:localhost","content":{"membership":"join","displayname":"mattermost_b [mm]"},"depth":13,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672674603569,"hashes":{"sha256":"6lqU7siZTpDjOwKtIYRXvlqdhJvTzcfsBG7Z3tbwf+w"},"signatures":{"localhost":{"ed25519:a_CHdg":"EFCdZAF9Rx26V5clzECT0rjtj8JlIjb/lq0zxn/tYkjI4vp+Oz00p3uuF+Fnk/c4L8yJM7yDVPsaKTt3sgqABA"}},"unsigned":{"age_ts":1672674603569,"replaces_state":"$IUtrl9K7UzIz2Mh8WwC4IwE46CubMgrjKFmHcXBu2Cg"}}	3
$DjME4nek1Vnfgp8JIvyexbgZFnJ7UrCzBWYcgi5DRQE	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$0qBcJsMAQpJ663R0qWtkO3DyspiocKFy-urTZsaZ3pw","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$AhmCkSaIYchTfHKz-ScAJNw5JBnITPWbCCQxUwRuIjo"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_a:localhost","content":{"membership":"join","displayname":"MattermostUser A [mm]"},"depth":14,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672674603823,"hashes":{"sha256":"AEl+/ztMFaoxVSyFiJPEEPsUm4nu9w9aFxXMXnB+vQU"},"signatures":{"localhost":{"ed25519:a_CHdg":"vRdMwS67lnpkApMgofsQZ8LVsi32zfiqiqjMmy/7RLmOEdpO2BCSPDDSUCqF3acQGPP34WGVduPWn3EioGpHCQ"}},"unsigned":{"age_ts":1672674603823,"replaces_state":"$0qBcJsMAQpJ663R0qWtkO3DyspiocKFy-urTZsaZ3pw"}}	3
$fG61faFdiQLdggY7LGhSk_5yDw-HxLQiWURS7cCmAAc	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$uuCt7OoWWYBzi7T3Jte6ntGxol6g760NhRDnyPvGMLA","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs"],"prev_events":["$fkjIqV9H5dj_boKqogOxPeFW_m8yxwpxTgr4lSwePDY"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"bridgeuser2 [mm]"},"depth":17,"prev_state":[],"state_key":"@mm_bridgeuser2:localhost","origin":"localhost","origin_server_ts":1672675304507,"hashes":{"sha256":"SyFgL/N/LiDMScYl9yc399ZenwpPS5bOTfPPZT3N/Bo"},"signatures":{"localhost":{"ed25519:a_CHdg":"QsdNTbr5BlsFMTCIc4VfcVPB3V/UAKqn1hfHo/8CfdB3NV46bE39DEqhugPWQeExxfH+sObE2mz22l5UQAxiDA"}},"unsigned":{"age_ts":1672675304507,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#off-topic:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$ifo4xdQDNVXvmkvgnrcj5o9iKblytzWMd_pEcRtWvx8	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$fkjIqV9H5dj_boKqogOxPeFW_m8yxwpxTgr4lSwePDY","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$ze3RfSNk1D8sruIVbtfFmFdyoNnUgcEoFtM7ULxeWMs"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_bridgeuser1:localhost","content":{"membership":"join","displayname":"mm_bridgeuser1"},"depth":19,"prev_state":[],"state_key":"@mm_bridgeuser1:localhost","origin":"localhost","origin_server_ts":1672676284187,"hashes":{"sha256":"jZMPnXuEg3WjEBSZ86YWuZL9n7eDiiStTRojghaHEyg"},"signatures":{"localhost":{"ed25519:a_CHdg":"gQxQ4USJW0GsCQPR2cjgvMCvzJuDI8255C3kQHUe0pPYpuDr/NHEN89qClYBukA7EDMUZ5od0cJ3LQ3wE+j6Aw"}},"unsigned":{"age_ts":1672676284187,"replaces_state":"$fkjIqV9H5dj_boKqogOxPeFW_m8yxwpxTgr4lSwePDY"}}	3
$YMb8Q2a5Xbnn70ZtQxPIimfv3Y9zSC67zsDIdEsRFJw	!dKcbdDATuwwphjRPQP:localhost	{"token_id":17,"txn_id":"m1672678315021.0","historical":false}	{"auth_events":["$sT18sK2FK6Bo7161sdufjmhywK9CsJHemT-D6fDbaWs","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$vg3binnx1kEog3C9nqvwJ7qPu28sTqYrZDssk0vab-Q"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_bridgeuser1:localhost","content":{"org.matrix.msc1767.text":"klk","body":"klk","msgtype":"m.text"},"depth":25,"prev_state":[],"origin":"localhost","origin_server_ts":1672678315133,"hashes":{"sha256":"1puJ1RZHDilnMQcGCCspxw1IuApAkMfk1eJ3U3QCsNU"},"signatures":{"localhost":{"ed25519:a_CHdg":"rfdbMnTCB/DJ9cA6wGg/nBUqnJpirBY+ryZRnivnlc28ecyEuRDT1tzaws6/e+UOTHkcJdZZIiHUMDF35NLjBQ"}},"unsigned":{"age_ts":1672678315133}}	3
$obESo5AynBeb9xLH4sESBL5g-segSsJGjC9XER9ZTt8	!dKcbdDATuwwphjRPQP:localhost	{"token_id":18,"txn_id":"m1672678428246.0","historical":false}	{"auth_events":["$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$d8OJKkkhp47jknk_LHO0c3d0-CSNWMzpJBRw6bOrQ4M"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"org.matrix.msc1767.text":"By e bye","body":"By e bye","msgtype":"m.text"},"depth":27,"prev_state":[],"origin":"localhost","origin_server_ts":1672678428347,"hashes":{"sha256":"F+YeW5ZVnRWCaFS9hn7FfcLdezpcpAN7bzFlyujhwi8"},"signatures":{"localhost":{"ed25519:a_CHdg":"8YitOz41hzSpRj/PPW3tQN9kuRvUUlXu9DAwfLWYCeGkwCO9hc6n77M2nEKGhrAjyQ85re1+rACajGHWPPwpBg"}},"unsigned":{"age_ts":1672678428347}}	3
$wttc0xGxavZKEFW4jhvY1iHmKn5fBDpTA47wmyrYJ6k	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$lV2FDnpp7NRIRR5BdRLjhMfQU639aIzIumB6iT8p1ao","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$th-c5RZ-B0CMnKv9LtzPkBy_JfUuYDy4zUtX-8O9Rzg"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"membership":"join","displayname":"MattermostUser A [mm]"},"depth":14,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672674603955,"hashes":{"sha256":"UtEo+YygTePd0ATStXHBMY2mA+81c7vWDsBdXIOnhTM"},"signatures":{"localhost":{"ed25519:a_CHdg":"0DXF9dz7tS/fM2fesW3JiYclKgIhcQox25tkTJDfj9/EQ6wDFffOcdindqphePxMqCeggvDcMHbEvoCnsDBLAg"}},"unsigned":{"age_ts":1672674603955,"replaces_state":"$lV2FDnpp7NRIRR5BdRLjhMfQU639aIzIumB6iT8p1ao"}}	3
$moj2kqPjW9Xd0RBTBX4Ee8HVebtt8aY6J7P3i6UT7qw	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$Z2BDuqYr2x_4RtA8EmelcT41xj-7klcpKFvY5-POfVw","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o"],"prev_events":["$wttc0xGxavZKEFW4jhvY1iHmKn5fBDpTA47wmyrYJ6k"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"bridgeuser1 [mm]"},"depth":15,"prev_state":[],"state_key":"@mm_bridgeuser1:localhost","origin":"localhost","origin_server_ts":1672675303518,"hashes":{"sha256":"Fsdfenc/trq5IAnBxn95EpgDylOYgqDgHvqJZXqX97M"},"signatures":{"localhost":{"ed25519:a_CHdg":"nuqZD54NSrw8W+Dct/V1VqK0I0771hkpKKR5wnMWOBVBTXzkqR/YVwf6H16fgf1P4W6ViO4YFz397knlJossAA"}},"unsigned":{"age_ts":1672675303518,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#town-square:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$fkjIqV9H5dj_boKqogOxPeFW_m8yxwpxTgr4lSwePDY	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$hUQcgu2HJB2PDqWBrqIQkblhG-WvxXaIzHEnXw-Ej30","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$hUQcgu2HJB2PDqWBrqIQkblhG-WvxXaIzHEnXw-Ej30"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_bridgeuser1:localhost","content":{"membership":"join","displayname":"bridgeuser1 [mm]"},"depth":16,"prev_state":[],"state_key":"@mm_bridgeuser1:localhost","origin":"localhost","origin_server_ts":1672675304004,"hashes":{"sha256":"o4gOmldMohl/UeUQXFEqQChUIrGdeD76PojcArvCJJM"},"signatures":{"localhost":{"ed25519:a_CHdg":"S5vouH4ISoWJ0tgm89jlPHK0sdxlEEwWMEIw6kGu5TRNLuPfpUBI95tZNVjLJgeooawvAYoKlahS+V/Pfd5CCA"}},"unsigned":{"age_ts":1672675304004,"replaces_state":"$hUQcgu2HJB2PDqWBrqIQkblhG-WvxXaIzHEnXw-Ej30"}}	3
$ze3RfSNk1D8sruIVbtfFmFdyoNnUgcEoFtM7ULxeWMs	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$fG61faFdiQLdggY7LGhSk_5yDw-HxLQiWURS7cCmAAc","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$fG61faFdiQLdggY7LGhSk_5yDw-HxLQiWURS7cCmAAc"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_bridgeuser2:localhost","content":{"membership":"join","displayname":"bridgeuser2 [mm]"},"depth":18,"prev_state":[],"state_key":"@mm_bridgeuser2:localhost","origin":"localhost","origin_server_ts":1672675304634,"hashes":{"sha256":"Yjm8wP6o3QsW2Ra72A1FXh7lRVqd4xCkwJu04OwMfVo"},"signatures":{"localhost":{"ed25519:a_CHdg":"DG3L6ZwwfqdyMQTqsXw8UVMoWePmN0+eQ2ubaaX4oHO2gmYS5Zv1FG5QLlpgzIeBu+RWKYPqJlMB59XJ0DIiCw"}},"unsigned":{"age_ts":1672675304634,"replaces_state":"$fG61faFdiQLdggY7LGhSk_5yDw-HxLQiWURS7cCmAAc"}}	3
$KG18kyO7FM4HavQZH_xZmXGUw1RbyfWhbs-Ds3u5vB8	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$BeKLUYL7qRfgvRH3qg2u6Z41GK2CNQqGwtAmWHwBWjA","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$BeKLUYL7qRfgvRH3qg2u6Z41GK2CNQqGwtAmWHwBWjA"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_bridgeuser1:localhost","content":{"membership":"join","displayname":"bridgeuser1 [mm]"},"depth":20,"prev_state":[],"state_key":"@mm_bridgeuser1:localhost","origin":"localhost","origin_server_ts":1672677122663,"hashes":{"sha256":"eV14u5spfM/TycndyJDIpNY2VP0C4vnTqOl4czIK1v4"},"signatures":{"localhost":{"ed25519:a_CHdg":"vGNOKaDsESndjjQVo/GNU5K10tdHq2aE7e8y5+YDjSiRZmmonYnWqgNgVi5UWy6voMHJHuFFgHhR5WDTvUKUDA"}},"unsigned":{"age_ts":1672677122663,"replaces_state":"$BeKLUYL7qRfgvRH3qg2u6Z41GK2CNQqGwtAmWHwBWjA"}}	3
$FVhXs60ZUT4hfp8SPDQiJ9sUL5CV4MjGIsUfequDwEE	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672677856104.0","historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$KG18kyO7FM4HavQZH_xZmXGUw1RbyfWhbs-Ds3u5vB8"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_bridgeuser2:localhost","content":{"msgtype":"m.text","body":"okokok"},"depth":21,"prev_state":[],"origin":"localhost","origin_server_ts":1672677856149,"hashes":{"sha256":"JoIr3NrZmHXEuLrSD2NaerOF5LcSNjoWznn1wLr5Jvk"},"signatures":{"localhost":{"ed25519:a_CHdg":"71HFWz6j1X3YxcaXBjYtBjnupfJYvPxBut+cndHrx4e+ATVCqkFqWMfufQ4KD542mjaTgTigMvssUG2Qwu34BQ"}},"unsigned":{"age_ts":1672677856149}}	3
$NDRnMTvwTgCFfTb_vFmNwNe1o4a-UnPMEHKYvBFg1Ms	!dKcbdDATuwwphjRPQP:localhost	{"txn_id":"m1672677919322.1","historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$ze3RfSNk1D8sruIVbtfFmFdyoNnUgcEoFtM7ULxeWMs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$DOD9xnyV6gfI9j6KBsEdTpRu2l62hsRVmc9i6QLcseo"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_bridgeuser2:localhost","content":{"msgtype":"m.text","body":"Hi again"},"depth":21,"prev_state":[],"origin":"localhost","origin_server_ts":1672677919372,"hashes":{"sha256":"SZf8slx36W13m5PyfcXzLQ+XA10Fci9Q8Mcw0fVL4SA"},"signatures":{"localhost":{"ed25519:a_CHdg":"QmGAQ2GWREsves9/oOKmCoSHMSDV5tOFwA8+FJhWpOhMfBo9QNPOHBxebp4fpJQTqdaJ17MwkVZq3K1Dye3yDw"}},"unsigned":{"age_ts":1672677919372}}	3
$sT18sK2FK6Bo7161sdufjmhywK9CsJHemT-D6fDbaWs	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$DOD9xnyV6gfI9j6KBsEdTpRu2l62hsRVmc9i6QLcseo","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$NDRnMTvwTgCFfTb_vFmNwNe1o4a-UnPMEHKYvBFg1Ms"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_bridgeuser1:localhost","content":{"membership":"join","displayname":"mm_bridgeuser1"},"depth":22,"prev_state":[],"state_key":"@mm_bridgeuser1:localhost","origin":"localhost","origin_server_ts":1672678123680,"hashes":{"sha256":"narUiP8z22OPCqFuU5U4GNIleUJ3ph8ak9iXGut4F00"},"signatures":{"localhost":{"ed25519:a_CHdg":"IBLWoWXfSCR3ZazVlxQS19mUV55ZtL4zRfcdqGG9usFjexO0jZOYmh0J4OJSLEgLyb4I3tBWVk4ff3IDVrxgDg"}},"unsigned":{"age_ts":1672678123680,"replaces_state":"$DOD9xnyV6gfI9j6KBsEdTpRu2l62hsRVmc9i6QLcseo"}}	3
$DrKoz6WomICqVeub6PxHnTnu5NbhLDAg2J9rHOxBMmA	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$moj2kqPjW9Xd0RBTBX4Ee8HVebtt8aY6J7P3i6UT7qw","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$moj2kqPjW9Xd0RBTBX4Ee8HVebtt8aY6J7P3i6UT7qw"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_bridgeuser1:localhost","content":{"membership":"join","displayname":"bridgeuser1 [mm]"},"depth":16,"prev_state":[],"state_key":"@mm_bridgeuser1:localhost","origin":"localhost","origin_server_ts":1672675303740,"hashes":{"sha256":"IGo1WuLVyt8ZonHl2wnpPm0Swy/9rDOcSHd/J5HgPjY"},"signatures":{"localhost":{"ed25519:a_CHdg":"ZNJql4w4IHvdrkZbJ20Zk9dDxQDHIDGVkJPZWNpcJ13BfyYvhDeD1EL4davHnlSouryAG7h42Iy8EEdO1Y3uDQ"}},"unsigned":{"age_ts":1672675303740,"replaces_state":"$moj2kqPjW9Xd0RBTBX4Ee8HVebtt8aY6J7P3i6UT7qw"}}	3
$hUQcgu2HJB2PDqWBrqIQkblhG-WvxXaIzHEnXw-Ej30	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$uuCt7OoWWYBzi7T3Jte6ntGxol6g760NhRDnyPvGMLA","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs"],"prev_events":["$DjME4nek1Vnfgp8JIvyexbgZFnJ7UrCzBWYcgi5DRQE"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"bridgeuser1 [mm]"},"depth":15,"prev_state":[],"state_key":"@mm_bridgeuser1:localhost","origin":"localhost","origin_server_ts":1672675303868,"hashes":{"sha256":"x4T+OzRs8a5qtEWbpZUXTOn4Yi5iqKNeQBWNbAnSb80"},"signatures":{"localhost":{"ed25519:a_CHdg":"l7HCEXnPxrNP/sNC3H/Z4eJDnLaKQJ+qDYFOBD8ehFhjx2P1nUi6IgXmB9T5fU/uEdjDixY0P3KwECD9t03CAA"}},"unsigned":{"age_ts":1672675303868,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#off-topic:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$FUJQN-_4fHqBV5emsypqKHRRS0j5jbpMmuarjoIptOg	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$Z2BDuqYr2x_4RtA8EmelcT41xj-7klcpKFvY5-POfVw","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o"],"prev_events":["$DrKoz6WomICqVeub6PxHnTnu5NbhLDAg2J9rHOxBMmA"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"bridgeuser2 [mm]"},"depth":17,"prev_state":[],"state_key":"@mm_bridgeuser2:localhost","origin":"localhost","origin_server_ts":1672675304229,"hashes":{"sha256":"HUlnQm2WXMV14kkX4IRQ5k9tBDoxJIqe9lqBDA8iNZ4"},"signatures":{"localhost":{"ed25519:a_CHdg":"ic1qp/pj6sLLDlP/UMPA8w1NL7BDaKd13fFEg8YNp1jImfHSJN3Pj1VASW6i+0Nq6B/MQ1Obg+ccHW9HUlBVBw"}},"unsigned":{"age_ts":1672675304229,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#town-square:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$FUJQN-_4fHqBV5emsypqKHRRS0j5jbpMmuarjoIptOg","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$FUJQN-_4fHqBV5emsypqKHRRS0j5jbpMmuarjoIptOg"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_bridgeuser2:localhost","content":{"membership":"join","displayname":"bridgeuser2 [mm]"},"depth":18,"prev_state":[],"state_key":"@mm_bridgeuser2:localhost","origin":"localhost","origin_server_ts":1672675304372,"hashes":{"sha256":"VhKkJIcHhqA+uCSFHgq2ckM9Npg5KXvPCCsjS5zPpAs"},"signatures":{"localhost":{"ed25519:a_CHdg":"GEuZoCBgAbvZGaN4FBmY9i7OVW6IemJio+vKf0jfdGA/J/s4GaRfQhrxR77srZpboPqbGRtB4P96+CGPLPl8Dg"}},"unsigned":{"age_ts":1672675304372,"replaces_state":"$FUJQN-_4fHqBV5emsypqKHRRS0j5jbpMmuarjoIptOg"}}	3
$BeKLUYL7qRfgvRH3qg2u6Z41GK2CNQqGwtAmWHwBWjA	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$DrKoz6WomICqVeub6PxHnTnu5NbhLDAg2J9rHOxBMmA","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_bridgeuser1:localhost","content":{"membership":"join","displayname":"mm_bridgeuser1"},"depth":19,"prev_state":[],"state_key":"@mm_bridgeuser1:localhost","origin":"localhost","origin_server_ts":1672676284551,"hashes":{"sha256":"SMsz01PaoXBBv3gZ5g7fMJ+mYe54hiqzPhrxOXJeEX4"},"signatures":{"localhost":{"ed25519:a_CHdg":"iFoXN2A/UG2fxZHe++AvJKqldZ/DdpaEErqFdMTmzc4wDR/KSLywG+FO7i2YbkBGU5WAb8pmcRkpFLHI1OkGCg"}},"unsigned":{"age_ts":1672676284551,"replaces_state":"$DrKoz6WomICqVeub6PxHnTnu5NbhLDAg2J9rHOxBMmA"}}	3
$d05l2i-Vc2Zzx3bl0Vz-NnDVVhxgFQIctiPfGoz0Xjs	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$KG18kyO7FM4HavQZH_xZmXGUw1RbyfWhbs-Ds3u5vB8","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$MSYX67PL-aQgpnMS30mo0OLCFY11arvS2Ehe0I0SNAg"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_bridgeuser1:localhost","content":{"membership":"join","displayname":"mm_bridgeuser1"},"depth":23,"prev_state":[],"state_key":"@mm_bridgeuser1:localhost","origin":"localhost","origin_server_ts":1672678123962,"hashes":{"sha256":"j9DzJoOV1yckUu0+aICjyfYmUSHzgrfjOmtZS280Cyc"},"signatures":{"localhost":{"ed25519:a_CHdg":"I8j2/FhQwHSIzJCFqJ3vUQb5ziIlSo8GASTzxU/KMxJWDZZYg7ufAIPJvCyXh5vvvyvvl9fI3B3Wg5LlTDKJDw"}},"unsigned":{"age_ts":1672678123962,"replaces_state":"$KG18kyO7FM4HavQZH_xZmXGUw1RbyfWhbs-Ds3u5vB8"}}	3
$DOD9xnyV6gfI9j6KBsEdTpRu2l62hsRVmc9i6QLcseo	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$ifo4xdQDNVXvmkvgnrcj5o9iKblytzWMd_pEcRtWvx8","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$ifo4xdQDNVXvmkvgnrcj5o9iKblytzWMd_pEcRtWvx8"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_bridgeuser1:localhost","content":{"membership":"join","displayname":"bridgeuser1 [mm]"},"depth":20,"prev_state":[],"state_key":"@mm_bridgeuser1:localhost","origin":"localhost","origin_server_ts":1672677122498,"hashes":{"sha256":"qkJXClODtgDLDV8fk/DZUYmckTGvsl9DxC6Drim3GUs"},"signatures":{"localhost":{"ed25519:a_CHdg":"VreyZJpcbsGL3swxnp7LldTEYeQmUN1MaZgfIWjKEp2Q5MFpGlGDSgXBrDzjJyl2oSd3LJ73K6cN2OqQlTMNDw"}},"unsigned":{"age_ts":1672677122498,"replaces_state":"$ifo4xdQDNVXvmkvgnrcj5o9iKblytzWMd_pEcRtWvx8"}}	3
$MSYX67PL-aQgpnMS30mo0OLCFY11arvS2Ehe0I0SNAg	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":16,"txn_id":"m1672677893256.0","historical":false}	{"auth_events":["$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$FVhXs60ZUT4hfp8SPDQiJ9sUL5CV4MjGIsUfequDwEE"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_a:localhost","content":{"org.matrix.msc1767.message":[{"body":"> <@mm_bridgeuser2:localhost> okokok\\n\\nCool","mimetype":"text/plain"},{"body":"<mx-reply><blockquote><a href=\\"https://matrix.to/#/!kmbTYjjsDRDHGgVqUP:localhost/$FVhXs60ZUT4hfp8SPDQiJ9sUL5CV4MjGIsUfequDwEE?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@mm_bridgeuser2:localhost\\">@mm_bridgeuser2:localhost</a><br>okokok</blockquote></mx-reply>Cool","mimetype":"text/html"}],"body":"> <@mm_bridgeuser2:localhost> okokok\\n\\nCool","msgtype":"m.text","format":"org.matrix.custom.html","formatted_body":"<mx-reply><blockquote><a href=\\"https://matrix.to/#/!kmbTYjjsDRDHGgVqUP:localhost/$FVhXs60ZUT4hfp8SPDQiJ9sUL5CV4MjGIsUfequDwEE?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@mm_bridgeuser2:localhost\\">@mm_bridgeuser2:localhost</a><br>okokok</blockquote></mx-reply>Cool","m.relates_to":{"m.in_reply_to":{"event_id":"$FVhXs60ZUT4hfp8SPDQiJ9sUL5CV4MjGIsUfequDwEE"}}},"depth":22,"prev_state":[],"origin":"localhost","origin_server_ts":1672677893374,"hashes":{"sha256":"iEs/Q7rxYt5Vjr0GUfay3D8VuSY3CnYD5zB7MA7WyZM"},"signatures":{"localhost":{"ed25519:a_CHdg":"hV7sUJNLoYm3j7tUNV3v3K4Sb++lKIKpvkvGK9ehvV1QTeTmoGhulh0DsWIl1dDRjpzQdkAF3B9UUlHQnpHCDA"}},"unsigned":{"age_ts":1672677893374}}	3
$jsgSLDcqxEQROuyA6P2myIoJf5N1kGLS_n8iWXwE-nU	!dKcbdDATuwwphjRPQP:localhost	{"txn_id":"m1672678277812.2","historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$ze3RfSNk1D8sruIVbtfFmFdyoNnUgcEoFtM7ULxeWMs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$sT18sK2FK6Bo7161sdufjmhywK9CsJHemT-D6fDbaWs"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_bridgeuser2:localhost","content":{"msgtype":"m.text","body":"hi"},"depth":23,"prev_state":[],"origin":"localhost","origin_server_ts":1672678277871,"hashes":{"sha256":"Ht356nRkAsi++avDYDC/An6RWLfXSN8jQ0GPA5amL6E"},"signatures":{"localhost":{"ed25519:a_CHdg":"3f0DAP/FCs7RAXCSHjdMshRnsTDYLQIH2Mj9WddDxa/rfUKJ7FVaIJKfssFbJj/AnB3nVPLySPlMzg+Nhx5PAA"}},"unsigned":{"age_ts":1672678277871}}	3
$vg3binnx1kEog3C9nqvwJ7qPu28sTqYrZDssk0vab-Q	!dKcbdDATuwwphjRPQP:localhost	{"txn_id":"m1672678307358.3","historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$ze3RfSNk1D8sruIVbtfFmFdyoNnUgcEoFtM7ULxeWMs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$jsgSLDcqxEQROuyA6P2myIoJf5N1kGLS_n8iWXwE-nU"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_bridgeuser2:localhost","content":{"msgtype":"m.text","body":"fine"},"depth":24,"prev_state":[],"origin":"localhost","origin_server_ts":1672678307400,"hashes":{"sha256":"PMdY+fx5jHQQEmN1cJlcc/2tgv4VJiqIhz87pB0Wgao"},"signatures":{"localhost":{"ed25519:a_CHdg":"k0YeOhvoC6kgFwrPFmk+7Ml2OVSgC5gWnFOyd7XOPImGZCg2r5sdm4MKzlV1xY2UQKOKmqhOdR18etnTEkjqBw"}},"unsigned":{"age_ts":1672678307400}}	3
$d8OJKkkhp47jknk_LHO0c3d0-CSNWMzpJBRw6bOrQ4M	!dKcbdDATuwwphjRPQP:localhost	{"txn_id":"m1672678409114.4","historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$ze3RfSNk1D8sruIVbtfFmFdyoNnUgcEoFtM7ULxeWMs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$YMb8Q2a5Xbnn70ZtQxPIimfv3Y9zSC67zsDIdEsRFJw"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_bridgeuser2:localhost","content":{"msgtype":"m.text","body":"ok ok"},"depth":26,"prev_state":[],"origin":"localhost","origin_server_ts":1672678409182,"hashes":{"sha256":"75Wzl6GofltsqsNaZgwYJAWjxRhsNU4agC7KF7CiW3A"},"signatures":{"localhost":{"ed25519:a_CHdg":"jt7czcTa2W4PLVspUKseX/VOMH29ZOPDiwIB4jHB+51FXCwaDRAYudn9dLXrkQXqP6nXOeg+N7hXPRGALWZVDw"}},"unsigned":{"age_ts":1672678409182}}	3
$CcTsy5iCDZyphUv5irDLp85iBq-btwDvTJahbK5ATzo	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$d05l2i-Vc2Zzx3bl0Vz-NnDVVhxgFQIctiPfGoz0Xjs","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$d05l2i-Vc2Zzx3bl0Vz-NnDVVhxgFQIctiPfGoz0Xjs"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_bridgeuser1:localhost","content":{"membership":"join","displayname":"bridgeuser1 [mm]"},"depth":24,"prev_state":[],"state_key":"@mm_bridgeuser1:localhost","origin":"localhost","origin_server_ts":1672681243650,"hashes":{"sha256":"Y5ryUaQDTrywmkoBhtakwNe1pHtOfQV3HOzATq/O5gY"},"signatures":{"localhost":{"ed25519:a_CHdg":"JnzMcVjlD896sA3AXlmewT0mZ6V+OqVOvx9gX1Kzst+K1qaeUOalYI4Ku6ulwonN8UpgyZVpLrJXuwT8EVuBCg"}},"unsigned":{"age_ts":1672681243650,"replaces_state":"$d05l2i-Vc2Zzx3bl0Vz-NnDVVhxgFQIctiPfGoz0Xjs"}}	3
$0F5VtbBOxf2d2OwQ46I3LM3tqAkj2YWFXSKWzfzdtT8	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$sT18sK2FK6Bo7161sdufjmhywK9CsJHemT-D6fDbaWs","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$obESo5AynBeb9xLH4sESBL5g-segSsJGjC9XER9ZTt8"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_bridgeuser1:localhost","content":{"membership":"join","displayname":"bridgeuser1 [mm]"},"depth":28,"prev_state":[],"state_key":"@mm_bridgeuser1:localhost","origin":"localhost","origin_server_ts":1672681243845,"hashes":{"sha256":"h2SZP4fsPnsES4dcJ48ZxoR7cybvrhpcp0u2L8DhU88"},"signatures":{"localhost":{"ed25519:a_CHdg":"U2vMOSKHNkgDiz+8JRhkk2FQ199F4pUmAjDEFqGy7Mb8SmpZ2JuYgRnSmiXnQUDUaoFxfGlq5DT24X4HFgz0AQ"}},"unsigned":{"age_ts":1672681243845,"replaces_state":"$sT18sK2FK6Bo7161sdufjmhywK9CsJHemT-D6fDbaWs"}}	3
$LkEO2DXJWjTGSlo7iokDO6KvigtD7BtSYgzN1bHF2q0	!dKcbdDATuwwphjRPQP:localhost	{"txn_id":"m1672681261831.0","historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$ze3RfSNk1D8sruIVbtfFmFdyoNnUgcEoFtM7ULxeWMs"],"prev_events":["$0F5VtbBOxf2d2OwQ46I3LM3tqAkj2YWFXSKWzfzdtT8"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_bridgeuser2:localhost","content":{"msgtype":"m.text","body":"ok"},"depth":29,"prev_state":[],"origin":"localhost","origin_server_ts":1672681261866,"hashes":{"sha256":"h+WN/lDkeEHkyoxHReNZVRWGAZ47iQJFPe7A6uRC0tY"},"signatures":{"localhost":{"ed25519:a_CHdg":"wt1vFBRoCCRhPovL6lNu6d7ncq8tcbrnN/AbzhV3pbC0Tn1qShyYGrNsTm6X3ga3veG9CbBTE/k7KO92NZ1oAA"}},"unsigned":{"age_ts":1672681261866}}	3
$RBYjw0bWPMbVEg8csvMs4tPORoqreh7W0cTgJTDKhxQ	!dKcbdDATuwwphjRPQP:localhost	{"txn_id":"m1672681270357.1","historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$ze3RfSNk1D8sruIVbtfFmFdyoNnUgcEoFtM7ULxeWMs"],"prev_events":["$LkEO2DXJWjTGSlo7iokDO6KvigtD7BtSYgzN1bHF2q0"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_bridgeuser2:localhost","content":{"msgtype":"m.text","body":"ok"},"depth":30,"prev_state":[],"origin":"localhost","origin_server_ts":1672681270387,"hashes":{"sha256":"nkxX3HD6LvSHtD59qS5o5KPMLgU7j7v2ywoBGdhHpgI"},"signatures":{"localhost":{"ed25519:a_CHdg":"w/AuDym98OAN8z6dUbMCvOcIzPTtYs4kexVSoSVarje07LhJnjhKNPFVj9EkqYFvQcaoNLSKfg5n345YgDGrCg"}},"unsigned":{"age_ts":1672681270387}}	3
$qpoohVqO3c0vYCNBJuvRZHkBBNPQSrgwVwzIcbCfJJk	!dKcbdDATuwwphjRPQP:localhost	{"txn_id":"m1672681331430.3","historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$ze3RfSNk1D8sruIVbtfFmFdyoNnUgcEoFtM7ULxeWMs"],"prev_events":["$3J0wiu01NbTrOfOGZgRjSdNtX0P7ZN-PQp8qKcLDlmY"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_bridgeuser2:localhost","content":{"msgtype":"m.text","body":"** klklklkl **"},"depth":32,"prev_state":[],"origin":"localhost","origin_server_ts":1672681331460,"hashes":{"sha256":"XV2xQwCIMbO00QcbTuI9Ze4Hz9Z8CoYABGcZQ7hKWKk"},"signatures":{"localhost":{"ed25519:a_CHdg":"Em+ZMzA8NsZftTFC3U1WdrEsDOhIED3K7tMstAx5ChlFwdBsnVQdIf/IzW2THWtOcj0RgTdHRYP2LUpBNVy6AA"}},"unsigned":{"age_ts":1672681331460}}	3
$FLa6I56u6EmzKm7SjplLhqPxGUZeJy_gEayv25svMwc	!dKcbdDATuwwphjRPQP:localhost	{"token_id":14,"txn_id":"m1672681344489.0","historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$qpoohVqO3c0vYCNBJuvRZHkBBNPQSrgwVwzIcbCfJJk"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"org.matrix.msc1767.text":"l\\u00f6l\\u00f6l","body":"l\\u00f6l\\u00f6l","msgtype":"m.text"},"depth":33,"prev_state":[],"origin":"localhost","origin_server_ts":1672681344588,"hashes":{"sha256":"d7zQF/LCXOYBHqE+YRcVJ0ZuSRaSGiNohW1gH0pysVk"},"signatures":{"localhost":{"ed25519:a_CHdg":"zD1LaD3S7YfWPdcatPA87hBbkqc0KcHRRAQFL8rPyAUl4/pdCeu4ocj9JOeL7GdRnRepSvyNSon5lvHmvo+4Dg"}},"unsigned":{"age_ts":1672681344588}}	3
$uVCWC5TSVmmOhtnjhBprXQIqqNMmjlwAjnAbCFWCmSM	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672681360024.4","historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk"],"prev_events":["$CcTsy5iCDZyphUv5irDLp85iBq-btwDvTJahbK5ATzo"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_bridgeuser2:localhost","content":{"msgtype":"m.text","body":"klklklk"},"depth":25,"prev_state":[],"origin":"localhost","origin_server_ts":1672681360085,"hashes":{"sha256":"gBrKlsU+rlVkMgV0BXI2JwKfNm3ZqB5vhMbgYQ4BmgE"},"signatures":{"localhost":{"ed25519:a_CHdg":"ftw8v4H+Eg5bJvrOwAWjheP3QuNmT+XqlTXvC5FQAmD6JcLI2DUcASdV1kj2C7aJb5TFmROY1XptaU6KC3wlCA"}},"unsigned":{"age_ts":1672681360085}}	3
$ze3rHWp4q76u5HD9VeEM4tmvDPVyEGXfJ16m3GKAPBA	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672681380138.5","historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk"],"prev_events":["$uVCWC5TSVmmOhtnjhBprXQIqqNMmjlwAjnAbCFWCmSM"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_bridgeuser2:localhost","content":{"msgtype":"m.text","body":"Data"},"depth":26,"prev_state":[],"origin":"localhost","origin_server_ts":1672681380176,"hashes":{"sha256":"hP5DYiaJCvRt0UBJ9bHAWj59N1IJGSi3Kc4vQZ3HO5o"},"signatures":{"localhost":{"ed25519:a_CHdg":"2V7vtLGvbYv1Q/+ReyTkM1ChXiAXFTdPxZOj1E0JvW9eBp3Qv+7dBHHswhCg/4n0/Vq9RpengLhbjkljreb/Dg"}},"unsigned":{"age_ts":1672681380176}}	3
$wQdEIjcFyopFZpNGXmYD7mGBK2vx6nRTZFbp0tUAS5s	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672681380571.6","historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk"],"prev_events":["$ze3rHWp4q76u5HD9VeEM4tmvDPVyEGXfJ16m3GKAPBA"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_bridgeuser2:localhost","content":{"msgtype":"m.file","body":"README.md","url":"mxc://localhost/GuGmZcSQoAvjfaruEvcaZCws","info":{"mimetype":"","size":2501}},"depth":27,"prev_state":[],"origin":"localhost","origin_server_ts":1672681380629,"hashes":{"sha256":"pT+nSrm4UtSCkGFCMI6mF0uaKWeYgLWoSdwPU9U/Yro"},"signatures":{"localhost":{"ed25519:a_CHdg":"e9B6btzHnBNiv9gihCpMitjdRinlwuL3um8MqbbU3guVrws7owqX0xNioSy4iZYEQtWiFC3/d/gDabIftVgPAA"}},"unsigned":{"age_ts":1672681380629}}	3
$vCLF-PjgFkWDlv9RC2q7AbemDp5Aq_wTHx26K7fVT2k	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":14,"txn_id":"m1672681414507.1","historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$wQdEIjcFyopFZpNGXmYD7mGBK2vx6nRTZFbp0tUAS5s"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_a:localhost","content":{"body":"README.md","info":{"size":14},"msgtype":"m.file","url":"mxc://localhost/qlZtzZJiheQYCQsPJZKPloGw"},"depth":28,"prev_state":[],"origin":"localhost","origin_server_ts":1672681414600,"hashes":{"sha256":"8Xg/54+JjtefS8XdmlfXALhPRiUoSEi6DVsw2ErAU3Q"},"signatures":{"localhost":{"ed25519:a_CHdg":"SEPIxfJoDqMgIExD8121A2Mn9qu+5fMjEZQU27Hixoy8yUcWM0NIeg1R7cdBSwajPWCALVOHQxzEgAYfUW6QCQ"}},"unsigned":{"age_ts":1672681414600}}	3
$CtsCO4y6Ci5lqltxoUXJqrNNDD4LeUErcBMp_5KFwdU	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":14,"txn_id":"m1672681420207.2","historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$vCLF-PjgFkWDlv9RC2q7AbemDp5Aq_wTHx26K7fVT2k"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_a:localhost","content":{"org.matrix.msc1767.text":"ok","body":"ok","msgtype":"m.text"},"depth":29,"prev_state":[],"origin":"localhost","origin_server_ts":1672681420303,"hashes":{"sha256":"0ehGH1BvDXaH+KUN9Qj4iCTNDs/2xl2pEVVvaVYrrx4"},"signatures":{"localhost":{"ed25519:a_CHdg":"hKxr/sOFJvZpWr03veWDXSewCgLOKWmRDjrtHdnXmlvo6ioBOtWmU6CzRMssp/B/uyLfZ3alUpyGBhY3NIFECA"}},"unsigned":{"age_ts":1672681420303}}	3
$8AX5D9nuhWswBU_Fc227Rvda1dcYTL38k5-nu5LYeow	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":14,"txn_id":"m1672681454556.3","historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$CtsCO4y6Ci5lqltxoUXJqrNNDD4LeUErcBMp_5KFwdU"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_a:localhost","content":{"body":"package.json","info":{"size":259,"mimetype":"application/json"},"msgtype":"m.file","url":"mxc://localhost/tOOcAZHFIHUrslceWBfnuyVf"},"depth":30,"prev_state":[],"origin":"localhost","origin_server_ts":1672681454632,"hashes":{"sha256":"hIm9wUL0y3DorehMmYlnOvBmpBO1/krJVR/ztSpZH6M"},"signatures":{"localhost":{"ed25519:a_CHdg":"Ie4c28oxEPirK8UdMCfzT3/DqnV9Ky2JFkZyhSyu4l+dn++7Saa8RErMpWkiLpQcu+TMAAPzno3Av9Sq/VpDDQ"}},"unsigned":{"age_ts":1672681454632}}	3
$C_yOhTrkIxQT1pPwVX1TWe0UBFqH59o0aetXDnxNbb4	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":16,"txn_id":"m1672681674217.0","historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw"],"prev_events":["$8AX5D9nuhWswBU_Fc227Rvda1dcYTL38k5-nu5LYeow"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@admin:localhost","content":{"body":"playwright.config.ts","info":{"size":1608},"msgtype":"m.file","url":"mxc://localhost/kmACnWKAAOsZJUXvlOQAmvPY"},"depth":31,"prev_state":[],"origin":"localhost","origin_server_ts":1672681674319,"hashes":{"sha256":"8JPpd+ouwTywsYWkZl4yN33nLvUH4IQdv+WH7u9Vg84"},"signatures":{"localhost":{"ed25519:a_CHdg":"LWXQudX64mcGF6F8L7uLi8KWwP0YVgjjYeRKAY27MegUmDJkbJrpDQ6qTAR7l5JLPTieiPETGIvo/XFrYBeaBg"}},"unsigned":{"age_ts":1672681674319}}	3
$7tsqPssEA6U65Qrd44F9FbFLND-JhznQ_c-4bXrIlRE	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672681715704.7","historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk"],"prev_events":["$C_yOhTrkIxQT1pPwVX1TWe0UBFqH59o0aetXDnxNbb4"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_bridgeuser2:localhost","content":{"msgtype":"m.text","body":"klk"},"depth":32,"prev_state":[],"origin":"localhost","origin_server_ts":1672681715671,"hashes":{"sha256":"WpHh9H79ariu75zfzTY+u55Q5tJ0mGsJ4dVPe5gsNNs"},"signatures":{"localhost":{"ed25519:a_CHdg":"+lPSK/Lxj7Dn0oh4UjnmfmyhEc9xVUEcV8lxK65uLnxdHlbz8eNGoe+XKcD3lkl5bDGIdCubKGeI5x0YjllJAQ"}},"unsigned":{"age_ts":1672681715671}}	3
$ge07snxHDhIl87w9HhFEY0Vf4fZF7sfC8ZgYVajdyBQ	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":16,"txn_id":"m1672681807684.1","historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw"],"prev_events":["$qIPcuD0d9eSflKKATXSbTJjoKFIBzNFk28nuN3007zo"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@admin:localhost","content":{"body":"package-lock.json","info":{"size":3107,"mimetype":"application/json"},"msgtype":"m.file","url":"mxc://localhost/HrygdBDWifMNkZMAjjZqASQE"},"depth":36,"prev_state":[],"origin":"localhost","origin_server_ts":1672681807766,"hashes":{"sha256":"baqgeV/eOQUXuvAVrE5o6MmfJM1Ney79O2iBpYN2S0g"},"signatures":{"localhost":{"ed25519:a_CHdg":"gqtLFd/LD9/SPLNmTqaLb0NXX+b6VE7G7o6hS4YtzhKgHmocY0KidKdHmJl4EmS3yr1bgaXt3y4BPx/tsWBBCQ"}},"unsigned":{"age_ts":1672681807766}}	3
$D4biAJRc__54ONgjSEAYBzE8_j1ePGCqni93Os3tKhM	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672681716089.8","historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk"],"prev_events":["$7tsqPssEA6U65Qrd44F9FbFLND-JhznQ_c-4bXrIlRE"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_bridgeuser2:localhost","content":{"msgtype":"m.file","body":"docker-compose.yml","url":"mxc://localhost/AaIOLDlmkQIhJCYLMJzOrirc","info":{"mimetype":"","size":558}},"depth":33,"prev_state":[],"origin":"localhost","origin_server_ts":1672681716099,"hashes":{"sha256":"gqCytJbRoM02Jk1nJ7Fp2wmsQREt2snsFW24s0M/Dns"},"signatures":{"localhost":{"ed25519:a_CHdg":"t0OMEJ6vFJNOwRe9FQ6aAGeWrHx4buynS5KSuq+FbXOBfFjnPwkce2/26696Pvd+p3WckrlNkzpLwyt+AHJGCQ"}},"unsigned":{"age_ts":1672681716099}}	3
$qIPcuD0d9eSflKKATXSbTJjoKFIBzNFk28nuN3007zo	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672681778991.10","historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk"],"prev_events":["$GPeeyjoIFFM1Mp_pvKB55ZyVVmuSxQ3czNsjj5VxcZs"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_bridgeuser2:localhost","content":{"msgtype":"m.file","body":"Dockerfile","url":"mxc://localhost/RGhmrIGOwMsaNgdGLQhxdtAd","info":{"mimetype":"","size":159}},"depth":35,"prev_state":[],"origin":"localhost","origin_server_ts":1672681779092,"hashes":{"sha256":"LB2ImlhBD2Y/OT2QFprMrnr+MmQBk6PjDVHbmNjjyN4"},"signatures":{"localhost":{"ed25519:a_CHdg":"SsjYuksjSpwuI5kvNODT4W0KQ98NDlqsfFqjTcKiY8ouYnixezfKxzQMnPgPGud0Z2lkGRL3+2p4NVY9hbY9Dg"}},"unsigned":{"age_ts":1672681779092}}	3
$iKj1OUBZW17_u23PJes2dsEtLEQhEZBWblS4q6rzsjU	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672681853037.12","historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk"],"prev_events":["$-F2yj6IuC13Z2Eri3_-fsH3NLCQXQ1igRElx9-Op2x4"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_bridgeuser2:localhost","content":{"msgtype":"m.file","body":"nginx.conf","url":"mxc://localhost/ENppMmCHcHDSyzFenKdFriGH","info":{"mimetype":"","size":353}},"depth":39,"prev_state":[],"origin":"localhost","origin_server_ts":1672681853170,"hashes":{"sha256":"f/20wd+VM94sI0gQTgoyNDqoAAx9sSL7zsnKeku8p54"},"signatures":{"localhost":{"ed25519:a_CHdg":"H1pFAprrzDjT7aY1NNP2Fsxymh3kjIf6CgrFGx7KaCj0tEAQx8cQAx+YvWRx4owUmBpIrhxJcbyCJTEbfbY3Aw"}},"unsigned":{"age_ts":1672681853170}}	3
$GPeeyjoIFFM1Mp_pvKB55ZyVVmuSxQ3czNsjj5VxcZs	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672681778678.9","historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk"],"prev_events":["$D4biAJRc__54ONgjSEAYBzE8_j1ePGCqni93Os3tKhM"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_bridgeuser2:localhost","content":{"msgtype":"m.text","body":"klk"},"depth":34,"prev_state":[],"origin":"localhost","origin_server_ts":1672681778733,"hashes":{"sha256":"FzhTlp5AIQ2X7JMfF9A1WfnWSIvg2AAx5OQZ2uINJ7A"},"signatures":{"localhost":{"ed25519:a_CHdg":"Fd2wC4B528R7D3JRhb3VF2qpkRqMbqHm+L/81KMF0DC/+40ukAOm/cee15NzxkKfxFTcPALsgH5FtlBdzEZtAg"}},"unsigned":{"age_ts":1672681778733}}	3
$8u1nGQdQsFC_o-G3u1FrKnqITkatzs7OCMMVEir7wnk	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":16,"txn_id":"m1672681813354.2","historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw"],"prev_events":["$ge07snxHDhIl87w9HhFEY0Vf4fZF7sfC8ZgYVajdyBQ"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@admin:localhost","content":{"org.matrix.msc1767.text":"ssdff","body":"ssdff","msgtype":"m.text"},"depth":37,"prev_state":[],"origin":"localhost","origin_server_ts":1672681813452,"hashes":{"sha256":"H9/ScTUkCR43kkrffVC1niVpazTNZr/nhEw9tLAjJCI"},"signatures":{"localhost":{"ed25519:a_CHdg":"eqfG8/7XmH3Nuz40PzlLRLKFSExiuaKOXcK7S4ONk0OzWWYaRIW2A9NcREDWOEFf/aVomUS21+3K65iFgSofAQ"}},"unsigned":{"age_ts":1672681813452}}	3
$-F2yj6IuC13Z2Eri3_-fsH3NLCQXQ1igRElx9-Op2x4	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672681852683.11","historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk"],"prev_events":["$8u1nGQdQsFC_o-G3u1FrKnqITkatzs7OCMMVEir7wnk"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_bridgeuser2:localhost","content":{"msgtype":"m.text","body":"conf"},"depth":38,"prev_state":[],"origin":"localhost","origin_server_ts":1672681852726,"hashes":{"sha256":"4hT8W/8jSUBV4qF1hsaSaR8etOIQWsOgS0Pn9oLj6Cs"},"signatures":{"localhost":{"ed25519:a_CHdg":"OKYVbkOuATImLGfheSe7lSWwRfWGEE0pevEUgsYm/jjIzvqga1J1OMwkpvC8isAN/LOOYRmYgBcqoCVY/nWlAg"}},"unsigned":{"age_ts":1672681852726}}	3
$_aHR2VH_SqifxgVILz9ZPES5I390wFZQHGdjrgNSekM	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":16,"txn_id":"m1672681995104.3","historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw"],"prev_events":["$iKj1OUBZW17_u23PJes2dsEtLEQhEZBWblS4q6rzsjU"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@admin:localhost","content":{"org.matrix.msc1767.message":[{"body":"> <@admin:localhost> sent a file.\\n\\n\\ud83d\\udc4d\\ufe0f\\ud83d\\udc4d\\ufe0f","mimetype":"text/plain"},{"body":"<mx-reply><blockquote><a href=\\"https://matrix.to/#/!kmbTYjjsDRDHGgVqUP:localhost/$ge07snxHDhIl87w9HhFEY0Vf4fZF7sfC8ZgYVajdyBQ?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@admin:localhost\\">@admin:localhost</a><br>sent a file.</blockquote></mx-reply>\\ud83d\\udc4d\\ufe0f\\ud83d\\udc4d\\ufe0f","mimetype":"text/html"}],"body":"> <@admin:localhost> sent a file.\\n\\n\\ud83d\\udc4d\\ufe0f\\ud83d\\udc4d\\ufe0f","msgtype":"m.text","format":"org.matrix.custom.html","formatted_body":"<mx-reply><blockquote><a href=\\"https://matrix.to/#/!kmbTYjjsDRDHGgVqUP:localhost/$ge07snxHDhIl87w9HhFEY0Vf4fZF7sfC8ZgYVajdyBQ?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@admin:localhost\\">@admin:localhost</a><br>sent a file.</blockquote></mx-reply>\\ud83d\\udc4d\\ufe0f\\ud83d\\udc4d\\ufe0f","m.relates_to":{"m.in_reply_to":{"event_id":"$ge07snxHDhIl87w9HhFEY0Vf4fZF7sfC8ZgYVajdyBQ"}}},"depth":40,"prev_state":[],"origin":"localhost","origin_server_ts":1672681995176,"hashes":{"sha256":"1RznX2tHNgc2NI4EBqhix75b8XVggzEPX8ROA4EDe0g"},"signatures":{"localhost":{"ed25519:a_CHdg":"ptbAh55+fdV576PbGzfXaUfsCx92Ka3Y9Ftvt6EQp13WT9WDaYrGHffCQbXeandC4J9E8Tv9oEM/D3R8vQexAg"}},"unsigned":{"age_ts":1672681995176}}	3
$v72gLcqi6Rs213KYj3Q9EwPHikqyQNxPsM2PYcEx_yI	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":14,"txn_id":"m1672682559751.0","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$wttc0xGxavZKEFW4jhvY1iHmKn5fBDpTA47wmyrYJ6k","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$_aHR2VH_SqifxgVILz9ZPES5I390wFZQHGdjrgNSekM"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"org.matrix.msc1767.text":"\\ud83d\\ude36\\u200d\\ud83c\\udf2b\\ufe0fklkk","body":"\\ud83d\\ude36\\u200d\\ud83c\\udf2b\\ufe0fklkk","msgtype":"m.text"},"depth":41,"prev_state":[],"origin":"localhost","origin_server_ts":1672682559851,"hashes":{"sha256":"NW7vLp23NVlIf9xow89/bVdWukA73bJLSUvtTl8nB8Y"},"signatures":{"localhost":{"ed25519:a_CHdg":"WgszLgbyr1t9Dnvc/Ms2rVNsnTt0Ghyc/mHGKnmSCo1NVotRWWtWEG9kENsgLt6Q3cYZjc6sEpUC+UXMTbp9Dg"}},"unsigned":{"age_ts":1672682559851}}	3
$IF1JZZiHama5s_UHEDM0Lrd52rDP-14jwiiT7xvm8gk	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":14,"txn_id":"m1672682599435.1","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$wttc0xGxavZKEFW4jhvY1iHmKn5fBDpTA47wmyrYJ6k","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$v72gLcqi6Rs213KYj3Q9EwPHikqyQNxPsM2PYcEx_yI"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"org.matrix.msc1767.text":"\\ud83e\\udee5klkl","body":"\\ud83e\\udee5klkl","msgtype":"m.text"},"depth":42,"prev_state":[],"origin":"localhost","origin_server_ts":1672682599537,"hashes":{"sha256":"sjhSj4jYOECZE96nvb1ZAbZsHxvpw5Kh82n1TSHJdLM"},"signatures":{"localhost":{"ed25519:a_CHdg":"gRyuKVe2LdMxcBcd5k9R9ncMDI+YxHadGFvvs6TJurexYb88lUOmt9USQ7D2tlAQKgDzPySUcV8mD066qv+4DQ"}},"unsigned":{"age_ts":1672682599537}}	3
$nlOfoVdX08P1v2RQ_i1jakYQkuf0y1MGWr21M4pjQJU	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":14,"txn_id":"m1672682604757.2","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$wttc0xGxavZKEFW4jhvY1iHmKn5fBDpTA47wmyrYJ6k","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$IF1JZZiHama5s_UHEDM0Lrd52rDP-14jwiiT7xvm8gk"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"org.matrix.msc1767.text":"l\\u00f6l\\u00f6","body":"l\\u00f6l\\u00f6","msgtype":"m.text"},"depth":43,"prev_state":[],"origin":"localhost","origin_server_ts":1672682604854,"hashes":{"sha256":"smC80IJwhUtRi3xdVwcK2PyeGXB5fR3sHCitq6aCRUo"},"signatures":{"localhost":{"ed25519:a_CHdg":"MxQr06txnvTpUSrsEaIzHMpikxbLeRtiD2RAQc4+1HeK0IO7QPD+bilpkcA33NCHtfCJAvzkTa2h0UOw2JGtCw"}},"unsigned":{"age_ts":1672682604854}}	3
$AUKXpVUFnYNqEkGgCvdFpbjbYc6RVwJa6Lu4v1LGoBs	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672682627336.0","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk"],"prev_events":["$nlOfoVdX08P1v2RQ_i1jakYQkuf0y1MGWr21M4pjQJU"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_bridgeuser2:localhost","content":{"msgtype":"m.text","body":"klklkl"},"depth":44,"prev_state":[],"origin":"localhost","origin_server_ts":1672682627369,"hashes":{"sha256":"w1E+1MM2/TXnszMU/cnHH6Cot8bJk/IIfGQO/8ImTrU"},"signatures":{"localhost":{"ed25519:a_CHdg":"YXU3hFBqHe8DEd450X8LKaYuCTBXW8/MCDOtshTQRKL8Fe9sPa6VEm+XJQFQKwiIW4ZhxihtFiiTKTCCgs/SAA"}},"unsigned":{"age_ts":1672682627369}}	3
$1mBKLzxWBgLuS89oa3fbkVxTj_bUJ5krnjvFIGrcU2k	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":14,"txn_id":"m1672682646362.3","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$wttc0xGxavZKEFW4jhvY1iHmKn5fBDpTA47wmyrYJ6k","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$AUKXpVUFnYNqEkGgCvdFpbjbYc6RVwJa6Lu4v1LGoBs"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"org.matrix.msc1767.text":"\\ud83d\\udc4e\\ufe0fklkl","body":"\\ud83d\\udc4e\\ufe0fklkl","msgtype":"m.text"},"depth":45,"prev_state":[],"origin":"localhost","origin_server_ts":1672682646579,"hashes":{"sha256":"Iz7RSH+nar1Q/BalRojA3Zkx6kdAIOWVtnqHvWggcko"},"signatures":{"localhost":{"ed25519:a_CHdg":"F+9A4lLjUtU0Ccv2rNng+CHv+JOMhBsIYvaxRbRqToQnUm014pDocCHQxqo1nGmE9W3BsWLieHwsUKXAnI7NCQ"}},"unsigned":{"age_ts":1672682646579}}	3
$7mzkMAeImEcLYZGgGfqB1GHgCADF4xGJ7B-eojgjum4	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":14,"txn_id":"m1672682661892.4","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$wttc0xGxavZKEFW4jhvY1iHmKn5fBDpTA47wmyrYJ6k","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$1mBKLzxWBgLuS89oa3fbkVxTj_bUJ5krnjvFIGrcU2k"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"org.matrix.msc1767.text":"ok","body":"ok","msgtype":"m.text"},"depth":46,"prev_state":[],"origin":"localhost","origin_server_ts":1672682661985,"hashes":{"sha256":"wviOu+8FQbJa81sb9WlzEydHrG7dUAORe59b0jot49o"},"signatures":{"localhost":{"ed25519:a_CHdg":"V5+pplUIKMbFkQJJfNmBfYjjRpYeE/U9I1kn1zU+4vtgX1tSIiSaeNOrtLnoabwPLjZY+JQtQcgQLR0Ho18WBQ"}},"unsigned":{"age_ts":1672682661985}}	3
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
!kmbTYjjsDRDHGgVqUP:localhost	$FVhXs60ZUT4hfp8SPDQiJ9sUL5CV4MjGIsUfequDwEE	@matterbot:localhost	\N		21	42	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$FVhXs60ZUT4hfp8SPDQiJ9sUL5CV4MjGIsUfequDwEE	@ignored_user:localhost	\N		21	42	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$FVhXs60ZUT4hfp8SPDQiJ9sUL5CV4MjGIsUfequDwEE	@matrix_b:localhost	\N		21	42	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$MSYX67PL-aQgpnMS30mo0OLCFY11arvS2Ehe0I0SNAg	@matterbot:localhost	\N		22	43	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$MSYX67PL-aQgpnMS30mo0OLCFY11arvS2Ehe0I0SNAg	@ignored_user:localhost	\N		22	43	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$MSYX67PL-aQgpnMS30mo0OLCFY11arvS2Ehe0I0SNAg	@matrix_b:localhost	\N		22	43	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$NDRnMTvwTgCFfTb_vFmNwNe1o4a-UnPMEHKYvBFg1Ms	@matterbot:localhost	\N		21	44	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$NDRnMTvwTgCFfTb_vFmNwNe1o4a-UnPMEHKYvBFg1Ms	@ignored_user:localhost	\N		21	44	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$NDRnMTvwTgCFfTb_vFmNwNe1o4a-UnPMEHKYvBFg1Ms	@matrix_b:localhost	\N		21	44	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$jsgSLDcqxEQROuyA6P2myIoJf5N1kGLS_n8iWXwE-nU	@matterbot:localhost	\N		23	47	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$jsgSLDcqxEQROuyA6P2myIoJf5N1kGLS_n8iWXwE-nU	@ignored_user:localhost	\N		23	47	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$jsgSLDcqxEQROuyA6P2myIoJf5N1kGLS_n8iWXwE-nU	@matrix_b:localhost	\N		23	47	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$vg3binnx1kEog3C9nqvwJ7qPu28sTqYrZDssk0vab-Q	@matterbot:localhost	\N		24	48	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$vg3binnx1kEog3C9nqvwJ7qPu28sTqYrZDssk0vab-Q	@ignored_user:localhost	\N		24	48	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$vg3binnx1kEog3C9nqvwJ7qPu28sTqYrZDssk0vab-Q	@matrix_b:localhost	\N		24	48	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$YMb8Q2a5Xbnn70ZtQxPIimfv3Y9zSC67zsDIdEsRFJw	@matterbot:localhost	\N		25	49	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$YMb8Q2a5Xbnn70ZtQxPIimfv3Y9zSC67zsDIdEsRFJw	@ignored_user:localhost	\N		25	49	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$YMb8Q2a5Xbnn70ZtQxPIimfv3Y9zSC67zsDIdEsRFJw	@matrix_b:localhost	\N		25	49	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$d8OJKkkhp47jknk_LHO0c3d0-CSNWMzpJBRw6bOrQ4M	@matterbot:localhost	\N		26	50	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$d8OJKkkhp47jknk_LHO0c3d0-CSNWMzpJBRw6bOrQ4M	@ignored_user:localhost	\N		26	50	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$d8OJKkkhp47jknk_LHO0c3d0-CSNWMzpJBRw6bOrQ4M	@matrix_b:localhost	\N		26	50	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$obESo5AynBeb9xLH4sESBL5g-segSsJGjC9XER9ZTt8	@matterbot:localhost	\N		27	51	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$obESo5AynBeb9xLH4sESBL5g-segSsJGjC9XER9ZTt8	@ignored_user:localhost	\N		27	51	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$obESo5AynBeb9xLH4sESBL5g-segSsJGjC9XER9ZTt8	@matrix_b:localhost	\N		27	51	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$LkEO2DXJWjTGSlo7iokDO6KvigtD7BtSYgzN1bHF2q0	@ignored_user:localhost	\N		29	54	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$LkEO2DXJWjTGSlo7iokDO6KvigtD7BtSYgzN1bHF2q0	@matrix_b:localhost	\N		29	54	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$LkEO2DXJWjTGSlo7iokDO6KvigtD7BtSYgzN1bHF2q0	@matterbot:localhost	\N		29	54	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$RBYjw0bWPMbVEg8csvMs4tPORoqreh7W0cTgJTDKhxQ	@ignored_user:localhost	\N		30	55	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$RBYjw0bWPMbVEg8csvMs4tPORoqreh7W0cTgJTDKhxQ	@matrix_b:localhost	\N		30	55	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$RBYjw0bWPMbVEg8csvMs4tPORoqreh7W0cTgJTDKhxQ	@matterbot:localhost	\N		30	55	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$3J0wiu01NbTrOfOGZgRjSdNtX0P7ZN-PQp8qKcLDlmY	@ignored_user:localhost	\N		31	56	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$3J0wiu01NbTrOfOGZgRjSdNtX0P7ZN-PQp8qKcLDlmY	@matrix_b:localhost	\N		31	56	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$3J0wiu01NbTrOfOGZgRjSdNtX0P7ZN-PQp8qKcLDlmY	@matterbot:localhost	\N		31	56	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$qpoohVqO3c0vYCNBJuvRZHkBBNPQSrgwVwzIcbCfJJk	@ignored_user:localhost	\N		32	57	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$qpoohVqO3c0vYCNBJuvRZHkBBNPQSrgwVwzIcbCfJJk	@matrix_b:localhost	\N		32	57	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$qpoohVqO3c0vYCNBJuvRZHkBBNPQSrgwVwzIcbCfJJk	@matterbot:localhost	\N		32	57	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$FLa6I56u6EmzKm7SjplLhqPxGUZeJy_gEayv25svMwc	@ignored_user:localhost	\N		33	58	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$FLa6I56u6EmzKm7SjplLhqPxGUZeJy_gEayv25svMwc	@matrix_b:localhost	\N		33	58	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$FLa6I56u6EmzKm7SjplLhqPxGUZeJy_gEayv25svMwc	@matterbot:localhost	\N		33	58	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$uVCWC5TSVmmOhtnjhBprXQIqqNMmjlwAjnAbCFWCmSM	@ignored_user:localhost	\N		25	59	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$uVCWC5TSVmmOhtnjhBprXQIqqNMmjlwAjnAbCFWCmSM	@matrix_b:localhost	\N		25	59	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$uVCWC5TSVmmOhtnjhBprXQIqqNMmjlwAjnAbCFWCmSM	@matterbot:localhost	\N		25	59	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$ze3rHWp4q76u5HD9VeEM4tmvDPVyEGXfJ16m3GKAPBA	@ignored_user:localhost	\N		26	60	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$ze3rHWp4q76u5HD9VeEM4tmvDPVyEGXfJ16m3GKAPBA	@matrix_b:localhost	\N		26	60	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$ze3rHWp4q76u5HD9VeEM4tmvDPVyEGXfJ16m3GKAPBA	@matterbot:localhost	\N		26	60	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$wQdEIjcFyopFZpNGXmYD7mGBK2vx6nRTZFbp0tUAS5s	@ignored_user:localhost	\N		27	61	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$wQdEIjcFyopFZpNGXmYD7mGBK2vx6nRTZFbp0tUAS5s	@matrix_b:localhost	\N		27	61	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$wQdEIjcFyopFZpNGXmYD7mGBK2vx6nRTZFbp0tUAS5s	@matterbot:localhost	\N		27	61	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$vCLF-PjgFkWDlv9RC2q7AbemDp5Aq_wTHx26K7fVT2k	@ignored_user:localhost	\N		28	62	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$vCLF-PjgFkWDlv9RC2q7AbemDp5Aq_wTHx26K7fVT2k	@matrix_b:localhost	\N		28	62	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$vCLF-PjgFkWDlv9RC2q7AbemDp5Aq_wTHx26K7fVT2k	@matterbot:localhost	\N		28	62	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$CtsCO4y6Ci5lqltxoUXJqrNNDD4LeUErcBMp_5KFwdU	@ignored_user:localhost	\N		29	63	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$CtsCO4y6Ci5lqltxoUXJqrNNDD4LeUErcBMp_5KFwdU	@matrix_b:localhost	\N		29	63	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$CtsCO4y6Ci5lqltxoUXJqrNNDD4LeUErcBMp_5KFwdU	@matterbot:localhost	\N		29	63	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$8AX5D9nuhWswBU_Fc227Rvda1dcYTL38k5-nu5LYeow	@ignored_user:localhost	\N		30	64	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$8AX5D9nuhWswBU_Fc227Rvda1dcYTL38k5-nu5LYeow	@matrix_b:localhost	\N		30	64	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$8AX5D9nuhWswBU_Fc227Rvda1dcYTL38k5-nu5LYeow	@matterbot:localhost	\N		30	64	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$C_yOhTrkIxQT1pPwVX1TWe0UBFqH59o0aetXDnxNbb4	@ignored_user:localhost	\N		31	65	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$C_yOhTrkIxQT1pPwVX1TWe0UBFqH59o0aetXDnxNbb4	@matrix_a:localhost	\N		31	65	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$C_yOhTrkIxQT1pPwVX1TWe0UBFqH59o0aetXDnxNbb4	@matrix_b:localhost	\N		31	65	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$C_yOhTrkIxQT1pPwVX1TWe0UBFqH59o0aetXDnxNbb4	@matterbot:localhost	\N		31	65	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$7tsqPssEA6U65Qrd44F9FbFLND-JhznQ_c-4bXrIlRE	@ignored_user:localhost	\N		32	66	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$7tsqPssEA6U65Qrd44F9FbFLND-JhznQ_c-4bXrIlRE	@matrix_a:localhost	\N		32	66	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$7tsqPssEA6U65Qrd44F9FbFLND-JhznQ_c-4bXrIlRE	@matrix_b:localhost	\N		32	66	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$7tsqPssEA6U65Qrd44F9FbFLND-JhznQ_c-4bXrIlRE	@matterbot:localhost	\N		32	66	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$D4biAJRc__54ONgjSEAYBzE8_j1ePGCqni93Os3tKhM	@ignored_user:localhost	\N		33	67	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$D4biAJRc__54ONgjSEAYBzE8_j1ePGCqni93Os3tKhM	@matrix_a:localhost	\N		33	67	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$D4biAJRc__54ONgjSEAYBzE8_j1ePGCqni93Os3tKhM	@matrix_b:localhost	\N		33	67	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$D4biAJRc__54ONgjSEAYBzE8_j1ePGCqni93Os3tKhM	@matterbot:localhost	\N		33	67	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$GPeeyjoIFFM1Mp_pvKB55ZyVVmuSxQ3czNsjj5VxcZs	@ignored_user:localhost	\N		34	68	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$GPeeyjoIFFM1Mp_pvKB55ZyVVmuSxQ3czNsjj5VxcZs	@matrix_a:localhost	\N		34	68	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$GPeeyjoIFFM1Mp_pvKB55ZyVVmuSxQ3czNsjj5VxcZs	@matrix_b:localhost	\N		34	68	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$GPeeyjoIFFM1Mp_pvKB55ZyVVmuSxQ3czNsjj5VxcZs	@matterbot:localhost	\N		34	68	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$qIPcuD0d9eSflKKATXSbTJjoKFIBzNFk28nuN3007zo	@ignored_user:localhost	\N		35	69	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$qIPcuD0d9eSflKKATXSbTJjoKFIBzNFk28nuN3007zo	@matrix_a:localhost	\N		35	69	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$qIPcuD0d9eSflKKATXSbTJjoKFIBzNFk28nuN3007zo	@matrix_b:localhost	\N		35	69	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$qIPcuD0d9eSflKKATXSbTJjoKFIBzNFk28nuN3007zo	@matterbot:localhost	\N		35	69	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$ge07snxHDhIl87w9HhFEY0Vf4fZF7sfC8ZgYVajdyBQ	@ignored_user:localhost	\N		36	70	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$ge07snxHDhIl87w9HhFEY0Vf4fZF7sfC8ZgYVajdyBQ	@matrix_a:localhost	\N		36	70	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$ge07snxHDhIl87w9HhFEY0Vf4fZF7sfC8ZgYVajdyBQ	@matrix_b:localhost	\N		36	70	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$ge07snxHDhIl87w9HhFEY0Vf4fZF7sfC8ZgYVajdyBQ	@matterbot:localhost	\N		36	70	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$8u1nGQdQsFC_o-G3u1FrKnqITkatzs7OCMMVEir7wnk	@ignored_user:localhost	\N		37	71	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$8u1nGQdQsFC_o-G3u1FrKnqITkatzs7OCMMVEir7wnk	@matrix_a:localhost	\N		37	71	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$8u1nGQdQsFC_o-G3u1FrKnqITkatzs7OCMMVEir7wnk	@matrix_b:localhost	\N		37	71	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$8u1nGQdQsFC_o-G3u1FrKnqITkatzs7OCMMVEir7wnk	@matterbot:localhost	\N		37	71	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$iKj1OUBZW17_u23PJes2dsEtLEQhEZBWblS4q6rzsjU	@ignored_user:localhost	\N		39	73	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$-F2yj6IuC13Z2Eri3_-fsH3NLCQXQ1igRElx9-Op2x4	@ignored_user:localhost	\N		38	72	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$-F2yj6IuC13Z2Eri3_-fsH3NLCQXQ1igRElx9-Op2x4	@matrix_a:localhost	\N		38	72	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$-F2yj6IuC13Z2Eri3_-fsH3NLCQXQ1igRElx9-Op2x4	@matrix_b:localhost	\N		38	72	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$-F2yj6IuC13Z2Eri3_-fsH3NLCQXQ1igRElx9-Op2x4	@matterbot:localhost	\N		38	72	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$iKj1OUBZW17_u23PJes2dsEtLEQhEZBWblS4q6rzsjU	@matrix_a:localhost	\N		39	73	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$iKj1OUBZW17_u23PJes2dsEtLEQhEZBWblS4q6rzsjU	@matrix_b:localhost	\N		39	73	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$iKj1OUBZW17_u23PJes2dsEtLEQhEZBWblS4q6rzsjU	@matterbot:localhost	\N		39	73	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$_aHR2VH_SqifxgVILz9ZPES5I390wFZQHGdjrgNSekM	@ignored_user:localhost	\N		40	74	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$_aHR2VH_SqifxgVILz9ZPES5I390wFZQHGdjrgNSekM	@matrix_a:localhost	\N		40	74	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$_aHR2VH_SqifxgVILz9ZPES5I390wFZQHGdjrgNSekM	@matrix_b:localhost	\N		40	74	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$_aHR2VH_SqifxgVILz9ZPES5I390wFZQHGdjrgNSekM	@matterbot:localhost	\N		40	74	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$v72gLcqi6Rs213KYj3Q9EwPHikqyQNxPsM2PYcEx_yI	@matterbot:localhost	\N		41	75	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$v72gLcqi6Rs213KYj3Q9EwPHikqyQNxPsM2PYcEx_yI	@matrix_a:localhost	\N		41	75	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$v72gLcqi6Rs213KYj3Q9EwPHikqyQNxPsM2PYcEx_yI	@matrix_b:localhost	\N		41	75	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$v72gLcqi6Rs213KYj3Q9EwPHikqyQNxPsM2PYcEx_yI	@ignored_user:localhost	\N		41	75	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$v72gLcqi6Rs213KYj3Q9EwPHikqyQNxPsM2PYcEx_yI	@admin:localhost	\N		41	75	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$IF1JZZiHama5s_UHEDM0Lrd52rDP-14jwiiT7xvm8gk	@matterbot:localhost	\N		42	76	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$IF1JZZiHama5s_UHEDM0Lrd52rDP-14jwiiT7xvm8gk	@matrix_a:localhost	\N		42	76	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$IF1JZZiHama5s_UHEDM0Lrd52rDP-14jwiiT7xvm8gk	@matrix_b:localhost	\N		42	76	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$IF1JZZiHama5s_UHEDM0Lrd52rDP-14jwiiT7xvm8gk	@ignored_user:localhost	\N		42	76	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$IF1JZZiHama5s_UHEDM0Lrd52rDP-14jwiiT7xvm8gk	@admin:localhost	\N		42	76	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$nlOfoVdX08P1v2RQ_i1jakYQkuf0y1MGWr21M4pjQJU	@matterbot:localhost	\N		43	77	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$nlOfoVdX08P1v2RQ_i1jakYQkuf0y1MGWr21M4pjQJU	@matrix_a:localhost	\N		43	77	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$nlOfoVdX08P1v2RQ_i1jakYQkuf0y1MGWr21M4pjQJU	@matrix_b:localhost	\N		43	77	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$nlOfoVdX08P1v2RQ_i1jakYQkuf0y1MGWr21M4pjQJU	@ignored_user:localhost	\N		43	77	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$nlOfoVdX08P1v2RQ_i1jakYQkuf0y1MGWr21M4pjQJU	@admin:localhost	\N		43	77	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$AUKXpVUFnYNqEkGgCvdFpbjbYc6RVwJa6Lu4v1LGoBs	@matterbot:localhost	\N		44	78	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$AUKXpVUFnYNqEkGgCvdFpbjbYc6RVwJa6Lu4v1LGoBs	@matrix_a:localhost	\N		44	78	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$AUKXpVUFnYNqEkGgCvdFpbjbYc6RVwJa6Lu4v1LGoBs	@matrix_b:localhost	\N		44	78	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$AUKXpVUFnYNqEkGgCvdFpbjbYc6RVwJa6Lu4v1LGoBs	@ignored_user:localhost	\N		44	78	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$AUKXpVUFnYNqEkGgCvdFpbjbYc6RVwJa6Lu4v1LGoBs	@admin:localhost	\N		44	78	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$1mBKLzxWBgLuS89oa3fbkVxTj_bUJ5krnjvFIGrcU2k	@matterbot:localhost	\N		45	79	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$1mBKLzxWBgLuS89oa3fbkVxTj_bUJ5krnjvFIGrcU2k	@matrix_a:localhost	\N		45	79	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$1mBKLzxWBgLuS89oa3fbkVxTj_bUJ5krnjvFIGrcU2k	@matrix_b:localhost	\N		45	79	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$1mBKLzxWBgLuS89oa3fbkVxTj_bUJ5krnjvFIGrcU2k	@ignored_user:localhost	\N		45	79	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$1mBKLzxWBgLuS89oa3fbkVxTj_bUJ5krnjvFIGrcU2k	@admin:localhost	\N		45	79	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$7mzkMAeImEcLYZGgGfqB1GHgCADF4xGJ7B-eojgjum4	@matterbot:localhost	\N		46	80	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$7mzkMAeImEcLYZGgGfqB1GHgCADF4xGJ7B-eojgjum4	@matrix_a:localhost	\N		46	80	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$7mzkMAeImEcLYZGgGfqB1GHgCADF4xGJ7B-eojgjum4	@matrix_b:localhost	\N		46	80	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$7mzkMAeImEcLYZGgGfqB1GHgCADF4xGJ7B-eojgjum4	@ignored_user:localhost	\N		46	80	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$7mzkMAeImEcLYZGgGfqB1GHgCADF4xGJ7B-eojgjum4	@admin:localhost	\N		46	80	1	0	1
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
X	20
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
$Z2BDuqYr2x_4RtA8EmelcT41xj-7klcpKFvY5-POfVw	sha256	\\x676043baa62bdb1ff846d03c1267a5713e35c63fbb925729285bd8e7e3ce7d5c
$uuCt7OoWWYBzi7T3Jte6ntGxol6g760NhRDnyPvGMLA	sha256	\\xbae0adecea165980738bb4f726d7ba9ed1b1a25ea0efad0d8510e7c8fbc630b0
$IUtrl9K7UzIz2Mh8WwC4IwE46CubMgrjKFmHcXBu2Cg	sha256	\\x214b6b97d2bb533233d8c87c5b00b8230138e82b9b320ae328598771706ed828
$_ZI5M7wMM-QBKHgJHCRJC5LeBkOqglv0DLH3BAuL_mw	sha256	\\xfd923933bc0c33e4012878091c24490b92de0643aa825bf40cb1f7040b8bfe6c
$0qBcJsMAQpJ663R0qWtkO3DyspiocKFy-urTZsaZ3pw	sha256	\\xd2a05c26c30042927aeb7474a96b643b70f2b298a870a172faead366c699de9c
$lV2FDnpp7NRIRR5BdRLjhMfQU639aIzIumB6iT8p1ao	sha256	\\x955d850e7a69ecd448451e417512e384c7d053adfd688cc8ba607a893f29d5aa
$AhmCkSaIYchTfHKz-ScAJNw5JBnITPWbCCQxUwRuIjo	sha256	\\x02198291268861c8537c72b3f9270024dc392419c84cf59b08243153046e223a
$th-c5RZ-B0CMnKv9LtzPkBy_JfUuYDy4zUtX-8O9Rzg	sha256	\\xb61f9ce5167e07408c9cabfd2edccf901cbf25f52e603cb8cd4b57fbc3bd4738
$DjME4nek1Vnfgp8JIvyexbgZFnJ7UrCzBWYcgi5DRQE	sha256	\\x0e3304e277a4d559df829f0922fc9ec5b81916727b52b0b305661c822e434501
$wttc0xGxavZKEFW4jhvY1iHmKn5fBDpTA47wmyrYJ6k	sha256	\\xc2db5cd311b16af64a1055b88e1bd8d621e62a7e5f043a53038ef09b2ad827a9
$moj2kqPjW9Xd0RBTBX4Ee8HVebtt8aY6J7P3i6UT7qw	sha256	\\x9a88f692a3e35bd5ddd11053057e047bc1d579bb6df1a63a27b3f78ba513eeac
$DrKoz6WomICqVeub6PxHnTnu5NbhLDAg2J9rHOxBMmA	sha256	\\x0eb2a8cfa5a89880aa55eb9be8fc479d39eee4d6e12c3020d89f6b1cec413260
$hUQcgu2HJB2PDqWBrqIQkblhG-WvxXaIzHEnXw-Ej30	sha256	\\x85441c82ed87241d8f0ea581aea21091b9611be5afc57688cc71275f0f848f7d
$fkjIqV9H5dj_boKqogOxPeFW_m8yxwpxTgr4lSwePDY	sha256	\\x7e48c8a95f47e5d8ff6e82aaa203b13de156fe6f32c70a714e0af8952c1e3c36
$FUJQN-_4fHqBV5emsypqKHRRS0j5jbpMmuarjoIptOg	sha256	\\x15425037eff87c7a815797a6b32a6a2874514b48f98dba4c9ae6ab8e8229b4e8
$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk	sha256	\\x224ad875ec4a7dded6bee101966b0eebec6f526ef7efcdf3efbeffdbfcfd01f9
$fG61faFdiQLdggY7LGhSk_5yDw-HxLQiWURS7cCmAAc	sha256	\\x7c6eb57da15d8902dd82063b2c685293fe720f0f87c4b422594452edc0a60007
$ze3RfSNk1D8sruIVbtfFmFdyoNnUgcEoFtM7ULxeWMs	sha256	\\xcdedd17d2364d43f2caee2156ed7c5985772a0d9d481c12816d33b50bc5e58cb
$ifo4xdQDNVXvmkvgnrcj5o9iKblytzWMd_pEcRtWvx8	sha256	\\x89fa38c5d4033555ef9a4be09eb723e68f6229b972b7358c77fa44711b56bf1f
$BeKLUYL7qRfgvRH3qg2u6Z41GK2CNQqGwtAmWHwBWjA	sha256	\\x05e28b5182fba917e0bd11f7aa0daee99e3518ad82350a86c2d026587c015a30
$DOD9xnyV6gfI9j6KBsEdTpRu2l62hsRVmc9i6QLcseo	sha256	\\x0ce0fdc67c95ea07c8f63e8a06c11d4e946eda5eb686c45599cf62e902dcb1ea
$KG18kyO7FM4HavQZH_xZmXGUw1RbyfWhbs-Ds3u5vB8	sha256	\\x286d7c9323bb14ce076af4191ffc59997194c3545bc9f5a16ecf83b37bb9bc1f
$FVhXs60ZUT4hfp8SPDQiJ9sUL5CV4MjGIsUfequDwEE	sha256	\\x155857b3ad19513e217e9f123c342227db142f9095e0c8c622c51f7aab83c041
$MSYX67PL-aQgpnMS30mo0OLCFY11arvS2Ehe0I0SNAg	sha256	\\x312617ebb3cbf9a420a67312df49a8d0e2c2158d756abbd2d8485ed08d123408
$NDRnMTvwTgCFfTb_vFmNwNe1o4a-UnPMEHKYvBFg1Ms	sha256	\\x343467313bf04e00857d36ffbc598dc0d7b5a386be5273cc107298bc1160d4cb
$sT18sK2FK6Bo7161sdufjmhywK9CsJHemT-D6fDbaWs	sha256	\\xb13d7cb0ad852ba068ef5eb5b1db9f8e6872c0af42b091de993f83e9f0db696b
$d05l2i-Vc2Zzx3bl0Vz-NnDVVhxgFQIctiPfGoz0Xjs	sha256	\\x774e65da2f95736673c776e5d15cfe3670d5561c6015021cb623df1a8cf45e3b
$jsgSLDcqxEQROuyA6P2myIoJf5N1kGLS_n8iWXwE-nU	sha256	\\x8ec8122c372ac444113aec80e8fda6c88a097f93759062d2fe7f22597c04fa75
$vg3binnx1kEog3C9nqvwJ7qPu28sTqYrZDssk0vab-Q	sha256	\\xbe0ddb8a79f1d641288370bd9eabf027ba8fbb6f2c4ea62b643b2c934bda6fe4
$YMb8Q2a5Xbnn70ZtQxPIimfv3Y9zSC67zsDIdEsRFJw	sha256	\\x60c6fc4366b95db9e7ef466d4313c88a67efdd8f73482ebbcec0c8744b11149c
$d8OJKkkhp47jknk_LHO0c3d0-CSNWMzpJBRw6bOrQ4M	sha256	\\x77c3892a4921a78ee392793f2c73b4737774f8248d58cce9241470e9b3ab4383
$obESo5AynBeb9xLH4sESBL5g-segSsJGjC9XER9ZTt8	sha256	\\xa1b112a390329c179bf712c7e2c11204be60fac7a04ac2468c2f57111f594edf
$CcTsy5iCDZyphUv5irDLp85iBq-btwDvTJahbK5ATzo	sha256	\\x09c4eccb98820d9ca9854bf98ab0cba7ce6206af9bb700ef4c96a16cae404f3a
$0F5VtbBOxf2d2OwQ46I3LM3tqAkj2YWFXSKWzfzdtT8	sha256	\\xd05e55b5b04ec5fd9dd8ec10e3a2372ccdeda80923d985855d2296cdfcddb53f
$LkEO2DXJWjTGSlo7iokDO6KvigtD7BtSYgzN1bHF2q0	sha256	\\x2e410ed835c95a34c64a5a3b8a89033ba2af8a0b43ec1b52620ccdd5b1c5daad
$RBYjw0bWPMbVEg8csvMs4tPORoqreh7W0cTgJTDKhxQ	sha256	\\x441623c346d63cc6d5120f1cb2f32ce2d3ce468aab7a1ed6d1c4e02530ca8714
$3J0wiu01NbTrOfOGZgRjSdNtX0P7ZN-PQp8qKcLDlmY	sha256	\\xdc9d308aed3535b4eb39f38666046349d36d5f43fb64df8f429f2a29c2c39666
$qpoohVqO3c0vYCNBJuvRZHkBBNPQSrgwVwzIcbCfJJk	sha256	\\xaa9a28855a8eddcd2f60234126ebd164790104d3d04ab830570cc871b09f2499
$FLa6I56u6EmzKm7SjplLhqPxGUZeJy_gEayv25svMwc	sha256	\\x14b6ba239eaee849b32a6ed28e994b86a3f119465e272fe011acafdb9b2f3307
$uVCWC5TSVmmOhtnjhBprXQIqqNMmjlwAjnAbCFWCmSM	sha256	\\xb950960b94d256698e86d9e3841a6b5d022aa8d3268e5c008e701b0855829923
$ze3rHWp4q76u5HD9VeEM4tmvDPVyEGXfJ16m3GKAPBA	sha256	\\xcdedeb1d6a78abbeaee470fd55e10ce2d9af0cf5721065df275ea6dc62803c10
$wQdEIjcFyopFZpNGXmYD7mGBK2vx6nRTZFbp0tUAS5s	sha256	\\xc10744223705ca8a456693465e6603ee61812b6bf1ea74536456e9d2d5004b9b
$vCLF-PjgFkWDlv9RC2q7AbemDp5Aq_wTHx26K7fVT2k	sha256	\\xbc22c5f8f8e016458396ff510b6abb01b7a60e9e40abfc131f1dba2bb7d54f69
$CtsCO4y6Ci5lqltxoUXJqrNNDD4LeUErcBMp_5KFwdU	sha256	\\x0adb023b8cba0a2e65aa5b71a145c9aab34d0c3e0b79412b701329ff9285c1d5
$8AX5D9nuhWswBU_Fc227Rvda1dcYTL38k5-nu5LYeow	sha256	\\xf005f90fd9ee856b30054fc5736dbb46f75ad5d7184cbdfc939fa7bb92d87a8c
$C_yOhTrkIxQT1pPwVX1TWe0UBFqH59o0aetXDnxNbb4	sha256	\\x0bfc8e853ae4231413d693f0557d5359ed14045a87e7da3469eb570e7c4d6dbe
$7tsqPssEA6U65Qrd44F9FbFLND-JhznQ_c-4bXrIlRE	sha256	\\xeedb2a3ecb0403a53ae50adde3817d15b14b343f898739d0fdcfb86d7ac89511
$D4biAJRc__54ONgjSEAYBzE8_j1ePGCqni93Os3tKhM	sha256	\\x0f86e200945cfffe7838d82348401807313cfe3d5e3c60aa9e2f773acded2a13
$GPeeyjoIFFM1Mp_pvKB55ZyVVmuSxQ3czNsjj5VxcZs	sha256	\\x18f79eca3a08145335329fe9bca079e59c95566b92c50ddcccdb238f9571719b
$qIPcuD0d9eSflKKATXSbTJjoKFIBzNFk28nuN3007zo	sha256	\\xa883dcb83d1df5e49f94a2804d749b4c98e8285201ccd164dbc9ee377d34ef3a
$ge07snxHDhIl87w9HhFEY0Vf4fZF7sfC8ZgYVajdyBQ	sha256	\\x81ed3bb27c470e1225f3bc3d1e114463455fe1f645eec7c2f1981855a8ddc814
$8u1nGQdQsFC_o-G3u1FrKnqITkatzs7OCMMVEir7wnk	sha256	\\xf2ed67190750b050bfa3e1b7bb516b2a7a884e46adcecece08c315122afbc279
$-F2yj6IuC13Z2Eri3_-fsH3NLCQXQ1igRElx9-Op2x4	sha256	\\xf85db28fa22e0b5dd9d84ae2dfff9fb07dcd2c24174358a0444971f7e3a9db1e
$iKj1OUBZW17_u23PJes2dsEtLEQhEZBWblS4q6rzsjU	sha256	\\x88a8f53940595b5effbb6dcf25eb3676c12d2c44211190566e54b8abaaf3b235
$_aHR2VH_SqifxgVILz9ZPES5I390wFZQHGdjrgNSekM	sha256	\\xfda1d1d951ff4aa89fc605482f3f593c44b9237f74c056501c6763ae03527a43
$v72gLcqi6Rs213KYj3Q9EwPHikqyQNxPsM2PYcEx_yI	sha256	\\xbfbda02dcaa2e91b36d772988f743d1303c78a4ab240dc4fb0cd8f61c131ff22
$IF1JZZiHama5s_UHEDM0Lrd52rDP-14jwiiT7xvm8gk	sha256	\\x205d496598876a66b9b3f5071033342eb779dab0cffb5e23c22893ef1be6f209
$nlOfoVdX08P1v2RQ_i1jakYQkuf0y1MGWr21M4pjQJU	sha256	\\x9e539fa15757d3c3f5bf6450fe2d636a461092e7f4cb53065abdb5338a634095
$AUKXpVUFnYNqEkGgCvdFpbjbYc6RVwJa6Lu4v1LGoBs	sha256	\\x014297a555059d836a1241a00af745a5b8db61ce9157025ae8bbb8bf52c6a01b
$1mBKLzxWBgLuS89oa3fbkVxTj_bUJ5krnjvFIGrcU2k	sha256	\\xd6604a2f3c560602ee4bcf686b77db915c538ff6d427992b9e3bc5206adc5369
$7mzkMAeImEcLYZGgGfqB1GHgCADF4xGJ7B-eojgjum4	sha256	\\xee6ce430078898470b6191a019fa81d461e00800c5e31189ec1f9ea23823ba6e
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
$FVhXs60ZUT4hfp8SPDQiJ9sUL5CV4MjGIsUfequDwEE	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'okokok':1	1672677856149	42
$MSYX67PL-aQgpnMS30mo0OLCFY11arvS2Ehe0I0SNAg	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'bridgeuser2':2 'cool':5 'localhost':3 'mm':1 'okokok':4	1672677893374	43
$NDRnMTvwTgCFfTb_vFmNwNe1o4a-UnPMEHKYvBFg1Ms	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'hi':1	1672677919372	44
$jsgSLDcqxEQROuyA6P2myIoJf5N1kGLS_n8iWXwE-nU	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'hi':1	1672678277871	47
$vg3binnx1kEog3C9nqvwJ7qPu28sTqYrZDssk0vab-Q	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'fine':1	1672678307400	48
$YMb8Q2a5Xbnn70ZtQxPIimfv3Y9zSC67zsDIdEsRFJw	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'klk':1	1672678315133	49
$d8OJKkkhp47jknk_LHO0c3d0-CSNWMzpJBRw6bOrQ4M	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'ok':1,2	1672678409182	50
$obESo5AynBeb9xLH4sESBL5g-segSsJGjC9XER9ZTt8	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'bye':3 'e':2	1672678428347	51
$LkEO2DXJWjTGSlo7iokDO6KvigtD7BtSYgzN1bHF2q0	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'ok':1	1672681261866	54
$RBYjw0bWPMbVEg8csvMs4tPORoqreh7W0cTgJTDKhxQ	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'ok':1	1672681270387	55
$3J0wiu01NbTrOfOGZgRjSdNtX0P7ZN-PQp8qKcLDlmY	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'pl':1	1672681275706	56
$qpoohVqO3c0vYCNBJuvRZHkBBNPQSrgwVwzIcbCfJJk	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'klklklkl':1	1672681331460	57
$FLa6I56u6EmzKm7SjplLhqPxGUZeJy_gEayv25svMwc	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'lölöl':1	1672681344588	58
$uVCWC5TSVmmOhtnjhBprXQIqqNMmjlwAjnAbCFWCmSM	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'klklklk':1	1672681360085	59
$ze3rHWp4q76u5HD9VeEM4tmvDPVyEGXfJ16m3GKAPBA	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'data':1	1672681380176	60
$wQdEIjcFyopFZpNGXmYD7mGBK2vx6nRTZFbp0tUAS5s	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'readme.md':1	1672681380629	61
$vCLF-PjgFkWDlv9RC2q7AbemDp5Aq_wTHx26K7fVT2k	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'readme.md':1	1672681414600	62
$CtsCO4y6Ci5lqltxoUXJqrNNDD4LeUErcBMp_5KFwdU	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'ok':1	1672681420303	63
$8AX5D9nuhWswBU_Fc227Rvda1dcYTL38k5-nu5LYeow	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'package.json':1	1672681454632	64
$C_yOhTrkIxQT1pPwVX1TWe0UBFqH59o0aetXDnxNbb4	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'playwright.config.ts':1	1672681674319	65
$7tsqPssEA6U65Qrd44F9FbFLND-JhznQ_c-4bXrIlRE	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'klk':1	1672681715671	66
$D4biAJRc__54ONgjSEAYBzE8_j1ePGCqni93Os3tKhM	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'docker-compose.yml':1	1672681716099	67
$GPeeyjoIFFM1Mp_pvKB55ZyVVmuSxQ3czNsjj5VxcZs	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'klk':1	1672681778733	68
$qIPcuD0d9eSflKKATXSbTJjoKFIBzNFk28nuN3007zo	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'dockerfil':1	1672681779092	69
$ge07snxHDhIl87w9HhFEY0Vf4fZF7sfC8ZgYVajdyBQ	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'package-lock.json':1	1672681807766	70
$8u1nGQdQsFC_o-G3u1FrKnqITkatzs7OCMMVEir7wnk	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'ssdff':1	1672681813452	71
$-F2yj6IuC13Z2Eri3_-fsH3NLCQXQ1igRElx9-Op2x4	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'conf':1	1672681852726	72
$iKj1OUBZW17_u23PJes2dsEtLEQhEZBWblS4q6rzsjU	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'nginx.conf':1	1672681853170	73
$_aHR2VH_SqifxgVILz9ZPES5I390wFZQHGdjrgNSekM	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'admin':1 'file':5 'localhost':2 'sent':3 '👍️👍️':6	1672681995176	74
$v72gLcqi6Rs213KYj3Q9EwPHikqyQNxPsM2PYcEx_yI	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'😶‍🌫️klkk':1	1672682559851	75
$IF1JZZiHama5s_UHEDM0Lrd52rDP-14jwiiT7xvm8gk	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'🫥klkl':1	1672682599537	76
$nlOfoVdX08P1v2RQ_i1jakYQkuf0y1MGWr21M4pjQJU	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'lölö':1	1672682604854	77
$AUKXpVUFnYNqEkGgCvdFpbjbYc6RVwJa6Lu4v1LGoBs	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'klklkl':1	1672682627369	78
$1mBKLzxWBgLuS89oa3fbkVxTj_bUJ5krnjvFIGrcU2k	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'👎️klkl':1	1672682646579	79
$7mzkMAeImEcLYZGgGfqB1GHgCADF4xGJ7B-eojgjum4	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'ok':1	1672682661985	80
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
$Z2BDuqYr2x_4RtA8EmelcT41xj-7klcpKFvY5-POfVw	22
$uuCt7OoWWYBzi7T3Jte6ntGxol6g760NhRDnyPvGMLA	21
$IUtrl9K7UzIz2Mh8WwC4IwE46CubMgrjKFmHcXBu2Cg	23
$_ZI5M7wMM-QBKHgJHCRJC5LeBkOqglv0DLH3BAuL_mw	24
$0qBcJsMAQpJ663R0qWtkO3DyspiocKFy-urTZsaZ3pw	25
$lV2FDnpp7NRIRR5BdRLjhMfQU639aIzIumB6iT8p1ao	26
$AhmCkSaIYchTfHKz-ScAJNw5JBnITPWbCCQxUwRuIjo	27
$th-c5RZ-B0CMnKv9LtzPkBy_JfUuYDy4zUtX-8O9Rzg	28
$DjME4nek1Vnfgp8JIvyexbgZFnJ7UrCzBWYcgi5DRQE	29
$wttc0xGxavZKEFW4jhvY1iHmKn5fBDpTA47wmyrYJ6k	30
$moj2kqPjW9Xd0RBTBX4Ee8HVebtt8aY6J7P3i6UT7qw	31
$DrKoz6WomICqVeub6PxHnTnu5NbhLDAg2J9rHOxBMmA	32
$hUQcgu2HJB2PDqWBrqIQkblhG-WvxXaIzHEnXw-Ej30	33
$fkjIqV9H5dj_boKqogOxPeFW_m8yxwpxTgr4lSwePDY	34
$FUJQN-_4fHqBV5emsypqKHRRS0j5jbpMmuarjoIptOg	35
$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk	36
$fG61faFdiQLdggY7LGhSk_5yDw-HxLQiWURS7cCmAAc	37
$ze3RfSNk1D8sruIVbtfFmFdyoNnUgcEoFtM7ULxeWMs	38
$ifo4xdQDNVXvmkvgnrcj5o9iKblytzWMd_pEcRtWvx8	41
$BeKLUYL7qRfgvRH3qg2u6Z41GK2CNQqGwtAmWHwBWjA	42
$DOD9xnyV6gfI9j6KBsEdTpRu2l62hsRVmc9i6QLcseo	58
$KG18kyO7FM4HavQZH_xZmXGUw1RbyfWhbs-Ds3u5vB8	60
$FVhXs60ZUT4hfp8SPDQiJ9sUL5CV4MjGIsUfequDwEE	60
$MSYX67PL-aQgpnMS30mo0OLCFY11arvS2Ehe0I0SNAg	60
$NDRnMTvwTgCFfTb_vFmNwNe1o4a-UnPMEHKYvBFg1Ms	58
$sT18sK2FK6Bo7161sdufjmhywK9CsJHemT-D6fDbaWs	215
$d05l2i-Vc2Zzx3bl0Vz-NnDVVhxgFQIctiPfGoz0Xjs	216
$jsgSLDcqxEQROuyA6P2myIoJf5N1kGLS_n8iWXwE-nU	215
$vg3binnx1kEog3C9nqvwJ7qPu28sTqYrZDssk0vab-Q	215
$YMb8Q2a5Xbnn70ZtQxPIimfv3Y9zSC67zsDIdEsRFJw	215
$d8OJKkkhp47jknk_LHO0c3d0-CSNWMzpJBRw6bOrQ4M	215
$obESo5AynBeb9xLH4sESBL5g-segSsJGjC9XER9ZTt8	215
$CcTsy5iCDZyphUv5irDLp85iBq-btwDvTJahbK5ATzo	230
$0F5VtbBOxf2d2OwQ46I3LM3tqAkj2YWFXSKWzfzdtT8	232
$LkEO2DXJWjTGSlo7iokDO6KvigtD7BtSYgzN1bHF2q0	232
$RBYjw0bWPMbVEg8csvMs4tPORoqreh7W0cTgJTDKhxQ	232
$3J0wiu01NbTrOfOGZgRjSdNtX0P7ZN-PQp8qKcLDlmY	232
$qpoohVqO3c0vYCNBJuvRZHkBBNPQSrgwVwzIcbCfJJk	232
$FLa6I56u6EmzKm7SjplLhqPxGUZeJy_gEayv25svMwc	232
$uVCWC5TSVmmOhtnjhBprXQIqqNMmjlwAjnAbCFWCmSM	230
$ze3rHWp4q76u5HD9VeEM4tmvDPVyEGXfJ16m3GKAPBA	230
$wQdEIjcFyopFZpNGXmYD7mGBK2vx6nRTZFbp0tUAS5s	230
$vCLF-PjgFkWDlv9RC2q7AbemDp5Aq_wTHx26K7fVT2k	230
$CtsCO4y6Ci5lqltxoUXJqrNNDD4LeUErcBMp_5KFwdU	230
$8AX5D9nuhWswBU_Fc227Rvda1dcYTL38k5-nu5LYeow	230
$C_yOhTrkIxQT1pPwVX1TWe0UBFqH59o0aetXDnxNbb4	230
$7tsqPssEA6U65Qrd44F9FbFLND-JhznQ_c-4bXrIlRE	230
$D4biAJRc__54ONgjSEAYBzE8_j1ePGCqni93Os3tKhM	230
$GPeeyjoIFFM1Mp_pvKB55ZyVVmuSxQ3czNsjj5VxcZs	230
$qIPcuD0d9eSflKKATXSbTJjoKFIBzNFk28nuN3007zo	230
$ge07snxHDhIl87w9HhFEY0Vf4fZF7sfC8ZgYVajdyBQ	230
$8u1nGQdQsFC_o-G3u1FrKnqITkatzs7OCMMVEir7wnk	230
$-F2yj6IuC13Z2Eri3_-fsH3NLCQXQ1igRElx9-Op2x4	230
$iKj1OUBZW17_u23PJes2dsEtLEQhEZBWblS4q6rzsjU	230
$_aHR2VH_SqifxgVILz9ZPES5I390wFZQHGdjrgNSekM	230
$v72gLcqi6Rs213KYj3Q9EwPHikqyQNxPsM2PYcEx_yI	230
$IF1JZZiHama5s_UHEDM0Lrd52rDP-14jwiiT7xvm8gk	230
$nlOfoVdX08P1v2RQ_i1jakYQkuf0y1MGWr21M4pjQJU	230
$AUKXpVUFnYNqEkGgCvdFpbjbYc6RVwJa6Lu4v1LGoBs	230
$1mBKLzxWBgLuS89oa3fbkVxTj_bUJ5krnjvFIGrcU2k	230
$7mzkMAeImEcLYZGgGfqB1GHgCADF4xGJ7B-eojgjum4	230
\.


--
-- Data for Name: event_txn_id; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_txn_id (event_id, room_id, user_id, token_id, txn_id, inserted_ts) FROM stdin;
$v72gLcqi6Rs213KYj3Q9EwPHikqyQNxPsM2PYcEx_yI	!kmbTYjjsDRDHGgVqUP:localhost	@mm_mattermost_a:localhost	14	m1672682559751.0	1672682559936
$IF1JZZiHama5s_UHEDM0Lrd52rDP-14jwiiT7xvm8gk	!kmbTYjjsDRDHGgVqUP:localhost	@mm_mattermost_a:localhost	14	m1672682599435.1	1672682599595
$nlOfoVdX08P1v2RQ_i1jakYQkuf0y1MGWr21M4pjQJU	!kmbTYjjsDRDHGgVqUP:localhost	@mm_mattermost_a:localhost	14	m1672682604757.2	1672682604909
$1mBKLzxWBgLuS89oa3fbkVxTj_bUJ5krnjvFIGrcU2k	!kmbTYjjsDRDHGgVqUP:localhost	@mm_mattermost_a:localhost	14	m1672682646362.3	1672682646635
$7mzkMAeImEcLYZGgGfqB1GHgCADF4xGJ7B-eojgjum4	!kmbTYjjsDRDHGgVqUP:localhost	@mm_mattermost_a:localhost	14	m1672682661892.4	1672682662018
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
10	$Z2BDuqYr2x_4RtA8EmelcT41xj-7klcpKFvY5-POfVw	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	10	1672674596102	1672674596203	@matterbot:localhost	f	master	20
10	$uuCt7OoWWYBzi7T3Jte6ntGxol6g760NhRDnyPvGMLA	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	10	1672674596091	1672674596204	@matterbot:localhost	f	master	21
11	$IUtrl9K7UzIz2Mh8WwC4IwE46CubMgrjKFmHcXBu2Cg	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	11	1672674602948	1672674603101	@matterbot:localhost	f	master	22
11	$_ZI5M7wMM-QBKHgJHCRJC5LeBkOqglv0DLH3BAuL_mw	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	11	1672674603192	1672674603331	@matterbot:localhost	f	master	23
12	$0qBcJsMAQpJ663R0qWtkO3DyspiocKFy-urTZsaZ3pw	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	12	1672674603303	1672674603360	@matterbot:localhost	f	master	24
12	$lV2FDnpp7NRIRR5BdRLjhMfQU639aIzIumB6iT8p1ao	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	12	1672674603466	1672674603575	@matterbot:localhost	f	master	25
13	$AhmCkSaIYchTfHKz-ScAJNw5JBnITPWbCCQxUwRuIjo	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	13	1672674603569	1672674603606	@mm_mattermost_b:localhost	f	master	26
13	$th-c5RZ-B0CMnKv9LtzPkBy_JfUuYDy4zUtX-8O9Rzg	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	13	1672674603703	1672674603812	@mm_mattermost_b:localhost	f	master	27
14	$DjME4nek1Vnfgp8JIvyexbgZFnJ7UrCzBWYcgi5DRQE	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	14	1672674603823	1672674603875	@mm_mattermost_a:localhost	f	master	28
14	$wttc0xGxavZKEFW4jhvY1iHmKn5fBDpTA47wmyrYJ6k	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	14	1672674603955	1672674604043	@mm_mattermost_a:localhost	f	master	29
15	$moj2kqPjW9Xd0RBTBX4Ee8HVebtt8aY6J7P3i6UT7qw	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	15	1672675303518	1672675303605	@matterbot:localhost	f	master	30
16	$DrKoz6WomICqVeub6PxHnTnu5NbhLDAg2J9rHOxBMmA	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	16	1672675303740	1672675303763	@mm_bridgeuser1:localhost	f	master	31
15	$hUQcgu2HJB2PDqWBrqIQkblhG-WvxXaIzHEnXw-Ej30	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	15	1672675303868	1672675303903	@matterbot:localhost	f	master	32
16	$fkjIqV9H5dj_boKqogOxPeFW_m8yxwpxTgr4lSwePDY	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	16	1672675304004	1672675304030	@mm_bridgeuser1:localhost	f	master	33
17	$FUJQN-_4fHqBV5emsypqKHRRS0j5jbpMmuarjoIptOg	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	17	1672675304229	1672675304271	@matterbot:localhost	f	master	34
18	$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	18	1672675304372	1672675304398	@mm_bridgeuser2:localhost	f	master	35
17	$fG61faFdiQLdggY7LGhSk_5yDw-HxLQiWURS7cCmAAc	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	17	1672675304507	1672675304536	@matterbot:localhost	f	master	36
18	$ze3RfSNk1D8sruIVbtfFmFdyoNnUgcEoFtM7ULxeWMs	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	18	1672675304634	1672675304656	@mm_bridgeuser2:localhost	f	master	37
19	$ifo4xdQDNVXvmkvgnrcj5o9iKblytzWMd_pEcRtWvx8	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	19	1672676284187	1672676284271	@mm_bridgeuser1:localhost	f	master	38
19	$BeKLUYL7qRfgvRH3qg2u6Z41GK2CNQqGwtAmWHwBWjA	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	19	1672676284551	1672676284637	@mm_bridgeuser1:localhost	f	master	39
20	$DOD9xnyV6gfI9j6KBsEdTpRu2l62hsRVmc9i6QLcseo	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	20	1672677122498	1672677122537	@mm_bridgeuser1:localhost	f	master	40
20	$KG18kyO7FM4HavQZH_xZmXGUw1RbyfWhbs-Ds3u5vB8	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	20	1672677122663	1672677122723	@mm_bridgeuser1:localhost	f	master	41
21	$FVhXs60ZUT4hfp8SPDQiJ9sUL5CV4MjGIsUfequDwEE	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	21	1672677856149	1672677856189	@mm_bridgeuser2:localhost	f	master	42
22	$MSYX67PL-aQgpnMS30mo0OLCFY11arvS2Ehe0I0SNAg	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	22	1672677893374	1672677893450	@matrix_a:localhost	f	master	43
21	$NDRnMTvwTgCFfTb_vFmNwNe1o4a-UnPMEHKYvBFg1Ms	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	21	1672677919372	1672677919413	@mm_bridgeuser2:localhost	f	master	44
22	$sT18sK2FK6Bo7161sdufjmhywK9CsJHemT-D6fDbaWs	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	22	1672678123680	1672678123730	@mm_bridgeuser1:localhost	f	master	45
24	$vg3binnx1kEog3C9nqvwJ7qPu28sTqYrZDssk0vab-Q	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	24	1672678307400	1672678307433	@mm_bridgeuser2:localhost	f	master	48
26	$d8OJKkkhp47jknk_LHO0c3d0-CSNWMzpJBRw6bOrQ4M	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	26	1672678409182	1672678409224	@mm_bridgeuser2:localhost	f	master	50
23	$d05l2i-Vc2Zzx3bl0Vz-NnDVVhxgFQIctiPfGoz0Xjs	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	23	1672678123962	1672678124114	@mm_bridgeuser1:localhost	f	master	46
23	$jsgSLDcqxEQROuyA6P2myIoJf5N1kGLS_n8iWXwE-nU	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	23	1672678277871	1672678277914	@mm_bridgeuser2:localhost	f	master	47
25	$YMb8Q2a5Xbnn70ZtQxPIimfv3Y9zSC67zsDIdEsRFJw	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	25	1672678315133	1672678315176	@mm_bridgeuser1:localhost	f	master	49
27	$obESo5AynBeb9xLH4sESBL5g-segSsJGjC9XER9ZTt8	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	27	1672678428347	1672678428390	@matrix_a:localhost	f	master	51
24	$CcTsy5iCDZyphUv5irDLp85iBq-btwDvTJahbK5ATzo	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	24	1672681243650	1672681243740	@mm_bridgeuser1:localhost	f	master	52
28	$0F5VtbBOxf2d2OwQ46I3LM3tqAkj2YWFXSKWzfzdtT8	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	28	1672681243845	1672681243922	@mm_bridgeuser1:localhost	f	master	53
29	$LkEO2DXJWjTGSlo7iokDO6KvigtD7BtSYgzN1bHF2q0	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	29	1672681261866	1672681261952	@mm_bridgeuser2:localhost	f	master	54
30	$RBYjw0bWPMbVEg8csvMs4tPORoqreh7W0cTgJTDKhxQ	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	30	1672681270387	1672681270444	@mm_bridgeuser2:localhost	f	master	55
31	$3J0wiu01NbTrOfOGZgRjSdNtX0P7ZN-PQp8qKcLDlmY	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	31	1672681275706	1672681275759	@mm_bridgeuser2:localhost	f	master	56
32	$qpoohVqO3c0vYCNBJuvRZHkBBNPQSrgwVwzIcbCfJJk	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	32	1672681331460	1672681331518	@mm_bridgeuser2:localhost	f	master	57
33	$FLa6I56u6EmzKm7SjplLhqPxGUZeJy_gEayv25svMwc	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	33	1672681344588	1672681344646	@matrix_a:localhost	f	master	58
25	$uVCWC5TSVmmOhtnjhBprXQIqqNMmjlwAjnAbCFWCmSM	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	25	1672681360085	1672681360132	@mm_bridgeuser2:localhost	f	master	59
26	$ze3rHWp4q76u5HD9VeEM4tmvDPVyEGXfJ16m3GKAPBA	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	26	1672681380176	1672681380218	@mm_bridgeuser2:localhost	f	master	60
27	$wQdEIjcFyopFZpNGXmYD7mGBK2vx6nRTZFbp0tUAS5s	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	27	1672681380629	1672681380689	@mm_bridgeuser2:localhost	t	master	61
28	$vCLF-PjgFkWDlv9RC2q7AbemDp5Aq_wTHx26K7fVT2k	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	28	1672681414600	1672681414647	@matrix_a:localhost	t	master	62
29	$CtsCO4y6Ci5lqltxoUXJqrNNDD4LeUErcBMp_5KFwdU	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	29	1672681420303	1672681420335	@matrix_a:localhost	f	master	63
30	$8AX5D9nuhWswBU_Fc227Rvda1dcYTL38k5-nu5LYeow	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	30	1672681454632	1672681454687	@matrix_a:localhost	t	master	64
31	$C_yOhTrkIxQT1pPwVX1TWe0UBFqH59o0aetXDnxNbb4	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	31	1672681674319	1672681674371	@admin:localhost	t	master	65
32	$7tsqPssEA6U65Qrd44F9FbFLND-JhznQ_c-4bXrIlRE	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	32	1672681715671	1672681715722	@mm_bridgeuser2:localhost	f	master	66
33	$D4biAJRc__54ONgjSEAYBzE8_j1ePGCqni93Os3tKhM	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	33	1672681716099	1672681716133	@mm_bridgeuser2:localhost	t	master	67
34	$GPeeyjoIFFM1Mp_pvKB55ZyVVmuSxQ3czNsjj5VxcZs	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	34	1672681778733	1672681778775	@mm_bridgeuser2:localhost	f	master	68
35	$qIPcuD0d9eSflKKATXSbTJjoKFIBzNFk28nuN3007zo	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	35	1672681779092	1672681779116	@mm_bridgeuser2:localhost	t	master	69
36	$ge07snxHDhIl87w9HhFEY0Vf4fZF7sfC8ZgYVajdyBQ	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	36	1672681807766	1672681807812	@admin:localhost	t	master	70
37	$8u1nGQdQsFC_o-G3u1FrKnqITkatzs7OCMMVEir7wnk	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	37	1672681813452	1672681813498	@admin:localhost	f	master	71
38	$-F2yj6IuC13Z2Eri3_-fsH3NLCQXQ1igRElx9-Op2x4	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	38	1672681852726	1672681852790	@mm_bridgeuser2:localhost	f	master	72
39	$iKj1OUBZW17_u23PJes2dsEtLEQhEZBWblS4q6rzsjU	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	39	1672681853170	1672681853205	@mm_bridgeuser2:localhost	t	master	73
40	$_aHR2VH_SqifxgVILz9ZPES5I390wFZQHGdjrgNSekM	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	40	1672681995176	1672681995216	@admin:localhost	f	master	74
41	$v72gLcqi6Rs213KYj3Q9EwPHikqyQNxPsM2PYcEx_yI	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	41	1672682559851	1672682559934	@mm_mattermost_a:localhost	f	master	75
42	$IF1JZZiHama5s_UHEDM0Lrd52rDP-14jwiiT7xvm8gk	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	42	1672682599537	1672682599592	@mm_mattermost_a:localhost	f	master	76
43	$nlOfoVdX08P1v2RQ_i1jakYQkuf0y1MGWr21M4pjQJU	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	43	1672682604854	1672682604906	@mm_mattermost_a:localhost	f	master	77
44	$AUKXpVUFnYNqEkGgCvdFpbjbYc6RVwJa6Lu4v1LGoBs	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	44	1672682627369	1672682627415	@mm_bridgeuser2:localhost	f	master	78
45	$1mBKLzxWBgLuS89oa3fbkVxTj_bUJ5krnjvFIGrcU2k	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	45	1672682646579	1672682646628	@mm_mattermost_a:localhost	f	master	79
46	$7mzkMAeImEcLYZGgGfqB1GHgCADF4xGJ7B-eojgjum4	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	46	1672682661985	1672682662017	@mm_mattermost_a:localhost	f	master	80
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
events	80	master
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
!kmbTYjjsDRDHGgVqUP:localhost	@matterbot:localhost	$Z2BDuqYr2x_4RtA8EmelcT41xj-7klcpKFvY5-POfVw	join
!dKcbdDATuwwphjRPQP:localhost	@matterbot:localhost	$uuCt7OoWWYBzi7T3Jte6ntGxol6g760NhRDnyPvGMLA	join
!dKcbdDATuwwphjRPQP:localhost	@mm_mattermost_b:localhost	$AhmCkSaIYchTfHKz-ScAJNw5JBnITPWbCCQxUwRuIjo	join
!kmbTYjjsDRDHGgVqUP:localhost	@mm_mattermost_b:localhost	$th-c5RZ-B0CMnKv9LtzPkBy_JfUuYDy4zUtX-8O9Rzg	join
!dKcbdDATuwwphjRPQP:localhost	@mm_mattermost_a:localhost	$DjME4nek1Vnfgp8JIvyexbgZFnJ7UrCzBWYcgi5DRQE	join
!kmbTYjjsDRDHGgVqUP:localhost	@mm_mattermost_a:localhost	$wttc0xGxavZKEFW4jhvY1iHmKn5fBDpTA47wmyrYJ6k	join
!kmbTYjjsDRDHGgVqUP:localhost	@mm_bridgeuser2:localhost	$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk	join
!dKcbdDATuwwphjRPQP:localhost	@mm_bridgeuser2:localhost	$ze3RfSNk1D8sruIVbtfFmFdyoNnUgcEoFtM7ULxeWMs	join
!kmbTYjjsDRDHGgVqUP:localhost	@mm_bridgeuser1:localhost	$CcTsy5iCDZyphUv5irDLp85iBq-btwDvTJahbK5ATzo	join
!dKcbdDATuwwphjRPQP:localhost	@mm_bridgeuser1:localhost	$0F5VtbBOxf2d2OwQ46I3LM3tqAkj2YWFXSKWzfzdtT8	join
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
GuGmZcSQoAvjfaruEvcaZCws	application/octet-stream	2501	1672681380552	README.md	@mm_bridgeuser2:localhost	\N	\N	\N	f
qlZtzZJiheQYCQsPJZKPloGw		14	1672681414484	README.md	@matrix_a:localhost	\N	\N	\N	f
tOOcAZHFIHUrslceWBfnuyVf	application/json	259	1672681454541	package.json	@matrix_a:localhost	\N	\N	\N	f
kmACnWKAAOsZJUXvlOQAmvPY		1608	1672681674215	playwright.config.ts	@admin:localhost	\N	\N	\N	f
ENppMmCHcHDSyzFenKdFriGH	application/octet-stream	353	1672681853002	nginx.conf	@mm_bridgeuser2:localhost	\N	\N	1672681876398	f
HrygdBDWifMNkZMAjjZqASQE	application/json	3107	1672681807675	package-lock.json	@admin:localhost	\N	\N	1672681876398	f
AaIOLDlmkQIhJCYLMJzOrirc	application/octet-stream	558	1672681715940	docker-compose.yml	@mm_bridgeuser2:localhost	\N	\N	1672681936391	f
RGhmrIGOwMsaNgdGLQhxdtAd	application/octet-stream	159	1672681778960	Dockerfile	@mm_bridgeuser2:localhost	\N	\N	1672681996393	f
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
53	@mm_bridgeuser1:localhost	offline	1672678345588	1672678400227	1672678346262	\N	t	master
69	@matrix_a:localhost	offline	1672681485086	1672681546315	1672681511890	\N	t	master
75	@bridgeadmin:localhost	offline	1672681609534	1672681756317	1672681634934	\N	t	master
87	@admin:localhost	offline	1672682055504	1672682358957	1672682055504	\N	t	master
93	@mm_bridgeuser2:localhost	offline	1672682627580	1672682626343	0	\N	f	master
94	@mm_mattermost_a:localhost	online	1672682722191	1672682525968	1672682722191	\N	t	master
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.profiles (user_id, displayname, avatar_url) FROM stdin;
matrix_b	matrix_b	\N
ignored_user	ignored_user	\N
matterbot	Mattermost Bridge	\N
bridgeadmin	bridgeadmin	\N
bridgeuser1	bridgeuser1	\N
bridgeuser2	bridgeuser2	\N
admin	admin	\N
matrix_a	matrix_a	\N
mm_mattermost_a	MattermostUser A [mm]	\N
mm_bridgeuser2	bridgeuser2 [mm]	\N
mm_bridgeuser1	bridgeuser1 [mm]	\N
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
!kmbTYjjsDRDHGgVqUP:localhost	m.read	@mm_bridgeuser1:localhost	["$MSYX67PL-aQgpnMS30mo0OLCFY11arvS2Ehe0I0SNAg"]	{"ts":1672678207169,"hidden":false}
!dKcbdDATuwwphjRPQP:localhost	m.read	@mm_bridgeuser1:localhost	["$vg3binnx1kEog3C9nqvwJ7qPu28sTqYrZDssk0vab-Q"]	{"ts":1672678310688,"hidden":false}
!dKcbdDATuwwphjRPQP:localhost	m.read	@matrix_a:localhost	["$qpoohVqO3c0vYCNBJuvRZHkBBNPQSrgwVwzIcbCfJJk"]	{"ts":1672681335310,"hidden":false}
!kmbTYjjsDRDHGgVqUP:localhost	m.read	@matrix_a:localhost	["$wQdEIjcFyopFZpNGXmYD7mGBK2vx6nRTZFbp0tUAS5s"]	{"ts":1672681387313,"hidden":false}
!dKcbdDATuwwphjRPQP:localhost	m.read	@admin:localhost	["$FLa6I56u6EmzKm7SjplLhqPxGUZeJy_gEayv25svMwc"]	{"ts":1672681656265,"hidden":false}
!kmbTYjjsDRDHGgVqUP:localhost	m.read	@admin:localhost	["$iKj1OUBZW17_u23PJes2dsEtLEQhEZBWblS4q6rzsjU"]	{"ts":1672681856014,"hidden":false}
!dKcbdDATuwwphjRPQP:localhost	m.read	@mm_mattermost_a:localhost	["$FLa6I56u6EmzKm7SjplLhqPxGUZeJy_gEayv25svMwc"]	{"ts":1672682533473,"hidden":false}
!kmbTYjjsDRDHGgVqUP:localhost	m.read	@mm_mattermost_a:localhost	["$AUKXpVUFnYNqEkGgCvdFpbjbYc6RVwJa6Lu4v1LGoBs"]	{"ts":1672682631406,"hidden":false}
\.


--
-- Data for Name: receipts_linearized; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.receipts_linearized (stream_id, room_id, receipt_type, user_id, event_id, data, instance_name) FROM stdin;
5	!kmbTYjjsDRDHGgVqUP:localhost	m.read	@mm_bridgeuser1:localhost	$MSYX67PL-aQgpnMS30mo0OLCFY11arvS2Ehe0I0SNAg	{"ts":1672678207169,"hidden":false}	\N
8	!dKcbdDATuwwphjRPQP:localhost	m.read	@mm_bridgeuser1:localhost	$vg3binnx1kEog3C9nqvwJ7qPu28sTqYrZDssk0vab-Q	{"ts":1672678310688,"hidden":false}	\N
14	!dKcbdDATuwwphjRPQP:localhost	m.read	@matrix_a:localhost	$qpoohVqO3c0vYCNBJuvRZHkBBNPQSrgwVwzIcbCfJJk	{"ts":1672681335310,"hidden":false}	\N
15	!kmbTYjjsDRDHGgVqUP:localhost	m.read	@matrix_a:localhost	$wQdEIjcFyopFZpNGXmYD7mGBK2vx6nRTZFbp0tUAS5s	{"ts":1672681387313,"hidden":false}	\N
16	!dKcbdDATuwwphjRPQP:localhost	m.read	@admin:localhost	$FLa6I56u6EmzKm7SjplLhqPxGUZeJy_gEayv25svMwc	{"ts":1672681656265,"hidden":false}	\N
20	!kmbTYjjsDRDHGgVqUP:localhost	m.read	@admin:localhost	$iKj1OUBZW17_u23PJes2dsEtLEQhEZBWblS4q6rzsjU	{"ts":1672681856014,"hidden":false}	\N
21	!dKcbdDATuwwphjRPQP:localhost	m.read	@mm_mattermost_a:localhost	$FLa6I56u6EmzKm7SjplLhqPxGUZeJy_gEayv25svMwc	{"ts":1672682533473,"hidden":false}	\N
23	!kmbTYjjsDRDHGgVqUP:localhost	m.read	@mm_mattermost_a:localhost	$AUKXpVUFnYNqEkGgCvdFpbjbYc6RVwJa6Lu4v1LGoBs	{"ts":1672682631406,"hidden":false}	\N
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
@admin:localhost	!dKcbdDATuwwphjRPQP:localhost	m.fully_read	21	{"event_id":"$TVnvv0nGbLydCBtMmTTz-htMsoI4hmxCr3s9AHyFGHQ"}	\N
@admin:localhost	!kmbTYjjsDRDHGgVqUP:localhost	m.fully_read	23	{"event_id":"$O5iO4EII22igkDq5cMKHFB-SGIYD0KqJQXZohS2Dzc0"}	\N
@mm_bridgeuser1:localhost	!kmbTYjjsDRDHGgVqUP:localhost	m.fully_read	41	{"event_id":"$d05l2i-Vc2Zzx3bl0Vz-NnDVVhxgFQIctiPfGoz0Xjs"}	\N
@mm_bridgeuser1:localhost	!dKcbdDATuwwphjRPQP:localhost	m.fully_read	49	{"event_id":"$YMb8Q2a5Xbnn70ZtQxPIimfv3Y9zSC67zsDIdEsRFJw"}	\N
@matrix_a:localhost	!dKcbdDATuwwphjRPQP:localhost	m.fully_read	65	{"event_id":"$FLa6I56u6EmzKm7SjplLhqPxGUZeJy_gEayv25svMwc"}	\N
@matrix_a:localhost	!kmbTYjjsDRDHGgVqUP:localhost	m.fully_read	70	{"event_id":"$8AX5D9nuhWswBU_Fc227Rvda1dcYTL38k5-nu5LYeow"}	\N
@mm_mattermost_a:localhost	!dKcbdDATuwwphjRPQP:localhost	m.fully_read	87	{"event_id":"$DjME4nek1Vnfgp8JIvyexbgZFnJ7UrCzBWYcgi5DRQE"}	\N
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
$Z2BDuqYr2x_4RtA8EmelcT41xj-7klcpKFvY5-POfVw	@matterbot:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	Mattermost Bridge	\N
$uuCt7OoWWYBzi7T3Jte6ntGxol6g760NhRDnyPvGMLA	@matterbot:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	Mattermost Bridge	\N
$IUtrl9K7UzIz2Mh8WwC4IwE46CubMgrjKFmHcXBu2Cg	@mm_mattermost_b:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	invite	0	mattermost_b [mm]	\N
$_ZI5M7wMM-QBKHgJHCRJC5LeBkOqglv0DLH3BAuL_mw	@mm_mattermost_b:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	invite	0	mattermost_b [mm]	\N
$0qBcJsMAQpJ663R0qWtkO3DyspiocKFy-urTZsaZ3pw	@mm_mattermost_a:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	invite	0	MattermostUser A [mm]	\N
$lV2FDnpp7NRIRR5BdRLjhMfQU639aIzIumB6iT8p1ao	@mm_mattermost_a:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	invite	0	MattermostUser A [mm]	\N
$AhmCkSaIYchTfHKz-ScAJNw5JBnITPWbCCQxUwRuIjo	@mm_mattermost_b:localhost	@mm_mattermost_b:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	mattermost_b [mm]	\N
$th-c5RZ-B0CMnKv9LtzPkBy_JfUuYDy4zUtX-8O9Rzg	@mm_mattermost_b:localhost	@mm_mattermost_b:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	mattermost_b [mm]	\N
$DjME4nek1Vnfgp8JIvyexbgZFnJ7UrCzBWYcgi5DRQE	@mm_mattermost_a:localhost	@mm_mattermost_a:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	MattermostUser A [mm]	\N
$wttc0xGxavZKEFW4jhvY1iHmKn5fBDpTA47wmyrYJ6k	@mm_mattermost_a:localhost	@mm_mattermost_a:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	MattermostUser A [mm]	\N
$moj2kqPjW9Xd0RBTBX4Ee8HVebtt8aY6J7P3i6UT7qw	@mm_bridgeuser1:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	invite	0	bridgeuser1 [mm]	\N
$DrKoz6WomICqVeub6PxHnTnu5NbhLDAg2J9rHOxBMmA	@mm_bridgeuser1:localhost	@mm_bridgeuser1:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	bridgeuser1 [mm]	\N
$hUQcgu2HJB2PDqWBrqIQkblhG-WvxXaIzHEnXw-Ej30	@mm_bridgeuser1:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	invite	0	bridgeuser1 [mm]	\N
$fkjIqV9H5dj_boKqogOxPeFW_m8yxwpxTgr4lSwePDY	@mm_bridgeuser1:localhost	@mm_bridgeuser1:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	bridgeuser1 [mm]	\N
$FUJQN-_4fHqBV5emsypqKHRRS0j5jbpMmuarjoIptOg	@mm_bridgeuser2:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	invite	0	bridgeuser2 [mm]	\N
$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk	@mm_bridgeuser2:localhost	@mm_bridgeuser2:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	bridgeuser2 [mm]	\N
$fG61faFdiQLdggY7LGhSk_5yDw-HxLQiWURS7cCmAAc	@mm_bridgeuser2:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	invite	0	bridgeuser2 [mm]	\N
$ze3RfSNk1D8sruIVbtfFmFdyoNnUgcEoFtM7ULxeWMs	@mm_bridgeuser2:localhost	@mm_bridgeuser2:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	bridgeuser2 [mm]	\N
$ifo4xdQDNVXvmkvgnrcj5o9iKblytzWMd_pEcRtWvx8	@mm_bridgeuser1:localhost	@mm_bridgeuser1:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	mm_bridgeuser1	\N
$BeKLUYL7qRfgvRH3qg2u6Z41GK2CNQqGwtAmWHwBWjA	@mm_bridgeuser1:localhost	@mm_bridgeuser1:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	mm_bridgeuser1	\N
$DOD9xnyV6gfI9j6KBsEdTpRu2l62hsRVmc9i6QLcseo	@mm_bridgeuser1:localhost	@mm_bridgeuser1:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	bridgeuser1 [mm]	\N
$KG18kyO7FM4HavQZH_xZmXGUw1RbyfWhbs-Ds3u5vB8	@mm_bridgeuser1:localhost	@mm_bridgeuser1:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	bridgeuser1 [mm]	\N
$sT18sK2FK6Bo7161sdufjmhywK9CsJHemT-D6fDbaWs	@mm_bridgeuser1:localhost	@mm_bridgeuser1:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	mm_bridgeuser1	\N
$d05l2i-Vc2Zzx3bl0Vz-NnDVVhxgFQIctiPfGoz0Xjs	@mm_bridgeuser1:localhost	@mm_bridgeuser1:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	mm_bridgeuser1	\N
$CcTsy5iCDZyphUv5irDLp85iBq-btwDvTJahbK5ATzo	@mm_bridgeuser1:localhost	@mm_bridgeuser1:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	bridgeuser1 [mm]	\N
$0F5VtbBOxf2d2OwQ46I3LM3tqAkj2YWFXSKWzfzdtT8	@mm_bridgeuser1:localhost	@mm_bridgeuser1:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	bridgeuser1 [mm]	\N
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
!kmbTYjjsDRDHGgVqUP:localhost	14	9	0	0	0	9	52	0
!dKcbdDATuwwphjRPQP:localhost	14	9	0	0	0	9	53	0
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
$Z2BDuqYr2x_4RtA8EmelcT41xj-7klcpKFvY5-POfVw	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	\N
$uuCt7OoWWYBzi7T3Jte6ntGxol6g760NhRDnyPvGMLA	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	\N
$IUtrl9K7UzIz2Mh8WwC4IwE46CubMgrjKFmHcXBu2Cg	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$_ZI5M7wMM-QBKHgJHCRJC5LeBkOqglv0DLH3BAuL_mw	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$0qBcJsMAQpJ663R0qWtkO3DyspiocKFy-urTZsaZ3pw	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$lV2FDnpp7NRIRR5BdRLjhMfQU639aIzIumB6iT8p1ao	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$AhmCkSaIYchTfHKz-ScAJNw5JBnITPWbCCQxUwRuIjo	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$th-c5RZ-B0CMnKv9LtzPkBy_JfUuYDy4zUtX-8O9Rzg	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$DjME4nek1Vnfgp8JIvyexbgZFnJ7UrCzBWYcgi5DRQE	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$wttc0xGxavZKEFW4jhvY1iHmKn5fBDpTA47wmyrYJ6k	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$moj2kqPjW9Xd0RBTBX4Ee8HVebtt8aY6J7P3i6UT7qw	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	\N
$DrKoz6WomICqVeub6PxHnTnu5NbhLDAg2J9rHOxBMmA	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	\N
$hUQcgu2HJB2PDqWBrqIQkblhG-WvxXaIzHEnXw-Ej30	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	\N
$fkjIqV9H5dj_boKqogOxPeFW_m8yxwpxTgr4lSwePDY	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	\N
$FUJQN-_4fHqBV5emsypqKHRRS0j5jbpMmuarjoIptOg	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	\N
$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	\N
$fG61faFdiQLdggY7LGhSk_5yDw-HxLQiWURS7cCmAAc	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	\N
$ze3RfSNk1D8sruIVbtfFmFdyoNnUgcEoFtM7ULxeWMs	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	\N
$ifo4xdQDNVXvmkvgnrcj5o9iKblytzWMd_pEcRtWvx8	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	\N
$BeKLUYL7qRfgvRH3qg2u6Z41GK2CNQqGwtAmWHwBWjA	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	\N
$DOD9xnyV6gfI9j6KBsEdTpRu2l62hsRVmc9i6QLcseo	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	\N
$KG18kyO7FM4HavQZH_xZmXGUw1RbyfWhbs-Ds3u5vB8	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	\N
$sT18sK2FK6Bo7161sdufjmhywK9CsJHemT-D6fDbaWs	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	\N
$d05l2i-Vc2Zzx3bl0Vz-NnDVVhxgFQIctiPfGoz0Xjs	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	\N
$CcTsy5iCDZyphUv5irDLp85iBq-btwDvTJahbK5ATzo	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	\N
$0F5VtbBOxf2d2OwQ46I3LM3tqAkj2YWFXSKWzfzdtT8	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	\N
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
32	31
33	29
34	33
35	32
36	35
37	34
38	37
39	38
40	36
41	38
42	36
43	41
44	42
45	42
46	41
47	41
48	42
49	41
50	41
51	42
52	41
53	41
54	41
55	42
56	41
57	41
58	41
59	58
60	42
61	58
62	58
63	58
64	60
65	58
66	60
67	58
68	60
69	58
70	60
71	60
72	60
73	60
74	60
75	60
76	60
77	60
78	60
79	60
80	58
81	58
82	60
83	60
84	58
85	60
86	60
87	60
88	58
89	60
90	58
91	60
92	60
93	58
94	60
95	58
96	60
97	58
98	60
99	60
100	58
101	60
102	58
103	60
104	58
105	60
106	60
107	58
108	58
109	58
110	58
111	58
112	58
114	60
113	58
115	58
116	60
117	60
118	58
119	60
120	58
121	60
122	60
123	58
124	60
125	58
126	60
127	58
128	60
129	58
130	60
131	58
132	60
133	58
134	60
135	58
136	60
137	60
138	58
139	60
140	58
141	60
142	58
143	60
144	58
145	58
146	58
147	60
148	58
149	58
150	60
151	58
152	58
153	58
154	60
155	58
156	58
157	60
158	58
160	60
159	58
161	60
162	60
163	58
164	60
165	58
166	60
167	60
168	58
170	58
169	60
171	58
172	58
173	60
174	58
175	60
176	58
177	60
178	60
179	60
180	60
181	60
182	58
183	58
184	60
185	60
186	58
187	60
188	60
193	58
201	60
209	58
213	60
189	60
192	60
198	58
208	60
190	58
194	60
202	58
205	58
212	58
191	58
196	58
207	58
195	60
199	60
214	58
197	60
203	58
211	58
200	58
204	60
206	60
210	60
215	58
216	60
217	215
218	216
219	215
220	216
221	215
222	216
223	216
224	215
225	215
226	215
227	216
228	215
229	215
230	216
231	215
232	215
233	232
234	230
235	232
236	230
237	232
238	230
239	232
240	230
241	232
242	230
243	232
244	230
245	232
246	230
247	232
248	230
249	232
250	230
251	230
252	230
253	230
254	230
255	230
256	232
258	230
257	232
259	230
260	232
261	230
262	230
263	232
264	230
265	230
266	232
267	232
268	230
269	232
270	230
271	232
272	230
273	230
274	230
275	230
276	232
277	230
278	230
279	230
280	232
281	230
282	232
283	230
284	232
285	232
286	232
287	232
288	232
289	232
290	232
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
21	!dKcbdDATuwwphjRPQP:localhost	$uuCt7OoWWYBzi7T3Jte6ntGxol6g760NhRDnyPvGMLA
22	!kmbTYjjsDRDHGgVqUP:localhost	$Z2BDuqYr2x_4RtA8EmelcT41xj-7klcpKFvY5-POfVw
23	!dKcbdDATuwwphjRPQP:localhost	$IUtrl9K7UzIz2Mh8WwC4IwE46CubMgrjKFmHcXBu2Cg
24	!kmbTYjjsDRDHGgVqUP:localhost	$_ZI5M7wMM-QBKHgJHCRJC5LeBkOqglv0DLH3BAuL_mw
25	!dKcbdDATuwwphjRPQP:localhost	$0qBcJsMAQpJ663R0qWtkO3DyspiocKFy-urTZsaZ3pw
26	!kmbTYjjsDRDHGgVqUP:localhost	$lV2FDnpp7NRIRR5BdRLjhMfQU639aIzIumB6iT8p1ao
27	!dKcbdDATuwwphjRPQP:localhost	$AhmCkSaIYchTfHKz-ScAJNw5JBnITPWbCCQxUwRuIjo
28	!kmbTYjjsDRDHGgVqUP:localhost	$th-c5RZ-B0CMnKv9LtzPkBy_JfUuYDy4zUtX-8O9Rzg
29	!dKcbdDATuwwphjRPQP:localhost	$DjME4nek1Vnfgp8JIvyexbgZFnJ7UrCzBWYcgi5DRQE
30	!kmbTYjjsDRDHGgVqUP:localhost	$wttc0xGxavZKEFW4jhvY1iHmKn5fBDpTA47wmyrYJ6k
31	!kmbTYjjsDRDHGgVqUP:localhost	$moj2kqPjW9Xd0RBTBX4Ee8HVebtt8aY6J7P3i6UT7qw
32	!kmbTYjjsDRDHGgVqUP:localhost	$DrKoz6WomICqVeub6PxHnTnu5NbhLDAg2J9rHOxBMmA
33	!dKcbdDATuwwphjRPQP:localhost	$hUQcgu2HJB2PDqWBrqIQkblhG-WvxXaIzHEnXw-Ej30
34	!dKcbdDATuwwphjRPQP:localhost	$fkjIqV9H5dj_boKqogOxPeFW_m8yxwpxTgr4lSwePDY
35	!kmbTYjjsDRDHGgVqUP:localhost	$FUJQN-_4fHqBV5emsypqKHRRS0j5jbpMmuarjoIptOg
36	!kmbTYjjsDRDHGgVqUP:localhost	$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk
37	!dKcbdDATuwwphjRPQP:localhost	$fG61faFdiQLdggY7LGhSk_5yDw-HxLQiWURS7cCmAAc
38	!dKcbdDATuwwphjRPQP:localhost	$ze3RfSNk1D8sruIVbtfFmFdyoNnUgcEoFtM7ULxeWMs
39	!dKcbdDATuwwphjRPQP:localhost	$T94ds0BsF33hksbM8x1p42y1eauHht8DiitXYDinE5M
40	!kmbTYjjsDRDHGgVqUP:localhost	$XriW0JhiRV6-_AagddOeI42XQXuXj1a4rG5DQjVG45E
41	!dKcbdDATuwwphjRPQP:localhost	$ifo4xdQDNVXvmkvgnrcj5o9iKblytzWMd_pEcRtWvx8
42	!kmbTYjjsDRDHGgVqUP:localhost	$BeKLUYL7qRfgvRH3qg2u6Z41GK2CNQqGwtAmWHwBWjA
43	!dKcbdDATuwwphjRPQP:localhost	$MQmuafNPR-YuaQQZM_zyZv74P6YY5UKWQdnPAT7NS0A
44	!kmbTYjjsDRDHGgVqUP:localhost	$Ijd9c4VtNVwtw-gMOUgrIsF3bzDuJ23d9npKyPeWBhA
45	!kmbTYjjsDRDHGgVqUP:localhost	$6v2ceieNjzNf9CvhEdPBHGXnZLPemkK3qdxjzGlLc-U
46	!dKcbdDATuwwphjRPQP:localhost	$5QJoJx_ZuAVBMLZpJgXCrgT_YQYu3UKEGUnWP7V5LjM
47	!dKcbdDATuwwphjRPQP:localhost	$hGI5R-QkVOCChZio6yAtE10bJujfAtNtAMvyO7MRsdU
48	!kmbTYjjsDRDHGgVqUP:localhost	$UXd1D0pxH9HCdhOWR1oyGWdIX-hylh4Xxa5lmaJSJvc
49	!dKcbdDATuwwphjRPQP:localhost	$quYYkkWt_HluTH78v_uoYllNl8yq1aukK_hXQxoTv5I
50	!dKcbdDATuwwphjRPQP:localhost	$XfCPJE_zzkM1HcxOcfjNmNDp_W3RZgfLCt6lDb_fPKA
51	!kmbTYjjsDRDHGgVqUP:localhost	$-t9RWJZi6ibsMlXhor9BnyanAbb_P-hKK8AMKxudkYU
52	!dKcbdDATuwwphjRPQP:localhost	$Dw8nZjcVjuUlOoF3Xy2jYr6VFqAag745v3EW2gQLW9w
53	!dKcbdDATuwwphjRPQP:localhost	$EshEVlbbLLbm1nsItD4pPvWbBPpf-U9cFcGKrTVGpmo
54	!dKcbdDATuwwphjRPQP:localhost	$WVkyOfOXJnhrnsBXxRNp4c0iSSiv3wUfI6ljx8SFUa0
55	!kmbTYjjsDRDHGgVqUP:localhost	$jeTSucSVyCh2XMSfRrHNLdBlxFXVNFzcmH2yEbN9lvs
56	!dKcbdDATuwwphjRPQP:localhost	$XiAU45Y_bL79HDr35KN6_QIvs-FApVQTvL5Xo_ml-FY
57	!dKcbdDATuwwphjRPQP:localhost	$KV36051Cc2y9YR_YFGqpz9G1Cbh8L13mFxoe5CJEvIo
58	!dKcbdDATuwwphjRPQP:localhost	$DOD9xnyV6gfI9j6KBsEdTpRu2l62hsRVmc9i6QLcseo
59	!dKcbdDATuwwphjRPQP:localhost	$ydIcMO3D875wyCQ-zD8gmjaPPnDCHFVtaOqZzOx2L10
60	!kmbTYjjsDRDHGgVqUP:localhost	$KG18kyO7FM4HavQZH_xZmXGUw1RbyfWhbs-Ds3u5vB8
61	!dKcbdDATuwwphjRPQP:localhost	$vJlPlQHof2tCkn3nZ_3woJvH5_cPdE02dXdWY155tHs
62	!dKcbdDATuwwphjRPQP:localhost	$GpSJxRcFfZdVI60AmIQI057G3wOOAJu5rBzt9MJ6uN8
63	!dKcbdDATuwwphjRPQP:localhost	$90WslPQ2cCyvI-kX4JQolpGKFHTlrhiAJHBtKTA4R9s
64	!kmbTYjjsDRDHGgVqUP:localhost	$dhrKMg8rd9jry7rZsn4SkP4LSUvIetZ4iN0JdwluLAg
65	!dKcbdDATuwwphjRPQP:localhost	$OM-pgQSBrZddQofZbtjwVZL1DByVyJf_7XUDD6d7vdg
66	!kmbTYjjsDRDHGgVqUP:localhost	$KK5d6qEgr2jG6kCz8kbnLDwkiSh840RRB9ywANn2T68
67	!dKcbdDATuwwphjRPQP:localhost	$7Tg__Nr76_HIY9O8BC72L0Z0xXoPJY55P4GPTrHr-sw
68	!kmbTYjjsDRDHGgVqUP:localhost	$IWLTlvnhqaogwekEURlMdaCUoH6MBlY7kxs197v3P2U
69	!dKcbdDATuwwphjRPQP:localhost	$Me6YPAPt06KEGn6CSqOh8QXvrVyTrxfi0IKnZ0W31Rg
70	!kmbTYjjsDRDHGgVqUP:localhost	$Mjqjunbs1UdHypsFYYeunRJwPtM-toKgonZ8dxc-25c
71	!kmbTYjjsDRDHGgVqUP:localhost	$xxwkYDucr87LZH2DMxK5vZXcjUAa7bg8U9YZPkS34HM
76	!kmbTYjjsDRDHGgVqUP:localhost	$v-nUvzZmr-sqXX1AQic2VaaA25TtuYpXGO6nJwOW51U
72	!kmbTYjjsDRDHGgVqUP:localhost	$LVAVDncvVcZMAeiNvrJuvkPmAu8fUdOgu4GkusXTJ9s
73	!kmbTYjjsDRDHGgVqUP:localhost	$-LGKuRMOm7WO170UA9gXyA7tUOBYn8_lYPAi_pPolqg
77	!kmbTYjjsDRDHGgVqUP:localhost	$Kc4gj4r1LVmOofWd50KKfcsIO31CJTjFR-jsGtLX0cc
74	!kmbTYjjsDRDHGgVqUP:localhost	$jezpnctJxyHD49xA8mlxoYrF1dYbEqeqf_IAGupkLPE
75	!kmbTYjjsDRDHGgVqUP:localhost	$nVVLwVB4tJsJ44QiNpapZkVuwzwE8vJv-voaPYbstiA
78	!kmbTYjjsDRDHGgVqUP:localhost	$DLGGj3W5rhdGUpOG5WjBeBnI19iiItevjt4n4WJXEuQ
79	!kmbTYjjsDRDHGgVqUP:localhost	$WasaKfKKPjWmdS9kCQqHY1b1Y8qH1cbyYJURx7LQQ44
80	!dKcbdDATuwwphjRPQP:localhost	$OU1C4sN9_3hIUz0hteG6206l9VV_U_TRggB4Qv_oqkM
81	!dKcbdDATuwwphjRPQP:localhost	$tcunLrlrTnbvbMbVkwG69b6N5VL-2Eur3zEor2BwYwY
82	!kmbTYjjsDRDHGgVqUP:localhost	$PCpSKUpZUOJyXo8Mf9nyZUxidc4-Ymq3In7s3liuV6c
83	!kmbTYjjsDRDHGgVqUP:localhost	$DQdjtPNxNka9oyB3lId2yVO1iOYs5P8eux8hyYcNya0
84	!dKcbdDATuwwphjRPQP:localhost	$rJNyeoCScmvYFUQHzBxvRkBiNS1Dd-xRY-5eXylNH78
85	!kmbTYjjsDRDHGgVqUP:localhost	$h6JFfsYRe-yiiGjQ3yOuqTKzd-XLzwk49nze71e46ds
86	!kmbTYjjsDRDHGgVqUP:localhost	$zMIa1Ns1LbIbhNtLnXxodApwpUxa7xOwzgiyhZp30AM
87	!kmbTYjjsDRDHGgVqUP:localhost	$5jcJJiyJhAAkrAQ9Rjh03V1nQn2pa4kkczbQdAdsEE0
88	!dKcbdDATuwwphjRPQP:localhost	$nK2IhXC6SMCijlYDnZ21Xd60WqDWkFireG7-R-J9ZRQ
89	!kmbTYjjsDRDHGgVqUP:localhost	$-fEFOgXKIo_f9FjaPT9U9wZnxjp3Ze3BmD5KZcaIOdA
90	!dKcbdDATuwwphjRPQP:localhost	$7xpmneM6KFc6_vfHPvyGzbyv-55hRRrS0SuXs_3wdSc
91	!kmbTYjjsDRDHGgVqUP:localhost	$jkon-yEgLu4jIv_ciEvp8Wk_OB3nEbzVPYbJHRBBa2E
92	!kmbTYjjsDRDHGgVqUP:localhost	$HGLgNyRWNogDCNnoJyz1eMTjzLihsm_YVJ6C0CII2gk
93	!dKcbdDATuwwphjRPQP:localhost	$wjr7yhhQizpgnwyyXH-e5poySIpiAUoravCvywpmgz8
94	!kmbTYjjsDRDHGgVqUP:localhost	$jHl2FqdeCeXywFrlh2ZtL8jQ1duwM2D_D9z_DJcdnyY
95	!dKcbdDATuwwphjRPQP:localhost	$I0Kf-b1MIhow5EIolNpqbMkYwUWbifZi-y1EAfu9RUQ
96	!kmbTYjjsDRDHGgVqUP:localhost	$7OXRut2mXk9W62UC1Z1KPP2ABcfscQZ_8QQR9gAQx9o
97	!dKcbdDATuwwphjRPQP:localhost	$IS-9xSUPmzC_xTt7lWrhgeOmw7BphiMxnpue2jHjfMw
98	!kmbTYjjsDRDHGgVqUP:localhost	$OonC8lCnL2wYhsOKLv0a8iv_pFroSReo4D3jzbn6RmM
99	!kmbTYjjsDRDHGgVqUP:localhost	$9JaHIWhc1pSsPtr4Gx9oJeAx5oFViZ5T_hrnaGpkKCk
100	!dKcbdDATuwwphjRPQP:localhost	$t5ChiLWAL1F4bjVIrNrhMZ1ZT8oXhrZw7jiybeGybXo
101	!kmbTYjjsDRDHGgVqUP:localhost	$VkraJuQKOYt76sMfk9vlU_7CsXM4deMgaV1OVDhfe5g
102	!dKcbdDATuwwphjRPQP:localhost	$_2AZzFdrx3zE6LXLWcPgogWkbJZk-T9zDkCZok5rcfo
103	!kmbTYjjsDRDHGgVqUP:localhost	$7Tlc6-_kHddASW_0alwWScx-rcUjkQq-104RLHXaOfI
104	!dKcbdDATuwwphjRPQP:localhost	$pTb_L34VixFt3GfuwCgSOb1UWJl-VWKowQRR3sYfvYE
105	!kmbTYjjsDRDHGgVqUP:localhost	$QNRnV1jbk5DlyOz0wCwth-mhN8-om4CIwHGUh4IOVow
106	!kmbTYjjsDRDHGgVqUP:localhost	$ypoZzrxOuGi_0lMqZIaxbvTvkw-j-L73O75J-hHQKtI
107	!dKcbdDATuwwphjRPQP:localhost	$3hxutDcW64QYbGtPuM700m1UpROQsonk6CfWQWiNztM
108	!dKcbdDATuwwphjRPQP:localhost	$6lBR9xP_FrVz6i2WdAe0nq3W-6z7sh3VBmwt2aV9fM0
109	!dKcbdDATuwwphjRPQP:localhost	$0YEbl_Xqv-QivvUdnKuTZHl9tu9zTEsShFbaIO3ajVM
110	!dKcbdDATuwwphjRPQP:localhost	$DiIa-APw8Y8OAMosnJxAEnKZMRgTM2l5B3FkRLFdB9k
111	!dKcbdDATuwwphjRPQP:localhost	$scCPfNywbwlEgLq0irL8AALcIbUv804XVdSzk6nF-HE
112	!dKcbdDATuwwphjRPQP:localhost	$hJaugM0L3rrmhv4fiIAmbW-anraIrR7j0DiXDtEBV08
114	!kmbTYjjsDRDHGgVqUP:localhost	$bpEg4JPa_MtLfp2P7epmEU80GD1g7p4_V__zCy3v2NE
113	!dKcbdDATuwwphjRPQP:localhost	$PL_HZMgE19_58hNH2qCw23MFOB1kcm_s84Bv3pqOdDY
115	!dKcbdDATuwwphjRPQP:localhost	$PTu23d8pE2NryniKOVJRPZUPeTWaTIZP-E-uWhvM8-8
116	!kmbTYjjsDRDHGgVqUP:localhost	$Yax3CxcJqZVIuVEvLa01-GQkO_8gh4fB0v_Mze7vWXo
117	!kmbTYjjsDRDHGgVqUP:localhost	$Lyq9hljYefOBbLjEGnOhmCnUY1ci6Hbd0rWEUjSypWU
118	!dKcbdDATuwwphjRPQP:localhost	$z1uw_wSwEkGjOd_kBppfvJBrflI2kC9s_4gffxwr4lg
119	!kmbTYjjsDRDHGgVqUP:localhost	$_UqmxZoxGhIwC3Ix2Z5nLWa9RHHcKBthFr7n2v7zskQ
120	!dKcbdDATuwwphjRPQP:localhost	$gViUR5OJ-ms3_x1dsonU_drGzgX-jPc9RggqZfZgzic
121	!kmbTYjjsDRDHGgVqUP:localhost	$yD_DY2JLVWrx-cCBHt5N8TPQ6oCGT6UYSd2idF1kXis
122	!kmbTYjjsDRDHGgVqUP:localhost	$qh7UyjCyslR5maWktYgdWV9Nt7IyGo2rCFxXDHORi-g
123	!dKcbdDATuwwphjRPQP:localhost	$D-dNC2r9zS4NrHzOdhhReBgzQZ5sEKIZdL0R33wYfDU
124	!kmbTYjjsDRDHGgVqUP:localhost	$BTSmMjyoi5p8JkVFnr6bHORyXO-kYjdL7dvb86vRiBo
125	!dKcbdDATuwwphjRPQP:localhost	$sgI2nFfWR9Qk3lIWlon5OnqPI6DbXVnqZaa3RaL2zxM
126	!kmbTYjjsDRDHGgVqUP:localhost	$baZJZSW4Uex7sMK8ySYj-9WBB3rbtYufsdW_P33R21E
127	!dKcbdDATuwwphjRPQP:localhost	$22QdCZySd3uFf93ODNbq-Wb9Plt14-ZtaB6SY7J4Zxw
128	!kmbTYjjsDRDHGgVqUP:localhost	$QU1AdaKDV19UIS5yVH0DCAUKSCVgv3Twge9NmFiCxEc
129	!dKcbdDATuwwphjRPQP:localhost	$hIy_NCvJ4ghNZ8FTFCBlhGOmDFH2u17fnJ85Z1UypMs
130	!kmbTYjjsDRDHGgVqUP:localhost	$yZrKkZPs_1IEARKwqml9-SRzBwiRBzC5uIrOSoN5E6k
131	!dKcbdDATuwwphjRPQP:localhost	$aZjxcK7eQQCUYoppEfehKwhAbKRp0D0Y2KkQLVlaebo
132	!kmbTYjjsDRDHGgVqUP:localhost	$uRaT1tjcp1DcquZH7McrXzhsKovacZLEXLrxtJqnQVw
133	!dKcbdDATuwwphjRPQP:localhost	$YI2l2ZAxKWoKcj3TmbuEOlj11MSTzbUbV1a6sUiRY8U
134	!kmbTYjjsDRDHGgVqUP:localhost	$0iwlwxCRyxLm46wfn05bUVhaLgED_9JgqCO3ESrd5hs
135	!dKcbdDATuwwphjRPQP:localhost	$jqBeWEh3OFP8t_Jih4aL7gJRkMoEKGHVp-pshP9DVak
136	!kmbTYjjsDRDHGgVqUP:localhost	$rO0kfd5ed8Dt-P5RtvGy8XngWxFbdmQ5qHLtvBxwObA
137	!kmbTYjjsDRDHGgVqUP:localhost	$h_xV1VAAffd730mexUFtNXxmXqp-WW95n1TSPLLQNts
138	!dKcbdDATuwwphjRPQP:localhost	$l0GqxuPEfV0oEael0yD1AIV8QWeQ2TdsVN1aRIrO32Q
139	!kmbTYjjsDRDHGgVqUP:localhost	$I1kVn-I4IKMOBo5g2VSDmKuwzH9xlqPTtcKjs0RcebE
140	!dKcbdDATuwwphjRPQP:localhost	$sgssXCvteJ35t8l5ewtchfrYKqLQHgyjJHCxiWBxC0E
141	!kmbTYjjsDRDHGgVqUP:localhost	$3z_ZwZ1eRAzeenra8MgkRHW1zvxXaDRXERkuracTLpM
142	!dKcbdDATuwwphjRPQP:localhost	$aX6LnD4M7laaTty2RpJwEiwt2cmmHmHrtVwsblY0CPE
143	!kmbTYjjsDRDHGgVqUP:localhost	$9_KBbrWoDXTSU7jqrf2TBoVGZoyIgwD6twpCUcUFCak
144	!dKcbdDATuwwphjRPQP:localhost	$MzGkZJBqHiwIbNI6hnAh90hA1IwF2UH5NVtm4tcb-rs
145	!dKcbdDATuwwphjRPQP:localhost	$0D_jhvtRlBRVlO1s2fXteGqGthCpZtklJJTllC8-Ib0
146	!dKcbdDATuwwphjRPQP:localhost	$zXbb-XPBYZHMds_9AjseAJcnUB0hC2s_-r68M4ayd4c
147	!kmbTYjjsDRDHGgVqUP:localhost	$nzUThI9srvHL6OjgPLY0TsyGc8eWQD_8nNPs7Uec2yU
148	!dKcbdDATuwwphjRPQP:localhost	$I43XoPy7lz7NzxTuGjW6WW2FA2ugT8MdEJUuf5e-MTU
149	!dKcbdDATuwwphjRPQP:localhost	$-EmulSnZqysigC-S2cjj8zfanclpkWUFkKJTJfKKLN0
153	!dKcbdDATuwwphjRPQP:localhost	$jcNKZOWfKiozp0CAtVuJUJmv9IdN1lM5pndFPCPOpfk
160	!kmbTYjjsDRDHGgVqUP:localhost	$5pGWtH5PsW8QLxbV29O6969u7dyMD3cbWlemF7Jlx4g
163	!dKcbdDATuwwphjRPQP:localhost	$dufWoJ7YK5ahR2CUNQ4YAA9ehJq7aqD_P5jg8F38I9A
165	!dKcbdDATuwwphjRPQP:localhost	$emJEvHWWcplmLT2uz8OBiM076mVfZbLgyH4gusdMj0M
169	!kmbTYjjsDRDHGgVqUP:localhost	$QIGHtfxR_zloTmi0NvrMPY4LNLROpXEbYTzYvuG-7L8
172	!dKcbdDATuwwphjRPQP:localhost	$pQMCZrKCgJ9PiQ6bkSQTUu05O_tiCM_mbk1tdOxegDc
184	!kmbTYjjsDRDHGgVqUP:localhost	$yg720o9PIqO2IL2b---Bb2OGfedqFB7GslX4ObmHd1E
185	!kmbTYjjsDRDHGgVqUP:localhost	$eqP4rRC_VBfkw4TFYw0UHeSgtz6jxOzZVHmvBaGMF1Y
191	!dKcbdDATuwwphjRPQP:localhost	$X5vFEkRjpxNkfs8LlGf2a2qMWuwyJAaDcxTfLvnynJw
195	!kmbTYjjsDRDHGgVqUP:localhost	$pAu2qpjHWmYuzwKw2-wLhkOGa5RTPN8oc2f9VEkvKIc
196	!dKcbdDATuwwphjRPQP:localhost	$E07bP2cra7TiRVYgQKBcXnGo9R8j_ZUBQGRBXLzOpZY
199	!kmbTYjjsDRDHGgVqUP:localhost	$yhQU05vFqqaJKmsBbI2jG9mdpGPbq4He40_Da7HTBPU
207	!dKcbdDATuwwphjRPQP:localhost	$msKrDFhJ--WEExp8kvcS1aXmgW_g43xnfxEgZZtMBEY
214	!dKcbdDATuwwphjRPQP:localhost	$0qdhedgCWd6nmrvWXv3gk9jNAyJQ1DjqBseCAMmpzCI
150	!kmbTYjjsDRDHGgVqUP:localhost	$y_2HlkDKNHF4uS_-8hW32uPu_tm2CZUGweazr-oXdF4
151	!dKcbdDATuwwphjRPQP:localhost	$8CrW7y5m6sGTIlmdGnkG_t0PzP7khFp8UiCCaPz9jb4
152	!dKcbdDATuwwphjRPQP:localhost	$ySK5oWHpLZ_COrHCHYd_4tAUrAyaj6x5AWRiYC6AxAo
154	!kmbTYjjsDRDHGgVqUP:localhost	$C7ew_JKknMKW7BijsALQmhBulLIVz0IXXVw5R6VA8uk
155	!dKcbdDATuwwphjRPQP:localhost	$_oO5zGn26BEn2oppT-sOHCiLb67pN7--VsBCcK6mSoQ
156	!dKcbdDATuwwphjRPQP:localhost	$2pXReRTm2LML0XnYTVF4vVb0820WlmPjiIv6NErYiMU
157	!kmbTYjjsDRDHGgVqUP:localhost	$iavdMM2LKCGKBg0nN5EVrIZa123jXTM12qOgSjEhoyQ
158	!dKcbdDATuwwphjRPQP:localhost	$Uj519CSOwuudDF4QtJYWp-w3IX3aNLd0A2dFahNW_K8
159	!dKcbdDATuwwphjRPQP:localhost	$w7dsveaNXVIJvPSI77Q8h6Y1if7tqU34WA-Ay04e97Y
161	!kmbTYjjsDRDHGgVqUP:localhost	$MGld7XuZGKwLOqIAwrZQDPR3t35Hio3AJcC3hN4qQMk
162	!kmbTYjjsDRDHGgVqUP:localhost	$WABauEkas_0sMHQRkXZXdcxdEhvPXO8pU1LQdW7Mos4
164	!kmbTYjjsDRDHGgVqUP:localhost	$CW8ypDF439GdQahCuiR6pzqhsyFqhDCpbuAKrhVlyKI
166	!kmbTYjjsDRDHGgVqUP:localhost	$H-pD89Y4WQt7qSHFhDlSIGgxOEQGd5sohS7-GElEbhs
167	!kmbTYjjsDRDHGgVqUP:localhost	$dh1venqEJSMefSwUr833tenYIpmq9IHbGev2UebCfBs
168	!dKcbdDATuwwphjRPQP:localhost	$O_JRy_fdccUn1B_SN3yaShtFQJps-IqQeXzWDcUzm2c
170	!dKcbdDATuwwphjRPQP:localhost	$inP_876eKRiVUaWzJMpb1Cv3EoZJkaQX9g7oCQbwfVk
171	!dKcbdDATuwwphjRPQP:localhost	$YwMpWsDkUPHG7DgzRAxTg30nfhNGH4x9BUycthdsv7M
173	!kmbTYjjsDRDHGgVqUP:localhost	$uoOeeDzRD-BCI0ywx90YSuTQcChCC60Fz6bXP1pAjOc
174	!dKcbdDATuwwphjRPQP:localhost	$4QM2q32MAF7nOx_eFH4gNzafcWbdxPmtPWn8Z_IlaHg
175	!kmbTYjjsDRDHGgVqUP:localhost	$EQ6uKD2H-3CWj2XuaqhDq9H3b--jk_HgpB9nikxMvEo
176	!dKcbdDATuwwphjRPQP:localhost	$hUYgIrc56rQGSjuTyfFidGLOFjPYe0CwonY-gMMwL7Q
177	!kmbTYjjsDRDHGgVqUP:localhost	$jmvUz5RrgFiGvrbJ7IOboEJZnjCBh1d_79dUQFhk4z8
178	!kmbTYjjsDRDHGgVqUP:localhost	$Q1e4q3bajzcphO-m3AUlEB5rszNguOse5soMbU9EfV0
179	!kmbTYjjsDRDHGgVqUP:localhost	$mQhDwoflMkrkQ_BD6hn-hGBqzcrf_5iUMkaP1MKljgw
180	!kmbTYjjsDRDHGgVqUP:localhost	$xwpFBERxk5YELVkTdMhVfZtrwGOGfxdECG_Z759JJdc
181	!kmbTYjjsDRDHGgVqUP:localhost	$qJ6ZkzCaXNuMIaur_osf14lSWZ6Fff9GOXBnxBrCcHI
182	!dKcbdDATuwwphjRPQP:localhost	$Eus-r71rvCUrB4zRhDlad-P4ZG3vin-FVtZwoheFR3k
183	!dKcbdDATuwwphjRPQP:localhost	$aeDFhXbNeYQl2Im19uLbj1Gf2C-RnH2tQks4cWWPyOw
186	!dKcbdDATuwwphjRPQP:localhost	$CDwnOcEfjmr7DckdQYjtFqSU2ZJVwLniqZ3ysPbT5Fc
187	!kmbTYjjsDRDHGgVqUP:localhost	$CaLIEmMfA7RLRbOm24XZGM8C7LuMCpgQlDsd8nyUHgw
188	!kmbTYjjsDRDHGgVqUP:localhost	$Yf8o452pv6vKrZy5hHBP_K7g6A4ptEHBHniduthe2gg
189	!kmbTYjjsDRDHGgVqUP:localhost	$RXF6pkHpF62SZX5uaxpbTExh7dLsHo-QvIbFQNG60dg
190	!dKcbdDATuwwphjRPQP:localhost	$gTbeecYpkup1doLCXn0DP4X5NBnhsrvl-OEIj3CGR8U
192	!kmbTYjjsDRDHGgVqUP:localhost	$bOsUfhZ3Axg1_V5iTTI6rFv6ltwmv-gFYszjHWaYp7k
193	!dKcbdDATuwwphjRPQP:localhost	$wEXO_QgcTLBxNSmNX5jptcPTOXZyanSamw5IAVxOfZ0
194	!kmbTYjjsDRDHGgVqUP:localhost	$8MoZVVJHrMdDqMqVltwb5Uh1f13sPRedFU6D5sgq8VI
197	!kmbTYjjsDRDHGgVqUP:localhost	$KeHWISNZNF7ISkb2GsP7GEu8Xc5ePWxCWQ8E4rNp_AE
198	!dKcbdDATuwwphjRPQP:localhost	$qheWhmuT8DhedVyRWHw2VTwyiwt8SacIj50ioYT0m2c
200	!dKcbdDATuwwphjRPQP:localhost	$K9a0s_ftVBV3K8CPZCImC6xmxo0yO9Z8PYjYlxZsvdI
201	!kmbTYjjsDRDHGgVqUP:localhost	$7kZacDS50mkCFZrnmv8ALFmZ4K24Z1ZeXfGwVD57O8c
202	!dKcbdDATuwwphjRPQP:localhost	$PF3wOqMpnZRvmBPosT3bsNWlfzUyBGZBsiCXkKOOigM
203	!dKcbdDATuwwphjRPQP:localhost	$69n_KFgwE-UAMbL5vdvGlL9VDfRavwaBjzFEM6Fmii0
204	!kmbTYjjsDRDHGgVqUP:localhost	$Rw2gCebekeaVAQFrDNYgtlrtRbsIHZGm9GmsPjodDp4
205	!dKcbdDATuwwphjRPQP:localhost	$YKe0eqAVhZocOi4EB0qyiDAAu4Pm-Y1NYcAXZ_RMfIc
206	!kmbTYjjsDRDHGgVqUP:localhost	$NEEvq48mxjcNlmWUe-pKnQATGYxOBl2c8tuLObolHrE
208	!kmbTYjjsDRDHGgVqUP:localhost	$EqelrWmRuTN4mpI5A1ircGxgfkt48135JKxME_nSuNQ
209	!dKcbdDATuwwphjRPQP:localhost	$4rdAmMIaToPy0A2yd1NjEyX5SPX1Tcfj2t-WslNXvhc
210	!kmbTYjjsDRDHGgVqUP:localhost	$pKD-jgYaDSgcExePTFgFF_JpMegxPFY_RltnZ_-Vm3M
211	!dKcbdDATuwwphjRPQP:localhost	$lqK9qpU9GXfzhplju5Me0ztZ9QG4_F4_mySTjDGUQIU
212	!dKcbdDATuwwphjRPQP:localhost	$Q315jaGXj0Sw3eDBTwT5fyXPqHmKzdmRs0Sn9XhDtOY
213	!kmbTYjjsDRDHGgVqUP:localhost	$1oywHgIrVRMYPQSmNgh2vn43skL2RLiDZofoL09t5Sk
215	!dKcbdDATuwwphjRPQP:localhost	$sT18sK2FK6Bo7161sdufjmhywK9CsJHemT-D6fDbaWs
216	!kmbTYjjsDRDHGgVqUP:localhost	$d05l2i-Vc2Zzx3bl0Vz-NnDVVhxgFQIctiPfGoz0Xjs
217	!dKcbdDATuwwphjRPQP:localhost	$_J2e0WVMchF09kYRMXCI-hGZqd67GdMBtfgdHm6CLUs
218	!kmbTYjjsDRDHGgVqUP:localhost	$ArlQRLA8yKJMzC8dm4motKx-ovfYGIIOxGChJMsq0sQ
219	!dKcbdDATuwwphjRPQP:localhost	$qYLxtgQDC1CPbT_iYpARWl6vbU_JU3eKGQKxATJ3BNg
220	!kmbTYjjsDRDHGgVqUP:localhost	$AEXMRcO9wL1g1CQ3Uzij-TpxjK1r7X-kwEgn2EAJpwc
221	!dKcbdDATuwwphjRPQP:localhost	$MmeIMRhhjaq1I4MLl5TAuzZDgCYJ4Y5QW12D1vAbUMQ
222	!kmbTYjjsDRDHGgVqUP:localhost	$mBITMsbfFG2fw49B2t28m6cOZDFrdB6nq7UXOyUvA64
223	!kmbTYjjsDRDHGgVqUP:localhost	$3G57h5-ySTBFlImNu7m1T5X3XDMHgKDIOETNG6pyGmM
224	!dKcbdDATuwwphjRPQP:localhost	$k0tUzM1zyjpyylT_KJTWdP0aL7YihX2Lt2HYPyvnSL8
225	!dKcbdDATuwwphjRPQP:localhost	$u-hn8s9a31vhWVPdSaCkeaBGJOnivqxg6tNrD4odgOQ
226	!dKcbdDATuwwphjRPQP:localhost	$vT5mjUyFQD7r0qOVNHer41VgKdnC_hBYTYcomn8PY3I
227	!kmbTYjjsDRDHGgVqUP:localhost	$nS0wNNQDMOJLaHqgJOEsc6SwYWos0qxsUBBlstDtkdE
228	!dKcbdDATuwwphjRPQP:localhost	$PAV9AsGMJv-U51ok09prDneqLga_iPKCJX3wC_kthSk
229	!dKcbdDATuwwphjRPQP:localhost	$bfrFXqAOi2M9OCfCZ2glHFgQsE-3VSbaYQGI3C_mXdI
230	!kmbTYjjsDRDHGgVqUP:localhost	$CcTsy5iCDZyphUv5irDLp85iBq-btwDvTJahbK5ATzo
231	!dKcbdDATuwwphjRPQP:localhost	$fvo4mZ7KIgdTdKOQiDrJFdi9tNCdRghrXnMRXJ10V64
232	!dKcbdDATuwwphjRPQP:localhost	$0F5VtbBOxf2d2OwQ46I3LM3tqAkj2YWFXSKWzfzdtT8
233	!dKcbdDATuwwphjRPQP:localhost	$driXlLbowLHxAUlz9c1XctAM02daqj_ConDjD5viclc
234	!kmbTYjjsDRDHGgVqUP:localhost	$TXPsEoXAP5AgvzMxUyaKhFVA3iDh3nxlHc69E_MhlU0
235	!dKcbdDATuwwphjRPQP:localhost	$hOf3H6hue06WCLKkfIJFPezr8g8KO2l6pfg9pVtjeZY
236	!kmbTYjjsDRDHGgVqUP:localhost	$PJ30vmX4XzNG-AOFQcYUKl8YvAWChYEIVCn1YUrBUcM
237	!dKcbdDATuwwphjRPQP:localhost	$4YbXtqA0TnVGOITKJscXF1Woad7tAL8IDCA-U0IkQqA
238	!kmbTYjjsDRDHGgVqUP:localhost	$91t3C9h77WytYAqYN-YZd1U00uidfo7ZfhoFJZt-_Mk
239	!dKcbdDATuwwphjRPQP:localhost	$JgBVMGeexvrkq39pPujA8mUp-MsDsfFuepCm-nYtUFM
240	!kmbTYjjsDRDHGgVqUP:localhost	$-j3DBmxsnqmjiEOHJkeoohJGHRYp6wNjLfQYVwVWNHs
241	!dKcbdDATuwwphjRPQP:localhost	$3qspLACfvklecAM8Ln3Jt692acSCsR9ZbMm-KZj1JUc
242	!kmbTYjjsDRDHGgVqUP:localhost	$Y078exIbcNzu4mwpGasWId-SVt5gIyhJS5G5ooUl6QI
243	!dKcbdDATuwwphjRPQP:localhost	$UqDhtLY-lAcWDKJL6k-2aDAmQ4BpnVbIrVeeZDOYi9Q
244	!kmbTYjjsDRDHGgVqUP:localhost	$SRJnjLwAtTHr5obTT3WI0oFHI6W1XuEwvL3ISJSIaVg
245	!dKcbdDATuwwphjRPQP:localhost	$wu1M4E82pvl8A52P0zYR4OJaPwWczQ7S0HVyPYvIsd4
246	!kmbTYjjsDRDHGgVqUP:localhost	$OSRRkXN7fvgGCBEJuO0aMCGDc5JwxATMZHBci0-jQ8w
247	!dKcbdDATuwwphjRPQP:localhost	$IXOrWB_Dyy4qozqjpSaGzCP6msltS0GOuIO7cgTO1zg
248	!kmbTYjjsDRDHGgVqUP:localhost	$UXNv1aXh4KL-A1VMrz3eS4HXVCzh1KRVVbBb_S__riQ
249	!dKcbdDATuwwphjRPQP:localhost	$n5JRnv7yHp1yrXTLIxPuF2tohk-go85zeSbx4Zk0UYI
250	!kmbTYjjsDRDHGgVqUP:localhost	$hsssgXO5Q7moES9_iYodszmllqetDbRinxI_VSs3ozs
251	!kmbTYjjsDRDHGgVqUP:localhost	$oZLltDnIDDnejL5Nlo2k6PC8gq_RqmIgtySMiEzSjts
252	!kmbTYjjsDRDHGgVqUP:localhost	$xS5zIf6AZGK8LtXBrEVJTeQje8qY1-PK7lAEqpRXQ3c
253	!kmbTYjjsDRDHGgVqUP:localhost	$9GxdsJ0-ZSpwBDTpb6Wbs0BoC5C3GbgLkf5t4oe3atI
254	!kmbTYjjsDRDHGgVqUP:localhost	$LwV68t7Y7c3RXpWAVj9S5BuWMlLMJOfInI8P7UhThAY
255	!kmbTYjjsDRDHGgVqUP:localhost	$X7PlE_SI8LAAVesu4xnfmbTayK_oPMnT04bnXISgv20
256	!dKcbdDATuwwphjRPQP:localhost	$1pjzB6WtsKorcZS8VGO-S0EBpfensR-JIj3hXUdxe3A
257	!dKcbdDATuwwphjRPQP:localhost	$tJ2PEzv_yv1PEWrJmZzz3Z-BxwXQUzMTPSnqwN8_OjY
258	!kmbTYjjsDRDHGgVqUP:localhost	$O04-SKNGWbSH4_yREAW3d4AIKngZ4e1w_I1eGt6SVhI
259	!kmbTYjjsDRDHGgVqUP:localhost	$J-Py5zoQThj8CtPiFZH2u32_4wTyS2BCsoK7b9RI4Wo
260	!dKcbdDATuwwphjRPQP:localhost	$KsKK6PNrfgZnIvnp684i_Rek1NPWHaL4Pn2Je7aWD_g
261	!kmbTYjjsDRDHGgVqUP:localhost	$a1lP8c3vzbYOak5o_l5DoueNQcUq0oUXDA6Xg-XXG2Y
262	!kmbTYjjsDRDHGgVqUP:localhost	$Bi3EKjIn68jNJOISjygwZqJq7DpgzQymZjf9XCuSwhM
263	!dKcbdDATuwwphjRPQP:localhost	$2KzLibhKBaYwwwBM38zz-MV5Acp8RF3t19fw6PEUwSE
264	!kmbTYjjsDRDHGgVqUP:localhost	$H3Gl7F0koXpexVlWVOlFbjf9xMFqU9pAzulebaWS6Eo
265	!kmbTYjjsDRDHGgVqUP:localhost	$CszJpdd00mIJlBnHdXU42Z-KKs1814GOjG-W46qsSsk
266	!dKcbdDATuwwphjRPQP:localhost	$uB-NUFJdC81ktPoM5MP9fjYUGGLK890zQioUNkXJ2PU
267	!dKcbdDATuwwphjRPQP:localhost	$NqqnEYau7z8Goe2R8S1tFVuKaBjLQoUsIIHxSDw8v0E
268	!kmbTYjjsDRDHGgVqUP:localhost	$z6qXHR82LdrCSrh8Fw0y9-MVYTJhFfc6LMyXcxkfZHQ
269	!dKcbdDATuwwphjRPQP:localhost	$dzBNY7N6UoIb73Du-_JlXmF0ci842puQAVgCDR4aExE
270	!kmbTYjjsDRDHGgVqUP:localhost	$2QR42i1u75uVsKjBhpAXK21UIr3FvG8hTU5WUTrN0ZI
271	!dKcbdDATuwwphjRPQP:localhost	$hNT2o3lpQe8ho8r9bC_6LrLg42XEC80zDDFrMDOHIDs
272	!kmbTYjjsDRDHGgVqUP:localhost	$lQJXYK2jSLeqY4a-v6UH4Y-kv1kke_ibHMqlgGCa28Y
273	!kmbTYjjsDRDHGgVqUP:localhost	$3jeAAkYBAb1wPFjixXDbakWkfVIsAs9W482cgujRgno
274	!kmbTYjjsDRDHGgVqUP:localhost	$Ae6y8DfFHrDlnqDDnfNA3_2zOo57HS71jZSjbT32G1o
275	!kmbTYjjsDRDHGgVqUP:localhost	$LqDjfH2xhRzrgVXqxg7A3a17synjAjV0aAvUHj1zibI
276	!dKcbdDATuwwphjRPQP:localhost	$OkgYv0sxc5Hvn9BJgHQ8bfqucIDY3GgYrqJea_UvEEc
277	!kmbTYjjsDRDHGgVqUP:localhost	$KgLjpKuQCaQDNjFusx3OR8iY5BrLqzwiS4FITmGILuE
278	!kmbTYjjsDRDHGgVqUP:localhost	$afmitSSLulEa-hnSX70jG8UVlpcpGZMjpyqS3BB05HY
279	!kmbTYjjsDRDHGgVqUP:localhost	$Z3W1nSCucdkFXWtik3Hd0iQdNQWq1QTqRdsEi7MeIro
280	!dKcbdDATuwwphjRPQP:localhost	$EXB9UJVRWU4Y2R0C7_wbQiIB8ynSDKQ-7UpeQLVJz_8
281	!kmbTYjjsDRDHGgVqUP:localhost	$as7MUShNE62v4Mc9ptPtE4MJbDQPHtfmLI_uOkIye88
286	!dKcbdDATuwwphjRPQP:localhost	$s70V11_YlIcmtX6UwvLRY6AeVkDUQIJneth6uDAGksQ
282	!dKcbdDATuwwphjRPQP:localhost	$sxvcDuS0thziP4PPP4vAy8fkTTl17P2oEc7Qy-XFXXE
288	!dKcbdDATuwwphjRPQP:localhost	$WBvr5NEdhpQNMXjbOwSXOknAR5do2aWq1uqyUb-DDa0
283	!kmbTYjjsDRDHGgVqUP:localhost	$RFjqCnMefEqdO8JWUY-hawmEn7pOpHmiE-goAtLTkhM
284	!dKcbdDATuwwphjRPQP:localhost	$VgtOC9Z6-QSaIYhipKYH1aPszqDppaqID2jEe2XSXuk
290	!dKcbdDATuwwphjRPQP:localhost	$yjd8LOo3ElntNdXHVOoM4SfIN1m6OvB1GjTRbsTKSJM
285	!dKcbdDATuwwphjRPQP:localhost	$16pQSHJnFEE54jnTI3BYQE3omU3AEARcqk2prOwjRWg
287	!dKcbdDATuwwphjRPQP:localhost	$-s43lUgOz7YA8xTrab_9TmMt2i2p7eae9pAHeYiXp2o
289	!dKcbdDATuwwphjRPQP:localhost	$GZG9sGt7zrbVeHNQjtkj_vBQlRl8prhR_GFd6iXX6Rs
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
21	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$uuCt7OoWWYBzi7T3Jte6ntGxol6g760NhRDnyPvGMLA
22	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$Z2BDuqYr2x_4RtA8EmelcT41xj-7klcpKFvY5-POfVw
23	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$IUtrl9K7UzIz2Mh8WwC4IwE46CubMgrjKFmHcXBu2Cg
24	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$_ZI5M7wMM-QBKHgJHCRJC5LeBkOqglv0DLH3BAuL_mw
25	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$0qBcJsMAQpJ663R0qWtkO3DyspiocKFy-urTZsaZ3pw
26	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$lV2FDnpp7NRIRR5BdRLjhMfQU639aIzIumB6iT8p1ao
27	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$AhmCkSaIYchTfHKz-ScAJNw5JBnITPWbCCQxUwRuIjo
28	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$th-c5RZ-B0CMnKv9LtzPkBy_JfUuYDy4zUtX-8O9Rzg
29	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$DjME4nek1Vnfgp8JIvyexbgZFnJ7UrCzBWYcgi5DRQE
30	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$wttc0xGxavZKEFW4jhvY1iHmKn5fBDpTA47wmyrYJ6k
31	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$moj2kqPjW9Xd0RBTBX4Ee8HVebtt8aY6J7P3i6UT7qw
32	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$DrKoz6WomICqVeub6PxHnTnu5NbhLDAg2J9rHOxBMmA
33	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$hUQcgu2HJB2PDqWBrqIQkblhG-WvxXaIzHEnXw-Ej30
34	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$fkjIqV9H5dj_boKqogOxPeFW_m8yxwpxTgr4lSwePDY
35	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$FUJQN-_4fHqBV5emsypqKHRRS0j5jbpMmuarjoIptOg
36	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk
37	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$fG61faFdiQLdggY7LGhSk_5yDw-HxLQiWURS7cCmAAc
38	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$ze3RfSNk1D8sruIVbtfFmFdyoNnUgcEoFtM7ULxeWMs
39	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@admin:localhost	$T94ds0BsF33hksbM8x1p42y1eauHht8DiitXYDinE5M
40	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@admin:localhost	$XriW0JhiRV6-_AagddOeI42XQXuXj1a4rG5DQjVG45E
41	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$ifo4xdQDNVXvmkvgnrcj5o9iKblytzWMd_pEcRtWvx8
42	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$BeKLUYL7qRfgvRH3qg2u6Z41GK2CNQqGwtAmWHwBWjA
43	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	$MQmuafNPR-YuaQQZM_zyZv74P6YY5UKWQdnPAT7NS0A
44	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_a:localhost	$Ijd9c4VtNVwtw-gMOUgrIsF3bzDuJ23d9npKyPeWBhA
45	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$6v2ceieNjzNf9CvhEdPBHGXnZLPemkK3qdxjzGlLc-U
46	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$5QJoJx_ZuAVBMLZpJgXCrgT_YQYu3UKEGUnWP7V5LjM
47	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$hGI5R-QkVOCChZio6yAtE10bJujfAtNtAMvyO7MRsdU
48	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$UXd1D0pxH9HCdhOWR1oyGWdIX-hylh4Xxa5lmaJSJvc
49	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$quYYkkWt_HluTH78v_uoYllNl8yq1aukK_hXQxoTv5I
50	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$XfCPJE_zzkM1HcxOcfjNmNDp_W3RZgfLCt6lDb_fPKA
51	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$-t9RWJZi6ibsMlXhor9BnyanAbb_P-hKK8AMKxudkYU
52	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Dw8nZjcVjuUlOoF3Xy2jYr6VFqAag745v3EW2gQLW9w
53	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$EshEVlbbLLbm1nsItD4pPvWbBPpf-U9cFcGKrTVGpmo
54	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$WVkyOfOXJnhrnsBXxRNp4c0iSSiv3wUfI6ljx8SFUa0
55	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$jeTSucSVyCh2XMSfRrHNLdBlxFXVNFzcmH2yEbN9lvs
56	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$XiAU45Y_bL79HDr35KN6_QIvs-FApVQTvL5Xo_ml-FY
57	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$KV36051Cc2y9YR_YFGqpz9G1Cbh8L13mFxoe5CJEvIo
61	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$vJlPlQHof2tCkn3nZ_3woJvH5_cPdE02dXdWY155tHs
64	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$dhrKMg8rd9jry7rZsn4SkP4LSUvIetZ4iN0JdwluLAg
68	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$IWLTlvnhqaogwekEURlMdaCUoH6MBlY7kxs197v3P2U
58	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$DOD9xnyV6gfI9j6KBsEdTpRu2l62hsRVmc9i6QLcseo
65	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$OM-pgQSBrZddQofZbtjwVZL1DByVyJf_7XUDD6d7vdg
78	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$DLGGj3W5rhdGUpOG5WjBeBnI19iiItevjt4n4WJXEuQ
59	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$ydIcMO3D875wyCQ-zD8gmjaPPnDCHFVtaOqZzOx2L10
69	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$Me6YPAPt06KEGn6CSqOh8QXvrVyTrxfi0IKnZ0W31Rg
74	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$jezpnctJxyHD49xA8mlxoYrF1dYbEqeqf_IAGupkLPE
75	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$nVVLwVB4tJsJ44QiNpapZkVuwzwE8vJv-voaPYbstiA
60	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$KG18kyO7FM4HavQZH_xZmXGUw1RbyfWhbs-Ds3u5vB8
62	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$GpSJxRcFfZdVI60AmIQI057G3wOOAJu5rBzt9MJ6uN8
63	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$90WslPQ2cCyvI-kX4JQolpGKFHTlrhiAJHBtKTA4R9s
70	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$Mjqjunbs1UdHypsFYYeunRJwPtM-toKgonZ8dxc-25c
66	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$KK5d6qEgr2jG6kCz8kbnLDwkiSh840RRB9ywANn2T68
71	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$xxwkYDucr87LZH2DMxK5vZXcjUAa7bg8U9YZPkS34HM
76	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$v-nUvzZmr-sqXX1AQic2VaaA25TtuYpXGO6nJwOW51U
67	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$7Tg__Nr76_HIY9O8BC72L0Z0xXoPJY55P4GPTrHr-sw
72	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$LVAVDncvVcZMAeiNvrJuvkPmAu8fUdOgu4GkusXTJ9s
73	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$-LGKuRMOm7WO170UA9gXyA7tUOBYn8_lYPAi_pPolqg
77	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$Kc4gj4r1LVmOofWd50KKfcsIO31CJTjFR-jsGtLX0cc
79	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$WasaKfKKPjWmdS9kCQqHY1b1Y8qH1cbyYJURx7LQQ44
80	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$OU1C4sN9_3hIUz0hteG6206l9VV_U_TRggB4Qv_oqkM
81	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$tcunLrlrTnbvbMbVkwG69b6N5VL-2Eur3zEor2BwYwY
82	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$PCpSKUpZUOJyXo8Mf9nyZUxidc4-Ymq3In7s3liuV6c
83	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$DQdjtPNxNka9oyB3lId2yVO1iOYs5P8eux8hyYcNya0
84	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$rJNyeoCScmvYFUQHzBxvRkBiNS1Dd-xRY-5eXylNH78
85	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$h6JFfsYRe-yiiGjQ3yOuqTKzd-XLzwk49nze71e46ds
86	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$zMIa1Ns1LbIbhNtLnXxodApwpUxa7xOwzgiyhZp30AM
87	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$5jcJJiyJhAAkrAQ9Rjh03V1nQn2pa4kkczbQdAdsEE0
88	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$nK2IhXC6SMCijlYDnZ21Xd60WqDWkFireG7-R-J9ZRQ
89	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$-fEFOgXKIo_f9FjaPT9U9wZnxjp3Ze3BmD5KZcaIOdA
90	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$7xpmneM6KFc6_vfHPvyGzbyv-55hRRrS0SuXs_3wdSc
91	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$jkon-yEgLu4jIv_ciEvp8Wk_OB3nEbzVPYbJHRBBa2E
92	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$HGLgNyRWNogDCNnoJyz1eMTjzLihsm_YVJ6C0CII2gk
93	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$wjr7yhhQizpgnwyyXH-e5poySIpiAUoravCvywpmgz8
94	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$jHl2FqdeCeXywFrlh2ZtL8jQ1duwM2D_D9z_DJcdnyY
95	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$I0Kf-b1MIhow5EIolNpqbMkYwUWbifZi-y1EAfu9RUQ
96	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$7OXRut2mXk9W62UC1Z1KPP2ABcfscQZ_8QQR9gAQx9o
97	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$IS-9xSUPmzC_xTt7lWrhgeOmw7BphiMxnpue2jHjfMw
98	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$OonC8lCnL2wYhsOKLv0a8iv_pFroSReo4D3jzbn6RmM
99	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$9JaHIWhc1pSsPtr4Gx9oJeAx5oFViZ5T_hrnaGpkKCk
100	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$t5ChiLWAL1F4bjVIrNrhMZ1ZT8oXhrZw7jiybeGybXo
101	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$VkraJuQKOYt76sMfk9vlU_7CsXM4deMgaV1OVDhfe5g
102	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$_2AZzFdrx3zE6LXLWcPgogWkbJZk-T9zDkCZok5rcfo
103	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$7Tlc6-_kHddASW_0alwWScx-rcUjkQq-104RLHXaOfI
104	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$pTb_L34VixFt3GfuwCgSOb1UWJl-VWKowQRR3sYfvYE
105	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$QNRnV1jbk5DlyOz0wCwth-mhN8-om4CIwHGUh4IOVow
106	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$ypoZzrxOuGi_0lMqZIaxbvTvkw-j-L73O75J-hHQKtI
107	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$3hxutDcW64QYbGtPuM700m1UpROQsonk6CfWQWiNztM
108	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$6lBR9xP_FrVz6i2WdAe0nq3W-6z7sh3VBmwt2aV9fM0
109	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$0YEbl_Xqv-QivvUdnKuTZHl9tu9zTEsShFbaIO3ajVM
110	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$DiIa-APw8Y8OAMosnJxAEnKZMRgTM2l5B3FkRLFdB9k
111	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$scCPfNywbwlEgLq0irL8AALcIbUv804XVdSzk6nF-HE
112	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$hJaugM0L3rrmhv4fiIAmbW-anraIrR7j0DiXDtEBV08
114	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$bpEg4JPa_MtLfp2P7epmEU80GD1g7p4_V__zCy3v2NE
113	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$PL_HZMgE19_58hNH2qCw23MFOB1kcm_s84Bv3pqOdDY
115	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$PTu23d8pE2NryniKOVJRPZUPeTWaTIZP-E-uWhvM8-8
116	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$Yax3CxcJqZVIuVEvLa01-GQkO_8gh4fB0v_Mze7vWXo
117	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$Lyq9hljYefOBbLjEGnOhmCnUY1ci6Hbd0rWEUjSypWU
118	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$z1uw_wSwEkGjOd_kBppfvJBrflI2kC9s_4gffxwr4lg
119	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$_UqmxZoxGhIwC3Ix2Z5nLWa9RHHcKBthFr7n2v7zskQ
120	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$gViUR5OJ-ms3_x1dsonU_drGzgX-jPc9RggqZfZgzic
121	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$yD_DY2JLVWrx-cCBHt5N8TPQ6oCGT6UYSd2idF1kXis
122	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$qh7UyjCyslR5maWktYgdWV9Nt7IyGo2rCFxXDHORi-g
123	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$D-dNC2r9zS4NrHzOdhhReBgzQZ5sEKIZdL0R33wYfDU
124	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$BTSmMjyoi5p8JkVFnr6bHORyXO-kYjdL7dvb86vRiBo
125	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$sgI2nFfWR9Qk3lIWlon5OnqPI6DbXVnqZaa3RaL2zxM
126	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$baZJZSW4Uex7sMK8ySYj-9WBB3rbtYufsdW_P33R21E
127	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$22QdCZySd3uFf93ODNbq-Wb9Plt14-ZtaB6SY7J4Zxw
131	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$aZjxcK7eQQCUYoppEfehKwhAbKRp0D0Y2KkQLVlaebo
136	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$rO0kfd5ed8Dt-P5RtvGy8XngWxFbdmQ5qHLtvBxwObA
137	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$h_xV1VAAffd730mexUFtNXxmXqp-WW95n1TSPLLQNts
145	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$0D_jhvtRlBRVlO1s2fXteGqGthCpZtklJJTllC8-Ib0
146	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$zXbb-XPBYZHMds_9AjseAJcnUB0hC2s_-r68M4ayd4c
128	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$QU1AdaKDV19UIS5yVH0DCAUKSCVgv3Twge9NmFiCxEc
132	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$uRaT1tjcp1DcquZH7McrXzhsKovacZLEXLrxtJqnQVw
140	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$sgssXCvteJ35t8l5ewtchfrYKqLQHgyjJHCxiWBxC0E
141	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$3z_ZwZ1eRAzeenra8MgkRHW1zvxXaDRXERkuracTLpM
143	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$9_KBbrWoDXTSU7jqrf2TBoVGZoyIgwD6twpCUcUFCak
129	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$hIy_NCvJ4ghNZ8FTFCBlhGOmDFH2u17fnJ85Z1UypMs
130	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$yZrKkZPs_1IEARKwqml9-SRzBwiRBzC5uIrOSoN5E6k
133	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$YI2l2ZAxKWoKcj3TmbuEOlj11MSTzbUbV1a6sUiRY8U
142	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$aX6LnD4M7laaTty2RpJwEiwt2cmmHmHrtVwsblY0CPE
134	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$0iwlwxCRyxLm46wfn05bUVhaLgED_9JgqCO3ESrd5hs
135	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$jqBeWEh3OFP8t_Jih4aL7gJRkMoEKGHVp-pshP9DVak
138	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$l0GqxuPEfV0oEael0yD1AIV8QWeQ2TdsVN1aRIrO32Q
139	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$I1kVn-I4IKMOBo5g2VSDmKuwzH9xlqPTtcKjs0RcebE
144	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$MzGkZJBqHiwIbNI6hnAh90hA1IwF2UH5NVtm4tcb-rs
147	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$nzUThI9srvHL6OjgPLY0TsyGc8eWQD_8nNPs7Uec2yU
148	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$I43XoPy7lz7NzxTuGjW6WW2FA2ugT8MdEJUuf5e-MTU
149	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$-EmulSnZqysigC-S2cjj8zfanclpkWUFkKJTJfKKLN0
150	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$y_2HlkDKNHF4uS_-8hW32uPu_tm2CZUGweazr-oXdF4
151	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$8CrW7y5m6sGTIlmdGnkG_t0PzP7khFp8UiCCaPz9jb4
152	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$ySK5oWHpLZ_COrHCHYd_4tAUrAyaj6x5AWRiYC6AxAo
153	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$jcNKZOWfKiozp0CAtVuJUJmv9IdN1lM5pndFPCPOpfk
154	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$C7ew_JKknMKW7BijsALQmhBulLIVz0IXXVw5R6VA8uk
155	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$_oO5zGn26BEn2oppT-sOHCiLb67pN7--VsBCcK6mSoQ
156	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$2pXReRTm2LML0XnYTVF4vVb0820WlmPjiIv6NErYiMU
157	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$iavdMM2LKCGKBg0nN5EVrIZa123jXTM12qOgSjEhoyQ
158	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Uj519CSOwuudDF4QtJYWp-w3IX3aNLd0A2dFahNW_K8
160	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$5pGWtH5PsW8QLxbV29O6969u7dyMD3cbWlemF7Jlx4g
159	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$w7dsveaNXVIJvPSI77Q8h6Y1if7tqU34WA-Ay04e97Y
161	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$MGld7XuZGKwLOqIAwrZQDPR3t35Hio3AJcC3hN4qQMk
162	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$WABauEkas_0sMHQRkXZXdcxdEhvPXO8pU1LQdW7Mos4
163	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$dufWoJ7YK5ahR2CUNQ4YAA9ehJq7aqD_P5jg8F38I9A
165	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$emJEvHWWcplmLT2uz8OBiM076mVfZbLgyH4gusdMj0M
164	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$CW8ypDF439GdQahCuiR6pzqhsyFqhDCpbuAKrhVlyKI
166	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$H-pD89Y4WQt7qSHFhDlSIGgxOEQGd5sohS7-GElEbhs
167	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$dh1venqEJSMefSwUr833tenYIpmq9IHbGev2UebCfBs
168	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$O_JRy_fdccUn1B_SN3yaShtFQJps-IqQeXzWDcUzm2c
170	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$inP_876eKRiVUaWzJMpb1Cv3EoZJkaQX9g7oCQbwfVk
169	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$QIGHtfxR_zloTmi0NvrMPY4LNLROpXEbYTzYvuG-7L8
171	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$YwMpWsDkUPHG7DgzRAxTg30nfhNGH4x9BUycthdsv7M
172	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$pQMCZrKCgJ9PiQ6bkSQTUu05O_tiCM_mbk1tdOxegDc
173	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$uoOeeDzRD-BCI0ywx90YSuTQcChCC60Fz6bXP1pAjOc
174	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$4QM2q32MAF7nOx_eFH4gNzafcWbdxPmtPWn8Z_IlaHg
175	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$EQ6uKD2H-3CWj2XuaqhDq9H3b--jk_HgpB9nikxMvEo
176	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$hUYgIrc56rQGSjuTyfFidGLOFjPYe0CwonY-gMMwL7Q
177	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$jmvUz5RrgFiGvrbJ7IOboEJZnjCBh1d_79dUQFhk4z8
178	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$Q1e4q3bajzcphO-m3AUlEB5rszNguOse5soMbU9EfV0
179	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$mQhDwoflMkrkQ_BD6hn-hGBqzcrf_5iUMkaP1MKljgw
180	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$xwpFBERxk5YELVkTdMhVfZtrwGOGfxdECG_Z759JJdc
181	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$qJ6ZkzCaXNuMIaur_osf14lSWZ6Fff9GOXBnxBrCcHI
182	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$Eus-r71rvCUrB4zRhDlad-P4ZG3vin-FVtZwoheFR3k
183	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$aeDFhXbNeYQl2Im19uLbj1Gf2C-RnH2tQks4cWWPyOw
184	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$yg720o9PIqO2IL2b---Bb2OGfedqFB7GslX4ObmHd1E
185	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$eqP4rRC_VBfkw4TFYw0UHeSgtz6jxOzZVHmvBaGMF1Y
186	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$CDwnOcEfjmr7DckdQYjtFqSU2ZJVwLniqZ3ysPbT5Fc
187	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$CaLIEmMfA7RLRbOm24XZGM8C7LuMCpgQlDsd8nyUHgw
188	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$Yf8o452pv6vKrZy5hHBP_K7g6A4ptEHBHniduthe2gg
190	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$gTbeecYpkup1doLCXn0DP4X5NBnhsrvl-OEIj3CGR8U
189	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$RXF6pkHpF62SZX5uaxpbTExh7dLsHo-QvIbFQNG60dg
191	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$X5vFEkRjpxNkfs8LlGf2a2qMWuwyJAaDcxTfLvnynJw
192	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$bOsUfhZ3Axg1_V5iTTI6rFv6ltwmv-gFYszjHWaYp7k
193	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$wEXO_QgcTLBxNSmNX5jptcPTOXZyanSamw5IAVxOfZ0
194	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$8MoZVVJHrMdDqMqVltwb5Uh1f13sPRedFU6D5sgq8VI
195	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$pAu2qpjHWmYuzwKw2-wLhkOGa5RTPN8oc2f9VEkvKIc
196	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$E07bP2cra7TiRVYgQKBcXnGo9R8j_ZUBQGRBXLzOpZY
197	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$KeHWISNZNF7ISkb2GsP7GEu8Xc5ePWxCWQ8E4rNp_AE
198	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$qheWhmuT8DhedVyRWHw2VTwyiwt8SacIj50ioYT0m2c
208	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$EqelrWmRuTN4mpI5A1ircGxgfkt48135JKxME_nSuNQ
199	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$yhQU05vFqqaJKmsBbI2jG9mdpGPbq4He40_Da7HTBPU
214	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$0qdhedgCWd6nmrvWXv3gk9jNAyJQ1DjqBseCAMmpzCI
200	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$K9a0s_ftVBV3K8CPZCImC6xmxo0yO9Z8PYjYlxZsvdI
201	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$7kZacDS50mkCFZrnmv8ALFmZ4K24Z1ZeXfGwVD57O8c
209	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$4rdAmMIaToPy0A2yd1NjEyX5SPX1Tcfj2t-WslNXvhc
213	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$1oywHgIrVRMYPQSmNgh2vn43skL2RLiDZofoL09t5Sk
202	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$PF3wOqMpnZRvmBPosT3bsNWlfzUyBGZBsiCXkKOOigM
205	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$YKe0eqAVhZocOi4EB0qyiDAAu4Pm-Y1NYcAXZ_RMfIc
212	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$Q315jaGXj0Sw3eDBTwT5fyXPqHmKzdmRs0Sn9XhDtOY
203	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$69n_KFgwE-UAMbL5vdvGlL9VDfRavwaBjzFEM6Fmii0
211	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$lqK9qpU9GXfzhplju5Me0ztZ9QG4_F4_mySTjDGUQIU
204	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$Rw2gCebekeaVAQFrDNYgtlrtRbsIHZGm9GmsPjodDp4
206	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$NEEvq48mxjcNlmWUe-pKnQATGYxOBl2c8tuLObolHrE
207	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$msKrDFhJ--WEExp8kvcS1aXmgW_g43xnfxEgZZtMBEY
210	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$pKD-jgYaDSgcExePTFgFF_JpMegxPFY_RltnZ_-Vm3M
215	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$sT18sK2FK6Bo7161sdufjmhywK9CsJHemT-D6fDbaWs
216	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$d05l2i-Vc2Zzx3bl0Vz-NnDVVhxgFQIctiPfGoz0Xjs
217	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$_J2e0WVMchF09kYRMXCI-hGZqd67GdMBtfgdHm6CLUs
218	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$ArlQRLA8yKJMzC8dm4motKx-ovfYGIIOxGChJMsq0sQ
219	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	$qYLxtgQDC1CPbT_iYpARWl6vbU_JU3eKGQKxATJ3BNg
220	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_a:localhost	$AEXMRcO9wL1g1CQ3Uzij-TpxjK1r7X-kwEgn2EAJpwc
221	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$MmeIMRhhjaq1I4MLl5TAuzZDgCYJ4Y5QW12D1vAbUMQ
222	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$mBITMsbfFG2fw49B2t28m6cOZDFrdB6nq7UXOyUvA64
223	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$3G57h5-ySTBFlImNu7m1T5X3XDMHgKDIOETNG6pyGmM
224	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$k0tUzM1zyjpyylT_KJTWdP0aL7YihX2Lt2HYPyvnSL8
225	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$u-hn8s9a31vhWVPdSaCkeaBGJOnivqxg6tNrD4odgOQ
226	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$vT5mjUyFQD7r0qOVNHer41VgKdnC_hBYTYcomn8PY3I
227	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$nS0wNNQDMOJLaHqgJOEsc6SwYWos0qxsUBBlstDtkdE
228	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$PAV9AsGMJv-U51ok09prDneqLga_iPKCJX3wC_kthSk
229	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$bfrFXqAOi2M9OCfCZ2glHFgQsE-3VSbaYQGI3C_mXdI
230	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$CcTsy5iCDZyphUv5irDLp85iBq-btwDvTJahbK5ATzo
231	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$fvo4mZ7KIgdTdKOQiDrJFdi9tNCdRghrXnMRXJ10V64
232	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$0F5VtbBOxf2d2OwQ46I3LM3tqAkj2YWFXSKWzfzdtT8
233	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$driXlLbowLHxAUlz9c1XctAM02daqj_ConDjD5viclc
234	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$TXPsEoXAP5AgvzMxUyaKhFVA3iDh3nxlHc69E_MhlU0
235	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$hOf3H6hue06WCLKkfIJFPezr8g8KO2l6pfg9pVtjeZY
236	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$PJ30vmX4XzNG-AOFQcYUKl8YvAWChYEIVCn1YUrBUcM
237	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$4YbXtqA0TnVGOITKJscXF1Woad7tAL8IDCA-U0IkQqA
238	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$91t3C9h77WytYAqYN-YZd1U00uidfo7ZfhoFJZt-_Mk
239	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$JgBVMGeexvrkq39pPujA8mUp-MsDsfFuepCm-nYtUFM
240	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$-j3DBmxsnqmjiEOHJkeoohJGHRYp6wNjLfQYVwVWNHs
241	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$3qspLACfvklecAM8Ln3Jt692acSCsR9ZbMm-KZj1JUc
242	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$Y078exIbcNzu4mwpGasWId-SVt5gIyhJS5G5ooUl6QI
243	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$UqDhtLY-lAcWDKJL6k-2aDAmQ4BpnVbIrVeeZDOYi9Q
244	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$SRJnjLwAtTHr5obTT3WI0oFHI6W1XuEwvL3ISJSIaVg
245	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$wu1M4E82pvl8A52P0zYR4OJaPwWczQ7S0HVyPYvIsd4
246	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$OSRRkXN7fvgGCBEJuO0aMCGDc5JwxATMZHBci0-jQ8w
247	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$IXOrWB_Dyy4qozqjpSaGzCP6msltS0GOuIO7cgTO1zg
248	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$UXNv1aXh4KL-A1VMrz3eS4HXVCzh1KRVVbBb_S__riQ
249	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$n5JRnv7yHp1yrXTLIxPuF2tohk-go85zeSbx4Zk0UYI
250	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$hsssgXO5Q7moES9_iYodszmllqetDbRinxI_VSs3ozs
251	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$oZLltDnIDDnejL5Nlo2k6PC8gq_RqmIgtySMiEzSjts
252	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$xS5zIf6AZGK8LtXBrEVJTeQje8qY1-PK7lAEqpRXQ3c
253	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$9GxdsJ0-ZSpwBDTpb6Wbs0BoC5C3GbgLkf5t4oe3atI
254	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$LwV68t7Y7c3RXpWAVj9S5BuWMlLMJOfInI8P7UhThAY
255	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$X7PlE_SI8LAAVesu4xnfmbTayK_oPMnT04bnXISgv20
256	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$1pjzB6WtsKorcZS8VGO-S0EBpfensR-JIj3hXUdxe3A
258	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$O04-SKNGWbSH4_yREAW3d4AIKngZ4e1w_I1eGt6SVhI
257	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$tJ2PEzv_yv1PEWrJmZzz3Z-BxwXQUzMTPSnqwN8_OjY
259	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$J-Py5zoQThj8CtPiFZH2u32_4wTyS2BCsoK7b9RI4Wo
260	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$KsKK6PNrfgZnIvnp684i_Rek1NPWHaL4Pn2Je7aWD_g
261	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$a1lP8c3vzbYOak5o_l5DoueNQcUq0oUXDA6Xg-XXG2Y
262	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$Bi3EKjIn68jNJOISjygwZqJq7DpgzQymZjf9XCuSwhM
263	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$2KzLibhKBaYwwwBM38zz-MV5Acp8RF3t19fw6PEUwSE
264	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$H3Gl7F0koXpexVlWVOlFbjf9xMFqU9pAzulebaWS6Eo
265	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$CszJpdd00mIJlBnHdXU42Z-KKs1814GOjG-W46qsSsk
274	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$Ae6y8DfFHrDlnqDDnfNA3_2zOo57HS71jZSjbT32G1o
266	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$uB-NUFJdC81ktPoM5MP9fjYUGGLK890zQioUNkXJ2PU
275	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$LqDjfH2xhRzrgVXqxg7A3a17synjAjV0aAvUHj1zibI
279	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$Z3W1nSCucdkFXWtik3Hd0iQdNQWq1QTqRdsEi7MeIro
289	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$GZG9sGt7zrbVeHNQjtkj_vBQlRl8prhR_GFd6iXX6Rs
267	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$NqqnEYau7z8Goe2R8S1tFVuKaBjLQoUsIIHxSDw8v0E
273	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$3jeAAkYBAb1wPFjixXDbakWkfVIsAs9W482cgujRgno
281	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$as7MUShNE62v4Mc9ptPtE4MJbDQPHtfmLI_uOkIye88
286	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$s70V11_YlIcmtX6UwvLRY6AeVkDUQIJneth6uDAGksQ
268	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$z6qXHR82LdrCSrh8Fw0y9-MVYTJhFfc6LMyXcxkfZHQ
269	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$dzBNY7N6UoIb73Du-_JlXmF0ci842puQAVgCDR4aExE
270	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$2QR42i1u75uVsKjBhpAXK21UIr3FvG8hTU5WUTrN0ZI
271	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$hNT2o3lpQe8ho8r9bC_6LrLg42XEC80zDDFrMDOHIDs
277	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$KgLjpKuQCaQDNjFusx3OR8iY5BrLqzwiS4FITmGILuE
280	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$EXB9UJVRWU4Y2R0C7_wbQiIB8ynSDKQ-7UpeQLVJz_8
282	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$sxvcDuS0thziP4PPP4vAy8fkTTl17P2oEc7Qy-XFXXE
288	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$WBvr5NEdhpQNMXjbOwSXOknAR5do2aWq1uqyUb-DDa0
272	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser2:localhost	$lQJXYK2jSLeqY4a-v6UH4Y-kv1kke_ibHMqlgGCa28Y
276	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$OkgYv0sxc5Hvn9BJgHQ8bfqucIDY3GgYrqJea_UvEEc
283	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$RFjqCnMefEqdO8JWUY-hawmEn7pOpHmiE-goAtLTkhM
284	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$VgtOC9Z6-QSaIYhipKYH1aPszqDppaqID2jEe2XSXuk
290	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$yjd8LOo3ElntNdXHVOoM4SfIN1m6OvB1GjTRbsTKSJM
278	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_bridgeuser1:localhost	$afmitSSLulEa-hnSX70jG8UVlpcpGZMjpyqS3BB05HY
285	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser2:localhost	$16pQSHJnFEE54jnTI3BYQE3omU3AEARcqk2prOwjRWg
287	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_bridgeuser1:localhost	$-s43lUgOz7YA8xTrab_9TmMt2i2p7eae9pAHeYiXp2o
\.


--
-- Data for Name: stats_incremental_position; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.stats_incremental_position (lock, stream_id) FROM stdin;
X	80
\.


--
-- Data for Name: stream_ordering_to_exterm; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.stream_ordering_to_exterm (stream_ordering, room_id, event_id) FROM stdin;
20	!kmbTYjjsDRDHGgVqUP:localhost	$Z2BDuqYr2x_4RtA8EmelcT41xj-7klcpKFvY5-POfVw
21	!dKcbdDATuwwphjRPQP:localhost	$uuCt7OoWWYBzi7T3Jte6ntGxol6g760NhRDnyPvGMLA
22	!dKcbdDATuwwphjRPQP:localhost	$IUtrl9K7UzIz2Mh8WwC4IwE46CubMgrjKFmHcXBu2Cg
23	!kmbTYjjsDRDHGgVqUP:localhost	$_ZI5M7wMM-QBKHgJHCRJC5LeBkOqglv0DLH3BAuL_mw
24	!dKcbdDATuwwphjRPQP:localhost	$0qBcJsMAQpJ663R0qWtkO3DyspiocKFy-urTZsaZ3pw
25	!kmbTYjjsDRDHGgVqUP:localhost	$lV2FDnpp7NRIRR5BdRLjhMfQU639aIzIumB6iT8p1ao
26	!dKcbdDATuwwphjRPQP:localhost	$AhmCkSaIYchTfHKz-ScAJNw5JBnITPWbCCQxUwRuIjo
27	!kmbTYjjsDRDHGgVqUP:localhost	$th-c5RZ-B0CMnKv9LtzPkBy_JfUuYDy4zUtX-8O9Rzg
28	!dKcbdDATuwwphjRPQP:localhost	$DjME4nek1Vnfgp8JIvyexbgZFnJ7UrCzBWYcgi5DRQE
29	!kmbTYjjsDRDHGgVqUP:localhost	$wttc0xGxavZKEFW4jhvY1iHmKn5fBDpTA47wmyrYJ6k
30	!kmbTYjjsDRDHGgVqUP:localhost	$moj2kqPjW9Xd0RBTBX4Ee8HVebtt8aY6J7P3i6UT7qw
31	!kmbTYjjsDRDHGgVqUP:localhost	$DrKoz6WomICqVeub6PxHnTnu5NbhLDAg2J9rHOxBMmA
32	!dKcbdDATuwwphjRPQP:localhost	$hUQcgu2HJB2PDqWBrqIQkblhG-WvxXaIzHEnXw-Ej30
33	!dKcbdDATuwwphjRPQP:localhost	$fkjIqV9H5dj_boKqogOxPeFW_m8yxwpxTgr4lSwePDY
34	!kmbTYjjsDRDHGgVqUP:localhost	$FUJQN-_4fHqBV5emsypqKHRRS0j5jbpMmuarjoIptOg
35	!kmbTYjjsDRDHGgVqUP:localhost	$IkrYdexKfd7WvuEBlmsO6-xvUm73783z777_2_z9Afk
36	!dKcbdDATuwwphjRPQP:localhost	$fG61faFdiQLdggY7LGhSk_5yDw-HxLQiWURS7cCmAAc
37	!dKcbdDATuwwphjRPQP:localhost	$ze3RfSNk1D8sruIVbtfFmFdyoNnUgcEoFtM7ULxeWMs
38	!dKcbdDATuwwphjRPQP:localhost	$ifo4xdQDNVXvmkvgnrcj5o9iKblytzWMd_pEcRtWvx8
39	!kmbTYjjsDRDHGgVqUP:localhost	$BeKLUYL7qRfgvRH3qg2u6Z41GK2CNQqGwtAmWHwBWjA
40	!dKcbdDATuwwphjRPQP:localhost	$DOD9xnyV6gfI9j6KBsEdTpRu2l62hsRVmc9i6QLcseo
41	!kmbTYjjsDRDHGgVqUP:localhost	$KG18kyO7FM4HavQZH_xZmXGUw1RbyfWhbs-Ds3u5vB8
42	!kmbTYjjsDRDHGgVqUP:localhost	$FVhXs60ZUT4hfp8SPDQiJ9sUL5CV4MjGIsUfequDwEE
43	!kmbTYjjsDRDHGgVqUP:localhost	$MSYX67PL-aQgpnMS30mo0OLCFY11arvS2Ehe0I0SNAg
44	!dKcbdDATuwwphjRPQP:localhost	$NDRnMTvwTgCFfTb_vFmNwNe1o4a-UnPMEHKYvBFg1Ms
45	!dKcbdDATuwwphjRPQP:localhost	$sT18sK2FK6Bo7161sdufjmhywK9CsJHemT-D6fDbaWs
46	!kmbTYjjsDRDHGgVqUP:localhost	$d05l2i-Vc2Zzx3bl0Vz-NnDVVhxgFQIctiPfGoz0Xjs
47	!dKcbdDATuwwphjRPQP:localhost	$jsgSLDcqxEQROuyA6P2myIoJf5N1kGLS_n8iWXwE-nU
48	!dKcbdDATuwwphjRPQP:localhost	$vg3binnx1kEog3C9nqvwJ7qPu28sTqYrZDssk0vab-Q
49	!dKcbdDATuwwphjRPQP:localhost	$YMb8Q2a5Xbnn70ZtQxPIimfv3Y9zSC67zsDIdEsRFJw
50	!dKcbdDATuwwphjRPQP:localhost	$d8OJKkkhp47jknk_LHO0c3d0-CSNWMzpJBRw6bOrQ4M
51	!dKcbdDATuwwphjRPQP:localhost	$obESo5AynBeb9xLH4sESBL5g-segSsJGjC9XER9ZTt8
52	!kmbTYjjsDRDHGgVqUP:localhost	$CcTsy5iCDZyphUv5irDLp85iBq-btwDvTJahbK5ATzo
53	!dKcbdDATuwwphjRPQP:localhost	$0F5VtbBOxf2d2OwQ46I3LM3tqAkj2YWFXSKWzfzdtT8
54	!dKcbdDATuwwphjRPQP:localhost	$LkEO2DXJWjTGSlo7iokDO6KvigtD7BtSYgzN1bHF2q0
55	!dKcbdDATuwwphjRPQP:localhost	$RBYjw0bWPMbVEg8csvMs4tPORoqreh7W0cTgJTDKhxQ
56	!dKcbdDATuwwphjRPQP:localhost	$3J0wiu01NbTrOfOGZgRjSdNtX0P7ZN-PQp8qKcLDlmY
57	!dKcbdDATuwwphjRPQP:localhost	$qpoohVqO3c0vYCNBJuvRZHkBBNPQSrgwVwzIcbCfJJk
58	!dKcbdDATuwwphjRPQP:localhost	$FLa6I56u6EmzKm7SjplLhqPxGUZeJy_gEayv25svMwc
59	!kmbTYjjsDRDHGgVqUP:localhost	$uVCWC5TSVmmOhtnjhBprXQIqqNMmjlwAjnAbCFWCmSM
60	!kmbTYjjsDRDHGgVqUP:localhost	$ze3rHWp4q76u5HD9VeEM4tmvDPVyEGXfJ16m3GKAPBA
61	!kmbTYjjsDRDHGgVqUP:localhost	$wQdEIjcFyopFZpNGXmYD7mGBK2vx6nRTZFbp0tUAS5s
62	!kmbTYjjsDRDHGgVqUP:localhost	$vCLF-PjgFkWDlv9RC2q7AbemDp5Aq_wTHx26K7fVT2k
63	!kmbTYjjsDRDHGgVqUP:localhost	$CtsCO4y6Ci5lqltxoUXJqrNNDD4LeUErcBMp_5KFwdU
64	!kmbTYjjsDRDHGgVqUP:localhost	$8AX5D9nuhWswBU_Fc227Rvda1dcYTL38k5-nu5LYeow
65	!kmbTYjjsDRDHGgVqUP:localhost	$C_yOhTrkIxQT1pPwVX1TWe0UBFqH59o0aetXDnxNbb4
66	!kmbTYjjsDRDHGgVqUP:localhost	$7tsqPssEA6U65Qrd44F9FbFLND-JhznQ_c-4bXrIlRE
67	!kmbTYjjsDRDHGgVqUP:localhost	$D4biAJRc__54ONgjSEAYBzE8_j1ePGCqni93Os3tKhM
68	!kmbTYjjsDRDHGgVqUP:localhost	$GPeeyjoIFFM1Mp_pvKB55ZyVVmuSxQ3czNsjj5VxcZs
69	!kmbTYjjsDRDHGgVqUP:localhost	$qIPcuD0d9eSflKKATXSbTJjoKFIBzNFk28nuN3007zo
70	!kmbTYjjsDRDHGgVqUP:localhost	$ge07snxHDhIl87w9HhFEY0Vf4fZF7sfC8ZgYVajdyBQ
71	!kmbTYjjsDRDHGgVqUP:localhost	$8u1nGQdQsFC_o-G3u1FrKnqITkatzs7OCMMVEir7wnk
72	!kmbTYjjsDRDHGgVqUP:localhost	$-F2yj6IuC13Z2Eri3_-fsH3NLCQXQ1igRElx9-Op2x4
73	!kmbTYjjsDRDHGgVqUP:localhost	$iKj1OUBZW17_u23PJes2dsEtLEQhEZBWblS4q6rzsjU
74	!kmbTYjjsDRDHGgVqUP:localhost	$_aHR2VH_SqifxgVILz9ZPES5I390wFZQHGdjrgNSekM
75	!kmbTYjjsDRDHGgVqUP:localhost	$v72gLcqi6Rs213KYj3Q9EwPHikqyQNxPsM2PYcEx_yI
76	!kmbTYjjsDRDHGgVqUP:localhost	$IF1JZZiHama5s_UHEDM0Lrd52rDP-14jwiiT7xvm8gk
77	!kmbTYjjsDRDHGgVqUP:localhost	$nlOfoVdX08P1v2RQ_i1jakYQkuf0y1MGWr21M4pjQJU
78	!kmbTYjjsDRDHGgVqUP:localhost	$AUKXpVUFnYNqEkGgCvdFpbjbYc6RVwJa6Lu4v1LGoBs
79	!kmbTYjjsDRDHGgVqUP:localhost	$1mBKLzxWBgLuS89oa3fbkVxTj_bUJ5krnjvFIGrcU2k
80	!kmbTYjjsDRDHGgVqUP:localhost	$7mzkMAeImEcLYZGgGfqB1GHgCADF4xGJ7B-eojgjum4
\.


--
-- Data for Name: stream_positions; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.stream_positions (stream_name, instance_name, stream_id) FROM stdin;
receipts	master	23
account_data	master	91
events	master	80
presence_stream	master	94
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
hpFzBXtJXPbCTMVOLvbhobKF	1672676402744	{"request_user_id":"@matrix_a:localhost"}	{"master_key":{"user_id":"@matrix_a:localhost","usage":["master"],"keys":{"ed25519:s7AxObibLcTRgOC/O+exL9WNyi5neAuVF3uOFmqY6c0":"s7AxObibLcTRgOC/O+exL9WNyi5neAuVF3uOFmqY6c0"},"signatures":{"@matrix_a:localhost":{"ed25519:DOIVEAHHYD":"I6iNT+wj08jJvQ2kLVjsgSkXiNjrnUXUzS+i4hEjXdDIBHR0ojJQKLmZ34k06ZKSLOKpxVID1km5+Ax9Nx9WBw"}}},"self_signing_key":{"user_id":"@matrix_a:localhost","usage":["self_signing"],"keys":{"ed25519:uUrBrohIl6Xrd5lyKxJ9lBty/nGOXWJ2+gVk01JxZO4":"uUrBrohIl6Xrd5lyKxJ9lBty/nGOXWJ2+gVk01JxZO4"},"signatures":{"@matrix_a:localhost":{"ed25519:s7AxObibLcTRgOC/O+exL9WNyi5neAuVF3uOFmqY6c0":"9Fl58cB/h3cR3gdHOCtl2FM92FJERiKi++9TeP1Ta6YUTyi+budzUowZMn4MB4eQp2+uivbW0c/Wt87c+E4DBQ"}}},"user_signing_key":{"user_id":"@matrix_a:localhost","usage":["user_signing"],"keys":{"ed25519:2Ni0+kad0Qdxs5VniAAOzVxLBZKcqynOFjSLUwz7kb0":"2Ni0+kad0Qdxs5VniAAOzVxLBZKcqynOFjSLUwz7kb0"},"signatures":{"@matrix_a:localhost":{"ed25519:s7AxObibLcTRgOC/O+exL9WNyi5neAuVF3uOFmqY6c0":"P3a//sInj7zPgo7uZNfBV4nkdjQz0Oi48eWPZS5xjVQCI6L+EsS+oj5OdUcVTSQfioRjTKiyrLHwh/83fX/kCw"}}}}	/_matrix/client/unstable/keys/device_signing/upload	POST	add a device signing key to your account
sEOFLjjNNOCCJSMDQwUmvECK	1672676578973	{"request_user_id":"@admin:localhost"}	{"master_key":{"user_id":"@admin:localhost","usage":["master"],"keys":{"ed25519:R3UgEnhYPa5+D1+tlkvn37kpQ3lgTINOyh4m0UCJD3Y":"R3UgEnhYPa5+D1+tlkvn37kpQ3lgTINOyh4m0UCJD3Y"},"signatures":{"@admin:localhost":{"ed25519:LDJENJGFPQ":"N1jU3qw/saBzpPEoEj2sPYyV/VYPZwA1I5MoWL4qdqEEEfhlxgQXLADFBVd0Bo1D3RH7pqdwN3kHRe6dxVa9Bw"}}},"self_signing_key":{"user_id":"@admin:localhost","usage":["self_signing"],"keys":{"ed25519:q3CUiM6vsCzN2C4tfyod3VwGOZhtnXOV2TSj2s4fWqs":"q3CUiM6vsCzN2C4tfyod3VwGOZhtnXOV2TSj2s4fWqs"},"signatures":{"@admin:localhost":{"ed25519:R3UgEnhYPa5+D1+tlkvn37kpQ3lgTINOyh4m0UCJD3Y":"n0Db7vqFQBWt8OgTGPwYTZUsko2VEvsiTq9Y31X0Cn9UGAVwFhwv3pfKvGGGzG3ja6s2aW8y6G4Ra5hZ0wAMAw"}}},"user_signing_key":{"user_id":"@admin:localhost","usage":["user_signing"],"keys":{"ed25519:5qGRDtSxhVZyiP2JJbhLJnoUlfH9iHyovyqyPdRG1ZU":"5qGRDtSxhVZyiP2JJbhLJnoUlfH9iHyovyqyPdRG1ZU"},"signatures":{"@admin:localhost":{"ed25519:R3UgEnhYPa5+D1+tlkvn37kpQ3lgTINOyh4m0UCJD3Y":"Zs0pzlzDd0cvKg8PPx6XwDIZKrZ7P7x6uuwYwPeBM0Yf8VA2IKpffDmAS1kOeKS/9I8zasqDWoZNaIEMRQzyBg"}}}}	/_matrix/client/unstable/keys/device_signing/upload	POST	add a device signing key to your account
uCIiFSkZtpafOFcvuUTsGSct	1672678197789	{"request_user_id":"@mm_bridgeuser1:localhost"}	{"master_key":{"user_id":"@mm_bridgeuser1:localhost","usage":["master"],"keys":{"ed25519:DRMz880tLTidkDctudXSpIqG4uAwslSk8Hjm68KYkdY":"DRMz880tLTidkDctudXSpIqG4uAwslSk8Hjm68KYkdY"},"signatures":{"@mm_bridgeuser1:localhost":{"ed25519:TKJYESZBTR":"+O3h34tCSZ2wQkoqkj7UKQwOUTtVvaZ5yVyZGCnA6yY0NEI66CJECDTKXCWqqpTkJvaGuTTKjwyAB4EvbKpmCA"}}},"self_signing_key":{"user_id":"@mm_bridgeuser1:localhost","usage":["self_signing"],"keys":{"ed25519:Ms3Q/f6VJi/GNybdMFWcA0vERCQXuM7D5DDQTK2zvWI":"Ms3Q/f6VJi/GNybdMFWcA0vERCQXuM7D5DDQTK2zvWI"},"signatures":{"@mm_bridgeuser1:localhost":{"ed25519:DRMz880tLTidkDctudXSpIqG4uAwslSk8Hjm68KYkdY":"CRUPZrr7rUIRIBr6C1QCGgknvX4RAScQkx3drLSpZkMFbV7H9l84hhn1TUJLMdlbmpDkzG7AmH25Bgqa8DWjCA"}}},"user_signing_key":{"user_id":"@mm_bridgeuser1:localhost","usage":["user_signing"],"keys":{"ed25519:sXQuRrkSusQMI3K8q7A91xEhfNh6GgxUxCkNTrAI9kA":"sXQuRrkSusQMI3K8q7A91xEhfNh6GgxUxCkNTrAI9kA"},"signatures":{"@mm_bridgeuser1:localhost":{"ed25519:DRMz880tLTidkDctudXSpIqG4uAwslSk8Hjm68KYkdY":"7a0lyQx9ajNZg6t9mkCkOJiYIvXByWb7T1U2Tz4Da4yKpE+9/K3dqM0Mxss6X/0qjj6RjOVcjsw3p0F9aoy9CQ"}}}}	/_matrix/client/unstable/keys/device_signing/upload	POST	add a device signing key to your account
ANQlDVNecobVMsJrGBUaDToA	1672681537361	{"request_user_id":"@bridgeadmin:localhost"}	{"master_key":{"user_id":"@bridgeadmin:localhost","usage":["master"],"keys":{"ed25519:EoTezP3Htf0wWXZ5EMiXaHZRa41sFDA4ijibsq4g86A":"EoTezP3Htf0wWXZ5EMiXaHZRa41sFDA4ijibsq4g86A"},"signatures":{"@bridgeadmin:localhost":{"ed25519:UMGHKMXVHU":"JVwM1K+s3mvBjPTN/jonX/Yb42uHOQc955iZ42nkDNdfLAHdjRYQO7wjwBgfwofdGi1ZIRiK4B9ljcQI8swzAg"}}},"self_signing_key":{"user_id":"@bridgeadmin:localhost","usage":["self_signing"],"keys":{"ed25519:rHLn0DPtS8WpleuRtsccACEPrgLfXqAe5RUhD+5lFEU":"rHLn0DPtS8WpleuRtsccACEPrgLfXqAe5RUhD+5lFEU"},"signatures":{"@bridgeadmin:localhost":{"ed25519:EoTezP3Htf0wWXZ5EMiXaHZRa41sFDA4ijibsq4g86A":"X8kHoGsV9bDiGT0LdZHw/Rb1jZRX1qzF8IB6GXvGWJflpOMR5X2ltmog+zoT1yTfX8VYUcHZo2jLENjQudXhAQ"}}},"user_signing_key":{"user_id":"@bridgeadmin:localhost","usage":["user_signing"],"keys":{"ed25519:+Hw6SR2JZ3zFIE5KSHXalhL2IITMMY36ncTP+oqqTpE":"+Hw6SR2JZ3zFIE5KSHXalhL2IITMMY36ncTP+oqqTpE"},"signatures":{"@bridgeadmin:localhost":{"ed25519:EoTezP3Htf0wWXZ5EMiXaHZRa41sFDA4ijibsq4g86A":"rJJHCKHM/Do1T2xuc1+ZoPzvaePQIxCD6hqHtR+SEEQa8BjuGvnEqiU7Jv495j1+gl+r/DTpO/D0BRKQ0BRhCA"}}}}	/_matrix/client/unstable/keys/device_signing/upload	POST	add a device signing key to your account
duUsvAOdsIyHAUEYbZcMtNdw	1672682526576	{"request_user_id":"@mm_mattermost_a:localhost"}	{"master_key":{"user_id":"@mm_mattermost_a:localhost","usage":["master"],"keys":{"ed25519:8W+CcIzUjA2oQzjIN2dyZF9K8UTXwkVIJZsNz6w6jUI":"8W+CcIzUjA2oQzjIN2dyZF9K8UTXwkVIJZsNz6w6jUI"},"signatures":{"@mm_mattermost_a:localhost":{"ed25519:WVINFYXSBT":"IdZGwnosGPlrPhFTjCJ/7kmmlWBd6srwko5TGZOtj0+5p1jHvc0XlgMhvrSRITDg9LA+i3vxvFHdbM9IFWxbCQ"}}},"self_signing_key":{"user_id":"@mm_mattermost_a:localhost","usage":["self_signing"],"keys":{"ed25519:RBbqKTOq8cZNFukjqOuU4bF/bvV4zFH8LJVI+pxViuo":"RBbqKTOq8cZNFukjqOuU4bF/bvV4zFH8LJVI+pxViuo"},"signatures":{"@mm_mattermost_a:localhost":{"ed25519:8W+CcIzUjA2oQzjIN2dyZF9K8UTXwkVIJZsNz6w6jUI":"Sz/7uBfQ5vc36fN7Zsm/HyCpd+uFRPsMXv65iIMIUZefi1bdtN7nMjwlWISAqGlRg0WnmUWtUHWjVfmsFRphCA"}}},"user_signing_key":{"user_id":"@mm_mattermost_a:localhost","usage":["user_signing"],"keys":{"ed25519:ZO1pbK/bBirmkdP/EIuvXs3nKHy/UeSuVIdwEJF6Lns":"ZO1pbK/bBirmkdP/EIuvXs3nKHy/UeSuVIdwEJF6Lns"},"signatures":{"@mm_mattermost_a:localhost":{"ed25519:8W+CcIzUjA2oQzjIN2dyZF9K8UTXwkVIJZsNz6w6jUI":"8USadFVsmhRECSaJ1IOJa05zSaUI13jmyBPPOZZEsZ5ek2d3KmFrhP8nXxwQCRInyIG32CNt/DCCEed+PlwfCw"}}}}	/_matrix/client/unstable/keys/device_signing/upload	POST	add a device signing key to your account
\.


--
-- Data for Name: ui_auth_sessions_credentials; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.ui_auth_sessions_credentials (session_id, stage_type, result) FROM stdin;
hpFzBXtJXPbCTMVOLvbhobKF	m.login.password	"@matrix_a:localhost"
sEOFLjjNNOCCJSMDQwUmvECK	m.login.password	"@admin:localhost"
uCIiFSkZtpafOFcvuUTsGSct	m.login.password	"@mm_bridgeuser1:localhost"
ANQlDVNecobVMsJrGBUaDToA	m.login.password	"@bridgeadmin:localhost"
duUsvAOdsIyHAUEYbZcMtNdw	m.login.password	"@mm_mattermost_a:localhost"
\.


--
-- Data for Name: ui_auth_sessions_ips; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.ui_auth_sessions_ips (session_id, ip, user_agent) FROM stdin;
hpFzBXtJXPbCTMVOLvbhobKF	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
sEOFLjjNNOCCJSMDQwUmvECK	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
uCIiFSkZtpafOFcvuUTsGSct	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
ANQlDVNecobVMsJrGBUaDToA	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
duUsvAOdsIyHAUEYbZcMtNdw	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
\.


--
-- Data for Name: user_daily_visits; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_daily_visits (user_id, device_id, "timestamp", user_agent) FROM stdin;
@bridgeadmin:localhost	JRVSUYQVAD	1672617600000	PostmanRuntime/7.29.2
@matrix_a:localhost	DOIVEAHHYD	1672617600000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
@admin:localhost	LDJENJGFPQ	1672617600000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
@matrix_a:localhost	CMZPUTUYMO	1672617600000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
@matrix_a:localhost	QAMBZSULSZ	1672617600000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
@matrix_a:localhost	JEDZORXLOY	1672617600000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
@admin:localhost	VXDDHODNPG	1672617600000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
@bridgeadmin:localhost	UMGHKMXVHU	1672617600000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
\.


--
-- Data for Name: user_directory; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_directory (user_id, room_id, display_name, avatar_url) FROM stdin;
@matrix_b:localhost	\N	matrix_b	\N
@ignored_user:localhost	\N	ignored_user	\N
@bridgeadmin:localhost	\N	bridgeadmin	\N
@bridgeuser1:localhost	\N	bridgeuser1	\N
@bridgeuser2:localhost	\N	bridgeuser2	\N
@admin:localhost	\N	admin	\N
@matrix_a:localhost	\N	matrix_a	\N
\.


--
-- Data for Name: user_directory_search; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_directory_search (user_id, vector) FROM stdin;
@matrix_b:localhost	'b':2A,5B 'localhost':3 'matrix':1A,4B
@ignored_user:localhost	'ignor':1A,4B 'localhost':3 'user':2A,5B
@bridgeadmin:localhost	'bridgeadmin':1A,3B 'localhost':2
@bridgeuser1:localhost	'bridgeuser1':1A,3B 'localhost':2
@bridgeuser2:localhost	'bridgeuser2':1A,3B 'localhost':2
@admin:localhost	'admin':1A,3B 'localhost':2
@matrix_a:localhost	'a':2A,5B 'localhost':3 'matrix':1A,4B
\.


--
-- Data for Name: user_directory_stream_pos; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_directory_stream_pos (lock, stream_id) FROM stdin;
X	80
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
matrix_a	0	\\x7b22726f6f6d223a7b227374617465223a7b226c617a795f6c6f61645f6d656d62657273223a747275657d7d7d
admin	0	\\x7b22726f6f6d223a7b227374617465223a7b226c617a795f6c6f61645f6d656d62657273223a747275657d7d7d
mm_bridgeuser1	0	\\x7b22726f6f6d223a7b227374617465223a7b226c617a795f6c6f61645f6d656d62657273223a747275657d7d7d
bridgeadmin	0	\\x7b22726f6f6d223a7b227374617465223a7b226c617a795f6c6f61645f6d656d62657273223a747275657d7d7d
mm_mattermost_a	0	\\x7b22726f6f6d223a7b227374617465223a7b226c617a795f6c6f61645f6d656d62657273223a747275657d7d7d
\.


--
-- Data for Name: user_ips; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_ips (user_id, access_token, device_id, ip, user_agent, last_seen) FROM stdin;
@matrix_a:localhost	syt_bWF0cml4X2E_uuRAHFFhyRiVYFtlxPOQ_3HbVe4	DOIVEAHHYD	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36	1672676523112
@admin:localhost	syt_YWRtaW4_kKXHzcVWHTpWkVgojjen_2QRSP0	LDJENJGFPQ	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36	1672676722917
@matrix_a:localhost	syt_bWF0cml4X2E_ftlYIoYtsjTFLAnIApLj_3Ywr1n	CMZPUTUYMO	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36	1672678094790
@mm_bridgeuser1:localhost	syt_bW1fYnJpZGdldXNlcjE_ZPvUjdGMdxjbetYlnVEp_48DPeD	TKJYESZBTR	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36	1672678345588
@matrix_a:localhost	syt_bWF0cml4X2E_FAZDqbqYROOTUHDzMSNf_0D9Qs8	QAMBZSULSZ	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36	1672678488755
@matrix_a:localhost	syt_bWF0cml4X2E_cTFxDDHRKyiohLEVNSlU_40TgMx	JEDZORXLOY	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36	1672681418775
@bridgeadmin:localhost	syt_YnJpZGdlYWRtaW4_XbgGxIqpNVYMvwBwSeaY_0XQEMe	UMGHKMXVHU	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36	1672681535182
@admin:localhost	syt_YWRtaW4_ySaKUQAzQNbimqhezTsU_3zxMzh	VXDDHODNPG	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36	1672682025413
@bridgeadmin:localhost	syt_YnJpZGdlYWRtaW4_JoxiEWljSnpIybaKgheJ_3grklR	JRVSUYQVAD	172.16.238.1	PostmanRuntime/7.29.2	1672682466862
@mm_mattermost_a:localhost	syt_bW1fbWF0dGVybW9zdF9h_HygTckNEzuhbEEcsHKnc_4aaOjA	WVINFYXSBT	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36	1672682644828
\.


--
-- Data for Name: user_signature_stream; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_signature_stream (stream_id, from_user_id, user_ids) FROM stdin;
19	@matrix_a:localhost	["@matrix_a:localhost"]
25	@admin:localhost	["@admin:localhost"]
34	@mm_bridgeuser1:localhost	["@mm_bridgeuser1:localhost"]
46	@bridgeadmin:localhost	["@bridgeadmin:localhost"]
56	@mm_mattermost_a:localhost	["@mm_mattermost_a:localhost"]
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
@bridgeadmin:localhost	0	29
@bridgeuser1:localhost	0	29
@bridgeuser2:localhost	0	29
@mm_bridgeuser1:localhost	2	33
@mm_bridgeuser2:localhost	2	37
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
@admin:localhost	email	admin@localhost	1672676257445	1672676257445
@mm_bridgeuser1:localhost	email	mm_bridgeuser1@localhost	1672676284794	1672676284794
@matrix_a:localhost	email	matrix_a@localhost	1672676297049	1672676297049
@mm_mattermost_a:localhost	email	mm_mattermost@localhost	1672682467525	1672682467526
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.users (name, password_hash, creation_ts, admin, upgrade_ts, is_guest, appservice_id, consent_version, consent_server_notice_sent, user_type, deactivated, shadow_banned) FROM stdin;
@matrix_b:localhost	$2b$12$gnHJ1cdN/bfA2A2V61rPauepmeV2dLXr/pC70rCZy9qZoM9u2GKaq	1598686327	0	\N	0	\N	\N	\N	\N	0	\N
@ignored_user:localhost	$2b$12$cDOaADzxfGcFFspSrfJNcueOwevhD2Ex0hu6oAJcpz3S/owrOeSsW	1598686327	0	\N	0	\N	\N	\N	\N	0	\N
@matterbot:localhost		1672674595	0	\N	0	xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	\N	\N	\N	0	f
@mm_mattermost_b:localhost		1672674602	0	\N	0	xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	\N	\N	\N	0	f
@bridgeadmin:localhost	$2b$12$p7LB825E5V9UPLL3x3MxNOuGGaQCSzYFxLJJBOFhQXZhdD8qzD/ji	1672674658	1	\N	0	\N	\N	\N	\N	0	f
@bridgeuser1:localhost	$2b$12$C3DduimZEbqipMvXR28Gw.FrBkoiPjV8OSJCTp/SGwyPATsw7Tyxe	1672674679	0	\N	0	\N	\N	\N	\N	0	f
@bridgeuser2:localhost	$2b$12$wemk/.LpWYuHk3DL/DGvMur/DiLw/hr75bTSmxBueLPTspR7zfjIO	1672674708	0	\N	0	\N	\N	\N	\N	0	f
@mm_bridgeuser2:localhost		1672675304	0	\N	0	xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	\N	\N	\N	0	f
@admin:localhost	$2b$12$/yWJEh5clRga2Gfq6laNGePQaVHfNr0F/UBDwSyXMFNjLNvJNXngq	1598686326	1	\N	0	\N	\N	\N	\N	0	\N
@mm_bridgeuser1:localhost	$2b$12$5VxN4V8iyXqtfWp2O16PVubGb7GVHh6lbXJ6c5LGo7S6eFrwIB2wO	1672675303	0	\N	0	xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	\N	\N	\N	0	f
@matrix_a:localhost	$2b$12$xzg4eM2KAoH.Vfr1Xy9Fz.2C.lxx7rJ.yWi.3sFBD85wV6JMKnoE6	1598686327	0	\N	0	\N	\N	\N	\N	0	\N
@mm_mattermost_a:localhost	$2b$12$PAGvF8v1lR1DGxTZ1aQtReD/Iu1BJOFxWK/4JhD.Uij7uqtCX4O5K	1672674602	0	\N	0	xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	\N	\N	\N	0	f
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

SELECT pg_catalog.setval('public.account_data_sequence', 91, true);


--
-- Name: cache_invalidation_stream_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.cache_invalidation_stream_seq', 232, true);


--
-- Name: device_inbox_sequence; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.device_inbox_sequence', 1, true);


--
-- Name: event_auth_chain_id; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.event_auth_chain_id', 28, true);


--
-- Name: events_backfill_stream_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.events_backfill_stream_seq', 1, true);


--
-- Name: events_stream_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.events_stream_seq', 80, true);


--
-- Name: instance_map_instance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.instance_map_instance_id_seq', 1, false);


--
-- Name: presence_stream_sequence; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.presence_stream_sequence', 94, true);


--
-- Name: receipts_sequence; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.receipts_sequence', 23, true);


--
-- Name: state_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.state_group_id_seq', 290, true);


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

