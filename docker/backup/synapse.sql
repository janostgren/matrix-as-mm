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
9	@admin:localhost	\N	syt_dXNlcjE_zEkKYrbLQyATgolYFkza_3ANvNh	\N	@user1:localhost	1672918171780	\N	f
12	@mm_user1:localhost	SHXZHAGORF	syt_bW1fdXNlcjE_qazPfKDrjsKkOsrLqPrg_3EIMRj	\N	\N	1672922249217	\N	f
14	@user1:localhost	YRNLOWWMIS	syt_dXNlcjE_HPGeQfSPFIwzsrgqwiYs_0hIeO6	\N	\N	1673683487973	\N	t
\.


--
-- Data for Name: account_data; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.account_data (user_id, account_data_type, stream_id, content, instance_name) FROM stdin;
@user1:localhost	org.matrix.msc3890.local_notification_settings.ZLJUJWPSRR	2	{"is_silenced":false}	\N
@user1:localhost	im.vector.analytics	4	{"pseudonymousAnalyticsOptIn":false}	\N
@user1:localhost	org.matrix.msc3890.local_notification_settings.NXIGVVVFXK	6	{"is_silenced":false}	\N
@user1:localhost	io.element.recent_emoji	24	{"recent_emoji":[["\\ud83e\\udd29",1]]}	\N
@user1:localhost	org.matrix.msc3890.local_notification_settings.MPUPZCTVVU	33	{"is_silenced":false}	\N
@user1:localhost	org.matrix.msc3890.local_notification_settings.RUGVQYUUVH	39	{"is_silenced":false}	\N
@user1:localhost	org.matrix.msc3890.local_notification_settings.SANIOXWFGO	46	{"is_silenced":false}	\N
@user1:localhost	im.vector.web.settings	47	{"SpotlightSearch.recentSearches":["!kmbTYjjsDRDHGgVqUP:localhost","!dKcbdDATuwwphjRPQP:localhost"]}	\N
@user1:localhost	org.matrix.msc3890.local_notification_settings.GIFRBCGYKB	49	{"is_silenced":false}	\N
@user1:localhost	org.matrix.msc3890.local_notification_settings.GQNMDRYGXH	51	{"is_silenced":false}	\N
@user1:localhost	org.matrix.msc3890.local_notification_settings.MNQVRBCAUG	53	{"is_silenced":false}	\N
@user1:localhost	org.matrix.msc3890.local_notification_settings.YRNLOWWMIS	56	{"is_silenced":false}	\N
@user1:localhost	im.vector.setting.breadcrumbs	60	{"recent_rooms":["!kmbTYjjsDRDHGgVqUP:localhost","!dKcbdDATuwwphjRPQP:localhost"]}	\N
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
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	up	116	\N	\N
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
X	135
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
42	master	user_last_seen_monthly_active	\N	1672871790969
43	master	get_monthly_active_count	{}	1672871790975
44	master	user_last_seen_monthly_active	\N	1672876490785
45	master	get_monthly_active_count	{}	1672876490795
46	master	user_last_seen_monthly_active	\N	1672879734358
47	master	get_monthly_active_count	{}	1672879734369
48	master	user_last_seen_monthly_active	\N	1672883390253
49	master	get_monthly_active_count	{}	1672883390256
50	master	user_last_seen_monthly_active	\N	1672887715288
51	master	get_monthly_active_count	{}	1672887715291
52	master	user_last_seen_monthly_active	\N	1672890172298
53	master	get_monthly_active_count	{}	1672890172304
54	master	user_last_seen_monthly_active	\N	1672893416286
55	master	get_monthly_active_count	{}	1672893416295
56	master	user_last_seen_monthly_active	\N	1672897967221
57	master	get_monthly_active_count	{}	1672897967224
58	master	user_last_seen_monthly_active	\N	1672901650324
59	master	get_monthly_active_count	{}	1672901650333
60	master	user_last_seen_monthly_active	\N	1672905017461
61	master	get_monthly_active_count	{}	1672905017476
62	master	user_last_seen_monthly_active	\N	1672908258295
63	master	get_monthly_active_count	{}	1672908258298
64	master	user_last_seen_monthly_active	\N	1672912478194
65	master	get_monthly_active_count	{}	1672912478203
66	master	user_last_seen_monthly_active	\N	1672916886701
67	master	get_monthly_active_count	{}	1672916886997
68	master	get_user_by_id	{@user1:localhost}	1672918078870
69	master	count_e2e_one_time_keys	{@user1:localhost,ZLJUJWPSRR}	1672918201747
70	master	get_e2e_unused_fallback_key_types	{@user1:localhost,ZLJUJWPSRR}	1672918201778
71	master	count_e2e_one_time_keys	{@user1:localhost,ZLJUJWPSRR}	1672918201864
72	master	get_e2e_unused_fallback_key_types	{@user1:localhost,ZLJUJWPSRR}	1672918201873
73	master	count_e2e_one_time_keys	{@user1:localhost,ZLJUJWPSRR}	1672918201935
74	master	count_e2e_one_time_keys	{@user1:localhost,ZLJUJWPSRR}	1672918201992
83	master	count_e2e_one_time_keys	{@user1:localhost,ZLJUJWPSRR}	1672918202476
93	master	count_e2e_one_time_keys	{@user1:localhost,NXIGVVVFXK}	1672918479094
98	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@user1:localhost}	1672918494236
104	master	get_user_by_id	{@mm_user1:localhost}	1672922249191
75	master	count_e2e_one_time_keys	{@user1:localhost,ZLJUJWPSRR}	1672918202054
76	master	count_e2e_one_time_keys	{@user1:localhost,ZLJUJWPSRR}	1672918202117
77	master	count_e2e_one_time_keys	{@user1:localhost,ZLJUJWPSRR}	1672918202177
78	master	_get_bare_e2e_cross_signing_keys	{@user1:localhost}	1672918202194
79	master	_get_bare_e2e_cross_signing_keys	{@user1:localhost}	1672918202201
80	master	_get_bare_e2e_cross_signing_keys	{@user1:localhost}	1672918202211
89	master	count_e2e_one_time_keys	{@user1:localhost,NXIGVVVFXK}	1672918478877
90	master	count_e2e_one_time_keys	{@user1:localhost,NXIGVVVFXK}	1672918478929
91	master	count_e2e_one_time_keys	{@user1:localhost,NXIGVVVFXK}	1672918478984
94	master	count_e2e_one_time_keys	{@user1:localhost,NXIGVVVFXK}	1672918479151
95	master	count_e2e_one_time_keys	{@user1:localhost,NXIGVVVFXK}	1672918479203
96	master	count_e2e_one_time_keys	{@user1:localhost,NXIGVVVFXK}	1672918479265
106	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_user1:localhost}	1672922249700
81	master	count_e2e_one_time_keys	{@user1:localhost,ZLJUJWPSRR}	1672918202327
82	master	count_e2e_one_time_keys	{@user1:localhost,ZLJUJWPSRR}	1672918202405
84	master	get_user_by_access_token	{syt_dXNlcjE_vFGpLeZRPNVxPbNorgcL_2sVSJz}	1672918252762
87	master	count_e2e_one_time_keys	{@user1:localhost,NXIGVVVFXK}	1672918478805
92	master	count_e2e_one_time_keys	{@user1:localhost,NXIGVVVFXK}	1672918479038
108	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_user1:localhost}	1672922250047
85	master	count_e2e_one_time_keys	{@user1:localhost,ZLJUJWPSRR}	1672918252781
86	master	get_e2e_unused_fallback_key_types	{@user1:localhost,ZLJUJWPSRR}	1672918252785
88	master	get_e2e_unused_fallback_key_types	{@user1:localhost,NXIGVVVFXK}	1672918478825
97	master	count_e2e_one_time_keys	{@user1:localhost,NXIGVVVFXK}	1672918479380
99	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@user1:localhost}	1672918508504
100	master	user_last_seen_monthly_active	\N	1672918590856
101	master	get_monthly_active_count	{}	1672918590858
102	master	user_last_seen_monthly_active	\N	1672922190858
103	master	get_monthly_active_count	{}	1672922190860
105	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_user1:localhost}	1672922249483
107	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_user1:localhost}	1672922249900
109	master	user_last_seen_monthly_active	\N	1672924683126
110	master	get_monthly_active_count	{}	1672924683137
111	master	get_user_by_access_token	{syt_dXNlcjE_dGiJSUmorpRoxHUDXRjR_0LCV3x}	1672925412123
112	master	count_e2e_one_time_keys	{@user1:localhost,NXIGVVVFXK}	1672925412142
113	master	get_e2e_unused_fallback_key_types	{@user1:localhost,NXIGVVVFXK}	1672925412148
114	master	count_e2e_one_time_keys	{@user1:localhost,MPUPZCTVVU}	1672925430599
115	master	get_e2e_unused_fallback_key_types	{@user1:localhost,MPUPZCTVVU}	1672925430620
116	master	count_e2e_one_time_keys	{@user1:localhost,MPUPZCTVVU}	1672925430693
117	master	count_e2e_one_time_keys	{@user1:localhost,MPUPZCTVVU}	1672925430769
118	master	count_e2e_one_time_keys	{@user1:localhost,MPUPZCTVVU}	1672925430827
119	master	count_e2e_one_time_keys	{@user1:localhost,MPUPZCTVVU}	1672925430884
120	master	count_e2e_one_time_keys	{@user1:localhost,MPUPZCTVVU}	1672925430948
121	master	count_e2e_one_time_keys	{@user1:localhost,MPUPZCTVVU}	1672925431001
122	master	count_e2e_one_time_keys	{@user1:localhost,MPUPZCTVVU}	1672925431059
123	master	count_e2e_one_time_keys	{@user1:localhost,MPUPZCTVVU}	1672925431115
124	master	count_e2e_one_time_keys	{@user1:localhost,MPUPZCTVVU}	1672925431172
125	master	user_last_seen_monthly_active	\N	1673367012166
126	master	get_monthly_active_count	{}	1673367012170
127	master	user_last_seen_monthly_active	\N	1673456325543
128	master	get_monthly_active_count	{}	1673456325566
129	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_b:localhost}	1673456497269
130	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_b:localhost}	1673456497411
131	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_b:localhost}	1673456497673
132	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_b:localhost}	1673456497823
146	master	count_e2e_one_time_keys	{@user1:localhost,RUGVQYUUVH}	1673456972096
133	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@matrix_b:localhost}	1673456498024
143	master	count_e2e_one_time_keys	{@user1:localhost,RUGVQYUUVH}	1673456971853
144	master	count_e2e_one_time_keys	{@user1:localhost,RUGVQYUUVH}	1673456971924
159	master	count_e2e_one_time_keys	{@user1:localhost,SANIOXWFGO}	1673457224967
160	master	count_e2e_one_time_keys	{@user1:localhost,SANIOXWFGO}	1673457225039
161	master	count_e2e_one_time_keys	{@user1:localhost,SANIOXWFGO}	1673457225102
168	master	get_user_by_id	{@user1:localhost}	1673457328337
178	master	count_e2e_one_time_keys	{@user1:localhost,GIFRBCGYKB}	1673459341596
134	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@matrix_b:localhost}	1673456498225
135	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@matrix_b:localhost}	1673456498489
137	master	count_e2e_one_time_keys	{@user1:localhost,RUGVQYUUVH}	1673456971433
138	master	get_e2e_unused_fallback_key_types	{@user1:localhost,RUGVQYUUVH}	1673456971450
139	master	count_e2e_one_time_keys	{@user1:localhost,RUGVQYUUVH}	1673456971607
140	master	get_e2e_unused_fallback_key_types	{@user1:localhost,RUGVQYUUVH}	1673456971617
145	master	count_e2e_one_time_keys	{@user1:localhost,RUGVQYUUVH}	1673456972010
147	master	count_e2e_one_time_keys	{@user1:localhost,RUGVQYUUVH}	1673456972152
148	master	count_e2e_one_time_keys	{@user1:localhost,RUGVQYUUVH}	1673456972212
162	master	count_e2e_one_time_keys	{@user1:localhost,SANIOXWFGO}	1673457225181
163	master	count_e2e_one_time_keys	{@user1:localhost,SANIOXWFGO}	1673457225493
164	master	get_user_by_id	{@user2:localhost}	1673457283080
166	master	get_user_by_id	{@user2:localhost}	1673457301110
169	master	get_user_by_access_token	{syt_dXNlcjE_BEmigoJNqBjQZGIGdMlE_1eiirr}	1673457328353
170	master	count_e2e_one_time_keys	{@user1:localhost,MPUPZCTVVU}	1673457328370
171	master	get_e2e_unused_fallback_key_types	{@user1:localhost,MPUPZCTVVU}	1673457328375
172	master	get_user_by_access_token	{syt_dXNlcjE_LGnQVdOblEysOOBtecvy_1y3288}	1673457328384
175	master	count_e2e_one_time_keys	{@user1:localhost,GIFRBCGYKB}	1673459339169
176	master	get_e2e_unused_fallback_key_types	{@user1:localhost,GIFRBCGYKB}	1673459339186
181	master	count_e2e_one_time_keys	{@user1:localhost,GIFRBCGYKB}	1673459348756
197	master	count_e2e_one_time_keys	{@user1:localhost,GQNMDRYGXH}	1673459439192
198	master	get_e2e_unused_fallback_key_types	{@user1:localhost,GQNMDRYGXH}	1673459439195
136	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@matrix_b:localhost}	1673456498693
141	master	count_e2e_one_time_keys	{@user1:localhost,RUGVQYUUVH}	1673456971713
142	master	count_e2e_one_time_keys	{@user1:localhost,RUGVQYUUVH}	1673456971781
149	master	get_user_by_id	{@user1:localhost}	1673457169978
150	master	get_user_by_access_token	{syt_dXNlcjE_twbcIxFDeJPokdrFQuLG_086a2C}	1673457201433
151	master	count_e2e_one_time_keys	{@user1:localhost,RUGVQYUUVH}	1673457201449
152	master	get_e2e_unused_fallback_key_types	{@user1:localhost,RUGVQYUUVH}	1673457201452
153	master	count_e2e_one_time_keys	{@user1:localhost,SANIOXWFGO}	1673457224601
154	master	get_e2e_unused_fallback_key_types	{@user1:localhost,SANIOXWFGO}	1673457224623
155	master	count_e2e_one_time_keys	{@user1:localhost,SANIOXWFGO}	1673457224702
156	master	count_e2e_one_time_keys	{@user1:localhost,SANIOXWFGO}	1673457224766
157	master	count_e2e_one_time_keys	{@user1:localhost,SANIOXWFGO}	1673457224829
158	master	count_e2e_one_time_keys	{@user1:localhost,SANIOXWFGO}	1673457224888
165	master	get_user_by_id	{@user2:localhost}	1673457300301
167	master	get_user_by_id	{@user1:localhost}	1673457327937
177	master	count_e2e_one_time_keys	{@user1:localhost,GIFRBCGYKB}	1673459341175
179	master	count_e2e_one_time_keys	{@user1:localhost,GIFRBCGYKB}	1673459345782
180	master	count_e2e_one_time_keys	{@user1:localhost,GIFRBCGYKB}	1673459348215
182	master	count_e2e_one_time_keys	{@user1:localhost,GIFRBCGYKB}	1673459349186
183	master	get_user_by_access_token	{syt_dXNlcjE_OexwEKyumZSymlBdyNmn_4YUjcB}	1673459349504
184	master	count_e2e_one_time_keys	{@user1:localhost,GIFRBCGYKB}	1673459349524
185	master	get_e2e_unused_fallback_key_types	{@user1:localhost,GIFRBCGYKB}	1673459349531
186	master	count_e2e_one_time_keys	{@user1:localhost,GQNMDRYGXH}	1673459430579
187	master	get_e2e_unused_fallback_key_types	{@user1:localhost,GQNMDRYGXH}	1673459430601
188	master	count_e2e_one_time_keys	{@user1:localhost,GQNMDRYGXH}	1673459430931
189	master	get_e2e_unused_fallback_key_types	{@user1:localhost,GQNMDRYGXH}	1673459430995
190	master	count_e2e_one_time_keys	{@user1:localhost,GQNMDRYGXH}	1673459432346
191	master	count_e2e_one_time_keys	{@user1:localhost,GQNMDRYGXH}	1673459432654
194	master	count_e2e_one_time_keys	{@user1:localhost,GQNMDRYGXH}	1673459438536
173	master	count_e2e_one_time_keys	{@user1:localhost,SANIOXWFGO}	1673457328400
270	master	user_last_seen_monthly_active	\N	1673688450519
174	master	get_e2e_unused_fallback_key_types	{@user1:localhost,SANIOXWFGO}	1673457328402
192	master	count_e2e_one_time_keys	{@user1:localhost,GQNMDRYGXH}	1673459436558
193	master	count_e2e_one_time_keys	{@user1:localhost,GQNMDRYGXH}	1673459438114
195	master	count_e2e_one_time_keys	{@user1:localhost,GQNMDRYGXH}	1673459439021
196	master	get_user_by_access_token	{syt_dXNlcjE_sbRshouVnDtVAVggArmR_1nA1EH}	1673459439164
199	master	user_last_seen_monthly_active	\N	1673622197299
200	master	get_monthly_active_count	{}	1673622197305
201	master	user_last_seen_monthly_active	\N	1673622249919
202	master	get_monthly_active_count	{}	1673622249930
203	master	user_last_seen_monthly_active	\N	1673625139073
204	master	get_monthly_active_count	{}	1673625139085
205	master	user_last_seen_monthly_active	\N	1673625931004
206	master	get_monthly_active_count	{}	1673625931032
207	master	user_last_seen_monthly_active	\N	1673629530699
208	master	get_monthly_active_count	{}	1673629530700
209	master	user_last_seen_monthly_active	\N	1673633325004
210	master	get_monthly_active_count	{}	1673633325026
211	master	user_last_seen_monthly_active	\N	1673633714714
212	master	get_monthly_active_count	{}	1673633714722
213	master	count_e2e_one_time_keys	{@user1:localhost,MNQVRBCAUG}	1673633774184
214	master	get_e2e_unused_fallback_key_types	{@user1:localhost,MNQVRBCAUG}	1673633774199
215	master	count_e2e_one_time_keys	{@user1:localhost,MNQVRBCAUG}	1673633774316
216	master	count_e2e_one_time_keys	{@user1:localhost,MNQVRBCAUG}	1673633774377
217	master	count_e2e_one_time_keys	{@user1:localhost,MNQVRBCAUG}	1673633774448
218	master	count_e2e_one_time_keys	{@user1:localhost,MNQVRBCAUG}	1673633774520
219	master	count_e2e_one_time_keys	{@user1:localhost,MNQVRBCAUG}	1673633774583
220	master	count_e2e_one_time_keys	{@user1:localhost,MNQVRBCAUG}	1673633774662
221	master	count_e2e_one_time_keys	{@user1:localhost,MNQVRBCAUG}	1673633774698
222	master	count_e2e_one_time_keys	{@user1:localhost,MNQVRBCAUG}	1673633774771
223	master	count_e2e_one_time_keys	{@user1:localhost,MNQVRBCAUG}	1673633774843
224	master	user_last_seen_monthly_active	\N	1673634099872
225	master	get_monthly_active_count	{}	1673634099877
226	master	user_last_seen_monthly_active	\N	1673637711228
227	master	get_monthly_active_count	{}	1673637711309
228	master	user_last_seen_monthly_active	\N	1673643056640
229	master	get_monthly_active_count	{}	1673643056807
230	master	user_last_seen_monthly_active	\N	1673646298181
231	master	get_monthly_active_count	{}	1673646298186
232	master	user_last_seen_monthly_active	\N	1673649539099
233	master	get_monthly_active_count	{}	1673649539121
234	master	user_last_seen_monthly_active	\N	1673652782462
235	master	get_monthly_active_count	{}	1673652782487
236	master	user_last_seen_monthly_active	\N	1673656020625
237	master	get_monthly_active_count	{}	1673656020635
238	master	user_last_seen_monthly_active	\N	1673662503326
239	master	get_monthly_active_count	{}	1673662503563
240	master	user_last_seen_monthly_active	\N	1673665744191
241	master	get_monthly_active_count	{}	1673665744216
242	master	user_last_seen_monthly_active	\N	1673668984424
243	master	get_monthly_active_count	{}	1673668984426
244	master	user_last_seen_monthly_active	\N	1673672225855
245	master	get_monthly_active_count	{}	1673672226057
246	master	user_last_seen_monthly_active	\N	1673675468538
247	master	get_monthly_active_count	{}	1673675468649
248	master	user_last_seen_monthly_active	\N	1673678121354
249	master	get_monthly_active_count	{}	1673678121787
250	master	user_last_seen_monthly_active	\N	1673681017312
251	master	get_monthly_active_count	{}	1673681017607
252	master	user_last_seen_monthly_active	\N	1673683426543
253	master	get_monthly_active_count	{}	1673683426547
254	master	get_user_by_access_token	{syt_dXNlcjE_GfXeGWBZFNCBDEgYsXHs_0Wk2Il}	1673683470335
255	master	count_e2e_one_time_keys	{@user1:localhost,MNQVRBCAUG}	1673683470370
256	master	get_e2e_unused_fallback_key_types	{@user1:localhost,MNQVRBCAUG}	1673683470378
257	master	count_e2e_one_time_keys	{@user1:localhost,YRNLOWWMIS}	1673683489881
258	master	get_e2e_unused_fallback_key_types	{@user1:localhost,YRNLOWWMIS}	1673683489899
259	master	count_e2e_one_time_keys	{@user1:localhost,YRNLOWWMIS}	1673683490039
260	master	count_e2e_one_time_keys	{@user1:localhost,YRNLOWWMIS}	1673683490164
261	master	count_e2e_one_time_keys	{@user1:localhost,YRNLOWWMIS}	1673683490257
262	master	count_e2e_one_time_keys	{@user1:localhost,YRNLOWWMIS}	1673683490401
263	master	count_e2e_one_time_keys	{@user1:localhost,YRNLOWWMIS}	1673683490585
264	master	count_e2e_one_time_keys	{@user1:localhost,YRNLOWWMIS}	1673683490808
265	master	count_e2e_one_time_keys	{@user1:localhost,YRNLOWWMIS}	1673683490981
266	master	count_e2e_one_time_keys	{@user1:localhost,YRNLOWWMIS}	1673683491131
267	master	count_e2e_one_time_keys	{@user1:localhost,YRNLOWWMIS}	1673683491263
268	master	user_last_seen_monthly_active	\N	1673683847668
269	master	get_monthly_active_count	{}	1673683847674
271	master	get_monthly_active_count	{}	1673688450524
272	master	user_last_seen_monthly_active	\N	1673690575010
273	master	get_monthly_active_count	{}	1673690575016
274	master	user_last_seen_monthly_active	\N	1673694174786
275	master	get_monthly_active_count	{}	1673694174787
276	master	user_last_seen_monthly_active	\N	1673697007074
277	master	get_monthly_active_count	{}	1673697007082
278	master	user_last_seen_monthly_active	\N	1673697156875
279	master	get_monthly_active_count	{}	1673697156878
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
40	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@user1:localhost	$kHkn3X5sgQZbnc7m1GNs3FoN729sUsLsqASYxvh3Jb8	\N	master
41	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@user1:localhost	$cl-cBWQqCEUtQdjEqlQcE0PD7MCeX1R25oC5CKqb7oE	\N	master
46	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$S7qfuHyVNKlnX8WQb78EyVSR_7_dnmagLA8asozsQtE	\N	master
47	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$TOzcyxIV2S5U6CP15QCldRMJRaDz1Yaik15PorvZYGc	\N	master
48	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$Sa-w9Co29Yd94wHfPbpfCOuSSlMlorQ7ssiGXYp8oh8	$S7qfuHyVNKlnX8WQb78EyVSR_7_dnmagLA8asozsQtE	master
49	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$n6TBNMF739-W93vnPpWYiJ_zTj-UGsx8mCtkFUsmkrY	$TOzcyxIV2S5U6CP15QCldRMJRaDz1Yaik15PorvZYGc	master
103	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Op0TBQz5bRKUyxhUgvd0RMEbDt0BloR6y_aUatQJcO4	$PSZPiF2_GHeawUZsuFzgg_JuCtoOyaf_11-uLulGF0c	master
104	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$KjxZjGyxoIyEvF0d6WjubIy5-PjQ8gTixRenqiw88iA	$t5n7gGV4l0pVzkJq8YJdQm4IFq3hTrEHABs9QiejsEA	master
105	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$zUomLm3mThwuYeUXH2UXzsuqxE6DQeH_95sT95psJag	$Op0TBQz5bRKUyxhUgvd0RMEbDt0BloR6y_aUatQJcO4	master
106	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$XMPmaEvrP8Ebnl1P6-T-4JWR8Ms1HgLkboYib2Z0LAI	$KjxZjGyxoIyEvF0d6WjubIy5-PjQ8gTixRenqiw88iA	master
107	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_b:localhost	$sKC-AGmNhmjm9fAYYksybJgXr_tCsBeZrEAv6k7VTyk	$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0	master
108	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_b:localhost	$8Lzt8KQPe0wAkuTOKq6BkdBqXu9LrnnsSyeYQ70hPDs	$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk	master
109	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_b:localhost	$9i3p0sl8iw-4rVjwMHJnTFujme1in4rnO1zkP9hPq8w	$sKC-AGmNhmjm9fAYYksybJgXr_tCsBeZrEAv6k7VTyk	master
110	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_b:localhost	$1c97W6vcISTaUEtVZ3XtpTvdbUxTp84W9UUnJ7yQ1hI	$8Lzt8KQPe0wAkuTOKq6BkdBqXu9LrnnsSyeYQ70hPDs	master
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
$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@ignored_user:localhost	join
$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@ignored_user:localhost	join
$mGK5pQEzegKFhAPXc0TX7drNl2qyJL8ajxnJRmA3kN8	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	join
$666ybhBdzZc96KCxYMslNrmlLRi8w6uUusi8J4BUVNM	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	join
$CPrx1EOiKU0xFQBY1-CbMIp4Nx64vw33awql9URc-is	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	join
$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	join
$kHkn3X5sgQZbnc7m1GNs3FoN729sUsLsqASYxvh3Jb8	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@user1:localhost	join
$cl-cBWQqCEUtQdjEqlQcE0PD7MCeX1R25oC5CKqb7oE	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@user1:localhost	join
$Sa-w9Co29Yd94wHfPbpfCOuSSlMlorQ7ssiGXYp8oh8	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	join
$n6TBNMF739-W93vnPpWYiJ_zTj-UGsx8mCtkFUsmkrY	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	join
$zUomLm3mThwuYeUXH2UXzsuqxE6DQeH_95sT95psJag	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	join
$XMPmaEvrP8Ebnl1P6-T-4JWR8Ms1HgLkboYib2Z0LAI	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	join
$9i3p0sl8iw-4rVjwMHJnTFujme1in4rnO1zkP9hPq8w	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_b:localhost	join
$1c97W6vcISTaUEtVZ3XtpTvdbUxTp84W9UUnJ7yQ1hI	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_b:localhost	join
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
12	@user1:localhost	58pTnmZrmfrb2oYvQzQ3gqD+pVVgFJzSKS5rGmhc64I
13	@user1:localhost	pdBCJJeCaBQUwJbb5/uPHNNL9DLS6KDonsWdP5TfCW0
14	@user1:localhost	ZLJUJWPSRR
17	@mm_user1:localhost	SHXZHAGORF
18	@user1:localhost	NXIGVVVFXK
23	@user1:localhost	RUGVQYUUVH
26	@user1:localhost	MPUPZCTVVU
27	@user1:localhost	SANIOXWFGO
30	@user1:localhost	GIFRBCGYKB
33	@user1:localhost	GQNMDRYGXH
36	@user1:localhost	MNQVRBCAUG
38	@user1:localhost	YRNLOWWMIS
\.


--
-- Data for Name: devices; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.devices (user_id, device_id, display_name, last_seen, ip, user_agent, hidden) FROM stdin;
@ignored_user:localhost	IYEBBQEXHS	\N	1598686328565	172.21.0.1	curl/7.72.0	f
@matterbot:localhost	OKGPMGNNEY	\N	\N	\N	\N	f
@mm_mattermost_b:localhost	ZESISTJYYM	\N	\N	\N	\N	f
@mm_mattermost_a:localhost	CWUORKDCEH	\N	\N	\N	\N	f
@user1:localhost	58pTnmZrmfrb2oYvQzQ3gqD+pVVgFJzSKS5rGmhc64I	master signing key	\N	\N	\N	t
@user1:localhost	pdBCJJeCaBQUwJbb5/uPHNNL9DLS6KDonsWdP5TfCW0	self_signing signing key	\N	\N	\N	t
@user1:localhost	8VwxF1XcfucbvnEe3tmKLZBRBD5vxbOIg2RNVH0Ndyg	user_signing signing key	\N	\N	\N	t
@mm_user1:localhost	SHXZHAGORF	\N	\N	\N	\N	f
@admin:localhost	WCSUBIGVWG	\N	1673457535988	172.16.238.1		f
@matrix_a:localhost	TKAVEOGKHH	\N	1673459764936	172.16.238.1	undici	f
@user1:localhost	YRNLOWWMIS	localhost:8080: Chrome on macOS	1673697158151	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	f
@matrix_b:localhost	DJFHSWMXLW	\N	1673685169829	172.16.238.1	Playwright/1.29.2 (x64; macOS 12.6) node/18.2	f
\.


--
-- Data for Name: e2e_cross_signing_keys; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_cross_signing_keys (user_id, keytype, keydata, stream_id) FROM stdin;
@user1:localhost	master	{"user_id":"@user1:localhost","usage":["master"],"keys":{"ed25519:58pTnmZrmfrb2oYvQzQ3gqD+pVVgFJzSKS5rGmhc64I":"58pTnmZrmfrb2oYvQzQ3gqD+pVVgFJzSKS5rGmhc64I"},"signatures":{"@user1:localhost":{"ed25519:ZLJUJWPSRR":"yBESboDwQNBEOXMduanqiGoLXTF4gKvF7N4LP5ovnEoMFi8kAbAQjbpnVX0YLH2MvpuzesgQ+bxC7p7VkQ6fBQ"}}}	2
@user1:localhost	self_signing	{"user_id":"@user1:localhost","usage":["self_signing"],"keys":{"ed25519:pdBCJJeCaBQUwJbb5/uPHNNL9DLS6KDonsWdP5TfCW0":"pdBCJJeCaBQUwJbb5/uPHNNL9DLS6KDonsWdP5TfCW0"},"signatures":{"@user1:localhost":{"ed25519:58pTnmZrmfrb2oYvQzQ3gqD+pVVgFJzSKS5rGmhc64I":"O1vPD1mJiCrfD4q0awkAK2iLx4aOmzEayu9GwW2zLZmZ44nzOsQQ4krEwKKtuXAHl1uaHgLPIknBSMgWsdkGBQ"}}}	3
@user1:localhost	user_signing	{"user_id":"@user1:localhost","usage":["user_signing"],"keys":{"ed25519:8VwxF1XcfucbvnEe3tmKLZBRBD5vxbOIg2RNVH0Ndyg":"8VwxF1XcfucbvnEe3tmKLZBRBD5vxbOIg2RNVH0Ndyg"},"signatures":{"@user1:localhost":{"ed25519:58pTnmZrmfrb2oYvQzQ3gqD+pVVgFJzSKS5rGmhc64I":"MnzzIPIWi1oUBte11VVm2XtrdKv32Zg3NXY+YMa9SZrMg6O7k9Kew1GvvfmN49wndN4Aq1V6JvCuHZSFDZjSAg"}}}	4
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
@user1:localhost	YRNLOWWMIS	1673683488450	{"algorithms":["m.olm.v1.curve25519-aes-sha2","m.megolm.v1.aes-sha2"],"device_id":"YRNLOWWMIS","keys":{"curve25519:YRNLOWWMIS":"t8h9k0MFcvlMSwHZLh6L9VzgeYOd8QXAMG0sT7koAHI","ed25519:YRNLOWWMIS":"hO959zRNZVlYta+r7G6V8EPQXt5Dnp7kUzqRz2EJ7Ag"},"signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"voTYLQZS1uFfHxIrtaarbd317Q1mHWzCzq33hjknhnozaJiwv58x14LSYaQ02MXUa0sLh7HtAnsMJcBhLBdSBg"}},"user_id":"@user1:localhost"}
\.


--
-- Data for Name: e2e_fallback_keys_json; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_fallback_keys_json (user_id, device_id, algorithm, key_id, key_json, used) FROM stdin;
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAABg	{"key":"b+HNWBNcQKaMdpGQaKJbU+Q8M0mbMb1VVtfSR0Ubm3g","fallback":true,"signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"BTXT8JvkKocDNMadKFXM/vePiLRrj8tD4qo4kCCW4M/dTqkcaL1G9zkGWPw/BS7Ka8OdlVwTkO/FPbQkM4G8CA"}}}	f
\.


--
-- Data for Name: e2e_one_time_keys_json; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_one_time_keys_json (user_id, device_id, algorithm, key_id, ts_added_ms, key_json) FROM stdin;
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAABQ	1673683489700	{"key":"2fEVpsxn6Im+bR5EThrWoX11I4XueATEfXOC5idGWkQ","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"ESMD4qdBCYFPyd+ckGyFLzQ0bCWRjqDcrpWD40NCaKiSfP9+N5VtOfxbyXEXwZV7tm6KUIC0Yo2ISOcppHDoDA"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAABA	1673683489700	{"key":"jr79Y8nfutcRk753NzrRzWr182/e6avgLxAy9uiWLUM","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"HLvGXDBzCJqFJdZ9zk1N7TbRlfo5SkV6R63VvpXoBpGYoZlK4MBMihRR5+LxnxCGf7+lm2dBPgMwcY9tebGeCg"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAAw	1673683489700	{"key":"Pe9AbtF7qfWTZ4pEWFSpJ+u4qCkjkkW0LXz9K1KIzkU","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"T2NTaXo5bTeYx7ScSPyDEj70GI8/BdroelOMplhJia/r64gLW9sRkjs9YVKjWy0K/5YgktwV2pHVDmpvNiZQCg"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAAg	1673683489700	{"key":"CWgNeept6WuB0/rD4lc+Fjc/3ht5HwAXO+8BXABiPUA","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"FcvqOCPO2rzzWt835vGqe96mJMK5pv9H9Kem3HhrRTfCzTERwuKwZMVhPsjmek0knWvqK70pUl+WRZK4X6XTDg"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAAQ	1673683489700	{"key":"gnFNQZev+I7tKOwl8TVP5S6X4gvtyqDhMV/BnN02REo","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"KPoBLZERCEF4mcceTV2F3+R5RoWzE0AEtWbAmKutNXCxgUwtn8oJ6GBhbXwjltmPYi3C6Al5LjYDQ5ZlA2A0Aw"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAACw	1673683489985	{"key":"qun291jQbJa4kPr2C2U+ePaYM5VLqBbszLNHnp5r0yA","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"wnijsZCerabmhmb03oVs5d5DLfX3ZVZEiWUYnWv4NbqHIHzLAglo/L2KbQ4/a5IoVmA62KoQD3TfnhlWYBWcCg"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAACg	1673683489985	{"key":"/YBJWAx51BakxMbDddWRpa3Xj3poXxwYLXd9pw9tqTM","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"uqIO8h2zjJpwTHm0Ika6A66KxD6s00zVIx+c0Wa9iVO7uDzcA0S0wG+zt7ajSooXgfpTBZO3d/DZaU+9YbMSDg"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAACQ	1673683489985	{"key":"b3Y7vh1A8j73zGzxd6XWMOntxHSuKEk9hNcnQc8RgHo","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"Gf+ZRvbFvw3tq6NnrXwvMjHHRI6lZzr2yWk3PjLcGYIvyyHOp2zEP3fKGkNErXNTJbRniwVmAMPg2D4ZqloaBg"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAACA	1673683489985	{"key":"edDvli8DKbQ24aNPQAi9K24BbW42Kx/QviQwX9MVOGo","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"Ax2WBYj5cwFOE42PSPNZAlB9O+gfB4QV7xicpsQFFG+7wQSiXbHY7NWWdvGLtrbXNlRtkc1D5eXLkWiOMwyNCA"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAABw	1673683489985	{"key":"sG2+viMLLuIX2RYe0YM0r1aEhyL6MekliFDPfRI3KWQ","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"4TJLc93Xu1BovA6adqw138XuUp2vVaD+w08nqOgkyFzlX0y7CbEg+FeLUcoQ6A9qpFYiWBl6Y3V/F/sc/XL1BA"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAEA	1673683490144	{"key":"vmY8NLyzfKb0wrwG3u5YIeHMeDGpoUFTQ9hXaqcGhgw","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"PrxveYaAxtJeihq97GyY5nx//nISI3W0nRTF2xQcuMNNHhvp+w/oCAiOqnJiRilCZxwtaO8IUb7BFlPu4aHuAg"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAADw	1673683490144	{"key":"v3lVcuoedVyqRy44jFlAV5n63MXrouUjKVcmBas4bxU","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"uz5sJiF0UbKHqwCWbKPEJk9rDUZ0zYNWqHRP1hxuB/F8pguVfveWMV5mmm95/ORE/Snwbgw7EifRdCUywiIKBA"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAADg	1673683490144	{"key":"HhGG6vhdvTiaRpxZlGInYv3Aop5qIgp7MGEOFU0DVzg","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"qhccRja6QGLejq6tT25MsSdPICL8MPEb5u59Sn73i3xKbb9uw1J/Au1+tqPgrcREFiWEUNsyB8KIBpWU7Q8qAQ"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAADQ	1673683490144	{"key":"/h2p6BcFkPN4DV5JBth/1YrVrsCAmZyGvbDb+ZwBsn0","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"K3jQe6jdXxdRm0H4uk7Cwzl4YXAzHB3i5TY3K91DzxsyD9Ayqu7bkFigAqPAUKy190lJLqVFPCF7T1lzQAIRCA"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAADA	1673683490144	{"key":"DOSRLpZIoSctC54DhgRgaVCLwJMv50in8Y4vjCdp8xs","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"Ya1hPv7y1LrsUtBJzoK9PAfMAitzmLKIP//QMggtbExpiuqtCBFvwekxQ47N0DiAtH/Awi0hUKL74hFy3mhyDQ"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAFQ	1673683490243	{"key":"nuVjYqjIoF3LGB6bqLdOuKR9JPwz9E6ytQZKENZwmkU","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"eBI29Pw9YK6anMF6IrlHgZ6s141Ch5hqPX/SZNR9qRfJtc+xnPTH6/qES12R4UmIbShKsORDntzuwKDIZzVTCg"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAFA	1673683490243	{"key":"iHbe7RwiZsADu5XAmXGezt+Fd9szy7MqPfUNV6r7AFk","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"WrQisja+hknh8YiAGOVzWvMkqs9fVoj0nb1IpK6xbOWO6+2396ewnbqu9bk2TamthX2Qj6AmeF4FhduZyJZEDA"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAEw	1673683490243	{"key":"kEn9Z7pEVD3s1CJv5LwUxnDWC/BmImrYFiI9wYFQfwY","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"vYjigXpBUY/9NYfYMHqrBigs1IXhTzsu268liiUGTBMDwimd4I/uMspB0CE2XA+NBWHgTC3K1a7eDAeT9YxiAg"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAEg	1673683490243	{"key":"nKuyp1Qzudh7IYzgaDDB50g1Ic1p5zaPU7I0vWX1mh8","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"p5hGUij2G+ZGWHSflLHXEyYL54vvwpxEgkapvReO7K13ljCH9m5nEIxRAF22G8MTfH+Noeldspfw56Dw795jAA"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAEQ	1673683490243	{"key":"t9E6zDQ3iKhA0t/tyKuDvk4aEWKJ6JWR+0b3owz4o0A","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"EZu6Br3LtE6z9MqQwzmPjGa/0RHHUvzvvGvVVWBrf0n0R7QbHcE2wTOfdRroWmCGxIrfeCs4vSiGYZefaRkYCQ"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAGg	1673683490385	{"key":"NdZSP6EioiEC1OsDD+SMlrmbq0STZOPrm6ey4GVr32o","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"jMfXquP9ZNdW282rHulHKjEHVmS69nS6SKakDVvGbXFTFh38GCAmqo21qknf+RBHdWv5k8uAxkLJShufRGY2Dg"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAGQ	1673683490385	{"key":"YPshnszmLBFBizeZDv6/9UvNV6Mr/VJamF+Z7KUkP0Q","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"2Kq31AcprAtOhHFFqHCCqTyD7TLuTczBfmjLpCRqmPeL2zRusoCKPT5fg8TcvZET96G5QTuu71u5uqcDv9thAg"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAGA	1673683490385	{"key":"5Z2FLRcjfjP1BTAINc2sd3QCI5NWgrhyzmds3H2O7no","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"pgWzothdlSlAlnKa1KvkysHKpDKJ+hfWiPIu+dKnwFg7RZhtbaJwlLMTZaV2GTP5Snynzh/I+QDiOqvfKBmQBQ"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAFw	1673683490385	{"key":"YkzKPe5aXGvXsKXQVKeJhkGlTTZ913GZ6/5cMH8gfBg","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"nYLF8xotH1fchMF+yJx4CjDXD2S10Ye0ja2ZTELUS8dBpNJMXMTFe0OzVdmJBYAAYD/BfNT8gkZ8AtWKQXp9Cg"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAFg	1673683490385	{"key":"ebr2ZmDcoYLaynZaG84+xknq0k1+ZN4VjEFhX0+h1i4","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"+qqWMtZfEPVOh0+00VeEXZDTtD0sLA3/eP3wKsT81Cw9A2kuEK6zvqDvej6dB34NL+VNy8XlEubLacjZcwoxBg"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAHw	1673683490552	{"key":"BNRffDpezYmZx4tvcxKQFWIWRWTC/J+Ips86pAvk/Qc","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"gIHomGMCm+j+ceBfXsFlIrATlKgPo6bsVIZMjDUxdjxB45sQfil/OwX9qxKwzzjvAFuLjzZByP69uI5JalhuAA"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAHg	1673683490552	{"key":"H+5zbtb774NKKTeOLUpJmbd8/I6aTvJae9v1T5X64wU","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"5BcQ7ykKTBuRPRncJg00i812hrAlsSdqQD7LlLhAsLLgJeGKM9RP6DJkqqhyg8TNCOr8xKQUjfoit6N82Qj1DQ"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAHQ	1673683490552	{"key":"+9WyF36JZVy7oIFYlyhupys2jTWVBIc1R1QCxJalwmQ","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"ePpixKaH4kxKUd5kQdD7jolG2BIKjxyNkSaEyjdupgCh3Axaw1ZII4fqbUkOhxvpiTZkt0s1PMC1+KwnxTJ9CA"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAHA	1673683490552	{"key":"N4qyvkW5IFBpG6XKYSKA9EPqXls2ntCPge8RlgrJ7Bo","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"ZHrNDSphu0rE+Pi4fxMJhO7/+9HIUkVyKiKw5mmr/75mNwtNfVr2KjHqdB1XbpGZwSiEGCuy+XxG4KuPmarPBw"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAGw	1673683490552	{"key":"ubbFa0xX1uxR2rpqBxwFEDJFXFhntu/tzqiT7hC9BzY","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"1L8x9hxPGgL+12OH7pezn6+mGFrNq/fcrQGAnl/ivt7ylL23crfPZhZT/gN7MYouAMHuxhSXOr4eqhlmLFpkCA"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAJA	1673683490783	{"key":"Q+EHRNDMAH5BprxyOXyGVNSTzigXzqENJ2xnFY7kcWU","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"MiUsLzWhugvCO3NN/uEkw6NuKuITyKkJDzqLIR+TPbd+3ViTXYSPdFSltUU7md/JU7Q0YO1ZQ5aTNNM0duCPDw"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAIw	1673683490783	{"key":"68CUwvdKssKA3k7EOmovK2kjF3voAiIIpjE0tSCEihw","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"EokdhpfICNu9U/ioQbPxRl5jcJXf9IC78xPa0EEeIADYT6RP2v/drxQdr7Abl1EtNt/gWIILabtQBJi5EyDiBg"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAIg	1673683490783	{"key":"kS74I5yAqgQzXf+0E9GFOpkbRDbMfJ/X8/dAinrMizE","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"zAcJo7zq6Wj6tfRyEqYVHaaCzm08dENbYfAIj2b/OkMxmRggP3L1kJtsgOVgYhPlczfCMGTrW+JyPx3MNENgDA"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAIQ	1673683490783	{"key":"wXlEJ/ahz52VovN4FqxcPVtKqUwZQliEpelJkmoi1jA","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"1Y7iEp4A7qK1p5ZXPhztMwgz+iLjveqyyKb5H6bl/tc6ZmCmu2diYUMcx44zN9dJ8mFlMXcawKpQiDDks+hEBQ"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAIA	1673683490783	{"key":"whB2BJq9AjhgUNArH8ph9bT9poRVPqbFGX96bKOdr14","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"Z0bIyVs+0dfAJjO7d/UutlmB+h14Nt948ZVupd7BVOKfs3e77iYQk0jD9l0RMIzreDrlVN4YFuBHd8784KCuBg"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAKQ	1673683490963	{"key":"J3wWiUE1BfpD1Nwik44E4r1CE1C7wCibosnaHVg9uQs","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"qs+cChfB/7iElZpP7UzSR18TyMnXB4JCEkWTT9FcL3P9SOqD264VFNR4iG2lGTXycee5dIGrfUs3G/FB8JYTDw"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAKA	1673683490963	{"key":"efx/iwfeL5UMZqUyogAC6Q4XxPPbqMSrLPLdwy2gM3g","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"PiLoNZpviBqJK/nb/qQvwx2hOFT5V10iCGMyJNGcYoFodZ0zG0pz17RXWWdWIhfzRCzEn6jIQpfbs39GRiarCA"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAJw	1673683490963	{"key":"2GoT6DQExhA+ZJ5jw93BRMvWi4C/4D5oOIWnUOeOaik","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"VlddPnLfXix89lti8b9aqX8AhGJ/Ne04eUlcUSlb3w9PuTkeKePnSHAGoOTG26oOFkHmj1ScSjdbanFgfwhHBQ"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAJg	1673683490963	{"key":"vUHUYIVeNYwJPuXefWOal1mwQujzdsrci3oFJ0lkiRY","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"+Fbg3+H2LVbiemA+AAI01SjvWAcKx6EDVmGvO52nNwsTCusUVmXMteDwC0d4bdFR0vYofnmK5zOcntqJdNUcCg"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAJQ	1673683490963	{"key":"l0g+3ZXPedz/jx0CRcwEZF7isU98kOSxXe0J9Y01KUQ","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"K1wD/L/Ui25WNEgJiBnGbAx6jzQYRxKs7Flpc/inzRFM5c0FSGzNuudqpp2FNX9MFNK3rqcW5nw9TXAEaLPoAQ"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAALg	1673683491115	{"key":"/wtD0ifPhSzboJBV53DJi3xaYH3c43Gix1jdSqT2gXk","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"0JXAFileJEe498pixBBaor7Gx7mgXEelNKUMDGPSbkHU3uRDxghrqk6qgwZZBV/BxuqocBd7QDK6EF53hC3BBQ"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAALQ	1673683491115	{"key":"tSRgSo4dLRorYiHAXAgXE3xpO0eFqQkBouyixc+Cml8","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"+vRbxk4XdUKxCaR0wtFrNv+t6pFZ4S7D9MwLn0yYUEjAux60ot2ZwfCXr5kYbpgmL5geM0DlPdtLY21wwstWDw"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAALA	1673683491115	{"key":"863TFF79nH1LRe/x6O7cidmwXvqY21KdS3oVa70Qf2Y","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"cPczmCITFXRS01CUOF0BZ/NSiKMjvLNGPfJ7KAaL++OIpDhoBkYY5a6Z0cBKzGgicoq4zmuvQd0RsRWd43HIDg"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAKw	1673683491115	{"key":"mchgIbXuUyHt5d5Mgo7BfwuArsrhHHc1QzRT1ae3wWs","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"FMaxkn2+ZVtRkkTvbISMLlvgf8Q7s7s4q45yDVUU4oyCNdcAh44lFjBsiUgJkRiav7ApyN8MkJq44/IbRaPACg"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAKg	1673683491115	{"key":"MeXc+mepYgveRBRsIyCK5jmsBnkRXTdyd5Xl8AmXJR4","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"iVcp3SYVebAf4QzsUgxFeDvVwgWtHq9eehMdRfVQCgJBPO99fgmglbbyuptZOliH4I+gIyyx7EJ+z9TlWEFDDQ"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAMw	1673683491245	{"key":"O6p4FMlN5fmL4rtND90bXDpE6Dv0RNHGCnOpZvW2Qwk","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"D1J4569smBe2BaubSK0VQs3yq0SS6EKtBpEjYokt6zh8KGrXO+heUMwZ0uLDSSJtReLCNbwWpA50XEnA/4CFCQ"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAMg	1673683491245	{"key":"DvGFF+qoUJgp125xGnYy1TAH/P4r7oZ+lqPv0DGVOlU","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"kPba6K0959CbxBb8/D8tV0Z8MRlIHDMYUJbhYQ4dDqcV6v3JKLwXI2MxZBB02/uSPSX2/B186TkuCZ0kgbJRDw"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAMQ	1673683491245	{"key":"6ofu5lbe7ezNsPNghATuLBEg/jIDaQyj0k7B367ES3Q","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"+q0dOyaUM4mfqlXWYKqIoVF9fOqlYM/r+oA9rVD+mqO/KYEqvi73b3dibph/McMFU5yhJMbRYVNXBb5brHfxAA"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAAMA	1673683491245	{"key":"/XTwu5SVYZ2WJ0BhFzxSb7RtFCDeMfgYZKsw6plSL1Y","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"RA0pSClt3s6ZiquyZlXqu1ujLkks/R1j50Y+X1GKOUuCocCFkGCxtFwmiyeQaZl5uMpdXeW3QBmUFVew9runCQ"}}}
@user1:localhost	YRNLOWWMIS	signed_curve25519	AAAALw	1673683491245	{"key":"ZsgW1Cl/KuxGm5XuEEcsv0gH4vJ5/SqwxuBgV6EWjW4","signatures":{"@user1:localhost":{"ed25519:YRNLOWWMIS":"8T1j1L3A3onWD9LEtQb164JccUeCgY6ELwp+kqXHC3FXQJHYxcV6Y237nOVBslf9bkwp774ybCnHOO1HT6eKBQ"}}}
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
$kHkn3X5sgQZbnc7m1GNs3FoN729sUsLsqASYxvh3Jb8	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$kHkn3X5sgQZbnc7m1GNs3FoN729sUsLsqASYxvh3Jb8	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$kHkn3X5sgQZbnc7m1GNs3FoN729sUsLsqASYxvh3Jb8	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$cl-cBWQqCEUtQdjEqlQcE0PD7MCeX1R25oC5CKqb7oE	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$cl-cBWQqCEUtQdjEqlQcE0PD7MCeX1R25oC5CKqb7oE	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$cl-cBWQqCEUtQdjEqlQcE0PD7MCeX1R25oC5CKqb7oE	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$S7qfuHyVNKlnX8WQb78EyVSR_7_dnmagLA8asozsQtE	$666ybhBdzZc96KCxYMslNrmlLRi8w6uUusi8J4BUVNM	!kmbTYjjsDRDHGgVqUP:localhost
$S7qfuHyVNKlnX8WQb78EyVSR_7_dnmagLA8asozsQtE	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$S7qfuHyVNKlnX8WQb78EyVSR_7_dnmagLA8asozsQtE	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$S7qfuHyVNKlnX8WQb78EyVSR_7_dnmagLA8asozsQtE	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$TOzcyxIV2S5U6CP15QCldRMJRaDz1Yaik15PorvZYGc	$mGK5pQEzegKFhAPXc0TX7drNl2qyJL8ajxnJRmA3kN8	!dKcbdDATuwwphjRPQP:localhost
$TOzcyxIV2S5U6CP15QCldRMJRaDz1Yaik15PorvZYGc	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$TOzcyxIV2S5U6CP15QCldRMJRaDz1Yaik15PorvZYGc	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$TOzcyxIV2S5U6CP15QCldRMJRaDz1Yaik15PorvZYGc	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$Sa-w9Co29Yd94wHfPbpfCOuSSlMlorQ7ssiGXYp8oh8	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$Sa-w9Co29Yd94wHfPbpfCOuSSlMlorQ7ssiGXYp8oh8	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$Sa-w9Co29Yd94wHfPbpfCOuSSlMlorQ7ssiGXYp8oh8	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$Sa-w9Co29Yd94wHfPbpfCOuSSlMlorQ7ssiGXYp8oh8	$S7qfuHyVNKlnX8WQb78EyVSR_7_dnmagLA8asozsQtE	!kmbTYjjsDRDHGgVqUP:localhost
$n6TBNMF739-W93vnPpWYiJ_zTj-UGsx8mCtkFUsmkrY	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$n6TBNMF739-W93vnPpWYiJ_zTj-UGsx8mCtkFUsmkrY	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$n6TBNMF739-W93vnPpWYiJ_zTj-UGsx8mCtkFUsmkrY	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$n6TBNMF739-W93vnPpWYiJ_zTj-UGsx8mCtkFUsmkrY	$TOzcyxIV2S5U6CP15QCldRMJRaDz1Yaik15PorvZYGc	!dKcbdDATuwwphjRPQP:localhost
$Op0TBQz5bRKUyxhUgvd0RMEbDt0BloR6y_aUatQJcO4	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$Op0TBQz5bRKUyxhUgvd0RMEbDt0BloR6y_aUatQJcO4	$PSZPiF2_GHeawUZsuFzgg_JuCtoOyaf_11-uLulGF0c	!dKcbdDATuwwphjRPQP:localhost
$Op0TBQz5bRKUyxhUgvd0RMEbDt0BloR6y_aUatQJcO4	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$Op0TBQz5bRKUyxhUgvd0RMEbDt0BloR6y_aUatQJcO4	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$KjxZjGyxoIyEvF0d6WjubIy5-PjQ8gTixRenqiw88iA	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$KjxZjGyxoIyEvF0d6WjubIy5-PjQ8gTixRenqiw88iA	$t5n7gGV4l0pVzkJq8YJdQm4IFq3hTrEHABs9QiejsEA	!kmbTYjjsDRDHGgVqUP:localhost
$KjxZjGyxoIyEvF0d6WjubIy5-PjQ8gTixRenqiw88iA	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$KjxZjGyxoIyEvF0d6WjubIy5-PjQ8gTixRenqiw88iA	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$zUomLm3mThwuYeUXH2UXzsuqxE6DQeH_95sT95psJag	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$zUomLm3mThwuYeUXH2UXzsuqxE6DQeH_95sT95psJag	$Op0TBQz5bRKUyxhUgvd0RMEbDt0BloR6y_aUatQJcO4	!dKcbdDATuwwphjRPQP:localhost
$zUomLm3mThwuYeUXH2UXzsuqxE6DQeH_95sT95psJag	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$zUomLm3mThwuYeUXH2UXzsuqxE6DQeH_95sT95psJag	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$XMPmaEvrP8Ebnl1P6-T-4JWR8Ms1HgLkboYib2Z0LAI	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$XMPmaEvrP8Ebnl1P6-T-4JWR8Ms1HgLkboYib2Z0LAI	$KjxZjGyxoIyEvF0d6WjubIy5-PjQ8gTixRenqiw88iA	!kmbTYjjsDRDHGgVqUP:localhost
$XMPmaEvrP8Ebnl1P6-T-4JWR8Ms1HgLkboYib2Z0LAI	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$XMPmaEvrP8Ebnl1P6-T-4JWR8Ms1HgLkboYib2Z0LAI	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$sKC-AGmNhmjm9fAYYksybJgXr_tCsBeZrEAv6k7VTyk	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$sKC-AGmNhmjm9fAYYksybJgXr_tCsBeZrEAv6k7VTyk	$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0	!dKcbdDATuwwphjRPQP:localhost
$sKC-AGmNhmjm9fAYYksybJgXr_tCsBeZrEAv6k7VTyk	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$sKC-AGmNhmjm9fAYYksybJgXr_tCsBeZrEAv6k7VTyk	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$8Lzt8KQPe0wAkuTOKq6BkdBqXu9LrnnsSyeYQ70hPDs	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$8Lzt8KQPe0wAkuTOKq6BkdBqXu9LrnnsSyeYQ70hPDs	$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk	!kmbTYjjsDRDHGgVqUP:localhost
$8Lzt8KQPe0wAkuTOKq6BkdBqXu9LrnnsSyeYQ70hPDs	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$8Lzt8KQPe0wAkuTOKq6BkdBqXu9LrnnsSyeYQ70hPDs	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$9i3p0sl8iw-4rVjwMHJnTFujme1in4rnO1zkP9hPq8w	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$9i3p0sl8iw-4rVjwMHJnTFujme1in4rnO1zkP9hPq8w	$sKC-AGmNhmjm9fAYYksybJgXr_tCsBeZrEAv6k7VTyk	!dKcbdDATuwwphjRPQP:localhost
$9i3p0sl8iw-4rVjwMHJnTFujme1in4rnO1zkP9hPq8w	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$9i3p0sl8iw-4rVjwMHJnTFujme1in4rnO1zkP9hPq8w	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$1c97W6vcISTaUEtVZ3XtpTvdbUxTp84W9UUnJ7yQ1hI	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$1c97W6vcISTaUEtVZ3XtpTvdbUxTp84W9UUnJ7yQ1hI	$8Lzt8KQPe0wAkuTOKq6BkdBqXu9LrnnsSyeYQ70hPDs	!kmbTYjjsDRDHGgVqUP:localhost
$1c97W6vcISTaUEtVZ3XtpTvdbUxTp84W9UUnJ7yQ1hI	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$1c97W6vcISTaUEtVZ3XtpTvdbUxTp84W9UUnJ7yQ1hI	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
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
25	1	9	1
25	1	18	1
25	1	16	1
25	1	3	1
26	1	7	1
26	1	10	1
26	1	8	1
26	1	1	1
27	1	16	1
27	1	3	1
27	1	9	1
27	1	20	1
27	1	18	1
28	1	19	1
28	1	8	1
28	1	10	1
28	1	1	1
28	1	7	1
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
$kHkn3X5sgQZbnc7m1GNs3FoN729sUsLsqASYxvh3Jb8	25	1
$cl-cBWQqCEUtQdjEqlQcE0PD7MCeX1R25oC5CKqb7oE	26	1
$S7qfuHyVNKlnX8WQb78EyVSR_7_dnmagLA8asozsQtE	27	1
$TOzcyxIV2S5U6CP15QCldRMJRaDz1Yaik15PorvZYGc	28	1
$Sa-w9Co29Yd94wHfPbpfCOuSSlMlorQ7ssiGXYp8oh8	27	2
$n6TBNMF739-W93vnPpWYiJ_zTj-UGsx8mCtkFUsmkrY	28	2
$Op0TBQz5bRKUyxhUgvd0RMEbDt0BloR6y_aUatQJcO4	21	3
$KjxZjGyxoIyEvF0d6WjubIy5-PjQ8gTixRenqiw88iA	22	3
$zUomLm3mThwuYeUXH2UXzsuqxE6DQeH_95sT95psJag	21	4
$XMPmaEvrP8Ebnl1P6-T-4JWR8Ms1HgLkboYib2Z0LAI	22	4
$sKC-AGmNhmjm9fAYYksybJgXr_tCsBeZrEAv6k7VTyk	14	2
$8Lzt8KQPe0wAkuTOKq6BkdBqXu9LrnnsSyeYQ70hPDs	15	2
$9i3p0sl8iw-4rVjwMHJnTFujme1in4rnO1zkP9hPq8w	14	3
$1c97W6vcISTaUEtVZ3XtpTvdbUxTp84W9UUnJ7yQ1hI	15	3
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
$kHkn3X5sgQZbnc7m1GNs3FoN729sUsLsqASYxvh3Jb8	$Jt6sBZkF1u2z9OovN4zzqiZfS0rQPS2vVpynSjt9ypI	!kmbTYjjsDRDHGgVqUP:localhost	f
$cl-cBWQqCEUtQdjEqlQcE0PD7MCeX1R25oC5CKqb7oE	$xRdCRWLb62a-YRgcfBkJSxc7lUVFkdZnQfSIvcKWw88	!dKcbdDATuwwphjRPQP:localhost	f
$8a8OTFPqvfsx2aHJeu9IBu-xR3Gn7rdv9l_HZtPKkFg	$cl-cBWQqCEUtQdjEqlQcE0PD7MCeX1R25oC5CKqb7oE	!dKcbdDATuwwphjRPQP:localhost	f
$BWMrEpKFpKKbBz5Ox9zTP3TvT5zyh6w3zhpl-epXhkk	$kHkn3X5sgQZbnc7m1GNs3FoN729sUsLsqASYxvh3Jb8	!kmbTYjjsDRDHGgVqUP:localhost	f
$r3Ho1IsdJmJB13pD9yX-Jkg_a5s28kBCqoNZ5EPWwqM	$BWMrEpKFpKKbBz5Ox9zTP3TvT5zyh6w3zhpl-epXhkk	!kmbTYjjsDRDHGgVqUP:localhost	f
$fQ28BQv7GUBcg_Ok7MCh8uTcQLoT2Tkr2BegUMhst1M	$r3Ho1IsdJmJB13pD9yX-Jkg_a5s28kBCqoNZ5EPWwqM	!kmbTYjjsDRDHGgVqUP:localhost	f
$S7qfuHyVNKlnX8WQb78EyVSR_7_dnmagLA8asozsQtE	$fQ28BQv7GUBcg_Ok7MCh8uTcQLoT2Tkr2BegUMhst1M	!kmbTYjjsDRDHGgVqUP:localhost	f
$TOzcyxIV2S5U6CP15QCldRMJRaDz1Yaik15PorvZYGc	$8a8OTFPqvfsx2aHJeu9IBu-xR3Gn7rdv9l_HZtPKkFg	!dKcbdDATuwwphjRPQP:localhost	f
$Sa-w9Co29Yd94wHfPbpfCOuSSlMlorQ7ssiGXYp8oh8	$S7qfuHyVNKlnX8WQb78EyVSR_7_dnmagLA8asozsQtE	!kmbTYjjsDRDHGgVqUP:localhost	f
$n6TBNMF739-W93vnPpWYiJ_zTj-UGsx8mCtkFUsmkrY	$TOzcyxIV2S5U6CP15QCldRMJRaDz1Yaik15PorvZYGc	!dKcbdDATuwwphjRPQP:localhost	f
$5auMphtCZ9zvRqrhyXpY0s-cZZl2AbvkyGNRbm2h2zc	$Sa-w9Co29Yd94wHfPbpfCOuSSlMlorQ7ssiGXYp8oh8	!kmbTYjjsDRDHGgVqUP:localhost	f
$Yb59onmhkHIpIJ_VnrP0V02pkFQEF1GwuJqZCNRTQeQ	$5auMphtCZ9zvRqrhyXpY0s-cZZl2AbvkyGNRbm2h2zc	!kmbTYjjsDRDHGgVqUP:localhost	f
$j0CTOXXA4AtSOD0pk6kL2BNsa6j5w517GGfkTqmm9ZE	$Yb59onmhkHIpIJ_VnrP0V02pkFQEF1GwuJqZCNRTQeQ	!kmbTYjjsDRDHGgVqUP:localhost	f
$YgrzVCWDDxVv-dvf3HhpLD0QlN4nD5-CXg0T-gEX6iI	$j0CTOXXA4AtSOD0pk6kL2BNsa6j5w517GGfkTqmm9ZE	!kmbTYjjsDRDHGgVqUP:localhost	f
$IaI_j1zJZ04lmJmCzJfvnr48U2umqKYG1xogY-r9UNY	$YgrzVCWDDxVv-dvf3HhpLD0QlN4nD5-CXg0T-gEX6iI	!kmbTYjjsDRDHGgVqUP:localhost	f
$TbIhAYsmySe2O7IaMBarYDokr6-UmyH4IYI3SpbhI-Q	$n6TBNMF739-W93vnPpWYiJ_zTj-UGsx8mCtkFUsmkrY	!dKcbdDATuwwphjRPQP:localhost	f
$YBt0yFQdKC_886W6aXe4LIv5A5BcBP7pXYeF8XLKhH0	$TbIhAYsmySe2O7IaMBarYDokr6-UmyH4IYI3SpbhI-Q	!dKcbdDATuwwphjRPQP:localhost	f
$-wkWlUVunP818RkFXsoACrEQ85-ybLTc-vWqiil50Vo	$YBt0yFQdKC_886W6aXe4LIv5A5BcBP7pXYeF8XLKhH0	!dKcbdDATuwwphjRPQP:localhost	f
$kQPpv66TuseXeTXJr41QlqLnJBWNpBA_zgzIaJMjpLc	$IaI_j1zJZ04lmJmCzJfvnr48U2umqKYG1xogY-r9UNY	!kmbTYjjsDRDHGgVqUP:localhost	f
$BG2gCT3tXMWdl5AO704CVjroaQJysHmLZMRN-QrTH8w	$-wkWlUVunP818RkFXsoACrEQ85-ybLTc-vWqiil50Vo	!dKcbdDATuwwphjRPQP:localhost	f
$AXNJvl1CFFkmeDr63y2IykCN_G-lJiDa4JHsOjaUj4Y	$BG2gCT3tXMWdl5AO704CVjroaQJysHmLZMRN-QrTH8w	!dKcbdDATuwwphjRPQP:localhost	f
$9hK3JsOVrMiv0wKjw57rMkc6mne_XmZ0CRTz65g97ek	$AXNJvl1CFFkmeDr63y2IykCN_G-lJiDa4JHsOjaUj4Y	!dKcbdDATuwwphjRPQP:localhost	f
$uFBLsg4RZn3DtG5dqcZ8A11zEbkWHwPLjk_VQtaj0qM	$kQPpv66TuseXeTXJr41QlqLnJBWNpBA_zgzIaJMjpLc	!kmbTYjjsDRDHGgVqUP:localhost	f
$wFcIkswyANl3CQZdt_hX9g9e2TeFjIzp9bWhcEbBiCI	$uFBLsg4RZn3DtG5dqcZ8A11zEbkWHwPLjk_VQtaj0qM	!kmbTYjjsDRDHGgVqUP:localhost	f
$Y_FmFbCe62ffJ-UyN7IA1IbcRgUsELxe9lGLmGbDg9o	$9hK3JsOVrMiv0wKjw57rMkc6mne_XmZ0CRTz65g97ek	!dKcbdDATuwwphjRPQP:localhost	f
$CPoznAc0caDQuTVk0FlfLDWH79HumOVggLi7MDSYT5M	$Y_FmFbCe62ffJ-UyN7IA1IbcRgUsELxe9lGLmGbDg9o	!dKcbdDATuwwphjRPQP:localhost	f
$pWJdSD5NsfN2PI0YapF9GmJPDpHhbeH6m--Uc5qoX-A	$CPoznAc0caDQuTVk0FlfLDWH79HumOVggLi7MDSYT5M	!dKcbdDATuwwphjRPQP:localhost	f
$zsvkWRGeOerm3Q5DPlTgr7kA7cM2-F0gXr40MUzknyc	$wFcIkswyANl3CQZdt_hX9g9e2TeFjIzp9bWhcEbBiCI	!kmbTYjjsDRDHGgVqUP:localhost	f
$NSU5p_lrJEBTd3R6M_2_6ujF1CP9jw5z6-bDhTYxlzY	$zsvkWRGeOerm3Q5DPlTgr7kA7cM2-F0gXr40MUzknyc	!kmbTYjjsDRDHGgVqUP:localhost	f
$35mlnbt-wcKTRY9cY7oyxyQbIoQPDLdRLHQQPGPVJzo	$NSU5p_lrJEBTd3R6M_2_6ujF1CP9jw5z6-bDhTYxlzY	!kmbTYjjsDRDHGgVqUP:localhost	f
$bZPoJ2CteeROVbzJXAb_pwUfP2AIqhQn8X1nYN6cjRI	$35mlnbt-wcKTRY9cY7oyxyQbIoQPDLdRLHQQPGPVJzo	!kmbTYjjsDRDHGgVqUP:localhost	f
$EpI_As8tc8wuYQzlSbGEsxAOAAjphf1Wn48-zC2Pj68	$bZPoJ2CteeROVbzJXAb_pwUfP2AIqhQn8X1nYN6cjRI	!kmbTYjjsDRDHGgVqUP:localhost	f
$Q-2CPBoV3oTFZxGNkFMvNq26XugVjG2Cya0i5tuYeEg	$pWJdSD5NsfN2PI0YapF9GmJPDpHhbeH6m--Uc5qoX-A	!dKcbdDATuwwphjRPQP:localhost	f
$_k0ZpNW0oLpqiDqR7NJvZKdA2ZtHt_egRgLiFirmaYQ	$Q-2CPBoV3oTFZxGNkFMvNq26XugVjG2Cya0i5tuYeEg	!dKcbdDATuwwphjRPQP:localhost	f
$tWUlYx2qFNzpE_0CfMdKwbXSysRu-Z-uE0yWFp2GbGo	$EpI_As8tc8wuYQzlSbGEsxAOAAjphf1Wn48-zC2Pj68	!kmbTYjjsDRDHGgVqUP:localhost	f
$Ip6vtDe80sOxCWnWoPVYYN-aqQ4AdGR-zO_krrdduFg	$_k0ZpNW0oLpqiDqR7NJvZKdA2ZtHt_egRgLiFirmaYQ	!dKcbdDATuwwphjRPQP:localhost	f
$9bNGuvT22oFV6Q8GFIzEZVofSbnyc61EIvnP8_3QqCE	$tWUlYx2qFNzpE_0CfMdKwbXSysRu-Z-uE0yWFp2GbGo	!kmbTYjjsDRDHGgVqUP:localhost	f
$FhGz_XSQqkNt3u5faKV2p5k8gF47j_27y5RwVbtf3dk	$9bNGuvT22oFV6Q8GFIzEZVofSbnyc61EIvnP8_3QqCE	!kmbTYjjsDRDHGgVqUP:localhost	f
$J2GCbFH7iG1fp5SNdsGmkmqFm59eqB_lJMGLY5yk1D8	$FhGz_XSQqkNt3u5faKV2p5k8gF47j_27y5RwVbtf3dk	!kmbTYjjsDRDHGgVqUP:localhost	f
$Dtmij3Zgur83VAr9O_P7MPtbPgUoMnnz_pOwemaro9I	$J2GCbFH7iG1fp5SNdsGmkmqFm59eqB_lJMGLY5yk1D8	!kmbTYjjsDRDHGgVqUP:localhost	f
$Y0__yZ70xH8p15Jr_yTtOJmrMCpaSJLwSo2cc1W4F6o	$Dtmij3Zgur83VAr9O_P7MPtbPgUoMnnz_pOwemaro9I	!kmbTYjjsDRDHGgVqUP:localhost	f
$gPWgeFNvAi1vMKPUzorqatfuOy4HXWKOwonBbcYhiN8	$Y0__yZ70xH8p15Jr_yTtOJmrMCpaSJLwSo2cc1W4F6o	!kmbTYjjsDRDHGgVqUP:localhost	f
$Bh8N0WeVWl8koOcEkS8E0m4kulvHaq75oA0ou0aE8qs	$gPWgeFNvAi1vMKPUzorqatfuOy4HXWKOwonBbcYhiN8	!kmbTYjjsDRDHGgVqUP:localhost	f
$GgR_nTglOMJoS8SoJ-HFOS81y7cmJK64h0DeBVyFxkM	$Ip6vtDe80sOxCWnWoPVYYN-aqQ4AdGR-zO_krrdduFg	!dKcbdDATuwwphjRPQP:localhost	f
$_fc7lLRXoDsqiFKFvhlsSOsOE75ppMdi2ZRa-w_o0OY	$GgR_nTglOMJoS8SoJ-HFOS81y7cmJK64h0DeBVyFxkM	!dKcbdDATuwwphjRPQP:localhost	f
$oXdn9vR9Yxd3FXZOxnZLiW-XByipCOWC32N6UNC7fCI	$_fc7lLRXoDsqiFKFvhlsSOsOE75ppMdi2ZRa-w_o0OY	!dKcbdDATuwwphjRPQP:localhost	f
$sDESXFNHywZLVAjOAvBW4Qtv660_Xx9oVSAIUzZs5bA	$Bh8N0WeVWl8koOcEkS8E0m4kulvHaq75oA0ou0aE8qs	!kmbTYjjsDRDHGgVqUP:localhost	f
$jnaBiJUcEka0drCdQFKBUWluWZq5S7dPNR3XCnWwx8g	$sDESXFNHywZLVAjOAvBW4Qtv660_Xx9oVSAIUzZs5bA	!kmbTYjjsDRDHGgVqUP:localhost	f
$Hlu0oKcyD432dWmJ9w0xHm3PLMnH85Jn-X3GDTYuVV4	$jnaBiJUcEka0drCdQFKBUWluWZq5S7dPNR3XCnWwx8g	!kmbTYjjsDRDHGgVqUP:localhost	f
$krZXlGfGshKwkFJk6XwnR-gCOaeiC5p1Z6YZwNw6Tg0	$oXdn9vR9Yxd3FXZOxnZLiW-XByipCOWC32N6UNC7fCI	!dKcbdDATuwwphjRPQP:localhost	f
$eY_eQCpyM7JAv11-157xBIO8c02XOKPAKO5-oLLkaMM	$krZXlGfGshKwkFJk6XwnR-gCOaeiC5p1Z6YZwNw6Tg0	!dKcbdDATuwwphjRPQP:localhost	f
$vQGo7i4QMQ-SSBxBmQa7vPtet-fqNIosOIQOhXXoLwc	$eY_eQCpyM7JAv11-157xBIO8c02XOKPAKO5-oLLkaMM	!dKcbdDATuwwphjRPQP:localhost	f
$CGChqoz8kvvahzTLr-uENaReKyq5KpqLrL1g9bePx2I	$vQGo7i4QMQ-SSBxBmQa7vPtet-fqNIosOIQOhXXoLwc	!dKcbdDATuwwphjRPQP:localhost	f
$m8qqKQF7tvdc1qLDrWf1DjyHng9_F2Y0v_gzFRh6Kag	$Hlu0oKcyD432dWmJ9w0xHm3PLMnH85Jn-X3GDTYuVV4	!kmbTYjjsDRDHGgVqUP:localhost	f
$UHKKJIW-yVrjog2Pg_MR43oEkfSUhSVKiFGHGPbNaOU	$m8qqKQF7tvdc1qLDrWf1DjyHng9_F2Y0v_gzFRh6Kag	!kmbTYjjsDRDHGgVqUP:localhost	f
$_64yupcz2_qLrKOWrT87_V-HWN64bsQaq1VhCZ_zRnE	$UHKKJIW-yVrjog2Pg_MR43oEkfSUhSVKiFGHGPbNaOU	!kmbTYjjsDRDHGgVqUP:localhost	f
$Yis1BltcsgIBI_y81aVbrWa5qBJs3O4cjY7TtOnv3AU	$CGChqoz8kvvahzTLr-uENaReKyq5KpqLrL1g9bePx2I	!dKcbdDATuwwphjRPQP:localhost	f
$3tVAg8SuDfjs9Fgkhfie7XW_PKyBUpsFLrnHYwASpBc	$Yis1BltcsgIBI_y81aVbrWa5qBJs3O4cjY7TtOnv3AU	!dKcbdDATuwwphjRPQP:localhost	f
$ABAs5n2LLFjtJj9U8vpXJZW4XssE1_1AOKq1Hht9rAc	$_64yupcz2_qLrKOWrT87_V-HWN64bsQaq1VhCZ_zRnE	!kmbTYjjsDRDHGgVqUP:localhost	f
$XhY61XTnLilEWT5TBmpjFvWg-ttI3HSyLVoLRUVNShI	$ABAs5n2LLFjtJj9U8vpXJZW4XssE1_1AOKq1Hht9rAc	!kmbTYjjsDRDHGgVqUP:localhost	f
$efNJ2_fNXgtmBlwuX0QfDBZLeNBnkF0bix0VF0AaBUc	$XhY61XTnLilEWT5TBmpjFvWg-ttI3HSyLVoLRUVNShI	!kmbTYjjsDRDHGgVqUP:localhost	f
$Rx9kQ8hCx2y1bcLpdhzPqXHkrlExdX1yc3YshWnC6og	$efNJ2_fNXgtmBlwuX0QfDBZLeNBnkF0bix0VF0AaBUc	!kmbTYjjsDRDHGgVqUP:localhost	f
$hz_8OnlfAO5weTQ3Sy0cNJ83PP6UGxmBomiBKe4JB5w	$Rx9kQ8hCx2y1bcLpdhzPqXHkrlExdX1yc3YshWnC6og	!kmbTYjjsDRDHGgVqUP:localhost	f
$Op0TBQz5bRKUyxhUgvd0RMEbDt0BloR6y_aUatQJcO4	$3tVAg8SuDfjs9Fgkhfie7XW_PKyBUpsFLrnHYwASpBc	!dKcbdDATuwwphjRPQP:localhost	f
$KjxZjGyxoIyEvF0d6WjubIy5-PjQ8gTixRenqiw88iA	$hz_8OnlfAO5weTQ3Sy0cNJ83PP6UGxmBomiBKe4JB5w	!kmbTYjjsDRDHGgVqUP:localhost	f
$zUomLm3mThwuYeUXH2UXzsuqxE6DQeH_95sT95psJag	$Op0TBQz5bRKUyxhUgvd0RMEbDt0BloR6y_aUatQJcO4	!dKcbdDATuwwphjRPQP:localhost	f
$XMPmaEvrP8Ebnl1P6-T-4JWR8Ms1HgLkboYib2Z0LAI	$KjxZjGyxoIyEvF0d6WjubIy5-PjQ8gTixRenqiw88iA	!kmbTYjjsDRDHGgVqUP:localhost	f
$sKC-AGmNhmjm9fAYYksybJgXr_tCsBeZrEAv6k7VTyk	$zUomLm3mThwuYeUXH2UXzsuqxE6DQeH_95sT95psJag	!dKcbdDATuwwphjRPQP:localhost	f
$8Lzt8KQPe0wAkuTOKq6BkdBqXu9LrnnsSyeYQ70hPDs	$XMPmaEvrP8Ebnl1P6-T-4JWR8Ms1HgLkboYib2Z0LAI	!kmbTYjjsDRDHGgVqUP:localhost	f
$7SK-_DIPq2s374RTSr3as9S8GNyjBCDXOXK_ycMXc74	$VcoB1_pk9tOinsmwdQJYShtIuSLosTj-jzPHDVJjEv8	!kmbTYjjsDRDHGgVqUP:localhost	f
$P2m7f_ReTUYd4Csc5OKob_vf90ua2PMyuv0NqQqhyZs	$tJ-FG4LvyDPWWc02tnnNTzC6FW5jTNsJ4Q0Y3sswUwU	!kmbTYjjsDRDHGgVqUP:localhost	f
$9i3p0sl8iw-4rVjwMHJnTFujme1in4rnO1zkP9hPq8w	$sKC-AGmNhmjm9fAYYksybJgXr_tCsBeZrEAv6k7VTyk	!dKcbdDATuwwphjRPQP:localhost	f
$dyDBJ0bfzPuc6VwuCR3A1Q2GNqb5JweFoRuLiNBdLgg	$u2wX-H57z6LJIi2iBRq8--9YEHZj924d1XHR1tbNoTU	!kmbTYjjsDRDHGgVqUP:localhost	f
$1c97W6vcISTaUEtVZ3XtpTvdbUxTp84W9UUnJ7yQ1hI	$8Lzt8KQPe0wAkuTOKq6BkdBqXu9LrnnsSyeYQ70hPDs	!kmbTYjjsDRDHGgVqUP:localhost	f
$u2wX-H57z6LJIi2iBRq8--9YEHZj924d1XHR1tbNoTU	$1c97W6vcISTaUEtVZ3XtpTvdbUxTp84W9UUnJ7yQ1hI	!kmbTYjjsDRDHGgVqUP:localhost	f
$HtuzOrzcCN4JBQCmC2S0KmN-Sq3OXYHy41_xxL3VNE4	$dyDBJ0bfzPuc6VwuCR3A1Q2GNqb5JweFoRuLiNBdLgg	!kmbTYjjsDRDHGgVqUP:localhost	f
$GoX13j6N-LFoVwqTvDVdFkmlAMyOQncU-wyYccvSOnE	$9i3p0sl8iw-4rVjwMHJnTFujme1in4rnO1zkP9hPq8w	!dKcbdDATuwwphjRPQP:localhost	f
$njvVCKYhRssX__fnFZ8owlNsOC9u3FRj0pmcqeIVVjI	$ORHWJnv40jDzKKISq_X3_aBTGHZZJqjFEVg1kUnrWQ4	!dKcbdDATuwwphjRPQP:localhost	f
$uwxaXiusawT_bOeyGHwB7wfy4YVDUUpEs6A4YMBKfTg	$HtuzOrzcCN4JBQCmC2S0KmN-Sq3OXYHy41_xxL3VNE4	!kmbTYjjsDRDHGgVqUP:localhost	f
$VcoB1_pk9tOinsmwdQJYShtIuSLosTj-jzPHDVJjEv8	$uwxaXiusawT_bOeyGHwB7wfy4YVDUUpEs6A4YMBKfTg	!kmbTYjjsDRDHGgVqUP:localhost	f
$0DBuAxDOgwokpytW0JkbbD3h3YNz3tiYsyJNZZqT6dM	$njvVCKYhRssX__fnFZ8owlNsOC9u3FRj0pmcqeIVVjI	!dKcbdDATuwwphjRPQP:localhost	f
$ORHWJnv40jDzKKISq_X3_aBTGHZZJqjFEVg1kUnrWQ4	$GoX13j6N-LFoVwqTvDVdFkmlAMyOQncU-wyYccvSOnE	!dKcbdDATuwwphjRPQP:localhost	f
$dbbS4HRWajCEFK63hUlDVeDwHbQPIAwiE7q2p34gr64	$7SK-_DIPq2s374RTSr3as9S8GNyjBCDXOXK_ycMXc74	!kmbTYjjsDRDHGgVqUP:localhost	f
$tJ-FG4LvyDPWWc02tnnNTzC6FW5jTNsJ4Q0Y3sswUwU	$dbbS4HRWajCEFK63hUlDVeDwHbQPIAwiE7q2p34gr64	!kmbTYjjsDRDHGgVqUP:localhost	f
$3DuuE2hHvtoVIEVkMMMOyVstiJ3B7k1t3FJ_ifxj4aw	$0DBuAxDOgwokpytW0JkbbD3h3YNz3tiYsyJNZZqT6dM	!dKcbdDATuwwphjRPQP:localhost	f
$3_rhZk71KOig-uRX6JvtgQTiwiDNjWvrhDiK3CsG8Bc	$3DuuE2hHvtoVIEVkMMMOyVstiJ3B7k1t3FJ_ifxj4aw	!dKcbdDATuwwphjRPQP:localhost	f
$kFOWuoGosyBpmijZKeHjb49l9qG1PYd-7_Mz8m7TdZw	$3_rhZk71KOig-uRX6JvtgQTiwiDNjWvrhDiK3CsG8Bc	!dKcbdDATuwwphjRPQP:localhost	f
$WVRAu1BgFM0v9p1pHq87lQjV3QNR3ftT3-zfVqOdjoE	$kFOWuoGosyBpmijZKeHjb49l9qG1PYd-7_Mz8m7TdZw	!dKcbdDATuwwphjRPQP:localhost	f
$GHt9inHBpvm4nrOPtbJHG8c8UlpzqeGJh_-OBG8ptHQ	$WVRAu1BgFM0v9p1pHq87lQjV3QNR3ftT3-zfVqOdjoE	!dKcbdDATuwwphjRPQP:localhost	f
$yVvV-TsDoWvvUlnpW14wS1F-qAd-Vm9J-uj4cAsZykg	$GHt9inHBpvm4nrOPtbJHG8c8UlpzqeGJh_-OBG8ptHQ	!dKcbdDATuwwphjRPQP:localhost	f
$W37bP5pDpEKfiUi_hzWhdjakNnPVlC7KgjnlsImT9os	$yVvV-TsDoWvvUlnpW14wS1F-qAd-Vm9J-uj4cAsZykg	!dKcbdDATuwwphjRPQP:localhost	f
$2KYS5UbprMHWtKf1XE3EdQYt3jO__dF1wZsmNw0m7Po	$W37bP5pDpEKfiUi_hzWhdjakNnPVlC7KgjnlsImT9os	!dKcbdDATuwwphjRPQP:localhost	f
$V_mgJvf-2J-ZWvd3_isj_ng3ED1Y3IR98ma44L3WQ4o	$P2m7f_ReTUYd4Csc5OKob_vf90ua2PMyuv0NqQqhyZs	!kmbTYjjsDRDHGgVqUP:localhost	f
$WVroKTDWt83RCC4syxi_4hpsCXXPlQmrMVO527aD_bg	$V_mgJvf-2J-ZWvd3_isj_ng3ED1Y3IR98ma44L3WQ4o	!kmbTYjjsDRDHGgVqUP:localhost	f
$n5Sx_AizJGu6tfAlx-aQBr2gIQ6eFROdu41oBPH_EYk	$WVroKTDWt83RCC4syxi_4hpsCXXPlQmrMVO527aD_bg	!kmbTYjjsDRDHGgVqUP:localhost	f
$U_hhCm5TKVpLfccts8cldxQRA18VARaw6KqAREJosKQ	$n5Sx_AizJGu6tfAlx-aQBr2gIQ6eFROdu41oBPH_EYk	!kmbTYjjsDRDHGgVqUP:localhost	f
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
$2KYS5UbprMHWtKf1XE3EdQYt3jO__dF1wZsmNw0m7Po	!dKcbdDATuwwphjRPQP:localhost
$U_hhCm5TKVpLfccts8cldxQRA18VARaw6KqAREJosKQ	!kmbTYjjsDRDHGgVqUP:localhost
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
$kHkn3X5sgQZbnc7m1GNs3FoN729sUsLsqASYxvh3Jb8	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":11,"historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o"],"prev_events":["$Jt6sBZkF1u2z9OovN4zzqiZfS0rQPS2vVpynSjt9ypI"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@user1:localhost","content":{"membership":"join","displayname":"User 1"},"depth":21,"prev_state":[],"state_key":"@user1:localhost","origin":"localhost","origin_server_ts":1672918494139,"hashes":{"sha256":"VJ9KoASvERbwI3F9r4aUDElMVg/+Uw1x3panoh5xFFQ"},"signatures":{"localhost":{"ed25519:a_CHdg":"jwQKbHrzeWqJcwZOwN6OBwoD8POzdKt8Z5kEOYcCuCLQav/sfnhieFXKBrBVKZ6CnN+tNjVEZRns6r3Fj+jZAA"}},"unsigned":{"age_ts":1672918494139}}	3
$cl-cBWQqCEUtQdjEqlQcE0PD7MCeX1R25oC5CKqb7oE	!dKcbdDATuwwphjRPQP:localhost	{"token_id":11,"historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs"],"prev_events":["$xRdCRWLb62a-YRgcfBkJSxc7lUVFkdZnQfSIvcKWw88"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@user1:localhost","content":{"membership":"join","displayname":"User 1"},"depth":19,"prev_state":[],"state_key":"@user1:localhost","origin":"localhost","origin_server_ts":1672918508427,"hashes":{"sha256":"wqN5F/BXSzPY9qS5OIBFvcz/MSqUsna/dqa28PIf+zw"},"signatures":{"localhost":{"ed25519:a_CHdg":"6F8Jmyl+FyF7UhX9fBjCreSoTD+CohjFEccu1WaHKB88rgyeAAj6DgTQjYcpqMhJlPZ8TgjFAvgT4KvTK96VAA"}},"unsigned":{"age_ts":1672918508427}}	3
$8a8OTFPqvfsx2aHJeu9IBu-xR3Gn7rdv9l_HZtPKkFg	!dKcbdDATuwwphjRPQP:localhost	{"token_id":2,"txn_id":"1672920683","historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA"],"prev_events":["$cl-cBWQqCEUtQdjEqlQcE0PD7MCeX1R25oC5CKqb7oE"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@admin:localhost","content":{"body":"My text","msgtype":"m.text"},"depth":20,"prev_state":[],"origin":"localhost","origin_server_ts":1672920683485,"hashes":{"sha256":"EAXdSYKMjM6wLQTHQWxPBsEMPbnS49Y1H0bqnXmeqXA"},"signatures":{"localhost":{"ed25519:a_CHdg":"ud5yW+/OefODbUcT8iKlzA3LB0ysbUvsje5YKSeUnLHqiNKf4TAhJwaz5+6ZOgHO4ZwHtWASQFozRscYju4nBQ"}},"unsigned":{"age_ts":1672920683485}}	3
$BWMrEpKFpKKbBz5Ox9zTP3TvT5zyh6w3zhpl-epXhkk	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":2,"txn_id":"1672920817","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw"],"prev_events":["$kHkn3X5sgQZbnc7m1GNs3FoN729sUsLsqASYxvh3Jb8"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@admin:localhost","content":{"body":"My text","msgtype":"m.text"},"depth":22,"prev_state":[],"origin":"localhost","origin_server_ts":1672920816788,"hashes":{"sha256":"x4sO4BLkKa7nGynS8gRg+04wuLwVtlfVHwa3Ax4FLbw"},"signatures":{"localhost":{"ed25519:a_CHdg":"JFp9CoawnCQZneO3OM75BKQt9zFIr/yInJlZmnRdnd/qpLHGxj1E1tFu0MYkeCQG3lYZYf5o3ZiwJuxmnF2CDQ"}},"unsigned":{"age_ts":1672920816788}}	3
$r3Ho1IsdJmJB13pD9yX-Jkg_a5s28kBCqoNZ5EPWwqM	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":4,"txn_id":"1672921550668","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$BWMrEpKFpKKbBz5Ox9zTP3TvT5zyh6w3zhpl-epXhkk"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_b:localhost","content":{"body":"My Text","msgtype":"m.text"},"depth":23,"prev_state":[],"origin":"localhost","origin_server_ts":1672921550713,"hashes":{"sha256":"ImKbJpqhhImN1IFLRCIidezKZbjV8X/WRA+751jEV8I"},"signatures":{"localhost":{"ed25519:a_CHdg":"vqtNrws4z1hE4NM+MJnwS1xjglzODHS8yeo0Ryvt8pEOKrYOtveCNQ5CPTyYrz0HKOMAz2FpNAPDg+uqvmCODg"}},"unsigned":{"age_ts":1672921550713}}	3
$fQ28BQv7GUBcg_Ok7MCh8uTcQLoT2Tkr2BegUMhst1M	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":4,"txn_id":"1672921603086","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$r3Ho1IsdJmJB13pD9yX-Jkg_a5s28kBCqoNZ5EPWwqM"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_b:localhost","content":{"body":"I'll copy the solid state DRAM transmitter, that should capacitor the USB pixel!","msgtype":"m.text"},"depth":24,"prev_state":[],"origin":"localhost","origin_server_ts":1672921603138,"hashes":{"sha256":"Cu3PzUy4HM+3l9yrnIjmsaqlzn1CShyFKwJtWDNyTpg"},"signatures":{"localhost":{"ed25519:a_CHdg":"yWV/pejCEtbJTCBZpRI1aI7tdm433/w7cMJYn9cUXgekujnoEzoXHX+7w6/NtCwlfjAfgsNSkRe2FAB7p4RnAw"}},"unsigned":{"age_ts":1672921603138}}	3
$n6TBNMF739-W93vnPpWYiJ_zTj-UGsx8mCtkFUsmkrY	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$TOzcyxIV2S5U6CP15QCldRMJRaDz1Yaik15PorvZYGc"],"prev_events":["$TOzcyxIV2S5U6CP15QCldRMJRaDz1Yaik15PorvZYGc"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_user1:localhost","content":{"membership":"join","displayname":"user1 [mm]"},"depth":22,"prev_state":[],"state_key":"@mm_user1:localhost","origin":"localhost","origin_server_ts":1672922249928,"hashes":{"sha256":"P4zYInipysNjupSphKZP+repv7suvoIpIHTa0c5l/Yw"},"signatures":{"localhost":{"ed25519:a_CHdg":"y0EYiCgbBwQbPrcSEGeqmpxCJazO0YcIphttu6wYl3VvF6lIe57FzKTEPLAokOz9ceMjvXM2o542tbGlYAjfAQ"}},"unsigned":{"age_ts":1672922249928,"replaces_state":"$TOzcyxIV2S5U6CP15QCldRMJRaDz1Yaik15PorvZYGc"}}	3
$S7qfuHyVNKlnX8WQb78EyVSR_7_dnmagLA8asozsQtE	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$666ybhBdzZc96KCxYMslNrmlLRi8w6uUusi8J4BUVNM","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$fQ28BQv7GUBcg_Ok7MCh8uTcQLoT2Tkr2BegUMhst1M"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"user1 [mm]"},"depth":25,"prev_state":[],"state_key":"@mm_user1:localhost","origin":"localhost","origin_server_ts":1672922249364,"hashes":{"sha256":"lvMafb10jsetq8V7JBN43ObMf4mOqSbTecJYnSLym6w"},"signatures":{"localhost":{"ed25519:a_CHdg":"YqU0aSM9f4xdZTbGgTf0NR1gcNL0BTm5MFWBc1FowElMSmNQB+sAbMRxR8iXk5er+od19XmEWeFnOoWHgwPSBA"}},"unsigned":{"age_ts":1672922249364,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#town-square:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$TOzcyxIV2S5U6CP15QCldRMJRaDz1Yaik15PorvZYGc	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$mGK5pQEzegKFhAPXc0TX7drNl2qyJL8ajxnJRmA3kN8","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$8a8OTFPqvfsx2aHJeu9IBu-xR3Gn7rdv9l_HZtPKkFg"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"user1 [mm]"},"depth":21,"prev_state":[],"state_key":"@mm_user1:localhost","origin":"localhost","origin_server_ts":1672922249479,"hashes":{"sha256":"IO3ui3pw9FdXgbTHpl71L4LdQOC68LVLmWdryXVD6X0"},"signatures":{"localhost":{"ed25519:a_CHdg":"rcGa5pW7vv7+6gwNTzaD5lyqFsquTkXiT59drmSDZjFC5vD9dbu5Q3w71usLVpPy+4Rpysf3aL1/VhxAEoeuCA"}},"unsigned":{"age_ts":1672922249479,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#off-topic:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$Sa-w9Co29Yd94wHfPbpfCOuSSlMlorQ7ssiGXYp8oh8	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$S7qfuHyVNKlnX8WQb78EyVSR_7_dnmagLA8asozsQtE"],"prev_events":["$S7qfuHyVNKlnX8WQb78EyVSR_7_dnmagLA8asozsQtE"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_user1:localhost","content":{"membership":"join","displayname":"user1 [mm]"},"depth":26,"prev_state":[],"state_key":"@mm_user1:localhost","origin":"localhost","origin_server_ts":1672922249759,"hashes":{"sha256":"/jdZM3cEwbg6DEChR7SlTpVdQtkWnBIjIhmVmoATiEk"},"signatures":{"localhost":{"ed25519:a_CHdg":"XPM7q/5Knz3fgXGBwW9oOoOnJFTOFPBtNfAmFdkD545gFubxprzXjwYxX9XFB990a/3UXVPjE5ZMMe6rc1ghBA"}},"unsigned":{"age_ts":1672922249759,"replaces_state":"$S7qfuHyVNKlnX8WQb78EyVSR_7_dnmagLA8asozsQtE"}}	3
$5auMphtCZ9zvRqrhyXpY0s-cZZl2AbvkyGNRbm2h2zc	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672922287732.0","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$Sa-w9Co29Yd94wHfPbpfCOuSSlMlorQ7ssiGXYp8oh8"],"prev_events":["$Sa-w9Co29Yd94wHfPbpfCOuSSlMlorQ7ssiGXYp8oh8"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_user1:localhost","content":{"msgtype":"m.text","body":"Like this channel"},"depth":27,"prev_state":[],"origin":"localhost","origin_server_ts":1672922287761,"hashes":{"sha256":"uSJSsp3YW1gVLkxxCZEVz4QZuCxYaopbJwPY8MgamTE"},"signatures":{"localhost":{"ed25519:a_CHdg":"HzdDZVIlSDiRqZSFxZwZVYAqM/Nd0ymEmtjR5x53YtOrzrxTqy5GLIOJVYroW63aJN7WE+MUjwQKG9Ux23gdDw"}},"unsigned":{"age_ts":1672922287761}}	3
$Yb59onmhkHIpIJ_VnrP0V02pkFQEF1GwuJqZCNRTQeQ	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":4,"txn_id":"1672922412231","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$5auMphtCZ9zvRqrhyXpY0s-cZZl2AbvkyGNRbm2h2zc"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_b:localhost","content":{"body":"Use the digital THX hard drive, then you can parse the solid state alarm!","msgtype":"m.text"},"depth":28,"prev_state":[],"origin":"localhost","origin_server_ts":1672922412287,"hashes":{"sha256":"1a995mFuc2OYRb4F/kEoEfBlMZU2wVjAVxnEjzionuE"},"signatures":{"localhost":{"ed25519:a_CHdg":"i6CP1400RgF6aBSwuFFNmBVC9bw5l0Vs1MfqdtM+mah2mKtVtFXGCOWdrg9kYN9LY/hNI9mz1Xuf3J6c44Z/DA"}},"unsigned":{"age_ts":1672922412287}}	3
$j0CTOXXA4AtSOD0pk6kL2BNsa6j5w517GGfkTqmm9ZE	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672922547553.1","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$Sa-w9Co29Yd94wHfPbpfCOuSSlMlorQ7ssiGXYp8oh8"],"prev_events":["$Yb59onmhkHIpIJ_VnrP0V02pkFQEF1GwuJqZCNRTQeQ"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_user1:localhost","content":{"msgtype":"m.text","body":"Are you online User 1 ?","format":"org.matrix.custom.html","formatted_body":"Are you online <a href='https://matrix.to/#/@user1:localhost'>User 1</a> ?"},"depth":29,"prev_state":[],"origin":"localhost","origin_server_ts":1672922547588,"hashes":{"sha256":"55C77g7UQ1YGE1SRmB9r7wBpIphhmCovMQGhb/P4Jvs"},"signatures":{"localhost":{"ed25519:a_CHdg":"1BbsunImqgvrDouw/kPpJXKSbNGa//WDwLebTo/8lHnX71YvYfmJOgu5GmFCu1SE7FFMt9Z2VGawJbaD/E/oAg"}},"unsigned":{"age_ts":1672922547588}}	3
$YgrzVCWDDxVv-dvf3HhpLD0QlN4nD5-CXg0T-gEX6iI	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":11,"txn_id":"m1672922566753.0","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$kHkn3X5sgQZbnc7m1GNs3FoN729sUsLsqASYxvh3Jb8"],"prev_events":["$j0CTOXXA4AtSOD0pk6kL2BNsa6j5w517GGfkTqmm9ZE"],"type":"m.reaction","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@user1:localhost","content":{"m.relates_to":{"rel_type":"m.annotation","event_id":"$j0CTOXXA4AtSOD0pk6kL2BNsa6j5w517GGfkTqmm9ZE","key":"\\ud83e\\udd29"}},"depth":30,"prev_state":[],"origin":"localhost","origin_server_ts":1672922566841,"hashes":{"sha256":"WEJXzwaafGnDk29PErCnidxuPVWErIrpPpgo53cUxtg"},"signatures":{"localhost":{"ed25519:a_CHdg":"9kajk4mdklAiXeuZVofdPg0xjle0oPPZn1w92WFAcLnuEXZ4vqjjT174PWZiip8GhnXLOJC9z8xw4zjgfFWjBw"}},"unsigned":{"age_ts":1672922566841}}	3
$IaI_j1zJZ04lmJmCzJfvnr48U2umqKYG1xogY-r9UNY	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":11,"txn_id":"m1672922600510.1","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$kHkn3X5sgQZbnc7m1GNs3FoN729sUsLsqASYxvh3Jb8"],"prev_events":["$YgrzVCWDDxVv-dvf3HhpLD0QlN4nD5-CXg0T-gEX6iI"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@user1:localhost","content":{"org.matrix.msc1767.text":"OK","body":"OK","msgtype":"m.text"},"depth":31,"prev_state":[],"origin":"localhost","origin_server_ts":1672922600605,"hashes":{"sha256":"ScGq08z4OGBiRDDrl+Ir61LjBWpeDYojjszsICaLl2E"},"signatures":{"localhost":{"ed25519:a_CHdg":"RyS4yrod+c4LRVnC6gfUmCTG4tiBmzaxe37LUAP0TmWqyz+jlwcCddRBV4FcCM9risx06Qqczx1jMyyv6rOZCQ"}},"unsigned":{"age_ts":1672922600605}}	3
$TbIhAYsmySe2O7IaMBarYDokr6-UmyH4IYI3SpbhI-Q	!dKcbdDATuwwphjRPQP:localhost	{"txn_id":"m1672922654468.2","historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$n6TBNMF739-W93vnPpWYiJ_zTj-UGsx8mCtkFUsmkrY"],"prev_events":["$n6TBNMF739-W93vnPpWYiJ_zTj-UGsx8mCtkFUsmkrY"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_user1:localhost","content":{"msgtype":"m.text","body":"A program"},"depth":23,"prev_state":[],"origin":"localhost","origin_server_ts":1672922654500,"hashes":{"sha256":"DUbVsqi9njrQIEIrWYSQwmESUX2dkPbmeMshrcYra1s"},"signatures":{"localhost":{"ed25519:a_CHdg":"gXfIG0/co4DgNun1Rsm+thP30lW/Q1eiZ5BBwfHPwj11AAH6C07wfwl5W1kGU7gDa4o1nBgICcqkwo3iOX/mAw"}},"unsigned":{"age_ts":1672922654500}}	3
$YBt0yFQdKC_886W6aXe4LIv5A5BcBP7pXYeF8XLKhH0	!dKcbdDATuwwphjRPQP:localhost	{"txn_id":"m1672922655068.3","historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$n6TBNMF739-W93vnPpWYiJ_zTj-UGsx8mCtkFUsmkrY"],"prev_events":["$TbIhAYsmySe2O7IaMBarYDokr6-UmyH4IYI3SpbhI-Q"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_user1:localhost","content":{"msgtype":"m.image","body":"Testing_in_VS_Code.png","url":"mxc://localhost/riXoaRqUQVaJbMHbhxJcKwHB","info":{"mimetype":"image/png","size":172914}},"depth":24,"prev_state":[],"origin":"localhost","origin_server_ts":1672922655109,"hashes":{"sha256":"oLCIF3PeaxZksNQeObEDLIQVwlbXPU38EzQw+dU+1nM"},"signatures":{"localhost":{"ed25519:a_CHdg":"8sHBxFEsCDLQXGqdKKr0Wx4bf0Zrzyb/HrO9e29fLdGJHpG3oVT1KFlHeJ9GUaTejNwyu2qEQrQ1JkADvEOnCA"}},"unsigned":{"age_ts":1672922655109}}	3
$-wkWlUVunP818RkFXsoACrEQ85-ybLTc-vWqiil50Vo	!dKcbdDATuwwphjRPQP:localhost	{"txn_id":"m1672923027733.0","historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$CPrx1EOiKU0xFQBY1-CbMIp4Nx64vw33awql9URc-is","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$YBt0yFQdKC_886W6aXe4LIv5A5BcBP7pXYeF8XLKhH0"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"Nice"},"depth":25,"prev_state":[],"origin":"localhost","origin_server_ts":1672923027781,"hashes":{"sha256":"GLUpVwO2HmluqFgEMW9jVQ6IRq3IS7cg5kDhT54JThY"},"signatures":{"localhost":{"ed25519:a_CHdg":"7oFwUUDaiDl+TfaVkp0FYg5DzvYEYZPlnJHKJIAAJ4vw6dqF0UZXdQWsIIMl2OsLwfM+a7W90LWIWV0SktVlAg"}},"unsigned":{"age_ts":1672923027781}}	3
$kQPpv66TuseXeTXJr41QlqLnJBWNpBA_zgzIaJMjpLc	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":4,"txn_id":"1672923221882","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$IaI_j1zJZ04lmJmCzJfvnr48U2umqKYG1xogY-r9UNY"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_b:localhost","content":{"body":"You can't hack the circuit without indexing the back-end IP bus!","msgtype":"m.text"},"depth":32,"prev_state":[],"origin":"localhost","origin_server_ts":1672923221916,"hashes":{"sha256":"IhDbHsE07WyR0U94GolwjLcAJXqCuBGJECmSjUbiIAU"},"signatures":{"localhost":{"ed25519:a_CHdg":"//rWkPKzzwr/9GCvUvhL9WaxSSsq3r4gVIzxWY5jPhVNgOhnniUyYx6gpnXUTEoV3X1++six+s3x3ZivhD/hCg"}},"unsigned":{"age_ts":1672923221916}}	3
$BG2gCT3tXMWdl5AO704CVjroaQJysHmLZMRN-QrTH8w	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1673367066651.0","historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0"],"prev_events":["$-wkWlUVunP818RkFXsoACrEQ85-ybLTc-vWqiil50Vo"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"hidden message"},"depth":26,"prev_state":[],"origin":"localhost","origin_server_ts":1673367066720,"hashes":{"sha256":"oZBi2hAN3OT+skg4c8/4fFMMgwCSZ3a4U6UaHw50oRU"},"signatures":{"localhost":{"ed25519:a_CHdg":"vhFkOkWw9RsMO6wy9b3jaTDboEt964kTrIgDU9RUeMZj+O7LJ75zSNpyQlOnZtJR32iLjGkRBCeHJSsAvdyJAw"}},"unsigned":{"age_ts":1673367066720}}	3
$AXNJvl1CFFkmeDr63y2IykCN_G-lJiDa4JHsOjaUj4Y	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1673367091785.0","historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0"],"prev_events":["$BG2gCT3tXMWdl5AO704CVjroaQJysHmLZMRN-QrTH8w"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"hidden message"},"depth":27,"prev_state":[],"origin":"localhost","origin_server_ts":1673367091822,"hashes":{"sha256":"VNfcNf2ylqSaWdPu6BnzgdV0ImyjP44PvRJMTVnhewU"},"signatures":{"localhost":{"ed25519:a_CHdg":"vTNM2d2BcX1ugdxagtl6e5IPKBmWGeAqESNxGelAi8qy3KkZBIXQTWDMqPXp4itBiEXa4IeADErWX+3vAricAg"}},"unsigned":{"age_ts":1673367091822}}	3
$9hK3JsOVrMiv0wKjw57rMkc6mne_XmZ0CRTz65g97ek	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1673367607022.0","historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0"],"prev_events":["$AXNJvl1CFFkmeDr63y2IykCN_G-lJiDa4JHsOjaUj4Y"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"hidden message"},"depth":28,"prev_state":[],"origin":"localhost","origin_server_ts":1673367607062,"hashes":{"sha256":"YgbLKsD/+7/e6NmYv+ljZIs7B+wXoRkr3/J7oe5IYfo"},"signatures":{"localhost":{"ed25519:a_CHdg":"lPUMJkYIYaAJjynzS56w74NNuqo0+0ZsxJBSDuWIYlvAtg3nu4oSnU883swtlVG86Dy6VDICqNmygvQGo+M4Bw"}},"unsigned":{"age_ts":1673367607062}}	3
$uFBLsg4RZn3DtG5dqcZ8A11zEbkWHwPLjk_VQtaj0qM	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1673367804437.0","historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$kQPpv66TuseXeTXJr41QlqLnJBWNpBA_zgzIaJMjpLc"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"test"},"depth":33,"prev_state":[],"origin":"localhost","origin_server_ts":1673367804476,"hashes":{"sha256":"AYW1i5LkSUazhgQtHVYQ3l0OD6aGNTWZyGf546O21PA"},"signatures":{"localhost":{"ed25519:a_CHdg":"sojiL2uTZLxU7jJcOUVRDzallndpyyZHU9ASQGFFce955h4WiQk/qKJ/FZxZIOekrOdPuaZRFWREcAhH1faaAQ"}},"unsigned":{"age_ts":1673367804476}}	3
$wFcIkswyANl3CQZdt_hX9g9e2TeFjIzp9bWhcEbBiCI	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1673367882712.0","historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$uFBLsg4RZn3DtG5dqcZ8A11zEbkWHwPLjk_VQtaj0qM"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"test"},"depth":34,"prev_state":[],"origin":"localhost","origin_server_ts":1673367882756,"hashes":{"sha256":"80YREj07HIkFjkA8dnB+tZcsV0j3yI81h4NLN/zrP2U"},"signatures":{"localhost":{"ed25519:a_CHdg":"Q9wrxzE38EJz1KzSf92AqaeDMZM0U+buKzRmkm0IAwpFZ49x4lMU4ROganNEt13L013s7Ig725ylNkdN0/e1AA"}},"unsigned":{"age_ts":1673367882756}}	3
$Y_FmFbCe62ffJ-UyN7IA1IbcRgUsELxe9lGLmGbDg9o	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1673367937034.0","historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0"],"prev_events":["$9hK3JsOVrMiv0wKjw57rMkc6mne_XmZ0CRTz65g97ek"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"first matrix message"},"depth":29,"prev_state":[],"origin":"localhost","origin_server_ts":1673367937094,"hashes":{"sha256":"2ZxouxENidbqu6eCxTMvZuKkk3NACJbxbVyAmeBicBE"},"signatures":{"localhost":{"ed25519:a_CHdg":"KmhhDREPOorOce48X8gEKV9MD0U+gtUwyFoOtFyU9vrBfvuBPT2gsCewn+rf25eyKxMIOWqWLRk9sNIfqCzPDQ"}},"unsigned":{"age_ts":1673367937094}}	3
$CPoznAc0caDQuTVk0FlfLDWH79HumOVggLi7MDSYT5M	!dKcbdDATuwwphjRPQP:localhost	{"token_id":4,"txn_id":"m1673367937150.0","historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0"],"prev_events":["$Y_FmFbCe62ffJ-UyN7IA1IbcRgUsELxe9lGLmGbDg9o"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_b:localhost","content":{"msgtype":"m.text","body":"> <@matrix_a> first matrix message\\n\\nsecond matrix message","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>second matrix message","m.relates_to":{"m.in_reply_to":{"event_id":"$Y_FmFbCe62ffJ-UyN7IA1IbcRgUsELxe9lGLmGbDg9o"}}},"depth":30,"prev_state":[],"origin":"localhost","origin_server_ts":1673367937228,"hashes":{"sha256":"Iu6MW/5LDh3hTr7cWaPcnWBV0BsBUXHGDeYt2+hWzEM"},"signatures":{"localhost":{"ed25519:a_CHdg":"lBBgeopIGmxSx8lrTNa1EEPPFUYcFSGVfl0Yh7rNFUa+lzxPDzlzPmnWd+UmfA9SOn81pyaeaJbRg6vVLINiDw"}},"unsigned":{"age_ts":1673367937228}}	3
$pWJdSD5NsfN2PI0YapF9GmJPDpHhbeH6m--Uc5qoX-A	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1673367937285.1","historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0"],"prev_events":["$CPoznAc0caDQuTVk0FlfLDWH79HumOVggLi7MDSYT5M"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"> <@matrix_b> > <@matrix_a>\\n\\nthird matrix message","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>third matrix message","m.relates_to":{"m.in_reply_to":{"event_id":"$CPoznAc0caDQuTVk0FlfLDWH79HumOVggLi7MDSYT5M"}}},"depth":31,"prev_state":[],"origin":"localhost","origin_server_ts":1673367937356,"hashes":{"sha256":"DorDy2oXIrZvECkpK7xWypbRigoulrc9Wx7I1rKjGLQ"},"signatures":{"localhost":{"ed25519:a_CHdg":"XMfcSNtFs7FTGxfVT/OPl3bNJ7eQVhi93rhoAwEjtQepBDTXm3NKl5S8fkOvo8uewlbUcN22PSup3NE/XwuBCg"}},"unsigned":{"age_ts":1673367937356}}	3
$zsvkWRGeOerm3Q5DPlTgr7kA7cM2-F0gXr40MUzknyc	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1673456419271.0","historical":false}	{"auth_events":["$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$wFcIkswyANl3CQZdt_hX9g9e2TeFjIzp9bWhcEbBiCI"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"test"},"depth":35,"prev_state":[],"origin":"localhost","origin_server_ts":1673456419304,"hashes":{"sha256":"Tnp5+7Ph1GQ+/tn9xAVT1m7g1LpOxeEHYHBnKBK3E0o"},"signatures":{"localhost":{"ed25519:a_CHdg":"XYyE1+YeHfWsL6cF2PQQg0tzTuh0W47C88YWXTEL4M5OLtIhnwwn+Q9qY4SNphCCN4+gVzaM4l4GO/1hsHD7AQ"}},"unsigned":{"age_ts":1673456419304}}	3
$NSU5p_lrJEBTd3R6M_2_6ujF1CP9jw5z6-bDhTYxlzY	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":3,"txn_id":"m1673456422102.0","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$zsvkWRGeOerm3Q5DPlTgr7kA7cM2-F0gXr40MUzknyc"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"test2"},"depth":36,"prev_state":[],"origin":"localhost","origin_server_ts":1673456422195,"hashes":{"sha256":"o1evKoVJFcyo6MENFh1FzE6xbF8yUAtsyEuLD4Wddg4"},"signatures":{"localhost":{"ed25519:a_CHdg":"gOLaDQINeswvsKivuSjp8jpHDFWnyyfgJTxL+pT5b8rUflpUnPNm0v0zULO4VR3xDf1lF43KLtLuTa7VOq4BCw"}},"unsigned":{"age_ts":1673456422195}}	3
$35mlnbt-wcKTRY9cY7oyxyQbIoQPDLdRLHQQPGPVJzo	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1673456423056.1","historical":false}	{"auth_events":["$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$NSU5p_lrJEBTd3R6M_2_6ujF1CP9jw5z6-bDhTYxlzY"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"# Header\\n\\n**bold**","format":"org.matrix.custom.html","formatted_body":"<h1>Header</h1><strong>bold</strong>"},"depth":37,"prev_state":[],"origin":"localhost","origin_server_ts":1673456423178,"hashes":{"sha256":"pjf9sHoL4Ic2VitZi1HbB9YP/7TrcjMXqqK6USJ5wmQ"},"signatures":{"localhost":{"ed25519:a_CHdg":"vUq3WEgW1ZJEVS3KkuwLMQWXrpdHrQ3adJJdAB9WC2KLpKrFTGrE2gr6e+O9vPxb+XxzwWoEQM9MCPIjenecCw"}},"unsigned":{"age_ts":1673456423178}}	3
$bZPoJ2CteeROVbzJXAb_pwUfP2AIqhQn8X1nYN6cjRI	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":4,"txn_id":"m1673456423925.0","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$35mlnbt-wcKTRY9cY7oyxyQbIoQPDLdRLHQQPGPVJzo"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_b:localhost","content":{"msgtype":"m.text","body":"random wrong message","format":"org.matrix.custom.html","formatted_body":"<h1>Header</h1><b>Bolded text</b>"},"depth":38,"prev_state":[],"origin":"localhost","origin_server_ts":1673456424045,"hashes":{"sha256":"lAUrLqf7vlSCcaeO+F6N1jQn3YMvdt1tjoidHmAqmKY"},"signatures":{"localhost":{"ed25519:a_CHdg":"d3SoyWt9VE2hLMrG7RX+f22cshb7wW03sqITpedUV8i8JLjmPmYgBwvHC2Llx9nk83HPt425ig0f5by9HgqEAw"}},"unsigned":{"age_ts":1673456424045}}	3
$EpI_As8tc8wuYQzlSbGEsxAOAAjphf1Wn48-zC2Pj68	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":3,"txn_id":"m1673456424439.0","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$bZPoJ2CteeROVbzJXAb_pwUfP2AIqhQn8X1nYN6cjRI"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.emote","body":"test"},"depth":39,"prev_state":[],"origin":"localhost","origin_server_ts":1673456424470,"hashes":{"sha256":"bouR6rVAadg9MQxrQ98dBuMPtQiOGUaYPfYpovymRUA"},"signatures":{"localhost":{"ed25519:a_CHdg":"shsSQ5NyfzUx3TmMQ2wD0XFGMJNclS7qEf0WNmJXFJSjsmRj53d0GRMzI6WiijSGTzhdLA37hd6IXP41RYKmDg"}},"unsigned":{"age_ts":1673456424470}}	3
$Q-2CPBoV3oTFZxGNkFMvNq26XugVjG2Cya0i5tuYeEg	!dKcbdDATuwwphjRPQP:localhost	{"txn_id":"m1673456424745.0","historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$PSZPiF2_GHeawUZsuFzgg_JuCtoOyaf_11-uLulGF0c","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$pWJdSD5NsfN2PI0YapF9GmJPDpHhbeH6m--Uc5qoX-A"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_b:localhost","content":{"msgtype":"m.text","body":"filename"},"depth":32,"prev_state":[],"origin":"localhost","origin_server_ts":1673456424779,"hashes":{"sha256":"C4YF3tRsAj6muhbdcKEkqWDjFDcY7oQ+v22RdR9OMrA"},"signatures":{"localhost":{"ed25519:a_CHdg":"pPwJtMfG1aBvJrsv5XWif0RxYXj2jdOh8c+WRkNTWXT6iYk7JQsiBQie5lXgwD5cpf4JJYetMxEZDgUoNCvMAg"}},"unsigned":{"age_ts":1673456424779}}	3
$_k0ZpNW0oLpqiDqR7NJvZKdA2ZtHt_egRgLiFirmaYQ	!dKcbdDATuwwphjRPQP:localhost	{"txn_id":"m1673456424983.1","historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$PSZPiF2_GHeawUZsuFzgg_JuCtoOyaf_11-uLulGF0c","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$Q-2CPBoV3oTFZxGNkFMvNq26XugVjG2Cya0i5tuYeEg"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_b:localhost","content":{"msgtype":"m.file","body":"filename","url":"mxc://localhost/EkoNzWJIOlmjsKFCPAwGWxjd","info":{"mimetype":"","size":11}},"depth":33,"prev_state":[],"origin":"localhost","origin_server_ts":1673456425021,"hashes":{"sha256":"34uh02TY+17lwM4jakYcnimNWmxQp+3Dvq541XcWT1Y"},"signatures":{"localhost":{"ed25519:a_CHdg":"fC2L0Lbz0lvAaotP3qEEjs1Z6vzH+3BbowybAOOaNH05ircRPsImkHq+KFrQ06Hj6fSPI9C/VcHiY9EDRyRuDA"}},"unsigned":{"age_ts":1673456425021}}	3
$tWUlYx2qFNzpE_0CfMdKwbXSysRu-Z-uE0yWFp2GbGo	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":3,"txn_id":"m1673456425330.0","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$EpI_As8tc8wuYQzlSbGEsxAOAAjphf1Wn48-zC2Pj68"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.file","body":"mydata","url":"mxc://localhost/oJfyxvQeKlYvbgZBUnuypzXc","info":{"mimetype":"text/plain"}},"depth":40,"prev_state":[],"origin":"localhost","origin_server_ts":1673456425374,"hashes":{"sha256":"l/qqHvnJajNNNLMPNCFA8ZOJeGAQWCZyNcck1NNbc4w"},"signatures":{"localhost":{"ed25519:a_CHdg":"72FjzXdBtKdg+2mzba+eXx81LHyjad5d7e+MN5E0AKgCfjPV2yqCHYnluQrQvDi1l10JTO0nVbFAahAujzMeAQ"}},"unsigned":{"age_ts":1673456425374}}	3
$Ip6vtDe80sOxCWnWoPVYYN-aqQ4AdGR-zO_krrdduFg	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1673456425668.0","historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$_k0ZpNW0oLpqiDqR7NJvZKdA2ZtHt_egRgLiFirmaYQ"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"hidden message"},"depth":34,"prev_state":[],"origin":"localhost","origin_server_ts":1673456425739,"hashes":{"sha256":"5+7voqPoSF9uOHjgOav/o6IyxRHHi0G46kFWT0e+E1M"},"signatures":{"localhost":{"ed25519:a_CHdg":"mx0LWhiG3y3JWbgZ7cY3BvInPIL01w8e1HtrqtNx777X0sni4TsKFIrtydE6Cctri9mAJoRHaNiu5FZFmf+qAQ"}},"unsigned":{"age_ts":1673456425739}}	3
$9bNGuvT22oFV6Q8GFIzEZVofSbnyc61EIvnP8_3QqCE	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1673456445160.0","historical":false}	{"auth_events":["$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$tWUlYx2qFNzpE_0CfMdKwbXSysRu-Z-uE0yWFp2GbGo"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"test"},"depth":41,"prev_state":[],"origin":"localhost","origin_server_ts":1673456445206,"hashes":{"sha256":"d/IxT1Q3HTnf2sGc6AeN7Zoz4YsyW96juNRnnvquuIU"},"signatures":{"localhost":{"ed25519:a_CHdg":"vT8HxmNKZwkmQfTkKyM8AQNkuroJW8m1ZAfzaEo+HZiKt76+sR61aMao0ZVhwDWNqRBCSCmUMC5S9Pw5MH3LAA"}},"unsigned":{"age_ts":1673456445206}}	3
$_fc7lLRXoDsqiFKFvhlsSOsOE75ppMdi2ZRa-w_o0OY	!dKcbdDATuwwphjRPQP:localhost	{"token_id":4,"txn_id":"m1673456469214.0","historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$GgR_nTglOMJoS8SoJ-HFOS81y7cmJK64h0DeBVyFxkM"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_b:localhost","content":{"msgtype":"m.text","body":"> <@matrix_a> first matrix message\\n\\nsecond matrix message","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>second matrix message","m.relates_to":{"m.in_reply_to":{"event_id":"$GgR_nTglOMJoS8SoJ-HFOS81y7cmJK64h0DeBVyFxkM"}}},"depth":36,"prev_state":[],"origin":"localhost","origin_server_ts":1673456469260,"hashes":{"sha256":"GE/DMZ37b317H/Njz7yGiDZCQP1jxV6wryR31gJ0D4o"},"signatures":{"localhost":{"ed25519:a_CHdg":"1oAOcYY46izZOpdmQ91HCCl+w4bR43bmstqP3/7JbJaXHsN354rLF38/FRsXNZYS7M1nyHD1uLMGm/1qDiUBBA"}},"unsigned":{"age_ts":1673456469260}}	3
$oXdn9vR9Yxd3FXZOxnZLiW-XByipCOWC32N6UNC7fCI	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1673456469385.1","historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$_fc7lLRXoDsqiFKFvhlsSOsOE75ppMdi2ZRa-w_o0OY"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"> <@matrix_b> > <@matrix_a>\\n\\nthird matrix message","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>third matrix message","m.relates_to":{"m.in_reply_to":{"event_id":"$_fc7lLRXoDsqiFKFvhlsSOsOE75ppMdi2ZRa-w_o0OY"}}},"depth":37,"prev_state":[],"origin":"localhost","origin_server_ts":1673456469482,"hashes":{"sha256":"tPwRdLvRvz6Yy1pXfxh0n7fyKaK6jqp5znYV325mgRQ"},"signatures":{"localhost":{"ed25519:a_CHdg":"oUElIMnTL573VFhXlHwPpqOQTk+D+eC7OEwKgv4D/ljis6ZNkh2I9EzFSiqdlXJX9YElGQk00m11CR/H/JzbDQ"}},"unsigned":{"age_ts":1673456469482}}	3
$dbbS4HRWajCEFK63hUlDVeDwHbQPIAwiE7q2p34gr64	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":4,"txn_id":"m.1673458178295","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$1c97W6vcISTaUEtVZ3XtpTvdbUxTp84W9UUnJ7yQ1hI","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$7SK-_DIPq2s374RTSr3as9S8GNyjBCDXOXK_ycMXc74"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_b:localhost","content":{"body":"Strange message seen:\\nprogramming the port won't do anything, we need to reboot the 1080p GB microchip!\\n from Jerod_Green@hotmail.com","msgtype":"m.text"},"depth":69,"prev_state":[],"origin":"localhost","origin_server_ts":1673458178331,"hashes":{"sha256":"OdNv2Db8qUUpqDECBmShH8OCwhvsWr1kWm0tD06kKn8"},"signatures":{"localhost":{"ed25519:a_CHdg":"SLrFA5VAY+0GpZzS/VhllJHC0vSqDzUsqK3lhp1+UJfUCUriqIssfZTOWhOWhkxRAD0yvO9YYGnDa3cjsewSAQ"}},"unsigned":{"age_ts":1673458178331}}	3
$FhGz_XSQqkNt3u5faKV2p5k8gF47j_27y5RwVbtf3dk	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":3,"txn_id":"m1673456445488.0","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$9bNGuvT22oFV6Q8GFIzEZVofSbnyc61EIvnP8_3QqCE"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"test2"},"depth":42,"prev_state":[],"origin":"localhost","origin_server_ts":1673456445512,"hashes":{"sha256":"cRJrEJo423zxic710jz7pcdu36lssg5ppHU7J4dTY8Q"},"signatures":{"localhost":{"ed25519:a_CHdg":"n9g+haVjYBhDyQrzxTbfUmF7+8RDEWVibVw0SBTkFN1Q+AtIhjCnu0pZ6W+f3emjQHNPLP32ml1AGDFD8YzlCA"}},"unsigned":{"age_ts":1673456445512}}	3
$J2GCbFH7iG1fp5SNdsGmkmqFm59eqB_lJMGLY5yk1D8	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1673456445788.1","historical":false}	{"auth_events":["$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$FhGz_XSQqkNt3u5faKV2p5k8gF47j_27y5RwVbtf3dk"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"# Header\\n\\n**bold**","format":"org.matrix.custom.html","formatted_body":"<h1>Header</h1><strong>bold</strong>"},"depth":43,"prev_state":[],"origin":"localhost","origin_server_ts":1673456445810,"hashes":{"sha256":"cMz4a47HBxjNdJ/spKYIfn9oFVqtiaxJdtFCsGioxxs"},"signatures":{"localhost":{"ed25519:a_CHdg":"xjh0krxBXKbTk4e4LPAwFICJTc6tKY+TZok5Xp5ZmZ4H0T0kk/QY+DN/OEL/5yTaOamLEwWmRZGHKTurhnCvBw"}},"unsigned":{"age_ts":1673456445810}}	3
$Dtmij3Zgur83VAr9O_P7MPtbPgUoMnnz_pOwemaro9I	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":4,"txn_id":"m1673456446011.0","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$J2GCbFH7iG1fp5SNdsGmkmqFm59eqB_lJMGLY5yk1D8"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_b:localhost","content":{"msgtype":"m.text","body":"random wrong message","format":"org.matrix.custom.html","formatted_body":"<h1>Header</h1><b>Bolded text</b>"},"depth":44,"prev_state":[],"origin":"localhost","origin_server_ts":1673456446033,"hashes":{"sha256":"ELAKIMDY2F1EZeTRusEa+qBfhO+zM28avk8a+aNopog"},"signatures":{"localhost":{"ed25519:a_CHdg":"aQcWsoTBFU+CnuPQSASwnC99onCKPt25ST7USbmLPw6S9PtK6ZY5NpmxDyuDFHKPoz7Rsa0fUttfvo24GLKrAQ"}},"unsigned":{"age_ts":1673456446033}}	3
$Y0__yZ70xH8p15Jr_yTtOJmrMCpaSJLwSo2cc1W4F6o	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1673456468103.0","historical":false}	{"auth_events":["$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$Dtmij3Zgur83VAr9O_P7MPtbPgUoMnnz_pOwemaro9I"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"first mm message"},"depth":45,"prev_state":[],"origin":"localhost","origin_server_ts":1673456468128,"hashes":{"sha256":"EVB6W3X0irZ28S9jY4FgGKPeoxyg91iVQSy6jjxe9es"},"signatures":{"localhost":{"ed25519:a_CHdg":"Bvl8dIGtGgM4DF0CKYgmZz+xPkbsyY3QxzrQw2NrLyNvlJOTeSwEnaVW/tydnBUwsshsRWp+xLWsvO4muckDBw"}},"unsigned":{"age_ts":1673456468128}}	3
$gPWgeFNvAi1vMKPUzorqatfuOy4HXWKOwonBbcYhiN8	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1673456468699.0","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$t5n7gGV4l0pVzkJq8YJdQm4IFq3hTrEHABs9QiejsEA","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$Y0__yZ70xH8p15Jr_yTtOJmrMCpaSJLwSo2cc1W4F6o"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_b:localhost","content":{"msgtype":"m.text","body":"> <@mm_mattermost_a:localhost> first mm message\\n\\nsecond mm message","m.relates_to":{"m.in_reply_to":{"event_id":"$Y0__yZ70xH8p15Jr_yTtOJmrMCpaSJLwSo2cc1W4F6o"}},"formatted_body":"<mx-reply><blockquote><a href=\\"https://matrix.to/#/!kmbTYjjsDRDHGgVqUP:localhost/$Y0__yZ70xH8p15Jr_yTtOJmrMCpaSJLwSo2cc1W4F6o?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@mm_mattermost_a:localhost\\">@mm_mattermost_a:localhost</a><br>first mm message</blockquote></mx-reply>second mm message","format":"org.matrix.custom.html"},"depth":46,"prev_state":[],"origin":"localhost","origin_server_ts":1673456468733,"hashes":{"sha256":"BGn7lGLYp3wII40O7fQJCMFND8G4Se0ZQs3xGJWnIBY"},"signatures":{"localhost":{"ed25519:a_CHdg":"AROZlFbNlD6a/dk5ls1PdtFV8DdP1lbMAHdTkW24AiD4dCPpfgov95qYtEFJK2joVQnajiDua6t5q6If+Q9pAg"}},"unsigned":{"age_ts":1673456468733}}	3
$Bh8N0WeVWl8koOcEkS8E0m4kulvHaq75oA0ou0aE8qs	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1673456468885.1","historical":false}	{"auth_events":["$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$gPWgeFNvAi1vMKPUzorqatfuOy4HXWKOwonBbcYhiN8"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"> <@mm_mattermost_b:localhost> > <@mm_mattermost_a:localhost>\\n\\nthird mm message","m.relates_to":{"m.in_reply_to":{"event_id":"$gPWgeFNvAi1vMKPUzorqatfuOy4HXWKOwonBbcYhiN8"}},"formatted_body":"<mx-reply><blockquote><a href=\\"https://matrix.to/#/!kmbTYjjsDRDHGgVqUP:localhost/$gPWgeFNvAi1vMKPUzorqatfuOy4HXWKOwonBbcYhiN8?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@mm_mattermost_b:localhost\\">@mm_mattermost_b:localhost</a><br><mx-reply><blockquote><a href=\\"https://matrix.to/#/!kmbTYjjsDRDHGgVqUP:localhost/$Y0__yZ70xH8p15Jr_yTtOJmrMCpaSJLwSo2cc1W4F6o?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@mm_mattermost_a:localhost\\">@mm_mattermost_a:localhost</a><br>first mm message</blockquote></mx-reply>second mm message</blockquote></mx-reply>third mm message","format":"org.matrix.custom.html"},"depth":47,"prev_state":[],"origin":"localhost","origin_server_ts":1673456468901,"hashes":{"sha256":"PeTL1Ezsb1lnLkFqkC0MOomrtvX1INfC+cfjfmehkGs"},"signatures":{"localhost":{"ed25519:a_CHdg":"/VX5XfFQyaycZHnh5tiD03CE0GWS1IGA0Dfy8oOk9VZtUyvQRFBL7WnKwuzLHNIKgMNEqz7zN/I3M66DwKSUDA"}},"unsigned":{"age_ts":1673456468901}}	3
$GgR_nTglOMJoS8SoJ-HFOS81y7cmJK64h0DeBVyFxkM	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1673456469128.0","historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$Ip6vtDe80sOxCWnWoPVYYN-aqQ4AdGR-zO_krrdduFg"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"first matrix message"},"depth":35,"prev_state":[],"origin":"localhost","origin_server_ts":1673456469150,"hashes":{"sha256":"FQsAIsX46uX52ScE6vLO9D9gtMnwa0tu+n51CS3jO8g"},"signatures":{"localhost":{"ed25519:a_CHdg":"PbtNTOgJF+Dj8sGTVK4qVzQP8zjQ3cis5SPghKYVzqS9m3fI1QJpN1j3TW15c+3IDqJiGM3bluKDsy5Lr3sbBg"}},"unsigned":{"age_ts":1673456469150}}	3
$sDESXFNHywZLVAjOAvBW4Qtv660_Xx9oVSAIUzZs5bA	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1673456469822.2","historical":false}	{"auth_events":["$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$Bh8N0WeVWl8koOcEkS8E0m4kulvHaq75oA0ou0aE8qs"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"first message"},"depth":48,"prev_state":[],"origin":"localhost","origin_server_ts":1673456469844,"hashes":{"sha256":"Hl3qnKe+vmXzFZ6lYfq3Qsa4L3bXUdGFGmLvNs3/PL4"},"signatures":{"localhost":{"ed25519:a_CHdg":"LkLz4qvHPQEAct3Iv8Gx8B9RYMf6qfl0oApRbR+4dmPWHsaXouJBPrre9LrM4DRPGJ11bEMnuniDz4z2yMSPCA"}},"unsigned":{"age_ts":1673456469844}}	3
$Hlu0oKcyD432dWmJ9w0xHm3PLMnH85Jn-X3GDTYuVV4	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1673456470412.3","historical":false}	{"auth_events":["$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$jnaBiJUcEka0drCdQFKBUWluWZq5S7dPNR3XCnWwx8g"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"> <@matrix_b:localhost> whatever\\n\\nthird message","m.relates_to":{"m.in_reply_to":{"event_id":"$jnaBiJUcEka0drCdQFKBUWluWZq5S7dPNR3XCnWwx8g"}},"formatted_body":"<mx-reply><blockquote><a href=\\"https://matrix.to/#/!kmbTYjjsDRDHGgVqUP:localhost/$jnaBiJUcEka0drCdQFKBUWluWZq5S7dPNR3XCnWwx8g?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@matrix_b:localhost\\">@matrix_b:localhost</a><br><mx-reply>Dummy content</mx-reply>second message</blockquote></mx-reply>third message","format":"org.matrix.custom.html"},"depth":50,"prev_state":[],"origin":"localhost","origin_server_ts":1673456470431,"hashes":{"sha256":"0rQGu9JCyWfJ9ubpqzTcq7gCwYdTB/4/KX3Xee9QO2c"},"signatures":{"localhost":{"ed25519:a_CHdg":"3h55rgixTt4799j6YjWnz69cMMZ9N89CC+q/DBq39ATjMtP3IRvBjxBAPXd3ui3DCE0LuA1set0hKuB/0yLmAw"}},"unsigned":{"age_ts":1673456470431}}	3
$CGChqoz8kvvahzTLr-uENaReKyq5KpqLrL1g9bePx2I	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1673456471128.3","historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$vQGo7i4QMQ-SSBxBmQa7vPtet-fqNIosOIQOhXXoLwc"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"> <@matrix_a> reply message\\n\\nlast message","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>last message","m.relates_to":{"m.in_reply_to":{"event_id":"$eY_eQCpyM7JAv11-157xBIO8c02XOKPAKO5-oLLkaMM"}}},"depth":41,"prev_state":[],"origin":"localhost","origin_server_ts":1673456471204,"hashes":{"sha256":"8pdGMMmN7fdNJCeqDe1Io3AvimfUxmxDJahuJMQmduA"},"signatures":{"localhost":{"ed25519:a_CHdg":"5P0k0LsxVnJ7/WQMXRjYZsokBFrtoq+eH/QoTuhcn41W0Izrf7CONtnPaLt1qTeqZy4Gvp7/5CWK9a6RAwwjCg"}},"unsigned":{"age_ts":1673456471204}}	3
$UHKKJIW-yVrjog2Pg_MR43oEkfSUhSVKiFGHGPbNaOU	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1673456484446.0","historical":false}	{"auth_events":["$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$m8qqKQF7tvdc1qLDrWf1DjyHng9_F2Y0v_gzFRh6Kag"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"mm to delete"},"depth":52,"prev_state":[],"origin":"localhost","origin_server_ts":1673456484479,"hashes":{"sha256":"qpUfYY/OLBWQeAc4sJjJrzPnSaJhi5Qoq60ALtltrkU"},"signatures":{"localhost":{"ed25519:a_CHdg":"o7DaC8rwOUeQl7z+nX5BCTqEC+rfIaulhwXzEjMyN19hYVTXNGqSUay6huPT3tcTujqxtseDywc4T4A5MVcTCQ"}},"unsigned":{"age_ts":1673456484479}}	3
$_64yupcz2_qLrKOWrT87_V-HWN64bsQaq1VhCZ_zRnE	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1673456484762.0","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$666ybhBdzZc96KCxYMslNrmlLRi8w6uUusi8J4BUVNM","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$UHKKJIW-yVrjog2Pg_MR43oEkfSUhSVKiFGHGPbNaOU"],"type":"m.room.redaction","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{},"depth":53,"prev_state":[],"redacts":"$UHKKJIW-yVrjog2Pg_MR43oEkfSUhSVKiFGHGPbNaOU","origin":"localhost","origin_server_ts":1673456484815,"hashes":{"sha256":"UVi/Lsy5aA3yxeck+rA3T0k6IH8UXqLhjBe7oMgECIY"},"signatures":{"localhost":{"ed25519:a_CHdg":"aEe86nvHAl3B0ZBnL0wlGuM2sYffp4bpWloIo1GcQG3zW8eF2rHOqQaBg0ylMDXPU27e6I3ozbz8hOIPocmNCg"}},"unsigned":{"age_ts":1673456484815}}	3
$XMPmaEvrP8Ebnl1P6-T-4JWR8Ms1HgLkboYib2Z0LAI	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$KjxZjGyxoIyEvF0d6WjubIy5-PjQ8gTixRenqiw88iA","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$KjxZjGyxoIyEvF0d6WjubIy5-PjQ8gTixRenqiw88iA"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_b:localhost","content":{"membership":"join","displayname":"mattermost_b [mm]"},"depth":60,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1673456497755,"hashes":{"sha256":"ae5v4CtxY4uSXQ++oibyXaMRzgO8rU0UkveQh34RTgw"},"signatures":{"localhost":{"ed25519:a_CHdg":"DzuiBY0BMfgAo8gW3Cx3RepGslrZ44uxVmjZ76PDsS+By0ue8y8M8Vz64nIdEw8vGx+ywc/ywosVU6DNKWU5Ag"}},"unsigned":{"age_ts":1673456497755,"replaces_state":"$KjxZjGyxoIyEvF0d6WjubIy5-PjQ8gTixRenqiw88iA"}}	3
$8Lzt8KQPe0wAkuTOKq6BkdBqXu9LrnnsSyeYQ70hPDs	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":4,"historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$XMPmaEvrP8Ebnl1P6-T-4JWR8Ms1HgLkboYib2Z0LAI"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_b:localhost","content":{"membership":"join","displayname":"Hello World"},"depth":61,"prev_state":[],"state_key":"@matrix_b:localhost","origin":"localhost","origin_server_ts":1673456498102,"hashes":{"sha256":"uuAqZQTDqm1GFcwtf4IX4dWoyv0fIqb05VUUknSkh5g"},"signatures":{"localhost":{"ed25519:a_CHdg":"300+AQcpovDl6adOSs1FBl27k1TtT87j8VrD42Qy4aV/wdPNrXl41h0AebhJVbCxBBdHipk2foGQh/0Ob5wOBw"}},"unsigned":{"age_ts":1673456498102,"replaces_state":"$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk"}}	3
$7SK-_DIPq2s374RTSr3as9S8GNyjBCDXOXK_ycMXc74	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":3,"txn_id":"m1673457542360.0","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$VcoB1_pk9tOinsmwdQJYShtIuSLosTj-jzPHDVJjEv8"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.file","body":"mydata","url":"mxc://localhost/subBjguJAvrMNdPHjdiMQXfT","info":{"mimetype":"text/plain"}},"depth":68,"prev_state":[],"origin":"localhost","origin_server_ts":1673457542559,"hashes":{"sha256":"aYxpEyqKo9bRD16BVdR8seA4pK7FhaNomPHCOdWSCgA"},"signatures":{"localhost":{"ed25519:a_CHdg":"t990LvIkBGz8NsMcgjZwV07LhoVz+NXDCaLa7FYWlQgddw5PkTFoleegwgGZK57mep2bQK76wCaVqNnnEZnXBw"}},"unsigned":{"age_ts":1673457542559}}	3
$jnaBiJUcEka0drCdQFKBUWluWZq5S7dPNR3XCnWwx8g	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":4,"txn_id":"m1673456470079.0","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$sDESXFNHywZLVAjOAvBW4Qtv660_Xx9oVSAIUzZs5bA"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_b:localhost","content":{"msgtype":"m.text","body":"whatever","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>second message","m.relates_to":{"m.in_reply_to":{"event_id":"$sDESXFNHywZLVAjOAvBW4Qtv660_Xx9oVSAIUzZs5bA"}}},"depth":49,"prev_state":[],"origin":"localhost","origin_server_ts":1673456470100,"hashes":{"sha256":"1710lcB7qeky+KPlyVck5w5mwjAtJeQcusujujdSCTQ"},"signatures":{"localhost":{"ed25519:a_CHdg":"YlTVrmKwa2BH+49HDYf5ConMwbDlGw3ktAUZ703d4w0lRX5UfRAgXUfVvSOm+MFOvabonM+KtObFvn9RMBveAw"}},"unsigned":{"age_ts":1673456470100}}	3
$krZXlGfGshKwkFJk6XwnR-gCOaeiC5p1Z6YZwNw6Tg0	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1673456470661.0","historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$oXdn9vR9Yxd3FXZOxnZLiW-XByipCOWC32N6UNC7fCI"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"root message"},"depth":38,"prev_state":[],"origin":"localhost","origin_server_ts":1673456470681,"hashes":{"sha256":"3YRYeTKyDgRh2XMHt4fftI/yF/lpQVICx0ZByCi6Y0o"},"signatures":{"localhost":{"ed25519:a_CHdg":"ON9h4fdpI+cw4J7RW0kuEdl5meOcW5uVNvQ4+yE0vrg+wzObfdiTBpTL+p8vOyz4lpP/S2a/tYUlaNl6PafQAA"}},"unsigned":{"age_ts":1673456470681}}	3
$eY_eQCpyM7JAv11-157xBIO8c02XOKPAKO5-oLLkaMM	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1673456470750.1","historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$krZXlGfGshKwkFJk6XwnR-gCOaeiC5p1Z6YZwNw6Tg0"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"> <@matrix_a> root message\\n\\nreply message","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>reply message","m.relates_to":{"m.in_reply_to":{"event_id":"$krZXlGfGshKwkFJk6XwnR-gCOaeiC5p1Z6YZwNw6Tg0"}}},"depth":39,"prev_state":[],"origin":"localhost","origin_server_ts":1673456470815,"hashes":{"sha256":"UnM6yYI58LgRnNzJjwz5n7bdQThLzr9X6AMQTn0kc4M"},"signatures":{"localhost":{"ed25519:a_CHdg":"uniqU2K2JUrFFcPtzSsLVvQ64/ScfzSDVpXjogAeafrpkwMq/sMlvh8Fszm4hpFsrDNTHhj93kwkhr2YZAx4AA"}},"unsigned":{"age_ts":1673456470815}}	3
$vQGo7i4QMQ-SSBxBmQa7vPtet-fqNIosOIQOhXXoLwc	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1673456470912.2","historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$eY_eQCpyM7JAv11-157xBIO8c02XOKPAKO5-oLLkaMM"],"type":"m.room.redaction","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{},"depth":40,"prev_state":[],"redacts":"$krZXlGfGshKwkFJk6XwnR-gCOaeiC5p1Z6YZwNw6Tg0","origin":"localhost","origin_server_ts":1673456470956,"hashes":{"sha256":"EV2BLBd3O7XHtZOZBPQiIOQv+a+rN3+rasx3PGo4rtc"},"signatures":{"localhost":{"ed25519:a_CHdg":"s9cFggvbJDnazkpny1vo4Ydhi3G9UCnQ4EKWn1EbxNZB+Fy/dT/81CRnyjCU72PqgPVpjpaeUKcaIbFblHMJAA"}},"unsigned":{"age_ts":1673456470956}}	3
$m8qqKQF7tvdc1qLDrWf1DjyHng9_F2Y0v_gzFRh6Kag	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1673456473447.0","historical":false}	{"auth_events":["$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$Hlu0oKcyD432dWmJ9w0xHm3PLMnH85Jn-X3GDTYuVV4"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"new message"},"depth":51,"prev_state":[],"origin":"localhost","origin_server_ts":1673456473466,"hashes":{"sha256":"/KFZsvOSXhi+4ji+9s0+TNDKRtLbzHNxovW3wgWJ0eg"},"signatures":{"localhost":{"ed25519:a_CHdg":"WZphg5DDZod7sD7PN1iEN42TtfAowY9UqDODhAA7lNYIQpYu8xwP0bdje3B3L0olJcTQMiFesNGQmajZsZ3dCQ"}},"unsigned":{"age_ts":1673456473466}}	3
$Yis1BltcsgIBI_y81aVbrWa5qBJs3O4cjY7TtOnv3AU	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1673456485017.0","historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$CGChqoz8kvvahzTLr-uENaReKyq5KpqLrL1g9bePx2I"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"matrix to delete"},"depth":42,"prev_state":[],"origin":"localhost","origin_server_ts":1673456485049,"hashes":{"sha256":"NLlX4YOEy8Kx+e3tilpCntISA7DW5Qw6XtowCpPrpkw"},"signatures":{"localhost":{"ed25519:a_CHdg":"svzVmVvQT6xvUNwwpqsxOo5mxSsjrQM3mVBsDpQLBfWR3AlTKwmczLAyH7p7uq5/1HJvLhxwRypJibxFiIokDQ"}},"unsigned":{"age_ts":1673456485049}}	3
$zUomLm3mThwuYeUXH2UXzsuqxE6DQeH_95sT95psJag	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$Op0TBQz5bRKUyxhUgvd0RMEbDt0BloR6y_aUatQJcO4","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$Op0TBQz5bRKUyxhUgvd0RMEbDt0BloR6y_aUatQJcO4"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_b:localhost","content":{"membership":"join","displayname":"mattermost_b [mm]"},"depth":45,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1673456497621,"hashes":{"sha256":"Y1iKQr1OiiNvlxb4secEdQFn2E022igE2w0fzdsZsJ8"},"signatures":{"localhost":{"ed25519:a_CHdg":"/QMTVPCRoL+kGikIvx+3FWxImRN/VPrrVviI1weS1UaQkEH7QiNi8vuLtlgwLgb+24MRptXA+O4aHOOyuOQ0CA"}},"unsigned":{"age_ts":1673456497621,"replaces_state":"$Op0TBQz5bRKUyxhUgvd0RMEbDt0BloR6y_aUatQJcO4"}}	3
$sKC-AGmNhmjm9fAYYksybJgXr_tCsBeZrEAv6k7VTyk	!dKcbdDATuwwphjRPQP:localhost	{"token_id":4,"historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$zUomLm3mThwuYeUXH2UXzsuqxE6DQeH_95sT95psJag"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_b:localhost","content":{"membership":"join","displayname":"Hello World"},"depth":46,"prev_state":[],"state_key":"@matrix_b:localhost","origin":"localhost","origin_server_ts":1673456497972,"hashes":{"sha256":"IdeceYJsWLZNIGnkD4tfLm1dTE5husMwAPoE0N9LZQE"},"signatures":{"localhost":{"ed25519:a_CHdg":"p0GhumRLbdjsPyGnQK89etTskS3mEaX3QbSH1uM/BmmjeSOfLOa3KkN68guqYFwHnPPtCLOCXeBxgp4nmwBcAw"}},"unsigned":{"age_ts":1673456497972,"replaces_state":"$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0"}}	3
$3tVAg8SuDfjs9Fgkhfie7XW_PKyBUpsFLrnHYwASpBc	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1673456485214.1","historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$Yis1BltcsgIBI_y81aVbrWa5qBJs3O4cjY7TtOnv3AU"],"type":"m.room.redaction","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{},"depth":43,"prev_state":[],"redacts":"$Yis1BltcsgIBI_y81aVbrWa5qBJs3O4cjY7TtOnv3AU","origin":"localhost","origin_server_ts":1673456485255,"hashes":{"sha256":"LKhw7OzYpJrM3EZg9jnR2PUYeOHggfVqs4W93hq5faQ"},"signatures":{"localhost":{"ed25519:a_CHdg":"eNx022ICGg33R0xiwuI+cG7Cfh4zWCZXPi1j5xJkgnTC3En+AtZn0rXrIAWuQo5mpZTKYH8Oc0KE+jFEw31IAw"}},"unsigned":{"age_ts":1673456485255}}	3
$ABAs5n2LLFjtJj9U8vpXJZW4XssE1_1AOKq1Hht9rAc	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1673456485486.1","historical":false}	{"auth_events":["$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$_64yupcz2_qLrKOWrT87_V-HWN64bsQaq1VhCZ_zRnE"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"pre-thread message"},"depth":54,"prev_state":[],"origin":"localhost","origin_server_ts":1673456485528,"hashes":{"sha256":"gGSha3J3qotVVDUyqcl7ouv+ucAAjB+Z8fEQND9jTTE"},"signatures":{"localhost":{"ed25519:a_CHdg":"CTeHcOjC+CioveLG3AfxtZI4TcWbQJ7UMVHSFztYWbo8J4MaqOp6gPxws3hLrCXIZHdpgo1BZaUaaDP7zlw2Dg"}},"unsigned":{"age_ts":1673456485528}}	3
$XhY61XTnLilEWT5TBmpjFvWg-ttI3HSyLVoLRUVNShI	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1673456485669.2","historical":false}	{"auth_events":["$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$ABAs5n2LLFjtJj9U8vpXJZW4XssE1_1AOKq1Hht9rAc"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"first message"},"depth":55,"prev_state":[],"origin":"localhost","origin_server_ts":1673456485756,"hashes":{"sha256":"o2KKTTlVnOjCZ5Xj4s5GPVY4/rXpCU95CB9CTWRbNYc"},"signatures":{"localhost":{"ed25519:a_CHdg":"Aii/61WYPrt+WbLG6fmdanKkouMXzEcvt3kPAwwb8s8/NNXzLy60WAh39Ze166H0BfkHKYyNb0FikuXGZL/UCQ"}},"unsigned":{"age_ts":1673456485756}}	3
$efNJ2_fNXgtmBlwuX0QfDBZLeNBnkF0bix0VF0AaBUc	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1673456485982.3","historical":false}	{"auth_events":["$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$XhY61XTnLilEWT5TBmpjFvWg-ttI3HSyLVoLRUVNShI"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"> <@mm_mattermost_a:localhost> first message\\n\\nsecond message","m.relates_to":{"m.in_reply_to":{"event_id":"$XhY61XTnLilEWT5TBmpjFvWg-ttI3HSyLVoLRUVNShI"}},"formatted_body":"<mx-reply><blockquote><a href=\\"https://matrix.to/#/!kmbTYjjsDRDHGgVqUP:localhost/$XhY61XTnLilEWT5TBmpjFvWg-ttI3HSyLVoLRUVNShI?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@mm_mattermost_a:localhost\\">@mm_mattermost_a:localhost</a><br>first message</blockquote></mx-reply>second message","format":"org.matrix.custom.html"},"depth":56,"prev_state":[],"origin":"localhost","origin_server_ts":1673456486014,"hashes":{"sha256":"MX+emBaArIBsdnVquWATzuYSfsV5IIzSk3l6XytikqE"},"signatures":{"localhost":{"ed25519:a_CHdg":"QIMzLHNdfvZuVu8eWimR8rFkBx4UbD6vQd2wMh2Zp76uIWTJFbNJtCnOtAhpEmD3rC/Fl+aR7hTN1vWmlhHGDg"}},"unsigned":{"age_ts":1673456486014}}	3
$Rx9kQ8hCx2y1bcLpdhzPqXHkrlExdX1yc3YshWnC6og	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1673456486335.1","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$666ybhBdzZc96KCxYMslNrmlLRi8w6uUusi8J4BUVNM","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$efNJ2_fNXgtmBlwuX0QfDBZLeNBnkF0bix0VF0AaBUc"],"type":"m.room.redaction","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{},"depth":57,"prev_state":[],"redacts":"$XhY61XTnLilEWT5TBmpjFvWg-ttI3HSyLVoLRUVNShI","origin":"localhost","origin_server_ts":1673456486424,"hashes":{"sha256":"UVDNPSy/4b6QV8WSvBZesMeIM2tkaoQSd2/rp3p7GYg"},"signatures":{"localhost":{"ed25519:a_CHdg":"XyRJwCiua/SXrks8aHOmbv9ixUCXuRzN0YayQHNhM1iXfC7Mo+PYlExTUCI0G6uX5X7fMdmZrKMtf7K3RbIRDA"}},"unsigned":{"age_ts":1673456486424}}	3
$hz_8OnlfAO5weTQ3Sy0cNJ83PP6UGxmBomiBKe4JB5w	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1673456486335.2","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$666ybhBdzZc96KCxYMslNrmlLRi8w6uUusi8J4BUVNM","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$Rx9kQ8hCx2y1bcLpdhzPqXHkrlExdX1yc3YshWnC6og"],"type":"m.room.redaction","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{},"depth":58,"prev_state":[],"redacts":"$efNJ2_fNXgtmBlwuX0QfDBZLeNBnkF0bix0VF0AaBUc","origin":"localhost","origin_server_ts":1673456486509,"hashes":{"sha256":"3eKIU3fvbc+56cwv+LwZnnJmqOuCJCpWdFw351ZIPHU"},"signatures":{"localhost":{"ed25519:a_CHdg":"Rf5JKe1eUgLow+x5obKgBC5JcnMyhV8QYc4Xdw957MPxH83uh8nvrdB4gjgUPYtjYqrnIBUobTRw+j2i4KCrAQ"}},"unsigned":{"age_ts":1673456486509}}	3
$Op0TBQz5bRKUyxhUgvd0RMEbDt0BloR6y_aUatQJcO4	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$PSZPiF2_GHeawUZsuFzgg_JuCtoOyaf_11-uLulGF0c","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$3tVAg8SuDfjs9Fgkhfie7XW_PKyBUpsFLrnHYwASpBc"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_b:localhost","content":{"membership":"join","displayname":"MMTest Last [mm]"},"depth":44,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1673456497209,"hashes":{"sha256":"7DvFYYmq61JwS/WBYBmjdDGkIKuwRHVXPiqObcNpytQ"},"signatures":{"localhost":{"ed25519:a_CHdg":"TChKIGgW7UiOUeBTp4TBwWWXqihQ/MVOIV16CIEFAhoWzD9HAdynQyLmfQqmIhPd08yf3dNRntT0vZjKYbQjAg"}},"unsigned":{"age_ts":1673456497209,"replaces_state":"$PSZPiF2_GHeawUZsuFzgg_JuCtoOyaf_11-uLulGF0c"}}	3
$KjxZjGyxoIyEvF0d6WjubIy5-PjQ8gTixRenqiw88iA	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$t5n7gGV4l0pVzkJq8YJdQm4IFq3hTrEHABs9QiejsEA","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$hz_8OnlfAO5weTQ3Sy0cNJ83PP6UGxmBomiBKe4JB5w"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_b:localhost","content":{"membership":"join","displayname":"MMTest Last [mm]"},"depth":59,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1673456497350,"hashes":{"sha256":"1vS2A2IgUGADwgi5Fs3dHVzIxG6GCvZ7OHbAFl3NmWk"},"signatures":{"localhost":{"ed25519:a_CHdg":"4Ghr4wsh97LMUEwzlzMRPO9C7dJOjoLzXDGSfzKWPrzX2HvDHBXCBu/q7NcWnbU3O59c2nV98jhntUmwfndoAg"}},"unsigned":{"age_ts":1673456497350,"replaces_state":"$t5n7gGV4l0pVzkJq8YJdQm4IFq3hTrEHABs9QiejsEA"}}	3
$9i3p0sl8iw-4rVjwMHJnTFujme1in4rnO1zkP9hPq8w	!dKcbdDATuwwphjRPQP:localhost	{"token_id":4,"historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$sKC-AGmNhmjm9fAYYksybJgXr_tCsBeZrEAv6k7VTyk","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$sKC-AGmNhmjm9fAYYksybJgXr_tCsBeZrEAv6k7VTyk"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_b:localhost","content":{"membership":"join"},"depth":47,"prev_state":[],"state_key":"@matrix_b:localhost","origin":"localhost","origin_server_ts":1673456498429,"hashes":{"sha256":"3GTlllXy3IDM1onqo9RhcKzqFgJbzzV5ukcDKLTya/o"},"signatures":{"localhost":{"ed25519:a_CHdg":"+n20dBy07kk3ivqQwxfHxBpkFC+pqO5bCnd0nTNJ3FwWB7txD0U8fFZpebOkPq+AMPJmefHLyFicjqtYk/WFCA"}},"unsigned":{"age_ts":1673456498429,"replaces_state":"$sKC-AGmNhmjm9fAYYksybJgXr_tCsBeZrEAv6k7VTyk"}}	3
$dyDBJ0bfzPuc6VwuCR3A1Q2GNqb5JweFoRuLiNBdLgg	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":3,"txn_id":"m1673456843160.0","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$u2wX-H57z6LJIi2iBRq8--9YEHZj924d1XHR1tbNoTU"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"test2"},"depth":64,"prev_state":[],"origin":"localhost","origin_server_ts":1673456843196,"hashes":{"sha256":"YN1/yz/iWE385cgqY08IU7I9vUaxp4kwx52XBjStmFs"},"signatures":{"localhost":{"ed25519:a_CHdg":"9BlUzZOBbXG9ocmG+dJxMrYCQ8d++wqVvjhfKfzkBuxp1JPHPqOCBSrzitHS/QEQdJPAKPT8RsyoUbpwZ1PqCw"}},"unsigned":{"age_ts":1673456843196}}	3
$1c97W6vcISTaUEtVZ3XtpTvdbUxTp84W9UUnJ7yQ1hI	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":4,"historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$8Lzt8KQPe0wAkuTOKq6BkdBqXu9LrnnsSyeYQ70hPDs","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$8Lzt8KQPe0wAkuTOKq6BkdBqXu9LrnnsSyeYQ70hPDs"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_b:localhost","content":{"membership":"join"},"depth":62,"prev_state":[],"state_key":"@matrix_b:localhost","origin":"localhost","origin_server_ts":1673456498578,"hashes":{"sha256":"E4iHFbNN7YNuytrSk4gY7r6QnfoKTcwQ249Umo2Lvr4"},"signatures":{"localhost":{"ed25519:a_CHdg":"g781QBPYRv02PexxFI0aLL1TV9D5aFfrnM47464LLIuVaSkjvAILbQIQjHXT4ybGX1gqdUprMyT97tQBm0LDDg"}},"unsigned":{"age_ts":1673456498578,"replaces_state":"$8Lzt8KQPe0wAkuTOKq6BkdBqXu9LrnnsSyeYQ70hPDs"}}	3
$u2wX-H57z6LJIi2iBRq8--9YEHZj924d1XHR1tbNoTU	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1673456842837.0","historical":false}	{"auth_events":["$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$1c97W6vcISTaUEtVZ3XtpTvdbUxTp84W9UUnJ7yQ1hI"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"test"},"depth":63,"prev_state":[],"origin":"localhost","origin_server_ts":1673456842880,"hashes":{"sha256":"UKC3fQnDK0EIJ8Saw8jnoOk26Rgy3wYKL9hy17ogeqY"},"signatures":{"localhost":{"ed25519:a_CHdg":"6IeMsR92EqNnhu+riQEkdACwk/QdaQwci8Y3Z4j8TbCWDVZqXi4/YUgGsjlC8LSkvjUUvZQA9MJYT2XzZPvFAg"}},"unsigned":{"age_ts":1673456842880}}	3
$HtuzOrzcCN4JBQCmC2S0KmN-Sq3OXYHy41_xxL3VNE4	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1673456843497.1","historical":false}	{"auth_events":["$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$dyDBJ0bfzPuc6VwuCR3A1Q2GNqb5JweFoRuLiNBdLgg"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"# Header\\n\\n**bold**","format":"org.matrix.custom.html","formatted_body":"<h1>Header</h1><strong>bold</strong>"},"depth":65,"prev_state":[],"origin":"localhost","origin_server_ts":1673456843570,"hashes":{"sha256":"WPngx2Jn5gJPM/JetQPlcqI+kEXxB8pIGICyLYKE5sY"},"signatures":{"localhost":{"ed25519:a_CHdg":"KGOMaB7M2d72pNpTkmIvXD4xR1OlStj/mgjhQwHrRL2cLjDBk1ibwW37iqviudwFdnSL3qAZw2/kVyoBWoj5AQ"}},"unsigned":{"age_ts":1673456843570}}	3
$GoX13j6N-LFoVwqTvDVdFkmlAMyOQncU-wyYccvSOnE	!dKcbdDATuwwphjRPQP:localhost	{"txn_id":"m1673457534616.2","historical":false}	{"auth_events":["$CPrx1EOiKU0xFQBY1-CbMIp4Nx64vw33awql9URc-is","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$9i3p0sl8iw-4rVjwMHJnTFujme1in4rnO1zkP9hPq8w"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"Natus magnam a. Omnis neque facilis voluptatibus nobis. Sit voluptatem veritatis ad natus adipisci ut iusto occaecati. Omnis iure vitae unde ut totam deleniti blanditiis ab. Officiis voluptatem vero vero optio consequatur sapiente."},"depth":48,"prev_state":[],"origin":"localhost","origin_server_ts":1673457534765,"hashes":{"sha256":"BrbrhtWj63OCc5T04RYnHPgodxeECzNRZW16fy7VvD8"},"signatures":{"localhost":{"ed25519:a_CHdg":"DFWeTDRXMy4k8FE09ojuMF1aPuDLj3H8iKljAeUhQjaKv5v2vqVloG+Ndhv2jx842bkVNNH4oEtkA2aDyhOfCw"}},"unsigned":{"age_ts":1673457534765}}	3
$njvVCKYhRssX__fnFZ8owlNsOC9u3FRj0pmcqeIVVjI	!dKcbdDATuwwphjRPQP:localhost	{"txn_id":"m1673457540642.1","historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$zUomLm3mThwuYeUXH2UXzsuqxE6DQeH_95sT95psJag","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$ORHWJnv40jDzKKISq_X3_aBTGHZZJqjFEVg1kUnrWQ4"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_b:localhost","content":{"msgtype":"m.file","body":"filename","url":"mxc://localhost/uYoKGLTJtbUlbloZKqxWZTvr","info":{"mimetype":"","size":11}},"depth":50,"prev_state":[],"origin":"localhost","origin_server_ts":1673457540893,"hashes":{"sha256":"24cB5dlwSW6lG+3FJAIuXU8pFpy2VCqAVk3JJpfHwHY"},"signatures":{"localhost":{"ed25519:a_CHdg":"x5mnmEa8nueS3h1FMY2QwZLjvm0TMrQC0DKhtZCks9+n1JeIP4JIPPX0q5yZhlmFNCsWLcRYT+binloY8L6ABA"}},"unsigned":{"age_ts":1673457540893}}	3
$uwxaXiusawT_bOeyGHwB7wfy4YVDUUpEs6A4YMBKfTg	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":4,"txn_id":"m1673456843807.0","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$1c97W6vcISTaUEtVZ3XtpTvdbUxTp84W9UUnJ7yQ1hI","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$HtuzOrzcCN4JBQCmC2S0KmN-Sq3OXYHy41_xxL3VNE4"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_b:localhost","content":{"msgtype":"m.text","body":"random wrong message","format":"org.matrix.custom.html","formatted_body":"<h1>Header</h1><b>Bolded text</b>"},"depth":66,"prev_state":[],"origin":"localhost","origin_server_ts":1673456843841,"hashes":{"sha256":"44k7VhWAXMgcMdZ+vQUIeGemGxp95XyTBItb858qX5Q"},"signatures":{"localhost":{"ed25519:a_CHdg":"fMNg4a1quV1sPQs+2fCPB8OV/VWWTS38IWv4rrFHHYiG5OznH9Rh85cjCIRTUBSesua/k+VS0NoanDGOvnOwCQ"}},"unsigned":{"age_ts":1673456843841}}	3
$VcoB1_pk9tOinsmwdQJYShtIuSLosTj-jzPHDVJjEv8	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":3,"txn_id":"m1673457537092.0","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$uwxaXiusawT_bOeyGHwB7wfy4YVDUUpEs6A4YMBKfTg"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.emote","body":"test"},"depth":67,"prev_state":[],"origin":"localhost","origin_server_ts":1673457537295,"hashes":{"sha256":"t4Ge7E6h2nwRrirGWpy314AFlfoDPNrtBrFktBPiduo"},"signatures":{"localhost":{"ed25519:a_CHdg":"RJZz2M/cAS92y7e6IEgqIooKJyez4zBdRsN10xBsX/V4PpzyFdnqyk7lSmgng4Pbgic7/sYiUwFX3vdzaCbfBg"}},"unsigned":{"age_ts":1673457537295}}	3
$0DBuAxDOgwokpytW0JkbbD3h3YNz3tiYsyJNZZqT6dM	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1673457544547.0","historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$njvVCKYhRssX__fnFZ8owlNsOC9u3FRj0pmcqeIVVjI"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"hidden message"},"depth":51,"prev_state":[],"origin":"localhost","origin_server_ts":1673457544763,"hashes":{"sha256":"t/wLikF6f/j1k/puDhsa5F3TVyikWCjrIEnsJWZfrzI"},"signatures":{"localhost":{"ed25519:a_CHdg":"vMMZpnHzaG47MRdHf3kR+s6Y60UmerxSoKLOGt3lm2tgmDQ7pLjTUbg9hMtVpupJIhYkoVwuB8q0hu6/5kXkDA"}},"unsigned":{"age_ts":1673457544763}}	3
$ORHWJnv40jDzKKISq_X3_aBTGHZZJqjFEVg1kUnrWQ4	!dKcbdDATuwwphjRPQP:localhost	{"txn_id":"m1673457539412.0","historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$zUomLm3mThwuYeUXH2UXzsuqxE6DQeH_95sT95psJag","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$GoX13j6N-LFoVwqTvDVdFkmlAMyOQncU-wyYccvSOnE"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_b:localhost","content":{"msgtype":"m.text","body":"filename"},"depth":49,"prev_state":[],"origin":"localhost","origin_server_ts":1673457539688,"hashes":{"sha256":"xouMvLjSdmmfJ4RcRCKrU6rm5UReXQDLKYZHMtBK/Nc"},"signatures":{"localhost":{"ed25519:a_CHdg":"pxK5c0S8+7QO8eWja8CrVB9MT2kS9xwCTcCd53oKhERyEnebhZnf6czjgxL7rKlpidkwj40SWy4CZtHVN9pdAQ"}},"unsigned":{"age_ts":1673457539688}}	3
$tJ-FG4LvyDPWWc02tnnNTzC6FW5jTNsJ4Q0Y3sswUwU	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":16,"txn_id":"m1673459348258.0","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$kHkn3X5sgQZbnc7m1GNs3FoN729sUsLsqASYxvh3Jb8","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$dbbS4HRWajCEFK63hUlDVeDwHbQPIAwiE7q2p34gr64"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@user1:localhost","content":{"org.matrix.msc1767.text":"Check the message from test 1673459346045","body":"Check the message from test 1673459346045","msgtype":"m.text"},"depth":70,"prev_state":[],"origin":"localhost","origin_server_ts":1673459348382,"hashes":{"sha256":"q4cWFw6PtuNz+0t5rlHv+7pWdY3bdgMg5VtdsZ3WHLQ"},"signatures":{"localhost":{"ed25519:a_CHdg":"C8YRJfUk3hcp+a8DU0R/z5Y83bkw8tFCAM8MSkWmwWV9h9c0jsCVqTG/ndo/Xp+yxulJ/kAWUfLfzXN11akaDw"}},"unsigned":{"age_ts":1673459348382}}	3
$P2m7f_ReTUYd4Csc5OKob_vf90ua2PMyuv0NqQqhyZs	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":17,"txn_id":"m1673459438117.0","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$kHkn3X5sgQZbnc7m1GNs3FoN729sUsLsqASYxvh3Jb8","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$tJ-FG4LvyDPWWc02tnnNTzC6FW5jTNsJ4Q0Y3sswUwU"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@user1:localhost","content":{"org.matrix.msc1767.text":"Check the message from test 1673459436577","body":"Check the message from test 1673459436577","msgtype":"m.text"},"depth":71,"prev_state":[],"origin":"localhost","origin_server_ts":1673459438277,"hashes":{"sha256":"5cua7fpo9oftbjDcI1XtZuTbLNBIKpeQTP5T50Kd47Q"},"signatures":{"localhost":{"ed25519:a_CHdg":"MVP2YJ310nCccjKSsY7ikBcFTpXn/1MNxWamcgKdVuBiH8MVX05OjrqydXeK8SPMlQioJ0pKsodqpdpV3xmyBg"}},"unsigned":{"age_ts":1673459438277}}	3
$3DuuE2hHvtoVIEVkMMMOyVstiJ3B7k1t3FJ_ifxj4aw	!dKcbdDATuwwphjRPQP:localhost	{"token_id":13,"txn_id":"m1673633796820.0","historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$cl-cBWQqCEUtQdjEqlQcE0PD7MCeX1R25oC5CKqb7oE","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$0DBuAxDOgwokpytW0JkbbD3h3YNz3tiYsyJNZZqT6dM"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@user1:localhost","content":{"org.matrix.msc1767.text":"Now it should work","body":"Now it should work","msgtype":"m.text"},"depth":52,"prev_state":[],"origin":"localhost","origin_server_ts":1673633796953,"hashes":{"sha256":"jP0tJX3VNj7EKIMjnMP2JWUzwlSQo3h+nnyFuuB+KYU"},"signatures":{"localhost":{"ed25519:a_CHdg":"Y0XfanjPJ1Z/zNq0EsitwKc40Q4WJrf5M6yoWG/d+djO+1yb56bPFS9mwBz7RLa53ZyUIWBf13TN3COI4+z4Cw"}},"unsigned":{"age_ts":1673633796953}}	3
$3_rhZk71KOig-uRX6JvtgQTiwiDNjWvrhDiK3CsG8Bc	!dKcbdDATuwwphjRPQP:localhost	{"token_id":13,"txn_id":"m1673634310831.1","historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$cl-cBWQqCEUtQdjEqlQcE0PD7MCeX1R25oC5CKqb7oE"],"prev_events":["$3DuuE2hHvtoVIEVkMMMOyVstiJ3B7k1t3FJ_ifxj4aw"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@user1:localhost","content":{"org.matrix.msc1767.text":"now it should work","body":"now it should work","msgtype":"m.text"},"depth":53,"prev_state":[],"origin":"localhost","origin_server_ts":1673634310952,"hashes":{"sha256":"C3fRp2NTjND9PaglrZtdtuKviGbfn6WYK6NZF7c4cuc"},"signatures":{"localhost":{"ed25519:a_CHdg":"cIKF2iAgeZdr73oQpzeT1PmtFpT1QTShwCMPIZvng4TfY92e25zc51MxsHHOF2bSLxeR2rb5mP/cZCUXRTSFDQ"}},"unsigned":{"age_ts":1673634310952}}	3
$kFOWuoGosyBpmijZKeHjb49l9qG1PYd-7_Mz8m7TdZw	!dKcbdDATuwwphjRPQP:localhost	{"token_id":13,"txn_id":"m1673634432723.2","historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$cl-cBWQqCEUtQdjEqlQcE0PD7MCeX1R25oC5CKqb7oE"],"prev_events":["$3_rhZk71KOig-uRX6JvtgQTiwiDNjWvrhDiK3CsG8Bc"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@user1:localhost","content":{"org.matrix.msc1767.text":"ok again","body":"ok again","msgtype":"m.text"},"depth":54,"prev_state":[],"origin":"localhost","origin_server_ts":1673634432823,"hashes":{"sha256":"BaUxNM/pAvS/wr2coAIXvaA7TFPSOeZ8cR47EDBYGCg"},"signatures":{"localhost":{"ed25519:a_CHdg":"JvCmJMPMWkve7y6ytK0cKaeuh3O/oPhPqiUgJX5wl3yhlUtkXIenQ/tfKBzK9gFg2Odr9P6mvXXQL432PVuHAg"}},"unsigned":{"age_ts":1673634432823}}	3
$WVRAu1BgFM0v9p1pHq87lQjV3QNR3ftT3-zfVqOdjoE	!dKcbdDATuwwphjRPQP:localhost	{"token_id":14,"txn_id":"m1673683517767.0","historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$cl-cBWQqCEUtQdjEqlQcE0PD7MCeX1R25oC5CKqb7oE","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$kFOWuoGosyBpmijZKeHjb49l9qG1PYd-7_Mz8m7TdZw"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@user1:localhost","content":{"org.matrix.msc1767.text":"This one will work","body":"This one will work","msgtype":"m.text"},"depth":55,"prev_state":[],"origin":"localhost","origin_server_ts":1673683517916,"hashes":{"sha256":"UtuWu1ycJEwPnnDPSKpFEksr+jZzOXNbizQlTunVhRw"},"signatures":{"localhost":{"ed25519:a_CHdg":"0TSeq3bod5cwzc3xzJZku/1YyATr8TCRP58FhX3a+S9Ph/Jnq6qxut30nECFZzcEtLwpcz9xOEPkE9ZXvK6lDg"}},"unsigned":{"age_ts":1673683517916}}	3
$GHt9inHBpvm4nrOPtbJHG8c8UlpzqeGJh_-OBG8ptHQ	!dKcbdDATuwwphjRPQP:localhost	{"token_id":14,"txn_id":"m1673683910615.1","historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$cl-cBWQqCEUtQdjEqlQcE0PD7MCeX1R25oC5CKqb7oE"],"prev_events":["$WVRAu1BgFM0v9p1pHq87lQjV3QNR3ftT3-zfVqOdjoE"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@user1:localhost","content":{"org.matrix.msc1767.text":"Try again","body":"Try again","msgtype":"m.text"},"depth":56,"prev_state":[],"origin":"localhost","origin_server_ts":1673683910745,"hashes":{"sha256":"3cfOG1Qfs767s1hStCT6FFuZZ7i+j1EUbIB5OFLon+M"},"signatures":{"localhost":{"ed25519:a_CHdg":"0BeizFR9LPExlIYkNlL0pE9I0XkfISRuv9s0Qpwhj1OsGMp8opFvv2xTrmLKKjwluyRFxsiU2xUpYEzWrEFiAw"}},"unsigned":{"age_ts":1673683910745}}	3
$yVvV-TsDoWvvUlnpW14wS1F-qAd-Vm9J-uj4cAsZykg	!dKcbdDATuwwphjRPQP:localhost	{"token_id":14,"txn_id":"m1673684119236.2","historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$cl-cBWQqCEUtQdjEqlQcE0PD7MCeX1R25oC5CKqb7oE"],"prev_events":["$GHt9inHBpvm4nrOPtbJHG8c8UlpzqeGJh_-OBG8ptHQ"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@user1:localhost","content":{"body":"Ska\\u0308rmavbild 2022-12-24 kl. 12.47.52.png","info":{"size":230773,"mimetype":"image/png","thumbnail_info":{"w":800,"h":382,"mimetype":"image/png","size":63980},"w":1138,"h":544,"xyz.amorgan.blurhash":"L7Simi4:E2E5~AadE1aetSIp-nn#","thumbnail_url":"mxc://localhost/jbAAwecIXZRYlqNzQrBjriVH"},"msgtype":"m.image","url":"mxc://localhost/KfJoSGSBddxVlqlydVPwLNez"},"depth":57,"prev_state":[],"origin":"localhost","origin_server_ts":1673684119539,"hashes":{"sha256":"IGHScmbaUJVw5MeQHhilwMGRt7+I54Qw4lUVW3R0/EQ"},"signatures":{"localhost":{"ed25519:a_CHdg":"S7O7M4PKDq/YF/eqO5riuHnKNhNnlFMsxXQa0DPg/o6YHGqQHHCKV4IxH8MIUyPqgvQwpcjctsFuF7ZtvoFgBQ"}},"unsigned":{"age_ts":1673684119539}}	3
$W37bP5pDpEKfiUi_hzWhdjakNnPVlC7KgjnlsImT9os	!dKcbdDATuwwphjRPQP:localhost	{"txn_id":"m1673684215748.0","historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$CPrx1EOiKU0xFQBY1-CbMIp4Nx64vw33awql9URc-is"],"prev_events":["$yVvV-TsDoWvvUlnpW14wS1F-qAd-Vm9J-uj4cAsZykg"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"> <@user1:localhost> Ska\\u0308rmavbild 2022-12-24 kl. 12\\n\\nNice map :face_with_cowboy_hat:  ","m.relates_to":{"m.in_reply_to":{"event_id":"$yVvV-TsDoWvvUlnpW14wS1F-qAd-Vm9J-uj4cAsZykg"}},"formatted_body":"<mx-reply><blockquote><a href=\\"https://matrix.to/#/!dKcbdDATuwwphjRPQP:localhost/$yVvV-TsDoWvvUlnpW14wS1F-qAd-Vm9J-uj4cAsZykg?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@user1:localhost\\">@user1:localhost</a><br>Ska\\u0308rmavbild 2022-12-24 kl. 12.47.52.png</blockquote></mx-reply>Nice map :face_with_cowboy_hat:  ","format":"org.matrix.custom.html"},"depth":58,"prev_state":[],"origin":"localhost","origin_server_ts":1673684215773,"hashes":{"sha256":"xwbZdcaKtfLvD4VkmjUkobSR7IBycx0Ag+pJQKm+wkU"},"signatures":{"localhost":{"ed25519:a_CHdg":"a2PJBHHYwJ1xdeUT0WqXrFhiX8GTDvkP6080B8YwDNHH5yoVjzUbgspIwcLG+mGF/2qzr4QUMKvsstG7YU4ABg"}},"unsigned":{"age_ts":1673684215773}}	3
$2KYS5UbprMHWtKf1XE3EdQYt3jO__dF1wZsmNw0m7Po	!dKcbdDATuwwphjRPQP:localhost	{"token_id":14,"txn_id":"m1673684282445.3","historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$cl-cBWQqCEUtQdjEqlQcE0PD7MCeX1R25oC5CKqb7oE"],"prev_events":["$W37bP5pDpEKfiUi_hzWhdjakNnPVlC7KgjnlsImT9os"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@user1:localhost","content":{"org.matrix.msc1767.message":[{"body":"> <@mm_mattermost_a:localhost> Nice map :face_with_cowboy_hat:\\n\\nOK","mimetype":"text/plain"},{"body":"<mx-reply><blockquote><a href=\\"https://matrix.to/#/!dKcbdDATuwwphjRPQP:localhost/$W37bP5pDpEKfiUi_hzWhdjakNnPVlC7KgjnlsImT9os?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@mm_mattermost_a:localhost\\">@mm_mattermost_a:localhost</a><br>Nice map :face_with_cowboy_hat:  </blockquote></mx-reply>OK","mimetype":"text/html"}],"body":"> <@mm_mattermost_a:localhost> Nice map :face_with_cowboy_hat:\\n\\nOK","msgtype":"m.text","format":"org.matrix.custom.html","formatted_body":"<mx-reply><blockquote><a href=\\"https://matrix.to/#/!dKcbdDATuwwphjRPQP:localhost/$W37bP5pDpEKfiUi_hzWhdjakNnPVlC7KgjnlsImT9os?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@mm_mattermost_a:localhost\\">@mm_mattermost_a:localhost</a><br>Nice map :face_with_cowboy_hat:  </blockquote></mx-reply>OK","m.relates_to":{"m.in_reply_to":{"event_id":"$W37bP5pDpEKfiUi_hzWhdjakNnPVlC7KgjnlsImT9os"}}},"depth":59,"prev_state":[],"origin":"localhost","origin_server_ts":1673684282569,"hashes":{"sha256":"c5l9LLOVLn6HbCfBStmjg+vVULWGVB0pUBuF2UsGbnY"},"signatures":{"localhost":{"ed25519:a_CHdg":"MBlq0xJDmljiJ7p8SSsdDFkNS6zLx6MY8wqYSTzKuG+aIPLENs6BTO24tJpcg1vKOuLGNbmOIkaEFbMaChCQDg"}},"unsigned":{"age_ts":1673684282569}}	3
$n5Sx_AizJGu6tfAlx-aQBr2gIQ6eFROdu41oBPH_EYk	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":4,"txn_id":"m.1673685169861","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$1c97W6vcISTaUEtVZ3XtpTvdbUxTp84W9UUnJ7yQ1hI"],"prev_events":["$WVroKTDWt83RCC4syxi_4hpsCXXPlQmrMVO527aD_bg"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_b:localhost","content":{"body":"Strange message seen:\\nUse the mobile TLS system, then you can quantify the mobile interface!\\n from Kenyatta.Wolf14@hotmail.com","msgtype":"m.text"},"depth":74,"prev_state":[],"origin":"localhost","origin_server_ts":1673685169914,"hashes":{"sha256":"XzR48r2PHGcAB18isw3nnBHaEtueItjZvnx9b93rtA0"},"signatures":{"localhost":{"ed25519:a_CHdg":"gwCQwdG1lwWyT+dQZzyKeSA2Y+Z1o3XdEJyogT7jkwJzNQdkH/BkvKI475mOBjKPahrwuoiFWygE0goFGMEoAw"}},"unsigned":{"age_ts":1673685169914}}	3
$V_mgJvf-2J-ZWvd3_isj_ng3ED1Y3IR98ma44L3WQ4o	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1673684356406.1","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk"],"prev_events":["$P2m7f_ReTUYd4Csc5OKob_vf90ua2PMyuv0NqQqhyZs"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"Can you please reply !"},"depth":72,"prev_state":[],"origin":"localhost","origin_server_ts":1673684356453,"hashes":{"sha256":"IUV7RCDwfh+pJ2VZuQ5eXFbO2NGuKwVYzigHUYk00tA"},"signatures":{"localhost":{"ed25519:a_CHdg":"PsVuyDedH6L+5RmWls+bMiNQdKGz9YtIr9ydXOz8ShuuK7b4wPtWvjuNnVOUDzqg4bBy5G9j7ZzqGx1qXfxfDg"}},"unsigned":{"age_ts":1673684356453}}	3
$WVroKTDWt83RCC4syxi_4hpsCXXPlQmrMVO527aD_bg	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":14,"txn_id":"m1673684403527.4","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$kHkn3X5sgQZbnc7m1GNs3FoN729sUsLsqASYxvh3Jb8"],"prev_events":["$V_mgJvf-2J-ZWvd3_isj_ng3ED1Y3IR98ma44L3WQ4o"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@user1:localhost","content":{"org.matrix.msc1767.message":[{"body":"> <@mm_mattermost_a:localhost> Can you please reply !\\n\\nI reply now","mimetype":"text/plain"},{"body":"<mx-reply><blockquote><a href=\\"https://matrix.to/#/!kmbTYjjsDRDHGgVqUP:localhost/$V_mgJvf-2J-ZWvd3_isj_ng3ED1Y3IR98ma44L3WQ4o?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@mm_mattermost_a:localhost\\">@mm_mattermost_a:localhost</a><br>Can you please reply !</blockquote></mx-reply>I reply now","mimetype":"text/html"}],"body":"> <@mm_mattermost_a:localhost> Can you please reply !\\n\\nI reply now","msgtype":"m.text","format":"org.matrix.custom.html","formatted_body":"<mx-reply><blockquote><a href=\\"https://matrix.to/#/!kmbTYjjsDRDHGgVqUP:localhost/$V_mgJvf-2J-ZWvd3_isj_ng3ED1Y3IR98ma44L3WQ4o?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@mm_mattermost_a:localhost\\">@mm_mattermost_a:localhost</a><br>Can you please reply !</blockquote></mx-reply>I reply now","m.relates_to":{"m.in_reply_to":{"event_id":"$V_mgJvf-2J-ZWvd3_isj_ng3ED1Y3IR98ma44L3WQ4o"}}},"depth":73,"prev_state":[],"origin":"localhost","origin_server_ts":1673684403770,"hashes":{"sha256":"TBnkwmAGRfOqn8UEtYD7OQWwp+PtE1MkR+jRzlvdgM0"},"signatures":{"localhost":{"ed25519:a_CHdg":"FHoVZkhhEB5kIM2EfD9gRvGzyIcGZTYXxnOhGCPh9nNfzBUUIIbmk7+aXX77N442uQDyMU374iQj6yfnIJsmCw"}},"unsigned":{"age_ts":1673684403770}}	3
$U_hhCm5TKVpLfccts8cldxQRA18VARaw6KqAREJosKQ	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":14,"txn_id":"m1673688511428.5","historical":false}	{"auth_events":["$kHkn3X5sgQZbnc7m1GNs3FoN729sUsLsqASYxvh3Jb8","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$n5Sx_AizJGu6tfAlx-aQBr2gIQ6eFROdu41oBPH_EYk"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@user1:localhost","content":{"org.matrix.msc1767.text":"hi","body":"hi","msgtype":"m.text"},"depth":75,"prev_state":[],"origin":"localhost","origin_server_ts":1673688511510,"hashes":{"sha256":"+hRaqG+MElLyvIr6uLmpHpBR9ktnn46fywY5vCmrrCE"},"signatures":{"localhost":{"ed25519:a_CHdg":"vQlDWszudR346/LalXkGtTvw85pOiKS3tXqTh/IomlK8I6V+l3jkFsTT/i1htjuPNT+upiIjs3RZ9gitAzYcCg"}},"unsigned":{"age_ts":1673688511510}}	3
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
!dKcbdDATuwwphjRPQP:localhost	$3DuuE2hHvtoVIEVkMMMOyVstiJ3B7k1t3FJ_ifxj4aw	@matterbot:localhost	\N		52	124	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$3DuuE2hHvtoVIEVkMMMOyVstiJ3B7k1t3FJ_ifxj4aw	@admin:localhost	\N		52	124	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$3DuuE2hHvtoVIEVkMMMOyVstiJ3B7k1t3FJ_ifxj4aw	@matrix_a:localhost	\N		52	124	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$3DuuE2hHvtoVIEVkMMMOyVstiJ3B7k1t3FJ_ifxj4aw	@ignored_user:localhost	\N		52	124	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$3DuuE2hHvtoVIEVkMMMOyVstiJ3B7k1t3FJ_ifxj4aw	@matrix_b:localhost	\N		52	124	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$3_rhZk71KOig-uRX6JvtgQTiwiDNjWvrhDiK3CsG8Bc	@ignored_user:localhost	\N		53	125	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$3_rhZk71KOig-uRX6JvtgQTiwiDNjWvrhDiK3CsG8Bc	@admin:localhost	\N		53	125	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$3_rhZk71KOig-uRX6JvtgQTiwiDNjWvrhDiK3CsG8Bc	@matterbot:localhost	\N		53	125	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$3_rhZk71KOig-uRX6JvtgQTiwiDNjWvrhDiK3CsG8Bc	@matrix_b:localhost	\N		53	125	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$j0CTOXXA4AtSOD0pk6kL2BNsa6j5w517GGfkTqmm9ZE	@user1:localhost	\N		29	52	1	1	1
!dKcbdDATuwwphjRPQP:localhost	$3_rhZk71KOig-uRX6JvtgQTiwiDNjWvrhDiK3CsG8Bc	@matrix_a:localhost	\N		53	125	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$kFOWuoGosyBpmijZKeHjb49l9qG1PYd-7_Mz8m7TdZw	@ignored_user:localhost	\N		54	126	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$kFOWuoGosyBpmijZKeHjb49l9qG1PYd-7_Mz8m7TdZw	@admin:localhost	\N		54	126	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$kFOWuoGosyBpmijZKeHjb49l9qG1PYd-7_Mz8m7TdZw	@matterbot:localhost	\N		54	126	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$kFOWuoGosyBpmijZKeHjb49l9qG1PYd-7_Mz8m7TdZw	@matrix_b:localhost	\N		54	126	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$CPoznAc0caDQuTVk0FlfLDWH79HumOVggLi7MDSYT5M	@matrix_a:localhost	\N		30	65	1	1	1
!dKcbdDATuwwphjRPQP:localhost	$pWJdSD5NsfN2PI0YapF9GmJPDpHhbeH6m--Uc5qoX-A	@matrix_b:localhost	\N		31	66	1	1	1
!dKcbdDATuwwphjRPQP:localhost	$kFOWuoGosyBpmijZKeHjb49l9qG1PYd-7_Mz8m7TdZw	@matrix_a:localhost	\N		54	126	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$WVRAu1BgFM0v9p1pHq87lQjV3QNR3ftT3-zfVqOdjoE	@matrix_a:localhost	\N		55	127	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$WVRAu1BgFM0v9p1pHq87lQjV3QNR3ftT3-zfVqOdjoE	@matterbot:localhost	\N		55	127	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$WVRAu1BgFM0v9p1pHq87lQjV3QNR3ftT3-zfVqOdjoE	@admin:localhost	\N		55	127	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$WVRAu1BgFM0v9p1pHq87lQjV3QNR3ftT3-zfVqOdjoE	@matrix_b:localhost	\N		55	127	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$WVRAu1BgFM0v9p1pHq87lQjV3QNR3ftT3-zfVqOdjoE	@ignored_user:localhost	\N		55	127	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$GHt9inHBpvm4nrOPtbJHG8c8UlpzqeGJh_-OBG8ptHQ	@matrix_a:localhost	\N		56	128	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$GHt9inHBpvm4nrOPtbJHG8c8UlpzqeGJh_-OBG8ptHQ	@ignored_user:localhost	\N		56	128	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$GHt9inHBpvm4nrOPtbJHG8c8UlpzqeGJh_-OBG8ptHQ	@matrix_b:localhost	\N		56	128	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$GHt9inHBpvm4nrOPtbJHG8c8UlpzqeGJh_-OBG8ptHQ	@matterbot:localhost	\N		56	128	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$GHt9inHBpvm4nrOPtbJHG8c8UlpzqeGJh_-OBG8ptHQ	@admin:localhost	\N		56	128	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$2KYS5UbprMHWtKf1XE3EdQYt3jO__dF1wZsmNw0m7Po	@matrix_a:localhost	\N		59	131	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$2KYS5UbprMHWtKf1XE3EdQYt3jO__dF1wZsmNw0m7Po	@ignored_user:localhost	\N		59	131	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$2KYS5UbprMHWtKf1XE3EdQYt3jO__dF1wZsmNw0m7Po	@matrix_b:localhost	\N		59	131	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$2KYS5UbprMHWtKf1XE3EdQYt3jO__dF1wZsmNw0m7Po	@matterbot:localhost	\N		59	131	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$2KYS5UbprMHWtKf1XE3EdQYt3jO__dF1wZsmNw0m7Po	@admin:localhost	\N		59	131	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$U_hhCm5TKVpLfccts8cldxQRA18VARaw6KqAREJosKQ	@ignored_user:localhost	\N		75	135	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$U_hhCm5TKVpLfccts8cldxQRA18VARaw6KqAREJosKQ	@matterbot:localhost	\N		75	135	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$U_hhCm5TKVpLfccts8cldxQRA18VARaw6KqAREJosKQ	@matrix_b:localhost	\N		75	135	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$U_hhCm5TKVpLfccts8cldxQRA18VARaw6KqAREJosKQ	@admin:localhost	\N		75	135	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$U_hhCm5TKVpLfccts8cldxQRA18VARaw6KqAREJosKQ	@matrix_a:localhost	\N		75	135	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$yVvV-TsDoWvvUlnpW14wS1F-qAd-Vm9J-uj4cAsZykg	@matrix_a:localhost	\N		57	129	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$yVvV-TsDoWvvUlnpW14wS1F-qAd-Vm9J-uj4cAsZykg	@ignored_user:localhost	\N		57	129	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$yVvV-TsDoWvvUlnpW14wS1F-qAd-Vm9J-uj4cAsZykg	@matrix_b:localhost	\N		57	129	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$yVvV-TsDoWvvUlnpW14wS1F-qAd-Vm9J-uj4cAsZykg	@matterbot:localhost	\N		57	129	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$yVvV-TsDoWvvUlnpW14wS1F-qAd-Vm9J-uj4cAsZykg	@admin:localhost	\N		57	129	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$WVroKTDWt83RCC4syxi_4hpsCXXPlQmrMVO527aD_bg	@matrix_a:localhost	\N		73	133	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$WVroKTDWt83RCC4syxi_4hpsCXXPlQmrMVO527aD_bg	@ignored_user:localhost	\N		73	133	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$WVroKTDWt83RCC4syxi_4hpsCXXPlQmrMVO527aD_bg	@matrix_b:localhost	\N		73	133	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$WVroKTDWt83RCC4syxi_4hpsCXXPlQmrMVO527aD_bg	@matterbot:localhost	\N		73	133	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$WVroKTDWt83RCC4syxi_4hpsCXXPlQmrMVO527aD_bg	@admin:localhost	\N		73	133	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$_fc7lLRXoDsqiFKFvhlsSOsOE75ppMdi2ZRa-w_o0OY	@matrix_a:localhost	\N		36	84	1	1	1
!dKcbdDATuwwphjRPQP:localhost	$oXdn9vR9Yxd3FXZOxnZLiW-XByipCOWC32N6UNC7fCI	@matrix_b:localhost	\N		37	85	1	1	1
!dKcbdDATuwwphjRPQP:localhost	$W37bP5pDpEKfiUi_hzWhdjakNnPVlC7KgjnlsImT9os	@matrix_a:localhost	\N		58	130	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$W37bP5pDpEKfiUi_hzWhdjakNnPVlC7KgjnlsImT9os	@ignored_user:localhost	\N		58	130	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$W37bP5pDpEKfiUi_hzWhdjakNnPVlC7KgjnlsImT9os	@matrix_b:localhost	\N		58	130	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$W37bP5pDpEKfiUi_hzWhdjakNnPVlC7KgjnlsImT9os	@matterbot:localhost	\N		58	130	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$W37bP5pDpEKfiUi_hzWhdjakNnPVlC7KgjnlsImT9os	@admin:localhost	\N		58	130	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$W37bP5pDpEKfiUi_hzWhdjakNnPVlC7KgjnlsImT9os	@user1:localhost	\N		58	130	1	1	1
!kmbTYjjsDRDHGgVqUP:localhost	$V_mgJvf-2J-ZWvd3_isj_ng3ED1Y3IR98ma44L3WQ4o	@matrix_a:localhost	\N		72	132	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$V_mgJvf-2J-ZWvd3_isj_ng3ED1Y3IR98ma44L3WQ4o	@ignored_user:localhost	\N		72	132	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$V_mgJvf-2J-ZWvd3_isj_ng3ED1Y3IR98ma44L3WQ4o	@matrix_b:localhost	\N		72	132	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$V_mgJvf-2J-ZWvd3_isj_ng3ED1Y3IR98ma44L3WQ4o	@matterbot:localhost	\N		72	132	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$Hlu0oKcyD432dWmJ9w0xHm3PLMnH85Jn-X3GDTYuVV4	@matrix_b:localhost	\N		50	88	1	1	1
!kmbTYjjsDRDHGgVqUP:localhost	$V_mgJvf-2J-ZWvd3_isj_ng3ED1Y3IR98ma44L3WQ4o	@admin:localhost	\N		72	132	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$n5Sx_AizJGu6tfAlx-aQBr2gIQ6eFROdu41oBPH_EYk	@matrix_a:localhost	\N		74	134	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$n5Sx_AizJGu6tfAlx-aQBr2gIQ6eFROdu41oBPH_EYk	@ignored_user:localhost	\N		74	134	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$n5Sx_AizJGu6tfAlx-aQBr2gIQ6eFROdu41oBPH_EYk	@matterbot:localhost	\N		74	134	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$n5Sx_AizJGu6tfAlx-aQBr2gIQ6eFROdu41oBPH_EYk	@admin:localhost	\N		74	134	1	0	1
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
@admin:localhost	!kmbTYjjsDRDHGgVqUP:localhost	42	123	42
@admin:localhost	!dKcbdDATuwwphjRPQP:localhost	25	120	25
@matrix_a:localhost	!dKcbdDATuwwphjRPQP:localhost	12	118	12
@ignored_user:localhost	!dKcbdDATuwwphjRPQP:localhost	26	120	26
@matrix_a:localhost	!kmbTYjjsDRDHGgVqUP:localhost	33	123	33
@ignored_user:localhost	!kmbTYjjsDRDHGgVqUP:localhost	43	123	43
@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	26	120	26
@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	43	123	43
@matrix_b:localhost	!dKcbdDATuwwphjRPQP:localhost	22	120	22
@matrix_b:localhost	!kmbTYjjsDRDHGgVqUP:localhost	32	123	32
\.


--
-- Data for Name: event_push_summary_stream_ordering; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_push_summary_stream_ordering (lock, stream_ordering) FROM stdin;
X	124
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
$kHkn3X5sgQZbnc7m1GNs3FoN729sUsLsqASYxvh3Jb8	sha256	\\x907927dd7e6c81065b9dcee6d4636cdc5a0def6f6c52c2eca80498c6f87725bf
$cl-cBWQqCEUtQdjEqlQcE0PD7MCeX1R25oC5CKqb7oE	sha256	\\x725f9c05642a08452d41d8c4aa541c1343c3ecc09e5f5476e680b908aa9bee81
$8a8OTFPqvfsx2aHJeu9IBu-xR3Gn7rdv9l_HZtPKkFg	sha256	\\xf1af0e4c53eabdfb31d9a1c97aef4806efb14771a7eeb76ff65fc766d3ca9058
$BWMrEpKFpKKbBz5Ox9zTP3TvT5zyh6w3zhpl-epXhkk	sha256	\\x05632b129285a4a29b073e4ec7dcd33f74ef4f9cf287ac37ce1a65f9ea578649
$r3Ho1IsdJmJB13pD9yX-Jkg_a5s28kBCqoNZ5EPWwqM	sha256	\\xaf71e8d48b1d266241d77a43f725fe26483f6b9b36f24042aa8359e443d6c2a3
$fQ28BQv7GUBcg_Ok7MCh8uTcQLoT2Tkr2BegUMhst1M	sha256	\\x7d0dbc050bfb19405c83f3a4ecc0a1f2e4dc40ba13d9392bd817a050c86cb753
$S7qfuHyVNKlnX8WQb78EyVSR_7_dnmagLA8asozsQtE	sha256	\\x4bba9fb87c9534a9675fc5906fbf04c95491ffbfdd9e66a02c0f1ab28cec42d1
$TOzcyxIV2S5U6CP15QCldRMJRaDz1Yaik15PorvZYGc	sha256	\\x4cecdccb1215d92e54e823f5e500a575130945a0f3d586a2935e4fa2bbd96067
$Sa-w9Co29Yd94wHfPbpfCOuSSlMlorQ7ssiGXYp8oh8	sha256	\\x49afb0f42a36f5877de301df3dba5f08eb924a5325a2b43bb2c8865d8a7ca21f
$n6TBNMF739-W93vnPpWYiJ_zTj-UGsx8mCtkFUsmkrY	sha256	\\x9fa4c134c17bdfdf96f77be73e9598889ff34e3f941acc7c982b64154b2692b6
$5auMphtCZ9zvRqrhyXpY0s-cZZl2AbvkyGNRbm2h2zc	sha256	\\xe5ab8ca61b4267dcef46aae1c97a58d2cf9c65997601bbe4c863516e6da1db37
$Yb59onmhkHIpIJ_VnrP0V02pkFQEF1GwuJqZCNRTQeQ	sha256	\\x61be7da279a1907229209fd59eb3f4574da99054041751b0b89a9908d45341e4
$j0CTOXXA4AtSOD0pk6kL2BNsa6j5w517GGfkTqmm9ZE	sha256	\\x8f40933975c0e00b52383d2993a90bd8136c6ba8f9c39d7b1867e44ea9a6f591
$YgrzVCWDDxVv-dvf3HhpLD0QlN4nD5-CXg0T-gEX6iI	sha256	\\x620af35425830f156ff9dbdfdc78692c3d1094de270f9f825e0d13fa0117ea22
$IaI_j1zJZ04lmJmCzJfvnr48U2umqKYG1xogY-r9UNY	sha256	\\x21a23f8f5cc9674e25989982cc97ef9ebe3c536ba6a8a606d71a2063eafd50d6
$TbIhAYsmySe2O7IaMBarYDokr6-UmyH4IYI3SpbhI-Q	sha256	\\x4db221018b26c927b63bb21a3016ab603a24afaf949b21f82182374a96e123e4
$YBt0yFQdKC_886W6aXe4LIv5A5BcBP7pXYeF8XLKhH0	sha256	\\x601b74c8541d282ffcf3a5ba6977b82c8bf903905c04fee95d8785f172ca847d
$-wkWlUVunP818RkFXsoACrEQ85-ybLTc-vWqiil50Vo	sha256	\\xfb091695456e9cff35f119055eca000ab110f39fb26cb4dcfaf5aa8a2979d15a
$kQPpv66TuseXeTXJr41QlqLnJBWNpBA_zgzIaJMjpLc	sha256	\\x9103e9bfae93bac7977935c9af8d5096a2e724158da4103fce0cc8689323a4b7
$BG2gCT3tXMWdl5AO704CVjroaQJysHmLZMRN-QrTH8w	sha256	\\x046da0093ded5cc59d97900eef4e02563ae8690272b0798b64c44df90ad31fcc
$AXNJvl1CFFkmeDr63y2IykCN_G-lJiDa4JHsOjaUj4Y	sha256	\\x017349be5d42145926783afadf2d88ca408dfc6fa52620dae091ec3a36948f86
$9hK3JsOVrMiv0wKjw57rMkc6mne_XmZ0CRTz65g97ek	sha256	\\xf612b726c395acc8afd302a3c39eeb32473a9a77bf5e66740914f3eb983dede9
$uFBLsg4RZn3DtG5dqcZ8A11zEbkWHwPLjk_VQtaj0qM	sha256	\\xb8504bb20e11667dc3b46e5da9c67c035d7311b9161f03cb8e4fd542d6a3d2a3
$wFcIkswyANl3CQZdt_hX9g9e2TeFjIzp9bWhcEbBiCI	sha256	\\xc0570892cc3200d97709065db7f857f60f5ed937858c8ce9f5b5a17046c18822
$Y_FmFbCe62ffJ-UyN7IA1IbcRgUsELxe9lGLmGbDg9o	sha256	\\x63f16615b09eeb67df27e53237b200d486dc46052c10bc5ef6518b9866c383da
$CPoznAc0caDQuTVk0FlfLDWH79HumOVggLi7MDSYT5M	sha256	\\x08fa339c073471a0d0b93564d0595f2c3587efd1ee98e56080b8bb3034984f93
$pWJdSD5NsfN2PI0YapF9GmJPDpHhbeH6m--Uc5qoX-A	sha256	\\xa5625d483e4db1f3763c8d186a917d1a624f0e91e16de1fa9bef94739aa85fe0
$zsvkWRGeOerm3Q5DPlTgr7kA7cM2-F0gXr40MUzknyc	sha256	\\xcecbe459119e39eae6dd0e433e54e0afb900edc336f85d205ebe34314ce49f27
$NSU5p_lrJEBTd3R6M_2_6ujF1CP9jw5z6-bDhTYxlzY	sha256	\\x352539a7f96b24405377747a33fdbfeae8c5d423fd8f0e73ebe6c38536319736
$35mlnbt-wcKTRY9cY7oyxyQbIoQPDLdRLHQQPGPVJzo	sha256	\\xdf99a59dbb7ec1c293458f5c63ba32c7241b22840f0cb7512c74103c63d5273a
$bZPoJ2CteeROVbzJXAb_pwUfP2AIqhQn8X1nYN6cjRI	sha256	\\x6d93e82760ad79e44e55bcc95c06ffa7051f3f6008aa1427f17d6760de9c8d12
$EpI_As8tc8wuYQzlSbGEsxAOAAjphf1Wn48-zC2Pj68	sha256	\\x12923f02cf2d73cc2e610ce549b184b3100e0008e985fd569f8f3ecc2d8f8faf
$Q-2CPBoV3oTFZxGNkFMvNq26XugVjG2Cya0i5tuYeEg	sha256	\\x43ed823c1a15de84c567118d90532f36adba5ee8158c6d82c9ad22e6db987848
$tWUlYx2qFNzpE_0CfMdKwbXSysRu-Z-uE0yWFp2GbGo	sha256	\\xb56525631daa14dce913fd027cc74ac1b5d2cac46ef99fae134c96169d866c6a
$Ip6vtDe80sOxCWnWoPVYYN-aqQ4AdGR-zO_krrdduFg	sha256	\\x229eafb437bcd2c3b10969d6a0f55860df9aa90e0074647eccefe4aeb75db858
$FhGz_XSQqkNt3u5faKV2p5k8gF47j_27y5RwVbtf3dk	sha256	\\x1611b3fd7490aa436ddeee5f68a576a7993c805e3b8ffdbbcb947055bb5fddd9
$J2GCbFH7iG1fp5SNdsGmkmqFm59eqB_lJMGLY5yk1D8	sha256	\\x2761826c51fb886d5fa7948d76c1a6926a859b9f5ea81fe524c18b639ca4d43f
$Dtmij3Zgur83VAr9O_P7MPtbPgUoMnnz_pOwemaro9I	sha256	\\x0ed9a28f7660babf37540afd3bf3fb30fb5b3e05283279f3fe93b07a66aba3d2
$Y0__yZ70xH8p15Jr_yTtOJmrMCpaSJLwSo2cc1W4F6o	sha256	\\x634fffc99ef4c47f29d7926bff24ed3899ab302a5a4892f04a8d9c7355b817aa
$gPWgeFNvAi1vMKPUzorqatfuOy4HXWKOwonBbcYhiN8	sha256	\\x80f5a078536f022d6f30a3d4ce8aea6ad7ee3b2e075d628ec289c16dc62188df
$Bh8N0WeVWl8koOcEkS8E0m4kulvHaq75oA0ou0aE8qs	sha256	\\x061f0dd167955a5f24a0e704912f04d26e24ba5bc76aaef9a00d28bb4684f2ab
$GgR_nTglOMJoS8SoJ-HFOS81y7cmJK64h0DeBVyFxkM	sha256	\\x1a047f9d382538c2684bc4a827e1c5392f35cbb72624aeb88740de055c85c643
$sDESXFNHywZLVAjOAvBW4Qtv660_Xx9oVSAIUzZs5bA	sha256	\\xb031125c5347cb064b5408ce02f056e10b6febad3f5f1f6855200853366ce5b0
$Hlu0oKcyD432dWmJ9w0xHm3PLMnH85Jn-X3GDTYuVV4	sha256	\\x1e5bb4a0a7320f8df6756989f70d311e6dcf2cc9c7f39267f97dc60d362e555e
$CGChqoz8kvvahzTLr-uENaReKyq5KpqLrL1g9bePx2I	sha256	\\x0860a1aa8cfc92fbda8734cbafeb8435a45e2b2ab92a9a8bacbd60f5b78fc762
$UHKKJIW-yVrjog2Pg_MR43oEkfSUhSVKiFGHGPbNaOU	sha256	\\x50728a2485bec95ae3a20d8f83f311e37a0491f49485254a88518718f6cd68e5
$_64yupcz2_qLrKOWrT87_V-HWN64bsQaq1VhCZ_zRnE	sha256	\\xffae32ba9733dbfa8baca396ad3f3bfd5f8758deb86ec41aab5561099ff34671
$XMPmaEvrP8Ebnl1P6-T-4JWR8Ms1HgLkboYib2Z0LAI	sha256	\\x5cc3e6684beb3fc11b9e5d4febe4fee09591f0cb351e02e46e86226f66742c02
$8Lzt8KQPe0wAkuTOKq6BkdBqXu9LrnnsSyeYQ70hPDs	sha256	\\xf0bcedf0a40f7b4c0092e4ce2aae8191d06a5eef4bae79ec4b279843bd213c3b
$7SK-_DIPq2s374RTSr3as9S8GNyjBCDXOXK_ycMXc74	sha256	\\xed22befc320fab6b37ef84534abddab3d4bc18dca30420d73972bfc9c31773be
$P2m7f_ReTUYd4Csc5OKob_vf90ua2PMyuv0NqQqhyZs	sha256	\\x3f69bb7ff45e4d461de02b1ce4e2a86ffbdff74b9ad8f332bafd0da90aa1c99b
$_k0ZpNW0oLpqiDqR7NJvZKdA2ZtHt_egRgLiFirmaYQ	sha256	\\xfe4d19a4d5b4a0ba6a883a91ecd26f64a740d99b47b7f7a04602e2162ae66984
$9i3p0sl8iw-4rVjwMHJnTFujme1in4rnO1zkP9hPq8w	sha256	\\xf62de9d2c97c8b0fb8ad58f03072674c5ba399ed629f8ae73b5ce43fd84fabcc
$dyDBJ0bfzPuc6VwuCR3A1Q2GNqb5JweFoRuLiNBdLgg	sha256	\\x7720c12746dfccfb9ce95c2e091dc0d50d8636a6f9270785a11b8b88d05d2e08
$9bNGuvT22oFV6Q8GFIzEZVofSbnyc61EIvnP8_3QqCE	sha256	\\xf5b346baf4f6da8155e90f06148cc4655a1f49b9f273ad4422f9cff3fdd0a821
$_fc7lLRXoDsqiFKFvhlsSOsOE75ppMdi2ZRa-w_o0OY	sha256	\\xfdf73b94b457a03b2a885285be196c48eb0e13be69a4c762d9945afb0fe8d0e6
$oXdn9vR9Yxd3FXZOxnZLiW-XByipCOWC32N6UNC7fCI	sha256	\\xa17767f6f47d63177715764ec6764b896f970728a908e582df637a50d0bb7c22
$dbbS4HRWajCEFK63hUlDVeDwHbQPIAwiE7q2p34gr64	sha256	\\x75b6d2e074566a308414aeb785494355e0f01db40f200c2213bab6a77e20afae
$jnaBiJUcEka0drCdQFKBUWluWZq5S7dPNR3XCnWwx8g	sha256	\\x8e768188951c1246b476b09d40528151696e599ab94bb74f351dd70a75b0c7c8
$krZXlGfGshKwkFJk6XwnR-gCOaeiC5p1Z6YZwNw6Tg0	sha256	\\x92b6579467c6b212b0905264e97c2747e80239a7a20b9a7567a619c0dc3a4e0d
$eY_eQCpyM7JAv11-157xBIO8c02XOKPAKO5-oLLkaMM	sha256	\\x798fde402a7233b240bf5d7ed79ef10483bc734d9738a3c028ee7ea0b2e468c3
$vQGo7i4QMQ-SSBxBmQa7vPtet-fqNIosOIQOhXXoLwc	sha256	\\xbd01a8ee2e10310f92481c419906bbbcfb5eb7e7ea348a2c38840e8575e82f07
$m8qqKQF7tvdc1qLDrWf1DjyHng9_F2Y0v_gzFRh6Kag	sha256	\\x9bcaaa29017bb6f75cd6a2c3ad67f50e3c879e0f7f176634bff83315187a29a8
$Yis1BltcsgIBI_y81aVbrWa5qBJs3O4cjY7TtOnv3AU	sha256	\\x622b35065b5cb2020123fcbcd5a55bad66b9a8126cdcee1c8d8ed3b4e9efdc05
$zUomLm3mThwuYeUXH2UXzsuqxE6DQeH_95sT95psJag	sha256	\\xcd4a262e6de64e1c2e61e5171f6517cecbaac44e8341e1fff79b13f79a6c25a8
$sKC-AGmNhmjm9fAYYksybJgXr_tCsBeZrEAv6k7VTyk	sha256	\\xb0a0be00698d8668e6f5f018624b326c9817affb42b01799ac402fea4ed54f29
$1c97W6vcISTaUEtVZ3XtpTvdbUxTp84W9UUnJ7yQ1hI	sha256	\\xd5cf7b5babdc2124da504b556775eda53bdd6d4c53a7ce16f5452727bc90d612
$u2wX-H57z6LJIi2iBRq8--9YEHZj924d1XHR1tbNoTU	sha256	\\xbb6c17f87e7bcfa2c9222da2051abcfbef58107663f76e1dd571d1d6d6cda135
$GoX13j6N-LFoVwqTvDVdFkmlAMyOQncU-wyYccvSOnE	sha256	\\x1a85f5de3e8df8b168570a93bc355d1649a500cc8e427714fb0c9871cbd23a71
$njvVCKYhRssX__fnFZ8owlNsOC9u3FRj0pmcqeIVVjI	sha256	\\x9e3bd508a62146cb17fff7e7159f28c2536c382f6edc5463d2999ca9e2155632
$3tVAg8SuDfjs9Fgkhfie7XW_PKyBUpsFLrnHYwASpBc	sha256	\\xded54083c4ae0df8ecf4582485f89eed75bf3cac81529b052eb9c7630012a417
$ABAs5n2LLFjtJj9U8vpXJZW4XssE1_1AOKq1Hht9rAc	sha256	\\x00102ce67d8b2c58ed263f54f2fa572595b85ecb04d7fd4038aab51e1b7dac07
$XhY61XTnLilEWT5TBmpjFvWg-ttI3HSyLVoLRUVNShI	sha256	\\x5e163ad574e72e2944593e53066a6316f5a0fadb48dc74b22d5a0b45454d4a12
$efNJ2_fNXgtmBlwuX0QfDBZLeNBnkF0bix0VF0AaBUc	sha256	\\x79f349dbf7cd5e0b66065c2e5f441f0c164b78d067905d1b8b1d1517401a0547
$Rx9kQ8hCx2y1bcLpdhzPqXHkrlExdX1yc3YshWnC6og	sha256	\\x471f6443c842c76cb56dc2e9761ccfa971e4ae5131757d7273762c8569c2ea88
$hz_8OnlfAO5weTQ3Sy0cNJ83PP6UGxmBomiBKe4JB5w	sha256	\\x873ffc3a795f00ee707934374b2d1c349f373cfe941b1981a2688129ee09079c
$Op0TBQz5bRKUyxhUgvd0RMEbDt0BloR6y_aUatQJcO4	sha256	\\x3a9d13050cf96d1294cb185482f77444c11b0edd0196847acbf6946ad40970ee
$KjxZjGyxoIyEvF0d6WjubIy5-PjQ8gTixRenqiw88iA	sha256	\\x2a3c598c6cb1a08c84bc5d1de968ee6c8cb9f8f8d0f204e2c517a7aa2c3cf220
$HtuzOrzcCN4JBQCmC2S0KmN-Sq3OXYHy41_xxL3VNE4	sha256	\\x1edbb33abcdc08de090500a60b64b42a637e4aadce5d81f2e35ff1c4bdd5344e
$uwxaXiusawT_bOeyGHwB7wfy4YVDUUpEs6A4YMBKfTg	sha256	\\xbb0c5a5e2bac6b04ff6ce7b2187c01ef07f2e18543514a44b3a03860c04a7d38
$VcoB1_pk9tOinsmwdQJYShtIuSLosTj-jzPHDVJjEv8	sha256	\\x55ca01d7fa64f6d3a29ec9b07502584a1b48b922e8b138fe8f33c70d526312ff
$ORHWJnv40jDzKKISq_X3_aBTGHZZJqjFEVg1kUnrWQ4	sha256	\\x3911d6267bf8d230f328a212abf5f7fda05318765926a8c51158359149eb590e
$0DBuAxDOgwokpytW0JkbbD3h3YNz3tiYsyJNZZqT6dM	sha256	\\xd0306e0310ce830a24a72b56d0991b6c3de1dd8373ded898b3224d659a93e9d3
$tJ-FG4LvyDPWWc02tnnNTzC6FW5jTNsJ4Q0Y3sswUwU	sha256	\\xb49f851b82efc833d659cd36b679cd4f30ba156e634cdb09e10d18decb305305
$3DuuE2hHvtoVIEVkMMMOyVstiJ3B7k1t3FJ_ifxj4aw	sha256	\\xdc3bae136847beda1520456430c30ec95b2d889dc1ee4d6ddc527f89fc63e1ac
$3_rhZk71KOig-uRX6JvtgQTiwiDNjWvrhDiK3CsG8Bc	sha256	\\xdffae1664ef528e8a0fae457e89bed8104e2c220cd8d6beb84388adc2b06f017
$kFOWuoGosyBpmijZKeHjb49l9qG1PYd-7_Mz8m7TdZw	sha256	\\x905396ba81a8b320699a28d929e1e36f8f65f6a1b53d877eeff333f26ed3759c
$WVRAu1BgFM0v9p1pHq87lQjV3QNR3ftT3-zfVqOdjoE	sha256	\\x595440bb506014cd2ff69d691eaf3b9508d5dd0351ddfb53dfecdf56a39d8e81
$GHt9inHBpvm4nrOPtbJHG8c8UlpzqeGJh_-OBG8ptHQ	sha256	\\x187b7d8a71c1a6f9b89eb38fb5b2471bc73c525a73a9e18987ff8e046f29b474
$yVvV-TsDoWvvUlnpW14wS1F-qAd-Vm9J-uj4cAsZykg	sha256	\\xc95bd5f93b03a16bef5259e95b5e304b517ea8077e566f49fae8f8700b19ca48
$W37bP5pDpEKfiUi_hzWhdjakNnPVlC7KgjnlsImT9os	sha256	\\x5b7edb3f9a43a4429f8948bf8735a17636a43673d5942eca8239e5b08993f68b
$2KYS5UbprMHWtKf1XE3EdQYt3jO__dF1wZsmNw0m7Po	sha256	\\xd8a612e546e9acc1d6b4a7f55c4dc475062dde33bffdd175c19b26370d26ecfa
$V_mgJvf-2J-ZWvd3_isj_ng3ED1Y3IR98ma44L3WQ4o	sha256	\\x57f9a026f7fed89f995af777fe2b23fe7837103d58dc847df266b8e0bdd6438a
$WVroKTDWt83RCC4syxi_4hpsCXXPlQmrMVO527aD_bg	sha256	\\x595ae82930d6b7cdd1082e2ccb18bfe21a6c0975cf9509ab3153b9dbb683fdb8
$n5Sx_AizJGu6tfAlx-aQBr2gIQ6eFROdu41oBPH_EYk	sha256	\\x9f94b1fc08b3246bbab5f025c7e69006bda0210e9e15139dbb8d6804f1ff1189
$U_hhCm5TKVpLfccts8cldxQRA18VARaw6KqAREJosKQ	sha256	\\x53f8610a6e53295a4b7dc72db3c725771411035f150116b0e8aa80444268b0a4
\.


--
-- Data for Name: event_relations; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_relations (event_id, relates_to_id, relation_type, aggregation_key) FROM stdin;
$YgrzVCWDDxVv-dvf3HhpLD0QlN4nD5-CXg0T-gEX6iI	$j0CTOXXA4AtSOD0pk6kL2BNsa6j5w517GGfkTqmm9ZE	m.annotation	🤩
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
$8a8OTFPqvfsx2aHJeu9IBu-xR3Gn7rdv9l_HZtPKkFg	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'text':2	1672920683485	42
$BWMrEpKFpKKbBz5Ox9zTP3TvT5zyh6w3zhpl-epXhkk	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'text':2	1672920816788	43
$r3Ho1IsdJmJB13pD9yX-Jkg_a5s28kBCqoNZ5EPWwqM	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'text':2	1672921550713	44
$fQ28BQv7GUBcg_Ok7MCh8uTcQLoT2Tkr2BegUMhst1M	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'capacitor':11 'copi':3 'dram':7 'll':2 'pixel':14 'solid':5 'state':6 'transmitt':8 'usb':13	1672921603138	45
$5auMphtCZ9zvRqrhyXpY0s-cZZl2AbvkyGNRbm2h2zc	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'channel':3 'like':1	1672922287761	50
$Yb59onmhkHIpIJ_VnrP0V02pkFQEF1GwuJqZCNRTQeQ	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'alarm':14 'digit':3 'drive':6 'hard':5 'pars':10 'solid':12 'state':13 'thx':4 'use':1	1672922412287	51
$j0CTOXXA4AtSOD0pk6kL2BNsa6j5w517GGfkTqmm9ZE	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'1':5 'onlin':3 'user':4	1672922547588	52
$IaI_j1zJZ04lmJmCzJfvnr48U2umqKYG1xogY-r9UNY	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'ok':1	1672922600605	54
$TbIhAYsmySe2O7IaMBarYDokr6-UmyH4IYI3SpbhI-Q	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'program':2	1672922654500	55
$YBt0yFQdKC_886W6aXe4LIv5A5BcBP7pXYeF8XLKhH0	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'testing_in_vs_code.png':1	1672922655109	56
$-wkWlUVunP818RkFXsoACrEQ85-ybLTc-vWqiil50Vo	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'nice':1	1672923027781	57
$kQPpv66TuseXeTXJr41QlqLnJBWNpBA_zgzIaJMjpLc	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'back':11 'back-end':10 'bus':14 'circuit':6 'end':12 'hack':4 'index':8 'ip':13 'without':7	1672923221916	58
$BG2gCT3tXMWdl5AO704CVjroaQJysHmLZMRN-QrTH8w	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'hidden':1 'messag':2	1673367066720	59
$AXNJvl1CFFkmeDr63y2IykCN_G-lJiDa4JHsOjaUj4Y	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'hidden':1 'messag':2	1673367091822	60
$9hK3JsOVrMiv0wKjw57rMkc6mne_XmZ0CRTz65g97ek	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'hidden':1 'messag':2	1673367607062	61
$uFBLsg4RZn3DtG5dqcZ8A11zEbkWHwPLjk_VQtaj0qM	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'test':1	1673367804476	62
$wFcIkswyANl3CQZdt_hX9g9e2TeFjIzp9bWhcEbBiCI	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'test':1	1673367882756	63
$Y_FmFbCe62ffJ-UyN7IA1IbcRgUsELxe9lGLmGbDg9o	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'first':1 'matrix':2 'messag':3	1673367937094	64
$CPoznAc0caDQuTVk0FlfLDWH79HumOVggLi7MDSYT5M	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'first':3 'matrix':1,4,7 'messag':5,8 'second':6	1673367937228	65
$pWJdSD5NsfN2PI0YapF9GmJPDpHhbeH6m--Uc5qoX-A	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'b':2 'matrix':1,3,6 'messag':7 'third':5	1673367937356	66
$zsvkWRGeOerm3Q5DPlTgr7kA7cM2-F0gXr40MUzknyc	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'test':1	1673456419304	67
$NSU5p_lrJEBTd3R6M_2_6ujF1CP9jw5z6-bDhTYxlzY	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'test2':1	1673456422195	68
$35mlnbt-wcKTRY9cY7oyxyQbIoQPDLdRLHQQPGPVJzo	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'bold':2 'header':1	1673456423178	69
$bZPoJ2CteeROVbzJXAb_pwUfP2AIqhQn8X1nYN6cjRI	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'messag':3 'random':1 'wrong':2	1673456424045	70
$EpI_As8tc8wuYQzlSbGEsxAOAAjphf1Wn48-zC2Pj68	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'test':1	1673456424470	71
$Q-2CPBoV3oTFZxGNkFMvNq26XugVjG2Cya0i5tuYeEg	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'filenam':1	1673456424779	72
$_k0ZpNW0oLpqiDqR7NJvZKdA2ZtHt_egRgLiFirmaYQ	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'filenam':1	1673456425021	73
$tWUlYx2qFNzpE_0CfMdKwbXSysRu-Z-uE0yWFp2GbGo	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'mydata':1	1673456425374	74
$Ip6vtDe80sOxCWnWoPVYYN-aqQ4AdGR-zO_krrdduFg	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'hidden':1 'messag':2	1673456425739	75
$9bNGuvT22oFV6Q8GFIzEZVofSbnyc61EIvnP8_3QqCE	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'test':1	1673456445206	76
$FhGz_XSQqkNt3u5faKV2p5k8gF47j_27y5RwVbtf3dk	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'test2':1	1673456445512	77
$J2GCbFH7iG1fp5SNdsGmkmqFm59eqB_lJMGLY5yk1D8	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'bold':2 'header':1	1673456445810	78
$Dtmij3Zgur83VAr9O_P7MPtbPgUoMnnz_pOwemaro9I	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'messag':3 'random':1 'wrong':2	1673456446033	79
$Y0__yZ70xH8p15Jr_yTtOJmrMCpaSJLwSo2cc1W4F6o	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'first':1 'messag':3 'mm':2	1673456468128	80
$gPWgeFNvAi1vMKPUzorqatfuOy4HXWKOwonBbcYhiN8	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'first':5 'localhost':4 'mattermost':2 'messag':7,10 'mm':1,6,9 'second':8	1673456468733	81
$Bh8N0WeVWl8koOcEkS8E0m4kulvHaq75oA0ou0aE8qs	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'b':3 'localhost':4,8 'mattermost':2,6 'messag':11 'mm':1,5,10 'third':9	1673456468901	82
$jnaBiJUcEka0drCdQFKBUWluWZq5S7dPNR3XCnWwx8g	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'whatev':1	1673456470100	87
$GgR_nTglOMJoS8SoJ-HFOS81y7cmJK64h0DeBVyFxkM	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'first':1 'matrix':2 'messag':3	1673456469150	83
$sDESXFNHywZLVAjOAvBW4Qtv660_Xx9oVSAIUzZs5bA	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'first':1 'messag':2	1673456469844	86
$Hlu0oKcyD432dWmJ9w0xHm3PLMnH85Jn-X3GDTYuVV4	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'b':2 'localhost':3 'matrix':1 'messag':6 'third':5 'whatev':4	1673456470431	88
$CGChqoz8kvvahzTLr-uENaReKyq5KpqLrL1g9bePx2I	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'last':5 'matrix':1 'messag':4,6 'repli':3	1673456471204	92
$UHKKJIW-yVrjog2Pg_MR43oEkfSUhSVKiFGHGPbNaOU	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'delet':3 'mm':1	1673456484479	94
$_fc7lLRXoDsqiFKFvhlsSOsOE75ppMdi2ZRa-w_o0OY	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'first':3 'matrix':1,4,7 'messag':5,8 'second':6	1673456469260	84
$oXdn9vR9Yxd3FXZOxnZLiW-XByipCOWC32N6UNC7fCI	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'b':2 'matrix':1,3,6 'messag':7 'third':5	1673456469482	85
$krZXlGfGshKwkFJk6XwnR-gCOaeiC5p1Z6YZwNw6Tg0	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'messag':2 'root':1	1673456470681	89
$eY_eQCpyM7JAv11-157xBIO8c02XOKPAKO5-oLLkaMM	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'matrix':1 'messag':4,6 'repli':5 'root':3	1673456470815	90
$m8qqKQF7tvdc1qLDrWf1DjyHng9_F2Y0v_gzFRh6Kag	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'messag':2 'new':1	1673456473466	93
$Yis1BltcsgIBI_y81aVbrWa5qBJs3O4cjY7TtOnv3AU	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'delet':3 'matrix':1	1673456485049	96
$ABAs5n2LLFjtJj9U8vpXJZW4XssE1_1AOKq1Hht9rAc	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'messag':4 'pre':2 'pre-thread':1 'thread':3	1673456485528	98
$XhY61XTnLilEWT5TBmpjFvWg-ttI3HSyLVoLRUVNShI	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'first':1 'messag':2	1673456485756	99
$efNJ2_fNXgtmBlwuX0QfDBZLeNBnkF0bix0VF0AaBUc	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'first':5 'localhost':4 'mattermost':2 'messag':6,8 'mm':1 'second':7	1673456486014	100
$u2wX-H57z6LJIi2iBRq8--9YEHZj924d1XHR1tbNoTU	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'test':1	1673456842880	111
$dyDBJ0bfzPuc6VwuCR3A1Q2GNqb5JweFoRuLiNBdLgg	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'test2':1	1673456843196	112
$HtuzOrzcCN4JBQCmC2S0KmN-Sq3OXYHy41_xxL3VNE4	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'bold':2 'header':1	1673456843570	113
$uwxaXiusawT_bOeyGHwB7wfy4YVDUUpEs6A4YMBKfTg	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'messag':3 'random':1 'wrong':2	1673456843841	114
$GoX13j6N-LFoVwqTvDVdFkmlAMyOQncU-wyYccvSOnE	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'ab':26 'ad':12 'adipisci':14 'blanditii':25 'consequatur':32 'delen':24 'facili':6 'iur':19 'iusto':16 'magnam':2 'natus':1,13 'nequ':5 'nobi':8 'occaecati':17 'officii':27 'omni':4,18 'optio':31 'sapient':33 'sit':9 'totam':23 'und':21 'ut':15,22 'veritati':11 'vero':29,30 'vita':20 'voluptatem':10,28 'voluptatibus':7	1673457534765	115
$VcoB1_pk9tOinsmwdQJYShtIuSLosTj-jzPHDVJjEv8	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'test':1	1673457537295	116
$ORHWJnv40jDzKKISq_X3_aBTGHZZJqjFEVg1kUnrWQ4	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'filenam':1	1673457539688	117
$njvVCKYhRssX__fnFZ8owlNsOC9u3FRj0pmcqeIVVjI	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'filenam':1	1673457540893	118
$7SK-_DIPq2s374RTSr3as9S8GNyjBCDXOXK_ycMXc74	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'mydata':1	1673457542559	119
$0DBuAxDOgwokpytW0JkbbD3h3YNz3tiYsyJNZZqT6dM	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'hidden':1 'messag':2	1673457544763	120
$dbbS4HRWajCEFK63hUlDVeDwHbQPIAwiE7q2p34gr64	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'1080p':16 'anyth':10 'gb':17 'jerod_green@hotmail.com':20 'messag':2 'microchip':18 'need':12 'port':6 'program':4 'reboot':14 'seen':3 'strang':1 'won':7	1673458178331	121
$tJ-FG4LvyDPWWc02tnnNTzC6FW5jTNsJ4Q0Y3sswUwU	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'1673459346045':6 'check':1 'messag':3 'test':5	1673459348382	122
$P2m7f_ReTUYd4Csc5OKob_vf90ua2PMyuv0NqQqhyZs	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'1673459436577':6 'check':1 'messag':3 'test':5	1673459438277	123
$3DuuE2hHvtoVIEVkMMMOyVstiJ3B7k1t3FJ_ifxj4aw	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'work':4	1673633796953	124
$3_rhZk71KOig-uRX6JvtgQTiwiDNjWvrhDiK3CsG8Bc	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'work':4	1673634310952	125
$kFOWuoGosyBpmijZKeHjb49l9qG1PYd-7_Mz8m7TdZw	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'ok':1	1673634432823	126
$WVRAu1BgFM0v9p1pHq87lQjV3QNR3ftT3-zfVqOdjoE	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'one':2 'work':4	1673683517916	127
$GHt9inHBpvm4nrOPtbJHG8c8UlpzqeGJh_-OBG8ptHQ	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'tri':1	1673683910745	128
$yVvV-TsDoWvvUlnpW14wS1F-qAd-Vm9J-uj4cAsZykg	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'-12':3 '-24':4 '12.47.52.png':6 '2022':2 'kl':5 'skärmavbild':1	1673684119539	129
$W37bP5pDpEKfiUi_hzWhdjakNnPVlC7KgjnlsImT9os	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'-12':5 '-24':6 '12':8 '2022':4 'cowboy':13 'face':11 'hat':14 'kl':7 'localhost':2 'map':10 'nice':9 'skärmavbild':3 'user1':1	1673684215773	130
$2KYS5UbprMHWtKf1XE3EdQYt3jO__dF1wZsmNw0m7Po	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'cowboy':9 'face':7 'hat':10 'localhost':4 'map':6 'mattermost':2 'mm':1 'nice':5 'ok':11	1673684282569	131
$V_mgJvf-2J-ZWvd3_isj_ng3ED1Y3IR98ma44L3WQ4o	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'pleas':3 'repli':4	1673684356453	132
$WVroKTDWt83RCC4syxi_4hpsCXXPlQmrMVO527aD_bg	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'localhost':4 'mattermost':2 'mm':1 'pleas':7 'repli':8,10	1673684403770	133
$n5Sx_AizJGu6tfAlx-aQBr2gIQ6eFROdu41oBPH_EYk	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'interfac':15 'kenyatta.wolf14@hotmail.com':17 'messag':2 'mobil':6,14 'quantifi':12 'seen':3 'strang':1 'system':8 'tls':7 'use':4	1673685169914	134
$U_hhCm5TKVpLfccts8cldxQRA18VARaw6KqAREJosKQ	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'hi':1	1673688511510	135
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
$kHkn3X5sgQZbnc7m1GNs3FoN729sUsLsqASYxvh3Jb8	49
$cl-cBWQqCEUtQdjEqlQcE0PD7MCeX1R25oC5CKqb7oE	50
$8a8OTFPqvfsx2aHJeu9IBu-xR3Gn7rdv9l_HZtPKkFg	50
$BWMrEpKFpKKbBz5Ox9zTP3TvT5zyh6w3zhpl-epXhkk	49
$r3Ho1IsdJmJB13pD9yX-Jkg_a5s28kBCqoNZ5EPWwqM	49
$fQ28BQv7GUBcg_Ok7MCh8uTcQLoT2Tkr2BegUMhst1M	49
$S7qfuHyVNKlnX8WQb78EyVSR_7_dnmagLA8asozsQtE	62
$TOzcyxIV2S5U6CP15QCldRMJRaDz1Yaik15PorvZYGc	65
$Sa-w9Co29Yd94wHfPbpfCOuSSlMlorQ7ssiGXYp8oh8	68
$n6TBNMF739-W93vnPpWYiJ_zTj-UGsx8mCtkFUsmkrY	71
$5auMphtCZ9zvRqrhyXpY0s-cZZl2AbvkyGNRbm2h2zc	68
$Yb59onmhkHIpIJ_VnrP0V02pkFQEF1GwuJqZCNRTQeQ	68
$j0CTOXXA4AtSOD0pk6kL2BNsa6j5w517GGfkTqmm9ZE	68
$YgrzVCWDDxVv-dvf3HhpLD0QlN4nD5-CXg0T-gEX6iI	68
$IaI_j1zJZ04lmJmCzJfvnr48U2umqKYG1xogY-r9UNY	68
$TbIhAYsmySe2O7IaMBarYDokr6-UmyH4IYI3SpbhI-Q	71
$YBt0yFQdKC_886W6aXe4LIv5A5BcBP7pXYeF8XLKhH0	71
$-wkWlUVunP818RkFXsoACrEQ85-ybLTc-vWqiil50Vo	71
$kQPpv66TuseXeTXJr41QlqLnJBWNpBA_zgzIaJMjpLc	68
$BG2gCT3tXMWdl5AO704CVjroaQJysHmLZMRN-QrTH8w	71
$AXNJvl1CFFkmeDr63y2IykCN_G-lJiDa4JHsOjaUj4Y	71
$9hK3JsOVrMiv0wKjw57rMkc6mne_XmZ0CRTz65g97ek	71
$uFBLsg4RZn3DtG5dqcZ8A11zEbkWHwPLjk_VQtaj0qM	68
$wFcIkswyANl3CQZdt_hX9g9e2TeFjIzp9bWhcEbBiCI	68
$Y_FmFbCe62ffJ-UyN7IA1IbcRgUsELxe9lGLmGbDg9o	71
$CPoznAc0caDQuTVk0FlfLDWH79HumOVggLi7MDSYT5M	71
$pWJdSD5NsfN2PI0YapF9GmJPDpHhbeH6m--Uc5qoX-A	71
$zsvkWRGeOerm3Q5DPlTgr7kA7cM2-F0gXr40MUzknyc	68
$NSU5p_lrJEBTd3R6M_2_6ujF1CP9jw5z6-bDhTYxlzY	68
$35mlnbt-wcKTRY9cY7oyxyQbIoQPDLdRLHQQPGPVJzo	68
$bZPoJ2CteeROVbzJXAb_pwUfP2AIqhQn8X1nYN6cjRI	68
$EpI_As8tc8wuYQzlSbGEsxAOAAjphf1Wn48-zC2Pj68	68
$Q-2CPBoV3oTFZxGNkFMvNq26XugVjG2Cya0i5tuYeEg	71
$_k0ZpNW0oLpqiDqR7NJvZKdA2ZtHt_egRgLiFirmaYQ	71
$tWUlYx2qFNzpE_0CfMdKwbXSysRu-Z-uE0yWFp2GbGo	68
$Ip6vtDe80sOxCWnWoPVYYN-aqQ4AdGR-zO_krrdduFg	71
$9bNGuvT22oFV6Q8GFIzEZVofSbnyc61EIvnP8_3QqCE	68
$FhGz_XSQqkNt3u5faKV2p5k8gF47j_27y5RwVbtf3dk	68
$J2GCbFH7iG1fp5SNdsGmkmqFm59eqB_lJMGLY5yk1D8	68
$Dtmij3Zgur83VAr9O_P7MPtbPgUoMnnz_pOwemaro9I	68
$Y0__yZ70xH8p15Jr_yTtOJmrMCpaSJLwSo2cc1W4F6o	68
$gPWgeFNvAi1vMKPUzorqatfuOy4HXWKOwonBbcYhiN8	68
$Bh8N0WeVWl8koOcEkS8E0m4kulvHaq75oA0ou0aE8qs	68
$GgR_nTglOMJoS8SoJ-HFOS81y7cmJK64h0DeBVyFxkM	71
$_fc7lLRXoDsqiFKFvhlsSOsOE75ppMdi2ZRa-w_o0OY	71
$oXdn9vR9Yxd3FXZOxnZLiW-XByipCOWC32N6UNC7fCI	71
$sDESXFNHywZLVAjOAvBW4Qtv660_Xx9oVSAIUzZs5bA	68
$jnaBiJUcEka0drCdQFKBUWluWZq5S7dPNR3XCnWwx8g	68
$Hlu0oKcyD432dWmJ9w0xHm3PLMnH85Jn-X3GDTYuVV4	68
$krZXlGfGshKwkFJk6XwnR-gCOaeiC5p1Z6YZwNw6Tg0	71
$eY_eQCpyM7JAv11-157xBIO8c02XOKPAKO5-oLLkaMM	71
$vQGo7i4QMQ-SSBxBmQa7vPtet-fqNIosOIQOhXXoLwc	71
$CGChqoz8kvvahzTLr-uENaReKyq5KpqLrL1g9bePx2I	71
$m8qqKQF7tvdc1qLDrWf1DjyHng9_F2Y0v_gzFRh6Kag	68
$UHKKJIW-yVrjog2Pg_MR43oEkfSUhSVKiFGHGPbNaOU	68
$_64yupcz2_qLrKOWrT87_V-HWN64bsQaq1VhCZ_zRnE	68
$Yis1BltcsgIBI_y81aVbrWa5qBJs3O4cjY7TtOnv3AU	71
$3tVAg8SuDfjs9Fgkhfie7XW_PKyBUpsFLrnHYwASpBc	71
$ABAs5n2LLFjtJj9U8vpXJZW4XssE1_1AOKq1Hht9rAc	68
$XhY61XTnLilEWT5TBmpjFvWg-ttI3HSyLVoLRUVNShI	68
$efNJ2_fNXgtmBlwuX0QfDBZLeNBnkF0bix0VF0AaBUc	68
$Rx9kQ8hCx2y1bcLpdhzPqXHkrlExdX1yc3YshWnC6og	68
$hz_8OnlfAO5weTQ3Sy0cNJ83PP6UGxmBomiBKe4JB5w	68
$Op0TBQz5bRKUyxhUgvd0RMEbDt0BloR6y_aUatQJcO4	351
$KjxZjGyxoIyEvF0d6WjubIy5-PjQ8gTixRenqiw88iA	352
$ORHWJnv40jDzKKISq_X3_aBTGHZZJqjFEVg1kUnrWQ4	357
$zUomLm3mThwuYeUXH2UXzsuqxE6DQeH_95sT95psJag	353
$1c97W6vcISTaUEtVZ3XtpTvdbUxTp84W9UUnJ7yQ1hI	358
$XMPmaEvrP8Ebnl1P6-T-4JWR8Ms1HgLkboYib2Z0LAI	354
$8Lzt8KQPe0wAkuTOKq6BkdBqXu9LrnnsSyeYQ70hPDs	356
$7SK-_DIPq2s374RTSr3as9S8GNyjBCDXOXK_ycMXc74	358
$P2m7f_ReTUYd4Csc5OKob_vf90ua2PMyuv0NqQqhyZs	358
$sKC-AGmNhmjm9fAYYksybJgXr_tCsBeZrEAv6k7VTyk	355
$u2wX-H57z6LJIi2iBRq8--9YEHZj924d1XHR1tbNoTU	358
$GoX13j6N-LFoVwqTvDVdFkmlAMyOQncU-wyYccvSOnE	357
$njvVCKYhRssX__fnFZ8owlNsOC9u3FRj0pmcqeIVVjI	357
$9i3p0sl8iw-4rVjwMHJnTFujme1in4rnO1zkP9hPq8w	357
$dyDBJ0bfzPuc6VwuCR3A1Q2GNqb5JweFoRuLiNBdLgg	358
$HtuzOrzcCN4JBQCmC2S0KmN-Sq3OXYHy41_xxL3VNE4	358
$uwxaXiusawT_bOeyGHwB7wfy4YVDUUpEs6A4YMBKfTg	358
$VcoB1_pk9tOinsmwdQJYShtIuSLosTj-jzPHDVJjEv8	358
$0DBuAxDOgwokpytW0JkbbD3h3YNz3tiYsyJNZZqT6dM	357
$dbbS4HRWajCEFK63hUlDVeDwHbQPIAwiE7q2p34gr64	358
$tJ-FG4LvyDPWWc02tnnNTzC6FW5jTNsJ4Q0Y3sswUwU	358
$3DuuE2hHvtoVIEVkMMMOyVstiJ3B7k1t3FJ_ifxj4aw	357
$3_rhZk71KOig-uRX6JvtgQTiwiDNjWvrhDiK3CsG8Bc	357
$kFOWuoGosyBpmijZKeHjb49l9qG1PYd-7_Mz8m7TdZw	357
$WVRAu1BgFM0v9p1pHq87lQjV3QNR3ftT3-zfVqOdjoE	357
$GHt9inHBpvm4nrOPtbJHG8c8UlpzqeGJh_-OBG8ptHQ	357
$yVvV-TsDoWvvUlnpW14wS1F-qAd-Vm9J-uj4cAsZykg	357
$W37bP5pDpEKfiUi_hzWhdjakNnPVlC7KgjnlsImT9os	357
$2KYS5UbprMHWtKf1XE3EdQYt3jO__dF1wZsmNw0m7Po	357
$V_mgJvf-2J-ZWvd3_isj_ng3ED1Y3IR98ma44L3WQ4o	358
$WVroKTDWt83RCC4syxi_4hpsCXXPlQmrMVO527aD_bg	358
$n5Sx_AizJGu6tfAlx-aQBr2gIQ6eFROdu41oBPH_EYk	358
$U_hhCm5TKVpLfccts8cldxQRA18VARaw6KqAREJosKQ	358
\.


--
-- Data for Name: event_txn_id; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_txn_id (event_id, room_id, user_id, token_id, txn_id, inserted_ts) FROM stdin;
$WVRAu1BgFM0v9p1pHq87lQjV3QNR3ftT3-zfVqOdjoE	!dKcbdDATuwwphjRPQP:localhost	@user1:localhost	14	m1673683517767.0	1673683518018
$GHt9inHBpvm4nrOPtbJHG8c8UlpzqeGJh_-OBG8ptHQ	!dKcbdDATuwwphjRPQP:localhost	@user1:localhost	14	m1673683910615.1	1673683910896
$yVvV-TsDoWvvUlnpW14wS1F-qAd-Vm9J-uj4cAsZykg	!dKcbdDATuwwphjRPQP:localhost	@user1:localhost	14	m1673684119236.2	1673684119757
$2KYS5UbprMHWtKf1XE3EdQYt3jO__dF1wZsmNw0m7Po	!dKcbdDATuwwphjRPQP:localhost	@user1:localhost	14	m1673684282445.3	1673684282644
$WVroKTDWt83RCC4syxi_4hpsCXXPlQmrMVO527aD_bg	!kmbTYjjsDRDHGgVqUP:localhost	@user1:localhost	14	m1673684403527.4	1673684403909
$n5Sx_AizJGu6tfAlx-aQBr2gIQ6eFROdu41oBPH_EYk	!kmbTYjjsDRDHGgVqUP:localhost	@matrix_b:localhost	4	m.1673685169861	1673685169986
$U_hhCm5TKVpLfccts8cldxQRA18VARaw6KqAREJosKQ	!kmbTYjjsDRDHGgVqUP:localhost	@user1:localhost	14	m1673688511428.5	1673688511569
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
21	$kHkn3X5sgQZbnc7m1GNs3FoN729sUsLsqASYxvh3Jb8	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	21	1672918494139	1672918494204	@user1:localhost	f	master	40
19	$cl-cBWQqCEUtQdjEqlQcE0PD7MCeX1R25oC5CKqb7oE	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	19	1672918508427	1672918508472	@user1:localhost	f	master	41
20	$8a8OTFPqvfsx2aHJeu9IBu-xR3Gn7rdv9l_HZtPKkFg	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	20	1672920683485	1672920683531	@admin:localhost	f	master	42
22	$BWMrEpKFpKKbBz5Ox9zTP3TvT5zyh6w3zhpl-epXhkk	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	22	1672920816788	1672920816831	@admin:localhost	f	master	43
23	$r3Ho1IsdJmJB13pD9yX-Jkg_a5s28kBCqoNZ5EPWwqM	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	23	1672921550713	1672921550743	@matrix_b:localhost	f	master	44
24	$fQ28BQv7GUBcg_Ok7MCh8uTcQLoT2Tkr2BegUMhst1M	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	24	1672921603138	1672921603164	@matrix_b:localhost	f	master	45
22	$n6TBNMF739-W93vnPpWYiJ_zTj-UGsx8mCtkFUsmkrY	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	22	1672922249928	1672922250009	@mm_user1:localhost	f	master	49
23	$TbIhAYsmySe2O7IaMBarYDokr6-UmyH4IYI3SpbhI-Q	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	23	1672922654500	1672922654526	@mm_user1:localhost	f	master	55
25	$S7qfuHyVNKlnX8WQb78EyVSR_7_dnmagLA8asozsQtE	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	25	1672922249364	1672922249453	@matterbot:localhost	f	master	46
21	$TOzcyxIV2S5U6CP15QCldRMJRaDz1Yaik15PorvZYGc	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	21	1672922249479	1672922249596	@matterbot:localhost	f	master	47
26	$Sa-w9Co29Yd94wHfPbpfCOuSSlMlorQ7ssiGXYp8oh8	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	26	1672922249759	1672922249852	@mm_user1:localhost	f	master	48
27	$5auMphtCZ9zvRqrhyXpY0s-cZZl2AbvkyGNRbm2h2zc	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	27	1672922287761	1672922287799	@mm_user1:localhost	f	master	50
28	$Yb59onmhkHIpIJ_VnrP0V02pkFQEF1GwuJqZCNRTQeQ	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	28	1672922412287	1672922412359	@matrix_b:localhost	f	master	51
29	$j0CTOXXA4AtSOD0pk6kL2BNsa6j5w517GGfkTqmm9ZE	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	29	1672922547588	1672922547621	@mm_user1:localhost	f	master	52
30	$YgrzVCWDDxVv-dvf3HhpLD0QlN4nD5-CXg0T-gEX6iI	m.reaction	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	30	1672922566841	1672922566878	@user1:localhost	f	master	53
31	$IaI_j1zJZ04lmJmCzJfvnr48U2umqKYG1xogY-r9UNY	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	31	1672922600605	1672922600637	@user1:localhost	f	master	54
24	$YBt0yFQdKC_886W6aXe4LIv5A5BcBP7pXYeF8XLKhH0	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	24	1672922655109	1672922655131	@mm_user1:localhost	t	master	56
25	$-wkWlUVunP818RkFXsoACrEQ85-ybLTc-vWqiil50Vo	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	25	1672923027781	1672923027845	@mm_mattermost_a:localhost	f	master	57
32	$kQPpv66TuseXeTXJr41QlqLnJBWNpBA_zgzIaJMjpLc	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	32	1672923221916	1672923221954	@matrix_b:localhost	f	master	58
26	$BG2gCT3tXMWdl5AO704CVjroaQJysHmLZMRN-QrTH8w	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	26	1673367066720	1673367066793	@matrix_a:localhost	f	master	59
27	$AXNJvl1CFFkmeDr63y2IykCN_G-lJiDa4JHsOjaUj4Y	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	27	1673367091822	1673367091862	@matrix_a:localhost	f	master	60
28	$9hK3JsOVrMiv0wKjw57rMkc6mne_XmZ0CRTz65g97ek	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	28	1673367607062	1673367607094	@matrix_a:localhost	f	master	61
33	$uFBLsg4RZn3DtG5dqcZ8A11zEbkWHwPLjk_VQtaj0qM	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	33	1673367804476	1673367804515	@mm_mattermost_a:localhost	f	master	62
34	$wFcIkswyANl3CQZdt_hX9g9e2TeFjIzp9bWhcEbBiCI	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	34	1673367882756	1673367882785	@mm_mattermost_a:localhost	f	master	63
29	$Y_FmFbCe62ffJ-UyN7IA1IbcRgUsELxe9lGLmGbDg9o	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	29	1673367937094	1673367937130	@matrix_a:localhost	f	master	64
30	$CPoznAc0caDQuTVk0FlfLDWH79HumOVggLi7MDSYT5M	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	30	1673367937228	1673367937268	@matrix_b:localhost	f	master	65
31	$pWJdSD5NsfN2PI0YapF9GmJPDpHhbeH6m--Uc5qoX-A	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	31	1673367937356	1673367937391	@matrix_a:localhost	f	master	66
35	$zsvkWRGeOerm3Q5DPlTgr7kA7cM2-F0gXr40MUzknyc	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	35	1673456419304	1673456419366	@mm_mattermost_a:localhost	f	master	67
36	$NSU5p_lrJEBTd3R6M_2_6ujF1CP9jw5z6-bDhTYxlzY	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	36	1673456422195	1673456422399	@matrix_a:localhost	f	master	68
37	$35mlnbt-wcKTRY9cY7oyxyQbIoQPDLdRLHQQPGPVJzo	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	37	1673456423178	1673456423302	@mm_mattermost_a:localhost	f	master	69
38	$bZPoJ2CteeROVbzJXAb_pwUfP2AIqhQn8X1nYN6cjRI	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	38	1673456424045	1673456424128	@matrix_b:localhost	f	master	70
39	$EpI_As8tc8wuYQzlSbGEsxAOAAjphf1Wn48-zC2Pj68	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	39	1673456424470	1673456424503	@matrix_a:localhost	f	master	71
32	$Q-2CPBoV3oTFZxGNkFMvNq26XugVjG2Cya0i5tuYeEg	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	32	1673456424779	1673456424823	@mm_mattermost_b:localhost	f	master	72
33	$_k0ZpNW0oLpqiDqR7NJvZKdA2ZtHt_egRgLiFirmaYQ	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	33	1673456425021	1673456425072	@mm_mattermost_b:localhost	t	master	73
40	$tWUlYx2qFNzpE_0CfMdKwbXSysRu-Z-uE0yWFp2GbGo	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	40	1673456425374	1673456425427	@matrix_a:localhost	t	master	74
34	$Ip6vtDe80sOxCWnWoPVYYN-aqQ4AdGR-zO_krrdduFg	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	34	1673456425739	1673456425758	@matrix_a:localhost	f	master	75
41	$9bNGuvT22oFV6Q8GFIzEZVofSbnyc61EIvnP8_3QqCE	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	41	1673456445206	1673456445235	@mm_mattermost_a:localhost	f	master	76
42	$FhGz_XSQqkNt3u5faKV2p5k8gF47j_27y5RwVbtf3dk	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	42	1673456445512	1673456445540	@matrix_a:localhost	f	master	77
43	$J2GCbFH7iG1fp5SNdsGmkmqFm59eqB_lJMGLY5yk1D8	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	43	1673456445810	1673456445837	@mm_mattermost_a:localhost	f	master	78
44	$Dtmij3Zgur83VAr9O_P7MPtbPgUoMnnz_pOwemaro9I	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	44	1673456446033	1673456446059	@matrix_b:localhost	f	master	79
45	$Y0__yZ70xH8p15Jr_yTtOJmrMCpaSJLwSo2cc1W4F6o	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	45	1673456468128	1673456468222	@mm_mattermost_a:localhost	f	master	80
46	$gPWgeFNvAi1vMKPUzorqatfuOy4HXWKOwonBbcYhiN8	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	46	1673456468733	1673456468765	@mm_mattermost_b:localhost	f	master	81
47	$Bh8N0WeVWl8koOcEkS8E0m4kulvHaq75oA0ou0aE8qs	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	47	1673456468901	1673456468942	@mm_mattermost_a:localhost	f	master	82
35	$GgR_nTglOMJoS8SoJ-HFOS81y7cmJK64h0DeBVyFxkM	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	35	1673456469150	1673456469173	@matrix_a:localhost	f	master	83
48	$sDESXFNHywZLVAjOAvBW4Qtv660_Xx9oVSAIUzZs5bA	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	48	1673456469844	1673456469869	@mm_mattermost_a:localhost	f	master	86
50	$Hlu0oKcyD432dWmJ9w0xHm3PLMnH85Jn-X3GDTYuVV4	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	50	1673456470431	1673456470455	@mm_mattermost_a:localhost	f	master	88
41	$CGChqoz8kvvahzTLr-uENaReKyq5KpqLrL1g9bePx2I	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	41	1673456471204	1673456471323	@matrix_a:localhost	f	master	92
52	$UHKKJIW-yVrjog2Pg_MR43oEkfSUhSVKiFGHGPbNaOU	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	52	1673456484479	1673456484504	@mm_mattermost_a:localhost	f	master	94
53	$_64yupcz2_qLrKOWrT87_V-HWN64bsQaq1VhCZ_zRnE	m.room.redaction	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	53	1673456484815	1673456484854	@matterbot:localhost	f	master	95
60	$XMPmaEvrP8Ebnl1P6-T-4JWR8Ms1HgLkboYib2Z0LAI	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	60	1673456497755	1673456497804	@mm_mattermost_b:localhost	f	master	106
61	$8Lzt8KQPe0wAkuTOKq6BkdBqXu9LrnnsSyeYQ70hPDs	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	61	1673456498102	1673456498197	@matrix_b:localhost	f	master	108
68	$7SK-_DIPq2s374RTSr3as9S8GNyjBCDXOXK_ycMXc74	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	68	1673457542559	1673457542792	@matrix_a:localhost	t	master	119
71	$P2m7f_ReTUYd4Csc5OKob_vf90ua2PMyuv0NqQqhyZs	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	71	1673459438277	1673459438360	@user1:localhost	f	master	123
36	$_fc7lLRXoDsqiFKFvhlsSOsOE75ppMdi2ZRa-w_o0OY	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	36	1673456469260	1673456469333	@matrix_b:localhost	f	master	84
37	$oXdn9vR9Yxd3FXZOxnZLiW-XByipCOWC32N6UNC7fCI	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	37	1673456469482	1673456469548	@matrix_a:localhost	f	master	85
69	$dbbS4HRWajCEFK63hUlDVeDwHbQPIAwiE7q2p34gr64	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	69	1673458178331	1673458178356	@matrix_b:localhost	f	master	121
49	$jnaBiJUcEka0drCdQFKBUWluWZq5S7dPNR3XCnWwx8g	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	49	1673456470100	1673456470130	@matrix_b:localhost	f	master	87
38	$krZXlGfGshKwkFJk6XwnR-gCOaeiC5p1Z6YZwNw6Tg0	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	38	1673456470681	1673456470716	@matrix_a:localhost	f	master	89
39	$eY_eQCpyM7JAv11-157xBIO8c02XOKPAKO5-oLLkaMM	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	39	1673456470815	1673456470885	@matrix_a:localhost	f	master	90
40	$vQGo7i4QMQ-SSBxBmQa7vPtet-fqNIosOIQOhXXoLwc	m.room.redaction	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	40	1673456470956	1673456471048	@matrix_a:localhost	f	master	91
51	$m8qqKQF7tvdc1qLDrWf1DjyHng9_F2Y0v_gzFRh6Kag	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	51	1673456473466	1673456473489	@mm_mattermost_a:localhost	f	master	93
42	$Yis1BltcsgIBI_y81aVbrWa5qBJs3O4cjY7TtOnv3AU	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	42	1673456485049	1673456485072	@matrix_a:localhost	f	master	96
45	$zUomLm3mThwuYeUXH2UXzsuqxE6DQeH_95sT95psJag	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	45	1673456497621	1673456497649	@mm_mattermost_b:localhost	f	master	105
46	$sKC-AGmNhmjm9fAYYksybJgXr_tCsBeZrEAv6k7VTyk	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	46	1673456497972	1673456498000	@matrix_b:localhost	f	master	107
62	$1c97W6vcISTaUEtVZ3XtpTvdbUxTp84W9UUnJ7yQ1hI	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	62	1673456498578	1673456498665	@matrix_b:localhost	f	master	110
63	$u2wX-H57z6LJIi2iBRq8--9YEHZj924d1XHR1tbNoTU	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	63	1673456842880	1673456842941	@mm_mattermost_a:localhost	f	master	111
48	$GoX13j6N-LFoVwqTvDVdFkmlAMyOQncU-wyYccvSOnE	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	48	1673457534765	1673457534973	@mm_mattermost_a:localhost	f	master	115
50	$njvVCKYhRssX__fnFZ8owlNsOC9u3FRj0pmcqeIVVjI	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	50	1673457540893	1673457540930	@mm_mattermost_b:localhost	t	master	118
43	$3tVAg8SuDfjs9Fgkhfie7XW_PKyBUpsFLrnHYwASpBc	m.room.redaction	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	43	1673456485255	1673456485286	@matrix_a:localhost	f	master	97
54	$ABAs5n2LLFjtJj9U8vpXJZW4XssE1_1AOKq1Hht9rAc	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	54	1673456485528	1673456485607	@mm_mattermost_a:localhost	f	master	98
55	$XhY61XTnLilEWT5TBmpjFvWg-ttI3HSyLVoLRUVNShI	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	55	1673456485756	1673456485785	@mm_mattermost_a:localhost	f	master	99
56	$efNJ2_fNXgtmBlwuX0QfDBZLeNBnkF0bix0VF0AaBUc	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	56	1673456486014	1673456486072	@mm_mattermost_a:localhost	f	master	100
57	$Rx9kQ8hCx2y1bcLpdhzPqXHkrlExdX1yc3YshWnC6og	m.room.redaction	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	57	1673456486424	1673456486440	@matterbot:localhost	f	master	101
58	$hz_8OnlfAO5weTQ3Sy0cNJ83PP6UGxmBomiBKe4JB5w	m.room.redaction	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	58	1673456486509	1673456486552	@matterbot:localhost	f	master	102
44	$Op0TBQz5bRKUyxhUgvd0RMEbDt0BloR6y_aUatQJcO4	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	44	1673456497209	1673456497242	@mm_mattermost_b:localhost	f	master	103
59	$KjxZjGyxoIyEvF0d6WjubIy5-PjQ8gTixRenqiw88iA	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	59	1673456497350	1673456497375	@mm_mattermost_b:localhost	f	master	104
66	$uwxaXiusawT_bOeyGHwB7wfy4YVDUUpEs6A4YMBKfTg	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	66	1673456843841	1673456843870	@matrix_b:localhost	f	master	114
67	$VcoB1_pk9tOinsmwdQJYShtIuSLosTj-jzPHDVJjEv8	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	67	1673457537295	1673457537352	@matrix_a:localhost	f	master	116
49	$ORHWJnv40jDzKKISq_X3_aBTGHZZJqjFEVg1kUnrWQ4	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	49	1673457539688	1673457539923	@mm_mattermost_b:localhost	f	master	117
51	$0DBuAxDOgwokpytW0JkbbD3h3YNz3tiYsyJNZZqT6dM	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	51	1673457544763	1673457544839	@matrix_a:localhost	f	master	120
47	$9i3p0sl8iw-4rVjwMHJnTFujme1in4rnO1zkP9hPq8w	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	47	1673456498429	1673456498463	@matrix_b:localhost	f	master	109
64	$dyDBJ0bfzPuc6VwuCR3A1Q2GNqb5JweFoRuLiNBdLgg	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	64	1673456843196	1673456843230	@matrix_a:localhost	f	master	112
65	$HtuzOrzcCN4JBQCmC2S0KmN-Sq3OXYHy41_xxL3VNE4	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	65	1673456843570	1673456843607	@mm_mattermost_a:localhost	f	master	113
70	$tJ-FG4LvyDPWWc02tnnNTzC6FW5jTNsJ4Q0Y3sswUwU	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	70	1673459348382	1673459348468	@user1:localhost	f	master	122
52	$3DuuE2hHvtoVIEVkMMMOyVstiJ3B7k1t3FJ_ifxj4aw	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	52	1673633796953	1673633797006	@user1:localhost	f	master	124
53	$3_rhZk71KOig-uRX6JvtgQTiwiDNjWvrhDiK3CsG8Bc	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	53	1673634310952	1673634311037	@user1:localhost	f	master	125
54	$kFOWuoGosyBpmijZKeHjb49l9qG1PYd-7_Mz8m7TdZw	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	54	1673634432823	1673634432864	@user1:localhost	f	master	126
55	$WVRAu1BgFM0v9p1pHq87lQjV3QNR3ftT3-zfVqOdjoE	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	55	1673683517916	1673683518015	@user1:localhost	f	master	127
56	$GHt9inHBpvm4nrOPtbJHG8c8UlpzqeGJh_-OBG8ptHQ	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	56	1673683910745	1673683910891	@user1:localhost	f	master	128
57	$yVvV-TsDoWvvUlnpW14wS1F-qAd-Vm9J-uj4cAsZykg	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	57	1673684119539	1673684119754	@user1:localhost	t	master	129
58	$W37bP5pDpEKfiUi_hzWhdjakNnPVlC7KgjnlsImT9os	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	58	1673684215773	1673684215835	@mm_mattermost_a:localhost	f	master	130
59	$2KYS5UbprMHWtKf1XE3EdQYt3jO__dF1wZsmNw0m7Po	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	59	1673684282569	1673684282640	@user1:localhost	f	master	131
72	$V_mgJvf-2J-ZWvd3_isj_ng3ED1Y3IR98ma44L3WQ4o	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	72	1673684356453	1673684356514	@mm_mattermost_a:localhost	f	master	132
73	$WVroKTDWt83RCC4syxi_4hpsCXXPlQmrMVO527aD_bg	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	73	1673684403770	1673684403904	@user1:localhost	f	master	133
74	$n5Sx_AizJGu6tfAlx-aQBr2gIQ6eFROdu41oBPH_EYk	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	74	1673685169914	1673685169981	@matrix_b:localhost	f	master	134
75	$U_hhCm5TKVpLfccts8cldxQRA18VARaw6KqAREJosKQ	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	75	1673688511510	1673688511568	@user1:localhost	f	master	135
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
events	135	master
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
!kmbTYjjsDRDHGgVqUP:localhost	@ignored_user:localhost	$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	join
!dKcbdDATuwwphjRPQP:localhost	@ignored_user:localhost	$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A	join
!dKcbdDATuwwphjRPQP:localhost	@matterbot:localhost	$mGK5pQEzegKFhAPXc0TX7drNl2qyJL8ajxnJRmA3kN8	join
!kmbTYjjsDRDHGgVqUP:localhost	@matterbot:localhost	$666ybhBdzZc96KCxYMslNrmlLRi8w6uUusi8J4BUVNM	join
!dKcbdDATuwwphjRPQP:localhost	@mm_mattermost_a:localhost	$CPrx1EOiKU0xFQBY1-CbMIp4Nx64vw33awql9URc-is	join
!kmbTYjjsDRDHGgVqUP:localhost	@mm_mattermost_a:localhost	$FiPh76BhP5tT1Hors997MJgDvrehT02uvfmqsY25ilk	join
!kmbTYjjsDRDHGgVqUP:localhost	@user1:localhost	$kHkn3X5sgQZbnc7m1GNs3FoN729sUsLsqASYxvh3Jb8	join
!dKcbdDATuwwphjRPQP:localhost	@user1:localhost	$cl-cBWQqCEUtQdjEqlQcE0PD7MCeX1R25oC5CKqb7oE	join
!kmbTYjjsDRDHGgVqUP:localhost	@mm_user1:localhost	$Sa-w9Co29Yd94wHfPbpfCOuSSlMlorQ7ssiGXYp8oh8	join
!dKcbdDATuwwphjRPQP:localhost	@mm_user1:localhost	$n6TBNMF739-W93vnPpWYiJ_zTj-UGsx8mCtkFUsmkrY	join
!dKcbdDATuwwphjRPQP:localhost	@mm_mattermost_b:localhost	$zUomLm3mThwuYeUXH2UXzsuqxE6DQeH_95sT95psJag	join
!kmbTYjjsDRDHGgVqUP:localhost	@mm_mattermost_b:localhost	$XMPmaEvrP8Ebnl1P6-T-4JWR8Ms1HgLkboYib2Z0LAI	join
!dKcbdDATuwwphjRPQP:localhost	@matrix_b:localhost	$9i3p0sl8iw-4rVjwMHJnTFujme1in4rnO1zkP9hPq8w	join
!kmbTYjjsDRDHGgVqUP:localhost	@matrix_b:localhost	$1c97W6vcISTaUEtVZ3XtpTvdbUxTp84W9UUnJ7yQ1hI	join
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
EkoNzWJIOlmjsKFCPAwGWxjd	application/octet-stream	11	1673456424965	filename	@mm_mattermost_b:localhost	\N	\N	1673456445356	f
oJfyxvQeKlYvbgZBUnuypzXc	text/plain	8	1673456425329	mydata	@matrix_a:localhost	\N	\N	1673456445356	f
riXoaRqUQVaJbMHbhxJcKwHB	image/png	172914	1672922654767	Testing_in_VS_Code.png	@mm_user1:localhost	\N	\N	1673457045358	f
uYoKGLTJtbUlbloZKqxWZTvr	application/octet-stream	11	1673457540461	filename	@mm_mattermost_b:localhost	\N	\N	1673457585357	f
subBjguJAvrMNdPHjdiMQXfT	text/plain	8	1673457542348	mydata	@matrix_a:localhost	\N	\N	1673457585357	f
jbAAwecIXZRYlqNzQrBjriVH	image/png	63980	1673684117895	\N	@user1:localhost	\N	\N	\N	f
KfJoSGSBddxVlqlydVPwLNez	image/png	230773	1673684118255	Ska%CC%88rmavbild%202022-12-24%20kl.%2012.47.52.png	@user1:localhost	\N	\N	1673684147311	f
\.


--
-- Data for Name: local_media_repository_thumbnails; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.local_media_repository_thumbnails (media_id, thumbnail_width, thumbnail_height, thumbnail_type, thumbnail_method, thumbnail_length) FROM stdin;
riXoaRqUQVaJbMHbhxJcKwHB	32	32	image/png	crop	4942
riXoaRqUQVaJbMHbhxJcKwHB	96	96	image/png	crop	14985
riXoaRqUQVaJbMHbhxJcKwHB	320	171	image/png	scale	59178
riXoaRqUQVaJbMHbhxJcKwHB	640	343	image/png	scale	162554
riXoaRqUQVaJbMHbhxJcKwHB	800	429	image/png	scale	220318
jbAAwecIXZRYlqNzQrBjriVH	32	32	image/png	crop	824
jbAAwecIXZRYlqNzQrBjriVH	96	96	image/png	crop	3898
jbAAwecIXZRYlqNzQrBjriVH	320	152	image/png	scale	19757
jbAAwecIXZRYlqNzQrBjriVH	640	305	image/png	scale	51626
jbAAwecIXZRYlqNzQrBjriVH	800	382	image/png	scale	59370
KfJoSGSBddxVlqlydVPwLNez	32	32	image/png	crop	4080
KfJoSGSBddxVlqlydVPwLNez	96	96	image/png	crop	7221
KfJoSGSBddxVlqlydVPwLNez	320	152	image/png	scale	23234
KfJoSGSBddxVlqlydVPwLNez	640	305	image/png	scale	53158
KfJoSGSBddxVlqlydVPwLNez	800	382	image/png	scale	67293
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
98	@mm_user1:localhost	offline	1672922655202	1672922649578	0	\N	f	master
181	@mm_mattermost_b:localhost	offline	1673457541321	1673457539953	0	\N	f	master
182	@matrix_a:localhost	offline	1673457545085	1673457537542	0	\N	f	master
185	@admin:localhost	offline	1673457541439	1673457590259	1673457542126	\N	t	master
384	@user1:localhost	online	1673697104121	1673695824370	1673697104122	\N	t	master
285	@mm_mattermost_a:localhost	offline	1673684356660	1673684338389	0	\N	f	master
302	@matrix_b:localhost	offline	1673685170088	1673685170088	0	\N	f	master
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.profiles (user_id, displayname, avatar_url) FROM stdin;
admin	Admin User	\N
matrix_a	Matrix UserA	\N
ignored_user	ignored_user	\N
matterbot	Mattermost Bridge	\N
user2	User 2	\N
user1	User 1	\N
matrix_b	\N	\N
mm_user1	user1 [mm]	\N
mm_mattermost_b	mattermost_b [mm]	\N
mm_mattermost_a	MattermostUser A [mm]	\N
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
!dKcbdDATuwwphjRPQP:localhost	m.read	@user1:localhost	["$W37bP5pDpEKfiUi_hzWhdjakNnPVlC7KgjnlsImT9os"]	{"ts":1673684220097,"hidden":false}
!kmbTYjjsDRDHGgVqUP:localhost	m.read	@user1:localhost	["$n5Sx_AizJGu6tfAlx-aQBr2gIQ6eFROdu41oBPH_EYk"]	{"ts":1673685201838,"hidden":false}
\.


--
-- Data for Name: receipts_linearized; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.receipts_linearized (stream_id, room_id, receipt_type, user_id, event_id, data, instance_name) FROM stdin;
16	!dKcbdDATuwwphjRPQP:localhost	m.read	@user1:localhost	$W37bP5pDpEKfiUi_hzWhdjakNnPVlC7KgjnlsImT9os	{"ts":1673684220097,"hidden":false}	\N
18	!kmbTYjjsDRDHGgVqUP:localhost	m.read	@user1:localhost	$n5Sx_AizJGu6tfAlx-aQBr2gIQ6eFROdu41oBPH_EYk	{"ts":1673685201838,"hidden":false}	\N
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
$vQGo7i4QMQ-SSBxBmQa7vPtet-fqNIosOIQOhXXoLwc	$krZXlGfGshKwkFJk6XwnR-gCOaeiC5p1Z6YZwNw6Tg0	f	1673456471077
$_64yupcz2_qLrKOWrT87_V-HWN64bsQaq1VhCZ_zRnE	$UHKKJIW-yVrjog2Pg_MR43oEkfSUhSVKiFGHGPbNaOU	f	1673456484862
$3tVAg8SuDfjs9Fgkhfie7XW_PKyBUpsFLrnHYwASpBc	$Yis1BltcsgIBI_y81aVbrWa5qBJs3O4cjY7TtOnv3AU	f	1673456485296
$Rx9kQ8hCx2y1bcLpdhzPqXHkrlExdX1yc3YshWnC6og	$XhY61XTnLilEWT5TBmpjFvWg-ttI3HSyLVoLRUVNShI	f	1673456486447
$hz_8OnlfAO5weTQ3Sy0cNJ83PP6UGxmBomiBKe4JB5w	$efNJ2_fNXgtmBlwuX0QfDBZLeNBnkF0bix0VF0AaBUc	f	1673456486570
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
@user1:localhost	!kmbTYjjsDRDHGgVqUP:localhost	m.fully_read	44	{"event_id":"$uFBLsg4RZn3DtG5dqcZ8A11zEbkWHwPLjk_VQtaj0qM"}	\N
@user1:localhost	!dKcbdDATuwwphjRPQP:localhost	m.fully_read	59	{"event_id":"$2KYS5UbprMHWtKf1XE3EdQYt3jO__dF1wZsmNw0m7Po"}	\N
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
$kHkn3X5sgQZbnc7m1GNs3FoN729sUsLsqASYxvh3Jb8	@user1:localhost	@user1:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	User 1	\N
$cl-cBWQqCEUtQdjEqlQcE0PD7MCeX1R25oC5CKqb7oE	@user1:localhost	@user1:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	User 1	\N
$S7qfuHyVNKlnX8WQb78EyVSR_7_dnmagLA8asozsQtE	@mm_user1:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	invite	0	user1 [mm]	\N
$TOzcyxIV2S5U6CP15QCldRMJRaDz1Yaik15PorvZYGc	@mm_user1:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	invite	0	user1 [mm]	\N
$Sa-w9Co29Yd94wHfPbpfCOuSSlMlorQ7ssiGXYp8oh8	@mm_user1:localhost	@mm_user1:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	user1 [mm]	\N
$n6TBNMF739-W93vnPpWYiJ_zTj-UGsx8mCtkFUsmkrY	@mm_user1:localhost	@mm_user1:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	user1 [mm]	\N
$Op0TBQz5bRKUyxhUgvd0RMEbDt0BloR6y_aUatQJcO4	@mm_mattermost_b:localhost	@mm_mattermost_b:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	MMTest Last [mm]	\N
$KjxZjGyxoIyEvF0d6WjubIy5-PjQ8gTixRenqiw88iA	@mm_mattermost_b:localhost	@mm_mattermost_b:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	MMTest Last [mm]	\N
$zUomLm3mThwuYeUXH2UXzsuqxE6DQeH_95sT95psJag	@mm_mattermost_b:localhost	@mm_mattermost_b:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	mattermost_b [mm]	\N
$XMPmaEvrP8Ebnl1P6-T-4JWR8Ms1HgLkboYib2Z0LAI	@mm_mattermost_b:localhost	@mm_mattermost_b:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	mattermost_b [mm]	\N
$sKC-AGmNhmjm9fAYYksybJgXr_tCsBeZrEAv6k7VTyk	@matrix_b:localhost	@matrix_b:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	Hello World	\N
$8Lzt8KQPe0wAkuTOKq6BkdBqXu9LrnnsSyeYQ70hPDs	@matrix_b:localhost	@matrix_b:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	Hello World	\N
$9i3p0sl8iw-4rVjwMHJnTFujme1in4rnO1zkP9hPq8w	@matrix_b:localhost	@matrix_b:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	\N	\N
$1c97W6vcISTaUEtVZ3XtpTvdbUxTp84W9UUnJ7yQ1hI	@matrix_b:localhost	@matrix_b:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	\N	\N
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
!dKcbdDATuwwphjRPQP:localhost	14	9	0	0	0	9	109	0
!kmbTYjjsDRDHGgVqUP:localhost	14	9	0	0	0	9	110	0
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
!dKcbdDATuwwphjRPQP:localhost	t	@admin:localhost	5	t
!kmbTYjjsDRDHGgVqUP:localhost	t	@admin:localhost	5	t
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
$kHkn3X5sgQZbnc7m1GNs3FoN729sUsLsqASYxvh3Jb8	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@user1:localhost	\N
$cl-cBWQqCEUtQdjEqlQcE0PD7MCeX1R25oC5CKqb7oE	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@user1:localhost	\N
$S7qfuHyVNKlnX8WQb78EyVSR_7_dnmagLA8asozsQtE	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	\N
$TOzcyxIV2S5U6CP15QCldRMJRaDz1Yaik15PorvZYGc	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	\N
$Sa-w9Co29Yd94wHfPbpfCOuSSlMlorQ7ssiGXYp8oh8	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	\N
$n6TBNMF739-W93vnPpWYiJ_zTj-UGsx8mCtkFUsmkrY	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	\N
$Op0TBQz5bRKUyxhUgvd0RMEbDt0BloR6y_aUatQJcO4	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$KjxZjGyxoIyEvF0d6WjubIy5-PjQ8gTixRenqiw88iA	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$zUomLm3mThwuYeUXH2UXzsuqxE6DQeH_95sT95psJag	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$XMPmaEvrP8Ebnl1P6-T-4JWR8Ms1HgLkboYib2Z0LAI	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$sKC-AGmNhmjm9fAYYksybJgXr_tCsBeZrEAv6k7VTyk	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_b:localhost	\N
$8Lzt8KQPe0wAkuTOKq6BkdBqXu9LrnnsSyeYQ70hPDs	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_b:localhost	\N
$9i3p0sl8iw-4rVjwMHJnTFujme1in4rnO1zkP9hPq8w	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_b:localhost	\N
$1c97W6vcISTaUEtVZ3XtpTvdbUxTp84W9UUnJ7yQ1hI	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_b:localhost	\N
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
49	30
50	29
51	50
52	50
53	49
54	50
55	49
56	49
57	50
58	49
59	49
60	49
61	49
62	49
63	50
64	50
65	50
66	62
67	62
68	62
69	65
70	65
71	65
72	71
73	71
74	71
75	68
76	71
77	68
78	71
79	68
80	71
81	71
82	68
83	68
84	71
85	68
86	71
87	71
88	68
89	68
90	71
91	68
92	71
93	68
94	71
95	71
97	71
96	68
98	71
99	68
100	68
101	68
102	71
104	71
103	68
106	71
105	68
107	71
108	68
109	68
110	71
111	71
112	68
113	71
114	68
115	68
116	71
118	71
117	68
119	68
120	71
121	68
122	68
123	71
124	68
125	71
126	68
127	71
128	68
129	68
130	71
131	68
132	71
133	68
134	68
135	68
136	71
137	68
138	71
139	71
140	71
141	71
142	71
144	71
143	68
145	68
146	71
147	71
148	71
149	68
151	71
150	68
152	71
153	68
154	71
155	68
156	71
157	68
158	71
159	68
160	68
161	71
162	68
163	68
164	71
165	68
166	71
167	68
168	71
169	71
170	68
171	71
172	68
173	71
174	71
175	71
176	68
177	71
178	68
179	71
180	68
181	68
182	71
183	68
184	71
185	71
186	71
187	71
188	68
189	71
210	71
222	68
227	71
230	71
231	68
237	71
190	68
191	68
193	68
196	68
197	71
201	68
203	68
206	68
207	71
211	71
212	71
214	68
215	71
216	68
218	68
220	68
221	71
223	71
226	71
228	68
229	68
234	68
235	71
242	68
243	71
192	68
194	68
198	68
202	71
224	68
225	71
232	71
239	71
195	71
205	71
213	71
217	71
219	71
233	71
238	68
240	68
241	71
245	68
199	68
200	71
204	68
208	68
209	68
236	68
244	68
246	68
247	68
248	71
249	71
250	68
251	71
252	71
253	68
254	71
255	68
256	71
257	68
258	68
259	71
260	71
262	68
261	71
263	68
264	71
265	68
266	71
267	71
268	68
269	68
270	71
271	68
272	68
273	68
274	71
275	71
276	68
277	68
278	71
279	68
280	71
281	68
282	68
283	71
284	68
285	71
286	68
287	68
288	71
289	71
290	68
291	71
292	68
294	68
293	71
295	71
296	68
297	71
298	71
299	71
300	68
301	71
302	68
303	68
304	71
305	71
306	68
307	68
308	68
309	71
310	71
311	68
312	71
314	68
313	71
315	68
316	71
317	68
318	71
319	68
320	71
321	68
323	71
322	68
324	71
325	68
326	71
327	71
328	68
329	68
330	71
331	68
332	71
333	68
334	68
335	71
336	71
337	68
338	71
339	68
340	71
341	71
342	68
343	71
344	68
345	71
346	68
347	68
348	71
349	68
350	71
351	71
352	68
353	351
354	352
355	353
356	354
357	355
358	356
360	357
359	358
361	357
362	358
363	358
364	357
365	358
366	358
367	358
368	357
369	358
370	358
371	358
372	357
373	358
374	357
375	358
376	357
377	358
378	357
379	358
380	357
381	357
382	357
383	357
384	357
385	358
386	357
387	358
388	358
389	357
390	357
391	358
392	357
393	358
394	358
396	357
395	358
397	357
399	358
398	357
400	357
401	358
402	357
403	358
404	357
405	358
406	357
408	358
407	357
409	358
410	357
411	358
412	357
413	358
414	358
415	357
416	357
417	358
418	358
419	357
420	358
421	357
422	358
423	357
424	358
425	358
426	357
427	358
428	357
429	358
430	358
431	357
432	358
433	357
434	358
435	357
436	358
437	357
438	357
439	357
440	357
441	358
442	358
443	357
444	357
445	358
446	357
447	357
448	358
449	358
450	357
451	358
452	358
453	357
454	358
455	358
456	358
457	357
458	358
459	358
460	357
461	358
462	357
463	357
464	357
465	357
466	358
467	357
468	358
469	357
470	357
471	358
472	358
473	357
474	357
475	358
476	357
477	358
478	357
479	358
480	357
481	358
482	357
483	358
484	357
485	358
486	358
487	357
488	358
489	357
490	358
491	357
493	358
492	357
494	358
495	357
496	358
497	358
498	357
499	358
500	358
501	358
502	358
503	357
504	358
505	358
506	357
507	358
508	357
509	358
510	358
511	357
512	357
513	357
514	357
515	357
516	357
517	357
518	358
519	357
520	358
521	357
522	357
523	357
524	358
525	357
526	357
527	358
528	357
529	357
530	357
531	358
532	357
533	358
534	357
535	358
536	357
537	358
538	357
539	358
540	358
541	358
542	358
543	358
544	358
545	357
546	358
547	357
548	358
549	358
550	357
551	358
553	357
552	358
554	357
555	358
556	357
557	357
558	357
568	357
570	357
574	357
577	357
579	357
583	357
590	358
591	357
592	358
594	358
559	358
562	358
566	357
575	358
581	357
593	358
560	358
564	358
567	358
576	357
588	358
561	357
563	357
565	357
580	357
587	357
569	358
571	358
572	358
578	358
582	358
584	358
586	358
589	357
573	357
585	357
595	358
596	358
597	357
598	358
599	357
600	357
601	358
602	357
603	358
604	357
605	357
606	357
607	358
608	357
609	358
610	357
611	358
612	357
613	358
614	357
615	358
616	357
617	358
618	357
619	358
620	358
621	358
622	357
623	358
624	358
625	357
626	358
627	358
628	357
629	358
630	358
631	357
632	357
633	357
634	358
635	357
636	357
637	357
638	357
639	358
640	358
641	357
642	357
644	358
643	357
645	358
646	358
647	358
648	357
649	358
650	357
651	358
652	357
653	357
654	358
655	357
656	358
657	357
658	358
659	358
660	357
661	358
662	357
663	358
664	357
665	358
666	358
667	357
668	357
669	357
670	358
671	357
672	358
673	358
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
49	!kmbTYjjsDRDHGgVqUP:localhost	$kHkn3X5sgQZbnc7m1GNs3FoN729sUsLsqASYxvh3Jb8
50	!dKcbdDATuwwphjRPQP:localhost	$cl-cBWQqCEUtQdjEqlQcE0PD7MCeX1R25oC5CKqb7oE
51	!dKcbdDATuwwphjRPQP:localhost	$E7asGSdoMxdTkkqkSW3E0QPPoMvwzykIQvRw-bu2MlE
52	!dKcbdDATuwwphjRPQP:localhost	$C6gG6HIW6wwHiDAGDerxQ21ZtJ_fhVw30Ix9yjYFkLg
53	!kmbTYjjsDRDHGgVqUP:localhost	$Vd4lLlRvqh_TADReKDXjCcwdCyrI8f6PsJFU6zAvpQo
54	!dKcbdDATuwwphjRPQP:localhost	$Iv1tfNd19DYZLXKlL8QGU65IkNXeog_gFzeU4c-U8RE
55	!kmbTYjjsDRDHGgVqUP:localhost	$iID6c4MBkqS7-1WsnDOBQgOYEdr1CVPN9RtxIvUuZg0
56	!kmbTYjjsDRDHGgVqUP:localhost	$EJWKI8eTZpfGTKRknMihyVkHArdXuvLseElldAjwWHQ
57	!dKcbdDATuwwphjRPQP:localhost	$NEDl1FOUS-Ud7GgNcynoPiZMJq9A8YlEyGYxgvc_3f0
58	!kmbTYjjsDRDHGgVqUP:localhost	$ZT_5tMYNZ1KcFnWwJ2-QwQgqee4sEaL4NMvAr9Y7Q28
59	!kmbTYjjsDRDHGgVqUP:localhost	$p4N1aqpvCiZwCtwrwlk0iA--rTP3GRfBXey1T9rrG8s
60	!kmbTYjjsDRDHGgVqUP:localhost	$mN2b23T_CWKCh21s4DSMtK-0Ivse-M4o9tXNl3OcgOY
61	!kmbTYjjsDRDHGgVqUP:localhost	$HgACI5p4LSrFIhIgjLan4Z4eDGKWa3oT4cOknqleKOQ
62	!kmbTYjjsDRDHGgVqUP:localhost	$S7qfuHyVNKlnX8WQb78EyVSR_7_dnmagLA8asozsQtE
63	!dKcbdDATuwwphjRPQP:localhost	$yHUzJmGkEAYoMEmrjCGIimVkrSR-XxoUdwq8U-4YxmQ
64	!dKcbdDATuwwphjRPQP:localhost	$0vL62P-h7UrmHhU4ioF6wSA73ffo6vVKlFK1G7Ebvak
65	!dKcbdDATuwwphjRPQP:localhost	$TOzcyxIV2S5U6CP15QCldRMJRaDz1Yaik15PorvZYGc
66	!kmbTYjjsDRDHGgVqUP:localhost	$ir2lo1K2-OlnQHUaJd6Y3umSj10sEcvqIaj4-YxtREQ
67	!kmbTYjjsDRDHGgVqUP:localhost	$wnL_MRKUuGQ37iq3tlr8xkZ73-622MAnfPaRoQw5Opo
68	!kmbTYjjsDRDHGgVqUP:localhost	$Sa-w9Co29Yd94wHfPbpfCOuSSlMlorQ7ssiGXYp8oh8
69	!dKcbdDATuwwphjRPQP:localhost	$90abgs-hzNifEYaOK-vbTnUUXcU513VrYsJBYNfG4Kw
70	!dKcbdDATuwwphjRPQP:localhost	$Zqk5MoXrcrjH3GJoIQf220q69Vayh-9QHXfRjpic78o
71	!dKcbdDATuwwphjRPQP:localhost	$n6TBNMF739-W93vnPpWYiJ_zTj-UGsx8mCtkFUsmkrY
72	!dKcbdDATuwwphjRPQP:localhost	$uWaTSGIpSJnnCV9HG5a5zGb0LSH2uXK-QLCAgjgit7c
73	!dKcbdDATuwwphjRPQP:localhost	$Tlp9YjzhiKmAmZzyivu0mpIuMlMkzWxFfWlwtj5zHZc
74	!dKcbdDATuwwphjRPQP:localhost	$Fz8vTARO9NHToB2Epr5qUR0gKErUBZcP_iMmnDw9zes
75	!kmbTYjjsDRDHGgVqUP:localhost	$U7q1U4E6PvddrLFkZ-IgZWLNH5JwQMKwxApvSe1Pc-4
76	!dKcbdDATuwwphjRPQP:localhost	$9L0MDAaqrMj6166uwEyUZlzfeWkDRsIVObuS7o00I-0
77	!kmbTYjjsDRDHGgVqUP:localhost	$5aKFhU5uekQTTY47t7WUErsQ6D6i-1sJlaeP9o484XI
78	!dKcbdDATuwwphjRPQP:localhost	$lf5sHxB86UdKZYXr0JC3-12W4nP0DZWeyrbHYYWeiAY
79	!kmbTYjjsDRDHGgVqUP:localhost	$HSX-I2M8_wUkWisApshI9qmmVVWS-oGULipYzBstpqc
80	!dKcbdDATuwwphjRPQP:localhost	$QnfBFeO5dEdm0Fo0xlQ0jZ7Qhl2frK5huiKe-XZeWtI
81	!dKcbdDATuwwphjRPQP:localhost	$7ZbDGxgteTl1uyata87G4m7oMlRXH-7FWGx3fz6Uk3I
82	!kmbTYjjsDRDHGgVqUP:localhost	$xRV_3scri01P3CN8Yk8Uj5kRN98J7r_BzpaYWDcxygU
83	!kmbTYjjsDRDHGgVqUP:localhost	$8dkt8GEzW_rbNRPh07-6uk5r1rixovZPmI_U1JvEZsE
84	!dKcbdDATuwwphjRPQP:localhost	$BLtE2v6TONv723FUOIxXyICUAIEc0MAj4D061ASN98E
85	!kmbTYjjsDRDHGgVqUP:localhost	$zlieYOI1M-BWRYe_7HQtpDzEEdUAGP3P1rppBTpa-gg
86	!dKcbdDATuwwphjRPQP:localhost	$IF-IpV86vc06PJjKQLZLv5zSLo6RhFbFhq4ESflREbs
87	!dKcbdDATuwwphjRPQP:localhost	$MCqISVNNz64_mm1eNx4MdunpBcEs3D4_cccTO7UxeEo
88	!kmbTYjjsDRDHGgVqUP:localhost	$oHONV5zpF0PbMs3W_mfinmmaehaU1mhfF4MgBE1Qe0E
89	!kmbTYjjsDRDHGgVqUP:localhost	$IdBAhjACyTKk0ZNY7q37ukLsaZlamh896aqB4JRp0Ak
90	!dKcbdDATuwwphjRPQP:localhost	$vY1BQo452NDbeb-fQcWAeHNptFSfCH-tz0hyyX_0KHw
91	!kmbTYjjsDRDHGgVqUP:localhost	$N5vnwiqD6vTa8P068T3nm2gC85VBZ9jbhBkidGWH4y4
92	!dKcbdDATuwwphjRPQP:localhost	$MIg8MwA__tVnwKOTSbNMhDbFQdNzOspIdjHunWOWTXo
93	!kmbTYjjsDRDHGgVqUP:localhost	$bFZxglDcEGrzE4UltyM5qble8OPFUYf1HCcyhHkxCZw
94	!dKcbdDATuwwphjRPQP:localhost	$fOw1OK_Z-99J69QwZQnS2w0kErksSQlRVWy_uYMALyQ
95	!dKcbdDATuwwphjRPQP:localhost	$osIKXvE9C_LN7JS2liSacSDe4OMu8i4EfoBZtDc49GA
97	!dKcbdDATuwwphjRPQP:localhost	$pbPnr7boAFsdY2Cl9d9RqHuhCQ4DEuffsodtnqicRQU
96	!kmbTYjjsDRDHGgVqUP:localhost	$MdGvFLu7OgkJmk5QFhh09ch24n_Nm5s0OprzzOQp-BQ
98	!dKcbdDATuwwphjRPQP:localhost	$z56tpDb6SQ20hAAJSnUW4iq5KshMfcyF11ri0jXivjw
99	!kmbTYjjsDRDHGgVqUP:localhost	$Jm5Kq88xqnnlOB5NxlxBKNxnPO1zmqUqN2xBcck3Y8M
100	!kmbTYjjsDRDHGgVqUP:localhost	$GcnmLPU4neOMVVS6jP0mTEuOgHF07GPpzCwVYxkJ2Cg
101	!kmbTYjjsDRDHGgVqUP:localhost	$yp90ZJhZRNi_jnL2rT91wTtQeGY5JgJibxlbtBftEDM
102	!dKcbdDATuwwphjRPQP:localhost	$iGNJEeKe_FaprC9MHkNXpECrv9YZUTEsJ1zTRt8IHRs
104	!dKcbdDATuwwphjRPQP:localhost	$YVzCfjieRla3dc_IRz0__apizPaipgYbNoG38P4Pjzo
103	!kmbTYjjsDRDHGgVqUP:localhost	$Ni9PxK9c_fhaz_L40G_oeOsJ6qBhRpuzQ4hVlVvdf3Y
105	!kmbTYjjsDRDHGgVqUP:localhost	$FbMtJdUuQsncWmh4E6k7GM4g19tqMjdPVk5fayFYGKw
106	!dKcbdDATuwwphjRPQP:localhost	$QKPr0huguKOBW_mgzWz1UbH1JJisQGkItdfgGi0-WPs
107	!dKcbdDATuwwphjRPQP:localhost	$RuNzKCE_vONsTGHU1yfkXlNv9MxUspzI2R_uj5Vosfc
108	!kmbTYjjsDRDHGgVqUP:localhost	$dWASiSCo-ndJXTiZjRYHD4NCvag08EgsJGoJL_uj84s
109	!kmbTYjjsDRDHGgVqUP:localhost	$VUkoEV4SLWYarXN7z8vOsYL0FJlhsOiPdkbatF03VmQ
110	!dKcbdDATuwwphjRPQP:localhost	$ablNMTYzsJyVS-P2d8NBQVanmRI0fAx4PlO42kl_Y9k
111	!dKcbdDATuwwphjRPQP:localhost	$my423N54HYnmSaUQ0yrm5d-qaRo97cijrr95bP5GDNY
112	!kmbTYjjsDRDHGgVqUP:localhost	$tfG11TaVnHZeEAKdavDDjgKea75EY4xxUJ8VOj-Dlxc
113	!dKcbdDATuwwphjRPQP:localhost	$UUTukGCaJitmBKamocHGYrs5OpZNsaSFs2npDQgVpck
114	!kmbTYjjsDRDHGgVqUP:localhost	$GsqAhtVBYcUQXT147PM9v3W9PJ9lSTNq9IajBmUTf00
115	!kmbTYjjsDRDHGgVqUP:localhost	$T9jmxdCLXr5NqlISMd-TEEdMTjqgOCUuOXfEY6iJSIc
116	!dKcbdDATuwwphjRPQP:localhost	$Ev7bxxH2Ah_UTgxUfzAp-Nrm3aAuW7mKcmEBKBuon4w
117	!kmbTYjjsDRDHGgVqUP:localhost	$7l7P6YEqPaWtnCWBCrqUfSgR8qKS4PIBD72DWuBhwqo
118	!dKcbdDATuwwphjRPQP:localhost	$N9WmxGhTdaRvg9iOEMS0IxuXWqRhRSKVXGJd3ga5EIk
119	!kmbTYjjsDRDHGgVqUP:localhost	$ljs81WukGSQKuG8_XIoeEizepuyRmVR9bm7AYGAjjMY
120	!dKcbdDATuwwphjRPQP:localhost	$8d8N-i8RkNQv6QDWFrWzU-jtTVloel7ZWVUeiFyuARA
121	!kmbTYjjsDRDHGgVqUP:localhost	$LA6NcF4ZNwknAoEep2vmqOtrrAVdfx7wWgs2QzGiRI4
122	!kmbTYjjsDRDHGgVqUP:localhost	$PSHlaeauYf8z31NaJjlutB2f6VfoC1jA0zlGvA8ADrM
123	!dKcbdDATuwwphjRPQP:localhost	$_d5NSRVMkmFfGOgLgeuYegLCDiGpzKtSYT3BB_xfJJw
124	!kmbTYjjsDRDHGgVqUP:localhost	$scEWDHms8IkwamZNSy3y5dUXxzdOHy6BqBoOYiLjCFI
125	!dKcbdDATuwwphjRPQP:localhost	$MF98WMCod9mD4-EkjkJzrhITSPUIqifqEfCsAxnZuek
126	!kmbTYjjsDRDHGgVqUP:localhost	$hbOhAMLBEy0NwTmN90Ta3dmHVyd7AIpyDNaoSbGBO9k
127	!dKcbdDATuwwphjRPQP:localhost	$uITK9jNO0mygUpcKMTsvC9-64KigGqBEOAYW7U23jOI
128	!kmbTYjjsDRDHGgVqUP:localhost	$NktchtAWV-fVvZR0Qol52_iH9TiU06dYgz9AtlIUzuk
129	!kmbTYjjsDRDHGgVqUP:localhost	$FCKZ5jvLh3GvFl0ItOxRa2HNNpBn_loc9KtCXC-3izs
130	!dKcbdDATuwwphjRPQP:localhost	$FNl7nQTr424oiWFqebjaFcIQpg301Lrvyf9kxeHnTVY
131	!kmbTYjjsDRDHGgVqUP:localhost	$WTXlWbsTiRT8aidgWXwk8ChcmBIksdKlHYW6UpjhoME
132	!dKcbdDATuwwphjRPQP:localhost	$uXCaMc1vXRfWE1L54EhpIIDFOoox_jjfwMRKGYHBNMM
133	!kmbTYjjsDRDHGgVqUP:localhost	$aHgGhiv3xClOMq6s_WTnvfD9N9bKsW5Kl_3zHi1DCo8
134	!kmbTYjjsDRDHGgVqUP:localhost	$wIw9WkkF9SmKQyihdccvwowSN1P59odk5uQ37tTrCj0
135	!kmbTYjjsDRDHGgVqUP:localhost	$W8WF6wgFgm3CXjarC2waQNs76jelVoxiHhqqRxlqg54
136	!dKcbdDATuwwphjRPQP:localhost	$wRW9LN3T6DjMgSIMDmAMpH2W63NqYfLL9varOo6mTzg
137	!kmbTYjjsDRDHGgVqUP:localhost	$FT0QBjiZiQF6TEwkrh-gfrg40Q32IMNH5WJE-NGoUJw
138	!dKcbdDATuwwphjRPQP:localhost	$okJHwsYIM2qtpJq9X38uFiK0HTVYNC_YVaGGHQSdHi4
139	!dKcbdDATuwwphjRPQP:localhost	$YxrW68PmII4FR3tSV2DlMw5rLJ9tkgN-IAorJK76ZF0
140	!dKcbdDATuwwphjRPQP:localhost	$78FN3rSTksVHlqj3pVwOu4OqyQWb_kojoDv8Z4siAho
141	!dKcbdDATuwwphjRPQP:localhost	$Z-zN6YVNtwc5-sC2_gqVOqGdBWP9MtkZ5AqVVIpVS1c
142	!dKcbdDATuwwphjRPQP:localhost	$zac6ikLLjmhtpGwmeOXeNvFBe13vavuAbgeJ3V--L74
143	!kmbTYjjsDRDHGgVqUP:localhost	$_eGV2WLucuJ5WUj2zxi9h8RoVVLj3epObbai8d9uiBM
144	!dKcbdDATuwwphjRPQP:localhost	$20RPj61r433ltZKlA_zjshrGKHbOwOYzoeqMq9lIibs
145	!kmbTYjjsDRDHGgVqUP:localhost	$ZIKeFFw9iKIo0lQS_EahlQ-2H_MUawJt03OfV4bhkw0
146	!dKcbdDATuwwphjRPQP:localhost	$96z94FnX3Z4wFXhtU5h_MG7dplI3k2OSYPNnaNsWHpA
147	!dKcbdDATuwwphjRPQP:localhost	$CZ9ISJIRtjuUHkQ_afzV7hHpFP__5Y7uCQYpINWev0Q
148	!dKcbdDATuwwphjRPQP:localhost	$FV9fGwTrrsSULTG29HysxmyU0JwQbWkcCp194yuwRr4
149	!kmbTYjjsDRDHGgVqUP:localhost	$mwtCirIztAGJ9ji4rg7nw5VlLm_6_sP0z0pr-8fsEjE
150	!kmbTYjjsDRDHGgVqUP:localhost	$lXaQr4I0TzmD3ElzwPhFSXVI_9njGCaxorSrUNkWosM
151	!dKcbdDATuwwphjRPQP:localhost	$ryVAC4sZ_GuLdWSWf3H49MerHNRZIqb_XZl-cZ4vZX0
152	!dKcbdDATuwwphjRPQP:localhost	$LaKcPOlOyqg3zH15fQrR-9_nEJmKBpzs9PEhhnoa_YM
153	!kmbTYjjsDRDHGgVqUP:localhost	$2IWy9LjE7Krzobf0BDlPHmDQTfC_mlaHfLDRx0D_KSg
154	!dKcbdDATuwwphjRPQP:localhost	$ReZHJ8bn0D949tS1Z4rK1A_OldCeJXSu_z6bvWyxkP8
155	!kmbTYjjsDRDHGgVqUP:localhost	$LytXCAxhhMuXWLqz76rEaUZqJ4vArp4iF4lyJWQAom0
156	!dKcbdDATuwwphjRPQP:localhost	$RVL87O_052WjvihngqMP2wml6CrYR3ETZPS9AQcdkXE
157	!kmbTYjjsDRDHGgVqUP:localhost	$M_TeQ8v6agN7KHCFhaTS2WCcGV35sHVe3G7L3BYV66k
158	!dKcbdDATuwwphjRPQP:localhost	$66z3By-n_vl5wYEwyxkr5XCESaYZdITtfPX-Ql6jJps
159	!kmbTYjjsDRDHGgVqUP:localhost	$qThQV09ZG3001xOhw6wQZwnkYNJCXKMmRAME6mMk6vU
160	!kmbTYjjsDRDHGgVqUP:localhost	$zlrFAQyOfBp0Yk2NhrKS9ZrJTI3TPBpQQ1RU5pA-zsI
161	!dKcbdDATuwwphjRPQP:localhost	$SMfchwwijJRjg-dyUd7PvxmVCmjDKX1pZiNstEClh3w
162	!kmbTYjjsDRDHGgVqUP:localhost	$JFsvZVb4sDfcRmaejalrbwRwwUmXSl8YfFeKzUFCFII
163	!kmbTYjjsDRDHGgVqUP:localhost	$427tt1KJakZ6eyMfnK5SNnOcWTdp-onm1a8NpQAgnOc
164	!dKcbdDATuwwphjRPQP:localhost	$iuxaR3O8IzLXwUEO49jvkuByC2GVQPkx_ZptsZSqf1s
165	!kmbTYjjsDRDHGgVqUP:localhost	$scc5v4OjJXqJETWOTIZHBMv4yvL_rW9zlja0qLLVq0A
166	!dKcbdDATuwwphjRPQP:localhost	$cUrQpzCoYIYF5cYCjqTlmeJv2MQaDU5x8l67Jfki9CA
167	!kmbTYjjsDRDHGgVqUP:localhost	$C8NxDwv8onlxLp7GWZUlJ6Of-DEgpHv2EyxUD5kVawg
168	!dKcbdDATuwwphjRPQP:localhost	$E_NG2FYpoMH4OopElszmCy1RDPEVr5GgaleQve4G3fA
169	!dKcbdDATuwwphjRPQP:localhost	$FxkLj1rdCBoI5n-PQymoCDUdJjFmOd0s27Js3rLYfOs
170	!kmbTYjjsDRDHGgVqUP:localhost	$PRjHcAAICLgYK3XY-NErxUtt_wsvu54SRhyAFKnpfdU
171	!dKcbdDATuwwphjRPQP:localhost	$4E7kN-BJwtwZxiaOzq5nlSDrtHW091zrvo4helm83zo
172	!kmbTYjjsDRDHGgVqUP:localhost	$KFMvW_vZu9RNx9EUhVogCsf-5w1sY7nBnK25pVedoIg
173	!dKcbdDATuwwphjRPQP:localhost	$-JEr4JIoAMygP_QRAs9Jv-iADvzIwLyAqC-OGwhOaz8
174	!dKcbdDATuwwphjRPQP:localhost	$tO732UWGu6BRuC6D7nxHRr0mzlZATItK1nJdw2vssUo
175	!dKcbdDATuwwphjRPQP:localhost	$b5cK72m_LYLOCXdks0dJR8YR2NUOhzyb_EIzMrJeiHo
176	!kmbTYjjsDRDHGgVqUP:localhost	$qGfpbIvHpOVZtwnIzJoordk128W1bbJL4tO9Oppt7AU
177	!dKcbdDATuwwphjRPQP:localhost	$x-W0LGzIk7Uzv1r2jFg7gx7otG3Lc4D3vGOaJwejju0
178	!kmbTYjjsDRDHGgVqUP:localhost	$RnpX5g3JH6jpSfLcpuV2U-ZNYTNVSdWTf4DUNIFMsr4
179	!dKcbdDATuwwphjRPQP:localhost	$2eIpQ45JTS7VTgATlO0mXqlYXz46Z9kFu3aZ0gb8FnU
180	!kmbTYjjsDRDHGgVqUP:localhost	$6uW4FPZ4rmMpE0LAdrXTalyG9qS2RWcHznbqu-Pj0_k
181	!kmbTYjjsDRDHGgVqUP:localhost	$-j2CBh6M1qqedPILqSQjOeKo7DzyfV9qX0M9EAcPvI4
182	!dKcbdDATuwwphjRPQP:localhost	$UV4_Zf2YL4gxDOc9KFs1RNYroZrMWypdfHN6Lx7kaBI
183	!kmbTYjjsDRDHGgVqUP:localhost	$Ns-nffQ5v20nWGD0NFVrX_auu_O-gAXSrSQhly2sJ1I
184	!dKcbdDATuwwphjRPQP:localhost	$Z0wivM3fsEKLc1Be1JiChy8kiP8ApDxdcmy51mWkBhk
185	!dKcbdDATuwwphjRPQP:localhost	$GHieoljZ6vmSl9Q2vkSy9gEPu4FooqplxgfDXerZ8gg
186	!dKcbdDATuwwphjRPQP:localhost	$oFw27uy3wCnJmaki_Pmqd7iUeyDC8CtIbezsnqmJqHU
187	!dKcbdDATuwwphjRPQP:localhost	$xsjLpj6f62AxGbNb4GJ1grmPYCyJ2UcBk2M4PnkLUz8
188	!kmbTYjjsDRDHGgVqUP:localhost	$Dk-ayxJmbBGZWmA1mmxYXXtTubHcVIGOSif9BZRak5o
189	!dKcbdDATuwwphjRPQP:localhost	$LO4JbONTLdRYnRsiEmAa9EZKF9gOIgppfVeVDVk2NmM
190	!kmbTYjjsDRDHGgVqUP:localhost	$5clF0wwGPRj-kjxaUNsst8TSkhGcgeW6Uco_LETCZT8
191	!kmbTYjjsDRDHGgVqUP:localhost	$pT5f3hjpM-O7jjmY6ltvCPil7vE4SCwIc_f8fz6NGI0
192	!kmbTYjjsDRDHGgVqUP:localhost	$NcXRdb2ft15gUA18r5qv1hBOJPXBlP_GWTdFAOdUKlc
193	!kmbTYjjsDRDHGgVqUP:localhost	$eQvEqc1_af1ldzsdEEl95WumLWS5ipRrAPVsJGi0VAM
194	!kmbTYjjsDRDHGgVqUP:localhost	$0gp0EPFRanC0jriwAbr39rEywXl1TtmsGetjvcFePkw
195	!dKcbdDATuwwphjRPQP:localhost	$GumzrsEvUfP2mK3VlimFmnxefQIAoARNhuB3VijIUP0
196	!kmbTYjjsDRDHGgVqUP:localhost	$ADVpZVcve3WZmJJlbMuWC08LTrnTWE8iE3U7Kjkccew
197	!dKcbdDATuwwphjRPQP:localhost	$1ivkQolJh28E65KCTdZFg-9JL6DdG89yjFeMjqW0RmU
198	!kmbTYjjsDRDHGgVqUP:localhost	$dMtYbdewwlgf3pUO8IpSaszb9U-i1iu4cLoPnOdarMg
199	!kmbTYjjsDRDHGgVqUP:localhost	$S9U9EJOnxM2dNgNljOG_Mqix4hFq8eEzoc-kg609W7M
200	!dKcbdDATuwwphjRPQP:localhost	$bija9Vo1aDPA0Nh_IcvnsdGQHNAzaikmRrAUn4gMPEE
201	!kmbTYjjsDRDHGgVqUP:localhost	$ShE0paQlbQmO6DO1uDpThgm9CuYVVxwdAQbG309R_gg
202	!dKcbdDATuwwphjRPQP:localhost	$IwXCdgCEAM-h0xs_-9VBU5B6QnIMP209_5ehWVHPCns
203	!kmbTYjjsDRDHGgVqUP:localhost	$VPHsYU9BWa2fXGQiRiuxjTneBiINKDgzarFBDQLtjFc
204	!kmbTYjjsDRDHGgVqUP:localhost	$7ij0oeLT0Bwov3CDZx-Aw08A7otYoVl3r3h3W1tDKcU
205	!dKcbdDATuwwphjRPQP:localhost	$3DsKEEmlaTB7ZtCmo6sdlibowkxyEblvlYHADVEG3iA
206	!kmbTYjjsDRDHGgVqUP:localhost	$GsNXwosBvPN7ZQotuPf2lmZcmTy71Q5wdwz8MxtTlwM
207	!dKcbdDATuwwphjRPQP:localhost	$-pW5O2pJh_2AJYUSBaFetGJ3BRZRuqco28kqbedUeQ8
208	!kmbTYjjsDRDHGgVqUP:localhost	$jTcKXqJEQ95H5Bg8HhnouwNlmZxvm-zO8GOK9XDNShQ
209	!kmbTYjjsDRDHGgVqUP:localhost	$mSH68CBsDtqDSaETqhiL5ndSRIHJnZEZHfNTr-VYIm8
210	!dKcbdDATuwwphjRPQP:localhost	$hLkYdEmPTHZMcJnov4ZsG7XD23zNjKaX4pNtXvPjs_I
211	!dKcbdDATuwwphjRPQP:localhost	$_HszCcHP8YOiOxllHF1Oz32uwN7zvPkiKsS1ogkWrK8
212	!dKcbdDATuwwphjRPQP:localhost	$VdTrMdfOyL1DZ30DkAnFuIUofKEtOk_H2pF0oEzqhP8
216	!kmbTYjjsDRDHGgVqUP:localhost	$uGHZZ-Yz2PAQX0wNAMlZVsLIVmJtu6Xa7hmfZP4hoZw
218	!kmbTYjjsDRDHGgVqUP:localhost	$JpeYShGG49hm1tm2szGTbj_Ad8syeP-_zHCjUtcyDW0
220	!kmbTYjjsDRDHGgVqUP:localhost	$YSfyQAFQ7QY-iuTQlyB6FDgC5MVoRKGybsLMxYXeOno
223	!dKcbdDATuwwphjRPQP:localhost	$mOwiaepGRyjJsnm_OUDMUEh19wp-kvtE6rZjqS6T6Qw
226	!dKcbdDATuwwphjRPQP:localhost	$UqS62uUwwgjNC7m43u-OzFd0NlWP14pRSdMShryA-OA
234	!kmbTYjjsDRDHGgVqUP:localhost	$_3gf5vvCg3EOAp1Q8jix5_u1X3dcz3I2YOOJnLgfyLU
235	!dKcbdDATuwwphjRPQP:localhost	$ldSJmecZ-XFUSA276NblPkKsrp6F9-7SOq_bVvbJIMg
242	!kmbTYjjsDRDHGgVqUP:localhost	$cHNGphBcS0JdljZ_qXDUB5FCKHdU_qHX2SupMXfYfgk
243	!dKcbdDATuwwphjRPQP:localhost	$kd1c1xMGDVYzW7UKm7ukUxezvnK55kCygo0SREvSabM
213	!dKcbdDATuwwphjRPQP:localhost	$kPsLZfjzhb9VbV9Niy3LEDw16IkOq82bA9DzbgueNqw
217	!dKcbdDATuwwphjRPQP:localhost	$XgLkd1mPehDswcwvC80mYipQGC4eyHA8YlDO94-mLh4
219	!dKcbdDATuwwphjRPQP:localhost	$ONH23hQdD0T0G75aP1jV0aJp-CI7wA3uf7fuGchk9xc
233	!dKcbdDATuwwphjRPQP:localhost	$TU-6DJUZ_Y2P2o8co2ANw-YQglpJjMpWk4y7ynR3nzY
238	!kmbTYjjsDRDHGgVqUP:localhost	$e3V4xZnTVInSYV6go67sGixdf982XRRz1vqy6xjUADk
240	!kmbTYjjsDRDHGgVqUP:localhost	$BRfPTSz22V7srsm1mQdnab9JJZteh-qzyDVxi6nMSuY
241	!dKcbdDATuwwphjRPQP:localhost	$56hhxnuUCDhY_FIqU1jVYXERaYIi7eD3azhwSxITnXA
245	!kmbTYjjsDRDHGgVqUP:localhost	$qECtj995yYxki0bQLCPrY98Lxx8F--3rMD_3hFwFm4M
214	!kmbTYjjsDRDHGgVqUP:localhost	$Z4xeJ4R20MboSLnMhswFErA6i38OSlBXGluDVy2ByvY
215	!dKcbdDATuwwphjRPQP:localhost	$XVyZGGZiCPdqdp4Ghuhpllefiu4t6CzklcLpsOgdQo4
221	!dKcbdDATuwwphjRPQP:localhost	$2tokfrQ58H1jbQd1SE9eeoBkmUoFdA4J1FR-5QPBQyA
228	!kmbTYjjsDRDHGgVqUP:localhost	$3noaqaRS9KxMxckU5_sisNvcAq7QBWBBbJEucgPco9c
229	!kmbTYjjsDRDHGgVqUP:localhost	$pCRA27_JEbxVjc1CYbe_YIbe5I3brBzCimLklRQvxjk
222	!kmbTYjjsDRDHGgVqUP:localhost	$lcxQuSgYav6SAXCtor7PcgAx55stIfs7pUiw9W8V_jQ
227	!dKcbdDATuwwphjRPQP:localhost	$Zx1UYbm6_nDTdC8yyZ7IF1HGWHztD-HOoadwzqOrrx8
230	!dKcbdDATuwwphjRPQP:localhost	$JfymGgTNpWgrPBhAf9mTJSyWQr7ko1F_30gUKa_M5NY
231	!kmbTYjjsDRDHGgVqUP:localhost	$sCN5SiXxHx-vme9FWf73E0xk5fP8KKT4MIrurI6zVSE
237	!dKcbdDATuwwphjRPQP:localhost	$0imkZ45yWW0fSc-G2ak6ejGMMJRRQgHFPyObQ0SeNqc
224	!kmbTYjjsDRDHGgVqUP:localhost	$44K-SnNKTzndgI3lWCh5FxdbRg3ZzENFG_HAqzsyPw4
225	!dKcbdDATuwwphjRPQP:localhost	$vSsR4w5RLvaEucW3yEjRe7nZuVGvV46a76b2xLpbAMc
232	!dKcbdDATuwwphjRPQP:localhost	$lVzKffAN5aYQWs5TCqBXIpZSl29pGAyCmOQ5or2psZ8
239	!dKcbdDATuwwphjRPQP:localhost	$Gsm-HyY8ghp5jnPQY5xCvYeGJdACkJYnCBxMGOu3YbE
236	!kmbTYjjsDRDHGgVqUP:localhost	$wVjsVUuRifcmJWBUzjKVfU64rJWHpFwzMmhVyoNJ2CM
244	!kmbTYjjsDRDHGgVqUP:localhost	$jmNoNPJJVWbliGcIo6zEPgue5WhGiAQ-02F5sUdxb5k
246	!kmbTYjjsDRDHGgVqUP:localhost	$q835RTIYlrfptTOdElzE6yLeryXnpAe6sBZ-wrXeYWo
247	!kmbTYjjsDRDHGgVqUP:localhost	$IC7XPWkgfvsD0GASMe4Ih9mgp2k9ABMX5xCMWNpNSwM
248	!dKcbdDATuwwphjRPQP:localhost	$Gqw9r3I_eVZ-BLxDRsgXjb1k8iDHvXLnGFamhXZ5vec
249	!dKcbdDATuwwphjRPQP:localhost	$_K14CA6WUVr9lSRSFGep1Jctv_dRZ3ypws6I7EwN7lU
250	!kmbTYjjsDRDHGgVqUP:localhost	$jiDz1SrKn5EnKT-hsrgwgj-WnPjCQsf52m3b4omIbJM
251	!dKcbdDATuwwphjRPQP:localhost	$Pt2Hhv8GKcJIPNaDVmOA7D3QXhuXvXNSMD8Ixft1b9c
252	!dKcbdDATuwwphjRPQP:localhost	$x_Z64R06dNc7xMERtwpkjVA4V5asHLizmW0bAoy0u4o
253	!kmbTYjjsDRDHGgVqUP:localhost	$ll2PHFhXRI7X-WEZjp1VeCxYc-VzGJTRIl6DF5sY72U
254	!dKcbdDATuwwphjRPQP:localhost	$FjsBFw-_MLzyEW8Z_Y4b74RUbAm3CkK-lUEdyUMH64s
255	!kmbTYjjsDRDHGgVqUP:localhost	$Eb3vVCh6EIDN7FhBJt2nRxzX2hogZvkfzshFfIV1vxM
256	!dKcbdDATuwwphjRPQP:localhost	$R7lEwM2wAbK8XfzbqmMIPd8Pl1mDTjk0Z7EsYxc8D3I
257	!kmbTYjjsDRDHGgVqUP:localhost	$QV-PSstXAg3CBWgJsWWv-wWweTQJtnd-Xb3_UHlvLao
258	!kmbTYjjsDRDHGgVqUP:localhost	$oEbJ0qLItkJKWV8ASqMucQE_aTbOBYal1em_l_NW4B8
259	!dKcbdDATuwwphjRPQP:localhost	$wvc6XB-l-RYjQVlw0hdTWpog0iQzQ8emO6yY9r2cwcU
260	!dKcbdDATuwwphjRPQP:localhost	$swlNLbqgOtlyDxyp_tPGr8sFSkJ38wJHUz8lsNO5tpA
262	!kmbTYjjsDRDHGgVqUP:localhost	$gapNykj-iaq3z-2uBfizldcLhIDcDQNBE-j5IM4q2uc
261	!dKcbdDATuwwphjRPQP:localhost	$r6IuwtQgVeU0yTzPOwNEvpwP_68ZIfHO4ukobTN7HOw
263	!kmbTYjjsDRDHGgVqUP:localhost	$YCxt6fHYsElmWrljpWDg6zUrwOa_UgLUrNd_yv6YOL8
264	!dKcbdDATuwwphjRPQP:localhost	$voYXgDbJERPG0WYiYEcOPPfxb1x8D1OxXrb4YPQMk0A
265	!kmbTYjjsDRDHGgVqUP:localhost	$SIwrQNayrwtBHR48kSzVN7oZWwteQWy5N5B9SCVy8r0
266	!dKcbdDATuwwphjRPQP:localhost	$jiJu8UOWCGf4_gCw0Kik4K7irau0AB5W0Ln9Q9ARmFM
267	!dKcbdDATuwwphjRPQP:localhost	$RwTzM1d7yJmRSjuhSRjOdDVeBsXHw7ivvHME597GlGI
268	!kmbTYjjsDRDHGgVqUP:localhost	$N8yMX_bOsLyM55kTCXOweV5W6eHWoX9-SXJv_h3Fuuk
269	!kmbTYjjsDRDHGgVqUP:localhost	$YK9NVxqYWFjsLH3Hq7qeNPnLGrTnzdz9Vm5Xoj4oFKE
270	!dKcbdDATuwwphjRPQP:localhost	$QsrebPbSgJ3hGVwXiHq9MXGadC-MP7ehmEgLHVROdbs
271	!kmbTYjjsDRDHGgVqUP:localhost	$LTHL3LlRVNrPhRkjuAJZAnrn9TxE0VJNzhHzlpeIOtw
272	!kmbTYjjsDRDHGgVqUP:localhost	$GC0xEuJnwGQKhy4PP5Fps-2vyhFQXURFjFhMMu6e39k
273	!kmbTYjjsDRDHGgVqUP:localhost	$pJWTdmwi6rTMbfJUFNxleRX2FCaQUX9kpdCF_Fl5u38
274	!dKcbdDATuwwphjRPQP:localhost	$ze2Niy56_7XHRfJ1TxaWNymtm8LUbwKCKDhR4lCYFEw
275	!dKcbdDATuwwphjRPQP:localhost	$iju1QLlEd15kAw8CdDeKpxUiIglD1tu16Vy9CE99Gi8
276	!kmbTYjjsDRDHGgVqUP:localhost	$7sTtH-3_5JdX1s6nEDeHlgconMj5zhTbbAN1Sj3sSEk
277	!kmbTYjjsDRDHGgVqUP:localhost	$bxMErosR1jWaU8smH1x83fp155ZsJDrKoxpYQe07fvU
278	!dKcbdDATuwwphjRPQP:localhost	$F_NxNLkUUW3M3ycmhoAPTB2OgEfk2CX2vl9sc_rmOew
279	!kmbTYjjsDRDHGgVqUP:localhost	$98YOnFq49tpq91ULd-dkuciQDt8SLsMTfJfbJYhrtKk
280	!dKcbdDATuwwphjRPQP:localhost	$4eCsy6BlXga0ZBCEsowCxrzMRi6AFBfhbui5wnv8okg
281	!kmbTYjjsDRDHGgVqUP:localhost	$kHSLXtHLXKbKnpohOTpK0MHdci7kHH37wbF1rFn88pU
282	!kmbTYjjsDRDHGgVqUP:localhost	$dex_s62jDbGAFfmj3DACx4C-IEliBMY6WHnkhMcSIeo
283	!dKcbdDATuwwphjRPQP:localhost	$AbLb0eh3AyP6eESYFAf6ZChqvbbMUZOAoQWaI5VGmJI
284	!kmbTYjjsDRDHGgVqUP:localhost	$lPRKxUmhH2h-cb2fg6wnR94-MiHdlxHl8jdIWt-drf4
285	!dKcbdDATuwwphjRPQP:localhost	$fWjPnCuvaPnr6IEiGE24nCdJL45rmg456jXOpCpAPEo
286	!kmbTYjjsDRDHGgVqUP:localhost	$HvKCrzX0i2S9FmqDCixwUALIuMg5Q815hUVvarAAndI
287	!kmbTYjjsDRDHGgVqUP:localhost	$97qoxlByy_DPtJys_Rody0B0epO26i7OfFaCNgJmUwE
288	!dKcbdDATuwwphjRPQP:localhost	$gLosusM0q5FKktKrS8-Xdn6CtZjPbmez5jSYq7ByFx4
289	!dKcbdDATuwwphjRPQP:localhost	$LgU_WFkS-bvyeU3PZisr5tBWnXuIeL4qfBrosrC-Zo4
290	!kmbTYjjsDRDHGgVqUP:localhost	$tEDHFQjo2VF_Z72T1hUGgkCeh2BDQ1pSZHgU8JjnPyI
291	!dKcbdDATuwwphjRPQP:localhost	$TfBTzlSXNy1kehoegAQnqGu_UG_JVz24j3SKCuzVmsU
292	!kmbTYjjsDRDHGgVqUP:localhost	$T9UC-Azf67D2cfSWXmMx07Ifywx5ZZSvyGmIENquHeI
293	!dKcbdDATuwwphjRPQP:localhost	$QZvlGrodMSAksphGZ9uCvNnCTlCzVFOSFiB37Lh4JXk
294	!kmbTYjjsDRDHGgVqUP:localhost	$nocPi7lNeOzk_Va45XoM-TXMt0usDsU_6S97MZNW3ps
295	!dKcbdDATuwwphjRPQP:localhost	$67MfU0dO-ARDQ3LHnCGyERHA0Tl_MpCRhYSTFAHuxy4
296	!kmbTYjjsDRDHGgVqUP:localhost	$7VUu_lYxl55iG0Fk-bUv23mySXyAo3IjdtQPaqFIaZc
297	!dKcbdDATuwwphjRPQP:localhost	$tBlQ0_SRowkxKPxnd6wyqVZNpdfFJa1AaZj11sFeo_4
298	!dKcbdDATuwwphjRPQP:localhost	$4pGVcnDkOFkfkIsibCpOzF_pLN1zyVa64oo9E0A_F3s
299	!dKcbdDATuwwphjRPQP:localhost	$hctyN7H3VwusGaSx9G3VxjdP6XAD-npClpuHnIby9P8
300	!kmbTYjjsDRDHGgVqUP:localhost	$ITumaOTQ-TPqv82ND85rTVtxB_slHPn-1Ds1ixT1YMM
301	!dKcbdDATuwwphjRPQP:localhost	$bLui5hvS5Rm828T-Vd_hUaBzYehFuvs5jthZuk4EMng
302	!kmbTYjjsDRDHGgVqUP:localhost	$Atuqu2ygQ9ALYkY_4JVN0L5R63_yL_9IDneKccaPexg
303	!kmbTYjjsDRDHGgVqUP:localhost	$IxOnycDTOtkWn8g5giMyu88ghJnpIbPzSy7oKowCqcI
304	!dKcbdDATuwwphjRPQP:localhost	$g9rczUTLPj0dUBqXVVBw2h_sKntEbsE_v0y4wqekqQM
305	!dKcbdDATuwwphjRPQP:localhost	$7fNqDcYwdBofKa3Tdb_ozuy-7JvHY6aEjHPx3dtK0Jo
306	!kmbTYjjsDRDHGgVqUP:localhost	$LesIhSE86XzyQPkB7b4TyY6KnXX-pYPgXEh6pdOBL1s
307	!kmbTYjjsDRDHGgVqUP:localhost	$bwA7mRj_RxsTAGpGf-t61H3LDTorQJ2B4vdWPMu81Qg
308	!kmbTYjjsDRDHGgVqUP:localhost	$EYct8pcN3TR2iw4L28JcvwHRrH79akTS7Uv_YHdydyA
309	!dKcbdDATuwwphjRPQP:localhost	$pm7XI9sywlUrAHs8qdFu4OwZ5lGlyq-H4Za-_Qph67Y
310	!dKcbdDATuwwphjRPQP:localhost	$rSJaoKOTJsEKYpxqniMuLIgSddnszvT-NoqHNtX9nYQ
311	!kmbTYjjsDRDHGgVqUP:localhost	$P6Dtn75RwyFpmO6OacwziN1f5O0x7HdXC0d7QB7S-qw
312	!dKcbdDATuwwphjRPQP:localhost	$BJjfbIWO7SRyJUYt2W16plyo7Vge28yvihe00hXY5eM
313	!dKcbdDATuwwphjRPQP:localhost	$fCJ8ZVUwK005ZC5W15tchQk6yITJm0QNnLDQbHh0vRw
314	!kmbTYjjsDRDHGgVqUP:localhost	$NpB149LSQCeoQ2CN4pBZ-eAFNrwAkWoX9Tm3oBcr0lA
315	!kmbTYjjsDRDHGgVqUP:localhost	$58ZOy45BulwCfOXfmNjgcwgTCSHJRVXmFu7g0DBS-S0
317	!kmbTYjjsDRDHGgVqUP:localhost	$2uakM8131VJaDpHoLXOMSFJ6iH-WSUC9Bc7qZoyAe8M
345	!dKcbdDATuwwphjRPQP:localhost	$0wZHcHMKbNb3_HQlP7OaPWZmz_2M_PhY2aS_yvOJf6s
357	!dKcbdDATuwwphjRPQP:localhost	$9i3p0sl8iw-4rVjwMHJnTFujme1in4rnO1zkP9hPq8w
316	!dKcbdDATuwwphjRPQP:localhost	$6WD4GwrjiOweRzus0U7k_br9MA6ItqEjRwUQewtaSlk
318	!dKcbdDATuwwphjRPQP:localhost	$ZOA5CmJBW5jFwb0P11yiLkfPkIxUFa_WirC-e4EgHgY
321	!kmbTYjjsDRDHGgVqUP:localhost	$lQaF0IuuiE3nyH9hfvYC5haDYc7DNTJgS8TRoRk72sc
322	!kmbTYjjsDRDHGgVqUP:localhost	$KfPuruJi9WSX9utHuejsg4KQUfSb8KC10qeYZ3A-MvQ
329	!kmbTYjjsDRDHGgVqUP:localhost	$Lp6oWL5XMW9C7d3BgJa5Wym_oGCobgxcRs3lvumP0wo
334	!kmbTYjjsDRDHGgVqUP:localhost	$3CJ8qoc6n0fCyIuR55SvFzN27bZDLSJkBoZVvbU53dA
337	!kmbTYjjsDRDHGgVqUP:localhost	$gT4wR_3nxsvf68d4n3i54-GPFvmk0UIZ9ysgv30Sbi4
339	!kmbTYjjsDRDHGgVqUP:localhost	$y5Pkc0ehBYCShZFYZ_vPlVgpiw_99AhNZsps2u_fjm0
343	!dKcbdDATuwwphjRPQP:localhost	$UP1_PqQCdJgYfG3ar1g9j25Btb4K2IFwybbWkllGXpQ
348	!dKcbdDATuwwphjRPQP:localhost	$_6pNGWmE3CVhhekVZUQ_FgJVOC7aNE2TKs1LiWuPCRA
351	!dKcbdDATuwwphjRPQP:localhost	$Op0TBQz5bRKUyxhUgvd0RMEbDt0BloR6y_aUatQJcO4
352	!kmbTYjjsDRDHGgVqUP:localhost	$KjxZjGyxoIyEvF0d6WjubIy5-PjQ8gTixRenqiw88iA
319	!kmbTYjjsDRDHGgVqUP:localhost	$sU2o99fcmX-dJIwmqMx6vylWt2uH_cI5fe6tnpc-1C4
324	!dKcbdDATuwwphjRPQP:localhost	$oKDO2xzyevl4Bbgsq8OU5pRoSFeamgVL-8yqZzmD6PU
327	!dKcbdDATuwwphjRPQP:localhost	$ob0hvf_1UhFTYQ5Ka0kVQYTlhwQMZJfK_-IqusjDFSI
330	!dKcbdDATuwwphjRPQP:localhost	$8ev9UN9u42sjBV7z0-UUuYgwjOcyvBAJ2NmRLV6HLsk
331	!kmbTYjjsDRDHGgVqUP:localhost	$tTct6UC4chzZoCQxVDeG20QT_VFl8no7v3zUhWiWplI
342	!kmbTYjjsDRDHGgVqUP:localhost	$sVsScgvVnYwe5O67jvt70HoldKxd0tvQMeduu2xNxOs
320	!dKcbdDATuwwphjRPQP:localhost	$rk3nAC_mbUEeriUcG9oFR47PX7yw-nDFZQn-XDySqsE
325	!kmbTYjjsDRDHGgVqUP:localhost	$hG6UnvTjxBEH5OvoW4eqsAeonJoCmYOrnBspvon_iu8
328	!kmbTYjjsDRDHGgVqUP:localhost	$9UbUv1ziiJ6NDByi2DupLmoskuTkslmBtsmnYpnA7ig
332	!dKcbdDATuwwphjRPQP:localhost	$0SSS7ZSZbHI5LQ7h4rsS20xlRRpZdlMblEfu6gd6hoY
353	!dKcbdDATuwwphjRPQP:localhost	$zUomLm3mThwuYeUXH2UXzsuqxE6DQeH_95sT95psJag
323	!dKcbdDATuwwphjRPQP:localhost	$OoLkvEmnMtM9N202Ewa59t_aytFrZ4hJiAe5Y8cIWWs
338	!dKcbdDATuwwphjRPQP:localhost	$blKb6TnbTahKyhtp1uWggk5ghgejFMqWuxB785aAUBk
340	!dKcbdDATuwwphjRPQP:localhost	$pHb1_CgrV8Q3wcwx8MEr6ty97wb4wfs1iSjBBO0QfFA
344	!kmbTYjjsDRDHGgVqUP:localhost	$omRpIBNwS3dmUSFoxFnXEepeNsfJgZCDl7piUIZ0R_w
349	!kmbTYjjsDRDHGgVqUP:localhost	$dceJQcyKlSKFVNNcV-XXe-wYnxpRc_5R7w27-Fiadmk
326	!dKcbdDATuwwphjRPQP:localhost	$uQRFhx8oPJdKNVWHXBm3R_uZqEa8Kr-jGirS4AtULgM
333	!kmbTYjjsDRDHGgVqUP:localhost	$yXLZ1V5hlF5dCa9Mfng3zrHlIwsWWWkCuM9Qg07zHS4
335	!dKcbdDATuwwphjRPQP:localhost	$9hug2iul8IyTcPKSEtlsL-r3z0QTjNAZoJ3L9P5pvrc
336	!dKcbdDATuwwphjRPQP:localhost	$ib3O-PfWFyGliGGTSO7B6JzFkMWWSl3gNM8Z_EPURkg
341	!dKcbdDATuwwphjRPQP:localhost	$ZqRJOUm8TgYD5dpGag__9MQ4fU2o70fHX0sJBeMQxD8
346	!kmbTYjjsDRDHGgVqUP:localhost	$GcATD9gWzOntrM_-dgkqcPZEfysPV-0mcsSdvFZjfuc
347	!kmbTYjjsDRDHGgVqUP:localhost	$JyR7yFAn8DoVezoMeFt0GDGdAJdlTAJlO4o7PZnQNjE
350	!dKcbdDATuwwphjRPQP:localhost	$vqpeVXbQRMk1Oz1jfMlyPdiItesHjk6VSax2IEsIeU4
354	!kmbTYjjsDRDHGgVqUP:localhost	$XMPmaEvrP8Ebnl1P6-T-4JWR8Ms1HgLkboYib2Z0LAI
355	!dKcbdDATuwwphjRPQP:localhost	$sKC-AGmNhmjm9fAYYksybJgXr_tCsBeZrEAv6k7VTyk
356	!kmbTYjjsDRDHGgVqUP:localhost	$8Lzt8KQPe0wAkuTOKq6BkdBqXu9LrnnsSyeYQ70hPDs
358	!kmbTYjjsDRDHGgVqUP:localhost	$1c97W6vcISTaUEtVZ3XtpTvdbUxTp84W9UUnJ7yQ1hI
359	!kmbTYjjsDRDHGgVqUP:localhost	$E_ffgnOG3LQqftvNZTrqtqWIYSu7K-Od5IBhdtJik4M
360	!dKcbdDATuwwphjRPQP:localhost	$hxQN9v1jskMaFj7Oea0TnONdZ-2IU5r63dktwdVjSb4
361	!dKcbdDATuwwphjRPQP:localhost	$nBfECAms3jYX98ClcP7jHlxsZFZPShGshoeC8cP51K8
362	!kmbTYjjsDRDHGgVqUP:localhost	$03Ov0NWr4ocHjT2sofFZb-NVdkmBwDqMWSRMJqWjHQ8
363	!kmbTYjjsDRDHGgVqUP:localhost	$1bObCi5fAcbbrNE-smwH6AECySiqu02SdF1HcZiNLS4
364	!dKcbdDATuwwphjRPQP:localhost	$smqDLILNOVZazXn4eYC5OSifMqqH-xHqeKPLOyVLrP4
365	!kmbTYjjsDRDHGgVqUP:localhost	$NnCes_L4ehaZSWsjKLUxag3jLMGd6UoqN1ukXrFSGvI
366	!kmbTYjjsDRDHGgVqUP:localhost	$OD6-n91qVi0ncfhxaxv2ZX8Ty40lwpxnf2J-vf8hOro
367	!kmbTYjjsDRDHGgVqUP:localhost	$m6k1D_gFOkdQm0ONrDD0C2Eepl60zWaqYMlVCpXOtmA
368	!dKcbdDATuwwphjRPQP:localhost	$YAh_aGe2I-GyzUPhPR7JlYTsh52xsGXztSMwzelAlgM
369	!kmbTYjjsDRDHGgVqUP:localhost	$6xID9TCNz-RpcIZdVbfplXxRT-3XbG4uAkc34QhTPpg
370	!kmbTYjjsDRDHGgVqUP:localhost	$k82kldzQ2_vs4adbqoKhWdl3ZjHAyBOCubSZsMRwacE
371	!kmbTYjjsDRDHGgVqUP:localhost	$dIPPE3QBGDou378mU9Y4SmE3TsFwOMwlM9NurC7Gows
372	!dKcbdDATuwwphjRPQP:localhost	$DTJ07HHe6J-06vC8yePJe-CcozdQglm6x9ILr5ZKPyk
373	!kmbTYjjsDRDHGgVqUP:localhost	$BjcXTtpum8XWkGQrL8j6VGIIBrYSnBRW9gUN_nTKnxo
374	!dKcbdDATuwwphjRPQP:localhost	$03KQwLeZTiLNq7k7DooZfwkE-cw4qF-6vaA53d1rKT8
375	!kmbTYjjsDRDHGgVqUP:localhost	$xjFT_xMUrX-xZ9UGtwR4YkBwC0vOSsAF-4B-e568zW4
376	!dKcbdDATuwwphjRPQP:localhost	$Mg6fyelB36WKXECwON2O2Cr-JEQ9xAVPbkaR_sI8Cvg
377	!kmbTYjjsDRDHGgVqUP:localhost	$wiQhyG_4bJ1olQg0plsG2mjuraWaOJLwSOOIJyWm4ic
378	!dKcbdDATuwwphjRPQP:localhost	$-dqC3h5F-megGnhTrHam8MEfahqMCdkAwX93uCerMio
379	!kmbTYjjsDRDHGgVqUP:localhost	$NWVZk4K7N1GfhInWD02-THmB0h8Ect-bOVLbMKa-NG8
380	!dKcbdDATuwwphjRPQP:localhost	$NLAbxhrOwvTXPQgMd522ipqrrlIemkAipLkDBZ2L8FQ
381	!dKcbdDATuwwphjRPQP:localhost	$MWBbgUUHEQu2Kforln-kleSDdCdtibzziEA1aS-fEDo
382	!dKcbdDATuwwphjRPQP:localhost	$syYUwRJl1hIGRWsxbbmDiAvRvFc-2_btHSpMmJVyQH0
383	!dKcbdDATuwwphjRPQP:localhost	$Qh4VtM54drJ8g25vGuwkCD5VqhgwhbOnJLcP5qTDdps
384	!dKcbdDATuwwphjRPQP:localhost	$QjUskGVE5PDuWbZzwvOb-zUAqxgaoN84LRLhfUYdEzk
385	!kmbTYjjsDRDHGgVqUP:localhost	$Z3lb84md9FuILJsuZwO-q3dtA88DQ7oqEDoTjd31QUI
386	!dKcbdDATuwwphjRPQP:localhost	$B6pluS0ISlXPPp8Qb7N97HoutiTFT0H7H9nCJJMLYTI
387	!kmbTYjjsDRDHGgVqUP:localhost	$gjVF442oFQaSlwHxmy_6J2h-E8W_yMnW8AJFTlwfblU
388	!kmbTYjjsDRDHGgVqUP:localhost	$QK0lT3rot6JRP7PC2IU--7WNKGywkXNbrSS1ZnEPXd4
389	!dKcbdDATuwwphjRPQP:localhost	$bQgCyxbKjQUL4aOK37wctj80bKRlDEbdpQSQdawVA5M
390	!dKcbdDATuwwphjRPQP:localhost	$_m4hSeuxFF5C5VL5ml4C236AdJ2ha7GFpiHqsA0T46U
391	!kmbTYjjsDRDHGgVqUP:localhost	$F7TpyPdzymo1ldMUgE5TZRtE1ZQ6f5_QSrbRNUIXdok
392	!dKcbdDATuwwphjRPQP:localhost	$JIjm4MLGNTB7uYCfpyRki4OQvFf3wdLm5_Jyp5wy_eo
393	!kmbTYjjsDRDHGgVqUP:localhost	$6d5VPDhqRSPxM8XIMrXAlO3QVxGovm1TFB4zAaY9-sA
394	!kmbTYjjsDRDHGgVqUP:localhost	$SnyKQyEiCCPdZhluvyOBC9d0Dx2Wu_XM1GuTLaCFv_I
395	!kmbTYjjsDRDHGgVqUP:localhost	$gICPE7fVCrb3Uwspg_AeqAzHhqGjX8LV9LG0E1MRE34
396	!dKcbdDATuwwphjRPQP:localhost	$o9OgS_kp4k10KkrqitSVrkn9STx-F42VVRF8EFSrXUo
397	!dKcbdDATuwwphjRPQP:localhost	$YkYvAReh3CXbkRiKRCH1SmKkc5P7E8Cj-PBRiYc4KHk
398	!dKcbdDATuwwphjRPQP:localhost	$h-Atv0_2osOXLjfJ-8t9IlaV_zxC4bhsi_AYlJg1NOM
399	!kmbTYjjsDRDHGgVqUP:localhost	$cQ9cNICpyvXgbrMv_NhTWUIBZYtr-uO0B5spC7u-zYk
400	!dKcbdDATuwwphjRPQP:localhost	$k-dpzcN-i5_jJkLZgB3Cx2PeYPZCMaFX4oj_pJLoYlk
401	!kmbTYjjsDRDHGgVqUP:localhost	$5A0dwVhtEX480RoPd66xAxm_COlUP9njI10BuUkASrI
402	!dKcbdDATuwwphjRPQP:localhost	$z7uq7yRHlV3atA_5pjhOpPH0ZgxDwtZLIePsJt2FOQE
403	!kmbTYjjsDRDHGgVqUP:localhost	$91B3wKbbOy-p6-_J4KaZXG2WklxfLJiraoGEDyx47Q4
404	!dKcbdDATuwwphjRPQP:localhost	$W6h6tuDui8tLY89dtOtdYbeULMbmzn7-6z1S_QZpdS0
405	!kmbTYjjsDRDHGgVqUP:localhost	$jAe8FqU9mMmrte3grv2ZA3Xqk354_humjzNVKx2mElk
406	!dKcbdDATuwwphjRPQP:localhost	$Y7O7reJuDgKHzz5gRvjNwOh4WOQsOKvw0vYIuyWUilc
407	!dKcbdDATuwwphjRPQP:localhost	$kdbJNSxuAA4Ngmc1kCOZCzPEwDuI5AeFHALqsCS4elU
408	!kmbTYjjsDRDHGgVqUP:localhost	$fU1bJEWaXrfUrMmcSz_mfgs_DwRFngl8eAdFCXA8wC4
409	!kmbTYjjsDRDHGgVqUP:localhost	$w-vX84CASAduViO2hLevAm4pATNqtpvW-NDTFis9MQ0
410	!dKcbdDATuwwphjRPQP:localhost	$-qK0oir09kKPxFo5YjkDmL5nXsLvKqCxrJqe_Pls2Z8
411	!kmbTYjjsDRDHGgVqUP:localhost	$9vnrIIvmE9HJhD9bpKbhtRQJNLrTX_R8hYwFihomyAo
412	!dKcbdDATuwwphjRPQP:localhost	$Tdh7YbxcAf-w_3RsfAhM1w5Blnz74lVt8beWxk8aX80
413	!kmbTYjjsDRDHGgVqUP:localhost	$kSwvEXASnPGHobpchuSH3tjquiVt9jZZpBqtwpOIXB4
414	!kmbTYjjsDRDHGgVqUP:localhost	$U0W0nPmHIlLpxhiDB-1ybL3jEuCQlslb5EfFzF3cmJg
415	!dKcbdDATuwwphjRPQP:localhost	$kQCP-XgdtidbaoQ8t_FcIVRpbr2reMeN9BlmH8NgHoQ
416	!dKcbdDATuwwphjRPQP:localhost	$It1nkT37IMvvWoNsumFX_olMFx3d9V-rvYRgWTTcFCw
417	!kmbTYjjsDRDHGgVqUP:localhost	$-iOLumQlL9weMxGvPUSXOpXr2jNkj55p83LxuxWuZRo
418	!kmbTYjjsDRDHGgVqUP:localhost	$VXV75_AO7FAHgKX-BY-LGppfuY-gvltLLWHwR7HgZ1U
419	!dKcbdDATuwwphjRPQP:localhost	$VhtISDLe4N7Uywm0XPk-CJgTlsxZswl_hNcHiBjZzf8
420	!kmbTYjjsDRDHGgVqUP:localhost	$dE9AXEt-ibN6n4TE5G8h8h51bfjW7gwKTAswFb6Y96Q
421	!dKcbdDATuwwphjRPQP:localhost	$d-nlW63-gUx-1l5iVBriA0L6xT2DUSYtrKXmmJJJG1o
424	!kmbTYjjsDRDHGgVqUP:localhost	$ghk_5O4ASIhXCtmdmfLI9L10I04XSKL6yslBcC1bMsU
433	!dKcbdDATuwwphjRPQP:localhost	$xk4YfGryLq04gsnuycfCV6CskGswdkdNg_4ex2w6rDw
422	!kmbTYjjsDRDHGgVqUP:localhost	$d1x5Bv2lxBhKvhxm9iL0LD0JMC8SVmT1wwO_-l6K63c
423	!dKcbdDATuwwphjRPQP:localhost	$ZATHF7fZwsa5PN3-MJUbq9keezgMw-84_jyDu9WN_TU
435	!dKcbdDATuwwphjRPQP:localhost	$aqYokooe6j_Ge2qKkT0aa-6HcsHoRXXl-VGjrqFi-Ec
437	!dKcbdDATuwwphjRPQP:localhost	$2sLfClcLYp86jeOi87fgT9PzSgLedlvHZfy9wM9La6Y
425	!kmbTYjjsDRDHGgVqUP:localhost	$bxuVS5FayXodn0thLWn3dbMXUjYMHyaoAmZMxz5QHEk
426	!dKcbdDATuwwphjRPQP:localhost	$o6LK2jj0-WrfwTSKp7Nkqs4mlcf7kli-TMTOSMVVp18
427	!kmbTYjjsDRDHGgVqUP:localhost	$qqHLJ4_jVX2dT5v7Zifsk89RTJrqEsZY8cHQkkeTH1M
428	!dKcbdDATuwwphjRPQP:localhost	$PSSDE6G2Opv54bYlA8uKwssoIS8yEJGeXB1Th2W8plM
429	!kmbTYjjsDRDHGgVqUP:localhost	$k41_5cxJXnYEUcfHM8aEkkK_kLkKGgqF6eia9KhNRrA
430	!kmbTYjjsDRDHGgVqUP:localhost	$J_VxtSqnumSh1QJ8aUO_QwIPbef5FUzbGZyAUijfKXU
431	!dKcbdDATuwwphjRPQP:localhost	$lBTfQYdSf9fk6wyuE9Yf_LjnX6nZKxYsGyJxrsdY6TQ
432	!kmbTYjjsDRDHGgVqUP:localhost	$82eCeBgVkTQnIiAJjesspqjDQEM1iK2J8ZMVNLIN-qk
434	!kmbTYjjsDRDHGgVqUP:localhost	$msxftcdpRjOn87KzmJ1l0ekrw_L2MshrqNcY5acBil0
436	!kmbTYjjsDRDHGgVqUP:localhost	$RX7xAmYcXlUMB78kQY-mbE3LNTB4pZck046xGKJIrjw
438	!dKcbdDATuwwphjRPQP:localhost	$vqy4uMnUlF1Af39dolKO10TPLVgMuUCNri6RRW5zLbs
439	!dKcbdDATuwwphjRPQP:localhost	$pvgqnjHNptVGIYdaz0Vu-03WNvGqaHBxP-32wxTvRW4
440	!dKcbdDATuwwphjRPQP:localhost	$7YwSP0ojWMKFb6yYTov2f672ztECo_ca-X7b_15z1dQ
441	!kmbTYjjsDRDHGgVqUP:localhost	$WApPSBSI7vLXxQ7UVV9m2XLuYAKhIfunaE83pMuiKzk
442	!kmbTYjjsDRDHGgVqUP:localhost	$DAkHhUSrwdSVEVvsvj0T0FnTKF_f9Fk5OPIBcSr3m-A
443	!dKcbdDATuwwphjRPQP:localhost	$HzG8V5dvnDih4OOxhKA7ioWTE5O4dWd7y6CwXI7pEtk
444	!dKcbdDATuwwphjRPQP:localhost	$RUgd5sljaDC7qarKKtogmwkttnA7UYsOV66Ot2yYXp8
445	!kmbTYjjsDRDHGgVqUP:localhost	$Da7xOchoJrNGZ8RMyHyaLFYsuCbroArXCyb_X39pw_Y
446	!dKcbdDATuwwphjRPQP:localhost	$x_YyL0NEmor5-l1z7XAxomi3ZgOjLXL63LPofI-lHxk
447	!dKcbdDATuwwphjRPQP:localhost	$87xrs4WAcKqZ97aqqW2jcnIOnVitwFvPx7NrmhcVYCQ
448	!kmbTYjjsDRDHGgVqUP:localhost	$SkqwjL9UqyqxnmeuNbaptHasJCkUtNajzT-FQSJE5hc
449	!kmbTYjjsDRDHGgVqUP:localhost	$AfIfxfCCP1mpifSu1SFd1-jOcITywde_bA8c2Qp-Qc4
450	!dKcbdDATuwwphjRPQP:localhost	$_-rM0WaJ_j5cVYu65gZTmDNZ3p8qjfAxLdNj1BC0JQw
451	!kmbTYjjsDRDHGgVqUP:localhost	$_UVAyljO4i2-J-8JlYAtMutiyS7Wf_6_EQHpDm0zWPI
452	!kmbTYjjsDRDHGgVqUP:localhost	$x2kPX--8V7vg3W5IwXw-lxVcJvu61FPd3PTslD4cQY0
453	!dKcbdDATuwwphjRPQP:localhost	$HU7w_1RyGT5rhAaPl6k6vW91etJMw6xC8qiX-qVzSZc
454	!kmbTYjjsDRDHGgVqUP:localhost	$YdTAcOePopiKAKM_5bviyVbbU0VimSkKNBR9Qigcbmk
455	!kmbTYjjsDRDHGgVqUP:localhost	$ST587tP0ZzPWz1-y3o1wLvfJ20ELxm1AL6ZoElmJCq4
456	!kmbTYjjsDRDHGgVqUP:localhost	$9euqeLKRUG671hw0OAdJRNc4wuApiqg5qfK9HRurIOE
457	!dKcbdDATuwwphjRPQP:localhost	$XEMvcj_0Nu1_qWpmR-zbCDEFwCPVcTWmWYCiLl4o36M
458	!kmbTYjjsDRDHGgVqUP:localhost	$xjnDBD3CYNYeC00129Gp5FZPoqpeGOsQRtPDnx-rwxo
459	!kmbTYjjsDRDHGgVqUP:localhost	$r70e6UupQF0P05RBv08fb0kn40fMXSAcwmLtA11KjAE
460	!dKcbdDATuwwphjRPQP:localhost	$iTpsDXH-DOVNiqasHYFnaJVQ8_URs1iPU0XCyLuZqEA
461	!kmbTYjjsDRDHGgVqUP:localhost	$ctSxuddVjdig6Q4qdrs5T_mIEmQ9D2vRAqX1wuMDxm8
462	!dKcbdDATuwwphjRPQP:localhost	$u3VA-BShTTexLCrAeWITbqk9QnyBo6H79XtIu_uYUt8
463	!dKcbdDATuwwphjRPQP:localhost	$vwdw7H2kOywXTzCWGkqXLbL-tauBsZTYFfFqUP96mcM
464	!dKcbdDATuwwphjRPQP:localhost	$WK2_ikeAhuC3BcBKM66EWyMT2tZ4dx0HP28TDgcpnqU
465	!dKcbdDATuwwphjRPQP:localhost	$pmnljLnLxMHY186VqjwwBrF9FIlCiOefKXa5TyPn-WQ
466	!kmbTYjjsDRDHGgVqUP:localhost	$NlrLjPqVpscFGK1txNQAZf-7mZRfbN7s0_LSb83-gaM
467	!dKcbdDATuwwphjRPQP:localhost	$SQgZemcc_oHa6ciqZnVbqxx26mIMpQecUKd-Vek3auw
468	!kmbTYjjsDRDHGgVqUP:localhost	$kdnCA2aN-0o1RZ-3ocQOPTNdc73Si0VL-INICMQrU64
469	!dKcbdDATuwwphjRPQP:localhost	$A5KlE17b_R6XqKET9K_TZa6MV5ri5nEe1PZZa5nxUDg
470	!dKcbdDATuwwphjRPQP:localhost	$boA4czH5oIsvFc6x_KDCG_swzSmQGxl27gKO9ZOui2g
471	!kmbTYjjsDRDHGgVqUP:localhost	$r-terwMhDUst83AP3BuF_65QxRFF_Bz31yXmwcwiCkw
472	!kmbTYjjsDRDHGgVqUP:localhost	$aeOkj7LoMaGdAmvBC2Bc4uEIRWdNQjeqANnY9gebuAg
473	!dKcbdDATuwwphjRPQP:localhost	$TzcjfhPwQnyxQyDTJHZ3enB5uS4vuGo2KZ9hWhMd7DA
474	!dKcbdDATuwwphjRPQP:localhost	$qm81FwKKxEmXU41v9_It0hqd_DP-rP6J1OWUj66euj8
475	!kmbTYjjsDRDHGgVqUP:localhost	$K6k8nwmvbzlcqKtJQxyXIWbnHWP2Dr2W_eixSKZM2WI
476	!dKcbdDATuwwphjRPQP:localhost	$XbSswxHbGv6u0RoNSYFgc-8QeaEO2TwzytUZh5grS8o
477	!kmbTYjjsDRDHGgVqUP:localhost	$e3KeYP4IszF6dC4pVivY4C31rqzBkF9AfbYPp_XM3hs
478	!dKcbdDATuwwphjRPQP:localhost	$39K2kmcIVRCqhSKHuKvnnMiz9N5hNnlJVYnU_B3EvRQ
479	!kmbTYjjsDRDHGgVqUP:localhost	$PnOFYCidglsH25hKt3JstSjBQmTj02uuCUsYMp9a0PU
480	!dKcbdDATuwwphjRPQP:localhost	$yNqdKiVuGHDuCN1HPns2LJiDCYkyhrY06WMSMDRXxaE
481	!kmbTYjjsDRDHGgVqUP:localhost	$jSqIAhQEc4VxZvd4W3BH8IxV-UO-Tj0Hm0fo4RAJX8E
482	!dKcbdDATuwwphjRPQP:localhost	$F5VyJX5kdbjHRvGMizgebzAIRdrasV1JS0UmUKCiKuo
483	!kmbTYjjsDRDHGgVqUP:localhost	$VQpFjJTDuKaOnZ5CYFxRFQ-OWTuFVUX7-jGtg1Ile48
484	!dKcbdDATuwwphjRPQP:localhost	$p3QZHNokAwpgE0_Frg-HUUYfQNHwEZSyg7XoQ5e-OcY
485	!kmbTYjjsDRDHGgVqUP:localhost	$xsOY5znQhUAgS2eZttlpieqrRNhWOh5Wq2Cwkw86SUs
486	!kmbTYjjsDRDHGgVqUP:localhost	$2lyxlgHkujicxG-7KdYJDtcW0A_day2NRrTrwpx49Bw
487	!dKcbdDATuwwphjRPQP:localhost	$z9kfJtZShMmrPKUBf33ZOO6kUAGyQGvYjAApKC0LPDg
488	!kmbTYjjsDRDHGgVqUP:localhost	$AOnPNAvpB2aF2OiBCfocVvA_0eCcZjIKPdXT6rF5ghc
489	!dKcbdDATuwwphjRPQP:localhost	$gYeuzPYTXMj_j9kMC_vV0ZGrBwoFXjdkwCVwGarhLd0
490	!kmbTYjjsDRDHGgVqUP:localhost	$76rQNRORitSAvr0yhpzW4AdFdzSv4ctOef75l7NPWo8
491	!dKcbdDATuwwphjRPQP:localhost	$WYTPImcY7w8cd8Z1948NM1Xbr5A9DajlT0afbkBWK6g
492	!dKcbdDATuwwphjRPQP:localhost	$pjgbR_STMPETTha39k-nJOVoTpeld4earSgurREcAhs
493	!kmbTYjjsDRDHGgVqUP:localhost	$b2OCKyutowQ_OGdva-D1m0KmvPSnr5K1jdA0C_H6Qt0
494	!kmbTYjjsDRDHGgVqUP:localhost	$86xAB58n4pUYJDS-IsnyLa8zzu90JcoWWMK9hJkl9EQ
495	!dKcbdDATuwwphjRPQP:localhost	$WPUR9p2vIiwdUy_gTbvT4pHtjZV7sNMlPVxoTpQ8Gyc
496	!kmbTYjjsDRDHGgVqUP:localhost	$AV3RSR_MYh_v4QNz4O5pWvHRLagte3FLcD3pZXpoe9Q
497	!kmbTYjjsDRDHGgVqUP:localhost	$d-xqAkcQFHQ5UqEtzTkdDVJJriIK8LcgGjZ43XM_1oI
498	!dKcbdDATuwwphjRPQP:localhost	$Y6bkAK4aoQPqfs776xSSqw8V7U44ZRNxOYHzxQuYRk8
500	!kmbTYjjsDRDHGgVqUP:localhost	$-TUAFAJ3DeC1ra_qTxLxXuajBBr7FfvLxYe93JjDbLg
503	!dKcbdDATuwwphjRPQP:localhost	$vACJgOgH6s_GfB3xYx6v2UkrE7SKkDLL8CGm7jC8ULE
505	!kmbTYjjsDRDHGgVqUP:localhost	$n1YkCaXOhJ--xLl9Zx3JDBYOM7Qub-79dmxVYZayT2A
512	!dKcbdDATuwwphjRPQP:localhost	$TPhmQuU3yZ_HkKqABfBVZUvaGvsNVtunNb23J4-1cZc
517	!dKcbdDATuwwphjRPQP:localhost	$8kDzrELlE_UWnL5hK1DxcZTtP9PTMKW0qMt0etA-BPU
499	!kmbTYjjsDRDHGgVqUP:localhost	$jDI9EgxmfsYgQ3BlMAQdRhdhIUx2_ItL8wmMiyw8VGs
501	!kmbTYjjsDRDHGgVqUP:localhost	$M2zAHDZELuOmni3_O6DP0M0od7GtjKI-yqb80diYQDI
507	!kmbTYjjsDRDHGgVqUP:localhost	$8Y5WPNcrfiBDzVeUPp9TJ21RQ-8qrMkR_baEYaKb2_4
510	!kmbTYjjsDRDHGgVqUP:localhost	$F7QGWDlMZOSQFP27Aq8OmXqK11O3r-FqzbLCqhYGFfw
513	!dKcbdDATuwwphjRPQP:localhost	$vxGipjBvv6SWX2hxqn915K6H4-jTXv0uo1lr5pUAjfI
502	!kmbTYjjsDRDHGgVqUP:localhost	$2hxZAjhfPZ2DxJznIQyebkGr9-5LPDuuMBsdyyuoQQM
504	!kmbTYjjsDRDHGgVqUP:localhost	$6gP-Tehjbk1XPxDMJXrz8UOSUKAh086BRTtE3rb4sBU
506	!dKcbdDATuwwphjRPQP:localhost	$7qNGy0PqgrjH5546Iei5p8fQdGExuvpGdXq71CDz_qs
508	!dKcbdDATuwwphjRPQP:localhost	$qxjtyk5wJbpHl22XRlAkrwmBCT7nO_NAB5vDQhdzYrE
509	!kmbTYjjsDRDHGgVqUP:localhost	$09Pn4aaVcJsK8VsKH8iU9lRfIH3_BTlqJ_Zs6r1DqG4
511	!dKcbdDATuwwphjRPQP:localhost	$Qt6MQ_IqqOXmNIJ4_OsYnAGsFIP5DPRs9vno86KcqTg
514	!dKcbdDATuwwphjRPQP:localhost	$cOo6lq5DWcfcn26OOfdgeFZAq2zdOCKy3veWZFVM2Ns
515	!dKcbdDATuwwphjRPQP:localhost	$OiCVh2G9iZOuLdECqktyLkT4TLL_qjK24E_W8Tq1DUA
516	!dKcbdDATuwwphjRPQP:localhost	$GHkGku7nSpHPMQjSNI4qxwD8HSOWv9VnVXSsGT6JHZg
518	!kmbTYjjsDRDHGgVqUP:localhost	$_tvCWC3fX4jTHEPdegTywi-uE7Cnm7K7iAhxBz8WD_E
519	!dKcbdDATuwwphjRPQP:localhost	$CoYgR2hnSlwAq76fP_i-gD_F1b6e9qZd6g1wdukinnE
520	!kmbTYjjsDRDHGgVqUP:localhost	$Ab0o7NeD-KQ2tyno_Srrq32pG70sdvmuYoToqIpXbl8
521	!dKcbdDATuwwphjRPQP:localhost	$48xcJgrplfq8wWsfMWxgXujxW3rzvQpk648z_SJM89g
522	!dKcbdDATuwwphjRPQP:localhost	$1e3sHlt53tIWdX5ktRhL5qsjodG5jN499ttoQEnCMKg
523	!dKcbdDATuwwphjRPQP:localhost	$zR3Fe8BpkvJlBP7tCC6chrQTN5UwuoKWWghUgceFN1U
524	!kmbTYjjsDRDHGgVqUP:localhost	$2ggJ1_gc0uRb_x03ufyH23bfxBejHpkU_ADUzaSQl9c
525	!dKcbdDATuwwphjRPQP:localhost	$zSuHxPD9U4iFva2bdGqApP-AEpJhXG_3ZT7KWKQWoIc
526	!dKcbdDATuwwphjRPQP:localhost	$RD0DoBG1EPRM0tkCbCeDHbQ04g91UxDTWdZWLF4VbMM
527	!kmbTYjjsDRDHGgVqUP:localhost	$LgLbXnxdav6w2strPYj8Pc6vmR-sLUzuHMSqp47lt_M
528	!dKcbdDATuwwphjRPQP:localhost	$yGMQ8C-hHnAQkDZAH79Gn_YqZqOTC3tXEu0zoS-Ttcc
529	!dKcbdDATuwwphjRPQP:localhost	$nLE0H5oYr7dYKUpGT_pVtT-Go1wbKKIfCkHsR0FOFbg
530	!dKcbdDATuwwphjRPQP:localhost	$usinMOH0xtk8udhzzflTQGSxWUyc-2cspaD9HIWczT0
531	!kmbTYjjsDRDHGgVqUP:localhost	$TdT_y-RuJG26SBB_VGtdA7gVa-QC1MsVMhEjy9wApbE
532	!dKcbdDATuwwphjRPQP:localhost	$uFBaenQlmblZD7gKG6iq8N-22dI4AQ51U0vLEwu2qEI
533	!kmbTYjjsDRDHGgVqUP:localhost	$vRVBQUY85cDpR9KBp9wvJcLnjvDyvu2wLWxzNwG9jV4
534	!dKcbdDATuwwphjRPQP:localhost	$kkWADajf3lIUWFCK1ckiVmMrExjdZI9ZFjiODEzHngo
535	!kmbTYjjsDRDHGgVqUP:localhost	$-Pq5JwqcOPKJreW531L17c5HCs3KsZEi1ywYFuXnaCU
536	!dKcbdDATuwwphjRPQP:localhost	$zjiXxTJZVEYzoxZDY9uNqZIyiFCsB8c0DUm9U9Fuk7E
537	!kmbTYjjsDRDHGgVqUP:localhost	$dz-b3tZjrv6YZJNadBICyAbpKwtjt6idU2qUelK-nGY
538	!dKcbdDATuwwphjRPQP:localhost	$7IJzE6fE_UMKzW52F7gH3K6lpVbdDUh4O7ZukD7itbE
539	!kmbTYjjsDRDHGgVqUP:localhost	$4H2AvCHdYU9XHcCPIVFfFHRkZGUfChJAh3Q9A5DGF40
540	!kmbTYjjsDRDHGgVqUP:localhost	$YTuWG_BjbrzDVlSPohVXjBu8CXHnphyqqQuJXUJH7ew
541	!kmbTYjjsDRDHGgVqUP:localhost	$cC_ivr8rkeBAUa_FjTUl4d-KvOjdoETfmKGr_CaTwX0
542	!kmbTYjjsDRDHGgVqUP:localhost	$6jbKt2CVf_uarSrmNkuT-w_5LiEhn68tUWTigXnkYQ8
543	!kmbTYjjsDRDHGgVqUP:localhost	$Hgz4OXf2UnZVqHOwxztTXb-cC3_ClhTfyic8zoaJj1o
544	!kmbTYjjsDRDHGgVqUP:localhost	$nS6gLWANnbZw1Nc1RwIMv8HsvEKmnVgK3Vgu_mcDYDU
545	!dKcbdDATuwwphjRPQP:localhost	$gyMgyAgyM_OgDhvlQfBhO6d2XzEo-p-dxEl6bHnFgoE
546	!kmbTYjjsDRDHGgVqUP:localhost	$iiK1ZXn7Uuhn3ULIBrQqoToIUWVUJWDQR1BkKmy1JpI
547	!dKcbdDATuwwphjRPQP:localhost	$K44LOKteBlKOlr4ittzG55xQyL-yd5dbyyPxZK3RSpE
548	!kmbTYjjsDRDHGgVqUP:localhost	$Brjkd1XSPeknGy7f3dFRsRhUDJ8xemw_jLtjo1OVkSk
549	!kmbTYjjsDRDHGgVqUP:localhost	$e929UrhVOZoujef7MTan3ahOqZogL1vtGJtIi0GRQ0o
550	!dKcbdDATuwwphjRPQP:localhost	$71F_vJ40i3rgOX_Fb2_IJEs_t1NBabZvEZRM2sKqstg
551	!kmbTYjjsDRDHGgVqUP:localhost	$NUZkPXLg6U22UYdTs8VLlmUJ_TzC_PNGcVxRXKtTc2Q
552	!kmbTYjjsDRDHGgVqUP:localhost	$Ge2qRE3CRZECV0SYGTWGxPs-Qj22--xq3jpWgb73Cn4
553	!dKcbdDATuwwphjRPQP:localhost	$MuQCUy_UK5t2I3BvlNc5xhRFU8OjncdFwOYyv8TwLPs
554	!dKcbdDATuwwphjRPQP:localhost	$7kna76RM__wWZmXxNwYeR40VKRCf0-RFHTL3dsFpCOo
555	!kmbTYjjsDRDHGgVqUP:localhost	$F36u6nUjnCdDvRU829V6O0H31JjzG7P3cNemYfd8Qwc
556	!dKcbdDATuwwphjRPQP:localhost	$7I0OgyyShyLJ0KJDTal-J9rzXuED9II3sx7bUD9zOcs
557	!dKcbdDATuwwphjRPQP:localhost	$b4Oa3Z4fWHHEV_R4ZO1Hnq0c-SbS6fdHh-3LYy7Cxf4
558	!dKcbdDATuwwphjRPQP:localhost	$Joar5xoUxIMxVlDY8QADb5Yb9Xsrh89OqjAFN_ZI3JI
559	!kmbTYjjsDRDHGgVqUP:localhost	$c7rK_oUHfa9COHJCyxDrCEP9u17LjM29Wv2hEDrluh4
560	!kmbTYjjsDRDHGgVqUP:localhost	$9vL5EMBEZBlrQkyIjowaA52nvx-qaaM07vvDEgRoPQI
561	!dKcbdDATuwwphjRPQP:localhost	$OqfMWPUcuH0-mN1vDdvrcZ4_duQ89m6bwzV8_m8LlZ4
562	!kmbTYjjsDRDHGgVqUP:localhost	$Ux4Veb6_qNVwdoxPRSOa7TQdeWu7orjska5Nr-bMCHQ
563	!dKcbdDATuwwphjRPQP:localhost	$kg80-QZ-GqNmjWiTvdtM3PyInU570xi8Ri3flylf8Rc
564	!kmbTYjjsDRDHGgVqUP:localhost	$lHQO_kxfePQpvtGbVaxq0dGiIwAmNBZWx6-C0yDKexQ
565	!dKcbdDATuwwphjRPQP:localhost	$wsLJvM3oKyjMmCfj5N6J7JBw69TWBr3QH3zpv6NjTtw
566	!dKcbdDATuwwphjRPQP:localhost	$ZSEb9LVtUe5Ofgub8nGxoGTlmmOqvpqAUrHuLS4ktK8
567	!kmbTYjjsDRDHGgVqUP:localhost	$wMGUNQXfUeMOS61U4O1dlgsSFHW9B_UW4TJ4w5v2dzw
568	!dKcbdDATuwwphjRPQP:localhost	$_z4AETauBl517WV2yqqo91-ZTOGAb8X0cOq5GpR4VXY
569	!kmbTYjjsDRDHGgVqUP:localhost	$G1oiX5x0QEzwFx4ZozUTk3-67YpANQ10xP0sFe7DQmE
570	!dKcbdDATuwwphjRPQP:localhost	$4kDKT3sjvaMV6Qf8xEHcPi28ILt8Qim8nkCBYTo-s-g
571	!kmbTYjjsDRDHGgVqUP:localhost	$xMKZXTyFbWSdbyHmJC7nVAew4H1UeVy4R9xvTYuV8dU
572	!kmbTYjjsDRDHGgVqUP:localhost	$OEvju5T8L0IuYvWZHYAzLgD6lk1OIQifwAmN7YfFtfo
573	!dKcbdDATuwwphjRPQP:localhost	$arPgHhFHE6dBjd4gzvtryh_NNYZNhUYuwtim1WN99eE
574	!dKcbdDATuwwphjRPQP:localhost	$QQRR3vgD5VqktW1wNRnfJ-9SyQynllgkZpnhrt43-aY
575	!kmbTYjjsDRDHGgVqUP:localhost	$S12nkw4S7SzSSnw6cfDIe1tIoMCgOh7ya4ivQeISn5Y
576	!dKcbdDATuwwphjRPQP:localhost	$c8bdkx_lGsUPOOkcH7mapzpOjRlEXU8I1cRbU-B3ng4
577	!dKcbdDATuwwphjRPQP:localhost	$_Mop4qnrH3PEsOf7hBCpvQ41zO30kiSlFH21b2UPZsg
578	!kmbTYjjsDRDHGgVqUP:localhost	$2VR3ci7qaBedtDLAbpC1498ra4AV2HIjCQuSEbGzngA
579	!dKcbdDATuwwphjRPQP:localhost	$sWyL5ETIVY-60YXzDtL7VuQIMXAStBOL3fK3SHiQizA
583	!dKcbdDATuwwphjRPQP:localhost	$3IPqxhEMHwCe66RizYzXvwqnY7T4XQlDFzO2lXfHauU
590	!kmbTYjjsDRDHGgVqUP:localhost	$_ip99Kkg8HFVuRabzUje01wpi9FgO3SBSRUSCrklhi0
591	!dKcbdDATuwwphjRPQP:localhost	$Zba0b8GUHYv4hvdDLfz8ucLk4ZbKryM0URHPT0IvTBs
592	!kmbTYjjsDRDHGgVqUP:localhost	$agpJF9x2mt3cGpnc58d701Md6mJURV6NL9pPY53_kmk
594	!kmbTYjjsDRDHGgVqUP:localhost	$GGws1PR9ggV6ff4kQWuhjGrmxpbnEfda43y6yH7N5Ew
580	!dKcbdDATuwwphjRPQP:localhost	$HYC9MmU307vhBcAQUChcHC3uQSoZSGHwFWO5j1cLG8w
587	!dKcbdDATuwwphjRPQP:localhost	$WUnaXmFsKXKO9c5meSbhr8luj-OYMSWCvpyVJ9sBEeo
581	!dKcbdDATuwwphjRPQP:localhost	$pR3GcQhxqP7nAkvaCzSxn4CjmdqlyV12eR0mqgU2BEw
593	!kmbTYjjsDRDHGgVqUP:localhost	$kOUnZIPmtBD4GVGB0UtmnJPVRlHZnJ4n4Sr8QMo6Nmo
582	!kmbTYjjsDRDHGgVqUP:localhost	$jlVxUyaClnzULQOFZg307B7PLrtYQasYO5HKGlYFFtE
584	!kmbTYjjsDRDHGgVqUP:localhost	$pYd9AeXSBoTpdThMilTeIVqGMab_-Isfnixql9t1MC0
586	!kmbTYjjsDRDHGgVqUP:localhost	$TrhLO9mQUGGL8ZBvBy3aLrcByexW_2cCybLpWLHq1Zs
589	!dKcbdDATuwwphjRPQP:localhost	$4SaygUB8Ff43p300nR-kfheP_aQs3Zu8mUgtbBUNeO8
585	!dKcbdDATuwwphjRPQP:localhost	$zoyjvjZ4Mgo95oRQbzWEGf-yt5GMhqtmIRJuYuFeIVc
595	!kmbTYjjsDRDHGgVqUP:localhost	$ij2CDfzjXdlYcmp1Ghg_i0W3rGEmbA_PdMZbGKLvIkU
588	!kmbTYjjsDRDHGgVqUP:localhost	$-c5dig-9sw6zinQN9AIdQago8f0KOcgmUyhzMBjoJDI
596	!kmbTYjjsDRDHGgVqUP:localhost	$L-sRn17ud1mGJztg_U-7glC6U8sHRnuX6s9cRIpPQzk
597	!dKcbdDATuwwphjRPQP:localhost	$patHbWjJiGlVmgdMd2Ep8bxYHnHYxApMgtJMVgwZL3k
598	!kmbTYjjsDRDHGgVqUP:localhost	$iqL_RYNZlnzo0kbreDjl5YBRyp8U9kUnsTkjpkAe7_s
599	!dKcbdDATuwwphjRPQP:localhost	$TGtT7Tm80Eo7dubJEfWVOVM3C4LVxtsBsBu41-teCho
600	!dKcbdDATuwwphjRPQP:localhost	$KyRIVhdQK_Rm8T525IgNiiRvNzVcbNuPIs8fkLa4Ouo
601	!kmbTYjjsDRDHGgVqUP:localhost	$2iH2N82j_psiLayFBLHb5guudGi8DotXHL_IPaVQ9V4
602	!dKcbdDATuwwphjRPQP:localhost	$b1w4Uwg7wVi0RM9df-2BIMx16pe8hZY6NF5zFIvzgR0
603	!kmbTYjjsDRDHGgVqUP:localhost	$CB-1TfHAuG14c0YZT2lyEKEEZrcLOJQmX5nXrPuVigc
604	!dKcbdDATuwwphjRPQP:localhost	$XASM5-HjBQjRwrP_IR72f50wAwbc4WjX8xtSDOdgz98
605	!dKcbdDATuwwphjRPQP:localhost	$97z_eyk30lpsYzpHuTdpzza1JdRX4DQOmN4-d9AAFLw
606	!dKcbdDATuwwphjRPQP:localhost	$U5zKEbwku6ycvLYujToVsuuHyJCviiDEG-JnZRyZJns
607	!kmbTYjjsDRDHGgVqUP:localhost	$2GhkzEMhKOc6pz2oyi4Zd6APZ-kLHpw4fsvJx7xTOsM
608	!dKcbdDATuwwphjRPQP:localhost	$thbzS30z-1oaSbRth-uJt2fnjULmNZxml3DxFg9J0dg
609	!kmbTYjjsDRDHGgVqUP:localhost	$N81fzYD8ARJvuEs9ykEg1cei8mThJFsdMpS51A7AnJA
610	!dKcbdDATuwwphjRPQP:localhost	$uLlAnfd6a3gIXzL0Vo0hfcm5NLoNDJHfo5kmHQO4t4w
611	!kmbTYjjsDRDHGgVqUP:localhost	$OUMK51TPz2SjFwx4woMPhsqVdB-bJeCQOttqCA_FdmE
612	!dKcbdDATuwwphjRPQP:localhost	$RPjtshBezGfqnRDLopCdVwvF_IzEK64ods5n5SFyTVk
613	!kmbTYjjsDRDHGgVqUP:localhost	$B6Rjmsia35KAtCXcU6oYWgTsCvnDZy7xQqyx_1DUeXk
614	!dKcbdDATuwwphjRPQP:localhost	$sqjYP2hovrLJNRezSJWd0VLxIuhjhcx5Rf2_r0D4Hgw
615	!kmbTYjjsDRDHGgVqUP:localhost	$Its0qBq0NurlUJC6-uC4Z6Cnuc6dcFGoNenRDuCJuJI
616	!dKcbdDATuwwphjRPQP:localhost	$bWep3jEB42FmsjTRsH1-wjnfeTwWNPuK4xt0xcJEBkw
617	!kmbTYjjsDRDHGgVqUP:localhost	$q9vhGFqjxqZcprCCKb_UZtsxFbxujaX611rEFVQItEQ
618	!dKcbdDATuwwphjRPQP:localhost	$krAeY97shvwKyOJyTi90hXtAgwA-FeMo6zhV3-oDPGI
619	!kmbTYjjsDRDHGgVqUP:localhost	$pUWJJbBtvG8giWi-v5bYK9SJUzUZeGiR3l6NZfnuvec
620	!kmbTYjjsDRDHGgVqUP:localhost	$ekQ-3IPg1SiEZYCo6IQ59KJF9hxglZkE2u50I7MvwOo
621	!kmbTYjjsDRDHGgVqUP:localhost	$PXh6DUjewZfzQsCAfNHUGt5fYdXxNZisjFsBDY5wZ1g
622	!dKcbdDATuwwphjRPQP:localhost	$OJr4c-Ab8UBqFqPcQnpVSY860C1csNr72p6Qqsbeeqw
623	!kmbTYjjsDRDHGgVqUP:localhost	$3WCH-xpkO1-8jJ_vuwsl5aYzNeud4WnmxfSDfS14SgE
624	!kmbTYjjsDRDHGgVqUP:localhost	$pw3cuEtB-JMNp1n4SW0QgkztxfzHkY8D5sym5KckPaI
625	!dKcbdDATuwwphjRPQP:localhost	$e2niLQDLFE_mvRA4Zln1EQV5saBhhOEIuR9_ZfzoLA8
626	!kmbTYjjsDRDHGgVqUP:localhost	$Fq-A_5q0hHfaiaJBT-PKdB-YLhnmS__aRPL_ghsL2Qc
627	!kmbTYjjsDRDHGgVqUP:localhost	$mp5XfGOY8bqbz2ZKF66i_iYHSa6MQjVBtGCdPDOuw5o
628	!dKcbdDATuwwphjRPQP:localhost	$VHCbr3MOF4tHotX2KIjBScsYZqiE8wGdiqR0rpD7yEc
629	!kmbTYjjsDRDHGgVqUP:localhost	$K7GwgH_4XHPEkNMbSDIHitJOBv7oP6COEHlMPU_XxSk
630	!kmbTYjjsDRDHGgVqUP:localhost	$tSSNC2CoHpDnfkrByZuI5yIwQnkGfWgi78719EF2fTo
631	!dKcbdDATuwwphjRPQP:localhost	$Nnf21eixntvdCp5m2WCGU6GDBdx2bf8tB9n98SBd0sg
632	!dKcbdDATuwwphjRPQP:localhost	$YVEEIBgXMpQzyS1b5HZDkjDGp2tWWxdK8RCq-FKdc3s
633	!dKcbdDATuwwphjRPQP:localhost	$UjBEvkABkhTXv4-1U8VQjVJWBCB-WjnPcMs583tpGzs
634	!kmbTYjjsDRDHGgVqUP:localhost	$L3vAzBYRC4sgLyH4mINPwSl-cvhgnkxuH53L5xXkbvc
635	!dKcbdDATuwwphjRPQP:localhost	$_A9H6l1YCIyWeaKF0LESz5bjCo3hQn_35AnW1igUhQI
636	!dKcbdDATuwwphjRPQP:localhost	$JE4KV092EgjgUfHyH-sos-Tj9wpjWvPovhuSN-c1LeQ
637	!dKcbdDATuwwphjRPQP:localhost	$osMJL-EavW3iNUIJtx4UnItFlmK_e4UbroKPDO10Mx8
638	!dKcbdDATuwwphjRPQP:localhost	$rxselF4IM1B8uuE3CLIdp_w2DJj1fBEJXF7EHJBMYKA
639	!kmbTYjjsDRDHGgVqUP:localhost	$dkbHbD2l3QKhMVnjVmg4pDiBWcFwHSxSvnUFvVIF8jY
640	!kmbTYjjsDRDHGgVqUP:localhost	$noBXIcFkpuaMLGdsOl4q4azSfGRtWzShBezHDtsJWUw
641	!dKcbdDATuwwphjRPQP:localhost	$-TnoKgk-nb2MfxpeYor8K5d3vFd-Rn441I39oZ8Y0WU
642	!dKcbdDATuwwphjRPQP:localhost	$i9AMGiTP8tBlZClOE9HpqC7ek8XTkldiog2Y4WfLfsg
644	!kmbTYjjsDRDHGgVqUP:localhost	$alhywz8ivKCWyLckse6ukqUcToKsk0m8gKnebqxsBbM
643	!dKcbdDATuwwphjRPQP:localhost	$xg8FDCH8lQVv7hUJtCN6U-beuRoy9Ue6xKF_t_tEuxY
645	!kmbTYjjsDRDHGgVqUP:localhost	$B5vma0V3tgeoxh2j5z0VhUBJN_WIYLACj-RLW-7KzZ4
646	!kmbTYjjsDRDHGgVqUP:localhost	$1mQ0kqEFK9HCpuNxKsrTBu3Um6mrH4V8nN9muqsP5lE
647	!kmbTYjjsDRDHGgVqUP:localhost	$Vwhq3Aug-KkxelmGhEpxo-Wl1iFz03MZluLAg6tTwBw
648	!dKcbdDATuwwphjRPQP:localhost	$p36rUyNB1atSVncL9VKK0wrdt4oU5RcMD3ErQGBaC1c
649	!kmbTYjjsDRDHGgVqUP:localhost	$MGwdoENIKM_afcyvUMD6G1hTqX8eLB5O7w4WgbyIbU8
650	!dKcbdDATuwwphjRPQP:localhost	$SNMmmoustem1mOi2UF8r9pnXBtCqmoS5OguiuNpM5bI
651	!kmbTYjjsDRDHGgVqUP:localhost	$jDakROP1q-A11MRdrYsKMhHnPRyTeSD2IWbE0vmbkRY
652	!dKcbdDATuwwphjRPQP:localhost	$-YtFFtix25AEzaujOz2rBDJk_t42v1taSIeW9YVq9fE
653	!dKcbdDATuwwphjRPQP:localhost	$vGwTmQbTxOoaOgKMCME4NZcj8mGHzsatoWwYlqbtaO4
654	!kmbTYjjsDRDHGgVqUP:localhost	$KTN4m61vTn3rIHWHXk5JoTYtykM2f_hGSYc8tEMTNyY
655	!dKcbdDATuwwphjRPQP:localhost	$tKysdeYuG-DASU2RdR2UooF567KB4gaTUJIhTG4Bwt0
656	!kmbTYjjsDRDHGgVqUP:localhost	$WVrTRGemi2iuepbSQzRhNd5u3qYtFajzcd38Cav7Sj0
657	!dKcbdDATuwwphjRPQP:localhost	$-sOxyckTXT8fLsEBCklN2eursW15v33chOEyOHo9W8E
658	!kmbTYjjsDRDHGgVqUP:localhost	$AdTvhCedlX8HkQDS9DMkeMF9qAJScvp4khcWCZvzx2w
659	!kmbTYjjsDRDHGgVqUP:localhost	$s5Lt57UgfdEuuClHytzZbZihF-K7D_sVQmC4GcIgvag
660	!dKcbdDATuwwphjRPQP:localhost	$oJx-93oiVgBsF9lKPPzaUVRJesRGLi-FCd13adCyz2k
661	!kmbTYjjsDRDHGgVqUP:localhost	$UgHZKVjGiZ7ImztrKOcOttQmPzjlreluKj741-x4zxg
662	!dKcbdDATuwwphjRPQP:localhost	$Kfw2jMPB-FOPgdgw5beX7hE2L6LpqJ-8c70ma1RW1zI
663	!kmbTYjjsDRDHGgVqUP:localhost	$Okv3MleSVG-TfL8JDtRFsfr3KUR9pL9bG6s3x-huGSw
664	!dKcbdDATuwwphjRPQP:localhost	$Hn8zmwLfazLV77zyZOXOJ3VSIk-ThSTRGtjPbJRKlNM
665	!kmbTYjjsDRDHGgVqUP:localhost	$N_eEyLVVB4UuZASAGn2cUNEPtPro523MDxJshaTIRoM
667	!dKcbdDATuwwphjRPQP:localhost	$yKSj75ZII4oulXFHVrNEByncncH515RkDfY245vBcUU
668	!dKcbdDATuwwphjRPQP:localhost	$j-f7KMEjAlWdaXgXKiATxSNLXUas_vcs7-vWC6V73IA
669	!dKcbdDATuwwphjRPQP:localhost	$clK7OsQzqTDwc0VORyJ6CJBoCi6GaawXVBnxF7-0R_I
671	!dKcbdDATuwwphjRPQP:localhost	$mhL8p8edyOhrPp-Pi3YcnDKx-fAclZdHWrsBXmXkDA8
666	!kmbTYjjsDRDHGgVqUP:localhost	$y1nxVnb7SmJBJ7mlCshyA_zWD-VL98isbPpmkpNvs8c
670	!kmbTYjjsDRDHGgVqUP:localhost	$jX1akduQovi8zxSCkQROKMjot_yz3AXpfnSSbf70918
673	!kmbTYjjsDRDHGgVqUP:localhost	$g0XgRk751A8ItszuwvUurQScNqlMT0rNjxoHpuIUDrg
672	!kmbTYjjsDRDHGgVqUP:localhost	$aEQsbQvfQB4hXHMP2h9skj2CUnKQqY10TmYBzbD2BJs
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
49	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@user1:localhost	$kHkn3X5sgQZbnc7m1GNs3FoN729sUsLsqASYxvh3Jb8
50	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@user1:localhost	$cl-cBWQqCEUtQdjEqlQcE0PD7MCeX1R25oC5CKqb7oE
51	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@user1:localhost	$E7asGSdoMxdTkkqkSW3E0QPPoMvwzykIQvRw-bu2MlE
52	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$C6gG6HIW6wwHiDAGDerxQ21ZtJ_fhVw30Ix9yjYFkLg
53	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$Vd4lLlRvqh_TADReKDXjCcwdCyrI8f6PsJFU6zAvpQo
54	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Iv1tfNd19DYZLXKlL8QGU65IkNXeog_gFzeU4c-U8RE
55	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$iID6c4MBkqS7-1WsnDOBQgOYEdr1CVPN9RtxIvUuZg0
56	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$EJWKI8eTZpfGTKRknMihyVkHArdXuvLseElldAjwWHQ
57	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$NEDl1FOUS-Ud7GgNcynoPiZMJq9A8YlEyGYxgvc_3f0
58	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$ZT_5tMYNZ1KcFnWwJ2-QwQgqee4sEaL4NMvAr9Y7Q28
69	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$90abgs-hzNifEYaOK-vbTnUUXcU513VrYsJBYNfG4Kw
59	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$p4N1aqpvCiZwCtwrwlk0iA--rTP3GRfBXey1T9rrG8s
67	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$wnL_MRKUuGQ37iq3tlr8xkZ73-622MAnfPaRoQw5Opo
68	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$Sa-w9Co29Yd94wHfPbpfCOuSSlMlorQ7ssiGXYp8oh8
60	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$mN2b23T_CWKCh21s4DSMtK-0Ivse-M4o9tXNl3OcgOY
72	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$uWaTSGIpSJnnCV9HG5a5zGb0LSH2uXK-QLCAgjgit7c
61	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$HgACI5p4LSrFIhIgjLan4Z4eDGKWa3oT4cOknqleKOQ
62	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$S7qfuHyVNKlnX8WQb78EyVSR_7_dnmagLA8asozsQtE
63	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$yHUzJmGkEAYoMEmrjCGIimVkrSR-XxoUdwq8U-4YxmQ
64	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$0vL62P-h7UrmHhU4ioF6wSA73ffo6vVKlFK1G7Ebvak
65	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$TOzcyxIV2S5U6CP15QCldRMJRaDz1Yaik15PorvZYGc
70	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$Zqk5MoXrcrjH3GJoIQf220q69Vayh-9QHXfRjpic78o
71	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$n6TBNMF739-W93vnPpWYiJ_zTj-UGsx8mCtkFUsmkrY
66	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$ir2lo1K2-OlnQHUaJd6Y3umSj10sEcvqIaj4-YxtREQ
73	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$Tlp9YjzhiKmAmZzyivu0mpIuMlMkzWxFfWlwtj5zHZc
74	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@user1:localhost	$Fz8vTARO9NHToB2Epr5qUR0gKErUBZcP_iMmnDw9zes
75	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$U7q1U4E6PvddrLFkZ-IgZWLNH5JwQMKwxApvSe1Pc-4
76	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$9L0MDAaqrMj6166uwEyUZlzfeWkDRsIVObuS7o00I-0
77	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$5aKFhU5uekQTTY47t7WUErsQ6D6i-1sJlaeP9o484XI
78	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$lf5sHxB86UdKZYXr0JC3-12W4nP0DZWeyrbHYYWeiAY
79	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$HSX-I2M8_wUkWisApshI9qmmVVWS-oGULipYzBstpqc
80	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$QnfBFeO5dEdm0Fo0xlQ0jZ7Qhl2frK5huiKe-XZeWtI
81	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$7ZbDGxgteTl1uyata87G4m7oMlRXH-7FWGx3fz6Uk3I
82	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$xRV_3scri01P3CN8Yk8Uj5kRN98J7r_BzpaYWDcxygU
83	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$8dkt8GEzW_rbNRPh07-6uk5r1rixovZPmI_U1JvEZsE
84	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$BLtE2v6TONv723FUOIxXyICUAIEc0MAj4D061ASN98E
85	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$zlieYOI1M-BWRYe_7HQtpDzEEdUAGP3P1rppBTpa-gg
86	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$IF-IpV86vc06PJjKQLZLv5zSLo6RhFbFhq4ESflREbs
87	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$MCqISVNNz64_mm1eNx4MdunpBcEs3D4_cccTO7UxeEo
88	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$oHONV5zpF0PbMs3W_mfinmmaehaU1mhfF4MgBE1Qe0E
89	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$IdBAhjACyTKk0ZNY7q37ukLsaZlamh896aqB4JRp0Ak
90	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$vY1BQo452NDbeb-fQcWAeHNptFSfCH-tz0hyyX_0KHw
91	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$N5vnwiqD6vTa8P068T3nm2gC85VBZ9jbhBkidGWH4y4
92	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$MIg8MwA__tVnwKOTSbNMhDbFQdNzOspIdjHunWOWTXo
93	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$bFZxglDcEGrzE4UltyM5qble8OPFUYf1HCcyhHkxCZw
94	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$fOw1OK_Z-99J69QwZQnS2w0kErksSQlRVWy_uYMALyQ
95	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$osIKXvE9C_LN7JS2liSacSDe4OMu8i4EfoBZtDc49GA
97	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$pbPnr7boAFsdY2Cl9d9RqHuhCQ4DEuffsodtnqicRQU
96	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$MdGvFLu7OgkJmk5QFhh09ch24n_Nm5s0OprzzOQp-BQ
98	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$z56tpDb6SQ20hAAJSnUW4iq5KshMfcyF11ri0jXivjw
99	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$Jm5Kq88xqnnlOB5NxlxBKNxnPO1zmqUqN2xBcck3Y8M
100	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$GcnmLPU4neOMVVS6jP0mTEuOgHF07GPpzCwVYxkJ2Cg
101	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$yp90ZJhZRNi_jnL2rT91wTtQeGY5JgJibxlbtBftEDM
102	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$iGNJEeKe_FaprC9MHkNXpECrv9YZUTEsJ1zTRt8IHRs
104	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$YVzCfjieRla3dc_IRz0__apizPaipgYbNoG38P4Pjzo
103	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$Ni9PxK9c_fhaz_L40G_oeOsJ6qBhRpuzQ4hVlVvdf3Y
106	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$QKPr0huguKOBW_mgzWz1UbH1JJisQGkItdfgGi0-WPs
105	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$FbMtJdUuQsncWmh4E6k7GM4g19tqMjdPVk5fayFYGKw
107	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$RuNzKCE_vONsTGHU1yfkXlNv9MxUspzI2R_uj5Vosfc
108	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$dWASiSCo-ndJXTiZjRYHD4NCvag08EgsJGoJL_uj84s
109	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$VUkoEV4SLWYarXN7z8vOsYL0FJlhsOiPdkbatF03VmQ
110	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$ablNMTYzsJyVS-P2d8NBQVanmRI0fAx4PlO42kl_Y9k
115	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$T9jmxdCLXr5NqlISMd-TEEdMTjqgOCUuOXfEY6iJSIc
123	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$_d5NSRVMkmFfGOgLgeuYegLCDiGpzKtSYT3BB_xfJJw
128	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$NktchtAWV-fVvZR0Qol52_iH9TiU06dYgz9AtlIUzuk
134	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$wIw9WkkF9SmKQyihdccvwowSN1P59odk5uQ37tTrCj0
137	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$FT0QBjiZiQF6TEwkrh-gfrg40Q32IMNH5WJE-NGoUJw
111	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$my423N54HYnmSaUQ0yrm5d-qaRo97cijrr95bP5GDNY
113	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$UUTukGCaJitmBKamocHGYrs5OpZNsaSFs2npDQgVpck
117	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$7l7P6YEqPaWtnCWBCrqUfSgR8qKS4PIBD72DWuBhwqo
122	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$PSHlaeauYf8z31NaJjlutB2f6VfoC1jA0zlGvA8ADrM
141	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Z-zN6YVNtwc5-sC2_gqVOqGdBWP9MtkZ5AqVVIpVS1c
112	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$tfG11TaVnHZeEAKdavDDjgKea75EY4xxUJ8VOj-Dlxc
127	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$uITK9jNO0mygUpcKMTsvC9-64KigGqBEOAYW7U23jOI
132	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$uXCaMc1vXRfWE1L54EhpIIDFOoox_jjfwMRKGYHBNMM
114	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$GsqAhtVBYcUQXT147PM9v3W9PJ9lSTNq9IajBmUTf00
116	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$Ev7bxxH2Ah_UTgxUfzAp-Nrm3aAuW7mKcmEBKBuon4w
119	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$ljs81WukGSQKuG8_XIoeEizepuyRmVR9bm7AYGAjjMY
121	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$LA6NcF4ZNwknAoEep2vmqOtrrAVdfx7wWgs2QzGiRI4
126	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$hbOhAMLBEy0NwTmN90Ta3dmHVyd7AIpyDNaoSbGBO9k
129	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$FCKZ5jvLh3GvFl0ItOxRa2HNNpBn_loc9KtCXC-3izs
135	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$W8WF6wgFgm3CXjarC2waQNs76jelVoxiHhqqRxlqg54
138	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$okJHwsYIM2qtpJq9X38uFiK0HTVYNC_YVaGGHQSdHi4
139	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$YxrW68PmII4FR3tSV2DlMw5rLJ9tkgN-IAorJK76ZF0
118	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$N9WmxGhTdaRvg9iOEMS0IxuXWqRhRSKVXGJd3ga5EIk
136	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$wRW9LN3T6DjMgSIMDmAMpH2W63NqYfLL9varOo6mTzg
120	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$8d8N-i8RkNQv6QDWFrWzU-jtTVloel7ZWVUeiFyuARA
133	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$aHgGhiv3xClOMq6s_WTnvfD9N9bKsW5Kl_3zHi1DCo8
142	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$zac6ikLLjmhtpGwmeOXeNvFBe13vavuAbgeJ3V--L74
124	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$scEWDHms8IkwamZNSy3y5dUXxzdOHy6BqBoOYiLjCFI
130	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$FNl7nQTr424oiWFqebjaFcIQpg301Lrvyf9kxeHnTVY
131	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$WTXlWbsTiRT8aidgWXwk8ChcmBIksdKlHYW6UpjhoME
125	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$MF98WMCod9mD4-EkjkJzrhITSPUIqifqEfCsAxnZuek
140	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$78FN3rSTksVHlqj3pVwOu4OqyQWb_kojoDv8Z4siAho
144	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$20RPj61r433ltZKlA_zjshrGKHbOwOYzoeqMq9lIibs
143	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$_eGV2WLucuJ5WUj2zxi9h8RoVVLj3epObbai8d9uiBM
145	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$ZIKeFFw9iKIo0lQS_EahlQ-2H_MUawJt03OfV4bhkw0
146	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$96z94FnX3Z4wFXhtU5h_MG7dplI3k2OSYPNnaNsWHpA
147	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$CZ9ISJIRtjuUHkQ_afzV7hHpFP__5Y7uCQYpINWev0Q
148	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$FV9fGwTrrsSULTG29HysxmyU0JwQbWkcCp194yuwRr4
149	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$mwtCirIztAGJ9ji4rg7nw5VlLm_6_sP0z0pr-8fsEjE
151	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$ryVAC4sZ_GuLdWSWf3H49MerHNRZIqb_XZl-cZ4vZX0
150	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$lXaQr4I0TzmD3ElzwPhFSXVI_9njGCaxorSrUNkWosM
152	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$LaKcPOlOyqg3zH15fQrR-9_nEJmKBpzs9PEhhnoa_YM
153	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$2IWy9LjE7Krzobf0BDlPHmDQTfC_mlaHfLDRx0D_KSg
154	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$ReZHJ8bn0D949tS1Z4rK1A_OldCeJXSu_z6bvWyxkP8
155	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$LytXCAxhhMuXWLqz76rEaUZqJ4vArp4iF4lyJWQAom0
156	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$RVL87O_052WjvihngqMP2wml6CrYR3ETZPS9AQcdkXE
157	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$M_TeQ8v6agN7KHCFhaTS2WCcGV35sHVe3G7L3BYV66k
158	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$66z3By-n_vl5wYEwyxkr5XCESaYZdITtfPX-Ql6jJps
159	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$qThQV09ZG3001xOhw6wQZwnkYNJCXKMmRAME6mMk6vU
160	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$zlrFAQyOfBp0Yk2NhrKS9ZrJTI3TPBpQQ1RU5pA-zsI
161	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$SMfchwwijJRjg-dyUd7PvxmVCmjDKX1pZiNstEClh3w
162	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$JFsvZVb4sDfcRmaejalrbwRwwUmXSl8YfFeKzUFCFII
163	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$427tt1KJakZ6eyMfnK5SNnOcWTdp-onm1a8NpQAgnOc
164	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$iuxaR3O8IzLXwUEO49jvkuByC2GVQPkx_ZptsZSqf1s
165	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$scc5v4OjJXqJETWOTIZHBMv4yvL_rW9zlja0qLLVq0A
166	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$cUrQpzCoYIYF5cYCjqTlmeJv2MQaDU5x8l67Jfki9CA
167	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$C8NxDwv8onlxLp7GWZUlJ6Of-DEgpHv2EyxUD5kVawg
168	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$E_NG2FYpoMH4OopElszmCy1RDPEVr5GgaleQve4G3fA
169	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$FxkLj1rdCBoI5n-PQymoCDUdJjFmOd0s27Js3rLYfOs
170	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$PRjHcAAICLgYK3XY-NErxUtt_wsvu54SRhyAFKnpfdU
171	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$4E7kN-BJwtwZxiaOzq5nlSDrtHW091zrvo4helm83zo
172	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$KFMvW_vZu9RNx9EUhVogCsf-5w1sY7nBnK25pVedoIg
173	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$-JEr4JIoAMygP_QRAs9Jv-iADvzIwLyAqC-OGwhOaz8
174	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$tO732UWGu6BRuC6D7nxHRr0mzlZATItK1nJdw2vssUo
175	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$b5cK72m_LYLOCXdks0dJR8YR2NUOhzyb_EIzMrJeiHo
176	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$qGfpbIvHpOVZtwnIzJoordk128W1bbJL4tO9Oppt7AU
177	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$x-W0LGzIk7Uzv1r2jFg7gx7otG3Lc4D3vGOaJwejju0
178	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$RnpX5g3JH6jpSfLcpuV2U-ZNYTNVSdWTf4DUNIFMsr4
179	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$2eIpQ45JTS7VTgATlO0mXqlYXz46Z9kFu3aZ0gb8FnU
180	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$6uW4FPZ4rmMpE0LAdrXTalyG9qS2RWcHznbqu-Pj0_k
181	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$-j2CBh6M1qqedPILqSQjOeKo7DzyfV9qX0M9EAcPvI4
182	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$UV4_Zf2YL4gxDOc9KFs1RNYroZrMWypdfHN6Lx7kaBI
183	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$Ns-nffQ5v20nWGD0NFVrX_auu_O-gAXSrSQhly2sJ1I
184	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$Z0wivM3fsEKLc1Be1JiChy8kiP8ApDxdcmy51mWkBhk
185	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$GHieoljZ6vmSl9Q2vkSy9gEPu4FooqplxgfDXerZ8gg
186	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$oFw27uy3wCnJmaki_Pmqd7iUeyDC8CtIbezsnqmJqHU
187	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$xsjLpj6f62AxGbNb4GJ1grmPYCyJ2UcBk2M4PnkLUz8
188	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$Dk-ayxJmbBGZWmA1mmxYXXtTubHcVIGOSif9BZRak5o
189	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$LO4JbONTLdRYnRsiEmAa9EZKF9gOIgppfVeVDVk2NmM
190	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$5clF0wwGPRj-kjxaUNsst8TSkhGcgeW6Uco_LETCZT8
191	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$pT5f3hjpM-O7jjmY6ltvCPil7vE4SCwIc_f8fz6NGI0
192	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$NcXRdb2ft15gUA18r5qv1hBOJPXBlP_GWTdFAOdUKlc
193	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$eQvEqc1_af1ldzsdEEl95WumLWS5ipRrAPVsJGi0VAM
194	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$0gp0EPFRanC0jriwAbr39rEywXl1TtmsGetjvcFePkw
195	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$GumzrsEvUfP2mK3VlimFmnxefQIAoARNhuB3VijIUP0
196	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$ADVpZVcve3WZmJJlbMuWC08LTrnTWE8iE3U7Kjkccew
197	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$1ivkQolJh28E65KCTdZFg-9JL6DdG89yjFeMjqW0RmU
198	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$dMtYbdewwlgf3pUO8IpSaszb9U-i1iu4cLoPnOdarMg
199	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$S9U9EJOnxM2dNgNljOG_Mqix4hFq8eEzoc-kg609W7M
200	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$bija9Vo1aDPA0Nh_IcvnsdGQHNAzaikmRrAUn4gMPEE
201	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$ShE0paQlbQmO6DO1uDpThgm9CuYVVxwdAQbG309R_gg
202	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$IwXCdgCEAM-h0xs_-9VBU5B6QnIMP209_5ehWVHPCns
203	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$VPHsYU9BWa2fXGQiRiuxjTneBiINKDgzarFBDQLtjFc
204	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$7ij0oeLT0Bwov3CDZx-Aw08A7otYoVl3r3h3W1tDKcU
205	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$3DsKEEmlaTB7ZtCmo6sdlibowkxyEblvlYHADVEG3iA
206	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$GsNXwosBvPN7ZQotuPf2lmZcmTy71Q5wdwz8MxtTlwM
207	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$-pW5O2pJh_2AJYUSBaFetGJ3BRZRuqco28kqbedUeQ8
208	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$jTcKXqJEQ95H5Bg8HhnouwNlmZxvm-zO8GOK9XDNShQ
209	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$mSH68CBsDtqDSaETqhiL5ndSRIHJnZEZHfNTr-VYIm8
210	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$hLkYdEmPTHZMcJnov4ZsG7XD23zNjKaX4pNtXvPjs_I
211	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$_HszCcHP8YOiOxllHF1Oz32uwN7zvPkiKsS1ogkWrK8
212	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$VdTrMdfOyL1DZ30DkAnFuIUofKEtOk_H2pF0oEzqhP8
214	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$Z4xeJ4R20MboSLnMhswFErA6i38OSlBXGluDVy2ByvY
213	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$kPsLZfjzhb9VbV9Niy3LEDw16IkOq82bA9DzbgueNqw
215	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$XVyZGGZiCPdqdp4Ghuhpllefiu4t6CzklcLpsOgdQo4
216	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$uGHZZ-Yz2PAQX0wNAMlZVsLIVmJtu6Xa7hmfZP4hoZw
218	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$JpeYShGG49hm1tm2szGTbj_Ad8syeP-_zHCjUtcyDW0
220	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$YSfyQAFQ7QY-iuTQlyB6FDgC5MVoRKGybsLMxYXeOno
223	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$mOwiaepGRyjJsnm_OUDMUEh19wp-kvtE6rZjqS6T6Qw
226	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$UqS62uUwwgjNC7m43u-OzFd0NlWP14pRSdMShryA-OA
234	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$_3gf5vvCg3EOAp1Q8jix5_u1X3dcz3I2YOOJnLgfyLU
235	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$ldSJmecZ-XFUSA276NblPkKsrp6F9-7SOq_bVvbJIMg
242	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$cHNGphBcS0JdljZ_qXDUB5FCKHdU_qHX2SupMXfYfgk
243	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$kd1c1xMGDVYzW7UKm7ukUxezvnK55kCygo0SREvSabM
217	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$XgLkd1mPehDswcwvC80mYipQGC4eyHA8YlDO94-mLh4
219	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$ONH23hQdD0T0G75aP1jV0aJp-CI7wA3uf7fuGchk9xc
233	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$TU-6DJUZ_Y2P2o8co2ANw-YQglpJjMpWk4y7ynR3nzY
238	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$e3V4xZnTVInSYV6go67sGixdf982XRRz1vqy6xjUADk
240	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$BRfPTSz22V7srsm1mQdnab9JJZteh-qzyDVxi6nMSuY
241	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$56hhxnuUCDhY_FIqU1jVYXERaYIi7eD3azhwSxITnXA
245	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$qECtj995yYxki0bQLCPrY98Lxx8F--3rMD_3hFwFm4M
221	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$2tokfrQ58H1jbQd1SE9eeoBkmUoFdA4J1FR-5QPBQyA
228	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$3noaqaRS9KxMxckU5_sisNvcAq7QBWBBbJEucgPco9c
229	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$pCRA27_JEbxVjc1CYbe_YIbe5I3brBzCimLklRQvxjk
222	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$lcxQuSgYav6SAXCtor7PcgAx55stIfs7pUiw9W8V_jQ
227	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$Zx1UYbm6_nDTdC8yyZ7IF1HGWHztD-HOoadwzqOrrx8
230	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$JfymGgTNpWgrPBhAf9mTJSyWQr7ko1F_30gUKa_M5NY
231	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$sCN5SiXxHx-vme9FWf73E0xk5fP8KKT4MIrurI6zVSE
237	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$0imkZ45yWW0fSc-G2ak6ejGMMJRRQgHFPyObQ0SeNqc
224	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$44K-SnNKTzndgI3lWCh5FxdbRg3ZzENFG_HAqzsyPw4
225	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$vSsR4w5RLvaEucW3yEjRe7nZuVGvV46a76b2xLpbAMc
232	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$lVzKffAN5aYQWs5TCqBXIpZSl29pGAyCmOQ5or2psZ8
239	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Gsm-HyY8ghp5jnPQY5xCvYeGJdACkJYnCBxMGOu3YbE
236	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$wVjsVUuRifcmJWBUzjKVfU64rJWHpFwzMmhVyoNJ2CM
244	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$jmNoNPJJVWbliGcIo6zEPgue5WhGiAQ-02F5sUdxb5k
246	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$q835RTIYlrfptTOdElzE6yLeryXnpAe6sBZ-wrXeYWo
247	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$IC7XPWkgfvsD0GASMe4Ih9mgp2k9ABMX5xCMWNpNSwM
248	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$Gqw9r3I_eVZ-BLxDRsgXjb1k8iDHvXLnGFamhXZ5vec
249	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$_K14CA6WUVr9lSRSFGep1Jctv_dRZ3ypws6I7EwN7lU
250	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$jiDz1SrKn5EnKT-hsrgwgj-WnPjCQsf52m3b4omIbJM
251	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$Pt2Hhv8GKcJIPNaDVmOA7D3QXhuXvXNSMD8Ixft1b9c
252	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$x_Z64R06dNc7xMERtwpkjVA4V5asHLizmW0bAoy0u4o
253	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$ll2PHFhXRI7X-WEZjp1VeCxYc-VzGJTRIl6DF5sY72U
254	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$FjsBFw-_MLzyEW8Z_Y4b74RUbAm3CkK-lUEdyUMH64s
255	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$Eb3vVCh6EIDN7FhBJt2nRxzX2hogZvkfzshFfIV1vxM
256	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$R7lEwM2wAbK8XfzbqmMIPd8Pl1mDTjk0Z7EsYxc8D3I
257	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$QV-PSstXAg3CBWgJsWWv-wWweTQJtnd-Xb3_UHlvLao
258	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$oEbJ0qLItkJKWV8ASqMucQE_aTbOBYal1em_l_NW4B8
259	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$wvc6XB-l-RYjQVlw0hdTWpog0iQzQ8emO6yY9r2cwcU
260	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$swlNLbqgOtlyDxyp_tPGr8sFSkJ38wJHUz8lsNO5tpA
262	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$gapNykj-iaq3z-2uBfizldcLhIDcDQNBE-j5IM4q2uc
261	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$r6IuwtQgVeU0yTzPOwNEvpwP_68ZIfHO4ukobTN7HOw
263	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$YCxt6fHYsElmWrljpWDg6zUrwOa_UgLUrNd_yv6YOL8
264	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$voYXgDbJERPG0WYiYEcOPPfxb1x8D1OxXrb4YPQMk0A
265	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$SIwrQNayrwtBHR48kSzVN7oZWwteQWy5N5B9SCVy8r0
266	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$jiJu8UOWCGf4_gCw0Kik4K7irau0AB5W0Ln9Q9ARmFM
267	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$RwTzM1d7yJmRSjuhSRjOdDVeBsXHw7ivvHME597GlGI
268	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$N8yMX_bOsLyM55kTCXOweV5W6eHWoX9-SXJv_h3Fuuk
269	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$YK9NVxqYWFjsLH3Hq7qeNPnLGrTnzdz9Vm5Xoj4oFKE
270	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$QsrebPbSgJ3hGVwXiHq9MXGadC-MP7ehmEgLHVROdbs
271	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$LTHL3LlRVNrPhRkjuAJZAnrn9TxE0VJNzhHzlpeIOtw
272	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$GC0xEuJnwGQKhy4PP5Fps-2vyhFQXURFjFhMMu6e39k
273	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$pJWTdmwi6rTMbfJUFNxleRX2FCaQUX9kpdCF_Fl5u38
274	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$ze2Niy56_7XHRfJ1TxaWNymtm8LUbwKCKDhR4lCYFEw
275	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$iju1QLlEd15kAw8CdDeKpxUiIglD1tu16Vy9CE99Gi8
276	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$7sTtH-3_5JdX1s6nEDeHlgconMj5zhTbbAN1Sj3sSEk
277	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$bxMErosR1jWaU8smH1x83fp155ZsJDrKoxpYQe07fvU
278	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$F_NxNLkUUW3M3ycmhoAPTB2OgEfk2CX2vl9sc_rmOew
279	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$98YOnFq49tpq91ULd-dkuciQDt8SLsMTfJfbJYhrtKk
280	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$4eCsy6BlXga0ZBCEsowCxrzMRi6AFBfhbui5wnv8okg
281	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$kHSLXtHLXKbKnpohOTpK0MHdci7kHH37wbF1rFn88pU
282	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$dex_s62jDbGAFfmj3DACx4C-IEliBMY6WHnkhMcSIeo
283	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$AbLb0eh3AyP6eESYFAf6ZChqvbbMUZOAoQWaI5VGmJI
284	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$lPRKxUmhH2h-cb2fg6wnR94-MiHdlxHl8jdIWt-drf4
285	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$fWjPnCuvaPnr6IEiGE24nCdJL45rmg456jXOpCpAPEo
286	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$HvKCrzX0i2S9FmqDCixwUALIuMg5Q815hUVvarAAndI
287	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$97qoxlByy_DPtJys_Rody0B0epO26i7OfFaCNgJmUwE
288	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$gLosusM0q5FKktKrS8-Xdn6CtZjPbmez5jSYq7ByFx4
289	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$LgU_WFkS-bvyeU3PZisr5tBWnXuIeL4qfBrosrC-Zo4
290	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$tEDHFQjo2VF_Z72T1hUGgkCeh2BDQ1pSZHgU8JjnPyI
291	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$TfBTzlSXNy1kehoegAQnqGu_UG_JVz24j3SKCuzVmsU
292	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$T9UC-Azf67D2cfSWXmMx07Ifywx5ZZSvyGmIENquHeI
294	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$nocPi7lNeOzk_Va45XoM-TXMt0usDsU_6S97MZNW3ps
293	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$QZvlGrodMSAksphGZ9uCvNnCTlCzVFOSFiB37Lh4JXk
295	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$67MfU0dO-ARDQ3LHnCGyERHA0Tl_MpCRhYSTFAHuxy4
296	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$7VUu_lYxl55iG0Fk-bUv23mySXyAo3IjdtQPaqFIaZc
297	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$tBlQ0_SRowkxKPxnd6wyqVZNpdfFJa1AaZj11sFeo_4
300	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$ITumaOTQ-TPqv82ND85rTVtxB_slHPn-1Ds1ixT1YMM
301	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$bLui5hvS5Rm828T-Vd_hUaBzYehFuvs5jthZuk4EMng
303	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$IxOnycDTOtkWn8g5giMyu88ghJnpIbPzSy7oKowCqcI
310	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$rSJaoKOTJsEKYpxqniMuLIgSddnszvT-NoqHNtX9nYQ
312	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$BJjfbIWO7SRyJUYt2W16plyo7Vge28yvihe00hXY5eM
320	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$rk3nAC_mbUEeriUcG9oFR47PX7yw-nDFZQn-XDySqsE
325	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$hG6UnvTjxBEH5OvoW4eqsAeonJoCmYOrnBspvon_iu8
328	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$9UbUv1ziiJ6NDByi2DupLmoskuTkslmBtsmnYpnA7ig
332	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$0SSS7ZSZbHI5LQ7h4rsS20xlRRpZdlMblEfu6gd6hoY
353	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$zUomLm3mThwuYeUXH2UXzsuqxE6DQeH_95sT95psJag
298	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$4pGVcnDkOFkfkIsibCpOzF_pLN1zyVa64oo9E0A_F3s
299	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$hctyN7H3VwusGaSx9G3VxjdP6XAD-npClpuHnIby9P8
302	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$Atuqu2ygQ9ALYkY_4JVN0L5R63_yL_9IDneKccaPexg
307	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$bwA7mRj_RxsTAGpGf-t61H3LDTorQJ2B4vdWPMu81Qg
319	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$sU2o99fcmX-dJIwmqMx6vylWt2uH_cI5fe6tnpc-1C4
324	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$oKDO2xzyevl4Bbgsq8OU5pRoSFeamgVL-8yqZzmD6PU
327	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$ob0hvf_1UhFTYQ5Ka0kVQYTlhwQMZJfK_-IqusjDFSI
330	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$8ev9UN9u42sjBV7z0-UUuYgwjOcyvBAJ2NmRLV6HLsk
331	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$tTct6UC4chzZoCQxVDeG20QT_VFl8no7v3zUhWiWplI
342	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$sVsScgvVnYwe5O67jvt70HoldKxd0tvQMeduu2xNxOs
304	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$g9rczUTLPj0dUBqXVVBw2h_sKntEbsE_v0y4wqekqQM
306	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$LesIhSE86XzyQPkB7b4TyY6KnXX-pYPgXEh6pdOBL1s
326	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$uQRFhx8oPJdKNVWHXBm3R_uZqEa8Kr-jGirS4AtULgM
335	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$9hug2iul8IyTcPKSEtlsL-r3z0QTjNAZoJ3L9P5pvrc
346	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$GcATD9gWzOntrM_-dgkqcPZEfysPV-0mcsSdvFZjfuc
355	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_b:localhost	$sKC-AGmNhmjm9fAYYksybJgXr_tCsBeZrEAv6k7VTyk
305	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$7fNqDcYwdBofKa3Tdb_ozuy-7JvHY6aEjHPx3dtK0Jo
308	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$EYct8pcN3TR2iw4L28JcvwHRrH79akTS7Uv_YHdydyA
311	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$P6Dtn75RwyFpmO6OacwziN1f5O0x7HdXC0d7QB7S-qw
313	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$fCJ8ZVUwK005ZC5W15tchQk6yITJm0QNnLDQbHh0vRw
316	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$6WD4GwrjiOweRzus0U7k_br9MA6ItqEjRwUQewtaSlk
318	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$ZOA5CmJBW5jFwb0P11yiLkfPkIxUFa_WirC-e4EgHgY
321	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$lQaF0IuuiE3nyH9hfvYC5haDYc7DNTJgS8TRoRk72sc
322	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$KfPuruJi9WSX9utHuejsg4KQUfSb8KC10qeYZ3A-MvQ
329	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$Lp6oWL5XMW9C7d3BgJa5Wym_oGCobgxcRs3lvumP0wo
334	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$3CJ8qoc6n0fCyIuR55SvFzN27bZDLSJkBoZVvbU53dA
337	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$gT4wR_3nxsvf68d4n3i54-GPFvmk0UIZ9ysgv30Sbi4
339	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$y5Pkc0ehBYCShZFYZ_vPlVgpiw_99AhNZsps2u_fjm0
343	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$UP1_PqQCdJgYfG3ar1g9j25Btb4K2IFwybbWkllGXpQ
348	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$_6pNGWmE3CVhhekVZUQ_FgJVOC7aNE2TKs1LiWuPCRA
351	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Op0TBQz5bRKUyxhUgvd0RMEbDt0BloR6y_aUatQJcO4
352	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$KjxZjGyxoIyEvF0d6WjubIy5-PjQ8gTixRenqiw88iA
309	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$pm7XI9sywlUrAHs8qdFu4OwZ5lGlyq-H4Za-_Qph67Y
323	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$OoLkvEmnMtM9N202Ewa59t_aytFrZ4hJiAe5Y8cIWWs
338	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$blKb6TnbTahKyhtp1uWggk5ghgejFMqWuxB785aAUBk
340	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$pHb1_CgrV8Q3wcwx8MEr6ty97wb4wfs1iSjBBO0QfFA
344	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$omRpIBNwS3dmUSFoxFnXEepeNsfJgZCDl7piUIZ0R_w
349	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$dceJQcyKlSKFVNNcV-XXe-wYnxpRc_5R7w27-Fiadmk
314	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$NpB149LSQCeoQ2CN4pBZ-eAFNrwAkWoX9Tm3oBcr0lA
315	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$58ZOy45BulwCfOXfmNjgcwgTCSHJRVXmFu7g0DBS-S0
317	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$2uakM8131VJaDpHoLXOMSFJ6iH-WSUC9Bc7qZoyAe8M
333	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$yXLZ1V5hlF5dCa9Mfng3zrHlIwsWWWkCuM9Qg07zHS4
336	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$ib3O-PfWFyGliGGTSO7B6JzFkMWWSl3gNM8Z_EPURkg
341	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$ZqRJOUm8TgYD5dpGag__9MQ4fU2o70fHX0sJBeMQxD8
345	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$0wZHcHMKbNb3_HQlP7OaPWZmz_2M_PhY2aS_yvOJf6s
347	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$JyR7yFAn8DoVezoMeFt0GDGdAJdlTAJlO4o7PZnQNjE
350	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$vqpeVXbQRMk1Oz1jfMlyPdiItesHjk6VSax2IEsIeU4
354	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$XMPmaEvrP8Ebnl1P6-T-4JWR8Ms1HgLkboYib2Z0LAI
356	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_b:localhost	$8Lzt8KQPe0wAkuTOKq6BkdBqXu9LrnnsSyeYQ70hPDs
357	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_b:localhost	$9i3p0sl8iw-4rVjwMHJnTFujme1in4rnO1zkP9hPq8w
358	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_b:localhost	$1c97W6vcISTaUEtVZ3XtpTvdbUxTp84W9UUnJ7yQ1hI
360	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$hxQN9v1jskMaFj7Oea0TnONdZ-2IU5r63dktwdVjSb4
359	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$E_ffgnOG3LQqftvNZTrqtqWIYSu7K-Od5IBhdtJik4M
361	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$nBfECAms3jYX98ClcP7jHlxsZFZPShGshoeC8cP51K8
362	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$03Ov0NWr4ocHjT2sofFZb-NVdkmBwDqMWSRMJqWjHQ8
363	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$1bObCi5fAcbbrNE-smwH6AECySiqu02SdF1HcZiNLS4
364	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$smqDLILNOVZazXn4eYC5OSifMqqH-xHqeKPLOyVLrP4
365	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$NnCes_L4ehaZSWsjKLUxag3jLMGd6UoqN1ukXrFSGvI
366	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$OD6-n91qVi0ncfhxaxv2ZX8Ty40lwpxnf2J-vf8hOro
367	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$m6k1D_gFOkdQm0ONrDD0C2Eepl60zWaqYMlVCpXOtmA
368	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$YAh_aGe2I-GyzUPhPR7JlYTsh52xsGXztSMwzelAlgM
369	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$6xID9TCNz-RpcIZdVbfplXxRT-3XbG4uAkc34QhTPpg
370	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$k82kldzQ2_vs4adbqoKhWdl3ZjHAyBOCubSZsMRwacE
371	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$dIPPE3QBGDou378mU9Y4SmE3TsFwOMwlM9NurC7Gows
372	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$DTJ07HHe6J-06vC8yePJe-CcozdQglm6x9ILr5ZKPyk
373	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$BjcXTtpum8XWkGQrL8j6VGIIBrYSnBRW9gUN_nTKnxo
374	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$03KQwLeZTiLNq7k7DooZfwkE-cw4qF-6vaA53d1rKT8
375	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$xjFT_xMUrX-xZ9UGtwR4YkBwC0vOSsAF-4B-e568zW4
376	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$Mg6fyelB36WKXECwON2O2Cr-JEQ9xAVPbkaR_sI8Cvg
377	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$wiQhyG_4bJ1olQg0plsG2mjuraWaOJLwSOOIJyWm4ic
378	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$-dqC3h5F-megGnhTrHam8MEfahqMCdkAwX93uCerMio
379	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$NWVZk4K7N1GfhInWD02-THmB0h8Ect-bOVLbMKa-NG8
380	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$NLAbxhrOwvTXPQgMd522ipqrrlIemkAipLkDBZ2L8FQ
381	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$MWBbgUUHEQu2Kforln-kleSDdCdtibzziEA1aS-fEDo
382	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$syYUwRJl1hIGRWsxbbmDiAvRvFc-2_btHSpMmJVyQH0
383	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Qh4VtM54drJ8g25vGuwkCD5VqhgwhbOnJLcP5qTDdps
384	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$QjUskGVE5PDuWbZzwvOb-zUAqxgaoN84LRLhfUYdEzk
385	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@user1:localhost	$Z3lb84md9FuILJsuZwO-q3dtA88DQ7oqEDoTjd31QUI
386	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@user1:localhost	$B6pluS0ISlXPPp8Qb7N97HoutiTFT0H7H9nCJJMLYTI
387	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@user1:localhost	$gjVF442oFQaSlwHxmy_6J2h-E8W_yMnW8AJFTlwfblU
388	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$QK0lT3rot6JRP7PC2IU--7WNKGywkXNbrSS1ZnEPXd4
389	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$bQgCyxbKjQUL4aOK37wctj80bKRlDEbdpQSQdawVA5M
390	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$_m4hSeuxFF5C5VL5ml4C236AdJ2ha7GFpiHqsA0T46U
391	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$F7TpyPdzymo1ldMUgE5TZRtE1ZQ6f5_QSrbRNUIXdok
392	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$JIjm4MLGNTB7uYCfpyRki4OQvFf3wdLm5_Jyp5wy_eo
393	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$6d5VPDhqRSPxM8XIMrXAlO3QVxGovm1TFB4zAaY9-sA
394	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$SnyKQyEiCCPdZhluvyOBC9d0Dx2Wu_XM1GuTLaCFv_I
396	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$o9OgS_kp4k10KkrqitSVrkn9STx-F42VVRF8EFSrXUo
395	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$gICPE7fVCrb3Uwspg_AeqAzHhqGjX8LV9LG0E1MRE34
397	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$YkYvAReh3CXbkRiKRCH1SmKkc5P7E8Cj-PBRiYc4KHk
399	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$cQ9cNICpyvXgbrMv_NhTWUIBZYtr-uO0B5spC7u-zYk
398	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$h-Atv0_2osOXLjfJ-8t9IlaV_zxC4bhsi_AYlJg1NOM
400	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$k-dpzcN-i5_jJkLZgB3Cx2PeYPZCMaFX4oj_pJLoYlk
407	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$kdbJNSxuAA4Ngmc1kCOZCzPEwDuI5AeFHALqsCS4elU
401	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$5A0dwVhtEX480RoPd66xAxm_COlUP9njI10BuUkASrI
405	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$jAe8FqU9mMmrte3grv2ZA3Xqk354_humjzNVKx2mElk
402	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$z7uq7yRHlV3atA_5pjhOpPH0ZgxDwtZLIePsJt2FOQE
413	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$kSwvEXASnPGHobpchuSH3tjquiVt9jZZpBqtwpOIXB4
403	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$91B3wKbbOy-p6-_J4KaZXG2WklxfLJiraoGEDyx47Q4
410	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$-qK0oir09kKPxFo5YjkDmL5nXsLvKqCxrJqe_Pls2Z8
404	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$W6h6tuDui8tLY89dtOtdYbeULMbmzn7-6z1S_QZpdS0
411	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$9vnrIIvmE9HJhD9bpKbhtRQJNLrTX_R8hYwFihomyAo
406	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$Y7O7reJuDgKHzz5gRvjNwOh4WOQsOKvw0vYIuyWUilc
408	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$fU1bJEWaXrfUrMmcSz_mfgs_DwRFngl8eAdFCXA8wC4
409	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$w-vX84CASAduViO2hLevAm4pATNqtpvW-NDTFis9MQ0
412	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Tdh7YbxcAf-w_3RsfAhM1w5Blnz74lVt8beWxk8aX80
414	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$U0W0nPmHIlLpxhiDB-1ybL3jEuCQlslb5EfFzF3cmJg
415	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$kQCP-XgdtidbaoQ8t_FcIVRpbr2reMeN9BlmH8NgHoQ
416	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$It1nkT37IMvvWoNsumFX_olMFx3d9V-rvYRgWTTcFCw
417	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$-iOLumQlL9weMxGvPUSXOpXr2jNkj55p83LxuxWuZRo
418	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$VXV75_AO7FAHgKX-BY-LGppfuY-gvltLLWHwR7HgZ1U
419	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$VhtISDLe4N7Uywm0XPk-CJgTlsxZswl_hNcHiBjZzf8
420	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$dE9AXEt-ibN6n4TE5G8h8h51bfjW7gwKTAswFb6Y96Q
421	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$d-nlW63-gUx-1l5iVBriA0L6xT2DUSYtrKXmmJJJG1o
422	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$d1x5Bv2lxBhKvhxm9iL0LD0JMC8SVmT1wwO_-l6K63c
423	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$ZATHF7fZwsa5PN3-MJUbq9keezgMw-84_jyDu9WN_TU
424	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$ghk_5O4ASIhXCtmdmfLI9L10I04XSKL6yslBcC1bMsU
425	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$bxuVS5FayXodn0thLWn3dbMXUjYMHyaoAmZMxz5QHEk
426	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$o6LK2jj0-WrfwTSKp7Nkqs4mlcf7kli-TMTOSMVVp18
427	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$qqHLJ4_jVX2dT5v7Zifsk89RTJrqEsZY8cHQkkeTH1M
428	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$PSSDE6G2Opv54bYlA8uKwssoIS8yEJGeXB1Th2W8plM
429	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$k41_5cxJXnYEUcfHM8aEkkK_kLkKGgqF6eia9KhNRrA
431	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$lBTfQYdSf9fk6wyuE9Yf_LjnX6nZKxYsGyJxrsdY6TQ
432	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$82eCeBgVkTQnIiAJjesspqjDQEM1iK2J8ZMVNLIN-qk
438	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$vqy4uMnUlF1Af39dolKO10TPLVgMuUCNri6RRW5zLbs
430	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$J_VxtSqnumSh1QJ8aUO_QwIPbef5FUzbGZyAUijfKXU
434	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$msxftcdpRjOn87KzmJ1l0ekrw_L2MshrqNcY5acBil0
439	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$pvgqnjHNptVGIYdaz0Vu-03WNvGqaHBxP-32wxTvRW4
433	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$xk4YfGryLq04gsnuycfCV6CskGswdkdNg_4ex2w6rDw
435	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$aqYokooe6j_Ge2qKkT0aa-6HcsHoRXXl-VGjrqFi-Ec
436	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$RX7xAmYcXlUMB78kQY-mbE3LNTB4pZck046xGKJIrjw
437	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$2sLfClcLYp86jeOi87fgT9PzSgLedlvHZfy9wM9La6Y
440	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$7YwSP0ojWMKFb6yYTov2f672ztECo_ca-X7b_15z1dQ
441	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$WApPSBSI7vLXxQ7UVV9m2XLuYAKhIfunaE83pMuiKzk
442	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$DAkHhUSrwdSVEVvsvj0T0FnTKF_f9Fk5OPIBcSr3m-A
443	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$HzG8V5dvnDih4OOxhKA7ioWTE5O4dWd7y6CwXI7pEtk
444	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$RUgd5sljaDC7qarKKtogmwkttnA7UYsOV66Ot2yYXp8
445	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$Da7xOchoJrNGZ8RMyHyaLFYsuCbroArXCyb_X39pw_Y
446	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$x_YyL0NEmor5-l1z7XAxomi3ZgOjLXL63LPofI-lHxk
447	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$87xrs4WAcKqZ97aqqW2jcnIOnVitwFvPx7NrmhcVYCQ
448	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$SkqwjL9UqyqxnmeuNbaptHasJCkUtNajzT-FQSJE5hc
449	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$AfIfxfCCP1mpifSu1SFd1-jOcITywde_bA8c2Qp-Qc4
450	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$_-rM0WaJ_j5cVYu65gZTmDNZ3p8qjfAxLdNj1BC0JQw
451	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$_UVAyljO4i2-J-8JlYAtMutiyS7Wf_6_EQHpDm0zWPI
452	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$x2kPX--8V7vg3W5IwXw-lxVcJvu61FPd3PTslD4cQY0
453	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$HU7w_1RyGT5rhAaPl6k6vW91etJMw6xC8qiX-qVzSZc
454	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$YdTAcOePopiKAKM_5bviyVbbU0VimSkKNBR9Qigcbmk
455	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$ST587tP0ZzPWz1-y3o1wLvfJ20ELxm1AL6ZoElmJCq4
456	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$9euqeLKRUG671hw0OAdJRNc4wuApiqg5qfK9HRurIOE
457	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$XEMvcj_0Nu1_qWpmR-zbCDEFwCPVcTWmWYCiLl4o36M
458	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$xjnDBD3CYNYeC00129Gp5FZPoqpeGOsQRtPDnx-rwxo
459	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$r70e6UupQF0P05RBv08fb0kn40fMXSAcwmLtA11KjAE
460	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$iTpsDXH-DOVNiqasHYFnaJVQ8_URs1iPU0XCyLuZqEA
461	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$ctSxuddVjdig6Q4qdrs5T_mIEmQ9D2vRAqX1wuMDxm8
462	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$u3VA-BShTTexLCrAeWITbqk9QnyBo6H79XtIu_uYUt8
463	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$vwdw7H2kOywXTzCWGkqXLbL-tauBsZTYFfFqUP96mcM
464	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$WK2_ikeAhuC3BcBKM66EWyMT2tZ4dx0HP28TDgcpnqU
465	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$pmnljLnLxMHY186VqjwwBrF9FIlCiOefKXa5TyPn-WQ
466	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$NlrLjPqVpscFGK1txNQAZf-7mZRfbN7s0_LSb83-gaM
467	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$SQgZemcc_oHa6ciqZnVbqxx26mIMpQecUKd-Vek3auw
468	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$kdnCA2aN-0o1RZ-3ocQOPTNdc73Si0VL-INICMQrU64
469	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$A5KlE17b_R6XqKET9K_TZa6MV5ri5nEe1PZZa5nxUDg
470	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$boA4czH5oIsvFc6x_KDCG_swzSmQGxl27gKO9ZOui2g
471	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$r-terwMhDUst83AP3BuF_65QxRFF_Bz31yXmwcwiCkw
472	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$aeOkj7LoMaGdAmvBC2Bc4uEIRWdNQjeqANnY9gebuAg
473	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$TzcjfhPwQnyxQyDTJHZ3enB5uS4vuGo2KZ9hWhMd7DA
474	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$qm81FwKKxEmXU41v9_It0hqd_DP-rP6J1OWUj66euj8
475	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$K6k8nwmvbzlcqKtJQxyXIWbnHWP2Dr2W_eixSKZM2WI
476	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$XbSswxHbGv6u0RoNSYFgc-8QeaEO2TwzytUZh5grS8o
477	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$e3KeYP4IszF6dC4pVivY4C31rqzBkF9AfbYPp_XM3hs
478	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$39K2kmcIVRCqhSKHuKvnnMiz9N5hNnlJVYnU_B3EvRQ
479	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$PnOFYCidglsH25hKt3JstSjBQmTj02uuCUsYMp9a0PU
480	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$yNqdKiVuGHDuCN1HPns2LJiDCYkyhrY06WMSMDRXxaE
481	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$jSqIAhQEc4VxZvd4W3BH8IxV-UO-Tj0Hm0fo4RAJX8E
482	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$F5VyJX5kdbjHRvGMizgebzAIRdrasV1JS0UmUKCiKuo
483	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$VQpFjJTDuKaOnZ5CYFxRFQ-OWTuFVUX7-jGtg1Ile48
484	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$p3QZHNokAwpgE0_Frg-HUUYfQNHwEZSyg7XoQ5e-OcY
485	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$xsOY5znQhUAgS2eZttlpieqrRNhWOh5Wq2Cwkw86SUs
486	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$2lyxlgHkujicxG-7KdYJDtcW0A_day2NRrTrwpx49Bw
487	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$z9kfJtZShMmrPKUBf33ZOO6kUAGyQGvYjAApKC0LPDg
488	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$AOnPNAvpB2aF2OiBCfocVvA_0eCcZjIKPdXT6rF5ghc
489	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$gYeuzPYTXMj_j9kMC_vV0ZGrBwoFXjdkwCVwGarhLd0
490	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$76rQNRORitSAvr0yhpzW4AdFdzSv4ctOef75l7NPWo8
491	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$WYTPImcY7w8cd8Z1948NM1Xbr5A9DajlT0afbkBWK6g
493	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$b2OCKyutowQ_OGdva-D1m0KmvPSnr5K1jdA0C_H6Qt0
492	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$pjgbR_STMPETTha39k-nJOVoTpeld4earSgurREcAhs
494	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$86xAB58n4pUYJDS-IsnyLa8zzu90JcoWWMK9hJkl9EQ
495	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$WPUR9p2vIiwdUy_gTbvT4pHtjZV7sNMlPVxoTpQ8Gyc
496	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$AV3RSR_MYh_v4QNz4O5pWvHRLagte3FLcD3pZXpoe9Q
497	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$d-xqAkcQFHQ5UqEtzTkdDVJJriIK8LcgGjZ43XM_1oI
498	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Y6bkAK4aoQPqfs776xSSqw8V7U44ZRNxOYHzxQuYRk8
499	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$jDI9EgxmfsYgQ3BlMAQdRhdhIUx2_ItL8wmMiyw8VGs
500	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$-TUAFAJ3DeC1ra_qTxLxXuajBBr7FfvLxYe93JjDbLg
501	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$M2zAHDZELuOmni3_O6DP0M0od7GtjKI-yqb80diYQDI
502	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$2hxZAjhfPZ2DxJznIQyebkGr9-5LPDuuMBsdyyuoQQM
503	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$vACJgOgH6s_GfB3xYx6v2UkrE7SKkDLL8CGm7jC8ULE
504	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$6gP-Tehjbk1XPxDMJXrz8UOSUKAh086BRTtE3rb4sBU
505	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$n1YkCaXOhJ--xLl9Zx3JDBYOM7Qub-79dmxVYZayT2A
506	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$7qNGy0PqgrjH5546Iei5p8fQdGExuvpGdXq71CDz_qs
507	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$8Y5WPNcrfiBDzVeUPp9TJ21RQ-8qrMkR_baEYaKb2_4
508	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$qxjtyk5wJbpHl22XRlAkrwmBCT7nO_NAB5vDQhdzYrE
509	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$09Pn4aaVcJsK8VsKH8iU9lRfIH3_BTlqJ_Zs6r1DqG4
510	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$F7QGWDlMZOSQFP27Aq8OmXqK11O3r-FqzbLCqhYGFfw
511	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$Qt6MQ_IqqOXmNIJ4_OsYnAGsFIP5DPRs9vno86KcqTg
512	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$TPhmQuU3yZ_HkKqABfBVZUvaGvsNVtunNb23J4-1cZc
513	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$vxGipjBvv6SWX2hxqn915K6H4-jTXv0uo1lr5pUAjfI
514	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$cOo6lq5DWcfcn26OOfdgeFZAq2zdOCKy3veWZFVM2Ns
515	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$OiCVh2G9iZOuLdECqktyLkT4TLL_qjK24E_W8Tq1DUA
516	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$GHkGku7nSpHPMQjSNI4qxwD8HSOWv9VnVXSsGT6JHZg
517	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$8kDzrELlE_UWnL5hK1DxcZTtP9PTMKW0qMt0etA-BPU
518	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$_tvCWC3fX4jTHEPdegTywi-uE7Cnm7K7iAhxBz8WD_E
519	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$CoYgR2hnSlwAq76fP_i-gD_F1b6e9qZd6g1wdukinnE
520	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$Ab0o7NeD-KQ2tyno_Srrq32pG70sdvmuYoToqIpXbl8
521	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$48xcJgrplfq8wWsfMWxgXujxW3rzvQpk648z_SJM89g
522	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$1e3sHlt53tIWdX5ktRhL5qsjodG5jN499ttoQEnCMKg
523	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$zR3Fe8BpkvJlBP7tCC6chrQTN5UwuoKWWghUgceFN1U
524	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$2ggJ1_gc0uRb_x03ufyH23bfxBejHpkU_ADUzaSQl9c
525	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$zSuHxPD9U4iFva2bdGqApP-AEpJhXG_3ZT7KWKQWoIc
526	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$RD0DoBG1EPRM0tkCbCeDHbQ04g91UxDTWdZWLF4VbMM
527	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$LgLbXnxdav6w2strPYj8Pc6vmR-sLUzuHMSqp47lt_M
528	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$yGMQ8C-hHnAQkDZAH79Gn_YqZqOTC3tXEu0zoS-Ttcc
529	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$nLE0H5oYr7dYKUpGT_pVtT-Go1wbKKIfCkHsR0FOFbg
530	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$usinMOH0xtk8udhzzflTQGSxWUyc-2cspaD9HIWczT0
531	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$TdT_y-RuJG26SBB_VGtdA7gVa-QC1MsVMhEjy9wApbE
532	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$uFBaenQlmblZD7gKG6iq8N-22dI4AQ51U0vLEwu2qEI
533	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$vRVBQUY85cDpR9KBp9wvJcLnjvDyvu2wLWxzNwG9jV4
534	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$kkWADajf3lIUWFCK1ckiVmMrExjdZI9ZFjiODEzHngo
535	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$-Pq5JwqcOPKJreW531L17c5HCs3KsZEi1ywYFuXnaCU
536	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$zjiXxTJZVEYzoxZDY9uNqZIyiFCsB8c0DUm9U9Fuk7E
537	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$dz-b3tZjrv6YZJNadBICyAbpKwtjt6idU2qUelK-nGY
538	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$7IJzE6fE_UMKzW52F7gH3K6lpVbdDUh4O7ZukD7itbE
539	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$4H2AvCHdYU9XHcCPIVFfFHRkZGUfChJAh3Q9A5DGF40
540	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$YTuWG_BjbrzDVlSPohVXjBu8CXHnphyqqQuJXUJH7ew
541	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$cC_ivr8rkeBAUa_FjTUl4d-KvOjdoETfmKGr_CaTwX0
542	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$6jbKt2CVf_uarSrmNkuT-w_5LiEhn68tUWTigXnkYQ8
543	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$Hgz4OXf2UnZVqHOwxztTXb-cC3_ClhTfyic8zoaJj1o
544	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$nS6gLWANnbZw1Nc1RwIMv8HsvEKmnVgK3Vgu_mcDYDU
546	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$iiK1ZXn7Uuhn3ULIBrQqoToIUWVUJWDQR1BkKmy1JpI
548	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$Brjkd1XSPeknGy7f3dFRsRhUDJ8xemw_jLtjo1OVkSk
573	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$arPgHhFHE6dBjd4gzvtryh_NNYZNhUYuwtim1WN99eE
585	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$zoyjvjZ4Mgo95oRQbzWEGf-yt5GMhqtmIRJuYuFeIVc
595	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$ij2CDfzjXdlYcmp1Ghg_i0W3rGEmbA_PdMZbGKLvIkU
545	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$gyMgyAgyM_OgDhvlQfBhO6d2XzEo-p-dxEl6bHnFgoE
551	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$NUZkPXLg6U22UYdTs8VLlmUJ_TzC_PNGcVxRXKtTc2Q
552	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$Ge2qRE3CRZECV0SYGTWGxPs-Qj22--xq3jpWgb73Cn4
554	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$7kna76RM__wWZmXxNwYeR40VKRCf0-RFHTL3dsFpCOo
556	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$7I0OgyyShyLJ0KJDTal-J9rzXuED9II3sx7bUD9zOcs
558	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Joar5xoUxIMxVlDY8QADb5Yb9Xsrh89OqjAFN_ZI3JI
568	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$_z4AETauBl517WV2yqqo91-ZTOGAb8X0cOq5GpR4VXY
570	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$4kDKT3sjvaMV6Qf8xEHcPi28ILt8Qim8nkCBYTo-s-g
574	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$QQRR3vgD5VqktW1wNRnfJ-9SyQynllgkZpnhrt43-aY
577	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$_Mop4qnrH3PEsOf7hBCpvQ41zO30kiSlFH21b2UPZsg
579	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$sWyL5ETIVY-60YXzDtL7VuQIMXAStBOL3fK3SHiQizA
583	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$3IPqxhEMHwCe66RizYzXvwqnY7T4XQlDFzO2lXfHauU
590	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$_ip99Kkg8HFVuRabzUje01wpi9FgO3SBSRUSCrklhi0
591	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Zba0b8GUHYv4hvdDLfz8ucLk4ZbKryM0URHPT0IvTBs
592	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$agpJF9x2mt3cGpnc58d701Md6mJURV6NL9pPY53_kmk
594	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$GGws1PR9ggV6ff4kQWuhjGrmxpbnEfda43y6yH7N5Ew
547	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$K44LOKteBlKOlr4ittzG55xQyL-yd5dbyyPxZK3RSpE
559	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$c7rK_oUHfa9COHJCyxDrCEP9u17LjM29Wv2hEDrluh4
562	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$Ux4Veb6_qNVwdoxPRSOa7TQdeWu7orjska5Nr-bMCHQ
566	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$ZSEb9LVtUe5Ofgub8nGxoGTlmmOqvpqAUrHuLS4ktK8
575	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$S12nkw4S7SzSSnw6cfDIe1tIoMCgOh7ya4ivQeISn5Y
581	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$pR3GcQhxqP7nAkvaCzSxn4CjmdqlyV12eR0mqgU2BEw
593	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$kOUnZIPmtBD4GVGB0UtmnJPVRlHZnJ4n4Sr8QMo6Nmo
549	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$e929UrhVOZoujef7MTan3ahOqZogL1vtGJtIi0GRQ0o
550	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$71F_vJ40i3rgOX_Fb2_IJEs_t1NBabZvEZRM2sKqstg
553	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$MuQCUy_UK5t2I3BvlNc5xhRFU8OjncdFwOYyv8TwLPs
569	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$G1oiX5x0QEzwFx4ZozUTk3-67YpANQ10xP0sFe7DQmE
571	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$xMKZXTyFbWSdbyHmJC7nVAew4H1UeVy4R9xvTYuV8dU
572	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$OEvju5T8L0IuYvWZHYAzLgD6lk1OIQifwAmN7YfFtfo
578	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$2VR3ci7qaBedtDLAbpC1498ra4AV2HIjCQuSEbGzngA
582	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$jlVxUyaClnzULQOFZg307B7PLrtYQasYO5HKGlYFFtE
584	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$pYd9AeXSBoTpdThMilTeIVqGMab_-Isfnixql9t1MC0
586	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$TrhLO9mQUGGL8ZBvBy3aLrcByexW_2cCybLpWLHq1Zs
589	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$4SaygUB8Ff43p300nR-kfheP_aQs3Zu8mUgtbBUNeO8
555	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$F36u6nUjnCdDvRU829V6O0H31JjzG7P3cNemYfd8Qwc
560	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$9vL5EMBEZBlrQkyIjowaA52nvx-qaaM07vvDEgRoPQI
564	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$lHQO_kxfePQpvtGbVaxq0dGiIwAmNBZWx6-C0yDKexQ
567	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$wMGUNQXfUeMOS61U4O1dlgsSFHW9B_UW4TJ4w5v2dzw
576	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$c8bdkx_lGsUPOOkcH7mapzpOjRlEXU8I1cRbU-B3ng4
588	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$-c5dig-9sw6zinQN9AIdQago8f0KOcgmUyhzMBjoJDI
557	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$b4Oa3Z4fWHHEV_R4ZO1Hnq0c-SbS6fdHh-3LYy7Cxf4
561	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$OqfMWPUcuH0-mN1vDdvrcZ4_duQ89m6bwzV8_m8LlZ4
563	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$kg80-QZ-GqNmjWiTvdtM3PyInU570xi8Ri3flylf8Rc
565	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$wsLJvM3oKyjMmCfj5N6J7JBw69TWBr3QH3zpv6NjTtw
580	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$HYC9MmU307vhBcAQUChcHC3uQSoZSGHwFWO5j1cLG8w
587	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$WUnaXmFsKXKO9c5meSbhr8luj-OYMSWCvpyVJ9sBEeo
596	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$L-sRn17ud1mGJztg_U-7glC6U8sHRnuX6s9cRIpPQzk
597	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$patHbWjJiGlVmgdMd2Ep8bxYHnHYxApMgtJMVgwZL3k
598	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$iqL_RYNZlnzo0kbreDjl5YBRyp8U9kUnsTkjpkAe7_s
599	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$TGtT7Tm80Eo7dubJEfWVOVM3C4LVxtsBsBu41-teCho
600	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$KyRIVhdQK_Rm8T525IgNiiRvNzVcbNuPIs8fkLa4Ouo
601	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$2iH2N82j_psiLayFBLHb5guudGi8DotXHL_IPaVQ9V4
602	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$b1w4Uwg7wVi0RM9df-2BIMx16pe8hZY6NF5zFIvzgR0
603	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$CB-1TfHAuG14c0YZT2lyEKEEZrcLOJQmX5nXrPuVigc
604	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$XASM5-HjBQjRwrP_IR72f50wAwbc4WjX8xtSDOdgz98
605	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$97z_eyk30lpsYzpHuTdpzza1JdRX4DQOmN4-d9AAFLw
606	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$U5zKEbwku6ycvLYujToVsuuHyJCviiDEG-JnZRyZJns
607	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$2GhkzEMhKOc6pz2oyi4Zd6APZ-kLHpw4fsvJx7xTOsM
608	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$thbzS30z-1oaSbRth-uJt2fnjULmNZxml3DxFg9J0dg
609	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$N81fzYD8ARJvuEs9ykEg1cei8mThJFsdMpS51A7AnJA
610	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$uLlAnfd6a3gIXzL0Vo0hfcm5NLoNDJHfo5kmHQO4t4w
611	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$OUMK51TPz2SjFwx4woMPhsqVdB-bJeCQOttqCA_FdmE
612	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$RPjtshBezGfqnRDLopCdVwvF_IzEK64ods5n5SFyTVk
613	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$B6Rjmsia35KAtCXcU6oYWgTsCvnDZy7xQqyx_1DUeXk
614	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$sqjYP2hovrLJNRezSJWd0VLxIuhjhcx5Rf2_r0D4Hgw
615	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$Its0qBq0NurlUJC6-uC4Z6Cnuc6dcFGoNenRDuCJuJI
616	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$bWep3jEB42FmsjTRsH1-wjnfeTwWNPuK4xt0xcJEBkw
617	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$q9vhGFqjxqZcprCCKb_UZtsxFbxujaX611rEFVQItEQ
618	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$krAeY97shvwKyOJyTi90hXtAgwA-FeMo6zhV3-oDPGI
619	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$pUWJJbBtvG8giWi-v5bYK9SJUzUZeGiR3l6NZfnuvec
620	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$ekQ-3IPg1SiEZYCo6IQ59KJF9hxglZkE2u50I7MvwOo
621	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$PXh6DUjewZfzQsCAfNHUGt5fYdXxNZisjFsBDY5wZ1g
623	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$3WCH-xpkO1-8jJ_vuwsl5aYzNeud4WnmxfSDfS14SgE
622	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$OJr4c-Ab8UBqFqPcQnpVSY860C1csNr72p6Qqsbeeqw
624	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$pw3cuEtB-JMNp1n4SW0QgkztxfzHkY8D5sym5KckPaI
625	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$e2niLQDLFE_mvRA4Zln1EQV5saBhhOEIuR9_ZfzoLA8
626	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$Fq-A_5q0hHfaiaJBT-PKdB-YLhnmS__aRPL_ghsL2Qc
627	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$mp5XfGOY8bqbz2ZKF66i_iYHSa6MQjVBtGCdPDOuw5o
628	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$VHCbr3MOF4tHotX2KIjBScsYZqiE8wGdiqR0rpD7yEc
629	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$K7GwgH_4XHPEkNMbSDIHitJOBv7oP6COEHlMPU_XxSk
630	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$tSSNC2CoHpDnfkrByZuI5yIwQnkGfWgi78719EF2fTo
631	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Nnf21eixntvdCp5m2WCGU6GDBdx2bf8tB9n98SBd0sg
632	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$YVEEIBgXMpQzyS1b5HZDkjDGp2tWWxdK8RCq-FKdc3s
633	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$UjBEvkABkhTXv4-1U8VQjVJWBCB-WjnPcMs583tpGzs
634	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$L3vAzBYRC4sgLyH4mINPwSl-cvhgnkxuH53L5xXkbvc
635	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$_A9H6l1YCIyWeaKF0LESz5bjCo3hQn_35AnW1igUhQI
636	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$JE4KV092EgjgUfHyH-sos-Tj9wpjWvPovhuSN-c1LeQ
637	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$osMJL-EavW3iNUIJtx4UnItFlmK_e4UbroKPDO10Mx8
638	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$rxselF4IM1B8uuE3CLIdp_w2DJj1fBEJXF7EHJBMYKA
639	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$dkbHbD2l3QKhMVnjVmg4pDiBWcFwHSxSvnUFvVIF8jY
640	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$noBXIcFkpuaMLGdsOl4q4azSfGRtWzShBezHDtsJWUw
641	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$-TnoKgk-nb2MfxpeYor8K5d3vFd-Rn441I39oZ8Y0WU
642	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$i9AMGiTP8tBlZClOE9HpqC7ek8XTkldiog2Y4WfLfsg
643	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$xg8FDCH8lQVv7hUJtCN6U-beuRoy9Ue6xKF_t_tEuxY
646	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$1mQ0kqEFK9HCpuNxKsrTBu3Um6mrH4V8nN9muqsP5lE
644	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$alhywz8ivKCWyLckse6ukqUcToKsk0m8gKnebqxsBbM
647	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$Vwhq3Aug-KkxelmGhEpxo-Wl1iFz03MZluLAg6tTwBw
645	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$B5vma0V3tgeoxh2j5z0VhUBJN_WIYLACj-RLW-7KzZ4
649	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$MGwdoENIKM_afcyvUMD6G1hTqX8eLB5O7w4WgbyIbU8
648	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$p36rUyNB1atSVncL9VKK0wrdt4oU5RcMD3ErQGBaC1c
650	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$SNMmmoustem1mOi2UF8r9pnXBtCqmoS5OguiuNpM5bI
651	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$jDakROP1q-A11MRdrYsKMhHnPRyTeSD2IWbE0vmbkRY
652	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$-YtFFtix25AEzaujOz2rBDJk_t42v1taSIeW9YVq9fE
653	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$vGwTmQbTxOoaOgKMCME4NZcj8mGHzsatoWwYlqbtaO4
654	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$KTN4m61vTn3rIHWHXk5JoTYtykM2f_hGSYc8tEMTNyY
655	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$tKysdeYuG-DASU2RdR2UooF567KB4gaTUJIhTG4Bwt0
656	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$WVrTRGemi2iuepbSQzRhNd5u3qYtFajzcd38Cav7Sj0
657	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1:localhost	$-sOxyckTXT8fLsEBCklN2eursW15v33chOEyOHo9W8E
658	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$AdTvhCedlX8HkQDS9DMkeMF9qAJScvp4khcWCZvzx2w
659	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1:localhost	$s5Lt57UgfdEuuClHytzZbZihF-K7D_sVQmC4GcIgvag
660	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$oJx-93oiVgBsF9lKPPzaUVRJesRGLi-FCd13adCyz2k
661	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$UgHZKVjGiZ7ImztrKOcOttQmPzjlreluKj741-x4zxg
662	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$Kfw2jMPB-FOPgdgw5beX7hE2L6LpqJ-8c70ma1RW1zI
663	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$Okv3MleSVG-TfL8JDtRFsfr3KUR9pL9bG6s3x-huGSw
664	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Hn8zmwLfazLV77zyZOXOJ3VSIk-ThSTRGtjPbJRKlNM
665	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$N_eEyLVVB4UuZASAGn2cUNEPtPro523MDxJshaTIRoM
666	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$y1nxVnb7SmJBJ7mlCshyA_zWD-VL98isbPpmkpNvs8c
667	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$yKSj75ZII4oulXFHVrNEByncncH515RkDfY245vBcUU
668	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$j-f7KMEjAlWdaXgXKiATxSNLXUas_vcs7-vWC6V73IA
669	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$clK7OsQzqTDwc0VORyJ6CJBoCi6GaawXVBnxF7-0R_I
671	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$mhL8p8edyOhrPp-Pi3YcnDKx-fAclZdHWrsBXmXkDA8
670	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$jX1akduQovi8zxSCkQROKMjot_yz3AXpfnSSbf70918
672	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$aEQsbQvfQB4hXHMP2h9skj2CUnKQqY10TmYBzbD2BJs
673	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$g0XgRk751A8ItszuwvUurQScNqlMT0rNjxoHpuIUDrg
\.


--
-- Data for Name: stats_incremental_position; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.stats_incremental_position (lock, stream_id) FROM stdin;
X	135
\.


--
-- Data for Name: stream_ordering_to_exterm; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.stream_ordering_to_exterm (stream_ordering, room_id, event_id) FROM stdin;
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
40	!kmbTYjjsDRDHGgVqUP:localhost	$kHkn3X5sgQZbnc7m1GNs3FoN729sUsLsqASYxvh3Jb8
41	!dKcbdDATuwwphjRPQP:localhost	$cl-cBWQqCEUtQdjEqlQcE0PD7MCeX1R25oC5CKqb7oE
42	!dKcbdDATuwwphjRPQP:localhost	$8a8OTFPqvfsx2aHJeu9IBu-xR3Gn7rdv9l_HZtPKkFg
43	!kmbTYjjsDRDHGgVqUP:localhost	$BWMrEpKFpKKbBz5Ox9zTP3TvT5zyh6w3zhpl-epXhkk
44	!kmbTYjjsDRDHGgVqUP:localhost	$r3Ho1IsdJmJB13pD9yX-Jkg_a5s28kBCqoNZ5EPWwqM
45	!kmbTYjjsDRDHGgVqUP:localhost	$fQ28BQv7GUBcg_Ok7MCh8uTcQLoT2Tkr2BegUMhst1M
46	!kmbTYjjsDRDHGgVqUP:localhost	$S7qfuHyVNKlnX8WQb78EyVSR_7_dnmagLA8asozsQtE
47	!dKcbdDATuwwphjRPQP:localhost	$TOzcyxIV2S5U6CP15QCldRMJRaDz1Yaik15PorvZYGc
48	!kmbTYjjsDRDHGgVqUP:localhost	$Sa-w9Co29Yd94wHfPbpfCOuSSlMlorQ7ssiGXYp8oh8
49	!dKcbdDATuwwphjRPQP:localhost	$n6TBNMF739-W93vnPpWYiJ_zTj-UGsx8mCtkFUsmkrY
50	!kmbTYjjsDRDHGgVqUP:localhost	$5auMphtCZ9zvRqrhyXpY0s-cZZl2AbvkyGNRbm2h2zc
51	!kmbTYjjsDRDHGgVqUP:localhost	$Yb59onmhkHIpIJ_VnrP0V02pkFQEF1GwuJqZCNRTQeQ
52	!kmbTYjjsDRDHGgVqUP:localhost	$j0CTOXXA4AtSOD0pk6kL2BNsa6j5w517GGfkTqmm9ZE
53	!kmbTYjjsDRDHGgVqUP:localhost	$YgrzVCWDDxVv-dvf3HhpLD0QlN4nD5-CXg0T-gEX6iI
54	!kmbTYjjsDRDHGgVqUP:localhost	$IaI_j1zJZ04lmJmCzJfvnr48U2umqKYG1xogY-r9UNY
55	!dKcbdDATuwwphjRPQP:localhost	$TbIhAYsmySe2O7IaMBarYDokr6-UmyH4IYI3SpbhI-Q
56	!dKcbdDATuwwphjRPQP:localhost	$YBt0yFQdKC_886W6aXe4LIv5A5BcBP7pXYeF8XLKhH0
57	!dKcbdDATuwwphjRPQP:localhost	$-wkWlUVunP818RkFXsoACrEQ85-ybLTc-vWqiil50Vo
58	!kmbTYjjsDRDHGgVqUP:localhost	$kQPpv66TuseXeTXJr41QlqLnJBWNpBA_zgzIaJMjpLc
59	!dKcbdDATuwwphjRPQP:localhost	$BG2gCT3tXMWdl5AO704CVjroaQJysHmLZMRN-QrTH8w
60	!dKcbdDATuwwphjRPQP:localhost	$AXNJvl1CFFkmeDr63y2IykCN_G-lJiDa4JHsOjaUj4Y
61	!dKcbdDATuwwphjRPQP:localhost	$9hK3JsOVrMiv0wKjw57rMkc6mne_XmZ0CRTz65g97ek
62	!kmbTYjjsDRDHGgVqUP:localhost	$uFBLsg4RZn3DtG5dqcZ8A11zEbkWHwPLjk_VQtaj0qM
63	!kmbTYjjsDRDHGgVqUP:localhost	$wFcIkswyANl3CQZdt_hX9g9e2TeFjIzp9bWhcEbBiCI
64	!dKcbdDATuwwphjRPQP:localhost	$Y_FmFbCe62ffJ-UyN7IA1IbcRgUsELxe9lGLmGbDg9o
65	!dKcbdDATuwwphjRPQP:localhost	$CPoznAc0caDQuTVk0FlfLDWH79HumOVggLi7MDSYT5M
66	!dKcbdDATuwwphjRPQP:localhost	$pWJdSD5NsfN2PI0YapF9GmJPDpHhbeH6m--Uc5qoX-A
67	!kmbTYjjsDRDHGgVqUP:localhost	$zsvkWRGeOerm3Q5DPlTgr7kA7cM2-F0gXr40MUzknyc
68	!kmbTYjjsDRDHGgVqUP:localhost	$NSU5p_lrJEBTd3R6M_2_6ujF1CP9jw5z6-bDhTYxlzY
69	!kmbTYjjsDRDHGgVqUP:localhost	$35mlnbt-wcKTRY9cY7oyxyQbIoQPDLdRLHQQPGPVJzo
70	!kmbTYjjsDRDHGgVqUP:localhost	$bZPoJ2CteeROVbzJXAb_pwUfP2AIqhQn8X1nYN6cjRI
71	!kmbTYjjsDRDHGgVqUP:localhost	$EpI_As8tc8wuYQzlSbGEsxAOAAjphf1Wn48-zC2Pj68
72	!dKcbdDATuwwphjRPQP:localhost	$Q-2CPBoV3oTFZxGNkFMvNq26XugVjG2Cya0i5tuYeEg
73	!dKcbdDATuwwphjRPQP:localhost	$_k0ZpNW0oLpqiDqR7NJvZKdA2ZtHt_egRgLiFirmaYQ
74	!kmbTYjjsDRDHGgVqUP:localhost	$tWUlYx2qFNzpE_0CfMdKwbXSysRu-Z-uE0yWFp2GbGo
75	!dKcbdDATuwwphjRPQP:localhost	$Ip6vtDe80sOxCWnWoPVYYN-aqQ4AdGR-zO_krrdduFg
76	!kmbTYjjsDRDHGgVqUP:localhost	$9bNGuvT22oFV6Q8GFIzEZVofSbnyc61EIvnP8_3QqCE
77	!kmbTYjjsDRDHGgVqUP:localhost	$FhGz_XSQqkNt3u5faKV2p5k8gF47j_27y5RwVbtf3dk
78	!kmbTYjjsDRDHGgVqUP:localhost	$J2GCbFH7iG1fp5SNdsGmkmqFm59eqB_lJMGLY5yk1D8
79	!kmbTYjjsDRDHGgVqUP:localhost	$Dtmij3Zgur83VAr9O_P7MPtbPgUoMnnz_pOwemaro9I
80	!kmbTYjjsDRDHGgVqUP:localhost	$Y0__yZ70xH8p15Jr_yTtOJmrMCpaSJLwSo2cc1W4F6o
81	!kmbTYjjsDRDHGgVqUP:localhost	$gPWgeFNvAi1vMKPUzorqatfuOy4HXWKOwonBbcYhiN8
82	!kmbTYjjsDRDHGgVqUP:localhost	$Bh8N0WeVWl8koOcEkS8E0m4kulvHaq75oA0ou0aE8qs
83	!dKcbdDATuwwphjRPQP:localhost	$GgR_nTglOMJoS8SoJ-HFOS81y7cmJK64h0DeBVyFxkM
84	!dKcbdDATuwwphjRPQP:localhost	$_fc7lLRXoDsqiFKFvhlsSOsOE75ppMdi2ZRa-w_o0OY
85	!dKcbdDATuwwphjRPQP:localhost	$oXdn9vR9Yxd3FXZOxnZLiW-XByipCOWC32N6UNC7fCI
86	!kmbTYjjsDRDHGgVqUP:localhost	$sDESXFNHywZLVAjOAvBW4Qtv660_Xx9oVSAIUzZs5bA
87	!kmbTYjjsDRDHGgVqUP:localhost	$jnaBiJUcEka0drCdQFKBUWluWZq5S7dPNR3XCnWwx8g
88	!kmbTYjjsDRDHGgVqUP:localhost	$Hlu0oKcyD432dWmJ9w0xHm3PLMnH85Jn-X3GDTYuVV4
89	!dKcbdDATuwwphjRPQP:localhost	$krZXlGfGshKwkFJk6XwnR-gCOaeiC5p1Z6YZwNw6Tg0
90	!dKcbdDATuwwphjRPQP:localhost	$eY_eQCpyM7JAv11-157xBIO8c02XOKPAKO5-oLLkaMM
91	!dKcbdDATuwwphjRPQP:localhost	$vQGo7i4QMQ-SSBxBmQa7vPtet-fqNIosOIQOhXXoLwc
93	!kmbTYjjsDRDHGgVqUP:localhost	$m8qqKQF7tvdc1qLDrWf1DjyHng9_F2Y0v_gzFRh6Kag
96	!dKcbdDATuwwphjRPQP:localhost	$Yis1BltcsgIBI_y81aVbrWa5qBJs3O4cjY7TtOnv3AU
105	!dKcbdDATuwwphjRPQP:localhost	$zUomLm3mThwuYeUXH2UXzsuqxE6DQeH_95sT95psJag
110	!kmbTYjjsDRDHGgVqUP:localhost	$1c97W6vcISTaUEtVZ3XtpTvdbUxTp84W9UUnJ7yQ1hI
92	!dKcbdDATuwwphjRPQP:localhost	$CGChqoz8kvvahzTLr-uENaReKyq5KpqLrL1g9bePx2I
94	!kmbTYjjsDRDHGgVqUP:localhost	$UHKKJIW-yVrjog2Pg_MR43oEkfSUhSVKiFGHGPbNaOU
95	!kmbTYjjsDRDHGgVqUP:localhost	$_64yupcz2_qLrKOWrT87_V-HWN64bsQaq1VhCZ_zRnE
97	!dKcbdDATuwwphjRPQP:localhost	$3tVAg8SuDfjs9Fgkhfie7XW_PKyBUpsFLrnHYwASpBc
98	!kmbTYjjsDRDHGgVqUP:localhost	$ABAs5n2LLFjtJj9U8vpXJZW4XssE1_1AOKq1Hht9rAc
99	!kmbTYjjsDRDHGgVqUP:localhost	$XhY61XTnLilEWT5TBmpjFvWg-ttI3HSyLVoLRUVNShI
100	!kmbTYjjsDRDHGgVqUP:localhost	$efNJ2_fNXgtmBlwuX0QfDBZLeNBnkF0bix0VF0AaBUc
101	!kmbTYjjsDRDHGgVqUP:localhost	$Rx9kQ8hCx2y1bcLpdhzPqXHkrlExdX1yc3YshWnC6og
102	!kmbTYjjsDRDHGgVqUP:localhost	$hz_8OnlfAO5weTQ3Sy0cNJ83PP6UGxmBomiBKe4JB5w
103	!dKcbdDATuwwphjRPQP:localhost	$Op0TBQz5bRKUyxhUgvd0RMEbDt0BloR6y_aUatQJcO4
104	!kmbTYjjsDRDHGgVqUP:localhost	$KjxZjGyxoIyEvF0d6WjubIy5-PjQ8gTixRenqiw88iA
106	!kmbTYjjsDRDHGgVqUP:localhost	$XMPmaEvrP8Ebnl1P6-T-4JWR8Ms1HgLkboYib2Z0LAI
108	!kmbTYjjsDRDHGgVqUP:localhost	$8Lzt8KQPe0wAkuTOKq6BkdBqXu9LrnnsSyeYQ70hPDs
114	!kmbTYjjsDRDHGgVqUP:localhost	$uwxaXiusawT_bOeyGHwB7wfy4YVDUUpEs6A4YMBKfTg
116	!kmbTYjjsDRDHGgVqUP:localhost	$VcoB1_pk9tOinsmwdQJYShtIuSLosTj-jzPHDVJjEv8
117	!dKcbdDATuwwphjRPQP:localhost	$ORHWJnv40jDzKKISq_X3_aBTGHZZJqjFEVg1kUnrWQ4
119	!kmbTYjjsDRDHGgVqUP:localhost	$7SK-_DIPq2s374RTSr3as9S8GNyjBCDXOXK_ycMXc74
120	!dKcbdDATuwwphjRPQP:localhost	$0DBuAxDOgwokpytW0JkbbD3h3YNz3tiYsyJNZZqT6dM
123	!kmbTYjjsDRDHGgVqUP:localhost	$P2m7f_ReTUYd4Csc5OKob_vf90ua2PMyuv0NqQqhyZs
107	!dKcbdDATuwwphjRPQP:localhost	$sKC-AGmNhmjm9fAYYksybJgXr_tCsBeZrEAv6k7VTyk
109	!dKcbdDATuwwphjRPQP:localhost	$9i3p0sl8iw-4rVjwMHJnTFujme1in4rnO1zkP9hPq8w
111	!kmbTYjjsDRDHGgVqUP:localhost	$u2wX-H57z6LJIi2iBRq8--9YEHZj924d1XHR1tbNoTU
112	!kmbTYjjsDRDHGgVqUP:localhost	$dyDBJ0bfzPuc6VwuCR3A1Q2GNqb5JweFoRuLiNBdLgg
113	!kmbTYjjsDRDHGgVqUP:localhost	$HtuzOrzcCN4JBQCmC2S0KmN-Sq3OXYHy41_xxL3VNE4
115	!dKcbdDATuwwphjRPQP:localhost	$GoX13j6N-LFoVwqTvDVdFkmlAMyOQncU-wyYccvSOnE
118	!dKcbdDATuwwphjRPQP:localhost	$njvVCKYhRssX__fnFZ8owlNsOC9u3FRj0pmcqeIVVjI
121	!kmbTYjjsDRDHGgVqUP:localhost	$dbbS4HRWajCEFK63hUlDVeDwHbQPIAwiE7q2p34gr64
122	!kmbTYjjsDRDHGgVqUP:localhost	$tJ-FG4LvyDPWWc02tnnNTzC6FW5jTNsJ4Q0Y3sswUwU
124	!dKcbdDATuwwphjRPQP:localhost	$3DuuE2hHvtoVIEVkMMMOyVstiJ3B7k1t3FJ_ifxj4aw
125	!dKcbdDATuwwphjRPQP:localhost	$3_rhZk71KOig-uRX6JvtgQTiwiDNjWvrhDiK3CsG8Bc
126	!dKcbdDATuwwphjRPQP:localhost	$kFOWuoGosyBpmijZKeHjb49l9qG1PYd-7_Mz8m7TdZw
127	!dKcbdDATuwwphjRPQP:localhost	$WVRAu1BgFM0v9p1pHq87lQjV3QNR3ftT3-zfVqOdjoE
128	!dKcbdDATuwwphjRPQP:localhost	$GHt9inHBpvm4nrOPtbJHG8c8UlpzqeGJh_-OBG8ptHQ
129	!dKcbdDATuwwphjRPQP:localhost	$yVvV-TsDoWvvUlnpW14wS1F-qAd-Vm9J-uj4cAsZykg
130	!dKcbdDATuwwphjRPQP:localhost	$W37bP5pDpEKfiUi_hzWhdjakNnPVlC7KgjnlsImT9os
131	!dKcbdDATuwwphjRPQP:localhost	$2KYS5UbprMHWtKf1XE3EdQYt3jO__dF1wZsmNw0m7Po
132	!kmbTYjjsDRDHGgVqUP:localhost	$V_mgJvf-2J-ZWvd3_isj_ng3ED1Y3IR98ma44L3WQ4o
133	!kmbTYjjsDRDHGgVqUP:localhost	$WVroKTDWt83RCC4syxi_4hpsCXXPlQmrMVO527aD_bg
134	!kmbTYjjsDRDHGgVqUP:localhost	$n5Sx_AizJGu6tfAlx-aQBr2gIQ6eFROdu41oBPH_EYk
135	!kmbTYjjsDRDHGgVqUP:localhost	$U_hhCm5TKVpLfccts8cldxQRA18VARaw6KqAREJosKQ
\.


--
-- Data for Name: stream_positions; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.stream_positions (stream_name, instance_name, stream_id) FROM stdin;
account_data	master	60
presence_stream	master	384
receipts	master	18
events	master	135
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
FjZIsJmEtcXnfwPKXUeYLWzz	1673683494276	{"request_user_id":"@user1:localhost"}	{}	/_matrix/client/unstable/keys/device_signing/upload	POST	add a device signing key to your account
\.


--
-- Data for Name: ui_auth_sessions_credentials; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.ui_auth_sessions_credentials (session_id, stage_type, result) FROM stdin;
\.


--
-- Data for Name: ui_auth_sessions_ips; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.ui_auth_sessions_ips (session_id, ip, user_agent) FROM stdin;
FjZIsJmEtcXnfwPKXUeYLWzz	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36
\.


--
-- Data for Name: user_daily_visits; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_daily_visits (user_id, device_id, "timestamp", user_agent) FROM stdin;
@admin:localhost	WCSUBIGVWG	1672790400000	
@matrix_a:localhost	TKAVEOGKHH	1672790400000	
@matrix_b:localhost	DJFHSWMXLW	1672790400000	
@admin:localhost	WCSUBIGVWG	1672876800000	PostmanRuntime/7.30.0
@user1:localhost	ZLJUJWPSRR	1672876800000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
@user1:localhost	NXIGVVVFXK	1672876800000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
@matrix_b:localhost	DJFHSWMXLW	1672876800000	Playwright/1.29.1 (x64; macOS 12.6) node/18.2
@user1:localhost	MPUPZCTVVU	1672876800000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36
@matrix_a:localhost	TKAVEOGKHH	1673308800000	undici
@matrix_b:localhost	DJFHSWMXLW	1673395200000	
@admin:localhost	WCSUBIGVWG	1673395200000	
@matrix_a:localhost	TKAVEOGKHH	1673395200000	undici
@user1:localhost	RUGVQYUUVH	1673395200000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36
@user1:localhost	SANIOXWFGO	1673395200000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36
@user1:localhost	GQNMDRYGXH	1673395200000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36
@user1:localhost	GIFRBCGYKB	1673395200000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36
@user1:localhost	MNQVRBCAUG	1673568000000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36
@user1:localhost	MNQVRBCAUG	1673654400000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36
@user1:localhost	YRNLOWWMIS	1673654400000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36
@matrix_b:localhost	DJFHSWMXLW	1673654400000	Playwright/1.29.2 (x64; macOS 12.6) node/18.2
\.


--
-- Data for Name: user_directory; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_directory (user_id, room_id, display_name, avatar_url) FROM stdin;
@admin:localhost	\N	admin	\N
@matrix_a:localhost	\N	matrix_a	\N
@ignored_user:localhost	\N	ignored_user	\N
@matrix_b:localhost	\N	\N	\N
@user2:localhost	\N	User 2	\N
@user1:localhost	\N	User 1	\N
\.


--
-- Data for Name: user_directory_search; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_directory_search (user_id, vector) FROM stdin;
@admin:localhost	'admin':1A,3B 'localhost':2
@matrix_a:localhost	'localhost':2 'matrix':1A,3B
@ignored_user:localhost	'ignor':1A,4B 'localhost':3 'user':2A,5B
@matrix_b:localhost	'b':2A 'localhost':3 'matrix':1A
@user2:localhost	'2':4B 'localhost':2 'user':3B 'user2':1A
@user1:localhost	'1':4B 'localhost':2 'user':3B 'user1':1A
\.


--
-- Data for Name: user_directory_stream_pos; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_directory_stream_pos (lock, stream_id) FROM stdin;
X	135
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
user1	0	\\x7b22726f6f6d223a7b227374617465223a7b226c617a795f6c6f61645f6d656d62657273223a747275657d7d7d
\.


--
-- Data for Name: user_ips; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_ips (user_id, access_token, device_id, ip, user_agent, last_seen) FROM stdin;
@user1:localhost	syt_dXNlcjE_vFGpLeZRPNVxPbNorgcL_2sVSJz	ZLJUJWPSRR	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36	1672918199790
@user1:localhost	syt_dXNlcjE_dGiJSUmorpRoxHUDXRjR_0LCV3x	NXIGVVVFXK	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36	1672925412112
@user1:localhost	syt_dXNlcjE_BEmigoJNqBjQZGIGdMlE_1eiirr	MPUPZCTVVU	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Element/1.11.17 Chrome/108.0.5359.62 Electron/22.0.0 Safari/537.36	1672925559909
@user1:localhost	syt_dXNlcjE_twbcIxFDeJPokdrFQuLG_086a2C	RUGVQYUUVH	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	1673457105198
@user1:localhost	syt_dXNlcjE_LGnQVdOblEysOOBtecvy_1y3288	SANIOXWFGO	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	1673457223889
@admin:localhost	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjNjaWQgdXNlcl9pZCA9IEBhZG1pbjpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSBXVU9yUTVRMFRnUkNjME1ACjAwMmZzaWduYXR1cmUgdYKA-yuTQ5JV5O0HWRak-48xavOYgA1MMc6A1V_Uw5kK	WCSUBIGVWG	172.16.238.1		1673457535988
@user1:localhost	syt_dXNlcjE_OexwEKyumZSymlBdyNmn_4YUjcB	GIFRBCGYKB	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36	1673459336007
@user1:localhost	syt_dXNlcjE_sbRshouVnDtVAVggArmR_1nA1EH	GQNMDRYGXH	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36	1673459428243
@matrix_a:localhost	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjZjaWQgdXNlcl9pZCA9IEBtYXRyaXhfYTpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSAwb3Y6eTZVdHojUk4jbFprCjAwMmZzaWduYXR1cmUgNNZKnOVRzj5svh9pEM0UUEqtXYnHjnj9XyNLJ1_uKoAK	TKAVEOGKHH	172.16.238.1	undici	1673459764936
@user1:localhost	syt_dXNlcjE_HPGeQfSPFIwzsrgqwiYs_0hIeO6	YRNLOWWMIS	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	1673697158151
@user1:localhost	syt_dXNlcjE_GfXeGWBZFNCBDEgYsXHs_0Wk2Il	MNQVRBCAUG	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	1673683434088
@matrix_b:localhost	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjZjaWQgdXNlcl9pZCA9IEBtYXRyaXhfYjpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSBBYl9hbWthI0daSzgtfjdICjAwMmZzaWduYXR1cmUgOReBLkPURCMNtzORS9fpogQqVa3IWN9ZEu5gXW91QTMK	DJFHSWMXLW	172.16.238.1	Playwright/1.29.2 (x64; macOS 12.6) node/18.2	1673685169829
\.


--
-- Data for Name: user_signature_stream; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_signature_stream (stream_id, from_user_id, user_ids) FROM stdin;
11	@user1:localhost	["@user1:localhost"]
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
@user1:localhost	2	41
@mm_user1:localhost	2	49
@user2:localhost	0	110
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
@user1:localhost	email	user1@localhost	1672918078891	1672918078891
@user2:localhost	email	user2@localhost	1673457283108	1673457283108
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.users (name, password_hash, creation_ts, admin, upgrade_ts, is_guest, appservice_id, consent_version, consent_server_notice_sent, user_type, deactivated, shadow_banned) FROM stdin;
@matrix_a:localhost	$2b$12$V8cOJ670WikSre/C66CGI.a1ANkbEvkgYEUW.M23dlUnekRcPr08O	1598686327	0	\N	0	\N	\N	\N	\N	0	\N
@matrix_b:localhost	$2b$12$gnHJ1cdN/bfA2A2V61rPauepmeV2dLXr/pC70rCZy9qZoM9u2GKaq	1598686327	0	\N	0	\N	\N	\N	\N	0	\N
@ignored_user:localhost	$2b$12$cDOaADzxfGcFFspSrfJNcueOwevhD2Ex0hu6oAJcpz3S/owrOeSsW	1598686327	0	\N	0	\N	\N	\N	\N	0	\N
@matterbot:localhost		1672856700	0	\N	0	xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	\N	\N	\N	0	f
@mm_mattermost_b:localhost		1672856704	0	\N	0	xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	\N	\N	\N	0	f
@mm_mattermost_a:localhost		1672856704	0	\N	0	xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	\N	\N	\N	0	f
@admin:localhost	$2b$12$y3lT6nJGWMTXBWF2kFRaRuUqALWaFe.dhbEEBKROoFnkoKBuDnLhK	1598686326	1	\N	0	\N	\N	\N	\N	0	\N
@mm_user1:localhost		1672922249	0	\N	0	xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	\N	\N	\N	0	f
@user2:localhost	$2b$12$uKY6dQ8obYDqweUL7y3QBezIhdhku1ods3OP86iL7b4P03SN96V.u	1673457283	0	\N	0	\N	\N	\N	\N	0	f
@user1:localhost	$2b$12$rX4t6Wx9x3piVanSLXgEF.s8xRfSzp6WyUvDqvnDiZ2fhkBD1XhYK	1672918078	0	\N	0	\N	\N	\N	\N	0	f
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
@user1:localhost	!kmbTYjjsDRDHGgVqUP:localhost
@user1:localhost	!dKcbdDATuwwphjRPQP:localhost
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

SELECT pg_catalog.setval('public.account_data_sequence', 60, true);


--
-- Name: cache_invalidation_stream_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.cache_invalidation_stream_seq', 279, true);


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

SELECT pg_catalog.setval('public.events_stream_seq', 135, true);


--
-- Name: instance_map_instance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.instance_map_instance_id_seq', 1, false);


--
-- Name: presence_stream_sequence; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.presence_stream_sequence', 384, true);


--
-- Name: receipts_sequence; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.receipts_sequence', 18, true);


--
-- Name: state_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.state_group_id_seq', 673, true);


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

