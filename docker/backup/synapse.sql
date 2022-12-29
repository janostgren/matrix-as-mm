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
6	@bridgedemo1:localhost	OEVKYFSVRM	syt_YnJpZGdlZGVtbzE_MTBlUHyqiBJBcVyFsmub_2xw2s3	\N	\N	1672237198925	\N	f
7	@matterbot:localhost	DTAXGIQPDM	syt_bWF0dGVyYm90_HEyVYyerXjuzPeTpgXib_0g7VWG	\N	\N	1672241417248	\N	f
8	@mm_mattermost_a:localhost	LOWWEFFERP	syt_bW1fbWF0dGVybW9zdF9h_TiRCHRPArvaNeePqSNsE_2R1XV8	\N	\N	1672241421168	\N	f
9	@mm_mattermost_b:localhost	DDYXDXSBCQ	syt_bW1fbWF0dGVybW9zdF9i_zaUUJJRgWVpYjdYxJekI_4VgYx4	\N	\N	1672241421325	\N	f
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
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	up	175	\N	\N
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
X	194
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
27	master	user_last_seen_monthly_active	\N	1672236785579
28	master	get_monthly_active_count	{}	1672236785585
29	master	user_last_seen_monthly_active	\N	1672237005831
30	master	get_monthly_active_count	{}	1672237005833
31	master	get_user_by_id	{@bridgedemo1:localhost}	1672237198842
32	master	user_last_seen_monthly_active	\N	1672237743138
33	master	get_monthly_active_count	{}	1672237743140
34	master	user_last_seen_monthly_active	\N	1672238815675
35	master	get_monthly_active_count	{}	1672238815678
36	master	user_last_seen_monthly_active	\N	1672241113704
37	master	get_monthly_active_count	{}	1672241113706
38	master	get_user_by_id	{@matterbot:localhost}	1672241417204
39	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@matterbot:localhost}	1672241417945
40	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@matterbot:localhost}	1672241418081
41	master	get_user_by_id	{@mm_mattermost_a:localhost}	1672241421142
42	master	get_user_by_id	{@mm_mattermost_b:localhost}	1672241421299
43	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_a:localhost}	1672241421501
44	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_a:localhost}	1672241421648
45	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_b:localhost}	1672241421708
46	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_b:localhost}	1672241421848
47	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_a:localhost}	1672241421935
48	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_a:localhost}	1672241422057
49	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_b:localhost}	1672241422157
50	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_b:localhost}	1672241422274
51	master	user_last_seen_monthly_active	\N	1672244713567
52	master	get_monthly_active_count	{}	1672244713569
53	master	user_last_seen_monthly_active	\N	1672248313566
54	master	get_monthly_active_count	{}	1672248313567
55	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_a:localhost}	1672248712226
56	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_a:localhost}	1672248798348
57	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_a:localhost}	1672248798467
58	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@matrix_a:localhost}	1672249105033
59	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@matrix_a:localhost}	1672249106206
60	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@matrix_a:localhost}	1672249107036
61	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@matrix_a:localhost}	1672249107551
62	master	get_device_list_last_stream_id_for_remote	{@matrix_a:localhost}	1672249107628
63	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@matrix_a:localhost}	1672249107957
64	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@matrix_a:localhost}	1672249108398
65	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_b:localhost}	1672249109770
71	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@matterbot:localhost}	1672249110398
75	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@matterbot:localhost}	1672249111347
80	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_b:localhost}	1672249112795
104	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_a:localhost}	1672308588469
113	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_b:localhost}	1672308591067
66	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_a:localhost}	1672249110037
67	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_a:localhost}	1672249110083
72	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@matterbot:localhost}	1672249110543
73	master	get_device_list_last_stream_id_for_remote	{@matterbot:localhost}	1672249110579
76	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_b:localhost}	1672249112274
86	master	user_last_seen_monthly_active	\N	1672263914473
87	master	get_monthly_active_count	{}	1672263914488
88	master	user_last_seen_monthly_active	\N	1672271120015
89	master	get_monthly_active_count	{}	1672271120049
100	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_a:localhost}	1672305682190
105	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@matrix_a:localhost}	1672308588626
109	master	get_device_list_last_stream_id_for_remote	{@matrix_a:localhost}	1672308589425
118	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@matterbot:localhost}	1672308591490
121	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@matterbot:localhost}	1672308592259
125	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_a:localhost}	1672308593263
68	master	get_device_list_last_stream_id_for_remote	{@mm_mattermost_a:localhost}	1672249110186
84	master	user_last_seen_monthly_active	\N	1672256686346
85	master	get_monthly_active_count	{}	1672256686349
90	master	user_last_seen_monthly_active	\N	1672278324607
91	master	get_monthly_active_count	{}	1672278324608
111	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@matrix_a:localhost}	1672308590101
123	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_b:localhost}	1672308593065
69	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_b:localhost}	1672249110320
77	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_a:localhost}	1672249112367
78	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_a:localhost}	1672249112543
108	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@matrix_a:localhost}	1672308589394
129	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_a:localhost}	1672308593665
70	master	get_device_list_last_stream_id_for_remote	{@mm_mattermost_b:localhost}	1672249110387
74	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@matterbot:localhost}	1672249111294
79	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_b:localhost}	1672249112644
81	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_a:localhost}	1672249112900
82	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_a:localhost}	1672249113032
94	master	user_last_seen_monthly_active	\N	1672292732278
95	master	get_monthly_active_count	{}	1672292732285
96	master	user_last_seen_monthly_active	\N	1672299937476
97	master	get_monthly_active_count	{}	1672299937490
98	master	user_last_seen_monthly_active	\N	1672305549260
99	master	get_monthly_active_count	{}	1672305549266
101	master	user_last_seen_monthly_active	\N	1672305913566
102	master	get_monthly_active_count	{}	1672305913566
103	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_a:localhost}	1672308588301
107	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@matrix_a:localhost}	1672308589204
110	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@matrix_a:localhost}	1672308589647
112	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_a:localhost}	1672308591065
114	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_b:localhost}	1672308591261
116	master	get_device_list_last_stream_id_for_remote	{@mm_mattermost_b:localhost}	1672308591307
117	master	get_device_list_last_stream_id_for_remote	{@mm_mattermost_a:localhost}	1672308591325
119	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@matterbot:localhost}	1672308591539
122	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@matterbot:localhost}	1672308592328
126	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_a:localhost}	1672308593369
127	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_b:localhost}	1672308593489
130	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_a:localhost}	1672308593765
83	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_b:localhost}	1672249113543
92	master	user_last_seen_monthly_active	\N	1672285528325
93	master	get_monthly_active_count	{}	1672285528334
106	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@matrix_a:localhost}	1672308588869
115	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_a:localhost}	1672308591264
120	master	get_device_list_last_stream_id_for_remote	{@matterbot:localhost}	1672308591587
124	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_b:localhost}	1672308593162
128	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_b:localhost}	1672308593597
131	master	user_last_seen_monthly_active	\N	1672309513574
132	master	get_monthly_active_count	{}	1672309513576
133	master	user_last_seen_monthly_active	\N	1672313113563
134	master	get_monthly_active_count	{}	1672313113564
135	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_a:localhost}	1672314814444
136	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_a:localhost}	1672314814701
137	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_a:localhost}	1672314814844
138	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@matrix_a:localhost}	1672314815006
139	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@matrix_a:localhost}	1672314815247
140	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@matrix_a:localhost}	1672314815506
141	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@matrix_a:localhost}	1672314815719
142	master	get_device_list_last_stream_id_for_remote	{@matrix_a:localhost}	1672314815748
143	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@matrix_a:localhost}	1672314815962
144	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@matrix_a:localhost}	1672314816453
145	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_a:localhost}	1672314817207
146	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_b:localhost}	1672314817227
147	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_a:localhost}	1672314817533
148	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_b:localhost}	1672314817534
149	master	get_device_list_last_stream_id_for_remote	{@mm_mattermost_a:localhost}	1672314817569
150	master	get_device_list_last_stream_id_for_remote	{@mm_mattermost_b:localhost}	1672314817582
151	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@matterbot:localhost}	1672314817752
152	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@matterbot:localhost}	1672314817787
153	master	get_device_list_last_stream_id_for_remote	{@matterbot:localhost}	1672314817819
154	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@matterbot:localhost}	1672314818491
155	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@matterbot:localhost}	1672314818502
156	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_b:localhost}	1672314819306
157	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_b:localhost}	1672314819362
158	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_a:localhost}	1672314819519
159	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_a:localhost}	1672314819566
160	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_b:localhost}	1672314819709
161	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_b:localhost}	1672314819792
162	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_a:localhost}	1672314819885
163	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_a:localhost}	1672314819978
164	master	user_last_seen_monthly_active	\N	1672314987690
165	master	get_monthly_active_count	{}	1672314987697
166	master	user_last_seen_monthly_active	\N	1672318587547
167	master	get_monthly_active_count	{}	1672318587551
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
20	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$oPNBx-eTHzyLXPzpYpdxdhLdVeGmx5lNmrECxIazfPQ	\N	master
21	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$3pZnE6ITQzzyNsuVCenuFBVRMocr892PiAvIbMGbMBM	\N	master
22	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$Oqb-EaDS-8U6U1Z6bTGSE7FJIlxKGhzMkNsnYIJY0Y0	\N	master
23	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$hJeKBcpebJzm9oiwjDCNTWPtbEcfp9GOLXl3yGkyaFU	\N	master
24	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$9cACT8rCcbUXbMhABzEciyF9pIIDRFNzaBkRVPH_0mk	\N	master
25	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$0gxNuNkWyOeHPtnNZ92FzvprItMgnH9hLCbYuY0Vzos	\N	master
26	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$9ArTh8Z2w2oc68FOD1X8Ka3DlK7lq00HaHKT_4DMSY4	$Oqb-EaDS-8U6U1Z6bTGSE7FJIlxKGhzMkNsnYIJY0Y0	master
27	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$V_uchZ_8H2oh6EdsXqKsT6Ri62_YZtAAMfZi8pbBGrc	$hJeKBcpebJzm9oiwjDCNTWPtbEcfp9GOLXl3yGkyaFU	master
28	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Q4TOA6SPu2kQIrypB8QEJLHphxV5mHZ_eFwQux4jWSY	$9cACT8rCcbUXbMhABzEciyF9pIIDRFNzaBkRVPH_0mk	master
29	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$YwLlyzcAMpJ69jsxTNglcWTbK8XHK8huc6aB6jpgEWk	$0gxNuNkWyOeHPtnNZ92FzvprItMgnH9hLCbYuY0Vzos	master
30	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$irHFClZVEAzlAtsjct-1MJjEotldPu1Ozkm_NYQrtqI	$9ArTh8Z2w2oc68FOD1X8Ka3DlK7lq00HaHKT_4DMSY4	master
31	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$QwAobZq6xey4D-6yOm_xg4h6rCKIRUpTqM4HBNroJwE	$irHFClZVEAzlAtsjct-1MJjEotldPu1Ozkm_NYQrtqI	master
32	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$3xEI-iU3Teo4B51pXGBbjKxM_DDvYlASNK7W09pHncM	$QwAobZq6xey4D-6yOm_xg4h6rCKIRUpTqM4HBNroJwE	master
33	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	$ETv-B1S-bU8wgS3S1fDdineVdS9YGNq1EMeUPHb6imQ	$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0	master
34	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	$GMh4hFLoeDc1Ssk9kdi7yAMIMSZA9zOJYJMC1AJEOKs	$ETv-B1S-bU8wgS3S1fDdineVdS9YGNq1EMeUPHb6imQ	master
35	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	$zMfjO64yH55JKcwd-hMCa1P1ARHyAuvBbnPeUiNnS48	$GMh4hFLoeDc1Ssk9kdi7yAMIMSZA9zOJYJMC1AJEOKs	master
36	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_a:localhost	$5-KkKYPCr68IjD4sKk3rDF6kVYVkDMllW0BFUv7G4Do	$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8	master
37	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_a:localhost	$sPO_9Od1FvK55Z9_vb0hx3ophiGuLyATo1RKYIEFxHc	$5-KkKYPCr68IjD4sKk3rDF6kVYVkDMllW0BFUv7G4Do	master
38	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	$oXLyUPbqiXmRRNovjt9_FJFQLCzMQjPsaism-trtsDw	$zMfjO64yH55JKcwd-hMCa1P1ARHyAuvBbnPeUiNnS48	master
39	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$7EOMmT1sBVcDB2udDBhhf11Mok_GC9CY-6bxtIKAYpc	$Q4TOA6SPu2kQIrypB8QEJLHphxV5mHZ_eFwQux4jWSY	master
40	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$-J2tr3j7vfmJ8ZSBAK5AyvQYmP2Byp-7dKfcBg5xHjU	$V_uchZ_8H2oh6EdsXqKsT6Ri62_YZtAAMfZi8pbBGrc	master
41	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$o0wI9-m-SdyS4UK7_m9_MUd0luWmj6eoXfMg1ieT00g	$3xEI-iU3Teo4B51pXGBbjKxM_DDvYlASNK7W09pHncM	master
42	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$wEwGnOPXUgG2_4DpqsPrYbSlIM2TnPjdWNDyVbZNE2Y	$YwLlyzcAMpJ69jsxTNglcWTbK8XHK8huc6aB6jpgEWk	master
43	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$oZEGsAxUrYn8R6NS359wZO9T54eXOD-N88ftDK7ZHGU	$oPNBx-eTHzyLXPzpYpdxdhLdVeGmx5lNmrECxIazfPQ	master
44	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$LN4aYSSVw4GLaWf8g7uzrsw-fHTUyCBwq_-RRgS-MGE	$3pZnE6ITQzzyNsuVCenuFBVRMocr892PiAvIbMGbMBM	master
45	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$sY34u-PbOKSI3_z8SIqGfn_2XnO9wqZ_eU1dvGDnRJY	$oZEGsAxUrYn8R6NS359wZO9T54eXOD-N88ftDK7ZHGU	master
46	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$zhfRuogjo-Vq5GM4-f6hyuXBGHx99o9_Nef1KWi2-EM	$LN4aYSSVw4GLaWf8g7uzrsw-fHTUyCBwq_-RRgS-MGE	master
47	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$3A5iUMUsDMAckTZ_lQ9ZLyQdw7FKGrqWfMMxwAZJCwc	$7EOMmT1sBVcDB2udDBhhf11Mok_GC9CY-6bxtIKAYpc	master
48	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$aUCd2uzLS80uiu1DeYrTDp1wAWs7M1ba_4Srm8LLnmU	$-J2tr3j7vfmJ8ZSBAK5AyvQYmP2Byp-7dKfcBg5xHjU	master
49	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$zogqtnD68sbYTleQBUL-RkGDpkNmTHar6ilm_2oVnRs	$o0wI9-m-SdyS4UK7_m9_MUd0luWmj6eoXfMg1ieT00g	master
50	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$OcjvTopfs1z8zuVgRxn4ynq9LH7z4eQhJnWG0PQ7150	$wEwGnOPXUgG2_4DpqsPrYbSlIM2TnPjdWNDyVbZNE2Y	master
51	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$GcBRlllGdKFvT1pDzY7airMfjuYYNt06vxkQ0BnM6IM	$3A5iUMUsDMAckTZ_lQ9ZLyQdw7FKGrqWfMMxwAZJCwc	master
52	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$JtjXz-jm6mi5wU33MudkV8ZsCM2V-zduDqeI1xIG254	$aUCd2uzLS80uiu1DeYrTDp1wAWs7M1ba_4Srm8LLnmU	master
53	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$6cga7PdI_98v2MEH6Wosfik3Plxt3Ml7GwsUkSFFa00	$zogqtnD68sbYTleQBUL-RkGDpkNmTHar6ilm_2oVnRs	master
54	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$0BYuX-7BWlMOYXwWp-y_txKwBBorVZzavW6fDuXxUrM	$OcjvTopfs1z8zuVgRxn4ynq9LH7z4eQhJnWG0PQ7150	master
55	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$OOCwtQCB-nmnnlgQ3ST3ItcIsITOLkC3b4a-WpaJjRg	$6cga7PdI_98v2MEH6Wosfik3Plxt3Ml7GwsUkSFFa00	master
65	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$0ruVoUZRE1Edh-f7Z0QopPRTCr7L2kEpX8unxgxmfSQ	$OOCwtQCB-nmnnlgQ3ST3ItcIsITOLkC3b4a-WpaJjRg	master
66	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$hWVSd4FzjwQq7FYDdhFSCgpisb3gxDJ2OAjCjYS6rkg	$0ruVoUZRE1Edh-f7Z0QopPRTCr7L2kEpX8unxgxmfSQ	master
67	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	$OJhJIVnJWjcgl3gc2AqLQK7sy1tKn075fy4E5qUK014	$oXLyUPbqiXmRRNovjt9_FJFQLCzMQjPsaism-trtsDw	master
68	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	$nsJ2oe7ZtdBtY0V-sJWzGBBDi7tcgH24zUaAdmLjXy4	$OJhJIVnJWjcgl3gc2AqLQK7sy1tKn075fy4E5qUK014	master
69	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	$XYKCYavbY8FMdUIlSSoqP0likUnTP6uJ0yHoGQCMnWQ	$nsJ2oe7ZtdBtY0V-sJWzGBBDi7tcgH24zUaAdmLjXy4	master
70	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_a:localhost	$fc-Paa3ZBQU-GAAxH4QWDNrWblQvQ4ddYVzPTPiYV6U	$sPO_9Od1FvK55Z9_vb0hx3ophiGuLyATo1RKYIEFxHc	master
71	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_a:localhost	$4KgY7ivi_pp1q2tjdk7IWENjs1kzgSRLB29nKbq-UXw	$fc-Paa3ZBQU-GAAxH4QWDNrWblQvQ4ddYVzPTPiYV6U	master
72	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	$0EmcDbHM6t0AJ7YKAcphqL8othdZg4dIXSazEHvnCno	$XYKCYavbY8FMdUIlSSoqP0likUnTP6uJ0yHoGQCMnWQ	master
73	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$EklY0FV28pDgoXqwoQUjAB5wTv33O8RCHRE8k2k6o2c	$JtjXz-jm6mi5wU33MudkV8ZsCM2V-zduDqeI1xIG254	master
74	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$ShuNV5AOx3oTjKr3eYjFKvzCZ374R_0vxs2HC21ht-g	$GcBRlllGdKFvT1pDzY7airMfjuYYNt06vxkQ0BnM6IM	master
75	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$UTOQTSrmXya3IQYDcRPwNWN1bIv2zQ3YfbaVRy9NQuA	$0BYuX-7BWlMOYXwWp-y_txKwBBorVZzavW6fDuXxUrM	master
76	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$IfK4xyQ_h94nUHneDilGoM0TTwuWFeP5_u_nlRs571U	$hWVSd4FzjwQq7FYDdhFSCgpisb3gxDJ2OAjCjYS6rkg	master
77	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$sbDgkkxT05mw8xIVFWyOJtbW9nnehE06Wvxor1z8ms8	$zhfRuogjo-Vq5GM4-f6hyuXBGHx99o9_Nef1KWi2-EM	master
78	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$aaPR9QI7az6NxeJ0hSrQxyKzzVyM-rBWODbN9y9rM9Q	$sY34u-PbOKSI3_z8SIqGfn_2XnO9wqZ_eU1dvGDnRJY	master
79	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$TbzKCcECXvJAKvBu5GZCTLIGi7Js0b1w9dE6KKZXaKo	$aaPR9QI7az6NxeJ0hSrQxyKzzVyM-rBWODbN9y9rM9Q	master
80	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$2-SFwejONuAnI3cUJ4UN3FSzzJjeIWUURtWOJiO2sWo	$sbDgkkxT05mw8xIVFWyOJtbW9nnehE06Wvxor1z8ms8	master
81	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$72MNMNMOJMJpfLbdNKdm6ZXGr14ukIKdq-fG2OvzOqg	$UTOQTSrmXya3IQYDcRPwNWN1bIv2zQ3YfbaVRy9NQuA	master
82	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$LjACIs2QTEZTfukFRb30GQyevcb7EREdVFxoNEgvHSk	$ShuNV5AOx3oTjKr3eYjFKvzCZ374R_0vxs2HC21ht-g	master
83	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$XhzyXIYIbI0BfDV1QY4H3b4Wrpy5pJgJsGNZc8P8seg	$EklY0FV28pDgoXqwoQUjAB5wTv33O8RCHRE8k2k6o2c	master
84	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$EB67Xwo9B0__CxNTvptFIy4e4vG93cmEcHRWbiVSFJU	$IfK4xyQ_h94nUHneDilGoM0TTwuWFeP5_u_nlRs571U	master
85	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$85g2ma_sFrYS8UbhpRwYEglJLj7xswd8VgNCg787_3E	$72MNMNMOJMJpfLbdNKdm6ZXGr14ukIKdq-fG2OvzOqg	master
86	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$jL60Q94H_SC7S4ZFOWkA4RilDwTMIUci2DyEXyQS_t0	$LjACIs2QTEZTfukFRb30GQyevcb7EREdVFxoNEgvHSk	master
87	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$WPbDUZRE7W6o_O4D0qf40PxoXNWcHrBwx3LxCA_ILaY	$XhzyXIYIbI0BfDV1QY4H3b4Wrpy5pJgJsGNZc8P8seg	master
88	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$sPW_-g3Oq09Bq8Rm-TKPTRO4HHOlMXEni0rE18Y01h4	$EB67Xwo9B0__CxNTvptFIy4e4vG93cmEcHRWbiVSFJU	master
104	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$BtKmdXlHyT65KPvPIiDSk38oldbOKOUbuv7J13Up4wE	$sPW_-g3Oq09Bq8Rm-TKPTRO4HHOlMXEni0rE18Y01h4	master
105	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$HVWinlm6AKNeOld7iV_yqdfmpznmG5wAyWK5k3xjM7Y	$BtKmdXlHyT65KPvPIiDSk38oldbOKOUbuv7J13Up4wE	master
106	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$FNOekiMLFE4AEgQ1st7kiouCRAYO3DKEMbrYHGbH-zw	$HVWinlm6AKNeOld7iV_yqdfmpznmG5wAyWK5k3xjM7Y	master
107	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	$56oOQ2hizWAJWWKoJTMYGwAKX_gaANdZg2QHgtC63ZE	$0EmcDbHM6t0AJ7YKAcphqL8othdZg4dIXSazEHvnCno	master
108	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	$6Sy4DU04a_WCzalQkimJ_l9-eYsJ3kcn3Lat9w42L2I	$56oOQ2hizWAJWWKoJTMYGwAKX_gaANdZg2QHgtC63ZE	master
109	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	$FC2J9PSIQLoF8YJo6zY2dP8Eo55L8CPgzVGN7iaofRo	$6Sy4DU04a_WCzalQkimJ_l9-eYsJ3kcn3Lat9w42L2I	master
110	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_a:localhost	$WcPnOWvRmgShLlAe8RxY4-_M71l0auS5ykpKdmUS0LU	$4KgY7ivi_pp1q2tjdk7IWENjs1kzgSRLB29nKbq-UXw	master
111	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_a:localhost	$-R5ZDLwPtIisO-W746dPRRrr1U6HjM8uhC78Zh95UUQ	$WcPnOWvRmgShLlAe8RxY4-_M71l0auS5ykpKdmUS0LU	master
112	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E	$FC2J9PSIQLoF8YJo6zY2dP8Eo55L8CPgzVGN7iaofRo	master
114	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$19Wa_uoHXFwHicMPIWHRa1c8H1yIjgzKxpDzo89CTTE	$WPbDUZRE7W6o_O4D0qf40PxoXNWcHrBwx3LxCA_ILaY	master
113	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$M2xNoGVeTRazjk5EjiA0u3mOkneK7za9KWYn2LMJFwA	$jL60Q94H_SC7S4ZFOWkA4RilDwTMIUci2DyEXyQS_t0	master
115	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$lDJnxY-YfTRyXQcBLRlbFT2_w4DXO4Pks75YGGa5M5o	$85g2ma_sFrYS8UbhpRwYEglJLj7xswd8VgNCg787_3E	master
116	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$SLqtTg1DQZU0Y4ezk90kDHz7IxD9TXjhW4qQAoPUfTk	$FNOekiMLFE4AEgQ1st7kiouCRAYO3DKEMbrYHGbH-zw	master
117	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$6ZYuUr8K6uh0D7tl9-HD___6hQH3lj8qU1liF0zAkmo	$2-SFwejONuAnI3cUJ4UN3FSzzJjeIWUURtWOJiO2sWo	master
118	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$t_tUn4wROpupdwEmZnXWQ-mtnx68XnGjofi61K92cRY	$TbzKCcECXvJAKvBu5GZCTLIGi7Js0b1w9dE6KKZXaKo	master
119	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$JgtV2Jrt_3Cws_oeqEte6xeUnTbTSMu0pBPrEWD4WyM	$t_tUn4wROpupdwEmZnXWQ-mtnx68XnGjofi61K92cRY	master
120	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$Qyk1jqM8wu6uOaEDEalSs_0hepeq6CnfZZRy1hQ4sd8	$6ZYuUr8K6uh0D7tl9-HD___6hQH3lj8qU1liF0zAkmo	master
121	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$qgyz1sVriFBiepR7YLOpA_tcnRjhDX9q13fkeJa8i3U	$M2xNoGVeTRazjk5EjiA0u3mOkneK7za9KWYn2LMJFwA	master
122	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$ZLuzCoh1UZ9oNHYyBNCtneq81TelpJ882dsDdio0oKU	$lDJnxY-YfTRyXQcBLRlbFT2_w4DXO4Pks75YGGa5M5o	master
125	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Zv-9wNEnjnF-VeZtZKtHkYObGhccwLKewNnJg-fUiF8	$qgyz1sVriFBiepR7YLOpA_tcnRjhDX9q13fkeJa8i3U	master
123	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$ggRHO4QwGg8SLwSXlSNnHypSBsgj2jFMUXbjC7U97qM	$SLqtTg1DQZU0Y4ezk90kDHz7IxD9TXjhW4qQAoPUfTk	master
124	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$0ClPrn0jv_hdCQB4TqbWVPUxxSqFeDViCsOjYwQVDAg	$19Wa_uoHXFwHicMPIWHRa1c8H1yIjgzKxpDzo89CTTE	master
126	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$aa2-bg9KcCtrn4nE5HK1JGC6sa8Gr7jWqLhPgLQTtsU	$ZLuzCoh1UZ9oNHYyBNCtneq81TelpJ882dsDdio0oKU	master
127	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$ewJTQJq2XdLvkqYVULlUmmJ-A3LQ6Jnqs4GDYi6q0DE	$ggRHO4QwGg8SLwSXlSNnHypSBsgj2jFMUXbjC7U97qM	master
128	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo	$0ClPrn0jv_hdCQB4TqbWVPUxxSqFeDViCsOjYwQVDAg	master
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
$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_b:localhost	join
$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_b:localhost	join
$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@ignored_user:localhost	join
$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@ignored_user:localhost	join
$-R5ZDLwPtIisO-W746dPRRrr1U6HjM8uhC78Zh95UUQ	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_a:localhost	join
$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	join
$JgtV2Jrt_3Cws_oeqEte6xeUnTbTSMu0pBPrEWD4WyM	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	join
$Qyk1jqM8wu6uOaEDEalSs_0hepeq6CnfZZRy1hQ4sd8	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	join
$Zv-9wNEnjnF-VeZtZKtHkYObGhccwLKewNnJg-fUiF8	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	join
$aa2-bg9KcCtrn4nE5HK1JGC6sa8Gr7jWqLhPgLQTtsU	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	join
$ewJTQJq2XdLvkqYVULlUmmJ-A3LQ6Jnqs4GDYi6q0DE	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	join
$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	join
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
6	@bridgedemo1:localhost	OEVKYFSVRM
7	@matterbot:localhost	DTAXGIQPDM
8	@mm_mattermost_a:localhost	LOWWEFFERP
9	@mm_mattermost_b:localhost	DDYXDXSBCQ
\.


--
-- Data for Name: devices; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.devices (user_id, device_id, display_name, last_seen, ip, user_agent, hidden) FROM stdin;
@ignored_user:localhost	IYEBBQEXHS	\N	1598686328565	172.21.0.1	curl/7.72.0	f
@bridgedemo1:localhost	OEVKYFSVRM	\N	\N	\N	\N	f
@matterbot:localhost	DTAXGIQPDM	\N	\N	\N	\N	f
@mm_mattermost_a:localhost	LOWWEFFERP	\N	\N	\N	\N	f
@mm_mattermost_b:localhost	DDYXDXSBCQ	\N	\N	\N	\N	f
@admin:localhost	WCSUBIGVWG	\N	1672317897932	172.19.0.1		f
@matrix_a:localhost	TKAVEOGKHH	\N	1672317898023	172.19.0.1		f
@matrix_b:localhost	DJFHSWMXLW	\N	1672317898111	172.19.0.1		f
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
$oPNBx-eTHzyLXPzpYpdxdhLdVeGmx5lNmrECxIazfPQ	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$oPNBx-eTHzyLXPzpYpdxdhLdVeGmx5lNmrECxIazfPQ	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$oPNBx-eTHzyLXPzpYpdxdhLdVeGmx5lNmrECxIazfPQ	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$3pZnE6ITQzzyNsuVCenuFBVRMocr892PiAvIbMGbMBM	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$3pZnE6ITQzzyNsuVCenuFBVRMocr892PiAvIbMGbMBM	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$3pZnE6ITQzzyNsuVCenuFBVRMocr892PiAvIbMGbMBM	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$Oqb-EaDS-8U6U1Z6bTGSE7FJIlxKGhzMkNsnYIJY0Y0	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$Oqb-EaDS-8U6U1Z6bTGSE7FJIlxKGhzMkNsnYIJY0Y0	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$Oqb-EaDS-8U6U1Z6bTGSE7FJIlxKGhzMkNsnYIJY0Y0	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$Oqb-EaDS-8U6U1Z6bTGSE7FJIlxKGhzMkNsnYIJY0Y0	$oPNBx-eTHzyLXPzpYpdxdhLdVeGmx5lNmrECxIazfPQ	!dKcbdDATuwwphjRPQP:localhost
$hJeKBcpebJzm9oiwjDCNTWPtbEcfp9GOLXl3yGkyaFU	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$hJeKBcpebJzm9oiwjDCNTWPtbEcfp9GOLXl3yGkyaFU	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$hJeKBcpebJzm9oiwjDCNTWPtbEcfp9GOLXl3yGkyaFU	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$hJeKBcpebJzm9oiwjDCNTWPtbEcfp9GOLXl3yGkyaFU	$3pZnE6ITQzzyNsuVCenuFBVRMocr892PiAvIbMGbMBM	!kmbTYjjsDRDHGgVqUP:localhost
$9cACT8rCcbUXbMhABzEciyF9pIIDRFNzaBkRVPH_0mk	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$9cACT8rCcbUXbMhABzEciyF9pIIDRFNzaBkRVPH_0mk	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$9cACT8rCcbUXbMhABzEciyF9pIIDRFNzaBkRVPH_0mk	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$9cACT8rCcbUXbMhABzEciyF9pIIDRFNzaBkRVPH_0mk	$oPNBx-eTHzyLXPzpYpdxdhLdVeGmx5lNmrECxIazfPQ	!dKcbdDATuwwphjRPQP:localhost
$V_uchZ_8H2oh6EdsXqKsT6Ri62_YZtAAMfZi8pbBGrc	$hJeKBcpebJzm9oiwjDCNTWPtbEcfp9GOLXl3yGkyaFU	!kmbTYjjsDRDHGgVqUP:localhost
$V_uchZ_8H2oh6EdsXqKsT6Ri62_YZtAAMfZi8pbBGrc	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$V_uchZ_8H2oh6EdsXqKsT6Ri62_YZtAAMfZi8pbBGrc	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$V_uchZ_8H2oh6EdsXqKsT6Ri62_YZtAAMfZi8pbBGrc	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$0gxNuNkWyOeHPtnNZ92FzvprItMgnH9hLCbYuY0Vzos	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$0gxNuNkWyOeHPtnNZ92FzvprItMgnH9hLCbYuY0Vzos	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$0gxNuNkWyOeHPtnNZ92FzvprItMgnH9hLCbYuY0Vzos	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$0gxNuNkWyOeHPtnNZ92FzvprItMgnH9hLCbYuY0Vzos	$3pZnE6ITQzzyNsuVCenuFBVRMocr892PiAvIbMGbMBM	!kmbTYjjsDRDHGgVqUP:localhost
$9ArTh8Z2w2oc68FOD1X8Ka3DlK7lq00HaHKT_4DMSY4	$Oqb-EaDS-8U6U1Z6bTGSE7FJIlxKGhzMkNsnYIJY0Y0	!dKcbdDATuwwphjRPQP:localhost
$9ArTh8Z2w2oc68FOD1X8Ka3DlK7lq00HaHKT_4DMSY4	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$9ArTh8Z2w2oc68FOD1X8Ka3DlK7lq00HaHKT_4DMSY4	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$9ArTh8Z2w2oc68FOD1X8Ka3DlK7lq00HaHKT_4DMSY4	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$Q4TOA6SPu2kQIrypB8QEJLHphxV5mHZ_eFwQux4jWSY	$9cACT8rCcbUXbMhABzEciyF9pIIDRFNzaBkRVPH_0mk	!dKcbdDATuwwphjRPQP:localhost
$Q4TOA6SPu2kQIrypB8QEJLHphxV5mHZ_eFwQux4jWSY	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$Q4TOA6SPu2kQIrypB8QEJLHphxV5mHZ_eFwQux4jWSY	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$Q4TOA6SPu2kQIrypB8QEJLHphxV5mHZ_eFwQux4jWSY	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$YwLlyzcAMpJ69jsxTNglcWTbK8XHK8huc6aB6jpgEWk	$0gxNuNkWyOeHPtnNZ92FzvprItMgnH9hLCbYuY0Vzos	!kmbTYjjsDRDHGgVqUP:localhost
$YwLlyzcAMpJ69jsxTNglcWTbK8XHK8huc6aB6jpgEWk	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$YwLlyzcAMpJ69jsxTNglcWTbK8XHK8huc6aB6jpgEWk	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$YwLlyzcAMpJ69jsxTNglcWTbK8XHK8huc6aB6jpgEWk	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$irHFClZVEAzlAtsjct-1MJjEotldPu1Ozkm_NYQrtqI	$9ArTh8Z2w2oc68FOD1X8Ka3DlK7lq00HaHKT_4DMSY4	!dKcbdDATuwwphjRPQP:localhost
$irHFClZVEAzlAtsjct-1MJjEotldPu1Ozkm_NYQrtqI	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$irHFClZVEAzlAtsjct-1MJjEotldPu1Ozkm_NYQrtqI	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$QwAobZq6xey4D-6yOm_xg4h6rCKIRUpTqM4HBNroJwE	$irHFClZVEAzlAtsjct-1MJjEotldPu1Ozkm_NYQrtqI	!dKcbdDATuwwphjRPQP:localhost
$QwAobZq6xey4D-6yOm_xg4h6rCKIRUpTqM4HBNroJwE	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$QwAobZq6xey4D-6yOm_xg4h6rCKIRUpTqM4HBNroJwE	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$QwAobZq6xey4D-6yOm_xg4h6rCKIRUpTqM4HBNroJwE	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$QwAobZq6xey4D-6yOm_xg4h6rCKIRUpTqM4HBNroJwE	$oPNBx-eTHzyLXPzpYpdxdhLdVeGmx5lNmrECxIazfPQ	!dKcbdDATuwwphjRPQP:localhost
$3xEI-iU3Teo4B51pXGBbjKxM_DDvYlASNK7W09pHncM	$QwAobZq6xey4D-6yOm_xg4h6rCKIRUpTqM4HBNroJwE	!dKcbdDATuwwphjRPQP:localhost
$3xEI-iU3Teo4B51pXGBbjKxM_DDvYlASNK7W09pHncM	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$3xEI-iU3Teo4B51pXGBbjKxM_DDvYlASNK7W09pHncM	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$3xEI-iU3Teo4B51pXGBbjKxM_DDvYlASNK7W09pHncM	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$ETv-B1S-bU8wgS3S1fDdineVdS9YGNq1EMeUPHb6imQ	$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0	!dKcbdDATuwwphjRPQP:localhost
$ETv-B1S-bU8wgS3S1fDdineVdS9YGNq1EMeUPHb6imQ	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$ETv-B1S-bU8wgS3S1fDdineVdS9YGNq1EMeUPHb6imQ	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$GMh4hFLoeDc1Ssk9kdi7yAMIMSZA9zOJYJMC1AJEOKs	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$GMh4hFLoeDc1Ssk9kdi7yAMIMSZA9zOJYJMC1AJEOKs	$ETv-B1S-bU8wgS3S1fDdineVdS9YGNq1EMeUPHb6imQ	!dKcbdDATuwwphjRPQP:localhost
$GMh4hFLoeDc1Ssk9kdi7yAMIMSZA9zOJYJMC1AJEOKs	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$GMh4hFLoeDc1Ssk9kdi7yAMIMSZA9zOJYJMC1AJEOKs	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$zMfjO64yH55JKcwd-hMCa1P1ARHyAuvBbnPeUiNnS48	$GMh4hFLoeDc1Ssk9kdi7yAMIMSZA9zOJYJMC1AJEOKs	!dKcbdDATuwwphjRPQP:localhost
$zMfjO64yH55JKcwd-hMCa1P1ARHyAuvBbnPeUiNnS48	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$zMfjO64yH55JKcwd-hMCa1P1ARHyAuvBbnPeUiNnS48	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$5-KkKYPCr68IjD4sKk3rDF6kVYVkDMllW0BFUv7G4Do	$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8	!kmbTYjjsDRDHGgVqUP:localhost
$5-KkKYPCr68IjD4sKk3rDF6kVYVkDMllW0BFUv7G4Do	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$5-KkKYPCr68IjD4sKk3rDF6kVYVkDMllW0BFUv7G4Do	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$sPO_9Od1FvK55Z9_vb0hx3ophiGuLyATo1RKYIEFxHc	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$sPO_9Od1FvK55Z9_vb0hx3ophiGuLyATo1RKYIEFxHc	$5-KkKYPCr68IjD4sKk3rDF6kVYVkDMllW0BFUv7G4Do	!kmbTYjjsDRDHGgVqUP:localhost
$sPO_9Od1FvK55Z9_vb0hx3ophiGuLyATo1RKYIEFxHc	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$sPO_9Od1FvK55Z9_vb0hx3ophiGuLyATo1RKYIEFxHc	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$oXLyUPbqiXmRRNovjt9_FJFQLCzMQjPsaism-trtsDw	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$oXLyUPbqiXmRRNovjt9_FJFQLCzMQjPsaism-trtsDw	$zMfjO64yH55JKcwd-hMCa1P1ARHyAuvBbnPeUiNnS48	!dKcbdDATuwwphjRPQP:localhost
$oXLyUPbqiXmRRNovjt9_FJFQLCzMQjPsaism-trtsDw	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$oXLyUPbqiXmRRNovjt9_FJFQLCzMQjPsaism-trtsDw	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$7EOMmT1sBVcDB2udDBhhf11Mok_GC9CY-6bxtIKAYpc	$Q4TOA6SPu2kQIrypB8QEJLHphxV5mHZ_eFwQux4jWSY	!dKcbdDATuwwphjRPQP:localhost
$7EOMmT1sBVcDB2udDBhhf11Mok_GC9CY-6bxtIKAYpc	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$7EOMmT1sBVcDB2udDBhhf11Mok_GC9CY-6bxtIKAYpc	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$-J2tr3j7vfmJ8ZSBAK5AyvQYmP2Byp-7dKfcBg5xHjU	$V_uchZ_8H2oh6EdsXqKsT6Ri62_YZtAAMfZi8pbBGrc	!kmbTYjjsDRDHGgVqUP:localhost
$-J2tr3j7vfmJ8ZSBAK5AyvQYmP2Byp-7dKfcBg5xHjU	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$-J2tr3j7vfmJ8ZSBAK5AyvQYmP2Byp-7dKfcBg5xHjU	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$o0wI9-m-SdyS4UK7_m9_MUd0luWmj6eoXfMg1ieT00g	$3xEI-iU3Teo4B51pXGBbjKxM_DDvYlASNK7W09pHncM	!dKcbdDATuwwphjRPQP:localhost
$o0wI9-m-SdyS4UK7_m9_MUd0luWmj6eoXfMg1ieT00g	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$o0wI9-m-SdyS4UK7_m9_MUd0luWmj6eoXfMg1ieT00g	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$3A5iUMUsDMAckTZ_lQ9ZLyQdw7FKGrqWfMMxwAZJCwc	$7EOMmT1sBVcDB2udDBhhf11Mok_GC9CY-6bxtIKAYpc	!dKcbdDATuwwphjRPQP:localhost
$3A5iUMUsDMAckTZ_lQ9ZLyQdw7FKGrqWfMMxwAZJCwc	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$3A5iUMUsDMAckTZ_lQ9ZLyQdw7FKGrqWfMMxwAZJCwc	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$3A5iUMUsDMAckTZ_lQ9ZLyQdw7FKGrqWfMMxwAZJCwc	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$3A5iUMUsDMAckTZ_lQ9ZLyQdw7FKGrqWfMMxwAZJCwc	$sY34u-PbOKSI3_z8SIqGfn_2XnO9wqZ_eU1dvGDnRJY	!dKcbdDATuwwphjRPQP:localhost
$wEwGnOPXUgG2_4DpqsPrYbSlIM2TnPjdWNDyVbZNE2Y	$YwLlyzcAMpJ69jsxTNglcWTbK8XHK8huc6aB6jpgEWk	!kmbTYjjsDRDHGgVqUP:localhost
$wEwGnOPXUgG2_4DpqsPrYbSlIM2TnPjdWNDyVbZNE2Y	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$wEwGnOPXUgG2_4DpqsPrYbSlIM2TnPjdWNDyVbZNE2Y	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$aUCd2uzLS80uiu1DeYrTDp1wAWs7M1ba_4Srm8LLnmU	$-J2tr3j7vfmJ8ZSBAK5AyvQYmP2Byp-7dKfcBg5xHjU	!kmbTYjjsDRDHGgVqUP:localhost
$aUCd2uzLS80uiu1DeYrTDp1wAWs7M1ba_4Srm8LLnmU	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$aUCd2uzLS80uiu1DeYrTDp1wAWs7M1ba_4Srm8LLnmU	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$aUCd2uzLS80uiu1DeYrTDp1wAWs7M1ba_4Srm8LLnmU	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$aUCd2uzLS80uiu1DeYrTDp1wAWs7M1ba_4Srm8LLnmU	$zhfRuogjo-Vq5GM4-f6hyuXBGHx99o9_Nef1KWi2-EM	!kmbTYjjsDRDHGgVqUP:localhost
$zogqtnD68sbYTleQBUL-RkGDpkNmTHar6ilm_2oVnRs	$o0wI9-m-SdyS4UK7_m9_MUd0luWmj6eoXfMg1ieT00g	!dKcbdDATuwwphjRPQP:localhost
$zogqtnD68sbYTleQBUL-RkGDpkNmTHar6ilm_2oVnRs	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$zogqtnD68sbYTleQBUL-RkGDpkNmTHar6ilm_2oVnRs	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$zogqtnD68sbYTleQBUL-RkGDpkNmTHar6ilm_2oVnRs	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$zogqtnD68sbYTleQBUL-RkGDpkNmTHar6ilm_2oVnRs	$sY34u-PbOKSI3_z8SIqGfn_2XnO9wqZ_eU1dvGDnRJY	!dKcbdDATuwwphjRPQP:localhost
$oZEGsAxUrYn8R6NS359wZO9T54eXOD-N88ftDK7ZHGU	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$oZEGsAxUrYn8R6NS359wZO9T54eXOD-N88ftDK7ZHGU	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$oZEGsAxUrYn8R6NS359wZO9T54eXOD-N88ftDK7ZHGU	$oPNBx-eTHzyLXPzpYpdxdhLdVeGmx5lNmrECxIazfPQ	!dKcbdDATuwwphjRPQP:localhost
$zhfRuogjo-Vq5GM4-f6hyuXBGHx99o9_Nef1KWi2-EM	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$zhfRuogjo-Vq5GM4-f6hyuXBGHx99o9_Nef1KWi2-EM	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$zhfRuogjo-Vq5GM4-f6hyuXBGHx99o9_Nef1KWi2-EM	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$zhfRuogjo-Vq5GM4-f6hyuXBGHx99o9_Nef1KWi2-EM	$LN4aYSSVw4GLaWf8g7uzrsw-fHTUyCBwq_-RRgS-MGE	!kmbTYjjsDRDHGgVqUP:localhost
$GcBRlllGdKFvT1pDzY7airMfjuYYNt06vxkQ0BnM6IM	$3A5iUMUsDMAckTZ_lQ9ZLyQdw7FKGrqWfMMxwAZJCwc	!dKcbdDATuwwphjRPQP:localhost
$GcBRlllGdKFvT1pDzY7airMfjuYYNt06vxkQ0BnM6IM	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$GcBRlllGdKFvT1pDzY7airMfjuYYNt06vxkQ0BnM6IM	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$GcBRlllGdKFvT1pDzY7airMfjuYYNt06vxkQ0BnM6IM	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$LN4aYSSVw4GLaWf8g7uzrsw-fHTUyCBwq_-RRgS-MGE	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$LN4aYSSVw4GLaWf8g7uzrsw-fHTUyCBwq_-RRgS-MGE	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$LN4aYSSVw4GLaWf8g7uzrsw-fHTUyCBwq_-RRgS-MGE	$3pZnE6ITQzzyNsuVCenuFBVRMocr892PiAvIbMGbMBM	!kmbTYjjsDRDHGgVqUP:localhost
$sY34u-PbOKSI3_z8SIqGfn_2XnO9wqZ_eU1dvGDnRJY	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$sY34u-PbOKSI3_z8SIqGfn_2XnO9wqZ_eU1dvGDnRJY	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$sY34u-PbOKSI3_z8SIqGfn_2XnO9wqZ_eU1dvGDnRJY	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$sY34u-PbOKSI3_z8SIqGfn_2XnO9wqZ_eU1dvGDnRJY	$oZEGsAxUrYn8R6NS359wZO9T54eXOD-N88ftDK7ZHGU	!dKcbdDATuwwphjRPQP:localhost
$OcjvTopfs1z8zuVgRxn4ynq9LH7z4eQhJnWG0PQ7150	$wEwGnOPXUgG2_4DpqsPrYbSlIM2TnPjdWNDyVbZNE2Y	!kmbTYjjsDRDHGgVqUP:localhost
$OcjvTopfs1z8zuVgRxn4ynq9LH7z4eQhJnWG0PQ7150	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$OcjvTopfs1z8zuVgRxn4ynq9LH7z4eQhJnWG0PQ7150	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$OcjvTopfs1z8zuVgRxn4ynq9LH7z4eQhJnWG0PQ7150	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$OcjvTopfs1z8zuVgRxn4ynq9LH7z4eQhJnWG0PQ7150	$zhfRuogjo-Vq5GM4-f6hyuXBGHx99o9_Nef1KWi2-EM	!kmbTYjjsDRDHGgVqUP:localhost
$JtjXz-jm6mi5wU33MudkV8ZsCM2V-zduDqeI1xIG254	$aUCd2uzLS80uiu1DeYrTDp1wAWs7M1ba_4Srm8LLnmU	!kmbTYjjsDRDHGgVqUP:localhost
$JtjXz-jm6mi5wU33MudkV8ZsCM2V-zduDqeI1xIG254	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$JtjXz-jm6mi5wU33MudkV8ZsCM2V-zduDqeI1xIG254	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$JtjXz-jm6mi5wU33MudkV8ZsCM2V-zduDqeI1xIG254	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$6cga7PdI_98v2MEH6Wosfik3Plxt3Ml7GwsUkSFFa00	$zogqtnD68sbYTleQBUL-RkGDpkNmTHar6ilm_2oVnRs	!dKcbdDATuwwphjRPQP:localhost
$6cga7PdI_98v2MEH6Wosfik3Plxt3Ml7GwsUkSFFa00	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$6cga7PdI_98v2MEH6Wosfik3Plxt3Ml7GwsUkSFFa00	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$6cga7PdI_98v2MEH6Wosfik3Plxt3Ml7GwsUkSFFa00	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$0BYuX-7BWlMOYXwWp-y_txKwBBorVZzavW6fDuXxUrM	$OcjvTopfs1z8zuVgRxn4ynq9LH7z4eQhJnWG0PQ7150	!kmbTYjjsDRDHGgVqUP:localhost
$0BYuX-7BWlMOYXwWp-y_txKwBBorVZzavW6fDuXxUrM	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$0BYuX-7BWlMOYXwWp-y_txKwBBorVZzavW6fDuXxUrM	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$0BYuX-7BWlMOYXwWp-y_txKwBBorVZzavW6fDuXxUrM	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$OOCwtQCB-nmnnlgQ3ST3ItcIsITOLkC3b4a-WpaJjRg	$6cga7PdI_98v2MEH6Wosfik3Plxt3Ml7GwsUkSFFa00	!dKcbdDATuwwphjRPQP:localhost
$OOCwtQCB-nmnnlgQ3ST3ItcIsITOLkC3b4a-WpaJjRg	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$OOCwtQCB-nmnnlgQ3ST3ItcIsITOLkC3b4a-WpaJjRg	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$0ruVoUZRE1Edh-f7Z0QopPRTCr7L2kEpX8unxgxmfSQ	$OOCwtQCB-nmnnlgQ3ST3ItcIsITOLkC3b4a-WpaJjRg	!dKcbdDATuwwphjRPQP:localhost
$0ruVoUZRE1Edh-f7Z0QopPRTCr7L2kEpX8unxgxmfSQ	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$0ruVoUZRE1Edh-f7Z0QopPRTCr7L2kEpX8unxgxmfSQ	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$0ruVoUZRE1Edh-f7Z0QopPRTCr7L2kEpX8unxgxmfSQ	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$0ruVoUZRE1Edh-f7Z0QopPRTCr7L2kEpX8unxgxmfSQ	$sY34u-PbOKSI3_z8SIqGfn_2XnO9wqZ_eU1dvGDnRJY	!dKcbdDATuwwphjRPQP:localhost
$hWVSd4FzjwQq7FYDdhFSCgpisb3gxDJ2OAjCjYS6rkg	$0ruVoUZRE1Edh-f7Z0QopPRTCr7L2kEpX8unxgxmfSQ	!dKcbdDATuwwphjRPQP:localhost
$hWVSd4FzjwQq7FYDdhFSCgpisb3gxDJ2OAjCjYS6rkg	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$hWVSd4FzjwQq7FYDdhFSCgpisb3gxDJ2OAjCjYS6rkg	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$hWVSd4FzjwQq7FYDdhFSCgpisb3gxDJ2OAjCjYS6rkg	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$OJhJIVnJWjcgl3gc2AqLQK7sy1tKn075fy4E5qUK014	$oXLyUPbqiXmRRNovjt9_FJFQLCzMQjPsaism-trtsDw	!dKcbdDATuwwphjRPQP:localhost
$OJhJIVnJWjcgl3gc2AqLQK7sy1tKn075fy4E5qUK014	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$OJhJIVnJWjcgl3gc2AqLQK7sy1tKn075fy4E5qUK014	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$nsJ2oe7ZtdBtY0V-sJWzGBBDi7tcgH24zUaAdmLjXy4	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$nsJ2oe7ZtdBtY0V-sJWzGBBDi7tcgH24zUaAdmLjXy4	$OJhJIVnJWjcgl3gc2AqLQK7sy1tKn075fy4E5qUK014	!dKcbdDATuwwphjRPQP:localhost
$nsJ2oe7ZtdBtY0V-sJWzGBBDi7tcgH24zUaAdmLjXy4	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$nsJ2oe7ZtdBtY0V-sJWzGBBDi7tcgH24zUaAdmLjXy4	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$XYKCYavbY8FMdUIlSSoqP0likUnTP6uJ0yHoGQCMnWQ	$nsJ2oe7ZtdBtY0V-sJWzGBBDi7tcgH24zUaAdmLjXy4	!dKcbdDATuwwphjRPQP:localhost
$XYKCYavbY8FMdUIlSSoqP0likUnTP6uJ0yHoGQCMnWQ	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$XYKCYavbY8FMdUIlSSoqP0likUnTP6uJ0yHoGQCMnWQ	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$fc-Paa3ZBQU-GAAxH4QWDNrWblQvQ4ddYVzPTPiYV6U	$sPO_9Od1FvK55Z9_vb0hx3ophiGuLyATo1RKYIEFxHc	!kmbTYjjsDRDHGgVqUP:localhost
$fc-Paa3ZBQU-GAAxH4QWDNrWblQvQ4ddYVzPTPiYV6U	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$fc-Paa3ZBQU-GAAxH4QWDNrWblQvQ4ddYVzPTPiYV6U	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$4KgY7ivi_pp1q2tjdk7IWENjs1kzgSRLB29nKbq-UXw	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$4KgY7ivi_pp1q2tjdk7IWENjs1kzgSRLB29nKbq-UXw	$fc-Paa3ZBQU-GAAxH4QWDNrWblQvQ4ddYVzPTPiYV6U	!kmbTYjjsDRDHGgVqUP:localhost
$4KgY7ivi_pp1q2tjdk7IWENjs1kzgSRLB29nKbq-UXw	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$4KgY7ivi_pp1q2tjdk7IWENjs1kzgSRLB29nKbq-UXw	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$0EmcDbHM6t0AJ7YKAcphqL8othdZg4dIXSazEHvnCno	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$0EmcDbHM6t0AJ7YKAcphqL8othdZg4dIXSazEHvnCno	$XYKCYavbY8FMdUIlSSoqP0likUnTP6uJ0yHoGQCMnWQ	!dKcbdDATuwwphjRPQP:localhost
$0EmcDbHM6t0AJ7YKAcphqL8othdZg4dIXSazEHvnCno	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$0EmcDbHM6t0AJ7YKAcphqL8othdZg4dIXSazEHvnCno	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$EklY0FV28pDgoXqwoQUjAB5wTv33O8RCHRE8k2k6o2c	$JtjXz-jm6mi5wU33MudkV8ZsCM2V-zduDqeI1xIG254	!kmbTYjjsDRDHGgVqUP:localhost
$EklY0FV28pDgoXqwoQUjAB5wTv33O8RCHRE8k2k6o2c	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$EklY0FV28pDgoXqwoQUjAB5wTv33O8RCHRE8k2k6o2c	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$ShuNV5AOx3oTjKr3eYjFKvzCZ374R_0vxs2HC21ht-g	$GcBRlllGdKFvT1pDzY7airMfjuYYNt06vxkQ0BnM6IM	!dKcbdDATuwwphjRPQP:localhost
$ShuNV5AOx3oTjKr3eYjFKvzCZ374R_0vxs2HC21ht-g	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$ShuNV5AOx3oTjKr3eYjFKvzCZ374R_0vxs2HC21ht-g	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$UTOQTSrmXya3IQYDcRPwNWN1bIv2zQ3YfbaVRy9NQuA	$0BYuX-7BWlMOYXwWp-y_txKwBBorVZzavW6fDuXxUrM	!kmbTYjjsDRDHGgVqUP:localhost
$UTOQTSrmXya3IQYDcRPwNWN1bIv2zQ3YfbaVRy9NQuA	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$UTOQTSrmXya3IQYDcRPwNWN1bIv2zQ3YfbaVRy9NQuA	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$IfK4xyQ_h94nUHneDilGoM0TTwuWFeP5_u_nlRs571U	$hWVSd4FzjwQq7FYDdhFSCgpisb3gxDJ2OAjCjYS6rkg	!dKcbdDATuwwphjRPQP:localhost
$IfK4xyQ_h94nUHneDilGoM0TTwuWFeP5_u_nlRs571U	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$IfK4xyQ_h94nUHneDilGoM0TTwuWFeP5_u_nlRs571U	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$sbDgkkxT05mw8xIVFWyOJtbW9nnehE06Wvxor1z8ms8	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$sbDgkkxT05mw8xIVFWyOJtbW9nnehE06Wvxor1z8ms8	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$sbDgkkxT05mw8xIVFWyOJtbW9nnehE06Wvxor1z8ms8	$zhfRuogjo-Vq5GM4-f6hyuXBGHx99o9_Nef1KWi2-EM	!kmbTYjjsDRDHGgVqUP:localhost
$aaPR9QI7az6NxeJ0hSrQxyKzzVyM-rBWODbN9y9rM9Q	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$aaPR9QI7az6NxeJ0hSrQxyKzzVyM-rBWODbN9y9rM9Q	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$aaPR9QI7az6NxeJ0hSrQxyKzzVyM-rBWODbN9y9rM9Q	$sY34u-PbOKSI3_z8SIqGfn_2XnO9wqZ_eU1dvGDnRJY	!dKcbdDATuwwphjRPQP:localhost
$TbzKCcECXvJAKvBu5GZCTLIGi7Js0b1w9dE6KKZXaKo	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$TbzKCcECXvJAKvBu5GZCTLIGi7Js0b1w9dE6KKZXaKo	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$TbzKCcECXvJAKvBu5GZCTLIGi7Js0b1w9dE6KKZXaKo	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$TbzKCcECXvJAKvBu5GZCTLIGi7Js0b1w9dE6KKZXaKo	$aaPR9QI7az6NxeJ0hSrQxyKzzVyM-rBWODbN9y9rM9Q	!dKcbdDATuwwphjRPQP:localhost
$XhzyXIYIbI0BfDV1QY4H3b4Wrpy5pJgJsGNZc8P8seg	$EklY0FV28pDgoXqwoQUjAB5wTv33O8RCHRE8k2k6o2c	!kmbTYjjsDRDHGgVqUP:localhost
$XhzyXIYIbI0BfDV1QY4H3b4Wrpy5pJgJsGNZc8P8seg	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$XhzyXIYIbI0BfDV1QY4H3b4Wrpy5pJgJsGNZc8P8seg	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$XhzyXIYIbI0BfDV1QY4H3b4Wrpy5pJgJsGNZc8P8seg	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$XhzyXIYIbI0BfDV1QY4H3b4Wrpy5pJgJsGNZc8P8seg	$2-SFwejONuAnI3cUJ4UN3FSzzJjeIWUURtWOJiO2sWo	!kmbTYjjsDRDHGgVqUP:localhost
$2-SFwejONuAnI3cUJ4UN3FSzzJjeIWUURtWOJiO2sWo	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$2-SFwejONuAnI3cUJ4UN3FSzzJjeIWUURtWOJiO2sWo	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$2-SFwejONuAnI3cUJ4UN3FSzzJjeIWUURtWOJiO2sWo	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$2-SFwejONuAnI3cUJ4UN3FSzzJjeIWUURtWOJiO2sWo	$sbDgkkxT05mw8xIVFWyOJtbW9nnehE06Wvxor1z8ms8	!kmbTYjjsDRDHGgVqUP:localhost
$sPW_-g3Oq09Bq8Rm-TKPTRO4HHOlMXEni0rE18Y01h4	$EB67Xwo9B0__CxNTvptFIy4e4vG93cmEcHRWbiVSFJU	!dKcbdDATuwwphjRPQP:localhost
$sPW_-g3Oq09Bq8Rm-TKPTRO4HHOlMXEni0rE18Y01h4	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$sPW_-g3Oq09Bq8Rm-TKPTRO4HHOlMXEni0rE18Y01h4	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$sPW_-g3Oq09Bq8Rm-TKPTRO4HHOlMXEni0rE18Y01h4	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$72MNMNMOJMJpfLbdNKdm6ZXGr14ukIKdq-fG2OvzOqg	$UTOQTSrmXya3IQYDcRPwNWN1bIv2zQ3YfbaVRy9NQuA	!kmbTYjjsDRDHGgVqUP:localhost
$72MNMNMOJMJpfLbdNKdm6ZXGr14ukIKdq-fG2OvzOqg	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$72MNMNMOJMJpfLbdNKdm6ZXGr14ukIKdq-fG2OvzOqg	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$72MNMNMOJMJpfLbdNKdm6ZXGr14ukIKdq-fG2OvzOqg	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$72MNMNMOJMJpfLbdNKdm6ZXGr14ukIKdq-fG2OvzOqg	$2-SFwejONuAnI3cUJ4UN3FSzzJjeIWUURtWOJiO2sWo	!kmbTYjjsDRDHGgVqUP:localhost
$LjACIs2QTEZTfukFRb30GQyevcb7EREdVFxoNEgvHSk	$ShuNV5AOx3oTjKr3eYjFKvzCZ374R_0vxs2HC21ht-g	!dKcbdDATuwwphjRPQP:localhost
$LjACIs2QTEZTfukFRb30GQyevcb7EREdVFxoNEgvHSk	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$LjACIs2QTEZTfukFRb30GQyevcb7EREdVFxoNEgvHSk	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$LjACIs2QTEZTfukFRb30GQyevcb7EREdVFxoNEgvHSk	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$LjACIs2QTEZTfukFRb30GQyevcb7EREdVFxoNEgvHSk	$TbzKCcECXvJAKvBu5GZCTLIGi7Js0b1w9dE6KKZXaKo	!dKcbdDATuwwphjRPQP:localhost
$jL60Q94H_SC7S4ZFOWkA4RilDwTMIUci2DyEXyQS_t0	$LjACIs2QTEZTfukFRb30GQyevcb7EREdVFxoNEgvHSk	!dKcbdDATuwwphjRPQP:localhost
$jL60Q94H_SC7S4ZFOWkA4RilDwTMIUci2DyEXyQS_t0	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$jL60Q94H_SC7S4ZFOWkA4RilDwTMIUci2DyEXyQS_t0	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$jL60Q94H_SC7S4ZFOWkA4RilDwTMIUci2DyEXyQS_t0	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$EB67Xwo9B0__CxNTvptFIy4e4vG93cmEcHRWbiVSFJU	$IfK4xyQ_h94nUHneDilGoM0TTwuWFeP5_u_nlRs571U	!dKcbdDATuwwphjRPQP:localhost
$EB67Xwo9B0__CxNTvptFIy4e4vG93cmEcHRWbiVSFJU	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$EB67Xwo9B0__CxNTvptFIy4e4vG93cmEcHRWbiVSFJU	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$EB67Xwo9B0__CxNTvptFIy4e4vG93cmEcHRWbiVSFJU	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$EB67Xwo9B0__CxNTvptFIy4e4vG93cmEcHRWbiVSFJU	$TbzKCcECXvJAKvBu5GZCTLIGi7Js0b1w9dE6KKZXaKo	!dKcbdDATuwwphjRPQP:localhost
$85g2ma_sFrYS8UbhpRwYEglJLj7xswd8VgNCg787_3E	$72MNMNMOJMJpfLbdNKdm6ZXGr14ukIKdq-fG2OvzOqg	!kmbTYjjsDRDHGgVqUP:localhost
$85g2ma_sFrYS8UbhpRwYEglJLj7xswd8VgNCg787_3E	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$85g2ma_sFrYS8UbhpRwYEglJLj7xswd8VgNCg787_3E	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$85g2ma_sFrYS8UbhpRwYEglJLj7xswd8VgNCg787_3E	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$WPbDUZRE7W6o_O4D0qf40PxoXNWcHrBwx3LxCA_ILaY	$XhzyXIYIbI0BfDV1QY4H3b4Wrpy5pJgJsGNZc8P8seg	!kmbTYjjsDRDHGgVqUP:localhost
$WPbDUZRE7W6o_O4D0qf40PxoXNWcHrBwx3LxCA_ILaY	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$WPbDUZRE7W6o_O4D0qf40PxoXNWcHrBwx3LxCA_ILaY	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$WPbDUZRE7W6o_O4D0qf40PxoXNWcHrBwx3LxCA_ILaY	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$BtKmdXlHyT65KPvPIiDSk38oldbOKOUbuv7J13Up4wE	$sPW_-g3Oq09Bq8Rm-TKPTRO4HHOlMXEni0rE18Y01h4	!dKcbdDATuwwphjRPQP:localhost
$BtKmdXlHyT65KPvPIiDSk38oldbOKOUbuv7J13Up4wE	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$BtKmdXlHyT65KPvPIiDSk38oldbOKOUbuv7J13Up4wE	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$HVWinlm6AKNeOld7iV_yqdfmpznmG5wAyWK5k3xjM7Y	$BtKmdXlHyT65KPvPIiDSk38oldbOKOUbuv7J13Up4wE	!dKcbdDATuwwphjRPQP:localhost
$HVWinlm6AKNeOld7iV_yqdfmpznmG5wAyWK5k3xjM7Y	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$HVWinlm6AKNeOld7iV_yqdfmpznmG5wAyWK5k3xjM7Y	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$HVWinlm6AKNeOld7iV_yqdfmpznmG5wAyWK5k3xjM7Y	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$HVWinlm6AKNeOld7iV_yqdfmpznmG5wAyWK5k3xjM7Y	$TbzKCcECXvJAKvBu5GZCTLIGi7Js0b1w9dE6KKZXaKo	!dKcbdDATuwwphjRPQP:localhost
$FNOekiMLFE4AEgQ1st7kiouCRAYO3DKEMbrYHGbH-zw	$HVWinlm6AKNeOld7iV_yqdfmpznmG5wAyWK5k3xjM7Y	!dKcbdDATuwwphjRPQP:localhost
$FNOekiMLFE4AEgQ1st7kiouCRAYO3DKEMbrYHGbH-zw	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$FNOekiMLFE4AEgQ1st7kiouCRAYO3DKEMbrYHGbH-zw	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$FNOekiMLFE4AEgQ1st7kiouCRAYO3DKEMbrYHGbH-zw	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$56oOQ2hizWAJWWKoJTMYGwAKX_gaANdZg2QHgtC63ZE	$0EmcDbHM6t0AJ7YKAcphqL8othdZg4dIXSazEHvnCno	!dKcbdDATuwwphjRPQP:localhost
$56oOQ2hizWAJWWKoJTMYGwAKX_gaANdZg2QHgtC63ZE	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$56oOQ2hizWAJWWKoJTMYGwAKX_gaANdZg2QHgtC63ZE	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$6Sy4DU04a_WCzalQkimJ_l9-eYsJ3kcn3Lat9w42L2I	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$6Sy4DU04a_WCzalQkimJ_l9-eYsJ3kcn3Lat9w42L2I	$56oOQ2hizWAJWWKoJTMYGwAKX_gaANdZg2QHgtC63ZE	!dKcbdDATuwwphjRPQP:localhost
$6Sy4DU04a_WCzalQkimJ_l9-eYsJ3kcn3Lat9w42L2I	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$6Sy4DU04a_WCzalQkimJ_l9-eYsJ3kcn3Lat9w42L2I	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$FC2J9PSIQLoF8YJo6zY2dP8Eo55L8CPgzVGN7iaofRo	$6Sy4DU04a_WCzalQkimJ_l9-eYsJ3kcn3Lat9w42L2I	!dKcbdDATuwwphjRPQP:localhost
$FC2J9PSIQLoF8YJo6zY2dP8Eo55L8CPgzVGN7iaofRo	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$FC2J9PSIQLoF8YJo6zY2dP8Eo55L8CPgzVGN7iaofRo	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$WcPnOWvRmgShLlAe8RxY4-_M71l0auS5ykpKdmUS0LU	$4KgY7ivi_pp1q2tjdk7IWENjs1kzgSRLB29nKbq-UXw	!kmbTYjjsDRDHGgVqUP:localhost
$WcPnOWvRmgShLlAe8RxY4-_M71l0auS5ykpKdmUS0LU	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$WcPnOWvRmgShLlAe8RxY4-_M71l0auS5ykpKdmUS0LU	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$-R5ZDLwPtIisO-W746dPRRrr1U6HjM8uhC78Zh95UUQ	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$-R5ZDLwPtIisO-W746dPRRrr1U6HjM8uhC78Zh95UUQ	$WcPnOWvRmgShLlAe8RxY4-_M71l0auS5ykpKdmUS0LU	!kmbTYjjsDRDHGgVqUP:localhost
$-R5ZDLwPtIisO-W746dPRRrr1U6HjM8uhC78Zh95UUQ	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$-R5ZDLwPtIisO-W746dPRRrr1U6HjM8uhC78Zh95UUQ	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E	$FC2J9PSIQLoF8YJo6zY2dP8Eo55L8CPgzVGN7iaofRo	!dKcbdDATuwwphjRPQP:localhost
$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$M2xNoGVeTRazjk5EjiA0u3mOkneK7za9KWYn2LMJFwA	$jL60Q94H_SC7S4ZFOWkA4RilDwTMIUci2DyEXyQS_t0	!dKcbdDATuwwphjRPQP:localhost
$M2xNoGVeTRazjk5EjiA0u3mOkneK7za9KWYn2LMJFwA	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$M2xNoGVeTRazjk5EjiA0u3mOkneK7za9KWYn2LMJFwA	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$19Wa_uoHXFwHicMPIWHRa1c8H1yIjgzKxpDzo89CTTE	$WPbDUZRE7W6o_O4D0qf40PxoXNWcHrBwx3LxCA_ILaY	!kmbTYjjsDRDHGgVqUP:localhost
$19Wa_uoHXFwHicMPIWHRa1c8H1yIjgzKxpDzo89CTTE	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$19Wa_uoHXFwHicMPIWHRa1c8H1yIjgzKxpDzo89CTTE	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$lDJnxY-YfTRyXQcBLRlbFT2_w4DXO4Pks75YGGa5M5o	$85g2ma_sFrYS8UbhpRwYEglJLj7xswd8VgNCg787_3E	!kmbTYjjsDRDHGgVqUP:localhost
$lDJnxY-YfTRyXQcBLRlbFT2_w4DXO4Pks75YGGa5M5o	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$lDJnxY-YfTRyXQcBLRlbFT2_w4DXO4Pks75YGGa5M5o	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$SLqtTg1DQZU0Y4ezk90kDHz7IxD9TXjhW4qQAoPUfTk	$FNOekiMLFE4AEgQ1st7kiouCRAYO3DKEMbrYHGbH-zw	!dKcbdDATuwwphjRPQP:localhost
$SLqtTg1DQZU0Y4ezk90kDHz7IxD9TXjhW4qQAoPUfTk	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$SLqtTg1DQZU0Y4ezk90kDHz7IxD9TXjhW4qQAoPUfTk	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$6ZYuUr8K6uh0D7tl9-HD___6hQH3lj8qU1liF0zAkmo	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$6ZYuUr8K6uh0D7tl9-HD___6hQH3lj8qU1liF0zAkmo	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$6ZYuUr8K6uh0D7tl9-HD___6hQH3lj8qU1liF0zAkmo	$2-SFwejONuAnI3cUJ4UN3FSzzJjeIWUURtWOJiO2sWo	!kmbTYjjsDRDHGgVqUP:localhost
$t_tUn4wROpupdwEmZnXWQ-mtnx68XnGjofi61K92cRY	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$t_tUn4wROpupdwEmZnXWQ-mtnx68XnGjofi61K92cRY	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$t_tUn4wROpupdwEmZnXWQ-mtnx68XnGjofi61K92cRY	$TbzKCcECXvJAKvBu5GZCTLIGi7Js0b1w9dE6KKZXaKo	!dKcbdDATuwwphjRPQP:localhost
$Qyk1jqM8wu6uOaEDEalSs_0hepeq6CnfZZRy1hQ4sd8	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$Qyk1jqM8wu6uOaEDEalSs_0hepeq6CnfZZRy1hQ4sd8	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$Qyk1jqM8wu6uOaEDEalSs_0hepeq6CnfZZRy1hQ4sd8	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$Qyk1jqM8wu6uOaEDEalSs_0hepeq6CnfZZRy1hQ4sd8	$6ZYuUr8K6uh0D7tl9-HD___6hQH3lj8qU1liF0zAkmo	!kmbTYjjsDRDHGgVqUP:localhost
$qgyz1sVriFBiepR7YLOpA_tcnRjhDX9q13fkeJa8i3U	$M2xNoGVeTRazjk5EjiA0u3mOkneK7za9KWYn2LMJFwA	!dKcbdDATuwwphjRPQP:localhost
$qgyz1sVriFBiepR7YLOpA_tcnRjhDX9q13fkeJa8i3U	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$qgyz1sVriFBiepR7YLOpA_tcnRjhDX9q13fkeJa8i3U	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$qgyz1sVriFBiepR7YLOpA_tcnRjhDX9q13fkeJa8i3U	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$qgyz1sVriFBiepR7YLOpA_tcnRjhDX9q13fkeJa8i3U	$JgtV2Jrt_3Cws_oeqEte6xeUnTbTSMu0pBPrEWD4WyM	!dKcbdDATuwwphjRPQP:localhost
$JgtV2Jrt_3Cws_oeqEte6xeUnTbTSMu0pBPrEWD4WyM	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$JgtV2Jrt_3Cws_oeqEte6xeUnTbTSMu0pBPrEWD4WyM	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$JgtV2Jrt_3Cws_oeqEte6xeUnTbTSMu0pBPrEWD4WyM	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$JgtV2Jrt_3Cws_oeqEte6xeUnTbTSMu0pBPrEWD4WyM	$t_tUn4wROpupdwEmZnXWQ-mtnx68XnGjofi61K92cRY	!dKcbdDATuwwphjRPQP:localhost
$ZLuzCoh1UZ9oNHYyBNCtneq81TelpJ882dsDdio0oKU	$lDJnxY-YfTRyXQcBLRlbFT2_w4DXO4Pks75YGGa5M5o	!kmbTYjjsDRDHGgVqUP:localhost
$ZLuzCoh1UZ9oNHYyBNCtneq81TelpJ882dsDdio0oKU	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$ZLuzCoh1UZ9oNHYyBNCtneq81TelpJ882dsDdio0oKU	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$ZLuzCoh1UZ9oNHYyBNCtneq81TelpJ882dsDdio0oKU	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$ZLuzCoh1UZ9oNHYyBNCtneq81TelpJ882dsDdio0oKU	$Qyk1jqM8wu6uOaEDEalSs_0hepeq6CnfZZRy1hQ4sd8	!kmbTYjjsDRDHGgVqUP:localhost
$Zv-9wNEnjnF-VeZtZKtHkYObGhccwLKewNnJg-fUiF8	$qgyz1sVriFBiepR7YLOpA_tcnRjhDX9q13fkeJa8i3U	!dKcbdDATuwwphjRPQP:localhost
$Zv-9wNEnjnF-VeZtZKtHkYObGhccwLKewNnJg-fUiF8	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$Zv-9wNEnjnF-VeZtZKtHkYObGhccwLKewNnJg-fUiF8	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$Zv-9wNEnjnF-VeZtZKtHkYObGhccwLKewNnJg-fUiF8	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$ggRHO4QwGg8SLwSXlSNnHypSBsgj2jFMUXbjC7U97qM	$SLqtTg1DQZU0Y4ezk90kDHz7IxD9TXjhW4qQAoPUfTk	!dKcbdDATuwwphjRPQP:localhost
$ggRHO4QwGg8SLwSXlSNnHypSBsgj2jFMUXbjC7U97qM	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$ggRHO4QwGg8SLwSXlSNnHypSBsgj2jFMUXbjC7U97qM	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$ggRHO4QwGg8SLwSXlSNnHypSBsgj2jFMUXbjC7U97qM	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$ggRHO4QwGg8SLwSXlSNnHypSBsgj2jFMUXbjC7U97qM	$JgtV2Jrt_3Cws_oeqEte6xeUnTbTSMu0pBPrEWD4WyM	!dKcbdDATuwwphjRPQP:localhost
$0ClPrn0jv_hdCQB4TqbWVPUxxSqFeDViCsOjYwQVDAg	$19Wa_uoHXFwHicMPIWHRa1c8H1yIjgzKxpDzo89CTTE	!kmbTYjjsDRDHGgVqUP:localhost
$0ClPrn0jv_hdCQB4TqbWVPUxxSqFeDViCsOjYwQVDAg	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$0ClPrn0jv_hdCQB4TqbWVPUxxSqFeDViCsOjYwQVDAg	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$0ClPrn0jv_hdCQB4TqbWVPUxxSqFeDViCsOjYwQVDAg	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$0ClPrn0jv_hdCQB4TqbWVPUxxSqFeDViCsOjYwQVDAg	$Qyk1jqM8wu6uOaEDEalSs_0hepeq6CnfZZRy1hQ4sd8	!kmbTYjjsDRDHGgVqUP:localhost
$aa2-bg9KcCtrn4nE5HK1JGC6sa8Gr7jWqLhPgLQTtsU	$ZLuzCoh1UZ9oNHYyBNCtneq81TelpJ882dsDdio0oKU	!kmbTYjjsDRDHGgVqUP:localhost
$aa2-bg9KcCtrn4nE5HK1JGC6sa8Gr7jWqLhPgLQTtsU	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$aa2-bg9KcCtrn4nE5HK1JGC6sa8Gr7jWqLhPgLQTtsU	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$aa2-bg9KcCtrn4nE5HK1JGC6sa8Gr7jWqLhPgLQTtsU	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$ewJTQJq2XdLvkqYVULlUmmJ-A3LQ6Jnqs4GDYi6q0DE	$ggRHO4QwGg8SLwSXlSNnHypSBsgj2jFMUXbjC7U97qM	!dKcbdDATuwwphjRPQP:localhost
$ewJTQJq2XdLvkqYVULlUmmJ-A3LQ6Jnqs4GDYi6q0DE	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$ewJTQJq2XdLvkqYVULlUmmJ-A3LQ6Jnqs4GDYi6q0DE	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$ewJTQJq2XdLvkqYVULlUmmJ-A3LQ6Jnqs4GDYi6q0DE	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo	$0ClPrn0jv_hdCQB4TqbWVPUxxSqFeDViCsOjYwQVDAg	!kmbTYjjsDRDHGgVqUP:localhost
$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
\.


--
-- Data for Name: event_auth_chain_links; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_auth_chain_links (origin_chain_id, origin_sequence_number, target_chain_id, target_sequence_number) FROM stdin;
12	1	16	1
4	1	2	1
12	1	14	1
9	1	14	1
9	1	3	1
13	1	2	1
12	1	18	1
8	1	10	1
4	1	15	1
4	1	17	1
15	1	2	1
14	1	16	1
2	1	10	1
9	1	16	1
13	1	15	1
5	1	3	1
9	1	18	1
17	1	10	1
4	1	10	1
7	1	3	1
13	1	17	1
6	1	2	1
6	1	15	1
13	1	10	1
1	1	14	1
1	1	3	1
7	1	14	1
7	1	16	1
18	1	14	1
16	1	3	1
15	1	10	1
8	1	2	1
7	1	18	1
11	1	2	1
11	1	10	1
6	1	17	1
11	1	15	1
1	1	16	1
18	1	3	1
6	1	10	1
18	1	16	1
8	1	15	1
17	1	2	1
12	1	3	1
17	1	15	1
5	1	14	1
14	1	3	1
5	1	16	1
19	1	3	1
19	1	16	1
19	1	14	1
19	1	18	1
20	1	17	1
20	1	15	1
20	1	10	1
20	1	2	1
21	1	18	1
21	1	14	1
21	1	16	1
21	1	19	1
21	1	3	1
22	1	15	1
22	1	10	1
22	1	2	1
22	1	17	1
22	1	20	1
23	1	14	1
23	1	19	1
23	1	3	1
23	1	16	1
23	1	18	1
24	1	17	1
24	1	2	1
24	1	20	1
24	1	15	1
24	1	10	1
23	4	19	3
22	4	20	3
21	7	19	3
24	4	20	3
24	7	20	5
23	7	19	5
22	7	20	5
21	13	19	5
23	10	19	7
24	10	20	7
21	19	19	7
22	10	20	7
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
$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	3	1
$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA	16	1
$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	14	1
$TVnvv0nGbLydCBtMmTTz-htMsoI4hmxCr3s9AHyFGHQ	5	1
$b__a7rX3L5YpX7nAZte73DAbjtXZK48JH8VKSnGOKKw	1	1
$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	18	1
$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0	12	1
$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A	9	1
$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	10	1
$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw	2	1
$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	15	1
$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	17	1
$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8	13	1
$O5iO4EII22igkDq5cMKHFB-SGIYD0KqJQXZohS2Dzc0	8	1
$X8tdoEsXAgBC6gobCepAn3rwO8CJoQU6i9NN9Rzhukg	11	1
$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	6	1
$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk	4	1
$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0	7	1
$oPNBx-eTHzyLXPzpYpdxdhLdVeGmx5lNmrECxIazfPQ	19	1
$3pZnE6ITQzzyNsuVCenuFBVRMocr892PiAvIbMGbMBM	20	1
$Oqb-EaDS-8U6U1Z6bTGSE7FJIlxKGhzMkNsnYIJY0Y0	21	1
$hJeKBcpebJzm9oiwjDCNTWPtbEcfp9GOLXl3yGkyaFU	22	1
$9cACT8rCcbUXbMhABzEciyF9pIIDRFNzaBkRVPH_0mk	23	1
$0gxNuNkWyOeHPtnNZ92FzvprItMgnH9hLCbYuY0Vzos	24	1
$9ArTh8Z2w2oc68FOD1X8Ka3DlK7lq00HaHKT_4DMSY4	21	2
$V_uchZ_8H2oh6EdsXqKsT6Ri62_YZtAAMfZi8pbBGrc	22	2
$Q4TOA6SPu2kQIrypB8QEJLHphxV5mHZ_eFwQux4jWSY	23	2
$YwLlyzcAMpJ69jsxTNglcWTbK8XHK8huc6aB6jpgEWk	24	2
$irHFClZVEAzlAtsjct-1MJjEotldPu1Ozkm_NYQrtqI	21	3
$QwAobZq6xey4D-6yOm_xg4h6rCKIRUpTqM4HBNroJwE	21	4
$3xEI-iU3Teo4B51pXGBbjKxM_DDvYlASNK7W09pHncM	21	5
$ETv-B1S-bU8wgS3S1fDdineVdS9YGNq1EMeUPHb6imQ	7	2
$GMh4hFLoeDc1Ssk9kdi7yAMIMSZA9zOJYJMC1AJEOKs	7	3
$zMfjO64yH55JKcwd-hMCa1P1ARHyAuvBbnPeUiNnS48	7	4
$5-KkKYPCr68IjD4sKk3rDF6kVYVkDMllW0BFUv7G4Do	13	2
$sPO_9Od1FvK55Z9_vb0hx3ophiGuLyATo1RKYIEFxHc	13	3
$oXLyUPbqiXmRRNovjt9_FJFQLCzMQjPsaism-trtsDw	7	5
$7EOMmT1sBVcDB2udDBhhf11Mok_GC9CY-6bxtIKAYpc	23	3
$-J2tr3j7vfmJ8ZSBAK5AyvQYmP2Byp-7dKfcBg5xHjU	22	3
$o0wI9-m-SdyS4UK7_m9_MUd0luWmj6eoXfMg1ieT00g	21	6
$wEwGnOPXUgG2_4DpqsPrYbSlIM2TnPjdWNDyVbZNE2Y	24	3
$oZEGsAxUrYn8R6NS359wZO9T54eXOD-N88ftDK7ZHGU	19	2
$LN4aYSSVw4GLaWf8g7uzrsw-fHTUyCBwq_-RRgS-MGE	20	2
$sY34u-PbOKSI3_z8SIqGfn_2XnO9wqZ_eU1dvGDnRJY	19	3
$zhfRuogjo-Vq5GM4-f6hyuXBGHx99o9_Nef1KWi2-EM	20	3
$3A5iUMUsDMAckTZ_lQ9ZLyQdw7FKGrqWfMMxwAZJCwc	23	4
$aUCd2uzLS80uiu1DeYrTDp1wAWs7M1ba_4Srm8LLnmU	22	4
$zogqtnD68sbYTleQBUL-RkGDpkNmTHar6ilm_2oVnRs	21	7
$OcjvTopfs1z8zuVgRxn4ynq9LH7z4eQhJnWG0PQ7150	24	4
$GcBRlllGdKFvT1pDzY7airMfjuYYNt06vxkQ0BnM6IM	23	5
$JtjXz-jm6mi5wU33MudkV8ZsCM2V-zduDqeI1xIG254	22	5
$6cga7PdI_98v2MEH6Wosfik3Plxt3Ml7GwsUkSFFa00	21	8
$0BYuX-7BWlMOYXwWp-y_txKwBBorVZzavW6fDuXxUrM	24	5
$OOCwtQCB-nmnnlgQ3ST3ItcIsITOLkC3b4a-WpaJjRg	21	9
$0ruVoUZRE1Edh-f7Z0QopPRTCr7L2kEpX8unxgxmfSQ	21	10
$hWVSd4FzjwQq7FYDdhFSCgpisb3gxDJ2OAjCjYS6rkg	21	11
$OJhJIVnJWjcgl3gc2AqLQK7sy1tKn075fy4E5qUK014	7	6
$nsJ2oe7ZtdBtY0V-sJWzGBBDi7tcgH24zUaAdmLjXy4	7	7
$XYKCYavbY8FMdUIlSSoqP0likUnTP6uJ0yHoGQCMnWQ	7	8
$fc-Paa3ZBQU-GAAxH4QWDNrWblQvQ4ddYVzPTPiYV6U	13	4
$4KgY7ivi_pp1q2tjdk7IWENjs1kzgSRLB29nKbq-UXw	13	5
$0EmcDbHM6t0AJ7YKAcphqL8othdZg4dIXSazEHvnCno	7	9
$EklY0FV28pDgoXqwoQUjAB5wTv33O8RCHRE8k2k6o2c	22	6
$ShuNV5AOx3oTjKr3eYjFKvzCZ374R_0vxs2HC21ht-g	23	6
$UTOQTSrmXya3IQYDcRPwNWN1bIv2zQ3YfbaVRy9NQuA	24	6
$IfK4xyQ_h94nUHneDilGoM0TTwuWFeP5_u_nlRs571U	21	12
$sbDgkkxT05mw8xIVFWyOJtbW9nnehE06Wvxor1z8ms8	20	4
$aaPR9QI7az6NxeJ0hSrQxyKzzVyM-rBWODbN9y9rM9Q	19	4
$TbzKCcECXvJAKvBu5GZCTLIGi7Js0b1w9dE6KKZXaKo	19	5
$2-SFwejONuAnI3cUJ4UN3FSzzJjeIWUURtWOJiO2sWo	20	5
$72MNMNMOJMJpfLbdNKdm6ZXGr14ukIKdq-fG2OvzOqg	24	7
$LjACIs2QTEZTfukFRb30GQyevcb7EREdVFxoNEgvHSk	23	7
$XhzyXIYIbI0BfDV1QY4H3b4Wrpy5pJgJsGNZc8P8seg	22	7
$EB67Xwo9B0__CxNTvptFIy4e4vG93cmEcHRWbiVSFJU	21	13
$85g2ma_sFrYS8UbhpRwYEglJLj7xswd8VgNCg787_3E	24	8
$jL60Q94H_SC7S4ZFOWkA4RilDwTMIUci2DyEXyQS_t0	23	8
$WPbDUZRE7W6o_O4D0qf40PxoXNWcHrBwx3LxCA_ILaY	22	8
$sPW_-g3Oq09Bq8Rm-TKPTRO4HHOlMXEni0rE18Y01h4	21	14
$BtKmdXlHyT65KPvPIiDSk38oldbOKOUbuv7J13Up4wE	21	15
$HVWinlm6AKNeOld7iV_yqdfmpznmG5wAyWK5k3xjM7Y	21	16
$FNOekiMLFE4AEgQ1st7kiouCRAYO3DKEMbrYHGbH-zw	21	17
$56oOQ2hizWAJWWKoJTMYGwAKX_gaANdZg2QHgtC63ZE	7	10
$6Sy4DU04a_WCzalQkimJ_l9-eYsJ3kcn3Lat9w42L2I	7	11
$FC2J9PSIQLoF8YJo6zY2dP8Eo55L8CPgzVGN7iaofRo	7	12
$WcPnOWvRmgShLlAe8RxY4-_M71l0auS5ykpKdmUS0LU	13	6
$-R5ZDLwPtIisO-W746dPRRrr1U6HjM8uhC78Zh95UUQ	13	7
$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E	7	13
$19Wa_uoHXFwHicMPIWHRa1c8H1yIjgzKxpDzo89CTTE	22	9
$M2xNoGVeTRazjk5EjiA0u3mOkneK7za9KWYn2LMJFwA	23	9
$ggRHO4QwGg8SLwSXlSNnHypSBsgj2jFMUXbjC7U97qM	21	19
$lDJnxY-YfTRyXQcBLRlbFT2_w4DXO4Pks75YGGa5M5o	24	9
$t_tUn4wROpupdwEmZnXWQ-mtnx68XnGjofi61K92cRY	19	6
$JgtV2Jrt_3Cws_oeqEte6xeUnTbTSMu0pBPrEWD4WyM	19	7
$SLqtTg1DQZU0Y4ezk90kDHz7IxD9TXjhW4qQAoPUfTk	21	18
$6ZYuUr8K6uh0D7tl9-HD___6hQH3lj8qU1liF0zAkmo	20	6
$Qyk1jqM8wu6uOaEDEalSs_0hepeq6CnfZZRy1hQ4sd8	20	7
$qgyz1sVriFBiepR7YLOpA_tcnRjhDX9q13fkeJa8i3U	23	10
$ZLuzCoh1UZ9oNHYyBNCtneq81TelpJ882dsDdio0oKU	24	10
$Zv-9wNEnjnF-VeZtZKtHkYObGhccwLKewNnJg-fUiF8	23	11
$0ClPrn0jv_hdCQB4TqbWVPUxxSqFeDViCsOjYwQVDAg	22	10
$aa2-bg9KcCtrn4nE5HK1JGC6sa8Gr7jWqLhPgLQTtsU	24	11
$ewJTQJq2XdLvkqYVULlUmmJ-A3LQ6Jnqs4GDYi6q0DE	21	20
$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo	22	11
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
$oPNBx-eTHzyLXPzpYpdxdhLdVeGmx5lNmrECxIazfPQ	$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A	!dKcbdDATuwwphjRPQP:localhost	f
$3pZnE6ITQzzyNsuVCenuFBVRMocr892PiAvIbMGbMBM	$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	!kmbTYjjsDRDHGgVqUP:localhost	f
$Oqb-EaDS-8U6U1Z6bTGSE7FJIlxKGhzMkNsnYIJY0Y0	$oPNBx-eTHzyLXPzpYpdxdhLdVeGmx5lNmrECxIazfPQ	!dKcbdDATuwwphjRPQP:localhost	f
$hJeKBcpebJzm9oiwjDCNTWPtbEcfp9GOLXl3yGkyaFU	$3pZnE6ITQzzyNsuVCenuFBVRMocr892PiAvIbMGbMBM	!kmbTYjjsDRDHGgVqUP:localhost	f
$9cACT8rCcbUXbMhABzEciyF9pIIDRFNzaBkRVPH_0mk	$Oqb-EaDS-8U6U1Z6bTGSE7FJIlxKGhzMkNsnYIJY0Y0	!dKcbdDATuwwphjRPQP:localhost	f
$0gxNuNkWyOeHPtnNZ92FzvprItMgnH9hLCbYuY0Vzos	$hJeKBcpebJzm9oiwjDCNTWPtbEcfp9GOLXl3yGkyaFU	!kmbTYjjsDRDHGgVqUP:localhost	f
$9ArTh8Z2w2oc68FOD1X8Ka3DlK7lq00HaHKT_4DMSY4	$9cACT8rCcbUXbMhABzEciyF9pIIDRFNzaBkRVPH_0mk	!dKcbdDATuwwphjRPQP:localhost	f
$V_uchZ_8H2oh6EdsXqKsT6Ri62_YZtAAMfZi8pbBGrc	$0gxNuNkWyOeHPtnNZ92FzvprItMgnH9hLCbYuY0Vzos	!kmbTYjjsDRDHGgVqUP:localhost	f
$Q4TOA6SPu2kQIrypB8QEJLHphxV5mHZ_eFwQux4jWSY	$9ArTh8Z2w2oc68FOD1X8Ka3DlK7lq00HaHKT_4DMSY4	!dKcbdDATuwwphjRPQP:localhost	f
$YwLlyzcAMpJ69jsxTNglcWTbK8XHK8huc6aB6jpgEWk	$V_uchZ_8H2oh6EdsXqKsT6Ri62_YZtAAMfZi8pbBGrc	!kmbTYjjsDRDHGgVqUP:localhost	f
$irHFClZVEAzlAtsjct-1MJjEotldPu1Ozkm_NYQrtqI	$Q4TOA6SPu2kQIrypB8QEJLHphxV5mHZ_eFwQux4jWSY	!dKcbdDATuwwphjRPQP:localhost	f
$QwAobZq6xey4D-6yOm_xg4h6rCKIRUpTqM4HBNroJwE	$irHFClZVEAzlAtsjct-1MJjEotldPu1Ozkm_NYQrtqI	!dKcbdDATuwwphjRPQP:localhost	f
$3xEI-iU3Teo4B51pXGBbjKxM_DDvYlASNK7W09pHncM	$QwAobZq6xey4D-6yOm_xg4h6rCKIRUpTqM4HBNroJwE	!dKcbdDATuwwphjRPQP:localhost	f
$ETv-B1S-bU8wgS3S1fDdineVdS9YGNq1EMeUPHb6imQ	$3xEI-iU3Teo4B51pXGBbjKxM_DDvYlASNK7W09pHncM	!dKcbdDATuwwphjRPQP:localhost	f
$GMh4hFLoeDc1Ssk9kdi7yAMIMSZA9zOJYJMC1AJEOKs	$ETv-B1S-bU8wgS3S1fDdineVdS9YGNq1EMeUPHb6imQ	!dKcbdDATuwwphjRPQP:localhost	f
$zMfjO64yH55JKcwd-hMCa1P1ARHyAuvBbnPeUiNnS48	$GMh4hFLoeDc1Ssk9kdi7yAMIMSZA9zOJYJMC1AJEOKs	!dKcbdDATuwwphjRPQP:localhost	f
$5-KkKYPCr68IjD4sKk3rDF6kVYVkDMllW0BFUv7G4Do	$YwLlyzcAMpJ69jsxTNglcWTbK8XHK8huc6aB6jpgEWk	!kmbTYjjsDRDHGgVqUP:localhost	f
$sPO_9Od1FvK55Z9_vb0hx3ophiGuLyATo1RKYIEFxHc	$5-KkKYPCr68IjD4sKk3rDF6kVYVkDMllW0BFUv7G4Do	!kmbTYjjsDRDHGgVqUP:localhost	f
$oXLyUPbqiXmRRNovjt9_FJFQLCzMQjPsaism-trtsDw	$zMfjO64yH55JKcwd-hMCa1P1ARHyAuvBbnPeUiNnS48	!dKcbdDATuwwphjRPQP:localhost	f
$7EOMmT1sBVcDB2udDBhhf11Mok_GC9CY-6bxtIKAYpc	$oXLyUPbqiXmRRNovjt9_FJFQLCzMQjPsaism-trtsDw	!dKcbdDATuwwphjRPQP:localhost	f
$-J2tr3j7vfmJ8ZSBAK5AyvQYmP2Byp-7dKfcBg5xHjU	$sPO_9Od1FvK55Z9_vb0hx3ophiGuLyATo1RKYIEFxHc	!kmbTYjjsDRDHGgVqUP:localhost	f
$o0wI9-m-SdyS4UK7_m9_MUd0luWmj6eoXfMg1ieT00g	$7EOMmT1sBVcDB2udDBhhf11Mok_GC9CY-6bxtIKAYpc	!dKcbdDATuwwphjRPQP:localhost	f
$wEwGnOPXUgG2_4DpqsPrYbSlIM2TnPjdWNDyVbZNE2Y	$-J2tr3j7vfmJ8ZSBAK5AyvQYmP2Byp-7dKfcBg5xHjU	!kmbTYjjsDRDHGgVqUP:localhost	f
$oZEGsAxUrYn8R6NS359wZO9T54eXOD-N88ftDK7ZHGU	$o0wI9-m-SdyS4UK7_m9_MUd0luWmj6eoXfMg1ieT00g	!dKcbdDATuwwphjRPQP:localhost	f
$LN4aYSSVw4GLaWf8g7uzrsw-fHTUyCBwq_-RRgS-MGE	$wEwGnOPXUgG2_4DpqsPrYbSlIM2TnPjdWNDyVbZNE2Y	!kmbTYjjsDRDHGgVqUP:localhost	f
$sY34u-PbOKSI3_z8SIqGfn_2XnO9wqZ_eU1dvGDnRJY	$oZEGsAxUrYn8R6NS359wZO9T54eXOD-N88ftDK7ZHGU	!dKcbdDATuwwphjRPQP:localhost	f
$zhfRuogjo-Vq5GM4-f6hyuXBGHx99o9_Nef1KWi2-EM	$LN4aYSSVw4GLaWf8g7uzrsw-fHTUyCBwq_-RRgS-MGE	!kmbTYjjsDRDHGgVqUP:localhost	f
$3A5iUMUsDMAckTZ_lQ9ZLyQdw7FKGrqWfMMxwAZJCwc	$sY34u-PbOKSI3_z8SIqGfn_2XnO9wqZ_eU1dvGDnRJY	!dKcbdDATuwwphjRPQP:localhost	f
$aUCd2uzLS80uiu1DeYrTDp1wAWs7M1ba_4Srm8LLnmU	$zhfRuogjo-Vq5GM4-f6hyuXBGHx99o9_Nef1KWi2-EM	!kmbTYjjsDRDHGgVqUP:localhost	f
$zogqtnD68sbYTleQBUL-RkGDpkNmTHar6ilm_2oVnRs	$3A5iUMUsDMAckTZ_lQ9ZLyQdw7FKGrqWfMMxwAZJCwc	!dKcbdDATuwwphjRPQP:localhost	f
$OcjvTopfs1z8zuVgRxn4ynq9LH7z4eQhJnWG0PQ7150	$aUCd2uzLS80uiu1DeYrTDp1wAWs7M1ba_4Srm8LLnmU	!kmbTYjjsDRDHGgVqUP:localhost	f
$GcBRlllGdKFvT1pDzY7airMfjuYYNt06vxkQ0BnM6IM	$zogqtnD68sbYTleQBUL-RkGDpkNmTHar6ilm_2oVnRs	!dKcbdDATuwwphjRPQP:localhost	f
$JtjXz-jm6mi5wU33MudkV8ZsCM2V-zduDqeI1xIG254	$OcjvTopfs1z8zuVgRxn4ynq9LH7z4eQhJnWG0PQ7150	!kmbTYjjsDRDHGgVqUP:localhost	f
$6cga7PdI_98v2MEH6Wosfik3Plxt3Ml7GwsUkSFFa00	$GcBRlllGdKFvT1pDzY7airMfjuYYNt06vxkQ0BnM6IM	!dKcbdDATuwwphjRPQP:localhost	f
$0BYuX-7BWlMOYXwWp-y_txKwBBorVZzavW6fDuXxUrM	$JtjXz-jm6mi5wU33MudkV8ZsCM2V-zduDqeI1xIG254	!kmbTYjjsDRDHGgVqUP:localhost	f
$OOCwtQCB-nmnnlgQ3ST3ItcIsITOLkC3b4a-WpaJjRg	$6cga7PdI_98v2MEH6Wosfik3Plxt3Ml7GwsUkSFFa00	!dKcbdDATuwwphjRPQP:localhost	f
$gnR3q3jOOEFI04MZ00yFbtQ5ZNs9EfZENfrrOEEj46s	$0BYuX-7BWlMOYXwWp-y_txKwBBorVZzavW6fDuXxUrM	!kmbTYjjsDRDHGgVqUP:localhost	f
$ZI6mQ9fcQaRUQRDK0WWxDErZcQGD7ahzFrk1b9nCFRE	$gnR3q3jOOEFI04MZ00yFbtQ5ZNs9EfZENfrrOEEj46s	!kmbTYjjsDRDHGgVqUP:localhost	f
$raYGvFCt-q8kxStPhO_tzxQ3pOmVeo5gn8lTV6sHBvs	$ZI6mQ9fcQaRUQRDK0WWxDErZcQGD7ahzFrk1b9nCFRE	!kmbTYjjsDRDHGgVqUP:localhost	f
$mfDu-vDNMkOg-psLHXlWcSXOnVkeuUPJfdm2cZ-3P-k	$raYGvFCt-q8kxStPhO_tzxQ3pOmVeo5gn8lTV6sHBvs	!kmbTYjjsDRDHGgVqUP:localhost	f
$iDgp052fBKJYL2KTsRdizUAlriA5itky5-e20aiZwHI	$mfDu-vDNMkOg-psLHXlWcSXOnVkeuUPJfdm2cZ-3P-k	!kmbTYjjsDRDHGgVqUP:localhost	f
$uwN8jjs4qWXT6fsX4o-36T96CWj17IDa_TJ3mF5Hd7M	$OOCwtQCB-nmnnlgQ3ST3ItcIsITOLkC3b4a-WpaJjRg	!dKcbdDATuwwphjRPQP:localhost	f
$mXxM94SwVR0FuKbH_riuFTeW0zH7Om62-HEudW_5y80	$uwN8jjs4qWXT6fsX4o-36T96CWj17IDa_TJ3mF5Hd7M	!dKcbdDATuwwphjRPQP:localhost	f
$OVhb59gyrKY7dsgLlfdIwe1H4O5zslN774jooAK4vec	$iDgp052fBKJYL2KTsRdizUAlriA5itky5-e20aiZwHI	!kmbTYjjsDRDHGgVqUP:localhost	f
$AxFCh7nvzu51kpXaQqyK3CKEqdyGhhJ0zhqT-c9LGPk	$mXxM94SwVR0FuKbH_riuFTeW0zH7Om62-HEudW_5y80	!dKcbdDATuwwphjRPQP:localhost	f
$0ruVoUZRE1Edh-f7Z0QopPRTCr7L2kEpX8unxgxmfSQ	$AxFCh7nvzu51kpXaQqyK3CKEqdyGhhJ0zhqT-c9LGPk	!dKcbdDATuwwphjRPQP:localhost	f
$hWVSd4FzjwQq7FYDdhFSCgpisb3gxDJ2OAjCjYS6rkg	$0ruVoUZRE1Edh-f7Z0QopPRTCr7L2kEpX8unxgxmfSQ	!dKcbdDATuwwphjRPQP:localhost	f
$OJhJIVnJWjcgl3gc2AqLQK7sy1tKn075fy4E5qUK014	$hWVSd4FzjwQq7FYDdhFSCgpisb3gxDJ2OAjCjYS6rkg	!dKcbdDATuwwphjRPQP:localhost	f
$nsJ2oe7ZtdBtY0V-sJWzGBBDi7tcgH24zUaAdmLjXy4	$OJhJIVnJWjcgl3gc2AqLQK7sy1tKn075fy4E5qUK014	!dKcbdDATuwwphjRPQP:localhost	f
$XYKCYavbY8FMdUIlSSoqP0likUnTP6uJ0yHoGQCMnWQ	$nsJ2oe7ZtdBtY0V-sJWzGBBDi7tcgH24zUaAdmLjXy4	!dKcbdDATuwwphjRPQP:localhost	f
$fc-Paa3ZBQU-GAAxH4QWDNrWblQvQ4ddYVzPTPiYV6U	$OVhb59gyrKY7dsgLlfdIwe1H4O5zslN774jooAK4vec	!kmbTYjjsDRDHGgVqUP:localhost	f
$4KgY7ivi_pp1q2tjdk7IWENjs1kzgSRLB29nKbq-UXw	$fc-Paa3ZBQU-GAAxH4QWDNrWblQvQ4ddYVzPTPiYV6U	!kmbTYjjsDRDHGgVqUP:localhost	f
$0EmcDbHM6t0AJ7YKAcphqL8othdZg4dIXSazEHvnCno	$XYKCYavbY8FMdUIlSSoqP0likUnTP6uJ0yHoGQCMnWQ	!dKcbdDATuwwphjRPQP:localhost	f
$EklY0FV28pDgoXqwoQUjAB5wTv33O8RCHRE8k2k6o2c	$4KgY7ivi_pp1q2tjdk7IWENjs1kzgSRLB29nKbq-UXw	!kmbTYjjsDRDHGgVqUP:localhost	f
$ShuNV5AOx3oTjKr3eYjFKvzCZ374R_0vxs2HC21ht-g	$0EmcDbHM6t0AJ7YKAcphqL8othdZg4dIXSazEHvnCno	!dKcbdDATuwwphjRPQP:localhost	f
$UTOQTSrmXya3IQYDcRPwNWN1bIv2zQ3YfbaVRy9NQuA	$EklY0FV28pDgoXqwoQUjAB5wTv33O8RCHRE8k2k6o2c	!kmbTYjjsDRDHGgVqUP:localhost	f
$IfK4xyQ_h94nUHneDilGoM0TTwuWFeP5_u_nlRs571U	$ShuNV5AOx3oTjKr3eYjFKvzCZ374R_0vxs2HC21ht-g	!dKcbdDATuwwphjRPQP:localhost	f
$sbDgkkxT05mw8xIVFWyOJtbW9nnehE06Wvxor1z8ms8	$UTOQTSrmXya3IQYDcRPwNWN1bIv2zQ3YfbaVRy9NQuA	!kmbTYjjsDRDHGgVqUP:localhost	f
$aaPR9QI7az6NxeJ0hSrQxyKzzVyM-rBWODbN9y9rM9Q	$IfK4xyQ_h94nUHneDilGoM0TTwuWFeP5_u_nlRs571U	!dKcbdDATuwwphjRPQP:localhost	f
$TbzKCcECXvJAKvBu5GZCTLIGi7Js0b1w9dE6KKZXaKo	$aaPR9QI7az6NxeJ0hSrQxyKzzVyM-rBWODbN9y9rM9Q	!dKcbdDATuwwphjRPQP:localhost	f
$2-SFwejONuAnI3cUJ4UN3FSzzJjeIWUURtWOJiO2sWo	$sbDgkkxT05mw8xIVFWyOJtbW9nnehE06Wvxor1z8ms8	!kmbTYjjsDRDHGgVqUP:localhost	f
$72MNMNMOJMJpfLbdNKdm6ZXGr14ukIKdq-fG2OvzOqg	$2-SFwejONuAnI3cUJ4UN3FSzzJjeIWUURtWOJiO2sWo	!kmbTYjjsDRDHGgVqUP:localhost	f
$LjACIs2QTEZTfukFRb30GQyevcb7EREdVFxoNEgvHSk	$TbzKCcECXvJAKvBu5GZCTLIGi7Js0b1w9dE6KKZXaKo	!dKcbdDATuwwphjRPQP:localhost	f
$XhzyXIYIbI0BfDV1QY4H3b4Wrpy5pJgJsGNZc8P8seg	$72MNMNMOJMJpfLbdNKdm6ZXGr14ukIKdq-fG2OvzOqg	!kmbTYjjsDRDHGgVqUP:localhost	f
$EB67Xwo9B0__CxNTvptFIy4e4vG93cmEcHRWbiVSFJU	$LjACIs2QTEZTfukFRb30GQyevcb7EREdVFxoNEgvHSk	!dKcbdDATuwwphjRPQP:localhost	f
$85g2ma_sFrYS8UbhpRwYEglJLj7xswd8VgNCg787_3E	$XhzyXIYIbI0BfDV1QY4H3b4Wrpy5pJgJsGNZc8P8seg	!kmbTYjjsDRDHGgVqUP:localhost	f
$jL60Q94H_SC7S4ZFOWkA4RilDwTMIUci2DyEXyQS_t0	$EB67Xwo9B0__CxNTvptFIy4e4vG93cmEcHRWbiVSFJU	!dKcbdDATuwwphjRPQP:localhost	f
$WPbDUZRE7W6o_O4D0qf40PxoXNWcHrBwx3LxCA_ILaY	$85g2ma_sFrYS8UbhpRwYEglJLj7xswd8VgNCg787_3E	!kmbTYjjsDRDHGgVqUP:localhost	f
$sPW_-g3Oq09Bq8Rm-TKPTRO4HHOlMXEni0rE18Y01h4	$jL60Q94H_SC7S4ZFOWkA4RilDwTMIUci2DyEXyQS_t0	!dKcbdDATuwwphjRPQP:localhost	f
$QjDo1bVrVGh33tmezjIVWxT6VXLutgIWlP9outS8Gcg	$WPbDUZRE7W6o_O4D0qf40PxoXNWcHrBwx3LxCA_ILaY	!kmbTYjjsDRDHGgVqUP:localhost	f
$j4OmrTBgGXlAg2ui751-jxTS4uMSPCzpj81xWRfOWiA	$QjDo1bVrVGh33tmezjIVWxT6VXLutgIWlP9outS8Gcg	!kmbTYjjsDRDHGgVqUP:localhost	f
$lQM-XkcgjA40yc1T7BNzbZ8V8yxcnsj23SxrixdEev8	$j4OmrTBgGXlAg2ui751-jxTS4uMSPCzpj81xWRfOWiA	!kmbTYjjsDRDHGgVqUP:localhost	f
$XikqApD6-vTeGUebJl-_Bc9ButeowpABz5W37dejAy0	$lQM-XkcgjA40yc1T7BNzbZ8V8yxcnsj23SxrixdEev8	!kmbTYjjsDRDHGgVqUP:localhost	f
$A5qbTNFuQ1MZL2fuT4oUFzi1xCHHDk0NuQZstoz4u-U	$sPW_-g3Oq09Bq8Rm-TKPTRO4HHOlMXEni0rE18Y01h4	!dKcbdDATuwwphjRPQP:localhost	f
$kMqJ62yuvBi4RWfOiLMiPcoSKbfcjZvTwwiuRRmfEKA	$A5qbTNFuQ1MZL2fuT4oUFzi1xCHHDk0NuQZstoz4u-U	!dKcbdDATuwwphjRPQP:localhost	f
$2xt0-DVGoBAEL-GIwj9HZfHBCQu7_M-HzB2XaEfxjwM	$kMqJ62yuvBi4RWfOiLMiPcoSKbfcjZvTwwiuRRmfEKA	!dKcbdDATuwwphjRPQP:localhost	f
$6CT_ZCazUgJysnWN-q2s4b5iR-x1EbXa932nBRpldW4	$XikqApD6-vTeGUebJl-_Bc9ButeowpABz5W37dejAy0	!kmbTYjjsDRDHGgVqUP:localhost	f
$UD0jEJtVKXhlCRf7VxHITWSUyhzaGkpH0VGbwilf2RE	$6CT_ZCazUgJysnWN-q2s4b5iR-x1EbXa932nBRpldW4	!kmbTYjjsDRDHGgVqUP:localhost	f
$BMnLymfijfp2V1tH1M6Nayfx-iF_rRw70COW60dCBG0	$UD0jEJtVKXhlCRf7VxHITWSUyhzaGkpH0VGbwilf2RE	!kmbTYjjsDRDHGgVqUP:localhost	f
$jhFoiytsqlLXRCkoL5gH2sXpQQJFwk3XLtzQPCpA0K8	$2xt0-DVGoBAEL-GIwj9HZfHBCQu7_M-HzB2XaEfxjwM	!dKcbdDATuwwphjRPQP:localhost	f
$UQr1C3BZK9MztXbBR2a0yz0wCyXSy_abmCstrHnXi2E	$jhFoiytsqlLXRCkoL5gH2sXpQQJFwk3XLtzQPCpA0K8	!dKcbdDATuwwphjRPQP:localhost	f
$wehc8FMA82xW0EU5F86ZkvsBra_SZ0JSA3Yweowv_s8	$UQr1C3BZK9MztXbBR2a0yz0wCyXSy_abmCstrHnXi2E	!dKcbdDATuwwphjRPQP:localhost	f
$p2y4ivsQApKJEQKZQ-5KFk47veZlq7V00tHHrokVqK0	$wehc8FMA82xW0EU5F86ZkvsBra_SZ0JSA3Yweowv_s8	!dKcbdDATuwwphjRPQP:localhost	f
$VzxEyd-riDbZr-sdhUSEcA4h_6kWYfmSeoqEtaZHFFo	$BMnLymfijfp2V1tH1M6Nayfx-iF_rRw70COW60dCBG0	!kmbTYjjsDRDHGgVqUP:localhost	f
$BtKmdXlHyT65KPvPIiDSk38oldbOKOUbuv7J13Up4wE	$p2y4ivsQApKJEQKZQ-5KFk47veZlq7V00tHHrokVqK0	!dKcbdDATuwwphjRPQP:localhost	f
$HVWinlm6AKNeOld7iV_yqdfmpznmG5wAyWK5k3xjM7Y	$BtKmdXlHyT65KPvPIiDSk38oldbOKOUbuv7J13Up4wE	!dKcbdDATuwwphjRPQP:localhost	f
$FNOekiMLFE4AEgQ1st7kiouCRAYO3DKEMbrYHGbH-zw	$HVWinlm6AKNeOld7iV_yqdfmpznmG5wAyWK5k3xjM7Y	!dKcbdDATuwwphjRPQP:localhost	f
$56oOQ2hizWAJWWKoJTMYGwAKX_gaANdZg2QHgtC63ZE	$FNOekiMLFE4AEgQ1st7kiouCRAYO3DKEMbrYHGbH-zw	!dKcbdDATuwwphjRPQP:localhost	f
$6Sy4DU04a_WCzalQkimJ_l9-eYsJ3kcn3Lat9w42L2I	$56oOQ2hizWAJWWKoJTMYGwAKX_gaANdZg2QHgtC63ZE	!dKcbdDATuwwphjRPQP:localhost	f
$FC2J9PSIQLoF8YJo6zY2dP8Eo55L8CPgzVGN7iaofRo	$6Sy4DU04a_WCzalQkimJ_l9-eYsJ3kcn3Lat9w42L2I	!dKcbdDATuwwphjRPQP:localhost	f
$WcPnOWvRmgShLlAe8RxY4-_M71l0auS5ykpKdmUS0LU	$VzxEyd-riDbZr-sdhUSEcA4h_6kWYfmSeoqEtaZHFFo	!kmbTYjjsDRDHGgVqUP:localhost	f
$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E	$FC2J9PSIQLoF8YJo6zY2dP8Eo55L8CPgzVGN7iaofRo	!dKcbdDATuwwphjRPQP:localhost	f
$ZLuzCoh1UZ9oNHYyBNCtneq81TelpJ882dsDdio0oKU	$Qyk1jqM8wu6uOaEDEalSs_0hepeq6CnfZZRy1hQ4sd8	!kmbTYjjsDRDHGgVqUP:localhost	f
$Zv-9wNEnjnF-VeZtZKtHkYObGhccwLKewNnJg-fUiF8	$ggRHO4QwGg8SLwSXlSNnHypSBsgj2jFMUXbjC7U97qM	!dKcbdDATuwwphjRPQP:localhost	f
$53rDO0S-X2QNPUyUVrTGx092yf0EW0nvJXQNLgQ09kc	$kkmwTP1mOPGymh7Q3_N1Y7ftC1xrv5qaHbV_zi99vD4	!dKcbdDATuwwphjRPQP:localhost	f
$-R5ZDLwPtIisO-W746dPRRrr1U6HjM8uhC78Zh95UUQ	$WcPnOWvRmgShLlAe8RxY4-_M71l0auS5ykpKdmUS0LU	!kmbTYjjsDRDHGgVqUP:localhost	f
$19Wa_uoHXFwHicMPIWHRa1c8H1yIjgzKxpDzo89CTTE	$-R5ZDLwPtIisO-W746dPRRrr1U6HjM8uhC78Zh95UUQ	!kmbTYjjsDRDHGgVqUP:localhost	f
$Qyk1jqM8wu6uOaEDEalSs_0hepeq6CnfZZRy1hQ4sd8	$6ZYuUr8K6uh0D7tl9-HD___6hQH3lj8qU1liF0zAkmo	!kmbTYjjsDRDHGgVqUP:localhost	f
$qgyz1sVriFBiepR7YLOpA_tcnRjhDX9q13fkeJa8i3U	$JgtV2Jrt_3Cws_oeqEte6xeUnTbTSMu0pBPrEWD4WyM	!dKcbdDATuwwphjRPQP:localhost	f
$j_Vf4RSpugcR52JQthWyGuqRIEdGrETb4ZLvnGxwwg0	$mjUbm6eO9Jk-i6bqdyRHFZy9L-lH5TOO27GYMQ87nhs	!kmbTYjjsDRDHGgVqUP:localhost	f
$iVV3o47Y40f29uNsCktD5R1VKbTF1y3nGq4KSKQ5YYo	$RuT3uWLcY4y4GhqYFFNXur6XuNwXipRRmx5rJFfM9ms	!dKcbdDATuwwphjRPQP:localhost	f
$M2xNoGVeTRazjk5EjiA0u3mOkneK7za9KWYn2LMJFwA	$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E	!dKcbdDATuwwphjRPQP:localhost	f
$ggRHO4QwGg8SLwSXlSNnHypSBsgj2jFMUXbjC7U97qM	$qgyz1sVriFBiepR7YLOpA_tcnRjhDX9q13fkeJa8i3U	!dKcbdDATuwwphjRPQP:localhost	f
$m8QuIxNBjngQA1UhDPZlw6nIvodE764mdmYG9oCKf94	$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo	!kmbTYjjsDRDHGgVqUP:localhost	f
$RuT3uWLcY4y4GhqYFFNXur6XuNwXipRRmx5rJFfM9ms	$ewJTQJq2XdLvkqYVULlUmmJ-A3LQ6Jnqs4GDYi6q0DE	!dKcbdDATuwwphjRPQP:localhost	f
$lDJnxY-YfTRyXQcBLRlbFT2_w4DXO4Pks75YGGa5M5o	$19Wa_uoHXFwHicMPIWHRa1c8H1yIjgzKxpDzo89CTTE	!kmbTYjjsDRDHGgVqUP:localhost	f
$t_tUn4wROpupdwEmZnXWQ-mtnx68XnGjofi61K92cRY	$SLqtTg1DQZU0Y4ezk90kDHz7IxD9TXjhW4qQAoPUfTk	!dKcbdDATuwwphjRPQP:localhost	f
$JgtV2Jrt_3Cws_oeqEte6xeUnTbTSMu0pBPrEWD4WyM	$t_tUn4wROpupdwEmZnXWQ-mtnx68XnGjofi61K92cRY	!dKcbdDATuwwphjRPQP:localhost	f
$SLqtTg1DQZU0Y4ezk90kDHz7IxD9TXjhW4qQAoPUfTk	$M2xNoGVeTRazjk5EjiA0u3mOkneK7za9KWYn2LMJFwA	!dKcbdDATuwwphjRPQP:localhost	f
$mjUbm6eO9Jk-i6bqdyRHFZy9L-lH5TOO27GYMQ87nhs	$m8QuIxNBjngQA1UhDPZlw6nIvodE764mdmYG9oCKf94	!kmbTYjjsDRDHGgVqUP:localhost	f
$6ZYuUr8K6uh0D7tl9-HD___6hQH3lj8qU1liF0zAkmo	$lDJnxY-YfTRyXQcBLRlbFT2_w4DXO4Pks75YGGa5M5o	!kmbTYjjsDRDHGgVqUP:localhost	f
$0ClPrn0jv_hdCQB4TqbWVPUxxSqFeDViCsOjYwQVDAg	$ZLuzCoh1UZ9oNHYyBNCtneq81TelpJ882dsDdio0oKU	!kmbTYjjsDRDHGgVqUP:localhost	f
$kkmwTP1mOPGymh7Q3_N1Y7ftC1xrv5qaHbV_zi99vD4	$iVV3o47Y40f29uNsCktD5R1VKbTF1y3nGq4KSKQ5YYo	!dKcbdDATuwwphjRPQP:localhost	f
$aa2-bg9KcCtrn4nE5HK1JGC6sa8Gr7jWqLhPgLQTtsU	$0ClPrn0jv_hdCQB4TqbWVPUxxSqFeDViCsOjYwQVDAg	!kmbTYjjsDRDHGgVqUP:localhost	f
$99PDED6qRD6JvJgyuUpKL5SGciNeDx4Q8aNU8-knIfI	$sD72WUGTkmqfbvA4mcCNx5IcT-WfbmjsGalYB6V6S-E	!kmbTYjjsDRDHGgVqUP:localhost	f
$ewJTQJq2XdLvkqYVULlUmmJ-A3LQ6Jnqs4GDYi6q0DE	$Zv-9wNEnjnF-VeZtZKtHkYObGhccwLKewNnJg-fUiF8	!dKcbdDATuwwphjRPQP:localhost	f
$kdWmWl1h_wHbp_4CZHM4AOF1I3SpjgbLYkYoFiWiazU	$j_Vf4RSpugcR52JQthWyGuqRIEdGrETb4ZLvnGxwwg0	!kmbTYjjsDRDHGgVqUP:localhost	f
$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo	$aa2-bg9KcCtrn4nE5HK1JGC6sa8Gr7jWqLhPgLQTtsU	!kmbTYjjsDRDHGgVqUP:localhost	f
$sD72WUGTkmqfbvA4mcCNx5IcT-WfbmjsGalYB6V6S-E	$kdWmWl1h_wHbp_4CZHM4AOF1I3SpjgbLYkYoFiWiazU	!kmbTYjjsDRDHGgVqUP:localhost	f
$OL5YFZuIzpeGWvQkJsWD5fA-_tqvM6MNM8aACLhDIKc	$99PDED6qRD6JvJgyuUpKL5SGciNeDx4Q8aNU8-knIfI	!kmbTYjjsDRDHGgVqUP:localhost	f
$WxOx5K9OBtSH4SKkxlQDUCVkiuA8mdui6eTN417KUig	$OL5YFZuIzpeGWvQkJsWD5fA-_tqvM6MNM8aACLhDIKc	!kmbTYjjsDRDHGgVqUP:localhost	f
$9eV_AyLXyN9dQJyo8nKzxH0MD2Pj26OD3m5hxM368ek	$WxOx5K9OBtSH4SKkxlQDUCVkiuA8mdui6eTN417KUig	!kmbTYjjsDRDHGgVqUP:localhost	f
$KAudDRl-ilYkXdKdFFwSH1rjB9FuDL3iaIcj9chsvuc	$53rDO0S-X2QNPUyUVrTGx092yf0EW0nvJXQNLgQ09kc	!dKcbdDATuwwphjRPQP:localhost	f
$NBW9KofbXfyJlflrssj5f0gU9-vix_ChkMTdCTutt6E	$KAudDRl-ilYkXdKdFFwSH1rjB9FuDL3iaIcj9chsvuc	!dKcbdDATuwwphjRPQP:localhost	f
$G4jqJ_vLOuComzEY5LKlWgJmqk76rEv2BaFnoUc32C4	$NBW9KofbXfyJlflrssj5f0gU9-vix_ChkMTdCTutt6E	!dKcbdDATuwwphjRPQP:localhost	f
$PmdsaAuptefoxepoi5dH3S5XZjMQnrw_IY8E3iiC0JI	$9eV_AyLXyN9dQJyo8nKzxH0MD2Pj26OD3m5hxM368ek	!kmbTYjjsDRDHGgVqUP:localhost	f
$LLxGQgsj2x835E7aJtEtKuPEzf1fHJTT_1b0cxZaynk	$PmdsaAuptefoxepoi5dH3S5XZjMQnrw_IY8E3iiC0JI	!kmbTYjjsDRDHGgVqUP:localhost	f
$xaKVxYK5Ka0brhbVcFdQdutgxYlZom-dUIRWmloBBms	$LLxGQgsj2x835E7aJtEtKuPEzf1fHJTT_1b0cxZaynk	!kmbTYjjsDRDHGgVqUP:localhost	f
$7IBjUUbkm6m5Y_DazT_SUW3_XBAwV0nvHP6nkPuBbV0	$G4jqJ_vLOuComzEY5LKlWgJmqk76rEv2BaFnoUc32C4	!dKcbdDATuwwphjRPQP:localhost	f
$iZZsHDRKa9MPh0wKPGoTIkR9_IN1gXmgYQ3CLA-oEsU	$7IBjUUbkm6m5Y_DazT_SUW3_XBAwV0nvHP6nkPuBbV0	!dKcbdDATuwwphjRPQP:localhost	f
$OxJtFsDfjfHJ57HdnctrwwYfeMAuGw-MFWayc0MqGW4	$iZZsHDRKa9MPh0wKPGoTIkR9_IN1gXmgYQ3CLA-oEsU	!dKcbdDATuwwphjRPQP:localhost	f
$OIgyn6WfwavdRqCIV587JtVG-UzMqFnY1_VC_N2O6ok	$OxJtFsDfjfHJ57HdnctrwwYfeMAuGw-MFWayc0MqGW4	!dKcbdDATuwwphjRPQP:localhost	f
$z-yABBMUu-RFJeiOLWwmWghP2O4vgO3Bts6c9FX-uG8	$xaKVxYK5Ka0brhbVcFdQdutgxYlZom-dUIRWmloBBms	!kmbTYjjsDRDHGgVqUP:localhost	f
$P2eP-7teBmGXcBM7DqUedLeBNdY5eaTasFqCr7GXY74	$z-yABBMUu-RFJeiOLWwmWghP2O4vgO3Bts6c9FX-uG8	!kmbTYjjsDRDHGgVqUP:localhost	f
$62DK_5Urc-R1gCm6T-D7rEFWp3Q47rECTaNApSOe0tg	$P2eP-7teBmGXcBM7DqUedLeBNdY5eaTasFqCr7GXY74	!kmbTYjjsDRDHGgVqUP:localhost	f
$reo6-sRCAReTplLLrWZiUXEMMfaufd1o-PclhKbhxXw	$62DK_5Urc-R1gCm6T-D7rEFWp3Q47rECTaNApSOe0tg	!kmbTYjjsDRDHGgVqUP:localhost	f
$LiUaGyMC-ZVhJFLD9EeZsUNlhdIzJ2J41q-tpdMYQ-g	$OIgyn6WfwavdRqCIV587JtVG-UzMqFnY1_VC_N2O6ok	!dKcbdDATuwwphjRPQP:localhost	f
$kGXjbDILpzPlAVquVm-0ro1Y2cAjvBSU3chLQmB-ZgI	$LiUaGyMC-ZVhJFLD9EeZsUNlhdIzJ2J41q-tpdMYQ-g	!dKcbdDATuwwphjRPQP:localhost	f
$iR6CRvH8xG5VgeMQIZFMBeaVeTjxgDtnqT7tv-PoCf8	$kGXjbDILpzPlAVquVm-0ro1Y2cAjvBSU3chLQmB-ZgI	!dKcbdDATuwwphjRPQP:localhost	f
$47BkoMnB5FT3PSdXLEy0rb4ZdbS1q9w82a669O4lBXg	$reo6-sRCAReTplLLrWZiUXEMMfaufd1o-PclhKbhxXw	!kmbTYjjsDRDHGgVqUP:localhost	f
$zI1CZE-pX4aF7RBiJiZqzqFZlxIfJRBpmSuBjEzHTCQ	$47BkoMnB5FT3PSdXLEy0rb4ZdbS1q9w82a669O4lBXg	!kmbTYjjsDRDHGgVqUP:localhost	f
$y7fmz8cz_zrBS0ZmRnthufiCH3PFkuCVz8YKzQaf81g	$zI1CZE-pX4aF7RBiJiZqzqFZlxIfJRBpmSuBjEzHTCQ	!kmbTYjjsDRDHGgVqUP:localhost	f
$mJ65YIJRPOxuW2mcyV5dt1MwIY7iWY76Fnj51047dZM	$iR6CRvH8xG5VgeMQIZFMBeaVeTjxgDtnqT7tv-PoCf8	!dKcbdDATuwwphjRPQP:localhost	f
$p7GJemyaMZGUqYX0guKHUqmObfwF2yChmhI7v1sn2nE	$mJ65YIJRPOxuW2mcyV5dt1MwIY7iWY76Fnj51047dZM	!dKcbdDATuwwphjRPQP:localhost	f
$Ky-_xzOrnEPuDm0WQev0E1urDcDHtvv8esKT3jQ6lFY	$p7GJemyaMZGUqYX0guKHUqmObfwF2yChmhI7v1sn2nE	!dKcbdDATuwwphjRPQP:localhost	f
$5Iq2ZU88BXgNKKqMGOu71dH7vsyaxwI-Fxg8ocEMI2E	$Ky-_xzOrnEPuDm0WQev0E1urDcDHtvv8esKT3jQ6lFY	!dKcbdDATuwwphjRPQP:localhost	f
$LHW3l0dgme8yNUY6xjIvP_Osal1_vZAuIfg7vCLzGKI	$y7fmz8cz_zrBS0ZmRnthufiCH3PFkuCVz8YKzQaf81g	!kmbTYjjsDRDHGgVqUP:localhost	f
$_XRh5iYtBtMSC8b9sq-Zq1kS1LqI6azDTXLEGQTiQSs	$LHW3l0dgme8yNUY6xjIvP_Osal1_vZAuIfg7vCLzGKI	!kmbTYjjsDRDHGgVqUP:localhost	f
$jgIb5yphKm1y65Shpo1bZF38fQ0ZqUjOopYEMjB2JS0	$_XRh5iYtBtMSC8b9sq-Zq1kS1LqI6azDTXLEGQTiQSs	!kmbTYjjsDRDHGgVqUP:localhost	f
$j96SJY0VtGl6Q_Fnj_jg3BifdW7s0-Vd8t57DrAeAX8	$jgIb5yphKm1y65Shpo1bZF38fQ0ZqUjOopYEMjB2JS0	!kmbTYjjsDRDHGgVqUP:localhost	f
$5-UBR4vNvgnHcUIuQA0gIHJmn4pOL-BNEZ33B-2Dmes	$5Iq2ZU88BXgNKKqMGOu71dH7vsyaxwI-Fxg8ocEMI2E	!dKcbdDATuwwphjRPQP:localhost	f
$8f7euYUQUOKVs1LECS5C0ny-iJc0LrEhKy5AjaE9VwM	$5-UBR4vNvgnHcUIuQA0gIHJmn4pOL-BNEZ33B-2Dmes	!dKcbdDATuwwphjRPQP:localhost	f
$n7rEuNOUTfPAb-nKtA8sQLtp0FZoDqOfMyqN9eKVULc	$8f7euYUQUOKVs1LECS5C0ny-iJc0LrEhKy5AjaE9VwM	!dKcbdDATuwwphjRPQP:localhost	f
$KdF0e2L1V2qamNtPDDdbE1nZ8xvaqEBCeH0VcCCosQ8	$j96SJY0VtGl6Q_Fnj_jg3BifdW7s0-Vd8t57DrAeAX8	!kmbTYjjsDRDHGgVqUP:localhost	f
$VGPWrlgPM0aSEOjGq1_ygJ2gwcjdfMl06P2yF-1EjMw	$KdF0e2L1V2qamNtPDDdbE1nZ8xvaqEBCeH0VcCCosQ8	!kmbTYjjsDRDHGgVqUP:localhost	f
$T-S0-0A2-tysbZGnQHyOgfmxVouK-Ise06pRgQbLLcg	$VGPWrlgPM0aSEOjGq1_ygJ2gwcjdfMl06P2yF-1EjMw	!kmbTYjjsDRDHGgVqUP:localhost	f
$jTQQwpTqOMCeKxagSFuov0Dg8yBrYJJogGNCxBE1qwk	$n7rEuNOUTfPAb-nKtA8sQLtp0FZoDqOfMyqN9eKVULc	!dKcbdDATuwwphjRPQP:localhost	f
$8Hjay0ed9n_Y3vv-Lhtc_-A0-5CvZe8YsPugJA7pwVg	$jTQQwpTqOMCeKxagSFuov0Dg8yBrYJJogGNCxBE1qwk	!dKcbdDATuwwphjRPQP:localhost	f
$NHchZjGDozZxBeE_hBCfcWNQSoGcpRSxMwGAV4CVzWU	$8Hjay0ed9n_Y3vv-Lhtc_-A0-5CvZe8YsPugJA7pwVg	!dKcbdDATuwwphjRPQP:localhost	f
$5G3tHkgsc39AkOi94e7gxCeKaPhkmyOOAZlGWI8YaCQ	$NHchZjGDozZxBeE_hBCfcWNQSoGcpRSxMwGAV4CVzWU	!dKcbdDATuwwphjRPQP:localhost	f
$c-G9o6jTgFkz_rB_zESYfRkHoFMmTM5uCDXF1JAermc	$T-S0-0A2-tysbZGnQHyOgfmxVouK-Ise06pRgQbLLcg	!kmbTYjjsDRDHGgVqUP:localhost	f
$eY9D8MVKC5bDdinpPVI9ooLWvoYHx0tLFn-vRWkp9nk	$c-G9o6jTgFkz_rB_zESYfRkHoFMmTM5uCDXF1JAermc	!kmbTYjjsDRDHGgVqUP:localhost	f
$AAj21zp54kdoP3h1Zql3vB7JlPNE4Y9HrXrzBQPQrTA	$eY9D8MVKC5bDdinpPVI9ooLWvoYHx0tLFn-vRWkp9nk	!kmbTYjjsDRDHGgVqUP:localhost	f
$VZnQHRUET5azOmfmvUZMF1_eEKzi1_WkVHB0pxMELxo	$AAj21zp54kdoP3h1Zql3vB7JlPNE4Y9HrXrzBQPQrTA	!kmbTYjjsDRDHGgVqUP:localhost	f
$7q-JkspgsFYptPnMJ25LHdffz-rXLRDHzidSYCV3Kc8	$5G3tHkgsc39AkOi94e7gxCeKaPhkmyOOAZlGWI8YaCQ	!dKcbdDATuwwphjRPQP:localhost	f
$dtGyXiOFORXfCA1yAgiPJbV5UKJjEo-zfetInljHoV0	$7q-JkspgsFYptPnMJ25LHdffz-rXLRDHzidSYCV3Kc8	!dKcbdDATuwwphjRPQP:localhost	f
$dxD8VRi5x30Gu7BMEOui-JOrXZEL9meU6Q8aZra1b6U	$dtGyXiOFORXfCA1yAgiPJbV5UKJjEo-zfetInljHoV0	!dKcbdDATuwwphjRPQP:localhost	f
$bXKGeqgVWpdObwAv0HPtsV7_MNqo8HhD_whsZ1gxx54	$VZnQHRUET5azOmfmvUZMF1_eEKzi1_WkVHB0pxMELxo	!kmbTYjjsDRDHGgVqUP:localhost	f
$LOcz4Bm15D4BsyuDXygSGL-0AvIjwSLYy4cezgebQK8	$bXKGeqgVWpdObwAv0HPtsV7_MNqo8HhD_whsZ1gxx54	!kmbTYjjsDRDHGgVqUP:localhost	f
$RJSqE0ZymidM-ZtkpYLdrShv6_yNohaw5QtWzVooGsk	$LOcz4Bm15D4BsyuDXygSGL-0AvIjwSLYy4cezgebQK8	!kmbTYjjsDRDHGgVqUP:localhost	f
$EdC99i51IXAQXh-JndOybB0EFIdpgm02s0Z6Takw4Jw	$dxD8VRi5x30Gu7BMEOui-JOrXZEL9meU6Q8aZra1b6U	!dKcbdDATuwwphjRPQP:localhost	f
$pp-1vh-obnf3bLKs4cnpwy9dbINdz1MGiUDLrdenfek	$EdC99i51IXAQXh-JndOybB0EFIdpgm02s0Z6Takw4Jw	!dKcbdDATuwwphjRPQP:localhost	f
$AbcQJxS0qvSibn6R_hm5OSrLKkHjrpsW8oo97om40r8	$RJSqE0ZymidM-ZtkpYLdrShv6_yNohaw5QtWzVooGsk	!kmbTYjjsDRDHGgVqUP:localhost	f
$xKmd10QHFv5EgHAyd9HpWHkEi2QTI9MhKVlqpVntWM8	$pp-1vh-obnf3bLKs4cnpwy9dbINdz1MGiUDLrdenfek	!dKcbdDATuwwphjRPQP:localhost	f
$gLYRtP_fFTIbdUQ6jtldLcUG60gMNlghw7x9t2_PurE	$xKmd10QHFv5EgHAyd9HpWHkEi2QTI9MhKVlqpVntWM8	!dKcbdDATuwwphjRPQP:localhost	f
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
$gLYRtP_fFTIbdUQ6jtldLcUG60gMNlghw7x9t2_PurE	!dKcbdDATuwwphjRPQP:localhost
$AbcQJxS0qvSibn6R_hm5OSrLKkHjrpsW8oo97om40r8	!kmbTYjjsDRDHGgVqUP:localhost
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
$sbDgkkxT05mw8xIVFWyOJtbW9nnehE06Wvxor1z8ms8	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$zhfRuogjo-Vq5GM4-f6hyuXBGHx99o9_Nef1KWi2-EM"],"prev_events":["$UTOQTSrmXya3IQYDcRPwNWN1bIv2zQ3YfbaVRy9NQuA"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"leave"},"depth":35,"prev_state":[],"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1672308591372,"hashes":{"sha256":"atPF49EudlDLhdR0TFR1aS39o1Z5Ao5ipq/nCljAsX8"},"signatures":{"localhost":{"ed25519:a_CHdg":"XEqE4zSD/sHU61+i81xiGoEJrUZ7U/HnvDoyf2RwM/XTPBRsbcli8P5jljCNgbnkrYMXNqf1jYHUKvK35lViBA"}},"unsigned":{"age_ts":1672308591372,"replaces_state":"$zhfRuogjo-Vq5GM4-f6hyuXBGHx99o9_Nef1KWi2-EM"}}	3
$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id": 5, "stream_ordering": 18}	{"auth_events": ["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w", "$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o", "$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"], "prev_events": ["$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk"], "type": "m.room.member", "room_id": "!kmbTYjjsDRDHGgVqUP:localhost", "sender": "@ignored_user:localhost", "content": {"membership": "join", "displayname": "ignored_user"}, "depth": 9, "prev_state": [], "state_key": "@ignored_user:localhost", "origin": "localhost", "origin_server_ts": 1598686328575, "hashes": {"sha256": "D/rwxkYqWZ03Kws7Xsq84khdp4oGHRGnOy4+XwM8dLA"}, "signatures": {"localhost": {"ed25519:a_snHR": "kXK8xKjLjJ97KcFQivelEBI1TR/au+bgtD6i2VPDp9LjRi1bVH/zb6YqHZetT0JYaGt3NY4iFeN0Qh0mD4zyAg"}}, "unsigned": {"age_ts": 1598686328575}}	3
$oPNBx-eTHzyLXPzpYpdxdhLdVeGmx5lNmrECxIazfPQ	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"depth":10,"prev_state":[],"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1672241417787,"hashes":{"sha256":"EvDr1CyOyKw90TUs9rQBCAiHLG1CRHF6yTx3CtW2Rnk"},"signatures":{"localhost":{"ed25519:a_CHdg":"OUHUrd6TqFp1F65q8bEJdp3aVzbz5+7UKqBD5kBgjb8dLULjE7erw6inKk8znE7PCXXy1DUIWiNMqA1Cghb0AA"}},"unsigned":{"age_ts":1672241417787}}	3
$3pZnE6ITQzzyNsuVCenuFBVRMocr892PiAvIbMGbMBM	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"depth":10,"prev_state":[],"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1672241417777,"hashes":{"sha256":"H6qHGkOnakv1LSrMbu4jfOy20b+Na7pTPhLbcOMgMRE"},"signatures":{"localhost":{"ed25519:a_CHdg":"G+ry6uGG5Sez8K43DPmOgj9tHcMj6WTKyYoq+afTTvU5uk87UMReZBxkgJCbBx8PJ68mGoXP8sIpPwkziUrxBA"}},"unsigned":{"age_ts":1672241417777}}	3
$Oqb-EaDS-8U6U1Z6bTGSE7FJIlxKGhzMkNsnYIJY0Y0	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$oPNBx-eTHzyLXPzpYpdxdhLdVeGmx5lNmrECxIazfPQ"],"prev_events":["$oPNBx-eTHzyLXPzpYpdxdhLdVeGmx5lNmrECxIazfPQ"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"MattermostUser A [mm]"},"depth":11,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672241421316,"hashes":{"sha256":"shoUz69bHLzLo2CPU12cv1g0zGvCBX9X5aOt5u6bbf8"},"signatures":{"localhost":{"ed25519:a_CHdg":"4ugf5dbyASoRhlCAzN1J1h0N+i84zC9gykbDe4RZwaHRkDepctVwdyp7xW75cAlCD/4LlKgrcUzIYyCp5emYCw"}},"unsigned":{"age_ts":1672241421316,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#off-topic:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$hJeKBcpebJzm9oiwjDCNTWPtbEcfp9GOLXl3yGkyaFU	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$3pZnE6ITQzzyNsuVCenuFBVRMocr892PiAvIbMGbMBM"],"prev_events":["$3pZnE6ITQzzyNsuVCenuFBVRMocr892PiAvIbMGbMBM"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"MattermostUser A [mm]"},"depth":11,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672241421505,"hashes":{"sha256":"RTmcubKhRDnO2uenscC7+lJNRqBKhsmNwncyvV/shcg"},"signatures":{"localhost":{"ed25519:a_CHdg":"s+72NW2B/Vq9nJtjG08yVGNq4z/VFc+K1SjXgnTmx9FVPKBqvDSs4zZU95/H9QN8Yi7rZF1Nvr4g9vAulaz5Dw"}},"unsigned":{"age_ts":1672241421505,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#town-square:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$9cACT8rCcbUXbMhABzEciyF9pIIDRFNzaBkRVPH_0mk	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$oPNBx-eTHzyLXPzpYpdxdhLdVeGmx5lNmrECxIazfPQ"],"prev_events":["$Oqb-EaDS-8U6U1Z6bTGSE7FJIlxKGhzMkNsnYIJY0Y0"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"mattermost_b [mm]"},"depth":12,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672241421587,"hashes":{"sha256":"YgwLAyJ25LfwATiq2nT+QWRvaQ4VJnEKqUHtn5mkj/s"},"signatures":{"localhost":{"ed25519:a_CHdg":"++Fln+jxxMdfjG0bbkvQIoIEZclUKe8jOhQ2HgejjDgxGdKKphqqMd9mEjKhYWm0JAINoHetF36pMDxB3E/TDQ"}},"unsigned":{"age_ts":1672241421587,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#off-topic:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$V_uchZ_8H2oh6EdsXqKsT6Ri62_YZtAAMfZi8pbBGrc	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$hJeKBcpebJzm9oiwjDCNTWPtbEcfp9GOLXl3yGkyaFU","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$0gxNuNkWyOeHPtnNZ92FzvprItMgnH9hLCbYuY0Vzos"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"membership":"join","displayname":"MattermostUser A [mm]"},"depth":13,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672241421941,"hashes":{"sha256":"MzT+3M1SixS5Qn1+IOlSod8JZ8eaydXkm9Cm7AN6nv0"},"signatures":{"localhost":{"ed25519:a_CHdg":"3FLtocrbxfAhwAs64LsE/Q0SgU2eKCpCd6M9JF506jNZbxEiSayVrkdRrIdXs7K5GWs0sOqgV4SwlLRc43/NDQ"}},"unsigned":{"age_ts":1672241421941,"replaces_state":"$hJeKBcpebJzm9oiwjDCNTWPtbEcfp9GOLXl3yGkyaFU"}}	3
$0gxNuNkWyOeHPtnNZ92FzvprItMgnH9hLCbYuY0Vzos	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$3pZnE6ITQzzyNsuVCenuFBVRMocr892PiAvIbMGbMBM"],"prev_events":["$hJeKBcpebJzm9oiwjDCNTWPtbEcfp9GOLXl3yGkyaFU"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"mattermost_b [mm]"},"depth":12,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672241421719,"hashes":{"sha256":"ena8c7Z7X7KZ/CRMtd2gGA6l1hmj6q1Q7muLNo+QB2w"},"signatures":{"localhost":{"ed25519:a_CHdg":"xB1X6yXdEuQpIz8USuSNgtUhJVXXoVME2LseAMniEC0cEET0Q9LAUfN9dUoWGC4AWXKTnd2cDxOu0ITsgD+/AQ"}},"unsigned":{"age_ts":1672241421719,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#town-square:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$9ArTh8Z2w2oc68FOD1X8Ka3DlK7lq00HaHKT_4DMSY4	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$Oqb-EaDS-8U6U1Z6bTGSE7FJIlxKGhzMkNsnYIJY0Y0","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$9cACT8rCcbUXbMhABzEciyF9pIIDRFNzaBkRVPH_0mk"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_a:localhost","content":{"membership":"join","displayname":"MattermostUser A [mm]"},"depth":13,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672241421811,"hashes":{"sha256":"c7Q8BqlWGjRkwuEgMoB8psu0yxvaRIcbb5hYANaWbvc"},"signatures":{"localhost":{"ed25519:a_CHdg":"5W804hKVMSzSfPKKp1n/v0fMlctLw5uNRqrDzCVv0gWiyWu9aIZLUcPmNkZ9NRVQ0HX/L+pd7icaqJVbIlXBAQ"}},"unsigned":{"age_ts":1672241421811,"replaces_state":"$Oqb-EaDS-8U6U1Z6bTGSE7FJIlxKGhzMkNsnYIJY0Y0"}}	3
$Q4TOA6SPu2kQIrypB8QEJLHphxV5mHZ_eFwQux4jWSY	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$9cACT8rCcbUXbMhABzEciyF9pIIDRFNzaBkRVPH_0mk","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$9ArTh8Z2w2oc68FOD1X8Ka3DlK7lq00HaHKT_4DMSY4"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_b:localhost","content":{"membership":"join","displayname":"mattermost_b [mm]"},"depth":14,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672241422029,"hashes":{"sha256":"T6x+5QrbpYoRtDk2SDpJeGKxsX6YpdJ3HCQF7a3Mj9A"},"signatures":{"localhost":{"ed25519:a_CHdg":"+NQMQp/7PM2i2W2bt96lIbwuV/QcEiYY/c4dxpT169AWpD7gAxAd9VAe9Xaepq1KVgY/00cd4MVpM+Ul6S4HAg"}},"unsigned":{"age_ts":1672241422029,"replaces_state":"$9cACT8rCcbUXbMhABzEciyF9pIIDRFNzaBkRVPH_0mk"}}	3
$YwLlyzcAMpJ69jsxTNglcWTbK8XHK8huc6aB6jpgEWk	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$0gxNuNkWyOeHPtnNZ92FzvprItMgnH9hLCbYuY0Vzos","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$V_uchZ_8H2oh6EdsXqKsT6Ri62_YZtAAMfZi8pbBGrc"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_b:localhost","content":{"membership":"join","displayname":"mattermost_b [mm]"},"depth":14,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672241422141,"hashes":{"sha256":"Ib5zDyRLE2QGb9zd0csft2Ld5UWm44zszAlx9gm/Nn0"},"signatures":{"localhost":{"ed25519:a_CHdg":"/dkBh0jtP/lXjLYMszqXKyVuW9FceaS3AgkYeosd0U7BYmieMaHYr/YTHWKvCYlaMzOwATtvSBmJQ8TgfTwODQ"}},"unsigned":{"age_ts":1672241422141,"replaces_state":"$0gxNuNkWyOeHPtnNZ92FzvprItMgnH9hLCbYuY0Vzos"}}	3
$5-KkKYPCr68IjD4sKk3rDF6kVYVkDMllW0BFUv7G4Do	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":3,"historical":false}	{"auth_events":["$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$YwLlyzcAMpJ69jsxTNglcWTbK8XHK8huc6aB6jpgEWk"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_a:localhost","content":{"membership":"leave"},"depth":15,"prev_state":[],"state_key":"@matrix_a:localhost","origin":"localhost","origin_server_ts":1672249107449,"hashes":{"sha256":"6tZm+Dlv4tToAGnGx7GnTA62HXse28dqis5FzHx29oY"},"signatures":{"localhost":{"ed25519:a_CHdg":"D4j8vpftiUK2THqVN9ptXxlu32H6+D4DfrKsSL1p8zRU0VeIyvo+PLYMNQhoxxSCzvoph/g64bP29Sffr8t6CA"}},"unsigned":{"age_ts":1672249107449,"replaces_state":"$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8"}}	3
$7EOMmT1sBVcDB2udDBhhf11Mok_GC9CY-6bxtIKAYpc	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$Q4TOA6SPu2kQIrypB8QEJLHphxV5mHZ_eFwQux4jWSY","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$oXLyUPbqiXmRRNovjt9_FJFQLCzMQjPsaism-trtsDw"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_b:localhost","content":{"membership":"leave"},"depth":22,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672249109607,"hashes":{"sha256":"vglFQBJ/9FvYI9iURsoGSusJThQxzLNWAB8gDEtXz+E"},"signatures":{"localhost":{"ed25519:a_CHdg":"RQ371YO+KXH3XRBNyB9IDJtoaADacPjJ4PBcI4yK645Nr8ksclDvorzkcOTmG15JK3qqV4aG+YSITxoglgcDDA"}},"unsigned":{"age_ts":1672249109607,"replaces_state":"$Q4TOA6SPu2kQIrypB8QEJLHphxV5mHZ_eFwQux4jWSY"}}	3
$o0wI9-m-SdyS4UK7_m9_MUd0luWmj6eoXfMg1ieT00g	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$3xEI-iU3Teo4B51pXGBbjKxM_DDvYlASNK7W09pHncM","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$7EOMmT1sBVcDB2udDBhhf11Mok_GC9CY-6bxtIKAYpc"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_a:localhost","content":{"membership":"leave"},"depth":23,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672249109920,"hashes":{"sha256":"hE4c4INOh+uvhVFhgRWU6eDicc57tbFTXwtqAxrvoKw"},"signatures":{"localhost":{"ed25519:a_CHdg":"/hJZsueCQ5F5k+6oIOeH1/SGZSu18+9UFCrdpCkt1u4rLAcFm3b1r36e610vD4gw9kz3Fzkx4tbYTS4+Id+zAQ"}},"unsigned":{"age_ts":1672249109920,"replaces_state":"$3xEI-iU3Teo4B51pXGBbjKxM_DDvYlASNK7W09pHncM"}}	3
$oZEGsAxUrYn8R6NS359wZO9T54eXOD-N88ftDK7ZHGU	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$oPNBx-eTHzyLXPzpYpdxdhLdVeGmx5lNmrECxIazfPQ"],"prev_events":["$o0wI9-m-SdyS4UK7_m9_MUd0luWmj6eoXfMg1ieT00g"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"leave"},"depth":24,"prev_state":[],"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1672249110239,"hashes":{"sha256":"x+JDYFazA5HcUCk1N+RaL6ikY6L4kbdZ909UbXGgnEE"},"signatures":{"localhost":{"ed25519:a_CHdg":"s3cx/Trd1r1/o8IQvXqd4QK61v2F7n+rWHBOnemgIvg0CfYMzBcCC6K7tS4J/n4Ja2/g3JfEWXdxwZcICnEmAA"}},"unsigned":{"age_ts":1672249110239,"replaces_state":"$oPNBx-eTHzyLXPzpYpdxdhLdVeGmx5lNmrECxIazfPQ"}}	3
$irHFClZVEAzlAtsjct-1MJjEotldPu1Ozkm_NYQrtqI	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$9ArTh8Z2w2oc68FOD1X8Ka3DlK7lq00HaHKT_4DMSY4","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$Q4TOA6SPu2kQIrypB8QEJLHphxV5mHZ_eFwQux4jWSY"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_a:localhost","content":{"membership":"leave"},"depth":15,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672248712153,"hashes":{"sha256":"AO49ohGTq0nzy6Mlr6OzmdXCKC6pklkSAvFY+v9FH5s"},"signatures":{"localhost":{"ed25519:a_CHdg":"PB3PwPHhWN5TCBhltX08aDF49XdYAQ114PuqbaRFq0J18sAnR8zQqsnUGS04PR6FhgKMIjWNRjMq351uRz6/AQ"}},"unsigned":{"age_ts":1672248712153,"replaces_state":"$9ArTh8Z2w2oc68FOD1X8Ka3DlK7lq00HaHKT_4DMSY4"}}	3
$QwAobZq6xey4D-6yOm_xg4h6rCKIRUpTqM4HBNroJwE	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$irHFClZVEAzlAtsjct-1MJjEotldPu1Ozkm_NYQrtqI","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$oPNBx-eTHzyLXPzpYpdxdhLdVeGmx5lNmrECxIazfPQ"],"prev_events":["$irHFClZVEAzlAtsjct-1MJjEotldPu1Ozkm_NYQrtqI"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"MattermostUser A [mm]"},"depth":16,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672248798272,"hashes":{"sha256":"ol8wyilvNoiJl0JVVm1GNJOBj+IjIiv0kn7Z2weo5xQ"},"signatures":{"localhost":{"ed25519:a_CHdg":"O1ZHiKjtHsAmv6bjNL+Dvqe5RyZb169ZOY0ro8s4dmQRdatHUs8dQ+E9d/jLkq+wb4MHDNaIv2g24qEQfy6yDg"}},"unsigned":{"age_ts":1672248798272,"replaces_state":"$irHFClZVEAzlAtsjct-1MJjEotldPu1Ozkm_NYQrtqI","invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#off-topic:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$sPO_9Od1FvK55Z9_vb0hx3ophiGuLyATo1RKYIEFxHc	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":3,"historical":false}	{"auth_events":["$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$5-KkKYPCr68IjD4sKk3rDF6kVYVkDMllW0BFUv7G4Do","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$5-KkKYPCr68IjD4sKk3rDF6kVYVkDMllW0BFUv7G4Do"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_a:localhost","content":{"membership":"join","displayname":"Matrix UserA"},"depth":16,"prev_state":[],"state_key":"@matrix_a:localhost","origin":"localhost","origin_server_ts":1672249107906,"hashes":{"sha256":"jK9zbeGshAMFITcwcNdniYSBJ1lQKNSYzvzPbBFHfSc"},"signatures":{"localhost":{"ed25519:a_CHdg":"LQzEev8oSvCTVNebqqRipOgjULaI/BzKTUIks8egqJWzwWaKCZcOguOfCuC2Iems2k4JF4fr/9NJgWbeylloCg"}},"unsigned":{"age_ts":1672249107906,"replaces_state":"$5-KkKYPCr68IjD4sKk3rDF6kVYVkDMllW0BFUv7G4Do"}}	3
$oXLyUPbqiXmRRNovjt9_FJFQLCzMQjPsaism-trtsDw	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"historical":false}	{"auth_events":["$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$zMfjO64yH55JKcwd-hMCa1P1ARHyAuvBbnPeUiNnS48","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$zMfjO64yH55JKcwd-hMCa1P1ARHyAuvBbnPeUiNnS48"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"membership":"join","displayname":"Matrix UserA"},"depth":21,"prev_state":[],"state_key":"@matrix_a:localhost","origin":"localhost","origin_server_ts":1672249108353,"hashes":{"sha256":"Rw2eyYa+tbXse7Sfgzx8PFBAv6CgOmAoQWZq/QumAfc"},"signatures":{"localhost":{"ed25519:a_CHdg":"It8i+GPeAxIounaUGzpxzGERML7Ei84ZT4AefhzGXiu9A/1HOTw+IB5sCDXN68hv6eLfYd5heVmWKnlaPOpxAQ"}},"unsigned":{"age_ts":1672249108353,"replaces_state":"$zMfjO64yH55JKcwd-hMCa1P1ARHyAuvBbnPeUiNnS48"}}	3
$wEwGnOPXUgG2_4DpqsPrYbSlIM2TnPjdWNDyVbZNE2Y	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$YwLlyzcAMpJ69jsxTNglcWTbK8XHK8huc6aB6jpgEWk","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$-J2tr3j7vfmJ8ZSBAK5AyvQYmP2Byp-7dKfcBg5xHjU"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_b:localhost","content":{"membership":"leave"},"depth":18,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672249110131,"hashes":{"sha256":"WuFiPGe2RTyweruE19M1SX43bAkTcuWsBVxm8mP2ntw"},"signatures":{"localhost":{"ed25519:a_CHdg":"qxYWvqwu5EMt2TpjkKrJ+BChK+INPW96XuG3wuevJgy7HJyyenQ+ps64ib82f0a1WAKUyY183oc22V0H7WUfDQ"}},"unsigned":{"age_ts":1672249110131,"replaces_state":"$YwLlyzcAMpJ69jsxTNglcWTbK8XHK8huc6aB6jpgEWk"}}	3
$sY34u-PbOKSI3_z8SIqGfn_2XnO9wqZ_eU1dvGDnRJY	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$oZEGsAxUrYn8R6NS359wZO9T54eXOD-N88ftDK7ZHGU"],"prev_events":["$oZEGsAxUrYn8R6NS359wZO9T54eXOD-N88ftDK7ZHGU"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"depth":25,"prev_state":[],"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1672249111145,"hashes":{"sha256":"J9UZX2mFSPx7Ec9SevHq5KJXTyn8nX2cq3pdh2ZC/bo"},"signatures":{"localhost":{"ed25519:a_CHdg":"G70E58mLIO6BFfNn5MKsxKWNrKTcwNwsrNz0VIG8ckSArmM3gDdyhpyKqYPiQGQq3uYR95C5QHQvnJfbXTjcCA"}},"unsigned":{"age_ts":1672249111145,"replaces_state":"$oZEGsAxUrYn8R6NS359wZO9T54eXOD-N88ftDK7ZHGU"}}	3
$aUCd2uzLS80uiu1DeYrTDp1wAWs7M1ba_4Srm8LLnmU	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$-J2tr3j7vfmJ8ZSBAK5AyvQYmP2Byp-7dKfcBg5xHjU","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$zhfRuogjo-Vq5GM4-f6hyuXBGHx99o9_Nef1KWi2-EM"],"prev_events":["$zhfRuogjo-Vq5GM4-f6hyuXBGHx99o9_Nef1KWi2-EM"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"MattermostUser A [mm]"},"depth":21,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672249112222,"hashes":{"sha256":"MH5LscPpBzxi67ZwXXZib9nv1B6LeDkGp/a8oEUSdEg"},"signatures":{"localhost":{"ed25519:a_CHdg":"mP9GYBimbvjTwkdrBY7cQe/11KZSGYhoClqE0pEcIwTezTYBQmxYnzv6ex2YJDDU1/2HlUCcr8pTEBNMjxbpBw"}},"unsigned":{"age_ts":1672249112222,"replaces_state":"$-J2tr3j7vfmJ8ZSBAK5AyvQYmP2Byp-7dKfcBg5xHjU","invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#town-square:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$3xEI-iU3Teo4B51pXGBbjKxM_DDvYlASNK7W09pHncM	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$QwAobZq6xey4D-6yOm_xg4h6rCKIRUpTqM4HBNroJwE","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$QwAobZq6xey4D-6yOm_xg4h6rCKIRUpTqM4HBNroJwE"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_a:localhost","content":{"membership":"join","displayname":"MattermostUser A [mm]"},"depth":17,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672248798425,"hashes":{"sha256":"OPMwWwe5ivr7BfdisgdT875lPbeLfFS9afq5d9U+g2w"},"signatures":{"localhost":{"ed25519:a_CHdg":"DVPQSD0a0EsddKpkC8Nor/i+LMTZOBju6mc/PbnoFA1YkbQhA5BQ4zjjw1SDmhcbh5nWs4VC5ArMoJJkbsDfBg"}},"unsigned":{"age_ts":1672248798425,"replaces_state":"$QwAobZq6xey4D-6yOm_xg4h6rCKIRUpTqM4HBNroJwE"}}	3
$GMh4hFLoeDc1Ssk9kdi7yAMIMSZA9zOJYJMC1AJEOKs	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"historical":false}	{"auth_events":["$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$ETv-B1S-bU8wgS3S1fDdineVdS9YGNq1EMeUPHb6imQ","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$ETv-B1S-bU8wgS3S1fDdineVdS9YGNq1EMeUPHb6imQ"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"membership":"join","displayname":"Matrix UserA"},"depth":19,"prev_state":[],"state_key":"@matrix_a:localhost","origin":"localhost","origin_server_ts":1672249106075,"hashes":{"sha256":"KzpQQwT0twcncMQ7/GmpLigXAsT5AutEt2PcvLxTRHk"},"signatures":{"localhost":{"ed25519:a_CHdg":"Fn/5u9gucmpWMK0n63f62DQXcnW9t6QQjjtJfAxN9EUvaND6KajNhjKbwvtGmk6HoWpEJ/wO6chmqUwtVntoBg"}},"unsigned":{"age_ts":1672249106075,"replaces_state":"$ETv-B1S-bU8wgS3S1fDdineVdS9YGNq1EMeUPHb6imQ"}}	3
$zMfjO64yH55JKcwd-hMCa1P1ARHyAuvBbnPeUiNnS48	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"historical":false}	{"auth_events":["$GMh4hFLoeDc1Ssk9kdi7yAMIMSZA9zOJYJMC1AJEOKs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$GMh4hFLoeDc1Ssk9kdi7yAMIMSZA9zOJYJMC1AJEOKs"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"membership":"leave"},"depth":20,"prev_state":[],"state_key":"@matrix_a:localhost","origin":"localhost","origin_server_ts":1672249106854,"hashes":{"sha256":"514z8FfG2CNQAZKi0z+Q3DzCy5ZkKsuwVRfV1lxm3jg"},"signatures":{"localhost":{"ed25519:a_CHdg":"QkbBVZF0jM+6enMrBwQliOD8xQwq2AOajdJfG7D6MozpCUfP4tJb8v/DlKXibVqIJhZaaH/TIB6cqCsRIpX8BA"}},"unsigned":{"age_ts":1672249106854,"replaces_state":"$GMh4hFLoeDc1Ssk9kdi7yAMIMSZA9zOJYJMC1AJEOKs"}}	3
$-J2tr3j7vfmJ8ZSBAK5AyvQYmP2Byp-7dKfcBg5xHjU	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$V_uchZ_8H2oh6EdsXqKsT6Ri62_YZtAAMfZi8pbBGrc","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$sPO_9Od1FvK55Z9_vb0hx3ophiGuLyATo1RKYIEFxHc"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"membership":"leave"},"depth":17,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672249109780,"hashes":{"sha256":"uEu1u/m8sYJPIzIuP3YP1GkLOa0xrX/mBhxdQgG/N/k"},"signatures":{"localhost":{"ed25519:a_CHdg":"bATxYxfQYSckbPMzYp1P1XDsNsAmuaByxXzQXno5uyGOuk3JAegesbZlKxB9tG4J5eA2MFZQLHfA46GTMaLKAg"}},"unsigned":{"age_ts":1672249109780,"replaces_state":"$V_uchZ_8H2oh6EdsXqKsT6Ri62_YZtAAMfZi8pbBGrc"}}	3
$LN4aYSSVw4GLaWf8g7uzrsw-fHTUyCBwq_-RRgS-MGE	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$3pZnE6ITQzzyNsuVCenuFBVRMocr892PiAvIbMGbMBM"],"prev_events":["$wEwGnOPXUgG2_4DpqsPrYbSlIM2TnPjdWNDyVbZNE2Y"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"leave"},"depth":19,"prev_state":[],"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1672249110470,"hashes":{"sha256":"aWlFNlYGyYWd6QD0AkKoByi9chVan9ZbshoZ6P7iJzk"},"signatures":{"localhost":{"ed25519:a_CHdg":"xtQbLHB6MPs1L/3KCN97lHrUD/UqejNFj1eGRuCAErkb05Bf34yjGFxO7HvDcjBNpsJY4IUpjz/iGbqivZKJCQ"}},"unsigned":{"age_ts":1672249110470,"replaces_state":"$3pZnE6ITQzzyNsuVCenuFBVRMocr892PiAvIbMGbMBM"}}	3
$ETv-B1S-bU8wgS3S1fDdineVdS9YGNq1EMeUPHb6imQ	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"historical":false}	{"auth_events":["$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$3xEI-iU3Teo4B51pXGBbjKxM_DDvYlASNK7W09pHncM"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"membership":"leave"},"depth":18,"prev_state":[],"state_key":"@matrix_a:localhost","origin":"localhost","origin_server_ts":1672249103595,"hashes":{"sha256":"SnqBH69sxQ0ySWoPbtKWZXdAniJRd+UaBI6G0Z0uswc"},"signatures":{"localhost":{"ed25519:a_CHdg":"3zDwCPA6PhY8iHmWOXrudrvM+/BoBVo5OCWn1SSHDJrDyjLMs+r0RBg8DzWiLiKR+8IqD6b8EJgNosH7/ALdDg"}},"unsigned":{"age_ts":1672249103595,"replaces_state":"$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0"}}	3
$0BYuX-7BWlMOYXwWp-y_txKwBBorVZzavW6fDuXxUrM	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$OcjvTopfs1z8zuVgRxn4ynq9LH7z4eQhJnWG0PQ7150","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$JtjXz-jm6mi5wU33MudkV8ZsCM2V-zduDqeI1xIG254"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_b:localhost","content":{"membership":"join","displayname":"mattermost_b [mm]"},"depth":24,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672249112992,"hashes":{"sha256":"OeekHpIfxgt8Sb09P9Y9KzTzoc6q8K6vscKZlKEU23c"},"signatures":{"localhost":{"ed25519:a_CHdg":"n2oASq6zTYylWJCMW+vUL/4p6CJTj+sT2Vs4TJ0zTB0nmmkVGvlrnhLPvROBSN4ri0QeRn6RDcBb7u7BsUJmBg"}},"unsigned":{"age_ts":1672249112992,"replaces_state":"$OcjvTopfs1z8zuVgRxn4ynq9LH7z4eQhJnWG0PQ7150"}}	3
$zhfRuogjo-Vq5GM4-f6hyuXBGHx99o9_Nef1KWi2-EM	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$LN4aYSSVw4GLaWf8g7uzrsw-fHTUyCBwq_-RRgS-MGE"],"prev_events":["$LN4aYSSVw4GLaWf8g7uzrsw-fHTUyCBwq_-RRgS-MGE"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"depth":20,"prev_state":[],"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1672249111160,"hashes":{"sha256":"/pNSKZwrjdJafFfVY2/SC6Ne6LN0KDHmrtA8b+T2u9k"},"signatures":{"localhost":{"ed25519:a_CHdg":"f94BJWI9Dd8Gd8IK+thvN18AUaHmZWRm3EAlbCE1O2QelPxiTd/Bc8iAeIfWepfq5ZlKOX/YYoLpMaDJSEOyAw"}},"unsigned":{"age_ts":1672249111160,"replaces_state":"$LN4aYSSVw4GLaWf8g7uzrsw-fHTUyCBwq_-RRgS-MGE"}}	3
$GcBRlllGdKFvT1pDzY7airMfjuYYNt06vxkQ0BnM6IM	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$3A5iUMUsDMAckTZ_lQ9ZLyQdw7FKGrqWfMMxwAZJCwc","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$zogqtnD68sbYTleQBUL-RkGDpkNmTHar6ilm_2oVnRs"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_b:localhost","content":{"membership":"join","displayname":"mattermost_b [mm]"},"depth":28,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672249112651,"hashes":{"sha256":"d+ywFuUyMEXl00WCWLagKJkBBfPzmjFhhIYzJTV5iCU"},"signatures":{"localhost":{"ed25519:a_CHdg":"gJlnpMwAzeyrwEsk15rrim5YR3wAtMeuqMUXZOOCsd9biqzXSh8vQIPPTXvunQUFLLDpJ9aA/HErG/Itt6WdBQ"}},"unsigned":{"age_ts":1672249112651,"replaces_state":"$3A5iUMUsDMAckTZ_lQ9ZLyQdw7FKGrqWfMMxwAZJCwc"}}	3
$3A5iUMUsDMAckTZ_lQ9ZLyQdw7FKGrqWfMMxwAZJCwc	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$7EOMmT1sBVcDB2udDBhhf11Mok_GC9CY-6bxtIKAYpc","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$sY34u-PbOKSI3_z8SIqGfn_2XnO9wqZ_eU1dvGDnRJY"],"prev_events":["$sY34u-PbOKSI3_z8SIqGfn_2XnO9wqZ_eU1dvGDnRJY"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"mattermost_b [mm]"},"depth":26,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672249112088,"hashes":{"sha256":"MXIjF/x9cnhTk/oSaG+V8EylMl5DFhhiICWTRCIKOY0"},"signatures":{"localhost":{"ed25519:a_CHdg":"6wBKE2uMYOQRz3ls6IENn+nUgth5uNq7uOAhbN+hY4gc39CZKjIjPYLSIfwTwfAcL9vBcFy8SlrUZ/4yFUH2Cw"}},"unsigned":{"age_ts":1672249112088,"replaces_state":"$7EOMmT1sBVcDB2udDBhhf11Mok_GC9CY-6bxtIKAYpc","invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#off-topic:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$zogqtnD68sbYTleQBUL-RkGDpkNmTHar6ilm_2oVnRs	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$o0wI9-m-SdyS4UK7_m9_MUd0luWmj6eoXfMg1ieT00g","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$sY34u-PbOKSI3_z8SIqGfn_2XnO9wqZ_eU1dvGDnRJY"],"prev_events":["$3A5iUMUsDMAckTZ_lQ9ZLyQdw7FKGrqWfMMxwAZJCwc"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"MattermostUser A [mm]"},"depth":27,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672249112364,"hashes":{"sha256":"o9hdCABUSimZgo/V0n65WXkb60aLems5elDHaTOV2BY"},"signatures":{"localhost":{"ed25519:a_CHdg":"MmLf2u1Cx8/2TkshoSMYs4g6fP9S7cw6KNep5VSddpX5cHNArz0uBPooJVMJc/Diup2VRXfA1AnMSj2lb7+rDA"}},"unsigned":{"age_ts":1672249112364,"replaces_state":"$o0wI9-m-SdyS4UK7_m9_MUd0luWmj6eoXfMg1ieT00g","invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#off-topic:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$OcjvTopfs1z8zuVgRxn4ynq9LH7z4eQhJnWG0PQ7150	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$wEwGnOPXUgG2_4DpqsPrYbSlIM2TnPjdWNDyVbZNE2Y","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$zhfRuogjo-Vq5GM4-f6hyuXBGHx99o9_Nef1KWi2-EM"],"prev_events":["$aUCd2uzLS80uiu1DeYrTDp1wAWs7M1ba_4Srm8LLnmU"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"mattermost_b [mm]"},"depth":22,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672249112469,"hashes":{"sha256":"Dyai5oN89eMiS3IPaxqn75KgJ6VI8ov1GlDYUa3SJx8"},"signatures":{"localhost":{"ed25519:a_CHdg":"p3MIK5RXxxzpn0VR26fiMsHRLr8cdTlga6/bniNg+5/nWvcMX3TIYz0GEuGR5SEb2LVwqh0KJzifxQLBqnjqCA"}},"unsigned":{"age_ts":1672249112469,"replaces_state":"$wEwGnOPXUgG2_4DpqsPrYbSlIM2TnPjdWNDyVbZNE2Y","invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#town-square:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$JtjXz-jm6mi5wU33MudkV8ZsCM2V-zduDqeI1xIG254	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$aUCd2uzLS80uiu1DeYrTDp1wAWs7M1ba_4Srm8LLnmU","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$OcjvTopfs1z8zuVgRxn4ynq9LH7z4eQhJnWG0PQ7150"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"membership":"join","displayname":"MattermostUser A [mm]"},"depth":23,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672249112754,"hashes":{"sha256":"GEUKbroREEZbu6sxfKGM2855WQrjSsudIZ8j6MLGrJw"},"signatures":{"localhost":{"ed25519:a_CHdg":"V/V+UTjxaJkUDhNfS/lQ6gJENhKLB/IJ3GzWv6U/jVb+1PdgD81Aivp4zLDOBLStAD8ivbUT915HHyqUIAx0BQ"}},"unsigned":{"age_ts":1672249112754,"replaces_state":"$aUCd2uzLS80uiu1DeYrTDp1wAWs7M1ba_4Srm8LLnmU"}}	3
$6cga7PdI_98v2MEH6Wosfik3Plxt3Ml7GwsUkSFFa00	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$zogqtnD68sbYTleQBUL-RkGDpkNmTHar6ilm_2oVnRs","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$GcBRlllGdKFvT1pDzY7airMfjuYYNt06vxkQ0BnM6IM"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_a:localhost","content":{"membership":"join","displayname":"MattermostUser A [mm]"},"depth":29,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672249112876,"hashes":{"sha256":"Y/pMj8T9eJTu37MvwWpjxkMxTz96TzPcghLwwm51KS4"},"signatures":{"localhost":{"ed25519:a_CHdg":"7l5HNgikuKv1sPnPXZw3MUEplkRfB9T0yIAwMliqoH2qD49XoWufCaVBPmVH3rI/J3+F/GojIa9fggFgCz7xCw"}},"unsigned":{"age_ts":1672249112876,"replaces_state":"$zogqtnD68sbYTleQBUL-RkGDpkNmTHar6ilm_2oVnRs"}}	3
$OOCwtQCB-nmnnlgQ3ST3ItcIsITOLkC3b4a-WpaJjRg	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$6cga7PdI_98v2MEH6Wosfik3Plxt3Ml7GwsUkSFFa00","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$6cga7PdI_98v2MEH6Wosfik3Plxt3Ml7GwsUkSFFa00"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_a:localhost","content":{"membership":"leave"},"depth":30,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672305682122,"hashes":{"sha256":"aOlLmySJPXGZ7jRPZJWWR9D4wQW12qLEGn25XpzLGcI"},"signatures":{"localhost":{"ed25519:a_CHdg":"K4b4CoU9vDm34a0ruGGHR8EzNfMLOwuiSqkLzz2ClqUGQWLT6X00oFNwfT7s+4mCBgdKRhFnfANxxyyRC8WpDQ"}},"unsigned":{"age_ts":1672305682122,"replaces_state":"$6cga7PdI_98v2MEH6Wosfik3Plxt3Ml7GwsUkSFFa00"}}	3
$gnR3q3jOOEFI04MZ00yFbtQ5ZNs9EfZENfrrOEEj46s	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672305710373.0","historical":false}	{"auth_events":["$JtjXz-jm6mi5wU33MudkV8ZsCM2V-zduDqeI1xIG254","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$0BYuX-7BWlMOYXwWp-y_txKwBBorVZzavW6fDuXxUrM"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"test"},"depth":25,"prev_state":[],"origin":"localhost","origin_server_ts":1672305710404,"hashes":{"sha256":"xJ62kYf8+rb5ZjSyKKicqxlZH1nYQWSUsNoMOeDTBiQ"},"signatures":{"localhost":{"ed25519:a_CHdg":"LW6TABEoPqM9P7Lrf2usfI6AGtJ4fPETN4GRtipZtOOUKgqfcARof4n5pqAlnTJn5GE1BKPgZum5ikiAMNMiDg"}},"unsigned":{"age_ts":1672305710404}}	3
$ZI6mQ9fcQaRUQRDK0WWxDErZcQGD7ahzFrk1b9nCFRE	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":3,"txn_id":"m1672306061819.0","historical":false}	{"auth_events":["$sPO_9Od1FvK55Z9_vb0hx3ophiGuLyATo1RKYIEFxHc","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$gnR3q3jOOEFI04MZ00yFbtQ5ZNs9EfZENfrrOEEj46s"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"test2"},"depth":26,"prev_state":[],"origin":"localhost","origin_server_ts":1672306061836,"hashes":{"sha256":"b+/FlYcHJuyzOQBM0afKqS09GAk+Ra6ISt+QGQ/8ufA"},"signatures":{"localhost":{"ed25519:a_CHdg":"k4SlFcZHgvlkgMf+4ol5+hh3qA8KZeAzY6wYEJClNckY/HXaEUk8Dbsu8QldAWlQThaWunZp0TsxhzdwQ9E8Ag"}},"unsigned":{"age_ts":1672306061836}}	3
$raYGvFCt-q8kxStPhO_tzxQ3pOmVeo5gn8lTV6sHBvs	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672306062131.1","historical":false}	{"auth_events":["$JtjXz-jm6mi5wU33MudkV8ZsCM2V-zduDqeI1xIG254","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$ZI6mQ9fcQaRUQRDK0WWxDErZcQGD7ahzFrk1b9nCFRE"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"# Header\\n\\n**bold**","format":"org.matrix.custom.html","formatted_body":"<h1>Header</h1><strong>bold</strong>"},"depth":27,"prev_state":[],"origin":"localhost","origin_server_ts":1672306062147,"hashes":{"sha256":"h5Hg+b6cx0//IP2Zp+FDQ1xfJoUSxazjjALBBJRi8a8"},"signatures":{"localhost":{"ed25519:a_CHdg":"77HTYp1uUEE1SqnpPYDqV5WyGQFA76ah/Gstxm9YYE03ydX2J2YwgI7citDB22/FnLaQjVTf8+4Yysxk3TmpDQ"}},"unsigned":{"age_ts":1672306062147}}	3
$mfDu-vDNMkOg-psLHXlWcSXOnVkeuUPJfdm2cZ-3P-k	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":4,"txn_id":"m1672306062302.0","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk"],"prev_events":["$raYGvFCt-q8kxStPhO_tzxQ3pOmVeo5gn8lTV6sHBvs"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_b:localhost","content":{"msgtype":"m.text","body":"random wrong message","format":"org.matrix.custom.html","formatted_body":"<h1>Header</h1><b>Bolded text</b>"},"depth":28,"prev_state":[],"origin":"localhost","origin_server_ts":1672306062326,"hashes":{"sha256":"fev9h6X4YtDDKgCTD77/TfeIwg6NHYpfxRRRmiQt01k"},"signatures":{"localhost":{"ed25519:a_CHdg":"6dKxdGWpTt3tqxTGs6dJvB72OyKoax1WYMU50+ayNBe/xdXpxkujhEwlW1WV3ef2duv3/dUgZMphGMLPs3CdBA"}},"unsigned":{"age_ts":1672306062326}}	3
$iDgp052fBKJYL2KTsRdizUAlriA5itky5-e20aiZwHI	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":3,"txn_id":"m1672306062480.0","historical":false}	{"auth_events":["$sPO_9Od1FvK55Z9_vb0hx3ophiGuLyATo1RKYIEFxHc","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$mfDu-vDNMkOg-psLHXlWcSXOnVkeuUPJfdm2cZ-3P-k"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.emote","body":"test"},"depth":29,"prev_state":[],"origin":"localhost","origin_server_ts":1672306062494,"hashes":{"sha256":"jVcMqW9OX7LWRZzMB37DBMTG+MOIfqNGy1HuYxEYVQE"},"signatures":{"localhost":{"ed25519:a_CHdg":"YVdYESQem0vTgO8j172/7YV0FotAq/h46DQF+r0ata3tB45n2SLpDC1dSvTWzPkBPad5iaB2FYEclJSgq5/oDg"}},"unsigned":{"age_ts":1672306062494}}	3
$uwN8jjs4qWXT6fsX4o-36T96CWj17IDa_TJ3mF5Hd7M	!dKcbdDATuwwphjRPQP:localhost	{"txn_id":"m1672306062737.0","historical":false}	{"auth_events":["$GcBRlllGdKFvT1pDzY7airMfjuYYNt06vxkQ0BnM6IM","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$OOCwtQCB-nmnnlgQ3ST3ItcIsITOLkC3b4a-WpaJjRg"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_b:localhost","content":{"msgtype":"m.text","body":"filename"},"depth":31,"prev_state":[],"origin":"localhost","origin_server_ts":1672306062756,"hashes":{"sha256":"3ZTMfULvAsMpjoBhnT2/6v0EJ6IH0+fmv+GG99xA0uc"},"signatures":{"localhost":{"ed25519:a_CHdg":"0KV2pjWMrWUDPHQ0LVHHz8H3+INf07ORos/hOV+3YZDm384rey93XM94TPptmRpfOJu5L0sepUIB+AcLZ5nFAA"}},"unsigned":{"age_ts":1672306062756}}	3
$AxFCh7nvzu51kpXaQqyK3CKEqdyGhhJ0zhqT-c9LGPk	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672306063313.0","historical":false}	{"auth_events":["$oXLyUPbqiXmRRNovjt9_FJFQLCzMQjPsaism-trtsDw","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$mXxM94SwVR0FuKbH_riuFTeW0zH7Om62-HEudW_5y80"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"hidden message"},"depth":33,"prev_state":[],"origin":"localhost","origin_server_ts":1672306063330,"hashes":{"sha256":"f5dA+eA+QVbsPTtvN2cEyrntsQo1AlcBVD8qR7c6dkc"},"signatures":{"localhost":{"ed25519:a_CHdg":"T+3ZiD+45G3QW+fWBrA87g3kQ8wjSz+owZZBBXbtSuQ1xGdOzj3c83tkD9qMuGBIkr6GLTx3XQ19XCqYvgmdBg"}},"unsigned":{"age_ts":1672306063330}}	3
$mXxM94SwVR0FuKbH_riuFTeW0zH7Om62-HEudW_5y80	!dKcbdDATuwwphjRPQP:localhost	{"txn_id":"m1672306062881.1","historical":false}	{"auth_events":["$GcBRlllGdKFvT1pDzY7airMfjuYYNt06vxkQ0BnM6IM","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$uwN8jjs4qWXT6fsX4o-36T96CWj17IDa_TJ3mF5Hd7M"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_b:localhost","content":{"msgtype":"m.file","body":"filename","url":"mxc://localhost/HDyXgvaVtVojxpAOhDMJKTum","info":{"mimetype":"","size":11}},"depth":32,"prev_state":[],"origin":"localhost","origin_server_ts":1672306062896,"hashes":{"sha256":"SUyUOrkXug4GEUnqDjPlxVobFa4Ovm3dvWQYXFAXfz8"},"signatures":{"localhost":{"ed25519:a_CHdg":"l4+SrT659cG75hUWYkIgYCSejNspfOOFFvjAun7DhPACTVtboFUg1I2pvzJp1ngW8WKuvSKcCLfKwY2cXgQuBA"}},"unsigned":{"age_ts":1672306062896}}	3
$OVhb59gyrKY7dsgLlfdIwe1H4O5zslN774jooAK4vec	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":3,"txn_id":"m1672306063113.0","historical":false}	{"auth_events":["$sPO_9Od1FvK55Z9_vb0hx3ophiGuLyATo1RKYIEFxHc","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$iDgp052fBKJYL2KTsRdizUAlriA5itky5-e20aiZwHI"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.file","body":"mydata","url":"mxc://localhost/fWhfcdaRNpxsjrhOUkKqnmdY","info":{"mimetype":"text/plain"}},"depth":30,"prev_state":[],"origin":"localhost","origin_server_ts":1672306063132,"hashes":{"sha256":"RYd5rYhbX61tTpv9PS1BAZFqyzob9AvS6eXTsQjGHxs"},"signatures":{"localhost":{"ed25519:a_CHdg":"BJ3algKtwZIIruSOOBVeRG/JHo1GZ10RvRyA7nWWD7gb46jX3jiI91dAe/vgsl88CnVeXH4l3ZmFd9v1x4q2Cg"}},"unsigned":{"age_ts":1672306063132}}	3
$4KgY7ivi_pp1q2tjdk7IWENjs1kzgSRLB29nKbq-UXw	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":3,"historical":false}	{"auth_events":["$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$fc-Paa3ZBQU-GAAxH4QWDNrWblQvQ4ddYVzPTPiYV6U","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$fc-Paa3ZBQU-GAAxH4QWDNrWblQvQ4ddYVzPTPiYV6U"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_a:localhost","content":{"membership":"join","displayname":"Matrix UserA"},"depth":32,"prev_state":[],"state_key":"@matrix_a:localhost","origin":"localhost","origin_server_ts":1672308589600,"hashes":{"sha256":"imEPMl3Ij9dJFVR9KgJ7rcveS/y4WpZYToCaxeOQL14"},"signatures":{"localhost":{"ed25519:a_CHdg":"3l3Y7hD33pymGNZ/aWS/jz1Hx86mVYOqwQPNZzsXIh8MDNH//qVPWElUbU4M6rA+tz/p1CBSkUP3yusdxA3tBQ"}},"unsigned":{"age_ts":1672308589600,"replaces_state":"$fc-Paa3ZBQU-GAAxH4QWDNrWblQvQ4ddYVzPTPiYV6U"}}	3
$UTOQTSrmXya3IQYDcRPwNWN1bIv2zQ3YfbaVRy9NQuA	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$0BYuX-7BWlMOYXwWp-y_txKwBBorVZzavW6fDuXxUrM","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$EklY0FV28pDgoXqwoQUjAB5wTv33O8RCHRE8k2k6o2c"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_b:localhost","content":{"membership":"leave"},"depth":34,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672308591162,"hashes":{"sha256":"c0l1h4mhesJ7q/SWNRGEkp+UaFZPCTa2JXs5ELauytY"},"signatures":{"localhost":{"ed25519:a_CHdg":"6kfHwssWMI7FKNAebi6IOS/0ZnhAzpGEqcSayYPi3Adaeg+GJs78iPnCwUH5GRn9BWmIQKFh2xxFBUBpxaqXBg"}},"unsigned":{"age_ts":1672308591162,"replaces_state":"$0BYuX-7BWlMOYXwWp-y_txKwBBorVZzavW6fDuXxUrM"}}	3
$EB67Xwo9B0__CxNTvptFIy4e4vG93cmEcHRWbiVSFJU	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$IfK4xyQ_h94nUHneDilGoM0TTwuWFeP5_u_nlRs571U","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$TbzKCcECXvJAKvBu5GZCTLIGi7Js0b1w9dE6KKZXaKo"],"prev_events":["$LjACIs2QTEZTfukFRb30GQyevcb7EREdVFxoNEgvHSk"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"MattermostUser A [mm]"},"depth":45,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672308593237,"hashes":{"sha256":"7dKR+VBZSGGNQAM/9DiB/qQSfowxJ9RRv1UlaTD5usE"},"signatures":{"localhost":{"ed25519:a_CHdg":"od4h8XpjkzM526aGcVU3NG7KXU5wePGqKphwgxO5G/+L2OxudvTKkYbd7dwosk/oc2ewn5uf1tg+KIkCGBxqCA"}},"unsigned":{"age_ts":1672308593237,"replaces_state":"$IfK4xyQ_h94nUHneDilGoM0TTwuWFeP5_u_nlRs571U","invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#off-topic:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$85g2ma_sFrYS8UbhpRwYEglJLj7xswd8VgNCg787_3E	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$72MNMNMOJMJpfLbdNKdm6ZXGr14ukIKdq-fG2OvzOqg","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$XhzyXIYIbI0BfDV1QY4H3b4Wrpy5pJgJsGNZc8P8seg"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_b:localhost","content":{"membership":"join","displayname":"mattermost_b [mm]"},"depth":39,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672308593347,"hashes":{"sha256":"mYn1CC6CLwhNDvu28RhCIPmLGaZ9J8AZi4lc7kQbZNM"},"signatures":{"localhost":{"ed25519:a_CHdg":"MmUpDnwvEEw6OGjFhzNlKyCXsb8mwirPm/85Z7X6Ne7cmkpstg47JvepdJZ5lWYiCA4/62tpwHOwKQlvnN3vCg"}},"unsigned":{"age_ts":1672308593347,"replaces_state":"$72MNMNMOJMJpfLbdNKdm6ZXGr14ukIKdq-fG2OvzOqg"}}	3
$kMqJ62yuvBi4RWfOiLMiPcoSKbfcjZvTwwiuRRmfEKA	!dKcbdDATuwwphjRPQP:localhost	{"token_id":4,"txn_id":"m1672312690803.0","historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0"],"prev_events":["$A5qbTNFuQ1MZL2fuT4oUFzi1xCHHDk0NuQZstoz4u-U"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_b:localhost","content":{"msgtype":"m.text","body":"> <@matrix_a> first matrix message\\n\\nsecond matrix message","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>second matrix message","m.relates_to":{"m.in_reply_to":{"event_id":"$A5qbTNFuQ1MZL2fuT4oUFzi1xCHHDk0NuQZstoz4u-U"}}},"depth":49,"prev_state":[],"origin":"localhost","origin_server_ts":1672312690858,"hashes":{"sha256":"uCev6cGfZoi/O547Tr5fQRyEzRW8+5fTUDuxYWlw8uU"},"signatures":{"localhost":{"ed25519:a_CHdg":"/ILdLxEF/mxAqyacsCjDi9vGc9iGnd44k8G6PrKE7QA9KFulNmSkiESfO3P8Wij8510HU6IymB+1X6ozU2LNAA"}},"unsigned":{"age_ts":1672312690858}}	3
$0ruVoUZRE1Edh-f7Z0QopPRTCr7L2kEpX8unxgxmfSQ	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$OOCwtQCB-nmnnlgQ3ST3ItcIsITOLkC3b4a-WpaJjRg","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$sY34u-PbOKSI3_z8SIqGfn_2XnO9wqZ_eU1dvGDnRJY"],"prev_events":["$AxFCh7nvzu51kpXaQqyK3CKEqdyGhhJ0zhqT-c9LGPk"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"MattermostUser A [mm]"},"depth":34,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672308588235,"hashes":{"sha256":"p/rXdtNNJ/sqMLvujitQBhYoxsgaQgOl3yQmtQXqt78"},"signatures":{"localhost":{"ed25519:a_CHdg":"DCO7Pcro3ECTXAkPxCLqHa31d2wprEuwm+C4YaLyQz8/nhmetwfBYly0oeKKeFOd0kyOW9ESBjaZIaCnRlheDA"}},"unsigned":{"age_ts":1672308588235,"replaces_state":"$OOCwtQCB-nmnnlgQ3ST3ItcIsITOLkC3b4a-WpaJjRg","invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#off-topic:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$hWVSd4FzjwQq7FYDdhFSCgpisb3gxDJ2OAjCjYS6rkg	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$0ruVoUZRE1Edh-f7Z0QopPRTCr7L2kEpX8unxgxmfSQ","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$0ruVoUZRE1Edh-f7Z0QopPRTCr7L2kEpX8unxgxmfSQ"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_a:localhost","content":{"membership":"join","displayname":"MattermostUser A [mm]"},"depth":35,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672308588403,"hashes":{"sha256":"/a6Q6tCPAtjanRq7Rt2E7e8lZhNU2Yq3MIidZtSn57s"},"signatures":{"localhost":{"ed25519:a_CHdg":"0gIg821CJC591ETx46290e/SPVxY2R8v9p6ELOQhLDcNtxG6zPZarfZwDVZ4B12irAAGWW0mnzuWDP0D//WgBQ"}},"unsigned":{"age_ts":1672308588403,"replaces_state":"$0ruVoUZRE1Edh-f7Z0QopPRTCr7L2kEpX8unxgxmfSQ"}}	3
$EklY0FV28pDgoXqwoQUjAB5wTv33O8RCHRE8k2k6o2c	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$JtjXz-jm6mi5wU33MudkV8ZsCM2V-zduDqeI1xIG254","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$4KgY7ivi_pp1q2tjdk7IWENjs1kzgSRLB29nKbq-UXw"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"membership":"leave"},"depth":33,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672308590900,"hashes":{"sha256":"XUY1x5ZZrH6LA7ku/azccN705D8IBvaPhniEECBRci8"},"signatures":{"localhost":{"ed25519:a_CHdg":"buvIrgEivkpZqd/h+igq4BlrnvLUEaC6QjmGvnYP7NP91jW781jSNEB/layrubjQ0iKj9OPyl9KFyKV9VHkwAQ"}},"unsigned":{"age_ts":1672308590900,"replaces_state":"$JtjXz-jm6mi5wU33MudkV8ZsCM2V-zduDqeI1xIG254"}}	3
$ShuNV5AOx3oTjKr3eYjFKvzCZ374R_0vxs2HC21ht-g	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$GcBRlllGdKFvT1pDzY7airMfjuYYNt06vxkQ0BnM6IM","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$0EmcDbHM6t0AJ7YKAcphqL8othdZg4dIXSazEHvnCno"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_b:localhost","content":{"membership":"leave"},"depth":40,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672308590951,"hashes":{"sha256":"mbje2XCUpQOm5ZaZQ4EzbrR2eeUshOA/We7G1cXyTvU"},"signatures":{"localhost":{"ed25519:a_CHdg":"HPkErpUF/SGsPwQHCmywuAKUjx+sznvVqyhEPv2j3xRRY6rMRD5ptH3kl1PtMXYmpVx1b41dsAbZa1gtsdBrAA"}},"unsigned":{"age_ts":1672308590951,"replaces_state":"$GcBRlllGdKFvT1pDzY7airMfjuYYNt06vxkQ0BnM6IM"}}	3
$QjDo1bVrVGh33tmezjIVWxT6VXLutgIWlP9outS8Gcg	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672312506140.0","historical":false}	{"auth_events":["$WPbDUZRE7W6o_O4D0qf40PxoXNWcHrBwx3LxCA_ILaY","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$WPbDUZRE7W6o_O4D0qf40PxoXNWcHrBwx3LxCA_ILaY"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"test"},"depth":41,"prev_state":[],"origin":"localhost","origin_server_ts":1672312506179,"hashes":{"sha256":"CSk8+khSHBxi5pID6nphL/Imr7HDh4vyhJBU70EuLNo"},"signatures":{"localhost":{"ed25519:a_CHdg":"rfAc2ODmL/jN3JOkG3AaR/ImuB3JddEdK2h1e0cHDMAQ1cQRBoV7vl2Yrvk7Zz+eMxKDhepneC0cf3HdagIbDw"}},"unsigned":{"age_ts":1672312506179}}	3
$XikqApD6-vTeGUebJl-_Bc9ButeowpABz5W37dejAy0	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672312536277.1","historical":false}	{"auth_events":["$WPbDUZRE7W6o_O4D0qf40PxoXNWcHrBwx3LxCA_ILaY","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$lQM-XkcgjA40yc1T7BNzbZ8V8yxcnsj23SxrixdEev8"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"> <@mm_mattermost_b:localhost> > <@mm_mattermost_a:localhost>\\n\\nthird mm message","m.relates_to":{"m.in_reply_to":{"event_id":"$lQM-XkcgjA40yc1T7BNzbZ8V8yxcnsj23SxrixdEev8"}},"formatted_body":"<mx-reply><blockquote><a href=\\"https://matrix.to/#/!kmbTYjjsDRDHGgVqUP:localhost/$lQM-XkcgjA40yc1T7BNzbZ8V8yxcnsj23SxrixdEev8?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@mm_mattermost_b:localhost\\">@mm_mattermost_b:localhost</a><br><mx-reply><blockquote><a href=\\"https://matrix.to/#/!kmbTYjjsDRDHGgVqUP:localhost/$j4OmrTBgGXlAg2ui751-jxTS4uMSPCzpj81xWRfOWiA?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@mm_mattermost_a:localhost\\">@mm_mattermost_a:localhost</a><br>first mm message</blockquote></mx-reply>second mm message</blockquote></mx-reply>third mm message","format":"org.matrix.custom.html"},"depth":44,"prev_state":[],"origin":"localhost","origin_server_ts":1672312536321,"hashes":{"sha256":"b7qEDWuvRxkMAXcGP/2Mv+7hKQNmgYi1jLa9HqXv0OA"},"signatures":{"localhost":{"ed25519:a_CHdg":"1x0kPOBMWEQL0TiNrGZlYDJBMOYtHeBNI6VQo2EfsoMFQpHyD72avILfNm+yQEt8wzHKcwlKk/i/0GLeeTJ5Cw"}},"unsigned":{"age_ts":1672312536321}}	3
$wehc8FMA82xW0EU5F86ZkvsBra_SZ0JSA3Yweowv_s8	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672312693293.2","historical":false}	{"auth_events":["$0EmcDbHM6t0AJ7YKAcphqL8othdZg4dIXSazEHvnCno","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$UQr1C3BZK9MztXbBR2a0yz0wCyXSy_abmCstrHnXi2E"],"type":"m.room.redaction","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{},"depth":53,"prev_state":[],"redacts":"$jhFoiytsqlLXRCkoL5gH2sXpQQJFwk3XLtzQPCpA0K8","origin":"localhost","origin_server_ts":1672312693355,"hashes":{"sha256":"UjGRtO6x2iFeKuHzOMjJcK6sDz3UjFnqWmLZdUuKSNI"},"signatures":{"localhost":{"ed25519:a_CHdg":"QbZJLzMHG/y9UGnMyQtf3Bal0L98XHtxa62JSkzXywOox/WhCzNsjC19vqwKesABfs4VDtZVM6iaOfx6TDoIBQ"}},"unsigned":{"age_ts":1672312693355}}	3
$OJhJIVnJWjcgl3gc2AqLQK7sy1tKn075fy4E5qUK014	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"historical":false}	{"auth_events":["$oXLyUPbqiXmRRNovjt9_FJFQLCzMQjPsaism-trtsDw","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$hWVSd4FzjwQq7FYDdhFSCgpisb3gxDJ2OAjCjYS6rkg"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"membership":"leave"},"depth":36,"prev_state":[],"state_key":"@matrix_a:localhost","origin":"localhost","origin_server_ts":1672308588565,"hashes":{"sha256":"aNqM8H6W8tVQcOeMXWrBfdf/C67+EVHRdl0D1E/Tr9g"},"signatures":{"localhost":{"ed25519:a_CHdg":"m4Lmao4w4HAaisdQCJ+Xf0JfabXpYt5Vy0IMZbvMXrfgqlTt8nUmkGwnkybBQCR1aKh5Ga4Vv6PnCYMZ5d34Ag"}},"unsigned":{"age_ts":1672308588565,"replaces_state":"$oXLyUPbqiXmRRNovjt9_FJFQLCzMQjPsaism-trtsDw"}}	3
$nsJ2oe7ZtdBtY0V-sJWzGBBDi7tcgH24zUaAdmLjXy4	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"historical":false}	{"auth_events":["$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$OJhJIVnJWjcgl3gc2AqLQK7sy1tKn075fy4E5qUK014","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$OJhJIVnJWjcgl3gc2AqLQK7sy1tKn075fy4E5qUK014"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"membership":"join","displayname":"Matrix UserA"},"depth":37,"prev_state":[],"state_key":"@matrix_a:localhost","origin":"localhost","origin_server_ts":1672308588805,"hashes":{"sha256":"SVOXW1DYgFBLcmRzHjiSU+V0z1ugpfxP+ECAYE8W8m8"},"signatures":{"localhost":{"ed25519:a_CHdg":"Kk3TCxi1oCO+urrGBFlV+pqmbfYjq6ttD56Y4GUsmOog3ce+2Tuyo4mmr8nF4apSNdYKnTXIZnROQY4AGmG/Aw"}},"unsigned":{"age_ts":1672308588805,"replaces_state":"$OJhJIVnJWjcgl3gc2AqLQK7sy1tKn075fy4E5qUK014"}}	3
$IfK4xyQ_h94nUHneDilGoM0TTwuWFeP5_u_nlRs571U	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$hWVSd4FzjwQq7FYDdhFSCgpisb3gxDJ2OAjCjYS6rkg","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$ShuNV5AOx3oTjKr3eYjFKvzCZ374R_0vxs2HC21ht-g"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_a:localhost","content":{"membership":"leave"},"depth":41,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672308591151,"hashes":{"sha256":"i+vr1sDbv4gGENWrN7p/vlGSD2MnaoXNPNG9LPEWLBc"},"signatures":{"localhost":{"ed25519:a_CHdg":"h0DqNsu0WPa8CHnycIpYPL7vAKZuBh/zce1EvvZ2IBPQ6PDlBxsbj+ytoyGfZ7DY0YrRjFxpxub+mhCIvqnzCQ"}},"unsigned":{"age_ts":1672308591151,"replaces_state":"$hWVSd4FzjwQq7FYDdhFSCgpisb3gxDJ2OAjCjYS6rkg"}}	3
$LjACIs2QTEZTfukFRb30GQyevcb7EREdVFxoNEgvHSk	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$ShuNV5AOx3oTjKr3eYjFKvzCZ374R_0vxs2HC21ht-g","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$TbzKCcECXvJAKvBu5GZCTLIGi7Js0b1w9dE6KKZXaKo"],"prev_events":["$TbzKCcECXvJAKvBu5GZCTLIGi7Js0b1w9dE6KKZXaKo"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"mattermost_b [mm]"},"depth":44,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672308593015,"hashes":{"sha256":"An1PoETSz78MuY/m89L3Qwjt+/Uff4Do/b6/XEqkzXQ"},"signatures":{"localhost":{"ed25519:a_CHdg":"XKShBsOxUYmB7t/4XbkPT2jxea9Bqc5Gfq1IdY51VSSbbw30WsDxlRwqCzxgqxYYmHRaZCCNBeVDNuUdWEWYBA"}},"unsigned":{"age_ts":1672308593015,"replaces_state":"$ShuNV5AOx3oTjKr3eYjFKvzCZ374R_0vxs2HC21ht-g","invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#off-topic:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$jL60Q94H_SC7S4ZFOWkA4RilDwTMIUci2DyEXyQS_t0	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$LjACIs2QTEZTfukFRb30GQyevcb7EREdVFxoNEgvHSk","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$EB67Xwo9B0__CxNTvptFIy4e4vG93cmEcHRWbiVSFJU"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_b:localhost","content":{"membership":"join","displayname":"mattermost_b [mm]"},"depth":46,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672308593474,"hashes":{"sha256":"EkAkNXyRch1AVhLo4jYhsbIXHMoYC4B+8icRHuwSp98"},"signatures":{"localhost":{"ed25519:a_CHdg":"+ucssfG7fUI4Y2TJ1CT4GjIuXoFwrdiWl67KWzeGKNgqOQIIR0NHxkP6XebgYqRf9j2hSk4X1teLBBc02yY8CA"}},"unsigned":{"age_ts":1672308593474,"replaces_state":"$LjACIs2QTEZTfukFRb30GQyevcb7EREdVFxoNEgvHSk"}}	3
$6CT_ZCazUgJysnWN-q2s4b5iR-x1EbXa932nBRpldW4	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672312691371.2","historical":false}	{"auth_events":["$WPbDUZRE7W6o_O4D0qf40PxoXNWcHrBwx3LxCA_ILaY","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$XikqApD6-vTeGUebJl-_Bc9ButeowpABz5W37dejAy0"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"first message"},"depth":45,"prev_state":[],"origin":"localhost","origin_server_ts":1672312691392,"hashes":{"sha256":"qkPBgHFNihcSkYze7r9gkJ1rKbf54M27u2QGwNT1Hfo"},"signatures":{"localhost":{"ed25519:a_CHdg":"2RL0JzzwoLRR020Iz45FSFHdJa7zxQBgQ6WrUjKoXSlvAQD1tZdoYl+xHNEq93duhliTvwsSidj4U0//lVDiBQ"}},"unsigned":{"age_ts":1672312691392}}	3
$UQr1C3BZK9MztXbBR2a0yz0wCyXSy_abmCstrHnXi2E	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672312693119.1","historical":false}	{"auth_events":["$0EmcDbHM6t0AJ7YKAcphqL8othdZg4dIXSazEHvnCno","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$jhFoiytsqlLXRCkoL5gH2sXpQQJFwk3XLtzQPCpA0K8"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"> <@matrix_a> root message\\n\\nreply message","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>reply message","m.relates_to":{"m.in_reply_to":{"event_id":"$jhFoiytsqlLXRCkoL5gH2sXpQQJFwk3XLtzQPCpA0K8"}}},"depth":52,"prev_state":[],"origin":"localhost","origin_server_ts":1672312693241,"hashes":{"sha256":"gJtM+LTF0vPmA9Aaap0tEKN7AXRn0P6ceu2o0yt0BR0"},"signatures":{"localhost":{"ed25519:a_CHdg":"tWhgl51A9OP1cpHtktf8AQ8JIR33JjfR2guoh2TLsDFlDZpdHfGx/9jB7zNIzqMYan/p8Z3f+68Ci8NTL0p0DA"}},"unsigned":{"age_ts":1672312693241}}	3
$XYKCYavbY8FMdUIlSSoqP0likUnTP6uJ0yHoGQCMnWQ	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"historical":false}	{"auth_events":["$nsJ2oe7ZtdBtY0V-sJWzGBBDi7tcgH24zUaAdmLjXy4","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$nsJ2oe7ZtdBtY0V-sJWzGBBDi7tcgH24zUaAdmLjXy4"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"membership":"leave"},"depth":38,"prev_state":[],"state_key":"@matrix_a:localhost","origin":"localhost","origin_server_ts":1672308589144,"hashes":{"sha256":"62FNL7XVkhlh85CLJbTMIH5qkLnlWO7MbZGTbtpglyM"},"signatures":{"localhost":{"ed25519:a_CHdg":"l+qDaoEQVLh7pnEel8FJxt9ZHlZ7p1x6sZXQtBSKFj7EGR6KmUUt1LiZyPDISA2wmEb1lgqmPqhNyNVT71mTBw"}},"unsigned":{"age_ts":1672308589144,"replaces_state":"$nsJ2oe7ZtdBtY0V-sJWzGBBDi7tcgH24zUaAdmLjXy4"}}	3
$fc-Paa3ZBQU-GAAxH4QWDNrWblQvQ4ddYVzPTPiYV6U	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":3,"historical":false}	{"auth_events":["$sPO_9Od1FvK55Z9_vb0hx3ophiGuLyATo1RKYIEFxHc","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$OVhb59gyrKY7dsgLlfdIwe1H4O5zslN774jooAK4vec"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_a:localhost","content":{"membership":"leave"},"depth":31,"prev_state":[],"state_key":"@matrix_a:localhost","origin":"localhost","origin_server_ts":1672308589333,"hashes":{"sha256":"UEtZV/6WyXBNlmOKFwcDBciLz7bdkPgjoFG67G9plpI"},"signatures":{"localhost":{"ed25519:a_CHdg":"oxKKkyiXO55VjuJu8Ihu7BHCp0EZRPdN1sAvxZgkEmVs+pBJHNyax5PR0xJMzyuu7n2lhKd0dO8g7uI2OdF9Dw"}},"unsigned":{"age_ts":1672308589333,"replaces_state":"$sPO_9Od1FvK55Z9_vb0hx3ophiGuLyATo1RKYIEFxHc"}}	3
$0EmcDbHM6t0AJ7YKAcphqL8othdZg4dIXSazEHvnCno	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"historical":false}	{"auth_events":["$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$XYKCYavbY8FMdUIlSSoqP0likUnTP6uJ0yHoGQCMnWQ","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$XYKCYavbY8FMdUIlSSoqP0likUnTP6uJ0yHoGQCMnWQ"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"membership":"join","displayname":"Matrix UserA"},"depth":39,"prev_state":[],"state_key":"@matrix_a:localhost","origin":"localhost","origin_server_ts":1672308590035,"hashes":{"sha256":"6Na6Rs5BBwTfeeu+2kzqmCDi5a8cWDiSvFN/ioSxDts"},"signatures":{"localhost":{"ed25519:a_CHdg":"nuS6bhadV2k8x4K2mkxoxqk8LV9NaQOPk8VFDB8Ku+3/W7fX9Clve0/LJ488J2DTTjha1JvOlMvuFU+Ak6ugCg"}},"unsigned":{"age_ts":1672308590035,"replaces_state":"$XYKCYavbY8FMdUIlSSoqP0likUnTP6uJ0yHoGQCMnWQ"}}	3
$aaPR9QI7az6NxeJ0hSrQxyKzzVyM-rBWODbN9y9rM9Q	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$sY34u-PbOKSI3_z8SIqGfn_2XnO9wqZ_eU1dvGDnRJY"],"prev_events":["$IfK4xyQ_h94nUHneDilGoM0TTwuWFeP5_u_nlRs571U"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"leave"},"depth":42,"prev_state":[],"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1672308591386,"hashes":{"sha256":"pzjudXpp0oDExRG+BM61fpDynitc44/eb/9onIW4ZM4"},"signatures":{"localhost":{"ed25519:a_CHdg":"/TW0UikqBIN4sGiVweczjWwwX44X/78rIVyJycwheZH+oBqSOBARdjytHB/pXB0B6nsLFRwya7+bxx7A8wMjCQ"}},"unsigned":{"age_ts":1672308591386,"replaces_state":"$sY34u-PbOKSI3_z8SIqGfn_2XnO9wqZ_eU1dvGDnRJY"}}	3
$2-SFwejONuAnI3cUJ4UN3FSzzJjeIWUURtWOJiO2sWo	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$sbDgkkxT05mw8xIVFWyOJtbW9nnehE06Wvxor1z8ms8"],"prev_events":["$sbDgkkxT05mw8xIVFWyOJtbW9nnehE06Wvxor1z8ms8"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"depth":36,"prev_state":[],"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1672308592151,"hashes":{"sha256":"msOqB6CtT69Ak4OQZ3HhwtyRVIk4dJMCxmC6BToym2Y"},"signatures":{"localhost":{"ed25519:a_CHdg":"vHx6CGSX+Dfhhsi7O9l0adJnoHRzFxmvH1F+5+JfPvzRkNbY0b0YWQaGjX3eevjXdWVZ53nmiSsIgqlWGNLgCA"}},"unsigned":{"age_ts":1672308592151,"replaces_state":"$sbDgkkxT05mw8xIVFWyOJtbW9nnehE06Wvxor1z8ms8"}}	3
$72MNMNMOJMJpfLbdNKdm6ZXGr14ukIKdq-fG2OvzOqg	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$UTOQTSrmXya3IQYDcRPwNWN1bIv2zQ3YfbaVRy9NQuA","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$2-SFwejONuAnI3cUJ4UN3FSzzJjeIWUURtWOJiO2sWo"],"prev_events":["$2-SFwejONuAnI3cUJ4UN3FSzzJjeIWUURtWOJiO2sWo"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"mattermost_b [mm]"},"depth":37,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672308592958,"hashes":{"sha256":"VrOJxSYPEHtQTtlXuaE3aJJlDI3lwqNpDpmMKbX3cTY"},"signatures":{"localhost":{"ed25519:a_CHdg":"VDb7x776WZ2qNTQ1lGcaheoF8WJRSGvBG1T41hzfrevLL9dLa4JPmtLBFXcsIBQY09ij69FXq0nefMD+XlNHAA"}},"unsigned":{"age_ts":1672308592958,"replaces_state":"$UTOQTSrmXya3IQYDcRPwNWN1bIv2zQ3YfbaVRy9NQuA","invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#town-square:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$WPbDUZRE7W6o_O4D0qf40PxoXNWcHrBwx3LxCA_ILaY	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$XhzyXIYIbI0BfDV1QY4H3b4Wrpy5pJgJsGNZc8P8seg","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$85g2ma_sFrYS8UbhpRwYEglJLj7xswd8VgNCg787_3E"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"membership":"join","displayname":"MattermostUser A [mm]"},"depth":40,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672308593568,"hashes":{"sha256":"hLYBE/8xWA2rDO+e52V1bnjHt47LzO8gPKAWBEX0P9c"},"signatures":{"localhost":{"ed25519:a_CHdg":"XoVU5RL/Pgw4GEMBERAro91unwSx3VnnJhJhbo9uyoppy/6vUSI9MNwhDIYxJkkN+oZiWOuk7bmyIXwAPRLHDg"}},"unsigned":{"age_ts":1672308593568,"replaces_state":"$XhzyXIYIbI0BfDV1QY4H3b4Wrpy5pJgJsGNZc8P8seg"}}	3
$j4OmrTBgGXlAg2ui751-jxTS4uMSPCzpj81xWRfOWiA	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672312535821.0","historical":false}	{"auth_events":["$WPbDUZRE7W6o_O4D0qf40PxoXNWcHrBwx3LxCA_ILaY","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$QjDo1bVrVGh33tmezjIVWxT6VXLutgIWlP9outS8Gcg"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"first mm message"},"depth":42,"prev_state":[],"origin":"localhost","origin_server_ts":1672312535871,"hashes":{"sha256":"CWP5sxIEk176w1bnWXy7MKU6PyyZK8eblHpPC+dx9lk"},"signatures":{"localhost":{"ed25519:a_CHdg":"N5baw2kH4V7tO74MU0XB8pnmTiJEXcyidT8a9+S3uIxAGlbUvHflFAw4GzrAv4vdZVUULpPUDsl/E4sQQy0GAA"}},"unsigned":{"age_ts":1672312535871}}	3
$TbzKCcECXvJAKvBu5GZCTLIGi7Js0b1w9dE6KKZXaKo	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$aaPR9QI7az6NxeJ0hSrQxyKzzVyM-rBWODbN9y9rM9Q"],"prev_events":["$aaPR9QI7az6NxeJ0hSrQxyKzzVyM-rBWODbN9y9rM9Q"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"depth":43,"prev_state":[],"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1672308592135,"hashes":{"sha256":"vmcQ8jXAZse/RQ0YKqsoEJPweLOQlsuuvDmxIlBNpOk"},"signatures":{"localhost":{"ed25519:a_CHdg":"jigBd1kRmu/grvzHxhSVFAIZKDDmG3RAn6ngybY81aAcZ3Nv7Vu4SzpqkV00sTnTBNOJ89ICCUVvodEJppXFAw"}},"unsigned":{"age_ts":1672308592135,"replaces_state":"$aaPR9QI7az6NxeJ0hSrQxyKzzVyM-rBWODbN9y9rM9Q"}}	3
$XhzyXIYIbI0BfDV1QY4H3b4Wrpy5pJgJsGNZc8P8seg	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$EklY0FV28pDgoXqwoQUjAB5wTv33O8RCHRE8k2k6o2c","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$2-SFwejONuAnI3cUJ4UN3FSzzJjeIWUURtWOJiO2sWo"],"prev_events":["$72MNMNMOJMJpfLbdNKdm6ZXGr14ukIKdq-fG2OvzOqg"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"MattermostUser A [mm]"},"depth":38,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672308593138,"hashes":{"sha256":"naA70MqT/wl2xtavj5x6xKwYMsKgSdzCkmxCzBl7weQ"},"signatures":{"localhost":{"ed25519:a_CHdg":"HqP7J/V1Jr1yfbXl6LWDYnMAY7SZ/hd5DKEP6DH8NU7gVsf6XjIfhKMhXqrwWk+PY6HDxQsZXvT5HHl8/v+gAg"}},"unsigned":{"age_ts":1672308593138,"replaces_state":"$EklY0FV28pDgoXqwoQUjAB5wTv33O8RCHRE8k2k6o2c","invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#town-square:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$M2xNoGVeTRazjk5EjiA0u3mOkneK7za9KWYn2LMJFwA	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$jL60Q94H_SC7S4ZFOWkA4RilDwTMIUci2DyEXyQS_t0","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_b:localhost","content":{"membership":"leave"},"depth":62,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672314817085,"hashes":{"sha256":"RMZc+XAeDIuwgiHOTDAljtQjAf+8EgTsfeyUo2phquY"},"signatures":{"localhost":{"ed25519:a_CHdg":"qBFwWLia1YVWw/d2RyeQ8VPZcF/91z2mDRgQNcXqa6qHF1/5NSBbfnTKeUX0vQeNxQWkb5D4jLb/KIzr4v10CA"}},"unsigned":{"age_ts":1672314817085,"replaces_state":"$jL60Q94H_SC7S4ZFOWkA4RilDwTMIUci2DyEXyQS_t0"}}	3
$ggRHO4QwGg8SLwSXlSNnHypSBsgj2jFMUXbjC7U97qM	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$SLqtTg1DQZU0Y4ezk90kDHz7IxD9TXjhW4qQAoPUfTk","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$JgtV2Jrt_3Cws_oeqEte6xeUnTbTSMu0pBPrEWD4WyM"],"prev_events":["$qgyz1sVriFBiepR7YLOpA_tcnRjhDX9q13fkeJa8i3U"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"MattermostUser A [mm]"},"depth":67,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672314819392,"hashes":{"sha256":"826VISk8h6MYWatNzvNSw5ibri/GNVc8igWjjK6DAX0"},"signatures":{"localhost":{"ed25519:a_CHdg":"G/4X+h55rLmDL+BDEnCbLYjpaZbUIMOFnG1VXSDlVrkVC2rFvwWAumtquddgBxkzIqGBBV5OX3V7DiioqmrEBA"}},"unsigned":{"age_ts":1672314819392,"replaces_state":"$SLqtTg1DQZU0Y4ezk90kDHz7IxD9TXjhW4qQAoPUfTk","invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#off-topic:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$m8QuIxNBjngQA1UhDPZlw6nIvodE764mdmYG9oCKf94	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672314829710.0","historical":false}	{"auth_events":["$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"test"},"depth":59,"prev_state":[],"origin":"localhost","origin_server_ts":1672314829737,"hashes":{"sha256":"BhotRnxDrLq71IvEqdp/y1LxEIar3/uSGNz6qjjEUkg"},"signatures":{"localhost":{"ed25519:a_CHdg":"dkDbIwCPHSzjgS/omQ1JIxMQbIjPxqwjcAPyNZGcmBzWw1ZzK6KbNxCU9nWhDqF7mPJ80pP6aKY95I7+XxJgCg"}},"unsigned":{"age_ts":1672314829737}}	3
$RuT3uWLcY4y4GhqYFFNXur6XuNwXipRRmx5rJFfM9ms	!dKcbdDATuwwphjRPQP:localhost	{"txn_id":"m1672314834045.2","historical":false}	{"auth_events":["$ewJTQJq2XdLvkqYVULlUmmJ-A3LQ6Jnqs4GDYi6q0DE","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$ewJTQJq2XdLvkqYVULlUmmJ-A3LQ6Jnqs4GDYi6q0DE"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.emote","body":"hi me"},"depth":70,"prev_state":[],"origin":"localhost","origin_server_ts":1672314834068,"hashes":{"sha256":"6bttI2WFqHaLP26BcawEPaDzOXDeawlInu/s1G1w7Dg"},"signatures":{"localhost":{"ed25519:a_CHdg":"QjoTZB7UirT5bpyBcoRlt+07MK1xCJ/+9TIng13NrFcb4ped9XQqEnSp/BdzHWEgOL9IEWFrepz4NbyrgZS1CQ"}},"unsigned":{"age_ts":1672314834068}}	3
$sPW_-g3Oq09Bq8Rm-TKPTRO4HHOlMXEni0rE18Y01h4	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$EB67Xwo9B0__CxNTvptFIy4e4vG93cmEcHRWbiVSFJU","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$jL60Q94H_SC7S4ZFOWkA4RilDwTMIUci2DyEXyQS_t0"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_a:localhost","content":{"membership":"join","displayname":"MattermostUser A [mm]"},"depth":47,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672308593684,"hashes":{"sha256":"rfnqtlzInErKWJ3VGFpHk8HBEN4UwBgIZ2MQR+zGK8E"},"signatures":{"localhost":{"ed25519:a_CHdg":"jp3YhGpnduucLZEhGu/87RfJ4rw7GCOxc3zUSZZcN+VjGZQEMs0Sg3qpcOO2dh7de6b7pJ7mrf0PV8t96vu7BQ"}},"unsigned":{"age_ts":1672308593684,"replaces_state":"$EB67Xwo9B0__CxNTvptFIy4e4vG93cmEcHRWbiVSFJU"}}	3
$A5qbTNFuQ1MZL2fuT4oUFzi1xCHHDk0NuQZstoz4u-U	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672312690692.0","historical":false}	{"auth_events":["$0EmcDbHM6t0AJ7YKAcphqL8othdZg4dIXSazEHvnCno","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$sPW_-g3Oq09Bq8Rm-TKPTRO4HHOlMXEni0rE18Y01h4"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"first matrix message"},"depth":48,"prev_state":[],"origin":"localhost","origin_server_ts":1672312690722,"hashes":{"sha256":"WFVLcGJIPZBovhMIzvFizuy4LvdGijXpATFLxojbaFQ"},"signatures":{"localhost":{"ed25519:a_CHdg":"zw4dORlyT5YC7CfQJu90uQIU36BhzcqGYv6gTKHy0Iejwozac7qgEeQqKYnhuywt4rYsO7ZcOz1D+XxMxrpPDw"}},"unsigned":{"age_ts":1672312690722}}	3
$jhFoiytsqlLXRCkoL5gH2sXpQQJFwk3XLtzQPCpA0K8	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672312692940.0","historical":false}	{"auth_events":["$0EmcDbHM6t0AJ7YKAcphqL8othdZg4dIXSazEHvnCno","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$2xt0-DVGoBAEL-GIwj9HZfHBCQu7_M-HzB2XaEfxjwM"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"root message"},"depth":51,"prev_state":[],"origin":"localhost","origin_server_ts":1672312692993,"hashes":{"sha256":"7g9hPwLP4/ZjP10oy6yM+a0a1n+CO/HSFAeXVBcFaOM"},"signatures":{"localhost":{"ed25519:a_CHdg":"EFL8Mv694Bp39H71C7+oCJF78bUs+LCjmfF1Vfv//odVLyUlWq80vbjYoVqxmULJ2hhExwJneo724J0fDHBRAw"}},"unsigned":{"age_ts":1672312692993}}	3
$0ClPrn0jv_hdCQB4TqbWVPUxxSqFeDViCsOjYwQVDAg	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$19Wa_uoHXFwHicMPIWHRa1c8H1yIjgzKxpDzo89CTTE","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$Qyk1jqM8wu6uOaEDEalSs_0hepeq6CnfZZRy1hQ4sd8"],"prev_events":["$ZLuzCoh1UZ9oNHYyBNCtneq81TelpJ882dsDdio0oKU"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"MattermostUser A [mm]"},"depth":56,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672314819459,"hashes":{"sha256":"2Oq+tge9DpMbJ9+kPWXD7xhgjS6MvpXdgcyUcuN70PE"},"signatures":{"localhost":{"ed25519:a_CHdg":"Y03uxPHum5ujKTir7tfaU9FDMhWGO5G8hL3dQfwZypxsQRjbgWHoaWoNflOYJ1ryjupoPf3fqW1Jtg73lhzBAg"}},"unsigned":{"age_ts":1672314819459,"replaces_state":"$19Wa_uoHXFwHicMPIWHRa1c8H1yIjgzKxpDzo89CTTE","invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#town-square:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$kkmwTP1mOPGymh7Q3_N1Y7ftC1xrv5qaHbV_zi99vD4	!dKcbdDATuwwphjRPQP:localhost	{"txn_id":"m1672314834628.1","historical":false}	{"auth_events":["$Zv-9wNEnjnF-VeZtZKtHkYObGhccwLKewNnJg-fUiF8","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$iVV3o47Y40f29uNsCktD5R1VKbTF1y3nGq4KSKQ5YYo"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_b:localhost","content":{"msgtype":"m.file","body":"filename","url":"mxc://localhost/EEnSOhlMqCJzCjOgkbSaZLSQ","info":{"mimetype":"","size":11}},"depth":72,"prev_state":[],"origin":"localhost","origin_server_ts":1672314834658,"hashes":{"sha256":"9HfIf38ebQFTW2DFN15xV64xoRhhXylZmXinN2PDyrw"},"signatures":{"localhost":{"ed25519:a_CHdg":"7CaLmyrFa5r5q853EitR5ztuxqOLNiX2GbQt1VGHll6VnKNMpFcxy9+dDLQm9cLIFQ0i0fOC7F5Ecy5J2EOJBQ"}},"unsigned":{"age_ts":1672314834658}}	3
$lQM-XkcgjA40yc1T7BNzbZ8V8yxcnsj23SxrixdEev8	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672312536113.0","historical":false}	{"auth_events":["$85g2ma_sFrYS8UbhpRwYEglJLj7xswd8VgNCg787_3E","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$j4OmrTBgGXlAg2ui751-jxTS4uMSPCzpj81xWRfOWiA"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_b:localhost","content":{"msgtype":"m.text","body":"> <@mm_mattermost_a:localhost> first mm message\\n\\nsecond mm message","m.relates_to":{"m.in_reply_to":{"event_id":"$j4OmrTBgGXlAg2ui751-jxTS4uMSPCzpj81xWRfOWiA"}},"formatted_body":"<mx-reply><blockquote><a href=\\"https://matrix.to/#/!kmbTYjjsDRDHGgVqUP:localhost/$j4OmrTBgGXlAg2ui751-jxTS4uMSPCzpj81xWRfOWiA?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@mm_mattermost_a:localhost\\">@mm_mattermost_a:localhost</a><br>first mm message</blockquote></mx-reply>second mm message","format":"org.matrix.custom.html"},"depth":43,"prev_state":[],"origin":"localhost","origin_server_ts":1672312536151,"hashes":{"sha256":"8qTeeOvg/ETosyehOjg+l6eTjXBCKUJ05rA+220rUsw"},"signatures":{"localhost":{"ed25519:a_CHdg":"gGeUl7t+5ydm159qY5zzPkkmHBudRr4fObQXitqGan85V058g4vc74RzIIR+tryLaQYZIHRcIgV0wfa/CykqBw"}},"unsigned":{"age_ts":1672312536151}}	3
$FNOekiMLFE4AEgQ1st7kiouCRAYO3DKEMbrYHGbH-zw	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$HVWinlm6AKNeOld7iV_yqdfmpznmG5wAyWK5k3xjM7Y","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$HVWinlm6AKNeOld7iV_yqdfmpznmG5wAyWK5k3xjM7Y"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_a:localhost","content":{"membership":"join","displayname":"MattermostUser A [mm]"},"depth":57,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672314814778,"hashes":{"sha256":"bZznqxIYNG4zATulzNWnJZLQLP73uPOgg/8KcOVEzBQ"},"signatures":{"localhost":{"ed25519:a_CHdg":"2XjhryQ5E8qc+bxi9ZMsnoLcAvKKTlU/WUvtV2PN9rEmznHEolhZ7cXGsfM3jIL261yLCzEmKRDl9B1F1dXmAw"}},"unsigned":{"age_ts":1672314814778,"replaces_state":"$HVWinlm6AKNeOld7iV_yqdfmpznmG5wAyWK5k3xjM7Y"}}	3
$6ZYuUr8K6uh0D7tl9-HD___6hQH3lj8qU1liF0zAkmo	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$2-SFwejONuAnI3cUJ4UN3FSzzJjeIWUURtWOJiO2sWo"],"prev_events":["$lDJnxY-YfTRyXQcBLRlbFT2_w4DXO4Pks75YGGa5M5o"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"leave"},"depth":53,"prev_state":[],"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1672314817648,"hashes":{"sha256":"yyFZDnBzlQPcLb9S6WhdH2sfBC0nvNPrN0OAjxFnJmI"},"signatures":{"localhost":{"ed25519:a_CHdg":"lHlpuKuswAmiWrv8mZeF9LEiY39cjpJ/fHKahD6UAwMLVt7LCmcZCovgtwKyzFtwMlXnhKrBLhmxXRVaRoQOCQ"}},"unsigned":{"age_ts":1672314817648,"replaces_state":"$2-SFwejONuAnI3cUJ4UN3FSzzJjeIWUURtWOJiO2sWo"}}	3
$2xt0-DVGoBAEL-GIwj9HZfHBCQu7_M-HzB2XaEfxjwM	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672312690956.1","historical":false}	{"auth_events":["$0EmcDbHM6t0AJ7YKAcphqL8othdZg4dIXSazEHvnCno","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$kMqJ62yuvBi4RWfOiLMiPcoSKbfcjZvTwwiuRRmfEKA"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"> <@matrix_b> > <@matrix_a>\\n\\nthird matrix message","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>third matrix message","m.relates_to":{"m.in_reply_to":{"event_id":"$kMqJ62yuvBi4RWfOiLMiPcoSKbfcjZvTwwiuRRmfEKA"}}},"depth":50,"prev_state":[],"origin":"localhost","origin_server_ts":1672312691040,"hashes":{"sha256":"8a71ggSfuLlt7cq/gZa5Dx2ga6xyW6vfIu6VBaeuO1s"},"signatures":{"localhost":{"ed25519:a_CHdg":"bJQk5gwJFQAtGdBZyA+J6Z0jlCl2o9JpaXTKG+Y1FC08ZoJEfIgySWdHBsMOuvjMB2OInD/jVmj/LHhPujnGAw"}},"unsigned":{"age_ts":1672312691040}}	3
$ewJTQJq2XdLvkqYVULlUmmJ-A3LQ6Jnqs4GDYi6q0DE	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$ggRHO4QwGg8SLwSXlSNnHypSBsgj2jFMUXbjC7U97qM","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$Zv-9wNEnjnF-VeZtZKtHkYObGhccwLKewNnJg-fUiF8"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_a:localhost","content":{"membership":"join","displayname":"MattermostUser A [mm]"},"depth":69,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672314819789,"hashes":{"sha256":"bfrL9ZkiA3IOVwZKAIFetd6u2AcWPoQl8KyEYwODA5s"},"signatures":{"localhost":{"ed25519:a_CHdg":"L7hcuNJShcYZ5YKi2tVXbWuUMOD5HbxUu6PWEp0s484HthKjxxbu5REY7FHbtKs7G7/175B9nAJAfYOnm/jmAw"}},"unsigned":{"age_ts":1672314819789,"replaces_state":"$ggRHO4QwGg8SLwSXlSNnHypSBsgj2jFMUXbjC7U97qM"}}	3
$kdWmWl1h_wHbp_4CZHM4AOF1I3SpjgbLYkYoFiWiazU	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":4,"txn_id":"m1672314833825.0","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk"],"prev_events":["$j_Vf4RSpugcR52JQthWyGuqRIEdGrETb4ZLvnGxwwg0"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_b:localhost","content":{"msgtype":"m.text","body":"random wrong message","format":"org.matrix.custom.html","formatted_body":"<h1>Header</h1><b>Bolded text</b>"},"depth":62,"prev_state":[],"origin":"localhost","origin_server_ts":1672314833853,"hashes":{"sha256":"cM71/4syL8yyX518tuEcfGxn2XXV4S9R3JeDLIJ/rM4"},"signatures":{"localhost":{"ed25519:a_CHdg":"xMvFb0IiRLC03Sz2M+GFZ6xSD1vVRaFxdQhpsxkDNoyqXANyaohsYFOTpvpxIwQq3WGo89Ojb6A/nxjAgJcvCA"}},"unsigned":{"age_ts":1672314833853}}	3
$UD0jEJtVKXhlCRf7VxHITWSUyhzaGkpH0VGbwilf2RE	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":4,"txn_id":"m1672312691752.0","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk"],"prev_events":["$6CT_ZCazUgJysnWN-q2s4b5iR-x1EbXa932nBRpldW4"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_b:localhost","content":{"msgtype":"m.text","body":"whatever","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>second message","m.relates_to":{"m.in_reply_to":{"event_id":"$6CT_ZCazUgJysnWN-q2s4b5iR-x1EbXa932nBRpldW4"}}},"depth":46,"prev_state":[],"origin":"localhost","origin_server_ts":1672312691855,"hashes":{"sha256":"pC0mxW+CWxRP3Z9Ynh/QRVRuppzVGNDrszSSkfZgnHQ"},"signatures":{"localhost":{"ed25519:a_CHdg":"zl6XzWMV6j2zGEhZ3floh0vOe3jzBwDHAwCrNttNxRawUP5hbG54zthbWRe54FalaXRy73ASMtgXP+FwGsPCBA"}},"unsigned":{"age_ts":1672312691855}}	3
$-R5ZDLwPtIisO-W746dPRRrr1U6HjM8uhC78Zh95UUQ	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":3,"historical":false}	{"auth_events":["$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$WcPnOWvRmgShLlAe8RxY4-_M71l0auS5ykpKdmUS0LU","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$WcPnOWvRmgShLlAe8RxY4-_M71l0auS5ykpKdmUS0LU"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_a:localhost","content":{"membership":"join","displayname":"Matrix UserA"},"depth":50,"prev_state":[],"state_key":"@matrix_a:localhost","origin":"localhost","origin_server_ts":1672314815909,"hashes":{"sha256":"t3rXF+8/F/UmdVXY4FIoKOj/WqZWWP+Ncq5MGyOXvxY"},"signatures":{"localhost":{"ed25519:a_CHdg":"PoNqneH8IRg2jblujvFnJafHsZ+/gMmiIROxJgY7qleywdb5o56llBMojCfmIEKHN6nGt7LUce0waFR3LMmnBQ"}},"unsigned":{"age_ts":1672314815909,"replaces_state":"$WcPnOWvRmgShLlAe8RxY4-_M71l0auS5ykpKdmUS0LU"}}	3
$19Wa_uoHXFwHicMPIWHRa1c8H1yIjgzKxpDzo89CTTE	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$WPbDUZRE7W6o_O4D0qf40PxoXNWcHrBwx3LxCA_ILaY","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$-R5ZDLwPtIisO-W746dPRRrr1U6HjM8uhC78Zh95UUQ"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"membership":"leave"},"depth":51,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672314817098,"hashes":{"sha256":"7nYHYFL5b+Jzxk70d3hDqZ/7bd5wLOOxJA2SEuyGynQ"},"signatures":{"localhost":{"ed25519:a_CHdg":"yVLyaRV1d65HH5PijDY1m8q6bwi7KLCSCzieMLS/mWHRaxYD6+Fkb1NQaESoxyDV9ATZYaldvU8PZ3O8bjfMCA"}},"unsigned":{"age_ts":1672314817098,"replaces_state":"$WPbDUZRE7W6o_O4D0qf40PxoXNWcHrBwx3LxCA_ILaY"}}	3
$Qyk1jqM8wu6uOaEDEalSs_0hepeq6CnfZZRy1hQ4sd8	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$6ZYuUr8K6uh0D7tl9-HD___6hQH3lj8qU1liF0zAkmo"],"prev_events":["$6ZYuUr8K6uh0D7tl9-HD___6hQH3lj8qU1liF0zAkmo"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"depth":54,"prev_state":[],"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1672314818348,"hashes":{"sha256":"h2nH41xilXPm2riCjlUlMBS+kdBEJRNNdEeRR7ADjLM"},"signatures":{"localhost":{"ed25519:a_CHdg":"dGsLVWGSbrtk/AUS4zQzkZm6rO/+aq0hoiIlPLPgzryYSso5NfmjUuVLX8LtS+G4XGhG0g9aC1zA/rFzekc0BA"}},"unsigned":{"age_ts":1672314818348,"replaces_state":"$6ZYuUr8K6uh0D7tl9-HD___6hQH3lj8qU1liF0zAkmo"}}	3
$qgyz1sVriFBiepR7YLOpA_tcnRjhDX9q13fkeJa8i3U	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$M2xNoGVeTRazjk5EjiA0u3mOkneK7za9KWYn2LMJFwA","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$JgtV2Jrt_3Cws_oeqEte6xeUnTbTSMu0pBPrEWD4WyM"],"prev_events":["$JgtV2Jrt_3Cws_oeqEte6xeUnTbTSMu0pBPrEWD4WyM"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"mattermost_b [mm]"},"depth":66,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672314819175,"hashes":{"sha256":"W/sKb4a/Et9VbxtH6N8Hhtc1fG5l/XpPnTJwYF56pDc"},"signatures":{"localhost":{"ed25519:a_CHdg":"pUNUc3xvj7Cmt+Wm40Ayd7L0euAyosKRn6KB/vCffhE+zeesZyUeFPqkG0DUo6lj8gK+ZEKBuGBwlbz5clCPBg"}},"unsigned":{"age_ts":1672314819175,"replaces_state":"$M2xNoGVeTRazjk5EjiA0u3mOkneK7za9KWYn2LMJFwA","invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#off-topic:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$j_Vf4RSpugcR52JQthWyGuqRIEdGrETb4ZLvnGxwwg0	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672314833619.1","historical":false}	{"auth_events":["$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$mjUbm6eO9Jk-i6bqdyRHFZy9L-lH5TOO27GYMQ87nhs"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"# Header\\n\\n**bold**","format":"org.matrix.custom.html","formatted_body":"<h1>Header</h1><strong>bold</strong>"},"depth":61,"prev_state":[],"origin":"localhost","origin_server_ts":1672314833650,"hashes":{"sha256":"ZQ6vUVvLd4GhjWA3p7TIwpm6/FVVPQEksR/idJFxOXI"},"signatures":{"localhost":{"ed25519:a_CHdg":"djVZ8Mz6pAkfdqZJamr7uGgFJWXryksZTZGLM3U/bA4RlkEGkJmK3xrCl6p2KQ+RiKfH/DLPHvwobpxfl9bpAA"}},"unsigned":{"age_ts":1672314833650}}	3
$iVV3o47Y40f29uNsCktD5R1VKbTF1y3nGq4KSKQ5YYo	!dKcbdDATuwwphjRPQP:localhost	{"txn_id":"m1672314834472.0","historical":false}	{"auth_events":["$Zv-9wNEnjnF-VeZtZKtHkYObGhccwLKewNnJg-fUiF8","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$RuT3uWLcY4y4GhqYFFNXur6XuNwXipRRmx5rJFfM9ms"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_b:localhost","content":{"msgtype":"m.text","body":"filename"},"depth":71,"prev_state":[],"origin":"localhost","origin_server_ts":1672314834507,"hashes":{"sha256":"HdEOGtDOHQcUiDem0544JGCHpI3/GLVwnOQldb5vk+E"},"signatures":{"localhost":{"ed25519:a_CHdg":"pKbtcB/l7ck/adb3lBxSvEgmM500/EbnuFaG33vVXADP0DEtNeh/6Si+l1qhMjDpJA8LYq+/Ys+YPQ5fcl+JDg"}},"unsigned":{"age_ts":1672314834507}}	3
$BMnLymfijfp2V1tH1M6Nayfx-iF_rRw70COW60dCBG0	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672312692402.3","historical":false}	{"auth_events":["$WPbDUZRE7W6o_O4D0qf40PxoXNWcHrBwx3LxCA_ILaY","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$UD0jEJtVKXhlCRf7VxHITWSUyhzaGkpH0VGbwilf2RE"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"> <@matrix_b:localhost> whatever\\n\\nthird message","m.relates_to":{"m.in_reply_to":{"event_id":"$UD0jEJtVKXhlCRf7VxHITWSUyhzaGkpH0VGbwilf2RE"}},"formatted_body":"<mx-reply><blockquote><a href=\\"https://matrix.to/#/!kmbTYjjsDRDHGgVqUP:localhost/$UD0jEJtVKXhlCRf7VxHITWSUyhzaGkpH0VGbwilf2RE?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@matrix_b:localhost\\">@matrix_b:localhost</a><br><mx-reply>Dummy content</mx-reply>second message</blockquote></mx-reply>third message","format":"org.matrix.custom.html"},"depth":47,"prev_state":[],"origin":"localhost","origin_server_ts":1672312692473,"hashes":{"sha256":"c4DpP5pMPTSceGmOxYb1BkckBIRULUmstbcqiB7SkmI"},"signatures":{"localhost":{"ed25519:a_CHdg":"YgiZ2KBhxwZI7d9PtnWIFZYRywUELX5sbpMgv2ko/ttTT4OYH5fqJRbkjhNxl7ZfQEQTnJIe2+iGGTkHis/IDw"}},"unsigned":{"age_ts":1672312692473}}	3
$p2y4ivsQApKJEQKZQ-5KFk47veZlq7V00tHHrokVqK0	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672312693485.3","historical":false}	{"auth_events":["$0EmcDbHM6t0AJ7YKAcphqL8othdZg4dIXSazEHvnCno","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$wehc8FMA82xW0EU5F86ZkvsBra_SZ0JSA3Yweowv_s8"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"> <@matrix_a> reply message\\n\\nlast message","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>last message","m.relates_to":{"m.in_reply_to":{"event_id":"$UQr1C3BZK9MztXbBR2a0yz0wCyXSy_abmCstrHnXi2E"}}},"depth":54,"prev_state":[],"origin":"localhost","origin_server_ts":1672312693607,"hashes":{"sha256":"gH3d3a0fw7Q8tM9wmza2w6uP8hqk1myMDzO2RKFKTvA"},"signatures":{"localhost":{"ed25519:a_CHdg":"nygxQIYot95sMwCpb8PF8WNAhr5W6pX6hgikVnohX5zMI6SbG7ligLjifl56vvvae4yGVlz5kr6IahFf3pbRDg"}},"unsigned":{"age_ts":1672312693607}}	3
$VzxEyd-riDbZr-sdhUSEcA4h_6kWYfmSeoqEtaZHFFo	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672312696285.0","historical":false}	{"auth_events":["$WPbDUZRE7W6o_O4D0qf40PxoXNWcHrBwx3LxCA_ILaY","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$BMnLymfijfp2V1tH1M6Nayfx-iF_rRw70COW60dCBG0"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"new message"},"depth":48,"prev_state":[],"origin":"localhost","origin_server_ts":1672312696316,"hashes":{"sha256":"uzNv0fkf/oiY/dTOfmVt1d+3voB/ltxDDlBi7mWqU68"},"signatures":{"localhost":{"ed25519:a_CHdg":"SVAXHYjS2zydyhIeuoYFTqoEpCyXruDL1j9fvXoOi8VdSZLn9ne6rwFZXHFqoxt0MVtcZn7H8NLdCCpk/6flBQ"}},"unsigned":{"age_ts":1672312696316}}	3
$BtKmdXlHyT65KPvPIiDSk38oldbOKOUbuv7J13Up4wE	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$sPW_-g3Oq09Bq8Rm-TKPTRO4HHOlMXEni0rE18Y01h4","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$p2y4ivsQApKJEQKZQ-5KFk47veZlq7V00tHHrokVqK0"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_a:localhost","content":{"membership":"leave"},"depth":55,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672314814370,"hashes":{"sha256":"BA7um4vuOMbmJyYtLpwKJ3NSCrqvuaLObFSBdB8SrhY"},"signatures":{"localhost":{"ed25519:a_CHdg":"VeICauc+JCYsyvnj6p3+rVtfjoVF6fGMHmX0UkyQgVHghn5wGFsIIhx4d2AbESmeNMWpxePgb158WuBMwfBpAg"}},"unsigned":{"age_ts":1672314814370,"replaces_state":"$sPW_-g3Oq09Bq8Rm-TKPTRO4HHOlMXEni0rE18Y01h4"}}	3
$HVWinlm6AKNeOld7iV_yqdfmpznmG5wAyWK5k3xjM7Y	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$BtKmdXlHyT65KPvPIiDSk38oldbOKOUbuv7J13Up4wE","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$TbzKCcECXvJAKvBu5GZCTLIGi7Js0b1w9dE6KKZXaKo"],"prev_events":["$BtKmdXlHyT65KPvPIiDSk38oldbOKOUbuv7J13Up4wE"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"MattermostUser A [mm]"},"depth":56,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672314814639,"hashes":{"sha256":"AlIqqMfZ5ziaTpLruXBq8/kiRDC/NEddvWAUij6t1kk"},"signatures":{"localhost":{"ed25519:a_CHdg":"uia3/d3mmXUQYe+AuZv1kA35xx+57mnIhTsTumE8XeT7I3XLk2+qI0iAB5j2QiGooHRl2LHxGmp9KkyqNm42Bg"}},"unsigned":{"age_ts":1672314814639,"replaces_state":"$BtKmdXlHyT65KPvPIiDSk38oldbOKOUbuv7J13Up4wE","invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#off-topic:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$aa2-bg9KcCtrn4nE5HK1JGC6sa8Gr7jWqLhPgLQTtsU	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$ZLuzCoh1UZ9oNHYyBNCtneq81TelpJ882dsDdio0oKU","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$0ClPrn0jv_hdCQB4TqbWVPUxxSqFeDViCsOjYwQVDAg"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_b:localhost","content":{"membership":"join","displayname":"mattermost_b [mm]"},"depth":57,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672314819666,"hashes":{"sha256":"xH8JXc1BsgvmT6ZzPVwf+p3cH0QPZlvkOfFJ1MAybEs"},"signatures":{"localhost":{"ed25519:a_CHdg":"9JIDjWoUwz/XSvXVvnQBWmNGkJLtbOYAip3LMP9CHR+Ie/BwirOcmdBG6NASc3Q1PmYH+0UIxghx9O8EtyPcBg"}},"unsigned":{"age_ts":1672314819666,"replaces_state":"$ZLuzCoh1UZ9oNHYyBNCtneq81TelpJ882dsDdio0oKU"}}	3
$99PDED6qRD6JvJgyuUpKL5SGciNeDx4Q8aNU8-knIfI	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":3,"txn_id":"m1672314834969.0","historical":false}	{"auth_events":["$-R5ZDLwPtIisO-W746dPRRrr1U6HjM8uhC78Zh95UUQ","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$sD72WUGTkmqfbvA4mcCNx5IcT-WfbmjsGalYB6V6S-E"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.file","body":"mydata","url":"mxc://localhost/hPLBTbnUBGBfWfltvwMyRdqa","info":{"mimetype":"text/plain"}},"depth":64,"prev_state":[],"origin":"localhost","origin_server_ts":1672314835018,"hashes":{"sha256":"CkzLgFOSYpx14y+PSJrps6g4BmNuI9CNlUXKgGSEoJg"},"signatures":{"localhost":{"ed25519:a_CHdg":"UXU6ZRmOctx+hko4n6iiVMxgSiUtupI0XBeU4yUy1An7X/iPiQj7l7M7wwsrgHE4GiBop05KfG4wd77SVA6SAg"}},"unsigned":{"age_ts":1672314835018}}	3
$56oOQ2hizWAJWWKoJTMYGwAKX_gaANdZg2QHgtC63ZE	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"historical":false}	{"auth_events":["$0EmcDbHM6t0AJ7YKAcphqL8othdZg4dIXSazEHvnCno","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$FNOekiMLFE4AEgQ1st7kiouCRAYO3DKEMbrYHGbH-zw"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"membership":"leave"},"depth":58,"prev_state":[],"state_key":"@matrix_a:localhost","origin":"localhost","origin_server_ts":1672314814937,"hashes":{"sha256":"cqRVFrCZvP+Q93o9dgNW7a6eBJo0X4eOAl+Ne3iOVdA"},"signatures":{"localhost":{"ed25519:a_CHdg":"/454V7elAhke9f95jrckpRYm+jBM9zYSDLexPr8jy12XLb1U58P5q/jA0tcloHRCvpnBwr1P0RqBucOkO3Q1CA"}},"unsigned":{"age_ts":1672314814937,"replaces_state":"$0EmcDbHM6t0AJ7YKAcphqL8othdZg4dIXSazEHvnCno"}}	3
$6Sy4DU04a_WCzalQkimJ_l9-eYsJ3kcn3Lat9w42L2I	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"historical":false}	{"auth_events":["$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$56oOQ2hizWAJWWKoJTMYGwAKX_gaANdZg2QHgtC63ZE","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$56oOQ2hizWAJWWKoJTMYGwAKX_gaANdZg2QHgtC63ZE"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"membership":"join","displayname":"Matrix UserA"},"depth":59,"prev_state":[],"state_key":"@matrix_a:localhost","origin":"localhost","origin_server_ts":1672314815191,"hashes":{"sha256":"pMYn3ctX6A3iPnoJ8mhGAo3MXFJCURjZgOdEf4Fz7X4"},"signatures":{"localhost":{"ed25519:a_CHdg":"VOMHorvFSGkdkQcU6Z2OAGQyeQ9UaL0BLhen6T2XvADSvoIt57SCEsGVZI96Ska08Fhi6sSxDPjGSZdJ1WU8Dw"}},"unsigned":{"age_ts":1672314815191,"replaces_state":"$56oOQ2hizWAJWWKoJTMYGwAKX_gaANdZg2QHgtC63ZE"}}	3
$FC2J9PSIQLoF8YJo6zY2dP8Eo55L8CPgzVGN7iaofRo	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"historical":false}	{"auth_events":["$6Sy4DU04a_WCzalQkimJ_l9-eYsJ3kcn3Lat9w42L2I","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$6Sy4DU04a_WCzalQkimJ_l9-eYsJ3kcn3Lat9w42L2I"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"membership":"leave"},"depth":60,"prev_state":[],"state_key":"@matrix_a:localhost","origin":"localhost","origin_server_ts":1672314815441,"hashes":{"sha256":"TOvvr+Tf0J9q3nSE8uRCGv6brkv77SUInDGA43MNQtY"},"signatures":{"localhost":{"ed25519:a_CHdg":"ztKznuI0/8uPeojCDHxPuWaLCS9mmAxuAAdsI/4erXZgCBnmKVJ8LOaGwRL/Lg2qYq2dtrZkmN4oxKTXE5f/Dw"}},"unsigned":{"age_ts":1672314815441,"replaces_state":"$6Sy4DU04a_WCzalQkimJ_l9-eYsJ3kcn3Lat9w42L2I"}}	3
$WcPnOWvRmgShLlAe8RxY4-_M71l0auS5ykpKdmUS0LU	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":3,"historical":false}	{"auth_events":["$4KgY7ivi_pp1q2tjdk7IWENjs1kzgSRLB29nKbq-UXw","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$VzxEyd-riDbZr-sdhUSEcA4h_6kWYfmSeoqEtaZHFFo"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_a:localhost","content":{"membership":"leave"},"depth":49,"prev_state":[],"state_key":"@matrix_a:localhost","origin":"localhost","origin_server_ts":1672314815648,"hashes":{"sha256":"2LxsS4kxAHy3rcQgfRwx3rhv4+YTHCKm32I1a0GCOrg"},"signatures":{"localhost":{"ed25519:a_CHdg":"J+9D3xjSE1CJ2Ti8I73B/RR7ndKCYRLgAozycO3j7uSKaUqdEajs/v+Su+PXGqUtNqwSSem3FWKRhb+sEfQABg"}},"unsigned":{"age_ts":1672314815648,"replaces_state":"$4KgY7ivi_pp1q2tjdk7IWENjs1kzgSRLB29nKbq-UXw"}}	3
$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"historical":false}	{"auth_events":["$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$FC2J9PSIQLoF8YJo6zY2dP8Eo55L8CPgzVGN7iaofRo","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$FC2J9PSIQLoF8YJo6zY2dP8Eo55L8CPgzVGN7iaofRo"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"membership":"join","displayname":"Matrix UserA"},"depth":61,"prev_state":[],"state_key":"@matrix_a:localhost","origin":"localhost","origin_server_ts":1672314816398,"hashes":{"sha256":"m5d1TqhtJb8mggt9UZhEehqrJT5FOuzRXqsW3ZWqyyE"},"signatures":{"localhost":{"ed25519:a_CHdg":"n4sBVeHYNjAXqRPFvZ1v/eUmhVxlcRd+4V+396Nzhq5CIkTCvqmCDqQxp/YtbEsyXhXTWINGDtdTCmpUdiNGAA"}},"unsigned":{"age_ts":1672314816398,"replaces_state":"$FC2J9PSIQLoF8YJo6zY2dP8Eo55L8CPgzVGN7iaofRo"}}	3
$ZLuzCoh1UZ9oNHYyBNCtneq81TelpJ882dsDdio0oKU	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$lDJnxY-YfTRyXQcBLRlbFT2_w4DXO4Pks75YGGa5M5o","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$Qyk1jqM8wu6uOaEDEalSs_0hepeq6CnfZZRy1hQ4sd8"],"prev_events":["$Qyk1jqM8wu6uOaEDEalSs_0hepeq6CnfZZRy1hQ4sd8"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"mattermost_b [mm]"},"depth":55,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672314819213,"hashes":{"sha256":"swrP673qj9AOA6yqLE0h2AyUTgxlasGay58reY0AiIA"},"signatures":{"localhost":{"ed25519:a_CHdg":"+r/q56Yq/HV3qsRiF2+FP1K4O66Pq9pgEtVsDwcqgbAfkCb3Zoa/qML/rUpWrntmqOhk88OB/p41h5koXJuPCA"}},"unsigned":{"age_ts":1672314819213,"replaces_state":"$lDJnxY-YfTRyXQcBLRlbFT2_w4DXO4Pks75YGGa5M5o","invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#town-square:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$Zv-9wNEnjnF-VeZtZKtHkYObGhccwLKewNnJg-fUiF8	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$qgyz1sVriFBiepR7YLOpA_tcnRjhDX9q13fkeJa8i3U","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$ggRHO4QwGg8SLwSXlSNnHypSBsgj2jFMUXbjC7U97qM"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_b:localhost","content":{"membership":"join","displayname":"mattermost_b [mm]"},"depth":68,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672314819642,"hashes":{"sha256":"a1io6VLGN1t8nUJonzNZLzKxgCnW9Tvhq9qGBmOTe6s"},"signatures":{"localhost":{"ed25519:a_CHdg":"9FVo+ygkdqDfoep+B/2NuvFiXb1EcSiBm5FEC2gjQO/yIL1OCjvGnENbXj/K4LW9XXkH/hJQvPdggoO+WOZSDg"}},"unsigned":{"age_ts":1672314819642,"replaces_state":"$qgyz1sVriFBiepR7YLOpA_tcnRjhDX9q13fkeJa8i3U"}}	3
$lDJnxY-YfTRyXQcBLRlbFT2_w4DXO4Pks75YGGa5M5o	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$85g2ma_sFrYS8UbhpRwYEglJLj7xswd8VgNCg787_3E","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$19Wa_uoHXFwHicMPIWHRa1c8H1yIjgzKxpDzo89CTTE"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_b:localhost","content":{"membership":"leave"},"depth":52,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1672314817354,"hashes":{"sha256":"Kdh5e5W6gNNmGQdGgSh2HoVKuTjhc/dBzMV7AGTgEfg"},"signatures":{"localhost":{"ed25519:a_CHdg":"/a6g76k9ezOOO2OVYOFJ4ibq3zKKoYixgsUb8vC+OwazKaI3+qMtsZECrHCBvfuqPslvJbcde8Ju/LnD7kVjBA"}},"unsigned":{"age_ts":1672314817354,"replaces_state":"$85g2ma_sFrYS8UbhpRwYEglJLj7xswd8VgNCg787_3E"}}	3
$t_tUn4wROpupdwEmZnXWQ-mtnx68XnGjofi61K92cRY	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$TbzKCcECXvJAKvBu5GZCTLIGi7Js0b1w9dE6KKZXaKo"],"prev_events":["$SLqtTg1DQZU0Y4ezk90kDHz7IxD9TXjhW4qQAoPUfTk"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"leave"},"depth":64,"prev_state":[],"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1672314817658,"hashes":{"sha256":"b8sFDzF3KLcpbtsb1+Jmhu27QdeExNJJ42LphKxfItQ"},"signatures":{"localhost":{"ed25519:a_CHdg":"gFsN6ZrCG7kpjwsFhUGDnOU/746Kb5k0rNrBmKHnWfn382DgpuhMA5NmE6wgfVEir7xTIBsJfqDAtoLX2dAPCg"}},"unsigned":{"age_ts":1672314817658,"replaces_state":"$TbzKCcECXvJAKvBu5GZCTLIGi7Js0b1w9dE6KKZXaKo"}}	3
$JgtV2Jrt_3Cws_oeqEte6xeUnTbTSMu0pBPrEWD4WyM	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$t_tUn4wROpupdwEmZnXWQ-mtnx68XnGjofi61K92cRY"],"prev_events":["$t_tUn4wROpupdwEmZnXWQ-mtnx68XnGjofi61K92cRY"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"depth":65,"prev_state":[],"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1672314818343,"hashes":{"sha256":"8ZhjbPR6HSYgQ6tHuUDLoadd2I5ShuphVo/bizwMVqU"},"signatures":{"localhost":{"ed25519:a_CHdg":"kxqhqpOIUa8ATdeO7BDteOKTAVZJQPRJs4jB4iLbZG0lyWUskM1nK87AcOeGkiZwy3kQVkRnDslomMz0YBjWCw"}},"unsigned":{"age_ts":1672314818343,"replaces_state":"$t_tUn4wROpupdwEmZnXWQ-mtnx68XnGjofi61K92cRY"}}	3
$SLqtTg1DQZU0Y4ezk90kDHz7IxD9TXjhW4qQAoPUfTk	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$FNOekiMLFE4AEgQ1st7kiouCRAYO3DKEMbrYHGbH-zw","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$M2xNoGVeTRazjk5EjiA0u3mOkneK7za9KWYn2LMJFwA"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_a:localhost","content":{"membership":"leave"},"depth":63,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672314817388,"hashes":{"sha256":"oQC357UEShZuN2VgAiUe8mxLxLqIZFtvgWDKFwVt/vU"},"signatures":{"localhost":{"ed25519:a_CHdg":"hJqliKghJutMz+DpVcCp28QrbaWkyQROn03XDWWJjKLH/kOFuRRNeeidxASAvQQNxGGvBHfz8x2mWNUo/zkTBg"}},"unsigned":{"age_ts":1672314817388,"replaces_state":"$FNOekiMLFE4AEgQ1st7kiouCRAYO3DKEMbrYHGbH-zw"}}	3
$mjUbm6eO9Jk-i6bqdyRHFZy9L-lH5TOO27GYMQ87nhs	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":3,"txn_id":"m1672314833209.0","historical":false}	{"auth_events":["$-R5ZDLwPtIisO-W746dPRRrr1U6HjM8uhC78Zh95UUQ","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$m8QuIxNBjngQA1UhDPZlw6nIvodE764mdmYG9oCKf94"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"test2"},"depth":60,"prev_state":[],"origin":"localhost","origin_server_ts":1672314833256,"hashes":{"sha256":"jMnlUGQac0fS4Aql7wwQ0RpW/kpcQwtnCsgAUurh+sY"},"signatures":{"localhost":{"ed25519:a_CHdg":"p71ExtZY3+Q0+Q74Lc+DuqtIXuPNrpXVB9ig7qqE7D8FRGW0S8YD0wZhUS3Ox8/GBKtrharqm/W8Od/HiYWUAQ"}},"unsigned":{"age_ts":1672314833256}}	3
$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$0ClPrn0jv_hdCQB4TqbWVPUxxSqFeDViCsOjYwQVDAg","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$aa2-bg9KcCtrn4nE5HK1JGC6sa8Gr7jWqLhPgLQTtsU"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"membership":"join","displayname":"MattermostUser A [mm]"},"depth":58,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1672314819878,"hashes":{"sha256":"BOrLwJWb0IhSRJFyWgdT1GHP1/t4pxPLDZ21i2+KLPY"},"signatures":{"localhost":{"ed25519:a_CHdg":"qwXcexo3SkUXh5UEkZcyjBMQBZsT+Hg3U47j43qgqglAIx6malnTjI6cRVMwQRc+4ap/RfSi+vtSKMI0ELN4Dg"}},"unsigned":{"age_ts":1672314819878,"replaces_state":"$0ClPrn0jv_hdCQB4TqbWVPUxxSqFeDViCsOjYwQVDAg"}}	3
$sD72WUGTkmqfbvA4mcCNx5IcT-WfbmjsGalYB6V6S-E	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":3,"txn_id":"m1672314834232.0","historical":false}	{"auth_events":["$-R5ZDLwPtIisO-W746dPRRrr1U6HjM8uhC78Zh95UUQ","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$kdWmWl1h_wHbp_4CZHM4AOF1I3SpjgbLYkYoFiWiazU"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.emote","body":"test"},"depth":63,"prev_state":[],"origin":"localhost","origin_server_ts":1672314834257,"hashes":{"sha256":"YyS6iApvuI83VFaovtwCVBa7HQ6CRzkf3OZ6JYq9NMY"},"signatures":{"localhost":{"ed25519:a_CHdg":"gzKNkJkuQBFt5pOZI4lKkorPxe+3fk2uZ4Z6aWftP7vJx1kuSTzTeIabX/YwBYcr+E+d3WMU5dDATkE9mosSDw"}},"unsigned":{"age_ts":1672314834257}}	3
$53rDO0S-X2QNPUyUVrTGx092yf0EW0nvJXQNLgQ09kc	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672314835267.0","historical":false}	{"auth_events":["$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$kkmwTP1mOPGymh7Q3_N1Y7ftC1xrv5qaHbV_zi99vD4"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"hidden message"},"depth":73,"prev_state":[],"origin":"localhost","origin_server_ts":1672314835302,"hashes":{"sha256":"etzJMY+KM6AIBQLNp4z05STS484laeEh7GHntVdp/3Q"},"signatures":{"localhost":{"ed25519:a_CHdg":"by6N3dOxeQY/AO3N47lRfnSiZqCg6rIPeW6LyuOx0MlV/dTzhh7ekCbKygSiqoKTOwlyD5qd0AzXJPYOyVFPDQ"}},"unsigned":{"age_ts":1672314835302}}	3
$OL5YFZuIzpeGWvQkJsWD5fA-_tqvM6MNM8aACLhDIKc	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672314857859.0","historical":false}	{"auth_events":["$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$99PDED6qRD6JvJgyuUpKL5SGciNeDx4Q8aNU8-knIfI"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"first mm message"},"depth":65,"prev_state":[],"origin":"localhost","origin_server_ts":1672314857885,"hashes":{"sha256":"v4lpq12qroWHz89BkA0XaGzVIwYYZVD6LHD9cK910eM"},"signatures":{"localhost":{"ed25519:a_CHdg":"9/H6MKYzFlzeJfKhGxJYjt25lGKMEfbiGVQ/kPGVfjNGSkR67gYAqvl5lVbVxyAvktJMYP1BJ1eU6ky1gWcCBg"}},"unsigned":{"age_ts":1672314857885}}	3
$WxOx5K9OBtSH4SKkxlQDUCVkiuA8mdui6eTN417KUig	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672314858102.0","historical":false}	{"auth_events":["$aa2-bg9KcCtrn4nE5HK1JGC6sa8Gr7jWqLhPgLQTtsU","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$OL5YFZuIzpeGWvQkJsWD5fA-_tqvM6MNM8aACLhDIKc"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_b:localhost","content":{"msgtype":"m.text","body":"> <@mm_mattermost_a:localhost> first mm message\\n\\nsecond mm message","m.relates_to":{"m.in_reply_to":{"event_id":"$OL5YFZuIzpeGWvQkJsWD5fA-_tqvM6MNM8aACLhDIKc"}},"formatted_body":"<mx-reply><blockquote><a href=\\"https://matrix.to/#/!kmbTYjjsDRDHGgVqUP:localhost/$OL5YFZuIzpeGWvQkJsWD5fA-_tqvM6MNM8aACLhDIKc?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@mm_mattermost_a:localhost\\">@mm_mattermost_a:localhost</a><br>first mm message</blockquote></mx-reply>second mm message","format":"org.matrix.custom.html"},"depth":66,"prev_state":[],"origin":"localhost","origin_server_ts":1672314858127,"hashes":{"sha256":"ror07tE5nnmIfbr/YZI3Xp0rPJ0YX6c99l3Jvj6aTAE"},"signatures":{"localhost":{"ed25519:a_CHdg":"CefZ5mF7zv74uPuIerjo4FXVdslluHzdpxm0PLVh51GmqYeM2bnWI/LXg/MBuEfnhs3bio1ZlxVF4tY09ZDXAA"}},"unsigned":{"age_ts":1672314858127}}	3
$9eV_AyLXyN9dQJyo8nKzxH0MD2Pj26OD3m5hxM368ek	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672314858278.1","historical":false}	{"auth_events":["$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$WxOx5K9OBtSH4SKkxlQDUCVkiuA8mdui6eTN417KUig"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"> <@mm_mattermost_b:localhost> > <@mm_mattermost_a:localhost>\\n\\nthird mm message","m.relates_to":{"m.in_reply_to":{"event_id":"$WxOx5K9OBtSH4SKkxlQDUCVkiuA8mdui6eTN417KUig"}},"formatted_body":"<mx-reply><blockquote><a href=\\"https://matrix.to/#/!kmbTYjjsDRDHGgVqUP:localhost/$WxOx5K9OBtSH4SKkxlQDUCVkiuA8mdui6eTN417KUig?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@mm_mattermost_b:localhost\\">@mm_mattermost_b:localhost</a><br><mx-reply><blockquote><a href=\\"https://matrix.to/#/!kmbTYjjsDRDHGgVqUP:localhost/$OL5YFZuIzpeGWvQkJsWD5fA-_tqvM6MNM8aACLhDIKc?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@mm_mattermost_a:localhost\\">@mm_mattermost_a:localhost</a><br>first mm message</blockquote></mx-reply>second mm message</blockquote></mx-reply>third mm message","format":"org.matrix.custom.html"},"depth":67,"prev_state":[],"origin":"localhost","origin_server_ts":1672314858312,"hashes":{"sha256":"MKZo4SaXdvuF7hz0jxNNdoEpZ3DG3nIzQWEM1+6Bchw"},"signatures":{"localhost":{"ed25519:a_CHdg":"4h2IKuzYYjJMz8ZNqqwGVs7pqFmPOCrbTQ3mNjI8zv1u/2TjheHS9wdya4tWcznV+bkDDhOJyPpEBMqhFbEbAA"}},"unsigned":{"age_ts":1672314858312}}	3
$KAudDRl-ilYkXdKdFFwSH1rjB9FuDL3iaIcj9chsvuc	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672314858504.0","historical":false}	{"auth_events":["$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$53rDO0S-X2QNPUyUVrTGx092yf0EW0nvJXQNLgQ09kc"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"first matrix message"},"depth":74,"prev_state":[],"origin":"localhost","origin_server_ts":1672314858527,"hashes":{"sha256":"6xwOzU/FTvlu7xMu7VCIXq8b+sUmU37tqbuSoOF2iNQ"},"signatures":{"localhost":{"ed25519:a_CHdg":"91qwtdAdNmZ//qnWdi7LX0iFMjtmCMppW8Q1Q48dbdftzfz5e4QedsK4MJTSdDLtenai9T7vYYk3TBO9gvVFCA"}},"unsigned":{"age_ts":1672314858527}}	3
$NBW9KofbXfyJlflrssj5f0gU9-vix_ChkMTdCTutt6E	!dKcbdDATuwwphjRPQP:localhost	{"token_id":4,"txn_id":"m1672314858586.0","historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0"],"prev_events":["$KAudDRl-ilYkXdKdFFwSH1rjB9FuDL3iaIcj9chsvuc"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_b:localhost","content":{"msgtype":"m.text","body":"> <@matrix_a> first matrix message\\n\\nsecond matrix message","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>second matrix message","m.relates_to":{"m.in_reply_to":{"event_id":"$KAudDRl-ilYkXdKdFFwSH1rjB9FuDL3iaIcj9chsvuc"}}},"depth":75,"prev_state":[],"origin":"localhost","origin_server_ts":1672314858660,"hashes":{"sha256":"y2MH18Q+OiOjWYtAJr+lJoGD/0Gm+5PMaHHMJul0nGU"},"signatures":{"localhost":{"ed25519:a_CHdg":"nJ6tfwnCzYMR5JYXPkAVJu6fsGZU8z8vPV7VtBo+rGbXKupMlHtIkbIHWED4lkD8OlcY3ImyOvMRoZrqsiaCAw"}},"unsigned":{"age_ts":1672314858660}}	3
$G4jqJ_vLOuComzEY5LKlWgJmqk76rEv2BaFnoUc32C4	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672314858730.1","historical":false}	{"auth_events":["$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$NBW9KofbXfyJlflrssj5f0gU9-vix_ChkMTdCTutt6E"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"> <@matrix_b> > <@matrix_a>\\n\\nthird matrix message","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>third matrix message","m.relates_to":{"m.in_reply_to":{"event_id":"$NBW9KofbXfyJlflrssj5f0gU9-vix_ChkMTdCTutt6E"}}},"depth":76,"prev_state":[],"origin":"localhost","origin_server_ts":1672314858772,"hashes":{"sha256":"7KC3wVDozJPpxsbdmOz5kwvpMyRlkaC72WtIWSLJRm8"},"signatures":{"localhost":{"ed25519:a_CHdg":"WnTOrNpRTcvUEzY/LeuAsmLcaQsl92gRlMTT9JNmlFd1HbJHqwR9n2A/zdZ/j57pu1mGSfqPA+Dl7neWwtXvDw"}},"unsigned":{"age_ts":1672314858772}}	3
$PmdsaAuptefoxepoi5dH3S5XZjMQnrw_IY8E3iiC0JI	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672314859054.2","historical":false}	{"auth_events":["$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$9eV_AyLXyN9dQJyo8nKzxH0MD2Pj26OD3m5hxM368ek"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"first message"},"depth":68,"prev_state":[],"origin":"localhost","origin_server_ts":1672314859079,"hashes":{"sha256":"9IYhOO0W3VeJ24Ef0avCgaMgcy5C0g54vdUY1ShOh4k"},"signatures":{"localhost":{"ed25519:a_CHdg":"qhVQV3MYkkNs+B566ZdcdWx4cNB8D0hwC8wDy09dXyXS9pro16WEncLtzZvsfz7EvhuFWeRjAfXZOYDNocVUDw"}},"unsigned":{"age_ts":1672314859079}}	3
$LLxGQgsj2x835E7aJtEtKuPEzf1fHJTT_1b0cxZaynk	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":4,"txn_id":"m1672314859284.0","historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk"],"prev_events":["$PmdsaAuptefoxepoi5dH3S5XZjMQnrw_IY8E3iiC0JI"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_b:localhost","content":{"msgtype":"m.text","body":"whatever","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>second message","m.relates_to":{"m.in_reply_to":{"event_id":"$PmdsaAuptefoxepoi5dH3S5XZjMQnrw_IY8E3iiC0JI"}}},"depth":69,"prev_state":[],"origin":"localhost","origin_server_ts":1672314859309,"hashes":{"sha256":"se16XxQFn1QQ6SAj07GkwUzh73Pe5KZFL3qIx45Nj2Y"},"signatures":{"localhost":{"ed25519:a_CHdg":"Dd+z75ylZTopovvvk2skvrxaFmOvx9fqPqXQ5aflaUWDZV2or/MtOTupmtAvTLApC/JCbHDJZw6qhnGeppaHDA"}},"unsigned":{"age_ts":1672314859309}}	3
$xaKVxYK5Ka0brhbVcFdQdutgxYlZom-dUIRWmloBBms	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672314859525.3","historical":false}	{"auth_events":["$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$LLxGQgsj2x835E7aJtEtKuPEzf1fHJTT_1b0cxZaynk"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"> <@matrix_b:localhost> whatever\\n\\nthird message","m.relates_to":{"m.in_reply_to":{"event_id":"$LLxGQgsj2x835E7aJtEtKuPEzf1fHJTT_1b0cxZaynk"}},"formatted_body":"<mx-reply><blockquote><a href=\\"https://matrix.to/#/!kmbTYjjsDRDHGgVqUP:localhost/$LLxGQgsj2x835E7aJtEtKuPEzf1fHJTT_1b0cxZaynk?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@matrix_b:localhost\\">@matrix_b:localhost</a><br><mx-reply>Dummy content</mx-reply>second message</blockquote></mx-reply>third message","format":"org.matrix.custom.html"},"depth":70,"prev_state":[],"origin":"localhost","origin_server_ts":1672314859555,"hashes":{"sha256":"wDTXZYtDVasRaSYahQxV91iNoTA0C35Bnb1yedf5/RQ"},"signatures":{"localhost":{"ed25519:a_CHdg":"xjRrOP5SOJgNBYHgOauVpYMvafKHMREtqpjDKFRbUHF6oXnrnuFYmTXHo8m6Oc3jMPfp3L1uEDh3DYTVc+TsCw"}},"unsigned":{"age_ts":1672314859555}}	3
$OIgyn6WfwavdRqCIV587JtVG-UzMqFnY1_VC_N2O6ok	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672314860143.3","historical":false}	{"auth_events":["$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$OxJtFsDfjfHJ57HdnctrwwYfeMAuGw-MFWayc0MqGW4"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"> <@matrix_a> reply message\\n\\nlast message","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>last message","m.relates_to":{"m.in_reply_to":{"event_id":"$iZZsHDRKa9MPh0wKPGoTIkR9_IN1gXmgYQ3CLA-oEsU"}}},"depth":80,"prev_state":[],"origin":"localhost","origin_server_ts":1672314860182,"hashes":{"sha256":"FeCdnk5ZbFmcdsGBezYM7UuGWN+wi9YlhZGSPLZhEnI"},"signatures":{"localhost":{"ed25519:a_CHdg":"GNl8kbMAd54/jNg3M6wGTAMyyOcQwP4JW8ZMrH4GvEobcJ6NJVJx1H6EJ+EkBubCk3YfmBGN65ul0XahF/vvBg"}},"unsigned":{"age_ts":1672314860182}}	3
$7IBjUUbkm6m5Y_DazT_SUW3_XBAwV0nvHP6nkPuBbV0	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672314859754.0","historical":false}	{"auth_events":["$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$G4jqJ_vLOuComzEY5LKlWgJmqk76rEv2BaFnoUc32C4"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"root message"},"depth":77,"prev_state":[],"origin":"localhost","origin_server_ts":1672314859803,"hashes":{"sha256":"/8pRkIdXWCd4e44kjI9i/JKoJulGMSFRKpQhJTRFyw4"},"signatures":{"localhost":{"ed25519:a_CHdg":"hsDOQgYzvGDz5rrLbGTAMprR0qUce8tDlqTifdZKM0knlmz0GfD8meSHAYftwA+OECAE3lrurVvx9XCMXN3wDg"}},"unsigned":{"age_ts":1672314859803}}	3
$iZZsHDRKa9MPh0wKPGoTIkR9_IN1gXmgYQ3CLA-oEsU	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672314859844.1","historical":false}	{"auth_events":["$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$7IBjUUbkm6m5Y_DazT_SUW3_XBAwV0nvHP6nkPuBbV0"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"> <@matrix_a> root message\\n\\nreply message","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>reply message","m.relates_to":{"m.in_reply_to":{"event_id":"$7IBjUUbkm6m5Y_DazT_SUW3_XBAwV0nvHP6nkPuBbV0"}}},"depth":78,"prev_state":[],"origin":"localhost","origin_server_ts":1672314859926,"hashes":{"sha256":"CCnoU8FnCuFXbYvcWxkovZ7cCXbWrOYCLhn9hZgANQA"},"signatures":{"localhost":{"ed25519:a_CHdg":"v7JcDQbf1hWP1LVCjeVe4RxrZuaV4upgOr6tgRH9KwlFj2et/ypiPfvVxV5Mi5RYJKw6IK2x0eXu0BGIwycyAA"}},"unsigned":{"age_ts":1672314859926}}	3
$OxJtFsDfjfHJ57HdnctrwwYfeMAuGw-MFWayc0MqGW4	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672314859996.2","historical":false}	{"auth_events":["$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII"],"prev_events":["$iZZsHDRKa9MPh0wKPGoTIkR9_IN1gXmgYQ3CLA-oEsU"],"type":"m.room.redaction","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{},"depth":79,"prev_state":[],"redacts":"$7IBjUUbkm6m5Y_DazT_SUW3_XBAwV0nvHP6nkPuBbV0","origin":"localhost","origin_server_ts":1672314860034,"hashes":{"sha256":"fT9IrRmmobKoXKhqFC2/gSgqrtp3f+RK3DxnqT1mg4k"},"signatures":{"localhost":{"ed25519:a_CHdg":"mj4UBmi8d54OByXRho3LrmaCBbRYDQMEa/H5tQg6+PdE/nGfgNZqxsMX79uhZ4k6IjiEeh9oC9qad5IWRCIqAg"}},"unsigned":{"age_ts":1672314860034}}	3
$z-yABBMUu-RFJeiOLWwmWghP2O4vgO3Bts6c9FX-uG8	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672314861902.0","historical":false}	{"auth_events":["$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w"],"prev_events":["$xaKVxYK5Ka0brhbVcFdQdutgxYlZom-dUIRWmloBBms"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"new message"},"depth":71,"prev_state":[],"origin":"localhost","origin_server_ts":1672314861926,"hashes":{"sha256":"mAn1vUFyWIQ3vgPoUJ34MLXhD/Y1rKbc+hh5z4VsS+M"},"signatures":{"localhost":{"ed25519:a_CHdg":"/6VBGbuO+zs2npo4ljhRRURT35L5yShIql2cV8VtHUodB+yasuLF12WF4iF/6K5UP+0nQ/txoQaSV9dogKLWAQ"}},"unsigned":{"age_ts":1672314861926}}	3
$P2eP-7teBmGXcBM7DqUedLeBNdY5eaTasFqCr7GXY74	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672315004560.0","historical":false}	{"auth_events":["$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$z-yABBMUu-RFJeiOLWwmWghP2O4vgO3Bts6c9FX-uG8"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"first mm message"},"depth":72,"prev_state":[],"origin":"localhost","origin_server_ts":1672315004592,"hashes":{"sha256":"dsaSToyLJLFXZ0k2i/aDykyOTdGyTDekirKMXYhZH6Q"},"signatures":{"localhost":{"ed25519:a_CHdg":"UOJvGNRpfYtkGOkeoPCPqOfczUy6H9xD83FOTQCfFHNGs+WWK5LeKki9hsvl/5uoDDfujkf+HL2G41HcOzNwBQ"}},"unsigned":{"age_ts":1672315004592}}	3
$62DK_5Urc-R1gCm6T-D7rEFWp3Q47rECTaNApSOe0tg	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672315004969.0","historical":false}	{"auth_events":["$aa2-bg9KcCtrn4nE5HK1JGC6sa8Gr7jWqLhPgLQTtsU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$P2eP-7teBmGXcBM7DqUedLeBNdY5eaTasFqCr7GXY74"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_b:localhost","content":{"msgtype":"m.text","body":"> <@mm_mattermost_a:localhost> first mm message\\n\\nsecond mm message","m.relates_to":{"m.in_reply_to":{"event_id":"$P2eP-7teBmGXcBM7DqUedLeBNdY5eaTasFqCr7GXY74"}},"formatted_body":"<mx-reply><blockquote><a href=\\"https://matrix.to/#/!kmbTYjjsDRDHGgVqUP:localhost/$P2eP-7teBmGXcBM7DqUedLeBNdY5eaTasFqCr7GXY74?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@mm_mattermost_a:localhost\\">@mm_mattermost_a:localhost</a><br>first mm message</blockquote></mx-reply>second mm message","format":"org.matrix.custom.html"},"depth":73,"prev_state":[],"origin":"localhost","origin_server_ts":1672315005001,"hashes":{"sha256":"sv7ZQSuterkAlRqG9YpLhCSgnKaKV8P78x8FdUEbudM"},"signatures":{"localhost":{"ed25519:a_CHdg":"3qWprV9SHLrvFmmCQv3foNQeM7sXT17k26VhLpM9JDFPz4LbzHY4W5h34xL/BG71k0s/3q4MYdh+e3HiXGz3CA"}},"unsigned":{"age_ts":1672315005001}}	3
$reo6-sRCAReTplLLrWZiUXEMMfaufd1o-PclhKbhxXw	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672315005169.1","historical":false}	{"auth_events":["$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$62DK_5Urc-R1gCm6T-D7rEFWp3Q47rECTaNApSOe0tg"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"> <@mm_mattermost_b:localhost> > <@mm_mattermost_a:localhost>\\n\\nthird mm message","m.relates_to":{"m.in_reply_to":{"event_id":"$62DK_5Urc-R1gCm6T-D7rEFWp3Q47rECTaNApSOe0tg"}},"formatted_body":"<mx-reply><blockquote><a href=\\"https://matrix.to/#/!kmbTYjjsDRDHGgVqUP:localhost/$62DK_5Urc-R1gCm6T-D7rEFWp3Q47rECTaNApSOe0tg?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@mm_mattermost_b:localhost\\">@mm_mattermost_b:localhost</a><br><mx-reply><blockquote><a href=\\"https://matrix.to/#/!kmbTYjjsDRDHGgVqUP:localhost/$P2eP-7teBmGXcBM7DqUedLeBNdY5eaTasFqCr7GXY74?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@mm_mattermost_a:localhost\\">@mm_mattermost_a:localhost</a><br>first mm message</blockquote></mx-reply>second mm message</blockquote></mx-reply>third mm message","format":"org.matrix.custom.html"},"depth":74,"prev_state":[],"origin":"localhost","origin_server_ts":1672315005201,"hashes":{"sha256":"UaQ+ff3fjEqjdqFAUmTAyZduxZL+L3ttiiEdnsDuPkk"},"signatures":{"localhost":{"ed25519:a_CHdg":"yfkkX8RtMYgSigKnSjh3CqxFCIJYm8/6AHLbdBz1gDIvEHl/xJFv/KYCGgTCQjCGtgBHLwzdrNXnv1gVpwDhAw"}},"unsigned":{"age_ts":1672315005201}}	3
$LiUaGyMC-ZVhJFLD9EeZsUNlhdIzJ2J41q-tpdMYQ-g	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672315005553.0","historical":false}	{"auth_events":["$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$OIgyn6WfwavdRqCIV587JtVG-UzMqFnY1_VC_N2O6ok"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"first matrix message"},"depth":81,"prev_state":[],"origin":"localhost","origin_server_ts":1672315005582,"hashes":{"sha256":"GWxPqrK5d/pwhjebbqLSYRI3kZTsx97vvk08madX1vU"},"signatures":{"localhost":{"ed25519:a_CHdg":"WU7C9ivhLoiicxLydPUN43uohu44p21h13fhrxm9HneprV9ruac2LdV+q90gZhzIjQ16CFPpvPxvbqo+CFPZBw"}},"unsigned":{"age_ts":1672315005582}}	3
$kGXjbDILpzPlAVquVm-0ro1Y2cAjvBSU3chLQmB-ZgI	!dKcbdDATuwwphjRPQP:localhost	{"token_id":4,"txn_id":"m1672315005672.0","historical":false}	{"auth_events":["$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$LiUaGyMC-ZVhJFLD9EeZsUNlhdIzJ2J41q-tpdMYQ-g"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_b:localhost","content":{"msgtype":"m.text","body":"> <@matrix_a> first matrix message\\n\\nsecond matrix message","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>second matrix message","m.relates_to":{"m.in_reply_to":{"event_id":"$LiUaGyMC-ZVhJFLD9EeZsUNlhdIzJ2J41q-tpdMYQ-g"}}},"depth":82,"prev_state":[],"origin":"localhost","origin_server_ts":1672315005779,"hashes":{"sha256":"JjKlXVOnoI5sTPtFgh9F4+Ri8jwJ7jOsb8OXWHwvI5U"},"signatures":{"localhost":{"ed25519:a_CHdg":"nfyK6aCPGUC5KCxPKjD27Xu9lBHsjZk1Az0KRlySeKE29yA1VFbQifajRAfE2QTTVI31fB16BSum+6wFjMw5BA"}},"unsigned":{"age_ts":1672315005779}}	3
$zI1CZE-pX4aF7RBiJiZqzqFZlxIfJRBpmSuBjEzHTCQ	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":4,"txn_id":"m1672315006512.0","historical":false}	{"auth_events":["$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$47BkoMnB5FT3PSdXLEy0rb4ZdbS1q9w82a669O4lBXg"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_b:localhost","content":{"msgtype":"m.text","body":"whatever","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>second message","m.relates_to":{"m.in_reply_to":{"event_id":"$47BkoMnB5FT3PSdXLEy0rb4ZdbS1q9w82a669O4lBXg"}}},"depth":76,"prev_state":[],"origin":"localhost","origin_server_ts":1672315006535,"hashes":{"sha256":"CnpQxOrrW6OPDM1uLXjRfVoBBSSd4C3Hjqi9BL11TK4"},"signatures":{"localhost":{"ed25519:a_CHdg":"IPFElYJdrAZoTa2HuMcQnk8pB1dbhFRngTJAZvijJiBTi5XCN760S2Rf6rDTuD1+tzUtHhR0VKWgFkVAIi68Bg"}},"unsigned":{"age_ts":1672315006535}}	3
$y7fmz8cz_zrBS0ZmRnthufiCH3PFkuCVz8YKzQaf81g	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672315006771.3","historical":false}	{"auth_events":["$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$zI1CZE-pX4aF7RBiJiZqzqFZlxIfJRBpmSuBjEzHTCQ"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"> <@matrix_b:localhost> whatever\\n\\nthird message","m.relates_to":{"m.in_reply_to":{"event_id":"$zI1CZE-pX4aF7RBiJiZqzqFZlxIfJRBpmSuBjEzHTCQ"}},"formatted_body":"<mx-reply><blockquote><a href=\\"https://matrix.to/#/!kmbTYjjsDRDHGgVqUP:localhost/$zI1CZE-pX4aF7RBiJiZqzqFZlxIfJRBpmSuBjEzHTCQ?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@matrix_b:localhost\\">@matrix_b:localhost</a><br><mx-reply>Dummy content</mx-reply>second message</blockquote></mx-reply>third message","format":"org.matrix.custom.html"},"depth":77,"prev_state":[],"origin":"localhost","origin_server_ts":1672315006795,"hashes":{"sha256":"Ahq/nAhBukU1mx3sZMHiAU44CEqGMgaln+OfNCoyHSE"},"signatures":{"localhost":{"ed25519:a_CHdg":"aJNL5CMuxK5QxRHE9sImuiuWVCmuJ8/DXpS6PREx2YAkN79Yk1vwgnIwgpYLL/RDR5zUePD2LbKs032ymwH/Dw"}},"unsigned":{"age_ts":1672315006795}}	3
$LHW3l0dgme8yNUY6xjIvP_Osal1_vZAuIfg7vCLzGKI	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672315009020.0","historical":false}	{"auth_events":["$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$y7fmz8cz_zrBS0ZmRnthufiCH3PFkuCVz8YKzQaf81g"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"new message"},"depth":78,"prev_state":[],"origin":"localhost","origin_server_ts":1672315009057,"hashes":{"sha256":"QajItdqEcFns044Pb9oZ1R0SH/nW7w83LZqx7ZbcqqI"},"signatures":{"localhost":{"ed25519:a_CHdg":"B0sqzJ7CcnE9d6iCAjGF0/6oAH984AwkozuuCcoSHM/uv/QEikeY05PoLEreKGZ0p1t1y07e82PM0PmIbfocAQ"}},"unsigned":{"age_ts":1672315009057}}	3
$jgIb5yphKm1y65Shpo1bZF38fQ0ZqUjOopYEMjB2JS0	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672317654262.0","historical":false}	{"auth_events":["$aa2-bg9KcCtrn4nE5HK1JGC6sa8Gr7jWqLhPgLQTtsU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$_XRh5iYtBtMSC8b9sq-Zq1kS1LqI6azDTXLEGQTiQSs"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_b:localhost","content":{"msgtype":"m.text","body":"> <@mm_mattermost_a:localhost> first mm message\\n\\nsecond mm message","m.relates_to":{"m.in_reply_to":{"event_id":"$_XRh5iYtBtMSC8b9sq-Zq1kS1LqI6azDTXLEGQTiQSs"}},"formatted_body":"<mx-reply><blockquote><a href=\\"https://matrix.to/#/!kmbTYjjsDRDHGgVqUP:localhost/$_XRh5iYtBtMSC8b9sq-Zq1kS1LqI6azDTXLEGQTiQSs?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@mm_mattermost_a:localhost\\">@mm_mattermost_a:localhost</a><br>first mm message</blockquote></mx-reply>second mm message","format":"org.matrix.custom.html"},"depth":80,"prev_state":[],"origin":"localhost","origin_server_ts":1672317654290,"hashes":{"sha256":"3z0+RfZJLRQ6N4PBf5fJAEAvt74vlALtqKC1CDHNw6o"},"signatures":{"localhost":{"ed25519:a_CHdg":"3Y3djOxR9uorpqcL1Fd6KNmRbHuxX5n6CYP7cfAFX9VggzgFgnIBtvIZpDLv1wf7rZzNkbDwmMY30JNRm377BQ"}},"unsigned":{"age_ts":1672317654290}}	3
$n7rEuNOUTfPAb-nKtA8sQLtp0FZoDqOfMyqN9eKVULc	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672317654926.1","historical":false}	{"auth_events":["$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$8f7euYUQUOKVs1LECS5C0ny-iJc0LrEhKy5AjaE9VwM"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"> <@matrix_b> > <@matrix_a>\\n\\nthird matrix message","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>third matrix message","m.relates_to":{"m.in_reply_to":{"event_id":"$8f7euYUQUOKVs1LECS5C0ny-iJc0LrEhKy5AjaE9VwM"}}},"depth":90,"prev_state":[],"origin":"localhost","origin_server_ts":1672317655010,"hashes":{"sha256":"EgL+hjbl3BPizOH3Bum5vfpgu6fHz8CcBEhwCCRb5zw"},"signatures":{"localhost":{"ed25519:a_CHdg":"8+qFsPA6aEOowtDQHXS6fcmhEW6ljQqLps5mrAlQQPALAc9Irwduh4uQ54FDbrTroIfz11jOlLdCwcPTuJDYAw"}},"unsigned":{"age_ts":1672317655010}}	3
$iR6CRvH8xG5VgeMQIZFMBeaVeTjxgDtnqT7tv-PoCf8	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672315005868.1","historical":false}	{"auth_events":["$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$kGXjbDILpzPlAVquVm-0ro1Y2cAjvBSU3chLQmB-ZgI"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"> <@matrix_b> > <@matrix_a>\\n\\nthird matrix message","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>third matrix message","m.relates_to":{"m.in_reply_to":{"event_id":"$kGXjbDILpzPlAVquVm-0ro1Y2cAjvBSU3chLQmB-ZgI"}}},"depth":83,"prev_state":[],"origin":"localhost","origin_server_ts":1672315005925,"hashes":{"sha256":"b5cMyk06T5P6EjDI7MOYTNbCY0hFtExOVYtj23h3GzQ"},"signatures":{"localhost":{"ed25519:a_CHdg":"/a9nW0/gbLj1MPzvQik4sbTtFiveHF1+xJg6Gg5z2edKsSZMbXfgFhMRRkDkyfsuQesYhYBK22a+U0yEoe1tDw"}},"unsigned":{"age_ts":1672315005925}}	3
$dtGyXiOFORXfCA1yAgiPJbV5UKJjEo-zfetInljHoV0	!dKcbdDATuwwphjRPQP:localhost	{"token_id":4,"txn_id":"m1672317898082.0","historical":false}	{"auth_events":["$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$7q-JkspgsFYptPnMJ25LHdffz-rXLRDHzidSYCV3Kc8"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_b:localhost","content":{"msgtype":"m.text","body":"> <@matrix_a> first matrix message\\n\\nsecond matrix message","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>second matrix message","m.relates_to":{"m.in_reply_to":{"event_id":"$7q-JkspgsFYptPnMJ25LHdffz-rXLRDHzidSYCV3Kc8"}}},"depth":96,"prev_state":[],"origin":"localhost","origin_server_ts":1672317898206,"hashes":{"sha256":"DJxH3yqVJT8yo1UKeNK408WyCp6N0LSFB8rCJDSqk1o"},"signatures":{"localhost":{"ed25519:a_CHdg":"wTyKFYiU7JXxD1fC78PhQwSHGOxLv+gGBhmrX37l3q0Ko5yCHa3HntEV+Ex3+wS72rLJrllcFjwD487ckRJNBw"}},"unsigned":{"age_ts":1672317898206}}	3
$47BkoMnB5FT3PSdXLEy0rb4ZdbS1q9w82a669O4lBXg	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672315006297.2","historical":false}	{"auth_events":["$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$reo6-sRCAReTplLLrWZiUXEMMfaufd1o-PclhKbhxXw"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"first message"},"depth":75,"prev_state":[],"origin":"localhost","origin_server_ts":1672315006320,"hashes":{"sha256":"jQn1klzBw4M+HmdojEHah+pDUYx9n9fIGZQQnfN+hFE"},"signatures":{"localhost":{"ed25519:a_CHdg":"4ktKPM5I/XRVdfaMVnPggXY0K/ciP/prtwuLQsKwBhxgZNgFuD5oTh9TbuU8fdY3rcUDN4Z8NZT9x8Jb0mqZAA"}},"unsigned":{"age_ts":1672315006320}}	3
$mJ65YIJRPOxuW2mcyV5dt1MwIY7iWY76Fnj51047dZM	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672315006989.0","historical":false}	{"auth_events":["$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$iR6CRvH8xG5VgeMQIZFMBeaVeTjxgDtnqT7tv-PoCf8"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"root message"},"depth":84,"prev_state":[],"origin":"localhost","origin_server_ts":1672315007015,"hashes":{"sha256":"RSxtpu4oT6/vXjVnUe4GEe+4z8G/KKr14k2Xw0qMMZ0"},"signatures":{"localhost":{"ed25519:a_CHdg":"wsA0zqOsA/MZJ7sq93UuW+rpXNXwUq7/cYi9k/7tpolvHtxW0ScKPLVMG3BRFTYeJH8ah9byPGVkjcAnk1cmDA"}},"unsigned":{"age_ts":1672315007015}}	3
$p7GJemyaMZGUqYX0guKHUqmObfwF2yChmhI7v1sn2nE	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672315007087.1","historical":false}	{"auth_events":["$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$mJ65YIJRPOxuW2mcyV5dt1MwIY7iWY76Fnj51047dZM"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"> <@matrix_a> root message\\n\\nreply message","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>reply message","m.relates_to":{"m.in_reply_to":{"event_id":"$mJ65YIJRPOxuW2mcyV5dt1MwIY7iWY76Fnj51047dZM"}}},"depth":85,"prev_state":[],"origin":"localhost","origin_server_ts":1672315007130,"hashes":{"sha256":"Pf6Ub9eBLUA1SxBpCnRbwS1DZUponDhigOoK8GYxutc"},"signatures":{"localhost":{"ed25519:a_CHdg":"nzyafUShphTMkcSprIGI6LaggYtaGtfXm2/Gm1pC/h/jSjDiifIaBJlxdHp4rdWZ2atvnxNya/dL+2Vrcfq0Aw"}},"unsigned":{"age_ts":1672315007130}}	3
$Ky-_xzOrnEPuDm0WQev0E1urDcDHtvv8esKT3jQ6lFY	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672315007218.2","historical":false}	{"auth_events":["$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$p7GJemyaMZGUqYX0guKHUqmObfwF2yChmhI7v1sn2nE"],"type":"m.room.redaction","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{},"depth":86,"prev_state":[],"redacts":"$mJ65YIJRPOxuW2mcyV5dt1MwIY7iWY76Fnj51047dZM","origin":"localhost","origin_server_ts":1672315007272,"hashes":{"sha256":"LglNPbnkxoPF+GLH6K0FT2V+99xSYIjA6Dvbhf9Rys4"},"signatures":{"localhost":{"ed25519:a_CHdg":"FhRPFoQHrOv5hTVq84Yk4KpcLANqL1FUWCpwWjdhta2c/P7cwHPwYXQi6h7SfBipTID32Z+fTmXSiQg8nBgKCg"}},"unsigned":{"age_ts":1672315007272}}	3
$5Iq2ZU88BXgNKKqMGOu71dH7vsyaxwI-Fxg8ocEMI2E	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672315007386.3","historical":false}	{"auth_events":["$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$Ky-_xzOrnEPuDm0WQev0E1urDcDHtvv8esKT3jQ6lFY"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"> <@matrix_a> reply message\\n\\nlast message","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>last message","m.relates_to":{"m.in_reply_to":{"event_id":"$p7GJemyaMZGUqYX0guKHUqmObfwF2yChmhI7v1sn2nE"}}},"depth":87,"prev_state":[],"origin":"localhost","origin_server_ts":1672315007420,"hashes":{"sha256":"a8Hoo1OlamwUdu2Jw0eNkh4dW2EXlaBFwxCgZEC5QAI"},"signatures":{"localhost":{"ed25519:a_CHdg":"sCwAA+ta0D6+LH+4X7xqitqJ886ujYRd4jp0pcvVECPkPuZ1RxaOVAfDpmbHDZ8VhD+fXbDoPzBPUX+pmQ4KAA"}},"unsigned":{"age_ts":1672315007420}}	3
$_XRh5iYtBtMSC8b9sq-Zq1kS1LqI6azDTXLEGQTiQSs	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672317654005.0","historical":false}	{"auth_events":["$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$LHW3l0dgme8yNUY6xjIvP_Osal1_vZAuIfg7vCLzGKI"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"first mm message"},"depth":79,"prev_state":[],"origin":"localhost","origin_server_ts":1672317654041,"hashes":{"sha256":"JSAQ/0o9CyIGXEZ7Xy4oPhPr8yVrNcpugDhh24JtzLg"},"signatures":{"localhost":{"ed25519:a_CHdg":"CsFcxCgWyOpWXj6hU4nSobTUoV/hTz91FPX75A8UOVjOAYX9dPJZMp0bIHr/qPbgTa7lTa5dKIIPoKhtbfCoAA"}},"unsigned":{"age_ts":1672317654041}}	3
$8f7euYUQUOKVs1LECS5C0ny-iJc0LrEhKy5AjaE9VwM	!dKcbdDATuwwphjRPQP:localhost	{"token_id":4,"txn_id":"m1672317654771.0","historical":false}	{"auth_events":["$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$5-UBR4vNvgnHcUIuQA0gIHJmn4pOL-BNEZ33B-2Dmes"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_b:localhost","content":{"msgtype":"m.text","body":"> <@matrix_a> first matrix message\\n\\nsecond matrix message","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>second matrix message","m.relates_to":{"m.in_reply_to":{"event_id":"$5-UBR4vNvgnHcUIuQA0gIHJmn4pOL-BNEZ33B-2Dmes"}}},"depth":89,"prev_state":[],"origin":"localhost","origin_server_ts":1672317654827,"hashes":{"sha256":"p8uQe84Nf9BuXJriuTLy44pW9Vp3rtLQnnOgTJ4g9iY"},"signatures":{"localhost":{"ed25519:a_CHdg":"tXGIMgH+Yme2OBrqiE1BjIx02Uz2VDLHFO+80gG5xYgF12GjCSTYNgVL5tzNaeB/WjPP76KvAQnRMmuErDb1Aw"}},"unsigned":{"age_ts":1672317654827}}	3
$jTQQwpTqOMCeKxagSFuov0Dg8yBrYJJogGNCxBE1qwk	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672317655997.0","historical":false}	{"auth_events":["$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$n7rEuNOUTfPAb-nKtA8sQLtp0FZoDqOfMyqN9eKVULc"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"root message"},"depth":91,"prev_state":[],"origin":"localhost","origin_server_ts":1672317656025,"hashes":{"sha256":"C70v8zRIPFOsTF44zgxyIMwdeWCpmkrsoU6i/qjwoLA"},"signatures":{"localhost":{"ed25519:a_CHdg":"jYf47N7YwTVsQFQH9uifWZTq5NTpH6tbwahgfkhSp0ajhjPGVn9LaFCusnKP6MWiZsPISH6SSx31FxtWhhUJAw"}},"unsigned":{"age_ts":1672317656025}}	3
$j96SJY0VtGl6Q_Fnj_jg3BifdW7s0-Vd8t57DrAeAX8	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672317654444.1","historical":false}	{"auth_events":["$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$jgIb5yphKm1y65Shpo1bZF38fQ0ZqUjOopYEMjB2JS0"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"> <@mm_mattermost_b:localhost> > <@mm_mattermost_a:localhost>\\n\\nthird mm message","m.relates_to":{"m.in_reply_to":{"event_id":"$jgIb5yphKm1y65Shpo1bZF38fQ0ZqUjOopYEMjB2JS0"}},"formatted_body":"<mx-reply><blockquote><a href=\\"https://matrix.to/#/!kmbTYjjsDRDHGgVqUP:localhost/$jgIb5yphKm1y65Shpo1bZF38fQ0ZqUjOopYEMjB2JS0?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@mm_mattermost_b:localhost\\">@mm_mattermost_b:localhost</a><br><mx-reply><blockquote><a href=\\"https://matrix.to/#/!kmbTYjjsDRDHGgVqUP:localhost/$_XRh5iYtBtMSC8b9sq-Zq1kS1LqI6azDTXLEGQTiQSs?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@mm_mattermost_a:localhost\\">@mm_mattermost_a:localhost</a><br>first mm message</blockquote></mx-reply>second mm message</blockquote></mx-reply>third mm message","format":"org.matrix.custom.html"},"depth":81,"prev_state":[],"origin":"localhost","origin_server_ts":1672317654478,"hashes":{"sha256":"wm7OEnVC4Lm4nfaOmgkpQWnP2HiouEExLy5TweT3r7s"},"signatures":{"localhost":{"ed25519:a_CHdg":"CqNorM/NXRVZkZiiixtvzf+c3DgqKdoyzVzVwupUs5Ca9LOFP21cv6n/4SZeZVJ5xixBvves8LPBa2ldhwoCDQ"}},"unsigned":{"age_ts":1672317654478}}	3
$5-UBR4vNvgnHcUIuQA0gIHJmn4pOL-BNEZ33B-2Dmes	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672317654681.0","historical":false}	{"auth_events":["$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$5Iq2ZU88BXgNKKqMGOu71dH7vsyaxwI-Fxg8ocEMI2E"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"first matrix message"},"depth":88,"prev_state":[],"origin":"localhost","origin_server_ts":1672317654712,"hashes":{"sha256":"G7NTPBK5BwtkJhPXtG+rc42thM+waiGNipTl6oNIe1o"},"signatures":{"localhost":{"ed25519:a_CHdg":"He5zSh82ItXe6Pj8kBcINtOY2BnojbbW63sMcVKyFGX9nOVR/u5qbdIunxPNYYZhILhp1pK8QpNmBKtHoeafAw"}},"unsigned":{"age_ts":1672317654712}}	3
$KdF0e2L1V2qamNtPDDdbE1nZ8xvaqEBCeH0VcCCosQ8	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672317655260.2","historical":false}	{"auth_events":["$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$j96SJY0VtGl6Q_Fnj_jg3BifdW7s0-Vd8t57DrAeAX8"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"first message"},"depth":82,"prev_state":[],"origin":"localhost","origin_server_ts":1672317655291,"hashes":{"sha256":"ze0W8gp4FgtHOa6q1wuJeY3VNIAbCNXYzBERlJogeBw"},"signatures":{"localhost":{"ed25519:a_CHdg":"MC4s9j2mEqS6EwNFSyuwmQqJ/t6QKaxj8gu3TqlETvS2Xca3oU/e41NlcQEWTTugOlF6SsGocB1TLUITdyRRBA"}},"unsigned":{"age_ts":1672317655291}}	3
$VGPWrlgPM0aSEOjGq1_ygJ2gwcjdfMl06P2yF-1EjMw	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":4,"txn_id":"m1672317655467.0","historical":false}	{"auth_events":["$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$KdF0e2L1V2qamNtPDDdbE1nZ8xvaqEBCeH0VcCCosQ8"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_b:localhost","content":{"msgtype":"m.text","body":"whatever","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>second message","m.relates_to":{"m.in_reply_to":{"event_id":"$KdF0e2L1V2qamNtPDDdbE1nZ8xvaqEBCeH0VcCCosQ8"}}},"depth":83,"prev_state":[],"origin":"localhost","origin_server_ts":1672317655501,"hashes":{"sha256":"c/YrKK4Wr0TitVLkN51MHw/X0+OJAX0fsFH623SHylM"},"signatures":{"localhost":{"ed25519:a_CHdg":"y6BGvwCSG+PWIKqp77/J7jr5FF3zU1YRuYQKj8qL8mql7TIr1ccnqB1gOOCD3m6inHnpMWofCWK4sTvXMCprAg"}},"unsigned":{"age_ts":1672317655501}}	3
$T-S0-0A2-tysbZGnQHyOgfmxVouK-Ise06pRgQbLLcg	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672317655777.3","historical":false}	{"auth_events":["$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$VGPWrlgPM0aSEOjGq1_ygJ2gwcjdfMl06P2yF-1EjMw"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"> <@matrix_b:localhost> whatever\\n\\nthird message","m.relates_to":{"m.in_reply_to":{"event_id":"$VGPWrlgPM0aSEOjGq1_ygJ2gwcjdfMl06P2yF-1EjMw"}},"formatted_body":"<mx-reply><blockquote><a href=\\"https://matrix.to/#/!kmbTYjjsDRDHGgVqUP:localhost/$VGPWrlgPM0aSEOjGq1_ygJ2gwcjdfMl06P2yF-1EjMw?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@matrix_b:localhost\\">@matrix_b:localhost</a><br><mx-reply>Dummy content</mx-reply>second message</blockquote></mx-reply>third message","format":"org.matrix.custom.html"},"depth":84,"prev_state":[],"origin":"localhost","origin_server_ts":1672317655810,"hashes":{"sha256":"3HIJMU/0Hvvjd/12jx8Zo6CcDX0mEmqoqG9ZouldaT0"},"signatures":{"localhost":{"ed25519:a_CHdg":"NQqApLn22cLPdm4VNU9FqiPJFn12eWTK22Ly6e5sjTICe8lfrKZVsTyH1oUXqU2BMPnFOiwqHfJnVlB0PiHEDA"}},"unsigned":{"age_ts":1672317655810}}	3
$8Hjay0ed9n_Y3vv-Lhtc_-A0-5CvZe8YsPugJA7pwVg	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672317656069.1","historical":false}	{"auth_events":["$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$jTQQwpTqOMCeKxagSFuov0Dg8yBrYJJogGNCxBE1qwk"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"> <@matrix_a> root message\\n\\nreply message","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>reply message","m.relates_to":{"m.in_reply_to":{"event_id":"$jTQQwpTqOMCeKxagSFuov0Dg8yBrYJJogGNCxBE1qwk"}}},"depth":92,"prev_state":[],"origin":"localhost","origin_server_ts":1672317656117,"hashes":{"sha256":"wZzzMnrQEjaI9n3A5/5iWBK6gbG3Pkr7MP6f2Fm15o0"},"signatures":{"localhost":{"ed25519:a_CHdg":"Ky3OZ9HABioOyC1hjOeAvKowdEX+iOKzVQ4m5koRtCLtv6+EbONIZNOPAOg/NQZqg++Y6EC6JhBsW31SFG5MBw"}},"unsigned":{"age_ts":1672317656117}}	3
$NHchZjGDozZxBeE_hBCfcWNQSoGcpRSxMwGAV4CVzWU	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672317656361.2","historical":false}	{"auth_events":["$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$8Hjay0ed9n_Y3vv-Lhtc_-A0-5CvZe8YsPugJA7pwVg"],"type":"m.room.redaction","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{},"depth":93,"prev_state":[],"redacts":"$jTQQwpTqOMCeKxagSFuov0Dg8yBrYJJogGNCxBE1qwk","origin":"localhost","origin_server_ts":1672317656469,"hashes":{"sha256":"cFFDswEunw8/7j0mwcUteoAvg9PAAJnObEOLiEaeEG8"},"signatures":{"localhost":{"ed25519:a_CHdg":"xw37J/uY9DVBoPNRsYV+o7+ux134ZhkmSt+NnaaI7Ja4cOVo9JJivCDtwGTjj+b8v55qROvNJ6oVeDEU/LLJCg"}},"unsigned":{"age_ts":1672317656469}}	3
$5G3tHkgsc39AkOi94e7gxCeKaPhkmyOOAZlGWI8YaCQ	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672317656547.3","historical":false}	{"auth_events":["$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$NHchZjGDozZxBeE_hBCfcWNQSoGcpRSxMwGAV4CVzWU"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"> <@matrix_a> reply message\\n\\nlast message","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>last message","m.relates_to":{"m.in_reply_to":{"event_id":"$8Hjay0ed9n_Y3vv-Lhtc_-A0-5CvZe8YsPugJA7pwVg"}}},"depth":94,"prev_state":[],"origin":"localhost","origin_server_ts":1672317656609,"hashes":{"sha256":"rBuOGDY6/KAFyum4G583Uvpg1nZ8MofmjYZUpYSta8Q"},"signatures":{"localhost":{"ed25519:a_CHdg":"vcojeakCa068EyH8OPfZMFZXpk2smA5FwReeLkCLbcs7mhMFuEfyH4kXSVI7+8h6xw4gm7gqhYM4D2Jz1GQ0Dg"}},"unsigned":{"age_ts":1672317656609}}	3
$eY9D8MVKC5bDdinpPVI9ooLWvoYHx0tLFn-vRWkp9nk	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672317897316.0","historical":false}	{"auth_events":["$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$c-G9o6jTgFkz_rB_zESYfRkHoFMmTM5uCDXF1JAermc"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"first mm message"},"depth":86,"prev_state":[],"origin":"localhost","origin_server_ts":1672317897360,"hashes":{"sha256":"nrst10nsH1xBDutWU/UI1oQ53vd3shVmiT1UaACVXzw"},"signatures":{"localhost":{"ed25519:a_CHdg":"CSNGGWQTaglXhssDnhzvnY/Zufw8khiVpErxRUjii5qDKztsmzA3GEc9984Gn9J5cSMCulkwyzadA389EFwDDw"}},"unsigned":{"age_ts":1672317897360}}	3
$xKmd10QHFv5EgHAyd9HpWHkEi2QTI9MhKVlqpVntWM8	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672317899505.2","historical":false}	{"auth_events":["$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$pp-1vh-obnf3bLKs4cnpwy9dbINdz1MGiUDLrdenfek"],"type":"m.room.redaction","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{},"depth":100,"prev_state":[],"redacts":"$EdC99i51IXAQXh-JndOybB0EFIdpgm02s0Z6Takw4Jw","origin":"localhost","origin_server_ts":1672317899602,"hashes":{"sha256":"0gquaY6DcQbliYV/6qHd2AkFe4eUGW+41zYduHzz+2s"},"signatures":{"localhost":{"ed25519:a_CHdg":"0C+h3D6JK0zVXAHdODsR0fSuvwMP+gkP4hrTy5mdi9QvDeH3rfBYTwg6nP8CkMohRTDPM3k1IKDcaR8Iefl9Ag"}},"unsigned":{"age_ts":1672317899602}}	3
$gLYRtP_fFTIbdUQ6jtldLcUG60gMNlghw7x9t2_PurE	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672317899652.3","historical":false}	{"auth_events":["$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$xKmd10QHFv5EgHAyd9HpWHkEi2QTI9MhKVlqpVntWM8"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"> <@matrix_a> reply message\\n\\nlast message","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>last message","m.relates_to":{"m.in_reply_to":{"event_id":"$pp-1vh-obnf3bLKs4cnpwy9dbINdz1MGiUDLrdenfek"}}},"depth":101,"prev_state":[],"origin":"localhost","origin_server_ts":1672317899688,"hashes":{"sha256":"KdOLpprRNVOHOAcjpu/WvLPMVh1RFZfxzTu7+2h2Ias"},"signatures":{"localhost":{"ed25519:a_CHdg":"tjASsxl6+r8PuclLlmklSRV5UjBgSdpYwSuPEX3RwF6gJHpW8jmnFBDHPvBsU5GCUATkUootUHXUh+0dirGABw"}},"unsigned":{"age_ts":1672317899688}}	3
$c-G9o6jTgFkz_rB_zESYfRkHoFMmTM5uCDXF1JAermc	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672317658281.0","historical":false}	{"auth_events":["$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$T-S0-0A2-tysbZGnQHyOgfmxVouK-Ise06pRgQbLLcg"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"new message"},"depth":85,"prev_state":[],"origin":"localhost","origin_server_ts":1672317658319,"hashes":{"sha256":"Gx2wgy/9YY+Ze56y+nQCaQE6Tv3eYV7DwlbX+dbSCXY"},"signatures":{"localhost":{"ed25519:a_CHdg":"3iTptobnrDYowr3v887UITuhsGMZ8ydVelLZvNNkbmvtS2IqLssv3rH+jULjlEbguaJkSXsBdMo/lk2fRliyDw"}},"unsigned":{"age_ts":1672317658319}}	3
$dxD8VRi5x30Gu7BMEOui-JOrXZEL9meU6Q8aZra1b6U	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672317898241.1","historical":false}	{"auth_events":["$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$dtGyXiOFORXfCA1yAgiPJbV5UKJjEo-zfetInljHoV0"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"> <@matrix_b> > <@matrix_a>\\n\\nthird matrix message","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>third matrix message","m.relates_to":{"m.in_reply_to":{"event_id":"$dtGyXiOFORXfCA1yAgiPJbV5UKJjEo-zfetInljHoV0"}}},"depth":97,"prev_state":[],"origin":"localhost","origin_server_ts":1672317898341,"hashes":{"sha256":"iEzitGFQeiAz5O8hvEsCFePjgLuxUYXDLf1DWOHb2eM"},"signatures":{"localhost":{"ed25519:a_CHdg":"0P+8BVMVAFoLc15DbZN1CufbuWktRTIsU9DoiVWOwS67DYCwnqLXa2qD6fO5vXx9kZvxSAkBuIm8fcQm7/RFCg"}},"unsigned":{"age_ts":1672317898341}}	3
$RJSqE0ZymidM-ZtkpYLdrShv6_yNohaw5QtWzVooGsk	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672317899019.3","historical":false}	{"auth_events":["$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$LOcz4Bm15D4BsyuDXygSGL-0AvIjwSLYy4cezgebQK8"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"> <@matrix_b:localhost> whatever\\n\\nthird message","m.relates_to":{"m.in_reply_to":{"event_id":"$LOcz4Bm15D4BsyuDXygSGL-0AvIjwSLYy4cezgebQK8"}},"formatted_body":"<mx-reply><blockquote><a href=\\"https://matrix.to/#/!kmbTYjjsDRDHGgVqUP:localhost/$LOcz4Bm15D4BsyuDXygSGL-0AvIjwSLYy4cezgebQK8?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@matrix_b:localhost\\">@matrix_b:localhost</a><br><mx-reply>Dummy content</mx-reply>second message</blockquote></mx-reply>third message","format":"org.matrix.custom.html"},"depth":91,"prev_state":[],"origin":"localhost","origin_server_ts":1672317899053,"hashes":{"sha256":"7ipUq8GSwA06DLXWj+aACcoSCIadkjUhWBMTQ/kLwh8"},"signatures":{"localhost":{"ed25519:a_CHdg":"y7c7bTaliwt5oZZzAJ3bNIMocJkh2URxLT86WQKoYQCaPVPKNWH6dLJpC8y/qw4oSrcQcGwlfMrCNyNqLzcPBg"}},"unsigned":{"age_ts":1672317899053}}	3
$AAj21zp54kdoP3h1Zql3vB7JlPNE4Y9HrXrzBQPQrTA	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672317897583.0","historical":false}	{"auth_events":["$aa2-bg9KcCtrn4nE5HK1JGC6sa8Gr7jWqLhPgLQTtsU","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$eY9D8MVKC5bDdinpPVI9ooLWvoYHx0tLFn-vRWkp9nk"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_b:localhost","content":{"msgtype":"m.text","body":"> <@mm_mattermost_a:localhost> first mm message\\n\\nsecond mm message","m.relates_to":{"m.in_reply_to":{"event_id":"$eY9D8MVKC5bDdinpPVI9ooLWvoYHx0tLFn-vRWkp9nk"}},"formatted_body":"<mx-reply><blockquote><a href=\\"https://matrix.to/#/!kmbTYjjsDRDHGgVqUP:localhost/$eY9D8MVKC5bDdinpPVI9ooLWvoYHx0tLFn-vRWkp9nk?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@mm_mattermost_a:localhost\\">@mm_mattermost_a:localhost</a><br>first mm message</blockquote></mx-reply>second mm message","format":"org.matrix.custom.html"},"depth":87,"prev_state":[],"origin":"localhost","origin_server_ts":1672317897621,"hashes":{"sha256":"PuIbLiyzSEys7Io474JYWp8DjiwQnLN7bl1wgQzojRI"},"signatures":{"localhost":{"ed25519:a_CHdg":"aFaaUaU9IQSbO4F0n7Y6GnJ2zyuszYaT7plSZkkl/Mc+1NN0MrjPHDUw4WOixxOQIAkPYVI+wPUEfJ8qHz3xAw"}},"unsigned":{"age_ts":1672317897621}}	3
$bXKGeqgVWpdObwAv0HPtsV7_MNqo8HhD_whsZ1gxx54	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672317898569.2","historical":false}	{"auth_events":["$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$VZnQHRUET5azOmfmvUZMF1_eEKzi1_WkVHB0pxMELxo"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"first message"},"depth":89,"prev_state":[],"origin":"localhost","origin_server_ts":1672317898605,"hashes":{"sha256":"1ImwcUF8ZREuXyTR44HfpNQND5+ZiiqO083HdxGuftM"},"signatures":{"localhost":{"ed25519:a_CHdg":"N47mSNGbOBFplwhmB1ZSx0Xy1ijGCTD49yeC+nNnIR40tDBxoGk/83JrF6Q0q6Zpnq/bT4zd+z2Erp2hxTbzDA"}},"unsigned":{"age_ts":1672317898605}}	3
$EdC99i51IXAQXh-JndOybB0EFIdpgm02s0Z6Takw4Jw	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672317899263.0","historical":false}	{"auth_events":["$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$dxD8VRi5x30Gu7BMEOui-JOrXZEL9meU6Q8aZra1b6U"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"root message"},"depth":98,"prev_state":[],"origin":"localhost","origin_server_ts":1672317899297,"hashes":{"sha256":"s7t6tjFBYcuAsjK3BiIiTu6+OOzm6ov6RIAluRYwx/s"},"signatures":{"localhost":{"ed25519:a_CHdg":"qsWpjIoNxg6xG/HEbgEiFAlxl/u0wYqD/Ga3OV/S6T13xG9VbcH2xpJQANsTJivIitwWCgJDAUkCj3s0AZg1AQ"}},"unsigned":{"age_ts":1672317899297}}	3
$VZnQHRUET5azOmfmvUZMF1_eEKzi1_WkVHB0pxMELxo	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672317897764.1","historical":false}	{"auth_events":["$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$AAj21zp54kdoP3h1Zql3vB7JlPNE4Y9HrXrzBQPQrTA"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"> <@mm_mattermost_b:localhost> > <@mm_mattermost_a:localhost>\\n\\nthird mm message","m.relates_to":{"m.in_reply_to":{"event_id":"$AAj21zp54kdoP3h1Zql3vB7JlPNE4Y9HrXrzBQPQrTA"}},"formatted_body":"<mx-reply><blockquote><a href=\\"https://matrix.to/#/!kmbTYjjsDRDHGgVqUP:localhost/$AAj21zp54kdoP3h1Zql3vB7JlPNE4Y9HrXrzBQPQrTA?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@mm_mattermost_b:localhost\\">@mm_mattermost_b:localhost</a><br><mx-reply><blockquote><a href=\\"https://matrix.to/#/!kmbTYjjsDRDHGgVqUP:localhost/$eY9D8MVKC5bDdinpPVI9ooLWvoYHx0tLFn-vRWkp9nk?via=localhost\\">In reply to</a> <a href=\\"https://matrix.to/#/@mm_mattermost_a:localhost\\">@mm_mattermost_a:localhost</a><br>first mm message</blockquote></mx-reply>second mm message</blockquote></mx-reply>third mm message","format":"org.matrix.custom.html"},"depth":88,"prev_state":[],"origin":"localhost","origin_server_ts":1672317897801,"hashes":{"sha256":"oJrS/hyAgktivvPI2RRzV6lh9ykvQrV+0DJv6kMwpJ4"},"signatures":{"localhost":{"ed25519:a_CHdg":"21kOzkNXG0x2zQ+gLU1w9VFvV284d+pMGeD1LTCnnDXroBGDsS88mPMWTEzs1a6OhnR5xsQoNd3FII8mP4YJBQ"}},"unsigned":{"age_ts":1672317897801}}	3
$LOcz4Bm15D4BsyuDXygSGL-0AvIjwSLYy4cezgebQK8	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":4,"txn_id":"m1672317898765.0","historical":false}	{"auth_events":["$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$bXKGeqgVWpdObwAv0HPtsV7_MNqo8HhD_whsZ1gxx54"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_b:localhost","content":{"msgtype":"m.text","body":"whatever","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>second message","m.relates_to":{"m.in_reply_to":{"event_id":"$bXKGeqgVWpdObwAv0HPtsV7_MNqo8HhD_whsZ1gxx54"}}},"depth":90,"prev_state":[],"origin":"localhost","origin_server_ts":1672317898797,"hashes":{"sha256":"dtS/1O7wT18SOzb6W40FYXYI+3Z45BCp0oZ331Gu93U"},"signatures":{"localhost":{"ed25519:a_CHdg":"nSDm+UW7midf4/7mhXwf8hlN638CKnGY7LotL8KOwo7ZIa9IvjX3af37bWuYkL/zl3zXJiohaBtY8hw1aq94DQ"}},"unsigned":{"age_ts":1672317898797}}	3
$7q-JkspgsFYptPnMJ25LHdffz-rXLRDHzidSYCV3Kc8	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672317898001.0","historical":false}	{"auth_events":["$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$5G3tHkgsc39AkOi94e7gxCeKaPhkmyOOAZlGWI8YaCQ"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"first matrix message"},"depth":95,"prev_state":[],"origin":"localhost","origin_server_ts":1672317898031,"hashes":{"sha256":"4846/A+oEpOeUbWPFXE4PmIxRboEY04rPch4eVh/Pqc"},"signatures":{"localhost":{"ed25519:a_CHdg":"GBaUu3nNtdBXFI6tUQiH5WQUl7YLmMKQly3IuEwYAdPoGKxz/TRkej9fJcaZ1c2AUZp7DZec4DlsgF8MESbWCQ"}},"unsigned":{"age_ts":1672317898031}}	3
$pp-1vh-obnf3bLKs4cnpwy9dbINdz1MGiUDLrdenfek	!dKcbdDATuwwphjRPQP:localhost	{"token_id":3,"txn_id":"m1672317899338.1","historical":false}	{"auth_events":["$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$EdC99i51IXAQXh-JndOybB0EFIdpgm02s0Z6Takw4Jw"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matrix_a:localhost","content":{"msgtype":"m.text","body":"> <@matrix_a> root message\\n\\nreply message","format":"org.matrix.custom.html","formatted_body":"<mx-reply>Dummy content</mx-reply>reply message","m.relates_to":{"m.in_reply_to":{"event_id":"$EdC99i51IXAQXh-JndOybB0EFIdpgm02s0Z6Takw4Jw"}}},"depth":99,"prev_state":[],"origin":"localhost","origin_server_ts":1672317899445,"hashes":{"sha256":"WEqz0ha2AdyKc9eQzXHuYAWkffeAUxTUjDcRfrPQOM0"},"signatures":{"localhost":{"ed25519:a_CHdg":"uMFYHHxvBAdXMfd9rd2TiiQCYb4+bnLMekrZmmRyFUFtb1bw0vPu1DNQ7atj/y9TZpHrwmYJ1hhJqGYiy3sJAw"}},"unsigned":{"age_ts":1672317899445}}	3
$AbcQJxS0qvSibn6R_hm5OSrLKkHjrpsW8oo97om40r8	!kmbTYjjsDRDHGgVqUP:localhost	{"txn_id":"m1672317901692.0","historical":false}	{"auth_events":["$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$RJSqE0ZymidM-ZtkpYLdrShv6_yNohaw5QtWzVooGsk"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"msgtype":"m.text","body":"new message"},"depth":92,"prev_state":[],"origin":"localhost","origin_server_ts":1672317901740,"hashes":{"sha256":"nx8iNQkIyD/N7nSiPbTTW35dVtKsEgq7cSw0+CPNT9A"},"signatures":{"localhost":{"ed25519:a_CHdg":"QnXaRV2MiQnD47mV9eh7jq7w/QP5I+glE8G0rDN+zbrkGaPCN3077oeliTA4CNBANcAxCG3LSvCIVS8vFlvMBw"}},"unsigned":{"age_ts":1672317901740}}	3
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
!kmbTYjjsDRDHGgVqUP:localhost	$gnR3q3jOOEFI04MZ00yFbtQ5ZNs9EfZENfrrOEEj46s	@matrix_b:localhost	\N		25	56	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$gnR3q3jOOEFI04MZ00yFbtQ5ZNs9EfZENfrrOEEj46s	@ignored_user:localhost	\N		25	56	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$gnR3q3jOOEFI04MZ00yFbtQ5ZNs9EfZENfrrOEEj46s	@admin:localhost	\N		25	56	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$gnR3q3jOOEFI04MZ00yFbtQ5ZNs9EfZENfrrOEEj46s	@matrix_a:localhost	\N		25	56	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$gnR3q3jOOEFI04MZ00yFbtQ5ZNs9EfZENfrrOEEj46s	@matterbot:localhost	\N		25	56	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$ZI6mQ9fcQaRUQRDK0WWxDErZcQGD7ahzFrk1b9nCFRE	@matrix_b:localhost	\N		26	57	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$ZI6mQ9fcQaRUQRDK0WWxDErZcQGD7ahzFrk1b9nCFRE	@ignored_user:localhost	\N		26	57	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$ZI6mQ9fcQaRUQRDK0WWxDErZcQGD7ahzFrk1b9nCFRE	@admin:localhost	\N		26	57	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$ZI6mQ9fcQaRUQRDK0WWxDErZcQGD7ahzFrk1b9nCFRE	@matterbot:localhost	\N		26	57	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$raYGvFCt-q8kxStPhO_tzxQ3pOmVeo5gn8lTV6sHBvs	@matrix_b:localhost	\N		27	58	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$raYGvFCt-q8kxStPhO_tzxQ3pOmVeo5gn8lTV6sHBvs	@ignored_user:localhost	\N		27	58	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$raYGvFCt-q8kxStPhO_tzxQ3pOmVeo5gn8lTV6sHBvs	@admin:localhost	\N		27	58	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$raYGvFCt-q8kxStPhO_tzxQ3pOmVeo5gn8lTV6sHBvs	@matrix_a:localhost	\N		27	58	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$raYGvFCt-q8kxStPhO_tzxQ3pOmVeo5gn8lTV6sHBvs	@matterbot:localhost	\N		27	58	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$mfDu-vDNMkOg-psLHXlWcSXOnVkeuUPJfdm2cZ-3P-k	@ignored_user:localhost	\N		28	59	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$mfDu-vDNMkOg-psLHXlWcSXOnVkeuUPJfdm2cZ-3P-k	@admin:localhost	\N		28	59	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$mfDu-vDNMkOg-psLHXlWcSXOnVkeuUPJfdm2cZ-3P-k	@matrix_a:localhost	\N		28	59	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$mfDu-vDNMkOg-psLHXlWcSXOnVkeuUPJfdm2cZ-3P-k	@matterbot:localhost	\N		28	59	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$iDgp052fBKJYL2KTsRdizUAlriA5itky5-e20aiZwHI	@matrix_b:localhost	\N		29	60	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$iDgp052fBKJYL2KTsRdizUAlriA5itky5-e20aiZwHI	@ignored_user:localhost	\N		29	60	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$iDgp052fBKJYL2KTsRdizUAlriA5itky5-e20aiZwHI	@admin:localhost	\N		29	60	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$iDgp052fBKJYL2KTsRdizUAlriA5itky5-e20aiZwHI	@matterbot:localhost	\N		29	60	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$uwN8jjs4qWXT6fsX4o-36T96CWj17IDa_TJ3mF5Hd7M	@matrix_b:localhost	\N		31	61	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$uwN8jjs4qWXT6fsX4o-36T96CWj17IDa_TJ3mF5Hd7M	@ignored_user:localhost	\N		31	61	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$uwN8jjs4qWXT6fsX4o-36T96CWj17IDa_TJ3mF5Hd7M	@admin:localhost	\N		31	61	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$uwN8jjs4qWXT6fsX4o-36T96CWj17IDa_TJ3mF5Hd7M	@matrix_a:localhost	\N		31	61	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$uwN8jjs4qWXT6fsX4o-36T96CWj17IDa_TJ3mF5Hd7M	@matterbot:localhost	\N		31	61	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$mXxM94SwVR0FuKbH_riuFTeW0zH7Om62-HEudW_5y80	@matrix_b:localhost	\N		32	62	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$mXxM94SwVR0FuKbH_riuFTeW0zH7Om62-HEudW_5y80	@ignored_user:localhost	\N		32	62	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$mXxM94SwVR0FuKbH_riuFTeW0zH7Om62-HEudW_5y80	@admin:localhost	\N		32	62	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$mXxM94SwVR0FuKbH_riuFTeW0zH7Om62-HEudW_5y80	@matrix_a:localhost	\N		32	62	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$mXxM94SwVR0FuKbH_riuFTeW0zH7Om62-HEudW_5y80	@matterbot:localhost	\N		32	62	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$OVhb59gyrKY7dsgLlfdIwe1H4O5zslN774jooAK4vec	@matrix_b:localhost	\N		30	63	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$OVhb59gyrKY7dsgLlfdIwe1H4O5zslN774jooAK4vec	@ignored_user:localhost	\N		30	63	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$OVhb59gyrKY7dsgLlfdIwe1H4O5zslN774jooAK4vec	@admin:localhost	\N		30	63	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$OVhb59gyrKY7dsgLlfdIwe1H4O5zslN774jooAK4vec	@matterbot:localhost	\N		30	63	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$AxFCh7nvzu51kpXaQqyK3CKEqdyGhhJ0zhqT-c9LGPk	@matrix_b:localhost	\N		33	64	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$AxFCh7nvzu51kpXaQqyK3CKEqdyGhhJ0zhqT-c9LGPk	@ignored_user:localhost	\N		33	64	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$AxFCh7nvzu51kpXaQqyK3CKEqdyGhhJ0zhqT-c9LGPk	@admin:localhost	\N		33	64	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$AxFCh7nvzu51kpXaQqyK3CKEqdyGhhJ0zhqT-c9LGPk	@matterbot:localhost	\N		33	64	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$QjDo1bVrVGh33tmezjIVWxT6VXLutgIWlP9outS8Gcg	@matrix_b:localhost	\N		41	89	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$QjDo1bVrVGh33tmezjIVWxT6VXLutgIWlP9outS8Gcg	@ignored_user:localhost	\N		41	89	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$QjDo1bVrVGh33tmezjIVWxT6VXLutgIWlP9outS8Gcg	@admin:localhost	\N		41	89	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$QjDo1bVrVGh33tmezjIVWxT6VXLutgIWlP9outS8Gcg	@matrix_a:localhost	\N		41	89	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$QjDo1bVrVGh33tmezjIVWxT6VXLutgIWlP9outS8Gcg	@matterbot:localhost	\N		41	89	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$j4OmrTBgGXlAg2ui751-jxTS4uMSPCzpj81xWRfOWiA	@matrix_b:localhost	\N		42	90	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$j4OmrTBgGXlAg2ui751-jxTS4uMSPCzpj81xWRfOWiA	@ignored_user:localhost	\N		42	90	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$j4OmrTBgGXlAg2ui751-jxTS4uMSPCzpj81xWRfOWiA	@admin:localhost	\N		42	90	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$j4OmrTBgGXlAg2ui751-jxTS4uMSPCzpj81xWRfOWiA	@matrix_a:localhost	\N		42	90	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$j4OmrTBgGXlAg2ui751-jxTS4uMSPCzpj81xWRfOWiA	@matterbot:localhost	\N		42	90	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$lQM-XkcgjA40yc1T7BNzbZ8V8yxcnsj23SxrixdEev8	@matrix_b:localhost	\N		43	91	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$lQM-XkcgjA40yc1T7BNzbZ8V8yxcnsj23SxrixdEev8	@ignored_user:localhost	\N		43	91	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$lQM-XkcgjA40yc1T7BNzbZ8V8yxcnsj23SxrixdEev8	@admin:localhost	\N		43	91	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$lQM-XkcgjA40yc1T7BNzbZ8V8yxcnsj23SxrixdEev8	@matrix_a:localhost	\N		43	91	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$lQM-XkcgjA40yc1T7BNzbZ8V8yxcnsj23SxrixdEev8	@matterbot:localhost	\N		43	91	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$XikqApD6-vTeGUebJl-_Bc9ButeowpABz5W37dejAy0	@matrix_b:localhost	\N		44	92	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$XikqApD6-vTeGUebJl-_Bc9ButeowpABz5W37dejAy0	@ignored_user:localhost	\N		44	92	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$XikqApD6-vTeGUebJl-_Bc9ButeowpABz5W37dejAy0	@admin:localhost	\N		44	92	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$XikqApD6-vTeGUebJl-_Bc9ButeowpABz5W37dejAy0	@matrix_a:localhost	\N		44	92	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$XikqApD6-vTeGUebJl-_Bc9ButeowpABz5W37dejAy0	@matterbot:localhost	\N		44	92	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$A5qbTNFuQ1MZL2fuT4oUFzi1xCHHDk0NuQZstoz4u-U	@matrix_b:localhost	\N		48	93	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$A5qbTNFuQ1MZL2fuT4oUFzi1xCHHDk0NuQZstoz4u-U	@ignored_user:localhost	\N		48	93	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$A5qbTNFuQ1MZL2fuT4oUFzi1xCHHDk0NuQZstoz4u-U	@admin:localhost	\N		48	93	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$A5qbTNFuQ1MZL2fuT4oUFzi1xCHHDk0NuQZstoz4u-U	@matterbot:localhost	\N		48	93	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$kMqJ62yuvBi4RWfOiLMiPcoSKbfcjZvTwwiuRRmfEKA	@ignored_user:localhost	\N		49	94	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$kMqJ62yuvBi4RWfOiLMiPcoSKbfcjZvTwwiuRRmfEKA	@admin:localhost	\N		49	94	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$kMqJ62yuvBi4RWfOiLMiPcoSKbfcjZvTwwiuRRmfEKA	@matrix_a:localhost	\N		49	94	1	1	1
!dKcbdDATuwwphjRPQP:localhost	$kMqJ62yuvBi4RWfOiLMiPcoSKbfcjZvTwwiuRRmfEKA	@matterbot:localhost	\N		49	94	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$2xt0-DVGoBAEL-GIwj9HZfHBCQu7_M-HzB2XaEfxjwM	@matrix_b:localhost	\N		50	95	1	1	1
!dKcbdDATuwwphjRPQP:localhost	$2xt0-DVGoBAEL-GIwj9HZfHBCQu7_M-HzB2XaEfxjwM	@ignored_user:localhost	\N		50	95	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$2xt0-DVGoBAEL-GIwj9HZfHBCQu7_M-HzB2XaEfxjwM	@admin:localhost	\N		50	95	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$2xt0-DVGoBAEL-GIwj9HZfHBCQu7_M-HzB2XaEfxjwM	@matterbot:localhost	\N		50	95	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$6CT_ZCazUgJysnWN-q2s4b5iR-x1EbXa932nBRpldW4	@matrix_b:localhost	\N		45	96	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$6CT_ZCazUgJysnWN-q2s4b5iR-x1EbXa932nBRpldW4	@ignored_user:localhost	\N		45	96	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$6CT_ZCazUgJysnWN-q2s4b5iR-x1EbXa932nBRpldW4	@admin:localhost	\N		45	96	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$6CT_ZCazUgJysnWN-q2s4b5iR-x1EbXa932nBRpldW4	@matrix_a:localhost	\N		45	96	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$6CT_ZCazUgJysnWN-q2s4b5iR-x1EbXa932nBRpldW4	@matterbot:localhost	\N		45	96	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$UD0jEJtVKXhlCRf7VxHITWSUyhzaGkpH0VGbwilf2RE	@ignored_user:localhost	\N		46	97	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$UD0jEJtVKXhlCRf7VxHITWSUyhzaGkpH0VGbwilf2RE	@admin:localhost	\N		46	97	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$UD0jEJtVKXhlCRf7VxHITWSUyhzaGkpH0VGbwilf2RE	@matrix_a:localhost	\N		46	97	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$UD0jEJtVKXhlCRf7VxHITWSUyhzaGkpH0VGbwilf2RE	@matterbot:localhost	\N		46	97	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$BMnLymfijfp2V1tH1M6Nayfx-iF_rRw70COW60dCBG0	@matrix_b:localhost	\N		47	98	1	1	1
!kmbTYjjsDRDHGgVqUP:localhost	$BMnLymfijfp2V1tH1M6Nayfx-iF_rRw70COW60dCBG0	@ignored_user:localhost	\N		47	98	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$BMnLymfijfp2V1tH1M6Nayfx-iF_rRw70COW60dCBG0	@admin:localhost	\N		47	98	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$BMnLymfijfp2V1tH1M6Nayfx-iF_rRw70COW60dCBG0	@matrix_a:localhost	\N		47	98	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$BMnLymfijfp2V1tH1M6Nayfx-iF_rRw70COW60dCBG0	@matterbot:localhost	\N		47	98	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$UQr1C3BZK9MztXbBR2a0yz0wCyXSy_abmCstrHnXi2E	@matrix_b:localhost	\N		52	100	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$UQr1C3BZK9MztXbBR2a0yz0wCyXSy_abmCstrHnXi2E	@ignored_user:localhost	\N		52	100	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$UQr1C3BZK9MztXbBR2a0yz0wCyXSy_abmCstrHnXi2E	@admin:localhost	\N		52	100	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$UQr1C3BZK9MztXbBR2a0yz0wCyXSy_abmCstrHnXi2E	@matterbot:localhost	\N		52	100	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$p2y4ivsQApKJEQKZQ-5KFk47veZlq7V00tHHrokVqK0	@matrix_b:localhost	\N		54	102	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$p2y4ivsQApKJEQKZQ-5KFk47veZlq7V00tHHrokVqK0	@ignored_user:localhost	\N		54	102	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$p2y4ivsQApKJEQKZQ-5KFk47veZlq7V00tHHrokVqK0	@admin:localhost	\N		54	102	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$p2y4ivsQApKJEQKZQ-5KFk47veZlq7V00tHHrokVqK0	@matterbot:localhost	\N		54	102	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$VzxEyd-riDbZr-sdhUSEcA4h_6kWYfmSeoqEtaZHFFo	@matrix_b:localhost	\N		48	103	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$VzxEyd-riDbZr-sdhUSEcA4h_6kWYfmSeoqEtaZHFFo	@ignored_user:localhost	\N		48	103	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$VzxEyd-riDbZr-sdhUSEcA4h_6kWYfmSeoqEtaZHFFo	@admin:localhost	\N		48	103	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$VzxEyd-riDbZr-sdhUSEcA4h_6kWYfmSeoqEtaZHFFo	@matrix_a:localhost	\N		48	103	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$VzxEyd-riDbZr-sdhUSEcA4h_6kWYfmSeoqEtaZHFFo	@matterbot:localhost	\N		48	103	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$m8QuIxNBjngQA1UhDPZlw6nIvodE764mdmYG9oCKf94	@matrix_b:localhost	\N		59	129	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$m8QuIxNBjngQA1UhDPZlw6nIvodE764mdmYG9oCKf94	@ignored_user:localhost	\N		59	129	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$m8QuIxNBjngQA1UhDPZlw6nIvodE764mdmYG9oCKf94	@admin:localhost	\N		59	129	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$m8QuIxNBjngQA1UhDPZlw6nIvodE764mdmYG9oCKf94	@matrix_a:localhost	\N		59	129	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$m8QuIxNBjngQA1UhDPZlw6nIvodE764mdmYG9oCKf94	@matterbot:localhost	\N		59	129	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$mjUbm6eO9Jk-i6bqdyRHFZy9L-lH5TOO27GYMQ87nhs	@matrix_b:localhost	\N		60	130	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$mjUbm6eO9Jk-i6bqdyRHFZy9L-lH5TOO27GYMQ87nhs	@ignored_user:localhost	\N		60	130	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$mjUbm6eO9Jk-i6bqdyRHFZy9L-lH5TOO27GYMQ87nhs	@admin:localhost	\N		60	130	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$mjUbm6eO9Jk-i6bqdyRHFZy9L-lH5TOO27GYMQ87nhs	@matterbot:localhost	\N		60	130	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$j_Vf4RSpugcR52JQthWyGuqRIEdGrETb4ZLvnGxwwg0	@matrix_b:localhost	\N		61	131	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$j_Vf4RSpugcR52JQthWyGuqRIEdGrETb4ZLvnGxwwg0	@ignored_user:localhost	\N		61	131	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$j_Vf4RSpugcR52JQthWyGuqRIEdGrETb4ZLvnGxwwg0	@admin:localhost	\N		61	131	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$j_Vf4RSpugcR52JQthWyGuqRIEdGrETb4ZLvnGxwwg0	@matrix_a:localhost	\N		61	131	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$j_Vf4RSpugcR52JQthWyGuqRIEdGrETb4ZLvnGxwwg0	@matterbot:localhost	\N		61	131	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$iVV3o47Y40f29uNsCktD5R1VKbTF1y3nGq4KSKQ5YYo	@matrix_b:localhost	\N		71	135	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$iVV3o47Y40f29uNsCktD5R1VKbTF1y3nGq4KSKQ5YYo	@ignored_user:localhost	\N		71	135	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$iVV3o47Y40f29uNsCktD5R1VKbTF1y3nGq4KSKQ5YYo	@admin:localhost	\N		71	135	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$iVV3o47Y40f29uNsCktD5R1VKbTF1y3nGq4KSKQ5YYo	@matrix_a:localhost	\N		71	135	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$iVV3o47Y40f29uNsCktD5R1VKbTF1y3nGq4KSKQ5YYo	@matterbot:localhost	\N		71	135	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$kdWmWl1h_wHbp_4CZHM4AOF1I3SpjgbLYkYoFiWiazU	@ignored_user:localhost	\N		62	132	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$kdWmWl1h_wHbp_4CZHM4AOF1I3SpjgbLYkYoFiWiazU	@admin:localhost	\N		62	132	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$kdWmWl1h_wHbp_4CZHM4AOF1I3SpjgbLYkYoFiWiazU	@matrix_a:localhost	\N		62	132	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$kdWmWl1h_wHbp_4CZHM4AOF1I3SpjgbLYkYoFiWiazU	@matterbot:localhost	\N		62	132	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$RuT3uWLcY4y4GhqYFFNXur6XuNwXipRRmx5rJFfM9ms	@matrix_b:localhost	\N		70	133	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$RuT3uWLcY4y4GhqYFFNXur6XuNwXipRRmx5rJFfM9ms	@ignored_user:localhost	\N		70	133	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$RuT3uWLcY4y4GhqYFFNXur6XuNwXipRRmx5rJFfM9ms	@admin:localhost	\N		70	133	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$RuT3uWLcY4y4GhqYFFNXur6XuNwXipRRmx5rJFfM9ms	@matrix_a:localhost	\N		70	133	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$RuT3uWLcY4y4GhqYFFNXur6XuNwXipRRmx5rJFfM9ms	@matterbot:localhost	\N		70	133	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$sD72WUGTkmqfbvA4mcCNx5IcT-WfbmjsGalYB6V6S-E	@matrix_b:localhost	\N		63	134	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$sD72WUGTkmqfbvA4mcCNx5IcT-WfbmjsGalYB6V6S-E	@ignored_user:localhost	\N		63	134	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$sD72WUGTkmqfbvA4mcCNx5IcT-WfbmjsGalYB6V6S-E	@admin:localhost	\N		63	134	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$sD72WUGTkmqfbvA4mcCNx5IcT-WfbmjsGalYB6V6S-E	@matterbot:localhost	\N		63	134	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$kkmwTP1mOPGymh7Q3_N1Y7ftC1xrv5qaHbV_zi99vD4	@matrix_b:localhost	\N		72	136	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$kkmwTP1mOPGymh7Q3_N1Y7ftC1xrv5qaHbV_zi99vD4	@ignored_user:localhost	\N		72	136	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$kkmwTP1mOPGymh7Q3_N1Y7ftC1xrv5qaHbV_zi99vD4	@admin:localhost	\N		72	136	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$kkmwTP1mOPGymh7Q3_N1Y7ftC1xrv5qaHbV_zi99vD4	@matrix_a:localhost	\N		72	136	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$kkmwTP1mOPGymh7Q3_N1Y7ftC1xrv5qaHbV_zi99vD4	@matterbot:localhost	\N		72	136	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$99PDED6qRD6JvJgyuUpKL5SGciNeDx4Q8aNU8-knIfI	@matrix_b:localhost	\N		64	137	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$99PDED6qRD6JvJgyuUpKL5SGciNeDx4Q8aNU8-knIfI	@ignored_user:localhost	\N		64	137	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$99PDED6qRD6JvJgyuUpKL5SGciNeDx4Q8aNU8-knIfI	@admin:localhost	\N		64	137	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$99PDED6qRD6JvJgyuUpKL5SGciNeDx4Q8aNU8-knIfI	@matterbot:localhost	\N		64	137	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$53rDO0S-X2QNPUyUVrTGx092yf0EW0nvJXQNLgQ09kc	@matrix_b:localhost	\N		73	138	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$53rDO0S-X2QNPUyUVrTGx092yf0EW0nvJXQNLgQ09kc	@ignored_user:localhost	\N		73	138	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$53rDO0S-X2QNPUyUVrTGx092yf0EW0nvJXQNLgQ09kc	@admin:localhost	\N		73	138	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$53rDO0S-X2QNPUyUVrTGx092yf0EW0nvJXQNLgQ09kc	@matterbot:localhost	\N		73	138	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$OL5YFZuIzpeGWvQkJsWD5fA-_tqvM6MNM8aACLhDIKc	@matrix_b:localhost	\N		65	139	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$OL5YFZuIzpeGWvQkJsWD5fA-_tqvM6MNM8aACLhDIKc	@ignored_user:localhost	\N		65	139	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$OL5YFZuIzpeGWvQkJsWD5fA-_tqvM6MNM8aACLhDIKc	@admin:localhost	\N		65	139	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$OL5YFZuIzpeGWvQkJsWD5fA-_tqvM6MNM8aACLhDIKc	@matrix_a:localhost	\N		65	139	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$OL5YFZuIzpeGWvQkJsWD5fA-_tqvM6MNM8aACLhDIKc	@matterbot:localhost	\N		65	139	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$WxOx5K9OBtSH4SKkxlQDUCVkiuA8mdui6eTN417KUig	@matrix_b:localhost	\N		66	140	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$WxOx5K9OBtSH4SKkxlQDUCVkiuA8mdui6eTN417KUig	@ignored_user:localhost	\N		66	140	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$WxOx5K9OBtSH4SKkxlQDUCVkiuA8mdui6eTN417KUig	@admin:localhost	\N		66	140	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$WxOx5K9OBtSH4SKkxlQDUCVkiuA8mdui6eTN417KUig	@matrix_a:localhost	\N		66	140	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$WxOx5K9OBtSH4SKkxlQDUCVkiuA8mdui6eTN417KUig	@matterbot:localhost	\N		66	140	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$9eV_AyLXyN9dQJyo8nKzxH0MD2Pj26OD3m5hxM368ek	@matrix_b:localhost	\N		67	141	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$9eV_AyLXyN9dQJyo8nKzxH0MD2Pj26OD3m5hxM368ek	@ignored_user:localhost	\N		67	141	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$9eV_AyLXyN9dQJyo8nKzxH0MD2Pj26OD3m5hxM368ek	@admin:localhost	\N		67	141	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$9eV_AyLXyN9dQJyo8nKzxH0MD2Pj26OD3m5hxM368ek	@matrix_a:localhost	\N		67	141	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$9eV_AyLXyN9dQJyo8nKzxH0MD2Pj26OD3m5hxM368ek	@matterbot:localhost	\N		67	141	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$KAudDRl-ilYkXdKdFFwSH1rjB9FuDL3iaIcj9chsvuc	@matrix_b:localhost	\N		74	142	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$KAudDRl-ilYkXdKdFFwSH1rjB9FuDL3iaIcj9chsvuc	@ignored_user:localhost	\N		74	142	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$KAudDRl-ilYkXdKdFFwSH1rjB9FuDL3iaIcj9chsvuc	@admin:localhost	\N		74	142	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$KAudDRl-ilYkXdKdFFwSH1rjB9FuDL3iaIcj9chsvuc	@matterbot:localhost	\N		74	142	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$NBW9KofbXfyJlflrssj5f0gU9-vix_ChkMTdCTutt6E	@ignored_user:localhost	\N		75	143	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$NBW9KofbXfyJlflrssj5f0gU9-vix_ChkMTdCTutt6E	@admin:localhost	\N		75	143	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$NBW9KofbXfyJlflrssj5f0gU9-vix_ChkMTdCTutt6E	@matrix_a:localhost	\N		75	143	1	1	1
!dKcbdDATuwwphjRPQP:localhost	$NBW9KofbXfyJlflrssj5f0gU9-vix_ChkMTdCTutt6E	@matterbot:localhost	\N		75	143	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$G4jqJ_vLOuComzEY5LKlWgJmqk76rEv2BaFnoUc32C4	@matrix_b:localhost	\N		76	144	1	1	1
!dKcbdDATuwwphjRPQP:localhost	$G4jqJ_vLOuComzEY5LKlWgJmqk76rEv2BaFnoUc32C4	@ignored_user:localhost	\N		76	144	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$G4jqJ_vLOuComzEY5LKlWgJmqk76rEv2BaFnoUc32C4	@admin:localhost	\N		76	144	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$G4jqJ_vLOuComzEY5LKlWgJmqk76rEv2BaFnoUc32C4	@matterbot:localhost	\N		76	144	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$PmdsaAuptefoxepoi5dH3S5XZjMQnrw_IY8E3iiC0JI	@matrix_b:localhost	\N		68	145	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$PmdsaAuptefoxepoi5dH3S5XZjMQnrw_IY8E3iiC0JI	@ignored_user:localhost	\N		68	145	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$PmdsaAuptefoxepoi5dH3S5XZjMQnrw_IY8E3iiC0JI	@admin:localhost	\N		68	145	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$PmdsaAuptefoxepoi5dH3S5XZjMQnrw_IY8E3iiC0JI	@matrix_a:localhost	\N		68	145	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$PmdsaAuptefoxepoi5dH3S5XZjMQnrw_IY8E3iiC0JI	@matterbot:localhost	\N		68	145	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$LLxGQgsj2x835E7aJtEtKuPEzf1fHJTT_1b0cxZaynk	@ignored_user:localhost	\N		69	146	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$LLxGQgsj2x835E7aJtEtKuPEzf1fHJTT_1b0cxZaynk	@admin:localhost	\N		69	146	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$LLxGQgsj2x835E7aJtEtKuPEzf1fHJTT_1b0cxZaynk	@matrix_a:localhost	\N		69	146	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$LLxGQgsj2x835E7aJtEtKuPEzf1fHJTT_1b0cxZaynk	@matterbot:localhost	\N		69	146	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$xaKVxYK5Ka0brhbVcFdQdutgxYlZom-dUIRWmloBBms	@matrix_b:localhost	\N		70	147	1	1	1
!kmbTYjjsDRDHGgVqUP:localhost	$xaKVxYK5Ka0brhbVcFdQdutgxYlZom-dUIRWmloBBms	@ignored_user:localhost	\N		70	147	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$xaKVxYK5Ka0brhbVcFdQdutgxYlZom-dUIRWmloBBms	@admin:localhost	\N		70	147	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$xaKVxYK5Ka0brhbVcFdQdutgxYlZom-dUIRWmloBBms	@matrix_a:localhost	\N		70	147	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$xaKVxYK5Ka0brhbVcFdQdutgxYlZom-dUIRWmloBBms	@matterbot:localhost	\N		70	147	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$iZZsHDRKa9MPh0wKPGoTIkR9_IN1gXmgYQ3CLA-oEsU	@matrix_b:localhost	\N		78	149	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$iZZsHDRKa9MPh0wKPGoTIkR9_IN1gXmgYQ3CLA-oEsU	@ignored_user:localhost	\N		78	149	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$iZZsHDRKa9MPh0wKPGoTIkR9_IN1gXmgYQ3CLA-oEsU	@admin:localhost	\N		78	149	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$iZZsHDRKa9MPh0wKPGoTIkR9_IN1gXmgYQ3CLA-oEsU	@matterbot:localhost	\N		78	149	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$OIgyn6WfwavdRqCIV587JtVG-UzMqFnY1_VC_N2O6ok	@matrix_b:localhost	\N		80	151	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$OIgyn6WfwavdRqCIV587JtVG-UzMqFnY1_VC_N2O6ok	@ignored_user:localhost	\N		80	151	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$OIgyn6WfwavdRqCIV587JtVG-UzMqFnY1_VC_N2O6ok	@admin:localhost	\N		80	151	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$OIgyn6WfwavdRqCIV587JtVG-UzMqFnY1_VC_N2O6ok	@matterbot:localhost	\N		80	151	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$z-yABBMUu-RFJeiOLWwmWghP2O4vgO3Bts6c9FX-uG8	@matrix_b:localhost	\N		71	152	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$z-yABBMUu-RFJeiOLWwmWghP2O4vgO3Bts6c9FX-uG8	@ignored_user:localhost	\N		71	152	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$z-yABBMUu-RFJeiOLWwmWghP2O4vgO3Bts6c9FX-uG8	@admin:localhost	\N		71	152	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$z-yABBMUu-RFJeiOLWwmWghP2O4vgO3Bts6c9FX-uG8	@matrix_a:localhost	\N		71	152	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$z-yABBMUu-RFJeiOLWwmWghP2O4vgO3Bts6c9FX-uG8	@matterbot:localhost	\N		71	152	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$P2eP-7teBmGXcBM7DqUedLeBNdY5eaTasFqCr7GXY74	@matterbot:localhost	\N		72	153	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$P2eP-7teBmGXcBM7DqUedLeBNdY5eaTasFqCr7GXY74	@admin:localhost	\N		72	153	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$P2eP-7teBmGXcBM7DqUedLeBNdY5eaTasFqCr7GXY74	@ignored_user:localhost	\N		72	153	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$P2eP-7teBmGXcBM7DqUedLeBNdY5eaTasFqCr7GXY74	@matrix_b:localhost	\N		72	153	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$P2eP-7teBmGXcBM7DqUedLeBNdY5eaTasFqCr7GXY74	@matrix_a:localhost	\N		72	153	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$62DK_5Urc-R1gCm6T-D7rEFWp3Q47rECTaNApSOe0tg	@matterbot:localhost	\N		73	154	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$62DK_5Urc-R1gCm6T-D7rEFWp3Q47rECTaNApSOe0tg	@admin:localhost	\N		73	154	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$62DK_5Urc-R1gCm6T-D7rEFWp3Q47rECTaNApSOe0tg	@ignored_user:localhost	\N		73	154	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$62DK_5Urc-R1gCm6T-D7rEFWp3Q47rECTaNApSOe0tg	@matrix_b:localhost	\N		73	154	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$62DK_5Urc-R1gCm6T-D7rEFWp3Q47rECTaNApSOe0tg	@matrix_a:localhost	\N		73	154	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$reo6-sRCAReTplLLrWZiUXEMMfaufd1o-PclhKbhxXw	@matterbot:localhost	\N		74	155	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$reo6-sRCAReTplLLrWZiUXEMMfaufd1o-PclhKbhxXw	@admin:localhost	\N		74	155	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$reo6-sRCAReTplLLrWZiUXEMMfaufd1o-PclhKbhxXw	@ignored_user:localhost	\N		74	155	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$reo6-sRCAReTplLLrWZiUXEMMfaufd1o-PclhKbhxXw	@matrix_b:localhost	\N		74	155	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$reo6-sRCAReTplLLrWZiUXEMMfaufd1o-PclhKbhxXw	@matrix_a:localhost	\N		74	155	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$LiUaGyMC-ZVhJFLD9EeZsUNlhdIzJ2J41q-tpdMYQ-g	@matterbot:localhost	\N		81	156	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$LiUaGyMC-ZVhJFLD9EeZsUNlhdIzJ2J41q-tpdMYQ-g	@admin:localhost	\N		81	156	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$LiUaGyMC-ZVhJFLD9EeZsUNlhdIzJ2J41q-tpdMYQ-g	@ignored_user:localhost	\N		81	156	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$LiUaGyMC-ZVhJFLD9EeZsUNlhdIzJ2J41q-tpdMYQ-g	@matrix_b:localhost	\N		81	156	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$kGXjbDILpzPlAVquVm-0ro1Y2cAjvBSU3chLQmB-ZgI	@matterbot:localhost	\N		82	157	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$kGXjbDILpzPlAVquVm-0ro1Y2cAjvBSU3chLQmB-ZgI	@admin:localhost	\N		82	157	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$kGXjbDILpzPlAVquVm-0ro1Y2cAjvBSU3chLQmB-ZgI	@ignored_user:localhost	\N		82	157	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$kGXjbDILpzPlAVquVm-0ro1Y2cAjvBSU3chLQmB-ZgI	@matrix_a:localhost	\N		82	157	1	1	1
!dKcbdDATuwwphjRPQP:localhost	$iR6CRvH8xG5VgeMQIZFMBeaVeTjxgDtnqT7tv-PoCf8	@matterbot:localhost	\N		83	158	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$iR6CRvH8xG5VgeMQIZFMBeaVeTjxgDtnqT7tv-PoCf8	@admin:localhost	\N		83	158	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$iR6CRvH8xG5VgeMQIZFMBeaVeTjxgDtnqT7tv-PoCf8	@ignored_user:localhost	\N		83	158	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$iR6CRvH8xG5VgeMQIZFMBeaVeTjxgDtnqT7tv-PoCf8	@matrix_b:localhost	\N		83	158	1	1	1
!kmbTYjjsDRDHGgVqUP:localhost	$47BkoMnB5FT3PSdXLEy0rb4ZdbS1q9w82a669O4lBXg	@matterbot:localhost	\N		75	159	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$47BkoMnB5FT3PSdXLEy0rb4ZdbS1q9w82a669O4lBXg	@admin:localhost	\N		75	159	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$47BkoMnB5FT3PSdXLEy0rb4ZdbS1q9w82a669O4lBXg	@ignored_user:localhost	\N		75	159	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$47BkoMnB5FT3PSdXLEy0rb4ZdbS1q9w82a669O4lBXg	@matrix_b:localhost	\N		75	159	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$47BkoMnB5FT3PSdXLEy0rb4ZdbS1q9w82a669O4lBXg	@matrix_a:localhost	\N		75	159	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$zI1CZE-pX4aF7RBiJiZqzqFZlxIfJRBpmSuBjEzHTCQ	@matterbot:localhost	\N		76	160	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$zI1CZE-pX4aF7RBiJiZqzqFZlxIfJRBpmSuBjEzHTCQ	@admin:localhost	\N		76	160	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$zI1CZE-pX4aF7RBiJiZqzqFZlxIfJRBpmSuBjEzHTCQ	@ignored_user:localhost	\N		76	160	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$zI1CZE-pX4aF7RBiJiZqzqFZlxIfJRBpmSuBjEzHTCQ	@matrix_a:localhost	\N		76	160	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$y7fmz8cz_zrBS0ZmRnthufiCH3PFkuCVz8YKzQaf81g	@matterbot:localhost	\N		77	161	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$y7fmz8cz_zrBS0ZmRnthufiCH3PFkuCVz8YKzQaf81g	@admin:localhost	\N		77	161	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$y7fmz8cz_zrBS0ZmRnthufiCH3PFkuCVz8YKzQaf81g	@ignored_user:localhost	\N		77	161	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$y7fmz8cz_zrBS0ZmRnthufiCH3PFkuCVz8YKzQaf81g	@matrix_b:localhost	\N		77	161	1	1	1
!kmbTYjjsDRDHGgVqUP:localhost	$y7fmz8cz_zrBS0ZmRnthufiCH3PFkuCVz8YKzQaf81g	@matrix_a:localhost	\N		77	161	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$p7GJemyaMZGUqYX0guKHUqmObfwF2yChmhI7v1sn2nE	@matterbot:localhost	\N		85	163	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$p7GJemyaMZGUqYX0guKHUqmObfwF2yChmhI7v1sn2nE	@admin:localhost	\N		85	163	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$p7GJemyaMZGUqYX0guKHUqmObfwF2yChmhI7v1sn2nE	@ignored_user:localhost	\N		85	163	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$p7GJemyaMZGUqYX0guKHUqmObfwF2yChmhI7v1sn2nE	@matrix_b:localhost	\N		85	163	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$5Iq2ZU88BXgNKKqMGOu71dH7vsyaxwI-Fxg8ocEMI2E	@matterbot:localhost	\N		87	165	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$5Iq2ZU88BXgNKKqMGOu71dH7vsyaxwI-Fxg8ocEMI2E	@admin:localhost	\N		87	165	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$5Iq2ZU88BXgNKKqMGOu71dH7vsyaxwI-Fxg8ocEMI2E	@ignored_user:localhost	\N		87	165	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$5Iq2ZU88BXgNKKqMGOu71dH7vsyaxwI-Fxg8ocEMI2E	@matrix_b:localhost	\N		87	165	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$LHW3l0dgme8yNUY6xjIvP_Osal1_vZAuIfg7vCLzGKI	@matterbot:localhost	\N		78	166	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$LHW3l0dgme8yNUY6xjIvP_Osal1_vZAuIfg7vCLzGKI	@admin:localhost	\N		78	166	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$LHW3l0dgme8yNUY6xjIvP_Osal1_vZAuIfg7vCLzGKI	@ignored_user:localhost	\N		78	166	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$LHW3l0dgme8yNUY6xjIvP_Osal1_vZAuIfg7vCLzGKI	@matrix_b:localhost	\N		78	166	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$LHW3l0dgme8yNUY6xjIvP_Osal1_vZAuIfg7vCLzGKI	@matrix_a:localhost	\N		78	166	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$_XRh5iYtBtMSC8b9sq-Zq1kS1LqI6azDTXLEGQTiQSs	@matterbot:localhost	\N		79	167	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$_XRh5iYtBtMSC8b9sq-Zq1kS1LqI6azDTXLEGQTiQSs	@admin:localhost	\N		79	167	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$_XRh5iYtBtMSC8b9sq-Zq1kS1LqI6azDTXLEGQTiQSs	@ignored_user:localhost	\N		79	167	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$_XRh5iYtBtMSC8b9sq-Zq1kS1LqI6azDTXLEGQTiQSs	@matrix_b:localhost	\N		79	167	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$_XRh5iYtBtMSC8b9sq-Zq1kS1LqI6azDTXLEGQTiQSs	@matrix_a:localhost	\N		79	167	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$jgIb5yphKm1y65Shpo1bZF38fQ0ZqUjOopYEMjB2JS0	@matterbot:localhost	\N		80	168	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$jgIb5yphKm1y65Shpo1bZF38fQ0ZqUjOopYEMjB2JS0	@admin:localhost	\N		80	168	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$jgIb5yphKm1y65Shpo1bZF38fQ0ZqUjOopYEMjB2JS0	@ignored_user:localhost	\N		80	168	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$jgIb5yphKm1y65Shpo1bZF38fQ0ZqUjOopYEMjB2JS0	@matrix_b:localhost	\N		80	168	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$jgIb5yphKm1y65Shpo1bZF38fQ0ZqUjOopYEMjB2JS0	@matrix_a:localhost	\N		80	168	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$j96SJY0VtGl6Q_Fnj_jg3BifdW7s0-Vd8t57DrAeAX8	@matterbot:localhost	\N		81	169	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$j96SJY0VtGl6Q_Fnj_jg3BifdW7s0-Vd8t57DrAeAX8	@admin:localhost	\N		81	169	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$j96SJY0VtGl6Q_Fnj_jg3BifdW7s0-Vd8t57DrAeAX8	@ignored_user:localhost	\N		81	169	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$j96SJY0VtGl6Q_Fnj_jg3BifdW7s0-Vd8t57DrAeAX8	@matrix_b:localhost	\N		81	169	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$j96SJY0VtGl6Q_Fnj_jg3BifdW7s0-Vd8t57DrAeAX8	@matrix_a:localhost	\N		81	169	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$5-UBR4vNvgnHcUIuQA0gIHJmn4pOL-BNEZ33B-2Dmes	@matterbot:localhost	\N		88	170	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$5-UBR4vNvgnHcUIuQA0gIHJmn4pOL-BNEZ33B-2Dmes	@admin:localhost	\N		88	170	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$5-UBR4vNvgnHcUIuQA0gIHJmn4pOL-BNEZ33B-2Dmes	@ignored_user:localhost	\N		88	170	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$5-UBR4vNvgnHcUIuQA0gIHJmn4pOL-BNEZ33B-2Dmes	@matrix_b:localhost	\N		88	170	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$8f7euYUQUOKVs1LECS5C0ny-iJc0LrEhKy5AjaE9VwM	@matterbot:localhost	\N		89	171	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$8f7euYUQUOKVs1LECS5C0ny-iJc0LrEhKy5AjaE9VwM	@admin:localhost	\N		89	171	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$8f7euYUQUOKVs1LECS5C0ny-iJc0LrEhKy5AjaE9VwM	@ignored_user:localhost	\N		89	171	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$8f7euYUQUOKVs1LECS5C0ny-iJc0LrEhKy5AjaE9VwM	@matrix_a:localhost	\N		89	171	1	1	1
!dKcbdDATuwwphjRPQP:localhost	$n7rEuNOUTfPAb-nKtA8sQLtp0FZoDqOfMyqN9eKVULc	@matterbot:localhost	\N		90	172	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$n7rEuNOUTfPAb-nKtA8sQLtp0FZoDqOfMyqN9eKVULc	@admin:localhost	\N		90	172	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$n7rEuNOUTfPAb-nKtA8sQLtp0FZoDqOfMyqN9eKVULc	@ignored_user:localhost	\N		90	172	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$n7rEuNOUTfPAb-nKtA8sQLtp0FZoDqOfMyqN9eKVULc	@matrix_b:localhost	\N		90	172	1	1	1
!kmbTYjjsDRDHGgVqUP:localhost	$KdF0e2L1V2qamNtPDDdbE1nZ8xvaqEBCeH0VcCCosQ8	@matterbot:localhost	\N		82	173	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$KdF0e2L1V2qamNtPDDdbE1nZ8xvaqEBCeH0VcCCosQ8	@admin:localhost	\N		82	173	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$KdF0e2L1V2qamNtPDDdbE1nZ8xvaqEBCeH0VcCCosQ8	@ignored_user:localhost	\N		82	173	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$KdF0e2L1V2qamNtPDDdbE1nZ8xvaqEBCeH0VcCCosQ8	@matrix_b:localhost	\N		82	173	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$KdF0e2L1V2qamNtPDDdbE1nZ8xvaqEBCeH0VcCCosQ8	@matrix_a:localhost	\N		82	173	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$VGPWrlgPM0aSEOjGq1_ygJ2gwcjdfMl06P2yF-1EjMw	@matterbot:localhost	\N		83	174	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$VGPWrlgPM0aSEOjGq1_ygJ2gwcjdfMl06P2yF-1EjMw	@admin:localhost	\N		83	174	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$VGPWrlgPM0aSEOjGq1_ygJ2gwcjdfMl06P2yF-1EjMw	@ignored_user:localhost	\N		83	174	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$VGPWrlgPM0aSEOjGq1_ygJ2gwcjdfMl06P2yF-1EjMw	@matrix_a:localhost	\N		83	174	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$T-S0-0A2-tysbZGnQHyOgfmxVouK-Ise06pRgQbLLcg	@matterbot:localhost	\N		84	175	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$T-S0-0A2-tysbZGnQHyOgfmxVouK-Ise06pRgQbLLcg	@admin:localhost	\N		84	175	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$T-S0-0A2-tysbZGnQHyOgfmxVouK-Ise06pRgQbLLcg	@ignored_user:localhost	\N		84	175	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$T-S0-0A2-tysbZGnQHyOgfmxVouK-Ise06pRgQbLLcg	@matrix_b:localhost	\N		84	175	1	1	1
!kmbTYjjsDRDHGgVqUP:localhost	$T-S0-0A2-tysbZGnQHyOgfmxVouK-Ise06pRgQbLLcg	@matrix_a:localhost	\N		84	175	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$c-G9o6jTgFkz_rB_zESYfRkHoFMmTM5uCDXF1JAermc	@matterbot:localhost	\N		85	180	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$c-G9o6jTgFkz_rB_zESYfRkHoFMmTM5uCDXF1JAermc	@admin:localhost	\N		85	180	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$c-G9o6jTgFkz_rB_zESYfRkHoFMmTM5uCDXF1JAermc	@ignored_user:localhost	\N		85	180	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$c-G9o6jTgFkz_rB_zESYfRkHoFMmTM5uCDXF1JAermc	@matrix_b:localhost	\N		85	180	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$c-G9o6jTgFkz_rB_zESYfRkHoFMmTM5uCDXF1JAermc	@matrix_a:localhost	\N		85	180	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$8Hjay0ed9n_Y3vv-Lhtc_-A0-5CvZe8YsPugJA7pwVg	@matterbot:localhost	\N		92	177	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$8Hjay0ed9n_Y3vv-Lhtc_-A0-5CvZe8YsPugJA7pwVg	@admin:localhost	\N		92	177	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$8Hjay0ed9n_Y3vv-Lhtc_-A0-5CvZe8YsPugJA7pwVg	@ignored_user:localhost	\N		92	177	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$8Hjay0ed9n_Y3vv-Lhtc_-A0-5CvZe8YsPugJA7pwVg	@matrix_b:localhost	\N		92	177	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$5G3tHkgsc39AkOi94e7gxCeKaPhkmyOOAZlGWI8YaCQ	@matterbot:localhost	\N		94	179	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$5G3tHkgsc39AkOi94e7gxCeKaPhkmyOOAZlGWI8YaCQ	@admin:localhost	\N		94	179	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$5G3tHkgsc39AkOi94e7gxCeKaPhkmyOOAZlGWI8YaCQ	@ignored_user:localhost	\N		94	179	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$5G3tHkgsc39AkOi94e7gxCeKaPhkmyOOAZlGWI8YaCQ	@matrix_b:localhost	\N		94	179	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$eY9D8MVKC5bDdinpPVI9ooLWvoYHx0tLFn-vRWkp9nk	@matterbot:localhost	\N		86	181	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$eY9D8MVKC5bDdinpPVI9ooLWvoYHx0tLFn-vRWkp9nk	@admin:localhost	\N		86	181	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$eY9D8MVKC5bDdinpPVI9ooLWvoYHx0tLFn-vRWkp9nk	@ignored_user:localhost	\N		86	181	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$eY9D8MVKC5bDdinpPVI9ooLWvoYHx0tLFn-vRWkp9nk	@matrix_b:localhost	\N		86	181	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$eY9D8MVKC5bDdinpPVI9ooLWvoYHx0tLFn-vRWkp9nk	@matrix_a:localhost	\N		86	181	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$AAj21zp54kdoP3h1Zql3vB7JlPNE4Y9HrXrzBQPQrTA	@matterbot:localhost	\N		87	182	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$AAj21zp54kdoP3h1Zql3vB7JlPNE4Y9HrXrzBQPQrTA	@admin:localhost	\N		87	182	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$AAj21zp54kdoP3h1Zql3vB7JlPNE4Y9HrXrzBQPQrTA	@ignored_user:localhost	\N		87	182	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$AAj21zp54kdoP3h1Zql3vB7JlPNE4Y9HrXrzBQPQrTA	@matrix_b:localhost	\N		87	182	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$AAj21zp54kdoP3h1Zql3vB7JlPNE4Y9HrXrzBQPQrTA	@matrix_a:localhost	\N		87	182	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$VZnQHRUET5azOmfmvUZMF1_eEKzi1_WkVHB0pxMELxo	@matterbot:localhost	\N		88	183	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$VZnQHRUET5azOmfmvUZMF1_eEKzi1_WkVHB0pxMELxo	@admin:localhost	\N		88	183	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$VZnQHRUET5azOmfmvUZMF1_eEKzi1_WkVHB0pxMELxo	@ignored_user:localhost	\N		88	183	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$VZnQHRUET5azOmfmvUZMF1_eEKzi1_WkVHB0pxMELxo	@matrix_b:localhost	\N		88	183	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$VZnQHRUET5azOmfmvUZMF1_eEKzi1_WkVHB0pxMELxo	@matrix_a:localhost	\N		88	183	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$7q-JkspgsFYptPnMJ25LHdffz-rXLRDHzidSYCV3Kc8	@matterbot:localhost	\N		95	184	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$7q-JkspgsFYptPnMJ25LHdffz-rXLRDHzidSYCV3Kc8	@admin:localhost	\N		95	184	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$7q-JkspgsFYptPnMJ25LHdffz-rXLRDHzidSYCV3Kc8	@ignored_user:localhost	\N		95	184	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$7q-JkspgsFYptPnMJ25LHdffz-rXLRDHzidSYCV3Kc8	@matrix_b:localhost	\N		95	184	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$dtGyXiOFORXfCA1yAgiPJbV5UKJjEo-zfetInljHoV0	@matterbot:localhost	\N		96	185	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$dtGyXiOFORXfCA1yAgiPJbV5UKJjEo-zfetInljHoV0	@admin:localhost	\N		96	185	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$dtGyXiOFORXfCA1yAgiPJbV5UKJjEo-zfetInljHoV0	@ignored_user:localhost	\N		96	185	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$dtGyXiOFORXfCA1yAgiPJbV5UKJjEo-zfetInljHoV0	@matrix_a:localhost	\N		96	185	1	1	1
!dKcbdDATuwwphjRPQP:localhost	$dxD8VRi5x30Gu7BMEOui-JOrXZEL9meU6Q8aZra1b6U	@matterbot:localhost	\N		97	186	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$dxD8VRi5x30Gu7BMEOui-JOrXZEL9meU6Q8aZra1b6U	@admin:localhost	\N		97	186	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$dxD8VRi5x30Gu7BMEOui-JOrXZEL9meU6Q8aZra1b6U	@ignored_user:localhost	\N		97	186	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$dxD8VRi5x30Gu7BMEOui-JOrXZEL9meU6Q8aZra1b6U	@matrix_b:localhost	\N		97	186	1	1	1
!kmbTYjjsDRDHGgVqUP:localhost	$bXKGeqgVWpdObwAv0HPtsV7_MNqo8HhD_whsZ1gxx54	@matterbot:localhost	\N		89	187	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$bXKGeqgVWpdObwAv0HPtsV7_MNqo8HhD_whsZ1gxx54	@admin:localhost	\N		89	187	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$bXKGeqgVWpdObwAv0HPtsV7_MNqo8HhD_whsZ1gxx54	@ignored_user:localhost	\N		89	187	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$bXKGeqgVWpdObwAv0HPtsV7_MNqo8HhD_whsZ1gxx54	@matrix_b:localhost	\N		89	187	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$bXKGeqgVWpdObwAv0HPtsV7_MNqo8HhD_whsZ1gxx54	@matrix_a:localhost	\N		89	187	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$LOcz4Bm15D4BsyuDXygSGL-0AvIjwSLYy4cezgebQK8	@matterbot:localhost	\N		90	188	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$LOcz4Bm15D4BsyuDXygSGL-0AvIjwSLYy4cezgebQK8	@admin:localhost	\N		90	188	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$LOcz4Bm15D4BsyuDXygSGL-0AvIjwSLYy4cezgebQK8	@ignored_user:localhost	\N		90	188	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$LOcz4Bm15D4BsyuDXygSGL-0AvIjwSLYy4cezgebQK8	@matrix_a:localhost	\N		90	188	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$RJSqE0ZymidM-ZtkpYLdrShv6_yNohaw5QtWzVooGsk	@matterbot:localhost	\N		91	189	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$RJSqE0ZymidM-ZtkpYLdrShv6_yNohaw5QtWzVooGsk	@admin:localhost	\N		91	189	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$RJSqE0ZymidM-ZtkpYLdrShv6_yNohaw5QtWzVooGsk	@ignored_user:localhost	\N		91	189	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$RJSqE0ZymidM-ZtkpYLdrShv6_yNohaw5QtWzVooGsk	@matrix_b:localhost	\N		91	189	1	1	1
!kmbTYjjsDRDHGgVqUP:localhost	$RJSqE0ZymidM-ZtkpYLdrShv6_yNohaw5QtWzVooGsk	@matrix_a:localhost	\N		91	189	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$pp-1vh-obnf3bLKs4cnpwy9dbINdz1MGiUDLrdenfek	@matterbot:localhost	\N		99	191	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$pp-1vh-obnf3bLKs4cnpwy9dbINdz1MGiUDLrdenfek	@admin:localhost	\N		99	191	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$pp-1vh-obnf3bLKs4cnpwy9dbINdz1MGiUDLrdenfek	@ignored_user:localhost	\N		99	191	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$pp-1vh-obnf3bLKs4cnpwy9dbINdz1MGiUDLrdenfek	@matrix_b:localhost	\N		99	191	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$AbcQJxS0qvSibn6R_hm5OSrLKkHjrpsW8oo97om40r8	@matterbot:localhost	\N		92	194	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$AbcQJxS0qvSibn6R_hm5OSrLKkHjrpsW8oo97om40r8	@admin:localhost	\N		92	194	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$AbcQJxS0qvSibn6R_hm5OSrLKkHjrpsW8oo97om40r8	@ignored_user:localhost	\N		92	194	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$AbcQJxS0qvSibn6R_hm5OSrLKkHjrpsW8oo97om40r8	@matrix_b:localhost	\N		92	194	1	0	1
!kmbTYjjsDRDHGgVqUP:localhost	$AbcQJxS0qvSibn6R_hm5OSrLKkHjrpsW8oo97om40r8	@matrix_a:localhost	\N		92	194	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$gLYRtP_fFTIbdUQ6jtldLcUG60gMNlghw7x9t2_PurE	@matterbot:localhost	\N		101	193	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$gLYRtP_fFTIbdUQ6jtldLcUG60gMNlghw7x9t2_PurE	@admin:localhost	\N		101	193	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$gLYRtP_fFTIbdUQ6jtldLcUG60gMNlghw7x9t2_PurE	@ignored_user:localhost	\N		101	193	1	0	1
!dKcbdDATuwwphjRPQP:localhost	$gLYRtP_fFTIbdUQ6jtldLcUG60gMNlghw7x9t2_PurE	@matrix_b:localhost	\N		101	193	1	0	1
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
$oPNBx-eTHzyLXPzpYpdxdhLdVeGmx5lNmrECxIazfPQ	sha256	\\xa0f341c7e7931f3c8b5cfce96297717612dd55e1a6c7994d9ab102c486b37cf4
$3pZnE6ITQzzyNsuVCenuFBVRMocr892PiAvIbMGbMBM	sha256	\\xde966713a213433cf236cb9509e9ee14155132872bf3dd8f880bc86cc19b3013
$Oqb-EaDS-8U6U1Z6bTGSE7FJIlxKGhzMkNsnYIJY0Y0	sha256	\\x3aa6fe11a0d2fbc53a53567a6d319213b149225c4a1a1ccc90db27608258d18d
$hJeKBcpebJzm9oiwjDCNTWPtbEcfp9GOLXl3yGkyaFU	sha256	\\x84978a05ca5e6c9ce6f688b08c308d4d63ed6c471fa7d18e2d7977c869326855
$9cACT8rCcbUXbMhABzEciyF9pIIDRFNzaBkRVPH_0mk	sha256	\\xf5c0024fcac271b5176cc84007311c8b217da4820344537368191154f1ffd269
$0gxNuNkWyOeHPtnNZ92FzvprItMgnH9hLCbYuY0Vzos	sha256	\\xd20c4db8d916c8e7873ed9cd67dd85cefa6b22d3209c7f612c26d8b98d15ce8b
$9ArTh8Z2w2oc68FOD1X8Ka3DlK7lq00HaHKT_4DMSY4	sha256	\\xf40ad387c676c36a1cebc14e0f55fc29adc394aee5ab4d07687293ff80cc498e
$V_uchZ_8H2oh6EdsXqKsT6Ri62_YZtAAMfZi8pbBGrc	sha256	\\x57fb9c859ffc1f6a21e8476c5ea2ac4fa462eb6fd866d00031f662f296c11ab7
$Q4TOA6SPu2kQIrypB8QEJLHphxV5mHZ_eFwQux4jWSY	sha256	\\x4384ce03a48fbb691022bca907c40424b1e987157998767f785c10bb1e235926
$YwLlyzcAMpJ69jsxTNglcWTbK8XHK8huc6aB6jpgEWk	sha256	\\x6302e5cb370032927af63b314cd8257164db2bc5c72bc86e73a681ea3a601169
$irHFClZVEAzlAtsjct-1MJjEotldPu1Ozkm_NYQrtqI	sha256	\\x8ab1c50a5655100ce502db2372dfb53098c4a2d95d3eed4ece49bf35842bb6a2
$QwAobZq6xey4D-6yOm_xg4h6rCKIRUpTqM4HBNroJwE	sha256	\\x4300286d9abac5ecb80feeb23a6ff183887aac2288454a53a8ce0704dae82701
$3xEI-iU3Teo4B51pXGBbjKxM_DDvYlASNK7W09pHncM	sha256	\\xdf1108fa25374dea38079d695c605b8cac4cfc30ef62501234aed6d3da479dc3
$ETv-B1S-bU8wgS3S1fDdineVdS9YGNq1EMeUPHb6imQ	sha256	\\x113bfe0754be6d4f30812dd2d5f0dd8a7795752f5818dab510c7943c76fa8a64
$GMh4hFLoeDc1Ssk9kdi7yAMIMSZA9zOJYJMC1AJEOKs	sha256	\\x18c8788452e87837354ac93d91d8bbc80308312640f73389609302d4024438ab
$zMfjO64yH55JKcwd-hMCa1P1ARHyAuvBbnPeUiNnS48	sha256	\\xccc7e33bae321f9e4929cc1dfa13026b53f50111f202ebc16e73de5223674b8f
$5-KkKYPCr68IjD4sKk3rDF6kVYVkDMllW0BFUv7G4Do	sha256	\\xe7e2a42983c2afaf088c3e2c2a4deb0c5ea45585640cc9655b404552fec6e03a
$sPO_9Od1FvK55Z9_vb0hx3ophiGuLyATo1RKYIEFxHc	sha256	\\xb0f3bff4e77516f2b9e59f7fbdbd21c77a298621ae2f2013a3544a608105c477
$oXLyUPbqiXmRRNovjt9_FJFQLCzMQjPsaism-trtsDw	sha256	\\xa172f250f6ea89799144da2f8edf7f1491502c2ccc4233ec6a2b26fadaedb03c
$7EOMmT1sBVcDB2udDBhhf11Mok_GC9CY-6bxtIKAYpc	sha256	\\xec438c993d6c055703076b9d0c18617f5d4ca24fc60bd098fba6f1b482806297
$-J2tr3j7vfmJ8ZSBAK5AyvQYmP2Byp-7dKfcBg5xHjU	sha256	\\xf89dadaf78fbbdf989f1948100ae40caf41898fd81ca9fbb74a7dc060e711e35
$o0wI9-m-SdyS4UK7_m9_MUd0luWmj6eoXfMg1ieT00g	sha256	\\xa34c08f7e9be49dc92e142bbfe6f7f31477496e5a68fa7a85df320d62793d348
$wEwGnOPXUgG2_4DpqsPrYbSlIM2TnPjdWNDyVbZNE2Y	sha256	\\xc04c069ce3d75201b6ff80e9aac3eb61b4a520cd939cf8dd58d0f255b64d1366
$oZEGsAxUrYn8R6NS359wZO9T54eXOD-N88ftDK7ZHGU	sha256	\\xa19106b00c54ad89fc47a352df9f7064ef53e78797383f8df3c7ed0caed91c65
$LN4aYSSVw4GLaWf8g7uzrsw-fHTUyCBwq_-RRgS-MGE	sha256	\\x2cde1a612495c3818b6967fc83bbb3aecc3e7c74d4c82070abff914604be3061
$sY34u-PbOKSI3_z8SIqGfn_2XnO9wqZ_eU1dvGDnRJY	sha256	\\xb18df8bbe3db38a488dffcfc488a867e7ff65e73bdc2a67f794d5dbc60e74496
$zhfRuogjo-Vq5GM4-f6hyuXBGHx99o9_Nef1KWi2-EM	sha256	\\xce17d1ba8823a3e56ae46338f9fea1cae5c1187c7df68f7f35e7f52968b6f843
$3A5iUMUsDMAckTZ_lQ9ZLyQdw7FKGrqWfMMxwAZJCwc	sha256	\\xdc0e6250c52c0cc01c91367f950f592f241dc3b14a1aba967cc331c006490b07
$aUCd2uzLS80uiu1DeYrTDp1wAWs7M1ba_4Srm8LLnmU	sha256	\\x69409ddaeccb4bcd2e8aed43798ad30e9d70016b3b3356daff84ab9bc2cb9e65
$zogqtnD68sbYTleQBUL-RkGDpkNmTHar6ilm_2oVnRs	sha256	\\xce882ab670faf2c6d84e57900542fe464183a643664c76abea2966ff6a159d1b
$OcjvTopfs1z8zuVgRxn4ynq9LH7z4eQhJnWG0PQ7150	sha256	\\x39c8ef4e8a5fb35cfccee5604719f8ca7abd2c7ef3e1e421267586d0f43bd79d
$GcBRlllGdKFvT1pDzY7airMfjuYYNt06vxkQ0BnM6IM	sha256	\\x19c05196594674a16f4f5a43cd8eda8ab31f8ee61836dd3abf1910d019cce883
$JtjXz-jm6mi5wU33MudkV8ZsCM2V-zduDqeI1xIG254	sha256	\\x26d8d7cfe8e6ea68b9c14df732e76457c66c08cd95fb376e0ea788d71206db9e
$6cga7PdI_98v2MEH6Wosfik3Plxt3Ml7GwsUkSFFa00	sha256	\\xe9c81aecf748ffdf2fd8c107e96a2c7e29373e5c6ddcc97b1b0b149121456b4d
$0BYuX-7BWlMOYXwWp-y_txKwBBorVZzavW6fDuXxUrM	sha256	\\xd0162e5feec15a530e617c16a7ecbfb712b0041a2b559cdabd6e9f0ee5f152b3
$OOCwtQCB-nmnnlgQ3ST3ItcIsITOLkC3b4a-WpaJjRg	sha256	\\x38e0b0b50081fa79a79e5810dd24f722d708b084ce2e40b76f86be5a96898d18
$gnR3q3jOOEFI04MZ00yFbtQ5ZNs9EfZENfrrOEEj46s	sha256	\\x827477ab78ce384148d38319d34c856ed43964db3d11f64435faeb384123e3ab
$ZI6mQ9fcQaRUQRDK0WWxDErZcQGD7ahzFrk1b9nCFRE	sha256	\\x648ea643d7dc41a4544110cad165b10c4ad9710183eda87316b9356fd9c21511
$raYGvFCt-q8kxStPhO_tzxQ3pOmVeo5gn8lTV6sHBvs	sha256	\\xada606bc50adfaaf24c52b4f84efedcf1437a4e9957a8e609fc95357ab0706fb
$mfDu-vDNMkOg-psLHXlWcSXOnVkeuUPJfdm2cZ-3P-k	sha256	\\x99f0eefaf0cd3243a0fa9b0b1d79567125ce9d591eb943c97dd9b6719fb73fe9
$iDgp052fBKJYL2KTsRdizUAlriA5itky5-e20aiZwHI	sha256	\\x883829d39d9f04a2582f6293b11762cd4025ae20398ad932e7e7b6d1a899c072
$uwN8jjs4qWXT6fsX4o-36T96CWj17IDa_TJ3mF5Hd7M	sha256	\\xbb037c8e3b38a965d3e9fb17e28fb7e93f7a0968f5ec80dafd3277985e4777b3
$mXxM94SwVR0FuKbH_riuFTeW0zH7Om62-HEudW_5y80	sha256	\\x997c4cf784b0551d05b8a6c7feb8ae153796d331fb3a6eb6f8712e756ff9cbcd
$OVhb59gyrKY7dsgLlfdIwe1H4O5zslN774jooAK4vec	sha256	\\x39585be7d832aca63b76c80b95f748c1ed47e0ee73b2537bef88e8a002b8bde7
$AxFCh7nvzu51kpXaQqyK3CKEqdyGhhJ0zhqT-c9LGPk	sha256	\\x03114287b9efceee759295da42ac8adc2284a9dc86861274ce1a93f9cf4b18f9
$0ruVoUZRE1Edh-f7Z0QopPRTCr7L2kEpX8unxgxmfSQ	sha256	\\xd2bb95a1465113511d87e7fb674428a4f4530abecbda41295fcba7c60c667d24
$hWVSd4FzjwQq7FYDdhFSCgpisb3gxDJ2OAjCjYS6rkg	sha256	\\x8565527781738f042aec56037611520a0a62b1bde0c432763808c28d84baae48
$OJhJIVnJWjcgl3gc2AqLQK7sy1tKn075fy4E5qUK014	sha256	\\x3898492159c95a372097781cd80a8b40aeeccb5b4a9f4ef97f2e04e6a50ad35e
$nsJ2oe7ZtdBtY0V-sJWzGBBDi7tcgH24zUaAdmLjXy4	sha256	\\x9ec276a1eed9b5d06d63457eb095b31810438bbb5c807db8cd46807662e35f2e
$XYKCYavbY8FMdUIlSSoqP0likUnTP6uJ0yHoGQCMnWQ	sha256	\\x5d828261abdb63c14c754225492a2a3f49629149d33fab89d321e819008c9d64
$fc-Paa3ZBQU-GAAxH4QWDNrWblQvQ4ddYVzPTPiYV6U	sha256	\\x7dcf8f69add905053e1800311f84160cdad66e542f43875d615ccf4cf89857a5
$4KgY7ivi_pp1q2tjdk7IWENjs1kzgSRLB29nKbq-UXw	sha256	\\xe0a818ee2be2fe9a75ab6b63764ec8584363b3593381244b076f6729babe517c
$0EmcDbHM6t0AJ7YKAcphqL8othdZg4dIXSazEHvnCno	sha256	\\xd0499c0db1cceadd0027b60a01ca61a8bf28b617598387485d26b3107be70a7a
$72MNMNMOJMJpfLbdNKdm6ZXGr14ukIKdq-fG2OvzOqg	sha256	\\xef630d30d30e24c2697cb6dd34a766e995c6af5e2e90829dabe7c6d8ebf33aa8
$j4OmrTBgGXlAg2ui751-jxTS4uMSPCzpj81xWRfOWiA	sha256	\\x8f83a6ad3060197940836ba2ef9d7e8f14d2e2e3123c2ce98fcd715917ce5a20
$lQM-XkcgjA40yc1T7BNzbZ8V8yxcnsj23SxrixdEev8	sha256	\\x95033e5e47208c0e34c9cd53ec13736d9f15f32c5c9ec8f6dd2c6b8b17447aff
$FNOekiMLFE4AEgQ1st7kiouCRAYO3DKEMbrYHGbH-zw	sha256	\\x14d39e92230b144e00120435b2dee48a8b8244060edc328431bad81c66c7fb3c
$6ZYuUr8K6uh0D7tl9-HD___6hQH3lj8qU1liF0zAkmo	sha256	\\xe9962e52bf0aeae8740fbb65f7e1c3fffffa8501f7963f2a535962174cc0926a
$EklY0FV28pDgoXqwoQUjAB5wTv33O8RCHRE8k2k6o2c	sha256	\\x124958d05576f290e0a17ab0a10523001e704efdf73bc4421d113c93693aa367
$BMnLymfijfp2V1tH1M6Nayfx-iF_rRw70COW60dCBG0	sha256	\\x04c9cbca67e28dfa76575b47d4ce8d6b27f1fa217fad1c3bd02396eb4742046d
$p2y4ivsQApKJEQKZQ-5KFk47veZlq7V00tHHrokVqK0	sha256	\\xa76cb88afb1002928911029943ee4a164e3bbde665abb574d2d1c7ae8915a8ad
$VzxEyd-riDbZr-sdhUSEcA4h_6kWYfmSeoqEtaZHFFo	sha256	\\x573c44c9dfab8836d9afeb1d854484700e21ffa91661f9927a8a84b5a647145a
$BtKmdXlHyT65KPvPIiDSk38oldbOKOUbuv7J13Up4wE	sha256	\\x06d2a6757947c93eb928fbcf2220d2937f2895d6ce28e51bbafec9d77529e301
$HVWinlm6AKNeOld7iV_yqdfmpznmG5wAyWK5k3xjM7Y	sha256	\\x1d55a29e59ba00a35e3a577b895ff2a9d7e6a739e61b9c00c962b9937c6333b6
$aa2-bg9KcCtrn4nE5HK1JGC6sa8Gr7jWqLhPgLQTtsU	sha256	\\x69adbe6e0f4a702b6b9f89c4e472b52460bab1af06afb8d6a8b84f80b413b6c5
$99PDED6qRD6JvJgyuUpKL5SGciNeDx4Q8aNU8-knIfI	sha256	\\xf7d3c3103eaa443e89bc9832b94a4a2f948672235e0f1e10f1a354f3e92721f2
$ShuNV5AOx3oTjKr3eYjFKvzCZ374R_0vxs2HC21ht-g	sha256	\\x4a1b8d57900ec77a138caaf77988c52afcc2677ef847fd2fc6cd870b6d61b7e8
$QjDo1bVrVGh33tmezjIVWxT6VXLutgIWlP9outS8Gcg	sha256	\\x4230e8d5b56b546877ded99ece32155b14fa5572eeb6021694ff68bad4bc19c8
$XikqApD6-vTeGUebJl-_Bc9ButeowpABz5W37dejAy0	sha256	\\x5e292a0290fafaf4de19479b265fbf05cf41bad7a8c29001cf95b7edd7a3032d
$wehc8FMA82xW0EU5F86ZkvsBra_SZ0JSA3Yweowv_s8	sha256	\\xc1e85cf05300f36c56d0453917ce9992fb01adafd26742520376307a8c2ffecf
$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo	sha256	\\x4a8e34ec60a136aa847a3d2bca96ad1ddb6e4640bd257534d07b4bd3cb88725a
$sD72WUGTkmqfbvA4mcCNx5IcT-WfbmjsGalYB6V6S-E	sha256	\\xb03ef6594193926a9f6ef03899c08dc7921c4fe59f6e68ec19a95807a57a4be1
$UTOQTSrmXya3IQYDcRPwNWN1bIv2zQ3YfbaVRy9NQuA	sha256	\\x5133904d2ae65f26b72106037113f03563756c8bf6cd0dd87db695472f4d42e0
$EB67Xwo9B0__CxNTvptFIy4e4vG93cmEcHRWbiVSFJU	sha256	\\x101ebb5f0a3d074fff0b1353be9b45232e1ee2f1bdddc9847074566e25521495
$85g2ma_sFrYS8UbhpRwYEglJLj7xswd8VgNCg787_3E	sha256	\\xf3983699afec16b612f146e1a51c181209492e3ef1b3077c56034283bf3bff71
$kMqJ62yuvBi4RWfOiLMiPcoSKbfcjZvTwwiuRRmfEKA	sha256	\\x90ca89eb6caebc18b84567ce88b3223dca1229b7dc8d9bd3c308ae45199f10a0
$SLqtTg1DQZU0Y4ezk90kDHz7IxD9TXjhW4qQAoPUfTk	sha256	\\x48baad4e0d434195346387b393dd240c7cfb2310fd4d78e15b8a900283d47d39
$mjUbm6eO9Jk-i6bqdyRHFZy9L-lH5TOO27GYMQ87nhs	sha256	\\x9a351b9ba78ef4993e8ba6ea772447159cbd2fe947e5338edbb198310f3b9e1b
$IfK4xyQ_h94nUHneDilGoM0TTwuWFeP5_u_nlRs571U	sha256	\\x21f2b8c7243f87de275079de0e2946a0cd134f0b9615e3f9feefe7951b39ef55
$LjACIs2QTEZTfukFRb30GQyevcb7EREdVFxoNEgvHSk	sha256	\\x2e300222cd904c46537ee90545bdf4190c9ebdc6fb11111d545c6834482f1d29
$jL60Q94H_SC7S4ZFOWkA4RilDwTMIUci2DyEXyQS_t0	sha256	\\x8cbeb443de07fd20bb4b8645396900e118a50f04cc214722d83c845f2412fedd
$lDJnxY-YfTRyXQcBLRlbFT2_w4DXO4Pks75YGGa5M5o	sha256	\\x943267c58f987d34725d07012d195b153dbfc380d73b83e4b3be581866b9339a
$t_tUn4wROpupdwEmZnXWQ-mtnx68XnGjofi61K92cRY	sha256	\\xb7fb549f8c113a9ba97701266675d643e9ad9f1ebc5e71a3a1f8bad4af767116
$JgtV2Jrt_3Cws_oeqEte6xeUnTbTSMu0pBPrEWD4WyM	sha256	\\x260b55d89aedff70b0b3fa1ea84b5eeb17949d36d348cbb4a413eb1160f85b23
$sbDgkkxT05mw8xIVFWyOJtbW9nnehE06Wvxor1z8ms8	sha256	\\xb1b0e0924c53d399b0f31215156c8e26d6d6f679de844d3a5afc68af5cfc9acf
$TbzKCcECXvJAKvBu5GZCTLIGi7Js0b1w9dE6KKZXaKo	sha256	\\x4dbcca09c1025ef2402af06ee466424cb2068bb26cd1bd70f5d13a28a65768aa
$XhzyXIYIbI0BfDV1QY4H3b4Wrpy5pJgJsGNZc8P8seg	sha256	\\x5e1cf25c86086c8d017c3575418e07ddbe16ae9cb9a49809b0635973c3fcb1e8
$M2xNoGVeTRazjk5EjiA0u3mOkneK7za9KWYn2LMJFwA	sha256	\\x336c4da0655e4d16b38e4e448e2034bb798e92778aef36bd296627d8b3091700
$ggRHO4QwGg8SLwSXlSNnHypSBsgj2jFMUXbjC7U97qM	sha256	\\x8204473b84301a0f122f04979523671f2a5206c823da314c5176e30bb53deea3
$m8QuIxNBjngQA1UhDPZlw6nIvodE764mdmYG9oCKf94	sha256	\\x9bc42e2313418e78100355210cf665c3a9c8be8744efae26766606f6808a7fde
$RuT3uWLcY4y4GhqYFFNXur6XuNwXipRRmx5rJFfM9ms	sha256	\\x46e4f7b962dc638cb81a1a98145357babe97b8dc178a94519b1e6b2457ccf66b
$aaPR9QI7az6NxeJ0hSrQxyKzzVyM-rBWODbN9y9rM9Q	sha256	\\x69a3d1f5023b6b3e8dc5e274852ad0c722b3cd5c8cfab0563836cdf72f6b33d4
$2-SFwejONuAnI3cUJ4UN3FSzzJjeIWUURtWOJiO2sWo	sha256	\\xdbe485c1e8ce36e02723771427850ddc54b3cc98de21651446d58e2623b6b16a
$sPW_-g3Oq09Bq8Rm-TKPTRO4HHOlMXEni0rE18Y01h4	sha256	\\xb0f5bffa0dceab4f41abc466f9328f4d13b81c73a53171278b4ac4d7c634d61e
$A5qbTNFuQ1MZL2fuT4oUFzi1xCHHDk0NuQZstoz4u-U	sha256	\\x039a9b4cd16e4353192f67ee4f8a141738b5c421c70e4d0db9066cb68cf8bbe5
$jhFoiytsqlLXRCkoL5gH2sXpQQJFwk3XLtzQPCpA0K8	sha256	\\x8e11688b2b6caa52d74429282f9807dac5e9410245c24dd72edcd03c2a40d0af
$0ClPrn0jv_hdCQB4TqbWVPUxxSqFeDViCsOjYwQVDAg	sha256	\\xd0294fae7d23bff85d0900784ea6d654f531c52a857835620ac3a36304150c08
$kkmwTP1mOPGymh7Q3_N1Y7ftC1xrv5qaHbV_zi99vD4	sha256	\\x9249b04cfd6638f1b29a1ed0dff37563b7ed0b5c6bbf9a9a1db57fce2f7dbc3e
$WPbDUZRE7W6o_O4D0qf40PxoXNWcHrBwx3LxCA_ILaY	sha256	\\x58f6c3519444ed6ea8fcee03d2a7f8d0fc685cd59c1eb070c772f1080fc82da6
$2xt0-DVGoBAEL-GIwj9HZfHBCQu7_M-HzB2XaEfxjwM	sha256	\\xdb1b74f83546a010042fe188c23f4765f1c1090bbbfccf87cc1d976847f18f03
$ewJTQJq2XdLvkqYVULlUmmJ-A3LQ6Jnqs4GDYi6q0DE	sha256	\\x7b0253409ab65dd2ef92a61550b9549a627e0372d0e899eab38183622eaad031
$kdWmWl1h_wHbp_4CZHM4AOF1I3SpjgbLYkYoFiWiazU	sha256	\\x91d5a65a5d61ff01dba7fe0264733800e1752374a98e06cb6246281625a26b35
$6CT_ZCazUgJysnWN-q2s4b5iR-x1EbXa932nBRpldW4	sha256	\\xe824ff6426b3520272b2758dfaadace1be6247ec7511b5daf77da7051a65756e
$UQr1C3BZK9MztXbBR2a0yz0wCyXSy_abmCstrHnXi2E	sha256	\\x510af50b70592bd333b576c14766b4cb3d300b25d2cbf69b982b2dac79d78b61
$56oOQ2hizWAJWWKoJTMYGwAKX_gaANdZg2QHgtC63ZE	sha256	\\xe7aa0e436862cd60095962a82533181b000a5ff81a00d75983640782d0badd91
$6Sy4DU04a_WCzalQkimJ_l9-eYsJ3kcn3Lat9w42L2I	sha256	\\xe92cb80d4d386bf582cda950922989fe5f7e798b09de4727dcb6adf70e362f62
$FC2J9PSIQLoF8YJo6zY2dP8Eo55L8CPgzVGN7iaofRo	sha256	\\x142d89f4f48840ba05f18268eb363674ff04a39e4bf023e0cd518dee26a87d1a
$WcPnOWvRmgShLlAe8RxY4-_M71l0auS5ykpKdmUS0LU	sha256	\\x59c3e7396bd19a04a12e501ef11c58e3efccef59746ae4b9ca4a4a766512d0b5
$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E	sha256	\\xb493150252f8413971a00e900f8688ead6dcdee0c468f5931c15834223abf7d1
$ZLuzCoh1UZ9oNHYyBNCtneq81TelpJ882dsDdio0oKU	sha256	\\x64bbb30a8875519f6834763204d0ad9deabcd537a5a49f3cd9db03762a34a0a5
$Zv-9wNEnjnF-VeZtZKtHkYObGhccwLKewNnJg-fUiF8	sha256	\\x66ffbdc0d1278e717e55e66d64ab4791839b1a171cc0b29ec0d9c983e7d4885f
$53rDO0S-X2QNPUyUVrTGx092yf0EW0nvJXQNLgQ09kc	sha256	\\xe77ac33b44be5f640d3d4c9456b4c6c74f76c9fd045b49ef25740d2e0434f647
$UD0jEJtVKXhlCRf7VxHITWSUyhzaGkpH0VGbwilf2RE	sha256	\\x503d23109b552978650917fb5711c84d6494ca1cda1a4a47d1519bc2295fd911
$-R5ZDLwPtIisO-W746dPRRrr1U6HjM8uhC78Zh95UUQ	sha256	\\xf91e590cbc0fb488ac3be5bbe3a74f451aebd54e878ccf2e842efc661f795144
$19Wa_uoHXFwHicMPIWHRa1c8H1yIjgzKxpDzo89CTTE	sha256	\\xd7d59afeea075c5c0789c30f2161d16b573c1f5c888e0ccac690f3a3cf424d31
$Qyk1jqM8wu6uOaEDEalSs_0hepeq6CnfZZRy1hQ4sd8	sha256	\\x4329358ea33cc2eeae39a10311a952b3fd217a97aae829df659472d61438b1df
$qgyz1sVriFBiepR7YLOpA_tcnRjhDX9q13fkeJa8i3U	sha256	\\xaa0cb3d6c56b8850627a947b60b3a903fb5c9d18e10d7f6ad777e47896bc8b75
$j_Vf4RSpugcR52JQthWyGuqRIEdGrETb4ZLvnGxwwg0	sha256	\\x8ff55fe114a9ba0711e76250b615b21aea91204746ac44dbe192ef9c6c70c20d
$iVV3o47Y40f29uNsCktD5R1VKbTF1y3nGq4KSKQ5YYo	sha256	\\x895577a38ed8e347f6f6e36c0a4b43e51d5529b4c5d72de71aae0a48a439618a
$OL5YFZuIzpeGWvQkJsWD5fA-_tqvM6MNM8aACLhDIKc	sha256	\\x38be58159b88ce97865af42426c583e5f03efedaaf33a30d33c68008b84320a7
$WxOx5K9OBtSH4SKkxlQDUCVkiuA8mdui6eTN417KUig	sha256	\\x5b13b1e4af4e06d487e122a4c654035025648ae03c99dba2e9e4cde35eca5228
$9eV_AyLXyN9dQJyo8nKzxH0MD2Pj26OD3m5hxM368ek	sha256	\\xf5e57f0322d7c8df5d409ca8f272b3c47d0c0f63e3dba383de6e61c4cdfaf1e9
$KAudDRl-ilYkXdKdFFwSH1rjB9FuDL3iaIcj9chsvuc	sha256	\\x280b9d0d197e8a56245dd29d145c121f5ae307d16e0cbde2688723f5c86cbee7
$NBW9KofbXfyJlflrssj5f0gU9-vix_ChkMTdCTutt6E	sha256	\\x3415bd2a87db5dfc8995f96bb2c8f97f4814f7ebe2c7f0a190c4dd093badb7a1
$G4jqJ_vLOuComzEY5LKlWgJmqk76rEv2BaFnoUc32C4	sha256	\\x1b88ea27fbcb3ae0a89b3118e4b2a55a0266aa4efaac4bf605a167a14737d82e
$PmdsaAuptefoxepoi5dH3S5XZjMQnrw_IY8E3iiC0JI	sha256	\\x3e676c680ba9b5e7e8c5ea688b9747dd2e576633109ebc3f218f04de2882d092
$LLxGQgsj2x835E7aJtEtKuPEzf1fHJTT_1b0cxZaynk	sha256	\\x2cbc46420b23db1f37e44eda26d12d2ae3c4cdfd5f1c94d3ff56f473165aca79
$xaKVxYK5Ka0brhbVcFdQdutgxYlZom-dUIRWmloBBms	sha256	\\xc5a295c582b929ad1bae16d570575076eb60c58959a26f9d5084569a5a01066b
$7IBjUUbkm6m5Y_DazT_SUW3_XBAwV0nvHP6nkPuBbV0	sha256	\\xec80635146e49ba9b963f0dacd3fd2516dff5c10305749ef1cfea790fb816d5d
$iZZsHDRKa9MPh0wKPGoTIkR9_IN1gXmgYQ3CLA-oEsU	sha256	\\x89966c1c344a6bd30f874c0a3c6a1322447dfc83758179a0610dc22c0fa812c5
$OxJtFsDfjfHJ57HdnctrwwYfeMAuGw-MFWayc0MqGW4	sha256	\\x3b126d16c0df8df1c9e7b1dd9dcb6bc3061f78c02e1b0f8c1566b273432a196e
$OIgyn6WfwavdRqCIV587JtVG-UzMqFnY1_VC_N2O6ok	sha256	\\x3888329fa59fc1abdd46a088579f3b26d546f94ccca859d8d7f542fcdd8eea89
$z-yABBMUu-RFJeiOLWwmWghP2O4vgO3Bts6c9FX-uG8	sha256	\\xcfec80041314bbe44525e88e2d6c265a084fd8ee2f80edc1b6ce9cf455feb86f
$P2eP-7teBmGXcBM7DqUedLeBNdY5eaTasFqCr7GXY74	sha256	\\x3f678ffbbb5e06619770133b0ea51e74b78135d63979a4dab05a82afb19763be
$62DK_5Urc-R1gCm6T-D7rEFWp3Q47rECTaNApSOe0tg	sha256	\\xeb60caff952b73e4758029ba4fe0fbac4156a77438eeb1024da340a5239ed2d8
$reo6-sRCAReTplLLrWZiUXEMMfaufd1o-PclhKbhxXw	sha256	\\xadea3afac442011793a652cbad666251710c31f6ae7ddd68f8f72584a6e1c57c
$LiUaGyMC-ZVhJFLD9EeZsUNlhdIzJ2J41q-tpdMYQ-g	sha256	\\x2e251a1b2302f995612452c3f44799b1436585d233276278d6afada5d31843e8
$kGXjbDILpzPlAVquVm-0ro1Y2cAjvBSU3chLQmB-ZgI	sha256	\\x9065e36c320ba733e5015aae566fb4ae8d58d9c023bc1494ddc84b42607e6602
$iR6CRvH8xG5VgeMQIZFMBeaVeTjxgDtnqT7tv-PoCf8	sha256	\\x891e8246f1fcc46e5581e31021914c05e6957938f1803b67a93eedbfe3e809ff
$47BkoMnB5FT3PSdXLEy0rb4ZdbS1q9w82a669O4lBXg	sha256	\\xe3b064a0c9c1e454f73d27572c4cb4adbe1975b4b5abdc3cd9aebaf4ee250578
$zI1CZE-pX4aF7RBiJiZqzqFZlxIfJRBpmSuBjEzHTCQ	sha256	\\xcc8d42644fa95f8685ed106226266acea15997121f251069992b818c4cc74c24
$y7fmz8cz_zrBS0ZmRnthufiCH3PFkuCVz8YKzQaf81g	sha256	\\xcbb7e6cfc733ff3ac14b4666467b61b9f8821f73c592e095cfc60acd069ff358
$mJ65YIJRPOxuW2mcyV5dt1MwIY7iWY76Fnj51047dZM	sha256	\\x989eb96082513cec6e5b699cc95e5db75330218ee2598efa1678f9d74e3b7593
$p7GJemyaMZGUqYX0guKHUqmObfwF2yChmhI7v1sn2nE	sha256	\\xa7b1897a6c9a319194a985f482e28752a98e6dfc05db20a19a123bbf5b27da71
$Ky-_xzOrnEPuDm0WQev0E1urDcDHtvv8esKT3jQ6lFY	sha256	\\x2b2fbfc733ab9c43ee0e6d1641ebf4135bab0dc0c7b6fbfc7ac293de343a9456
$5Iq2ZU88BXgNKKqMGOu71dH7vsyaxwI-Fxg8ocEMI2E	sha256	\\xe48ab6654f3c05780d28aa8c18ebbbd5d1fbbecc9ac7023e17183ca1c10c2361
$LHW3l0dgme8yNUY6xjIvP_Osal1_vZAuIfg7vCLzGKI	sha256	\\x2c75b797476099ef3235463ac6322f3ff3ac6a5d7fbd902e21f83bbc22f318a2
$_XRh5iYtBtMSC8b9sq-Zq1kS1LqI6azDTXLEGQTiQSs	sha256	\\xfd7461e6262d06d3120bc6fdb2af99ab5912d4ba88e9acc34d72c41904e2412b
$jgIb5yphKm1y65Shpo1bZF38fQ0ZqUjOopYEMjB2JS0	sha256	\\x8e021be72a612a6d72eb94a1a68d5b645dfc7d0d19a948cea29604323076252d
$j96SJY0VtGl6Q_Fnj_jg3BifdW7s0-Vd8t57DrAeAX8	sha256	\\x8fde92258d15b4697a43f1678ff8e0dc189f756eecd3e55df2de7b0eb01e017f
$5-UBR4vNvgnHcUIuQA0gIHJmn4pOL-BNEZ33B-2Dmes	sha256	\\xe7e501478bcdbe09c771422e400d202072669f8a4e2fe04d119df707ed8399eb
$8f7euYUQUOKVs1LECS5C0ny-iJc0LrEhKy5AjaE9VwM	sha256	\\xf1fedeb9851050e295b352c4092e42d27cbe8897342eb1212b2e408da13d5703
$n7rEuNOUTfPAb-nKtA8sQLtp0FZoDqOfMyqN9eKVULc	sha256	\\x9fbac4b8d3944df3c06fe9cab40f2c40bb69d056680ea39f332a8df5e29550b7
$KdF0e2L1V2qamNtPDDdbE1nZ8xvaqEBCeH0VcCCosQ8	sha256	\\x29d1747b62f5576a9a98db4f0c375b1359d9f31bdaa84042787d157020a8b10f
$VGPWrlgPM0aSEOjGq1_ygJ2gwcjdfMl06P2yF-1EjMw	sha256	\\x5463d6ae580f33469210e8c6ab5ff2809da0c1c8dd7cc974e8fdb217ed448ccc
$T-S0-0A2-tysbZGnQHyOgfmxVouK-Ise06pRgQbLLcg	sha256	\\x4fe4b4fb4036fadcac6d91a7407c8e81f9b1568b8af88b1ed3aa518106cb2dc8
$jTQQwpTqOMCeKxagSFuov0Dg8yBrYJJogGNCxBE1qwk	sha256	\\x8d3410c294ea38c09e2b16a0485ba8bf40e0f3206b609268806342c41135ab09
$8Hjay0ed9n_Y3vv-Lhtc_-A0-5CvZe8YsPugJA7pwVg	sha256	\\xf078dacb479df67fd8defbfe2e1b5cffe034fb90af65ef18b0fba0240ee9c158
$NHchZjGDozZxBeE_hBCfcWNQSoGcpRSxMwGAV4CVzWU	sha256	\\x347721663183a3367105e13f84109f7163504a819ca514b1330180578095cd65
$5G3tHkgsc39AkOi94e7gxCeKaPhkmyOOAZlGWI8YaCQ	sha256	\\xe46ded1e482c737f4090e8bde1eee0c4278a68f8649b238e019946588f186824
$c-G9o6jTgFkz_rB_zESYfRkHoFMmTM5uCDXF1JAermc	sha256	\\x73e1bda3a8d3805933feb07fcc44987d1907a053264cce6e0835c5d4901eae67
$eY9D8MVKC5bDdinpPVI9ooLWvoYHx0tLFn-vRWkp9nk	sha256	\\x798f43f0c54a0b96c37629e93d523da282d6be8607c74b4b167faf456929f679
$AAj21zp54kdoP3h1Zql3vB7JlPNE4Y9HrXrzBQPQrTA	sha256	\\x0008f6d73a79e247683f787566a977bc1ec994f344e18f47ad7af30503d0ad30
$VZnQHRUET5azOmfmvUZMF1_eEKzi1_WkVHB0pxMELxo	sha256	\\x5599d01d15044f96b33a67e6bd464c175fde10ace2d7f5a4547074a713042f1a
$7q-JkspgsFYptPnMJ25LHdffz-rXLRDHzidSYCV3Kc8	sha256	\\xeeaf8992ca60b05629b4f9cc276e4b1dd7dfcfead72d10c7ce275260257729cf
$dtGyXiOFORXfCA1yAgiPJbV5UKJjEo-zfetInljHoV0	sha256	\\x76d1b25e23853915df080d7202088f25b57950a263128fb37deb489e58c7a15d
$dxD8VRi5x30Gu7BMEOui-JOrXZEL9meU6Q8aZra1b6U	sha256	\\x7710fc5518b9c77d06bbb04c10eba2f893ab5d910bf66794e90f1a66b6b56fa5
$bXKGeqgVWpdObwAv0HPtsV7_MNqo8HhD_whsZ1gxx54	sha256	\\x6d72867aa8155a974e6f002fd073edb15eff30daa8f07843ff086c675831c79e
$LOcz4Bm15D4BsyuDXygSGL-0AvIjwSLYy4cezgebQK8	sha256	\\x2ce733e019b5e43e01b32b835f281218bfb402f223c122d8cb871ece079b40af
$RJSqE0ZymidM-ZtkpYLdrShv6_yNohaw5QtWzVooGsk	sha256	\\x4494aa1346729a274cf99b64a582ddad286febfc8da216b0e50b56cd5a281ac9
$EdC99i51IXAQXh-JndOybB0EFIdpgm02s0Z6Takw4Jw	sha256	\\x11d0bdf62e752170105e1f899dd3b26c1d04148769826d36b3467a4da930e09c
$pp-1vh-obnf3bLKs4cnpwy9dbINdz1MGiUDLrdenfek	sha256	\\xa69fb5be1fa86e77f76cb2ace1c9e9c32f5d6c835dcf53068940cbadd7a77de9
$xKmd10QHFv5EgHAyd9HpWHkEi2QTI9MhKVlqpVntWM8	sha256	\\xc4a99dd7440716fe4480703277d1e95879048b641323d32129596aa559ed58cf
$gLYRtP_fFTIbdUQ6jtldLcUG60gMNlghw7x9t2_PurE	sha256	\\x80b611b4ffdf15321b75443a8ed95d2dc506eb480c365821c3bc7db76fcfbab1
$AbcQJxS0qvSibn6R_hm5OSrLKkHjrpsW8oo97om40r8	sha256	\\x01b7102714b4aaf4a26e7e91fe19b9392acb2a41e3ae9b16f28a3dee89b8d2bf
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
$gnR3q3jOOEFI04MZ00yFbtQ5ZNs9EfZENfrrOEEj46s	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'test':1	1672305710404	56
$ZI6mQ9fcQaRUQRDK0WWxDErZcQGD7ahzFrk1b9nCFRE	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'test2':1	1672306061836	57
$raYGvFCt-q8kxStPhO_tzxQ3pOmVeo5gn8lTV6sHBvs	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'bold':2 'header':1	1672306062147	58
$mfDu-vDNMkOg-psLHXlWcSXOnVkeuUPJfdm2cZ-3P-k	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'messag':3 'random':1 'wrong':2	1672306062326	59
$iDgp052fBKJYL2KTsRdizUAlriA5itky5-e20aiZwHI	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'test':1	1672306062494	60
$uwN8jjs4qWXT6fsX4o-36T96CWj17IDa_TJ3mF5Hd7M	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'filenam':1	1672306062756	61
$mXxM94SwVR0FuKbH_riuFTeW0zH7Om62-HEudW_5y80	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'filenam':1	1672306062896	62
$OVhb59gyrKY7dsgLlfdIwe1H4O5zslN774jooAK4vec	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'mydata':1	1672306063132	63
$AxFCh7nvzu51kpXaQqyK3CKEqdyGhhJ0zhqT-c9LGPk	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'hidden':1 'messag':2	1672306063330	64
$QjDo1bVrVGh33tmezjIVWxT6VXLutgIWlP9outS8Gcg	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'test':1	1672312506179	89
$j4OmrTBgGXlAg2ui751-jxTS4uMSPCzpj81xWRfOWiA	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'first':1 'messag':3 'mm':2	1672312535871	90
$lQM-XkcgjA40yc1T7BNzbZ8V8yxcnsj23SxrixdEev8	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'first':5 'localhost':4 'mattermost':2 'messag':7,10 'mm':1,6,9 'second':8	1672312536151	91
$XikqApD6-vTeGUebJl-_Bc9ButeowpABz5W37dejAy0	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'b':3 'localhost':4,8 'mattermost':2,6 'messag':11 'mm':1,5,10 'third':9	1672312536321	92
$A5qbTNFuQ1MZL2fuT4oUFzi1xCHHDk0NuQZstoz4u-U	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'first':1 'matrix':2 'messag':3	1672312690722	93
$kMqJ62yuvBi4RWfOiLMiPcoSKbfcjZvTwwiuRRmfEKA	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'first':3 'matrix':1,4,7 'messag':5,8 'second':6	1672312690858	94
$2xt0-DVGoBAEL-GIwj9HZfHBCQu7_M-HzB2XaEfxjwM	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'b':2 'matrix':1,3,6 'messag':7 'third':5	1672312691040	95
$6CT_ZCazUgJysnWN-q2s4b5iR-x1EbXa932nBRpldW4	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'first':1 'messag':2	1672312691392	96
$UD0jEJtVKXhlCRf7VxHITWSUyhzaGkpH0VGbwilf2RE	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'whatev':1	1672312691855	97
$BMnLymfijfp2V1tH1M6Nayfx-iF_rRw70COW60dCBG0	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'b':2 'localhost':3 'matrix':1 'messag':6 'third':5 'whatev':4	1672312692473	98
$jhFoiytsqlLXRCkoL5gH2sXpQQJFwk3XLtzQPCpA0K8	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'messag':2 'root':1	1672312692993	99
$UQr1C3BZK9MztXbBR2a0yz0wCyXSy_abmCstrHnXi2E	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'matrix':1 'messag':4,6 'repli':5 'root':3	1672312693241	100
$p2y4ivsQApKJEQKZQ-5KFk47veZlq7V00tHHrokVqK0	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'last':5 'matrix':1 'messag':4,6 'repli':3	1672312693607	102
$VzxEyd-riDbZr-sdhUSEcA4h_6kWYfmSeoqEtaZHFFo	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'messag':2 'new':1	1672312696316	103
$m8QuIxNBjngQA1UhDPZlw6nIvodE764mdmYG9oCKf94	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'test':1	1672314829737	129
$mjUbm6eO9Jk-i6bqdyRHFZy9L-lH5TOO27GYMQ87nhs	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'test2':1	1672314833256	130
$j_Vf4RSpugcR52JQthWyGuqRIEdGrETb4ZLvnGxwwg0	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'bold':2 'header':1	1672314833650	131
$kdWmWl1h_wHbp_4CZHM4AOF1I3SpjgbLYkYoFiWiazU	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'messag':3 'random':1 'wrong':2	1672314833853	132
$RuT3uWLcY4y4GhqYFFNXur6XuNwXipRRmx5rJFfM9ms	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'hi':1	1672314834068	133
$sD72WUGTkmqfbvA4mcCNx5IcT-WfbmjsGalYB6V6S-E	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'test':1	1672314834257	134
$iVV3o47Y40f29uNsCktD5R1VKbTF1y3nGq4KSKQ5YYo	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'filenam':1	1672314834507	135
$kkmwTP1mOPGymh7Q3_N1Y7ftC1xrv5qaHbV_zi99vD4	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'filenam':1	1672314834658	136
$99PDED6qRD6JvJgyuUpKL5SGciNeDx4Q8aNU8-knIfI	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'mydata':1	1672314835018	137
$53rDO0S-X2QNPUyUVrTGx092yf0EW0nvJXQNLgQ09kc	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'hidden':1 'messag':2	1672314835302	138
$OL5YFZuIzpeGWvQkJsWD5fA-_tqvM6MNM8aACLhDIKc	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'first':1 'messag':3 'mm':2	1672314857885	139
$WxOx5K9OBtSH4SKkxlQDUCVkiuA8mdui6eTN417KUig	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'first':5 'localhost':4 'mattermost':2 'messag':7,10 'mm':1,6,9 'second':8	1672314858127	140
$9eV_AyLXyN9dQJyo8nKzxH0MD2Pj26OD3m5hxM368ek	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'b':3 'localhost':4,8 'mattermost':2,6 'messag':11 'mm':1,5,10 'third':9	1672314858312	141
$KAudDRl-ilYkXdKdFFwSH1rjB9FuDL3iaIcj9chsvuc	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'first':1 'matrix':2 'messag':3	1672314858527	142
$NBW9KofbXfyJlflrssj5f0gU9-vix_ChkMTdCTutt6E	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'first':3 'matrix':1,4,7 'messag':5,8 'second':6	1672314858660	143
$G4jqJ_vLOuComzEY5LKlWgJmqk76rEv2BaFnoUc32C4	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'b':2 'matrix':1,3,6 'messag':7 'third':5	1672314858772	144
$PmdsaAuptefoxepoi5dH3S5XZjMQnrw_IY8E3iiC0JI	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'first':1 'messag':2	1672314859079	145
$LLxGQgsj2x835E7aJtEtKuPEzf1fHJTT_1b0cxZaynk	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'whatev':1	1672314859309	146
$xaKVxYK5Ka0brhbVcFdQdutgxYlZom-dUIRWmloBBms	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'b':2 'localhost':3 'matrix':1 'messag':6 'third':5 'whatev':4	1672314859555	147
$7IBjUUbkm6m5Y_DazT_SUW3_XBAwV0nvHP6nkPuBbV0	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'messag':2 'root':1	1672314859803	148
$iZZsHDRKa9MPh0wKPGoTIkR9_IN1gXmgYQ3CLA-oEsU	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'matrix':1 'messag':4,6 'repli':5 'root':3	1672314859926	149
$OIgyn6WfwavdRqCIV587JtVG-UzMqFnY1_VC_N2O6ok	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'last':5 'matrix':1 'messag':4,6 'repli':3	1672314860182	151
$z-yABBMUu-RFJeiOLWwmWghP2O4vgO3Bts6c9FX-uG8	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'messag':2 'new':1	1672314861926	152
$P2eP-7teBmGXcBM7DqUedLeBNdY5eaTasFqCr7GXY74	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'first':1 'messag':3 'mm':2	1672315004592	153
$62DK_5Urc-R1gCm6T-D7rEFWp3Q47rECTaNApSOe0tg	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'first':5 'localhost':4 'mattermost':2 'messag':7,10 'mm':1,6,9 'second':8	1672315005001	154
$reo6-sRCAReTplLLrWZiUXEMMfaufd1o-PclhKbhxXw	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'b':3 'localhost':4,8 'mattermost':2,6 'messag':11 'mm':1,5,10 'third':9	1672315005201	155
$LiUaGyMC-ZVhJFLD9EeZsUNlhdIzJ2J41q-tpdMYQ-g	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'first':1 'matrix':2 'messag':3	1672315005582	156
$kGXjbDILpzPlAVquVm-0ro1Y2cAjvBSU3chLQmB-ZgI	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'first':3 'matrix':1,4,7 'messag':5,8 'second':6	1672315005779	157
$iR6CRvH8xG5VgeMQIZFMBeaVeTjxgDtnqT7tv-PoCf8	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'b':2 'matrix':1,3,6 'messag':7 'third':5	1672315005925	158
$47BkoMnB5FT3PSdXLEy0rb4ZdbS1q9w82a669O4lBXg	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'first':1 'messag':2	1672315006320	159
$zI1CZE-pX4aF7RBiJiZqzqFZlxIfJRBpmSuBjEzHTCQ	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'whatev':1	1672315006535	160
$y7fmz8cz_zrBS0ZmRnthufiCH3PFkuCVz8YKzQaf81g	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'b':2 'localhost':3 'matrix':1 'messag':6 'third':5 'whatev':4	1672315006795	161
$mJ65YIJRPOxuW2mcyV5dt1MwIY7iWY76Fnj51047dZM	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'messag':2 'root':1	1672315007015	162
$p7GJemyaMZGUqYX0guKHUqmObfwF2yChmhI7v1sn2nE	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'matrix':1 'messag':4,6 'repli':5 'root':3	1672315007130	163
$5Iq2ZU88BXgNKKqMGOu71dH7vsyaxwI-Fxg8ocEMI2E	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'last':5 'matrix':1 'messag':4,6 'repli':3	1672315007420	165
$LHW3l0dgme8yNUY6xjIvP_Osal1_vZAuIfg7vCLzGKI	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'messag':2 'new':1	1672315009057	166
$_XRh5iYtBtMSC8b9sq-Zq1kS1LqI6azDTXLEGQTiQSs	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'first':1 'messag':3 'mm':2	1672317654041	167
$jgIb5yphKm1y65Shpo1bZF38fQ0ZqUjOopYEMjB2JS0	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'first':5 'localhost':4 'mattermost':2 'messag':7,10 'mm':1,6,9 'second':8	1672317654290	168
$j96SJY0VtGl6Q_Fnj_jg3BifdW7s0-Vd8t57DrAeAX8	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'b':3 'localhost':4,8 'mattermost':2,6 'messag':11 'mm':1,5,10 'third':9	1672317654478	169
$5-UBR4vNvgnHcUIuQA0gIHJmn4pOL-BNEZ33B-2Dmes	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'first':1 'matrix':2 'messag':3	1672317654712	170
$8f7euYUQUOKVs1LECS5C0ny-iJc0LrEhKy5AjaE9VwM	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'first':3 'matrix':1,4,7 'messag':5,8 'second':6	1672317654827	171
$n7rEuNOUTfPAb-nKtA8sQLtp0FZoDqOfMyqN9eKVULc	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'b':2 'matrix':1,3,6 'messag':7 'third':5	1672317655010	172
$KdF0e2L1V2qamNtPDDdbE1nZ8xvaqEBCeH0VcCCosQ8	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'first':1 'messag':2	1672317655291	173
$VGPWrlgPM0aSEOjGq1_ygJ2gwcjdfMl06P2yF-1EjMw	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'whatev':1	1672317655501	174
$T-S0-0A2-tysbZGnQHyOgfmxVouK-Ise06pRgQbLLcg	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'b':2 'localhost':3 'matrix':1 'messag':6 'third':5 'whatev':4	1672317655810	175
$jTQQwpTqOMCeKxagSFuov0Dg8yBrYJJogGNCxBE1qwk	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'messag':2 'root':1	1672317656025	176
$8Hjay0ed9n_Y3vv-Lhtc_-A0-5CvZe8YsPugJA7pwVg	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'matrix':1 'messag':4,6 'repli':5 'root':3	1672317656117	177
$5G3tHkgsc39AkOi94e7gxCeKaPhkmyOOAZlGWI8YaCQ	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'last':5 'matrix':1 'messag':4,6 'repli':3	1672317656609	179
$c-G9o6jTgFkz_rB_zESYfRkHoFMmTM5uCDXF1JAermc	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'messag':2 'new':1	1672317658319	180
$eY9D8MVKC5bDdinpPVI9ooLWvoYHx0tLFn-vRWkp9nk	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'first':1 'messag':3 'mm':2	1672317897360	181
$AAj21zp54kdoP3h1Zql3vB7JlPNE4Y9HrXrzBQPQrTA	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'first':5 'localhost':4 'mattermost':2 'messag':7,10 'mm':1,6,9 'second':8	1672317897621	182
$VZnQHRUET5azOmfmvUZMF1_eEKzi1_WkVHB0pxMELxo	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'b':3 'localhost':4,8 'mattermost':2,6 'messag':11 'mm':1,5,10 'third':9	1672317897801	183
$7q-JkspgsFYptPnMJ25LHdffz-rXLRDHzidSYCV3Kc8	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'first':1 'matrix':2 'messag':3	1672317898031	184
$dtGyXiOFORXfCA1yAgiPJbV5UKJjEo-zfetInljHoV0	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'first':3 'matrix':1,4,7 'messag':5,8 'second':6	1672317898206	185
$dxD8VRi5x30Gu7BMEOui-JOrXZEL9meU6Q8aZra1b6U	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'b':2 'matrix':1,3,6 'messag':7 'third':5	1672317898341	186
$bXKGeqgVWpdObwAv0HPtsV7_MNqo8HhD_whsZ1gxx54	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'first':1 'messag':2	1672317898605	187
$LOcz4Bm15D4BsyuDXygSGL-0AvIjwSLYy4cezgebQK8	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'whatev':1	1672317898797	188
$RJSqE0ZymidM-ZtkpYLdrShv6_yNohaw5QtWzVooGsk	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'b':2 'localhost':3 'matrix':1 'messag':6 'third':5 'whatev':4	1672317899053	189
$EdC99i51IXAQXh-JndOybB0EFIdpgm02s0Z6Takw4Jw	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'messag':2 'root':1	1672317899297	190
$pp-1vh-obnf3bLKs4cnpwy9dbINdz1MGiUDLrdenfek	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'matrix':1 'messag':4,6 'repli':5 'root':3	1672317899445	191
$gLYRtP_fFTIbdUQ6jtldLcUG60gMNlghw7x9t2_PurE	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'last':5 'matrix':1 'messag':4,6 'repli':3	1672317899688	193
$AbcQJxS0qvSibn6R_hm5OSrLKkHjrpsW8oo97om40r8	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'messag':2 'new':1	1672317901740	194
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
$oPNBx-eTHzyLXPzpYpdxdhLdVeGmx5lNmrECxIazfPQ	22
$3pZnE6ITQzzyNsuVCenuFBVRMocr892PiAvIbMGbMBM	21
$Oqb-EaDS-8U6U1Z6bTGSE7FJIlxKGhzMkNsnYIJY0Y0	23
$hJeKBcpebJzm9oiwjDCNTWPtbEcfp9GOLXl3yGkyaFU	24
$9cACT8rCcbUXbMhABzEciyF9pIIDRFNzaBkRVPH_0mk	25
$0gxNuNkWyOeHPtnNZ92FzvprItMgnH9hLCbYuY0Vzos	26
$9ArTh8Z2w2oc68FOD1X8Ka3DlK7lq00HaHKT_4DMSY4	27
$V_uchZ_8H2oh6EdsXqKsT6Ri62_YZtAAMfZi8pbBGrc	28
$Q4TOA6SPu2kQIrypB8QEJLHphxV5mHZ_eFwQux4jWSY	29
$YwLlyzcAMpJ69jsxTNglcWTbK8XHK8huc6aB6jpgEWk	30
$irHFClZVEAzlAtsjct-1MJjEotldPu1Ozkm_NYQrtqI	265
$QwAobZq6xey4D-6yOm_xg4h6rCKIRUpTqM4HBNroJwE	279
$3xEI-iU3Teo4B51pXGBbjKxM_DDvYlASNK7W09pHncM	280
$ETv-B1S-bU8wgS3S1fDdineVdS9YGNq1EMeUPHb6imQ	281
$GMh4hFLoeDc1Ssk9kdi7yAMIMSZA9zOJYJMC1AJEOKs	282
$zMfjO64yH55JKcwd-hMCa1P1ARHyAuvBbnPeUiNnS48	283
$5-KkKYPCr68IjD4sKk3rDF6kVYVkDMllW0BFUv7G4Do	284
$sPO_9Od1FvK55Z9_vb0hx3ophiGuLyATo1RKYIEFxHc	285
$oXLyUPbqiXmRRNovjt9_FJFQLCzMQjPsaism-trtsDw	286
$7EOMmT1sBVcDB2udDBhhf11Mok_GC9CY-6bxtIKAYpc	287
$-J2tr3j7vfmJ8ZSBAK5AyvQYmP2Byp-7dKfcBg5xHjU	288
$o0wI9-m-SdyS4UK7_m9_MUd0luWmj6eoXfMg1ieT00g	289
$wEwGnOPXUgG2_4DpqsPrYbSlIM2TnPjdWNDyVbZNE2Y	290
$oZEGsAxUrYn8R6NS359wZO9T54eXOD-N88ftDK7ZHGU	291
$LN4aYSSVw4GLaWf8g7uzrsw-fHTUyCBwq_-RRgS-MGE	292
$sY34u-PbOKSI3_z8SIqGfn_2XnO9wqZ_eU1dvGDnRJY	293
$zhfRuogjo-Vq5GM4-f6hyuXBGHx99o9_Nef1KWi2-EM	294
$3A5iUMUsDMAckTZ_lQ9ZLyQdw7FKGrqWfMMxwAZJCwc	295
$aUCd2uzLS80uiu1DeYrTDp1wAWs7M1ba_4Srm8LLnmU	296
$zogqtnD68sbYTleQBUL-RkGDpkNmTHar6ilm_2oVnRs	297
$OcjvTopfs1z8zuVgRxn4ynq9LH7z4eQhJnWG0PQ7150	298
$GcBRlllGdKFvT1pDzY7airMfjuYYNt06vxkQ0BnM6IM	299
$JtjXz-jm6mi5wU33MudkV8ZsCM2V-zduDqeI1xIG254	300
$6cga7PdI_98v2MEH6Wosfik3Plxt3Ml7GwsUkSFFa00	301
$0BYuX-7BWlMOYXwWp-y_txKwBBorVZzavW6fDuXxUrM	302
$OOCwtQCB-nmnnlgQ3ST3ItcIsITOLkC3b4a-WpaJjRg	321
$gnR3q3jOOEFI04MZ00yFbtQ5ZNs9EfZENfrrOEEj46s	302
$ZI6mQ9fcQaRUQRDK0WWxDErZcQGD7ahzFrk1b9nCFRE	302
$raYGvFCt-q8kxStPhO_tzxQ3pOmVeo5gn8lTV6sHBvs	302
$mfDu-vDNMkOg-psLHXlWcSXOnVkeuUPJfdm2cZ-3P-k	302
$iDgp052fBKJYL2KTsRdizUAlriA5itky5-e20aiZwHI	302
$uwN8jjs4qWXT6fsX4o-36T96CWj17IDa_TJ3mF5Hd7M	321
$mXxM94SwVR0FuKbH_riuFTeW0zH7Om62-HEudW_5y80	321
$OVhb59gyrKY7dsgLlfdIwe1H4O5zslN774jooAK4vec	302
$AxFCh7nvzu51kpXaQqyK3CKEqdyGhhJ0zhqT-c9LGPk	321
$0ruVoUZRE1Edh-f7Z0QopPRTCr7L2kEpX8unxgxmfSQ	361
$hWVSd4FzjwQq7FYDdhFSCgpisb3gxDJ2OAjCjYS6rkg	362
$OJhJIVnJWjcgl3gc2AqLQK7sy1tKn075fy4E5qUK014	363
$nsJ2oe7ZtdBtY0V-sJWzGBBDi7tcgH24zUaAdmLjXy4	364
$XYKCYavbY8FMdUIlSSoqP0likUnTP6uJ0yHoGQCMnWQ	365
$fc-Paa3ZBQU-GAAxH4QWDNrWblQvQ4ddYVzPTPiYV6U	366
$4KgY7ivi_pp1q2tjdk7IWENjs1kzgSRLB29nKbq-UXw	367
$0EmcDbHM6t0AJ7YKAcphqL8othdZg4dIXSazEHvnCno	368
$EklY0FV28pDgoXqwoQUjAB5wTv33O8RCHRE8k2k6o2c	369
$ShuNV5AOx3oTjKr3eYjFKvzCZ374R_0vxs2HC21ht-g	370
$UTOQTSrmXya3IQYDcRPwNWN1bIv2zQ3YfbaVRy9NQuA	372
$IfK4xyQ_h94nUHneDilGoM0TTwuWFeP5_u_nlRs571U	371
$sbDgkkxT05mw8xIVFWyOJtbW9nnehE06Wvxor1z8ms8	373
$aaPR9QI7az6NxeJ0hSrQxyKzzVyM-rBWODbN9y9rM9Q	374
$TbzKCcECXvJAKvBu5GZCTLIGi7Js0b1w9dE6KKZXaKo	375
$2-SFwejONuAnI3cUJ4UN3FSzzJjeIWUURtWOJiO2sWo	376
$72MNMNMOJMJpfLbdNKdm6ZXGr14ukIKdq-fG2OvzOqg	377
$LjACIs2QTEZTfukFRb30GQyevcb7EREdVFxoNEgvHSk	378
$XhzyXIYIbI0BfDV1QY4H3b4Wrpy5pJgJsGNZc8P8seg	379
$EB67Xwo9B0__CxNTvptFIy4e4vG93cmEcHRWbiVSFJU	380
$85g2ma_sFrYS8UbhpRwYEglJLj7xswd8VgNCg787_3E	381
$jL60Q94H_SC7S4ZFOWkA4RilDwTMIUci2DyEXyQS_t0	382
$WPbDUZRE7W6o_O4D0qf40PxoXNWcHrBwx3LxCA_ILaY	383
$sPW_-g3Oq09Bq8Rm-TKPTRO4HHOlMXEni0rE18Y01h4	384
$QjDo1bVrVGh33tmezjIVWxT6VXLutgIWlP9outS8Gcg	383
$j4OmrTBgGXlAg2ui751-jxTS4uMSPCzpj81xWRfOWiA	383
$lQM-XkcgjA40yc1T7BNzbZ8V8yxcnsj23SxrixdEev8	383
$XikqApD6-vTeGUebJl-_Bc9ButeowpABz5W37dejAy0	383
$A5qbTNFuQ1MZL2fuT4oUFzi1xCHHDk0NuQZstoz4u-U	384
$kMqJ62yuvBi4RWfOiLMiPcoSKbfcjZvTwwiuRRmfEKA	384
$2xt0-DVGoBAEL-GIwj9HZfHBCQu7_M-HzB2XaEfxjwM	384
$6CT_ZCazUgJysnWN-q2s4b5iR-x1EbXa932nBRpldW4	383
$UD0jEJtVKXhlCRf7VxHITWSUyhzaGkpH0VGbwilf2RE	383
$BMnLymfijfp2V1tH1M6Nayfx-iF_rRw70COW60dCBG0	383
$jhFoiytsqlLXRCkoL5gH2sXpQQJFwk3XLtzQPCpA0K8	384
$0ClPrn0jv_hdCQB4TqbWVPUxxSqFeDViCsOjYwQVDAg	801
$kkmwTP1mOPGymh7Q3_N1Y7ftC1xrv5qaHbV_zi99vD4	804
$UQr1C3BZK9MztXbBR2a0yz0wCyXSy_abmCstrHnXi2E	384
$56oOQ2hizWAJWWKoJTMYGwAKX_gaANdZg2QHgtC63ZE	784
$6Sy4DU04a_WCzalQkimJ_l9-eYsJ3kcn3Lat9w42L2I	785
$FC2J9PSIQLoF8YJo6zY2dP8Eo55L8CPgzVGN7iaofRo	786
$WcPnOWvRmgShLlAe8RxY4-_M71l0auS5ykpKdmUS0LU	787
$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E	789
$ZLuzCoh1UZ9oNHYyBNCtneq81TelpJ882dsDdio0oKU	799
$Zv-9wNEnjnF-VeZtZKtHkYObGhccwLKewNnJg-fUiF8	802
$53rDO0S-X2QNPUyUVrTGx092yf0EW0nvJXQNLgQ09kc	804
$wehc8FMA82xW0EU5F86ZkvsBra_SZ0JSA3Yweowv_s8	384
$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo	805
$sD72WUGTkmqfbvA4mcCNx5IcT-WfbmjsGalYB6V6S-E	805
$p2y4ivsQApKJEQKZQ-5KFk47veZlq7V00tHHrokVqK0	384
$VzxEyd-riDbZr-sdhUSEcA4h_6kWYfmSeoqEtaZHFFo	383
$BtKmdXlHyT65KPvPIiDSk38oldbOKOUbuv7J13Up4wE	781
$HVWinlm6AKNeOld7iV_yqdfmpznmG5wAyWK5k3xjM7Y	782
$aa2-bg9KcCtrn4nE5HK1JGC6sa8Gr7jWqLhPgLQTtsU	803
$99PDED6qRD6JvJgyuUpKL5SGciNeDx4Q8aNU8-knIfI	805
$FNOekiMLFE4AEgQ1st7kiouCRAYO3DKEMbrYHGbH-zw	783
$6ZYuUr8K6uh0D7tl9-HD___6hQH3lj8qU1liF0zAkmo	794
$-R5ZDLwPtIisO-W746dPRRrr1U6HjM8uhC78Zh95UUQ	788
$19Wa_uoHXFwHicMPIWHRa1c8H1yIjgzKxpDzo89CTTE	791
$Qyk1jqM8wu6uOaEDEalSs_0hepeq6CnfZZRy1hQ4sd8	797
$qgyz1sVriFBiepR7YLOpA_tcnRjhDX9q13fkeJa8i3U	798
$j_Vf4RSpugcR52JQthWyGuqRIEdGrETb4ZLvnGxwwg0	805
$iVV3o47Y40f29uNsCktD5R1VKbTF1y3nGq4KSKQ5YYo	804
$M2xNoGVeTRazjk5EjiA0u3mOkneK7za9KWYn2LMJFwA	790
$ggRHO4QwGg8SLwSXlSNnHypSBsgj2jFMUXbjC7U97qM	800
$m8QuIxNBjngQA1UhDPZlw6nIvodE764mdmYG9oCKf94	805
$RuT3uWLcY4y4GhqYFFNXur6XuNwXipRRmx5rJFfM9ms	804
$lDJnxY-YfTRyXQcBLRlbFT2_w4DXO4Pks75YGGa5M5o	792
$t_tUn4wROpupdwEmZnXWQ-mtnx68XnGjofi61K92cRY	795
$JgtV2Jrt_3Cws_oeqEte6xeUnTbTSMu0pBPrEWD4WyM	796
$SLqtTg1DQZU0Y4ezk90kDHz7IxD9TXjhW4qQAoPUfTk	793
$mjUbm6eO9Jk-i6bqdyRHFZy9L-lH5TOO27GYMQ87nhs	805
$ewJTQJq2XdLvkqYVULlUmmJ-A3LQ6Jnqs4GDYi6q0DE	804
$kdWmWl1h_wHbp_4CZHM4AOF1I3SpjgbLYkYoFiWiazU	805
$OL5YFZuIzpeGWvQkJsWD5fA-_tqvM6MNM8aACLhDIKc	805
$WxOx5K9OBtSH4SKkxlQDUCVkiuA8mdui6eTN417KUig	805
$9eV_AyLXyN9dQJyo8nKzxH0MD2Pj26OD3m5hxM368ek	805
$KAudDRl-ilYkXdKdFFwSH1rjB9FuDL3iaIcj9chsvuc	804
$NBW9KofbXfyJlflrssj5f0gU9-vix_ChkMTdCTutt6E	804
$G4jqJ_vLOuComzEY5LKlWgJmqk76rEv2BaFnoUc32C4	804
$PmdsaAuptefoxepoi5dH3S5XZjMQnrw_IY8E3iiC0JI	805
$LLxGQgsj2x835E7aJtEtKuPEzf1fHJTT_1b0cxZaynk	805
$xaKVxYK5Ka0brhbVcFdQdutgxYlZom-dUIRWmloBBms	805
$7IBjUUbkm6m5Y_DazT_SUW3_XBAwV0nvHP6nkPuBbV0	804
$iZZsHDRKa9MPh0wKPGoTIkR9_IN1gXmgYQ3CLA-oEsU	804
$OxJtFsDfjfHJ57HdnctrwwYfeMAuGw-MFWayc0MqGW4	804
$OIgyn6WfwavdRqCIV587JtVG-UzMqFnY1_VC_N2O6ok	804
$z-yABBMUu-RFJeiOLWwmWghP2O4vgO3Bts6c9FX-uG8	805
$P2eP-7teBmGXcBM7DqUedLeBNdY5eaTasFqCr7GXY74	805
$62DK_5Urc-R1gCm6T-D7rEFWp3Q47rECTaNApSOe0tg	805
$reo6-sRCAReTplLLrWZiUXEMMfaufd1o-PclhKbhxXw	805
$LiUaGyMC-ZVhJFLD9EeZsUNlhdIzJ2J41q-tpdMYQ-g	804
$kGXjbDILpzPlAVquVm-0ro1Y2cAjvBSU3chLQmB-ZgI	804
$iR6CRvH8xG5VgeMQIZFMBeaVeTjxgDtnqT7tv-PoCf8	804
$47BkoMnB5FT3PSdXLEy0rb4ZdbS1q9w82a669O4lBXg	805
$zI1CZE-pX4aF7RBiJiZqzqFZlxIfJRBpmSuBjEzHTCQ	805
$y7fmz8cz_zrBS0ZmRnthufiCH3PFkuCVz8YKzQaf81g	805
$mJ65YIJRPOxuW2mcyV5dt1MwIY7iWY76Fnj51047dZM	804
$p7GJemyaMZGUqYX0guKHUqmObfwF2yChmhI7v1sn2nE	804
$Ky-_xzOrnEPuDm0WQev0E1urDcDHtvv8esKT3jQ6lFY	804
$5Iq2ZU88BXgNKKqMGOu71dH7vsyaxwI-Fxg8ocEMI2E	804
$LHW3l0dgme8yNUY6xjIvP_Osal1_vZAuIfg7vCLzGKI	805
$_XRh5iYtBtMSC8b9sq-Zq1kS1LqI6azDTXLEGQTiQSs	805
$jgIb5yphKm1y65Shpo1bZF38fQ0ZqUjOopYEMjB2JS0	805
$j96SJY0VtGl6Q_Fnj_jg3BifdW7s0-Vd8t57DrAeAX8	805
$5-UBR4vNvgnHcUIuQA0gIHJmn4pOL-BNEZ33B-2Dmes	804
$8f7euYUQUOKVs1LECS5C0ny-iJc0LrEhKy5AjaE9VwM	804
$n7rEuNOUTfPAb-nKtA8sQLtp0FZoDqOfMyqN9eKVULc	804
$KdF0e2L1V2qamNtPDDdbE1nZ8xvaqEBCeH0VcCCosQ8	805
$VGPWrlgPM0aSEOjGq1_ygJ2gwcjdfMl06P2yF-1EjMw	805
$T-S0-0A2-tysbZGnQHyOgfmxVouK-Ise06pRgQbLLcg	805
$jTQQwpTqOMCeKxagSFuov0Dg8yBrYJJogGNCxBE1qwk	804
$8Hjay0ed9n_Y3vv-Lhtc_-A0-5CvZe8YsPugJA7pwVg	804
$NHchZjGDozZxBeE_hBCfcWNQSoGcpRSxMwGAV4CVzWU	804
$5G3tHkgsc39AkOi94e7gxCeKaPhkmyOOAZlGWI8YaCQ	804
$c-G9o6jTgFkz_rB_zESYfRkHoFMmTM5uCDXF1JAermc	805
$eY9D8MVKC5bDdinpPVI9ooLWvoYHx0tLFn-vRWkp9nk	805
$AAj21zp54kdoP3h1Zql3vB7JlPNE4Y9HrXrzBQPQrTA	805
$VZnQHRUET5azOmfmvUZMF1_eEKzi1_WkVHB0pxMELxo	805
$7q-JkspgsFYptPnMJ25LHdffz-rXLRDHzidSYCV3Kc8	804
$dtGyXiOFORXfCA1yAgiPJbV5UKJjEo-zfetInljHoV0	804
$dxD8VRi5x30Gu7BMEOui-JOrXZEL9meU6Q8aZra1b6U	804
$bXKGeqgVWpdObwAv0HPtsV7_MNqo8HhD_whsZ1gxx54	805
$LOcz4Bm15D4BsyuDXygSGL-0AvIjwSLYy4cezgebQK8	805
$RJSqE0ZymidM-ZtkpYLdrShv6_yNohaw5QtWzVooGsk	805
$EdC99i51IXAQXh-JndOybB0EFIdpgm02s0Z6Takw4Jw	804
$pp-1vh-obnf3bLKs4cnpwy9dbINdz1MGiUDLrdenfek	804
$xKmd10QHFv5EgHAyd9HpWHkEi2QTI9MhKVlqpVntWM8	804
$gLYRtP_fFTIbdUQ6jtldLcUG60gMNlghw7x9t2_PurE	804
$AbcQJxS0qvSibn6R_hm5OSrLKkHjrpsW8oo97om40r8	805
\.


--
-- Data for Name: event_txn_id; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_txn_id (event_id, room_id, user_id, token_id, txn_id, inserted_ts) FROM stdin;
$ZI6mQ9fcQaRUQRDK0WWxDErZcQGD7ahzFrk1b9nCFRE	!kmbTYjjsDRDHGgVqUP:localhost	@matrix_a:localhost	3	m1672306061819.0	1672306061863
$mfDu-vDNMkOg-psLHXlWcSXOnVkeuUPJfdm2cZ-3P-k	!kmbTYjjsDRDHGgVqUP:localhost	@matrix_b:localhost	4	m1672306062302.0	1672306062351
$iDgp052fBKJYL2KTsRdizUAlriA5itky5-e20aiZwHI	!kmbTYjjsDRDHGgVqUP:localhost	@matrix_a:localhost	3	m1672306062480.0	1672306062516
$OVhb59gyrKY7dsgLlfdIwe1H4O5zslN774jooAK4vec	!kmbTYjjsDRDHGgVqUP:localhost	@matrix_a:localhost	3	m1672306063113.0	1672306063153
$AxFCh7nvzu51kpXaQqyK3CKEqdyGhhJ0zhqT-c9LGPk	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672306063313.0	1672306063349
$A5qbTNFuQ1MZL2fuT4oUFzi1xCHHDk0NuQZstoz4u-U	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672312690692.0	1672312690764
$kMqJ62yuvBi4RWfOiLMiPcoSKbfcjZvTwwiuRRmfEKA	!dKcbdDATuwwphjRPQP:localhost	@matrix_b:localhost	4	m1672312690803.0	1672312690897
$2xt0-DVGoBAEL-GIwj9HZfHBCQu7_M-HzB2XaEfxjwM	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672312690956.1	1672312691187
$UD0jEJtVKXhlCRf7VxHITWSUyhzaGkpH0VGbwilf2RE	!kmbTYjjsDRDHGgVqUP:localhost	@matrix_b:localhost	4	m1672312691752.0	1672312691942
$jhFoiytsqlLXRCkoL5gH2sXpQQJFwk3XLtzQPCpA0K8	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672312692940.0	1672312693049
$UQr1C3BZK9MztXbBR2a0yz0wCyXSy_abmCstrHnXi2E	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672312693119.1	1672312693273
$wehc8FMA82xW0EU5F86ZkvsBra_SZ0JSA3Yweowv_s8	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672312693293.2	1672312693440
$p2y4ivsQApKJEQKZQ-5KFk47veZlq7V00tHHrokVqK0	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672312693485.3	1672312693693
$mjUbm6eO9Jk-i6bqdyRHFZy9L-lH5TOO27GYMQ87nhs	!kmbTYjjsDRDHGgVqUP:localhost	@matrix_a:localhost	3	m1672314833209.0	1672314833349
$kdWmWl1h_wHbp_4CZHM4AOF1I3SpjgbLYkYoFiWiazU	!kmbTYjjsDRDHGgVqUP:localhost	@matrix_b:localhost	4	m1672314833825.0	1672314833875
$sD72WUGTkmqfbvA4mcCNx5IcT-WfbmjsGalYB6V6S-E	!kmbTYjjsDRDHGgVqUP:localhost	@matrix_a:localhost	3	m1672314834232.0	1672314834282
$99PDED6qRD6JvJgyuUpKL5SGciNeDx4Q8aNU8-knIfI	!kmbTYjjsDRDHGgVqUP:localhost	@matrix_a:localhost	3	m1672314834969.0	1672314835053
$53rDO0S-X2QNPUyUVrTGx092yf0EW0nvJXQNLgQ09kc	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672314835267.0	1672314835339
$KAudDRl-ilYkXdKdFFwSH1rjB9FuDL3iaIcj9chsvuc	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672314858504.0	1672314858563
$NBW9KofbXfyJlflrssj5f0gU9-vix_ChkMTdCTutt6E	!dKcbdDATuwwphjRPQP:localhost	@matrix_b:localhost	4	m1672314858586.0	1672314858712
$G4jqJ_vLOuComzEY5LKlWgJmqk76rEv2BaFnoUc32C4	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672314858730.1	1672314858867
$LLxGQgsj2x835E7aJtEtKuPEzf1fHJTT_1b0cxZaynk	!kmbTYjjsDRDHGgVqUP:localhost	@matrix_b:localhost	4	m1672314859284.0	1672314859334
$7IBjUUbkm6m5Y_DazT_SUW3_XBAwV0nvHP6nkPuBbV0	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672314859754.0	1672314859834
$iZZsHDRKa9MPh0wKPGoTIkR9_IN1gXmgYQ3CLA-oEsU	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672314859844.1	1672314859980
$OxJtFsDfjfHJ57HdnctrwwYfeMAuGw-MFWayc0MqGW4	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672314859996.2	1672314860104
$OIgyn6WfwavdRqCIV587JtVG-UzMqFnY1_VC_N2O6ok	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672314860143.3	1672314860279
$LiUaGyMC-ZVhJFLD9EeZsUNlhdIzJ2J41q-tpdMYQ-g	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672315005553.0	1672315005624
$kGXjbDILpzPlAVquVm-0ro1Y2cAjvBSU3chLQmB-ZgI	!dKcbdDATuwwphjRPQP:localhost	@matrix_b:localhost	4	m1672315005672.0	1672315005849
$iR6CRvH8xG5VgeMQIZFMBeaVeTjxgDtnqT7tv-PoCf8	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672315005868.1	1672315006038
$zI1CZE-pX4aF7RBiJiZqzqFZlxIfJRBpmSuBjEzHTCQ	!kmbTYjjsDRDHGgVqUP:localhost	@matrix_b:localhost	4	m1672315006512.0	1672315006563
$mJ65YIJRPOxuW2mcyV5dt1MwIY7iWY76Fnj51047dZM	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672315006989.0	1672315007053
$p7GJemyaMZGUqYX0guKHUqmObfwF2yChmhI7v1sn2nE	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672315007087.1	1672315007203
$Ky-_xzOrnEPuDm0WQev0E1urDcDHtvv8esKT3jQ6lFY	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672315007218.2	1672315007356
$5Iq2ZU88BXgNKKqMGOu71dH7vsyaxwI-Fxg8ocEMI2E	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672315007386.3	1672315007487
$5-UBR4vNvgnHcUIuQA0gIHJmn4pOL-BNEZ33B-2Dmes	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672317654681.0	1672317654741
$8f7euYUQUOKVs1LECS5C0ny-iJc0LrEhKy5AjaE9VwM	!dKcbdDATuwwphjRPQP:localhost	@matrix_b:localhost	4	m1672317654771.0	1672317654909
$n7rEuNOUTfPAb-nKtA8sQLtp0FZoDqOfMyqN9eKVULc	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672317654926.1	1672317655074
$VGPWrlgPM0aSEOjGq1_ygJ2gwcjdfMl06P2yF-1EjMw	!kmbTYjjsDRDHGgVqUP:localhost	@matrix_b:localhost	4	m1672317655467.0	1672317655543
$jTQQwpTqOMCeKxagSFuov0Dg8yBrYJJogGNCxBE1qwk	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672317655997.0	1672317656052
$8Hjay0ed9n_Y3vv-Lhtc_-A0-5CvZe8YsPugJA7pwVg	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672317656069.1	1672317656240
$NHchZjGDozZxBeE_hBCfcWNQSoGcpRSxMwGAV4CVzWU	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672317656361.2	1672317656531
$5G3tHkgsc39AkOi94e7gxCeKaPhkmyOOAZlGWI8YaCQ	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672317656547.3	1672317656678
$7q-JkspgsFYptPnMJ25LHdffz-rXLRDHzidSYCV3Kc8	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672317898001.0	1672317898055
$dtGyXiOFORXfCA1yAgiPJbV5UKJjEo-zfetInljHoV0	!dKcbdDATuwwphjRPQP:localhost	@matrix_b:localhost	4	m1672317898082.0	1672317898233
$dxD8VRi5x30Gu7BMEOui-JOrXZEL9meU6Q8aZra1b6U	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672317898241.1	1672317898393
$LOcz4Bm15D4BsyuDXygSGL-0AvIjwSLYy4cezgebQK8	!kmbTYjjsDRDHGgVqUP:localhost	@matrix_b:localhost	4	m1672317898765.0	1672317898824
$EdC99i51IXAQXh-JndOybB0EFIdpgm02s0Z6Takw4Jw	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672317899263.0	1672317899323
$pp-1vh-obnf3bLKs4cnpwy9dbINdz1MGiUDLrdenfek	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672317899338.1	1672317899488
$xKmd10QHFv5EgHAyd9HpWHkEi2QTI9MhKVlqpVntWM8	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672317899505.2	1672317899637
$gLYRtP_fFTIbdUQ6jtldLcUG60gMNlghw7x9t2_PurE	!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	3	m1672317899652.3	1672317899770
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
10	$oPNBx-eTHzyLXPzpYpdxdhLdVeGmx5lNmrECxIazfPQ	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	10	1672241417787	1672241417878	@matterbot:localhost	f	master	20
10	$3pZnE6ITQzzyNsuVCenuFBVRMocr892PiAvIbMGbMBM	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	10	1672241417777	1672241417928	@matterbot:localhost	f	master	21
11	$Oqb-EaDS-8U6U1Z6bTGSE7FJIlxKGhzMkNsnYIJY0Y0	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	11	1672241421316	1672241421429	@matterbot:localhost	f	master	22
11	$hJeKBcpebJzm9oiwjDCNTWPtbEcfp9GOLXl3yGkyaFU	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	11	1672241421505	1672241421616	@matterbot:localhost	f	master	23
12	$9cACT8rCcbUXbMhABzEciyF9pIIDRFNzaBkRVPH_0mk	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	12	1672241421587	1672241421631	@matterbot:localhost	f	master	24
12	$0gxNuNkWyOeHPtnNZ92FzvprItMgnH9hLCbYuY0Vzos	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	12	1672241421719	1672241421815	@matterbot:localhost	f	master	25
13	$9ArTh8Z2w2oc68FOD1X8Ka3DlK7lq00HaHKT_4DMSY4	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	13	1672241421811	1672241421845	@mm_mattermost_a:localhost	f	master	26
13	$V_uchZ_8H2oh6EdsXqKsT6Ri62_YZtAAMfZi8pbBGrc	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	13	1672241421941	1672241422021	@mm_mattermost_a:localhost	f	master	27
14	$Q4TOA6SPu2kQIrypB8QEJLHphxV5mHZ_eFwQux4jWSY	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	14	1672241422029	1672241422093	@mm_mattermost_b:localhost	f	master	28
14	$YwLlyzcAMpJ69jsxTNglcWTbK8XHK8huc6aB6jpgEWk	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	14	1672241422141	1672241422200	@mm_mattermost_b:localhost	f	master	29
15	$irHFClZVEAzlAtsjct-1MJjEotldPu1Ozkm_NYQrtqI	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	15	1672248712153	1672248712202	@mm_mattermost_a:localhost	f	master	30
16	$QwAobZq6xey4D-6yOm_xg4h6rCKIRUpTqM4HBNroJwE	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	16	1672248798272	1672248798318	@matterbot:localhost	f	master	31
17	$3xEI-iU3Teo4B51pXGBbjKxM_DDvYlASNK7W09pHncM	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	17	1672248798425	1672248798447	@mm_mattermost_a:localhost	f	master	32
18	$ETv-B1S-bU8wgS3S1fDdineVdS9YGNq1EMeUPHb6imQ	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	18	1672249103595	1672249104803	@matrix_a:localhost	f	master	33
19	$GMh4hFLoeDc1Ssk9kdi7yAMIMSZA9zOJYJMC1AJEOKs	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	19	1672249106075	1672249106147	@matrix_a:localhost	f	master	34
20	$zMfjO64yH55JKcwd-hMCa1P1ARHyAuvBbnPeUiNnS48	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	20	1672249106854	1672249106942	@matrix_a:localhost	f	master	35
15	$5-KkKYPCr68IjD4sKk3rDF6kVYVkDMllW0BFUv7G4Do	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	15	1672249107449	1672249107517	@matrix_a:localhost	f	master	36
16	$sPO_9Od1FvK55Z9_vb0hx3ophiGuLyATo1RKYIEFxHc	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	16	1672249107906	1672249107936	@matrix_a:localhost	f	master	37
21	$oXLyUPbqiXmRRNovjt9_FJFQLCzMQjPsaism-trtsDw	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	21	1672249108353	1672249108380	@matrix_a:localhost	f	master	38
22	$7EOMmT1sBVcDB2udDBhhf11Mok_GC9CY-6bxtIKAYpc	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	22	1672249109607	1672249109680	@mm_mattermost_b:localhost	f	master	39
17	$-J2tr3j7vfmJ8ZSBAK5AyvQYmP2Byp-7dKfcBg5xHjU	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	17	1672249109780	1672249110003	@mm_mattermost_a:localhost	f	master	40
23	$o0wI9-m-SdyS4UK7_m9_MUd0luWmj6eoXfMg1ieT00g	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	23	1672249109920	1672249110027	@mm_mattermost_a:localhost	f	master	41
26	$3A5iUMUsDMAckTZ_lQ9ZLyQdw7FKGrqWfMMxwAZJCwc	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	26	1672249112088	1672249112216	@matterbot:localhost	f	master	47
18	$wEwGnOPXUgG2_4DpqsPrYbSlIM2TnPjdWNDyVbZNE2Y	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	18	1672249110131	1672249110265	@mm_mattermost_b:localhost	f	master	42
21	$aUCd2uzLS80uiu1DeYrTDp1wAWs7M1ba_4Srm8LLnmU	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	21	1672249112222	1672249112291	@matterbot:localhost	f	master	48
27	$zogqtnD68sbYTleQBUL-RkGDpkNmTHar6ilm_2oVnRs	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	27	1672249112364	1672249112498	@matterbot:localhost	f	master	49
24	$oZEGsAxUrYn8R6NS359wZO9T54eXOD-N88ftDK7ZHGU	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	24	1672249110239	1672249110312	@matterbot:localhost	f	master	43
20	$zhfRuogjo-Vq5GM4-f6hyuXBGHx99o9_Nef1KWi2-EM	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	20	1672249111160	1672249111258	@matterbot:localhost	f	master	46
28	$GcBRlllGdKFvT1pDzY7airMfjuYYNt06vxkQ0BnM6IM	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	28	1672249112651	1672249112742	@mm_mattermost_b:localhost	f	master	51
19	$LN4aYSSVw4GLaWf8g7uzrsw-fHTUyCBwq_-RRgS-MGE	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	19	1672249110470	1672249110522	@matterbot:localhost	f	master	44
25	$sY34u-PbOKSI3_z8SIqGfn_2XnO9wqZ_eU1dvGDnRJY	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	25	1672249111145	1672249111227	@matterbot:localhost	f	master	45
22	$OcjvTopfs1z8zuVgRxn4ynq9LH7z4eQhJnWG0PQ7150	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	22	1672249112469	1672249112538	@matterbot:localhost	f	master	50
29	$6cga7PdI_98v2MEH6Wosfik3Plxt3Ml7GwsUkSFFa00	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	29	1672249112876	1672249112944	@mm_mattermost_a:localhost	f	master	53
23	$JtjXz-jm6mi5wU33MudkV8ZsCM2V-zduDqeI1xIG254	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	23	1672249112754	1672249112798	@mm_mattermost_a:localhost	f	master	52
24	$0BYuX-7BWlMOYXwWp-y_txKwBBorVZzavW6fDuXxUrM	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	24	1672249112992	1672249113435	@mm_mattermost_b:localhost	f	master	54
30	$OOCwtQCB-nmnnlgQ3ST3ItcIsITOLkC3b4a-WpaJjRg	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	30	1672305682122	1672305682166	@mm_mattermost_a:localhost	f	master	55
25	$gnR3q3jOOEFI04MZ00yFbtQ5ZNs9EfZENfrrOEEj46s	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	25	1672305710404	1672305710449	@mm_mattermost_a:localhost	f	master	56
26	$ZI6mQ9fcQaRUQRDK0WWxDErZcQGD7ahzFrk1b9nCFRE	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	26	1672306061836	1672306061862	@matrix_a:localhost	f	master	57
27	$raYGvFCt-q8kxStPhO_tzxQ3pOmVeo5gn8lTV6sHBvs	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	27	1672306062147	1672306062167	@mm_mattermost_a:localhost	f	master	58
28	$mfDu-vDNMkOg-psLHXlWcSXOnVkeuUPJfdm2cZ-3P-k	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	28	1672306062326	1672306062350	@matrix_b:localhost	f	master	59
29	$iDgp052fBKJYL2KTsRdizUAlriA5itky5-e20aiZwHI	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	29	1672306062494	1672306062515	@matrix_a:localhost	f	master	60
31	$uwN8jjs4qWXT6fsX4o-36T96CWj17IDa_TJ3mF5Hd7M	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	31	1672306062756	1672306062777	@mm_mattermost_b:localhost	f	master	61
32	$mXxM94SwVR0FuKbH_riuFTeW0zH7Om62-HEudW_5y80	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	32	1672306062896	1672306062916	@mm_mattermost_b:localhost	t	master	62
30	$OVhb59gyrKY7dsgLlfdIwe1H4O5zslN774jooAK4vec	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	30	1672306063132	1672306063153	@matrix_a:localhost	t	master	63
33	$AxFCh7nvzu51kpXaQqyK3CKEqdyGhhJ0zhqT-c9LGPk	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	33	1672306063330	1672306063348	@matrix_a:localhost	f	master	64
34	$0ruVoUZRE1Edh-f7Z0QopPRTCr7L2kEpX8unxgxmfSQ	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	34	1672308588235	1672308588277	@matterbot:localhost	f	master	65
35	$hWVSd4FzjwQq7FYDdhFSCgpisb3gxDJ2OAjCjYS6rkg	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	35	1672308588403	1672308588438	@mm_mattermost_a:localhost	f	master	66
36	$OJhJIVnJWjcgl3gc2AqLQK7sy1tKn075fy4E5qUK014	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	36	1672308588565	1672308588611	@matrix_a:localhost	f	master	67
37	$nsJ2oe7ZtdBtY0V-sJWzGBBDi7tcgH24zUaAdmLjXy4	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	37	1672308588805	1672308588846	@matrix_a:localhost	f	master	68
38	$XYKCYavbY8FMdUIlSSoqP0likUnTP6uJ0yHoGQCMnWQ	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	38	1672308589144	1672308589181	@matrix_a:localhost	f	master	69
31	$fc-Paa3ZBQU-GAAxH4QWDNrWblQvQ4ddYVzPTPiYV6U	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	31	1672308589333	1672308589379	@matrix_a:localhost	f	master	70
32	$4KgY7ivi_pp1q2tjdk7IWENjs1kzgSRLB29nKbq-UXw	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	32	1672308589600	1672308589632	@matrix_a:localhost	f	master	71
39	$0EmcDbHM6t0AJ7YKAcphqL8othdZg4dIXSazEHvnCno	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	39	1672308590035	1672308590079	@matrix_a:localhost	f	master	72
33	$EklY0FV28pDgoXqwoQUjAB5wTv33O8RCHRE8k2k6o2c	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	33	1672308590900	1672308591021	@mm_mattermost_a:localhost	f	master	73
40	$ShuNV5AOx3oTjKr3eYjFKvzCZ374R_0vxs2HC21ht-g	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	40	1672308590951	1672308591029	@mm_mattermost_b:localhost	f	master	74
34	$UTOQTSrmXya3IQYDcRPwNWN1bIv2zQ3YfbaVRy9NQuA	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	34	1672308591162	1672308591238	@mm_mattermost_b:localhost	f	master	75
41	$IfK4xyQ_h94nUHneDilGoM0TTwuWFeP5_u_nlRs571U	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	41	1672308591151	1672308591241	@mm_mattermost_a:localhost	f	master	76
35	$sbDgkkxT05mw8xIVFWyOJtbW9nnehE06Wvxor1z8ms8	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	35	1672308591372	1672308591449	@matterbot:localhost	f	master	77
42	$aaPR9QI7az6NxeJ0hSrQxyKzzVyM-rBWODbN9y9rM9Q	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	42	1672308591386	1672308591468	@matterbot:localhost	f	master	78
43	$TbzKCcECXvJAKvBu5GZCTLIGi7Js0b1w9dE6KKZXaKo	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	43	1672308592135	1672308592201	@matterbot:localhost	f	master	79
36	$2-SFwejONuAnI3cUJ4UN3FSzzJjeIWUURtWOJiO2sWo	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	36	1672308592151	1672308592222	@matterbot:localhost	f	master	80
37	$72MNMNMOJMJpfLbdNKdm6ZXGr14ukIKdq-fG2OvzOqg	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	37	1672308592958	1672308593036	@matterbot:localhost	f	master	81
44	$LjACIs2QTEZTfukFRb30GQyevcb7EREdVFxoNEgvHSk	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	44	1672308593015	1672308593066	@matterbot:localhost	f	master	82
38	$XhzyXIYIbI0BfDV1QY4H3b4Wrpy5pJgJsGNZc8P8seg	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	38	1672308593138	1672308593228	@matterbot:localhost	f	master	83
45	$EB67Xwo9B0__CxNTvptFIy4e4vG93cmEcHRWbiVSFJU	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	45	1672308593237	1672308593333	@matterbot:localhost	f	master	84
39	$85g2ma_sFrYS8UbhpRwYEglJLj7xswd8VgNCg787_3E	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	39	1672308593347	1672308593421	@mm_mattermost_b:localhost	f	master	85
46	$jL60Q94H_SC7S4ZFOWkA4RilDwTMIUci2DyEXyQS_t0	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	46	1672308593474	1672308593554	@mm_mattermost_b:localhost	f	master	86
40	$WPbDUZRE7W6o_O4D0qf40PxoXNWcHrBwx3LxCA_ILaY	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	40	1672308593568	1672308593608	@mm_mattermost_a:localhost	f	master	87
47	$sPW_-g3Oq09Bq8Rm-TKPTRO4HHOlMXEni0rE18Y01h4	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	47	1672308593684	1672308593751	@mm_mattermost_a:localhost	f	master	88
41	$QjDo1bVrVGh33tmezjIVWxT6VXLutgIWlP9outS8Gcg	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	41	1672312506179	1672312506208	@mm_mattermost_a:localhost	f	master	89
42	$j4OmrTBgGXlAg2ui751-jxTS4uMSPCzpj81xWRfOWiA	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	42	1672312535871	1672312535915	@mm_mattermost_a:localhost	f	master	90
43	$lQM-XkcgjA40yc1T7BNzbZ8V8yxcnsj23SxrixdEev8	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	43	1672312536151	1672312536183	@mm_mattermost_b:localhost	f	master	91
44	$XikqApD6-vTeGUebJl-_Bc9ButeowpABz5W37dejAy0	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	44	1672312536321	1672312536344	@mm_mattermost_a:localhost	f	master	92
48	$A5qbTNFuQ1MZL2fuT4oUFzi1xCHHDk0NuQZstoz4u-U	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	48	1672312690722	1672312690763	@matrix_a:localhost	f	master	93
51	$jhFoiytsqlLXRCkoL5gH2sXpQQJFwk3XLtzQPCpA0K8	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	51	1672312692993	1672312693044	@matrix_a:localhost	f	master	99
56	$0ClPrn0jv_hdCQB4TqbWVPUxxSqFeDViCsOjYwQVDAg	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	56	1672314819459	1672314819513	@matterbot:localhost	f	master	124
72	$kkmwTP1mOPGymh7Q3_N1Y7ftC1xrv5qaHbV_zi99vD4	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	72	1672314834658	1672314834685	@mm_mattermost_b:localhost	t	master	136
49	$kMqJ62yuvBi4RWfOiLMiPcoSKbfcjZvTwwiuRRmfEKA	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	49	1672312690858	1672312690893	@matrix_b:localhost	f	master	94
63	$SLqtTg1DQZU0Y4ezk90kDHz7IxD9TXjhW4qQAoPUfTk	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	63	1672314817388	1672314817512	@mm_mattermost_a:localhost	f	master	116
60	$mjUbm6eO9Jk-i6bqdyRHFZy9L-lH5TOO27GYMQ87nhs	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	60	1672314833256	1672314833346	@matrix_a:localhost	f	master	130
50	$2xt0-DVGoBAEL-GIwj9HZfHBCQu7_M-HzB2XaEfxjwM	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	50	1672312691040	1672312691182	@matrix_a:localhost	f	master	95
69	$ewJTQJq2XdLvkqYVULlUmmJ-A3LQ6Jnqs4GDYi6q0DE	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	69	1672314819789	1672314819866	@mm_mattermost_a:localhost	f	master	127
62	$kdWmWl1h_wHbp_4CZHM4AOF1I3SpjgbLYkYoFiWiazU	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	62	1672314833853	1672314833873	@matrix_b:localhost	f	master	132
45	$6CT_ZCazUgJysnWN-q2s4b5iR-x1EbXa932nBRpldW4	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	45	1672312691392	1672312691409	@mm_mattermost_a:localhost	f	master	96
52	$UQr1C3BZK9MztXbBR2a0yz0wCyXSy_abmCstrHnXi2E	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	52	1672312693241	1672312693272	@matrix_a:localhost	f	master	100
58	$56oOQ2hizWAJWWKoJTMYGwAKX_gaANdZg2QHgtC63ZE	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	58	1672314814937	1672314814991	@matrix_a:localhost	f	master	107
59	$6Sy4DU04a_WCzalQkimJ_l9-eYsJ3kcn3Lat9w42L2I	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	59	1672314815191	1672314815230	@matrix_a:localhost	f	master	108
60	$FC2J9PSIQLoF8YJo6zY2dP8Eo55L8CPgzVGN7iaofRo	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	60	1672314815441	1672314815493	@matrix_a:localhost	f	master	109
49	$WcPnOWvRmgShLlAe8RxY4-_M71l0auS5ykpKdmUS0LU	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	49	1672314815648	1672314815693	@matrix_a:localhost	f	master	110
61	$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	61	1672314816398	1672314816435	@matrix_a:localhost	f	master	112
55	$ZLuzCoh1UZ9oNHYyBNCtneq81TelpJ882dsDdio0oKU	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	55	1672314819213	1672314819289	@matterbot:localhost	f	master	122
68	$Zv-9wNEnjnF-VeZtZKtHkYObGhccwLKewNnJg-fUiF8	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	68	1672314819642	1672314819690	@mm_mattermost_b:localhost	f	master	125
73	$53rDO0S-X2QNPUyUVrTGx092yf0EW0nvJXQNLgQ09kc	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	73	1672314835302	1672314835337	@matrix_a:localhost	f	master	138
46	$UD0jEJtVKXhlCRf7VxHITWSUyhzaGkpH0VGbwilf2RE	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	46	1672312691855	1672312691937	@matrix_b:localhost	f	master	97
50	$-R5ZDLwPtIisO-W746dPRRrr1U6HjM8uhC78Zh95UUQ	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	50	1672314815909	1672314815945	@matrix_a:localhost	f	master	111
51	$19Wa_uoHXFwHicMPIWHRa1c8H1yIjgzKxpDzo89CTTE	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	51	1672314817098	1672314817175	@mm_mattermost_a:localhost	f	master	114
54	$Qyk1jqM8wu6uOaEDEalSs_0hepeq6CnfZZRy1hQ4sd8	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	54	1672314818348	1672314818436	@matterbot:localhost	f	master	120
66	$qgyz1sVriFBiepR7YLOpA_tcnRjhDX9q13fkeJa8i3U	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	66	1672314819175	1672314819277	@matterbot:localhost	f	master	121
61	$j_Vf4RSpugcR52JQthWyGuqRIEdGrETb4ZLvnGxwwg0	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	61	1672314833650	1672314833672	@mm_mattermost_a:localhost	f	master	131
71	$iVV3o47Y40f29uNsCktD5R1VKbTF1y3nGq4KSKQ5YYo	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	71	1672314834507	1672314834537	@mm_mattermost_b:localhost	f	master	135
47	$BMnLymfijfp2V1tH1M6Nayfx-iF_rRw70COW60dCBG0	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	47	1672312692473	1672312692557	@mm_mattermost_a:localhost	f	master	98
54	$p2y4ivsQApKJEQKZQ-5KFk47veZlq7V00tHHrokVqK0	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	54	1672312693607	1672312693691	@matrix_a:localhost	f	master	102
48	$VzxEyd-riDbZr-sdhUSEcA4h_6kWYfmSeoqEtaZHFFo	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	48	1672312696316	1672312696339	@mm_mattermost_a:localhost	f	master	103
55	$BtKmdXlHyT65KPvPIiDSk38oldbOKOUbuv7J13Up4wE	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	55	1672314814370	1672314814425	@mm_mattermost_a:localhost	f	master	104
56	$HVWinlm6AKNeOld7iV_yqdfmpznmG5wAyWK5k3xjM7Y	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	56	1672314814639	1672314814683	@matterbot:localhost	f	master	105
57	$aa2-bg9KcCtrn4nE5HK1JGC6sa8Gr7jWqLhPgLQTtsU	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	57	1672314819666	1672314819709	@mm_mattermost_b:localhost	f	master	126
64	$99PDED6qRD6JvJgyuUpKL5SGciNeDx4Q8aNU8-knIfI	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	64	1672314835018	1672314835049	@matrix_a:localhost	t	master	137
53	$wehc8FMA82xW0EU5F86ZkvsBra_SZ0JSA3Yweowv_s8	m.room.redaction	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	53	1672312693355	1672312693436	@matrix_a:localhost	f	master	101
58	$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	58	1672314819878	1672314819948	@mm_mattermost_a:localhost	f	master	128
63	$sD72WUGTkmqfbvA4mcCNx5IcT-WfbmjsGalYB6V6S-E	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	63	1672314834257	1672314834280	@matrix_a:localhost	f	master	134
57	$FNOekiMLFE4AEgQ1st7kiouCRAYO3DKEMbrYHGbH-zw	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	57	1672314814778	1672314814820	@mm_mattermost_a:localhost	f	master	106
53	$6ZYuUr8K6uh0D7tl9-HD___6hQH3lj8qU1liF0zAkmo	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	53	1672314817648	1672314817730	@matterbot:localhost	f	master	117
62	$M2xNoGVeTRazjk5EjiA0u3mOkneK7za9KWYn2LMJFwA	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	62	1672314817085	1672314817171	@mm_mattermost_b:localhost	f	master	113
67	$ggRHO4QwGg8SLwSXlSNnHypSBsgj2jFMUXbjC7U97qM	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	67	1672314819392	1672314819491	@matterbot:localhost	f	master	123
59	$m8QuIxNBjngQA1UhDPZlw6nIvodE764mdmYG9oCKf94	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	59	1672314829737	1672314829755	@mm_mattermost_a:localhost	f	master	129
70	$RuT3uWLcY4y4GhqYFFNXur6XuNwXipRRmx5rJFfM9ms	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	70	1672314834068	1672314834091	@mm_mattermost_a:localhost	f	master	133
52	$lDJnxY-YfTRyXQcBLRlbFT2_w4DXO4Pks75YGGa5M5o	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	52	1672314817354	1672314817507	@mm_mattermost_b:localhost	f	master	115
64	$t_tUn4wROpupdwEmZnXWQ-mtnx68XnGjofi61K92cRY	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	64	1672314817658	1672314817737	@matterbot:localhost	f	master	118
65	$JgtV2Jrt_3Cws_oeqEte6xeUnTbTSMu0pBPrEWD4WyM	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	65	1672314818343	1672314818436	@matterbot:localhost	f	master	119
65	$OL5YFZuIzpeGWvQkJsWD5fA-_tqvM6MNM8aACLhDIKc	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	65	1672314857885	1672314857937	@mm_mattermost_a:localhost	f	master	139
66	$WxOx5K9OBtSH4SKkxlQDUCVkiuA8mdui6eTN417KUig	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	66	1672314858127	1672314858164	@mm_mattermost_b:localhost	f	master	140
67	$9eV_AyLXyN9dQJyo8nKzxH0MD2Pj26OD3m5hxM368ek	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	67	1672314858312	1672314858343	@mm_mattermost_a:localhost	f	master	141
74	$KAudDRl-ilYkXdKdFFwSH1rjB9FuDL3iaIcj9chsvuc	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	74	1672314858527	1672314858561	@matrix_a:localhost	f	master	142
75	$NBW9KofbXfyJlflrssj5f0gU9-vix_ChkMTdCTutt6E	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	75	1672314858660	1672314858710	@matrix_b:localhost	f	master	143
76	$G4jqJ_vLOuComzEY5LKlWgJmqk76rEv2BaFnoUc32C4	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	76	1672314858772	1672314858864	@matrix_a:localhost	f	master	144
68	$PmdsaAuptefoxepoi5dH3S5XZjMQnrw_IY8E3iiC0JI	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	68	1672314859079	1672314859111	@mm_mattermost_a:localhost	f	master	145
69	$LLxGQgsj2x835E7aJtEtKuPEzf1fHJTT_1b0cxZaynk	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	69	1672314859309	1672314859332	@matrix_b:localhost	f	master	146
70	$xaKVxYK5Ka0brhbVcFdQdutgxYlZom-dUIRWmloBBms	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	70	1672314859555	1672314859580	@mm_mattermost_a:localhost	f	master	147
77	$7IBjUUbkm6m5Y_DazT_SUW3_XBAwV0nvHP6nkPuBbV0	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	77	1672314859803	1672314859833	@matrix_a:localhost	f	master	148
78	$iZZsHDRKa9MPh0wKPGoTIkR9_IN1gXmgYQ3CLA-oEsU	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	78	1672314859926	1672314859975	@matrix_a:localhost	f	master	149
79	$OxJtFsDfjfHJ57HdnctrwwYfeMAuGw-MFWayc0MqGW4	m.room.redaction	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	79	1672314860034	1672314860102	@matrix_a:localhost	f	master	150
80	$OIgyn6WfwavdRqCIV587JtVG-UzMqFnY1_VC_N2O6ok	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	80	1672314860182	1672314860273	@matrix_a:localhost	f	master	151
71	$z-yABBMUu-RFJeiOLWwmWghP2O4vgO3Bts6c9FX-uG8	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	71	1672314861926	1672314861941	@mm_mattermost_a:localhost	f	master	152
72	$P2eP-7teBmGXcBM7DqUedLeBNdY5eaTasFqCr7GXY74	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	72	1672315004592	1672315004695	@mm_mattermost_a:localhost	f	master	153
73	$62DK_5Urc-R1gCm6T-D7rEFWp3Q47rECTaNApSOe0tg	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	73	1672315005001	1672315005039	@mm_mattermost_b:localhost	f	master	154
74	$reo6-sRCAReTplLLrWZiUXEMMfaufd1o-PclhKbhxXw	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	74	1672315005201	1672315005235	@mm_mattermost_a:localhost	f	master	155
81	$LiUaGyMC-ZVhJFLD9EeZsUNlhdIzJ2J41q-tpdMYQ-g	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	81	1672315005582	1672315005623	@matrix_a:localhost	f	master	156
82	$kGXjbDILpzPlAVquVm-0ro1Y2cAjvBSU3chLQmB-ZgI	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	82	1672315005779	1672315005843	@matrix_b:localhost	f	master	157
83	$iR6CRvH8xG5VgeMQIZFMBeaVeTjxgDtnqT7tv-PoCf8	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	83	1672315005925	1672315006028	@matrix_a:localhost	f	master	158
75	$47BkoMnB5FT3PSdXLEy0rb4ZdbS1q9w82a669O4lBXg	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	75	1672315006320	1672315006347	@mm_mattermost_a:localhost	f	master	159
76	$zI1CZE-pX4aF7RBiJiZqzqFZlxIfJRBpmSuBjEzHTCQ	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	76	1672315006535	1672315006559	@matrix_b:localhost	f	master	160
77	$y7fmz8cz_zrBS0ZmRnthufiCH3PFkuCVz8YKzQaf81g	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	77	1672315006795	1672315006824	@mm_mattermost_a:localhost	f	master	161
84	$mJ65YIJRPOxuW2mcyV5dt1MwIY7iWY76Fnj51047dZM	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	84	1672315007015	1672315007047	@matrix_a:localhost	f	master	162
85	$p7GJemyaMZGUqYX0guKHUqmObfwF2yChmhI7v1sn2nE	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	85	1672315007130	1672315007202	@matrix_a:localhost	f	master	163
86	$Ky-_xzOrnEPuDm0WQev0E1urDcDHtvv8esKT3jQ6lFY	m.room.redaction	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	86	1672315007272	1672315007355	@matrix_a:localhost	f	master	164
87	$5Iq2ZU88BXgNKKqMGOu71dH7vsyaxwI-Fxg8ocEMI2E	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	87	1672315007420	1672315007479	@matrix_a:localhost	f	master	165
78	$LHW3l0dgme8yNUY6xjIvP_Osal1_vZAuIfg7vCLzGKI	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	78	1672315009057	1672315009093	@mm_mattermost_a:localhost	f	master	166
79	$_XRh5iYtBtMSC8b9sq-Zq1kS1LqI6azDTXLEGQTiQSs	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	79	1672317654041	1672317654094	@mm_mattermost_a:localhost	f	master	167
80	$jgIb5yphKm1y65Shpo1bZF38fQ0ZqUjOopYEMjB2JS0	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	80	1672317654290	1672317654324	@mm_mattermost_b:localhost	f	master	168
81	$j96SJY0VtGl6Q_Fnj_jg3BifdW7s0-Vd8t57DrAeAX8	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	81	1672317654478	1672317654511	@mm_mattermost_a:localhost	f	master	169
88	$5-UBR4vNvgnHcUIuQA0gIHJmn4pOL-BNEZ33B-2Dmes	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	88	1672317654712	1672317654740	@matrix_a:localhost	f	master	170
89	$8f7euYUQUOKVs1LECS5C0ny-iJc0LrEhKy5AjaE9VwM	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	89	1672317654827	1672317654908	@matrix_b:localhost	f	master	171
90	$n7rEuNOUTfPAb-nKtA8sQLtp0FZoDqOfMyqN9eKVULc	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	90	1672317655010	1672317655069	@matrix_a:localhost	f	master	172
82	$KdF0e2L1V2qamNtPDDdbE1nZ8xvaqEBCeH0VcCCosQ8	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	82	1672317655291	1672317655316	@mm_mattermost_a:localhost	f	master	173
83	$VGPWrlgPM0aSEOjGq1_ygJ2gwcjdfMl06P2yF-1EjMw	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	83	1672317655501	1672317655542	@matrix_b:localhost	f	master	174
84	$T-S0-0A2-tysbZGnQHyOgfmxVouK-Ise06pRgQbLLcg	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	84	1672317655810	1672317655833	@mm_mattermost_a:localhost	f	master	175
92	$8Hjay0ed9n_Y3vv-Lhtc_-A0-5CvZe8YsPugJA7pwVg	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	92	1672317656117	1672317656229	@matrix_a:localhost	f	master	177
93	$NHchZjGDozZxBeE_hBCfcWNQSoGcpRSxMwGAV4CVzWU	m.room.redaction	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	93	1672317656469	1672317656530	@matrix_a:localhost	f	master	178
88	$VZnQHRUET5azOmfmvUZMF1_eEKzi1_WkVHB0pxMELxo	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	88	1672317897801	1672317897834	@mm_mattermost_a:localhost	f	master	183
90	$LOcz4Bm15D4BsyuDXygSGL-0AvIjwSLYy4cezgebQK8	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	90	1672317898797	1672317898822	@matrix_b:localhost	f	master	188
91	$jTQQwpTqOMCeKxagSFuov0Dg8yBrYJJogGNCxBE1qwk	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	91	1672317656025	1672317656050	@matrix_a:localhost	f	master	176
85	$c-G9o6jTgFkz_rB_zESYfRkHoFMmTM5uCDXF1JAermc	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	85	1672317658319	1672317658353	@mm_mattermost_a:localhost	f	master	180
97	$dxD8VRi5x30Gu7BMEOui-JOrXZEL9meU6Q8aZra1b6U	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	97	1672317898341	1672317898391	@matrix_a:localhost	f	master	186
91	$RJSqE0ZymidM-ZtkpYLdrShv6_yNohaw5QtWzVooGsk	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	91	1672317899053	1672317899079	@mm_mattermost_a:localhost	f	master	189
94	$5G3tHkgsc39AkOi94e7gxCeKaPhkmyOOAZlGWI8YaCQ	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	94	1672317656609	1672317656677	@matrix_a:localhost	f	master	179
86	$eY9D8MVKC5bDdinpPVI9ooLWvoYHx0tLFn-vRWkp9nk	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	86	1672317897360	1672317897412	@mm_mattermost_a:localhost	f	master	181
100	$xKmd10QHFv5EgHAyd9HpWHkEi2QTI9MhKVlqpVntWM8	m.room.redaction	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	100	1672317899602	1672317899635	@matrix_a:localhost	f	master	192
101	$gLYRtP_fFTIbdUQ6jtldLcUG60gMNlghw7x9t2_PurE	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	101	1672317899688	1672317899763	@matrix_a:localhost	f	master	193
87	$AAj21zp54kdoP3h1Zql3vB7JlPNE4Y9HrXrzBQPQrTA	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	87	1672317897621	1672317897655	@mm_mattermost_b:localhost	f	master	182
89	$bXKGeqgVWpdObwAv0HPtsV7_MNqo8HhD_whsZ1gxx54	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	89	1672317898605	1672317898628	@mm_mattermost_a:localhost	f	master	187
98	$EdC99i51IXAQXh-JndOybB0EFIdpgm02s0Z6Takw4Jw	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	98	1672317899297	1672317899321	@matrix_a:localhost	f	master	190
95	$7q-JkspgsFYptPnMJ25LHdffz-rXLRDHzidSYCV3Kc8	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	95	1672317898031	1672317898054	@matrix_a:localhost	f	master	184
99	$pp-1vh-obnf3bLKs4cnpwy9dbINdz1MGiUDLrdenfek	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	99	1672317899445	1672317899486	@matrix_a:localhost	f	master	191
92	$AbcQJxS0qvSibn6R_hm5OSrLKkHjrpsW8oo97om40r8	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	92	1672317901740	1672317901765	@mm_mattermost_a:localhost	f	master	194
96	$dtGyXiOFORXfCA1yAgiPJbV5UKJjEo-zfetInljHoV0	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	96	1672317898206	1672317898232	@matrix_b:localhost	f	master	185
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
events	194	master
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
!kmbTYjjsDRDHGgVqUP:localhost	@matrix_b:localhost	$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk	join
!dKcbdDATuwwphjRPQP:localhost	@matrix_b:localhost	$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0	join
!kmbTYjjsDRDHGgVqUP:localhost	@ignored_user:localhost	$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	join
!dKcbdDATuwwphjRPQP:localhost	@ignored_user:localhost	$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A	join
!kmbTYjjsDRDHGgVqUP:localhost	@matrix_a:localhost	$-R5ZDLwPtIisO-W746dPRRrr1U6HjM8uhC78Zh95UUQ	join
!dKcbdDATuwwphjRPQP:localhost	@matrix_a:localhost	$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E	join
!dKcbdDATuwwphjRPQP:localhost	@matterbot:localhost	$JgtV2Jrt_3Cws_oeqEte6xeUnTbTSMu0pBPrEWD4WyM	join
!kmbTYjjsDRDHGgVqUP:localhost	@matterbot:localhost	$Qyk1jqM8wu6uOaEDEalSs_0hepeq6CnfZZRy1hQ4sd8	join
!dKcbdDATuwwphjRPQP:localhost	@mm_mattermost_b:localhost	$Zv-9wNEnjnF-VeZtZKtHkYObGhccwLKewNnJg-fUiF8	join
!kmbTYjjsDRDHGgVqUP:localhost	@mm_mattermost_b:localhost	$aa2-bg9KcCtrn4nE5HK1JGC6sa8Gr7jWqLhPgLQTtsU	join
!dKcbdDATuwwphjRPQP:localhost	@mm_mattermost_a:localhost	$ewJTQJq2XdLvkqYVULlUmmJ-A3LQ6Jnqs4GDYi6q0DE	join
!kmbTYjjsDRDHGgVqUP:localhost	@mm_mattermost_a:localhost	$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo	join
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
fWhfcdaRNpxsjrhOUkKqnmdY	text/plain	8	1672306063108	mydata	@matrix_a:localhost	\N	\N	1672306093550	f
HDyXgvaVtVojxpAOhDMJKTum	application/octet-stream	11	1672306062872	filename	@mm_mattermost_b:localhost	\N	\N	1672306093550	f
EEnSOhlMqCJzCjOgkbSaZLSQ	application/octet-stream	11	1672314834609	filename	@mm_mattermost_b:localhost	\N	\N	1672314853550	f
hPLBTbnUBGBfWfltvwMyRdqa	text/plain	8	1672314834959	mydata	@matrix_a:localhost	\N	\N	1672314853550	f
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
60	@mm_mattermost_b:localhost	offline	1672317897678	1672317897678	0	\N	f	master
64	@matrix_b:localhost	offline	1672317898850	1672317898248	0	\N	f	master
65	@mm_mattermost_a:localhost	offline	1672317901813	1672317897443	0	\N	f	master
66	@matrix_a:localhost	offline	1672317899803	1672317898085	0	\N	f	master
68	@admin:localhost	offline	1672317901884	1672317932449	1672317901941	\N	t	master
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.profiles (user_id, displayname, avatar_url) FROM stdin;
admin	Admin User	\N
matrix_a	Matrix UserA	\N
matrix_b	matrix_b	\N
ignored_user	ignored_user	\N
bridgedemo1	bridgedemo1	\N
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
$wehc8FMA82xW0EU5F86ZkvsBra_SZ0JSA3Yweowv_s8	$jhFoiytsqlLXRCkoL5gH2sXpQQJFwk3XLtzQPCpA0K8	f	1672312693455
$OxJtFsDfjfHJ57HdnctrwwYfeMAuGw-MFWayc0MqGW4	$7IBjUUbkm6m5Y_DazT_SUW3_XBAwV0nvHP6nkPuBbV0	f	1672314860127
$Ky-_xzOrnEPuDm0WQev0E1urDcDHtvv8esKT3jQ6lFY	$mJ65YIJRPOxuW2mcyV5dt1MwIY7iWY76Fnj51047dZM	f	1672315007366
$NHchZjGDozZxBeE_hBCfcWNQSoGcpRSxMwGAV4CVzWU	$jTQQwpTqOMCeKxagSFuov0Dg8yBrYJJogGNCxBE1qwk	f	1672317656544
$xKmd10QHFv5EgHAyd9HpWHkEi2QTI9MhKVlqpVntWM8	$EdC99i51IXAQXh-JndOybB0EFIdpgm02s0Z6Takw4Jw	f	1672317899649
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
$oPNBx-eTHzyLXPzpYpdxdhLdVeGmx5lNmrECxIazfPQ	@matterbot:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	Mattermost Bridge	\N
$3pZnE6ITQzzyNsuVCenuFBVRMocr892PiAvIbMGbMBM	@matterbot:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	Mattermost Bridge	\N
$Oqb-EaDS-8U6U1Z6bTGSE7FJIlxKGhzMkNsnYIJY0Y0	@mm_mattermost_a:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	invite	0	MattermostUser A [mm]	\N
$hJeKBcpebJzm9oiwjDCNTWPtbEcfp9GOLXl3yGkyaFU	@mm_mattermost_a:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	invite	0	MattermostUser A [mm]	\N
$9cACT8rCcbUXbMhABzEciyF9pIIDRFNzaBkRVPH_0mk	@mm_mattermost_b:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	invite	0	mattermost_b [mm]	\N
$0gxNuNkWyOeHPtnNZ92FzvprItMgnH9hLCbYuY0Vzos	@mm_mattermost_b:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	invite	0	mattermost_b [mm]	\N
$9ArTh8Z2w2oc68FOD1X8Ka3DlK7lq00HaHKT_4DMSY4	@mm_mattermost_a:localhost	@mm_mattermost_a:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	MattermostUser A [mm]	\N
$V_uchZ_8H2oh6EdsXqKsT6Ri62_YZtAAMfZi8pbBGrc	@mm_mattermost_a:localhost	@mm_mattermost_a:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	MattermostUser A [mm]	\N
$Q4TOA6SPu2kQIrypB8QEJLHphxV5mHZ_eFwQux4jWSY	@mm_mattermost_b:localhost	@mm_mattermost_b:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	mattermost_b [mm]	\N
$YwLlyzcAMpJ69jsxTNglcWTbK8XHK8huc6aB6jpgEWk	@mm_mattermost_b:localhost	@mm_mattermost_b:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	mattermost_b [mm]	\N
$irHFClZVEAzlAtsjct-1MJjEotldPu1Ozkm_NYQrtqI	@mm_mattermost_a:localhost	@mm_mattermost_a:localhost	!dKcbdDATuwwphjRPQP:localhost	leave	0	\N	\N
$QwAobZq6xey4D-6yOm_xg4h6rCKIRUpTqM4HBNroJwE	@mm_mattermost_a:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	invite	0	MattermostUser A [mm]	\N
$3xEI-iU3Teo4B51pXGBbjKxM_DDvYlASNK7W09pHncM	@mm_mattermost_a:localhost	@mm_mattermost_a:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	MattermostUser A [mm]	\N
$ETv-B1S-bU8wgS3S1fDdineVdS9YGNq1EMeUPHb6imQ	@matrix_a:localhost	@matrix_a:localhost	!dKcbdDATuwwphjRPQP:localhost	leave	0	\N	\N
$GMh4hFLoeDc1Ssk9kdi7yAMIMSZA9zOJYJMC1AJEOKs	@matrix_a:localhost	@matrix_a:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	Matrix UserA	\N
$zMfjO64yH55JKcwd-hMCa1P1ARHyAuvBbnPeUiNnS48	@matrix_a:localhost	@matrix_a:localhost	!dKcbdDATuwwphjRPQP:localhost	leave	0	\N	\N
$5-KkKYPCr68IjD4sKk3rDF6kVYVkDMllW0BFUv7G4Do	@matrix_a:localhost	@matrix_a:localhost	!kmbTYjjsDRDHGgVqUP:localhost	leave	0	\N	\N
$sPO_9Od1FvK55Z9_vb0hx3ophiGuLyATo1RKYIEFxHc	@matrix_a:localhost	@matrix_a:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	Matrix UserA	\N
$oXLyUPbqiXmRRNovjt9_FJFQLCzMQjPsaism-trtsDw	@matrix_a:localhost	@matrix_a:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	Matrix UserA	\N
$7EOMmT1sBVcDB2udDBhhf11Mok_GC9CY-6bxtIKAYpc	@mm_mattermost_b:localhost	@mm_mattermost_b:localhost	!dKcbdDATuwwphjRPQP:localhost	leave	0	\N	\N
$-J2tr3j7vfmJ8ZSBAK5AyvQYmP2Byp-7dKfcBg5xHjU	@mm_mattermost_a:localhost	@mm_mattermost_a:localhost	!kmbTYjjsDRDHGgVqUP:localhost	leave	0	\N	\N
$o0wI9-m-SdyS4UK7_m9_MUd0luWmj6eoXfMg1ieT00g	@mm_mattermost_a:localhost	@mm_mattermost_a:localhost	!dKcbdDATuwwphjRPQP:localhost	leave	0	\N	\N
$wEwGnOPXUgG2_4DpqsPrYbSlIM2TnPjdWNDyVbZNE2Y	@mm_mattermost_b:localhost	@mm_mattermost_b:localhost	!kmbTYjjsDRDHGgVqUP:localhost	leave	0	\N	\N
$oZEGsAxUrYn8R6NS359wZO9T54eXOD-N88ftDK7ZHGU	@matterbot:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	leave	0	\N	\N
$LN4aYSSVw4GLaWf8g7uzrsw-fHTUyCBwq_-RRgS-MGE	@matterbot:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	leave	0	\N	\N
$sY34u-PbOKSI3_z8SIqGfn_2XnO9wqZ_eU1dvGDnRJY	@matterbot:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	Mattermost Bridge	\N
$zhfRuogjo-Vq5GM4-f6hyuXBGHx99o9_Nef1KWi2-EM	@matterbot:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	Mattermost Bridge	\N
$3A5iUMUsDMAckTZ_lQ9ZLyQdw7FKGrqWfMMxwAZJCwc	@mm_mattermost_b:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	invite	0	mattermost_b [mm]	\N
$aUCd2uzLS80uiu1DeYrTDp1wAWs7M1ba_4Srm8LLnmU	@mm_mattermost_a:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	invite	0	MattermostUser A [mm]	\N
$zogqtnD68sbYTleQBUL-RkGDpkNmTHar6ilm_2oVnRs	@mm_mattermost_a:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	invite	0	MattermostUser A [mm]	\N
$OcjvTopfs1z8zuVgRxn4ynq9LH7z4eQhJnWG0PQ7150	@mm_mattermost_b:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	invite	0	mattermost_b [mm]	\N
$GcBRlllGdKFvT1pDzY7airMfjuYYNt06vxkQ0BnM6IM	@mm_mattermost_b:localhost	@mm_mattermost_b:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	mattermost_b [mm]	\N
$JtjXz-jm6mi5wU33MudkV8ZsCM2V-zduDqeI1xIG254	@mm_mattermost_a:localhost	@mm_mattermost_a:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	MattermostUser A [mm]	\N
$6cga7PdI_98v2MEH6Wosfik3Plxt3Ml7GwsUkSFFa00	@mm_mattermost_a:localhost	@mm_mattermost_a:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	MattermostUser A [mm]	\N
$0BYuX-7BWlMOYXwWp-y_txKwBBorVZzavW6fDuXxUrM	@mm_mattermost_b:localhost	@mm_mattermost_b:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	mattermost_b [mm]	\N
$OOCwtQCB-nmnnlgQ3ST3ItcIsITOLkC3b4a-WpaJjRg	@mm_mattermost_a:localhost	@mm_mattermost_a:localhost	!dKcbdDATuwwphjRPQP:localhost	leave	0	\N	\N
$0ruVoUZRE1Edh-f7Z0QopPRTCr7L2kEpX8unxgxmfSQ	@mm_mattermost_a:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	invite	0	MattermostUser A [mm]	\N
$OJhJIVnJWjcgl3gc2AqLQK7sy1tKn075fy4E5qUK014	@matrix_a:localhost	@matrix_a:localhost	!dKcbdDATuwwphjRPQP:localhost	leave	0	\N	\N
$hWVSd4FzjwQq7FYDdhFSCgpisb3gxDJ2OAjCjYS6rkg	@mm_mattermost_a:localhost	@mm_mattermost_a:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	MattermostUser A [mm]	\N
$ShuNV5AOx3oTjKr3eYjFKvzCZ374R_0vxs2HC21ht-g	@mm_mattermost_b:localhost	@mm_mattermost_b:localhost	!dKcbdDATuwwphjRPQP:localhost	leave	0	\N	\N
$nsJ2oe7ZtdBtY0V-sJWzGBBDi7tcgH24zUaAdmLjXy4	@matrix_a:localhost	@matrix_a:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	Matrix UserA	\N
$IfK4xyQ_h94nUHneDilGoM0TTwuWFeP5_u_nlRs571U	@mm_mattermost_a:localhost	@mm_mattermost_a:localhost	!dKcbdDATuwwphjRPQP:localhost	leave	0	\N	\N
$LjACIs2QTEZTfukFRb30GQyevcb7EREdVFxoNEgvHSk	@mm_mattermost_b:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	invite	0	mattermost_b [mm]	\N
$jL60Q94H_SC7S4ZFOWkA4RilDwTMIUci2DyEXyQS_t0	@mm_mattermost_b:localhost	@mm_mattermost_b:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	mattermost_b [mm]	\N
$XYKCYavbY8FMdUIlSSoqP0likUnTP6uJ0yHoGQCMnWQ	@matrix_a:localhost	@matrix_a:localhost	!dKcbdDATuwwphjRPQP:localhost	leave	0	\N	\N
$aaPR9QI7az6NxeJ0hSrQxyKzzVyM-rBWODbN9y9rM9Q	@matterbot:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	leave	0	\N	\N
$2-SFwejONuAnI3cUJ4UN3FSzzJjeIWUURtWOJiO2sWo	@matterbot:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	Mattermost Bridge	\N
$sPW_-g3Oq09Bq8Rm-TKPTRO4HHOlMXEni0rE18Y01h4	@mm_mattermost_a:localhost	@mm_mattermost_a:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	MattermostUser A [mm]	\N
$fc-Paa3ZBQU-GAAxH4QWDNrWblQvQ4ddYVzPTPiYV6U	@matrix_a:localhost	@matrix_a:localhost	!kmbTYjjsDRDHGgVqUP:localhost	leave	0	\N	\N
$WPbDUZRE7W6o_O4D0qf40PxoXNWcHrBwx3LxCA_ILaY	@mm_mattermost_a:localhost	@mm_mattermost_a:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	MattermostUser A [mm]	\N
$4KgY7ivi_pp1q2tjdk7IWENjs1kzgSRLB29nKbq-UXw	@matrix_a:localhost	@matrix_a:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	Matrix UserA	\N
$UTOQTSrmXya3IQYDcRPwNWN1bIv2zQ3YfbaVRy9NQuA	@mm_mattermost_b:localhost	@mm_mattermost_b:localhost	!kmbTYjjsDRDHGgVqUP:localhost	leave	0	\N	\N
$EB67Xwo9B0__CxNTvptFIy4e4vG93cmEcHRWbiVSFJU	@mm_mattermost_a:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	invite	0	MattermostUser A [mm]	\N
$85g2ma_sFrYS8UbhpRwYEglJLj7xswd8VgNCg787_3E	@mm_mattermost_b:localhost	@mm_mattermost_b:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	mattermost_b [mm]	\N
$0EmcDbHM6t0AJ7YKAcphqL8othdZg4dIXSazEHvnCno	@matrix_a:localhost	@matrix_a:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	Matrix UserA	\N
$72MNMNMOJMJpfLbdNKdm6ZXGr14ukIKdq-fG2OvzOqg	@mm_mattermost_b:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	invite	0	mattermost_b [mm]	\N
$EklY0FV28pDgoXqwoQUjAB5wTv33O8RCHRE8k2k6o2c	@mm_mattermost_a:localhost	@mm_mattermost_a:localhost	!kmbTYjjsDRDHGgVqUP:localhost	leave	0	\N	\N
$sbDgkkxT05mw8xIVFWyOJtbW9nnehE06Wvxor1z8ms8	@matterbot:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	leave	0	\N	\N
$TbzKCcECXvJAKvBu5GZCTLIGi7Js0b1w9dE6KKZXaKo	@matterbot:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	Mattermost Bridge	\N
$XhzyXIYIbI0BfDV1QY4H3b4Wrpy5pJgJsGNZc8P8seg	@mm_mattermost_a:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	invite	0	MattermostUser A [mm]	\N
$BtKmdXlHyT65KPvPIiDSk38oldbOKOUbuv7J13Up4wE	@mm_mattermost_a:localhost	@mm_mattermost_a:localhost	!dKcbdDATuwwphjRPQP:localhost	leave	0	\N	\N
$HVWinlm6AKNeOld7iV_yqdfmpznmG5wAyWK5k3xjM7Y	@mm_mattermost_a:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	invite	0	MattermostUser A [mm]	\N
$FNOekiMLFE4AEgQ1st7kiouCRAYO3DKEMbrYHGbH-zw	@mm_mattermost_a:localhost	@mm_mattermost_a:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	MattermostUser A [mm]	\N
$56oOQ2hizWAJWWKoJTMYGwAKX_gaANdZg2QHgtC63ZE	@matrix_a:localhost	@matrix_a:localhost	!dKcbdDATuwwphjRPQP:localhost	leave	0	\N	\N
$6Sy4DU04a_WCzalQkimJ_l9-eYsJ3kcn3Lat9w42L2I	@matrix_a:localhost	@matrix_a:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	Matrix UserA	\N
$FC2J9PSIQLoF8YJo6zY2dP8Eo55L8CPgzVGN7iaofRo	@matrix_a:localhost	@matrix_a:localhost	!dKcbdDATuwwphjRPQP:localhost	leave	0	\N	\N
$WcPnOWvRmgShLlAe8RxY4-_M71l0auS5ykpKdmUS0LU	@matrix_a:localhost	@matrix_a:localhost	!kmbTYjjsDRDHGgVqUP:localhost	leave	0	\N	\N
$-R5ZDLwPtIisO-W746dPRRrr1U6HjM8uhC78Zh95UUQ	@matrix_a:localhost	@matrix_a:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	Matrix UserA	\N
$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E	@matrix_a:localhost	@matrix_a:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	Matrix UserA	\N
$19Wa_uoHXFwHicMPIWHRa1c8H1yIjgzKxpDzo89CTTE	@mm_mattermost_a:localhost	@mm_mattermost_a:localhost	!kmbTYjjsDRDHGgVqUP:localhost	leave	0	\N	\N
$M2xNoGVeTRazjk5EjiA0u3mOkneK7za9KWYn2LMJFwA	@mm_mattermost_b:localhost	@mm_mattermost_b:localhost	!dKcbdDATuwwphjRPQP:localhost	leave	0	\N	\N
$lDJnxY-YfTRyXQcBLRlbFT2_w4DXO4Pks75YGGa5M5o	@mm_mattermost_b:localhost	@mm_mattermost_b:localhost	!kmbTYjjsDRDHGgVqUP:localhost	leave	0	\N	\N
$SLqtTg1DQZU0Y4ezk90kDHz7IxD9TXjhW4qQAoPUfTk	@mm_mattermost_a:localhost	@mm_mattermost_a:localhost	!dKcbdDATuwwphjRPQP:localhost	leave	0	\N	\N
$6ZYuUr8K6uh0D7tl9-HD___6hQH3lj8qU1liF0zAkmo	@matterbot:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	leave	0	\N	\N
$t_tUn4wROpupdwEmZnXWQ-mtnx68XnGjofi61K92cRY	@matterbot:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	leave	0	\N	\N
$JgtV2Jrt_3Cws_oeqEte6xeUnTbTSMu0pBPrEWD4WyM	@matterbot:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	Mattermost Bridge	\N
$Qyk1jqM8wu6uOaEDEalSs_0hepeq6CnfZZRy1hQ4sd8	@matterbot:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	Mattermost Bridge	\N
$qgyz1sVriFBiepR7YLOpA_tcnRjhDX9q13fkeJa8i3U	@mm_mattermost_b:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	invite	0	mattermost_b [mm]	\N
$ZLuzCoh1UZ9oNHYyBNCtneq81TelpJ882dsDdio0oKU	@mm_mattermost_b:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	invite	0	mattermost_b [mm]	\N
$ggRHO4QwGg8SLwSXlSNnHypSBsgj2jFMUXbjC7U97qM	@mm_mattermost_a:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	invite	0	MattermostUser A [mm]	\N
$0ClPrn0jv_hdCQB4TqbWVPUxxSqFeDViCsOjYwQVDAg	@mm_mattermost_a:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	invite	0	MattermostUser A [mm]	\N
$Zv-9wNEnjnF-VeZtZKtHkYObGhccwLKewNnJg-fUiF8	@mm_mattermost_b:localhost	@mm_mattermost_b:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	mattermost_b [mm]	\N
$aa2-bg9KcCtrn4nE5HK1JGC6sa8Gr7jWqLhPgLQTtsU	@mm_mattermost_b:localhost	@mm_mattermost_b:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	mattermost_b [mm]	\N
$ewJTQJq2XdLvkqYVULlUmmJ-A3LQ6Jnqs4GDYi6q0DE	@mm_mattermost_a:localhost	@mm_mattermost_a:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	MattermostUser A [mm]	\N
$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo	@mm_mattermost_a:localhost	@mm_mattermost_a:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	MattermostUser A [mm]	\N
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
!dKcbdDATuwwphjRPQP:localhost	12	7	0	0	0	7	127	0
!kmbTYjjsDRDHGgVqUP:localhost	12	7	0	0	0	7	128	0
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
$oPNBx-eTHzyLXPzpYpdxdhLdVeGmx5lNmrECxIazfPQ	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	\N
$3pZnE6ITQzzyNsuVCenuFBVRMocr892PiAvIbMGbMBM	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	\N
$Oqb-EaDS-8U6U1Z6bTGSE7FJIlxKGhzMkNsnYIJY0Y0	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$hJeKBcpebJzm9oiwjDCNTWPtbEcfp9GOLXl3yGkyaFU	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$9cACT8rCcbUXbMhABzEciyF9pIIDRFNzaBkRVPH_0mk	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$0gxNuNkWyOeHPtnNZ92FzvprItMgnH9hLCbYuY0Vzos	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$9ArTh8Z2w2oc68FOD1X8Ka3DlK7lq00HaHKT_4DMSY4	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$V_uchZ_8H2oh6EdsXqKsT6Ri62_YZtAAMfZi8pbBGrc	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$Q4TOA6SPu2kQIrypB8QEJLHphxV5mHZ_eFwQux4jWSY	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$YwLlyzcAMpJ69jsxTNglcWTbK8XHK8huc6aB6jpgEWk	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$irHFClZVEAzlAtsjct-1MJjEotldPu1Ozkm_NYQrtqI	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$QwAobZq6xey4D-6yOm_xg4h6rCKIRUpTqM4HBNroJwE	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$3xEI-iU3Teo4B51pXGBbjKxM_DDvYlASNK7W09pHncM	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$ETv-B1S-bU8wgS3S1fDdineVdS9YGNq1EMeUPHb6imQ	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	\N
$GMh4hFLoeDc1Ssk9kdi7yAMIMSZA9zOJYJMC1AJEOKs	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	\N
$zMfjO64yH55JKcwd-hMCa1P1ARHyAuvBbnPeUiNnS48	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	\N
$5-KkKYPCr68IjD4sKk3rDF6kVYVkDMllW0BFUv7G4Do	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_a:localhost	\N
$sPO_9Od1FvK55Z9_vb0hx3ophiGuLyATo1RKYIEFxHc	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_a:localhost	\N
$oXLyUPbqiXmRRNovjt9_FJFQLCzMQjPsaism-trtsDw	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	\N
$7EOMmT1sBVcDB2udDBhhf11Mok_GC9CY-6bxtIKAYpc	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$-J2tr3j7vfmJ8ZSBAK5AyvQYmP2Byp-7dKfcBg5xHjU	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$o0wI9-m-SdyS4UK7_m9_MUd0luWmj6eoXfMg1ieT00g	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$wEwGnOPXUgG2_4DpqsPrYbSlIM2TnPjdWNDyVbZNE2Y	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$oZEGsAxUrYn8R6NS359wZO9T54eXOD-N88ftDK7ZHGU	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	\N
$LN4aYSSVw4GLaWf8g7uzrsw-fHTUyCBwq_-RRgS-MGE	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	\N
$sY34u-PbOKSI3_z8SIqGfn_2XnO9wqZ_eU1dvGDnRJY	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	\N
$zhfRuogjo-Vq5GM4-f6hyuXBGHx99o9_Nef1KWi2-EM	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	\N
$3A5iUMUsDMAckTZ_lQ9ZLyQdw7FKGrqWfMMxwAZJCwc	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$aUCd2uzLS80uiu1DeYrTDp1wAWs7M1ba_4Srm8LLnmU	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$zogqtnD68sbYTleQBUL-RkGDpkNmTHar6ilm_2oVnRs	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$OcjvTopfs1z8zuVgRxn4ynq9LH7z4eQhJnWG0PQ7150	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$GcBRlllGdKFvT1pDzY7airMfjuYYNt06vxkQ0BnM6IM	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$JtjXz-jm6mi5wU33MudkV8ZsCM2V-zduDqeI1xIG254	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$6cga7PdI_98v2MEH6Wosfik3Plxt3Ml7GwsUkSFFa00	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$0BYuX-7BWlMOYXwWp-y_txKwBBorVZzavW6fDuXxUrM	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$OOCwtQCB-nmnnlgQ3ST3ItcIsITOLkC3b4a-WpaJjRg	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$0ruVoUZRE1Edh-f7Z0QopPRTCr7L2kEpX8unxgxmfSQ	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$hWVSd4FzjwQq7FYDdhFSCgpisb3gxDJ2OAjCjYS6rkg	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$OJhJIVnJWjcgl3gc2AqLQK7sy1tKn075fy4E5qUK014	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	\N
$nsJ2oe7ZtdBtY0V-sJWzGBBDi7tcgH24zUaAdmLjXy4	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	\N
$XYKCYavbY8FMdUIlSSoqP0likUnTP6uJ0yHoGQCMnWQ	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	\N
$fc-Paa3ZBQU-GAAxH4QWDNrWblQvQ4ddYVzPTPiYV6U	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_a:localhost	\N
$4KgY7ivi_pp1q2tjdk7IWENjs1kzgSRLB29nKbq-UXw	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_a:localhost	\N
$0EmcDbHM6t0AJ7YKAcphqL8othdZg4dIXSazEHvnCno	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	\N
$UTOQTSrmXya3IQYDcRPwNWN1bIv2zQ3YfbaVRy9NQuA	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$IfK4xyQ_h94nUHneDilGoM0TTwuWFeP5_u_nlRs571U	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$aaPR9QI7az6NxeJ0hSrQxyKzzVyM-rBWODbN9y9rM9Q	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	\N
$2-SFwejONuAnI3cUJ4UN3FSzzJjeIWUURtWOJiO2sWo	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	\N
$72MNMNMOJMJpfLbdNKdm6ZXGr14ukIKdq-fG2OvzOqg	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$LjACIs2QTEZTfukFRb30GQyevcb7EREdVFxoNEgvHSk	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$EB67Xwo9B0__CxNTvptFIy4e4vG93cmEcHRWbiVSFJU	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$85g2ma_sFrYS8UbhpRwYEglJLj7xswd8VgNCg787_3E	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$jL60Q94H_SC7S4ZFOWkA4RilDwTMIUci2DyEXyQS_t0	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$WPbDUZRE7W6o_O4D0qf40PxoXNWcHrBwx3LxCA_ILaY	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$sPW_-g3Oq09Bq8Rm-TKPTRO4HHOlMXEni0rE18Y01h4	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$FNOekiMLFE4AEgQ1st7kiouCRAYO3DKEMbrYHGbH-zw	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$lDJnxY-YfTRyXQcBLRlbFT2_w4DXO4Pks75YGGa5M5o	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$SLqtTg1DQZU0Y4ezk90kDHz7IxD9TXjhW4qQAoPUfTk	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$6ZYuUr8K6uh0D7tl9-HD___6hQH3lj8qU1liF0zAkmo	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	\N
$t_tUn4wROpupdwEmZnXWQ-mtnx68XnGjofi61K92cRY	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	\N
$JgtV2Jrt_3Cws_oeqEte6xeUnTbTSMu0pBPrEWD4WyM	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	\N
$0ClPrn0jv_hdCQB4TqbWVPUxxSqFeDViCsOjYwQVDAg	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$ewJTQJq2XdLvkqYVULlUmmJ-A3LQ6Jnqs4GDYi6q0DE	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$EklY0FV28pDgoXqwoQUjAB5wTv33O8RCHRE8k2k6o2c	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$BtKmdXlHyT65KPvPIiDSk38oldbOKOUbuv7J13Up4wE	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$HVWinlm6AKNeOld7iV_yqdfmpznmG5wAyWK5k3xjM7Y	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$aa2-bg9KcCtrn4nE5HK1JGC6sa8Gr7jWqLhPgLQTtsU	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$ShuNV5AOx3oTjKr3eYjFKvzCZ374R_0vxs2HC21ht-g	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$sbDgkkxT05mw8xIVFWyOJtbW9nnehE06Wvxor1z8ms8	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	\N
$TbzKCcECXvJAKvBu5GZCTLIGi7Js0b1w9dE6KKZXaKo	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	\N
$XhzyXIYIbI0BfDV1QY4H3b4Wrpy5pJgJsGNZc8P8seg	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$M2xNoGVeTRazjk5EjiA0u3mOkneK7za9KWYn2LMJFwA	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$ggRHO4QwGg8SLwSXlSNnHypSBsgj2jFMUXbjC7U97qM	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$56oOQ2hizWAJWWKoJTMYGwAKX_gaANdZg2QHgtC63ZE	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	\N
$6Sy4DU04a_WCzalQkimJ_l9-eYsJ3kcn3Lat9w42L2I	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	\N
$FC2J9PSIQLoF8YJo6zY2dP8Eo55L8CPgzVGN7iaofRo	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	\N
$WcPnOWvRmgShLlAe8RxY4-_M71l0auS5ykpKdmUS0LU	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_a:localhost	\N
$-R5ZDLwPtIisO-W746dPRRrr1U6HjM8uhC78Zh95UUQ	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_a:localhost	\N
$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	\N
$19Wa_uoHXFwHicMPIWHRa1c8H1yIjgzKxpDzo89CTTE	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$Qyk1jqM8wu6uOaEDEalSs_0hepeq6CnfZZRy1hQ4sd8	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	\N
$qgyz1sVriFBiepR7YLOpA_tcnRjhDX9q13fkeJa8i3U	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$ZLuzCoh1UZ9oNHYyBNCtneq81TelpJ882dsDdio0oKU	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$Zv-9wNEnjnF-VeZtZKtHkYObGhccwLKewNnJg-fUiF8	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
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
21	19
22	20
23	22
24	21
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
38	30
39	29
40	29
41	30
42	30
43	30
44	30
45	30
46	29
47	29
48	29
49	30
50	29
51	30
52	29
53	30
54	30
55	29
56	30
57	29
58	30
59	29
60	30
61	29
62	30
63	30
64	29
65	29
66	29
67	30
68	29
69	30
70	29
71	29
72	30
73	29
74	30
75	29
76	29
77	30
78	29
79	30
80	29
81	30
82	29
83	30
84	30
85	29
86	30
87	30
88	29
89	29
90	30
91	29
92	30
93	29
94	29
95	30
96	29
97	30
98	29
99	30
100	29
101	30
102	30
103	29
104	30
105	30
106	29
107	29
108	30
109	29
110	29
111	30
112	30
113	30
114	29
115	30
116	29
117	30
118	29
119	30
120	29
122	30
121	29
123	30
124	29
125	29
126	30
127	29
128	30
129	29
130	29
131	30
132	29
133	30
134	29
135	29
136	30
137	30
138	30
139	30
140	29
141	30
142	29
143	30
144	30
145	30
146	29
147	30
148	29
149	30
150	29
151	30
152	30
153	29
154	29
155	29
156	29
157	29
158	30
159	30
160	29
161	29
162	30
163	29
164	30
166	29
165	30
167	29
168	30
169	29
170	30
171	29
172	29
173	30
174	30
176	29
175	30
177	30
178	29
179	30
180	30
181	29
182	30
183	29
184	30
185	30
186	29
187	30
188	29
200	30
213	30
189	30
194	30
197	30
201	30
206	29
207	30
208	29
211	29
215	29
216	30
220	29
223	29
226	29
190	29
191	29
205	30
209	29
192	29
195	30
210	29
217	30
225	29
193	29
202	29
204	29
214	29
219	30
227	30
196	29
218	29
221	29
198	30
228	30
199	29
203	30
222	30
212	30
224	30
229	29
230	30
231	30
232	29
233	30
234	30
235	29
236	30
237	30
238	29
239	29
240	30
241	30
242	29
243	30
244	29
245	29
246	29
247	30
248	29
249	30
250	29
251	29
252	30
253	29
254	30
255	29
256	29
257	30
258	29
259	30
260	29
261	30
262	29
263	30
264	30
265	29
266	30
267	265
268	30
269	30
270	30
271	265
272	30
273	30
274	30
275	30
276	265
277	265
278	265
279	265
280	279
281	280
282	281
283	282
284	30
285	284
286	283
287	286
288	285
289	287
290	288
291	289
292	290
293	291
294	292
295	293
296	294
297	295
298	296
299	297
300	298
301	299
302	300
303	302
304	301
305	302
306	301
307	302
308	302
310	302
309	301
311	301
312	302
313	301
314	302
315	301
317	301
316	302
318	301
319	302
320	301
321	301
322	302
323	321
324	302
325	302
326	302
328	302
327	321
329	302
330	302
332	321
331	302
333	321
334	321
336	302
335	321
337	302
338	321
339	302
340	302
341	302
342	302
343	321
344	302
345	321
346	321
347	302
348	321
349	302
350	302
351	321
352	321
353	302
354	321
355	302
356	321
357	302
358	302
359	302
360	302
361	321
362	361
363	362
364	363
365	364
366	302
367	366
368	365
369	367
370	368
371	370
372	369
373	372
374	371
375	374
376	373
377	376
378	375
379	377
380	378
381	379
382	380
383	381
384	382
385	384
386	383
387	383
388	384
389	383
390	383
391	384
392	383
393	384
394	383
395	384
396	384
397	383
398	383
399	383
400	384
401	384
402	384
404	383
403	384
405	383
406	384
407	384
408	383
409	384
410	384
411	383
412	384
425	384
428	383
443	384
446	383
449	383
463	383
471	383
480	383
486	384
504	383
508	383
413	383
423	383
429	384
444	383
453	383
461	384
478	384
481	384
482	384
499	384
501	384
414	384
416	383
422	383
431	383
447	384
468	383
470	384
477	383
485	383
498	383
503	384
415	384
417	384
418	383
419	383
421	384
424	384
432	383
433	383
435	384
439	384
441	383
442	384
450	384
452	384
454	384
455	383
457	384
459	383
460	384
464	384
469	384
476	383
479	384
483	384
491	383
492	383
495	383
496	384
497	384
500	384
505	384
507	383
509	383
420	383
426	383
437	384
448	384
465	384
473	383
474	383
475	384
489	384
427	384
438	384
466	383
467	384
488	383
490	383
493	383
430	384
434	383
436	383
440	383
445	384
451	383
456	383
458	383
462	383
472	384
484	383
487	384
494	384
502	383
506	384
510	383
511	383
512	384
513	383
514	384
515	383
516	383
517	384
518	383
519	383
520	383
521	384
522	383
523	384
524	383
525	384
526	384
527	384
528	384
529	383
530	384
531	383
532	384
533	383
534	383
535	384
536	383
538	383
537	384
539	383
540	384
541	383
542	384
543	383
544	384
545	384
546	384
548	383
547	384
549	383
550	384
551	384
552	383
553	384
554	383
555	384
556	384
557	383
558	384
559	383
560	384
561	383
562	384
563	383
564	383
565	383
566	384
567	383
568	384
569	384
570	383
571	384
572	383
573	384
574	384
575	383
576	384
577	383
578	384
579	383
581	384
580	383
582	383
583	383
584	384
585	383
586	384
587	384
588	383
589	384
590	383
591	384
592	384
593	383
594	384
595	383
596	384
597	383
598	384
599	383
600	383
601	383
602	384
603	383
604	384
605	384
606	383
607	384
608	384
609	384
610	383
611	384
612	383
613	384
614	383
615	384
616	383
617	383
618	383
619	384
620	383
621	383
622	384
623	383
624	383
625	383
626	384
627	383
628	384
629	383
630	384
631	383
632	384
633	383
634	384
635	384
636	384
637	384
638	383
639	383
640	384
641	383
642	383
643	383
644	384
645	383
646	384
647	383
648	384
649	384
650	384
651	384
652	383
653	384
654	383
655	383
656	384
657	383
658	384
659	384
660	383
661	384
662	384
663	384
664	383
665	383
666	384
667	384
668	383
670	383
669	384
671	383
672	383
673	384
674	383
675	383
676	384
677	384
678	383
679	383
680	384
685	383
691	383
698	383
719	384
740	384
681	384
688	384
705	383
709	384
715	384
732	383
741	383
742	383
682	383
694	384
707	383
722	384
726	383
730	384
743	383
744	383
683	384
708	383
717	384
684	384
687	384
692	384
697	384
700	384
703	383
704	384
710	383
728	384
731	384
737	384
686	383
713	383
727	383
689	383
695	384
701	383
702	384
714	383
729	383
735	384
738	383
739	384
690	383
693	383
706	384
711	383
712	384
716	383
721	383
725	383
733	384
734	384
736	383
696	383
699	384
720	384
724	384
718	383
723	384
745	383
746	384
747	383
748	384
749	384
750	383
751	384
752	383
753	384
754	384
755	383
756	384
757	383
758	384
759	383
760	384
761	383
762	383
763	383
764	384
765	383
766	384
767	383
768	383
769	383
770	384
771	383
772	384
773	383
774	384
775	383
776	384
777	383
778	384
779	384
780	384
781	384
782	781
783	782
784	783
785	784
786	785
787	383
788	787
789	786
791	788
790	789
792	791
793	790
794	792
795	793
797	794
796	795
798	796
799	797
800	798
801	799
802	800
803	801
804	802
805	803
807	804
806	805
808	805
809	804
810	805
811	805
813	805
812	804
814	805
815	805
816	804
817	805
818	804
819	805
820	804
821	804
822	804
823	804
824	805
825	804
826	805
827	804
828	804
829	805
830	804
832	805
831	804
833	805
835	805
834	804
836	805
837	804
838	805
839	804
840	805
841	804
842	805
843	804
844	805
845	804
846	804
847	805
848	804
849	804
850	804
851	805
852	804
853	805
854	804
855	804
856	805
857	805
858	805
859	805
860	805
861	804
862	805
863	804
864	805
865	805
867	805
866	804
868	805
869	805
870	804
871	805
872	805
873	804
874	804
875	804
876	804
877	804
878	805
879	804
880	804
881	805
882	805
883	804
884	805
885	805
886	805
887	804
889	805
888	804
890	805
891	804
892	805
893	804
894	804
895	804
896	805
897	804
898	804
899	805
900	805
901	804
902	805
903	804
904	805
905	804
906	805
907	804
908	805
909	804
910	805
911	805
912	804
913	804
914	805
915	804
916	804
917	805
918	804
919	804
920	804
921	805
922	804
923	805
925	805
924	804
926	805
927	804
928	805
937	804
949	805
955	804
965	805
966	805
971	805
982	805
989	805
1015	805
1018	804
1032	805
929	804
933	805
938	804
942	804
945	804
962	805
972	804
975	804
1005	805
1007	805
1026	804
1031	804
1037	805
930	805
947	805
948	805
953	805
954	804
956	804
959	804
963	804
978	805
980	805
998	804
999	805
1016	804
1020	804
1024	804
1028	804
1034	805
931	805
932	804
936	804
941	804
951	805
967	805
968	804
970	804
973	804
984	805
985	805
986	805
988	804
1002	805
1010	805
1014	804
1025	805
1035	805
1036	805
1039	804
934	804
946	805
987	804
990	804
992	805
994	805
1003	805
1011	804
1017	805
1019	805
1022	805
1027	804
935	805
939	805
943	805
944	805
961	804
976	804
997	805
1000	804
1004	804
940	804
950	804
957	805
958	804
960	805
964	805
974	805
979	804
981	804
983	805
991	804
1001	805
1006	804
1009	804
1012	805
1021	804
1029	805
1030	805
1038	804
952	804
969	805
977	804
993	804
995	804
996	804
1008	805
1013	805
1023	804
1033	804
1040	805
1041	804
1042	804
1043	805
1044	804
1045	804
1046	805
1047	804
1048	804
1049	804
1051	805
1050	804
1052	804
1053	805
1054	805
1055	805
1056	805
1057	805
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
21	!kmbTYjjsDRDHGgVqUP:localhost	$3pZnE6ITQzzyNsuVCenuFBVRMocr892PiAvIbMGbMBM
22	!dKcbdDATuwwphjRPQP:localhost	$oPNBx-eTHzyLXPzpYpdxdhLdVeGmx5lNmrECxIazfPQ
23	!dKcbdDATuwwphjRPQP:localhost	$Oqb-EaDS-8U6U1Z6bTGSE7FJIlxKGhzMkNsnYIJY0Y0
24	!kmbTYjjsDRDHGgVqUP:localhost	$hJeKBcpebJzm9oiwjDCNTWPtbEcfp9GOLXl3yGkyaFU
25	!dKcbdDATuwwphjRPQP:localhost	$9cACT8rCcbUXbMhABzEciyF9pIIDRFNzaBkRVPH_0mk
26	!kmbTYjjsDRDHGgVqUP:localhost	$0gxNuNkWyOeHPtnNZ92FzvprItMgnH9hLCbYuY0Vzos
27	!dKcbdDATuwwphjRPQP:localhost	$9ArTh8Z2w2oc68FOD1X8Ka3DlK7lq00HaHKT_4DMSY4
28	!kmbTYjjsDRDHGgVqUP:localhost	$V_uchZ_8H2oh6EdsXqKsT6Ri62_YZtAAMfZi8pbBGrc
29	!dKcbdDATuwwphjRPQP:localhost	$Q4TOA6SPu2kQIrypB8QEJLHphxV5mHZ_eFwQux4jWSY
30	!kmbTYjjsDRDHGgVqUP:localhost	$YwLlyzcAMpJ69jsxTNglcWTbK8XHK8huc6aB6jpgEWk
31	!dKcbdDATuwwphjRPQP:localhost	$_qmz4Qfyozj7n8l7PRHSQzTSzbhu__B-wlB74YcT9ZQ
32	!kmbTYjjsDRDHGgVqUP:localhost	$jfm5A0yxQ8B1hRgqCEVhjsNN1u1S-DjTjhDsaFnUCbg
33	!kmbTYjjsDRDHGgVqUP:localhost	$acVS3JJiynka-P6x16zaA0A54ALX8vu_mvJwobIw0Ig
34	!dKcbdDATuwwphjRPQP:localhost	$d7DBG0H7S-n_GLC2cC0UFgyntugHIFjIPmi0DpBAODY
35	!dKcbdDATuwwphjRPQP:localhost	$USV5WNYJNpxK534dOjGXmqI-018r4uXLbTx6RD9FF7c
36	!kmbTYjjsDRDHGgVqUP:localhost	$qNTRLk1wSqa3NzGbKiDcoJUR2iXEzgfRmYIRHSzyrws
37	!dKcbdDATuwwphjRPQP:localhost	$s_CiX1M8vzBe34vqSRs7OHqehdJk6X6veVlkJL9tD0w
38	!kmbTYjjsDRDHGgVqUP:localhost	$uLhb0AAPmwVbnsOJOC-DgHyRJc3xdU3yVqJoXQKeTwE
39	!dKcbdDATuwwphjRPQP:localhost	$r2pfZV7TBF33N9GSPzCDuCRktoPTY_SdD_c4cQY74fs
40	!dKcbdDATuwwphjRPQP:localhost	$aDLI-_gaaN0AqME_UQKGBhDruqAYxQ1TFmTIelqacRY
41	!kmbTYjjsDRDHGgVqUP:localhost	$hf_SzqMjWH2a99844BZWQ370Z8fxb5VmTVmxO2rUH7s
42	!kmbTYjjsDRDHGgVqUP:localhost	$PfCxtlQvfKX15DGv8hl5JE_FSchpfxzwtlfa4I6ekQU
43	!kmbTYjjsDRDHGgVqUP:localhost	$nQkSaQ2x8Zz2QwOhUJkjMueeJrfFpearE26hCHOP5Fg
44	!kmbTYjjsDRDHGgVqUP:localhost	$popNZhEfogEXHtQjC0j6d1Y8RwQhL38dw6il0G27guU
45	!kmbTYjjsDRDHGgVqUP:localhost	$nECeEyhkAesTx9vdKnWqYfPyYhegB5Rq45sCMHrKk7E
46	!dKcbdDATuwwphjRPQP:localhost	$nJ4yFPhyTNytm118ESavHKdcfx8kBbWvS2LRZScW9dY
47	!dKcbdDATuwwphjRPQP:localhost	$KVX22PlqJxtdV0aJPjql7nz04yVNfoXjSA-DPbJWfyo
48	!dKcbdDATuwwphjRPQP:localhost	$ou3AgyqgCApBHPcw67tKPrzNrHS--stDRyAiFnV0Yek
49	!kmbTYjjsDRDHGgVqUP:localhost	$WgNJkwLwifQ1nedcCx02Q-XKrj0RSONfOZAkuS7yoKk
50	!dKcbdDATuwwphjRPQP:localhost	$V_KQhQvxJRwrWBQ6mPpRQhjvI7J3WZaGkokjxtlhuE0
51	!kmbTYjjsDRDHGgVqUP:localhost	$rIaUREO5pHlPmrUPjykYdzMOpq1XgEy0o7c6wNSk6Xk
52	!dKcbdDATuwwphjRPQP:localhost	$MvgmmDq0C_1mtWzBrVa1jYul79bvavWn__51KlLYxP4
53	!kmbTYjjsDRDHGgVqUP:localhost	$sdZQNeTf3qJAOEBIyzpLNjZ_OXbBsyca4rHb2UhnUVI
54	!kmbTYjjsDRDHGgVqUP:localhost	$Yop5FSJS0WFOgZ7TDC59sc2zmda4a7LJVl0ehBu3itE
55	!dKcbdDATuwwphjRPQP:localhost	$DTXRpEhUd7mdlAFRVkxUz189zGZBkKF5Y0y3dTxUpQM
56	!kmbTYjjsDRDHGgVqUP:localhost	$48GtrF6umRd7vrp7U62OwCyOzTWp0Ni9f0pEKA-lXjU
57	!dKcbdDATuwwphjRPQP:localhost	$m5XjEKLKBhkaFNIpPJJDDrbOAS59kLsxznvHGRf6L-E
58	!kmbTYjjsDRDHGgVqUP:localhost	$ae08F80RJk2G6TsxifBGOd-Vonii3XfrMX4x-IA-EL0
59	!dKcbdDATuwwphjRPQP:localhost	$LDw2djChe3maKDVtD7Dt__-APjXjwEOUEW0utBfPu3I
60	!kmbTYjjsDRDHGgVqUP:localhost	$Bqpmajg0LyajvlHQxgMkqHam2S7NmfztmOk6I9cuRvU
61	!dKcbdDATuwwphjRPQP:localhost	$Iqyv-g55dIENuYvzxfrMC_Z60HrXdyMIaZ5rzDPN39s
62	!kmbTYjjsDRDHGgVqUP:localhost	$aHpnnBVl8QMov-uTe-BAYQbN6e3bgtjYYohmVanVJ1Y
63	!kmbTYjjsDRDHGgVqUP:localhost	$iSEvBSqLEOR2CeW8pMxtwd6NacnGVhLdhxJmTcBxBok
64	!dKcbdDATuwwphjRPQP:localhost	$unCM-ixmKcqc63QDGcDP9tdZgM-o7x2D9hO8eHrmgCw
65	!dKcbdDATuwwphjRPQP:localhost	$usoPaEyShWpI6Zd1IXcy0axfqcri4UdV_8Kl7MxtoAQ
66	!dKcbdDATuwwphjRPQP:localhost	$ATSVoY3nonCv1003gK9zr_dz7k08lgBXFqKan4O0UKU
67	!kmbTYjjsDRDHGgVqUP:localhost	$xGGwbMyjMNYdpCeNDCocZRIPHcBwni-VGVpLj5yl4hk
68	!dKcbdDATuwwphjRPQP:localhost	$rIQO-ynsAFnr8hCcUhBI2uc7kB_Rd1T64Sj0eDTWCeI
69	!kmbTYjjsDRDHGgVqUP:localhost	$i0HpyyuVBOdXDoAgzLOBmhiM0t9N3bOQVhPxeVMEI-c
70	!dKcbdDATuwwphjRPQP:localhost	$pmx--naCjTlIBmLXhZfbqq4tlGP4fz9j1orntNdZOc4
71	!dKcbdDATuwwphjRPQP:localhost	$7TOt5bi8CLlI8eqofW8vh5zUMNPoMB7vTlo7AJF13vY
72	!kmbTYjjsDRDHGgVqUP:localhost	$P9VUrha3ThmrwrRBNWSv9px-7sWpb3LULVpqotWHatI
73	!dKcbdDATuwwphjRPQP:localhost	$nvTZBtj-PQ5IV2J3K4bi3Oqm9Bl5gcsNTSEN3CVpPuM
79	!kmbTYjjsDRDHGgVqUP:localhost	$9OcrwYcxaebwcgsyKqqk-B_d7Wfwy6G-_dIY0go3_x8
81	!kmbTYjjsDRDHGgVqUP:localhost	$xaA2PsHmpEnOPsRnEG2bCQcaF3JEYssBvekk5zaW-qM
92	!kmbTYjjsDRDHGgVqUP:localhost	$t3r4a5f1bvQ7BoQoIGRl9qxLxn7IwcdI3naAoA4ZqTs
95	!kmbTYjjsDRDHGgVqUP:localhost	$v1IppjRAWKm5718PgejseTWkId5beUtE3kAwQTRGlgE
97	!kmbTYjjsDRDHGgVqUP:localhost	$PUVQLmAjdOk9N4GRcyyCv6essAMVSBYz49zwqT8ukCg
98	!dKcbdDATuwwphjRPQP:localhost	$mV0cHYY64EHmZjKSc0RdfpQywBPQ04_sixaJwn1b6q0
101	!kmbTYjjsDRDHGgVqUP:localhost	$7KbszJFmbcLxlNjNZ3HsxDbWnmaC2qjGEZOPrW2G6ZQ
102	!kmbTYjjsDRDHGgVqUP:localhost	$waoG8h-WFQYHxKC8AsWntFCJGl-o_vCQY-2sjSuMYaA
105	!kmbTYjjsDRDHGgVqUP:localhost	$7oYDUZRJXIlLowf-Dk3_y7PgGpEb-nnMVvo9CspKtB8
108	!kmbTYjjsDRDHGgVqUP:localhost	$sgR55JrwZs41WCpvkVV1GmVYFkN_kHXth7dhL54duT0
115	!kmbTYjjsDRDHGgVqUP:localhost	$WIFmXGXHDTGyySDLLB2gQBNoZmNBcKkG68_UnFAQaDI
127	!dKcbdDATuwwphjRPQP:localhost	$bZDgBKRMuUZ3izP3zZgpeROaTU-y1cUucHXLbthta94
129	!dKcbdDATuwwphjRPQP:localhost	$YNTVLRy40AlIL_DF3ttx2C-BvVXJZKPsb-Gpwnw2cBo
134	!dKcbdDATuwwphjRPQP:localhost	$d4cLbE7qK0Z0sSqVwfFGr0opSBAmHS3B_34YVOLSdaQ
144	!kmbTYjjsDRDHGgVqUP:localhost	$S4gLjVfRMu7fHIqyIwU6ap1fzuD_x1MvJYXXbmYp9J0
153	!dKcbdDATuwwphjRPQP:localhost	$CbhgFxv4qYQ-5kFPYrTTHxfmCU_G2M8Vxqqu5Huieb0
154	!dKcbdDATuwwphjRPQP:localhost	$kOk9Qyp0UpQWZbvotwi3EqUzWePNtjedb6koDUYBWN4
74	!kmbTYjjsDRDHGgVqUP:localhost	$coz1sqYl20OmVpPyIlGfh5cb3pi8mx7LDKg6UtHro14
77	!kmbTYjjsDRDHGgVqUP:localhost	$EtDG0MJ1-_jrNT0yivKm7iqcGwBL_U0i5nzvbw5Z1No
86	!kmbTYjjsDRDHGgVqUP:localhost	$ikN_5HY1a1dd9pCNZRbfVT8AWtVeUDGVIe_qm_TA1Q4
104	!kmbTYjjsDRDHGgVqUP:localhost	$vCTIFxoTOiQ-zlHweDsxldYZu9EOHvQ_cReY8bofAeg
107	!dKcbdDATuwwphjRPQP:localhost	$--OzTSfx6OLS2z01vk7ZSkK7pYS0GvQvtjM1PUiIcDg
118	!dKcbdDATuwwphjRPQP:localhost	$3e2HAzbj6YIoe38nT8UFPXKNMiUB7jrjk11X7C3eUbQ
126	!kmbTYjjsDRDHGgVqUP:localhost	$uvUjV1EPaViweersEx-EI50UdZbmpEXsas3JyI1cQ_E
128	!kmbTYjjsDRDHGgVqUP:localhost	$3p5TueEGAyGWRhmvG5mGzj5aaVsIVpH9r2MmENsQOko
131	!kmbTYjjsDRDHGgVqUP:localhost	$NNFR_ELqO0aie14zdx0yx7iMsg9otUzterLCRUaaRx0
143	!kmbTYjjsDRDHGgVqUP:localhost	$8lo6SyEw2oKEpOKddwkPlIw38G8SPJ_7TXcwWOvVNHc
145	!kmbTYjjsDRDHGgVqUP:localhost	$AKFTxp-f-b1pK8af6Xd1oRqF5h6LKQzKL_cRaKREiBA
150	!dKcbdDATuwwphjRPQP:localhost	$ucoD35tor_bS7YI0fjODTkzWk4NrhzQhbWbCyaErmQM
75	!dKcbdDATuwwphjRPQP:localhost	$Pycmsw9PlnIrjJtSB5CsNVYe8fk_auY93e154qgiYik
82	!dKcbdDATuwwphjRPQP:localhost	$UKAe3SE5Jg8h3YejSMclcqmdwhDaACGihBDMcqmD5HM
83	!kmbTYjjsDRDHGgVqUP:localhost	$leRZrZqYUugoJ6-lFkyC7YxwyVWeMG6IM0w5DI55kXc
106	!dKcbdDATuwwphjRPQP:localhost	$b56h_G23WgTFneRsieSw8fuSFWQ0Iak0WqbPCNnlzgI
109	!dKcbdDATuwwphjRPQP:localhost	$oCfdkHMiZ41Sl9f5jK1mV2AcdH1k2-Zb-Eia6E6PHPE
111	!kmbTYjjsDRDHGgVqUP:localhost	$3Uawz9W0kWhLA7yXQGUCPZJBLUav8zggG0jQgjKnXx4
119	!kmbTYjjsDRDHGgVqUP:localhost	$HJaOHRV_oyXSVzF_yen0rElIAKJaBViFH2kzwLRg8DE
121	!dKcbdDATuwwphjRPQP:localhost	$-1p5P1AmoBeo5PVTs1_crHkRV90iBspXMAPMXH9u7wo
125	!dKcbdDATuwwphjRPQP:localhost	$71h1qpIMl5c0QQ7dNa76kjq2RgjMukTWZIH-fZVoE6s
130	!dKcbdDATuwwphjRPQP:localhost	$90pFqNQP_FtdhXnVMw8ThE5s70xkE9xvOekrLiU6tLE
138	!kmbTYjjsDRDHGgVqUP:localhost	$M4zxF8DQoxUjI3kZjRWDkzSG17hiH4E2wqnb-wuEzzw
141	!kmbTYjjsDRDHGgVqUP:localhost	$wjx7Witiki2sztuyUmQuVd2Akx1PI5RFNCdhoWv9OoY
149	!kmbTYjjsDRDHGgVqUP:localhost	$24M8TONdEXe0IHZK1WX0FnOfAv_bQOEcetzmzmwawXc
156	!dKcbdDATuwwphjRPQP:localhost	$YjpnlEJ7Ezr9uJanEHfQ8WgOfM-erjoLvePIqSwT40k
76	!dKcbdDATuwwphjRPQP:localhost	$kI0jRX0XMzw8dqKwTMQ-gWoPIHIbkNxGWzCnfEYKRCs
85	!dKcbdDATuwwphjRPQP:localhost	$d3MyOohPFDD6jTC2R8dX2fqtFRG8w-wMhl4JTXP7G9A
90	!kmbTYjjsDRDHGgVqUP:localhost	$bwfeqLdhox25JxjpMLqCnW1alPiUy5FDsgVUB9LludA
94	!dKcbdDATuwwphjRPQP:localhost	$zcbpA8GkElguaElYO6FN6PV3khRSMEivUMbuxoGTzMI
100	!dKcbdDATuwwphjRPQP:localhost	$_HBabhQkhIR5ZWeYcdVcx93COjPtIBmFziWNl33lWiI
103	!dKcbdDATuwwphjRPQP:localhost	$QafUUpSFDzHf7urjWYBQrWg7ljX_mEmLW1UFJr8NRuU
117	!kmbTYjjsDRDHGgVqUP:localhost	$iyR4Y8_Y8e13NuUST12XUbaD-kz6RsNy61u9pgGlf9A
123	!kmbTYjjsDRDHGgVqUP:localhost	$WCf9yiFLFk6b9s7pp1oXNL49X3SRs71S59dWMPHIi9o
132	!dKcbdDATuwwphjRPQP:localhost	$lPRSMvyjjz0eyXCk7pB7LP13Ey30fyd9Zrnhj7OShmc
133	!kmbTYjjsDRDHGgVqUP:localhost	$qKsurgjgIOGPa8UIKFF-XVUvkI-u3hQMpCiTbNmTevM
135	!dKcbdDATuwwphjRPQP:localhost	$h_jic-9IKUfkajx2Zj8XaWeLQbuVoh8mtORfcyzpe6E
140	!dKcbdDATuwwphjRPQP:localhost	$Vk-59jkK1bF7FpkM9SF4-ZRJ4cKO6iyn5dBB28nwiCQ
146	!dKcbdDATuwwphjRPQP:localhost	$BhuD2dOxIdItBNRr2V6auijOWGI_Cuc_rT6-H5mehX0
78	!dKcbdDATuwwphjRPQP:localhost	$JQ00qR2uxIX2Bt9CTt6XrbBslcLPn-GXc3fSjFDDXYs
80	!dKcbdDATuwwphjRPQP:localhost	$risHeecWr-hzwPLZLbZ3DBudjb9nMkSKnYt4PoW7ynY
84	!kmbTYjjsDRDHGgVqUP:localhost	$LbUvf0WjS4n2q-lymFry31bDBJfqpLpnKxbwByvnCJQ
87	!kmbTYjjsDRDHGgVqUP:localhost	$dJHNMbUqFcriJyY-hR2GUZXWyAO5_7F9Oi8SeVx11Aw
88	!dKcbdDATuwwphjRPQP:localhost	$BmqYA62rtzKhT1xo_JEc_30sLc2ETiwznsZilEeMOOs
89	!dKcbdDATuwwphjRPQP:localhost	$PoEkbdkddNlmuLMF-j1MDakZ2Gy4r8l1LbXoVbuPRvQ
91	!dKcbdDATuwwphjRPQP:localhost	$35xbm_hEmaUuhFHMjztVvnFxs-0x6oYbGitJSK3nXm4
93	!dKcbdDATuwwphjRPQP:localhost	$nmJDtgqNIL8GMfIMNLCNEP44FCfIKzCgjZgJBvI_hls
96	!dKcbdDATuwwphjRPQP:localhost	$YOJzvxoU5aa8HSOK5-ezAvDPSedHxCpN7CRmfb8wdGA
99	!kmbTYjjsDRDHGgVqUP:localhost	$-Gki9QWPEDpKK1abH_WOAgBCArzjBXpr6tH9KqSGG6o
110	!dKcbdDATuwwphjRPQP:localhost	$1dlFgBR4UPO_Z8BiuVqoS7aoXp8FwVkwGi9olFZw8tQ
112	!kmbTYjjsDRDHGgVqUP:localhost	$4Vb-vRiGRUJUaQupVkhlgbIxfb9i497qcKCdqRa4_D4
113	!kmbTYjjsDRDHGgVqUP:localhost	$L-tUkq6pvfFV4CowSgK1VFPnySWe1_ObifUAmpCKRZ8
114	!dKcbdDATuwwphjRPQP:localhost	$YQJhR7m8MtzU6qKCnOvWNhQeVoOo_dIOvLFqmVTys4U
116	!dKcbdDATuwwphjRPQP:localhost	$qaMLS0TiRymLVVSqZVcOpYzEqFbQIecVpWhGAWi_8gk
120	!dKcbdDATuwwphjRPQP:localhost	$FBerhrQP6kAJSfMLv4t0Jeu3F8O9NUbkYsavrSCGXUA
122	!kmbTYjjsDRDHGgVqUP:localhost	$gSZ8u8AfZm231KIjz9Set8L4bWCQ0VPTWX8dyJ1DKdA
124	!dKcbdDATuwwphjRPQP:localhost	$NG7Y90KLE1Yrh_SNf8c2oHqXHy7VeAwsvgwavUWsvLs
136	!kmbTYjjsDRDHGgVqUP:localhost	$Pbn7LTLYrHwuoXncIedZ8zT_inyp5Q7o_jXJ1s3KlHA
137	!kmbTYjjsDRDHGgVqUP:localhost	$l8b2cNYmji6ZhDdDrFL2y1cBa2-rHurbHwtETRrCfPo
139	!kmbTYjjsDRDHGgVqUP:localhost	$UDuUfSx897QK7x_uj3k9e9dLHpD8pFupIL-g2bKOTqc
142	!dKcbdDATuwwphjRPQP:localhost	$R6-HznqkaOqidL5UU7FavatIZ8bhHmg5kRrI46oOoHs
147	!kmbTYjjsDRDHGgVqUP:localhost	$62e5TUPaMxCYyA9kN1x5QRrMv-D7FTVuKVC889a5C7o
148	!dKcbdDATuwwphjRPQP:localhost	$yIFSBC4d2KfNwbPhmAEkQfa9Y0pJh5PRgqHRZ_NOZQ4
151	!kmbTYjjsDRDHGgVqUP:localhost	$Iacj7emwQCMdEBryp2JBpjUW3tVaTm-BljibLn-ORSU
152	!kmbTYjjsDRDHGgVqUP:localhost	$sJNodrV3k_29LZcUktC996ixsFLffBXXqwo8wX61j44
155	!dKcbdDATuwwphjRPQP:localhost	$q3vWym5O1J-Dc5KL8b8bxJfFvSqgcCIH3g-1qJqijJs
157	!dKcbdDATuwwphjRPQP:localhost	$3wo4OUf38lhhC2kGx_Sea3MSDNMGg5ktBgIdcSJILyA
158	!kmbTYjjsDRDHGgVqUP:localhost	$au91nTAqaJxHDNk0q6LjXKKokCa_NO5IWPLaUaQXpao
159	!kmbTYjjsDRDHGgVqUP:localhost	$IlP_Ey_bLvv32m4v8Eq8IcVOhfvNnHBTQ8aZzIB_2uU
160	!dKcbdDATuwwphjRPQP:localhost	$GEAWg-VDfh5ouAGhqRTobk45-UTxoa3mCsV7yqBZaIQ
161	!dKcbdDATuwwphjRPQP:localhost	$FLhgsKlGmoQGVHahDyuLlFuYvqss2CZBrVZ_qDWm8Dk
162	!kmbTYjjsDRDHGgVqUP:localhost	$-jSOLzj9wYm5oZ7extQEKsPrUvWrYcYMWFTcN_oV__8
163	!dKcbdDATuwwphjRPQP:localhost	$68F2BwZFfoMSLHwCWKXISaUFuoPYjD-L_53cRhJNY6Q
164	!kmbTYjjsDRDHGgVqUP:localhost	$qByuRMWkaqBaClwJhifU4aKMvZQtKGxJWd1MYoOck4Y
165	!kmbTYjjsDRDHGgVqUP:localhost	$IAmu7HTnBzathinTcwxJWk7og6NmDpW62tt9xKjPHV0
166	!dKcbdDATuwwphjRPQP:localhost	$5o1bZvUXxluZkOPs4Pww8q7pIGeURStwISlsLNPORD0
167	!dKcbdDATuwwphjRPQP:localhost	$oc8Pedo518lURriTVYcIPmWartodeL-2fWApr5vaUgs
168	!kmbTYjjsDRDHGgVqUP:localhost	$Mn-KEUfjJuKKPWZWxtu8OUG4xWhVAhXXT3rtq2Y_Plo
169	!dKcbdDATuwwphjRPQP:localhost	$lrPOzuE1RGga3yFPxlSYn4wBb2CRmnJd480NhWje5j0
170	!kmbTYjjsDRDHGgVqUP:localhost	$XityxPYrDgZfKW78NagU4iv41VSma-oWHsrCTo5mWIk
171	!dKcbdDATuwwphjRPQP:localhost	$TFDhQsUAJIa18bDRoRT2TeqrpKX017rqm4a3QXHhCwI
172	!dKcbdDATuwwphjRPQP:localhost	$4ir1AmNdT-NsanlvDD0v_tu_eZz1Muo4DnyI9HUjCGg
173	!kmbTYjjsDRDHGgVqUP:localhost	$tnWlkm936_vB_Y7hIm1xitvjYyTOTxvjRimKLFwXAes
174	!kmbTYjjsDRDHGgVqUP:localhost	$SXOzqaVuzZuli7jRexRfjcBkG_Lo8bpYQFDPmubl-zo
175	!kmbTYjjsDRDHGgVqUP:localhost	$zSromuuyxxtiOuvXmZhmmof0fMhFrv8ciSfP2huUStI
176	!dKcbdDATuwwphjRPQP:localhost	$EN8AVCSmlEDK1ICFP87t_RF0u02PSlLg5C-Ua7yY_hU
177	!kmbTYjjsDRDHGgVqUP:localhost	$Adoe1Mrg1tslCP4i3jY47OLMQNh711qCFdCTjvP5zv4
178	!dKcbdDATuwwphjRPQP:localhost	$_9v_j7nrKdcJmJGC_a_ELETSNjuWlvm83O1y33w7vWM
179	!kmbTYjjsDRDHGgVqUP:localhost	$tofYv9HtfGzOFkReTS_OoI0_OCa6YhG18wUS7QOVI_c
180	!kmbTYjjsDRDHGgVqUP:localhost	$CopCQXMrMKDK8ilbfQO0YE4ilrl2T_-s2_O2OjDfc_0
181	!dKcbdDATuwwphjRPQP:localhost	$FtaZD7iezke1l83dzUPNFG_-rVA7THcPafMYV5bVHoc
182	!kmbTYjjsDRDHGgVqUP:localhost	$nWP9k0OOVSUiVHV-WzUEchO7A3AxxT5i4eLIO__6jug
183	!dKcbdDATuwwphjRPQP:localhost	$FStGc70GaP_czNf50kQG5Lyf2Gp-n1PaRWg1bXNHqmE
184	!kmbTYjjsDRDHGgVqUP:localhost	$W_eOOOWJJmqQ72AeG2ZBqWCKLBzydu8jp-IgDd0ZPjk
185	!kmbTYjjsDRDHGgVqUP:localhost	$dXZVpq6rDuuMLODc8B-JlLnwftlBXKmM5Niwqbgu_NU
186	!dKcbdDATuwwphjRPQP:localhost	$P8l2xT7AmZ_4vwUj8hjZKjwgH5D3TE-U1GzyG74BjWM
187	!kmbTYjjsDRDHGgVqUP:localhost	$IS2TKt63YEYZcKtF2FoTvDIEoZ0gbV0Y8T0ANPRPO7c
188	!dKcbdDATuwwphjRPQP:localhost	$CDRukd_j8EcynOp-aQFUiBxx8A8MKkIMpKf89DbyZf8
189	!kmbTYjjsDRDHGgVqUP:localhost	$2PNdgt5X_fxicrWqiJSPxOimobaQkd0jE5NkuNay5Is
190	!dKcbdDATuwwphjRPQP:localhost	$1owv4BeGwWuirb6CSSxk49vtgeQL9wXOLCiQ2bWEBUQ
191	!dKcbdDATuwwphjRPQP:localhost	$oc8ce-nem7d6mExmr_sjCnSsc-UzQO0bWp_ouj1RDGA
192	!dKcbdDATuwwphjRPQP:localhost	$rFwvNm3Fh-s9C6aLuN2l-EDC3q82QTZ124YCgowzi9w
193	!dKcbdDATuwwphjRPQP:localhost	$r90eJGAZSSMAOd4wtqN7oORGSCWTwpr9vpwJ0FoXurU
194	!kmbTYjjsDRDHGgVqUP:localhost	$-Kk-uF1ihIQtGe3Cbe82xiZlHtgM-olwXbH8YZagHE0
195	!kmbTYjjsDRDHGgVqUP:localhost	$63KRjybQb-7TBYWwCqr23IE6hKz-Dj5acau1w-x3rug
196	!dKcbdDATuwwphjRPQP:localhost	$wQBGW0PDXKVyt_23Kros2HpN-p0xdvQtMc40XYib5bM
197	!kmbTYjjsDRDHGgVqUP:localhost	$mmaC3I6t1Qe5E74G5xHADrMClURQbF9QsphtChxhtjs
198	!kmbTYjjsDRDHGgVqUP:localhost	$f5gOUNT7dWUgwHD1Qh4EcxyJkxGUfUdmEL0775sbMiM
199	!dKcbdDATuwwphjRPQP:localhost	$glpKV7KxRpU8QAMVncN4auZgTCd2Ek398IbmYXz8y6g
200	!kmbTYjjsDRDHGgVqUP:localhost	$0U3MdJjsG2H04UaxN43SeTtUoD9pRoSxNgpPzioMVEE
213	!kmbTYjjsDRDHGgVqUP:localhost	$cI4VbMzLsBMqKIHR4-0z-9FcaxC-KZnYDPWIA8j_IXE
201	!kmbTYjjsDRDHGgVqUP:localhost	$bEz2lszVOHZrYDBO5mP8509gTdEe2tvO9rqd3vzi60U
206	!dKcbdDATuwwphjRPQP:localhost	$WvMHRvklktudE6jsXWVhDCR4SFFH4DAQ5mRjt3fvliw
207	!kmbTYjjsDRDHGgVqUP:localhost	$Z6oqd0kUneXuH4QnR4LdvdLsqjCO1Zbb2mJxl6IaCQw
208	!dKcbdDATuwwphjRPQP:localhost	$l1XbvsK55fiW2rZBK4DlgHxUtIW9aIRCOMsxQ7pYxQg
211	!dKcbdDATuwwphjRPQP:localhost	$ON_nHffY-9ivRAcJ0VhLypBe9lWZDk-n7suZEsMhsgk
215	!dKcbdDATuwwphjRPQP:localhost	$j1Z2yVFXFVG2BtB5V0oT82baz_QKXsseJ8i_McohlPk
216	!kmbTYjjsDRDHGgVqUP:localhost	$dTYKWKHUGuvAfPFvO7x6_vrjznIr0UcExIGylPQHm1g
220	!dKcbdDATuwwphjRPQP:localhost	$TYy3n3KWkqtTglblIX3sNquoijnwEjjU33UXmpvW5SY
223	!dKcbdDATuwwphjRPQP:localhost	$XXY3WRUy642wWEzMMIHgjuUMLThtFH8vrOBUJhQdS_E
226	!dKcbdDATuwwphjRPQP:localhost	$fDrV9a9UoqlwY6lpml6wAPX1hT1ZOShyl1XCMcuH77A
202	!dKcbdDATuwwphjRPQP:localhost	$3gt3rfJcSog16uC6oIAgEdO55QTNiQrMjLfn26nq7PY
204	!dKcbdDATuwwphjRPQP:localhost	$0OEGV420NSLHDNLE8Ay4wVZi-nEwnXASdg3-dghKPj4
214	!dKcbdDATuwwphjRPQP:localhost	$PbwZyALDMVfT5Ndle1YMxRAAdzCEnBhBQ7sIvZ9gCHU
219	!kmbTYjjsDRDHGgVqUP:localhost	$j-j29KrNVPD6NvYKZqtkMdvSiYWKvoRbCBtB62GV1hY
227	!kmbTYjjsDRDHGgVqUP:localhost	$kvfnYs8U7ql1lQ_cW-GrYPsOAueYLkAOa_zJjD0sssc
203	!kmbTYjjsDRDHGgVqUP:localhost	$kCczrb4vQV21B5aXRV5r3em3uVq_MyBDXuJR9IP9ZbE
222	!kmbTYjjsDRDHGgVqUP:localhost	$HEiCUyELxf6qbWFH0ZRfN_OcO444ZlZ1MpBtqmvOvyY
205	!kmbTYjjsDRDHGgVqUP:localhost	$pFJCgvmGwkB4CjrxW7vG2AuO0cheFo-eAxqopGa-wT0
209	!dKcbdDATuwwphjRPQP:localhost	$toEhKUOOoeBj0Bzk4Anc_jJrFR0ZZqnpq_RQ16bgHM8
210	!dKcbdDATuwwphjRPQP:localhost	$BdKah2K8bdkq-f_Qfs5TGfp8I5rW0FhSUewa1rTU5-I
217	!kmbTYjjsDRDHGgVqUP:localhost	$lHWe9O10kJNhwG8XsExXySKPT8WMTJyJIOJZHIDZTzI
225	!dKcbdDATuwwphjRPQP:localhost	$AtPnWnD7YnkDey-BIz2rcXbiTRwNA951VGs8-smyjlY
212	!kmbTYjjsDRDHGgVqUP:localhost	$EY3wCW8Avo3IBGm1xhjcdan9iMxmeTfKSsZ2SYt9nSY
224	!kmbTYjjsDRDHGgVqUP:localhost	$5qlOagXzgi8ze6oZuRyWj3jWuvJNunkkre49NzDXHSE
218	!dKcbdDATuwwphjRPQP:localhost	$gdM1m1jg9Zzy3XKIrnRVqgqXtzKXd5TMaDJN5wsCybs
221	!dKcbdDATuwwphjRPQP:localhost	$5T30pCSb-0tu3YZkKrKi8jnZp9Uoy2ravJfDd2X16_0
228	!kmbTYjjsDRDHGgVqUP:localhost	$0W2TmFo0Va3v1is4d5QJZQZtghMvBDtTi_4wpoAdOXg
229	!dKcbdDATuwwphjRPQP:localhost	$37C6gs50fW9iP5lMlSV8nT2XSya064EZrJlaa2muiTs
230	!kmbTYjjsDRDHGgVqUP:localhost	$JBH7PSZFqS37yNeW7QwhiyF8hUnPDkJsv9xeMt4J6PI
231	!kmbTYjjsDRDHGgVqUP:localhost	$27naR92ItDSb4d6cYpsDez0sVGBl0cwFvFB5SwyOWy4
232	!dKcbdDATuwwphjRPQP:localhost	$CnVhO6-tImNZyMglc5Z5TWcxn-96NfGWFN0B_N1dUCA
233	!kmbTYjjsDRDHGgVqUP:localhost	$VFhYAs1n6bT8dFPWBYgtkD9f1vhTOBcItBPGmCXnvzE
234	!kmbTYjjsDRDHGgVqUP:localhost	$HMS_Th38vFRi74B3JXTA69rpMIGmmLeXwmhCgsAEiuI
235	!dKcbdDATuwwphjRPQP:localhost	$zsfDuRl_MGqEO8y0jC7E4LNT8pPls-DPmwLVpSoeTT4
236	!kmbTYjjsDRDHGgVqUP:localhost	$CQOkuHpe9Hs9A55hzzoBJLVHeOPJbFbVUlM20RUg6L8
237	!kmbTYjjsDRDHGgVqUP:localhost	$kZwRpRTYdNRvgtvmpOvuacbCAsnqJQP_-7ZPm4fO2tA
238	!dKcbdDATuwwphjRPQP:localhost	$uw3kmqBZU0lxZxwmMSeC26JMyUZgpMy5RkpRrLagrLk
239	!dKcbdDATuwwphjRPQP:localhost	$yeZHbjrueGxcAOgK48SPHXvt5Owj3KgXcRAhW5IyHCo
240	!kmbTYjjsDRDHGgVqUP:localhost	$Qr_YdPIFqgP3mwlUjmhXALRHhmnR3sOw3OkYVMcN3r0
241	!kmbTYjjsDRDHGgVqUP:localhost	$18IU5mHBYgSq1KW4aEytpEXbtI87lnEJjusP64peV_c
242	!dKcbdDATuwwphjRPQP:localhost	$DDYg8Nys4TjaSrA8MmWjEGT2adYfvl1nKGZiTGJfzS4
243	!kmbTYjjsDRDHGgVqUP:localhost	$KsnEG5GXXianUbu92opCLA28Cd0UOPu_KzoJ90Gjelo
244	!dKcbdDATuwwphjRPQP:localhost	$SfCRKwPjxksewV8ZowkpDyDQdRxKdEpRmrFap6JpG-4
245	!dKcbdDATuwwphjRPQP:localhost	$CvZSa5Q2pxl9J9C8807I0kpwBTvDKUpMj85qVJSAVZo
246	!dKcbdDATuwwphjRPQP:localhost	$yS_KH934Z3E2E35NExzDMpueAMSHr1phfIN1gd-lpKU
247	!kmbTYjjsDRDHGgVqUP:localhost	$tn_mMSdxiwoYGDcWxP27aFtGLBv3cTi32-zhyO4ANJA
248	!dKcbdDATuwwphjRPQP:localhost	$i6kzBKblJVqjJk_5PIH2jt37cxTdkNtuiuUFAJ_d37U
249	!kmbTYjjsDRDHGgVqUP:localhost	$MtfQ2bGSzVvEftqxYFz7z-s3GS7LSDhEVSY7DM6j2_c
250	!dKcbdDATuwwphjRPQP:localhost	$7WTjHD4DTeaKFcCFq8zO_4fkzx7N3jH8hy_-wRBgMng
251	!dKcbdDATuwwphjRPQP:localhost	$H_PkF8UBBDuGziD1hRW6HcJeDCpXlGji-H6CUen1kwI
252	!kmbTYjjsDRDHGgVqUP:localhost	$S2TfMiBMppdgtkLK2b_BCqAKgKJGqg0oCEsgjRfrNwA
253	!dKcbdDATuwwphjRPQP:localhost	$WEwam5Z_026BzpuXUzlUNc6eTZhCWUhJy730_Td3kfk
254	!kmbTYjjsDRDHGgVqUP:localhost	$xhTrxjEw-L03BXFexu_7xSaGXe37M_n_IZ_rX1dpO-E
255	!dKcbdDATuwwphjRPQP:localhost	$S9tlcF9PPGtaEI59yL15N35vVasVBXGyqQqWfkxBxkk
256	!dKcbdDATuwwphjRPQP:localhost	$Xy9BbtBfKTsoFHoubcomXzXu3Oxw_B2z32OzJJC4thA
257	!kmbTYjjsDRDHGgVqUP:localhost	$udc-LLiFAn5p66x5mI7XlsQkzqYSwx3vcE57iaF2KzA
258	!dKcbdDATuwwphjRPQP:localhost	$Q0PSyYHDW7uad1QdfQpgDPwragNrSLq8K0FlJAUMYrQ
259	!kmbTYjjsDRDHGgVqUP:localhost	$3BI5QI8diQv15jZtSKest18wIHm8ekgtfjhio6hjlKM
260	!dKcbdDATuwwphjRPQP:localhost	$vJiivpudEWJl8hAVEvn2z-aTl8pmjHaRRVo_H8CZj6Q
261	!kmbTYjjsDRDHGgVqUP:localhost	$WHwUvyIWyRVEI6f-lwv8v3z8eYleLqmlQnX55fFE0sk
262	!dKcbdDATuwwphjRPQP:localhost	$6INlBRFopEr8U5oyPC08d7E5lhs9hrSm7RmNFXQUBq4
263	!kmbTYjjsDRDHGgVqUP:localhost	$CFRxi-JDSA97DV1hcrHaTofYarPQYU1lHevLnOc7dMQ
264	!kmbTYjjsDRDHGgVqUP:localhost	$B7yUeDblAwPcUtCM4Vvxv7q_EBEZvP6RqsotipPrKDE
265	!dKcbdDATuwwphjRPQP:localhost	$irHFClZVEAzlAtsjct-1MJjEotldPu1Ozkm_NYQrtqI
266	!kmbTYjjsDRDHGgVqUP:localhost	$8cL0dItrpraP5F2cmhITdceIBRXhBvULxV6WzwUt99E
267	!dKcbdDATuwwphjRPQP:localhost	$VdJdZGsjhN1WDg_b3HSQME14AGAatc_tiTZB7QJ7PD4
268	!kmbTYjjsDRDHGgVqUP:localhost	$ro5gYx1Rj5KWI20ad49-sE0-rMbGnb61fZyg14WVwt8
269	!kmbTYjjsDRDHGgVqUP:localhost	$S1onw9lFlZOHGbgN_KsIfyR2ZLh9lw1ujZiEHiZapC0
270	!kmbTYjjsDRDHGgVqUP:localhost	$mP0N_R48Yx7r0aUN2nRioVVtSLvvy7pi3ya-ETppGcs
271	!dKcbdDATuwwphjRPQP:localhost	$qBXrFEx9sV6QLWGBqzLXa3mMUjmBhazGllLtIAAclHo
272	!kmbTYjjsDRDHGgVqUP:localhost	$FNi1M3d0ESEkXAd4NVI7ZLgXe6PVp96CkD0fDy-6sDk
273	!kmbTYjjsDRDHGgVqUP:localhost	$ekP0XEZr1V9h0ai9bfxRsv5oQOzm9G3gAW_2AcIUjrg
274	!kmbTYjjsDRDHGgVqUP:localhost	$Vy9UYj-Sgj2IIaiEi-PDSApj59Yz0QL5rOmTSg0Kw8s
275	!kmbTYjjsDRDHGgVqUP:localhost	$tHxZdJDJhMa7-mYFtmyHYBiDNXrRIWTwL4RQG_gB7-c
276	!dKcbdDATuwwphjRPQP:localhost	$WRJI8gqxz4M-J733Nwgt1hciaz1CtWqiKmttWU1rkwE
277	!dKcbdDATuwwphjRPQP:localhost	$FVLHm8hEbAzmJl1bvBKkDdleTvem2a2ME99uZcjK-PA
278	!dKcbdDATuwwphjRPQP:localhost	$7dkvwekZULq-OjQNvOi5LI67ypnz4CLMbKSttzeO-FI
279	!dKcbdDATuwwphjRPQP:localhost	$QwAobZq6xey4D-6yOm_xg4h6rCKIRUpTqM4HBNroJwE
280	!dKcbdDATuwwphjRPQP:localhost	$3xEI-iU3Teo4B51pXGBbjKxM_DDvYlASNK7W09pHncM
281	!dKcbdDATuwwphjRPQP:localhost	$ETv-B1S-bU8wgS3S1fDdineVdS9YGNq1EMeUPHb6imQ
282	!dKcbdDATuwwphjRPQP:localhost	$GMh4hFLoeDc1Ssk9kdi7yAMIMSZA9zOJYJMC1AJEOKs
283	!dKcbdDATuwwphjRPQP:localhost	$zMfjO64yH55JKcwd-hMCa1P1ARHyAuvBbnPeUiNnS48
284	!kmbTYjjsDRDHGgVqUP:localhost	$5-KkKYPCr68IjD4sKk3rDF6kVYVkDMllW0BFUv7G4Do
285	!kmbTYjjsDRDHGgVqUP:localhost	$sPO_9Od1FvK55Z9_vb0hx3ophiGuLyATo1RKYIEFxHc
286	!dKcbdDATuwwphjRPQP:localhost	$oXLyUPbqiXmRRNovjt9_FJFQLCzMQjPsaism-trtsDw
287	!dKcbdDATuwwphjRPQP:localhost	$7EOMmT1sBVcDB2udDBhhf11Mok_GC9CY-6bxtIKAYpc
288	!kmbTYjjsDRDHGgVqUP:localhost	$-J2tr3j7vfmJ8ZSBAK5AyvQYmP2Byp-7dKfcBg5xHjU
289	!dKcbdDATuwwphjRPQP:localhost	$o0wI9-m-SdyS4UK7_m9_MUd0luWmj6eoXfMg1ieT00g
290	!kmbTYjjsDRDHGgVqUP:localhost	$wEwGnOPXUgG2_4DpqsPrYbSlIM2TnPjdWNDyVbZNE2Y
291	!dKcbdDATuwwphjRPQP:localhost	$oZEGsAxUrYn8R6NS359wZO9T54eXOD-N88ftDK7ZHGU
292	!kmbTYjjsDRDHGgVqUP:localhost	$LN4aYSSVw4GLaWf8g7uzrsw-fHTUyCBwq_-RRgS-MGE
293	!dKcbdDATuwwphjRPQP:localhost	$sY34u-PbOKSI3_z8SIqGfn_2XnO9wqZ_eU1dvGDnRJY
294	!kmbTYjjsDRDHGgVqUP:localhost	$zhfRuogjo-Vq5GM4-f6hyuXBGHx99o9_Nef1KWi2-EM
295	!dKcbdDATuwwphjRPQP:localhost	$3A5iUMUsDMAckTZ_lQ9ZLyQdw7FKGrqWfMMxwAZJCwc
296	!kmbTYjjsDRDHGgVqUP:localhost	$aUCd2uzLS80uiu1DeYrTDp1wAWs7M1ba_4Srm8LLnmU
297	!dKcbdDATuwwphjRPQP:localhost	$zogqtnD68sbYTleQBUL-RkGDpkNmTHar6ilm_2oVnRs
298	!kmbTYjjsDRDHGgVqUP:localhost	$OcjvTopfs1z8zuVgRxn4ynq9LH7z4eQhJnWG0PQ7150
299	!dKcbdDATuwwphjRPQP:localhost	$GcBRlllGdKFvT1pDzY7airMfjuYYNt06vxkQ0BnM6IM
300	!kmbTYjjsDRDHGgVqUP:localhost	$JtjXz-jm6mi5wU33MudkV8ZsCM2V-zduDqeI1xIG254
301	!dKcbdDATuwwphjRPQP:localhost	$6cga7PdI_98v2MEH6Wosfik3Plxt3Ml7GwsUkSFFa00
302	!kmbTYjjsDRDHGgVqUP:localhost	$0BYuX-7BWlMOYXwWp-y_txKwBBorVZzavW6fDuXxUrM
303	!kmbTYjjsDRDHGgVqUP:localhost	$1gF1Jebj6lrrJEF4bT7P_rKyKyoYZfX5iGaLkUtgtI8
304	!dKcbdDATuwwphjRPQP:localhost	$sOnmqvo3Er9yCiTYF5ZDvIitPJyWvdZcXsXWtaYEqHU
305	!kmbTYjjsDRDHGgVqUP:localhost	$rihsrTf6Re_Yo9d-_XE4uuxTnj3-iBKAcYVWAc5deWo
306	!dKcbdDATuwwphjRPQP:localhost	$JE3Egim-VcVGfNztlGkye1CRFS-XRRa_sWKKBj00Y_o
307	!kmbTYjjsDRDHGgVqUP:localhost	$QfJDTmbel89kwJs4Bzi0AaeJEYRVWy4W4WeFniRjMdE
308	!kmbTYjjsDRDHGgVqUP:localhost	$uGMHHx8tymMYkm7WsnvCblTbmFRVSXcXHTZK7A3x3Q4
309	!dKcbdDATuwwphjRPQP:localhost	$EuP89-GoUrHN6kBivlFmc0P0DYcjV0A_X1LJU_CrqRc
310	!kmbTYjjsDRDHGgVqUP:localhost	$5-eIrEUrPzlsYUDryHI5hvc3-at4EZKaFfHXitx0xyM
311	!dKcbdDATuwwphjRPQP:localhost	$70pfcMKsQWT6GCVB7BvHC-lJTT1lTBPazOa6eJgi0Yg
312	!kmbTYjjsDRDHGgVqUP:localhost	$v0yqJdbwrH5opsbTcLmSL5zP9Hl_N2FQhWInLryRHMY
313	!dKcbdDATuwwphjRPQP:localhost	$D9x8lj5eYxC7LlYm8ivzy92Md1bU1igU6EBjZbXkw0I
314	!kmbTYjjsDRDHGgVqUP:localhost	$OQ5Loi04X9R35vC0eL9l3pISVh8ZDRXKuOG_GgFB4vA
315	!dKcbdDATuwwphjRPQP:localhost	$i7uqjrfwoWPwHkG4a99WWSlIYRyyGyUbxqPADGgjXDY
316	!kmbTYjjsDRDHGgVqUP:localhost	$3tp9ppjIKSphzokgNChkUT__AKCklTPU9IGAbyH2fmA
317	!dKcbdDATuwwphjRPQP:localhost	$RkpmpidNG88idz06umOciDHmNFjDhjCbMKOClnIYT7s
318	!dKcbdDATuwwphjRPQP:localhost	$jzU_GZjFiRoc7PPwidBWS8YOdRms-wzsrHJ0476wZz8
319	!kmbTYjjsDRDHGgVqUP:localhost	$vCNa8VNQJJKME53A-IIbJ82J6-cPo7v4kRA5D1AbXlQ
320	!dKcbdDATuwwphjRPQP:localhost	$7qXo9iYitv8MuYo7jtKfxEFpiB9GmddR0bdTqEA3mmc
321	!dKcbdDATuwwphjRPQP:localhost	$OOCwtQCB-nmnnlgQ3ST3ItcIsITOLkC3b4a-WpaJjRg
322	!kmbTYjjsDRDHGgVqUP:localhost	$p6hK4YyEwE7JmNsDZSVZo0_-mIxa8k_eaE508aUG21Y
323	!dKcbdDATuwwphjRPQP:localhost	$tOnPdbn-zYbP5dGLmo-NIlzRcHaYQ93eHhzPARW9jAc
324	!kmbTYjjsDRDHGgVqUP:localhost	$bGRKTABtbhLsFMEvxArMP9SzzVsakkr0CqFgYdZGg98
325	!kmbTYjjsDRDHGgVqUP:localhost	$FBk4rWlItdcv2N45AZ_RJqOfg9On9XXqj-KU8GYEzkw
326	!kmbTYjjsDRDHGgVqUP:localhost	$09Co1_Z3o9rjYOasMecXdIGFoJO_9jgdGOPGXyIqYuo
327	!dKcbdDATuwwphjRPQP:localhost	$-tPH3Usot-icaLc5iLxPet3nHoOxW4Z3DgGAxlWTwqo
328	!kmbTYjjsDRDHGgVqUP:localhost	$qQLOfz-msHlNErviqlt8LIb-21G9N6VolAhgk1tBZkk
329	!kmbTYjjsDRDHGgVqUP:localhost	$lvii911Ihgz5Z5zG0r0Vvhthm1UhosO-8zvJyxK2EqU
330	!kmbTYjjsDRDHGgVqUP:localhost	$O0VDOFsP-wkKpsdltvO9ILH7ok1k_JwIzL4fgTu_Swk
331	!kmbTYjjsDRDHGgVqUP:localhost	$_rJA5XjLKIlwZ6RmjX5Ur_MKKg1gu0BBspg23hZxTaA
332	!dKcbdDATuwwphjRPQP:localhost	$ej1WDcZ85moa4uG0j-uVqjAtm68srtfqNxoxt3jDYRg
333	!dKcbdDATuwwphjRPQP:localhost	$SbRY_d-beIw-ZH77X2TVg3zISRm4CasttzVxtyV5uQ8
334	!dKcbdDATuwwphjRPQP:localhost	$8olR95vxD2mybiNVjwiQHF7nG-Ck6GJRyFTLCsDxZng
335	!dKcbdDATuwwphjRPQP:localhost	$Zomu-_L3OeoI84oQ88W4aMtTaA7K2gxDyH7KcK8PNSQ
336	!kmbTYjjsDRDHGgVqUP:localhost	$3Wg3lWxS-P7ivcROdCHSR_9vsviy3nUeMlAjlv74GFA
337	!kmbTYjjsDRDHGgVqUP:localhost	$_tMIamGUVvekAqkH0Yj7bCvPJQfzeM2JVBhZaBzcLro
338	!dKcbdDATuwwphjRPQP:localhost	$vnP_M3_gxSMNh48KEkWl7QZM7NOQUYiHCtIHpZyO2uM
339	!kmbTYjjsDRDHGgVqUP:localhost	$axz1R5RX7DoPd8ngU6knWd5hWuAHCHCFtBdp02_Yho4
340	!kmbTYjjsDRDHGgVqUP:localhost	$vU6ucv5Cc4paH_7Z6uNkgMjocXGM58hIm-L5FtYUgoU
341	!kmbTYjjsDRDHGgVqUP:localhost	$jUx2lj6j7lLXO3tsyCU4njgK55f706l5Y90kNKf30Es
342	!kmbTYjjsDRDHGgVqUP:localhost	$k7fwKYLwTAsX2j9J-OZclMJ2qUxOytcdTd1WhDF4qHw
343	!dKcbdDATuwwphjRPQP:localhost	$8RWzJ6rJMHz2mOkYiEQf6J5yI_xrXvk-RG8rFtGD6pc
344	!kmbTYjjsDRDHGgVqUP:localhost	$uPX2zgMdaOIDe4u4Ra8dMgjXJk17uyjpWYxNqzdXteY
345	!dKcbdDATuwwphjRPQP:localhost	$OeYHLvn0Av4DC4X0_4T5oc8B0o53LLb2XYabIsVjGcA
346	!dKcbdDATuwwphjRPQP:localhost	$LazFMOeWkd_L7PnmjyL7zSOBxVRcMDY5H9guO35wewY
347	!kmbTYjjsDRDHGgVqUP:localhost	$LlqVh6LdPfWX4yY3EyATYwx8V7k0JSJElh7j2Ep084k
348	!dKcbdDATuwwphjRPQP:localhost	$NyzFkIoK_fNw6neifAzFAo6pOv35UmMNYVAfj3lJz7c
349	!kmbTYjjsDRDHGgVqUP:localhost	$VEMFh0jUEl0n0S8o5C2fGCthEfaJQufcMQzIpF8n7qI
350	!kmbTYjjsDRDHGgVqUP:localhost	$JF5zfIyeUqmUc-k7QRs0FcR1fC-5SSl4NlXtE5xahB4
351	!dKcbdDATuwwphjRPQP:localhost	$I7IRSsaMYytyIiQX1Npzyk-SssTyMGOPAyv9QfvO5ZE
352	!dKcbdDATuwwphjRPQP:localhost	$z_EJ6dWa5CjX2phtq3RYPBiXUrX6s1OIovGcTV9Uh2I
353	!kmbTYjjsDRDHGgVqUP:localhost	$n950ZCLbokhsejgAPiWqIm-elUyFZw520IicwdbyutY
354	!dKcbdDATuwwphjRPQP:localhost	$XLmFhG7KLxexQBNJ9YMfFvGqduyZbn1P-Vy7VwPPXeU
355	!kmbTYjjsDRDHGgVqUP:localhost	$RHUEtyOmmJEwQAVIOcr9x874COU36cTU68qaz-6X_Wk
356	!dKcbdDATuwwphjRPQP:localhost	$7Gg4gNMjR_8xoMiw7DstH8F9c31jtELv59YSrcoPRSM
357	!kmbTYjjsDRDHGgVqUP:localhost	$4maGzdDfkDGXzNh-qs0ycloo4wbJIuka8bFz4H6S8HU
358	!kmbTYjjsDRDHGgVqUP:localhost	$DdokTNzv_hx62xZunQtaASj08oKz1Ra-QgNuyNS8Xxk
359	!kmbTYjjsDRDHGgVqUP:localhost	$lV9ZLm_LY8McexZSBsuirusluj7Z9UPcalafQJyFOf0
360	!kmbTYjjsDRDHGgVqUP:localhost	$bRp4mSu4gDOUl2yvIfF41ocDuhZTFVQ6SyAGYEQyCcs
361	!dKcbdDATuwwphjRPQP:localhost	$0ruVoUZRE1Edh-f7Z0QopPRTCr7L2kEpX8unxgxmfSQ
362	!dKcbdDATuwwphjRPQP:localhost	$hWVSd4FzjwQq7FYDdhFSCgpisb3gxDJ2OAjCjYS6rkg
363	!dKcbdDATuwwphjRPQP:localhost	$OJhJIVnJWjcgl3gc2AqLQK7sy1tKn075fy4E5qUK014
364	!dKcbdDATuwwphjRPQP:localhost	$nsJ2oe7ZtdBtY0V-sJWzGBBDi7tcgH24zUaAdmLjXy4
365	!dKcbdDATuwwphjRPQP:localhost	$XYKCYavbY8FMdUIlSSoqP0likUnTP6uJ0yHoGQCMnWQ
366	!kmbTYjjsDRDHGgVqUP:localhost	$fc-Paa3ZBQU-GAAxH4QWDNrWblQvQ4ddYVzPTPiYV6U
367	!kmbTYjjsDRDHGgVqUP:localhost	$4KgY7ivi_pp1q2tjdk7IWENjs1kzgSRLB29nKbq-UXw
368	!dKcbdDATuwwphjRPQP:localhost	$0EmcDbHM6t0AJ7YKAcphqL8othdZg4dIXSazEHvnCno
369	!kmbTYjjsDRDHGgVqUP:localhost	$EklY0FV28pDgoXqwoQUjAB5wTv33O8RCHRE8k2k6o2c
370	!dKcbdDATuwwphjRPQP:localhost	$ShuNV5AOx3oTjKr3eYjFKvzCZ374R_0vxs2HC21ht-g
371	!dKcbdDATuwwphjRPQP:localhost	$IfK4xyQ_h94nUHneDilGoM0TTwuWFeP5_u_nlRs571U
372	!kmbTYjjsDRDHGgVqUP:localhost	$UTOQTSrmXya3IQYDcRPwNWN1bIv2zQ3YfbaVRy9NQuA
375	!dKcbdDATuwwphjRPQP:localhost	$TbzKCcECXvJAKvBu5GZCTLIGi7Js0b1w9dE6KKZXaKo
402	!dKcbdDATuwwphjRPQP:localhost	$TB59kUPeq9fMVMzC2h_3UnHw2NajiTJEsnRyv3PMK-A
373	!kmbTYjjsDRDHGgVqUP:localhost	$sbDgkkxT05mw8xIVFWyOJtbW9nnehE06Wvxor1z8ms8
377	!kmbTYjjsDRDHGgVqUP:localhost	$72MNMNMOJMJpfLbdNKdm6ZXGr14ukIKdq-fG2OvzOqg
386	!kmbTYjjsDRDHGgVqUP:localhost	$fwk7G5oe7wJgKYMNL4T7DYLNKl3iNM8sMytekVrwaGk
391	!dKcbdDATuwwphjRPQP:localhost	$dHmMlteyHAJ7M-fPLw4ASf2jTrlTIdvTVmaQ5Gag5bo
394	!kmbTYjjsDRDHGgVqUP:localhost	$nALoHqM5KHY4yNdqe5M_FdIfnEBFbhKxcKJSw_SBKnY
395	!dKcbdDATuwwphjRPQP:localhost	$9M9p7sRO17QwOjrnc8Jcx8Es9uZCLBHs-7sWHbmnKbA
374	!dKcbdDATuwwphjRPQP:localhost	$aaPR9QI7az6NxeJ0hSrQxyKzzVyM-rBWODbN9y9rM9Q
379	!kmbTYjjsDRDHGgVqUP:localhost	$XhzyXIYIbI0BfDV1QY4H3b4Wrpy5pJgJsGNZc8P8seg
376	!kmbTYjjsDRDHGgVqUP:localhost	$2-SFwejONuAnI3cUJ4UN3FSzzJjeIWUURtWOJiO2sWo
378	!dKcbdDATuwwphjRPQP:localhost	$LjACIs2QTEZTfukFRb30GQyevcb7EREdVFxoNEgvHSk
393	!dKcbdDATuwwphjRPQP:localhost	$10jIYd3nOoWAzbBpDOg2uLibaMHSMjKGNaCcULPk8aA
397	!kmbTYjjsDRDHGgVqUP:localhost	$ggjIFUeFBT-T7B98_lY4Wm-oBrkln2jwLwqn2oICopQ
398	!kmbTYjjsDRDHGgVqUP:localhost	$ytm_7kYhKNYM3h7ChQh-miFByQ68gRVVrNubvh8NsGs
380	!dKcbdDATuwwphjRPQP:localhost	$EB67Xwo9B0__CxNTvptFIy4e4vG93cmEcHRWbiVSFJU
381	!kmbTYjjsDRDHGgVqUP:localhost	$85g2ma_sFrYS8UbhpRwYEglJLj7xswd8VgNCg787_3E
383	!kmbTYjjsDRDHGgVqUP:localhost	$WPbDUZRE7W6o_O4D0qf40PxoXNWcHrBwx3LxCA_ILaY
382	!dKcbdDATuwwphjRPQP:localhost	$jL60Q94H_SC7S4ZFOWkA4RilDwTMIUci2DyEXyQS_t0
384	!dKcbdDATuwwphjRPQP:localhost	$sPW_-g3Oq09Bq8Rm-TKPTRO4HHOlMXEni0rE18Y01h4
390	!kmbTYjjsDRDHGgVqUP:localhost	$gmdByk3yCSTLhbpo1UBgcqOQHTtUk_zBtpb99Fl8Nkg
392	!kmbTYjjsDRDHGgVqUP:localhost	$sfCKuBp0xKHYt3c8Te0Hbae5DfQsahCC1DSQIc0lelY
385	!dKcbdDATuwwphjRPQP:localhost	$EuTTTqDUMl_auURt0x6EczjhMD0HBOTrdz7tI6_7-sg
389	!kmbTYjjsDRDHGgVqUP:localhost	$Dr4XnDe61j-sW1MbQnDanz90rFAEbZr-iPiME1MS118
387	!kmbTYjjsDRDHGgVqUP:localhost	$lDHVNNZ-lsX4vdZa8nj7leEaKNL779KLayi6mt_m7c0
396	!dKcbdDATuwwphjRPQP:localhost	$3iiKKAnHKDnTkCK5nm2jQph5VGVJLhzMXrBaJE8csig
399	!kmbTYjjsDRDHGgVqUP:localhost	$o7q1GvlLqE1MGsGDPtNZIePjHtWwS437ruaUPZRK2bk
388	!dKcbdDATuwwphjRPQP:localhost	$vQQEmbT6vHhsCEhRZ3VHEzdGvhz6HexKilq7e9p0asE
400	!dKcbdDATuwwphjRPQP:localhost	$ecjMrUduqNL8Ll0DsYW4c0U_UDVderlYKVD5C6YnKm0
401	!dKcbdDATuwwphjRPQP:localhost	$KH8mL_g0ImKfGBaUEImlRqBN2sYA5bpu4y7ibOVDWkc
403	!dKcbdDATuwwphjRPQP:localhost	$DRL_ruBcN_7GJsSKbTuYx5IVcUdfXvN5nfcXEiwUKHM
404	!kmbTYjjsDRDHGgVqUP:localhost	$HUbhrTw971dm3h2Jc2CM4CSvdWBF9oyG6lOc_nkEOMg
405	!kmbTYjjsDRDHGgVqUP:localhost	$PzffL5ctPlnn41OzHT8XZKOqLnZQUlc70SyvYBhdbzA
406	!dKcbdDATuwwphjRPQP:localhost	$JdAK_9HMkFckl7RubcWaHKzz9GaR46IiylfxJe6dB5M
407	!dKcbdDATuwwphjRPQP:localhost	$wd7LGAaOF0CSOBfmfOvfDR0RnfNJr1XEO_KjhnwN35Y
408	!kmbTYjjsDRDHGgVqUP:localhost	$0NuL6ahj3KLYzwtfZv0bjuTuQxl1SXfO2I3cQEGxT1M
409	!dKcbdDATuwwphjRPQP:localhost	$W5ccBz_vmKl3L10y3N8FMg8Vu_vume03Xjg9VxwTwUc
410	!dKcbdDATuwwphjRPQP:localhost	$Eb_1RtIt-TDQ4g8c_FwiGR7-KLqYYlDtt6DK-TFhqdE
411	!kmbTYjjsDRDHGgVqUP:localhost	$09CPa1ssrGMXBaq2jLothC_OBhTaz8KuyPAgaSq_Vfo
412	!dKcbdDATuwwphjRPQP:localhost	$W_ZKfLo1LghRNjXqLQTZtcSnQc9F1B3uA9tT3wjSIKk
413	!kmbTYjjsDRDHGgVqUP:localhost	$8BcqAEpaKHyD5tYjptW8zkdU9oZoiizn0FOo8R_X1uU
414	!dKcbdDATuwwphjRPQP:localhost	$d3jBM4cZNF-fxyQSZHDiocRgdYJryQIBoLDvL1l2ReE
415	!dKcbdDATuwwphjRPQP:localhost	$qcmfM6iZF_FivbmShQc7Be10wvs5yFKoCst_mT4h0ZQ
416	!kmbTYjjsDRDHGgVqUP:localhost	$oK6yyZ3LDQBXojfR6858NGF3_EBUPeZ6s6bPFDko-rg
417	!dKcbdDATuwwphjRPQP:localhost	$us7UJUfRSZa75Mk4RvjFqXW7ZSiVSgSVbHes0NJnsm8
418	!kmbTYjjsDRDHGgVqUP:localhost	$L2CF2b_N1cdbODElwdbDKdJytXbnrAHud7LV3VfwYuY
419	!kmbTYjjsDRDHGgVqUP:localhost	$CzCq6IOQZPom2jFaLARrGdPzD1b1fsfHACQxoXupg6c
420	!kmbTYjjsDRDHGgVqUP:localhost	$x_qTungzcVo-XLbXK2XYh8vu_ETbIr4L0G0l7-e1_A8
421	!dKcbdDATuwwphjRPQP:localhost	$d9QtJzWYbJwABqtyXUTMkdTU8f2KqZoesw5BKJJYNdg
422	!kmbTYjjsDRDHGgVqUP:localhost	$dRFLKViRUwbAtE9azsvLTdKpA8vzlNl2nNFeJqDIALE
423	!kmbTYjjsDRDHGgVqUP:localhost	$vRgQkKWTs6m5YEZhozlW0rO7bg73LHY99hA8mSK-uDM
424	!dKcbdDATuwwphjRPQP:localhost	$SGd3agqt_4slNnQVH_j1vEIDvn0MhN0_py4wTsm1vWM
425	!dKcbdDATuwwphjRPQP:localhost	$JH9SpWERJ8lWYD0r3HEZNrTwXJVX0ePWcqoe9E4E-o0
426	!kmbTYjjsDRDHGgVqUP:localhost	$TZcR5wrmvVeJlMhmGbxIbT3LZWMZvL2NlOjHM1waUIY
427	!dKcbdDATuwwphjRPQP:localhost	$S0mWidQfgfDr7V5rnTUgx-nTETonw1ZcuTJa_rCf-eQ
428	!kmbTYjjsDRDHGgVqUP:localhost	$DTif-rsb3d__3bEYvui9CRTDJmjOLv_FVPQ_nZpy-90
429	!dKcbdDATuwwphjRPQP:localhost	$SGg7s0Y8UmqzJ-01PY5BIOyGoG8kO95u5M79aZhEoyU
430	!dKcbdDATuwwphjRPQP:localhost	$61HZ9wQtDblchyUfvO7GkLWZ6GFf54LXCRlXYSbVx8I
431	!kmbTYjjsDRDHGgVqUP:localhost	$WA12r461P-fcjgPwgJEuWncCBDN5T8VPxXsGf8jyMck
432	!kmbTYjjsDRDHGgVqUP:localhost	$NyHVtTb3hztQACpz9Mu_KhJoF_sbcYVcnjN8F93QB50
433	!kmbTYjjsDRDHGgVqUP:localhost	$a2MOPpDlfH_FMlQzUUyAroPyqcnmYz21Kux51FRs7ig
434	!kmbTYjjsDRDHGgVqUP:localhost	$Ssd-M-q4m9GIqXCJpEW-EvWyuTXN4XIwF2EfkWc9oXA
435	!dKcbdDATuwwphjRPQP:localhost	$OOrnuO3vDVvaHrprXPFSQ0xTCDTZUB13mIODas8XFis
436	!kmbTYjjsDRDHGgVqUP:localhost	$xT9Ixe2nFmDBeDwJ55xqZO913q6UfWT0RUkVRGJp72U
437	!dKcbdDATuwwphjRPQP:localhost	$zuoJFxKkFL2e0H3uO9BuLOnP0_k_gwEjRFIIMDkTnwg
438	!dKcbdDATuwwphjRPQP:localhost	$KDyJWEkBHEkPPTerz9twJWKT_9V-mC3A7R0PBAXa75U
439	!dKcbdDATuwwphjRPQP:localhost	$fC1kaZtB2P7NsWjrbPepbh6YOIgVtKQe9vtRGGMtfCw
440	!kmbTYjjsDRDHGgVqUP:localhost	$9HZaZSAdLNNBJ6dhsHoDOs67ocENoOuT9M31GNpRzx0
441	!kmbTYjjsDRDHGgVqUP:localhost	$VrnWOG54hY63XUAF8DR2_LFZKsk67ByEZEuujmbVZCE
442	!dKcbdDATuwwphjRPQP:localhost	$9VcIVZ_KlecrcPb6T9zwwD4d602v2JhWBF-8B1vIXuA
443	!dKcbdDATuwwphjRPQP:localhost	$D0ZghNxCKHs1WeshpFAYFct436KSb45fbLG3iK_LsWk
444	!kmbTYjjsDRDHGgVqUP:localhost	$rWkaayUh7dEGMWDtBkP55-D8nUWWkYx84jyXAfQ9rGY
445	!dKcbdDATuwwphjRPQP:localhost	$2zdGcjhdpvWexvQBAXhtc2qCUxMbkWcAOSNwWx5q5-Y
446	!kmbTYjjsDRDHGgVqUP:localhost	$QVZ8miaQNT17DFvuFo-5hwdVcvcBNTWFWYnS6YAwPQQ
447	!dKcbdDATuwwphjRPQP:localhost	$tCDcEnIWBlHO2Bk3FcZu5LD4FbZHGdTT6bT64Jm4nxY
448	!dKcbdDATuwwphjRPQP:localhost	$AWgeP69lNesoFPAXIiLB55_FF5g5oZ14-G21OM_7nCA
449	!kmbTYjjsDRDHGgVqUP:localhost	$s-wR1xTx431_dFIuH09ToEemQR-3cRJ2A7iXdh_BZSM
450	!dKcbdDATuwwphjRPQP:localhost	$XeO0jeC-JqH6IirxAA7GhRykff-nCQd9ZdPmw0rYqO0
451	!kmbTYjjsDRDHGgVqUP:localhost	$tJfEgEcTpuLPRjALnAQ_7SDOnXaHW1Qo-jkydii_svU
452	!dKcbdDATuwwphjRPQP:localhost	$9Y6ERhKcLWTziauuSjGcL2pZbsX-gvHH8b2FWKHNEpM
453	!kmbTYjjsDRDHGgVqUP:localhost	$prv8wRWboyKg5RimYh5r_KU1jxyz_5aIQ7eI3DXxFG4
454	!dKcbdDATuwwphjRPQP:localhost	$G8yO18PUxaUxRUVFt7Kf5W6rPNtinioGl08LgsOGnnk
455	!kmbTYjjsDRDHGgVqUP:localhost	$6qFli1GjCq4ySbEkosg6b8_DYLYYU6ejDC_GKxsyfCk
456	!kmbTYjjsDRDHGgVqUP:localhost	$0Rbu4rYP6VrLeEIzHZt8cr2E_ba7QIIm9rtIF64IbG4
457	!dKcbdDATuwwphjRPQP:localhost	$nq2Ga1ROWQgNS_rTIBG3Uec83dfxLJ9wWmxVDO_gzoU
458	!kmbTYjjsDRDHGgVqUP:localhost	$IlGIbDmBApxvbudqjQDjacxH1HJ_nANWpCR_jGMnaX8
459	!kmbTYjjsDRDHGgVqUP:localhost	$wcHCvTlfoNnT0kXHhKawclQkP26yEKrtmdpCB_BXZfw
460	!dKcbdDATuwwphjRPQP:localhost	$uBonPofxIODliJYWY8UJqh6nPKSInZdsP201RUI-KNQ
461	!dKcbdDATuwwphjRPQP:localhost	$MJyky96kmCEU8SCkFezNmzeJfochqsJK34BxMU6TniI
462	!kmbTYjjsDRDHGgVqUP:localhost	$GblkUHRMFe7oYsXjLTI9yBDNmabbym_RN9GCSdsIoTQ
463	!kmbTYjjsDRDHGgVqUP:localhost	$SaXJCnbF-Ds9_RHxRzckFPJJnNLOvTdE4dcDxLq5dU4
464	!dKcbdDATuwwphjRPQP:localhost	$Oqud96ogIYnUb9KAzeYU3iBdb7IhGh1bo9RbUHp0IwM
465	!dKcbdDATuwwphjRPQP:localhost	$-MQM4yGJFL2Ko8_qVFBNvkTUhJ6kBmAjV--HFXu-_jI
466	!kmbTYjjsDRDHGgVqUP:localhost	$DKx-REzWoWm8KLVrhlQXKakLuysOzmBtT_pyw9gnyd8
467	!dKcbdDATuwwphjRPQP:localhost	$QZ7kkmlx7bpP4XazSlFLqPC2zaffnw8rHHmgyY6hPbg
468	!kmbTYjjsDRDHGgVqUP:localhost	$lRAE2QoZQPvRdkxhAjhhKTo18yoKuJAdX4qqWKz_Qhc
469	!dKcbdDATuwwphjRPQP:localhost	$0MB5wm2nphx2aBdrmRGG8spNBcGv6gqoFyOsz4iJHXY
470	!dKcbdDATuwwphjRPQP:localhost	$lNUJ-zWb94UwFGvQjOdf_jJVTcqfnJGz7ZWkj-xf-H0
477	!kmbTYjjsDRDHGgVqUP:localhost	$f2qNeq8kJS-6DLl26udXJ_sn5M-HZvx11scn96_z5Yk
485	!kmbTYjjsDRDHGgVqUP:localhost	$dQWmE-jkGYbvp0jt2GTSchkQCkSSsbswKEF4LBKqyOI
498	!kmbTYjjsDRDHGgVqUP:localhost	$ghQbZw0R73ClJHhLJQ2zXreV1fswMzWZ6TaGdVG1Aqs
503	!dKcbdDATuwwphjRPQP:localhost	$enj8rtyWWFRv61yE6d6u4slKuz_GO3WvmICufaAwfd4
471	!kmbTYjjsDRDHGgVqUP:localhost	$p9zGSGKifE8WvFDCL0xvtyfSKCaeAwyaODxB3DACd-M
480	!kmbTYjjsDRDHGgVqUP:localhost	$eGFd-BWvdiDzygSwJeSmBQg4se0Cu_yRXbnMhePmJhU
486	!dKcbdDATuwwphjRPQP:localhost	$u0KqDu7x3Jzq4x-a44wRP02_zIIpUyl_snxSKZlD1Ic
504	!kmbTYjjsDRDHGgVqUP:localhost	$cnYmAn0a7fuY0jmLK98n7aMM0oYQFJme42KEIhHQ3oA
508	!kmbTYjjsDRDHGgVqUP:localhost	$TX59oLP4qE79DxjV4lGKyBYUiNh8FX_bBZlKMJYhwMM
472	!dKcbdDATuwwphjRPQP:localhost	$MBrLuCxLlOJVZn8_BDZg1ZQTx1kHYvhpbU4lIxYJrb0
484	!kmbTYjjsDRDHGgVqUP:localhost	$U7uZK-uA7B4fZW-kMj_GMxqNyGl4qs4_5IzTKD7DOtI
487	!dKcbdDATuwwphjRPQP:localhost	$ClXRZZJSaVHbkdE5uZ5oQ8vCHGAIUsp8wDLfbEOHnn4
510	!kmbTYjjsDRDHGgVqUP:localhost	$JvdqK8VfvaBY1eQB8ZEIlEbbMfhmSwStPB2MlR1FbHs
473	!kmbTYjjsDRDHGgVqUP:localhost	$I9SdOHxtOnKn8jlQA-ZjcH78oyxvvbtTP7TNOeZnrTY
474	!kmbTYjjsDRDHGgVqUP:localhost	$VswkgkFlrClg-nxeZ_HKhNDqOfq4EgUhrmdgjnliB2U
475	!dKcbdDATuwwphjRPQP:localhost	$-5rKfd1WFww2s18N8R4HeN46aDuGoRN7m5xyoAfT4eg
489	!dKcbdDATuwwphjRPQP:localhost	$aFn-r0lCD82RXxVu7G2_BAZHR2YruiexBYN1T5JnVuw
476	!kmbTYjjsDRDHGgVqUP:localhost	$ZzypG4NqvNlt7yKSi1RFCFSBGsaKEkwX3hQL68sMBc4
479	!dKcbdDATuwwphjRPQP:localhost	$Vqg411aP1zv11R3fh1vwtXv53dXGERcHYEGGeNxEhDw
497	!dKcbdDATuwwphjRPQP:localhost	$62l9uliphlswtBwFjIj5gHhhfUBVNseN6iXPO-snARg
505	!dKcbdDATuwwphjRPQP:localhost	$ozNTg0BAgNk-GyVjMPWjzJmUre-TmGrCQZyUjLXrj08
507	!kmbTYjjsDRDHGgVqUP:localhost	$aRKwkfOkiRwi9BePZkAZyiVBC9DdLIasMBhvTV-L2w4
478	!dKcbdDATuwwphjRPQP:localhost	$gDfjyO6nr_S_h5FC2UM-NHn4ypFpvSjNfjWdJ9QdBTA
481	!dKcbdDATuwwphjRPQP:localhost	$RFJMql8obfWqlXMyTvfAVBcomE-a4HOQXLobJOFOb5E
482	!dKcbdDATuwwphjRPQP:localhost	$BnB3gKRZaWDJEXVdAvF7-R5pYXhhcQLAapfU0YVSgbQ
499	!dKcbdDATuwwphjRPQP:localhost	$2vpHnomRZoScF5x3jqFy3rBMpqOxOmRRI_x7uervmtM
501	!dKcbdDATuwwphjRPQP:localhost	$mdoOoW7DzjYMWsAFGSAP5FTFaA8VOnucNvqH4XOwl9U
483	!dKcbdDATuwwphjRPQP:localhost	$OWvaccBnDZb5TahnEJQ0kVaKwlrQfjAV_h5RLC9xNzo
491	!kmbTYjjsDRDHGgVqUP:localhost	$a7f6ue-IQWTlSmIt8hi2TLEgauUbPCtd9P72c7Uy6fw
495	!kmbTYjjsDRDHGgVqUP:localhost	$bdy9bUgqbt-lsY2GPZJQgurUsX7QbyVlDyUAyiVX1xU
488	!kmbTYjjsDRDHGgVqUP:localhost	$JJ-uvHjgXrjtkBZlICoac-RLB2UhyWLuINjtQepV8Ys
490	!kmbTYjjsDRDHGgVqUP:localhost	$QeLHDsaKpuVVOa1isgQpT-21R4GWBJF6fd2IDfQJi3U
493	!kmbTYjjsDRDHGgVqUP:localhost	$KCzw0ZYpjmxSYpBg-VWijOLJoDaO3ORJGcygSJgDKU4
492	!kmbTYjjsDRDHGgVqUP:localhost	$EHSmZq5rfXOGj9UinA--ZLHE3x7sLgpBD0dOdS4zcJ4
496	!dKcbdDATuwwphjRPQP:localhost	$LJiv1uvKCdUrUDRy1pCHkSS9kLFSTSh6zv_uuWwW7FU
500	!dKcbdDATuwwphjRPQP:localhost	$52zIBRKBNFz27FXuUOS3JvkSVWkE_UdZ3Bzh7CbDdV4
509	!kmbTYjjsDRDHGgVqUP:localhost	$rvX3gusrqDnQXFdKLk99OwB-6ONPZZ4E_ccmjiMx95s
494	!dKcbdDATuwwphjRPQP:localhost	$BFG066DaOscAxNTNKtTAjWIMqsj9y-BO3kpSOh_nllA
502	!kmbTYjjsDRDHGgVqUP:localhost	$cmpNWgb1YoE_kPOBNRGJOwXucztLwH0-LigpF5B5Cw0
506	!dKcbdDATuwwphjRPQP:localhost	$YN9SLoJL97SWXJLt8ahCEKIViygmiF5sifNLasdkE9U
511	!kmbTYjjsDRDHGgVqUP:localhost	$2euvkqBoo-5Se-C3uCUz1J3OyjFQZWT1Koc4f8cNMIs
512	!dKcbdDATuwwphjRPQP:localhost	$8kwA3m4GxTPFmmz3pyc4YhMGi7mHW1Sr_CDY0tWUHvE
513	!kmbTYjjsDRDHGgVqUP:localhost	$-Lz8wuqRJCdSnH1sYYHg_FThOxKhm1ZBz1p09Vl3R6s
514	!dKcbdDATuwwphjRPQP:localhost	$zlQGIgQpBJYxe4nMh9GU7u1XS2J1F-yvmVGkCPfVVJ0
515	!kmbTYjjsDRDHGgVqUP:localhost	$MHC_bSsV1nkcbVymfrMbdD9lgLcEhSetUO89LQUWLE0
516	!kmbTYjjsDRDHGgVqUP:localhost	$IGpAkCtT6EbruRQaXyXZGdNVxYZoFB-4FECiYEFDcQA
517	!dKcbdDATuwwphjRPQP:localhost	$h3U4sZG2Tz2kLNL06VfiingI2IHffskMfI2nVYq5sls
518	!kmbTYjjsDRDHGgVqUP:localhost	$_cnOvxhROPVlPyNwBk_DDBKKMmhLgPZh1tKZfmYE57s
519	!kmbTYjjsDRDHGgVqUP:localhost	$JyUNIV-7E-90HsZWK_Szi0jZh877QsFxQx5eEJGUAE4
520	!kmbTYjjsDRDHGgVqUP:localhost	$IogelUAIfoT5Uj8qJoZyjAk-T8AFDm4otPGjVQHTTl0
521	!dKcbdDATuwwphjRPQP:localhost	$iZjPPnxWfT1tbN6uQf7-Ws6PyF_CNvE6aqiekjkmBZQ
522	!kmbTYjjsDRDHGgVqUP:localhost	$AlvunJEAuOs0u3PW8U0UhbaWs5PtbsFMH-JZg06ue1I
523	!dKcbdDATuwwphjRPQP:localhost	$mnzmZb-5pMKIBehkoM4Up5s6CAaUPAgwbAioGAaeYFk
524	!kmbTYjjsDRDHGgVqUP:localhost	$kHMKyilo507mTTpEyCsYwdC5oz2F3gauHSjD9rjLizI
525	!dKcbdDATuwwphjRPQP:localhost	$y_oAfIf4VVmmJBsVBWkaHzmaKd31UzdCNg_QSdAoqKk
526	!dKcbdDATuwwphjRPQP:localhost	$N-L5BbodB5yNVZ_5M4CMFQ8mYX8-DxCbzgqZjFPHwBU
527	!dKcbdDATuwwphjRPQP:localhost	$U1pPxZshFnhejiWqv0te9NmAXH_Wj7x4SZSpcIauJdo
528	!dKcbdDATuwwphjRPQP:localhost	$-i9tF16cca5QefwQT9ENErpZLdPQyz2FGCyQ6xiSFvQ
529	!kmbTYjjsDRDHGgVqUP:localhost	$Rzgc0MTRG4UvzvggNFKyHS0ttYkAxUnPOXp0IOEWzaE
530	!dKcbdDATuwwphjRPQP:localhost	$15LQu--UlzP7slpkxTjFebd3TyX_NNuRrFnz2MyGDSY
531	!kmbTYjjsDRDHGgVqUP:localhost	$un98C3VuIkdOqy-ZpPAU6ESf5Hu6h9lyqwJLKLRfYxE
532	!dKcbdDATuwwphjRPQP:localhost	$NA5jh2sxaEK6AI9VCvigrp4rXMsUGKxVYTmKzQ_EmZE
533	!kmbTYjjsDRDHGgVqUP:localhost	$ySG0pne3vb0dSrjfqVp7lMC9nNmUIg1j8T_EHsC_occ
534	!kmbTYjjsDRDHGgVqUP:localhost	$f3mP5rbfx77GEZ1ex_9z-Q5RkbQWLKkKrzRGEW33_5I
535	!dKcbdDATuwwphjRPQP:localhost	$rwLyRy-Ep7NjiRW5yMKmLJaYo5G5-Wx6fjlIOjws0o0
536	!kmbTYjjsDRDHGgVqUP:localhost	$-z22_1xeqTtF-NfNRJZiTt3UNsrRIRCOnOcb9zTLyi8
537	!dKcbdDATuwwphjRPQP:localhost	$qH58hytg0VY3tyB88lyc4f5dEjRDyzrcuJ_OBDt4zCQ
538	!kmbTYjjsDRDHGgVqUP:localhost	$w7-WZhppk1n53KlG2SBxC9oQM1zIAkBJpwbTJgCI3yE
539	!kmbTYjjsDRDHGgVqUP:localhost	$I1OlU4-Jd9iheZktatb8ncX7UIehBPRQuLVEkQLq6eQ
540	!dKcbdDATuwwphjRPQP:localhost	$I0SzUqlGHolINXZh1_OsQRrw8fm9UpXHpjp6Fbfv6lg
541	!kmbTYjjsDRDHGgVqUP:localhost	$nqmaMbEnfjWVtSbvlKW4o7eZnWxOTdattqflmI2Dz4E
542	!dKcbdDATuwwphjRPQP:localhost	$xKDLXulWL6oH4yQNT7BRcSufORWKmtPNKxe_KTDfhNE
543	!kmbTYjjsDRDHGgVqUP:localhost	$nf2tBPUZEy-tdpLfZk0l8y95_PkCtd_Xn1O8JvWlMiQ
544	!dKcbdDATuwwphjRPQP:localhost	$wpJVJPW3YAQFskoIOf9FDnUHZkw0GB0gpHlZ8VKnjRo
545	!dKcbdDATuwwphjRPQP:localhost	$NyNSSjPuFAc8Wva-4-jFz_gs3wZyVwmgs4kLLY7Q08A
546	!dKcbdDATuwwphjRPQP:localhost	$bGBza7hC6tPQtLzY9coBj0Ba7r0GYrTVrKzPIevSm4Q
547	!dKcbdDATuwwphjRPQP:localhost	$AEL5KHgC4K46g44AdP-MpoE0tKm80Op1sOYoa2q0--E
548	!kmbTYjjsDRDHGgVqUP:localhost	$XTivchOOE5kcp_aBg3s1BZpfgzhyUwNOxLGwesl9Ty8
549	!kmbTYjjsDRDHGgVqUP:localhost	$qLj34jfenRtAfS39lAC8U4xuV1-sDS5GfL1TsZ1eBCE
550	!dKcbdDATuwwphjRPQP:localhost	$m2B29qfe8-9HIcYydkugLkN_jyjWIol0wRAmY1umdec
551	!dKcbdDATuwwphjRPQP:localhost	$ySRpVvBzAq-6qpIb-vrt64FJ6tylzAmtweTbdVvornM
552	!kmbTYjjsDRDHGgVqUP:localhost	$8cbJPQts7_sZrpogcM_6HMDpcd2T1hftkvqzYpmcyK4
553	!dKcbdDATuwwphjRPQP:localhost	$5t3TZM4PRMSlVNtVfL2yw0FxlBFyuJAKNgyYiezevS8
554	!kmbTYjjsDRDHGgVqUP:localhost	$LjBXXM8TvGp-81bJZOLGG1QfRpXTpoopDbkeo9t5JHE
555	!dKcbdDATuwwphjRPQP:localhost	$XjFmayQxxagMkdrVYXnk-IOUM_o647ezTHfMR83l_l8
556	!dKcbdDATuwwphjRPQP:localhost	$GOzmpW_FtFYxLRMiDR4ZcyGGnoib8nMAm_WThLHUu0M
557	!kmbTYjjsDRDHGgVqUP:localhost	$-SJLQQer6Yp4ND2ivOIUhLg9ANNd2e64s5_vg59I1P0
558	!dKcbdDATuwwphjRPQP:localhost	$qey2Z6FhJfa0XblMvawZ6JzKmPfVKNjxrI_oBx__AQI
559	!kmbTYjjsDRDHGgVqUP:localhost	$E40vibb53bhbZsaYld4CEPJuNqA9rl-I-Ct7pY6GsJQ
560	!dKcbdDATuwwphjRPQP:localhost	$qfZ0R-D0FDX18kcRs_QXfmnUx3Eia_FNg4yCX1mLfUE
561	!kmbTYjjsDRDHGgVqUP:localhost	$VZjcWglE8Uq2ppUM4Nooj3Uy2z35rJQoEi-mN5-kXD8
562	!dKcbdDATuwwphjRPQP:localhost	$v4t0ITuTVaBXUal1SIkCMfnlciT0LD0yKjPiAUikLfg
563	!kmbTYjjsDRDHGgVqUP:localhost	$OXA-i5O4kK6mFbSehE34ELwd4F6TvBIbudZk39gjuVM
564	!kmbTYjjsDRDHGgVqUP:localhost	$-Zgjet3Ry8bCf5xcR0_rQpYHrfrQ-r79fBEB3Ci6cW8
565	!kmbTYjjsDRDHGgVqUP:localhost	$DG7otHaC6Q0yXMuof02fylRDdBrW94MSdFGX3d_RSVk
566	!dKcbdDATuwwphjRPQP:localhost	$ENiOGIetrXiD9dNYRr37p7CHxry_RybUV9xS7-r4jNo
567	!kmbTYjjsDRDHGgVqUP:localhost	$i1N_vrkfViG9CpIwLEZuAkQ0YhvlZH5FUGnGMkCFnws
568	!dKcbdDATuwwphjRPQP:localhost	$cwA2NlggcJqc6qbAZ1hfLB9vcOzJJZYe0PqnxVYTsiE
569	!dKcbdDATuwwphjRPQP:localhost	$XsHcL0PpeW4eMnD_IXp8EUx4bmwTECx_HRQaOlw9loY
570	!kmbTYjjsDRDHGgVqUP:localhost	$lDAKu7bbYALsXyPjCkjIgDf6rLmFnL852FCpsq08d6s
571	!dKcbdDATuwwphjRPQP:localhost	$FdXdayj7PXCKIxAhmxPcyyzDShahbDfQvNFDVf9Dy9s
572	!kmbTYjjsDRDHGgVqUP:localhost	$GVBEyaMnb9ufXlkz9mrJ8GaAFNt3eQH2r8nsyM-2E0g
573	!dKcbdDATuwwphjRPQP:localhost	$ApJGq9HwQEvCzlj2czu-3wQsjE26U2o0JgAOFBkGWWQ
574	!dKcbdDATuwwphjRPQP:localhost	$oIkCp2HvySKXBd4ncBsNUVh9xNwZfmfJbi9vvGzOGCs
575	!kmbTYjjsDRDHGgVqUP:localhost	$YxaiVYBwPweg-q1aScBHb3CoJ5uBKn9eEjhA8b8evIo
576	!dKcbdDATuwwphjRPQP:localhost	$54GMUmgObr7bD-r2TpujmAWNmZ3939AEiBpC49Azcx0
577	!kmbTYjjsDRDHGgVqUP:localhost	$YV3VDHUq9_uS4qKdz4DFH_mxMsioA0jwNUaWpqyyqmc
578	!dKcbdDATuwwphjRPQP:localhost	$w4DtFAcI9KL6d1Dn086_AlWa68a5kp_R8esFkDqn_uY
582	!kmbTYjjsDRDHGgVqUP:localhost	$Q4IpS6AgYYBl49yKAzoZONVBc4AePJH28XZIDvwemW4
586	!dKcbdDATuwwphjRPQP:localhost	$JKL35Ziedumo9YkS5xQLCrXMhb1otb3ah_SrcYK83T0
602	!dKcbdDATuwwphjRPQP:localhost	$Msi7QI0P9bOYl-mueqETBjTaDzxhpTDBuS9Q51p3xxk
579	!kmbTYjjsDRDHGgVqUP:localhost	$tFcocm2695F9c4ggKiFGJlKGSjnTHZ1C00GW7evyPyM
595	!kmbTYjjsDRDHGgVqUP:localhost	$LVDg_BEZV5UjiYDpF0nA_45ovAApomSL3Vcwo75CnrI
600	!kmbTYjjsDRDHGgVqUP:localhost	$e1vZycRzMYXgVF9HnnladMauaR2ZxVITcoKX_s4r5R8
580	!kmbTYjjsDRDHGgVqUP:localhost	$lFi7p-KDrRWUZOY7Wa7dNPlFJ9te5UB6pVudiJVT2Xs
598	!dKcbdDATuwwphjRPQP:localhost	$m9OqM5FueA6VVXTwyBzpPbtVxcerNbo1y17hTiCbCkM
607	!dKcbdDATuwwphjRPQP:localhost	$5jLnuqj1_MkORFXdLdGwHs_kpEGnPfxTVduvX43AYMM
613	!dKcbdDATuwwphjRPQP:localhost	$v1q1pLUpcF9FtODtIhrqmaMmkQJe-psTNuyZY729EsU
617	!kmbTYjjsDRDHGgVqUP:localhost	$nT58-ZovJGWWWIbxLj2PVipgWNpyo_WVq_brhpXgPcI
581	!dKcbdDATuwwphjRPQP:localhost	$JMD2hW0GmqizTDu6OSGq0NRVfGXJ8kC3B7MfTzNY3bw
585	!kmbTYjjsDRDHGgVqUP:localhost	$NcAOsbTmBKlooLu53iabLHTfcwifGnS1iCQQ5nci7VI
588	!kmbTYjjsDRDHGgVqUP:localhost	$zwZnmNpx_8m1rcP1ZIfiTX-Pkg8t_3jglCmO_hv7sZg
599	!kmbTYjjsDRDHGgVqUP:localhost	$9ph2mJGJmaRE1tuAAvzpHdAK9Jv5oc9Qdv2sisnHgZo
601	!kmbTYjjsDRDHGgVqUP:localhost	$kty88hNLAm-8zGwD61qKomt26JLkX0EUnxjZzFA7Xl8
608	!dKcbdDATuwwphjRPQP:localhost	$RoFjDEA4aEGEUNiThEe25rytmMeJaqM9Po9ROTcc148
610	!kmbTYjjsDRDHGgVqUP:localhost	$cZ7UK1RI9NmK4Kx6wwDSpN-aIuQnaVkkrJgV011A-8Y
618	!kmbTYjjsDRDHGgVqUP:localhost	$DbxXGBcEN1Z90Alfx1MbJRXUD43jlhLyiIyjnICfpkA
583	!kmbTYjjsDRDHGgVqUP:localhost	$rS6uG4cUMYWOg-9IaPPF3t8syXWs0rhp3VNCM7W0BVQ
589	!dKcbdDATuwwphjRPQP:localhost	$CRNgIVz2veDUIh5gSOe2-OD7WUBJMOqMNAb71DhjYog
592	!dKcbdDATuwwphjRPQP:localhost	$Rz1ZYTvHOHrMy0YSxy0FBcU4D1cuSlmH88IqPZeUKFo
596	!dKcbdDATuwwphjRPQP:localhost	$zHjYI34TZQyibyBPDDY9Mv9n6Fsa5NjmoRkyUFrQ2FI
605	!dKcbdDATuwwphjRPQP:localhost	$6nFmpd3GRMLlwYD2Cd4zmXryvoiQkCOE7xzwuSmpRfg
606	!kmbTYjjsDRDHGgVqUP:localhost	$BQy0h1wP4N2NoJo7HNFLbfFplA-rtt-60AebMMpLtVo
612	!kmbTYjjsDRDHGgVqUP:localhost	$Cvz4iCL9o5DjT60ms1Plfnc4RHgvVxTvcLMuxKM9Bbo
614	!kmbTYjjsDRDHGgVqUP:localhost	$B0w5MzdFfo8BqklgpvftRkjRWY9ezuIRKeDbJkjE6hk
584	!dKcbdDATuwwphjRPQP:localhost	$Yf7uCfrVtbbut1hqURI2hWHV9SSNPwb1X-UU7ctqjRw
590	!kmbTYjjsDRDHGgVqUP:localhost	$A6TExYel0mXgPEmcyWTrKx9E2hg4mzb9Ea7Fxc_Mmek
603	!kmbTYjjsDRDHGgVqUP:localhost	$PemXval2WB_UcOzSkvRa8XBxQhziB0T-5OU6hhyy9n4
587	!dKcbdDATuwwphjRPQP:localhost	$vUjH7nYVmvP1N8143hN9tF3wRQM4vGvtzVSZLcxs4Wg
591	!dKcbdDATuwwphjRPQP:localhost	$9yTbHjjGO9dCCvOY65cKS72QeeapJN8lrb66e3oDcrI
594	!dKcbdDATuwwphjRPQP:localhost	$HrBuMWW-0L1kbXPhjJaJY6R2mxhbQ9-8k6nDIDEJZFc
597	!kmbTYjjsDRDHGgVqUP:localhost	$FIk1P5eHNDJI1-dgl69HghS87I1TEPPXXIYyVXapDw4
609	!dKcbdDATuwwphjRPQP:localhost	$txmKSuer004FEeE2Js2o1-RO99aP4d0O-5OIdYVRzx0
616	!kmbTYjjsDRDHGgVqUP:localhost	$iIMbKgKocIHCdd3LwQK-YCgWeadL0zTgotmz_zKf_UI
593	!kmbTYjjsDRDHGgVqUP:localhost	$a2EKZ1cUTbm23hsjfsT5H64tnUBN87TGW72kJVfqXzg
615	!dKcbdDATuwwphjRPQP:localhost	$XyhWiMEqqEd7rFkH3igAWls82YtbN_1KCcEN7ow8uqw
604	!dKcbdDATuwwphjRPQP:localhost	$W9Sz9QWe7L0y7MlR2Az5bNpk5llGHj9o9o9ZqutFBBY
611	!dKcbdDATuwwphjRPQP:localhost	$iD7NYRKK1pbdxxz4UqGjEPD1ES466eCmqAtLmXLzDNo
619	!dKcbdDATuwwphjRPQP:localhost	$OpdCgf8grfcfhpiLFYZWJ7XrYNXOYENOe7sSHNgpRpU
620	!kmbTYjjsDRDHGgVqUP:localhost	$kwnB4q_YqjfJ_AGkjfTK-jZ111jTT-U4010xX-T4LuE
621	!kmbTYjjsDRDHGgVqUP:localhost	$Q6xUKfK76DxzNPj-kEJMqQrAHOFFkNCZwRKWTDEbYJk
622	!dKcbdDATuwwphjRPQP:localhost	$3_ErZSbMyFbau0rYcASpZEgrWCzcm0AlUvj52ogJAMo
623	!kmbTYjjsDRDHGgVqUP:localhost	$JAJMX8qEZXHr6cK6O01785Y7x_T63YGyGUgQ0IzaEbc
624	!kmbTYjjsDRDHGgVqUP:localhost	$LrWLWL8ROdFElsmPh8RfvVRetphZG1m-d1-JjlIQQY4
625	!kmbTYjjsDRDHGgVqUP:localhost	$W-AJ49bmoFkkeZ5q4I5P4ZaEQPYnX5cXpo5GyhTKIE4
626	!dKcbdDATuwwphjRPQP:localhost	$ZWUphuWh1NE42PK8ClAxJhx6H8ntAgxHBPn3FJbR5Ds
627	!kmbTYjjsDRDHGgVqUP:localhost	$PVJY1qHoALdAw65r94JJarnMwop1rYs0wqY3zgL-b1Q
628	!dKcbdDATuwwphjRPQP:localhost	$7DQxP7a4F3PluqTuMIKQXy2MnH5gCYWTOyTXgYk_Wsc
629	!kmbTYjjsDRDHGgVqUP:localhost	$ZTbPHEs7ZfetTVYCG-wCmHAIPQyD3-iMfN6jKtq-7i4
630	!dKcbdDATuwwphjRPQP:localhost	$MV8iXvchdNqWWza-1uxlHrVa5k07hiZ7m-Mlcri2d94
631	!kmbTYjjsDRDHGgVqUP:localhost	$BtSfAWbSLMo7v6jKfYiIat79nOP1WpX4xFPjItBIaUE
632	!dKcbdDATuwwphjRPQP:localhost	$7KbWgeEDD-0zEKZ0MtaG41q0Fbz7pX3p4Kd-ZBmndbo
633	!kmbTYjjsDRDHGgVqUP:localhost	$ESv9JJiu5T6BsIDCWh3Z9eRycuIml_UXhToLULG2J9U
634	!dKcbdDATuwwphjRPQP:localhost	$9rdis2Y7KjE846mPY_tBmZkImy_JC5EGN7M4XFUJEno
635	!dKcbdDATuwwphjRPQP:localhost	$5lbMIP5vv_w4_8kTltA6OOE-CqdLX4h5cd03UzsyTN8
636	!dKcbdDATuwwphjRPQP:localhost	$aTB906NQgUXcF5sqW8m-g4r8uALWE299zBNBIfdl4iw
637	!dKcbdDATuwwphjRPQP:localhost	$-8A-GN-R7ZlEwytAhAs5-RaJ78b-fP2sE4mriguJQnU
638	!kmbTYjjsDRDHGgVqUP:localhost	$FsjGyZtQKvbdwxYF5oJef_nWG1neetGlNr1o6imxaKw
639	!kmbTYjjsDRDHGgVqUP:localhost	$lI_bZhekPdNId4ZUNpyYiay6L9YBWY6RmMK5WQAu9Fs
640	!dKcbdDATuwwphjRPQP:localhost	$kdr2VeT0AowrLRd4HXI6EEAZw8oPl3deZdPbxUAFGcA
641	!kmbTYjjsDRDHGgVqUP:localhost	$Wg59bxdg7VQVLQGO3euA8MBjqIP4UQiIbb4tsCMOlVk
642	!kmbTYjjsDRDHGgVqUP:localhost	$pkLLj8upnCIXz5ta1-JHxFAbWngqCaJGOdjBF58S-Sg
643	!kmbTYjjsDRDHGgVqUP:localhost	$3hVt24aD0PRuljnOfkHJMeonmkJvkEBw28048m9e71c
644	!dKcbdDATuwwphjRPQP:localhost	$ubg4OjsArGbwxbtotPNooD4lnjwLwVel56lHtwIcAK4
645	!kmbTYjjsDRDHGgVqUP:localhost	$pUIqtxiHfdv8hNjzKzFZ0WSWqlI7asKxuTb9yZTlhRs
646	!dKcbdDATuwwphjRPQP:localhost	$ilJQmCj0mSuegZ-gsRW3ek6hUksMupS1OB3W1F-7PKU
647	!kmbTYjjsDRDHGgVqUP:localhost	$jZILA9yvkk7LX7zRmtb117ydII9ok6FTSA0nxFAgJhM
648	!dKcbdDATuwwphjRPQP:localhost	$b7fZJx2RWEsQJ4CfPGyYq3OwyLKZ0M485ebOegb3Ag8
649	!dKcbdDATuwwphjRPQP:localhost	$inAkMf2O8U3UJDGO19UXVKdVbbi7BInrabn_EiQn8xY
650	!dKcbdDATuwwphjRPQP:localhost	$2GgrW1vYQqY7rWlGxP4Kz1R6x469-P-h476YshS8aZ4
651	!dKcbdDATuwwphjRPQP:localhost	$Ffyd2XgMPkKpnzHyJsa2PqJWP1JxB1SDROLQ2iCIER8
652	!kmbTYjjsDRDHGgVqUP:localhost	$lSYAOA8XFH74Igp8GaBBM5aIrgcONmHb0ItmA-1IXII
653	!dKcbdDATuwwphjRPQP:localhost	$hXewMMBfUuzRoMLQxe0oLxF3Mfs5Z_9JnmyS7ie0-EI
654	!kmbTYjjsDRDHGgVqUP:localhost	$5BWzcOEPDLsEh4ALrBjci0rD3CV1FH0b6lmuF10auJE
655	!kmbTYjjsDRDHGgVqUP:localhost	$ujYNsKLscCPhIaH3O-6CGIEHwAeXoXoUcFPYdx09gRY
656	!dKcbdDATuwwphjRPQP:localhost	$iZMZ4earoVGvR5ZLJoUdzwEQYk6y0Vl14RW5XohiNVU
657	!kmbTYjjsDRDHGgVqUP:localhost	$UwstWDXFCzBSDpC9jQEQ65-54UPjCGh75p6Q-tjg6Sc
658	!dKcbdDATuwwphjRPQP:localhost	$tP1AH5c9Y2cPXAw5Hwh1OaDb5suTBCnCkLk7_SCo5rI
659	!dKcbdDATuwwphjRPQP:localhost	$MbuWe0ruDRx5fbkVvtcn5UjTBkv4Yv5TS1q-rLP1XH0
660	!kmbTYjjsDRDHGgVqUP:localhost	$GFijw4NpMTA0SmjMYsUuD5czdsfcB2wyMsr-mkSfD7c
661	!dKcbdDATuwwphjRPQP:localhost	$E7yT7WSZml-zdf1DcWToZmOoCirZNUhclLvxN6yk6RA
662	!dKcbdDATuwwphjRPQP:localhost	$OzU6yNQOWiSvmZErgxBULJSf2gsapQISEhD67pANnwg
663	!dKcbdDATuwwphjRPQP:localhost	$WkvVbzGBpB2t_YatpDAHzE-s0YISTNGIewJ39D0G-OQ
664	!kmbTYjjsDRDHGgVqUP:localhost	$BTWAxCL1Q-kc8J7k08Wg_u37f-A3tuX2sCVAwuic0Z0
665	!kmbTYjjsDRDHGgVqUP:localhost	$lWFhSdVYsgrmF-rTV3G6VcnXt07wiTYHxfu2ArvhEBo
666	!dKcbdDATuwwphjRPQP:localhost	$0QNG_l0Wmd4_YtwXDHIS9Wr_di_pB4Q8qIxNv4LwD9Q
667	!dKcbdDATuwwphjRPQP:localhost	$AnkpTiuy9AKjxcv15awPzAskfP8BjWH99wlkALBGVYw
668	!kmbTYjjsDRDHGgVqUP:localhost	$JVuQlJWDWn8vYlX21BZrqL1jluSQk-XHuM_TPYA6Oxs
669	!dKcbdDATuwwphjRPQP:localhost	$Q2t3fUCbcpFnAa5r3QjHhq912uj_sL-cfxOUP3_hYYw
670	!kmbTYjjsDRDHGgVqUP:localhost	$9_FtEw7X9Du5GWXI_LQHnp4ESJVtXr3XXx88qN53uHc
671	!kmbTYjjsDRDHGgVqUP:localhost	$4_gC4X4BTT7jwfdmTIPxsw5gXL9NTQ6gh20zzmzEiZI
672	!kmbTYjjsDRDHGgVqUP:localhost	$mEio6O9xG9bb7k3kRpq2jjkjTjoNB6mlIM5UHZuk9cs
673	!dKcbdDATuwwphjRPQP:localhost	$xvhDZnbXWIsjpS9jA0aYPiJi8NY9RXptCrwt9HGoZ6k
674	!kmbTYjjsDRDHGgVqUP:localhost	$2o_hECzW3pEhaBNCxUbMxN20UPfHHQPw_j8fK4ZR2Os
675	!kmbTYjjsDRDHGgVqUP:localhost	$VyiBuYIbFiTHkw0NhcQLHV8b6rO60ckz0XPGY3ShB0I
676	!dKcbdDATuwwphjRPQP:localhost	$Xe8Mo5aJtIqb7CV_tT1ogA6boPZKeGpwId6HLhjx_tA
677	!dKcbdDATuwwphjRPQP:localhost	$iWQEkTD1m9isdCdAvQDnUbl_9DXr_88p7e4v7Ce-DvE
678	!kmbTYjjsDRDHGgVqUP:localhost	$P-1M4RkPsWa70Cu7U5f9YwtBoIhwF7osExs7gP0A6Os
679	!kmbTYjjsDRDHGgVqUP:localhost	$ghrv60PB4SXj-3D_GF65UEkFYidgsuBdAKhMIHABG7k
680	!dKcbdDATuwwphjRPQP:localhost	$21uxUnmUW1HO-Gle48qPToUn6JhoqXXIA1IAAfLb3Zw
681	!dKcbdDATuwwphjRPQP:localhost	$93GE3yLpWe8ilGy7uZOVNETs026vhGjuF7yNV368ioY
682	!kmbTYjjsDRDHGgVqUP:localhost	$fu3xtF29R2ipWx_9YfE7L-dISXtzIIx68LJ5EFPMJZA
683	!dKcbdDATuwwphjRPQP:localhost	$2QiP_dEXwxSd3h1hu87ploDjbuMQy0AWJ_lW2yejuh8
684	!dKcbdDATuwwphjRPQP:localhost	$MSSFq1_XkzPzV_xq3-Qv39xhz8ICui5HYnIsWf8QaLY
685	!kmbTYjjsDRDHGgVqUP:localhost	$3-gXPCcG5YP9ej7ijF1miVAnQ9vabV6d8WvAxIZ2LYI
686	!kmbTYjjsDRDHGgVqUP:localhost	$XNyu6B9IwTazqbo4Ru-DOI2uYa3SMJtz8ms7M2LK-fY
687	!dKcbdDATuwwphjRPQP:localhost	$h8hbKC9OnNmOVyT_DC-O4CidukuCdPsU71KFjo6WbxE
688	!dKcbdDATuwwphjRPQP:localhost	$NRpRjp14rxKUijyFsx9WsT4hg5bHtpiUY9utHOh2yvc
705	!kmbTYjjsDRDHGgVqUP:localhost	$UpCSWtYZcloTB3Bkuf2y26rGJHq4f_RW7F6WxNz232o
709	!dKcbdDATuwwphjRPQP:localhost	$WnNMK8UD3oW7-FG5xmI6a9zDJgqiA7k3e1BmpRhOr9M
715	!dKcbdDATuwwphjRPQP:localhost	$DORn2H1jtyC6gpFLPFmd2rn3SkJwh-MEKOkBAa5_i-Y
732	!kmbTYjjsDRDHGgVqUP:localhost	$mlcjVgSw5MQbNGSCXkjUyV71B6LExR6X_w-Z2_fESQ0
741	!kmbTYjjsDRDHGgVqUP:localhost	$97JLfcL_MVoXjFiElky5S5ayqm3cUKWcP65ZQnzfUa0
742	!kmbTYjjsDRDHGgVqUP:localhost	$_ukO8pr11vCPwRJKJrVdyGri3u4wuXKBtQ_lJZ66rko
689	!kmbTYjjsDRDHGgVqUP:localhost	$OXWFNg3THQXQHzKFdXBoK-_Spi5b2Uc8lQmp-gDhXrc
695	!dKcbdDATuwwphjRPQP:localhost	$Fr4uRc5Po-KFE4Iz7S8RZAtrraup3RaEYMPhw828aoM
701	!kmbTYjjsDRDHGgVqUP:localhost	$cpPbNaIS345RGtJVXsehwvifpuJWhFplv8AEZ0ZTLgw
702	!dKcbdDATuwwphjRPQP:localhost	$oCjQcj9YsKmHLXjjOUrAF_FxrAnxQiPsGw0t1VZynKQ
714	!kmbTYjjsDRDHGgVqUP:localhost	$y5svLRTO7_zaxPlBOzyg0bGgTJ4MsLipiQdqi-83VO4
729	!kmbTYjjsDRDHGgVqUP:localhost	$Pt1sk6TY-vkeLYoxpqBybdBN9E2edQP-XySILK5IIh8
735	!dKcbdDATuwwphjRPQP:localhost	$kD-FK3SdW3a0acQil3u5OZYAu-8KIz7h0FA7B0he1Xg
738	!kmbTYjjsDRDHGgVqUP:localhost	$3F6GcK-o8p1uRzP-TYVegplnm-0i6ON380nWVutwsz0
739	!dKcbdDATuwwphjRPQP:localhost	$iHhh4tCzopwi7N0GMAkpJOii0dVLgysVnnf1Ee3YK0Y
690	!kmbTYjjsDRDHGgVqUP:localhost	$VUhvzyW5-TUIzhuaI63i-q4PbNbBUvSRrtigzKHRdgI
693	!kmbTYjjsDRDHGgVqUP:localhost	$leoxrLZqQ5yphCXUHtVyJouUqznByba2WSVoixQySgA
706	!dKcbdDATuwwphjRPQP:localhost	$hSdYibp4nugz0bTb8BOQdlnTZNVJMxc0uVcUfabZZAY
711	!kmbTYjjsDRDHGgVqUP:localhost	$mASeUWnn5lmXHrab5t-u35hv6lHvYDxaDSsYqG_2sWA
712	!dKcbdDATuwwphjRPQP:localhost	$a4lJewuAh0PX5xgnjlFyUtay8JEosTLkWPfDDsX3Psw
716	!kmbTYjjsDRDHGgVqUP:localhost	$4EkQCbF-8UiwcL3Y6qM1U7FeI2twmLkEDQnID-pA10Q
721	!kmbTYjjsDRDHGgVqUP:localhost	$36RYSF232RfQNHdWYQMmJ6TF7iqZ9gN3LZjU1mn14Gk
725	!kmbTYjjsDRDHGgVqUP:localhost	$4z0r9ExwCvGW45uPLtN4UGkSUWnR1iCWXbGL3eFRf80
733	!dKcbdDATuwwphjRPQP:localhost	$jWOKRJT0JXWifj1usBkR2r_ZWBf8QZ0ARiam835XRF4
734	!dKcbdDATuwwphjRPQP:localhost	$s45nrx25owBPoNesAaJ3cFSh004zh5y7xnQBF87XYno
736	!kmbTYjjsDRDHGgVqUP:localhost	$QFh5efWclywreXsTZQS0iizSr1qnQOjaWgguK-1Qiew
691	!kmbTYjjsDRDHGgVqUP:localhost	$2Xt7gT6gKAO6yCjELaOppr8qaE1vsFMKy10scInkICI
698	!kmbTYjjsDRDHGgVqUP:localhost	$A1Xh_H2DE4kiWONSGi-oId0tLtIMXcznqhjtWVrEwdA
719	!dKcbdDATuwwphjRPQP:localhost	$xeR3suiER6H_Ihkc2Qh9fitNeg8MspnonA6tvExM3lM
740	!dKcbdDATuwwphjRPQP:localhost	$BNQ7KqqijBvIgMvR7PpeXMx_ZBUQ9xgTuIvZR4h3GlU
692	!dKcbdDATuwwphjRPQP:localhost	$Y-xchU8-VyCn1DhcKZyKC6T0zmxsZKHAYwM6r4PVg4I
697	!dKcbdDATuwwphjRPQP:localhost	$Y6idHmYHfAyUhiFBP5r-6fq2hvlfKkDOEG2wCu-pLa8
700	!dKcbdDATuwwphjRPQP:localhost	$Fl1L_fKoWpdilKxS0DecRLpvXlghCyriorNSxOIjIhg
703	!kmbTYjjsDRDHGgVqUP:localhost	$QKoeT5XV4xwl0N0UQFLAO6TSWkp2MDanFk85XEpJ_jg
704	!dKcbdDATuwwphjRPQP:localhost	$RU2T-B3RYx9hf0UlWYvNelqULIZiwWSHEMmn4AHlUpE
710	!kmbTYjjsDRDHGgVqUP:localhost	$4S0FhGCfClV4YJp9wzJNOzbxJnV3qfcmS7dNpBAI26g
728	!dKcbdDATuwwphjRPQP:localhost	$inD5d7kRpfBp516Cs2z0sXk6mFeS7X0n_Y2fPIRJvQo
731	!dKcbdDATuwwphjRPQP:localhost	$JTQDl9XHXsvPA5zJ5I5EABbCS_qEA5ToNjwhwEK83Tk
737	!dKcbdDATuwwphjRPQP:localhost	$NvVkabz1KcwMkrpCf-B9fCNqo-GG_aiNr5mKQfnHgNQ
694	!dKcbdDATuwwphjRPQP:localhost	$WzK2e9hi70VK1Ex9n3prvEkJXLhF_oM_4qxTEhyKFBI
707	!kmbTYjjsDRDHGgVqUP:localhost	$NXsNThjd36ZSNMiw8pFMUXHYrFjaqxu_dCKIU_KSuko
722	!dKcbdDATuwwphjRPQP:localhost	$aj6Km1527wlg-T8hOO294PCTfkPVF0Y1bJM24ZNa0Qc
726	!kmbTYjjsDRDHGgVqUP:localhost	$IJA87eZxEEZhiPq1EtkFQR9tzXABECK3XVhC1EAOaGw
730	!dKcbdDATuwwphjRPQP:localhost	$t5noefWL-SG6kxztIf4LOl5h-PKd6jBFMOrMQjc1axk
743	!kmbTYjjsDRDHGgVqUP:localhost	$i3kAHwvAu9wFNErdFjNUf9F3Vn_q3td-QVD8XwroAnA
744	!kmbTYjjsDRDHGgVqUP:localhost	$MIaGvfVQfK4XuMh2A-UflPirD_En8coO1-r_MNeWpNM
696	!kmbTYjjsDRDHGgVqUP:localhost	$Pwnj8HtDKyiEpzNqgPdBXcmbGZK3IUnwG1u9W0OBPpE
699	!dKcbdDATuwwphjRPQP:localhost	$gdGMYFIy3DYVHc9Juw-uWhoMUXDNiSabVm2qSqs8eNI
720	!dKcbdDATuwwphjRPQP:localhost	$yvfH5tYTTrrIpYwiYXOMPCsIAdiJVZrdwjW3Sd40sw8
724	!dKcbdDATuwwphjRPQP:localhost	$UQkJdiA8utbU5gKCP8L98Wp6XPeq4NqEixPXO2-YFqY
708	!kmbTYjjsDRDHGgVqUP:localhost	$2exc46eo9dEf1pnAhiGR6fH_QICi5smss-3OE73LYIk
717	!dKcbdDATuwwphjRPQP:localhost	$omNOk7KaX16A4sV0vZcjVj9ey0CoIyhTDnUhxHR8ccQ
713	!kmbTYjjsDRDHGgVqUP:localhost	$lRIgA9IItq3ic96r0ZzcJvudWIWsV9Eu-eSmSFPF8bM
727	!kmbTYjjsDRDHGgVqUP:localhost	$X2dDqylt0SVjcvkbUtt0lidrSPRqqlkZtvjLxmj50Vc
718	!kmbTYjjsDRDHGgVqUP:localhost	$4Mk2JpeIwhsmKqi0d9bSKFmDDsLQRI5DTzujkZ056-s
723	!dKcbdDATuwwphjRPQP:localhost	$ZmMG1BvGXSJN3N2K-ivnBqJ3ofUguCpxQsXTzVsTG7w
745	!kmbTYjjsDRDHGgVqUP:localhost	$aYTHjmp8iDkb6p2mVOloeWvdP1ft3y_rKHX_micNDSE
746	!dKcbdDATuwwphjRPQP:localhost	$o9kcSZjecstIMXBMVRH-oIcw5Vx27S18IabESSItK-A
747	!kmbTYjjsDRDHGgVqUP:localhost	$k9G1zIQqA4vovjf9GX0TlMJ0GrbbvCI4dzgrKYH9Q5U
748	!dKcbdDATuwwphjRPQP:localhost	$SYyEnJYU1WJGpBmiVR5Csq0CUrwui-hW24rr6At5zwE
749	!dKcbdDATuwwphjRPQP:localhost	$W-aQsju20zVpGWe-dsdKKUFap5ErvdtEJqheWQQo3no
750	!kmbTYjjsDRDHGgVqUP:localhost	$z_4BCOrBims4sVRvW8WsXwhfP9Y80zKVQn3GZtdcYtY
751	!dKcbdDATuwwphjRPQP:localhost	$1PwHjL21t8ZKeiwJ3nToCNM56onZch97JuMVf5kBs0A
752	!kmbTYjjsDRDHGgVqUP:localhost	$Mc0QM0-M4yJSTnq2qAbsxgk_IZ3z0wQUQLZ7kkJCgrI
753	!dKcbdDATuwwphjRPQP:localhost	$RSHYaOXucaV1w3ek2DcCffcZrvIL7VD5xbJc7T8ychc
754	!dKcbdDATuwwphjRPQP:localhost	$nS0FO3BaaXEG7Hch4PPFBWk3y9nsT16ufNjNsE9mhXQ
755	!kmbTYjjsDRDHGgVqUP:localhost	$KL8gNaGPFyrGt8AOusuwIknPZi9F814khGrp-RNEN7A
756	!dKcbdDATuwwphjRPQP:localhost	$PJZj6JFbqNHoFpxpyNmXH4S6nsILjrt0zVVEdzCdtZo
757	!kmbTYjjsDRDHGgVqUP:localhost	$MaATo1ETeRSyg2QSWs09jzF6D5E77HNDbRdF0wfzjGA
758	!dKcbdDATuwwphjRPQP:localhost	$xhgrll_YejWNlVK-yltIdE31CiZsHCgTOxl-P85eGOQ
759	!kmbTYjjsDRDHGgVqUP:localhost	$JbqmHsg_NrRNfgKp8vqriw2r26qwutCfB6iulRErysY
760	!dKcbdDATuwwphjRPQP:localhost	$mWJoPtaH-AQM2dOoxErHlLdEbnIjOCpDDXFdH5S8IJY
761	!kmbTYjjsDRDHGgVqUP:localhost	$DbxeKNS7UQvIcrmdg3aEJG27F4UjKiHYik-2KLo8Ho0
762	!kmbTYjjsDRDHGgVqUP:localhost	$ZubZFT3t8FWXh2TQMRLrSO4z58DdCUjeqAtlwYQOyhA
763	!kmbTYjjsDRDHGgVqUP:localhost	$wTAaHsIcAwSuzSA7H-VHJ6OXl42-SP9P5BrF9tG-Drw
764	!dKcbdDATuwwphjRPQP:localhost	$ilsoFYG97CK7uL8PB0L479J2-OHnBGTUudyIJRVfNV0
765	!kmbTYjjsDRDHGgVqUP:localhost	$XQ1jFv42iko4nJCLIdfpOn1d2M6_QPKXZoIII4rlu6E
766	!dKcbdDATuwwphjRPQP:localhost	$e-LOqEUXSEfmQn4OUgNDAHsb5AzpNsDo-mjp0m2vFQA
767	!kmbTYjjsDRDHGgVqUP:localhost	$se-hxsgWXjDaZa7YzaTOSUMDuUxq9PwF9mjbrV3wDGY
768	!kmbTYjjsDRDHGgVqUP:localhost	$Hr6BwLJAYo3C1XXG_ALOQ6XnEfYUVkpAHTAyMV6sRws
769	!kmbTYjjsDRDHGgVqUP:localhost	$iHcvngt5K7BO_ryjzeAfNe6IzsHVyjhlTWKZiULiu2c
770	!dKcbdDATuwwphjRPQP:localhost	$_dSWYptFmigdmoPwl4pPgkQsXzf93z3ymnhqLiZYZQ0
771	!kmbTYjjsDRDHGgVqUP:localhost	$mIzc6ywORMA4PimH1v-tONsYp9OAtOd_N8QayOJRChk
772	!dKcbdDATuwwphjRPQP:localhost	$vxw7cwkwLq32OUI5XmEye0SoHADbZvD7KRIKJjv-d_w
773	!kmbTYjjsDRDHGgVqUP:localhost	$OIyI_RMLRG3WqF78rUutbBuZrXoVOTbjTebt_ptNKD8
774	!dKcbdDATuwwphjRPQP:localhost	$6Ck35VhoI3WNs6LLHosS814RtZrY2REFf-6tgXVzA3E
775	!kmbTYjjsDRDHGgVqUP:localhost	$B-WvvdnzWeJvVAqKokLJeGygybnl-gRLFdJrvfM0ryE
776	!dKcbdDATuwwphjRPQP:localhost	$cdxgSQ7KdCWWlrJrFvTZePP-f5nmlzXmlaQvmvZdDw4
777	!kmbTYjjsDRDHGgVqUP:localhost	$2Ssf7gkS2NkVT6vtdKc6Pyyb9zsIjwWnDWVRVMpWBxc
778	!dKcbdDATuwwphjRPQP:localhost	$geOU56teKdqcKV7kG7s23qj_HQbPQJMTLO0UmB5yANg
779	!dKcbdDATuwwphjRPQP:localhost	$kjbYSfaGFjSymA5ueut8EloSHx_DpZaBG_RT5D6TemY
780	!dKcbdDATuwwphjRPQP:localhost	$86Pf6vb7BHzOZsjy0ObG0cYuSD0HDSs1wYqB1k7JDgg
781	!dKcbdDATuwwphjRPQP:localhost	$BtKmdXlHyT65KPvPIiDSk38oldbOKOUbuv7J13Up4wE
782	!dKcbdDATuwwphjRPQP:localhost	$HVWinlm6AKNeOld7iV_yqdfmpznmG5wAyWK5k3xjM7Y
783	!dKcbdDATuwwphjRPQP:localhost	$FNOekiMLFE4AEgQ1st7kiouCRAYO3DKEMbrYHGbH-zw
784	!dKcbdDATuwwphjRPQP:localhost	$56oOQ2hizWAJWWKoJTMYGwAKX_gaANdZg2QHgtC63ZE
785	!dKcbdDATuwwphjRPQP:localhost	$6Sy4DU04a_WCzalQkimJ_l9-eYsJ3kcn3Lat9w42L2I
786	!dKcbdDATuwwphjRPQP:localhost	$FC2J9PSIQLoF8YJo6zY2dP8Eo55L8CPgzVGN7iaofRo
787	!kmbTYjjsDRDHGgVqUP:localhost	$WcPnOWvRmgShLlAe8RxY4-_M71l0auS5ykpKdmUS0LU
788	!kmbTYjjsDRDHGgVqUP:localhost	$-R5ZDLwPtIisO-W746dPRRrr1U6HjM8uhC78Zh95UUQ
789	!dKcbdDATuwwphjRPQP:localhost	$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E
790	!dKcbdDATuwwphjRPQP:localhost	$M2xNoGVeTRazjk5EjiA0u3mOkneK7za9KWYn2LMJFwA
791	!kmbTYjjsDRDHGgVqUP:localhost	$19Wa_uoHXFwHicMPIWHRa1c8H1yIjgzKxpDzo89CTTE
792	!kmbTYjjsDRDHGgVqUP:localhost	$lDJnxY-YfTRyXQcBLRlbFT2_w4DXO4Pks75YGGa5M5o
793	!dKcbdDATuwwphjRPQP:localhost	$SLqtTg1DQZU0Y4ezk90kDHz7IxD9TXjhW4qQAoPUfTk
794	!kmbTYjjsDRDHGgVqUP:localhost	$6ZYuUr8K6uh0D7tl9-HD___6hQH3lj8qU1liF0zAkmo
795	!dKcbdDATuwwphjRPQP:localhost	$t_tUn4wROpupdwEmZnXWQ-mtnx68XnGjofi61K92cRY
796	!dKcbdDATuwwphjRPQP:localhost	$JgtV2Jrt_3Cws_oeqEte6xeUnTbTSMu0pBPrEWD4WyM
797	!kmbTYjjsDRDHGgVqUP:localhost	$Qyk1jqM8wu6uOaEDEalSs_0hepeq6CnfZZRy1hQ4sd8
798	!dKcbdDATuwwphjRPQP:localhost	$qgyz1sVriFBiepR7YLOpA_tcnRjhDX9q13fkeJa8i3U
799	!kmbTYjjsDRDHGgVqUP:localhost	$ZLuzCoh1UZ9oNHYyBNCtneq81TelpJ882dsDdio0oKU
800	!dKcbdDATuwwphjRPQP:localhost	$ggRHO4QwGg8SLwSXlSNnHypSBsgj2jFMUXbjC7U97qM
801	!kmbTYjjsDRDHGgVqUP:localhost	$0ClPrn0jv_hdCQB4TqbWVPUxxSqFeDViCsOjYwQVDAg
802	!dKcbdDATuwwphjRPQP:localhost	$Zv-9wNEnjnF-VeZtZKtHkYObGhccwLKewNnJg-fUiF8
803	!kmbTYjjsDRDHGgVqUP:localhost	$aa2-bg9KcCtrn4nE5HK1JGC6sa8Gr7jWqLhPgLQTtsU
804	!dKcbdDATuwwphjRPQP:localhost	$ewJTQJq2XdLvkqYVULlUmmJ-A3LQ6Jnqs4GDYi6q0DE
805	!kmbTYjjsDRDHGgVqUP:localhost	$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo
806	!kmbTYjjsDRDHGgVqUP:localhost	$Zgnflyip0N0Un_OQKWbp8UTKqsYDsMF1KWxIbyyXeZU
807	!dKcbdDATuwwphjRPQP:localhost	$Rj6-cgqQLa-sm2y7xCdmsbowv1aA3xi5zbPKvghQvsE
808	!kmbTYjjsDRDHGgVqUP:localhost	$7YneRUzgSdDJ7M_Te78S8xhVh9mMw-zuJtgoD4whiaU
809	!dKcbdDATuwwphjRPQP:localhost	$MZGUVdjeKp_G50hZmBlFVdEB6IqWRZEF_F09RwaUKpg
810	!kmbTYjjsDRDHGgVqUP:localhost	$Xa-kxbjVzIuWZk7MczOO0Lsu5l0vPG9R8TEcz-FR7UQ
811	!kmbTYjjsDRDHGgVqUP:localhost	$1YpqIvJtw2TvK5W2FEFeTvsq9OvOYytjSCk-5swUPAI
812	!dKcbdDATuwwphjRPQP:localhost	$J8aC7EapXPdD7Wn2sBxp9PM_ifD9WOvg9ExQ8VA1EBw
813	!kmbTYjjsDRDHGgVqUP:localhost	$9Az6aShbcLHi8sucLXwfVQqMXhn0GQU5ARFregtYick
818	!dKcbdDATuwwphjRPQP:localhost	$qNjW0FWyCI9O1d21v-OM1eRYYGTrRAhhoPlWb52bt_E
826	!kmbTYjjsDRDHGgVqUP:localhost	$SGlG9QIyttSS1S-UxR2rNHpdA98-GK4BJZ6OZ1Y9F2Q
834	!dKcbdDATuwwphjRPQP:localhost	$bs9UhrWMuuIUZUX9yunh_jp-dty7I-OfHOMGV3DDTRk
847	!kmbTYjjsDRDHGgVqUP:localhost	$-TRGyYJ1RIWG7BZoERAkWXx7e1RmR29ZZUfcZqsLhcs
852	!dKcbdDATuwwphjRPQP:localhost	$Mg4CI7sjccWPLYIN-n0dtWvCRLOVWX4nsZom5JNCXzY
857	!kmbTYjjsDRDHGgVqUP:localhost	$JoNW8TcNOcvY9IFbcbbPrgsG-Doiz3nUPLCb4QDMAik
814	!kmbTYjjsDRDHGgVqUP:localhost	$_lR02zR-Swkcd3UqOwpEP2lSxNkkXnA56Ez_349FQVA
819	!kmbTYjjsDRDHGgVqUP:localhost	$iU7x4gyphxqfcA5Cp98H-ahXMAhWGOzggfoRn4EPsRU
825	!dKcbdDATuwwphjRPQP:localhost	$f2gGsazlQAaRyNNlEYu8xpuZlgF1HWnzwVt5D0s4mmo
836	!kmbTYjjsDRDHGgVqUP:localhost	$Zd2-qaHPSceqiflC5zH2SijYuqpTb4uqPC9aDAdL6mc
842	!kmbTYjjsDRDHGgVqUP:localhost	$XBNgiXxNNVl-1CZgzH8nXkpCUvA_50RTMvdg473YYas
846	!dKcbdDATuwwphjRPQP:localhost	$ZE1ce-mLqCEwF-Y3OX_8wk8ZxkWBY-7gO-a2Fr00umI
850	!dKcbdDATuwwphjRPQP:localhost	$oJbb2yIULGSdtwshWLgKDVR6M7wVruZYHOYxc1GQp9I
855	!dKcbdDATuwwphjRPQP:localhost	$rXJVVj0ynCW0JGPVOewm69a8zWOUyfXO1trJCOTa3yA
860	!kmbTYjjsDRDHGgVqUP:localhost	$zVAJqVneaN6dmObrxbyMDM0ikKmWGSQHkMTf6TIjZ2o
870	!dKcbdDATuwwphjRPQP:localhost	$whsneZ-CyVZL-8jbp0im-rk0dCxnMqeEiYuM3XNZolE
873	!dKcbdDATuwwphjRPQP:localhost	$8eh5khD7zvskv6jQ-GGlwc1-jks3osUqY32rqqWXGcU
815	!kmbTYjjsDRDHGgVqUP:localhost	$aPvLQkQt1Em79tepZtbtEvZRdx1NGWpEWGXadEiP2tc
829	!kmbTYjjsDRDHGgVqUP:localhost	$nC6OBYF3Me6eXYa9KzUrstC_Ypikxd9J9qENgV0H0FU
835	!kmbTYjjsDRDHGgVqUP:localhost	$BmLqRHFOuidrqnVraB487N0gPPLCfsuOISSVR9ak-sw
839	!dKcbdDATuwwphjRPQP:localhost	$Rid4ZH2wt7ZTaZuDxd7EM3MJIKtSXWRpHbiVR1r0hKg
843	!dKcbdDATuwwphjRPQP:localhost	$k1UkeU9EVyBwiDdR4lvkgsbQQNOsoCJpmivkMrsRbiE
866	!dKcbdDATuwwphjRPQP:localhost	$Zf-VQ-tTrKZXdjSof9QJwHA_NoexX1KofdTMZ-q2ypY
871	!kmbTYjjsDRDHGgVqUP:localhost	$iiYXkDx_xvgYas2gOXwd9lgM2y_Pz7JmZ6oebG6x2d8
875	!dKcbdDATuwwphjRPQP:localhost	$vX-e7WIYe5ttyeaD4sjA8RG0wNkHqty52awlhju_N0s
816	!dKcbdDATuwwphjRPQP:localhost	$Tt3TwjqNwF3BMMK_iRnkUM55GhnHQTHdyIujoM4KVf4
838	!kmbTYjjsDRDHGgVqUP:localhost	$Jza4B4lfmWRl3kM0CWpht5THqgKlntYbX1BbmRiFA1o
851	!kmbTYjjsDRDHGgVqUP:localhost	$Y6hq0w2WZ8EB7wkjpOg7SWTn8YPKaxOEgsZO9TNrXck
862	!kmbTYjjsDRDHGgVqUP:localhost	$qQjqkHxUOckS6bBkj8uuQ5qPlNqTt3eesRZbiSETCL4
867	!kmbTYjjsDRDHGgVqUP:localhost	$Di17M9JIg42R6OGzkz47OQ9A8RVmFm5epuLvTaxVTOY
874	!dKcbdDATuwwphjRPQP:localhost	$ZyDmXhlUtIFNmqJh7KDc4AyC7_a987iLlu77yAuvNy4
817	!kmbTYjjsDRDHGgVqUP:localhost	$qvQpGvaX7NF_3wwnBgcfkCpJPZIxG-uyv3lmw7OsC3E
823	!dKcbdDATuwwphjRPQP:localhost	$ZISsQrKIhyV-C1r9GZrWa3tZAXp6JIvXebe6x5jd8P0
828	!dKcbdDATuwwphjRPQP:localhost	$xlQt_O4a9JMSvIAPLqgQSWXD0SW3AiLYjF_F0DIQjgE
837	!dKcbdDATuwwphjRPQP:localhost	$arbwg5Xz5O_4X_4JNzjQy5_mYTuznn3_4509_ZRraMo
841	!dKcbdDATuwwphjRPQP:localhost	$lZj3Hh5897cVXkQJob8jnbBK7AdlsazPRFavFlrsD84
856	!kmbTYjjsDRDHGgVqUP:localhost	$4Gzsls_kMYtk_8cgN5vgAXHDaXaeEbTtLs0ASPhSKJc
872	!kmbTYjjsDRDHGgVqUP:localhost	$HfccZV9bfsEc0jtPXtXHpKH1HhaR-7lwnD3pzLKpy5o
820	!dKcbdDATuwwphjRPQP:localhost	$0rbT64xaQgvfhKeIPIv_FZNDBSN-LK7f_OPy__2jAAs
827	!dKcbdDATuwwphjRPQP:localhost	$bo-pfXDPqz-6bW6lWqlM_3cqZ5LDsJ1a89yq2uiw4VY
845	!dKcbdDATuwwphjRPQP:localhost	$yPFosTQs7Sqb2lSG4wNvovYGLt5an_pjYvjIN1diKEo
853	!kmbTYjjsDRDHGgVqUP:localhost	$bwla6VL2GAW2r7Iqbf8BpX84P4Mrq4dkkzXoDMhnK58
864	!kmbTYjjsDRDHGgVqUP:localhost	$TAufM8VbjDUR2YGA-AHrW5qj3Mfed0Yvg6S9AdbgAxY
869	!kmbTYjjsDRDHGgVqUP:localhost	$OtjpL6RH8LedvpCr46TvtiaNEJUCVp5siXwzawzvVEQ
821	!dKcbdDATuwwphjRPQP:localhost	$12sa6Yc7rKZv98-tMtW-V3EDnRBEXdI7OuEbRArfjlI
831	!dKcbdDATuwwphjRPQP:localhost	$7KYv-muwdu6SMRcpgNNFubk1An1Dl7_f3Sub6z9Kn7s
865	!kmbTYjjsDRDHGgVqUP:localhost	$w7san8E2lObp6oE270LUyktBvthDtgPOcDTm4KDJMz4
822	!dKcbdDATuwwphjRPQP:localhost	$sLKVG7GtD5c25GHpA9ym3F-Ulp5BbNbOknjtOcH6E_c
832	!kmbTYjjsDRDHGgVqUP:localhost	$aPIZ5vpa2QHDLskvy384LO6xb_7Grsa-5E7XxcVx2Bc
840	!kmbTYjjsDRDHGgVqUP:localhost	$ASsIjI2_ngiRDvT7LAQF0tWn3khycNAxuo57kUjSXTA
854	!dKcbdDATuwwphjRPQP:localhost	$bxSzL0H48VoCouxqhSGFdxLFi0hLBupYq4pIVud7N-A
824	!kmbTYjjsDRDHGgVqUP:localhost	$CeEa89lM9awBTcCA-i7vxpZfM9ZDn-d4352zYE1fPjQ
833	!kmbTYjjsDRDHGgVqUP:localhost	$1qreijYdXoeq1tKeGmZgLwyi0tmfw52a_NtPAOaCvZo
861	!dKcbdDATuwwphjRPQP:localhost	$KSiMHQkUituuPCxXNVybLI-4Nt1uQNO23L1gt03SDh0
830	!dKcbdDATuwwphjRPQP:localhost	$fbk0yd0IsIg_OjYQ64fApi1RNik4-prJI8T11Dy6aPM
844	!kmbTYjjsDRDHGgVqUP:localhost	$PTrxs03orEy4-ZNfyuzkahxVWtieNTdLunhf0hN-k1o
848	!dKcbdDATuwwphjRPQP:localhost	$rzHYo2XXi9PMz6SXNk5wcfkdXr9smHym673zevulQTU
849	!dKcbdDATuwwphjRPQP:localhost	$4zUYz066OZYJIgWsaGn3uF__M3YHiHjefiN-pgPBUTY
858	!kmbTYjjsDRDHGgVqUP:localhost	$qJt5ygVMhv8a-qVGKsla4gmxz629Ai1vT4IzFICcXZw
859	!kmbTYjjsDRDHGgVqUP:localhost	$g4au_5aKUQgmkW_VQORfsbH-TRts299x55_YYeYVbRs
863	!dKcbdDATuwwphjRPQP:localhost	$Vyf3hOxtpjhjRMKhI1lY_LICGaNkhSSyoQll6drrFGs
868	!kmbTYjjsDRDHGgVqUP:localhost	$2hWwEm4RlzFOEncRnEEg5BSCfKep1BLoPYQfSoqES7g
876	!dKcbdDATuwwphjRPQP:localhost	$U3_pJaCcLs7xB_jj8HrUER6pYdpIMMqEJ7MvBri5j0I
877	!dKcbdDATuwwphjRPQP:localhost	$yiGiFoaUL9ZDTv9diFjBc3vYGjVBRjaPtEVwSZsXUyc
878	!kmbTYjjsDRDHGgVqUP:localhost	$o3mOz1bBAIWTtc5vpLi6eZOxdPjSi-kjJAHw4JuFuZw
879	!dKcbdDATuwwphjRPQP:localhost	$rTTOii1dV6AKQ-17hb8e6mpQ0XXn5vXK3Jc14VZKcxo
880	!dKcbdDATuwwphjRPQP:localhost	$6zunp5CCmo4xJR-ScAyGxtn1Amakzs49vZL-SiAUtMc
881	!kmbTYjjsDRDHGgVqUP:localhost	$wo7Iz5cB2PfLcTPVAmQL_WFFuWKy4ZFMCrKW1t7_EN0
882	!kmbTYjjsDRDHGgVqUP:localhost	$QzxCVtepRcnUC8W4FRDFuEmAgixsxxGHvLUIdTVxHXc
883	!dKcbdDATuwwphjRPQP:localhost	$SfH6n3byrCtM4pQ-qLwXOI3sCBoDZaC4dsX0dr_Kpwc
884	!kmbTYjjsDRDHGgVqUP:localhost	$cn29yijVXCQikn8Jy3OwLKbw5ISKXPl0z42QnF4dtD4
885	!kmbTYjjsDRDHGgVqUP:localhost	$Fe_3hXV7AoKR3N96Mw8dfJm4sXZj5MR8Kmb8uUzQ8v8
886	!kmbTYjjsDRDHGgVqUP:localhost	$ZLBm_dexB3jkAROZrN7dKQp1U4FLCNU_kBXf4-JBMh0
887	!dKcbdDATuwwphjRPQP:localhost	$FKZcnCf5AfN2lv7vjHE-fMLcvDJa15Di57mU0P4O0fg
888	!dKcbdDATuwwphjRPQP:localhost	$g1uAvuaIYLlTkasCZ-i3jkRixnb_Lji1Ltwrgfvik4E
889	!kmbTYjjsDRDHGgVqUP:localhost	$C3iUQm0HMao2GEeuKBnEH_XN0Ll8SwrYygiKbAzj-DA
890	!kmbTYjjsDRDHGgVqUP:localhost	$DQQRR0JcOZkPSoOvNcCXczg99ZSX9tms_2A6SHYKNMU
891	!dKcbdDATuwwphjRPQP:localhost	$7UzeCUU0SlliReZsFaPqnQeLU236-jIEplDshmYVFfM
892	!kmbTYjjsDRDHGgVqUP:localhost	$qHHEv5q3MpEsIdXH1idIzqQL3tbgWatGPC_QdmUrGFQ
893	!dKcbdDATuwwphjRPQP:localhost	$7myhztOYE9eNYGAgdFsKRcCnSpf2-YqJu_AYt5y8Shs
894	!dKcbdDATuwwphjRPQP:localhost	$0zazzIpeOwV9Dar_jOfAjp9AjrCZZc4XJW_tVHBAhfo
895	!dKcbdDATuwwphjRPQP:localhost	$YUO0Q5ZyT6NtmoNcDY0OIaE7h2-v6ewSxMAh6_kFSf4
896	!kmbTYjjsDRDHGgVqUP:localhost	$COI-O3jEIQ2nOPVfVLolJbVfR569zTP9xOV5FqX6asE
897	!dKcbdDATuwwphjRPQP:localhost	$N5dvZG3mklnSuwnBA79sbcRtzgPWVSzoPEL7t-m8t3c
898	!dKcbdDATuwwphjRPQP:localhost	$sLzwfw4aW7zEMqrnRJ6m4QCIWMy36zc9h1zHOyh4zTQ
899	!kmbTYjjsDRDHGgVqUP:localhost	$oeRRvxJqPMCdYMUDH1UQCR0AXPuOr0Sc9x58cFITLjg
900	!kmbTYjjsDRDHGgVqUP:localhost	$bmFm-3CV_5-ZFPY6Jxw8nDRu0L8LPa8T0HmSV60W09E
901	!dKcbdDATuwwphjRPQP:localhost	$cs7vGd_supYOEssanlgvqGVXb-MiAoq_LwZ2M-nZTI4
902	!kmbTYjjsDRDHGgVqUP:localhost	$Iry3FS1Vjv2WkozYT4Y59J7aq4varOElqx7PMe7i4bY
903	!dKcbdDATuwwphjRPQP:localhost	$bYhST0uKrA2FW6s-YEFqzPrabK9HadtXA_2I_kIefBo
904	!kmbTYjjsDRDHGgVqUP:localhost	$8hiJoLRQUD-3tDnyO21z4XB2E8tTyQosS27Nj2kS1Wo
905	!dKcbdDATuwwphjRPQP:localhost	$XNsoQPzNyCDBQ6T9oa0c-m4xQVK2-Aq1C7fHX5aqtb8
906	!kmbTYjjsDRDHGgVqUP:localhost	$Ihs3atH0QngjgnLFy8eS-sEmZi7IVzT5ZunroMU5ZtY
907	!dKcbdDATuwwphjRPQP:localhost	$pahKUd2PrHxkP1WApv1gWbVOIUGacMzJeLQSQlZqFcY
908	!kmbTYjjsDRDHGgVqUP:localhost	$UQmqzxE4M1RzsPrQri1fA27BzBQuCgp0mAhi4-vyLOk
909	!dKcbdDATuwwphjRPQP:localhost	$zEX1XaTVtT6Z-Dg158IdyJgqDT_aR0Od37oeoUc4x_k
910	!kmbTYjjsDRDHGgVqUP:localhost	$lPYG_C62p7bdu_o3MTfT6NKjV0L6Z-qPuyHbhwdzJ9g
911	!kmbTYjjsDRDHGgVqUP:localhost	$r8SzcOxc0siJLH_T8_PzCsGCyP2b1c71M_Of1YO_f6c
912	!dKcbdDATuwwphjRPQP:localhost	$AKYVSNk5Ft59wwHSBF4NGcGrqWeqB3dSD0Jao-K5de4
913	!dKcbdDATuwwphjRPQP:localhost	$R4jtSfjHvoXvEcTOU7vXV3Snk6KkA9BvHX2FktyKQbE
914	!kmbTYjjsDRDHGgVqUP:localhost	$sZOegUiHUklzRiC-JOqONVwuR_lF9jeUXhUGx1XWYQQ
915	!dKcbdDATuwwphjRPQP:localhost	$QGPbxlmoLTiTtVRmaN56kgzQUKDv3OOR9NmsCbb4zXI
916	!dKcbdDATuwwphjRPQP:localhost	$EBNT8zpQfljZSVlw3Sd0absk3IHhBMgxCAxvNpodb78
917	!kmbTYjjsDRDHGgVqUP:localhost	$A6OHxy4153QtccshtR2NuOzOLJe9vlzTYhDmHeTWz3I
918	!dKcbdDATuwwphjRPQP:localhost	$5WD0oHZ8vlUgITaikIMGAGqqxRCTYFX7_Z8rZHUl-vM
919	!dKcbdDATuwwphjRPQP:localhost	$UxIrDMEppa-xA0G7EOBbgW64ncD1QvT5626GzhYjqao
920	!dKcbdDATuwwphjRPQP:localhost	$fI9mHJpfofNXVbuJidriuQ5a-Ziwz9vN6tr3rsa2sTY
921	!kmbTYjjsDRDHGgVqUP:localhost	$USrw8nxfDlAf-yqvbp8AudpcFJPj6YR0YCrJnQsIBw4
922	!dKcbdDATuwwphjRPQP:localhost	$ejN_OUjcw9SUs5Sjmsq7y-vMQtaEqeqKHZKxXbBAGmY
923	!kmbTYjjsDRDHGgVqUP:localhost	$gY9nkYqpOB58iJ49O0CIttWZ4pVxlLPY5Fu7a9R16sc
924	!dKcbdDATuwwphjRPQP:localhost	$6_I17LPHYe9WHpIom0CdS9NNbXFumiDxxWMh_yB8TdI
925	!kmbTYjjsDRDHGgVqUP:localhost	$prtlsqdiW6xDWGbtFM0ModjScjHPOMj0b2jU_s1Vke8
926	!kmbTYjjsDRDHGgVqUP:localhost	$q-eZwhCHgbg2ExUVkntexoM6sPe0eeOhFaXcDhJ61EA
927	!dKcbdDATuwwphjRPQP:localhost	$UXiA2Bg2egIE7SeNCP-90XMiKIRJ-6jFQH-g8r5wXpw
928	!kmbTYjjsDRDHGgVqUP:localhost	$xjauTg8qMh3tRNpoVHaEwBg4hKg59YXOQSFwqyxUM8Q
929	!dKcbdDATuwwphjRPQP:localhost	$Dy0nuScsu4OHf9FjCAXMJ60BHH4Tuqml2m-Lv-9m5FM
930	!kmbTYjjsDRDHGgVqUP:localhost	$kNxpHovDfeSWxuNI8Dqo1MKZabC-2sc82KDkT0Gp53c
931	!kmbTYjjsDRDHGgVqUP:localhost	$Iy8TDhPxQHAYtdgcQz8sLx8KAjMwNhFiHr30n7HbKGo
932	!dKcbdDATuwwphjRPQP:localhost	$qd4_hfefNCwHArC8mxVpf9SVgrX3JYlftaNvT5R9uIc
933	!kmbTYjjsDRDHGgVqUP:localhost	$ZyHjFZD_sLtPYRp-3nEhL9fPnbL7hbiyErHftWYVGCY
934	!dKcbdDATuwwphjRPQP:localhost	$OeYg8Ixye0_R1UhQB-26ADFNFTuK_pc8mwPqH2DHo9U
935	!kmbTYjjsDRDHGgVqUP:localhost	$85Ks0YVRIFkf1timCh_aBJhcBb6iB3dR-0LCO-XymiE
936	!dKcbdDATuwwphjRPQP:localhost	$DBvt4AoL6YlrBJ1DJ-b5AUeifMfWaCOql8ORqCLTqbo
937	!dKcbdDATuwwphjRPQP:localhost	$U1RP5Wv0hanjBDwRKwfx_IN-pwmkNQBFmdL2bWfCT9E
938	!dKcbdDATuwwphjRPQP:localhost	$Pv6-qkvsZVbhgcOJQrazAHXFEjJeXsgfaYv2-C99wKU
942	!dKcbdDATuwwphjRPQP:localhost	$eHAno1JcWsWJGo1csGW_iqvHLWd4gnXcqabVV8kf_JI
945	!dKcbdDATuwwphjRPQP:localhost	$XioofOPYiW4r_WbEqtyjNOGgyuCSgHCJQ4bK05RRPtA
962	!kmbTYjjsDRDHGgVqUP:localhost	$vaHUp3icRaWD4K6ZKyD-et7Nn1NweIZHbKchZMVt2Rw
972	!dKcbdDATuwwphjRPQP:localhost	$TWxmvclcp3cbkkj07Br-tFntHlAs1PkRujDzAiY4-0w
975	!dKcbdDATuwwphjRPQP:localhost	$Ax9ycToqrEH0gm3gwLZT1lHC8_ESwJUoyH_5ayu32yg
1005	!kmbTYjjsDRDHGgVqUP:localhost	$RbOyQVW5BEVq-eubE28Z7U9Tr3L_i2b48gIEAvEjO2U
1007	!kmbTYjjsDRDHGgVqUP:localhost	$sknLBDt1inberFjuplW7jxDlOoHCoNUJuUNDDsnxcCM
1026	!dKcbdDATuwwphjRPQP:localhost	$Ianh3w6LnvE0xLwc2gL2TXCWStfILWBtAM8PVw5YQnQ
1031	!dKcbdDATuwwphjRPQP:localhost	$BKDK0b5t8vbw3PdmyrSvR7u42Y4aw4d83Z8A7tk9ge0
1037	!kmbTYjjsDRDHGgVqUP:localhost	$AxczXKeEcoOyFPeF2VP4ub-x4drIISUyi-CQmMdvGuA
939	!kmbTYjjsDRDHGgVqUP:localhost	$f8PsLL43ywA0ViuTZPBacDkI0A1kKsoO32w7uy9NKvU
943	!kmbTYjjsDRDHGgVqUP:localhost	$DxWfkgU3blaHHVUrxChCcRjq3Nelrux5tRXgh0GrUNM
944	!kmbTYjjsDRDHGgVqUP:localhost	$u1GoamlCBjFISjI26GC9-bWB23nle0RthbbnczOzJYI
961	!dKcbdDATuwwphjRPQP:localhost	$H0g3tJyU7MkmPdlTEgM0t2oPHcg4U-Hy5XGGGdr2Ju8
976	!dKcbdDATuwwphjRPQP:localhost	$nBOMyFFdnjMXGAuTP_Hxt92V1C2ToBf7dWep_TBMXcQ
997	!kmbTYjjsDRDHGgVqUP:localhost	$RU23WBla7uK-kp138KgbR17Nu4cyfkmu9lJTzkaj59s
1000	!dKcbdDATuwwphjRPQP:localhost	$Eqj92dZexS2BFOjNuZdKef9x-VyhVKLeGyiq6INcx2s
1004	!dKcbdDATuwwphjRPQP:localhost	$VxgZXjCh9QTcXhW1XRTKi457xYt9quUC3jzvHAR8Ww0
940	!dKcbdDATuwwphjRPQP:localhost	$gyvkaB8MG9yhra4pU98I510ZEmJu5gHewCcl12hsUgs
950	!dKcbdDATuwwphjRPQP:localhost	$oX0YEJEcDwHx4rEonsuTu3qq6VSeIs0Hxud4q2uI0b4
957	!kmbTYjjsDRDHGgVqUP:localhost	$-THTfCnYNhFPd1pCqK8eHM1KzmhXk9QprttnFcmehNU
958	!dKcbdDATuwwphjRPQP:localhost	$J25SSHQ580TwL2PaQ3X7pN8lRh12sSkytpw5iX2DP0c
960	!kmbTYjjsDRDHGgVqUP:localhost	$WD7Ca8vjw3mnkKT-3S3gf7nLQCEel4hYIHGs9NyHQSg
964	!kmbTYjjsDRDHGgVqUP:localhost	$jB0RKIdA0DMe_-ArFR4koGzIaVn2-QUIS2j0LvvpmOg
974	!kmbTYjjsDRDHGgVqUP:localhost	$5WqnKxZDDRKKOND2WiFRmGKwBeIaogSd6ssh0UGBBe0
979	!dKcbdDATuwwphjRPQP:localhost	$Bfy3cyYNq0jWBV1SiAWVw_Muw42YEywDNP4KZX_cmS4
981	!dKcbdDATuwwphjRPQP:localhost	$9PNJUS0Xzdt2mT1_cGogdqKZNam3cvGWeTwji0h8F4k
983	!kmbTYjjsDRDHGgVqUP:localhost	$rPd4eRZuw4gMED2ZgQ5QzrHDG9vs2KxSGiEJuywaSig
991	!dKcbdDATuwwphjRPQP:localhost	$wrRNcC95z8kNum6xy4uzvZZrWy5mdgaBA5wBzXTNEuo
1001	!kmbTYjjsDRDHGgVqUP:localhost	$2XJNTEwBvofIAsDeoJod7N8FA5lLi2fvg1lep0197DQ
1006	!dKcbdDATuwwphjRPQP:localhost	$wUX_qMEINo24BqmqAvkpiNw2glTMW4LHZpMaUHr_t9w
1009	!dKcbdDATuwwphjRPQP:localhost	$S63yDopPO5_rwpA2OW2tIZinSCVLKuTbzk4oEBRxgFI
1012	!kmbTYjjsDRDHGgVqUP:localhost	$Xerc4F6QP56C9IDgil5R6nTil1QaTfQxFumBkDT1v7Y
1021	!dKcbdDATuwwphjRPQP:localhost	$q1f5f7RZf3ShRciHf6LpnqDFeeUt1PmvWpFzkJTOmd8
1029	!kmbTYjjsDRDHGgVqUP:localhost	$W5fHfwoXRnIhIuaVb5rQXsckfOV9vfuKViZlzJb50Rc
1030	!kmbTYjjsDRDHGgVqUP:localhost	$7trRPgicvr3J9eo7CZnurlYNrpqODvSsG0jeIoGSQ6I
1038	!dKcbdDATuwwphjRPQP:localhost	$Hy7qRiuA1WtbS-SqRor01L1jg5xibrbS0AHNujd3uTs
941	!dKcbdDATuwwphjRPQP:localhost	$KHnU1mW90-lDo3CvCU1ZY1BYl1BWPyv6oOGrrbFuyLs
951	!kmbTYjjsDRDHGgVqUP:localhost	$FtFYj99c795gtnEpzQDJmGcruD1mQAzmW3xxOhaGxaY
967	!kmbTYjjsDRDHGgVqUP:localhost	$Xe_3ouBgTJROO5KtF2SKTiVPbOKpdrRbx_f_Z0d2bP8
968	!dKcbdDATuwwphjRPQP:localhost	$OrcSApp5fTYSxGAsF4c4cdllJKLvBbQA9t686yvOw5Q
970	!dKcbdDATuwwphjRPQP:localhost	$OKYDeKcKuE5Sqea283iYY6oIISOMtXeVO87QlF2ezPk
973	!dKcbdDATuwwphjRPQP:localhost	$IQjPUBDt0lqF_IqRU8SyXXtk0wMCMqWB6763g05jDmo
984	!kmbTYjjsDRDHGgVqUP:localhost	$-03PPbJsZ-4R5pTB0HnA6hZNWGVK4Ls6yYKkjs-7sVE
985	!kmbTYjjsDRDHGgVqUP:localhost	$_4KyGgOK7XcsIqBpwgOvq5mQ-2EpswvfVA5c5CUfvzk
986	!kmbTYjjsDRDHGgVqUP:localhost	$XFciMBCHzLHzglWGjo7Y46fSDPsvhJEOjyERGXimHXk
988	!dKcbdDATuwwphjRPQP:localhost	$1PHABpOxMgE7GZ45uAp2l-V25ZhYj1g2yxMT9kqS2qw
1002	!kmbTYjjsDRDHGgVqUP:localhost	$RHRaqZf8SAKDZtraUS6sGwbkuG0HpdlXNLVkqEzoaCU
1010	!kmbTYjjsDRDHGgVqUP:localhost	$vg9InjRobCW_TkERR1v5zFWEDPeaLMeAPrF87L3CVoM
1014	!dKcbdDATuwwphjRPQP:localhost	$f0XoBBhr0WGqO1na-Rj4ptEiM2Y4_GcpGWYt19jNPt0
1025	!kmbTYjjsDRDHGgVqUP:localhost	$utObfLdpdhbzbO6WL7jHJo08sbENGYYLSHcEfxroxQs
1035	!kmbTYjjsDRDHGgVqUP:localhost	$zVgLTLhhOSNnk0PwxjrNcUyhlIh0ymB3nqDfRgtrhKw
1036	!kmbTYjjsDRDHGgVqUP:localhost	$S9aSlkVGMguDuHSyYSV3I7Hld-dMkoINpACHewuOlqQ
1039	!dKcbdDATuwwphjRPQP:localhost	$BFx8OOBE9ldqrtR-WVXRJk3026ZLoKoFCdJqEaS_Gzw
946	!kmbTYjjsDRDHGgVqUP:localhost	$eMO1a8LbT0MoTghsDjUz3AdR_U0XLCVpJb9sCRMpfX0
987	!dKcbdDATuwwphjRPQP:localhost	$ikddfOX3Bm6klwZgH_y0dTAvDQLdgAfIqySoFkvM5fk
990	!dKcbdDATuwwphjRPQP:localhost	$_E3e8IELPZWLv3a_BSIVG15oJFRxdYPTM0s7d9RZxMA
992	!kmbTYjjsDRDHGgVqUP:localhost	$8GhA1X9NrsD2SC1lmIgbZChA0ELl1T5OtBKykBC0k3U
994	!kmbTYjjsDRDHGgVqUP:localhost	$BgNR3RY9_lqeS5hYZk8urht2LuZAOnkso-NKW_Obg-g
1003	!kmbTYjjsDRDHGgVqUP:localhost	$agBDUziHZML-GANL4sngL_WSqquMoCEkvgZAoZZyGow
1011	!dKcbdDATuwwphjRPQP:localhost	$HI8RB_6QEYGUGm6GKjA4cP-KmhCKBgX29VRl7ILnoTQ
1017	!kmbTYjjsDRDHGgVqUP:localhost	$jqBg5fX8xkBXYOef3MU6xMLLrwxSpDqBYHmdLAOujS0
1019	!kmbTYjjsDRDHGgVqUP:localhost	$ecijDduaN75a7OH96EOFYnFtunue2UjsVQpEnAJQ_Vk
1022	!kmbTYjjsDRDHGgVqUP:localhost	$JMrtbwuXTsGJm0iCeuYdEK-sc0OJoVyTp284RbFiPxk
1027	!dKcbdDATuwwphjRPQP:localhost	$rykziPHO_QRv84OWAnP2b2cfd6J7y2qsPSiZ7Nn5fAA
947	!kmbTYjjsDRDHGgVqUP:localhost	$cHFEKJTWjxxkf0Tg0x9PKG3bqzSRIjtm5U-aojVPNLE
948	!kmbTYjjsDRDHGgVqUP:localhost	$spGlG1nNJ_ZwfrbkOFktJw4VzFbvtEjfXc3SWiCGeuY
953	!kmbTYjjsDRDHGgVqUP:localhost	$1C7mh1YHcxQ7j6heTRZ9ssc7hbKNW1NnCLf976LZ31g
954	!dKcbdDATuwwphjRPQP:localhost	$5o6FPK62p4fj59yAbT09AmqQSRisvAWMBRYrqbBMnGI
956	!dKcbdDATuwwphjRPQP:localhost	$gQ0tfHL4VAImZtSGv98j2QTgroJDMdWgNj-I-vfIOMY
959	!dKcbdDATuwwphjRPQP:localhost	$BvIAcu7X-pVerZzAcnnMMBAHsRG9s_0cmS3SziPsidQ
963	!dKcbdDATuwwphjRPQP:localhost	$06iVkq49_UE3DvUBOZT4F1bKi_5vuUYGL5O_2uFmz68
978	!kmbTYjjsDRDHGgVqUP:localhost	$eMdSavESc5KzFHHeHYRlDCTETslWEnS47aMKTnGlCUg
980	!kmbTYjjsDRDHGgVqUP:localhost	$ycfpT6G0jh2ZLuz8qjtds1HKJwdTIhzdc15zyvA06ic
998	!dKcbdDATuwwphjRPQP:localhost	$D8vwoPiHrlQfFnXl28i2_y3g7e83H3zGLnR36vXn9Rg
999	!kmbTYjjsDRDHGgVqUP:localhost	$poOEP0hoNsAgo2HKfpnnqjX3zkQd6RT8uqoManoi-WU
1016	!dKcbdDATuwwphjRPQP:localhost	$Omqg6b_C98_sehCXjZoa0UxiP8vDLmHudV6M-Fgytb8
1020	!dKcbdDATuwwphjRPQP:localhost	$R6Irg0_ZxIzVpewB1o6zmlntWcLnN87hcrN9jb7TOQg
1024	!dKcbdDATuwwphjRPQP:localhost	$QyL9pmQvCJkMuP8nEuBAGkjcG-gkAmzYNd_huviEiio
1028	!dKcbdDATuwwphjRPQP:localhost	$YdvWy0WXV_badjRTtOSj8KttXl3Y9mZpHdHxlj341dU
1034	!kmbTYjjsDRDHGgVqUP:localhost	$0qcvynOqGjem6f-Fx4C-oPBN_Avka5y_UDxu1r09xAg
949	!kmbTYjjsDRDHGgVqUP:localhost	$tmCfdvFubpDkXJ80CZjZFWuh0uczo5-ksFUONI9z1ww
955	!dKcbdDATuwwphjRPQP:localhost	$AjDYgpQJQ-EFQDypFcjmMh_x7dTp9iaUrmJrAenn0TM
965	!kmbTYjjsDRDHGgVqUP:localhost	$5l5MFZQmG8xBxUmmKc6HJyG5SFzlszhqCawT0WXlDqk
966	!kmbTYjjsDRDHGgVqUP:localhost	$sL7pWu4kWsQZRUx7B1VYMso1uxsjnnQ64Kw13SdjxbQ
971	!kmbTYjjsDRDHGgVqUP:localhost	$ZR6mGfrtspbmZif8XIKs77dDelL3yUoAynBo-VoExQQ
982	!kmbTYjjsDRDHGgVqUP:localhost	$8Q6aWpZctsbNj0WH4PbSyPe7J_p2zHk9m1ycNoD9F6E
989	!kmbTYjjsDRDHGgVqUP:localhost	$sgHyC0nCMspBPkOTL2D8atjF_ss0Ma_HGfddDj_hWQw
1015	!kmbTYjjsDRDHGgVqUP:localhost	$mJBmMspKDM2NNjFgxy8VH4IkIekwf558nJU7KRuToh0
1018	!dKcbdDATuwwphjRPQP:localhost	$VF61G_XL3LzEM4VHM5Sq9OF22D-4JsnA1E_0Rm6iBQo
1032	!kmbTYjjsDRDHGgVqUP:localhost	$gClqFb3XOmk1NsNHYNeltHzaerMGUglVMjyEMDUj5DE
952	!dKcbdDATuwwphjRPQP:localhost	$MmlCrgErTy4QX2RP-B-FbQ37d-ahGAN27l436s1FPis
969	!kmbTYjjsDRDHGgVqUP:localhost	$EwRNzdoiSbeBupJKnjLdLIVWx5Jtx1ANsJIpo1eJpK0
977	!dKcbdDATuwwphjRPQP:localhost	$zMXSxScyZcVORRyX-ew51P6Q9lfdEVEclRbwpiA8tJU
993	!dKcbdDATuwwphjRPQP:localhost	$Le_nW2097lSPYaktA-osQO0l5O4sVZqS84wr-rU65wk
995	!dKcbdDATuwwphjRPQP:localhost	$svHa1avwjb0nPAdMXMpgfgWk0o9DPEd9TosgAiDx7to
996	!dKcbdDATuwwphjRPQP:localhost	$mDgbocfMQuuIt1dYIHuTh1_3IhhfSrqCviBgNrKt_gg
1008	!kmbTYjjsDRDHGgVqUP:localhost	$hXP6XeSTT9cqOBiZzKpgd4ZlzS6nZ06SebynSN-22nM
1013	!kmbTYjjsDRDHGgVqUP:localhost	$l6M51erSVO4aqbVrTfVUYwXVq54maLwilx5p3qQy7ac
1023	!dKcbdDATuwwphjRPQP:localhost	$1qIRJkqBBHrS_C2B0hqSKfBvNtzRxWgv-_PER4wv-r4
1033	!dKcbdDATuwwphjRPQP:localhost	$vuIxc5VRd-ePuUe8UbIhRaf5SdJIDCVV0qITYnLLbds
1040	!kmbTYjjsDRDHGgVqUP:localhost	$qSYdaB2QTLfIIEL7dBmuJruzc-mKG-Nefl38gdyhquU
1041	!dKcbdDATuwwphjRPQP:localhost	$ELhJW-lL4dy0I4EjKy1CfdleBEzYoQuY_0HWpoaxszE
1042	!dKcbdDATuwwphjRPQP:localhost	$TY4fFx4ngtnMc4pBhnSwhi3hcL49ITM1irEtrQA7T5I
1043	!kmbTYjjsDRDHGgVqUP:localhost	$8f2B77O2KT0xWYiDjO4Zm7j8nCwL6FuvJGUESnaPdTw
1044	!dKcbdDATuwwphjRPQP:localhost	$wZu5tGB93bPuVZNp1o-P73x5suuYOc--iJ4PMNlVpYU
1045	!dKcbdDATuwwphjRPQP:localhost	$HmHESDB8fY8Im7ve0zC1OozLZNYRk2AqJZx1Mqb-k-M
1046	!kmbTYjjsDRDHGgVqUP:localhost	$oErofAhwKwSjdiXrb2fNmGAh0LPiRs9cToN1F4qZ0UQ
1047	!dKcbdDATuwwphjRPQP:localhost	$cLyPQLPNAQxHnlfS0uc5n9Y-olvHZw7O77cixROreRg
1048	!dKcbdDATuwwphjRPQP:localhost	$OJ8r4GjCqT7v0XHcQYwUTnPty_DqwRKpqnbXfsehlMk
1049	!dKcbdDATuwwphjRPQP:localhost	$i7E2SMYyfjgOCC6_5zZmZekndFTe1E1OO_y3n-xJCUM
1050	!dKcbdDATuwwphjRPQP:localhost	$QOBIHSHhJGkmSpFH9Db8vwW4H_icaL0JQpD93N73oyw
1051	!kmbTYjjsDRDHGgVqUP:localhost	$Wolh4KSqw4kE1LtzPphtfG-Akiz9XZ6YpBgVBSNmJ7U
1052	!dKcbdDATuwwphjRPQP:localhost	$jkiMQr0fqAR6Bk3sAwdlc43-GwVkk-y6LvIuExJIXEA
1053	!kmbTYjjsDRDHGgVqUP:localhost	$nTkvX5Pck4CUWA9ZVA2-ehaERvNr6sCwlLohIOSSixc
1054	!kmbTYjjsDRDHGgVqUP:localhost	$Xt2ED14lWsgZvSeb-eXZLi3nu8oqHJ9tdbFEVWN4vB8
1055	!kmbTYjjsDRDHGgVqUP:localhost	$AQq1Or5Cjf-8MCOiU1fijOp6k7h_uQM-f8gA-UnK8DM
1056	!kmbTYjjsDRDHGgVqUP:localhost	$qCd62sqU0coqNfLVfdVG0Qis8VCggOIrxMW9RRYlzIU
1057	!kmbTYjjsDRDHGgVqUP:localhost	$sBCT80i-N15EiC23L_f8LbXkoUPx7l8XGo_DolkYHPk
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
22	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$oPNBx-eTHzyLXPzpYpdxdhLdVeGmx5lNmrECxIazfPQ
21	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$3pZnE6ITQzzyNsuVCenuFBVRMocr892PiAvIbMGbMBM
23	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$Oqb-EaDS-8U6U1Z6bTGSE7FJIlxKGhzMkNsnYIJY0Y0
24	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$hJeKBcpebJzm9oiwjDCNTWPtbEcfp9GOLXl3yGkyaFU
25	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$9cACT8rCcbUXbMhABzEciyF9pIIDRFNzaBkRVPH_0mk
26	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$0gxNuNkWyOeHPtnNZ92FzvprItMgnH9hLCbYuY0Vzos
27	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$9ArTh8Z2w2oc68FOD1X8Ka3DlK7lq00HaHKT_4DMSY4
28	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$V_uchZ_8H2oh6EdsXqKsT6Ri62_YZtAAMfZi8pbBGrc
29	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Q4TOA6SPu2kQIrypB8QEJLHphxV5mHZ_eFwQux4jWSY
30	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$YwLlyzcAMpJ69jsxTNglcWTbK8XHK8huc6aB6jpgEWk
31	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$_qmz4Qfyozj7n8l7PRHSQzTSzbhu__B-wlB74YcT9ZQ
32	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$jfm5A0yxQ8B1hRgqCEVhjsNN1u1S-DjTjhDsaFnUCbg
33	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$acVS3JJiynka-P6x16zaA0A54ALX8vu_mvJwobIw0Ig
34	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$d7DBG0H7S-n_GLC2cC0UFgyntugHIFjIPmi0DpBAODY
35	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$USV5WNYJNpxK534dOjGXmqI-018r4uXLbTx6RD9FF7c
36	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$qNTRLk1wSqa3NzGbKiDcoJUR2iXEzgfRmYIRHSzyrws
37	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$s_CiX1M8vzBe34vqSRs7OHqehdJk6X6veVlkJL9tD0w
38	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$uLhb0AAPmwVbnsOJOC-DgHyRJc3xdU3yVqJoXQKeTwE
39	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$r2pfZV7TBF33N9GSPzCDuCRktoPTY_SdD_c4cQY74fs
40	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$aDLI-_gaaN0AqME_UQKGBhDruqAYxQ1TFmTIelqacRY
41	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$hf_SzqMjWH2a99844BZWQ370Z8fxb5VmTVmxO2rUH7s
42	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$PfCxtlQvfKX15DGv8hl5JE_FSchpfxzwtlfa4I6ekQU
43	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$nQkSaQ2x8Zz2QwOhUJkjMueeJrfFpearE26hCHOP5Fg
44	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$popNZhEfogEXHtQjC0j6d1Y8RwQhL38dw6il0G27guU
45	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$nECeEyhkAesTx9vdKnWqYfPyYhegB5Rq45sCMHrKk7E
46	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$nJ4yFPhyTNytm118ESavHKdcfx8kBbWvS2LRZScW9dY
47	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$KVX22PlqJxtdV0aJPjql7nz04yVNfoXjSA-DPbJWfyo
48	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$ou3AgyqgCApBHPcw67tKPrzNrHS--stDRyAiFnV0Yek
49	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$WgNJkwLwifQ1nedcCx02Q-XKrj0RSONfOZAkuS7yoKk
50	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$V_KQhQvxJRwrWBQ6mPpRQhjvI7J3WZaGkokjxtlhuE0
51	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$rIaUREO5pHlPmrUPjykYdzMOpq1XgEy0o7c6wNSk6Xk
52	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$MvgmmDq0C_1mtWzBrVa1jYul79bvavWn__51KlLYxP4
53	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$sdZQNeTf3qJAOEBIyzpLNjZ_OXbBsyca4rHb2UhnUVI
54	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$Yop5FSJS0WFOgZ7TDC59sc2zmda4a7LJVl0ehBu3itE
55	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$DTXRpEhUd7mdlAFRVkxUz189zGZBkKF5Y0y3dTxUpQM
56	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$48GtrF6umRd7vrp7U62OwCyOzTWp0Ni9f0pEKA-lXjU
57	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$m5XjEKLKBhkaFNIpPJJDDrbOAS59kLsxznvHGRf6L-E
60	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$Bqpmajg0LyajvlHQxgMkqHam2S7NmfztmOk6I9cuRvU
58	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$ae08F80RJk2G6TsxifBGOd-Vonii3XfrMX4x-IA-EL0
66	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$ATSVoY3nonCv1003gK9zr_dz7k08lgBXFqKan4O0UKU
59	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$LDw2djChe3maKDVtD7Dt__-APjXjwEOUEW0utBfPu3I
61	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$Iqyv-g55dIENuYvzxfrMC_Z60HrXdyMIaZ5rzDPN39s
62	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$aHpnnBVl8QMov-uTe-BAYQbN6e3bgtjYYohmVanVJ1Y
64	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$unCM-ixmKcqc63QDGcDP9tdZgM-o7x2D9hO8eHrmgCw
63	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$iSEvBSqLEOR2CeW8pMxtwd6NacnGVhLdhxJmTcBxBok
65	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$usoPaEyShWpI6Zd1IXcy0axfqcri4UdV_8Kl7MxtoAQ
67	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$xGGwbMyjMNYdpCeNDCocZRIPHcBwni-VGVpLj5yl4hk
68	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$rIQO-ynsAFnr8hCcUhBI2uc7kB_Rd1T64Sj0eDTWCeI
69	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$i0HpyyuVBOdXDoAgzLOBmhiM0t9N3bOQVhPxeVMEI-c
70	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$pmx--naCjTlIBmLXhZfbqq4tlGP4fz9j1orntNdZOc4
71	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$7TOt5bi8CLlI8eqofW8vh5zUMNPoMB7vTlo7AJF13vY
72	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$P9VUrha3ThmrwrRBNWSv9px-7sWpb3LULVpqotWHatI
73	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$nvTZBtj-PQ5IV2J3K4bi3Oqm9Bl5gcsNTSEN3CVpPuM
74	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$coz1sqYl20OmVpPyIlGfh5cb3pi8mx7LDKg6UtHro14
75	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$Pycmsw9PlnIrjJtSB5CsNVYe8fk_auY93e154qgiYik
76	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$kI0jRX0XMzw8dqKwTMQ-gWoPIHIbkNxGWzCnfEYKRCs
77	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$EtDG0MJ1-_jrNT0yivKm7iqcGwBL_U0i5nzvbw5Z1No
78	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$JQ00qR2uxIX2Bt9CTt6XrbBslcLPn-GXc3fSjFDDXYs
79	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$9OcrwYcxaebwcgsyKqqk-B_d7Wfwy6G-_dIY0go3_x8
80	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$risHeecWr-hzwPLZLbZ3DBudjb9nMkSKnYt4PoW7ynY
81	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$xaA2PsHmpEnOPsRnEG2bCQcaF3JEYssBvekk5zaW-qM
82	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$UKAe3SE5Jg8h3YejSMclcqmdwhDaACGihBDMcqmD5HM
83	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$leRZrZqYUugoJ6-lFkyC7YxwyVWeMG6IM0w5DI55kXc
84	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$LbUvf0WjS4n2q-lymFry31bDBJfqpLpnKxbwByvnCJQ
85	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$d3MyOohPFDD6jTC2R8dX2fqtFRG8w-wMhl4JTXP7G9A
86	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$ikN_5HY1a1dd9pCNZRbfVT8AWtVeUDGVIe_qm_TA1Q4
87	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$dJHNMbUqFcriJyY-hR2GUZXWyAO5_7F9Oi8SeVx11Aw
88	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$BmqYA62rtzKhT1xo_JEc_30sLc2ETiwznsZilEeMOOs
89	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$PoEkbdkddNlmuLMF-j1MDakZ2Gy4r8l1LbXoVbuPRvQ
90	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$bwfeqLdhox25JxjpMLqCnW1alPiUy5FDsgVUB9LludA
91	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$35xbm_hEmaUuhFHMjztVvnFxs-0x6oYbGitJSK3nXm4
92	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$t3r4a5f1bvQ7BoQoIGRl9qxLxn7IwcdI3naAoA4ZqTs
93	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$nmJDtgqNIL8GMfIMNLCNEP44FCfIKzCgjZgJBvI_hls
94	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$zcbpA8GkElguaElYO6FN6PV3khRSMEivUMbuxoGTzMI
95	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$v1IppjRAWKm5718PgejseTWkId5beUtE3kAwQTRGlgE
96	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$YOJzvxoU5aa8HSOK5-ezAvDPSedHxCpN7CRmfb8wdGA
97	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$PUVQLmAjdOk9N4GRcyyCv6essAMVSBYz49zwqT8ukCg
98	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$mV0cHYY64EHmZjKSc0RdfpQywBPQ04_sixaJwn1b6q0
99	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$-Gki9QWPEDpKK1abH_WOAgBCArzjBXpr6tH9KqSGG6o
100	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$_HBabhQkhIR5ZWeYcdVcx93COjPtIBmFziWNl33lWiI
101	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$7KbszJFmbcLxlNjNZ3HsxDbWnmaC2qjGEZOPrW2G6ZQ
102	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$waoG8h-WFQYHxKC8AsWntFCJGl-o_vCQY-2sjSuMYaA
103	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$QafUUpSFDzHf7urjWYBQrWg7ljX_mEmLW1UFJr8NRuU
104	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$vCTIFxoTOiQ-zlHweDsxldYZu9EOHvQ_cReY8bofAeg
105	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$7oYDUZRJXIlLowf-Dk3_y7PgGpEb-nnMVvo9CspKtB8
106	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$b56h_G23WgTFneRsieSw8fuSFWQ0Iak0WqbPCNnlzgI
107	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$--OzTSfx6OLS2z01vk7ZSkK7pYS0GvQvtjM1PUiIcDg
108	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$sgR55JrwZs41WCpvkVV1GmVYFkN_kHXth7dhL54duT0
109	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$oCfdkHMiZ41Sl9f5jK1mV2AcdH1k2-Zb-Eia6E6PHPE
110	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$1dlFgBR4UPO_Z8BiuVqoS7aoXp8FwVkwGi9olFZw8tQ
111	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$3Uawz9W0kWhLA7yXQGUCPZJBLUav8zggG0jQgjKnXx4
112	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$4Vb-vRiGRUJUaQupVkhlgbIxfb9i497qcKCdqRa4_D4
113	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$L-tUkq6pvfFV4CowSgK1VFPnySWe1_ObifUAmpCKRZ8
114	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$YQJhR7m8MtzU6qKCnOvWNhQeVoOo_dIOvLFqmVTys4U
115	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$WIFmXGXHDTGyySDLLB2gQBNoZmNBcKkG68_UnFAQaDI
116	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$qaMLS0TiRymLVVSqZVcOpYzEqFbQIecVpWhGAWi_8gk
117	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$iyR4Y8_Y8e13NuUST12XUbaD-kz6RsNy61u9pgGlf9A
118	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$3e2HAzbj6YIoe38nT8UFPXKNMiUB7jrjk11X7C3eUbQ
126	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$uvUjV1EPaViweersEx-EI50UdZbmpEXsas3JyI1cQ_E
128	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$3p5TueEGAyGWRhmvG5mGzj5aaVsIVpH9r2MmENsQOko
131	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$NNFR_ELqO0aie14zdx0yx7iMsg9otUzterLCRUaaRx0
143	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$8lo6SyEw2oKEpOKddwkPlIw38G8SPJ_7TXcwWOvVNHc
145	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$AKFTxp-f-b1pK8af6Xd1oRqF5h6LKQzKL_cRaKREiBA
150	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$ucoD35tor_bS7YI0fjODTkzWk4NrhzQhbWbCyaErmQM
119	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$HJaOHRV_oyXSVzF_yen0rElIAKJaBViFH2kzwLRg8DE
121	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$-1p5P1AmoBeo5PVTs1_crHkRV90iBspXMAPMXH9u7wo
125	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$71h1qpIMl5c0QQ7dNa76kjq2RgjMukTWZIH-fZVoE6s
130	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$90pFqNQP_FtdhXnVMw8ThE5s70xkE9xvOekrLiU6tLE
138	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$M4zxF8DQoxUjI3kZjRWDkzSG17hiH4E2wqnb-wuEzzw
141	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$wjx7Witiki2sztuyUmQuVd2Akx1PI5RFNCdhoWv9OoY
149	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$24M8TONdEXe0IHZK1WX0FnOfAv_bQOEcetzmzmwawXc
156	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$YjpnlEJ7Ezr9uJanEHfQ8WgOfM-erjoLvePIqSwT40k
120	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$FBerhrQP6kAJSfMLv4t0Jeu3F8O9NUbkYsavrSCGXUA
122	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$gSZ8u8AfZm231KIjz9Set8L4bWCQ0VPTWX8dyJ1DKdA
142	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$R6-HznqkaOqidL5UU7FavatIZ8bhHmg5kRrI46oOoHs
147	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$62e5TUPaMxCYyA9kN1x5QRrMv-D7FTVuKVC889a5C7o
148	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$yIFSBC4d2KfNwbPhmAEkQfa9Y0pJh5PRgqHRZ_NOZQ4
152	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$sJNodrV3k_29LZcUktC996ixsFLffBXXqwo8wX61j44
123	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$WCf9yiFLFk6b9s7pp1oXNL49X3SRs71S59dWMPHIi9o
132	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$lPRSMvyjjz0eyXCk7pB7LP13Ey30fyd9Zrnhj7OShmc
133	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$qKsurgjgIOGPa8UIKFF-XVUvkI-u3hQMpCiTbNmTevM
135	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$h_jic-9IKUfkajx2Zj8XaWeLQbuVoh8mtORfcyzpe6E
140	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$Vk-59jkK1bF7FpkM9SF4-ZRJ4cKO6iyn5dBB28nwiCQ
146	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$BhuD2dOxIdItBNRr2V6auijOWGI_Cuc_rT6-H5mehX0
124	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$NG7Y90KLE1Yrh_SNf8c2oHqXHy7VeAwsvgwavUWsvLs
136	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$Pbn7LTLYrHwuoXncIedZ8zT_inyp5Q7o_jXJ1s3KlHA
137	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$l8b2cNYmji6ZhDdDrFL2y1cBa2-rHurbHwtETRrCfPo
139	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$UDuUfSx897QK7x_uj3k9e9dLHpD8pFupIL-g2bKOTqc
151	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$Iacj7emwQCMdEBryp2JBpjUW3tVaTm-BljibLn-ORSU
155	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$q3vWym5O1J-Dc5KL8b8bxJfFvSqgcCIH3g-1qJqijJs
127	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$bZDgBKRMuUZ3izP3zZgpeROaTU-y1cUucHXLbthta94
153	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$CbhgFxv4qYQ-5kFPYrTTHxfmCU_G2M8Vxqqu5Huieb0
154	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$kOk9Qyp0UpQWZbvotwi3EqUzWePNtjedb6koDUYBWN4
129	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$YNTVLRy40AlIL_DF3ttx2C-BvVXJZKPsb-Gpwnw2cBo
134	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$d4cLbE7qK0Z0sSqVwfFGr0opSBAmHS3B_34YVOLSdaQ
144	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$S4gLjVfRMu7fHIqyIwU6ap1fzuD_x1MvJYXXbmYp9J0
157	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$3wo4OUf38lhhC2kGx_Sea3MSDNMGg5ktBgIdcSJILyA
158	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$au91nTAqaJxHDNk0q6LjXKKokCa_NO5IWPLaUaQXpao
159	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$IlP_Ey_bLvv32m4v8Eq8IcVOhfvNnHBTQ8aZzIB_2uU
160	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$GEAWg-VDfh5ouAGhqRTobk45-UTxoa3mCsV7yqBZaIQ
161	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$FLhgsKlGmoQGVHahDyuLlFuYvqss2CZBrVZ_qDWm8Dk
162	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$-jSOLzj9wYm5oZ7extQEKsPrUvWrYcYMWFTcN_oV__8
163	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$68F2BwZFfoMSLHwCWKXISaUFuoPYjD-L_53cRhJNY6Q
164	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$qByuRMWkaqBaClwJhifU4aKMvZQtKGxJWd1MYoOck4Y
166	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$5o1bZvUXxluZkOPs4Pww8q7pIGeURStwISlsLNPORD0
165	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$IAmu7HTnBzathinTcwxJWk7og6NmDpW62tt9xKjPHV0
167	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$oc8Pedo518lURriTVYcIPmWartodeL-2fWApr5vaUgs
168	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$Mn-KEUfjJuKKPWZWxtu8OUG4xWhVAhXXT3rtq2Y_Plo
169	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$lrPOzuE1RGga3yFPxlSYn4wBb2CRmnJd480NhWje5j0
170	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$XityxPYrDgZfKW78NagU4iv41VSma-oWHsrCTo5mWIk
171	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$TFDhQsUAJIa18bDRoRT2TeqrpKX017rqm4a3QXHhCwI
172	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$4ir1AmNdT-NsanlvDD0v_tu_eZz1Muo4DnyI9HUjCGg
173	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$tnWlkm936_vB_Y7hIm1xitvjYyTOTxvjRimKLFwXAes
174	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$SXOzqaVuzZuli7jRexRfjcBkG_Lo8bpYQFDPmubl-zo
176	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$EN8AVCSmlEDK1ICFP87t_RF0u02PSlLg5C-Ua7yY_hU
175	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$zSromuuyxxtiOuvXmZhmmof0fMhFrv8ciSfP2huUStI
177	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$Adoe1Mrg1tslCP4i3jY47OLMQNh711qCFdCTjvP5zv4
178	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$_9v_j7nrKdcJmJGC_a_ELETSNjuWlvm83O1y33w7vWM
179	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$tofYv9HtfGzOFkReTS_OoI0_OCa6YhG18wUS7QOVI_c
180	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$CopCQXMrMKDK8ilbfQO0YE4ilrl2T_-s2_O2OjDfc_0
181	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$FtaZD7iezke1l83dzUPNFG_-rVA7THcPafMYV5bVHoc
182	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$nWP9k0OOVSUiVHV-WzUEchO7A3AxxT5i4eLIO__6jug
183	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$FStGc70GaP_czNf50kQG5Lyf2Gp-n1PaRWg1bXNHqmE
184	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$W_eOOOWJJmqQ72AeG2ZBqWCKLBzydu8jp-IgDd0ZPjk
185	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$dXZVpq6rDuuMLODc8B-JlLnwftlBXKmM5Niwqbgu_NU
186	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$P8l2xT7AmZ_4vwUj8hjZKjwgH5D3TE-U1GzyG74BjWM
187	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$IS2TKt63YEYZcKtF2FoTvDIEoZ0gbV0Y8T0ANPRPO7c
188	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$CDRukd_j8EcynOp-aQFUiBxx8A8MKkIMpKf89DbyZf8
189	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$2PNdgt5X_fxicrWqiJSPxOimobaQkd0jE5NkuNay5Is
190	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$1owv4BeGwWuirb6CSSxk49vtgeQL9wXOLCiQ2bWEBUQ
191	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$oc8ce-nem7d6mExmr_sjCnSsc-UzQO0bWp_ouj1RDGA
192	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$rFwvNm3Fh-s9C6aLuN2l-EDC3q82QTZ124YCgowzi9w
193	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$r90eJGAZSSMAOd4wtqN7oORGSCWTwpr9vpwJ0FoXurU
194	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$-Kk-uF1ihIQtGe3Cbe82xiZlHtgM-olwXbH8YZagHE0
195	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$63KRjybQb-7TBYWwCqr23IE6hKz-Dj5acau1w-x3rug
196	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$wQBGW0PDXKVyt_23Kros2HpN-p0xdvQtMc40XYib5bM
197	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$mmaC3I6t1Qe5E74G5xHADrMClURQbF9QsphtChxhtjs
198	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$f5gOUNT7dWUgwHD1Qh4EcxyJkxGUfUdmEL0775sbMiM
199	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$glpKV7KxRpU8QAMVncN4auZgTCd2Ek398IbmYXz8y6g
200	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$0U3MdJjsG2H04UaxN43SeTtUoD9pRoSxNgpPzioMVEE
201	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$bEz2lszVOHZrYDBO5mP8509gTdEe2tvO9rqd3vzi60U
202	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$3gt3rfJcSog16uC6oIAgEdO55QTNiQrMjLfn26nq7PY
203	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$kCczrb4vQV21B5aXRV5r3em3uVq_MyBDXuJR9IP9ZbE
204	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$0OEGV420NSLHDNLE8Ay4wVZi-nEwnXASdg3-dghKPj4
205	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$pFJCgvmGwkB4CjrxW7vG2AuO0cheFo-eAxqopGa-wT0
206	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$WvMHRvklktudE6jsXWVhDCR4SFFH4DAQ5mRjt3fvliw
207	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$Z6oqd0kUneXuH4QnR4LdvdLsqjCO1Zbb2mJxl6IaCQw
208	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$l1XbvsK55fiW2rZBK4DlgHxUtIW9aIRCOMsxQ7pYxQg
211	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$ON_nHffY-9ivRAcJ0VhLypBe9lWZDk-n7suZEsMhsgk
215	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$j1Z2yVFXFVG2BtB5V0oT82baz_QKXsseJ8i_McohlPk
216	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$dTYKWKHUGuvAfPFvO7x6_vrjznIr0UcExIGylPQHm1g
220	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$TYy3n3KWkqtTglblIX3sNquoijnwEjjU33UXmpvW5SY
223	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$XXY3WRUy642wWEzMMIHgjuUMLThtFH8vrOBUJhQdS_E
226	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$fDrV9a9UoqlwY6lpml6wAPX1hT1ZOShyl1XCMcuH77A
209	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$toEhKUOOoeBj0Bzk4Anc_jJrFR0ZZqnpq_RQ16bgHM8
210	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$BdKah2K8bdkq-f_Qfs5TGfp8I5rW0FhSUewa1rTU5-I
217	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$lHWe9O10kJNhwG8XsExXySKPT8WMTJyJIOJZHIDZTzI
225	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$AtPnWnD7YnkDey-BIz2rcXbiTRwNA951VGs8-smyjlY
212	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$EY3wCW8Avo3IBGm1xhjcdan9iMxmeTfKSsZ2SYt9nSY
224	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$5qlOagXzgi8ze6oZuRyWj3jWuvJNunkkre49NzDXHSE
213	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$cI4VbMzLsBMqKIHR4-0z-9FcaxC-KZnYDPWIA8j_IXE
214	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$PbwZyALDMVfT5Ndle1YMxRAAdzCEnBhBQ7sIvZ9gCHU
219	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$j-j29KrNVPD6NvYKZqtkMdvSiYWKvoRbCBtB62GV1hY
227	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$kvfnYs8U7ql1lQ_cW-GrYPsOAueYLkAOa_zJjD0sssc
218	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$gdM1m1jg9Zzy3XKIrnRVqgqXtzKXd5TMaDJN5wsCybs
221	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$5T30pCSb-0tu3YZkKrKi8jnZp9Uoy2ravJfDd2X16_0
222	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$HEiCUyELxf6qbWFH0ZRfN_OcO444ZlZ1MpBtqmvOvyY
228	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$0W2TmFo0Va3v1is4d5QJZQZtghMvBDtTi_4wpoAdOXg
229	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$37C6gs50fW9iP5lMlSV8nT2XSya064EZrJlaa2muiTs
230	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$JBH7PSZFqS37yNeW7QwhiyF8hUnPDkJsv9xeMt4J6PI
231	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$27naR92ItDSb4d6cYpsDez0sVGBl0cwFvFB5SwyOWy4
232	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$CnVhO6-tImNZyMglc5Z5TWcxn-96NfGWFN0B_N1dUCA
233	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$VFhYAs1n6bT8dFPWBYgtkD9f1vhTOBcItBPGmCXnvzE
234	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$HMS_Th38vFRi74B3JXTA69rpMIGmmLeXwmhCgsAEiuI
235	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$zsfDuRl_MGqEO8y0jC7E4LNT8pPls-DPmwLVpSoeTT4
236	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$CQOkuHpe9Hs9A55hzzoBJLVHeOPJbFbVUlM20RUg6L8
237	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$kZwRpRTYdNRvgtvmpOvuacbCAsnqJQP_-7ZPm4fO2tA
238	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$uw3kmqBZU0lxZxwmMSeC26JMyUZgpMy5RkpRrLagrLk
239	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$yeZHbjrueGxcAOgK48SPHXvt5Owj3KgXcRAhW5IyHCo
240	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$Qr_YdPIFqgP3mwlUjmhXALRHhmnR3sOw3OkYVMcN3r0
241	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$18IU5mHBYgSq1KW4aEytpEXbtI87lnEJjusP64peV_c
242	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$DDYg8Nys4TjaSrA8MmWjEGT2adYfvl1nKGZiTGJfzS4
243	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$KsnEG5GXXianUbu92opCLA28Cd0UOPu_KzoJ90Gjelo
244	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$SfCRKwPjxksewV8ZowkpDyDQdRxKdEpRmrFap6JpG-4
245	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$CvZSa5Q2pxl9J9C8807I0kpwBTvDKUpMj85qVJSAVZo
246	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$yS_KH934Z3E2E35NExzDMpueAMSHr1phfIN1gd-lpKU
247	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$tn_mMSdxiwoYGDcWxP27aFtGLBv3cTi32-zhyO4ANJA
248	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$i6kzBKblJVqjJk_5PIH2jt37cxTdkNtuiuUFAJ_d37U
249	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$MtfQ2bGSzVvEftqxYFz7z-s3GS7LSDhEVSY7DM6j2_c
250	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$7WTjHD4DTeaKFcCFq8zO_4fkzx7N3jH8hy_-wRBgMng
251	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$H_PkF8UBBDuGziD1hRW6HcJeDCpXlGji-H6CUen1kwI
252	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$S2TfMiBMppdgtkLK2b_BCqAKgKJGqg0oCEsgjRfrNwA
253	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$WEwam5Z_026BzpuXUzlUNc6eTZhCWUhJy730_Td3kfk
254	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$xhTrxjEw-L03BXFexu_7xSaGXe37M_n_IZ_rX1dpO-E
255	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$S9tlcF9PPGtaEI59yL15N35vVasVBXGyqQqWfkxBxkk
256	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$Xy9BbtBfKTsoFHoubcomXzXu3Oxw_B2z32OzJJC4thA
257	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$udc-LLiFAn5p66x5mI7XlsQkzqYSwx3vcE57iaF2KzA
258	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Q0PSyYHDW7uad1QdfQpgDPwragNrSLq8K0FlJAUMYrQ
259	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$3BI5QI8diQv15jZtSKest18wIHm8ekgtfjhio6hjlKM
260	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$vJiivpudEWJl8hAVEvn2z-aTl8pmjHaRRVo_H8CZj6Q
261	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$WHwUvyIWyRVEI6f-lwv8v3z8eYleLqmlQnX55fFE0sk
262	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$6INlBRFopEr8U5oyPC08d7E5lhs9hrSm7RmNFXQUBq4
263	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$CFRxi-JDSA97DV1hcrHaTofYarPQYU1lHevLnOc7dMQ
264	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$B7yUeDblAwPcUtCM4Vvxv7q_EBEZvP6RqsotipPrKDE
265	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$irHFClZVEAzlAtsjct-1MJjEotldPu1Ozkm_NYQrtqI
266	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$8cL0dItrpraP5F2cmhITdceIBRXhBvULxV6WzwUt99E
267	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$VdJdZGsjhN1WDg_b3HSQME14AGAatc_tiTZB7QJ7PD4
268	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$ro5gYx1Rj5KWI20ad49-sE0-rMbGnb61fZyg14WVwt8
269	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$S1onw9lFlZOHGbgN_KsIfyR2ZLh9lw1ujZiEHiZapC0
270	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$mP0N_R48Yx7r0aUN2nRioVVtSLvvy7pi3ya-ETppGcs
271	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$qBXrFEx9sV6QLWGBqzLXa3mMUjmBhazGllLtIAAclHo
272	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$FNi1M3d0ESEkXAd4NVI7ZLgXe6PVp96CkD0fDy-6sDk
273	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$ekP0XEZr1V9h0ai9bfxRsv5oQOzm9G3gAW_2AcIUjrg
274	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$Vy9UYj-Sgj2IIaiEi-PDSApj59Yz0QL5rOmTSg0Kw8s
275	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$tHxZdJDJhMa7-mYFtmyHYBiDNXrRIWTwL4RQG_gB7-c
276	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$WRJI8gqxz4M-J733Nwgt1hciaz1CtWqiKmttWU1rkwE
277	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$FVLHm8hEbAzmJl1bvBKkDdleTvem2a2ME99uZcjK-PA
278	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$7dkvwekZULq-OjQNvOi5LI67ypnz4CLMbKSttzeO-FI
279	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$QwAobZq6xey4D-6yOm_xg4h6rCKIRUpTqM4HBNroJwE
280	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$3xEI-iU3Teo4B51pXGBbjKxM_DDvYlASNK7W09pHncM
285	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_a:localhost	$sPO_9Od1FvK55Z9_vb0hx3ophiGuLyATo1RKYIEFxHc
286	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	$oXLyUPbqiXmRRNovjt9_FJFQLCzMQjPsaism-trtsDw
295	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$3A5iUMUsDMAckTZ_lQ9ZLyQdw7FKGrqWfMMxwAZJCwc
299	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$GcBRlllGdKFvT1pDzY7airMfjuYYNt06vxkQ0BnM6IM
281	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	$ETv-B1S-bU8wgS3S1fDdineVdS9YGNq1EMeUPHb6imQ
282	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	$GMh4hFLoeDc1Ssk9kdi7yAMIMSZA9zOJYJMC1AJEOKs
284	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_a:localhost	$5-KkKYPCr68IjD4sKk3rDF6kVYVkDMllW0BFUv7G4Do
287	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$7EOMmT1sBVcDB2udDBhhf11Mok_GC9CY-6bxtIKAYpc
297	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$zogqtnD68sbYTleQBUL-RkGDpkNmTHar6ilm_2oVnRs
300	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$JtjXz-jm6mi5wU33MudkV8ZsCM2V-zduDqeI1xIG254
283	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	$zMfjO64yH55JKcwd-hMCa1P1ARHyAuvBbnPeUiNnS48
288	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$-J2tr3j7vfmJ8ZSBAK5AyvQYmP2Byp-7dKfcBg5xHjU
289	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$o0wI9-m-SdyS4UK7_m9_MUd0luWmj6eoXfMg1ieT00g
292	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$LN4aYSSVw4GLaWf8g7uzrsw-fHTUyCBwq_-RRgS-MGE
302	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$0BYuX-7BWlMOYXwWp-y_txKwBBorVZzavW6fDuXxUrM
290	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$wEwGnOPXUgG2_4DpqsPrYbSlIM2TnPjdWNDyVbZNE2Y
298	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$OcjvTopfs1z8zuVgRxn4ynq9LH7z4eQhJnWG0PQ7150
291	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$oZEGsAxUrYn8R6NS359wZO9T54eXOD-N88ftDK7ZHGU
294	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$zhfRuogjo-Vq5GM4-f6hyuXBGHx99o9_Nef1KWi2-EM
293	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$sY34u-PbOKSI3_z8SIqGfn_2XnO9wqZ_eU1dvGDnRJY
296	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$aUCd2uzLS80uiu1DeYrTDp1wAWs7M1ba_4Srm8LLnmU
301	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$6cga7PdI_98v2MEH6Wosfik3Plxt3Ml7GwsUkSFFa00
303	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$1gF1Jebj6lrrJEF4bT7P_rKyKyoYZfX5iGaLkUtgtI8
304	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$sOnmqvo3Er9yCiTYF5ZDvIitPJyWvdZcXsXWtaYEqHU
305	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$rihsrTf6Re_Yo9d-_XE4uuxTnj3-iBKAcYVWAc5deWo
306	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$JE3Egim-VcVGfNztlGkye1CRFS-XRRa_sWKKBj00Y_o
307	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$QfJDTmbel89kwJs4Bzi0AaeJEYRVWy4W4WeFniRjMdE
308	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$uGMHHx8tymMYkm7WsnvCblTbmFRVSXcXHTZK7A3x3Q4
310	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$5-eIrEUrPzlsYUDryHI5hvc3-at4EZKaFfHXitx0xyM
309	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$EuP89-GoUrHN6kBivlFmc0P0DYcjV0A_X1LJU_CrqRc
311	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$70pfcMKsQWT6GCVB7BvHC-lJTT1lTBPazOa6eJgi0Yg
312	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$v0yqJdbwrH5opsbTcLmSL5zP9Hl_N2FQhWInLryRHMY
313	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$D9x8lj5eYxC7LlYm8ivzy92Md1bU1igU6EBjZbXkw0I
314	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$OQ5Loi04X9R35vC0eL9l3pISVh8ZDRXKuOG_GgFB4vA
315	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$i7uqjrfwoWPwHkG4a99WWSlIYRyyGyUbxqPADGgjXDY
317	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$RkpmpidNG88idz06umOciDHmNFjDhjCbMKOClnIYT7s
316	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$3tp9ppjIKSphzokgNChkUT__AKCklTPU9IGAbyH2fmA
318	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$jzU_GZjFiRoc7PPwidBWS8YOdRms-wzsrHJ0476wZz8
319	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$vCNa8VNQJJKME53A-IIbJ82J6-cPo7v4kRA5D1AbXlQ
320	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$7qXo9iYitv8MuYo7jtKfxEFpiB9GmddR0bdTqEA3mmc
321	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$OOCwtQCB-nmnnlgQ3ST3ItcIsITOLkC3b4a-WpaJjRg
322	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$p6hK4YyEwE7JmNsDZSVZo0_-mIxa8k_eaE508aUG21Y
323	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$tOnPdbn-zYbP5dGLmo-NIlzRcHaYQ93eHhzPARW9jAc
324	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$bGRKTABtbhLsFMEvxArMP9SzzVsakkr0CqFgYdZGg98
325	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$FBk4rWlItdcv2N45AZ_RJqOfg9On9XXqj-KU8GYEzkw
326	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$09Co1_Z3o9rjYOasMecXdIGFoJO_9jgdGOPGXyIqYuo
328	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$qQLOfz-msHlNErviqlt8LIb-21G9N6VolAhgk1tBZkk
327	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$-tPH3Usot-icaLc5iLxPet3nHoOxW4Z3DgGAxlWTwqo
329	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$lvii911Ihgz5Z5zG0r0Vvhthm1UhosO-8zvJyxK2EqU
330	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$O0VDOFsP-wkKpsdltvO9ILH7ok1k_JwIzL4fgTu_Swk
332	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$ej1WDcZ85moa4uG0j-uVqjAtm68srtfqNxoxt3jDYRg
331	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$_rJA5XjLKIlwZ6RmjX5Ur_MKKg1gu0BBspg23hZxTaA
333	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$SbRY_d-beIw-ZH77X2TVg3zISRm4CasttzVxtyV5uQ8
334	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$8olR95vxD2mybiNVjwiQHF7nG-Ck6GJRyFTLCsDxZng
336	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$3Wg3lWxS-P7ivcROdCHSR_9vsviy3nUeMlAjlv74GFA
335	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$Zomu-_L3OeoI84oQ88W4aMtTaA7K2gxDyH7KcK8PNSQ
337	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$_tMIamGUVvekAqkH0Yj7bCvPJQfzeM2JVBhZaBzcLro
338	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$vnP_M3_gxSMNh48KEkWl7QZM7NOQUYiHCtIHpZyO2uM
339	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$axz1R5RX7DoPd8ngU6knWd5hWuAHCHCFtBdp02_Yho4
340	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$vU6ucv5Cc4paH_7Z6uNkgMjocXGM58hIm-L5FtYUgoU
341	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$jUx2lj6j7lLXO3tsyCU4njgK55f706l5Y90kNKf30Es
342	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$k7fwKYLwTAsX2j9J-OZclMJ2qUxOytcdTd1WhDF4qHw
343	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$8RWzJ6rJMHz2mOkYiEQf6J5yI_xrXvk-RG8rFtGD6pc
344	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$uPX2zgMdaOIDe4u4Ra8dMgjXJk17uyjpWYxNqzdXteY
345	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$OeYHLvn0Av4DC4X0_4T5oc8B0o53LLb2XYabIsVjGcA
346	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$LazFMOeWkd_L7PnmjyL7zSOBxVRcMDY5H9guO35wewY
347	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$LlqVh6LdPfWX4yY3EyATYwx8V7k0JSJElh7j2Ep084k
348	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$NyzFkIoK_fNw6neifAzFAo6pOv35UmMNYVAfj3lJz7c
349	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$VEMFh0jUEl0n0S8o5C2fGCthEfaJQufcMQzIpF8n7qI
350	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$JF5zfIyeUqmUc-k7QRs0FcR1fC-5SSl4NlXtE5xahB4
351	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$I7IRSsaMYytyIiQX1Npzyk-SssTyMGOPAyv9QfvO5ZE
352	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$z_EJ6dWa5CjX2phtq3RYPBiXUrX6s1OIovGcTV9Uh2I
353	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$n950ZCLbokhsejgAPiWqIm-elUyFZw520IicwdbyutY
354	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$XLmFhG7KLxexQBNJ9YMfFvGqduyZbn1P-Vy7VwPPXeU
357	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$4maGzdDfkDGXzNh-qs0ycloo4wbJIuka8bFz4H6S8HU
373	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$sbDgkkxT05mw8xIVFWyOJtbW9nnehE06Wvxor1z8ms8
377	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$72MNMNMOJMJpfLbdNKdm6ZXGr14ukIKdq-fG2OvzOqg
386	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$fwk7G5oe7wJgKYMNL4T7DYLNKl3iNM8sMytekVrwaGk
391	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$dHmMlteyHAJ7M-fPLw4ASf2jTrlTIdvTVmaQ5Gag5bo
394	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$nALoHqM5KHY4yNdqe5M_FdIfnEBFbhKxcKJSw_SBKnY
395	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$9M9p7sRO17QwOjrnc8Jcx8Es9uZCLBHs-7sWHbmnKbA
355	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$RHUEtyOmmJEwQAVIOcr9x874COU36cTU68qaz-6X_Wk
358	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$DdokTNzv_hx62xZunQtaASj08oKz1Ra-QgNuyNS8Xxk
365	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	$XYKCYavbY8FMdUIlSSoqP0likUnTP6uJ0yHoGQCMnWQ
370	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$ShuNV5AOx3oTjKr3eYjFKvzCZ374R_0vxs2HC21ht-g
385	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$EuTTTqDUMl_auURt0x6EczjhMD0HBOTrdz7tI6_7-sg
389	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$Dr4XnDe61j-sW1MbQnDanz90rFAEbZr-iPiME1MS118
356	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$7Gg4gNMjR_8xoMiw7DstH8F9c31jtELv59YSrcoPRSM
376	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$2-SFwejONuAnI3cUJ4UN3FSzzJjeIWUURtWOJiO2sWo
378	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$LjACIs2QTEZTfukFRb30GQyevcb7EREdVFxoNEgvHSk
393	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$10jIYd3nOoWAzbBpDOg2uLibaMHSMjKGNaCcULPk8aA
397	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$ggjIFUeFBT-T7B98_lY4Wm-oBrkln2jwLwqn2oICopQ
398	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$ytm_7kYhKNYM3h7ChQh-miFByQ68gRVVrNubvh8NsGs
359	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$lV9ZLm_LY8McexZSBsuirusluj7Z9UPcalafQJyFOf0
374	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$aaPR9QI7az6NxeJ0hSrQxyKzzVyM-rBWODbN9y9rM9Q
379	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$XhzyXIYIbI0BfDV1QY4H3b4Wrpy5pJgJsGNZc8P8seg
360	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$bRp4mSu4gDOUl2yvIfF41ocDuhZTFVQ6SyAGYEQyCcs
361	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$0ruVoUZRE1Edh-f7Z0QopPRTCr7L2kEpX8unxgxmfSQ
363	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	$OJhJIVnJWjcgl3gc2AqLQK7sy1tKn075fy4E5qUK014
387	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$lDHVNNZ-lsX4vdZa8nj7leEaKNL779KLayi6mt_m7c0
396	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$3iiKKAnHKDnTkCK5nm2jQph5VGVJLhzMXrBaJE8csig
399	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$o7q1GvlLqE1MGsGDPtNZIePjHtWwS437ruaUPZRK2bk
362	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$hWVSd4FzjwQq7FYDdhFSCgpisb3gxDJ2OAjCjYS6rkg
368	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	$0EmcDbHM6t0AJ7YKAcphqL8othdZg4dIXSazEHvnCno
372	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$UTOQTSrmXya3IQYDcRPwNWN1bIv2zQ3YfbaVRy9NQuA
375	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$TbzKCcECXvJAKvBu5GZCTLIGi7Js0b1w9dE6KKZXaKo
402	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$TB59kUPeq9fMVMzC2h_3UnHw2NajiTJEsnRyv3PMK-A
364	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	$nsJ2oe7ZtdBtY0V-sJWzGBBDi7tcgH24zUaAdmLjXy4
382	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$jL60Q94H_SC7S4ZFOWkA4RilDwTMIUci2DyEXyQS_t0
384	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$sPW_-g3Oq09Bq8Rm-TKPTRO4HHOlMXEni0rE18Y01h4
390	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$gmdByk3yCSTLhbpo1UBgcqOQHTtUk_zBtpb99Fl8Nkg
392	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$sfCKuBp0xKHYt3c8Te0Hbae5DfQsahCC1DSQIc0lelY
366	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_a:localhost	$fc-Paa3ZBQU-GAAxH4QWDNrWblQvQ4ddYVzPTPiYV6U
367	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_a:localhost	$4KgY7ivi_pp1q2tjdk7IWENjs1kzgSRLB29nKbq-UXw
369	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$EklY0FV28pDgoXqwoQUjAB5wTv33O8RCHRE8k2k6o2c
380	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$EB67Xwo9B0__CxNTvptFIy4e4vG93cmEcHRWbiVSFJU
371	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$IfK4xyQ_h94nUHneDilGoM0TTwuWFeP5_u_nlRs571U
381	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$85g2ma_sFrYS8UbhpRwYEglJLj7xswd8VgNCg787_3E
383	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$WPbDUZRE7W6o_O4D0qf40PxoXNWcHrBwx3LxCA_ILaY
388	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$vQQEmbT6vHhsCEhRZ3VHEzdGvhz6HexKilq7e9p0asE
400	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$ecjMrUduqNL8Ll0DsYW4c0U_UDVderlYKVD5C6YnKm0
401	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$KH8mL_g0ImKfGBaUEImlRqBN2sYA5bpu4y7ibOVDWkc
404	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$HUbhrTw971dm3h2Jc2CM4CSvdWBF9oyG6lOc_nkEOMg
403	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$DRL_ruBcN_7GJsSKbTuYx5IVcUdfXvN5nfcXEiwUKHM
405	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$PzffL5ctPlnn41OzHT8XZKOqLnZQUlc70SyvYBhdbzA
406	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$JdAK_9HMkFckl7RubcWaHKzz9GaR46IiylfxJe6dB5M
407	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$wd7LGAaOF0CSOBfmfOvfDR0RnfNJr1XEO_KjhnwN35Y
408	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$0NuL6ahj3KLYzwtfZv0bjuTuQxl1SXfO2I3cQEGxT1M
409	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$W5ccBz_vmKl3L10y3N8FMg8Vu_vume03Xjg9VxwTwUc
410	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Eb_1RtIt-TDQ4g8c_FwiGR7-KLqYYlDtt6DK-TFhqdE
411	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$09CPa1ssrGMXBaq2jLothC_OBhTaz8KuyPAgaSq_Vfo
412	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$W_ZKfLo1LghRNjXqLQTZtcSnQc9F1B3uA9tT3wjSIKk
413	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$8BcqAEpaKHyD5tYjptW8zkdU9oZoiizn0FOo8R_X1uU
414	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$d3jBM4cZNF-fxyQSZHDiocRgdYJryQIBoLDvL1l2ReE
416	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$oK6yyZ3LDQBXojfR6858NGF3_EBUPeZ6s6bPFDko-rg
415	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$qcmfM6iZF_FivbmShQc7Be10wvs5yFKoCst_mT4h0ZQ
417	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$us7UJUfRSZa75Mk4RvjFqXW7ZSiVSgSVbHes0NJnsm8
418	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$L2CF2b_N1cdbODElwdbDKdJytXbnrAHud7LV3VfwYuY
419	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$CzCq6IOQZPom2jFaLARrGdPzD1b1fsfHACQxoXupg6c
420	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$x_qTungzcVo-XLbXK2XYh8vu_ETbIr4L0G0l7-e1_A8
421	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$d9QtJzWYbJwABqtyXUTMkdTU8f2KqZoesw5BKJJYNdg
422	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$dRFLKViRUwbAtE9azsvLTdKpA8vzlNl2nNFeJqDIALE
423	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$vRgQkKWTs6m5YEZhozlW0rO7bg73LHY99hA8mSK-uDM
424	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$SGd3agqt_4slNnQVH_j1vEIDvn0MhN0_py4wTsm1vWM
425	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$JH9SpWERJ8lWYD0r3HEZNrTwXJVX0ePWcqoe9E4E-o0
426	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$TZcR5wrmvVeJlMhmGbxIbT3LZWMZvL2NlOjHM1waUIY
427	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$S0mWidQfgfDr7V5rnTUgx-nTETonw1ZcuTJa_rCf-eQ
428	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$DTif-rsb3d__3bEYvui9CRTDJmjOLv_FVPQ_nZpy-90
429	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$SGg7s0Y8UmqzJ-01PY5BIOyGoG8kO95u5M79aZhEoyU
430	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$61HZ9wQtDblchyUfvO7GkLWZ6GFf54LXCRlXYSbVx8I
431	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$WA12r461P-fcjgPwgJEuWncCBDN5T8VPxXsGf8jyMck
432	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$NyHVtTb3hztQACpz9Mu_KhJoF_sbcYVcnjN8F93QB50
433	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$a2MOPpDlfH_FMlQzUUyAroPyqcnmYz21Kux51FRs7ig
434	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$Ssd-M-q4m9GIqXCJpEW-EvWyuTXN4XIwF2EfkWc9oXA
435	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$OOrnuO3vDVvaHrprXPFSQ0xTCDTZUB13mIODas8XFis
436	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$xT9Ixe2nFmDBeDwJ55xqZO913q6UfWT0RUkVRGJp72U
437	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$zuoJFxKkFL2e0H3uO9BuLOnP0_k_gwEjRFIIMDkTnwg
438	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$KDyJWEkBHEkPPTerz9twJWKT_9V-mC3A7R0PBAXa75U
439	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$fC1kaZtB2P7NsWjrbPepbh6YOIgVtKQe9vtRGGMtfCw
440	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$9HZaZSAdLNNBJ6dhsHoDOs67ocENoOuT9M31GNpRzx0
441	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$VrnWOG54hY63XUAF8DR2_LFZKsk67ByEZEuujmbVZCE
442	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$9VcIVZ_KlecrcPb6T9zwwD4d602v2JhWBF-8B1vIXuA
443	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$D0ZghNxCKHs1WeshpFAYFct436KSb45fbLG3iK_LsWk
444	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$rWkaayUh7dEGMWDtBkP55-D8nUWWkYx84jyXAfQ9rGY
445	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$2zdGcjhdpvWexvQBAXhtc2qCUxMbkWcAOSNwWx5q5-Y
446	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$QVZ8miaQNT17DFvuFo-5hwdVcvcBNTWFWYnS6YAwPQQ
447	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$tCDcEnIWBlHO2Bk3FcZu5LD4FbZHGdTT6bT64Jm4nxY
448	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$AWgeP69lNesoFPAXIiLB55_FF5g5oZ14-G21OM_7nCA
449	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$s-wR1xTx431_dFIuH09ToEemQR-3cRJ2A7iXdh_BZSM
450	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$XeO0jeC-JqH6IirxAA7GhRykff-nCQd9ZdPmw0rYqO0
451	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$tJfEgEcTpuLPRjALnAQ_7SDOnXaHW1Qo-jkydii_svU
452	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$9Y6ERhKcLWTziauuSjGcL2pZbsX-gvHH8b2FWKHNEpM
454	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$G8yO18PUxaUxRUVFt7Kf5W6rPNtinioGl08LgsOGnnk
457	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$nq2Ga1ROWQgNS_rTIBG3Uec83dfxLJ9wWmxVDO_gzoU
476	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$ZzypG4NqvNlt7yKSi1RFCFSBGsaKEkwX3hQL68sMBc4
479	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Vqg411aP1zv11R3fh1vwtXv53dXGERcHYEGGeNxEhDw
497	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$62l9uliphlswtBwFjIj5gHhhfUBVNseN6iXPO-snARg
505	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$ozNTg0BAgNk-GyVjMPWjzJmUre-TmGrCQZyUjLXrj08
507	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$aRKwkfOkiRwi9BePZkAZyiVBC9DdLIasMBhvTV-L2w4
453	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$prv8wRWboyKg5RimYh5r_KU1jxyz_5aIQ7eI3DXxFG4
461	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$MJyky96kmCEU8SCkFezNmzeJfochqsJK34BxMU6TniI
478	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$gDfjyO6nr_S_h5FC2UM-NHn4ypFpvSjNfjWdJ9QdBTA
481	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$RFJMql8obfWqlXMyTvfAVBcomE-a4HOQXLobJOFOb5E
482	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$BnB3gKRZaWDJEXVdAvF7-R5pYXhhcQLAapfU0YVSgbQ
499	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$2vpHnomRZoScF5x3jqFy3rBMpqOxOmRRI_x7uervmtM
501	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$mdoOoW7DzjYMWsAFGSAP5FTFaA8VOnucNvqH4XOwl9U
455	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$6qFli1GjCq4ySbEkosg6b8_DYLYYU6ejDC_GKxsyfCk
460	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$uBonPofxIODliJYWY8UJqh6nPKSInZdsP201RUI-KNQ
492	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$EHSmZq5rfXOGj9UinA--ZLHE3x7sLgpBD0dOdS4zcJ4
496	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$LJiv1uvKCdUrUDRy1pCHkSS9kLFSTSh6zv_uuWwW7FU
500	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$52zIBRKBNFz27FXuUOS3JvkSVWkE_UdZ3Bzh7CbDdV4
509	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$rvX3gusrqDnQXFdKLk99OwB-6ONPZZ4E_ccmjiMx95s
456	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$0Rbu4rYP6VrLeEIzHZt8cr2E_ba7QIIm9rtIF64IbG4
462	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$GblkUHRMFe7oYsXjLTI9yBDNmabbym_RN9GCSdsIoTQ
472	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$MBrLuCxLlOJVZn8_BDZg1ZQTx1kHYvhpbU4lIxYJrb0
484	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$U7uZK-uA7B4fZW-kMj_GMxqNyGl4qs4_5IzTKD7DOtI
487	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$ClXRZZJSaVHbkdE5uZ5oQ8vCHGAIUsp8wDLfbEOHnn4
510	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$JvdqK8VfvaBY1eQB8ZEIlEbbMfhmSwStPB2MlR1FbHs
458	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$IlGIbDmBApxvbudqjQDjacxH1HJ_nANWpCR_jGMnaX8
494	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$BFG066DaOscAxNTNKtTAjWIMqsj9y-BO3kpSOh_nllA
502	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$cmpNWgb1YoE_kPOBNRGJOwXucztLwH0-LigpF5B5Cw0
506	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$YN9SLoJL97SWXJLt8ahCEKIViygmiF5sifNLasdkE9U
459	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$wcHCvTlfoNnT0kXHhKawclQkP26yEKrtmdpCB_BXZfw
464	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$Oqud96ogIYnUb9KAzeYU3iBdb7IhGh1bo9RbUHp0IwM
469	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$0MB5wm2nphx2aBdrmRGG8spNBcGv6gqoFyOsz4iJHXY
483	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$OWvaccBnDZb5TahnEJQ0kVaKwlrQfjAV_h5RLC9xNzo
491	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$a7f6ue-IQWTlSmIt8hi2TLEgauUbPCtd9P72c7Uy6fw
495	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$bdy9bUgqbt-lsY2GPZJQgurUsX7QbyVlDyUAyiVX1xU
463	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$SaXJCnbF-Ds9_RHxRzckFPJJnNLOvTdE4dcDxLq5dU4
471	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$p9zGSGKifE8WvFDCL0xvtyfSKCaeAwyaODxB3DACd-M
480	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$eGFd-BWvdiDzygSwJeSmBQg4se0Cu_yRXbnMhePmJhU
486	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$u0KqDu7x3Jzq4x-a44wRP02_zIIpUyl_snxSKZlD1Ic
504	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$cnYmAn0a7fuY0jmLK98n7aMM0oYQFJme42KEIhHQ3oA
508	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$TX59oLP4qE79DxjV4lGKyBYUiNh8FX_bBZlKMJYhwMM
465	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$-MQM4yGJFL2Ko8_qVFBNvkTUhJ6kBmAjV--HFXu-_jI
473	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$I9SdOHxtOnKn8jlQA-ZjcH78oyxvvbtTP7TNOeZnrTY
474	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$VswkgkFlrClg-nxeZ_HKhNDqOfq4EgUhrmdgjnliB2U
475	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$-5rKfd1WFww2s18N8R4HeN46aDuGoRN7m5xyoAfT4eg
489	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$aFn-r0lCD82RXxVu7G2_BAZHR2YruiexBYN1T5JnVuw
466	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$DKx-REzWoWm8KLVrhlQXKakLuysOzmBtT_pyw9gnyd8
467	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$QZ7kkmlx7bpP4XazSlFLqPC2zaffnw8rHHmgyY6hPbg
488	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$JJ-uvHjgXrjtkBZlICoac-RLB2UhyWLuINjtQepV8Ys
490	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$QeLHDsaKpuVVOa1isgQpT-21R4GWBJF6fd2IDfQJi3U
493	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$KCzw0ZYpjmxSYpBg-VWijOLJoDaO3ORJGcygSJgDKU4
468	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$lRAE2QoZQPvRdkxhAjhhKTo18yoKuJAdX4qqWKz_Qhc
470	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$lNUJ-zWb94UwFGvQjOdf_jJVTcqfnJGz7ZWkj-xf-H0
477	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$f2qNeq8kJS-6DLl26udXJ_sn5M-HZvx11scn96_z5Yk
485	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$dQWmE-jkGYbvp0jt2GTSchkQCkSSsbswKEF4LBKqyOI
498	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$ghQbZw0R73ClJHhLJQ2zXreV1fswMzWZ6TaGdVG1Aqs
503	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$enj8rtyWWFRv61yE6d6u4slKuz_GO3WvmICufaAwfd4
511	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$2euvkqBoo-5Se-C3uCUz1J3OyjFQZWT1Koc4f8cNMIs
512	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$8kwA3m4GxTPFmmz3pyc4YhMGi7mHW1Sr_CDY0tWUHvE
513	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$-Lz8wuqRJCdSnH1sYYHg_FThOxKhm1ZBz1p09Vl3R6s
514	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$zlQGIgQpBJYxe4nMh9GU7u1XS2J1F-yvmVGkCPfVVJ0
515	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$MHC_bSsV1nkcbVymfrMbdD9lgLcEhSetUO89LQUWLE0
516	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$IGpAkCtT6EbruRQaXyXZGdNVxYZoFB-4FECiYEFDcQA
517	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$h3U4sZG2Tz2kLNL06VfiingI2IHffskMfI2nVYq5sls
518	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$_cnOvxhROPVlPyNwBk_DDBKKMmhLgPZh1tKZfmYE57s
519	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$JyUNIV-7E-90HsZWK_Szi0jZh877QsFxQx5eEJGUAE4
520	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$IogelUAIfoT5Uj8qJoZyjAk-T8AFDm4otPGjVQHTTl0
521	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$iZjPPnxWfT1tbN6uQf7-Ws6PyF_CNvE6aqiekjkmBZQ
522	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$AlvunJEAuOs0u3PW8U0UhbaWs5PtbsFMH-JZg06ue1I
524	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$kHMKyilo507mTTpEyCsYwdC5oz2F3gauHSjD9rjLizI
523	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$mnzmZb-5pMKIBehkoM4Up5s6CAaUPAgwbAioGAaeYFk
525	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$y_oAfIf4VVmmJBsVBWkaHzmaKd31UzdCNg_QSdAoqKk
526	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$N-L5BbodB5yNVZ_5M4CMFQ8mYX8-DxCbzgqZjFPHwBU
527	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$U1pPxZshFnhejiWqv0te9NmAXH_Wj7x4SZSpcIauJdo
528	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$-i9tF16cca5QefwQT9ENErpZLdPQyz2FGCyQ6xiSFvQ
529	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$Rzgc0MTRG4UvzvggNFKyHS0ttYkAxUnPOXp0IOEWzaE
530	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$15LQu--UlzP7slpkxTjFebd3TyX_NNuRrFnz2MyGDSY
531	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$un98C3VuIkdOqy-ZpPAU6ESf5Hu6h9lyqwJLKLRfYxE
532	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$NA5jh2sxaEK6AI9VCvigrp4rXMsUGKxVYTmKzQ_EmZE
533	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$ySG0pne3vb0dSrjfqVp7lMC9nNmUIg1j8T_EHsC_occ
534	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$f3mP5rbfx77GEZ1ex_9z-Q5RkbQWLKkKrzRGEW33_5I
535	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$rwLyRy-Ep7NjiRW5yMKmLJaYo5G5-Wx6fjlIOjws0o0
536	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$-z22_1xeqTtF-NfNRJZiTt3UNsrRIRCOnOcb9zTLyi8
538	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$w7-WZhppk1n53KlG2SBxC9oQM1zIAkBJpwbTJgCI3yE
537	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$qH58hytg0VY3tyB88lyc4f5dEjRDyzrcuJ_OBDt4zCQ
539	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$I1OlU4-Jd9iheZktatb8ncX7UIehBPRQuLVEkQLq6eQ
540	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$I0SzUqlGHolINXZh1_OsQRrw8fm9UpXHpjp6Fbfv6lg
541	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$nqmaMbEnfjWVtSbvlKW4o7eZnWxOTdattqflmI2Dz4E
542	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$xKDLXulWL6oH4yQNT7BRcSufORWKmtPNKxe_KTDfhNE
543	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$nf2tBPUZEy-tdpLfZk0l8y95_PkCtd_Xn1O8JvWlMiQ
544	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$wpJVJPW3YAQFskoIOf9FDnUHZkw0GB0gpHlZ8VKnjRo
545	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$NyNSSjPuFAc8Wva-4-jFz_gs3wZyVwmgs4kLLY7Q08A
546	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$bGBza7hC6tPQtLzY9coBj0Ba7r0GYrTVrKzPIevSm4Q
548	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$XTivchOOE5kcp_aBg3s1BZpfgzhyUwNOxLGwesl9Ty8
547	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$AEL5KHgC4K46g44AdP-MpoE0tKm80Op1sOYoa2q0--E
549	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$qLj34jfenRtAfS39lAC8U4xuV1-sDS5GfL1TsZ1eBCE
550	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$m2B29qfe8-9HIcYydkugLkN_jyjWIol0wRAmY1umdec
551	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$ySRpVvBzAq-6qpIb-vrt64FJ6tylzAmtweTbdVvornM
552	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$8cbJPQts7_sZrpogcM_6HMDpcd2T1hftkvqzYpmcyK4
553	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$5t3TZM4PRMSlVNtVfL2yw0FxlBFyuJAKNgyYiezevS8
554	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$LjBXXM8TvGp-81bJZOLGG1QfRpXTpoopDbkeo9t5JHE
555	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$XjFmayQxxagMkdrVYXnk-IOUM_o647ezTHfMR83l_l8
556	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$GOzmpW_FtFYxLRMiDR4ZcyGGnoib8nMAm_WThLHUu0M
557	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$-SJLQQer6Yp4ND2ivOIUhLg9ANNd2e64s5_vg59I1P0
566	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$ENiOGIetrXiD9dNYRr37p7CHxry_RybUV9xS7-r4jNo
581	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$JMD2hW0GmqizTDu6OSGq0NRVfGXJ8kC3B7MfTzNY3bw
585	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$NcAOsbTmBKlooLu53iabLHTfcwifGnS1iCQQ5nci7VI
588	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$zwZnmNpx_8m1rcP1ZIfiTX-Pkg8t_3jglCmO_hv7sZg
599	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$9ph2mJGJmaRE1tuAAvzpHdAK9Jv5oc9Qdv2sisnHgZo
601	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$kty88hNLAm-8zGwD61qKomt26JLkX0EUnxjZzFA7Xl8
608	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$RoFjDEA4aEGEUNiThEe25rytmMeJaqM9Po9ROTcc148
610	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$cZ7UK1RI9NmK4Kx6wwDSpN-aIuQnaVkkrJgV011A-8Y
618	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$DbxXGBcEN1Z90Alfx1MbJRXUD43jlhLyiIyjnICfpkA
558	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$qey2Z6FhJfa0XblMvawZ6JzKmPfVKNjxrI_oBx__AQI
560	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$qfZ0R-D0FDX18kcRs_QXfmnUx3Eia_FNg4yCX1mLfUE
571	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$FdXdayj7PXCKIxAhmxPcyyzDShahbDfQvNFDVf9Dy9s
578	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$w4DtFAcI9KL6d1Dn086_AlWa68a5kp_R8esFkDqn_uY
582	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$Q4IpS6AgYYBl49yKAzoZONVBc4AePJH28XZIDvwemW4
586	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$JKL35Ziedumo9YkS5xQLCrXMhb1otb3ah_SrcYK83T0
602	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$Msi7QI0P9bOYl-mueqETBjTaDzxhpTDBuS9Q51p3xxk
559	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$E40vibb53bhbZsaYld4CEPJuNqA9rl-I-Ct7pY6GsJQ
572	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$GVBEyaMnb9ufXlkz9mrJ8GaAFNt3eQH2r8nsyM-2E0g
579	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$tFcocm2695F9c4ggKiFGJlKGSjnTHZ1C00GW7evyPyM
595	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$LVDg_BEZV5UjiYDpF0nA_45ovAApomSL3Vcwo75CnrI
600	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$e1vZycRzMYXgVF9HnnladMauaR2ZxVITcoKX_s4r5R8
561	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$VZjcWglE8Uq2ppUM4Nooj3Uy2z35rJQoEi-mN5-kXD8
564	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$-Zgjet3Ry8bCf5xcR0_rQpYHrfrQ-r79fBEB3Ci6cW8
574	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$oIkCp2HvySKXBd4ncBsNUVh9xNwZfmfJbi9vvGzOGCs
604	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$W9Sz9QWe7L0y7MlR2Az5bNpk5llGHj9o9o9ZqutFBBY
562	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$v4t0ITuTVaBXUal1SIkCMfnlciT0LD0yKjPiAUikLfg
567	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$i1N_vrkfViG9CpIwLEZuAkQ0YhvlZH5FUGnGMkCFnws
573	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$ApJGq9HwQEvCzlj2czu-3wQsjE26U2o0JgAOFBkGWWQ
575	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$YxaiVYBwPweg-q1aScBHb3CoJ5uBKn9eEjhA8b8evIo
611	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$iD7NYRKK1pbdxxz4UqGjEPD1ES466eCmqAtLmXLzDNo
563	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$OXA-i5O4kK6mFbSehE34ELwd4F6TvBIbudZk39gjuVM
568	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$cwA2NlggcJqc6qbAZ1hfLB9vcOzJJZYe0PqnxVYTsiE
576	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$54GMUmgObr7bD-r2TpujmAWNmZ3939AEiBpC49Azcx0
583	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$rS6uG4cUMYWOg-9IaPPF3t8syXWs0rhp3VNCM7W0BVQ
589	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$CRNgIVz2veDUIh5gSOe2-OD7WUBJMOqMNAb71DhjYog
592	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Rz1ZYTvHOHrMy0YSxy0FBcU4D1cuSlmH88IqPZeUKFo
596	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$zHjYI34TZQyibyBPDDY9Mv9n6Fsa5NjmoRkyUFrQ2FI
605	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$6nFmpd3GRMLlwYD2Cd4zmXryvoiQkCOE7xzwuSmpRfg
606	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$BQy0h1wP4N2NoJo7HNFLbfFplA-rtt-60AebMMpLtVo
612	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$Cvz4iCL9o5DjT60ms1Plfnc4RHgvVxTvcLMuxKM9Bbo
614	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$B0w5MzdFfo8BqklgpvftRkjRWY9ezuIRKeDbJkjE6hk
565	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$DG7otHaC6Q0yXMuof02fylRDdBrW94MSdFGX3d_RSVk
580	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$lFi7p-KDrRWUZOY7Wa7dNPlFJ9te5UB6pVudiJVT2Xs
598	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$m9OqM5FueA6VVXTwyBzpPbtVxcerNbo1y17hTiCbCkM
607	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$5jLnuqj1_MkORFXdLdGwHs_kpEGnPfxTVduvX43AYMM
613	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$v1q1pLUpcF9FtODtIhrqmaMmkQJe-psTNuyZY729EsU
617	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$nT58-ZovJGWWWIbxLj2PVipgWNpyo_WVq_brhpXgPcI
569	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$XsHcL0PpeW4eMnD_IXp8EUx4bmwTECx_HRQaOlw9loY
584	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$Yf7uCfrVtbbut1hqURI2hWHV9SSNPwb1X-UU7ctqjRw
590	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$A6TExYel0mXgPEmcyWTrKx9E2hg4mzb9Ea7Fxc_Mmek
603	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$PemXval2WB_UcOzSkvRa8XBxQhziB0T-5OU6hhyy9n4
570	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$lDAKu7bbYALsXyPjCkjIgDf6rLmFnL852FCpsq08d6s
577	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$YV3VDHUq9_uS4qKdz4DFH_mxMsioA0jwNUaWpqyyqmc
593	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$a2EKZ1cUTbm23hsjfsT5H64tnUBN87TGW72kJVfqXzg
615	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$XyhWiMEqqEd7rFkH3igAWls82YtbN_1KCcEN7ow8uqw
587	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$vUjH7nYVmvP1N8143hN9tF3wRQM4vGvtzVSZLcxs4Wg
591	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$9yTbHjjGO9dCCvOY65cKS72QeeapJN8lrb66e3oDcrI
594	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$HrBuMWW-0L1kbXPhjJaJY6R2mxhbQ9-8k6nDIDEJZFc
597	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$FIk1P5eHNDJI1-dgl69HghS87I1TEPPXXIYyVXapDw4
609	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$txmKSuer004FEeE2Js2o1-RO99aP4d0O-5OIdYVRzx0
616	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$iIMbKgKocIHCdd3LwQK-YCgWeadL0zTgotmz_zKf_UI
620	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$kwnB4q_YqjfJ_AGkjfTK-jZ111jTT-U4010xX-T4LuE
619	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$OpdCgf8grfcfhpiLFYZWJ7XrYNXOYENOe7sSHNgpRpU
621	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$Q6xUKfK76DxzNPj-kEJMqQrAHOFFkNCZwRKWTDEbYJk
622	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$3_ErZSbMyFbau0rYcASpZEgrWCzcm0AlUvj52ogJAMo
623	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$JAJMX8qEZXHr6cK6O01785Y7x_T63YGyGUgQ0IzaEbc
624	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$LrWLWL8ROdFElsmPh8RfvVRetphZG1m-d1-JjlIQQY4
625	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$W-AJ49bmoFkkeZ5q4I5P4ZaEQPYnX5cXpo5GyhTKIE4
626	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$ZWUphuWh1NE42PK8ClAxJhx6H8ntAgxHBPn3FJbR5Ds
627	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$PVJY1qHoALdAw65r94JJarnMwop1rYs0wqY3zgL-b1Q
628	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$7DQxP7a4F3PluqTuMIKQXy2MnH5gCYWTOyTXgYk_Wsc
629	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$ZTbPHEs7ZfetTVYCG-wCmHAIPQyD3-iMfN6jKtq-7i4
630	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$MV8iXvchdNqWWza-1uxlHrVa5k07hiZ7m-Mlcri2d94
631	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$BtSfAWbSLMo7v6jKfYiIat79nOP1WpX4xFPjItBIaUE
632	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$7KbWgeEDD-0zEKZ0MtaG41q0Fbz7pX3p4Kd-ZBmndbo
633	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$ESv9JJiu5T6BsIDCWh3Z9eRycuIml_UXhToLULG2J9U
634	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$9rdis2Y7KjE846mPY_tBmZkImy_JC5EGN7M4XFUJEno
635	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$5lbMIP5vv_w4_8kTltA6OOE-CqdLX4h5cd03UzsyTN8
636	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$aTB906NQgUXcF5sqW8m-g4r8uALWE299zBNBIfdl4iw
637	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$-8A-GN-R7ZlEwytAhAs5-RaJ78b-fP2sE4mriguJQnU
638	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$FsjGyZtQKvbdwxYF5oJef_nWG1neetGlNr1o6imxaKw
639	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$lI_bZhekPdNId4ZUNpyYiay6L9YBWY6RmMK5WQAu9Fs
640	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$kdr2VeT0AowrLRd4HXI6EEAZw8oPl3deZdPbxUAFGcA
641	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$Wg59bxdg7VQVLQGO3euA8MBjqIP4UQiIbb4tsCMOlVk
642	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$pkLLj8upnCIXz5ta1-JHxFAbWngqCaJGOdjBF58S-Sg
643	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$3hVt24aD0PRuljnOfkHJMeonmkJvkEBw28048m9e71c
644	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$ubg4OjsArGbwxbtotPNooD4lnjwLwVel56lHtwIcAK4
645	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$pUIqtxiHfdv8hNjzKzFZ0WSWqlI7asKxuTb9yZTlhRs
646	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$ilJQmCj0mSuegZ-gsRW3ek6hUksMupS1OB3W1F-7PKU
647	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$jZILA9yvkk7LX7zRmtb117ydII9ok6FTSA0nxFAgJhM
648	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$b7fZJx2RWEsQJ4CfPGyYq3OwyLKZ0M485ebOegb3Ag8
649	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$inAkMf2O8U3UJDGO19UXVKdVbbi7BInrabn_EiQn8xY
650	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$2GgrW1vYQqY7rWlGxP4Kz1R6x469-P-h476YshS8aZ4
651	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$Ffyd2XgMPkKpnzHyJsa2PqJWP1JxB1SDROLQ2iCIER8
652	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$lSYAOA8XFH74Igp8GaBBM5aIrgcONmHb0ItmA-1IXII
653	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$hXewMMBfUuzRoMLQxe0oLxF3Mfs5Z_9JnmyS7ie0-EI
654	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$5BWzcOEPDLsEh4ALrBjci0rD3CV1FH0b6lmuF10auJE
655	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$ujYNsKLscCPhIaH3O-6CGIEHwAeXoXoUcFPYdx09gRY
656	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$iZMZ4earoVGvR5ZLJoUdzwEQYk6y0Vl14RW5XohiNVU
657	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$UwstWDXFCzBSDpC9jQEQ65-54UPjCGh75p6Q-tjg6Sc
658	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$tP1AH5c9Y2cPXAw5Hwh1OaDb5suTBCnCkLk7_SCo5rI
659	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$MbuWe0ruDRx5fbkVvtcn5UjTBkv4Yv5TS1q-rLP1XH0
660	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$GFijw4NpMTA0SmjMYsUuD5czdsfcB2wyMsr-mkSfD7c
661	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$E7yT7WSZml-zdf1DcWToZmOoCirZNUhclLvxN6yk6RA
662	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$OzU6yNQOWiSvmZErgxBULJSf2gsapQISEhD67pANnwg
663	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$WkvVbzGBpB2t_YatpDAHzE-s0YISTNGIewJ39D0G-OQ
664	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$BTWAxCL1Q-kc8J7k08Wg_u37f-A3tuX2sCVAwuic0Z0
665	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$lWFhSdVYsgrmF-rTV3G6VcnXt07wiTYHxfu2ArvhEBo
668	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$JVuQlJWDWn8vYlX21BZrqL1jluSQk-XHuM_TPYA6Oxs
675	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$VyiBuYIbFiTHkw0NhcQLHV8b6rO60ckz0XPGY3ShB0I
689	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$OXWFNg3THQXQHzKFdXBoK-_Spi5b2Uc8lQmp-gDhXrc
695	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Fr4uRc5Po-KFE4Iz7S8RZAtrraup3RaEYMPhw828aoM
701	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$cpPbNaIS345RGtJVXsehwvifpuJWhFplv8AEZ0ZTLgw
702	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$oCjQcj9YsKmHLXjjOUrAF_FxrAnxQiPsGw0t1VZynKQ
714	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$y5svLRTO7_zaxPlBOzyg0bGgTJ4MsLipiQdqi-83VO4
729	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$Pt1sk6TY-vkeLYoxpqBybdBN9E2edQP-XySILK5IIh8
735	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$kD-FK3SdW3a0acQil3u5OZYAu-8KIz7h0FA7B0he1Xg
738	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$3F6GcK-o8p1uRzP-TYVegplnm-0i6ON380nWVutwsz0
739	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$iHhh4tCzopwi7N0GMAkpJOii0dVLgysVnnf1Ee3YK0Y
666	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$0QNG_l0Wmd4_YtwXDHIS9Wr_di_pB4Q8qIxNv4LwD9Q
669	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$Q2t3fUCbcpFnAa5r3QjHhq912uj_sL-cfxOUP3_hYYw
674	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$2o_hECzW3pEhaBNCxUbMxN20UPfHHQPw_j8fK4ZR2Os
718	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$4Mk2JpeIwhsmKqi0d9bSKFmDDsLQRI5DTzujkZ056-s
723	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$ZmMG1BvGXSJN3N2K-ivnBqJ3ofUguCpxQsXTzVsTG7w
667	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$AnkpTiuy9AKjxcv15awPzAskfP8BjWH99wlkALBGVYw
681	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$93GE3yLpWe8ilGy7uZOVNETs026vhGjuF7yNV368ioY
688	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$NRpRjp14rxKUijyFsx9WsT4hg5bHtpiUY9utHOh2yvc
705	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$UpCSWtYZcloTB3Bkuf2y26rGJHq4f_RW7F6WxNz232o
709	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$WnNMK8UD3oW7-FG5xmI6a9zDJgqiA7k3e1BmpRhOr9M
715	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$DORn2H1jtyC6gpFLPFmd2rn3SkJwh-MEKOkBAa5_i-Y
732	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$mlcjVgSw5MQbNGSCXkjUyV71B6LExR6X_w-Z2_fESQ0
741	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$97JLfcL_MVoXjFiElky5S5ayqm3cUKWcP65ZQnzfUa0
742	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$_ukO8pr11vCPwRJKJrVdyGri3u4wuXKBtQ_lJZ66rko
670	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$9_FtEw7X9Du5GWXI_LQHnp4ESJVtXr3XXx88qN53uHc
679	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$ghrv60PB4SXj-3D_GF65UEkFYidgsuBdAKhMIHABG7k
686	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$XNyu6B9IwTazqbo4Ru-DOI2uYa3SMJtz8ms7M2LK-fY
713	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$lRIgA9IItq3ic96r0ZzcJvudWIWsV9Eu-eSmSFPF8bM
727	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$X2dDqylt0SVjcvkbUtt0lidrSPRqqlkZtvjLxmj50Vc
671	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$4_gC4X4BTT7jwfdmTIPxsw5gXL9NTQ6gh20zzmzEiZI
680	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$21uxUnmUW1HO-Gle48qPToUn6JhoqXXIA1IAAfLb3Zw
685	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$3-gXPCcG5YP9ej7ijF1miVAnQ9vabV6d8WvAxIZ2LYI
691	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$2Xt7gT6gKAO6yCjELaOppr8qaE1vsFMKy10scInkICI
698	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$A1Xh_H2DE4kiWONSGi-oId0tLtIMXcznqhjtWVrEwdA
719	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$xeR3suiER6H_Ihkc2Qh9fitNeg8MspnonA6tvExM3lM
740	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$BNQ7KqqijBvIgMvR7PpeXMx_ZBUQ9xgTuIvZR4h3GlU
672	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$mEio6O9xG9bb7k3kRpq2jjkjTjoNB6mlIM5UHZuk9cs
676	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Xe8Mo5aJtIqb7CV_tT1ogA6boPZKeGpwId6HLhjx_tA
677	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$iWQEkTD1m9isdCdAvQDnUbl_9DXr_88p7e4v7Ce-DvE
696	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$Pwnj8HtDKyiEpzNqgPdBXcmbGZK3IUnwG1u9W0OBPpE
699	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$gdGMYFIy3DYVHc9Juw-uWhoMUXDNiSabVm2qSqs8eNI
720	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$yvfH5tYTTrrIpYwiYXOMPCsIAdiJVZrdwjW3Sd40sw8
724	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$UQkJdiA8utbU5gKCP8L98Wp6XPeq4NqEixPXO2-YFqY
673	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$xvhDZnbXWIsjpS9jA0aYPiJi8NY9RXptCrwt9HGoZ6k
683	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$2QiP_dEXwxSd3h1hu87ploDjbuMQy0AWJ_lW2yejuh8
708	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$2exc46eo9dEf1pnAhiGR6fH_QICi5smss-3OE73LYIk
717	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$omNOk7KaX16A4sV0vZcjVj9ey0CoIyhTDnUhxHR8ccQ
678	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$P-1M4RkPsWa70Cu7U5f9YwtBoIhwF7osExs7gP0A6Os
690	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$VUhvzyW5-TUIzhuaI63i-q4PbNbBUvSRrtigzKHRdgI
693	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$leoxrLZqQ5yphCXUHtVyJouUqznByba2WSVoixQySgA
706	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$hSdYibp4nugz0bTb8BOQdlnTZNVJMxc0uVcUfabZZAY
711	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$mASeUWnn5lmXHrab5t-u35hv6lHvYDxaDSsYqG_2sWA
712	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$a4lJewuAh0PX5xgnjlFyUtay8JEosTLkWPfDDsX3Psw
716	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$4EkQCbF-8UiwcL3Y6qM1U7FeI2twmLkEDQnID-pA10Q
721	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$36RYSF232RfQNHdWYQMmJ6TF7iqZ9gN3LZjU1mn14Gk
725	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$4z0r9ExwCvGW45uPLtN4UGkSUWnR1iCWXbGL3eFRf80
733	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$jWOKRJT0JXWifj1usBkR2r_ZWBf8QZ0ARiam835XRF4
734	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$s45nrx25owBPoNesAaJ3cFSh004zh5y7xnQBF87XYno
736	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$QFh5efWclywreXsTZQS0iizSr1qnQOjaWgguK-1Qiew
682	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$fu3xtF29R2ipWx_9YfE7L-dISXtzIIx68LJ5EFPMJZA
694	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$WzK2e9hi70VK1Ex9n3prvEkJXLhF_oM_4qxTEhyKFBI
707	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$NXsNThjd36ZSNMiw8pFMUXHYrFjaqxu_dCKIU_KSuko
722	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$aj6Km1527wlg-T8hOO294PCTfkPVF0Y1bJM24ZNa0Qc
726	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$IJA87eZxEEZhiPq1EtkFQR9tzXABECK3XVhC1EAOaGw
730	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$t5noefWL-SG6kxztIf4LOl5h-PKd6jBFMOrMQjc1axk
743	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$i3kAHwvAu9wFNErdFjNUf9F3Vn_q3td-QVD8XwroAnA
744	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$MIaGvfVQfK4XuMh2A-UflPirD_En8coO1-r_MNeWpNM
684	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$MSSFq1_XkzPzV_xq3-Qv39xhz8ICui5HYnIsWf8QaLY
687	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$h8hbKC9OnNmOVyT_DC-O4CidukuCdPsU71KFjo6WbxE
692	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$Y-xchU8-VyCn1DhcKZyKC6T0zmxsZKHAYwM6r4PVg4I
697	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Y6idHmYHfAyUhiFBP5r-6fq2hvlfKkDOEG2wCu-pLa8
700	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Fl1L_fKoWpdilKxS0DecRLpvXlghCyriorNSxOIjIhg
703	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$QKoeT5XV4xwl0N0UQFLAO6TSWkp2MDanFk85XEpJ_jg
704	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$RU2T-B3RYx9hf0UlWYvNelqULIZiwWSHEMmn4AHlUpE
710	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$4S0FhGCfClV4YJp9wzJNOzbxJnV3qfcmS7dNpBAI26g
728	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$inD5d7kRpfBp516Cs2z0sXk6mFeS7X0n_Y2fPIRJvQo
731	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$JTQDl9XHXsvPA5zJ5I5EABbCS_qEA5ToNjwhwEK83Tk
737	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$NvVkabz1KcwMkrpCf-B9fCNqo-GG_aiNr5mKQfnHgNQ
745	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$aYTHjmp8iDkb6p2mVOloeWvdP1ft3y_rKHX_micNDSE
746	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$o9kcSZjecstIMXBMVRH-oIcw5Vx27S18IabESSItK-A
747	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$k9G1zIQqA4vovjf9GX0TlMJ0GrbbvCI4dzgrKYH9Q5U
748	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$SYyEnJYU1WJGpBmiVR5Csq0CUrwui-hW24rr6At5zwE
749	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$W-aQsju20zVpGWe-dsdKKUFap5ErvdtEJqheWQQo3no
750	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$z_4BCOrBims4sVRvW8WsXwhfP9Y80zKVQn3GZtdcYtY
751	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$1PwHjL21t8ZKeiwJ3nToCNM56onZch97JuMVf5kBs0A
752	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$Mc0QM0-M4yJSTnq2qAbsxgk_IZ3z0wQUQLZ7kkJCgrI
753	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$RSHYaOXucaV1w3ek2DcCffcZrvIL7VD5xbJc7T8ychc
754	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$nS0FO3BaaXEG7Hch4PPFBWk3y9nsT16ufNjNsE9mhXQ
755	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$KL8gNaGPFyrGt8AOusuwIknPZi9F814khGrp-RNEN7A
756	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$PJZj6JFbqNHoFpxpyNmXH4S6nsILjrt0zVVEdzCdtZo
757	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$MaATo1ETeRSyg2QSWs09jzF6D5E77HNDbRdF0wfzjGA
758	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$xhgrll_YejWNlVK-yltIdE31CiZsHCgTOxl-P85eGOQ
759	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$JbqmHsg_NrRNfgKp8vqriw2r26qwutCfB6iulRErysY
760	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$mWJoPtaH-AQM2dOoxErHlLdEbnIjOCpDDXFdH5S8IJY
761	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$DbxeKNS7UQvIcrmdg3aEJG27F4UjKiHYik-2KLo8Ho0
762	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$ZubZFT3t8FWXh2TQMRLrSO4z58DdCUjeqAtlwYQOyhA
763	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$wTAaHsIcAwSuzSA7H-VHJ6OXl42-SP9P5BrF9tG-Drw
764	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$ilsoFYG97CK7uL8PB0L479J2-OHnBGTUudyIJRVfNV0
765	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$XQ1jFv42iko4nJCLIdfpOn1d2M6_QPKXZoIII4rlu6E
766	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$e-LOqEUXSEfmQn4OUgNDAHsb5AzpNsDo-mjp0m2vFQA
767	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$se-hxsgWXjDaZa7YzaTOSUMDuUxq9PwF9mjbrV3wDGY
768	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$Hr6BwLJAYo3C1XXG_ALOQ6XnEfYUVkpAHTAyMV6sRws
769	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$iHcvngt5K7BO_ryjzeAfNe6IzsHVyjhlTWKZiULiu2c
770	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$_dSWYptFmigdmoPwl4pPgkQsXzf93z3ymnhqLiZYZQ0
771	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$mIzc6ywORMA4PimH1v-tONsYp9OAtOd_N8QayOJRChk
772	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$vxw7cwkwLq32OUI5XmEye0SoHADbZvD7KRIKJjv-d_w
773	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$OIyI_RMLRG3WqF78rUutbBuZrXoVOTbjTebt_ptNKD8
774	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$6Ck35VhoI3WNs6LLHosS814RtZrY2REFf-6tgXVzA3E
775	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$B-WvvdnzWeJvVAqKokLJeGygybnl-gRLFdJrvfM0ryE
776	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$cdxgSQ7KdCWWlrJrFvTZePP-f5nmlzXmlaQvmvZdDw4
777	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$2Ssf7gkS2NkVT6vtdKc6Pyyb9zsIjwWnDWVRVMpWBxc
778	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$geOU56teKdqcKV7kG7s23qj_HQbPQJMTLO0UmB5yANg
779	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$kjbYSfaGFjSymA5ueut8EloSHx_DpZaBG_RT5D6TemY
780	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$86Pf6vb7BHzOZsjy0ObG0cYuSD0HDSs1wYqB1k7JDgg
781	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$BtKmdXlHyT65KPvPIiDSk38oldbOKOUbuv7J13Up4wE
782	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$HVWinlm6AKNeOld7iV_yqdfmpznmG5wAyWK5k3xjM7Y
783	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$FNOekiMLFE4AEgQ1st7kiouCRAYO3DKEMbrYHGbH-zw
784	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	$56oOQ2hizWAJWWKoJTMYGwAKX_gaANdZg2QHgtC63ZE
785	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	$6Sy4DU04a_WCzalQkimJ_l9-eYsJ3kcn3Lat9w42L2I
786	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	$FC2J9PSIQLoF8YJo6zY2dP8Eo55L8CPgzVGN7iaofRo
787	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_a:localhost	$WcPnOWvRmgShLlAe8RxY4-_M71l0auS5ykpKdmUS0LU
788	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matrix_a:localhost	$-R5ZDLwPtIisO-W746dPRRrr1U6HjM8uhC78Zh95UUQ
789	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matrix_a:localhost	$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E
794	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$6ZYuUr8K6uh0D7tl9-HD___6hQH3lj8qU1liF0zAkmo
804	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$ewJTQJq2XdLvkqYVULlUmmJ-A3LQ6Jnqs4GDYi6q0DE
805	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo
807	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$Rj6-cgqQLa-sm2y7xCdmsbowv1aA3xi5zbPKvghQvsE
830	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$fbk0yd0IsIg_OjYQ64fApi1RNik4-prJI8T11Dy6aPM
844	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$PTrxs03orEy4-ZNfyuzkahxVWtieNTdLunhf0hN-k1o
848	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$rzHYo2XXi9PMz6SXNk5wcfkdXr9smHym673zevulQTU
849	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$4zUYz066OZYJIgWsaGn3uF__M3YHiHjefiN-pgPBUTY
858	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$qJt5ygVMhv8a-qVGKsla4gmxz629Ai1vT4IzFICcXZw
859	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$g4au_5aKUQgmkW_VQORfsbH-TRts299x55_YYeYVbRs
863	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$Vyf3hOxtpjhjRMKhI1lY_LICGaNkhSSyoQll6drrFGs
868	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$2hWwEm4RlzFOEncRnEEg5BSCfKep1BLoPYQfSoqES7g
876	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$U3_pJaCcLs7xB_jj8HrUER6pYdpIMMqEJ7MvBri5j0I
877	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$yiGiFoaUL9ZDTv9diFjBc3vYGjVBRjaPtEVwSZsXUyc
791	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$19Wa_uoHXFwHicMPIWHRa1c8H1yIjgzKxpDzo89CTTE
792	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$lDJnxY-YfTRyXQcBLRlbFT2_w4DXO4Pks75YGGa5M5o
811	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$1YpqIvJtw2TvK5W2FEFeTvsq9OvOYytjSCk-5swUPAI
821	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$12sa6Yc7rKZv98-tMtW-V3EDnRBEXdI7OuEbRArfjlI
831	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$7KYv-muwdu6SMRcpgNNFubk1An1Dl7_f3Sub6z9Kn7s
865	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$w7san8E2lObp6oE270LUyktBvthDtgPOcDTm4KDJMz4
790	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$M2xNoGVeTRazjk5EjiA0u3mOkneK7za9KWYn2LMJFwA
795	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$t_tUn4wROpupdwEmZnXWQ-mtnx68XnGjofi61K92cRY
799	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$ZLuzCoh1UZ9oNHYyBNCtneq81TelpJ882dsDdio0oKU
810	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$Xa-kxbjVzIuWZk7MczOO0Lsu5l0vPG9R8TEcz-FR7UQ
820	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$0rbT64xaQgvfhKeIPIv_FZNDBSN-LK7f_OPy__2jAAs
827	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$bo-pfXDPqz-6bW6lWqlM_3cqZ5LDsJ1a89yq2uiw4VY
845	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$yPFosTQs7Sqb2lSG4wNvovYGLt5an_pjYvjIN1diKEo
853	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$bwla6VL2GAW2r7Iqbf8BpX84P4Mrq4dkkzXoDMhnK58
864	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$TAufM8VbjDUR2YGA-AHrW5qj3Mfed0Yvg6S9AdbgAxY
869	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$OtjpL6RH8LedvpCr46TvtiaNEJUCVp5siXwzawzvVEQ
793	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$SLqtTg1DQZU0Y4ezk90kDHz7IxD9TXjhW4qQAoPUfTk
802	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Zv-9wNEnjnF-VeZtZKtHkYObGhccwLKewNnJg-fUiF8
808	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$7YneRUzgSdDJ7M_Te78S8xhVh9mMw-zuJtgoD4whiaU
822	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$sLKVG7GtD5c25GHpA9ym3F-Ulp5BbNbOknjtOcH6E_c
832	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$aPIZ5vpa2QHDLskvy384LO6xb_7Grsa-5E7XxcVx2Bc
840	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$ASsIjI2_ngiRDvT7LAQF0tWn3khycNAxuo57kUjSXTA
854	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$bxSzL0H48VoCouxqhSGFdxLFi0hLBupYq4pIVud7N-A
797	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$Qyk1jqM8wu6uOaEDEalSs_0hepeq6CnfZZRy1hQ4sd8
801	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$0ClPrn0jv_hdCQB4TqbWVPUxxSqFeDViCsOjYwQVDAg
803	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$aa2-bg9KcCtrn4nE5HK1JGC6sa8Gr7jWqLhPgLQTtsU
814	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$_lR02zR-Swkcd3UqOwpEP2lSxNkkXnA56Ez_349FQVA
819	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$iU7x4gyphxqfcA5Cp98H-ahXMAhWGOzggfoRn4EPsRU
825	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$f2gGsazlQAaRyNNlEYu8xpuZlgF1HWnzwVt5D0s4mmo
836	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$Zd2-qaHPSceqiflC5zH2SijYuqpTb4uqPC9aDAdL6mc
842	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$XBNgiXxNNVl-1CZgzH8nXkpCUvA_50RTMvdg473YYas
846	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$ZE1ce-mLqCEwF-Y3OX_8wk8ZxkWBY-7gO-a2Fr00umI
850	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$oJbb2yIULGSdtwshWLgKDVR6M7wVruZYHOYxc1GQp9I
855	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$rXJVVj0ynCW0JGPVOewm69a8zWOUyfXO1trJCOTa3yA
860	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$zVAJqVneaN6dmObrxbyMDM0ikKmWGSQHkMTf6TIjZ2o
870	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$whsneZ-CyVZL-8jbp0im-rk0dCxnMqeEiYuM3XNZolE
873	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$8eh5khD7zvskv6jQ-GGlwc1-jks3osUqY32rqqWXGcU
796	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$JgtV2Jrt_3Cws_oeqEte6xeUnTbTSMu0pBPrEWD4WyM
809	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$MZGUVdjeKp_G50hZmBlFVdEB6IqWRZEF_F09RwaUKpg
817	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$qvQpGvaX7NF_3wwnBgcfkCpJPZIxG-uyv3lmw7OsC3E
823	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$ZISsQrKIhyV-C1r9GZrWa3tZAXp6JIvXebe6x5jd8P0
828	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$xlQt_O4a9JMSvIAPLqgQSWXD0SW3AiLYjF_F0DIQjgE
837	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$arbwg5Xz5O_4X_4JNzjQy5_mYTuznn3_4509_ZRraMo
841	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$lZj3Hh5897cVXkQJob8jnbBK7AdlsazPRFavFlrsD84
856	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$4Gzsls_kMYtk_8cgN5vgAXHDaXaeEbTtLs0ASPhSKJc
872	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$HfccZV9bfsEc0jtPXtXHpKH1HhaR-7lwnD3pzLKpy5o
798	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$qgyz1sVriFBiepR7YLOpA_tcnRjhDX9q13fkeJa8i3U
816	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$Tt3TwjqNwF3BMMK_iRnkUM55GhnHQTHdyIujoM4KVf4
838	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$Jza4B4lfmWRl3kM0CWpht5THqgKlntYbX1BbmRiFA1o
851	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$Y6hq0w2WZ8EB7wkjpOg7SWTn8YPKaxOEgsZO9TNrXck
862	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$qQjqkHxUOckS6bBkj8uuQ5qPlNqTt3eesRZbiSETCL4
867	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$Di17M9JIg42R6OGzkz47OQ9A8RVmFm5epuLvTaxVTOY
874	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$ZyDmXhlUtIFNmqJh7KDc4AyC7_a987iLlu77yAuvNy4
800	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$ggRHO4QwGg8SLwSXlSNnHypSBsgj2jFMUXbjC7U97qM
806	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$Zgnflyip0N0Un_OQKWbp8UTKqsYDsMF1KWxIbyyXeZU
812	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$J8aC7EapXPdD7Wn2sBxp9PM_ifD9WOvg9ExQ8VA1EBw
815	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$aPvLQkQt1Em79tepZtbtEvZRdx1NGWpEWGXadEiP2tc
829	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$nC6OBYF3Me6eXYa9KzUrstC_Ypikxd9J9qENgV0H0FU
835	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$BmLqRHFOuidrqnVraB487N0gPPLCfsuOISSVR9ak-sw
839	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Rid4ZH2wt7ZTaZuDxd7EM3MJIKtSXWRpHbiVR1r0hKg
843	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$k1UkeU9EVyBwiDdR4lvkgsbQQNOsoCJpmivkMrsRbiE
866	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Zf-VQ-tTrKZXdjSof9QJwHA_NoexX1KofdTMZ-q2ypY
871	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$iiYXkDx_xvgYas2gOXwd9lgM2y_Pz7JmZ6oebG6x2d8
875	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$vX-e7WIYe5ttyeaD4sjA8RG0wNkHqty52awlhju_N0s
813	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$9Az6aShbcLHi8sucLXwfVQqMXhn0GQU5ARFregtYick
818	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$qNjW0FWyCI9O1d21v-OM1eRYYGTrRAhhoPlWb52bt_E
826	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$SGlG9QIyttSS1S-UxR2rNHpdA98-GK4BJZ6OZ1Y9F2Q
834	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$bs9UhrWMuuIUZUX9yunh_jp-dty7I-OfHOMGV3DDTRk
847	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$-TRGyYJ1RIWG7BZoERAkWXx7e1RmR29ZZUfcZqsLhcs
852	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Mg4CI7sjccWPLYIN-n0dtWvCRLOVWX4nsZom5JNCXzY
857	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$JoNW8TcNOcvY9IFbcbbPrgsG-Doiz3nUPLCb4QDMAik
824	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$CeEa89lM9awBTcCA-i7vxpZfM9ZDn-d4352zYE1fPjQ
833	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$1qreijYdXoeq1tKeGmZgLwyi0tmfw52a_NtPAOaCvZo
861	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$KSiMHQkUituuPCxXNVybLI-4Nt1uQNO23L1gt03SDh0
878	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$o3mOz1bBAIWTtc5vpLi6eZOxdPjSi-kjJAHw4JuFuZw
879	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$rTTOii1dV6AKQ-17hb8e6mpQ0XXn5vXK3Jc14VZKcxo
880	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$6zunp5CCmo4xJR-ScAyGxtn1Amakzs49vZL-SiAUtMc
881	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$wo7Iz5cB2PfLcTPVAmQL_WFFuWKy4ZFMCrKW1t7_EN0
882	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$QzxCVtepRcnUC8W4FRDFuEmAgixsxxGHvLUIdTVxHXc
883	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$SfH6n3byrCtM4pQ-qLwXOI3sCBoDZaC4dsX0dr_Kpwc
884	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$cn29yijVXCQikn8Jy3OwLKbw5ISKXPl0z42QnF4dtD4
885	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$Fe_3hXV7AoKR3N96Mw8dfJm4sXZj5MR8Kmb8uUzQ8v8
886	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$ZLBm_dexB3jkAROZrN7dKQp1U4FLCNU_kBXf4-JBMh0
887	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$FKZcnCf5AfN2lv7vjHE-fMLcvDJa15Di57mU0P4O0fg
889	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$C3iUQm0HMao2GEeuKBnEH_XN0Ll8SwrYygiKbAzj-DA
888	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$g1uAvuaIYLlTkasCZ-i3jkRixnb_Lji1Ltwrgfvik4E
890	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$DQQRR0JcOZkPSoOvNcCXczg99ZSX9tms_2A6SHYKNMU
891	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$7UzeCUU0SlliReZsFaPqnQeLU236-jIEplDshmYVFfM
892	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$qHHEv5q3MpEsIdXH1idIzqQL3tbgWatGPC_QdmUrGFQ
893	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$7myhztOYE9eNYGAgdFsKRcCnSpf2-YqJu_AYt5y8Shs
894	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$0zazzIpeOwV9Dar_jOfAjp9AjrCZZc4XJW_tVHBAhfo
895	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$YUO0Q5ZyT6NtmoNcDY0OIaE7h2-v6ewSxMAh6_kFSf4
896	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$COI-O3jEIQ2nOPVfVLolJbVfR569zTP9xOV5FqX6asE
897	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$N5dvZG3mklnSuwnBA79sbcRtzgPWVSzoPEL7t-m8t3c
898	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$sLzwfw4aW7zEMqrnRJ6m4QCIWMy36zc9h1zHOyh4zTQ
899	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$oeRRvxJqPMCdYMUDH1UQCR0AXPuOr0Sc9x58cFITLjg
900	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$bmFm-3CV_5-ZFPY6Jxw8nDRu0L8LPa8T0HmSV60W09E
901	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$cs7vGd_supYOEssanlgvqGVXb-MiAoq_LwZ2M-nZTI4
902	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$Iry3FS1Vjv2WkozYT4Y59J7aq4varOElqx7PMe7i4bY
903	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$bYhST0uKrA2FW6s-YEFqzPrabK9HadtXA_2I_kIefBo
904	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$8hiJoLRQUD-3tDnyO21z4XB2E8tTyQosS27Nj2kS1Wo
905	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$XNsoQPzNyCDBQ6T9oa0c-m4xQVK2-Aq1C7fHX5aqtb8
906	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$Ihs3atH0QngjgnLFy8eS-sEmZi7IVzT5ZunroMU5ZtY
907	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$pahKUd2PrHxkP1WApv1gWbVOIUGacMzJeLQSQlZqFcY
908	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$UQmqzxE4M1RzsPrQri1fA27BzBQuCgp0mAhi4-vyLOk
909	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$zEX1XaTVtT6Z-Dg158IdyJgqDT_aR0Od37oeoUc4x_k
910	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$lPYG_C62p7bdu_o3MTfT6NKjV0L6Z-qPuyHbhwdzJ9g
911	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$r8SzcOxc0siJLH_T8_PzCsGCyP2b1c71M_Of1YO_f6c
912	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$AKYVSNk5Ft59wwHSBF4NGcGrqWeqB3dSD0Jao-K5de4
913	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$R4jtSfjHvoXvEcTOU7vXV3Snk6KkA9BvHX2FktyKQbE
914	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$sZOegUiHUklzRiC-JOqONVwuR_lF9jeUXhUGx1XWYQQ
915	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$QGPbxlmoLTiTtVRmaN56kgzQUKDv3OOR9NmsCbb4zXI
916	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$EBNT8zpQfljZSVlw3Sd0absk3IHhBMgxCAxvNpodb78
917	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$A6OHxy4153QtccshtR2NuOzOLJe9vlzTYhDmHeTWz3I
918	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$5WD0oHZ8vlUgITaikIMGAGqqxRCTYFX7_Z8rZHUl-vM
919	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$UxIrDMEppa-xA0G7EOBbgW64ncD1QvT5626GzhYjqao
920	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$fI9mHJpfofNXVbuJidriuQ5a-Ziwz9vN6tr3rsa2sTY
921	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$USrw8nxfDlAf-yqvbp8AudpcFJPj6YR0YCrJnQsIBw4
922	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$ejN_OUjcw9SUs5Sjmsq7y-vMQtaEqeqKHZKxXbBAGmY
923	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$gY9nkYqpOB58iJ49O0CIttWZ4pVxlLPY5Fu7a9R16sc
925	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$prtlsqdiW6xDWGbtFM0ModjScjHPOMj0b2jU_s1Vke8
924	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$6_I17LPHYe9WHpIom0CdS9NNbXFumiDxxWMh_yB8TdI
926	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$q-eZwhCHgbg2ExUVkntexoM6sPe0eeOhFaXcDhJ61EA
927	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$UXiA2Bg2egIE7SeNCP-90XMiKIRJ-6jFQH-g8r5wXpw
935	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$85Ks0YVRIFkf1timCh_aBJhcBb6iB3dR-0LCO-XymiE
939	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$f8PsLL43ywA0ViuTZPBacDkI0A1kKsoO32w7uy9NKvU
943	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$DxWfkgU3blaHHVUrxChCcRjq3Nelrux5tRXgh0GrUNM
944	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$u1GoamlCBjFISjI26GC9-bWB23nle0RthbbnczOzJYI
961	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$H0g3tJyU7MkmPdlTEgM0t2oPHcg4U-Hy5XGGGdr2Ju8
976	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$nBOMyFFdnjMXGAuTP_Hxt92V1C2ToBf7dWep_TBMXcQ
997	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$RU23WBla7uK-kp138KgbR17Nu4cyfkmu9lJTzkaj59s
1000	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Eqj92dZexS2BFOjNuZdKef9x-VyhVKLeGyiq6INcx2s
1004	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$VxgZXjCh9QTcXhW1XRTKi457xYt9quUC3jzvHAR8Ww0
928	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$xjauTg8qMh3tRNpoVHaEwBg4hKg59YXOQSFwqyxUM8Q
937	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$U1RP5Wv0hanjBDwRKwfx_IN-pwmkNQBFmdL2bWfCT9E
949	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$tmCfdvFubpDkXJ80CZjZFWuh0uczo5-ksFUONI9z1ww
955	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$AjDYgpQJQ-EFQDypFcjmMh_x7dTp9iaUrmJrAenn0TM
965	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$5l5MFZQmG8xBxUmmKc6HJyG5SFzlszhqCawT0WXlDqk
966	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$sL7pWu4kWsQZRUx7B1VYMso1uxsjnnQ64Kw13SdjxbQ
971	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$ZR6mGfrtspbmZif8XIKs77dDelL3yUoAynBo-VoExQQ
982	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$8Q6aWpZctsbNj0WH4PbSyPe7J_p2zHk9m1ycNoD9F6E
989	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$sgHyC0nCMspBPkOTL2D8atjF_ss0Ma_HGfddDj_hWQw
1015	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$mJBmMspKDM2NNjFgxy8VH4IkIekwf558nJU7KRuToh0
1018	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$VF61G_XL3LzEM4VHM5Sq9OF22D-4JsnA1E_0Rm6iBQo
1032	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$gClqFb3XOmk1NsNHYNeltHzaerMGUglVMjyEMDUj5DE
929	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Dy0nuScsu4OHf9FjCAXMJ60BHH4Tuqml2m-Lv-9m5FM
933	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$ZyHjFZD_sLtPYRp-3nEhL9fPnbL7hbiyErHftWYVGCY
938	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$Pv6-qkvsZVbhgcOJQrazAHXFEjJeXsgfaYv2-C99wKU
942	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$eHAno1JcWsWJGo1csGW_iqvHLWd4gnXcqabVV8kf_JI
945	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$XioofOPYiW4r_WbEqtyjNOGgyuCSgHCJQ4bK05RRPtA
962	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$vaHUp3icRaWD4K6ZKyD-et7Nn1NweIZHbKchZMVt2Rw
972	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$TWxmvclcp3cbkkj07Br-tFntHlAs1PkRujDzAiY4-0w
975	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$Ax9ycToqrEH0gm3gwLZT1lHC8_ESwJUoyH_5ayu32yg
1005	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$RbOyQVW5BEVq-eubE28Z7U9Tr3L_i2b48gIEAvEjO2U
1007	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$sknLBDt1inberFjuplW7jxDlOoHCoNUJuUNDDsnxcCM
1026	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$Ianh3w6LnvE0xLwc2gL2TXCWStfILWBtAM8PVw5YQnQ
1031	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$BKDK0b5t8vbw3PdmyrSvR7u42Y4aw4d83Z8A7tk9ge0
1037	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$AxczXKeEcoOyFPeF2VP4ub-x4drIISUyi-CQmMdvGuA
930	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$kNxpHovDfeSWxuNI8Dqo1MKZabC-2sc82KDkT0Gp53c
947	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$cHFEKJTWjxxkf0Tg0x9PKG3bqzSRIjtm5U-aojVPNLE
948	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$spGlG1nNJ_ZwfrbkOFktJw4VzFbvtEjfXc3SWiCGeuY
953	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$1C7mh1YHcxQ7j6heTRZ9ssc7hbKNW1NnCLf976LZ31g
954	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$5o6FPK62p4fj59yAbT09AmqQSRisvAWMBRYrqbBMnGI
956	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$gQ0tfHL4VAImZtSGv98j2QTgroJDMdWgNj-I-vfIOMY
959	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$BvIAcu7X-pVerZzAcnnMMBAHsRG9s_0cmS3SziPsidQ
963	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$06iVkq49_UE3DvUBOZT4F1bKi_5vuUYGL5O_2uFmz68
978	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$eMdSavESc5KzFHHeHYRlDCTETslWEnS47aMKTnGlCUg
980	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$ycfpT6G0jh2ZLuz8qjtds1HKJwdTIhzdc15zyvA06ic
998	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$D8vwoPiHrlQfFnXl28i2_y3g7e83H3zGLnR36vXn9Rg
999	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$poOEP0hoNsAgo2HKfpnnqjX3zkQd6RT8uqoManoi-WU
1016	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$Omqg6b_C98_sehCXjZoa0UxiP8vDLmHudV6M-Fgytb8
1020	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$R6Irg0_ZxIzVpewB1o6zmlntWcLnN87hcrN9jb7TOQg
1024	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$QyL9pmQvCJkMuP8nEuBAGkjcG-gkAmzYNd_huviEiio
1028	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$YdvWy0WXV_badjRTtOSj8KttXl3Y9mZpHdHxlj341dU
1034	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$0qcvynOqGjem6f-Fx4C-oPBN_Avka5y_UDxu1r09xAg
931	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$Iy8TDhPxQHAYtdgcQz8sLx8KAjMwNhFiHr30n7HbKGo
932	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$qd4_hfefNCwHArC8mxVpf9SVgrX3JYlftaNvT5R9uIc
936	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$DBvt4AoL6YlrBJ1DJ-b5AUeifMfWaCOql8ORqCLTqbo
941	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$KHnU1mW90-lDo3CvCU1ZY1BYl1BWPyv6oOGrrbFuyLs
951	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$FtFYj99c795gtnEpzQDJmGcruD1mQAzmW3xxOhaGxaY
967	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$Xe_3ouBgTJROO5KtF2SKTiVPbOKpdrRbx_f_Z0d2bP8
968	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$OrcSApp5fTYSxGAsF4c4cdllJKLvBbQA9t686yvOw5Q
970	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$OKYDeKcKuE5Sqea283iYY6oIISOMtXeVO87QlF2ezPk
973	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$IQjPUBDt0lqF_IqRU8SyXXtk0wMCMqWB6763g05jDmo
984	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$-03PPbJsZ-4R5pTB0HnA6hZNWGVK4Ls6yYKkjs-7sVE
985	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$_4KyGgOK7XcsIqBpwgOvq5mQ-2EpswvfVA5c5CUfvzk
986	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$XFciMBCHzLHzglWGjo7Y46fSDPsvhJEOjyERGXimHXk
988	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$1PHABpOxMgE7GZ45uAp2l-V25ZhYj1g2yxMT9kqS2qw
1002	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$RHRaqZf8SAKDZtraUS6sGwbkuG0HpdlXNLVkqEzoaCU
1010	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$vg9InjRobCW_TkERR1v5zFWEDPeaLMeAPrF87L3CVoM
1014	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$f0XoBBhr0WGqO1na-Rj4ptEiM2Y4_GcpGWYt19jNPt0
1025	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$utObfLdpdhbzbO6WL7jHJo08sbENGYYLSHcEfxroxQs
1035	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$zVgLTLhhOSNnk0PwxjrNcUyhlIh0ymB3nqDfRgtrhKw
1036	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$S9aSlkVGMguDuHSyYSV3I7Hld-dMkoINpACHewuOlqQ
1039	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$BFx8OOBE9ldqrtR-WVXRJk3026ZLoKoFCdJqEaS_Gzw
934	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$OeYg8Ixye0_R1UhQB-26ADFNFTuK_pc8mwPqH2DHo9U
946	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$eMO1a8LbT0MoTghsDjUz3AdR_U0XLCVpJb9sCRMpfX0
987	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$ikddfOX3Bm6klwZgH_y0dTAvDQLdgAfIqySoFkvM5fk
990	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$_E3e8IELPZWLv3a_BSIVG15oJFRxdYPTM0s7d9RZxMA
992	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$8GhA1X9NrsD2SC1lmIgbZChA0ELl1T5OtBKykBC0k3U
994	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$BgNR3RY9_lqeS5hYZk8urht2LuZAOnkso-NKW_Obg-g
1003	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$agBDUziHZML-GANL4sngL_WSqquMoCEkvgZAoZZyGow
1011	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$HI8RB_6QEYGUGm6GKjA4cP-KmhCKBgX29VRl7ILnoTQ
1017	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$jqBg5fX8xkBXYOef3MU6xMLLrwxSpDqBYHmdLAOujS0
1019	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$ecijDduaN75a7OH96EOFYnFtunue2UjsVQpEnAJQ_Vk
1022	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$JMrtbwuXTsGJm0iCeuYdEK-sc0OJoVyTp284RbFiPxk
1027	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$rykziPHO_QRv84OWAnP2b2cfd6J7y2qsPSiZ7Nn5fAA
940	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$gyvkaB8MG9yhra4pU98I510ZEmJu5gHewCcl12hsUgs
950	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$oX0YEJEcDwHx4rEonsuTu3qq6VSeIs0Hxud4q2uI0b4
957	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$-THTfCnYNhFPd1pCqK8eHM1KzmhXk9QprttnFcmehNU
958	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$J25SSHQ580TwL2PaQ3X7pN8lRh12sSkytpw5iX2DP0c
960	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$WD7Ca8vjw3mnkKT-3S3gf7nLQCEel4hYIHGs9NyHQSg
964	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$jB0RKIdA0DMe_-ArFR4koGzIaVn2-QUIS2j0LvvpmOg
974	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$5WqnKxZDDRKKOND2WiFRmGKwBeIaogSd6ssh0UGBBe0
979	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Bfy3cyYNq0jWBV1SiAWVw_Muw42YEywDNP4KZX_cmS4
981	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$9PNJUS0Xzdt2mT1_cGogdqKZNam3cvGWeTwji0h8F4k
983	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$rPd4eRZuw4gMED2ZgQ5QzrHDG9vs2KxSGiEJuywaSig
991	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$wrRNcC95z8kNum6xy4uzvZZrWy5mdgaBA5wBzXTNEuo
1001	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$2XJNTEwBvofIAsDeoJod7N8FA5lLi2fvg1lep0197DQ
1006	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$wUX_qMEINo24BqmqAvkpiNw2glTMW4LHZpMaUHr_t9w
1009	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$S63yDopPO5_rwpA2OW2tIZinSCVLKuTbzk4oEBRxgFI
1012	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$Xerc4F6QP56C9IDgil5R6nTil1QaTfQxFumBkDT1v7Y
1021	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$q1f5f7RZf3ShRciHf6LpnqDFeeUt1PmvWpFzkJTOmd8
1029	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$W5fHfwoXRnIhIuaVb5rQXsckfOV9vfuKViZlzJb50Rc
1030	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$7trRPgicvr3J9eo7CZnurlYNrpqODvSsG0jeIoGSQ6I
1038	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Hy7qRiuA1WtbS-SqRor01L1jg5xibrbS0AHNujd3uTs
952	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$MmlCrgErTy4QX2RP-B-FbQ37d-ahGAN27l436s1FPis
969	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$EwRNzdoiSbeBupJKnjLdLIVWx5Jtx1ANsJIpo1eJpK0
977	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$zMXSxScyZcVORRyX-ew51P6Q9lfdEVEclRbwpiA8tJU
993	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$Le_nW2097lSPYaktA-osQO0l5O4sVZqS84wr-rU65wk
995	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$svHa1avwjb0nPAdMXMpgfgWk0o9DPEd9TosgAiDx7to
996	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$mDgbocfMQuuIt1dYIHuTh1_3IhhfSrqCviBgNrKt_gg
1008	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$hXP6XeSTT9cqOBiZzKpgd4ZlzS6nZ06SebynSN-22nM
1013	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$l6M51erSVO4aqbVrTfVUYwXVq54maLwilx5p3qQy7ac
1023	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$1qIRJkqBBHrS_C2B0hqSKfBvNtzRxWgv-_PER4wv-r4
1033	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$vuIxc5VRd-ePuUe8UbIhRaf5SdJIDCVV0qITYnLLbds
1040	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$qSYdaB2QTLfIIEL7dBmuJruzc-mKG-Nefl38gdyhquU
1041	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$ELhJW-lL4dy0I4EjKy1CfdleBEzYoQuY_0HWpoaxszE
1042	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$TY4fFx4ngtnMc4pBhnSwhi3hcL49ITM1irEtrQA7T5I
1043	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$8f2B77O2KT0xWYiDjO4Zm7j8nCwL6FuvJGUESnaPdTw
1044	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$wZu5tGB93bPuVZNp1o-P73x5suuYOc--iJ4PMNlVpYU
1045	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$HmHESDB8fY8Im7ve0zC1OozLZNYRk2AqJZx1Mqb-k-M
1046	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$oErofAhwKwSjdiXrb2fNmGAh0LPiRs9cToN1F4qZ0UQ
1047	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$cLyPQLPNAQxHnlfS0uc5n9Y-olvHZw7O77cixROreRg
1048	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$OJ8r4GjCqT7v0XHcQYwUTnPty_DqwRKpqnbXfsehlMk
1049	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$i7E2SMYyfjgOCC6_5zZmZekndFTe1E1OO_y3n-xJCUM
1051	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$Wolh4KSqw4kE1LtzPphtfG-Akiz9XZ6YpBgVBSNmJ7U
1050	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$QOBIHSHhJGkmSpFH9Db8vwW4H_icaL0JQpD93N73oyw
1052	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$jkiMQr0fqAR6Bk3sAwdlc43-GwVkk-y6LvIuExJIXEA
1053	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$nTkvX5Pck4CUWA9ZVA2-ehaERvNr6sCwlLohIOSSixc
1054	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$Xt2ED14lWsgZvSeb-eXZLi3nu8oqHJ9tdbFEVWN4vB8
1055	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$AQq1Or5Cjf-8MCOiU1fijOp6k7h_uQM-f8gA-UnK8DM
1056	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$qCd62sqU0coqNfLVfdVG0Qis8VCggOIrxMW9RRYlzIU
1057	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$sBCT80i-N15EiC23L_f8LbXkoUPx7l8XGo_DolkYHPk
\.


--
-- Data for Name: stats_incremental_position; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.stats_incremental_position (lock, stream_id) FROM stdin;
X	194
\.


--
-- Data for Name: stream_ordering_to_exterm; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.stream_ordering_to_exterm (stream_ordering, room_id, event_id) FROM stdin;
20	!dKcbdDATuwwphjRPQP:localhost	$oPNBx-eTHzyLXPzpYpdxdhLdVeGmx5lNmrECxIazfPQ
21	!kmbTYjjsDRDHGgVqUP:localhost	$3pZnE6ITQzzyNsuVCenuFBVRMocr892PiAvIbMGbMBM
22	!dKcbdDATuwwphjRPQP:localhost	$Oqb-EaDS-8U6U1Z6bTGSE7FJIlxKGhzMkNsnYIJY0Y0
23	!kmbTYjjsDRDHGgVqUP:localhost	$hJeKBcpebJzm9oiwjDCNTWPtbEcfp9GOLXl3yGkyaFU
24	!dKcbdDATuwwphjRPQP:localhost	$9cACT8rCcbUXbMhABzEciyF9pIIDRFNzaBkRVPH_0mk
25	!kmbTYjjsDRDHGgVqUP:localhost	$0gxNuNkWyOeHPtnNZ92FzvprItMgnH9hLCbYuY0Vzos
26	!dKcbdDATuwwphjRPQP:localhost	$9ArTh8Z2w2oc68FOD1X8Ka3DlK7lq00HaHKT_4DMSY4
27	!kmbTYjjsDRDHGgVqUP:localhost	$V_uchZ_8H2oh6EdsXqKsT6Ri62_YZtAAMfZi8pbBGrc
28	!dKcbdDATuwwphjRPQP:localhost	$Q4TOA6SPu2kQIrypB8QEJLHphxV5mHZ_eFwQux4jWSY
29	!kmbTYjjsDRDHGgVqUP:localhost	$YwLlyzcAMpJ69jsxTNglcWTbK8XHK8huc6aB6jpgEWk
30	!dKcbdDATuwwphjRPQP:localhost	$irHFClZVEAzlAtsjct-1MJjEotldPu1Ozkm_NYQrtqI
31	!dKcbdDATuwwphjRPQP:localhost	$QwAobZq6xey4D-6yOm_xg4h6rCKIRUpTqM4HBNroJwE
32	!dKcbdDATuwwphjRPQP:localhost	$3xEI-iU3Teo4B51pXGBbjKxM_DDvYlASNK7W09pHncM
33	!dKcbdDATuwwphjRPQP:localhost	$ETv-B1S-bU8wgS3S1fDdineVdS9YGNq1EMeUPHb6imQ
34	!dKcbdDATuwwphjRPQP:localhost	$GMh4hFLoeDc1Ssk9kdi7yAMIMSZA9zOJYJMC1AJEOKs
35	!dKcbdDATuwwphjRPQP:localhost	$zMfjO64yH55JKcwd-hMCa1P1ARHyAuvBbnPeUiNnS48
36	!kmbTYjjsDRDHGgVqUP:localhost	$5-KkKYPCr68IjD4sKk3rDF6kVYVkDMllW0BFUv7G4Do
37	!kmbTYjjsDRDHGgVqUP:localhost	$sPO_9Od1FvK55Z9_vb0hx3ophiGuLyATo1RKYIEFxHc
38	!dKcbdDATuwwphjRPQP:localhost	$oXLyUPbqiXmRRNovjt9_FJFQLCzMQjPsaism-trtsDw
39	!dKcbdDATuwwphjRPQP:localhost	$7EOMmT1sBVcDB2udDBhhf11Mok_GC9CY-6bxtIKAYpc
40	!kmbTYjjsDRDHGgVqUP:localhost	$-J2tr3j7vfmJ8ZSBAK5AyvQYmP2Byp-7dKfcBg5xHjU
41	!dKcbdDATuwwphjRPQP:localhost	$o0wI9-m-SdyS4UK7_m9_MUd0luWmj6eoXfMg1ieT00g
42	!kmbTYjjsDRDHGgVqUP:localhost	$wEwGnOPXUgG2_4DpqsPrYbSlIM2TnPjdWNDyVbZNE2Y
43	!dKcbdDATuwwphjRPQP:localhost	$oZEGsAxUrYn8R6NS359wZO9T54eXOD-N88ftDK7ZHGU
44	!kmbTYjjsDRDHGgVqUP:localhost	$LN4aYSSVw4GLaWf8g7uzrsw-fHTUyCBwq_-RRgS-MGE
45	!dKcbdDATuwwphjRPQP:localhost	$sY34u-PbOKSI3_z8SIqGfn_2XnO9wqZ_eU1dvGDnRJY
46	!kmbTYjjsDRDHGgVqUP:localhost	$zhfRuogjo-Vq5GM4-f6hyuXBGHx99o9_Nef1KWi2-EM
47	!dKcbdDATuwwphjRPQP:localhost	$3A5iUMUsDMAckTZ_lQ9ZLyQdw7FKGrqWfMMxwAZJCwc
48	!kmbTYjjsDRDHGgVqUP:localhost	$aUCd2uzLS80uiu1DeYrTDp1wAWs7M1ba_4Srm8LLnmU
49	!dKcbdDATuwwphjRPQP:localhost	$zogqtnD68sbYTleQBUL-RkGDpkNmTHar6ilm_2oVnRs
50	!kmbTYjjsDRDHGgVqUP:localhost	$OcjvTopfs1z8zuVgRxn4ynq9LH7z4eQhJnWG0PQ7150
51	!dKcbdDATuwwphjRPQP:localhost	$GcBRlllGdKFvT1pDzY7airMfjuYYNt06vxkQ0BnM6IM
52	!kmbTYjjsDRDHGgVqUP:localhost	$JtjXz-jm6mi5wU33MudkV8ZsCM2V-zduDqeI1xIG254
53	!dKcbdDATuwwphjRPQP:localhost	$6cga7PdI_98v2MEH6Wosfik3Plxt3Ml7GwsUkSFFa00
54	!kmbTYjjsDRDHGgVqUP:localhost	$0BYuX-7BWlMOYXwWp-y_txKwBBorVZzavW6fDuXxUrM
55	!dKcbdDATuwwphjRPQP:localhost	$OOCwtQCB-nmnnlgQ3ST3ItcIsITOLkC3b4a-WpaJjRg
56	!kmbTYjjsDRDHGgVqUP:localhost	$gnR3q3jOOEFI04MZ00yFbtQ5ZNs9EfZENfrrOEEj46s
57	!kmbTYjjsDRDHGgVqUP:localhost	$ZI6mQ9fcQaRUQRDK0WWxDErZcQGD7ahzFrk1b9nCFRE
58	!kmbTYjjsDRDHGgVqUP:localhost	$raYGvFCt-q8kxStPhO_tzxQ3pOmVeo5gn8lTV6sHBvs
59	!kmbTYjjsDRDHGgVqUP:localhost	$mfDu-vDNMkOg-psLHXlWcSXOnVkeuUPJfdm2cZ-3P-k
60	!kmbTYjjsDRDHGgVqUP:localhost	$iDgp052fBKJYL2KTsRdizUAlriA5itky5-e20aiZwHI
61	!dKcbdDATuwwphjRPQP:localhost	$uwN8jjs4qWXT6fsX4o-36T96CWj17IDa_TJ3mF5Hd7M
62	!dKcbdDATuwwphjRPQP:localhost	$mXxM94SwVR0FuKbH_riuFTeW0zH7Om62-HEudW_5y80
63	!kmbTYjjsDRDHGgVqUP:localhost	$OVhb59gyrKY7dsgLlfdIwe1H4O5zslN774jooAK4vec
64	!dKcbdDATuwwphjRPQP:localhost	$AxFCh7nvzu51kpXaQqyK3CKEqdyGhhJ0zhqT-c9LGPk
65	!dKcbdDATuwwphjRPQP:localhost	$0ruVoUZRE1Edh-f7Z0QopPRTCr7L2kEpX8unxgxmfSQ
66	!dKcbdDATuwwphjRPQP:localhost	$hWVSd4FzjwQq7FYDdhFSCgpisb3gxDJ2OAjCjYS6rkg
67	!dKcbdDATuwwphjRPQP:localhost	$OJhJIVnJWjcgl3gc2AqLQK7sy1tKn075fy4E5qUK014
68	!dKcbdDATuwwphjRPQP:localhost	$nsJ2oe7ZtdBtY0V-sJWzGBBDi7tcgH24zUaAdmLjXy4
69	!dKcbdDATuwwphjRPQP:localhost	$XYKCYavbY8FMdUIlSSoqP0likUnTP6uJ0yHoGQCMnWQ
70	!kmbTYjjsDRDHGgVqUP:localhost	$fc-Paa3ZBQU-GAAxH4QWDNrWblQvQ4ddYVzPTPiYV6U
71	!kmbTYjjsDRDHGgVqUP:localhost	$4KgY7ivi_pp1q2tjdk7IWENjs1kzgSRLB29nKbq-UXw
96	!kmbTYjjsDRDHGgVqUP:localhost	$6CT_ZCazUgJysnWN-q2s4b5iR-x1EbXa932nBRpldW4
97	!kmbTYjjsDRDHGgVqUP:localhost	$UD0jEJtVKXhlCRf7VxHITWSUyhzaGkpH0VGbwilf2RE
100	!dKcbdDATuwwphjRPQP:localhost	$UQr1C3BZK9MztXbBR2a0yz0wCyXSy_abmCstrHnXi2E
107	!dKcbdDATuwwphjRPQP:localhost	$56oOQ2hizWAJWWKoJTMYGwAKX_gaANdZg2QHgtC63ZE
108	!dKcbdDATuwwphjRPQP:localhost	$6Sy4DU04a_WCzalQkimJ_l9-eYsJ3kcn3Lat9w42L2I
109	!dKcbdDATuwwphjRPQP:localhost	$FC2J9PSIQLoF8YJo6zY2dP8Eo55L8CPgzVGN7iaofRo
110	!kmbTYjjsDRDHGgVqUP:localhost	$WcPnOWvRmgShLlAe8RxY4-_M71l0auS5ykpKdmUS0LU
111	!kmbTYjjsDRDHGgVqUP:localhost	$-R5ZDLwPtIisO-W746dPRRrr1U6HjM8uhC78Zh95UUQ
112	!dKcbdDATuwwphjRPQP:localhost	$tJMVAlL4QTlxoA6QD4aI6tbc3uDEaPWTHBWDQiOr99E
114	!kmbTYjjsDRDHGgVqUP:localhost	$19Wa_uoHXFwHicMPIWHRa1c8H1yIjgzKxpDzo89CTTE
120	!kmbTYjjsDRDHGgVqUP:localhost	$Qyk1jqM8wu6uOaEDEalSs_0hepeq6CnfZZRy1hQ4sd8
121	!dKcbdDATuwwphjRPQP:localhost	$qgyz1sVriFBiepR7YLOpA_tcnRjhDX9q13fkeJa8i3U
122	!kmbTYjjsDRDHGgVqUP:localhost	$ZLuzCoh1UZ9oNHYyBNCtneq81TelpJ882dsDdio0oKU
125	!dKcbdDATuwwphjRPQP:localhost	$Zv-9wNEnjnF-VeZtZKtHkYObGhccwLKewNnJg-fUiF8
131	!kmbTYjjsDRDHGgVqUP:localhost	$j_Vf4RSpugcR52JQthWyGuqRIEdGrETb4ZLvnGxwwg0
135	!dKcbdDATuwwphjRPQP:localhost	$iVV3o47Y40f29uNsCktD5R1VKbTF1y3nGq4KSKQ5YYo
138	!dKcbdDATuwwphjRPQP:localhost	$53rDO0S-X2QNPUyUVrTGx092yf0EW0nvJXQNLgQ09kc
72	!dKcbdDATuwwphjRPQP:localhost	$0EmcDbHM6t0AJ7YKAcphqL8othdZg4dIXSazEHvnCno
81	!kmbTYjjsDRDHGgVqUP:localhost	$72MNMNMOJMJpfLbdNKdm6ZXGr14ukIKdq-fG2OvzOqg
90	!kmbTYjjsDRDHGgVqUP:localhost	$j4OmrTBgGXlAg2ui751-jxTS4uMSPCzpj81xWRfOWiA
91	!kmbTYjjsDRDHGgVqUP:localhost	$lQM-XkcgjA40yc1T7BNzbZ8V8yxcnsj23SxrixdEev8
106	!dKcbdDATuwwphjRPQP:localhost	$FNOekiMLFE4AEgQ1st7kiouCRAYO3DKEMbrYHGbH-zw
117	!kmbTYjjsDRDHGgVqUP:localhost	$6ZYuUr8K6uh0D7tl9-HD___6hQH3lj8qU1liF0zAkmo
73	!kmbTYjjsDRDHGgVqUP:localhost	$EklY0FV28pDgoXqwoQUjAB5wTv33O8RCHRE8k2k6o2c
98	!kmbTYjjsDRDHGgVqUP:localhost	$BMnLymfijfp2V1tH1M6Nayfx-iF_rRw70COW60dCBG0
102	!dKcbdDATuwwphjRPQP:localhost	$p2y4ivsQApKJEQKZQ-5KFk47veZlq7V00tHHrokVqK0
103	!kmbTYjjsDRDHGgVqUP:localhost	$VzxEyd-riDbZr-sdhUSEcA4h_6kWYfmSeoqEtaZHFFo
104	!dKcbdDATuwwphjRPQP:localhost	$BtKmdXlHyT65KPvPIiDSk38oldbOKOUbuv7J13Up4wE
105	!dKcbdDATuwwphjRPQP:localhost	$HVWinlm6AKNeOld7iV_yqdfmpznmG5wAyWK5k3xjM7Y
126	!kmbTYjjsDRDHGgVqUP:localhost	$aa2-bg9KcCtrn4nE5HK1JGC6sa8Gr7jWqLhPgLQTtsU
137	!kmbTYjjsDRDHGgVqUP:localhost	$99PDED6qRD6JvJgyuUpKL5SGciNeDx4Q8aNU8-knIfI
74	!dKcbdDATuwwphjRPQP:localhost	$ShuNV5AOx3oTjKr3eYjFKvzCZ374R_0vxs2HC21ht-g
89	!kmbTYjjsDRDHGgVqUP:localhost	$QjDo1bVrVGh33tmezjIVWxT6VXLutgIWlP9outS8Gcg
92	!kmbTYjjsDRDHGgVqUP:localhost	$XikqApD6-vTeGUebJl-_Bc9ButeowpABz5W37dejAy0
101	!dKcbdDATuwwphjRPQP:localhost	$wehc8FMA82xW0EU5F86ZkvsBra_SZ0JSA3Yweowv_s8
128	!kmbTYjjsDRDHGgVqUP:localhost	$So407GChNqqEej0rypatHdtuRkC9JXU00HtL08uIclo
134	!kmbTYjjsDRDHGgVqUP:localhost	$sD72WUGTkmqfbvA4mcCNx5IcT-WfbmjsGalYB6V6S-E
75	!kmbTYjjsDRDHGgVqUP:localhost	$UTOQTSrmXya3IQYDcRPwNWN1bIv2zQ3YfbaVRy9NQuA
84	!dKcbdDATuwwphjRPQP:localhost	$EB67Xwo9B0__CxNTvptFIy4e4vG93cmEcHRWbiVSFJU
85	!kmbTYjjsDRDHGgVqUP:localhost	$85g2ma_sFrYS8UbhpRwYEglJLj7xswd8VgNCg787_3E
94	!dKcbdDATuwwphjRPQP:localhost	$kMqJ62yuvBi4RWfOiLMiPcoSKbfcjZvTwwiuRRmfEKA
116	!dKcbdDATuwwphjRPQP:localhost	$SLqtTg1DQZU0Y4ezk90kDHz7IxD9TXjhW4qQAoPUfTk
130	!kmbTYjjsDRDHGgVqUP:localhost	$mjUbm6eO9Jk-i6bqdyRHFZy9L-lH5TOO27GYMQ87nhs
76	!dKcbdDATuwwphjRPQP:localhost	$IfK4xyQ_h94nUHneDilGoM0TTwuWFeP5_u_nlRs571U
82	!dKcbdDATuwwphjRPQP:localhost	$LjACIs2QTEZTfukFRb30GQyevcb7EREdVFxoNEgvHSk
86	!dKcbdDATuwwphjRPQP:localhost	$jL60Q94H_SC7S4ZFOWkA4RilDwTMIUci2DyEXyQS_t0
115	!kmbTYjjsDRDHGgVqUP:localhost	$lDJnxY-YfTRyXQcBLRlbFT2_w4DXO4Pks75YGGa5M5o
118	!dKcbdDATuwwphjRPQP:localhost	$t_tUn4wROpupdwEmZnXWQ-mtnx68XnGjofi61K92cRY
119	!dKcbdDATuwwphjRPQP:localhost	$JgtV2Jrt_3Cws_oeqEte6xeUnTbTSMu0pBPrEWD4WyM
77	!kmbTYjjsDRDHGgVqUP:localhost	$sbDgkkxT05mw8xIVFWyOJtbW9nnehE06Wvxor1z8ms8
79	!dKcbdDATuwwphjRPQP:localhost	$TbzKCcECXvJAKvBu5GZCTLIGi7Js0b1w9dE6KKZXaKo
83	!kmbTYjjsDRDHGgVqUP:localhost	$XhzyXIYIbI0BfDV1QY4H3b4Wrpy5pJgJsGNZc8P8seg
113	!dKcbdDATuwwphjRPQP:localhost	$M2xNoGVeTRazjk5EjiA0u3mOkneK7za9KWYn2LMJFwA
123	!dKcbdDATuwwphjRPQP:localhost	$ggRHO4QwGg8SLwSXlSNnHypSBsgj2jFMUXbjC7U97qM
129	!kmbTYjjsDRDHGgVqUP:localhost	$m8QuIxNBjngQA1UhDPZlw6nIvodE764mdmYG9oCKf94
133	!dKcbdDATuwwphjRPQP:localhost	$RuT3uWLcY4y4GhqYFFNXur6XuNwXipRRmx5rJFfM9ms
78	!dKcbdDATuwwphjRPQP:localhost	$aaPR9QI7az6NxeJ0hSrQxyKzzVyM-rBWODbN9y9rM9Q
80	!kmbTYjjsDRDHGgVqUP:localhost	$2-SFwejONuAnI3cUJ4UN3FSzzJjeIWUURtWOJiO2sWo
88	!dKcbdDATuwwphjRPQP:localhost	$sPW_-g3Oq09Bq8Rm-TKPTRO4HHOlMXEni0rE18Y01h4
93	!dKcbdDATuwwphjRPQP:localhost	$A5qbTNFuQ1MZL2fuT4oUFzi1xCHHDk0NuQZstoz4u-U
99	!dKcbdDATuwwphjRPQP:localhost	$jhFoiytsqlLXRCkoL5gH2sXpQQJFwk3XLtzQPCpA0K8
124	!kmbTYjjsDRDHGgVqUP:localhost	$0ClPrn0jv_hdCQB4TqbWVPUxxSqFeDViCsOjYwQVDAg
136	!dKcbdDATuwwphjRPQP:localhost	$kkmwTP1mOPGymh7Q3_N1Y7ftC1xrv5qaHbV_zi99vD4
87	!kmbTYjjsDRDHGgVqUP:localhost	$WPbDUZRE7W6o_O4D0qf40PxoXNWcHrBwx3LxCA_ILaY
95	!dKcbdDATuwwphjRPQP:localhost	$2xt0-DVGoBAEL-GIwj9HZfHBCQu7_M-HzB2XaEfxjwM
127	!dKcbdDATuwwphjRPQP:localhost	$ewJTQJq2XdLvkqYVULlUmmJ-A3LQ6Jnqs4GDYi6q0DE
132	!kmbTYjjsDRDHGgVqUP:localhost	$kdWmWl1h_wHbp_4CZHM4AOF1I3SpjgbLYkYoFiWiazU
139	!kmbTYjjsDRDHGgVqUP:localhost	$OL5YFZuIzpeGWvQkJsWD5fA-_tqvM6MNM8aACLhDIKc
140	!kmbTYjjsDRDHGgVqUP:localhost	$WxOx5K9OBtSH4SKkxlQDUCVkiuA8mdui6eTN417KUig
141	!kmbTYjjsDRDHGgVqUP:localhost	$9eV_AyLXyN9dQJyo8nKzxH0MD2Pj26OD3m5hxM368ek
142	!dKcbdDATuwwphjRPQP:localhost	$KAudDRl-ilYkXdKdFFwSH1rjB9FuDL3iaIcj9chsvuc
143	!dKcbdDATuwwphjRPQP:localhost	$NBW9KofbXfyJlflrssj5f0gU9-vix_ChkMTdCTutt6E
144	!dKcbdDATuwwphjRPQP:localhost	$G4jqJ_vLOuComzEY5LKlWgJmqk76rEv2BaFnoUc32C4
145	!kmbTYjjsDRDHGgVqUP:localhost	$PmdsaAuptefoxepoi5dH3S5XZjMQnrw_IY8E3iiC0JI
146	!kmbTYjjsDRDHGgVqUP:localhost	$LLxGQgsj2x835E7aJtEtKuPEzf1fHJTT_1b0cxZaynk
147	!kmbTYjjsDRDHGgVqUP:localhost	$xaKVxYK5Ka0brhbVcFdQdutgxYlZom-dUIRWmloBBms
148	!dKcbdDATuwwphjRPQP:localhost	$7IBjUUbkm6m5Y_DazT_SUW3_XBAwV0nvHP6nkPuBbV0
149	!dKcbdDATuwwphjRPQP:localhost	$iZZsHDRKa9MPh0wKPGoTIkR9_IN1gXmgYQ3CLA-oEsU
150	!dKcbdDATuwwphjRPQP:localhost	$OxJtFsDfjfHJ57HdnctrwwYfeMAuGw-MFWayc0MqGW4
151	!dKcbdDATuwwphjRPQP:localhost	$OIgyn6WfwavdRqCIV587JtVG-UzMqFnY1_VC_N2O6ok
152	!kmbTYjjsDRDHGgVqUP:localhost	$z-yABBMUu-RFJeiOLWwmWghP2O4vgO3Bts6c9FX-uG8
153	!kmbTYjjsDRDHGgVqUP:localhost	$P2eP-7teBmGXcBM7DqUedLeBNdY5eaTasFqCr7GXY74
154	!kmbTYjjsDRDHGgVqUP:localhost	$62DK_5Urc-R1gCm6T-D7rEFWp3Q47rECTaNApSOe0tg
155	!kmbTYjjsDRDHGgVqUP:localhost	$reo6-sRCAReTplLLrWZiUXEMMfaufd1o-PclhKbhxXw
156	!dKcbdDATuwwphjRPQP:localhost	$LiUaGyMC-ZVhJFLD9EeZsUNlhdIzJ2J41q-tpdMYQ-g
157	!dKcbdDATuwwphjRPQP:localhost	$kGXjbDILpzPlAVquVm-0ro1Y2cAjvBSU3chLQmB-ZgI
158	!dKcbdDATuwwphjRPQP:localhost	$iR6CRvH8xG5VgeMQIZFMBeaVeTjxgDtnqT7tv-PoCf8
159	!kmbTYjjsDRDHGgVqUP:localhost	$47BkoMnB5FT3PSdXLEy0rb4ZdbS1q9w82a669O4lBXg
160	!kmbTYjjsDRDHGgVqUP:localhost	$zI1CZE-pX4aF7RBiJiZqzqFZlxIfJRBpmSuBjEzHTCQ
161	!kmbTYjjsDRDHGgVqUP:localhost	$y7fmz8cz_zrBS0ZmRnthufiCH3PFkuCVz8YKzQaf81g
162	!dKcbdDATuwwphjRPQP:localhost	$mJ65YIJRPOxuW2mcyV5dt1MwIY7iWY76Fnj51047dZM
163	!dKcbdDATuwwphjRPQP:localhost	$p7GJemyaMZGUqYX0guKHUqmObfwF2yChmhI7v1sn2nE
164	!dKcbdDATuwwphjRPQP:localhost	$Ky-_xzOrnEPuDm0WQev0E1urDcDHtvv8esKT3jQ6lFY
165	!dKcbdDATuwwphjRPQP:localhost	$5Iq2ZU88BXgNKKqMGOu71dH7vsyaxwI-Fxg8ocEMI2E
166	!kmbTYjjsDRDHGgVqUP:localhost	$LHW3l0dgme8yNUY6xjIvP_Osal1_vZAuIfg7vCLzGKI
167	!kmbTYjjsDRDHGgVqUP:localhost	$_XRh5iYtBtMSC8b9sq-Zq1kS1LqI6azDTXLEGQTiQSs
168	!kmbTYjjsDRDHGgVqUP:localhost	$jgIb5yphKm1y65Shpo1bZF38fQ0ZqUjOopYEMjB2JS0
169	!kmbTYjjsDRDHGgVqUP:localhost	$j96SJY0VtGl6Q_Fnj_jg3BifdW7s0-Vd8t57DrAeAX8
170	!dKcbdDATuwwphjRPQP:localhost	$5-UBR4vNvgnHcUIuQA0gIHJmn4pOL-BNEZ33B-2Dmes
171	!dKcbdDATuwwphjRPQP:localhost	$8f7euYUQUOKVs1LECS5C0ny-iJc0LrEhKy5AjaE9VwM
172	!dKcbdDATuwwphjRPQP:localhost	$n7rEuNOUTfPAb-nKtA8sQLtp0FZoDqOfMyqN9eKVULc
173	!kmbTYjjsDRDHGgVqUP:localhost	$KdF0e2L1V2qamNtPDDdbE1nZ8xvaqEBCeH0VcCCosQ8
174	!kmbTYjjsDRDHGgVqUP:localhost	$VGPWrlgPM0aSEOjGq1_ygJ2gwcjdfMl06P2yF-1EjMw
175	!kmbTYjjsDRDHGgVqUP:localhost	$T-S0-0A2-tysbZGnQHyOgfmxVouK-Ise06pRgQbLLcg
176	!dKcbdDATuwwphjRPQP:localhost	$jTQQwpTqOMCeKxagSFuov0Dg8yBrYJJogGNCxBE1qwk
177	!dKcbdDATuwwphjRPQP:localhost	$8Hjay0ed9n_Y3vv-Lhtc_-A0-5CvZe8YsPugJA7pwVg
178	!dKcbdDATuwwphjRPQP:localhost	$NHchZjGDozZxBeE_hBCfcWNQSoGcpRSxMwGAV4CVzWU
179	!dKcbdDATuwwphjRPQP:localhost	$5G3tHkgsc39AkOi94e7gxCeKaPhkmyOOAZlGWI8YaCQ
180	!kmbTYjjsDRDHGgVqUP:localhost	$c-G9o6jTgFkz_rB_zESYfRkHoFMmTM5uCDXF1JAermc
181	!kmbTYjjsDRDHGgVqUP:localhost	$eY9D8MVKC5bDdinpPVI9ooLWvoYHx0tLFn-vRWkp9nk
182	!kmbTYjjsDRDHGgVqUP:localhost	$AAj21zp54kdoP3h1Zql3vB7JlPNE4Y9HrXrzBQPQrTA
183	!kmbTYjjsDRDHGgVqUP:localhost	$VZnQHRUET5azOmfmvUZMF1_eEKzi1_WkVHB0pxMELxo
184	!dKcbdDATuwwphjRPQP:localhost	$7q-JkspgsFYptPnMJ25LHdffz-rXLRDHzidSYCV3Kc8
185	!dKcbdDATuwwphjRPQP:localhost	$dtGyXiOFORXfCA1yAgiPJbV5UKJjEo-zfetInljHoV0
186	!dKcbdDATuwwphjRPQP:localhost	$dxD8VRi5x30Gu7BMEOui-JOrXZEL9meU6Q8aZra1b6U
187	!kmbTYjjsDRDHGgVqUP:localhost	$bXKGeqgVWpdObwAv0HPtsV7_MNqo8HhD_whsZ1gxx54
188	!kmbTYjjsDRDHGgVqUP:localhost	$LOcz4Bm15D4BsyuDXygSGL-0AvIjwSLYy4cezgebQK8
189	!kmbTYjjsDRDHGgVqUP:localhost	$RJSqE0ZymidM-ZtkpYLdrShv6_yNohaw5QtWzVooGsk
190	!dKcbdDATuwwphjRPQP:localhost	$EdC99i51IXAQXh-JndOybB0EFIdpgm02s0Z6Takw4Jw
191	!dKcbdDATuwwphjRPQP:localhost	$pp-1vh-obnf3bLKs4cnpwy9dbINdz1MGiUDLrdenfek
192	!dKcbdDATuwwphjRPQP:localhost	$xKmd10QHFv5EgHAyd9HpWHkEi2QTI9MhKVlqpVntWM8
193	!dKcbdDATuwwphjRPQP:localhost	$gLYRtP_fFTIbdUQ6jtldLcUG60gMNlghw7x9t2_PurE
194	!kmbTYjjsDRDHGgVqUP:localhost	$AbcQJxS0qvSibn6R_hm5OSrLKkHjrpsW8oo97om40r8
\.


--
-- Data for Name: stream_positions; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.stream_positions (stream_name, instance_name, stream_id) FROM stdin;
events	master	194
presence_stream	master	68
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
\.


--
-- Data for Name: user_daily_visits; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_daily_visits (user_id, device_id, "timestamp", user_agent) FROM stdin;
@admin:localhost	WCSUBIGVWG	1672185600000	
@matrix_a:localhost	TKAVEOGKHH	1672185600000	
@admin:localhost	WCSUBIGVWG	1672272000000	
@matrix_a:localhost	TKAVEOGKHH	1672272000000	
@matrix_b:localhost	DJFHSWMXLW	1672272000000	
\.


--
-- Data for Name: user_directory; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_directory (user_id, room_id, display_name, avatar_url) FROM stdin;
@admin:localhost	\N	admin	\N
@matrix_a:localhost	\N	matrix_a	\N
@matrix_b:localhost	\N	matrix_b	\N
@ignored_user:localhost	\N	ignored_user	\N
@bridgedemo1:localhost	\N	bridgedemo1	\N
\.


--
-- Data for Name: user_directory_search; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_directory_search (user_id, vector) FROM stdin;
@admin:localhost	'admin':1A,3B 'localhost':2
@matrix_a:localhost	'localhost':2 'matrix':1A,3B
@matrix_b:localhost	'b':2A,5B 'localhost':3 'matrix':1A,4B
@ignored_user:localhost	'ignor':1A,4B 'localhost':3 'user':2A,5B
@bridgedemo1:localhost	'bridgedemo1':1A,3B 'localhost':2
\.


--
-- Data for Name: user_directory_stream_pos; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_directory_stream_pos (lock, stream_id) FROM stdin;
X	194
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
@admin:localhost	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjNjaWQgdXNlcl9pZCA9IEBhZG1pbjpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSBXVU9yUTVRMFRnUkNjME1ACjAwMmZzaWduYXR1cmUgdYKA-yuTQ5JV5O0HWRak-48xavOYgA1MMc6A1V_Uw5kK	WCSUBIGVWG	172.19.0.1		1672317897932
@matrix_a:localhost	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjZjaWQgdXNlcl9pZCA9IEBtYXRyaXhfYTpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSAwb3Y6eTZVdHojUk4jbFprCjAwMmZzaWduYXR1cmUgNNZKnOVRzj5svh9pEM0UUEqtXYnHjnj9XyNLJ1_uKoAK	TKAVEOGKHH	172.19.0.1		1672317898023
@matrix_b:localhost	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjZjaWQgdXNlcl9pZCA9IEBtYXRyaXhfYjpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSBBYl9hbWthI0daSzgtfjdICjAwMmZzaWduYXR1cmUgOReBLkPURCMNtzORS9fpogQqVa3IWN9ZEu5gXW91QTMK	DJFHSWMXLW	172.19.0.1		1672317898111
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
@matrix_b:localhost	2	17
@ignored_user:localhost	2	19
@bridgedemo1:localhost	0	19
@matrix_a:localhost	2	112
@matterbot:localhost	2	120
@mm_mattermost_b:localhost	2	126
@mm_mattermost_a:localhost	2	128
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
@bridgedemo1:localhost	$2b$12$MelzefiZZcZqumhVo6Sl4.HfGeoLW2fJEDB79eZ3d2nPLi8ypRkUm	1672237198	0	\N	0	\N	\N	\N	\N	0	f
@matterbot:localhost		1672241417	0	\N	0	xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	\N	\N	\N	0	f
@mm_mattermost_a:localhost		1672241421	0	\N	0	xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	\N	\N	\N	0	f
@mm_mattermost_b:localhost		1672241421	0	\N	0	xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	\N	\N	\N	0	f
\.


--
-- Data for Name: users_in_public_rooms; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.users_in_public_rooms (user_id, room_id) FROM stdin;
@admin:localhost	!kmbTYjjsDRDHGgVqUP:localhost
@admin:localhost	!dKcbdDATuwwphjRPQP:localhost
@matrix_b:localhost	!kmbTYjjsDRDHGgVqUP:localhost
@matrix_b:localhost	!dKcbdDATuwwphjRPQP:localhost
@ignored_user:localhost	!kmbTYjjsDRDHGgVqUP:localhost
@ignored_user:localhost	!dKcbdDATuwwphjRPQP:localhost
@matrix_a:localhost	!kmbTYjjsDRDHGgVqUP:localhost
@matrix_a:localhost	!dKcbdDATuwwphjRPQP:localhost
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

SELECT pg_catalog.setval('public.cache_invalidation_stream_seq', 167, true);


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

SELECT pg_catalog.setval('public.events_stream_seq', 194, true);


--
-- Name: instance_map_instance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.instance_map_instance_id_seq', 1, false);


--
-- Name: presence_stream_sequence; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.presence_stream_sequence', 68, true);


--
-- Name: receipts_sequence; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.receipts_sequence', 1, true);


--
-- Name: state_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.state_group_id_seq', 1057, true);


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

