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

--
-- Name: check_partial_state_events(); Type: FUNCTION; Schema: public; Owner: synapse
--

CREATE FUNCTION public.check_partial_state_events() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
            BEGIN
                IF EXISTS (
                    SELECT 1 FROM events
                    WHERE events.event_id = NEW.event_id
                       AND events.room_id != NEW.room_id
                ) THEN
                    RAISE EXCEPTION 'Incorrect room_id in partial_state_events';
                END IF;
                RETURN NEW;
            END;
            $$;


ALTER FUNCTION public.check_partial_state_events() OWNER TO synapse;

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
    read_receipt_stream_id bigint,
    presence_stream_id bigint,
    to_device_stream_id bigint,
    device_list_stream_id bigint
);


ALTER TABLE public.application_services_state OWNER TO synapse;

--
-- Name: application_services_txn_id_seq; Type: SEQUENCE; Schema: public; Owner: synapse
--

CREATE SEQUENCE public.application_services_txn_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.application_services_txn_id_seq OWNER TO synapse;

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
-- Name: device_auth_providers; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.device_auth_providers (
    user_id text NOT NULL,
    device_id text NOT NULL,
    auth_provider_id text NOT NULL,
    auth_provider_session_id text NOT NULL
);


ALTER TABLE public.device_auth_providers OWNER TO synapse;

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
-- Name: device_lists_changes_converted_stream_position; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.device_lists_changes_converted_stream_position (
    lock character(1) DEFAULT 'X'::bpchar NOT NULL,
    stream_id bigint NOT NULL,
    room_id text NOT NULL,
    CONSTRAINT device_lists_changes_converted_stream_position_lock_check CHECK ((lock = 'X'::bpchar))
);


ALTER TABLE public.device_lists_changes_converted_stream_position OWNER TO synapse;

--
-- Name: device_lists_changes_in_room; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.device_lists_changes_in_room (
    user_id text NOT NULL,
    device_id text NOT NULL,
    room_id text NOT NULL,
    stream_id bigint NOT NULL,
    converted_to_destinations boolean NOT NULL,
    opentracing_context text
);


ALTER TABLE public.device_lists_changes_in_room OWNER TO synapse;

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
-- Name: device_lists_remote_pending; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.device_lists_remote_pending (
    stream_id bigint NOT NULL,
    user_id text NOT NULL,
    device_id text NOT NULL
);


ALTER TABLE public.device_lists_remote_pending OWNER TO synapse;

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
    room_id text,
    is_state boolean DEFAULT false NOT NULL
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
-- Name: event_failed_pull_attempts; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_failed_pull_attempts (
    room_id text NOT NULL,
    event_id text NOT NULL,
    num_attempts integer NOT NULL,
    last_attempt_ts bigint NOT NULL,
    last_cause text NOT NULL
);


ALTER TABLE public.event_failed_pull_attempts OWNER TO synapse;

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
    unread smallint,
    thread_id text
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
    unread smallint,
    thread_id text,
    inserted_ts bigint DEFAULT (EXTRACT(epoch FROM now()) * (1000)::numeric)
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
    unread_count bigint,
    last_receipt_stream_ordering bigint,
    thread_id text
);


ALTER TABLE public.event_push_summary OWNER TO synapse;

--
-- Name: event_push_summary_last_receipt_stream_id; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_push_summary_last_receipt_stream_id (
    lock character(1) DEFAULT 'X'::bpchar NOT NULL,
    stream_id bigint NOT NULL,
    CONSTRAINT event_push_summary_last_receipt_stream_id_lock_check CHECK ((lock = 'X'::bpchar))
);


ALTER TABLE public.event_push_summary_last_receipt_stream_id OWNER TO synapse;

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
ALTER TABLE ONLY public.event_search ALTER COLUMN room_id SET (n_distinct=-0.01);


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
    stream_ordering bigint,
    state_key text,
    rejection_reason text
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
-- Name: login_tokens; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.login_tokens (
    token text NOT NULL,
    user_id text NOT NULL,
    expiry_ts bigint NOT NULL,
    used_ts bigint,
    auth_provider_id text,
    auth_provider_session_id text
);


ALTER TABLE public.login_tokens OWNER TO synapse;

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
-- Name: partial_state_events; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.partial_state_events (
    room_id text NOT NULL,
    event_id text NOT NULL
);


ALTER TABLE public.partial_state_events OWNER TO synapse;

--
-- Name: partial_state_rooms; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.partial_state_rooms (
    room_id text NOT NULL,
    device_lists_stream_id bigint DEFAULT 0 NOT NULL,
    join_event_id text,
    joined_via text
);


ALTER TABLE public.partial_state_rooms OWNER TO synapse;

--
-- Name: partial_state_rooms_servers; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.partial_state_rooms_servers (
    room_id text NOT NULL,
    server_name text NOT NULL
);


ALTER TABLE public.partial_state_rooms_servers OWNER TO synapse;

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
    failing_since bigint,
    enabled boolean,
    device_id text
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
    data text NOT NULL,
    thread_id text
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
    instance_name text,
    event_stream_ordering bigint,
    thread_id text
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
    next_token_id bigint,
    expiry_ts bigint,
    ultimate_session_expiry_ts bigint
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
    topic text,
    room_type text
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
-- Name: threads; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.threads (
    room_id text NOT NULL,
    thread_id text NOT NULL,
    latest_event_id text NOT NULL,
    topological_ordering bigint NOT NULL,
    stream_ordering bigint NOT NULL
);


ALTER TABLE public.threads OWNER TO synapse;

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
    shadow_banned boolean,
    consent_ts bigint,
    approved boolean
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
2	@matterbot:localhost	OLBOZIJMVW	syt_bWF0dGVyYm90_qGhTXcfYSAtIXxMkJoXD_1QuGhe	\N	\N	1675285580099	\N	f
3	@admin:localhost	SKYCUHVNIF	syt_YWRtaW4_PKfmprBqpLSUHTXlnxuX_1Veg6R	\N	\N	1675287345904	\N	f
4	@admin:localhost	MCWQGRUWJV	syt_YWRtaW4_zzjcJlaeJfDtltVuDqsj_3MzL9R	\N	\N	1675287441320	\N	t
5	@mm_admin:localhost	CQIRMKNFTR	syt_bW1fYWRtaW4_ApqivuEaDQSEfehoxPpw_2lBf4B	\N	\N	1675287996151	\N	f
\.


--
-- Data for Name: account_data; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.account_data (user_id, account_data_type, stream_id, content, instance_name) FROM stdin;
@admin:localhost	org.matrix.msc3890.local_notification_settings.MCWQGRUWJV	3	{"is_silenced":false}	\N
@admin:localhost	im.vector.analytics	4	{"pseudonymousAnalyticsOptIn":false}	\N
@admin:localhost	im.vector.setting.breadcrumbs	17	{"recent_rooms":["!DaecDLDoTLOuqPWadN:localhost","!YmJPedFXUiFFGzTnFq:localhost"]}	\N
\.


--
-- Data for Name: account_validity; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.account_validity (user_id, expiration_ts_ms, email_sent, renewal_token, token_used_ts_ms) FROM stdin;
\.


--
-- Data for Name: application_services_state; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.application_services_state (as_id, state, read_receipt_stream_id, presence_stream_id, to_device_stream_id, device_list_stream_id) FROM stdin;
xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	up	\N	\N	\N	\N
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
73	73/01event_failed_pull_attempts.sql
73	73/02add_pusher_enabled.sql
73	73/02room_id_indexes_for_purging.sql
73	73/03pusher_device_id.sql
73	73/03users_approved_column.sql
73	73/04partial_join_details.sql
73	73/04pending_device_list_updates.sql
73	73/05old_push_actions.sql.postgres
73	73/06thread_notifications_thread_id_idx.sql
73	73/08thread_receipts_non_null.sql.postgres
73	73/09partial_joined_via_destination.sql
73	73/09threads_table.sql
73	73/10_update_sqlite_fts4_tokenizer.py
73	73/10login_tokens.sql
73	73/11event_search_room_id_n_distinct.sql.postgres
73	73/12refactor_device_list_outbound_pokes.sql
73	73/13add_device_lists_index.sql
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
X	24
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
2	master	user_last_seen_monthly_active	\N	1675285304390
3	master	get_monthly_active_count	{}	1675285304398
4	master	get_user_by_id	{@matterbot:localhost}	1675285580070
5	master	get_user_by_id	{@admin:localhost}	1675287345873
6	master	count_e2e_one_time_keys	{@admin:localhost,MCWQGRUWJV}	1675287440840
7	master	get_e2e_unused_fallback_key_types	{@admin:localhost,MCWQGRUWJV}	1675287440863
8	master	count_e2e_one_time_keys	{@admin:localhost,MCWQGRUWJV}	1675287440947
9	master	get_e2e_unused_fallback_key_types	{@admin:localhost,MCWQGRUWJV}	1675287440955
10	master	count_e2e_one_time_keys	{@admin:localhost,MCWQGRUWJV}	1675287441024
11	master	count_e2e_one_time_keys	{@admin:localhost,MCWQGRUWJV}	1675287441080
12	master	count_e2e_one_time_keys	{@admin:localhost,MCWQGRUWJV}	1675287441143
13	master	count_e2e_one_time_keys	{@admin:localhost,MCWQGRUWJV}	1675287441202
14	master	count_e2e_one_time_keys	{@admin:localhost,MCWQGRUWJV}	1675287441260
15	master	count_e2e_one_time_keys	{@admin:localhost,MCWQGRUWJV}	1675287441336
16	master	_get_bare_e2e_cross_signing_keys	{@admin:localhost}	1675287441339
17	master	_get_bare_e2e_cross_signing_keys	{@admin:localhost}	1675287441352
18	master	_get_bare_e2e_cross_signing_keys	{@admin:localhost}	1675287441368
19	master	count_e2e_one_time_keys	{@admin:localhost,MCWQGRUWJV}	1675287441419
20	master	count_e2e_one_time_keys	{@admin:localhost,MCWQGRUWJV}	1675287441583
21	master	get_aliases_for_room	{!DaecDLDoTLOuqPWadN:localhost}	1675287622922
22	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost}	1675287623018
23	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@admin:localhost}	1675287623174
24	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost}	1675287623640
25	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost}	1675287623897
26	master	get_aliases_for_room	{!YmJPedFXUiFFGzTnFq:localhost}	1675287779248
27	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost}	1675287779327
28	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@admin:localhost}	1675287779577
29	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost}	1675287780078
30	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost}	1675287780310
31	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675287995933
32	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675287995934
33	master	get_user_by_id	{@mm_admin:localhost}	1675287996112
34	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost}	1675288813851
35	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost}	1675288846564
36	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost}	1675288889179
37	master	user_last_seen_monthly_active	\N	1675288904261
38	master	get_monthly_active_count	{}	1675288904263
39	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@mm_admin:localhost}	1675288909897
40	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@mm_admin:localhost}	1675288909922
41	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@mm_admin:localhost}	1675288910203
42	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@mm_admin:localhost}	1675288910292
\.


--
-- Data for Name: current_state_delta_stream; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.current_state_delta_stream (stream_id, room_id, type, state_key, event_id, prev_event_id, instance_name) FROM stdin;
2	!DaecDLDoTLOuqPWadN:localhost	m.room.create		$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	\N	master
3	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@admin:localhost	$UaZuzLfnyOIw3iLU39I6ihmpGMjzRB3mDd4pkHT22Jo	\N	master
4	!DaecDLDoTLOuqPWadN:localhost	m.room.canonical_alias		$StretV_bUYoe4zZLM8qe8KW0l5M_C1Ik6aSZVQxi8rg	\N	master
4	!DaecDLDoTLOuqPWadN:localhost	m.room.history_visibility		$M1L18DSD9p1dUaGXmyktgOAaNvLS1cAXM3CfIMT15LE	\N	master
4	!DaecDLDoTLOuqPWadN:localhost	m.room.join_rules		$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	\N	master
4	!DaecDLDoTLOuqPWadN:localhost	m.room.power_levels		$cPQw7bnJzfkKROnFKbANhreS_L7eznZtJH4RClxd71s	\N	master
8	!DaecDLDoTLOuqPWadN:localhost	m.room.name		$kQauQY6TyYK4PeP16G5HJI6i9oybAY_CtRu56inmyEk	\N	master
9	!YmJPedFXUiFFGzTnFq:localhost	m.room.create		$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	\N	master
10	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@admin:localhost	$HpReuVvJCIb4gFAA0V1ZLkXuAYpbGbYJ9xTxIowp0iA	\N	master
11	!YmJPedFXUiFFGzTnFq:localhost	m.room.canonical_alias		$hGkMaf8X0yAqBrPj1PikKCF5r3g0CD5sbqK_0vYDI3s	\N	master
11	!YmJPedFXUiFFGzTnFq:localhost	m.room.history_visibility		$Ln0DFzhDHk3ZBOxf3CqyszFxBgR-vLuaU6XMGfFiMBY	\N	master
11	!YmJPedFXUiFFGzTnFq:localhost	m.room.join_rules		$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	\N	master
11	!YmJPedFXUiFFGzTnFq:localhost	m.room.power_levels		$DoaPAQf-ky_qYpibXlB13gxRmHsYdEJTQRCskrRSxrI	\N	master
15	!YmJPedFXUiFFGzTnFq:localhost	m.room.name		$aR_Ehub6nY87EKeuOUobM8EqspDDVswweVVJLsgPe9M	\N	master
16	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4	\N	master
17	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc	\N	master
18	!YmJPedFXUiFFGzTnFq:localhost	m.room.power_levels		$3iRjuPdSa2RM8LZ_hEUz2rpxW7wRYwAMtjldk4L3x2o	$DoaPAQf-ky_qYpibXlB13gxRmHsYdEJTQRCskrRSxrI	master
19	!YmJPedFXUiFFGzTnFq:localhost	m.room.power_levels		$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	$3iRjuPdSa2RM8LZ_hEUz2rpxW7wRYwAMtjldk4L3x2o	master
20	!DaecDLDoTLOuqPWadN:localhost	m.room.power_levels		$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	$cPQw7bnJzfkKROnFKbANhreS_L7eznZtJH4RClxd71s	master
21	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@mm_admin:localhost	$CqTXYvkWmU1WEVsryzPffrK-UFPsAp9ZN7hNFMzRdcU	\N	master
22	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@mm_admin:localhost	$M7i7kIr_313-fsK6zIJjyPUvcArWEnDYRpGwuz1z5zY	\N	master
23	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@mm_admin:localhost	$e59i0svd92559O6Ylspucl1xefsa8dpbbZe0ZE0mUp4	$M7i7kIr_313-fsK6zIJjyPUvcArWEnDYRpGwuz1z5zY	master
24	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@mm_admin:localhost	$6Lgivd2MHjS9x-3BOttMrBNfnyKpvrsbwS8TFPVdz1c	$CqTXYvkWmU1WEVsryzPffrK-UFPsAp9ZN7hNFMzRdcU	master
\.


--
-- Data for Name: current_state_events; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.current_state_events (event_id, room_id, type, state_key, membership) FROM stdin;
$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost	m.room.create		\N
$UaZuzLfnyOIw3iLU39I6ihmpGMjzRB3mDd4pkHT22Jo	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@admin:localhost	join
$StretV_bUYoe4zZLM8qe8KW0l5M_C1Ik6aSZVQxi8rg	!DaecDLDoTLOuqPWadN:localhost	m.room.canonical_alias		\N
$M1L18DSD9p1dUaGXmyktgOAaNvLS1cAXM3CfIMT15LE	!DaecDLDoTLOuqPWadN:localhost	m.room.history_visibility		\N
$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost	m.room.join_rules		\N
$kQauQY6TyYK4PeP16G5HJI6i9oybAY_CtRu56inmyEk	!DaecDLDoTLOuqPWadN:localhost	m.room.name		\N
$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost	m.room.create		\N
$HpReuVvJCIb4gFAA0V1ZLkXuAYpbGbYJ9xTxIowp0iA	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@admin:localhost	join
$hGkMaf8X0yAqBrPj1PikKCF5r3g0CD5sbqK_0vYDI3s	!YmJPedFXUiFFGzTnFq:localhost	m.room.canonical_alias		\N
$Ln0DFzhDHk3ZBOxf3CqyszFxBgR-vLuaU6XMGfFiMBY	!YmJPedFXUiFFGzTnFq:localhost	m.room.history_visibility		\N
$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	!YmJPedFXUiFFGzTnFq:localhost	m.room.join_rules		\N
$aR_Ehub6nY87EKeuOUobM8EqspDDVswweVVJLsgPe9M	!YmJPedFXUiFFGzTnFq:localhost	m.room.name		\N
$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	join
$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	join
$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost	m.room.power_levels		\N
$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost	m.room.power_levels		\N
$e59i0svd92559O6Ylspucl1xefsa8dpbbZe0ZE0mUp4	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@mm_admin:localhost	join
$6Lgivd2MHjS9x-3BOttMrBNfnyKpvrsbwS8TFPVdz1c	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@mm_admin:localhost	join
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
-- Data for Name: device_auth_providers; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.device_auth_providers (user_id, device_id, auth_provider_id, auth_provider_session_id) FROM stdin;
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
-- Data for Name: device_lists_changes_converted_stream_position; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.device_lists_changes_converted_stream_position (lock, stream_id, room_id) FROM stdin;
X	10	
\.


--
-- Data for Name: device_lists_changes_in_room; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.device_lists_changes_in_room (user_id, device_id, room_id, stream_id, converted_to_destinations, opentracing_context) FROM stdin;
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
-- Data for Name: device_lists_remote_pending; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.device_lists_remote_pending (stream_id, user_id, device_id) FROM stdin;
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
2	@matterbot:localhost	OLBOZIJMVW
3	@admin:localhost	SKYCUHVNIF
7	@admin:localhost	9Favlbyv41Oymu7psEi73Z78IgREtdjB3x7X333+GCc
8	@admin:localhost	SKb4WrefUUeHJMqsPB41qypT5nbR4gIz7rM2zpp77QQ
9	@admin:localhost	MCWQGRUWJV
10	@mm_admin:localhost	CQIRMKNFTR
\.


--
-- Data for Name: devices; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.devices (user_id, device_id, display_name, last_seen, ip, user_agent, hidden) FROM stdin;
@matterbot:localhost	OLBOZIJMVW	\N	\N	\N	\N	f
@admin:localhost	SKYCUHVNIF	\N	\N	\N	\N	f
@admin:localhost	9Favlbyv41Oymu7psEi73Z78IgREtdjB3x7X333+GCc	master signing key	\N	\N	\N	t
@admin:localhost	SKb4WrefUUeHJMqsPB41qypT5nbR4gIz7rM2zpp77QQ	self_signing signing key	\N	\N	\N	t
@admin:localhost	vmvfo59xzOjKmX7eTKaUauAKaUMTqr5oZimh0Tsm5Ww	user_signing signing key	\N	\N	\N	t
@admin:localhost	MCWQGRUWJV	localhost:8080: Chrome on macOS	1675289375046	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36	f
@mm_admin:localhost	CQIRMKNFTR	\N	\N	\N	\N	f
\.


--
-- Data for Name: e2e_cross_signing_keys; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_cross_signing_keys (user_id, keytype, keydata, stream_id) FROM stdin;
@admin:localhost	master	{"user_id":"@admin:localhost","usage":["master"],"keys":{"ed25519:9Favlbyv41Oymu7psEi73Z78IgREtdjB3x7X333+GCc":"9Favlbyv41Oymu7psEi73Z78IgREtdjB3x7X333+GCc"},"signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"+AIaMRp47RqQVG8cjzPonIXJE9Lap0DgATzEldFKzZ0bBg/RvUCQWUN1yi9JadL4AjLhsioItNJorDdLK5ZtCw"}}}	2
@admin:localhost	self_signing	{"user_id":"@admin:localhost","usage":["self_signing"],"keys":{"ed25519:SKb4WrefUUeHJMqsPB41qypT5nbR4gIz7rM2zpp77QQ":"SKb4WrefUUeHJMqsPB41qypT5nbR4gIz7rM2zpp77QQ"},"signatures":{"@admin:localhost":{"ed25519:9Favlbyv41Oymu7psEi73Z78IgREtdjB3x7X333+GCc":"CPfwqSgCqjlRddGeMfp+xXef/aNL89q7MUxFiW88yqY8NMEgcqmAl5kALmo7wbiAbgeehw5qw4XkOdVSryg1Bw"}}}	3
@admin:localhost	user_signing	{"user_id":"@admin:localhost","usage":["user_signing"],"keys":{"ed25519:vmvfo59xzOjKmX7eTKaUauAKaUMTqr5oZimh0Tsm5Ww":"vmvfo59xzOjKmX7eTKaUauAKaUMTqr5oZimh0Tsm5Ww"},"signatures":{"@admin:localhost":{"ed25519:9Favlbyv41Oymu7psEi73Z78IgREtdjB3x7X333+GCc":"eN8GO27s5/Q1LH17jHzTqSM6Cz8gHIJ+OxpeTswKoaOckpG0pxP2ZPQd9eknBiBTsCPMB3RKOPjwgGUjCsBLDQ"}}}	4
\.


--
-- Data for Name: e2e_cross_signing_signatures; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_cross_signing_signatures (user_id, key_id, target_user_id, target_device_id, signature) FROM stdin;
@admin:localhost	ed25519:SKb4WrefUUeHJMqsPB41qypT5nbR4gIz7rM2zpp77QQ	@admin:localhost	MCWQGRUWJV	yEpCjldTE4CeZIknGoXGRecTTsTWxkpftTyHyq7xuT3EzxHz6VVd/9DDDp+jA+mHA5GqwF5ARMwxifKDpD3zCQ
\.


--
-- Data for Name: e2e_device_keys_json; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_device_keys_json (user_id, device_id, ts_added_ms, key_json) FROM stdin;
@admin:localhost	MCWQGRUWJV	1675287440399	{"algorithms":["m.olm.v1.curve25519-aes-sha2","m.megolm.v1.aes-sha2"],"device_id":"MCWQGRUWJV","keys":{"curve25519:MCWQGRUWJV":"uOt+7lTrgFtzcreO5r+ciAg3gGNgkI+qgcn1eeN8Aic","ed25519:MCWQGRUWJV":"pvdYWTAlPhvpfQ1IYVUT6hjltGsEffXkMHXeaOk+xiM"},"signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"9iM/y75zK9C6zdOdMTksw+/EcZEUUEXMT7mW34ABGQelvhlDG1Iu6j6Qp01SGk2HKTJLkV3u6B4ABROrcyfHBQ"}},"user_id":"@admin:localhost"}
\.


--
-- Data for Name: e2e_fallback_keys_json; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_fallback_keys_json (user_id, device_id, algorithm, key_id, key_json, used) FROM stdin;
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAADA	{"key":"e0f1/4qUPW+oF3oJmTF0NqmKxDTIJF2xrEy3P907eFE","fallback":true,"signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"cR4MVQO7EFSellYAf8Buz0r6s31n3KLs87V3bgoiKcE8SvBV5IXEqBVzFs+R5Cnrd5Ys8DBdzKvSyP8XQIYtAw"}}}	f
\.


--
-- Data for Name: e2e_one_time_keys_json; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_one_time_keys_json (user_id, device_id, algorithm, key_id, ts_added_ms, key_json) FROM stdin;
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAABQ	1675287440823	{"key":"6u6v8L5AT2NP7sQ0daYxxk5LuFblNGb5MW0Jz8Rl108","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"zhnuRTFJO9SXHkv4Z4OC/kiUcHFA89XMVptfA2ioKhc86QReqOyQG/tOpOvCcY+kPpdH8fR1GZRU/5V1a+m+Ag"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAABA	1675287440823	{"key":"PJZaj/CfjM2xgY2OXVBm7XcQF8wAnVMUTlIdCVryaCQ","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"u+Tf3vTd9PVBQK6/KxU2YiaCf/5/NV7ice9SvC7mK1Vk4GueNeeTYGVgIpTyerTvIDLguPV2SfdbMPpdo7imCg"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAAw	1675287440823	{"key":"+xNa1ucamA5rjUse08uyC8GQimrsZujIMb1FOgehnBk","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"ZvKH9l2jNf+p9X5Qk92oULT1Icn92a6+plUiP6A6Tz8zIfydJ/GvB6mLh4hV9tuPwa6UX2aBG+SEOgsxXfXrCA"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAAg	1675287440823	{"key":"4coyx6Bj0K3LhyW1aqLDqVJmX5s7hMMwWpWNPntuyAA","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"5ZFjZgQOzvyM4Y0xqIqEfSKH9wv7HyI2+0t3bZPSa0CuJ1PjN4mE1fwFeOZi4gh77diWYgdPBrOCCts7TRYnDA"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAAQ	1675287440823	{"key":"PNb/4w6P1LyyttYHp6pA6D98qqtuZnysuX7VjaWbG0k","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"iNtQIlb8y1F27FN+PS/wwhgo9ThlwgGqXw8GAjnaQeZCFbSOBHFHGQ2VzyJ8pJH4zqDW9uZkMYufqw55nasMBw"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAACw	1675287440938	{"key":"QC6t+Ic+HnJfV02EISCDHJEU2xc+4Dn2b1R9RtpemjI","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"3ZG/FtCxOJVYwS7uhHa4AErK1deIgZHnOrEYUJzXiAXZ2nkU0V5BL+AnQ9BXS9pyPQksBOstz/A7iCKGRvAPAw"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAACg	1675287440938	{"key":"52Lay3II3gmBaFhzUJrChfTZESIWL3T45pqo4BIEBx8","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"dNs9CXZzjsbz+yN2p9V9HRPsvQWOpnPO+YZnpWepmvd3rYyi/1sqgTdBjo4DF3F3VKTSlqTRWS1ZOrwrVGfIAg"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAACQ	1675287440938	{"key":"YZpS+FUOXFWg5Xq0rom4VnExT95N8q7TEJgWWS7lbDU","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"XJg1sinXQtwLAQfnFDHhG3oyTMX589WAonOLgPC7/IYO00Pzgx0VLNWxqjPFaOIuEIcZmhVoCPG4EFZCNLa3Cg"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAACA	1675287440938	{"key":"9K/7cHu1NWFMn4z9IX986rPHuqv7JPUA469M4xXGQEU","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"OcGkpjiaT94jCMlECjEs20uKt7xM1O0O4VsdblneSUVyBSbJtukgnqAEiNU/68XZiiE2j7d+7vTghwwJEAVxDA"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAABw	1675287440938	{"key":"1gq/AncDhs3BWC7LS+iH7c5DJuF5GysFMj/5/voPEWo","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"h6t9zllQnSQJ9FkCVn+tJi8g31QIoYP6O7IjKz2ADqcLFKHmVVZG0Of6a2APN0cAXNkOgT40hhR5BXq3x0qUDg"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAEQ	1675287441012	{"key":"sFEVV8v21gO89NQEaotLeb3/0fl666JgdWCCoFSbNBU","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"cWsAjeuiTT0PuHDC29P+5CPKpl49fc4nFUyogB0v3Kq/oo2JtsbtkjSroT5vS4yOIhzJYADKTXs945MeniFTAg"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAEA	1675287441012	{"key":"/goOcClcvKkOMq93RxvgNo50/43GMnbF7HTjK6rlshc","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"oMiMNnh0E0SpdgWBhYsKq2OMZBL08gTXdBG7WVdHFhKcnMUAExHge1EqZbnxPNjbiLIzfzZ9ShZIeiYUR3DVBw"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAADw	1675287441012	{"key":"BV12a+cATS4RbUA9dpEa+zGvJteuqSLn2/0vmFmnHS0","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"uhKdVhx4vMCuW3VWZUxxs0BsXqCZeRTqXOxfBctLo9Mt20Qb8iVoBUyHo2sMjqlFL9ptm8OOd0vr3gAP+qaiDQ"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAADg	1675287441012	{"key":"ubqakJWUWLrLNVYLhnNmCR3w3Y0r5EFW5OlypZ1QJHA","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"joAarOgJG/y2BAG5N747DxBMDlIbgvOsmnia6IRcGEmxNzbUzlXZsz++iIZJ+mH9F1H99ENkE7esej2bIlTsDQ"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAADQ	1675287441012	{"key":"U90o/py7cQWGOsEO3QRNuUwuxKksihZoHROV377O32o","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"1uteQ5MoZ/XOuqPSEE5tDxt9Fn9OZEcggbsdUJUMkfiurY7D7zABBz5q5fRpNQ88xc4SlAggKMZVMTUHGxpcCA"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAFg	1675287441074	{"key":"ocezA3z66HhBTD3bAfi8mjnTzNGk7y2L9yZu6EFqcnQ","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"VTmQnRTvmYphzbBibRiUKYZKWf2dnyCd0pRETtOcrOOAwei6utA+s1c2zZyS0HQpGP6kRlVG1Vx8sE1GHZ7YBA"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAFQ	1675287441074	{"key":"lShpe/KIu5xcLddvcFlrET+81HHuPvs+haY1CnYzXBg","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"AwJnxGzqmw4Elwu4jYxI0KM+/BAowj2vhopVKpN9P1JyCNMaBbNyxHWKZ8zZT0Yih0PsB0QgqHd9n6v97ylGAA"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAFA	1675287441074	{"key":"9rX2urXHATpHDfCk4vF0BtmeeYcS+k+IpLJDgfowiSM","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"nOggo95SPd8WBAjrfsJWXMKSyDcYy2D7ndgn4UGjvPBqqpe0zTT5H51cXN027wfQMFNRV+TGmsA1o3PHbCGTCQ"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAEw	1675287441074	{"key":"70CfgKnbP7x4etIPuvmTlD6er5peCsGa1ZvhDP2Y62k","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"JNFXkiSn7snC1S7Uejc8cctV6VXHNiyNTuI6R/GP4EG6o8C3LBvUa/zLiYNblvML4yLfSurJfnphcHN6zDjmAg"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAEg	1675287441074	{"key":"WQs3bZ0jf13az7lf5WUEa3+lVQomXuQraEn66B6pNm8","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"tAhNJAo8j1L3HBoYeEZKtKJyn41150XY26dvLNXJsiQrNEcujR4wNFvRE5xXFKsamhSKCLv8LMKigVIJQelfDQ"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAGw	1675287441133	{"key":"qqa1qwfotRIfLoJV4zmQc9Kuset7nMKkbz0lNNZ+Ex8","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"5PI9SbKeDa/LfN8+3+vcwEqaIdTu+va/PFBdVVtY+dwfTUPPDiAaPqu7wSEZ8VNO9bAfRnPWfMEnlAM/UHV8Bg"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAGg	1675287441133	{"key":"9tWKPIR+nIE2HKoFfG2R6t7aFCSUF8EEVuKHUiCPEi8","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"boKb48+YbZZtDejGxslUKEJBk65WW9jdvYfITMY0PYSBsJ2Xqw8QNAHJRPp62+MRs7ByMEb+ecmMQMlDBxCtBA"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAGQ	1675287441133	{"key":"jkmNwo5rdR8TUmotdTGNEV5HQMWp/kOYT9BJNkFwAgU","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"mtLarwQ5EqQ4MppyYpQQx8jA5zVdcYuw2S9OArCvAiZ0FfIi34WAyTG2L70KKYBqNbtMo+XznAauVMSnoy38Aw"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAGA	1675287441133	{"key":"YvMJEpBqXvFHNFdVqV6ple8uILtOlDg8lsbNbFubIGs","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"WsBfwW2U4uvyj0RmDH0DlIwB3rbtPz5KZyqKrfIWvFbK0iLs1IU1exzZLhCRWgFEzJg38UplCI/QPBI9EzfIDw"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAFw	1675287441133	{"key":"PWGGGqTYTs187YYA3lEfwDv0xD7f+hcoSNG2ZEZoLhM","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"t2+mf5RA3yZWePWHR2CCV/d6wz1NlLtoG8Ei84aK4LGpFHnWORQiLrpMUHv9nVMIIUnBLQgY8QhEMfrFm4WIAQ"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAIA	1675287441197	{"key":"73Oocc/4v+VlPGjjSI9FJQ+TNjK08BHOU4MkkkjwKBw","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"88cW9vgwZzIbTeCzu4AF4vzPfjJfAl35jJytFtvv17xBRS2ItZdgpSasLaVx1MDgHqWYLNouHrqS9q0x2JciDA"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAHw	1675287441197	{"key":"92bzqfNKz5olHUu/uL3hLykGBUHXBqyEk8YBKVG1LDs","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"zjMy2eRodh1q8zAi8Ck9p4E5qOzJIHUST4Zd79Tq5BEYgphuFyNHfcwEmBVXRIjzfP5D9z3+Bn+ai8WXA076AQ"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAHg	1675287441197	{"key":"g/KboWNCPLxMyzpsgR64RXEzcDEfMZa251R4x04jME0","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"KGWqvfzzKYJ9PlOuYLykOokCi/b7rPHydsVGlgk2iV/NqqdbcomUGuddf3EyShFdSzPOulOoRhm/KaqWMbudCA"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAHQ	1675287441197	{"key":"whVKbuzFrmNEwsk73GK538bWgAvGNIV98G6OZYm3NjA","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"iyFMFJWjhltv871jfmqkM/CGbPUMRXD0VQwX80ZuqT4AKgM6IB3pEKPHwWdvFT9zYt7r5e9Ey2GRld/WpEfKDg"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAHA	1675287441197	{"key":"L3wpmi9YskyXdjQgGrELiROsyT6DgHit1ZPF19Gdwjg","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"sMEl35zBYgHM6TnNCrx7T5ox+88IGwL9hmcTmI/LErfUhZNogRGSqcY0F2I/T1AhBDc5T8cBlXeKbKVyudbOCw"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAJQ	1675287441255	{"key":"bE6qn5ZrMt3wfOe2aX6yN1mgv40QYtdKZPLitLPE33Q","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"E8OtfzluS8vYZlNQS8zR4YF7jM+msXwYVgXRQXNwy5rAnVqEn6x8dD5yVBpQh5GZADcO3vgto0JGi3zQXkPfDw"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAJA	1675287441255	{"key":"1qq9Tpg815HnRArv0viYopeAg3Me4g1MMk7u6IFmKBA","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"NSLazF2hzAD3CQac6hZWshCYp7hhRUZXQRuQ14jcsi5HlcPT9DB1mqpMzqKxfoNfoZbmzAXl1AQ0wnuPth8YCw"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAIw	1675287441255	{"key":"8jkqHGcEp8yKz1gdKfY1wYAA+skKudKd/B1ezKJab38","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"ktUCybxzup52/uDms1GnhulC9j5HaqE3Etum9/yDL0eSkUdfIj3P1cTeCH67Zq5GDt9cHqL2qBZeEY731CjtCw"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAIg	1675287441255	{"key":"VeYW/0c5GJzxq7snah3/CfKaKczKp9khGSFLPL9sxSE","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"J3hZm8Co2Ob87PG8EE5OAnNkcY+dzFgEK3C6+eDSFFX1JadHXh/heAKaYJibJTxLEAEhTeMorMG/pKC1OXShBA"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAIQ	1675287441255	{"key":"2fYh7wqAHDPcVE4PULv3aVTbEiODRug9SRh1gyzR3y0","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"b4vcBHjkEaLdMi6empIr2696LM+XdZXM0MXz3a7MDst5pme8wAHySS6kdZ8rTyzHozT2C96VaQoTH54QU51mDQ"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAKg	1675287441327	{"key":"AY6ebkjM/yNgMFKHYLCb7eOOO8WfRQdtK/aY4UNkFzo","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"MOvTls0Uw3VdjPLYDstoslns9BOTMn2ZZboem3BF9VZrs/K1hrmAiHflhAPWa0gZFF26TUgl56TE7h85vVBEAA"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAKQ	1675287441327	{"key":"iB5ZST79GDgkUaM+/7sCfL2zfABDbfc1t6FcyMBppFk","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"a39Xv4o5JzKr8HfEu+YmIR5p51mrgyi4Q6M9AfmeALpxsfFZ5vsowmozmHpPRGjEkH4ayB6nd2YWhKDaIXVuCA"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAKA	1675287441327	{"key":"E3CYQ7ZZXcD1p1wsJsuHn5BKKiVKAeQlKmBMPfZ0d1M","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"J1C471s1abi6OApoI/+qKbVwfVaHivFLDKaTb7E5cRnTNCmMLsK2ynx9rwjqPoo188ECZ6gZpxkXcapcejCuDA"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAJw	1675287441327	{"key":"7TYKjvGGMtNhkUp+SB43F9uBaBY+s9PRxnMrZvvpD0M","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"IaiUN5TMr2Ovzohg+I3ICHYn0q48+dcxq546XGlEkwRMPt/3hILkOBluWw9iLyzeZpMpksMQsDkDP1UgrEajAg"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAJg	1675287441327	{"key":"DjDogMsJKWE068E5YQNGQqCH3+vc6yL8gdrz8JZIu1Y","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"r5dGSI541fW3kJ7xeXdhX/sTC0U8pxrbZdbOg3NTjNtkF0MwPxTDPzXATfYJkdaN0SsOxC201+iSqXbQVCFxBg"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAALw	1675287441407	{"key":"V614EDq7QpM+HPRDluqH6qIwfT69PUlhtPiqPwo+2jo","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"vMZACuMKWhqQO62H+seTvmcjHANOEB8WbM6QRtZSOaDTIVyzQV3TfpjgnBnbNWYk7oHCsWrn0vSaGxJx6u1/Bg"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAALg	1675287441407	{"key":"ugRgrtz7kY/I904dZcViGdH3EGP6T+5fHwPI8iWWUSE","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"IJ6ayIac9UK22c75g69NmlZwWl3mkuVsOThZQgfn+wL5mjVIBDHmjJZ+tl2T24R1WRoK3RrlOb0Ze98F0V/oDw"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAALQ	1675287441407	{"key":"YJ8u18MmVtIUpax25n/+AjV6x+RRx0tfv3qbza6YxyU","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"T6FGwl51mowiJcjmPPMd0AJYH/6fTSVowq6F33zLMXGeDY0Zeu7FOrVlyfuqxg0ALKHpDn//VhSfpvdGf9u8BA"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAALA	1675287441407	{"key":"f5Ca1gQRbYp1admqRYplZDHGruNl8LeDivFdi9qb9Tg","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"gY5uMMq0W/hLqbZiSMoO1j8jfjO39chptAcOkQaB96W2nhucDBIWb0XJ4Kcs+qMSwqckCxmzDCR8jS8Uini+Bg"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAKw	1675287441407	{"key":"NhuWyd1OV0uITTeelrC4vUDe325pJzG0AqRmfBL6IVk","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"CCxfEayx+JI7C4Rg3Vze9iIWXgVgug4xacsbLG22gW1PKTqsrGvNJ8PE3caG9OYQlOu6k2ZDiRoTu7ByCvuoCQ"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAANA	1675287441561	{"key":"Qymn/2C7U3haWvOMK30lbBDlHZgFLAtBM4Ec9VqUBgQ","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"IAVzjahjzL3iqikkShdRLN4G8zx18Q4Tuy+fM6cX9CrLSgLVjAnmZDef7KVJID1ybPqEU2BoS+7b/R2+dk9uBg"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAMw	1675287441561	{"key":"9y2xHMYTfDGipIDaRiSrsA8QRzIZthFvQ9TyPk82KC4","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"pniGAJ5YcSgwvkrGqebHVJtDmrLUFSEJN/I8kC9unf8WoE32dKKze1WpUYBWm0QfO0JMP8UDRMib4jgS/sG4Dw"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAMg	1675287441561	{"key":"yzFeOX6Y4Y+F+qfL8LmCSFDNESkZh3WeOoEYrVrizlc","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"GgBHFuUOe3n+OdERQR3541XrZrQqgwV9kBjEzsaQcGVOkAWHDkkygRoWcKguT+uqA808HeFT1wpcrQhRvaXPAg"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAMQ	1675287441561	{"key":"Gad+MPpqdGdXtVCc5rO9vIQMN56EMtmfa/WDWJxaQyQ","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"zRtSVjnXOiBSDqEBACIinlrnhnxZ5NnsWkQjFVMcYPlCg7q9mlkDy8ICDiUq2naInXzEZcdkB/F+E+ZkyimaDQ"}}}
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAAMA	1675287441561	{"key":"1cPDxVM/YDTQ2ibL0TimRWuQwaDT6MQfBv2Tlf8NJ20","signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"RcdLS/UTAc/H5bceLN6/I6qnrlIJq+Za3qf7HCM+b3naLohT/mraBRkLRu+ceIyW8l6mVPI+5jB/QoXjCl+oCw"}}}
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
$UaZuzLfnyOIw3iLU39I6ihmpGMjzRB3mDd4pkHT22Jo	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$cPQw7bnJzfkKROnFKbANhreS_L7eznZtJH4RClxd71s	$UaZuzLfnyOIw3iLU39I6ihmpGMjzRB3mDd4pkHT22Jo	!DaecDLDoTLOuqPWadN:localhost
$cPQw7bnJzfkKROnFKbANhreS_L7eznZtJH4RClxd71s	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$StretV_bUYoe4zZLM8qe8KW0l5M_C1Ik6aSZVQxi8rg	$UaZuzLfnyOIw3iLU39I6ihmpGMjzRB3mDd4pkHT22Jo	!DaecDLDoTLOuqPWadN:localhost
$StretV_bUYoe4zZLM8qe8KW0l5M_C1Ik6aSZVQxi8rg	$cPQw7bnJzfkKROnFKbANhreS_L7eznZtJH4RClxd71s	!DaecDLDoTLOuqPWadN:localhost
$StretV_bUYoe4zZLM8qe8KW0l5M_C1Ik6aSZVQxi8rg	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	$UaZuzLfnyOIw3iLU39I6ihmpGMjzRB3mDd4pkHT22Jo	!DaecDLDoTLOuqPWadN:localhost
$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	$cPQw7bnJzfkKROnFKbANhreS_L7eznZtJH4RClxd71s	!DaecDLDoTLOuqPWadN:localhost
$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$M1L18DSD9p1dUaGXmyktgOAaNvLS1cAXM3CfIMT15LE	$UaZuzLfnyOIw3iLU39I6ihmpGMjzRB3mDd4pkHT22Jo	!DaecDLDoTLOuqPWadN:localhost
$M1L18DSD9p1dUaGXmyktgOAaNvLS1cAXM3CfIMT15LE	$cPQw7bnJzfkKROnFKbANhreS_L7eznZtJH4RClxd71s	!DaecDLDoTLOuqPWadN:localhost
$M1L18DSD9p1dUaGXmyktgOAaNvLS1cAXM3CfIMT15LE	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$kQauQY6TyYK4PeP16G5HJI6i9oybAY_CtRu56inmyEk	$UaZuzLfnyOIw3iLU39I6ihmpGMjzRB3mDd4pkHT22Jo	!DaecDLDoTLOuqPWadN:localhost
$kQauQY6TyYK4PeP16G5HJI6i9oybAY_CtRu56inmyEk	$cPQw7bnJzfkKROnFKbANhreS_L7eznZtJH4RClxd71s	!DaecDLDoTLOuqPWadN:localhost
$kQauQY6TyYK4PeP16G5HJI6i9oybAY_CtRu56inmyEk	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$HpReuVvJCIb4gFAA0V1ZLkXuAYpbGbYJ9xTxIowp0iA	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$DoaPAQf-ky_qYpibXlB13gxRmHsYdEJTQRCskrRSxrI	$HpReuVvJCIb4gFAA0V1ZLkXuAYpbGbYJ9xTxIowp0iA	!YmJPedFXUiFFGzTnFq:localhost
$DoaPAQf-ky_qYpibXlB13gxRmHsYdEJTQRCskrRSxrI	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$hGkMaf8X0yAqBrPj1PikKCF5r3g0CD5sbqK_0vYDI3s	$HpReuVvJCIb4gFAA0V1ZLkXuAYpbGbYJ9xTxIowp0iA	!YmJPedFXUiFFGzTnFq:localhost
$hGkMaf8X0yAqBrPj1PikKCF5r3g0CD5sbqK_0vYDI3s	$DoaPAQf-ky_qYpibXlB13gxRmHsYdEJTQRCskrRSxrI	!YmJPedFXUiFFGzTnFq:localhost
$hGkMaf8X0yAqBrPj1PikKCF5r3g0CD5sbqK_0vYDI3s	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	$HpReuVvJCIb4gFAA0V1ZLkXuAYpbGbYJ9xTxIowp0iA	!YmJPedFXUiFFGzTnFq:localhost
$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	$DoaPAQf-ky_qYpibXlB13gxRmHsYdEJTQRCskrRSxrI	!YmJPedFXUiFFGzTnFq:localhost
$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$Ln0DFzhDHk3ZBOxf3CqyszFxBgR-vLuaU6XMGfFiMBY	$HpReuVvJCIb4gFAA0V1ZLkXuAYpbGbYJ9xTxIowp0iA	!YmJPedFXUiFFGzTnFq:localhost
$Ln0DFzhDHk3ZBOxf3CqyszFxBgR-vLuaU6XMGfFiMBY	$DoaPAQf-ky_qYpibXlB13gxRmHsYdEJTQRCskrRSxrI	!YmJPedFXUiFFGzTnFq:localhost
$Ln0DFzhDHk3ZBOxf3CqyszFxBgR-vLuaU6XMGfFiMBY	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$aR_Ehub6nY87EKeuOUobM8EqspDDVswweVVJLsgPe9M	$HpReuVvJCIb4gFAA0V1ZLkXuAYpbGbYJ9xTxIowp0iA	!YmJPedFXUiFFGzTnFq:localhost
$aR_Ehub6nY87EKeuOUobM8EqspDDVswweVVJLsgPe9M	$DoaPAQf-ky_qYpibXlB13gxRmHsYdEJTQRCskrRSxrI	!YmJPedFXUiFFGzTnFq:localhost
$aR_Ehub6nY87EKeuOUobM8EqspDDVswweVVJLsgPe9M	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost
$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4	$cPQw7bnJzfkKROnFKbANhreS_L7eznZtJH4RClxd71s	!DaecDLDoTLOuqPWadN:localhost
$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc	$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	!YmJPedFXUiFFGzTnFq:localhost
$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc	$DoaPAQf-ky_qYpibXlB13gxRmHsYdEJTQRCskrRSxrI	!YmJPedFXUiFFGzTnFq:localhost
$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$3iRjuPdSa2RM8LZ_hEUz2rpxW7wRYwAMtjldk4L3x2o	$HpReuVvJCIb4gFAA0V1ZLkXuAYpbGbYJ9xTxIowp0iA	!YmJPedFXUiFFGzTnFq:localhost
$3iRjuPdSa2RM8LZ_hEUz2rpxW7wRYwAMtjldk4L3x2o	$DoaPAQf-ky_qYpibXlB13gxRmHsYdEJTQRCskrRSxrI	!YmJPedFXUiFFGzTnFq:localhost
$3iRjuPdSa2RM8LZ_hEUz2rpxW7wRYwAMtjldk4L3x2o	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	$HpReuVvJCIb4gFAA0V1ZLkXuAYpbGbYJ9xTxIowp0iA	!YmJPedFXUiFFGzTnFq:localhost
$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	$3iRjuPdSa2RM8LZ_hEUz2rpxW7wRYwAMtjldk4L3x2o	!YmJPedFXUiFFGzTnFq:localhost
$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	$UaZuzLfnyOIw3iLU39I6ihmpGMjzRB3mDd4pkHT22Jo	!DaecDLDoTLOuqPWadN:localhost
$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	$cPQw7bnJzfkKROnFKbANhreS_L7eznZtJH4RClxd71s	!DaecDLDoTLOuqPWadN:localhost
$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$CqTXYvkWmU1WEVsryzPffrK-UFPsAp9ZN7hNFMzRdcU	$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc	!YmJPedFXUiFFGzTnFq:localhost
$CqTXYvkWmU1WEVsryzPffrK-UFPsAp9ZN7hNFMzRdcU	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$CqTXYvkWmU1WEVsryzPffrK-UFPsAp9ZN7hNFMzRdcU	$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	!YmJPedFXUiFFGzTnFq:localhost
$CqTXYvkWmU1WEVsryzPffrK-UFPsAp9ZN7hNFMzRdcU	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$M7i7kIr_313-fsK6zIJjyPUvcArWEnDYRpGwuz1z5zY	$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4	!DaecDLDoTLOuqPWadN:localhost
$M7i7kIr_313-fsK6zIJjyPUvcArWEnDYRpGwuz1z5zY	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$M7i7kIr_313-fsK6zIJjyPUvcArWEnDYRpGwuz1z5zY	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost
$M7i7kIr_313-fsK6zIJjyPUvcArWEnDYRpGwuz1z5zY	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$e59i0svd92559O6Ylspucl1xefsa8dpbbZe0ZE0mUp4	$M7i7kIr_313-fsK6zIJjyPUvcArWEnDYRpGwuz1z5zY	!DaecDLDoTLOuqPWadN:localhost
$e59i0svd92559O6Ylspucl1xefsa8dpbbZe0ZE0mUp4	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost
$e59i0svd92559O6Ylspucl1xefsa8dpbbZe0ZE0mUp4	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$e59i0svd92559O6Ylspucl1xefsa8dpbbZe0ZE0mUp4	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$6Lgivd2MHjS9x-3BOttMrBNfnyKpvrsbwS8TFPVdz1c	$CqTXYvkWmU1WEVsryzPffrK-UFPsAp9ZN7hNFMzRdcU	!YmJPedFXUiFFGzTnFq:localhost
$6Lgivd2MHjS9x-3BOttMrBNfnyKpvrsbwS8TFPVdz1c	$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	!YmJPedFXUiFFGzTnFq:localhost
$6Lgivd2MHjS9x-3BOttMrBNfnyKpvrsbwS8TFPVdz1c	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$6Lgivd2MHjS9x-3BOttMrBNfnyKpvrsbwS8TFPVdz1c	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
\.


--
-- Data for Name: event_auth_chain_links; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_auth_chain_links (origin_chain_id, origin_sequence_number, target_chain_id, target_sequence_number) FROM stdin;
2	1	1	1
5	1	6	1
5	1	1	1
4	1	2	1
3	1	1	1
5	1	2	1
4	1	6	1
4	1	1	1
3	1	6	1
3	1	2	1
6	1	1	1
6	1	2	1
7	1	6	1
7	1	1	1
7	1	2	1
9	1	8	1
10	1	9	1
12	1	9	1
12	1	13	1
12	1	8	1
10	1	8	1
11	1	13	1
11	1	8	1
11	1	9	1
13	1	9	1
13	1	8	1
10	1	13	1
14	1	13	1
14	1	8	1
14	1	9	1
15	1	6	1
15	1	1	1
15	1	4	1
15	1	2	1
16	1	8	1
16	1	13	1
16	1	11	1
16	1	9	1
17	1	16	1
17	1	13	3
17	1	8	1
17	1	11	1
17	1	13	3
17	1	9	1
18	1	4	1
18	1	2	1
18	1	6	2
18	1	1	1
18	1	15	1
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
$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	1	1
$UaZuzLfnyOIw3iLU39I6ihmpGMjzRB3mDd4pkHT22Jo	2	1
$cPQw7bnJzfkKROnFKbANhreS_L7eznZtJH4RClxd71s	6	1
$M1L18DSD9p1dUaGXmyktgOAaNvLS1cAXM3CfIMT15LE	3	1
$StretV_bUYoe4zZLM8qe8KW0l5M_C1Ik6aSZVQxi8rg	5	1
$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	4	1
$kQauQY6TyYK4PeP16G5HJI6i9oybAY_CtRu56inmyEk	7	1
$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	8	1
$HpReuVvJCIb4gFAA0V1ZLkXuAYpbGbYJ9xTxIowp0iA	9	1
$DoaPAQf-ky_qYpibXlB13gxRmHsYdEJTQRCskrRSxrI	13	1
$Ln0DFzhDHk3ZBOxf3CqyszFxBgR-vLuaU6XMGfFiMBY	10	1
$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	11	1
$hGkMaf8X0yAqBrPj1PikKCF5r3g0CD5sbqK_0vYDI3s	12	1
$aR_Ehub6nY87EKeuOUobM8EqspDDVswweVVJLsgPe9M	14	1
$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4	15	1
$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc	16	1
$3iRjuPdSa2RM8LZ_hEUz2rpxW7wRYwAMtjldk4L3x2o	13	2
$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	13	3
$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	6	2
$CqTXYvkWmU1WEVsryzPffrK-UFPsAp9ZN7hNFMzRdcU	17	1
$M7i7kIr_313-fsK6zIJjyPUvcArWEnDYRpGwuz1z5zY	18	1
$e59i0svd92559O6Ylspucl1xefsa8dpbbZe0ZE0mUp4	18	2
$6Lgivd2MHjS9x-3BOttMrBNfnyKpvrsbwS8TFPVdz1c	17	2
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
$UaZuzLfnyOIw3iLU39I6ihmpGMjzRB3mDd4pkHT22Jo	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	\N	f
$cPQw7bnJzfkKROnFKbANhreS_L7eznZtJH4RClxd71s	$UaZuzLfnyOIw3iLU39I6ihmpGMjzRB3mDd4pkHT22Jo	\N	f
$StretV_bUYoe4zZLM8qe8KW0l5M_C1Ik6aSZVQxi8rg	$cPQw7bnJzfkKROnFKbANhreS_L7eznZtJH4RClxd71s	\N	f
$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	$StretV_bUYoe4zZLM8qe8KW0l5M_C1Ik6aSZVQxi8rg	\N	f
$M1L18DSD9p1dUaGXmyktgOAaNvLS1cAXM3CfIMT15LE	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	\N	f
$kQauQY6TyYK4PeP16G5HJI6i9oybAY_CtRu56inmyEk	$M1L18DSD9p1dUaGXmyktgOAaNvLS1cAXM3CfIMT15LE	\N	f
$HpReuVvJCIb4gFAA0V1ZLkXuAYpbGbYJ9xTxIowp0iA	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	\N	f
$DoaPAQf-ky_qYpibXlB13gxRmHsYdEJTQRCskrRSxrI	$HpReuVvJCIb4gFAA0V1ZLkXuAYpbGbYJ9xTxIowp0iA	\N	f
$hGkMaf8X0yAqBrPj1PikKCF5r3g0CD5sbqK_0vYDI3s	$DoaPAQf-ky_qYpibXlB13gxRmHsYdEJTQRCskrRSxrI	\N	f
$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	$hGkMaf8X0yAqBrPj1PikKCF5r3g0CD5sbqK_0vYDI3s	\N	f
$Ln0DFzhDHk3ZBOxf3CqyszFxBgR-vLuaU6XMGfFiMBY	$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	\N	f
$aR_Ehub6nY87EKeuOUobM8EqspDDVswweVVJLsgPe9M	$Ln0DFzhDHk3ZBOxf3CqyszFxBgR-vLuaU6XMGfFiMBY	\N	f
$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4	$kQauQY6TyYK4PeP16G5HJI6i9oybAY_CtRu56inmyEk	\N	f
$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc	$aR_Ehub6nY87EKeuOUobM8EqspDDVswweVVJLsgPe9M	\N	f
$3iRjuPdSa2RM8LZ_hEUz2rpxW7wRYwAMtjldk4L3x2o	$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc	\N	f
$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	$3iRjuPdSa2RM8LZ_hEUz2rpxW7wRYwAMtjldk4L3x2o	\N	f
$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4	\N	f
$CqTXYvkWmU1WEVsryzPffrK-UFPsAp9ZN7hNFMzRdcU	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	\N	f
$M7i7kIr_313-fsK6zIJjyPUvcArWEnDYRpGwuz1z5zY	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	\N	f
$e59i0svd92559O6Ylspucl1xefsa8dpbbZe0ZE0mUp4	$M7i7kIr_313-fsK6zIJjyPUvcArWEnDYRpGwuz1z5zY	\N	f
$6Lgivd2MHjS9x-3BOttMrBNfnyKpvrsbwS8TFPVdz1c	$CqTXYvkWmU1WEVsryzPffrK-UFPsAp9ZN7hNFMzRdcU	\N	f
\.


--
-- Data for Name: event_expiry; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_expiry (event_id, expiry_ts) FROM stdin;
\.


--
-- Data for Name: event_failed_pull_attempts; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_failed_pull_attempts (room_id, event_id, num_attempts, last_attempt_ts, last_cause) FROM stdin;
\.


--
-- Data for Name: event_forward_extremities; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_forward_extremities (event_id, room_id) FROM stdin;
$e59i0svd92559O6Ylspucl1xefsa8dpbbZe0ZE0mUp4	!DaecDLDoTLOuqPWadN:localhost
$6Lgivd2MHjS9x-3BOttMrBNfnyKpvrsbwS8TFPVdz1c	!YmJPedFXUiFFGzTnFq:localhost
\.


--
-- Data for Name: event_json; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_json (event_id, room_id, internal_metadata, json, format_version) FROM stdin;
$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost	{"token_id":4,"historical":false}	{"auth_events":[],"prev_events":[],"type":"m.room.create","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@admin:localhost","content":{"room_version":"9","creator":"@admin:localhost"},"depth":1,"state_key":"","origin":"localhost","origin_server_ts":1675287622927,"hashes":{"sha256":"tnxNv9nG7MHb56XaLBtSwM+5nG7yudUgwVMamLWFR6k"},"signatures":{"localhost":{"ed25519:a_vyji":"tFIuCY3mG56BdgeeE/KTIfOYj+cPrBi9K24yV2OCv1CKy2bXgLgKKQ2vyoWDS6Le2602Z7Z4c/PzHH8DERHQAQ"}},"unsigned":{"age_ts":1675287622927}}	3
$UaZuzLfnyOIw3iLU39I6ihmpGMjzRB3mDd4pkHT22Jo	!DaecDLDoTLOuqPWadN:localhost	{"token_id":4,"historical":false}	{"auth_events":["$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg"],"prev_events":["$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@admin:localhost","content":{"membership":"join","displayname":"admin"},"depth":2,"state_key":"@admin:localhost","origin":"localhost","origin_server_ts":1675287623093,"hashes":{"sha256":"Q/i9kQW6eR2DTLpRJK4TPOU+TSbdGJVxGq5k/alar7g"},"signatures":{"localhost":{"ed25519:a_vyji":"N4OiPHBFFFOmnueVLQEwm3kIx4sDJmf8ZOv2hdPbQD/IBq7191CjKzB9wCPiWhDvycfhF/MFF9YQzUJcHgXPCw"}},"unsigned":{"age_ts":1675287623093}}	3
$cPQw7bnJzfkKROnFKbANhreS_L7eznZtJH4RClxd71s	!DaecDLDoTLOuqPWadN:localhost	{"token_id":4,"historical":false}	{"auth_events":["$UaZuzLfnyOIw3iLU39I6ihmpGMjzRB3mDd4pkHT22Jo","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg"],"prev_events":["$UaZuzLfnyOIw3iLU39I6ihmpGMjzRB3mDd4pkHT22Jo"],"type":"m.room.power_levels","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@admin:localhost","content":{"users":{"@admin:localhost":100},"users_default":0,"events":{"m.room.name":50,"m.room.power_levels":100,"m.room.history_visibility":100,"m.room.canonical_alias":50,"m.room.avatar":50,"m.room.tombstone":100,"m.room.server_acl":100,"m.room.encryption":100},"events_default":0,"state_default":50,"ban":50,"kick":50,"redact":50,"invite":50,"historical":100},"depth":3,"state_key":"","origin":"localhost","origin_server_ts":1675287623279,"hashes":{"sha256":"NLar7kzfDxYfEgg5D9IJBYgOqBm+Yl6uy6D30MoTfaI"},"signatures":{"localhost":{"ed25519:a_vyji":"Ca7W214cI5pRsNSoiywpBLuEzLV2C1wqCGimKL6Sl97z2o7kn5b4dPtXsRqyREr8/KDXEylxrh/jy9YYr/SdDg"}},"unsigned":{"age_ts":1675287623279}}	3
$StretV_bUYoe4zZLM8qe8KW0l5M_C1Ik6aSZVQxi8rg	!DaecDLDoTLOuqPWadN:localhost	{"token_id":4,"historical":false}	{"auth_events":["$UaZuzLfnyOIw3iLU39I6ihmpGMjzRB3mDd4pkHT22Jo","$cPQw7bnJzfkKROnFKbANhreS_L7eznZtJH4RClxd71s","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg"],"prev_events":["$cPQw7bnJzfkKROnFKbANhreS_L7eznZtJH4RClxd71s"],"type":"m.room.canonical_alias","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@admin:localhost","content":{"alias":"#off-topic:localhost"},"depth":4,"state_key":"","origin":"localhost","origin_server_ts":1675287623314,"hashes":{"sha256":"32DjrefUL0KHlyxW+3QqbKUwbwMLy0k9mCMUqKb+mHU"},"signatures":{"localhost":{"ed25519:a_vyji":"UGvh90s0Wr8vtaFzPhFI14dfKATzhsX+b1cuqJo2xtisj/lsZ3DxQLWp/aCO8WzbQMj6X+tZO9TN0qFwPwjJBA"}},"unsigned":{"age_ts":1675287623314}}	3
$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost	{"token_id":4,"historical":false}	{"auth_events":["$UaZuzLfnyOIw3iLU39I6ihmpGMjzRB3mDd4pkHT22Jo","$cPQw7bnJzfkKROnFKbANhreS_L7eznZtJH4RClxd71s","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg"],"prev_events":["$StretV_bUYoe4zZLM8qe8KW0l5M_C1Ik6aSZVQxi8rg"],"type":"m.room.join_rules","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@admin:localhost","content":{"join_rule":"public"},"depth":5,"state_key":"","origin":"localhost","origin_server_ts":1675287623324,"hashes":{"sha256":"nPH8HSobdy/qFaZytGO3LlWimMEmkTQI5o1b8GJh5CU"},"signatures":{"localhost":{"ed25519:a_vyji":"P/CGHnpIGASOLIhX7tS3iDRs8sQKzboO24QeU2GhgDrh3JO5t+dlU4rf8a3hn6fwXwKai4TvbL6mqqG6lVu0Cg"}},"unsigned":{"age_ts":1675287623324}}	3
$M1L18DSD9p1dUaGXmyktgOAaNvLS1cAXM3CfIMT15LE	!DaecDLDoTLOuqPWadN:localhost	{"token_id":4,"historical":false}	{"auth_events":["$UaZuzLfnyOIw3iLU39I6ihmpGMjzRB3mDd4pkHT22Jo","$cPQw7bnJzfkKROnFKbANhreS_L7eznZtJH4RClxd71s","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg"],"prev_events":["$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY"],"type":"m.room.history_visibility","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@admin:localhost","content":{"history_visibility":"shared"},"depth":6,"state_key":"","origin":"localhost","origin_server_ts":1675287623333,"hashes":{"sha256":"H8KvLYi2GIZmvoAd3jD5Nu1wCradf7VWLmjvzGKQJjU"},"signatures":{"localhost":{"ed25519:a_vyji":"HExMw30Uxc27HgHlMiNqdw/ORK9fm67CuWEYKXR9tJ7IV3gkXP+Whl2ryt5LFzTDgW0n4a7NCjQoS1q2IOUmAw"}},"unsigned":{"age_ts":1675287623333}}	3
$kQauQY6TyYK4PeP16G5HJI6i9oybAY_CtRu56inmyEk	!DaecDLDoTLOuqPWadN:localhost	{"token_id":4,"historical":false}	{"auth_events":["$UaZuzLfnyOIw3iLU39I6ihmpGMjzRB3mDd4pkHT22Jo","$cPQw7bnJzfkKROnFKbANhreS_L7eznZtJH4RClxd71s","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg"],"prev_events":["$M1L18DSD9p1dUaGXmyktgOAaNvLS1cAXM3CfIMT15LE"],"type":"m.room.name","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@admin:localhost","content":{"name":"#off-topic"},"depth":7,"state_key":"","origin":"localhost","origin_server_ts":1675287623684,"hashes":{"sha256":"Kvy+oSLdEzCiRoim7ucf0srJ20Z7uMRzeldt9kesjho"},"signatures":{"localhost":{"ed25519:a_vyji":"Jr03Ht0RojmBytlYdEZoDmunupPUwf18Mrho0HdBPFbOsPRQkUQjlbz604O34cFvJG1MruZseur9gKhDQDlADg"}},"unsigned":{"age_ts":1675287623684}}	3
$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost	{"token_id":4,"historical":false}	{"auth_events":[],"prev_events":[],"type":"m.room.create","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@admin:localhost","content":{"room_version":"9","creator":"@admin:localhost"},"depth":1,"state_key":"","origin":"localhost","origin_server_ts":1675287779253,"hashes":{"sha256":"iDQWr3t4VMT/q7tRtZ0y0KdQSMswtBqUJEW5EAk+C4Y"},"signatures":{"localhost":{"ed25519:a_vyji":"h8GNtHVykg8qnU/Bm+NdSn4QP8Ocokv+t4JQOoIf9jfUwr8mdk+92QDeKkWiG//prPb8jd0l4eiQ1+GcYQ4FAw"}},"unsigned":{"age_ts":1675287779253}}	3
$HpReuVvJCIb4gFAA0V1ZLkXuAYpbGbYJ9xTxIowp0iA	!YmJPedFXUiFFGzTnFq:localhost	{"token_id":4,"historical":false}	{"auth_events":["$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM"],"prev_events":["$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@admin:localhost","content":{"membership":"join","displayname":"admin"},"depth":2,"state_key":"@admin:localhost","origin":"localhost","origin_server_ts":1675287779385,"hashes":{"sha256":"8QcdkUbqAMccfYjrTsDWw10Dy2z3LQCDhJ5/SKQrwac"},"signatures":{"localhost":{"ed25519:a_vyji":"WYb0CYCg/FsYBtZCJgq/My5/+R18wnDetIdnqn2VslxzoPqmhv0j7lozKLYjjD4i0vvJzeiDe+W7GIuh6Iz2Cw"}},"unsigned":{"age_ts":1675287779385}}	3
$aR_Ehub6nY87EKeuOUobM8EqspDDVswweVVJLsgPe9M	!YmJPedFXUiFFGzTnFq:localhost	{"token_id":4,"historical":false}	{"auth_events":["$HpReuVvJCIb4gFAA0V1ZLkXuAYpbGbYJ9xTxIowp0iA","$DoaPAQf-ky_qYpibXlB13gxRmHsYdEJTQRCskrRSxrI","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM"],"prev_events":["$Ln0DFzhDHk3ZBOxf3CqyszFxBgR-vLuaU6XMGfFiMBY"],"type":"m.room.name","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@admin:localhost","content":{"name":"#town-square"},"depth":7,"state_key":"","origin":"localhost","origin_server_ts":1675287780161,"hashes":{"sha256":"3oDflGZmVVxXQwkpZgXWb6jFxqF+xGEJYzdV6uWjSFE"},"signatures":{"localhost":{"ed25519:a_vyji":"Vaq/bajoL0kcRYquDP4VtLCbzQGoKYQvebaVxIWEEl9TGVYW/wqEsYB/yo1SWapa4IJY722On7MrEHlB0mjTDg"}},"unsigned":{"age_ts":1675287780161}}	3
$DoaPAQf-ky_qYpibXlB13gxRmHsYdEJTQRCskrRSxrI	!YmJPedFXUiFFGzTnFq:localhost	{"token_id":4,"historical":false}	{"auth_events":["$HpReuVvJCIb4gFAA0V1ZLkXuAYpbGbYJ9xTxIowp0iA","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM"],"prev_events":["$HpReuVvJCIb4gFAA0V1ZLkXuAYpbGbYJ9xTxIowp0iA"],"type":"m.room.power_levels","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@admin:localhost","content":{"users":{"@admin:localhost":100},"users_default":0,"events":{"m.room.name":50,"m.room.power_levels":100,"m.room.history_visibility":100,"m.room.canonical_alias":50,"m.room.avatar":50,"m.room.tombstone":100,"m.room.server_acl":100,"m.room.encryption":100},"events_default":0,"state_default":50,"ban":50,"kick":50,"redact":50,"invite":50,"historical":100},"depth":3,"state_key":"","origin":"localhost","origin_server_ts":1675287779648,"hashes":{"sha256":"2IvXWBbAvzB61d6Hqnucg0hMVRga72Q8v3O8P0pJLLg"},"signatures":{"localhost":{"ed25519:a_vyji":"SABCwI6+ZobzSz/RrLO7vaOfHTL5bqPWt5pnmG5vwk11M+nGYkYJ8Mq3EVjrvNRTxv2baiRP08lAAOwORTWDDQ"}},"unsigned":{"age_ts":1675287779648}}	3
$hGkMaf8X0yAqBrPj1PikKCF5r3g0CD5sbqK_0vYDI3s	!YmJPedFXUiFFGzTnFq:localhost	{"token_id":4,"historical":false}	{"auth_events":["$HpReuVvJCIb4gFAA0V1ZLkXuAYpbGbYJ9xTxIowp0iA","$DoaPAQf-ky_qYpibXlB13gxRmHsYdEJTQRCskrRSxrI","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM"],"prev_events":["$DoaPAQf-ky_qYpibXlB13gxRmHsYdEJTQRCskrRSxrI"],"type":"m.room.canonical_alias","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@admin:localhost","content":{"alias":"#town-square:localhost"},"depth":4,"state_key":"","origin":"localhost","origin_server_ts":1675287779723,"hashes":{"sha256":"ZDCPW5cMXGw9sNmmAOTnfiWXGhXheya/e4JOr+2itVs"},"signatures":{"localhost":{"ed25519:a_vyji":"fdC8yZpL25OFXqyj71IK9cvJw+qYdH1yO3x9DaMd+Kpz/N2DnZCnUChoaHmRRA43XbjE6hKgeFCA9VGfc58AAA"}},"unsigned":{"age_ts":1675287779723}}	3
$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	!YmJPedFXUiFFGzTnFq:localhost	{"token_id":4,"historical":false}	{"auth_events":["$HpReuVvJCIb4gFAA0V1ZLkXuAYpbGbYJ9xTxIowp0iA","$DoaPAQf-ky_qYpibXlB13gxRmHsYdEJTQRCskrRSxrI","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM"],"prev_events":["$hGkMaf8X0yAqBrPj1PikKCF5r3g0CD5sbqK_0vYDI3s"],"type":"m.room.join_rules","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@admin:localhost","content":{"join_rule":"public"},"depth":5,"state_key":"","origin":"localhost","origin_server_ts":1675287779741,"hashes":{"sha256":"F1rOrLgqnjGxbRGReA/pKuTTgunc2KkeQczUXgQ+1aA"},"signatures":{"localhost":{"ed25519:a_vyji":"mHtWtPb+eI7KYfEBSr3Q0ExCbD/fOQEy3vNTtuUalH7ReqX8zlEAPSiybUFiH2CLuTsXeOF/uXlfxOnTopL6Dw"}},"unsigned":{"age_ts":1675287779741}}	3
$Ln0DFzhDHk3ZBOxf3CqyszFxBgR-vLuaU6XMGfFiMBY	!YmJPedFXUiFFGzTnFq:localhost	{"token_id":4,"historical":false}	{"auth_events":["$HpReuVvJCIb4gFAA0V1ZLkXuAYpbGbYJ9xTxIowp0iA","$DoaPAQf-ky_qYpibXlB13gxRmHsYdEJTQRCskrRSxrI","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM"],"prev_events":["$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM"],"type":"m.room.history_visibility","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@admin:localhost","content":{"history_visibility":"shared"},"depth":6,"state_key":"","origin":"localhost","origin_server_ts":1675287779755,"hashes":{"sha256":"qf8TZsiC094vcm4s3hzXTNncg4LP0cCV3fUIWVj45Fw"},"signatures":{"localhost":{"ed25519:a_vyji":"Neie28H1HeVUL3+2HGYNXuSJlbP8VYDdLGiBpKHs3ROMcQGBpfw1z5B6zCqTaO3Jom0ZtNfilDoDKHeEstZBCg"}},"unsigned":{"age_ts":1675287779755}}	3
$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY","$cPQw7bnJzfkKROnFKbANhreS_L7eznZtJH4RClxd71s","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg"],"prev_events":["$kQauQY6TyYK4PeP16G5HJI6i9oybAY_CtRu56inmyEk"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"depth":8,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675287995866,"hashes":{"sha256":"JyuHlojj96KQaMA/oXDf9qJbHEzH2TUiDCnI/7R3wgU"},"signatures":{"localhost":{"ed25519:a_vyji":"HbVodWjJE9ZqQn4Gh5a4lrPemubBjmi62yw+K/eoChv7an7B+p78ozi+XICXtjy3yvT0zUz46cPvDZH+V5QnCA"}},"unsigned":{"age_ts":1675287995866}}	3
$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM","$DoaPAQf-ky_qYpibXlB13gxRmHsYdEJTQRCskrRSxrI","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM"],"prev_events":["$aR_Ehub6nY87EKeuOUobM8EqspDDVswweVVJLsgPe9M"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"depth":8,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675287995872,"hashes":{"sha256":"9Q0AgZTHuR3t8/O1DAvUV4G49zGrZkTSPmMWag8zBa8"},"signatures":{"localhost":{"ed25519:a_vyji":"rqDHDlNK7QMg87SdQ/jESV2rBbfqoh25+6ZQ27Z31rXXdLp5zK1/NbVNovb0QtwLHtK2ocCW2q0hprRe/yGHAQ"}},"unsigned":{"age_ts":1675287995872}}	3
$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost	{"token_id":4,"historical":false}	{"auth_events":["$HpReuVvJCIb4gFAA0V1ZLkXuAYpbGbYJ9xTxIowp0iA","$3iRjuPdSa2RM8LZ_hEUz2rpxW7wRYwAMtjldk4L3x2o","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM"],"prev_events":["$3iRjuPdSa2RM8LZ_hEUz2rpxW7wRYwAMtjldk4L3x2o"],"type":"m.room.power_levels","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@admin:localhost","content":{"users":{"@admin:localhost":100,"@matterbot:localhost":100},"users_default":0,"events":{"m.room.name":50,"m.room.power_levels":100,"m.room.history_visibility":100,"m.room.canonical_alias":50,"m.room.avatar":50,"m.room.tombstone":100,"m.room.server_acl":100,"m.room.encryption":100,"m.space.child":50,"m.room.topic":50,"m.room.pinned_events":50,"m.reaction":0,"m.room.redaction":0,"org.matrix.msc3401.call":50,"org.matrix.msc3401.call.member":50,"im.vector.modular.widgets":50,"io.element.voice_broadcast_info":50},"events_default":0,"state_default":50,"ban":50,"kick":50,"redact":50,"invite":50,"historical":100},"depth":10,"state_key":"","origin":"localhost","origin_server_ts":1675288846498,"hashes":{"sha256":"5IVj4nPZEk6NgJAT4wn2QxDQPHC0ajVeceR+diRpobY"},"signatures":{"localhost":{"ed25519:a_vyji":"OIOkpcCjYO2JMZWyKeeeQVmeWw/MNKcElJhMJzpdY9pC0E5vpbm5z/vMJQzHK0IRwT76/v8EPoDFUQkO/anqDw"}},"unsigned":{"age_ts":1675288846498,"replaces_state":"$3iRjuPdSa2RM8LZ_hEUz2rpxW7wRYwAMtjldk4L3x2o"}}	3
$3iRjuPdSa2RM8LZ_hEUz2rpxW7wRYwAMtjldk4L3x2o	!YmJPedFXUiFFGzTnFq:localhost	{"token_id":4,"historical":false}	{"auth_events":["$HpReuVvJCIb4gFAA0V1ZLkXuAYpbGbYJ9xTxIowp0iA","$DoaPAQf-ky_qYpibXlB13gxRmHsYdEJTQRCskrRSxrI","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM"],"prev_events":["$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc"],"type":"m.room.power_levels","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@admin:localhost","content":{"users":{"@admin:localhost":100,"@matterbot:localhost":0},"users_default":0,"events":{"m.room.name":50,"m.room.power_levels":100,"m.room.history_visibility":100,"m.room.canonical_alias":50,"m.room.avatar":50,"m.room.tombstone":100,"m.room.server_acl":100,"m.room.encryption":100,"m.space.child":50,"m.room.topic":50,"m.room.pinned_events":50,"m.reaction":0,"m.room.redaction":0,"org.matrix.msc3401.call":50,"org.matrix.msc3401.call.member":50,"im.vector.modular.widgets":50,"io.element.voice_broadcast_info":50},"events_default":0,"state_default":50,"ban":50,"kick":50,"redact":50,"invite":50,"historical":100},"depth":9,"state_key":"","origin":"localhost","origin_server_ts":1675288813725,"hashes":{"sha256":"JhvK4VzURw7/zfWj+Typllkddi2QjGR8FGcRHkMjkeE"},"signatures":{"localhost":{"ed25519:a_vyji":"2qxelJAcmSDnoHB0MMz45WGARuJDn42R1Dx4Nfqa13dVReIU8vfqW/5/cuhcPoYWAYL8GykitQJBMk2+2rygCA"}},"unsigned":{"age_ts":1675288813725,"replaces_state":"$DoaPAQf-ky_qYpibXlB13gxRmHsYdEJTQRCskrRSxrI"}}	3
$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost	{"token_id":4,"historical":false}	{"auth_events":["$UaZuzLfnyOIw3iLU39I6ihmpGMjzRB3mDd4pkHT22Jo","$cPQw7bnJzfkKROnFKbANhreS_L7eznZtJH4RClxd71s","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg"],"prev_events":["$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4"],"type":"m.room.power_levels","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@admin:localhost","content":{"users":{"@admin:localhost":100,"@matterbot:localhost":100},"users_default":0,"events":{"m.room.name":50,"m.room.power_levels":100,"m.room.history_visibility":100,"m.room.canonical_alias":50,"m.room.avatar":50,"m.room.tombstone":100,"m.room.server_acl":100,"m.room.encryption":100,"m.space.child":50,"m.room.topic":50,"m.room.pinned_events":50,"m.reaction":0,"m.room.redaction":0,"org.matrix.msc3401.call":50,"org.matrix.msc3401.call.member":50,"im.vector.modular.widgets":50,"io.element.voice_broadcast_info":50},"events_default":0,"state_default":50,"ban":50,"kick":50,"redact":50,"invite":50,"historical":100},"depth":9,"state_key":"","origin":"localhost","origin_server_ts":1675288889095,"hashes":{"sha256":"LoaPHUwCvCfim9YGY4N3VzvTYp20knBTqNNa2cIgezY"},"signatures":{"localhost":{"ed25519:a_vyji":"naBVO8l6eQOgCjyuDeGbtmw5odi0k+5p08jK6QDeaUsUH2ZBlS6+9eBu2/YdK+4FOGDJ9L2gXJN03+SRQn03CQ"}},"unsigned":{"age_ts":1675288889095,"replaces_state":"$cPQw7bnJzfkKROnFKbANhreS_L7eznZtJH4RClxd71s"}}	3
$CqTXYvkWmU1WEVsryzPffrK-UFPsAp9ZN7hNFMzRdcU	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc","$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM"],"prev_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"admin [mm]"},"depth":11,"state_key":"@mm_admin:localhost","origin":"localhost","origin_server_ts":1675288909796,"hashes":{"sha256":"DpWxTm9cMA8m+EwYhpy/NLbhrfMR6LsF+/+i/B1HmI4"},"signatures":{"localhost":{"ed25519:a_vyji":"xEKMoH78Y3srW89d9B6XZ4wTp8xuv9XZx7g7tUqtiohsqOabIx6uSAK9OOiviffw0qQVGyhGNTGnKZSx5C0EBA"}},"unsigned":{"age_ts":1675288909796,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#town-square:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"9","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.name","state_key":"","content":{"name":"#town-square"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$e59i0svd92559O6Ylspucl1xefsa8dpbbZe0ZE0mUp4	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$M7i7kIr_313-fsK6zIJjyPUvcArWEnDYRpGwuz1z5zY","$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY","$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg"],"prev_events":["$M7i7kIr_313-fsK6zIJjyPUvcArWEnDYRpGwuz1z5zY"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@mm_admin:localhost","content":{"membership":"join","displayname":"admin [mm]"},"depth":11,"state_key":"@mm_admin:localhost","origin":"localhost","origin_server_ts":1675288910073,"hashes":{"sha256":"7sC6lZDmjkv9iDTtJMQBg2Sv3RLgwM3ZZapJfNYyqAA"},"signatures":{"localhost":{"ed25519:a_vyji":"vYSUWoqaGq0uPVftSVqpB3oKGqAdSU4bMX7XpRpdhXhVF7PMC8IL5+1QS5l6Bug/XTlwYEPICGq6cfoQlbp6Dw"}},"unsigned":{"age_ts":1675288910073,"replaces_state":"$M7i7kIr_313-fsK6zIJjyPUvcArWEnDYRpGwuz1z5zY"}}	3
$M7i7kIr_313-fsK6zIJjyPUvcArWEnDYRpGwuz1z5zY	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4","$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg"],"prev_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"admin [mm]"},"depth":10,"state_key":"@mm_admin:localhost","origin":"localhost","origin_server_ts":1675288909840,"hashes":{"sha256":"whNPEG7yS+tUS6+12r6Urq21x1t87WIMmzdoSae6QaE"},"signatures":{"localhost":{"ed25519:a_vyji":"hozjIZMGADWOHzkyPKxrEm+eTTdZqEmt5y5iVB/hP8HM/skkZrBx0VK47E3Y3nyjtLgPQDigza/o8+nlz4vSDg"}},"unsigned":{"age_ts":1675288909840,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#off-topic:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"9","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.name","state_key":"","content":{"name":"#off-topic"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$6Lgivd2MHjS9x-3BOttMrBNfnyKpvrsbwS8TFPVdz1c	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$CqTXYvkWmU1WEVsryzPffrK-UFPsAp9ZN7hNFMzRdcU","$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM","$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM"],"prev_events":["$CqTXYvkWmU1WEVsryzPffrK-UFPsAp9ZN7hNFMzRdcU"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@mm_admin:localhost","content":{"membership":"join","displayname":"admin [mm]"},"depth":12,"state_key":"@mm_admin:localhost","origin":"localhost","origin_server_ts":1675288910076,"hashes":{"sha256":"3Ps0/weBCjQ7yfw1usg7PNHmd8g8/QyCXHh76T8JoJo"},"signatures":{"localhost":{"ed25519:a_vyji":"nv+XsQ7fiOlAl5i5FT9ijR1ANgk5+R4fkOw93K93gIkZynpnY0PsAxSk5PcEFPi7A+EEz9ABVjKSVGKd9NUkBA"}},"unsigned":{"age_ts":1675288910076,"replaces_state":"$CqTXYvkWmU1WEVsryzPffrK-UFPsAp9ZN7hNFMzRdcU"}}	3
\.


--
-- Data for Name: event_labels; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_labels (event_id, label, room_id, topological_ordering) FROM stdin;
\.


--
-- Data for Name: event_push_actions; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_push_actions (room_id, event_id, user_id, profile_tag, actions, topological_ordering, stream_ordering, notif, highlight, unread, thread_id) FROM stdin;
!YmJPedFXUiFFGzTnFq:localhost	$CqTXYvkWmU1WEVsryzPffrK-UFPsAp9ZN7hNFMzRdcU	@mm_admin:localhost	\N	["notify",{"set_tweak":"highlight","value":false},{"set_tweak":"sound","value":"default"}]	11	21	1	0	0	main
!DaecDLDoTLOuqPWadN:localhost	$M7i7kIr_313-fsK6zIJjyPUvcArWEnDYRpGwuz1z5zY	@mm_admin:localhost	\N	["notify",{"set_tweak":"highlight","value":false},{"set_tweak":"sound","value":"default"}]	10	22	1	0	0	main
\.


--
-- Data for Name: event_push_actions_staging; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_push_actions_staging (event_id, user_id, actions, notif, highlight, unread, thread_id, inserted_ts) FROM stdin;
\.


--
-- Data for Name: event_push_summary; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_push_summary (user_id, room_id, notif_count, stream_ordering, unread_count, last_receipt_stream_ordering, thread_id) FROM stdin;
@mm_admin:localhost	!DaecDLDoTLOuqPWadN:localhost	1	22	0	\N	main
@mm_admin:localhost	!YmJPedFXUiFFGzTnFq:localhost	1	21	0	\N	main
\.


--
-- Data for Name: event_push_summary_last_receipt_stream_id; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_push_summary_last_receipt_stream_id (lock, stream_id) FROM stdin;
X	5
\.


--
-- Data for Name: event_push_summary_stream_ordering; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_push_summary_stream_ordering (lock, stream_ordering) FROM stdin;
X	24
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
$kQauQY6TyYK4PeP16G5HJI6i9oybAY_CtRu56inmyEk	!DaecDLDoTLOuqPWadN:localhost	\N	content.name	'off-top':1 'topic':3	1675287623684	8
$aR_Ehub6nY87EKeuOUobM8EqspDDVswweVVJLsgPe9M	!YmJPedFXUiFFGzTnFq:localhost	\N	content.name	'squar':3 'town':2 'town-squar':1	1675287780161	15
\.


--
-- Data for Name: event_to_state_groups; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_to_state_groups (event_id, state_group) FROM stdin;
$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	2
$UaZuzLfnyOIw3iLU39I6ihmpGMjzRB3mDd4pkHT22Jo	3
$cPQw7bnJzfkKROnFKbANhreS_L7eznZtJH4RClxd71s	4
$StretV_bUYoe4zZLM8qe8KW0l5M_C1Ik6aSZVQxi8rg	5
$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	6
$M1L18DSD9p1dUaGXmyktgOAaNvLS1cAXM3CfIMT15LE	7
$kQauQY6TyYK4PeP16G5HJI6i9oybAY_CtRu56inmyEk	8
$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	10
$HpReuVvJCIb4gFAA0V1ZLkXuAYpbGbYJ9xTxIowp0iA	11
$DoaPAQf-ky_qYpibXlB13gxRmHsYdEJTQRCskrRSxrI	12
$hGkMaf8X0yAqBrPj1PikKCF5r3g0CD5sbqK_0vYDI3s	13
$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	14
$Ln0DFzhDHk3ZBOxf3CqyszFxBgR-vLuaU6XMGfFiMBY	15
$aR_Ehub6nY87EKeuOUobM8EqspDDVswweVVJLsgPe9M	16
$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4	17
$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc	18
$3iRjuPdSa2RM8LZ_hEUz2rpxW7wRYwAMtjldk4L3x2o	21
$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	22
$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	23
$CqTXYvkWmU1WEVsryzPffrK-UFPsAp9ZN7hNFMzRdcU	26
$M7i7kIr_313-fsK6zIJjyPUvcArWEnDYRpGwuz1z5zY	27
$e59i0svd92559O6Ylspucl1xefsa8dpbbZe0ZE0mUp4	28
$6Lgivd2MHjS9x-3BOttMrBNfnyKpvrsbwS8TFPVdz1c	29
\.


--
-- Data for Name: event_txn_id; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_txn_id (event_id, room_id, user_id, token_id, txn_id, inserted_ts) FROM stdin;
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.events (topological_ordering, event_id, type, room_id, content, unrecognized_keys, processed, outlier, depth, origin_server_ts, received_ts, sender, contains_url, instance_name, stream_ordering, state_key, rejection_reason) FROM stdin;
1	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	m.room.create	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	1	1675287622927	1675287622985	@admin:localhost	f	master	2		\N
2	$UaZuzLfnyOIw3iLU39I6ihmpGMjzRB3mDd4pkHT22Jo	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	2	1675287623093	1675287623136	@admin:localhost	f	master	3	@admin:localhost	\N
3	$cPQw7bnJzfkKROnFKbANhreS_L7eznZtJH4RClxd71s	m.room.power_levels	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	3	1675287623279	1675287623601	@admin:localhost	f	master	4		\N
4	$StretV_bUYoe4zZLM8qe8KW0l5M_C1Ik6aSZVQxi8rg	m.room.canonical_alias	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	4	1675287623314	1675287623601	@admin:localhost	f	master	5		\N
5	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	m.room.join_rules	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	5	1675287623324	1675287623601	@admin:localhost	f	master	6		\N
6	$M1L18DSD9p1dUaGXmyktgOAaNvLS1cAXM3CfIMT15LE	m.room.history_visibility	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	6	1675287623333	1675287623601	@admin:localhost	f	master	7		\N
7	$kQauQY6TyYK4PeP16G5HJI6i9oybAY_CtRu56inmyEk	m.room.name	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	7	1675287623684	1675287623823	@admin:localhost	f	master	8		\N
1	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	m.room.create	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	1	1675287779253	1675287779302	@admin:localhost	f	master	9		\N
2	$HpReuVvJCIb4gFAA0V1ZLkXuAYpbGbYJ9xTxIowp0iA	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	2	1675287779385	1675287779518	@admin:localhost	f	master	10	@admin:localhost	\N
3	$DoaPAQf-ky_qYpibXlB13gxRmHsYdEJTQRCskrRSxrI	m.room.power_levels	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	3	1675287779648	1675287780018	@admin:localhost	f	master	11		\N
4	$hGkMaf8X0yAqBrPj1PikKCF5r3g0CD5sbqK_0vYDI3s	m.room.canonical_alias	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	4	1675287779723	1675287780018	@admin:localhost	f	master	12		\N
5	$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	m.room.join_rules	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	5	1675287779741	1675287780018	@admin:localhost	f	master	13		\N
6	$Ln0DFzhDHk3ZBOxf3CqyszFxBgR-vLuaU6XMGfFiMBY	m.room.history_visibility	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	6	1675287779755	1675287780018	@admin:localhost	f	master	14		\N
7	$aR_Ehub6nY87EKeuOUobM8EqspDDVswweVVJLsgPe9M	m.room.name	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	7	1675287780161	1675287780269	@admin:localhost	f	master	15		\N
8	$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	8	1675287995866	1675287995906	@matterbot:localhost	f	master	16	@matterbot:localhost	\N
8	$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	8	1675287995872	1675287995910	@matterbot:localhost	f	master	17	@matterbot:localhost	\N
9	$3iRjuPdSa2RM8LZ_hEUz2rpxW7wRYwAMtjldk4L3x2o	m.room.power_levels	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	9	1675288813725	1675288813825	@admin:localhost	f	master	18		\N
10	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	m.room.power_levels	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	10	1675288846498	1675288846552	@admin:localhost	f	master	19		\N
9	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	m.room.power_levels	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	9	1675288889095	1675288889161	@admin:localhost	f	master	20		\N
11	$CqTXYvkWmU1WEVsryzPffrK-UFPsAp9ZN7hNFMzRdcU	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	11	1675288909796	1675288909878	@matterbot:localhost	f	master	21	@mm_admin:localhost	\N
10	$M7i7kIr_313-fsK6zIJjyPUvcArWEnDYRpGwuz1z5zY	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	10	1675288909840	1675288909888	@matterbot:localhost	f	master	22	@mm_admin:localhost	\N
11	$e59i0svd92559O6Ylspucl1xefsa8dpbbZe0ZE0mUp4	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	11	1675288910073	1675288910145	@mm_admin:localhost	f	master	23	@mm_admin:localhost	\N
12	$6Lgivd2MHjS9x-3BOttMrBNfnyKpvrsbwS8TFPVdz1c	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	12	1675288910076	1675288910172	@mm_admin:localhost	f	master	24	@mm_admin:localhost	\N
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
events	24	master
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
!DaecDLDoTLOuqPWadN:localhost	@admin:localhost	$UaZuzLfnyOIw3iLU39I6ihmpGMjzRB3mDd4pkHT22Jo	join
!YmJPedFXUiFFGzTnFq:localhost	@admin:localhost	$HpReuVvJCIb4gFAA0V1ZLkXuAYpbGbYJ9xTxIowp0iA	join
!DaecDLDoTLOuqPWadN:localhost	@matterbot:localhost	$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4	join
!YmJPedFXUiFFGzTnFq:localhost	@matterbot:localhost	$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc	join
!DaecDLDoTLOuqPWadN:localhost	@mm_admin:localhost	$e59i0svd92559O6Ylspucl1xefsa8dpbbZe0ZE0mUp4	join
!YmJPedFXUiFFGzTnFq:localhost	@mm_admin:localhost	$6Lgivd2MHjS9x-3BOttMrBNfnyKpvrsbwS8TFPVdz1c	join
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
-- Data for Name: login_tokens; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.login_tokens (token, user_id, expiry_ts, used_ts, auth_provider_id, auth_provider_session_id) FROM stdin;
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
-- Data for Name: partial_state_events; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.partial_state_events (room_id, event_id) FROM stdin;
\.


--
-- Data for Name: partial_state_rooms; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.partial_state_rooms (room_id, device_lists_stream_id, join_event_id, joined_via) FROM stdin;
\.


--
-- Data for Name: partial_state_rooms_servers; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.partial_state_rooms_servers (room_id, server_name) FROM stdin;
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
41	@admin:localhost	online	1675289375046	1675289074219	1675289375047	\N	t	master
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.profiles (user_id, displayname, avatar_url) FROM stdin;
matterbot	Mattermost Bridge	\N
admin	admin	\N
mm_admin	admin [mm]	\N
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

COPY public.pushers (id, user_name, access_token, profile_tag, kind, app_id, app_display_name, device_display_name, pushkey, ts, lang, data, last_stream_ordering, last_success, failing_since, enabled, device_id) FROM stdin;
\.


--
-- Data for Name: ratelimit_override; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.ratelimit_override (user_id, messages_per_second, burst_count) FROM stdin;
\.


--
-- Data for Name: receipts_graph; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.receipts_graph (room_id, receipt_type, user_id, event_ids, data, thread_id) FROM stdin;
!DaecDLDoTLOuqPWadN:localhost	m.read.private	@admin:localhost	["$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4"]	{"ts":1675288208461}	\N
!DaecDLDoTLOuqPWadN:localhost	m.read	@admin:localhost	["$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4"]	{"ts":1675288208478}	\N
!YmJPedFXUiFFGzTnFq:localhost	m.read.private	@admin:localhost	["$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc"]	{"ts":1675288273900}	\N
!YmJPedFXUiFFGzTnFq:localhost	m.read	@admin:localhost	["$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc"]	{"ts":1675288273989}	\N
\.


--
-- Data for Name: receipts_linearized; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.receipts_linearized (stream_id, room_id, receipt_type, user_id, event_id, data, instance_name, event_stream_ordering, thread_id) FROM stdin;
2	!DaecDLDoTLOuqPWadN:localhost	m.read.private	@admin:localhost	$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4	{"ts":1675288208461}	\N	16	\N
3	!DaecDLDoTLOuqPWadN:localhost	m.read	@admin:localhost	$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4	{"ts":1675288208478}	\N	16	\N
4	!YmJPedFXUiFFGzTnFq:localhost	m.read.private	@admin:localhost	$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc	{"ts":1675288273900}	\N	17	\N
5	!YmJPedFXUiFFGzTnFq:localhost	m.read	@admin:localhost	$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc	{"ts":1675288273989}	\N	17	\N
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

COPY public.refresh_tokens (id, user_id, device_id, token, next_token_id, expiry_ts, ultimate_session_expiry_ts) FROM stdin;
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
-- Data for Name: room_account_data; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_account_data (user_id, room_id, account_data_type, stream_id, content, instance_name) FROM stdin;
@admin:localhost	!YmJPedFXUiFFGzTnFq:localhost	m.fully_read	16	{"event_id":"$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok"}	\N
@admin:localhost	!DaecDLDoTLOuqPWadN:localhost	m.fully_read	18	{"event_id":"$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E"}	\N
\.


--
-- Data for Name: room_alias_servers; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_alias_servers (room_alias, server) FROM stdin;
#off-topic:localhost	localhost
#town-square:localhost	localhost
\.


--
-- Data for Name: room_aliases; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_aliases (room_alias, room_id, creator) FROM stdin;
#off-topic:localhost	!DaecDLDoTLOuqPWadN:localhost	@admin:localhost
#town-square:localhost	!YmJPedFXUiFFGzTnFq:localhost	@admin:localhost
\.


--
-- Data for Name: room_depth; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_depth (room_id, min_depth) FROM stdin;
!DaecDLDoTLOuqPWadN:localhost	1
!YmJPedFXUiFFGzTnFq:localhost	1
\.


--
-- Data for Name: room_memberships; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_memberships (event_id, user_id, sender, room_id, membership, forgotten, display_name, avatar_url) FROM stdin;
$UaZuzLfnyOIw3iLU39I6ihmpGMjzRB3mDd4pkHT22Jo	@admin:localhost	@admin:localhost	!DaecDLDoTLOuqPWadN:localhost	join	0	admin	\N
$HpReuVvJCIb4gFAA0V1ZLkXuAYpbGbYJ9xTxIowp0iA	@admin:localhost	@admin:localhost	!YmJPedFXUiFFGzTnFq:localhost	join	0	admin	\N
$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	join	0	Mattermost Bridge	\N
$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	join	0	Mattermost Bridge	\N
$CqTXYvkWmU1WEVsryzPffrK-UFPsAp9ZN7hNFMzRdcU	@mm_admin:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	invite	0	admin [mm]	\N
$M7i7kIr_313-fsK6zIJjyPUvcArWEnDYRpGwuz1z5zY	@mm_admin:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	invite	0	admin [mm]	\N
$e59i0svd92559O6Ylspucl1xefsa8dpbbZe0ZE0mUp4	@mm_admin:localhost	@mm_admin:localhost	!DaecDLDoTLOuqPWadN:localhost	join	0	admin [mm]	\N
$6Lgivd2MHjS9x-3BOttMrBNfnyKpvrsbwS8TFPVdz1c	@mm_admin:localhost	@mm_admin:localhost	!YmJPedFXUiFFGzTnFq:localhost	join	0	admin [mm]	\N
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
!DaecDLDoTLOuqPWadN:localhost	9	3	0	0	0	3	23	0
!YmJPedFXUiFFGzTnFq:localhost	9	3	0	0	0	3	24	0
\.


--
-- Data for Name: room_stats_earliest_token; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_stats_earliest_token (room_id, token) FROM stdin;
\.


--
-- Data for Name: room_stats_state; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_stats_state (room_id, name, canonical_alias, join_rules, history_visibility, encryption, avatar, guest_access, is_federatable, topic, room_type) FROM stdin;
!DaecDLDoTLOuqPWadN:localhost	#off-topic	#off-topic:localhost	public	shared	\N	\N	\N	t	\N	\N
!YmJPedFXUiFFGzTnFq:localhost	#town-square	#town-square:localhost	public	shared	\N	\N	\N	t	\N	\N
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
!DaecDLDoTLOuqPWadN:localhost	t	@admin:localhost	9	t
!YmJPedFXUiFFGzTnFq:localhost	t	@admin:localhost	9	t
\.


--
-- Data for Name: schema_compat_version; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.schema_compat_version (lock, compat_version) FROM stdin;
X	73
\.


--
-- Data for Name: schema_version; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.schema_version (lock, version, upgraded) FROM stdin;
X	73	t
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
$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost	m.room.create		\N
$UaZuzLfnyOIw3iLU39I6ihmpGMjzRB3mDd4pkHT22Jo	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@admin:localhost	\N
$cPQw7bnJzfkKROnFKbANhreS_L7eznZtJH4RClxd71s	!DaecDLDoTLOuqPWadN:localhost	m.room.power_levels		\N
$StretV_bUYoe4zZLM8qe8KW0l5M_C1Ik6aSZVQxi8rg	!DaecDLDoTLOuqPWadN:localhost	m.room.canonical_alias		\N
$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost	m.room.join_rules		\N
$M1L18DSD9p1dUaGXmyktgOAaNvLS1cAXM3CfIMT15LE	!DaecDLDoTLOuqPWadN:localhost	m.room.history_visibility		\N
$kQauQY6TyYK4PeP16G5HJI6i9oybAY_CtRu56inmyEk	!DaecDLDoTLOuqPWadN:localhost	m.room.name		\N
$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost	m.room.create		\N
$HpReuVvJCIb4gFAA0V1ZLkXuAYpbGbYJ9xTxIowp0iA	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@admin:localhost	\N
$DoaPAQf-ky_qYpibXlB13gxRmHsYdEJTQRCskrRSxrI	!YmJPedFXUiFFGzTnFq:localhost	m.room.power_levels		\N
$hGkMaf8X0yAqBrPj1PikKCF5r3g0CD5sbqK_0vYDI3s	!YmJPedFXUiFFGzTnFq:localhost	m.room.canonical_alias		\N
$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	!YmJPedFXUiFFGzTnFq:localhost	m.room.join_rules		\N
$Ln0DFzhDHk3ZBOxf3CqyszFxBgR-vLuaU6XMGfFiMBY	!YmJPedFXUiFFGzTnFq:localhost	m.room.history_visibility		\N
$aR_Ehub6nY87EKeuOUobM8EqspDDVswweVVJLsgPe9M	!YmJPedFXUiFFGzTnFq:localhost	m.room.name		\N
$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$3iRjuPdSa2RM8LZ_hEUz2rpxW7wRYwAMtjldk4L3x2o	!YmJPedFXUiFFGzTnFq:localhost	m.room.power_levels		\N
$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost	m.room.power_levels		\N
$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost	m.room.power_levels		\N
$CqTXYvkWmU1WEVsryzPffrK-UFPsAp9ZN7hNFMzRdcU	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@mm_admin:localhost	\N
$M7i7kIr_313-fsK6zIJjyPUvcArWEnDYRpGwuz1z5zY	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@mm_admin:localhost	\N
$e59i0svd92559O6Ylspucl1xefsa8dpbbZe0ZE0mUp4	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@mm_admin:localhost	\N
$6Lgivd2MHjS9x-3BOttMrBNfnyKpvrsbwS8TFPVdz1c	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@mm_admin:localhost	\N
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
8	7
10	9
11	10
12	11
13	12
14	13
15	14
16	15
17	8
18	16
19	18
20	17
21	18
22	21
23	17
24	23
25	22
26	22
27	23
28	27
29	26
30	28
31	29
32	29
33	28
34	29
35	29
36	29
37	28
38	28
39	28
\.


--
-- Data for Name: state_groups; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.state_groups (id, room_id, event_id) FROM stdin;
1	!DaecDLDoTLOuqPWadN:localhost	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg
2	!DaecDLDoTLOuqPWadN:localhost	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg
3	!DaecDLDoTLOuqPWadN:localhost	$UaZuzLfnyOIw3iLU39I6ihmpGMjzRB3mDd4pkHT22Jo
4	!DaecDLDoTLOuqPWadN:localhost	$cPQw7bnJzfkKROnFKbANhreS_L7eznZtJH4RClxd71s
5	!DaecDLDoTLOuqPWadN:localhost	$StretV_bUYoe4zZLM8qe8KW0l5M_C1Ik6aSZVQxi8rg
6	!DaecDLDoTLOuqPWadN:localhost	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY
7	!DaecDLDoTLOuqPWadN:localhost	$M1L18DSD9p1dUaGXmyktgOAaNvLS1cAXM3CfIMT15LE
8	!DaecDLDoTLOuqPWadN:localhost	$kQauQY6TyYK4PeP16G5HJI6i9oybAY_CtRu56inmyEk
9	!YmJPedFXUiFFGzTnFq:localhost	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM
10	!YmJPedFXUiFFGzTnFq:localhost	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM
11	!YmJPedFXUiFFGzTnFq:localhost	$HpReuVvJCIb4gFAA0V1ZLkXuAYpbGbYJ9xTxIowp0iA
12	!YmJPedFXUiFFGzTnFq:localhost	$DoaPAQf-ky_qYpibXlB13gxRmHsYdEJTQRCskrRSxrI
13	!YmJPedFXUiFFGzTnFq:localhost	$hGkMaf8X0yAqBrPj1PikKCF5r3g0CD5sbqK_0vYDI3s
14	!YmJPedFXUiFFGzTnFq:localhost	$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM
15	!YmJPedFXUiFFGzTnFq:localhost	$Ln0DFzhDHk3ZBOxf3CqyszFxBgR-vLuaU6XMGfFiMBY
16	!YmJPedFXUiFFGzTnFq:localhost	$aR_Ehub6nY87EKeuOUobM8EqspDDVswweVVJLsgPe9M
17	!DaecDLDoTLOuqPWadN:localhost	$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4
18	!YmJPedFXUiFFGzTnFq:localhost	$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc
19	!YmJPedFXUiFFGzTnFq:localhost	$0HbM9E_uc6yuuZ9WCxTFzSCWsJSpX5dBO62atD_SpD0
20	!DaecDLDoTLOuqPWadN:localhost	$4K3NwFFkA4uoPauq3NfR6_4NcO0bsNlPYUKFnuwb9lc
21	!YmJPedFXUiFFGzTnFq:localhost	$3iRjuPdSa2RM8LZ_hEUz2rpxW7wRYwAMtjldk4L3x2o
22	!YmJPedFXUiFFGzTnFq:localhost	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok
23	!DaecDLDoTLOuqPWadN:localhost	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E
24	!DaecDLDoTLOuqPWadN:localhost	$effmZpky4EHKTVCWVrjLRduUNe-aPjIfmFKA4aPVbVQ
25	!YmJPedFXUiFFGzTnFq:localhost	$ayPtCbSHLWgBI9Lj-ZFmLRtpO09p3CYDGStFI0a7g2c
26	!YmJPedFXUiFFGzTnFq:localhost	$CqTXYvkWmU1WEVsryzPffrK-UFPsAp9ZN7hNFMzRdcU
27	!DaecDLDoTLOuqPWadN:localhost	$M7i7kIr_313-fsK6zIJjyPUvcArWEnDYRpGwuz1z5zY
28	!DaecDLDoTLOuqPWadN:localhost	$e59i0svd92559O6Ylspucl1xefsa8dpbbZe0ZE0mUp4
29	!YmJPedFXUiFFGzTnFq:localhost	$6Lgivd2MHjS9x-3BOttMrBNfnyKpvrsbwS8TFPVdz1c
30	!DaecDLDoTLOuqPWadN:localhost	$k-hg8qVW-hbBsX-qHygdLzVa_rTIFAmslE7GIUC0Vxk
31	!YmJPedFXUiFFGzTnFq:localhost	$BWGDHEvSYK1yrRwKy0VMEeOrY3cVWmoXRFxc7zsuXDU
32	!YmJPedFXUiFFGzTnFq:localhost	$fJQzYbu212NHnbAN7fbd7PtmJpQAqFyfZfQAPMb8agg
33	!DaecDLDoTLOuqPWadN:localhost	$zcPgv4D7KNqsAXFN7Wl0qn99YmyKP0qK8uANTBNsOXM
34	!YmJPedFXUiFFGzTnFq:localhost	$-uHaNTtLnI5QIIgGB6JM1P2TABBk3NtuoBJQiTcHM6Y
35	!YmJPedFXUiFFGzTnFq:localhost	$WCJsov2hKvNvNwELcLWAdu_TzqNletOtcJY6YWrmFOE
36	!YmJPedFXUiFFGzTnFq:localhost	$rfbwnS-2LpE6IgFBEHXZEIH-ITG36Q_CAmUBxARas24
37	!DaecDLDoTLOuqPWadN:localhost	$Ji0lv1aEWc34JUdBzktCkfKEpFzeSaRvahnkmD-v3OM
38	!DaecDLDoTLOuqPWadN:localhost	$6-ar0KJkHu858vY_ddce4SzDMkt8qKmTNdCkQAVnLfI
39	!DaecDLDoTLOuqPWadN:localhost	$htmW6fojR9DeyZpJlWGAHQIK_DfbARwSbwZrTjOzMeg
\.


--
-- Data for Name: state_groups_state; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.state_groups_state (state_group, room_id, type, state_key, event_id) FROM stdin;
2	!DaecDLDoTLOuqPWadN:localhost	m.room.create		$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg
3	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@admin:localhost	$UaZuzLfnyOIw3iLU39I6ihmpGMjzRB3mDd4pkHT22Jo
4	!DaecDLDoTLOuqPWadN:localhost	m.room.power_levels		$cPQw7bnJzfkKROnFKbANhreS_L7eznZtJH4RClxd71s
5	!DaecDLDoTLOuqPWadN:localhost	m.room.canonical_alias		$StretV_bUYoe4zZLM8qe8KW0l5M_C1Ik6aSZVQxi8rg
6	!DaecDLDoTLOuqPWadN:localhost	m.room.join_rules		$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY
7	!DaecDLDoTLOuqPWadN:localhost	m.room.history_visibility		$M1L18DSD9p1dUaGXmyktgOAaNvLS1cAXM3CfIMT15LE
8	!DaecDLDoTLOuqPWadN:localhost	m.room.name		$kQauQY6TyYK4PeP16G5HJI6i9oybAY_CtRu56inmyEk
10	!YmJPedFXUiFFGzTnFq:localhost	m.room.create		$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM
11	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@admin:localhost	$HpReuVvJCIb4gFAA0V1ZLkXuAYpbGbYJ9xTxIowp0iA
12	!YmJPedFXUiFFGzTnFq:localhost	m.room.power_levels		$DoaPAQf-ky_qYpibXlB13gxRmHsYdEJTQRCskrRSxrI
13	!YmJPedFXUiFFGzTnFq:localhost	m.room.canonical_alias		$hGkMaf8X0yAqBrPj1PikKCF5r3g0CD5sbqK_0vYDI3s
14	!YmJPedFXUiFFGzTnFq:localhost	m.room.join_rules		$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM
15	!YmJPedFXUiFFGzTnFq:localhost	m.room.history_visibility		$Ln0DFzhDHk3ZBOxf3CqyszFxBgR-vLuaU6XMGfFiMBY
16	!YmJPedFXUiFFGzTnFq:localhost	m.room.name		$aR_Ehub6nY87EKeuOUobM8EqspDDVswweVVJLsgPe9M
17	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4
18	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc
19	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@mm_admin:localhost	$0HbM9E_uc6yuuZ9WCxTFzSCWsJSpX5dBO62atD_SpD0
20	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@mm_admin:localhost	$4K3NwFFkA4uoPauq3NfR6_4NcO0bsNlPYUKFnuwb9lc
21	!YmJPedFXUiFFGzTnFq:localhost	m.room.power_levels		$3iRjuPdSa2RM8LZ_hEUz2rpxW7wRYwAMtjldk4L3x2o
22	!YmJPedFXUiFFGzTnFq:localhost	m.room.power_levels		$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok
23	!DaecDLDoTLOuqPWadN:localhost	m.room.power_levels		$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E
24	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$effmZpky4EHKTVCWVrjLRduUNe-aPjIfmFKA4aPVbVQ
25	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$ayPtCbSHLWgBI9Lj-ZFmLRtpO09p3CYDGStFI0a7g2c
26	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@mm_admin:localhost	$CqTXYvkWmU1WEVsryzPffrK-UFPsAp9ZN7hNFMzRdcU
27	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@mm_admin:localhost	$M7i7kIr_313-fsK6zIJjyPUvcArWEnDYRpGwuz1z5zY
28	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@mm_admin:localhost	$e59i0svd92559O6Ylspucl1xefsa8dpbbZe0ZE0mUp4
29	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@mm_admin:localhost	$6Lgivd2MHjS9x-3BOttMrBNfnyKpvrsbwS8TFPVdz1c
30	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$k-hg8qVW-hbBsX-qHygdLzVa_rTIFAmslE7GIUC0Vxk
31	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$BWGDHEvSYK1yrRwKy0VMEeOrY3cVWmoXRFxc7zsuXDU
32	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@mm_admin:localhost	$fJQzYbu212NHnbAN7fbd7PtmJpQAqFyfZfQAPMb8agg
33	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@mm_admin:localhost	$zcPgv4D7KNqsAXFN7Wl0qn99YmyKP0qK8uANTBNsOXM
34	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@mm_admin:localhost	$-uHaNTtLnI5QIIgGB6JM1P2TABBk3NtuoBJQiTcHM6Y
35	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@mm_admin:localhost	$WCJsov2hKvNvNwELcLWAdu_TzqNletOtcJY6YWrmFOE
36	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@mm_admin:localhost	$rfbwnS-2LpE6IgFBEHXZEIH-ITG36Q_CAmUBxARas24
37	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@mm_admin:localhost	$Ji0lv1aEWc34JUdBzktCkfKEpFzeSaRvahnkmD-v3OM
38	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@mm_admin:localhost	$6-ar0KJkHu858vY_ddce4SzDMkt8qKmTNdCkQAVnLfI
39	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@mm_admin:localhost	$htmW6fojR9DeyZpJlWGAHQIK_DfbARwSbwZrTjOzMeg
\.


--
-- Data for Name: stats_incremental_position; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.stats_incremental_position (lock, stream_id) FROM stdin;
X	24
\.


--
-- Data for Name: stream_ordering_to_exterm; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.stream_ordering_to_exterm (stream_ordering, room_id, event_id) FROM stdin;
2	!DaecDLDoTLOuqPWadN:localhost	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg
3	!DaecDLDoTLOuqPWadN:localhost	$UaZuzLfnyOIw3iLU39I6ihmpGMjzRB3mDd4pkHT22Jo
7	!DaecDLDoTLOuqPWadN:localhost	$M1L18DSD9p1dUaGXmyktgOAaNvLS1cAXM3CfIMT15LE
8	!DaecDLDoTLOuqPWadN:localhost	$kQauQY6TyYK4PeP16G5HJI6i9oybAY_CtRu56inmyEk
9	!YmJPedFXUiFFGzTnFq:localhost	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM
10	!YmJPedFXUiFFGzTnFq:localhost	$HpReuVvJCIb4gFAA0V1ZLkXuAYpbGbYJ9xTxIowp0iA
14	!YmJPedFXUiFFGzTnFq:localhost	$Ln0DFzhDHk3ZBOxf3CqyszFxBgR-vLuaU6XMGfFiMBY
15	!YmJPedFXUiFFGzTnFq:localhost	$aR_Ehub6nY87EKeuOUobM8EqspDDVswweVVJLsgPe9M
16	!DaecDLDoTLOuqPWadN:localhost	$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4
17	!YmJPedFXUiFFGzTnFq:localhost	$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc
18	!YmJPedFXUiFFGzTnFq:localhost	$3iRjuPdSa2RM8LZ_hEUz2rpxW7wRYwAMtjldk4L3x2o
19	!YmJPedFXUiFFGzTnFq:localhost	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok
20	!DaecDLDoTLOuqPWadN:localhost	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E
21	!YmJPedFXUiFFGzTnFq:localhost	$CqTXYvkWmU1WEVsryzPffrK-UFPsAp9ZN7hNFMzRdcU
22	!DaecDLDoTLOuqPWadN:localhost	$M7i7kIr_313-fsK6zIJjyPUvcArWEnDYRpGwuz1z5zY
23	!DaecDLDoTLOuqPWadN:localhost	$e59i0svd92559O6Ylspucl1xefsa8dpbbZe0ZE0mUp4
24	!YmJPedFXUiFFGzTnFq:localhost	$6Lgivd2MHjS9x-3BOttMrBNfnyKpvrsbwS8TFPVdz1c
\.


--
-- Data for Name: stream_positions; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.stream_positions (stream_name, instance_name, stream_id) FROM stdin;
account_data	master	18
events	master	24
presence_stream	master	41
receipts	master	5
\.


--
-- Data for Name: threads; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.threads (room_id, thread_id, latest_event_id, topological_ordering, stream_ordering) FROM stdin;
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
gygigjEVtQMyTMFHkMbfGIOH	1675287440828	{"request_user_id":"@admin:localhost"}	{"master_key":{"user_id":"@admin:localhost","usage":["master"],"keys":{"ed25519:9Favlbyv41Oymu7psEi73Z78IgREtdjB3x7X333+GCc":"9Favlbyv41Oymu7psEi73Z78IgREtdjB3x7X333+GCc"},"signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"+AIaMRp47RqQVG8cjzPonIXJE9Lap0DgATzEldFKzZ0bBg/RvUCQWUN1yi9JadL4AjLhsioItNJorDdLK5ZtCw"}}},"self_signing_key":{"user_id":"@admin:localhost","usage":["self_signing"],"keys":{"ed25519:SKb4WrefUUeHJMqsPB41qypT5nbR4gIz7rM2zpp77QQ":"SKb4WrefUUeHJMqsPB41qypT5nbR4gIz7rM2zpp77QQ"},"signatures":{"@admin:localhost":{"ed25519:9Favlbyv41Oymu7psEi73Z78IgREtdjB3x7X333+GCc":"CPfwqSgCqjlRddGeMfp+xXef/aNL89q7MUxFiW88yqY8NMEgcqmAl5kALmo7wbiAbgeehw5qw4XkOdVSryg1Bw"}}},"user_signing_key":{"user_id":"@admin:localhost","usage":["user_signing"],"keys":{"ed25519:vmvfo59xzOjKmX7eTKaUauAKaUMTqr5oZimh0Tsm5Ww":"vmvfo59xzOjKmX7eTKaUauAKaUMTqr5oZimh0Tsm5Ww"},"signatures":{"@admin:localhost":{"ed25519:9Favlbyv41Oymu7psEi73Z78IgREtdjB3x7X333+GCc":"eN8GO27s5/Q1LH17jHzTqSM6Cz8gHIJ+OxpeTswKoaOckpG0pxP2ZPQd9eknBiBTsCPMB3RKOPjwgGUjCsBLDQ"}}}}	/_matrix/client/unstable/keys/device_signing/upload	POST	add a device signing key to your account
\.


--
-- Data for Name: ui_auth_sessions_credentials; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.ui_auth_sessions_credentials (session_id, stage_type, result) FROM stdin;
gygigjEVtQMyTMFHkMbfGIOH	m.login.password	"@admin:localhost"
\.


--
-- Data for Name: ui_auth_sessions_ips; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.ui_auth_sessions_ips (session_id, ip, user_agent) FROM stdin;
gygigjEVtQMyTMFHkMbfGIOH	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36
\.


--
-- Data for Name: user_daily_visits; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_daily_visits (user_id, device_id, "timestamp", user_agent) FROM stdin;
@admin:localhost	MCWQGRUWJV	1675209600000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36
\.


--
-- Data for Name: user_directory; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_directory (user_id, room_id, display_name, avatar_url) FROM stdin;
@admin:localhost	\N	admin	\N
\.


--
-- Data for Name: user_directory_search; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_directory_search (user_id, vector) FROM stdin;
@admin:localhost	'admin':1A,3B 'localhost':2
\.


--
-- Data for Name: user_directory_stream_pos; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_directory_stream_pos (lock, stream_id) FROM stdin;
X	24
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
admin	0	\\x7b22726f6f6d223a7b227374617465223a7b226c617a795f6c6f61645f6d656d62657273223a747275657d2c2274696d656c696e65223a7b22756e726561645f7468726561645f6e6f74696669636174696f6e73223a747275657d7d7d
\.


--
-- Data for Name: user_ips; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_ips (user_id, access_token, device_id, ip, user_agent, last_seen) FROM stdin;
@admin:localhost	syt_YWRtaW4_zzjcJlaeJfDtltVuDqsj_3MzL9R	MCWQGRUWJV	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36	1675289375046
\.


--
-- Data for Name: user_signature_stream; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_signature_stream (stream_id, from_user_id, user_ids) FROM stdin;
6	@admin:localhost	["@admin:localhost"]
\.


--
-- Data for Name: user_stats_current; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_stats_current (user_id, joined_rooms, completed_delta_stream_id) FROM stdin;
@admin:localhost	2	10
@matterbot:localhost	2	17
@mm_admin:localhost	2	24
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

COPY public.users (name, password_hash, creation_ts, admin, upgrade_ts, is_guest, appservice_id, consent_version, consent_server_notice_sent, user_type, deactivated, shadow_banned, consent_ts, approved) FROM stdin;
@matterbot:localhost		1675285580	0	\N	0	xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	\N	\N	\N	0	f	\N	t
@admin:localhost	$2b$12$etNMSBHnWul.Omuedo3FGOovtBDfj7.iP0YiR.PNhbrzCE0mo4R66	1675287345	1	\N	0	\N	\N	\N	\N	0	f	\N	t
@mm_admin:localhost		1675287996	0	\N	0	xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	\N	\N	\N	0	f	\N	t
\.


--
-- Data for Name: users_in_public_rooms; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.users_in_public_rooms (user_id, room_id) FROM stdin;
@admin:localhost	!DaecDLDoTLOuqPWadN:localhost
@admin:localhost	!YmJPedFXUiFFGzTnFq:localhost
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

SELECT pg_catalog.setval('public.account_data_sequence', 18, true);


--
-- Name: application_services_txn_id_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.application_services_txn_id_seq', 18, true);


--
-- Name: cache_invalidation_stream_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.cache_invalidation_stream_seq', 42, true);


--
-- Name: device_inbox_sequence; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.device_inbox_sequence', 1, true);


--
-- Name: event_auth_chain_id; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.event_auth_chain_id', 18, true);


--
-- Name: events_backfill_stream_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.events_backfill_stream_seq', 1, true);


--
-- Name: events_stream_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.events_stream_seq', 24, true);


--
-- Name: instance_map_instance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.instance_map_instance_id_seq', 1, false);


--
-- Name: presence_stream_sequence; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.presence_stream_sequence', 41, true);


--
-- Name: receipts_sequence; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.receipts_sequence', 5, true);


--
-- Name: state_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.state_group_id_seq', 39, true);


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
-- Name: device_lists_changes_converted_stream_position device_lists_changes_converted_stream_position_lock_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.device_lists_changes_converted_stream_position
    ADD CONSTRAINT device_lists_changes_converted_stream_position_lock_key UNIQUE (lock);


--
-- Name: device_lists_remote_pending device_lists_remote_pending_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.device_lists_remote_pending
    ADD CONSTRAINT device_lists_remote_pending_pkey PRIMARY KEY (stream_id);


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
-- Name: event_expiry event_expiry_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_expiry
    ADD CONSTRAINT event_expiry_pkey PRIMARY KEY (event_id);


--
-- Name: event_failed_pull_attempts event_failed_pull_attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_failed_pull_attempts
    ADD CONSTRAINT event_failed_pull_attempts_pkey PRIMARY KEY (room_id, event_id);


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
-- Name: event_push_summary_last_receipt_stream_id event_push_summary_last_receipt_stream_id_lock_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_push_summary_last_receipt_stream_id
    ADD CONSTRAINT event_push_summary_last_receipt_stream_id_lock_key UNIQUE (lock);


--
-- Name: event_push_summary_stream_ordering event_push_summary_stream_ordering_lock_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_push_summary_stream_ordering
    ADD CONSTRAINT event_push_summary_stream_ordering_lock_key UNIQUE (lock);


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
-- Name: login_tokens login_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.login_tokens
    ADD CONSTRAINT login_tokens_pkey PRIMARY KEY (token);


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
-- Name: partial_state_events partial_state_events_event_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.partial_state_events
    ADD CONSTRAINT partial_state_events_event_id_key UNIQUE (event_id);


--
-- Name: partial_state_rooms partial_state_rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.partial_state_rooms
    ADD CONSTRAINT partial_state_rooms_pkey PRIMARY KEY (room_id);


--
-- Name: partial_state_rooms_servers partial_state_rooms_servers_room_id_server_name_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.partial_state_rooms_servers
    ADD CONSTRAINT partial_state_rooms_servers_room_id_server_name_key UNIQUE (room_id, server_name);


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
-- Name: receipts_graph receipts_graph_uniqueness_thread; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.receipts_graph
    ADD CONSTRAINT receipts_graph_uniqueness_thread UNIQUE (room_id, receipt_type, user_id, thread_id);


--
-- Name: receipts_linearized receipts_linearized_uniqueness_thread; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.receipts_linearized
    ADD CONSTRAINT receipts_linearized_uniqueness_thread UNIQUE (room_id, receipt_type, user_id, thread_id);


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
-- Name: threads threads_uniqueness; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.threads
    ADD CONSTRAINT threads_uniqueness UNIQUE (room_id, thread_id);


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
-- Name: batch_events_room_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX batch_events_room_id ON public.batch_events USING btree (room_id);


--
-- Name: blocked_rooms_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX blocked_rooms_idx ON public.blocked_rooms USING btree (room_id);


--
-- Name: cache_invalidation_stream_by_instance_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX cache_invalidation_stream_by_instance_id ON public.cache_invalidation_stream_by_instance USING btree (stream_id);


--
-- Name: cache_invalidation_stream_by_instance_instance_index; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX cache_invalidation_stream_by_instance_instance_index ON public.cache_invalidation_stream_by_instance USING btree (instance_name, stream_id);


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
-- Name: device_auth_providers_devices; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX device_auth_providers_devices ON public.device_auth_providers USING btree (user_id, device_id);


--
-- Name: device_auth_providers_sessions; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX device_auth_providers_sessions ON public.device_auth_providers USING btree (auth_provider_id, auth_provider_session_id);


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
-- Name: device_lists_changes_in_room_by_room_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX device_lists_changes_in_room_by_room_idx ON public.device_lists_changes_in_room USING btree (room_id, stream_id);


--
-- Name: device_lists_changes_in_stream_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX device_lists_changes_in_stream_id ON public.device_lists_changes_in_room USING btree (stream_id, room_id);


--
-- Name: device_lists_changes_in_stream_id_unconverted; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX device_lists_changes_in_stream_id_unconverted ON public.device_lists_changes_in_room USING btree (stream_id) WHERE (NOT converted_to_destinations);


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
-- Name: device_lists_remote_pending_user_device_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX device_lists_remote_pending_user_device_id ON public.device_lists_remote_pending USING btree (user_id, device_id);


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
-- Name: event_edges_event_id_prev_event_id_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX event_edges_event_id_prev_event_id_idx ON public.event_edges USING btree (event_id, prev_event_id);


--
-- Name: event_expiry_expiry_ts_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_expiry_expiry_ts_idx ON public.event_expiry USING btree (expiry_ts);


--
-- Name: event_failed_pull_attempts_room_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_failed_pull_attempts_room_id ON public.event_failed_pull_attempts USING btree (room_id);


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
-- Name: event_push_actions_stream_highlight_index; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_push_actions_stream_highlight_index ON public.event_push_actions USING btree (highlight, stream_ordering) WHERE (highlight = 0);


--
-- Name: event_push_actions_stream_ordering; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_push_actions_stream_ordering ON public.event_push_actions USING btree (stream_ordering, user_id);


--
-- Name: event_push_actions_thread_id_null; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_push_actions_thread_id_null ON public.event_push_actions USING btree (thread_id) WHERE (thread_id IS NULL);


--
-- Name: event_push_actions_u_highlight; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_push_actions_u_highlight ON public.event_push_actions USING btree (user_id, stream_ordering);


--
-- Name: event_push_summary_thread_id_null; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_push_summary_thread_id_null ON public.event_push_summary USING btree (thread_id) WHERE (thread_id IS NULL);


--
-- Name: event_push_summary_unique_index2; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX event_push_summary_unique_index2 ON public.event_push_summary USING btree (user_id, room_id, thread_id);


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
-- Name: insertion_events_room_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX insertion_events_room_id ON public.insertion_events USING btree (room_id);


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
-- Name: login_tokens_auth_provider_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX login_tokens_auth_provider_idx ON public.login_tokens USING btree (auth_provider_id, auth_provider_session_id);


--
-- Name: login_tokens_expiry_time_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX login_tokens_expiry_time_idx ON public.login_tokens USING btree (expiry_ts);


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
-- Name: partial_state_events_room_id_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX partial_state_events_room_id_idx ON public.partial_state_events USING btree (room_id);


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
-- Name: receipts_graph_unique_index; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX receipts_graph_unique_index ON public.receipts_graph USING btree (room_id, receipt_type, user_id) WHERE (thread_id IS NULL);


--
-- Name: receipts_linearized_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX receipts_linearized_id ON public.receipts_linearized USING btree (stream_id);


--
-- Name: receipts_linearized_room_stream; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX receipts_linearized_room_stream ON public.receipts_linearized USING btree (room_id, stream_id);


--
-- Name: receipts_linearized_unique_index; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX receipts_linearized_unique_index ON public.receipts_linearized USING btree (room_id, receipt_type, user_id) WHERE (thread_id IS NULL);


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
-- Name: refresh_tokens_next_token_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX refresh_tokens_next_token_id ON public.refresh_tokens USING btree (next_token_id) WHERE (next_token_id IS NOT NULL);


--
-- Name: remote_media_repository_thumbn_media_origin_id_width_height_met; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX remote_media_repository_thumbn_media_origin_id_width_height_met ON public.remote_media_cache_thumbnails USING btree (media_origin, media_id, thumbnail_width, thumbnail_height, thumbnail_type, thumbnail_method);


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
-- Name: room_stats_state_room; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX room_stats_state_room ON public.room_stats_state USING btree (room_id);


--
-- Name: state_group_edges_prev_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX state_group_edges_prev_idx ON public.state_group_edges USING btree (prev_state_group);


--
-- Name: state_group_edges_unique_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX state_group_edges_unique_idx ON public.state_group_edges USING btree (state_group, prev_state_group);


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
-- Name: threads_ordering_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX threads_ordering_idx ON public.threads USING btree (room_id, topological_ordering, stream_ordering);


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
-- Name: partial_state_events check_partial_state_events; Type: TRIGGER; Schema: public; Owner: synapse
--

CREATE TRIGGER check_partial_state_events BEFORE INSERT OR UPDATE ON public.partial_state_events FOR EACH ROW EXECUTE FUNCTION public.check_partial_state_events();


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
-- Name: event_edges event_edges_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_edges
    ADD CONSTRAINT event_edges_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(event_id);


--
-- Name: event_failed_pull_attempts event_failed_pull_attempts_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_failed_pull_attempts
    ADD CONSTRAINT event_failed_pull_attempts_room_id_fkey FOREIGN KEY (room_id) REFERENCES public.rooms(room_id);


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
-- Name: partial_state_events partial_state_events_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.partial_state_events
    ADD CONSTRAINT partial_state_events_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(event_id);


--
-- Name: partial_state_events partial_state_events_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.partial_state_events
    ADD CONSTRAINT partial_state_events_room_id_fkey FOREIGN KEY (room_id) REFERENCES public.partial_state_rooms(room_id);


--
-- Name: partial_state_rooms partial_state_rooms_join_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.partial_state_rooms
    ADD CONSTRAINT partial_state_rooms_join_event_id_fkey FOREIGN KEY (join_event_id) REFERENCES public.events(event_id);


--
-- Name: partial_state_rooms partial_state_rooms_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.partial_state_rooms
    ADD CONSTRAINT partial_state_rooms_room_id_fkey FOREIGN KEY (room_id) REFERENCES public.rooms(room_id);


--
-- Name: partial_state_rooms_servers partial_state_rooms_servers_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.partial_state_rooms_servers
    ADD CONSTRAINT partial_state_rooms_servers_room_id_fkey FOREIGN KEY (room_id) REFERENCES public.partial_state_rooms(room_id);


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

